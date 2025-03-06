Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D047C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqC3c-0002oo-Kt; Thu, 06 Mar 2025 09:18:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC1U-0000lz-Ny
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:16:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC1S-00026D-Km
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741270585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BU+dkKqyovOGnsyjcACGTgAqOZVrzySUjaZmfUrJeks=;
 b=VzuaQK21lQxrOQXPkODR7qhYSaGWxgToekdL8LcRai6QcV8PRnBalU0KzURdlB1XH3TWC/
 /MThY8IXzj/bpszYFvjpfJ3LkRdMzwYHdNEAAMfbfue5fpxuLG2b19jtywG+sCAV1tBtbE
 oEwW6LWgyMXaGZ7lDRT2NkTz1sWbuP8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-Fn0hhD5bPHu-w_WB6J5lVw-1; Thu,
 06 Mar 2025 09:16:24 -0500
X-MC-Unique: Fn0hhD5bPHu-w_WB6J5lVw-1
X-Mimecast-MFC-AGG-ID: Fn0hhD5bPHu-w_WB6J5lVw_1741270583
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91866180AF6C; Thu,  6 Mar 2025 14:16:23 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BC68A1801751; Thu,  6 Mar 2025 14:16:21 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 41/42] vfio/migration: Make x-migration-multifd-transfer VFIO
 property mutable
Date: Thu,  6 Mar 2025 15:14:17 +0100
Message-ID: <20250306141419.2015340-42-clg@redhat.com>
In-Reply-To: <20250306141419.2015340-1-clg@redhat.com>
References: <20250306141419.2015340-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

DEFINE_PROP_ON_OFF_AUTO() property isn't runtime-mutable so using it
would mean that the source VM would need to decide upfront at startup
time whether it wants to do a multifd device state transfer at some
point.

Source VM can run for a long time before being migrated so it is
desirable to have a fallback mechanism to the old way of transferring
VFIO device state if it turns to be necessary.

This brings this property to the same mutability level as ordinary
migration parameters, which too can be adjusted at the run time.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/f2f2d66bda477da3e6cb8c0311006cff36e8651d.1741124640.git.maciej.szmigiero@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/migration-multifd.c |  4 ++++
 hw/vfio/pci.c               | 20 +++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index aacddc503bb8ba6c40e38c97ce9e2b3ca9430e12..233724710b377afd40aabe5ef5b846f654f9865d 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -485,6 +485,10 @@ bool vfio_multifd_setup(VFIODevice *vbasedev, bool alloc_multifd, Error **errp)
 {
     VFIOMigration *migration = vbasedev->migration;
 
+    /*
+     * Make a copy of this setting at the start in case it is changed
+     * mid-migration.
+     */
     if (vbasedev->migration_multifd_transfer == ON_OFF_AUTO_AUTO) {
         migration->multifd_transfer = vfio_multifd_transfer_supported();
     } else {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 1bbf15cea32657ef2a9ee37b8e1dee392d5dbcb7..fdbc15885d442ee20343e6b7127d54a70b1688ce 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3357,6 +3357,8 @@ static void vfio_instance_init(Object *obj)
     pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
 }
 
+static PropertyInfo vfio_pci_migration_multifd_transfer_prop;
+
 static const Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
     DEFINE_PROP_UUID_NODEFAULT("vf-token", VFIOPCIDevice, vf_token),
@@ -3381,9 +3383,10 @@ static const Property vfio_pci_dev_properties[] = {
                     VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
     DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
                             vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
-    DEFINE_PROP_ON_OFF_AUTO("x-migration-multifd-transfer", VFIOPCIDevice,
-                            vbasedev.migration_multifd_transfer,
-                            ON_OFF_AUTO_AUTO),
+    DEFINE_PROP("x-migration-multifd-transfer", VFIOPCIDevice,
+                vbasedev.migration_multifd_transfer,
+                vfio_pci_migration_multifd_transfer_prop, OnOffAuto,
+                .set_default = true, .defval.i = ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
                      vbasedev.migration_events, false),
     DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
@@ -3608,6 +3611,17 @@ static const TypeInfo vfio_pci_nohotplug_dev_info = {
 
 static void register_vfio_pci_dev_type(void)
 {
+    /*
+     * Ordinary ON_OFF_AUTO property isn't runtime-mutable, but source VM can
+     * run for a long time before being migrated so it is desirable to have a
+     * fallback mechanism to the old way of transferring VFIO device state if
+     * it turns to be necessary.
+     * The following makes this type of property have the same mutability level
+     * as ordinary migration parameters.
+     */
+    vfio_pci_migration_multifd_transfer_prop = qdev_prop_on_off_auto;
+    vfio_pci_migration_multifd_transfer_prop.realized_set_allowed = true;
+
     type_register_static(&vfio_pci_dev_info);
     type_register_static(&vfio_pci_nohotplug_dev_info);
 }
-- 
2.48.1


