Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F43C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 11:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVqq8-0005gz-UV; Mon, 22 Jul 2024 07:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqq6-0005VX-3V
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:04:22 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqq3-0002RO-Qk
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:04:21 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52efd530a4eso2374475e87.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 04:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721646258; x=1722251058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rc/yY6n9+uzIblLVcOxQLSBJO6NUzRvL8eMhoaOnKuM=;
 b=F9PJh7qhTL7nfKidWlu0Y6z/JdxdaIotSS9jP4lKfb7DlwIKFLLZfzqGng0qcxmbLA
 PVOiv1iRenRx3Ws2uRsZ9txeq1fvB6j/2j2ZGiry2Od1CuwbJR04tTZkI5Zct2GQFXAe
 8asmYqg/eLWnpXfmU3o1+Lj/iOeuCjCu1lHyb8N38LBNsHP1G3V7vpeOUxOunGq0bZmk
 TyNny389eBSCp7MJ14r1uqRQDx/RuDvffRh9qMPeVQboWVkIbYqK8JtkqqkbmY2bnDqn
 utOzVf36afpIMZgrCppJgAzaNXDmmSqqm0IEhHFZ2tbO+J9Lf+NvLlHx8VEKy6TlSe2v
 RfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721646258; x=1722251058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rc/yY6n9+uzIblLVcOxQLSBJO6NUzRvL8eMhoaOnKuM=;
 b=KD3raENBUcWpuBiG1whJ6P4JekuWmbvh/xfuQ5gzCF9bDbsCmWUPQAEAxXA2MjJESJ
 /6S4HipewuNL9f+Xft71pyuBEPiRqbM1Gz2ky6PxTKg2B1yxjarPuDPUO0C+/SCN2+TL
 sr+hWWNWdU0QnaybzdT39Y0hSfGrudXoKnchhSCcy9oa1NTaAr0rkhoY6rrMMG5DkOeu
 0gtW1GGmzaYDqP5EiDyphhcPPLR23pKx9lQbsk0DkSYrjsxqe2xW5REKvFSriPL3OSkP
 oN4+fEF90W6bCKLdYOIo+m9cWjTnJFkJkvpr4FIVtAWbm1qZrQXP606y+F899zDLoeK+
 eQeA==
X-Gm-Message-State: AOJu0Yy/fTxcscQNiWgRT2ZzuamnSkEee+9nswMdqqyGIFwD2lNzsqTX
 8eAQGHwStfrFzly70mHqQC03drRRAnLMIaEea33stE3gcXAb/vIekiOMsMBvFhY=
X-Google-Smtp-Source: AGHT+IFbE26CqNpyqfXDtgXhavvItkrrUh6bBoPBjrWpax9MiRxInbsPCYKT0Qi1oxWqRpruBZFMww==
X-Received: by 2002:a05:6512:a8d:b0:52e:9b9e:2c14 with SMTP id
 2adb3069b0e04-52ee543f28amr10479329e87.60.1721646257613; 
 Mon, 22 Jul 2024 04:04:17 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c786032sm408823766b.34.2024.07.22.04.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 04:04:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F3E7E5F94C;
 Mon, 22 Jul 2024 12:04:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Simon Hamelin <simon.hamelin@grenoble-inp.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 04/16] plugins/stoptrigger: TCG plugin to stop execution under
 conditions
Date: Mon, 22 Jul 2024 12:04:01 +0100
Message-Id: <20240722110413.118418-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722110413.118418-1-alex.bennee@linaro.org>
References: <20240722110413.118418-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12d.google.com
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

From: Simon Hamelin <simon.hamelin@grenoble-inp.org>

This new plugin allows to stop emulation using conditions on the
emulation state. By setting this plugin arguments, it is possible
to set an instruction count limit and/or trigger address(es) to stop at.
The code returned at emulation exit can be customized.

This plugin demonstrates how someone could stop QEMU execution.
It could be used for research purposes to launch some code and
deterministically stop it and understand where its execution flow went.

Co-authored-by: Alexandre Iooss <erdnaxe@crans.org>
Signed-off-by: Simon Hamelin <simon.hamelin@grenoble-inp.org>
Signed-off-by: Alexandre Iooss <erdnaxe@crans.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240715081521.19122-2-simon.hamelin@grenoble-inp.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240718094523.1198645-5-alex.bennee@linaro.org>

diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index f7d7b9e3a4..954623f9bf 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -642,6 +642,28 @@ The plugin has a number of arguments, all of them are optional:
   configuration arguments implies ``l2=on``.
   (default: N = 2097152 (2MB), B = 64, A = 16)
 
+- contrib/plugins/stoptrigger.c
+
+The stoptrigger plugin allows to setup triggers to stop emulation.
+It can be used for research purposes to launch some code and precisely stop it
+and understand where its execution flow went.
+
+Two types of triggers can be configured: a count of instructions to stop at,
+or an address to stop at. Multiple triggers can be set at once.
+
+By default, QEMU will exit with return code 0. A custom return code can be
+configured for each trigger using ``:CODE`` syntax.
+
+For example, to stop at the 20-th instruction with return code 41, at address
+0xd4 with return code 0 or at address 0xd8 with return code 42::
+
+  $ qemu-system-aarch64 $(QEMU_ARGS) \
+    -plugin ./contrib/plugins/libstoptrigger.so,icount=20:41,addr=0xd4,addr=0xd8:42 -d plugin
+
+The plugin will log the reason of exit, for example::
+
+  0xd4 reached, exiting
+
 Plugin API
 ==========
 
