Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D308C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDuf-0005Z8-Dn; Fri, 11 Jul 2025 09:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDtk-0004Og-D8
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:47 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDti-0002zz-K7
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:44 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-450cb2ddd46so12433155e9.2
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752240881; x=1752845681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xLvUOEistdyulnFrRYxEkwmXouibdyACcWmS4j+YWEc=;
 b=ja3UQ+2DN2Y2Hpp93fUNdVoUizYLASkB6v9zpMB8szzGBgzkjVL3MOLnz9gKxV++8u
 jkBIbvoBupVEmrVWQfTkLPFCz80L9r/wFqccpSIsMCgl6bdgE3HzkmAPp4nZbJQZ2t7z
 DHvpWDCL81I8OSCXYesosEIwnLwdkG6DGOl3D1dFXdhxAFvs663k3cEdjnKjqqoE8LpS
 ixSg1vNK/oQWfN7+g9wUOIAVYoFtG4wFujVUZQoRTMBl2qDIZdEB2QgZb5gOByUQK0Ti
 GWGdmXR/K943efuNIZSQ5+Co3/+t452cbUZV12N76ZlYLmTE8ENGstBvOg7qq5RngzJS
 JDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240881; x=1752845681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xLvUOEistdyulnFrRYxEkwmXouibdyACcWmS4j+YWEc=;
 b=LNTPJgsztYozzwDKZUhAqS9JWiI9SemDD2LqSYP7hh5E0ssVCpyV0eVP1Srv1kjMeX
 BAwKXJjN2Ei7Gb3bs1DlP85Ilo/HbJltdL9MivtGbxyNp0Op35mYD68Zt96kqMvXBYqP
 3lOAISpU+2vZBlTjgVRki9jT0SIWcTpmBITlR7HYWyX0w0aRKAUmwfyVcBlRQm0iJn+f
 h9AwVbSGnVx4PdsaEz5jHY162aJmT5xY8GS5Bi6Yjyd/4Vb5ItQO+ATwbqvDbKD8pBEf
 Y7UklIIX1L6BaUEGSKncE71RL19LEQJiLEhYhW421jMUosKH5DfGY6bz2VoXNuQc8Zsy
 usfg==
X-Gm-Message-State: AOJu0Yw9Ciq6AY90D67+epRNajnsg3BWdXWafdKy4Vg7RTDmZTlfMSEI
 5QU2IOkgQ8zNdnsuvvm2j476zQx0H3eI29Vweti87T9ETFCLwyWdZNLawNIs2oUJs8U3f1Ih8vF
 pmz5i
X-Gm-Gg: ASbGncs6L+Srph6MNRsrKoonhxOSLwsIZAqjiH1//vDbJLL7l5l/Ph6H1ONUYQqX6IM
 47ZC9HBMzh6t045TDvQxvcXpX61BhpNE4DvcyYLsHJDoryjPK1MLXWceDB88mIY60+uHyP8Vudt
 HXKv+XdPK1V15WlmWOK0Zx5Lt0ZMCB9rXqO824DENWrXqBDbwTDGH1UKyQI8sI57+s9P676CgU1
 G42v6ZswOi12dxpK59eVUblNcOpGfVV3b9WkYY0Da/RDsD84Zhu20t+GR9ksFi4h5FUPzg+872C
 1UNYkMaJRc2p7nn4cLh/YZMF1tlyFWbX/Mci+HeMsWOpRp4v3HBqdhl2vVuYVNIqrqkggMRgvj6
 OwLk/TbDxP/16S2nFyz9RhlpE9KnD
X-Google-Smtp-Source: AGHT+IESU2ZBjATExqSFUm/Ml1xt8dlMCVCp8VZM03IvxhPolsaTEv5+F1YHqYrX+qflbJ9v5R4YLg==
X-Received: by 2002:a05:6000:2dc2:b0:3a4:f50b:ca2 with SMTP id
 ffacd0b85a97d-3b5f187591bmr3088907f8f.8.1752240880958; 
 Fri, 11 Jul 2025 06:34:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df0cdsm89734145e9.25.2025.07.11.06.34.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:34:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/36] MAX78000: Add TRNG to SOC
Date: Fri, 11 Jul 2025 14:34:02 +0100
Message-ID: <20250711133429.1423030-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711133429.1423030-1-peter.maydell@linaro.org>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Jackson Donaldson <jackson88044@gmail.com>

This commit adds TRNG to max78000_soc

Signed-off-by: Jackson Donaldson
Message-id: 20250704223239.248781-10-jcksn@duck.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/max78000_soc.h |  2 ++
 hw/arm/max78000_soc.c         | 10 +++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/max78000_soc.h b/include/hw/arm/max78000_soc.h
index 919aca0855f..528598cfcbe 100644
--- a/include/hw/arm/max78000_soc.h
+++ b/include/hw/arm/max78000_soc.h
@@ -14,6 +14,7 @@
 #include "hw/misc/max78000_gcr.h"
 #include "hw/misc/max78000_icc.h"
 #include "hw/char/max78000_uart.h"
+#include "hw/misc/max78000_trng.h"
 #include "qom/object.h"
 
 #define TYPE_MAX78000_SOC "max78000-soc"
@@ -39,6 +40,7 @@ struct MAX78000State {
     Max78000GcrState gcr;
     Max78000IccState icc[MAX78000_NUM_ICC];
     Max78000UartState uart[MAX78000_NUM_UART];
+    Max78000TrngState trng;
 
     Clock *sysclk;
 };
diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
index 45c60883121..3f2069fb039 100644
--- a/hw/arm/max78000_soc.c
+++ b/hw/arm/max78000_soc.c
@@ -43,6 +43,8 @@ static void max78000_soc_initfn(Object *obj)
                                 TYPE_MAX78000_UART);
     }
 
+    object_initialize_child(obj, "trng", &s->trng, TYPE_MAX78000_TRNG);
+
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
 }
 
@@ -124,6 +126,13 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
                                                        max78000_uart_irq[i]));
     }
 
+    dev = DEVICE(&s->trng);
+    sysbus_realize(SYS_BUS_DEVICE(dev), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x4004d000);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(armv7m, 4));
+
+    object_property_set_link(OBJECT(gcrdev), "trng", OBJECT(dev), &err);
+
     dev = DEVICE(&s->gcr);
     sysbus_realize(SYS_BUS_DEVICE(dev), errp);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x40000000);
@@ -166,7 +175,6 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("semaphore",            0x4003e000, 0x1000);
 
     create_unimplemented_device("spi1",                 0x40046000, 0x2000);
-    create_unimplemented_device("trng",                 0x4004d000, 0x1000);
     create_unimplemented_device("i2s",                  0x40060000, 0x1000);
     create_unimplemented_device("lowPowerControl",      0x40080000, 0x400);
     create_unimplemented_device("gpio2",                0x40080400, 0x200);
-- 
2.43.0


