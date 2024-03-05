Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A183C54E49
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 12:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhTlQ-0001Km-A6; Tue, 05 Mar 2024 07:19:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTl1-0008Oy-2Y
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:18:58 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTks-0003Dr-Bs
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:18:54 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-412ee276dc9so3111205e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 04:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709641125; x=1710245925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Q6z2XfIeMWCEhbEBjQ3EoV1Q07C8fVhTLWW7QaYwTo=;
 b=C4hb9L1i4X4op+bj66Nf6ySvXmCwh8ZrnDBJl8V2WYBNpQdmMVYACU2knUt7gsXaLS
 ZIxs4CAkMg8tPpYKx0LphxXFl9GNYfxe72M+UGqpV6PphRnL55KlSMSNdCFRwRgmX2xg
 gDCp3bTtzDIvJBOKaf3ogsBdKcyt5rLUnbTLEHF+Q0wjZ+uAdkeZsKGZ4yIzfsBGnElw
 Ei8RZl5xCi7685IMHklq8++BRPA1UIn77ZXGR/EfpPwH9abXlhmV/eKjx/xhShxjYWHp
 1zCapC4fcTaHZ6j8RV9X04QGIDRi0QYNle5geymZHa2Fu2e2eTc8hVTQsD7d0NZMVklN
 j6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709641125; x=1710245925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Q6z2XfIeMWCEhbEBjQ3EoV1Q07C8fVhTLWW7QaYwTo=;
 b=aTNybHkQM0H4qmeCuTLUafyGL2uuNkBEA6kJtjwiW94TfBFux/4VTtaAfq66YNXCho
 7f53uq7V24QHTe+taVXNItyX7BtaHfBiUTb0TI73EwdnXlAV8Tc74iPETL9vsG0X1JXp
 WGDpIL7Hlyg6OlB4EdTsvUZ1wx8EoovkYsJc9QYiqr60jJtLRSThoOYFPt8D5SpoJ/4C
 VMaSLO06xM0pX0ekIBfc+Uxvtg8ZgRvVIkdmQVg89wiRXo2QOTS9BYmbCf+39VXeVgSd
 XdMlU1wHcexDR+TSN6FhiKw1Q4DJAtZyZUhw4L4wwzNZ+sEp+Q27+uHKOKqRrc3oAp0G
 SZAQ==
X-Gm-Message-State: AOJu0YwTmm5PmP1mmRlel91wDm9RmkcTX+EgA8dbHh7V4/mC+roMKWRV
 rje5Y7JtKbvoXxnq5DSxWv+A5FPPlnPgqANO4qX+LPDK6KCPtHNiqRd+eOtZ1m4=
X-Google-Smtp-Source: AGHT+IEFRj2k6ymwj3aH8m1DmVV4O8TFL0RBA9AlzHT9bhhJLpp1WAN7/tMuaMyZR7yOAyChFmPhCQ==
X-Received: by 2002:a05:600c:1912:b0:412:e79f:3f8e with SMTP id
 j18-20020a05600c191200b00412e79f3f8emr3004101wmq.15.1709641124629; 
 Tue, 05 Mar 2024 04:18:44 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 q13-20020a05600c46cd00b00412ebd587ebsm2115488wmo.3.2024.03.05.04.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 04:18:43 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 37A5D5F9E4;
 Tue,  5 Mar 2024 12:10:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Brad Smith <brad@comstyle.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <bcain@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Beraldo Leal <bleal@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 David Hildenbrand <david@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Warner Losh <imp@bsdimp.com>, qemu-riscv@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 18/29] tests/plugin: add test plugin for inline operations
Date: Tue,  5 Mar 2024 12:09:54 +0000
Message-Id: <20240305121005.3528075-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305121005.3528075-1-alex.bennee@linaro.org>
References: <20240305121005.3528075-1-alex.bennee@linaro.org>
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

For now, it simply performs instruction, bb and mem count, and ensure
that inline vs callback versions have the same result. Later, we'll
extend it when new inline operations are added.

Use existing plugins to test everything works is a bit cumbersome, as
different events are treated in different plugins. Thus, this new one.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240304130036.124418-6-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/plugin/inline.c    | 186 +++++++++++++++++++++++++++++++++++++++
 tests/plugin/meson.build |   2 +-
 2 files changed, 187 insertions(+), 1 deletion(-)
 create mode 100644 tests/plugin/inline.c

