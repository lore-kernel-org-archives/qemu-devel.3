Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA59CCA471
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 10:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5i0y-00025h-1u; Mon, 06 Oct 2025 06:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v5i0R-0001Wk-0i
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 05:59:48 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v5i0O-00041A-Md
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 05:59:46 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 9237B60B93
 for <qemu-devel@nongnu.org>; Mon,  6 Oct 2025 11:59:42 +0200 (CEST)
Received: (qmail 21008 invoked by uid 990); 6 Oct 2025 09:59:42 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 06 Oct 2025 11:59:42 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v7 23/25] tests: add plugin asserting correctness of discon
 event's to_pc
Date: Mon,  6 Oct 2025 11:59:18 +0200
Message-ID: <44a29c55c2ed358a216e542fc90724ca0f8e5c40.1759744337.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1759744337.git.neither@nut.email>
References: <cover.1759744337.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ----
X-Rspamd-Report: REPLY(-4) SUSPICIOUS_RECIPS(1.5) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) BAYES_HAM(-2.99992) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -4.09992
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=M66cb9o00ka1yDebj+//xx3Us6bJo1VzJeW7Zn7c/As=;
 b=eaBYqXlNvDotqG7YoQbMvsubKn0ZQmoMAv5ztZ5tiWDW0CMO+0wHL7vEIOE7JVT4FQJuh8C75V
 DwcD4bH6zc+fA+bzDSDWdHQNpvCbIJ/DRULkfvxGpesHdJNB2g09yK2xr+aOcNWhGkLfTrMpno9c
 EWBQBPqOsxRzD+PFa2c+Vowi8hdj8gzj4QB299uzahY2Tfs3YjXkAvTfOOP0TCPLmguwMlfPCIl8
 yO4HFD9iU31NgVwl9MeB31Yh++Jr7vHDZMf3gmCO/X440vc4Ngl3CyVGgJ7+kHUtz+Y+kGorQ2vQ
 l8W8e2PELInBlKJ7a69iqpm5+f71wdMhPIhiy5rvzS/5P/S3iKAEmtBzzsK8+AQXvorGFuHR4GfA
 OSE6IjlTsMQqtcy89thqVL7GjPwRQtHkz9cM+EuEIrHiFrgR84/iBySTRa2JW56L0I6VpnSja4Ng
 F2SgOMadPNSffgPHnEzhtiUSgSKIvEc2BK6rdD4wbrp9rcHTa52GXV2CsDvh0QxJchllZScf0f8D
 E5TwyM1A0r0UFebWTDJxmnBN4vE9azOV7EjmEmCeUBKlL8N2F5Ic2mYBI9ECyFD1VFDPsEmYMqi5
 98e/dDyh3FivGIdYSuAJkiDOhfFgmUYn8Ub/GT3Z2mO1ze9Ta+6fR3ucPRebb3fKoygk03dsSZcA
 Y=
Received-SPF: pass client-ip=2001:1a50:11:0:c83f:a8ff:fea6:c8da;
 envelope-from=neither@nut.email; helo=mailgate01.uberspace.is
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
behaviour in cases where this is possible with reasonable effort.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
---
 tests/tcg/plugins/discons.c   | 221 ++++++++++++++++++++++++++++++++++
 tests/tcg/plugins/meson.build |   2 +-
 2 files changed, 222 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/plugins/discons.c

diff --git a/tests/tcg/plugins/discons.c b/tests/tcg/plugins/discons.c
new file mode 100644
index 0000000000..2e0e664e82
--- /dev/null
+++ b/tests/tcg/plugins/discons.c
@@ -0,0 +1,221 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2025, Julian Ganz <neither@nut.email>
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
+
+static bool addr_eq(uint64_t a, uint64_t b)
+{
+    if (a == b) {
+        return true;
+    }
+
+    uint64_t a_hw;
+    uint64_t b_hw;
+    if (!qemu_plugin_translate_vaddr(a, &a_hw) ||
+        !qemu_plugin_translate_vaddr(b, &b_hw))
+    {
+        return false;
+    }
+
+    return a_hw == b_hw;
+}
+
+static void report_mismatch(const char *pc_name, unsigned int vcpu_index,
+                            enum qemu_plugin_discon_type type, uint64_t last,
+                            uint64_t expected, uint64_t encountered)
+{
+    gchar *report;
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
+    report = g_strdup_printf("Discon %s PC mismatch on VCPU %d\n"
+                             "Expected:      %"PRIx64"\nEncountered:   %"
+                             PRIx64"\nExecuted Last: %"PRIx64
+                             "\nEvent type:    %s\n",
+                             pc_name, vcpu_index, expected, encountered, last,
+                             discon_type_name);
+    if (abort_on_mismatch) {
+        /*
+         * The qemu log infrastructure may lose messages when aborting. Using
+         * fputs directly ensures the final report is visible to developers.
+         */
+        fputs(report, stderr);
+        g_abort();
+    } else {
+        qemu_plugin_outs(report);
+    }
+    g_free(report);
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
+    if (!info->system_emulation) {
+        qemu_plugin_outs("Testing of the disontinuity plugin API is only"
+                         " possible in system emulation mode.");
+        return 0;
+    }
+
+    /* Set defaults */
+    abort_on_mismatch = true;
+    trace_all_insns = false;
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
index 61a007d9e7..561584159e 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -1,6 +1,6 @@
 t = []
 if get_option('plugins')
-  foreach i : ['bb', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall', 'patch']
+  foreach i : ['bb', 'discons', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall', 'patch']
     if host_os == 'windows'
       t += shared_module(i, files(i + '.c') + '../../../contrib/plugins/win32_linker.c',
                         include_directories: '../../../include/qemu',
-- 
2.49.1


