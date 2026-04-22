Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9011AFA1FEC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdnR-0008PD-GP; Wed, 22 Apr 2026 16:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdn6-00083P-Mp
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:03:21 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdn3-0003nB-OT
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:03:20 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43d73422431so4991714f8f.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776888196; x=1777492996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wPPwHg0YhbYOsKiFFkFNPpr//Tcvm9/IcIz9DcTTPd4=;
 b=xZ1DNw6MUCbeik3ogwIMIDQFzvNYa1ufmhBGt3Z1ArMCAv4Y5Eoa41QBqLiReJZ1g/
 COVA6UPwshJk5ldSnWZjW4eZbCWElbBKIDF2lMXi5kS2xjBqauL2HItWlBDgpruYZSPJ
 O41JQgIEXr/t60GpiX80ED5yh8QLF+HYNyPtDwC7423/cuTf7NYqdO+TFGK5HJmANr1K
 HZV08FpbOSpNqL8GK+LiQ/MOApK0W8WzQPoyfwAneeeFO6g+gV7dT9T1MI4dC+06K4HP
 gTTKgRNz87hnHlIvUn8OsNujbrURiHE5OFF1kY6VeLhGsNElY8EGkes58nf3WtKWWTc6
 joyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776888196; x=1777492996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wPPwHg0YhbYOsKiFFkFNPpr//Tcvm9/IcIz9DcTTPd4=;
 b=j3jmWAM+7HJA3oK2Zd9R58EnZQOOzxZ+OWLvgv10+5oIH99WKBloMhRZIyTH2YrWUV
 qlLNRtrmHdvxPkk1SoWMHqOT74RFfuDaolHPGotkphIe5XbjmptemrzOH/QMkl3Z0z2q
 0NIKIzyAycTnh+daLpELzS1upEEwdrNLJRjCKXFnGVMj963vjtJqaFOsu0KXAjtN0GoY
 xgHU6XZ/8n7ovwLx12GVcGXfsGsyjKkceGkQz8CedRTIs6Ns5d1FiTMIcWjGx8K3pnCg
 MACGj/FfFu73k2TuB98WJntGAFNqqmQhLHeQSXRF+xhS7G9EV3U0PvnUnraGPL7mbDmx
 IeSg==
X-Gm-Message-State: AOJu0YyBrrVan1HTbelWXfDcXNs1K+S9bT3utoMxfM7cajcBvaDzazmP
 eaHDRgqzQ6yONl8vpiSCr6X67hh1R5O+a/tG4EjWL4RcMoqLkdrrM22fCB1RH+xZR9gwkrmV5IC
 wpWBw97g=
X-Gm-Gg: AeBDietxQjFpx85Ct0b22mBq13c8zTOfGHieKQ5G6+3zfs/d1tCS1lBiDTmD4w9r7e5
 cxwUkjBQ9AtWSr/zaO4aqgdKpYqTDrZ++okjzFZgY+MVg4La0p6rLFCBoGuQgWcJ+Gf9rmylUQ3
 z53nKdQm6sOo0kYoDdQpvVF4lmD5TbZWZ6aZxh/oDPIO0fXBYt/2YClkVdvYssKUHHuTLI7Gxj8
 yihoPx1XfSkjF297lFjS+0MJ2Cf6ltRTomFpYBGQcGZ6nMozww50HXbisJAJVKsTFiZ/GemqEn5
 7qEcc/XQlwziqjthfiDTuO/e2aMYzPfOmKCjC85vzGL0tObeSzeJ1GJMKZ43dnQjWi5CTxMahOj
 8o8IqzBChnLWRwT/tWRU6MDvgp+x9/CC7ADxya2zjJRAl2Xb7WkoyZ+aOQplxV9E+YyEWpUUiZ4
 KW9LWVOeW1Zs+Jgz8qBGcvinbpSqRfzTrOrba71X4tuZ1pkG9G/Yn3x0zcS5wvkTul7iszbsNlu
 +QEW4aZmvQ=
X-Received: by 2002:a05:6000:2211:b0:43f:e938:1e67 with SMTP id
 ffacd0b85a97d-43fe9381e75mr34348984f8f.38.1776888195252; 
 Wed, 22 Apr 2026 13:03:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc0f31sm47646546f8f.12.2026.04.22.13.03.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 13:03:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 46/48] MAINTAINERS: Remove my disfunctional emails
