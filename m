Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314C4C36005
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 17:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twPGX-0005qP-VU; Sun, 23 Mar 2025 13:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGW-0005p8-54
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:40 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGS-0002tI-OJ
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:39 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-227a8cdd241so13077305ad.3
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 10:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742751455; x=1743356255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9/Tq8455Xl28q7efQW3SLtflxU6Hj8gr8oQW0BIa1vs=;
 b=BuMIbuMuWTXUDEPn5Nrt/GFlLu1ZItNBMZPMMIF/lrmzZkdDVt3pCgiXsWzpHWsh4a
 9rETYhXY8w4XIca6rj6wPsJeCgIRRP4pUdrKfkBwrnYPmJutKy6+bp0ppT2LaJiXVW2d
 84giPDVE+kLQhh7LhwmoSZ+4N5Aq+NMUdFbpBzdFrOvOtVuQ/3Z+JM1X49tyqdnP60h/
 iGf52sO5/NUR49S5R36TapGM8a8UvzDFBZvokKLNi1P3FSDQxckb+i6tDGrjlql0ovrc
 v+vPiPyG41m452TuHUoqsAFrSTvL2QRF9tolN8frT5un/vftvYrlddSkzV5Cq08h9Ujk
 PQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742751455; x=1743356255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9/Tq8455Xl28q7efQW3SLtflxU6Hj8gr8oQW0BIa1vs=;
 b=Csk3Ep55pVvmmtMtGEl8VYTKwiD8PSWDonXUIKDWDtz06ttcHgZM0KYE+vXGUcbkWs
 AoqLwpif1dAJTucE9I5hzBJ3VNFquD9/xAOsoUwEmZhhD74dikTxtjlyAQw+3SzkZtq/
 79Q61M9VB/JgwQ06lcNQ0+zpWLcQFiynD8rBlhUJOk7iq4JHpCjHbfwLwdivB1cmLlly
 o70f15yNuB2ZRCbMJhQeORGhvTPt91nqbNX30axHvDFSHUSObEpDbkagUiuuxjnx/fuM
 knOToYLFhybA02Y6jHAj2pv2UJBr/W+l1AvSlnci3Nx2lY8HGzEDqJlJjZFPYwBWgQlV
 KZ/Q==
X-Gm-Message-State: AOJu0YyamtFzS0IPYjzMu/bLcNuxRodmFxxC0iyUGWzRwTyuaW+nwpNc
 +QJs1kXuSi62C+zzD8q1sA7Kcsys0gmjP3aNS+NuiV3TTHhHtB6bBdkI+0qtevGSAp+X/i/Eib9
 X
X-Gm-Gg: ASbGnctPpRWq34olvh2+bCUOxUkmQVXGhRkrtBVdUHhCK2dym6o2YPiKpES8mupTD1u
 sdO7OBDR4/nv1w5IL9pWP2m4pasR4EezorFCZ2a3tlP6WiLIv4temRiV8MgiH7sFH0PVDrbsz42
 GIkcrtQsGrph7y0Y0RSrw+TkCmnXqGC+6NiNpzBfdzQPVgaGBwzq/y7oMtqL7iod56Ye8t4uG+c
 Mxdgg9qAOu6ympnH+IQUC8mD4oSVse68P1ZjpbeOEC2jz8oD/k0HLnGW2GVrJB4ViReGI9exBEO
 PHNBuFEswdynT4x4cMLLToyMr7Uq8mGd3lWy2qb6IRLoVX8NcYJyQSl59u33inLmlp1/YnJNd2p
 F
X-Google-Smtp-Source: AGHT+IGKvT8qm0wChFsqWsxeKZ+j+oxfopqxoeEguwbwTSqH4umTXD8XEjAMzuxazBVvQqgyJrHFiw==
X-Received: by 2002:a17:902:e54d:b0:21f:1549:a55a with SMTP id
 d9443c01a7336-22780c50856mr151984365ad.1.1742751455161; 
 Sun, 23 Mar 2025 10:37:35 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22781209ff3sm54075165ad.257.2025.03.23.10.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 10:37:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mrolnik@gmail.com,
	philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH 05/17] target/avr: Move cpu register accesses into system
 memory
