Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19640C624D3
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 09:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2mqd-0004mx-AW; Sat, 05 Sep 2026 05:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1x2mqb-0004mZ-Eo; Sat, 05 Sep 2026 05:38:05 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1x2mqY-0002d5-FL; Sat, 05 Sep 2026 05:38:05 -0400
Received: from DESKTOP-7FLBREN (unknown [124.16.137.194])
 by APP-03 (Coremail) with SMTP id rQCowABHUT_u4ptqIsvvBg--.16071S5;
 Sat, 05 Sep 2026 17:37:53 +0800 (CST)
From: wangyang <wangyang25@otcaix.iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: wangyang <wangyang25@otcaix.iscas.ac.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
Subject: [PATCH 3/5] target/riscv: require read permission for HLVX accesses
Date: Sat,  5 Sep 2026 17:37:47 +0800
Message-ID: <20260905093749.491-4-wangyang25@otcaix.iscas.ac.cn>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260905093749.491-1-wangyang25@otcaix.iscas.ac.cn>
References: <20260905093749.491-1-wangyang25@otcaix.iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABHUT_u4ptqIsvvBg--.16071S5
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw4fCrWxZr13uw47Aw1xuFg_yoW7Cw43pr
 WrCrZIkw4kKFZrGayxtFyjyF15CF43GFWjg3Z7WwsY93Waq3yru3WkGa42gFs8GFWkWw1j
 ga1qyF1jk3WjqFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUmm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
 x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
 ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vY
 z4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
 02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE
 4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mx
 kF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8uwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
 s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
 1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
 JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r
 1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
 YxBIdaVFxhVjvjDU0xZFpf9x0JUStCwUUUUU=
X-Originating-IP: [124.16.137.194]
X-CM-SenderInfo: 5zdqw5xdqjjk46rwut1l0ox2xfdvhtffof0/
Received-SPF: pass client-ip=159.226.251.81;
 envelope-from=wangyang25@otcaix.iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

HLVX address translation uses execute permission, but the final PMP
check on the supervisor physical address must also require read
permission. Carry the HLVX operation through the MMU index and include
PMP_READ in the final check so execute-only pages fault.

Tested: RV32 system-mode RWX, HLV, and HLVX.WU PMP witness matrix.
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4414

Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
---
 target/riscv/internals.h      |  6 ++++++
 target/riscv/tcg/cpu_helper.c | 24 ++++++++++++++++--------
 target/riscv/tcg/op_helper.c  | 11 +++++------
 3 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 5d84e4de96..832c6406bc 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -42,6 +42,7 @@
 #define MMUIdx_M            3
 #define MMU_2STAGE_BIT      (1 << 2)
 #define MMU_IDX_SS_WRITE    (1 << 3)
+#define MMU_IDX_HLVX        (1 << 4)
 
 static inline privilege_mode_t mmuidx_priv(int mmu_idx)
 {
@@ -62,6 +63,11 @@ static inline bool mmuidx_2stage(int mmu_idx)
     return mmu_idx & MMU_2STAGE_BIT;
 }
 
+static inline bool mmuidx_hlvx(int mmu_idx)
+{
+    return mmu_idx & MMU_IDX_HLVX;
+}
+
 /*
  * Return the endianness for the current privilege
  * level, based on the MSTATUS MBE/SBE/UBE bits.
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 07d9222652..ad41de9d06 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -905,6 +905,7 @@ void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
  */
 static int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
                                     int size, MMUAccessType access_type,
+                                    pmp_priv_t extra_privs,
                                     privilege_mode_t mode)
 {
     pmp_priv_t pmp_priv;
@@ -915,7 +916,8 @@ static int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
         return TRANSLATE_SUCCESS;
     }
 
