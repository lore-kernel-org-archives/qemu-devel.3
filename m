Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D90CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up5JE-0000zY-CE; Thu, 21 Aug 2025 09:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d.zhebryakov@yandex.ru>)
 id 1up3YW-00075b-66; Thu, 21 Aug 2025 07:34:08 -0400
Received: from forward100d.mail.yandex.net ([2a02:6b8:c41:1300:1:45:d181:d100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d.zhebryakov@yandex.ru>)
 id 1up3YO-0008Kc-W5; Thu, 21 Aug 2025 07:34:06 -0400
Received: from mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:ba25:0:640:6c71:0])
 by forward100d.mail.yandex.net (Yandex) with ESMTPS id 960DEC0087;
 Thu, 21 Aug 2025 14:33:51 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id mXRF5KIMdSw0-LgyCQBHa; 
 Thu, 21 Aug 2025 14:33:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1755776031; bh=iPwvSTCU2o8PPIdy3UyxyvI1GnJplS9Cch9VJRDYH4E=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=WMYlrcPBnHBhGGDQFv5pviTGmb1FMJBT4vr/HsoHwfnpeBWMikImFDEI64Ge3iWFM
 XdWdt4R/LGJE2FRb+A+Z7vKhZQjHmgUGN2c3qz4S0toz8pWMSNX+F5UhJhg8KEE8C+
 C5KAZ9y410nMMaWjQa/VYjTQ1IhAvUMkmG2L1eoQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Danila Zhebryakov <d.zhebryakov@yandex.ru>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Riku Voipio <riku.voipio@iki.fi>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Danila Zhebryakov <d.zhebryakov@yandex.ru>
Subject: [PATCH 1/3] accel/tcg: Unify big- and little- endian atomic ops
Date: Thu, 21 Aug 2025 14:33:45 +0300
Message-ID: <20250821113348.91339-2-d.zhebryakov@yandex.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250821113348.91339-1-d.zhebryakov@yandex.ru>
References: <20250821113348.91339-1-d.zhebryakov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:d100;
 envelope-from=d.zhebryakov@yandex.ru; helo=forward100d.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 21 Aug 2025 09:26:25 -0400
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

Remove dedicated LE and BE atomic helpers. Use MO_BSWAP flag of the memop instead.
Adjust atomic_mmu_lookup to respect the TLB_BSWAP flag

Signed-off-by: Danila Zhebryakov <d.zhebryakov@yandex.ru>
---
 accel/tcg/atomic_common.c.inc       |  27 +--
 accel/tcg/atomic_template.h         | 246 +++++++++-------------------
 accel/tcg/cputlb.c                  |  10 +-
 accel/tcg/tcg-runtime.h             |  36 +---
 accel/tcg/user-exec.c               |   2 +-
 include/accel/tcg/cpu-ldst-common.h |  39 ++---
 target/m68k/op_helper.c             |   4 +-
 target/s390x/tcg/mem_helper.c       |   6 +-
 tcg/tcg-op-ldst.c                   |  31 ++--
 9 files changed, 131 insertions(+), 270 deletions(-)

