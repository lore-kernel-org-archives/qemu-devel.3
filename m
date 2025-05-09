Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3015BC3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 13:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDNYE-0001nK-Pp; Fri, 09 May 2025 09:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNYD-0001nC-UV
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNYA-00072Y-V1
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746796441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EgX52XnmIkBlF15up3p+eVDztujVWFimpqqDzgYI5l0=;
 b=ek0Q6M6iyDFnjiFV0Zj+/t8u7hdDpiQNa37bAC3rMZYFkTSq8fBLYaNNwh44tgqsJbdpY5
 GFRnCJNev7f8uLO2Hxqjqq9Z1xCKoOCzGV6LnjaTcXVaW23OavvCAdToVuMbqTyapAQOtY
 zzEEmkqI/HvBsfMGBY96Gv11bsiUoxk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-Uq-xfJtNMeew1sCqcrPhNA-1; Fri,
 09 May 2025 09:13:57 -0400
X-MC-Unique: Uq-xfJtNMeew1sCqcrPhNA-1
X-Mimecast-MFC-AGG-ID: Uq-xfJtNMeew1sCqcrPhNA_1746796435
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80576195605B; Fri,  9 May 2025 13:13:55 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9AA5318003FD; Fri,  9 May 2025 13:13:52 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 10/28] vfio/igd: Allow overriding GMS with 0xf0 to 0xfe on Gen9+
Date: Fri,  9 May 2025 15:12:59 +0200
Message-ID: <20250509131317.164235-11-clg@redhat.com>
In-Reply-To: <20250509131317.164235-1-clg@redhat.com>
References: <20250509131317.164235-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On Gen9 and later IGD devices, GMS 0xf0 to 0xfe represents 4MB to 60MB
pre-allocated memory size in 4MB increments. Allow users overriding
GMS with these values.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250505170305.23622-8-tomitamoeko@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/igd.c | 59 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 18 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 9dec32818c91f2021f6dc0c4bbe1fc0682df1a55..8ad9d723e29cd4d63e12346b6e40604ac020e747 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -412,6 +412,44 @@ static bool vfio_pci_igd_setup_lpc_bridge(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
+static bool vfio_pci_igd_override_gms(int gen, uint32_t gms, uint32_t *gmch)
+{
+    bool ret = false;
+
+    if (gen == -1) {
+        error_report("x-igd-gms is not supported on this device");
+    } else if (gen < 8) {
+        if (gms <= 0x10) {
+            *gmch &= ~(IGD_GMCH_GEN6_GMS_MASK << IGD_GMCH_GEN6_GMS_SHIFT);
+            *gmch |= gms << IGD_GMCH_GEN6_GMS_SHIFT;
+            ret = true;
+        } else {
+            error_report(QERR_INVALID_PARAMETER_VALUE, "x-igd-gms", "0~0x10");
+        }
+    } else if (gen == 8) {
+        if (gms <= 0x40) {
+            *gmch &= ~(IGD_GMCH_GEN8_GMS_MASK << IGD_GMCH_GEN8_GMS_SHIFT);
+            *gmch |= gms << IGD_GMCH_GEN8_GMS_SHIFT;
+            ret = true;
+        } else {
+            error_report(QERR_INVALID_PARAMETER_VALUE, "x-igd-gms", "0~0x40");
+        }
+    } else {
+        /* 0x0  to 0x40: 32MB increments starting at 0MB */
+        /* 0xf0 to 0xfe: 4MB increments starting at 4MB */
+        if ((gms <= 0x40) || (gms >= 0xf0 && gms <= 0xfe)) {
+            *gmch &= ~(IGD_GMCH_GEN8_GMS_MASK << IGD_GMCH_GEN8_GMS_SHIFT);
+            *gmch |= gms << IGD_GMCH_GEN8_GMS_SHIFT;
+            ret = true;
+        } else {
+            error_report(QERR_INVALID_PARAMETER_VALUE,
+                         "x-igd-gms", "0~0x40 or 0xf0~0xfe");
+        }
+    }
+
+    return ret;
+}
+
 #define IGD_GGC_MMIO_OFFSET     0x108040
 #define IGD_BDSM_MMIO_OFFSET    0x1080C0
 
@@ -594,24 +632,9 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
      * 32MiB. This option should only be used when the desired size cannot be
      * set from DVMT Pre-Allocated option in host BIOS.
      */
-    if (vdev->igd_gms) {
-        if (gen < 8) {
-            if (vdev->igd_gms <= 0x10) {
-                gmch &= ~(IGD_GMCH_GEN6_GMS_MASK << IGD_GMCH_GEN6_GMS_SHIFT);
-                gmch |= vdev->igd_gms << IGD_GMCH_GEN6_GMS_SHIFT;
-            } else {
-                error_report(QERR_INVALID_PARAMETER_VALUE,
-                             "x-igd-gms", "0~0x10");
-            }
-        } else {
-            if (vdev->igd_gms <= 0x40) {
-                gmch &= ~(IGD_GMCH_GEN8_GMS_MASK << IGD_GMCH_GEN8_GMS_SHIFT);
-                gmch |= vdev->igd_gms << IGD_GMCH_GEN8_GMS_SHIFT;
-            } else {
-                error_report(QERR_INVALID_PARAMETER_VALUE,
-                             "x-igd-gms", "0~0x40");
-            }
-        }
+    if (vdev->igd_gms &&
+        !vfio_pci_igd_override_gms(gen, vdev->igd_gms, &gmch)) {
+        return false;
     }
 
     gms_size = igd_stolen_memory_size(gen, gmch);
-- 
2.49.0


