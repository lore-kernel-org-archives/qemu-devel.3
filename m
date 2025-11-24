Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3829CFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 09:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNTHb-0005Wv-BE; Mon, 24 Nov 2025 04:54:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTEa-0004St-8B
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:51:54 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTEU-0001ZC-Nx
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:51:47 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so34809105e9.3
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 01:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763977899; x=1764582699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t8tG0tPqgGtNakU7Kz6dEt+20+JLjRPjTmlNHec45RY=;
 b=G4JwhbzG1/rECHOzYKsuwM3q19vKRFG5n2dHFWU/G/8Awf30uN12mYibLkBnly/Gxh
 JrmG9KLuynSyWP5wbR1OcE3hFcgkBmVLOK2P8uH9RQ8AaVLgu3x0QOCiwNNUe79VYuVN
 NSO8MVAagP1Jnonj6Fcz2fkjIm+u5DRTL5TtImO/qI7ScBQGX5hQJlDxq5GgeK0OnV14
 sYJYNpS/mWGVXbvb5yVaRx0cOFXGTIMhmICOMJd2dH+Sc7t7JL9PYQJLhSXDMFRxmmD7
 S0eGY9iuWm/rOPf7H3kAKc893e/8ppCJJihkWgK9kNUrFEeAqHzjO077vcaU24ZiwjJ4
 JGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763977899; x=1764582699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t8tG0tPqgGtNakU7Kz6dEt+20+JLjRPjTmlNHec45RY=;
 b=G+lxkaAZ7MetLZ+Dk5zfacxysQV7tlfAitI9S/iD/O6K3DwnJ35FKl0cbWNjnVAV3N
 W7EFTA1/z8ZBxziINWCanMGXB3z8HcrkZASEr3BSX7MEcSR1/fPjVrdMFm8NrISyy0an
 y3pHPPwK264dE7VjoUOspDiMUz7ub4DKyqaqODvta5rUrARTj/5YjBZCUGbrEqQIjPxI
 4UffRNm2H1POkimda3sqa93+KQqAIG39p5Ku1AZGIcnmCZ0ihCqXch6zVp33HrzWA6lv
 28gVE1Rie5GCz3GSFEAXkNgvdDKnchJaCOQdP8b77WJ3AZpIDDZVojr5nZJPZ5h71GNJ
 Ewqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVthgu/tPjI+7mfK7RN0gANKNxwYEFkN0i6nsW+ThmdK3Re7Peg+JhKDTILPz4L/Ok5QiyVKaAr4yxh@nongnu.org
X-Gm-Message-State: AOJu0YwbyFkcY6rx1sZJ9FRB+HruSK4xiwoxMx6jRvQG4la1GJgjaKYf
 UJ2xuHBuBX+9Ltu+ZLe/S3AEgJMDYaldkiPyenCCznsbplqyocKkz2yRV0wwELvKxyQcSi8v0C5
 62eKWQ1FP5A==
X-Gm-Gg: ASbGncvzSrtxH0YRhIVh1HTMfXb80Lg/ZHoAcZnT7F4QUCGehY9Y0RaHctvDQrYuXKI
 kyVslxV6SXxGBr20Fvj9Hv7LPXylFSuxEEa3zuVf33lnR36QeJXl6uIKkCCuYPXuqAYQGPHlaw4
 nTkGazf6n0j61K+FQhxgtI0E4nVlAivSjCh4t3XouMUlVhSKqg1CcE5x4+YZ+x9NwcdNVyYQvYb
 5gqpIv3lMI235PfHQXldf4jEc5Sc+TPYPXZURYsJaqYBOke4u1t7t8GXcoKGkXPH7ZBFMUR/Vzr
 KrWJk4q3KKhRwVqgJfQYf34PMXu8nJ7JYVksWOAt8wmqvfAzFUEB9+FFSpRfWpQzXKGOKMRBXQk
 GqdsF61qSoxtgugVOXBizWZM+RBRFK3llHK656R3sQcLmw32t9Ywi5btjg0XSXYgPbY0Gf+3J5O
 SEZCqB/2t0dG89zek6Quyyt/PdpTXiAbdLoyUigu4bzijf4q/26c72knyoEs3J
X-Google-Smtp-Source: AGHT+IGdRsNhdR8xn4iwXa7PqXFWXUmKyFu0Zd06f7x27fsrYEj1yRhAdcNz0v3/gveF11OZpiAl1Q==
X-Received: by 2002:a05:600c:1c92:b0:477:73e9:dc17 with SMTP id
 5b1f17b1804b1-477c0202473mr133167415e9.35.1763977899659; 
 Mon, 24 Nov 2025 01:51:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf3af0e1sm183240265e9.10.2025.11.24.01.51.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Nov 2025 01:51:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 qemu-devel@nongnu.org
Cc: Rob Landley <rob@landley.net>, Thorsten Glaser <tg@debian.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.0 04/13] hw/sh4/r2d: Use memdev allocation for RAM
Date: Mon, 24 Nov 2025 10:50:59 +0100
Message-ID: <20251124095109.66091-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251124095109.66091-1-philmd@linaro.org>
References: <20251124095109.66091-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Memdev allocated MemoryRegion is initialized by generic code,
so board only needs to opt in to memdev scheme by providing
MachineClass::default_ram_id and using MachineState::ram
instead of manually initializing RAM memory region.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sh4/r2d.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 51c7c3e2e07..5fd06b3b731 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -252,7 +252,7 @@ static void r2d_init(MachineState *machine)
     USBBus *usb_bus;
     r2d_fpga_t *fpga;
     hwaddr sdram_base;
-    uint64_t sdram_size = SDRAM_SIZE;
+    uint64_t sdram_size = machine->ram_size;
 
     switch (machine->ram_size) {
     case 64 * MiB:
@@ -272,7 +272,7 @@ static void r2d_init(MachineState *machine)
     qemu_register_reset(main_cpu_reset, reset_info);
 
     /* Allocate memory space */
-    memory_region_init_ram(sdram, NULL, "r2d.sdram", sdram_size, &error_fatal);
+    memory_region_init_alias(sdram, NULL, "sdram", machine->ram, 0, sdram_size);
     memory_region_add_subregion(address_space_mem, sdram_base, sdram);
     /* Register peripherals */
     s = sh7750_init(cpu, address_space_mem);
@@ -396,6 +396,8 @@ static void r2d_machine_init(MachineClass *mc)
     mc->init = r2d_init;
     mc->block_default_type = IF_IDE;
     mc->default_cpu_type = TYPE_SH7751R_CPU;
+    mc->default_ram_size = 64 * MiB;
+    mc->default_ram_id = "ram";
     mc->default_nic = "rtl8139";
 }
 
-- 
2.51.0


