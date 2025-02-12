Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E99C021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 17:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiGh7-0003BI-AW; Wed, 12 Feb 2025 12:38:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiGh1-0003A2-FI
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:38:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiGgy-0005VF-PP
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:38:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739381911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wvUNFBZgwhyUDMusFAfIqvOJ+fJC8BZVqXIzzj42zLU=;
 b=NGcvjF/fl5NN2nZ2jQY+lStpyJAbNIUupOjWMD9c7TblvSinXsM0MamOetdI0cXf8ySYt2
 BxxaMAWxKUZsVG2K4qusnncmK5g+srcgSblKp7t6FXH50aBWK8OeB3oTsMOhw0SQZU9Bzy
 d7hx6INnhOp6XsD+ls1ERSkFLZZExmk=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-wZcy4K-lNz2Uz9u1r_nedw-1; Wed, 12 Feb 2025 12:38:30 -0500
X-MC-Unique: wZcy4K-lNz2Uz9u1r_nedw-1
X-Mimecast-MFC-AGG-ID: wZcy4K-lNz2Uz9u1r_nedw
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7231e621dccso871408a34.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 09:38:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739381909; x=1739986709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wvUNFBZgwhyUDMusFAfIqvOJ+fJC8BZVqXIzzj42zLU=;
 b=goVZDa+ydoR15DCiSE5OOodrmQQhJpR79lMYkltbiFlqljjy6bdy3GRlgoJLUIb4ea
 IkUuorzr6pZ+Qe+nirzylUZs1Zsk13RR45U6yIc9gU4dHArZA+2U6wGj9NIz4pPoH9Xm
 0PvgxdpVq6yrXf3m5Ujaw0+1EeBjwBZn9chvKBYrkC7K4JqluRBaB5R0cIZrTjX9OojU
 tYI27dNQbWYXJxXu1kOCSP5LCY09e7w/x37UQx67iYdwWdtAx9a/AQE61kwGMQnQ18EM
 ITZVQmBehMCCtpRsdEdcD0M5oUIvWS8H+9pRnHvXsSKuefvF2HBiaXa6IvKCiXmR9DbI
 +XOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDGafKBoYOv3nVGGg++/uqxMa/MAlbQ3plUYo7C3u+DhfPJUs5Knk2U5qVtAT9cUWpem+DLZT4TTLr@nongnu.org
X-Gm-Message-State: AOJu0Yzae19HzULA9i1JViYHDuz0o1k91g30aztjQ4teyvJzEdfJqNN9
 c5Iw3vn3iowMusqY9HTS8yOC2PAMe+DMp0re6mFm9O0RJjmb8pHxfQx7Tt9rb1XLkRjEO2INQLM
 57G/0DnpUXFRzAIKiCPXG5AFFVi/3F4f46ejbTQtwzPKCS/LGLsPYuADdEXXD
X-Gm-Gg: ASbGncvCY/a7p+J9DRoQiHKzd1QEK7RxlblqM2vva79Qx0c/sDuxkN0xAHwzV/qq8i5
 pFH63RJ0KdnX5EtRbgcViSU9xcfeX4VNi4M+laN/QemFIg32wXYq2u5BrnmTlMaR6RqYaAf3vNG
 7AU0vxZiH8rJTWgRtmonCL/U/dNAWvx7IBUduEy4rbkud+lMdxNRmlYt6S8nXgkImcLXDQWvoLB
 eIznxlGLlPYvzsbwXInQargRP/+15xu/4o5/kg7XV14IxvhY3OH5xSL
X-Received: by 2002:a05:6830:3749:b0:71d:ffb8:18a6 with SMTP id
 46e09a7af769-726fe7bbf80mr155175a34.9.1739381909122; 
 Wed, 12 Feb 2025 09:38:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLzVenN4UwrP/jvaBETQiheyazY1IdXTsq2FV8Kvs48aiVbdRPUvSu+ctUoqAHG8NOryoasA==
X-Received: by 2002:a05:6830:3749:b0:71d:ffb8:18a6 with SMTP id
 46e09a7af769-726fe7bbf80mr155148a34.9.1739381908686; 
 Wed, 12 Feb 2025 09:38:28 -0800 (PST)
Received: from x1.com ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc544b08d4sm4457194eaf.2.2025.02.12.09.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 09:38:28 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL v2 06/14] memory: pass MemTxAttrs to memory_access_is_direct()
Date: Wed, 12 Feb 2025 12:38:22 -0500
Message-ID: <20250212173823.214429-2-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250212173823.214429-1-peterx@redhat.com>
References: <20250212173823.214429-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: David Hildenbrand <david@redhat.com>

