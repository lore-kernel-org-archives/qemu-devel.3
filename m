Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD43CF9C5B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 09:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssfPy-000442-Vn; Mon, 23 Sep 2024 05:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPx-0003uR-56; Mon, 23 Sep 2024 05:31:41 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPv-000724-M6; Mon, 23 Sep 2024 05:31:40 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a8d64b27c45so766521666b.3; 
 Mon, 23 Sep 2024 02:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727083893; x=1727688693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aOzD6ssHRYbkBf57nSepsx+Z8u/2fDdX3pi3JzLzT/I=;
 b=ZXEcUDOwqEVhtfU+C7i2nf5J/TGDI4ttCtnJAK3AtluK9IeGt1UX+eaFFWFq29PRGY
 NfDkvMseHbs/HNOTQLuiLka0swhe4W046xNVCm+0eC+LEv+d8gcfOtYwFMMn36JSHD4G
 12ZOSdoo97iTwg5g0LDNLf6pBquF9AGTG2bWRzi3G+uCj3bFNTdZf3MwlT7uOBNj2KoL
 mwnYqnpx9rGFCwf76RlnqJpZMACTv3hRatReA+ZRd+noLqLvPy3xDzIrci8S0JpcgERH
 XiAskIG7SH5vjrOoiNfPghYWMckV1NZyozldocobPiRu5aTsCaDGAoGKBHJdxBpmuz9o
 SoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727083893; x=1727688693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aOzD6ssHRYbkBf57nSepsx+Z8u/2fDdX3pi3JzLzT/I=;
 b=T6/nRdxfCKQLq1YN1/V29VKS/rABZCaDlUQv+QENCME3Ctmn0EYC3z+C9PcapdIBBj
 lv2fxqu1C7+e9cmrjGO1GE8p4GuJoNvMfjKDbx2jB+r8nzUoojLZXzNupdxWk4cm3YoN
 qkZknUIYmW/H9a8kIXs3jxsH8O1zYJmF8rlRZdgo/2oYh9juwvTMbH9Po0wIQgOkjo8k
 IohuYpC5/iW6snjI9Jf8rYHusJTgLFxjWKhVR9QcBojeoX3spfGwOEqg+YCktQ6Ugqm8
 DGS0WqoSuZ0YE6YkqrByfa/LD7WDoqOgvea0DMOnWEs5r0O43DRaKHlQiKyd13aiRO1O
 t57w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeR//EtxPnX7YdF0Yrrk9HWQ+s7g74wCl58mb13EmUQNysbG2XfC3SZ/sHc8oQ334SQA1I5N3KK+Y=@nongnu.org,
 AJvYcCX5f3ZwAd4sr8iT6z4AgBwuzCzDGMD8rHE6JmM2i4SzLYJQzgK9XqOLKlLQuKqlN3DPqlWmBVCacIvP@nongnu.org
X-Gm-Message-State: AOJu0YzbbEYxsjp/qBDm+UJjjiFNIooeM+BynwEVxZF5szfHI1MSS/Ap
 wtVq3R2T4m3T6uAT9BOzNxPntVIBAIvAiCPh4eadkq2LgzBf/u8iWUsAQg==
X-Google-Smtp-Source: AGHT+IHMnDUojEx5KTsGqZ/MIAt5QRpQ9BKEWydVapkuMT0BgZXw4V5k0QrZhao7n3vFI2nx1cBMMw==
X-Received: by 2002:a17:906:d25b:b0:a86:f960:411d with SMTP id
 a640c23a62f3a-a90d4fdf842mr1140091666b.2.1727083893465; 
 Mon, 23 Sep 2024 02:31:33 -0700 (PDT)
Received: from archlinux.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612b3f6fsm1188747166b.107.2024.09.23.02.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 02:31:33 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 20/23] hw/i2c/smbus_eeprom: Prefer DEFINE_TYPES() macro
Date: Mon, 23 Sep 2024 11:30:13 +0200
Message-ID: <20240923093016.66437-21-shentey@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923093016.66437-1-shentey@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i2c/smbus_eeprom.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index 9e62c27a1a..1d4d9704bf 100644
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
+static const TypeInfo types[] = {
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
+DEFINE_TYPES(types)
 
 void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *eeprom_buf)
 {
-- 
2.46.1


