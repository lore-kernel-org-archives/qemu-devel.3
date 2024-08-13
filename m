Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81573C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 11:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdpvE-0001JR-MV; Tue, 13 Aug 2024 07:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sdpv5-0000la-Ru; Tue, 13 Aug 2024 07:42:33 -0400
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sdpv2-0003dy-T0; Tue, 13 Aug 2024 07:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1723549344; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=znLSvwkEqr0aaxGpxr2NfOv6XEcqHqV18gv2KQ2YOyM=;
 b=SDmLkI4J6JA2hhd3O+Aq9zUg7K4GD6Qeu1b4CTQ6UIhq8ZDEl8vUCbq4ZDdCROw54hFM91Z64H7sfzGwzXWuTlQt949efm2LTe68FwgtELmqdv18HG1rAs5waWOLZB1+FB+sEmoLZyJ0Sfk0Z3Z8VO6gzW88U1NESGUJ711uZLM=
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WCow1xq_1723549342) by smtp.aliyun-inc.com;
 Tue, 13 Aug 2024 19:42:23 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v1 14/15] tcg/riscv: Implement vector roti/v/x shi ops
Date: Tue, 13 Aug 2024 19:34:35 +0800
Message-Id: <20240813113436.831-15-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
References: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.110;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-110.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 tcg/riscv/tcg-target.c.inc | 107 ++++++++++++++++++++++++++++++++++++-
 tcg/riscv/tcg-target.h     |   8 +--
 tcg/riscv/tcg-target.opc.h |   3 ++
 3 files changed, 113 insertions(+), 5 deletions(-)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 467437e175..59d23ed622 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -345,10 +345,13 @@ typedef enum {
     OPC_VMSGT_VX = 0x7c000057 | V_OPIVX,
 
     OPC_VSLL_VV = 0x94000057 | V_OPIVV,
+    OPC_VSLL_VI = 0x94000057 | V_OPIVI,
     OPC_VSLL_VX = 0x94000057 | V_OPIVX,
     OPC_VSRL_VV = 0xa0000057 | V_OPIVV,
+    OPC_VSRL_VI = 0xa0000057 | V_OPIVI,
     OPC_VSRL_VX = 0xa0000057 | V_OPIVX,
     OPC_VSRA_VV = 0xa4000057 | V_OPIVV,
+    OPC_VSRA_VI = 0xa4000057 | V_OPIVI,
     OPC_VSRA_VX = 0xa4000057 | V_OPIVX,
 
     OPC_VMV_V_V = 0x5e000057 | V_OPIVV,
@@ -2384,6 +2387,15 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_sarv_vec:
         tcg_out_opc_vv(s, OPC_VSRA_VV, a0, a1, a2, true);
         break;
+    case INDEX_op_rvv_shli_vec:
+        tcg_out_opc_vi(s, OPC_VSLL_VI, a0, a1, a2, true);
+        break;
+    case INDEX_op_rvv_shri_vec:
+        tcg_out_opc_vi(s, OPC_VSRL_VI, a0, a1, a2, true);
+        break;
+    case INDEX_op_rvv_sari_vec:
+        tcg_out_opc_vi(s, OPC_VSRA_VI, a0, a1, a2, true);
+        break;
     case INDEX_op_rvv_cmpcond_vec:
         {
             RISCVInsn op;
@@ -2422,7 +2434,8 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
                        TCGArg a0, ...)
 {
     va_list va;
-    TCGv_vec v0, v1;
+    TCGv_vec v0, v1, v2, c1, t1;
+    TCGv_i32 t2;
     TCGArg a2, a3;
 
     va_start(va, a0);
@@ -2442,6 +2455,81 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
                       tcgv_i64_arg(tcg_constant_i64(-1)));
         }
         break;
