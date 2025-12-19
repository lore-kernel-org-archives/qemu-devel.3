Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BF8E66882
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 19:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfrI-0000ye-65; Fri, 19 Dec 2025 14:09:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vWfqb-0000fB-5F
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 14:09:12 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vWfqX-0006rX-L2
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 14:09:04 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42fbbc3df8fso1059233f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 11:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766171340; x=1766776140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KcQg2SX8Fz5MOpmF02U0B+xAbMjSsIf/owN/YL97tDk=;
 b=N8Tvs23hq8zh5weHIRhobDMaoLoK4FOSqWcoj+BUXd19/InYjW+Obh4Eg0TYNQrvKv
 6TRuIs9CGMrzZB2UQ2xoIuEe3/Ydrb+uYopajcav2Khhd8fa0xrN6UUyphN8/80W9a9x
 by4BcGYvxQ4HiaC+MXcLYDHoI5732AqjcYCPL8OBvBSjy8h5WGojsPEz//Mtr71qn93Z
 zIgN4WPvYXNvfCaeKSHBViHZ7wCYPPKqqVJeE/MwDFvnDa0QkGnW14SH2wsHWB/qMJh1
 gk2TYfUBIghID0dC48MR1QsRWF8ek/FuEwJoIPmDOpYnegwF++GR/mhNm80omYHKvrf4
 N6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766171340; x=1766776140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KcQg2SX8Fz5MOpmF02U0B+xAbMjSsIf/owN/YL97tDk=;
 b=ml8dYQU8fqq51nUf/CDk6yQG657oxtbG0E0SdrAuTQBW6AzXfFw3T2czs9BEqZ1k54
 vvuccrXKKYzzVigcF3W3cuk+La1kL6b1XXAfV488QOPy1lZvbecO2jiXwcxaYYI0o/Cs
 YTyduIDqu7l8yIlGIW5cD8j4YzKfYDdYVeckW+ryGE6lYoHpJG2A2bBpMxEQ4R3clBiJ
 5YDFMyK3Nr58lx+Hq5QyIbCa05WDBzZecdlQxuNXGaFeZxzEH+aJv9GE6e67wWBp5ZjT
 +xA5VHmqlqooxnTxdLaLfXsTvxAbgtBnR60t4V6tWM+IxdypWxLAPF/YZt9WfGRmorpp
 EbHA==
X-Gm-Message-State: AOJu0YzYtTbr1g7BI+GnpbGgVtZiuca9YpEjEcmN7r7qm2+N3ZRj7gNQ
 wCK+ya3I6JHW3eXTRwsW5NMKIgUxsLO5ThSeNXh5lLYJSOViYeb0jzNuH+bW9ar6zbA=
X-Gm-Gg: AY/fxX7gpoiuFJ32FjLyxwX9hde+ES8fLYyVKWc8H1f4H4OKzb76zOHbsvLhs3GA0SF
 nfIHvzUNvQRs8vxUTpwt8u4lH18/MCoUlvz3OkTTe7T/c/k6yNh30txoA6J7pk7v84VjtXtfBsK
 nzshU1zettEL5nODuJHhhM+ufD8wx5eH1GMjIebhxjCzNTeB4wLFxchOOZyHFJIcIOiP8Rwrh7C
 8raXkkpZMUam3r7R0fZatojfFQsYHXDWbVbn7GbNgjaD++69jHPvDIyje7K0zMZxcx5Z/SeR8ru
 8cwHezR0Uxw8IFTzZkhc8YPHLr0tGIVoPB7k2wky7EiW2EWxk8xcV2+ik7HyYupj+kMQYhg3f77
 15n35+AAA6eEcwXdbO62knA+ZYLjuj1aH9dI8XV7jItqcVeMPySIuyrbYNFz9oxa3rtCM/v//ZA
 D2cEsmF+2WhEI=
X-Google-Smtp-Source: AGHT+IH598mxUk0qoBk6qUyJAdxA6HPyr+xHiIoAKNHXWXHsghW99OXPC7uG6O/RuG2BS7iOmnynDA==
X-Received: by 2002:a05:6000:604:b0:431:8f8:7f1e with SMTP id
 ffacd0b85a97d-4324e50e0eamr4047737f8f.48.1766171339497; 
 Fri, 19 Dec 2025 11:08:59 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea82fddsm6429044f8f.25.2025.12.19.11.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 11:08:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 09D90601C8;
 Fri, 19 Dec 2025 19:08:51 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alwalid Salama <asalama@qti.qualcomm.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Mark Burton <mburton@qti.qualcomm.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 11/12] contrib/plugins: add systrace plugin for tracking
 exceptions and irqs
