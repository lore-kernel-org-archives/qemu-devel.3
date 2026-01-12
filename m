Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE2CCF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQjR-0001bK-TR; Mon, 12 Jan 2026 17:49:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQjP-0001Gq-S4
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:49:51 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQjN-0002Yf-3p
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:49:51 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa9so3190793f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258187; x=1768862987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EFcy3YB0W8aqP0hlfO8tI15urK4elPTzR+0h1Nbgg7U=;
 b=IsYsQkKsus7FnT9+HrzuYkLBE0Rs49+H01+NSA0tb+5vAKCPXZIguwbv0Cv53JOCIf
 Ho7xtcD2i0Hr9T+BUGU4Ga87f3glaBbVBGTRASMay3OWBdzCpoA+CtOjL7OCvTW7tk0j
 mpakE6YWutCIUZZNCSgsMUT8luESLTlYx1WwtJPaiXP2z0hR8KG2v/FjnX41YbcXeP7M
 ftxMgQMHuL89+NzQ3ELuh+oIThSV/OGw06KKRFCVpQ0qrl1ot8SuslbNtMfLX2gcOzBo
 8bxUuZQadVTCf6jkE91XeRcdsbu0iynZATpTXX/3x0TRLdpQSerRWTl6rpUH4Lp1WA9l
 ScsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258187; x=1768862987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EFcy3YB0W8aqP0hlfO8tI15urK4elPTzR+0h1Nbgg7U=;
 b=juTFcLT1ESi9lf867LsX16cyHtQNBnez01uGsoH6j+7K10G/tnAbfZG4MCHenQSUyq
 dfvHXzgiQ/WYV5IkQtCGDfG1ZMhOqGBXirKIaeDQHogvsopdxkMgv4w1ab3+Z92q+2cI
 TSXNRCLgPdhsr22SckgsVJqE4Agj4YJzs/b/zlBQuWFoy737GXHEACxPdT5W2OPd3zkv
 uhJkuXc8LotB6m+u2f1nG83z9fqH7qHlYXSnv+94Cl5M+GamN0SCRHdGCgQHzHcUK8m5
 BdqYgBJISpiV2CVpiqMdTUOzgiaT/xAnGFbJRNnNA78orjyWyyCOzsRP+AkOCAx9iYUm
 TITw==
X-Gm-Message-State: AOJu0YydBJ7o+sz17hRI+10XVMJePsnLRVL8iqZwjeSzBzsx6UnseZhd
 R1IcxFnbY14s+ukeoUQroxglBaTsHe/4TQlN62YYI4f0aVBaxHc62WbVTHnaGQjXzepHH8T7Vjj
 vEN/rAlc=
X-Gm-Gg: AY/fxX6zEpaCx9YNdDmc8YV90aVPELw0eKupN7jrVmk+eeEnc93gJtQCSvH3LfHf0Ys
 O2lpxLyJgJrK9kMb25eTs6IcKfYldxd3b6+werY2yRJaZuODqXmyixAW1uwRWRb4/bXYZ3U/UN2
 4USNpkqDJMBptU1uezgp93WGLsRynJy3Rq53sNgtqXrtg90pwFVHiksd1DtdkbaV9oIMtw4K9O4
 yAU59ulpTZ4+Ki0rzjrYQV45hX5WcL/Hj4Lram4KkpEl4N53xBxxsRJAzP5Z0Qr9nTX01tw7nt+
 u6qrBC/g0a6l/FkmmAAPz03/MWt4nCUendWR7yzgBYKj2WbVt4UeuI+uUGTQjpRUUIursCEXgVi
 EbY9bs3upy50t/z6cy4EGNSqHYWcThYovsXAvpT+Xepd5tjxcN0iXyIh2Quj0YuacaUjXT1to05
 5Fnm8eRGbeMutEvRV0uBD4oE/zfnWlNf33Ly3PpEoFuvnUCkZ3XXxhEI7tIQCs
