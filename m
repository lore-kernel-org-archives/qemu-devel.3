Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29FDC44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkfTq-0003cl-FC; Fri, 17 Jul 2026 06:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wkfTl-0003Yh-ER; Fri, 17 Jul 2026 06:07:37 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wkfTg-0006aW-Ex; Fri, 17 Jul 2026 06:07:37 -0400
Received: from xiaoou-ubuntu-02.home.arpa (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowAB3T_Pa_llqSAw4AA--.34459S3;
 Fri, 17 Jul 2026 18:07:23 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: xiaoou@iscas.ac.cn, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Yin Zhang <zhangyin2018@iscas.ac.cn>,
 Dajun Huang <djhuang_1@std.uestc.edu.cn>,
 Zhiyuan Yang <zhiyuan.plct@isrc.iscas.ac.cn>
Subject: [PATCH v2 01/18] target/riscv: Add packed SIMD extension state
Date: Fri, 17 Jul 2026 10:06:54 +0000
Message-Id: <8b602c084875d5d5517958ffa3a25651c0bb41c1.1784280142.git.xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1784280142.git.xiaoou@iscas.ac.cn>
References: <cover.1784280142.git.xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAB3T_Pa_llqSAw4AA--.34459S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar4xtryfWrW7WF4kCryDKFg_yoWfKF1xpr
 4kG39Ik34UGa93Z3Z3tF1DWF15Ww4kG3ySkws7Ww4IqFW5JrW5GF1kt3y7ZFn8GFWkZr43
 uF48Cr1DZr4UAFDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUmY14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
 x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
 ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
 xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
 vE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
 jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
 kIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
 Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
 AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
 cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
 IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
 Ja73UjIFyTuYvjTRtyCJDUUUU
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: 50ld003x6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.21; envelope-from=xiaoou@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

Model vxsat with separate Vector/Zve and P-only control paths.  When
Zve* is present, vxsat follows mstatus.VS/vsstatus.VS; when P is
implemented without Zve*, stateen0.VXSAT controls access instead.

Record the P-only stateen result in TB flags so cached translations
preserve both instruction legality and the illegal-vs-virtual exception
class.

Co-authored-by: Yin Zhang <zhangyin2018@iscas.ac.cn>
Co-authored-by: Dajun Huang <djhuang_1@std.uestc.edu.cn>
Co-authored-by: Zhiyuan Yang <zhiyuan.plct@isrc.iscas.ac.cn>

Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
---
 target/riscv/cpu.c         |  5 ++--
 target/riscv/cpu.h         |  8 +++++++
 target/riscv/cpu_bits.h    |  2 ++
 target/riscv/machine.c     | 19 +++++++++++++++
 target/riscv/tcg/csr.c     | 39 +++++++++++++++++++++++++++++--
 target/riscv/tcg/tcg-cpu.c | 48 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 117 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5a82e6563bf..c9e6c83a491 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -46,7 +46,7 @@
 /* RISC-V CPU definitions */
 static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
 const uint32_t misa_bits[] = {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
-                              RVC, RVS, RVU, RVH, RVG, RVB, 0};
+                              RVC, RVS, RVU, RVH, RVG, RVB, RVP, 0};
 #define RISCV_CPU_MVENDORID 0
 #define RISCV_CPU_MIMPID 0
 /*
@@ -1489,7 +1489,8 @@ static const MISAExtInfo misa_ext_info_arr[] = {
     MISA_EXT_INFO(RVH, "h", "Hypervisor"),
     MISA_EXT_INFO(RVV, "v", "Vector operations"),
     MISA_EXT_INFO(RVG, "g", "General purpose (IMAFD_Zicsr_Zifencei)"),
-    MISA_EXT_INFO(RVB, "b", "Bit manipulation (Zba_Zbb_Zbs)")
+    MISA_EXT_INFO(RVB, "b", "Bit manipulation (Zba_Zbb_Zbs)"),
+    MISA_EXT_INFO(RVP, "x-p", "Packed-SIMD instructions")
 };
 
 static void riscv_cpu_validate_misa_mxl(RISCVCPUClass *mcc)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index c9dfa7daff2..75cfb16d846 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -70,6 +70,7 @@ typedef struct CPUArchState CPURISCVState;
 #define RVG RV('G')
 #define RVB RV('B')
 #define RVX RV('X')
+#define RVP RV('P')
 
 extern const uint32_t misa_bits[];
 const char *riscv_get_misa_ext_name(uint32_t bit);
@@ -742,6 +743,13 @@ FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
 FIELD(EXT_TB_FLAGS, MISA_EXT, 0, 32)
 FIELD(EXT_TB_FLAGS, ALTFMT, 32, 1)
 FIELD(EXT_TB_FLAGS, BIG_ENDIAN, 33, 1)
+FIELD(EXT_TB_FLAGS, P_VXSAT_EXCP, 34, 2)
+
+enum {
+    P_VXSAT_EXCP_NONE,
+    P_VXSAT_EXCP_ILLEGAL,
+    P_VXSAT_EXCP_VIRTUAL,
+};
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 3f146a43fe4..fa7bf60f4fc 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -355,6 +355,8 @@
 #define SMSTATEEN0_CS       (1ULL << 0)
 #define SMSTATEEN0_FCSR     (1ULL << 1)
 #define SMSTATEEN0_JVT      (1ULL << 2)
+/* Packed-SIMD draft: enable access to vxsat when misa.V = 0. */
+#define SMSTATEEN0_VXSAT    (1ULL << 3)
 #define SMSTATEEN0_CTR      (1ULL << 54)
 #define SMSTATEEN0_P1P13    (1ULL << 56)
 #define SMSTATEEN0_HSCONTXT (1ULL << 57)
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 0ab613a2980..a9cd7e4c1cc 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -158,6 +158,24 @@ static const VMStateDescription vmstate_vector = {
     }
 };
 