diff --git a/contrib/plugins/stoptrigger.c b/contrib/plugins/stoptrigger.c
new file mode 100644
index 0000000000..03ee22f4c6
--- /dev/null
+++ b/contrib/plugins/stoptrigger.c
@@ -0,0 +1,151 @@
+/*
+ * Copyright (C) 2024, Simon Hamelin <simon.hamelin@grenoble-inp.org>
+ *
+ * Stop execution once a given address is reached or if the
+ * count of executed instructions reached a specified limit
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+
+#include <assert.h>
+#include <glib.h>
+#include <inttypes.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+/* Scoreboard to track executed instructions count */
+typedef struct {
+    uint64_t insn_count;
+} InstructionsCount;
+static struct qemu_plugin_scoreboard *insn_count_sb;
+static qemu_plugin_u64 insn_count;
+
+static uint64_t icount;
+static int icount_exit_code;
+
+static bool exit_on_icount;
+static bool exit_on_address;
+
+/* Map trigger addresses to exit code */
+static GHashTable *addrs_ht;
+
+static void exit_emulation(int return_code, char *message)
+{
+    qemu_plugin_outs(message);
+    g_free(message);
+    exit(return_code);
+}
+
+static void exit_icount_reached(unsigned int cpu_index, void *udata)
+{
+    uint64_t insn_vaddr = GPOINTER_TO_UINT(udata);
+    char *msg = g_strdup_printf("icount reached at 0x%" PRIx64 ", exiting\n",
+                                insn_vaddr);
+
+    exit_emulation(icount_exit_code, msg);
+}
+
+static void exit_address_reached(unsigned int cpu_index, void *udata)
+{
+    uint64_t insn_vaddr = GPOINTER_TO_UINT(udata);
+    char *msg = g_strdup_printf("0x%" PRIx64 " reached, exiting\n", insn_vaddr);
+    int exit_code;
+
+    exit_code = GPOINTER_TO_INT(
+        g_hash_table_lookup(addrs_ht, GUINT_TO_POINTER(insn_vaddr)));
+
+    exit_emulation(exit_code, msg);
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    size_t tb_n = qemu_plugin_tb_n_insns(tb);
+    for (size_t i = 0; i < tb_n; i++) {
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
+        gpointer insn_vaddr = GUINT_TO_POINTER(qemu_plugin_insn_vaddr(insn));
+
+        if (exit_on_icount) {
+            /* Increment and check scoreboard for each instruction */
+            qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+                insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, 1);
+            qemu_plugin_register_vcpu_insn_exec_cond_cb(
+                insn, exit_icount_reached, QEMU_PLUGIN_CB_NO_REGS,
+                QEMU_PLUGIN_COND_EQ, insn_count, icount + 1, insn_vaddr);
+        }
+
+        if (exit_on_address) {
+            if (g_hash_table_contains(addrs_ht, insn_vaddr)) {
+                /* Exit triggered by address */
+                qemu_plugin_register_vcpu_insn_exec_cb(
+                    insn, exit_address_reached, QEMU_PLUGIN_CB_NO_REGS,
+                    insn_vaddr);
+            }
+        }
+    }
+}
+
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    g_hash_table_destroy(addrs_ht);
+    qemu_plugin_scoreboard_free(insn_count_sb);
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info, int argc,
+                                           char **argv)
+{
+    addrs_ht = g_hash_table_new(NULL, g_direct_equal);
+
+    insn_count_sb = qemu_plugin_scoreboard_new(sizeof(InstructionsCount));
+    insn_count = qemu_plugin_scoreboard_u64_in_struct(
+        insn_count_sb, InstructionsCount, insn_count);
+
+    for (int i = 0; i < argc; i++) {
+        char *opt = argv[i];
+        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
+        if (g_strcmp0(tokens[0], "icount") == 0) {
+            g_auto(GStrv) icount_tokens = g_strsplit(tokens[1], ":", 2);
+            icount = g_ascii_strtoull(icount_tokens[0], NULL, 0);
+            if (icount < 1 || g_strrstr(icount_tokens[0], "-") != NULL) {
+                fprintf(stderr,
+                        "icount parsing failed: '%s' must be a positive "
+                        "integer\n",
+                        icount_tokens[0]);
+                return -1;
+            }
+            if (icount_tokens[1]) {
+                icount_exit_code = g_ascii_strtoull(icount_tokens[1], NULL, 0);
+            }
+            exit_on_icount = true;
+        } else if (g_strcmp0(tokens[0], "addr") == 0) {
+            g_auto(GStrv) addr_tokens = g_strsplit(tokens[1], ":", 2);
+            uint64_t exit_addr = g_ascii_strtoull(addr_tokens[0], NULL, 0);
+            int exit_code = 0;
+            if (addr_tokens[1]) {
+                exit_code = g_ascii_strtoull(addr_tokens[1], NULL, 0);
+            }
+            g_hash_table_insert(addrs_ht, GUINT_TO_POINTER(exit_addr),
+                                GINT_TO_POINTER(exit_code));
+            exit_on_address = true;
+        } else {
+            fprintf(stderr, "option parsing failed: %s\n", opt);
+            return -1;
+        }
+    }
+
+    if (!exit_on_icount && !exit_on_address) {
+        fprintf(stderr, "'icount' or 'addr' argument missing\n");
+        return -1;
+    }
+
+    /* Register translation block and exit callbacks */
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+
+    return 0;
+}
diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
index 449ead1130..98a89d5c40 100644
--- a/contrib/plugins/Makefile
+++ b/contrib/plugins/Makefile
@@ -28,6 +28,7 @@ NAMES += hwprofile
 NAMES += cache
 NAMES += drcov
 NAMES += ips
+NAMES += stoptrigger
 
 ifeq ($(CONFIG_WIN32),y)
 SO_SUFFIX := .dll
-- 
2.39.2


