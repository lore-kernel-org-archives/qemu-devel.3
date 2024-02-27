Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4ACC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ret28-0008QX-8Y; Tue, 27 Feb 2024 03:41:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret1k-0007dT-PP
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:41:32 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret1c-000809-30
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:41:28 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-512a65cd2c7so5549014e87.0
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 00:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709023278; x=1709628078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PlYoLDbUbjomSEd23m1u/ajnPye5YRTUfebEkIuJSY0=;
 b=bXMBlr8Pfz8cayLou3WQFdkwZJ17kFeaYYSjO0S8lDZjMCsRfacf0BFVl8hlj9dfGw
 ABIbgR1KLM2y0TcQ78rE/yE3DlpH/7Ml79Exh3EygiLWypMbxx6ffz98OfFEbztWiRfl
 lzECAWN7YS/+WFUeBYKamNmTNSvEoagSZgYi04eSE084SwliIerRuOO11kZWXvbU2huN
 qPaCbsIMq3GLXXwOXng1VbeBcU6JqMxhgESfXgV8BgMiqqPtP4HBczx05VYSNWGYdo/+
 WwIgn6A91b0LsQSRgWrI4QSfgfIFp871Rf2cKOe5la5Z6MG2f72DRiciI9P42ApM75q7
 JzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709023278; x=1709628078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PlYoLDbUbjomSEd23m1u/ajnPye5YRTUfebEkIuJSY0=;
 b=A1nIE4Qjb84Wk9rcCo7TeGih1n8Ou5PnhMpM2ATgiSTV/gCQIAL09k5ymFyGT3y2GH
 T5fPpR2EjO2yfSVVgqEnyfvp7eLdu5QpKrEdZJG+1iVi9vxx71BftavhVDxTQDN6GpKw
 mJAXQLP7alteB15bLtWTuhJJb7h/A4E2Hn8YD6jJ09HTgWje73XjoGfmY85tGqgoeE5T
 OXZ+FXtc+igljZLbC9bsjzRFLLbYbLwoGA5rSZJUykJqIxwBY1zG3UxJ40yXOiYzrabT
 Lwm2u3bba0/NKDJSe8eeQQWxB9sOEUET+qvTAYXVfYnaYm1TLFKtJqqzjUhals70b0KT
 NDZg==
X-Gm-Message-State: AOJu0Yx1uClYa1YAWu6umBL123UMzgnipiSwA2dGsPUztRGBDg18s+ht
 mr5mBzDRuXxbxY9VhZiENroufSsC2YJxetrZk0goB1bgiLXVdDhpHjvk/Q6EVFlZTIr8FGsqfXR
 C
X-Google-Smtp-Source: AGHT+IGLLOYV3D+5HRrVOa/za+fkZoPSCpx6sl0EAkvOP6CREgkO1DSGwEFeHXF2vqjzYbeDmin7oA==
X-Received: by 2002:ac2:58d9:0:b0:512:febe:ab20 with SMTP id
 u25-20020ac258d9000000b00512febeab20mr2406231lfo.17.1709023277754; 
 Tue, 27 Feb 2024 00:41:17 -0800 (PST)
Received: from m1x-phil.lan (mic92-h03-176-184-33-214.dsl.sta.abo.bbox.fr.
 [176.184.33.214]) by smtp.gmail.com with ESMTPSA id
 j5-20020a19f505000000b00512daaef13bsm1109312lfb.102.2024.02.27.00.41.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Feb 2024 00:41:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 14/30] hw/hppa: do not require CONFIG_USB
Date: Tue, 27 Feb 2024 09:39:30 +0100
Message-ID: <20240227083948.5427-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240227083948.5427-1-philmd@linaro.org>
References: <20240227083948.5427-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

With --without-default-devices it is possible to build a binary that
does not include any USB host controller and therefore that does not
include the code guarded by CONFIG_USB.  While the simpler creation
functions such as usb_create_simple can be inlined, this is not true
of usb_bus_find().  Remove it, replacing it with a search of the single
USB bus on the machine.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240223124406.234509-6-pbonzini@redhat.com>
[PMD: Fixed style]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/hppa/machine.c | 10 +++++++---
 hw/hppa/Kconfig   |  2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 5fcaf5884b..37ee6387e0 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -396,10 +396,14 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
     }
 
     /* create USB OHCI controller for USB keyboard & mouse on Astro machines */
-    if (!lasi_dev && machine->enable_graphics) {
+    if (!lasi_dev && machine->enable_graphics && defaults_enabled()) {
+        USBBus *usb_bus;
+
         pci_create_simple(pci_bus, -1, "pci-ohci");
-        usb_create_simple(usb_bus_find(-1), "usb-kbd");
-        usb_create_simple(usb_bus_find(-1), "usb-mouse");
+        usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS,
+                                                          &error_abort));
+        usb_create_simple(usb_bus, "usb-kbd");
+        usb_create_simple(usb_bus, "usb-mouse");
     }
 
     /* register power switch emulation */
diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
index dff5df7f72..ee7ffd2bfb 100644
--- a/hw/hppa/Kconfig
+++ b/hw/hppa/Kconfig
@@ -2,6 +2,7 @@ config HPPA_B160L
     bool
     imply PCI_DEVICES
     imply E1000_PCI
+    imply USB_OHCI_PCI
     imply VIRTIO_VGA
     select ASTRO
     select DINO
@@ -17,4 +18,3 @@ config HPPA_B160L
     select LASIPS2
     select PARALLEL
     select ARTIST
-    select USB_OHCI_PCI
-- 
2.41.0


