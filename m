Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E412C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 10:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thQzx-0001bL-M0; Mon, 10 Feb 2025 05:26:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thQzv-0001Ri-6H
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:26:39 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thQzt-0001px-AD
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:26:38 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso27910895e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 02:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739183195; x=1739787995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tRDqbtanMlA5Asve4v+RadDNokWUtgjMp7wgM0p7V4g=;
 b=Y3YuWfrEPCspAh6vyGKQ/bRHIY9DBK52r7bkwQTzELRFIAv4Fs5wNQ+raNVnlOfJ/D
 dpu6fSiByY4Ipt6ttrLNkM6gON1UJr4N6cajSmcdcQCCGZHs4dJ6OcNHyW5YZbBL1tpD
 HHJw3FnKQ7m6D9St9ogfejg/A8ky8SAvdoDIzgE0Xe8FbyOmLU4z+IVurbT/kf9eD2Pn
 PQPC2xwgLGcH2MVqLS78VN2o4zD+zXe6O6pyNJERbTYF0KKdjQer+9HSlvoKU0z0mX7z
 JlHN44XRxkENPs59kCzvZR8S8K7ZJ+OUPW6v6SwL4yUJjw1zMkLg9bMp7007xnwDF0sF
 Eh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739183195; x=1739787995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tRDqbtanMlA5Asve4v+RadDNokWUtgjMp7wgM0p7V4g=;
 b=Sf6yEWbuwlqBl9eAmrWr0aptrhSGopTXeLgTIKa5CdmKAKhOQlB82/s6ONyngDkxdP
 7Sccv/mK1qnh6YHXuMpCXu/EgQ8il4qopAWmdtRWKe/tgT07NULqS6pJNJoiZ0b5z8yC
 Oqycj54OTmeDp6YX1rqEbw4vhewX1kVMwVvjJQNCI8pLa5a8aeej8nH781Pp1ranaCbv
 +4T4DBaucYtVb5GQlwQ3kRtr4w+3dSEGaMXrKFf7rW7n2VvFtpGHEJDG0k/LnLFbYQl4
 q3owNYreWTZlSsaYsvgHpUReryLDeSHK9/mw45cj1PoYFBYMJTTxeBYTchdPqXKrpFJ7
 DZtg==
X-Gm-Message-State: AOJu0YykOpAsO5qgyOpZZse8WzAg5Qhwa2GW1YzNBKk73ZCSWPQZFZB6
 QnLvdwAEYyZdtPmNoCW7bXQwdKEgXsvBr3Qie6/CM8Wp7ZgjT1fzXjk6XRjuIagt0XtGXCyhrWO
 X3yA=
X-Gm-Gg: ASbGncsV2RX8RK4/qbfmiTkLGT7E9oZ171ItI9YmFo8sTQsF8DWcaBaeIgT0pQsQAuV
 JdPgUZ+QSQdHglHMzXv/hnE/OU81gOXTA3YIXXlkb4XLRKbfMmyWqU+Bvvo3kvQH8nDlHUZ6rkb
 1E4c/NiOeuYAI8+7phCX7BKJPsvOiNK23Q9IkmwQlH3YGhjPdbudDcBXJlE+2r9ff+V52hUBzRO
 MKW9C7w08besgIZGpcTkwFU8jPOBD+XLR7FuCH3q1YrN5uamSwbMyvDXNno8MrgfTbZe1NARUwm
 RrDCBwJXT0iK1q4go2E11X653QxknM3ck9NjAA56cGHK+jiAmOgVeWlovFFQ2EGcRuAirY0=
X-Google-Smtp-Source: AGHT+IHrqGrYCnv6aFVdtB2T/pXjIhKu2h6/wogDJe5McArtoOWzQVdnFbXhUsJc3hjIxrSJiHvjMA==
X-Received: by 2002:a05:600c:4eca:b0:434:a852:ba6d with SMTP id
 5b1f17b1804b1-4392498a1e3mr93634665e9.9.1739183195282; 
 Mon, 10 Feb 2025 02:26:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d94d753sm175560445e9.11.2025.02.10.02.26.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 02:26:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/10] hw: Declare various const data as 'const'
Date: Mon, 10 Feb 2025 11:26:00 +0100
Message-ID: <20250210102604.34284-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210102604.34284-1-philmd@linaro.org>
References: <20250210102604.34284-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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


