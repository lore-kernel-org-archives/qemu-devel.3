Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436ABCDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNsH-000189-Jv; Wed, 24 Jun 2026 09:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNre-0000ZY-LD; Wed, 24 Jun 2026 09:42:04 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNrc-0001vF-Gm; Wed, 24 Jun 2026 09:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782308001; bh=xyeWbwDuQ+aowg9DTN9j7L2dMVeci73X2nXvAfRyHbI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=v309/pJwDcMAeqdbq0xt4nQeCv8MtPX9+TQ8lo1vS+3IFH1kfjo+UvRnWdYpwZ1Hw
 NTW9eR1EpUM1DHhryNOca4MkkAvTr/03sMhq8gj7OTIq1jbEwZI8hU//WS29dUpNbR
 dRaVKFabwJZ/l+JrmNyGILo1KmaUT/vzDoRqC45QLwE6a0CvZLYAVcdha9aZT7A+x4
 +DjphKGhiKCrnrJqDgZY7PCOufRXJDnPQDtUoLhFA9CsEUGq1Ozp8SYWh5DlceZ+g4
 JlkAohkGcvzPoNqDCo8YrT0aRQ/a5Hzvfhe9LGSMXwbGbIISXA6wQY32NOxZPM1/g6
 llcNQG1vwPb/Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7F46B1BAA0C;
 Wed, 24 Jun 2026 16:33:21 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1AD303DEA5B;
 Wed, 24 Jun 2026 16:33:27 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 090/107] target/riscv/cpu_helper.c: add PMA access
 fault
Date: Wed, 24 Jun 2026 16:31:35 +0300
Message-ID: <20260624133301.403266-90-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

We're not doing anything special w.r.t PMA (Physical Memory Access)
related faults, handling them like regular faults that will eventually
turn to be regular page faults.

Turns out we can't do that.  Priv spec section "Virtual Address
Translation Process" mentions:

"If a store to the PTE at address a+va.vpn[i]×PTESIZE would violate a
PMA or PMP check, raise an access-fault exception corresponding to the
original access type."

This means that we should handle PMA violations with access faults, like
we're already doing with PMP.  One clear code path where we should throw
a PMA failure, exposed by [1], is the error return from
address_space_ld* call.

There's a separated issue with the error code being returned by them (it
always return DECODE_ERROR even with 'rejected' reads) that we're going
to work around it by assuming that we did a good job with the PTE
address sanitization beforehand, and interpret that the error here is
related to PMA.  This is of course not ideal but fixing this QEMU API is
out of scope for this work.

All this said, we'll set the new pmp_pma_violation flag when we have
either a PMP or a PMA fault, and everything else shall fall into place.

[1] https://gitlab.com/qemu-project/qemu/-/work_items/3502

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3502
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Message-ID: <20260522172502.320529-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 8e090ecfa9e5d9c225a9f6aae1e39586c182afa7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a6adf6efc6..8a77682627 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -131,7 +131,8 @@ enum {
     TRANSLATE_SUCCESS,
     TRANSLATE_FAIL,
     TRANSLATE_PMP_FAIL,
-    TRANSLATE_G_STAGE_FAIL
+    TRANSLATE_G_STAGE_FAIL,
+    TRANSLATE_PMA_FAIL,
 };
 
 /* Extension context status */
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index d64c4d2e80..665d0f7181 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1374,7 +1374,22 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         }
 
         if (res != MEMTX_OK) {
-            return TRANSLATE_FAIL;
+            /*
+             * The result of address_space_* APIs above does not take into
+             * consideration reject reads, putting all errors in the same
+             * cathegory (DECODE_ERROR), although there's a clear
+             * distinction between a rejected read versus other errors
+             * (see memory_region_dispatch_read() ->
+             * memory_region_access_valid()).  This is something that
+             * we might have to deal with core QEMU logic some other
+             * day.
+             *
+             * For this particular error path, given that we made checks
+             * w.r.t legal PTE address before calling those APIs, we'll
+             * assume that anything != MEMTX_OK means a rejected read,
+             * i.e. a PMA error.
+             */
+            return TRANSLATE_PMA_FAIL;
         }
 
         if (riscv_cpu_sxl(env) == MXL_RV32) {
@@ -1654,7 +1669,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
 }
 
 static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
-                                MMUAccessType access_type, bool pmp_violation,
+                                MMUAccessType access_type,
+                                bool pmp_pma_violation,
                                 bool first_stage, bool two_stage,
                                 bool two_stage_indirect)
 {
@@ -1662,7 +1678,7 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
 
     switch (access_type) {
     case MMU_INST_FETCH:
-        if (pmp_violation) {
+        if (pmp_pma_violation) {
             cs->exception_index = RISCV_EXCP_INST_ACCESS_FAULT;
         } else if (env->virt_enabled && !first_stage) {
             cs->exception_index = RISCV_EXCP_INST_GUEST_PAGE_FAULT;
@@ -1671,7 +1687,7 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
         }
         break;
     case MMU_DATA_LOAD:
-        if (pmp_violation) {
+        if (pmp_pma_violation) {
             cs->exception_index = RISCV_EXCP_LOAD_ACCESS_FAULT;
         } else if (two_stage && !first_stage) {
             cs->exception_index = RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT;
@@ -1680,7 +1696,7 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
         }
         break;
     case MMU_DATA_STORE:
-        if (pmp_violation) {
+        if (pmp_pma_violation) {
             cs->exception_index = RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
         } else if (two_stage && !first_stage) {
             cs->exception_index = RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT;
@@ -1806,7 +1822,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     vaddr im_address;
     hwaddr pa = 0;
     int prot, prot2, prot_pmp;
-    bool pmp_violation = false;
+    bool pmp_pma_violation = false;
     bool first_stage_error = true;
     bool two_stage_lookup = mmuidx_2stage(mmu_idx);
     bool two_stage_indirect_error = false;
@@ -1907,8 +1923,8 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         }
     }
 
-    if (ret == TRANSLATE_PMP_FAIL) {
-        pmp_violation = true;
+    if (ret == TRANSLATE_PMP_FAIL || ret == TRANSLATE_PMA_FAIL) {
+        pmp_pma_violation = true;
     }
 
     if (ret == TRANSLATE_SUCCESS) {
@@ -1935,7 +1951,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         cpu_check_watchpoint(cs, address, size, MEMTXATTRS_UNSPECIFIED,
                              wp_access, retaddr);
 
-        raise_mmu_exception(env, address, access_type, pmp_violation,
+        raise_mmu_exception(env, address, access_type, pmp_pma_violation,
                             first_stage_error, two_stage_lookup,
                             two_stage_indirect_error);
         cpu_loop_exit_restore(cs, retaddr);
-- 
2.47.3


