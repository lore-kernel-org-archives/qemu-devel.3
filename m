Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEA9C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCs-0007hF-3L; Tue, 18 Aug 2026 13:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCq-0007fm-7a
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:32 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCo-0004qW-CT
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:31 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-84f77cc7302so82767b3a.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072549; x=1787677349; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8Uv7LOs6RXlnAv+bZCgV2Njs2YWrslQkt4dGMw+5r34=;
 b=a8lGcBj8ybFS0VTPeMBFy8Jt2+L57B9WHwzCSWRsRhtgop9Svjp6cPbcmtq1dEseHq
 yu/oxZBFd7AMgOu7DQuFKX09BO25c+lDtTQLYIXEwAC3gMwZXsAWrKR8g1fpApkp8vAw
 t+oBnkK02cDEIpIrsEm9xAleJqQ5xcKplhkYl0kK6gZSLa2ei3N6lv35eBwxGwA0MXxS
 7l7XWWfnLdSuwtCZuCwdzP5dL//C836LI476CKJmjD39NxUJqGWTIEchAgRlkC2kC9o1
 DVnU+wvq3BVexLYgPMgLnFtEWDswtsti4B3a2IHNSo/ubTcOnR1Fl14M04CeNRtPcdmv
 VM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072549; x=1787677349;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8Uv7LOs6RXlnAv+bZCgV2Njs2YWrslQkt4dGMw+5r34=;
 b=d1uN7pqMgpqBnuym9QWYG9vm+982IIo0Mf3QwqEdQ386qODgXLmhbrObvqKQDWUT2Q
 QY+XS0d8qUZ0aK2P4Tx8btLl3+1XJrlQrdT8r7IJ6g+3rP0Ef+UiHROFRQqTbO81PQOt
 3T2QJcn+QcMzG2eGXzCfUA8IzF7FjNByaGRKOXPgjMdILwSmJwKOfTYcy581L8ce6/Ux
 EaNx7naRS+Cs/qFiSI92ot54Hw4sZ6+URAtU763hDqCyfEVktGfAUZY6ffmprcNrzeC1
 Rjzstjt9iZN+4KoIZbOZ9oQVeCVUx25uJrMWDeZbmYCGY9EmY3a4wKLhVoCCwbV/usnk
 v6Hg==
X-Gm-Message-State: AOJu0YyMTDpYiX2z2o3all7vvB5YADaVLiMerGz4X3/Co7u46rs8/Jfs
 kagTdRn6IWyK7YvRRBiZgcbTYHOc6wi9rqfDb2BpoLwR+kH9ArFjacLlntn8ZCpLQ8O47ueENfG
 qqsYJpSo=
X-Gm-Gg: AR+sD12knsMIF07brepam34CmUKUyFqJ9jSN8TUjENeA/+MHT3r9V2u9Q7laLRzV+vg
 kP5KBZ99nxy/MXDwdNwV9SzdYBHb82ZY5dpP9Oti9jFSYwxEsxVyjtTdFkvelb3rmqIcD3+Gr1N
 /+GKxk/1aJ1PWAMSnJqZds32DsarhviEwUaUyKqjYSJ9hNfwlEXN5PLzz6/2A6NnSdVtMo/mwGq
 w/CteXW3ynCjvLsUs+HywrOwMQZiGAPT4LEDjGyzNYfRI/1x5ul3KVhtY6H7CtmRDDny/awuVoz
 Zlng4XYblbx+t5hrB33ULLYYvaD1PoAwAqXBzM2r4u1qKMkdvTOPoQZXKhIjutUlXbOi4BXudrs
 6+a0hddGR+bsPE8jPIrjdB26SqKbFUvf6az+zSyYoaj8B7sLeiB3LLEe94I/xFDgrWEewBrK8zN
 7wocA/4Un554OTA+lQ3SsT99aU1zpwIXca3DAydrzD4TMvrsIgQSCjKFN33C2WS4aMRfPjKfNJa
 C9I7Ei75nItheXNQKsRQtMROPQEchY6ino=
X-Received: by 2002:a05:6a00:14ca:b0:84e:216d:7e4e with SMTP id
 d2e1a72fcca58-84fde14ffb3mr31653532b3a.1.1787072548503; 
 Tue, 18 Aug 2026 10:02:28 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 26/38] tcg/aarch64: Implement min/max with FEAT_CSSC
Date: Tue, 18 Aug 2026 10:01:43 -0700
Message-ID: <20260818170155.1907006-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


