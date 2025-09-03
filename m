Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D149BCA100C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 08:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utidj-0002lm-3p; Wed, 03 Sep 2025 04:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1utidf-0002kp-El; Wed, 03 Sep 2025 04:14:43 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1utidc-0001ic-GT; Wed, 03 Sep 2025 04:14:42 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-24c89867a17so5596995ad.1; 
 Wed, 03 Sep 2025 01:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756887278; x=1757492078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y8yvSBFdg6/w+t6lod7oj6WNKUXqjZ+id/3TLdUhnCs=;
 b=QD78kuM88NIjf1I582Or4hrgAXGFcElkDvv0RDSU975g3cHWTiaKk0sVm07Y+3QicC
 vGn1TUj2X7RJ8PlxbdaEiKEE4llYKZp74DLrRisn9sBRS/ezTeWlmlj3AUGbzi2tPAe8
 CYNz6PBdjL5XrK3vfBvXcwme2vUoeurOao1AYzQeqjp9T9JTGI8ZIcLGFTXTn3TBisi0
 cUYVH5ODJqMos/NJMrO7TxNJHqTr+HjmHj1TY/gqweCJdcLk6e2sHcuR8BdKLZ0A1JOc
 BGWupHf2xBSE54k7ZYXuoolxay2bltzceCBQRqhXWuDoB/eiJTKva4drDjE/KdgsqLV8
 PLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756887278; x=1757492078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y8yvSBFdg6/w+t6lod7oj6WNKUXqjZ+id/3TLdUhnCs=;
 b=pZ0Xf8Vf43ck/GmzR+/JZ8M0Pm2KOkvGsMAvWn1tPKO8GEtnFvCkCsWjdCCl/8Qwt/
 nQsqtJelXoZ+zzKdwoH+Q/9qsZaBO203C5E9RmSwIdQQuL8Tyr81EbC55PclI6T1Awvh
 f8UeraBQTpx8GnPKPXeGvKxHfDglmYvw57UvRU8sgb9XDtDjaqKfOGO7rvVtVhT1hG1d
 hbmcLZ9AK5gCnRxC+4iPfdrXRxJSZ7SdYDGA5UXLGEkOu+MVqMi8bUuritTWT/HexnGL
 n8UbilMJVP9RDpj2t09KIQ9qAN/5bGde5CufKcW1cpVdcCi6QyAJJMuuyUlQprANHX6o
 UJDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2QUXxvLC3jrfvgTpeGUM2nMiT77Hl8oc+eB9/acEYZdIeT4bQDezt3TDVTYo5vCZ/ji5uW1Z/Jre1@nongnu.org
X-Gm-Message-State: AOJu0YzfgD4joUuPqnXZzq4/dNU0DwS9qPGN8vxuz6razTdi3hTEPftY
 QOvB8FPc0C5W63seruNOY/PJ2NE0jXFEi34N6ziA6+4KOXJ6xn/K/wglXwrCGA==
X-Gm-Gg: ASbGncvY5ZsGb6iSuUSxb3q+pvKTzQ8l1UMxFsNt8aMZTDKDXTvcoDQ91O8WVhIY5Iu
 y6wz4UTN6o9aM6qwJEfKgFlKQZgaAZSqfpBb+ZPWpR9VgIqQK9cHjcrA/a+KugV/9Agv3s+zhTz
 a+uGAujRBrjLNvyCASm/dmLNbMW2Uw64sQwOdjaJLL/LOiao07Zd2axg1V5Ik6ID6oomO7JbZQa
 tb5BAEdxLG1rreLSWkV7dD81xCftZcf79MJdWfZX4FY/vZtv8uJiWZTXDbUETtfoxRJLIiR0ClA
 75XoMZMy2N7NRpUllNHL8FhedNe4nWrre6qx4/AZef17DZnwZ3nYDJzM+OMdKRekgCo1o6+AX82
 rnnX5ZMlxLeOwx91k/ZNrpSAEHG51XiHjKTvJFDtsbuzQMVMwgCmZBXyKbh7p8t9KVcBkTSWmPQ
 Qvv9A=
X-Google-Smtp-Source: AGHT+IGWlSzX5PITXxqII30tvw4U0jA/SpacMQqK+RBFUNSiiBT14jsJVm+aNonu5ibkMVIHcfFwEA==
X-Received: by 2002:a17:902:dac2:b0:24a:b5a1:10cd with SMTP id
 d9443c01a7336-24ab5a1122fmr147329255ad.52.1756887277992; 
 Wed, 03 Sep 2025 01:14:37 -0700 (PDT)
