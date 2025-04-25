Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D78C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8REB-0002Qu-6h; Fri, 25 Apr 2025 18:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RB7-0004A0-Kv
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:50 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RB3-0001u6-97
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:49 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so3020728b3a.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618743; x=1746223543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qLZhLiDuHf43sgIxDrreufVhjTxRCGaOFpCs/PZsxGk=;
 b=C5idK2Xa93FSH/S88u88TTE4rN8zcNz9kEeOr3IEwwBI8bdI6a40vEnn4ZnplcETad
 6wZ2w/6Ij8CUTKF7aeVsAgbQW90jaB+VnN5/q9vxWSv31jtzHsejuLUxx+5fKdtEM+ZF
 p6USkWNlJwJeX7uOb4o9uPFjsE4eOCtTA5hDzPNi/TuY7id1utiX2iNXaIQuiodPEqx4
 X2S4nfH1VcR1buEH7h9K8+7QZ5V0hpIogmvB9gkD1vuU0xHqSOY0/GUfCYDZv+1Kfhr8
 WRtplkOCHozPUm4MP0WJiXa0r3lCwbclnNDJwcNRhwtd8PfPVbPVp57abtupWkDAbLkW
 z5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618743; x=1746223543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qLZhLiDuHf43sgIxDrreufVhjTxRCGaOFpCs/PZsxGk=;
 b=Fk94vE8FP2VeWxIMKFzt41IxXIwzvRtuNJ5xYk5nBNr7qOskTt9VryOCrhcrFpEUPd
 nJaQrOq+++BRY2leDwnx1PK5lXCuTJE8Is9FJ4AEJglZOtrSUELSf5w7ALeAmAddEDXX
 wTwu8qc1oAAfw0ZSXoA/IKpz7eOBmUb9uks3+qh7Y9pCLM4NHh7S2hqsMRkafhbZgBR7
 Yn4cwL4obXRIpfZP8EEIytjDw+5Y2NpzfGC+ZYg+TqulDyPtont6A9rBFbW7DWphWme/
 eUqTN5rckNkZXMgZOR+LOESlHvwkSujXX3a1bGKBuJF+GPp+DWdmNNB9nk73pGgDAv5X
 8Gig==
X-Gm-Message-State: AOJu0YyQBvd+0i+YiXQtBWTJU7H+qW45+igihKggS+D5sTsgMLI56yBI
 eIUy3ypKxXfaUjhkRN9IEuJJ+Q7OkpWvE1sKkfnR8h/appS68djzboLeFHnNyv9p91zxEgbca1u
 n
X-Gm-Gg: ASbGncuqJw2krkjnxYt24Q0WtW/DIGuyZ6Fgl7fCNRv2FoECEutn2fuTUrQebP+G7Ix
 yHVmDdbqX2ORZPhdop6vVvP/w5KoEJL36ZQnnCuVuXvUe+nCdprFS6wOaA1ntyISyXaGnpWP3Fu
 FryFrtsfp+qZ1PRrczMYujL1AzR1dIwTH7PBuvjzZYl3+jnzjEmJSUUPAAFrenZ9KySvLvfQ70Q
 yykFKiiwVvqFlkFKxy/b6brf0HPJUaT0kQ/5OJdq3h5gX0HtSGXftAmE9nxtaf4gOQjzhr49Wka
 tOZzWTybJAKYJPwa9Zcsni9ggeKlYa2lqvQOJ5h1I2rThEO5dWEsCjoaIDxVhBFPTFGu/+WsMlo
 =
X-Google-Smtp-Source: AGHT+IFoCKTnhO+oVx2CA5wguz4grSsqNu4/yvP1m8nJkr91OTIpu3bR0wTMVe5hAqQvOpFOLGyI/A==
X-Received: by 2002:a05:6a00:a17:b0:73e:23be:11fc with SMTP id
 d2e1a72fcca58-73fd8f4d3efmr5137557b3a.22.1745618743393; 
 Fri, 25 Apr 2025 15:05:43 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 147/159] tcg: Formalize tcg_out_mb
Date: Fri, 25 Apr 2025 14:54:41 -0700
Message-ID: <20250425215454.886111-148-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
index 5a498b48b6..e7478bef77 100644
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
@@ -6899,6 +6900,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
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
index 4f640764ef..1ad577ad8d 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -301,7 +301,7 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
  * TCG intrinsics
  */
 
-static void tcg_out_mb(TCGContext *s, TCGArg a0)
+static void tcg_out_mb(TCGContext *s, unsigned a0)
 {
     /* Baseline LoongArch only has the full barrier, unfortunately.  */
     tcg_out_opc_dbar(s, 0);
@@ -1917,10 +1917,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
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
index c2251a6927..7754627a5d 100644
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
@@ -2025,10 +2025,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
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


