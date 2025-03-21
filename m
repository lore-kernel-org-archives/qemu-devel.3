Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33DCC35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 08:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvXV9-0001h7-Kf; Fri, 21 Mar 2025 04:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1tvXV7-0001gn-JY; Fri, 21 Mar 2025 04:13:09 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1tvXV5-00062e-59; Fri, 21 Mar 2025 04:13:09 -0400
Received: from LT2ubnt.. (dynamic-046-114-107-082.46.114.pool.telefonica.de
 [46.114.107.82])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id A64583FF2F; 
 Fri, 21 Mar 2025 08:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1742544784;
 bh=XjFpM0OxTOvEIyCXkDknkwo4d3tPh6/VEwRR9RJGnN0=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Yy+nGWoU/77890/hJjHLroqvWfRwuoFymp4UEd/ll5sloWLvXtE66jludOVFcNRog
 +Qxs1ujpyN+MOzzpvtX3PwqL4KiZIxOQfTHI9gqntGLPyqerO/A6LzPnS0C577pIYX
 fb/z3dg36Z4dRXViWeAo6HpPImdJbBFbPTF4RgouzxY1GTQv2LCt20UVbBNgtUwBpV
 /S/HSwbzCc8obA8vVx+uQoHWuM8EKAFYCI+uzoDOjh+xs5WMgxgI9ybHYlL0M3QlfW
 pUbe5xdG03wLLE91NHL64fSPQX+y+z7/YH29x5fZTcKqDxUxyI48bxgakNR7f5yAWc
 mgpoNht4Hyuyw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Anup Patel <anup.patel@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Cc: Frederik Du Toit Lotter <fred.lotter@canonical.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] goldfish_rtc: keep time offset when resetting
Date: Fri, 21 Mar 2025 09:12:55 +0100
Message-ID: <20250321081255.30564-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.121;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-canonical-1.canonical.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Currently resetting leads to resynchronizing the Goldfish RTC with the
system clock of the host. In real hardware an RTC reset would not change
the wall time. Other RTCs like pl031 do not show this behavior.

Move the synchronization of the RTC with the system clock to the instance
realization.

Reported-by: Frederik Du Toit Lotter <fred.lotter@canonical.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 hw/rtc/goldfish_rtc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
index 0f1b53e0e4..203a343511 100644
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
@@ -267,6 +261,12 @@ static void goldfish_rtc_realize(DeviceState *d, Error **errp)
     sysbus_init_irq(dev, &s->irq);
 
     s->timer = timer_new_ns(rtc_clock, goldfish_rtc_interrupt, s);
+
+    qemu_get_timedate(&tm, 0);
+    s->tick_offset = mktimegm(&tm);
+    s->tick_offset *= NANOSECONDS_PER_SECOND;
+    s->tick_offset -= qemu_clock_get_ns(rtc_clock);
+    s->tick_offset_vmstate = 0;
 }
 
 static const Property goldfish_rtc_properties[] = {
-- 
2.48.1


