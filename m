Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F51CD484C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 14:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slr6d-0003lZ-WC; Wed, 04 Sep 2024 10:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1slr6X-0003PL-Jc; Wed, 04 Sep 2024 10:35:30 -0400
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1slr6U-0004nC-D3; Wed, 04 Sep 2024 10:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1725460521; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=YwNh1NhR33CWm9gxOxQNuG8prh3bIgFdxX/Xanaw2TE=;
 b=SUhYQRwwZ4fgddwkG/zqDtABaMYeM0hMRUp24vp480yqF/T/LtewHVtKlrWwLQAvQVahzw176Em6l/wU4xKK2OQNE6uwzUOz5PP5fIYECW7AFOKaaRTFNL/tzoF2kJpFpfwBZcxgYu3eLjlJioWTNF/wiEwQcEgEdnsCYpgkpe0=
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WEI8cfc_1725460519) by smtp.aliyun-inc.com;
 Wed, 04 Sep 2024 22:35:20 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v3 13/14] tcg/riscv: Implement vector roti/v/x shi ops
Date: Wed,  4 Sep 2024 22:27:38 +0800
Message-Id: <20240904142739.854-14-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240904142739.854-1-zhiwei_liu@linux.alibaba.com>
References: <20240904142739.854-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.100;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-100.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
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
 tcg/riscv/tcg-target-con-set.h |  1 +
 tcg/riscv/tcg-target.c.inc     | 86 +++++++++++++++++++++++++++++++++-
 tcg/riscv/tcg-target.h         |  8 ++--
 3 files changed, 90 insertions(+), 5 deletions(-)

diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index cc06102ccf..53649f750c 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -25,5 +25,6 @@ C_O0_I2(v, r)
 C_O1_I1(v, r)
 C_O1_I1(v, v)
 C_O1_I2(v, v, v)
+C_O1_I2(v, v, r)
 C_O1_I2(v, v, vL)
 C_O1_I4(v, v, vL, vK, vK)
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 2dc6befe09..c09055d514 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -316,10 +316,13 @@ typedef enum {
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
@@ -2494,6 +2497,33 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         riscv_set_vec_config_vl_vece(s, type, vece);
         tcg_out_opc_vv(s, OPC_VSRA_VV, a0, a1, a2, true);
         break;
+    case INDEX_op_shli_vec:
+        riscv_set_vec_config_vl_vece(s, type, vece);
+        if (a2 > 31) {
+            tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP0, TCG_REG_ZERO, a2);
+            tcg_out_opc_vx(s, OPC_VSLL_VX, a0, a1, TCG_REG_TMP0, true);
+        } else {
+            tcg_out_opc_vi(s, OPC_VSLL_VI, a0, a1, a2, true);
+        }
+        break;
+    case INDEX_op_shri_vec:
+        riscv_set_vec_config_vl_vece(s, type, vece);
+        if (a2 > 31) {
+            tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP0, TCG_REG_ZERO, a2);
+            tcg_out_opc_vx(s, OPC_VSRL_VX, a0, a1, TCG_REG_TMP0, true);
+        } else {
+            tcg_out_opc_vi(s, OPC_VSRL_VI, a0, a1, a2, true);
+        }
+        break;
+    case INDEX_op_sari_vec:
+        riscv_set_vec_config_vl_vece(s, type, vece);
+        if (a2 > 31) {
+            tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP0, TCG_REG_ZERO, a2);
+            tcg_out_opc_vx(s, OPC_VSRA_VX, a0, a1, TCG_REG_TMP0, true);
+        } else {
+            tcg_out_opc_vi(s, OPC_VSRA_VI, a0, a1, a2, true);
+        }
+        break;
     case INDEX_op_cmpsel_vec:
         TCGArg a3, a4;
         int c3, c4;
@@ -2550,7 +2580,8 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
                        TCGArg a0, ...)
 {
     va_list va;
-    TCGv_vec v0, v1;
+    TCGv_vec v0, v1, v2, t1;
+    TCGv_i32 t2;
     TCGArg a2, a3;
 
     va_start(va, a0);
@@ -2566,6 +2597,45 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
                     tcgv_i64_arg(tcg_constant_i64(-1)),
                     tcgv_i64_arg(tcg_constant_i64(0)), a3);
         break;
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
+        tcg_gen_neg_i32(t2, temp_tcgv_i32(arg_temp(a2)));
+        tcg_gen_shrs_vec(vece, v0, v1, t2);
+        tcg_gen_shls_vec(vece, t1, v1, temp_tcgv_i32(arg_temp(a2)));
+        tcg_gen_or_vec(vece, v0, v0, t1);
+        tcg_temp_free_vec(t1);
+        tcg_temp_free_i32(t2);
+        break;
+    case INDEX_op_rotlv_vec:
+        v2 = temp_tcgv_vec(arg_temp(a2));
+        t1 = tcg_temp_new_vec(type);
+        tcg_gen_neg_vec(vece, t1, v2);
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
+        tcg_gen_neg_vec(vece, t1, v2);
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
@@ -2597,8 +2667,15 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_shlv_vec:
     case INDEX_op_shrv_vec:
     case INDEX_op_sarv_vec:
+    case INDEX_op_shri_vec:
+    case INDEX_op_shli_vec:
+    case INDEX_op_sari_vec:
     case INDEX_op_cmpsel_vec:
         return 1;
+    case INDEX_op_rotls_vec:
+    case INDEX_op_rotlv_vec:
+    case INDEX_op_rotrv_vec:
+    case INDEX_op_rotli_vec:
     case INDEX_op_cmp_vec:
         return -1;
     default:
@@ -2753,6 +2830,10 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
         return C_O1_I1(v, r);
     case INDEX_op_neg_vec:
     case INDEX_op_not_vec:
+    case INDEX_op_rotli_vec:
+    case INDEX_op_shli_vec:
+    case INDEX_op_shri_vec:
+    case INDEX_op_sari_vec:
         return C_O1_I1(v, v);
     case INDEX_op_add_vec:
     case INDEX_op_sub_vec:
@@ -2771,10 +2852,13 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
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
         return C_O1_I2(v, v, vL);
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 3bd8b811ef..082942d858 100644
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
+#define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          1
 #define TCG_TARGET_HAS_shv_vec          1
 #define TCG_TARGET_HAS_mul_vec          1
-- 
2.43.0