X-Google-Smtp-Source: AGHT+IENjXZV638E6Tyd9U+qlNdVZWZKq1pcJ+sICocfht5qlltRp2QvYbV6sprSCGiNzGSGLqjsEQ==
X-Received: by 2002:a05:6000:24c8:b0:432:84f9:8bed with SMTP id
 ffacd0b85a97d-432c364380cmr23872670f8f.28.1768258187023; 
 Mon, 12 Jan 2026 14:49:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e199bsm40381679f8f.16.2026.01.12.14.49.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:49:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/61] system/memory: Split MemoryRegionCache API to
 'memory_cached.h'
Date: Mon, 12 Jan 2026 23:48:02 +0100
Message-ID: <20260112224857.42068-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

We have 115 direct inclusions of "system/memory.h", and 91 headers
in include/ use it: hundreds of files have to process it.
However only one single header really uses the MemoryRegionCache
API: "hw/virtio/virtio-access.h". Split it out to a new header,
avoiding processing unused inlined functions hundreds of times.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260109165058.59144-6-philmd@linaro.org>
---
 MAINTAINERS                       |   1 +
 include/hw/virtio/virtio-access.h |   1 +
 include/system/memory.h           | 185 --------------------------
 include/system/memory_cached.h    | 210 ++++++++++++++++++++++++++++++
 system/physmem.c                  |   1 +
 5 files changed, 213 insertions(+), 185 deletions(-)
 create mode 100644 include/system/memory_cached.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 88deca06cd6..62050d7dec3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3285,6 +3285,7 @@ F: include/system/ioport.h
 F: include/exec/memop.h
 F: include/system/ram_addr.h
 F: include/system/memory.h
+F: include/system/memory_cached.h
 F: include/system/memory_ldst*
 F: include/system/physmem.h
 F: include/system/ramblock.h
diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index 5b5fff5295e..cd17d0c87eb 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -17,6 +17,7 @@
 #define QEMU_VIRTIO_ACCESS_H
 
 #include "exec/hwaddr.h"
+#include "system/memory_cached.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
 
diff --git a/include/system/memory.h b/include/system/memory.h
index 0e8de527d36..92028dc7a4e 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2862,140 +2862,6 @@ MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
 #include "system/memory_ldst_phys.h.inc"
 #endif
 
