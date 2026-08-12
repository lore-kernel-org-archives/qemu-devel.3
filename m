Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D64C5AC67
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 00:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtwst-00043u-GF; Tue, 11 Aug 2026 20:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtwsr-00043d-VG
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 20:31:53 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtwsq-0000T5-2Y
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 20:31:53 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-84e27035206so86052b3a.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 17:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786494710; x=1787099510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RH8No/RX2kZXf8IsOLgYzc6hqLZ0AnrkKHzKl/VSgOc=;
 b=BzbjZeIA3OPvY0YYWOFeoLmh03NqXknqsN0NKJwznLJ9kRLTGkA4shr5gWey3Ee5Yo
 xhEnJYZACSm5Zuwc0woAT76wN7fjGU8CCXIoiHz0yMWYNgsKvwFB1K7s/827H20CMmlk
 e8+jVw0JmJr9P/CKebQI+JiZUIiQPXRKzgIfmY7VlMigOC1EV8HGFU5HpvYCFZ44OHq9
 X+en4oAHBb1H1CLILySMtpcu16QgRcr9a+ZQNciPHj3UrimQsDgm5gJ2nZNS1phWhF6b
 Obboa79t+diKeR1Dc/OvFyXkSIIfcDQlG+5L6c9Mni8Pd25kgSWRmJ+hqT82qDe7C+Bo
 Ug6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786494710; x=1787099510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RH8No/RX2kZXf8IsOLgYzc6hqLZ0AnrkKHzKl/VSgOc=;
 b=ZnipKAp7qkGVfzSjS9l+YQlHP5JI8V8JMNyYcH+gPjh1/0YvyPiehbQ+2RwlnEyxFj
 OXMltJjKsnTdW+4RvkGKIrnaagGybbBTaUMyDrVC8MZ2yve2pcojOs5RbL3teTkzIYBa
 qdOllv5LBElX10gKXKmmS1eRFkOg+E9wrWt/llJBrRd57w54oF+yP3AChLA1kH41jacl
 O4gnKBycSgdtfCN7P4TkoHk/4QwnDdtc5KaCnRnS+yZQIYqs3aw4QV/S9cu4zIgA4d+f
 0zBteixHGgDkUUEC2bJ2EqhjYyXWhtaLcPQpEXCSK8rqdvDCgIrWqpTb5vZ4XyEZUUE3
 92PA==
X-Gm-Message-State: AOJu0YyMBh293CAgh+l3ir9XXdqVnf6Mx4+jRCLZzrTsDBDJHhOvUheG
 IyFZ36mxQva5ESFcDhuooI45Wywf8zs3o5SbQRetH6e0oai7m3SRLLh5GwPxbMDyMQfzG93XKe2
 aCYlU
X-Gm-Gg: AR+sD124eSuTqSJOZV90hSyvaWN4Yaay87a4qlcQ7BlOhY32k7Waik/K+wRMnDGbAKG
 pUJaBEUJGtJjLFa8JS/Rq0Chk7PUs9iCiD6ONW5qjeEp1X31ieKV77aMqCW9kYddrKeUvEFY2cW
 QnCNv2maoqfdXdenfy5TQIsEhj/iXnYmgub9ksZFbXEq4xU5cpH4EyvUZC36U/s3QdStn/iXtFq
 6fkj8mwn0rxDw0fR9Yp3VaMSqj5RDrI4Ypb9lpaJSFcNlAyxk7cWfC72Ks6qfGqMTMcucF7H3ON
 4X4MsVfPbGAu1z1URE9PR6hDFGjBN503CeknHwEjwvQG06Gvhpg9RJ6j9YPCUViKOxmQdYeAbI5
 1wVuaWrP2W0oodV54twjZm3vF5iUncvFrp4ml/LXeCu1eKDeBdfu3bENHcmZdCB9CNiQd8ra4Xj
 tN8/5etFmnHguFtJDpJVuqVMYpqe9VN3KIpzcg4hXmsUxZWoyBeJlCyf4AO2Uv2Z/XSc2AJ2PQo
 2WsqQXyw4GtpwCWFpiC9g==
