Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711A4C3ABCB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 13:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE6WV-0007I4-2v; Sun, 11 May 2025 09:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uE6WT-00078H-Am
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:15:17 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uE6WP-0006sF-RS
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:15:17 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id E1729180076
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 15:14:52 +0200 (CEST)
Received: (qmail 26222 invoked by uid 990); 11 May 2025 13:14:52 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 11 May 2025 15:14:52 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 21/23] tests: add plugin asserting correctness of discon
 event's to_pc
Date: Sun, 11 May 2025 15:14:13 +0200
Message-ID: <e212e53b98c264366458654493e2fa2e2cdecdcc.1746968215.git.neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746968215.git.neither@nut.email>
References: <cover.1746968215.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ----
X-Rspamd-Report: REPLY(-4) SUSPICIOUS_RECIPS(1.5) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) BAYES_HAM(-3) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -4.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=TDT0V7CtuWjwKP9/qcbxUMFvzfBRMDmCmSbWL0Z6dCI=;
 b=J8aTdmeg3BRQT6dRXKMToove4U+En5wLD8HykpsFSbAZH8bUmL8DHD8klJnXtkK/GR27iOQk7g
 4wpcM7La/dSd9O1jRUu6hp6QngaNQTcWuW/d3GQSBPtglC2j1JWM9UiC2q//53PqfyKaA+h5e3v4
 2T2hh/Pt8ah+5WYpfGqt/bXNcivTEpDRV6io/2Xwc3qCCPHOmpCACpoIhM/bzq0OXXRLUotSu9cT
 Ny8gYNupai14wiJIVY6tIcJhfsiH+Ka1NinGXJl2OlT+yPkezbNrwjPU4yUZmJiYl6uROGVSQvwc
 yY8tRDL11KJ+FpALLvoFI5LuHNtGjZgVEGFKlbJk1Vjz+jPzWQ0mXXAAuZCJZ0F0u/lQpEVHgnKo
 SH6PCygH06xpWQuB/Ar9gy7iufDGMlQYrabtOPxqK7LpGYXCuZKJjhrZmpCgfV2Rswpy8S+ehjKU
 7KXnf9LTvix37mCp02CuZ8249ojk3b8sTUXUsMonSzwEn7kqpPO8FkqUQQexpXRvR+44ledL4G7Q
 BPCkhZrRADb6zG0XhXtfS5h4rQW5bajQ4lcBZ3CxcwVxp4NRsNzRyxSywbPquV0DIMnb4pRHsWhb
 a8Os9rp5VPKLBjBwz2rs8euLuRKzBBhUHzGDPmG+Jz/qckiDhPAV0azdd/5oGY3sHKRy5Oz93ax3
 g=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We recently introduced plugin API for the registration of callbacks for
discontinuity events, specifically for interrupts, exceptions and host
call events. The callback receives various bits of information,
including the VCPU index and PCs.

This change introduces a test plugin asserting the correctness of that
behaviour in cases where this is possible with reasonable effort. Since
instruction PCs are recorded at translation blocks translation time and
a TB may be used in multiple processes running in distinct virtual
memory, the plugin allows comparing not full addresses but a subset of
address bits via the `compare-addr-bits` option.

Signed-off-by: Julian Ganz <neither@nut.email>
---
 tests/tcg/plugins/discons.c   | 219 ++++++++++++++++++++++++++++++++++
 tests/tcg/plugins/meson.build |   2 +-
 2 files changed, 220 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/plugins/discons.c

