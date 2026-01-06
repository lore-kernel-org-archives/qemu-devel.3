Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A181CD043E
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 06:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd0S7-00051G-9P; Tue, 06 Jan 2026 01:21:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1vd0Rj-0004yI-Eq
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 01:21:39 -0500
Received: from canpmsgout08.his.huawei.com ([113.46.200.223])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1vd0Rg-0001GK-BU
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 01:21:35 -0500
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=lDaSqBbrDfZw7jwb/pdxH2mcdpV5iUDeqTeAmdYbOTI=;
 b=mWn5YynYuZgn41C8c5b6BEdGgqdHbhjE61TpJpglBpI1lHEWxK6+fls1DO4fRebB9hhJTKamd
 dH38Qx94LLd2c0XU4c53olz4FsKt9fYqCJ1WsewKIJZjCFKy+3IZZWBGK/mGR1ryivIuV+FzxDU
 +5RY0Ii+m26w1MajpfoZtt8=
Received: from mail.maildlp.com (unknown [172.19.163.200])
 by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dlgvZ6sMNzmV6Y;
 Tue,  6 Jan 2026 14:18:02 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
 by mail.maildlp.com (Postfix) with ESMTPS id 52E8540591;
 Tue,  6 Jan 2026 14:21:18 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 6 Jan
 2026 14:21:17 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <mst@redhat.com>, <pbonzini@redhat.com>, <qemu-devel@nongnu.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] hw/rtc/mc146818rtc: Fix get_guest_rtc_ns() overflow bug
Date: Tue, 6 Jan 2026 14:21:45 +0800
Message-ID: <20260106062145.151760-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)
Received-SPF: pass client-ip=113.46.200.223;
 envelope-from=ruanjinjie@huawei.com; helo=canpmsgout08.his.huawei.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

In get_guest_rtc_ns(), "s->base_rtc" is uint64_t, which multiplied by
"NANOSECONDS_PER_SECOND" may overflow the uint64_t type.

Fix it by avoiding adding s->base_rtc in get_guest_rtc_ns_offset(),
because get_guest_rtc_ns() is used either take the remainder of
NANOSECONDS_PER_SECOND or take the quotient of NANOSECONDS_PER_SECOND.

Fixes: 56038ef6234e ("RTC: Update the RTC clock only when reading it")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/rtc/mc146818rtc.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index 8631386b9f..78bdfab8bd 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -79,10 +79,7 @@ static inline bool rtc_running(MC146818RtcState *s)
 
 static uint64_t get_guest_rtc_ns(MC146818RtcState *s)
 {
-    uint64_t guest_clock = qemu_clock_get_ns(rtc_clock);
-
-    return s->base_rtc * NANOSECONDS_PER_SECOND +
-        guest_clock - s->last_update + s->offset;
+    return qemu_clock_get_ns(rtc_clock) - s->last_update + s->offset;
 }
 
 static void rtc_coalesced_timer_update(MC146818RtcState *s)
@@ -623,10 +620,8 @@ static void rtc_update_time(MC146818RtcState *s)
 {
     struct tm ret;
     time_t guest_sec;
-    int64_t guest_nsec;
 
-    guest_nsec = get_guest_rtc_ns(s);
-    guest_sec = guest_nsec / NANOSECONDS_PER_SECOND;
+    guest_sec = s->base_rtc + get_guest_rtc_ns(s) / NANOSECONDS_PER_SECOND;
     gmtime_r(&guest_sec, &ret);
 
     /* Is SET flag of Register B disabled? */
@@ -637,7 +632,7 @@ static void rtc_update_time(MC146818RtcState *s)
 
 static int update_in_progress(MC146818RtcState *s)
 {
-    int64_t guest_nsec;
+    uint64_t guest_nsec;
 
     if (!rtc_running(s)) {
         return 0;
-- 
2.34.1


