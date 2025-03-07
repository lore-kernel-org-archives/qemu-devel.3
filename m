Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309A7C28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqc5f-0006YY-Vc; Fri, 07 Mar 2025 13:06:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqc3x-0004LL-Kc
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:04:46 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqc3u-0002Ia-K4
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:04:45 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-390e702d481so1168656f8f.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741370681; x=1741975481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=otdB0Dz5nRAMnlnyGAk6/GxyQibbHb9x6DFoSBTI7l0=;
 b=Tvs8+1q8i7N+avAe1w9JySLJKId9LqyaNg12JeYnWit2UTki8AozYf19g/FM1rGHCC
 HQCn2yPAoC1uRqFzZrXKCMyhuRWM8Cu+dj7XuOlV5h+4xDP3eOYTHAWCoypeSu+Lgijr
 0AHZdPZmW6uTZm/1HLK4siNrv9KwUoIGmrc774WrPoJnYekReo0EYi/jJ3WE6q3xaScK
 hNveDEfe5bWJ9xK7UsQ1pW3aimm6PKl92Aah2q85wUZd3QO/VkxHJjps2kfCP/lmx3oG
 JcZb2l4GH1OSLeFUZRkkwWU1u7crDpETYUg4dYOvZTEvqjcnpkeebjx17JxCCj4FnAWM
 ymgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741370681; x=1741975481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=otdB0Dz5nRAMnlnyGAk6/GxyQibbHb9x6DFoSBTI7l0=;
 b=Mcl8zjK/bt7V3q6QtMjPtM61zgl1J2tZ2cC0mcxBshMm+zBKg/To8fpHCjH2U7IzcN
 r/SvFoz6T6KbAB/qxtV+OhPhq1o/5Rs9Us7zqMA/rYwCnzMzYY0/2z3CMBjsBBuFrHsX
 5o8JulGp8Ri/mLpLqlPPdBrvnmFaLwaoCJYVmz+hGHQMbeGAMDQZhJzg8q6gxQRLPsR+
 xEBrHmI8IWnCCghKmj93H1AHs9xmP4vjww/fPI7PxqsNsVZfPov62qZug4TxV0TY8XND
 /3Vbqk22AUOtthrx89SsXMXqK7kDxoOJ+XlNLrcBHD13Cgyj0PD2Vt017wgyyojilGtx
 dmVQ==
X-Gm-Message-State: AOJu0YwCBY7tiIOB52/HL9OWmw+P1SrpJCFUDsRy3YfqwDhZtm8GOtwE
 sM9cpB7Nk6ekmIZOKIRabtyn5AyyInrlLsETrLUM4PA+TIs99fhQkZ8e3uXiOpTZBhDLLP8dCbt
 /xtM=
X-Gm-Gg: ASbGncs7CSLUZ80WXwl3djVYxsJIYF2x8aVVnHxFaUEEKaa1Ysw3AcWN7rwOThJ8GPb
 Qzb+v9uA6X5E3eiqOGebuigPUScnCKK+2ptMEifQNsPjpH/Dr8SlKDuspCvUg7vxI3Nc+ZYKXEh
 pYLrNw5AkPAeeSQap/lug7MTOLwy4veEbqj6FuIVf6WwUHrZmQ9bWMRnwWA6ryiERUPCq6C09sX
 bDd+EW6FeujlfQQYHDbWEMyGS46tIITIGXYtQQOc/LU60xTrl6zSF87ppC4hwIe9uhbMDir3kuM
 zWzbBmahRLHNmqRR4I8E3OmYnSCiMtwm4vmro8i2keN6HGwqqka35LTeTD0b4o7bUge1H5IQzdW
 nOQHsj8a+vF4WlzQqWIM=
X-Google-Smtp-Source: AGHT+IGoXSQiYR+Znceq9QhV/DA24dcXDFRGzeqHnWry6oSbt2EZw73v5ZrTBEMEOa+RqbZY3pfWWQ==
X-Received: by 2002:a05:6000:4112:b0:391:d52:d042 with SMTP id
 ffacd0b85a97d-39132d883f3mr2410120f8f.32.1741370680523; 
 Fri, 07 Mar 2025 10:04:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8b0425sm58830765e9.3.2025.03.07.10.04.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 10:04:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 11/14] hw/vfio/pci: Check CONFIG_IOMMUFD at runtime using
 iommufd_builtin()
