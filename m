Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28B8C8303F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 10:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWv2g-0000Fl-GZ; Wed, 02 Jul 2025 06:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWv2e-0000Df-Ix
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:50:16 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWv2Z-00033f-P5
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:50:16 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4538a2fc7ffso44871385e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 03:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751453409; x=1752058209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ga+r7yAjZ91S5TYW9IwIwF6TbkVAcOYP9gO9+s32MWY=;
 b=gOIy0CZ2eznjUwIAkU3kZHjrx897jrlUuv+F1mbnOzW03KJQRyDZNJYNQpY9J8rSfQ
 b4u+/04UQ/7EqqzB0q5Izm8bdSvLtn8Nc8tyAE/9HSqh9T5MRzd5QE6byF199fCXwbZM
 Z4Fn0iHIPDRJ+2tdNGnAyW6N0bd0OPH5cJUCzO4dn84zOE7TEf1DQKTWpaR371zmhxOs
 GYXrFDFXxC4hRxVHtq+8WqcmZ0a/Vh47LFJbKnpm2fE9c7xzZ+Bcf0cp2Ny0lIAGTx4x
 EYN82SOkPi+Ka3nHVNw2Bp9vyGxSSbycpmbVnBBE1QOLgCDJ5SuA6ShSEFpVA1Goz3/H
 R2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751453409; x=1752058209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ga+r7yAjZ91S5TYW9IwIwF6TbkVAcOYP9gO9+s32MWY=;
 b=wmv4F/7uwocnd7Lk+n1P9jOKTwBZ2EyuoxMoOoA605G6AjpsrPQKt48gPRizo9E4pA
 vOInHyABo3C5e+emdSs1cKqPdKhz20lVTLKNPV/iDpCLJEXqz3SIpjJpQgueY5K52C7P
 17/u7SVzbljdaCWJpZEmrGv6O24h+Wuarci1U5ju6XNALoBAZOLUGCsxknG5LKS9aVI3
 yOs5Ue584bWlvTonqrIqtgFliSiyezO3UnqZpU4TSAjZzf2XoT6Yp+gwyjHhB7RTV5Y8
 ItP7ex5tvx4fYr6rlzJvnPOE4dHONWPChreblIxYptWLRlcGN/YqtbT93CT8fn5SVjeP
 zhgA==
X-Gm-Message-State: AOJu0YzSM8oFZnh6ZWUL7qn9VUkA9Y2LUNpWaCmkefc9sOcbaW8ou/ex
 52E8pxDx61tA0e7SfYJWOO5N8uqYgE9fOtiGyAtNJhAmVHjjb8x3HQ7l8zthjkDEji0=
X-Gm-Gg: ASbGncu+fEFw5AZEIR8XuXuEotRA6jhfZf+BDiRD5+JNIjsxGMuTKb3FcdRfdfOxnEL
 0gQzhp6Db1tVH4iW8n3ggfaXp+79k7tF/mzcHTPY09SDs5u2EvZGFtNF7Q2HUWZQOJPWuQD2zu9
 DuRJs93HLe3XjZDYGZsq0hXCRShuNKtLTWN8CnZdOuzms50xRQKES5y5pUeZsA6974rWnQKRG53
 7mPsdKgh3Yv3zAhROpKYYc7ACZJ2meFxir+RWhjLhHZj0/Ib11Ss8ArDCF3zX7PWTMOFrWvfIZB
 Tkz6JhEoTas2cTDXpT0g/frqTY6XT/wNvB+dsa++NwAfWnJ1tbz/t4Dbt9Tx6sY=
X-Google-Smtp-Source: AGHT+IHOlwq7FgtCHB+a4B7ziT7LjROuWgILOCXT3hcrZmBwfrHefX1WwHAYiBuHEw9js4dYxHz6PQ==
X-Received: by 2002:a05:600c:8884:b0:453:69dc:2621 with SMTP id
 5b1f17b1804b1-454a3c5527cmr16590965e9.12.1751453408383; 
 Wed, 02 Jul 2025 03:50:08 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a3fe0d6sm194246525e9.25.2025.07.02.03.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 03:50:05 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D39BC5F8FC;
 Wed, 02 Jul 2025 11:49:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Rowan Hart <rowanbhart@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 11/15] plugins: Add patcher plugin and test
Date: Wed,  2 Jul 2025 11:49:51 +0100
Message-ID: <20250702104955.3778269-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250702104955.3778269-1-alex.bennee@linaro.org>
References: <20250702104955.3778269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

