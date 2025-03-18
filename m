Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF68DC35FF8
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 09:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuTga-0007AS-F9; Tue, 18 Mar 2025 05:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTgT-0006hk-NO
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:56:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTgR-0002We-OG
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742291785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KEQhZwlgK6wK/8TIiK7ky3mHyYC6ovFIcut2aASS15A=;
 b=La6PplZF+pFriGItYVPxnAoSnr7ItWBR+pztkLjGzrIJAGgq8/TdINpWJoSAV8cSfyJsJD
 3X8rlB23At+DKGbnjh9QOx/tI1zmyhIZXVXdgry6h8zpWgX79zRsok0YQenkltyylWPEox
 mhl00AI9Qn2dhBcWGZ97sxj3vbtzZy0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-0Oi1f59MOeO_q_6XtI698w-1; Tue,
 18 Mar 2025 05:56:22 -0400
X-MC-Unique: 0Oi1f59MOeO_q_6XtI698w-1
X-Mimecast-MFC-AGG-ID: 0Oi1f59MOeO_q_6XtI698w_1742291781
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49FCF1828AA4; Tue, 18 Mar 2025 09:56:21 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 28C4018001EF; Tue, 18 Mar 2025 09:56:18 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 32/32] vfio: Rename RAM discard related services
Date: Tue, 18 Mar 2025 10:54:15 +0100
Message-ID: <20250318095415.670319-33-clg@redhat.com>
In-Reply-To: <20250318095415.670319-1-clg@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/dirty-tracking.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/dirty-tracking.c b/hw/vfio/dirty-tracking.c
index d7827f7b64adf3e2b41fafd59aab71e0b28c1567..50699a411de3ecd7424a48c7bb583ce39370a296 100644
--- a/hw/vfio/dirty-tracking.c
+++ b/hw/vfio/dirty-tracking.c
@@ -262,7 +262,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
     return 0;
 }
 
-static void vfio_register_ram_discard_listener(VFIOContainerBase *bcontainer,
+static void  vfio_ram_discard_register_listener(VFIOContainerBase *bcontainer,
                                                MemoryRegionSection *section)
 {
     RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
@@ -337,7 +337,7 @@ static void vfio_register_ram_discard_listener(VFIOContainerBase *bcontainer,
     }
 }
 
-static void vfio_unregister_ram_discard_listener(VFIOContainerBase *bcontainer,
+static void  vfio_ram_discard_unregister_listener(VFIOContainerBase *bcontainer,
                                                  MemoryRegionSection *section)
 {
     RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
@@ -524,7 +524,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
      * about changes.
      */
     if (memory_region_has_ram_discard_manager(section->mr)) {
-        vfio_register_ram_discard_listener(bcontainer, section);
+        vfio_ram_discard_register_listener(bcontainer, section);
         return;
     }
 
@@ -647,7 +647,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
         pgmask = (1ULL << ctz64(bcontainer->pgsizes)) - 1;
         try_unmap = !((iova & pgmask) || (int128_get64(llsize) & pgmask));
     } else if (memory_region_has_ram_discard_manager(section->mr)) {
-        vfio_unregister_ram_discard_listener(bcontainer, section);
+        vfio_ram_discard_unregister_listener(bcontainer, section);
         /* Unregistering will trigger an unmap. */
         try_unmap = false;
     }
@@ -1132,7 +1132,7 @@ out:
     }
 }
 
-static int vfio_ram_discard_get_dirty_bitmap(MemoryRegionSection *section,
+static int vfio_ram_discard_query_dirty_bitmap(MemoryRegionSection *section,
                                              void *opaque)
 {
     const hwaddr size = int128_get64(section->size);
@@ -1179,7 +1179,7 @@ vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainerBase *bcontainer,
      * which correspond to populated parts. Replay all populated parts.
      */
     return ram_discard_manager_replay_populated(rdm, section,
-                                              vfio_ram_discard_get_dirty_bitmap,
+                                                vfio_ram_discard_query_dirty_bitmap,
                                                 &vrdl);
 }
 
-- 
2.48.1


