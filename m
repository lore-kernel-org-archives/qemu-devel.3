Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B39C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdYdi-0004Cx-9r; Fri, 23 Feb 2024 11:43:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rdYQF-00062E-Uz
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:29:15 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rdYPt-0007HJ-DR
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:29:15 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41275855dc4so8249685e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 08:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708705732; x=1709310532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G3e1zs3hBLyk7ysaVKXI7mF1a4hmFyD3rPOj4+yRWkM=;
 b=uSUUguEk1KgqQAh8P0Wdd8Wc3HKgEMtDlwaZZfUIstFptDWMsgCybm/82wmmuWA8tL
 4gzzoE3PKg3Tlz8eemP4A8bbqi9FaGe5qaTilY9Q4eWErWRmrCowhcWnuT5J30+OlH8W
 2wUHhMYSNY9S/9wwJPsEEKW+Ctr0Q/zgr/ktbaveARkHFOmfNkWLSKJpxpHRvMMGvbMo
 NArYCLOnJcbAhhIFPTxtbk6Hm+FScxV1eytuIyqk595iCCW7siFDZ7vpTPwTZBgbH3ui
 X212Wiwkko8FypP+RgUB1qDtGIcdSZv4LbrpCaM9lUGc3EArnMSMvTcFgtb4b60QuOV8
 ermw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708705732; x=1709310532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G3e1zs3hBLyk7ysaVKXI7mF1a4hmFyD3rPOj4+yRWkM=;
 b=h2h7SVx00UlCSKPDQbB3WhzOauv9kgOwnGmroZmQqb9pEMA1Yth466OLI8i/QDqgHd
 hYbSM4LgUGAmDML47MvIK+xg3LQOSfYLrcsN2sNcYmYzBGekHq5fJma6TdPSeTWLZ+8D
 9i87bvMLhE5QsjGoDe+tG76/AjFmq60aCELb0++0GPzV7PMXzVJ4sDk1xlfdD9PG8LR8
 QS+CN+DXnskpJiHUTchP+K0LqwHcUAnyKAypbTymYejY9C458/j3zSdWbqk28H/CugNg
 cWbVJlnVMOOn7vt7iTLLCLITLNju7ReTGyQ47oCZSvfTl3AzxibcJcqitZs9WsUSaHnn
 AOmw==
X-Gm-Message-State: AOJu0YzwzxJ/MUa7zainPsENpd01epcuNvGN33/O3iI5b9EY9jwtTkfj
 /6Qe9SyDTA9ydnwHcRg7VRwBCqLh7qsAO9foKdjlwE3BQ39PkjxAy7EzzagZXH4=
X-Google-Smtp-Source: AGHT+IHcKAc1uI7iuDohmBJAuaxqfOpS/0692ClTHZS3LLHr9Zggi5IiUYtfJ72zcFRIxETsGhj6DQ==
X-Received: by 2002:a5d:5387:0:b0:33d:2d2c:f404 with SMTP id
 d7-20020a5d5387000000b0033d2d2cf404mr219773wrv.15.1708705731697; 
 Fri, 23 Feb 2024 08:28:51 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 co22-20020a0560000a1600b0033db0c866f7sm1675960wrb.11.2024.02.23.08.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 08:28:46 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 891FA5F937;
 Fri, 23 Feb 2024 16:22:04 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, qemu-s390x@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Bin Meng <bin.meng@windriver.com>, Yanan Wang <wangyanan55@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, John Snow <jsnow@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Brian Cain <bcain@quicinc.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 21/27] plugins: add an API to read registers
Date: Fri, 23 Feb 2024 16:21:56 +0000
Message-Id: <20240223162202.1936541-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240223162202.1936541-1-alex.bennee@linaro.org>
References: <20240223162202.1936541-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We can only request a list of registers once the vCPU has been
initialised so the user needs to use either call the get function on
vCPU initialisation or during the translation phase.

We don't expose the reg number to the plugin instead hiding it behind
an opaque handle. As the register set is potentially different for
each vCPU we store a separate set of handles for each vCPU. This will
become more important if we are able to emulate more heterogeneous
systems.