+    case INDEX_op_shli_vec:
+        if (a2 > 31) {
+            t2 = tcg_temp_new_i32();
+            tcg_gen_movi_i32(t2, (int32_t)a2);
+            tcg_gen_shls_vec(vece, v0, v1, t2);
+            tcg_temp_free_i32(t2);
+        } else {
+            vec_gen_3(INDEX_op_rvv_shli_vec, type, vece, tcgv_vec_arg(v0),
+                      tcgv_vec_arg(v1), a2);
+        }
+        break;
+    case INDEX_op_shri_vec:
+        if (a2 > 31) {
+            t2 = tcg_temp_new_i32();
+            tcg_gen_movi_i32(t2, (int32_t)a2);
+            tcg_gen_shrs_vec(vece, v0, v1, t2);
+            tcg_temp_free_i32(t2);
+        } else {
+            vec_gen_3(INDEX_op_rvv_shri_vec, type, vece, tcgv_vec_arg(v0),
+                      tcgv_vec_arg(v1), a2);
+        }
+        break;
+    case INDEX_op_sari_vec:
+        if (a2 > 31) {
+            t2 = tcg_temp_new_i32();
+            tcg_gen_movi_i32(t2, (int32_t)a2);
+            tcg_gen_sars_vec(vece, v0, v1, t2);
+            tcg_temp_free_i32(t2);
+        } else {
+            vec_gen_3(INDEX_op_rvv_sari_vec, type, vece, tcgv_vec_arg(v0),
+                      tcgv_vec_arg(v1), a2);
+        }
+        break;
+    case INDEX_op_rotli_vec:
+        t1 = tcg_temp_new_vec(type);
+        tcg_gen_shli_vec(vece, t1, v1, a2);
+        tcg_gen_shri_vec(vece, v0, v1, (8 << vece) - a2);
+        tcg_gen_or_vec(vece, v0, v0, t1);
+        tcg_temp_free_vec(t1);
+        break;
+    case INDEX_op_rotls_vec:
+        t1 = tcg_temp_new_vec(type);
+        t2 = tcg_temp_new_i32();
+        tcg_gen_sub_i32(t2, tcg_constant_i32(8 << vece),
+                        temp_tcgv_i32(arg_temp(a2)));
+        tcg_gen_shrs_vec(vece, v0, v1, t2);
+        tcg_gen_shls_vec(vece, t1, v1, temp_tcgv_i32(arg_temp(a2)));
+        tcg_gen_or_vec(vece, v0, v0, t1);
+        tcg_temp_free_vec(t1);
+        tcg_temp_free_i32(t2);
+        break;
+    case INDEX_op_rotlv_vec:
+        v2 = temp_tcgv_vec(arg_temp(a2));
+        t1 = tcg_temp_new_vec(type);
+        c1 = tcg_constant_vec(type, vece, 8 << vece);
+        tcg_gen_sub_vec(vece, t1, c1, v2);
+        vec_gen_3(INDEX_op_shrv_vec, type, vece, tcgv_vec_arg(t1),
+                  tcgv_vec_arg(v1), tcgv_vec_arg(t1));
+        vec_gen_3(INDEX_op_shlv_vec, type, vece, tcgv_vec_arg(v0),
+                  tcgv_vec_arg(v1), tcgv_vec_arg(v2));
+        tcg_gen_or_vec(vece, v0, v0, t1);
+        tcg_temp_free_vec(t1);
+        break;
+    case INDEX_op_rotrv_vec:
+        v2 = temp_tcgv_vec(arg_temp(a2));
+        t1 = tcg_temp_new_vec(type);
+        c1 = tcg_constant_vec(type, vece, 8 << vece);
+        tcg_gen_sub_vec(vece, t1, c1, v2);
+        vec_gen_3(INDEX_op_shlv_vec, type, vece, tcgv_vec_arg(t1),
+                  tcgv_vec_arg(v1), tcgv_vec_arg(t1));
+        vec_gen_3(INDEX_op_shrv_vec, type, vece, tcgv_vec_arg(v0),
+                  tcgv_vec_arg(v1), tcgv_vec_arg(v2));
+        tcg_gen_or_vec(vece, v0, v0, t1);
+        tcg_temp_free_vec(t1);
+        break;
     default:
         g_assert_not_reached();
     }
@@ -2475,6 +2563,13 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_sarv_vec:
         return 1;
     case INDEX_op_cmp_vec:
+    case INDEX_op_shri_vec:
+    case INDEX_op_shli_vec:
+    case INDEX_op_sari_vec:
+    case INDEX_op_rotls_vec:
+    case INDEX_op_rotlv_vec:
+    case INDEX_op_rotrv_vec:
+    case INDEX_op_rotli_vec:
         return -1;
     default:
         return 0;
@@ -2628,6 +2723,13 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
         return C_O1_I1(v, r);
     case INDEX_op_neg_vec:
     case INDEX_op_not_vec:
+    case INDEX_op_rotli_vec:
+    case INDEX_op_shli_vec:
+    case INDEX_op_shri_vec:
+    case INDEX_op_sari_vec:
+    case INDEX_op_rvv_shli_vec:
+    case INDEX_op_rvv_shri_vec:
+    case INDEX_op_rvv_sari_vec:
         return C_O1_I1(v, v);
     case INDEX_op_add_vec:
     case INDEX_op_sub_vec:
@@ -2646,10 +2748,13 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_shlv_vec:
     case INDEX_op_shrv_vec:
     case INDEX_op_sarv_vec:
+    case INDEX_op_rotlv_vec:
+    case INDEX_op_rotrv_vec:
         return C_O1_I2(v, v, v);
     case INDEX_op_shls_vec:
     case INDEX_op_shrs_vec:
     case INDEX_op_sars_vec:
+    case INDEX_op_rotls_vec:
         return C_O1_I2(v, v, r);
     case INDEX_op_cmp_vec:
     case INDEX_op_rvv_merge_vec:
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 41c6c446e8..eb5129a976 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -154,10 +154,10 @@ typedef enum {
 #define TCG_TARGET_HAS_not_vec          1
 #define TCG_TARGET_HAS_neg_vec          1
 #define TCG_TARGET_HAS_abs_vec          0
-#define TCG_TARGET_HAS_roti_vec         0
-#define TCG_TARGET_HAS_rots_vec         0
-#define TCG_TARGET_HAS_rotv_vec         0
-#define TCG_TARGET_HAS_shi_vec          0
+#define TCG_TARGET_HAS_roti_vec         -1
+#define TCG_TARGET_HAS_rots_vec         -1
+#define TCG_TARGET_HAS_rotv_vec         -1
+#define TCG_TARGET_HAS_shi_vec          -1
 #define TCG_TARGET_HAS_shs_vec          1
 #define TCG_TARGET_HAS_shv_vec          1
 #define TCG_TARGET_HAS_mul_vec          1
diff --git a/tcg/riscv/tcg-target.opc.h b/tcg/riscv/tcg-target.opc.h
index 2f23453c35..3a010e853e 100644
--- a/tcg/riscv/tcg-target.opc.h
+++ b/tcg/riscv/tcg-target.opc.h
@@ -13,3 +13,6 @@
 
 DEF(rvv_cmpcond_vec, 0, 2, 1, IMPLVEC)
 DEF(rvv_merge_vec, 1, 2, 0, IMPLVEC)
+DEF(rvv_shli_vec, 1, 1, 1, IMPLVEC)
+DEF(rvv_shri_vec, 1, 1, 1, IMPLVEC)
+DEF(rvv_sari_vec, 1, 1, 1, IMPLVEC)
-- 
2.43.0


