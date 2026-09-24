Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E705BC98321
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 19:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9pAj-00010t-1c; Thu, 24 Sep 2026 15:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mmorrell@tachyum.com>)
 id 1x9pAh-00010k-9e
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 15:31:55 -0400
Received: from mxa.tachyum.com ([66.160.133.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mmorrell@tachyum.com>)
 id 1x9pAf-0006m4-Ou
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 15:31:55 -0400
Received: from mxa.tachyum.com (localhost.localdomain [127.0.0.1])
 by mxa.tachyum.com (Proxmox) with ESMTP id 2D5D61E267D;
 Thu, 24 Sep 2026 12:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tachyum.com; h=
 cc:cc:content-transfer-encoding:date:from:from:message-id
 :mime-version:reply-to:subject:subject:to:to; s=dkim; bh=1Nt/0Fl
 jGm5mDWhohruSEr958TFWudjl79VZnSSYC2Q=; b=dcNy3kJFS0lvrwl7O/zUmtk
 woaexS5UXsJSsk3TuvS/z4yK0ybSoDOZdILr3/YYX7q5Dm2HcTiwg7GSJBp7j+fa
 tmgVKE/M3iyzVYMBULW7T7dn8GJ1yOve3bR3yMkbjvOPr2CV5MfCVyWVg00WrTHR
 6aZjFKi/4ZQy8HDhg42qMpMo4G6X3uCgm2tuTHgQTxVy4z685qelhXPftSebvc/x
 u85BtIKJR4vItflvwss4BNFEoFoFUMv5lVt2hpmy/QO2yzGqkLQh9V9KedSQpzzY
 24CpJtbw3zxYNaY2TFqfumgPQG6tmwFsd1jedwk8rH0XcSET8vGXivTp7edS2jw=
 =
From: Michael Morrell <mmorrell@tachyum.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Igor Shevlyakov <igor@tachyum.com>
Subject: [PATCH] linux-user: report EINVAL for a misaligned mincore() start
Date: Thu, 24 Sep 2026 12:31:43 -0700
Message-ID: <20260924193143.2062533-1-mmorrell@tachyum.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.160.133.173; envelope-from=mmorrell@tachyum.com;
 helo=mxa.tachyum.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 linux-user/syscall.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9f454502cb..a878feedf2 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -13051,7 +13051,17 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
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
2.43.0



