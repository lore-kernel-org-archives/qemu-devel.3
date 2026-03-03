Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B00EDEBFA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 22:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxY81-0004gH-5p; Tue, 03 Mar 2026 17:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxY7z-0004ey-IW
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 17:22:07 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxY7x-0002P0-UO
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 17:22:07 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4837907f535so54790715e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 14:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772576524; x=1773181324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xtq/5HasaYF/u2JgkoCvWSDDmD9TojuUdZIFbfZPAYc=;
 b=OrMGEhWEtzTyATo2uQ1YjTj+KQ6ZfZukroa3s+KkuJ5Sg4d0jXVp31C9uXn39UhgfN
 /YU7HM64mDAQbOJKcYS5DV2SnryqLF0feP4wPTlzuA9TuObY2g4ZHOO0v9XpesxRcVz6
 HDXMkwx2tVKmb64YvG6Se32xGGUsftIyU16a/d69RMfn0nF+DUQey+3tL7kEZ4v/qosJ
 5EuGpnHOfTPSwy6IdIgwe/Z/vxnRFCBJfWjDJ1Hr0pa74z7Ufl3mufmHheCzgdqhrq9Q
 4DgGTkhkWt1cFwnYEVjSK9pYo8f3B5+lplhcSR7wr2gKr5s6BbMDBANu5u2x2K4r/hR9
 V4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772576524; x=1773181324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xtq/5HasaYF/u2JgkoCvWSDDmD9TojuUdZIFbfZPAYc=;
 b=jxVlV0KrK4YD+bUtQwST67rdDYyi3LUQPOW7CHKTwx2kAWsP4AjARxAcyaeMGwPY9U
 U+IFJ/rQ58cd+rpJmSHeYemJo9x6OW7XYNhhWxPTKiEpWRA9Yj8mmPGJyMhpSX5Xo4Bs
 cKpys/cE7/ryNiUVCxrW6SVHiMG0VVLZCQ9uldw35+HFJsBdycxjv8MssP6mrt7VJ06Z
 Hp1qAGivbc160dmiruZxLCpAxds8u87Gwp36ek5DOVD6+wKJg+nHTFUmmypi3FFfdD17
 NL8Pn2U+GUvBR1B33wlBs+HmJifdMB63wD20efw+dAfk3svLWlKCEk2mwwCskD/A2pjP
 tsGw==
X-Gm-Message-State: AOJu0YwcJUqyaPZ+Nlhaga4DBZt51KpPI+2jHkM4SmCddgH3Gvv8qxxG
 D5rZXOcRO8fVSZYLYfj0l3amYwf9v/wzNORR2dSC23EbyPxvD0w06fKOq5L0qw==
X-Gm-Gg: ATEYQzyMxcBSrGMwncRcVjJfSNyLtekCPzg0J+oqzz2Z6vBiRiA2nBHhqbwF4DxncgR
 z2ICP1DPI3vUhWX/122o4cNrefK4g6y3gJVKiAkOWY1CrvIE4pHYMByRfVmh/wy9OHs510ne89Z
 aPIwxOxf2qU+Vbgi83YAy3XXbuMHG+u6aBmgyXpLIJkHBegtVDfY3AAmHzpiqEr/1hsy2uPfoFa
 HRJ33QpQn/HltJT0RmPiNsw77MvKEiPR03++2g+R8G98zZXU/Ph40CKWmUHwNbFME3lnOJMqTVY
 68sCjoJJKqsN1ZyYmltIOuxOrdVWgBN419bOCs6fKYsb6IctAtmOln51ONCTVtaPVl/GSacfmpv
 RAG5+ypIMWBl6oNA8b0asnjGsVssJr/E6LQMs3VoaUvuP4zwFRP/DPtxCdKLrhD65NzXkInwKV0
 rp0sn0oV5AQgZEv+OmuKurj+/0rUpTBhKi4kz07mjSzziljP2IHSc3WTEuTck9gGfSBF8XY+juT
 nWkt0HVr2e3bUD3TkKsimLeLNFALxk=
X-Received: by 2002:a05:600c:a0a:b0:483:7813:90d8 with SMTP id
 5b1f17b1804b1-483c9b94296mr279196615e9.1.1772576523993; 
 Tue, 03 Mar 2026 14:22:03 -0800 (PST)
Received: from Provence
 (dynamic-2a02-3100-1c79-b600-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c79:b600:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485187c81adsm7577715e9.6.2026.03.03.14.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 14:22:03 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-arm@nongnu.org,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 02/13] hw/arm/aspeed_ast27x0-{ssp,
 tsp}: Do not access SerialMM internals directly
Date: Tue,  3 Mar 2026 23:21:32 +0100
Message-ID: <20260303222143.142741-3-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303222143.142741-1-shentey@gmail.com>
References: <20260303222143.142741-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SerialMM inherits from SysBusDevice and exposes the memory region by
means of sysbus_mmio_get_region(). Use that in order to avoid accessing
implementation details of SerialMM.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed_ast27x0-ssp.c | 7 ++++---
 hw/arm/aspeed_ast27x0-tsp.c | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index 9b12ba6743..8b84300e0f 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -149,6 +149,7 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
     AspeedCoprocessorState *s = ASPEED_COPROCESSOR(dev_soc);
     AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
     DeviceState *armv7m;
+    MemoryRegion *mr;
     g_autofree char *sdram_name = NULL;
     int i;
 
@@ -230,9 +231,9 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
     }
 
     /* UART */
-    memory_region_init_alias(&s->uart_alias, OBJECT(s), "uart.alias",
-                             &s->uart->serial.io, 0,
-                             memory_region_size(&s->uart->serial.io));
+    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(s->uart), 0);
+    memory_region_init_alias(&s->uart_alias, OBJECT(s), "uart.alias", mr, 0,
+                             memory_region_size(mr));
     memory_region_add_subregion(s->memory, sc->memmap[s->uart_dev],
                                 &s->uart_alias);
     /*
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index e39d1dc171..e7c7b74491 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -149,6 +149,7 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
     AspeedCoprocessorState *s = ASPEED_COPROCESSOR(dev_soc);
     AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
     DeviceState *armv7m;
+    MemoryRegion *mr;
     g_autofree char *sdram_name = NULL;
     int i;
 
@@ -230,9 +231,9 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
     }
 
     /* UART */
-    memory_region_init_alias(&s->uart_alias, OBJECT(s), "uart.alias",
-                             &s->uart->serial.io, 0,
-                             memory_region_size(&s->uart->serial.io));
+    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(s->uart), 0);
+    memory_region_init_alias(&s->uart_alias, OBJECT(s), "uart.alias", mr, 0,
+                             memory_region_size(mr));
     memory_region_add_subregion(s->memory, sc->memmap[s->uart_dev],
                                 &s->uart_alias);
     /*
-- 
2.53.0