diff --git a/accel/tcg/atomic_common.c.inc b/accel/tcg/atomic_common.c.inc
index 6056598c23..4ce3bc3da1 100644
--- a/accel/tcg/atomic_common.c.inc
+++ b/accel/tcg/atomic_common.c.inc
@@ -42,19 +42,15 @@ static void atomic_trace_rmw_post(CPUArchState *env, uint64_t addr,
     { return cpu_atomic_##OP##_mmu(env, addr, oldv, newv, oi, GETPC()); }
 
 CMPXCHG_HELPER(cmpxchgb, uint32_t)
-CMPXCHG_HELPER(cmpxchgw_be, uint32_t)
-CMPXCHG_HELPER(cmpxchgw_le, uint32_t)
-CMPXCHG_HELPER(cmpxchgl_be, uint32_t)
-CMPXCHG_HELPER(cmpxchgl_le, uint32_t)
+CMPXCHG_HELPER(cmpxchgw, uint32_t)
+CMPXCHG_HELPER(cmpxchgl, uint32_t)
 
 #ifdef CONFIG_ATOMIC64
-CMPXCHG_HELPER(cmpxchgq_be, uint64_t)
-CMPXCHG_HELPER(cmpxchgq_le, uint64_t)
+CMPXCHG_HELPER(cmpxchgq, uint64_t)
 #endif
 
 #if HAVE_CMPXCHG128
-CMPXCHG_HELPER(cmpxchgo_be, Int128)
-CMPXCHG_HELPER(cmpxchgo_le, Int128)
+CMPXCHG_HELPER(cmpxchgo, Int128)
 #endif
 
 #undef CMPXCHG_HELPER
@@ -87,19 +83,14 @@ Int128 HELPER(nonatomic_cmpxchgo)(CPUArchState *env, uint64_t addr,
 #ifdef CONFIG_ATOMIC64
 #define GEN_ATOMIC_HELPERS(OP)              \
     ATOMIC_HELPER(glue(OP,b), uint32_t)     \
-    ATOMIC_HELPER(glue(OP,w_be), uint32_t)  \
-    ATOMIC_HELPER(glue(OP,w_le), uint32_t)  \
-    ATOMIC_HELPER(glue(OP,l_be), uint32_t)  \
-    ATOMIC_HELPER(glue(OP,l_le), uint32_t)  \
-    ATOMIC_HELPER(glue(OP,q_be), uint64_t)  \
-    ATOMIC_HELPER(glue(OP,q_le), uint64_t)
+    ATOMIC_HELPER(glue(OP,w), uint32_t)     \
+    ATOMIC_HELPER(glue(OP,l), uint32_t)     \
+    ATOMIC_HELPER(glue(OP,q), uint64_t)
 #else
 #define GEN_ATOMIC_HELPERS(OP)              \
     ATOMIC_HELPER(glue(OP,b), uint32_t)     \
-    ATOMIC_HELPER(glue(OP,w_be), uint32_t)  \
-    ATOMIC_HELPER(glue(OP,w_le), uint32_t)  \
-    ATOMIC_HELPER(glue(OP,l_be), uint32_t)  \
-    ATOMIC_HELPER(glue(OP,l_le), uint32_t)
+    ATOMIC_HELPER(glue(OP,w), uint32_t)     \
+    ATOMIC_HELPER(glue(OP,l), uint32_t)
 #endif
 
 GEN_ATOMIC_HELPERS(fetch_add)
diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index 08a475c10c..e51207c498 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -69,63 +69,84 @@
 
 /* Define host-endian atomic operations.  Note that END is used within
    the ATOMIC_NAME macro, and redefined below.  */
-#if DATA_SIZE == 1
 # define END
-#elif HOST_BIG_ENDIAN
-# define END  _be
-#else
-# define END  _le
-#endif
 
 ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, vaddr addr,
                               ABI_TYPE cmpv, ABI_TYPE newv,
                               MemOpIdx oi, uintptr_t retaddr)
 {
+    bool need_bswap = get_memop(oi) & MO_BSWAP;
     DATA_TYPE *haddr = atomic_mmu_lookup(env_cpu(env), addr, oi,
-                                         DATA_SIZE, retaddr);
-    DATA_TYPE ret;
-
+                                         DATA_SIZE, retaddr, &need_bswap);
+    DATA_TYPE ret, ret_e;
+    if (need_bswap) {
+#if DATA_SIZE == 16
+        ret = atomic16_cmpxchg(haddr, BSWAP(cmpv), BSWAP(newv));
+#else
+        ret = qatomic_cmpxchg__nocheck(haddr, BSWAP(cmpv), BSWAP(newv));
+#endif
+        ret_e = BSWAP(ret);
+    } else {
 #if DATA_SIZE == 16
-    ret = atomic16_cmpxchg(haddr, cmpv, newv);
+        ret = atomic16_cmpxchg(haddr, cmpv, newv);
 #else
-    ret = qatomic_cmpxchg__nocheck(haddr, cmpv, newv);
+        ret = qatomic_cmpxchg__nocheck(haddr, cmpv, newv);
 #endif
+        ret_e = ret;
+    }
     ATOMIC_MMU_CLEANUP;
     atomic_trace_rmw_post(env, addr,
-                          VALUE_LOW(ret),
-                          VALUE_HIGH(ret),
-                          VALUE_LOW(newv),
-                          VALUE_HIGH(newv),
-                          oi);
-    return ret;
+                        VALUE_LOW(ret),
+                        VALUE_HIGH(ret),
+                        VALUE_LOW(newv),
+                        VALUE_HIGH(newv),
+                        oi);
+    return ret_e;
 }
 
 #if DATA_SIZE < 16
 ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, vaddr addr, ABI_TYPE val,
                            MemOpIdx oi, uintptr_t retaddr)
 {
-    DATA_TYPE *haddr = atomic_mmu_lookup(env_cpu(env), addr, oi,
-                                         DATA_SIZE, retaddr);
-    DATA_TYPE ret;
+    bool need_bswap = get_memop(oi) & MO_BSWAP;
 
-    ret = qatomic_xchg__nocheck(haddr, val);
+    DATA_TYPE *haddr = atomic_mmu_lookup(env_cpu(env), addr, oi,
+                                         DATA_SIZE, retaddr, &need_bswap);
+    DATA_TYPE ret, ret_e;
+
+    if (need_bswap) {
+        ret = qatomic_xchg__nocheck(haddr, BSWAP(val));
+        ret_e = BSWAP(ret);
+    } else {
+        ret = qatomic_xchg__nocheck(haddr, val);
+        ret_e = ret;
+    }
     ATOMIC_MMU_CLEANUP;
     atomic_trace_rmw_post(env, addr,
-                          VALUE_LOW(ret),
-                          VALUE_HIGH(ret),
-                          VALUE_LOW(val),
-                          VALUE_HIGH(val),
-                          oi);
-    return ret;
+                        VALUE_LOW(ret),
+                        VALUE_HIGH(ret),
+                        VALUE_LOW(val),
+                        VALUE_HIGH(val),
+                        oi);
+    return ret_e;
 }
 
 #define GEN_ATOMIC_HELPER(X)                                        \
 ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, vaddr addr,              \
                         ABI_TYPE val, MemOpIdx oi, uintptr_t retaddr) \
 {                                                                   \
-    DATA_TYPE *haddr, ret;                                          \
-    haddr = atomic_mmu_lookup(env_cpu(env), addr, oi, DATA_SIZE, retaddr);   \
-    ret = qatomic_##X(haddr, val);                                  \
+    DATA_TYPE *haddr, ret, ret_e;                                   \
+    bool need_bswap = get_memop(oi) & MO_BSWAP;                     \
+    haddr = atomic_mmu_lookup(env_cpu(env), addr, oi, DATA_SIZE,    \
+                                             retaddr, &need_bswap); \
+    if (need_bswap) {                                               \
+        ret = qatomic_##X(haddr, BSWAP(val));                       \
+        ret_e = BSWAP(ret);                                         \
+    }                                                               \
+    else {                                                          \
+        ret = qatomic_##X(haddr, val);                              \
+        ret_e = ret;                                                \
+    }                                                               \
     ATOMIC_MMU_CLEANUP;                                             \
     atomic_trace_rmw_post(env, addr,                                \
                           VALUE_LOW(ret),                           \
@@ -133,7 +154,7 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, vaddr addr,              \
                           VALUE_LOW(val),                           \
                           VALUE_HIGH(val),                          \
                           oi);                                      \
-    return ret;                                                     \
+    return ret_e;                                                   \
 }
 
 GEN_ATOMIC_HELPER(fetch_add)
