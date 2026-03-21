Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64121094478
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 14:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3x65-0006Yb-Rl; Sat, 21 Mar 2026 10:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3x64-0006Xw-59
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 10:14:36 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3x62-0003sf-37
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 10:14:35 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-82a3d3235c9so2644971b3a.2
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2026 07:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774102473; x=1774707273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=48T9J0fElQTU2HMwN9GxJ5WHDVExenZwKppHr5OXU38=;
 b=eZ17Z5wEpcYMuo1dGR8n7rInaBNbf0Z/EpUuuAiGr7hqHWbo3PSXv8KRrFQ5HThMQb
 VuXVaZIkg8fkGql1sZaESBXB0d3R5q4T3Q0VtXPWQHlwZm8W1mCZ++DHTdEitJruFlYK
 c9Sne7KXzogyloZeFVl588c5M0wptcICJQqrCcRmMsOEiqoY0O18jsa1u/8I+gCbM6tB
 w2IE9ThK7OxSRxXE3/zp2x9UUKJjL8nnrZNYjo+eJ2XGGasok5aO1X47oUXGcUGgTrar
 RG+5VK+kqahOQddc9qEN8B2c9535aeHlop6hVFfCDSXmfcyh1KXL9FWFR7HmXKExsAgv
 xYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774102473; x=1774707273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=48T9J0fElQTU2HMwN9GxJ5WHDVExenZwKppHr5OXU38=;
 b=a58tK0HwLaPRI5p7ukjQQkgvKCaEscQ/dRfp50wWTOJSdICQ3EambVRpfGfUQqAOa/
 KaAkQfhA9sggbtQW7xxbjxfKxJO/EOb0x5P5BtaRXk1XDfhWYaKfVVklGRNKHDgYJDX+
 wb9/Uxx/Ld5OYlvC6882P9t/FPd6WDBIm8qRHVK3UI2XP52Iiniul45uSUxLPQi1k4Fn
 be/k6LMcoMugpRsBqqYMjKuDk639hiIRW0iQTOSBOtYF25VRsMGveBc1vQ8rD3cwE0tB
 1yILW0jDxnOjgXqwobjfGhUlDuDIXjcZS0R9B6W0NXK4bha8Ws4RghfKJSlEfP8heujl
 sZKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxp/WOfm0kWXVQmwaRPD/qZF350QndvfwTP3+XMYJZ2SGw+ydUGDy3jLr2v286UqkLtdJsfhVM7Zbu@nongnu.org
X-Gm-Message-State: AOJu0Yw4gSSOg7a4HW+itJorhihhTYBzlY/63Y7HeXnWkZcaxCykS0lk
 pO15JyKSohJT+SAd9CZaIyxSofY/366xDfsYzX6avzdwESiu+t6heqId
X-Gm-Gg: ATEYQzzdw/F61+O6PAQxDxppCWKS9JJJXfoPHQcdV7H+fzsOLjJX3hTUIJzNkYy0dXm
 N6AM8Vc+uE+YYlpXa/yckxTVtzXXUVwLVyAt6BrBYoYg9hHMtn18sH7PjYyVCz0cYxtVKpfqvAw
 nRNBcjWRJB7tj9N5/XAecjRGsD7hkQ2UlRJG9Qnvhj9L9N6sPBSG7E6FcnSActNcHRNNSw6XcHs
 P7IJq9ucmeqg2nbt1zS3f5YqSeP6fVzR3mtluGOGnL/SGRWhhv8J7EOZMMvK+l7Z03OJtkteocu
 JL2EKgnQdleTLJrPWlU1waxJoNJq2ZTU6yRGwDQCrUQmnA6awhwR9IT8gd8tEcb+YOOYKuhHq3Y
 JmDutdZXiL1XfLPyHE7Hl+PBQAob2nYPE/6wqJ8LYhavu9FbX9tCnk3nLzD/6SFlDb80M+Jjy6K
 Y9dXq/yWWv8XObVJfnG7FYbrBo9ZSTN/fSoaiMJM5XwqRkuHnYtK3h/FrXDHNFEF1Odyrx
