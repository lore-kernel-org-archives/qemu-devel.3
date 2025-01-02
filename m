Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DC9E7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPfa-00059Q-8E; Thu, 02 Jan 2025 13:11:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeX-0007Lm-BQ
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:43 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeU-0006Dm-Mb
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:37 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2161eb95317so163094495ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841433; x=1736446233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lzsP+UWMx/D13Dq3Gtzq1OLFMQJVWY+dBn5HNIxlV40=;
 b=YBkZUOmwnJork8BenriF7ynEk9KoqBoNpADCG+qNFH5CjoCcNVY0crGTECWi/cYjPB
 bsCXNxV634v+2PQr+unM8YVBoEeUzUw+rgw1jLfWaWttHUW1oViECX3K8V6Aqr58Afbb
 HvKZLWTczhpiRN2ZTAIeceQaeBP/yICU6MlbpM4xfwuKjPvNbWKhXRm2AIaYqtx6yMVM
 o1ljM7+SEoDRv3vQ+Yo8XCOnmgqd0EOT2nSpp5Kh9PCbp6ZYuMnZh7hzDjD8ltc7+bVn
 FXuFeNFTAs9yzCL4dQjXa2+osXhjAcK76J0GhQhHU+m/oDBB7aNB1/0sh9i9Hn6kkZ3l
 gt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841433; x=1736446233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lzsP+UWMx/D13Dq3Gtzq1OLFMQJVWY+dBn5HNIxlV40=;
 b=DfB8dHm5RiAktMR5fX44+aXVH+3tLoywCIwrDfBB/lNajh46VkgE/RSreOHGIkRbac
 JyAeL4macUPElr+Mya2bO7fyikWu5YhWANWxPmvZxMEP7m0WvMOUVdMyrLipivrRc8PC
 wTYPGeL8IqWNmHFaTy41oaMBZ44mWXW3A2M9BrHjiTPxaZjtg74EV/xQkMGjTkbLMmaw
 vEC0zIVHhrKNWobOgSXnLMI2D4zw7+7TRavWVzWY4crbuucZNBXbM4HVfmK4PCMnJXjT
 c5cycuVjwwzPvOiD95MvlJpfI+jHOmQyziXWWaGpDw5PG6RVLEf9X3wKkxRnEsN8YoBv
 /f/g==
X-Gm-Message-State: AOJu0YwnkhKsXX9KRJwTxDvx1pKZ66vs/eKmByH21abLcEC/15ouJ3K3
 oEOY1iwgdXzAleEelgBgYfChzvFhmktGOkoSvj5h43Ue3wXniLKwv5ObalfvLSjhrVSW+auQYu9
 I
X-Gm-Gg: ASbGncvdR41XkwzQxbL3ZhUb8yKR2YBlrVOH4qhBtwM47DXRVy/9HS1Yjy0epc+PjJD
 vZDJpNHuPd36+bD0i7Iy0hFLW31TTQv1HoZQWxsEguUQrlCJXOC+teJYSYmXz4mJw2rI2u70Ayg
 +mQ1XdWlrrXP8lpdV9v5f2EzktjzqmLAseUDuADen68D/YEanzZHCuUrRjJVl3kSy72qb2YUuMp
 qZF6FF0l3ZBwQXHF8/5GcZytouhTDokZD+67iQze0e+mlaNcALJSCo8+rh3Kw==
X-Google-Smtp-Source: AGHT+IHtmFD4BZdha8wphR+nzr4Q9GSsKXf56xG55lbyyt9JScnrwY0MNIvJ+e5W2wMSWOSGvcGj+A==
X-Received: by 2002:a05:6a00:410d:b0:728:fab1:edbb with SMTP id
 d2e1a72fcca58-72abde8fd62mr70179128b3a.20.1735841433205; 
 Thu, 02 Jan 2025 10:10:33 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 49/73] tcg: Reorg process_op_defs
