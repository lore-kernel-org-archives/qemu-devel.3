Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F2DC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mBl-0001Nh-F8; Tue, 15 Apr 2025 15:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m6s-0001J5-BB
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:38:36 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m5e-0004c7-Mx
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:37:54 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-224100e9a5cso68558715ad.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745781; x=1745350581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8D8dBP8MFbdVhbozG9Dd6wL4Ft2G4Mo7++JENf5oj+g=;
 b=X4D81aKugxc+2SKGw9uVy73Zi5lLLR3ZrCBJCNodFgoLPjy1HsbKduqCw6nhM29ASU
 a89q4jkroh3AfZezjgQxTR7HhOMzmciXE86AKzEXhK4iDWdF1XAuzisRCdqz6/rWDNJ3
 byGj/Rl507hGyn+uwbN+tU0D7EHiE3of7QbpwAWlsZWXr/i1RijEjinEKGwwpy3x34q0
 bE+9L6rqQd4PocuYEn6EjJBqs8jLxsqpozQIjPM1kdzuCnXLLaaIBIw33YNmLBesTxu6
 dvENE4MJREUWkn7V9OTV+w2an94P6J/ZAbYSGrzpMjjeeaCSyeRp6t+1oTlKuSWbmf+3
 lC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745781; x=1745350581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8D8dBP8MFbdVhbozG9Dd6wL4Ft2G4Mo7++JENf5oj+g=;
 b=rhmv1SgLDj/kMcl5AsiGZAz3tBje1VQl0t058Ivasl5BzCAbRgzXRSiRN0B/PtSByZ
 5gWOOi7Up8AlVZqZfJ6oPXsuFtAhe5XiMjag1zO5gaz88T0dy3FoQF4C1GmZI2zziGUk
 wKHhQq9ToXjkHQXneQZUVyc4trFEPzE524YhWmRC5I7+JC1BwwTcwsycLRM91AN3T2Ji
 PDQvwptt4uIf1OECWW+4vJs4evbk352mgbqidVXHqexPykCWn2O2nk+0hOVNgGXgbpT0
 9Sq2PfovwaqampmZqAKFC7dMR7SOBB6JS3m8Ip07jMdmzWJVKBaYnirSsOeMeDK80GBv
 G77w==
X-Gm-Message-State: AOJu0YzV5f73IZ8hzg9nM3CEs3/rWV1y+1hIby1aDd7Z59zl5qFPFfXC
 RKsx1KXDSfIbkS+d3J54wEnxiH5CBSpw1eNM4TZGtfDtNLuloKcTiOPBreQCsjFaAisCN1KTs+b
 3
X-Gm-Gg: ASbGncs3PuLM7o5/9l17zn9OwGNWYVFMaRDqNir7rPrVzWP0vPy8Cm8TEmGRRD3Pvsa
 FfpEi3M2Wn1QM1cg0vx6cXRGfotaFMJ1caq+QxZh+6FKkeUdmaOeLq741mX3Fw6xjC4aJt0SwqK
 EW7mJZln0HN3zO1qhH/gAsE7ICUs2XG3WJy8sH1tDUrpLsJpxl6EAq1rMapyrZtoy3irQITWPXz
 jB8e1FuiGopQMnBRV0hX+6TSoxv3Er1FmtJpJ6jsfhaEkRafDDRQV4YU/T0BU1p9VKr/cwINPmS
 zWv/Jh6tQhKB48f8ThCRAi3mt8KWqh4ESbse6jgj57UWlu4Zz9T1rC4qtoz0o4t7ubJ4Otn4FOo
 =
X-Google-Smtp-Source: AGHT+IFsRN2sxdHpbr/RUyLyYxVOmhIlWq9duAqJk4t4W5pCoNkRgpdxlv1HTphdzOd0NiiKAn3iaQ==
X-Received: by 2002:a17:903:1448:b0:220:da88:2009 with SMTP id
 d9443c01a7336-22c31ae9c4bmr5574205ad.45.1744745780556; 
 Tue, 15 Apr 2025 12:36:20 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.36.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:36:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 150/163] tcg: Formalize tcg_out_mb