Received: from lima-default (123.253.189.97.qld.leaptel.network.
 [123.253.189.97]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24c9a46bcf1sm8806555ad.3.2025.09.03.01.14.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 01:14:37 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 1/4] tests/tcg/riscv64: Add a user signal handling test
Date: Wed,  3 Sep 2025 18:14:14 +1000
Message-ID: <20250903081417.338515-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903081417.338515-1-npiggin@gmail.com>
References: <20250903081417.338515-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

Add a few basic signal handling tests for user emulation.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/tcg/riscv64/Makefile.target        |   5 +
 tests/tcg/riscv64/test-signal-handling.c | 303 +++++++++++++++++++++++
 2 files changed, 308 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-signal-handling.c

diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefile.target
index 8f4690ac57..0c89c46c4f 100644
--- a/tests/tcg/riscv64/Makefile.target
+++ b/tests/tcg/riscv64/Makefile.target
@@ -5,6 +5,11 @@ VPATH += $(SRC_PATH)/tests/tcg/riscv64
 TESTS += test-div
 TESTS += noexec
 
+# Test signal handling.
+TESTS += test-signal-handling
+test-signal-handling: CFLAGS += -march=rv64gcv
+run-test-signal-handling: QEMU_OPTS += -cpu rv64,v=on
+
 # Disable compressed instructions for test-noc
 TESTS += test-noc
 test-noc: LDFLAGS = -nostdlib -static
