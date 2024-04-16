Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA4CC05023
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 18:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwnqw-0003uc-0T; Tue, 16 Apr 2024 14:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwnqX-0003f5-FG
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 14:47:57 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwnqT-00033K-FG
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 14:47:55 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41890fd335fso7089485e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 11:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713293272; x=1713898072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zYXb4/m9oXI7w1Sc1uMalQZY0M+kZn7gKjywWZhXidY=;
 b=hFHzMwoKqKEFQ+Bk9JJtcfd5Kma/VxUb3Y4dBvT+Qb5l6tPcn0nfvf/uZCr3ltrciS
 DlwFFC6H7leExqQlxTBG6LfAWxcR/KOW54HLvHmO1H/n9aFvaPyqwd8QvrBAlnX7nPND
 g88LNR3DSjiLPwQdlJsPlxD+4XsI5ywZS2x5x0QpyA4ZvWWOVBkoPwUeQcLSeeQqooSb
 OizFaYwfoA5VS069YnO1TAbwRKHe/heyDeLZS9u/Rim01aPYvJ6wiJ0487xugrnga45i
 TbUS81qZdCKi94nmJfS4PpVOCeYATyrTpRRwhpAVMY1Ji+xG6mu7c+lgrHVEG1vMlNhU
 HmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713293272; x=1713898072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zYXb4/m9oXI7w1Sc1uMalQZY0M+kZn7gKjywWZhXidY=;
 b=Mi1jbEBGHaXnegq4Gih0/4pX2z6zlrCGG1ND5McNuyW2kDLSmkixTyQcZcwgqgIUAr
 nRwBJuXQf1N20eZcAgBAVZyc0KZiuyvlRES5klz1BTwg8EESVltvfBoxvTub42ttyr+D
 AuUo5DMd5wVpTmjbcvVFJmKZ9avohRccHHESJNriPZQhiTlAlCHYnCaqAypKxos085HA
 y0L5QHpRc9y/pUk0WWqB64lPzskpA5QG9chrroZZPQXOSWF7NxMVjSGBDBj0Z0kv+kNu
 r5bBmw8SPh5ismwo2fYa05bVA/X0Svrq7tyl1L5MgB6GWvPgNk8tS4QkU1Cpk47ru35r
 eVHg==
X-Gm-Message-State: AOJu0Yz0Z2VV0xMIR8VLcQIfmrGx87VUaQIm4K6k9XUSjV4E+V3vDYRm
 /54t0SCbi32cnwcvw7+jqHeKIAMPT3E1z1D5BvHLxQ4N/osMG65747IrUu0ehsLStTIqS5XUA9q
 y
X-Google-Smtp-Source: AGHT+IGcxH5PKlmhDVIT3P+/oOx+Ft/n04JasYJm0C+r6YPpR8l1pdd1kOVdMFzQYX+CUkMbJ0bbBg==
X-Received: by 2002:a05:600c:198b:b0:418:6b23:c02 with SMTP id
 t11-20020a05600c198b00b004186b230c02mr4398609wmq.16.1713293271618; 
 Tue, 16 Apr 2024 11:47:51 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 jh2-20020a05600ca08200b00417f700eaeasm17928595wmb.22.2024.04.16.11.47.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Apr 2024 11:47:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/4] hw/i2c: Convert to spec v7 terminology (manually)
Date: Tue, 16 Apr 2024 20:47:21 +0200
Message-ID: <20240416184722.28334-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416184722.28334-1-philmd@linaro.org>
References: <20240416184722.28334-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

See previous commit for rationale.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i2c/i2c.h | 52 ++++++++++++++++++++++----------------------
 hw/i2c/core.c        |  2 +-
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index 75c8154138..8908267c17 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -6,8 +6,8 @@
 
 /*
  * The QEMU I2C implementation only supports simple transfers that complete
- * immediately.  It does not support slave devices that need to be able to
- * defer their response (eg. CPU slave interfaces where the data is supplied
+ * immediately.  It does not support target devices that need to be able to
+ * defer their response (eg. CPU target interfaces where the data is supplied
  * by the device driver in response to an interrupt).
  */
 
