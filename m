Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EF21094474
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 14:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3x5n-0006Nl-4T; Sat, 21 Mar 2026 10:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3x5i-0006Li-4g
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 10:14:15 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3x5f-0003mF-35
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 10:14:13 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-8299f1ca894so1785428b3a.2
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2026 07:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774102450; x=1774707250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jiwdrJNDFg1OgiJNKsCj9IdOduRF8mocY80E3W+1o2E=;
 b=ZlA+5zRG1EsyloF+5YCtSw90d0QUlDkRwvugG53s7kj6Uzpbmm/Y+WiD9S/9EpcEan
 OIkaoKNOCE6gLAiccyb94MTTo8PlIWQr4QiJXe0AoTgi+kNA5h3dl4IDOJua7FSIYDFz
 mExaH/ints8wQhIJ447ev6APAG2g8uU52QoFsFMzobQRg87MXOzekrso2Qw45Z2t+Q/Y
 SNondEm8jLiDqYUPbFZuZhRAIdaPdTlPF+t4Ab5Ke/auU6OYIhVj0drgeYdaZ8kH0ma1
 IlShn+66Osmk/yfX/1G2ldW/SE5xCkOc24nG7bxU20Odtce6bVGWrzUsdmbjft4oHfVL
 AQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774102450; x=1774707250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jiwdrJNDFg1OgiJNKsCj9IdOduRF8mocY80E3W+1o2E=;
 b=A3U/qZnUXLkEaGawVdGwxXEfDze9EezcORDBg/FlskKguLUocTPvYJwXqDdXSDk+3Z
 WLkmjRfmRiJoNZQtKZxVlMSPXJOBp+5aMLst/55xIIDPYx2HDwXJsJt2I6jTHzlGmg7f
 f1CdOXT2Vvgv/RjwXlfWJpe5teZi/EcKA5sOPNhwX/qKSMiM3f0lkQbY2LYVi03GjRUj
 8v+9J1i0SmAneFb6ZjqTNJp00ym7rZf9Pz70+1mL8PAECLDy8GaMmS2UN86Y6o4WLRc5
 fDYhi7VJAbqoVXr/m6RcdiswUZs3lvWSpQDdLnTVTfRbVLyoUr0pTsZwVCvTXCjc42Ip
 O2Bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5yJ7aCw9beOspt37aNMmcqY5zWm/2IWmQn3vxd03qpeev/+GkOLG+HpQ1UioNieTpq4nMnjUxEOQI@nongnu.org
X-Gm-Message-State: AOJu0YwTsjU27s4BmmDDhgpQM2+wWGx3+D1J4+brZMesjgNP+eYzRiTO
 22JonBJB/ZVlsioDnJ5JkC1lRh3DD7WMFT6MV13u7dZZPF6by6m7kv9O
X-Gm-Gg: ATEYQzzu5UzZYQDQcoknyXJDNoPP58Bdk165gg1VwBJbLcvrBqTqfoFIqaSLoub5LE7
 pnxynRr3o6hTxiCsVglKIH0rWPNd6XGtgLivoFz3uFmQpurzvMAHuZbd8L74tBD+LzSSDrwBoYC
 QUC2s79+9PQ/LN02KDe05QZ8nDP8FOf+1cGaVMkOZSXhRWsjnDpz5YOTCiNUbBCrecw2IiVLR8H
 Z/kr+apS7RD3PhMegB37JvGYh5jk38bGQzXTLA2F+kELg3gitsA7c9+IFuOTwCzuNYG13weai3L
 xraquA+CuRvnAy4bVbeFVGF9/tjZwgOPk5/Ngacckz7+XQgVrQZpDZ2U5grGLEhIX+LiOF25DaG
 kPeZ09Mpsvdh+Unzn5TtJl6hAjLW07brb5kVjimOUao9hk0ZR+ZcvZ4SQtcHvF357gv3Nm4jSfe
 aeNcNV+K0SxjOybRs1YZFRovmOCXRhF/cKLO04164pA/SGcVlJVYIbxfF7QU/mH5A5d8kD
