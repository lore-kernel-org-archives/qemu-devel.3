Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C038FC52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 11:39:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdps9-0003IG-6k; Tue, 13 Aug 2024 07:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sdps4-0002ys-Rw; Tue, 13 Aug 2024 07:39:25 -0400
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sdps2-0002qB-7l; Tue, 13 Aug 2024 07:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1723549156; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=s41auOvuvSWYkWZrV+6/i6p4nZMm5ePpik2bsZvhZIE=;
 b=A2FWrD5M8rk7JxZCDxwAc0u1OYT6ySYZoF4DR4m5i/9rgDsWaMvK8z8MUo3EFrEOQSnhNUUZLn2tWF2qpwzMhqUbATgEzOVhZ/OgHJRPngrhi36XJktVXj6qnhlC7tQcAb4mXOZrBPUK+JZspnKFIGEHQ/Krqg2KhSBriyMLLeM=
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WCouBRU_1723549154) by smtp.aliyun-inc.com;
 Tue, 13 Aug 2024 19:39:15 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v1 08/15] tcg/riscv: Add support for basic vector opcodes
Date: Tue, 13 Aug 2024 19:34:29 +0800
Message-Id: <20240813113436.831-9-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
References: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.118;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-118.freemail.mail.aliyun.com
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
 tcg/riscv/tcg-target.c.inc     | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index d73a62b0f2..8a0de18257 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -23,3 +23,4 @@ C_O1_I4(r, r, rI, rM, rM)
 C_O2_I4(r, r, rZ, rZ, rM, rM)
 C_O0_I2(v, r)
 C_O1_I1(v, r)
+C_O1_I2(v, v, v)
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index f60913e805..650b5eff1a 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -289,6 +289,12 @@ typedef enum {
     OPC_VSE32_V = 0x6027 | V_SUMOP,
     OPC_VSE64_V = 0x7027 | V_SUMOP,
 
+    OPC_VADD_VV = 0x57 | V_OPIVV,
+    OPC_VSUB_VV = 0x8000057 | V_OPIVV,
+    OPC_VAND_VV = 0x24000057 | V_OPIVV,
+    OPC_VOR_VV = 0x28000057 | V_OPIVV,
+    OPC_VXOR_VV = 0x2c000057 | V_OPIVV,
+
     OPC_VMV_V_V = 0x5e000057 | V_OPIVV,
     OPC_VMV_V_I = 0x5e000057 | V_OPIVI,
     OPC_VMV_V_X = 0x5e000057 | V_OPIVX,
@@ -2158,6 +2164,21 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_st_vec:
         tcg_out_st(s, type, a0, a1, a2);
         break;
+    case INDEX_op_add_vec:
+        tcg_out_opc_vv(s, OPC_VADD_VV, a0, a1, a2, true);
+        break;
+    case INDEX_op_sub_vec:
+        tcg_out_opc_vv(s, OPC_VSUB_VV, a0, a1, a2, true);
+        break;
+    case INDEX_op_and_vec:
+        tcg_out_opc_vv(s, OPC_VAND_VV, a0, a1, a2, true);
+        break;
+    case INDEX_op_or_vec:
+        tcg_out_opc_vv(s, OPC_VOR_VV, a0, a1, a2, true);
+        break;
+    case INDEX_op_xor_vec:
+        tcg_out_opc_vv(s, OPC_VXOR_VV, a0, a1, a2, true);
+        break;
     case INDEX_op_mov_vec: /* Always emitted via tcg_out_mov.  */
     case INDEX_op_dup_vec: /* Always emitted via tcg_out_dup_vec.  */
     default:
@@ -2177,6 +2198,12 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
 int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
 {
     switch (opc) {
+    case INDEX_op_add_vec:
+    case INDEX_op_sub_vec:
+    case INDEX_op_and_vec:
+    case INDEX_op_or_vec:
+    case INDEX_op_xor_vec:
+        return 1;
     default:
         return 0;
     }
@@ -2327,6 +2354,12 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_dupm_vec:
     case INDEX_op_ld_vec:
         return C_O1_I1(v, r);
+    case INDEX_op_add_vec:
+    case INDEX_op_sub_vec:
+    case INDEX_op_and_vec:
+    case INDEX_op_or_vec:
+    case INDEX_op_xor_vec:
+        return C_O1_I2(v, v, v);
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


