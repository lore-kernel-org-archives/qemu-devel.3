Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EE6CA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 04:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utf4B-0005g5-Ah; Wed, 03 Sep 2025 00:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1utf49-0005fn-DC; Wed, 03 Sep 2025 00:25:49 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1utf47-0004Mr-7d; Wed, 03 Sep 2025 00:25:49 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-24884d9e54bso61351725ad.0; 
 Tue, 02 Sep 2025 21:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756873545; x=1757478345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mxUu8KtKg576qtWPJVuUm9tnY/uckAzRXEPT4WQcHhg=;
 b=jZykDYcLouzdFplwiKmfzFGaHGCKfRCnBLxIL8VB/2MWB61Ar003weZRWido2DtHCE
 M7xzyGvmLLAk3zfUBcmTX2pbsyCn5CnrEYGp13fkn1oS1HcPQ5i5disqrNevdzYyVpwd
 9+H+fQdmpvJ/6qzFn1nEaiLduVfrSPQZtjbvauhNRtGyShINcai8eIoX9yfNnb9j/mjU
 pOcHuX6y6TSEjIDR2jrVlL+bs/vaI57P80iJ3BSWflq1W1gdocukl4vvPDEsZwH2K9rV
 /v5x5W1qtEs+9NEFPhBCBdrKg5JqAVoxp/PakwRRZeEhNDg8jzFZjreIMSgw2IBvt+en
 QktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756873545; x=1757478345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mxUu8KtKg576qtWPJVuUm9tnY/uckAzRXEPT4WQcHhg=;
 b=VB04GwO14W//rT1GLczafttYmv5y7Xo+MGkCZLvL2MwkCPvDBxfaeoYvyojQG63XSY
 K70wJRNGdB058tEexu9GNbi1O/4T4aRHwOikuWqvjLPuEeueXAropfFBl7PIPV0a0WXt
 1CV3b/KTx4I+nEVgFJXl39ReT+3mgN6FQ5rNwarWWY9XaL4uV17YpHUdqNFW8/s/JavK
 Jn8FfX/8sJH1G7mSUXxlsdxnIur0tSOw6shQaHZc/8/g74BgrwUzkyUp1s5+PGG+vZF6
 2r3n1PAoUZT3Nwr/YaiZrb93ox8Zaii90vWuoMjS3+S4IRFv6COb8QJB0CgSGhRdN/cd
 IHOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfL8cSXzpADY+3u+39eUwKOX4J55IdG/xxjIWoXZh24NGqURvoLQlsvzCU1mL/79uPILLKzDLF4W7Y@nongnu.org
X-Gm-Message-State: AOJu0YyGpYowp5YQGKq7Bb+S7JbI3aRi1PMoj4oq20fbhBhMN8uMdl/f
 vZKtavf190vOiov2hnXs8Z7YJq+3B69tipTScjc4cRDnpGvyY/9VyWjPF9t+cg==
X-Gm-Gg: ASbGnctqWaaf/ssPo9mgnWgFLYDBeugOMsJGPMkTFzTxrA4Ld6UHRNDNdeKvzs3pjHf
 tuoMpr7D7NjOFp5yfkdY1k6qD8GTWv/RqjrlibLsXlp5QfG04yBaunv4Rj4XuQQO1QQnjCByfDW
 bYaFZVHEvW96zUFlCyl1rnDjYRiI98s6MZgvEhtuXFjqLSRth+NWWf1phDnv1yDlgkHeNLRbpux
 WDL10QUngOYW/0ylELQJ1VwgH1lMO8qAHerxiMBgWiPj9TBcQqUxcy1SNKOeC9Gfjg3h9pU5Q4V
 1fOHC6nDme5Dq7oWegYKG/E/MFfbU1tYT7gxkVVgg67wEXGNp7ApBe9fJlDb3s06ru3ultxCT2i
 t8OKxf06ukpN9b5S9a+j/K/cnljAucShRbQezcjk/qoGM9rPc5zbrZGR6KHljeFk5wH0d7xRDaA
 exRWSyjXsyBK1J+2CZ0gw=
X-Google-Smtp-Source: AGHT+IFtImf3skzEelAtlWK1DLP0m+OGqhOZ+yqsgUw5n8kheFslAUzPVkxCe+sU1pvEtrO6hNMXsg==
X-Received: by 2002:a17:902:d4c1:b0:24c:92b5:2175 with SMTP id
 d9443c01a7336-24c92b5262fmr7792215ad.24.1756873545146; 
 Tue, 02 Sep 2025 21:25:45 -0700 (PDT)
