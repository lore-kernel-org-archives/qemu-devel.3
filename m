Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225B9CDB47F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 09:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcgcV-0003WA-Ez; Thu, 25 Jun 2026 05:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1wcgcQ-0003UU-Up
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 05:43:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1wcgcO-00025w-6H
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 05:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782380609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/ORMVcRbXRgGLTIEDc67S+U5Utcp5RY403tsUApMa1w=;
 b=WQjBKGzx8W7i9XHfBcyEHXiBxBuIm9tJLupMVJwOFH7GRQX9cDPkv5XhKbQSjLpx3ESTbP
 0H0kktAJx8Y5ld9ljU3QZX82qM/S9mxhwzMMECuU7hqzTXjs4lvYIpG87sJllbaYz/T8zn
 CHvoAokOfzxYkCsgW13rdW8AJHzIbls=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-ajCGSq5YN16lloXEwedkjA-1; Thu,
 25 Jun 2026 05:43:27 -0400
X-MC-Unique: ajCGSq5YN16lloXEwedkjA-1
X-Mimecast-MFC-AGG-ID: ajCGSq5YN16lloXEwedkjA_1782380606
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 275D419560AA; Thu, 25 Jun 2026 09:43:26 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.49.185])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1101B1956040; Thu, 25 Jun 2026 09:43:22 +0000 (UTC)
From: Mario Casquero <mcasquer@redhat.com>
To: qemu-devel@nongnu.org
Cc: clg@redhat.com, alex@shazbot.org, philmd@mailo.com,
 Mario Casquero <mcasquer@redhat.com>
Subject: [PATCH v4] vfio/pci: Propagate errors in vfio_pci_load_rom() using
 Error API
Date: Thu, 25 Jun 2026 11:43:07 +0200
Message-ID: <20260625094307.148542-1-mcasquer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mcasquer@redhat.com;
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

Updates vfio_pci_load_rom() to use Error API for error propagation
instead of error_report(), improving error handling consistency.

Signed-off-by: Mario Casquero <mcasquer@redhat.com>
---
v4:
  - Use error_append_hint() instead of error_printf()
  - Reset rom_size and rom_offset to 0 in the error case
  - Update error message to "Device ROM size is zero", different from read errors
v3:
  - Use error_setg_errno() instead of error_setg() with strerror()
  - Reset rom_size and rom_offset to 0 when freeing rom on error
  - Use local_err with error_report_err() instead of passing NULL errp

 hw/vfio/pci.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9df04fa2d7..61b4a6a5a3 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1027,7 +1027,7 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
     }
 }
 
-static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
+static bool vfio_pci_load_rom(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
     struct vfio_region_info *reg_info = NULL;
@@ -1040,7 +1040,7 @@ static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
                                       &reg_info);
 
     if (ret != 0) {
-        error_report("vfio: Error getting ROM info: %s", strerror(-ret));
+        error_setg_errno(errp, -ret, "vfio: Error getting ROM info");
         return false;
     }
 
@@ -1052,10 +1052,13 @@ static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
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
 
@@ -1076,10 +1079,12 @@ static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
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
 
@@ -1147,7 +1152,12 @@ static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
 
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


