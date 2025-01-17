Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E228C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr2Q-0004WE-99; Fri, 17 Jan 2025 13:25:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr2E-0004BT-S8
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:36 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr27-0007v9-Bg
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:34 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2165448243fso57144995ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138326; x=1737743126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DHOuFKbiyyQEX/klSmP2CeFyRwv+iNHGvEa+p7k0Rd8=;
 b=lmXMPTXJ4qVTpzCjmMbZ6ezy53w/5BwExyCfHeLKtj4dT89kJ17w0Oq7P+/6vJcVvg
 GegT7k1fhjAO/ZT+8MkfVzdRk0zLBlldhkFR/qnMatNtsFxg/Y+JvrGDmzYzLAzYZmzJ
 KoAEiIX4Zo4/EK7S4S74QwNgVCMduKZbGiRlubyKDoS3wk0zMS+wYxArSlbA2vFivExh
 PoxzMkTjDtyOrt5LouvhpowuoLI6QbUcSdMn2uAuTSGYLblp8sLFYoFL1b0gGR4WKzQ0
 JJpDmIAb4CitjM3NFL6b69pRYhJT87yhsDsHQt2fO4DH2XjRFAenPiGV3QY+to64qX4W
 77iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138326; x=1737743126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DHOuFKbiyyQEX/klSmP2CeFyRwv+iNHGvEa+p7k0Rd8=;
 b=wOChX6VwPrjTVyNG635QUODy/wXqlHCcJYaVpz+Px1ZgwhX8TThJF23Ey1mMvrw76N
 glIShCluYUB4ipO50RmR3tgapkGP5b5eARF9Wkyv6OgsZE+PFhkVmR9vHmK/G2AlZUhH
 hQWy6NsQzjhlIs3yMDMY/TgGIp81EBi+E+emw2+JaNTBV/ShO8I/OvdMqHgZJhyZVupM
 gVPyg26rM8fSzFHvMitYHDkk9/x3LJ3uUz6oIv1+n1FjO2eZUR9rh15r4vFvwb4VSKjA
 05vJyozh+U45vCqA8MsOC5xSd3OV4z+BKf7McuhskVgERZbvFZB4a/2sdZd1xANCcqDd
 6YrA==
X-Gm-Message-State: AOJu0YxFTo4dBjdfTOsZafmr0+W3gcTXWKq68fYMAP9zZxxbCdGkKAk0
 OWtXHYJFduwjr1DeBCZ5zM068sh+JKJbOmxUVeArmH3xrkEyNvIX+XZsbo/FkPCZcecqiBSzJ7f
 y
X-Gm-Gg: ASbGncsDFtCcXj3GFSx908pdynmMUz29WdsTRKi88wFBNGKoJr5jH7GE2huVFST47/l
 XhEKPSHRXLDXgJRloToxZopPNDXMxw70lH7C0sv0oUQIUH5iAbA06P8u81Tb+ySgyTm2vCbdeOv
 MnPX+mwPeYUfBD3yh5kmHKzyblKxxKcNzpfoiNoQ/opKF09nJ/+QgUsRGTFKfTwlYVZn+Gxivt9
 AxqpOkl1SCL7hgqgSSizVR+ocOzhcEf+F3VgqxR1WuXiuyZKN7MjQuMIR7McfGuCMZFIPSFyCih
 z3ImhLB1vK3d1W8=
X-Google-Smtp-Source: AGHT+IFrsATpKJGWWXrmuZpjtl1CU2xr4aRnzklWAAZmhfh9Bdj6uy2VjrOiHMLfmP+e0fUhmvat+w==
X-Received: by 2002:a17:903:1d1:b0:216:4724:2757 with SMTP id
 d9443c01a7336-21c353eed3fmr55248215ad.4.1737138325883; 
 Fri, 17 Jan 2025 10:25:25 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 36/68] tcg: Reorg process_op_defs
