Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06C8C021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnzy-0005HV-9u; Sun, 16 Feb 2025 18:24:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnzt-00055o-S4
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:24:26 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnzo-0006e4-5V
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:24:25 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2212a930001so11705755ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748258; x=1740353058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Pn5JdaN3v2ZlxAdsEttIv13huASdKITRKAJAddNhIm8=;
 b=GYeHoUWK2yc168i4dFV79DTaPR24i+WzqinfGYfMhruT8wwqRlgu22IBH/Qr81bsEa
 aymC17cUzh97j2NvAdTNDSVMttR4LMKZDaqHfZcSpYIaMXCf8lnnOFU0lccU8hJQkoW7
 TnxViSb2KIk9qw9B5MghcCm3dD19cRgmxgiYafvuV1mH4axqJ0281ULm2KsLHwIU4Bo4
 bS3A631qQePF9wyOFoRtsdTyO9zjG2vH4KEzVuGrX0AZ/5ymhASXwUdeRm3quhhAxeYg
 9eU/uQyeubqq2JUTLIhP2sbIo62qEILrpXhfiFnIcp4++prg0fVNHxKctC2FvHms4DeV
 6wAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748258; x=1740353058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pn5JdaN3v2ZlxAdsEttIv13huASdKITRKAJAddNhIm8=;
 b=lxtyn0qdRz4s8UcVGjBts183kUC5by8OKgDD1i8BuS+X8iNv1u4Ug1I4KzDFhDvYWi
 FIzA0AOji53p4fkQ7/ketrlJDzxOB53phBtj9bog2/oTEVslVI1hkkzP+9O+Zbybcsto
 Dn15UgXwk3E0Lm7MJGuDn9kgONBcA1x4RckIoYHkPfFcIUej/Y9xSnjtLOImR318dpPV
 5GC6e10N581O0HwceFAzmjpeNPpuDIyy4v0/XUtvGo6JYE38cuh/zGPCx2XLyl9oMhno
 m8MYA/4yhZUfQJ3TofwZv/J8O6AP8+TgBjhSeL+jpx07ek1s4CUpwm6plbKjUMHakejQ
 NFsg==
X-Gm-Message-State: AOJu0YxZ8sbYZPwIK5SFwtLwqwPuu2PwSMD6jBPBFr8+zqRNABCBvIwb
 NPHrXqNVQ2pEdpO5qANAXW+hrmRHGRGs5oaMI6e4+N5e9S2tTP+r9l0gy4lMeQEbbvpANYNTBaE
 F
X-Gm-Gg: ASbGnctApfsxqGjBhsi15s3kiC79YeFRGU0HkOZThmcM4A493LH46P3qXwMxJAugWg6
 pdtBSR5+Nlg/QniB+G8ZiWaaI9QtVhg1TKudxbgZJ+0HqHRYz8qKTyCHUPG6bI5Lz9+mgzyIhE/
 UKNI9HXyIJ3WGZDrWrm/j6BF+CUYAOSl2IE9VeSoyTmI0CaIGBjm64SZfp0WS8Yw7zOpY0qUsFq
 C9GK/qz5n6HCML7XxUkyYXEeWGJ9voGdX9vfwT0vQvSlwZCk14QC3UmnAxHP/PDa7HnnL69ptRb
 vg7YoPX0ZLtcFE5T6EE82/eB9zu/A2Rvt7GMjFMXWBlOsws=
X-Google-Smtp-Source: AGHT+IFXHYZAhRKWleXrsrHh06uFhiNxtbFkORL2IQ8TOUH1Lr6Qg/fzMe0A0uopSFMDruox+9gqkA==
X-Received: by 2002:a05:6a20:3945:b0:1dc:2a02:913b with SMTP id
 adf61e73a8af0-1ee8cb4ef85mr11327651637.15.1739748257930; 
 Sun, 16 Feb 2025 15:24:17 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adc9ff10056sm4640529a12.72.2025.02.16.15.24.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:24:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 160/162] tcg: Convert qemu_ld{2} to TCGOutOpLoad{2}
