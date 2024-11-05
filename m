Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7790D3E77D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SNZ-0001TF-NF; Tue, 05 Nov 2024 17:50:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SN2-00018a-Lj
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:50:01 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SMy-0004Tc-Ly
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:49:55 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4315e9e9642so51825585e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730846990; x=1731451790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wSzSjRbSrc4AxjVgNC6KJMNU1HPmiTPaRC0XOlem+rM=;
 b=M5buZuA0XdRM5wwoKyhzeLttcpx5XPOjPRLZNHK+lwdnLQVtqNkNttNF7iyXUECIRX
 SPfrU/sgXKF+eUwOONEGu/vTi/kVqSqQOcySRB1T2soBPeVO7EEtY8PLCotiFerRF/o4
 kHXJguVR8DA7lXFy8jU0pqcb7ob6IgWTXr3O9An4Yf7ibMvu8sMOhBEMB3AsfxG6nITV
 drRbfmUJL/T2vBNP7y9ij848SoFxQWDoWeKxzb6V2SeAnmp7AZQBX7v/s23AYS2ojYDQ
 aRcVRX0CSzPCtZb+vI4VQjEn6DArF5vXWNjT9W/rKzpYOcbxvEhC7+XXogogfuTV89DR
 P2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730846990; x=1731451790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wSzSjRbSrc4AxjVgNC6KJMNU1HPmiTPaRC0XOlem+rM=;
 b=kePTx/19UQxvBUO3SdUsw6S35/GrDk2xL4URweG3zhcujGam6/ZYWJH5AyZGh7ch0j
 cYPSUIKQ5fyjmTF9BxhymcWA6Pr/ma2/PXK3G9/rTYTD/FRbwVMWzv3sMNwLMUzvajAK
 P05hZYr5XcajaA3LWMVGlRhMBTY2a8oeorRYkNONflT3RVJdnh4DbheQ6IzhF7JBgThX
 PWcrivla9dHPqJbRL3Rpbq2CotEd+whhAY1/3Hq+P4u0cyB34HWQ1vPH7n/sZMoc1Vij
 sxbsuNLNmFCpmSbdHNo4wMVkuDll25g8UZyUsJ4S0OCQqJQItJRGFd9CYRrrAitmwXPq
 GM4Q==
X-Gm-Message-State: AOJu0Yz+TzoBIfcvB5Tk8QCcC7+Gyk3Ay0flflxJPNl39cgg09ES0jE7
 LPFpSbHQDrMoQGc8fto8J/VNkJT71Wxpcow2ZgkfKeVhyBnrIsY/HXI+xin7d1v/YDfcs6fpNVy
 arXo2Ew==
X-Google-Smtp-Source: AGHT+IEbdBeEOBalhredLU0mQN8CejK9bqxeLfb6mwEjTOrw5jfb7p7wjEPECjG4PFk9XrhIco663w==
X-Received: by 2002:a05:600c:3591:b0:431:680e:95d9 with SMTP id
 5b1f17b1804b1-4327b7eac4emr184483205e9.22.1730846990329; 
 Tue, 05 Nov 2024 14:49:50 -0800 (PST)
Received: from localhost.localdomain ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6da939sm1053395e9.31.2024.11.05.14.49.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 14:49:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 26/29] hw/i2c/smbus_eeprom: Prefer DEFINE_TYPES() macro
Date: Tue,  5 Nov 2024 22:47:24 +0000
Message-ID: <20241105224727.53059-27-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105224727.53059-1-philmd@linaro.org>
References: <20241105224727.53059-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Acked-by: Corey Minyard <cminyard@mvista.com>
Message-ID: <20241103133412.73536-23-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i2c/smbus_eeprom.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index 9e62c27a1a5..e3e96d4a2d6 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -151,19 +151,16 @@ static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
     dc->user_creatable = false;
 }
 
-static const TypeInfo smbus_eeprom_info = {
-    .name          = TYPE_SMBUS_EEPROM,
-    .parent        = TYPE_SMBUS_DEVICE,
-    .instance_size = sizeof(SMBusEEPROMDevice),
-    .class_init    = smbus_eeprom_class_initfn,
+static const TypeInfo smbus_eeprom_types[] = {
+    {
+        .name          = TYPE_SMBUS_EEPROM,
+        .parent        = TYPE_SMBUS_DEVICE,
+        .instance_size = sizeof(SMBusEEPROMDevice),
+        .class_init    = smbus_eeprom_class_initfn,
+    },
 };
 
-static void smbus_eeprom_register_types(void)
-{
-    type_register_static(&smbus_eeprom_info);
-}
-
-type_init(smbus_eeprom_register_types)
+DEFINE_TYPES(smbus_eeprom_types)
 
 void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *eeprom_buf)
 {
-- 
2.45.2


