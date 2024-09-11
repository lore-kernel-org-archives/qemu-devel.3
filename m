Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6E6EE49B8
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 14:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOK5-00089P-R1; Wed, 11 Sep 2024 10:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1soOJ0-0006L7-AE; Wed, 11 Sep 2024 10:26:57 -0400
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1soOIw-000359-BE; Wed, 11 Sep 2024 10:26:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1726064792; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=8f6YkZ+ioz+svRX9lekPFU3pDZ9Dr096ApWa98Nt/fg=;
 b=DuMqi0RM2+EodaGdhUMFfXbfDlV3jo4T5G3CgOa84BvhqgH3+tLeeG46G6bzMYSYBZizB7FUgDv/HFF3PVGXh1t2rZPaFKUQDHeDis6/aMvhZZymHX/WdpUz9C5Lk4eKGbSfXyEKCKZAYvzVl7IG/fktlM5dzG2nErmhnDfGVT4=
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WEoCcSH_1726061502) by smtp.aliyun-inc.com;
 Wed, 11 Sep 2024 21:31:42 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v4 08/12] tcg/riscv: Implement vector sat/mul ops
Date: Wed, 11 Sep 2024 21:26:26 +0800
Message-Id: <20240911132630.461-9-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240911132630.461-1-zhiwei_liu@linux.alibaba.com>
References: <20240911132630.461-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.119;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-119.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.c.inc | 36 ++++++++++++++++++++++++++++++++++++
 tcg/riscv/tcg-target.h     |  4 ++--
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index cf86f3729c..0a091c12d2 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -281,6 +281,12 @@ typedef enum {
     OPC_VXOR_VI = 0x2c000057 | V_OPIVI,
 
     OPC_VRSUB_VI = 0xc000057 | V_OPIVI,
+    OPC_VMUL_VV = 0x94000057 | V_OPMVV,
+    OPC_VSADD_VV = 0x84000057 | V_OPIVV,
+    OPC_VSSUB_VV = 0x8c000057 | V_OPIVV,
+    OPC_VSADDU_VV = 0x80000057 | V_OPIVV,
+    OPC_VSSUBU_VV = 0x88000057 | V_OPIVV,
+
     OPC_VMSEQ_VV = 0x60000057 | V_OPIVV,
     OPC_VMSEQ_VI = 0x60000057 | V_OPIVI,
     OPC_VMSEQ_VX = 0x60000057 | V_OPIVX,
@@ -2390,6 +2396,26 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         set_vtype_len_sew(s, type, vece);
         tcg_out_opc_vi(s, OPC_VRSUB_VI, a0, a1, 0, true);
         break;
+    case INDEX_op_mul_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv(s, OPC_VMUL_VV, a0, a1, a2, true);
+        break;
+    case INDEX_op_ssadd_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv(s, OPC_VSADD_VV, a0, a1, a2, true);
+        break;
+    case INDEX_op_sssub_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv(s, OPC_VSSUB_VV, a0, a1, a2, true);
+        break;
+    case INDEX_op_usadd_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv(s, OPC_VSADDU_VV, a0, a1, a2, true);
+        break;
+    case INDEX_op_ussub_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv(s, OPC_VSSUBU_VV, a0, a1, a2, true);
+        break;
     case INDEX_op_cmpsel_vec:
         tcg_out_cmpsel(s, type, vece, args[5], a0, a1, a2, const_args[2],
                        args[3], const_args[3], args[4], const_args[4]);
@@ -2434,6 +2460,11 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_xor_vec:
     case INDEX_op_not_vec:
     case INDEX_op_neg_vec:
+    case INDEX_op_mul_vec:
+    case INDEX_op_ssadd_vec:
+    case INDEX_op_sssub_vec:
+    case INDEX_op_usadd_vec:
+    case INDEX_op_ussub_vec:
     case INDEX_op_cmpsel_vec:
         return 1;
     case INDEX_op_cmp_vec:
@@ -2596,6 +2627,11 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_and_vec:
     case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
+    case INDEX_op_mul_vec:
+    case INDEX_op_ssadd_vec:
+    case INDEX_op_sssub_vec:
+    case INDEX_op_usadd_vec:
+    case INDEX_op_ussub_vec:
         return C_O1_I2(v, v, v);
     case INDEX_op_cmp_vec:
         return C_O1_I2(v, v, vL);
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index ae10381e02..1d4d8878ce 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -160,8 +160,8 @@ typedef enum {
 #define TCG_TARGET_HAS_shi_vec          0
 #define TCG_TARGET_HAS_shs_vec          0
 #define TCG_TARGET_HAS_shv_vec          0
-#define TCG_TARGET_HAS_mul_vec          0
-#define TCG_TARGET_HAS_sat_vec          0
+#define TCG_TARGET_HAS_mul_vec          1
+#define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       0
 #define TCG_TARGET_HAS_bitsel_vec       0
 #define TCG_TARGET_HAS_cmpsel_vec       1
-- 
2.43.0