Date: Tue, 15 Apr 2025 12:25:01 -0700
Message-ID: <20250415192515.232910-151-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Most tcg backends already have a function for this;
the rest can split one out from tcg_out_op.
Call it directly from tcg_gen_code.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        |  4 ++++
 tcg/aarch64/tcg-target.c.inc     |  6 +-----
 tcg/arm/tcg-target.c.inc         |  6 +-----
 tcg/i386/tcg-target.c.inc        |  5 +----
 tcg/loongarch64/tcg-target.c.inc |  6 +-----
 tcg/mips/tcg-target.c.inc        |  5 +----
 tcg/ppc/tcg-target.c.inc         |  6 +-----
 tcg/riscv/tcg-target.c.inc       |  6 +-----
 tcg/s390x/tcg-target.c.inc       | 20 +++++++++++---------
 tcg/sparc64/tcg-target.c.inc     |  6 +-----
 tcg/tci/tcg-target.c.inc         |  9 +++++----
 11 files changed, 28 insertions(+), 51 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index ffabe43c91..4ffd4d203b 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -133,6 +133,7 @@ static void tcg_out_addi_ptr(TCGContext *s, TCGReg, TCGReg, tcg_target_long);
 static bool tcg_out_xchg(TCGContext *s, TCGType type, TCGReg r1, TCGReg r2);
 static void tcg_out_exit_tb(TCGContext *s, uintptr_t arg);
 static void tcg_out_goto_tb(TCGContext *s, int which);
+static void tcg_out_mb(TCGContext *s, unsigned bar);
 static void tcg_out_set_carry(TCGContext *s);
 static void tcg_out_set_borrow(TCGContext *s);
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
@@ -6894,6 +6895,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
         case INDEX_op_goto_tb:
             tcg_out_goto_tb(s, op->args[0]);
             break;
+        case INDEX_op_mb:
+            tcg_out_mb(s, op->args[0]);
+            break;
         case INDEX_op_dup2_vec:
             if (tcg_reg_alloc_dup2(s, op)) {
                 break;
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 75cf490fd2..d2babd9bab 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1575,7 +1575,7 @@ static void tcg_out_extrl_i64_i32(TCGContext *s, TCGReg rd, TCGReg rn)
     tcg_out_mov(s, TCG_TYPE_I32, rd, rn);
 }
 
-static inline void tcg_out_mb(TCGContext *s, TCGArg a0)
+static void tcg_out_mb(TCGContext *s, unsigned a0)
 {
     static const uint32_t sync[] = {
         [0 ... TCG_MO_ALL]            = DMB_ISH | DMB_LD | DMB_ST,
@@ -2845,10 +2845,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_qemu_ldst_i128(s, a0, a1, a2, args[3], false);
         break;
 
-    case INDEX_op_mb:
-        tcg_out_mb(s, a0);
-        break;
-
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 3c9042ebfa..131901dabc 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1203,7 +1203,7 @@ static void tcg_out_goto_label(TCGContext *s, ARMCond cond, TCGLabel *l)
     }
 }
 
-static void tcg_out_mb(TCGContext *s, TCGArg a0)
+static void tcg_out_mb(TCGContext *s, unsigned a0)
 {
     if (use_armv7_instructions) {
         tcg_out32(s, INSN_DMB_ISH);
@@ -2565,10 +2565,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_st(s, args[0], args[1], args[2], args[3], TCG_TYPE_I64);
         break;
 
-    case INDEX_op_mb:
-        tcg_out_mb(s, args[0]);
-        break;
-
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index da05f13b21..bf84f9f455 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1168,7 +1168,7 @@ static inline void tcg_out_pushi(TCGContext *s, tcg_target_long val)
     }
 }
 
