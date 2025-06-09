Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB333C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 19:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOiKg-0007Gu-Bi; Mon, 09 Jun 2025 15:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOiKa-0007Ex-Hq
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:38:52 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOiKX-0004Dq-JG
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:38:52 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-747ef5996edso3566248b3a.0
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 12:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749497928; x=1750102728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z0nlYktoATC6j3lpIaHBr3lSUsxpIXbgJCeWazuE310=;
 b=Ae8MiGcPL3w+Yp8JZKyZ51nXBsrEnVfiUCV/xHGcooG+4BV/xQTfyDlOrL1utkwc0N
 RJ4omBQceL9UVi4Ep7PCXWfgJnJTz7UYFzeGexwQ4I8RM++im74j5oI64WYcQBmYQYZ2
 Q/V4sp6pBT4qkS2dF5oW7y9cKusb2GvAWAeVvCFVqi0kqBP8Mvr9lIha9qAaaUWpzlNL
 E0u0vvt0PN8qH6mmgEOifyx0LiRrbOMlso09FCvl9d6eyY0WwsO4rmF73rIVvBYU2Hly
 oKqx521DK7rQgOnXv3fXap3tfBIV6wMZjHqUGXTjRZZR8LszQpBCAiCCxMAtg3mRL5wF
 9w4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749497928; x=1750102728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z0nlYktoATC6j3lpIaHBr3lSUsxpIXbgJCeWazuE310=;
 b=LcEcyQJZ5zXH+t70XoU1Qmmg88v/PeTNkXtbhw7mnzH/NJkx5UAoOycFrz60FlWrdT
 iQrF9yoA4a2bD8w/ri8ufjUYKJmnyMgqNBOSkyCQZ6AqZSeEVvne30A93q8rJiNdn4IK
 YS128pZ1Ok1J+797WqatiAwGeuSP1raZ5lHaGRCouU+2mywZ13CV86ajBz5GNcD91Lxj
 G5sZWvDJ+f4/IvuU+m/KZOMB35EZtqHbhV6buhpXSOHcT4+ui139X+Nj1i+sP1F6NP/5
 uCvyrpTCQm73N7wZ/wvbpM/KTmuiCfvnDn0eFoVp1Ktyo84Nv3AFMKDhDhpeSZkiEpEs
 vxAg==
X-Gm-Message-State: AOJu0Yx7cRKNC1MDRoI3SiQrV5iznwMjOsDRffpAHuPIj37aUwiQMAgH
 zBPYPyCq88hpRsqvPt8HtefSTgVn2jjX0T5smN6jtzIUKZ35epV+kKjzf/P4vZjP
X-Gm-Gg: ASbGncuQxvsx5up6At8yZXqgowUQrsQGpjPMS/V/2OuPX3l1aILhid3ga4AlBt/WyHT
 fVbrsYaIQ2RckLELa2Hf4Cizh/JNvB5O9dySA1YcZv0OnKqZBnKKn128RhO1rDPZB5wI0TQDtWm
 nb8+PxXGzxTTA2WPj207rfcJCQUAEUFhTrKf6E+R1chnxzN1mrweJD7Qy7yOXvvI91XG0StgUGz
 iu9/D1iPXZfHPVXJmHFkHCGqo+ozVhDQN230qqR/9ScpLebZQZzco+thUOjAq9TqTLISEBWNUeG
 NCa5wxjxV/gRsgwr/dzwX250VGZ8fCsIhO7px4232HJdeyqhbfiKU+ScJYM3Gg==
X-Google-Smtp-Source: AGHT+IFHrDbCBowk8Ld3Jen+9d3bsukHuL0I8tZ2rxxAM3lISOta9lB6leWafZng7dLEyB11SIrNGg==
X-Received: by 2002:a05:6a00:3c8c:b0:740:9d6f:a73b with SMTP id
 d2e1a72fcca58-748280ac433mr17528532b3a.17.1749497927856; 
 Mon, 09 Jun 2025 12:38:47 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482b083b03sm6095725b3a.83.2025.06.09.12.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 12:38:47 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Alexandre Iooss <erdnaxe@crans.org>,
 novafacing <rowanbhart@gmail.com>
