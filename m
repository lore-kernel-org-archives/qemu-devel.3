Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 207DFF55449
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv62D-00042Q-IT; Tue, 24 Feb 2026 22:58:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv62C-00041s-0L
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:58:00 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv62A-0001iI-Fg
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:57:59 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-483abed83b6so27189245e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771991876; x=1772596676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QB4oBjPoWpoNs0xhlkhhNhPsrkrrYyVT3ExoU/xXiJU=;
 b=TuS5Tf1Cqt5Y4z6IwxtwzgoR117CHBnbGUbN0BuhkuhARUBq0pfy9seYRT7X7RDnKd
 b7GWEsXdVc3ZWrdQrIDAc8U2CWhPRa2zVzPobPiWKk+DasVSg9JJw+C+mWceGCLd/ALX
 +lJtk197eMiVup2ZiSr9tXRVeuN+gyIThfVaN2atTo0IzAlr+cINfOL4Oa46BADO4dKp
 M9qi+LJeC3bJARx+4+ikX10sUa9OdbYmDnud4VJe462Vuv9q3zVL0hTvlRF0dk+PndpQ
 pAUxXBoQwp01YGBkHTka94UK59mlLuu11DxEXCV+ozXH9jWFPoCiVW0RmIXk8z08htZe
 WSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991876; x=1772596676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QB4oBjPoWpoNs0xhlkhhNhPsrkrrYyVT3ExoU/xXiJU=;
 b=dfXMLCWGp/AhyqUaospis9vZpiWFcDBY3d6NO/ohNdkbZegOUuOFhbsX/utKaDXjsk
 AFr0/Y2z990e0YSAPzn4XtlWHIPtOd6a3OUABWmLQx6Oq7l30fXPBBRPXue6M9q2wBXJ
 M7Jdq5PzixxiPa16QW0G+uz0AbhnXb9Az+T+xkPThe4fRE3uOoolSxfmDhArkVMdAbny
 ioTSA/ePst6vbqZErSkAWrPn76NVUZxxPQChn+Y0TFBF2smKbrZv3Gayijg16M+lXcrg
 XfChYSrMFWXyFGBz4OAhXFcLrccsJ8yKV4d2sRQZd4YQIQA+AeTa/m/kyuwAV6hoJl9s
 W2rw==
X-Gm-Message-State: AOJu0Yz/sq8oYNBe4cUmgFQcve2AmhsWeOsaoCBMJeISytnpVspm4Veh
 fWrwamMxL6kf5HbB7zreMN3be8nHZqfX5L7hU9OllM8Ej4iXMlCZUuttoDZUaHhsEJl43dCYlw2
 wVBB2kCw=
X-Gm-Gg: ATEYQzzcF6+0+1iXNrlJ3TtwD2a9Ba2sWP1qDHnKCCuZ6OBtjWS1eXLPVws6wSHOz6Q
 TW7ucjjKiJpNeRi/EFkevfjlw2Mg4vab7JU/56vj+dwv6jlAiGEv8HQmj3nfomfqMhANrEMWWJs
 bDPVLQdoPgwX1P1qJdfOd3+Kq7eCU8scF996SqjsMNLbufTxM5P1GXF75zJVhkDzNqlDHbScBB5
 CeF0EwOzn6FS31Jxm6anJ5ElSR7LiekW8D/Qhx3/44sOIqVxr9lPFXpuq8JVMsM64Xoba+257Fu
 XXdNE2OCXvScU8Z8spXHN96vppQ5grb3CKtXgQopBtzy2kBV3ww1QgAIPOkRi5ZXzcsL8ZPNfAV
 jEvOtT8kUE/tzJTOqCvqn965c7NZilxNX87oyTeDqKx7XZMbNpI42aOjuSAbpbXPL7ZiDwopEqt
 RV1ml9fNV2VH93S5dAyqz4UtOZoUbxxv9niA3DU6DZfM5IQouv/c59zWQQSdYmsZr2sK2u3L09