Date: Thu,  2 Jan 2025 10:06:29 -0800
Message-ID: <20250102180654.1420056-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Process each TCGConstraintSetIndex first.  Allocate TCGArgConstraint
arrays based on those.  Only afterward process the TCGOpcodes and
share those TCGArgConstraint arrays.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h |   7 +-
 tcg/tcg.c         | 273 +++++++++++++++++++++++-----------------------
 2 files changed, 139 insertions(+), 141 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index ee4785d33b..d589dbe02b 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -710,17 +710,12 @@ typedef struct TCGOpDef {
     const char *name;
     uint8_t nb_oargs, nb_iargs, nb_cargs, nb_args;
     uint8_t flags;
-    TCGArgConstraint *args_ct;
+    const TCGArgConstraint *args_ct;
 } TCGOpDef;
 
 extern TCGOpDef tcg_op_defs[];
 extern const size_t tcg_op_defs_max;
 
-typedef struct TCGTargetOpDef {
-    TCGOpcode op;
-    const char *args_ct_str[TCG_MAX_OP_ARGS];
-} TCGTargetOpDef;
-
 bool tcg_op_supported(TCGOpcode op, TCGType type);
 bool tcg_op_deposit_valid(TCGType type, unsigned ofs, unsigned len);
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 775d51953c..343da162a5 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -895,31 +895,35 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode);
 
 /* Put all of the constraint sets into an array, indexed by the enum. */
 
-#define C_O0_I1(I1)                     { .args_ct_str = { #I1 } },
-#define C_O0_I2(I1, I2)                 { .args_ct_str = { #I1, #I2 } },
-#define C_O0_I3(I1, I2, I3)             { .args_ct_str = { #I1, #I2, #I3 } },
-#define C_O0_I4(I1, I2, I3, I4)         { .args_ct_str = { #I1, #I2, #I3, #I4 } },
+typedef struct TCGConstraintSet {
+    uint8_t nb_oargs, nb_iargs;
+    const char *args_ct_str[TCG_MAX_OP_ARGS];
+} TCGConstraintSet;
 
-#define C_O1_I1(O1, I1)                 { .args_ct_str = { #O1, #I1 } },
-#define C_O1_I2(O1, I1, I2)             { .args_ct_str = { #O1, #I1, #I2 } },
-#define C_O1_I3(O1, I1, I2, I3)         { .args_ct_str = { #O1, #I1, #I2, #I3 } },
-#define C_O1_I4(O1, I1, I2, I3, I4)     { .args_ct_str = { #O1, #I1, #I2, #I3, #I4 } },
+#define C_O0_I1(I1)                     { 0, 1, { #I1 } },
+#define C_O0_I2(I1, I2)                 { 0, 2, { #I1, #I2 } },
+#define C_O0_I3(I1, I2, I3)             { 0, 3, { #I1, #I2, #I3 } },
+#define C_O0_I4(I1, I2, I3, I4)         { 0, 4, { #I1, #I2, #I3, #I4 } },
 
-#define C_N1_I2(O1, I1, I2)             { .args_ct_str = { "&" #O1, #I1, #I2 } },
-#define C_N1O1_I1(O1, O2, I1)           { .args_ct_str = { "&" #O1, #O2, #I1 } },
-#define C_N2_I1(O1, O2, I1)             { .args_ct_str = { "&" #O1, "&" #O2, #I1 } },
+#define C_O1_I1(O1, I1)                 { 1, 1, { #O1, #I1 } },
+#define C_O1_I2(O1, I1, I2)             { 1, 2, { #O1, #I1, #I2 } },
+#define C_O1_I3(O1, I1, I2, I3)         { 1, 3, { #O1, #I1, #I2, #I3 } },
+#define C_O1_I4(O1, I1, I2, I3, I4)     { 1, 4, { #O1, #I1, #I2, #I3, #I4 } },
 
-#define C_O2_I1(O1, O2, I1)             { .args_ct_str = { #O1, #O2, #I1 } },
-#define C_O2_I2(O1, O2, I1, I2)         { .args_ct_str = { #O1, #O2, #I1, #I2 } },
-#define C_O2_I3(O1, O2, I1, I2, I3)     { .args_ct_str = { #O1, #O2, #I1, #I2, #I3 } },
-#define C_O2_I4(O1, O2, I1, I2, I3, I4) { .args_ct_str = { #O1, #O2, #I1, #I2, #I3, #I4 } },
-#define C_N1_O1_I4(O1, O2, I1, I2, I3, I4) { .args_ct_str = { "&" #O1, #O2, #I1, #I2, #I3, #I4 } },
+#define C_N1_I2(O1, I1, I2)             { 1, 2, { "&" #O1, #I1, #I2 } },
+#define C_N1O1_I1(O1, O2, I1)           { 2, 1, { "&" #O1, #O2, #I1 } },
+#define C_N2_I1(O1, O2, I1)             { 2, 1, { "&" #O1, "&" #O2, #I1 } },
 
