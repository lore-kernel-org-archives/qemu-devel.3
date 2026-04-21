Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C32F8FA90
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFE55-0004wf-DP; Tue, 21 Apr 2026 12:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wFE40-0004aH-OY
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:35:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wFE3s-0007Mq-M0
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776789296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2aZygv18QyrraI5duFZEhvUtiCLkK2qjW57P+380aKo=;
 b=AG5TuopoTuE4HxjjbmpCQwLgjEJVpuZqGtTOj7fs1ciu+1H0yTykPV4xI45SXpiMiFpJrD
 yFhq+0DPmYvygnVpubl41A6NhemivZOx+0Zr+spZeiwt4XLmj0Kq+KUIJFSlADEkL6hFpe
 M249d8zTLQJK2chP8jSgloniI/spZpQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-GbRd4z22OHe5gd_rHo0WdA-1; Tue,
 21 Apr 2026 12:34:52 -0400
X-MC-Unique: GbRd4z22OHe5gd_rHo0WdA-1
X-Mimecast-MFC-AGG-ID: GbRd4z22OHe5gd_rHo0WdA_1776789291
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 524DB1800345; Tue, 21 Apr 2026 16:34:51 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.70])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 71F9A1956095; Tue, 21 Apr 2026 16:34:49 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/14] hw/vfio: eradicate CONFIG_IOMMU from sources
Date: Tue, 21 Apr 2026 18:34:28 +0200
Message-ID: <20260421163438.3447280-5-clg@redhat.com>
In-Reply-To: <20260421163438.3447280-1-clg@redhat.com>
References: <20260421163438.3447280-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

This commit removes usage of CONFIG_IOMMU in hw/vfio sources, exposing
inconditionally iommufd related properties, which are declared
statically (in const arrays). The alternative to expose them dynamically
is more complex and requires boilerplate to set properties at runtime,
with set_* callbacks and added logic to check if iommufd backend is
available, with no obvious benefit.

One possible difference is that user may see a different error message
when trying to attach a vfio device with a QEMU not supporting iommufd,
without declaring iommufd object associated.

Instead of:
```
$ qemu-system-* -device vfio-pci,host=0000:01:00.0,iommufd=iommufd0
qemu-system-*: -device vfio-pci,host=0000:01:00.0,iommufd=iommufd0: Property 'vfio-pci.iommufd' not found
```
User will now see:
```
qemu-system-aarch64: -device vfio-pci,host=0000:01:00.0,iommufd=iommufd0: Device 'iommufd0' not found
```

However, since declaring the iommufd object is needed, error reported
before and after is still the same:
```
$ qemu-system-* -object iommufd,id=iommufd0 -device vfio-pci,host=0000:01:00.0,iommufd=iommufd0
qemu-system-*: invalid object type: iommufd
```

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260318174733.1717643-5-pierrick.bouvier@linaro.org
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/ap.c  |  9 ---------
 hw/vfio/ccw.c |  9 ---------
 hw/vfio/pci.c | 11 -----------
 3 files changed, 29 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 5c8f3056530c7027670f042ac920bd9e4a3da6e9..be20d7e7dc67f21363863f8c6d8b2a7cdedb8762 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -11,7 +11,6 @@
  */
 
 #include "qemu/osdep.h"
-#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
 #include <linux/vfio.h>
 #include <sys/ioctl.h>
 #include "qapi/error.h"
@@ -279,10 +278,8 @@ static void vfio_ap_unrealize(DeviceState *dev)
 
 static const Property vfio_ap_properties[] = {
     DEFINE_PROP_STRING("sysfsdev", VFIOAPDevice, vdev.sysfsdev),
-#ifdef CONFIG_IOMMUFD
     DEFINE_PROP_LINK("iommufd", VFIOAPDevice, vdev.iommufd,
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
-#endif
 };
 
 static void vfio_ap_reset(DeviceState *dev)
@@ -320,21 +317,17 @@ static void vfio_ap_instance_init(Object *obj)
     vbasedev->mdev = true;
 }
 
-#ifdef CONFIG_IOMMUFD
 static void vfio_ap_set_fd(Object *obj, const char *str, Error **errp)
 {
     vfio_device_set_fd(&VFIO_AP_DEVICE(obj)->vdev, str, errp);
 }
-#endif
 
 static void vfio_ap_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_props(dc, vfio_ap_properties);
-#ifdef CONFIG_IOMMUFD
     object_class_property_add_str(klass, "fd", NULL, vfio_ap_set_fd);
-#endif
     dc->vmsd = &vfio_ap_vmstate;
     dc->desc = "VFIO-based AP device assignment";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
@@ -347,11 +340,9 @@ static void vfio_ap_class_init(ObjectClass *klass, const void *data)
     object_class_property_set_description(klass, /* 3.1 */
                                           "sysfsdev",
                                           "Host sysfs path of assigned device");
-#ifdef CONFIG_IOMMUFD
     object_class_property_set_description(klass, /* 9.0 */
                                           "iommufd",
                                           "Set host IOMMUFD backend device");
