Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFFF1061B00
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 14:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Deq-0001Aa-RX; Mon, 30 Mar 2026 10:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7DeS-00015S-M7
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:31:39 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7DeM-0002dO-Nt
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:31:34 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48557c8ad47so34809085e9.0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 07:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774881089; x=1775485889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FyGLkbR92NTumPuyUeCJS2oJhBp8cITIz5HhLWLYSAU=;
 b=jUnDI7FRjkaXoaHRp7sPfQcoldAh6Wz4CaXm5U4HTuKwtxJq7r4h82Py5RlXq13AhX
 dA+PNwHB5BQDnfQ/uAPVOq9WWi0kwQtjr63OXgJiua/qt96IEL4H+7gYdLLJRFqq8n5P
 1mwGssqotHI6RG/yhxXRxHJklnQxIaMV2wmFAh6zDSADBzVrb2GYRkVi8XyDbK3UhvVY
 FcjefGY6MdLm1/iQU3+dH8tj8oOKcHqlB+PzSxJ5EwfkA/NzniUNUBYgNqx3szjxImp+
 AqpmN+OkpgLL5J+57OUUPFXqo+3iFWBLvi3RXfBqknYLGQMPJ+UnFvQtmaHd58gLLC7Z
 r6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774881089; x=1775485889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FyGLkbR92NTumPuyUeCJS2oJhBp8cITIz5HhLWLYSAU=;
 b=d+dnrPEyX30UG9ZzWu+EwB4bI/1xe84S+EWbKxsRwjeapLkx2FdwwT8trlKmtp0n/0
 0QS0P7G8CBzxQRyxm0+1tofZQ3J9me902N3W+FduQZL/yT+Bi32greIhsfMIAo87W2Cq
 IH6zlR+Munzx1JzwsEjYaCtFcYj0PM8jHqF6U/VtSWEN6FDX6s5ttaFDtv4TFTBPBVGa
 HzSTUWZ0SxDbsfard0bTU7OvWuUa5Zw9SlY8TDzO2ThVEJFot9RTMz/vw9v6Rhy7VGec
 43fb1KLymrKFh/x49fqUlOcJ8BvxhLZvYVCFlUUa5+zgUZjixRk0nXCVtL6WRl9E5Yth
 2axQ==
X-Gm-Message-State: AOJu0Ywsb+Uw19eZL1RbVu9+0QyD7eTpRL0tPv2yhHwUvhmrfYxoWe2N
 PmX6wKJTUFWjm5yeToLvgDBSvVXRRit6dWDqIKpt+k90rVWRbIRVekT1MsD484V61Q0DYn3dzB0
 a+SgvctY=
X-Gm-Gg: ATEYQzzl4KFPvZ5XM895ZPSEnJ2Fz7L8CzMfoStydJCBCyQlIHWhuOPjFSodXPmTaSz
 l5TATVO8QkroNlYpJlTySMxbxOq7qEljWAHhTBNnxiKRhC2fgX0RRYGcbfg8DyFFH3ORr3PPPzo
 8pHjrNefhq22TKKSVAIsBQ0W0Q9Q8sE+uxzkKsqb+4Z+tYoZHhFe3bZril6RoGK80P7/GYuhqYd
 ozoJ9eYceA0r8J+bayYHFvzBbVc6O4EcWnR5Ynv9Le/fumYpC2xf/dRYOmPydnowarAV1rOv4ML
 g0syb/hYkhR9Gd7jmKe9B6+ff31zcoryEOnEdUzPnC7EnarukMH635S2tWvbHiFhme+fc30IL/w
 VcHlz3TUNb4HpjSLPqL3OaX7g1Wh7HKXICdEsIuSjoEOnyhhK6lI/KvZyeblZXmla6LALsVujuu
 UzFq9E025O4zAcqDPjXLrszstT3YEpNDTKdBGRd1uylKhoqwcYZjWOQ+Q4GY0bAno2Il6dN5KcL
 gOi94saRUMOS7vLLo2mDKhYP9r2cCI=
X-Received: by 2002:a05:600c:a06:b0:487:1108:48af with SMTP id
 5b1f17b1804b1-48727d59ce3mr229984535e9.4.1774881088735; 
 Mon, 30 Mar 2026 07:31:28 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722d49c18sm279767145e9.14.2026.03.30.07.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 07:31:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 2/2] include/user/guest-host.h: Provide g2h etc for both
 abi_ptr and vaddr
Date: Mon, 30 Mar 2026 15:31:23 +0100
Message-ID: <20260330143123.1685142-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330143123.1685142-1-peter.maydell@linaro.org>
References: <20260330143123.1685142-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In commit 7804c84a ("include/user: Use vaddr in guest-host.h") we
changed all the functions in guest-host.h that took or returned their
guest address argument in type abi_ptr to instead use vaddr.

