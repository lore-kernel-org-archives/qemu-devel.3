Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40B8D4A5EE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgabo-0007Sz-Am; Thu, 15 Jan 2026 22:34:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgabU-00073D-RQ
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:34:30 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgabR-0005ft-0b
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:34:28 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-81e8b1bdf0cso941840b3a.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534464; x=1769139264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wz/TZzAvKKMZ0ZLpHsQdp9lkg8RdqzBSeeZVnCRtct8=;
 b=KyAue7vOm/v7a0MIzYTheYID810c151j+UsyEDrd/1G7OyMtcqbOPg3lGNY2245he6
 b8ZKj3org6mPNmRclqoMIHgLvK0lSl0UbMJP1ITygTDglNIncVZWlNzCEszl0IlMPDDP
 AiyLAM/1TfSPRV9tmrqf3WRbhEa/OOxyn8EfaIW+UB8ipbLRIkoTIKjk1QY0MuRR5spf
 VWTKXO6nEIIE8m0TZAkMUViMNcFRlknODHF7k48smj3PxEHVUTmrvRfpEFpL193y7SRx
 XcR/CbnkXCcpZk00tdFtC/doOVwBeE/h/2+HUfaW8nDG6D8Vb0xfgGHHExvtWOFUReHy
 3xqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534464; x=1769139264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wz/TZzAvKKMZ0ZLpHsQdp9lkg8RdqzBSeeZVnCRtct8=;
 b=QZx6NSBh8hCTTSSouWx8sE0zQNxUMwQ7SH5SMBwMNqFC309yLSbmNnFebVBj4MznoM
 noaIQ2SDj4hhuJ57G8BKJn4l3jKucgW7UrKZAZN8wCjHINxrwUrQGOOIQxfNbZAPQdj0
 F4QjP4tdUsxzDZ6NvjMhjM8JXDQzRtovbHiUNsagKK+Wa2yQON876yF00SxHaWd8x5qF
 VWAy2fb3NmFYz//lxjI3/G2bW0SMwBrrETvtr9yhg4iTtwMLFMQnxr262hieVsyy5WTe
 fGNbUE7enuCT6CZ3qPSnLGjHzhjqoD9Xnobow6Ke8vTRJNw3rTqKHMO6voAWeGGgooVY
 nSDw==
X-Gm-Message-State: AOJu0YyQsfilNabXH+85XcgurmR5NNZGtr2Dntaad8u1NjY0pDDPqG9R
 X2/LF6Iu3t6gmhvyKFvzBR89gq2OygHnpla/JXcOzXhzKtQkQnUKvFWdT2ln+0EznwNRsWcGOvk
 FhIcbA9hCsg==
X-Gm-Gg: AY/fxX4cw0magpk7HrLgGUd6AOAAd1L9akdFAPTdFZ4yC7dLdZ1WeDp8YuDzEy8aWlE
 tX9PqCwISh01PtdpD81n4EemzHVEHrUWGHB7XOnBB0Pi4Hm8e5KkxGqaBe2Yar4vGq5zVgrwKRN
 +iso3JeJ+AZUaAt3jfJ7+fKvIijOhj9vLH371X3doF/MKYbykDgG9oYEQ9XYBz793os84J3+Qcu
 UpwiIfISzBzKB1EAmakZJe1W4cPgpOWooaomj+pPQUBopxygIPKj6kn9ymj2Qic44jmeLzT7Edl
 qo07OBtDPUCN98DXe5GSlzPw4mdYnLgz0MsiraaA6Q1ExLdHN5b2I/JAko7EgHxGQsFA8/1lOej
 IekwZy0oqSFHiQehQWaG3TTdag5PV0tC4waZD63XiMMCQ2XB3Q7vOhwwfBDKf3pwOUQzzmYBBCl
 /u9U0qfv8+yregYbiduQ==
X-Received: by 2002:a05:6a00:e84:b0:81e:b809:cf22 with SMTP id
 d2e1a72fcca58-81fa030f777mr1515588b3a.48.1768534463366; 
 Thu, 15 Jan 2026 19:34:23 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.34.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:34:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 17/58] tcg/i386: Remove TCG_TARGET_REG_BITS tests
Date: Fri, 16 Jan 2026 14:32:23 +1100
Message-ID: <20260116033305.51162-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

We now only support 64-bit code generation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target-has.h      |   8 +-
 tcg/i386/tcg-target-reg-bits.h |   2 +-
 tcg/i386/tcg-target.h          |  13 +-
 tcg/i386/tcg-target.c.inc      | 552 ++++++---------------------------
 4 files changed, 97 insertions(+), 478 deletions(-)

diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index 42647fabbd..d249c1b3e7 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -26,13 +26,10 @@
 #define have_avx512vbmi2  ((cpuinfo & CPUINFO_AVX512VBMI2) && have_avx512vl)
 
 /* optional instructions */
-#if TCG_TARGET_REG_BITS == 64
 /* Keep 32-bit values zero-extended in a register.  */
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#endif
 
-#define TCG_TARGET_HAS_qemu_ldst_i128 \
-    (TCG_TARGET_REG_BITS == 64 && (cpuinfo & CPUINFO_ATOMIC_VMOVDQA))
+#define TCG_TARGET_HAS_qemu_ldst_i128   (cpuinfo & CPUINFO_ATOMIC_VMOVDQA)
 
 #define TCG_TARGET_HAS_tst              1
 
@@ -63,8 +60,7 @@
 #define TCG_TARGET_HAS_tst_vec          have_avx512bw
 
 #define TCG_TARGET_deposit_valid(type, ofs, len) \