Date: Sun, 16 Feb 2025 15:10:09 -0800
Message-ID: <20250216231012.2808572-161-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        | 32 +++++++++++++++-
 tcg/aarch64/tcg-target.c.inc     | 30 +++++++++------
 tcg/arm/tcg-target.c.inc         | 63 +++++++++++++++++++++++---------
 tcg/i386/tcg-target.c.inc        | 47 ++++++++++++++++--------
 tcg/loongarch64/tcg-target.c.inc | 37 ++++++++++---------
 tcg/mips/tcg-target.c.inc        | 57 +++++++++++++++++++++--------
 tcg/ppc/tcg-target.c.inc         | 45 ++++++++++++++---------
 tcg/riscv/tcg-target.c.inc       | 22 ++++++-----
 tcg/s390x/tcg-target.c.inc       | 32 +++++++++-------
 tcg/sparc64/tcg-target.c.inc     | 21 ++++++-----
 tcg/tci/tcg-target.c.inc         | 30 ++++++++++++---
 11 files changed, 283 insertions(+), 133 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index e42a718e8c..31121b168c 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1071,6 +1071,18 @@ typedef struct TCGOutOpMul2 {
                      TCGReg a0, TCGReg a1, TCGReg a2, TCGReg a3);
 } TCGOutOpMul2;
 
+typedef struct TCGOutOpQemuLdSt {
+    TCGOutOp base;
+    void (*out)(TCGContext *s, TCGType type, TCGReg dest,
+                TCGReg addr, MemOpIdx oi);
+} TCGOutOpQemuLdSt;
+
+typedef struct TCGOutOpQemuLdSt2 {
+    TCGOutOp base;
+    void (*out)(TCGContext *s, TCGType type, TCGReg dlo, TCGReg dhi,
+                TCGReg addr, MemOpIdx oi);
+} TCGOutOpQemuLdSt2;
+
 typedef struct TCGOutOpUnary {
     TCGOutOp base;
     void (*out_rr)(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1);
@@ -1210,6 +1222,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_not, TCGOutOpUnary, outop_not),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
+    OUTOP(INDEX_op_qemu_ld, TCGOutOpQemuLdSt, outop_qemu_ld),
+    OUTOP(INDEX_op_qemu_ld2, TCGOutOpQemuLdSt2, outop_qemu_ld2),
     OUTOP(INDEX_op_rems, TCGOutOpBinary, outop_rems),
     OUTOP(INDEX_op_remu, TCGOutOpBinary, outop_remu),
     OUTOP(INDEX_op_rotl, TCGOutOpBinary, outop_rotl),
@@ -2446,7 +2460,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
             return true;
         }
         tcg_debug_assert(type == TCG_TYPE_I128);
-        return TCG_TARGET_HAS_qemu_ldst_i128;
+        goto do_lookup;
 
     case INDEX_op_add:
     case INDEX_op_and:
@@ -2558,6 +2572,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
                 return false;
             }
 
+    do_lookup:
             outop = all_outop[op];
             tcg_debug_assert(outop != NULL);
 
@@ -5763,6 +5778,21 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
+    case INDEX_op_qemu_ld:
+        {
+            const TCGOutOpQemuLdSt *out = &outop_qemu_ld;
+            out->out(s, type, new_args[0], new_args[1], new_args[2]);
+        }
+        break;
+
+    case INDEX_op_qemu_ld2:
+        {
+            const TCGOutOpQemuLdSt2 *out = &outop_qemu_ld2;
+            out->out(s, type, new_args[0], new_args[1],
+                     new_args[2], new_args[3]);
+        }
+        break;
+
     case INDEX_op_brcond:
         {
             const TCGOutOpBrcond *out = &outop_brcond;
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index f4a0b0e720..21b6ce1229 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1806,8 +1806,8 @@ static void tcg_out_qemu_st_direct(TCGContext *s, MemOp memop,
     }
 }
 
-static void tcg_out_qemu_ld(TCGContext *s, TCGReg data_reg, TCGReg addr_reg,
-                            MemOpIdx oi, TCGType data_type)
+static void tgen_qemu_ld(TCGContext *s, TCGType data_type, TCGReg data_reg,
+                         TCGReg addr_reg, MemOpIdx oi)
 {
     TCGLabelQemuLdst *ldst;
     HostAddress h;
@@ -1822,6 +1822,11 @@ static void tcg_out_qemu_ld(TCGContext *s, TCGReg data_reg, TCGReg addr_reg,
     }
 }
 