@@ -28,23 +28,23 @@ OBJECT_DECLARE_TYPE(I2CTarget, I2CTargetClass,
 struct I2CTargetClass {
     DeviceClass parent_class;
 
-    /* Master to slave. Returns non-zero for a NAK, 0 for success. */
+    /* Controller to target. Returns non-zero for a NAK, 0 for success. */
     int (*send)(I2CTarget *s, uint8_t data);
 
     /*
-     * Master to slave (asynchronous).
-     * Receiving slave must call i2c_ack().
+     * Controller to target (asynchronous).
+     * Receiving target must call i2c_ack().
      */
     void (*send_async)(I2CTarget *s, uint8_t data);
 
     /*
-     * Slave to master.  This cannot fail, the device should always
+     * Target to controller.  This cannot fail, the device should always
      * return something here.
      */
     uint8_t (*recv)(I2CTarget *s);
 
     /*
-     * Notify the slave of a bus state change.  For start event,
+     * Notify the target of a bus state change.  For start event,
      * returns non-zero to NAK an operation.  For other events the
      * return code is not used and should be zero.
      */
@@ -96,7 +96,7 @@ struct I2CBus {
     uint8_t saved_address;
     bool broadcast;
 
-    /* Set from slave currently mastering the bus. */
+    /* Set from target currently controlling the bus. */
     QEMUBH *bh;
 };
 
@@ -107,7 +107,7 @@ int i2c_bus_busy(I2CBus *bus);
  * i2c_start_transfer: start a transfer on an I2C bus.
  *
  * @bus: #I2CBus to be used
- * @address: address of the slave
+ * @address: address of the target
  * @is_recv: indicates the transfer direction
  *
  * When @is_recv is a known boolean constant, use the
@@ -121,7 +121,7 @@ int i2c_start_transfer(I2CBus *bus, uint8_t address, bool is_recv);
  * i2c_start_recv: start a 'receive' transfer on an I2C bus.
  *
  * @bus: #I2CBus to be used
- * @address: address of the slave
+ * @address: address of the target
  *
  * Returns: 0 on success, -1 on error
  */
@@ -131,7 +131,7 @@ int i2c_start_recv(I2CBus *bus, uint8_t address);
  * i2c_start_send: start a 'send' transfer on an I2C bus.
  *
  * @bus: #I2CBus to be used
- * @address: address of the slave
+ * @address: address of the target
  *
  * Returns: 0 on success, -1 on error
  */
@@ -141,7 +141,7 @@ int i2c_start_send(I2CBus *bus, uint8_t address);
  * i2c_start_send_async: start an asynchronous 'send' transfer on an I2C bus.
  *
  * @bus: #I2CBus to be used
- * @address: address of the slave
+ * @address: address of the target
  *
  * Return: 0 on success, -1 on error
  */
@@ -161,9 +161,9 @@ bool i2c_scan_bus(I2CBus *bus, uint8_t address, bool broadcast,
                   I2CNodeList *current_devs);
 
 /**
- * Create an I2C slave device on the heap.
+ * Create an I2C target device on the heap.
  * @name: a device type name
- * @addr: I2C address of the slave when put on a bus
+ * @addr: I2C address of the target when put on a bus
  *
  * This only initializes the device state structure and allows
  * properties to be set. Type @name must exist. The device still
@@ -172,10 +172,10 @@ bool i2c_scan_bus(I2CBus *bus, uint8_t address, bool broadcast,
 I2CTarget *i2c_target_new(const char *name, uint8_t addr);
 
 /**
- * Create and realize an I2C slave device on the heap.
+ * Create and realize an I2C target device on the heap.
  * @bus: I2C bus to put it on
- * @name: I2C slave device type name
- * @addr: I2C address of the slave when put on a bus
+ * @name: I2C target device type name
+ * @addr: I2C address of the target when put on a bus
  *
  * Create the device state structure, initialize it, put it on the
  * specified @bus, and drop the reference to it (the device is realized).
@@ -184,10 +184,10 @@ I2CTarget *i2c_target_create_simple(I2CBus *bus,
                                     const char *name, uint8_t addr);
 
 /**
- * Realize and drop a reference an I2C slave device
- * @dev: I2C slave device to realize
+ * Realize and drop a reference an I2C target device
+ * @dev: I2C target device to realize
  * @bus: I2C bus to put it on
- * @addr: I2C address of the slave on the bus
+ * @addr: I2C address of the target on the bus
  * @errp: pointer to NULL initialized error object
  *
  * Returns: %true on success, %false on failure.
@@ -196,27 +196,27 @@ I2CTarget *i2c_target_create_simple(I2CBus *bus,
  * reference to it.
  *
  * This function is useful if you have created @dev via qdev_new(),
- * i2c_target_new() or i2c_slave_try_new() (which take a reference to
+ * i2c_target_new() or i2c_target_try_new() (which take a reference to
  * the device it returns to you), so that you can set properties on it
  * before realizing it. If you don't need to set properties then
  * i2c_target_create_simple() is probably better (as it does the create,
  * init and realize in one step).
  *
- * If you are embedding the I2C slave into another QOM device and
+ * If you are embedding the I2C target into another QOM device and
  * initialized it via some variant on object_initialize_child() then
  * do not use this function, because that family of functions arrange
  * for the only reference to the child device to be held by the parent
  * via the child<> property, and so the reference-count-drop done here
- * would be incorrect.  (Instead you would want i2c_slave_realize(),
+ * would be incorrect.  (Instead you would want i2c_target_realize(),
  * which doesn't currently exist but would be trivial to create if we
  * had any code that wanted it.)
  */
 bool i2c_target_realize_and_unref(I2CTarget *dev, I2CBus *bus, Error **errp);
 
 /**
- * Set the I2C bus address of a slave device
- * @dev: I2C slave device
- * @address: I2C address of the slave when put on a bus
+ * Set the I2C bus address of a target device
+ * @dev: I2C target device
+ * @address: I2C address of the target when put on a bus
  */
 void i2c_target_set_address(I2CTarget *dev, uint8_t address);
 
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index fd34a6bc83..a8d12cae4e 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -103,7 +103,7 @@ bool i2c_scan_bus(I2CBus *bus, uint8_t address, bool broadcast,
     return broadcast;
 }
 
-/* TODO: Make this handle multiple masters.  */
+/* TODO: Make this handle multiple controllers.  */
 /*
  * Start or continue an i2c transaction.  When this is called for the
  * first time or after an i2c_end_transfer(), if it returns an error
-- 
2.41.0


