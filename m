Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A50C83F0B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 22:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXoxw-0001kr-RM; Fri, 04 Jul 2025 18:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXoxi-0001gH-Kq
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 18:32:58 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXoxd-0007CZ-6k
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 18:32:52 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4a6f0bcdf45so16992291cf.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 15:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751668368; x=1752273168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uKmkxRAsLrWjnsCOSQbFX4weQOnjMiP/ZpQ6qjeJJOQ=;
 b=V4/03W1xYn+nL0CZuSHkUQ3OIfm10dREr5eUWveaeHr5DywDxUClLQmjjhhD3Ag1PH
 D44xvqcvEAtUF6qz7LxfPmYBHU1joZhVAFnaW4eGE+3EWTaXb8JEemtWnzTQ6M6EX30d
 qnLxUsbvnQrvQoyPaN+fzPiJf3txL7+lecFZtLxYN0ZlFG+pG2PhO3x3/0eY86He6tdB
 GWZKdlByWYJjDHd1RSxjVRfLKml6ZyAScG8Ex4WpID9fUNmpRQHbdw8wNRj0M/xTJHCA
 /7UJJUBa6KJHG6qCP3i8sFoh8MxJq0FSc7GLvEBCYDJ9xqtTqmSvUXzCRFSDoXZSUzl7
 xU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751668368; x=1752273168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uKmkxRAsLrWjnsCOSQbFX4weQOnjMiP/ZpQ6qjeJJOQ=;
 b=w+ysNP+aIab3AhACTTufMIJL3ynZ1OOfup64T3vnH8wT/WoCE83Gp8x+c54UWZmF2u
 /70O/pp0mh7uiZSM6Cn0fKoYGwRjYiBNgqYtWkH01Rma9HNtJEEboL1nuv3KbFh+G6DP
 sxxS7hpWcpTgBFf+8YpZiUhRJhX9tSxG77nxYyimWIFUY/zlNyK3o4vfq3DZnASpnCDI
 C5cldzs6X0ijukuc46AyM/fSm7XTP2hUmfsmvaVKHGOu5J7uHKq7sonQ7mpmZpXUR8Cu
 B+l5zQ7Oh2hoioLyhdobvrFAww4GOuVO3nCM4Z7ApGquWiogPzFNpYOGZZwCUxzOiBL4
 09Nw==
X-Gm-Message-State: AOJu0Yx5ZaBH341XW163R7JyLmsfguq5s4uQAzn57sSD47DAWGHzCJ0f
 ARu3QAM/U4pCksSj208e2VF+FUNbrnMxLuuIG6+eYXWQm0Ks6WPjrq5JB4DG3g==
X-Gm-Gg: ASbGncsTV08qDScjCrNfSo8sV8q/H+dJvUAXvp/XULt+rMup0mAXq/GSxUAkeNxVKAZ
 ihGwRLj62NcdThgf2QLB3XNh9ou5hKZapFTvlmFbrzWzQxuKpeHIHW102/mr+D/7T3ADtLw90wR
 pT9cbXfNBPtMLzZQxe9c1r6PkM+YsgYpbv2f+ZimXmJ9EzHnOzxqHJ1AP0NUfldnD0rGwccoERE
 KKW6VpWeEcS9W/v/MrOgkHNb0PXbezK/t/TvxHRLTEWYqzXbxsI7JP2PxuJ6jo/GFD7rU/rnlse
 u5K8C30SuSpbMG/QXwYqxJMah5RLVQDcE44QEgec99Zh0O8adUytrwJIeR0MVrxIUJhI9lwYWvJ
 2gz952g==
X-Google-Smtp-Source: AGHT+IEQRc/K7OH7dQ+PT7kvz/9GHnfa8s48LweLUsDYemgDvFfn8FyLFp+CJoWxZKDLkEepGrd7cw==
X-Received: by 2002:a05:622a:4ccb:b0:4a9:8852:7b95 with SMTP id
 d75a77b69052e-4a99685488emr56714981cf.26.1751668367650; 
 Fri, 04 Jul 2025 15:32:47 -0700 (PDT)
Received: from user-jcksn.myfiosgateway.com
 ([2600:4040:2bcd:3800:7cf4:c69f:10f5:f5b9])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a3093asm21528851cf.36.2025.07.04.15.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 15:32:47 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v4 09/11] MAX78000: Add TRNG to SOC
Date: Fri,  4 Jul 2025 18:32:37 -0400
Message-Id: <20250704223239.248781-10-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704223239.248781-1-jcksn@duck.com>
References: <20250704223239.248781-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=jackson88044@gmail.com; helo=mail-qt1-x833.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This commit adds TRNG to max78000_soc

Signed-off-by: Jackson Donaldson
---
 hw/arm/max78000_soc.c         | 10 +++++++++-
 include/hw/arm/max78000_soc.h |  2 ++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
index 45c6088312..3f2069fb03 100644
--- a/hw/arm/max78000_soc.c
+++ b/hw/arm/max78000_soc.c
@@ -43,6 +43,8 @@ static void max78000_soc_initfn(Object *obj)
                                 TYPE_MAX78000_UART);
     }
 
+    object_initialize_child(obj, "trng", &s->trng, TYPE_MAX78000_TRNG);
+
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
 }
 
@@ -124,6 +126,13 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
                                                        max78000_uart_irq[i]));
     }
 
+    dev = DEVICE(&s->trng);
+    sysbus_realize(SYS_BUS_DEVICE(dev), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x4004d000);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(armv7m, 4));
+
+    object_property_set_link(OBJECT(gcrdev), "trng", OBJECT(dev), &err);
+
     dev = DEVICE(&s->gcr);
     sysbus_realize(SYS_BUS_DEVICE(dev), errp);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x40000000);
@@ -166,7 +175,6 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("semaphore",            0x4003e000, 0x1000);
 
     create_unimplemented_device("spi1",                 0x40046000, 0x2000);
-    create_unimplemented_device("trng",                 0x4004d000, 0x1000);
     create_unimplemented_device("i2s",                  0x40060000, 0x1000);
     create_unimplemented_device("lowPowerControl",      0x40080000, 0x400);
     create_unimplemented_device("gpio2",                0x40080400, 0x200);
diff --git a/include/hw/arm/max78000_soc.h b/include/hw/arm/max78000_soc.h
index 919aca0855..528598cfcb 100644
--- a/include/hw/arm/max78000_soc.h
+++ b/include/hw/arm/max78000_soc.h
@@ -14,6 +14,7 @@
 #include "hw/misc/max78000_gcr.h"
 #include "hw/misc/max78000_icc.h"
 #include "hw/char/max78000_uart.h"
+#include "hw/misc/max78000_trng.h"
 #include "qom/object.h"
 
 #define TYPE_MAX78000_SOC "max78000-soc"
@@ -39,6 +40,7 @@ struct MAX78000State {
     Max78000GcrState gcr;
     Max78000IccState icc[MAX78000_NUM_ICC];
     Max78000UartState uart[MAX78000_NUM_UART];
+    Max78000TrngState trng;
 
     Clock *sysclk;
 };
-- 
2.34.1


