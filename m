Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA51BC83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 20:05:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udwkC-0005aA-71; Mon, 21 Jul 2025 16:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1udwjH-0004ri-6d; Mon, 21 Jul 2025 16:03:29 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1udwjE-0004lf-On; Mon, 21 Jul 2025 16:03:18 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2235A139046;
 Mon, 21 Jul 2025 23:02:48 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D638924BED2;
 Mon, 21 Jul 2025 23:03:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 69/70] target/arm: Correct encoding of Debug
 Communications Channel registers
Date: Mon, 21 Jul 2025 23:02:56 +0300
Message-ID: <20250721200302.133559-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250721221446@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250721221446@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

We don't implement the Debug Communications Channel (DCC), but
we do attempt to provide dummy versions of its system registers
so that software that tries to access them doesn't fall over.

However, we got the tx/rx register definitions wrong. These
should be:

AArch32:
  DBGDTRTX   p14 0 c0 c5 0  (on writes)
  DBGDTRRX   p14 0 c0 c5 0  (on reads)

AArch64:
  DBGDTRTX_EL0  2 3 0 5 0 (on writes)
  DBGDTRRX_EL0  2 3 0 5 0 (on reads)
  DBGDTR_EL0    2 3 0 4 0 (reads and writes)

where DBGDTRTX and DBGDTRRX are effectively different names for the
same 32-bit register, which has tx behaviour on writes and rx
behaviour on reads.  The AArch64-only DBGDTR_EL0 is a 64-bit wide
register whose top and bottom halves map to the DBGDTRRX and DBGDTRTX
registers.

Currently we have just one cpreg struct, which:
 * calls itself DBGDTR_EL0
 * uses the DBGDTRTX_EL0/DBGDTRRX_EL0 encoding
 * is marked as ARM_CP_STATE_BOTH but has the wrong opc1
   value for AArch32
 * is implemented as RAZ/WI

Correct the encoding so:
 * we name the DBGDTRTX/DBGDTRRX register correctly
 * we split it into AA64 and AA32 versions so we can get the
   AA32 encoding right
 * we implement DBGDTR_EL0 at its correct encoding

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2986
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250708141049.778361-1-peter.maydell@linaro.org
(cherry picked from commit 655659a74a36b63e33d2dc969d3c44beb1b008b3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index a9a619ba6b..79c0e8eaff 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -986,11 +986,20 @@ static const ARMCPRegInfo debug_cp_reginfo[] = {
       .opc0 = 2, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 2,
       .access = PL1_RW, .accessfn = access_tdcc,
       .type = ARM_CP_CONST, .resetvalue = 0 },
-    /* DBGDTRTX_EL0/DBGDTRRX_EL0 depend on direction */
-    { .name = "DBGDTR_EL0", .state = ARM_CP_STATE_BOTH, .cp = 14,
+    /* Architecturally DBGDTRTX is named DBGDTRRX when used for reads */
+    { .name = "DBGDTRTX_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 2, .opc1 = 3, .crn = 0, .crm = 5, .opc2 = 0,
       .access = PL0_RW, .accessfn = access_tdcc,
       .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "DBGDTRTX", .state = ARM_CP_STATE_AA32, .cp = 14,
+      .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 0,
+      .access = PL0_RW, .accessfn = access_tdcc,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
+    /* This is AArch64-only and is a combination of DBGDTRTX and DBGDTRRX */
+    { .name = "DBGDTR_EL0", .state = ARM_CP_STATE_AA64,
+      .opc0 = 2, .opc1 = 3, .crn = 0, .crm = 4, .opc2 = 0,
+      .access = PL0_RW, .accessfn = access_tdcc,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
     /*
      * OSECCR_EL1 provides a mechanism for an operating system
      * to access the contents of EDECCR. EDECCR is not implemented though,
-- 
2.47.2


