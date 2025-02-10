Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF64C0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:47:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thacD-0006Q2-2Y; Mon, 10 Feb 2025 15:42:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thac9-0006Jv-SR
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:42:46 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thac8-0003cr-2p
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:42:45 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38dcf8009f0so1631159f8f.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739220162; x=1739824962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3LSXPak8+leEas4QYcp9RGIXAMu5A0oBZiFnt7dHBD8=;
 b=ae6vc3AK8a6Ap09rdUYv3lWtPvxt6f79Uks8ZCOc4q+AIoe/yCJncy1WdOeFMFrf5d
 V4sEaI4QuRcJTuiZblK4mVcie651Ze+fRLcXlbcuHYi5Gkp/mxzGDXXDjJ2stTpvQ+m2
 ko11iTlybts6QAYdv3yMW1537QuWfGCk3/Uh80nK/y1pDKnfHLHCMtMqcH/zIP25KoIw
 bwMOKhvQrkiuY28pFjHY9QEKr+N/AAGs+/i6tvQQIsCan/1Jxv+YnnRFkvYLFgTaSPkw
 PYSCfl4C8cMoIqp9vveR9rVndXwx6zzjrPT/0MYUE/Vd6NAM7N70+tRsa4OUb5SasKCb
 vLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739220162; x=1739824962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3LSXPak8+leEas4QYcp9RGIXAMu5A0oBZiFnt7dHBD8=;
 b=f2REPg5HYrG5AM5LuQYILsY39JkdFpWWKJpcekYAOW6MxKHPuFWuUGnECLV7UFyGsm
 /kKU36lvxb4PE+r/b+8QKTmrJrhGVl8c9CkWRfmFfjb4ek8gTbiK6aY0wBskFWXzjcBg
 ynZx6T39vVSnRR+krGnHXfy1CRww2b4yG6GG2Orp4t/VGx5ceZ063Vk8196261OAcpux
 VszmSvLAL7yvHmVrzI2N7QRXgFQOVP4lOEnLtvbiHIdzZqzKlpM4abJaXAux3VWE3Z4F
 d7S+5+cKc1QUIMAbXReMXkIJAVJLFU4dmzVbmnFhVBNCfdGaXcVdTEIMNfdrhvLODB9Q
 h5HQ==
X-Gm-Message-State: AOJu0YzesjdLJcWTXAmQS6ZIxA2ns1d7AE4SoVIg/b8JfMVIUDhUNpk8
 00AbSQ2MsOO9DcO2P2DRocePlF0McnBMhVFMhJ9O9QaxaVZiQBeHrGF3Ic8NKhDh1+bGYp/Tenl
 uB2A=
X-Gm-Gg: ASbGncuy94GNiNONqjzDhK3yQyZmbICJPmi7MXEOtbXGNtRaq1HSqIrI4gI8lNQBgZu
 HZ6EhKAE0WgIURRsaMt2KDPkhvHeOONj8KmVLyw9q+LatZkuLWhSI6ThtKlG/02CScFizQPgcZT
 pIWnTwWq/gbubdAnXt6bN+S9aQ8KD/qPBAxlN12wscg0HlEpWH3JfjNR/1JB9KEcr7rQMZW/uGt
 jbOZjQ9XytyPzRuzeCVyJ1EOp/bn+cCZVXB2vef3IZRPQzrtLeg/zc36ab6/tQo8R56SE6YlUic
 zNvyVOd0tPl3TNJtzxpYr9hCPZCD0oMsc3TDfE0JolzyqodI+i3jGsN7+X1P4BW1yg==
X-Google-Smtp-Source: AGHT+IHhzrA7a5FP2uvQUufgEdqg6xzsvVTY5gXbTTXrn3XN4VXDb7l7d0+ClS+NbXICJL/pUrePGg==
X-Received: by 2002:a5d:6d81:0:b0:38d:c58f:4ce5 with SMTP id
 ffacd0b85a97d-38dc891f27bmr10236936f8f.0.1739220162173; 
 Mon, 10 Feb 2025 12:42:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4394376118esm46514355e9.40.2025.02.10.12.42.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 12:42:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PULL 07/32] hw/arm/xlnx-zynqmp: Use &error_abort for programming
 errors
Date: Mon, 10 Feb 2025 21:41:39 +0100
Message-ID: <20250210204204.54407-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210204204.54407-1-philmd@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
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

When a property value is static (not provided by QMP or CLI),
error shouldn't happen, otherwise it is a programming error.
Therefore simplify and use &error_abort as this can't fail.

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20241108154317.12129-11-philmd@linaro.org>
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