@@ -155,147 +176,38 @@ GEN_ATOMIC_HELPER(xor_fetch)
  * Trace this load + RMW loop as a single RMW op. This way, regardless
  * of CF_PARALLEL's value, we'll trace just a read and a write.
  */
-#define GEN_ATOMIC_HELPER_FN(X, FN, XDATA_TYPE, RET)                \
-ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, vaddr addr,              \
-                        ABI_TYPE xval, MemOpIdx oi, uintptr_t retaddr) \
-{                                                                   \
-    XDATA_TYPE *haddr, cmp, old, new, val = xval;                   \
-    haddr = atomic_mmu_lookup(env_cpu(env), addr, oi, DATA_SIZE, retaddr);   \
-    smp_mb();                                                       \
-    cmp = qatomic_read__nocheck(haddr);                             \
-    do {                                                            \
-        old = cmp; new = FN(old, val);                              \
-        cmp = qatomic_cmpxchg__nocheck(haddr, old, new);            \
-    } while (cmp != old);                                           \
-    ATOMIC_MMU_CLEANUP;                                             \
-    atomic_trace_rmw_post(env, addr,                                \
-                          VALUE_LOW(old),                           \
-                          VALUE_HIGH(old),                          \
-                          VALUE_LOW(xval),                          \
-                          VALUE_HIGH(xval),                         \
-                          oi);                                      \
-    return RET;                                                     \
-}
-
-GEN_ATOMIC_HELPER_FN(fetch_smin, MIN, SDATA_TYPE, old)
-GEN_ATOMIC_HELPER_FN(fetch_umin, MIN,  DATA_TYPE, old)
-GEN_ATOMIC_HELPER_FN(fetch_smax, MAX, SDATA_TYPE, old)
-GEN_ATOMIC_HELPER_FN(fetch_umax, MAX,  DATA_TYPE, old)
 
