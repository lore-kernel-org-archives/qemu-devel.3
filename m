Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39995C02185
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 07:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta8w1-0001bq-34; Tue, 21 Jan 2025 02:44:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ta8w0-0001bg-34
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 02:44:28 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ta8vy-0005av-H0
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 02:44:27 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3863703258fso4162377f8f.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 23:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737445464; x=1738050264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gCByY4xFxKSas0mj1fQXD4ORekE5ijPVfSFdvDNgJM0=;
 b=kZ3VCByrCGzc+z0+NgqfOvs0h5VEe+Byw3fIcPu3X2cYnZuT58qEFCyuVJ1Cffkxw8
 CvcOHFrgVEOLZ+uXvkQtDo4HkVsY8P8iq03aEy9eeNZEBQswH0bG65JyWnnSZTY4F21I
 uFrswMPtNq/AfqJdd7i6E7CK8Uf7PqrPthr/lxToX4+oPUjQnsbdQSdVUBUajCd2gHOx
 e3UA+UJJTSNuJWKplR98A7Cy2B4Dms//Aqct2+eLRFgbXZOtZtlEOeyJ+VCnMU84hnma
 XaFfvPEATbACMdiejCUiv+tGdf6ZGRyYCEn3XE002hyx+mUyXZSbhCsuqDtnJjR1aS1p
 iZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737445464; x=1738050264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gCByY4xFxKSas0mj1fQXD4ORekE5ijPVfSFdvDNgJM0=;
 b=IQeXDrImqDBnMgsTVlZbmfeLLieKjqy51DJZ3eprfwyvzEd5nBMi1d2JwMmAFjO1Cg
 dfb/BJ9lXgPu8n5igO5Z1D371Q2CEZoLYq4vzF/ypmCzZ+nJQrgF4GmXd/XHisGb3YKX
 mPjLS9E37C9cEcXYqIAivP53KXBx7T+yDB0JkHBL+E1hHH5vG2kgO2VqQpX4pmXlq8YV
 sfa2RMVERIdIUBXDAq//hZDlclV4+q+7zWEZ1FhVcEuK57tuV9uZigQdgNsvZWD4nKjA
 fKocKp/CQkCxhcRp5TBIBBMwo8KQHLB/WkZZDeT/Kcdeed4DeeLsrdcHM7gvQ+6mNa3J
 YVyg==
X-Gm-Message-State: AOJu0YxMrVOXKHlx46wmw51VtGq0B2JjxO25ffbV0pxH2KSzg3DMSy2I
 KQ6GJuBebwccrA+NB8YkIE6p5klF0m5eUXnLnTs9C6RgvsPJhtkIrmwLibl0Up45WvP/aN8KoV3
 9BZE=
X-Gm-Gg: ASbGncsKkcA1fJ7bu1BdDocG05Kgt3w9+h6C4AMozi3V2xcrB6ngXiSAHt1zd8Gy4DI
 TPWBztpLIqYGYGk6elguLRCztzGPPHh0TJPb3j0JkuQMULQiKI53H9ljmx3wcfiGHRYrMopDTfC
 6GFPctY+Oo07z0qbhpfuVZtKeWrLOCu+KAIfMZ2srWmgvtafPWFOCi4+GeVcVdocvi2dATwc/2M
 KmpoF4qVoDZD9T2rUds8qkZU8jDXiigrdxwR6Uk9082peRD9tdw0nSwWWWT+VcFcd7diNwTE9uB
 eU0yvHP0cSA0QJqFoApAUjO7ST6n5HYVmQyRgDNWFJZT
X-Google-Smtp-Source: AGHT+IHBGfF2lw1s7z0jLTy9HMMsQBFwcIT+bzXwRduHKmursZYlmsPQrZzuMK/g9Hz8DJi0rvuIrQ==
X-Received: by 2002:a05:6000:1786:b0:38a:8d32:2707 with SMTP id
 ffacd0b85a97d-38bec548925mr21229320f8f.26.1737445464531; 
 Mon, 20 Jan 2025 23:44:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c0f026c0sm120518235e9.0.2025.01.20.23.44.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Jan 2025 23:44:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alberto Garcia <berto@igalia.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] hw/ipack: Remove legacy qemu_allocate_irqs() use
Date: Tue, 21 Jan 2025 08:44:12 +0100
Message-ID: <20250121074412.70292-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121074412.70292-1-philmd@linaro.org>
References: <20250121074412.70292-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

No need to dynamically allocate IRQ when we know before hands
how many we'll use. Declare the 2 of them in IPackDevice state
and initialize them in the DeviceRealize handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ipack/ipack.h | 7 ++-----
 hw/ipack/ipack.c         | 7 +++----
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/hw/ipack/ipack.h b/include/hw/ipack/ipack.h
index cbcdda509d3..14540281496 100644
--- a/include/hw/ipack/ipack.h
+++ b/include/hw/ipack/ipack.h
@@ -12,6 +12,7 @@
 #define QEMU_IPACK_H
 
 #include "hw/qdev-core.h"
+#include "hw/irq.h"
 #include "qom/object.h"
 
 
@@ -19,10 +20,8 @@
 OBJECT_DECLARE_SIMPLE_TYPE(IPackBus, IPACK_BUS)
 
 struct IPackBus {
-    /*< private >*/
     BusState parent_obj;
 
-    /* All fields are private */
     uint8_t n_slots;
     uint8_t free_slot;
     qemu_irq_handler set_irq;
@@ -58,13 +57,11 @@ struct IPackDeviceClass {
 };
 
 struct IPackDevice {
-    /*< private >*/
     DeviceState parent_obj;
-    /*< public >*/
 
     int32_t slot;
     /* IRQ objects for the IndustryPack INT0# and INT1# */
-    qemu_irq *irq;
+    qemu_irq irq[2];
 };
 
 extern const VMStateDescription vmstate_ipack_device;
diff --git a/hw/ipack/ipack.c b/hw/ipack/ipack.c
index ed75f791832..ef59f5dcd62 100644
--- a/hw/ipack/ipack.c
+++ b/hw/ipack/ipack.c
@@ -55,22 +55,21 @@ static void ipack_device_realize(DeviceState *dev, Error **errp)
     }
     bus->free_slot = idev->slot + 1;
 
-    idev->irq = qemu_allocate_irqs(bus->set_irq, idev, 2);
+    for (int i = 0; i < ARRAY_SIZE(idev->irq); i++) {
+        qemu_init_irq(idev->irq[i], bus->set_irq, idev, i);
+    }
 
     k->realize(dev, errp);
 }
 
 static void ipack_device_unrealize(DeviceState *dev)
 {
-    IPackDevice *idev = IPACK_DEVICE(dev);
     IPackDeviceClass *k = IPACK_DEVICE_GET_CLASS(dev);
 
     if (k->unrealize) {
         k->unrealize(dev);
         return;
     }
-
-    qemu_free_irqs(idev->irq, 2);
 }
 
 static const Property ipack_device_props[] = {
-- 
2.47.1


