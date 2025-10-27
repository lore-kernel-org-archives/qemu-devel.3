Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79678CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDL2V-0001nC-OY; Mon, 27 Oct 2025 07:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL2T-0001kO-EK
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:05:25 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL1a-0005ih-KS
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:05:25 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b6d345d7ff7so848562166b.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 04:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761563043; x=1762167843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TVYLXahecZ91ldK6eSOqRfu0FtwDFgFtl25J9v2pyFo=;
 b=NX7IAhghAQ02nj5RPLQxanHZMCzbahI9oT1eAk4tYcdKwtdiEPl25EcBRohbX0Vuni
 O1GAyd73/J5ZiYsEdIcB8kD1jnlOX5F/a/4rZvTvReqQRuLOkb6YqllYe+5ltvf/gf5u
 193RQ0auSVOCxpeTf6WHApiwb3iCg1Lucr0lC9THJbdFKhpxMI7UL3ARyLZlPSuZb99y
 z0fqOWaeJWoh+9uUZ9HwYOBWaHlyrIT9nZH8wzAMGViP13MLigPZ4NRc5onO0mDGkmIl
 Nqu9ZygUre38h4nCeaMebQTr1cqON1L+sAa7pnRK8vk3Pej/50scIo1HQPvt+WVyMxZf
 VcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761563043; x=1762167843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TVYLXahecZ91ldK6eSOqRfu0FtwDFgFtl25J9v2pyFo=;
 b=Pgcad0jn4var/eloV1I/evYes73ev+CceUPrc8zjCqh6ul3G8pYCo11/Rg6bLeEYho
 jR37t+d1qg8vlecGnkc8Dw3etKj8GC20xh/p4AdofYv2Cq7F9HwCDvcf+pBsq5Vz41k5
 HmAB7ixVjFmX4peoS7CA7Jx06ZOrlwv+C+prFEvBv2XZ21lUSmNGLolwiOt5SlDTSX0o
 7rum6vDiAlKvf8CpaYTyDk3d+4tJtcOJMS5aybE6DnXJjeUqEZ2gITcj/Q9kM9waBGZ1
 OFSTBXBPvG+SjA6ogc984TilF1TtxNGzfhwqY0R72/bge6S/eU4AlF7Dnu7KzxHSPTWT
 JgXw==
X-Gm-Message-State: AOJu0YzYqKEdk1QLdqPZKieYbaOs9bJjhrrOgLIzwbGVomD220PN2ItS
 lWlmosKIps5NqnRZ9vNmHa1mxaELneldS1mR3p+HZ9j+ZP+eQBX+Fd8O6HPgxHIkFCs=
X-Gm-Gg: ASbGncuU8hqKM+x4Jye0FMsQLNXTbzfjVGR3t6uZzq9J0USBDVuG+hDzQ4knfO8/nJ+
 Q2Ui35Msa1m8Pylps3fulF7C8BVpTH3BHYiw+snLLB+R3FDDuxCHJm0PU5ngLky42qMlt6Oui+K
 ug1OFEKnT6LkvQ1krEF3meo+ryDCiBAHUTEoWOcmoEQfp5ykoec6qLUorwWvPZp59haoQS1NYVJ
 gijO7A4o1ygIWbU2I9/n+IMNFhGpjSzkgscxkppKhgATeveUVhHmHJLkX1UwpKvF3oVVnj5LRQh
 /aI3qkUk8wPSvug+SqiINEqIbvcYws/aeSEwxplLmxH9zhAmYe3xGhoX8Z0fXhtO/o/sMPNI1Sq
 zNgBOHpuL6AzXOQUdz2u77fxkvtjIl3KZDZlO+L3jWLIMVa2aptFTv2vJAaEOYZ5wpAZzBr96yN
 75
X-Google-Smtp-Source: AGHT+IFNaacWyHgjOXtQQYb4QARRkJee3KyWx4SvORGK2ZnffWipQ/16R8whe8zBRui/M9y0rmDu6A==
X-Received: by 2002:a17:907:6090:b0:b6d:529f:9702 with SMTP id
 a640c23a62f3a-b6d6bb1a7fbmr1317949066b.12.1761563042869; 
 Mon, 27 Oct 2025 04:04:02 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d853c5bd8sm724170466b.38.2025.10.27.04.03.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 04:03:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D472961208;
 Mon, 27 Oct 2025 11:03:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Song Gao <gaosong@loongson.cn>, qemu-riscv@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Julian Ganz <neither@nut.email>
Subject: [PATCH 29/35] tests: add plugin asserting correctness of discon
 event's to_pc
Date: Mon, 27 Oct 2025 11:03:36 +0000
Message-ID: <20251027110344.2289945-30-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027110344.2289945-1-alex.bennee@linaro.org>
References: <20251027110344.2289945-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Julian Ganz <neither@nut.email>

We recently introduced plugin API for the registration of callbacks for
discontinuity events, specifically for interrupts, exceptions and host
call events. The callback receives various bits of information,
including the VCPU index and PCs.

This change introduces a test plugin asserting the correctness of that
behaviour in cases where this is possible with reasonable effort.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/plugins/discons.c   | 221 ++++++++++++++++++++++++++++++++++
 tests/tcg/plugins/meson.build |   2 +-
 2 files changed, 222 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/plugins/discons.c

diff --git a/tests/tcg/plugins/discons.c b/tests/tcg/plugins/discons.c
new file mode 100644
index 00000000000..2e0e664e823
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
index 61a007d9e74..561584159eb 100644
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
2.47.3


