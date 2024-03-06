Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07013C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 14:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsZy-0006gm-9Y; Wed, 06 Mar 2024 09:49:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsZq-0006bm-Ae
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:49:04 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsZn-0004E8-Bi
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:49:02 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-412e80e13abso22491725e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 06:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709736537; x=1710341337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gifdqyHFmpDZP+wxb+8YBxi+kUVbKDtu2FB/0Orwvkw=;
 b=FeMwaEDWFIEUAZ6E6GpHs0CuGQoSMT1OVozcJF2yqKPlV8BS3M9qe8dDwvgRcz59Up
 wVhS/2Wd9/7OaPpHRXORMMiBggZap6FjLcxzqRRCynywrXnm9SttwBc7FeHQAFcDo5JX
 oxNbZXSj6oz3czhr3ldvK9aX4mT6mklJCFdslxoe+iz8Ao+WOoR3eJ+UFbRBx/2hSIOF
 UChKfp5Myo7SgiLC41F8WZL2oT8t9ZWzF05R5aNBgTkYBqUNHNVntBanNa3YQ7XjLlGn
 Cn/r4pByne9tpI5ECkwBr8UVBQcsGciQbFyu+XynVkj05hQJs9OFe+rj808NSktUDAXb
 Z6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709736537; x=1710341337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gifdqyHFmpDZP+wxb+8YBxi+kUVbKDtu2FB/0Orwvkw=;
 b=MmL9Bxn9TZHf7Uh1CbHBJIXGb2UecvCN5ttdmj/QWSx0kNd/Wax9Acvc9JkKwQY/Sa
 4p6bcbPUfJVsUowZveaKOKyr4TITEvNMQbgVR+dTf0L4ZziAfgBVsKqTUyMj0223d3JH
 YTd7xoOeUZaPTVH391YZEN9XJmP4P7N1vBlKjQ4sW49sn+PgTPiDEImk5P5TPSg0PW56
 +q9kqxpe7FpqqzZUIPe0gF82pqzfiCnIE/ZLh0+fHTvzVZDBSaURCVG0Vs7Y0v0Q0qfm
 tY4MqiqVnuizo27AjgePrnRWe8qIKhV/VDMURVELE0MrUzRsiMXNRNA34NbcyrZQcNJs
 6lLA==
X-Gm-Message-State: AOJu0YwmbbEztSyI+46SnBMhBGa5ZgpPo6zqDZ1wQMO/jSuRJ0ofsWbL
 bh0ABjmyCsoxJKGpj5rEuvb4+tHf5OYnpPZEoJw5DgRqyKdMZ1kP5tKY1GlhLGY=
X-Google-Smtp-Source: AGHT+IFPZ2Mq6Jmn9F3p0pPkxbwTPa8cmOyFPmx0mzIeYIcBfEAQHP/E3YvZ2r8vkka0un1RkqEF6w==
X-Received: by 2002:a05:600c:1da6:b0:412:e95f:51bb with SMTP id
 p38-20020a05600c1da600b00412e95f51bbmr4520679wms.32.1709736537548; 
 Wed, 06 Mar 2024 06:48:57 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 fk15-20020a05600c0ccf00b00412ff1acf05sm715566wmb.7.2024.03.06.06.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 06:48:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 819A55F9E4;
 Wed,  6 Mar 2024 14:40:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 21/29] tests/plugin/bb: migrate to new per_vcpu API
Date: Wed,  6 Mar 2024 14:40:33 +0000
Message-Id: <20240306144041.3787188-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240306144041.3787188-1-alex.bennee@linaro.org>
References: <20240306144041.3787188-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240304130036.124418-9-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240305121005.3528075-22-alex.bennee@linaro.org>

diff --git a/tests/plugin/bb.c b/tests/plugin/bb.c
index df50d1fd3bc..36776dee1e1 100644
--- a/tests/plugin/bb.c
+++ b/tests/plugin/bb.c
@@ -17,27 +17,25 @@
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
 typedef struct {
-    GMutex lock;
-    int index;
     uint64_t bb_count;
     uint64_t insn_count;
 } CPUCount;
 
-/* Used by the inline & linux-user counts */
-static bool do_inline;
-static CPUCount inline_count;
+static struct qemu_plugin_scoreboard *counts;
+static qemu_plugin_u64 bb_count;
+static qemu_plugin_u64 insn_count;
 
