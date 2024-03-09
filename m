Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE10AC54E60
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2IQ-0001Rf-KE; Sat, 09 Mar 2024 14:23:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2IK-00011k-7G
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:23:47 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2II-0002dG-7H
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:23:43 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a3f893ad5f4so242826966b.2
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012220; x=1710617020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nJ7HW/Ft7i83AZTN2mskut6mEUi0nRJo8gD5MOoOvrw=;
 b=T+m7ZfltFHJ7ycKtMIpk6QC45W396GSVtAi5n+ZrWKY3HMFd7SfOZ/RnwJt3XjBaaf
 WKhaPGAuZ5nF29FTKUYJY+SJ4KZTfFkJMK09bDKIoGU1M5mMF7iO4fENHPgh8nqAEPDd
 jgEor89q0C8t3Hk+tv5Dh04wkaH8Jl/EMcRbWPyxJwwp8rHdb/JYGQyGMDp+jh7+NE9Z
 mO4CqXzfVhctMh/K4E5rruDz7+qpOlsZlpqOkoZ34utMrHxIrxrd7Lct5ueBZLZ4ZwEJ
 2eRBPKf1RAuEq+gqpE8gqiTQN6jUN1mYsYNBQuEFXopATGtCosLECW6cwEZMJZgktHzM
 9qTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012220; x=1710617020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nJ7HW/Ft7i83AZTN2mskut6mEUi0nRJo8gD5MOoOvrw=;
 b=abBcZnBSui1e2fUfGBd2/is/UtDpE0db236ZqYNo+paqTR1HZB7uMFCi8u37se6u+W
 iDS9vKAIh4H5L06dG0bMu8undH7CWAVRtl6rmbFzFhlwrm0VwugSwlnjVAC2l8hIkANd
 YJoOesQ+dBEtbYX9qgDD1H4l0U7L4r2ouQ+kBGXdalj23A32yIM0Cnt0+rjthrDYXUIx
 z4O5eWVhq6PKWu97Fzi0wgmjfrECejQ2rP7gknXQGEt0mulBEbJMmEo1rj6HMEuM9dcr
 RZZiYY1zgtlIHERWEG5ojke+oY8Wd5GA2BNwvJnqvfPSAv2PPt1x8ctQLGyw4IESp0i+
 eCdA==
X-Gm-Message-State: AOJu0YxgG3v6mcszX379ONs4JeWq9OJJkTlSXlErnFGUcV1uBxA+fVwZ
 /qkIONvxon+GCIvM/txa9jimnqXatQEOEjuw9oJMH4Q8efzNfED6xypbKByv+YuiYVhbp49rCvu
 h
X-Google-Smtp-Source: AGHT+IGJ8dRKKvAEJydBIDk5EIHimW4WL5gyfDXoimVbXutg1h6Ab0DpFGsPNz89nrlp7nNRGTQq2A==
X-Received: by 2002:a17:907:96ab:b0:a44:17da:424 with SMTP id
 hd43-20020a17090796ab00b00a4417da0424mr1554598ejc.56.1710012220525; 
 Sat, 09 Mar 2024 11:23:40 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 k9-20020a1709063e0900b00a45a73e0be9sm1167156eji.180.2024.03.09.11.23.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:23:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 xen-devel@lists.xenproject.org
