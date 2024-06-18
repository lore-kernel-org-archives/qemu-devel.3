Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E870C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 13:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJYbQ-0004DE-PS; Tue, 18 Jun 2024 09:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sJYbP-0004Cy-5f; Tue, 18 Jun 2024 09:10:23 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sJYbN-0001G3-7v; Tue, 18 Jun 2024 09:10:22 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a6e43dad8ecso942753466b.1; 
 Tue, 18 Jun 2024 06:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718716218; x=1719321018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CdC656LX/ayMRjO/5i3dWZETDsSTMDpoDwPrKBLb3YU=;
 b=KXdggFAeflKBNVjIQg7Pq2mYuEJuYCFDCUNu+VxyhlEmDrlkEDuNjU4iiM6am+k4N4
 nUuYnquJoTvqWimXdfMHXvNFE+qDMebbxPCTb4IOXOWreRwPAKi+433gPxi/F0CVMTra
 yzS7A5/DGC4z6rm78b5yd1c/14eoH0lNhlU0c5rsHnIF2nJ2B/RJKc8UWVkPEtt+qJFZ
 CldAAJpMzT3imR87xRSV1dv4ZJTXn1BaMldKcxakfzm6vtkzlM0DFzOBFnB5TKpLz9so
 uKLal3klcSnAWikje9qeCitr3qdR/lRoOrmdg4yjhO/UnKpGVLsnejV7F5nbUWKOCGG6
 i4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718716218; x=1719321018;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CdC656LX/ayMRjO/5i3dWZETDsSTMDpoDwPrKBLb3YU=;
 b=l7EXl1qgLBhUgQKtPSKY3F2sE5Dzfnpw1CDPSmj0eMna/mWpQRpUIAMns1h5AUE9Ao
 lPpLs1s0IMwsXMOB9sGD+A0sqR9xA+LEx2nUJUC4VL2UWF/MFQTW++hje9z/AgAuMIaw
 juKfe22dnCJOa+GtbzV9VWntq0b05VjfAw08xfOqchcgBVbiW8FOOH/Z+MeQRzTw0fHT
 proDyKPvEWQMRNegYba++2LqDuamgFX1hVjWhYP+1PFwvGH3mo/o0YNPCB/PU9dFjhBR
 pFrbjn+k0fkmr0mqMba24CiVzDNQjC5ilQ3YjLuvNvU0kHz+uhrp5fX4XAteMJMndqBC
 kPgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKjn7wIwEus1XMGiWgLMMi95rcspZFfeLh6JWIFtyoEFHstOhlJIEaMjbemRcKehTDIZWol2Sh+1tI+2hEBsuyB05Fg7w9rnEhaJzzyzX45CUDOSZ5HHkYIaY=
X-Gm-Message-State: AOJu0YyzWbHmGX2KXPohBiSofWOItKNM2a1MO2TdiVW4Ny7klz2UWx+V
 Zr8nIzirq3CfdixhaZtdQ18HANhN4/AS0JpKvPzQhCReCHoJJJl8FUhKUdGk1A==
X-Google-Smtp-Source: AGHT+IHjeRT1At+JkGoUU3rlz9KG77mP//yfEZ8h6zD6Arx2xUTlWGxiePm1s1w41e0cyVHM9kxFsA==
X-Received: by 2002:a17:906:5947:b0:a62:49ae:cd7b with SMTP id
 a640c23a62f3a-a6f950365f7mr136989666b.24.1718716217799; 
 Tue, 18 Jun 2024 06:10:17 -0700 (PDT)