-GEN_ATOMIC_HELPER_FN(smin_fetch, MIN, SDATA_TYPE, new)
-GEN_ATOMIC_HELPER_FN(umin_fetch, MIN,  DATA_TYPE, new)
-GEN_ATOMIC_HELPER_FN(smax_fetch, MAX, SDATA_TYPE, new)
-GEN_ATOMIC_HELPER_FN(umax_fetch, MAX,  DATA_TYPE, new)
-
-#undef GEN_ATOMIC_HELPER_FN
-#endif /* DATA SIZE < 16 */
-
-#undef END
-
-#if DATA_SIZE > 1
-
-/* Define reverse-host-endian atomic operations.  Note that END is used
-   within the ATOMIC_NAME macro.  */
-#if HOST_BIG_ENDIAN
-# define END  _le
-#else
-# define END  _be
-#endif
-
-ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, vaddr addr,
-                              ABI_TYPE cmpv, ABI_TYPE newv,
-                              MemOpIdx oi, uintptr_t retaddr)
-{
-    DATA_TYPE *haddr = atomic_mmu_lookup(env_cpu(env), addr, oi,
-                                         DATA_SIZE, retaddr);
-    DATA_TYPE ret;
-
-#if DATA_SIZE == 16
-    ret = atomic16_cmpxchg(haddr, BSWAP(cmpv), BSWAP(newv));
-#else
-    ret = qatomic_cmpxchg__nocheck(haddr, BSWAP(cmpv), BSWAP(newv));
-#endif
-    ATOMIC_MMU_CLEANUP;
-    atomic_trace_rmw_post(env, addr,
-                          VALUE_LOW(ret),
-                          VALUE_HIGH(ret),
-                          VALUE_LOW(newv),
-                          VALUE_HIGH(newv),
-                          oi);
-    return BSWAP(ret);
-}
-
-#if DATA_SIZE < 16
-ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, vaddr addr, ABI_TYPE val,
-                           MemOpIdx oi, uintptr_t retaddr)
-{
-    DATA_TYPE *haddr = atomic_mmu_lookup(env_cpu(env), addr, oi,
-                                         DATA_SIZE, retaddr);
-    ABI_TYPE ret;
-
-    ret = qatomic_xchg__nocheck(haddr, BSWAP(val));
-    ATOMIC_MMU_CLEANUP;
-    atomic_trace_rmw_post(env, addr,
-                          VALUE_LOW(ret),
-                          VALUE_HIGH(ret),
-                          VALUE_LOW(val),
-                          VALUE_HIGH(val),
-                          oi);
-    return BSWAP(ret);
-}
-
-#define GEN_ATOMIC_HELPER(X)                                        \
-ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, vaddr addr,              \
-                        ABI_TYPE val, MemOpIdx oi, uintptr_t retaddr) \
-{                                                                   \
-    DATA_TYPE *haddr, ret;                                          \
-    haddr = atomic_mmu_lookup(env_cpu(env), addr, oi, DATA_SIZE, retaddr);   \
-    ret = qatomic_##X(haddr, BSWAP(val));                           \
-    ATOMIC_MMU_CLEANUP;                                             \
-    atomic_trace_rmw_post(env, addr,                                \
-                          VALUE_LOW(ret),                           \
-                          VALUE_HIGH(ret),                          \
-                          VALUE_LOW(val),                           \
-                          VALUE_HIGH(val),                          \
-                          oi);                                      \
-    return BSWAP(ret);                                              \
-}
-
-GEN_ATOMIC_HELPER(fetch_and)
-GEN_ATOMIC_HELPER(fetch_or)
-GEN_ATOMIC_HELPER(fetch_xor)
-GEN_ATOMIC_HELPER(and_fetch)
-GEN_ATOMIC_HELPER(or_fetch)
-GEN_ATOMIC_HELPER(xor_fetch)
-
-#undef GEN_ATOMIC_HELPER
-
-/* These helpers are, as a whole, full barriers.  Within the helper,
- * the leading barrier is explicit and the trailing barrier is within
- * cmpxchg primitive.
- *
- * Trace this load + RMW loop as a single RMW op. This way, regardless
- * of CF_PARALLEL's value, we'll trace just a read and a write.
- */
 #define GEN_ATOMIC_HELPER_FN(X, FN, XDATA_TYPE, RET)                \
 ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, vaddr addr,              \
                         ABI_TYPE xval, MemOpIdx oi, uintptr_t retaddr) \
 {                                                                   \
     XDATA_TYPE *haddr, ldo, ldn, old, new, val = xval;              \
-    haddr = atomic_mmu_lookup(env_cpu(env), addr, oi, DATA_SIZE, retaddr);   \
+    bool need_bswap = get_memop(oi) & MO_BSWAP;                     \
+    haddr = atomic_mmu_lookup(env_cpu(env), addr, oi, DATA_SIZE,    \
+                              retaddr, &need_bswap);                \
     smp_mb();                                                       \
     ldn = qatomic_read__nocheck(haddr);                             \
-    do {                                                            \
-        ldo = ldn; old = BSWAP(ldo); new = FN(old, val);            \
-        ldn = qatomic_cmpxchg__nocheck(haddr, ldo, BSWAP(new));     \
-    } while (ldo != ldn);                                           \
+    if (need_bswap) {                                               \
+        do {                                                        \
+            ldo = ldn; old = BSWAP(ldo);                            \
+            new = FN(old, val);                                     \
+            ldn = qatomic_cmpxchg__nocheck(haddr, ldo, BSWAP(new)); \
+        } while (ldo != ldn);                                       \
+    }                                                               \
+    else{                                                           \
+        do {                                                        \
+            ldo = ldn; old = ldo;                                   \
+            new = FN(old, val);                                     \
+            ldn = qatomic_cmpxchg__nocheck(haddr, ldo, new);        \
+        } while (ldo != ldn);                                       \
+    }                                                               \
     ATOMIC_MMU_CLEANUP;                                             \
     atomic_trace_rmw_post(env, addr,                                \
-                          VALUE_LOW(old),                           \
-                          VALUE_HIGH(old),                          \
-                          VALUE_LOW(xval),                          \
-                          VALUE_HIGH(xval),                         \
-                          oi);                                      \
+                        VALUE_LOW(old),                             \
+                        VALUE_HIGH(old),                            \
+                        VALUE_LOW(xval),                            \
+                        VALUE_HIGH(xval),                           \
+                        oi);                                        \
     return RET;                                                     \
 }
 
