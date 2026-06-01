Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83661CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 14:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU3u8-0004bc-NU; Mon, 01 Jun 2026 10:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1wU3u2-0004a2-89
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 10:46:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1wU3u0-00029C-IN
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 10:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780325161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1rwRmaRjrEk9S8N/sDBUwePNzmT7sYxcYoAqqlGW4KE=;
 b=i0ih906INIM268fRYmDa2CiawPsdm+D1EP1AW93DyvWk2Mh9pMOcRk8qr4XaHDBQMq/L7r
 k3s2ePDpLxBrIYH0pDFMaiOYxmVTynsXSvHH8hhUq2WX77nseAiVYLXqib/bc1C7LlFJko
 4arMhktp5m4M1CHhXSzcZ3dS42/uAL0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-FLcDaCIzPbGJPrPBDDmlnw-1; Mon,
 01 Jun 2026 10:44:33 -0400
X-MC-Unique: FLcDaCIzPbGJPrPBDDmlnw-1
X-Mimecast-MFC-AGG-ID: FLcDaCIzPbGJPrPBDDmlnw_1780325073
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C605C180034A; Mon,  1 Jun 2026 14:44:32 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.177])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CABCB19560A2; Mon,  1 Jun 2026 14:44:30 +0000 (UTC)
From: Mario Casquero <mcasquer@redhat.com>
To: qemu-devel@nongnu.org
Cc: clg@redhat.com,
	alex@shazbot.org,
	Mario Casquero <mcasquer@redhat.com>
Subject: [PATCH] vfio/pci: Initialize rom_read_failed in vfio_pci_load_rom()
Date: Mon,  1 Jun 2026 16:43:39 +0200
Message-ID: <20260601144339.339275-1-mcasquer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mcasquer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When vfio_device_get_region_info() fails in vfio_pci_load_rom(),
the function returns without setting vdev->rom_read_failed to true,
and without allocating vdev->rom. This leaves vdev->rom as NULL.

Signed-off-by: Mario Casquero <mcasquer@redhat.com>
---
 hw/vfio/pci.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9c06b25e63..d73614d3de 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1027,7 +1027,7 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
     }
 }

-static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
+static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
     struct vfio_region_info *reg_info = NULL;
@@ -1041,7 +1041,7 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)

     if (ret != 0) {
         error_report("vfio: Error getting ROM info: %s", strerror(-ret));
-        return;
+        return false;
     }

     trace_vfio_pci_load_rom(vbasedev->name, (unsigned long)reg_info->size,
@@ -1057,7 +1057,7 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
         error_printf("Device option ROM contents are probably invalid "
                     "(check dmesg).\nSkip option ROM probe with rombar=0, "
                     "or load from file with romfile=\n");
-        return;
+        return false;
     }

     vdev->rom = g_malloc(size);
@@ -1113,6 +1113,8 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
             data[6] = -csum;
         }
     }
+
+    return true;
 }

 /* "Raw" read of underlying config space. */
@@ -1146,7 +1148,7 @@ static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)

     /* Load the ROM lazily when the guest tries to read it */
     if (unlikely(!vdev->rom && !vdev->rom_read_failed)) {
-        vfio_pci_load_rom(vdev);
+        vdev->rom_read_failed = !vfio_pci_load_rom(vdev);
     }

     memcpy(&val, vdev->rom + addr,
--
2.54.0