We want to pass another flag that will be stored in MemTxAttrs. So pass
MemTxAttrs directly.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20250210084648.33798-6-david@redhat.com
[peterx: Fix MacOS builds]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/exec/memory.h     |  5 +++--
 hw/core/loader.c          |  2 +-
 hw/remote/vfio-user-obj.c |  2 +-
 system/physmem.c          | 12 ++++++------
 system/memory_ldst.c.inc  | 18 +++++++++---------
 hw/display/apple-gfx.m    |  3 ++-
 6 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 4e2cf95ab6..b18ecf933e 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -3012,7 +3012,8 @@ static inline bool memory_region_supports_direct_access(MemoryRegion *mr)
     return !memory_region_is_ram_device(mr);
 }
 
-static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
+static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write,
+                                           MemTxAttrs attrs)
 {
     if (!memory_region_supports_direct_access(mr)) {
         return false;
@@ -3053,7 +3054,7 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
             fv = address_space_to_flatview(as);
             l = len;
             mr = flatview_translate(fv, addr, &addr1, &l, false, attrs);
-            if (len == l && memory_access_is_direct(mr, false)) {
+            if (len == l && memory_access_is_direct(mr, false, attrs)) {
                 ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
                 memcpy(buf, ptr, len);
             } else {
diff --git a/hw/core/loader.c b/hw/core/loader.c
index fd25c5e01b..332b879a0b 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -144,7 +144,7 @@ ssize_t load_image_mr(const char *filename, MemoryRegion *mr)
 {
     ssize_t size;
 
-    if (!memory_access_is_direct(mr, false)) {
+    if (!memory_access_is_direct(mr, false, MEMTXATTRS_UNSPECIFIED)) {
         /* Can only load an image into RAM or ROM */
         return -1;
     }
diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index 9e5ff6d87a..6e51a92856 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -358,7 +358,7 @@ static int vfu_object_mr_rw(MemoryRegion *mr, uint8_t *buf, hwaddr offset,
     int access_size;
     uint64_t val;
 
-    if (memory_access_is_direct(mr, is_write)) {
+    if (memory_access_is_direct(mr, is_write, MEMTXATTRS_UNSPECIFIED)) {
         /**
          * Some devices expose a PCI expansion ROM, which could be buffer
          * based as compared to other regions which are primarily based on
diff --git a/system/physmem.c b/system/physmem.c
index cff15ca1df..8745c10c9d 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -573,7 +573,7 @@ MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr *xlat,
                                     is_write, true, &as, attrs);
     mr = section.mr;
 
-    if (xen_enabled() && memory_access_is_direct(mr, is_write)) {
+    if (xen_enabled() && memory_access_is_direct(mr, is_write, attrs)) {
         hwaddr page = ((addr & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE) - addr;
         *plen = MIN(page, *plen);
     }
@@ -2869,7 +2869,7 @@ static MemTxResult flatview_write_continue_step(MemTxAttrs attrs,
         return MEMTX_ACCESS_ERROR;
     }
 
-    if (!memory_access_is_direct(mr, true)) {
+    if (!memory_access_is_direct(mr, true, attrs)) {
         uint64_t val;
         MemTxResult result;
         bool release_lock = prepare_mmio_access(mr);
@@ -2965,7 +2965,7 @@ static MemTxResult flatview_read_continue_step(MemTxAttrs attrs, uint8_t *buf,
         return MEMTX_ACCESS_ERROR;
     }
 
-    if (!memory_access_is_direct(mr, false)) {
+    if (!memory_access_is_direct(mr, false, attrs)) {
         /* I/O case */
         uint64_t val;
         MemTxResult result;
@@ -3274,7 +3274,7 @@ static bool flatview_access_valid(FlatView *fv, hwaddr addr, hwaddr len,
     while (len > 0) {
         l = len;
         mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
-        if (!memory_access_is_direct(mr, is_write)) {
+        if (!memory_access_is_direct(mr, is_write, attrs)) {
             l = memory_access_size(mr, l, addr);
             if (!memory_region_access_valid(mr, xlat, l, is_write, attrs)) {
                 return false;
@@ -3354,7 +3354,7 @@ void *address_space_map(AddressSpace *as,
     fv = address_space_to_flatview(as);
     mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
 
-    if (!memory_access_is_direct(mr, is_write)) {
+    if (!memory_access_is_direct(mr, is_write, attrs)) {
         size_t used = qatomic_read(&as->bounce_buffer_size);
         for (;;) {
             hwaddr alloc = MIN(as->max_bounce_buffer_size - used, l);
@@ -3487,7 +3487,7 @@ int64_t address_space_cache_init(MemoryRegionCache *cache,
 
     mr = cache->mrs.mr;
     memory_region_ref(mr);
-    if (memory_access_is_direct(mr, is_write)) {
+    if (memory_access_is_direct(mr, is_write, MEMTXATTRS_UNSPECIFIED)) {
         /* We don't care about the memory attributes here as we're only
          * doing this if we found actual RAM, which behaves the same
          * regardless of attributes; so UNSPECIFIED is fine.
diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index 0e6f3940a9..7f32d3d9ff 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -34,7 +34,7 @@ static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
 
     RCU_READ_LOCK();
     mr = TRANSLATE(addr, &addr1, &l, false, attrs);
-    if (l < 4 || !memory_access_is_direct(mr, false)) {
+    if (l < 4 || !memory_access_is_direct(mr, false, attrs)) {
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
@@ -103,7 +103,7 @@ static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
 
     RCU_READ_LOCK();
     mr = TRANSLATE(addr, &addr1, &l, false, attrs);
-    if (l < 8 || !memory_access_is_direct(mr, false)) {
+    if (l < 8 || !memory_access_is_direct(mr, false, attrs)) {
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
@@ -170,7 +170,7 @@ uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
 
     RCU_READ_LOCK();
     mr = TRANSLATE(addr, &addr1, &l, false, attrs);
-    if (!memory_access_is_direct(mr, false)) {
+    if (!memory_access_is_direct(mr, false, attrs)) {
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
@@ -207,7 +207,7 @@ static inline uint16_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
 
     RCU_READ_LOCK();
     mr = TRANSLATE(addr, &addr1, &l, false, attrs);
-    if (l < 2 || !memory_access_is_direct(mr, false)) {
+    if (l < 2 || !memory_access_is_direct(mr, false, attrs)) {
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
@@ -277,7 +277,7 @@ void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL,
 
     RCU_READ_LOCK();
     mr = TRANSLATE(addr, &addr1, &l, true, attrs);
-    if (l < 4 || !memory_access_is_direct(mr, true)) {
+    if (l < 4 || !memory_access_is_direct(mr, true, attrs)) {
         release_lock |= prepare_mmio_access(mr);
 
         r = memory_region_dispatch_write(mr, addr1, val, MO_32, attrs);
@@ -314,7 +314,7 @@ static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
 
     RCU_READ_LOCK();
     mr = TRANSLATE(addr, &addr1, &l, true, attrs);
-    if (l < 4 || !memory_access_is_direct(mr, true)) {
+    if (l < 4 || !memory_access_is_direct(mr, true, attrs)) {
         release_lock |= prepare_mmio_access(mr);
         r = memory_region_dispatch_write(mr, addr1, val,
                                          MO_32 | devend_memop(endian), attrs);
@@ -377,7 +377,7 @@ void glue(address_space_stb, SUFFIX)(ARG1_DECL,
 
     RCU_READ_LOCK();
     mr = TRANSLATE(addr, &addr1, &l, true, attrs);
-    if (!memory_access_is_direct(mr, true)) {
+    if (!memory_access_is_direct(mr, true, attrs)) {
         release_lock |= prepare_mmio_access(mr);
         r = memory_region_dispatch_write(mr, addr1, val, MO_8, attrs);
     } else {
@@ -410,7 +410,7 @@ static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL,
 
     RCU_READ_LOCK();
     mr = TRANSLATE(addr, &addr1, &l, true, attrs);
-    if (l < 2 || !memory_access_is_direct(mr, true)) {
+    if (l < 2 || !memory_access_is_direct(mr, true, attrs)) {
         release_lock |= prepare_mmio_access(mr);
         r = memory_region_dispatch_write(mr, addr1, val,
                                          MO_16 | devend_memop(endian), attrs);
@@ -474,7 +474,7 @@ static void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
 
     RCU_READ_LOCK();
     mr = TRANSLATE(addr, &addr1, &l, true, attrs);
-    if (l < 8 || !memory_access_is_direct(mr, true)) {
+    if (l < 8 || !memory_access_is_direct(mr, true, attrs)) {
         release_lock |= prepare_mmio_access(mr);
         r = memory_region_dispatch_write(mr, addr1, val,
                                          MO_64 | devend_memop(endian), attrs);
diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index aa1455b629..1554f3b801 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -137,7 +137,8 @@ static void apple_gfx_destroy_task(AppleGFXState *s, PGTask_t *task)
                                          MEMTXATTRS_UNSPECIFIED);
 
     if (!ram_region || ram_region_length < length ||
-        !memory_access_is_direct(ram_region, !read_only)) {
+        !memory_access_is_direct(ram_region, !read_only,
+				 MEMTXATTRS_UNSPECIFIED)) {
         return NULL;
     }
 
-- 
2.47.0


