Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C376EE77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 10:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJVXR-0006MP-Fx; Fri, 06 Dec 2024 05:26:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1tJVXK-0006He-K9
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 05:26:15 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1tJVXH-0004Rr-TO
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 05:26:13 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-725b3b9fa6cso952255b3a.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 02:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733480770; x=1734085570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0gntkKupC4lTPUOVbKLaIg1HZfIBbFfwjMRRBqmCiaE=;
 b=Tp7pl0B0EwbRZ0DbpwOJKo6qyZX4HUBk4P5PVWOlJYQDEmcSR+gatak0KQSHUdNzK6
 3ZxpTf4XaD32uWoDbDLQ4Nw1q9FAEKtsT3ttryDSLTdhQ8vNPup+eQiNL0mocrFfrcf6
 gvc/pesL39IGjWw82Km5nzBR/2vejL5QhJqYiNc2k7xfn8jgm4IG53it9lhsbhiyqeQx
 xcxVO3/VV4GxBLXKAF6xSbpctAbKGjVN61zMcV+2DZwlkiOb5vB7+2IpT2kjPultWQbO
 E8hrne1GGFkf10DsT0/cYOqILnFxirWlf+YS6DvM7vlY+fl1LboTfC/2iqtWd/d82qHr
 4SZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733480770; x=1734085570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0gntkKupC4lTPUOVbKLaIg1HZfIBbFfwjMRRBqmCiaE=;
 b=uakLgegXUB9jBh+fboQkdM69NE21TfhWTpD5BEjWNBW8fjf9YCM7pSMvh1Vg8LM3oB
 ZT6MRWyd6CEYDwwvPAqZDAybvdXKN4Sh5W44nylqh+02HaX0rEpq1j4GOgqWeeIRxopb
 6YHEc1lGcuG5TcOFFKQ7WYlmP9jmhrUVkuj8J/qDNuHl4zTRnDkYn/PaFEgbF6mCiaw+
 OnIQiD2YNV75kO8nxR/nalyq7E+JSitXcfwGAS+1gz3PBBFX74n7CVPi7XW/eGLVUizD
 4En606ixpWCixsz49m5iSCt3mRhBBHSHwBV85CsDlyu90Y+411AA8I3R4xgKdAHpmpcf
 w3gQ==
X-Gm-Message-State: AOJu0YwJuojSqHUEXW+Uf22URQCuwc2scaBjx8flmMgrgHb4oo0QH04x
 YQr3ZHHN++MfzOxXv2fg6j6+R4e1Sl+KM1yy3whdWb+4kJhpAn81r9dGg+zGH4E=
X-Gm-Gg: ASbGnct3YgXhsmH3wfPTcsYrcMYPu8lwro6KpmoSYsDv5RpuABICMfB1E76r0yHwz3y
 j6cAog2emC+BKdywRFJdzJ0WYgKu6+Btqdn9povGjgOj5oHzh+Os6S0LLFRPjLp8A/sbZVB5E2E
 nOBsAhEHi5eU5EHAr552LgzeFiTHBu81cr/pp0A4LzQ2nbuhnRfF2ep8bC+EkhsAKuf6Bm1XRLp
 +W385mMRrzs16ph2Ni7O03QFex2BgJ+QVVSh7R8kKsu+sE=
X-Google-Smtp-Source: AGHT+IH1jFb7dB3GAONJHhEZqDpKOW/irqFMks5vvjiJnFhYGJaSnu5R0mfXDHz9+w9zKkKPTUhcZw==
X-Received: by 2002:a17:902:da8f:b0:215:9894:5670 with SMTP id
 d9443c01a7336-21614d44589mr30219005ad.16.1733480769929; 
 Fri, 06 Dec 2024 02:26:09 -0800 (PST)
