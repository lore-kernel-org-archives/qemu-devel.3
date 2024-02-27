Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BD6C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 14:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reypX-00042j-BD; Tue, 27 Feb 2024 09:53:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reypV-0003xa-GK
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:53:13 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reypH-0004qF-1Q
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:53:12 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33de64c91abso865971f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 06:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709045576; x=1709650376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6xVYGm4nT6cWz4fyXZiPrJOLZa5oX8gcy9xaV5++0Mc=;
 b=XkumBFG5I2J2Ze+Q0QY6eipjunYjpFciZLmkdaKBDPCKTBZ+EM4KPBhWkSe03xaOuk
 +YwmPtD0l2CJDipGSpXjPGTGdLuv1n/uOIMKYKu73a8I7C3bNoDTZubyf7mu89gkf1WH
 XiJW4aXwzTlN1DU6x0iX5dTVukK7T4lpBbcyZKwOT/EU1kjw/+rgXCUehdnHRiE4vLQu
 3G0NVkvPWRFOoXr92MSJtBH+nRdgevbKwIH5rHAPe8iDlXV+LU9O73JAnWKP6XvmZsov
 PXDhhNfV5aOGyOFGE26+7eKewBOCH01E1Be0gLT9mmKRJJOZv3/Ic56aFw7Cdt3HcpUg
 bN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709045576; x=1709650376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6xVYGm4nT6cWz4fyXZiPrJOLZa5oX8gcy9xaV5++0Mc=;
 b=bAQJKZcGkc6TkKtmMOdDM4FzXBUc/oIyOyYh0DHITPGu9mMSl91c/MDO7XwHmQ5iOk
 uxcs9rlCLiFiDKtU8O8JNwCx1pQns3tVNhsz554jc1/h5zSWo9UQxLpd1WNZdzhBdXTH
 AHiDR8xTfeZuNIaWSksnjNPkfGjvRV+xOk5QAE8eZVlsuhcUm2x5kk5xn57Pv4ChaLPE
 MQLiCzAyDmuEiz14cb9iMOP9ZCB14ZfyJvqG7gpGIKhoxE9gkbT6AJ99OOSnjEegA2u+
 ve/cfVRGNTa8TN4UxTB5QoeU4CBxLJ2QhgfYN68fZS/Q2Q929Ru0UGRTYLCS03RlBLiZ
 a6aQ==
X-Gm-Message-State: AOJu0YycCj6C3S+df4FcViqLsI9Le6L3cQbvxBvhQ8q4aW06EBos+g+H
 8Haf3tMxkB2d7rop16JWpvlqm97Moz1DWGUbXGUS0OtZ58kpYTsUrNv1RXVE5SM=
X-Google-Smtp-Source: AGHT+IGv80MeFk2pOGX8cSxaEvcszb9R/23Zf7HcgqmmCB+KtvF/JnjdT7TTeWmEUUgDzy4DgVZ4Iw==
X-Received: by 2002:a5d:48cb:0:b0:33d:9d46:c16c with SMTP id
 p11-20020a5d48cb000000b0033d9d46c16cmr6488374wrs.44.1709045576693; 
 Tue, 27 Feb 2024 06:52:56 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o9-20020a5d4a89000000b0033df1dc39f0sm1852940wrq.4.2024.02.27.06.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 06:52:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B7C455F92A;
 Tue, 27 Feb 2024 14:43:37 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 qemu-arm@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Michael Rolnik <mrolnik@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-s390x@nongnu.org, Kyle Evans <kevans@freebsd.org>,
 Brad Smith <brad@comstyle.com>, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <bcain@quicinc.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 23/29] plugins: add an API to read registers
Date: Tue, 27 Feb 2024 14:43:29 +0000
Message-Id: <20240227144335.1196131-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227144335.1196131-1-alex.bennee@linaro.org>
References: <20240227144335.1196131-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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
an opaque handle. For now this is just the gdb_regnum encapsulated in
an anonymous GPOINTER but in future as we add more state for plugins
to track we can expand it.

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
v6
  - for now just wrap gdb_regnum
v7
  - minor style fixes
---
 include/qemu/qemu-plugin.h   | 48 +++++++++++++++++++++++++++++--
 plugins/api.c                | 55 ++++++++++++++++++++++++++++++++++++
 plugins/qemu-plugins.symbols |  2 ++
 3 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 93981f8f89f..6c5580f4428 100644
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
+ * Returns a potentially empty GArray of qemu_plugin_reg_descriptor.
+ * Caller frees the array (but not the const strings).
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
index 54df72c1c00..908fe7e6fa3 100644
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
+ * currently just a pointer encapsulation of the gdb_regnum but in
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