+static const TCGOutOpQemuLdSt outop_qemu_ld = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_qemu_ld,
+};
+
 static void tcg_out_qemu_st(TCGContext *s, TCGReg data_reg, TCGReg addr_reg,
                             MemOpIdx oi, TCGType data_type)
 {
@@ -1940,6 +1945,17 @@ static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg datalo, TCGReg datahi,
     }
 }
 
+static void tgen_qemu_ld2(TCGContext *s, TCGType type, TCGReg datalo,
+                          TCGReg datahi, TCGReg addr_reg, MemOpIdx oi)
+{
+    tcg_out_qemu_ldst_i128(s, datalo, datahi, addr_reg, oi, true);
+}
+
+static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
+    .base.static_constraint = C_O2_I1(r, r, r),
+    .out = tgen_qemu_ld2,
+};
+
 static const tcg_insn_unit *tb_ret_addr;
 
 static void tcg_out_exit_tb(TCGContext *s, uintptr_t a0)
@@ -2875,15 +2891,9 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
     TCGArg a2 = args[2];
 
     switch (opc) {
-    case INDEX_op_qemu_ld:
-        tcg_out_qemu_ld(s, a0, a1, a2, ext);
-        break;
     case INDEX_op_qemu_st:
         tcg_out_qemu_st(s, a0, a1, a2, ext);
         break;
-    case INDEX_op_qemu_ld2:
-        tcg_out_qemu_ldst_i128(s, a0, a1, a2, args[3], true);
-        break;
     case INDEX_op_qemu_st2:
         tcg_out_qemu_ldst_i128(s, a0, a1, a2, args[3], false);
         break;
@@ -3340,10 +3350,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_qemu_ld:
-        return C_O1_I1(r, r);
-    case INDEX_op_qemu_ld2:
-        return C_O2_I1(r, r, r);
     case INDEX_op_qemu_st:
         return C_O0_I2(rz, r);
     case INDEX_op_qemu_st2:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 6a7667113d..6cffaaaeee 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1592,8 +1592,8 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, MemOp opc, TCGReg datalo,
     }
 }
 
