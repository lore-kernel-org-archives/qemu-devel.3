Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2225E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPev-0008I0-Ji; Thu, 02 Jan 2025 13:11:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPee-0007OS-MH
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:47 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeb-0006FF-96
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:44 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21675fd60feso209356755ad.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841440; x=1736446240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UKtXdEN7bVZW13Z6irZq+DnAH3k2U5HQNIeF7BG/7wY=;
 b=u97dvtQDgoYhAbARQoSB0Y3z11VC/humHzoYgJfRu89YebHjAbe34AOo5dS0jo/yWD
 PMqjiuFK67bwWrmMGQWp703SeJcaewHL3XifQlTi7GO/FWNnvUMeeVFLO8d62rJopfD9
 sDaVBrlP/IwPJVjww6kMyfNNT1HLUj/BpLZ3IMCBSClQgOeT7A3RDRaVwTeWouuiAjYv
 9/t6yQtIXzAG8vaCryIAHH7m1C7Y1k3hdlk99KcfLmjUrsy5CmYd1p3vNbnBItZOb9M8
 E5TfSFPCCk89tbayHsvh0t0i0OvNHl5lD6enFaVs/AxTylcn3EnnukVPzlVRhRQ7cojF
 Uepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841440; x=1736446240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UKtXdEN7bVZW13Z6irZq+DnAH3k2U5HQNIeF7BG/7wY=;
 b=GuNPdPVTvyVGp1UhBWU2zzbOhjuP8spht8dTT17Q2UL5cZdzOvBknfqoDX4n06iXPg
 Rr2NUX12VwJu+Z58KB0nxUTYA1l6oeKh1j7w9aZXRk+sxWzVgokDIAWSQWdY50ZeAriu
 74V2jIB8FUY06zgXvJ6B2xoQ7J374NeF8FmtJktz7GzmHGMHJkovie6qTY0e3V/5NtI/
 Vv8JZN0PmZai9qL+61NQ2EvxwZ1U9oc0bu7CeTZ6ZykhRSbK35Kx6KtAUns27cZjMWNs
 8W3+anT8LCBUuz7O7PBr9+7+wZ0eBkAcX2VgXR+taHuUBycl3/3N8mNIPXhJ/3ANNPYb
 BjAw==
X-Gm-Message-State: AOJu0YwDV5kKtIvBti4/4C8DhFKU+nKR8b+naV4qMFCzxVqrV1znezAp
 sKenoU6KiPrgJ6J6HPQ/qsfK39YOJaojNyr3xPDxagW+tPcA0bx2lolmiyK6dCvuPb1I1CRtgin
 T
X-Gm-Gg: ASbGncvnqqXTKopGOF2YmxPmS05UhOQI6uXhV8xqVl0+fOEktL2w4iNpM4D68soIO55
 MSHD9+MPPT81ahZDdEvSL0Egba+yyeeG/gaFW47vYHoYaCJueRDqoF5iER/V1kCQkm4j5IFm0mD
 rEmVMWGq0SvBnb0nDTrC8VRUHQLBaaUgSeFF7x4VScux+YCi3LasK8hHBXMy2MJQKOK6i00UhD2
 IO8NHMBcF51P8LG6Vf6WxQwKgg2YbU/D0iBaLz9hErqpsHf0TjsK/iwfh4eKw==
X-Google-Smtp-Source: AGHT+IG67Gn9tpC0fL9kqVRAHnKycdGvLRjeNZKfNwLdisEuYKWpYzykLYxVmbphL8sFe55nAz4EEA==
X-Received: by 2002:a05:6a21:6d98:b0:1e1:a647:8a3f with SMTP id
 adf61e73a8af0-1e5e049f932mr90695420637.22.1735841439858; 
 Thu, 02 Jan 2025 10:10:39 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 57/73] tcg: Add TCGType argument to tcg_out_op
Date: Thu,  2 Jan 2025 10:06:37 -0800
Message-ID: <20250102180654.1420056-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
 tcg/tci/tcg-target.c.inc         | 2 +-
 11 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index e7bb7a4d69..c604785d39 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -143,7 +143,7 @@ static void tcg_out_addi_ptr(TCGContext *s, TCGReg, TCGReg, tcg_target_long);
 static bool tcg_out_xchg(TCGContext *s, TCGType type, TCGReg r1, TCGReg r2);
 static void tcg_out_exit_tb(TCGContext *s, uintptr_t arg);
 static void tcg_out_goto_tb(TCGContext *s, int which);
-static void tcg_out_op(TCGContext *s, TCGOpcode opc,
+static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS]);
 #if TCG_TARGET_MAYBE_vec
@@ -5367,7 +5367,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
             tcg_out_vec_op(s, op->opc, op->type - TCG_TYPE_V64,
                            TCGOP_VECE(op), new_args, const_args);
         } else {
-            tcg_out_op(s, op->opc, new_args, const_args);
+            tcg_out_op(s, op->opc, op->type, new_args, const_args);
         }
         break;
     }
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 6b6603a512..4fd42fc00e 100644
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
index 2b93054146..3098491f75 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1847,7 +1847,7 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     flush_idcache_range(jmp_rx, jmp_rw, 4);
 }
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc,
+static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index bee3e6b8c2..3ca6bfda73 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2627,12 +2627,12 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
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
@@ -2649,6 +2649,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
     a1 = args[1];
     a2 = args[2];
     const_a2 = const_args[2];
+    rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
 
     switch (opc) {
     case INDEX_op_goto_ptr:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index eff98fb02c..a8ffc479de 100644
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
index df016ae65a..52c71b0506 100644
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
index 07619b697e..e1e78b9c60 100644
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
index 707c0e4984..067b4c1108 100644
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
index 89993fb3ac..8465111a20 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2149,9 +2149,9 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
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
@@ -2745,7 +2745,6 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
             /* Since we can't support "0Z" as a constraint, we allow a1 in
                any register.  Fix things up as if a matching constraint.  */
             if (a0 != a1) {
-                TCGType type = (opc == INDEX_op_deposit_i64);
                 if (a0 == a2) {
                     tcg_out_mov(s, type, TCG_TMP0, a2);
                     a2 = TCG_TMP0;
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 3368ccb9fd..430e07511c 100644
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
index f4cabe5d3d..c541ee7dff 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -662,7 +662,7 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     /* Always indirect, nothing to do */
 }
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc,
+static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
-- 
2.43.0


