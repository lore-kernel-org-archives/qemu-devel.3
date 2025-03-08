Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D1FC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr1tB-0000PJ-20; Sat, 08 Mar 2025 16:39:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr1rZ-0005i7-AX
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:37:44 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr1rW-0003yy-72
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:37:41 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43bc638686eso25105915e9.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741469856; x=1742074656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M76BvQDiEF2f2PItQcUpRY11DWy0Vj4F0agjAvaV/Ks=;
 b=Ci72cBwx9CrTNogSl7s0Ch6ssFrfRmez7YqnXyaSNXgxCraWrVJOUn8GQ9PMBBYfTw
 wJ2/M9Un8rcR9DxgW492FgNVHmQsSlhruXC7lAeNfmbbJujS23WEQ99wThZ5MTMnnoNL
 GhoPG4FkzdEPv41PSPgGeANkLVoQptI2VTMuNSGo2R2qHoUzkQ9rtxzAbS3xDrtgPMvW
 7i2AJhUa5wmUDNl5IdaTyl5YpNnXuFl+BbMjeNSNyBBtxJWkX09L4OvHTfH9hYd0zyYs
 LYlXIlnZyPlZ3jZeHfzdG1DXBmZLFTYXatK/k7WHqt8ANB/ThijwT/r2VA7Fx64t7jve
 Yc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741469856; x=1742074656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M76BvQDiEF2f2PItQcUpRY11DWy0Vj4F0agjAvaV/Ks=;
 b=JIV0BaPtRaTr8v7FzqNHjxqJgXRin9tuTItSD+Y3lZ7u+R5HaJCRQEItRhsMJjzauy
 Epx+76p2tj2sGndx125r0I9KZf9AvmBJV8sIzHk1DRN8eeNejGq4SXp/LHdWRuAYF7wt
 z83hA2UaMD3Fb1IXpV3squAsyWkQEBWlzK4AXncVgMXTZEpQBQ3OWYW+n5TMZ3pOIKgu
 WHc+nUKIYfkM30ahSAMsHT27E7pzTB2QBTJ0j7oke6MNra6lFipNKpXhiKGziVaLab/N
 MCBai04nV79GIcaj+kHD72JXlEqyk7l1AGBICf8HxfclngHL9c99WjPlciS3eTrInLfJ
 ccKw==
X-Gm-Message-State: AOJu0YyjTqDlIgiwx1TGRLDlVwjyfrEMkYW9cglGHQtJDkXOtmHv6gnD
 uLsi10toneZkkogH2NDRtz8jfuBaOF9e5qV6u4FcC0+CsY+TqZHwn/WV10tQANA8rsai7MR84SP
 YL0Y=
X-Gm-Gg: ASbGncvzVCP9gHIUiHbIwXMcWKUBfDovAon58p9ose9MGT9ornXYEVAM5IKpPh7YkTQ
 hnMVqjp32yPkZogIJ0X7t7NqXQf3eDRse3Cb0MX6tf+PTCYilz2MLRyQpxXBFaYgEyuGxgHeQJi
 PN21715F1w/2aIRi9NslHbMw1t/joez0LfmWHpJx5jc7oq6ClqkkFKvpkWPFkP3Smuk5sgQRiRd
 4Iw0YJbtIgl6cgDZjJ3TzcxoIZarYCAU6ZJeCD/vDK8LLVoQ0w19Cmf4VYUydxHxdMpsOLsIIKl
 oMJV2oRSAqAXK6ho/Uw0chgE8zMmlpinLNjw6B+wt2lTvObVTdsrCmuq2DvtRIcFn+mmXJd1TOC
 kLnB4NhJDBvDLQjuEEoU=
X-Google-Smtp-Source: AGHT+IG7/T/yYK0P/Qt6v6nopiQ+iQxqQ74UC0nEv5yTSum3SPI76m0TG4Z8buebRdmL2kbGbjdDlg==
X-Received: by 2002:a5d:64ab:0:b0:390:f9d0:5e7 with SMTP id
 ffacd0b85a97d-3913af025b1mr2945488f8f.13.1741469855895; 
 Sat, 08 Mar 2025 13:37:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bee262esm9903118f8f.0.2025.03.08.13.37.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 13:37:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Guenter Roeck <linux@roeck-us.net>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org
Subject: [PATCH v4 10/14] hw/sd/sdhci: Convert SDHCIState::endianness to
 EndianMode
