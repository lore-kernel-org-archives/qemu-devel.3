Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6D7C5DF60
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8cn-00044G-Lq; Wed, 12 Aug 2026 09:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8cE-0003Yh-JF; Wed, 12 Aug 2026 09:03:30 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8cB-0004Iz-2s; Wed, 12 Aug 2026 09:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539783; bh=aMjLn6fbpzdfipoOErygivKJVLSr5EC6LNo3pCAh7/8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ENzBLt1nLAMhuDNqXH7AYEfqHbW1ZYCP6YkCbIox6jjKscm88THozG/jX1VSITMYF
 gB1hO8r1hO5qTVrGJBTps1XxEWVOPnPJkSzEUXIeliR6PPiezTi5RZTYh5JVgJGgme
 jwqdQEOADnLeSj2PeAlDMc/+l2tUqHhTJ/0e5dKG/yPIE1yuMOrRdx/TsKYZCQhzvm
 xhNOcqFYCBa0gLBsPm5lDhPl6qiJ9az5GQq5YKAVJqD5+j15/dIxolGIAkvJUO7pjV
 bj0DgnYI+5+FcZYXlh6fARReVSZYpQjiUzdUqGZNn21FRGFN5fYER0UDObg+CGmodj
 y8/18c4aYPxSw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 20E721CA486;
 Wed, 12 Aug 2026 16:03:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 56F19409B69;
 Wed, 12 Aug 2026 16:03:14 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D20732F8A2; Wed, 12 Aug 2026 16:02:49 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mario Casquero <mcasquer@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 007/102] vfio/pci: Initialize rom_read_failed in
 vfio_pci_load_rom()
Date: Wed, 12 Aug 2026 16:00:42 +0300
Message-ID: <20260812130233.621965-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
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
(Mjt: context fixup for v10.0.0-756-g2e27becf17b
 "vfio: consistently handle return value for helpers")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 7f1532fbed9..b8f16d9c463 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -877,7 +877,7 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
     }
 }
 
-static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
+static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
 {
     g_autofree struct vfio_region_info *reg_info = NULL;
     uint64_t size;
@@ -887,7 +887,7 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
     if (vfio_get_region_info(&vdev->vbasedev,
                              VFIO_PCI_ROM_REGION_INDEX, &reg_info)) {
         error_report("vfio: Error getting ROM info: %m");
-        return;
+        return false;
     }
 
     trace_vfio_pci_load_rom(vdev->vbasedev.name, (unsigned long)reg_info->size,
@@ -898,13 +898,12 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
     vdev->rom_offset = reg_info->offset;
 
     if (!vdev->rom_size) {
-        vdev->rom_read_failed = true;
         error_report("vfio-pci: Cannot read device rom at "
                     "%s", vdev->vbasedev.name);
         error_printf("Device option ROM contents are probably invalid "
                     "(check dmesg).\nSkip option ROM probe with rombar=0, "
                     "or load from file with romfile=\n");
-        return;
+        return false;
     }
 
     vdev->rom = g_malloc(size);
@@ -956,6 +955,8 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
             data[6] = -csum;
         }
     }
+
+    return true;
 }
 
 static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
@@ -971,7 +972,7 @@ static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
 
     /* Load the ROM lazily when the guest tries to read it */
     if (unlikely(!vdev->rom && !vdev->rom_read_failed)) {
-        vfio_pci_load_rom(vdev);
+        vdev->rom_read_failed = !vfio_pci_load_rom(vdev);
     }
 
     memcpy(&val, vdev->rom + addr,
-- 
2.47.3