diff --git a/tests/tcg/riscv64/test-signal-handling.c b/tests/tcg/riscv64/test-signal-handling.c
new file mode 100644
index 0000000000..e9c0170c74
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
+"    mv    t0, %[initial_gvalues]    \n"
+"    sd    x1, 0x0(t0)               \n"
+"    sd    x2, 0x8(t0)               \n"
+"    sd    x3, 0x10(t0)              \n"
+"    sd    x4, 0x18(t0)              \n"
+"    sd    x5, 0x20(t0)              \n"
+"    sd    x6, 0x28(t0)              \n"
+"    sd    x7, 0x30(t0)              \n"
+"    sd    x8, 0x38(t0)              \n"
+"    sd    x9, 0x40(t0)              \n"
+"    sd    x10, 0x48(t0)             \n"
+"    sd    x11, 0x50(t0)             \n"
+"    sd    x12, 0x58(t0)             \n"
+"    sd    x13, 0x60(t0)             \n"
+"    sd    x14, 0x68(t0)             \n"
+"    sd    x15, 0x70(t0)             \n"
+"    sd    x16, 0x78(t0)             \n"
+"    sd    x17, 0x80(t0)             \n"
+"    sd    x18, 0x88(t0)             \n"
+"    sd    x19, 0x90(t0)             \n"
+"    sd    x20, 0x98(t0)             \n"
+"    sd    x21, 0xa0(t0)             \n"
+"    sd    x22, 0xa8(t0)             \n"
+"    sd    x23, 0xb0(t0)             \n"
+"    sd    x24, 0xb8(t0)             \n"
+"    sd    x25, 0xc0(t0)             \n"
+"    sd    x26, 0xc8(t0)             \n"
+"    sd    x27, 0xd0(t0)             \n"
+"    sd    x28, 0xd8(t0)             \n"
+"    sd    x29, 0xe0(t0)             \n"
+"    sd    x30, 0xe8(t0)             \n"
+"    sd    x31, 0xf0(t0)             \n"
+    /* Load initial values into float registers */
+"    mv    t0, %[initial_fvalues]    \n"
+"    fld    f0, 0x0(t0)              \n"
+"    fld    f1, 0x8(t0)              \n"
+"    fld    f2, 0x10(t0)             \n"
+"    fld    f3, 0x18(t0)             \n"
+"    fld    f4, 0x20(t0)             \n"
+"    fld    f5, 0x28(t0)             \n"
+"    fld    f6, 0x30(t0)             \n"
+"    fld    f7, 0x38(t0)             \n"
+"    fld    f8, 0x40(t0)             \n"
+"    fld    f9, 0x48(t0)             \n"
+"    fld    f10, 0x50(t0)            \n"
+"    fld    f11, 0x58(t0)            \n"
+"    fld    f12, 0x60(t0)            \n"
+"    fld    f13, 0x68(t0)            \n"
+"    fld    f14, 0x70(t0)            \n"
+"    fld    f15, 0x78(t0)            \n"
+"    fld    f16, 0x80(t0)            \n"
+"    fld    f17, 0x88(t0)            \n"
+"    fld    f18, 0x90(t0)            \n"
+"    fld    f19, 0x98(t0)            \n"
+"    fld    f20, 0xa0(t0)            \n"
+"    fld    f21, 0xa8(t0)            \n"
+"    fld    f22, 0xb0(t0)            \n"
+"    fld    f23, 0xb8(t0)            \n"
+"    fld    f24, 0xc0(t0)            \n"
+"    fld    f25, 0xc8(t0)            \n"
+"    fld    f26, 0xd0(t0)            \n"
+"    fld    f27, 0xd8(t0)            \n"
+"    fld    f28, 0xe0(t0)            \n"
+"    fld    f29, 0xe8(t0)            \n"
+"    fld    f30, 0xf0(t0)            \n"
+"    fld    f31, 0xf8(t0)            \n"
+    /* Trigger the SIGILL */
+".global unimp_addr                  \n"
+"unimp_addr:                         \n"
+"    unimp                           \n"
+"    nop                             \n"
+    /* Save final values from gp registers */
+"    mv    t0, %[final_gvalues]      \n"
+"    sd    x1, 0x0(t0)               \n"
+"    sd    x2, 0x8(t0)               \n"
+"    sd    x3, 0x10(t0)              \n"
+"    sd    x4, 0x18(t0)              \n"
+"    sd    x5, 0x20(t0)              \n"
+"    sd    x6, 0x28(t0)              \n"
+"    sd    x7, 0x30(t0)              \n"
+"    sd    x8, 0x38(t0)              \n"
+"    sd    x9, 0x40(t0)              \n"
+"    sd    x10, 0x48(t0)             \n"
+"    sd    x11, 0x50(t0)             \n"
+"    sd    x12, 0x58(t0)             \n"
+"    sd    x13, 0x60(t0)             \n"
+"    sd    x14, 0x68(t0)             \n"
+"    sd    x15, 0x70(t0)             \n"
+"    sd    x16, 0x78(t0)             \n"
+"    sd    x17, 0x80(t0)             \n"
+"    sd    x18, 0x88(t0)             \n"
+"    sd    x19, 0x90(t0)             \n"
+"    sd    x20, 0x98(t0)             \n"
+"    sd    x21, 0xa0(t0)             \n"
+"    sd    x22, 0xa8(t0)             \n"
+"    sd    x23, 0xb0(t0)             \n"
+"    sd    x24, 0xb8(t0)             \n"
+"    sd    x25, 0xc0(t0)             \n"
+"    sd    x26, 0xc8(t0)             \n"
+"    sd    x27, 0xd0(t0)             \n"
+"    sd    x28, 0xd8(t0)             \n"
+"    sd    x29, 0xe0(t0)             \n"
+"    sd    x30, 0xe8(t0)             \n"
+"    sd    x31, 0xf0(t0)             \n"
+    /* Save final values from float registers */
+"    mv    t0, %[final_fvalues]      \n"
+"    fsd    f0, 0x0(t0)              \n"
+"    fsd    f1, 0x8(t0)              \n"
+"    fsd    f2, 0x10(t0)             \n"
+"    fsd    f3, 0x18(t0)             \n"
+"    fsd    f4, 0x20(t0)             \n"
+"    fsd    f5, 0x28(t0)             \n"
+"    fsd    f6, 0x30(t0)             \n"
+"    fsd    f7, 0x38(t0)             \n"
+"    fsd    f8, 0x40(t0)             \n"
+"    fsd    f9, 0x48(t0)             \n"
+"    fsd    f10, 0x50(t0)            \n"
+"    fsd    f11, 0x58(t0)            \n"
+"    fsd    f12, 0x60(t0)            \n"
+"    fsd    f13, 0x68(t0)            \n"
+"    fsd    f14, 0x70(t0)            \n"
+"    fsd    f15, 0x78(t0)            \n"
+"    fsd    f16, 0x80(t0)            \n"
+"    fsd    f17, 0x88(t0)            \n"
+"    fsd    f18, 0x90(t0)            \n"
+"    fsd    f19, 0x98(t0)            \n"
+"    fsd    f20, 0xa0(t0)            \n"
+"    fsd    f21, 0xa8(t0)            \n"
+"    fsd    f22, 0xb0(t0)            \n"
+"    fsd    f23, 0xb8(t0)            \n"
+"    fsd    f24, 0xc0(t0)            \n"
+"    fsd    f25, 0xc8(t0)            \n"
+"    fsd    f26, 0xd0(t0)            \n"
+"    fsd    f27, 0xd8(t0)            \n"
+"    fsd    f28, 0xe0(t0)            \n"
+"    fsd    f29, 0xe8(t0)            \n"
+"    fsd    f30, 0xf0(t0)            \n"
+"    fsd    f31, 0xf8(t0)            \n"
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