Date: Fri, 17 Jan 2025 10:24:24 -0800
Message-ID: <20250117182456.2077110-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h |   7 +-
 tcg/tcg.c         | 272 +++++++++++++++++++++++-----------------------
 2 files changed, 136 insertions(+), 143 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index e5fa69d20b..a02de82508 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -714,17 +714,12 @@ typedef struct TCGOpDef {
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
 /*
  * tcg_op_supported:
  * Query if @op, for @type and @flags, is supported by the host
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 915a181596..d5ab0abe9d 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -887,31 +887,35 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode);
 
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
@@ -1499,32 +1503,12 @@ static TCGTemp *tcg_global_reg_new_internal(TCGContext *s, TCGType type,
 static void tcg_context_init(unsigned max_cpus)
 {
     TCGContext *s = &tcg_init_ctx;
-    int op, total_args, n, i;
-    TCGOpDef *def;
-    TCGArgConstraint *args_ct;
+    int n, i;
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
@@ -3132,10 +3116,12 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
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
@@ -3164,10 +3150,9 @@ static int get_constraint_priority(const TCGOpDef *def, int k)
 }
 
 /* sort from highest priority to lowest */
-static void sort_constraints(TCGOpDef *def, int start, int n)
+static void sort_constraints(TCGArgConstraint *a, int start, int n)
 {
     int i, j;
-    TCGArgConstraint *a = def->args_ct;
 
     for (i = 0; i < n; i++) {
         a[start + i].sort_index = start + i;
@@ -3177,8 +3162,8 @@ static void sort_constraints(TCGOpDef *def, int start, int n)
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
@@ -3188,57 +3173,39 @@ static void sort_constraints(TCGOpDef *def, int start, int n)
     }
 }
 
+static const TCGArgConstraint empty_cts[TCG_MAX_OP_ARGS];
+static TCGArgConstraint all_cts[ARRAY_SIZE(constraint_sets)][TCG_MAX_OP_ARGS];
+
 static void process_op_defs(TCGContext *s)
 {
-    TCGOpcode op;
-
-    for (op = 0; op < NB_OPS; op++) {
-        TCGOpDef *def = &tcg_op_defs[op];
-        const TCGTargetOpDef *tdefs;
+    for (size_t c = 0; c < ARRAY_SIZE(constraint_sets); ++c) {
+        const TCGConstraintSet *tdefs = &constraint_sets[c];
+        TCGArgConstraint *args_ct = all_cts[c];
+        int nb_oargs = tdefs->nb_oargs;
+        int nb_iargs = tdefs->nb_iargs;
+        int nb_args = nb_oargs + nb_iargs;
         bool saw_alias_pair = false;
-        int i, o, i2, o2, nb_args;
-        TCGConstraintSetIndex con_set;
 
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
-         * the array index is in range.  At the same time, double-check
-         * that the opcode is implemented, i.e. not C_NotImplemented.
-         */
-        con_set = tcg_target_op_def(op);
-        tcg_debug_assert(con_set >= 0 && con_set < ARRAY_SIZE(constraint_sets));
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
@@ -3246,41 +3213,41 @@ static void process_op_defs(TCGContext *s)
 
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
@@ -3288,16 +3255,16 @@ static void process_op_defs(TCGContext *s)
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
 
@@ -3308,15 +3275,12 @@ static void process_op_defs(TCGContext *s)
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
@@ -3337,51 +3301,53 @@ static void process_op_defs(TCGContext *s)
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
@@ -3391,8 +3357,40 @@ static void process_op_defs(TCGContext *s)
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
+        TCGConstraintSetIndex con_set;
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
+         * the array index is in range.  At the same time, double-check
+         * that the opcode is implemented, i.e. not C_NotImplemented.
+         */
+        con_set = tcg_target_op_def(op);
+        tcg_debug_assert(con_set >= 0 && con_set < ARRAY_SIZE(constraint_sets));
+
+        /* The constraint arguments must match TCGOpcode arguments. */
+        tdefs = &constraint_sets[con_set];
+        tcg_debug_assert(tdefs->nb_oargs == def->nb_oargs);
+        tcg_debug_assert(tdefs->nb_iargs == def->nb_iargs);
+
+        def->args_ct = all_cts[con_set];
     }
 }
 
-- 
2.43.0