Date: Sat,  8 Mar 2025 22:36:36 +0100
Message-ID: <20250308213640.13138-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308213640.13138-1-philmd@linaro.org>
References: <20250308213640.13138-1-philmd@linaro.org>
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

EndianMode enum is preferred over DEVICE_BIG/LITTLE_ENDIAN
values because it is a QAPI type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci-internal.h | 3 ++-
 include/hw/sd/sdhci.h  | 3 ++-
 hw/ppc/e500.c          | 2 +-
 hw/sd/sdhci-pci.c      | 2 +-
 hw/sd/sdhci.c          | 7 ++++++-
 5 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 9072b06bdde..c459279f3f3 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -24,6 +24,7 @@
 #ifndef SDHCI_INTERNAL_H
 #define SDHCI_INTERNAL_H
 
+#include "hw/qdev-properties-system.h"
 #include "hw/registerfields.h"
 
 /* R/W SDMA System Address register 0x0 */
@@ -308,7 +309,7 @@ extern const VMStateDescription sdhci_vmstate;
 #define SDHC_CAPAB_REG_DEFAULT 0x057834b4
 
 #define DEFINE_SDHCI_COMMON_PROPERTIES(_state) \
-    DEFINE_PROP_UINT8("endianness", _state, endianness, DEVICE_LITTLE_ENDIAN), \
+    DEFINE_PROP_ENDIAN("endianness", _state, endianness, ENDIAN_MODE_LITTLE), \
     DEFINE_PROP_UINT8("sd-spec-version", _state, sd_spec_version, 2), \
     DEFINE_PROP_UINT8("uhs", _state, uhs_mode, UHS_NOT_SUPPORTED), \
     \
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 60a0442c805..a91cda16cbe 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -25,6 +25,7 @@
 #ifndef SDHCI_H
 #define SDHCI_H
 
+#include "qapi/qapi-types-common.h"
 #include "hw/pci/pci_device.h"
 #include "hw/sysbus.h"
 #include "hw/sd/sd.h"
@@ -95,7 +96,7 @@ struct SDHCIState {
 
     /* Configurable properties */
     bool pending_insert_quirk; /* Quirk for Raspberry Pi card insert int */
-    uint8_t endianness;
+    EndianMode endianness;
     uint8_t sd_spec_version;
     uint8_t uhs_mode;
     /*
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index fe8b9f79621..e85e000f054 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -1042,7 +1042,7 @@ void ppce500_init(MachineState *machine)
          */
         dev = qdev_new(TYPE_SYSBUS_SDHCI);
         qdev_prop_set_uint8(dev, "sd-spec-version", 2);
-        qdev_prop_set_uint8(dev, "endianness", DEVICE_BIG_ENDIAN);
+        qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_BIG);
         s = SYS_BUS_DEVICE(dev);
         sysbus_realize_and_unref(s, &error_fatal);
         sysbus_connect_irq(s, 0, qdev_get_gpio_in(mpicdev, MPC85XX_ESDHC_IRQ));
diff --git a/hw/sd/sdhci-pci.c b/hw/sd/sdhci-pci.c
index 5f82178a76f..49c4f0478b4 100644
--- a/hw/sd/sdhci-pci.c
+++ b/hw/sd/sdhci-pci.c
@@ -32,7 +32,7 @@ static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
     SDHCIState *s = PCI_SDHCI(dev);
 
     sdhci_initfn(s);
-    qdev_prop_set_uint8(DEVICE(dev), "endianness", DEVICE_LITTLE_ENDIAN);
+    qdev_prop_set_enum(DEVICE(dev), "endianness", ENDIAN_MODE_LITTLE);
     sdhci_common_realize(s, errp);
     if (*errp) {
         return;
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 23af3958a1d..f2bb612c665 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1437,7 +1437,12 @@ void sdhci_common_realize(SDHCIState *s, Error **errp)
     const char *class_name = object_get_typename(OBJECT(s));
     unsigned ops_index;
 
-    ops_index = s->endianness == DEVICE_BIG_ENDIAN ? 1 : 0;
+    if (s->endianness == ENDIAN_MODE_UNSPECIFIED) {
+        error_setg(errp, "%s property 'endianness'"
+                         " must be set to 'big' or 'little'", class_name);
+        return;
+    }
+    ops_index = s->endianness == ENDIAN_MODE_BIG ? 1 : 0;
 
     s->io_ops = sc->io_ops ?: &sdhci_mmio_ops[ops_index];
     if (s->io_ops->endianness != sdhci_mmio_ops[ops_index].endianness) {
-- 
2.47.1


