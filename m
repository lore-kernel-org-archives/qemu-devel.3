Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315A5C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 15:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH2MG-0008W8-Ps; Mon, 19 May 2025 11:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uH2Ln-0007xN-Co
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:24:26 -0400
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uH2Li-0005oU-J0
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:24:23 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 6514B180EAE
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 17:24:17 +0200 (CEST)
Received: (qmail 5944 invoked by uid 990); 19 May 2025 15:24:17 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 19 May 2025 17:24:17 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 23/25] tests: add plugin asserting correctness of discon
 event's to_pc
Date: Mon, 19 May 2025 17:24:07 +0200
Message-ID: <2a30a629012f39f8495415f87568fe9b3a0eb32b.1747666625.git.neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747666625.git.neither@nut.email>
References: <cover.1747666625.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ----
X-Rspamd-Report: REPLY(-4) SUSPICIOUS_RECIPS(1.5) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) BAYES_HAM(-3) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -4.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=4SF0Y+dqaHinO+9T1gaTFBgtUGDULaBri30lZLDat5o=;
 b=yrUSM+YHt2JynGD2aMAUSUqnpQnnqNEhP2xBL30LOzj+/hH2iYZkV1850kR2n5nHBjfOFc1sEL
 8EoURQ2P9Njxf/o3pDqyCrye/1eh5JJHzNnLWrHk7nXx0/G75TNdZt0ZUwgsIaR3BnaIF9uyqZDI
 jJFHt1ibt0PCbXrcoTaLOxek7wAKijWQMED3X8Or5U882788r4xJt2wBxmJPfSGnL1Yu7wwqqLrP
 MuKS/Pl56a151MCd9AMw21Hu9z+KXB3yL3C6AnAU4g1QoWwmI0GE0VTX6vOAw/IbOneRVIgpbPez
 ikRYbx0SDxry9D+zuRPCW2aFh1johH+w4C8lAlEp47b33iNcHACItoqWDbDsZKVR36esPXBCxbCW
 XlPlBMWmGmp/xEVuqcCQeyF8Cro9Y+2IIGA+OL7l/X2SvUAVehHXUPAgsl9n70Fb6xEyZBcL5pkf
 +PX2jCwbXK73I09px+EBC8RgxQrRm4v8SNtD+5XKAmCSKw08NYP0jrkl6oA5S+vmX7/AW5QfksMD
 MZ5FgFhdhBnq3FqmtJnLmzswVEL8Y55oRO/OiJF8BM1VEnG9UIyPmNXdFTK9rqXtyjEjG6C4VKlu
 silQANTVurzV4npxGu9KTG5oILWcQWMbMcF413kpZMu9iztjJmztrUx8qONmkLKFbi5FVF0jlweQ
 g=
Received-SPF: pass client-ip=2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4;
 envelope-from=neither@nut.email; helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Pierrick: I did implement the changes you requested, but I did not add
your Reviewed-By because I felt the changes were not trivial enough to
not require a new, coarse review.

 tests/tcg/plugins/discons.c   | 216 ++++++++++++++++++++++++++++++++++
 tests/tcg/plugins/meson.build |   2 +-
 2 files changed, 217 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/plugins/discons.c

diff --git a/tests/tcg/plugins/discons.c b/tests/tcg/plugins/discons.c
new file mode 100644
index 0000000000..afbd1b400d
--- /dev/null
+++ b/tests/tcg/plugins/discons.c
@@ -0,0 +1,216 @@
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
+    uint64_t has_from;
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
+static qemu_plugin_u64 last_pc;
+static qemu_plugin_u64 from_pc;
+static qemu_plugin_u64 has_from;
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
+    if (type == QEMU_PLUGIN_DISCON_EXCEPTION &&
+        addr_eq(state->last_pc, from_pc))
+    {
+        /*
+         * For some types of exceptions, insn_exec will be called for the
+         * instruction that caused the exception. This is valid behaviour and
+         * does not need to be reported.
+         */
+    } else if (state->has_next) {
+        /*
+         * We may encounter discontinuity chains without any instructions
+         * being executed in between.
+         */
+        report_mismatch("source", vcpu_index, type, state->last_pc,
+                        state->next_pc, from_pc);
+    } else if (state->has_from) {
+        report_mismatch("source", vcpu_index, type, state->last_pc,
+                        state->from_pc, from_pc);
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
+
+    if (state->has_next) {
+        report_mismatch("target", vcpu_index, state->next_type, state->last_pc,
+                        state->next_pc, state->last_pc);
+        state->has_next = false;
+    }
+
+    if (trace_all_insns) {
+        g_autoptr(GString) report = g_string_new(NULL);
+        g_string_append_printf(report, "Exec insn at %"PRIx64" on VCPU %d\n",
+                               state->last_pc, vcpu_index);
+        qemu_plugin_outs(report->str);
+    }
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    size_t n_insns = qemu_plugin_tb_n_insns(tb);
+    for (size_t i = 0; i < n_insns; i++) {
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
+        uint64_t pc = qemu_plugin_insn_vaddr(insn);
+        uint64_t next_pc = pc + qemu_plugin_insn_size(insn);
+        uint64_t has_next = (i + 1) < n_insns;
+
+        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(insn,
+                                                            QEMU_PLUGIN_INLINE_STORE_U64,
+                                                            last_pc, pc);
+        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(insn,
+                                                            QEMU_PLUGIN_INLINE_STORE_U64,
+                                                            from_pc, next_pc);
+        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(insn,
+                                                            QEMU_PLUGIN_INLINE_STORE_U64,
+                                                            has_from, has_next);
+        qemu_plugin_register_vcpu_insn_exec_cb(insn, insn_exec,
+                                               QEMU_PLUGIN_CB_NO_REGS, NULL);
+    }
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
+    for (int i = 0; i < argc; i++) {
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
+    last_pc = qemu_plugin_scoreboard_u64_in_struct(states, struct cpu_state,
+                                                   last_pc);
+    from_pc = qemu_plugin_scoreboard_u64_in_struct(states, struct cpu_state,
+                                                   from_pc);
+    has_from = qemu_plugin_scoreboard_u64_in_struct(states, struct cpu_state,
+                                                    has_from);
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


