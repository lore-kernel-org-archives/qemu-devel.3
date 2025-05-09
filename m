Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51566C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 13:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDNY2-0001lL-LG; Fri, 09 May 2025 09:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNXy-0001k4-NI
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:13:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNXw-00070I-Tv
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746796426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qjmL/N/97mMGevtU7uF4An+9crQQMESgHemcuPP65zc=;
 b=S94FL/6ClvZix3llYmFaSI4eNUUpqVBpgExaVEPMk+t1LOFdtv2JVEVekGShXl4pP4jlIX
 H0PMOr1N7m/KM1ePALukZG1vrq5ewfKP6gnMhjub035sre9qrElpTAZNBvwniY3JOoPYPm
 K0VTE+LQQxLXkXeizQorwlhH99VvMvk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-QYW0BDM5OlOvyyg36zbxGg-1; Fri,
 09 May 2025 09:13:45 -0400
X-MC-Unique: QYW0BDM5OlOvyyg36zbxGg-1
X-Mimecast-MFC-AGG-ID: QYW0BDM5OlOvyyg36zbxGg_1746796424
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9529D1955DDA; Fri,  9 May 2025 13:13:44 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 259BC18003FD; Fri,  9 May 2025 13:13:41 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/28] vfio/igd: Check vendor and device ID on GVT-g mdev
Date: Fri,  9 May 2025 15:12:56 +0200
Message-ID: <20250509131317.164235-8-clg@redhat.com>
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

Check the vendor and device ID on GVT-g mdev to ensure it is a supported
device [1]. This extra check is required for automatically enabling
OpRegion access later.

Note that Cherryview and Gemini Lake are marked as supported here since
current code cannot distinguish them with other Gen8 and Gen9 devices.
Since mdev cannot be created on these devices, this has no functional
impact.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/i915/intel_gvt.c?h=v6.14#n52

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250505170305.23622-5-tomitamoeko@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/igd.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 347253d08ce594d46cafb674ebbd9ca8878200e0..f5dd4750282920a71c52ca59f9ca42899d895c1e 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -672,6 +672,18 @@ error:
 static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 {
     g_autofree struct vfio_region_info *opregion = NULL;
+    int gen;
+
+    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
+        !vfio_is_vga(vdev)) {
+        return true;
+    }
+
+    /* FIXME: Cherryview is Gen8, but don't support GVT-g */
+    gen = igd_gen(vdev);
+    if (gen != 8 && gen != 9) {
+        return true;
+    }
 
     if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) &&
         (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp) ||
-- 
2.49.0


