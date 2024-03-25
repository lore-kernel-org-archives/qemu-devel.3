Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F60C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 12:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rojfH-0000jW-Pz; Mon, 25 Mar 2024 08:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rojf0-0000CY-9C
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:42:46 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rojek-0006gH-JA
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:42:38 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d48d75ab70so63121981fa.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 05:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711370544; x=1711975344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OmhIE37fkqsu8g+bGomSlM2HBiD6ETLgpCZvKdmkoMg=;
 b=MR50Skch5PJhXHvmvl6pqgVlVZzwbKkvf5J6HruIzAPUy+iq6hO6RSykbFENHflh4W
 F7ABlGWmGCAHKAQXRQ/FmTFTKnqVs3sEDQC2Fu/xWs1FzMIU/oMZNs1S7hhdFN1sHcuu
 /jqzTk3Fbzh4vz7uSh74V4aSzey/soKOM9X2PIRZ2sFB70E4HW/1LrzMvQ28Bw7GzUDa
 5kRunxPGmnA3b1gLSj2rq3463ENHNIZ2yJywUm2X0HiLymTzol8iLM5BWJQmLdZU2QQ1
 ouDymCZHPomjZurEADOnAcetEkZ8rDTceQ8xSG1v0jpzQ+CkO5xFd72/mn7GSCFqnrN7
 HSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711370544; x=1711975344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OmhIE37fkqsu8g+bGomSlM2HBiD6ETLgpCZvKdmkoMg=;
 b=uvFG4Zvq4ztdoKao9Qwxs28yL5rHAY4y2z0CjaKSDIVtymFiqfLIshS2hXVG4jVRqM
 c7naHblX/7zl8mF7R8n6JW9xxxAXKnVWBBfGNMBYtxxIhOaQtAsM7pYIqh6q0GWVGeTP
 g32KGxnqT9mFDjCPbg5wFAEbD3jqdWAPugIVTlpnkZ4EFktcvndTQ6xRkMPt/RxJ21G1
 M1W9HtyfNVikWRpZkX3cKBloy9982MXhxxws3W6zi+E88d+1msFSzH3Tj6vmasmaOeC4
 PsSHhfrFcERLdLMGiAO1TDoIaNvrtLaSW/U/L2vhghILP64VO5UdQTwNszDzh/kyMqAI
 FYsQ==
X-Gm-Message-State: AOJu0YyWu/xhBk9bNgdBH4C2PyKlWj8jTLO4OjS67drGYZzDs9DprBzF
 L0eDqMIcp706nJcfySHEZaIEmbVo7dzTR9a/cmbNeMCdSUlondbZPUN9wfokfkrjoxwAhkWHUSO
 a
X-Google-Smtp-Source: AGHT+IFFej0aIbzFv/Mx5Fr2JJv+Ou4VeJwk8M+kbFeEwSiTEDdSSizLM25YVYUPPc2ea871NOfkFA==
X-Received: by 2002:a05:6512:2188:b0:513:a7ce:525d with SMTP id
 b8-20020a056512218800b00513a7ce525dmr3652703lft.40.1711370543925; 
 Mon, 25 Mar 2024 05:42:23 -0700 (PDT)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 t20-20020ac243b4000000b00515b1b3a2bdsm35231lfl.194.2024.03.25.05.42.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 05:42:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v3 6/8] tests/plugin/inline: add test for conditional callback
Date: Mon, 25 Mar 2024 16:41:49 +0400
Message-Id: <20240325124151.336003-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325124151.336003-1-pierrick.bouvier@linaro.org>
References: <20240325124151.336003-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Count number of tb and insn executed using a conditional callback. We
ensure the callback has been called expected number of time (per vcpu).

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/plugin/inline.c | 89 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 86 insertions(+), 3 deletions(-)

diff --git a/tests/plugin/inline.c b/tests/plugin/inline.c
index 103c3a22f6e..cd63827b7d8 100644
--- a/tests/plugin/inline.c
+++ b/tests/plugin/inline.c
@@ -20,8 +20,14 @@ typedef struct {
     uint64_t count_insn_inline;
     uint64_t count_mem;
     uint64_t count_mem_inline;
+    uint64_t tb_cond_num_trigger;
+    uint64_t tb_cond_track_count;
+    uint64_t insn_cond_num_trigger;
+    uint64_t insn_cond_track_count;
 } CPUCount;
 
