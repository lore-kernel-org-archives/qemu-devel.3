Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56BDC61DDE
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 23:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0SiK-000845-6a; Sat, 29 Aug 2026 19:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0SiI-00082j-0u; Sat, 29 Aug 2026 19:43:54 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0SiG-0006Cm-AL; Sat, 29 Aug 2026 19:43:53 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4hXWzb28MzzBqXZ;
 Sun, 30 Aug 2026 01:43:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788047019;
 bh=cBVN2elGMHwvfeXc8aJbqK7Eg2e45SlSAax/Afk10WY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=c/xdt58n9LalEbIA7a3sY8SY8f3T3P9eIFhFcv+j/l7L8JA0Xk3Eigw7mohhVs6Yd
 9K60LtgzSqi632fSNhxVYEDnatDPHdgwrSgZgGM887tG5iMpjCHOZI4AY4mlpKXtZn
 UIRrp7pvOQH9OKbz73Hnvg1PNSmw0agVa9x9a/t6kIzRkGesTNjX8QfL5FSoM6UC3J
 dmXl5KC5sWDUe3k7fSm+aFQBdXZAuFOPIbgMM5qMJq9lebplzMd/Sfbi9c0wCS+YYJ
 he1imJDYZm/M3oNBsNGYmASJ+BUAXEBAmaJxVzV0GIfJcPXRCR4WOlLQiJ8SVROU5+
 sieCQYHJYvHww==
Received: from localhost.localdomain (unknown [10.134.14.34])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hXWzb0gZBz7vrV;
 Sun, 30 Aug 2026 01:43:39 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, qemu-arm@nongnu.org,
 gilles grimaud <gilles.grimaud@univ-lille.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH RFC v2 03/30] hw/misc: add RP2040 diagnostic helpers
Date: Sun, 30 Aug 2026 01:42:37 +0200
Message-ID: <20260829234308.33725-4-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
References: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.82;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-1.univ-lille.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: gilles grimaud <gilles.grimaud@univ-lille.fr>

Add shared helpers for reporting unimplemented RP2040 features and register accesses. Keeping the formatting in one place makes shallow peripheral models explicit and gives their diagnostics a consistent component, address, offset and value format.

Add a dedicated Kconfig symbol so the helpers remain disabled until selected by the RP2040 SoC.

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 MAINTAINERS                  |  7 ++++++
 hw/misc/Kconfig              |  3 +++
 hw/misc/meson.build          |  1 +
 hw/misc/rp2040_nyi.c         | 47 ++++++++++++++++++++++++++++++++++++
 include/hw/misc/rp2040_nyi.h | 19 +++++++++++++++
 5 files changed, 77 insertions(+)
 create mode 100644 hw/misc/rp2040_nyi.c
 create mode 100644 include/hw/misc/rp2040_nyi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 55f6f2e3c0..db641d9c4c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1035,6 +1035,13 @@ F: docs/system/arm/raspi.rst
 F: tests/functional/arm/test_raspi2.py
 F: tests/functional/aarch64/test_raspi*.py
 
+Raspberry Pi Pico / RP2040
+M: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/*/rp2040*
+F: include/hw/*/rp2040*
+
 Real View
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 46e3c03cc8..de7a0f56fa 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -101,6 +101,9 @@ config FSL_IMX8MP_ANALOG
 config FSL_IMX8MP_CCM
     bool
 
+config RP2040_NYI
+    bool
+
 config STM32_RCC
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 54e07aacda..8611d59437 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -98,6 +98,7 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
   'bcm2835_cprman.c',
   'bcm2835_powermgt.c',
 ))
+system_ss.add(when: 'CONFIG_RP2040_NYI', if_true: files('rp2040_nyi.c'))
 system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
 system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
 system_ss.add(when: 'CONFIG_XLNX_ZYNQ_DDRC', if_true: files('xlnx-zynq-ddrc.c'))
diff --git a/hw/misc/rp2040_nyi.c b/hw/misc/rp2040_nyi.c
new file mode 100644
index 0000000000..7e9e4c09a1
--- /dev/null
+++ b/hw/misc/rp2040_nyi.c
@@ -0,0 +1,47 @@
+/*
+ * RP2040 "not yet implemented" diagnostics
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "qemu/log.h"
+
+void rp2040_log_nyi(const char *component, const char *feature,
+                    const char *detail)
+{
+    if (g_str_has_prefix(component, "rp2040.")) {
+        component += strlen("rp2040.");
+    }
+
+    qemu_log_mask(LOG_UNIMP, "Not yet implemented: rp2040.%s: %s%s%s\n",
+                  component, feature, detail ? ": " : "",
+                  detail ? detail : "");
+}
+
+void rp2040_log_unimplemented_read(const char *component, unsigned size,
+                                   uint64_t addr, uint64_t offset,
+                                   uint64_t value)
+{
+    char detail[128];
+
+    snprintf(detail, sizeof(detail),
+             "size %u, addr 0x%08" PRIx64 ", offset 0x%04" PRIx64
+             " -> 0x%0*" PRIx64,
+             size, addr, offset, size << 1, value);
+    rp2040_log_nyi(component, "unimplemented read", detail);
+}
+
+void rp2040_log_unimplemented_write(const char *component, unsigned size,
+                                    uint64_t addr, uint64_t offset,
+                                    uint64_t value)
+{
+    char detail[128];
+
+    snprintf(detail, sizeof(detail),
+             "size %u, addr 0x%08" PRIx64 ", offset 0x%04" PRIx64
+             ", value 0x%0*" PRIx64,
+             size, addr, offset, size << 1, value);
+    rp2040_log_nyi(component, "unimplemented write", detail);
+}
diff --git a/include/hw/misc/rp2040_nyi.h b/include/hw/misc/rp2040_nyi.h
new file mode 100644
index 0000000000..c23805973b
--- /dev/null
+++ b/include/hw/misc/rp2040_nyi.h
@@ -0,0 +1,19 @@
+/*
+ * RP2040 "not yet implemented" diagnostics
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_NYI_H
+#define HW_MISC_RP2040_NYI_H
+
+void rp2040_log_nyi(const char *component, const char *feature,
+                    const char *detail);
+void rp2040_log_unimplemented_read(const char *component, unsigned size,
+                                   uint64_t addr, uint64_t offset,
+                                   uint64_t value);
+void rp2040_log_unimplemented_write(const char *component, unsigned size,
+                                    uint64_t addr, uint64_t offset,
+                                    uint64_t value);
+
+#endif
-- 
2.55.0


