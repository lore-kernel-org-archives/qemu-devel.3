Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B503EC5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 13:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh7xE-0002Lm-8p; Mon, 04 Mar 2024 08:02:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rh7wm-0001kn-Ow
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:01:40 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rh7wk-0000oX-IB
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:01:36 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a44cdb2d3a6so267539566b.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 05:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709557293; x=1710162093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tf1+lHjqcZCQuGZij+aDXt7N00g1XwukV+xuLoc/HBQ=;
 b=gB7DXcDQ6GiP/3iNIL3pTxxonBlcRec0/JFiJcuFyZXq2oSROXRv6rX5XNldJk+Fym
 /P38qMF1jgfnxqVtuB0xqpvl6WCkW0DvWBvx4Ufoqu3bi+UPUzFRVr7vFI/CiY5zQ2/2
 8NGhfGWhluX4SP8g8Qay0Ju94gBj9koOu9xtalvyCfpPWplIip4m9RzDY/G3lMRpW8NO
 uFLaC5RIAD7LSiOYfAwqCyihJwNi9LneNQ44iH7mBsG9GAFQD23rBicu9GHKcRMoUD4h
 kRAANS9YikP9iSH8eAiR22CAQQ2DPvHJ6Q0hsnB1wy6iLH//OHu+AeqWzr0j6jiYQTs+
 8aCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709557293; x=1710162093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tf1+lHjqcZCQuGZij+aDXt7N00g1XwukV+xuLoc/HBQ=;
 b=j/gjlfqFLf7jmXT3Vnua4h7BdjrTEP57PLlk3aZ1cKD/uzgdJrImJuUbrSojAn9TfM
 O9Rpw0hx3AgP0yAHjNAiluVU8ajBATVeeptyjtCVp4EN7B5yH/y+9wGCn4wqN186oGnr
 Dco8BPgffDw9Fv50kN/3WmWLWloKw/ampoPUm6KOuKWW8iq0hVU8UHL9Y0L2acrajUgO
 sA9Cxu/Cdds4w+5ZyYcD51zP0VExwxVAT8lV7klI27qQQei5NFIHTiQ3Gc2jciFLwKQR
 lox20T7DhBKDeNHtwf6aeuw+ogvvuP1B5xEkcBuuxpaQGsc1ZrZWxgyqFvkuoiKG6+g2
 lFoQ==
X-Gm-Message-State: AOJu0YyAKGozTqjOza5RGRHlEWaHOYDDusrFXcq0zc2iTlWVus2gkSNc
 dSeIVgOy3EuAol52Egoc0pfHCUwloF9jtBHEdjma2iuQvgbSS3SpsD/+p4FI98SKcA5rmwjPBJo
 0Nak=
X-Google-Smtp-Source: AGHT+IEZwDrLc1SF8bVFN+eprdg7ovtRtORv8leA/EDXLFNnZJerFMYFuA7Ty+jOzroKDnv65XaPhQ==
X-Received: by 2002:a17:906:3d4:b0:a44:8c1b:8877 with SMTP id
 c20-20020a17090603d400b00a448c1b8877mr6708897eja.50.1709557292827; 
 Mon, 04 Mar 2024 05:01:32 -0800 (PST)
Received: from debian.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 tj7-20020a170907c24700b00a413d1eda4bsm4806136ejc.87.2024.03.04.05.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 05:01:32 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@amd.com>
Subject: [PATCH v7 07/12] tests/plugin/insn: migrate to new per_vcpu API
Date: Mon,  4 Mar 2024 17:00:31 +0400
Message-Id: <20240304130036.124418-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240304130036.124418-1-pierrick.bouvier@linaro.org>
References: <20240304130036.124418-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-ej1-x633.google.com
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

Reviewed-by: Luc Michel <luc.michel@amd.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/plugin/insn.c | 106 +++++++++++++++++++++-----------------------
 1 file changed, 50 insertions(+), 56 deletions(-)

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


