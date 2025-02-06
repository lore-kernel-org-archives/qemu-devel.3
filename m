Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9C4C02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 13:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg1fH-00056n-Fg; Thu, 06 Feb 2025 08:11:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg1fF-00055p-Ag
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:11:29 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg1fD-000867-9A
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:11:29 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38da66ce63bso464645f8f.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 05:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738847485; x=1739452285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r3g08ohEQSqeyZw6xIdCyqqo2uAlLNUZF1ZoGaNfqHI=;
 b=QvmxTOgHTmAnid7oFxuDWaPFcHlU2zS29pjJEd/IT9nt8opTgzn1iM4zLvrB1VJznB
 eVSyakxaSmy4Jf5KcR7B2pq0YBxjq2Yl2xDUOWUMUHGAtN7hKtYDfMhUPmpkC8hf/p7Q
 HMReITs2ey6oDclumUerK7ePjvAl39WWfoFS+HMnkLOUL3O1pEzpH3+VcyoTm1xAhsaS
 sp3+KCo569pTd2Vda9I+PGyODCpvrC/bPXqAl5KVe00PB/R/m7RmynGtVVWoquIqLXD6
 LpQ2+4cljAKJFtBCdtIYJvbBWiPxEKCwh8YtpCXRY2FLj7ALuLxCuViQ4KvWxHJgtEkT
 zsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738847485; x=1739452285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r3g08ohEQSqeyZw6xIdCyqqo2uAlLNUZF1ZoGaNfqHI=;
 b=Q0oo/odD/LI6wF1DGSTFAlqe0KZrG+ylz0V4PXL7VzarXpQDhGGIXb9jbwo/E9i0/B
 KaOmJ4FYRH8jzGnTfIzo/uAfNkvGlq+VrI4R6k4RCqUgi9bHvyhHJ3/N/jCuulkd7E2x
 ByxZ7Rwcf3SiR1nYCq53BmHFdpl9kw+IZm+1amjfudJsVT8HW7l8VskgaSRVLk3kfwYp
 IO2mwTxD0LQZX6DqDQuwHL9+UUqXCeaVj4tpccSQ2Q+rAsGfY9XqjP9tx2C+7yGCiZMC
 dcRGzsDrYmiJja2e2PdCcy99KBqZeTo2wBjuBEQr3b77os0s+096I1OY3vPKZPQmWpsz
 n3Jg==
X-Gm-Message-State: AOJu0YxLVCFqVJfBr084fLF3n6d/7qVNBORASJvJBsACj6cGq399ZktI
 Cx6fIlp9u/wyGPklt20LCPtrKfl7laSXEGWRiweY+OjmqrB9oOT70NdhCuRvT5TvIr6LeIyt+BU
 M9YU=
X-Gm-Gg: ASbGncueRks0EhOqK1lMBUj9Fz3p+XJFxO7nvHTA03osdJ8vo+JE7xs9186VElC2/fY
 hcVl/swEiqHsr6orn3jwZcBfxm2tmvYv29EuyafzePRbrDKoO7uX2mK40PmJW7xkohsFqcO0lrY
 JnMAck09Uvm6m7FzyBhae0HlPPdF2SrOiRadEjEwV2k8JfS1EaiZiND9DJEfp3YD/5Iv1P79AvK
 tTXiWzFx/L2gqsImZG85iDUQ3+VeoZcYfMiByPBFe4IpVYfLhg1VmXwg3Cx96KlQ5cVRWg37xza
 VkVGkmsPXvgtJudtsC6oZO0nUslffMBIt+lEbAWWXHFjNG1KK17hp4mg2Xomu6p80g==
X-Google-Smtp-Source: AGHT+IEMKR2UYi/vp77sP4+ry+xOc5EirscmX9kw1fzakpplzFyhm2uBoqySil+1ZZAJ9jbXlc+JZA==
X-Received: by 2002:a05:6000:1546:b0:385:f249:c336 with SMTP id
 ffacd0b85a97d-38db48db20emr4823198f8f.45.1738847485416; 
 Thu, 06 Feb 2025 05:11:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d94d685sm54977725e9.13.2025.02.06.05.11.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 05:11:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 06/16] hw/arm/xlnx-zynqmp: Use &error_abort for programming
 errors
Date: Thu,  6 Feb 2025 14:10:42 +0100
Message-ID: <20250206131052.30207-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206131052.30207-1-philmd@linaro.org>
References: <20250206131052.30207-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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
Reviewed-by: Anton Johansson <anjo@rev.ng>
---
 hw/arm/xlnx-zynqmp.c | 38 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index bd5b0dd5e76..d6022ff2d3d 100644
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
@@ -763,14 +757,10 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
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
@@ -811,10 +801,8 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
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
@@ -833,10 +821,8 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
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
2.47.1


