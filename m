Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F3CC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 19:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUtOz-0001Jq-Ps; Tue, 30 Jan 2024 14:04:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUtOn-00014U-Gj
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 14:04:01 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUtOd-00005J-MW
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 14:03:57 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a26fa294e56so554640666b.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 11:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706641426; x=1707246226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Enae3717LfHgjJzKTiqqlkaB8nPVlBbey3ho9e5HGg=;
 b=JulB6Hj3gCGVEnrr6MwGJB0z1dUhaP8TtMFqupeL9FT5aJCARaH4BGbEDV+hpfhp/O
 +jjwST9QaY2arOpQti8vD5w/HJPsZP1fyORC+VEyfzUNMn9yVPFFBPNMKzrNqfFUv/bM
 xuf7Qb2Ym+TEkLg2uuoF03IPTwydcCzQiAVjUOjmybvGgUuX/EvYbBy93VvP1aqWTXXE
 esSnPGsofZCDK59jSFeXdIZxezPN+/A/3eSkmYHF2sFIl3F9sgnXUiH4g73PqiblQIy4
 KUy+oRDoqVsWqs/7NbbsS4CTtghtgvWbWZBecuTNV8VZYSv4eFucRZi0cQJpjySWxvjm
 VwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706641426; x=1707246226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Enae3717LfHgjJzKTiqqlkaB8nPVlBbey3ho9e5HGg=;
 b=N+CHvjFTXLh34+oPYMvbrbVeSwdX2p36fXKHYVeZGpatS+Sa6o+8T+Y9kohWysleVP
 7kaUU6qKjJCfHYJluk7UV5JjF9oLORSwkMI5HFnT0QvvhL/GRKLkzc09f9L9JhhBtZ9c
 BEXVFp3T0wj4GUYsRt5gn5Nujz8HutoqvNx46E8NI1tYy4A7UIdSgDwvMPHRHbkKkcwR
 eAqj7MD+QMH2yIVip3mWUa6urSbzK8/ft1ltAxzVZM95jnU/eD3RWogFF+ZsbwTB1YeZ
 nWkezrLCSjo96gYhsFU7xyn/qsNs9ViqvFoYU4g+lYIXsCuURurA6WrhYFNmQo/7ettU
 elPQ==
X-Gm-Message-State: AOJu0YyOfT3oUi9vx87f2MlX/bw3uL0Vbfqcr9fB2jL7pn0EcPEmiGGY
 PemalNvjuGjSAKCJtC2d9xZ4dS3kLZe44bLcTJE0jSa+iOgl+PlObzwTjVFU5sIJqm86LAjB/c+
 4
X-Google-Smtp-Source: AGHT+IGB8x+TSc0/5ym2fJKu8/neM1jd8yYRvGPf00SFZY7NkLvyD+LuruvQU1tGSYzsnluku+fLiA==
X-Received: by 2002:a17:906:7190:b0:a31:7e46:eac4 with SMTP id
 h16-20020a170906719000b00a317e46eac4mr137038ejk.45.1706641425935; 
 Tue, 30 Jan 2024 11:03:45 -0800 (PST)
Received: from m1x-phil.lan ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 vu12-20020a170907a64c00b00a3006857c55sm5359923ejc.130.2024.01.30.11.03.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jan 2024 11:03:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/4] hw/arm/stellaris: Add missing QOM 'SoC' parent
Date: Tue, 30 Jan 2024 20:03:17 +0100
Message-ID: <20240130190317.25692-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240130190317.25692-1-philmd@linaro.org>
References: <20240130190317.25692-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

QDev objects created with qdev_new() need to manually add
their parent relationship with object_property_add_child().

Since we don't model the SoC, just use a QOM container.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/stellaris.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index bb88b3ebde..e349981308 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1018,6 +1018,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
      * 400fe000 system control
      */
 
+    Object *soc_container;
     DeviceState *gpio_dev[7], *nvic;
     qemu_irq gpio_in[7][8];
     qemu_irq gpio_out[7][8];
@@ -1038,6 +1039,9 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     flash_size = (((board->dc0 & 0xffff) + 1) << 1) * 1024;
     sram_size = ((board->dc0 >> 18) + 1) * 1024;
 
+    soc_container = object_new("container");
+    object_property_add_child(OBJECT(ms), "soc", soc_container);
+
     /* Flash programming is done via the SCU, so pretend it is ROM.  */
     memory_region_init_rom(flash, NULL, "stellaris.flash", flash_size,
                            &error_fatal);
@@ -1052,6 +1056,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
      * need its sysclk output.
      */
     ssys_dev = qdev_new(TYPE_STELLARIS_SYS);
+    object_property_add_child(soc_container, "sys", OBJECT(ssys_dev));
     /* Most devices come preprogrammed with a MAC address in the user data. */
     macaddr = nd_table[0].macaddr.a;
     qdev_prop_set_uint32(ssys_dev, "user0",
@@ -1068,6 +1073,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     sysbus_realize_and_unref(SYS_BUS_DEVICE(ssys_dev), &error_fatal);
 
     nvic = qdev_new(TYPE_ARMV7M);
+    object_property_add_child(soc_container, "v7m", OBJECT(nvic));
     qdev_prop_set_uint32(nvic, "num-irq", NUM_IRQ_LINES);
     qdev_prop_set_uint8(nvic, "num-prio-bits", NUM_PRIO_BITS);
     qdev_prop_set_string(nvic, "cpu-type", ms->cpu_type);
@@ -1101,6 +1107,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
 
             dev = qdev_new(TYPE_STELLARIS_GPTM);
             sbd = SYS_BUS_DEVICE(dev);
+            object_property_add_child(soc_container, "gptm[*]", OBJECT(dev));
             qdev_connect_clock_in(dev, "clk",
                                   qdev_get_clock_out(ssys_dev, "SYSCLK"));
             sysbus_realize_and_unref(sbd, &error_fatal);
@@ -1114,7 +1121,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
 
     if (board->dc1 & (1 << 3)) { /* watchdog present */
         dev = qdev_new(TYPE_LUMINARY_WATCHDOG);
-
+        object_property_add_child(soc_container, "wdg", OBJECT(dev));
         qdev_connect_clock_in(dev, "WDOGCLK",
                               qdev_get_clock_out(ssys_dev, "SYSCLK"));
 
@@ -1154,6 +1161,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
             SysBusDevice *sbd;
 
             dev = qdev_new("pl011_luminary");
+            object_property_add_child(soc_container, "uart[*]", OBJECT(dev));
             sbd = SYS_BUS_DEVICE(dev);
             qdev_prop_set_chr(dev, "chardev", serial_hd(i));
             sysbus_realize_and_unref(sbd, &error_fatal);
@@ -1276,6 +1284,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
         qemu_check_nic_model(&nd_table[0], "stellaris");
 
         enet = qdev_new("stellaris_enet");
+        object_property_add_child(soc_container, "enet", OBJECT(enet));
         qdev_set_nic_properties(enet, &nd_table[0]);
         sysbus_realize_and_unref(SYS_BUS_DEVICE(enet), &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(enet), 0, 0x40048000);
-- 
2.41.0


