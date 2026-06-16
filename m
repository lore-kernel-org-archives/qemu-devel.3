Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4086DCD98EF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZAS-0006fO-JY; Tue, 16 Jun 2026 15:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8I-0004Zx-Kb
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:37 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8A-00011M-V4
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:30 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-460166910e6so2632984f8f.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636836; x=1782241636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TSml+C+o8e5g2HzgYLSNK9fnxCmPI3ITde5GKhyWgGw=;
 b=PhffYPtyJBLuMMtTqftR8gkA+/EWR7mklMP4jPie6wtJL7dbeOU6iOz3bP/wIR4Y9r
 aOMTP6XBRMDLaAa8sezzY06VHn0UAXFybxmjQiEZwNz+RdMAOAY071DxKr3/wI9H42nT
 VZEG32vtC93V1Rfk1pzlfmRssk17lBlKwOfCr2HIa9cJwoyCip6lXKC8KYmcE1qqJRnW
 KH/iXFXJi8apno/4Y2WOEJ9qdbJxUHGPynFPwQS4Q4GPTakjFxz7H4Eae7zd+UdmoYLs
 9tHz8A08Yk+0/VcDt6ZGTunCQajOxB6/HtwFo3LtCO9qGE41y+mo2aeR4pxBajSouDgO
 FQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636836; x=1782241636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TSml+C+o8e5g2HzgYLSNK9fnxCmPI3ITde5GKhyWgGw=;
 b=aWmckgjAEyYoSWj4cJ8WDNvz2WK6lHopBuA5nh2+jAGLIO3oegKROdrtv+2UCaZCah
 AgmkgwzgdnmLHXYLKkQXXATD9nolw0gP7ElARDKrplDFPYc7BK3FHoVjBB4hguClbBvq
 7sweTTthJIEEWzL6D+brITlaSE87l1w98hkvuLT5sZpI7dDWnLviGiGnIXaxZfqk9/IK
 QQI1Sq1fmAXwNYwJ0lEx35DR3Xos/5ylrAd75FnwYK2V4jTHocv2jc/DmeqK4O6oC5Bw
 OfrSkxcGBUBKdAa56RDDvk4k9KdMx4B0mjHv5WaFfGDt1l6Cmwcccir157aDpw47IQV0
 X9MA==
X-Gm-Message-State: AOJu0YyWN3TEjc4+38KcVFVNZABt1mT95eaEKjbTO8A6sCGTFPq4MXQu
 k/hOsyRfKwHVj4CB9IKX2faGW15XUnKu4WtVeHnlW+4it1HmvDtrYrXwvz4ugXrhq2SCPu+G65e
 c8Rla
X-Gm-Gg: Acq92OG4hgwxKMnl3acf/z+WqrS81ytsR3xHeirudGwenHkiBUPa2BoM/010CnC9llj
 fOH7yxUYmzHCGqwBE3VsUc3LlT7fUtn/uSLKzrJZn+dxe2v+cGui09LQZRBQtfT4yNMNYIPys9w
 OWJOENYuBaEbIPQyJRxBHOGehwmCKwbiB6sCHiNaRBzrb8Vd6H4FJ0stqiOvzbu8iQQZD8LJsZX
 gbM+NqHIIL85kpbKlNftzb8aLGyW6RaxihocsAWYOlGY6OT7S+BJQoMSV9VA0dEHMxCrYm/0BFx
 S1unwkcF/Bajpa2ZCvK8RV76pVbgNojbjzyBMDRO1sxuftvv8PUg6yv1qbhFZVtrKm6axEzyE/G
 Z/elasiebxNEzAnoGnsn45A8o60UFQHCwutheg5xdwuQHOzK5KxWqB9CkIcMT2SksX+/VVDbpG4
 fzYGAM/WXLyuFdHXEOUiEcUaGYbvjT3AYNqGS9t3oLlFWSpi0U9JrPE5ZHJFpuqQpKnuEIhLseD
 S9GWebt/oWphmUSu64ndfjOTHjhRL9a
X-Received: by 2002:a05:6000:2404:b0:45e:6518:3299 with SMTP id
 ffacd0b85a97d-46236930430mr1298944f8f.5.1781636835767; 
 Tue, 16 Jun 2026 12:07:15 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/61] memory: Allow RAM device regions to skip IOMMU mapping
Date: Tue, 16 Jun 2026 20:06:07 +0100
Message-ID: <20260616190639.3462006-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

Some RAM device regions created with memory_region_init_ram_device_ptr()
are not intended to be P2P DMA targets.

The VFIO listener currently treats all RAM device regions as DMA
capable and attempts to map them into the IOMMU. For regions without
dma-buf backing this fails and prints warnings such as:

  IOMMU_IOAS_MAP failed: Bad address, PCI BAR?

