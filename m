Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6F9D4A5EE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgabA-0005JC-E3; Thu, 15 Jan 2026 22:34:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgab9-0005Il-7r
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:34:07 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgab7-0005Wy-CG
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:34:06 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-ba599137cf8so555641a12.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534444; x=1769139244; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UDkM7uIkvNm6fLdpIQ/hnja2LnP7PMDxeJXBu7Pf1iw=;
 b=hDKpu1UaPTXKZwELIyb5s9KOq6vA9U5wDwwDIxx5IE/epu8ttLicTs0eMWBP8DqRki
 vHxFkxz0yR3WoO2aLa6/RLkZPBEQpsCVoHQBnZKL++ifst/Zf+prDBm0nkkMerjXSrl3
 iyKQ8eevKGyS3Gf8Qip+6lsB9OlCDR+MZ2piq+PHVay/Pk4ZunVJ63SZyEUfOPNkNHhO
 vI7+PVTp3Df6VkL7XdkcnD+84u/eZgQEWnrkxLOu1FF4HxQhyfdfOgk5QucNpSSL/tCH
 vKzRcjr2U+u1y54uYNKEsoKOi69Nnen/k6hfeqmzPBXWp7j2N3i6ymRhSHKEv8n7wbmi
 n2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534444; x=1769139244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UDkM7uIkvNm6fLdpIQ/hnja2LnP7PMDxeJXBu7Pf1iw=;
 b=QHw0fO4kUHObiZGTWSWR0aQAI/Az1E5cTUiRl7smTqo+wimALz6Z9P75yfl4rx6VKE
 krZxm9JAn/zr9zSt5OHLztZvP22/Z+e1an5QdZrqt2K72QyC6NmDXtGbdontdmbo9Do1
 w6Ml+diKffIimcrMFaIn7/GfAy5V8t06lwEf3EqQnPRd5EhqoI00QWkwZ58Jz9rk21AF
 3+83lBuMNJei72wI4zZ9+ZrpnisfpBQLE3FYjDcFAuB8qsJwaMvgvZGs0m0YDWU/x8LG
 jk2ZGkbquBkhHUul2OVAOEyXQQ9Ffbo6M8kFG6y1rLspJsUzx2G4lv+P7XvmxMqZxDoU
 MS0Q==
X-Gm-Message-State: AOJu0Yx+/3rRO4AikrcB3UhldWr4hLChpqCR3jNZWaxlEKiQHZaOwZB5
 VyFrhSgBJlh8GK+63LJk6u+4XO/PZc19Y7PKzxd401I3QYS+crFQdNuPvcbC/7ERtaxWSLaP/8n
 JCnp289mzsA==
X-Gm-Gg: AY/fxX7++bW3nSWcxpCZEpA0j44TO2GPe/11Ze5ZEkNQq2K93ZnQlT0aQGbncmmv3GA
 +gmGrDDrQdGcQAgG7LbHpaI0/Q8xcwOqaGku4H1BOAPFefTJI9Ji1QgvsIxcRT2AdVlgbqVmFRg
 rbYhusdrGgXV8qs4PyWLj2SP7ouwowyQoRInM6956OV2BzgKlvMFPaSqF+61RDtWTeZ7KP5Nqz7
 4zdzU20qqKpodAiNucF9nENS4UYPJbcJ1v4cbMtM3yNJ4n3T08fmtzxb6jPqV8TRwk7yDuhMC5r
 78PTPXbOtyJJQymHVaIbk/5FmlMnAGqkx3ohtOR5EIdkOv2MIpjE3HD3AJk5oCMc+RKTeIVRFF9
 7NofiorJsoNFH/3riUr7x95pmklKSR4gQwjdFDZbCrf2pghbYk4hTsb0s8bVsFeSxAm4BUvmmoX
 FzDr39O0RGZKbwOFrppA==
X-Received: by 2002:a17:90b:4cc2:b0:32e:3592:581a with SMTP id
 98e67ed59e1d1-35272ce863bmr1430473a91.17.1768534443919; 
 Thu, 15 Jan 2026 19:34:03 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:34:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 12/58] *: Remove __i386__ tests
Date: Fri, 16 Jan 2026 14:32:18 +1100
Message-ID: <20260116033305.51162-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

Remove instances of __i386__, except from tests and imported headers.

Drop a block containing sanity check and fprintf error message for
i386-on-i386 or x86_64-on-x86_64 emulation.  If we really want
something like this, we would do it via some form of compile-time check.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
index 67ad681098..3601715769 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7452,15 +7452,6 @@ void syscall_init(void)
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
index 0742f1212d..de0f3a8ebe 100755
--- a/configure
+++ b/configure
@@ -382,8 +382,6 @@ fi
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


