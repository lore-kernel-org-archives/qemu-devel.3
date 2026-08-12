Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6C0C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7ti-0006D5-VR; Wed, 12 Aug 2026 08:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7tN-0005Lp-HW
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:17:10 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7tL-0000Ag-0y
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:17:08 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso6132325e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786537024; x=1787141824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=M3OvWhPufdzBYG2iCN0wQNpXMz4uhFvJxdOFnxIDwfQ=;
 b=bXGvd6nL+/b4Ysqvf7S8QIeiY0Ph2myFVhzDibw48I9nRpli1LOOgA541UfZ6Ze7vQ
 /FDz5SwUnZ17MsOUCHup97U5HyBTsC2eH5paKxHGb+Ae7hkS0oRiPrfW3S1hPDzzaCtD
 8UOcRUvX0i5EudxhmSuaWdEL1iMpMMtaEMvNLYLflpmS1a1FVpOs+yMkz+AApkJnSRJp
 T1TjrZtWJtp/JaPIYrT+nw/xXj0RVTYbASFAojO/TY9OZ6vk3MGRr3HC8GD0VuiNzgCM
 O8Xwn+1C/tnh13tl5unn1KSxcOmOl9s+8eN+NKIF8wfTlf8hkWOP7k2NS6rT2SjvGwtf
 XTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537024; x=1787141824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=M3OvWhPufdzBYG2iCN0wQNpXMz4uhFvJxdOFnxIDwfQ=;
 b=Rnf/+eML9wyuAdlG79uvoaTfakRqvuhT6tIg5FWdWHuvUM+02NB61bm+oGQ6+4zi1q
 eLRCz0lIuU7Lw4NIvlemWMx7stFSJ+lhErmTKp79NHSLVXA+UWz6eOnbopBsG0bRoibb
 UA0/lmbPJQtq8/tLBeI16lgDYeiUak5roBMGqVrmxAp1MnVasMhUKILkEDvFyJfo6Mha
 n7loypWRkc54dErDohopRK2cYLnZy/FPBLl6AwgynuVRfy5CoQfTPC9oHZRf/9nDiY4l
 P/RE1HtP0tHFryIKUaiNe3RfQ9S0lwUVgrQqme3jq2DAbowptF5YlhpGFkmpQ4PXpCaA
 y16w==
X-Gm-Message-State: AOJu0YwFv17VJM8Uhu+Q+bxMWa9MYWMWT2U8rtuLz73ybUEjVQOKzIK/
 Qk7BszvxrZQlgedZio2cAqIoc0gTKqM8yhgQZpzsFqi0B2vctlmNWV/hcEMPzU9R3etuYJb46SK
 gkUP4
X-Gm-Gg: AR+sD13smi1HFKh1HjqQnTDOK4cApGNPTS20gzCb0cBfv3lzEpb6Mmq5bJ8aKrgbMCL
 4vLLPXRM02W9eP8FyrhVmiDMS/q6unIaVbdJ0wTVulcwp8T6vKAfPB5Plm5o/ZCxDWTsy1OTHMd
 p1HlBB+0l/Gq/rDGMIavOYCEEG/wEVxIHZKaJ4AlNCgeUBhgTVrYnAR8HSuGdJqv0rUcBCeAJld
 f/iE6fj/j1AcVNf4dDJkoqi7vW7hAeABMIPk0J1vTwGfIlqKSdNRtv4BaG+KDjd9FYoA9fl8Z4E
 0fUeSVqwDz5PU2VaQrh0wPIpgzIuuu8JruDURPObcyFIH+4lPM9x6h/0vkP4ZRvGqpJg3kHO6QT
 UuOPnQ1y2XSqTzCsVRgsILfvPmzwUxgR+BF6shxfAtlnU+rDKkU0ZTzr3lkLbO0btItMZ2PlKwH
 Aqbtwf5qTU/+6VMmpQyTry/7PMa2WclY4iJ/0WR6LVV8HPSCVXNBI/jvxkwT+OwaBfAEniJ/5YQ
 cpEQkeP0FLoXSBOBWBHSZE7VTkiU3/9yPqoTM3otF4yM5+tSBqx0y4G7Jpv9S1pdN7USA==
X-Received: by 2002:a05:600c:524c:b0:499:7410:545 with SMTP id
 5b1f17b1804b1-4997c145066mr54576295e9.12.1786537024031; 
 Wed, 12 Aug 2026 05:17:04 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad79e5csm36963805e9.3.2026.08.12.05.17.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:17:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/26] hw/misc/bcm2835_powermgt: implement a real watchdog timer
Date: Wed, 12 Aug 2026 13:16:20 +0100
Message-ID: <20260812121622.649730-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812121622.649730-1-peter.maydell@linaro.org>
References: <20260812121622.649730-1-peter.maydell@linaro.org>
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

From: Marcelo Manzo <marcelomanzo@gmail.com>

The RSTC register's write-config bits (0x30) being set to the
"full reset" value (0x20) does not mean "reset now" -- it arms the
hardware watchdog so that a reset happens if the WDOG countdown
register is not refreshed before it expires. The previous
implementation treated any such RSTC write as an immediate reset,
regardless of the WDOG value.

