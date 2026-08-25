Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1BCC61DC6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyr0-0005p4-2D; Tue, 25 Aug 2026 17:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyqx-0005n6-Ul
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:43 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyqw-00051r-BB
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:43 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id F34DB80C05;
 Wed, 26 Aug 2026 00:38:40 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:630::1:39])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QckKa93ZVmI0-k76Ud8fb; Wed, 26 Aug 2026 00:38:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787693920;
 bh=v2W1Ev9o02njg8c/xleyXHEUypY1szGPjue53/EGW+8=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=NR0iEPq/AJCxWhIk/vAK+3hQaFFQNbMrbnHagDk3OHCbBQgJfBCOO4PUtiD1+Hcz+
 FoKvgsK7AtN0X2PNQT2tEGwRzEdqA1WeOJn2PBk9Li9pDqi5IDl0Q9+hDJjNJdHy/g
 w0/QYu0y2sV1imni/nmvPssz1Swri0JaTrr+8Xik=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 10/30] hw/vfio/pci: move to new migration APIs
Date: Wed, 26 Aug 2026 00:37:50 +0300
Message-ID: <20260825213811.3725682-11-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
References: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/vfio/pci.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 428ab2f0698..ec59c30495d 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3000,8 +3000,8 @@ static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
 
-    return vmstate_save_state(f, &vmstate_vfio_pci_config, vdev, NULL,
-                              errp);
+    return vmstate_save_vmsd(
+        f, &vmstate_vfio_pci_config, vdev, NULL, errp) ? 0 : -EINVAL;
 }
 
 static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
@@ -3009,18 +3009,16 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
     PCIDevice *pdev = PCI_DEVICE(vdev);
     pcibus_t old_addr[PCI_NUM_REGIONS - 1];
-    int bar, ret;
+    int bar;
     Error *local_err = NULL;
 
     for (bar = 0; bar < PCI_ROM_SLOT; bar++) {
         old_addr[bar] = pdev->io_regions[bar].addr;
     }
 
-    ret = vmstate_load_state(f, &vmstate_vfio_pci_config, vdev, 1,
-                             &local_err);
-    if (ret) {
+    if (!vmstate_load_vmsd(f, &vmstate_vfio_pci_config, vdev, 1, &local_err)) {
         error_report_err(local_err);
-        return ret;
+        return -EINVAL;
     }
 
     vfio_pci_write_config(pdev, PCI_COMMAND,
@@ -3044,7 +3042,7 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
         vfio_msix_enable(vdev);
     }
 
-    return ret;
+    return 0;
 }
 
 /* Transform from VFIODevice to VFIOPCIDevice. Return NULL if fails. */
-- 
2.43.0


