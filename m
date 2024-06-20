Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7987AC27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 14:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKINU-0001t6-0d; Thu, 20 Jun 2024 10:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sKINR-0001rL-TP; Thu, 20 Jun 2024 10:03:01 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sKINQ-0001VT-1O; Thu, 20 Jun 2024 10:03:01 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a6f09b457fdso99438866b.2; 
 Thu, 20 Jun 2024 07:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718892178; x=1719496978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8JcYGEPwPru8qUDB09nHeyCS8JgDTBK2beev54WwtpQ=;
 b=EhoyO+hqX0IGidCKkqFgFKwtKiWksAoxM5E0SnPcQ3NoX4UcIlOFi/2RJlwBXFuuww
 N/RTtTlAtWB7XFU3cCt1G3wJC+o5ZxxD1KR6KxxD8JhXbXTl7JYNt97if2/j5Hd0OItL
 5HM6uCVs3ZXrKYsO7cizPzHSibKkB8P+FyxmTVgBqTiW7d33wFAAM1dO0o4supH8CLTk
 dzzLulVh1/pEdwDxR8HTkvMjKpkRVoWsyeICn6Uco4lHbp4bIwtnWPokeuQZbn1dLfap
 yVK+HQekXCdAwe2q8YooYD7PTkonugI5feyHi36gZcOxQnsU3PTc6quTrQoL47JNeSG1
 3O2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718892178; x=1719496978;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8JcYGEPwPru8qUDB09nHeyCS8JgDTBK2beev54WwtpQ=;
 b=PS9pdX7HEII5ZVvHbc2LhIBSKcvFOPU0AocqjPic5X54HB/fSVNAsh26axZ/ZSjTX/
 CcOsgUJfCLfFzo2VT19PVgqPo8/uwNqAzfjzSMT84TP9oZ21iJrK1j4KHuuspcUIE70W
 0qKAAYobPIadIV3Izmq8KHVPgWGzdNjbmIF82bR1Ey0Z837uZJTQGOlQq3HfmuI5co0h
 H0+BUQvy0adT6AYzTw9xSIrFh45oisXi7GdkwPQj3Kq6TpiqUT8hdCfLH+0RecfWyk7t
 H/x5AOR7A3TjMu0bMiye5iYKYw2c8k0tsy7yrjGLdDSM6v1lk58w+0ME9OJTzQ2msl/h
 76Wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7A1ONBGkR0Y2nyAAn4xxc89So1evn5cQKH+zDdjLUQJUJVbyL15DGoE6FKPiUWO6dX4XudDeOs6ULMceNdH51aw2CTJ+cNYP/GMrTE8UAIdjR+6cJ3d9t1g8=
X-Gm-Message-State: AOJu0YwteDs+C0QgXdRJUvf6VvZ30N/cpQiVgNOIF1KFopZl2u37eMWB
 7PZMKJ8VM2uWNvYwNiOkspoFfiOJrTE8pqCxBkNbNkg83SvB10yvlFJ+zhA=
X-Google-Smtp-Source: AGHT+IHLG4GyZnsQbN9k+BhJLuuN6BWZ1AbPaSdwFMhtSHRFul3HQYBEIdag/MWEIy3XV5KvK3nDtg==
X-Received: by 2002:a17:906:9c18:b0:a6f:3e20:bf15 with SMTP id
 a640c23a62f3a-a6fab62a235mr305046666b.31.1718892177839; 
 Thu, 20 Jun 2024 07:02:57 -0700 (PDT)
Received: from wing.epfl.ch (dhcp-122-dist-b-021.epfl.ch. [128.178.122.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f7373484esm565651066b.147.2024.06.20.07.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 07:02:57 -0700 (PDT)
From: Zheyu Ma <zheyuma97@gmail.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Cc: Zheyu Ma <zheyuma97@gmail.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v4] hw/gpio/aspeed: Add reg_table_count to AspeedGPIOClass
Date: Thu, 20 Jun 2024 16:02:39 +0200
Message-Id: <20240620140239.375338-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=zheyuma97@gmail.com; helo=mail-ej1-x62c.google.com
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

ASan detected a global-buffer-overflow error in the aspeed_gpio_read()
function. This issue occurred when reading beyond the bounds of the
reg_table.

To enhance the safety and maintainability of the Aspeed GPIO code, this commit
introduces a reg_table_count member to the AspeedGPIOClass structure. This
change ensures that the size of the GPIO register table is explicitly tracked
and initialized, reducing the risk of errors if new register tables are
introduced in the future.

Reproducer:
cat << EOF | qemu-system-aarch64 -display none \
-machine accel=qtest, -m 512M -machine ast1030-evb -qtest stdio
readq 0x7e780272
EOF

ASAN log indicating the issue:
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
Changes in v4:
- Change the variable name to 'reg_table_count'
- Change the 'reg_table_count' type to unsigned
Changes in v3:
- Add the reproducer
---
 hw/gpio/aspeed_gpio.c         | 17 +++++++++++++++++
 include/hw/gpio/aspeed_gpio.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index c1781e2ba3..6474bb8de5 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -559,6 +559,12 @@ static uint64_t aspeed_gpio_read(void *opaque, hwaddr offset, uint32_t size)
         return debounce_value;
     }
 
