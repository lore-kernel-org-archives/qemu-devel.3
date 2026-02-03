Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D6AE83063
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 08:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnC9M-0004YO-Lc; Tue, 03 Feb 2026 03:52:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vnC9L-0004Xl-9b; Tue, 03 Feb 2026 03:52:43 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vnC9J-0002qU-Il; Tue, 03 Feb 2026 03:52:43 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 3 Feb
 2026 16:52:29 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 3 Feb 2026 16:52:29 +0800
To: <komlodi@google.com>, <nabihestefan@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "open list:All
 patches CC here" <qemu-devel@nongnu.org>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>, Patrick Venture <venture@google.com>, "Titus
 Rwantare" <titusr@google.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>
Subject: [PATCH v2 01/20] hw/misc/aspeed_i3c: Move to i3c directory
Date: Tue, 3 Feb 2026 16:52:01 +0800
Message-ID: <20260203085229.1543287-2-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203085229.1543287-1-jamin_lin@aspeedtech.com>
References: <20260203085229.1543287-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Joe Komlodi <komlodi@google.com>

Moves the Aspeed I3C model and traces into hw/i3c and creates I3C build
files.

Signed-off-by: Joe Komlodi <komlodi@google.com>

Reviewed-by: Patrick Venture <venture@google.com>
Reviewed-by: Titus Rwantare <titusr@google.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 meson.build                           | 1 +
 hw/i3c/trace.h                        | 2 ++
 include/hw/arm/aspeed_soc.h           | 2 +-
 include/hw/{misc => i3c}/aspeed_i3c.h | 0
 hw/{misc => i3c}/aspeed_i3c.c         | 2 +-
 hw/Kconfig                            | 1 +
 hw/arm/Kconfig                        | 1 +
 hw/i3c/Kconfig                        | 2 ++
 hw/i3c/meson.build                    | 3 +++
 hw/i3c/trace-events                   | 7 +++++++
 hw/meson.build                        | 1 +
 hw/misc/meson.build                   | 1 -
 hw/misc/trace-events                  | 6 ------
 13 files changed, 20 insertions(+), 9 deletions(-)
 create mode 100644 hw/i3c/trace.h
 rename include/hw/{misc => i3c}/aspeed_i3c.h (100%)
 rename hw/{misc => i3c}/aspeed_i3c.c (99%)
 create mode 100644 hw/i3c/Kconfig
 create mode 100644 hw/i3c/meson.build
 create mode 100644 hw/i3c/trace-events

diff --git a/meson.build b/meson.build
index a84f14258b..463af9e33e 100644
--- a/meson.build
+++ b/meson.build
@@ -3600,6 +3600,7 @@ if have_system
     'hw/fsi',
     'hw/hyperv',
     'hw/i2c',
+    'hw/i3c',
     'hw/i386',
     'hw/i386/xen',
     'hw/i386/kvm',
diff --git a/hw/i3c/trace.h b/hw/i3c/trace.h
new file mode 100644
index 0000000000..1e0c4eadf0
--- /dev/null
+++ b/hw/i3c/trace.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include "trace/trace-hw_i3c.h"
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 18ff961a38..b3fc68f292 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -23,7 +23,7 @@
 #include "hw/timer/aspeed_timer.h"
 #include "hw/rtc/aspeed_rtc.h"
 #include "hw/i2c/aspeed_i2c.h"
-#include "hw/misc/aspeed_i3c.h"
+#include "hw/i3c/aspeed_i3c.h"
 #include "hw/ssi/aspeed_smc.h"
 #include "hw/misc/aspeed_hace.h"
 #include "hw/misc/aspeed_sbc.h"
diff --git a/include/hw/misc/aspeed_i3c.h b/include/hw/i3c/aspeed_i3c.h
similarity index 100%
rename from include/hw/misc/aspeed_i3c.h
rename to include/hw/i3c/aspeed_i3c.h
diff --git a/hw/misc/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c
similarity index 99%
rename from hw/misc/aspeed_i3c.c
rename to hw/i3c/aspeed_i3c.c
index ac6db214ee..fff259ff66 100644
--- a/hw/misc/aspeed_i3c.c
+++ b/hw/i3c/aspeed_i3c.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
-#include "hw/misc/aspeed_i3c.h"
+#include "hw/i3c/aspeed_i3c.h"
 #include "hw/core/registerfields.h"
 #include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