Date: Fri, 19 Dec 2025 19:08:48 +0000
Message-ID: <20251219190849.238323-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251219190849.238323-1-alex.bennee@linaro.org>
References: <20251219190849.238323-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

I'm hunting for lost IRQs and want to trace what various registers are
being set to when IRQs happen. This combines the discontinuity
tracking API with register value tracking to do so.

It supports:

  tracksw - to keep track of the last thing that wrote to a register
  show_frompc - show the line executing before the discontinuity

As we might not have disassembly for the nominal last pc for an async
IRQ we also track the pc of the last executed instruction in a block
and use that as a fallback.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/plugins/systrace.c  | 572 ++++++++++++++++++++++++++++++++++++
 contrib/plugins/meson.build |   2 +-
 2 files changed, 573 insertions(+), 1 deletion(-)
 create mode 100644 contrib/plugins/systrace.c

diff --git a/contrib/plugins/systrace.c b/contrib/plugins/systrace.c
new file mode 100644
index 00000000000..6c8f6d91f87
--- /dev/null
+++ b/contrib/plugins/systrace.c
@@ -0,0 +1,572 @@
+/*
+ * Copyright (C) 2025, Alex Bennée <alex.bennee@linaro.org>
+ *
+ * System tracing tool. Log changes to system registers and where IRQ
+ * and exceptions occur in the code.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <glib.h>
+#include <inttypes.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+/* The base register we are tracking */
+typedef struct {
+    struct qemu_plugin_register *handle;
+    const char *name;
+    int index;
+    int instrumentation_count;
+} BaseRegister;
+
+/*
+ * Array of BaseRegister - the position in the array will also
+ * control the index into the access score board. As the list may grow
+ * dynamically as additional vCPUs are initialised we need to protect
+ * the list with a lock.
+ */
+static GArray *base_registers;
+static GMutex base_reg_lock;
+static struct qemu_plugin_scoreboard *base_reg_hits;
+
+#define MAX_TRACKING_REGISTERS 32
+
+/*
+ * Scoreboard for tracking last sysreg write - usually the last one
+ * touched is the one that triggered something ;-)
+ */
+static bool track_sysreg_write;
+static char *sysreg_ins;
+static struct qemu_plugin_scoreboard *last_sysreg_write;
+
+/*
+ * Scoreboard for tracking last executed PC. It's possible to be
+ * missing a translation of from_pc due to the fact we may have
+ * advanced the PC before attempting the translation. However the last
+ * insn in a block will generally be the last thing we did.
+ */
+static struct qemu_plugin_scoreboard *last_exec_pc;
+
+/* per-vcpu initialisation lock */
+static GMutex vcpu_init_lock;
+
+/* the passed matching parameters */
+static GPtrArray *rmatches;
+
+/* The per-cpu register tracking structure */
+typedef struct {
+    GByteArray *last;
+    uint64_t last_dump_count;
+    int index;
+} Register;
+
+/* CPU specific data */
+typedef struct CPU {
+    /* Track available registers over multiple vcpu_init calls */
+    int available_reg_count;
+    /* Ptr array of Register */
+    GPtrArray *registers;
+} CPU;
+
+/* This is defined at start time */
+static GArray *cpus;
+
+/* Track the disassembly */
+static GHashTable *haddr_disas;
+static GMutex disas_lock;
+
+static bool show_from_pc;
+
+static CPU *get_cpu(int vcpu_index)
+{
+    CPU *c = &g_array_index(cpus, CPU, vcpu_index);
+    return c;
+}
+
+/*
+ * BaseRegister handling
+ *
+ * We return copies of the BaseRegister entry so we don't get
+ * surprised by resizing of the underlying array.
+ */
+
+static BaseRegister get_base_reg(int index)
+{
+    BaseRegister info, *entry;
+
+    g_mutex_lock(&base_reg_lock);
+
+    entry = &g_array_index(base_registers, BaseRegister, index);
+    info = *entry;
+
+    g_mutex_unlock(&base_reg_lock);
+
+    return info;
+}
+
+static BaseRegister find_or_add_base_register(qemu_plugin_reg_descriptor * rd)
+{
+    g_autofree gchar *lower = g_utf8_strdown(rd->name, -1);
+    BaseRegister base;
+    bool found = false;
+
+    g_mutex_lock(&base_reg_lock);
+
+    for (int i = 0; i < base_registers->len; i++) {
+        BaseRegister *check = &g_array_index(base_registers, BaseRegister, i);
+        if (check->handle == rd->handle) {
+            base = *check;
+            found = true;
+            break;
+        }
+    }
+
+    /* didn't find, then add it */
+    if (!found) {
+        base.handle = rd->handle;
+        base.name = g_intern_string(lower);
+        base.index = base_registers->len;
+
+        g_array_append_val(base_registers, base);
+    }
+
+    g_assert(base_registers->len < MAX_TRACKING_REGISTERS);
+
+    g_mutex_unlock(&base_reg_lock);
+
+    return base;
+}
+
+/* Sets *info on find */
+static bool find_base_reg_by_str(const gchar *insn_arg, BaseRegister *info)
+{
+    bool reg_hit = false;
+
+    g_mutex_lock(&base_reg_lock);
+
+    for (int n = 0; n < base_registers->len; n++) {
+        BaseRegister *base = &g_array_index(base_registers, BaseRegister, n);
+        if (g_strrstr(insn_arg, base->name)) {
+            *info = *base;
+            reg_hit = true;
+            break;
+        }
+    }
+
+    g_mutex_unlock(&base_reg_lock);
+
+    return reg_hit;
+}
+
+/**
+ * On translation block new translation
+ *
+ * QEMU convert code by translation block (TB). We are only going to
+ * add hooks to instructions that modify the registers we care about.
+ * However we do need a record of every instruction we come across so
+ * we can resolve information for the discontinuities.
+ */
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    struct qemu_plugin_insn *insn;
+    uint64_t vaddr;
+
+    g_mutex_lock(&disas_lock);
+
+    size_t n_insns = qemu_plugin_tb_n_insns(tb);
+    for (size_t i = 0; i < n_insns; i++) {
+        g_autofree char *insn_disas = NULL;
+        const gchar *intern_disas;
+
+        /*
+         * `insn` is shared between translations in QEMU, copy needed
+         * data here.
+         *
+         * We will generate an interned string from the disassembly
+         * and save it in out hash table indexed by the vaddr.
+         *
+         * This is vulnerable to old pages being swapped out because
+         * we aren't tracking the underlying physical address. But
+         * generally we expect this to be sane.
+         *
+         * The interned strings are never free'd but hopefully there
+         * is enough repetition we don't need a string for every
+         * instruction we execute.
+         */
+        insn = qemu_plugin_tb_get_insn(tb, i);
+        insn_disas = qemu_plugin_insn_disas(insn);
+        intern_disas = g_intern_string(insn_disas);
+        /* haddr = qemu_plugin_insn_haddr(insn); */
+        vaddr = qemu_plugin_insn_vaddr(insn);
+
+        /* replaces any existing interned string */
+        g_hash_table_insert(haddr_disas,
+                            GUINT_TO_POINTER(vaddr),
+                            (gpointer) intern_disas);
+
+        /*
+         * Check the disassembly to see if a register we care about
+         * will be affected by this instruction. This relies on the
+         * dissembler doing something sensible for the registers we
+         * care about.
+         */
+        g_auto(GStrv) args = g_strsplit_set(insn_disas, " \t", 2);
+
+        if (args && args[1]) {
+            BaseRegister info;
+
+            if (find_base_reg_by_str(args[1], &info)) {
+                qemu_plugin_u64 cnt = {
+                    .score = base_reg_hits,
+                    .offset = (size_t)info.index * sizeof(uint64_t)
+                };
+                qemu_plugin_register_inline_per_vcpu(insn,
+                                                    QEMU_PLUGIN_INLINE_ADD_U64,
+                                                     cnt, 1);
+            }
+        }
+
+        /*
+         * If we are tracking system register writes lets check here.
+         */
+        if (args && track_sysreg_write) {
+            if (g_strrstr(args[0], sysreg_ins)) {
+                qemu_plugin_u64 write_pc = {
+                    .score = last_sysreg_write,
+                };
+                qemu_plugin_register_inline_per_vcpu(
+                    insn, QEMU_PLUGIN_INLINE_STORE_U64,
+                    write_pc, vaddr);
+            }
+        }
+    }
+
+    /*
+     * On the last instruction store the PC so we can recover if we
+     * are missing translations we haven't done yet.
+     */
+    if (n_insns > 0) {
+        qemu_plugin_u64 last_pc = { .score = last_exec_pc };
+        qemu_plugin_register_inline_per_vcpu(
+                insn, QEMU_PLUGIN_INLINE_STORE_U64,
+                last_pc, vaddr);
+    }
+
+    g_mutex_unlock(&disas_lock);
+}
+
+static void dump_reg(GString *out, GByteArray *value) {
+    /* TODO: handle BE properly */
+    for (int j = value->len - 1; j >= 0; j--) {
+        g_string_append_printf(out, "%02x", value->data[j]);
+    }
+}
+
+static void check_reg_changes(unsigned int vcpu_index, CPU *cpu, GString *out)
+{
+    uint64_t *hits = qemu_plugin_scoreboard_find(base_reg_hits, vcpu_index);
+
+    for (int i = 0; i < cpu->registers->len; i++) {
+        Register *reg = g_ptr_array_index(cpu->registers, i);
+        uint64_t hit_count = hits[reg->index];
+        if (hit_count > reg->last_dump_count) {
+            BaseRegister base = get_base_reg(reg->index);
+            g_autoptr(GByteArray) new_val = g_byte_array_new();
+            int bytes = qemu_plugin_read_register(base.handle, new_val);
+            g_assert(bytes > 0);
+            g_assert(bytes == reg->last->len);
+            if (memcmp(reg->last->data, new_val->data, reg->last->len) != 0) {
+                g_string_append_printf(out, "  REG: %s is ", base.name);
+                dump_reg(out, new_val);
+                g_string_append_printf(out, " (previously ");
+                dump_reg(out, reg->last);
+                g_string_append_printf(out, ", %"PRId64" to %"PRId64" hits)\n", reg->last_dump_count, hit_count);
+
+                /* record the new value */
+                g_byte_array_set_size(reg->last, 0);
+                g_byte_array_append(reg->last, new_val->data, new_val->len);
+            }
+            reg->last_dump_count = hit_count;
+        }
+    }
+}
+
+
+static void vcpu_discon(qemu_plugin_id_t id, unsigned int vcpu_index,
+                        enum qemu_plugin_discon_type type, uint64_t from_pc,
+                        uint64_t to_pc)
+{
+    CPU *cpu = get_cpu(vcpu_index);
+    g_autoptr(GString) report = g_string_new("");
+    const char *type_string;
+    uint64_t from_hwaddr;
+    const char *disas;
+
+    qemu_plugin_translate_vaddr(from_pc, &from_hwaddr);
+
+    switch (type) {
+    case QEMU_PLUGIN_DISCON_INTERRUPT:
+        type_string = "irq";
+        break;
+    case QEMU_PLUGIN_DISCON_EXCEPTION:
+        type_string = "exception";
+        break;
+    case QEMU_PLUGIN_DISCON_HOSTCALL:
+        type_string = "host call";
+        break;
+    default:
+        g_assert_not_reached();
+        break;
+    }
+
+    g_string_append_printf(report,
+                           "CPU: %d taking %s from 0x%" PRIx64 " to 0x%" PRIx64 "\n",
+                           vcpu_index, type_string, from_pc, to_pc);
+
+    g_mutex_lock(&disas_lock);
+
+    if (show_from_pc) {
+        bool le_fallback = false;
+        uint64_t *le_pc = qemu_plugin_scoreboard_find(last_exec_pc, vcpu_index);
+        disas = g_hash_table_lookup(haddr_disas, GUINT_TO_POINTER(from_pc));
+        if (!disas) {
+            le_fallback = true;
+            disas = g_hash_table_lookup(haddr_disas, GUINT_TO_POINTER(*le_pc));
+            g_assert(disas);
+        }
+        g_string_append_printf(report, "  FROM: 0x%" PRIx64 " %s\t(%s)\n",
+                               le_fallback ? *le_pc : from_pc, disas,
+                               le_fallback ? "lepc" : "fpc");
+    }
+
+    if (track_sysreg_write) {
+        uint64_t *last_write = qemu_plugin_scoreboard_find(last_sysreg_write, vcpu_index);
+        disas = g_hash_table_lookup(haddr_disas, GUINT_TO_POINTER(*last_write));
+        if (disas) {
+            g_string_append_printf(report, "  LAST SYSREG: 0x%"PRIx64" %s\n", *last_write, disas);
+        }
+    }
+
+    g_mutex_unlock(&disas_lock);
+
+    if (base_reg_hits && cpu->registers) {
+        check_reg_changes(vcpu_index, cpu, report);
+    }
+
+    qemu_plugin_outs(report->str);
+}
+
+/**
+ * On vcpu exit, print the final state of the registers
+ */
+static void vcpu_exit(qemu_plugin_id_t id, unsigned int cpu_index)
+{
+    g_autoptr(GString) result = g_string_new("Register, Value, Accesses ");
+    g_autoptr(GByteArray) value = g_byte_array_new();
+
+    g_string_append_printf(result, "for CPU%d\n", cpu_index);
+    for (int i = 0; i < base_registers->len; i++) {
+        BaseRegister *base = &g_array_index(base_registers, BaseRegister, i);
+        qemu_plugin_u64 cnt = {
+            .score = base_reg_hits,
+            .offset = (size_t)base->index * sizeof(uint64_t)
+        };
+        uint64_t sum_hits = qemu_plugin_u64_get(cnt, cpu_index );
+
+        if (sum_hits > 0) {
+            g_string_append_printf(result, "%s, ", base->name);
+            qemu_plugin_read_register(base->handle, value);
+            dump_reg(result, value);
+            g_string_append_printf(result, ", % "PRId64"\n", sum_hits);
+        }
+    }
+    qemu_plugin_outs(result->str);
+}
+
+
+/*
+ * g_pattern_match_string has been deprecated in Glib since 2.70 and
+ * will complain about it if you try to use it. Fortunately the
+ * signature of both functions is the same making it easy to work
+ * around.
+ */
+static inline
+gboolean g_pattern_spec_match_string_qemu(GPatternSpec *pspec,
+                                          const gchar *string)
+{
+#if GLIB_CHECK_VERSION(2, 70, 0)
+    return g_pattern_spec_match_string(pspec, string);
+#else
+    return g_pattern_match_string(pspec, string);
+#endif
+};
+#define g_pattern_spec_match_string(p, s) g_pattern_spec_match_string_qemu(p, s)
+
+
+static Register *init_vcpu_register(BaseRegister *base)
+{
+    Register *reg = g_new0(Register, 1);
+    int r;
+
+    reg->index = base->index;
+    reg->last = g_byte_array_new();
+
+    /* read the initial value */
+    r = qemu_plugin_read_register(base->handle, reg->last);
+    /* we currently don't handle the bigger ones */
+    g_assert(r > 0);
+    g_assert(r <= 8);
+    return reg;
+}
+
+static void free_vcpu_register(gpointer data)
+{
+    Register *reg = (Register *)data;
+    g_byte_array_unref(reg->last);
+    g_free(reg);
+}
+
+static GPtrArray *registers_init(GArray *reg_list, int vcpu_index)
+{
+    g_autoptr(GPtrArray) registers = g_ptr_array_new_with_free_func(free_vcpu_register);
+
+    if (!rmatches) {
+        return NULL;
+    }
+
+    /*
+     * Go through each register in the complete list and
+     * see if we want to track it.
+     */
+    for (int r = 0; r < reg_list->len; r++) {
+        qemu_plugin_reg_descriptor *rd = &g_array_index(
+            reg_list, qemu_plugin_reg_descriptor, r);
+        for (int p = 0; p < rmatches->len; p++) {
+            g_autoptr(GPatternSpec) pat = g_pattern_spec_new(rmatches->pdata[p]);
+            g_autofree gchar *rd_lower = g_utf8_strdown(rd->name, -1);
+            if (g_pattern_spec_match_string(pat, rd->name) ||
+                g_pattern_spec_match_string(pat, rd_lower)) {
+                BaseRegister base = find_or_add_base_register(rd);
+                Register *reg = init_vcpu_register(&base);
+                g_ptr_array_add(registers, reg);
+            }
+        }
+    }
+
+    return registers->len ? g_steal_pointer(&registers) : NULL;
+}
+
+/*
+ * Initialise a new vcpu with:
+ *   - initial value of registers
+ *   - scoreboard to track reg hits
+ *   - optional scoreboard to track sysreg writes
+ */
+static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
+{
+    CPU *c;
+    g_autoptr(GArray) reg_list = qemu_plugin_get_registers();
+
+    g_mutex_lock(&vcpu_init_lock);
+
+    c = get_cpu(vcpu_index);
+
+    /* Are more registers available now? */
+    if (c->registers && (reg_list->len > c->available_reg_count)) {
+        fprintf(stderr, "%s: reset list....\n", __func__);
+        g_ptr_array_free(c->registers, true);
+        c->registers = NULL;
+    }
+
+    c->available_reg_count = reg_list->len;
+
+    if (!c->registers) {
+        c->registers = registers_init(reg_list, vcpu_index);
+        fprintf(stderr, "%s:%d reglen %d\n", __func__, vcpu_index, c->registers ? c->registers->len : 0);
+    }
+
+    if (track_sysreg_write && !last_sysreg_write) {
+        last_sysreg_write = qemu_plugin_scoreboard_new(sizeof(uint64_t));
+    }
+
+    if (!last_exec_pc) {
+        last_exec_pc = qemu_plugin_scoreboard_new(sizeof(uint64_t));
+    }
+
+    g_mutex_unlock(&vcpu_init_lock);
+}
+
+/*
+ * We have to wait until vCPUs are started before we can check the
+ * patterns find anything.
+ */
+static void add_regpat(char *regpat)
+{
+    if (!rmatches) {
+        rmatches = g_ptr_array_new();
+    }
+    g_ptr_array_add(rmatches, g_strdup(regpat));
+}
+
+/**
+ * Install the plugin
+ */
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info, int argc,
+                                           char **argv)
+{
+    /* We only work for system emulation */
+    if (!info->system_emulation) {
+        qemu_plugin_outs("The systrace plugin is for system emulation only.");
+        return -1;
+    }
+
+    /*
+     * Initialize dynamic array to cache vCPU instruction. We also
+     * need a hash table to track disassembly.
+     */
+    cpus = g_array_sized_new(true, true, sizeof(CPU), info->system.max_vcpus);
+    g_array_set_size(cpus, info->system.max_vcpus);
+    haddr_disas = g_hash_table_new(NULL, NULL);
+
+    base_registers = g_array_new(true, true, sizeof(BaseRegister));
+    base_reg_hits = qemu_plugin_scoreboard_new(MAX_TRACKING_REGISTERS * sizeof(uint64_t));
+
+    for (int i = 0; i < argc; i++) {
+        char *opt = argv[i];
+        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
+        if (g_strcmp0(tokens[0], "reg") == 0) {
+            add_regpat(tokens[1]);
+        } else if (g_strcmp0(tokens[0], "tracksw") == 0) {
+            track_sysreg_write = true;
+            if (tokens[1]) {
+                sysreg_ins = g_strdup(tokens[1]);
+            } else {
+                sysreg_ins = g_strdup("msr");
+            }
+        } else if (g_strcmp0(tokens[0], "show_frompc") == 0) {
+            if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &show_from_pc)) {
+                fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
+                return -1;
+            }
+        } else {
+            fprintf(stderr, "option parsing failed: %s\n", opt);
+            return -1;
+        }
+    }
+
+    /* Register init, translation block and exit callbacks */
+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_vcpu_discon_cb(id, QEMU_PLUGIN_DISCON_ALL, vcpu_discon);
+    qemu_plugin_register_vcpu_exit_cb(id, vcpu_exit);
+
+    return 0;
+}
diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index eb944b5159a..3d1365da433 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -1,6 +1,6 @@
 contrib_plugins = ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'hotblocks',
                    'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger',
-                   'traps', 'uftrace']
+                   'systrace', 'traps', 'uftrace']
 if host_os != 'windows'
   # lockstep uses socket.h
   contrib_plugins += 'lockstep'
-- 
2.47.3


