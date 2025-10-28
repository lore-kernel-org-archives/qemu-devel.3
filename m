Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BB5CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDstL-0002tX-Aw; Tue, 28 Oct 2025 19:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstH-0002sJ-H7
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:11 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDst8-00015Q-Kx
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:11 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 67C248175B;
 Wed, 29 Oct 2025 02:13:57 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:582::1:19])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id oDnXpg2bCW20-hDAe9Lg5; Wed, 29 Oct 2025 02:13:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761693237;
 bh=2RdqmSqfNG0TgINlHqYz9mlYzWrFLPE9G7i68j2dG0c=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=WNc3Dh8W5EzfDlgLVcpXALx87a6xHFAvkO/Deny11QE5jE+Wzkpy+9sMz3Cp+Cagt
 jCb1jOj97Wkw5ssHY5ccZP9ibS8Jgk4jK3oUBYvxGsffYrj5YFdtNBkOP8fvsgxpaV
 XEb1lZTMQ3RY8AtlKIIyUGMdHJMv/deZFcispRkQ=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: armbru@redhat.com,
	vsementsov@yandex-team.ru,
	qemu-devel@nongnu.org
Subject: [RFC 08/22] hw/vfio/pci: move to new migration APIs
Date: Wed, 29 Oct 2025 02:13:32 +0300
Message-ID: <20251028231347.194844-9-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251028231347.194844-1-vsementsov@yandex-team.ru>
References: <20251028231347.194844-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/vfio/pci.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 8b8bc5a421..152015d2f7 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2821,8 +2821,8 @@ static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
 
-    return vmstate_save_state(f, &vmstate_vfio_pci_config, vdev, NULL,
-                              errp);
+    return vmstate_save_vmsd(
+        f, &vmstate_vfio_pci_config, vdev, NULL, errp) ? 0 : -EINVAL;
 }
 
 static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
@@ -2830,18 +2830,16 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
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
@@ -2865,7 +2863,7 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
         vfio_msix_enable(vdev);
     }
 
-    return ret;
+    return 0;
 }
 
 /* Transform from VFIODevice to VFIOPCIDevice. Return NULL if fails. */
-- 
2.48.1


