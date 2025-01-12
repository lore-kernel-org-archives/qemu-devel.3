Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE332E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6sq-0007C0-UB; Sun, 12 Jan 2025 17:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6sg-000745-PF
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:56:30 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6sf-0001ZW-7l
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:56:30 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso25753855e9.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736722586; x=1737327386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2P6utQTgIOG24muh2STqCnSn8EGidw/ozbeVNIgt5Qs=;
 b=eqbY9VjZvl82B6wKXGXxwF/YtgopRob7R+s0pY/XEBNiFVdnQKgiClrXgqGlWM4eOZ
 AUboeSFEDCFWVb1I57kvM/IYMYDlNLgyDuGPyunT0vxsGnTiKkR3+pwFBTRQMHMzpqfr
 Sz8uXzbhljJ9Dyw+E4gvUfsINvF7DkJ6s/dA/Fs1oKQCJ40w3ln5Rr16ZfFmMAgXHjtn
 fOp4LoDDVDTN5ogDjhS/nn+jUnboeUr16sJZGNzxxQL1EDWfmyg598dky8Gp8rbxtJ6j
 DW6OA8Kl6ROjnsJVCTVt8NCptMmnRDVPpGWT57cU4EbHfxvda9EqV8r/FI/eJ243hg91
 r3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736722586; x=1737327386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2P6utQTgIOG24muh2STqCnSn8EGidw/ozbeVNIgt5Qs=;
 b=iru3dctVN14nU/c+kynLeSVUrcIyMTDao3yiNqfwghfvLroqYuGwhcIA9GGJ0I9EcR
 nqiTQGnE2dBS2NTisihW+C1Ztjwm12YzTV0BEF27FmUMbVXslt7EY0ZdKFvMtE3xxfiF
 fkPyzhP2eVhVR3voX4b+3WaozgSw/TZ1yXVg5+Fs6ZygbxAq3eC0Aik593RVRB9T1Ybz
 fZ7eDlwKtzFX+9j0Wdlp79eg3Z1R/HdG8e8Obute1qsGHfDupVMKQLkhwJJQ0XcHxJ5Z
 xEU5VNUFSmTxLjHL8xcB6N0J8SD42T9iNLof1utMvmQhrbEVO3fkviJ1GgIALCtLSB3A
 M8Qw==
X-Gm-Message-State: AOJu0YxPTBY4W1ltNTZ7jjHuQI/8CcGd5v8Z3s8S1QQ8Y10+gV04cMnL
 5jVLiGiKcC8pcTpIAZZxZ8FoFsJ0HOWs19j1qg4QQ6fMwWwgoIhX4qmgIydzzjYbva+fgRNu72v
 ZEpw=
X-Gm-Gg: ASbGncsKNdP9hYlQT+PaHw7d+8wkyhhz0bxX3TCMRuflPuNdIzyuiHcQSUKmU2+JmsS
 CJ3x6XLIXoI+S/TXelhDTprgmchwOsuUTRR7NoPhgBBfLcXGzo+en8CAX5EWTkvbB8Sy7Iix2cw
 q4+tGyKhHCX+9lBvH0OH02g/ksn7+zOEBCXngQZJ/aLJHi9PJ97JhiMTzglDTFzfYg7f/1Kxr0B
 At4V1D9PJivcZX4rv581C0rGBwJHBnl5hd/QMDnhF+N9TeGJDSz1UnMvg9yLpUxKNe4OUm/u/PO
 sYf8+fSvqIVRWta3XfmBTuFselNRJkw=
X-Google-Smtp-Source: AGHT+IH+5YafZH2P42CltqfpGc83dhL86YZLmypoK3N2S/d99qVlK9EdA6lwoAYn1L19DIRD3I156Q==
X-Received: by 2002:a05:600c:3593:b0:431:6083:cd38 with SMTP id
 5b1f17b1804b1-436e2696e93mr147917025e9.6.1736722586315; 
 Sun, 12 Jan 2025 14:56:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b80besm10442329f8f.83.2025.01.12.14.56.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:56:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Samuel Tardieu <sam@rfc1149.net>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Felipe Balbi <balbi@kernel.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Joel Stanley <joel@jms.id.au>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] hw/arm/stellaris: Add 'armv7m' local variable
Date: Sun, 12 Jan 2025 23:56:13 +0100
Message-ID: <20250112225614.33723-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112225614.33723-1-philmd@linaro.org>
References: <20250112225614.33723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

While the TYPE_ARMV7M object forward its NVIC interrupt lines,
it is somehow misleading to name it 'nvic'. Add the 'armv7m'
local variable for clarity, but also keep the 'nvic' variable
behaving like before when used for wiring IRQ lines.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/stellaris.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 1bba96df14e..7303e096ef7 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1031,7 +1031,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
      */
 
     Object *soc_container;
-    DeviceState *gpio_dev[7], *nvic;
+    DeviceState *gpio_dev[7], *armv7m, *nvic;
     qemu_irq gpio_in[7][8];
     qemu_irq gpio_out[7][8];
     qemu_irq adc;
@@ -1095,19 +1095,20 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     qdev_prop_set_uint32(ssys_dev, "dc4", board->dc4);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(ssys_dev), &error_fatal);
 
-    nvic = qdev_new(TYPE_ARMV7M);
-    object_property_add_child(soc_container, "v7m", OBJECT(nvic));
-    qdev_prop_set_uint32(nvic, "num-irq", NUM_IRQ_LINES);
-    qdev_prop_set_uint8(nvic, "num-prio-bits", NUM_PRIO_BITS);
-    qdev_prop_set_string(nvic, "cpu-type", ms->cpu_type);
-    qdev_prop_set_bit(nvic, "enable-bitband", true);
-    qdev_connect_clock_in(nvic, "cpuclk",
+    armv7m = qdev_new(TYPE_ARMV7M);
+    object_property_add_child(soc_container, "v7m", OBJECT(armv7m));
+    qdev_prop_set_uint32(armv7m, "num-irq", NUM_IRQ_LINES);
+    qdev_prop_set_uint8(armv7m, "num-prio-bits", NUM_PRIO_BITS);
+    qdev_prop_set_string(armv7m, "cpu-type", ms->cpu_type);
+    qdev_prop_set_bit(armv7m, "enable-bitband", true);
+    qdev_connect_clock_in(armv7m, "cpuclk",
                           qdev_get_clock_out(ssys_dev, "SYSCLK"));
     /* This SoC does not connect the systick reference clock */
-    object_property_set_link(OBJECT(nvic), "memory",
+    object_property_set_link(OBJECT(armv7m), "memory",
                              OBJECT(get_system_memory()), &error_abort);
     /* This will exit with an error if the user passed us a bad cpu_type */
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(nvic), &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(armv7m), &error_fatal);
+    nvic = armv7m;
 
     /* Now we can wire up the IRQ and MMIO of the system registers */
     sysbus_mmio_map(SYS_BUS_DEVICE(ssys_dev), 0, 0x400fe000);
-- 
2.47.1


