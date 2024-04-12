Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F8AC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBmV-0000CF-06; Fri, 12 Apr 2024 03:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvBmM-0000AV-Rm; Fri, 12 Apr 2024 03:56:59 -0400
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvBmF-0003I0-UN; Fri, 12 Apr 2024 03:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712908605; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=DekwD9q+3PbDnA5bdrcq6XzBLYGk6h6UtXapc5/9268=;
 b=BBxOkZsVl6QsC3S0ClHzeaAV34UxnXfS6AZRz0pFVUjs7QteCyERotB5JbTlxcBwM/VIxW6AgAALvEPC1Xs0K9uJDN2Kp4ycql2tp56+BAfMyV+QJoUi3+mRa/eEqnmzK341I0XHiXa8PLOGadOyD0td1z4k0oGoYCube6lXH3g=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NUO.B_1712908603; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NUO.B_1712908603) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 15:56:44 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 09/65] target/riscv: Add strided store instructions for
 XTheadVector
Date: Fri, 12 Apr 2024 15:36:39 +0800
Message-ID: <20240412073735.76413-10-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
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

XTheadVector strided store instructions diff from RVV1.0 in the following
points:
1. Different mask reg layout. The difference is same as strided load instructions.
2. Different vector reg element width. XTheadVector has 4 instructions,
   th.vss{b,h,w,e}.v. They store SEW-bit reg data to 8/16/32/SEW-bit memory loaction.
   RVV1.0 has 4 instructions, vsse{8,16,32,64}.v. They store 8/16/32/64-bit reg data
   to 8/16/32/64-bit memory location.
3. Different tail/masked elements process policy. The difference is same as strided
   load instructions.