X-Received: by 2002:a05:6a00:8006:b0:848:2d1d:836f with SMTP id
 d2e1a72fcca58-84fb55856e9mr1376059b3a.28.1786494710335; 
 Tue, 11 Aug 2026 17:31:50 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fb1f2587fsm321466b3a.49.2026.08.11.17.31.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 17:31:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/7] tcg/aarch64: Implement min/max with FEAT_CSSC
Date: Tue, 11 Aug 2026 17:31:40 -0700
Message-ID: <20260812003143.225228-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812003143.225228-1-richard.henderson@linaro.org>
References: <20260812003143.225228-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target-con-set.h |   2 +
 tcg/aarch64/tcg-target-con-str.h |   2 +
 tcg/aarch64/tcg-target.c.inc     | 103 +++++++++++++++++++++++++++++--
 3 files changed, 103 insertions(+), 4 deletions(-)

diff --git a/tcg/aarch64/tcg-target-con-set.h b/tcg/aarch64/tcg-target-con-set.h
index d0622e65fb..dd84a9af58 100644
--- a/tcg/aarch64/tcg-target-con-set.h
+++ b/tcg/aarch64/tcg-target-con-set.h
@@ -24,6 +24,8 @@ C_O1_I2(r, r, rAL)
 C_O1_I2(r, r, rC)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rL)
+C_O1_I2(r, r, rS)
+C_O1_I2(r, r, rU)
 C_O1_I2(r, rZ, rA)
 C_O1_I2(r, rz, rMZ)
 C_O1_I2(r, rz, rz)
diff --git a/tcg/aarch64/tcg-target-con-str.h b/tcg/aarch64/tcg-target-con-str.h
index 48e1722c68..fef75e8a76 100644
--- a/tcg/aarch64/tcg-target-con-str.h
+++ b/tcg/aarch64/tcg-target-con-str.h
@@ -21,4 +21,6 @@ CONST('L', TCG_CT_CONST_LIMM)
 CONST('M', TCG_CT_CONST_MONE)
 CONST('O', TCG_CT_CONST_ORRI)
 CONST('N', TCG_CT_CONST_ANDI)
+CONST('S', TCG_CT_CONST_S8)
+CONST('U', TCG_CT_CONST_U8)
 CONST('Z', TCG_CT_CONST_ZERO)
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index f5c185bbf4..55b3be0b96 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -152,6 +152,8 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
 #define TCG_CT_CONST_ORRI 0x1000
 #define TCG_CT_CONST_ANDI 0x2000
 #define TCG_CT_CONST_CMP  0x4000
+#define TCG_CT_CONST_S8   0x8000
+#define TCG_CT_CONST_U8   0x10000
 
 #define ALL_GENERAL_REGS  0xffffffffu
 #define ALL_VECTOR_REGS   0xffffffff00000000ull
@@ -320,6 +322,12 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if ((ct & TCG_CT_CONST_LIMM) && is_limm(val)) {
         return 1;
     }
+    if ((ct & TCG_CT_CONST_S8) && val == (int8_t)val) {
+        return 1;
+    }
+    if ((ct & TCG_CT_CONST_U8) && val == (uint8_t)val) {
+        return 1;
+    }
     if ((ct & TCG_CT_CONST_ZERO) && val == 0) {
         return 1;
     }
