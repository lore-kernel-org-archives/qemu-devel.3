Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1450C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 18:37:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK0B2-0004U8-51; Wed, 19 Jun 2024 14:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sK0B0-0004TY-7d; Wed, 19 Jun 2024 14:36:58 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sK0Ay-00004z-72; Wed, 19 Jun 2024 14:36:57 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-52c815e8e9eso111427e87.0; 
 Wed, 19 Jun 2024 11:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718822213; x=1719427013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VGpiTZhwEEty9YTK3vcP9wWQVkaY76eUgrz1ZAi9qvs=;
 b=Hm3Rh2r07fltBUjiNiGmjiva80XVTvLU69A+IpO1QqsunLFy5nJpevvb18dq7zymIS
 FDPE3aWYogmVjNzUDWm3u66e/YiUuM2pvN5PFIuKC8mXJupCTImQzF6c2pH3KRQUkNe6
 NlECtRzbD/qT/m77xUtqJ/L/7zMP1cP1sqON64mRTqsr6iVNMgWhbVlzI637/PtEf+gi
 iUjLTg4vCI0g1CePedR2dA/3l6ovzoGV9BUqKAJHhWGTp7tXlgIAv7ITgxNXwyZ3U5/f
 0Dnxa4/1QCgLFV3f2QVLOKgqRKZPkX61S3toGn0TXmIGvndJIovswJYWR9cqfyukIeX+
 U+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718822213; x=1719427013;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VGpiTZhwEEty9YTK3vcP9wWQVkaY76eUgrz1ZAi9qvs=;
 b=WRFK6+7RaUV4FQRGQwBG5M1etvItHEHufoEkImERIXgbvY73zTp5wtFxBqIkwRO489
 hnLZ9RRyebAtQTypUuZiSU6UgnaQumIFz5pvPxR6wp4o0N34qKsH17qIk0XLymi6O6KU
 vfdJUtuHDOVuzICJ6xveo33u4YI9Sgbfax6mtsrBR1qJUdH9BTuykNP2lLYcJgX9Fvy3
 ngX+VdxAhGsMxPQ+KqIBV8B1L8YbOO/2ZGlhrYws2Ripe+5xoQjdPt1mzO4NisDljGeY
 P4bJLkzymp+MmwiiRUN0wGJAzb84lD8ddUWR26deEvjdtuK/Ffrmdl/3O6orw+85FIjI
 rhOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk7vS8CtBheSTeam8iqtVpesT6F8LuKZmgFajmzDh5ygTmi97wcZj4ENxqj+03lTRGRsdeFXTbVoVCFEdoT5XoquY/0V4aj6ol70W1sBXQSePIQyRCelI7AIg=
X-Gm-Message-State: AOJu0YyeRBggde8YL7602t4H76f6cbTp0rZ7sJfe1bITVv+DvAfhtUzD
 5fbrmjN12Lc8ABbXDUi/ZGkzlcrVm7lEiDbLTYdlZC6A+eItnhg=
X-Google-Smtp-Source: AGHT+IEkL/5JnKsqE8ptBJcCgyOEuG8/r0GZ5sS7Vs4nI7sbvBe0QfliaZ1sS901Mic8ip49aJMBCA==
X-Received: by 2002:a05:6512:1392:b0:52c:c75c:e08c with SMTP id
 2adb3069b0e04-52ccaa37fa1mr1973906e87.39.1718822212601; 
 Wed, 19 Jun 2024 11:36:52 -0700 (PDT)
Received: from wing.epfl.ch (dhcp-122-dist-b-021.epfl.ch. [128.178.122.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56da4136sm687521066b.36.2024.06.19.11.36.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 11:36:52 -0700 (PDT)
From: Zheyu Ma <zheyuma97@gmail.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Cc: Zheyu Ma <zheyuma97@gmail.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3] hw/gpio/aspeed: Add reg_table_size to AspeedGPIOClass
Date: Wed, 19 Jun 2024 20:36:38 +0200
Message-Id: <20240619183638.4073070-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=zheyuma97@gmail.com; helo=mail-lf1-x131.google.com
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
introduces a reg_table_size member to the AspeedGPIOClass structure. This
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
Changes in v3:
- Add the reproducer

Changes in v2:
- Introduce the reg_table_size to AspeedGPIOClass
---
 hw/gpio/aspeed_gpio.c         | 17 +++++++++++++++++
 include/hw/gpio/aspeed_gpio.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index c1781e2ba3..fd4912edae 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -559,6 +559,12 @@ static uint64_t aspeed_gpio_read(void *opaque, hwaddr offset, uint32_t size)
         return debounce_value;
     }
 
+    if (idx >= agc->reg_table_size) {
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
 
+    if (idx >= agc->reg_table_size) {
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
+    agc->reg_table_size = GPIO_3_3V_REG_ARRAY_SIZE;
 }
 
 static void aspeed_gpio_2500_class_init(ObjectClass *klass, void *data)
@@ -1127,6 +1140,7 @@ static void aspeed_gpio_2500_class_init(ObjectClass *klass, void *data)
     agc->nr_gpio_pins = 228;
     agc->nr_gpio_sets = 8;
     agc->reg_table = aspeed_3_3v_gpios;
+    agc->reg_table_size = GPIO_3_3V_REG_ARRAY_SIZE;
 }
 
 static void aspeed_gpio_ast2600_3_3v_class_init(ObjectClass *klass, void *data)
@@ -1137,6 +1151,7 @@ static void aspeed_gpio_ast2600_3_3v_class_init(ObjectClass *klass, void *data)
     agc->nr_gpio_pins = 208;
     agc->nr_gpio_sets = 7;
     agc->reg_table = aspeed_3_3v_gpios;
+    agc->reg_table_size = GPIO_3_3V_REG_ARRAY_SIZE;
 }
 
 static void aspeed_gpio_ast2600_1_8v_class_init(ObjectClass *klass, void *data)
@@ -1147,6 +1162,7 @@ static void aspeed_gpio_ast2600_1_8v_class_init(ObjectClass *klass, void *data)
     agc->nr_gpio_pins = 36;
     agc->nr_gpio_sets = 2;
     agc->reg_table = aspeed_1_8v_gpios;
+    agc->reg_table_size = GPIO_1_8V_REG_ARRAY_SIZE;
 }
 
 static void aspeed_gpio_1030_class_init(ObjectClass *klass, void *data)
@@ -1157,6 +1173,7 @@ static void aspeed_gpio_1030_class_init(ObjectClass *klass, void *data)
     agc->nr_gpio_pins = 151;
     agc->nr_gpio_sets = 6;
     agc->reg_table = aspeed_3_3v_gpios;
+    agc->reg_table_size = GPIO_3_3V_REG_ARRAY_SIZE;
 }
 
 static const TypeInfo aspeed_gpio_info = {
diff --git a/include/hw/gpio/aspeed_gpio.h b/include/hw/gpio/aspeed_gpio.h
index 904eecf62c..e66036ac39 100644
--- a/include/hw/gpio/aspeed_gpio.h
+++ b/include/hw/gpio/aspeed_gpio.h
@@ -75,6 +75,7 @@ struct AspeedGPIOClass {
     uint32_t nr_gpio_pins;
     uint32_t nr_gpio_sets;
     const AspeedGPIOReg *reg_table;
+    uint32_t reg_table_size;
 };
 
 struct AspeedGPIOState {
-- 
2.34.1


