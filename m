Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81B3E7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 15:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ6dl-0006zz-1L; Tue, 24 Dec 2024 10:16:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6dj-0006zR-Ve
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:16:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6dg-00043f-SJ
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:16:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735053364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7nZUe/7rfHB8+kh430NSyhptv7wBQFvHbetB7MPi8QQ=;
 b=fsBo988pJCcmOlq2E9O5CvGRLblHUtNWQlU5qydRuUjh4FXBDI4iBvqa1Itc9svM71VFGC
 MM2ssMsQz919sowgKkc9SeF4k+zy0udRD8evT5v0p8px6V7JCvPA3smFi2tBsG8q+nsNWF
 aLm7sXlJKAhXFWrXG3SklDC5c+WQ16k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-nr2mlYe8MryQOXQcC1ppbw-1; Tue,
 24 Dec 2024 10:15:59 -0500
X-MC-Unique: nr2mlYe8MryQOXQcC1ppbw-1
X-Mimecast-MFC-AGG-ID: nr2mlYe8MryQOXQcC1ppbw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 178C919560B1; Tue, 24 Dec 2024 15:15:58 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7A0983000197; Tue, 24 Dec 2024 15:15:56 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 03/17] vfio/igd: align generation with i915 kernel driver
Date: Tue, 24 Dec 2024 16:15:33 +0100
Message-ID: <20241224151547.386529-4-clg@redhat.com>
In-Reply-To: <20241224151547.386529-1-clg@redhat.com>
References: <20241224151547.386529-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Tomita Moeko <tomitamoeko@gmail.com>

Define the igd device generations according to i915 kernel driver to
avoid confusion, and adjust comment placement to clearly reflect the
relationship between ids and devices.

The condition of how GTT stolen memory size is calculated is changed
accordingly as GGMS is in multiple of 2 starting from gen 8.

Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/r/20241206122749.9893-4-tomitamoeko@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/igd.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 059ed56439f127c92cd9df33c6368a8792f07675..09bd4e53837482540591546b3efcff818d576a12 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -59,33 +59,34 @@
  */
 static int igd_gen(VFIOPCIDevice *vdev)
 {
-    if ((vdev->device_id & 0xfff) == 0xa84) {
-        return 8; /* Broxton */
+    /*
+     * Device IDs for Broxton/Apollo Lake are 0x0a84, 0x1a84, 0x1a85, 0x5a84
+     * and 0x5a85, match bit 11:1 here
+     * Prefix 0x0a is taken by Haswell, this rule should be matched first.
+     */
+    if ((vdev->device_id & 0xffe) == 0xa84) {
+        return 9;
     }
 
     switch (vdev->device_id & 0xff00) {
-    /* SandyBridge, IvyBridge, ValleyView, Haswell */
-    case 0x0100:
-    case 0x0400:
-    case 0x0a00:
-    case 0x0c00:
-    case 0x0d00:
-    case 0x0f00:
+    case 0x0100:    /* SandyBridge, IvyBridge */
         return 6;
-    /* BroadWell, CherryView, SkyLake, KabyLake */
-    case 0x1600:
-    case 0x1900:
-    case 0x2200:
-    case 0x5900:
+    case 0x0400:    /* Haswell */
+    case 0x0a00:    /* Haswell */
+    case 0x0c00:    /* Haswell */
+    case 0x0d00:    /* Haswell */
+    case 0x0f00:    /* Valleyview/Bay Trail */
+        return 7;
+    case 0x1600:    /* Broadwell */
+    case 0x2200:    /* Cherryview */
         return 8;
-    /* CoffeeLake */
-    case 0x3e00:
+    case 0x1900:    /* Skylake */
+    case 0x5900:    /* Kaby Lake */
+    case 0x3e00:    /* Coffee Lake */
         return 9;
-    /* ElkhartLake */
-    case 0x4500:
+    case 0x4500:    /* Elkhart Lake */
         return 11;
-    /* TigerLake */
-    case 0x9A00:
+    case 0x9A00:    /* Tiger Lake */
         return 12;
     }
 
@@ -258,7 +259,7 @@ static int vfio_igd_gtt_max(VFIOPCIDevice *vdev)
 
     gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
     ggms = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
-    if (gen > 6 && ggms != 0) {
+    if (gen >= 8 && ggms != 0) {
         ggms = 1 << ggms;
     }
 
@@ -668,7 +669,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 
     /* Determine the size of stolen memory needed for GTT */
     ggms_mb = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
-    if (gen > 6 && ggms_mb != 0) {
+    if (gen >= 8 && ggms_mb != 0) {
         ggms_mb = 1 << ggms_mb;
     }
 
-- 
2.47.1


