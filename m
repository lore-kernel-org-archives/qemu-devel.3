Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2287BC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qfQ-0002sr-Ot; Tue, 30 Apr 2024 12:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qf4-0002Op-7q
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:58 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qex-0005cp-WE
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:57 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41a72f3a20dso42024095e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714495730; x=1715100530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xqt2LCRNbcncy6L7VTlxADhxm7D7waQ58ubzhGIRJc4=;
 b=G3kAiy+Hxo+PpUXbzhM5DTWnunMa899dEblrkQNywXoAoqicIor0J9movsHetHevR1
 pRSkgW96UgyeZzND986g3M7HDSFcPTeWEUXYVPIHnnHsgXaVDVqVtTkn3BxDqzY576OE
 S37dgjds7wqpA9+dDKk+CqxqQFnl0LyvDDOq+aYJ7fGXwoF3bCb4G3vdxUBpVgGxSzIJ
 rMt7NH1mUYLKJutsRifBWbf+VGQrAyT8PKO7qDjV2aaPiXffXV//iTLhsFPbzePkpols
 TRRFjOUlLTpHvrlqFfnfifpryj1fOrXvLqNEFPTq1Y6vQhonpTC4bo1SO7+YFQvnSsPf
 4KCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495730; x=1715100530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xqt2LCRNbcncy6L7VTlxADhxm7D7waQ58ubzhGIRJc4=;
 b=ggyVn80ybhpF2J0S8YtHqkmC9w1zL1PC4VBtgo1ebmwLWCUxxwjkj6wAo6hVIAE7/k
 V/zwKCfpPxd2T798byQJi+FPgerI2S5P9Um7rddkhReP4+jw3Lm1NG98lifwepmFh3E+
 qrxQWHbB76gVzQqDYgKSVM9+4ZH1z2YGhgkXq6bLNFuToN8t0Mw6mqrgQMWywrHslKrf
 2mcVyhkl008Ytc9AW2K2kEun+F+maSynkCaSCGOxsEih2hqDrdbai+Cjyy6w1sedffT+
 dJYFmhZN7nB1p5SD0jjhhSSKFfgLhgR7RUttk8gwuVJvlb4R27kvAEwb1wOvMQxV6npH
 QC0Q==
X-Gm-Message-State: AOJu0YxB008KReAx7nsE6JtcxLyBhlWyVknaNK7t9rIJdkuC710vf2jR
 O9ZN5rfbkAechhZKy3ZYC5UQ+peUz0bUGibmxFiLG0VPzyrt8Qf0Yi6M+nIALb3CanqDn+qige2
 0
X-Google-Smtp-Source: AGHT+IH6iH73ZM4ttT3jY1p38CSKYZ+ufZt0bRpbZlbajr82NrmXOusaod79BHWOr0qZLBxIWtAHMA==
X-Received: by 2002:a05:600c:a10:b0:418:e6fc:3708 with SMTP id
 z16-20020a05600c0a1000b00418e6fc3708mr68971wmp.24.1714495730119; 
 Tue, 30 Apr 2024 09:48:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a05600c4e0600b0041be3383a2fsm12920384wmq.19.2024.04.30.09.48.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:48:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/21] hw/watchdog/sbsa_gwdt: Make watchdog timer frequency a
 QOM property
Date: Tue, 30 Apr 2024 17:48:33 +0100
Message-Id: <20240430164842.4074734-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430164842.4074734-1-peter.maydell@linaro.org>
References: <20240430164842.4074734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Currently the sbsa_gdwt watchdog device hardcodes its frequency at
62.5MHz. In real hardware, this watchdog is supposed to be driven
from the system counter, which also drives the CPU generic timers.
Newer CPU types (in particular from Armv8.6) should have a CPU
generic timer frequency of 1GHz, so we can't leave the watchdog
on the old QEMU default of 62.5GHz.

Make the frequency a QOM property so it can be set by the board,
and have our only board that uses this device set that frequency
to the same value it sets the CPU frequency.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240426122913.3427983-4-peter.maydell@linaro.org
---
 include/hw/watchdog/sbsa_gwdt.h |  3 +--
 hw/arm/sbsa-ref.c               |  1 +
 hw/watchdog/sbsa_gwdt.c         | 15 ++++++++++++++-
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/hw/watchdog/sbsa_gwdt.h b/include/hw/watchdog/sbsa_gwdt.h
index 70b137de301..4bdc6c6fdb6 100644
--- a/include/hw/watchdog/sbsa_gwdt.h
+++ b/include/hw/watchdog/sbsa_gwdt.h
@@ -55,8 +55,6 @@
 #define SBSA_GWDT_RMMIO_SIZE 0x1000
 #define SBSA_GWDT_CMMIO_SIZE 0x1000
 
-#define SBSA_TIMER_FREQ      62500000 /* Hz */
-
 typedef struct SBSA_GWDTState {
     /* <private> */
     SysBusDevice parent_obj;
@@ -67,6 +65,7 @@ typedef struct SBSA_GWDTState {
     qemu_irq irq;
 
     QEMUTimer *timer;
+    uint64_t freq;
 
     uint32_t id;
     uint32_t wcs;
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 36f6f717b4b..57c337fd92a 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -543,6 +543,7 @@ static void create_wdt(const SBSAMachineState *sms)
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
     int irq = sbsa_ref_irqmap[SBSA_GWDT_WS0];
 
+    qdev_prop_set_uint64(dev, "clock-frequency", SBSA_GTIMER_HZ);
     sysbus_realize_and_unref(s, &error_fatal);
     sysbus_mmio_map(s, 0, rbase);
     sysbus_mmio_map(s, 1, cbase);
diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index 96895d76369..d437535cc66 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -18,6 +18,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/reset.h"
 #include "sysemu/watchdog.h"
+#include "hw/qdev-properties.h"
 #include "hw/watchdog/sbsa_gwdt.h"
 #include "qemu/timer.h"
 #include "migration/vmstate.h"
@@ -109,7 +110,7 @@ static void sbsa_gwdt_update_timer(SBSA_GWDTState *s, WdtRefreshType rtype)
         timeout = s->woru;
         timeout <<= 32;
         timeout |= s->worl;
-        timeout = muldiv64(timeout, NANOSECONDS_PER_SECOND, SBSA_TIMER_FREQ);
+        timeout = muldiv64(timeout, NANOSECONDS_PER_SECOND, s->freq);
         timeout += qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 
         if ((rtype == EXPLICIT_REFRESH) || ((rtype == TIMEOUT_REFRESH) &&
@@ -261,6 +262,17 @@ static void wdt_sbsa_gwdt_realize(DeviceState *dev, Error **errp)
                 dev);
 }
 
+static Property wdt_sbsa_gwdt_props[] = {
+    /*
+     * Timer frequency in Hz. This must match the frequency used by
+     * the CPU's generic timer. Default 62.5Hz matches QEMU's legacy
+     * CPU timer frequency default.
+     */
+    DEFINE_PROP_UINT64("clock-frequency", struct SBSA_GWDTState, freq,
+                       62500000),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void wdt_sbsa_gwdt_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -271,6 +283,7 @@ static void wdt_sbsa_gwdt_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_WATCHDOG, dc->categories);
     dc->vmsd = &vmstate_sbsa_gwdt;
     dc->desc = "SBSA-compliant generic watchdog device";
+    device_class_set_props(dc, wdt_sbsa_gwdt_props);
 }
 
 static const TypeInfo wdt_sbsa_gwdt_info = {
-- 
2.34.1


