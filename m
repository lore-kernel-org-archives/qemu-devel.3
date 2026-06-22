Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346DCCDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 09:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbagc-0003ZC-QK; Mon, 22 Jun 2026 05:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1wbaga-0003Yu-Hc
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 05:11:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1wbagY-00029K-Ra
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 05:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782119476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=QPFUAq+pQysfDmB0VcZVZF7tljshfpK7DKtQ08CzUO0=;
 b=ixCEDdiuoXZFRUUrHye2npyxIySf8K9vBXQjHCVI1tKSLuAmF3n98CGIxkefTd27jbLLDn
 u9xbZe8ZNQ+9SoKc9TcWo5sD9wCbsW/W/0nvHbytgUjvUPQgqUJe+VhuGT2NRgSgravOm/
 gR+/Ap+gygJzRDZtsjAQYBhhXMpeufM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-ZRAmL-ZGPRGAWs8e5kc1sw-1; Mon,
 22 Jun 2026 05:11:12 -0400
X-MC-Unique: ZRAmL-ZGPRGAWs8e5kc1sw-1
X-Mimecast-MFC-AGG-ID: ZRAmL-ZGPRGAWs8e5kc1sw_1782119471
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B0E5A18005AC; Mon, 22 Jun 2026 09:11:10 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.180])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 52F941800661; Mon, 22 Jun 2026 09:11:07 +0000 (UTC)
From: Mario Casquero <mcasquer@redhat.com>
To: qemu-devel@nongnu.org
Cc: clg@redhat.com, alex@shazbot.org, philmd@mailo.com,
 Mario Casquero <mcasquer@redhat.com>
Subject: [PATCH v2] vfio/pci: Propagate errors in vfio_pci_load_rom() using
 Error API
Date: Mon, 22 Jun 2026 11:10:51 +0200
Message-ID: <20260622091051.50048-1-mcasquer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mcasquer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 hw/vfio/pci.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9df04fa2d7..38ee4fc7a9 100644
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
 
@@ -1052,7 +1052,8 @@ static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
     vdev->rom_offset = reg_info->offset;
 
     if (!vdev->rom_size) {
-        error_report("vfio-pci: Cannot read device rom at %s", vbasedev->name);
+        error_setg(errp, "vfio-pci: Cannot read device rom at %s",
+                   vbasedev->name);
         error_printf("Device option ROM contents are probably invalid "
                     "(check dmesg).\nSkip option ROM probe with rombar=0, "
                     "or load from file with romfile=\n");
@@ -1076,10 +1077,12 @@ static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
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
 
@@ -1147,7 +1150,12 @@ static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
 
     /* Load the ROM lazily when the guest tries to read it */
     if (unlikely(!vdev->rom && !vdev->rom_read_failed)) {
-        vdev->rom_read_failed = !vfio_pci_load_rom(vdev);
+        Error *local_err = NULL;
+
+        vdev->rom_read_failed = !vfio_pci_load_rom(vdev, NULL);
+        if (vdev->rom_read_failed) {
+            error_report_err(local_err)
+        }
     }
 
     memcpy(&val, vdev->rom + addr,
-- 
2.54.0


