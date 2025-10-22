Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FEDBCCF9E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBXoN-00014L-Kt; Wed, 22 Oct 2025 08:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXoL-00013p-Dx
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:19:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXoJ-00073q-Go
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761135562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=65Vgceb3D7yf4yWybcxJjxF58FTpfcd+SoMiXXzlJys=;
 b=AWvJPy4UUwzuUa7qubuSMYkF++EU69Av0k6tAyh0jOczERdI/xISH9ZAUqJZpF9pRNeepj
 RnPDxGvwLqI9tfPffNjz0cysIwy4L6pqLTgcTVlaHhbS3AAc3lm8gOFC1124ARQ5HROmQV
 gzN2+S8pwSMBAHK9l9OFRaZCOPvKKUs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-92ZtQlKVNnCaEEwmV9iqYw-1; Wed,
 22 Oct 2025 08:18:54 -0400
X-MC-Unique: 92ZtQlKVNnCaEEwmV9iqYw-1
X-Mimecast-MFC-AGG-ID: 92ZtQlKVNnCaEEwmV9iqYw_1761135533
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63548195420F; Wed, 22 Oct 2025 12:18:53 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.12])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E0318180044F; Wed, 22 Oct 2025 12:18:50 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Steven Sistare <steven.sistare@oracle.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 01/12] vfio/container: Remap only populated parts in a section
Date: Wed, 22 Oct 2025 14:18:35 +0200
Message-ID: <20251022121846.874152-2-clg@redhat.com>
In-Reply-To: <20251022121846.874152-1-clg@redhat.com>
References: <20251022121846.874152-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

If there are multiple containers and unmap-all fails for some of them, we
need to remap vaddr for the other containers for which unmap-all succeeded.
When ram discard is enabled, we should only remap populated parts in a
section instead of the whole section.

Fixes: eba1f657cbb1 ("vfio/container: recover from unmap-all-vaddr failure")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250928085432.40107-2-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-cpr.h |  2 +-
 hw/vfio/cpr-legacy.c       | 20 +++++++++++++++-----
 hw/vfio/listener.c         |  4 ++--
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 81f4e24e229ef35f5b14582ce6e58415e0ebf3df..4606da500a7969b6519b054280464608ae624bb9 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -68,7 +68,7 @@ bool vfio_cpr_container_match(struct VFIOLegacyContainer *container,
 void vfio_cpr_giommu_remap(struct VFIOContainer *bcontainer,
                            MemoryRegionSection *section);
 
-bool vfio_cpr_ram_discard_register_listener(
+bool vfio_cpr_ram_discard_replay_populated(
     struct VFIOContainer *bcontainer, MemoryRegionSection *section);
 
 void vfio_cpr_save_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 80af7469d06b2f15a705a97c4b5ddd25a8044115..b4581e8f859323c1c45560f7d345b34f1ed9bd85 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -228,22 +228,32 @@ void vfio_cpr_giommu_remap(VFIOContainer *bcontainer,
     memory_region_iommu_replay(giommu->iommu_mr, &giommu->n);
 }
 
+static int vfio_cpr_rdm_remap(MemoryRegionSection *section, void *opaque)
+{
+    RamDiscardListener *rdl = opaque;
+
+    return rdl->notify_populate(rdl, section);
+}
+
 /*
  * In old QEMU, VFIO_DMA_UNMAP_FLAG_VADDR may fail on some mapping after
  * succeeding for others, so the latter have lost their vaddr.  Call this
- * to restore vaddr for a section with a RamDiscardManager.
+ * to restore vaddr for populated parts in a section with a RamDiscardManager.
  *
- * The ram discard listener already exists.  Call its populate function
+ * The ram discard listener already exists.  Call its replay_populated function
  * directly, which calls vfio_legacy_cpr_dma_map.
  */
-bool vfio_cpr_ram_discard_register_listener(VFIOContainer *bcontainer,
-                                            MemoryRegionSection *section)
+bool vfio_cpr_ram_discard_replay_populated(VFIOContainer *bcontainer,
+                                           MemoryRegionSection *section)
 {
+    RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
     VFIORamDiscardListener *vrdl =
         vfio_find_ram_discard_listener(bcontainer, section);
 
     g_assert(vrdl);
-    return vrdl->listener.notify_populate(&vrdl->listener, section) == 0;
+    return ram_discard_manager_replay_populated(rdm, section,
+                                                vfio_cpr_rdm_remap,
+                                                &vrdl->listener) == 0;
 }
 
 int vfio_cpr_group_get_device_fd(int d, const char *name)
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index c6bb58f5209a4c8eb67deac41a89c317fa391447..1b6e5065a3267ab08d2d3fea3c5b4965a80947e8 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -577,8 +577,8 @@ void vfio_container_region_add(VFIOContainer *bcontainer,
             if (!vfio_ram_discard_register_listener(bcontainer, section, &err)) {
                 goto fail;
             }
-        } else if (!vfio_cpr_ram_discard_register_listener(bcontainer,
-                                                           section)) {
+        } else if (!vfio_cpr_ram_discard_replay_populated(bcontainer,
+                                                          section)) {
             error_setg(&err,
                        "vfio_cpr_ram_discard_register_listener for %s failed",
                        memory_region_name(section->mr));
-- 
2.51.0


