Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8391CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSIp-0007Zk-D8; Wed, 10 Apr 2024 03:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSIh-0007R2-LL; Wed, 10 Apr 2024 03:23:20 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSIe-0003s2-SS; Wed, 10 Apr 2024 03:23:19 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9DFE85D673;
 Wed, 10 Apr 2024 10:25:02 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 41E1BB02B4;
 Wed, 10 Apr 2024 10:23:04 +0300 (MSK)
Received: (nullmailer pid 4191656 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Alexey Sheplyakov <asheplyakov@yandex.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 04/87] linux-user: Remove pgb_dynamic alignment
 assertion
Date: Wed, 10 Apr 2024 10:21:37 +0300
Message-Id: <20240410072303.4191455-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

The assertion was never correct, because the alignment is a composite
of the image alignment and SHMLBA.  Even if the image alignment didn't
match the image address, an assertion would not be correct -- more
appropriate would be an error message about an ill formed image.  But
the image cannot be held to SHMLBA under any circumstances.

Fixes: ee94743034b ("linux-user: completely re-write init_guest_space")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2157
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reported-by: Alexey Sheplyakov <asheplyakov@yandex.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit b816e1b5ba58a986b10cd830d6617f351979ab91)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index cf9e74468b..7cc8d9685e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3016,8 +3016,6 @@ static void pgb_dynamic(const char *image_name, uintptr_t guest_loaddr,
     uintptr_t brk, ret;
     PGBAddrs ga;
 
-    assert(QEMU_IS_ALIGNED(guest_loaddr, align));
-
     /* Try the identity map first. */
     if (pgb_addr_set(&ga, guest_loaddr, guest_hiaddr, true)) {
         brk = (uintptr_t)sbrk(0);
-- 
2.39.2