Date: Wed, 22 Apr 2026 21:57:44 +0200
Message-ID: <20260422195746.88865-47-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

With retrospective, mentioning email in authorship wasn't
really useful, more now than these addresses are dead:
 - f4bug@amsat.org
 - philmd@redhat.com
Simply remove them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260422080406.62638-3-philmd@linaro.org>
---
 hw/sd/sdmmc-internal.h                      | 2 +-
 include/crypto/tls-cipher-suites.h          | 2 +-
 include/hw/i2c/arm_sbcon_i2c.h              | 2 +-
 include/hw/misc/bcm2835_thermal.h           | 2 +-
 include/hw/misc/led.h                       | 2 +-
 include/hw/timer/bcm2835_systmr.h           | 2 +-
 include/qemu/units.h                        | 2 +-
 crypto/tls-cipher-suites.c                  | 2 +-
 hw/i386/fw_cfg.c                            | 2 +-
 hw/i386/pc_sysfw_ovmf-stubs.c               | 2 +-
 hw/misc/bcm2835_thermal.c                   | 2 +-
 hw/misc/led.c                               | 2 +-
 hw/ppc/fw_cfg.c                             | 2 +-
 hw/sd/sd.c                                  | 2 +-
 hw/timer/bcm2835_systmr.c                   | 2 +-
 hw/usb/bus-stub.c                           | 2 +-
 stubs/fw_cfg.c                              | 2 +-
 stubs/hotplug-stubs.c                       | 2 +-
 stubs/qdev.c                                | 2 +-
 tests/qtest/fuzz-sb16-test.c                | 2 +-
 tests/qtest/fuzz-sdcard-test.c              | 2 +-
 tests/qtest/sdhci-test.c                    | 2 +-
 tests/functional/aarch64/test_raspi3.py     | 2 +-
 tests/functional/arm/test_bflt.py           | 2 +-
 tests/functional/arm/test_raspi2.py         | 2 +-
 tests/functional/m68k/test_nextcube.py      | 2 +-
 tests/functional/mips/test_malta.py         | 2 +-
 tests/functional/mips64el/test_fuloong2e.py | 2 +-
 tests/functional/mips64el/test_malta.py     | 2 +-
 tests/functional/mipsel/test_malta.py       | 2 +-
 tests/functional/ppc/test_40p.py            | 2 +-
 tests/functional/qemu_test/tesseract.py     | 2 +-
 32 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/hw/sd/sdmmc-internal.h b/hw/sd/sdmmc-internal.h