Date: Sun, 23 Mar 2025 10:37:17 -0700
Message-ID: <20250323173730.3213964-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250323173730.3213964-1-richard.henderson@linaro.org>
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Integrate the i/o 0x00-0x1f and 0x38-0x3f loopbacks into
the cpu registers with normal address space accesses.
We no longer need to trap accesses to the first page within
avr_cpu_tlb_fill but can wait until a write occurs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/cpu.h       |   7 ++
 target/avr/helper.h    |   3 -
 target/avr/cpu.c       |  16 +++
 target/avr/helper.c    | 239 +++++++++++++++++------------------------
 target/avr/translate.c |  42 ++++----
 5 files changed, 146 insertions(+), 161 deletions(-)

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 84a8f5cc8c..be27b0152b 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -23,6 +23,7 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
+#include "exec/memory.h"
 
 #ifdef CONFIG_USER_ONLY
 #error "AVR 8-bit does not support user mode"
@@ -142,6 +143,9 @@ struct ArchCPU {
 
     CPUAVRState env;
 
+    MemoryRegion cpu_reg1;
+    MemoryRegion cpu_reg2;
+
     /* Initial value of stack pointer */
     uint32_t init_sp;
 };
@@ -242,6 +246,9 @@ bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                       MMUAccessType access_type, int mmu_idx,
                       bool probe, uintptr_t retaddr);
 
+extern const MemoryRegionOps avr_cpu_reg1;
+extern const MemoryRegionOps avr_cpu_reg2;
+
 #include "exec/cpu-all.h"
 
 #endif /* QEMU_AVR_CPU_H */
diff --git a/target/avr/helper.h b/target/avr/helper.h
index 4d02e648fa..e8d13e925f 100644
--- a/target/avr/helper.h
+++ b/target/avr/helper.h
@@ -23,7 +23,4 @@ DEF_HELPER_1(debug, noreturn, env)
 DEF_HELPER_1(break, noreturn, env)
 DEF_HELPER_1(sleep, noreturn, env)
 DEF_HELPER_1(unsupported, noreturn, env)
-DEF_HELPER_3(outb, void, env, i32, i32)
-DEF_HELPER_2(inb, tl, env, i32)
 DEF_HELPER_3(fullwr, void, env, i32, i32)
-DEF_HELPER_2(fullrd, tl, env, i32)
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 834c7082aa..0b14b36c17 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -23,6 +23,7 @@
 #include "qemu/qemu-print.h"
 #include "exec/exec-all.h"
 #include "exec/translation-block.h"
+#include "exec/address-spaces.h"
 #include "cpu.h"
 #include "disas/dis-asm.h"
 #include "tcg/debug-assert.h"
@@ -110,6 +111,8 @@ static void avr_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 static void avr_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
+    CPUAVRState *env = cpu_env(cs);
+    AVRCPU *cpu = env_archcpu(env);
     AVRCPUClass *mcc = AVR_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
@@ -122,6 +125,19 @@ static void avr_cpu_realizefn(DeviceState *dev, Error **errp)
     cpu_reset(cs);
 
     mcc->parent_realize(dev, errp);
+
+    /*
+     * Two blocks in the low data space loop back into cpu registers.
+     */
+    memory_region_init_io(&cpu->cpu_reg1, OBJECT(cpu), &avr_cpu_reg1, env,
+                          "avr-cpu-reg1", 32);
+    memory_region_add_subregion(get_system_memory(),
+                                OFFSET_DATA, &cpu->cpu_reg1);
+
+    memory_region_init_io(&cpu->cpu_reg2, OBJECT(cpu), &avr_cpu_reg2, env,
+                          "avr-cpu-reg2", 8);
+    memory_region_add_subregion(get_system_memory(),
+                                OFFSET_DATA + 0x58, &cpu->cpu_reg2);
 }
 
 static void avr_cpu_set_int(void *opaque, int irq, int level)
