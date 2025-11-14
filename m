Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAFACE8D40
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 15:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJviJ-0003fF-6Z; Fri, 14 Nov 2025 10:27:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJvc3-0006PS-Ue
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 10:21:24 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJvc2-0003vF-9r
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 10:21:23 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso18572165e9.0
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 07:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763133681; x=1763738481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kWsT9+pVP2bv7OoEAdZB0poxApdpHKvTDPxdXxBHL8M=;
 b=XrluESV+asICLy9+xCzDjQ+ux/Re7ZmYcc4xQkjvf4PNC9eXHAal/O9MABNTPl7Zlr
 9qK9/VgpRWTx0GI5nSfrr2GRMtTQbT2sKVfhtmDDohz5vilNG1gj7VAefqAfB1m/caPV
 F6Gt6CHDL4SWZ69oYqit6s1N7nswFgcVry1uGKAuGfUg6anmGbfIqYB7A6at+c8rQzyk
 NfrBqUwfm3WZs+NMmg32rldJca2GN249E5UckmNRBdzPEFFyhgWxDGvQ/EjCPFFdhy4M
 J4OH2EGNnjtJuTXXwJ/zE1cKzdrt9C6CJ3qwbYg99YPZaetz8aP3GeJN2owskAGswkDt
 NkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763133681; x=1763738481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kWsT9+pVP2bv7OoEAdZB0poxApdpHKvTDPxdXxBHL8M=;
 b=D+xsj437GhsFgRi8rxo1OQj8O8QPc+mKTwcbdQwRu+BU3AwiVsFAoSFhANN8/imhKA
 /aFw/ND/oEgfqTqSxglXl8EIHurUxRSb0/WmHdXH9ca6dEf9dC3J66N7VNn8dQ1eHWBj
 Lt744sxmSz8YYuW7+cIeLwqufZX+9XBlkHECenc548ROdiTwQKBnKo+3ZLZQQn2AMPZ4
 jgcMI12JrWKi1237BfhkZa+k9V7GGLMOXOjJzcorqynBQWfexlBKt9ke0+yZRNp+wf/U
 ZGFqVtJU3el5ahliaWh3VJ0/4hHfvR50pePIZ1BonuF/7QkfemmX8tJNkP40qEIwNtfL
 1e+Q==
X-Gm-Message-State: AOJu0YyTD0yz7/IXEUwlz9vwPG5m5rys77zHVkjMk5EzIcQF2ErVSRXI
 JZbTVJ5C+LWcrMU3hDnnigG37vtMZ3poIaRsQCzIZo2tzj1Tu6NCxJMzgCepuPSuK6HS1WPT3uE
 0BpQr
X-Gm-Gg: ASbGncv4IwwK4fH/7S8uJp9v4ZeiLHzLwFvAG9oAWK6HvdcDqeIzTSCUixbwDbDjoFp
 J1orwAXpZIWdY7kcLDCiJAqrwlgVCntKt25CY9WYJAfgtMbQu4jXH+ZcD/qWjN9Pzx+z/fo11Dl
 ikR6++K1QRLoQbPMgp3KOBjcXBkTVKUxkulgqpOAcf8OnI/A3mXvsZvHOVuNCmVH396LMndehkl
 +K3WTG2VmgtHTpW/kYzYJHfwiyAu6z+wSmx0Q8kOq/y/l2ddbomsM8DmA3aaeYQM0bzOSldfbAY
 d+JBXuIfg0TzXxQFWgJefpGCfSy28MEWGpcyoh2udESVL34pCVwEkCVmIFqzdN4iZKQBOXCwg8v
 gK5pA5fH4QqdR4Vc/PKm9Yc+acNjv+Hgpv8XQo1cMgBTRb5RI1Q1F1uVb0fFRoMnsGvABMB707U
 aK2o6KVzXNr0PFYZbo
X-Google-Smtp-Source: AGHT+IEXjcz4rOHXge63edYxPva0/3U36XGyzkeEflVUW1U8R3cqWuvCW2YxlDFjRb7IpHFC+VL7pA==
X-Received: by 2002:a05:600c:1e29:b0:477:5639:ff66 with SMTP id
 5b1f17b1804b1-4778bd07ac2mr61434045e9.13.1763133680555; 
 Fri, 14 Nov 2025 07:21:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e8e798sm146772835e9.10.2025.11.14.07.21.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 07:21:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/10] tests: Clean up includes
Date: Fri, 14 Nov 2025 15:21:08 +0000
Message-ID: <20251114152110.2547285-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114152110.2547285-1-peter.maydell@linaro.org>
References: <20251114152110.2547285-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-id: 20251104160943.751997-10-peter.maydell@linaro.org
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


