Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B40CD37B4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 14:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slr5X-0006L1-Ot; Wed, 04 Sep 2024 10:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1slr5T-00060S-4P; Wed, 04 Sep 2024 10:34:23 -0400
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1slr5R-0004JS-7y; Wed, 04 Sep 2024 10:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1725460458; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=S3cfLICiYQsX/UnZxHC9ym1YQjXjFRtv178sjIgitP4=;
 b=Y+WUE9/oYBSpLIJB9m1cBUUX+QRYxITh505D6kPwAtn/z4H82Nc+//RxeqkrNlW34k+Vakh8v9jwQnEfetjnToEnrZ776tdPxprZSAeDKlx8ct7zGs6Jtywz/AJALP3nw5fBQUBPxr1VbRgkGueRog2QFNBMZGhA+iinZn4eOls=
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WEHyKUn_1725460455) by smtp.aliyun-inc.com;
 Wed, 04 Sep 2024 22:34:17 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v3 11/14] tcg/riscv: Implement vector min/max ops
Date: Wed,  4 Sep 2024 22:27:36 +0800
Message-Id: <20240904142739.854-12-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240904142739.854-1-zhiwei_liu@linux.alibaba.com>
References: <20240904142739.854-1-zhiwei_liu@linux.alibaba.com>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.c.inc | 29 +++++++++++++++++++++++++++++
 tcg/riscv/tcg-target.h     |  2 +-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index c31f92731c..507f659fd6 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -287,6 +287,11 @@ typedef enum {
     OPC_VSADDU_VV = 0x80000057 | V_OPIVV,
     OPC_VSSUBU_VV = 0x88000057 | V_OPIVV,
 
+    OPC_VMAX_VV = 0x1c000057 | V_OPIVV,
+    OPC_VMAXU_VV = 0x18000057 | V_OPIVV,
+    OPC_VMIN_VV = 0x14000057 | V_OPIVV,
+    OPC_VMINU_VV = 0x10000057 | V_OPIVV,
+
     OPC_VMSEQ_VV = 0x60000057 | V_OPIVV,
     OPC_VMSEQ_VI = 0x60000057 | V_OPIVI,
     OPC_VMSEQ_VX = 0x60000057 | V_OPIVX,
@@ -2442,6 +2447,22 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         riscv_set_vec_config_vl_vece(s, type, vece);
         tcg_out_opc_vv(s, OPC_VSSUBU_VV, a0, a1, a2, true);
         break;
+    case INDEX_op_smax_vec:
+        riscv_set_vec_config_vl_vece(s, type, vece);
+        tcg_out_opc_vv(s, OPC_VMAX_VV, a0, a1, a2, true);
+        break;
+    case INDEX_op_smin_vec:
+        riscv_set_vec_config_vl_vece(s, type, vece);
+        tcg_out_opc_vv(s, OPC_VMIN_VV, a0, a1, a2, true);
+        break;
+    case INDEX_op_umax_vec:
+        riscv_set_vec_config_vl_vece(s, type, vece);
+        tcg_out_opc_vv(s, OPC_VMAXU_VV, a0, a1, a2, true);
+        break;
+    case INDEX_op_umin_vec:
+        riscv_set_vec_config_vl_vece(s, type, vece);
+        tcg_out_opc_vv(s, OPC_VMINU_VV, a0, a1, a2, true);
+        break;
     case INDEX_op_cmpsel_vec:
         TCGArg a3, a4;
         int c3, c4;
@@ -2535,6 +2556,10 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_sssub_vec:
     case INDEX_op_usadd_vec:
     case INDEX_op_ussub_vec:
+    case INDEX_op_smax_vec:
+    case INDEX_op_smin_vec:
+    case INDEX_op_umax_vec:
+    case INDEX_op_umin_vec:
     case INDEX_op_cmpsel_vec:
         return 1;
     case INDEX_op_cmp_vec:
@@ -2702,6 +2727,10 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_sssub_vec:
     case INDEX_op_usadd_vec:
     case INDEX_op_ussub_vec:
+    case INDEX_op_smax_vec:
+    case INDEX_op_smin_vec:
+    case INDEX_op_umax_vec:
+    case INDEX_op_umin_vec:
         return C_O1_I2(v, v, v);
     case INDEX_op_cmp_vec:
         return C_O1_I2(v, v, vL);
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 1d4d8878ce..7005099810 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -162,7 +162,7 @@ typedef enum {
 #define TCG_TARGET_HAS_shv_vec          0
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_sat_vec          1
-#define TCG_TARGET_HAS_minmax_vec       0
+#define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       0
 #define TCG_TARGET_HAS_cmpsel_vec       1
 
-- 
2.43.0