Received: from chaos.lan ([50.39.253.148]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8e3e452sm25934885ad.43.2024.12.06.02.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 02:26:09 -0800 (PST)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 novafacing <rowanbhart@gmail.com>
Subject: [PATCH v2 3/3] Add inject plugin and x86_64 target for the inject
 plugin
Date: Fri,  6 Dec 2024 02:26:04 -0800
Message-ID: <20241206102605.961658-4-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241206102605.961658-1-rowanbhart@gmail.com>
References: <20241206102605.961658-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: novafacing <rowanbhart@gmail.com>

---
 tests/tcg/plugins/inject.c       | 206 +++++++++++++++++++++++++++++++
 tests/tcg/plugins/meson.build    |   2 +-
 tests/tcg/x86_64/Makefile.target |   1 +
 tests/tcg/x86_64/inject-target.c |  27 ++++
 4 files changed, 235 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/plugins/inject.c
 create mode 100644 tests/tcg/x86_64/inject-target.c

diff --git a/tests/tcg/plugins/inject.c b/tests/tcg/plugins/inject.c
new file mode 100644
index 0000000000..9edc2cd34e
--- /dev/null
+++ b/tests/tcg/plugins/inject.c
@@ -0,0 +1,206 @@
+/*
+ * Copyright (C) 2024, Rowan Hart <rowanbhart@gmail.com>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+#include "glib.h"
+#include <assert.h>
+#include <inttypes.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <qemu-plugin.h>
+
+/*
+ * Specifies a Hypercall for an architecture:
+ *
+ * - Architecture name
+ * - Whether it is enabled
+ * - The hypercall instruction
+ * - The register names to pass the hypercall # and args
+ */
+struct HypercallSpec {
+    const char *name;
+    const bool enabled;
+    const char *hypercall;
+    const bool little_endian;
+    const char *num_reg;
+    const char *arg0_reg;
+    const char *arg1_reg;
+};
+
+static const struct HypercallSpec *hypercall_spec;
+
+static const struct HypercallSpec hypercall_specs[] = {
+    { "aarch64", false, NULL, true, 0, 0, 0 },
+    { "aarch64_be", false, NULL, false, 0, 0, 0 },
+    { "alpha", false, NULL, true, 0, 0, 0 },
+    { "arm", false, NULL, true, 0, 0, 0 },
+    { "armeb", false, NULL, false, 0, 0, 0 },
+    { "avr", false, NULL, true, 0, 0, 0 },
+    { "hexagon", false, NULL, true, 0, 0, 0 },
+    { "hppa", false, NULL, false, 0, 0, 0 },
+    { "i386", false, NULL, true, 0, 0, 0 },
+    { "loongarch64", false, NULL, true, 0, 0, 0 },
+    { "m68k", false, NULL, false, 0, 0, 0 },
+    { "microblaze", false, NULL, false, 0, 0, 0 },
+    { "microblazeel", false, NULL, true, 0, 0, 0 },
+    { "mips", false, NULL, false, 0, 0, 0 },
+    { "mips64", false, NULL, false, 0, 0, 0 },
+    { "mips64el", false, NULL, true, 0, 0, 0 },
+    { "mipsel", false, NULL, true, 0, 0, 0 },
+    { "mipsn32", false, NULL, false, 0, 0, 0 },
+    { "mipsn32el", false, NULL, true, 0, 0, 0 },
+    { "or1k", false, NULL, false, 0, 0, 0 },
+    { "ppc", false, NULL, false, 0, 0, 0 },
+    { "ppc64", false, NULL, false, 0, 0, 0 },
+    { "ppc64le", false, NULL, true, 0, 0, 0 },
+    { "riscv32", false, NULL, true, 0, 0, 0 },
+    { "riscv64", false, NULL, true, 0, 0, 0 },
+    { "rx", false, NULL, true, 0, 0, 0 },
+    { "s390x", false, NULL, false, 0, 0, 0 },
+    { "sh4", false, NULL, true, 0, 0, 0 },
+    { "sh4eb", false, NULL, false, 0, 0, 0 },
+    { "sparc", false, NULL, false, 0, 0, 0 },
+    { "sparc32plus", false, NULL, false, 0, 0, 0 },
+    { "sparc64", false, NULL, false, 0, 0, 0 },
+    { "tricore", false, NULL, true, 0, 0, 0 },
+    { "x86_64", true, "\x0f\xa2", true, "rax", "rdi", "rsi" },
+    { "xtensa", false, NULL, true, 0, 0, 0 },
+    { "xtensaeb", false, NULL, false, 0, 0, 0 },
+    { NULL, false, NULL, false, 0, 0, 0 },
+};
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+/*
+ * Returns a handle to a register with a given name, or NULL if there is no
+ * such register.
+ */
+static struct qemu_plugin_register *get_register(const char *name)
+{
+    GArray *registers = qemu_plugin_get_registers();
+
+    struct qemu_plugin_register *handle = NULL;
+
+    qemu_plugin_reg_descriptor *reg_descriptors =
+        (qemu_plugin_reg_descriptor *)registers->data;
+
+    for (size_t i = 0; i < registers->len; i++) {
+        if (!strcmp(reg_descriptors[i].name, name)) {
+            handle = reg_descriptors[i].handle;
+        }
+    }
+
+    g_array_free(registers, true);
+
+    return handle;
+}
+
+/*
+ * Transforms a byte array with at most 8 entries into a uint64_t
+ * depending on the target machine's endianness.
+ */
+static uint64_t byte_array_to_uint64(GByteArray *buf)
+{
+    uint64_t value = 0;
+    if (hypercall_spec->little_endian) {
+        for (int i = 0; i < buf->len && i < sizeof(uint64_t); i++) {
+            value |= ((uint64_t)buf->data[i]) << (i * 8);
+        }
+    } else {
+        for (int i = 0; i < buf->len && i < sizeof(uint64_t); i++) {
+            value |= ((uint64_t)buf->data[i]) << ((buf->len - 1 - i) * 8);
+        }
+    }
+    return value;
+}
+
+/*
+ * Handle a "hyperacll" instruction, which has some special meaning for this
+ * plugin.
+ */
+static void hypercall(unsigned int vcpu_index, void *userdata)
+{
+    uint64_t num = 0, arg0 = 0, arg1 = 0;
+    GByteArray *buf = g_byte_array_new();
+    qemu_plugin_read_register(get_register(hypercall_spec->num_reg), buf);
+    num = byte_array_to_uint64(buf);
+
+    g_byte_array_set_size(buf, 0);
+    qemu_plugin_read_register(get_register(hypercall_spec->arg0_reg), buf);
+    arg0 = byte_array_to_uint64(buf);
+
+    g_byte_array_set_size(buf, 0);
+    qemu_plugin_read_register(get_register(hypercall_spec->arg1_reg), buf);
+    arg1 = byte_array_to_uint64(buf);
+
+    switch (num) {
+    /*
+     * The write hypercall (#0x13371337) tells the plugin to write random bytes
+     * of a given size into the memory of the emulated system at a particular
+     * vaddr
+     */
+    case 0x13371337: {
+        GByteArray *data = g_byte_array_new();
+        g_byte_array_set_size(data, arg1);
+        for (uint64_t i = 0; i < arg1; i++) {
+            data->data[i] = (uint8_t)g_random_int();
+        }
+        qemu_plugin_write_memory_vaddr(arg0, data);
+        break;
+    }
+    default:
+        break;
+    }
+
+    g_byte_array_free(buf, TRUE);
+}
+
+/*
+ * Callback on translation of a translation block.
+ */
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    for (size_t i = 0; i < qemu_plugin_tb_n_insns(tb); i++) {
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
+        GByteArray *insn_data = g_byte_array_new();
+        size_t insn_len = qemu_plugin_insn_size(insn);
+        g_byte_array_set_size(insn_data, insn_len);
+        qemu_plugin_insn_data(insn, insn_data->data, insn_data->len);
+        if (!memcmp(insn_data->data, hypercall_spec->hypercall, insn_data->len)) {
+            qemu_plugin_register_vcpu_insn_exec_cb(insn, hypercall,
+                                                   QEMU_PLUGIN_CB_R_REGS, NULL);
+        }
+        g_byte_array_free(insn_data, true);
+    }
+}
+
+
+/*
+ * Called when the plugin is installed
+ */
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info, int argc,
+                                           char **argv)
+{
+    hypercall_spec = &hypercall_specs[0];
+    while (hypercall_spec->name != NULL) {
+        if (!strcmp(hypercall_spec->name, info->target_name)) {
+            break;
+        }
+        hypercall_spec++;
+    }
+
+    if (hypercall_spec->name == NULL) {
+        qemu_plugin_outs("Error: no hypercall spec.");
+        return -1;
+    }
+
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+
+    return 0;
+}
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index f847849b1b..96782416d3 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -1,6 +1,6 @@
 t = []
 if get_option('plugins')