diff --git a/tests/plugin/inline.c b/tests/plugin/inline.c
new file mode 100644
index 00000000000..0163e9b51c5
--- /dev/null
+++ b/tests/plugin/inline.c
@@ -0,0 +1,186 @@
+/*
+ * Copyright (C) 2023, Pierrick Bouvier <pierrick.bouvier@linaro.org>
+ *
+ * Demonstrates and tests usage of inline ops.
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+
+#include <glib.h>
+#include <stdint.h>
+#include <stdio.h>
+
+#include <qemu-plugin.h>
+
+typedef struct {
+    uint64_t count_tb;
+    uint64_t count_tb_inline;
+    uint64_t count_insn;
+    uint64_t count_insn_inline;
+    uint64_t count_mem;
+    uint64_t count_mem_inline;
+} CPUCount;
+
+static struct qemu_plugin_scoreboard *counts;
+static qemu_plugin_u64 count_tb;
+static qemu_plugin_u64 count_tb_inline;
+static qemu_plugin_u64 count_insn;
+static qemu_plugin_u64 count_insn_inline;
+static qemu_plugin_u64 count_mem;
+static qemu_plugin_u64 count_mem_inline;
+
+static uint64_t global_count_tb;
+static uint64_t global_count_insn;
+static uint64_t global_count_mem;
+static unsigned int max_cpu_index;
+static GMutex tb_lock;
+static GMutex insn_lock;
+static GMutex mem_lock;
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+static void stats_insn(void)
+{
+    const uint64_t expected = global_count_insn;
+    const uint64_t per_vcpu = qemu_plugin_u64_sum(count_insn);
+    const uint64_t inl_per_vcpu =
+        qemu_plugin_u64_sum(count_insn_inline);
+    printf("insn: %" PRIu64 "\n", expected);
+    printf("insn: %" PRIu64 " (per vcpu)\n", per_vcpu);
+    printf("insn: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
+    g_assert(expected > 0);
+    g_assert(per_vcpu == expected);
+    g_assert(inl_per_vcpu == expected);
+}
+
+static void stats_tb(void)
+{
+    const uint64_t expected = global_count_tb;
+    const uint64_t per_vcpu = qemu_plugin_u64_sum(count_tb);
+    const uint64_t inl_per_vcpu =
+        qemu_plugin_u64_sum(count_tb_inline);
+    printf("tb: %" PRIu64 "\n", expected);
+    printf("tb: %" PRIu64 " (per vcpu)\n", per_vcpu);
+    printf("tb: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
+    g_assert(expected > 0);
+    g_assert(per_vcpu == expected);
+    g_assert(inl_per_vcpu == expected);
+}
+
+static void stats_mem(void)
+{
+    const uint64_t expected = global_count_mem;
+    const uint64_t per_vcpu = qemu_plugin_u64_sum(count_mem);
+    const uint64_t inl_per_vcpu =
+        qemu_plugin_u64_sum(count_mem_inline);
+    printf("mem: %" PRIu64 "\n", expected);
+    printf("mem: %" PRIu64 " (per vcpu)\n", per_vcpu);
+    printf("mem: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
+    g_assert(expected > 0);
+    g_assert(per_vcpu == expected);
+    g_assert(inl_per_vcpu == expected);
+}
+
+static void plugin_exit(qemu_plugin_id_t id, void *udata)
+{
+    const unsigned int num_cpus = qemu_plugin_num_vcpus();
+    g_assert(num_cpus == max_cpu_index + 1);
+
+    for (int i = 0; i < num_cpus ; ++i) {
+        const uint64_t tb = qemu_plugin_u64_get(count_tb, i);
+        const uint64_t tb_inline = qemu_plugin_u64_get(count_tb_inline, i);
+        const uint64_t insn = qemu_plugin_u64_get(count_insn, i);
+        const uint64_t insn_inline = qemu_plugin_u64_get(count_insn_inline, i);
+        const uint64_t mem = qemu_plugin_u64_get(count_mem, i);
+        const uint64_t mem_inline = qemu_plugin_u64_get(count_mem_inline, i);
+        printf("cpu %d: tb (%" PRIu64 ", %" PRIu64 ") | "
+               "insn (%" PRIu64 ", %" PRIu64 ") | "
+               "mem (%" PRIu64 ", %" PRIu64 ")"
+               "\n",
+               i, tb, tb_inline, insn, insn_inline, mem, mem_inline);
+        g_assert(tb == tb_inline);
+        g_assert(insn == insn_inline);
+        g_assert(mem == mem_inline);
+    }
+
+    stats_tb();
+    stats_insn();
+    stats_mem();
+
+    qemu_plugin_scoreboard_free(counts);
+}
+
+static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
+{
+    qemu_plugin_u64_add(count_tb, cpu_index, 1);
+    g_mutex_lock(&tb_lock);
+    max_cpu_index = MAX(max_cpu_index, cpu_index);
+    global_count_tb++;
+    g_mutex_unlock(&tb_lock);
+}
+
+static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
+{
+    qemu_plugin_u64_add(count_insn, cpu_index, 1);
+    g_mutex_lock(&insn_lock);
+    global_count_insn++;
+    g_mutex_unlock(&insn_lock);
+}
+
+static void vcpu_mem_access(unsigned int cpu_index,
+                            qemu_plugin_meminfo_t info,
+                            uint64_t vaddr,
+                            void *userdata)
+{
+    qemu_plugin_u64_add(count_mem, cpu_index, 1);
+    g_mutex_lock(&mem_lock);
+    global_count_mem++;
+    g_mutex_unlock(&mem_lock);
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    qemu_plugin_register_vcpu_tb_exec_cb(
+        tb, vcpu_tb_exec, QEMU_PLUGIN_CB_NO_REGS, 0);
+    qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+        tb, QEMU_PLUGIN_INLINE_ADD_U64, count_tb_inline, 1);
+
+    for (int idx = 0; idx < qemu_plugin_tb_n_insns(tb); ++idx) {
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, idx);
+        qemu_plugin_register_vcpu_insn_exec_cb(
+            insn, vcpu_insn_exec, QEMU_PLUGIN_CB_NO_REGS, 0);
+        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+            insn, QEMU_PLUGIN_INLINE_ADD_U64, count_insn_inline, 1);
+        qemu_plugin_register_vcpu_mem_cb(insn, &vcpu_mem_access,
+                                         QEMU_PLUGIN_CB_NO_REGS,
+                                         QEMU_PLUGIN_MEM_RW, 0);
+        qemu_plugin_register_vcpu_mem_inline_per_vcpu(
+            insn, QEMU_PLUGIN_MEM_RW,
+            QEMU_PLUGIN_INLINE_ADD_U64,
+            count_mem_inline, 1);
+    }
+}
+
+QEMU_PLUGIN_EXPORT
+int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
+                        int argc, char **argv)
+{
+    counts = qemu_plugin_scoreboard_new(sizeof(CPUCount));
+    count_tb = qemu_plugin_scoreboard_u64_in_struct(
+        counts, CPUCount, count_tb);
+    count_insn = qemu_plugin_scoreboard_u64_in_struct(
+        counts, CPUCount, count_insn);
+    count_mem = qemu_plugin_scoreboard_u64_in_struct(
+        counts, CPUCount, count_mem);
+    count_tb_inline = qemu_plugin_scoreboard_u64_in_struct(
+        counts, CPUCount, count_tb_inline);
+    count_insn_inline = qemu_plugin_scoreboard_u64_in_struct(
+        counts, CPUCount, count_insn_inline);
+    count_mem_inline = qemu_plugin_scoreboard_u64_in_struct(
+        counts, CPUCount, count_mem_inline);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+
+    return 0;
+}
diff --git a/tests/plugin/meson.build b/tests/plugin/meson.build
index e18183aaeda..9eece5bab51 100644
--- a/tests/plugin/meson.build
+++ b/tests/plugin/meson.build
@@ -1,6 +1,6 @@
 t = []
 if get_option('plugins')
-  foreach i : ['bb', 'empty', 'insn', 'mem', 'syscall']
+  foreach i : ['bb', 'empty', 'inline', 'insn', 'mem', 'syscall']
     if host_os == 'windows'
       t += shared_module(i, files(i + '.c') + '../../contrib/plugins/win32_linker.c',
                         include_directories: '../../include/qemu',
-- 
2.39.2