+static bool do_inline;
 /* Dump running CPU total on idle? */
 static bool idle_report;
-static GPtrArray *counts;
-static int max_cpus;
 
-static void gen_one_cpu_report(CPUCount *count, GString *report)
+static void gen_one_cpu_report(CPUCount *count, GString *report,
+                               unsigned int cpu_index)
 {
     if (count->bb_count) {
         g_string_append_printf(report, "CPU%d: "
                                "bb's: %" PRIu64", insns: %" PRIu64 "\n",
-                               count->index,
+                               cpu_index,
                                count->bb_count, count->insn_count);
     }
 }
@@ -46,20 +44,23 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
     g_autoptr(GString) report = g_string_new("");
 
-    if (do_inline || !max_cpus) {
-        g_string_printf(report, "bb's: %" PRIu64", insns: %" PRIu64 "\n",
-                        inline_count.bb_count, inline_count.insn_count);
-    } else {
-        g_ptr_array_foreach(counts, (GFunc) gen_one_cpu_report, report);
+    for (int i = 0; i < qemu_plugin_num_vcpus(); ++i) {
+        CPUCount *count = qemu_plugin_scoreboard_find(counts, i);
+        gen_one_cpu_report(count, report, i);
     }
+    g_string_append_printf(report, "Total: "
+                           "bb's: %" PRIu64", insns: %" PRIu64 "\n",
+                           qemu_plugin_u64_sum(bb_count),
+                           qemu_plugin_u64_sum(insn_count));
     qemu_plugin_outs(report->str);
+    qemu_plugin_scoreboard_free(counts);
 }
 
 static void vcpu_idle(qemu_plugin_id_t id, unsigned int cpu_index)
 {
-    CPUCount *count = g_ptr_array_index(counts, cpu_index);
+    CPUCount *count = qemu_plugin_scoreboard_find(counts, cpu_index);
     g_autoptr(GString) report = g_string_new("");
-    gen_one_cpu_report(count, report);
+    gen_one_cpu_report(count, report, cpu_index);
 
     if (report->len > 0) {
         g_string_prepend(report, "Idling ");
@@ -69,14 +70,11 @@ static void vcpu_idle(qemu_plugin_id_t id, unsigned int cpu_index)
 
 static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
 {
-    CPUCount *count = max_cpus ?
-        g_ptr_array_index(counts, cpu_index) : &inline_count;
+    CPUCount *count = qemu_plugin_scoreboard_find(counts, cpu_index);
 
     uintptr_t n_insns = (uintptr_t)udata;
-    g_mutex_lock(&count->lock);
     count->insn_count += n_insns;
     count->bb_count++;
-    g_mutex_unlock(&count->lock);
 }
 
 static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
@@ -84,11 +82,10 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     size_t n_insns = qemu_plugin_tb_n_insns(tb);
 
     if (do_inline) {
-        qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
-                                                 &inline_count.bb_count, 1);
-        qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
-                                                 &inline_count.insn_count,
-                                                 n_insns);
+        qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+            tb, QEMU_PLUGIN_INLINE_ADD_U64, bb_count, 1);
+        qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+            tb, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, n_insns);
     } else {
         qemu_plugin_register_vcpu_tb_exec_cb(tb, vcpu_tb_exec,
                                              QEMU_PLUGIN_CB_NO_REGS,
@@ -121,18 +118,10 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         }
     }
 
-    if (info->system_emulation && !do_inline) {
-        max_cpus = info->system.max_vcpus;
-        counts = g_ptr_array_new();
-        for (i = 0; i < max_cpus; i++) {
-            CPUCount *count = g_new0(CPUCount, 1);
-            g_mutex_init(&count->lock);
-            count->index = i;
-            g_ptr_array_add(counts, count);
-        }
-    } else if (!do_inline) {
-        g_mutex_init(&inline_count.lock);
-    }
+    counts = qemu_plugin_scoreboard_new(sizeof(CPUCount));
+    bb_count = qemu_plugin_scoreboard_u64_in_struct(counts, CPUCount, bb_count);
+    insn_count = qemu_plugin_scoreboard_u64_in_struct(
+        counts, CPUCount, insn_count);
 
     if (idle_report) {
         qemu_plugin_register_vcpu_idle_cb(id, vcpu_idle);
-- 
2.39.2