diff --git a/tests/tcg/plugins/discons.c b/tests/tcg/plugins/discons.c
new file mode 100644
index 0000000000..3f6c9a96d4
--- /dev/null
+++ b/tests/tcg/plugins/discons.c
@@ -0,0 +1,219 @@
+/*
+ * Copyright (C) 2025, Julian Ganz <neither@nut.email>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ *
+ * This plugin exercises the discontinuity plugin API and asserts some
+ * of its behaviour regarding reported program counters.
+ */
+#include <stdio.h>
+
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+struct cpu_state {
+    uint64_t last_pc;
+    uint64_t from_pc;
+    uint64_t next_pc;
+    bool has_last;
+    bool has_from;
+    bool has_next;
+    enum qemu_plugin_discon_type next_type;
+};
+
+struct insn_data {
+    uint64_t addr;
+    uint64_t next_pc;
+    bool next_valid;
+};
+
+static struct qemu_plugin_scoreboard *states;
+
+static bool abort_on_mismatch;
+static bool trace_all_insns;
+static uint64_t compare_addr_mask;
+
+static bool addr_eq(uint64_t a, uint64_t b)
+{
+    return ((a ^ b) & compare_addr_mask) == 0;
+}
+
+static void report_mismatch(const char *pc_name, unsigned int vcpu_index,
+                            enum qemu_plugin_discon_type type, uint64_t last,
+                            uint64_t expected, uint64_t encountered)
+{
+    GString *report;
+    const char *discon_type_name = "unknown";
+
+    if (addr_eq(expected, encountered)) {
+        return;
+    }
+
+    switch (type) {
+    case QEMU_PLUGIN_DISCON_INTERRUPT:
+        discon_type_name = "interrupt";
+        break;
+    case QEMU_PLUGIN_DISCON_EXCEPTION:
+        discon_type_name = "exception";
+        break;
+    case QEMU_PLUGIN_DISCON_HOSTCALL:
+        discon_type_name = "hostcall";
+        break;
+    default:
+        break;
+    }
+
+    report = g_string_new(NULL);
+    g_string_append_printf(report,
+                           "Discon %s PC mismatch on VCPU %d\nExpected:      %"
+                           PRIx64"\nEncountered:   %"PRIx64"\nExecuted Last: %"
+                           PRIx64"\nEvent type:    %s\n",
+                           pc_name, vcpu_index, expected, encountered, last,
+                           discon_type_name);
+    qemu_plugin_outs(report->str);
+    if (abort_on_mismatch) {
+        g_abort();
+    }
+    g_string_free(report, true);
+}
+
+static void vcpu_discon(qemu_plugin_id_t id, unsigned int vcpu_index,
+                        enum qemu_plugin_discon_type type, uint64_t from_pc,
+                        uint64_t to_pc)
+{
+    struct cpu_state *state = qemu_plugin_scoreboard_find(states, vcpu_index);
+
+    switch (type) {
+    case QEMU_PLUGIN_DISCON_EXCEPTION:
+        /*
+         * For some types of exceptions, insn_exec will be called for the
+         * instruction that caused the exception.
+         */
+        if (addr_eq(state->last_pc, from_pc)) {
+            break;
+        }
+        __attribute__((fallthrough));
+    default:
+        if (state->has_next) {
+            /*
+             * We may encounter discontinuity chains without any instructions
+             * being executed in between.
+             */
+            report_mismatch("source", vcpu_index, type, state->last_pc,
+                            state->next_pc, from_pc);
+        } else if (state->has_from) {
+            report_mismatch("source", vcpu_index, type, state->last_pc,
+                            state->from_pc, from_pc);
+        }
+    }
+
+    state->has_from = false;
+
+    state->next_pc = to_pc;
+    state->next_type = type;
+    state->has_next = true;
+}
+
+static void insn_exec(unsigned int vcpu_index, void *userdata)
+{
+    struct cpu_state *state = qemu_plugin_scoreboard_find(states, vcpu_index);
+    struct insn_data* insn = (struct insn_data *) userdata;
+
+    state->last_pc = insn->addr;
+    state->has_last = true;
+
+    if (insn->next_valid) {
+        state->from_pc = insn->next_pc;
+    }
+    state->has_from = insn->next_valid;
+
+    if (state->has_next) {
+        report_mismatch("target", vcpu_index, state->next_type, state->last_pc,
+                        state->next_pc, insn->addr);
+        state->has_next = false;
+    }
+
+    if (trace_all_insns) {
+        g_autoptr(GString) report = g_string_new(NULL);
+        g_string_append_printf(report, "Exec insn at %"PRIx64" on VCPU %d\n",
+                               insn->addr, vcpu_index);
+        qemu_plugin_outs(report->str);
+    }
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    size_t i;
+    size_t n_insns = qemu_plugin_tb_n_insns(tb);
+    struct insn_data *udata = calloc(n_insns, sizeof(struct insn_data));
+
+    for (i = 0; i < n_insns; i++) {
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
+        uint64_t pc = qemu_plugin_insn_vaddr(insn);
+        udata[i].addr = pc;
+        udata[i].next_pc = pc + qemu_plugin_insn_size(insn);
+        udata[i].next_valid = true;
+        qemu_plugin_register_vcpu_insn_exec_cb(insn, insn_exec,
+                                               QEMU_PLUGIN_CB_NO_REGS,
+                                               &udata[i]);
+    }
+
+    udata[n_insns - 1].next_valid = false;
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+    /* Set defaults */
+    abort_on_mismatch = true;
+    trace_all_insns = false;
+    compare_addr_mask = -1;
+
+    int i;
+
+    for (i = 0; i < argc; i++) {
+        char *opt = argv[i];
+        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
+        if (g_strcmp0(tokens[0], "abort") == 0) {
+            if (!qemu_plugin_bool_parse(tokens[0], tokens[1],
+                                        &abort_on_mismatch)) {
+                fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
+                return -1;
+            }
+        } else if (g_strcmp0(tokens[0], "trace-all") == 0) {
+            if (!qemu_plugin_bool_parse(tokens[0], tokens[1],
+                                        &trace_all_insns)) {
+                fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
+                return -1;
+            }
+        } else if (g_strcmp0(tokens[0], "compare-addr-bits") == 0) {
+            if (g_strcmp0(tokens[1], "full") == 0) {
+                compare_addr_mask = -1;
+            } else {
+                char *end = tokens[1];
+                guint64 bits = g_ascii_strtoull(tokens[1], &end, 10);
+                if (bits == 0 || bits > 64 || *end) {
+                    fprintf(stderr,
+                            "integer parsing failed or out of range: %s\n",
+                            opt);
+                    return -1;
+                }
+                compare_addr_mask = ~(((uint64_t) -1) << bits);
+            }
+        } else {
+            fprintf(stderr, "option parsing failed: %s\n", opt);
+            return -1;
+        }
+    }
+
+    states = qemu_plugin_scoreboard_new(sizeof(struct cpu_state));
+
+    qemu_plugin_register_vcpu_discon_cb(id, QEMU_PLUGIN_DISCON_ALL,
+                                        vcpu_discon);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+
+    return 0;
+}
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index 41f02f2c7f..1b13d6e614 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -1,6 +1,6 @@
 t = []
 if get_option('plugins')
-  foreach i : ['bb', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall']
+  foreach i : ['bb', 'discons', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall']
     if host_os == 'windows'
       t += shared_module(i, files(i + '.c') + '../../../contrib/plugins/win32_linker.c',
                         include_directories: '../../../include/qemu',
-- 
2.49.0


