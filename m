Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DD1E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 15:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ6dk-0006zn-A6; Tue, 24 Dec 2024 10:16:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6di-0006z4-HA
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:16:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6dg-00043V-4H
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:16:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735053362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NH9uZhIjlURe8VeHUQLXHe8rQLtwh7MiU89E8MVV07Y=;
 b=J7HY5/jO6PeJRymiVe/pt/j5S1akcPMX0c+GhfTUlC3VdMJocKPPm0FI0Jpa20YX/Jlxgl
 xr4at5OPS21kvdebteN11cD4nYXVzseGU6BTsL/bacjw0BAs/Fn3QxlStp63uq2xaHXmKL
 z0P2YXKOpksox6dashKFYZb8lNTB8nE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-nJDjmzCZNTypyOJlHFbBDQ-1; Tue,
 24 Dec 2024 10:16:00 -0500
X-MC-Unique: nJDjmzCZNTypyOJlHFbBDQ-1
X-Mimecast-MFC-AGG-ID: nJDjmzCZNTypyOJlHFbBDQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D165E1956087; Tue, 24 Dec 2024 15:15:59 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7D3233000197; Tue, 24 Dec 2024 15:15:58 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 04/17] vfio/igd: canonicalize memory size calculations
Date: Tue, 24 Dec 2024 16:15:34 +0100
Message-ID: <20241224151547.386529-5-clg@redhat.com>
In-Reply-To: <20241224151547.386529-1-clg@redhat.com>
References: <20241224151547.386529-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add helper functions igd_gtt_memory_size() and igd_stolen_size() for
calculating GTT stolen memory and Data stolen memory size in bytes,
and use macros to replace the hardware-related magic numbers for
better readability.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/r/20241206122749.9893-5-tomitamoeko@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/igd.c | 101 ++++++++++++++++++++++++++++----------------------
 1 file changed, 57 insertions(+), 44 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 09bd4e53837482540591546b3efcff818d576a12..e231865d72251b1fd1f39b6ac8da26f10a7ac7a1 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -107,6 +107,53 @@ typedef struct VFIOIGDQuirk {
 #define IGD_BDSM 0x5c /* Base Data of Stolen Memory */
 #define IGD_BDSM_GEN11 0xc0 /* Base Data of Stolen Memory of gen 11 and later */
 
+#define IGD_GMCH_GEN6_GMS_SHIFT     3       /* SNB_GMCH in i915 */
+#define IGD_GMCH_GEN6_GMS_MASK      0x1f
+#define IGD_GMCH_GEN6_GGMS_SHIFT    8
+#define IGD_GMCH_GEN6_GGMS_MASK     0x3
+#define IGD_GMCH_GEN8_GMS_SHIFT     8       /* BDW_GMCH in i915 */
+#define IGD_GMCH_GEN8_GMS_MASK      0xff
+#define IGD_GMCH_GEN8_GGMS_SHIFT    6
+#define IGD_GMCH_GEN8_GGMS_MASK     0x3
+
+static uint64_t igd_gtt_memory_size(int gen, uint16_t gmch)
+{
+    uint64_t ggms;
+
+    if (gen < 8) {
+        ggms = (gmch >> IGD_GMCH_GEN6_GGMS_SHIFT) & IGD_GMCH_GEN6_GGMS_MASK;
+    } else {
+        ggms = (gmch >> IGD_GMCH_GEN8_GGMS_SHIFT) & IGD_GMCH_GEN8_GGMS_MASK;
+        if (ggms != 0) {
+            ggms = 1 << ggms;
+        }
+    }
+
+    return ggms * MiB;
+}
+
+static uint64_t igd_stolen_memory_size(int gen, uint32_t gmch)
+{
+    uint64_t gms;
+
+    if (gen < 8) {
+        gms = (gmch >> IGD_GMCH_GEN6_GMS_SHIFT) & IGD_GMCH_GEN6_GMS_MASK;
+    } else {
+        gms = (gmch >> IGD_GMCH_GEN8_GMS_SHIFT) & IGD_GMCH_GEN8_GMS_MASK;
+    }
+
+    if (gen < 9) {
+            return gms * 32 * MiB;
+    } else {
+        if (gms < 0xf0) {
+            return gms * 32 * MiB;
+        } else {
+            return (gms - 0xf0 + 1) * 4 * MiB;
+        }
+    }
+
+    return 0;
+}
 
 /*
  * The rather short list of registers that we copy from the host devices.
@@ -255,17 +302,10 @@ static int vfio_pci_igd_lpc_init(VFIOPCIDevice *vdev,
 static int vfio_igd_gtt_max(VFIOPCIDevice *vdev)
 {
     uint32_t gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
-    int ggms, gen = igd_gen(vdev);
-
-    gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
-    ggms = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
-    if (gen >= 8 && ggms != 0) {
-        ggms = 1 << ggms;
-    }
-
-    ggms *= MiB;
+    int gen = igd_gen(vdev);
+    uint64_t ggms_size = igd_gtt_memory_size(gen, gmch);
 
-    return (ggms / (4 * KiB)) * (gen < 8 ? 4 : 8);
+    return (ggms_size / (4 * KiB)) * (gen < 8 ? 4 : 8);
 }
 
 /*
@@ -472,30 +512,6 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
 }
 
-static int igd_get_stolen_mb(int gen, uint32_t gmch)
-{
-    int gms;
-
-    if (gen < 8) {
-        gms = (gmch >> 3) & 0x1f;
-    } else {
-        gms = (gmch >> 8) & 0xff;
-    }
-
-    if (gen < 9) {
-        if (gms > 0x10) {
-            error_report("Unsupported IGD GMS value 0x%x", gms);
-            return 0;
-        }
-        return gms * 32;
-    } else {
-        if (gms < 0xf0)
-            return gms * 32;
-        else
-            return (gms - 0xf0) * 4 + 4;
-    }
-}
-
 void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 {
     g_autofree struct vfio_region_info *rom = NULL;
@@ -505,7 +521,8 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     VFIOQuirk *quirk;
     VFIOIGDQuirk *igd;
     PCIDevice *lpc_bridge;
-    int i, ret, ggms_mb, gms_mb = 0, gen;
+    int i, ret, gen;
+    uint64_t ggms_size, gms_size;
     uint64_t *bdsm_size;
     uint32_t gmch;
     uint16_t cmd_orig, cmd;
@@ -667,13 +684,8 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
 
-    /* Determine the size of stolen memory needed for GTT */
-    ggms_mb = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
-    if (gen >= 8 && ggms_mb != 0) {
-        ggms_mb = 1 << ggms_mb;
-    }
-
-    gms_mb = igd_get_stolen_mb(gen, gmch);
+    ggms_size = igd_gtt_memory_size(gen, gmch);
+    gms_size = igd_stolen_memory_size(gen, gmch);
 
     /*
      * Request reserved memory for stolen memory via fw_cfg.  VM firmware
@@ -684,7 +696,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
      * config offset 0x5C.
      */
     bdsm_size = g_malloc(sizeof(*bdsm_size));
-    *bdsm_size = cpu_to_le64((ggms_mb + gms_mb) * MiB);
+    *bdsm_size = cpu_to_le64(ggms_size + gms_size);
     fw_cfg_add_file(fw_cfg_find(), "etc/igd-bdsm-size",
                     bdsm_size, sizeof(*bdsm_size));
 
@@ -735,5 +747,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
                      vdev->vbasedev.name);
     }
 
-    trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, ggms_mb + gms_mb);
+    trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name,
+                                    (ggms_size + gms_size) / MiB);
 }
-- 
2.47.1


