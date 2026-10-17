Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D0DCCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI9ed-00087c-Rn; Sat, 17 Oct 2026 15:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9dz-0006Dk-MS; Sat, 17 Oct 2026 15:00:37 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9dy-0004Gi-0h; Sat, 17 Oct 2026 15:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792263422; bh=BZJu4URBLdBr7Z7aHjzSCqrfILnRF6fUTjCqT4kRgfY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lNS2QzBqHmynN6S91ajkLm07M8v4dkYQ+xo62YM0LupG0wev9dR+wCxRhnvYK492V
 Wu6RAPatLvC29vjHPde0Y31pYEf8iee00BUrUIh+LSrg1c/CCASCEHgtSfmvkdID2r
 qLxtqeOOteRtMpqnSa02OZahy+WISyXc0VA97A8g4znyVU/d7lncvg6yqSu+IiCEav
 o4WsEwUf5baxuBIbzhvakMeaxqdRD0BXMEBw+d4s8pjeYu9N1Aqmf/umN2JFLRoTFR
 DLL3Mj7ND13LuQW8Qob3inwcyyxqnkE1rY2qfGjVZUJ7rnDMhFn63JBcMaVgh8n3NL
 iSjcSvrgKBc/g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A04CF1DE6D7;
 Sat, 17 Oct 2026 21:57:02 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7D83044339F;
 Sat, 17 Oct 2026 21:57:01 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 52/63] tcg/riscv64: Remove vector min/max ops with
 immediates
Date: Sat, 17 Oct 2026 21:55:08 +0300
Message-ID: <20261017185528.722197-52-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Aurelien Jarno <aurelien@aurel32.net>

RVV 1.0 only defines vmin, vminu, vmax and vmaxu instructions for the
vector-vector and vector-scalar case, not the for vector-immediate case.
Remove the immediate variant from TCG code generation.

Fixes: 1631f19b04fe ("tcg/riscv: Implement vector min/max ops")
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261008181611.3015838-1-aurelien@aurel32.net>
(cherry picked from commit 306d9ab85fdbbc626c067777cea70dccec22dae9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 4e2cc24a86..9a6662948c 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -301,13 +301,9 @@ typedef enum {
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
@@ -2492,19 +2488,19 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
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
@@ -2792,10 +2788,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
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
@@ -2805,6 +2797,10 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
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
2.47.3


