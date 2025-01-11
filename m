Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DFDE7719C
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 18:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWgMd-0007F2-7A; Sat, 11 Jan 2025 13:37:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tWgMb-0007CM-8v; Sat, 11 Jan 2025 13:37:37 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tWgMZ-0003wV-Kv; Sat, 11 Jan 2025 13:37:37 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d90a5581fcso4993211a12.1; 
 Sat, 11 Jan 2025 10:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736620653; x=1737225453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2lbCjO/QI9f/cjy0lFrwXYeFv174HAgj0VKP3Zi5H0A=;
 b=hhRHuW191HwI0vyyhaLixypkXbMGv1qQvJ73Ni3ULBkt/pclxXPgHN2Awrh6Q0BlyE
 zzBbuwhEMxS9S+friUhP0mHvg2zLTscDty+RF+CxrExvr379lSHPC/0IqT7LRIMLar7k
 fTBX8hdJ7ycAy8gLSw6nFllnbIyg5DqkmFImHfoVTwtk7PvRCov4yYiRo0T86zQcmohW
 TDLFbU7RYvwsSHutIY/9WzfkEIqBo0U67ef2fim/48f15vRME4H5MMng2sRDOmA/tn99
 WDeEUU3UzcO2jn0PxYvFfD3PYrA6LkpRleAb7u78dvFyF7ViIvhidogOFEIWNqSkMuDt
 4KoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736620653; x=1737225453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2lbCjO/QI9f/cjy0lFrwXYeFv174HAgj0VKP3Zi5H0A=;
 b=UoMkwghC2uTYAF2+lZJwhSq0r1GuJBIZxJPL/liP4zCfQAmYWUhdzOaj4SDZQJ50Ke
 6hZZDc3ZKf2PVMAfyTrnA0V7x2OFkqfE2Du1Ax/XtNXzEsz8tQlGbwNtVvBwfGJc+57A
 vmskIXmodKx5ZevPmZTb8RNyRV8r0cI3opuU9/MIGeT69Ybthlwyq+JpvTkr0NrhppPL
 wZcRGsb/a0YEAFGh4faczJImovx3tQ+pszW2WtY7lGOPUQNTgNQ+ghYwqLvDd7xKJT3L
 Jshxb21TJF90ij1uMfmaGVZAZiHNrQAg6MrPXNdIrLeLK+lo3FKTT6hL1GsZ+jAu2jF6
 TWOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVyJcJ2YgvNpEV1uBVcYRRK1jnZIQEHKiR1jbZPda+39bFShQIyMrW++wVjHmUImvuKUNK14oKIQ==@nongnu.org,
 AJvYcCV2/8gUkzaFpXDS8Jm4wip6HyDEFf860eY1DD5LFspn9XpWz3/zCrMQYkGqU+HwT1l3wObne7o+RTGT8g==@nongnu.org
X-Gm-Message-State: AOJu0YwYumgWhQqtVTqTP2RTJrIDGsDfjmn4LEKeoPIZqUK8V9+bvRnH
 ZP6Mfq0/V0EBL+hSWwfqPrMeA2IqZiYIwH4/SxHiCZrosncmsreCI8ohMw==
X-Gm-Gg: ASbGncsqdR3EbN8AA4oAyWtPBV1C7Bxe0P3m0XAT4dfNKMSFnl3xCW/KWHT5Tzc+LQq
 hpSXBL5iQyMiy9IRyeyL3niLNNPmJUeB5S2r4XPpmzkgR8uYhTSiWoGplEWZuguoxLTzqocBYLZ
 ru2zHwp+9XcaSwMYOjZaCMezz2mhfvoy3alsLwA/S1ltKON9b4E1vkxoURw2/w3W7efuDDUXXax
 p68aF96MUrqVVkA48LhGW3M/exWIrLhSaLGwjOON/qavvYCgAhIPXFXXBI8CDo/xcdw46HQzBqj
 hioFGKsftNPmxyjrHYRHvzuKDUcLV78XMheBzyl0UkY=
X-Google-Smtp-Source: AGHT+IHl3H1dYlpJHz/p8urwps7ktue8DJVYOmNRs38ZLXDw6pwPkiLHChBRkcwH67MviCY/5A1IFw==
X-Received: by 2002:a17:907:7f08:b0:aab:9430:40e9 with SMTP id
 a640c23a62f3a-ab2ab70a84emr1288917866b.32.1736620653018; 
 Sat, 11 Jan 2025 10:37:33 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-078-054-101-099.78.54.pool.telefonica.de. [78.54.101.99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95af187sm299026666b.142.2025.01.11.10.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jan 2025 10:37:32 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 10/13] tests/qtest/libqos: Reuse TYPE_IMX_I2C define
Date: Sat, 11 Jan 2025 19:37:08 +0100
Message-ID: <20250111183711.2338-11-shentey@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250111183711.2338-1-shentey@gmail.com>
References: <20250111183711.2338-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x531.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 tests/qtest/libqos/arm-imx25-pdk-machine.c | 5 +++--
 tests/qtest/libqos/i2c-imx.c               | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/libqos/arm-imx25-pdk-machine.c b/tests/qtest/libqos/arm-imx25-pdk-machine.c
index 8fe128fae8..2d8b754343 100644
--- a/tests/qtest/libqos/arm-imx25-pdk-machine.c
+++ b/tests/qtest/libqos/arm-imx25-pdk-machine.c
@@ -23,6 +23,7 @@
 #include "libqos-malloc.h"
 #include "qgraph.h"
 #include "i2c.h"
+#include "hw/i2c/imx_i2c.h"
 
 #define ARM_PAGE_SIZE            4096
 #define IMX25_PDK_RAM_START      0x80000000
@@ -50,7 +51,7 @@ static void *imx25_pdk_get_driver(void *object, const char *interface)
 static QOSGraphObject *imx25_pdk_get_device(void *obj, const char *device)
 {
     QIMX25PDKMachine *machine = obj;
-    if (!g_strcmp0(device, "imx.i2c")) {
+    if (!g_strcmp0(device, TYPE_IMX_I2C)) {
         return &machine->i2c_1.obj;
     }
 
@@ -86,7 +87,7 @@ static void imx25_pdk_register_nodes(void)
         .extra_device_opts = "bus=i2c-bus.0"
     };
     qos_node_create_machine("arm/imx25-pdk", qos_create_machine_arm_imx25_pdk);
-    qos_node_contains("arm/imx25-pdk", "imx.i2c", &edge, NULL);
+    qos_node_contains("arm/imx25-pdk", TYPE_IMX_I2C, &edge, NULL);
 }
 
 libqos_init(imx25_pdk_register_nodes);
diff --git a/tests/qtest/libqos/i2c-imx.c b/tests/qtest/libqos/i2c-imx.c
index 710cb926d6..6d868e4cc4 100644
--- a/tests/qtest/libqos/i2c-imx.c
+++ b/tests/qtest/libqos/i2c-imx.c
@@ -209,8 +209,8 @@ void imx_i2c_init(IMXI2C *s, QTestState *qts, uint64_t addr)
 
 static void imx_i2c_register_nodes(void)
 {
-    qos_node_create_driver("imx.i2c", NULL);
-    qos_node_produces("imx.i2c", "i2c-bus");
+    qos_node_create_driver(TYPE_IMX_I2C, NULL);
+    qos_node_produces(TYPE_IMX_I2C, "i2c-bus");
 }
 
 libqos_init(imx_i2c_register_nodes);
-- 
2.48.0