-    (((ofs) == 0 && ((len) == 8 || (len) == 16)) || \
-     (TCG_TARGET_REG_BITS == 32 && (ofs) == 8 && (len) == 8))
+    ((ofs) == 0 && ((len) == 8 || (len) == 16))
 
 /*
  * Check for the possibility of low byte/word extraction, high-byte extraction
diff --git a/tcg/i386/tcg-target-reg-bits.h b/tcg/i386/tcg-target-reg-bits.h
index aa386050eb..fc3377e829 100644
--- a/tcg/i386/tcg-target-reg-bits.h
+++ b/tcg/i386/tcg-target-reg-bits.h
@@ -10,7 +10,7 @@
 #ifdef __x86_64__
 # define TCG_TARGET_REG_BITS  64
 #else
-# define TCG_TARGET_REG_BITS  32
+# error
 #endif
 
 #endif
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 3cbdfbca52..7ebae56a7d 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -27,13 +27,8 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE  1
 
-#ifdef __x86_64__
-# define TCG_TARGET_NB_REGS   32
-# define MAX_CODE_GEN_BUFFER_SIZE  (2 * GiB)
-#else
-# define TCG_TARGET_NB_REGS   24
-# define MAX_CODE_GEN_BUFFER_SIZE  UINT32_MAX
-#endif
+#define TCG_TARGET_NB_REGS   32
+#define MAX_CODE_GEN_BUFFER_SIZE  (2 * GiB)
 
 typedef enum {
     TCG_REG_EAX = 0,
@@ -45,8 +40,6 @@ typedef enum {
     TCG_REG_ESI,
     TCG_REG_EDI,
 
-    /* 64-bit registers; always define the symbols to avoid
-       too much if-deffing.  */
     TCG_REG_R8,
     TCG_REG_R9,
     TCG_REG_R10,