Subject: [PATCH v11 7/8] plugins: Add hypercalls plugin and test
Date: Mon,  9 Jun 2025 12:38:40 -0700
Message-ID: <20250609193841.348076-8-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609193841.348076-1-rowanbhart@gmail.com>
References: <20250609193841.348076-1-rowanbhart@gmail.com>
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

This patch adds a plugin that implements a simple form of hypercalls
from guest code to the plugin by using the register read API. It accepts
only one hypercall, which writes a magic value to guest memory.

Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 tests/tcg/Makefile.target                     |   1 +
 tests/tcg/plugins/hypercalls.c                | 547 ++++++++++++++++++
 tests/tcg/plugins/meson.build                 |   2 +-
 tests/tcg/x86_64/Makefile.softmmu-target      |   6 +-
 tests/tcg/x86_64/system/hypercalls-target.c   |  40 ++
 .../tcg/x86_64/system/validate-hypercalls.py  |  40 ++
 6 files changed, 634 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/plugins/hypercalls.c
 create mode 100644 tests/tcg/x86_64/system/hypercalls-target.c
 create mode 100755 tests/tcg/x86_64/system/validate-hypercalls.py

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 4b709a9d18..5ac9638102 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -177,6 +177,7 @@ RUN_TESTS+=$(EXTRA_RUNS)
 # exercise things. We can define them on a per-test basis here.
 run-plugin-%-with-libmem.so: PLUGIN_ARGS=$(COMMA)inline=true
 run-plugin-%-with-libpatch.so: PLUGIN_ARGS=$(COMMA)target=ffffffff$(COMMA)patch=00000000
+run-plugin-%-with-libhypercalls.so: PLUGIN_ARGS=$(COMMA)ignore_unsupported=true
 
 ifeq ($(filter %-softmmu, $(TARGET)),)
 run-%: %
