Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EF4606A332
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Nov 2026 10:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UZXaVHJY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUi2j-00021w-85; Sat, 21 Nov 2026 05:10:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xUi2b-00021g-Tt
 for qemu-devel@nongnu.org; Sat, 21 Nov 2026 05:09:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xUi2a-0003A3-1Y
 for qemu-devel@nongnu.org; Sat, 21 Nov 2026 05:09:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795255789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=52Vi78J3V6/UE3+7+rmdEpoZPnz1gutK162/VzAPm+A=;
 b=UZXaVHJYA+6qIaBiGv5+rwn/SsFnXLrmZA7zAA/Q+Q9eN12K0e9zQI5NB8IxyKlChq8zQh
 e91orkIOo326yh/C/iWTZp/kM9i84apmLuvDwJrNxJku5EHquCYQC9MUtRxB0Cn5jyo2KS
 F2guWv2CvDcpyuhWYSxCs5tvQFolbIo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-nHilgmb5MGWDq2Kia4Z47Q-1; Sat,
 21 Nov 2026 10:09:47 +0000
X-MC-Unique: nHilgmb5MGWDq2Kia4Z47Q-1
X-Mimecast-MFC-AGG-ID: nHilgmb5MGWDq2Kia4Z47Q_1795255786
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45C3E195609F; Sat, 21 Nov 2026 10:09:46 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F59B195608C; Sat, 21 Nov 2026 10:09:44 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tai Yunfang <yunfangtai@tencent.com>,
 Xiao Guangrong <xiaoguangrong@tencent.com>, Jason Thorpe <thorpej@me.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4] mc146818rtc: set PF even when PIE is clear
Date: Sat, 21 Nov 2026 11:09:42 +0100
Message-ID: <20261121100943.877139-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The MC146818A datasheet says PF is latched independently of PIE; PIE
only makes PF raise IRQF and the IRQ line. QEMU skipped the periodic
timer when PIE was clear, so PF never latched.

Compute the period from register A regardless of PIE, and latch PF
without raising an interrupt when PIE is clear. Stop the timer while
PF is set so idle guests are not woken every period, then re-arm
it when register C is read.

Lost tick compensation is limited to PIE=1 so that the RTC does
not count ticks with the periodic interrupt disabled as lost.

