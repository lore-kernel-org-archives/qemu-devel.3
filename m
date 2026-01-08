Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87DED148A0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdibl-0005FD-9L; Thu, 08 Jan 2026 00:30:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibX-00054Y-S6
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:41 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibU-0005If-1f
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:37 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-bc274b8b15bso1867998a12.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850235; x=1768455035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uCFnZTBtXiYfE2GsTuOjtEBWiqrAh6+U/6CfMo8kNmo=;
 b=cTwrSZmzr6D5cqPIWrW7/aT7Zgowa2brHqoG/8Lmffb/XuY49T2H2fdZOw6IF138jT
 g50A9Ocht9iaZcp0KDL0B6gxTaFUSTM7DhyoI4JBOI80SDyoZhTukTMQNK/hyoAGskzK
 1jy0veMT1+g4BuqEU3De/65w6bZf1UkOLbctTUmfKOl0hq6l2aGxuYZOCruspIKuz/pD
 0rfSTZ0Vqu0uAuy3fNGJ3As8rIcnIOefL0ZePlw9t+E/ofxPWsX+9m5KbiMHjJuDsQzy
 wcNd1NCsXO3juWDFzncxIlqHZnU/rBjSRZ76XL6D2NvZenajEU7EqGJBcENUSAjWpXzU
 6eEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850235; x=1768455035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uCFnZTBtXiYfE2GsTuOjtEBWiqrAh6+U/6CfMo8kNmo=;
 b=v7Y3B3lZOGk/WmHM5rtz//JhnpSOmET7qpKvB748wgXm70GOZ/1BEPpbr8JJFRTN+c
 RlJZPlUKA3u5HYBxwRzKjyxtAQJqeioaNy5UbRLWTa01N3PcouzDsElEJr4nLmkoor8U
 1xcCz3wubcOLCNalUH/srjUpsGHJmcw06bDSh5BAxZ2SebZtQQnOlTyr4iHo88kzmGt1
 tUOUbxUCsrwDatJcKBup5/k0zHXWiKLme0ELBaDYMCjG4zLIQHPjoFpDfaZ6OjEhEVtj
 5AruW1l35P8mbD29rEwPM3wX/GGRvn3kPFLdsqlP54W0qp8LCTMuLBUpR2sFv3qsqZRl
 SHaQ==
X-Gm-Message-State: AOJu0Yz4gLSsjXkxtuv4oeROksiwM1cl3Z3XtNDBnHzgbuZFlrYGGS/T
 O6crD6RweBiop6I96nzeGPvJ7rlFQXD36dLUZTLc/AMsdYq8yB0YsBI5/0QlGyfpcp7NKr4Wb0j
 KnmHqdoI=
X-Gm-Gg: AY/fxX6dLPU7d0MbkuKO2an+Lz7qOwG7THOftbx/Z1M58OFhXyfln5L/44UEPd583CM
 u3lmpk5e6A2ywNY5YWAo5jVWX/OyFv1CDEM/N4ekDYDMBodeIWDfOWdwrZcjrsEQmaO3221RlCZ
 qo4gIsh6MlZ+Ob4RS/zecsfEOZrVNQOs/5EQkoJOGm6XsYXWem9usoJBdFPBnfHdHicsUb3G8Pf
 /VmfnGWCiB/W8ulBkXunqtBZhlkfzhTdwH+JPHgc3it/Zb3uj77npMHkXp/eq2RKa5dAIZoTVKx
 qtupf2Ot+zj6dNlE+ShEH+Y32ecOcRAMXsXNdS4ATsYHTHyba397iG4vM3F0++bXDQRcTn6+qLH
 nEd1NiElQnaTG6OSE4a6F7sEsHFqUh0QZVTQAznRPMHZLZlD232upgVG+eOftTKUacYkxNXhEuS
 QAG1KwdYPYi27uwNLWFw==
X-Google-Smtp-Source: AGHT+IHsAXltPcYhYjTqohEN/rsHWrhDm1u2Hw+Rahgcpi+cIGEssiuVtO9jWYSOuBlj8E0Rn+89Gw==
X-Received: by 2002:a05:6a20:939d:b0:384:f573:42b9 with SMTP id
 adf61e73a8af0-3898f9dd0a2mr4537683637.67.1767850234603; 
 Wed, 07 Jan 2026 21:30:34 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd9d9sm7036552a12.16.2026.01.07.21.30.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:30:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/50] *: Remove __i386__ tests
Date: Thu,  8 Jan 2026 16:29:33 +1100
Message-ID: <20260108053018.626690-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

