Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA0AC48BEC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 11:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raw0f-0006a4-Ga; Fri, 16 Feb 2024 06:04:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw0d-0006YK-MG
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:03:59 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw0b-0000wX-E6
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:03:59 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d0b4ea773eso23787391fa.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 03:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708081435; x=1708686235; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jyHSiP+USy9LLsFpR2fD5RYQ//7L3lzistxQTGbBMcU=;
 b=tI5dWdyKBhFtIOXg5uWn8++EdwkI9bV/ShkHlbHXcI8QS0TYyvoSc41cti49Wvdft9
 K+PTrFwaaRGWQ1R24NTKTx1s4vFvhm68JwaV7uH22nfGyqTdl19qEx4ys8R/WbUR6Z7C
 8HuEIsw8JZaf+xJpPO+2k3/ltziAMVqwcZQxJpE+gcdDxNshmWTAXpN49aqYkwN3Syjb
 zs9k87MnMfIw2zB9/HGkQwQ+PCziC3QwCY5ZJeUVK8QM8Uz4LyPkROMlslodrt5mrw3k
 9soYk769Y4j4N5EzhghvOl1GUN954L3lb1Jrv6E6uRpOdr1YAVLfwmwgQF9bq3I4nAAT
 7smQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708081435; x=1708686235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jyHSiP+USy9LLsFpR2fD5RYQ//7L3lzistxQTGbBMcU=;
 b=s/Bf3AcZLW1DWh4c5oxv7qu67R6aK4Qe+nvrZpPrk0jWlYI3sdE5d9WSSc7pIDYid7
 7S7re9ekdqn7sRD43ldVU9F7+lryKK3+sQ4cchR6h5TRJA/77LYDAj5n/pVs9j/bpHnA
 G6lUU+/n67uwmhSSKDVqRWdvSCbn3nTwpVx25f4Csg29Sq7L9caWsSJ9xYrnnpHMCaAT
 fDNsWYkIB+r6GZuLcd5zrEKmtR6KPJhQsmJfDzIMjx+DB9/yiRhI4M5y4aIN1055GVHV
 ztl72KxsVZTrobXVcTIBNR9ptDZJFdGtpRbc6/HDZrmLCBIK7wUGw8y1E+0T9VeEUf61
 Xo2g==
X-Gm-Message-State: AOJu0YwsYdSPPAGtv49wIzm3Vp3nXsMSo2sZdQmapoISHeLxZuUu1T1H
 Sypcv4bZN4VdPrTNuZIIdVBi1ITXfidV/MK7+8IGJV5BmyY9+HFZmi49hR4PS77lF/cc2UE6wkU
 O
X-Google-Smtp-Source: AGHT+IGwFCOSAE5u5XuM3ABzSbBFzUUJPQD2I2SIKs+5IDNXIEsbPSf9z/PKbbwaFLS7QsJohGfTxA==
X-Received: by 2002:a2e:8911:0:b0:2d2:12d8:42a5 with SMTP id
 d17-20020a2e8911000000b002d212d842a5mr1692149lji.7.1708081435334; 
 Fri, 16 Feb 2024 03:03:55 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 bk30-20020a0560001d9e00b0033cddadde6esm1920641wrb.80.2024.02.16.03.03.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Feb 2024 03:03:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jan Kiszka <jan.kiszka@web.de>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 06/21] hw: Replace DEVICE(object_new) -> qdev_new()
Date: Fri, 16 Feb 2024 12:02:57 +0100
Message-ID: <20240216110313.17039-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240216110313.17039-1-philmd@linaro.org>
References: <20240216110313.17039-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Prefer QDev API for QDev objects, avoid the underlying QOM layer.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/musicpal.c | 2 +-
 hw/core/qdev.c    | 2 +-
 hw/sparc/sun4m.c  | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 2020f73a57..74e4d24aab 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1238,7 +1238,7 @@ static void musicpal_init(MachineState *machine)
                           qdev_get_gpio_in(pic, MP_TIMER4_IRQ), NULL);
 
     /* Logically OR both UART IRQs together */
-    uart_orgate = DEVICE(object_new(TYPE_OR_IRQ));
+    uart_orgate = qdev_new(TYPE_OR_IRQ);
     object_property_set_int(OBJECT(uart_orgate), "num-lines", 2, &error_fatal);
     qdev_realize_and_unref(uart_orgate, NULL, &error_fatal);
     qdev_connect_gpio_out(uart_orgate, 0,
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index c68d0f7c51..a271380d20 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -171,7 +171,7 @@ DeviceState *qdev_try_new(const char *name)
     if (!module_object_class_by_name(name)) {
         return NULL;
     }
-    return DEVICE(object_new(name));
+    return qdev_new(name);
 }
 
 static QTAILQ_HEAD(, DeviceListener) device_listeners
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index d52e6a7213..fedc4b8b3f 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -979,7 +979,7 @@ static void sun4m_hw_init(MachineState *machine)
     sysbus_mmio_map(s, 0, hwdef->ms_kb_base);
 
     /* Logically OR both its IRQs together */
-    ms_kb_orgate = DEVICE(object_new(TYPE_OR_IRQ));
+    ms_kb_orgate = qdev_new(TYPE_OR_IRQ);
     object_property_set_int(OBJECT(ms_kb_orgate), "num-lines", 2, &error_fatal);
     qdev_realize_and_unref(ms_kb_orgate, NULL, &error_fatal);
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(ms_kb_orgate, 0));
@@ -1000,7 +1000,7 @@ static void sun4m_hw_init(MachineState *machine)
     sysbus_mmio_map(s, 0, hwdef->serial_base);
 
     /* Logically OR both its IRQs together */
-    serial_orgate = DEVICE(object_new(TYPE_OR_IRQ));
+    serial_orgate = qdev_new(TYPE_OR_IRQ);
     object_property_set_int(OBJECT(serial_orgate), "num-lines", 2,
                             &error_fatal);
     qdev_realize_and_unref(serial_orgate, NULL, &error_fatal);
-- 
2.41.0


