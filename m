Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA2DE677FC
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 13:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7E14-0003Jm-Nr; Sat, 02 Nov 2024 09:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0x-0003Cd-Bg; Sat, 02 Nov 2024 09:18:03 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0v-00022M-SE; Sat, 02 Nov 2024 09:18:03 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a99f3a5a44cso378959166b.3; 
 Sat, 02 Nov 2024 06:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730553479; x=1731158279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XUm8qjOgywmx7gvdmgv03kZ9/zFDrArayrTzSFDEf8g=;
 b=Vwbi71CYTVH1cgw4KOUxs6FBs3+G7TJe+mZOtBG8TiZRZjuBBTN1RJfzy9ju1htIU7
 DSLSKzRC8BEjfVH8kPolXN4mXl7OVorNyeIGZvYH9Snmsnsk3auUxXulvGbCcUcZPzsr
 dSgVuHAqE20oSEoKY07uZwg7X242rJeswwLmY9X6ofeChSZNKreOEI/mTKW9PvA5OA+A
 OCdLU9P88nxmANX8+uR/y+gVGkMkzlrrMaZ/cR6cHHI19fiGH7d4kKpM8eydxay5JN8g
 z6apnoFDD0joWNyjTe+GiuzmuH5urqRWoxbC18zRyaYKXKmlE+vTxqr8h+Y4HLFR6bWf
 1APA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730553479; x=1731158279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XUm8qjOgywmx7gvdmgv03kZ9/zFDrArayrTzSFDEf8g=;
 b=Ue2aJivvYfcnf9e/XWdDT5DC+w6LFQHwyC+hRynMI4OQ4wCNlhnGsxQGG4NK8DLaAn
 Tw0igBDYjppLX0y8lQpgIaisZ8Bv2aSWTiINxs5W62yH9ITr4GfewZlvsjGakuu+IA9F
 zDKQd0w2t4m5YsmWoqgCYwF27YwqR+LumshUweorrjEtaiEgWcwFOdWzYpXmE8hM9Xu3
 Y5Py13Vec1HgdlFaXXkbWz25hG8Wx7n4pT3sCK83Fbbr7swgSpkmknEOF68wXOhhNox1
 H8RaVFxP9/ofExRwFxKl9iP72pOImoE0XzdgAZpTgwSer8QzeaIsMFU8bDw9AvttFyhr
 lYLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7+8ZEy9D9V4/gYnVqW2n4SnYs5/Bm6T1S4o6zwogRFRcZdWdJBtW7/fOYAx6dlS+xhGPprT4S8TMX@nongnu.org,
 AJvYcCXui6lh3ZuEIk5n7A9MLXYNKFaxTzLuL7j6FcB5X3O8WVEXzf0GXZhl/A09p22+Bk61xZRSaDEIiLs=@nongnu.org
X-Gm-Message-State: AOJu0YyvYhWv3mEKgHyXcG9MZkyS74FBdJOKHxc1b3JEuX6zoo/4CP3o
 WIKR71UOOD77PtBv02M3Z+gCbwAgXt6sZXfQw6LMHdAtUOkIbZwAs8mOXA==
X-Google-Smtp-Source: AGHT+IFSs1F7VA7Fsy1GjJjGW/RL7wWm5sFOwhjWJKnYkvHtFSxVAslTGo5TJB9Pvf3myPzzPLGeZQ==
X-Received: by 2002:a17:907:7dab:b0:a9a:55dd:4d52 with SMTP id
 a640c23a62f3a-a9de633078bmr2039459366b.63.1730553479141; 
 Sat, 02 Nov 2024 06:17:59 -0700 (PDT)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm307859066b.159.2024.11.02.06.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 06:17:58 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v3 22/26] hw/i2c/smbus_eeprom: Prefer DEFINE_TYPES() macro
Date: Sat,  2 Nov 2024 14:17:11 +0100
Message-ID: <20241102131715.548849-23-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102131715.548849-1-shentey@gmail.com>
References: <20241102131715.548849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x631.google.com
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>
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
2.47.0


