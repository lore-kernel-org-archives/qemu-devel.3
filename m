Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE33DC35FF9
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 09:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuTgQ-0006KU-IY; Tue, 18 Mar 2025 05:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTgM-00067t-CW
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:56:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTgG-0002Tb-1g
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742291775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jnIlQFepylUsw+IYBb0BbibYTMjn3Fr9vOmoUD/CAeY=;
 b=g7b8MH+k6Wt02P0KKl6nOjv33I0PUV+tdEtSbpj8IDUgLQPvoj9JZV5iH+sMNxEji/qgk/
 ekJy+6Nwgbw15Rjw1O3csu+R+fOFGXFYQBViauaHpkZfb0Fyki2DRzapO4vtKnjN55uyn+
 q6WLeQgvJOetNkL50Exct7B77xrNLkk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-uXwkVyx6NLucB6iVKhTWLQ-1; Tue,
 18 Mar 2025 05:56:11 -0400
X-MC-Unique: uXwkVyx6NLucB6iVKhTWLQ-1
X-Mimecast-MFC-AGG-ID: uXwkVyx6NLucB6iVKhTWLQ_1742291770
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54E4B1956076; Tue, 18 Mar 2025 09:56:10 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BF2731828AAB; Tue, 18 Mar 2025 09:56:07 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 28/32] vfio: Make vfio_devices_query_dirty_bitmap()
 static
Date: Tue, 18 Mar 2025 10:54:11 +0100
Message-ID: <20250318095415.670319-29-clg@redhat.com>
In-Reply-To: <20250318095415.670319-1-clg@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

vfio_devices_query_dirty_bitmap() is only used in "dirty-tracking.c".

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/dirty-tracking.h | 3 ---
 hw/vfio/dirty-tracking.c | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/vfio/dirty-tracking.h b/hw/vfio/dirty-tracking.h
index 4b83dc54ab50dabfff040d7cc3db27b80bfe2d3a..322af30b0d5370600719594d4aed4c407f7d2295 100644
--- a/hw/vfio/dirty-tracking.h
+++ b/hw/vfio/dirty-tracking.h
@@ -13,9 +13,6 @@ extern const MemoryListener vfio_memory_listener;
 
 bool vfio_devices_all_dirty_tracking_started(const VFIOContainerBase *bcontainer);
 bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
-int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
-                                    VFIOBitmap *vbmap, hwaddr iova, hwaddr size,
-                                    Error **errp);
 int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
                           uint64_t size, ram_addr_t ram_addr, Error **errp);
 
diff --git a/hw/vfio/dirty-tracking.c b/hw/vfio/dirty-tracking.c
index 143cc5cf62b0165565e91f8a2ca166026f16b1eb..9b20668a6d0df93a2cfde12d9a5cd7c223ae3ca1 100644
--- a/hw/vfio/dirty-tracking.c
+++ b/hw/vfio/dirty-tracking.c
@@ -1016,7 +1016,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
     return 0;
 }
 
-int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
+static int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                  VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
 {
     VFIODevice *vbasedev;
-- 
2.48.1


