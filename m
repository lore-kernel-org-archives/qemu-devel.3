Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25394C3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJZL-00012B-Jd; Mon, 01 Jul 2024 12:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ4-0000fV-Au
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:41 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ0-0005Pe-4E
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:37 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ebed33cb65so34368941fa.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719850052; x=1720454852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v4q4C3V/5/Br3sgQcvb/M3Jy91TsPgVVMFf55olF/G8=;
 b=cQkVIHzAFfZYHIbtnxgnBEWvlfvpsqwFZDjsgzKE0MCvAhmF18bDafKcfzS4Im6Bi1
 16g1+41mzoiEarkTIWC8DPr7UtTfAuuBvo7lrtuA7HVn9dxaLtJvAObC9VbVd2UuuwXZ
 no1liUXKBrkR0qLcFefKla8R+sVo12BDbzMVYHqeLmunnreVUcgBencK+N48mwF3WzwH
 Xx7sbxlV4G5w55wFQ3XzQ+XP6S9NcoJdbdN9TLks9JuRunkTu0wSS/I00IfRIKRPvzby
 52QxcYcbE16eH70qn4OQ5o0MzXuJGSbbMPIlfeGGSq1Ycjk36UoHma3jUZse08+EfwWT
 Cbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719850052; x=1720454852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v4q4C3V/5/Br3sgQcvb/M3Jy91TsPgVVMFf55olF/G8=;
 b=Hxcl8dCgn8P2+4FxCGaRNFd0OM+UistWMOTnI3LuM5zRAwnn77IJEZuvuY6RMwiYFj
 JhXKSONQoX8LbYqyO6wGZeFlBNsvwPag3iOFMAWUu2URkKMihxHGR0kYefrCRN1VXjm/
 /+MnwarWcJxJwkofccJfyQYVRiwppz6b4XwLbWymmJVc89EGCs2N14OqWpu6WZQqDAhA
 T3CY6zSI21nTzq2ATjzfDAjeFan0FRBd6tXfB157ELmbXfulajJqyj/yZVkh4Vjpw7WS
 jBxT05sN2sZvyIt1TUaCzbxp1PXjcVXsOJa2987meoBwuyAsWjHa10fyOWAmuZ5b9PZD
 DmpA==
X-Gm-Message-State: AOJu0YyyfjXGniUiJlGileHQAjz7eVa13AVo4t5a1VI/6nR9rGdhqd5S
 spbhl1FStAqK6J4EhnOqsYBm+gxmUMs/cjrx5lRUBpF9s+QWVAgQD3hRrxrLVuEQsCqlTOdpITu
 6m3g=
X-Google-Smtp-Source: AGHT+IE0oFsxKRuBP2C5z0aA/d7lRQ4IhcwM+RRTfrljJTAy+9ZCD57/CsrMRkSBjYo2nxXo2cAKdw==
X-Received: by 2002:a2e:bc0d:0:b0:2ec:18e5:e686 with SMTP id
 38308e7fff4ca-2ee5e6f2727mr50981591fa.33.1719850051757; 
 Mon, 01 Jul 2024 09:07:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm161952135e9.11.2024.07.01.09.07.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 09:07:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/29] hw/misc: Implement mailbox properties for customer OTP
 and device specific private keys
Date: Mon,  1 Jul 2024 17:07:03 +0100
Message-Id: <20240701160729.1910763-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701160729.1910763-1-peter.maydell@linaro.org>
References: <20240701160729.1910763-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
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

From: Rayhan Faizel <rayhan.faizel@gmail.com>

Four mailbox properties are implemented as follows:
1. Customer OTP: GET_CUSTOMER_OTP and SET_CUSTOMER_OTP
2. Device-specific private key: GET_PRIVATE_KEY and
SET_PRIVATE_KEY.

The customer OTP is located in the rows 36-43. The device-specific private key
is located in the rows 56-63.