diff --git a/tests/tcg/plugins/hypercalls.c b/tests/tcg/plugins/hypercalls.c
new file mode 100644
index 0000000000..3214bb8ee5
--- /dev/null
+++ b/tests/tcg/plugins/hypercalls.c
@@ -0,0 +1,547 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This plugin implements a simple hypercall interface for guests (both system
+ * and user mode) to call certain operations from the host.
+ */
+#include "glib.h"
+#include "glibconfig.h"
+#include <assert.h>
+#include <inttypes.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+#define AARCH64_N_HYPERCALL_INSNS  (28)
+#define AARCH64_HYPERCALL_INSN_LEN (4)
+#define AARCH64_HYPERCALL_MAX (AARCH64_N_HYPERCALL_INSNS)
+#define ARM_N_HYPERCALL_INSNS  (12)
+#define ARM_HYPERCALL_INSN_LEN (4)
+#define ARM_HYPERCALL_MAX (ARM_N_HYPERCALL_INSNS)
+#define X86_HYPERCALL_INSN_LEN (2)
+#define X86_HYPERCALL_VALUE_BASE (0x4711)
+#define X86_HYPERCALL_MAX (0x10000)
+#define N_HYPERCALL_ARGS (4)
+
+static bool ignore_unsupported;
+
+static struct qemu_plugin_register *get_register(const char *name);
+static uint64_t byte_array_to_uint64(GByteArray *buf);
+
+enum HypercallInsnType {
+    CONSTANT,
+    CALLBACK,
+};
+
+
+/*
+ * Checks an instruction and returns its hypercall number, if it is
+ * a hypercall instruction, or -1 if it is not. Called at execution
+ * time.
+ */
+typedef int32_t (*hypercall_nr_cb)(GByteArray *);
+
+/*
+ * Checks an instruction and returns whether it is a hypercall, or -1 if it is
+ * not. Called at execution time.
+ */
+typedef bool (*is_hypercall_cb)(GByteArray *);
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
+    const bool enabled;
+    const char *name;
+    const bool le;
+    const char *args[N_HYPERCALL_ARGS];
+    const hypercall_nr_cb hypercall_nr_cb;
+    const is_hypercall_cb is_hypercall_cb;
+};
+
+static int32_t aarch64_hypercall_nr_cb(GByteArray *insn)
+{
+    if (insn->len != AARCH64_HYPERCALL_INSN_LEN) {
+        return -1;
+    }
+
+    static const uint8_t
+    hypercall_insns[AARCH64_N_HYPERCALL_INSNS][AARCH64_HYPERCALL_INSN_LEN] = {
+        { 0xaa, 0x4, 0x0, 0x84 },
+        { 0xaa, 0x5, 0x0, 0xa5 },
+        { 0xaa, 0x6, 0x0, 0xc6 },
+        { 0xaa, 0x7, 0x0, 0xe7 },
+        { 0xaa, 0x8, 0x1, 0x8 },
+        { 0xaa, 0x9, 0x1, 0x29 },
+        { 0xaa, 0xa, 0x1, 0x4a },
+        { 0xaa, 0xb, 0x1, 0x6b },
+        { 0xaa, 0xc, 0x1, 0x8c },
+        { 0xaa, 0xd, 0x1, 0xad },
+        { 0xaa, 0xe, 0x1, 0xce },
+        { 0xaa, 0xf, 0x1, 0xef },
+        { 0xaa, 0x10, 0x2, 0x10 },
+        { 0xaa, 0x11, 0x2, 0x31 },
+        { 0xaa, 0x12, 0x2, 0x52 },
+        { 0xaa, 0x13, 0x2, 0x73 },
+        { 0xaa, 0x14, 0x2, 0x94 },
+        { 0xaa, 0x15, 0x2, 0xb5 },
+        { 0xaa, 0x16, 0x2, 0xd6 },
+        { 0xaa, 0x17, 0x2, 0xf7 },
+        { 0xaa, 0x18, 0x3, 0x18 },
+        { 0xaa, 0x19, 0x3, 0x39 },
+        { 0xaa, 0x1a, 0x3, 0x5a },
+        { 0xaa, 0x1b, 0x3, 0x7b },
+        { 0xaa, 0x1c, 0x3, 0x9c },
+        { 0xaa, 0x1d, 0x3, 0xbd },
+        { 0xaa, 0x1e, 0x3, 0xde },
+        { 0xaa, 0x1f, 0x3, 0xff },
+    };
+
+    for (int32_t i = 0; i < AARCH64_N_HYPERCALL_INSNS; i++) {
+        if (!memcmp(hypercall_insns[i], insn->data, insn->len)) {
+            return i;
+        }
+    }
+    return -1;
+}
+
+static bool aarch64_is_hypercall_cb(GByteArray *insn)
+{
+    return aarch64_hypercall_nr_cb(insn) < 0;
+}
+
+
+static int32_t aarch64_be_hypercall_nr_cb(GByteArray *insn)
+{
+    if (insn->len != AARCH64_HYPERCALL_INSN_LEN) {
+        return -1;
+    }
+
+    static const uint8_t
+    hypercall_insns[AARCH64_N_HYPERCALL_INSNS][AARCH64_HYPERCALL_INSN_LEN] = {
+        {0x84, 0x0, 0x4, 0xaa},
+        {0xa5, 0x0, 0x5, 0xaa},
+        {0xc6, 0x0, 0x6, 0xaa},
+        {0xe7, 0x0, 0x7, 0xaa},
+        {0x8, 0x1, 0x8, 0xaa},
+        {0x29, 0x1, 0x9, 0xaa},
+        {0x4a, 0x1, 0xa, 0xaa},
+        {0x6b, 0x1, 0xb, 0xaa},
+        {0x8c, 0x1, 0xc, 0xaa},
+        {0xad, 0x1, 0xd, 0xaa},
+        {0xce, 0x1, 0xe, 0xaa},
+        {0xef, 0x1, 0xf, 0xaa},
+        {0x10, 0x2, 0x10, 0xaa},
+        {0x31, 0x2, 0x11, 0xaa},
+        {0x52, 0x2, 0x12, 0xaa},
+        {0x73, 0x2, 0x13, 0xaa},
+        {0x94, 0x2, 0x14, 0xaa},
+        {0xb5, 0x2, 0x15, 0xaa},
+        {0xd6, 0x2, 0x16, 0xaa},
+        {0xf7, 0x2, 0x17, 0xaa},
+        {0x18, 0x3, 0x18, 0xaa},
+        {0x39, 0x3, 0x19, 0xaa},
+        {0x5a, 0x3, 0x1a, 0xaa},
+        {0x7b, 0x3, 0x1b, 0xaa},
+        {0x9c, 0x3, 0x1c, 0xaa},
+        {0xbd, 0x3, 0x1d, 0xaa},
+        {0xde, 0x3, 0x1e, 0xaa},
+        {0xff, 0x3, 0x1f, 0xaa},
+    };
+
+    for (int32_t i = 0; i < AARCH64_N_HYPERCALL_INSNS; i++) {
+        if (!memcmp(hypercall_insns[i], insn->data, insn->len)) {
+            return i;
+        }
+    }
+    return -1;
+}
+
+static bool aarch64_be_is_hypercall_cb(GByteArray *insn)
+{
+    return aarch64_be_hypercall_nr_cb(insn) < 0;
+}
+
+
+static int32_t arm_hypercall_nr_cb(GByteArray *insn)
+{
+    if (insn->len != ARM_HYPERCALL_INSN_LEN) {
+        return -1;
+    }
+
+    static const uint8_t
+    hypercall_insns[ARM_N_HYPERCALL_INSNS][ARM_HYPERCALL_INSN_LEN] = {
+        { 0xe1, 0x84, 0x40, 0x4 },
+        { 0xe1, 0x85, 0x50, 0x5 },
+        { 0xe1, 0x86, 0x60, 0x6 },
+        { 0xe1, 0x87, 0x70, 0x7 },
+        { 0xe1, 0x88, 0x80, 0x8 },
+        { 0xe1, 0x89, 0x90, 0x9 },
+        { 0xe1, 0x8a, 0xa0, 0xa },
+        { 0xe1, 0x8b, 0xb0, 0xb },
+        { 0xe1, 0x8c, 0xc0, 0xc },
+        { 0xe1, 0x8d, 0xd0, 0xd },
+        { 0xe1, 0x8e, 0xe0, 0xe },
+        { 0xe1, 0x8f, 0xf0, 0xf },
+    };
+
+    for (int32_t i = 0; i < ARM_N_HYPERCALL_INSNS; i++) {
+        if (!memcmp(hypercall_insns[i], insn->data, insn->len)) {
+            return i;
+        }
+    }
+    return -1;
+}
+
+static bool arm_is_hypercall_cb(GByteArray *insn)
+{
+    return arm_hypercall_nr_cb(insn) < 0;
+}
+
+static int32_t arm_be_hypercall_nr_cb(GByteArray *insn)
+{
+    if (insn->len != ARM_HYPERCALL_INSN_LEN) {
+        return -1;
+    }
+
+    static const uint8_t
+    hypercall_insns[ARM_N_HYPERCALL_INSNS][ARM_HYPERCALL_INSN_LEN] = {
+        {0x4, 0x40, 0x84, 0xe1},
+        {0x5, 0x50, 0x85, 0xe1},
+        {0x6, 0x60, 0x86, 0xe1},
+        {0x7, 0x70, 0x87, 0xe1},
+        {0x8, 0x80, 0x88, 0xe1},
+        {0x9, 0x90, 0x89, 0xe1},
+        {0xa, 0xa0, 0x8a, 0xe1},
+        {0xb, 0xb0, 0x8b, 0xe1},
+        {0xc, 0xc0, 0x8c, 0xe1},
+        {0xd, 0xd0, 0x8d, 0xe1},
+        {0xe, 0xe0, 0x8e, 0xe1},
+        {0xf, 0xf0, 0x8f, 0xe1},
+    };
+
+    for (int32_t i = 0; i < ARM_N_HYPERCALL_INSNS; i++) {
+        if (!memcmp(hypercall_insns[i], insn->data, insn->len)) {
+            return i;
+        }
+    }
+    return -1;
+}
+
+static bool arm_be_is_hypercall_cb(GByteArray *insn)
+{
+    return arm_be_hypercall_nr_cb(insn) < 0;
+}
+
+static int32_t x86_64_hypercall_nr_cb(GByteArray *insn)
+{
+    if (insn->len != X86_HYPERCALL_INSN_LEN) {
+        return -1;
+    }
+
+    uint8_t cpuid[] = { 0x0f, 0xa2 };
+    if (!memcmp(cpuid, insn->data, insn->len)) {
+        GByteArray *reg = g_byte_array_new();
+        qemu_plugin_read_register(get_register("rax"), reg);
+        uint64_t value = byte_array_to_uint64(reg);
+        g_byte_array_free(reg, true);
+
+        if (!(value & X86_HYPERCALL_VALUE_BASE)) {
+            return -1;
+        }
+
+        value = (value >> 16) & 0xffff;
+
+        if (value >= X86_HYPERCALL_MAX) {
+            return -1;
+        }
+
+        return (int32_t)value;
+    }
+
+    return -1;
+}
+
+static bool x86_64_is_hypercall_cb(GByteArray *insn)
+{
+    if (insn->len != X86_HYPERCALL_INSN_LEN) {
+        return false;
+    }
+
+    uint8_t cpuid[] = { 0x0f, 0xa2 };
+    if (!memcmp(cpuid, insn->data, insn->len)) {
+        return true;
+    }
+
+    return false;
+}
+
+static int32_t i386_hypercall_nr_cb(GByteArray *insn)
+{
+    if (insn->len != X86_HYPERCALL_INSN_LEN) {
+        return -1;
+    }
+
+    uint8_t cpuid[] = { 0x0f, 0xa2 };
+    if (!memcmp(cpuid, insn->data, insn->len)) {
+        GByteArray *reg = g_byte_array_new();
+        qemu_plugin_read_register(get_register("eax"), reg);
+        uint64_t value = byte_array_to_uint64(reg);
+        g_byte_array_free(reg, true);
+
+        if (!(value & X86_HYPERCALL_VALUE_BASE)) {
+            return -1;
+        }
+
+        value = (value >> 16) & 0xffff;
+
+        if (value >= X86_HYPERCALL_MAX) {
+            return -1;
+        }
+        return (int32_t)value;
+    }
+
+    return -1;
+
+}
+
+static bool i386_is_hypercall_cb(GByteArray *insn)
+{
+    if (insn->len != X86_HYPERCALL_INSN_LEN) {
+        return false;
+    }
+
+    uint8_t cpuid[] = { 0x0f, 0xa2 };
+    if (!memcmp(cpuid, insn->data, insn->len)) {
+        return true;
+    }
+
+    return false;
+
+}
+
+static const struct HypercallSpec *hypercall_spec;
+
+static const struct HypercallSpec hypercall_specs[] = {
+    { true, "aarch64", true, {
+            "x0", "x1", "x2", "x3",
+        }, aarch64_hypercall_nr_cb, aarch64_is_hypercall_cb
+    },
+    { true, "aarch64_be", false,  {
+            "x0", "x1", "x2", "x3",
+        }, aarch64_be_hypercall_nr_cb, aarch64_be_is_hypercall_cb
+    },
+    { true, "arm", true,  {
+            "r0", "r1", "r2", "r3",
+        }, arm_hypercall_nr_cb, arm_is_hypercall_cb
+    },
+    { true, "armeb", false,  {
+            "r0", "r1", "r2", "r3"
+        }, arm_be_hypercall_nr_cb, arm_be_is_hypercall_cb
+    },
+    { true, "i386", true, {
+            "edi", "esi", "edx", "ecx"
+        }, i386_hypercall_nr_cb, i386_is_hypercall_cb
+    },
+    { true, "x86_64", true, {
+            "rdi", "rsi", "rdx", "rcx"
+
+        }, x86_64_hypercall_nr_cb, x86_64_is_hypercall_cb
+    },
+    { false, NULL, .le = false,  {NULL, NULL, NULL, NULL}, NULL},
+};
+
+static GArray *hypercall_insns;
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
+    if (hypercall_spec->le) {
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
+ * Handle a "hypercall" instruction, which has some special meaning for this
+ * plugin.
+ */
+static void hypercall(unsigned int vcpu_index, void *userdata)
+{
+    GByteArray *insn_data = (GByteArray *)userdata;
+    int32_t hypercall_nr = hypercall_spec->hypercall_nr_cb(insn_data);
+
+    if (hypercall_nr < 0) {
+        return;
+    }
+
+    uint64_t args[N_HYPERCALL_ARGS] = {0};
+    GByteArray *buf = g_byte_array_new();
+    for (size_t i = 0; i < N_HYPERCALL_ARGS; i++) {
+        g_byte_array_set_size(buf, 0);
+        struct qemu_plugin_register *reg =
+            get_register(hypercall_spec->args[i]);
+        qemu_plugin_read_register(reg, buf);
+        args[i] = byte_array_to_uint64(buf);
+    }
+    g_byte_array_free(buf, true);
+
+    switch (hypercall_nr) {
+    /*
+     * The write hypercall (#0x01) tells the plugin to write random bytes
+     * of a given size into the memory of the emulated system at a particular
+     * vaddr
+     */
+    case 1: {
+        GByteArray *data = g_byte_array_new();
+        g_byte_array_set_size(data, args[1]);
+        for (uint64_t i = 0; i < args[1]; i++) {
+            data->data[i] = (uint8_t)g_random_int();
+        }
+        qemu_plugin_write_memory_vaddr(args[0], data);
+        break;
+    }
+    default:
+        break;
+    }
+}
+
+/*
+ * Callback on translation of a translation block.
+ */
+static void vcpu_tb_trans_cb(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    for (size_t i = 0; i < qemu_plugin_tb_n_insns(tb); i++) {
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
+        GByteArray *insn_data = g_byte_array_new();
+        size_t insn_len = qemu_plugin_insn_size(insn);
+        g_byte_array_set_size(insn_data, insn_len);
+        qemu_plugin_insn_data(insn, insn_data->data, insn_data->len);
+
+        if (hypercall_spec->is_hypercall_cb(insn_data)) {
+            g_array_append_val(hypercall_insns, insn_data);
+            qemu_plugin_register_vcpu_insn_exec_cb(insn, hypercall,
+                                                   QEMU_PLUGIN_CB_R_REGS,
+                                                   (void *)insn_data);
+        } else {
+            g_byte_array_free(insn_data, true);
+        }
+
+    }
+}
+
+static void atexit_cb(qemu_plugin_id_t id, void *userdata)
+{
+    for (size_t i = 0; i < hypercall_insns->len; i++) {
+        g_byte_array_free(g_array_index(hypercall_insns, GByteArray *, i),
+                          true);
+    }
+
+    g_array_free(hypercall_insns, true);
+}
+
+static void usage(void)
+{
+    fprintf(stderr,
+            "Usage: <lib>,[ignore_unsupported=<ignore_unsupported>]");
+}
+
+/*
+ * Called when the plugin is installed
+ */
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info, int argc,
+                                           char **argv)
+{
+    if (argc > 1) {
+        usage();
+        return -1;
+    }
+
+    for (size_t i = 0; i < argc; i++) {
+        char *opt = argv[i];
+        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
+        if (g_strcmp0(tokens[0], "ignore_unsupported") == 0) {
+            if (!qemu_plugin_bool_parse(tokens[0],
+                                    tokens[1], &ignore_unsupported)) {
+                fprintf(stderr,
+                        "Failed to parse argument ignore_unsupported\n");
+                return -1;
+            }
+        } else {
+            fprintf(stderr, "Unknown argument: %s\n", tokens[0]);
+            usage();
+            return -1;
+        }
+    }
+
+
+    hypercall_spec = &hypercall_specs[0];
+
+    while (hypercall_spec->name != NULL) {
+        if (!strcmp(hypercall_spec->name, info->target_name)) {
+            break;
+        }
+        hypercall_spec++;
+    }
+
+    if (hypercall_spec->name == NULL || !hypercall_spec->enabled) {
+        qemu_plugin_outs("Error: no hypercall spec.");
+        if (ignore_unsupported) {
+            return 0;
+        }
+        return -1;
+    }
+
+    hypercall_insns = g_array_new(true, true, sizeof(GByteArray *));
+
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans_cb);
+    qemu_plugin_register_atexit_cb(id, atexit_cb, NULL);
+
+    return 0;
+}
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index 163042e601..909bf3005a 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -1,6 +1,6 @@
 t = []
 if get_option('plugins')
