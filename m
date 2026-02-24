Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE44AF4BB70
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 18:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vux1x-0002cs-NA; Tue, 24 Feb 2026 13:21:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vux1T-0002My-EZ
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 13:20:40 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vux1Q-0004Ar-CE
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 13:20:37 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4837f27cf2dso49803275e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 10:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771957233; x=1772562033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xap8QAqy2ECA+DNuqgis6fgdo0V7uWuXErMfaxZbeRA=;
 b=LoOJWWOqbLP2duSOuixoB5r8NSDoox69pNZ4nysvNwgMEtOcpvSHXon2S3bnI81nBT
 1UFQk48csd6dLOSWB00zuUk4TKsX9DotKRIXix3SO7R1U51WbuQuewxiXD7VIlnhnPpW
 E9PR3kmISMJBjgoLl5TEWbf68SQZV3cxO6BCod9q0H2XzJ/CfEPrtrgxqmC0cAPp8TYU
 2p1ORqLDfqzv7QOTFt46Q7RQIkoqCZejj7/0xpoJOY+Fb1vM9WtkqEIKhOTTETvCAMAS
 vRfEkcjfbj8qfv0K4rBKcp0e5I6JRC7ygiwrf+ynkJ1EiYD8ERTcJyWCtMrwCbx0u1q7
 9w3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771957233; x=1772562033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xap8QAqy2ECA+DNuqgis6fgdo0V7uWuXErMfaxZbeRA=;
 b=CuL6jGSdKlNgeSxwSJqq19yrjL77N3B12KKF1OlyPuzFkz99PoRIz8KZif8WzKYXYQ
 BPj9DDcYbdahkcqYjV84pFMYiWnu1Q54nf4vaR0Sv2lKOQSeCYXb+zwT/pVumUx8g9b5
 xNZ9bKISDh9rLmDl7r0XUD8tsyuy5TwWT1bWu+J9S3oHPiBBlwm0uO3p7V6ybv/l6+3P
 EzQ3TUrdIXrRvVmV1YuBv7MaHMyI405euJerNBrbm0NFaY5rYEoT+qZ5NSIuSSboq3tM
 PkzynHVOXcD+misUheMZ21eGBt2rRBbY/Ifgn9rRBy4zTG8YNE+Omd6e1BYUcy2UMeUO
 wLjg==
X-Gm-Message-State: AOJu0Yw4a2Ce8wZcmrCoCMQ2i3fIV3ZEbN0Q0egCVIlh9PJjc7GP7mf3
 GM+8Y/x2o4lwbEe5WsRy5jQJuPw/N5iH0qPI4E3a2jODk8hIlaV/MVl6CyVh4ApQXKpgu5ViEIW
 pYp5DrIA=
X-Gm-Gg: AZuq6aK6D/HkqDD8QkQC870d86fSoc5Nk5TkS18y13oLjq/A2XSfX/iB/rXtYi/nqEq
 u3rOG1KIkAYzoDL1lYhDUYpftTl8gdsOwQQ8PmfDl2P7IRwvOcmWaoECx7IkIKL7vnj0YXKLiXd
 2G8DTmnJp2DPP2YpYozDPUhNsRztlBU1QceRy6fHDjs0tLkcnlUarJA9xUoCgKIPLayXWEZSEuL
 bgzhtsI28nYiGrUZvaa76S4HD5srmwNgqMqjwMnS26qGqAkvrccdUMw2XVzaItk3fHEst5yaova
 D3Dl7dBOh+y+tdiQzMV42GCI5bKm4d0I0qHriMk8gSFYuQGLupfVbEKxCGRSLCR/C+hAfnIKxiC
 2WDU69u+qqGSkkA77Zfja+P64JbvrCkx2ak/OebgB6tLYyx2rb/sMM5jKiPsghl4OUmnJju8ooz
 q2hIVUdvKoVJL+mvWbnjNdRcbkfOEQDAYYQwgWrus2N9Cq//5O/FETPdUGKz8bMPklXcohC9cR
X-Received: by 2002:a05:600c:154b:b0:483:7ae2:1737 with SMTP id
 5b1f17b1804b1-483a962e486mr193588745e9.17.1771957232826; 
 Tue, 24 Feb 2026 10:20:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6854c7sm45135475e9.0.2026.02.24.10.20.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 10:20:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH 02/10] hw/acpi: Move acpi_send_event() function out of
 acpi_interface.c
Date: Tue, 24 Feb 2026 19:20:08 +0100
Message-ID: <20260224182017.99865-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260224182017.99865-1-philmd@linaro.org>
References: <20260224182017.99865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
event handlers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/acpi/acpi_interface.c |  9 ---------
 hw/acpi/core.c           | 10 ++++++++++
 2 files changed, 10 insertions(+), 9 deletions(-)

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