diff --git a/target/avr/helper.c b/target/avr/helper.c
index e5bf16c6b7..df7e2109d4 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -108,7 +108,7 @@ bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                       MMUAccessType access_type, int mmu_idx,
                       bool probe, uintptr_t retaddr)
 {
-    int prot, page_size = TARGET_PAGE_SIZE;
+    int prot;
     uint32_t paddr;
 
     address &= TARGET_PAGE_MASK;
@@ -133,23 +133,9 @@ bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         /* Access to memory. */
         paddr = OFFSET_DATA + address;
         prot = PAGE_READ | PAGE_WRITE;
-        if (address < NUMBER_OF_CPU_REGISTERS + NUMBER_OF_IO_REGISTERS) {
-            /*
-             * Access to CPU registers, exit and rebuilt this TB to use
-             * full access in case it touches specially handled registers
-             * like SREG or SP.  For probing, set page_size = 1, in order
-             * to force tlb_fill to be called for the next access.
-             */
-            if (probe) {
-                page_size = 1;
-            } else {
-                cpu_env(cs)->fullacc = 1;
-                cpu_loop_exit_restore(cs, retaddr);
-            }
-        }
     }
 
-    tlb_set_page(cs, address, paddr, prot, mmu_idx, page_size);
+    tlb_set_page(cs, address, paddr, prot, mmu_idx, TARGET_PAGE_SIZE);
     return true;
 }
 
@@ -203,134 +189,78 @@ void helper_wdr(CPUAVRState *env)
 }
 
 /*
- * This function implements IN instruction
- *
- * It does the following
- * a.  if an IO register belongs to CPU, its value is read and returned
- * b.  otherwise io address is translated to mem address and physical memory
- *     is read.
- * c.  it caches the value for sake of SBI, SBIC, SBIS & CBI implementation
- *
+ * The first 32 bytes of the data space are mapped to the cpu regs.
+ * We cannot write these from normal store operations because TCG
+ * does not expect global temps to be modified -- a global may be
+ * live in a host cpu register across the store.  We can however
+ * read these, as TCG does make sure the global temps are saved
+ * in case the load operation traps.
  */
-target_ulong helper_inb(CPUAVRState *env, uint32_t port)
+
+static uint64_t avr_cpu_reg1_read(void *opaque, hwaddr addr, unsigned size)
 {
-    target_ulong data = 0;
+    CPUAVRState *env = opaque;
 
-    switch (port) {
-    case 0x38: /* RAMPD */
-        data = 0xff & (env->rampD >> 16);
-        break;
-    case 0x39: /* RAMPX */
-        data = 0xff & (env->rampX >> 16);
-        break;
-    case 0x3a: /* RAMPY */
-        data = 0xff & (env->rampY >> 16);
-        break;
-    case 0x3b: /* RAMPZ */
-        data = 0xff & (env->rampZ >> 16);
-        break;
-    case 0x3c: /* EIND */
-        data = 0xff & (env->eind >> 16);
-        break;
-    case 0x3d: /* SPL */
-        data = env->sp & 0x00ff;
-        break;
-    case 0x3e: /* SPH */
-        data = env->sp >> 8;
-        break;
-    case 0x3f: /* SREG */
-        data = cpu_get_sreg(env);
-        break;
-    default:
-        /* not a special register, pass to normal memory access */
-        data = address_space_ldub(&address_space_memory,
-                                  OFFSET_IO_REGISTERS + port,
-                                  MEMTXATTRS_UNSPECIFIED, NULL);
-    }
-
-    return data;
+    assert(addr < 32);
+    return env->r[addr];
 }
 
 /*
- *  This function implements OUT instruction
- *
- *  It does the following
- *  a.  if an IO register belongs to CPU, its value is written into the register
- *  b.  otherwise io address is translated to mem address and physical memory
- *      is written.
- *  c.  it caches the value for sake of SBI, SBIC, SBIS & CBI implementation
- *
+ * The range 0x58-0x5f of the data space are mapped to cpu regs.
+ * As above, we cannot write these from normal store operations.
  */
