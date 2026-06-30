Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AE4C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 04:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weQ8h-0006nN-Js; Tue, 30 Jun 2026 00:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weQ8g-0006n4-3i
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 00:32:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weQ8e-0003FL-GU
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 00:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782793919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jIx95q429t63sKVC1uPzadqlslaDv+W+0CTA/My+vYM=;
 b=XZnG2/Od8S/k/aObJ3O2+IgA8yYQrIXU1t9IpAdF6y81J85BE6ekMrzfOvfOpB74kT0C+J
 bcnC1JQl5ZGI98EQ1F5L1Q722ZG0GQF7pAc4wtGdB7MeVzz9Bz6iTQY+FWBBx/dCnloVp7
 DkhzYUTNcrzm4M6KlF1GOw+JbH2UG0w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-aCHMOotCMQa1knbxE4BQpA-1; Tue,
 30 Jun 2026 00:31:57 -0400
X-MC-Unique: aCHMOotCMQa1knbxE4BQpA-1
X-Mimecast-MFC-AGG-ID: aCHMOotCMQa1knbxE4BQpA_1782793916
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B71CB19773FF; Tue, 30 Jun 2026 04:31:56 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.58])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3ABEB1956042; Tue, 30 Jun 2026 04:31:54 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mario Casquero <mcasquer@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 22/23] vfio/pci: Propagate errors in vfio_pci_load_rom() using
 Error API
Date: Tue, 30 Jun 2026 06:31:06 +0200
Message-ID: <20260630043107.1511076-23-clg@redhat.com>
In-Reply-To: <20260630043107.1511076-1-clg@redhat.com>
References: <20260630043107.1511076-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Mario Casquero <mcasquer@redhat.com>

Updates vfio_pci_load_rom() to use Error API for error propagation
instead of error_report(), improving error handling consistency.

Signed-off-by: Mario Casquero <mcasquer@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260625094307.148542-1-mcasquer@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c7f163399f8fbcc4ff70819a0d67879eb26980f9..e6d1adfd3655ce3c1baf8977c82223d23af9b770 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1028,7 +1028,7 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
     }
 }
 
-static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
+static bool vfio_pci_load_rom(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
     struct vfio_region_info *reg_info = NULL;
@@ -1041,7 +1041,7 @@ static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
                                       &reg_info);
 
     if (ret != 0) {
-        error_report("vfio: Error getting ROM info: %s", strerror(-ret));
+        error_setg_errno(errp, -ret, "vfio: Error getting ROM info");
         return false;
     }
 
@@ -1053,10 +1053,13 @@ static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
     vdev->rom_offset = reg_info->offset;
 
     if (!vdev->rom_size) {
-        error_report("vfio-pci: Cannot read device rom at %s", vbasedev->name);
-        error_printf("Device option ROM contents are probably invalid "
-                    "(check dmesg).\nSkip option ROM probe with rombar=0, "
-                    "or load from file with romfile=\n");
+        vdev->rom_size = 0;
+        vdev->rom_offset = 0;
+        error_setg(errp, "vfio-pci: Device ROM size is zero at %s",
+                   vbasedev->name);
+        error_append_hint(errp, "Device option ROM contents are probably "
+                          "invalid (check dmesg).\nSkip option ROM probe "
+                          "with rombar=0, or load from file with romfile=\n");
         return false;
     }
 
@@ -1077,10 +1080,12 @@ static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
             if (bytes == -EINTR || bytes == -EAGAIN) {
                 continue;
             }
-            error_report("vfio: Error reading device ROM: %s",
-                         strreaderror(bytes));
-
-            break;
+            error_setg_errno(errp, -bytes, "vfio: Error reading device ROM");
+            g_free(vdev->rom);
+            vdev->rom = NULL;
+            vdev->rom_size = 0;
+            vdev->rom_offset = 0;
+            return false;
         }
     }
 
@@ -1148,7 +1153,12 @@ static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
 
     /* Load the ROM lazily when the guest tries to read it */
     if (unlikely(!vdev->rom && !vdev->rom_read_failed)) {
-        vdev->rom_read_failed = !vfio_pci_load_rom(vdev);
+        Error *local_err = NULL;
+
+        vdev->rom_read_failed = !vfio_pci_load_rom(vdev, &local_err);
+        if (vdev->rom_read_failed) {
+            error_report_err(local_err);
+        }
     }
 
     memcpy(&val, vdev->rom + addr,
-- 
2.54.0