@@ -64,8 +57,6 @@ typedef enum {
     TCG_REG_XMM5,
     TCG_REG_XMM6,
     TCG_REG_XMM7,
-
-    /* 64-bit registers; likewise always define.  */
     TCG_REG_XMM8,
     TCG_REG_XMM9,
     TCG_REG_XMM10,
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index ee27266861..92251f8327 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -34,32 +34,22 @@
 #if defined(_WIN64)
 # define TCG_TARGET_CALL_ARG_I128    TCG_CALL_ARG_BY_REF
 # define TCG_TARGET_CALL_RET_I128    TCG_CALL_RET_BY_VEC
-#elif TCG_TARGET_REG_BITS == 64
-# define TCG_TARGET_CALL_ARG_I128    TCG_CALL_ARG_NORMAL
-# define TCG_TARGET_CALL_RET_I128    TCG_CALL_RET_NORMAL
 #else
 # define TCG_TARGET_CALL_ARG_I128    TCG_CALL_ARG_NORMAL
-# define TCG_TARGET_CALL_RET_I128    TCG_CALL_RET_BY_REF
+# define TCG_TARGET_CALL_RET_I128    TCG_CALL_RET_NORMAL
 #endif
 
 #ifdef CONFIG_DEBUG_TCG
 static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
-#if TCG_TARGET_REG_BITS == 64
     "%rax", "%rcx", "%rdx", "%rbx", "%rsp", "%rbp", "%rsi", "%rdi",
-#else
-    "%eax", "%ecx", "%edx", "%ebx", "%esp", "%ebp", "%esi", "%edi",
-#endif
     "%r8",  "%r9",  "%r10", "%r11", "%r12", "%r13", "%r14", "%r15",
     "%xmm0", "%xmm1", "%xmm2", "%xmm3", "%xmm4", "%xmm5", "%xmm6", "%xmm7",
-#if TCG_TARGET_REG_BITS == 64
     "%xmm8", "%xmm9", "%xmm10", "%xmm11",
     "%xmm12", "%xmm13", "%xmm14", "%xmm15",
-#endif
 };
 #endif
 
 static const int tcg_target_reg_alloc_order[] = {
-#if TCG_TARGET_REG_BITS == 64
     TCG_REG_RBP,
     TCG_REG_RBX,
     TCG_REG_R12,
@@ -75,15 +65,6 @@ static const int tcg_target_reg_alloc_order[] = {
     TCG_REG_RSI,
     TCG_REG_RDI,
     TCG_REG_RAX,
-#else
-    TCG_REG_EBX,
-    TCG_REG_ESI,
-    TCG_REG_EDI,
-    TCG_REG_EBP,
-    TCG_REG_ECX,
-    TCG_REG_EDX,
-    TCG_REG_EAX,
-#endif
     TCG_REG_XMM0,
     TCG_REG_XMM1,
     TCG_REG_XMM2,
@@ -95,7 +76,6 @@ static const int tcg_target_reg_alloc_order[] = {
        any of them.  Therefore only allow xmm0-xmm5 to be allocated.  */
     TCG_REG_XMM6,
     TCG_REG_XMM7,
-#if TCG_TARGET_REG_BITS == 64
     TCG_REG_XMM8,
     TCG_REG_XMM9,
     TCG_REG_XMM10,
@@ -105,13 +85,11 @@ static const int tcg_target_reg_alloc_order[] = {
     TCG_REG_XMM14,
     TCG_REG_XMM15,
 #endif
-#endif
 };
 
 #define TCG_TMP_VEC  TCG_REG_XMM5
 
 static const int tcg_target_call_iarg_regs[] = {
-#if TCG_TARGET_REG_BITS == 64
 #if defined(_WIN64)
     TCG_REG_RCX,
     TCG_REG_RDX,
@@ -123,9 +101,6 @@ static const int tcg_target_call_iarg_regs[] = {
 #endif
     TCG_REG_R8,
     TCG_REG_R9,
-#else
-    /* 32 bit mode uses stack based calling convention (GCC default). */
-#endif
 };
 
 static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
@@ -152,26 +127,13 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define TCG_CT_CONST_TST 0x1000
 #define TCG_CT_CONST_ZERO 0x2000
 
-/* Registers used with L constraint, which are the first argument
-   registers on x86_64, and two random call clobbered registers on
-   i386. */
-#if TCG_TARGET_REG_BITS == 64
-# define TCG_REG_L0 tcg_target_call_iarg_regs[0]
-# define TCG_REG_L1 tcg_target_call_iarg_regs[1]
-#else
-# define TCG_REG_L0 TCG_REG_EAX
-# define TCG_REG_L1 TCG_REG_EDX
-#endif
+/* Registers used with L constraint. */
+#define TCG_REG_L0 tcg_target_call_iarg_regs[0]
+#define TCG_REG_L1 tcg_target_call_iarg_regs[1]
 
-#if TCG_TARGET_REG_BITS == 64
-# define ALL_GENERAL_REGS      0x0000ffffu
-# define ALL_VECTOR_REGS       0xffff0000u
-# define ALL_BYTEL_REGS        ALL_GENERAL_REGS
-#else
-# define ALL_GENERAL_REGS      0x000000ffu
-# define ALL_VECTOR_REGS       0x00ff0000u
-# define ALL_BYTEL_REGS        0x0000000fu
-#endif
+#define ALL_GENERAL_REGS      0x0000ffffu
+#define ALL_VECTOR_REGS       0xffff0000u
+#define ALL_BYTEL_REGS        ALL_GENERAL_REGS
 #define SOFTMMU_RESERVE_REGS \
     (tcg_use_softmmu ? (1 << TCG_REG_L0) | (1 << TCG_REG_L1) : 0)
 
@@ -184,14 +146,12 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
 {
     value += addend;
-    switch(type) {
+    switch (type) {
     case R_386_PC32:
         value -= (uintptr_t)tcg_splitwx_to_rx(code_ptr);
         if (value != (int32_t)value) {
             return false;
         }
-        /* FALLTHRU */
-    case R_386_32:
         tcg_patch32(code_ptr, value);
         break;
     case R_386_PC8:
@@ -256,17 +216,10 @@ static bool tcg_target_const_match(int64_t val, int ct,
 #define P_EXT38         0x200           /* 0x0f 0x38 opcode prefix */
 #define P_DATA16        0x400           /* 0x66 opcode prefix */
 #define P_VEXW          0x1000          /* Set VEX.W = 1 */
-#if TCG_TARGET_REG_BITS == 64
-# define P_REXW         P_VEXW          /* Set REX.W = 1; match VEXW */
-# define P_REXB_R       0x2000          /* REG field as byte register */
-# define P_REXB_RM      0x4000          /* R/M field as byte register */
-# define P_GS           0x8000          /* gs segment override */
-#else
-# define P_REXW		0
-# define P_REXB_R	0
-# define P_REXB_RM	0
-# define P_GS           0
-#endif
+#define P_REXW          P_VEXW          /* Set REX.W = 1; match VEXW */
+#define P_REXB_R        0x2000          /* REG field as byte register */
+#define P_REXB_RM       0x4000          /* R/M field as byte register */
+#define P_GS            0x8000          /* gs segment override */
 #define P_EXT3A         0x10000         /* 0x0f 0x3a opcode prefix */
 #define P_SIMDF3        0x20000         /* 0xf3 opcode prefix */
 #define P_SIMDF2        0x40000         /* 0xf2 opcode prefix */
@@ -571,7 +524,6 @@ static const uint8_t tcg_cond_to_jcc[] = {
     [TCG_COND_TSTNE] = JCC_JNE,
 };
 
-#if TCG_TARGET_REG_BITS == 64
 static void tcg_out_opc(TCGContext *s, int opc, int r, int rm, int x)
 {
     int rex;
@@ -619,32 +571,6 @@ static void tcg_out_opc(TCGContext *s, int opc, int r, int rm, int x)
 
     tcg_out8(s, opc);
 }
-#else
-static void tcg_out_opc(TCGContext *s, int opc)
-{
-    if (opc & P_DATA16) {
-        tcg_out8(s, 0x66);
-    }
-    if (opc & P_SIMDF3) {
-        tcg_out8(s, 0xf3);
-    } else if (opc & P_SIMDF2) {
-        tcg_out8(s, 0xf2);
-    }
-    if (opc & (P_EXT | P_EXT38 | P_EXT3A)) {
-        tcg_out8(s, 0x0f);
-        if (opc & P_EXT38) {
-            tcg_out8(s, 0x38);
-        } else if (opc & P_EXT3A) {
-            tcg_out8(s, 0x3a);
-        }
-    }
-    tcg_out8(s, opc);
-}
-/* Discard the register arguments to tcg_out_opc early, so as not to penalize
-   the 32-bit compilation paths.  This method works with all versions of gcc,
-   whereas relying on optimization may not be able to exclude them.  */
-#define tcg_out_opc(s, opc, r, rm, x)  (tcg_out_opc)(s, opc)
-#endif
 
 static void tcg_out_modrm(TCGContext *s, int opc, int r, int rm)
 {
@@ -790,35 +716,32 @@ static void tcg_out_sib_offset(TCGContext *s, int r, int rm, int index,
     int mod, len;
 
     if (index < 0 && rm < 0) {
-        if (TCG_TARGET_REG_BITS == 64) {
-            /* Try for a rip-relative addressing mode.  This has replaced
-               the 32-bit-mode absolute addressing encoding.  */
-            intptr_t pc = (intptr_t)s->code_ptr + 5 + ~rm;
-            intptr_t disp = offset - pc;
-            if (disp == (int32_t)disp) {
-                tcg_out8(s, (LOWREGMASK(r) << 3) | 5);
-                tcg_out32(s, disp);
-                return;
-            }
+        /*
+         * Try for a rip-relative addressing mode.  This has replaced
+         * the 32-bit-mode absolute addressing encoding.
+         */
+        intptr_t pc = (intptr_t)s->code_ptr + 5 + ~rm;
+        intptr_t disp = offset - pc;
+        if (disp == (int32_t)disp) {
+            tcg_out8(s, (LOWREGMASK(r) << 3) | 5);
+            tcg_out32(s, disp);
+            return;
+        }
 
-            /* Try for an absolute address encoding.  This requires the
-               use of the MODRM+SIB encoding and is therefore larger than
-               rip-relative addressing.  */
-            if (offset == (int32_t)offset) {
-                tcg_out8(s, (LOWREGMASK(r) << 3) | 4);
-                tcg_out8(s, (4 << 3) | 5);
-                tcg_out32(s, offset);
-                return;
-            }
-
-            /* ??? The memory isn't directly addressable.  */
-            g_assert_not_reached();
-        } else {
-            /* Absolute address.  */
-            tcg_out8(s, (r << 3) | 5);
+        /*
+         * Try for an absolute address encoding.  This requires the
+         * use of the MODRM+SIB encoding and is therefore larger than
+         * rip-relative addressing.
+         */
+        if (offset == (int32_t)offset) {
+            tcg_out8(s, (LOWREGMASK(r) << 3) | 4);
+            tcg_out8(s, (4 << 3) | 5);
             tcg_out32(s, offset);
             return;
         }
+
+        /* ??? The memory isn't directly addressable.  */
+        g_assert_not_reached();
     }
 
     /* Find the length of the immediate addend.  Note that the encoding
@@ -1045,27 +968,14 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
         return;
     }
 
-    if (TCG_TARGET_REG_BITS == 32 && vece < MO_64) {
-        if (have_avx2) {
-            tcg_out_vex_modrm_pool(s, OPC_VPBROADCASTD + vex_l, ret);
-        } else {
-            tcg_out_vex_modrm_pool(s, OPC_VBROADCASTSS, ret);
-        }
-        new_pool_label(s, arg, R_386_32, s->code_ptr - 4, 0);
+    if (type == TCG_TYPE_V64) {
+        tcg_out_vex_modrm_pool(s, OPC_MOVQ_VqWq, ret);
+    } else if (have_avx2) {
+        tcg_out_vex_modrm_pool(s, OPC_VPBROADCASTQ + vex_l, ret);
     } else {
-        if (type == TCG_TYPE_V64) {
-            tcg_out_vex_modrm_pool(s, OPC_MOVQ_VqWq, ret);
-        } else if (have_avx2) {
-            tcg_out_vex_modrm_pool(s, OPC_VPBROADCASTQ + vex_l, ret);
-        } else {
-            tcg_out_vex_modrm_pool(s, OPC_MOVDDUP, ret);
-        }
-        if (TCG_TARGET_REG_BITS == 64) {
-            new_pool_label(s, arg, R_386_PC32, s->code_ptr - 4, -4);
-        } else {
-            new_pool_l2(s, R_386_32, s->code_ptr - 4, 0, arg, arg >> 32);
-        }
+        tcg_out_vex_modrm_pool(s, OPC_MOVDDUP, ret);
     }
+    new_pool_label(s, arg, R_386_PC32, s->code_ptr - 4, -4);
 }
 
 static void tcg_out_movi_vec(TCGContext *s, TCGType type,
@@ -1082,11 +992,7 @@ static void tcg_out_movi_vec(TCGContext *s, TCGType type,
 
     int rexw = (type == TCG_TYPE_I32 ? 0 : P_REXW);
     tcg_out_vex_modrm_pool(s, OPC_MOVD_VyEy + rexw, ret);
-    if (TCG_TARGET_REG_BITS == 64) {
-        new_pool_label(s, arg, R_386_PC32, s->code_ptr - 4, -4);
-    } else {
-        new_pool_label(s, arg, R_386_32, s->code_ptr - 4, 0);
-    }
+    new_pool_label(s, arg, R_386_PC32, s->code_ptr - 4, -4);
 }
 
 static void tcg_out_movi_int(TCGContext *s, TCGType type,
@@ -1127,9 +1033,7 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
 {
     switch (type) {
     case TCG_TYPE_I32:
-#if TCG_TARGET_REG_BITS == 64
     case TCG_TYPE_I64:
-#endif
         if (ret < 16) {
             tcg_out_movi_int(s, type, ret, arg);
         } else {
@@ -1292,7 +1196,7 @@ static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
                         TCGReg base, intptr_t ofs)
 {
     int rexw = 0;
-    if (TCG_TARGET_REG_BITS == 64 && type == TCG_TYPE_I64) {
+    if (type == TCG_TYPE_I64) {
         if (val != (int32_t)val) {
             return false;
         }
@@ -1331,31 +1235,12 @@ static inline void tcg_out_rolw_8(TCGContext *s, int reg)
 
 static void tcg_out_ext8u(TCGContext *s, TCGReg dest, TCGReg src)
 {
-    if (TCG_TARGET_REG_BITS == 32 && src >= 4) {
-        tcg_out_mov(s, TCG_TYPE_I32, dest, src);
-        if (dest >= 4) {
-            tcg_out_modrm(s, OPC_ARITH_EvIz, ARITH_AND, dest);
-            tcg_out32(s, 0xff);
-            return;
-        }
-        src = dest;
-    }
     tcg_out_modrm(s, OPC_MOVZBL + P_REXB_RM, dest, src);
 }
 
 static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg dest, TCGReg src)
 {
     int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
-
-    if (TCG_TARGET_REG_BITS == 32 && src >= 4) {
-        tcg_out_mov(s, TCG_TYPE_I32, dest, src);
-        if (dest >= 4) {
-            tcg_out_shifti(s, SHIFT_SHL, dest, 24);
-            tcg_out_shifti(s, SHIFT_SAR, dest, 24);
-            return;
-        }
-        src = dest;
-    }
     tcg_out_modrm(s, OPC_MOVSBL + P_REXB_RM + rexw, dest, src);
 }
 
@@ -1380,7 +1265,6 @@ static void tcg_out_ext32u(TCGContext *s, TCGReg dest, TCGReg src)
 
 static void tcg_out_ext32s(TCGContext *s, TCGReg dest, TCGReg src)
 {
-    tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
     tcg_out_modrm(s, OPC_MOVSLQ, dest, src);
 }
 
@@ -1409,12 +1293,9 @@ static inline void tcg_out_bswap64(TCGContext *s, int reg)
 static void tgen_arithi(TCGContext *s, int c, int r0,
                         tcg_target_long val, int cf)
 {
-    int rexw = 0;
+    int rexw = c & -8;
 
-    if (TCG_TARGET_REG_BITS == 64) {
-        rexw = c & -8;
-        c &= 7;
-    }
+    c &= 7;
 
     switch (c) {
     case ARITH_ADD:
@@ -1427,16 +1308,12 @@ static void tgen_arithi(TCGContext *s, int c, int r0,
              */
             if (val == 1 || val == -1) {
                 int is_inc = (c == ARITH_ADD) ^ (val < 0);
-                if (TCG_TARGET_REG_BITS == 64) {
-                    /*
-                     * The single-byte increment encodings are re-tasked
-                     * as the REX prefixes.  Use the MODRM encoding.
-                     */
-                    tcg_out_modrm(s, OPC_GRP5 + rexw,
-                                  (is_inc ? EXT5_INC_Ev : EXT5_DEC_Ev), r0);
-                } else {
-                    tcg_out8(s, (is_inc ? OPC_INC_r32 : OPC_DEC_r32) + r0);
-                }
+                /*
+                 * The single-byte increment encodings are re-tasked
+                 * as the REX prefixes.  Use the MODRM encoding.
+                 */
+                tcg_out_modrm(s, OPC_GRP5 + rexw,
+                              (is_inc ? EXT5_INC_Ev : EXT5_DEC_Ev), r0);
                 return;
             }
             if (val == 128) {
@@ -1451,17 +1328,15 @@ static void tgen_arithi(TCGContext *s, int c, int r0,
         break;
 
     case ARITH_AND:
-        if (TCG_TARGET_REG_BITS == 64) {
-            if (val == 0xffffffffu) {
-                tcg_out_ext32u(s, r0, r0);
-                return;
-            }
-            if (val == (uint32_t)val) {
-                /* AND with no high bits set can use a 32-bit operation.  */
-                rexw = 0;
-            }
+        if (val == 0xffffffffu) {
+            tcg_out_ext32u(s, r0, r0);
+            return;
         }
-        if (val == 0xffu && (r0 < 4 || TCG_TARGET_REG_BITS == 64)) {
+        if (val == (uint32_t)val) {
+            /* AND with no high bits set can use a 32-bit operation.  */
+            rexw = 0;
+        }
+        if (val == 0xffu) {
             tcg_out_ext8u(s, r0, r0);
             return;
         }
@@ -1473,8 +1348,7 @@ static void tgen_arithi(TCGContext *s, int c, int r0,
 
     case ARITH_OR:
     case ARITH_XOR:
-        if (val >= 0x80 && val <= 0xff
-            && (r0 < 4 || TCG_TARGET_REG_BITS == 64)) {
+        if (val >= 0x80 && val <= 0xff) {
             tcg_out_modrm(s, OPC_ARITH_EbIb + P_REXB_RM, c, r0);
             tcg_out8(s, val);
             return;
@@ -1577,7 +1451,7 @@ static int tcg_out_cmp(TCGContext *s, TCGCond cond, TCGArg arg1,
         return jz;
     }
 
-    if (arg2 <= 0xff && (TCG_TARGET_REG_BITS == 64 || arg1 < 4)) {
+    if (arg2 <= 0xff) {
         if (arg2 == 0x80) {
             tcg_out_modrm(s, OPC_TESTB | P_REXB_R, arg1, arg1);
             return js;
@@ -1669,53 +1543,6 @@ static const TCGOutOpBrcond outop_brcond = {
     .out_ri = tgen_brcondi,
 };
 
-static void tcg_out_brcond2(TCGContext *s, TCGCond cond, TCGReg al,
-                            TCGReg ah, TCGArg bl, bool blconst,
-                            TCGArg bh, bool bhconst,
-                            TCGLabel *label_this, bool small)
-{
-    TCGLabel *label_next = gen_new_label();
-
-    switch (cond) {
-    case TCG_COND_EQ:
-    case TCG_COND_TSTEQ:
-        tcg_out_brcond(s, 0, tcg_invert_cond(cond),
-                       al, bl, blconst, label_next, true);
-        tcg_out_brcond(s, 0, cond, ah, bh, bhconst, label_this, small);
-        break;
-
-    case TCG_COND_NE:
-    case TCG_COND_TSTNE:
-        tcg_out_brcond(s, 0, cond, al, bl, blconst, label_this, small);
-        tcg_out_brcond(s, 0, cond, ah, bh, bhconst, label_this, small);
-        break;
-
-    default:
-        tcg_out_brcond(s, 0, tcg_high_cond(cond),
-                       ah, bh, bhconst, label_this, small);
-        tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond(s, 0, tcg_unsigned_cond(cond),
-                       al, bl, blconst, label_this, small);
-        break;
-    }
-    tcg_out_label(s, label_next);
-}
-
-static void tgen_brcond2(TCGContext *s, TCGCond cond, TCGReg al,
-                         TCGReg ah, TCGArg bl, bool blconst,
-                         TCGArg bh, bool bhconst, TCGLabel *l)
-{
-    tcg_out_brcond2(s, cond, al, ah, bl, blconst, bh, bhconst, l, false);
-}
-
-#if TCG_TARGET_REG_BITS != 32
-__attribute__((unused))
-#endif
-static const TCGOutOpBrcond2 outop_brcond2 = {
-    .base.static_constraint = C_O0_I4(r, r, ri, ri),
-    .out = tgen_brcond2,
-};
-
 static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
                             TCGReg dest, TCGReg arg1, TCGArg arg2,
                             bool const_arg2, bool neg)
@@ -1867,54 +1694,6 @@ static const TCGOutOpSetcond outop_negsetcond = {
     .out_rri = tgen_negsetcondi,
 };
 
-static void tgen_setcond2(TCGContext *s, TCGCond cond, TCGReg ret,
-                          TCGReg al, TCGReg ah,
-                          TCGArg bl, bool const_bl,
-                          TCGArg bh, bool const_bh)
-{
-    TCGLabel *label_over = gen_new_label();
-
-    if (ret == al || ret == ah
-        || (!const_bl && ret == bl)
-        || (!const_bh && ret == bh)) {
-        /*
-         * When the destination overlaps with one of the argument
-         * registers, don't do anything tricky.
-         */
-        TCGLabel *label_true = gen_new_label();
-
-        tcg_out_brcond2(s, cond, al, ah, bl, const_bl,
-                        bh, const_bh, label_true, true);
-
-        tcg_out_movi(s, TCG_TYPE_I32, ret, 0);
-        tcg_out_jxx(s, JCC_JMP, label_over, 1);
-        tcg_out_label(s, label_true);
-
-        tcg_out_movi(s, TCG_TYPE_I32, ret, 1);
-    } else {
-        /*
-         * When the destination does not overlap one of the arguments,
-         * clear the destination first, jump if cond false, and emit an
-         * increment in the true case.  This results in smaller code.
-         */
-        tcg_out_movi(s, TCG_TYPE_I32, ret, 0);
-
-        tcg_out_brcond2(s, tcg_invert_cond(cond), al, ah, bl, const_bl,
-                        bh, const_bh, label_over, true);
-
-        tgen_arithi(s, ARITH_ADD, ret, 1, 0);
-    }
-    tcg_out_label(s, label_over);
-}
-
-#if TCG_TARGET_REG_BITS != 32
-__attribute__((unused))
-#endif
-static const TCGOutOpSetcond2 outop_setcond2 = {
-    .base.static_constraint = C_O1_I4(r, r, r, ri, ri),
-    .out = tgen_setcond2,
-};
-
 static void tcg_out_cmov(TCGContext *s, int jcc, int rexw,
                          TCGReg dest, TCGReg v1)
 {
@@ -1959,22 +1738,6 @@ static void tcg_out_call(TCGContext *s, const tcg_insn_unit *dest,
                          const TCGHelperInfo *info)
 {
     tcg_out_branch(s, 1, dest);
-
-#ifndef _WIN32
-    if (TCG_TARGET_REG_BITS == 32 && info->out_kind == TCG_CALL_RET_BY_REF) {
-        /*
-         * The sysv i386 abi for struct return places a reference as the
-         * first argument of the stack, and pops that argument with the
-         * return statement.  Since we want to retain the aligned stack
-         * pointer for the callee, we do not want to actually push that
-         * argument before the call but rely on the normal store to the
-         * stack slot.  But we do need to compensate for the pop in order
-         * to reset our correct stack pointer value.
-         * Pushing a garbage value back onto the stack is quickest.
-         */
-        tcg_out_push(s, TCG_REG_EAX);
-    }
-#endif
 }
 
 static void tcg_out_jmp(TCGContext *s, const tcg_insn_unit *dest)
@@ -2025,15 +1788,13 @@ bool tcg_target_has_memory_bswap(MemOp memop)
 }
 
 /*
- * Because i686 has no register parameters and because x86_64 has xchg
- * to handle addr/data register overlap, we have placed all input arguments
- * before we need might need a scratch reg.
+ * Because x86_64 has xchg to handle addr/data register overlap, we have
+ * placed all input arguments before we need might need a scratch reg.
  *
  * Even then, a scratch is only needed for l->raddr.  Rather than expose
  * a general-purpose scratch when we don't actually know it's available,
  * use the ra_gen hook to load into RAX if needed.
  */
-#if TCG_TARGET_REG_BITS == 64
 static TCGReg ldst_ra_gen(TCGContext *s, const TCGLabelQemuLdst *l, int arg)
 {
     if (arg < 0) {
@@ -2042,12 +1803,10 @@ static TCGReg ldst_ra_gen(TCGContext *s, const TCGLabelQemuLdst *l, int arg)
     tcg_out_movi(s, TCG_TYPE_PTR, arg, (uintptr_t)l->raddr);
     return arg;
 }
+
 static const TCGLdstHelperParam ldst_helper_param = {
     .ra_gen = ldst_ra_gen
 };
-#else
-static const TCGLdstHelperParam ldst_helper_param = { };
-#endif
 
 static void tcg_out_vec_to_pair(TCGContext *s, TCGType type,
                                 TCGReg l, TCGReg h, TCGReg v)
@@ -2121,7 +1880,7 @@ static HostAddress x86_guest_base = {
     .index = -1
 };
 
-#if defined(__x86_64__) && defined(__linux__)
+#if defined(__linux__)
 # include <asm/prctl.h>
 # include <sys/prctl.h>
 int arch_prctl(int code, unsigned long addr);
@@ -2133,8 +1892,7 @@ static inline int setup_guest_base_seg(void)
     return 0;
 }
 #define setup_guest_base_seg  setup_guest_base_seg
-#elif defined(__x86_64__) && \
-      (defined (__FreeBSD__) || defined (__FreeBSD_kernel__))
+#elif defined (__FreeBSD__) || defined (__FreeBSD_kernel__)
 # include <machine/sysarch.h>
 static inline int setup_guest_base_seg(void)
 {
@@ -2195,14 +1953,12 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst->oi = oi;
         ldst->addr_reg = addr;
 
-        if (TCG_TARGET_REG_BITS == 64) {
-            ttype = s->addr_type;
-            trexw = (ttype == TCG_TYPE_I32 ? 0 : P_REXW);
-            if (TCG_TYPE_PTR == TCG_TYPE_I64) {
-                hrexw = P_REXW;
-                tlbtype = TCG_TYPE_I64;
-                tlbrexw = P_REXW;
-            }
+        ttype = s->addr_type;
+        trexw = (ttype == TCG_TYPE_I32 ? 0 : P_REXW);
+        if (TCG_TYPE_PTR == TCG_TYPE_I64) {
+            hrexw = P_REXW;
+            tlbtype = TCG_TYPE_I64;
+            tlbrexw = P_REXW;
         }
 
         tcg_out_mov(s, tlbtype, TCG_REG_L0, addr);
@@ -2314,7 +2070,6 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
         tcg_out_modrm_sib_offset(s, movop + h.seg, datalo,
                                  h.base, h.index, 0, h.ofs);
         break;
-#if TCG_TARGET_REG_BITS == 64
     case MO_SL:
         if (use_movbe) {
             tcg_out_modrm_sib_offset(s, OPC_MOVBE_GyMy + h.seg, datalo,
@@ -2325,34 +2080,12 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
                                      h.base, h.index, 0, h.ofs);
         }
         break;
-#endif
     case MO_UQ:
-        if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_modrm_sib_offset(s, movop + P_REXW + h.seg, datalo,
-                                     h.base, h.index, 0, h.ofs);
-            break;
-        }
-        if (use_movbe) {
-            TCGReg t = datalo;
-            datalo = datahi;
-            datahi = t;
-        }
-        if (h.base == datalo || h.index == datalo) {
-            tcg_out_modrm_sib_offset(s, OPC_LEA, datahi,
-                                     h.base, h.index, 0, h.ofs);
-            tcg_out_modrm_offset(s, movop + h.seg, datalo, datahi, 0);
-            tcg_out_modrm_offset(s, movop + h.seg, datahi, datahi, 4);
-        } else {
-            tcg_out_modrm_sib_offset(s, movop + h.seg, datalo,
-                                     h.base, h.index, 0, h.ofs);
-            tcg_out_modrm_sib_offset(s, movop + h.seg, datahi,
-                                     h.base, h.index, 0, h.ofs + 4);
-        }
+        tcg_out_modrm_sib_offset(s, movop + P_REXW + h.seg, datalo,
+                                 h.base, h.index, 0, h.ofs);
         break;
 
     case MO_128:
-        tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
-
         /*
          * Without 16-byte atomicity, use integer regs.
          * That is where we want the data, and it allows bswaps.
@@ -2483,8 +2216,6 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
 
     switch (memop & MO_SIZE) {
     case MO_8:
-        /* This is handled with constraints in cset_qemu_st(). */
-        tcg_debug_assert(TCG_TARGET_REG_BITS == 64 || datalo < 4);
         tcg_out_modrm_sib_offset(s, OPC_MOVB_EvGv + P_REXB_R + h.seg,
                                  datalo, h.base, h.index, 0, h.ofs);
         break;
@@ -2497,25 +2228,11 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
                                  h.base, h.index, 0, h.ofs);
         break;
     case MO_64:
-        if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_modrm_sib_offset(s, movop + P_REXW + h.seg, datalo,
-                                     h.base, h.index, 0, h.ofs);
-        } else {
-            if (use_movbe) {
-                TCGReg t = datalo;
-                datalo = datahi;
-                datahi = t;
-            }
-            tcg_out_modrm_sib_offset(s, movop + h.seg, datalo,
-                                     h.base, h.index, 0, h.ofs);
-            tcg_out_modrm_sib_offset(s, movop + h.seg, datahi,
-                                     h.base, h.index, 0, h.ofs + 4);
-        }
+        tcg_out_modrm_sib_offset(s, movop + P_REXW + h.seg, datalo,
+                                 h.base, h.index, 0, h.ofs);
         break;
 
     case MO_128:
-        tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
-
         /*
          * Without 16-byte atomicity, use integer regs.
          * That is where we have the data, and it allows bswaps.
@@ -2592,16 +2309,8 @@ static void tgen_qemu_st(TCGContext *s, TCGType type, TCGReg data,
     }
 }
 
-static TCGConstraintSetIndex cset_qemu_st(TCGType type, unsigned flags)
-{
-    return flags == MO_8 ? C_O0_I2(s, L) : C_O0_I2(L, L);
-}
-
 static const TCGOutOpQemuLdSt outop_qemu_st = {
-    .base.static_constraint =
-        TCG_TARGET_REG_BITS == 32 ? C_Dynamic : C_O0_I2(L, L),
-    .base.dynamic_constraint =
-        TCG_TARGET_REG_BITS == 32 ? cset_qemu_st : NULL,
+    .base.static_constraint = C_O0_I2(L, L),
     .out = tgen_qemu_st,
 };
 
@@ -2958,7 +2667,6 @@ static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_NotImplemented,
 };
 
-#if TCG_TARGET_REG_BITS == 64
 static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
 {
     tcg_out_shifti(s, SHIFT_SHR + P_REXW, a0, 32);
@@ -2968,7 +2676,6 @@ static const TCGOutOpUnary outop_extrh_i64_i32 = {
     .base.static_constraint = C_O1_I1(r, 0),
     .out_rr = tgen_extrh_i64_i32,
 };
-#endif /* TCG_TARGET_REG_BITS == 64 */
 
 static void tgen_mul(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
@@ -3320,7 +3027,6 @@ static const TCGOutOpBswap outop_bswap32 = {
     .out_rr = tgen_bswap32,
 };
 
-#if TCG_TARGET_REG_BITS == 64
 static void tgen_bswap64(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tcg_out_bswap64(s, a0);
@@ -3330,7 +3036,6 @@ static const TCGOutOpUnary outop_bswap64 = {
     .base.static_constraint = C_O1_I1(r, 0),
     .out_rr = tgen_bswap64,
 };
-#endif
 
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
@@ -3361,8 +3066,6 @@ static void tgen_deposit(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
         tcg_out_modrm(s, OPC_MOVB_EvGv | P_REXB_R | P_REXB_RM, a2, a0);
     } else if (ofs == 0 && len == 16) {
         tcg_out_modrm(s, OPC_MOVL_EvGv | P_DATA16, a2, a0);
-    } else if (TCG_TARGET_REG_BITS == 32 && ofs == 8 && len == 8) {
-        tcg_out_modrm(s, OPC_MOVB_EvGv, a2, a0 + 4);
     } else {
         g_assert_not_reached();
     }
@@ -3377,9 +3080,6 @@ static void tgen_depositi(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
     } else if (ofs == 0 && len == 16) {
         tcg_out_opc(s, OPC_MOVL_Iv | P_DATA16 | LOWREGMASK(a0), 0, a0, 0);
         tcg_out16(s, a2);
-    } else if (TCG_TARGET_REG_BITS == 32 && ofs == 8 && len == 8) {
-        tcg_out8(s, OPC_MOVB_Ib + a0 + 4);
-        tcg_out8(s, a2);
     } else {
         g_assert_not_reached();
     }
@@ -3406,7 +3106,7 @@ static void tgen_extract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
             tcg_out_ext32u(s, a0, a1);
             return;
         }
-    } else if (TCG_TARGET_REG_BITS == 64 && ofs + len == 32) {
+    } else if (ofs + len == 32) {
         /* This is a 32-bit zero-extending right shift.  */
         tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
         tcg_out_shifti(s, SHIFT_SHR, a0, ofs);
@@ -3417,7 +3117,7 @@ static void tgen_extract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
          * Otherwise we emit the same ext16 + shift pattern that we
          * would have gotten from the normal tcg-op.c expansion.
          */
-        if (a1 < 4 && (TCG_TARGET_REG_BITS == 32 || a0 < 8)) {
+        if (a1 < 4 && a0 < 8) {
             tcg_out_modrm(s, OPC_MOVZBL, a0, a1 + 4);
         } else {
             tcg_out_ext16u(s, a0, a1);
@@ -3526,7 +3226,6 @@ static const TCGOutOpLoad outop_ld16s = {
     .out = tgen_ld16s,
 };
 
-#if TCG_TARGET_REG_BITS == 64
 static void tgen_ld32u(TCGContext *s, TCGType type, TCGReg dest,
                        TCGReg base, ptrdiff_t offset)
 {
@@ -3548,7 +3247,6 @@ static const TCGOutOpLoad outop_ld32s = {
     .base.static_constraint = C_O1_I1(r, r),
     .out = tgen_ld32s,
 };
-#endif
 
 static void tgen_st8_r(TCGContext *s, TCGType type, TCGReg data,
                        TCGReg base, ptrdiff_t offset)
@@ -3990,16 +3688,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         a1 = a2;
         a2 = args[3];
         goto gen_simd;
-#if TCG_TARGET_REG_BITS == 32
-    case INDEX_op_dup2_vec:
-        /* First merge the two 32-bit inputs to a single 64-bit element. */
-        tcg_out_vex_modrm(s, OPC_PUNPCKLDQ, a0, a1, a2);
-        /* Then replicate the 64-bit elements across the rest of the vector. */
-        if (type != TCG_TYPE_V64) {
-            tcg_out_dup_vec(s, type, MO_64, a0, a0);
-        }
-        break;
-#endif
     case INDEX_op_abs_vec:
         insn = abs_insn[vece];
         a2 = a1;
@@ -4194,9 +3882,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_x86_punpckh_vec:
     case INDEX_op_x86_vpshldi_vec:
     case INDEX_op_x86_vgf2p8affineqb_vec:
-#if TCG_TARGET_REG_BITS == 32
-    case INDEX_op_dup2_vec:
-#endif
         return C_O1_I2(x, x, x);
 
     case INDEX_op_abs_vec:
@@ -4732,7 +4417,6 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
 }
 
 static const int tcg_target_callee_save_regs[] = {
-#if TCG_TARGET_REG_BITS == 64
     TCG_REG_RBP,
     TCG_REG_RBX,
 #if defined(_WIN64)
@@ -4743,20 +4427,13 @@ static const int tcg_target_callee_save_regs[] = {
     TCG_REG_R13,
     TCG_REG_R14, /* Currently used for the global env. */
     TCG_REG_R15,
-#else
-    TCG_REG_EBP, /* Currently used for the global env. */
-    TCG_REG_EBX,
-    TCG_REG_ESI,
-    TCG_REG_EDI,
-#endif
 };
 
 /* Compute frame size via macros, to share between tcg_target_qemu_prologue
    and tcg_register_jit.  */
 
 #define PUSH_SIZE \
-    ((1 + ARRAY_SIZE(tcg_target_callee_save_regs)) \
-     * (TCG_TARGET_REG_BITS / 8))
+    ((1 + ARRAY_SIZE(tcg_target_callee_save_regs)) * sizeof(tcg_target_long))
 
 #define FRAME_SIZE \
     ((PUSH_SIZE \
@@ -4789,7 +4466,6 @@ static void tcg_target_qemu_prologue(TCGContext *s)
         } else if (guest_base == (int32_t)guest_base) {
             x86_guest_base.ofs = guest_base;
         } else {
-            assert(TCG_TARGET_REG_BITS == 64);
             /* Choose R12 because, as a base, it requires a SIB byte. */
             x86_guest_base.index = TCG_REG_R12;
             tcg_out_movi(s, TCG_TYPE_PTR, x86_guest_base.index, guest_base);
@@ -4797,20 +4473,10 @@ static void tcg_target_qemu_prologue(TCGContext *s)
         }
     }
 
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_out_ld(s, TCG_TYPE_PTR, TCG_AREG0, TCG_REG_ESP,
-                   (ARRAY_SIZE(tcg_target_callee_save_regs) + 1) * 4);
-        tcg_out_addi(s, TCG_REG_ESP, -stack_addend);
-        /* jmp *tb.  */
-        tcg_out_modrm_offset(s, OPC_GRP5, EXT5_JMPN_Ev, TCG_REG_ESP,
-                             (ARRAY_SIZE(tcg_target_callee_save_regs) + 2) * 4
-                             + stack_addend);
-    } else {
-        tcg_out_mov(s, TCG_TYPE_PTR, TCG_AREG0, tcg_target_call_iarg_regs[0]);
-        tcg_out_addi(s, TCG_REG_ESP, -stack_addend);
-        /* jmp *tb.  */
-        tcg_out_modrm(s, OPC_GRP5, EXT5_JMPN_Ev, tcg_target_call_iarg_regs[1]);
-    }
+    tcg_out_mov(s, TCG_TYPE_PTR, TCG_AREG0, tcg_target_call_iarg_regs[0]);
+    tcg_out_addi(s, TCG_REG_ESP, -stack_addend);
+    /* jmp *tb.  */
+    tcg_out_modrm(s, OPC_GRP5, EXT5_JMPN_Ev, tcg_target_call_iarg_regs[1]);
 
     /*
      * Return path for goto_ptr. Set return value to 0, a-la exit_tb,
@@ -4846,9 +4512,7 @@ static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
 static void tcg_target_init(TCGContext *s)
 {
     tcg_target_available_regs[TCG_TYPE_I32] = ALL_GENERAL_REGS;
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_target_available_regs[TCG_TYPE_I64] = ALL_GENERAL_REGS;
-    }
+    tcg_target_available_regs[TCG_TYPE_I64] = ALL_GENERAL_REGS;
     if (have_avx1) {
         tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
         tcg_target_available_regs[TCG_TYPE_V128] = ALL_VECTOR_REGS;
@@ -4861,16 +4525,14 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_EAX);
     tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_EDX);
     tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_ECX);
-    if (TCG_TARGET_REG_BITS == 64) {
 #if !defined(_WIN64)
-        tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_RDI);
-        tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_RSI);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_RDI);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_RSI);
 #endif
-        tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R8);
-        tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R9);
-        tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R10);
-        tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R11);
-    }
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R8);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R9);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R10);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R11);
 
     s->reserved_regs = 0;
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_CALL_STACK);
@@ -4899,10 +4561,9 @@ typedef struct {
 /* We're expecting a 2 byte uleb128 encoded value.  */
 QEMU_BUILD_BUG_ON(FRAME_SIZE >= (1 << 14));
 
-#if !defined(__ELF__)
-    /* Host machine without ELF. */
-#elif TCG_TARGET_REG_BITS == 64
+#ifdef __ELF__
 #define ELF_HOST_MACHINE EM_X86_64
+
 static const DebugFrame debug_frame = {
     .h.cie.len = sizeof(DebugFrameCIE)-4, /* length after .len member */
     .h.cie.id = -1,
@@ -4930,36 +4591,7 @@ static const DebugFrame debug_frame = {
         0x8f, 7,                        /* DW_CFA_offset, %r15, -56 */
     }
 };
-#else
-#define ELF_HOST_MACHINE EM_386
-static const DebugFrame debug_frame = {
-    .h.cie.len = sizeof(DebugFrameCIE)-4, /* length after .len member */
-    .h.cie.id = -1,
-    .h.cie.version = 1,
-    .h.cie.code_align = 1,
-    .h.cie.data_align = 0x7c,             /* sleb128 -4 */
-    .h.cie.return_column = 8,
 
-    /* Total FDE size does not include the "len" member.  */
-    .h.fde.len = sizeof(DebugFrame) - offsetof(DebugFrame, h.fde.cie_offset),
-
-    .fde_def_cfa = {
-        12, 4,                          /* DW_CFA_def_cfa %esp, ... */
-        (FRAME_SIZE & 0x7f) | 0x80,     /* ... uleb128 FRAME_SIZE */
-        (FRAME_SIZE >> 7)
-    },
-    .fde_reg_ofs = {
-        0x88, 1,                        /* DW_CFA_offset, %eip, -4 */
-        /* The following ordering must match tcg_target_callee_save_regs.  */
-        0x85, 2,                        /* DW_CFA_offset, %ebp, -8 */
-        0x83, 3,                        /* DW_CFA_offset, %ebx, -12 */
-        0x86, 4,                        /* DW_CFA_offset, %esi, -16 */
-        0x87, 5,                        /* DW_CFA_offset, %edi, -20 */
-    }
-};
-#endif
-
-#if defined(ELF_HOST_MACHINE)
 void tcg_register_jit(const void *buf, size_t buf_size)
 {
     tcg_register_jit_int(buf, buf_size, &debug_frame, sizeof(debug_frame));
-- 
2.43.0


