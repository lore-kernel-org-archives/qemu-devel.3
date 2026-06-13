Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DCECD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 19:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUQC-0002Jp-P6; Sat, 13 Jun 2026 15:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUPZ-0001YF-HA; Sat, 13 Jun 2026 15:52:59 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUPX-0003pC-Lr; Sat, 13 Jun 2026 15:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781380259; bh=A7M3pKHlxT7cnq9vreXDZlVxJ1EGoHd1EvfuOA4VJR8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=pK50vCNO7h4N9ph0sfF49G4itqiyVFncSbkLrW8ZkaHgOS7McOuGGALhxsnq2ePxY
 35q0QZRQOH6rLIlrpGy5g0jGXr6U/yjwoDJabchsK7vx7iGAKwAEGkZgMVNWShXze1
 9WCU5XZq459mo1wl2lGOyQ8Nes+GquA9Y8JsUlbRrrV1TicDGj97zdCWmuX30tVCVx
 hFWwmuwr5pKniZ9hUhHimct66MRydFiy5wvLHco1hoLlGFvYuOiySBdxCKYVHGuihK
 AHWLGTWflFBm7X6ec9mYg7FTGRU3AOtMU8EoXu06Ogijg0z4F6zRlD0V++vqQPOXVu
 VQQ6Wrsw1B4hA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 419D51B6E24;
 Sat, 13 Jun 2026 22:50:59 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9A6C53CE89E;
 Sat, 13 Jun 2026 22:51:17 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jinjie Ruan <ruanjinjie@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.11 21/56] mc146818rtc: Fix get_guest_rtc_ns() overflow
 bug
Date: Sat, 13 Jun 2026 22:50:35 +0300
Message-ID: <20260613195116.1807273-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
References: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

In get_guest_rtc_ns(), "s->base_rtc" is uint64_t, which multiplied by
"NANOSECONDS_PER_SECOND" may overflow the uint64_t type, which will
cause the QEMU Linux Virtual Machine's RTC time to jump and in turn
triggers a kernel Soft Lockup and ultimately leads to a crash.

Fix it by avoiding adding s->base_rtc in get_guest_rtc_ns_offset(),
because get_guest_rtc_ns() is used either take the remainder of
NANOSECONDS_PER_SECOND or take the quotient of NANOSECONDS_PER_SECOND.

Fixes: 56038ef6234e ("RTC: Update the RTC clock only when reading it")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Link: https://lore.kernel.org/r/20260114013257.3500578-1-ruanjinjie@huawei.com
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 4b6c088c88ccc9e7cafc72759c99742b3993f9f7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index e322fc2ffb..0bb4a6ccca 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -83,12 +83,13 @@ static inline bool rtc_running(MC146818RtcState *s)
             (s->cmos_data[RTC_REG_A] & 0x70) <= 0x20);
 }
 
-static uint64_t get_guest_rtc_ns(MC146818RtcState *s)
+/*
+ * Note: get_rtc_ns_since_last_update() does not include the base_rtc seconds
+ * value.  This does not matter if the caller only needs the nanoseconds part.
+ */
+static uint64_t get_rtc_ns_since_last_update(MC146818RtcState *s)
 {
-    uint64_t guest_clock = qemu_clock_get_ns(rtc_clock);
-
-    return s->base_rtc * NANOSECONDS_PER_SECOND +
-        guest_clock - s->last_update + s->offset;
+    return qemu_clock_get_ns(rtc_clock) - s->last_update + s->offset;
 }
 
 static void rtc_coalesced_timer_update(MC146818RtcState *s)
@@ -264,7 +265,7 @@ static void check_update_timer(MC146818RtcState *s)
         return;
     }
 
-    guest_nsec = get_guest_rtc_ns(s) % NANOSECONDS_PER_SECOND;
+    guest_nsec = get_rtc_ns_since_last_update(s) % NANOSECONDS_PER_SECOND;
     next_update_time = qemu_clock_get_ns(rtc_clock)
         + NANOSECONDS_PER_SECOND - guest_nsec;
 
@@ -517,7 +518,7 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
                 /* if disabling set mode, update the time */
                 if ((s->cmos_data[RTC_REG_B] & REG_B_SET) &&
                     (s->cmos_data[RTC_REG_A] & 0x70) <= 0x20) {
-                    s->offset = get_guest_rtc_ns(s) % NANOSECONDS_PER_SECOND;
+                    s->offset = get_rtc_ns_since_last_update(s) % NANOSECONDS_PER_SECOND;
                     rtc_set_time(s);
                 }
             }
@@ -630,10 +631,8 @@ static void rtc_update_time(MC146818RtcState *s)
 {
     struct tm ret;
     time_t guest_sec;
-    int64_t guest_nsec;
 
-    guest_nsec = get_guest_rtc_ns(s);
-    guest_sec = guest_nsec / NANOSECONDS_PER_SECOND;
+    guest_sec = s->base_rtc + get_rtc_ns_since_last_update(s) / NANOSECONDS_PER_SECOND;
     gmtime_r(&guest_sec, &ret);
 
     /* Is SET flag of Register B disabled? */
@@ -644,7 +643,7 @@ static void rtc_update_time(MC146818RtcState *s)
 
 static int update_in_progress(MC146818RtcState *s)
 {
-    int64_t guest_nsec;
+    uint64_t guest_nsec;
 
     if (!rtc_running(s)) {
         return 0;
@@ -659,7 +658,7 @@ static int update_in_progress(MC146818RtcState *s)
         }
     }
 
-    guest_nsec = get_guest_rtc_ns(s);
+    guest_nsec = get_rtc_ns_since_last_update(s);
     /* UIP bit will be set at last 244us of every second. */
     if ((guest_nsec % NANOSECONDS_PER_SECOND) >=
         (NANOSECONDS_PER_SECOND - UIP_HOLD_LENGTH)) {
-- 
2.47.3


