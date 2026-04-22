Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8015CD6E6B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 12:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV7PW-0003BL-Qv; Thu, 04 Jun 2026 08:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1wV2Li-0006t6-R4
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 03:18:43 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1wV2Lf-0003bW-DL
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 03:18:42 -0400
DKIM-Signature: a=rsa-sha256; bh=oAvFqrZftth2c6bas4KhQjbPZs/8e0Y62M1fVqqHMrw=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1780557513; v=1;
 b=iW4Kl1DetSWU2IiiS+57mRYXrexWl4nvrH+64XP7iEw7dV6ujNZh0i5xKobV8e+c6Y+BkhGk
 clCzv09iDw5FK+lxrjqimQAg4nepmt+oJ0jJUs4eX/CQ/FutoOll5qPMVO5nRga+/cqRT6QDwaJ
 GgVksv8Ee7DssAF8vNYodYgdCjFEvCetZlrQThwGSDqKZjcyo43ZfcSVt+sUzuyrzc49w00osRl
 OiIcZzfSivmy+OBvTYpQoCniBtqqROsmqdCJrDSXMNTVrUFGf0h7GWmEDrm4STUm/XVs9vDl/yz
 yK54UbqdJe/bDBTC+dpZYrYkr0+r+jIybfry0zKoAV8Bg==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id B8E2821303;
 Thu, 04 Jun 2026 07:18:33 +0000 (UTC)
From: ~kholia <kholia@git.sr.ht>
Date: Wed, 22 Apr 2026 19:28:05 +0530
Subject: [PATCH qemu 1/1] hw/usb/dev-storage: add vid/pid/manufacturer/product
 overrides
