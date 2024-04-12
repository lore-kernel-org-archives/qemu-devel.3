Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E412C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBoZ-0001UX-Fl; Fri, 12 Apr 2024 03:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvBoN-0001UA-KK; Fri, 12 Apr 2024 03:59:05 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvBoG-0003XK-3j; Fri, 12 Apr 2024 03:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712908729; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=09Sr0SXNnumO7TbG9kWITCDuN7gd8a13VCUf4d6xkso=;
 b=ubx08cEzfrcgipWuRJW31+8rw0k01A64an2bgO8EpJAl5kSkZ0M1KLxJVBYabNjsYN11V/1Dij+OkjHjBdZXMItW07PV3qdeYv+12KZn8sjRTnzq/uRh7P+DcsyyuE3jn14bW6OtAP/m6Z9imbqHaSyGAmPZVwnv2FWg/RDZEYg=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4Naf-L_1712908725; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4Naf-L_1712908725) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 15:58:46 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 10/65] target/riscv: Add unit-stride load instructions for
 XTheadVector
Date: Fri, 12 Apr 2024 15:36:40 +0800
Message-ID: <20240412073735.76413-11-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.132;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-132.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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

TheadVector unit-stride load instructions diff from RVV1.0 in the following
points:
1. Different mask reg layout.
2. Different vector reg element width.
3. Different tail/masked elements process policy.
4. Different check function.