This is dormant on older/lighter userspace (nothing in Bullseye's
default boot touches these registers this way), but modern systemd
(observed with Debian 13/Trixie's systemd 257) writes to RSTC as part
of routine early-boot watchdog probing. With the old code, this fires
an immediate reset a few seconds into boot; combined with -no-reboot
this looks exactly like a QEMU crash (clean exit, no panic, no guest
reboot message) with the last log line being the RSTC/WDOG write.

Fix this by actually implementing the watchdog as a QEMUTimer: writes
to RSTC/WDOG (re)compute the timeout from the WDOG register (in units
of 1/65536 s, per the real hardware) and arm a timer for that many
nanoseconds out; only when the timer actually fires do we request a
system reset or shutdown, matching real hardware behavior. Clearing
the write-config bits or the WDOG value disarms the timer, and reset
disarms it too.

Verified against real Raspberry Pi OS images under the patched
raspi4b machine: Bullseye (5.15) and Bookworm (6.12) never exercised
this path either way; Trixie (6.18, systemd 257) no longer crashes at
boot and reaches a working login/SSH state.

This is a migration compatibility break for the raspi boards.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
[PMM: bump vmstate version IDs, note migration break in commit msg]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/bcm2835_powermgt.c         | 53 ++++++++++++++++++++++--------
 include/hw/misc/bcm2835_powermgt.h |  2 ++
 2 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/hw/misc/bcm2835_powermgt.c b/hw/misc/bcm2835_powermgt.c
index 3ec7abad0e..7b01be48bb 100644
--- a/hw/misc/bcm2835_powermgt.c
+++ b/hw/misc/bcm2835_powermgt.c
@@ -19,10 +19,40 @@
 #define PASSWORD_MASK 0xff000000
 
 #define R_RSTC 0x1c
-#define V_RSTC_RESET 0x20
+#define V_RSTC_WRCFG_MASK 0x30
+#define V_RSTC_FULL_RESET 0x20
 #define R_RSTS 0x20
 #define V_RSTS_POWEROFF 0x555 /* Linux uses partition 63 to indicate halt. */
 #define R_WDOG 0x24
+#define V_WDOG_TIME_MASK 0xfffff
+#define WDOG_TICKS_PER_SECOND 65536
+
+static void bcm2835_powermgt_expire(void *opaque)
+{
+    BCM2835PowerMgtState *s = opaque;
+
+    if ((s->rsts & 0xfff) == V_RSTS_POWEROFF) {
+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+    } else {
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+    }
+}
+
+static void bcm2835_powermgt_update_wdog(BCM2835PowerMgtState *s)
+{
+    uint64_t timeout_ns;
+
+    if ((s->rstc & V_RSTC_WRCFG_MASK) != V_RSTC_FULL_RESET ||
+        s->wdog == 0) {
+        timer_del(s->wdog_timer);
+        return;
+    }
+
+    timeout_ns = muldiv64(s->wdog, NANOSECONDS_PER_SECOND,
+                          WDOG_TICKS_PER_SECOND);
+    timer_mod(s->wdog_timer,
+              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + timeout_ns);
+}
 
 static uint64_t bcm2835_powermgt_read(void *opaque, hwaddr offset,
                                       unsigned size)
@@ -70,13 +100,7 @@ static void bcm2835_powermgt_write(void *opaque, hwaddr offset,
     switch (offset) {
     case R_RSTC:
         s->rstc = value;
-        if (value & V_RSTC_RESET) {
-            if ((s->rsts & 0xfff) == V_RSTS_POWEROFF) {
-                qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
-            } else {
-                qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-            }
-        }
+        bcm2835_powermgt_update_wdog(s);
         break;
     case R_RSTS:
         qemu_log_mask(LOG_UNIMP,
@@ -84,9 +108,8 @@ static void bcm2835_powermgt_write(void *opaque, hwaddr offset,
         s->rsts = value;
         break;
     case R_WDOG:
-        qemu_log_mask(LOG_UNIMP,
-                      "bcm2835_powermgt_write: WDOG\n");
-        s->wdog = value;
+        s->wdog = value & V_WDOG_TIME_MASK;
+        bcm2835_powermgt_update_wdog(s);
         break;
 
     default:
@@ -107,12 +130,13 @@ static const MemoryRegionOps bcm2835_powermgt_ops = {
 
 static const VMStateDescription vmstate_bcm2835_powermgt = {
     .name = TYPE_BCM2835_POWERMGT,
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(rstc, BCM2835PowerMgtState),
         VMSTATE_UINT32(rsts, BCM2835PowerMgtState),
         VMSTATE_UINT32(wdog, BCM2835PowerMgtState),
+        VMSTATE_TIMER_PTR(wdog_timer, BCM2835PowerMgtState),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -124,6 +148,8 @@ static void bcm2835_powermgt_init(Object *obj)
     memory_region_init_io(&s->iomem, obj, &bcm2835_powermgt_ops, s,
                           TYPE_BCM2835_POWERMGT, 0x200);
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
+    s->wdog_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                 bcm2835_powermgt_expire, s);
 }
 
 static void bcm2835_powermgt_reset(DeviceState *dev)
@@ -134,6 +160,7 @@ static void bcm2835_powermgt_reset(DeviceState *dev)
     s->rstc = 0x00000102;
     s->rsts = 0x00001000;
     s->wdog = 0x00000000;
+    timer_del(s->wdog_timer);
 }
 
 static void bcm2835_powermgt_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/misc/bcm2835_powermgt.h b/include/hw/misc/bcm2835_powermgt.h
index fb0740c01e..d1903a9cce 100644
--- a/include/hw/misc/bcm2835_powermgt.h
+++ b/include/hw/misc/bcm2835_powermgt.h
@@ -12,6 +12,7 @@
 #define BCM2835_POWERMGT_H
 
 #include "hw/core/sysbus.h"
+#include "qemu/timer.h"
 #include "qom/object.h"
 
 #define TYPE_BCM2835_POWERMGT "bcm2835-powermgt"
@@ -24,6 +25,7 @@ struct BCM2835PowerMgtState {
     uint32_t rstc;
     uint32_t rsts;
     uint32_t wdog;
+    QEMUTimer *wdog_timer;
 };
 
 #endif
-- 
2.43.0


