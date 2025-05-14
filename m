Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D28FC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFBhK-0003j1-Ea; Wed, 14 May 2025 08:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBgp-0002rR-UU; Wed, 14 May 2025 08:58:27 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBgn-0007qX-IW; Wed, 14 May 2025 08:58:27 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 08E4A121AE0;
 Wed, 14 May 2025 15:57:49 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id A852D20B84E;
 Wed, 14 May 2025 15:57:58 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Frederik Du Toit Lotter <fred.lotter@canonical.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.4 02/34] hw/rtc/goldfish: keep time offset when resetting
Date: Wed, 14 May 2025 15:57:24 +0300
Message-Id: <20250514125758.92030-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.4-20250514155748@cover.tls.msk.ru>
References: <qemu-stable-9.2.4-20250514155748@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Currently resetting the leads to resynchronizing the Goldfish RTC
with the system clock of the host. In real hardware an RTC reset
would not change the wall time. Other RTCs like pl031 do not show
this behavior.

Move the synchronization of the RTC with the system clock to the
instance realization.

Cc: qemu-stable@nongnu.org
Reported-by: Frederik Du Toit Lotter <fred.lotter@canonical.com>
Fixes: 9a5b40b8427 ("hw: rtc: Add Goldfish RTC device")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250321221248.17764-1-heinrich.schuchardt@canonical.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 2542d5cf471a38c4ceb9717708178938b96ded47)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
index 3dcf307e99..75d4cb0f31 100644
--- a/hw/rtc/goldfish_rtc.c
+++ b/hw/rtc/goldfish_rtc.c
@@ -239,15 +239,8 @@ static const VMStateDescription goldfish_rtc_vmstate = {
 static void goldfish_rtc_reset(DeviceState *dev)
 {
     GoldfishRTCState *s = GOLDFISH_RTC(dev);
-    struct tm tm;
 
     timer_del(s->timer);
-
-    qemu_get_timedate(&tm, 0);
-    s->tick_offset = mktimegm(&tm);
-    s->tick_offset *= NANOSECONDS_PER_SECOND;
-    s->tick_offset -= qemu_clock_get_ns(rtc_clock);
-    s->tick_offset_vmstate = 0;
     s->alarm_next = 0;
     s->alarm_running = 0;
     s->irq_pending = 0;
@@ -258,6 +251,7 @@ static void goldfish_rtc_realize(DeviceState *d, Error **errp)
 {
     SysBusDevice *dev = SYS_BUS_DEVICE(d);
     GoldfishRTCState *s = GOLDFISH_RTC(d);
+    struct tm tm;
 
     memory_region_init_io(&s->iomem, OBJECT(s),
                           &goldfish_rtc_ops[s->big_endian], s,
@@ -267,6 +261,11 @@ static void goldfish_rtc_realize(DeviceState *d, Error **errp)
     sysbus_init_irq(dev, &s->irq);
 
     s->timer = timer_new_ns(rtc_clock, goldfish_rtc_interrupt, s);
+
+    qemu_get_timedate(&tm, 0);
+    s->tick_offset = mktimegm(&tm);
+    s->tick_offset *= NANOSECONDS_PER_SECOND;
+    s->tick_offset -= qemu_clock_get_ns(rtc_clock);
 }
 
 static Property goldfish_rtc_properties[] = {
-- 
2.39.5


