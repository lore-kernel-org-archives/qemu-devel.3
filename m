Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186A1C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 13:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDNY1-0001l4-Rs; Fri, 09 May 2025 09:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNXt-0001iP-F9
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:13:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNXr-0006yG-CS
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746796422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Koh2quX8r91kNjOJ+udna9B9DGaxcdmdXWt9BIe/6f8=;
 b=Sg+JcwlaviDzF9/rMnhH8Vi6JWQd1Pg9CqifhNNmXk7emHMzsSm40gw1mozZxwIVKPvRwO
 gf+PeFSYMXOCTiXiiemstD+XAYABunsvZMjadY4Ld9ij7WvPV7UYZSsWGMT3CP5ym2ZSJz
 VPph8DXdr8tlAoKyzBdJcbaL/Tuy2Fo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-1GnwZ9-JNkuIXuIk_Ws0Xg-1; Fri,
 09 May 2025 09:13:39 -0400
X-MC-Unique: 1GnwZ9-JNkuIXuIk_Ws0Xg-1
X-Mimecast-MFC-AGG-ID: 1GnwZ9-JNkuIXuIk_Ws0Xg_1746796418
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86CB31956080; Fri,  9 May 2025 13:13:38 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 841A9180045B; Fri,  9 May 2025 13:13:35 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 05/28] vfio/igd: Always emulate ASLS (OpRegion) register
Date: Fri,  9 May 2025 15:12:54 +0200
Message-ID: <20250509131317.164235-6-clg@redhat.com>
In-Reply-To: <20250509131317.164235-1-clg@redhat.com>
References: <20250509131317.164235-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
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

From: Tomita Moeko <tomitamoeko@gmail.com>

ASLS register represents the base address of OpRegion, and it is
programmed with HPA. In IGD passthrough scenario, it needs to be
reprogrammed with GPA by guest firmware. To prevent guest accessing
wrong memory range, ASLS should always be emulated and cleared.

In GVT-g scenario, emulating ASLS is unnecessary as access is handled
by kvmgt backend [1].

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/i915/gvt/cfg_space.c?h=v6.14#n295

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250505170305.23622-3-tomitamoeko@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/igd.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index e06484c9112f104b87c18bb7b2d0a2cd2de1992e..b1fce76f7250c2b2185cc259ac673d0d595832e8 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -182,10 +182,6 @@ static bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
 
     trace_vfio_pci_igd_opregion_enabled(vdev->vbasedev.name);
 
-    pci_set_long(vdev->pdev.config + IGD_ASLS, 0);
-    pci_set_long(vdev->pdev.wmask + IGD_ASLS, ~0);
-    pci_set_long(vdev->emulated_config_bits + IGD_ASLS, ~0);
-
     return true;
 }
 
@@ -584,7 +580,15 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
     if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_LPC) &&
         !vfio_pci_igd_setup_lpc_bridge(vdev, errp)) {
         goto error;
-     }
+    }
+
+    /*
+     * ASLS (OpRegion address) is read-only, emulated
+     * It contains HPA, guest firmware need to reprogram it with GPA.
+     */
+    pci_set_long(vdev->pdev.config + IGD_ASLS, 0);
+    pci_set_long(vdev->pdev.wmask + IGD_ASLS, ~0);
+    pci_set_long(vdev->emulated_config_bits + IGD_ASLS, ~0);
 
     /*
      * Allow user to override dsm size using x-igd-gms option, in multiples of
-- 
2.49.0