@@ -472,6 +480,12 @@ typedef enum {
     Iaddsub_imm_SUBI  = 0x51000000,
     Iaddsub_imm_SUBSI = 0x71000000,
 
+    /* Min/max immediate instructions. */
+    Iminmax_imm_SMAXI = 0x11c00000,
+    Iminmax_imm_UMAXI = 0x11c40000,
+    Iminmax_imm_SMINI = 0x11c80000,
+    Iminmax_imm_UMINI = 0x11cc0000,
+
     /* Bitfield instructions.  */
     Ibitfield_BFM     = 0x33000000,
     Ibitfield_SBFM    = 0x13000000,
@@ -533,6 +547,10 @@ typedef enum {
     Irrr_UMULH         = 0x9bc07c00,
     Irrr_UDIV          = 0x1ac00800,
     Irrr_SDIV          = 0x1ac00c00,
+    Irrr_SMAX          = 0x1ac00600,
+    Irrr_UMAX          = 0x1ac00640,
+    Irrr_SMIN          = 0x1ac00680,
+    Irrr_UMIN          = 0x1ac006c0,
 
     /* Data-processing (3 source) instructions.  */
     Irrrr_MADD         = 0x1b000000,
@@ -737,6 +755,13 @@ static void tcg_out_insn_addsub_imm(TCGContext *s, AArch64Insn insn,
     tcg_out32(s, insn | ext << 31 | aimm << 10 | rn << 5 | rd);
 }
 
+static void tcg_out_insn_minmax_imm(TCGContext *s, AArch64Insn insn,
+                                    TCGType ext, TCGReg rd, TCGReg rn,
+                                    uint8_t imm)
+{
+    tcg_out32(s, insn | ext << 31 | imm << 10 | rn << 5 | rd);
+}
+
 /* This function can be used for both 3.4.2 (Bitfield) and 3.4.4
    (Logical immediate).  Both insn groups have N, IMMR and IMMS fields
    that feed the DecodeBitMasks pseudo function.  */
@@ -2592,20 +2617,90 @@ static void tcg_out_set_borrow(TCGContext *s)
                  TCG_REG_XZR, TCG_REG_XZR, TCG_REG_XZR);
 }
 
+static TCGConstraintSetIndex cset_sminmax(TCGType type, unsigned flags)
+{
+    return cpuinfo & CPUINFO_CSSC ? C_O1_I2(r, r, rS) : C_NotImplemented;
+}
+
+static void tgen_smax(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, rrr, SMAX, type, a0, a1, a2);
+}
+
+static void tgen_smaxi(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_insn(s, minmax_imm, SMAXI, type, a0, a1, a2);
+}
+
 static const TCGOutOpBinary outop_smax = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_sminmax,
+    .out_rrr = tgen_smax,
+    .out_rri = tgen_smaxi,
 };
 
+static void tgen_smin(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, rrr, SMIN, type, a0, a1, a2);
+}
+
+static void tgen_smini(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_insn(s, minmax_imm, SMINI, type, a0, a1, a2);
+}
+
 static const TCGOutOpBinary outop_smin = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_sminmax,
+    .out_rrr = tgen_smin,
+    .out_rri = tgen_smini,
 };
 
+static TCGConstraintSetIndex cset_uminmax(TCGType type, unsigned flags)
+{
+    return cpuinfo & CPUINFO_CSSC ? C_O1_I2(r, r, rU) : C_NotImplemented;
+}
+
+static void tgen_umax(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, rrr, UMAX, type, a0, a1, a2);
+}
+
+static void tgen_umaxi(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_insn(s, minmax_imm, UMAXI, type, a0, a1, a2);
+}
+
 static const TCGOutOpBinary outop_umax = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_uminmax,
+    .out_rrr = tgen_umax,
+    .out_rri = tgen_umaxi,
 };
 
+static void tgen_umin(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, rrr, UMIN, type, a0, a1, a2);
+}
+
+static void tgen_umini(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_insn(s, minmax_imm, UMINI, type, a0, a1, a2);
+}
+
 static const TCGOutOpBinary outop_umin = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_uminmax,
+    .out_rrr = tgen_umin,
+    .out_rri = tgen_umini,
 };
 
 static void tgen_xor(TCGContext *s, TCGType type,
-- 
2.43.0


