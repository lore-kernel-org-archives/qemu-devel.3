Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E68CF436BB
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 16:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDmIR-0003TB-Ay; Fri, 17 Apr 2026 12:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wDmI5-0003OJ-5P
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 12:43:38 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wDmI2-0004sR-EM
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 12:43:36 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48897fd88ebso9577835e9.2
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 09:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776444213; x=1777049013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U9CvVkvNrCqRyV0yuj7Bc/GxfHKGTD1fL27261kvzsI=;
 b=rzR5YZT2w7N1T5l/g0wPreG+Y35fxL2d5AzIttQDaA2iDb/SISAVRadTtnwPVk+cSk
 /yVXETn5ApzNz0uA6kyUq54l4srrsi+wHNrsC2/jhssUIFLsbWweKMwnU0RkuZSJeL8B
 jkA1AS45sgQ2r2kXvaqaL1wgqICMntwElg9gjBbqBR5IYqN04W8mBJJ4H3KOzzEiLwMx
 UtxLlEeGfybg+qKbVRHXWOEdcACbYhRHjV/EeU5gAHna41ZH7LM5knywo21nQxkJwD9j
 qGop79/bCdO7cs+moFeaw2SHvKcPPSsJbjhPMTWmIb0MHVcMOtPPvczI9+/PGR+BdFFO
 BjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776444213; x=1777049013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U9CvVkvNrCqRyV0yuj7Bc/GxfHKGTD1fL27261kvzsI=;
 b=lTrghZCDe4ARFN4nSr/zNVDuD3HU+gX08cYaz35Z8sNE9JWmUZiAeWWVyYxX0BIsHb
 2zudRbo9qlu9k46U8qB/MUcM4ENR0djhwJ+QfUwZ7hOKl/ObQWUAIR3GdnjIBpEOylQr
 7mq0PdWsUhudy+sDCgHD7ntwgIK6UwyDrsHvaflH2BfQlnTU8jcJ2cTYncOWmbvUc5fq
 Ty3/21LGkJwQTxtvHOhDx9nSgoQVQakmDkxMe1n2akcblMuG90VULGOB9AU6VIYuQ+8F
 VSenwYRDqlTl3Yh0U1MYPE6o9q+cPegdu3zfdNwSiMRzI276pWuUDAOLH4UJZel1n7gk
 Pz/g==
X-Gm-Message-State: AOJu0Yzjze8AKLqVY7gVP4Dkub+QbRq4Ku68BKZX1fN3El7OTdXDXbk7
 FuCL4Q59l424WRhQiEpURcxPu2wkXqP4GARnd93mOEIt/t2BY2SajMSAIUv05mXiXowIqz49083
 KwfOaT58=
X-Gm-Gg: AeBDiesmk8X4k0jT6w+3umksh/ehIFWDzKgH8AZiU0/IDj9+I0GeY2COOQLj41lUHLB
 VQYcrUhd1F0meb5XONMpAu6+ZHkdMGTgnJ0j8l9yjvA2p1+mfJtoNYTlK+OpRa903B63LaaWNtH
 /s861AtXwieTOiKC8oudl80BJRR5Qizv+G3eeCpMYxTcoiKadZTAbOwmglde+POHw21oZ4uqOqv
 uShAhsuQ0VPVsITFdyWmZRRLiHxIiw4Ls8BHa2GJt97MBJf63Tjd78adlpOgqM1OoJ+mryDsRPo
 9b6CLK/XfiC1j0YR5FjbtZEmkKNeV3vjhWfc7/dgM9nkRokkQj2o1cg+rICS7JgKFJTf7mJd9LA
 NeTimiPu8Sgquq+x6sbwBJ6IH+4WpEUix3oj/NsFUL6vJOAVo88Jgq/aufGF5tPm+4Ho/k7qhEh
 qg8xTV+RvQ2jCt4ZOhjFksGa6wQHu8X4855BDfBZdush4/
X-Received: by 2002:a05:600c:4e16:b0:488:d6eb:e63a with SMTP id
 5b1f17b1804b1-488fb76fe73mr54724945e9.14.1776444212803; 
 Fri, 17 Apr 2026 09:43:32 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm5345640f8f.34.2026.04.17.09.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 09:43:31 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D05EB5F9DC;
 Fri, 17 Apr 2026 17:43:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 4/7] tests/tcg: move aarch64 page table setup to c code