X-Received: by 2002:a05:6a00:228e:b0:82a:6461:6d15 with SMTP id
 d2e1a72fcca58-82a8c334828mr5458106b3a.46.1774102472534; 
 Sat, 21 Mar 2026 07:14:32 -0700 (PDT)
Received: from lima-default (103.95.112.190.qld.leaptel.network.
 [103.95.112.190]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b040debf9sm4764875b3a.47.2026.03.21.07.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 07:14:31 -0700 (PDT)
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
Subject: [PATCH v3 5/5] tests/tcg/riscv64: Add vector state to signal test
Date: Sun, 22 Mar 2026 00:13:43 +1000
Message-ID: <20260321141345.599105-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260321141345.599105-1-npiggin@gmail.com>
References: <20260321141345.599105-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/tcg/riscv64/Makefile.target        |   4 +-
 tests/tcg/riscv64/test-signal-handling.c | 226 ++++++++++++++++++++++-
 2 files changed, 222 insertions(+), 8 deletions(-)

diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefile.target
index f318891396..86b6889a3d 100644
--- a/tests/tcg/riscv64/Makefile.target
+++ b/tests/tcg/riscv64/Makefile.target
@@ -21,5 +21,5 @@ run-test-fcvtmod: QEMU_OPTS += -cpu rv64,d=true,zfa=true
 
 # Test signal handling.
 TESTS += test-signal-handling
-test-signal-handling: CFLAGS += -march=rv64gc
-run-test-signal-handling: QEMU_OPTS += -cpu rv64
+test-signal-handling: CFLAGS += -march=rv64gcv
+run-test-signal-handling: QEMU_OPTS += -cpu rv64,v=on
diff --git a/tests/tcg/riscv64/test-signal-handling.c b/tests/tcg/riscv64/test-signal-handling.c
index c202503382..b71fa6ee87 100644
--- a/tests/tcg/riscv64/test-signal-handling.c
+++ b/tests/tcg/riscv64/test-signal-handling.c
@@ -19,10 +19,27 @@
 #include <execinfo.h>
 #include <unistd.h>
 #include <assert.h>
+#include <sys/auxv.h>
+#include <elf.h>
 #include <sys/mman.h>
 #include <ucontext.h>
 #include <asm/sigcontext.h>
 
+#ifdef __riscv_v_intrinsic
+#include <riscv_vector.h>
+#else
+static inline unsigned long __riscv_vlenb(void)
+{
+    unsigned long vlenb;
+    __asm__ __volatile__ ("csrr %0, vlenb" : "=r" (vlenb));
+    return vlenb;
+}
+#endif
+
+#ifndef COMPAT_HWCAP_ISA_V
+#define COMPAT_HWCAP_ISA_V (1 << ('V' - 'A'))
+#endif
+
 /*
  * This horrible hack seems to be required when including
  * signal.h and asm/sigcontext.h, to prevent sigcontext
@@ -41,6 +58,10 @@ static uint64_t *signal_gvalues;
 static double *initial_fvalues;
 static double *final_fvalues;
 static double *signal_fvalues;
+static size_t vlenb;
+static uint8_t *initial_vvalues;
+static uint8_t *final_vvalues;
+static uint8_t *signal_vvalues;
 
 extern unsigned long unimp_addr[];
 
@@ -64,6 +85,8 @@ static void ILL_handler(int signo, siginfo_t *info, void *context)
 {
     ucontext_t *uc = context;
     struct sigcontext *sc = (struct sigcontext *)&uc->uc_mcontext;
+    struct __riscv_ctx_hdr *sc_ext = &sc->sc_extdesc.hdr;
+    bool found_v = false;
 
     got_signal = true;
 
@@ -82,12 +105,48 @@ static void ILL_handler(int signo, siginfo_t *info, void *context)
     }
     /* Test sc->sc_fpregs.d.fcsr ? */
 
+    assert(sc->sc_extdesc.reserved == 0);
+    while (sc_ext->magic != END_MAGIC) {
+        assert(sc_ext->size != 0);
+
+        if (sc_ext->magic == RISCV_V_MAGIC) {
+            struct __sc_riscv_v_state *sc_v_state =
+                        (struct __sc_riscv_v_state *)(sc_ext + 1);
+            struct __riscv_v_ext_state *v_state = &sc_v_state->v_state;
+
+            found_v = true;
+
+            assert(getauxval(AT_HWCAP) & COMPAT_HWCAP_ISA_V);
+
+            assert(v_state->vlenb == vlenb);
+            assert(v_state->vtype == 0xc0); /* vma, vta */
+            assert(v_state->vl == vlenb);
+            assert(v_state->vstart == 0);
+            assert(v_state->vcsr == 0);
+
+            uint64_t *vregs = v_state->datap;
+            for (int i = 0; i < 32; i++) {
+                for (int j = 0; j < vlenb; j += 8) {
+                    size_t idx = (i * vlenb + j) / 8;
+                    ((uint64_t *)signal_vvalues)[idx] = vregs[idx];
+                }
+            }
+        }
+
+        sc_ext = (void *)sc_ext + sc_ext->size;
+    }
+
+    assert(sc_ext->size == 0);
+    if (getauxval(AT_HWCAP) & COMPAT_HWCAP_ISA_V) {
+        assert(found_v);
+    }
+
     sc->sc_regs.pc += 4;
 }
 
 static void init_test(void)
 {
-    int i;
+    int i, j;
 
     callchain_root = find_callchain_root();
 
@@ -107,6 +166,19 @@ static void init_test(void)
     memset(final_fvalues, 0, 8 * 32);
     signal_fvalues = malloc(8 * 32);
     memset(signal_fvalues, 0, 8 * 32);
+
+    vlenb = __riscv_vlenb();
+    initial_vvalues = malloc(vlenb * 32);
+    memset(initial_vvalues, 0, vlenb * 32);
+    for (i = 0; i < 32 ; i++) {
+        for (j = 0; j < vlenb; j++) {
+            initial_vvalues[i * vlenb + j] = i * vlenb + j;
+        }
+    }
+    final_vvalues = malloc(vlenb * 32);
+    memset(final_vvalues, 0, vlenb * 32);
+    signal_vvalues = malloc(vlenb * 32);
+    memset(signal_vvalues, 0, vlenb * 32);
 }
 
 static void run_test(void)