X-Received: by 2002:a05:600c:638d:b0:480:1e40:3d2 with SMTP id
 5b1f17b1804b1-483a95f5a62mr217318015e9.29.1771991876254; 
 Tue, 24 Feb 2026 19:57:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd765604sm35828575e9.15.2026.02.24.19.57.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 19:57:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v2 02/11] hw/acpi: Move acpi_send_event() function out of
 acpi_interface.c
Date: Wed, 25 Feb 2026 04:57:30 +0100
Message-ID: <20260225035739.42848-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225035739.42848-1-philmd@linaro.org>
References: <20260225035739.42848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

acpi_interface.c should only register QOM interfaces. Move
the acpi_send_event() function to core.c with the other
event handlers, and its declaration in 'hw/acpi/acpi.h'.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/acpi/acpi.h               |  1 +
 include/hw/acpi/acpi_dev_interface.h |  2 --
 hw/acpi/acpi_interface.c             |  9 ---------
 hw/acpi/core.c                       | 10 ++++++++++
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
index b036116dfb8..dc3672db521 100644
--- a/include/hw/acpi/acpi.h
+++ b/include/hw/acpi/acpi.h
@@ -182,6 +182,7 @@ void acpi_gpe_reset(ACPIREGS *ar);
 void acpi_gpe_ioport_writeb(ACPIREGS *ar, uint32_t addr, uint32_t val);
 uint32_t acpi_gpe_ioport_readb(ACPIREGS *ar, uint32_t addr);
 
+void acpi_send_event(DeviceState *dev, AcpiEventStatusBits event);
 void acpi_send_gpe_event(ACPIREGS *ar, qemu_irq irq,
                          AcpiEventStatusBits status);
 
diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
index 5927e40eaff..65debb90a8d 100644
--- a/include/hw/acpi/acpi_dev_interface.h
+++ b/include/hw/acpi/acpi_dev_interface.h
@@ -27,8 +27,6 @@ DECLARE_CLASS_CHECKERS(AcpiDeviceIfClass, ACPI_DEVICE_IF,
 
 typedef struct AcpiDeviceIf AcpiDeviceIf;
 
-void acpi_send_event(DeviceState *dev, AcpiEventStatusBits event);
-
 /**
  * AcpiDeviceIfClass:
  *
diff --git a/hw/acpi/acpi_interface.c b/hw/acpi/acpi_interface.c
index 8637ff18fca..e58e8aaee23 100644
--- a/hw/acpi/acpi_interface.c
+++ b/hw/acpi/acpi_interface.c
@@ -4,15 +4,6 @@
 #include "qemu/module.h"
 #include "qemu/queue.h"
 
-void acpi_send_event(DeviceState *dev, AcpiEventStatusBits event)
-{
-    AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(dev);
-    if (adevc->send_event) {
-        AcpiDeviceIf *adev = ACPI_DEVICE_IF(dev);
-        adevc->send_event(adev, event);
-    }
-}
-
 void qbus_build_aml(BusState *bus, Aml *scope)
 {
     BusChild *kid;
diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index 6b65e587f2a..a6a62a742d1 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -22,6 +22,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
 #include "hw/acpi/acpi.h"
+#include "hw/acpi/acpi_dev_interface.h"
 #include "hw/nvram/fw_cfg.h"
 #include "qemu/config-file.h"
 #include "qapi/error.h"
@@ -753,3 +754,12 @@ void acpi_update_sci(ACPIREGS *regs, qemu_irq irq)
                        (regs->pm1.evt.en & ACPI_BITMASK_TIMER_ENABLE) &&
                        !(pm1a_sts & ACPI_BITMASK_TIMER_STATUS));
 }
+
+void acpi_send_event(DeviceState *dev, AcpiEventStatusBits event)
+{
+    AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(dev);
+    if (adevc->send_event) {
+        AcpiDeviceIf *adev = ACPI_DEVICE_IF(dev);
+        adevc->send_event(adev, event);
+    }
+}
-- 
2.52.0