-struct MemoryRegionCache {
-    uint8_t *ptr;
-    hwaddr xlat;
-    hwaddr len;
-    FlatView *fv;
-    MemoryRegionSection mrs;
-    bool is_write;
-};
-
-/* address_space_ld*_cached: load from a cached #MemoryRegion
- * address_space_st*_cached: store into a cached #MemoryRegion
- *
- * These functions perform a load or store of the byte, word,
- * longword or quad to the specified address.  The address is
- * a physical address in the AddressSpace, but it must lie within
- * a #MemoryRegion that was mapped with address_space_cache_init.
- *
- * The _le suffixed functions treat the data as little endian;
- * _be indicates big endian; no suffix indicates "same endianness
- * as guest CPU".
- *
- * The "guest CPU endianness" accessors are deprecated for use outside
- * target-* code; devices should be CPU-agnostic and use either the LE
- * or the BE accessors.
- *
- * @cache: previously initialized #MemoryRegionCache to be accessed
- * @addr: address within the address space
- * @val: data value, for stores
- * @attrs: memory transaction attributes
- * @result: location to write the success/failure of the transaction;
- *   if NULL, this information is discarded
- */
-
-#define SUFFIX       _cached_slow
-#define ARG1         cache
-#define ARG1_DECL    MemoryRegionCache *cache
-#include "system/memory_ldst.h.inc"
-
-/* Inline fast path for direct RAM access.  */
-static inline uint8_t address_space_ldub_cached(MemoryRegionCache *cache,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
-{
-    assert(addr < cache->len);
-    if (likely(cache->ptr)) {
-        return ldub_p(cache->ptr + addr);
-    } else {
-        return address_space_ldub_cached_slow(cache, addr, attrs, result);
-    }
-}
-
-static inline void address_space_stb_cached(MemoryRegionCache *cache,
-    hwaddr addr, uint8_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    assert(addr < cache->len);
-    if (likely(cache->ptr)) {
-        stb_p(cache->ptr + addr, val);
-    } else {
-        address_space_stb_cached_slow(cache, addr, val, attrs, result);
-    }
-}
-
-#define ENDIANNESS
-#include "system/memory_ldst_cached.h.inc"
-
-#define ENDIANNESS   _le
-#include "system/memory_ldst_cached.h.inc"
-
-#define ENDIANNESS   _be
-#include "system/memory_ldst_cached.h.inc"
-
-#define SUFFIX       _cached
-#define ARG1         cache
-#define ARG1_DECL    MemoryRegionCache *cache
-#include "system/memory_ldst_phys.h.inc"
-
-/* address_space_cache_init: prepare for repeated access to a physical
- * memory region
- *
- * @cache: #MemoryRegionCache to be filled
- * @as: #AddressSpace to be accessed
- * @addr: address within that address space
- * @len: length of buffer
- * @is_write: indicates the transfer direction
- *
- * Will only work with RAM, and may map a subset of the requested range by
- * returning a value that is less than @len.  On failure, return a negative
- * errno value.
- *
- * Because it only works with RAM, this function can be used for
- * read-modify-write operations.  In this case, is_write should be %true.
- *
- * Note that addresses passed to the address_space_*_cached functions
- * are relative to @addr.
- */
-int64_t address_space_cache_init(MemoryRegionCache *cache,
-                                 AddressSpace *as,
-                                 hwaddr addr,
-                                 hwaddr len,
-                                 bool is_write);
-
-/**
- * address_space_cache_init_empty: Initialize empty #MemoryRegionCache
- *
- * @cache: The #MemoryRegionCache to operate on.
- *
- * Initializes #MemoryRegionCache structure without memory region attached.
- * Cache initialized this way can only be safely destroyed, but not used.
- */
-static inline void address_space_cache_init_empty(MemoryRegionCache *cache)
-{
-    cache->mrs.mr = NULL;
-    /* There is no real need to initialize fv, but it makes Coverity happy. */
-    cache->fv = NULL;
-}
-
-/**
- * address_space_cache_invalidate: complete a write to a #MemoryRegionCache
- *
- * @cache: The #MemoryRegionCache to operate on.
- * @addr: The first physical address that was written, relative to the
- * address that was passed to @address_space_cache_init.
- * @access_len: The number of bytes that were written starting at @addr.
- */
-void address_space_cache_invalidate(MemoryRegionCache *cache,
-                                    hwaddr addr,
-                                    hwaddr access_len);
-
-/**
- * address_space_cache_destroy: free a #MemoryRegionCache
- *
- * @cache: The #MemoryRegionCache whose memory should be released.
- */
-void address_space_cache_destroy(MemoryRegionCache *cache);
-
 void address_space_flush_icache_range(AddressSpace *as, hwaddr addr, hwaddr len);
 
 /* address_space_get_iotlb_entry: translate an address into an IOTLB
@@ -3123,14 +2989,6 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
                                    MemoryRegion *mr);
 void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr);
 
-/* Internal functions, part of the implementation of address_space_read_cached
- * and address_space_write_cached.  */
-MemTxResult address_space_read_cached_slow(MemoryRegionCache *cache,
-                                           hwaddr addr, void *buf, hwaddr len);
-MemTxResult address_space_write_cached_slow(MemoryRegionCache *cache,
-                                            hwaddr addr, const void *buf,
-                                            hwaddr len);
-
 int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr);
 bool prepare_mmio_access(MemoryRegion *mr);
 
@@ -3208,49 +3066,6 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
     return result;
 }
 
