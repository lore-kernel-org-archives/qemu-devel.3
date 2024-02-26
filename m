Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1871CC47DD9
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 00:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reOUw-0001Q7-3o; Sun, 25 Feb 2024 19:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1reOTM-0006zs-5F; Sun, 25 Feb 2024 19:04:00 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1reOTI-0000bP-EX; Sun, 25 Feb 2024 19:03:55 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-608a21f1cbcso13426247b3.0; 
 Sun, 25 Feb 2024 16:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708905829; x=1709510629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dwrUXWIcfFzdV7BBJp4HhKekDysIM9N/Y6Nj2awBLZc=;
 b=FmUpswnfRS072ZsFBo8yVLoWOfiD0Vcs3Ve0mdReQTg+fhBhEwjCtZnRqNOgYjFUI6
 YDKAXRMC1ErbsK3HTrFzFYWGHeXeCPYgZlN1LNAhSs7G7HWVrlynQbnkrNzQiPE/IXbF
 Hiy0gLHtbR2NA1idxeyXZXyqp/bQSBiI3SMV0QHZkbBbC8b9TR/dk0nL2urguQ+edtiL
 oJuX9xTm4IamW/epNPx45//yLnIDBk3IBoNboOEjFJAbjWdFscFidMxjHFIrJOSIs1ld
 yhuU0RKyukB88e8Y8liNC+JJCEugEREqZmF704Y50ewCzLc2JzfSoaeFbDD4ElNP5/Cp
 1twQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708905829; x=1709510629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dwrUXWIcfFzdV7BBJp4HhKekDysIM9N/Y6Nj2awBLZc=;
 b=IjGa75qCBdBYWl4rHztL+D1QlBwHtGT6qHBipc+kF2Stow+L8fNEhE/f2e25u9X11+
 KKhDA9sqOuKsC+MI+5MmsuTgBMQaCASY+UgwYnBhFNT/LpoXBeEuqBOfkPhHP+Pm9TyY
 thRNYWLGxAk6jSAGQUh31SWWaD8DBtlqWCp6a/mYObj4Mx22ZUhek/MoHlVXj2hm4D7J
 SXb5LtQKu+Id20to/yZjygNZhELGdiKBpflnWhvEWxSdrSZrqjLAbno97N1F+ytdZWwA
 Faa5B73sxVMIj1SJ6WOa5jZQIqPtyqDLwJ60qwrzo9yKH0ng0bkSyeYrDYBaLmQtBO6a
 Wmtw==
X-Gm-Message-State: AOJu0YyxKrwi/ybTGiE0t2KoJOWIP4bbk0h0rD+9rOmvVMZUZEOhEQoU
 MYH/FCEixhMQmtVOn8uC+1Aa9p+OC3x45rYsJaBtW2E05UT3m9+q9ZsG+m7sB6GUYQ==
X-Google-Smtp-Source: AGHT+IEjN4Z2BhQy7OptgDnZgNEV3GVo90JBNLAYbEQA6HEHQd1WWJvQdNrszMQUcmKuMWrtI1eNjw==
X-Received: by 2002:a0d:d812:0:b0:608:28cf:3591 with SMTP id
 a18-20020a0dd812000000b0060828cf3591mr5598216ywe.23.1708905829395; 
 Sun, 25 Feb 2024 16:03:49 -0800 (PST)
Received: from localhost.localdomain ([201.203.117.224])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a818312000000b00607bfa1913csm938171ywf.114.2024.02.25.16.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 16:03:49 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v6 39/41] Add missed BCM2835 properties
Date: Sun, 25 Feb 2024 18:02:57 -0600
Message-Id: <20240226000259.2752893-40-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/misc/bcm2835_property.c           | 21 +++++++++++++++++++++
 include/hw/arm/raspberrypi-fw-defs.h | 11 +++++++++++
 2 files changed, 32 insertions(+)

diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 5c48f8d743..bdd9a6bbce 100644
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
diff --git a/include/hw/arm/raspberrypi-fw-defs.h b/include/hw/arm/raspberrypi-fw-defs.h
index 579cf0d554..8b404e0533 100644
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
-- 
2.34.1


