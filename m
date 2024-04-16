Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8193FC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 18:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwnqU-0003cN-W4; Tue, 16 Apr 2024 14:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwnqM-0003bu-Mu
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 14:47:46 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwnqE-00032G-V1
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 14:47:43 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d858501412so61675401fa.0
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 11:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713293257; x=1713898057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tHLCK/YnntqXUfC6KOPJMzCxhjwRZbEvNRWEgpyELME=;
 b=q6TJ1XgGfQ4epnUpw2M/vGHVtJ8+wdnZkvxDUa8ilzK4maly/M02Te40x+nem4hE7C
 efTppN1/zgTamYNdk8NhLMV/1ackff3Kh75A/GxloYJvXN1UaL6VxZmRbNy1vzj93lwR
 n/S7GctffYSb0FoSOqvsJmsh6r5bQFL5d6eVMKo3iYDbPrFhvzcQ9YfqzaJjK30e8qhn
 lymeIQ34Ko3dQAIZ0Cik/aay0NcMmu4i2WKPTHE/qcPvORb4F7nYyMnK/JNtLfgzzLM7
 gVSQbRvQN39FjrDitDWT5jFipgmeMK3KqXXaVBAQxN8juzeAfq4YRlbpShnJcExwYCNx
 7ztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713293257; x=1713898057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tHLCK/YnntqXUfC6KOPJMzCxhjwRZbEvNRWEgpyELME=;
 b=BUcyzZfPN6uvB8nqtrHWiFhrdcNn+qh9I1WcxmoziCWQHqhrSs02H7UKcCtiCmIDHp
 Dg9JTQYvAGTbMolNUrkgpJof3WMj6oZW1HufaM+hdWQZfXd/QiQTh0DR4l01zhodAo+Z
 /yLn+g7xsWz1c/edo302ZjLycpgsHW4q2G7eV8PHKXLe0LdtMYRVReF/kHV6W9HYEQrm
 zo5vim8W1rx4CVaGg2KDmLmTxW08PsMzI6CpvCb7kgsz3VD6ptw9v5vGvbKIWv72IP5/
 xnXp0IoHhQUsQYaZL7XlUScno8j7EXXldE5kLq9CvkXoGhL3a3n6jQARACunGa7DCFvW
 bSKQ==
X-Gm-Message-State: AOJu0Yy0y0uvQppcWOl9nmOJaJoME8e/DJgq4tNAeUrioGiVUORUeaAz
 Jy+BCBgkT5HCEo5cWgf4E0r0fRHAxKv1t9BddpwJ9+uMWo5J3CsJKaKyEDgX0f7PNf4MPk4s7+O
 q
X-Google-Smtp-Source: AGHT+IEZZuraV6uudxgOzFvbjmvrjcnd8Q+44R1EJVaPt+dpnyrGrs2Bkmc7gCRH6tDQGRhMXThMrg==
X-Received: by 2002:a2e:a162:0:b0:2da:bbb5:8d47 with SMTP id
 u2-20020a2ea162000000b002dabbb58d47mr2250556ljl.3.1713293256736; 
 Tue, 16 Apr 2024 11:47:36 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 b13-20020a05600c4e0d00b0041898fc168bsm2983654wmq.36.2024.04.16.11.47.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Apr 2024 11:47:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH v2 2/4] hw/i2c: Fix checkpatch line over 80 chars warnings
Date: Tue, 16 Apr 2024 20:47:19 +0200
Message-ID: <20240416184722.28334-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416184722.28334-1-philmd@linaro.org>
References: <20240416184722.28334-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We are going to modify these lines, fix their style
in order to avoid checkpatch.pl warnings:

  WARNING: line over 80 characters

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i2c/i2c.h            |  11 ++-
 include/hw/nvram/eeprom_at24c.h |   6 +-
 hw/arm/aspeed.c                 | 140 +++++++++++++++++++-------------
 hw/nvram/eeprom_at24c.c         |   6 +-
 4 files changed, 98 insertions(+), 65 deletions(-)

diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index c18a69e4b6..a1b3f4d179 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -31,7 +31,10 @@ struct I2CSlaveClass {
     /* Master to slave. Returns non-zero for a NAK, 0 for success. */
     int (*send)(I2CSlave *s, uint8_t data);
 
-    /* Master to slave (asynchronous). Receiving slave must call i2c_ack(). */
+    /*
+     * Master to slave (asynchronous).
+     * Receiving slave must call i2c_ack().
+     */
     void (*send_async)(I2CSlave *s, uint8_t data);
 
     /*
@@ -83,7 +86,8 @@ struct I2CPendingMaster {
 };
 
 typedef QLIST_HEAD(I2CNodeList, I2CNode) I2CNodeList;
-typedef QSIMPLEQ_HEAD(I2CPendingMasters, I2CPendingMaster) I2CPendingMasters;
+typedef QSIMPLEQ_HEAD(I2CPendingMasters, I2CPendingMaster)
+            I2CPendingMasters;
 
 struct I2CBus {
     BusState qbus;
@@ -176,7 +180,8 @@ I2CSlave *i2c_slave_new(const char *name, uint8_t addr);
  * Create the device state structure, initialize it, put it on the
  * specified @bus, and drop the reference to it (the device is realized).
  */
-I2CSlave *i2c_slave_create_simple(I2CBus *bus, const char *name, uint8_t addr);
+I2CSlave *i2c_slave_create_simple(I2CBus *bus,
+                                  const char *name, uint8_t addr);
 
 /**
  * Realize and drop a reference an I2C slave device
diff --git a/include/hw/nvram/eeprom_at24c.h b/include/hw/nvram/eeprom_at24c.h
index acb9857b2a..9d29f0a69a 100644
--- a/include/hw/nvram/eeprom_at24c.h
+++ b/include/hw/nvram/eeprom_at24c.h
@@ -33,7 +33,9 @@ I2CSlave *at24c_eeprom_init(I2CBus *bus, uint8_t address, uint32_t rom_size);
  * @bus, and drop the reference to it (the device is realized). Copies the data
  * from @init_rom to the beginning of the EEPROM memory buffer.
  */
-I2CSlave *at24c_eeprom_init_rom(I2CBus *bus, uint8_t address, uint32_t rom_size,
-                                const uint8_t *init_rom, uint32_t init_rom_size);
+I2CSlave *at24c_eeprom_init_rom(I2CBus *bus,
+                                uint8_t address, uint32_t rom_size,
+                                const uint8_t *init_rom,
+                                uint32_t init_rom_size);
 
 #endif
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 93ca87fda2..8279ad748a 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -649,18 +649,23 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
         qdev_connect_gpio_out(dev, pca1_leds[i].gpio_id,
                               qdev_get_gpio_in(DEVICE(led), 0));
     }
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3), "dps310", 0x76);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3), "max31785", 0x52);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), "tmp423", 0x4c);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5), "tmp423", 0x4c);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3),
+                            "dps310", 0x76);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3),
+                            "max31785", 0x52);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
+                            "tmp423", 0x4c);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5),
+                            "tmp423", 0x4c);
 
     /* The Witherspoon expects a TMP275 but a TMP105 is compatible */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), TYPE_TMP105,
-                     0x4a);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
+                            TYPE_TMP105, 0x4a);
 
     /* The witherspoon board expects Epson RX8900 I2C RTC but a ds1338 is
      * good enough */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11),
+                            "ds1338", 0x32);
 
     smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 11), 0x51,
                           eeprom_buf);
@@ -717,19 +722,20 @@ static void fp5280g2_bmc_i2c_init(AspeedMachineState *bmc)
     at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 1), 0x50, 32768);
 
     /* The fp5280g2 expects a TMP112 but a TMP105 is compatible */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), TYPE_TMP105,
-                     0x48);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), TYPE_TMP105,
-                     0x49);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
+                            TYPE_TMP105, 0x48);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
+                            TYPE_TMP105, 0x49);
 
     i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
                      "pca9546", 0x70);
     /* It expects a TMP112 but a TMP105 is compatible */
-    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0), TYPE_TMP105,
-                     0x4a);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),
+                            TYPE_TMP105, 0x4a);
 
     /* It expects a ds3232 but a ds1338 is good enough */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), "ds1338", 0x68);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
+                            "ds1338", 0x68);
 
     /* It expects a pca9555 but a pca9552 is compatible */
     create_pca9552(soc, 8, 0x30);
@@ -745,12 +751,12 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
     create_pca9552(soc, 3, 0x61);
 
     /* The rainier expects a TMP275 but a TMP105 is compatible */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), TYPE_TMP105,
-                     0x48);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), TYPE_TMP105,
-                     0x49);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), TYPE_TMP105,
-                     0x4a);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
+                            TYPE_TMP105, 0x48);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
+                            TYPE_TMP105, 0x49);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
+                            TYPE_TMP105, 0x4a);
     i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
                                       "pca9546", 0x70);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
@@ -758,10 +764,10 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 2), 0x52, 64 * KiB);
     create_pca9552(soc, 4, 0x60);
 
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5), TYPE_TMP105,
-                     0x48);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5), TYPE_TMP105,
-                     0x49);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5),
+                            TYPE_TMP105, 0x48);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5),
+                            TYPE_TMP105, 0x49);
     create_pca9552(soc, 5, 0x60);
     create_pca9552(soc, 5, 0x61);
     i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5),