This introduced regressions for the case of a 32-bit guest and an
address above 2GB for the common situation where the address is a
syscall argument stored in a variable of type 'abi_long'.  With
abi_ptr (which will be an unsigned 32-bit type for 32-bit guests),
the address is cast to unsigned 32-bit, and then zero-extended to
64-bits in g2h_untagged_vaddr().  With the switch to vaddr (which is
always a 64-bit unsigned type), the guest address will instead be
sign-extended to 64 bits, which gives the wrong answer.

Fix this by providing two versions of the affected functions: the
standard names (g2h(), g2h_untagged(), guest_addr_valid_untagged(),
guest_range_valid_untagged(), cpu_untagged_addr()) return to using
the logically-correct abi_ptr type; new versions with a _vaddr()
prefix use the vaddr type.

accel/tcg/user-exec.c must change to use the _vaddr() versions; this
is the only file that uses guest-host.h that we want to compile once.
All the other uses are in linux-user and bsd-user code that
inherently has to know the sizes of target-ABI types.

Cc: qemu-stable@nongnu.org
Fixes: 7804c84a ("include/user: Use vaddr in guest-host.h")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3333
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/tcg/user-exec.c     | 26 ++++++++--------
 include/user/guest-host.h | 62 +++++++++++++++++++++++++++++++++++----
 2 files changed, 69 insertions(+), 19 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index f8b4a26711..d283d3cc72 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -647,7 +647,7 @@ void tb_lock_page0(tb_page_addr_t address)
 
     if (prot & PAGE_WRITE) {
         pageflags_set_clear(start, last, 0, PAGE_WRITE);
-        mprotect(g2h_untagged(start), last - start + 1,
+        mprotect(g2h_untagged_vaddr(start), last - start + 1,
                  prot & (PAGE_READ | PAGE_EXEC) ? PROT_READ : PROT_NONE);
     }
 }
@@ -734,7 +734,7 @@ int page_unprotect(CPUState *cpu, tb_page_addr_t address, uintptr_t pc)
         if (prot & PAGE_EXEC) {
             prot = (prot & ~PAGE_EXEC) | PAGE_READ;
         }
-        mprotect((void *)g2h_untagged(start), len, prot & PAGE_RWX);
+        mprotect((void *)g2h_untagged_vaddr(start), len, prot & PAGE_RWX);
     }
     mmap_unlock();
 
@@ -763,7 +763,7 @@ static int probe_access_internal(CPUArchState *env, vaddr addr,
         g_assert_not_reached();
     }
 
-    if (guest_addr_valid_untagged(addr)) {
+    if (guest_addr_valid_untagged_vaddr(addr)) {
         int page_flags = page_get_flags(addr);
         if (page_flags & acc_flag) {
             if (access_type != MMU_INST_FETCH
@@ -792,7 +792,7 @@ int probe_access_flags(CPUArchState *env, vaddr addr, int size,
 
     g_assert(-(addr | TARGET_PAGE_MASK) >= size);
     flags = probe_access_internal(env, addr, size, access_type, nonfault, ra);
-    *phost = (flags & TLB_INVALID_MASK) ? NULL : g2h(env_cpu(env), addr);
+    *phost = (flags & TLB_INVALID_MASK) ? NULL : g2h_vaddr(env_cpu(env), addr);
     return flags;
 }
 
@@ -805,13 +805,13 @@ void *probe_access(CPUArchState *env, vaddr addr, int size,
     flags = probe_access_internal(env, addr, size, access_type, false, ra);
     g_assert((flags & ~TLB_MMIO) == 0);
 
-    return size ? g2h(env_cpu(env), addr) : NULL;
+    return size ? g2h_vaddr(env_cpu(env), addr) : NULL;
 }
 
 void *tlb_vaddr_to_host(CPUArchState *env, vaddr addr,
                         MMUAccessType access_type, int mmu_idx)
 {
-    return g2h(env_cpu(env), addr);
+    return g2h_vaddr(env_cpu(env), addr);
 }
 
 tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
@@ -822,7 +822,7 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
     flags = probe_access_internal(env, addr, 1, MMU_INST_FETCH, false, 0);
     g_assert(flags == 0);
 
-    *hostp = g2h_untagged(addr);
+    *hostp = g2h_untagged_vaddr(addr);
     return addr;
 }
 
@@ -938,7 +938,7 @@ static void *cpu_mmu_lookup(CPUState *cpu, vaddr addr,
         cpu_loop_exit_sigbus(cpu, addr, type, ra);
     }
 
-    ret = g2h(cpu, addr);
+    ret = g2h_vaddr(cpu, addr);
     set_helper_retaddr(ra);
     return ret;
 }
@@ -968,7 +968,7 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
         }
         if (is_write) {
             if (flags & PAGE_WRITE) {
-                memcpy(g2h(cpu, addr), buf, l);
+                memcpy(g2h_vaddr(cpu, addr), buf, l);
             } else {
                 /* Bypass the host page protection using ptrace. */
                 if (fd == -1) {
@@ -987,13 +987,13 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
                  */
                 tb_invalidate_phys_range(NULL, addr, addr + l - 1);
                 written = pwrite(fd, buf, l,
-                                 (off_t)(uintptr_t)g2h_untagged(addr));
+                                 (off_t)(uintptr_t)g2h_untagged_vaddr(addr));
                 if (written != l) {
                     goto out_close;
                 }
             }
         } else if (flags & PAGE_READ) {
-            memcpy(buf, g2h(cpu, addr), l);
+            memcpy(buf, g2h_vaddr(cpu, addr), l);
         } else {
             /* Bypass the host page protection using ptrace. */
             if (fd == -1) {
@@ -1003,7 +1003,7 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
                 }
             }
             if (pread(fd, buf, l,
-                      (off_t)(uintptr_t)g2h_untagged(addr)) != l) {
+                      (off_t)(uintptr_t)g2h_untagged_vaddr(addr)) != l) {
                 goto out_close;
             }
         }
