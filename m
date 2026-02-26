Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851B0FCE086
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 14:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvbug-0002c4-Gi; Thu, 26 Feb 2026 09:00:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vvbue-0002bn-C4
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 09:00:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vvbuc-0006Hw-Kp
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 09:00:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772114417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fHe9iQ+1P8ZlO5xByO1a0ChmR22YDJBfDZShZX5olz8=;
 b=E1g/8G1HBalt/7T53Udm217Y8Y+oFsNTwnM54KQXDS4Ry8/tOgxt0T5647LEwaNKEEd2SZ
 30skElX+SMLvrws1imr5hJkFk3t1bigFajQ5GDRk74iRgXsYmpP+CyuFJ3A5IYg1DXui5D
 FcCnXK+oI4w90VjmU0CCn2jUiDRhWyM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-hcP5uesGOUi3WMeofA4mnQ-1; Thu,
 26 Feb 2026 09:00:14 -0500
X-MC-Unique: hcP5uesGOUi3WMeofA4mnQ-1
X-Mimecast-MFC-AGG-ID: hcP5uesGOUi3WMeofA4mnQ_1772114413
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A71818005BC; Thu, 26 Feb 2026 14:00:13 +0000 (UTC)
Received: from localhost (unknown [10.45.242.29])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9820D19560B5; Thu, 26 Feb 2026 14:00:10 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Ben Chaney <bchaney@akamai.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex@shazbot.org>,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Mark Kanda <mark.kanda@oracle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 02/15] memory: drop
 RamDiscardListener::double_discard_supported
Date: Thu, 26 Feb 2026 14:59:47 +0100
Message-ID: <20260226140001.3622334-3-marcandre.lureau@redhat.com>
In-Reply-To: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

This was never turned off, effectively some dead code.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/system/memory.h       | 12 +-----------
 hw/vfio/listener.c            |  2 +-
 hw/virtio/virtio-mem.c        | 22 ++--------------------
 system/ram-block-attributes.c | 23 +----------------------
 4 files changed, 5 insertions(+), 54 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 0562af31361..be36fd93dc0 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -580,26 +580,16 @@ struct RamDiscardListener {
      */
     NotifyRamDiscard notify_discard;
 
-    /*
-     * @double_discard_supported:
-     *
-     * The listener suppors getting @notify_discard notifications that span
-     * already discarded parts.
-     */
-    bool double_discard_supported;
-
     MemoryRegionSection *section;
     QLIST_ENTRY(RamDiscardListener) next;
 };
 
 static inline void ram_discard_listener_init(RamDiscardListener *rdl,
                                              NotifyRamPopulate populate_fn,
-                                             NotifyRamDiscard discard_fn,
-                                             bool double_discard_supported)
+                                             NotifyRamDiscard discard_fn)
 {
     rdl->notify_populate = populate_fn;
     rdl->notify_discard = discard_fn;
-    rdl->double_discard_supported = double_discard_supported;
 }
 
 /**
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 1087fdc142e..960da9e0a93 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -283,7 +283,7 @@ static bool vfio_ram_discard_register_listener(VFIOContainer *bcontainer,
 
     ram_discard_listener_init(&vrdl->listener,
                               vfio_ram_discard_notify_populate,
-                              vfio_ram_discard_notify_discard, true);
+                              vfio_ram_discard_notify_discard);
     ram_discard_manager_register_listener(rdm, &vrdl->listener, section);
     QLIST_INSERT_HEAD(&bcontainer->vrdl_list, vrdl, next);
 
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index c1e2defb68e..251d1d50aaa 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -331,14 +331,6 @@ static int virtio_mem_notify_populate_cb(MemoryRegionSection *s, void *arg)
     return rdl->notify_populate(rdl, s);
 }
 
-static int virtio_mem_notify_discard_cb(MemoryRegionSection *s, void *arg)
-{
-    RamDiscardListener *rdl = arg;
-
-    rdl->notify_discard(rdl, s);
-    return 0;
-}
-
 static void virtio_mem_notify_unplug(VirtIOMEM *vmem, uint64_t offset,
                                      uint64_t size)
 {
@@ -398,12 +390,7 @@ static void virtio_mem_notify_unplug_all(VirtIOMEM *vmem)
     }
 
     QLIST_FOREACH(rdl, &vmem->rdl_list, next) {
-        if (rdl->double_discard_supported) {
-            rdl->notify_discard(rdl, rdl->section);
-        } else {
-            virtio_mem_for_each_plugged_section(vmem, rdl->section, rdl,
-                                                virtio_mem_notify_discard_cb);
-        }
+        rdl->notify_discard(rdl, rdl->section);
     }
 }
 
@@ -1824,12 +1811,7 @@ static void virtio_mem_rdm_unregister_listener(RamDiscardManager *rdm,
 
     g_assert(rdl->section->mr == &vmem->memdev->mr);
     if (vmem->size) {
-        if (rdl->double_discard_supported) {
-            rdl->notify_discard(rdl, rdl->section);
-        } else {
-            virtio_mem_for_each_plugged_section(vmem, rdl->section, rdl,
-                                                virtio_mem_notify_discard_cb);
-        }
+        rdl->notify_discard(rdl, rdl->section);
     }
 
     memory_region_section_free_copy(rdl->section);
diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
index 9f72a6b3545..630b0fda126 100644
--- a/system/ram-block-attributes.c
+++ b/system/ram-block-attributes.c
@@ -61,16 +61,6 @@ ram_block_attributes_notify_populate_cb(MemoryRegionSection *section,
     return rdl->notify_populate(rdl, section);
 }
 
-static int
-ram_block_attributes_notify_discard_cb(MemoryRegionSection *section,
-                                       void *arg)
-{
-    RamDiscardListener *rdl = arg;
-
-    rdl->notify_discard(rdl, section);
-    return 0;
-}
-
 static int
 ram_block_attributes_for_each_populated_section(const RamBlockAttributes *attr,
                                                 MemoryRegionSection *section,
@@ -191,22 +181,11 @@ ram_block_attributes_rdm_unregister_listener(RamDiscardManager *rdm,
                                              RamDiscardListener *rdl)
 {
     RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rdm);
-    int ret;
 
     g_assert(rdl->section);
     g_assert(rdl->section->mr == attr->ram_block->mr);
 
-    if (rdl->double_discard_supported) {
-        rdl->notify_discard(rdl, rdl->section);
-    } else {
-        ret = ram_block_attributes_for_each_populated_section(attr,
-                rdl->section, rdl, ram_block_attributes_notify_discard_cb);
-        if (ret) {
-            error_report("%s: Failed to unregister RAM discard listener: %s",
-                         __func__, strerror(-ret));
-            exit(1);
-        }
-    }
+    rdl->notify_discard(rdl, rdl->section);
 
     memory_region_section_free_copy(rdl->section);
     rdl->section = NULL;
-- 
2.53.0