Date: Fri, 17 Apr 2026 17:43:24 +0100
Message-ID: <20260417164328.1009132-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260417164328.1009132-1-alex.bennee@linaro.org>
References: <20260417164328.1009132-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

If we want more flexibility messing around with page tables lets do it
without having to rely on assembly for it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
AJB
  - a result of -O0 does mean each helper ends up with a stack frame
    being needed to do the relatively simple mask and shift. I've
    experimented with -O1 and trying to manually enable inlining but
    couldn't get anything to work.
---
 tests/tcg/aarch64/system/lib/pgtable.h    |  80 ++++++++++++++++
 tests/tcg/aarch64/system/lib/sysregs.h    |  20 ++++
 tests/tcg/aarch64/system/lib/pgtable.c    |  60 ++++++++++++
 tests/tcg/aarch64/Makefile.softmmu-target |   9 +-
 tests/tcg/aarch64/system/boot.S           | 109 +---------------------
 tests/tcg/aarch64/system/kernel.ld        |   3 +
 6 files changed, 170 insertions(+), 111 deletions(-)
 create mode 100644 tests/tcg/aarch64/system/lib/pgtable.h
 create mode 100644 tests/tcg/aarch64/system/lib/pgtable.c

diff --git a/tests/tcg/aarch64/system/lib/pgtable.h b/tests/tcg/aarch64/system/lib/pgtable.h
new file mode 100644
index 00000000000..c5048c3eea1
--- /dev/null
+++ b/tests/tcg/aarch64/system/lib/pgtable.h
@@ -0,0 +1,80 @@
+/*
+ * AArch64 page table helpers
+ *
+ * Some simple helper functions for setting the page table entries.
+ *
+ * Copyright (C) 2026 Linaro Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+/*
+ * Page Table Descriptors
+ */
+#define DESC_VALID       (1ULL << 0)
+#define DESC_TYPE_TABLE  (1ULL << 1)
+#define DESC_TYPE_BLOCK  (0ULL << 1)
+#define DESC_TYPE_PAGE   (1ULL << 1)
+
+#define DESC_AF          (1ULL << 10)
+#define DESC_ATTRINDX(i) ((uint64_t)(i) << 2)
+#define DESC_NS          (1ULL << 5)
+#define DESC_UXN         (1ULL << 53)
+#define DESC_PXN         (1ULL << 54)
+
+#define DESC_ADDR_MASK          0x0000FFFFFFFFF000ULL
+#define DESC_ADDR_BLOCK_L1      0x0000FFFFC0000000ULL
+#define DESC_ADDR_BLOCK_L2      0x0000FFFFFFE00000ULL
+
+/* Stage 2 specific */
+#define DESC_S2_AP_RW           (3ULL << 6)
+#define DESC_S2_MEMATTR_NORMAL  (0xfULL << 2)
+
+/**
+ * pgt_map_l1_table - Setup a Level 1 table pointing to a Level 2 table
+ * @table: the level 1 table
+ * @va: the virtual address to map
+ * @next_table: the level 2 table to point to
+ */
+static inline void pgt_map_l1_table(uint64_t *table, uintptr_t va, uint64_t *next_table)
+{
+    int index = (va >> 30) & 0x1ff;
+    table[index] = ((uintptr_t)next_table & DESC_ADDR_MASK) | DESC_TYPE_TABLE | DESC_VALID;
+}
+
+/**
+ * pgt_map_l1_block - Setup a Level 1 block mapping (1GB)
+ * @table: the level 1 table
+ * @va: the virtual address to map
+ * @pa: the physical address to map to
+ * @flags: the descriptor flags (e.g. DESC_AF | ...)
+ */
+static inline void pgt_map_l1_block(uint64_t *table, uintptr_t va, uintptr_t pa, uint64_t flags)
+{
+    int index = (va >> 30) & 0x1ff;
+    table[index] = (pa & DESC_ADDR_BLOCK_L1) | flags | DESC_TYPE_BLOCK | DESC_VALID;
+}
+
+/**
+ * pgt_map_l2_block - Setup a Level 2 block mapping (2MB)
+ * @table: the level 2 table
+ * @va: the virtual address to map
+ * @pa: the physical address to map to
+ * @flags: the descriptor flags (e.g. DESC_AF | ...)
+ */
+static inline void pgt_map_l2_block(uint64_t *table, uintptr_t va, uintptr_t pa, uint64_t flags)
+{
+    int index = (va >> 21) & 0x1ff;
+    table[index] = (pa & DESC_ADDR_BLOCK_L2) | flags | DESC_TYPE_BLOCK | DESC_VALID;
+}
+
+/**
+ * flat_map_stage2 - Setup a flat (VA==PA) stage 2 mapping
+ * @table: the level 2 table
+ * @addr: the VA/PA to map
+ * @flags: the descriptor flags (e.g. DESC_AF | ...)
+ */
+static inline void flat_map_stage2(uint64_t *table, uintptr_t addr, uint64_t flags)
+{
+    pgt_map_l2_block(table, addr, addr, flags);
+}
diff --git a/tests/tcg/aarch64/system/lib/sysregs.h b/tests/tcg/aarch64/system/lib/sysregs.h
index b1c465e0746..6e714f46842 100644
--- a/tests/tcg/aarch64/system/lib/sysregs.h
+++ b/tests/tcg/aarch64/system/lib/sysregs.h
@@ -20,3 +20,23 @@
         asm volatile("msr " __stringify(r) ", %x0"  \
                  : : "rZ" (__val));                 \
 } while (0)