Cc: Tai Yunfang <yunfangtai@tencent.com>
Cc: Xiao Guangrong <xiaoguangrong@tencent.com>
Cc: Jason Thorpe <thorpej@me.com>
Fixes: 369b41359af ("mc146818rtc: precisely count the clock for periodic timer")
Co-authored-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/rtc/mc146818rtc.c   | 32 +++++++++++++++++++++---------
 tests/qtest/rtc-test.c | 45 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 66 insertions(+), 11 deletions(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index 887a8b07582..ae12e3f875e 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -132,13 +132,7 @@ static void rtc_coalesced_timer(void *opaque)
 
 static uint32_t rtc_periodic_clock_ticks(MC146818RtcState *s)
 {
-    int period_code;
-
-    if (!(s->cmos_data[RTC_REG_B] & REG_B_PIE)) {
-        return 0;
-     }
-
-    period_code = s->cmos_data[RTC_REG_A] & 0x0f;
+    int period_code = s->cmos_data[RTC_REG_A] & 0x0f;
 
     return periodic_period_to_clock(period_code);
 }
@@ -153,6 +147,18 @@ static void periodic_timer_update(MC146818RtcState *s, int64_t current_time,
     uint32_t period;
     int64_t cur_clock, next_irq_clock, lost_clock = 0;
 
+    /*
+     * When the periodic interrupt is disabled the periodic timer only
+     * serves to set the PF flag in register C. Once it has been set
+     * there is nothing to do until the flag is cleared by reading
+     * register C, so keep the timer stopped to avoid useless wakeups.
+     */
+    if (!(s->cmos_data[RTC_REG_B] & REG_B_PIE) &&
+        (s->cmos_data[RTC_REG_C] & REG_C_PF)) {
+        timer_del(s->periodic_timer);
+        return;
+    }
+
     period = rtc_periodic_clock_ticks(s);
     s->period = period;
 
@@ -194,7 +200,8 @@ static void periodic_timer_update(MC146818RtcState *s, int64_t current_time,
      *    to a shorter period, scale up the missing ticks since the
      *    OS handler will treat past delayed ticks as shorter.
      */
-    if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW) {
+    if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW &&
+        (s->cmos_data[RTC_REG_B] & REG_B_PIE)) {
         uint32_t old_irq_coalesced = s->irq_coalesced;
 
         lost_clock += old_irq_coalesced * old_period;
@@ -226,8 +233,8 @@ static void rtc_periodic_timer(void *opaque)
 {
     MC146818RtcState *s = opaque;
 
-    periodic_timer_update(s, s->next_periodic_time, s->period, false);
     s->cmos_data[RTC_REG_C] |= REG_C_PF;
+    periodic_timer_update(s, s->next_periodic_time, s->period, false);
     if (s->cmos_data[RTC_REG_B] & REG_B_PIE) {
         s->cmos_data[RTC_REG_C] |= REG_C_IRQF;
         if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW) {
@@ -699,10 +706,17 @@ static uint64_t cmos_ioport_read(void *opaque, hwaddr addr,
             ret = s->cmos_data[s->cmos_index];
             qemu_irq_lower(s->irq);
             s->cmos_data[RTC_REG_C] = 0x00;
+
+            /* Rearm the timers for bits that have been cleared.  */
             if (ret & (REG_C_UF | REG_C_AF)) {
                 check_update_timer(s);
             }
 
+            if ((ret & REG_C_PF) && !(s->cmos_data[RTC_REG_B] & REG_B_PIE)) {
+                periodic_timer_update(s, qemu_clock_get_ns(rtc_clock),
+                                      s->period, false);
+            }
+
             if(s->irq_coalesced &&
                     (s->cmos_data[RTC_REG_B] & REG_B_PIE) &&
                     s->irq_reinject_on_ack_count < RTC_REINJECT_ON_ACK_COUNT) {
diff --git a/tests/qtest/rtc-test.c b/tests/qtest/rtc-test.c
index 02ed4e12385..b320a91d950 100644
--- a/tests/qtest/rtc-test.c
+++ b/tests/qtest/rtc-test.c
@@ -643,6 +643,46 @@ static void uip_stuck(void)
 
 #define RTC_PERIOD_TEST_NR  50
 
+static uint64_t wait_periodic_timer(uint64_t real_time, int period_code)
+{
+    uint64_t periodic_time = real_time;
+    periodic_time += NANOSECONDS_PER_SECOND >> (16 - period_code);
+
+    cmos_write(RTC_REG_A, period_code);
+    while (!(cmos_read(RTC_REG_C) & REG_C_PF)) {
+        real_time = clock_step_next();
+        g_assert_cmpint(real_time, <, periodic_time + 100);
+    }
+
+    g_assert_cmpint(real_time, <, periodic_time + 100);
+    g_assert_cmpint(real_time, >, periodic_time - 100);
+    return real_time;
+}
+
+static void periodic_timer(void)
+{
+    int i;
+    uint64_t real_time;
+
+    /* disable all interrupts. */
+    cmos_write(RTC_REG_A, 0);
+    cmos_write(RTC_REG_B, cmos_read(RTC_REG_B) &
+                                   ~(REG_B_PIE | REG_B_AIE | REG_B_UIE));
+
+    /* wait for the first timer without assertions, to synchronize and clear PF */
+    cmos_read(RTC_REG_C);
+    cmos_write(RTC_REG_A, 10);
+    real_time = clock_step_next();
+    while (!(cmos_read(RTC_REG_C) & REG_C_PF)) {
+        real_time = clock_step_next();
+    }
+
+    for (i = 0; i < RTC_PERIOD_TEST_NR; i++) {
+        real_time = wait_periodic_timer(real_time, RTC_PERIOD_CODE1);
+        real_time = wait_periodic_timer(real_time, RTC_PERIOD_CODE2);
+    }
+}
+
 static uint64_t wait_periodic_interrupt(uint64_t real_time)
 {
     while (!get_irq(RTC_ISA_IRQ)) {
@@ -653,7 +693,7 @@ static uint64_t wait_periodic_interrupt(uint64_t real_time)
     return real_time;
 }
 
-static void periodic_timer(void)
+static void periodic_interrupt(void)
 {
     int i;
     uint64_t period_clocks, period_time, start_time, real_time;
@@ -708,7 +748,8 @@ int main(int argc, char **argv)
     qtest_add_func("/rtc/update/divider-reset", divider_reset);
     qtest_add_func("/rtc/update/uip-stuck", uip_stuck);
     qtest_add_func("/rtc/misc/fuzz-registers", fuzz_registers);
-    qtest_add_func("/rtc/periodic/interrupt", periodic_timer);
+    qtest_add_func("/rtc/periodic/timer", periodic_timer);
+    qtest_add_func("/rtc/periodic/interrupt", periodic_interrupt);
 
     ret = g_test_run();
 
-- 
2.56.0


