Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A201C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 13:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thTum-0000nV-5D; Mon, 10 Feb 2025 08:33:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thTtS-0008OW-Nn
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 08:32:16 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thTtP-0006AL-UJ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 08:32:09 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43946b5920cso4900475e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 05:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739194326; x=1739799126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tRDqbtanMlA5Asve4v+RadDNokWUtgjMp7wgM0p7V4g=;
 b=qhxDxgjvqblrHa7CRS/SgJ2Vd7oTFjEspKuvDAHduUNiZ/VWkn3wbMCwoCiL5GZLjl
 y9k5qxh3WdD+dR8Q8hFjxyBWLxJ9dZ0kIVwYGFfr7lDOlZM7HWKs32IkvxMr7uqSF08j
 TUvqJIaYgMRak0e9vR+n6NGWgn7IFV5pqX6iJZat2vx1LMa2sxIDLTxyLtpC3GUIut00
 phAf/UJI4IKjeSRx6BlYm0L0+MQnsMEqK8yZ+xTEtkO3IPvvz+Vq75WJ0jdywbWZZlTq
 WZ4mAWgFRvhBJkjPHcmbozyqylcYaIw2jzqAB0vlVHGymUnmN2Wwg9irhq0S6m7vxfDY
 uUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739194326; x=1739799126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tRDqbtanMlA5Asve4v+RadDNokWUtgjMp7wgM0p7V4g=;
 b=oVnjvJfiDULQKsQ5KZHZmyNhCR4BT4Nr4p36P1ejDrBFCr4KWDxXzznmxCRcp3XG7T
 5NDn4+NUTDrqqegANbKOdiLK6SGTrvHfP4bjJQg+e3yiwcKkJUPEwriZP9qZlfrwwOOn
 DYuxYo7iCGk1A1c16BIxfWF6ugpD9gjjb1Ou+Zd7V75H9nbuPbXKgFW9KxjpcYn8hNZ2
 ODk+9ogosWs7OIK1kRJMeCOyjpCYfj9F/uJxyIVfMEMce7ZSSGfOZm4SxEjxxPqreOzP
 2NXNMYVHQllLOr5d7gZ67QSZ50Tx6YwZn5Q3x4WtHy1rkSBMCDzKk4gPyA02+pwWDYoy
 RJVw==
X-Gm-Message-State: AOJu0Yxn4yx0aMwU/Nm9CtMCNpLJuNA5aG89n3vVnR7s2s/CjgDwfJb/
 +6MNkL7Q4ayKOCav7fL0m82KlKT5WB9Si1k1yZbq16JDBPZzCLD+WiF9716dww0lHtnrSDSKakJ
 D5bo=
X-Gm-Gg: ASbGnctDD19oNMAWWt4guuysEIYjSyQO5qBFIqpIn5scoPoZSg4jv8oVoUgGAW75BTq
 3+vw8jc252+HSHfnXtNCoqBGapyPeBA5NeJyNq1A/5EecOIELybnXnJfDLohaXaAoIb82Z1DO/N
 RjgwblZ1rdAH6iTf0sotPUYJ0IvJ7utcNPlLWdCj0xsSFF7li5s5YCYq4JIC7dwtKK77lbRHGHj
 H5UglIORqI/7NgjWeP8Xf70GNRwUpbpry1wBnYvTZ9vSXTB42QXKz6A/dosZSrkgo3dGJcNDMnR
 UuPGrbxEALkYeylPJ3NGIk1zYs23Ml7NMeZqJuKWoPxYghKT2m9EAohyH+o7LESr1WGlDAw=
X-Google-Smtp-Source: AGHT+IFzsz880LtYmACqmfTNeXfWjUlEIDGbcMekFpIU7IYI0n1irn3TSeUvIgJArYyrk8VQD6EjLg==
X-Received: by 2002:a05:600c:3849:b0:439:4a1f:cf8b with SMTP id
 5b1f17b1804b1-4394a1fd551mr18132165e9.0.1739194325647; 
 Mon, 10 Feb 2025 05:32:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d94dd1esm183301635e9.16.2025.02.10.05.32.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 05:32:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 06/11] hw: Declare various const data as 'const'
Date: Mon, 10 Feb 2025 14:31:29 +0100
Message-ID: <20250210133134.90879-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210133134.90879-1-philmd@linaro.org>
References: <20250210133134.90879-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/isa/vt82c686.c     | 2 +-
 hw/rtc/m48t59-isa.c   | 2 +-
 hw/rtc/m48t59.c       | 2 +-
 hw/sensor/tmp421.c    | 2 +-
 hw/usb/hcd-ehci-pci.c | 2 +-
 hw/usb/hcd-uhci.c     | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 6f44b381a5f..43bd67eeef2 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -224,7 +224,7 @@ static void via_pm_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
-    ViaPMInitInfo *info = data;
+    const ViaPMInitInfo *info = data;
 
     k->realize = via_pm_realize;
     k->config_write = pm_write_config;
diff --git a/hw/rtc/m48t59-isa.c b/hw/rtc/m48t59-isa.c
index 38bc8dcf100..9c3855a3ef1 100644
--- a/hw/rtc/m48t59-isa.c
+++ b/hw/rtc/m48t59-isa.c
@@ -129,7 +129,7 @@ static void m48txx_isa_class_init(ObjectClass *klass, void *data)
 static void m48txx_isa_concrete_class_init(ObjectClass *klass, void *data)
 {
     M48txxISADeviceClass *u = M48TXX_ISA_CLASS(klass);
-    M48txxInfo *info = data;
+    const M48txxInfo *info = data;
 
     u->info = *info;
 }
diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
index c9bd6f878fe..3fb2f27d9d1 100644
--- a/hw/rtc/m48t59.c
+++ b/hw/rtc/m48t59.c
@@ -639,7 +639,7 @@ static void m48txx_sysbus_class_init(ObjectClass *klass, void *data)
 static void m48txx_sysbus_concrete_class_init(ObjectClass *klass, void *data)
 {
     M48txxSysBusDeviceClass *u = M48TXX_SYS_BUS_CLASS(klass);
-    M48txxInfo *info = data;
+    const M48txxInfo *info = data;
 
     u->info = *info;
 }
diff --git a/hw/sensor/tmp421.c b/hw/sensor/tmp421.c
index 82e604279c5..007f7cd018b 100644
--- a/hw/sensor/tmp421.c
+++ b/hw/sensor/tmp421.c
@@ -68,7 +68,7 @@ struct TMP421State {
 
 struct TMP421Class {
     I2CSlaveClass parent_class;
-    DeviceInfo *dev;
+    const DeviceInfo *dev;
 };
 
 #define TYPE_TMP421 "tmp421-generic"
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
index d410c38a8a2..e00316721ac 100644
--- a/hw/usb/hcd-ehci-pci.c
+++ b/hw/usb/hcd-ehci-pci.c
@@ -182,7 +182,7 @@ static void ehci_data_class_init(ObjectClass *klass, void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
-    EHCIPCIInfo *i = data;
+    const EHCIPCIInfo *i = data;
 
     k->vendor_id = i->vendor_id;
     k->device_id = i->device_id;
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 8528d493d63..0561a6d801a 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -1289,7 +1289,7 @@ void uhci_data_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
     UHCIPCIDeviceClass *u = UHCI_CLASS(klass);
-    UHCIInfo *info = data;
+    const UHCIInfo *info = data;
 
     k->realize = info->realize ? info->realize : usb_uhci_common_realize;
     k->exit = info->unplug ? usb_uhci_exit : NULL;
-- 
2.47.1


