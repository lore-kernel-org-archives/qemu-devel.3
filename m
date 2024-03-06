Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16C7C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 14:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsZz-0006hE-I6; Wed, 06 Mar 2024 09:49:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsZv-0006eU-QZ
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:49:08 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsZr-0004Mv-0O
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:49:07 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-412f62ee005so5467335e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 06:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709736540; x=1710341340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2sGbd0lv/R8md3B/vm+P9fKxlwBCNXHR/trhpqI1z8Q=;
 b=vpsndotvJfyFQ8x8NoFNNS0JOLVn9C74lHBWvrtd3o2w4VFATijNNJYXFoLONW8x4E
 S3Wr4sYZ91j9K4i7SHKcKWmAx7yjeHF80NWWCD8ZolNQMnTJvrIcE3f6xa+6BVrGuQjl
 +9DZvmE/twa08TnUYXsCdN6IX1fHYlhvxCZ5UbscWA/LP90rgO1piXkScXzHpEaWK7My
 Ji/ltYuBUNq4SC8gf/psRijWaeMrN2Yh4f5tJaoOXKSymh5FahZjgHbIYoQV4HpchvIY
 PVQ9Eok8P9pd38KlUbLeVilkZz5uTgWHlsr13mafacyA6k5tcSnPVajSccA2B8IhwvGN
 U1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709736540; x=1710341340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2sGbd0lv/R8md3B/vm+P9fKxlwBCNXHR/trhpqI1z8Q=;
 b=ILyu5Onv4CjDs6rdiYfPLuIBWzezHrf0MkV2BQ3NR+xAFQ2L+m2As7jrQxOeGZHZV5
 myyj5yo2VTq+fZBd6zSMPT1OeUqgQaHq2A6VcbYHq3b3J3h4lFl4+MQKqDSYlYN4OI5s
 1wmEWttD3qOFwFpqQAWdN1lH1aEXSvj+7YR/LvA9vARmHTm3lhCjmtzpeKQo88AlQWgk
 q8VIVQ9Fw0ED83YIFnDvc9nt7iyLPD0LuRGQB7V17VEAYmdqJT3OL+hMp95rsDmYi3g2
 qPUwh8QoK5q1WqS18ZVMh69gEYKYzj0PY+akvEWtXkpirAjGrq2hLGQzu9yiOAXecd+N
 225A==
X-Gm-Message-State: AOJu0Yw4D1iHbHcaG7lEM3oi1BPych8g+59olc+ovk5Z5r7cOx2vZx3f
 QlZ6ixWrfm0JLgVaMb09YuP/cpcqMoOYnakvXUvxxgycq1NxN+BxDGuFcVYQdVs=
X-Google-Smtp-Source: AGHT+IFZiIKq6k3KFoMveUdfFxyI6xavTuCSs7uPPeFHDS1SJuK3mwxO4Hmdg+vSVXPk/DeNoC3SxQ==
X-Received: by 2002:a05:600c:5490:b0:412:ea93:230d with SMTP id
 iv16-20020a05600c549000b00412ea93230dmr4674917wmb.33.1709736540475; 
 Wed, 06 Mar 2024 06:49:00 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o1-20020a05600c4fc100b00412e97127c0sm6683373wmq.24.2024.03.06.06.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 06:49:00 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6F5975F9E2;
 Wed,  6 Mar 2024 14:40:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 20/29] tests/plugin/insn: migrate to new per_vcpu API
Date: Wed,  6 Mar 2024 14:40:32 +0000
Message-Id: <20240306144041.3787188-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240306144041.3787188-1-alex.bennee@linaro.org>
References: <20240306144041.3787188-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Luc Michel <luc.michel@amd.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240304130036.124418-8-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240305121005.3528075-21-alex.bennee@linaro.org>

diff --git a/tests/plugin/insn.c b/tests/plugin/insn.c
index 54da06fcf26..5e0aa03223e 100644
--- a/tests/plugin/insn.c
+++ b/tests/plugin/insn.c
@@ -16,25 +16,21 @@
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
-#define MAX_CPUS 8 /* lets not go nuts */
-
-typedef struct {
-    uint64_t insn_count;
-} InstructionCount;
-
-static InstructionCount counts[MAX_CPUS];
-static uint64_t inline_insn_count;
+static qemu_plugin_u64 insn_count;
 
 static bool do_inline;
 static bool do_size;
 static GArray *sizes;
 
+typedef struct {
+    uint64_t hits;
+    uint64_t last_hit;
+    uint64_t total_delta;
+} MatchCount;
+
 typedef struct {
     char *match_string;
-    uint64_t hits[MAX_CPUS];
-    uint64_t last_hit[MAX_CPUS];
-    uint64_t total_delta[MAX_CPUS];
-    GPtrArray *history[MAX_CPUS];
+    struct qemu_plugin_scoreboard *counts; /* MatchCount */
 } Match;
 
 static GArray *matches;
