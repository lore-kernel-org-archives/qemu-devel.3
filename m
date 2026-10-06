Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D747CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 07:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMQq-00006L-06; Wed, 07 Oct 2026 03:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEGMw-0002qM-Vf
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:23:10 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEGMk-0005SY-Ap
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:22:48 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so1063278f8f.2
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 18:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791335895; x=1791940695; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=quIvgnbJMv5vTwzRauO3a7Lqqn6EP9etKReuFzA3ts4=;
 b=PVp8GrYD2qAGW/3MtyGw/Mmp8GlBfCImjQRmVX8U5kvhy1A9QfOZqzyw7WI6ydHTwT
 xa3dPyH7efCqdapqLLwwV/vaq49Cd6DTOWg9jGGCh6vFKos7bgW9lRHvEFBYuXmBEqzO
 tfCujtOpe8WqxXR7D8pRTFdjjSr07tC7Oc1xJoHF0V2FYmnlO++GoIX05YSiMinHVaGu
 4eP8b77mk+5zcECm0fiAxWjFLpbIRmhNNMBjoCV8OuYScZT2mB+3fHmBwNRZ5lXZuSIR
 fOMRV8whsbDDdjFf5hQNOKJMJ9TJ+urruTQ1PpHd4eb9Q5/EcLHSW32dkg36ymMaaOI1
 tgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791335895; x=1791940695;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=quIvgnbJMv5vTwzRauO3a7Lqqn6EP9etKReuFzA3ts4=;
 b=0BeD75dWr4gJas7l7a9ia8jfVObplEJY9o0tK9TSd3PlIQ0TASJhK0ngZgmdUtb8d5
 +JO4TVpBTLW09xxTh522f6M3NwqXnb6RenqmBz2BMu+myzI85n9WmJInwJT0CvJlnBqU
 7ke/qV+jO9eTUlqv0OXznaovOCwb9nFP/t0QMAyozETUMv0xdhIxZbLbDZx3Bi3cdieH
 zsFCkwdMfafr3mL4SI/kQYune29mvWgREw1+HQKZNdNubKDZwHyUnrFsSwonA6Blto+9
 sI6f1ZbkUlkHvZs2i/ljpnlb+iBwcIE3EwYFYrmdCsu7m7itTgc713CjF5ZKaZ1hcnTg
 9jAw==
X-Gm-Message-State: AFq9FYJ472boMn1G7DuyntacUU9yoQS4gN0BQzEbDhBNoyTq8HahCGte
 gog8jnYCHD34RqnS54a1xcLKq0NSG2L7pwwLLpf1W4F7bWPcyHF5mX8iMtmzKA==
X-Gm-Gg: AYBFou1pqSB3YZkMia86s4jEqvkoihSLBlc5aCcu4/j2/fy4JOyA0MqBLI0koy9Z+qZ
 jYbwrWR6WQuLyZZHuiTS9DvW1tAR889WBlVeFWeflnBfocJYew4A5uwiYUQFeTzzIjn6PEyprG4
 gfkSyOn1P8J54SMaZuOc6zN848nlWFqct7F8WELrKq8UCdIWFEYaS/BVFNK2LHDfzJuDyPvUmdV
 cT3CLq/ZhHOGqx3btAKukDzdw6cr2W4gJjIrCp6KamrAHglVy65EknSR64fh28XmxK1wJZP9ABB
 kNm3KZP3vkMUEF6Cav7nLNGQRl9/JlghGtYn+fPLkrFaELaOwSm8f4ZSU9JrBMJWlNdVcO+ZekL
 JBI+h94ZJDoNQr2K46mMMILhZDLIv0pjhpSxnpN51DgfdfBUwcpGHaGWptqF6ClXMm0IC8FUdO7
 qoI8G8s2B0HAFNEjATvreBNgkLDacdyoBWOv93TZEPMxmRUa3rb3mkShFpym9OtAwIO52nZKNWK
 MYs0wO0KXsiVGlnbhWasdvnu2RJ6Ar9JQ7EWP3COnMp96aL
X-Received: by 2002:a05:6000:4210:b0:48c:571a:a1aa with SMTP id
 ffacd0b85a97d-48c6d16d96fmr1412559f8f.19.1791275741864; 
 Tue, 06 Oct 2026 01:35:41 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cdb281csm1566764f8f.55.2026.10.06.01.35.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 01:35:41 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 18/31] Kconfig: Extract config IMX_AVIC from config IMX
Date: Tue,  6 Oct 2026 10:34:30 +0200
Message-ID: <20261006083445.30362-19-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006083445.30362-1-shentey@gmail.com>
References: <20261006083445.30362-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Over time, QEMU has grown a number of i.MX boards and the monolithic
config IMX drags in unneeded dependencies into each SoC model. Extract
config IMX_AVIC to eventually eliminate config IMX.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig      | 2 ++
 hw/intc/Kconfig     | 3 +++
 hw/intc/meson.build | 3 ++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 4445f16f45..030b218eb6 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -480,6 +480,7 @@ config FSL_IMX25
     depends on TCG && ARM
     imply I2C_DEVICES
     select IMX
+    select IMX_AVIC
     select IMX_FEC
     select IMX_I2C
     select USB_CHIPIDEA
@@ -493,6 +494,7 @@ config FSL_IMX31
     imply I2C_DEVICES
     select SERIAL_MM
     select IMX
+    select IMX_AVIC
     select IMX_I2C
     select WDT_IMX2
     select LAN9118
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 05e697967d..97355f9df7 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -5,6 +5,9 @@ config I8259
     bool
     select ISA_BUS
 
+config IMX_AVIC
+    bool
+
 config PL190
     bool
 
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 0620b0792a..74d84b8ddc 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -23,7 +23,8 @@ system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_gic.c', 'exynos
 system_ss.add(when: 'CONFIG_GOLDFISH_PIC', if_true: files('goldfish_pic.c'))
 system_ss.add(when: 'CONFIG_HEATHROW_PIC', if_true: files('heathrow_pic.c'))
 system_ss.add(when: 'CONFIG_I8259', if_true: files('i8259_common.c', 'i8259.c'))
-system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_avic.c', 'imx_gpcv2.c'))
+system_ss.add(when: 'CONFIG_IMX_AVIC', if_true: files('imx_avic.c'))
+system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_gpcv2.c'))
 system_ss.add(when: 'CONFIG_IOAPIC', if_true: files('ioapic_common.c'), if_false: files('ioapic-stub.c'))
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_intc.c'))
 system_ss.add(when: 'CONFIG_OPENPIC', if_true: files('openpic.c'))
-- 
2.56.0


