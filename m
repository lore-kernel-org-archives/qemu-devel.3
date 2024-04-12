Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B1CC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 08:09:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvByF-00074b-Kl; Fri, 12 Apr 2024 04:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvByD-00074L-2l; Fri, 12 Apr 2024 04:09:13 -0400
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvBy6-0005Fr-Dp; Fri, 12 Apr 2024 04:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712909334; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=mn0p1OLAEnQ7KKDa+jWz4TOoWUuC4CYzS6oguLEqCkY=;
 b=nyNjSBklUv3N9/gM9q0hkQH3BP7HECBuqDq7waX5Y6uQd9OhtYI/BSefLiNSM7K2yZvIxCdRnlZY0swxAeflmRpOPkDg90h3f0V5JiJqerj/LZVPNT/wcKNN/cXi/aR+v4MsCqdUMulLBne4kFWS0Ap3MmlnC2EeyZadrel8cQo=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4Nbm6z_1712909332; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4Nbm6z_1712909332) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 16:08:53 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 15/65] target/riscv: Add vector amo operations for XTheadVector
Date: Fri, 12 Apr 2024 15:36:45 +0800
Message-ID: <20240412073735.76413-16-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.98;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-98.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

In this patch, we add the vector amo instructions(Zvamo) for XTheadVector.
Zvamo is unsupported by RVV1.0.
The action of Zvamo is similar to Zaamo(atomic operations from the standard
A extension).

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         |  28 ++++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 155 ++++++++++++++++--
 target/riscv/xtheadvector_helper.c            | 136 +++++++++++++++
 3 files changed, 301 insertions(+), 18 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 1bf4c38c4b..c2a26acabc 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1444,3 +1444,31 @@ DEF_HELPER_5(th_vlhuff_v_w, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(th_vlhuff_v_d, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(th_vlwuff_v_w, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(th_vlwuff_v_d, void, ptr, ptr, tl, env, i32)
+
+DEF_HELPER_6(th_vamoswapw_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vamoswapd_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vamoaddw_v_d,  void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vamoaddd_v_d,  void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vamoxorw_v_d,  void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vamoxord_v_d,  void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vamoandw_v_d,  void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vamoandd_v_d,  void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vamoorw_v_d,   void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vamoord_v_d,   void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vamominw_v_d,  void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vamomind_v_d,  void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vamomaxw_v_d,  void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vamomaxd_v_d,  void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vamominuw_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vamominud_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vamomaxuw_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vamomaxud_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vamoswapw_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vamoaddw_v_w,  void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vamoxorw_v_w,  void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vamoandw_v_w,  void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vamoorw_v_w,   void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vamominw_v_w,  void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vamomaxw_v_w,  void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vamominuw_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vamomaxuw_v_w, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 3548a6c2cc..2bcd9b0832 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -632,30 +632,149 @@ GEN_TH_TRANS(th_vlbuff_v, 4, r2nfvm, ldff_op_th, ld_us_check_th)
 GEN_TH_TRANS(th_vlhuff_v, 5, r2nfvm, ldff_op_th, ld_us_check_th)
 GEN_TH_TRANS(th_vlwuff_v, 6, r2nfvm, ldff_op_th, ld_us_check_th)
 
+
+/*
+ * vector atomic operation
+ */
+typedef void gen_helper_amo(TCGv_ptr, TCGv_ptr, TCGv, TCGv_ptr,
+                            TCGv_env, TCGv_i32);
+static bool amo_trans_th(uint32_t vd, uint32_t rs1, uint32_t vs2,
+                         uint32_t data, gen_helper_amo *fn, DisasContext *s)
+{
+    TCGv_ptr dest, mask, index;
+    TCGv base;
+    TCGv_i32 desc;
+
+    dest = tcg_temp_new_ptr();
+    mask = tcg_temp_new_ptr();
+    index = tcg_temp_new_ptr();
+    base = get_gpr(s, rs1, EXT_NONE);
+    desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
+                                      s->cfg_ptr->vlenb, data));
+
+    tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
+    tcg_gen_addi_ptr(index, tcg_env, vreg_ofs(s, vs2));
+    tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
+
+    mark_vs_dirty(s);
+
+    fn(dest, mask, base, index, tcg_env, desc);
+
+    finalize_rvv_inst(s);
+    return true;
+}
+
+static bool amo_op_th(DisasContext *s, arg_rwdvm *a, uint8_t seq)
+{
+    uint32_t data = 0;
+    gen_helper_amo *fn;
+    static gen_helper_amo *const fnsw[9] = {
+        /* no atomic operation */
+        gen_helper_th_vamoswapw_v_w,
+        gen_helper_th_vamoaddw_v_w,
+        gen_helper_th_vamoxorw_v_w,
+        gen_helper_th_vamoandw_v_w,
+        gen_helper_th_vamoorw_v_w,
+        gen_helper_th_vamominw_v_w,
+        gen_helper_th_vamomaxw_v_w,
+        gen_helper_th_vamominuw_v_w,
+        gen_helper_th_vamomaxuw_v_w
+    };
+    static gen_helper_amo *const fnsd[18] = {
+        gen_helper_th_vamoswapw_v_d,
+        gen_helper_th_vamoaddw_v_d,
+        gen_helper_th_vamoxorw_v_d,
+        gen_helper_th_vamoandw_v_d,
+        gen_helper_th_vamoorw_v_d,
+        gen_helper_th_vamominw_v_d,
+        gen_helper_th_vamomaxw_v_d,
+        gen_helper_th_vamominuw_v_d,
+        gen_helper_th_vamomaxuw_v_d,
+        gen_helper_th_vamoswapd_v_d,
+        gen_helper_th_vamoaddd_v_d,
+        gen_helper_th_vamoxord_v_d,
+        gen_helper_th_vamoandd_v_d,
+        gen_helper_th_vamoord_v_d,
+        gen_helper_th_vamomind_v_d,
+        gen_helper_th_vamomaxd_v_d,
+        gen_helper_th_vamominud_v_d,
+        gen_helper_th_vamomaxud_v_d
+    };
+
+    if (tb_cflags(s->base.tb) & CF_PARALLEL) {
+        gen_helper_exit_atomic(tcg_env);
+        s->base.is_jmp = DISAS_NORETURN;
+        return true;
+    }
+    switch (s->sew) {
+    case 0 ... 2:
+        assert(seq < ARRAY_SIZE(fnsw));
+        fn = fnsw[seq];
+        break;
+    case 3:
+        /* XLEN check done in amo_check(). */
+        assert(seq < ARRAY_SIZE(fnsd));
+        fn = fnsd[seq];
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    data = FIELD_DP32(data, VDATA_TH, MLEN, s->mlen);
+    data = FIELD_DP32(data, VDATA_TH, VM, a->vm);
+    data = FIELD_DP32(data, VDATA_TH, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA_TH, WD, a->wd);
+    return amo_trans_th(a->rd, a->rs1, a->rs2, data, fn, s);
+}
+/*
+ * There are two rules check here.
+ *
+ * 1. SEW must be at least as wide as the AMO memory element size.
+ *
+ * 2. If SEW is greater than XLEN, an illegal instruction exception is raised.
+ */
+static bool amo_check_th(DisasContext *s, arg_rwdvm* a)
+{
+    return (require_xtheadvector(s) &&
+            !s->vill && has_ext(s, RVA) &&
+            (!a->wd || th_check_overlap_mask(s, a->rd, a->vm, false)) &&
+            th_check_reg(s, a->rd, false) &&
+            th_check_reg(s, a->rs2, false) &&
+            ((1 << s->sew) <= (get_xlen(s) / 8)) &&
+            ((1 << s->sew) >= 4));
+}
+
+static bool amo_check64_th(DisasContext *s, arg_rwdvm* a)
+{
+    REQUIRE_64BIT(s);
+    return amo_check_th(s, a);
+}
+
+GEN_TH_TRANS(th_vamoswapw_v, 0, rwdvm, amo_op_th, amo_check_th)
+GEN_TH_TRANS(th_vamoaddw_v, 1, rwdvm, amo_op_th, amo_check_th)
+GEN_TH_TRANS(th_vamoxorw_v, 2, rwdvm, amo_op_th, amo_check_th)
+GEN_TH_TRANS(th_vamoandw_v, 3, rwdvm, amo_op_th, amo_check_th)
+GEN_TH_TRANS(th_vamoorw_v, 4, rwdvm, amo_op_th, amo_check_th)
+GEN_TH_TRANS(th_vamominw_v, 5, rwdvm, amo_op_th, amo_check_th)
+GEN_TH_TRANS(th_vamomaxw_v, 6, rwdvm, amo_op_th, amo_check_th)
+GEN_TH_TRANS(th_vamominuw_v, 7, rwdvm, amo_op_th, amo_check_th)
+GEN_TH_TRANS(th_vamomaxuw_v, 8, rwdvm, amo_op_th, amo_check_th)
+GEN_TH_TRANS(th_vamoswapd_v, 9, rwdvm, amo_op_th, amo_check64_th)
+GEN_TH_TRANS(th_vamoaddd_v, 10, rwdvm, amo_op_th, amo_check64_th)
+GEN_TH_TRANS(th_vamoxord_v, 11, rwdvm, amo_op_th, amo_check64_th)
+GEN_TH_TRANS(th_vamoandd_v, 12, rwdvm, amo_op_th, amo_check64_th)
+GEN_TH_TRANS(th_vamoord_v, 13, rwdvm, amo_op_th, amo_check64_th)
+GEN_TH_TRANS(th_vamomind_v, 14, rwdvm, amo_op_th, amo_check64_th)
+GEN_TH_TRANS(th_vamomaxd_v, 15, rwdvm, amo_op_th, amo_check64_th)
+GEN_TH_TRANS(th_vamominud_v, 16, rwdvm, amo_op_th, amo_check64_th)
+GEN_TH_TRANS(th_vamomaxud_v, 17, rwdvm, amo_op_th, amo_check64_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vamoswapw_v)
-TH_TRANS_STUB(th_vamoaddw_v)
-TH_TRANS_STUB(th_vamoxorw_v)
-TH_TRANS_STUB(th_vamoandw_v)
-TH_TRANS_STUB(th_vamoorw_v)
-TH_TRANS_STUB(th_vamominw_v)
-TH_TRANS_STUB(th_vamomaxw_v)
-TH_TRANS_STUB(th_vamominuw_v)
-TH_TRANS_STUB(th_vamomaxuw_v)
-TH_TRANS_STUB(th_vamoswapd_v)
-TH_TRANS_STUB(th_vamoaddd_v)
-TH_TRANS_STUB(th_vamoxord_v)
-TH_TRANS_STUB(th_vamoandd_v)
-TH_TRANS_STUB(th_vamoord_v)
-TH_TRANS_STUB(th_vamomind_v)
-TH_TRANS_STUB(th_vamomaxd_v)
-TH_TRANS_STUB(th_vamominud_v)
-TH_TRANS_STUB(th_vamomaxud_v)
 TH_TRANS_STUB(th_vadd_vv)
 TH_TRANS_STUB(th_vadd_vx)
 TH_TRANS_STUB(th_vadd_vi)
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index af814688b5..1dced03ee3 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -51,6 +51,11 @@ static inline uint32_t th_lmul(uint32_t desc)
     return FIELD_EX32(simd_data(desc), VDATA_TH, LMUL);
 }
 
+static uint32_t th_wd(uint32_t desc)
+{
+    return (simd_data(desc) >> 11) & 0x1;
+}
+
 /*
  * Get vector group length in bytes. Its range is [64, 2048].
  *
@@ -661,3 +666,134 @@ GEN_TH_LDFF(th_vlhuff_v_w, uint16_t, uint32_t, ldhu_w, clearl_th)
 GEN_TH_LDFF(th_vlhuff_v_d, uint16_t, uint64_t, ldhu_d, clearq_th)
 GEN_TH_LDFF(th_vlwuff_v_w, uint32_t, uint32_t, ldwu_w, clearl_th)
 GEN_TH_LDFF(th_vlwuff_v_d, uint32_t, uint64_t, ldwu_d, clearq_th)
+
+/*
+ * Vector AMO Operations (Zvamo)
+ */
+typedef void th_amo_noatomic_fn(void *vs3, target_ulong addr,
+                                uint32_t wd, uint32_t idx, CPURISCVState *env,
+                                uintptr_t retaddr);
+
+#define TH_SWAP(N, M) (M)
+#define TH_XOR(N, M)  (N ^ M)
+#define TH_OR(N, M)   (N | M)
+#define TH_AND(N, M)  (N & M)
+#define TH_ADD(N, M)  (N + M)
+
+#define GEN_TH_AMO_NOATOMIC_OP(NAME, ESZ, MSZ, H, DO_OP, SUF)   \
+static void                                                     \
+NAME##_noatomic_op(void *vs3, target_ulong addr,                \
+                   uint32_t wd, uint32_t idx,                   \
+                   CPURISCVState *env, uintptr_t retaddr)       \
+{                                                               \
+    typedef int##ESZ##_t ETYPE;                                 \
+    typedef int##MSZ##_t MTYPE;                                 \
+    typedef uint##MSZ##_t UMTYPE __attribute__((unused));       \
+    ETYPE *pe3 = (ETYPE *)vs3 + H(idx);                         \
+    MTYPE  a = cpu_ld##SUF##_data(env, addr), b = *pe3;         \
+                                                                \
+    cpu_st##SUF##_data(env, addr, DO_OP(a, b));                 \
+    if (wd) {                                                   \
+        *pe3 = a;                                               \
+    }                                                           \
+}
+
+#define TH_MAX(N, M)  ((N) >= (M) ? (N) : (M))
+#define TH_MIN(N, M)  ((N) >= (M) ? (M) : (N))
+#define TH_MAXU(N, M) TH_MAX((UMTYPE)N, (UMTYPE)M)
+#define TH_MINU(N, M) TH_MIN((UMTYPE)N, (UMTYPE)M)
+
+GEN_TH_AMO_NOATOMIC_OP(th_vamoswapw_v_w, 32, 32, H4, TH_SWAP, l)
+GEN_TH_AMO_NOATOMIC_OP(th_vamoaddw_v_w,  32, 32, H4, TH_ADD,  l)
+GEN_TH_AMO_NOATOMIC_OP(th_vamoxorw_v_w,  32, 32, H4, TH_XOR,  l)
+GEN_TH_AMO_NOATOMIC_OP(th_vamoandw_v_w,  32, 32, H4, TH_AND,  l)
+GEN_TH_AMO_NOATOMIC_OP(th_vamoorw_v_w,   32, 32, H4, TH_OR,   l)
+GEN_TH_AMO_NOATOMIC_OP(th_vamominw_v_w,  32, 32, H4, TH_MIN,  l)
+GEN_TH_AMO_NOATOMIC_OP(th_vamomaxw_v_w,  32, 32, H4, TH_MAX,  l)
+GEN_TH_AMO_NOATOMIC_OP(th_vamominuw_v_w, 32, 32, H4, TH_MINU, l)
+GEN_TH_AMO_NOATOMIC_OP(th_vamomaxuw_v_w, 32, 32, H4, TH_MAXU, l)
+GEN_TH_AMO_NOATOMIC_OP(th_vamoswapw_v_d, 64, 32, H8, TH_SWAP, l)
+GEN_TH_AMO_NOATOMIC_OP(th_vamoswapd_v_d, 64, 64, H8, TH_SWAP, q)
+GEN_TH_AMO_NOATOMIC_OP(th_vamoaddw_v_d,  64, 32, H8, TH_ADD,  l)
+GEN_TH_AMO_NOATOMIC_OP(th_vamoaddd_v_d,  64, 64, H8, TH_ADD,  q)
+GEN_TH_AMO_NOATOMIC_OP(th_vamoxorw_v_d,  64, 32, H8, TH_XOR,  l)
+GEN_TH_AMO_NOATOMIC_OP(th_vamoxord_v_d,  64, 64, H8, TH_XOR,  q)
+GEN_TH_AMO_NOATOMIC_OP(th_vamoandw_v_d,  64, 32, H8, TH_AND,  l)
+GEN_TH_AMO_NOATOMIC_OP(th_vamoandd_v_d,  64, 64, H8, TH_AND,  q)
+GEN_TH_AMO_NOATOMIC_OP(th_vamoorw_v_d,   64, 32, H8, TH_OR,   l)
+GEN_TH_AMO_NOATOMIC_OP(th_vamoord_v_d,   64, 64, H8, TH_OR,   q)
+GEN_TH_AMO_NOATOMIC_OP(th_vamominw_v_d,  64, 32, H8, TH_MIN,  l)
+GEN_TH_AMO_NOATOMIC_OP(th_vamomind_v_d,  64, 64, H8, TH_MIN,  q)
+GEN_TH_AMO_NOATOMIC_OP(th_vamomaxw_v_d,  64, 32, H8, TH_MAX,  l)
+GEN_TH_AMO_NOATOMIC_OP(th_vamomaxd_v_d,  64, 64, H8, TH_MAX,  q)
+GEN_TH_AMO_NOATOMIC_OP(th_vamominuw_v_d, 64, 32, H8, TH_MINU, l)
+GEN_TH_AMO_NOATOMIC_OP(th_vamominud_v_d, 64, 64, H8, TH_MINU, q)
+GEN_TH_AMO_NOATOMIC_OP(th_vamomaxuw_v_d, 64, 32, H8, TH_MAXU, l)
+GEN_TH_AMO_NOATOMIC_OP(th_vamomaxud_v_d, 64, 64, H8, TH_MAXU, q)
+
+static inline void
+th_amo_noatomic(void *vs3, void *v0, target_ulong base,
+                void *vs2, CPURISCVState *env, uint32_t desc,
+                th_get_index_addr get_index_addr,
+                th_amo_noatomic_fn * noatomic_op,
+                clear_fn * clear_elem,
+                uint32_t esz, uint32_t msz, uintptr_t ra)
+{
+    uint32_t i;
+    target_long addr;
+    uint32_t wd = th_wd(desc);
+    uint32_t vm = th_vm(desc);
+    uint32_t mlen = th_mlen(desc);
+    uint32_t vlmax = th_maxsz(desc) / esz;
+    uint32_t vl = env->vl;
+
+    VSTART_CHECK_EARLY_EXIT(env);
+
+    for (i = env->vstart; i < vl; env->vstart = ++i) {
+        if (!vm && !th_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        addr = get_index_addr(base, i, vs2);
+        noatomic_op(vs3, adjust_addr(env, addr), wd, i, env, ra);
+    }
+    env->vstart = 0;
+    clear_elem(vs3, env->vl, env->vl * esz, vlmax * esz);
+}
+
+#define GEN_TH_AMO(NAME, MTYPE, ETYPE, INDEX_FN, CLEAR_FN)      \
+void HELPER(NAME)(void *vs3, void *v0, target_ulong base,       \
+                  void *vs2, CPURISCVState *env, uint32_t desc) \
+{                                                               \
+    th_amo_noatomic(vs3, v0, base, vs2, env, desc,              \
+                    INDEX_FN, NAME##_noatomic_op,               \
+                    CLEAR_FN, sizeof(ETYPE), sizeof(MTYPE),     \
+                    GETPC());                                   \
+}
+
+GEN_TH_AMO(th_vamoswapw_v_d, int32_t,  int64_t,  idx_d, clearq_th)
+GEN_TH_AMO(th_vamoswapd_v_d, int64_t,  int64_t,  idx_d, clearq_th)
+GEN_TH_AMO(th_vamoaddw_v_d,  int32_t,  int64_t,  idx_d, clearq_th)
+GEN_TH_AMO(th_vamoaddd_v_d,  int64_t,  int64_t,  idx_d, clearq_th)
+GEN_TH_AMO(th_vamoxorw_v_d,  int32_t,  int64_t,  idx_d, clearq_th)
+GEN_TH_AMO(th_vamoxord_v_d,  int64_t,  int64_t,  idx_d, clearq_th)
+GEN_TH_AMO(th_vamoandw_v_d,  int32_t,  int64_t,  idx_d, clearq_th)
+GEN_TH_AMO(th_vamoandd_v_d,  int64_t,  int64_t,  idx_d, clearq_th)
+GEN_TH_AMO(th_vamoorw_v_d,   int32_t,  int64_t,  idx_d, clearq_th)
+GEN_TH_AMO(th_vamoord_v_d,   int64_t,  int64_t,  idx_d, clearq_th)
+GEN_TH_AMO(th_vamominw_v_d,  int32_t,  int64_t,  idx_d, clearq_th)
+GEN_TH_AMO(th_vamomind_v_d,  int64_t,  int64_t,  idx_d, clearq_th)
+GEN_TH_AMO(th_vamomaxw_v_d,  int32_t,  int64_t,  idx_d, clearq_th)
+GEN_TH_AMO(th_vamomaxd_v_d,  int64_t,  int64_t,  idx_d, clearq_th)
+GEN_TH_AMO(th_vamominuw_v_d, uint32_t, uint64_t, idx_d, clearq_th)
+GEN_TH_AMO(th_vamominud_v_d, uint64_t, uint64_t, idx_d, clearq_th)
+GEN_TH_AMO(th_vamomaxuw_v_d, uint32_t, uint64_t, idx_d, clearq_th)
+GEN_TH_AMO(th_vamomaxud_v_d, uint64_t, uint64_t, idx_d, clearq_th)
+GEN_TH_AMO(th_vamoswapw_v_w, int32_t,  int32_t,  idx_w, clearl_th)
+GEN_TH_AMO(th_vamoaddw_v_w,  int32_t,  int32_t,  idx_w, clearl_th)
+GEN_TH_AMO(th_vamoxorw_v_w,  int32_t,  int32_t,  idx_w, clearl_th)
+GEN_TH_AMO(th_vamoandw_v_w,  int32_t,  int32_t,  idx_w, clearl_th)
+GEN_TH_AMO(th_vamoorw_v_w,   int32_t,  int32_t,  idx_w, clearl_th)
+GEN_TH_AMO(th_vamominw_v_w,  int32_t,  int32_t,  idx_w, clearl_th)
+GEN_TH_AMO(th_vamomaxw_v_w,  int32_t,  int32_t,  idx_w, clearl_th)
+GEN_TH_AMO(th_vamominuw_v_w, uint32_t, uint32_t, idx_w, clearl_th)
+GEN_TH_AMO(th_vamomaxuw_v_w, uint32_t, uint32_t, idx_w, clearl_th)
-- 
2.44.0


