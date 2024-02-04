Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14F1C48286
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkF5-00028E-2k; Sun, 04 Feb 2024 16:41:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkF3-00027s-Fv
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:33 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkF1-0003XR-JP
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:33 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5d8df2edd29so3004780a12.2
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082890; x=1707687690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jqq6u+q1v4CNoIoGh6nUoMc6HIISs+w/ePs4mgq4UxI=;
 b=iSU68U3rj/B/WsrFGoSAqK7u83X4qBuHZPeDkh4dDRAhPZDL81RMGdEZA/bslepWGp
 GAVNk7YxPDqpcycYOLkijnZVudFFO5FvAVb5+SPIw8aCi/hl9R198ETgkLv8105iaUrk
 9zGDn9Akp/5uLGhOiHO21/ZB45ardX3JG6fHn4lrF1DlCJbghrekTLktLxAHcknKCBsL
 n30znDj0yk1ZPHMG232bi4QgN6o6Y/tV8QruwQXdtLB3GYxcKxcDm223/H6+KGuTht7f
 07eGj50LpLI4Z3TEFuRHLMvfiKunY/mbHUlWpYL5Bpq4SmwafqS4a5VIPW5+3JRRFZp5
 5HgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082890; x=1707687690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jqq6u+q1v4CNoIoGh6nUoMc6HIISs+w/ePs4mgq4UxI=;
 b=bIRxZa3HYGM5bgFhqdHlCKk+rkYsnQd6stmV4NbqE2qpY/1Hy7E6ypIVI3f/iOQTB/
 tkpncBfaiP40zwWLTh5YqUPqL63Ab0SgvHzI3+quGU2FBtlXpdLSFQAbFIIjrqt97uzi
 cigH6GDIXLP/7y5CryXXbqVFJ64DqcQcOlnij0M7Kj9eMYMtDOQQClJTHePwABzYLAEv
 RlSSwZwKaxEc1MJPH7x3mQvnVcYu7qaQHW25jXnVyh2GBWnzVbjXkPd1gsRHIFScTWkP
 N24jy++wyKWaAObqzzNYyHoajzvOglgkYj5KuZvGAFjn2+7I+NldNqDegRxnP0WAGxim
 npIg==
X-Gm-Message-State: AOJu0YxXedejdMpNTjbOHzKoYS6dTNJbUPRhxGWMJNpzHTX9L/qamT5G
 MaPnvkHwJTo9eSedhp3Dsuihoc7hxpBX7LO+bI+JpUWqnSb2uU+JiFGIWZ+6TMmMYyZK7MNnlLj
 Z+Q0=
X-Google-Smtp-Source: AGHT+IEva4jshI+tuPABiXxOWU4Ht0NG2QngHuNVFLgnAiLDRX+MNTqTeOejEfb3GP9IRLNeBZCY6w==
X-Received: by 2002:a05:6a20:bd1e:b0:19c:a202:3f96 with SMTP id
 fy30-20020a056a20bd1e00b0019ca2023f96mr9023837pzb.51.1707082890142; 
 Sun, 04 Feb 2024 13:41:30 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:41:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/39] tcg: Add TCGConst argument to tcg_target_const_match
Date: Mon,  5 Feb 2024 07:40:29 +1000
Message-Id: <20240204214052.5639-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Fill the new argument from any condition within the opcode.
Not yet used within any backend.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        | 34 ++++++++++++++++++++++++++++++--
 tcg/aarch64/tcg-target.c.inc     |  3 ++-
 tcg/arm/tcg-target.c.inc         |  3 ++-
 tcg/i386/tcg-target.c.inc        |  3 ++-
 tcg/loongarch64/tcg-target.c.inc |  3 ++-
 tcg/mips/tcg-target.c.inc        |  3 ++-
 tcg/ppc/tcg-target.c.inc         |  3 ++-
 tcg/riscv/tcg-target.c.inc       |  3 ++-
 tcg/s390x/tcg-target.c.inc       |  3 ++-
 tcg/sparc64/tcg-target.c.inc     |  3 ++-
 tcg/tci/tcg-target.c.inc         |  3 ++-
 11 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 60cb31c400..d6670237fb 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -173,7 +173,8 @@ static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
 static void tcg_out_call(TCGContext *s, const tcg_insn_unit *target,
                          const TCGHelperInfo *info);
 static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot);
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece);
+static bool tcg_target_const_match(int64_t val, int ct,
+                                   TCGType type, TCGCond cond, int vece);
 #ifdef TCG_TARGET_NEED_LDST_LABELS
 static int tcg_out_ldst_finalize(TCGContext *s);
 #endif
@@ -4786,6 +4787,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     TCGTemp *ts;
     TCGArg new_args[TCG_MAX_OP_ARGS];
     int const_args[TCG_MAX_OP_ARGS];
+    TCGCond op_cond;
 
     nb_oargs = def->nb_oargs;
     nb_iargs = def->nb_iargs;
@@ -4798,6 +4800,33 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     i_allocated_regs = s->reserved_regs;
     o_allocated_regs = s->reserved_regs;
 
