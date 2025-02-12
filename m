Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1568DC021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 15:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiF4F-0004lu-MY; Wed, 12 Feb 2025 10:54:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiF47-0004d9-P5
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:54:20 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiF46-0000r4-0y
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:54:19 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so26559575e9.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 07:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739375655; x=1739980455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9jgwvuUHnyL21kGDz/lsBVep518SWeLt+3+GCxJqisU=;
 b=DkjHD/upr6mBwgtIfb8+lP2ZqZHgIpVE7/vnkgF4ofnSqIRHsUZN3v8gIh7mcpn8bX
 4tYZWAHxXPbnfkADO2ioZxE4kC+9saoXXSuscLn/GSYk/ViO4YugNlWxIwS6Q5gSi6lw
 rGJvwHqeI2V5bupx7jXF9AewRFdIOPpSqTLqG/dFK1Zce1kSfNr7+CV/6pcaqIM6r58C
 TbBFeyPGauEPvn/aeM0txxHQZwmTLj0x/Yk7cRssHjXorlkvQOLzk3sbsJiBhpsEfR66
 RsAp8aSlZZ4GZshJ25hI0ZzijQBtg2y1Btlz2lguq3/lUY092DvOpkibEJ1KvcE8OxBh
 AJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739375655; x=1739980455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9jgwvuUHnyL21kGDz/lsBVep518SWeLt+3+GCxJqisU=;
 b=uVBXhS3tsbFhQIZU7GD955TvVDtt9WMf0IcLgLVHWfZjJLzrw8QrYwoXnmRtNPfhor
 NtZ14yy48WJ23iEXsYiPP1EX/YFzbJMLn1hRUgBGgtMRkR6o7s2xO1JTmasYfPDwY4dU
 X/YGE+Gr29kOfSf1o6QQ2rR/U4x7vt+H/Z74GgsMhSxEeRGroq9z8XrPidpSroASEIfO
 zjjzGMYUR/SmpJ8Gv8NrZFPks2O2pkimedd21aOLE+ygG68GI4r+2hmpaqngTsI7B8fO
 /KMnJ0/FLSSAqn0yD0x4a5dc8E1IkWfHOTQG8KZv2721Ez+/LijGdHdVPNeGH2QQ3vdv
 oLqA==
X-Gm-Message-State: AOJu0YxSCY1LCIqxRWNrCABGYWu70SVoyleEgcMHGawCy9mYam6f7KUP
 PPh4+ZsGHtI+P5vCsVTx7IsdxzzL11sYddIsxsk7ThH7Bf/xOGvKNGxEjgV1dbG0OI96En3V+J0
 oTpI=
X-Gm-Gg: ASbGncunlr4M/B9jOX5vh2DBZehxKwIooYHaj7fNcze1/2hEZCZ9bKNBQVURt8INqo1
 QP7JVQamqOhhdECeOgUkMwJdUFTyS3XdIQx9MrzHdSShbfyTJ5eING2QyWKdIH7hTMXmW2KssRp
 DdYQTqrBo5L6ncSnDOvyI0FK3bi/5D5gMSwDkPT3DdMz7cbln8qcxe9r5CqMdpDHr/AJTqKpcaB
 lpMlhEyvkvLOFokWT4cjlv3lu48tFzDJ3nT0c1MGAzETgfzTaP3OIsM+xUMsH7UEF0EKqPFwhQa
 zFEay23T5Dogg7CaLbPAh7kPcS7ouQ8i0dgQnCT9xy/N0hP4LKsArPC6iXBFU+I4ROSAYxU=
X-Google-Smtp-Source: AGHT+IGec4EqfxKCJuFloNeLbGhzs1N7BS45fJG6yFWRpSRKa5TURUzf4gInZfvwJxzV/xelNtpvjg==
X-Received: by 2002:a05:600c:1548:b0:436:1b08:4c78 with SMTP id
 5b1f17b1804b1-43959a997a5mr30960965e9.31.1739375655371; 
 Wed, 12 Feb 2025 07:54:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a055bffsm23336625e9.12.2025.02.12.07.54.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 07:54:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 28/29] hw: Declare various const data as 'const'
Date: Wed, 12 Feb 2025 16:54:07 +0100
Message-ID: <20250212155408.29502-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212155408.29502-1-philmd@linaro.org>
References: <20250212155408.29502-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250210133134.90879-7-philmd@linaro.org>
---
 hw/isa/vt82c686.c     | 2 +-
 hw/rtc/m48t59-isa.c   | 2 +-
 hw/rtc/m48t59.c       | 2 +-
 hw/sensor/tmp421.c    | 2 +-
 hw/usb/hcd-ehci-pci.c | 2 +-
 hw/usb/hcd-uhci.c     | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 6f44b381a5f..43bd67eeef2 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -224,7 +224,7 @@ static void via_pm_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
-    ViaPMInitInfo *info = data;
+    const ViaPMInitInfo *info = data;
 
     k->realize = via_pm_realize;
     k->config_write = pm_write_config;
diff --git a/hw/rtc/m48t59-isa.c b/hw/rtc/m48t59-isa.c
index 38bc8dcf100..9c3855a3ef1 100644
--- a/hw/rtc/m48t59-isa.c
+++ b/hw/rtc/m48t59-isa.c
@@ -129,7 +129,7 @@ static void m48txx_isa_class_init(ObjectClass *klass, void *data)
 static void m48txx_isa_concrete_class_init(ObjectClass *klass, void *data)
 {
     M48txxISADeviceClass *u = M48TXX_ISA_CLASS(klass);
-    M48txxInfo *info = data;
+    const M48txxInfo *info = data;
 
     u->info = *info;
 }
diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
index c9bd6f878fe..3fb2f27d9d1 100644
--- a/hw/rtc/m48t59.c
+++ b/hw/rtc/m48t59.c
@@ -639,7 +639,7 @@ static void m48txx_sysbus_class_init(ObjectClass *klass, void *data)
 static void m48txx_sysbus_concrete_class_init(ObjectClass *klass, void *data)
 {
     M48txxSysBusDeviceClass *u = M48TXX_SYS_BUS_CLASS(klass);
-    M48txxInfo *info = data;
+    const M48txxInfo *info = data;
 
     u->info = *info;
 }
diff --git a/hw/sensor/tmp421.c b/hw/sensor/tmp421.c
index 82e604279c5..007f7cd018b 100644
--- a/hw/sensor/tmp421.c
+++ b/hw/sensor/tmp421.c
@@ -68,7 +68,7 @@ struct TMP421State {
 
 struct TMP421Class {
     I2CSlaveClass parent_class;
-    DeviceInfo *dev;
+    const DeviceInfo *dev;
 };
 
 #define TYPE_TMP421 "tmp421-generic"
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
index d410c38a8a2..e00316721ac 100644
--- a/hw/usb/hcd-ehci-pci.c
+++ b/hw/usb/hcd-ehci-pci.c
@@ -182,7 +182,7 @@ static void ehci_data_class_init(ObjectClass *klass, void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
-    EHCIPCIInfo *i = data;
+    const EHCIPCIInfo *i = data;
 
     k->vendor_id = i->vendor_id;
     k->device_id = i->device_id;
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 8528d493d63..0561a6d801a 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -1289,7 +1289,7 @@ void uhci_data_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
     UHCIPCIDeviceClass *u = UHCI_CLASS(klass);
-    UHCIInfo *info = data;
+    const UHCIInfo *info = data;
 
     k->realize = info->realize ? info->realize : usb_uhci_common_realize;
     k->exit = info->unplug ? usb_uhci_exit : NULL;
-- 
2.47.1