index c115f472efe..f9282a9712d 100644
--- a/hw/sd/sdmmc-internal.h
+++ b/hw/sd/sdmmc-internal.h
@@ -1,7 +1,7 @@
 /*
  * SD/MMC cards common
  *
- * Copyright (c) 2018  Philippe Mathieu-Daudé <f4bug@amsat.org>
+ * Copyright (c) 2018  Philippe Mathieu-Daudé
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
diff --git a/include/crypto/tls-cipher-suites.h b/include/crypto/tls-cipher-suites.h
index 3bd2003f32d..31697a7d6de 100644
--- a/include/crypto/tls-cipher-suites.h
+++ b/include/crypto/tls-cipher-suites.h
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2018-2020 Red Hat, Inc.
  *
- * Author: Philippe Mathieu-Daudé <philmd@redhat.com>
+ * Author: Philippe Mathieu-Daudé
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
diff --git a/include/hw/i2c/arm_sbcon_i2c.h b/include/hw/i2c/arm_sbcon_i2c.h
index 39b99f57bfb..537de428e1f 100644
--- a/include/hw/i2c/arm_sbcon_i2c.h
+++ b/include/hw/i2c/arm_sbcon_i2c.h
@@ -5,7 +5,7 @@
  *
  * Copyright (c) 2006-2007 CodeSourcery.
  * Copyright (c) 2012 Oskar Andero <oskar.andero@gmail.com>
- * Copyright (C) 2020 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ * Copyright (C) 2020 Philippe Mathieu-Daudé
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
diff --git a/include/hw/misc/bcm2835_thermal.h b/include/hw/misc/bcm2835_thermal.h
index 13ffc61c1a7..04eda5cb83f 100644
--- a/include/hw/misc/bcm2835_thermal.h
+++ b/include/hw/misc/bcm2835_thermal.h
@@ -1,7 +1,7 @@
 /*
  * BCM2835 dummy thermal sensor
  *
- * Copyright (C) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ * Copyright (C) 2019 Philippe Mathieu-Daudé
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
diff --git a/include/hw/misc/led.h b/include/hw/misc/led.h
index 4d077a7c43e..89ccbad4660 100644
--- a/include/hw/misc/led.h
+++ b/include/hw/misc/led.h
@@ -1,7 +1,7 @@
 /*
  * QEMU single LED device
  *
- * Copyright (C) 2020 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ * Copyright (C) 2020 Philippe Mathieu-Daudé
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
diff --git a/include/hw/timer/bcm2835_systmr.h b/include/hw/timer/bcm2835_systmr.h
index 0674a18f12d..770e464937b 100644
--- a/include/hw/timer/bcm2835_systmr.h
+++ b/include/hw/timer/bcm2835_systmr.h
@@ -1,7 +1,7 @@
 /*
  * BCM2835 SYS timer emulation
  *
- * Copyright (c) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ * Copyright (c) 2019 Philippe Mathieu-Daudé
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
diff --git a/include/qemu/units.h b/include/qemu/units.h
index 692db3fbb26..4764e301e5b 100644
--- a/include/qemu/units.h
+++ b/include/qemu/units.h
@@ -2,7 +2,7 @@
  * IEC binary prefixes definitions
  *
  * Copyright (C) 2015 Nikunj A Dadhania, IBM Corporation
- * Copyright (C) 2018 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ * Copyright (C) 2018 Philippe Mathieu-Daudé
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
diff --git a/crypto/tls-cipher-suites.c b/crypto/tls-cipher-suites.c
index d9b61d0c08a..a6566f13c9b 100644
--- a/crypto/tls-cipher-suites.c
+++ b/crypto/tls-cipher-suites.c
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2018-2020 Red Hat, Inc.
  *
- * Author: Philippe Mathieu-Daudé <philmd@redhat.com>
+ * Author: Philippe Mathieu-Daudé
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index 5670e8553ea..858e6ca9c53 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2019 Red Hat, Inc.
  *
  * Author:
- *   Philippe Mathieu-Daudé <philmd@redhat.com>
+ *   Philippe Mathieu-Daudé
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  *
diff --git a/hw/i386/pc_sysfw_ovmf-stubs.c b/hw/i386/pc_sysfw_ovmf-stubs.c
index b53906a0521..42e300ddec4 100644
--- a/hw/i386/pc_sysfw_ovmf-stubs.c
+++ b/hw/i386/pc_sysfw_ovmf-stubs.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2021 Red Hat, Inc.
  *
  * Author:
- *   Philippe Mathieu-Daudé <philmd@redhat.com>
+ *   Philippe Mathieu-Daudé
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  *
diff --git a/hw/misc/bcm2835_thermal.c b/hw/misc/bcm2835_thermal.c
index 0dc1be15b4a..413c4179fed 100644
--- a/hw/misc/bcm2835_thermal.c
+++ b/hw/misc/bcm2835_thermal.c
@@ -1,7 +1,7 @@
 /*
  * BCM2835 dummy thermal sensor
  *
- * Copyright (C) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ * Copyright (C) 2019 Philippe Mathieu-Daudé
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
diff --git a/hw/misc/led.c b/hw/misc/led.c
index d9256aaaf56..8b758c1b76d 100644
--- a/hw/misc/led.c
+++ b/hw/misc/led.c
@@ -1,7 +1,7 @@
 /*
  * QEMU single LED device
  *
- * Copyright (C) 2020 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ * Copyright (C) 2020 Philippe Mathieu-Daudé
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
diff --git a/hw/ppc/fw_cfg.c b/hw/ppc/fw_cfg.c
index a88b5c4bde2..071cf855c23 100644
--- a/hw/ppc/fw_cfg.c
+++ b/hw/ppc/fw_cfg.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2019 Red Hat, Inc.
  *
  * Author:
- *   Philippe Mathieu-Daudé <philmd@redhat.com>
+ *   Philippe Mathieu-Daudé
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  *
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 37f6e0702b0..58275e7fa19 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -6,7 +6,7 @@
  *
  * Copyright (c) 2006 Andrzej Zaborowski  <balrog@zabor.org>
  * Copyright (c) 2007 CodeSourcery
- * Copyright (c) 2018 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ * Copyright (c) 2018 Philippe Mathieu-Daudé
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions
diff --git a/hw/timer/bcm2835_systmr.c b/hw/timer/bcm2835_systmr.c
index 00bcfcd05c6..06a919b1f8b 100644
--- a/hw/timer/bcm2835_systmr.c
+++ b/hw/timer/bcm2835_systmr.c
@@ -1,7 +1,7 @@
 /*
  * BCM2835 SYS timer emulation
  *
- * Copyright (C) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ * Copyright (C) 2019 Philippe Mathieu-Daudé
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  *
diff --git a/hw/usb/bus-stub.c b/hw/usb/bus-stub.c
index a7c3909e967..7cf1b494117 100644
--- a/hw/usb/bus-stub.c
+++ b/hw/usb/bus-stub.c
@@ -1,7 +1,7 @@
 /*
  * QEMU USB device emulation stubs
  *
- * Copyright (C) 2021 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ * Copyright (C) 2021 Philippe Mathieu-Daudé
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
diff --git a/stubs/fw_cfg.c b/stubs/fw_cfg.c
index bb1e3c8aa95..e7a9f714f35 100644
--- a/stubs/fw_cfg.c
+++ b/stubs/fw_cfg.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2019 Red Hat, Inc.
  *
  * Author:
- *   Philippe Mathieu-Daudé <philmd@redhat.com>
+ *   Philippe Mathieu-Daudé
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  *
diff --git a/stubs/hotplug-stubs.c b/stubs/hotplug-stubs.c
index 23a1678dbbc..0f592ee1391 100644
--- a/stubs/hotplug-stubs.c
+++ b/stubs/hotplug-stubs.c
@@ -4,7 +4,7 @@
  * Copyright (c) Red Hat
  *
  * Authors:
- *  Philippe Mathieu-Daudé <philmd@redhat.com>,
+ *  Philippe Mathieu-Daudé,
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  *
diff --git a/stubs/qdev.c b/stubs/qdev.c
index 7e957b3e524..61596de5f87 100644
--- a/stubs/qdev.c
+++ b/stubs/qdev.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2021 Red Hat, Inc.
  *
  * Author:
- *   Philippe Mathieu-Daudé <philmd@redhat.com>
+ *   Philippe Mathieu-Daudé
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  *
diff --git a/tests/qtest/fuzz-sb16-test.c b/tests/qtest/fuzz-sb16-test.c
index fc445b18710..9995ad88685 100644
--- a/tests/qtest/fuzz-sb16-test.c
+++ b/tests/qtest/fuzz-sb16-test.c
@@ -1,7 +1,7 @@
 /*
  * QTest fuzzer-generated testcase for sb16 audio device
  *
- * Copyright (c) 2021 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ * Copyright (c) 2021 Philippe Mathieu-Daudé
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
diff --git a/tests/qtest/fuzz-sdcard-test.c b/tests/qtest/fuzz-sdcard-test.c
index cd134cdf556..6d8be9d1195 100644
--- a/tests/qtest/fuzz-sdcard-test.c
+++ b/tests/qtest/fuzz-sdcard-test.c
@@ -1,7 +1,7 @@
 /*
  * QTest fuzzer-generated testcase for sdcard device
  *
- * Copyright (c) 2021 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ * Copyright (c) 2021 Philippe Mathieu-Daudé
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
diff --git a/tests/qtest/sdhci-test.c b/tests/qtest/sdhci-test.c
index 7b32711c8f8..cde132228eb 100644
--- a/tests/qtest/sdhci-test.c
+++ b/tests/qtest/sdhci-test.c
@@ -1,7 +1,7 @@
 /*
  * QTest testcase for SDHCI controllers
  *
- * Written by Philippe Mathieu-Daudé <f4bug@amsat.org>
+ * Written by Philippe Mathieu-Daudé
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
diff --git a/tests/functional/aarch64/test_raspi3.py b/tests/functional/aarch64/test_raspi3.py
index 74f6630ed26..ae9eed3589f 100755
--- a/tests/functional/aarch64/test_raspi3.py
+++ b/tests/functional/aarch64/test_raspi3.py
@@ -3,7 +3,7 @@
 # Functional test that boots a Linux kernel on a Raspberry Pi machine
 # and checks the console
 #
-# Copyright (c) 2020 Philippe Mathieu-Daudé <f4bug@amsat.org>
+# Copyright (c) 2020 Philippe Mathieu-Daudé
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
diff --git a/tests/functional/arm/test_bflt.py b/tests/functional/arm/test_bflt.py
index f273fc83546..835a3354a03 100755
--- a/tests/functional/arm/test_bflt.py
+++ b/tests/functional/arm/test_bflt.py
@@ -2,7 +2,7 @@
 #
 # Test the bFLT loader format
 #
-# Copyright (C) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
+# Copyright (C) 2019 Philippe Mathieu-Daudé
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
diff --git a/tests/functional/arm/test_raspi2.py b/tests/functional/arm/test_raspi2.py
index d3c7aaa39b0..fe644f04cf4 100755
--- a/tests/functional/arm/test_raspi2.py
+++ b/tests/functional/arm/test_raspi2.py
@@ -3,7 +3,7 @@
 # Functional test that boots a Linux kernel on a Raspberry Pi machine
 # and checks the console
 #
-# Copyright (c) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
+# Copyright (c) 2019 Philippe Mathieu-Daudé
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
diff --git a/tests/functional/m68k/test_nextcube.py b/tests/functional/m68k/test_nextcube.py
index 71c160d0262..d917cf5424f 100755
--- a/tests/functional/m68k/test_nextcube.py
+++ b/tests/functional/m68k/test_nextcube.py
@@ -2,7 +2,7 @@
 #
 # Functional test that boots a VM and run OCR on the framebuffer
 #
-# Copyright (c) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
+# Copyright (c) 2019 Philippe Mathieu-Daudé
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
diff --git a/tests/functional/mips/test_malta.py b/tests/functional/mips/test_malta.py
index e8f49f130be..7048d91a9fd 100755
--- a/tests/functional/mips/test_malta.py
+++ b/tests/functional/mips/test_malta.py
@@ -2,7 +2,7 @@
 #
 # Functional tests for the big-endian 32-bit MIPS Malta board
 #
-# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
+# Copyright (c) Philippe Mathieu-Daudé
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
diff --git a/tests/functional/mips64el/test_fuloong2e.py b/tests/functional/mips64el/test_fuloong2e.py
index 35e500b0221..d449e3c39a7 100755
--- a/tests/functional/mips64el/test_fuloong2e.py
+++ b/tests/functional/mips64el/test_fuloong2e.py
@@ -2,7 +2,7 @@
 #
 # Functional tests for the Lemote Fuloong-2E machine.
 #
-# Copyright (c) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
+# Copyright (c) 2019 Philippe Mathieu-Daudé
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or later.
 # See the COPYING file in the top-level directory.
diff --git a/tests/functional/mips64el/test_malta.py b/tests/functional/mips64el/test_malta.py
index bc750cb7ad6..163bbaf5ca3 100755
--- a/tests/functional/mips64el/test_malta.py
+++ b/tests/functional/mips64el/test_malta.py
@@ -2,7 +2,7 @@
 #
 # Functional tests for the little-endian 64-bit MIPS Malta board
 #
-# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
+# Copyright (c) Philippe Mathieu-Daudé
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or later.
 # See the COPYING file in the top-level directory.
diff --git a/tests/functional/mipsel/test_malta.py b/tests/functional/mipsel/test_malta.py
index 59ab4a60585..25bcb33c945 100755
--- a/tests/functional/mipsel/test_malta.py
+++ b/tests/functional/mipsel/test_malta.py
@@ -2,7 +2,7 @@
 #
 # Functional tests for the little-endian 32-bit MIPS Malta board
 #
-# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
+# Copyright (c) Philippe Mathieu-Daudé
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or later.
 # See the COPYING file in the top-level directory.
diff --git a/tests/functional/ppc/test_40p.py b/tests/functional/ppc/test_40p.py
index ed272147f6e..4c1c9bad6ec 100755
--- a/tests/functional/ppc/test_40p.py
+++ b/tests/functional/ppc/test_40p.py
@@ -2,7 +2,7 @@
 #
 # Functional test that boots a PReP/40p machine and checks its serial console.
 #
-# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
+# Copyright (c) Philippe Mathieu-Daudé
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later. See the COPYING file in the top-level directory.
diff --git a/tests/functional/qemu_test/tesseract.py b/tests/functional/qemu_test/tesseract.py
index ede6c6501e2..862faec2d2e 100644
--- a/tests/functional/qemu_test/tesseract.py
+++ b/tests/functional/qemu_test/tesseract.py
@@ -1,6 +1,6 @@
 # ...
 #
-# Copyright (c) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
+# Copyright (c) 2019 Philippe Mathieu-Daudé
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later. See the COPYING file in the top-level directory.
-- 
2.53.0


