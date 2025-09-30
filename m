Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07734CCA475
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 12:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3ZaZ-0002G2-D3; Tue, 30 Sep 2025 08:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3ZaJ-0002Ep-QD
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 08:36:01 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3ZaC-0007gA-U6
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 08:35:59 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e5b7dfeb0so3596915e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 05:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759235746; x=1759840546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eFA98SekIqFUzvB+1uunWekckAE89JbcwZ9hWbRAHWU=;
 b=F+x5PVbVOQrwzDwbcb5enNbpa06h8G+HjVcKjUGs/s+SoBxYOA4i8nZ8Ank3Zcb+Zk
 ZKOpi4OVjxtngeTVaQvmCYQdkWUZoQL8tunTiATyJrTeA3xRIb1jn0RpvgzCjqm2hS/a
 T5aRUV92R7W8P57RhUOBzfO6fREE7ff3M5SFL4nKhqW+3MwPlSTogOlyqWhPXmNJ86SX
 wqMjtAXVPM3XyHe3FQGBzpsvApbFNGI46kkw5kS9kIfjaZuWYREkdreBy/wHUUyGsAdC
 W7C5z9hQBHGVxHBYtzmuXMOZVbNIjtDHIELaokXjaosdWcbMVXYwF7vQeBrclrExD/dx
 WRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759235746; x=1759840546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eFA98SekIqFUzvB+1uunWekckAE89JbcwZ9hWbRAHWU=;
 b=bZP061aabT7uzuVOXAtWQePJA/x0z0H267xVi0QBGfEdGvemJFahXDdKs0JIP2V3zP
 3ouxtjrs3YIOEemTQIQtIaUf1TuKiVHjk+IPEfH1snuuSaQeV6juS90xRO7ztrgUwmMu
 PnNAJTp6rBC92sZrnM0upPLjv3olMJtFI4GxB5Kr7fshgkgf3zClNAkwzBJVzB8oEExA
 MFZrBjbc0wkoKzHsAtPIv2fhGLTTPK/4m5RYo+0ROVAre+IV/nBkX/1A6/1eEk6bgcpN
 Im8AHTyUEu7X2OAClbdIbREA3RbNklD6QhQuQ2uzR1CLXEdk0BDDDyZl/MNMWaMdhcYp
 ry8A==
X-Gm-Message-State: AOJu0YxPQv5p7Sigj98ZYRHINrS+Hu9ZOMTsJ/sbXVVLXclzf1AQipkK
 LlwfQGSaCtO7gIkLpMRPE2kh7zcXY2t/qhtQmRD3Bq46WWr3Ka1LghBuT/NeBT8IjPnSQTCbIvp
 7ECysSenIPg==
X-Gm-Gg: ASbGncvAwg9wjVFZJ19d1dlqcv+49ISlxJ/GomPF6v86O3/Bzlk1lUvhelQpgjYrBx4
 fVQT595qvU0LuhN//aaeB2bnAGJ+uuQGXlI1OnkZaKra4/0z1/iOy1KHqpd1AguVtg0CnKW/OE+
 qg9WKVFXaBds1NIt5kGEx1dood6c8hej2WBc7fsVa5rhFJpdqJPOl7ZnMkttoesxEO28a3E3MxS
 /t0sQgt6U5FjOA41TjwS8oqg+hZCulsErld9w6fzJY2pLgPX4d2r1eKpnFL5sBCEYfaIqaVi5KD
 zQSCcMbnH93+vSPPvRc2xKaZ7T1qGgq+Tu1mTLiaKPxMI39sJ6433PGrfXJw6Uc3mGJe/yIdmti
 ySvnkx2W84ol9NEfvy7CR2Abp78O3RWtLQOmS/hhS9TzaagDAmx3CqDycOoGVY1pRGJE2HdErXq
 PTZ/6yCLWzevQPiHijrbmX
X-Google-Smtp-Source: AGHT+IEfX9LjcY83wGmjTrbGN7K4ERrTyIijJiZu4ktrfuYreqiIFTYe2bzCbWyYXDoKEAwNmRf4Qg==
X-Received: by 2002:a05:600c:3f12:b0:46e:41e6:28c7 with SMTP id
 5b1f17b1804b1-46e41e6293fmr189932065e9.8.1759235745925; 
 Tue, 30 Sep 2025 05:35:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5602dc2sm22441437f8f.32.2025.09.30.05.35.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Sep 2025 05:35:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 John Levon <john.levon@nutanix.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 3/4] hw/vfio: Avoid ram_addr_t in
 vfio_container_query_dirty_bitmap()
Date: Tue, 30 Sep 2025 14:35:27 +0200
Message-ID: <20250930123528.42878-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930123528.42878-1-philmd@linaro.org>
References: <20250930123528.42878-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

The 'ram_addr_t' type is described as:

  a QEMU internal address space that maps guest RAM physical
  addresses into an intermediate address space that can map
  to host virtual address spaces.

vfio_container_query_dirty_bitmap() doesn't expect such QEMU
intermediate address, but a guest physical addresses. Use the
appropriate 'hwaddr' type, rename as @translated_addr for
clarity.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container.h |  3 ++-
 hw/vfio/container.c              | 11 ++++++-----
 hw/vfio/listener.c               | 18 +++++++++---------
 hw/vfio/trace-events             |  2 +-
 4 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
