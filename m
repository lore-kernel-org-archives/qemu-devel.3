Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361CFC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfJwM-0004lE-L6; Thu, 02 Jul 2026 12:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wfJwE-0004Xl-DM
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 12:06:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wfJwC-0007SU-Gj
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 12:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783008411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uXfdeyeBs/yL9lJQpogthSB7/mlGmImMV85AwszJ8Jw=;
 b=EAYfIW8ph2/wiE78JVzfy7A1BoGlxdTcnhkf24USpMfaYjrZ/j1csG+BazO+aAjJ2cWKfZ
 D+3XO0TYCPF3l2WNEShwzlbF9cCOjW1wHfJ1sw2xMMkZReb4Yz+dO3llRU+EV/LUncec1a
 d3FyxANr+MjBvi/TNJjwiEZwZxUJl9I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-dPvYBcEJOhe7vXbt-Ya_eQ-1; Thu,
 02 Jul 2026 12:06:48 -0400
X-MC-Unique: dPvYBcEJOhe7vXbt-Ya_eQ-1
X-Mimecast-MFC-AGG-ID: dPvYBcEJOhe7vXbt-Ya_eQ_1783008406
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3DDC1935338; Thu,  2 Jul 2026 16:06:45 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.58])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 37CB13001D8B; Thu,  2 Jul 2026 16:06:42 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Eric Auger <eric.auger@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] vfio/listener: Only warn on misalignment for VFIO-owned
 regions
Date: Thu,  2 Jul 2026 18:06:40 +0200
Message-ID: <20260702160640.3875666-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Any device on the board can have non-page-aligned memory regions. The
VFIO listener should not warn about misalignment for regions that are
not VFIO-related.

Replace the vfio_known_safe_misalignment() whitelist with a
vfio_get_vfio_device() ownership check: only warn when a VFIO device's
own region is misaligned. For all other regions, emit a trace event
and silently skip. Extract the misalignment test into a
vfio_section_misaligned() helper for readability.

Note: vfio_get_vfio_device() currently only covers VFIO PCI devices,
including vfio-user-pci.  Other VFIO backends (AP, CCW) don't expose
memory regions through this path so this is sufficient for now.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/device.c     |  2 +-
 hw/vfio/listener.c   | 33 +++++++++++++++------------------
 hw/vfio/trace-events |  2 +-
 3 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 1a7f8088aad9583ee96fc303be917fdb2f100df9..3a47109efb35c6dc28719dcc19acb85bef1d26cd 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -439,7 +439,7 @@ bool vfio_device_hiod_create_and_realize(VFIODevice *vbasedev,
 
 VFIODevice *vfio_get_vfio_device(Object *obj)
 {
-    if (object_dynamic_cast(obj, TYPE_VFIO_PCI)) {
+    if (object_dynamic_cast(obj, TYPE_VFIO_PCI_DEVICE)) {
         return &VFIO_PCI_DEVICE(obj)->vbasedev;
     } else {
         return NULL;
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index c19600e980a8d02217b5d9df4aca8f879ab2c5d5..76b9b02f8163f18d20994e4ec1f914a4d148fa92 100644
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
@@ -352,20 +351,10 @@ static void vfio_ram_discard_unregister_listener(VFIOContainer *bcontainer,
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
-
-    /* this is a known safe misaligned region, just trace for debug purpose */
-    trace_vfio_known_safe_misalignment(memory_region_name(mr),
-                                       section->offset_within_address_space,
-                                       section->offset_within_region,
-                                       qemu_real_host_page_size());
-    return true;
+    return (section->offset_within_address_space & ~qemu_real_host_page_mask()) !=
+           (section->offset_within_region & ~qemu_real_host_page_mask());
 }
 
 static bool vfio_listener_valid_section(MemoryRegionSection *section,
@@ -379,10 +368,12 @@ static bool vfio_listener_valid_section(MemoryRegionSection *section,
         return false;
     }
 
-    if (unlikely((section->offset_within_address_space &
-                  ~qemu_real_host_page_mask()) !=
-                 (section->offset_within_region & ~qemu_real_host_page_mask()))) {
-        if (!vfio_known_safe_misalignment(section)) {
+    if (unlikely(vfio_section_misaligned(section))) {
+        /*
+         * Only warn for VFIO device regions.  Other VFIO backends
+         * (AP, CCW) don't expose memory regions through this path.
+         */
+        if (vfio_get_vfio_device(memory_region_owner(section->mr))) {
             error_report("%s received unaligned region %s iova=0x%"PRIx64
                          " offset_within_region=0x%"PRIx64
                          " qemu_real_host_page_size=0x%"PRIxPTR,
@@ -390,6 +381,12 @@ static bool vfio_listener_valid_section(MemoryRegionSection *section,
                          section->offset_within_address_space,
                          section->offset_within_region,
                          qemu_real_host_page_size());
+        } else {
+            trace_vfio_listener_region_misaligned(
+                         memory_region_name(section->mr),
+                         section->offset_within_address_space,
+                         section->offset_within_region,
+                         qemu_real_host_page_size());
         }
         return false;
     }
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index f71d0bbc0a5440e4ccd374fac4733af08438e7be..5056b9942027938cd6bc832198acc9809739399f 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -98,7 +98,7 @@ vfio_spapr_group_attach(int groupfd, int tablefd) "Attached groupfd %d to liobn
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


