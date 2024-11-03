Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB9FE6F09E
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 13:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7alI-0006lq-Ro; Sun, 03 Nov 2024 08:35:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7alB-0006cM-2u; Sun, 03 Nov 2024 08:35:17 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7al9-0001Wl-Dg; Sun, 03 Nov 2024 08:35:16 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a9a2209bd7fso590743666b.2; 
 Sun, 03 Nov 2024 05:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730640913; x=1731245713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uvB/npsxlbJ9QKuMcZU24QB6i/ks5OjN7Y8RG67aRzw=;
 b=geiTZZt8q5FoxiktTZOKe0/TRRxqDSibcrPONEVc6uVTIhU66DdF60zien22qt5v/f
 Q6osiCu+paLZWbiaW1eewLd7tKvejOcDVS25a6s8chVaD3EUubD7cu4I1LjHRrmwsKRb
 9/76NusJuHg+zasfDoRb3hE8/1AILFNThD7U/GzWhu572DnL7TyoGIuohRW/Modpsfd5
 JE3e/i66UVLdiHvaDhUHo4cqjdPeIUIvJVdoEW0jKydKifZP1b9hVOV2mWniW6KAPyRY
 sQoOqR/A4DvXduZOdxQRVK6TO3lC2AcTAx7ZFVDdVrpOkao238ln84VOvv1/ebLjCzZ5
 XMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730640913; x=1731245713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uvB/npsxlbJ9QKuMcZU24QB6i/ks5OjN7Y8RG67aRzw=;
 b=iRwE7iEcKcAxpbHfoeAiusDigVjP1yueuiZ3ryhJpucXapiXfrAH1t9e3qeEIFu4Wk
 uVvuLI0XNUGowzGcdpGRGMEW5E2uEW7DUxpAQhoPx25pUhWMZptEjS2oPDFBXcnWGokV
 R5T7qzfID5gYM6qAjs5sj1aRU1qkVDfMmFwJlqzUOrEO0odKwpJCom2IZx6jQT1EbL1q
 K9bK9J51i3T3yXFfZeFZsWQweB3fEeHFz0SaBwnba4TyuGUgNfaxUNdY+BMLSh1JF4k0
 mMablU8Ql3sckVrq9//TrELZsUhyUauqzeBKkTa6V5w2/3s1ywu3xfTo3I/j/Cd1HKRz
 vbSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl+JoIEFWekg/KEo4Q3sYmzKgyxC2yWMC0Yh2Ay4aF1d6UKvJFNcZy/eZw3dAysT0tdBlt1rUirJKk@nongnu.org,
 AJvYcCXKliMSNB8r6DA/zpGQs9C1wPQyLi1p3dtBT10YQvxL6ZLYnsz0Ywpj3Tuqgs+QdY87sWsQ/SjJ2+0=@nongnu.org
X-Gm-Message-State: AOJu0YzHGDRwjIRufhh4H/Rv+dwfTWma9z3bBPhSRf+i3jCLHEQwoeB+
 LKdfckdC+IfOmCQr+0PRxM9QrxV7p/2KpJf4Z5DSbekshf3d6VB2WWWY8A==
X-Google-Smtp-Source: AGHT+IH//ZaAoLMQDViGf3sbi7kLGwX6e5QLPY1oWf6RMj9CL2sW8TG/69ANColW7aNzMzDoGjPg2g==
X-Received: by 2002:a17:907:7e8b:b0:a99:fd32:11dc with SMTP id
 a640c23a62f3a-a9de5d858aemr2955587066b.24.1730640912848; 
 Sun, 03 Nov 2024 05:35:12 -0800 (PST)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm424328866b.159.2024.11.03.05.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 05:35:12 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <cminyard@mvista.com>,
 Kevin Wolf <kwolf@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-block@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH v4 23/26] hw/rtc/ds1338: Prefer DEFINE_TYPES() macro
Date: Sun,  3 Nov 2024 14:34:09 +0100
Message-ID: <20241103133412.73536-24-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103133412.73536-1-shentey@gmail.com>
References: <20241103133412.73536-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x635.google.com
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
 hw/rtc/ds1338.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/hw/rtc/ds1338.c b/hw/rtc/ds1338.c
index a5fe221418..13472c5670 100644
--- a/hw/rtc/ds1338.c
+++ b/hw/rtc/ds1338.c
@@ -14,7 +14,6 @@
 #include "hw/i2c/i2c.h"
 #include "migration/vmstate.h"
 #include "qemu/bcd.h"
-#include "qemu/module.h"
 #include "qom/object.h"
 #include "sysemu/rtc.h"
 
@@ -227,16 +226,13 @@ static void ds1338_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_ds1338;
 }
 
-static const TypeInfo ds1338_info = {
-    .name          = TYPE_DS1338,
-    .parent        = TYPE_I2C_SLAVE,
-    .instance_size = sizeof(DS1338State),
-    .class_init    = ds1338_class_init,
+static const TypeInfo ds1338_types[] = {
+    {
+        .name          = TYPE_DS1338,
+        .parent        = TYPE_I2C_SLAVE,
+        .instance_size = sizeof(DS1338State),
+        .class_init    = ds1338_class_init,
+    },
 };
 
-static void ds1338_register_types(void)
-{
-    type_register_static(&ds1338_info);
-}
-
-type_init(ds1338_register_types)
+DEFINE_TYPES(ds1338_types)
-- 
2.47.0


