Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7EFE7FDCC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 19:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmzt7-0000Iy-0G; Mon, 02 Feb 2026 14:47:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vmzt0-0000Dp-QU; Mon, 02 Feb 2026 14:47:03 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vmzsz-0003Do-4d; Mon, 02 Feb 2026 14:47:02 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2278318509A;
 Mon, 02 Feb 2026 22:46:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C6A6435B27C;
 Mon, 02 Feb 2026 22:46:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jessica Clarke <jrtc27@jrtc27.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.8 08/69] target/arm: handle unaligned PC during tlb probe
Date: Mon,  2 Feb 2026 22:45:31 +0300
Message-ID: <20260202194638.939438-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.8-20260202173053@cover.tls.msk.ru>
References: <qemu-stable-10.0.8-20260202173053@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Alex Bennée <alex.bennee@linaro.org>

PC alignment faults have priority over instruction aborts and we have
code to deal with this in the translation front-ends. However during
tb_lookup we can see a potentially faulting probe which doesn't get a
MemOp set. If the page isn't available this results in
EC_INSNABORT (0x20) instead of EC_PCALIGNMENT (0x22).

As there is no easy way to set the appropriate MemOp in the
instruction fetch probe path lets just detect it in
arm_cpu_tlb_fill_align() ahead of the main alignment check. We also
teach arm_deliver_fault to deliver the right syndrome for
MMU_INST_FETCH alignment issues.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3233
Tested-by: Jessica Clarke <jrtc27@jrtc27.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251209092459.1058313-5-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
(cherry picked from commit dd77ef99aa0280c467fe8442b4238122899ae6cf)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 8841f039bc..912b98f272 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -243,7 +243,11 @@ void arm_deliver_fault(ARMCPU *cpu, vaddr addr,
     fsr = compute_fsr_fsc(env, fi, target_el, mmu_idx, &fsc);
 
     if (access_type == MMU_INST_FETCH) {
-        syn = syn_insn_abort(same_el, fi->ea, fi->s1ptw, fsc);
+        if (fi->type == ARMFault_Alignment) {
+            syn = syn_pcalignment();
+        } else {
+            syn = syn_insn_abort(same_el, fi->ea, fi->s1ptw, fsc);
+        }
         exc = EXCP_PREFETCH_ABORT;
     } else {
         syn = merge_syn_data_abort(env->exception.syndrome, fi, target_el,
@@ -338,11 +342,18 @@ bool arm_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr address,
     }
 
     /*
-     * Per R_XCHFJ, alignment fault not due to memory type has
-     * highest precedence.  Otherwise, walk the page table and
-     * and collect the page description.
+     * PC alignment faults should be dealt with at translation time
+     * but we also need to catch them while being probed.
+     *
+     * Then per R_XCHFJ, alignment fault not due to memory type take
+     * precedence. Otherwise, walk the page table and and collect the
+     * page description.
+     *
      */
-    if (address & ((1 << memop_alignment_bits(memop)) - 1)) {
+    if (access_type == MMU_INST_FETCH && !cpu->env.thumb &&
+        (address & 3)) {
+        fi->type = ARMFault_Alignment;
+    } else if (address & ((1 << memop_alignment_bits(memop)) - 1)) {
         fi->type = ARMFault_Alignment;
     } else if (!get_phys_addr(&cpu->env, address, access_type, memop,
                               core_to_arm_mmu_idx(&cpu->env, mmu_idx),
-- 
2.47.3