Introduce a MemoryRegion flag (ram_device_skip_iommu_map) to mark RAM
device regions that should not be IOMMU mapped, paired with
memory_region_skip_iommu_map() / memory_region_set_skip_iommu_map()
accessors. When the flag is set, the VFIO listener skips DMA mapping
for that region.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260609112552.378999-21-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/vfio/listener.c      |  6 ++++++
 hw/vfio/trace-events    |  1 +
 include/system/memory.h | 21 +++++++++++++++++++++
 system/memory.c         | 10 ++++++++++
 4 files changed, 38 insertions(+)

diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 0b72a2cf5e..14cca678ae 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -610,6 +610,12 @@ void vfio_container_region_add(VFIOContainer *bcontainer,
         }
     }
 
+    if (memory_region_skip_iommu_map(section->mr)) {
+        trace_vfio_listener_region_skip_dma_map(memory_region_name(section->mr),
+                                                iova, int128_get64(llsize));
+        return;
+    }
+
     ret = vfio_container_dma_map(bcontainer, iova, int128_get64(llsize),
                                  vaddr, section->readonly, section->mr);
     if (ret) {
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 2049159015..70c5aa1bcc 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -100,6 +100,7 @@ vfio_listener_region_del_iommu(const char *name) "region_del [iommu] %s"
 vfio_listener_region_add_ram(uint64_t iova_start, uint64_t iova_end, void *vaddr) "region_add [ram] 0x%"PRIx64" - 0x%"PRIx64" [%p]"
 vfio_known_safe_misalignment(const char *name, uint64_t iova, uint64_t offset_within_region, uintptr_t page_size) "Region \"%s\" iova=0x%"PRIx64" offset_within_region=0x%"PRIx64" qemu_real_host_page_size=0x%"PRIxPTR
 vfio_listener_region_add_no_dma_map(const char *name, uint64_t iova, uint64_t size, uint64_t page_size) "Region \"%s\" 0x%"PRIx64" size=0x%"PRIx64" is not aligned to 0x%"PRIx64" and cannot be mapped for DMA"
+vfio_listener_region_skip_dma_map(const char *name, uint64_t iova, uint64_t size) "Region \"%s\" 0x%"PRIx64" size=0x%"PRIx64" marked to skip IOMMU mapping"
 vfio_listener_region_del(uint64_t start, uint64_t end) "region_del 0x%"PRIx64" - 0x%"PRIx64
 vfio_device_dirty_tracking_update(uint64_t start, uint64_t end, uint64_t min, uint64_t max) "section 0x%"PRIx64" - 0x%"PRIx64" -> update [0x%"PRIx64" - 0x%"PRIx64"]"
 vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t max32, uint64_t min64, uint64_t max64, uint64_t minpci, uint64_t maxpci) "nr_ranges %d 32:[0x%"PRIx64" - 0x%"PRIx64"], 64:[0x%"PRIx64" - 0x%"PRIx64"], pci64:[0x%"PRIx64" - 0x%"PRIx64"]"
diff --git a/include/system/memory.h b/include/system/memory.h
index 1417132f6d..4560809013 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -864,6 +864,8 @@ struct MemoryRegion {
 
     /* For devices designed to perform re-entrant IO into their own IO MRs */
     bool disable_reentrancy_guard;
+    /* RAM device region that does not require IOMMU mapping for P2P */
+    bool ram_device_skip_iommu_map;
 };
 
 struct IOMMUMemoryRegion {
@@ -1743,6 +1745,25 @@ static inline bool memory_region_is_romd(const MemoryRegion *mr)
  */
 bool memory_region_is_protected(const MemoryRegion *mr);
 
+/**
+ * memory_region_skip_iommu_map: check whether a memory region is excluded
+ *                               from IOMMU mapping
+ *
+ * Returns %true if @mr is a RAM device region marked to skip IOMMU mapping.
+ *
+ * @mr: the memory region being queried
+ */
+bool memory_region_skip_iommu_map(const MemoryRegion *mr);
+
+/**
+ * memory_region_set_skip_iommu_map: mark a RAM device region to skip IOMMU
+ *                                   mapping
+ *
+ * @mr: the memory region being modified
+ * @skip: %true to skip IOMMU mapping, %false to allow it
+ */
+void memory_region_set_skip_iommu_map(MemoryRegion *mr, bool skip);
+
 /**
  * memory_region_has_guest_memfd: check whether a memory region has guest_memfd
  *     associated
diff --git a/system/memory.c b/system/memory.c
index 739ba11da6..48245fd01b 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1814,6 +1814,16 @@ bool memory_region_is_protected(const MemoryRegion *mr)
     return mr->ram && (mr->ram_block->flags & RAM_PROTECTED);
 }
 
+bool memory_region_skip_iommu_map(const MemoryRegion *mr)
+{
+    return memory_region_is_ram_device(mr) && mr->ram_device_skip_iommu_map;
+}
+
+void memory_region_set_skip_iommu_map(MemoryRegion *mr, bool skip)
+{
+    mr->ram_device_skip_iommu_map = skip;
+}
+
 bool memory_region_has_guest_memfd(const MemoryRegion *mr)
 {
     return mr->ram_block && mr->ram_block->guest_memfd >= 0;
-- 
2.43.0