-static inline void tcg_out_mb(TCGContext *s, TCGArg a0)
+static void tcg_out_mb(TCGContext *s, unsigned a0)
 {
     /* Given the strength of x86 memory ordering, we only need care for
        store-load ordering.  Experimentally, "lock orl $0,0(%esp)" is
@@ -3536,9 +3536,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
 #endif
 
-    case INDEX_op_mb:
-        tcg_out_mb(s, a0);
-        break;
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 937f19fe6b..b9b05b8c25 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -289,7 +289,7 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
  * TCG intrinsics
  */
 
-static void tcg_out_mb(TCGContext *s, TCGArg a0)
+static void tcg_out_mb(TCGContext *s, unsigned a0)
 {
     /* Baseline LoongArch only has the full barrier, unfortunately.  */
     tcg_out_opc_dbar(s, 0);
@@ -1905,10 +1905,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     TCGArg a3 = args[3];
 
     switch (opc) {
-    case INDEX_op_mb:
-        tcg_out_mb(s, a0);
-        break;
-
     case INDEX_op_goto_ptr:
         tcg_out_opc_jirl(s, TCG_REG_ZERO, a0, 0);
         break;
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 0c268cef42..b0da661561 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1491,7 +1491,7 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg datalo, TCGReg datahi,
     }
 }
 
-static void tcg_out_mb(TCGContext *s, TCGArg a0)
+static void tcg_out_mb(TCGContext *s, unsigned a0)
 {
     static const MIPSInsn sync[] = {
         /* Note that SYNC_MB is a slightly weaker than SYNC 0,
@@ -2352,9 +2352,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_mb:
-        tcg_out_mb(s, a0);
-        break;
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 91df9610ec..ae18c84ae6 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2208,7 +2208,7 @@ static const TCGOutOpBrcond2 outop_brcond2 = {
     .out = tgen_brcond2,
 };
 
-static void tcg_out_mb(TCGContext *s, TCGArg a0)
+static void tcg_out_mb(TCGContext *s, unsigned a0)
 {
     uint32_t insn;
 
@@ -3758,10 +3758,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], false);
         break;
 
-    case INDEX_op_mb:
-        tcg_out_mb(s, args[0]);
-        break;
-
     case INDEX_op_call:      /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:   /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:   /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 707ebb8f6d..df271752b7 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1582,7 +1582,7 @@ static void tcg_out_call(TCGContext *s, const tcg_insn_unit *arg,
     tcg_out_call_int(s, arg, false);
 }
 
-static void tcg_out_mb(TCGContext *s, TCGArg a0)
+static void tcg_out_mb(TCGContext *s, unsigned a0)
 {
     tcg_insn_unit insn = OPC_FENCE;
 
@@ -2594,10 +2594,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_st(s, a0, a1, a2, TCG_TYPE_I64);
         break;
 
-    case INDEX_op_mb:
-        tcg_out_mb(s, a0);
-        break;
-
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 09c7ca5b44..020d8ba73f 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -3008,6 +3008,17 @@ static const TCGOutOpUnary outop_not = {
     .out_rr = tgen_not,
 };
 
+static void tcg_out_mb(TCGContext *s, unsigned a0)
+{
+    /*
+     * The host memory model is quite strong, we simply need to
+     * serialize the instruction stream.
+     */
+    if (a0 & TCG_MO_ST_LD) {
+        /* fast-bcr-serialization facility (45) is present */
+        tcg_out_insn(s, RR, BCR, 14, 0);
+    }
+}
 
 # define OP_32_64(x) \
         case glue(glue(INDEX_op_,x),_i32): \
@@ -3107,15 +3118,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I64, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_mb:
-        /* The host memory model is quite strong, we simply need to
-           serialize the instruction stream.  */
-        if (args[0] & TCG_MO_ST_LD) {
-            /* fast-bcr-serialization facility (45) is present */
-            tcg_out_insn(s, RR, BCR, 14, 0);
-        }
-        break;
-
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 842ef68c54..56b68fe841 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -949,7 +949,7 @@ static void tcg_out_call(TCGContext *s, const tcg_insn_unit *dest,
     tcg_out_nop(s);
 }
 
-static void tcg_out_mb(TCGContext *s, TCGArg a0)
+static void tcg_out_mb(TCGContext *s, unsigned a0)
 {
     /* Note that the TCG memory order constants mirror the Sparc MEMBAR.  */
     tcg_out32(s, MEMBAR | (a0 & TCG_MO_ALL));
@@ -2020,10 +2020,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, a0, a1, a2, STX);
         break;
 
-    case INDEX_op_mb:
-        tcg_out_mb(s, a0);
-        break;
-
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 35c0c91f3e..64d4ac07cd 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -1131,6 +1131,11 @@ static const TCGOutOpSetcond2 outop_setcond2 = {
     .out = tgen_setcond2,
 };
 
+static void tcg_out_mb(TCGContext *s, unsigned a0)
+{
+    tcg_out_op_v(s, INDEX_op_mb);
+}
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -1178,10 +1183,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_mb:
-        tcg_out_op_v(s, opc);
-        break;
-
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-- 
2.43.0