diff --git a/hw/Kconfig b/hw/Kconfig
index 9e6c789ae7..c53f94d96a 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -13,6 +13,7 @@ source fsi/Kconfig
 source gpio/Kconfig
 source hyperv/Kconfig
 source i2c/Kconfig
+source i3c/Kconfig
 source ide/Kconfig
 source input/Kconfig
 source intc/Kconfig
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 97d747e206..822597458a 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -545,6 +545,7 @@ config ASPEED_SOC
     select DS1338
     select FTGMAC100
     select I2C
+    select I3C
     select DPS310
     select PCA9552
     select PCA9554
diff --git a/hw/i3c/Kconfig b/hw/i3c/Kconfig
new file mode 100644
index 0000000000..e07fe445c6
--- /dev/null
+++ b/hw/i3c/Kconfig
@@ -0,0 +1,2 @@
+config I3C
+    bool
diff --git a/hw/i3c/meson.build b/hw/i3c/meson.build
new file mode 100644
index 0000000000..ebf20325cb
--- /dev/null
+++ b/hw/i3c/meson.build
@@ -0,0 +1,3 @@
+i3c_ss = ss.source_set()
+i3c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i3c.c'))
+system_ss.add_all(when: 'CONFIG_I3C', if_true: i3c_ss)
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events
new file mode 100644
index 0000000000..3ead84eb45
--- /dev/null
+++ b/hw/i3c/trace-events
@@ -0,0 +1,7 @@
+# See docs/devel/tracing.rst for syntax documentation.
+
+# aspeed_i3c.c
+aspeed_i3c_read(uint64_t offset, uint64_t data) "I3C read: offset 0x%" PRIx64 " data 0x%" PRIx64
+aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C write: offset 0x%" PRIx64 " data 0x%" PRIx64
+aspeed_i3c_device_read(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64
+aspeed_i3c_device_write(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64
diff --git a/hw/meson.build b/hw/meson.build
index 1022bdb806..e05dc4864c 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -35,6 +35,7 @@ subdir('dma')
 subdir('gpio')
 subdir('hyperv')
 subdir('i2c')
+subdir('i3c')
 subdir('ide')
 subdir('input')
 subdir('intc')
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index c444e030ec..bf08545a6e 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -135,7 +135,6 @@ system_ss.add(when: 'CONFIG_PVPANIC_MMIO', if_true: files('pvpanic-mmio.c'))
 system_ss.add(when: 'CONFIG_AUX', if_true: files('auxbus.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_hace.c',
-  'aspeed_i3c.c',
   'aspeed_lpc.c',
   'aspeed_scu.c',
   'aspeed_sbc.c',
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 4cee8a2b45..e1265611bb 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -293,12 +293,6 @@ armsse_mhu_write(uint64_t offset, uint64_t data, unsigned size) "SSE-200 MHU wri
 # aspeed_xdma.c
 aspeed_xdma_write(uint64_t offset, uint64_t data) "XDMA write: offset 0x%" PRIx64 " data 0x%" PRIx64
 
-# aspeed_i3c.c
-aspeed_i3c_read(uint64_t offset, uint64_t data) "I3C read: offset 0x%" PRIx64 " data 0x%" PRIx64
-aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C write: offset 0x%" PRIx64 " data 0x%" PRIx64
-aspeed_i3c_device_read(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64
-aspeed_i3c_device_write(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64
-
 # aspeed_sdmc.c
 aspeed_sdmc_write(uint64_t reg, uint64_t data) "reg @0x%" PRIx64 " data: 0x%" PRIx64
 aspeed_sdmc_read(uint64_t reg, uint64_t data) "reg @0x%" PRIx64 " data: 0x%" PRIx64
-- 
2.43.0


