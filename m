Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E65AE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 09:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVSKr-0004G6-Kl; Wed, 08 Jan 2025 04:26:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVSKH-0003xy-3N; Wed, 08 Jan 2025 04:26:14 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVSKF-0004pJ-GZ; Wed, 08 Jan 2025 04:26:08 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5d7e3f1fdafso34640631a12.0; 
 Wed, 08 Jan 2025 01:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736328365; x=1736933165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qbHAwk39a0EI/mfJEXYlFT6Wq50d666L3aYBs+8Wil0=;
 b=O3kQTyyvy9f32SQTLnuUfCI0K5LE9l5SW9WjfkF7h8QAf57NKnNOVhuN2rbD4BMZOZ
 OwsUGE13yvS66AnvIb87Pa34/o8I7s83eWokn0m5dlmjt97P35BMOAf4LKJJTMiqIY0j
 G0m6g2DTcFXGY8Az5P1LUvhQiVDV7BihnXtMzybIDID4AkvyjgAE816ngS891EW+aPHg
 WkZQffqChRSBL9Pq28IPYWj/13VcZy6PAkxabEPnWdZgJ7nKIRzKa1L1DO8rKHfhU9zr
 70nzYQtjw7UuhzgcsWzX8gDIwzU+G/Pap0rrk6afoc53YrHM4FNObQsVuFiFknqHdLuG
 nEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736328365; x=1736933165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qbHAwk39a0EI/mfJEXYlFT6Wq50d666L3aYBs+8Wil0=;
 b=dZDZlIlv2mxvNk2P+E+FFY9j1N1tmVSvEnw44Tc1IBKa/ScIoeQl9tX9O0IjGpD+tP
 TxvH5cnufvdHYzPYLhZXPmuluKTTcDmwN/u+94US3gXVV8kXPWC0u7+dJnH0ZrpUfkfM
 lS8cfWMwlj7LQNPA21On7s7+ooMx+8+3ZOMXJ+SaN9VPyMtUu8YVsQFLv6DOG0c0x6pj
 XNdBWBni52zFFh74AEVfHA0Syhr1S/golv3VyTg/v8dmn7OaUs6oR3DSeAFB+MlRRFWD
 0TiWB5FLtqk9Fv0/xquf1UFstd+OXNMlV/WCa2TYlH1vkVLcJCXZmiHOoWZhJAd7CwNz
 c/vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDCv6WP5IfXJDiWXQVN28lx+AwskstaF/1Mq4q8EMUbctVYNQ0DJOtJV65PZW6Bkm6Fdvf/yUvaw==@nongnu.org,
 AJvYcCW00OfVpW22CrWG9jEvbW36eR7Jah9o5sZoTzKEZqoLSTucav/IXZjcN1LpZh9viwuamkiRcbEJ+dPRjg==@nongnu.org
X-Gm-Message-State: AOJu0Ywm6I7Fs7q+eeePq7GOGiSwLbRGZ3cWvoodwcU5rd+GM97dTlsj
 PPMkc787/nDft28J7hvrQO2JhqzOLBRs/uhUAlnbbGnZP7zOMUcXda0A4+Wi
X-Gm-Gg: ASbGncvJ6IQ1Sx94pr/A6BKD5PzpeHa7m92tszSRMPWSh46u4Ol2LWDWpy+RSMj4V9h
 To7Dz3tBII8MNkZi+zPh6gPuRR8Hq4qnUUUNkOmK5g6vFWwSzDLEilhzExvLiPszKWbKMPgt7KQ
 7lrq9m8qvujndilyMEKM3UoesWHT22w0BoDcVOJRRYZCJpxQA8+xxFQ/rFnkE9QGWs5yAPcwowg
 qFjzk5JDfZLSdPMiqeLEGVfjM+Gps6QIr5jbNo5bN9SlU45Xza//cFeWmar2CFtEpNXiw3hgveQ
 /jXxYXT8IWqt2Dx2ICr769jpElCbPR/X4zJ/zmJaaXU2AWM=
X-Google-Smtp-Source: AGHT+IE340ZO7/O4tWuw3vvS7/AUxeFEvFt5RUzTOe8GQ+NPh/kb66lntRwqwh+XS39R3YcbD8t8pg==
X-Received: by 2002:a05:6402:2686:b0:5d9:a55:810c with SMTP id
 4fb4d7f45d1cf-5d972df64c2mr1509804a12.5.1736328364806; 
 Wed, 08 Jan 2025 01:26:04 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-188-106-228.77.188.pool.telefonica.de. [77.188.106.228])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d806feddfasm26116096a12.58.2025.01.08.01.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 01:26:03 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Guenter Roeck <linux@roeck-us.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 11/14] tests/qtest/libqos: Reuse TYPE_IMX_I2C define
Date: Wed,  8 Jan 2025 10:25:35 +0100
Message-ID: <20250108092538.11474-12-shentey@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108092538.11474-1-shentey@gmail.com>
References: <20250108092538.11474-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x535.google.com
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
2.47.1


