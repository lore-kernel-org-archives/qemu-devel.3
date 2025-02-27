Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C953C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 16:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tngvm-0007xD-IZ; Thu, 27 Feb 2025 11:40:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tngvF-0007gH-0Z; Thu, 27 Feb 2025 11:39:42 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tnguz-0006HP-Ei; Thu, 27 Feb 2025 11:39:40 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 652324E6180;
 Thu, 27 Feb 2025 17:39:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id JNzQWidwlWNU; Thu, 27 Feb 2025 17:39:15 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 22F1D4E6032; Thu, 27 Feb 2025 17:39:15 +0100 (CET)
Message-Id: <446bf740cbb99422be2cc5a31e51a1034eddded7.1740673173.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1740673173.git.balaton@eik.bme.hu>
References: <cover.1740673173.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 1/5] ppc/amigaone: Simplify replacement dummy_fw
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 27 Feb 2025 17:39:15 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

There's no need to do shift in a loop, doing it in one instruction
works just as well, only the result is used.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/amigaone.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index b02792221c..4290d58613 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -41,10 +41,7 @@
 
 /* AmigaOS calls this routine from ROM, use this if no firmware loaded */
 static const char dummy_fw[] = {
-    0x38, 0x00, 0x00, 0x08, /* li      r0,8 */
-    0x7c, 0x09, 0x03, 0xa6, /* mtctr   r0 */
-    0x54, 0x63, 0xf8, 0x7e, /* srwi    r3,r3,1 */
-    0x42, 0x00, 0xff, 0xfc, /* bdnz    0x8 */
+    0x54, 0x63, 0xc2, 0x3e, /* srwi    r3,r3,8 */
     0x7c, 0x63, 0x18, 0xf8, /* not     r3,r3 */
     0x4e, 0x80, 0x00, 0x20, /* blr */
 };
-- 
2.30.9


