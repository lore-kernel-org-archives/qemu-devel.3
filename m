Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4EEF8D762
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 17:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDQUC-0006lE-4v; Thu, 16 Apr 2026 13:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDQUA-0006kk-0x
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 13:26:38 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDQU6-00068q-Dz
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 13:26:37 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488aa77a06eso134939975e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 10:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776360390; x=1776965190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=dguMNu+rblwGHa+gUuLRqPdQYImX3ZlNd0zX09DdGe4=;
 b=leqm9TcFn2DWp4wNJO3Y6XUJ7/NHMnrTCZV2m69xib8+L+gqbN0Td3tJ0Sa519gzVe
 eZh9r1Ag9M0fsUL7otIGOzDFK4faNCa/MatS9ASy1b0jBNSR8neLFhkZwsVHrBQAYbZ+
 ItPYrb/ACmdcUVckHBfATC9YJu6t4AOkAo4Ci549YiTCSM75ISqmXjBO+9sa7zYNhU+O
 PBHq8Qmuj10S0u23INOYeLcIUDJZ2H/xKSXXEG5BsIoh2sFeX8Uq1+KJtU74Y4ytJG1C
 d5nbvkHE9st5+J+0SYwpKxAPkqYoH7XNReHb3HWMbdX1udh9ULhJ6XbM9nizEqOU6SRR
 Eplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776360390; x=1776965190;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dguMNu+rblwGHa+gUuLRqPdQYImX3ZlNd0zX09DdGe4=;
 b=fk9ffrtsgMiKGrLN0NBRobNbkYt0olTdiG4nzpud9+7BuZCic0wNhou/4ci1fb8gms
 hzN8At57t7QpfjLzbEtZxLn9jVyGBhk7Td7fwprLu1+ZUPB3Px8TpHoXS06rk1ZNxmqd
 uZkhh3wiIQc97MqE1k37A4B5swzwplDBpyhjAIpQ9T/Ucy0c4CjZWDt5KQm17aBoGQ9B
 DxcVN9+ElmyoFBPe/GGhN9B58YnaYLiwc4vhkYpWtFm1wrT9p+HSS+kbYT2s2G/EWlpl
 A6WW+6M9J/km/gNN86W1Vf5kqWU7xcyXgYF77YviNwL6CADPmYWNOL6tcyB8bP3UlReY
 AydQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8rCdxY4WQet5cK31dvbw+1D7clXWQZe6+i/Gy18PuFUwGf32+NQkw4V+Gxm2wqcb5MFFirKGauFW3P@nongnu.org
X-Gm-Message-State: AOJu0YwI8Eth+DtUMDFZFKB7mLKncuyiELmESps75vcRgyJRUi9ODuyz
 lh5BAAijnIs5fASvyhjRmaeenJf51EME/vfMOKD2SHEFnm4pwnxTv7m0v3qIP6Lqn3ZW4i7KWsu
 XANNXuS8=
X-Gm-Gg: AeBDieu4od/aPJInf0H7WoGxO2MrDWoKvDPYdF89atCUb3Hyy7xUHRx9xVOzbFOEycL
 MRi01II1yWCWNcyE2IcdKmDgzPavd8a96b1ysTeltIi424cgVuqjuROAjJ4JQA7Bm1D7bNYSPHh
 SdndueBEKwM7JFJFfV+fhcSxPNH4DaHU+BvPlHmh63JWsCOU93qOu7/ht/2hsYk7cTEJtKcNyA7
 b/OTF7pqb0GgbRp9skZwHlFkaL3Q0FyUnQ48DBb0hJ6+082/9Mv39bHxAWc2o+x3atYexshIOFs
 PcKGLnhbm37tdGAVQRKx2bodcs4QRG7uuODiL8Hmvcao9eDhoqu/zmBNvJJeC1tk0VPMKh0E+qj
 mXCJ0MY1zp0TDH2RZqTqEt6R8TrwphMxDaLZlVHlCAq9NZ9HPzSiEkdQKebrneCu/EqIteT5XG+
 wdSChZio71bT0r2QDTZQjvAZ0038phaYdw5Q6Ra7UamNgRQHj1r2jrNi5BuwkKnK8O2aMDKNza1
 UH5Fv+zgZIANwGWd36G9DdbzYEwHoS9J9eubtz2Uw==
X-Received: by 2002:a05:600c:c108:b0:488:c282:e78c with SMTP id
 5b1f17b1804b1-488d684bd3amr260538165e9.19.1776360390170; 
 Thu, 16 Apr 2026 10:26:30 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fa73cbe3sm2022615e9.0.2026.04.16.10.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 10:26:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] hw: Move ARM_SYSCTL_GPIO definitions to arm sysctl specific
 header
Date: Thu, 16 Apr 2026 18:26:27 +0100
Message-ID: <20260416172627.690396-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

include/hw/arm/primecell.h used to be more expansive, but now the
only thing it defines is the ARM_SYSCTL_GPIO_* constants for the GPIO
lines for the arm-sysctl system-control device used on the Realview,
Versatile and Versatile Express boards.

Replace it with a header file specific to that device.