Remove instances of __i386__, except from tests and imported headers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/atomic.h     |  4 ++--
 include/qemu/cacheflush.h |  2 +-
 include/qemu/osdep.h      |  4 +---
 include/qemu/processor.h  |  2 +-
 include/qemu/timer.h      |  9 ---------
 tcg/tci/tcg-target-mo.h   |  2 +-
 accel/kvm/kvm-all.c       |  2 +-
 disas/disas-host.c        |  6 ------
 hw/display/xenfb.c        | 10 +---------
 linux-user/syscall.c      |  9 ---------
 target/i386/cpu.c         | 10 ----------
 util/cacheflush.c         |  2 +-
 configure                 |  2 --
 13 files changed, 9 insertions(+), 55 deletions(-)

diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index f80cba24cf..c39dc99f2f 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -204,7 +204,7 @@
  * the same semantics.
  */
 #if !defined(QEMU_SANITIZE_THREAD) && \
-    (defined(__i386__) || defined(__x86_64__) || defined(__s390x__))
+    (defined(__x86_64__) || defined(__s390x__))
 # define smp_mb__before_rmw() signal_barrier()
 # define smp_mb__after_rmw() signal_barrier()
 #else
@@ -218,7 +218,7 @@
  */
 
 #if !defined(QEMU_SANITIZE_THREAD) && \
-    (defined(__i386__) || defined(__x86_64__) || defined(__s390x__))
+    (defined(__x86_64__) || defined(__s390x__))
 # define qatomic_set_mb(ptr, i) \
     ({ (void)qatomic_xchg(ptr, i); smp_mb__after_rmw(); })
 #else
diff --git a/include/qemu/cacheflush.h b/include/qemu/cacheflush.h
index 76eb55d818..8c64b87814 100644
--- a/include/qemu/cacheflush.h
+++ b/include/qemu/cacheflush.h
@@ -19,7 +19,7 @@
  * mappings of the same physical page(s).
  */
 
-#if defined(__i386__) || defined(__x86_64__) || defined(__s390__)
+#if defined(__x86_64__) || defined(__s390__)
 
 static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
 {
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 4cdeda0b9c..b384b5b506 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -637,9 +637,7 @@ bool qemu_has_ofd_lock(void);
 
 bool qemu_has_direct_io(void);
 
-#if defined(__HAIKU__) && defined(__i386__)
-#define FMT_pid "%ld"
-#elif defined(WIN64)
+#ifdef WIN64
 #define FMT_pid "%" PRId64
 #else
 #define FMT_pid "%d"
diff --git a/include/qemu/processor.h b/include/qemu/processor.h
index 9f0dcdf28f..95b3262f8b 100644
--- a/include/qemu/processor.h
+++ b/include/qemu/processor.h
@@ -7,7 +7,7 @@
 #ifndef QEMU_PROCESSOR_H
 #define QEMU_PROCESSOR_H
 
-#if defined(__i386__) || defined(__x86_64__)
+#if defined(__x86_64__)
 # define cpu_relax() asm volatile("rep; nop" ::: "memory")
 
 #elif defined(__aarch64__)
diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 8b561cd696..7c18da1652 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -866,15 +866,6 @@ static inline int64_t cpu_get_host_ticks(void)
     return retval;
 }
 
-#elif defined(__i386__)
-
-static inline int64_t cpu_get_host_ticks(void)
-{
-    int64_t val;
-    asm volatile ("rdtsc" : "=A" (val));
-    return val;
-}
-
 #elif defined(__x86_64__)
 
 static inline int64_t cpu_get_host_ticks(void)
diff --git a/tcg/tci/tcg-target-mo.h b/tcg/tci/tcg-target-mo.h
index 779872e39a..b5b389dafc 100644
--- a/tcg/tci/tcg-target-mo.h
+++ b/tcg/tci/tcg-target-mo.h
@@ -8,7 +8,7 @@
 #define TCG_TARGET_MO_H
 
 /*
- * We could notice __i386__ or __s390x__ and reduce the barriers depending
+ * We could notice __x86_64__ or __s390x__ and reduce the barriers depending
  * on the host.  But if you want performance, you use the normal backend.
  * We prefer consistency across hosts on this.
  */
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f85eb42d78..8301a512e7 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -61,7 +61,7 @@
 #include <sys/eventfd.h>
 #endif
 
-#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
+#if defined(__x86_64__) || defined(__aarch64__)
 # define KVM_HAVE_MCE_INJECTION 1
 #endif
 