@@ -67,41 +63,40 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
 
 static void vcpu_insn_exec_before(unsigned int cpu_index, void *udata)
 {
-    unsigned int i = cpu_index % MAX_CPUS;
-    InstructionCount *c = &counts[i];
-
-    c->insn_count++;
+    qemu_plugin_u64_add(insn_count, cpu_index, 1);
 }
 
 static void vcpu_insn_matched_exec_before(unsigned int cpu_index, void *udata)
 {
-    unsigned int i = cpu_index % MAX_CPUS;
     Instruction *insn = (Instruction *) udata;
-    Match *match = insn->match;
+    Match *insn_match = insn->match;
+    MatchCount *match = qemu_plugin_scoreboard_find(insn_match->counts,
+                                                    cpu_index);
+
     g_autoptr(GString) ts = g_string_new("");
 
     insn->hits++;
     g_string_append_printf(ts, "0x%" PRIx64 ", '%s', %"PRId64 " hits",
                            insn->vaddr, insn->disas, insn->hits);
 
-    uint64_t icount = counts[i].insn_count;
-    uint64_t delta = icount - match->last_hit[i];
+    uint64_t icount = qemu_plugin_u64_get(insn_count, cpu_index);
+    uint64_t delta = icount - match->last_hit;
 
-    match->hits[i]++;
-    match->total_delta[i] += delta;
+    match->hits++;
+    match->total_delta += delta;
 
     g_string_append_printf(ts,
-                           ", %"PRId64" match hits, "
-                           "Δ+%"PRId64 " since last match,"
+                           " , cpu %u,"
+                           " %"PRId64" match hits,"
+                           " Δ+%"PRId64 " since last match,"
                            " %"PRId64 " avg insns/match\n",
-                           match->hits[i], delta,
-                           match->total_delta[i] / match->hits[i]);
+                           cpu_index,
+                           match->hits, delta,
+                           match->total_delta / match->hits);
 
-    match->last_hit[i] = icount;
+    match->last_hit = icount;
 
     qemu_plugin_outs(ts->str);
-
-    g_ptr_array_add(match->history[i], insn);
 }
 
 static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
@@ -113,8 +108,8 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
 
         if (do_inline) {
-            qemu_plugin_register_vcpu_insn_exec_inline(
-                insn, QEMU_PLUGIN_INLINE_ADD_U64, &inline_insn_count, 1);
+            qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+                insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, 1);
         } else {
             uint64_t vaddr = qemu_plugin_insn_vaddr(insn);
             qemu_plugin_register_vcpu_insn_exec_cb(
@@ -136,10 +131,9 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
          * information about the instruction which we also need to
          * save if there is a hit.
          */
-        if (matches) {
+        if (matches->len) {
             char *insn_disas = qemu_plugin_insn_disas(insn);
-            int j;
-            for (j = 0; j < matches->len; j++) {
+            for (int j = 0; j < matches->len; j++) {
                 Match *m = &g_array_index(matches, Match, j);
                 if (g_str_has_prefix(insn_disas, m->match_string)) {
                     Instruction *rec = g_new0(Instruction, 1);
@@ -169,36 +163,33 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
                                        "len %d bytes: %ld insns\n", i, *cnt);
             }
         }
-    } else if (do_inline) {
-        g_string_append_printf(out, "insns: %" PRIu64 "\n", inline_insn_count);
     } else {
-        uint64_t total_insns = 0;
-        for (i = 0; i < MAX_CPUS; i++) {
-            InstructionCount *c = &counts[i];
-            if (c->insn_count) {
-                g_string_append_printf(out, "cpu %d insns: %" PRIu64 "\n",
-                                       i, c->insn_count);
-                total_insns += c->insn_count;
-            }
+        for (i = 0; i < qemu_plugin_num_vcpus(); i++) {
+            g_string_append_printf(out, "cpu %d insns: %" PRIu64 "\n",
+                                   i, qemu_plugin_u64_get(insn_count, i));
         }
         g_string_append_printf(out, "total insns: %" PRIu64 "\n",
-                               total_insns);
+                               qemu_plugin_u64_sum(insn_count));
     }
     qemu_plugin_outs(out->str);
+
+    qemu_plugin_scoreboard_free(insn_count.score);
+    for (i = 0; i < matches->len; ++i) {
+        Match *m = &g_array_index(matches, Match, i);
+        g_free(m->match_string);
+        qemu_plugin_scoreboard_free(m->counts);
+    }
+    g_array_free(matches, TRUE);
+    g_array_free(sizes, TRUE);
 }
 
 
 /* Add a match to the array of matches */
 static void parse_match(char *match)
 {
-    Match new_match = { .match_string = match };
-    int i;
-    for (i = 0; i < MAX_CPUS; i++) {
-        new_match.history[i] = g_ptr_array_new();
-    }
-    if (!matches) {
-        matches = g_array_new(false, true, sizeof(Match));
-    }
+    Match new_match = {
+        .match_string = g_strdup(match),
+        .counts = qemu_plugin_scoreboard_new(sizeof(MatchCount)) };
     g_array_append_val(matches, new_match);
 }
 
@@ -206,6 +197,10 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            const qemu_info_t *info,
                                            int argc, char **argv)
 {
+    matches = g_array_new(false, true, sizeof(Match));
+    /* null terminated so 0 is not a special case */
+    sizes = g_array_new(true, true, sizeof(unsigned long));
+
     for (int i = 0; i < argc; i++) {
         char *opt = argv[i];
         g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
@@ -227,9 +222,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         }
     }
 
-    if (do_size) {
-        sizes = g_array_new(true, true, sizeof(unsigned long));
-    }
+    insn_count = qemu_plugin_scoreboard_u64(
+        qemu_plugin_scoreboard_new(sizeof(uint64_t)));
 
     /* Register init, translation block and exit callbacks */
     qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
-- 
2.39.2


