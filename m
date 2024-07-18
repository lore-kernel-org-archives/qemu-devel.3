Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF26C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 09:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUNhf-0003Qm-SG; Thu, 18 Jul 2024 05:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sUNhe-0003Lu-FO
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:45:34 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sUNhY-0007bj-MI
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:45:34 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-58c947a6692so617816a12.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 02:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721295927; x=1721900727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cy5Sl4WXq4QMVwT3rabklASKFIpoNgNRc1QNcX2+dVk=;
 b=rOB/PXfqox2Xr7qbdRnSV5XUqXINt7jUdD2nYiM1JR94HDZGlERlTZ5H+HpgC4efla
 WRs6it3Z3oPdgGqPin2FzMtbRgvJ13p64w9OUJC50OD/KNlpNoKSKPm/Hrpevuf9pNLU
 mD1vqNukSijmX+CUNvghL1HC9OzVjvHc0wtH8QG0kP08g7k+QW0gcgQacnHaM4B8Q8e6
 zRwIuD4YOF/0PHGFhRG1j70rGrUsnuY/amzhnHNInLrNHTrmycEoAcUVUDLg5SiKutB9
 567sFBmwQF9mhO8XsCvIwQXUw2jb2H72/74LXJ6jkIG9N4vFecYohK0P8geWs17kFLNu
 L4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721295927; x=1721900727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cy5Sl4WXq4QMVwT3rabklASKFIpoNgNRc1QNcX2+dVk=;
 b=B1dgX2HCDVj1CrB+NDTip3C4oEgpJgs7ICBbKROSp2M7onk+6ZUcHb9UWI5BPELZZo
 ZNczXrMql4SN2eCnrTJbB0rPwN3qDCCu2QgUodSGJKwt3aeRJr4C6BzhXc4/fhlLsqJb
 Fu73h/gHylWU3qeXmA5HV6xIGA5YDTD9y8lRhyDm39KYFMuIIGUfqjq43YnzwH4Gs9jV
 xo2sa7YpkYetidsWMMTn5lAGWV06lzIGmTpQVRznKaSu/xjIB3HHDY3KqWkyHNdaEue6
 l0kOzjuZXGoeNPHK3oa/vPPrPbYP+X1AR9I0IqVkz61S5ZAceWJDyaUOOKZ3tU4MQiCr
 Hwqg==
X-Gm-Message-State: AOJu0YwE4+z6xQVIcRuadyqYclzD+lNyQJgKMpeBhsbU5WIMCENuDuXf
 dC3lmNrglrg9irN2Ckh8RPaFTKtYfVgLwduatD5E/WP4Qo4L04KfLBlAc/DDDkI=
X-Google-Smtp-Source: AGHT+IFLNQqQuEjHyS9ulRMD4m3n/4XCql0unLNVcal5XdH1H8S46BPFW5w0bovQuENPm+8VSIbkOQ==
X-Received: by 2002:a17:906:a3cc:b0:a77:e2e3:3557 with SMTP id
 a640c23a62f3a-a7a013386b1mr339357566b.57.1721295926809; 
 Thu, 18 Jul 2024 02:45:26 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc7ff89esm539861466b.158.2024.07.18.02.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 02:45:25 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 62C205FA12;
 Thu, 18 Jul 2024 10:45:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Bin Meng <bmeng.cn@gmail.com>, qemu-riscv@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Beraldo Leal <bleal@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Ed Maste <emaste@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Simon Hamelin <simon.hamelin@grenoble-inp.org>
Subject: [PATCH 04/15] plugins/stoptrigger: TCG plugin to stop execution under
 conditions
Date: Thu, 18 Jul 2024 10:45:12 +0100
Message-Id: <20240718094523.1198645-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240718094523.1198645-1-alex.bennee@linaro.org>
References: <20240718094523.1198645-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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
---
 docs/devel/tcg-plugins.rst    |  22 +++++
 contrib/plugins/stoptrigger.c | 151 ++++++++++++++++++++++++++++++++++
 contrib/plugins/Makefile      |   1 +
 3 files changed, 174 insertions(+)
 create mode 100644 contrib/plugins/stoptrigger.c

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


