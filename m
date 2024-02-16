Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EB2C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 15:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb0FT-00044N-GF; Fri, 16 Feb 2024 10:35:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rb0FQ-000437-L4
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 10:35:33 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rb0FN-0008AI-Ry
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 10:35:32 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d220e39907so2713421fa.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 07:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708097727; x=1708702527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kV0Ad1FDMlSK0WAR0PyajC3eAS8o+2asLjvJepPvncc=;
 b=HpUsT+RlZVpYnQ6h9RCN+nUP1cq60oJ5XTz2Wtf557ztUG3ojkGYgh7iQLX4BVIO3o
 UkNYCbIMSd81wxIGBl6GGgQuNJyuM/CcY7MocFJlllFzvm8BbH4d6JWMKFEerpciD18R
 g10EnuZHiVpMCb8fp08hs2iBjoGAVdNOzjMQkO3dpc67UlaK7KeS35wBBumbHvWV43io
 7PlQ2KuqGI/OhY4shGkiws4MZm3hkkKn5N5B2RTk7Q4o1p1n8Ab1Wpj2UWTvAtUeCz0a
 v8264ovUU+OX/Jc4esMED2EQgeqGOuputz3ngcaDf507JyoY7L6OqntbM2vz2tztaj+Y
 cvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708097727; x=1708702527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kV0Ad1FDMlSK0WAR0PyajC3eAS8o+2asLjvJepPvncc=;
 b=rhooZrIReiuYjf/RmtdtS5TkVWQlLTAwkWCiAk+ZRNxgffinsq2zUnKRfYjIj1Wr4c
 nAgECbpuem/Magi83/EAH3GiRKo/+rcF8hX6ZOOPWly7k78luftYdXpmo7h2u4EdjaSO
 boN8cQdIcuC3XrrCApczZ4siH3R9r0HQS8qrvuuahQ1RDt/uxJ0VDaPOQ17RlL10qgfw
 sDPdweOBM9JOHRBMfib2pc7V+CzbIh3eP5vN5/saff/55f4YcZXzWYFAe9fU9Tt0qjZb
 UUVbFU59AaxYh4kmcxKCjTvW2G0+9eawu8pifMqPg6KhFvM3pFzOce52IdkGZx9kHb/7
 B3ag==
X-Gm-Message-State: AOJu0Yy6mzoPpBZygBmhkxaMWs5X0zHRgjiwpNyLJ+Xdlw9BmlwgsLUP
 Iz4x8yy/1QvAmW86h/mphW2uKi2SbClEm7o3MPkyqATQiw5BbarLcQfHDmd4s8wSnjMZA62q2fX
 f
X-Google-Smtp-Source: AGHT+IGfgXbpqZgKjNCGN8KVVHtzk2yqUaFF2+wmjjuAVnYD5GbeKX6Jl3GUMNEQNUdVj+AH74b60A==
X-Received: by 2002:a05:6512:20ce:b0:511:78bb:1a4d with SMTP id
 u14-20020a05651220ce00b0051178bb1a4dmr3559454lfr.17.1708097727158; 
 Fri, 16 Feb 2024 07:35:27 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 rn28-20020a170906d93c00b00a36c5b01ef3sm42951ejb.225.2024.02.16.07.35.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Feb 2024 07:35:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/6] hw/arm: Inline sysbus_create_simple(PL110 / PL111)
Date: Fri, 16 Feb 2024 16:35:12 +0100
Message-ID: <20240216153517.49422-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240216153517.49422-1-philmd@linaro.org>
References: <20240216153517.49422-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

We want to set another qdev property (a link) for the pl110
and pl111 devices, we can not use sysbus_create_simple() which
only passes sysbus base address and IRQs as arguments. Inline
it so we can set the link property in the next commit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/realview.c    |  5 ++++-
 hw/arm/versatilepb.c |  6 +++++-
 hw/arm/vexpress.c    | 10 ++++++++--
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 9058f5b414..77300e92e5 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -238,7 +238,10 @@ static void realview_init(MachineState *machine,
     sysbus_create_simple("pl061", 0x10014000, pic[7]);
     gpio2 = sysbus_create_simple("pl061", 0x10015000, pic[8]);
 
-    sysbus_create_simple("pl111", 0x10020000, pic[23]);
+    dev = qdev_new("pl111");
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x10020000);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[23]);
 
     dev = sysbus_create_varargs("pl181", 0x10005000, pic[17], pic[18], NULL);
     /* Wire up MMC card detect and read-only signals. These have
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index d10b75dfdb..7e04b23af8 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -299,7 +299,11 @@ static void versatile_init(MachineState *machine, int board_id)
 
     /* The versatile/PB actually has a modified Color LCD controller
        that includes hardware cursor support from the PL111.  */
-    dev = sysbus_create_simple("pl110_versatile", 0x10120000, pic[16]);
+    dev = qdev_new("pl110_versatile");
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x10120000);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[16]);
+
     /* Wire up the mux control signals from the SYS_CLCD register */
     qdev_connect_gpio_out(sysctl, 0, qdev_get_gpio_in(dev, 0));
 
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index aa5f3ca0d4..671986c21e 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -276,6 +276,7 @@ static void a9_daughterboard_init(VexpressMachineState *vms,
 {
     MachineState *machine = MACHINE(vms);
     MemoryRegion *sysmem = get_system_memory();
+    DeviceState *dev;
 
     if (ram_size > 0x40000000) {
         /* 1GB is the maximum the address space permits */
@@ -297,7 +298,9 @@ static void a9_daughterboard_init(VexpressMachineState *vms,
     /* Daughterboard peripherals : 0x10020000 .. 0x20000000 */
 
     /* 0x10020000 PL111 CLCD (daughterboard) */
-    sysbus_create_simple("pl111", 0x10020000, pic[44]);
+    dev = qdev_new("pl111");
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x10020000);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[44]);
 
     /* 0x10060000 AXI RAM */
     /* 0x100e0000 PL341 Dynamic Memory Controller */
@@ -650,7 +653,10 @@ static void vexpress_common_init(MachineState *machine)
 
     /* VE_COMPACTFLASH: not modelled */
 
-    sysbus_create_simple("pl111", map[VE_CLCD], pic[14]);
+    dev = qdev_new("pl111");
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, map[VE_CLCD]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[14]);
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
     pflash0 = ve_pflash_cfi01_register(map[VE_NORFLASH0], "vexpress.flash0",
-- 
2.41.0


