Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46023CFC501
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 02:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0XEk-0007Vx-TY; Mon, 14 Oct 2024 22:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yshxxsjt715@163.com>)
 id 1t0XEh-0007Vk-N4
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 22:24:35 -0400
Received: from m16.mail.163.com ([220.197.31.4])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yshxxsjt715@163.com>) id 1t0XEf-0000bH-7R
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 22:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=lM0mq
 D37BD1KHWcxASFEHk9BlsaaSV3648O9jeiqdaI=; b=J1uaEK+jmewDFNEYG9IvL
 FQTGLTE7OEGfQq/7Ul2W079VtjjowxPPKAblr9yYIRHaFkDSKdruxdN6H5koPiCa
 1R72jbTUY9vNiIwl4XsTPoUdkVoLi0Ku/YaZz+6OvuI9I3xAQvaG6sa8HIidnfbN
 p2XC+L/pu4NZmr4BE9Gq7Q=
Received: from jshen28-imini-Pro.. (unknown [113.128.83.231])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wAntKZS0g1nFB1+BA--.51697S2; 
 Tue, 15 Oct 2024 10:24:18 +0800 (CST)
From: shenjiatong <yshxxsjt715@163.com>
To: qemu-devel@nongnu.org
Cc: shenjiatong <yshxxsjt715@163.com>
Subject: [PATCH] Fix negative lost clock causing VM crash
Date: Tue, 15 Oct 2024 10:24:09 +0800
Message-ID: <20241015022416.804072-1-yshxxsjt715@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAntKZS0g1nFB1+BA--.51697S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrW8ur13Jryfuw47Xw1DZFb_yoW8ZF4rp3
 92kr9agwn2vF48Wrn7KFnrGrn8G3Z5C347tryUAw4ak3Wjqr48KFsxJryUKayq9FyrC3yU
 Za4Yqan8JF1jvw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_JPi8UUUUU=
X-Originating-IP: [113.128.83.231]
X-CM-SenderInfo: h1vk555vmwliqv6rljoofrz/1tbiMRJ5L2cNzFjJjQAAsP
Received-SPF: pass client-ip=220.197.31.4; envelope-from=yshxxsjt715@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Under situation where virtual machine is running in a deployment where
the system time is unstable, there is a chance that legacy OpenStack
Windows machines without stimer enabled will crash if system time moves
backwards and diftfix=slew is enabled. This primarily caused by the fact
the system time moves faster than NTP server and after synchronization,
system time flows backwards.

Signed-off-by: shenjiatong <yshxxsjt715@163.com>
---
 hw/rtc/mc146818rtc.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index 8ccee9a385..fa5d7915b1 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -180,7 +180,6 @@ static void periodic_timer_update(MC146818RtcState *s, int64_t current_time,
                                 RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
         last_periodic_clock = next_periodic_clock - old_period;
         lost_clock = cur_clock - last_periodic_clock;
-        assert(lost_clock >= 0);
     }
 
     /*
@@ -199,10 +198,15 @@ static void periodic_timer_update(MC146818RtcState *s, int64_t current_time,
      */
     if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW) {
         uint32_t old_irq_coalesced = s->irq_coalesced;
+        if (lost_clock >= 0) {
+            lost_clock += old_irq_coalesced * old_period;
+            s->irq_coalesced = lost_clock / s->period;
+            lost_clock %= s->period;
+        } else {
+            s->irq_coalesced = 0;
+            lost_clock = 0;
+        }
 
-        lost_clock += old_irq_coalesced * old_period;
-        s->irq_coalesced = lost_clock / s->period;
-        lost_clock %= s->period;
         if (old_irq_coalesced != s->irq_coalesced ||
             old_period != s->period) {
             DPRINTF_C("cmos: coalesced irqs scaled from %d to %d, "
@@ -215,6 +219,7 @@ static void periodic_timer_update(MC146818RtcState *s, int64_t current_time,
          * no way to compensate the interrupt if LOST_TICK_POLICY_SLEW
          * is not used, we should make the time progress anyway.
          */
+        lost_clock = MAX(0, lost_clock);
         lost_clock = MIN(lost_clock, period);
     }
 
-- 
2.43.0


