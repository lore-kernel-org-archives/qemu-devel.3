Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76298C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 09:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvDdg-0007p1-Ah; Fri, 12 Apr 2024 05:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDdd-0007om-S5; Fri, 12 Apr 2024 05:56:05 -0400
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDdZ-0008OR-33; Fri, 12 Apr 2024 05:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712915755; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=PtcCdLJMSL6qhMP3DJl3nheiurGwNC2IL8KiBFsJE8o=;
 b=SdK+XZzAq+/fDny8P/h73sRH5KSwpDpbiVwvqP6cmd9cLrWQYXaTpQwzAbhLsXD8Qps6fLD2YaQJNDIlBtWVvu1TMBWDqn800OUbBw2EyYOzKQq1hIsy0vGoNaHx7TwpVHa5w0ppKYjujSConf+oS9/uAzCAB0ohkyREa5M0NYg=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4Nu53m_1712915753; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4Nu53m_1712915753) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 17:55:54 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 60/65] target/riscv: Add integer extract and scalar move
 instructions for XTheadVector
Date: Fri, 12 Apr 2024 15:37:30 +0800
Message-ID: <20240412073735.76413-61-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.119;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-119.freemail.mail.aliyun.com
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

In this patch, we add integer extract and scalar move instructions to show the way we
implement XTheadVector permutation instructions.
XTheadVector integer scalar move instructions diff from RVV1.0 in the following
points:
1. th.vext.x.v can transfer any element in a vector register to a general
   register, while vmv.x.s can only transfer the first element in a vector
   register to a general register.
2. When SEW < XLEN, XTheadVector zero-extend the value, while RVV1.0
   sign-extend the value.
3. different tail element process policy.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 154 +++++++++++++++++-
 1 file changed, 152 insertions(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 9a0ea606ab..a8a1ec7b3f 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -2588,14 +2588,164 @@ static bool trans_th_vid_v(DisasContext *s, arg_th_vid_v *a)
     return false;
 }
 
