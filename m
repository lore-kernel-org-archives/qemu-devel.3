Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8622DCCFA07
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 16:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGJc1-0006ry-Lq; Tue, 04 Nov 2025 11:10:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGJbg-0006iu-MV
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:10:05 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGJbb-0007LG-4t
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:10:04 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-477563bcaacso6249625e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 08:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762272596; x=1762877396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+hEVObdsJT1oTtwhAwuxIspzQ82F1zrFTt1fpB0p3nQ=;
 b=EkHaVtyAjtlYRa2AUDhya3t2u77u7T3jXnn8wvWmUL8ZWsnZD1d7YF/NVuqGEsblIT
 ff81Uv9R3n9KdE7gVdoy+bKBV6uzDLKIe4WFZS2BBuifOC3p0lnH41pDIBMpYrCP3Lck
 e3tTivmFFO1f+vqzRetBR5Su3ggIBADAWfChVq4JrqSdeO2bbI4a1GB4r3fs0K7UODEk
 KolcWe1Xby0tsBjg13RubbSK1VshIVe3aXSglXadTvUssSfFlCAmD9ZH12xekA/LfyU6
 Ns63x5Xq7JXzT00IQTTICXPVWoIZsvY29QUCGH7/E59D1T3kXSGWuOe/kNICwf3cf/lp
 8NLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762272596; x=1762877396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+hEVObdsJT1oTtwhAwuxIspzQ82F1zrFTt1fpB0p3nQ=;
 b=F+C/Qdifp681lMxJID2Pa2jk5ViO3Y1sy49oGQ9acUri1MK0Fg8ZzLnYYlf02CSUqr
 fYBnV4O49VtQoP6fMQcOu5qSK0bE/gUXPyk1KuDZTftaaO3vNeC4Nuj8fxub1fJJoEWA
 pAihrJ190ul28c9B0bQhAD2FCamrdBNE9j3NfHsEd+8Ovb60FcvU7zaz0uE/Bzg+Iuh9
 7Svd4i+2xKosN2qRCyfxSNBM9tavUEgCLvNPZjnltajqWVeWYJlZpu8MH9KowGN4NFtZ
 DotdqjQvjkSwb+L0ISqW99Zn8NR53UbjCEaHNKq4tOKs+IVV34xRX+Tahj6UGvTUP2sn
 Fo7w==
X-Gm-Message-State: AOJu0YxQ6Zi9jNzEG9+ZApvJsbCWHW79opvTs6mVFVwXsQeCsQbd8w7x
 2huW7zeO1Bf2tJaQQAG6Dmbj1JGeJK0SNqp8AtZhxzoc+XEN2X4swRs/R0b2+e3++94XuErhWTS
 W69PI
X-Gm-Gg: ASbGncvgo4wZ9jF6k1vJQtHrQzElW0IMo/hjPJz+cyrASl3PM+PMJP1otq2rKX/TrMm
 IKVkJZIhR4ZQc3UiZOGEBq/fVf3S5Zj9dX90/zNv/KZJFubqWqGPcKy8liTDr8fp6QsJQ5xFKAw
 VoEq2FEoChum3JcWDxrrm4gFizUgnGPFkdjaCKXyTpfUeqEQhr5NUhOAGOh4HMUy1aCPvYsLjgK
 iYZqyGQrPV4kXBf3exsYDPFv82wu2fbQVDdoDixDjPyfomUEtIRis/rOc+0Xc+rWAV0HTxYQp4Q
 OeGb/wDbTe5p6+7VwXVihowJ0y9ZaLlrW4WhiMtYsa5bv09X43KidbOmj6JygIe7AlM3dfbp6nB
 littiDbafhi+gimXV3iscXH3BuDB7wgDyM2NaGzMUov+RAz6ZyiPyjPlLrsnxNN+KTAF7zxGwxH
 0C6Rk22A==
X-Google-Smtp-Source: AGHT+IFxJu+Idtm7BINARUFeLVnlHBVVShbfNbirprbsfxOvJ1uS+jcBP6brRdHSACjkiLhNhouCMw==
X-Received: by 2002:a05:600c:1e25:b0:471:1306:aa0f with SMTP id
 5b1f17b1804b1-477308b60d9mr149403185e9.38.1762272595858; 
 Tue, 04 Nov 2025 08:09:55 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47754adcd08sm57314455e9.5.2025.11.04.08.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:09:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>
Subject: [PATCH 9/9] tests: Clean up includes
Date: Tue,  4 Nov 2025 16:09:43 +0000
Message-ID: <20251104160943.751997-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104160943.751997-1-peter.maydell@linaro.org>
References: <20251104160943.751997-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

This commit was created with scripts/clean-includes:
 ./scripts/clean-includes --git tests tests

with one hand-edit to remove a now-empty #ifndef WIN32...#endif
from tests/qtest/dbus-display-test.c .

