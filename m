Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95038C0219C
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 11:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg08t-00078S-3X; Thu, 06 Feb 2025 06:33:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg08q-00077S-0N
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:33:57 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg08o-0000r9-2j
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:33:55 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38633b5dbcfso729594f8f.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 03:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738841632; x=1739446432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r3g08ohEQSqeyZw6xIdCyqqo2uAlLNUZF1ZoGaNfqHI=;
 b=Url+ahEy7QcrotHgUKoim5FB7zHgrwYSoZjsNExJYryOH5+07kdiYZmHB9uotfSlzN
 fuhEdA+Zv2JIDgWmf/QwICkkYZLzcGCu9FHtmSGArCmOPBJXoHGpUA9sQG8ydOauTUQb
 eMPpyuqKoYqedcxCmhlt3MzATTdKPTONhneS139DSLuVpjrRZWfVqYedkXBwJxhbbWl6
 SksWm6A4z6WrtGukoAjXFy7qUu3zO+e1M6NKTq1bw8lHbwn4io2JFctWHQmGnPO/ryL4
 sG/0JcQkHAmslxKycIxZ5mKI7X6V7FlUKwgbWyQK/luuhghNg32TGU1hbu+RBTpa8/Dc
 HRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738841632; x=1739446432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r3g08ohEQSqeyZw6xIdCyqqo2uAlLNUZF1ZoGaNfqHI=;
 b=hSwQSoIDRIivzunGt7qnMrZmPpHdDQbdUtMbsJzn09pr7ARZMHjtoRzs8uXrtwwMme
 xvOs7ROTlZ8xAom9p7ioO49q9py1vFvtSHwnvQTpKF8PbFCVjUEGiFMHMzCaU16gNtbK
 fY1MPTLRGOIfYCtXvP9/vGUTV71BBXsDi1/U7LF9pCt2gzr3dvlF1MKAxsq+9fniNRG5
 25xdVafnP1IISic/t9L/pODQzI+3kyryZsgz58NOKYzEO2gzdw5tVTqVvOuRtZ2A913t
 2VwJOmAHJ53E4vRtUiHbOQpJryKjOc/Jj72UL4SAUmTLGWiv6sIJrvvvvIh5CtwKHac3
 e6Dw==
X-Gm-Message-State: AOJu0YxbXuEk4dCxDwoHGR+ZIRLjLecIFYcNbi8baaVsrdo2DOss9UBb
 0CpCmJl0rFk9tuDJij9ULyw2cODJXLIDfpgcvx/0aeQFhSlV198VdY6C7D1al/9327jDAct2MNS
 wh2U=
X-Gm-Gg: ASbGnctINOcvwlVzfVukYdIcpSh0vcVSKIDknN9A9V6pgvr77jdOES47g2D42NJ8qKx
 Y9u4DaQ0iZHzGrby7b7SHYXVF0fB8v2gG5XPOCcS4oehWSfmefxqGLWF9r3AmWmFdJLF3GsdsCD
 LKRh9oOlthvjCe6uywIs/E9dC+8ppqqob+wpTiapKu8mfhKwaAKA/qpI3DAOFQEgJkD1ShwkXY8
 mDydFxDZ+bZucDAUubm/Nm0aKAr4PPmcA2aHgcq5IDBASQGWbc/rLAUUSaLR9E5FZ+SuTA6d82C
 SholqflhAYvg5r0/tl5mlWvv1z6stFg1eTC2XMz/wu0Rwr4OsoZheNCgqzDBc7dfnQ==
X-Google-Smtp-Source: AGHT+IHiXyM3N0b/uEwdDeta0+L9OO8pcOGqeWgZHpFc+i/ERL5NW4dSrEIbEWOvj0Kd2MPmmHFUPQ==
X-Received: by 2002:a5d:64a1:0:b0:38a:888c:7df0 with SMTP id
 ffacd0b85a97d-38db4869c52mr6084553f8f.1.1738841632026; 
 Thu, 06 Feb 2025 03:33:52 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbde31ccesm1506012f8f.98.2025.02.06.03.33.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 03:33:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 06/16] hw/arm/xlnx-zynqmp: Use &error_abort for programming
 errors
Date: Thu,  6 Feb 2025 12:33:11 +0100
Message-ID: <20250206113321.94906-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206113321.94906-1-philmd@linaro.org>
References: <20250206113321.94906-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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


