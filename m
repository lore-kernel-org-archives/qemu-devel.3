Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A963C282EC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqC3l-00035x-Uu; Thu, 06 Mar 2025 09:18:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC1S-0000lW-Ie
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:16:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC1Q-00025L-It
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:16:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741270583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rUvV7qq9uzaYU21iu4zHJBfeyJeO0F4FuZGYn1fB/w8=;
 b=CHjsT1AHfx7QD8oOKjiSdr/pYp7YCYQC+MlX82eW8F6s/YjWHgTIjRzhNXXheHpWsCFQ+j
 Qpn/Hf9ij2ji38ZgP5jvq3ATTMnhRbjWbo1Vzh+AL5B7Qyq+kJXdzNlSo/dOsSewwuM9fH
 SlF7lR4UQk5tv2tT9XVboE/4Bw7Ee1w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-jnK-QQmxP_GVoFLVmlVLbw-1; Thu,
 06 Mar 2025 09:16:22 -0500
X-MC-Unique: jnK-QQmxP_GVoFLVmlVLbw-1
X-Mimecast-MFC-AGG-ID: jnK-QQmxP_GVoFLVmlVLbw_1741270581
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38B751808869; Thu,  6 Mar 2025 14:16:21 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8BE051801748; Thu,  6 Mar 2025 14:16:19 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 40/42] vfio/migration: Add x-migration-multifd-transfer VFIO
 property
Date: Thu,  6 Mar 2025 15:14:16 +0100
Message-ID: <20250306141419.2015340-41-clg@redhat.com>
In-Reply-To: <20250306141419.2015340-1-clg@redhat.com>
References: <20250306141419.2015340-1-clg@redhat.com>
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

This property allows configuring whether to transfer the particular device
state via multifd channels when live migrating that device.

It defaults to AUTO, which means that VFIO device state transfer via
multifd channels is attempted in configurations that otherwise support it.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/d6dbb326e3d53c7104d62c96c9e3dd64e1c7b940.1741124640.git.maciej.szmigiero@oracle.com
[ clg: Added documentation ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/devel/migration/vfio.rst | 15 +++++++++++++++
 include/hw/vfio/vfio-common.h |  2 ++
 hw/vfio/migration-multifd.c   | 18 +++++++++++++++++-
 hw/vfio/pci.c                 |  7 +++++++
 4 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
index a803a09bc15619cfc46384908d50860ca135d26e..673e354754c8ad2f6ed5364516ef72c75d084610 100644
--- a/docs/devel/migration/vfio.rst
+++ b/docs/devel/migration/vfio.rst
@@ -232,3 +232,18 @@ Postcopy
 ========
 
 Postcopy migration is currently not supported for VFIO devices.
+
+Multifd
+=======
+
+Starting from QEMU version 10.0 there's a possibility to transfer VFIO device
+_STOP_COPY state via multifd channels. This helps reduce downtime - especially
+with multiple VFIO devices or with devices having a large migration state.
+As an additional benefit, setting the VFIO device to _STOP_COPY state and
+saving its config space is also parallelized (run in a separate thread) in
+such migration mode.
+
+The multifd VFIO device state transfer is controlled by
+"x-migration-multifd-transfer" VFIO device property. This property defaults to
+AUTO, which means that VFIO device state transfer via multifd channels is
+attempted in configurations that otherwise support it.
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 961931d9f457e170f26afabc484a1e7c39675533..04b123a6c929a8f47d740fc5433b54dadd32f731 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -91,6 +91,7 @@ typedef struct VFIOMigration {
     uint64_t mig_flags;
     uint64_t precopy_init_size;
     uint64_t precopy_dirty_size;
+    bool multifd_transfer;
     VFIOMultifd *multifd;
     bool initial_data_sent;
 
@@ -153,6 +154,7 @@ typedef struct VFIODevice {
     bool no_mmap;
     bool ram_block_discard_allowed;
     OnOffAuto enable_migration;
+    OnOffAuto migration_multifd_transfer;
     bool migration_events;
     VFIODeviceOps *ops;
     unsigned int num_irqs;
diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index bfb9a72fa4503e2ea00731a2ba528a54d09ed4c5..aacddc503bb8ba6c40e38c97ce9e2b3ca9430e12 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -476,18 +476,34 @@ bool vfio_multifd_transfer_supported(void)
 
 bool vfio_multifd_transfer_enabled(VFIODevice *vbasedev)
 {
-    return false;
+    VFIOMigration *migration = vbasedev->migration;
+
+    return migration->multifd_transfer;
 }
 
 bool vfio_multifd_setup(VFIODevice *vbasedev, bool alloc_multifd, Error **errp)
 {
     VFIOMigration *migration = vbasedev->migration;
 
+    if (vbasedev->migration_multifd_transfer == ON_OFF_AUTO_AUTO) {
+        migration->multifd_transfer = vfio_multifd_transfer_supported();
+    } else {
+        migration->multifd_transfer =
+            vbasedev->migration_multifd_transfer == ON_OFF_AUTO_ON;
+    }
+
     if (!vfio_multifd_transfer_enabled(vbasedev)) {
         /* Nothing further to check or do */
         return true;
     }
 
+    if (!vfio_multifd_transfer_supported()) {
+        error_setg(errp,
+                   "%s: Multifd device transfer requested but unsupported in the current config",
+                   vbasedev->name);
+        return false;
+    }
+
     if (alloc_multifd) {
         assert(!migration->multifd);
         migration->multifd = vfio_multifd_new();
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c1cee280ae4bbfc5a479aa5d1f2290065667a677..1bbf15cea32657ef2a9ee37b8e1dee392d5dbcb7 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3381,6 +3381,9 @@ static const Property vfio_pci_dev_properties[] = {
                     VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
     DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
                             vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO("x-migration-multifd-transfer", VFIOPCIDevice,
+                            vbasedev.migration_multifd_transfer,
+                            ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
                      vbasedev.migration_events, false),
     DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
@@ -3553,6 +3556,10 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
                                           "Skip config space check for Vendor Specific Capability. "
                                           "Setting to false will enforce strict checking of VSC content "
                                           "(DEBUG)");
+    object_class_property_set_description(klass, /* 10.0 */
+                                          "x-migration-multifd-transfer",
+                                          "Transfer this device state via "
+                                          "multifd channels when live migrating it");
 }
 
 static const TypeInfo vfio_pci_dev_info = {
-- 
2.48.1


