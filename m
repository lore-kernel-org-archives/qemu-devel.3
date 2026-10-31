Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EED606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 07:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fzOSWw/L
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN38C-0001Sr-0b; Sat, 31 Oct 2026 03:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN36V-0000sx-UI
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 03:02:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN36U-0003M7-9Y
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 03:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793430133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R9NtJTdgJOuxNOgX7IWRPzs1VYDjTzOeqz5UU10cxXg=;
 b=fzOSWw/LC0dJl/3FSoRvgoWqSBOpQcOBFVVuFQ0mMVgEc2XM+Ira+iFupEDY0t0I7zLzo+
 Pz3wEy9x1N9jB/ffMqm1w2BqYrznYvJMVKObOwxmpTvPI2lZPONxoitvrsfdL0vAxU95J5
 JXO3EN7ZIX8JLf7/ynTsrOWHf0mSXPQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-j9ROXr53PHaWI0cphVeAWQ-1; Sat,
 31 Oct 2026 03:02:10 -0400
X-MC-Unique: j9ROXr53PHaWI0cphVeAWQ-1
X-Mimecast-MFC-AGG-ID: j9ROXr53PHaWI0cphVeAWQ_1793430129
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9E2019560B5; Sat, 31 Oct 2026 07:02:08 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 037271803A6F; Sat, 31 Oct 2026 07:02:06 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tomita Moeko <tomitamoeko@gmail.com>, Yuan Wang <yuan1.wang@intel.com>,
 Bosheng Xue <bosheng.xue@intel.com>, Junjie Cao <junjie.cao@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 6/6] vfio/igd: Use version mapping for MTL/ARL quirk selection
Date: Sat, 31 Oct 2026 08:01:52 +0100
Message-ID: <20261031070152.197043-7-clg@redhat.com>
In-Reply-To: <20261031070152.197043-1-clg@redhat.com>
References: <20261031070152.197043-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tomita Moeko <tomitamoeko@gmail.com>

Meteor Lake and Arrow Lake use graphics IP version 12.70, but igd_gen()
only returns the major version (generation). Encode the existing device
ID mapping as (version * 100 + release) so that MTL/ARL can be selected
in the BAR0 pcode stolen access quirk instead of a separate device ID
check.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Cc: Yuan Wang <yuan1.wang@intel.com>
Cc: Bosheng Xue <bosheng.xue@intel.com>
Cc: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261029161702.117078-1-tomitamoeko@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/igd.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 4c7d6545924ca49cbe0285f77b422517b1c59159..728b60d3d4a5d3ed095d8bc9ae267c6120b933b2 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -58,8 +58,9 @@
  * not be taken as an indication that all the devices are supported, or even
  * supportable, some of them don't even support VT-d.
  * See linux:include/drm/i915_pciids.h for IDs.
+ * Returns (version * 100 + release).
  */
-static int igd_gen(VFIOPCIDevice *vdev)
+static int igd_graphics_ver(VFIOPCIDevice *vdev)
 {
     /*
      * Device IDs for Broxton/Apollo Lake are 0x0a84, 0x1a84, 0x1a85, 0x5a84
@@ -67,38 +68,39 @@ static int igd_gen(VFIOPCIDevice *vdev)
      * Prefix 0x0a is taken by Haswell, this rule should be matched first.
      */
     if ((vdev->device_id & 0xffe) == 0xa84) {
-        return 9;
+        return 900;
     }
 
     switch (vdev->device_id & 0xff00) {
     case 0x0100:    /* SandyBridge, IvyBridge */
-        return 6;
+        return 600;
     case 0x0400:    /* Haswell */
     case 0x0a00:    /* Haswell */
     case 0x0c00:    /* Haswell */
     case 0x0d00:    /* Haswell */
     case 0x0f00:    /* Valleyview/Bay Trail */
-        return 7;
+        return 700;
     case 0x1600:    /* Broadwell */
     case 0x2200:    /* Cherryview */
-        return 8;
+        return 800;
     case 0x1900:    /* Skylake */
     case 0x3100:    /* Gemini Lake */
     case 0x5900:    /* Kaby Lake */
     case 0x3e00:    /* Coffee Lake */
     case 0x9B00:    /* Comet Lake */
-        return 9;
+        return 900;
     case 0x8A00:    /* Ice Lake */
     case 0x4500:    /* Elkhart Lake */
     case 0x4E00:    /* Jasper Lake */
-        return 11;
+        return 1100;
     case 0x9A00:    /* Tiger Lake */
     case 0x4C00:    /* Rocket Lake */
     case 0x4600:    /* Alder Lake */
     case 0xA700:    /* Raptor Lake */
+        return 1200;
     case 0x7D00:    /* Meteor Lake / Arrow Lake */
     case 0xB600:    /* Arrow Lake */
-        return 12;
+        return 1270;
     }
 
     /*
@@ -109,6 +111,12 @@ static int igd_gen(VFIOPCIDevice *vdev)
     return -1;
 }
 
+static int igd_gen(VFIOPCIDevice *vdev)
+{
+    int ver = igd_graphics_ver(vdev);
+    return ver < 0 ? -1 : ver / 100;
+}
+
 #define IGD_ASLS 0xfc /* ASL Storage Register */
 #define IGD_GMCH 0x50 /* Graphics Control Register */
 #define IGD_BDSM 0x5c /* Base Data of Stolen Memory */
@@ -458,10 +466,6 @@ static bool vfio_pci_igd_override_gms(int gen, uint32_t gms, uint32_t *gmch)
 #define IGD_BDSM_MMIO_OFFSET        0x1080C0
 #define IGD_MTL_PCODE_STOLEN_ACCESS 0x138914
 
-#define IGD_IS_MTL_OR_ARL(vdev) \
-    ((((vdev)->device_id & 0xff00) == 0x7d00) || \
-     (((vdev)->device_id & 0xff00) == 0xb600))
-
 static uint64_t vfio_igd_pcode_stolen_access_read(void *opaque, hwaddr addr,
                                                   unsigned size)
 {
@@ -591,7 +595,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
      * Return 0 for PCODE stolen memory access detection (0x138914) so GOP
      * stays on the standard access path in the VM.
      */
-    if (IGD_IS_MTL_OR_ARL(vdev)) {
+    if (igd_graphics_ver(vdev) == 1270) {
         pcode_stolen_access_quirk = vfio_quirk_alloc(1);
         memory_region_init_io(pcode_stolen_access_quirk->mem, OBJECT(vdev),
                               &vfio_igd_pcode_stolen_access_quirk, vdev,
-- 
2.56.0


