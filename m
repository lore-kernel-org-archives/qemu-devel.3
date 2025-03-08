Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB9FC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr3Jx-0007pm-BI; Sat, 08 Mar 2025 18:11:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3Jl-0007eo-96
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:10:53 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3Ji-0001XI-4s
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:10:52 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so1623059f8f.3
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 15:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741475448; x=1742080248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rb5Gq5gjoqNir/3li58uEI51RqNLZd7aJ8wRwb3WrW0=;
 b=kbYMerpbu2auPrQgtcwk4ahZFARRoh87Uekzd5/A3BAUEhBMr5xZqc1hRD2SiI7R3+
 UgkizcjzEXcGmQT+vGqQJdlM7fEYQSzp8EybYMTfFiGd9MNDb8K3nazMk1zniP22VZTT
 6i1GxivGAFXk2+2v+Cho0a8PKB1T7rJOxgp6Lx/ef1L672frht/5PS+fxPL9ZTMFV5yt
 2XWb/TPbcIBoKWowLDzua+726N2Tt1Dtau4IEd2Cy+HjhdQ9lUShKbbmpZ7pZL48wuB/
 gzZNQmsn+OYcdMl/tboEAI7mBannDnJesG+o8Y9fZbaZ1BR/1vHJBhczKQEmxWNSX3iM
 cfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741475448; x=1742080248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rb5Gq5gjoqNir/3li58uEI51RqNLZd7aJ8wRwb3WrW0=;
 b=F1oBzDi/C5+QrHXUkS1bRPyzRmxbRI5xKwPxhZOMaPKf0MI3lOb0weveRyZrtgBbMF
 HU0kseP6Blmdjk+c8J5kA5JO0Rf4ue2mE2WVZ5hiZ0ZWC5YxydQWgx+1+8LB0ViacdE+
 A5gs0G1v6quIxd082XOjbZaBIC6D74cXHrZZlglcNTi0U13C9oJgnoBeFyk49ZAMvZ4a
 vVKfkXr+n0DeeSrYUJrQh/B/1d+uA/gEUEe3M+7Z8cMlbrTIlxJ26Az92NG2pAFvrFZF
 empUFXvQzvHQYE+Wl105bnMQYhzqWjZ4CDUzcCC1YNwHAelQu9bRoT4oFj8RIQtLJyHx
 i+JA==
X-Gm-Message-State: AOJu0YxJY0445Lb4zm3wLFYW3rYVVG5w8g5z2lruYiaHNXBPNi2rwk0+
 ylNetwQK6R0cYQJQeute69mOimbl2HbrQwqSYAoiiO7zLKx2IphkYDDgM25kiXStEyUMXcedYuU
 fh6A=
X-Gm-Gg: ASbGnctE3whuypphbV+8a8bngNsgT3uYqQLaBPom9ZUtGvVJL/LOvLc/8KHFf8TjvKY
 oAzgtuyh3oac5Cu+q+Usf7lmdUREiNBy6gFUHSaHvkJbkcO5Uay0pYmzSLxh/Q3045pnYxRaCH5
 rIp+aNisXDSm8TdRpZ8a8SCMkzIwOi4hQby77rQQHVgAIkzozlacqGQgNNEv3YA2B23FrOSjuMl
 gsR0lJv1INtJEw/upRtE52Xr2BdOyaAfh7+qYDMgq/P6Pl/1Mbg8ZtGLBgBUDl/UzvVqdNbXZ7U
 ydMzIGRqxmfw0ougUUvibZ5b+5619DCCk2lphpLibu5nU3TnNI/jGjIQc7PtkMF772zLmByNZ6V
 P/qZxAc704fYhW0Bn/Ds=
X-Google-Smtp-Source: AGHT+IFpyPZ8OHsunTdPUAhz3+hHZqpRzqB+uc+3KU0WeLI4qJr+CM3YEWcq/yPMOmAPEzlWQ4DAbw==
X-Received: by 2002:a5d:588f:0:b0:390:f394:6274 with SMTP id
 ffacd0b85a97d-39132da9214mr5345868f8f.52.1741475448065; 
 Sat, 08 Mar 2025 15:10:48 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfb79fbsm10297840f8f.13.2025.03.08.15.10.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 15:10:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 15/21] hw/vfio/pci: Check CONFIG_IOMMUFD at runtime using
 iommufd_builtin()
Date: Sun,  9 Mar 2025 00:09:11 +0100
Message-ID: <20250308230917.18907-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308230917.18907-1-philmd@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vfio/pci.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

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
-- 
2.47.1