-  foreach i : ['bb', 'empty', 'inline', 'insn', 'mem', 'syscall']
+  foreach i : ['bb', 'empty', 'inline', 'insn', 'mem', 'syscall', 'inject']
     if host_os == 'windows'
       t += shared_module(i, files(i + '.c') + '../../../contrib/plugins/win32_linker.c',
                         include_directories: '../../../include/qemu',
diff --git a/tests/tcg/x86_64/Makefile.target b/tests/tcg/x86_64/Makefile.target
index d6dff559c7..7c8e21636d 100644
--- a/tests/tcg/x86_64/Makefile.target
+++ b/tests/tcg/x86_64/Makefile.target
@@ -18,6 +18,7 @@ X86_64_TESTS += adox
 X86_64_TESTS += test-1648
 X86_64_TESTS += test-2175
 X86_64_TESTS += cross-modifying-code
+X86_64_TESTS += inject-target
 TESTS=$(MULTIARCH_TESTS) $(X86_64_TESTS) test-x86_64
 else
 TESTS=$(MULTIARCH_TESTS)
diff --git a/tests/tcg/x86_64/inject-target.c b/tests/tcg/x86_64/inject-target.c
new file mode 100644
index 0000000000..c886e5ab8b
--- /dev/null
+++ b/tests/tcg/x86_64/inject-target.c
@@ -0,0 +1,27 @@
+#include <stddef.h>
+#include <stdint.h>
+#include <stdio.h>
+
+#define hypercall(num, arg0, arg1)                                \
+    unsigned int _a __attribute__((unused)) = 0;                  \
+    unsigned int _b __attribute__((unused)) = 0;                  \
+    unsigned int _c __attribute__((unused)) = 0;                  \
+    unsigned int _d __attribute__((unused)) = 0;                  \
+    __asm__ __volatile__("cpuid\n\t"                              \
+                         : "=a"(_a), "=b"(_b), "=c"(_c), "=d"(_d) \
+                         : "a"(num), "D"(arg0), "S"(arg1));
+
+int main(void)
+{
+    uint16_t value;
+
+    for (size_t i = 0; i < 1000000; i++) {
+        hypercall(0x13371337, &value, sizeof(value));
+        if (value == 0x1337) {
+            printf("Victory!\n");
+            return 0;
+        }
+    }
+    return 1;
+}
+
-- 
2.46.1