@@ -309,18 +221,10 @@ GEN_ATOMIC_HELPER_FN(umin_fetch, MIN,  DATA_TYPE, new)
 GEN_ATOMIC_HELPER_FN(smax_fetch, MAX, SDATA_TYPE, new)
 GEN_ATOMIC_HELPER_FN(umax_fetch, MAX,  DATA_TYPE, new)
 
-/* Note that for addition, we need to use a separate cmpxchg loop instead
-   of bswaps for the reverse-host-endian helpers.  */
-#define ADD(X, Y)   (X + Y)
-GEN_ATOMIC_HELPER_FN(fetch_add, ADD, DATA_TYPE, old)
-GEN_ATOMIC_HELPER_FN(add_fetch, ADD, DATA_TYPE, new)
-#undef ADD
-
 #undef GEN_ATOMIC_HELPER_FN
-#endif /* DATA_SIZE < 16 */
+#endif /* DATA SIZE < 16 */
 
 #undef END
-#endif /* DATA_SIZE > 1 */
 
 #undef BSWAP
 #undef ABI_TYPE
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 87e14bde4f..841b54e41d 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1808,7 +1808,7 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
  * or io operations to proceed.  Return the host address.
  */
 static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
-                               int size, uintptr_t retaddr)
+                               int size, uintptr_t retaddr, bool *need_bswap)
 {
     uintptr_t mmu_idx = get_mmuidx(oi);
     MemOp mop = get_memop(oi);
@@ -1894,6 +1894,14 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
         notdirty_write(cpu, addr, size, full, retaddr);
     }
 
+    if (unlikely(tlb_addr & TLB_BSWAP)) {
+        assert(!( (  full->slow_flags[MMU_DATA_STORE]
+            ^ full->slow_flags[MMU_DATA_LOAD ])
+            & TLB_BSWAP));
+
+        *need_bswap = !need_bswap;
+    }
+
     if (unlikely(tlb_addr & TLB_WATCHPOINT)) {
         int wp_flags = 0;
 
diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index c23b5e66c4..02679b1fdb 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -44,24 +44,16 @@ DEF_HELPER_FLAGS_4(st_i128, TCG_CALL_NO_WG, void, env, i64, i128, i32)
 
 DEF_HELPER_FLAGS_5(atomic_cmpxchgb, TCG_CALL_NO_WG,
                    i32, env, i64, i32, i32, i32)
-DEF_HELPER_FLAGS_5(atomic_cmpxchgw_be, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_5(atomic_cmpxchgw, TCG_CALL_NO_WG,
                    i32, env, i64, i32, i32, i32)
-DEF_HELPER_FLAGS_5(atomic_cmpxchgw_le, TCG_CALL_NO_WG,
-                   i32, env, i64, i32, i32, i32)
-DEF_HELPER_FLAGS_5(atomic_cmpxchgl_be, TCG_CALL_NO_WG,
-                   i32, env, i64, i32, i32, i32)
-DEF_HELPER_FLAGS_5(atomic_cmpxchgl_le, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_5(atomic_cmpxchgl, TCG_CALL_NO_WG,
                    i32, env, i64, i32, i32, i32)
 #ifdef CONFIG_ATOMIC64
-DEF_HELPER_FLAGS_5(atomic_cmpxchgq_be, TCG_CALL_NO_WG,
-                   i64, env, i64, i64, i64, i32)
-DEF_HELPER_FLAGS_5(atomic_cmpxchgq_le, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_5(atomic_cmpxchgq, TCG_CALL_NO_WG,
                    i64, env, i64, i64, i64, i32)
 #endif
 #if HAVE_CMPXCHG128
-DEF_HELPER_FLAGS_5(atomic_cmpxchgo_be, TCG_CALL_NO_WG,
-                   i128, env, i64, i128, i128, i32)
-DEF_HELPER_FLAGS_5(atomic_cmpxchgo_le, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_5(atomic_cmpxchgo, TCG_CALL_NO_WG,
                    i128, env, i64, i128, i128, i32)
 #endif
 
@@ -72,29 +64,19 @@ DEF_HELPER_FLAGS_5(nonatomic_cmpxchgo, TCG_CALL_NO_WG,
 #define GEN_ATOMIC_HELPERS(NAME)                                  \
     DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), b),              \
                        TCG_CALL_NO_WG, i32, env, i64, i32, i32)   \
-    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), w_le),           \
+    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), w),              \
                        TCG_CALL_NO_WG, i32, env, i64, i32, i32)   \
