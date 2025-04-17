Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D667EC369CB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 00:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Z8R-0007Fm-6Y; Thu, 17 Apr 2025 19:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Z8Q-0007FO-BP
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 19:59:10 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Z8O-00041z-3Q
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 19:59:10 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so10226125e9.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 16:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744934346; x=1745539146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yYW2b9J9rpRFJ7QVGZ2mZ7NVt+Xm7Wy9C2Beg149RFE=;
 b=Gwv5TRxm12t5Dg9LE9AnVS0VhVvj0SimlvsP37r1Fgjn9Ce1az2xyoECgV2aiu4TXp
 KvpM7Lpjk3uyjbnCk2n7RSBWI+Rzea5yG1yeGE/HyOnKBCWU9tGIF8Tbz3P2Bdl/FCyk
 GCeL2I2xzgVGAFesX9zh7ZI8fmeM23HJQppBCLpLwIcI5+p9GQ9SKG5VGijYHW+fc6dB
 Fm90vGlNM1Gmq7A/njg17S/z3W50ccByINopmBHa7+dIgY6/Bbm8VsCkMEZ/iEZFFBU6
 L+EvLR/4RGnuJFao6lMzqtAxy4wScXjIw1LwDMDKdZu7obXLWT3zEJgN5zx7AYIVzMLR
 o30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744934346; x=1745539146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yYW2b9J9rpRFJ7QVGZ2mZ7NVt+Xm7Wy9C2Beg149RFE=;
 b=nA0xNWngWk4rTk+bNst0vzajik7wlF1OikVFC9eqyHR/hewJJWfoipJ1Yq0FtpqwSm
 SLB2ZQjjmhsjcCLE8wBE+oo/CBbfBYNr64O4LcK+U0EZHZlgDln8XPEs5UNfxwBwOz/Z
 5f3JCi5+HnuwobdjqO+c2uk+k0FWeSowNdUbTowd8KAeoW93tnKh/q3Bd/RnP4hLMF6w
 KVEWIrHB3IPIE7/d0EN2/NMH0su9Z2FWbBGWDvnr3iEIAFZ5bsMz3Ri7+K/tl/sotNm0
 uNGTxxhmg0IpkApugOtYIsI/FciZG0UmNmjsAZy+md8/j4UYqJF5zG7F7hbOeoCLghZH
 1wZg==
X-Gm-Message-State: AOJu0YxCCcXHs4aC0vL6Jt8aw0yt5kj/aY2j6wg1LcRTE8RWnpAIEV4T
 1gmbQBdF9p3+xjQDICb5xcPE9p60UabSMAbdaLyzqWY1G9VP2RhWwTX9Slr5Ibeb/plM883czUF
 l
X-Gm-Gg: ASbGncubsSTAQdQ2M21WnJQDWlbUPZ0Kcu8TkkOD/+B/oapkVLLWqxaWNQeQ5RhNYB4
 wPd93RAkmCjSNSkwRvXVSjx46IvCYbYtvor931HoGjmcM7F+HShCsFVHScLIy2p95koC7wL1VNK
 DWrlZR7zbTs3gxBbx5bXESe41YzjIf+4Ps+UDQOcvdzRCoEYUzw6mru5/yJLTO6AESry9WauS/O
 nGgni5KhB8WDqYTKSGTVH9c+IgEkl8alfSWJbLkqjWa0b+C7VKIE5OOg+0f6CH6MlIsRhb0LKxN
 RuVLtIl8PERuTfaxmYpQ0M+ijTJ7yoGnNz9d4WzySXXZlphOSuDIUiU0xwEaUOOgkooj1V9OBTR
 UkUcS2EH87wNdfteNAzoe
X-Google-Smtp-Source: AGHT+IG4glvgl098p3Kgp4m4MXxyBDyLul4G2KiAvdRKcT0sJ2LpC7CI4bSln0+AoYiWTf6dF3guRA==
X-Received: by 2002:a05:6000:400d:b0:39c:1f19:f0c3 with SMTP id
 ffacd0b85a97d-39efbad3dffmr512039f8f.46.1744934346291; 
 Thu, 17 Apr 2025 16:59:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa43c018sm1058365f8f.43.2025.04.17.16.59.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 16:59:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Felipe Balbi <balbi@kernel.org>, Bernhard Beschow <shentey@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, Alistair Francis <alistair@alistair23.me>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH 09/11] hw/arm/musicpal: Define machine as generic QOM type
Date: Fri, 18 Apr 2025 01:58:12 +0200
Message-ID: <20250417235814.98677-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250417235814.98677-1-philmd@linaro.org>
References: <20250417235814.98677-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_XBL=0.375, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

While DEFINE_MACHINE() is a succinct macro, it doesn't
allow registering QOM interfaces to the defined machine.
Convert to the generic DEFINE_TYPES() in preparation to
register interfaces.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/musicpal.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 48a32c24079..f7c488cd1d6 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1334,8 +1334,10 @@ static void musicpal_init(MachineState *machine)
     arm_load_kernel(cpu, machine, &musicpal_binfo);
 }
 
-static void musicpal_machine_init(MachineClass *mc)
+static void musicpal_machine_class_init(ObjectClass *oc, void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Marvell 88w8618 / MusicPal (ARM926EJ-S)";
     mc->init = musicpal_init;
     mc->ignore_memory_transaction_failures = true;
@@ -1346,8 +1348,6 @@ static void musicpal_machine_init(MachineClass *mc)
     machine_add_audiodev_property(mc);
 }
 
-DEFINE_MACHINE("musicpal", musicpal_machine_init)
-
 static void mv88w8618_wlan_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1375,3 +1375,13 @@ static void musicpal_register_types(void)
 }
 
 type_init(musicpal_register_types)
+
+static const TypeInfo musicpal_types[] = {
+    {
+        .name           = MACHINE_TYPE_NAME("musicpal"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = musicpal_machine_class_init,
+    },
+};
+
+DEFINE_TYPES(musicpal_types)
-- 
2.47.1


