Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF66C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexb4-0001AY-Nn; Tue, 27 Feb 2024 08:34:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexam-0000tq-9L
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:56 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaV-0002x7-UE
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:55 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33d0a7f2424so2873527f8f.0
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040818; x=1709645618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BfQK9OJD3aICemNdn3VvNxx2yZ6JTCZD2HCR6qHP728=;
 b=MzIEJVcS/KGUOjGy4VfxiuJhFjFVWk1fG3DJ0bHoko+8SJqMg58oo/ERAq8CJ06mNC
 S/n/bdkWHxPD/JebHNqWE21gjH17ZYbWWR+nAQKaXPsE2aeljdTkSZD5Qzxk4PDtFVkW
 TtGYhB9VAgu5RhA71lFRADWVZHiODCGmgh8MiG8m9GgpMC6V6ZOaQL/hws+T8NSrJoOS
 v5ckjWD/KXHJ6ZZfWMNIcizXhhVIO/aZVvmeYd7hAv2zZ71ItKtWFg59Ut8qxzKQGQKN
 9OSprnBoWG0B3GanP7xAgIjsk2lQoDrnkMG9aW+5FyuI7SyTD0kPHAg3W7rVJ4t6itR9
 9Rwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040818; x=1709645618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BfQK9OJD3aICemNdn3VvNxx2yZ6JTCZD2HCR6qHP728=;
 b=JjR+37FOdJx/9qjjYHXE3gRuu829sFg/Zxsj24bMElwM/vKhmHWMKY8zhDEmtCApvO
 kpDXY3StPvX33f/AiM+fNTYbZhAwhP3pPB0uXiUokRu3EemH3mzrhkaBUe4DHVLLDC9E
 CEH86Lgyi98RBaHOppryEKXDWCfQHnMBU8cfurRj0D4v2Lbjk6JiFAY5L9bJyPA2Jfd+
 F2yvNq1nfC1n8eLWA2auRQESNE66BAVA/H7Qqj3pxf3tljduuFFSHBgAHg1jZF0iokLi
 ReMq4SN/H4thKg6HU2f9Xy2qpo8AQOxJPWk/OTbRsPgOPbIEz4DwLFU8zSSnSTR1S7lK
 JfYw==
X-Gm-Message-State: AOJu0YwKSrNuf1eLeZ4URtfKyQX93BLpJX/bOIVR4XhK/qQiJsTKuNbY
 ZyQwwFg+25vVbxfAbjXAc+WQp793nZ+0eOx5JlhpxWlKAyHO9Tk0PudwIxjlGsoq7NBFgZN+gLt
 c
X-Google-Smtp-Source: AGHT+IHTe3ijaazVGaIu42uvrdNjmzWvX3w3ZtsIcpFbWP3L3lkZ+AAl+B94ioCr7LTrLS4oYLdkcQ==
X-Received: by 2002:adf:e8ce:0:b0:33d:269e:132a with SMTP id
 k14-20020adfe8ce000000b0033d269e132amr7010166wrn.15.1709040818296; 
 Tue, 27 Feb 2024 05:33:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/45] hw/misc/bcm2835_property: Add missed BCM2835 properties
Date: Tue, 27 Feb 2024 13:33:12 +0000
Message-Id: <20240227133314.1721857-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Sergey Kambalin <serg.oker@gmail.com>

Our model of the bcm2835 mailbox is missing a few properties
that we need for the raspi4 kernel:
 * RPI_FWREQ_GET_CLOCKS
 * RPI_FWREQ_GET_THROTTLED
 * RPI_FWREQ_VCHIQ_INIT

Add minimal implementations of them.

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Message-id: 20240226000259.2752893-40-sergey.kambalin@auriga.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: improved commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/raspberrypi-fw-defs.h | 11 +++++++++++
 hw/misc/bcm2835_property.c           | 21 +++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/hw/arm/raspberrypi-fw-defs.h b/include/hw/arm/raspberrypi-fw-defs.h
index 579cf0d5546..8b404e05336 100644
--- a/include/hw/arm/raspberrypi-fw-defs.h
+++ b/include/hw/arm/raspberrypi-fw-defs.h
@@ -159,4 +159,15 @@ enum rpi_firmware_clk_id {
     RPI_FIRMWARE_NUM_CLK_ID,
 };
 
+struct rpi_firmware_property_tag_header {
+    uint32_t tag;
+    uint32_t buf_size;
+    uint32_t req_resp_size;
+};
+
+typedef struct rpi_firmware_prop_request {
+    struct rpi_firmware_property_tag_header hdr;
+    uint8_t payload[0];
+} rpi_firmware_prop_request_t;
+
 #endif /* INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H_ */
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 5c48f8d7438..bdd9a6bbcec 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -19,6 +19,8 @@
 #include "trace.h"
 #include "hw/arm/raspi_platform.h"
 
+#define VCHI_BUSADDR_SIZE       sizeof(uint32_t)
+
 /* https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface */
 
 static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
@@ -138,6 +140,13 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             resplen = 8;
             break;
 
+        case RPI_FWREQ_GET_CLOCKS:
+            /* TODO: add more clock IDs if needed */
+            stl_le_phys(&s->dma_as, value + 12, 0);
+            stl_le_phys(&s->dma_as, value + 16, RPI_FIRMWARE_ARM_CLK_ID);
+            resplen = 8;
+            break;
+
         case RPI_FWREQ_SET_CLOCK_RATE:
         case RPI_FWREQ_SET_MAX_CLOCK_RATE:
         case RPI_FWREQ_SET_MIN_CLOCK_RATE:
@@ -276,6 +285,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             stl_le_phys(&s->dma_as, value + 12, 0);
             resplen = 4;
             break;
+
         case RPI_FWREQ_FRAMEBUFFER_GET_NUM_DISPLAYS:
             stl_le_phys(&s->dma_as, value + 12, 1);
             resplen = 4;
@@ -301,6 +311,17 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
                                     resplen);
             break;
 
+        case RPI_FWREQ_GET_THROTTLED:
+            stl_le_phys(&s->dma_as, value + 12, 0);
+            resplen = 4;
+            break;
+
+        case RPI_FWREQ_VCHIQ_INIT:
+            stl_le_phys(&s->dma_as,
+                        value + offsetof(rpi_firmware_prop_request_t, payload),
+                        0);
+            resplen = VCHI_BUSADDR_SIZE;
+            break;
         default:
             qemu_log_mask(LOG_UNIMP,
                           "bcm2835_property: unhandled tag 0x%08x\n", tag);
-- 
2.34.1


