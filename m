Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B32C606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=NNtJiDwR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWoxB-00004r-Lh; Fri, 27 Nov 2026 00:57:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWowx-0007sY-O8; Fri, 27 Nov 2026 00:56:49 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWowu-000185-KR; Fri, 27 Nov 2026 00:56:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758873; bh=5EmZNyptYjSuLbZUcYnB8xLz+WD0c7sCN63/HOs5o6c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NNtJiDwRAV+l3/UI+pV5OHcalvrW9p5O7LiWCwWTRRbuCRra4WPY6EXcFRObvk5kh
 ScdZe4n30sauE+OwclwDNiknoswUZ5x+fV0dq8VkKqhyg2WOG9iNF6PdcjqV7q+Ceo
 znFG1SuvRR0ekoOZi97tnXW3pnsn7KcXF/rjxHp+4FTdGwA7C3SCXLB2axSbo9ey3r
 vXQhZfsxPcgDSDZaaVwsPA+6dj362BOjNjYKlPgOtbEtJLhAP/hbblUR/uvZaCj3Zc
 oGopBQIhwz3n9NW8ca3/MzOB0Q32avkT0v+JOsP4JARZihwfiSv+PJo1PzAce9Sm/m
 sCAnUdLHhGOXw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F2CD41EA2DD;
 Fri, 27 Nov 2026 08:54:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EFCEB46991A;
 Fri, 27 Nov 2026 08:54:33 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id DA8D7CF240; Fri, 27 Nov 2026 08:54:33 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 085/140] tcg/riscv64: Fix logical vector immediate
 matching and emission
Date: Fri, 27 Nov 2026 08:53:11 +0300
Message-ID: <20261127055421.39015-26-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

and/or/xor_vec are bitwise, so the generic layer doesn't track a
meaningful VECE for them (it is always 0). The backend nevertheless
matched the constant as a byte element, and emitted the .vi form at
whatever SEW the previous op left behind:
"bic v4.8h, #0xf0" became "vand.vi ..., 15".

Add the 'N' constraint: find the smallest element size at which the
constant replicates; the constant matches if that element fits simm5.
The emitter then sets SEW to that size. A wider element can't fit
when the smallest doesn't: its upper half repeats the smaller
element, which would then be 0 or -1.

Cc: qemu-stable@nongnu.org
Fixes: 5a63f5998791 ("tcg/riscv: Add support for basic vector opcodes")
Reported-by: Aurelien Jarno <aurelien@aurel32.net>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20261028143330.6518-6-philmd@oss.qualcomm.com>
(cherry picked from commit d472efd0f1f126642ca54ac45d531e9befa73499)
(Mjt: fixup TCG_CT_CONST_LOGICAL_VI definition in tcg/riscv/tcg-target.c.inc
 and tcg/riscv/tcg-target-con-str.h to avoid clash with other defines in 10.0)
(Mjt: also pick up vec_imm() function from 6d09dfabf5174a63db73b1afdb80e0e32f453aef)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

ch

diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index e92e8154916..ba909f4b02f 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -29,4 +29,5 @@ C_O1_I2(v, v, v)
 C_O1_I2(v, vK, v)
 C_O1_I2(v, v, vK)
 C_O1_I2(v, v, vL)
+C_O1_I2(v, v, vN)
 C_O1_I4(v, v, vL, vK, vK)
diff --git a/tcg/riscv/tcg-target-con-str.h b/tcg/riscv/tcg-target-con-str.h
index 2f9700638c4..194649ec218 100644
--- a/tcg/riscv/tcg-target-con-str.h
+++ b/tcg/riscv/tcg-target-con-str.h
@@ -21,3 +21,4 @@ CONST('K', TCG_CT_CONST_S5)
 CONST('L', TCG_CT_CONST_CMP_VI)
 CONST('N', TCG_CT_CONST_N12)
 CONST('M', TCG_CT_CONST_M12)
+CONST('O', TCG_CT_CONST_LOGICAL_VI)
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 9a6662948c3..23ad54806fc 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -118,6 +118,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define TCG_CT_CONST_J12     0x800
 #define TCG_CT_CONST_S5     0x1000
 #define TCG_CT_CONST_CMP_VI 0x2000
+#define TCG_CT_CONST_LOGICAL_VI 0x4000
 
 #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
 #define ALL_VECTOR_REGS    MAKE_64BIT_MASK(32, 32)