-static void tcg_out_qemu_ld(TCGContext *s, TCGReg datalo, TCGReg datahi,
-                            TCGReg addr, MemOpIdx oi, TCGType data_type)
+static void tgen_qemu_ld(TCGContext *s, TCGType type, TCGReg data,
+                         TCGReg addr, MemOpIdx oi)
 {
     MemOp opc = get_memop(oi);
     TCGLabelQemuLdst *ldst;
@@ -1601,7 +1601,41 @@ static void tcg_out_qemu_ld(TCGContext *s, TCGReg datalo, TCGReg datahi,
 
     ldst = prepare_host_addr(s, &h, addr, oi, true);
     if (ldst) {
-        ldst->type = data_type;
+        ldst->type = type;
+        ldst->datalo_reg = data;
+        ldst->datahi_reg = -1;
+
+        /*
+         * This a conditional BL only to load a pointer within this
+         * opcode into LR for the slow path.  We will not be using
+         * the value for a tail call.
+         */
+        ldst->label_ptr[0] = s->code_ptr;
+        tcg_out_bl_imm(s, COND_NE, 0);
+    }
+
+    tcg_out_qemu_ld_direct(s, opc, data, -1, h);
+
+    if (ldst) {
+        ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
+    }
+}
+
+static const TCGOutOpQemuLdSt outop_qemu_ld = {
+    .base.static_constraint = C_O1_I1(r, q),
+    .out = tgen_qemu_ld,
+};
+
+static void tgen_qemu_ld2(TCGContext *s, TCGType type, TCGReg datalo,
+                          TCGReg datahi, TCGReg addr, MemOpIdx oi)
+{
+    MemOp opc = get_memop(oi);
+    TCGLabelQemuLdst *ldst;
+    HostAddress h;
+
+    ldst = prepare_host_addr(s, &h, addr, oi, true);
+    if (ldst) {
+        ldst->type = type;
         ldst->datalo_reg = datalo;
         ldst->datahi_reg = datahi;
 
@@ -1612,14 +1646,20 @@ static void tcg_out_qemu_ld(TCGContext *s, TCGReg datalo, TCGReg datahi,
          */
         ldst->label_ptr[0] = s->code_ptr;
         tcg_out_bl_imm(s, COND_NE, 0);
+    }
 
-        tcg_out_qemu_ld_direct(s, opc, datalo, datahi, h);
+    tcg_out_qemu_ld_direct(s, opc, datalo, datahi, h);
+
+    if (ldst) {
         ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
-    } else {
-        tcg_out_qemu_ld_direct(s, opc, datalo, datahi, h);
     }
 }
 
+static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
+    .base.static_constraint = C_O2_I1(e, p, q),
+    .out = tgen_qemu_ld2,
+};
+
 static void tcg_out_qemu_st_direct(TCGContext *s, MemOp opc, TCGReg datalo,
                                    TCGReg datahi, HostAddress h)
 {
@@ -2576,13 +2616,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const int const_args[TCG_MAX_OP_ARGS])
 {
     switch (opc) {
-    case INDEX_op_qemu_ld:
-        tcg_out_qemu_ld(s, args[0], -1, args[1], args[2], TCG_TYPE_I32);
-        break;
-    case INDEX_op_qemu_ld2:
-        tcg_out_qemu_ld(s, args[0], args[1], args[2], args[3], TCG_TYPE_I64);
-        break;
-
     case INDEX_op_qemu_st:
         tcg_out_qemu_st(s, args[0], -1, args[1], args[2], TCG_TYPE_I32);
         break;
@@ -2602,10 +2635,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_qemu_ld:
-        return C_O1_I1(r, q);
-    case INDEX_op_qemu_ld2:
-        return C_O2_I1(e, p, q);
     case INDEX_op_qemu_st:
         return C_O0_I2(q, q);
     case INDEX_op_qemu_st2:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index ad8bb40ecc..cf1184eae3 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2422,23 +2422,50 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
     }
 }
 
-static void tcg_out_qemu_ld(TCGContext *s, TCGReg datalo, TCGReg datahi,
-                            TCGReg addr, MemOpIdx oi, TCGType data_type)
+static void tgen_qemu_ld(TCGContext *s, TCGType type, TCGReg data,
+                         TCGReg addr, MemOpIdx oi)
 {
     TCGLabelQemuLdst *ldst;
     HostAddress h;
 
     ldst = prepare_host_addr(s, &h, addr, oi, true);
-    tcg_out_qemu_ld_direct(s, datalo, datahi, h, data_type, get_memop(oi));
+    tcg_out_qemu_ld_direct(s, data, -1, h, type, get_memop(oi));
 
     if (ldst) {
-        ldst->type = data_type;
+        ldst->type = type;
+        ldst->datalo_reg = data;
+        ldst->datahi_reg = -1;
+        ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
+    }
+}
+
+static const TCGOutOpQemuLdSt outop_qemu_ld = {
+    .base.static_constraint = C_O1_I1(r, L),
+    .out = tgen_qemu_ld,
+};
+
+static void tgen_qemu_ld2(TCGContext *s, TCGType type, TCGReg datalo,
+                          TCGReg datahi, TCGReg addr, MemOpIdx oi)
+{
+    TCGLabelQemuLdst *ldst;
+    HostAddress h;
+
+    ldst = prepare_host_addr(s, &h, addr, oi, true);
+    tcg_out_qemu_ld_direct(s, datalo, datahi, h, type, get_memop(oi));
+
+    if (ldst) {
+        ldst->type = type;
         ldst->datalo_reg = datalo;
         ldst->datahi_reg = datahi;
         ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
     }
 }
 
+static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
+    .base.static_constraint = C_O2_I1(r, r, L),
+    .out = tgen_qemu_ld2,
+};
+
 static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
                                    HostAddress h, MemOp memop)
 {
@@ -3552,13 +3579,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     a2 = args[2];
 
     switch (opc) {
-    case INDEX_op_qemu_ld:
-        tcg_out_qemu_ld(s, a0, -1, a1, a2, type);
-        break;
-    case INDEX_op_qemu_ld2:
-        tcg_out_qemu_ld(s, a0, a1, a2, args[3], type);
-        break;
-
     case INDEX_op_qemu_st:
         tcg_out_qemu_st(s, a0, -1, a1, a2, type);
         break;
@@ -4119,16 +4139,11 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_qemu_ld:
-        return C_O1_I1(r, L);
-
     case INDEX_op_qemu_st:
         return (TCG_TARGET_REG_BITS == 32 && flags == MO_8
                 ? C_O0_I2(s, L)
                 : C_O0_I2(L, L));
 
-    case INDEX_op_qemu_ld2:
-        return C_O2_I1(r, r, L);
     case INDEX_op_qemu_st2:
         return C_O0_I3(L, L, L);
 
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index d4f65692dd..a1147a1cdc 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1155,22 +1155,27 @@ static void tcg_out_qemu_ld_indexed(TCGContext *s, MemOp opc, TCGType type,
     }
 }
 
-static void tcg_out_qemu_ld(TCGContext *s, TCGReg data_reg, TCGReg addr_reg,
-                            MemOpIdx oi, TCGType data_type)
+static void tgen_qemu_ld(TCGContext *s, TCGType type, TCGReg data_reg,
+                         TCGReg addr_reg, MemOpIdx oi)
 {
     TCGLabelQemuLdst *ldst;
     HostAddress h;
 
     ldst = prepare_host_addr(s, &h, addr_reg, oi, true);
-    tcg_out_qemu_ld_indexed(s, get_memop(oi), data_type, data_reg, h);
+    tcg_out_qemu_ld_indexed(s, get_memop(oi), type, data_reg, h);
 
     if (ldst) {
-        ldst->type = data_type;
+        ldst->type = type;
         ldst->datalo_reg = data_reg;
         ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
     }
 }
 
+static const TCGOutOpQemuLdSt outop_qemu_ld = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_qemu_ld,
+};
+
 static void tcg_out_qemu_st_indexed(TCGContext *s, MemOp opc,
                                     TCGReg rd, HostAddress h)
 {
@@ -1258,6 +1263,17 @@ static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg data_lo, TCGReg data_hi
     }
 }
 