Date: Fri,  7 Mar 2025 19:03:34 +0100
Message-ID: <20250307180337.14811-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307180337.14811-1-philmd@linaro.org>
References: <20250307180337.14811-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Convert the compile time check on the CONFIG_IOMMUFD definition
by a runtime one by calling iommufd_builtin().

Since the file doesn't use any target-specific knowledge anymore,
move it to system_ss[] to build it once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vfio/pci.c       | 38 ++++++++++++++++++--------------------
 hw/vfio/meson.build |  2 +-
 2 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9872884ff8a..e83252766d1 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -19,7 +19,6 @@
  */
 
 #include "qemu/osdep.h"
-#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
 #include <linux/vfio.h>
 #include <sys/ioctl.h>
 
@@ -2973,11 +2972,10 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         if (!(~vdev->host.domain || ~vdev->host.bus ||
               ~vdev->host.slot || ~vdev->host.function)) {
             error_setg(errp, "No provided host device");
-            error_append_hint(errp, "Use -device vfio-pci,host=DDDD:BB:DD.F "
-#ifdef CONFIG_IOMMUFD
-                              "or -device vfio-pci,fd=DEVICE_FD "
-#endif
-                              "or -device vfio-pci,sysfsdev=PATH_TO_DEVICE\n");
+            error_append_hint(errp, "Use -device vfio-pci,host=DDDD:BB:DD.F %s"
+                              "or -device vfio-pci,sysfsdev=PATH_TO_DEVICE\n",
+                              iommufd_builtin()
+                              ? "or -device vfio-pci,fd=DEVICE_FD " : "");
             return;
         }
         vbasedev->sysfsdev =
@@ -3412,19 +3410,18 @@ static const Property vfio_pci_dev_properties[] = {
                                    qdev_prop_nv_gpudirect_clique, uint8_t),
     DEFINE_PROP_OFF_AUTO_PCIBAR("x-msix-relocation", VFIOPCIDevice, msix_relo,
                                 OFF_AUTO_PCIBAR_OFF),
-#ifdef CONFIG_IOMMUFD
-    DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
-                     TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
-#endif
     DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, skip_vsc_check, true),
 };
 
-#ifdef CONFIG_IOMMUFD
+static const Property vfio_pci_dev_iommufd_properties[] = {
+    DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
+                     TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
+};
+
 static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
 {
     vfio_device_set_fd(&VFIO_PCI(obj)->vbasedev, str, errp);
 }
-#endif
 
 static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
 {
@@ -3433,9 +3430,10 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
 
     device_class_set_legacy_reset(dc, vfio_pci_reset);
     device_class_set_props(dc, vfio_pci_dev_properties);
-#ifdef CONFIG_IOMMUFD
-    object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
-#endif
+    if (iommufd_builtin()) {
+        device_class_set_props(dc, vfio_pci_dev_iommufd_properties);
+        object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
+    }
     dc->desc = "VFIO-based PCI device assignment";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     pdc->realize = vfio_realize;
@@ -3540,11 +3538,11 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
                                           "vf-token",
                                           "Specify UUID VF token. Required for VF when PF is owned "
                                           "by another VFIO driver");
-#ifdef CONFIG_IOMMUFD
-    object_class_property_set_description(klass, /* 9.0 */
-                                          "iommufd",
-                                          "Set host IOMMUFD backend device");
-#endif
+    if (iommufd_builtin()) {
+        object_class_property_set_description(klass, /* 9.0 */
+                                              "iommufd",
+                                              "Set host IOMMUFD backend device");
+    }
     object_class_property_set_description(klass, /* 9.1 */
                                           "x-device-dirty-page-tracking",
                                           "Disable device dirty page tracking and use "
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 96e342aa8cb..9a004992c11 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -6,7 +6,6 @@ vfio_ss.add(files(
 vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'pci-quirks.c',
-  'pci.c',
 ))
 vfio_ss.add(when: 'CONFIG_VFIO_CCW', if_true: files('ccw.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_PLATFORM', if_true: files('platform.c'))
@@ -29,4 +28,5 @@ system_ss.add(when: ['CONFIG_VFIO', 'CONFIG_IOMMUFD'], if_true: files(
 ))
 system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'display.c',
+  'pci.c',
 ))
-- 
2.47.1