From: Rowan Hart <rowanbhart@gmail.com>

This patch adds a plugin that exercises the virtual and hardware memory
read-write API functions added in a previous patch. The plugin takes a
target and patch byte sequence, and will overwrite any instruction
matching the target byte sequence with the patch.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
Message-ID: <20250624175351.440780-8-rowanbhart@gmail.com>
[AJB: tweak Makefile, use uintptr_t for pointer stuffing]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250627112512.1880708-12-alex.bennee@linaro.org>

diff --git a/tests/tcg/plugins/patch.c b/tests/tcg/plugins/patch.c
new file mode 100644
index 0000000000..111c5c1f16
--- /dev/null
+++ b/tests/tcg/plugins/patch.c
@@ -0,0 +1,251 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This plugin patches instructions matching a pattern to a different
+ * instruction as they execute
+ *
+ */
+
+#include "glib.h"
+#include "glibconfig.h"
+
+#include <qemu-plugin.h>
+#include <string.h>
+#include <stdio.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+static bool use_hwaddr;
+static GByteArray *target_data;
+static GByteArray *patch_data;
+
+/**
+ * Parse a string of hexadecimal digits into a GByteArray. The string must be
+ * even length
+ */
+static GByteArray *str_to_bytes(const char *str)
+{
+    size_t len = strlen(str);
+
+    if (len == 0 || len % 2 != 0) {
+        return NULL;
+    }
+
+    GByteArray *bytes = g_byte_array_new();
+    char byte[3] = {0};
+    guint8 value = 0;
+
+    for (size_t i = 0; i < len; i += 2) {
+        byte[0] = str[i];
+        byte[1] = str[i + 1];
+        value = (guint8)g_ascii_strtoull(byte, NULL, 16);
+        g_byte_array_append(bytes, &value, 1);
+    }
+
+    return bytes;
+}
+
+static void patch_hwaddr(unsigned int vcpu_index, void *userdata)
+{
+    uintptr_t addr = (uintptr_t) userdata;
+    g_autoptr(GString) str = g_string_new(NULL);
+    g_string_printf(str, "patching: @0x%"
+                    PRIxPTR "\n",
+                    addr);
+    qemu_plugin_outs(str->str);
+
+    enum qemu_plugin_hwaddr_operation_result result =
+        qemu_plugin_write_memory_hwaddr(addr, patch_data);
+
+
+    if (result != QEMU_PLUGIN_HWADDR_OPERATION_OK) {
+        g_autoptr(GString) errmsg = g_string_new(NULL);
+        g_string_printf(errmsg, "Failed to write memory: %d\n", result);
+        qemu_plugin_outs(errmsg->str);
+        return;
+    }
+
+    GByteArray *read_data = g_byte_array_new();
+
+    result = qemu_plugin_read_memory_hwaddr(addr, read_data,
+                                            patch_data->len);
+
+    qemu_plugin_outs("Reading memory...\n");
+
+    if (result != QEMU_PLUGIN_HWADDR_OPERATION_OK) {
+        g_autoptr(GString) errmsg = g_string_new(NULL);
+        g_string_printf(errmsg, "Failed to read memory: %d\n", result);
+        qemu_plugin_outs(errmsg->str);
+        return;
+    }
+
+    if (memcmp(patch_data->data, read_data->data, patch_data->len) != 0) {
+        qemu_plugin_outs("Failed to read back written data\n");
+    }
+
+    qemu_plugin_outs("Success!\n");
+
+    return;
+}
+
+static void patch_vaddr(unsigned int vcpu_index, void *userdata)
+{
+    uintptr_t addr = (uintptr_t) userdata;
+    uint64_t hwaddr = 0;
+    if (!qemu_plugin_translate_vaddr(addr, &hwaddr)) {
+        qemu_plugin_outs("Failed to translate vaddr\n");
+        return;
+    }
+    g_autoptr(GString) str = g_string_new(NULL);
+    g_string_printf(str, "patching: @0x%"
+                    PRIxPTR " hw: @0x%" PRIx64 "\n",
+                    addr, hwaddr);
+    qemu_plugin_outs(str->str);
+
+    qemu_plugin_outs("Writing memory (vaddr)...\n");
+
+    if (!qemu_plugin_write_memory_vaddr(addr, patch_data)) {
+        qemu_plugin_outs("Failed to write memory\n");
+        return;
+    }
+
+    qemu_plugin_outs("Reading memory (vaddr)...\n");
+
+    g_autoptr(GByteArray) read_data = g_byte_array_new();
+
+    if (!qemu_plugin_read_memory_vaddr(addr, read_data, patch_data->len)) {
+        qemu_plugin_outs("Failed to read memory\n");
+        return;
+    }
+
+    if (memcmp(patch_data->data, read_data->data, patch_data->len) != 0) {
+        qemu_plugin_outs("Failed to read back written data\n");
+    }
+
+    qemu_plugin_outs("Success!\n");
+
+    return;
+}
+
+/*
+ * Callback on translation of a translation block.
+ */
+static void vcpu_tb_trans_cb(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    g_autoptr(GByteArray) insn_data = g_byte_array_new();
+    uintptr_t addr = 0;
+
+    for (size_t i = 0; i < qemu_plugin_tb_n_insns(tb); i++) {
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
+        uint64_t vaddr = qemu_plugin_insn_vaddr(insn);
+
+        if (use_hwaddr) {
+            uint64_t hwaddr = 0;
+            if (!qemu_plugin_translate_vaddr(vaddr, &hwaddr)) {
+                qemu_plugin_outs("Failed to translate vaddr\n");
+                continue;
+            }
+            /*
+             * As we cannot emulate 64 bit systems on 32 bit hosts we
+             * should never see the top bits set, hence we can safely
+             * cast to uintptr_t.
+             */
+            g_assert(hwaddr <= UINTPTR_MAX);
+            addr = (uintptr_t) hwaddr;
+        } else {
+            g_assert(vaddr <= UINTPTR_MAX);
+            addr = (uintptr_t) vaddr;
+        }
+
+        g_byte_array_set_size(insn_data, qemu_plugin_insn_size(insn));
+        qemu_plugin_insn_data(insn, insn_data->data, insn_data->len);
+
+        if (insn_data->len >= target_data->len &&
+            !memcmp(insn_data->data, target_data->data,
+                    MIN(target_data->len, insn_data->len))) {
+            if (use_hwaddr) {
+                qemu_plugin_register_vcpu_tb_exec_cb(tb, patch_hwaddr,
+                                                     QEMU_PLUGIN_CB_NO_REGS,
+                                                     (void *) addr);
+            } else {
+                qemu_plugin_register_vcpu_tb_exec_cb(tb, patch_vaddr,
+                                                     QEMU_PLUGIN_CB_NO_REGS,
+                                                     (void *) addr);
+            }
+        }
+    }
+}
+
+static void usage(void)
+{
+    fprintf(stderr, "Usage: <lib>,target=<bytes>,patch=<new_bytes>"
+            "[,use_hwaddr=true|false]");
+}
+
+/*
+ * Called when the plugin is installed
+ */
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info, int argc,
+                                           char **argv)
+{
+
+    use_hwaddr = true;
+    target_data = NULL;
+    patch_data = NULL;
+
+    if (argc > 4) {
+        usage();
+        return -1;
+    }
+
+    for (size_t i = 0; i < argc; i++) {
+        char *opt = argv[i];
+        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
+        if (g_strcmp0(tokens[0], "use_hwaddr") == 0) {
+            if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &use_hwaddr)) {
+                fprintf(stderr,
+                        "Failed to parse boolean argument use_hwaddr\n");
+                return -1;
+            }
+        } else if (g_strcmp0(tokens[0], "target") == 0) {
+            target_data = str_to_bytes(tokens[1]);
+            if (!target_data) {
+                fprintf(stderr,
+                         "Failed to parse target bytes.\n");
+                return -1;
+            }
+        } else if (g_strcmp0(tokens[0], "patch") == 0) {
+            patch_data = str_to_bytes(tokens[1]);
+            if (!patch_data) {
+                fprintf(stderr, "Failed to parse patch bytes.\n");
+                return -1;
+            }
+        } else {
+            fprintf(stderr, "Unknown argument: %s\n", tokens[0]);
+            usage();
+            return -1;
+        }
+    }
+
+    if (!target_data) {
+        fprintf(stderr, "target argument is required\n");
+        usage();
+        return -1;
+    }
+
+    if (!patch_data) {
+        fprintf(stderr, "patch argument is required\n");
+        usage();
+        return -1;
+    }
+
+    if (target_data->len != patch_data->len) {
+        fprintf(stderr, "Target and patch data must be the same length\n");
+        return -1;
+    }
+
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans_cb);
+
+    return 0;
+}
diff --git a/tests/tcg/x86_64/system/patch-target.c b/tests/tcg/x86_64/system/patch-target.c
new file mode 100644
index 0000000000..8c2b6f4ba7
--- /dev/null
+++ b/tests/tcg/x86_64/system/patch-target.c
@@ -0,0 +1,22 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This test target increments a value 100 times. The patcher converts the
+ * inc instruction to a nop, so it only increments the value once.
+ *
+ */
+#include <minilib.h>
+
+int main(void)
+{
+    ml_printf("Running test...\n");
+    unsigned int x = 0;
+    for (int i = 0; i < 100; i++) {
+        asm volatile (
+            "inc %[x]"
+            : [x] "+a" (x)
+        );
+    }
+    ml_printf("Value: %d\n", x);
+    return 0;
+}
diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 95ff76ea44..af68f11664 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -151,7 +151,12 @@ ifeq ($(CONFIG_PLUGIN),y)
 PLUGIN_SRC=$(SRC_PATH)/tests/tcg/plugins
 PLUGIN_LIB=../plugins
 VPATH+=$(PLUGIN_LIB)
