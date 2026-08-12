Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC737C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAJd-0005oG-UL; Wed, 12 Aug 2026 10:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAIO-0004Tb-RD; Wed, 12 Aug 2026 10:51:11 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAIM-0006jQ-VE; Wed, 12 Aug 2026 10:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546230; bh=2XnDISUFmJhjq7OY2XlvuVuko3shpVM4a6RDzXAfb7g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Q+QPzlfeIPcqNEupz35C7Fl6H17teSSg4SCb1wUZyJajfCfcRLU1Z0KxgiO/IjE8S
 I0x5YESxcI0+YRUMaoMCPcEiF5XPzPr1aFfe3NSDPlGtDBn+HPNdG2pSSuFsQIIs3b
 T10qkDvcYnooBnz4qi6kW76q14LCTH30i/a+X2nORpiZmQEkIX3fYntGvW2ii0aUMd
 6CGrrL+6SvWdU0yfUpjeJ4ULdMsB8z0C6IH5qdIGw/RJGfLQtkJDd3QfphwIMh9O4t
 V0dRE6xIeo4O78ugnFC2PaDtSHqzOdRpRZEYRobNmeMerwFV7dP42Fdd5hNgBO3uU1
 nm9ud9G1FKN6g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DADF71CA60C;
 Wed, 12 Aug 2026 17:50:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 41AF5409D46;
 Wed, 12 Aug 2026 17:50:42 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9B3FB2F973; Wed, 12 Aug 2026 17:50:17 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mario Casquero <mcasquer@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 008/120] vfio/pci: Initialize rom_read_failed in
 vfio_pci_load_rom()
Date: Wed, 12 Aug 2026 17:47:51 +0300
Message-ID: <20260812144955.649205-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
(cherry picked from commit c822ecd806614fa24e7d3bd120a0f96b00d6d1a5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 1945751ffd4..2b6e0c8386d 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1031,7 +1031,7 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
     }
 }
 
-static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
+static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
     struct vfio_region_info *reg_info = NULL;
@@ -1045,7 +1045,7 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
 
     if (ret != 0) {
         error_report("vfio: Error getting ROM info: %s", strerror(-ret));
-        return;
+        return false;
     }
 
     trace_vfio_pci_load_rom(vbasedev->name, (unsigned long)reg_info->size,
@@ -1056,12 +1056,11 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
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
@@ -1117,6 +1116,8 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
             data[6] = -csum;
         }
     }
+
+    return true;
 }
 
 /* "Raw" read of underlying config space. */
@@ -1150,7 +1151,7 @@ static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
 
     /* Load the ROM lazily when the guest tries to read it */
     if (unlikely(!vdev->rom && !vdev->rom_read_failed)) {
-        vfio_pci_load_rom(vdev);
+        vdev->rom_read_failed = !vfio_pci_load_rom(vdev);
     }
 
     memcpy(&val, vdev->rom + addr,
-- 
2.47.3


