Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0B5CA6012
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 18:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEsfo-0007Yx-8o; Thu, 08 Oct 2026 14:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1xEsfl-0007T5-0S; Thu, 08 Oct 2026 14:16:53 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1xEsfi-0001f1-0b; Thu, 08 Oct 2026 14:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
 ; s=202004.hall;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:Cc:To:From:Content-Type:From:Reply-To:Subject:Content-ID:
 Content-Description:In-Reply-To:References:X-Debbugs-Cc;
 bh=evOi33l1/vsZ2w7RUQwB43mEHaQZjfBnSWh0nn4P7ro=; b=pOp5ehxYu8w24c1/o61/3LU6bV
 QqbZuOQTCBgdGkW8Bps3P/oNxPw9bqTm+FeapGr+VHS88IBq1xagA0zPpxynVs888gKIHkBS+1xtH
 qeV1v7oSpT3RV8kePmrTHiaN0R1Y14iTC29dtnHam+fqq0VFyiBNHctHlSe5aYFHR3U69M8wZYaFq
 Mq5bpzFgXxi9kqitU/jlOqu2bd6si6Ez8yL5la23YgpvmLRyogIz7SXjv4akGHdtkobBOQ5LN0Uuz
 L7V6vWrzrBFGnd3+Q1zW1ZxXpc5tkLJhf/qAuDElaNTrj3isPAuY424kVE+H/sxcoY13LckR0QJa0
 r/4QVr5A==;
Received: from authenticated user by hall.aurel32.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.98.2)
 (envelope-from <aurelien@aurel32.net>) id 1xEsfW-0000000AwBv-1Efn;
 Thu, 08 Oct 2026 20:16:38 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG target),
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH] tcg/riscv64: Remove vector min/max ops with immediates
Date: Thu,  8 Oct 2026 20:16:10 +0200
Message-ID: <20261008181611.3015838-1-aurelien@aurel32.net>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:bc8:30d7:100::1;
 envelope-from=aurelien@aurel32.net; helo=hall.aurel32.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RVV 1.0 only defines vmin, vminu, vmax and vmaxu instructions for the
vector-vector and vector-scalar case, not the for vector-immediate case.
Remove the immediate variant from TCG code generation.

Fixes: 1631f19b04fe ("tcg/riscv: Implement vector min/max ops")
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 tcg/riscv64/tcg-target.c.inc | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index de9a3570b2..14a397117a 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -306,13 +306,9 @@ typedef enum {
     OPC_VSSUBU_VI = 0x88000057 | V_OPIVI,
 
     OPC_VMAX_VV = 0x1c000057 | V_OPIVV,
-    OPC_VMAX_VI = 0x1c000057 | V_OPIVI,
     OPC_VMAXU_VV = 0x18000057 | V_OPIVV,
-    OPC_VMAXU_VI = 0x18000057 | V_OPIVI,
     OPC_VMIN_VV = 0x14000057 | V_OPIVV,
-    OPC_VMIN_VI = 0x14000057 | V_OPIVI,
     OPC_VMINU_VV = 0x10000057 | V_OPIVV,
-    OPC_VMINU_VI = 0x10000057 | V_OPIVI,
 
     OPC_VMSEQ_VV = 0x60000057 | V_OPIVV,
     OPC_VMSEQ_VI = 0x60000057 | V_OPIVI,
@@ -2810,19 +2806,19 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         break;
     case INDEX_op_smax_vec:
         set_vtype_len_sew(s, type, vece);
-        tcg_out_opc_vv_vi(s, OPC_VMAX_VV, OPC_VMAX_VI, a0, a1, a2, c2);
+        tcg_out_opc_vv(s, OPC_VMAX_VV, a0, a1, a2);
         break;
     case INDEX_op_smin_vec:
         set_vtype_len_sew(s, type, vece);
-        tcg_out_opc_vv_vi(s, OPC_VMIN_VV, OPC_VMIN_VI, a0, a1, a2, c2);
+        tcg_out_opc_vv(s, OPC_VMIN_VV, a0, a1, a2);
         break;
     case INDEX_op_umax_vec:
         set_vtype_len_sew(s, type, vece);
-        tcg_out_opc_vv_vi(s, OPC_VMAXU_VV, OPC_VMAXU_VI, a0, a1, a2, c2);
+        tcg_out_opc_vv(s, OPC_VMAXU_VV, a0, a1, a2);
         break;
     case INDEX_op_umin_vec:
         set_vtype_len_sew(s, type, vece);
-        tcg_out_opc_vv_vi(s, OPC_VMINU_VV, OPC_VMINU_VI, a0, a1, a2, c2);
+        tcg_out_opc_vv(s, OPC_VMINU_VV, a0, a1, a2);
         break;
     case INDEX_op_shls_vec:
         set_vtype_len_sew(s, type, vece);
@@ -2974,10 +2970,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sssub_vec:
     case INDEX_op_usadd_vec:
     case INDEX_op_ussub_vec:
-    case INDEX_op_smax_vec:
-    case INDEX_op_smin_vec:
-    case INDEX_op_umax_vec:
-    case INDEX_op_umin_vec:
         return C_O1_I2(v, v, vK);
     case INDEX_op_sub_vec:
         return C_O1_I2(v, vK, v);
@@ -2987,6 +2979,10 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sarv_vec:
     case INDEX_op_rotlv_vec:
     case INDEX_op_rotrv_vec:
+    case INDEX_op_smax_vec:
+    case INDEX_op_smin_vec:
+    case INDEX_op_umax_vec:
+    case INDEX_op_umin_vec:
         return C_O1_I2(v, v, v);
     case INDEX_op_shls_vec:
     case INDEX_op_shrs_vec:
-- 
2.53.0