Received: from wing.epfl.ch (dhcp-122-dist-b-021.epfl.ch. [128.178.122.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56f41737sm612404766b.160.2024.06.18.06.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 06:10:17 -0700 (PDT)
From: Zheyu Ma <zheyuma97@gmail.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Cc: Zheyu Ma <zheyuma97@gmail.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH] hw/gpio/aspeed: Add bounds checking for register table access
Date: Tue, 18 Jun 2024 15:09:28 +0200
Message-Id: <20240618130928.3075494-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=zheyuma97@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Added bounds checking in the aspeed_gpio_read() and aspeed_gpio_write()
functions to ensure the index idx is within the valid range of the
reg_table array.

The correct size of reg_table is determined dynamically based on whether
it is aspeed_3_3v_gpios or aspeed_1_8v_gpios. If idx exceeds the
size of reg_table, an error is logged, and the function returns.

AddressSanitizer log indicating the issue:

==2602930==ERROR: AddressSanitizer: global-buffer-overflow on address 0x55a5da29e128 at pc 0x55a5d700dc62 bp 0x7fff096c4e90 sp 0x7fff096c4e88
READ of size 2 at 0x55a5da29e128 thread T0
    #0 0x55a5d700dc61 in aspeed_gpio_read hw/gpio/aspeed_gpio.c:564:14
    #1 0x55a5d933f3ab in memory_region_read_accessor system/memory.c:445:11
    #2 0x55a5d92fba40 in access_with_adjusted_size system/memory.c:573:18
    #3 0x55a5d92f842c in memory_region_dispatch_read1 system/memory.c:1426:16
    #4 0x55a5d92f7b68 in memory_region_dispatch_read system/memory.c:1459:9
    #5 0x55a5d9376ad1 in flatview_read_continue_step system/physmem.c:2836:18
    #6 0x55a5d9376399 in flatview_read_continue system/physmem.c:2877:19
    #7 0x55a5d93775b8 in flatview_read system/physmem.c:2907:12

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 hw/gpio/aspeed_gpio.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index c1781e2ba3..1441046f6c 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -550,6 +550,7 @@ static uint64_t aspeed_gpio_read(void *opaque, hwaddr offset, uint32_t size)
     GPIOSets *set;
     uint32_t value = 0;
     uint64_t debounce_value;
+    uint32_t reg_table_size;
 
     idx = offset >> 2;
     if (idx >= GPIO_DEBOUNCE_TIME_1 && idx <= GPIO_DEBOUNCE_TIME_3) {
@@ -559,6 +560,18 @@ static uint64_t aspeed_gpio_read(void *opaque, hwaddr offset, uint32_t size)
         return debounce_value;
     }
 
+    if (agc->reg_table == aspeed_3_3v_gpios) {
+        reg_table_size = GPIO_3_3V_REG_ARRAY_SIZE;
+    } else {
+        reg_table_size = GPIO_1_8V_REG_ARRAY_SIZE;
+    }
+
+    if (idx >= reg_table_size) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: idx 0x%" PRIx64 " out of bounds\n",
+                      __func__, idx);
+        return 0;
+    }
+
     reg = &agc->reg_table[idx];
     if (reg->set_idx >= agc->nr_gpio_sets) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: no getter for offset 0x%"
@@ -768,6 +781,7 @@ static void aspeed_gpio_write(void *opaque, hwaddr offset, uint64_t data,
     const AspeedGPIOReg *reg;
     GPIOSets *set;
     uint32_t cleared;
+    uint32_t reg_table_size;
 
     trace_aspeed_gpio_write(offset, data);
 
@@ -785,6 +799,18 @@ static void aspeed_gpio_write(void *opaque, hwaddr offset, uint64_t data,
         return;
     }
 
+    if (agc->reg_table == aspeed_3_3v_gpios) {
+        reg_table_size = GPIO_3_3V_REG_ARRAY_SIZE;
+    } else {
+        reg_table_size = GPIO_1_8V_REG_ARRAY_SIZE;
+    }
+
+    if (idx >= reg_table_size) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: idx 0x%" PRIx64 " out of bounds\n",
+                      __func__, idx);
+        return;
+    }
+
     reg = &agc->reg_table[idx];
     if (reg->set_idx >= agc->nr_gpio_sets) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: no setter for offset 0x%"
-- 
2.34.1


