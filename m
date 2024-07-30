Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A86C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYjLQ-00041F-UL; Tue, 30 Jul 2024 05:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLM-0003ir-J9
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:32 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLJ-0000Zy-Nw
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:32 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-368f92df172so2007720f8f.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 02:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722332428; x=1722937228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/hhRBmwKOtfoX+xYIxvn6dWC79cReHXO4z3495yS0JM=;
 b=EZuOFjvRBaVYBn8G09d182+hHM21mb6HaEt/uHK9WAmBkQYr5SW4eRlPQZhrCkEfzR
 9fnUnySlEmnEMA/A1hycpX8KQs+8OCImRLAdheiBpVC9hg5Er1Lge4YIq9cB6SUgdQDE
 qzb+q/Cb+TKhZGA1BYU+xvAoMI9kA8bwqyNoE/N3/QA5W3eAH5Ii2exYavCqjGMMD2QS
 phYTgibzjaaziFkikcsLodH2Ti1VzEghAAxxfg3rwF2Wh/8P8mCanDbPVD3bmf7sraG+
 OrAwLS90OqS4M8yqZgkjZpzAF7DcjnKchcCJjiEHWuM34W8KpBuP8G/yUGM0G2q32JcX
 5q7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722332428; x=1722937228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/hhRBmwKOtfoX+xYIxvn6dWC79cReHXO4z3495yS0JM=;
 b=PXw2hnFpEAsAKGciipKvkXJlu8TfuV0ERZEmI+ivg0bcXbMtfLeDTUnFnNu9Wfn1RY
 e7TSVVZYZWe3SNeV+K8NnOAfwNUAe75cE2plV468J9rtaQOPne1Ryk+NSe2oiXf0A193
 i0jLYId8SZ7L7b1yZrC3AAOfvcyZel2VTx0iyLQHxr8xJXxdJ07Pwo18loHWBCh6NxAv
 k+pvUznnOgFvcMVNxoGTuepxNNIuEoIy2huMnak0J7lrq2iHzJ51cSPkXklL/yl6u6E9
 wY91fVOhaxuhxeXov1f6lxLZS1CbaANm4H2PqcpFmqPrQ9FFukOYV1pSO33TlsrBkkB0
 sJkQ==
X-Gm-Message-State: AOJu0Yyln5B3K9RffKsPEsUkk50DUQatRGZFmHEAF/dhF+YIKYw2ImSy
 5LADotvJCqycEQ05qhP8WmGDbbI0lALTaBLoZY+pK/6IxstTB88w9R7Xu98LFabvY4Yx/S7Nmga
 O
X-Google-Smtp-Source: AGHT+IGC63MczyuoWEyxNNnA35HFzIz+yNf4rD5fzGMFhgGbXlSABqwuM5K7XQ676GPchlJLC1A6/w==
X-Received: by 2002:a5d:4390:0:b0:367:909b:8281 with SMTP id
 ffacd0b85a97d-36b5d0ddcd5mr6482178f8f.59.1722332428293; 
 Tue, 30 Jul 2024 02:40:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36862549sm14194974f8f.106.2024.07.30.02.40.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 02:40:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/21] hw/misc/bcm2835_property: Restrict scope of start_num,
 number, otp_row
Date: Tue, 30 Jul 2024 10:40:09 +0100
Message-Id: <20240730094020.2758637-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730094020.2758637-1-peter.maydell@linaro.org>
References: <20240730094020.2758637-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

In the long function bcm2835_property_mbox_push(), the variables
start_num, number and otp_row are used only in the four cases which
access OTP data, and their uses don't overlap with each other.

Make these variables have scope restricted to the cases where they're
used, so it's easier to read each individual case without having to
cross-refer up to the variable declaration at the top of the function
and check whether the variable is also used later in the loop.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240723131029.1159908-4-peter.maydell@linaro.org
---
 hw/misc/bcm2835_property.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 7eb623b4e90..443d42a1824 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -30,7 +30,6 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
     uint32_t tot_len;
     size_t resplen;
     uint32_t tmp;
