Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1808AEA8543
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMiY-0008FX-Bd; Sun, 08 Mar 2026 18:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMiW-0008AC-M4
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:35:20 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMiU-0003Gv-Uo
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:35:20 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48538c5956bso5611495e9.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009317; x=1773614117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+1VocN7MgnHEJhNLZV4eiwgA4lPII4YDTKWegM5dUPs=;
 b=vyMWw83E7bfZduK+dyKrxQMRwCNF+ciUWVpCYa3b/hohyqjk6PcqG4xqJslnP4UcxZ
 3pODrzYfffVuGlTYvI3Pk7J+NUK2CeXNA+kK3/KWiZBUPjaDleeT6ggiV5lSMilJxMwE
 R/nLP4No/bmzCbIySuvPUVIhNgqD8lEcGRvI0DN1vEPSYeiBrMeB61mBaoyQLg2hBc+y
 GWFVao2+62RJRmimriA+LEuLGxP5rsRRvz0xG9XaysdxSvxZ7u6P8tyNiZHcc3ZHEGos
 LLDvWxLaBPnPNZH0yU6y0CNU8XLREaYebynUilMAb459Wem+V16O9nGui1CkTcn3wFXs
 81kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009317; x=1773614117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+1VocN7MgnHEJhNLZV4eiwgA4lPII4YDTKWegM5dUPs=;
 b=QLvO6LGCDOVQvhxAoDUJkI+TBYGNgG+07Yhrtag1XfYEtDhUNTLk4uSaeWsZgsz5Nz
 qsTZEZNatfCVHi3NrQXmS2OoPpyD9+uPxrgY6bgas+KIPFvC+OUrjIq/TfvVjPkBPhqz
 wx/vvtFRqwBTp1HXJmtddaWgOWoMga7b0ncWcGmi6HVc/nhSDpJ/b3Rsw6TtP3RueiMt
 koVGz1J8xqm0pPX6rEZUMjKMsFmpVOXxpSzDOCcBTYYzm6plmNWB4C9FcbBfBA/sC6IB
 vUnog5nvf1x6WqW8OdIBq+dqKXnWg4Y8mB4UOHwSmRAwy7KuzoGC+no0Wqvhu6PO36Xs
 DIzQ==
X-Gm-Message-State: AOJu0Yx7Xgtp3Mn5NvWD6HT+iJ7ys2Ots8+Cjay6qbg8rNhGqcwkxbvV
 NY79bZV9z1Ge5mI09LZtJfAGxXT7cVMJfl7gAhgGv1dtUnO/OS4YZZ3Sk1TrwV0q2rozOE2P+tN
 4xfoCjKQ=
X-Gm-Gg: ATEYQzwouEhVQy7+FMAHwbOH768631kzNA8+IIwfbjJqUEeVhaetAvzDuKEYUfH3urM
 3GTnVGqhNeUWvCwKB2/EiJ5xtzJcou5wgkapvoY5oHhbl6R2GN1p1JPQ+GoGCLBbeHm2psDMhgQ
 PK4h8NQc0joghiXnwodhkdxY+2yR4jkP9Ga79tbspY9qOS6iu/IOMCeUjduxJ7uuC+5QCqK77FF
 K/Fg8TkE1QWZkD+K7Mpy4ARQKyFo6ko2n/MKVonHBb+8ncTRchZyXG3Lkls9IS30UPkdaJipuea
 d/fYySO60VLsk0Xg8wfpcsgJJB9q1z9mR0eYGZBRoFyN9SA2xjBB/yhZ8WqNRoVKJ8W/jgUk2K7
 94CL+9mCa4JXu3PRwPnt+cEq82MREwZsGk64cSYdBfWBTxlsVcOAzLnOd/kM92FkSFlKOCi75ot
 F7+HO2EbY7kN6gm3/7tlHGAqlTQjrvAeLTcvyNks1nQvoid6Lec0wkQwKYu8L4rpAsqWI1bJItO
 88tJg==
X-Received: by 2002:a05:600c:19c9:b0:485:3b33:f4b6 with SMTP id
 5b1f17b1804b1-4853b33f723mr25815545e9.0.1773009316954; 
 Sun, 08 Mar 2026 15:35:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4852e38c013sm282604645e9.8.2026.03.08.15.35.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:35:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/49] hw/acpi: Move acpi_send_event() function out of
 acpi_interface.c
Date: Sun,  8 Mar 2026 23:33:50 +0100
Message-ID: <20260308223433.25503-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20260225035739.42848-3-philmd@linaro.org>
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
2.53.0