-PLUGINS=$(patsubst %.c, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.c)))
+# Some plugins need to be disabled for all tests to avoid exponential explosion.
+# For example, libpatch.so only needs to run against the arch-specific patch
+# target test, so we explicitly run it in the arch-specific Makefile.
+DISABLE_PLUGINS=libpatch.so
+PLUGINS=$(filter-out $(DISABLE_PLUGINS), \
+	$(patsubst %.c, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.c))))
 
 # We need to ensure expand the run-plugin-TEST-with-PLUGIN
 # pre-requistes manually here as we can't use stems to handle it. We
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index 029342282a..61a007d9e7 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -1,6 +1,6 @@
 t = []
 if get_option('plugins')
-  foreach i : ['bb', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall']
+  foreach i : ['bb', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall', 'patch']
     if host_os == 'windows'
       t += shared_module(i, files(i + '.c') + '../../../contrib/plugins/win32_linker.c',
                         include_directories: '../../../include/qemu',
diff --git a/tests/tcg/x86_64/Makefile.softmmu-target b/tests/tcg/x86_64/Makefile.softmmu-target
index d3e09708a5..3e30ca9307 100644
--- a/tests/tcg/x86_64/Makefile.softmmu-target
+++ b/tests/tcg/x86_64/Makefile.softmmu-target
@@ -33,3 +33,12 @@ memory: CFLAGS+=-DCHECK_UNALIGNED=1
 
 # Running
 QEMU_OPTS+=-device isa-debugcon,chardev=output -device isa-debug-exit,iobase=0xf4,iosize=0x4 -kernel
+
+ifeq ($(CONFIG_PLUGIN),y)
+run-plugin-patch-target-with-libpatch.so:		\
+	PLUGIN_ARGS=$(COMMA)target=ffc0$(COMMA)patch=9090$(COMMA)use_hwaddr=true
+run-plugin-patch-target-with-libpatch.so:		\
+	CHECK_PLUGIN_OUTPUT_COMMAND=$(X64_SYSTEM_SRC)/validate-patch.py $@.out
+run-plugin-patch-target-with-libpatch.so: patch-target libpatch.so
+EXTRA_RUNS+=run-plugin-patch-target-with-libpatch.so
+endif
diff --git a/tests/tcg/x86_64/system/validate-patch.py b/tests/tcg/x86_64/system/validate-patch.py
new file mode 100755
index 0000000000..700950eae5
--- /dev/null
+++ b/tests/tcg/x86_64/system/validate-patch.py
@@ -0,0 +1,39 @@
+#!/usr/bin/env python3
+#
+# validate-patch.py: check the patch applies
+#
+# This program takes two inputs:
+#   - the plugin output
+#   - the binary output
+#
+# Copyright (C) 2024
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import sys
+from argparse import ArgumentParser
+
+def main() -> None:
+    """
+    Process the arguments, injest the program and plugin out and
+    verify they match up and report if they do not.
+    """
+    parser = ArgumentParser(description="Validate patch")
+    parser.add_argument('test_output',
+                        help="The output from the test itself")
+    parser.add_argument('plugin_output',
+                        help="The output from plugin")
+    args = parser.parse_args()
+
+    with open(args.test_output, 'r') as f:
+        test_data = f.read()
+    with open(args.plugin_output, 'r') as f:
+        plugin_data = f.read()
+    if "Value: 1" in test_data:
+        sys.exit(0)
+    else:
+        sys.exit(1)
+
+if __name__ == "__main__":
+    main()
+
-- 
2.47.2