+static bool p_vxsat_needed(void *opaque)
+{
+    RISCVCPU *cpu = opaque;
+
+    return riscv_has_ext(&cpu->env, RVP) && !cpu->cfg.ext_zve32x;
+}
+
+static const VMStateDescription vmstate_p_vxsat = {
+    .name = "cpu/p-vxsat",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = p_vxsat_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8(env.vxsat, RISCVCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool pointermasking_needed(void *opaque)
 {
     return false;
@@ -518,6 +536,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_pmp,
         &vmstate_hyper,
         &vmstate_vector,
+        &vmstate_p_vxsat,
         &vmstate_pointermasking,
         &vmstate_rv128,
 #ifdef CONFIG_KVM
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 36f2004bc56..e809997f52e 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -109,6 +109,24 @@ static RISCVException vs(CPURISCVState *env, int csrno)
     return RISCV_EXCP_ILLEGAL_INST;
 }
 
+/* vxsat is also architectural state when P is implemented without Zve*. */
+static RISCVException vxsat(CPURISCVState *env, int csrno)
+{
+    if (riscv_cpu_cfg(env)->ext_zve32x) {
+        return vs(env, csrno);
+    }
+
+    if (riscv_has_ext(env, RVP)) {
+#if !defined(CONFIG_USER_ONLY)
+        return smstateen_acc_ok(env, 0, SMSTATEEN0_VXSAT);
+#else
+        return RISCV_EXCP_NONE;
+#endif
+    }
+
+    return RISCV_EXCP_ILLEGAL_INST;
+}
+
 static RISCVException ctr(CPURISCVState *env, int csrno)
 {
 #if !defined(CONFIG_USER_ONLY)
@@ -1013,7 +1031,12 @@ static RISCVException write_vxsat(CPURISCVState *env, int csrno,
                                   target_ulong val, uintptr_t ra)
 {
 #if !defined(CONFIG_USER_ONLY)
-    env->mstatus |= MSTATUS_VS;
+    if (riscv_cpu_cfg(env)->ext_zve32x) {
+        env->mstatus |= MSTATUS_VS;
+        if (env->virt_enabled) {
+            env->mstatus_hs |= MSTATUS_VS;
+        }
+    }
 #endif
     env->vxsat = val & BIT(0);
     return RISCV_EXCP_NONE;
@@ -3494,6 +3517,10 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
                                       target_ulong new_val, uintptr_t ra)
 {
     uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
+
+    if (riscv_has_ext(env, RVP) && !riscv_cpu_cfg(env)->ext_zve32x) {
+        wr_mask |= SMSTATEEN0_VXSAT;
+    }
     if (!riscv_has_ext(env, RVF)) {
         wr_mask |= SMSTATEEN0_FCSR;
     }
@@ -3617,6 +3644,10 @@ static RISCVException write_hstateen0(CPURISCVState *env, int csrno,
 {
     uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
 
+    if (riscv_has_ext(env, RVP) && !riscv_cpu_cfg(env)->ext_zve32x) {
+        wr_mask |= SMSTATEEN0_VXSAT;
+    }
+
     if (!riscv_has_ext(env, RVF)) {
         wr_mask |= SMSTATEEN0_FCSR;
     }
@@ -3746,6 +3777,10 @@ static RISCVException write_sstateen0(CPURISCVState *env, int csrno,
 {
     uint64_t wr_mask = 0;
 
+    if (riscv_has_ext(env, RVP) && !riscv_cpu_cfg(env)->ext_zve32x) {
+        wr_mask |= SMSTATEEN0_VXSAT;
+    }
+
     if (!riscv_has_ext(env, RVF)) {
         wr_mask |= SMSTATEEN0_FCSR;
     }
@@ -5916,7 +5951,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_FCSR]     = { "fcsr",     fs,     read_fcsr,    write_fcsr   },
     /* Vector CSRs */
     [CSR_VSTART]   = { "vstart",   vs,     read_vstart,  write_vstart },
-    [CSR_VXSAT]    = { "vxsat",    vs,     read_vxsat,   write_vxsat  },
+    [CSR_VXSAT]    = { "vxsat",    vxsat,  read_vxsat,   write_vxsat  },
     [CSR_VXRM]     = { "vxrm",     vs,     read_vxrm,    write_vxrm   },
     [CSR_VCSR]     = { "vcsr",     vs,     read_vcsr,    write_vcsr   },
     [CSR_VL]       = { "vl",       vs,     read_vl                    },
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 4af5cd9c731..1665583accf 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -160,6 +160,8 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
     fs = EXT_STATUS_DIRTY;
     vs = EXT_STATUS_DIRTY;
 #else
+    RISCVException p_vxsat_excp;
+
     flags = FIELD_DP32(flags, TB_FLAGS, PRIV, env->priv);
 
     flags |= riscv_env_mmu_index(env, 0);
@@ -182,6 +184,23 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
              ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
     }
 
+    /*
+     * Without Zve*, all P instructions in the OP-32 and OP-IMM-32
+     * spaces are controlled by stateen0.VXSAT.  Preserve the exception
+     * class in the TB flags so translated code can distinguish an illegal
+     * instruction from a virtual-instruction exception.
+     */
+    p_vxsat_excp = smstateen_acc_ok(env, 0, SMSTATEEN0_VXSAT);
+    if (riscv_has_ext(env, RVP) && !riscv_cpu_cfg(env)->ext_zve32x) {
+        if (p_vxsat_excp == RISCV_EXCP_VIRT_INSTRUCTION_FAULT) {
+            ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, P_VXSAT_EXCP,
+                                   P_VXSAT_EXCP_VIRTUAL);
+        } else if (p_vxsat_excp != RISCV_EXCP_NONE) {
+            ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, P_VXSAT_EXCP,
+                                   P_VXSAT_EXCP_ILLEGAL);
+        }
+    }
+
     if (cpu->cfg.debug && !icount_enabled()) {
         flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
     }
@@ -530,6 +549,28 @@ static void riscv_cpu_validate_b(RISCVCPU *cpu)
     }
 }
 
+static void riscv_cpu_validate_p(RISCVCPU *cpu, Error **errp)
+{
+    CPURISCVState *env = &cpu->env;
+
+    if (!riscv_has_ext(env, RVP)) {
+        return;
+    }
+
+    if (riscv_cpu_mxl(env) != MXL_RV32 &&
+        riscv_cpu_mxl(env) != MXL_RV64) {
+        error_setg(errp, "P extension requires RV32 or RV64");
+        return;
+    }
+
+    if (!(cpu->cfg.ext_zmmul && cpu->cfg.ext_zba && cpu->cfg.ext_zbb &&
+          cpu->cfg.ext_zbkb)) {
+        error_setg(errp, "P extension requires zmmul, zba, zbb and zbkb "
+                         "extensions");
+        return;
+    }
+}
+
 /*
  * Check consistency between chosen extensions while setting
  * cpu->cfg accordingly.
@@ -612,6 +653,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    riscv_cpu_validate_p(cpu, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     riscv_cpu_validate_v(env, &cpu->cfg, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
@@ -1414,6 +1461,7 @@ static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
     MISA_CFG(RVV, false),
     MISA_CFG(RVG, false),
     MISA_CFG(RVB, false),
+    MISA_CFG(RVP, false),
 };
 
 /*
-- 
2.34.1


