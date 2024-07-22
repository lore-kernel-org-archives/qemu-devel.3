Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73775C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 11:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVqqE-000651-Ns; Mon, 22 Jul 2024 07:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqq8-0005gu-P7
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:04:24 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqq6-0002SE-SY
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:04:24 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a6fd513f18bso365876666b.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 04:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721646261; x=1722251061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ve/EVDm+/avLGnI6H90trY1ZG2F2hzrIYhnNFlab21k=;
 b=Bxk5oYchM6CL4kJsCkOfPOQJJmsH6lxbVkjj1WjOEc2OhPXvTob102FMTGFsPsHyBa
 D6nhJJoBnOwp7vcsLvxmW+j3fGxMEv+T0FxfXxQuJBr56xZeKxKQhw9bTXE9doTlI4Bd
 eFJX+bwsGGcsRQ6aE5lVQbQuF0ZVlnK36GU5IAL9trBLYvITX83iFJO9/fdJ3FBvn8Ja
 4UvzeNQWpcz+JMoVrwDc14RhAHHaI3xbtkwhpFyn4hxp8E24o8dlY0S2ODjqSvDRbbC4
 F3pnQnvT0d7mif93YDdgHtJTkRfMBv9NjDRnI/jWQ8UmpdGf9MHW0FFt2QPciY5Tmy/V
 NvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721646261; x=1722251061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ve/EVDm+/avLGnI6H90trY1ZG2F2hzrIYhnNFlab21k=;
 b=nSw2mXDJAIwu2Ri0Rnvw//J2oUwocu8nwYP6JyOBVXlo0up9HCsbZV4FMIRZPQE+7P
 uDhbu/RAq5ZYppoi4qR2ONrcSoP4CXw2fkRUKQ4NdtT1xKR6wcGWsxv7Wp4sps28rF6A
 PsMsaqFEwVKzZKaRI4dIrK4yBefgluZB6V9uolOYIasRjvhHH7CT8tFOPx8XJxfA883r
 3rUNNIsh1KKlFcnMLpY0a4ACX9mSRXdyF1E3fD6oza/6ytDb2ymzO1F8IyFNnrAs0Apz
 NcOo9FTQfoUEzTty2ygaTQh7c78yBfPnzc43k3UYIbQMsNnQO5LgqgfiG7+3k0ya7av8
 7+ow==
X-Gm-Message-State: AOJu0Yydh3V+c/1Jys7tuzbojyYJvlbE0sv+ntilGdmMa0WEzwkTFakz
 zr1xz+m5UzXQlzF8GUe26QfBgGJQeEU2oe4ceUnq7W5LjESbUnZ7py/gSvUIIlg=
X-Google-Smtp-Source: AGHT+IFOH84mo6vREhizawiaA15bn1CResCUUrqh9lUapF9J2O9MqN1OWLWQYSG6sjCePqeg31FP1g==
X-Received: by 2002:a17:906:aa55:b0:a77:e1fb:7df6 with SMTP id
 a640c23a62f3a-a7a011177a7mr901431066b.7.1721646260996; 
 Mon, 22 Jul 2024 04:04:20 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c785c6csm407394666b.20.2024.07.22.04.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 04:04:18 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2BC305F9FB;
 Mon, 22 Jul 2024 12:04:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 06/16] tests/plugins: use qemu_plugin_outs for inline stats
Date: Mon, 22 Jul 2024 12:04:03 +0100
Message-Id: <20240722110413.118418-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722110413.118418-1-alex.bennee@linaro.org>
References: <20240722110413.118418-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

Using bare printf's in plugins is perfectly acceptable but they do
rather mess up the output of "make check-tcg". Convert the printfs to
use g_string and then output with the plugin output helper which will
already be captured to .pout files by the test harness.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240718094523.1198645-7-alex.bennee@linaro.org>

diff --git a/tests/plugin/inline.c b/tests/plugin/inline.c
index cd63827b7d..73dde99578 100644
--- a/tests/plugin/inline.c
+++ b/tests/plugin/inline.c
@@ -71,10 +71,12 @@ static void stats_insn(void)
     const uint64_t cond_track_left = qemu_plugin_u64_sum(insn_cond_track_count);
     const uint64_t conditional =
         cond_num_trigger * cond_trigger_limit + cond_track_left;
