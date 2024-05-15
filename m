Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB2CC25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 20:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7LAG-0001BV-TW; Wed, 15 May 2024 16:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s7LA9-00013Y-HM
 for qemu-devel@nongnu.org; Wed, 15 May 2024 16:23:45 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s7LA6-0004FS-7p
 for qemu-devel@nongnu.org; Wed, 15 May 2024 16:23:45 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2e6f51f9de4so21568021fa.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 13:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715804620; x=1716409420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YudKlo7jq7Un7Vr1ZL9ijoYNgkD026frugjCbIOjExU=;
 b=LB25ILSbDgM8kBo6ROF6LQ04ufHDBOjTBHv/OVPjo1MVwX30Gnl03PoPGJk4gGCBcC
 r/f3rbhUz1xZga+jMSJU8LuWvRgI16PhBtXwnwkmETCtqy99HrKeAFm2NIYFi+TSNbYq
 jjt4DggS0ntO3pZCwxTDlSSj1Smiszyr9Sqe5kU9lafRp5A1ZLYFVoUJRoE87CRaMpXU
 OYmpK52SQQWgBzDAnQAFAj5w4yBHWMLIbZsRZkyLEV014rLsbPvjFJhZ8ABPsBsDsorJ
 50yk63aV45M+iEdg/p0hSee4nkquwFCef7cDxS8nyQ3OG8+iDvvpTf4Dz0z0w9ZwwmeR
 kRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715804620; x=1716409420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YudKlo7jq7Un7Vr1ZL9ijoYNgkD026frugjCbIOjExU=;
 b=QFEmB8UGVpqT18j492LzggbOUfTr40frGGamLzoV/w0W+y8JDI4hrtIA+c6P0iPacp
 7sVdypqbh8YD+cgs3HuGkcIYjdmR1EmnedMw0KAwNw4jcOf99rGRgh1CoOTyyhQOJAYs
 YnggVOWoll14t6qpgy/LGXn9p0jpFvUBipq3+PnhffTwQaQczFaJczcHc+JKpQNn/Grv
 gCqDN8NSUMsF4B7IZDE4poriywMzWmV6tqbG3AKTnYwH4W09u1rQPpoHZVC5VKryRaQT
 3tD8OD9OLxodqrtEOCDHXhARYq5VoK8xewiHqQmw61rWkiyWoge9pYbAcX93U4gedEYd
 3XoQ==
X-Gm-Message-State: AOJu0YypFnuN3EqDG0MwnhRJqFfmxU02JNDfhomVmfkOSz3kPejPrib+
 O0A6fLIZYa8RjGPJp7Y3MMPS3mxbDXaS3RWZMkcxnlJw65fWpGR75MtpEXYYAXs=
X-Google-Smtp-Source: AGHT+IHOUxoiEY3XQB0LUPv5guDGl/VHih8GQxjnd6fS3BwH4apB5+dTTxHmYAVydiiCCnW6cGX53A==
X-Received: by 2002:a2e:b0db:0:b0:2e5:566:c752 with SMTP id
 38308e7fff4ca-2e52039dc2fmr137504111fa.48.1715804620479; 
 Wed, 15 May 2024 13:23:40 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179c822fsm898246566b.138.2024.05.15.13.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 13:23:37 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6F22E5FA2A;
 Wed, 15 May 2024 21:23:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 08/11] tests/plugin/inline: add test for conditional callback
Date: Wed, 15 May 2024 21:23:31 +0100
Message-Id: <20240515202334.710324-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240515202334.710324-1-alex.bennee@linaro.org>
References: <20240515202334.710324-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22e.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Count number of tb and insn executed using a conditional callback. We
ensure the callback has been called expected number of time (per vcpu).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240502211522.346467-7-pierrick.bouvier@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240514174253.694591-9-alex.bennee@linaro.org>

diff --git a/tests/plugin/inline.c b/tests/plugin/inline.c
index 103c3a22f6..cd63827b7d 100644
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


