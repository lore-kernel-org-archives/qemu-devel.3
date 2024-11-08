Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613DFD5C0EF
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 15:47:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9R9k-00054d-8n; Fri, 08 Nov 2024 10:44:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9R9g-0004l6-Nk
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:44:12 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9R9e-0005aR-7S
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:44:12 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-431481433bdso19747435e9.3
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 07:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731080648; x=1731685448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kyIsI+ayDhQ8JXAjdTootbFXVBl2F0/8o1ehUxEHo8k=;
 b=M4MY10mSmR22OwbVtzpR22WBpc/deiOcD2aWQveCDuHimyG1gnTQTiE9l2FllXtRAs
 whEUO6DMgvk8pocE7ReOixv1YZ1jAdXydSqywCYNz8hAj5ro5U+p9/RahJiVNcOk+SdS
 dPI2TQKxBBvMK/KG7eoOfEnc6ezS5BWuEm+R21gs4DpxbKWPVNS/WXwDyOv8SjAn5ert
 56h/8f4Sm0+KoaumreRGijx8PpCQodkxQacuCpVu9KpiHTDzbUiqkkUVN7JhtFRm4hHj
 9dCu9emX9Nu4/40SLaIFWnataIU7BYYON9LKFWDMOJ3kSr8ydk5IWWRZpDouVU+eLnN/
 e/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731080648; x=1731685448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kyIsI+ayDhQ8JXAjdTootbFXVBl2F0/8o1ehUxEHo8k=;
 b=vpUj3Yi7HuUofTDHGkV0isdan9PbZG7kK0rmOZt2sSIgA81186gIYK03jt95nwnToR
 9U3aO1JNzT2VCp7uPGDqiWzrV54jwyOCipQlJ4j/DqiRrf2RfYqSFbt3w1fqFvdaVSFr
 i+2+hRqWfzY2I+I2DDIUlrCbjt1H+gfoMMI5aMefVI2cmS7OrT9ovsZOpcEJrRb+zJRJ
 TF5SOqDZRwCgYltqUVFjuZZuIhGe7G29MSLCUov2AyIDxppwSPO4Oh/qnzvGHyzH67W0
 QiRzgddzZx2Kg5ScnO+QfB8mQqx0CwjTf2eorljbxe6egTIVNcUyC2xjWDYI5P56ac91
 np1Q==
X-Gm-Message-State: AOJu0Yx2ndw6FQChKWN2e+g/QaK7tZCACMsS/7VA2k1Kh2rhInqX/FlH
 l/orMjuF/tPfYWGl3vUQUA5YB1LlMOYYPD3vPJ2bgrtjpR2NMFiFTtaLvJeJtJ6xA+2Ld9/ZTme
 l
X-Google-Smtp-Source: AGHT+IHnDOj/I22QYjLcRlsAGlJFd7/6hutzW1rMRBeCtsnChx2ggyE2P+8OpB+2011eUevUZb2N5w==
X-Received: by 2002:a05:600c:1d1b:b0:42c:a574:6360 with SMTP id
 5b1f17b1804b1-432b7522b25mr27077685e9.29.1731080648330; 
 Fri, 08 Nov 2024 07:44:08 -0800 (PST)
Received: from localhost.localdomain ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6c0414sm106580855e9.23.2024.11.08.07.44.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 08 Nov 2024 07:44:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Anton Johansson <anjo@rev.ng>
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 10/17] hw/arm/xlnx-zynqmp: Use &error_abort for programming
 errors
Date: Fri,  8 Nov 2024 15:43:10 +0000
Message-ID: <20241108154317.12129-11-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108154317.12129-1-philmd@linaro.org>
References: <20241108154317.12129-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

When a property value is static (not provided by QMP or CLI),
error shouldn't happen, otherwise it is a programming error.
Therefore simplify and use &error_abort as this can't fail.

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/xlnx-zynqmp.c | 44 ++++++++++++++------------------------------
 1 file changed, 14 insertions(+), 30 deletions(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index e735dbdf82..1770fb5402 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -689,16 +689,10 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
          * - SDIO Specification Version 3.0
          * - eMMC Specification Version 4.51
          */
-        if (!object_property_set_uint(sdhci, "sd-spec-version", 3, errp)) {
-            return;
-        }
-        if (!object_property_set_uint(sdhci, "capareg", SDHCI_CAPABILITIES,
-                                      errp)) {
-            return;
-        }
-        if (!object_property_set_uint(sdhci, "uhs", UHS_I, errp)) {
-            return;
-        }
+        object_property_set_uint(sdhci, "sd-spec-version", 3, &error_abort);
+        object_property_set_uint(sdhci, "capareg", SDHCI_CAPABILITIES,
+                                 &error_abort);
+        object_property_set_uint(sdhci, "uhs", UHS_I, &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(sdhci), errp)) {
             return;
         }
@@ -714,10 +708,8 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < XLNX_ZYNQMP_NUM_SPIS; i++) {
         gchar *bus_name;
 
-        if (!object_property_set_bool(OBJECT(&s->spi[i])), "little-endian",
-                                      true, errp)) {
-            return;
-        }
+        object_property_set_bool(OBJECT(&s->spi[i]), "little-endian",
+                                 true, &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
             return;
         }
@@ -767,14 +759,10 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     xlnx_zynqmp_create_unimp_mmio(s);
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_GDMA_CH; i++) {
-        if (!object_property_set_uint(OBJECT(&s->gdma[i]), "bus-width", 128,
-                                      errp)) {
-            return;
-        }
-        if (!object_property_set_link(OBJECT(&s->gdma[i]), "dma",
-                                      OBJECT(system_memory), errp)) {
-            return;
-        }
+        object_property_set_uint(OBJECT(&s->gdma[i]), "bus-width", 128,
+                                 &error_abort);
+        object_property_set_link(OBJECT(&s->gdma[i]), "dma",
+                                 OBJECT(system_memory), &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->gdma[i]), errp)) {
             return;
         }
@@ -815,10 +803,8 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->qspi_dma), 0,
                        qdev_get_gpio_in(DEVICE(&s->qspi_irq_orgate), 0));
 
-    if (!object_property_set_link(OBJECT(&s->qspi), "stream-connected-dma",
-                                  OBJECT(&s->qspi_dma), errp)) {
-         return;
-    }
+    object_property_set_link(OBJECT(&s->qspi), "stream-connected-dma",
+                             OBJECT(&s->qspi_dma), &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->qspi), errp)) {
         return;
     }
@@ -837,10 +823,8 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     }
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_USB; i++) {
-        if (!object_property_set_link(OBJECT(&s->usb[i].sysbus_xhci), "dma",
-                                      OBJECT(system_memory), errp)) {
-            return;
-        }
+        object_property_set_link(OBJECT(&s->usb[i].sysbus_xhci), "dma",
+                                 OBJECT(system_memory), &error_abort);
 
         qdev_prop_set_uint32(DEVICE(&s->usb[i].sysbus_xhci), "intrs", 4);
         qdev_prop_set_uint32(DEVICE(&s->usb[i].sysbus_xhci), "slots", 2);
-- 
2.45.2