Having an internal state within the plugins also allows us to expand
the interface in future (for example providing callbacks on register
change if the translator can track changes).

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1706
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240103173349.398526-39-alex.bennee@linaro.org>
Based-on: <20231025093128.33116-18-akihiko.odaki@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

---
v4
  - the get/read_registers functions are now implicitly for current
  vCPU only to accidental cpu != current_cpu uses.
v5
  - make reg_handles as per-CPUPluginState variable.
---
 include/qemu/plugin.h        |  2 +
 include/qemu/qemu-plugin.h   | 48 +++++++++++++++++++-
 plugins/api.c                | 88 ++++++++++++++++++++++++++++++++++++
 plugins/qemu-plugins.symbols |  2 +
 4 files changed, 138 insertions(+), 2 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 0e7b9693d80..64fb425fb0b 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -189,9 +189,11 @@ struct qemu_plugin_insn *qemu_plugin_tb_insn_get(struct qemu_plugin_tb *tb,
 /**
  * struct CPUPluginState - per-CPU state for plugins
  * @event_mask: plugin event bitmap. Modified only via async work.
+ * @reg_handles: hash table of register handles.
  */
 struct CPUPluginState {
     DECLARE_BITMAP(event_mask, QEMU_PLUGIN_EV_MAX);
+    GHashTable *reg_handles;
 };
 
 /**
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 93981f8f89f..3b6b18058d2 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -11,6 +11,7 @@
 #ifndef QEMU_QEMU_PLUGIN_H
 #define QEMU_QEMU_PLUGIN_H
 
+#include <glib.h>
 #include <inttypes.h>
 #include <stdbool.h>
 #include <stddef.h>
@@ -229,8 +230,8 @@ struct qemu_plugin_insn;
  * @QEMU_PLUGIN_CB_R_REGS: callback reads the CPU's regs
  * @QEMU_PLUGIN_CB_RW_REGS: callback reads and writes the CPU's regs
  *
- * Note: currently unused, plugins cannot read or change system
- * register state.
+ * Note: currently QEMU_PLUGIN_CB_RW_REGS is unused, plugins cannot change
+ * system register state.
  */
 enum qemu_plugin_cb_flags {
     QEMU_PLUGIN_CB_NO_REGS,
@@ -707,4 +708,47 @@ uint64_t qemu_plugin_end_code(void);
 QEMU_PLUGIN_API
 uint64_t qemu_plugin_entry_code(void);
 
+/** struct qemu_plugin_register - Opaque handle for register access */
+struct qemu_plugin_register;
+
+/**
+ * typedef qemu_plugin_reg_descriptor - register descriptions
+ *
+ * @handle: opaque handle for retrieving value with qemu_plugin_read_register
+ * @name: register name
+ * @feature: optional feature descriptor, can be NULL
+ */
+typedef struct {
+    struct qemu_plugin_register *handle;
+    const char *name;
+    const char *feature;
+} qemu_plugin_reg_descriptor;
+
+/**
+ * qemu_plugin_get_registers() - return register list for current vCPU
+ *
+ * Returns a GArray of qemu_plugin_reg_descriptor or NULL. Caller
+ * frees the array (but not the const strings).
+ *
+ * Should be used from a qemu_plugin_register_vcpu_init_cb() callback
+ * after the vCPU is initialised, i.e. in the vCPU context.
+ */
+GArray *qemu_plugin_get_registers(void);
+
+/**
+ * qemu_plugin_read_register() - read register for current vCPU
+ *
+ * @handle: a @qemu_plugin_reg_handle handle
+ * @buf: A GByteArray for the data owned by the plugin
+ *
+ * This function is only available in a context that register read access is
+ * explicitly requested via the QEMU_PLUGIN_CB_R_REGS flag.
+ *
+ * Returns the size of the read register. The content of @buf is in target byte
+ * order. On failure returns -1
+ */
+int qemu_plugin_read_register(struct qemu_plugin_register *handle,
+                              GByteArray *buf);
+
+
 #endif /* QEMU_QEMU_PLUGIN_H */
diff --git a/plugins/api.c b/plugins/api.c
index 54df72c1c00..f6c3ba2366f 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -8,6 +8,7 @@
  *
  *  qemu_plugin_tb
  *  qemu_plugin_insn
+ *  qemu_plugin_register
  *
  * Which can then be passed back into the API to do additional things.
  * As such all the public functions in here are exported in
@@ -35,10 +36,12 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "qemu/plugin.h"
 #include "qemu/log.h"
 #include "tcg/tcg.h"
 #include "exec/exec-all.h"
+#include "exec/gdbstub.h"
 #include "exec/ram_addr.h"
 #include "disas/disas.h"
 #include "plugin.h"
@@ -410,3 +413,88 @@ uint64_t qemu_plugin_entry_code(void)
 #endif
     return entry;
 }
+
+/*
+ * Register handles
+ *
+ * The plugin infrastructure keeps hold of these internal data
+ * structures which are presented to plugins as opaque handles. They
+ * are local to each vCPU as there can be slight variations for each
+ * vCPU depending on enabled features. We track this in
+ * CPUPluginState.
+ */
+
+struct qemu_plugin_register {
+    const char *name;
+    int gdb_reg_num;
+};
+
+/*
+ * Create register handles.
+ *
+ * We need to create a handle for each register so the plugin
+ * infrastructure can call gdbstub to read a register. We also
+ * construct a result array with those handles and some ancillary data
+ * the plugin might find useful.
+ */
+
+static GArray *create_register_handles(CPUState *cs, GArray *gdbstub_regs)
+{
+    GArray *find_data = g_array_new(true, true,
+                                    sizeof(qemu_plugin_reg_descriptor));
+
+    if (!cs->plugin_state->reg_handles) {
+        cs->plugin_state->reg_handles = g_hash_table_new(g_direct_hash,
+                                                         g_direct_equal);
+    }
+
+    for (int i = 0; i < gdbstub_regs->len; i++) {
+        GDBRegDesc *grd = &g_array_index(gdbstub_regs, GDBRegDesc, i);
+        gpointer key = GINT_TO_POINTER(grd->gdb_reg);
+        struct qemu_plugin_register *val
+            = g_hash_table_lookup(cs->plugin_state->reg_handles,
+                                  key);
+
+        /* skip "un-named" regs */
+        if (!grd->name) {
+            continue;
+        }
+
+        /* Doesn't exist, create one */
+        if (!val) {
+            val = g_new0(struct qemu_plugin_register, 1);
+            val->gdb_reg_num = grd->gdb_reg;
+            val->name = g_intern_string(grd->name);
+
+            g_hash_table_insert(cs->plugin_state->reg_handles, key, val);
+        } else {
+            /* make sure we are not seeing a key clash */
+            g_assert(val->gdb_reg_num == grd->gdb_reg);
+        }
+
+        /* Create a record for the plugin */
+        qemu_plugin_reg_descriptor desc = {
+            .handle = val,
+            .name = val->name,
+            .feature = g_intern_string(grd->feature_name)
+        };
+        g_array_append_val(find_data, desc);
+    }
+
+    return find_data;
+}
+
+GArray *qemu_plugin_get_registers(void)
+{
+    g_assert(current_cpu);
+
+    g_autoptr(GArray) regs = gdb_get_register_list(current_cpu);
+    return regs->len ? create_register_handles(current_cpu, regs) : NULL;
+}
+
+int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
+{
+    g_assert(current_cpu);
+
+    return gdb_read_register(current_cpu, buf, reg->gdb_reg_num);
+}
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index adb67608598..27fe97239be 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -3,6 +3,7 @@
   qemu_plugin_end_code;
   qemu_plugin_entry_code;
   qemu_plugin_get_hwaddr;
+  qemu_plugin_get_registers;
   qemu_plugin_hwaddr_device_name;
   qemu_plugin_hwaddr_is_io;
   qemu_plugin_hwaddr_phys_addr;
@@ -19,6 +20,7 @@
   qemu_plugin_num_vcpus;
   qemu_plugin_outs;
   qemu_plugin_path_to_binary;
+  qemu_plugin_read_register;
   qemu_plugin_register_atexit_cb;
   qemu_plugin_register_flush_cb;
   qemu_plugin_register_vcpu_exit_cb;
-- 
2.39.2


