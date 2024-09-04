Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4E7CD37B4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 14:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slr53-00023D-Tk; Wed, 04 Sep 2024 10:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1slr4V-0008DO-QN; Wed, 04 Sep 2024 10:33:25 -0400
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1slr4T-00048x-TF; Wed, 04 Sep 2024 10:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1725460395; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=9Is84xL1a+Sa/cjicvcfckfj19Ppv8IMDk6v/y8fwlE=;
 b=B/anqjC2Q1oKPF7WEOshwcLMDFZ0lCr4lHdzR+GkLo+Z9g7tQZKD6flDbn8dlcv90dsooZYTJupCl+v4ZoOe3DaZkvoHj1nQnUzV0K4AP7V7gvxA/ZiPIdotJ+YNGDfXfRJURhWah9S5D1Ecd/UTCxyXxnV9zzMHsGjfPI4g34Y=
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WEIASpc_1725460392) by smtp.aliyun-inc.com;
 Wed, 04 Sep 2024 22:33:13 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v3 09/14] tcg/riscv: Implement vector neg ops
Date: Wed,  4 Sep 2024 22:27:34 +0800
Message-Id: <20240904142739.854-10-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240904142739.854-1-zhiwei_liu@linux.alibaba.com>
References: <20240904142739.854-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
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
 tcg/riscv/tcg-target.c.inc | 7 +++++++
 tcg/riscv/tcg-target.h     | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 37909e56fb..60a5a21ff5 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -280,6 +280,7 @@ typedef enum {
     OPC_VXOR_VV = 0x2c000057 | V_OPIVV,
     OPC_VXOR_VI = 0x2c000057 | V_OPIVI,
 
+    OPC_VRSUB_VI = 0xc000057 | V_OPIVI,
     OPC_VMSEQ_VV = 0x60000057 | V_OPIVV,
     OPC_VMSEQ_VI = 0x60000057 | V_OPIVI,
     OPC_VMSEQ_VX = 0x60000057 | V_OPIVX,
@@ -2411,6 +2412,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         riscv_set_vec_config_vl(s, type);
         tcg_out_opc_vi(s, OPC_VXOR_VI, a0, a1, -1, true);
         break;
+    case INDEX_op_neg_vec:
+        riscv_set_vec_config_vl_vece(s, type, vece);
+        tcg_out_opc_vi(s, OPC_VRSUB_VI, a0, a1, 0, true);
+        break;
     case INDEX_op_cmpsel_vec:
         TCGArg a3, a4;
         int c3, c4;
@@ -2498,6 +2503,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
     case INDEX_op_not_vec:
+    case INDEX_op_neg_vec:
     case INDEX_op_cmpsel_vec:
         return 1;
     case INDEX_op_cmp_vec:
@@ -2652,6 +2658,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_dupm_vec:
     case INDEX_op_ld_vec:
         return C_O1_I1(v, r);
+    case INDEX_op_neg_vec:
     case INDEX_op_not_vec:
         return C_O1_I1(v, v);
     case INDEX_op_add_vec:
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 94034504b2..ae10381e02 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -152,7 +152,7 @@ typedef enum {
 #define TCG_TARGET_HAS_nor_vec          0
 #define TCG_TARGET_HAS_eqv_vec          0
 #define TCG_TARGET_HAS_not_vec          1
-#define TCG_TARGET_HAS_neg_vec          0
+#define TCG_TARGET_HAS_neg_vec          1
 #define TCG_TARGET_HAS_abs_vec          0
 #define TCG_TARGET_HAS_roti_vec         0
 #define TCG_TARGET_HAS_rots_vec         0
-- 
2.43.0


