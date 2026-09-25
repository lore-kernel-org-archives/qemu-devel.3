Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAAAC9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 09:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA2Oa-0000PU-GE; Fri, 25 Sep 2026 05:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xA2OS-0000OU-3W
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 05:39:00 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xA2OQ-0006EQ-Nv
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 05:38:59 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CD7EA6022E;
 Fri, 25 Sep 2026 09:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069A41F000FF;
 Fri, 25 Sep 2026 09:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790329137;
 bh=k9qQwd9rCS4KUyCxgy57OiSEAHkiyEnMiP8vN0BIMD0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=byUynqKMH7sq9hXUUFVzi5PbjCf1V59e15v5DggOxVAetSEmnyiYv/FkTL6xpMiS4
 hrXQsPdZ/6+a/BskftGJGiufs3m5H5DWXQ9j6tD6GGbkB0oyAUiuuIowUgx+xC3Qo8
 kA01Inf+gTWjVhM+ElEZonHkpyHKf6Wwo2UJulxZVYDqTIDHMwK/I7dpHvZcgZuIsO
 YiBwtdDfBfHdJ/G/3aE4SZqsTu55SZ4b5DdR3xvFSSiTY38+FYFzUI6BwUoHUdcLBd
 q/+YKaaPjYnoiAXqaxW3LDi6uz6Kh5TB8aNklEAz+tx+r12vGVirs8kDM4OfM6BuQQ
 usVa+zc5Hhh4g==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 5/8] linux-user: report EINVAL for a misaligned mincore() start
Date: Fri, 25 Sep 2026 11:38:41 +0200
Message-ID: <20260925093844.5685-6-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925093844.5685-1-deller@kernel.org>
References: <20260925093844.5685-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Igor Shevlyakov <igor@tachyum.com>

mincore(2) rejects a misaligned start address before it looks the range
up, so a start that is both misaligned and unmapped is EINVAL.  Here
lock_user() runs first and fails, and the call reports ENOMEM instead.

When the range is mapped this changes nothing -- the host syscall
receives the misaligned pointer and answers EINVAL by itself -- which is
why only the unmapped case is visibly wrong.

Caught by glibc's misc/test-errno-linux.

Signed-off-by: Igor Shevlyakov <igor@tachyum.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/syscall.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e7c9fb33a3..0380691a8b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -13064,7 +13064,17 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_mincore
     case TARGET_NR_mincore:
         {
-            void *a = lock_user(VERIFY_NONE, arg1, arg2, 0);
+            void *a;
+
+            /*
+             * The kernel rejects a misaligned start before it looks the range
+             * up, so a start that is both misaligned and unmapped is EINVAL,
+             * not the ENOMEM that a failing lock_user() would report.
+             */
+            if (arg1 & ~TARGET_PAGE_MASK) {
+                return -TARGET_EINVAL;
+            }
+            a = lock_user(VERIFY_NONE, arg1, arg2, 0);
             if (!a) {
                 return -TARGET_ENOMEM;
             }
-- 
2.54.0