@@ -179,6 +251,72 @@ static void run_test(void)
     "fld    f29, 0xe8(t0)\n\t"
     "fld    f30, 0xf0(t0)\n\t"
     "fld    f31, 0xf8(t0)\n\t"
+    /* Load initial values into vector registers */
+    "mv    t0, %[initial_vvalues]\n\t"
+    "vsetvli x0,%[vlenb],e8,m1,ta,ma\n\t"
+    "vle8.v    v0, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vle8.v    v1, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vle8.v    v2, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vle8.v    v3, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vle8.v    v4, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vle8.v    v5, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vle8.v    v6, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vle8.v    v7, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vle8.v    v8, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vle8.v    v9, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vle8.v    v10, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vle8.v    v11, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vle8.v    v12, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vle8.v    v13, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vle8.v    v14, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vle8.v    v15, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vle8.v    v16, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vle8.v    v17, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vle8.v    v18, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vle8.v    v19, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vle8.v    v20, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vle8.v    v21, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vle8.v    v22, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vle8.v    v23, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vle8.v    v24, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vle8.v    v25, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vle8.v    v26, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vle8.v    v27, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vle8.v    v28, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vle8.v    v29, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vle8.v    v30, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vle8.v    v31, (t0)\n\t"
     /* Trigger the SIGILL */
 ".global unimp_addr\n\t"
 "unimp_addr:\n\t"