-    pmp_has_privs = pmp_hart_has_privs(env, addr, size, 1 << access_type,
+    pmp_has_privs = pmp_hart_has_privs(env, addr, size,
+                                       (1 << access_type) | extra_privs,
                                        &pmp_priv, mode);
     if (!pmp_has_privs) {
         *prot = 0;
@@ -1177,7 +1179,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         int pmp_prot;
         int pmp_ret = get_physical_address_pmp(env, &pmp_prot, pte_addr,
                                                sxlen_bytes,
-                                               MMU_DATA_LOAD, PRV_S);
+                                               MMU_DATA_LOAD, 0, PRV_S);
         if (pmp_ret != TRANSLATE_SUCCESS) {
             return TRANSLATE_PMP_FAIL;
         }
@@ -1425,7 +1427,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         }
 
         pmp_ret = get_physical_address_pmp(env, &pmp_prot, pte_addr,
-                                           sxlen_bytes, MMU_DATA_STORE, PRV_S);
+                                           sxlen_bytes, MMU_DATA_STORE, 0,
+                                           PRV_S);
         if (pmp_ret != TRANSLATE_SUCCESS) {
             return TRANSLATE_PMP_FAIL;
         }
@@ -1711,7 +1714,9 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
             if (ret == TRANSLATE_SUCCESS) {
                 ret = get_physical_address_pmp(env, &prot_pmp, pa,
-                                               size, access_type, mode);
+                                               size, access_type,
+                                               mmuidx_hlvx(mmu_idx) ?
+                                               PMP_READ : 0, mode);
                 tlb_size = pmp_get_tlb_size(env, pa);
 
                 qemu_log_mask(CPU_LOG_MMU,
@@ -1746,7 +1751,9 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
         if (ret == TRANSLATE_SUCCESS) {
             ret = get_physical_address_pmp(env, &prot_pmp, pa,
-                                           size, access_type, mode);
+                                           size, access_type,
+                                           mmuidx_hlvx(mmu_idx) ?
+                                           PMP_READ : 0, mode);
             tlb_size = pmp_get_tlb_size(env, pa);
 
             qemu_log_mask(CPU_LOG_MMU,
@@ -1786,9 +1793,10 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         cpu_check_watchpoint(cs, address, size, MEMTXATTRS_UNSPECIFIED,
                              wp_access, retaddr);
 
-        raise_mmu_exception(env, address, access_type, pmp_pma_violation,
-                            first_stage_error, two_stage_lookup,
-                            two_stage_indirect_error);
+        raise_mmu_exception(env, address,
+                            mmuidx_hlvx(mmu_idx) ? MMU_DATA_LOAD : access_type,
+                            pmp_pma_violation, first_stage_error,
+                            two_stage_lookup, two_stage_indirect_error);
         cpu_loop_exit_restore(cs, retaddr);
     }
 
diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index 3e94005d2b..060d97ee9c 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -650,7 +650,7 @@ static int check_access_hlsv(CPURISCVState *env, bool x, uintptr_t ra)
     if (!x && mode == PRV_S && get_field(env->vsstatus, MSTATUS_SUM)) {
         mode = MMUIdx_S_SUM;
     }
-    return mode | MMU_2STAGE_BIT;
+    return mode | MMU_2STAGE_BIT | (x ? MMU_IDX_HLVX : 0);
 }
 
 target_ulong helper_hyp_hlv_bu(CPURISCVState *env, target_ulong addr)
@@ -726,11 +726,10 @@ void helper_hyp_hsv_d(CPURISCVState *env, target_ulong addr, target_ulong val)
 }
 
 /*
- * TODO: These implementations are not quite correct.  They perform the
- * access using execute permission just fine, but the final PMP check
- * is supposed to have read permission as well.  Without replicating
- * a fair fraction of cputlb.c, fixing this requires adding new mmu_idx
- * which would imply that exact check in tlb_fill.
+ * HLVX accesses are translated with execute permission (first stage),
+ * but the final PMP check on the supervisor physical address must
+ * require read permission as well.  The MMU_IDX_HLVX mmu_idx bit set
+ * by check_access_hlsv() makes riscv_cpu_tlb_fill() enforce this.
  */
 target_ulong helper_hyp_hlvx_hu(CPURISCVState *env, target_ulong addr)
 {
-- 
2.55.0.windows.2