@@ -769,12 +775,12 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
 
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), TYPE_TMP105,
-                     0x48);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), TYPE_TMP105,
-                     0x4a);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), TYPE_TMP105,
-                     0x4b);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
+                            TYPE_TMP105, 0x48);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
+                            TYPE_TMP105, 0x4a);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
+                            TYPE_TMP105, 0x4b);
     i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
                                       "pca9546", 0x70);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
@@ -788,18 +794,20 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
     create_pca9552(soc, 7, 0x33);
     create_pca9552(soc, 7, 0x60);
     create_pca9552(soc, 7, 0x61);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), "dps310", 0x76);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
+                            "dps310", 0x76);
     /* Bus 7: TODO si7021-a20@20 */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), TYPE_TMP105,
-                     0x48);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), "max31785", 0x52);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
+                            TYPE_TMP105, 0x48);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
+                            "max31785", 0x52);
     at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 7), 0x50, 64 * KiB);
     at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 7), 0x51, 64 * KiB);
 
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8), TYPE_TMP105,
-                     0x48);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8), TYPE_TMP105,
-                     0x4a);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8),
+                            TYPE_TMP105, 0x48);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8),
+                            TYPE_TMP105, 0x4a);
     at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 8), 0x50,
                           64 * KiB, rainier_bb_fruid, rainier_bb_fruid_len);
     at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 8), 0x51,
@@ -810,18 +818,22 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
     /* Bus 8: ucd90320@b */
     /* Bus 8: ucd90320@c */
 
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp423", 0x4c);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp423", 0x4d);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
+                            "tmp423", 0x4c);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
+                            "tmp423", 0x4d);
     at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 9), 0x50, 128 * KiB);
 
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 10), "tmp423", 0x4c);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 10), "tmp423", 0x4d);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 10),
+                            "tmp423", 0x4c);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 10),
+                            "tmp423", 0x4d);
     at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 10), 0x50, 128 * KiB);
 
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), TYPE_TMP105,
-                     0x48);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), TYPE_TMP105,
-                     0x49);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11),
+                            TYPE_TMP105, 0x48);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11),
+                            TYPE_TMP105, 0x49);
     i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11),
                                       "pca9546", 0x70);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
@@ -1012,7 +1024,8 @@ static void qcom_dc_scm_bmc_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = bmc->soc;
 
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 15), "tmp105", 0x4d);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 15),
+                            "tmp105", 0x4d);
 }
 
 static void qcom_dc_scm_firework_i2c_init(AspeedMachineState *bmc)
@@ -1028,23 +1041,34 @@ static void qcom_dc_scm_firework_i2c_init(AspeedMachineState *bmc)
     /* I2C7 CPUVR MUX */
     cpuvr_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
                                         "pca9546", 0x70);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 0), "pca9548", 0x72);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 1), "pca9548", 0x72);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 2), "pca9548", 0x72);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 3), "pca9548", 0x72);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 0),
+                            "pca9548", 0x72);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 1),
+                            "pca9548", 0x72);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 2),
+                            "pca9548", 0x72);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 3),
+                            "pca9548", 0x72);
 
     /* I2C8 Thermal Diodes*/
     therm_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8),
                                         "pca9548", 0x70);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 0), TYPE_LM75, 0x4C);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 1), TYPE_LM75, 0x4C);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 2), TYPE_LM75, 0x48);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 3), TYPE_LM75, 0x48);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 4), TYPE_LM75, 0x48);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 0),
+                            TYPE_LM75, 0x4C);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 1),
+                            TYPE_LM75, 0x4C);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 2),
+                            TYPE_LM75, 0x48);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 3),
+                            TYPE_LM75, 0x48);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 4),
+                            TYPE_LM75, 0x48);
 
     /* I2C9 Fan Controller (MAX31785) */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "max31785", 0x52);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "max31785", 0x54);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
+                            "max31785", 0x52);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
+                            "max31785", 0x54);
 }
 
 static bool aspeed_get_mmio_exec(Object *obj, Error **errp)
diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index 3272068663..4db83d0dd6 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -148,8 +148,10 @@ I2CSlave *at24c_eeprom_init(I2CBus *bus, uint8_t address, uint32_t rom_size)
     return at24c_eeprom_init_rom(bus, address, rom_size, NULL, 0);
 }
 
-I2CSlave *at24c_eeprom_init_rom(I2CBus *bus, uint8_t address, uint32_t rom_size,
-                                const uint8_t *init_rom, uint32_t init_rom_size)
+I2CSlave *at24c_eeprom_init_rom(I2CBus *bus,
+                                uint8_t address, uint32_t rom_size,
+                                const uint8_t *init_rom,
+                                uint32_t init_rom_size)
 {
     EEPROMState *s;
 
-- 
2.41.0