@@ -251,19 +389,93 @@ static void run_test(void)
     "fsd    f29, 0xe8(t0)\n\t"
     "fsd    f30, 0xf0(t0)\n\t"
     "fsd    f31, 0xf8(t0)\n\t"
+    /* Save final values from vector registers */
+    "mv    t0, %[final_vvalues]\n\t"
+    "vse8.v    v0, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vse8.v    v1, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vse8.v    v2, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vse8.v    v3, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vse8.v    v4, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vse8.v    v5, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vse8.v    v6, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vse8.v    v7, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vse8.v    v8, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vse8.v    v9, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vse8.v    v10, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vse8.v    v11, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vse8.v    v12, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vse8.v    v13, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vse8.v    v14, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vse8.v    v15, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vse8.v    v16, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vse8.v    v17, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vse8.v    v18, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vse8.v    v19, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vse8.v    v20, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vse8.v    v21, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vse8.v    v22, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vse8.v    v23, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vse8.v    v24, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vse8.v    v25, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vse8.v    v26, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vse8.v    v27, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vse8.v    v28, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vse8.v    v29, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vse8.v    v30, (t0)\n\t"
+    "add    t0, t0, %[vlenb]\n\t"
+    "vse8.v    v31, (t0)\n\t"
     : "=m" (initial_gvalues),
       "=m" (final_gvalues),
-      "=m" (final_fvalues)
-    : "m" (initial_fvalues),
+      "=m" (final_fvalues),
+      "=m" (final_vvalues)
+    : [vlenb] "r" (vlenb),
+      "m" (initial_fvalues),
+      "m" (initial_vvalues),
       [initial_gvalues] "r" (initial_gvalues),
       [initial_fvalues] "r" (initial_fvalues),
+      [initial_vvalues] "r" (initial_vvalues),
       [final_gvalues] "r" (final_gvalues),
-      [final_fvalues] "r" (final_fvalues)
+      [final_fvalues] "r" (final_fvalues),
+      [final_vvalues] "r" (final_vvalues)
     : "t0",
       "f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7",
       "f8", "f9", "f10", "f11", "f12", "f13", "f14", "f15",
       "f16", "f17", "f18", "f19", "f20", "f21", "f22", "f23",
-      "f24", "f25", "f26", "f27", "f28", "f29", "f30", "f31");
+      "f24", "f25", "f26", "f27", "f28", "f29", "f30", "f31",
+      "v0", "v1", "v2", "v3", "v4", "v5", "v6", "v7",
+      "v8", "v9", "v10", "v11", "v12", "v13", "v14", "v15",
+      "v16", "v17", "v18", "v19", "v20", "v21", "v22", "v23",
+      "v24", "v25", "v26", "v27", "v28", "v29", "v30", "v31");
 
     assert(got_signal);
 
@@ -272,7 +484,7 @@ static void run_test(void)
      * and is not a simple equality.
      */
     assert(initial_gvalues[4] == (unsigned long)initial_gvalues);
-    assert(signal_gvalues[4] == (unsigned long)initial_fvalues);
+    assert(signal_gvalues[4] == (unsigned long)initial_vvalues + 31 * vlenb);
     assert(final_gvalues[4] == (unsigned long)final_gvalues);
     initial_gvalues[4] = final_gvalues[4] = signal_gvalues[4] = 0;
 
@@ -284,6 +496,8 @@ static void run_test(void)
     assert(!memcmp(initial_gvalues, signal_gvalues, 8 * 31));
     assert(!memcmp(initial_fvalues, final_fvalues, 8 * 32));
     assert(!memcmp(initial_fvalues, signal_fvalues, 8 * 32));
+    assert(!memcmp(initial_vvalues, signal_vvalues, vlenb * 32));
+    assert(!memcmp(initial_vvalues, final_vvalues, vlenb * 32));
 }
 
 int main(void)
-- 
2.51.0


