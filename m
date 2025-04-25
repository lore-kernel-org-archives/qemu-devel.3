Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FE5C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:52:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Ek2-0006AF-A0; Fri, 25 Apr 2025 04:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Ejz-0005wl-Fz
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:48:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Ejx-0003KR-Jd
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=59l+mO+aqKmxGigOlfk5JEvgGu6pumdocPPdkevSbLE=;
 b=OL4zFaoKEgvYgo5sQ4T4rupc6hKOadOYORkWkD0y6OwJ8N4Oall1FVprvfxNAKyenYCzYI
 9dsUY860pICpzHGCzPCigGpRCoFsYNe6fQmD4Ic/Yu/yUVmjjMitWdy7gzSthy2OrH86w/
 RE8GxNo/h0AO//OVpSkVB+OMo12TvLs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-e5VVw6HoMQWYYGK0zCjEfg-1; Fri,
 25 Apr 2025 04:48:52 -0400
X-MC-Unique: e5VVw6HoMQWYYGK0zCjEfg-1
X-Mimecast-MFC-AGG-ID: e5VVw6HoMQWYYGK0zCjEfg_1745570931
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B12AD180098B; Fri, 25 Apr 2025 08:48:51 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B6E0530001AB; Fri, 25 Apr 2025 08:48:49 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
Subject: [PULL 37/50] vfio: Rename RAM discard related services
Date: Fri, 25 Apr 2025 10:46:30 +0200
Message-ID: <20250425084644.102196-38-clg@redhat.com>
In-Reply-To: <20250425084644.102196-1-clg@redhat.com>
References: <20250425084644.102196-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
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

Rename some routines to better reflect the namespace they belong to.

Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-34-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/listener.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index bde1bb3c1344818a3958f619a8c2a3dd755c5a84..70bdeb3ce743088306f0941d63e51bddb242a697 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -242,7 +242,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
     return 0;
 }
 
-static void vfio_register_ram_discard_listener(VFIOContainerBase *bcontainer,
+static void vfio_ram_discard_register_listener(VFIOContainerBase *bcontainer,
                                                MemoryRegionSection *section)
 {
     RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
@@ -317,7 +317,7 @@ static void vfio_register_ram_discard_listener(VFIOContainerBase *bcontainer,
     }
 }
 
-static void vfio_unregister_ram_discard_listener(VFIOContainerBase *bcontainer,
+static void vfio_ram_discard_unregister_listener(VFIOContainerBase *bcontainer,
                                                  MemoryRegionSection *section)
 {
     RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
@@ -504,7 +504,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
      * about changes.
      */
     if (memory_region_has_ram_discard_manager(section->mr)) {
-        vfio_register_ram_discard_listener(bcontainer, section);
+        vfio_ram_discard_register_listener(bcontainer, section);
         return;
     }
 
@@ -627,7 +627,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
         pgmask = (1ULL << ctz64(bcontainer->pgsizes)) - 1;
         try_unmap = !((iova & pgmask) || (int128_get64(llsize) & pgmask));
     } else if (memory_region_has_ram_discard_manager(section->mr)) {
-        vfio_unregister_ram_discard_listener(bcontainer, section);
+        vfio_ram_discard_unregister_listener(bcontainer, section);
         /* Unregistering will trigger an unmap. */
         try_unmap = false;
     }
@@ -1024,7 +1024,7 @@ out:
     }
 }
 
-static int vfio_ram_discard_get_dirty_bitmap(MemoryRegionSection *section,
+static int vfio_ram_discard_query_dirty_bitmap(MemoryRegionSection *section,
                                              void *opaque)
 {
     const hwaddr size = int128_get64(section->size);
@@ -1071,7 +1071,7 @@ vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainerBase *bcontainer,
      * which correspond to populated parts. Replay all populated parts.
      */
     return ram_discard_manager_replay_populated(rdm, section,
-                                              vfio_ram_discard_get_dirty_bitmap,
+                                                vfio_ram_discard_query_dirty_bitmap,
                                                 &vrdl);
 }
 
-- 
2.49.0


