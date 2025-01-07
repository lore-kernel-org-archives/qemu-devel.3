Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5886EE77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4YI-0003Eo-El; Tue, 07 Jan 2025 03:03:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4X7-0000Kj-Sa
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:51 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4X2-0002yT-RD
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:46 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2163dc5155fso218366925ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236903; x=1736841703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZDbY+3cgtXJJeopTJx6oLM3QXIeu+eUy2JM78lliXlA=;
 b=FguOwJAal4Cq36ETXiQoGitAXg21XMo1MT16JuuFmDZtZZkZE13IOsTn1VFe54XULA
 c/iEWoUYkS33vRY9LTqaFHZsPqd4w9I8s11+/Zxezj2TBYKnr+3NhQNoSaAyIQhWQuwp
 ivH8oU4FpS/BF8oJsPFE4deF/hWG4+RsbWViRIUGNS+ov2+fZ+8BFoQIZWjBSHku6B9t
 YplhAGPt7uOIBq3n3SfRQx/XJxqMNaP/LFJ9/iJyXq0m6jPe/57jq77E9gjpITfmPMMh
 D7oFwrzcNkYNmIcwx1OWWo4rBMNDQgLIlmbuTear62sRMMWN2ppKMOc8CulKTbfDRfE2
 G4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236903; x=1736841703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZDbY+3cgtXJJeopTJx6oLM3QXIeu+eUy2JM78lliXlA=;
 b=Z5bWy9PSVQ4sk1ezJj3MEMPrcABu+NPxUS+IIiOApSImrg/aRhC+oEeY28OBGqOBgW
 nIFaEM96XoULv5awyDmvBRu5U6z0hE6V0hC/oZRxctKCeUXp9JdcHBSeaw0A+iqUD9yM
 kLj4iLix+kYHtyCd3yzKpFF7gpl/VMXX7vaSYGYfxJIp+hScYk7dV426ajedbP7oV0WZ
 52TZtZgR77uHAl4SCb5QFTBApwZowDuotF5GbAspmlbyarCJbnrNDVUy+kfSSUqSyspR
 Nh968aGlbYD4l94j71qG1N1bKDzteSCPc2RXzxXjvuW0i6vTtsN/MOsSoP7L8fy0Fd22
 /pag==
X-Gm-Message-State: AOJu0YxVJ4rzbmiJWjH7Vc5yUAP1IOygv/rvLb+vbAz/lPGLKFEkHXEv
 S1HxzV6kc10eTCw0Bv4tiF9qYeFMNoiRmVKnIIrXdzn0svuz9yqrL3X4GDQ4JryjHD3ULW78tXb
 n
X-Gm-Gg: ASbGncuXJWE0JZdwHsJdgBrXlC75GaQm1f6XrX4KWFc4oPgnO8Ez0MaP0K8jT05/klN
 fxA1iphnGvIXa4tOYRQkMhrM4qpGw3fpWyxRh+IXMlU9BGl+cBQ8qdrQjujrn9eh5WhNfYlj6ut
 /0Ilq9Dx18yG9kkP0cw+8igGp7WlsAgPIjy7TKrm8dDu7W/eRJZsMqwBh8t3scm050BUd/2S09b
 8mCS7a3M0UP/8BPubsGX2+1Ds7+dMuS8egoBFqU6aNDS2MrKCnH/yEEPA+/AkBF0VxpbbDxKRli
 0WM0hXr3SHlQyXyAzA==
X-Google-Smtp-Source: AGHT+IEagIgLSLgWwVr3kwuWzsioKQg+bxoZqmdQ5yQey1laGaohhtCFsKXBANQXTE4mDOa3nU1+Sg==
X-Received: by 2002:a17:902:dad1:b0:216:725c:a137 with SMTP id
 d9443c01a7336-219e6ebc7dfmr737707505ad.28.1736236903350; 
 Tue, 07 Jan 2025 00:01:43 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 28/81] tcg: Add TCGType argument to tcg_out_op
Date: Tue,  7 Jan 2025 00:00:19 -0800
Message-ID: <20250107080112.1175095-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Pass TCGOp.type to the output function.
For aarch64 and tci, use this instead of testing TCG_OPF_64BIT.
For s390x, use this instead of testing INDEX_op_deposit_i64.
For i386, use this to initialize rexw.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        | 4 ++--
 tcg/aarch64/tcg-target.c.inc     | 6 +-----
 tcg/arm/tcg-target.c.inc         | 2 +-
 tcg/i386/tcg-target.c.inc        | 9 +++++----
 tcg/loongarch64/tcg-target.c.inc | 2 +-
 tcg/mips/tcg-target.c.inc        | 2 +-
 tcg/ppc/tcg-target.c.inc         | 2 +-
 tcg/riscv/tcg-target.c.inc       | 2 +-
 tcg/s390x/tcg-target.c.inc       | 7 +++----
 tcg/sparc64/tcg-target.c.inc     | 2 +-
 tcg/tci/tcg-target.c.inc         | 4 ++--
 11 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index b971909c3f..350ab5948e 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -134,7 +134,7 @@ static void tcg_out_addi_ptr(TCGContext *s, TCGReg, TCGReg, tcg_target_long);
 static bool tcg_out_xchg(TCGContext *s, TCGType type, TCGReg r1, TCGReg r2);
 static void tcg_out_exit_tb(TCGContext *s, uintptr_t arg);
 static void tcg_out_goto_tb(TCGContext *s, int which);