@@ -379,6 +380,22 @@ static const struct {
     [TCG_COND_GEU] = { OPC_VMSGTU_VI,   1, 16, true  },
 };
 
+/*
+ * Return the element size at which VAL is a replicated simm5,
+ * or -1 if there is none.  Used for vector logical ops, whose
+ * VECE is not meaningful.
+ */
+static int vec_logical_immediate_vece(int64_t val)
+{
+    for (int e = MO_8; e <= MO_64; e++) {
+        if (val == dup_const(e, val)) {
+            int64_t x = sextract64(val, 0, 8 << e);
+            return x >= -0x10 && x <= 0x0f ? e : -1;
+        }
+    }
+    g_assert_not_reached();
+}
+
 /* test if a constant matches the constraint */
 static bool tcg_target_const_match(int64_t val, int ct,
                                    TCGType type, TCGCond cond, int vece)
@@ -386,6 +403,10 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if (ct & TCG_CT_CONST) {
         return 1;
     }
+    if ((ct & TCG_CT_CONST_LOGICAL_VI) &&
+        vec_logical_immediate_vece(val) >= 0) {
+        return true;
+    }
     if (type >= TCG_TYPE_V64) {
         /* Val is replicated by VECE; extract the highest element. */
         val >>= (-8 << vece) & 63;
@@ -706,6 +727,12 @@ static void tcg_out_opc_vi(TCGContext *s, RISCVInsn opc,
     tcg_out32(s, encode_vi(opc, vd, imm, vs2, true));
 }
 
+/* Constants are replicated by VECE; extract one element for .vi forms. */
+static int64_t vec_imm(TCGArg arg, unsigned vece)
+{
+    return sextract64(arg, 0, 8 << vece);
+}
+
 static void tcg_out_opc_vv_vi(TCGContext *s, RISCVInsn o_vv, RISCVInsn o_vi,
                               TCGReg vd, TCGReg vs2, TCGArg vi1, int c_vi1)
 {
@@ -2410,6 +2437,23 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     }
 }
 
+static void tcg_out_opc_vv_vi_logical(TCGContext *s, TCGType type,
+                                      RISCVInsn o_vv, RISCVInsn o_vi,
+                                      TCGReg vd, TCGReg vs2,
+                                      TCGArg vi1, int c_vi1)
+{
+    if (c_vi1) {
+        int vece = vec_logical_immediate_vece(vi1);
+
+        tcg_debug_assert(vece >= 0);
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vi(s, o_vi, vd, vs2, vec_imm(vi1, vece));
+    } else {
+        set_vtype_len(s, type);
+        tcg_out_opc_vv(s, o_vv, vd, vs2, vi1);
+    }
+}
+
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            unsigned vecl, unsigned vece,
                            const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2447,16 +2491,16 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         }
         break;
     case INDEX_op_and_vec:
-        set_vtype_len(s, type);
-        tcg_out_opc_vv_vi(s, OPC_VAND_VV, OPC_VAND_VI, a0, a1, a2, c2);
+        tcg_out_opc_vv_vi_logical(s, type, OPC_VAND_VV, OPC_VAND_VI,
+                                  a0, a1, a2, c2);
         break;
     case INDEX_op_or_vec:
-        set_vtype_len(s, type);
-        tcg_out_opc_vv_vi(s, OPC_VOR_VV, OPC_VOR_VI, a0, a1, a2, c2);
+        tcg_out_opc_vv_vi_logical(s, type, OPC_VOR_VV, OPC_VOR_VI,
+                                  a0, a1, a2, c2);
         break;
     case INDEX_op_xor_vec:
-        set_vtype_len(s, type);
-        tcg_out_opc_vv_vi(s, OPC_VXOR_VV, OPC_VXOR_VI, a0, a1, a2, c2);
+        tcg_out_opc_vv_vi_logical(s, type, OPC_VXOR_VV, OPC_VXOR_VI,
+                                  a0, a1, a2, c2);
         break;
     case INDEX_op_not_vec:
         set_vtype_len(s, type);
@@ -2780,10 +2824,11 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sari_vec:
     case INDEX_op_rotli_vec:
         return C_O1_I1(v, v);
-    case INDEX_op_add_vec:
     case INDEX_op_and_vec:
     case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
+        return C_O1_I2(v, v, vN);
+    case INDEX_op_add_vec:
     case INDEX_op_ssadd_vec:
     case INDEX_op_sssub_vec:
     case INDEX_op_usadd_vec:
-- 
2.47.3


