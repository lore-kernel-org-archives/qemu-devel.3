Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDBAC021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 14:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkOEl-0002qD-1Y; Tue, 18 Feb 2025 09:06:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zeff@altlinux.org>) id 1tkJT0-0002ws-8u
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 04:00:35 -0500
Received: from air.basealt.ru ([193.43.8.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zeff@altlinux.org>) id 1tkJSx-0005ME-Gq
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 04:00:33 -0500
Received: from happy.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
 (Authenticated sender: sergeevdv)
 by air.basealt.ru (Postfix) with ESMTPSA id 48904233BC;
 Tue, 18 Feb 2025 12:00:22 +0300 (MSK)
From: zeff@altlinux.org
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com,
 peter.maydell@linaro.org, sdl.qemu@linuxtesting.org,
 e.bykhanova@fobos-nt.ru, sergeevdv@basealt.ru,
 Denis Sergeev <zeff@altlinux.org>
Subject: [sdl-qemu] [PATCH] disas/sparc: Fix integer overflow in
 compare_opcodes()
Date: Tue, 18 Feb 2025 11:58:35 +0300
Message-ID: <20250218085835.64928-1-zeff@altlinux.org>
X-Mailer: git-send-email 2.42.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=193.43.8.18; envelope-from=zeff@altlinux.org;
 helo=air.basealt.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 18 Feb 2025 09:06:04 -0500
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

From: Denis Sergeev <zeff@altlinux.org>

Fix an integer overflow issue caused by a left shift operation (1 << i)
on an int literal. For i >= 31, this could lead to undefined behavior by
exceeding the 32-bit range.

To prevent this, explicitly cast the literal to an unsigned long int
(1UL << i), ensuring the shift operation is performed safely.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2618
Reported-by: E. Bykhanova <e.bykhanova@fobos-nt.ru>
Signed-off-by: Denis Sergeev <zeff@altlinux.org>
---
 disas/sparc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/disas/sparc.c b/disas/sparc.c
index 5689533ce1..92b9ac754f 100644
--- a/disas/sparc.c
+++ b/disas/sparc.c
@@ -2515,7 +2515,7 @@ compare_opcodes (const void * a, const void * b)
      another, it is important to order the opcodes in the right order.  */
   for (i = 0; i < 32; ++i)
     {
-      unsigned long int x = 1 << i;
+      unsigned long int x = 1UL << i;
       int x0 = (match0 & x) != 0;
       int x1 = (match1 & x) != 0;
 
@@ -2525,7 +2525,7 @@ compare_opcodes (const void * a, const void * b)
 
   for (i = 0; i < 32; ++i)
     {
-      unsigned long int x = 1 << i;
+      unsigned long int x = 1UL << i;
       int x0 = (lose0 & x) != 0;
       int x1 = (lose1 & x) != 0;
 
-- 
2.42.4


