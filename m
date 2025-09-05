Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266C7CA1015
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 07:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuRGd-0006qk-1H; Fri, 05 Sep 2025 03:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uuRGZ-0006oj-N8; Fri, 05 Sep 2025 03:53:51 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uuRGU-0000GA-Au; Fri, 05 Sep 2025 03:53:50 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7723cf6e4b6so1505302b3a.3; 
 Fri, 05 Sep 2025 00:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757058819; x=1757663619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L40FU+2cHE+gg1yQw5PftfosyZFsMHdenZ9sL/QL4tM=;
 b=jzQk5tqmY+BaNcWC5LiZ0MXFggK/iann+8rqoFDZNEopGjGhZpWAyx5OZLTRh4YqZG
 NlL9Fly4P0tQMHbP9z2N0yJYVg/ASytcd5f1kYddeIJGmRi+m1EyUjGP0Hbl0IUT67Se
 I5SHmWvAFInmDr1biQDg7bNKyBqQ77pmPPT55NxHh4x7VFNpn8TXjxfpAN4hP9e9HG52
 PmC1Aq7twGUMjN7DqibTqEMz/B7AYhKVlWNJMki4svx/bqLbOL5ljQv4cm2Kes7kC5MK
 6v4ua2GyS762LCN8vu5xmaL51jAScB7I4htBImO2NELuyS8hPkBym7vMYF2V5RIIgJQp
 DbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757058819; x=1757663619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L40FU+2cHE+gg1yQw5PftfosyZFsMHdenZ9sL/QL4tM=;
 b=Rcu8v/CXZbB13R0K+W3i1+GiLg96Qi0hAM8z2Lciqf3j3z/wM3vTAKixWX6G3Hjdb9
 hOXKvymqQUvscOnsMfG75//AJsJiaWtFfZAy7tTU7QwCQZqOWyD+BJLHrBGQY0WC8RsH
 vtS4eSvTyTRcWSHTWa9WQQn31yc+ebNaEvgLDeIeOYF3dTAg1fzTxKQIOxgmGWG2ywx6
 Z0YyDg3ZzPHr4YUFJaMUr7UCayc32ZOVxmT7QlAs26fp4R9bpnTPMy7lruFRmEFsZJor
 zf2uMnrfK7k7ucdlAf6FeRW43wpTD523gRcVkgMU9UzFrzsfKlT2dV7F4pd9/cty9c84
 EUQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzPcoG1YIqvm+7yY+UsUNKBe5ewv0JA8tSsk1bYctwn08DndGi894t5+SYY/GxGA+jpenwhN5aziD0@nongnu.org
X-Gm-Message-State: AOJu0Yw7N7EtDTTovuKt1AKz73ThUCbUJeGbwyAQX2tsg4+6yme7PLZu
 7P8W60GH37O133EWrqVBD1Fj5zo6W9I1UpO7J6hMcp+XDOHe9kTdXehboBuULeae
X-Gm-Gg: ASbGncuOkRWz95DdFHJwSD9bwyWtScPjOmbANo//1xqsd7lYliWEBV7Js6Kdd9HCKtX
 K9qlaEpJ4ZLo6oOFC0yuIhOrcDdZx6rC/y9DsxzJ2VWmaFVKheJkiW64siFCO64YOUlMwttS+bO
 McFRdb88E1ZG6GvpOrTkLOofWsWvd3Ysp4Iq7rHT/kec4VqrUKZ4uUrSbEXZ9skguU4QNi52YB9
 b11yT9+fBImGtPCSwTwx1ay9NZmoLj+80M6SbDCBWkrotcI65jpbieMNbAXsASd0FCkK+ik6oo1
 G6YdAUTEG4cE0GiC1HTfofXBkrEUCoIIpnnpAQ4v95RqgF8TdkaaJsvTGFvmE8h57CqYmkdKybQ
 iOXSh+0W3NGKJnZSvxTvJZKZKobM=
X-Google-Smtp-Source: AGHT+IFB/vw9mwESMq8P1KFJ3RDS9liUVu3YjWlHP1w2GiV13wL4Gv0V1T+Q1l2vIegPidE9ccXMDg==
X-Received: by 2002:a05:6a00:23c7:b0:771:e434:6c7d with SMTP id
 d2e1a72fcca58-7723e262b24mr25194459b3a.12.1757058818929; 
 Fri, 05 Sep 2025 00:53:38 -0700 (PDT)
Received: from lima-default ([1.146.99.18]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a26ae02sm20967560b3a.21.2025.09.05.00.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 00:53:38 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] tests/tcg: Add riscv test for interrupted vector ops
Date: Fri,  5 Sep 2025 17:49:58 +1000
Message-ID: <20250905074959.426911-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905074959.426911-1-npiggin@gmail.com>
References: <20250905074959.426911-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
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
 tests/tcg/riscv64/Makefile.target      |   5 +
 tests/tcg/riscv64/test-interrupted-v.c | 208 +++++++++++++++++++++++++
 2 files changed, 213 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-interrupted-v.c

diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefile.target
index daa0c6688f..45a76e75ef 100644
--- a/tests/tcg/riscv64/Makefile.target
+++ b/tests/tcg/riscv64/Makefile.target
@@ -27,4 +27,9 @@ ifeq ($(HAVE_RISCV_VECTOR_INTRINSICS),y)
 TESTS += test-vstart-overflow
 test-vstart-overflow: CFLAGS += -march=rv64gcv
 run-test-vstart-overflow: QEMU_OPTS += -cpu rv64,v=on
+
+# Test for interrupted vector instructions
+TESTS += test-interrupted-v
+test-interrupted-v: CFLAGS += -march=rv64gcv
+run-test-interrupted-v: QEMU_OPTS += -cpu rv64,v=on
 endif
diff --git a/tests/tcg/riscv64/test-interrupted-v.c b/tests/tcg/riscv64/test-interrupted-v.c
new file mode 100644
index 0000000000..db4fb6092f
--- /dev/null
+++ b/tests/tcg/riscv64/test-interrupted-v.c
@@ -0,0 +1,208 @@
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
+    mprotect((void *)page, page_size, PROT_READ);
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