+static void tgen_qemu_ld2(TCGContext *s, TCGType type, TCGReg datalo,
+                          TCGReg datahi, TCGReg addr_reg, MemOpIdx oi)
+{
+    tcg_out_qemu_ldst_i128(s, datalo, datahi, addr_reg, oi, true);
+}
+
+static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
+    .base.static_constraint = C_N2_I1(r, r, r),
+    .out = tgen_qemu_ld2,
+};
+
 /*
  * Entry-points
  */
@@ -2008,12 +2024,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     TCGArg a3 = args[3];
 
     switch (opc) {
-    case INDEX_op_qemu_ld:
-        tcg_out_qemu_ld(s, a0, a1, a2, type);
-        break;
-    case INDEX_op_qemu_ld2:
-        tcg_out_qemu_ldst_i128(s, a0, a1, a2, a3, true);
-        break;
     case INDEX_op_qemu_st:
         tcg_out_qemu_st(s, a0, a1, a2, type);
         break;
@@ -2531,16 +2541,9 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     switch (op) {
     case INDEX_op_qemu_st:
         return C_O0_I2(rz, r);
-
-    case INDEX_op_qemu_ld2:
-        return C_N2_I1(r, r, r);
-
     case INDEX_op_qemu_st2:
         return C_O0_I3(r, r, r);
 
-    case INDEX_op_qemu_ld:
-        return C_O1_I1(r, r);
-
     case INDEX_op_ld_vec:
     case INDEX_op_dupm_vec:
     case INDEX_op_dup_vec:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index e61cab814f..d8916dcf37 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1387,8 +1387,8 @@ static void tcg_out_qemu_ld_unalign(TCGContext *s, TCGReg lo, TCGReg hi,
     }
 }
 
-static void tcg_out_qemu_ld(TCGContext *s, TCGReg datalo, TCGReg datahi,
-                            TCGReg addr, MemOpIdx oi, TCGType data_type)
+static void tgen_qemu_ld(TCGContext *s, TCGType type, TCGReg data,
+                         TCGReg addr, MemOpIdx oi)
 {
     MemOp opc = get_memop(oi);
     TCGLabelQemuLdst *ldst;
@@ -1397,19 +1397,56 @@ static void tcg_out_qemu_ld(TCGContext *s, TCGReg datalo, TCGReg datahi,
     ldst = prepare_host_addr(s, &h, addr, oi, true);
 
     if (use_mips32r6_instructions || h.aa.align >= (opc & MO_SIZE)) {
-        tcg_out_qemu_ld_direct(s, datalo, datahi, h.base, opc, data_type);
+        tcg_out_qemu_ld_direct(s, data, 0, h.base, opc, type);
     } else {
-        tcg_out_qemu_ld_unalign(s, datalo, datahi, h.base, opc, data_type);
+        tcg_out_qemu_ld_unalign(s, data, 0, h.base, opc, type);
     }
 
     if (ldst) {
-        ldst->type = data_type;
+        ldst->type = type;
+        ldst->datalo_reg = data;
+        ldst->datahi_reg = 0;
+        ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
+    }
+}
+
+static const TCGOutOpQemuLdSt outop_qemu_ld = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_qemu_ld,
+};
+
+static void tgen_qemu_ld2(TCGContext *s, TCGType type, TCGReg datalo,
+                          TCGReg datahi, TCGReg addr, MemOpIdx oi)
+{
+    MemOp opc = get_memop(oi);
+    TCGLabelQemuLdst *ldst;
+    HostAddress h;
+
+    tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
+    ldst = prepare_host_addr(s, &h, addr, oi, true);
+
+    if (use_mips32r6_instructions || h.aa.align >= (opc & MO_SIZE)) {
+        tcg_out_qemu_ld_direct(s, datalo, datahi, h.base, opc, type);
+    } else {
+        tcg_out_qemu_ld_unalign(s, datalo, datahi, h.base, opc, type);
+    }
+
+    if (ldst) {
+        ldst->type = type;
         ldst->datalo_reg = datalo;
         ldst->datahi_reg = datahi;
         ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
     }
 }
 
+static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
+    /* Ensure that the mips32 code is compiled but discarded for mips64. */
+    .base.static_constraint =
+        TCG_TARGET_REG_BITS == 32 ? C_O2_I1(r, r, r) : C_NotImplemented,
+    .out =
+        TCG_TARGET_REG_BITS == 32 ? tgen_qemu_ld2 : NULL,
+};
+
 static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg lo, TCGReg hi,
                                    TCGReg base, MemOp opc)
 {
@@ -2387,14 +2424,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     a2 = args[2];
 
     switch (opc) {
-    case INDEX_op_qemu_ld:
-        tcg_out_qemu_ld(s, a0, 0, a1, a2, type);
-        break;
-    case INDEX_op_qemu_ld2:
-        tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
-        tcg_out_qemu_ld(s, a0, a1, a2, args[3], type);
-        break;
-
     case INDEX_op_qemu_st:
         tcg_out_qemu_st(s, a0, 0, a1, a2, type);
         break;
@@ -2415,8 +2444,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_qemu_ld:
-        return C_O1_I1(r, r);
     case INDEX_op_qemu_st:
         return C_O0_I2(rz, r);
     case INDEX_op_qemu_ld2:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index bb26769d53..e4e6b7b2d9 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2695,6 +2695,33 @@ static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg datalo, TCGReg datahi,
     }
 }
 
