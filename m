Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F104ED6A22F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 21:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBgy7-0000pc-RP; Thu, 14 Nov 2024 16:01:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBgxd-0000ZR-Vd
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:01:07 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBgxc-00080P-DM
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:01:05 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4316a44d1bbso130685e9.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 13:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731618061; x=1732222861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w7oaVYUllzOyksXJ6qk0wfeCGOBTZK5l45Wvi+e1fAY=;
 b=SQdtn/DOCu4HhcM4Zfw5Au3sWhe9VKBJIDA9iK3KcfzRGq9OQHeDip868oGqKFylXH
 T8aXTJ0/l16tDBlmHX7Wuvw22PH7+E1BePuL2k4SsPfAzuTOaQkxMoY8XRYQU2CT7Kew
 xuKb3S6cjW8pb7X7te3WaJMDhXQ5ERjXmyBEUk6O0BxG/Yo+WqIfIMsGb3sa04b8SeOu
 nuPz+ORei0gVE+S5d4UaZWFVoH0WRZIJIpSAngZzKdbeqDmgtbdlzVepXCinfMESbeLM
 TYEAk/NEISh5DBSHAtTcoZaXe3S41CYMyUwS9VwxJtYOXa6s4jT49lOQ5t2CK1NGzZss
 I0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731618061; x=1732222861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w7oaVYUllzOyksXJ6qk0wfeCGOBTZK5l45Wvi+e1fAY=;
 b=rBrTHeUWhsE46Fc14SqzOJwqENF+h+1N50Z1Jsc7J9mWEatcb6BO9zm6H8Ar+ibC5j
 0klThYDKPwEvvT6JAZbSi12WOxugt6WvbN+q9b5acZMTrONq+hftX21mp7zo80SzypY1
 BBEq0/KUdIptC9I2h9PJPK472OsIGLRKmb/YzQDRRhHdPRVhxsOlENSQtxbiTKezMMvd
 lUgbGQakYj2YeLzdBlXLwwduKkBJCZO26JhU2bQ+W4A0eCPPc8vekMfub9O1ZKg3uxwU
 +3srKTTk/HeonNA/5JJ5GR4XJDoZ7W5xNm83Ur34OZL7mBRTEWAWPqJSIfjxmsu8UMAF
 uEwQ==
X-Gm-Message-State: AOJu0YzqrfUEIXYEHLZhCU5k0qjMfziPZgfgDxO731uemjzp0WxcBM+E
 5TWze/NE3V8PtnV1cu/NzvcuHnUIV+SUfc90ty9IET7pRdI4iBD82Y3j0LWRu3cEBnQ9nzuVJWz
 l
X-Google-Smtp-Source: AGHT+IG/hHHwMUDSe0dZ0tBPJptuzdLRNKOxZLtUb8H1wsc2ldVBqjRni2V4Na0iF/SN0w3mNQ4zpA==
X-Received: by 2002:a05:600c:3b03:b0:430:52ec:1e41 with SMTP id
 5b1f17b1804b1-432df74de50mr1780655e9.17.1731618061061; 
 Thu, 14 Nov 2024 13:01:01 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.228])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac1f94asm32089465e9.39.2024.11.14.13.00.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Nov 2024 13:00:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Bernhard Beschow <shentey@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH RESEND v2 06/19] hw/net/xilinx_ethlite: Map MDIO registers (as
 unimplemented)
Date: Thu, 14 Nov 2024 21:59:57 +0100
Message-ID: <20241114210010.34502-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114210010.34502-1-philmd@linaro.org>
References: <20241114210010.34502-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Rather than handling the MDIO registers as RAM, map them
as unimplemented I/O within the device MR.

The memory flat view becomes:

  (qemu) info mtree -f
  FlatView #0
   Root memory region: system
    0000000081000000-00000000810007e3 (prio 0, i/o): xlnx.xps-ethernetlite
    00000000810007e4-00000000810007f3 (prio 0, i/o): ethlite.mdio
    00000000810007f4-0000000081001fff (prio 0, i/o): xlnx.xps-ethernetlite @00000000000007f4

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/net/xilinx_ethlite.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 0df962cd22..8de3131408 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -28,15 +28,18 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qom/object.h"
+#include "qapi/error.h"
 #include "exec/tswap.h"
 #include "hw/sysbus.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "hw/misc/unimp.h"
 #include "net/net.h"
 #include "trace.h"
 
 #define R_TX_BUF0     0
 #define BUFSZ_MAX      0x07e4
+#define A_MDIO_BASE    0x07e4
 #define R_TX_LEN0     (0x07f4 / 4)
 #define R_TX_GIE0     (0x07f8 / 4)
 #define R_TX_CTRL0    (0x07fc / 4)
@@ -73,6 +76,7 @@ struct XlnxXpsEthLite
     unsigned int txbuf;
     unsigned int rxbuf;
 
+    UnimplementedDeviceState mdio;
     uint32_t regs[R_MAX];
 };
 
@@ -233,6 +237,14 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
 {
     XlnxXpsEthLite *s = XILINX_ETHLITE(dev);
 
+    object_initialize_child(OBJECT(dev), "ethlite.mdio", &s->mdio,
+                            TYPE_UNIMPLEMENTED_DEVICE);
+    qdev_prop_set_string(DEVICE(&s->mdio), "name", "ethlite.mdio");
+    qdev_prop_set_uint64(DEVICE(&s->mdio), "size", 4 * 4);
+    sysbus_realize(SYS_BUS_DEVICE(&s->mdio), &error_fatal);
+    memory_region_add_subregion(&s->mmio, A_MDIO_BASE,
+                           sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->mdio), 0));
+
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_xilinx_ethlite_info, &s->conf,
                           object_get_typename(OBJECT(dev)), dev->id,
-- 
2.45.2