Received: from lima-default (123.253.189.97.qld.leaptel.network.
 [123.253.189.97]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490370298dsm149002635ad.4.2025.09.02.21.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 21:25:44 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Subject: [PATCH 4/4] tests/tcg/riscv64: Add vector state to signal test
Date: Wed,  3 Sep 2025 14:25:10 +1000
Message-ID: <20250903042510.279954-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903042510.279954-1-npiggin@gmail.com>
References: <20250903042510.279954-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/tcg/riscv64/test-signal-handling.c | 215 ++++++++++++++++++++++-
 1 file changed, 209 insertions(+), 6 deletions(-)

diff --git a/tests/tcg/riscv64/test-signal-handling.c b/tests/tcg/riscv64/test-signal-handling.c
index e9c0170c74..29b2fe169d 100644
--- a/tests/tcg/riscv64/test-signal-handling.c
+++ b/tests/tcg/riscv64/test-signal-handling.c
@@ -19,9 +19,16 @@
 #include <execinfo.h>
 #include <unistd.h>
 #include <assert.h>
+#include <sys/auxv.h>
+#include <elf.h>
 #include <sys/mman.h>
 #include <ucontext.h>
 #include <asm/sigcontext.h>
+#include "riscv_vector.h"
+
+#ifndef COMPAT_HWCAP_ISA_V
+#define COMPAT_HWCAP_ISA_V (1 << ('V' - 'A'))
+#endif
 
 /*
  * This horrible hack seems to be required when including
@@ -41,6 +48,10 @@ static uint64_t *signal_gvalues;
 static double *initial_fvalues;
 static double *final_fvalues;
 static double *signal_fvalues;
+static size_t vlenb;
+static uint8_t *initial_vvalues;
+static uint8_t *final_vvalues;
+static uint8_t *signal_vvalues;
 
 extern unsigned long unimp_addr[];
 
@@ -64,6 +75,8 @@ static void ILL_handler(int signo, siginfo_t *info, void *context)
 {
     ucontext_t *uc = context;
     struct sigcontext *sc = (struct sigcontext *)&uc->uc_mcontext;
+    struct __riscv_ctx_hdr *sc_ext = &sc->sc_extdesc.hdr;
+    bool found_v = false;
 
     got_signal = true;
 
@@ -82,12 +95,47 @@ static void ILL_handler(int signo, siginfo_t *info, void *context)
     }
     /* Test sc->sc_fpregs.d.fcsr ? */
 
+    assert(sc->sc_extdesc.reserved == 0);
+    while (sc_ext->magic != END_MAGIC) {
+        assert(sc_ext->size != 0);
+
+        if (sc_ext->magic == RISCV_V_MAGIC) {
+            struct __sc_riscv_v_state *sc_v_state = (struct __sc_riscv_v_state *)(sc_ext + 1);
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
 
@@ -107,6 +155,19 @@ static void init_test(void)
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
@@ -179,6 +240,72 @@ static void run_test(void)
 "    fld    f29, 0xe8(t0)            \n"
 "    fld    f30, 0xf0(t0)            \n"
 "    fld    f31, 0xf8(t0)            \n"
+    /* Load initial values into vector registers */
+"    mv    t0, %[initial_vvalues]    \n"
+"    vsetvli x0,%[vlenb],e8,m1,ta,ma \n"
+"    vle8.v    v0, (t0)              \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vle8.v    v1, (t0)              \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vle8.v    v2, (t0)              \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vle8.v    v3, (t0)              \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vle8.v    v4, (t0)              \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vle8.v    v5, (t0)              \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vle8.v    v6, (t0)              \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vle8.v    v7, (t0)              \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vle8.v    v8, (t0)              \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vle8.v    v9, (t0)              \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vle8.v    v10, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vle8.v    v11, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vle8.v    v12, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vle8.v    v13, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vle8.v    v14, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vle8.v    v15, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vle8.v    v16, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vle8.v    v17, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vle8.v    v18, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vle8.v    v19, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vle8.v    v20, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vle8.v    v21, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vle8.v    v22, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vle8.v    v23, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vle8.v    v24, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vle8.v    v25, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vle8.v    v26, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vle8.v    v27, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vle8.v    v28, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vle8.v    v29, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vle8.v    v30, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vle8.v    v31, (t0)             \n"
     /* Trigger the SIGILL */
 ".global unimp_addr                  \n"
 "unimp_addr:                         \n"
@@ -251,19 +378,93 @@ static void run_test(void)
 "    fsd    f29, 0xe8(t0)            \n"
 "    fsd    f30, 0xf0(t0)            \n"
 "    fsd    f31, 0xf8(t0)            \n"
+    /* Save final values from vector registers */
+"    mv    t0, %[final_vvalues]      \n"
+"    vse8.v    v0, (t0)              \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vse8.v    v1, (t0)              \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vse8.v    v2, (t0)              \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vse8.v    v3, (t0)              \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vse8.v    v4, (t0)              \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vse8.v    v5, (t0)              \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vse8.v    v6, (t0)              \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vse8.v    v7, (t0)              \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vse8.v    v8, (t0)              \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vse8.v    v9, (t0)              \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vse8.v    v10, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vse8.v    v11, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vse8.v    v12, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vse8.v    v13, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vse8.v    v14, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vse8.v    v15, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vse8.v    v16, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vse8.v    v17, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vse8.v    v18, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vse8.v    v19, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vse8.v    v20, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vse8.v    v21, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vse8.v    v22, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vse8.v    v23, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vse8.v    v24, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vse8.v    v25, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vse8.v    v26, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vse8.v    v27, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vse8.v    v28, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vse8.v    v29, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vse8.v    v30, (t0)             \n"
+"    add    t0, t0, %[vlenb]         \n"
+"    vse8.v    v31, (t0)             \n"
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
 
@@ -272,7 +473,7 @@ static void run_test(void)
      * and is not a simple equality.
      */
     assert(initial_gvalues[4] == (unsigned long)initial_gvalues);
-    assert(signal_gvalues[4] == (unsigned long)initial_fvalues);
+    assert(signal_gvalues[4] == (unsigned long)initial_vvalues + 31 * vlenb);
     assert(final_gvalues[4] == (unsigned long)final_gvalues);
     initial_gvalues[4] = final_gvalues[4] = signal_gvalues[4] = 0;
 
@@ -284,6 +485,8 @@ static void run_test(void)
     assert(!memcmp(initial_gvalues, signal_gvalues, 8 * 31));
     assert(!memcmp(initial_fvalues, final_fvalues, 8 * 32));
     assert(!memcmp(initial_fvalues, signal_fvalues, 8 * 32));
+    assert(!memcmp(initial_vvalues, signal_vvalues, vlenb * 32));
+    assert(!memcmp(initial_vvalues, final_vvalues, vlenb * 32));
 }
 
 int main(void)
-- 
2.51.0