+static const uint64_t cond_trigger_limit = 100;
+
 typedef struct {
     uint64_t data_insn;
     uint64_t data_tb;
@@ -35,6 +41,10 @@ static qemu_plugin_u64 count_insn;
 static qemu_plugin_u64 count_insn_inline;
 static qemu_plugin_u64 count_mem;
 static qemu_plugin_u64 count_mem_inline;
+static qemu_plugin_u64 tb_cond_num_trigger;
+static qemu_plugin_u64 tb_cond_track_count;
+static qemu_plugin_u64 insn_cond_num_trigger;
+static qemu_plugin_u64 insn_cond_track_count;
 static struct qemu_plugin_scoreboard *data;
 static qemu_plugin_u64 data_insn;
 static qemu_plugin_u64 data_tb;
@@ -56,12 +66,19 @@ static void stats_insn(void)
     const uint64_t per_vcpu = qemu_plugin_u64_sum(count_insn);
     const uint64_t inl_per_vcpu =
         qemu_plugin_u64_sum(count_insn_inline);
+    const uint64_t cond_num_trigger =
+        qemu_plugin_u64_sum(insn_cond_num_trigger);
+    const uint64_t cond_track_left = qemu_plugin_u64_sum(insn_cond_track_count);
+    const uint64_t conditional =
+        cond_num_trigger * cond_trigger_limit + cond_track_left;
     printf("insn: %" PRIu64 "\n", expected);
     printf("insn: %" PRIu64 " (per vcpu)\n", per_vcpu);
     printf("insn: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
+    printf("insn: %" PRIu64 " (cond cb)\n", conditional);
     g_assert(expected > 0);
     g_assert(per_vcpu == expected);
     g_assert(inl_per_vcpu == expected);
+    g_assert(conditional == expected);
 }
 
 static void stats_tb(void)
@@ -70,12 +87,18 @@ static void stats_tb(void)
     const uint64_t per_vcpu = qemu_plugin_u64_sum(count_tb);
     const uint64_t inl_per_vcpu =
         qemu_plugin_u64_sum(count_tb_inline);
+    const uint64_t cond_num_trigger = qemu_plugin_u64_sum(tb_cond_num_trigger);
+    const uint64_t cond_track_left = qemu_plugin_u64_sum(tb_cond_track_count);
+    const uint64_t conditional =
+        cond_num_trigger * cond_trigger_limit + cond_track_left;
     printf("tb: %" PRIu64 "\n", expected);
     printf("tb: %" PRIu64 " (per vcpu)\n", per_vcpu);
     printf("tb: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
+    printf("tb: %" PRIu64 " (conditional cb)\n", conditional);
     g_assert(expected > 0);
     g_assert(per_vcpu == expected);
     g_assert(inl_per_vcpu == expected);
+    g_assert(conditional == expected);
 }
 
 static void stats_mem(void)
@@ -104,14 +127,35 @@ static void plugin_exit(qemu_plugin_id_t id, void *udata)
         const uint64_t insn_inline = qemu_plugin_u64_get(count_insn_inline, i);
         const uint64_t mem = qemu_plugin_u64_get(count_mem, i);
         const uint64_t mem_inline = qemu_plugin_u64_get(count_mem_inline, i);
-        printf("cpu %d: tb (%" PRIu64 ", %" PRIu64 ") | "
-               "insn (%" PRIu64 ", %" PRIu64 ") | "
+        const uint64_t tb_cond_trigger =
+            qemu_plugin_u64_get(tb_cond_num_trigger, i);
+        const uint64_t tb_cond_left =
+            qemu_plugin_u64_get(tb_cond_track_count, i);
+        const uint64_t insn_cond_trigger =
+            qemu_plugin_u64_get(insn_cond_num_trigger, i);
+        const uint64_t insn_cond_left =
+            qemu_plugin_u64_get(insn_cond_track_count, i);
+        printf("cpu %d: tb (%" PRIu64 ", %" PRIu64
+               ", %" PRIu64 " * %" PRIu64 " + %" PRIu64
+               ") | "
+               "insn (%" PRIu64 ", %" PRIu64
+               ", %" PRIu64 " * %" PRIu64 " + %" PRIu64
+               ") | "
                "mem (%" PRIu64 ", %" PRIu64 ")"
                "\n",
-               i, tb, tb_inline, insn, insn_inline, mem, mem_inline);
+               i,
+               tb, tb_inline,
+               tb_cond_trigger, cond_trigger_limit, tb_cond_left,
+               insn, insn_inline,
+               insn_cond_trigger, cond_trigger_limit, insn_cond_left,
+               mem, mem_inline);
         g_assert(tb == tb_inline);
         g_assert(insn == insn_inline);
         g_assert(mem == mem_inline);
+        g_assert(tb_cond_trigger == tb / cond_trigger_limit);
+        g_assert(tb_cond_left == tb % cond_trigger_limit);
+        g_assert(insn_cond_trigger == insn / cond_trigger_limit);
+        g_assert(insn_cond_left == insn % cond_trigger_limit);
     }
 
     stats_tb();
