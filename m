Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C04FC28B2E
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr3K4-0008Kv-O7; Sat, 08 Mar 2025 18:11:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3Jx-0007sR-Bj
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:11:07 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3Jt-0001ZR-BM
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:11:04 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38dcac27bcbso2699897f8f.0
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 15:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741475459; x=1742080259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9qGswFlRD0j2khHR7PT2I53zcxF8+u37OT/9BiqIPFA=;
 b=elg0vGchgLLQ7pA4AfKg0hKX/pf0BeDh98tz/qCQuDKedco3BINOXles5XfB9aujUt
 XIljB5IzLN6Oo/p9EtJhfmAuKGZfJSGm/y+aGyArMHnRZGsAhS4WH/39Zd28ciLX07JB
 poRhxsXxFsBpvO/rGEin3OuzYEBpsnQhRV8RqGCahCv8Vecicfex6oIIadhJUIXBh4UW
 DqosrpeK51QSff4ladJMbIzDw+aWDwsCwJiJSFf3nOK6zSbbhuj0vmh4MuOctboZguva
 YmwHrYAlQanGmoMJme5jcrhzF8lgfKltwuzxyR8LIiRGjzlpBMHsmoa+uefRDSS4zQu8
 7eXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741475459; x=1742080259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9qGswFlRD0j2khHR7PT2I53zcxF8+u37OT/9BiqIPFA=;
 b=Fus8a9tCqBPV05b9+ZL3vYv4afEO1am7KdClpMbph0/xdDtwIdyyy7O5A3IKYbRr7u
 FCMEF9m+ZkUu3/+mcFVwfgYhJdCw33T7kA6mfpPI3WRgKM12nhKyUSl77YqOKAvrWo9D
 CX1AKpsMy4q/Xtce1i5tCbEpawIGh7l7CZRmvOr0o7geEqHcKJugBg95MYTUYSZj0G5h
 XQ+WIYRah3Gmhus/PxHkBxneQAdX3RrAEvFRg1shYRH7Uo0mecwGjFH/dajAg/2/nqhe
 LiFjdS7EJ1C9sGR3H9dXqLkV5JI9fCb5jAOBfdHQQf2ErkvdECH7us7rVQvseQ2bdy8M
 IQiw==
X-Gm-Message-State: AOJu0YxTVdNlqdNb+IZY4TT4kJyVGTJVVey86Gg5VrG7GpKXY6YdkOkG
 vECo/lb6BZaxiFwZSdDkW7VZ57izN2NPoSk40VCGONHwyd7TGhTguKD8BekW5BZLteOx0BMakEH
 vYVc=
X-Gm-Gg: ASbGncuMEhbFyr/XGAMrrXbsuLYZpOkXiTTmX0P2z6Vf+EIKkakui7Njy0UhS6nOvoS
 60bSJYMhAGg0mhcP9Oa+FQmt3+fsfHAWb26scy0tMN7k7JIAlWWQ2542IaT7WAp+bRFVGD0thlU
 MvkSHy6WREM94HbxMc+C8JHMGODmW9y26rxkcj46XVSwnwPbxX7XCK/0K02+hT2nz/Tz+ezguXr
 jqhQqufld6axbTrnoFUvDUb87iybYnbh4lXa094dqSoXHk+P9fZAJHfeJXYc6vIcWShxmp9guLJ
 q6iD+P20hmNA3Y6X4e/AMuL7CT4M8mtt5Hun4DxTVFICMnGII470I6BlOrnuJt1w3BD4qDpzV8T
 dzI2Ej4TIC6ySsrkh0tc=
X-Google-Smtp-Source: AGHT+IEbpDTd0sPomjcJ6hoJScZQbmBmzr2wv56KE84rBFKzKYjSy1/YKGyelEMd+2MRWVmS4KkUgA==
X-Received: by 2002:a5d:584f:0:b0:391:1218:d5f4 with SMTP id
 ffacd0b85a97d-3913af39bccmr2283871f8f.23.1741475459232; 
 Sat, 08 Mar 2025 15:10:59 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdff72sm10254923f8f.36.2025.03.08.15.10.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 15:10:58 -0800 (PST)
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
Subject: [PATCH v2 17/21] hw/vfio/ap: Check CONFIG_IOMMUFD at runtime using
 iommufd_builtin()
Date: Sun,  9 Mar 2025 00:09:13 +0100
Message-ID: <20250308230917.18907-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308230917.18907-1-philmd@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Convert the compile time check on the CONFIG_IOMMUFD definition
by a runtime one by calling iommufd_builtin().

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vfio/ap.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index c7ab4ff57ad..a4ec2b5f9ac 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -11,7 +11,6 @@
  */
 
 #include "qemu/osdep.h"
-#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
 #include <linux/vfio.h>
 #include <sys/ioctl.h>
 #include "qapi/error.h"
@@ -193,10 +192,11 @@ static void vfio_ap_unrealize(DeviceState *dev)
 
 static const Property vfio_ap_properties[] = {
     DEFINE_PROP_STRING("sysfsdev", VFIOAPDevice, vdev.sysfsdev),
-#ifdef CONFIG_IOMMUFD
+};
+
+static const Property vfio_ap_iommufd_properties[] = {
     DEFINE_PROP_LINK("iommufd", VFIOAPDevice, vdev.iommufd,
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
-#endif
 };
 
 static void vfio_ap_reset(DeviceState *dev)
@@ -234,21 +234,20 @@ static void vfio_ap_instance_init(Object *obj)
     vbasedev->mdev = true;
 }
 
-#ifdef CONFIG_IOMMUFD
 static void vfio_ap_set_fd(Object *obj, const char *str, Error **errp)
 {
     vfio_device_set_fd(&VFIO_AP_DEVICE(obj)->vdev, str, errp);
 }
-#endif
 
 static void vfio_ap_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_props(dc, vfio_ap_properties);
-#ifdef CONFIG_IOMMUFD
-    object_class_property_add_str(klass, "fd", NULL, vfio_ap_set_fd);
-#endif
+    if (iommufd_builtin()) {
+        device_class_set_props(dc, vfio_ap_iommufd_properties);
+        object_class_property_add_str(klass, "fd", NULL, vfio_ap_set_fd);
+    }
     dc->vmsd = &vfio_ap_vmstate;
     dc->desc = "VFIO-based AP device assignment";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
@@ -261,11 +260,11 @@ static void vfio_ap_class_init(ObjectClass *klass, void *data)
     object_class_property_set_description(klass, /* 3.1 */
                                           "sysfsdev",
                                           "Host sysfs path of assigned device");
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
 }
 
 static const TypeInfo vfio_ap_info = {
-- 
2.47.1