+static void tgen_qemu_ld(TCGContext *s, TCGType type, TCGReg data,
+                         TCGReg addr, MemOpIdx oi)
+{
+    tcg_out_qemu_ld(s, data, -1, addr, oi, type);
+}
+
+static const TCGOutOpQemuLdSt outop_qemu_ld = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_qemu_ld,
+};
+
+static void tgen_qemu_ld2(TCGContext *s, TCGType type, TCGReg datalo,
+                          TCGReg datahi, TCGReg addr, MemOpIdx oi)
+{
+    if (TCG_TARGET_REG_BITS == 32) {
+        tcg_out_qemu_ld(s, datalo, datahi, addr, oi, type);
+    } else {
+        tcg_out_qemu_ldst_i128(s, datalo, datahi, addr, oi, true);
+    }
+}
+
+static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
+    .base.static_constraint =
+        TCG_TARGET_REG_BITS == 64 ? C_N1O1_I1(o, m, r) : C_O2_I1(r, r, r),
+    .out = tgen_qemu_ld2,
+};
+
 static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
 {
     int i;
@@ -3779,18 +3806,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const int const_args[TCG_MAX_OP_ARGS])
 {
     switch (opc) {
-    case INDEX_op_qemu_ld:
-        tcg_out_qemu_ld(s, args[0], -1, args[1], args[2], type);
-        break;
-    case INDEX_op_qemu_ld2:
-        if (TCG_TARGET_REG_BITS == 32) {
-            tcg_out_qemu_ld(s, args[0], args[1], args[2],
-                            args[3], TCG_TYPE_I64);
-            break;
-        }
-        tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], true);
-        break;
-
     case INDEX_op_qemu_st:
         tcg_out_qemu_st(s, args[0], -1, args[1], args[2], type);
         break;
