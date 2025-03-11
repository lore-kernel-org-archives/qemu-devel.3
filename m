Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983B2C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 18:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts486-0007mG-6t; Tue, 11 Mar 2025 14:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts47V-00079R-Am
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:14:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts47L-0006iU-Tc
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741716840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Mvk7qi+1MfRSVciOay3HBXxKeJIBtr9pVETo1LgVJ8=;
 b=DrRN1fPrfjJyM1QpElfJMrGF9bazj4LCE6+2ZkROhsIIGQctWupfvrgCJro1VoKJIrDmG/
 LpijYJ0bMrCri7g4181uXAZ6fskEK7AfbYBUQnaAxv1uvsrIEYyb9dIJ0hEWP5JkxkfccW
 XoiH147IVv/KVJYZk7JfYiRU6HSjnXc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-TI-gP8SfMSmlAlX-XV8lww-1; Tue,
 11 Mar 2025 14:13:57 -0400
X-MC-Unique: TI-gP8SfMSmlAlX-XV8lww-1
X-Mimecast-MFC-AGG-ID: TI-gP8SfMSmlAlX-XV8lww_1741716836
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 443FF1800259; Tue, 11 Mar 2025 18:13:56 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6844318001E9; Tue, 11 Mar 2025 18:13:54 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 09/21] vfio/igd: Introduce x-igd-lpc option for LPC bridge ID
 quirk
Date: Tue, 11 Mar 2025 19:13:16 +0100
Message-ID: <20250311181328.1200431-10-clg@redhat.com>
In-Reply-To: <20250311181328.1200431-1-clg@redhat.com>
References: <20250311181328.1200431-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Tomita Moeko <tomitamoeko@gmail.com>

The LPC bridge/Host bridge IDs quirk is also not dependent on legacy
mode. Recent Windows driver no longer depends on these IDs, as well as
Linux i915 driver, while UEFI GOP seems still needs them. Make it an
option to allow users enabling and disabling it as needed.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
Link: https://lore.kernel.org/qemu-devel/20250306180131.32970-10-tomitamoeko@gmail.com
[ clg: - Fixed spelling in vfio_probe_igd_config_quirk() ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h |  3 +++
 hw/vfio/igd.c | 14 ++++++++------
 hw/vfio/pci.c |  2 ++
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 816bdbf844dc17e7cbac9a6f42daf9a448ab9cc0..d94ecaba689c4681687c0a6796ffbcda522ae179 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -154,6 +154,9 @@ struct VFIOPCIDevice {
 #define VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT 2
 #define VFIO_FEATURE_ENABLE_IGD_OPREGION \
                                 (1 << VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT)
+#define VFIO_FEATURE_ENABLE_IGD_LPC_BIT 3
+#define VFIO_FEATURE_ENABLE_IGD_LPC \
+                                (1 << VFIO_FEATURE_ENABLE_IGD_LPC_BIT)
     OnOffAuto display;
     uint32_t display_xres;
     uint32_t display_yres;
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 12e07517b4a09ef87791acc09f6a6120abf17ae5..8a88dbab13ede764d0610a043132a3acfe208134 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -560,13 +560,9 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
             goto error;
         }
 
-        /* Enable OpRegion quirk */
+        /* Enable OpRegion and LPC bridge quirk */
         vdev->features |= VFIO_FEATURE_ENABLE_IGD_OPREGION;
-
-        /* Setup LPC bridge / Host bridge PCI IDs */
-        if (!vfio_pci_igd_setup_lpc_bridge(vdev, &err)) {
-            goto error;
-        }
+        vdev->features |= VFIO_FEATURE_ENABLE_IGD_LPC;
     } else if (vdev->igd_legacy_mode == ON_OFF_AUTO_ON) {
         error_setg(&err,
                    "Machine is not i440fx or assigned BDF is not 00:02.0");
@@ -579,6 +575,12 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
         goto error;
     }
 
+    /* Setup LPC bridge / Host bridge PCI IDs */
+    if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_LPC) &&
+        !vfio_pci_igd_setup_lpc_bridge(vdev, errp)) {
+        goto error;
+     }
+
     /*
      * Allow user to override dsm size using x-igd-gms option, in multiples of
      * 32MiB. This option should only be used when the desired size cannot be
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index e2897bdcd58d092d64689b5921a34c133139b56d..3cb7806f2f219174ffb7d28595e9430b41ee40ae 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3360,6 +3360,8 @@ static const Property vfio_pci_dev_properties[] = {
                     VFIO_FEATURE_ENABLE_REQ_BIT, true),
     DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
                     VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
+    DEFINE_PROP_BIT("x-igd-lpc", VFIOPCIDevice, features,
+                    VFIO_FEATURE_ENABLE_IGD_LPC_BIT, false),
     DEFINE_PROP_ON_OFF_AUTO("x-igd-legacy-mode", VFIOPCIDevice,
                             igd_legacy_mode, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
-- 
2.48.1