@@ -132,6 +176,24 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
     g_mutex_unlock(&tb_lock);
 }
 
+static void vcpu_tb_cond_exec(unsigned int cpu_index, void *udata)
+{
+    g_assert(qemu_plugin_u64_get(tb_cond_track_count, cpu_index) ==
+             cond_trigger_limit);
+    g_assert(qemu_plugin_u64_get(data_tb, cpu_index) == (uintptr_t) udata);
+    qemu_plugin_u64_set(tb_cond_track_count, cpu_index, 0);
+    qemu_plugin_u64_add(tb_cond_num_trigger, cpu_index, 1);
+}
+
+static void vcpu_insn_cond_exec(unsigned int cpu_index, void *udata)
+{
+    g_assert(qemu_plugin_u64_get(insn_cond_track_count, cpu_index) ==
+             cond_trigger_limit);
+    g_assert(qemu_plugin_u64_get(data_insn, cpu_index) == (uintptr_t) udata);
+    qemu_plugin_u64_set(insn_cond_track_count, cpu_index, 0);
+    qemu_plugin_u64_add(insn_cond_num_trigger, cpu_index, 1);
+}
+
 static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
 {
     qemu_plugin_u64_add(count_insn, cpu_index, 1);
@@ -163,6 +225,12 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
         tb, QEMU_PLUGIN_INLINE_ADD_U64, count_tb_inline, 1);
 
+    qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+        tb, QEMU_PLUGIN_INLINE_ADD_U64, tb_cond_track_count, 1);
+    qemu_plugin_register_vcpu_tb_exec_cond_cb(
+        tb, vcpu_tb_cond_exec, QEMU_PLUGIN_CB_NO_REGS,
+        QEMU_PLUGIN_COND_EQ, tb_cond_track_count, cond_trigger_limit, tb_store);
+
     for (int idx = 0; idx < qemu_plugin_tb_n_insns(tb); ++idx) {
         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, idx);
         void *insn_store = insn;
@@ -176,6 +244,13 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
         qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
             insn, QEMU_PLUGIN_INLINE_ADD_U64, count_insn_inline, 1);
 
+        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+            insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_cond_track_count, 1);
+        qemu_plugin_register_vcpu_insn_exec_cond_cb(
+            insn, vcpu_insn_cond_exec, QEMU_PLUGIN_CB_NO_REGS,
+            QEMU_PLUGIN_COND_EQ, insn_cond_track_count, cond_trigger_limit,
+            insn_store);
+
         qemu_plugin_register_vcpu_mem_inline_per_vcpu(
             insn, QEMU_PLUGIN_MEM_RW,
             QEMU_PLUGIN_INLINE_STORE_U64,
@@ -207,6 +282,14 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
         counts, CPUCount, count_insn_inline);
     count_mem_inline = qemu_plugin_scoreboard_u64_in_struct(
         counts, CPUCount, count_mem_inline);
+    tb_cond_num_trigger = qemu_plugin_scoreboard_u64_in_struct(
+        counts, CPUCount, tb_cond_num_trigger);
+    tb_cond_track_count = qemu_plugin_scoreboard_u64_in_struct(
+        counts, CPUCount, tb_cond_track_count);
+    insn_cond_num_trigger = qemu_plugin_scoreboard_u64_in_struct(
+        counts, CPUCount, insn_cond_num_trigger);
+    insn_cond_track_count = qemu_plugin_scoreboard_u64_in_struct(
+        counts, CPUCount, insn_cond_track_count);
     data = qemu_plugin_scoreboard_new(sizeof(CPUData));
     data_insn = qemu_plugin_scoreboard_u64_in_struct(data, CPUData, data_insn);
     data_tb = qemu_plugin_scoreboard_u64_in_struct(data, CPUData, data_tb);
-- 
2.39.2


