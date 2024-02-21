Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C83C5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctzG-0000H9-AZ; Wed, 21 Feb 2024 16:18:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctzB-0008O1-9e
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:18:37 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctz8-0001BB-Cy
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:18:37 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2d1094b549cso102518811fa.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708550312; x=1709155112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a97LH+/zHlwhK38ayT8uR+FI5InpUgImRxlOHohl8Qc=;
 b=Pg5yT5Cye0H1JIo91afFQqfD3as4YMI0YbA+r3u1A178bjxhJewLqvI+4uoZrwyyKa
 sWs1qGpiu1YGPj/yr/+XmSk+togHsVAxYoW2/8r4clI4Ch/TBn9a3c2942hav7aGm5dK
 3bfPfwBTBcyQDt5iB5T7Cf/eymJ5J2dqdlZ6GzUKjyzJPN5igA95Ns8EDRim4MzB3d3b
 2d0vQuVaWVYBmSbkdHs14n15Gmc0xN27aTZwvrtcJBgQq36gFNjf7AiYN5dG0BkDD9SI
 4kXerLNUBzh3McRSmcdviGPLFWu18BS/CsKNqT5vEDWpOqUm0Nvuca6+hM5eknpaNxmf
 ogFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708550312; x=1709155112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a97LH+/zHlwhK38ayT8uR+FI5InpUgImRxlOHohl8Qc=;
 b=puyeyiV0RgcijRTgUIi8V4Xarnro7d03tMgJCpF5TM6VbCbMm3XeeHwLmw/LSarvab
 4CHjmNisonj3sbQoKd1qb18omyrfhbcluWJolv83bih8wWj/IFIbajSfQB7FO466+Ibd
 ExrWhYefT8nqoyf0EHS/BKlQFAAzU5e6sSS1tGmdN/+Zmo2AnKsHm2CxKhEMgZ+WQ3m6
 ibqiKBToZTYvb1M6XVFhFmsl6WNYWSKdFbT+4GMoP3xoGFL2+SPvzPiVSs+h5u1p0Yup
 BZwP5kA160tYKwhlDJXmmln0QuHRsXmCRTKhXZ8eWugcm16Vka1kwMasvcTvlopEACxH
 ubEw==
X-Gm-Message-State: AOJu0YyZrpuihh1gcOZCQtRipwYATGm+c/eY61D8cUqTfPH4h/kQTsM6
 0cTTtBW7RiDXyxli+uQolFz0z9H6lHYjOvkB9n5NZunsj/WqPVuNlBehPC0HnUQFpNas3rFZ7Sc
 aM14=
X-Google-Smtp-Source: AGHT+IGHn3vTg+rbs/DTPQTKMSKzwkTYC2c5DO/nOMOxoryuS6JLqhTrLuPbVEFtGwjL2Cbx9nMOCA==
X-Received: by 2002:a05:651c:206:b0:2d2:4def:a7bd with SMTP id
 y6-20020a05651c020600b002d24defa7bdmr3459148ljn.24.1708550312324; 
 Wed, 21 Feb 2024 13:18:32 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 bw2-20020a0560001f8200b003392206c808sm12383532wrb.105.2024.02.21.13.18.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Feb 2024 13:18:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 16/25] hw/i386/pc_q35: Populate interrupt handlers before
 realizing LPC PCI function
Date: Wed, 21 Feb 2024 22:16:16 +0100
Message-ID: <20240221211626.48190-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240221211626.48190-1-philmd@linaro.org>
References: <20240221211626.48190-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

The interrupt handlers need to be populated before the device is realized since
internal devices such as the RTC are wired during realize(). If the interrupt
handlers aren't populated, devices such as the RTC will be wired with a NULL
interrupt handler, i.e. MC146818RtcState::irq is NULL.

Fixes: fc11ca08bc29 "hw/i386/q35: Realize LPC PCI function before accessing it"

Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20240217104644.19755-1-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_q35.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index ab7750c346..53fb3db26d 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -228,10 +228,10 @@ static void pc_q35_init(MachineState *machine)
     lpc_dev = DEVICE(lpc);
     qdev_prop_set_bit(lpc_dev, "smm-enabled",
                       x86_machine_is_smm_enabled(x86ms));
-    pci_realize_and_unref(lpc, host_bus, &error_fatal);
     for (i = 0; i < IOAPIC_NUM_PINS; i++) {
         qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i, x86ms->gsi[i]);
     }
+    pci_realize_and_unref(lpc, host_bus, &error_fatal);
 
     rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
 
-- 
2.41.0


