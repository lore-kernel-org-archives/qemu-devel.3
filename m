Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5A9CD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYV7r-0005Hk-MI; Sat, 13 Jun 2026 16:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV7U-0004YI-Db; Sat, 13 Jun 2026 16:38:22 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV7S-0003hd-LE; Sat, 13 Jun 2026 16:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781382963; bh=qo7CUVoBJT6J/Xn9BS8biH/2dl+pou5Ie/pG+aXu1z8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kZSjIoLn0rTyuRh/NM/Ugzrx3XEgoRMZyNEDVBk0C1naDoqJhn0ZJnWRbkm6PpGCR
 8QXhof8aVhn7I90xHy7hLMPmMSAQX16+Qt5SnReNBOV/ZNZM2f5pA2X8+ejUIl5wDo
 7hQqBVJh/iCKGlhsDXv36IUEwnIlz7QEriRt15y2UNCjox57dgaFNtImErCQR20GTQ
 KEn2qp4cmo+oOKPdk81H3Fm4E3wRY/Odd7+iH9NEd8Nho/MosccWK7K6eUjzCIH8ke
 Nu0govmikao6+b+4RhHKfNjM3TItcbyca9bxkXpufEPs+hYeAv8Kh9JnoecDM1C0gi
 A0QfUr7zF8Ewg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DE3DF1B6EF4;
 Sat, 13 Jun 2026 23:36:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 53E503CE945;
 Sat, 13 Jun 2026 23:36:22 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jinjie Ruan <ruanjinjie@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 25/72] mc146818rtc: Fix get_guest_rtc_ns() overflow bug
Date: Sat, 13 Jun 2026 23:34:51 +0300
Message-ID: <20260613203542.1809153-25-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
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
index ccbb279716..bcab018c7c 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -77,12 +77,13 @@ static inline bool rtc_running(MC146818RtcState *s)
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
@@ -258,7 +259,7 @@ static void check_update_timer(MC146818RtcState *s)
         return;
     }
 
-    guest_nsec = get_guest_rtc_ns(s) % NANOSECONDS_PER_SECOND;
+    guest_nsec = get_rtc_ns_since_last_update(s) % NANOSECONDS_PER_SECOND;
     next_update_time = qemu_clock_get_ns(rtc_clock)
         + NANOSECONDS_PER_SECOND - guest_nsec;
 
@@ -510,7 +511,7 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
                 /* if disabling set mode, update the time */
                 if ((s->cmos_data[RTC_REG_B] & REG_B_SET) &&
                     (s->cmos_data[RTC_REG_A] & 0x70) <= 0x20) {
-                    s->offset = get_guest_rtc_ns(s) % NANOSECONDS_PER_SECOND;
+                    s->offset = get_rtc_ns_since_last_update(s) % NANOSECONDS_PER_SECOND;
                     rtc_set_time(s);
                 }
             }
@@ -623,10 +624,8 @@ static void rtc_update_time(MC146818RtcState *s)
 {
     struct tm ret;
     time_t guest_sec;
-    int64_t guest_nsec;
 
-    guest_nsec = get_guest_rtc_ns(s);
-    guest_sec = guest_nsec / NANOSECONDS_PER_SECOND;
+    guest_sec = s->base_rtc + get_rtc_ns_since_last_update(s) / NANOSECONDS_PER_SECOND;
     gmtime_r(&guest_sec, &ret);
 
     /* Is SET flag of Register B disabled? */
@@ -637,7 +636,7 @@ static void rtc_update_time(MC146818RtcState *s)
 
 static int update_in_progress(MC146818RtcState *s)
 {
-    int64_t guest_nsec;
+    uint64_t guest_nsec;
 
     if (!rtc_running(s)) {
         return 0;
@@ -652,7 +651,7 @@ static int update_in_progress(MC146818RtcState *s)
         }
     }
 
-    guest_nsec = get_guest_rtc_ns(s);
+    guest_nsec = get_rtc_ns_since_last_update(s);
     /* UIP bit will be set at last 244us of every second. */
     if ((guest_nsec % NANOSECONDS_PER_SECOND) >=
         (NANOSECONDS_PER_SECOND - UIP_HOLD_LENGTH)) {
-- 
2.47.3


