Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93CC0C36002
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 22:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvkcT-0007M2-GF; Fri, 21 Mar 2025 18:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1tvkcQ-0007LY-UQ; Fri, 21 Mar 2025 18:13:35 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1tvkcN-0005Ca-PW; Fri, 21 Mar 2025 18:13:33 -0400
Received: from LT2ubnt.. (dynamic-046-114-107-181.46.114.pool.telefonica.de
 [46.114.107.181])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 7DD763F1A5; 
 Fri, 21 Mar 2025 22:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1742595207;
 bh=kx4VVxjwI+JrUSMAodWILioZHf+Ugp7uJC+tR1lSLWA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=GfeKaxe0YL0R9+FDiuJFmEzX9Orn36i0kiDAiXov3alBTmYHMGWbsvRzELXZZRJzI
 p1bILw0TTX3gttMfVXEtU82VaoEuArn/9GN1LQM0Ja2h19l18ENjkFDleI4j1PGPiI
 tKzfHg5fFT35oSLf+86GnLQNPV6Z9KXGHvmplHYl+c7bTkubGH0lomyY5EOVKevpAh
 mVBPTLsrCuQWrIbXaqBGsWqg+N0QacgEGGHZbCPwVP60q4OtMEyswKVfTRmlbfFFrG
 IkLwQW/MHFu2wpytVCorR0LQEAU/a6yskI2tomdzBaGwz08MuUgEnhh0WePmdEJ+nk
 HlzXGGwVsps5g==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Anup Patel <anup.patel@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Cc: Frederik Du Toit Lotter <fred.lotter@canonical.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] goldfish_rtc: keep time offset when resetting
Date: Fri, 21 Mar 2025 23:12:48 +0100
Message-ID: <20250321221248.17764-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.120;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-canonical-0.canonical.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Currently resetting the leads to resynchronizing the Goldfish RTC with the
system clock of the host. In real hardware an RTC reset would not change
the wall time. Other RTCs like pl031 do not show this behavior.

Move the synchronization of the RTC with the system clock to the instance
realization.

Cc: qemu-stable@nongnu.org
Reported-by: Frederik Du Toit Lotter <fred.lotter@canonical.com>
Fixes: 9a5b40b8427 ("hw: rtc: Add Goldfish RTC device")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
v2:
	Remove a superfluous intialization to nul.
	Add Cc:, Fixes:, and Reviewed-by: tags.
v1:
	https://lore.kernel.org/qemu-devel/CAAhSdy0-we9B19wRRqk_rRFkjY2LPPMRGaTdE=_4Ge_pCR4Y4Q@mail.gmail.com/T/
---
 hw/rtc/goldfish_rtc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
index 0f1b53e0e4..d83cc26481 100644
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
 
 static const Property goldfish_rtc_properties[] = {
-- 
2.48.1