-    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), w_be),           \
+    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), l),              \
                        TCG_CALL_NO_WG, i32, env, i64, i32, i32)   \
-    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), l_le),           \
-                       TCG_CALL_NO_WG, i32, env, i64, i32, i32)   \
-    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), l_be),           \
-                       TCG_CALL_NO_WG, i32, env, i64, i32, i32)   \
-    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), q_le),           \
-                       TCG_CALL_NO_WG, i64, env, i64, i64, i32)   \
-    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), q_be),           \
+    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), q),              \
                        TCG_CALL_NO_WG, i64, env, i64, i64, i32)
 #else
 #define GEN_ATOMIC_HELPERS(NAME)                                  \
     DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), b),              \
                        TCG_CALL_NO_WG, i32, env, i64, i32, i32)   \
-    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), w_le),           \
-                       TCG_CALL_NO_WG, i32, env, i64, i32, i32)   \
-    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), w_be),           \
-                       TCG_CALL_NO_WG, i32, env, i64, i32, i32)   \
-    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), l_le),           \
+    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), w),              \
                        TCG_CALL_NO_WG, i32, env, i64, i32, i32)   \
-    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), l_be),           \
+    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), l),              \
                        TCG_CALL_NO_WG, i32, env, i64, i32, i32)
 #endif /* CONFIG_ATOMIC64 */
 
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index f25d80e2dc..0c7443a16e 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -1268,7 +1268,7 @@ uint64_t cpu_ldq_code_mmu(CPUArchState *env, vaddr addr,
  * Do not allow unaligned operations to proceed.  Return the host address.
  */
 static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
-                               int size, uintptr_t retaddr)
+                               int size, uintptr_t retaddr, bool *need_bswap)
 {
     MemOp mop = get_memop(oi);
     int a_bits = memop_alignment_bits(mop);
diff --git a/include/accel/tcg/cpu-ldst-common.h b/include/accel/tcg/cpu-ldst-common.h
index 8bf17c2fab..b07f1827ce 100644
--- a/include/accel/tcg/cpu-ldst-common.h
+++ b/include/accel/tcg/cpu-ldst-common.h
@@ -36,22 +36,13 @@ void cpu_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
 uint32_t cpu_atomic_cmpxchgb_mmu(CPUArchState *env, vaddr addr,
                                  uint32_t cmpv, uint32_t newv,
                                  MemOpIdx oi, uintptr_t retaddr);
-uint32_t cpu_atomic_cmpxchgw_le_mmu(CPUArchState *env, vaddr addr,
+uint32_t cpu_atomic_cmpxchgw_mmu(CPUArchState *env, vaddr addr,
                                     uint32_t cmpv, uint32_t newv,
                                     MemOpIdx oi, uintptr_t retaddr);
-uint32_t cpu_atomic_cmpxchgl_le_mmu(CPUArchState *env, vaddr addr,
+uint32_t cpu_atomic_cmpxchgl_mmu(CPUArchState *env, vaddr addr,
                                     uint32_t cmpv, uint32_t newv,
                                     MemOpIdx oi, uintptr_t retaddr);
-uint64_t cpu_atomic_cmpxchgq_le_mmu(CPUArchState *env, vaddr addr,
-                                    uint64_t cmpv, uint64_t newv,
-                                    MemOpIdx oi, uintptr_t retaddr);
-uint32_t cpu_atomic_cmpxchgw_be_mmu(CPUArchState *env, vaddr addr,
-                                    uint32_t cmpv, uint32_t newv,
-                                    MemOpIdx oi, uintptr_t retaddr);
-uint32_t cpu_atomic_cmpxchgl_be_mmu(CPUArchState *env, vaddr addr,
-                                    uint32_t cmpv, uint32_t newv,
-                                    MemOpIdx oi, uintptr_t retaddr);
-uint64_t cpu_atomic_cmpxchgq_be_mmu(CPUArchState *env, vaddr addr,
+uint64_t cpu_atomic_cmpxchgq_mmu(CPUArchState *env, vaddr addr,
                                     uint64_t cmpv, uint64_t newv,
                                     MemOpIdx oi, uintptr_t retaddr);
 
@@ -63,19 +54,14 @@ TYPE cpu_atomic_ ## NAME ## SUFFIX ## _mmu      \
 #ifdef CONFIG_ATOMIC64
 #define GEN_ATOMIC_HELPER_ALL(NAME)          \
     GEN_ATOMIC_HELPER(NAME, uint32_t, b)     \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, w_le)  \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, w_be)  \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, l_le)  \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, l_be)  \