-static const TCGTargetOpDef constraint_sets[] = {
+#define C_O2_I1(O1, O2, I1)             { 2, 1, { #O1, #O2, #I1 } },
+#define C_O2_I2(O1, O2, I1, I2)         { 2, 2, { #O1, #O2, #I1, #I2 } },
+#define C_O2_I3(O1, O2, I1, I2, I3)     { 2, 3, { #O1, #O2, #I1, #I2, #I3 } },
+#define C_O2_I4(O1, O2, I1, I2, I3, I4) { 2, 4, { #O1, #O2, #I1, #I2, #I3, #I4 } },
+#define C_N1_O1_I4(O1, O2, I1, I2, I3, I4) { 2, 4, { "&" #O1, #O2, #I1, #I2, #I3, #I4 } },
+
+static const TCGConstraintSet constraint_sets[] = {
 #include "tcg-target-con-set.h"
 };
 
-
 #undef C_O0_I1
 #undef C_O0_I2
 #undef C_O0_I3
@@ -1514,32 +1518,12 @@ static TCGTemp *tcg_global_reg_new_internal(TCGContext *s, TCGType type,
 static void tcg_context_init(unsigned max_cpus)
 {
     TCGContext *s = &tcg_init_ctx;
-    int op, total_args, n, i;
-    TCGOpDef *def;
-    TCGArgConstraint *args_ct;
+    int  n, i;
     TCGTemp *ts;
 
     memset(s, 0, sizeof(*s));
     s->nb_globals = 0;
 
-    /* Count total number of arguments and allocate the corresponding
-       space */
-    total_args = 0;
-    for(op = 0; op < NB_OPS; op++) {
-        def = &tcg_op_defs[op];
-        n = def->nb_iargs + def->nb_oargs;
-        total_args += n;
-    }
-
-    args_ct = g_new0(TCGArgConstraint, total_args);
-
-    for(op = 0; op < NB_OPS; op++) {
-        def = &tcg_op_defs[op];
-        def->args_ct = args_ct;
-        n = def->nb_iargs + def->nb_oargs;
-        args_ct += n;
-    }
-
     init_call_layout(&info_helper_ld32_mmu);
     init_call_layout(&info_helper_ld64_mmu);
     init_call_layout(&info_helper_ld128_mmu);
@@ -3090,10 +3074,12 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
 }
 
 /* we give more priority to constraints with less registers */
-static int get_constraint_priority(const TCGOpDef *def, int k)
+static int get_constraint_priority(const TCGArgConstraint *arg_ct, int k)
 {
-    const TCGArgConstraint *arg_ct = &def->args_ct[k];
-    int n = ctpop64(arg_ct->regs);
+    int n;
+
+    arg_ct += k;
+    n = ctpop64(arg_ct->regs);
 
     /*
      * Sort constraints of a single register first, which includes output
@@ -3122,10 +3108,9 @@ static int get_constraint_priority(const TCGOpDef *def, int k)
 }
 
 /* sort from highest priority to lowest */
-static void sort_constraints(TCGOpDef *def, int start, int n)
+static void sort_constraints(TCGArgConstraint *a, int start, int n)
 {
     int i, j;
-    TCGArgConstraint *a = def->args_ct;
 
     for (i = 0; i < n; i++) {
         a[start + i].sort_index = start + i;
@@ -3135,8 +3120,8 @@ static void sort_constraints(TCGOpDef *def, int start, int n)
     }
     for (i = 0; i < n - 1; i++) {
         for (j = i + 1; j < n; j++) {
-            int p1 = get_constraint_priority(def, a[start + i].sort_index);
-            int p2 = get_constraint_priority(def, a[start + j].sort_index);
+            int p1 = get_constraint_priority(a, a[start + i].sort_index);
+            int p2 = get_constraint_priority(a, a[start + j].sort_index);
             if (p1 < p2) {
                 int tmp = a[start + i].sort_index;
                 a[start + i].sort_index = a[start + j].sort_index;
@@ -3146,56 +3131,43 @@ static void sort_constraints(TCGOpDef *def, int start, int n)
     }
 }
 
+static const TCGArgConstraint empty_cts[TCG_MAX_OP_ARGS];
+static TCGArgConstraint all_args_cts[ARRAY_SIZE(constraint_sets)][TCG_MAX_OP_ARGS];
+
 static void process_op_defs(TCGContext *s)
 {
-    TCGOpcode op;
+    /*
+     * Process each constraint set.
+     */
 
-    for (op = 0; op < NB_OPS; op++) {
-        TCGOpDef *def = &tcg_op_defs[op];
-        const TCGTargetOpDef *tdefs;
+    for (size_t c = 0; c < ARRAY_SIZE(constraint_sets); ++c) {
+        const TCGConstraintSet *tdefs = &constraint_sets[c];
+        TCGArgConstraint *args_ct = all_args_cts[c];
+        int nb_oargs = tdefs->nb_oargs;
+        int nb_iargs = tdefs->nb_iargs;
+        int nb_args = nb_oargs + nb_iargs;
         bool saw_alias_pair = false;
-        int i, o, i2, o2, nb_args;
 
-        if (def->flags & TCG_OPF_NOT_PRESENT) {
-            continue;
-        }
-
-        nb_args = def->nb_iargs + def->nb_oargs;
-        if (nb_args == 0) {
-            continue;
-        }
-
-        /*
-         * Macro magic should make it impossible, but double-check that
-         * the array index is in range.  Since the signness of an enum
-         * is implementation defined, force the result to unsigned.
-         */
-        unsigned con_set = tcg_target_op_def(op);
-        tcg_debug_assert(con_set < ARRAY_SIZE(constraint_sets));
-        tdefs = &constraint_sets[con_set];
-
-        for (i = 0; i < nb_args; i++) {
+        for (int i = 0; i < nb_args; i++) {
             const char *ct_str = tdefs->args_ct_str[i];
-            bool input_p = i >= def->nb_oargs;
-
-            /* Incomplete TCGTargetOpDef entry. */
-            tcg_debug_assert(ct_str != NULL);
+            bool input_p = i >= nb_oargs;
+            int o;
 
             switch (*ct_str) {
             case '0' ... '9':
                 o = *ct_str - '0';
                 tcg_debug_assert(input_p);
-                tcg_debug_assert(o < def->nb_oargs);
-                tcg_debug_assert(def->args_ct[o].regs != 0);
-                tcg_debug_assert(!def->args_ct[o].oalias);
-                def->args_ct[i] = def->args_ct[o];
+                tcg_debug_assert(o < nb_oargs);
+                tcg_debug_assert(args_ct[o].regs != 0);
+                tcg_debug_assert(!args_ct[o].oalias);
+                args_ct[i] = args_ct[o];
                 /* The output sets oalias.  */
-                def->args_ct[o].oalias = 1;
-                def->args_ct[o].alias_index = i;
+                args_ct[o].oalias = 1;
+                args_ct[o].alias_index = i;
                 /* The input sets ialias. */
-                def->args_ct[i].ialias = 1;
-                def->args_ct[i].alias_index = o;
-                if (def->args_ct[i].pair) {
+                args_ct[i].ialias = 1;
+                args_ct[i].alias_index = o;
+                if (args_ct[i].pair) {
                     saw_alias_pair = true;
                 }
                 tcg_debug_assert(ct_str[1] == '\0');
@@ -3203,41 +3175,41 @@ static void process_op_defs(TCGContext *s)
 
             case '&':
                 tcg_debug_assert(!input_p);
-                def->args_ct[i].newreg = true;
+                args_ct[i].newreg = true;
                 ct_str++;
                 break;
 
             case 'p': /* plus */
                 /* Allocate to the register after the previous. */
-                tcg_debug_assert(i > (input_p ? def->nb_oargs : 0));
+                tcg_debug_assert(i > (input_p ? nb_oargs : 0));
                 o = i - 1;
-                tcg_debug_assert(!def->args_ct[o].pair);
-                tcg_debug_assert(!def->args_ct[o].ct);
-                def->args_ct[i] = (TCGArgConstraint){
+                tcg_debug_assert(!args_ct[o].pair);
+                tcg_debug_assert(!args_ct[o].ct);
+                args_ct[i] = (TCGArgConstraint){
                     .pair = 2,
                     .pair_index = o,
-                    .regs = def->args_ct[o].regs << 1,
-                    .newreg = def->args_ct[o].newreg,
+                    .regs = args_ct[o].regs << 1,
+                    .newreg = args_ct[o].newreg,
                 };
-                def->args_ct[o].pair = 1;
-                def->args_ct[o].pair_index = i;
+                args_ct[o].pair = 1;
+                args_ct[o].pair_index = i;
                 tcg_debug_assert(ct_str[1] == '\0');
                 continue;
 
             case 'm': /* minus */
                 /* Allocate to the register before the previous. */
-                tcg_debug_assert(i > (input_p ? def->nb_oargs : 0));
+                tcg_debug_assert(i > (input_p ? nb_oargs : 0));
                 o = i - 1;
-                tcg_debug_assert(!def->args_ct[o].pair);
-                tcg_debug_assert(!def->args_ct[o].ct);
-                def->args_ct[i] = (TCGArgConstraint){
+                tcg_debug_assert(!args_ct[o].pair);
+                tcg_debug_assert(!args_ct[o].ct);
+                args_ct[i] = (TCGArgConstraint){
                     .pair = 1,
                     .pair_index = o,
-                    .regs = def->args_ct[o].regs >> 1,
-                    .newreg = def->args_ct[o].newreg,
+                    .regs = args_ct[o].regs >> 1,
+                    .newreg = args_ct[o].newreg,
                 };
-                def->args_ct[o].pair = 2;
-                def->args_ct[o].pair_index = i;
+                args_ct[o].pair = 2;
+                args_ct[o].pair_index = i;
                 tcg_debug_assert(ct_str[1] == '\0');
                 continue;
             }
@@ -3245,16 +3217,16 @@ static void process_op_defs(TCGContext *s)
             do {
                 switch (*ct_str) {
                 case 'i':
-                    def->args_ct[i].ct |= TCG_CT_CONST;
+                    args_ct[i].ct |= TCG_CT_CONST;
                     break;
 
                 /* Include all of the target-specific constraints. */
 
 #undef CONST
 #define CONST(CASE, MASK) \
-    case CASE: def->args_ct[i].ct |= MASK; break;
+    case CASE: args_ct[i].ct |= MASK; break;
 #define REGS(CASE, MASK) \
-    case CASE: def->args_ct[i].regs |= MASK; break;
+    case CASE: args_ct[i].regs |= MASK; break;
 
 #include "tcg-target-con-str.h"
 
@@ -3265,15 +3237,12 @@ static void process_op_defs(TCGContext *s)
                 case '&':
                 case 'p':
                 case 'm':
-                    /* Typo in TCGTargetOpDef constraint. */
+                    /* Typo in TCGConstraintSet constraint. */
                     g_assert_not_reached();
                 }
             } while (*++ct_str != '\0');
         }
 
-        /* TCGTargetOpDef entry with too much information? */
-        tcg_debug_assert(i == TCG_MAX_OP_ARGS || tdefs->args_ct_str[i] == NULL);
-
         /*
          * Fix up output pairs that are aliased with inputs.
          * When we created the alias, we copied pair from the output.
@@ -3294,51 +3263,53 @@ static void process_op_defs(TCGContext *s)
          * first output to pair=3, and the pair_index'es to match.
          */
         if (saw_alias_pair) {
-            for (i = def->nb_oargs; i < nb_args; i++) {
+            for (int i = nb_oargs; i < nb_args; i++) {
+                int o, o2, i2;
+
                 /*
                  * Since [0-9pm] must be alone in the constraint string,
                  * the only way they can both be set is if the pair comes
                  * from the output alias.
                  */
-                if (!def->args_ct[i].ialias) {
+                if (!args_ct[i].ialias) {
                     continue;
                 }
-                switch (def->args_ct[i].pair) {
+                switch (args_ct[i].pair) {
                 case 0:
                     break;
                 case 1:
-                    o = def->args_ct[i].alias_index;
-                    o2 = def->args_ct[o].pair_index;
-                    tcg_debug_assert(def->args_ct[o].pair == 1);
-                    tcg_debug_assert(def->args_ct[o2].pair == 2);
-                    if (def->args_ct[o2].oalias) {
+                    o = args_ct[i].alias_index;
+                    o2 = args_ct[o].pair_index;
+                    tcg_debug_assert(args_ct[o].pair == 1);
+                    tcg_debug_assert(args_ct[o2].pair == 2);
+                    if (args_ct[o2].oalias) {
                         /* Case 1a */
-                        i2 = def->args_ct[o2].alias_index;
-                        tcg_debug_assert(def->args_ct[i2].pair == 2);
-                        def->args_ct[i2].pair_index = i;
-                        def->args_ct[i].pair_index = i2;
+                        i2 = args_ct[o2].alias_index;
+                        tcg_debug_assert(args_ct[i2].pair == 2);
+                        args_ct[i2].pair_index = i;
+                        args_ct[i].pair_index = i2;
                     } else {
                         /* Case 1b */
-                        def->args_ct[i].pair_index = i;
+                        args_ct[i].pair_index = i;
                     }
                     break;
                 case 2:
-                    o = def->args_ct[i].alias_index;
-                    o2 = def->args_ct[o].pair_index;
-                    tcg_debug_assert(def->args_ct[o].pair == 2);
-                    tcg_debug_assert(def->args_ct[o2].pair == 1);
-                    if (def->args_ct[o2].oalias) {
+                    o = args_ct[i].alias_index;
+                    o2 = args_ct[o].pair_index;
+                    tcg_debug_assert(args_ct[o].pair == 2);
+                    tcg_debug_assert(args_ct[o2].pair == 1);
+                    if (args_ct[o2].oalias) {
                         /* Case 1a */
-                        i2 = def->args_ct[o2].alias_index;
-                        tcg_debug_assert(def->args_ct[i2].pair == 1);
-                        def->args_ct[i2].pair_index = i;
-                        def->args_ct[i].pair_index = i2;
+                        i2 = args_ct[o2].alias_index;
+                        tcg_debug_assert(args_ct[i2].pair == 1);
+                        args_ct[i2].pair_index = i;
+                        args_ct[i].pair_index = i2;
                     } else {
                         /* Case 2 */
-                        def->args_ct[i].pair = 3;
-                        def->args_ct[o2].pair = 3;
-                        def->args_ct[i].pair_index = o2;
-                        def->args_ct[o2].pair_index = i;
+                        args_ct[i].pair = 3;
+                        args_ct[o2].pair = 3;
+                        args_ct[i].pair_index = o2;
+                        args_ct[o2].pair_index = i;
                     }
                     break;
                 default:
@@ -3348,8 +3319,40 @@ static void process_op_defs(TCGContext *s)
         }
 
         /* sort the constraints (XXX: this is just an heuristic) */
-        sort_constraints(def, 0, def->nb_oargs);
-        sort_constraints(def, def->nb_oargs, def->nb_iargs);
+        sort_constraints(args_ct, 0, nb_oargs);
+        sort_constraints(args_ct, nb_oargs, nb_iargs);
+    }
+
+    for (TCGOpcode op = 0; op < NB_OPS; op++) {
+        TCGOpDef *def = &tcg_op_defs[op];
+        const TCGConstraintSet *tdefs;
+        unsigned con_set;
+        int nb_args;
+
+        nb_args = def->nb_iargs + def->nb_oargs;
+        if (nb_args == 0) {
+            continue;
+        }
+
+        if (def->flags & TCG_OPF_NOT_PRESENT) {
+            def->args_ct = empty_cts;
+            continue;
+        }
+
+        /*
+         * Macro magic should make it impossible, but double-check that
+         * the array index is in range.  Since the signness of an enum
+         * is implementation defined, force the result to unsigned.
+         */
+        con_set = tcg_target_op_def(op);
+        tcg_debug_assert(con_set < ARRAY_SIZE(constraint_sets));
+
+        /* The constraint arguments must match TCGOpcode arguments. */
+        tdefs = &constraint_sets[con_set];
+        tcg_debug_assert(tdefs->nb_oargs == def->nb_oargs);
+        tcg_debug_assert(tdefs->nb_iargs == def->nb_iargs);
+
+        def->args_ct = all_args_cts[con_set];
     }
 }
 
-- 
2.43.0