-void helper_outb(CPUAVRState *env, uint32_t port, uint32_t data)
-{
-    data &= 0x000000ff;
 
-    switch (port) {
-    case 0x38: /* RAMPD */
-        if (avr_feature(env, AVR_FEATURE_RAMPD)) {
-            env->rampD = (data & 0xff) << 16;
-        }
-        break;
-    case 0x39: /* RAMPX */
-        if (avr_feature(env, AVR_FEATURE_RAMPX)) {
-            env->rampX = (data & 0xff) << 16;
-        }
-        break;
-    case 0x3a: /* RAMPY */
-        if (avr_feature(env, AVR_FEATURE_RAMPY)) {
-            env->rampY = (data & 0xff) << 16;
-        }
-        break;
-    case 0x3b: /* RAMPZ */
-        if (avr_feature(env, AVR_FEATURE_RAMPZ)) {
-            env->rampZ = (data & 0xff) << 16;
-        }
-        break;
-    case 0x3c: /* EIDN */
-        env->eind = (data & 0xff) << 16;
-        break;
-    case 0x3d: /* SPL */
-        env->sp = (env->sp & 0xff00) | (data);
-        break;
-    case 0x3e: /* SPH */
-        if (avr_feature(env, AVR_FEATURE_2_BYTE_SP)) {
-            env->sp = (env->sp & 0x00ff) | (data << 8);
-        }
-        break;
-    case 0x3f: /* SREG */
-        cpu_set_sreg(env, data);
-        break;
-    default:
-        /* not a special register, pass to normal memory access */
-        address_space_stb(&address_space_memory, OFFSET_IO_REGISTERS + port,
-                          data, MEMTXATTRS_UNSPECIFIED, NULL);
+static uint64_t avr_cpu_reg2_read(void *opaque, hwaddr addr, unsigned size)
+{
+    CPUAVRState *env = opaque;
+
+    switch (addr) {
+    case 0: /* RAMPD */
+        return 0xff & (env->rampD >> 16);
+    case 1: /* RAMPX */
+        return 0xff & (env->rampX >> 16);
+    case 2: /* RAMPY */
+        return 0xff & (env->rampY >> 16);
+    case 3: /* RAMPZ */
+        return 0xff & (env->rampZ >> 16);
+    case 4: /* EIND */
+        return 0xff & (env->eind >> 16);
+    case 5: /* SPL */
+        return env->sp & 0x00ff;
+    case 6: /* SPH */
+        return 0xff & (env->sp >> 8);
+    case 7: /* SREG */
+        return cpu_get_sreg(env);
     }
+    g_assert_not_reached();
 }
 
-/*
- *  this function implements LD instruction when there is a possibility to read
- *  from a CPU register
- */
-target_ulong helper_fullrd(CPUAVRState *env, uint32_t addr)
+static void avr_cpu_trap_write(void *opaque, hwaddr addr,
+                               uint64_t data64, unsigned size)
 {
-    uint8_t data;
+    CPUAVRState *env = opaque;
+    CPUState *cs = env_cpu(env);
 
-    env->fullacc = false;
-
-    if (addr < NUMBER_OF_CPU_REGISTERS) {
-        /* CPU registers */
-        data = env->r[addr];
-    } else if (addr < NUMBER_OF_CPU_REGISTERS + NUMBER_OF_IO_REGISTERS) {
-        /* IO registers */
-        data = helper_inb(env, addr - NUMBER_OF_CPU_REGISTERS);
-    } else {
-        /* memory */
-        data = address_space_ldub(&address_space_memory, OFFSET_DATA + addr,
-                                  MEMTXATTRS_UNSPECIFIED, NULL);
-    }
-    return data;
+    env->fullacc = true;
+    cpu_loop_exit_restore(cs, cs->mem_io_pc);
 }
 
+const MemoryRegionOps avr_cpu_reg1 = {
+    .read = avr_cpu_reg1_read,
+    .write = avr_cpu_trap_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 1,
+};
+
+const MemoryRegionOps avr_cpu_reg2 = {
+    .read = avr_cpu_reg2_read,
+    .write = avr_cpu_trap_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 1,
+};
+
 /*
  *  this function implements ST instruction when there is a possibility to write
  *  into a CPU register
@@ -339,19 +269,50 @@ void helper_fullwr(CPUAVRState *env, uint32_t data, uint32_t addr)
 {
     env->fullacc = false;
 
-    /* Following logic assumes this: */
-    assert(OFFSET_IO_REGISTERS == OFFSET_DATA +
-                                  NUMBER_OF_CPU_REGISTERS);
-
-    if (addr < NUMBER_OF_CPU_REGISTERS) {
+    switch (addr) {
+    case 0 ... 31:
         /* CPU registers */
         env->r[addr] = data;
-    } else if (addr < NUMBER_OF_CPU_REGISTERS + NUMBER_OF_IO_REGISTERS) {
-        /* IO registers */
-        helper_outb(env, addr - NUMBER_OF_CPU_REGISTERS, data);
-    } else {
-        /* memory */
+        break;
+
+    case 0x58: /* RAMPD */
+        if (avr_feature(env, AVR_FEATURE_RAMPD)) {
+            env->rampD = data << 16;
+        }
+        break;
+    case 0x59: /* RAMPX */
+        if (avr_feature(env, AVR_FEATURE_RAMPX)) {
+            env->rampX = data << 16;
+        }
+        break;
+    case 0x5a: /* RAMPY */
+        if (avr_feature(env, AVR_FEATURE_RAMPY)) {
+            env->rampY = data << 16;
+        }
+        break;
+    case 0x5b: /* RAMPZ */
+        if (avr_feature(env, AVR_FEATURE_RAMPZ)) {
+            env->rampZ = data << 16;
+        }
+        break;
+    case 0x5c: /* EIDN */
+        env->eind = data << 16;
+        break;
+    case 0x5d: /* SPL */
+        env->sp = (env->sp & 0xff00) | data;
+        break;
+    case 0x5e: /* SPH */
+        if (avr_feature(env, AVR_FEATURE_2_BYTE_SP)) {
+            env->sp = (env->sp & 0x00ff) | (data << 8);
+        }
+        break;
+    case 0x5f: /* SREG */
+        cpu_set_sreg(env, data);
+        break;
+
+    default:
         address_space_stb(&address_space_memory, OFFSET_DATA + addr, data,
                           MEMTXATTRS_UNSPECIFIED, NULL);
+        break;
     }
 }
diff --git a/target/avr/translate.c b/target/avr/translate.c
index e7f8ced9b3..0490936cd5 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -194,6 +194,9 @@ static bool avr_have_feature(DisasContext *ctx, int feature)
 static bool decode_insn(DisasContext *ctx, uint16_t insn);
 #include "decode-insn.c.inc"
 
+static void gen_inb(DisasContext *ctx, TCGv data, int port);
+static void gen_outb(DisasContext *ctx, TCGv data, int port);
+
 /*
  * Arithmetic Instructions
  */
@@ -1293,9 +1296,8 @@ static bool trans_SBRS(DisasContext *ctx, arg_SBRS *a)
 static bool trans_SBIC(DisasContext *ctx, arg_SBIC *a)
 {
     TCGv data = tcg_temp_new_i32();
-    TCGv port = tcg_constant_i32(a->reg);
 
-    gen_helper_inb(data, tcg_env, port);
+    gen_inb(ctx, data, a->reg);
     tcg_gen_andi_tl(data, data, 1 << a->bit);
     ctx->skip_cond = TCG_COND_EQ;
     ctx->skip_var0 = data;
@@ -1311,9 +1313,8 @@ static bool trans_SBIC(DisasContext *ctx, arg_SBIC *a)
 static bool trans_SBIS(DisasContext *ctx, arg_SBIS *a)
 {
     TCGv data = tcg_temp_new_i32();
-    TCGv port = tcg_constant_i32(a->reg);
 
-    gen_helper_inb(data, tcg_env, port);
+    gen_inb(ctx, data, a->reg);
     tcg_gen_andi_tl(data, data, 1 << a->bit);
     ctx->skip_cond = TCG_COND_NE;
     ctx->skip_var0 = data;
@@ -1502,11 +1503,18 @@ static void gen_data_store(DisasContext *ctx, TCGv data, TCGv addr)
 
 static void gen_data_load(DisasContext *ctx, TCGv data, TCGv addr)
 {
-    if (ctx->base.tb->flags & TB_FLAGS_FULL_ACCESS) {
-        gen_helper_fullrd(data, tcg_env, addr);
-    } else {
-        tcg_gen_qemu_ld_tl(data, addr, MMU_DATA_IDX, MO_UB);
-    }
+    tcg_gen_qemu_ld_tl(data, addr, MMU_DATA_IDX, MO_UB);
+}
+
+static void gen_inb(DisasContext *ctx, TCGv data, int port)
+{
+    gen_data_load(ctx, data, tcg_constant_i32(port + NUMBER_OF_CPU_REGISTERS));
+}
+
+static void gen_outb(DisasContext *ctx, TCGv data, int port)
+{
+    gen_helper_fullwr(tcg_env, data,
+                      tcg_constant_i32(port + NUMBER_OF_CPU_REGISTERS));
 }
 
 /*
@@ -2126,9 +2134,8 @@ static bool trans_SPMX(DisasContext *ctx, arg_SPMX *a)
 static bool trans_IN(DisasContext *ctx, arg_IN *a)
 {
     TCGv Rd = cpu_r[a->rd];
-    TCGv port = tcg_constant_i32(a->imm);
 
-    gen_helper_inb(Rd, tcg_env, port);
+    gen_inb(ctx, Rd, a->imm);
     return true;
 }
 
@@ -2139,9 +2146,8 @@ static bool trans_IN(DisasContext *ctx, arg_IN *a)
 static bool trans_OUT(DisasContext *ctx, arg_OUT *a)
 {
     TCGv Rd = cpu_r[a->rd];
-    TCGv port = tcg_constant_i32(a->imm);
 
-    gen_helper_outb(tcg_env, port, Rd);
+    gen_outb(ctx, Rd, a->imm);
     return true;
 }
 
@@ -2407,11 +2413,10 @@ static bool trans_SWAP(DisasContext *ctx, arg_SWAP *a)
 static bool trans_SBI(DisasContext *ctx, arg_SBI *a)
 {
     TCGv data = tcg_temp_new_i32();
-    TCGv port = tcg_constant_i32(a->reg);
 
-    gen_helper_inb(data, tcg_env, port);
+    gen_inb(ctx, data, a->reg);
     tcg_gen_ori_tl(data, data, 1 << a->bit);
-    gen_helper_outb(tcg_env, port, data);
+    gen_outb(ctx, data, a->reg);
     return true;
 }
 
@@ -2422,11 +2427,10 @@ static bool trans_SBI(DisasContext *ctx, arg_SBI *a)
 static bool trans_CBI(DisasContext *ctx, arg_CBI *a)
 {
     TCGv data = tcg_temp_new_i32();
-    TCGv port = tcg_constant_i32(a->reg);
 
-    gen_helper_inb(data, tcg_env, port);
+    gen_inb(ctx, data, a->reg);
     tcg_gen_andi_tl(data, data, ~(1 << a->bit));
-    gen_helper_outb(tcg_env, port, data);
+    gen_outb(ctx, data, a->reg);
     return true;
 }
 
-- 
2.43.0


