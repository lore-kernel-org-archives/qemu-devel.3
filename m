Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C13C531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 23:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnlXE-0003j6-Cn; Sat, 25 Jul 2026 19:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnlX3-0003h2-01
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 19:11:49 -0400
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnlX0-0005j6-QL
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 19:11:48 -0400
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-5c2dbaf828eso576109e0c.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2026 16:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785021105; x=1785625905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rww7YfQ1WxkCJQmecJPYaSnIoUwIyure2gI4fgprYWc=;
 b=segqUeNxQXJYi0Yn7UEznANjGF31pdDQ0bwAQU99Cp3ZrSOdeVdE/hQ5OynesqJMLj
 znWw1EtlD51Wp4mVIO3ZTpm3OwsCw3VEqBgk8eMH6Y0Hq177ClStl/pU3jovgJOJIyTg
 lRGNtC2ceBJhvcXCDVHj0r9UT2tID6qErdnl9CyebvzxYzF74b+mlQExyuAtC0sGmeb/
 je9cyvKL3pXIqLsrcFy1KRkpvl/ZSbUihwtIphkAtSKrffkf6vYilPYxsjyFf1sjet6h
 1Ycc58wimnumqC970KjhG5I7U2j9wXDzzCR/KzBC4oKDC5hdbvIKQRrtiTexE5UViDRj
 3JLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785021105; x=1785625905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Rww7YfQ1WxkCJQmecJPYaSnIoUwIyure2gI4fgprYWc=;
 b=ICLAwvOkAOwdRRpGnMjnb1r69/8RpBdAOASSqyyB6E6FKl+4ngR2oioS7HSFVKHgpa
 LDK1BExhGJISB4lJycvPdGuowp5dKwYWDMs6ZFHHspUILV3qa562yCD6+c5RH04DrJkL
 /1LC6dIMWNp6sUvjbC0vLFt7YN/JBkOGJJAzEspeXewuduaCRktvmgni/GQW/KRGtyzC
 /HJ9H1GkJmn0pFaxEkLYZQhy00jm34y4EZl7t85xuTj6d63kxCpIjKK2FQXlnSDJS82c
 crbeKUb51uyhDH3HLxUsc39tGALDfnafWiY+7uhXRGM6MMlqZp/sp1EUwkN1LXXlQyc9
 nPFQ==
X-Gm-Message-State: AOJu0YzFHU0MGPDD9FAbxDspprhMC4arG0w3Tl8NFwCBORfDxLJp63Vf
 zblYxTOKU4AuwxA4wBDN4Wezhr0bZwA5CzCrg1X6VBQMdxu0ouPIkJuAAIDGAA==
X-Gm-Gg: AR+sD11ItI0VelG7E5Ks/gp2YOjfN1L1L3EYbfBubxg1Gf9eJxmJbThxtlQbZuIez5W
 DvZ0tEr+O0JZfEji05SjaZTj796a6J7PWatYpfzSPsDTWtQ4i4fwq1yuBNQNDJDByQcJc/He5sx
 gjPHzmFCXftF018ihQdA5gDd4bqUC4GxWQi4XWRCnLOe72q7Qq0Q9qieGA+gGHncIS+y25aTEKc
 RyJ0gNdI8ZNxMw6ch11//VX5TEAlKxX/F5Uu+H+raCXQLPCTzZ2ef97RZgjxPUp+0GS9YfsttPq
 gn1Xfmuw/wd89gTfL6vh3OUiM5elj3CD9qAkt2Rn6cLSydfyB2VQHUuygdcg3uFxBpjcY4egGmD
 Lf8NwmFIC0OgfNuJ2v9I1rYCfyphtkBIlgijz6Yy6AX4hxhTq0Ajf2PXgQ5vs/ZMz6umhEBBPlR
 rSBtm2M+ZBBfrQAZV9RNyqmHVdiWq3DBBf
X-Received: by 2002:a05:6122:65a4:b0:5bf:b500:c4f4 with SMTP id
 71dfb90a1353d-5c306bb3b3amr1528561e0c.2.1785021105607; 
 Sat, 25 Jul 2026 16:11:45 -0700 (PDT)
Received: from localhost.localdomain ([146.71.8.128])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c30549516csm2907015e0c.6.2026.07.25.16.11.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jul 2026 16:11:44 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jason Wang <jasowangio@gmail.com>, Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH 1/2] hw/misc/bcm2835_powermgt: implement a real watchdog timer
Date: Sat, 25 Jul 2026 19:11:41 -0400
Message-ID: <20260725231142.61663-2-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260725231142.61663-1-marcelomanzo@gmail.com>
References: <20260725231142.61663-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=marcelomanzo@gmail.com; helo=mail-vk1-xa33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 hw/misc/bcm2835_powermgt.c         | 49 +++++++++++++++++++++++-------
 include/hw/misc/bcm2835_powermgt.h |  2 ++
 2 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/hw/misc/bcm2835_powermgt.c b/hw/misc/bcm2835_powermgt.c
index 3ec7abad0e..d90b9a0c3e 100644
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
@@ -113,6 +136,7 @@ static const VMStateDescription vmstate_bcm2835_powermgt = {
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
2.47.1


