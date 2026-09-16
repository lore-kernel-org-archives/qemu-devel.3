Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119D0C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6jkb-0005dI-6X; Wed, 16 Sep 2026 03:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1x6jkX-0005bk-Mb; Wed, 16 Sep 2026 03:08:09 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1x6jkT-0008J2-RH; Wed, 16 Sep 2026 03:08:09 -0400
Received: from xiaoou-ubuntu-02.home.arpa (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowACXaOxHQKpq3zYkCA--.4143S3;
 Wed, 16 Sep 2026 15:08:00 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: nutty.liu@hotmail.com, max.chou@sifive.com, xiaoou@iscas.ac.cn,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Yin Zhang <zhangyin2018@iscas.ac.cn>,
 Dajun Huang <djhuang_1@std.uestc.edu.cn>,
 Zhiyuan Yang <zhiyuan.plct@isrc.iscas.ac.cn>
Subject: [PATCH v3 01/19] target/riscv: Add packed SIMD extension state
Date: Wed, 16 Sep 2026 07:07:03 +0000
Message-Id: <20260916070721.3279229-2-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
References: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACXaOxHQKpq3zYkCA--.4143S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar4xtryfWry8Jw1DAFW3GFg_yoWDGry7pr
 4DG39xG3y8Jas7Za93tF1UWF15Ww4kG3ySkws7Ww4IqFW5JrW5GFn7t3y7ZFn8GFZ5Zr43
 uF48CryDZr4UAFDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUQj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
 x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
 A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
 w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
 C2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC
 6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI
 8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC2
 0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
 0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
 14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
 vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pR0oG9UUUUU=
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: 50ld003x6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.21; envelope-from=xiaoou@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.74,
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
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
---
 target/riscv/cpu.c         |  5 ++--
 target/riscv/cpu.h         |  8 +++++++
 target/riscv/cpu_bits.h    |  2 ++
 target/riscv/machine.c     | 19 +++++++++++++++
 target/riscv/tcg/csr.c     | 39 +++++++++++++++++++++++++++++--
 target/riscv/tcg/tcg-cpu.c | 48 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 117 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 652311ddef2..ea771ac9167 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -47,7 +47,7 @@
 /* RISC-V CPU definitions */
 static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
 const uint32_t misa_bits[] = {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
-                              RVC, RVS, RVU, RVH, RVG, RVB, 0};
+                              RVC, RVS, RVU, RVH, RVG, RVB, RVP, 0};
 #define RISCV_CPU_MVENDORID 0
 #define RISCV_CPU_MIMPID 0
 /*
@@ -1579,7 +1579,8 @@ static const MISAExtInfo misa_ext_info_arr[] = {
     MISA_EXT_INFO(RVH, "h", "Hypervisor"),
     MISA_EXT_INFO(RVV, "v", "Vector operations"),
     MISA_EXT_INFO(RVG, "g", "General purpose (IMAFD_Zicsr_Zifencei)"),
-    MISA_EXT_INFO(RVB, "b", "Bit manipulation (Zba_Zbb_Zbs)")
+    MISA_EXT_INFO(RVB, "b", "Bit manipulation (Zba_Zbb_Zbs)"),
+    MISA_EXT_INFO(RVP, "x-p", "Packed-SIMD instructions")
 };
 
 static void riscv_cpu_validate_misa_mxl(RISCVCPUClass *mcc)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index c2138dbd4ba..23235b4cefb 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -70,6 +70,7 @@ typedef struct CPUArchState CPURISCVState;
 #define RVG RV('G')
 #define RVB RV('B')
 #define RVX RV('X')
+#define RVP RV('P')
 
 extern const uint32_t misa_bits[];
 const char *riscv_get_misa_ext_name(uint32_t bit);
@@ -748,6 +749,13 @@ FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
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
index c01050ce2b6..22774a3ec36 100644
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
index bf203bffcef..9d01236dd5d 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -160,6 +160,24 @@ static const VMStateDescription vmstate_vector = {
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
@@ -561,6 +579,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_pmp,
         &vmstate_hyper,
         &vmstate_vector,
+        &vmstate_p_vxsat,
         &vmstate_pointermasking,
         &vmstate_rv128,
 #ifdef CONFIG_KVM
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index bd4b6dc114b..eefb487ca21 100644
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
@@ -3512,6 +3535,10 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
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
@@ -3635,6 +3662,10 @@ static RISCVException write_hstateen0(CPURISCVState *env, int csrno,
 {
     uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
 
+    if (riscv_has_ext(env, RVP) && !riscv_cpu_cfg(env)->ext_zve32x) {
+        wr_mask |= SMSTATEEN0_VXSAT;
+    }
+
     if (!riscv_has_ext(env, RVF)) {
         wr_mask |= SMSTATEEN0_FCSR;
     }
@@ -3764,6 +3795,10 @@ static RISCVException write_sstateen0(CPURISCVState *env, int csrno,
 {
     uint64_t wr_mask = 0;
 
+    if (riscv_has_ext(env, RVP) && !riscv_cpu_cfg(env)->ext_zve32x) {
+        wr_mask |= SMSTATEEN0_VXSAT;
+    }
+
     if (!riscv_has_ext(env, RVF)) {
         wr_mask |= SMSTATEEN0_FCSR;
     }
@@ -5934,7 +5969,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_FCSR]     = { "fcsr",     fs,     read_fcsr,    write_fcsr   },
     /* Vector CSRs */
     [CSR_VSTART]   = { "vstart",   vs,     read_vstart,  write_vstart },
-    [CSR_VXSAT]    = { "vxsat",    vs,     read_vxsat,   write_vxsat  },
+    [CSR_VXSAT]    = { "vxsat",    vxsat,  read_vxsat,   write_vxsat  },
     [CSR_VXRM]     = { "vxrm",     vs,     read_vxrm,    write_vxrm   },
     [CSR_VCSR]     = { "vcsr",     vs,     read_vcsr,    write_vcsr   },
     [CSR_VL]       = { "vl",       vs,     read_vl                    },
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index b68160af830..3e72e2ffd7f 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -158,6 +158,8 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
     fs = EXT_STATUS_DIRTY;
     vs = EXT_STATUS_DIRTY;
 #else
+    RISCVException p_vxsat_excp;
+
     flags = FIELD_DP32(flags, TB_FLAGS, PRIV, env->priv);
 
     flags |= riscv_env_mmu_index(env, 0);
@@ -180,6 +182,23 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
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
     if ((cpu->cfg.debug || cpu->cfg.ext_sdtrig)
         && !icount_enabled()) {
         flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
@@ -529,6 +548,28 @@ static void riscv_cpu_validate_b(RISCVCPU *cpu)
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
@@ -611,6 +652,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
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
@@ -1413,6 +1460,7 @@ static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
     MISA_CFG(RVV, false),
     MISA_CFG(RVG, false),
     MISA_CFG(RVB, false),
+    MISA_CFG(RVP, false),
 };
 
 /*
-- 
2.34.1


