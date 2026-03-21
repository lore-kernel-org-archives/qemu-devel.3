Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1FE1094474
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 14:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3xbE-00072m-Ts; Sat, 21 Mar 2026 10:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3xb0-000717-27
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 10:46:34 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3xax-00014s-Ov
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 10:46:33 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-35b95a7444bso878473a91.1
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2026 07:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774104390; x=1774709190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4FxZI4z3rOz6H+RHO7jTyWTYOkyCV4lSQuIwbzBbor8=;
 b=eDGENyMYpAqFuouKlhWHoEt5pz1KFOsWG3JANPzFON6fXdYupP6s8EUUUTPi4lirUN
 M0jCDmI6+d4M3etf7CEvXdxmzZ7IVcGta+5iN6VA12SeXQ95Y9KgYstSEAfOdN1rOUKF
 XhPvw0JpcD1GBTLZ663MIurC8uvlMXd6Up2SeXwaQFAt3ar8riE+4S8qhTqhRCxxTUSt
 Vv0oWPMvLCjZIGSamjj/i5S28nFciOQ0kztDrFeEk+c2maBon9bApn9e6s6+J0EkAQt5
 +gygNu9a25E9MTrdod7k8irwv68tCfSe909lg7UAj4nSaK6hzI+8AP+dcZcbdhK7mxq7
 YMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774104390; x=1774709190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4FxZI4z3rOz6H+RHO7jTyWTYOkyCV4lSQuIwbzBbor8=;
 b=a88WNYHJKxUWI9N9pveARTjvJUU0oAdVuiMZicDqIpH37eJvaqfmi8L04EYmkbpsuH
 C/g3/gbq6oaBZXHK3tM1RWZqyl+P3xXWbBE/QAOyIqIEw/BZ8v7Gko/PsNwDvP9/tCKU
 4K5758A/GYOXEHeEfKqkWK27aTTRRUniM7WwJ1x5GaXQdvB8LjLt+lF7XFFHlFon+ZGE
 4h/ObtOr9bRwzwRPDhP9GvJZsfradwbY362TX0W/B7iXbwVK3SWTtLz+MzQlhLPx/kah
 6NMA7iWYd+byFf7vuw5ebS4wR5tMfPWCARbmNW5duK+KAAuJTqi5wcX2QlxDCvfcfADG
 UU4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiLBUNQBrrnWj26zSe+HpFd/dVdl0MDcz0ZigP7ZW+FpPLz/p3VJOx1I4E7C2Vm6p+1cshNIbMABRS@nongnu.org
X-Gm-Message-State: AOJu0Yx1G+3QS7G2Hof4Hv5gYioFmkY9vMtXyAlE1LmLfSNLnsAcyL45
 Faq9FmxKj555p2gAYbV/uq1y5reSAYIPCOostjn1pJ7JBPgDqRWf6mIF
X-Gm-Gg: ATEYQzyZjPKvmFcn5EqHY+YMacDBhitKjBe8dDjA+xwmvUJghPt0glT3nqQqb/qpUMd
 taAgUzK/S8cFpNA6lxsc3L8zrUxHDGVtIzyWmQODqoZGb7BDF22n1zznEDLolHAK6mAmJLyCgO6
 CVwnA1XDPTjSLIJ+uSVuX5z8yciGqAhPdpbJBw++RVwktZCLlcDcDe3KHU/cV8wkcb90eIcPC+P
 Pg+lUZ5KRy3f00Ht0YJUP7sefvoIBfS2jzhFxrH/bGJBsXs55oUp3AmLRREcWWN++gBJVeCUoK5
 qY8VYHHmwzQHFmVYhleB0SfZu+XonqEhpILbK0YgOwLN2PSNqzFp43TBwZkAC9hIGZcbB70kZ9j
 VX8KMYYek/toX0BFUc2kErtngFmA/EB5CWhQISKBbIcMh9AiSC3BYWq625xQpWljU5hJ9Js/Wox
 ZKiZlPDik1BiRAyVU/3/W5drfN0wxMnw3Q7zf7efBtABtZj3iUcccARZJzjWgoAdcbBEWB
X-Received: by 2002:a17:90b:3d48:b0:359:fecd:1cd3 with SMTP id
 98e67ed59e1d1-35bd2d1cf08mr5074721a91.23.1774104390319; 
 Sat, 21 Mar 2026 07:46:30 -0700 (PDT)