+    switch (op->opc) {
+    case INDEX_op_brcond_i32:
+    case INDEX_op_brcond_i64:
+        op_cond = op->args[2];
+        break;
+    case INDEX_op_setcond_i32:
+    case INDEX_op_setcond_i64:
+    case INDEX_op_negsetcond_i32:
+    case INDEX_op_negsetcond_i64:
+    case INDEX_op_cmp_vec:
+        op_cond = op->args[3];
+        break;
+    case INDEX_op_brcond2_i32:
+        op_cond = op->args[4];
+        break;
+    case INDEX_op_movcond_i32:
+    case INDEX_op_movcond_i64:
+    case INDEX_op_setcond2_i32:
+    case INDEX_op_cmpsel_vec:
+        op_cond = op->args[5];
+        break;
+    default:
+        /* No condition within opcode. */
+        op_cond = TCG_COND_ALWAYS;
+        break;
+    }
+
     /* satisfy input constraints */
     for (k = 0; k < nb_iargs; k++) {
         TCGRegSet i_preferred_regs, i_required_regs;
@@ -4811,7 +4840,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         ts = arg_temp(arg);
 
         if (ts->val_type == TEMP_VAL_CONST
-            && tcg_target_const_match(ts->val, ts->type, arg_ct->ct, TCGOP_VECE(op))) {
+            && tcg_target_const_match(ts->val, arg_ct->ct, ts->type,
+                                      op_cond, TCGOP_VECE(op))) {
             /* constant is OK for instruction */
             const_args[i] = 1;
             new_args[i] = ts->val;
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index a3efa1e67a..420e4a35ea 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -270,7 +270,8 @@ static bool is_shimm1632(uint32_t v32, int *cmode, int *imm8)
     }
 }
 
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
+static bool tcg_target_const_match(int64_t val, int ct,
+                                   TCGType type, TCGCond cond, int vece)
 {
     if (ct & TCG_CT_CONST) {
         return 1;
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index a9aa8aa91c..113094a5b2 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -501,7 +501,8 @@ static bool is_shimm1632(uint32_t v32, int *cmode, int *imm8)
  * mov operand2:     values represented with x << (2 * y), x < 0x100
  * add, sub, eor...: ditto
  */
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
+static bool tcg_target_const_match(int64_t val, int ct,
+                                   TCGType type, TCGCond cond, int vece)
 {
     if (ct & TCG_CT_CONST) {
         return 1;
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index d268199fc1..accaaa2660 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -195,7 +195,8 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
 }
 
 /* test if a constant matches the constraint */
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
+static bool tcg_target_const_match(int64_t val, int ct,
+                                   TCGType type, TCGCond cond, int vece)
 {
     if (ct & TCG_CT_CONST) {
         return 1;
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index dcf0205458..69c5b8ac4f 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -183,7 +183,8 @@ static inline tcg_target_long sextreg(tcg_target_long val, int pos, int len)
 }
 
 /* test if a constant matches the constraint */
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
+static bool tcg_target_const_match(int64_t val, int ct,
+                                   TCGType type, TCGCond cond, int vece)
 {
     if (ct & TCG_CT_CONST) {
         return true;
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 8328dbdecc..3b5b5c6d5b 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -188,7 +188,8 @@ static bool is_p2m1(tcg_target_long val)
 }
 
 /* test if a constant matches the constraint */
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
+static bool tcg_target_const_match(int64_t val, int ct,
+                                   TCGType type, TCGCond cond, int vece)
 {
     if (ct & TCG_CT_CONST) {
         return 1;
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 54816967bc..850ace98b2 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -282,7 +282,8 @@ static bool reloc_pc34(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
 }
 
 /* test if a constant matches the constraint */
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
+static bool tcg_target_const_match(int64_t val, int ct,
+                                   TCGType type, TCGCond cond, int vece)
 {
     if (ct & TCG_CT_CONST) {
         return 1;
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 34e10e77d9..639363039b 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -145,7 +145,8 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define sextreg  sextract64
 
 /* test if a constant matches the constraint */
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
+static bool tcg_target_const_match(int64_t val, int ct,
+                                   TCGType type, TCGCond cond, int vece)
 {
     if (ct & TCG_CT_CONST) {
         return 1;
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 7f6b84aa2c..54645d1f55 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -538,7 +538,8 @@ static bool risbg_mask(uint64_t c)
 }
 
 /* Test if a constant matches the constraint. */
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
+static bool tcg_target_const_match(int64_t val, int ct,
+                                   TCGType type, TCGCond cond, int vece)
 {
     if (ct & TCG_CT_CONST) {
         return 1;
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index a91defd0ac..ac86b92b75 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -322,7 +322,8 @@ static bool patch_reloc(tcg_insn_unit *src_rw, int type,
 }
 
 /* test if a constant matches the constraint */
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
+static bool tcg_target_const_match(int64_t val, int ct,
+                                   TCGType type, TCGCond cond, int vece)
 {
     if (ct & TCG_CT_CONST) {
         return 1;
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 461f4b47ff..c740864b96 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -913,7 +913,8 @@ static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
 }
 
 /* Test if a constant matches the constraint. */
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
+static bool tcg_target_const_match(int64_t val, int ct,
+                                   TCGType type, TCGCond cond, int vece)
 {
     return ct & TCG_CT_CONST;
 }
-- 
2.34.1