-/**
- * address_space_read_cached: read from a cached RAM region
- *
- * @cache: Cached region to be addressed
- * @addr: address relative to the base of the RAM region
- * @buf: buffer with the data transferred
- * @len: length of the data transferred
- */
-static inline MemTxResult
-address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
-                          void *buf, hwaddr len)
-{
-    assert(addr < cache->len && len <= cache->len - addr);
-    fuzz_dma_read_cb(cache->xlat + addr, len, cache->mrs.mr);
-    if (likely(cache->ptr)) {
-        memcpy(buf, cache->ptr + addr, len);
-        return MEMTX_OK;
-    } else {
-        return address_space_read_cached_slow(cache, addr, buf, len);
-    }
-}
-
-/**
- * address_space_write_cached: write to a cached RAM region
- *
- * @cache: Cached region to be addressed
- * @addr: address relative to the base of the RAM region
- * @buf: buffer with the data transferred
- * @len: length of the data transferred
- */
-static inline MemTxResult
-address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
-                           const void *buf, hwaddr len)
-{
-    assert(addr < cache->len && len <= cache->len - addr);
-    if (likely(cache->ptr)) {
-        memcpy(cache->ptr + addr, buf, len);
-        return MEMTX_OK;
-    } else {
-        return address_space_write_cached_slow(cache, addr, buf, len);
-    }
-}
-
 /**
  * address_space_set: Fill address space with a constant byte.
  *
diff --git a/include/system/memory_cached.h b/include/system/memory_cached.h
new file mode 100644
index 00000000000..e0ed54bd1eb
--- /dev/null
+++ b/include/system/memory_cached.h
@@ -0,0 +1,210 @@
+/*
+ * Physical memory management API
+ *
+ * Copyright 2011 Red Hat, Inc. and/or its affiliates
+ *
+ * Authors:
+ *  Avi Kivity <avi@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef SYSTEM_MEMORY_CACHED_H
+#define SYSTEM_MEMORY_CACHED_H
+
+#include "exec/hwaddr.h"
+#include "system/memory.h"
+
+struct MemoryRegionCache {
+    uint8_t *ptr;
+    hwaddr xlat;
+    hwaddr len;
+    FlatView *fv;
+    MemoryRegionSection mrs;
+    bool is_write;
+};
+
+/**
+ * address_space_ld*_cached: load from a cached #MemoryRegion
+ * address_space_st*_cached: store into a cached #MemoryRegion
+ *
+ * These functions perform a load or store of the byte, word,
+ * longword or quad to the specified address.  The address is
+ * a physical address in the AddressSpace, but it must lie within
+ * a #MemoryRegion that was mapped with address_space_cache_init.
+ *
+ * The _le suffixed functions treat the data as little endian;
+ * _be indicates big endian; no suffix indicates "same endianness
+ * as guest CPU".
+ *
+ * The "guest CPU endianness" accessors are deprecated for use outside
+ * target-* code; devices should be CPU-agnostic and use either the LE
+ * or the BE accessors.
+ *
+ * @cache: previously initialized #MemoryRegionCache to be accessed
+ * @addr: address within the address space
+ * @val: data value, for stores
+ * @attrs: memory transaction attributes
+ * @result: location to write the success/failure of the transaction;
+ *          if NULL, this information is discarded
+ */
+
+#define SUFFIX       _cached_slow
+#define ARG1         cache
+#define ARG1_DECL    MemoryRegionCache *cache
+#include "system/memory_ldst.h.inc"
+
+/* Inline fast path for direct RAM access.  */
+static inline
+uint8_t address_space_ldub_cached(MemoryRegionCache *cache, hwaddr addr,
+                                  MemTxAttrs attrs, MemTxResult *result)
+{
+    assert(addr < cache->len);
+    if (likely(cache->ptr)) {
+        return ldub_p(cache->ptr + addr);
+    } else {
+        return address_space_ldub_cached_slow(cache, addr, attrs, result);
+    }
+}
+
+static inline
+void address_space_stb_cached(MemoryRegionCache *cache,
+                              hwaddr addr, uint8_t val,
+                              MemTxAttrs attrs, MemTxResult *result)
+{
+    assert(addr < cache->len);
+    if (likely(cache->ptr)) {
+        stb_p(cache->ptr + addr, val);
+    } else {
+        address_space_stb_cached_slow(cache, addr, val, attrs, result);
+    }
+}
+
+#define ENDIANNESS
+#include "system/memory_ldst_cached.h.inc"
+
+#define ENDIANNESS   _le
+#include "system/memory_ldst_cached.h.inc"
+
+#define ENDIANNESS   _be
+#include "system/memory_ldst_cached.h.inc"
+
+#define SUFFIX       _cached
+#define ARG1         cache
+#define ARG1_DECL    MemoryRegionCache *cache
+#include "system/memory_ldst_phys.h.inc"
+
+/**
+ * address_space_cache_init: prepare for repeated access to a physical
+ *                           memory region
+ *
+ * @cache: #MemoryRegionCache to be filled
+ * @as: #AddressSpace to be accessed
+ * @addr: address within that address space
+ * @len: length of buffer
+ * @is_write: indicates the transfer direction
+ *
+ * Will only work with RAM, and may map a subset of the requested range by
+ * returning a value that is less than @len.  On failure, return a negative
+ * errno value.
+ *
+ * Because it only works with RAM, this function can be used for
+ * read-modify-write operations.  In this case, is_write should be %true.
+ *
+ * Note that addresses passed to the address_space_*_cached functions
+ * are relative to @addr.
+ */
+int64_t address_space_cache_init(MemoryRegionCache *cache,
+                                 AddressSpace *as,
+                                 hwaddr addr,
+                                 hwaddr len,
+                                 bool is_write);
+
+/**
+ * address_space_cache_init_empty: Initialize empty #MemoryRegionCache
+ *
+ * @cache: The #MemoryRegionCache to operate on.
+ *
+ * Initializes #MemoryRegionCache structure without memory region attached.
+ * Cache initialized this way can only be safely destroyed, but not used.
+ */
+static inline void address_space_cache_init_empty(MemoryRegionCache *cache)
+{
+    cache->mrs.mr = NULL;
+    /* There is no real need to initialize fv, but it makes Coverity happy. */
+    cache->fv = NULL;
+}
+
+/**
+ * address_space_cache_invalidate: complete a write to a #MemoryRegionCache
+ *
+ * @cache: The #MemoryRegionCache to operate on.
+ * @addr: The first physical address that was written, relative to the
+ * address that was passed to @address_space_cache_init.
+ * @access_len: The number of bytes that were written starting at @addr.
+ */
+void address_space_cache_invalidate(MemoryRegionCache *cache,
+                                    hwaddr addr,
+                                    hwaddr access_len);
+
+/**
+ * address_space_cache_destroy: free a #MemoryRegionCache
+ *
+ * @cache: The #MemoryRegionCache whose memory should be released.
+ */
+void address_space_cache_destroy(MemoryRegionCache *cache);
+
+/*
+ * Internal functions, part of the implementation of address_space_read_cached
+ * and address_space_write_cached.
+ */
+MemTxResult address_space_read_cached_slow(MemoryRegionCache *cache,
+                                           hwaddr addr, void *buf, hwaddr len);
+MemTxResult address_space_write_cached_slow(MemoryRegionCache *cache,
+                                            hwaddr addr, const void *buf,
+                                            hwaddr len);
+
+/**
+ * address_space_read_cached: read from a cached RAM region
+ *
+ * @cache: Cached region to be addressed
+ * @addr: address relative to the base of the RAM region
+ * @buf: buffer with the data transferred
+ * @len: length of the data transferred
+ */
+static inline MemTxResult
+address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
+                          void *buf, hwaddr len)
+{
+    assert(addr < cache->len && len <= cache->len - addr);
+    fuzz_dma_read_cb(cache->xlat + addr, len, cache->mrs.mr);
+    if (likely(cache->ptr)) {
+        memcpy(buf, cache->ptr + addr, len);
+        return MEMTX_OK;
+    } else {
+        return address_space_read_cached_slow(cache, addr, buf, len);
+    }
+}
+
+/**
+ * address_space_write_cached: write to a cached RAM region
+ *
+ * @cache: Cached region to be addressed
+ * @addr: address relative to the base of the RAM region
+ * @buf: buffer with the data transferred
+ * @len: length of the data transferred
+ */
+static inline MemTxResult
+address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
+                           const void *buf, hwaddr len)
+{
+    assert(addr < cache->len && len <= cache->len - addr);
+    if (likely(cache->ptr)) {
+        memcpy(cache->ptr + addr, buf, len);
+        return MEMTX_OK;
+    } else {
+        return address_space_write_cached_slow(cache, addr, buf, len);
+    }
+}
+
+#endif
diff --git a/system/physmem.c b/system/physmem.c
index 9981539543f..9a7aba9521d 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -53,6 +53,7 @@
 #include "qemu/memalign.h"
 #include "qemu/memfd.h"
 #include "system/memory.h"
+#include "system/memory_cached.h"
 #include "system/ioport.h"
 #include "system/dma.h"
 #include "system/hostmem.h"
-- 
2.52.0