Message-ID: <178055751360.22223.153528865155723674-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <178055751360.22223.153528865155723674-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 38
X-Spam_score: 3.8
X-Spam_bar: +++
X-Spam_report: (3.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, FREEMAIL_FORGED_REPLYTO=2.095,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 04 Jun 2026 08:42:54 -0400
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
Reply-To: ~kholia <dhiru.kholia@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Dhiru Kholia <dhiru@openwall.com>

This patch adds the ability to override the Vendor ID, Product ID,
Manufacturer and Product strings for USB storage devices via properties.

This allows emulating specific USB storage devices more accurately.
When vid or pid is specified, a per-instance USB descriptor is
created to hold these values.

This helps with debugging and reversing of various VID+PID restricted
applications (e.g. Samsung SecretZone, SanDisk SecureAccess and others).

Usage:

-drive file=3Dhdd.img,format=3Dqcow2,if=3Dnone,id=3Ddisk \
-device usb-storage,drive=3Ddisk,vid=3D0x1,pid=3D0x2,manufacturer=3DA,product=
=3DB

Signed-off-by: Dhiru Kholia <dhiru@openwall.com>
---
 hw/usb/dev-storage-bot.c     |  1 +
 hw/usb/dev-storage-classic.c |  1 +
 hw/usb/dev-storage.c         | 43 ++++++++++++++++++++++++++++++++++++
 include/hw/usb/msd.h         |  3 +++
 4 files changed, 48 insertions(+)

diff --git a/hw/usb/dev-storage-bot.c b/hw/usb/dev-storage-bot.c
index a7f8d80c17..9b8d12958c 100644
--- a/hw/usb/dev-storage-bot.c
+++ b/hw/usb/dev-storage-bot.c
@@ -30,6 +30,7 @@ static void usb_msd_bot_realize(USBDevice *dev, Error **err=
p)
     DeviceState *d =3D DEVICE(dev);
=20
     usb_desc_create_serial(dev);
+    usb_msd_init_desc(dev);
     usb_desc_init(dev);
     dev->flags |=3D (1 << USB_DEV_FLAG_IS_SCSI_STORAGE);
     if (d->hotplugged) {
diff --git a/hw/usb/dev-storage-classic.c b/hw/usb/dev-storage-classic.c
index 977151c4a0..92cf125c8e 100644
--- a/hw/usb/dev-storage-classic.c
+++ b/hw/usb/dev-storage-classic.c
@@ -53,6 +53,7 @@ static void usb_msd_storage_realize(USBDevice *dev, Error *=
*errp)
     s->conf.blk =3D NULL;
=20
     usb_desc_create_serial(dev);
+    usb_msd_init_desc(dev);
     usb_desc_init(dev);
     dev->flags |=3D (1 << USB_DEV_FLAG_IS_SCSI_STORAGE);
     scsi_bus_init(&s->bus, sizeof(s->bus), DEVICE(dev),
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 040cf15051..0f1389b2d5 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -567,6 +567,47 @@ void *usb_msd_load_request(QEMUFile *f, SCSIRequest *req)
     return NULL;
 }
=20
+static void usb_msd_unrealize(USBDevice *dev)
+{
+    if (dev->usb_desc !=3D &desc) {
+        g_free((USBDesc *)dev->usb_desc);
+    }
+}
+
+void usb_msd_init_desc(USBDevice *dev)
+{
+    MSDState *s =3D USB_STORAGE_DEV(dev);
+    USBDesc *d;
+
+    if (s->vid || s->pid) {
+        d =3D g_new0(USBDesc, 1);
+        *d =3D desc;
+        if (s->vid) {
+            d->id.idVendor =3D s->vid;
+        }
+        if (s->pid) {
+            d->id.idProduct =3D s->pid;
+        }
+        dev->usb_desc =3D d;
+    } else {
+        dev->usb_desc =3D &desc;
+    }
+
+    if (s->manufacturer) {
+        usb_desc_set_string(dev, STR_MANUFACTURER, s->manufacturer);
+    }
+    if (s->product) {
+        usb_desc_set_string(dev, STR_PRODUCT, s->product);
+    }
+}
+
+static const Property msd_properties_common[] =3D {
+    DEFINE_PROP_UINT16("vid", MSDState, vid, 0),
+    DEFINE_PROP_UINT16("pid", MSDState, pid, 0),
+    DEFINE_PROP_STRING("manufacturer", MSDState, manufacturer),
+    DEFINE_PROP_STRING("product", MSDState, product),
+};
+
 static const VMStateDescription vmstate_usb_msd =3D {
     .name =3D "usb-storage",
     .version_id =3D 1,
@@ -597,9 +638,11 @@ static void usb_msd_class_initfn_common(ObjectClass *kla=
ss, const void *data)
     uc->handle_reset   =3D usb_msd_handle_reset;
     uc->handle_control =3D usb_msd_handle_control;
     uc->handle_data    =3D usb_msd_handle_data;
+    uc->unrealize      =3D usb_msd_unrealize;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     dc->fw_name =3D "storage";
     dc->vmsd =3D &vmstate_usb_msd;
+    device_class_set_props(dc, msd_properties_common);
 }
=20
 static const TypeInfo usb_storage_dev_type_info =3D {
diff --git a/include/hw/usb/msd.h b/include/hw/usb/msd.h
index 125d2c218f..1920938a20 100644
--- a/include/hw/usb/msd.h
+++ b/include/hw/usb/msd.h
@@ -41,6 +41,8 @@ struct MSDState {
     bool commandlog;
     SCSIDevice *scsi_dev;
     bool needs_reset;
+    uint16_t vid, pid;
+    char *manufacturer, *product;
 };
=20
 typedef struct MSDState MSDState;
@@ -53,3 +55,4 @@ void usb_msd_command_complete(SCSIRequest *req, size_t resi=
d);
 void usb_msd_request_cancelled(SCSIRequest *req);
 void *usb_msd_load_request(QEMUFile *f, SCSIRequest *req);
 void usb_msd_handle_reset(USBDevice *dev);
+void usb_msd_init_desc(USBDevice *dev);
--=20
2.49.1