-  foreach i : ['bb', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall', 'patch']
+  foreach i : ['bb', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall', 'hypercalls', 'patch']
     if host_os == 'windows'
       t += shared_module(i, files(i + '.c') + '../../../contrib/plugins/win32_linker.c',
                         include_directories: '../../../include/qemu',
diff --git a/tests/tcg/x86_64/Makefile.softmmu-target b/tests/tcg/x86_64/Makefile.softmmu-target
index 8d3a067c33..8cb2a19461 100644
--- a/tests/tcg/x86_64/Makefile.softmmu-target
+++ b/tests/tcg/x86_64/Makefile.softmmu-target
@@ -46,14 +46,18 @@ EXTRA_RUNS+=$(MULTIARCH_RUNS)
 
 memory: CFLAGS+=-DCHECK_UNALIGNED=1
 patch-target: CFLAGS+=-O0
+hypercalls-target: CFLAGS+=-O0
 
 # Running
 QEMU_OPTS+=-device isa-debugcon,chardev=output -device isa-debug-exit,iobase=0xf4,iosize=0x4 -kernel
 
 # Add patch-target to ADDITIONAL_PLUGINS_TESTS
 ADDITIONAL_PLUGINS_TESTS += patch-target
+ADDITIONAL_PLUGINS_TESTS += hypercalls-target
 
 run-plugin-patch-target-with-libpatch.so:		\
 	PLUGIN_ARGS=$(COMMA)target=ffc0$(COMMA)patch=9090$(COMMA)use_hwaddr=true$(COMMA)debug_insns=false
 run-plugin-patch-target-with-libpatch.so:		\
-	CHECK_PLUGIN_OUTPUT_COMMAND=$(X86_64_SYSTEM_SRC)/validate-patch.py $@.out
\ No newline at end of file
+	CHECK_PLUGIN_OUTPUT_COMMAND=$(X86_64_SYSTEM_SRC)/validate-patch.py $@.out
+run-plugin-hypercalls-target-with-libhypercalls.so:		\
+	CHECK_PLUGIN_OUTPUT_COMMAND=$(X86_64_SYSTEM_SRC)/validate-hypercalls.py $@.out
diff --git a/tests/tcg/x86_64/system/hypercalls-target.c b/tests/tcg/x86_64/system/hypercalls-target.c
new file mode 100644
index 0000000000..acb6d695f2
--- /dev/null
+++ b/tests/tcg/x86_64/system/hypercalls-target.c
@@ -0,0 +1,40 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This test target invokes a hypercall to write the value 0x1337 to a
+ * variable.
+ *
+ */
+#include <stddef.h>
+#include <stdint.h>
+#include <minilib.h>
+
+#define _hypercall(num, arg0, arg1, arg2, arg3)                      \
+    unsigned int a __attribute__((unused)) = 0;                     \
+    unsigned int b __attribute__((unused)) = 0;                     \
+    unsigned int c __attribute__((unused)) = 0;                     \
+    unsigned int d __attribute__((unused)) = 0;                     \
+    __asm__ __volatile__("cpuid\n\t"                                \
+                         : "=a"(a), "=b"(b), "=c"(c), "=d"(d)       \
+                         : "a"(num), "D"(arg0), "S"(arg1), \
+                           "d"(arg2), "c"(arg3));
+
+#define hypercall(num, arg0, arg1, arg2, arg3) \
+    { \
+        unsigned int __num = 0x4711 | (num << 16); \
+        _hypercall(__num, arg0, arg1, arg2, arg3); \
+    }
+
+int main(void)
+{
+    uint16_t value = 0;
+
+    for (size_t i = 0; i < 1000000; i++) {
+        hypercall(1, &value, sizeof(value), 0, 0);
+        if (value == 0x1337) {
+            ml_printf("Victory!\n");
+            return 0;
+        }
+    }
+    return 0;
+}
diff --git a/tests/tcg/x86_64/system/validate-hypercalls.py b/tests/tcg/x86_64/system/validate-hypercalls.py
new file mode 100755
index 0000000000..6e7c980706
--- /dev/null
+++ b/tests/tcg/x86_64/system/validate-hypercalls.py
@@ -0,0 +1,40 @@
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
+
+    if "Victory" in test_data:
+        sys.exit(0)
+    else:
+        sys.exit(1)
+
+if __name__ == "__main__":
+    main()
+
-- 
2.49.0