All .c should include qemu/osdep.h first.  The script performs three
related cleanups:

* Ensure .c files include qemu/osdep.h first.
* Including it in a .h is redundant, since the .c  already includes
  it.  Drop such inclusions.
* Likewise, including headers qemu/osdep.h includes is redundant.
  Drop these, too.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/aspeed-hace-utils.h      | 1 -
 tests/qtest/aspeed-smc-utils.h       | 1 -
 tests/qtest/aspeed_gpio-test.c       | 1 -
 tests/qtest/dbus-display-test.c      | 3 ---
 tests/qtest/pnv-spi-seeprom-test.c   | 1 -
 tests/unit/test-cutils.c             | 2 +-
 tests/unit/test-error-report.c       | 1 -
 tests/unit/test-io-channel-command.c | 2 --
 8 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/tests/qtest/aspeed-hace-utils.h b/tests/qtest/aspeed-hace-utils.h
index c8b2ec45af2..27ab2bb9758 100644
--- a/tests/qtest/aspeed-hace-utils.h
+++ b/tests/qtest/aspeed-hace-utils.h
@@ -8,7 +8,6 @@
 #ifndef TESTS_ASPEED_HACE_UTILS_H
 #define TESTS_ASPEED_HACE_UTILS_H
 
-#include "qemu/osdep.h"
 #include "libqtest.h"
 #include "qemu/bitops.h"
 
diff --git a/tests/qtest/aspeed-smc-utils.h b/tests/qtest/aspeed-smc-utils.h
index b07870f3b8f..e2fd8ff1bd1 100644
--- a/tests/qtest/aspeed-smc-utils.h
+++ b/tests/qtest/aspeed-smc-utils.h
@@ -26,7 +26,6 @@
 #ifndef TESTS_ASPEED_SMC_UTILS_H
 #define TESTS_ASPEED_SMC_UTILS_H
 
-#include "qemu/osdep.h"
 #include "qemu/bswap.h"
 #include "libqtest-single.h"
 #include "qemu/bitops.h"
diff --git a/tests/qtest/aspeed_gpio-test.c b/tests/qtest/aspeed_gpio-test.c
index c2f9ca2298a..decbba23c8f 100644
--- a/tests/qtest/aspeed_gpio-test.c
+++ b/tests/qtest/aspeed_gpio-test.c
@@ -27,7 +27,6 @@
 #include "qemu/timer.h"
 #include "qobject/qdict.h"
 #include "libqtest-single.h"
-#include "qemu/typedefs.h"
 
 #define AST2600_GPIO_BASE 0x1E780000
 
diff --git a/tests/qtest/dbus-display-test.c b/tests/qtest/dbus-display-test.c
index f7fc873bfb3..1d5951b7117 100644
--- a/tests/qtest/dbus-display-test.c
+++ b/tests/qtest/dbus-display-test.c
@@ -7,9 +7,6 @@
 #include <gio/gio.h>
 #include <gio/gunixfdlist.h>
 #include "libqtest.h"
-#ifndef WIN32
-#include <sys/mman.h>
-#endif
 #include "ui/dbus-display1.h"
 
 static GDBusConnection*
diff --git a/tests/qtest/pnv-spi-seeprom-test.c b/tests/qtest/pnv-spi-seeprom-test.c
index 600493c425d..8033261758b 100644
--- a/tests/qtest/pnv-spi-seeprom-test.c
+++ b/tests/qtest/pnv-spi-seeprom-test.c
@@ -5,7 +5,6 @@
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
-#include <unistd.h>
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "qemu/bswap.h"
diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
index 227acc59955..75fae29003a 100644
--- a/tests/unit/test-cutils.c
+++ b/tests/unit/test-cutils.c
@@ -25,9 +25,9 @@
  * THE SOFTWARE.
  */
 
+#include "qemu/osdep.h"
 #include <math.h>
 
-#include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qemu/units.h"
 
diff --git a/tests/unit/test-error-report.c b/tests/unit/test-error-report.c
index 0cbde3c4cf5..a8532fc58fc 100644
--- a/tests/unit/test-error-report.c
+++ b/tests/unit/test-error-report.c
@@ -8,7 +8,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "glib-compat.h"
 #include <locale.h>
 
 #include "qemu/error-report.h"
diff --git a/tests/unit/test-io-channel-command.c b/tests/unit/test-io-channel-command.c
index 4f022617df0..964418b5cd9 100644
--- a/tests/unit/test-io-channel-command.c
+++ b/tests/unit/test-io-channel-command.c
@@ -20,8 +20,6 @@
 
 #include "qemu/osdep.h"
 #include <glib/gstdio.h>
-#include <sys/types.h>
-#include <sys/stat.h>
 #include "io/channel-command.h"
 #include "io-channel-helpers.h"
 #include "qapi/error.h"
-- 
2.43.0