Subject: [PULL 14/43] hw/xen/hvm: Get target page size at runtime
Date: Sat,  9 Mar 2024 20:21:41 +0100
Message-ID: <20240309192213.23420-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In order to build this file once for all targets, replace:

  TARGET_PAGE_BITS -> qemu_target_page_bits()
  TARGET_PAGE_SIZE -> qemu_target_page_size()
  TARGET_PAGE_MASK -> -qemu_target_page_size()

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20231114163123.74888-4-philmd@linaro.org>
---
 hw/i386/xen/xen-hvm.c | 62 +++++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 23 deletions(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 844b11ae08..7745cb3963 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -23,6 +23,7 @@
 #include "hw/xen/xen-hvm-common.h"
 #include "hw/xen/arch_hvm.h"
 #include <xen/hvm/e820.h>
+#include "exec/target_page.h"
 
 static MemoryRegion ram_640k, ram_lo, ram_hi;
 static MemoryRegion *framebuffer;
@@ -247,6 +248,9 @@ static int xen_add_to_physmap(XenIOState *state,
                               MemoryRegion *mr,
                               hwaddr offset_within_region)
 {
+    unsigned target_page_bits = qemu_target_page_bits();
+    int page_size = qemu_target_page_size();
+    int page_mask = -page_size;
     unsigned long nr_pages;
     int rc = 0;
     XenPhysmap *physmap = NULL;
@@ -254,7 +258,7 @@ static int xen_add_to_physmap(XenIOState *state,
     hwaddr phys_offset = memory_region_get_ram_addr(mr);
     const char *mr_name;
 
-    if (get_physmapping(start_addr, size, TARGET_PAGE_MASK)) {
+    if (get_physmapping(start_addr, size, page_mask)) {
         return 0;
     }
     if (size <= 0) {
@@ -294,9 +298,9 @@ go_physmap:
         return 0;
     }
 
-    pfn = phys_offset >> TARGET_PAGE_BITS;
-    start_gpfn = start_addr >> TARGET_PAGE_BITS;
-    nr_pages = size >> TARGET_PAGE_BITS;
+    pfn = phys_offset >> target_page_bits;
+    start_gpfn = start_addr >> target_page_bits;
+    nr_pages = size >> target_page_bits;
     rc = xendevicemodel_relocate_memory(xen_dmod, xen_domid, nr_pages, pfn,
                                         start_gpfn);
     if (rc) {
@@ -310,8 +314,8 @@ go_physmap:
     }
 
     rc = xendevicemodel_pin_memory_cacheattr(xen_dmod, xen_domid,
-                                   start_addr >> TARGET_PAGE_BITS,
-                                   (start_addr + size - 1) >> TARGET_PAGE_BITS,
+                                   start_addr >> target_page_bits,
+                                   (start_addr + size - 1) >> target_page_bits,
                                    XEN_DOMCTL_MEM_CACHEATTR_WB);
     if (rc) {
         error_report("pin_memory_cacheattr failed: %s", strerror(errno));
@@ -323,11 +327,14 @@ static int xen_remove_from_physmap(XenIOState *state,
                                    hwaddr start_addr,
                                    ram_addr_t size)
 {
+    unsigned target_page_bits = qemu_target_page_bits();
+    int page_size = qemu_target_page_size();
+    int page_mask = -page_size;
     int rc = 0;
     XenPhysmap *physmap = NULL;
     hwaddr phys_offset = 0;
 
-    physmap = get_physmapping(start_addr, size, TARGET_PAGE_MASK);
+    physmap = get_physmapping(start_addr, size, page_mask);
     if (physmap == NULL) {
         return -1;
     }
@@ -338,9 +345,9 @@ static int xen_remove_from_physmap(XenIOState *state,
     DPRINTF("unmapping vram to %"HWADDR_PRIx" - %"HWADDR_PRIx", at "
             "%"HWADDR_PRIx"\n", start_addr, start_addr + size, phys_offset);
 
-    size >>= TARGET_PAGE_BITS;
-    start_addr >>= TARGET_PAGE_BITS;
-    phys_offset >>= TARGET_PAGE_BITS;
+    size >>= target_page_bits;
+    start_addr >>= target_page_bits;
+    phys_offset >>= target_page_bits;
     rc = xendevicemodel_relocate_memory(xen_dmod, xen_domid, size, start_addr,
                                         phys_offset);
     if (rc) {
@@ -369,13 +376,16 @@ static void xen_sync_dirty_bitmap(XenIOState *state,
                                   hwaddr start_addr,
                                   ram_addr_t size)
 {
-    hwaddr npages = size >> TARGET_PAGE_BITS;
+    unsigned target_page_bits = qemu_target_page_bits();
+    int page_size = qemu_target_page_size();
+    int page_mask = -page_size;
+    hwaddr npages = size >> target_page_bits;
     const int width = sizeof(unsigned long) * 8;
     size_t bitmap_size = DIV_ROUND_UP(npages, width);
     int rc, i, j;
     const XenPhysmap *physmap = NULL;
 
-    physmap = get_physmapping(start_addr, size, TARGET_PAGE_MASK);
+    physmap = get_physmapping(start_addr, size, page_mask);
     if (physmap == NULL) {
         /* not handled */
         return;
@@ -389,7 +399,7 @@ static void xen_sync_dirty_bitmap(XenIOState *state,
         return;
     }
 
-    rc = xen_track_dirty_vram(xen_domid, start_addr >> TARGET_PAGE_BITS,
+    rc = xen_track_dirty_vram(xen_domid, start_addr >> target_page_bits,
                               npages, dirty_bitmap);
     if (rc < 0) {
 #ifndef ENODATA
@@ -410,8 +420,7 @@ static void xen_sync_dirty_bitmap(XenIOState *state,
             j = ctzl(map);
             map &= ~(1ul << j);
             memory_region_set_dirty(framebuffer,
-                                    (i * width + j) * TARGET_PAGE_SIZE,
-                                    TARGET_PAGE_SIZE);
+                                    (i * width + j) * page_size, page_size);
         };
     }
 }
@@ -631,17 +640,21 @@ void xen_register_framebuffer(MemoryRegion *mr)
 
 void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
 {
+    unsigned target_page_bits = qemu_target_page_bits();
+    int page_size = qemu_target_page_size();
+    int page_mask = -page_size;
+
     if (unlikely(xen_in_migration)) {
         int rc;
         ram_addr_t start_pfn, nb_pages;
 
-        start = xen_phys_offset_to_gaddr(start, length, TARGET_PAGE_MASK);
+        start = xen_phys_offset_to_gaddr(start, length, page_mask);
 
         if (length == 0) {
-            length = TARGET_PAGE_SIZE;
+            length = page_size;
         }
-        start_pfn = start >> TARGET_PAGE_BITS;
-        nb_pages = ((start + length + TARGET_PAGE_SIZE - 1) >> TARGET_PAGE_BITS)
+        start_pfn = start >> target_page_bits;
+        nb_pages = ((start + length + page_size - 1) >> target_page_bits)
             - start_pfn;
         rc = xen_modified_memory(xen_domid, start_pfn, nb_pages);
         if (rc) {
@@ -664,6 +677,9 @@ void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
 void arch_xen_set_memory(XenIOState *state, MemoryRegionSection *section,
                                 bool add)
 {
+    unsigned target_page_bits = qemu_target_page_bits();
+    int page_size = qemu_target_page_size();
+    int page_mask = -page_size;
     hwaddr start_addr = section->offset_within_address_space;
     ram_addr_t size = int128_get64(section->size);
     bool log_dirty = memory_region_is_logging(section->mr, DIRTY_MEMORY_VGA);
@@ -679,8 +695,8 @@ void arch_xen_set_memory(XenIOState *state, MemoryRegionSection *section,
 
     trace_xen_client_set_memory(start_addr, size, log_dirty);
 
-    start_addr &= TARGET_PAGE_MASK;
-    size = ROUND_UP(size, TARGET_PAGE_SIZE);
+    start_addr &= page_mask;
+    size = ROUND_UP(size, page_size);
 
     if (add) {
         if (!memory_region_is_rom(section->mr)) {
@@ -689,8 +705,8 @@ void arch_xen_set_memory(XenIOState *state, MemoryRegionSection *section,
         } else {
             mem_type = HVMMEM_ram_ro;
             if (xen_set_mem_type(xen_domid, mem_type,
-                                 start_addr >> TARGET_PAGE_BITS,
-                                 size >> TARGET_PAGE_BITS)) {
+                                 start_addr >> target_page_bits,
+                                 size >> target_page_bits)) {
                 DPRINTF("xen_set_mem_type error, addr: "HWADDR_FMT_plx"\n",
                         start_addr);
             }
-- 
2.41.0