@@ -1231,7 +1231,7 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
         cpu_loop_exit_atomic(cpu, retaddr);
     }
 
-    ret = g2h(cpu, addr);
+    ret = g2h_vaddr(cpu, addr);
     set_helper_retaddr(retaddr);
     return ret;
 }
diff --git a/include/user/guest-host.h b/include/user/guest-host.h
index 8f7ef75896..ef83ad8a18 100644
--- a/include/user/guest-host.h
+++ b/include/user/guest-host.h
@@ -29,7 +29,12 @@ extern unsigned long reserved_va;
  */
 extern unsigned long guest_addr_max;
 
-static inline vaddr cpu_untagged_addr(CPUState *cs, vaddr x)
+/*
+ * These functions take the guest virtual address as a vaddr,
+ * and are suitable for use from target-independent code.
+ */
+
+static inline vaddr cpu_untagged_addr_vaddr(CPUState *cs, vaddr x)
 {
     const TCGCPUOps *tcg_ops = cs->cc->tcg_ops;
     if (tcg_ops->untagged_addr) {
@@ -39,22 +44,22 @@ static inline vaddr cpu_untagged_addr(CPUState *cs, vaddr x)
 }
 
 /* All direct uses of g2h and h2g need to go away for usermode softmmu.  */
-static inline void *g2h_untagged(vaddr x)
+static inline void *g2h_untagged_vaddr(vaddr x)
 {
     return (void *)((uintptr_t)(x) + guest_base);
 }
 
-static inline void *g2h(CPUState *cs, vaddr x)
+static inline void *g2h_vaddr(CPUState *cs, vaddr x)
 {
-    return g2h_untagged(cpu_untagged_addr(cs, x));
+    return g2h_untagged_vaddr(cpu_untagged_addr_vaddr(cs, x));
 }
 
-static inline bool guest_addr_valid_untagged(vaddr x)
+static inline bool guest_addr_valid_untagged_vaddr(vaddr x)
 {
     return x <= guest_addr_max;
 }
 
-static inline bool guest_range_valid_untagged(vaddr start, vaddr len)
+static inline bool guest_range_valid_untagged_vaddr(vaddr start, vaddr len)
 {
     return len - 1 <= guest_addr_max && start <= guest_addr_max - len + 1;
 }
@@ -73,4 +78,49 @@ static inline bool guest_range_valid_untagged(vaddr start, vaddr len)
     h2g_nocheck(x); \
 })
 
+#ifdef COMPILING_PER_TARGET
+
+/*
+ * These functions take the guest virtual address as an abi_ptr.  This
+ * is an important difference from a vaddr for the common case where
+ * the address is a syscall argument in a variable of type abi_long,
+ * which may be smaller than the vaddr type. If you pass an address in
+ * an abi_long to these functions then the value will be converted to
+ * an unsigned type and then zero extended to give the vaddr. If you
+ * use the g2h_vaddr() and similar functions which take an argument of
+ * type vaddr, then the value will be sign-extended, giving the wrong
+ * answer for addresses above the 2GB mark on 32-bit guests.
+ *
+ * Providing these functions with their traditional QEMU semantics is
+ * less bug-prone than requiring many callsites to remember to cast
+ * their abi_long variable to an abi_ptr before calling.
+ */
+
+static inline void *g2h(CPUState *cs, abi_ptr x)
+{
+    return g2h_vaddr(cs, x);
+}
+
+static inline void *g2h_untagged(abi_ptr x)
+{
+    return g2h_untagged_vaddr(x);
+}
+
+static inline bool guest_addr_valid_untagged(abi_ptr x)
+{
+    return guest_addr_valid_untagged_vaddr(x);
+}
+
+static inline bool guest_range_valid_untagged(abi_ptr start, abi_ptr len)
+{
+    return guest_range_valid_untagged_vaddr(start, len);
+}
+
+static inline abi_ptr cpu_untagged_addr(CPUState *cs, abi_ptr x)
+{
+    return cpu_untagged_addr_vaddr(cs, x);
+}
+
+#endif
+
 #endif
-- 
2.43.0