-static void tcg_out_op(TCGContext *s, TCGOpcode opc,
+static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS]);
 #if TCG_TARGET_MAYBE_vec
@@ -5423,7 +5423,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
             tcg_out_vec_op(s, op->opc, TCGOP_TYPE(op) - TCG_TYPE_V64,
                            TCGOP_VECE(op), new_args, const_args);
         } else {
-            tcg_out_op(s, op->opc, new_args, const_args);
+            tcg_out_op(s, op->opc, TCGOP_TYPE(op), new_args, const_args);
         }
         break;
     }
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 9116f85667..ede6f47235 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2115,14 +2115,10 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     flush_idcache_range(jmp_rx, jmp_rw, 4);
 }
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc,
+static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
-    /* 99% of the time, we can signal the use of extension registers
-       by looking to see if the opcode handles 64-bit data.  */
-    TCGType ext = (tcg_op_defs[opc].flags & TCG_OPF_64BIT) != 0;
-
     /* Hoist the loads of the most common arguments.  */
     TCGArg a0 = args[0];
     TCGArg a1 = args[1];
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 182cac1a8a..9cfb733a14 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1805,7 +1805,7 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     flush_idcache_range(jmp_rx, jmp_rw, 4);
 }
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc,
+static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 64826c7419..e51269f81d 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2612,12 +2612,12 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     /* no need to flush icache explicitly */
 }
 
-static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
-                              const TCGArg args[TCG_MAX_OP_ARGS],
-                              const int const_args[TCG_MAX_OP_ARGS])
+static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
+                       const TCGArg args[TCG_MAX_OP_ARGS],
+                       const int const_args[TCG_MAX_OP_ARGS])
 {
     TCGArg a0, a1, a2;
-    int c, const_a2, vexop, rexw = 0;
+    int c, const_a2, vexop, rexw;
 
 #if TCG_TARGET_REG_BITS == 64
 # define OP_32_64(x) \
@@ -2634,6 +2634,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
     a1 = args[1];
     a2 = args[2];
     const_a2 = const_args[2];
+    rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
 
     switch (opc) {
     case INDEX_op_goto_ptr:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 2f0d4d01ff..3dff29facb 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1278,7 +1278,7 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     flush_idcache_range(jmp_rx, jmp_rw, 4);
 }
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc,
+static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index b89b279a0e..b31b8f0007 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1678,7 +1678,7 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     /* Always indirect, nothing to do */
 }
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc,
+static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 1e7b8a204c..9205ac99e9 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2940,7 +2940,7 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     flush_idcache_range(jmp_rx, jmp_rw, 4);
 }
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc,
+static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 432a2fe26f..e381ba4e77 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1960,7 +1960,7 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     flush_idcache_range(jmp_rx, jmp_rw, 4);
 }
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc,
+static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index e09a726ecf..fc7d986e68 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2117,9 +2117,9 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
         case glue(glue(INDEX_op_,x),_i32): \
         case glue(glue(INDEX_op_,x),_i64)
 
-static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
-                              const TCGArg args[TCG_MAX_OP_ARGS],
-                              const int const_args[TCG_MAX_OP_ARGS])
+static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
+                       const TCGArg args[TCG_MAX_OP_ARGS],
+                       const int const_args[TCG_MAX_OP_ARGS])
 {
     S390Opcode op, op2;
     TCGArg a0, a1, a2;
@@ -2713,7 +2713,6 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
             /* Since we can't support "0Z" as a constraint, we allow a1 in
                any register.  Fix things up as if a matching constraint.  */
             if (a0 != a1) {
-                TCGType type = (opc == INDEX_op_deposit_i64);
                 if (a0 == a2) {
                     tcg_out_mov(s, type, TCG_TMP0, a2);
                     a2 = TCG_TMP0;
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 48de490120..afc778fae7 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1288,7 +1288,7 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
 {
 }
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc,
+static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 662acbdcb6..88cecbd62f 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -708,7 +708,7 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     /* Always indirect, nothing to do */
 }
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc,
+static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
@@ -790,7 +790,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     CASE_32_64(sextract) /* Optional (TCG_TARGET_HAS_sextract_*). */
         {
             TCGArg pos = args[2], len = args[3];
-            TCGArg max = tcg_op_defs[opc].flags & TCG_OPF_64BIT ? 64 : 32;
+            TCGArg max = type == TCG_TYPE_I32 ? 32 : 64;
 
             tcg_debug_assert(pos < max);
             tcg_debug_assert(pos + len <= max);
-- 
2.43.0