virt.c and vmapple.c included primecell.h despite not using the
constants it defined; there we can simply drop the include entirely.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Trivial cleanup; I was trying out emacs eglot and it flagged
up that virt.c includes primecell.h unnecessarily, which led
me to this.
---
 MAINTAINERS                  |  2 +-
 hw/arm/realview.c            |  2 +-
 hw/arm/vexpress.c            |  2 +-
 hw/arm/virt.c                |  1 -
 hw/misc/arm_sysctl.c         |  2 +-
 hw/vmapple/vmapple.c         |  1 -
 include/hw/arm/primecell.h   | 12 ------------
 include/hw/misc/arm_sysctl.h | 16 ++++++++++++++++
 8 files changed, 20 insertions(+), 18 deletions(-)
 delete mode 100644 include/hw/arm/primecell.h
 create mode 100644 include/hw/misc/arm_sysctl.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ad215eced8..7f2b34d652 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -761,7 +761,6 @@ F: hw/ssi/pl022.c
 F: include/hw/ssi/pl022.h
 F: hw/rtc/pl031.c
 F: include/hw/rtc/pl031.h
-F: include/hw/arm/primecell.h
 F: hw/timer/cmsdk-apb-timer.c
 F: include/hw/timer/cmsdk-apb-timer.h
 F: tests/qtest/cmsdk-apb-timer-test.c
@@ -1106,6 +1105,7 @@ F: hw/*/versatile*
 F: hw/i2c/arm_sbcon_i2c.c
 F: include/hw/i2c/arm_sbcon_i2c.h
 F: hw/misc/arm_sysctl.c
+F: include/hw/misc/arm_sysctl.h
 F: docs/system/arm/versatile.rst
 
 Virt
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index c9558be4d4..bfcce4419a 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -12,9 +12,9 @@
 #include "cpu.h"
 #include "hw/core/sysbus.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/primecell.h"
 #include "hw/arm/machines-qom.h"
 #include "hw/core/split-irq.h"
+#include "hw/misc/arm_sysctl.h"
 #include "hw/net/lan9118.h"
 #include "hw/net/smc91c111.h"
 #include "hw/pci/pci.h"
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index cc6ae7d4c4..9db8a68ba9 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -26,8 +26,8 @@
 #include "qemu/datadir.h"
 #include "hw/core/sysbus.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/primecell.h"
 #include "hw/arm/machines-qom.h"
+#include "hw/misc/arm_sysctl.h"
 #include "hw/net/lan9118.h"
 #include "hw/i2c/i2c.h"
 #include "net/net.h"
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ec0d8475ca..16e905dca8 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -36,7 +36,6 @@
 #include "monitor/qdev.h"
 #include "hw/core/sysbus.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/primecell.h"
 #include "hw/arm/virt.h"
 #include "hw/arm/machines-qom.h"
 #include "hw/block/flash.h"
diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
index 7b320f89c1..ebc95b9bb5 100644
--- a/hw/misc/arm_sysctl.c
+++ b/hw/misc/arm_sysctl.c
@@ -14,8 +14,8 @@
 #include "system/runstate.h"
 #include "qemu/bitops.h"
 #include "hw/core/sysbus.h"
+#include "hw/misc/arm_sysctl.h"
 #include "migration/vmstate.h"
-#include "hw/arm/primecell.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qom/object.h"
diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
index b1379eafef..607181f517 100644
--- a/hw/vmapple/vmapple.c
+++ b/hw/vmapple/vmapple.c
@@ -32,7 +32,6 @@
 #include "hw/core/sysbus.h"
 #include "hw/usb/usb.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/primecell.h"
 #include "hw/char/pl011.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/intc/arm_gicv3_common.h"
diff --git a/include/hw/arm/primecell.h b/include/hw/arm/primecell.h
deleted file mode 100644
index 7337c3b3ca..0000000000
--- a/include/hw/arm/primecell.h
+++ /dev/null
@@ -1,12 +0,0 @@
-#ifndef PRIMECELL_H
-#define PRIMECELL_H
-
-/* Declarations for ARM PrimeCell based periperals.  */
-/* Also includes some devices that are currently only used by the
-   ARM boards.  */
-
-/* arm_sysctl GPIO lines */
-#define ARM_SYSCTL_GPIO_MMC_WPROT 0
-#define ARM_SYSCTL_GPIO_MMC_CARDIN 1
-
-#endif
diff --git a/include/hw/misc/arm_sysctl.h b/include/hw/misc/arm_sysctl.h
new file mode 100644
index 0000000000..424069cd6e
--- /dev/null
+++ b/include/hw/misc/arm_sysctl.h
@@ -0,0 +1,16 @@
+/*
+ * Status and system control registers for ARM RealView/Versatile boards.
+ *
+ * Copyright (c) Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_ARM_SYSCTL_H
+#define HW_MISC_ARM_SYSCTL_H
+
+/* arm_sysctl inbound GPIO lines */
+#define ARM_SYSCTL_GPIO_MMC_WPROT 0
+#define ARM_SYSCTL_GPIO_MMC_CARDIN 1
+
+#endif
-- 
2.43.0