@@ -4418,12 +4433,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_qemu_ld:
-        return C_O1_I1(r, r);
-    case INDEX_op_qemu_ld2:
-        return TCG_TARGET_REG_BITS == 64
-               ? C_N1O1_I1(o, m, r) : C_O2_I1(r, r, r);
-
     case INDEX_op_qemu_st:
         return C_O0_I2(r, r);
     case INDEX_op_qemu_st2:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 89c7736f9a..94e6f04fa6 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1833,22 +1833,31 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg val,
     }
 }
 
-static void tcg_out_qemu_ld(TCGContext *s, TCGReg data_reg, TCGReg addr_reg,
-                            MemOpIdx oi, TCGType data_type)
+static void tgen_qemu_ld(TCGContext *s, TCGType type, TCGReg data_reg,
+                         TCGReg addr_reg, MemOpIdx oi)
 {
     TCGLabelQemuLdst *ldst;
     TCGReg base;
 
     ldst = prepare_host_addr(s, &base, addr_reg, oi, true);
-    tcg_out_qemu_ld_direct(s, data_reg, base, get_memop(oi), data_type);
+    tcg_out_qemu_ld_direct(s, data_reg, base, get_memop(oi), type);
 
     if (ldst) {
-        ldst->type = data_type;
+        ldst->type = type;
         ldst->datalo_reg = data_reg;
         ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
     }
 }
 
+static const TCGOutOpQemuLdSt outop_qemu_ld = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_qemu_ld,
+};
+
+static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg val,
                                    TCGReg base, MemOp opc)
 {
@@ -2633,9 +2642,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     TCGArg a2 = args[2];
 
     switch (opc) {
-    case INDEX_op_qemu_ld:
-        tcg_out_qemu_ld(s, a0, a1, a2, type);
-        break;
     case INDEX_op_qemu_st:
         tcg_out_qemu_st(s, a0, a1, a2, type);
         break;
@@ -2869,8 +2875,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_qemu_ld:
-        return C_O1_I1(r, r);
     case INDEX_op_qemu_st:
         return C_O0_I2(rz, r);
 
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 652ce9023e..72dd161007 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2081,8 +2081,8 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     return ldst;
 }
 
-static void tcg_out_qemu_ld(TCGContext* s, TCGReg data_reg, TCGReg addr_reg,
-                            MemOpIdx oi, TCGType data_type)
+static void tgen_qemu_ld(TCGContext* s, TCGType type, TCGReg data_reg,
+                         TCGReg addr_reg, MemOpIdx oi)
 {
     TCGLabelQemuLdst *ldst;
     HostAddress h;
@@ -2091,12 +2091,17 @@ static void tcg_out_qemu_ld(TCGContext* s, TCGReg data_reg, TCGReg addr_reg,
     tcg_out_qemu_ld_direct(s, get_memop(oi), data_reg, h);
 
     if (ldst) {
-        ldst->type = data_type;
+        ldst->type = type;
         ldst->datalo_reg = data_reg;
         ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
     }
 }
 
+static const TCGOutOpQemuLdSt outop_qemu_ld = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_qemu_ld,
+};
+
 static void tcg_out_qemu_st(TCGContext* s, TCGReg data_reg, TCGReg addr_reg,
                             MemOpIdx oi, TCGType data_type)
 {
@@ -2187,6 +2192,17 @@ static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg datalo, TCGReg datahi,
     }
 }
 
+static void tgen_qemu_ld2(TCGContext *s, TCGType type, TCGReg datalo,
+                          TCGReg datahi, TCGReg addr_reg, MemOpIdx oi)
+{
+    tcg_out_qemu_ldst_i128(s, datalo, datahi, addr_reg, oi, true);
+}
+
+static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
+    .base.static_constraint = C_O2_I1(o, m, r),
+    .out = tgen_qemu_ld2,
+};
+
 static void tcg_out_exit_tb(TCGContext *s, uintptr_t a0)
 {
     /* Reuse the zeroing that exists for goto_ptr.  */
@@ -3133,15 +3149,9 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const int const_args[TCG_MAX_OP_ARGS])
 {
     switch (opc) {
-    case INDEX_op_qemu_ld:
-        tcg_out_qemu_ld(s, args[0], args[1], args[2], type);
-        break;
     case INDEX_op_qemu_st:
         tcg_out_qemu_st(s, args[0], args[1], args[2], type);
         break;
-    case INDEX_op_qemu_ld2:
-        tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], true);
-        break;
     case INDEX_op_qemu_st2:
         tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], false);
         break;