+
+#define isb() asm volatile("isb" : : : "memory")
+#define dsb(opt) asm volatile("dsb " #opt : : : "memory")
+
+/*
+ * SCTLR_EL1 Bits
+ */
+#define SCTLR_EL1_M      (1ULL << 0)  /* enable MMU for EL0/1 */
+#define SCTLR_EL1_C      (1ULL << 2)  /* Data cachability control */
+#define SCTLR_EL1_SA     (1ULL << 3)  /* SP alignment check */
+#define SCTLR_EL1_I      (1ULL << 12) /* Instruction cachability control */
+
+/*
+ * TCR_EL1 Bits
+ */
+#define TCR_EL1_T0SZ(s)  ((s) & 0x3fULL)
+#define TCR_EL1_IRGN0_WBWA (3ULL << 8)
+#define TCR_EL1_ORGN0_WBWA (3ULL << 10)
+#define TCR_EL1_IPS_40BIT  (2ULL << 32)
+#define TCR_EL1_TG0_4KB    (0ULL << 14)
diff --git a/tests/tcg/aarch64/system/lib/pgtable.c b/tests/tcg/aarch64/system/lib/pgtable.c
new file mode 100644
index 00000000000..a558f5f0dd5
--- /dev/null
+++ b/tests/tcg/aarch64/system/lib/pgtable.c
@@ -0,0 +1,60 @@
+#include <stdint.h>
+#include "sysregs.h"
+#include "pgtable.h"
+
+/*
+ * Page table setup for AArch64 system tests.
+ * We use a flat identity mapping.
+ */
+
+/* Symbols defined in kernel.ld */
+extern char _text_start[];
+extern char _data_start[];
+extern char _tag_start[];
+
+/* Assume these start zeroed */
+uint64_t ttb_l1[512] __attribute__((aligned(4096)));
+uint64_t ttb_l2[512] __attribute__((aligned(4096)));
+
+/*
+ * Setup a flat address mapping page-tables. Stage one simply
+ * maps RAM to the first Gb. The stage2 tables have two 2mb
+ * translation block entries covering a series of adjacent
+ * 4k pages.
+ */
+void setup_pgtables(void)
+{
+    /* L1 entry points to L2 table */
+    pgt_map_l1_table(ttb_l1, (uintptr_t)_text_start, ttb_l2);
+
+    /* L2 entries: 2MB blocks */
+    /* .text & .rodata (Read-only, executable) */
+    flat_map_stage2(ttb_l2, (uintptr_t)_text_start, DESC_AF);
+
+    /* .data & .bss (Read-write, no-execute) */
+    flat_map_stage2(ttb_l2, (uintptr_t)_data_start, DESC_AF | DESC_PXN | DESC_UXN);
+
+    /* mte_page (Read-write, no-execute, AttrIndx=1) */
+    flat_map_stage2(ttb_l2, (uintptr_t)_tag_start, DESC_AF | DESC_PXN | DESC_UXN | DESC_ATTRINDX(1));
+
+    /* Set TTBR0_EL1 */
+    write_sysreg(ttb_l1, ttbr0_el1);
+
+    /* Set MAIR_EL1 */
+    write_sysreg(0xeeULL, mair_el1);
+
+    /* Set TCR_EL1 */
+    uint64_t tcr = TCR_EL1_IPS_40BIT | TCR_EL1_TG0_4KB | TCR_EL1_ORGN0_WBWA | TCR_EL1_IRGN0_WBWA | TCR_EL1_T0SZ(25);
+    write_sysreg(tcr, tcr_el1);
+    isb();
+
+    /* Enable MMU via SCTLR_EL1 */
+    uint64_t sctlr = read_sysreg(sctlr_el1);
+    sctlr &= ~(1ULL << 1); /* Clear A (alignment check) */
+    sctlr &= ~(1ULL << 19); /* Clear WXN */
+    sctlr |= SCTLR_EL1_M | SCTLR_EL1_C | SCTLR_EL1_I | SCTLR_EL1_SA;
+
+    dsb(sy);
+    write_sysreg(sctlr, sctlr_el1);
+    isb();
+}
diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index c7f44803c73..5770ae1fb0c 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -6,10 +6,10 @@ AARCH64_SRC=$(SRC_PATH)/tests/tcg/aarch64
 AARCH64_SYSTEM_SRC=$(AARCH64_SRC)/system
 AARCH64_SYSTEM_LIB=$(AARCH64_SRC)/system/lib
 
