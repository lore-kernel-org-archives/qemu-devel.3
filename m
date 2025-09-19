Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBAACAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 14:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzc94-0006MB-Lx; Fri, 19 Sep 2025 10:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>) id 1uzc8y-0006LR-T3
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:31:24 -0400
Received: from mail.avm.de ([2001:bf0:244:244::94])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>) id 1uzc8p-0007kR-OG
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1758292267; bh=DVxe/KlH+huwXXc53J4y3b3H7fJZn3f18VK236eNISI=;
 h=From:Date:Subject:To:Cc:From;
 b=kCtyQ1RmJvjaWoDRddxF7HqmJ7wLGHeu7zMM7rr7G7ncqlZSjsdmrUxIaU9fE//0j
 nvJAhmyl4ZTj4NhGHEgVzFkdrPgbRKtV4CeyYVGA31QGZDh+pBYScSbLAz4H41Jmbf
 0yRENSd6az/OhnRApebHIcXB7eUCFLEqNAb4mzYg=
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.53.4)
 (envelope-from <c.speich@avm.de>)
 id 68cd692b-f941-7f0000032729-7f000001a598-1
 for <multiple-recipients>; Fri, 19 Sep 2025 16:31:07 +0200
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Fri, 19 Sep 2025 16:31:07 +0200 (CEST)
Received: from [127.0.1.1] ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2025091916310726-16944 ;
 Fri, 19 Sep 2025 16:31:07 +0200 
From: Christian Speich <c.speich@avm.de>
Date: Fri, 19 Sep 2025 16:30:53 +0200
Subject: [PATCH] virtio: vhost-user-device: Make user creatable again
MIME-Version: 1.0
Message-Id: <20250919-vhost-user-device-creatable-v1-1-87eefeea7f68@avm.de>
X-B4-Tracking: v=1; b=H4sIABxpzWgC/x2MQQqAMAzAviI9W9CByPyKeFi3zhVEZVMRxL9bP
 AaSPFA4CxcYqgcyX1JkWxXaugKf3DozSlAG05iusa3FK23lwFMzDOp7Rp/ZHY4WRuqjpZ46imR
 AD3vmKPd/H6f3/QB/m7I8bQAAAA==
X-Change-ID: 20250919-vhost-user-device-creatable-b7f9b7b5bfb2
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, =?utf-8?q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Christian Speich <c.speich@avm.de>
X-Mailer: b4 0.14.2
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 14.0FP4|March 10,
 2025) at 19.09.2025 16:31:07,
 Serialize by Router on ANIS1/AVM(Release 14.0FP4|March 10, 2025) at
 19.09.2025 16:31:07, Serialize complete at 19.09.2025 16:31:07
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-purgate-ID: 149429::1758292267-6CDE0482-918D6EF1/0/0
X-purgate-type: clean
X-purgate-size: 3443
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
Received-SPF: pass client-ip=2001:bf0:244:244::94;
 envelope-from=c.speich@avm.de; helo=mail.avm.de
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

This removes the change introduced in [1] that prevents the use of
vhost-user-device and vhost-user-device-pci on unpatched QEMU builds.

[1]: 6275989647efb708f126eb4f880e593792301ed4

Signed-off-by: Christian Speich <c.speich@avm.de>
---
vhost-user-device and vhost-user-device-pci started out as user
creatable devices. This was changed in [1] when the vhost-user-base was
introduced.

The reason given is to prevent user confusion. Searching qemu-discuss or
google for "vhost-user-device" I've seen no confused users.

Our use case is to provide wifi emulation using "vhost-user-device-pci",
which currently is working fine with the QEMU 9.0.2 present in Ubuntu
24.04. With newer QEMU versions we now need to patch, distribute and
maintain our own QEMU packages, which is non-trivial.

So I want to propose lifting this restriction to make this feature
usable without a custom QEMU.

[1]: 6275989647efb708f126eb4f880e593792301ed4
---
 docs/system/devices/vhost-user.rst | 10 ----------
 hw/virtio/vhost-user-device-pci.c  |  3 ---
 hw/virtio/vhost-user-device.c      |  3 ---
 3 files changed, 16 deletions(-)

diff --git a/docs/system/devices/vhost-user.rst b/docs/system/devices/vhost-user.rst
index 35259d8ec7c666aa0c56497b8261f48d77216ad5..2d130f9767dbb1cbb85cef43c63dc9a8d7b30d4a 100644
--- a/docs/system/devices/vhost-user.rst
+++ b/docs/system/devices/vhost-user.rst
@@ -73,16 +73,6 @@ all the required parameters including:
   - The ``num_vqs`` it needs and their ``vq_size``
   - The ``config_size`` if needed
 
-.. note::
-  To prevent user confusion you cannot currently instantiate
-  vhost-user-device without first patching out::
-
-    /* Reason: stop inexperienced users confusing themselves */
-    dc->user_creatable = false;
-
-  in ``vhost-user-device.c`` and ``vhost-user-device-pci.c`` file and
-  rebuilding.
-
 vhost-user daemon
 =================
 
diff --git a/hw/virtio/vhost-user-device-pci.c b/hw/virtio/vhost-user-device-pci.c
index f10bac874e78429c633752a4ce9db28385b3bb07..c76a856c9b9a67d941a93929244216658ff2a156 100644
--- a/hw/virtio/vhost-user-device-pci.c
+++ b/hw/virtio/vhost-user-device-pci.c
@@ -38,9 +38,6 @@ static void vhost_user_device_pci_class_init(ObjectClass *klass,
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
     PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
 
-    /* Reason: stop users confusing themselves */
-    dc->user_creatable = false;
-
     k->realize = vhost_user_device_pci_realize;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
     pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
diff --git a/hw/virtio/vhost-user-device.c b/hw/virtio/vhost-user-device.c
index 3939bdf755222a281da8ca22243d7d4f16990a66..1bea496afd0137ba9b42009f6252acf6800528d1 100644
--- a/hw/virtio/vhost-user-device.c
+++ b/hw/virtio/vhost-user-device.c
@@ -41,9 +41,6 @@ static void vud_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    /* Reason: stop inexperienced users confusing themselves */
-    dc->user_creatable = false;
-
     device_class_set_props(dc, vud_properties);
     dc->vmsd = &vud_vmstate;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);

---
base-commit: e7c1e8043a69c5a8efa39d4f9d111f7c72c076e6
change-id: 20250919-vhost-user-device-creatable-b7f9b7b5bfb2

Best regards,
-- 
Christian Speich <c.speich@avm.de>


