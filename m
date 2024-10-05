Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD755CFB42C
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxAkb-0005iY-HL; Sat, 05 Oct 2024 15:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAkP-0005UT-Uv; Sat, 05 Oct 2024 15:47:26 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAkO-0007jc-Gz; Sat, 05 Oct 2024 15:47:25 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42e82f7f36aso26638925e9.0; 
 Sat, 05 Oct 2024 12:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728157642; x=1728762442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gqpqyzefSA/fNNCTFuL3jxhMZZmJ96+lu7QCsbLGY8c=;
 b=hSozv1UUClqNPFGotkWwaBlqaptK7AQKD1bmc5DL6WeuG2wqGx9u0nR0gMNedAacm/
 7iKLHPwmh28Osz/+BT3xoCF1h37fFRHcvXO4CA77TrPx/SyjtNYxJLKHKLxOOIkWYP8t
 OgnWFEIb2pe4xAc5l/rG4FJLU9NmXZg5FA5CUr2vDi1V7I8D2qWoR/LIsAzbzZiXF9+o
 u4/rDrPB986Imxybvc01/UxQ7EE3NsmED1uPy4pMIlDyP4QIE255mIo/UVSzGe/Qclx/
 J0vSPQFV+zAjgZmwWvZsl7Z0zaP8AnpFnReWFId7S4NzcF+n539aYOxLHfW9QA/Efj42
 xlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728157642; x=1728762442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gqpqyzefSA/fNNCTFuL3jxhMZZmJ96+lu7QCsbLGY8c=;
 b=mI5zxca+m9Nv9QeeufF66UzQ7QPzpSlVpEGZznWHClyN2iewRCdtCKLDiMs3TJ/nVG
 UrXVLoDtmcM4wFhNGXw5rxAomaM7XeG2HgFiMJwbheunGU8p4U2C1PqmC9FqIN7tocnx
 0qx3AukboXaOuR+hXL37dpQcsCj/SFJ4W/+yeSP/6DnYdNNZcOwR7QEC7x1CC74GdFlb
 c/ThauHn0PXz23sdkrR4XLUoco2GIwGsXPmUYY8v+PU0iQuWjLtPVTOcHUWbIDHBgmgr
 IZbQFsECua8hD6LjeXzcXCok87veKwHbwBzM/w29pcU0vFXvGvsxdqibCxHj7b6bCw5Y
 R5zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSQ4shcgORvISc5zsjY2GhfdF4RvV9mtYeKOz7V8qyZH12z+4en26ygBTYrwX46CSq+06yXbLqMI53@nongnu.org,
 AJvYcCUnWQNuF17pnShl9/i9RgKqjxgVYm+MilDWaiUqL9iKNXWk3wE2WPDTThc5/BvJEP0TFhW0nVB+GXo=@nongnu.org
X-Gm-Message-State: AOJu0YyryDTVRpV5BlWOvnQ1Ixn8ddv9cQqV9l6tteiWTOEhGxh9gRAK
 IkaOFov7guM775H31LCv4wUS8C6UUhHcHWdQj9wrWHq/WBui52bZbt+G+A==
X-Google-Smtp-Source: AGHT+IFpW+Dqh/CnTv/uS1K3nRQWU7jcXq/wSLu+3iDbUJ2V0Xog/ca4uj17M4W2jcWRJXOcOATOEw==
X-Received: by 2002:a05:600c:6054:b0:42f:8ac6:5198 with SMTP id
 5b1f17b1804b1-42f8ac655damr20482115e9.18.1728157641715; 
 Sat, 05 Oct 2024 12:47:21 -0700 (PDT)
Received: from archlinux.. (pd95ed790.dip0.t-ipconnect.de. [217.94.215.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86a0afc1sm47506775e9.1.2024.10.05.12.47.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 12:47:21 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Corey Minyard <cminyard@mvista.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 20/23] hw/i2c/smbus_eeprom: Prefer DEFINE_TYPES() macro
Date: Sat,  5 Oct 2024 21:46:00 +0200
Message-ID: <20241005194603.23139-21-shentey@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241005194603.23139-1-shentey@gmail.com>
References: <20241005194603.23139-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32b.google.com
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
2.46.2