diff --git a/disas/disas-host.c b/disas/disas-host.c
index 88e7d8800c..7cf432938e 100644
--- a/disas/disas-host.c
+++ b/disas/disas-host.c
@@ -44,12 +44,6 @@ static void initialize_debug_host(CPUDebug *s)
 #endif
 #if defined(CONFIG_TCG_INTERPRETER)
     s->info.print_insn = print_insn_tci;
-#elif defined(__i386__)
-    s->info.mach = bfd_mach_i386_i386;
-    s->info.cap_arch = CS_ARCH_X86;
-    s->info.cap_mode = CS_MODE_32;
-    s->info.cap_insn_unit = 1;
-    s->info.cap_insn_split = 8;
 #elif defined(__x86_64__)
     s->info.mach = bfd_mach_x86_64;
     s->info.cap_arch = CS_ARCH_X86;
diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index 164fd0b248..ba886a940e 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -459,10 +459,7 @@ static int xenfb_map_fb(struct XenFB *xenfb)
          */
         uint32_t *ptr32 = NULL;
         uint32_t *ptr64 = NULL;
-#if defined(__i386__)
-        ptr32 = (void*)page->pd;
-        ptr64 = ((void*)page->pd) + 4;
-#elif defined(__x86_64__)
+#if defined(__x86_64__)
         ptr32 = ((void*)page->pd) - 4;
         ptr64 = (void*)page->pd;
 #endif
@@ -480,11 +477,6 @@ static int xenfb_map_fb(struct XenFB *xenfb)
         /* 64bit dom0, 32bit domU */
         mode = 32;
         pd   = ((void*)page->pd) - 4;
-#elif defined(__i386__)
-    } else if (strcmp(protocol, XEN_IO_PROTO_ABI_X86_64) == 0) {
-        /* 32bit dom0, 64bit domU */
-        mode = 64;
-        pd   = ((void*)page->pd) + 4;
 #endif
     }
 
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 2060e561a2..63713f1992 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7449,15 +7449,6 @@ void syscall_init(void)
                               ~(TARGET_IOC_SIZEMASK << TARGET_IOC_SIZESHIFT)) |
                 (size << TARGET_IOC_SIZESHIFT);
         }
-
-        /* automatic consistency check if same arch */
-#if (defined(__i386__) && defined(TARGET_I386) && defined(TARGET_ABI32)) || \
-    (defined(__x86_64__) && defined(TARGET_X86_64))
-        if (unlikely(ie->target_cmd != ie->host_cmd)) {
-            fprintf(stderr, "ERROR: ioctl(%s): target=0x%x host=0x%x\n",
-                    ie->name, ie->target_cmd, ie->host_cmd);
-        }
-#endif
         ie++;
     }
 }
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 37803cd724..0b8cca7cec 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2251,16 +2251,6 @@ void host_cpuid(uint32_t function, uint32_t count,
                  : "=a"(vec[0]), "=b"(vec[1]),
                    "=c"(vec[2]), "=d"(vec[3])
                  : "0"(function), "c"(count) : "cc");
-#elif defined(__i386__)
-    asm volatile("pusha \n\t"
-                 "cpuid \n\t"
-                 "mov %%eax, 0(%2) \n\t"
-                 "mov %%ebx, 4(%2) \n\t"
-                 "mov %%ecx, 8(%2) \n\t"
-                 "mov %%edx, 12(%2) \n\t"
-                 "popa"
-                 : : "a"(function), "c"(count), "S"(vec)
-                 : "memory", "cc");
 #else
     abort();
 #endif
diff --git a/util/cacheflush.c b/util/cacheflush.c
index 69c9614e2c..99221a409f 100644
--- a/util/cacheflush.c
+++ b/util/cacheflush.c
@@ -225,7 +225,7 @@ static void __attribute__((constructor)) init_cache_info(void)
  * Architecture (+ OS) specific cache flushing mechanisms.
  */
 
-#if defined(__i386__) || defined(__x86_64__) || defined(__s390__)
+#if defined(__x86_64__) || defined(__s390__)
 
 /* Caches are coherent and do not require flushing; symbol inline. */
 
diff --git a/configure b/configure
index 2016062492..00e455be57 100755
--- a/configure
+++ b/configure
@@ -377,8 +377,6 @@ fi
 if test ! -z "$cpu" ; then
   # command line argument
   :
-elif check_define __i386__ ; then
-  cpu="i386"
 elif check_define __x86_64__ ; then
   if check_define __ILP32__ ; then
     cpu="x32"
-- 
2.43.0