The detials of the difference are the same as strided load instruction, as
unit-stride is the special case of strided operations.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         | 44 ++++++++++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 84 ++++++++++++++++--
 target/riscv/xtheadvector_helper.c            | 86 +++++++++++++++++++
 3 files changed, 207 insertions(+), 7 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index bfd6bd9b13..f2fa8425b3 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1317,3 +1317,47 @@ DEF_HELPER_6(th_vsse_v_b, void, ptr, ptr, tl, tl, env, i32)
 DEF_HELPER_6(th_vsse_v_h, void, ptr, ptr, tl, tl, env, i32)
 DEF_HELPER_6(th_vsse_v_w, void, ptr, ptr, tl, tl, env, i32)
 DEF_HELPER_6(th_vsse_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_5(th_vlb_v_b, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlb_v_b_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlb_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlb_v_h_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlb_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlb_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlb_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlb_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlh_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlh_v_h_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlh_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlh_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlh_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlh_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlw_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlw_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlw_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlw_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vle_v_b, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vle_v_b_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vle_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vle_v_h_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vle_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vle_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vle_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vle_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlbu_v_b, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlbu_v_b_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlbu_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlbu_v_h_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlbu_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlbu_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlbu_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlbu_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlhu_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlhu_v_h_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlhu_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlhu_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlhu_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlhu_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlwu_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlwu_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlwu_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(th_vlwu_v_d_mask, void, ptr, ptr, tl, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 48004bf0d6..eb910acf40 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -321,19 +321,89 @@ GEN_TH_TRANS(th_vssh_v, 1, rnfvm, st_stride_op_th, st_stride_check_th)
 GEN_TH_TRANS(th_vssw_v, 2, rnfvm, st_stride_op_th, st_stride_check_th)
 GEN_TH_TRANS(th_vsse_v, 3, rnfvm, st_stride_op_th, st_stride_check_th)
 
+/*
+ * unit stride load and store
+ */
+
+#define gen_helper_ldst_us_th gen_helper_ldst_us
+
+/*
+ * This function is almost the copy of ld_us_op, except:
+ * 1) different data encoding
+ * 2) XTheadVector has more insns to handle zero/sign-extended.
+ */
+static bool ld_us_op_th(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
+{
+    uint32_t data = 0;
+    gen_helper_ldst_us_th *fn;
+    static gen_helper_ldst_us_th * const fns[2][7][4] = {
+        /* masked unit stride load */
+        { { gen_helper_th_vlb_v_b_mask,  gen_helper_th_vlb_v_h_mask,
+            gen_helper_th_vlb_v_w_mask,  gen_helper_th_vlb_v_d_mask },
+          { NULL,                        gen_helper_th_vlh_v_h_mask,
+            gen_helper_th_vlh_v_w_mask,  gen_helper_th_vlh_v_d_mask },
+          { NULL,                        NULL,
+            gen_helper_th_vlw_v_w_mask,  gen_helper_th_vlw_v_d_mask },
+          { gen_helper_th_vle_v_b_mask,  gen_helper_th_vle_v_h_mask,
+            gen_helper_th_vle_v_w_mask,  gen_helper_th_vle_v_d_mask },
+          { gen_helper_th_vlbu_v_b_mask, gen_helper_th_vlbu_v_h_mask,
+            gen_helper_th_vlbu_v_w_mask, gen_helper_th_vlbu_v_d_mask },
+          { NULL,                        gen_helper_th_vlhu_v_h_mask,
+            gen_helper_th_vlhu_v_w_mask, gen_helper_th_vlhu_v_d_mask },
+          { NULL,                        NULL,
+            gen_helper_th_vlwu_v_w_mask, gen_helper_th_vlwu_v_d_mask } },
+        /* unmasked unit stride load */
+        { { gen_helper_th_vlb_v_b,  gen_helper_th_vlb_v_h,
+            gen_helper_th_vlb_v_w,  gen_helper_th_vlb_v_d },
+          { NULL,                   gen_helper_th_vlh_v_h,
+            gen_helper_th_vlh_v_w,  gen_helper_th_vlh_v_d },
+          { NULL,                   NULL,
+            gen_helper_th_vlw_v_w,  gen_helper_th_vlw_v_d },
+          { gen_helper_th_vle_v_b,  gen_helper_th_vle_v_h,
+            gen_helper_th_vle_v_w,  gen_helper_th_vle_v_d },
+          { gen_helper_th_vlbu_v_b, gen_helper_th_vlbu_v_h,
+            gen_helper_th_vlbu_v_w, gen_helper_th_vlbu_v_d },
+          { NULL,                   gen_helper_th_vlhu_v_h,
+            gen_helper_th_vlhu_v_w, gen_helper_th_vlhu_v_d },
+          { NULL,                   NULL,
+            gen_helper_th_vlwu_v_w, gen_helper_th_vlwu_v_d } }
+    };
+
+    fn =  fns[a->vm][seq][s->sew];
+    if (fn == NULL) {
+        return false;
+    }
+
+    data = FIELD_DP32(data, VDATA_TH, MLEN, s->mlen);
+    data = FIELD_DP32(data, VDATA_TH, VM, a->vm);
+    data = FIELD_DP32(data, VDATA_TH, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA_TH, NF, a->nf);
+    return ldst_us_trans(a->rd, a->rs1, data, fn, s, false);
+}
+
+static bool ld_us_check_th(DisasContext *s, arg_r2nfvm* a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_overlap_mask(s, a->rd, a->vm, false) &&
+            th_check_reg(s, a->rd, false) &&
+            th_check_nf(s, a->rd, a->nf));
+}
+
+GEN_TH_TRANS(th_vlb_v, 0, r2nfvm, ld_us_op_th, ld_us_check_th)
+GEN_TH_TRANS(th_vlh_v, 1, r2nfvm, ld_us_op_th, ld_us_check_th)
+GEN_TH_TRANS(th_vlw_v, 2, r2nfvm, ld_us_op_th, ld_us_check_th)
+GEN_TH_TRANS(th_vle_v, 3, r2nfvm, ld_us_op_th, ld_us_check_th)
+GEN_TH_TRANS(th_vlbu_v, 4, r2nfvm, ld_us_op_th, ld_us_check_th)
+GEN_TH_TRANS(th_vlhu_v, 5, r2nfvm, ld_us_op_th, ld_us_check_th)
+GEN_TH_TRANS(th_vlwu_v, 6, r2nfvm, ld_us_op_th, ld_us_check_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vlb_v)
-TH_TRANS_STUB(th_vlh_v)
-TH_TRANS_STUB(th_vlw_v)
-TH_TRANS_STUB(th_vle_v)
-TH_TRANS_STUB(th_vlbu_v)
-TH_TRANS_STUB(th_vlhu_v)
-TH_TRANS_STUB(th_vlwu_v)
 TH_TRANS_STUB(th_vlbff_v)
 TH_TRANS_STUB(th_vlhff_v)
 TH_TRANS_STUB(th_vlwff_v)
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 17de312f0a..7566ab8e31 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -319,3 +319,89 @@ GEN_TH_ST_STRIDE(th_vsse_v_b, int8_t,  int8_t,  ste_b)
 GEN_TH_ST_STRIDE(th_vsse_v_h, int16_t, int16_t, ste_h)
 GEN_TH_ST_STRIDE(th_vsse_v_w, int32_t, int32_t, ste_w)
 GEN_TH_ST_STRIDE(th_vsse_v_d, int64_t, int64_t, ste_d)
+
+/*
+ * unit-stride: access elements stored contiguously in memory
+ */
+
+/*
+ * unmasked unit-stride load and store operation
+ *
+ * This function is almost the copy of vext_ldst_us, except:
+ * 1) different mask layout
+ * 2) different data encoding
+ * 3) different the tail elements process policy
+ */
+static void
+th_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
+           th_ldst_elem_fn *ldst_elem, clear_fn *clear_elem,
+           uint32_t esz, uint32_t msz, uintptr_t ra)
+{
+    uint32_t i, k;
+    uint32_t nf = th_nf(desc);
+    uint32_t vlmax = th_maxsz(desc) / esz;
+
+    VSTART_CHECK_EARLY_EXIT(env);
+
+    /* load bytes from guest memory */
+    for (i = env->vstart; i < env->vl; env->vstart = ++i) {
+        k = 0;
+        while (k < nf) {
+            target_ulong addr = base + (i * nf + k) * msz;
+            ldst_elem(env, adjust_addr(env, addr), i + k * vlmax, vd, ra);
+            k++;
+        }
+    }
+    env->vstart = 0;
+    /* clear tail elements */
+    if (clear_elem) {
+        for (k = 0; k < nf; k++) {
+            clear_elem(vd, env->vl + k * vlmax, env->vl * esz, vlmax * esz);
+        }
+    }
+}
+
+/*
+ * masked unit-stride load and store operation will be a special case of stride,
+ * stride = NF * sizeof (MTYPE)
+ *
+ * similar to GEN_GEN_VEXT_LD_US, change the function
+ */
+#define GEN_TH_LD_US(NAME, MTYPE, ETYPE, LOAD_FN, CLEAR_FN)             \
+void HELPER(NAME##_mask)(void *vd, void *v0, target_ulong base,         \
+                         CPURISCVState *env, uint32_t desc)             \
+{                                                                       \
+    uint32_t stride = th_nf(desc) * sizeof(MTYPE);                      \
+    th_ldst_stride(vd, v0, base, stride, env, desc, false, LOAD_FN,     \
+                   CLEAR_FN, sizeof(ETYPE), sizeof(MTYPE), GETPC());    \
+}                                                                       \
+                                                                        \
+void HELPER(NAME)(void *vd, void *v0, target_ulong base,                \
+                  CPURISCVState *env, uint32_t desc)                    \
+{                                                                       \
+    th_ldst_us(vd, base, env, desc, LOAD_FN, CLEAR_FN,                  \
+               sizeof(ETYPE), sizeof(MTYPE), GETPC());                  \
+}
+
+GEN_TH_LD_US(th_vlb_v_b,  int8_t,   int8_t,   ldb_b,  clearb_th)
+GEN_TH_LD_US(th_vlb_v_h,  int8_t,   int16_t,  ldb_h,  clearh_th)
+GEN_TH_LD_US(th_vlb_v_w,  int8_t,   int32_t,  ldb_w,  clearl_th)
+GEN_TH_LD_US(th_vlb_v_d,  int8_t,   int64_t,  ldb_d,  clearq_th)
+GEN_TH_LD_US(th_vlh_v_h,  int16_t,  int16_t,  ldh_h,  clearh_th)
+GEN_TH_LD_US(th_vlh_v_w,  int16_t,  int32_t,  ldh_w,  clearl_th)
+GEN_TH_LD_US(th_vlh_v_d,  int16_t,  int64_t,  ldh_d,  clearq_th)
+GEN_TH_LD_US(th_vlw_v_w,  int32_t,  int32_t,  ldw_w,  clearl_th)
+GEN_TH_LD_US(th_vlw_v_d,  int32_t,  int64_t,  ldw_d,  clearq_th)
+GEN_TH_LD_US(th_vle_v_b,  int8_t,   int8_t,   lde_b,  clearb_th)
+GEN_TH_LD_US(th_vle_v_h,  int16_t,  int16_t,  lde_h,  clearh_th)
+GEN_TH_LD_US(th_vle_v_w,  int32_t,  int32_t,  lde_w,  clearl_th)
+GEN_TH_LD_US(th_vle_v_d,  int64_t,  int64_t,  lde_d,  clearq_th)
+GEN_TH_LD_US(th_vlbu_v_b, uint8_t,  uint8_t,  ldbu_b, clearb_th)
+GEN_TH_LD_US(th_vlbu_v_h, uint8_t,  uint16_t, ldbu_h, clearh_th)
+GEN_TH_LD_US(th_vlbu_v_w, uint8_t,  uint32_t, ldbu_w, clearl_th)
+GEN_TH_LD_US(th_vlbu_v_d, uint8_t,  uint64_t, ldbu_d, clearq_th)
+GEN_TH_LD_US(th_vlhu_v_h, uint16_t, uint16_t, ldhu_h, clearh_th)
+GEN_TH_LD_US(th_vlhu_v_w, uint16_t, uint32_t, ldhu_w, clearl_th)
+GEN_TH_LD_US(th_vlhu_v_d, uint16_t, uint64_t, ldhu_d, clearq_th)
+GEN_TH_LD_US(th_vlwu_v_w, uint32_t, uint32_t, ldwu_w, clearl_th)
+GEN_TH_LD_US(th_vlwu_v_d, uint32_t, uint64_t, ldwu_d, clearq_th)
-- 
2.44.0


