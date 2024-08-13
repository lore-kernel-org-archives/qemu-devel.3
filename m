Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C6AC52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 11:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdptF-0008GO-1K; Tue, 13 Aug 2024 07:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sdpt8-0007xt-2y; Tue, 13 Aug 2024 07:40:30 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sdpt6-0003GB-6V; Tue, 13 Aug 2024 07:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1723549219; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=nnKMM2MC1SMQYBJ/VRtsUYtNfI60eaUGG26OupLLaDE=;
 b=d3wndni8mnuIRimVr1nuG7SDbyGXQ8t5YyZbOCiTz3JTK+E69AxSCw4wm0cc3yohLI9f55eX0EYUJKwcpjNlD7i8b3MIvbqHt1j/4UzDF3AEcbBltfxFPuvl6VFw5C+gHvr62KmjTX4hzoa4dvz0nqtm5a93dzkhEtuhqtsdSWo=
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WCovfQE_1723549217) by smtp.aliyun-inc.com;
 Tue, 13 Aug 2024 19:40:18 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v1 10/15] tcg/riscv: Implement vector not/neg ops
Date: Tue, 13 Aug 2024 19:34:31 +0800
Message-Id: <20240813113436.831-11-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
References: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.133;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-133.freemail.mail.aliyun.com
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
 tcg/riscv/tcg-target-con-set.h |  1 +
 tcg/riscv/tcg-target.c.inc     | 13 +++++++++++++
 tcg/riscv/tcg-target.h         |  4 ++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index 23b391dd07..781b18a09e 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -24,5 +24,6 @@ C_O2_I4(r, r, rZ, rZ, rM, rM)
 C_O0_I2(v, r)
 C_O0_I2(v, vK)
 C_O1_I1(v, r)
+C_O1_I1(v, v)
 C_O1_I2(v, v, v)
 C_O1_I2(v, v, vK)
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 3f1e215e90..a33c634dbb 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -306,7 +306,9 @@ typedef enum {
     OPC_VAND_VV = 0x24000057 | V_OPIVV,
     OPC_VOR_VV = 0x28000057 | V_OPIVV,
     OPC_VXOR_VV = 0x2c000057 | V_OPIVV,
+    OPC_VXOR_VI = 0x2c000057 | V_OPIVI,
 
+    OPC_VRSUB_VX = 0xc000057 | V_OPIVX,
     OPC_VMSEQ_VV = 0x60000057 | V_OPIVV,
     OPC_VMSEQ_VI = 0x60000057 | V_OPIVI,
     OPC_VMSEQ_VX = 0x60000057 | V_OPIVX,
@@ -2312,6 +2314,12 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_xor_vec:
         tcg_out_opc_vv(s, OPC_VXOR_VV, a0, a1, a2, true);
         break;
+    case INDEX_op_not_vec:
+        tcg_out_opc_vi(s, OPC_VXOR_VI, a0, a1, -1, true);
+        break;
+    case INDEX_op_neg_vec:
+        tcg_out_opc_vx(s, OPC_VRSUB_VX, a0, a1, TCG_REG_ZERO, true);
+        break;
     case INDEX_op_rvv_cmpcond_vec:
         {
             RISCVInsn op;
@@ -2384,6 +2392,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_and_vec:
     case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
+    case INDEX_op_not_vec:
+    case INDEX_op_neg_vec:
         return 1;
     case INDEX_op_cmp_vec:
         return -1;
@@ -2537,6 +2547,9 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_dupm_vec:
     case INDEX_op_ld_vec:
         return C_O1_I1(v, r);
+    case INDEX_op_neg_vec:
+    case INDEX_op_not_vec:
+        return C_O1_I1(v, v);
     case INDEX_op_add_vec:
     case INDEX_op_sub_vec:
     case INDEX_op_and_vec:
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 12a7a37aaa..401696d639 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -151,8 +151,8 @@ typedef enum {
 #define TCG_TARGET_HAS_nand_vec         0
 #define TCG_TARGET_HAS_nor_vec          0
 #define TCG_TARGET_HAS_eqv_vec          0
-#define TCG_TARGET_HAS_not_vec          0
-#define TCG_TARGET_HAS_neg_vec          0
+#define TCG_TARGET_HAS_not_vec          1
+#define TCG_TARGET_HAS_neg_vec          1
 #define TCG_TARGET_HAS_abs_vec          0
 #define TCG_TARGET_HAS_roti_vec         0
 #define TCG_TARGET_HAS_rots_vec         0
-- 
2.43.0


