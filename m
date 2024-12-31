Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336F2E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 20:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSin4-0007I3-0P; Tue, 31 Dec 2024 15:24:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSimn-0006l5-HS
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:24:19 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSiml-0000xb-Dq
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:24:16 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3862ca8e0bbso7979993f8f.0
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 12:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735676652; x=1736281452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vts4Pv6wqeOpsJqeP0LsusmybTITtJOTCbWV0U0dSWI=;
 b=pW/fiKM8L3ePnn7/lZNCBK57FslT/G/auwNlTEZaUrSh5OdH67zP70S3Ts1b0MsR9s
 bc+tW/OBvxCbo17K1cRi/jJrDTB6WxRG+Rva5T9Ltp0L1/FQnaUft0RVYG82iUbctK8b
 epDarUCdML0x31tAAP+wWz0hkRrdG7lesO2avy3psq0DMskVTzCGDB7DX7+v9VcOF1J1
 8MSzMkRpqU3rj+a2gKCKg9lsbcrcPbdjFU7xe64ElEfLssCML4Rwzm52WdZvIMmdux6Q
 GL+BsTGKD2WH5Xctkdvqny2iNF2EGS9i5Z3CP0Q6sdA1ESON2ChbS5o5tFNIjvGYSqvG
 dviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735676652; x=1736281452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vts4Pv6wqeOpsJqeP0LsusmybTITtJOTCbWV0U0dSWI=;
 b=fPb8CUNH0LvmJ1PPCQ67/4GlR7n+Fp9X5kLHoWrV0h49MCqg9nELDYqGp85iqBoB6q
 0JQFkxN+NXmx9K1XiV+I2GQp7jGGGZJm8ZKYpiF17n7UagV+4V1wU+pf+genuxhHqV6B
 byDYTzJ9P9xgbgF5Vaej3+F/iOsJ5UKtQHQ282bOFk4hlDme3MQ8uhdrbFQT1fOPeK+E
 asroLicQEJ3pEh1qaQTNgQD03EKtn+G5b45b9ArsoNEM7i0wNWKIMpJjI2UBxjlJTURY
 Y79CEQ6Qz09ulNNCKZaCVgPgmEYRgGyaGGYI23BOodNudrk/gbLLkwBb5z6LLfyN4Ayr
 PCrQ==
X-Gm-Message-State: AOJu0YwgNHSvfFGV8SmVfJ7YwVBxOXlAYpgMhMg14kNzCOwZBb7Yi3Rv
 GfQZFcIKrx4jclB9Xe5VTKx0G/Rfi8QilAvQD3wBr/rqncJVT4R/nC1bbz6h0SPoLy6MUIZ79Hv
 6yec=
X-Gm-Gg: ASbGncsRTGpqUGQhUs+7s1ajldTHWM8JxRuy21dZx+VbdTVeF0dw1N7eEfsE7zgrFJv
 Rjsa4obgL5MPgosGb7hJJVmfzn65vPVL4WWuEveMcVxjiCaSbzDZR3QT6YeLiWcVw6PCLarm0wC
 PZLzI5xQtSeIF0cHNaXa+kNCqNpxM3uIGB1Lve9OcI31a2+/wvX1GNo0fYRHE2SxPBx0ZKvk2Ac
 bGQ+8bmO7yPv6CnY3VDVG3tG3jzRhdyQsxjZan6eOrGpA2ABMbHaGKuRtfOLFvfgEFafh3Qo4VW
 dyPIrHKKuDRVTjejld89+Dc/zZQ9PMw=
X-Google-Smtp-Source: AGHT+IH+GKp4yWCkYousfJTPduSOs2vIz3aRXqxWprhQSQIkp5HkeGXSox6y+YwNd04J2XWRtKVi1g==
X-Received: by 2002:a5d:5e09:0:b0:385:e4a7:df09 with SMTP id
 ffacd0b85a97d-38a223f75fbmr44072192f8f.44.1735676652519; 
 Tue, 31 Dec 2024 12:24:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8a636asm34468588f8f.88.2024.12.31.12.24.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Dec 2024 12:24:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/29] hw/usb/hcd-xhci-pci: Move msi/msix properties from NEC
 to superclass
Date: Tue, 31 Dec 2024 21:22:20 +0100
Message-ID: <20241231202228.28819-22-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231202228.28819-1-philmd@linaro.org>
References: <20241231202228.28819-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

The NEC XHCI controller exposes the underlying PCI device's msi and
msix properties, but the superclass and thus the qemu-xhci device do
not. There does not seem to be any obvious reason for this limitation.
This change moves these properties to the superclass so they are
exposed by both PCI XHCI device variants.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241227121336.25838-3-phil@philjordan.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/hcd-xhci-nec.c | 2 --
 hw/usb/hcd-xhci-pci.c | 6 ++++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
index b1df95b52a5..1df518baf59 100644
--- a/hw/usb/hcd-xhci-nec.c
+++ b/hw/usb/hcd-xhci-nec.c
@@ -37,8 +37,6 @@ struct XHCINecState {
 };
 
 static const Property nec_xhci_properties[] = {
-    DEFINE_PROP_ON_OFF_AUTO("msi", XHCIPciState, msi, ON_OFF_AUTO_AUTO),
-    DEFINE_PROP_ON_OFF_AUTO("msix", XHCIPciState, msix, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_UINT32("intrs", XHCINecState, intrs, XHCI_MAXINTRS),
     DEFINE_PROP_UINT32("slots", XHCINecState, slots, XHCI_MAXSLOTS),
 };
diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index e110840c7a0..a069b423388 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -197,6 +197,11 @@ static void xhci_instance_init(Object *obj)
     qdev_alias_all_properties(DEVICE(&s->xhci), obj);
 }
 
+static const Property xhci_pci_properties[] = {
+    DEFINE_PROP_ON_OFF_AUTO("msi", XHCIPciState, msi, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO("msix", XHCIPciState, msix, ON_OFF_AUTO_AUTO),
+};
+
 static void xhci_class_init(ObjectClass *klass, void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -208,6 +213,7 @@ static void xhci_class_init(ObjectClass *klass, void *data)
     k->realize      = usb_xhci_pci_realize;
     k->exit         = usb_xhci_pci_exit;
     k->class_id     = PCI_CLASS_SERIAL_USB;
+    device_class_set_props(dc, xhci_pci_properties);
 }
 
 static const TypeInfo xhci_pci_info = {
-- 
2.47.1