index b8fb2b8b5d7..093c360f0ee 100644
--- a/include/hw/vfio/vfio-container.h
+++ b/include/hw/vfio/vfio-container.h
@@ -98,7 +98,8 @@ bool vfio_container_dirty_tracking_is_started(
 bool vfio_container_devices_dirty_tracking_is_supported(
     const VFIOContainer *bcontainer);
 int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
-    uint64_t iova, uint64_t size, ram_addr_t ram_addr, Error **errp);
+                                      uint64_t iova, uint64_t size,
+                                      hwaddr translated_addr, Error **errp);
 
 GList *vfio_container_get_iova_ranges(const VFIOContainer *bcontainer);
 
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 250b20f4245..9d694393714 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -246,7 +246,7 @@ static int vfio_container_devices_query_dirty_bitmap(
 
 int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
                                       uint64_t iova, uint64_t size,
-                                      ram_addr_t ram_addr, Error **errp)
+                                      hwaddr translated_addr, Error **errp)
 {
     bool all_device_dirty_tracking =
         vfio_container_devices_dirty_tracking_is_supported(bcontainer);
@@ -255,7 +255,7 @@ int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
     int ret;
 
     if (!bcontainer->dirty_pages_supported && !all_device_dirty_tracking) {
-        cpu_physical_memory_set_dirty_range(ram_addr, size,
+        cpu_physical_memory_set_dirty_range(translated_addr, size,
                                             tcg_enabled() ? DIRTY_CLIENTS_ALL :
                                             DIRTY_CLIENTS_NOCODE);
         return 0;
@@ -280,11 +280,12 @@ int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
         goto out;
     }
 
-    dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
+    dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap,
+                                                         translated_addr,
                                                          vbmap.pages);
 
-    trace_vfio_container_query_dirty_bitmap(iova, size, vbmap.size, ram_addr,
-                                            dirty_pages);
+    trace_vfio_container_query_dirty_bitmap(iova, size, vbmap.size,
+                                            translated_addr, dirty_pages);
 out:
     g_free(vbmap.bitmap);
 
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 3b6f17f0c3a..a2c19a3cec1 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -1059,7 +1059,7 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     VFIOGuestIOMMU *giommu = gdn->giommu;
     VFIOContainer *bcontainer = giommu->bcontainer;
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
-    ram_addr_t translated_addr;
+    hwaddr translated_addr;
     Error *local_err = NULL;
     int ret = -EINVAL;
     MemoryRegion *mr;
@@ -1108,8 +1108,8 @@ static int vfio_ram_discard_query_dirty_bitmap(MemoryRegionSection *section,
 {
     const hwaddr size = int128_get64(section->size);
     const hwaddr iova = section->offset_within_address_space;
-    const ram_addr_t ram_addr = memory_region_get_ram_addr(section->mr) +
-                                section->offset_within_region;
+    const hwaddr translated_addr = memory_region_get_ram_addr(section->mr) +
+                                   section->offset_within_region;
     VFIORamDiscardListener *vrdl = opaque;
     Error *local_err = NULL;
     int ret;
@@ -1118,8 +1118,8 @@ static int vfio_ram_discard_query_dirty_bitmap(MemoryRegionSection *section,
      * Sync the whole mapped region (spanning multiple individual mappings)
      * in one go.
      */
-    ret = vfio_container_query_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr,
-                                &local_err);
+    ret = vfio_container_query_dirty_bitmap(vrdl->bcontainer, iova, size,
+                                            translated_addr, &local_err);
     if (ret) {
         error_report_err(local_err);
     }
@@ -1183,7 +1183,7 @@ static int vfio_sync_iommu_dirty_bitmap(VFIOContainer *bcontainer,
 static int vfio_sync_dirty_bitmap(VFIOContainer *bcontainer,
                                   MemoryRegionSection *section, Error **errp)
 {
-    ram_addr_t ram_addr;
+    hwaddr translated_addr;
 
     if (memory_region_is_iommu(section->mr)) {
         return vfio_sync_iommu_dirty_bitmap(bcontainer, section);
@@ -1198,12 +1198,12 @@ static int vfio_sync_dirty_bitmap(VFIOContainer *bcontainer,
         return ret;
     }
 
-    ram_addr = memory_region_get_ram_addr(section->mr) +
-               section->offset_within_region;
+    translated_addr = memory_region_get_ram_addr(section->mr) +
+                      section->offset_within_region;
 
     return vfio_container_query_dirty_bitmap(bcontainer,
                    REAL_HOST_PAGE_ALIGN(section->offset_within_address_space),
-                                 int128_get64(section->size), ram_addr, errp);
+                   int128_get64(section->size), translated_addr, errp);
 }
 
 static void vfio_listener_log_sync(MemoryListener *listener,
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 981cf40675e..d66b18f507b 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -105,7 +105,7 @@ vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t max32,
 vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
 
 # container.c
-vfio_container_query_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
+vfio_container_query_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t translated_addr, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" gpa=0x%"PRIx64" dirty_pages=%"PRIu64
 
 # container-legacy.c
 vfio_container_disconnect(int fd) "close container->fd=%d"
-- 
2.51.0