-VPATH+=$(AARCH64_SYSTEM_SRC)
+VPATH+=$(AARCH64_SYSTEM_SRC) $(AARCH64_SYSTEM_LIB)
 
 # These objects provide the basic boot code and helper functions for all tests
-CRT_OBJS=boot.o
+CRT_OBJS=boot.o pgtable.o
 
 AARCH64_TEST_C_SRCS=$(wildcard $(AARCH64_SYSTEM_SRC)/*.c)
 AARCH64_TEST_S_SRCS=$(AARCH64_SYSTEM_SRC)/mte.S
@@ -37,9 +37,12 @@ config-cc.mak: Makefile
 # building head blobs
 .PRECIOUS: $(CRT_OBJS)
 
-%.o: $(CRT_PATH)/%.S
+%.o: %.S
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
 
+%.o: %.c
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
+
 # Build and link the tests
 %: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
diff --git a/tests/tcg/aarch64/system/boot.S b/tests/tcg/aarch64/system/boot.S
index 8bfa4e4efc7..bee8d9372e7 100644
--- a/tests/tcg/aarch64/system/boot.S
+++ b/tests/tcg/aarch64/system/boot.S
@@ -243,102 +243,7 @@ at_testel:
 	msr	vbar_el1, x0
 
 	/* Page table setup (identity mapping). */
-	adrp	x0, ttb
-	add	x0, x0, :lo12:ttb
-	msr	ttbr0_el1, x0
-
-	/*
-	 * Setup a flat address mapping page-tables. Stage one simply
-	 * maps RAM to the first Gb. The stage2 tables have two 2mb
-	 * translation block entries covering a series of adjacent
-	 * 4k pages.
-	 */
-
-	/* Stage 1 entry: indexed by IA[38:30] */
-	adr	x1, .				/* phys address */
-	bic	x1, x1, #(1 << 30) - 1		/* 1GB alignment*/
-	add	x2, x0, x1, lsr #(30 - 3)	/* offset in l1 page table */
-
-	/* point to stage 2 table [47:12] */
-	adrp	x0, ttb_stage2
-	orr 	x1, x0, #3 			/* ptr to stage 2 */
-	str	x1, [x2]
-
-	/* Stage 2 entries: indexed by IA[29:21] */
-	ldr	x5, =(((1 << 9) - 1) << 21)
-
-	/* First block: .text/RO/execute enabled */
-	adr	x1, .				/* phys address */
-	bic	x1, x1, #(1 << 21) - 1		/* 2mb block alignment	*/
-	and	x4, x1, x5			/* IA[29:21] */
-	add	x2, x0, x4, lsr #(21 - 3)	/* offset in l2 page table */
-	ldr	x3, =0x401			/* attr(AF, block) */
-	orr	x1, x1, x3
-	str	x1, [x2]			/* 1st 2mb (.text & rodata) */
-
-	/* Second block: .data/RW/no execute */
-	adrp	x1, .data
-	add	x1, x1, :lo12:.data
-	bic	x1, x1, #(1 << 21) - 1		/* 2mb block alignment */
-	and	x4, x1, x5			/* IA[29:21] */
-	add	x2, x0, x4, lsr #(21 - 3)	/* offset in l2 page table */
-	ldr	x3, =(3 << 53) | 0x401		/* attr(AF, NX, block) */
-	orr	x1, x1, x3
-	str	x1, [x2]			/* 2nd 2mb (.data & .bss)*/
-
-	/* Third block: at 'mte_page', set in kernel.ld */
-	adrp	x1, mte_page
-	add	x1, x1, :lo12:mte_page
-	bic	x1, x1, #(1 << 21) - 1
-	and 	x4, x1, x5
-	add	x2, x0, x4, lsr #(21 - 3)
-	/* attr(AF, NX, block, AttrIndx=Attr1) */
-	ldr	x3, =(3 << 53) | 0x401 | (1 << 2)
-	orr	x1, x1, x3
-	str	x1, [x2]
-
-	/* Setup/enable the MMU.  */
-
-	/*
-	 * TCR_EL1 - Translation Control Registers
-	 *
-	 * IPS[34:32] = 40-bit PA, 1TB
-	 * TG0[14:15] = b00 => 4kb granuale
-	 * ORGN0[11:10] = Outer: Normal, WB Read-Alloc No Write-Alloc Cacheable
-	 * IRGN0[9:8] = Inner: Normal, WB Read-Alloc No Write-Alloc Cacheable
-	 * T0SZ[5:0]  = 2^(64 - 25)
-	 *
-	 * The size of T0SZ controls what the initial lookup level. It
-	 * would be nice to start at level 2 but unfortunately for a
-	 * flat-mapping on the virt machine we need to handle IA's
-	 * with at least 1gb range to see RAM. So we start with a
-	 * level 1 lookup.
-	 */
-	ldr	x0, = (2 << 32) | 25 | (3 << 10) | (3 << 8)
-	msr	tcr_el1, x0
-
-	mov	x0, #0xee			/* Inner/outer cacheable WB */
-	msr	mair_el1, x0
-	isb
-
-	/*
-	 * SCTLR_EL1 - System Control Register
-	 *
-	 * WXN[19] = 0 = no effect, Write does not imply XN (execute never)
-	 * I[12] = Instruction cachability control
-	 * SA[3] = SP alignment check
-	 * C[2] = Data cachability control
-	 * M[0] = 1, enable stage 1 address translation for EL0/1
-	 */
-	mrs	x0, sctlr_el1
-	ldr	x1, =0x100d			/* bits I(12) SA(3) C(2) M(0) */
-	bic	x0, x0, #(1 << 1)		/* clear bit A(1) */
-	bic	x0, x0, #(1 << 19)		/* clear WXN */
-	orr	x0, x0, x1			/* set bits */
-
-	dsb	sy
-	msr	sctlr_el1, x0
-	isb
+	bl	setup_pgtables
 
 	/*
 	 * Enable FP/SVE registers. The standard C pre-amble will be
@@ -392,18 +297,6 @@ cmdline:
 	.space 128, 0
 
 	.align	12
-
-	/* Translation table
-	 * @4k granuale: 9 bit lookup, 512 entries
-	*/
-ttb:
-	.space	4096, 0
-
-	.align	12
-ttb_stage2:
-	.space	4096, 0
-
-	.align	12
 system_stack:
 	.space 4096, 0
 system_stack_end:
diff --git a/tests/tcg/aarch64/system/kernel.ld b/tests/tcg/aarch64/system/kernel.ld
index aef043e31db..267ffcbe520 100644
--- a/tests/tcg/aarch64/system/kernel.ld
+++ b/tests/tcg/aarch64/system/kernel.ld
@@ -13,10 +13,12 @@ MEMORY {
 
 SECTIONS {
     .text : {
+        _text_start = .;
         *(.text)
         *(.rodata)
     } >TXT
     .data : {
+        _data_start = .;
         *(.data)
         *(.bss)
     } >DAT
@@ -25,6 +27,7 @@ SECTIONS {
          * Symbol 'mte_page' is used in boot.S to setup the PTE and in the mte.S
          * test as the address that the MTE instructions operate on.
          */
+        _tag_start = .;
         mte_page = .;
     } >TAG
     /DISCARD/ : {
-- 
2.47.3