Received: from lima-default (103.95.112.190.qld.leaptel.network.
 [103.95.112.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bd24f1b9csm2283060a91.0.2026.03.21.07.46.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 07:46:29 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org,
 Joel Stanley <joel@jms.id.au>
Subject: [PATCH v3 3/3] tests/tcg: Add riscv test for interrupted vector ops
Date: Sun, 22 Mar 2026 00:45:54 +1000
Message-ID: <20260321144554.606417-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260321144554.606417-1-npiggin@gmail.com>
References: <20260321144554.606417-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1031.google.com
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

riscv vector instructions can be interrupted with a trap, and partial
completion is recorded in the vstart register. Some causes are
implementation dependent, for example an asynchronous interrupt (which I
don't think TCG allows). Others are architectural, typically memory
access faults on vector load/store instructions.

Add some TCG tests for interrupting vector load instructions and
resuming partially completed ones.

This would have caught a recent (now reverted) regression in vector
stride load implementation, commit 28c12c1f2f50d ("Generate strided
vector loads/stores with tcg nodes.")

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/tcg/riscv64/Makefile.target      |  11 +
 tests/tcg/riscv64/test-interrupted-v.c | 329 +++++++++++++++++++++++++
 2 files changed, 340 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-interrupted-v.c

diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefile.target
index 19a49b6467..b2b2325843 100644
--- a/tests/tcg/riscv64/Makefile.target
+++ b/tests/tcg/riscv64/Makefile.target
@@ -1,6 +1,10 @@
 # -*- Mode: makefile -*-
 # RISC-V specific tweaks
 
+# Not all environments have compilers with vector intrinsics yet.
+HAVE_RISCV_VECTOR_INTRINSICS := $(shell echo '#ifndef __riscv_v_intrinsic\n#error\n#endif' |  \
+                                  $(CC) -march=rv64gcv -E -x c - >/dev/null 2>&1 && echo y)
+
 VPATH += $(SRC_PATH)/tests/tcg/riscv64
 TESTS += test-div
 TESTS += noexec
@@ -23,3 +27,10 @@ run-test-fcvtmod: QEMU_OPTS += -cpu rv64,d=true,zfa=true
 TESTS += test-vstart-overflow
 test-vstart-overflow: CFLAGS += -march=rv64gcv
 run-test-vstart-overflow: QEMU_OPTS += -cpu rv64,v=on
+
+ifeq ($(HAVE_RISCV_VECTOR_INTRINSICS),y)
+# Test for interrupted vector instructions
+TESTS += test-interrupted-v
+test-interrupted-v: CFLAGS += -march=rv64gcv
+run-test-interrupted-v: QEMU_OPTS += -cpu rv64,v=on
+endif
diff --git a/tests/tcg/riscv64/test-interrupted-v.c b/tests/tcg/riscv64/test-interrupted-v.c
new file mode 100644
index 0000000000..3d0d21b49b
--- /dev/null
+++ b/tests/tcg/riscv64/test-interrupted-v.c
@@ -0,0 +1,329 @@
+/*
+ * Test for interrupted vector operations.
+ *
+ * Some vector instructions can be interrupted partially complete, vstart will
+ * be set to where the operation has progressed to, and the instruction can be
+ * re-executed with vstart != 0. It is implementation dependent as to what
+ * instructions can be interrupted and what vstart values are permitted when
+ * executing them. Vector memory operations can typically be interrupted
+ * (as they can take page faults), so these are easy to test.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <stdlib.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <stdio.h>
+#include <assert.h>
+#include <signal.h>
+#include <unistd.h>
+#include <riscv_vector.h>
+
+static unsigned long page_size;
+
+static volatile int nr_segv;
+static volatile unsigned long fault_start, fault_end;
+static volatile bool fault_write;
+
+/*
+ * Careful: qemu-user does not save/restore vector state in
+ * signals yet, so any library or compiler autovec code will
+ * corrupt our test.
+ *
+ * Do only minimal work in the signal handler.
+ */
+static void SEGV_handler(int signo, siginfo_t *info, void *context)
+{
+    unsigned long page = (unsigned long)info->si_addr &
+                             ~(unsigned long)(page_size - 1);
+
+    assert((unsigned long)info->si_addr >= fault_start);
+    assert((unsigned long)info->si_addr < fault_end);
+    if (fault_write) {
+        mprotect((void *)page, page_size, PROT_READ | PROT_WRITE);
+    } else {
+        mprotect((void *)page, page_size, PROT_READ);
+    }
+    nr_segv++;
+}
+
+/* Use noinline to make generated code easier to inspect */
+static __attribute__((noinline))
+uint8_t unit_load(uint8_t *mem, size_t nr, bool ff)
+{
+    size_t vl;
+    vuint8m1_t vec, redvec, sum;
+
+    vl = __riscv_vsetvl_e8m1(nr);
+    if (ff) {
+        vec = __riscv_vle8ff_v_u8m1(mem, &vl, vl);
+    } else {
+        vec = __riscv_vle8_v_u8m1(mem, vl);
+    }
+    redvec = __riscv_vmv_v_x_u8m1(0, vl);
+    sum = __riscv_vredsum_vs_u8m1_u8m1(vec, redvec, vl);
+    return __riscv_vmv_x_s_u8m1_u8(sum);
+}
+
+static __attribute__((noinline))
+uint8_t seg2_load(uint8_t *mem, size_t nr, bool ff)
+{
+    size_t vl;
+    vuint8m1x2_t segvec;
+    vuint8m1_t vec, redvec, sum;
+
+    vl = __riscv_vsetvl_e8m1(nr);
+    if (ff) {
+        segvec = __riscv_vlseg2e8ff_v_u8m1x2(mem, &vl, vl);
+    } else {
+        segvec = __riscv_vlseg2e8_v_u8m1x2(mem, vl);
+    }
+    vec = __riscv_vadd_vv_u8m1(__riscv_vget_v_u8m1x2_u8m1(segvec, 0),
+                   __riscv_vget_v_u8m1x2_u8m1(segvec, 1), vl);
+    redvec = __riscv_vmv_v_x_u8m1(0, vl);
+    sum = __riscv_vredsum_vs_u8m1_u8m1(vec, redvec, vl);
+    return __riscv_vmv_x_s_u8m1_u8(sum);
+}
+
+static __attribute__((noinline))
+uint8_t strided_load(uint8_t *mem, size_t nr, size_t stride)
+{
+    size_t vl;
+    vuint8m1_t vec, redvec, sum;
+
+    vl = __riscv_vsetvl_e8m1(nr);
+    vec = __riscv_vlse8_v_u8m1(mem, stride, vl);
+    redvec = __riscv_vmv_v_x_u8m1(0, vl);
+    sum = __riscv_vredsum_vs_u8m1_u8m1(vec, redvec, vl);
+    return __riscv_vmv_x_s_u8m1_u8(sum);
+}
+
+static __attribute__((noinline))
+uint8_t indexed_load(uint8_t *mem, size_t nr, uint32_t *indices)
+{
+    size_t vl;
+    vuint32m4_t idx;
+    vuint8m1_t vec, redvec, sum;
+
+    vl = __riscv_vsetvl_e8m1(nr);
+    idx = __riscv_vle32_v_u32m4(indices, vl);
+    vec = __riscv_vloxei32_v_u8m1(mem, idx, vl);
+    redvec = __riscv_vmv_v_x_u8m1(0, vl);
+    sum = __riscv_vredsum_vs_u8m1_u8m1(vec, redvec, vl);
+    return __riscv_vmv_x_s_u8m1_u8(sum);
+}
+
+/* New store functions */
+static __attribute__((noinline))
+void unit_store(uint8_t *mem, size_t nr, vuint8m1_t vec)
+{
+    size_t vl;
+
+    vl = __riscv_vsetvl_e8m1(nr);
+    __riscv_vse8_v_u8m1(mem, vec, vl);
+}
+
+static __attribute__((noinline))
+void seg2_store(uint8_t *mem, size_t nr, vuint8m1x2_t segvec)
+{
+    size_t vl;
+
+    vl = __riscv_vsetvl_e8m1(nr);
+    __riscv_vsseg2e8_v_u8m1x2(mem, segvec, vl);
+}
+
+static __attribute__((noinline))
+void strided_store(uint8_t *mem, size_t nr, size_t stride, vuint8m1_t vec)
+{
+    size_t vl;
+
+    vl = __riscv_vsetvl_e8m1(nr);
+    __riscv_vsse8_v_u8m1(mem, stride, vec, vl);
+}
+
+static __attribute__((noinline))
+void indexed_store(uint8_t *mem, size_t nr, uint32_t *indices, vuint8m1_t vec)
+{
+    size_t vl;
+    vuint32m4_t idx;
+
+    vl = __riscv_vsetvl_e8m1(nr);
+    idx = __riscv_vle32_v_u32m4(indices, vl);
+    __riscv_vsoxei32_v_u8m1(mem, idx, vec, vl);
+}
+
+/* Use e8 elements, 128-bit vectors */
+#define NR_ELEMS 16
+
+static int run_interrupted_v_tests(void)
+{
+    struct sigaction act = { 0 };
+    uint8_t *mem;
+    uint32_t indices[NR_ELEMS];
+    int i;
+
+    page_size = sysconf(_SC_PAGESIZE);
+
+    act.sa_flags = SA_SIGINFO;
+    act.sa_sigaction = &SEGV_handler;
+    if (sigaction(SIGSEGV, &act, NULL) == -1) {
+        perror("sigaction");
+        exit(EXIT_FAILURE);
+    }
+
+    mem = mmap(NULL, NR_ELEMS * page_size, PROT_READ | PROT_WRITE,
+               MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    assert(mem != MAP_FAILED);
+    madvise(mem, NR_ELEMS * page_size, MADV_NOHUGEPAGE);
+
+    /*** Load tests ***/
+    fault_write = false;
+
+    /* Unit-stride tests load memory crossing a page boundary */
+    memset(mem, 0, NR_ELEMS * page_size);
+    for (i = 0; i < NR_ELEMS; i++) {
+        mem[page_size - NR_ELEMS + i] = 3;
+    }
+    for (i = 0; i < NR_ELEMS; i++) {
+        mem[page_size + i] = 5;
+    }
+
+    nr_segv = 0;
+    fault_start = (unsigned long)&mem[page_size - (NR_ELEMS / 2)];
+    fault_end = fault_start + NR_ELEMS;
+    mprotect(mem, page_size * 2, PROT_NONE);
+    assert(unit_load(&mem[page_size - (NR_ELEMS / 2)], NR_ELEMS, false)
+                    == 8 * NR_ELEMS / 2);
+    assert(nr_segv == 2);
+
+    nr_segv = 0;
+    fault_start = (unsigned long)&mem[page_size - NR_ELEMS];
+    fault_end = fault_start + NR_ELEMS * 2;
+    mprotect(mem, page_size * 2, PROT_NONE);
+    assert(seg2_load(&mem[page_size - NR_ELEMS], NR_ELEMS, false)
+                    == 8 * NR_ELEMS);
+    assert(nr_segv == 2);
+
+    nr_segv = 0;
+    fault_start = (unsigned long)&mem[page_size - (NR_ELEMS / 2)];
+    fault_end = fault_start + (NR_ELEMS / 2);
+    mprotect(mem, page_size * 2, PROT_NONE);
+    assert(unit_load(&mem[page_size - (NR_ELEMS / 2)], NR_ELEMS, true)
+                    == 3 * NR_ELEMS / 2);
+    assert(nr_segv == 1); /* fault-first does not fault the second page */
+
+    nr_segv = 0;
+    fault_start = (unsigned long)&mem[page_size - NR_ELEMS];
+    fault_end = fault_start + NR_ELEMS;
+    mprotect(mem, page_size * 2, PROT_NONE);
+    assert(seg2_load(&mem[page_size - NR_ELEMS], NR_ELEMS * 2, true)
+                    == 3 * NR_ELEMS);
+    assert(nr_segv == 1); /* fault-first does not fault the second page */
+
+    /* Following tests load one element from first byte of each page */
+    mprotect(mem, page_size * 2, PROT_READ | PROT_WRITE);
+    memset(mem, 0, NR_ELEMS * page_size);
+    for (i = 0; i < NR_ELEMS; i++) {
+        mem[i * page_size] = 3;
+        indices[i] = i * page_size;
+    }
+
+    nr_segv = 0;
+    fault_start = (unsigned long)mem;
+    fault_end = fault_start + NR_ELEMS * page_size;
+    mprotect(mem, NR_ELEMS * page_size, PROT_NONE);
+    assert(strided_load(mem, NR_ELEMS, page_size) == 3 * NR_ELEMS);
+    assert(nr_segv == NR_ELEMS);
+
+    nr_segv = 0;
+    fault_start = (unsigned long)mem;
+    fault_end = fault_start + NR_ELEMS * page_size;
+    mprotect(mem, NR_ELEMS * page_size, PROT_NONE);
+    assert(indexed_load(mem, NR_ELEMS, indices) == 3 * NR_ELEMS);
+    assert(nr_segv == NR_ELEMS);
+
+    /*** Store tests ***/
+    fault_write = true;
+
+    uint8_t store_data[NR_ELEMS];
+    uint8_t store_data_seg0[NR_ELEMS];
+    uint8_t store_data_seg1[NR_ELEMS];
+    vuint8m1_t vec;
+    vuint8m1x2_t segvec;
+    size_t vl = __riscv_vsetvl_e8m1(NR_ELEMS);
+
+    /* Create some data to store */
+    for (i = 0; i < NR_ELEMS; i++) {
+        store_data[i] = i * 3;
+        store_data_seg0[i] = i * 5;
+        store_data_seg1[i] = i * 7;
+    }
+    vec = __riscv_vle8_v_u8m1(store_data, vl);
+    segvec = __riscv_vcreate_v_u8m1x2(
+        __riscv_vle8_v_u8m1(store_data_seg0, vl),
+        __riscv_vle8_v_u8m1(store_data_seg1, vl));
+
+    /* Unit-stride store test crossing a page boundary */
+    mprotect(mem, page_size * 2, PROT_READ | PROT_WRITE);
+    memset(mem, 0, page_size * 2);
+    nr_segv = 0;
+    fault_start = (unsigned long)&mem[page_size - (NR_ELEMS / 2)];
+    fault_end = fault_start + NR_ELEMS;
+    mprotect(mem, page_size * 2, PROT_NONE);
+    unit_store(&mem[page_size - (NR_ELEMS / 2)], NR_ELEMS, vec);
+    assert(nr_segv == 2);
+    for (i = 0; i < NR_ELEMS; i++) {
+        assert(mem[page_size - (NR_ELEMS / 2) + i] == store_data[i]);
+    }
+
+    /* Segmented store test crossing a page boundary */
+    mprotect(mem, page_size * 2, PROT_READ | PROT_WRITE);
+    memset(mem, 0, page_size * 2);
+    nr_segv = 0;
+    fault_start = (unsigned long)&mem[page_size - NR_ELEMS];
+    fault_end = fault_start + NR_ELEMS * 2;
+    mprotect(mem, page_size * 2, PROT_NONE);
+    seg2_store(&mem[page_size - NR_ELEMS], NR_ELEMS, segvec);
+    assert(nr_segv == 2);
+    for (i = 0; i < NR_ELEMS; i++) {
+        assert(mem[page_size - NR_ELEMS + i * 2] == store_data_seg0[i]);
+        assert(mem[page_size - NR_ELEMS + i * 2 + 1] == store_data_seg1[i]);
+    }
+
+    /* Strided store test to one element on each page */
+    mprotect(mem, NR_ELEMS * page_size, PROT_READ | PROT_WRITE);
+    memset(mem, 0, NR_ELEMS * page_size);
+    nr_segv = 0;
+    fault_start = (unsigned long)mem;
+    fault_end = fault_start + NR_ELEMS * page_size;
+    mprotect(mem, NR_ELEMS * page_size, PROT_NONE);
+    strided_store(mem, NR_ELEMS, page_size, vec);
+    assert(nr_segv == NR_ELEMS);
+    for (i = 0; i < NR_ELEMS; i++) {
+        assert(mem[i * page_size] == store_data[i]);
+    }
+
+    /* Indexed store test to one element on each page */
+    mprotect(mem, NR_ELEMS * page_size, PROT_READ | PROT_WRITE);
+    memset(mem, 0, NR_ELEMS * page_size);
+    nr_segv = 0;
+    fault_start = (unsigned long)mem;
+    fault_end = fault_start + NR_ELEMS * page_size;
+    mprotect(mem, NR_ELEMS * page_size, PROT_NONE);
+    indexed_store(mem, NR_ELEMS, indices, vec);
+    assert(nr_segv == NR_ELEMS);
+    for (i = 0; i < NR_ELEMS; i++) {
+        assert(mem[indices[i]] == store_data[i]);
+    }
+
+    munmap(mem, NR_ELEMS * page_size);
+
+    return 0;
+}
+
+int main(void)
+{
+    return run_interrupted_v_tests();
+}
-- 
2.51.0


