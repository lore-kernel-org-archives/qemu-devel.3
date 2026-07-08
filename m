Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395B9C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 13:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whSRp-0006F9-7B; Wed, 08 Jul 2026 09:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1whSRm-0006EP-UJ
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 09:36:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1whSRk-0007CA-DP
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 09:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783517773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KzNFA2tBcp3Exp5k+8TLpJUtQhHqZThwshCpUmFxIRM=;
 b=Tt+TERLZJHw6RpISIwe9dCHZHrTYeoJVVC6VkmbUidqzFDWf2J7cz16SA3FM0Rz4SXEsZC
 9lpizr6EE0l6CwsDFRjPjuPJKCTRGQSVOrkJWCeoyywrKXdBc1g+9D59Trrw4iyx7ElPoE
 La6ygqcHs3eCyeFfSzZoZJsNjvIvH1w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-v7N4Tx6nPBKlAJYYOIkEjw-1; Wed,
 08 Jul 2026 09:36:11 -0400
X-MC-Unique: v7N4Tx6nPBKlAJYYOIkEjw-1
X-Mimecast-MFC-AGG-ID: v7N4Tx6nPBKlAJYYOIkEjw_1783517770
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 468541954B06; Wed,  8 Jul 2026 13:36:10 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.253])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AE38D18005B9; Wed,  8 Jul 2026 13:36:07 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2] vfio/listener: Replace misalignment whitelist with DMA
 capability check
Date: Wed,  8 Jul 2026 15:36:04 +0200
Message-ID: <20260708133604.1606448-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The vfio_known_safe_misalignment() whitelist (currently TPM CRB only)
requires a new entry every time a device exposes a non-page-aligned
region, which does not scale.

Replace it with a DMA capability check: a region that is not
page-aligned or is smaller than a host page can never be a valid DMA
target, so a page-offset mismatch is harmless and only traced. Only
warn for page-aligned, page-sized regions where the mismatch could
indicate a real mapping problem.

This removes the TPM CRB dependency from the VFIO listener and
eliminates the need for per-device whitelisting entirely.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260702160640.3875666-1-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/listener.c   | 47 +++++++++++++++++++++++++-------------------
 hw/vfio/trace-events |  2 +-
 2 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index c19600e980a8d02217b5d9df4aca8f879ab2c5d5..f2c3603a920b99002630d6f47af5bbbdfed8be86 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -40,7 +40,6 @@
 #include "migration/misc.h"
 #include "migration/qemu-file.h"
 #include "system/tcg.h"
-#include "system/tpm.h"
 #include "vfio-migration-internal.h"
 #include "vfio-helpers.h"
 #include "vfio-listener.h"
@@ -352,20 +351,17 @@ static void vfio_ram_discard_unregister_listener(VFIOContainer *bcontainer,
     g_free(vrdl);
 }
 
-static bool vfio_known_safe_misalignment(MemoryRegionSection *section)
+static bool vfio_section_misaligned(MemoryRegionSection *section)
 {
-    MemoryRegion *mr = section->mr;
-
-    if (!TPM_IS_CRB(mr->owner)) {
-        return false;
-    }
+    return (section->offset_within_address_space & ~qemu_real_host_page_mask()) !=
+        (section->offset_within_region & ~qemu_real_host_page_mask());
+}
 
-    /* this is a known safe misaligned region, just trace for debug purpose */
-    trace_vfio_known_safe_misalignment(memory_region_name(mr),
-                                       section->offset_within_address_space,
-                                       section->offset_within_region,
-                                       qemu_real_host_page_size());
-    return true;
+static bool vfio_section_dma_capable(MemoryRegionSection *section)
+{
+    return QEMU_IS_ALIGNED(section->offset_within_address_space,
+                           qemu_real_host_page_size()) &&
+        int128_ge(section->size, int128_make64(qemu_real_host_page_size()));
 }
 
 static bool vfio_listener_valid_section(MemoryRegionSection *section,
@@ -379,17 +375,28 @@ static bool vfio_listener_valid_section(MemoryRegionSection *section,
         return false;
     }
 
-    if (unlikely((section->offset_within_address_space &
-                  ~qemu_real_host_page_mask()) !=
-                 (section->offset_within_region & ~qemu_real_host_page_mask()))) {
-        if (!vfio_known_safe_misalignment(section)) {
-            error_report("%s received unaligned region %s iova=0x%"PRIx64
+    if (unlikely(vfio_section_misaligned(section))) {
+        /*
+         * A region that is not page-aligned or is smaller than a host
+         * page can never be a valid DMA target, so the misalignment is
+         * harmless. Only warn for page-aligned, page-sized regions
+         * where the offset mismatch could indicate a real problem.
+         */
+        if (vfio_section_dma_capable(section)) {
+            error_report("vfio: region %s page-offset mismatch prevents"
+                         " DMA mapping (iova=0x%"PRIx64
                          " offset_within_region=0x%"PRIx64
-                         " qemu_real_host_page_size=0x%"PRIxPTR,
-                         __func__, memory_region_name(section->mr),
+                         " page_size=0x%"PRIxPTR ")",
+                         memory_region_name(section->mr),
                          section->offset_within_address_space,
                          section->offset_within_region,
                          qemu_real_host_page_size());
+        } else {
+            trace_vfio_listener_region_misaligned(
+                memory_region_name(section->mr),
+                section->offset_within_address_space,
+                section->offset_within_region,
+                qemu_real_host_page_size());
         }
         return false;
     }
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index bfdaf229e42b0d9d40e38c828c97cf47eb831a87..8cbad9ad0f3a4cbcbb3b5f00ac7afe392a821071 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -99,7 +99,7 @@ vfio_spapr_group_attach(int groupfd, int tablefd) "Attached groupfd %d to liobn
 vfio_listener_region_add_iommu(const char* name, uint64_t start, uint64_t end) "region_add [iommu] %s 0x%"PRIx64" - 0x%"PRIx64
 vfio_listener_region_del_iommu(const char *name) "region_del [iommu] %s"
 vfio_listener_region_add_ram(uint64_t iova_start, uint64_t iova_end, void *vaddr) "region_add [ram] 0x%"PRIx64" - 0x%"PRIx64" [%p]"
-vfio_known_safe_misalignment(const char *name, uint64_t iova, uint64_t offset_within_region, uintptr_t page_size) "Region \"%s\" iova=0x%"PRIx64" offset_within_region=0x%"PRIx64" qemu_real_host_page_size=0x%"PRIxPTR
+vfio_listener_region_misaligned(const char *name, uint64_t iova, uint64_t offset_within_region, uintptr_t page_size) "Region \"%s\" iova=0x%"PRIx64" offset_within_region=0x%"PRIx64" qemu_real_host_page_size=0x%"PRIxPTR
 vfio_listener_region_add_no_dma_map(const char *name, uint64_t iova, uint64_t size, uint64_t page_size) "Region \"%s\" 0x%"PRIx64" size=0x%"PRIx64" is not aligned to 0x%"PRIx64" and cannot be mapped for DMA"
 vfio_listener_region_skip_dma_map(const char *name, uint64_t iova, uint64_t size) "Region \"%s\" 0x%"PRIx64" size=0x%"PRIx64" marked to skip IOMMU mapping"
 vfio_listener_region_del(uint64_t start, uint64_t end) "region_del 0x%"PRIx64" - 0x%"PRIx64
-- 
2.54.0