-#endif
 }
 
 static const TypeInfo vfio_ap_info = {
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index ce9c014e6a7f23b2eceecc05bc60509ece270e4b..ff6ab9a7408f01b9e64ba06f2c8da4a69fa1f9ff 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -15,7 +15,6 @@
  */
 
 #include "qemu/osdep.h"
-#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
 #include <linux/vfio.h>
 #include <linux/vfio_ccw.h>
 #include <sys/ioctl.h>
@@ -647,10 +646,8 @@ static void vfio_ccw_unrealize(DeviceState *dev)
 static const Property vfio_ccw_properties[] = {
     DEFINE_PROP_STRING("sysfsdev", VFIOCCWDevice, vdev.sysfsdev),
     DEFINE_PROP_BOOL("force-orb-pfch", VFIOCCWDevice, force_orb_pfch, false),
-#ifdef CONFIG_IOMMUFD
     DEFINE_PROP_LINK("iommufd", VFIOCCWDevice, vdev.iommufd,
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
-#endif
     DEFINE_PROP_CCW_LOADPARM("loadparm", CcwDevice, loadparm),
 };
 
@@ -679,12 +676,10 @@ static void vfio_ccw_instance_init(Object *obj)
                      DEVICE(vcdev), true);
 }
 
-#ifdef CONFIG_IOMMUFD
 static void vfio_ccw_set_fd(Object *obj, const char *str, Error **errp)
 {
     vfio_device_set_fd(&VFIO_CCW(obj)->vdev, str, errp);
 }
-#endif
 
 static void vfio_ccw_class_init(ObjectClass *klass, const void *data)
 {
@@ -692,9 +687,7 @@ static void vfio_ccw_class_init(ObjectClass *klass, const void *data)
     S390CCWDeviceClass *cdc = S390_CCW_DEVICE_CLASS(klass);
 
     device_class_set_props(dc, vfio_ccw_properties);
-#ifdef CONFIG_IOMMUFD
     object_class_property_add_str(klass, "fd", NULL, vfio_ccw_set_fd);
-#endif
     dc->vmsd = &vfio_ccw_vmstate;
     dc->desc = "VFIO-based subchannel assignment";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
@@ -713,11 +706,9 @@ static void vfio_ccw_class_init(ObjectClass *klass, const void *data)
     object_class_property_set_description(klass, /* 3.0 */
                                           "force-orb-pfch",
                                           "Force unlimited prefetch");
-#ifdef CONFIG_IOMMUFD
     object_class_property_set_description(klass, /* 9.0 */
                                           "iommufd",
                                           "Set host IOMMUFD backend device");
-#endif
     object_class_property_set_description(klass, /* 9.2 */
                                           "loadparm",
                                           "Define which devices that can be used for booting");
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 1945751ffd44dd129768ac7788f0375b216f1747..1f1f3aaad9a901a087ecad1b5c46e8756b3a6339 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -19,7 +19,6 @@
  */
 
 #include "qemu/osdep.h"
-#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
 #include <linux/vfio.h>
 #include <sys/ioctl.h>
 
@@ -3471,9 +3470,7 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
               ~vdev->host.slot || ~vdev->host.function)) {
             error_setg(errp, "No provided host device");
             error_append_hint(errp, "Use -device vfio-pci,host=DDDD:BB:DD.F "
-#ifdef CONFIG_IOMMUFD
                               "or -device vfio-pci,fd=DEVICE_FD "
-#endif
                               "or -device vfio-pci,sysfsdev=PATH_TO_DEVICE\n");
             return;
         }
@@ -3816,22 +3813,18 @@ static const Property vfio_pci_properties[] = {
                                    qdev_prop_nv_gpudirect_clique, uint8_t),
     DEFINE_PROP_OFF_AUTO_PCIBAR("x-msix-relocation", VFIOPCIDevice, msix_relo,
                                 OFF_AUTO_PCIBAR_OFF),
-#ifdef CONFIG_IOMMUFD
     DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
-#endif
     DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, skip_vsc_check, true),
     DEFINE_PROP_UINT16("x-vpasid-cap-offset", VFIOPCIDevice,
                        vpasid_cap_offset, 0),
 };
 
-#ifdef CONFIG_IOMMUFD
 static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
 {
     VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(obj);
     vfio_device_set_fd(&vdev->vbasedev, str, errp);
 }
-#endif
 
 static void vfio_pci_class_init(ObjectClass *klass, const void *data)
 {
@@ -3840,9 +3833,7 @@ static void vfio_pci_class_init(ObjectClass *klass, const void *data)
 
     device_class_set_legacy_reset(dc, vfio_pci_reset);
     device_class_set_props(dc, vfio_pci_properties);
-#ifdef CONFIG_IOMMUFD
     object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
-#endif
     dc->vmsd = &vfio_cpr_pci_vmstate;
     dc->desc = "VFIO-based PCI device assignment";
     pdc->realize = vfio_pci_realize;
@@ -3944,11 +3935,9 @@ static void vfio_pci_class_init(ObjectClass *klass, const void *data)
                                           "vf-token",
                                           "Specify UUID VF token. Required for VF when PF is owned "
                                           "by another VFIO driver");
-#ifdef CONFIG_IOMMUFD
     object_class_property_set_description(klass, /* 9.0 */
                                           "iommufd",
                                           "Set host IOMMUFD backend device");
-#endif
     object_class_property_set_description(klass, /* 9.1 */
                                           "x-device-dirty-page-tracking",
                                           "Disable device dirty page tracking and use "
-- 
2.53.0