The customer OTP can be locked with the magic numbers 0xffffffff 0xaffe0000
when running the SET_CUSTOMER_OTP mailbox command. Bit 6 of row 32 indicates
this lock, which is undocumented. The lock also applies to the device-specific
private key.

Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/raspberrypi-fw-defs.h |  2 +
 include/hw/misc/bcm2835_property.h   |  2 +
 hw/arm/bcm2835_peripherals.c         |  2 +
 hw/misc/bcm2835_property.c           | 87 ++++++++++++++++++++++++++++
 4 files changed, 93 insertions(+)

diff --git a/include/hw/arm/raspberrypi-fw-defs.h b/include/hw/arm/raspberrypi-fw-defs.h
index 8b404e05336..60b8e5b4513 100644
--- a/include/hw/arm/raspberrypi-fw-defs.h
+++ b/include/hw/arm/raspberrypi-fw-defs.h
@@ -56,6 +56,7 @@ enum rpi_firmware_property_tag {
     RPI_FWREQ_GET_THROTTLED =                          0x00030046,
     RPI_FWREQ_GET_CLOCK_MEASURED =                     0x00030047,
     RPI_FWREQ_NOTIFY_REBOOT =                          0x00030048,
+    RPI_FWREQ_GET_PRIVATE_KEY =                        0x00030081,
     RPI_FWREQ_SET_CLOCK_STATE =                        0x00038001,
     RPI_FWREQ_SET_CLOCK_RATE =                         0x00038002,
     RPI_FWREQ_SET_VOLTAGE =                            0x00038003,
@@ -73,6 +74,7 @@ enum rpi_firmware_property_tag {
     RPI_FWREQ_SET_PERIPH_REG =                         0x00038045,
     RPI_FWREQ_GET_POE_HAT_VAL =                        0x00030049,
     RPI_FWREQ_SET_POE_HAT_VAL =                        0x00038049,
+    RPI_FWREQ_SET_PRIVATE_KEY =                        0x00038081,
     RPI_FWREQ_SET_POE_HAT_VAL_OLD =                    0x00030050,
     RPI_FWREQ_NOTIFY_XHCI_RESET =                      0x00030058,
     RPI_FWREQ_GET_REBOOT_FLAGS =                       0x00030064,
diff --git a/include/hw/misc/bcm2835_property.h b/include/hw/misc/bcm2835_property.h
index ba8896610cc..2f93fd0c757 100644
--- a/include/hw/misc/bcm2835_property.h
+++ b/include/hw/misc/bcm2835_property.h
@@ -11,6 +11,7 @@
 #include "hw/sysbus.h"
 #include "net/net.h"
 #include "hw/display/bcm2835_fb.h"
+#include "hw/nvram/bcm2835_otp.h"
 #include "qom/object.h"
 
 #define TYPE_BCM2835_PROPERTY "bcm2835-property"
@@ -26,6 +27,7 @@ struct BCM2835PropertyState {
     MemoryRegion iomem;
     qemu_irq mbox_irq;
     BCM2835FBState *fbdev;
+    BCM2835OTPState *otp;
 
     MACAddr macaddr;
     uint32_t board_rev;
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 7d735bb56cf..ac153a96b9a 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -132,6 +132,8 @@ static void raspi_peripherals_base_init(Object *obj)
                                    OBJECT(&s->fb));
     object_property_add_const_link(OBJECT(&s->property), "dma-mr",
                                    OBJECT(&s->gpu_bus_mr));
+    object_property_add_const_link(OBJECT(&s->property), "otp",
+                                   OBJECT(&s->otp));
 
     /* Extended Mass Media Controller */
     object_initialize_child(obj, "sdhci", &s->sdhci, TYPE_SYSBUS_SDHCI);
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index bdd9a6bbcec..63de3db6215 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -32,6 +32,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
     uint32_t tmp;
     int n;
     uint32_t offset, length, color;
+    uint32_t start_num, number, otp_row;
 
     /*
      * Copy the current state of the framebuffer config; we will update
@@ -322,6 +323,89 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
                         0);
             resplen = VCHI_BUSADDR_SIZE;
             break;
+
+        /* Customer OTP */
+
+        case RPI_FWREQ_GET_CUSTOMER_OTP:
+            start_num = ldl_le_phys(&s->dma_as, value + 12);
+            number = ldl_le_phys(&s->dma_as, value + 16);
+
+            resplen = 8 + 4 * number;
+
+            for (n = start_num; n < start_num + number &&
+                 n < BCM2835_OTP_CUSTOMER_OTP_LEN; n++) {
+                otp_row = bcm2835_otp_get_row(s->otp,
+                                              BCM2835_OTP_CUSTOMER_OTP + n);
+                stl_le_phys(&s->dma_as,
+                            value + 20 + ((n - start_num) << 2), otp_row);
+            }
+            break;
+        case RPI_FWREQ_SET_CUSTOMER_OTP:
+            start_num = ldl_le_phys(&s->dma_as, value + 12);
+            number = ldl_le_phys(&s->dma_as, value + 16);
+
+            resplen = 4;
+
+            /* Magic numbers to permanently lock customer OTP */
+            if (start_num == BCM2835_OTP_LOCK_NUM1 &&
+                number == BCM2835_OTP_LOCK_NUM2) {
+                bcm2835_otp_set_row(s->otp,
+                                    BCM2835_OTP_ROW_32,
+                                    BCM2835_OTP_ROW_32_LOCK);
+                break;
+            }
+
+            /* If row 32 has the lock bit, don't allow further writes */
+            if (bcm2835_otp_get_row(s->otp, BCM2835_OTP_ROW_32) &
+                                    BCM2835_OTP_ROW_32_LOCK) {
+                break;
+            }
+
+            for (n = start_num; n < start_num + number &&
+                 n < BCM2835_OTP_CUSTOMER_OTP_LEN; n++) {
+                otp_row = ldl_le_phys(&s->dma_as,
+                                      value + 20 + ((n - start_num) << 2));
+                bcm2835_otp_set_row(s->otp,
+                                    BCM2835_OTP_CUSTOMER_OTP + n, otp_row);
+            }
+            break;
+
+        /* Device-specific private key */
+
+        case RPI_FWREQ_GET_PRIVATE_KEY:
+            start_num = ldl_le_phys(&s->dma_as, value + 12);
+            number = ldl_le_phys(&s->dma_as, value + 16);
+
+            resplen = 8 + 4 * number;
+
+            for (n = start_num; n < start_num + number &&
+                 n < BCM2835_OTP_PRIVATE_KEY_LEN; n++) {
+                otp_row = bcm2835_otp_get_row(s->otp,
+                                              BCM2835_OTP_PRIVATE_KEY + n);
+                stl_le_phys(&s->dma_as,
+                            value + 20 + ((n - start_num) << 2), otp_row);
+            }
+            break;
+        case RPI_FWREQ_SET_PRIVATE_KEY:
+            start_num = ldl_le_phys(&s->dma_as, value + 12);
+            number = ldl_le_phys(&s->dma_as, value + 16);
+
+            resplen = 4;
+
+            /* If row 32 has the lock bit, don't allow further writes */
+            if (bcm2835_otp_get_row(s->otp, BCM2835_OTP_ROW_32) &
+                                    BCM2835_OTP_ROW_32_LOCK) {
+                break;
+            }
+
+            for (n = start_num; n < start_num + number &&
+                 n < BCM2835_OTP_PRIVATE_KEY_LEN; n++) {
+                otp_row = ldl_le_phys(&s->dma_as,
+                                      value + 20 + ((n - start_num) << 2));
+                bcm2835_otp_set_row(s->otp,
+                                    BCM2835_OTP_PRIVATE_KEY + n, otp_row);
+            }
+            break;
         default:
             qemu_log_mask(LOG_UNIMP,
                           "bcm2835_property: unhandled tag 0x%08x\n", tag);
@@ -449,6 +533,9 @@ static void bcm2835_property_realize(DeviceState *dev, Error **errp)
     s->dma_mr = MEMORY_REGION(obj);
     address_space_init(&s->dma_as, s->dma_mr, TYPE_BCM2835_PROPERTY "-memory");
 
+    obj = object_property_get_link(OBJECT(dev), "otp", &error_abort);
+    s->otp = BCM2835_OTP(obj);
+
     /* TODO: connect to MAC address of USB NIC device, once we emulate it */
     qemu_macaddr_default_if_unset(&s->macaddr);
 
-- 
2.34.1


