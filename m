Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6967FC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr3L0-0001gv-Sw; Sat, 08 Mar 2025 18:12:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3KD-0000Ws-8V
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:11:24 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3KA-0001cc-35
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:11:20 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39130ee05b0so1688723f8f.3
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 15:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741475476; x=1742080276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Krkj4W9PXI2bbr9HKRBnaek4mFUNomZTUnghoZDAa+8=;
 b=os90LoBHFlka3zPbfNT7wB5Zrq4F7WLIMNC9IUBxaQRU1WgWC++RMljkQPwG541nbd
 fDzZiNraVncksdDFS3kbX2vCzxhr1pUlwW1m/mKFLxVfsDxJRzyXc1N9cskXKuPYhFul
 wwIS4zA6rDVsOsuVOerPoIzU4JcnXfXIRXeZA3KysHJ9MTKFfH9FceZOQ7Bn76I/9gLN
 jdmt5Uh7amXLAZxHFF1BvROWVwkLRjL0pcCKIksFj9d+b7IU9UVbUQd6HoJKuZ5FLylY
 NjYpfS9z0YfGVLrF5F3RLNwQMECrSI0XErn0Gt2+1e+7aBzj69ARcWcUSuVLQeV+EYsH
 90Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741475476; x=1742080276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Krkj4W9PXI2bbr9HKRBnaek4mFUNomZTUnghoZDAa+8=;
 b=pzTNBmfpUN8oNkx2V6Jr9Pn+QjRrHRJAuhtu+hF+AmaLJVloSrNhwktaI/WIV6692L
 ij8CV7oyDZYDxT1gPE5kAvpAC5MWS6bk0GJb7ZWF1dM/8tmKxWhi4UYkhEj2FogU5OhY
 t5Z4SZyhFqJ+mSaRgftInDN93Xw+tswMketH+g9gM7TzJeCrcFYAvYJYI7vGlE+cRtoV
 PxCuGZ2aJoV1y3cQ/YnB+USpjpoecAoiqjyqgykzIOHGiPQh2eRXdJuDIEnstEWiVlXj
 5ahc1r2lXwUYyjj2dLtp+KLIi093yPnaRR4m9ldVRrSqWA9xL4Qo6r9Opw7NGtq6fwTJ
 2NKw==
X-Gm-Message-State: AOJu0YyFGgiD8l5aI+7YVCvgmvQOurt9S1NAKtfIXzoVtuzXySm/MYHo
 4S2TcfadeMKDEFxGJ/aKdwvp0vcEZg4kvjioKbYKuFfjOHzOebRg2OGtN3YPkrrPGGLr2GwPC7V
 pBLw=
X-Gm-Gg: ASbGncvqUP7SK6dmvIscy9PWhGGjXHVmGC0tUbyn26SEJ9UMghTV4C1njc5eyX2flQs
 IAzub4nap4e6LqUZHXpMeLkZgoiTi5S72vP18y1L53uiAjwy/13YORfveiWI+xPw5vv0NB26J+6
 wlmVdwkTVD29nZTPqdGTJh8nXLkunmdCIU59aybwG9aynUkWU0AVAhy/X1EWb4YG0MgyvM7XsZW
 VaZi37CmYSHAsCr3uQCxLtyhe60UPHarGoduiNSzFA32i1ubsoJxEb/O+3ULd4feH0+y/xX36zw
 iiMFRV1LPmjf1pFJyUlBLDqOlwpf2u9UC/2WAOAmE/xQPLPsX2q9JBUlOrxXvDZaXKVN28GffWN
 OVdVTalNFBCd/FfHH/Zo=
X-Google-Smtp-Source: AGHT+IEi5WAhR9L6pJSrF/tDnKMBfesHPV2+gJAeMrFmEGRf8Nfb1OcWHH46hcW/pc42V1sIDxqOTg==
X-Received: by 2002:a5d:598f:0:b0:391:412b:e22b with SMTP id
 ffacd0b85a97d-391412be5e4mr1168437f8f.18.1741475476383; 
 Sat, 08 Mar 2025 15:11:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01de21sm10233750f8f.59.2025.03.08.15.11.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 15:11:15 -0800 (PST)
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
Subject: [PATCH v2 20/21] hw/vfio/platform: Check CONFIG_IOMMUFD at runtime
 using iommufd_builtin
Date: Sun,  9 Mar 2025 00:09:16 +0100
Message-ID: <20250308230917.18907-21-philmd@linaro.org>
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
 hw/vfio/platform.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 67bc57409c1..265c550b747 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -15,7 +15,6 @@
  */
 
 #include "qemu/osdep.h"
-#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
 #include "qapi/error.h"
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
@@ -637,10 +636,11 @@ static const Property vfio_platform_dev_properties[] = {
     DEFINE_PROP_UINT32("mmap-timeout-ms", VFIOPlatformDevice,
                        mmap_timeout, 1100),
     DEFINE_PROP_BOOL("x-irqfd", VFIOPlatformDevice, irqfd_allowed, true),
-#ifdef CONFIG_IOMMUFD
+};
+
+static const Property vfio_platform_dev_iommufd_properties[] = {
     DEFINE_PROP_LINK("iommufd", VFIOPlatformDevice, vbasedev.iommufd,
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
-#endif
 };
 
 static void vfio_platform_instance_init(Object *obj)
@@ -652,12 +652,10 @@ static void vfio_platform_instance_init(Object *obj)
                      DEVICE(vdev), false);
 }
 
-#ifdef CONFIG_IOMMUFD
 static void vfio_platform_set_fd(Object *obj, const char *str, Error **errp)
 {
     vfio_device_set_fd(&VFIO_PLATFORM_DEVICE(obj)->vbasedev, str, errp);
 }
-#endif
 
 static void vfio_platform_class_init(ObjectClass *klass, void *data)
 {
@@ -666,9 +664,10 @@ static void vfio_platform_class_init(ObjectClass *klass, void *data)
 
     dc->realize = vfio_platform_realize;
     device_class_set_props(dc, vfio_platform_dev_properties);
-#ifdef CONFIG_IOMMUFD
-    object_class_property_add_str(klass, "fd", NULL, vfio_platform_set_fd);
-#endif
+    if (iommufd_builtin()) {
+        device_class_set_props(dc, vfio_platform_dev_iommufd_properties);
+        object_class_property_add_str(klass, "fd", NULL, vfio_platform_set_fd);
+    }
     dc->vmsd = &vfio_platform_vmstate;
     dc->desc = "VFIO-based platform device assignment";
     sbc->connect_irq_notifier = vfio_start_irqfd_injection;
@@ -692,11 +691,11 @@ static void vfio_platform_class_init(ObjectClass *klass, void *data)
     object_class_property_set_description(klass, /* 2.6 */
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
 
 static const TypeInfo vfio_platform_dev_info = {
-- 
2.47.1


