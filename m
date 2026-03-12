Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A72A106ACEF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 22:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0omN-00076h-In; Thu, 12 Mar 2026 18:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0omC-000721-Oh
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 18:45:09 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0om9-0003EY-Tt
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 18:45:08 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-35691a231a7so905715a91.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 15:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773355504; x=1773960304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N4ZUK5OdFX1Uj62uUQzKpHzS+GcZQqU09JoP5tVMW5I=;
 b=D21tqW/cJdbo/fR3RpkS+a3fQCmdBprFii0FPMaU+yGJnY13Ar8/3WoET6NH5fh1Di
 OvNZYcNIvg9Oz6jZcldlA8fprGTE32G+6mNAzvDBwpyQmcv9sMBxdWagjeZkFo50jmSk
 X3nuWX/pRi0a1pCfT/X7IRKSs0A5zZlKFVFMdVTw1DkhB6tIVztmrGIWP/X4nidi+mI7
 6DuRamcl9+pV1EpP0k2xZV27wWdOruZFs7n0SgAedH5rrSkcdxN2rN06mxi5LuqdzU1I
 hz6AHQ6JJhS9MzF5tB4J6LcQ02IM2XT8afZVbYUBTNKphLHrkVlbTGin0rEzJglbpKAL
 D/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773355504; x=1773960304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N4ZUK5OdFX1Uj62uUQzKpHzS+GcZQqU09JoP5tVMW5I=;
 b=cuh2JFsHkyJWLFKOUmmO1R78+bpz3sAvjuN+PtZhG8h9Mmo7c/a63DXe4yAmRz9KQr
 tIJDkH51jRUZW23yQL5iePbkkdXzzpHSTdb7ARsWK2KEZKOmhWWISgrjYSRDUO5e3W4I
 LMNBUp/vlClOZojF/vXbgAjlws96IVKbvmzin4PRsKd9obS31b2gkxYNx8wxAQQarHOf
 G8Kbn+eBL/cB1Wi6TvWwuM2NnbHEajcFizMLgohGLXvF0PfpJuyh8qeCZXxYoBf8sWzH
 syxP5SJQQpQRjTkdC4ykpFfBc4eTld+AuqSTjvGfAjNWprlYinXvPDkBcQzNqSJREXRk
 5ZlQ==
X-Gm-Message-State: AOJu0Yw1lwlTUulYaaXfgjX1RJcC6C+1UgWbVMkF7GR3uoQZe2KPhNE0
 n3iFRF/t0qjvVCeKLsbz3nhFvhd8wwKdFEUtTydWjcHIDl3xvjpSAcFp2Taqt/vnZPiXXpgyALq
 qgqnAr7M=
X-Gm-Gg: ATEYQzzU3KoVE7mO6QQp7taw2XfMT2WknxI+hXA98s3I0vPlgy3IagYkju0nC5sj085
 evABOmQDzy8nwdrCHQbGiCcFzr4l2+yr7a0pA5yNTUXjj1H1B8yo+oEu0+ssJaEQ29buRcJJY62
 KkXHHKpqyt1BiPOCekYa0fpV7EIEGIIzVWPBrsSZiGtl06NPrPHLkQAiwpHiUExziE/IuN8YxfK
 sTn3lGW6BeWlLQK/CpWupGj9I6GJuIYerVVZn2nWHRkjzEkP75LL2Y3OcECVIw1ZwnBW3hjuxRJ
 KxrksC/4hXM8zJGKzv7X3S/75hxxnc7WLWczW4l+lfaDiH53E0wSIlKkx+zUArSl1blV0tSbtd+
 N757tr/CfvsDeqmwe80/GRbZkYmO20KAe8k+krxY8Z8Y172CILeV4k8p2kWJ9hKiUTLHZ3TQwpP
 CPx3k8mlzUAGXvLLiUZ1/J8lgtE7BsQyWrf1iNFkqrJGLixSADI/TCWTwUApBVYfhV8ltPc6wAr
 mVt
X-Received: by 2002:a17:903:24f:b0:2ae:826f:2c50 with SMTP id
 d9443c01a7336-2aeca9411edmr8672495ad.12.1773355504346; 
 Thu, 12 Mar 2026 15:45:04 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece7ed9cdsm128215ad.60.2026.03.12.15.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 15:45:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 4/8] hw/vfio: eradicate CONFIG_IOMMU from sources
Date: Thu, 12 Mar 2026 15:44:45 -0700
Message-ID: <20260312224449.1605071-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

As pointed in c1139fa4 "vfio/iommufd: Remove CONFIG_IOMMUFD usage",
iommufd presence can be detected at runtime (through /dev/iommufd) and
we don't need to isolate this at build time.

It's much (much) more simple to expose this inconditionally compared to
build dynamically properties arrays.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/vfio/ap.c  |  9 ---------
 hw/vfio/ccw.c |  9 ---------
 hw/vfio/pci.c | 11 -----------
 3 files changed, 29 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index e58a0169af9..856fa2678cd 100644
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
index 2251facb356..c66f42a13c2 100644
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
index 94c174a773f..df617f1fe46 100644
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
2.47.3