@@ -3594,12 +3604,8 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_qemu_ld:
-        return C_O1_I1(r, r);
     case INDEX_op_qemu_st:
         return C_O0_I2(r, r);
-    case INDEX_op_qemu_ld2:
-        return C_O2_I1(o, m, r);
     case INDEX_op_qemu_st2:
         return C_O0_I3(o, m, r);
 
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 2f23d713b7..d9a4b4ea36 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1186,8 +1186,8 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     return ldst;
 }
 
-static void tcg_out_qemu_ld(TCGContext *s, TCGReg data, TCGReg addr,
-                            MemOpIdx oi, TCGType data_type)
+static void tgen_qemu_ld(TCGContext *s, TCGType type, TCGReg data,
+                         TCGReg addr, MemOpIdx oi)
 {
     static const int ld_opc[(MO_SSIZE | MO_BSWAP) + 1] = {
         [MO_UB]   = LDUB,
@@ -1219,12 +1219,21 @@ static void tcg_out_qemu_ld(TCGContext *s, TCGReg data, TCGReg addr,
                     ld_opc[get_memop(oi) & (MO_BSWAP | MO_SSIZE)]);
 
     if (ldst) {
-        ldst->type = data_type;
+        ldst->type = type;
         ldst->datalo_reg = data;
         ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
     }
 }
 
+static const TCGOutOpQemuLdSt outop_qemu_ld = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_qemu_ld,
+};
+
+static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tcg_out_qemu_st(TCGContext *s, TCGReg data, TCGReg addr,
                             MemOpIdx oi, TCGType data_type)
 {
@@ -2063,9 +2072,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     a2 = args[2];
 
     switch (opc) {
-    case INDEX_op_qemu_ld:
-        tcg_out_qemu_ld(s, a0, a1, a2, type);
-        break;
     case INDEX_op_qemu_st:
         tcg_out_qemu_st(s, a0, a1, a2, type);
         break;
@@ -2082,9 +2088,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_qemu_ld:
-        return C_O1_I1(r, r);
-
     case INDEX_op_qemu_st:
         return C_O0_I2(rz, r);
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 6b8f71f49e..f69e35e6ce 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -40,12 +40,8 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_qemu_ld:
-        return C_O1_I1(r, r);
     case INDEX_op_qemu_st:
         return C_O0_I2(r, r);
-    case INDEX_op_qemu_ld2:
-        return TCG_TARGET_REG_BITS == 64 ? C_NotImplemented : C_O2_I1(r, r, r);
     case INDEX_op_qemu_st2:
         return TCG_TARGET_REG_BITS == 64 ? C_NotImplemented : C_O0_I3(r, r, r);
 
@@ -1197,17 +1193,39 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static void tgen_qemu_ld(TCGContext *s, TCGType type, TCGReg data,
+                         TCGReg addr, MemOpIdx oi)
+{
+    tcg_out_op_rrm(s, INDEX_op_qemu_ld, data, addr, oi);
+}
+
+static const TCGOutOpQemuLdSt outop_qemu_ld = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_qemu_ld,
+};
+
+static void tgen_qemu_ld2(TCGContext *s, TCGType type, TCGReg datalo,
+                          TCGReg datahi, TCGReg addr, MemOpIdx oi)
+{
+    tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, oi);
+    tcg_out_op_rrrr(s, INDEX_op_qemu_ld2, datalo, datahi, addr, TCG_REG_TMP);
+}
+
+static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
+    .base.static_constraint =
+        TCG_TARGET_REG_BITS == 64 ? C_NotImplemented : C_O2_I1(r, r, r),
+    .out =
+        TCG_TARGET_REG_BITS == 64 ? NULL : tgen_qemu_ld2,
+};
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
     switch (opc) {
-    case INDEX_op_qemu_ld:
     case INDEX_op_qemu_st:
         tcg_out_op_rrm(s, opc, args[0], args[1], args[2]);
         break;
-    case INDEX_op_qemu_ld2:
     case INDEX_op_qemu_st2:
         tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, args[3]);
         tcg_out_op_rrrr(s, opc, args[0], args[1], args[2], TCG_REG_TMP);
-- 
2.43.0