+/*
+ * Vector Permutation Instructions
+ */
+
+/* Integer Extract Instruction */
+
+/*
+ * This function is almost the copy of load_element, except:
+ * 1) When SEW < XLEN, XTheadVector zero-extend the value, while
+ *    RVV1.0 sign-extend the value.
+ */
+static void load_element_th(TCGv_i64 dest, TCGv_ptr base,
+                            int ofs, int sew)
+{
+    switch (sew) {
+    case MO_8:
+        tcg_gen_ld8u_i64(dest, base, ofs);
+        break;
+    case MO_16:
+        tcg_gen_ld16u_i64(dest, base, ofs);
+        break;
+    case MO_32:
+        tcg_gen_ld32u_i64(dest, base, ofs);
+        break;
+    case MO_64:
+        tcg_gen_ld_i64(dest, base, ofs);
+        break;
+    default:
+        g_assert_not_reached();
+        break;
+    }
+}
+
+/* Load idx >= VLMAX ? 0 : vreg[idx] */
+static void th_element_loadx(DisasContext *s, TCGv_i64 dest,
+                              int vreg, TCGv idx, int vlmax)
+{
+    TCGv_i32 ofs = tcg_temp_new_i32();
+    TCGv_ptr base = tcg_temp_new_ptr();
+    TCGv_i64 t_idx = tcg_temp_new_i64();
+    TCGv_i64 t_vlmax, t_zero;
+
+    /*
+     * Mask the index to the length so that we do
+     * not produce an out-of-range load.
+     */
+    tcg_gen_trunc_tl_i32(ofs, idx);
+    tcg_gen_andi_i32(ofs, ofs, vlmax - 1);
+
+    /* Convert the index to an offset. */
+    endian_adjust(ofs, s->sew);
+    tcg_gen_shli_i32(ofs, ofs, s->sew);
+
+    /* Convert the index to a pointer. */
+    tcg_gen_ext_i32_ptr(base, ofs);
+    tcg_gen_add_ptr(base, base, tcg_env);
+
+    /* Perform the load. */
+    load_element_th(dest, base,
+                    vreg_ofs(s, vreg), s->sew);
+
+    /* Flush out-of-range indexing to zero.  */
+    t_vlmax = tcg_constant_i64(vlmax);
+    t_zero = tcg_constant_i64(0);
+    tcg_gen_extu_tl_i64(t_idx, idx);
+
+    tcg_gen_movcond_i64(TCG_COND_LTU, dest, t_idx,
+                        t_vlmax, dest, t_zero);
+
+}
+/*
+ * This function is almost the copy of vec_element_loadi, except
+ * we just change the function name to decouple and delete the
+ * unused parameter.
+ * We delete the arg "bool sign", because XTheadVector always
+ * zero-extend the value.
+ */
+static void th_element_loadi(DisasContext *s, TCGv_i64 dest,
+                              int vreg, int idx)
+{
+    load_element_th(dest, tcg_env, endian_ofs(s, vreg, idx), s->sew);
+}
+
+/*
+ * Compared to trans_vmv_x_s, th.vext.x.v can transfer any element
+ * in a vector register to a general register, while vmv.x.s can only
+ * transfer the first element in a vector register to a general register.
+ *
+ * So we use th_element_loadx to load the element. And we use th_element_loadi
+ * to deal with the special case when rs1 == 0, to accelerate.
+ */
+static bool trans_th_vext_x_v(DisasContext *s, arg_r *a)
+{
+    if (require_xtheadvector(s) &&
+        vext_check_isa_ill(s)) {
+        TCGv_i64 tmp = tcg_temp_new_i64();
+        TCGv dest = dest_gpr(s, a->rd);
+
+        if (a->rs1 == 0) {
+            /* Special case vmv.x.s rd, vs2. */
+            th_element_loadi(s, tmp, a->rs2, 0);
+        } else {
+            /* This instruction ignores LMUL and vector register groups */
+            int vlmax = s->cfg_ptr->vlenb >> s->sew;
+            th_element_loadx(s, tmp, a->rs2, cpu_gpr[a->rs1], vlmax);
+        }
+
+        tcg_gen_trunc_i64_tl(dest, tmp);
+        gen_set_gpr(s, a->rd, dest);
+        tcg_gen_movi_tl(cpu_vstart, 0);
+        finalize_rvv_inst(s);
+        return true;
+    }
+    return false;
+}
+
+/* Integer Scalar Move Instruction */
+
+static void th_element_storei(DisasContext *s, int vreg,
+                              int idx, TCGv_i64 val)
+{
+    vec_element_storei(s, vreg, idx, val);
+}
+/* vmv.s.x vd, rs1 # vd[0] = rs1 */
+static bool trans_th_vmv_s_x(DisasContext *s, arg_th_vmv_s_x *a)
+{
+    if (require_xtheadvector(s) &&
+        vext_check_isa_ill(s)) {
+        /* This instruction ignores LMUL and vector register groups */
+        int maxsz = s->cfg_ptr->vlenb;
+        TCGv_i64 t1;
+        TCGLabel *over = gen_new_label();
+        TCGv src1 = get_gpr(s, a->rs1, EXT_ZERO);
+
+        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
+        tcg_gen_gvec_dup_imm(MO_64, vreg_ofs(s, a->rd), maxsz, maxsz, 0);
+        if (a->rs1 == 0) {
+            goto done;
+        }
+
+        t1 = tcg_temp_new_i64();
+        tcg_gen_extu_tl_i64(t1, src1);
+        th_element_storei(s, a->rd, 0, t1);
+    done:
+        gen_set_label(over);
+        tcg_gen_movi_tl(cpu_vstart, 0);
+        finalize_rvv_inst(s);
+        return true;
+    }
+    return false;
+}
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vext_x_v)
-TH_TRANS_STUB(th_vmv_s_x)
 TH_TRANS_STUB(th_vfmv_f_s)
 TH_TRANS_STUB(th_vfmv_s_f)
 TH_TRANS_STUB(th_vslideup_vx)
-- 
2.44.0


