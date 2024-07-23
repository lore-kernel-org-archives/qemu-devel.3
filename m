Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C367DC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWCPf-0001NT-Js; Tue, 23 Jul 2024 06:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uwu@dram.page>) id 1sWCPe-0001Lt-LY
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:06:30 -0400
Received: from kuriko.dram.page ([65.108.252.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uwu@dram.page>) id 1sWCPZ-0007Jd-F2
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:06:28 -0400
From: Vivian Wang <uwu@dram.page>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dram.page; s=mail;
 t=1721729182; bh=qMID2xczG5B6sBH1FwIwhYTdVvpjThT0Ch5GCuMOoA4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lvcrS51rhDwPrWiN0zx4MbeGIlBZVqVBM3OpORa6JzPeZzc0BsESED3mY+R4YOyf+
 Ua/ek9bmWrxvo+gCBT2YKAmH1mFDK+87gR1tMtjB41dppwkGSxMF1U+HQDAw2JFHkh
 e9tZ3byfKQrJ2jdImOGCFt1+fg1MQDa0+KtxDh14=
To: qemu-devel@nongnu.org
Cc: Vivian Wang <uwu@dram.page>, Richard Henderson <rth@twiddle.net>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 2/2] linux-user/main: Check errno when getting AT_EXECFD
Date: Tue, 23 Jul 2024 18:05:45 +0800
Message-ID: <20240723100545.405476-3-uwu@dram.page>
In-Reply-To: <20240723100545.405476-1-uwu@dram.page>
References: <20240723100545.405476-1-uwu@dram.page>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=65.108.252.55; envelope-from=uwu@dram.page;
 helo=kuriko.dram.page
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

It's possible for AT_EXECFD to end up with a valid value of 0. Check
errno when using qemu_getauxval instead of return value to handle this
case.

Not handling this case leads to a confusing condition where the
executable ends up as fd 0, i.e. stdin.

Signed-off-by: Vivian Wang <uwu@dram.page>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Fixes: 0b959cf5e4cc ("linux-user: Use qemu_getauxval for AT_EXECFD")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2448
---
 linux-user/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 7d3cf45fa9..8143a0d4b0 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -755,8 +755,9 @@ int main(int argc, char **argv, char **envp)
     /*
      * Manage binfmt-misc open-binary flag
      */
+    errno = 0;
     execfd = qemu_getauxval(AT_EXECFD);
-    if (execfd == 0) {
+    if (errno != 0) {
         execfd = open(exec_path, O_RDONLY);
         if (execfd < 0) {
             printf("Error while loading %s: %s\n", exec_path, strerror(errno));
-- 
2.45.1


