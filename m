Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17FB6C5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 09:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwzMc-00037w-6H; Thu, 20 Aug 2026 05:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiangwencheng@lanxincomputing.com>)
 id 1wwzMa-00037a-77
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 05:47:08 -0400
Received: from va-2-43.ptr.blmpb.com ([209.127.231.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xiangwencheng@lanxincomputing.com>)
 id 1wwzMS-0004lY-US
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 05:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1787219204;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=Q9C3XVWRj98ub6Mva6ln4t1B8Wv4S4tKroS2JcWq3JI=;
 b=uKcnLrqX4G2Ary9u9lcfoqKWihh2yL/1A5ohmRQJs+gMRMLWeN+/OfzSRu4J01ylbj3IOa
 eDi6xUGGITLUZjyi6HDkcEu1yU2pG36hASN6W9aJmrso/ClVwum2vn/pVqPalLeQgkHAT9
 /aHuuZNYfGf47ISapN/p0OMWss2N9hBH/Cq3eJ/XpzgxsXbRFCWZ68ynyTZj3CzU7PcUCI
 +gGajhgU2rETA5lqU+lZd+6X1wjJEu/qepHKN78CJMrkqkFJymg1uUZTm/xk1jHMdfAzx5
 EMMX7VJL3M2Fdj+lLVuqyq3Huaxxus5eH4xLOXEyukWH6PFc5z0liFdrT3GrvQ==
From: "BillXiang" <xiangwencheng@lanxincomputing.com>
Message-Id: <20260820094611.1767100-1-xiangwencheng@lanxincomputing.com>
Mime-Version: 1.0
Subject: [PATCH] virtio: Add aligned ld/st accessors for vring
X-Original-From: BillXiang <xiangwencheng@lanxincomputing.com>
Cc: <pbonzini@redhat.com>, <peterx@redhat.com>, <philmd@mailo.com>, 
 <qemu-devel@nongnu.org>, <xiangwencheng@lanxincomputing.com>
Received: from lanxin-ThinkBook-16-G5-IRH ([123.120.5.129]) by smtp.feishu.cn
 with ESMTP; Thu, 20 Aug 2026 17:46:41 +0800
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
To: <mst@redhat.com>
Date: Thu, 20 Aug 2026 17:46:11 +0800
Content-Transfer-Encoding: quoted-printable
X-Lms-Return-Path: <lba+26a86cd02+f39ed0+nongnu.org+xiangwencheng@lanxincomputing.com>
Received-SPF: pass client-ip=209.127.231.43;
 envelope-from=xiangwencheng@lanxincomputing.com; helo=va-2-43.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001, SPF_HELO_NONE=0.001,
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

The generic ld/st*_p() pointer helpers lower to __builtin_memcpy,
which on RISC-V will be expanded to multiple byte-access instructions
rather than a single aligned access by the compiler because it
cannot prove alignment at the call site.

Each cached 16-bit access of a vring field therefore performs several
distinct byte ld/st, which is a memory-tearing hazard for fields that
the guest may access concurrently =E2=80=94 most notably avail->idx, where =
we
find the guest can write a new value between the individual byte loads
and produce a torn read that never existed in memory, as seen in logs
like:
  "Guest moved used index from 49417 to 49919"
Here, 49919 (binary 1100 0010-1111 1111) is incorrectly assembled from
the lower byte of 49663 (1100 0001-1111 1111) and the upper byte of
49664 (1100 0010-0000 0000).

Add a parallel set of _aligned cached accessors so the fast (RAM) path
emits a single aligned load instruction, eliminating the tearing window.

Callers MUST ensure @addr is naturally aligned to the access size before
invoking the _aligned helpers; the virtio vring layout guarantees this
for avail->idx and other naturally-aligned fields.

This patch fixes the memory-tearing hazard while also improves performance.

Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
---
 hw/virtio/virtio.c                            |  8 +-
 include/qemu/bswap.h                          | 41 ++++++++++
 include/system/memory_cached.h                | 16 ++++
 .../system/memory_ldst_cached_aligned.h.inc   | 76 +++++++++++++++++++
 4 files changed, 137 insertions(+), 4 deletions(-)
 create mode 100644 include/system/memory_ldst_cached_aligned.h.inc

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index daa5607..f796bdd 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -223,9 +223,9 @@ static inline uint16_t virtio_lduw_phys_cached(VirtIODe=
vice *vdev,
                                                hwaddr pa)
 {
     if (virtio_vdev_is_big_endian(vdev)) {
-        return lduw_be_phys_cached(cache, pa);
+        return lduw_be_phys_cached_aligned(cache, pa);
     }
-    return lduw_le_phys_cached(cache, pa);
+    return lduw_le_phys_cached_aligned(cache, pa);
 }
=20
 static inline void virtio_stw_phys_cached(VirtIODevice *vdev,
@@ -233,9 +233,9 @@ static inline void virtio_stw_phys_cached(VirtIODevice =
*vdev,
                                           hwaddr pa, uint16_t value)
 {
     if (virtio_vdev_is_big_endian(vdev)) {
-        stw_be_phys_cached(cache, pa, value);
+        stw_be_phys_cached_aligned(cache, pa, value);
     } else {
-        stw_le_phys_cached(cache, pa, value);
+        stw_le_phys_cached_aligned(cache, pa, value);
     }
 }
=20
diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 387d65c..c23f5a2 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -255,6 +255,20 @@ static inline int lduw_he_p(const void *ptr)
     return r;
 }
=20
+static inline int lduw_he_p_aligned(const void *ptr)
+{
+    uint16_t r;
+    __builtin_memcpy(&r, __builtin_assume_aligned(ptr, sizeof(r)), sizeof(=
r));
+    return r;
+}
+
 static inline int ldsw_he_p(const void *ptr)
 {
     int16_t r;
@@ -267,6 +281,11 @@ static inline void stw_he_p(void *ptr, uint16_t v)
     __builtin_memcpy(ptr, &v, sizeof(v));
 }
=20
+static inline void stw_he_p_aligned(void *ptr, uint16_t v)
+{
+    __builtin_memcpy(__builtin_assume_aligned(ptr, sizeof(v)), &v, sizeof(=
v));
+}
+
 static inline void st24_he_p(void *ptr, uint32_t v)
 {
     __builtin_memcpy(ptr, &v, 3);
@@ -301,6 +320,12 @@ static inline int lduw_le_p(const void *ptr)
     return (uint16_t)le_bswap(lduw_he_p(ptr), 16);
 }
=20
+static inline int lduw_le_p_aligned(const void *ptr)
+{
+    return (uint16_t)le_bswap(lduw_he_p_aligned(ptr), 16);
+}
+
 static inline int ldsw_le_p(const void *ptr)
 {
     return (int16_t)le_bswap(lduw_he_p(ptr), 16);
@@ -321,6 +346,11 @@ static inline void stw_le_p(void *ptr, uint16_t v)
     stw_he_p(ptr, le_bswap(v, 16));
 }
=20
+static inline void stw_le_p_aligned(void *ptr, uint16_t v)
+{
+    stw_he_p_aligned(ptr, le_bswap(v, 16));
+}
+
 static inline void st24_le_p(void *ptr, uint32_t v)
 {
     st24_he_p(ptr, le_bswap24(v));
@@ -341,6 +371,12 @@ static inline int lduw_be_p(const void *ptr)
     return (uint16_t)be_bswap(lduw_he_p(ptr), 16);
 }
=20
+static inline int lduw_be_p_aligned(const void *ptr)
+{
+    return (uint16_t)be_bswap(lduw_he_p_aligned(ptr), 16);
+}
+
 static inline int ldsw_be_p(const void *ptr)
 {
     return (int16_t)be_bswap(lduw_he_p(ptr), 16);
@@ -361,6 +397,11 @@ static inline void stw_be_p(void *ptr, uint16_t v)
     stw_he_p(ptr, be_bswap(v, 16));
 }
=20
+static inline void stw_be_p_aligned(void *ptr, uint16_t v)
+{
+    stw_he_p_aligned(ptr, be_bswap(v, 16));
+}
+
 static inline void st24_be_p(void *ptr, uint32_t v)
 {
     st24_he_p(ptr, be_bswap24(v));
diff --git a/include/system/memory_cached.h b/include/system/memory_cached.=
h
index 09d4682..cfa7a26 100644
--- a/include/system/memory_cached.h
+++ b/include/system/memory_cached.h
@@ -96,6 +96,22 @@ void address_space_stb_cached(const MemoryRegionCache *c=
ache,
 #define ARG1_DECL    const MemoryRegionCache *cache
 #include "system/memory_ldst_phys.h.inc"
=20
+/*
+ * Aligned counterparts of the cached load accessors.
+ *
+ * The fast path (direct RAM access) uses the ld*_p_aligned() pointer help=
ers,
+ * which assume the host pointer is naturally aligned to the access size a=
nd
+ * therefore let the compiler emit an aligned load instruction.
+ *
+ * Callers MUST ensure @addr is aligned to the access size before invoking
+ * these helpers; otherwise the behavior is undefined.
+ */
+#define ENDIANNESS   _le
+#include "system/memory_ldst_cached_aligned.h.inc"
+
+#define ENDIANNESS   _be
+#include "system/memory_ldst_cached_aligned.h.inc"
+
 /**
  * address_space_cache_init: prepare for repeated access to a physical
  *                           memory region
diff --git a/include/system/memory_ldst_cached_aligned.h.inc b/include/syst=
em/memory_ldst_cached_aligned.h.inc
new file mode 100644
index 0000000..c21c135
--- /dev/null
+++ b/include/system/memory_ldst_cached_aligned.h.inc
@@ -0,0 +1,76 @@
+/*
+ *  Aligned Memory access templates for MemoryRegionCache
+ *
+ *  Callers MUST ensure @addr is aligned to the access size before invokin=
g
+ *  these helpers; otherwise the behavior is undefined.
+ *
+ *  Copyright (c) 2018 Red Hat, Inc.
+ *  Copyright (c) 2018 LanxinComputing, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define ADDRESS_SPACE_LD_CACHED_ALIGNED(size) \
+    glue(glue(address_space_ld, size), glue(ENDIANNESS, _cached_aligned))
+#define ADDRESS_SPACE_LD_CACHED_SLOW(size) \
+    glue(glue(address_space_ld, size), glue(ENDIANNESS, _cached_slow))
+#define LD_P_ALIGNED(size) \
+    glue(glue(ld, size), glue(ENDIANNESS, _p_aligned))
+#define LD_PHYS_CACHED_ALIGNED(size) \
+    glue(glue(ld, size), glue(ENDIANNESS, glue(_phys, _cached_aligned)))
+
+static inline uint16_t ADDRESS_SPACE_LD_CACHED_ALIGNED(uw)(MemoryRegionCac=
he *cache,
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
+{
+    assert(addr < cache->len && 2 <=3D cache->len - addr);
+    fuzz_dma_read_cb(cache->xlat + addr, 2, cache->mrs.mr);
+    if (likely(cache->ptr)) {
+        return LD_P_ALIGNED(uw)(cache->ptr + addr);
+    } else {
+        return ADDRESS_SPACE_LD_CACHED_SLOW(uw)(cache, addr, attrs, result=
);
+    }
+}
+
+static inline uint16_t LD_PHYS_CACHED_ALIGNED(uw)(MemoryRegionCache *cache=
,
+                                                  hwaddr addr)
+{
+    return ADDRESS_SPACE_LD_CACHED_ALIGNED(uw)(cache, addr,
+                                              MEMTXATTRS_UNSPECIFIED, NULL=
);
+}
+
+#undef ADDRESS_SPACE_LD_CACHED_ALIGNED
+#undef ADDRESS_SPACE_LD_CACHED_SLOW
+#undef LD_P_ALIGNED
+#undef LD_PHYS_CACHED_ALIGNED
+
+#define ADDRESS_SPACE_ST_CACHED_ALIGNED(size) \
+    glue(glue(address_space_st, size), glue(ENDIANNESS, _cached_aligned))
+#define ADDRESS_SPACE_ST_CACHED_SLOW(size) \
+    glue(glue(address_space_st, size), glue(ENDIANNESS, _cached_slow))
+#define ST_P_ALIGNED(size) \
+    glue(glue(st, size), glue(ENDIANNESS, _p_aligned))
+#define ST_PHYS_CACHED_ALIGNED(size) \
+    glue(glue(st, size), glue(ENDIANNESS, glue(_phys, _cached_aligned)))
+
+static inline void ADDRESS_SPACE_ST_CACHED_ALIGNED(w)(const MemoryRegionCa=
che *cache,
+    hwaddr addr, uint16_t val, MemTxAttrs attrs, MemTxResult *result)
+{
+    assert(addr < cache->len && 2 <=3D cache->len - addr);
+    if (likely(cache->ptr)) {
+        ST_P_ALIGNED(w)(cache->ptr + addr, val);
+    } else {
+        ADDRESS_SPACE_ST_CACHED_SLOW(w)(cache, addr, val, attrs, result);
+    }
+}
+
+static inline void ST_PHYS_CACHED_ALIGNED(w)(MemoryRegionCache *cache,
+    hwaddr addr, uint16_t val)
+{
+    ADDRESS_SPACE_ST_CACHED_ALIGNED(w)(cache, addr, val, MEMTXATTRS_UNSPEC=
IFIED, NULL);
+}
+
+#undef ADDRESS_SPACE_ST_CACHED_ALIGNED
+#undef ADDRESS_SPACE_ST_CACHED_SLOW
+#undef ST_P_ALIGNED
+#undef ST_PHYS_CACHED_ALIGNED
+
+#undef ENDIANNESS
--=20
2.53.0