-    uint32_t start_num, number, otp_row;
 
     /*
      * Copy the current state of the framebuffer config; we will update
@@ -331,22 +330,25 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
         /* Customer OTP */
 
         case RPI_FWREQ_GET_CUSTOMER_OTP:
-            start_num = ldl_le_phys(&s->dma_as, value + 12);
-            number = ldl_le_phys(&s->dma_as, value + 16);
+        {
+            uint32_t start_num = ldl_le_phys(&s->dma_as, value + 12);
+            uint32_t number = ldl_le_phys(&s->dma_as, value + 16);
 
             resplen = 8 + 4 * number;
 
             for (uint32_t n = start_num; n < start_num + number &&
                  n < BCM2835_OTP_CUSTOMER_OTP_LEN; n++) {
-                otp_row = bcm2835_otp_get_row(s->otp,
+                uint32_t otp_row = bcm2835_otp_get_row(s->otp,
                                               BCM2835_OTP_CUSTOMER_OTP + n);
                 stl_le_phys(&s->dma_as,
                             value + 20 + ((n - start_num) << 2), otp_row);
             }
             break;
+        }
         case RPI_FWREQ_SET_CUSTOMER_OTP:
-            start_num = ldl_le_phys(&s->dma_as, value + 12);
-            number = ldl_le_phys(&s->dma_as, value + 16);
+        {
+            uint32_t start_num = ldl_le_phys(&s->dma_as, value + 12);
+            uint32_t number = ldl_le_phys(&s->dma_as, value + 16);
 
             resplen = 4;
 
@@ -367,32 +369,35 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
 
             for (uint32_t n = start_num; n < start_num + number &&
                  n < BCM2835_OTP_CUSTOMER_OTP_LEN; n++) {
-                otp_row = ldl_le_phys(&s->dma_as,
+                uint32_t otp_row = ldl_le_phys(&s->dma_as,
                                       value + 20 + ((n - start_num) << 2));
                 bcm2835_otp_set_row(s->otp,
                                     BCM2835_OTP_CUSTOMER_OTP + n, otp_row);
             }
             break;
+        }
 
         /* Device-specific private key */
-
         case RPI_FWREQ_GET_PRIVATE_KEY:
-            start_num = ldl_le_phys(&s->dma_as, value + 12);
-            number = ldl_le_phys(&s->dma_as, value + 16);
+        {
+            uint32_t start_num = ldl_le_phys(&s->dma_as, value + 12);
+            uint32_t number = ldl_le_phys(&s->dma_as, value + 16);
 
             resplen = 8 + 4 * number;
 
             for (uint32_t n = start_num; n < start_num + number &&
                  n < BCM2835_OTP_PRIVATE_KEY_LEN; n++) {
-                otp_row = bcm2835_otp_get_row(s->otp,
+                uint32_t otp_row = bcm2835_otp_get_row(s->otp,
                                               BCM2835_OTP_PRIVATE_KEY + n);
                 stl_le_phys(&s->dma_as,
                             value + 20 + ((n - start_num) << 2), otp_row);
             }
             break;
+        }
         case RPI_FWREQ_SET_PRIVATE_KEY:
-            start_num = ldl_le_phys(&s->dma_as, value + 12);
-            number = ldl_le_phys(&s->dma_as, value + 16);
+        {
+            uint32_t start_num = ldl_le_phys(&s->dma_as, value + 12);
+            uint32_t number = ldl_le_phys(&s->dma_as, value + 16);
 
             resplen = 4;
 
@@ -404,12 +409,13 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
 
             for (uint32_t n = start_num; n < start_num + number &&
                  n < BCM2835_OTP_PRIVATE_KEY_LEN; n++) {
-                otp_row = ldl_le_phys(&s->dma_as,
+                uint32_t otp_row = ldl_le_phys(&s->dma_as,
                                       value + 20 + ((n - start_num) << 2));
                 bcm2835_otp_set_row(s->otp,
                                     BCM2835_OTP_PRIVATE_KEY + n, otp_row);
             }
             break;
+        }
         default:
             qemu_log_mask(LOG_UNIMP,
                           "bcm2835_property: unhandled tag 0x%08x\n", tag);
-- 
2.34.1


