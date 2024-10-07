Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24FDCFB424
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 03:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxe0m-0008Ie-Os; Sun, 06 Oct 2024 23:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sxe0j-0008E5-Ot; Sun, 06 Oct 2024 23:02:13 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sxe0h-00039O-CB; Sun, 06 Oct 2024 23:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1728270106; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=1BwZTo2Gv9JmjGRLj61qhmQffATv4Z1KiVQQa2ozVQQ=;
 b=nFTGs4FfOaH/L1vSvpLSVADYKb9OBUgXcsRZUYMyIxRCdqMe7LYSCRX7AX44z9bA1zX0omwebwgIRTmqmHlV2Fw9VZweKxUshQkb5Gmge1sJMiVuP4p/MnpBrVzSdMRHAzURpn0f849TJWw1LW3naLoWySX8/IeRNIx2PdHHN0c=
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WGLSSQn_1728270103) by smtp.aliyun-inc.com;
 Mon, 07 Oct 2024 11:01:44 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 richard.henderson@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v5 09/12] tcg/riscv: Implement vector min/max ops
Date: Mon,  7 Oct 2024 10:56:57 +0800
Message-Id: <20241007025700.47259-10-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241007025700.47259-1-zhiwei_liu@linux.alibaba.com>
References: <20241007025700.47259-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.132;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-132.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.c.inc | 29 +++++++++++++++++++++++++++++
 tcg/riscv/tcg-target.h     |  2 +-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 0b2541692a..fd9a079d53 100644
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
@@ -2432,6 +2437,22 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         set_vtype_len_sew(s, type, vece);
         tcg_out_opc_vv(s, OPC_VSSUBU_VV, a0, a1, a2, true);
         break;
+    case INDEX_op_smax_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv(s, OPC_VMAX_VV, a0, a1, a2, true);
+        break;
+    case INDEX_op_smin_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv(s, OPC_VMIN_VV, a0, a1, a2, true);
+        break;
+    case INDEX_op_umax_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv(s, OPC_VMAXU_VV, a0, a1, a2, true);
+        break;
+    case INDEX_op_umin_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv(s, OPC_VMINU_VV, a0, a1, a2, true);
+        break;
     case INDEX_op_cmpsel_vec:
         tcg_out_cmpsel(s, type, vece, args[5], a0, a1, a2, const_args[2],
                        args[3], const_args[3], args[4], const_args[4]);
@@ -2481,6 +2502,10 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
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
@@ -2648,6 +2673,10 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
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


