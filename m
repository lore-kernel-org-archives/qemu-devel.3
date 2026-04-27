Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC5AFF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLU8-0006Sh-6f; Mon, 27 Apr 2026 08:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNq-00084k-9q
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:25 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNi-0005fU-Qk
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:13 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so127020295e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294085; x=1777898885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7ZMrAR860LVLLbEn3nTo+Jz2p6zIzurqX1lJh5uQLiY=;
 b=srHfm4lcUF36gz9rsxxNUMhTrzyO9wMLqmOhshbYoet1CLd4p4/NkX0yzUb2Lg8AjX
 4JaY9W8SZ2Q/7dwTL+0HLRFq+mRsqUkU4cFZSvDSaN5YpEYSy8c2OjmarGr9I/JqnqrG
 wJHK4td5IyWI7nzNGeugll5gXqrpcMfSWGYEvIN45WSjF35IIIbBoQqdVrStGs8tVfZc
 CjJhEccP//IpeMRMNhhzOJdaqs7qgLD3Q9qj5gU3wunrsE1IOo90tGP7lOpPu5stH3pf
 YIy/BFGbSagyUlWyuqNDgFL/Rc++DXjANpCIncSSfGI/czymIkWTXD0ooXrc9bNcyxhq
 9f6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294085; x=1777898885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7ZMrAR860LVLLbEn3nTo+Jz2p6zIzurqX1lJh5uQLiY=;
 b=WdRkb/jlnio4lgKi9O4eUhu4944mB6rzE8vP7ijfun1Hu9qRm4VpxboXNmKpVczRpN
 GLspW6xrR3Az/7LzPYuvu5MTkyH3MDBwdYAYIX36wasesZsK6NHMDwbjH+oFbYchq2wC
 ilTZNR/xnLV1UafeLYuWEdeC75C8+IlFXHs8IMkYQd4uSJlhNoiLeRswLlQGNknar1SG
 ljFjJvdRNN3ROgnFn7v79FUQDrDLUjLb29s0mu1yfmU+WzkP+xIaq2l/A4cQ7T68F+X4
 Mjk63UdfPNfT48gMaPsLpjdbpnk8vMe55BYHCQuftZ7O33FClyGE8b3nkGtUANrZIrjl
 i3Tw==
X-Gm-Message-State: AOJu0Yxa1Zh1yK6WY0wGj5BHjGdcQR+nSA8qL3vHareWXMHRsYui0kn7
 n76C+USl4UHESlwBMPm/bonS3h/nECaSivXx6lF+2xmbIfVHGM1bOe+w2CSjo+PdBXGC4HbDsZm
 6UPLa
X-Gm-Gg: AeBDievt4pNKruRLVrB2gHFoHDBm0VoX549OoLjHEjFtDjZmCvbCXMgGkP05RSGFKgq
 pgYv2Ypkl70ReuczIcRG62V/kZOQhfdjp8c4e5SHNuh4UJEkQLOFI2OXaJe4lqkCAbvt78ej6cf
 NloggqchkBhpzgs1i+WCk988c3gn5W2EPC9Vd2Ut1Xh0RyuQkuQ3sN7dO1uFD+raMWxz8vMbXlv
 5eIkRgUXW9QS5scNzsfrNeFVY9Y0b1yrts1520B18HHalXzTY7+0TZjjvFFAtvmNNJECkR9Z9Og
 IqeMKpQp7oRznFqF92i3/+hyin28AszEoa9nVOibSYXF5NT0HJNyAYg5quBcDZcTSADO6U5zKUy
 QNzCBJnAmywtYv8B7nocAWuh4qPSnUK2rPJKzKPIg95hMLJopVo06IS2C15dHxOsSuQjrBeCWp0
 fj75jdwzvLS7IocBRQS76KqHjzfzWmcplSrlvWLljsn/KuwQJynJVo2s3JHTD0xGldLnKcbDwO2
 eQIKyl3H3FSgQvn4UNV/PZB3te/9pA5QSXRzssQPA==
X-Received: by 2002:a05:600c:4714:b0:48a:5574:3a5b with SMTP id
 5b1f17b1804b1-48a55743d05mr384702495e9.27.1777294084480; 
 Mon, 27 Apr 2026 05:48:04 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/63] hw: Move ARM_SYSCTL_GPIO definitions to arm sysctl
 specific header
Date: Mon, 27 Apr 2026 13:47:01 +0100
Message-ID: <20260427124738.966578-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

include/hw/arm/primecell.h used to be more expansive, but now the
only thing it defines is the ARM_SYSCTL_GPIO_* constants for the GPIO
lines for the arm-sysctl system-control device used on the Realview,
Versatile and Versatile Express boards.

Replace it with a header file specific to that device.

virt.c and vmapple.c included primecell.h despite not using the
constants it defined; there we can simply drop the include entirely.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260416172627.690396-1-peter.maydell@linaro.org
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
index 8d980d6c40..50a8e161c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -759,7 +759,6 @@ F: hw/ssi/pl022.c
 F: include/hw/ssi/pl022.h
 F: hw/rtc/pl031.c
 F: include/hw/rtc/pl031.h
-F: include/hw/arm/primecell.h
 F: hw/timer/cmsdk-apb-timer.c
 F: include/hw/timer/cmsdk-apb-timer.h
 F: tests/qtest/cmsdk-apb-timer-test.c
@@ -1113,6 +1112,7 @@ F: hw/*/versatile*
 F: hw/i2c/arm_sbcon_i2c.c
 F: include/hw/i2c/arm_sbcon_i2c.h
 F: hw/misc/arm_sysctl.c
+F: include/hw/misc/arm_sysctl.h
 F: docs/system/arm/versatile.rst
 
 Virt
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 7c49995c80..2b9f3271d6 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -12,9 +12,9 @@
 #include "target/arm/cpu.h"
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
index b178798085..f26d8c6f8d 100644
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
index f62253e1ab..77891f0820 100644
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