+    if (idx >= agc->reg_table_count) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: idx 0x%" PRIx64 " out of bounds\n",
+                      __func__, idx);
+        return 0;
+    }
+
     reg = &agc->reg_table[idx];
     if (reg->set_idx >= agc->nr_gpio_sets) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: no getter for offset 0x%"
@@ -785,6 +791,12 @@ static void aspeed_gpio_write(void *opaque, hwaddr offset, uint64_t data,
         return;
     }
 
+    if (idx >= agc->reg_table_count) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: idx 0x%" PRIx64 " out of bounds\n",
+                      __func__, idx);
+        return;
+    }
+
     reg = &agc->reg_table[idx];
     if (reg->set_idx >= agc->nr_gpio_sets) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: no setter for offset 0x%"
@@ -1117,6 +1129,7 @@ static void aspeed_gpio_ast2400_class_init(ObjectClass *klass, void *data)
     agc->nr_gpio_pins = 216;
     agc->nr_gpio_sets = 7;
     agc->reg_table = aspeed_3_3v_gpios;
+    agc->reg_table_count = GPIO_3_3V_REG_ARRAY_SIZE;
 }
 
 static void aspeed_gpio_2500_class_init(ObjectClass *klass, void *data)
@@ -1127,6 +1140,7 @@ static void aspeed_gpio_2500_class_init(ObjectClass *klass, void *data)
     agc->nr_gpio_pins = 228;
     agc->nr_gpio_sets = 8;
     agc->reg_table = aspeed_3_3v_gpios;
+    agc->reg_table_count = GPIO_3_3V_REG_ARRAY_SIZE;
 }
 
 static void aspeed_gpio_ast2600_3_3v_class_init(ObjectClass *klass, void *data)
@@ -1137,6 +1151,7 @@ static void aspeed_gpio_ast2600_3_3v_class_init(ObjectClass *klass, void *data)
     agc->nr_gpio_pins = 208;
     agc->nr_gpio_sets = 7;
     agc->reg_table = aspeed_3_3v_gpios;
+    agc->reg_table_count = GPIO_3_3V_REG_ARRAY_SIZE;
 }
 
 static void aspeed_gpio_ast2600_1_8v_class_init(ObjectClass *klass, void *data)
@@ -1147,6 +1162,7 @@ static void aspeed_gpio_ast2600_1_8v_class_init(ObjectClass *klass, void *data)
     agc->nr_gpio_pins = 36;
     agc->nr_gpio_sets = 2;
     agc->reg_table = aspeed_1_8v_gpios;
+    agc->reg_table_count = GPIO_1_8V_REG_ARRAY_SIZE;
 }
 
 static void aspeed_gpio_1030_class_init(ObjectClass *klass, void *data)
@@ -1157,6 +1173,7 @@ static void aspeed_gpio_1030_class_init(ObjectClass *klass, void *data)
     agc->nr_gpio_pins = 151;
     agc->nr_gpio_sets = 6;
     agc->reg_table = aspeed_3_3v_gpios;
+    agc->reg_table_count = GPIO_3_3V_REG_ARRAY_SIZE;
 }
 
 static const TypeInfo aspeed_gpio_info = {
diff --git a/include/hw/gpio/aspeed_gpio.h b/include/hw/gpio/aspeed_gpio.h
index 904eecf62c..90a12ae318 100644
--- a/include/hw/gpio/aspeed_gpio.h
+++ b/include/hw/gpio/aspeed_gpio.h
@@ -75,6 +75,7 @@ struct AspeedGPIOClass {
     uint32_t nr_gpio_pins;
     uint32_t nr_gpio_sets;
     const AspeedGPIOReg *reg_table;
+    unsigned reg_table_count;
 };
 
 struct AspeedGPIOState {
-- 
2.34.1


