Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F96C54E49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 12:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIeP-0004iz-Hr; Wed, 28 Feb 2024 07:03:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIeK-0004P3-DG
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:03:02 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIeI-00034c-4V
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:03:00 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-412a390347dso25801225e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 04:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709121776; x=1709726576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5fqJzaG+rra4qIDd/yb84hh5r0ZoEwCIgugl/C1mkk8=;
 b=SZado+C7i16ig+U4mDd6i7aIipnf+cN5tL/yuBgXTHcsf91I+FHaB+i6T3ugIcuCqb
 /Bc/OaMwoS8UQ6NkSQijeglcsg8eCEfUtXCg0/dI1TF6LDmKRNESFoYkgKB9kzudYC41
 vW9BygGM4gycF5YNvdkrEgd0d03jl75CL3YLHyB89pgX3I0PJLAOrh02pKOckzGdY2MZ
 b7QUgtNH0kVMA2uXTtK7w7YCnssQ1XEvQtLNeZV6787OlYRrnwd3Q32/kqZpnD9BYVJ2
 PtlgKF+gGiQUJ2XYcyq9qZJuOaQmQTUtDkKFGTLi1zpx6ouITPQUDpBqq/2xVGBFgx7Z
 L66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709121776; x=1709726576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5fqJzaG+rra4qIDd/yb84hh5r0ZoEwCIgugl/C1mkk8=;
 b=IYe1/ubOxzBMPyuCK3JdU0xaTRPdcCnV0b4UJd36Oi71dtZ+TqU+JUR6DC1JNEIxl3
 wg/BJ+7yl62BWP2pSNMMvHNy7xltR7Faa67GLdiyWZA+7PCn1VzEXzhs7vEelzaJIB4w
 oGEMDa0/Kc6viWKwaFXeC7Dg7+43m+Iskf37EHAZx/v6LiAcRT/UrLhPNi5S2N0aU6F7
 B5mElZ3FvYRHjoElnQp8pkpphS5oEkhcwTw08GPNCqiYwSKLyL0+zjmIxSaymllBTLYf
 NG6YtlZecfbpblXczn2JfIcYJJedBcm9DbgZ4bGcH3b2vdQmklcbjSlW/9lIyObwXhkm
 kGJA==
X-Gm-Message-State: AOJu0Yyam8srsdBUIu/iDg7+oHzj9aroqeENaB0E0sVNVGWuVqzTfc8y
 dY6InBy3cNlPGISH4RTmdgDyAD91p+WWkSHMVoK2ddlR9IxFCipD/Y4y7ZWJqrvkVUOgSF8mFXB
 h
X-Google-Smtp-Source: AGHT+IHfLtu31qZBg/EuL3Pi9Plq8Qx5ILAyXrjFU4aTlDj3X8sHOPsJKSSmxGQu5Exj6jCbTWxhpA==
X-Received: by 2002:a05:600c:4591:b0:412:a5ed:bb57 with SMTP id
 r17-20020a05600c459100b00412a5edbb57mr6152075wmo.31.1709121776292; 
 Wed, 28 Feb 2024 04:02:56 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 j17-20020a5d6191000000b0033d4cf751b2sm14313773wru.33.2024.02.28.04.02.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 04:02:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 297D65F92A;
 Wed, 28 Feb 2024 11:57:04 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 23/29] plugins: add an API to read registers
Date: Wed, 28 Feb 2024 11:56:55 +0000
Message-Id: <20240228115701.1416107-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228115701.1416107-1-alex.bennee@linaro.org>
References: <20240228115701.1416107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

We can only request a list of registers once the vCPU has been
initialised so the user needs to use either call the get function on
vCPU initialisation or during the translation phase.

We don't expose the reg number to the plugin instead hiding it behind
an opaque handle. For now this is just the gdb_regnum encapsulated in
an anonymous GPOINTER but in future as we add more state for plugins
to track we can expand it.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1706
Based-on:  <20231025093128.33116-18-akihiko.odaki@daynix.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240227144335.1196131-24-alex.bennee@linaro.org>

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 93981f8f89f..45e2ebc8f8f 100644
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
@@ -707,4 +708,49 @@ uint64_t qemu_plugin_end_code(void);
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
+ * Returns a potentially empty GArray of qemu_plugin_reg_descriptor.
+ * Caller frees the array (but not the const strings).
+ *
+ * Should be used from a qemu_plugin_register_vcpu_init_cb() callback
+ * after the vCPU is initialised, i.e. in the vCPU context.
+ */
+QEMU_PLUGIN_API
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
+ * order. On failure returns -1.
+ */
+QEMU_PLUGIN_API
+int qemu_plugin_read_register(struct qemu_plugin_register *handle,
+                              GByteArray *buf);
+
+
 #endif /* QEMU_QEMU_PLUGIN_H */
diff --git a/plugins/api.c b/plugins/api.c
index 54df72c1c00..81f43c9ce8a 100644
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
@@ -410,3 +413,55 @@ uint64_t qemu_plugin_entry_code(void)
 #endif
     return entry;
 }
+
+/*
+ * Create register handles.
+ *
+ * We need to create a handle for each register so the plugin
+ * infrastructure can call gdbstub to read a register. They are
+ * currently just a pointer encapsulation of the gdb_reg but in
+ * future may hold internal plugin state so its important plugin
+ * authors are not tempted to treat them as numbers.
+ *
+ * We also construct a result array with those handles and some
+ * ancillary data the plugin might find useful.
+ */
+
+static GArray *create_register_handles(GArray *gdbstub_regs)
+{
+    GArray *find_data = g_array_new(true, true,
+                                    sizeof(qemu_plugin_reg_descriptor));
+
+    for (int i = 0; i < gdbstub_regs->len; i++) {
+        GDBRegDesc *grd = &g_array_index(gdbstub_regs, GDBRegDesc, i);
+        qemu_plugin_reg_descriptor desc;
+
+        /* skip "un-named" regs */
+        if (!grd->name) {
+            continue;
+        }
+
+        /* Create a record for the plugin */
+        desc.handle = GINT_TO_POINTER(grd->gdb_reg);
+        desc.name = g_intern_string(grd->name);
+        desc.feature = g_intern_string(grd->feature_name);
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
+    return create_register_handles(regs);
+}
+
+int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
+{
+    g_assert(current_cpu);
+
+    return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg));
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


