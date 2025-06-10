Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509DCC5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 13:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOyas-0000ro-02; Tue, 10 Jun 2025 09:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyYN-0007hZ-Gx
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:58:14 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyYK-0002hb-UB
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:58:11 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so70528405e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 05:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749560287; x=1750165087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=taQBYKGiataMrkl3P46PoMWshwDonRVg+ORcNAH8umE=;
 b=fDsvVSsvE7OzFVbX4PNzyQyeSYNxq7yLhO/0e9AF6aJS7S+xgQDbupBBKl8JzCLUPf
 GE6fl2PAqGW4HKDpTlfugGzf9Dy9v3BIMMl+1NzEv+oP6/H+5BZgoKCghHVtx8iItv46
 ZkGz055HVxQyU3DKxYDt3M5o64fHidL0tvhp4nzFhyqpEyKyGbqN2f7pSoKrldW0UlYw
 QnAY2IvKiczwkz+bmJo2Y7Wni+TIqTcbtGuEN27GHWVqgmBt/DiOgNtZnb9ozZZYu2MX
 5I4SRcwzvEjNpceAB+IrDVMEAZ7uEwCbhAhjkft+LMzmrpuEenaDZaa8dMu09adVT2S/
 zCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749560287; x=1750165087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=taQBYKGiataMrkl3P46PoMWshwDonRVg+ORcNAH8umE=;
 b=ihmTbxE1DPdKS4yW/m9TEdsT+hc5ua1IbcC8ZxZEgY8wk3rAA08sW/5c6rCaM9c5di
 M8krERZE+Y7nTatT8RuryMBwVVlUjRbP/ltxeFJnM+2UTJBY/NZssYIcaVaMkWSckR/T
 crDe9p88D+C8XsJUsTlF8KQx/OBh+xvcrkh3ZOpoxnzGnolxllVc7hpY4YXa6boMlFMy
 lP4boNxeVtcc1jboyY/Juc9C+HAyUCjeVnvcxSWUdOWuBnbMnsKPldGTkRslatos+b9c
 bCkWk1orcDIEyW4oVaFIcK+Ji5NeFAm7lJw1GuHSsqKJzHW2PbdHVePdOnhg3HFONdSU
 zEhg==
X-Gm-Message-State: AOJu0Yzg/g4ALruM+9dCZt9X4cf+JL1ahji+16bSCKNU+sIy5P6j0Yx0
 ZOIOy3klGfWah0pM6vlVkfWCMSohd3S3R1nmN5J9ZWb6d5GS8tEI/dnNJMJTYywfqus1aNEr2LG
 2jxV8vQE=
X-Gm-Gg: ASbGncs4U2MjZOiHHWBhqrMCCsgOXw0K8o0NQMM1eKMelw9yzWvyogCbdEW2L36CwvS
 eO7FwvLjPRrcsr4fFvt3I9nXIoJtnkVntCAGHrQUNuX2BFmVi7XMfE57gZTtGM/zQEwAThTsU0H
 E8jrS578NbRzpo4xj5dXXFzSclqxAAfoKdQcO2uGCxSNuCANJOdrN2wddgb/i+RZ81gE/bCDjAr
 Dpk3LUx7/p7QdTQjlUVEqevc0djHy0EqIz6BhyzJxpLdnquccjCrtwf3W4jt9tw6flsNABcXWY2
 0XrcH0PZ+cB9bmE5NxOM+brTI8dgfb8yIyx9bWBn0SRwlFOzX1lzcV/qdGQhkqY1ig3jqTnJSCs
 Ls45IFw2tILWgMKX40GNXIcuJuVUABea4aAKDN4mNU/dDEPNMlYJA
X-Google-Smtp-Source: AGHT+IG/8wsFeyevifiDQkct0SB0x01VNl7qRnuZfeLXkpx3bbv7EFKQjC6FuyFKtdmgFQwdRZjQ0Q==
X-Received: by 2002:a05:6000:430c:b0:3a5:1240:6802 with SMTP id
 ffacd0b85a97d-3a531cb2a63mr13700643f8f.57.1749560286854; 
 Tue, 10 Jun 2025 05:58:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244f07dsm12432763f8f.79.2025.06.10.05.58.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Jun 2025 05:58:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 20/24] hw/gpio/aspeed: Fix definition of AspeedGPIOClass
Date: Tue, 10 Jun 2025 14:56:29 +0200
Message-ID: <20250610125633.24411-21-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610125633.24411-1-philmd@linaro.org>
References: <20250610125633.24411-1-philmd@linaro.org>
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

AspeedGPIOClass's parent is SysBusDeviceClass rather than SysBusDevice.
This isn't catastrophic only because sizeof(SysBusDevice) >
sizeof(SysBusDeviceClass).

Fixes: 4b7f956862dc ("hw/gpio: Add basic Aspeed GPIO model for AST2400 and AST2500")
Closes: https://lists.gnu.org/archive/html/qemu-devel/2025-06/msg00586.html
Suggested-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Message-ID: <20250606092406.229833-4-zhenzhong.duan@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/gpio/aspeed_gpio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/gpio/aspeed_gpio.h b/include/hw/gpio/aspeed_gpio.h
index e1e6c543339..e6b2fe71b50 100644
--- a/include/hw/gpio/aspeed_gpio.h
+++ b/include/hw/gpio/aspeed_gpio.h
@@ -70,7 +70,7 @@ typedef struct AspeedGPIOReg {
 } AspeedGPIOReg;
 
 struct AspeedGPIOClass {
-    SysBusDevice parent_obj;
+    SysBusDeviceClass parent_class;
     const GPIOSetProperties *props;
     uint32_t nr_gpio_pins;
     uint32_t nr_gpio_sets;
-- 
2.49.0


