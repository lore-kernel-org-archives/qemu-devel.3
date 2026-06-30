Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B246C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 04:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weQ80-0006dA-4q; Tue, 30 Jun 2026 00:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weQ7y-0006cv-MJ
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 00:31:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weQ7x-0002xv-2A
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 00:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782793875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AK8st6ZsSR9rdtKS3UXX81Tfh/+SrtFP6nIEbY2Os24=;
 b=ZLkNNXcTfMwzU0aMDn4fKoYMNUyc3dNJaU81oJQh1xoCcUiT9+tqVlGnsgMTEnhgO4WYlq
 0bVbA0xperG/vSYwDUs1OPtXCpVVYLoKYJFSoZawtqNKwjCVqY1YzTvPvohxXhM17bUBfL
 l323v1zIXcUoWIwSLCDM0UdrqCCDh/Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-k9itPA1oMD-vqsyNFZzWHQ-1; Tue,
 30 Jun 2026 00:31:13 -0400
X-MC-Unique: k9itPA1oMD-vqsyNFZzWHQ-1
X-Mimecast-MFC-AGG-ID: k9itPA1oMD-vqsyNFZzWHQ_1782793872
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67CC71954B1E
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 04:31:12 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.58])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2A6C41956042; Tue, 30 Jun 2026 04:31:10 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mario Casquero <mcasquer@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 01/23] vfio/pci: Initialize rom_read_failed in
 vfio_pci_load_rom()
Date: Tue, 30 Jun 2026 06:30:45 +0200
Message-ID: <20260630043107.1511076-2-clg@redhat.com>
In-Reply-To: <20260630043107.1511076-1-clg@redhat.com>
References: <20260630043107.1511076-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When vfio_device_get_region_info() fails in vfio_pci_load_rom(),
the function returns without setting vdev->rom_read_failed to true,
and without allocating vdev->rom. This leaves vdev->rom as NULL.

Signed-off-by: Mario Casquero <mcasquer@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260602070857.356526-1-mcasquer@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 4d822b96b530c614671551589ce3584e9598f386..68ee3ce7dc254dd045ed2c1b21bebc53a4b4e3d6 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1028,7 +1028,7 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
     }
 }
 
-static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
+static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
     struct vfio_region_info *reg_info = NULL;
@@ -1042,7 +1042,7 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
 
     if (ret != 0) {
         error_report("vfio: Error getting ROM info: %s", strerror(-ret));
-        return;
+        return false;
     }
 
     trace_vfio_pci_load_rom(vbasedev->name, (unsigned long)reg_info->size,
@@ -1053,12 +1053,11 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
     vdev->rom_offset = reg_info->offset;
 
     if (!vdev->rom_size) {
-        vdev->rom_read_failed = true;
         error_report("vfio-pci: Cannot read device rom at %s", vbasedev->name);
         error_printf("Device option ROM contents are probably invalid "
                     "(check dmesg).\nSkip option ROM probe with rombar=0, "
                     "or load from file with romfile=\n");
-        return;
+        return false;
     }
 
     vdev->rom = g_malloc(size);
@@ -1114,6 +1113,8 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
             data[6] = -csum;
         }
     }
+
+    return true;
 }
 
 /* "Raw" read of underlying config space. */
@@ -1147,7 +1148,7 @@ static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
 
     /* Load the ROM lazily when the guest tries to read it */
     if (unlikely(!vdev->rom && !vdev->rom_read_failed)) {
-        vfio_pci_load_rom(vdev);
+        vdev->rom_read_failed = !vfio_pci_load_rom(vdev);
     }
 
     memcpy(&val, vdev->rom + addr,
-- 
2.54.0