-    GEN_ATOMIC_HELPER(NAME, uint64_t, q_le)  \
-    GEN_ATOMIC_HELPER(NAME, uint64_t, q_be)
+    GEN_ATOMIC_HELPER(NAME, uint32_t, w)     \
+    GEN_ATOMIC_HELPER(NAME, uint32_t, l)     \
+    GEN_ATOMIC_HELPER(NAME, uint64_t, q)
 #else
 #define GEN_ATOMIC_HELPER_ALL(NAME)          \
     GEN_ATOMIC_HELPER(NAME, uint32_t, b)     \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, w_le)  \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, w_be)  \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, l_le)  \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, l_be)
+    GEN_ATOMIC_HELPER(NAME, uint32_t, w)     \
+    GEN_ATOMIC_HELPER(NAME, uint32_t, l)
 #endif
 
 GEN_ATOMIC_HELPER_ALL(fetch_add)
@@ -103,12 +89,9 @@ GEN_ATOMIC_HELPER_ALL(xchg)
 #undef GEN_ATOMIC_HELPER_ALL
 #undef GEN_ATOMIC_HELPER
 
-Int128 cpu_atomic_cmpxchgo_le_mmu(CPUArchState *env, vaddr addr,
-                                  Int128 cmpv, Int128 newv,
-                                  MemOpIdx oi, uintptr_t retaddr);
-Int128 cpu_atomic_cmpxchgo_be_mmu(CPUArchState *env, vaddr addr,
-                                  Int128 cmpv, Int128 newv,
-                                  MemOpIdx oi, uintptr_t retaddr);
+Int128 cpu_atomic_cmpxchgo_mmu(CPUArchState *env, vaddr addr,
+                               Int128 cmpv, Int128 newv,
+                               MemOpIdx oi, uintptr_t retaddr);
 
 uint8_t cpu_ldb_code_mmu(CPUArchState *env, vaddr addr,
                          MemOpIdx oi, uintptr_t ra);
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index f29ae12af8..d138bb6742 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -806,13 +806,13 @@ static void do_cas2l(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2,
         if ((a1 & 7) == 0 && a2 == a1 + 4) {
             c = deposit64(c2, 32, 32, c1);
             u = deposit64(u2, 32, 32, u1);
-            l = cpu_atomic_cmpxchgq_be_mmu(env, a1, c, u, oi, ra);
+            l = cpu_atomic_cmpxchgq_mmu(env, a1, c, u, oi, ra);
             l1 = l >> 32;
             l2 = l;
         } else if ((a2 & 7) == 0 && a1 == a2 + 4) {
             c = deposit64(c1, 32, 32, c2);
             u = deposit64(u1, 32, 32, u2);
-            l = cpu_atomic_cmpxchgq_be_mmu(env, a2, c, u, oi, ra);
+            l = cpu_atomic_cmpxchgq_mmu(env, a2, c, u, oi, ra);
             l2 = l >> 32;
             l1 = l;
         } else
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index f1acb1618f..996e10ece3 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -1838,7 +1838,7 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
             uint32_t ov;
 
             if (parallel) {
-                ov = cpu_atomic_cmpxchgl_be_mmu(env, a1, cv, nv, oi4, ra);
+                ov = cpu_atomic_cmpxchgl_mmu(env, a1, cv, nv, oi4, ra);
             } else {
                 ov = cpu_ldl_mmu(env, a1, oi4, ra);
                 cpu_stl_mmu(env, a1, (ov == cv ? nv : ov), oi4, ra);
@@ -1856,7 +1856,7 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
 
             if (parallel) {
 #ifdef CONFIG_ATOMIC64
-                ov = cpu_atomic_cmpxchgq_be_mmu(env, a1, cv, nv, oi8, ra);
+                ov = cpu_atomic_cmpxchgq_mmu(env, a1, cv, nv, oi8, ra);
 #else
                 /* Note that we asserted !parallel above.  */
                 g_assert_not_reached();
@@ -1884,7 +1884,7 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
                 }
                 cpu_st16_mmu(env, a1, nv, oi16, ra);
             } else if (HAVE_CMPXCHG128) {
-                ov = cpu_atomic_cmpxchgo_be_mmu(env, a1, cv, nv, oi16, ra);
+                ov = cpu_atomic_cmpxchgo_mmu(env, a1, cv, nv, oi16, ra);
                 cc = !int128_eq(ov, cv);
             } else {
                 /* Note that we asserted !parallel above.  */
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 548496002d..8db45d8f0c 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -813,16 +813,12 @@ typedef void (*gen_atomic_op_i64)(TCGv_i64, TCGv_env, TCGv_i64,
 # define WITH_ATOMIC128(X)
 #endif
 
-static void * const table_cmpxchg[(MO_SIZE | MO_BSWAP) + 1] = {
+static void * const table_cmpxchg[MO_SIZE + 1] = {
     [MO_8] = gen_helper_atomic_cmpxchgb,
-    [MO_16 | MO_LE] = gen_helper_atomic_cmpxchgw_le,
-    [MO_16 | MO_BE] = gen_helper_atomic_cmpxchgw_be,
-    [MO_32 | MO_LE] = gen_helper_atomic_cmpxchgl_le,
-    [MO_32 | MO_BE] = gen_helper_atomic_cmpxchgl_be,
-    WITH_ATOMIC64([MO_64 | MO_LE] = gen_helper_atomic_cmpxchgq_le)
-    WITH_ATOMIC64([MO_64 | MO_BE] = gen_helper_atomic_cmpxchgq_be)
-    WITH_ATOMIC128([MO_128 | MO_LE] = gen_helper_atomic_cmpxchgo_le)
-    WITH_ATOMIC128([MO_128 | MO_BE] = gen_helper_atomic_cmpxchgo_be)
+    [MO_16] = gen_helper_atomic_cmpxchgw,
+    [MO_32] = gen_helper_atomic_cmpxchgl,
+    WITH_ATOMIC64([MO_64] = gen_helper_atomic_cmpxchgq)
+    WITH_ATOMIC128([MO_128] = gen_helper_atomic_cmpxchgo)
 };
 
 static void tcg_gen_nonatomic_cmpxchg_i32_int(TCGv_i32 retv, TCGTemp *addr,
@@ -871,7 +867,7 @@ static void tcg_gen_atomic_cmpxchg_i32_int(TCGv_i32 retv, TCGTemp *addr,
     }
 
     memop = tcg_canonicalize_memop(memop, 0, 0);
-    gen = table_cmpxchg[memop & (MO_SIZE | MO_BSWAP)];
+    gen = table_cmpxchg[memop & MO_SIZE];
     tcg_debug_assert(gen != NULL);
 
     oi = make_memop_idx(memop & ~MO_SIGN, idx);
@@ -952,7 +948,7 @@ static void tcg_gen_atomic_cmpxchg_i64_int(TCGv_i64 retv, TCGTemp *addr,
         gen_atomic_cx_i64 gen;
 
         memop = tcg_canonicalize_memop(memop, 1, 0);
-        gen = table_cmpxchg[memop & (MO_SIZE | MO_BSWAP)];
+        gen = table_cmpxchg[memop & MO_SIZE];
         if (gen) {
             MemOpIdx oi = make_memop_idx(memop, idx);
             TCGv_i64 a64 = maybe_extend_addr64(addr);
@@ -1074,7 +1070,7 @@ static void tcg_gen_atomic_cmpxchg_i128_int(TCGv_i128 retv, TCGTemp *addr,
         return;
     }
 
-    gen = table_cmpxchg[memop & (MO_SIZE | MO_BSWAP)];
+    gen = table_cmpxchg[memop & MO_SIZE];
     if (gen) {
         MemOpIdx oi = make_memop_idx(memop, idx);
         TCGv_i64 a64 = maybe_extend_addr64(addr);
@@ -1202,14 +1198,11 @@ static void do_atomic_op_i64(TCGv_i64 ret, TCGTemp *addr, TCGv_i64 val,
 }
 
 #define GEN_ATOMIC_HELPER(NAME, OP, NEW)                                \
-static void * const table_##NAME[(MO_SIZE | MO_BSWAP) + 1] = {          \
+static void * const table_##NAME[MO_SIZE + 1] = {                       \
     [MO_8] = gen_helper_atomic_##NAME##b,                               \
-    [MO_16 | MO_LE] = gen_helper_atomic_##NAME##w_le,                   \
-    [MO_16 | MO_BE] = gen_helper_atomic_##NAME##w_be,                   \
-    [MO_32 | MO_LE] = gen_helper_atomic_##NAME##l_le,                   \
-    [MO_32 | MO_BE] = gen_helper_atomic_##NAME##l_be,                   \
-    WITH_ATOMIC64([MO_64 | MO_LE] = gen_helper_atomic_##NAME##q_le)     \
-    WITH_ATOMIC64([MO_64 | MO_BE] = gen_helper_atomic_##NAME##q_be)     \
+    [MO_16] = gen_helper_atomic_##NAME##w,                              \
+    [MO_32] = gen_helper_atomic_##NAME##l,                              \
+    WITH_ATOMIC64([MO_64] = gen_helper_atomic_##NAME##q)                \
 };                                                                      \
 void tcg_gen_atomic_##NAME##_i32_chk(TCGv_i32 ret, TCGTemp *addr,       \
                                      TCGv_i32 val, TCGArg idx,          \
-- 
2.47.2