-    printf("insn: %" PRIu64 "\n", expected);
-    printf("insn: %" PRIu64 " (per vcpu)\n", per_vcpu);
-    printf("insn: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
-    printf("insn: %" PRIu64 " (cond cb)\n", conditional);
+    g_autoptr(GString) stats = g_string_new("");
+    g_string_append_printf(stats, "insn: %" PRIu64 "\n", expected);
+    g_string_append_printf(stats, "insn: %" PRIu64 " (per vcpu)\n", per_vcpu);
+    g_string_append_printf(stats, "insn: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
+    g_string_append_printf(stats, "insn: %" PRIu64 " (cond cb)\n", conditional);
+    qemu_plugin_outs(stats->str);
     g_assert(expected > 0);
     g_assert(per_vcpu == expected);
     g_assert(inl_per_vcpu == expected);
@@ -91,10 +93,12 @@ static void stats_tb(void)
     const uint64_t cond_track_left = qemu_plugin_u64_sum(tb_cond_track_count);
     const uint64_t conditional =
         cond_num_trigger * cond_trigger_limit + cond_track_left;
-    printf("tb: %" PRIu64 "\n", expected);
-    printf("tb: %" PRIu64 " (per vcpu)\n", per_vcpu);
-    printf("tb: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
-    printf("tb: %" PRIu64 " (conditional cb)\n", conditional);
+    g_autoptr(GString) stats = g_string_new("");
+    g_string_append_printf(stats, "tb: %" PRIu64 "\n", expected);
+    g_string_append_printf(stats, "tb: %" PRIu64 " (per vcpu)\n", per_vcpu);
+    g_string_append_printf(stats, "tb: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
+    g_string_append_printf(stats, "tb: %" PRIu64 " (conditional cb)\n", conditional);
+    qemu_plugin_outs(stats->str);
     g_assert(expected > 0);
     g_assert(per_vcpu == expected);
     g_assert(inl_per_vcpu == expected);
@@ -107,9 +111,11 @@ static void stats_mem(void)
     const uint64_t per_vcpu = qemu_plugin_u64_sum(count_mem);
     const uint64_t inl_per_vcpu =
         qemu_plugin_u64_sum(count_mem_inline);
-    printf("mem: %" PRIu64 "\n", expected);
-    printf("mem: %" PRIu64 " (per vcpu)\n", per_vcpu);
-    printf("mem: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
+    g_autoptr(GString) stats = g_string_new("");
+    g_string_append_printf(stats, "mem: %" PRIu64 "\n", expected);
+    g_string_append_printf(stats, "mem: %" PRIu64 " (per vcpu)\n", per_vcpu);
+    g_string_append_printf(stats, "mem: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
+    qemu_plugin_outs(stats->str);
     g_assert(expected > 0);
     g_assert(per_vcpu == expected);
     g_assert(inl_per_vcpu == expected);
@@ -118,6 +124,7 @@ static void stats_mem(void)
 static void plugin_exit(qemu_plugin_id_t id, void *udata)
 {
     const unsigned int num_cpus = qemu_plugin_num_vcpus();
+    g_autoptr(GString) stats = g_string_new("");
     g_assert(num_cpus == max_cpu_index + 1);
 
     for (int i = 0; i < num_cpus ; ++i) {
@@ -135,20 +142,21 @@ static void plugin_exit(qemu_plugin_id_t id, void *udata)
             qemu_plugin_u64_get(insn_cond_num_trigger, i);
         const uint64_t insn_cond_left =
             qemu_plugin_u64_get(insn_cond_track_count, i);
-        printf("cpu %d: tb (%" PRIu64 ", %" PRIu64
-               ", %" PRIu64 " * %" PRIu64 " + %" PRIu64
-               ") | "
-               "insn (%" PRIu64 ", %" PRIu64
-               ", %" PRIu64 " * %" PRIu64 " + %" PRIu64
-               ") | "
-               "mem (%" PRIu64 ", %" PRIu64 ")"
-               "\n",
-               i,
-               tb, tb_inline,
-               tb_cond_trigger, cond_trigger_limit, tb_cond_left,
-               insn, insn_inline,
-               insn_cond_trigger, cond_trigger_limit, insn_cond_left,
-               mem, mem_inline);
+        g_string_printf(stats, "cpu %d: tb (%" PRIu64 ", %" PRIu64
+                        ", %" PRIu64 " * %" PRIu64 " + %" PRIu64
+                        ") | "
+                        "insn (%" PRIu64 ", %" PRIu64
+                        ", %" PRIu64 " * %" PRIu64 " + %" PRIu64
+                        ") | "
+                        "mem (%" PRIu64 ", %" PRIu64 ")"
+                        "\n",
+                        i,
+                        tb, tb_inline,
+                        tb_cond_trigger, cond_trigger_limit, tb_cond_left,
+                        insn, insn_inline,
+                        insn_cond_trigger, cond_trigger_limit, insn_cond_left,
+                        mem, mem_inline);
+        qemu_plugin_outs(stats->str);
         g_assert(tb == tb_inline);
         g_assert(insn == insn_inline);
         g_assert(mem == mem_inline);
-- 
2.39.2