4. Different check policy. XTheadVector does not have fractional lmul and emul,
   so we can use simpler check function.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         | 13 +++++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 56 +++++++++++++++++--
 target/riscv/xtheadvector_helper.c            | 50 +++++++++++++++++
 3 files changed, 115 insertions(+), 4 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 8decfc20cc..bfd6bd9b13 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1304,3 +1304,16 @@ DEF_HELPER_6(th_vlshu_v_w, void, ptr, ptr, tl, tl, env, i32)
 DEF_HELPER_6(th_vlshu_v_d, void, ptr, ptr, tl, tl, env, i32)
 DEF_HELPER_6(th_vlswu_v_w, void, ptr, ptr, tl, tl, env, i32)
 DEF_HELPER_6(th_vlswu_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vssb_v_b, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vssb_v_h, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vssb_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vssb_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vssh_v_h, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vssh_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vssh_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vssw_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vssw_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vsse_v_b, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vsse_v_h, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vsse_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(th_vsse_v_d, void, ptr, ptr, tl, tl, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 72481fdd5f..48004bf0d6 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -269,6 +269,58 @@ GEN_TH_TRANS(th_vlsbu_v, 4, rnfvm, ld_stride_op_th, ld_stride_check_th)
 GEN_TH_TRANS(th_vlshu_v, 5, rnfvm, ld_stride_op_th, ld_stride_check_th)
 GEN_TH_TRANS(th_vlswu_v, 6, rnfvm, ld_stride_op_th, ld_stride_check_th)
 
+/*
+ * This function is almost the copy of st_stride_op, except:
+ * 1) XTheadVector using different data encoding, add MLEN,
+ *    delete VTA and VMA.
+ * 2) XTheadVector has more situations. vss{8,16,32,64}.v decide the
+ *    reg and mem width both equal 8/16/32/64. As for th.vss{b,h,w}.v, the
+ *    reg width equals SEW, and the mem width equals 8/16/32. The reg and
+ *    mem width of th.vsse.v both equal SEW. Therefore, we need to add more
+ *    helper functions depending on SEW.
+ */
+static bool st_stride_op_th(DisasContext *s, arg_rnfvm *a, uint8_t seq)
+{
+    uint32_t data = 0;
+    gen_helper_ldst_stride_th *fn;
+    static gen_helper_ldst_stride_th * const fns[4][4] = {
+        /* masked stride store */
+        { gen_helper_th_vssb_v_b,  gen_helper_th_vssb_v_h,
+          gen_helper_th_vssb_v_w,  gen_helper_th_vssb_v_d },
+        { NULL,                    gen_helper_th_vssh_v_h,
+          gen_helper_th_vssh_v_w,  gen_helper_th_vssh_v_d },
+        { NULL,                    NULL,
+          gen_helper_th_vssw_v_w,  gen_helper_th_vssw_v_d },
+        { gen_helper_th_vsse_v_b,  gen_helper_th_vsse_v_h,
+          gen_helper_th_vsse_v_w,  gen_helper_th_vsse_v_d }
+    };
+
+    data = FIELD_DP32(data, VDATA_TH, MLEN, s->mlen);
+    data = FIELD_DP32(data, VDATA_TH, VM, a->vm);
+    data = FIELD_DP32(data, VDATA_TH, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA_TH, NF, a->nf);
+    fn =  fns[seq][s->sew];
+    if (fn == NULL) {
+        return false;
+    }
+
+    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
+}
+
+/* store does not need to check overlap */
+static bool st_stride_check_th(DisasContext *s, arg_rnfvm* a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_reg(s, a->rd, false) &&
+            th_check_nf(s, a->rd, a->nf));
+}
+
+GEN_TH_TRANS(th_vssb_v, 0, rnfvm, st_stride_op_th, st_stride_check_th)
+GEN_TH_TRANS(th_vssh_v, 1, rnfvm, st_stride_op_th, st_stride_check_th)
+GEN_TH_TRANS(th_vssw_v, 2, rnfvm, st_stride_op_th, st_stride_check_th)
+GEN_TH_TRANS(th_vsse_v, 3, rnfvm, st_stride_op_th, st_stride_check_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
@@ -293,10 +345,6 @@ TH_TRANS_STUB(th_vsb_v)
 TH_TRANS_STUB(th_vsh_v)
 TH_TRANS_STUB(th_vsw_v)
 TH_TRANS_STUB(th_vse_v)
-TH_TRANS_STUB(th_vssb_v)
-TH_TRANS_STUB(th_vssh_v)
-TH_TRANS_STUB(th_vssw_v)
-TH_TRANS_STUB(th_vsse_v)
 TH_TRANS_STUB(th_vlxb_v)
 TH_TRANS_STUB(th_vlxh_v)
 TH_TRANS_STUB(th_vlxw_v)
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 7bfd85901e..17de312f0a 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -179,6 +179,28 @@ GEN_TH_LD_ELEM(ldhu_d, uint16_t, uint64_t, H8, lduw)
 GEN_TH_LD_ELEM(ldwu_w, uint32_t, uint32_t, H4, ldl)
 GEN_TH_LD_ELEM(ldwu_d, uint32_t, uint64_t, H8, ldl)
 
+#define GEN_TH_ST_ELEM(NAME, ETYPE, H, STSUF)            \
+static void NAME(CPURISCVState *env, abi_ptr addr,         \
+                 uint32_t idx, void *vd, uintptr_t retaddr)\
+{                                                          \
+    ETYPE data = *((ETYPE *)vd + H(idx));                  \
+    cpu_##STSUF##_data_ra(env, addr, data, retaddr);       \
+}
+
+GEN_TH_ST_ELEM(stb_b, int8_t,  H1, stb)
+GEN_TH_ST_ELEM(stb_h, int16_t, H2, stb)
+GEN_TH_ST_ELEM(stb_w, int32_t, H4, stb)
+GEN_TH_ST_ELEM(stb_d, int64_t, H8, stb)
+GEN_TH_ST_ELEM(sth_h, int16_t, H2, stw)
+GEN_TH_ST_ELEM(sth_w, int32_t, H4, stw)
+GEN_TH_ST_ELEM(sth_d, int64_t, H8, stw)
+GEN_TH_ST_ELEM(stw_w, int32_t, H4, stl)
+GEN_TH_ST_ELEM(stw_d, int64_t, H8, stl)
+GEN_TH_ST_ELEM(ste_b, int8_t,  H1, stb)
+GEN_TH_ST_ELEM(ste_h, int16_t, H2, stw)
+GEN_TH_ST_ELEM(ste_w, int32_t, H4, stl)
+GEN_TH_ST_ELEM(ste_d, int64_t, H8, stq)
+
 /*
  * stride: access vector element from strided memory
  */
@@ -269,3 +291,31 @@ GEN_TH_LD_STRIDE(th_vlshu_v_w, uint16_t, uint32_t, ldhu_w, clearl_th)
 GEN_TH_LD_STRIDE(th_vlshu_v_d, uint16_t, uint64_t, ldhu_d, clearq_th)
 GEN_TH_LD_STRIDE(th_vlswu_v_w, uint32_t, uint32_t, ldwu_w, clearl_th)
 GEN_TH_LD_STRIDE(th_vlswu_v_d, uint32_t, uint64_t, ldwu_d, clearq_th)
+
+/*
+ * GEN_TH_ST_STRIDE is similar to GEN_VEXT_ST_STRIDE
+ * just change the function name and args
+ */
+#define GEN_TH_ST_STRIDE(NAME, MTYPE, ETYPE, STORE_FN)                  \
+void HELPER(NAME)(void *vd, void *v0, target_ulong base,                \
+                  target_ulong stride, CPURISCVState *env,              \
+                  uint32_t desc)                                        \
+{                                                                       \
+    uint32_t vm = th_vm(desc);                                          \
+    th_ldst_stride(vd, v0, base, stride, env, desc, vm, STORE_FN,       \
+                   NULL, sizeof(ETYPE), sizeof(MTYPE), GETPC());        \
+}
+
+GEN_TH_ST_STRIDE(th_vssb_v_b, int8_t,  int8_t,  stb_b)
+GEN_TH_ST_STRIDE(th_vssb_v_h, int8_t,  int16_t, stb_h)
+GEN_TH_ST_STRIDE(th_vssb_v_w, int8_t,  int32_t, stb_w)
+GEN_TH_ST_STRIDE(th_vssb_v_d, int8_t,  int64_t, stb_d)
+GEN_TH_ST_STRIDE(th_vssh_v_h, int16_t, int16_t, sth_h)
+GEN_TH_ST_STRIDE(th_vssh_v_w, int16_t, int32_t, sth_w)
+GEN_TH_ST_STRIDE(th_vssh_v_d, int16_t, int64_t, sth_d)
+GEN_TH_ST_STRIDE(th_vssw_v_w, int32_t, int32_t, stw_w)
+GEN_TH_ST_STRIDE(th_vssw_v_d, int32_t, int64_t, stw_d)
+GEN_TH_ST_STRIDE(th_vsse_v_b, int8_t,  int8_t,  ste_b)
+GEN_TH_ST_STRIDE(th_vsse_v_h, int16_t, int16_t, ste_h)
+GEN_TH_ST_STRIDE(th_vsse_v_w, int32_t, int32_t, ste_w)
+GEN_TH_ST_STRIDE(th_vsse_v_d, int64_t, int64_t, ste_d)
-- 
2.44.0