X-Received: by 2002:aa7:9e41:0:b0:82b:4a85:3e2f with SMTP id
 d2e1a72fcca58-82b4a854131mr3350503b3a.41.1774102449552; 
 Sat, 21 Mar 2026 07:14:09 -0700 (PDT)
Received: from lima-default (103.95.112.190.qld.leaptel.network.
 [103.95.112.190]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b040debf9sm4764875b3a.47.2026.03.21.07.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 07:14:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Joel Stanley <joel@jms.id.au>
Subject: [PATCH v3 1/5] tests/tcg/riscv64: Add a user signal handling test
Date: Sun, 22 Mar 2026 00:13:39 +1000
Message-ID: <20260321141345.599105-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260321141345.599105-1-npiggin@gmail.com>
References: <20260321141345.599105-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a few basic signal handling tests for user emulation.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/tcg/riscv64/Makefile.target        |   5 +
 tests/tcg/riscv64/test-signal-handling.c | 303 +++++++++++++++++++++++
 2 files changed, 308 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-signal-handling.c

diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefile.target
index 4da5b9a3b3..f318891396 100644
--- a/tests/tcg/riscv64/Makefile.target
+++ b/tests/tcg/riscv64/Makefile.target
@@ -18,3 +18,8 @@ TESTS += test-fcvtmod
 test-fcvtmod: CFLAGS += -march=rv64imafdc
 test-fcvtmod: LDFLAGS += -static
 run-test-fcvtmod: QEMU_OPTS += -cpu rv64,d=true,zfa=true
+
+# Test signal handling.
+TESTS += test-signal-handling
+test-signal-handling: CFLAGS += -march=rv64gc
+run-test-signal-handling: QEMU_OPTS += -cpu rv64
diff --git a/tests/tcg/riscv64/test-signal-handling.c b/tests/tcg/riscv64/test-signal-handling.c
new file mode 100644
index 0000000000..c202503382
--- /dev/null
+++ b/tests/tcg/riscv64/test-signal-handling.c
@@ -0,0 +1,303 @@
+/*
+ * Test for linux-user signal handling.
+ *
+ * This ensures that integer and fp register values are
+ * saved as expected in the sigcontext, created by a SIGILL.
+ *
+ * TODO: Register restore is not explicitly verified, except
+ * for advancing pc, and the restoring of registers that were
+ * clobbered by the compiler in the signal handler.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <execinfo.h>
+#include <unistd.h>
+#include <assert.h>
+#include <sys/mman.h>
+#include <ucontext.h>
+#include <asm/sigcontext.h>
+
+/*
+ * This horrible hack seems to be required when including
+ * signal.h and asm/sigcontext.h, to prevent sigcontext
+ * redefinition by bits/sigcontext.h :(
+ *
+ * bits/sigcontext.h does not have the extended state or
+ * RISCV_V_MAGIC, etc. It could have just been introduced
+ * as a new type.
+ */
+#define _BITS_SIGCONTEXT_H 1
+#include <signal.h>
+
+static uint64_t *initial_gvalues;
+static uint64_t *final_gvalues;
+static uint64_t *signal_gvalues;
+static double *initial_fvalues;
+static double *final_fvalues;
+static double *signal_fvalues;
+
+extern unsigned long unimp_addr[];
+
+static bool got_signal = false;
+
+#define BT_BUF_SIZE 100
+
+static void *find_callchain_root(void)
+{
+   int nptrs;
+   void *buffer[BT_BUF_SIZE];
+
+   nptrs = backtrace(buffer, BT_BUF_SIZE);
+
+   return buffer[nptrs - 1];
+}
+
+static void *callchain_root;
+
+static void ILL_handler(int signo, siginfo_t *info, void *context)
+{
+    ucontext_t *uc = context;
+    struct sigcontext *sc = (struct sigcontext *)&uc->uc_mcontext;
+
+    got_signal = true;
+
+    assert(unimp_addr == info->si_addr);
+    assert(sc->sc_regs.pc == (unsigned long)info->si_addr);
+
+    /* Ensure stack unwind through the signal frame is not broken */
+    assert(callchain_root == find_callchain_root());
+
+    for (int i = 0; i < 31; i++) {
+        ((uint64_t *)signal_gvalues)[i] = ((unsigned long *)&sc->sc_regs.ra)[i];
+    }
+
+    for (int i = 0; i < 32; i++) {
+        ((uint64_t *)signal_fvalues)[i] = sc->sc_fpregs.d.f[i];
+    }
+    /* Test sc->sc_fpregs.d.fcsr ? */
+
+    sc->sc_regs.pc += 4;
+}
+
+static void init_test(void)
+{
+    int i;
+
+    callchain_root = find_callchain_root();
+
+    initial_gvalues = malloc(8 * 31);
+    memset(initial_gvalues, 0, 8 * 31);
+    final_gvalues = malloc(8 * 31);
+    memset(final_gvalues, 0, 8 * 31);
+    signal_gvalues = malloc(8 * 31);
+    memset(signal_gvalues, 0, 8 * 31);
+
+    initial_fvalues = malloc(8 * 32);
+    memset(initial_fvalues, 0, 8 * 32);
+    for (i = 0; i < 32 ; i++) {
+        initial_fvalues[i] = 3.142 * (i + 1);
+    }
+    final_fvalues = malloc(8 * 32);
+    memset(final_fvalues, 0, 8 * 32);
+    signal_fvalues = malloc(8 * 32);
+    memset(signal_fvalues, 0, 8 * 32);
+}
+
+static void run_test(void)
+{
+    asm volatile(
+    /* Save initial values from gp registers */
+    "mv    t0, %[initial_gvalues]\n\t"
+    "sd    x1, 0x0(t0)\n\t"
+    "sd    x2, 0x8(t0)\n\t"
+    "sd    x3, 0x10(t0)\n\t"
+    "sd    x4, 0x18(t0)\n\t"
+    "sd    x5, 0x20(t0)\n\t"
+    "sd    x6, 0x28(t0)\n\t"
+    "sd    x7, 0x30(t0)\n\t"
+    "sd    x8, 0x38(t0)\n\t"
+    "sd    x9, 0x40(t0)\n\t"
+    "sd    x10, 0x48(t0)\n\t"
+    "sd    x11, 0x50(t0)\n\t"
+    "sd    x12, 0x58(t0)\n\t"
+    "sd    x13, 0x60(t0)\n\t"
+    "sd    x14, 0x68(t0)\n\t"
+    "sd    x15, 0x70(t0)\n\t"
+    "sd    x16, 0x78(t0)\n\t"
+    "sd    x17, 0x80(t0)\n\t"
+    "sd    x18, 0x88(t0)\n\t"
+    "sd    x19, 0x90(t0)\n\t"
+    "sd    x20, 0x98(t0)\n\t"
+    "sd    x21, 0xa0(t0)\n\t"
+    "sd    x22, 0xa8(t0)\n\t"
+    "sd    x23, 0xb0(t0)\n\t"
+    "sd    x24, 0xb8(t0)\n\t"
+    "sd    x25, 0xc0(t0)\n\t"
+    "sd    x26, 0xc8(t0)\n\t"
+    "sd    x27, 0xd0(t0)\n\t"
+    "sd    x28, 0xd8(t0)\n\t"
+    "sd    x29, 0xe0(t0)\n\t"
+    "sd    x30, 0xe8(t0)\n\t"
+    "sd    x31, 0xf0(t0)\n\t"
+    /* Load initial values into float registers */
+    "mv    t0, %[initial_fvalues]\n\t"
+    "fld    f0, 0x0(t0)\n\t"
+    "fld    f1, 0x8(t0)\n\t"
+    "fld    f2, 0x10(t0)\n\t"
+    "fld    f3, 0x18(t0)\n\t"
+    "fld    f4, 0x20(t0)\n\t"
+    "fld    f5, 0x28(t0)\n\t"
+    "fld    f6, 0x30(t0)\n\t"
+    "fld    f7, 0x38(t0)\n\t"
+    "fld    f8, 0x40(t0)\n\t"
+    "fld    f9, 0x48(t0)\n\t"
+    "fld    f10, 0x50(t0)\n\t"
+    "fld    f11, 0x58(t0)\n\t"
+    "fld    f12, 0x60(t0)\n\t"
+    "fld    f13, 0x68(t0)\n\t"
+    "fld    f14, 0x70(t0)\n\t"
+    "fld    f15, 0x78(t0)\n\t"
+    "fld    f16, 0x80(t0)\n\t"
+    "fld    f17, 0x88(t0)\n\t"
+    "fld    f18, 0x90(t0)\n\t"
+    "fld    f19, 0x98(t0)\n\t"
+    "fld    f20, 0xa0(t0)\n\t"
+    "fld    f21, 0xa8(t0)\n\t"
+    "fld    f22, 0xb0(t0)\n\t"
+    "fld    f23, 0xb8(t0)\n\t"
+    "fld    f24, 0xc0(t0)\n\t"
+    "fld    f25, 0xc8(t0)\n\t"
+    "fld    f26, 0xd0(t0)\n\t"
+    "fld    f27, 0xd8(t0)\n\t"
+    "fld    f28, 0xe0(t0)\n\t"
+    "fld    f29, 0xe8(t0)\n\t"
+    "fld    f30, 0xf0(t0)\n\t"
+    "fld    f31, 0xf8(t0)\n\t"
+    /* Trigger the SIGILL */
+".global unimp_addr\n\t"
+"unimp_addr:\n\t"
+    "unimp\n\t"
+    "nop\n\t"
+    /* Save final values from gp registers */
+    "mv    t0, %[final_gvalues]\n\t"
+    "sd    x1, 0x0(t0)\n\t"
+    "sd    x2, 0x8(t0)\n\t"
+    "sd    x3, 0x10(t0)\n\t"
+    "sd    x4, 0x18(t0)\n\t"
+    "sd    x5, 0x20(t0)\n\t"
+    "sd    x6, 0x28(t0)\n\t"
+    "sd    x7, 0x30(t0)\n\t"
+    "sd    x8, 0x38(t0)\n\t"
+    "sd    x9, 0x40(t0)\n\t"
+    "sd    x10, 0x48(t0)\n\t"
+    "sd    x11, 0x50(t0)\n\t"
+    "sd    x12, 0x58(t0)\n\t"
+    "sd    x13, 0x60(t0)\n\t"
+    "sd    x14, 0x68(t0)\n\t"
+    "sd    x15, 0x70(t0)\n\t"
+    "sd    x16, 0x78(t0)\n\t"
+    "sd    x17, 0x80(t0)\n\t"
+    "sd    x18, 0x88(t0)\n\t"
+    "sd    x19, 0x90(t0)\n\t"
+    "sd    x20, 0x98(t0)\n\t"
+    "sd    x21, 0xa0(t0)\n\t"
+    "sd    x22, 0xa8(t0)\n\t"
+    "sd    x23, 0xb0(t0)\n\t"
+    "sd    x24, 0xb8(t0)\n\t"
+    "sd    x25, 0xc0(t0)\n\t"
+    "sd    x26, 0xc8(t0)\n\t"
+    "sd    x27, 0xd0(t0)\n\t"
+    "sd    x28, 0xd8(t0)\n\t"
+    "sd    x29, 0xe0(t0)\n\t"
+    "sd    x30, 0xe8(t0)\n\t"
+    "sd    x31, 0xf0(t0)\n\t"
+    /* Save final values from float registers */
+    "mv    t0, %[final_fvalues]\n\t"
+    "fsd    f0, 0x0(t0)\n\t"
+    "fsd    f1, 0x8(t0)\n\t"
+    "fsd    f2, 0x10(t0)\n\t"
+    "fsd    f3, 0x18(t0)\n\t"
+    "fsd    f4, 0x20(t0)\n\t"
+    "fsd    f5, 0x28(t0)\n\t"
+    "fsd    f6, 0x30(t0)\n\t"
+    "fsd    f7, 0x38(t0)\n\t"
+    "fsd    f8, 0x40(t0)\n\t"
+    "fsd    f9, 0x48(t0)\n\t"
+    "fsd    f10, 0x50(t0)\n\t"
+    "fsd    f11, 0x58(t0)\n\t"
+    "fsd    f12, 0x60(t0)\n\t"
+    "fsd    f13, 0x68(t0)\n\t"
+    "fsd    f14, 0x70(t0)\n\t"
+    "fsd    f15, 0x78(t0)\n\t"
+    "fsd    f16, 0x80(t0)\n\t"
+    "fsd    f17, 0x88(t0)\n\t"
+    "fsd    f18, 0x90(t0)\n\t"
+    "fsd    f19, 0x98(t0)\n\t"
+    "fsd    f20, 0xa0(t0)\n\t"
+    "fsd    f21, 0xa8(t0)\n\t"
+    "fsd    f22, 0xb0(t0)\n\t"
+    "fsd    f23, 0xb8(t0)\n\t"
+    "fsd    f24, 0xc0(t0)\n\t"
+    "fsd    f25, 0xc8(t0)\n\t"
+    "fsd    f26, 0xd0(t0)\n\t"
+    "fsd    f27, 0xd8(t0)\n\t"
+    "fsd    f28, 0xe0(t0)\n\t"
+    "fsd    f29, 0xe8(t0)\n\t"
+    "fsd    f30, 0xf0(t0)\n\t"
+    "fsd    f31, 0xf8(t0)\n\t"
+    : "=m" (initial_gvalues),
+      "=m" (final_gvalues),
+      "=m" (final_fvalues)
+    : "m" (initial_fvalues),
+      [initial_gvalues] "r" (initial_gvalues),
+      [initial_fvalues] "r" (initial_fvalues),
+      [final_gvalues] "r" (final_gvalues),
+      [final_fvalues] "r" (final_fvalues)
+    : "t0",
+      "f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7",
+      "f8", "f9", "f10", "f11", "f12", "f13", "f14", "f15",
+      "f16", "f17", "f18", "f19", "f20", "f21", "f22", "f23",
+      "f24", "f25", "f26", "f27", "f28", "f29", "f30", "f31");
+
+    assert(got_signal);
+
+    /*
+     * x4 / t0 is used in the asm so it has to be handled specially
+     * and is not a simple equality.
+     */
+    assert(initial_gvalues[4] == (unsigned long)initial_gvalues);
+    assert(signal_gvalues[4] == (unsigned long)initial_fvalues);
+    assert(final_gvalues[4] == (unsigned long)final_gvalues);
+    initial_gvalues[4] = final_gvalues[4] = signal_gvalues[4] = 0;
+
+    /*
+     * Ensure registers match before, inside, and after signal
+     * handler.
+     */
+    assert(!memcmp(initial_gvalues, final_gvalues, 8 * 31));
+    assert(!memcmp(initial_gvalues, signal_gvalues, 8 * 31));
+    assert(!memcmp(initial_fvalues, final_fvalues, 8 * 32));
+    assert(!memcmp(initial_fvalues, signal_fvalues, 8 * 32));
+}
+
+int main(void)
+{
+    struct sigaction act = { 0 };
+
+    act.sa_flags = SA_SIGINFO;
+    act.sa_sigaction = &ILL_handler;
+    if (sigaction(SIGILL, &act, NULL) == -1) {
+        perror("sigaction");
+        exit(EXIT_FAILURE);
+    }
+
+    init_test();
+
+    run_test();
+}
-- 
2.51.0


