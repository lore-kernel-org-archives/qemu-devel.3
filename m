Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3297C48BEB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 11:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raw18-0007Nn-DF; Fri, 16 Feb 2024 06:04:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw15-0007BI-2w
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:04:27 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw12-00013E-1b
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:04:26 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33d14a711efso681771f8f.2
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 03:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708081462; x=1708686262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1f6J2H1K9VOhN8YiJnj6i61rwEdmxKhJYj3MwXMwmEA=;
 b=aklU6aCRgVVkS4G4qnszjyTTv5IvY/xbh8JwrkXQjUznalKUIvh7LMV/FuwUMv8qwT
 qPyUkgwuQ1RF9CgV5iEKCgtVjtHoPAghDMs3D4pegzbUspx9nnUV+1y/61YUCwFSelVr
 pYLGNo4POjhX1n7amesa143IGUtbKy3rPZOXozLnJ1wT54xkewGPjn4AGxart7IJ8GXg
 T2ErzLyQ8r9ZrxjweRz5e3yAncECGMHnbh60x6qWIIwnqXd0S7t0peR16jF5KOQZmffW
 IXfOV8bFpTjr50/2VFgVdUPx5Zwms1SuF6/KSqE9P0zCo4NisOwo9Vo66QVKuDon7uCd
 QTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708081462; x=1708686262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1f6J2H1K9VOhN8YiJnj6i61rwEdmxKhJYj3MwXMwmEA=;
 b=cgkEdGwznHfFjPcId8wTg6JTaByRIhU7x1gP7Ey+gErROHLsypfX+ZgZFWgTkum0mR
 ETzS3j3vtHowNLLYPb8JC0r+Eu5x2ScQGUHebMYLUUaB9JJvz2oGY+3c67Vvc33uiv9p
 xpyHs0TmDxawsZPyAC1LOrEE3GtdR9/zDhuueJ+4NswWKTWMjMqnFMe+HHLeHAChFAio
 nMgi0BVoLHTqQX8LmCbuKH68E+TPv+jBtCRqrajvJBs6WGoygV/fteK10E9d1t3M6ZPD
 v7M+a+HceTIWE92x7mKoD7ou1iKfLfHjeNQRXVFMIjYMn/+Z1Qzu1/HyYHb5psu9e7rO
 Iipw==
X-Gm-Message-State: AOJu0YzMF+WKQ7JMJmRv7b0HBAHSOSP+wOCyWzfjSkbY4G1nv/e/+1uq
 gxm72gwFoTv7CP4+o/H9ImM+LpsZxQ4ZMbVrkU+hppVmFMbY+Y6al38PWTmIqOiEx5JUI43Ufbv
 3
X-Google-Smtp-Source: AGHT+IGd+K1Ye21x3B9/fikutK4pHA5/MV8nPoj9xvkFcz4dlQ3vDbllE3JsMEgnq7erpMjwDyfFKw==
X-Received: by 2002:a05:6000:1e8f:b0:33d:2120:1011 with SMTP id
 dd15-20020a0560001e8f00b0033d21201011mr550180wrb.54.1708081462196; 
 Fri, 16 Feb 2024 03:04:22 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 az1-20020adfe181000000b0033d1f992ae3sm1275770wrb.112.2024.02.16.03.04.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Feb 2024 03:04:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH 10/21] hw/usb: Inline usb_new()
Date: Fri, 16 Feb 2024 12:03:01 +0100
Message-ID: <20240216110313.17039-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240216110313.17039-1-philmd@linaro.org>
References: <20240216110313.17039-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Inline the 2 uses of usb_new().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/usb.h    | 1 -
 hw/usb/bus.c        | 9 ++-------
 hw/usb/dev-serial.c | 2 +-
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/hw/usb.h b/include/hw/usb.h
index 32c23a5ca2..2d820685cc 100644
--- a/include/hw/usb.h
+++ b/include/hw/usb.h
@@ -500,7 +500,6 @@ void usb_bus_release(USBBus *bus);
 USBBus *usb_bus_find(int busnr);
 void usb_legacy_register(const char *typename, const char *usbdevice_name,
                          USBDevice *(*usbdevice_init)(void));
-USBDevice *usb_new(const char *name);
 bool usb_realize_and_unref(USBDevice *dev, USBBus *bus, Error **errp);
 USBDevice *usb_create_simple(USBBus *bus, const char *name);
 USBDevice *usbdevice_create(const char *cmdline);
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 148224f06a..a599e2552b 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -329,11 +329,6 @@ void usb_legacy_register(const char *typename, const char *usbdevice_name,
     }
 }
 
-USBDevice *usb_new(const char *name)
-{
-    return USB_DEVICE(qdev_new(name));
-}
-
 bool usb_realize_and_unref(USBDevice *dev, USBBus *bus, Error **errp)
 {
     return qdev_realize_and_unref(&dev->qdev, &bus->qbus, errp);
@@ -341,7 +336,7 @@ bool usb_realize_and_unref(USBDevice *dev, USBBus *bus, Error **errp)
 
 USBDevice *usb_create_simple(USBBus *bus, const char *name)
 {
-    USBDevice *dev = usb_new(name);
+    USBDevice *dev = USB_DEVICE(qdev_new(name));
 
     usb_realize_and_unref(dev, bus, &error_abort);
     return dev;
@@ -693,7 +688,7 @@ USBDevice *usbdevice_create(const char *driver)
         return NULL;
     }
 
-    dev = f->usbdevice_init ? f->usbdevice_init() : usb_new(f->name);
+    dev = f->usbdevice_init ? f->usbdevice_init() : USB_DEVICE(qdev_new(f->name));
     if (!dev) {
         error_report("Failed to create USB device '%s'", f->name);
         return NULL;
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 63047d79cf..6e79c46d53 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -624,7 +624,7 @@ static USBDevice *usb_braille_init(void)
         return NULL;
     }
 
-    dev = usb_new("usb-braille");
+    dev = USB_DEVICE(qdev_new("usb-braille"));
     qdev_prop_set_chr(&dev->qdev, "chardev", cdrv);
     return dev;
 }
-- 
2.41.0


