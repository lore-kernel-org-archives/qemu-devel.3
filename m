Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6794CD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRX2v-0006CJ-Sl; Mon, 25 May 2026 11:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRX2o-00061u-Hq
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:16:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRX2m-0007Up-ED
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779722199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pUP3DOSZXs62VtQk1fVchKzZIjmgpgHq+9XvtsuO+Dg=;
 b=GhA3uVZ0okLPJWfOxU4fyeHs1SgRxHpQnQ/u32rJC3ItvlhTLdwUOBGxHJWRdwMN+zKX4w
 ZxXT92efiRIOLXNIjKr3GQ+NTzaitCeiXWcsfIgmNqWL47cE3Q/OhTasKUX6wdFDX3LWzO
 iUIpyxAlbDbuiEDyBaEeXlwPy4I+sVo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-E0KFfki8NRehT9EJkc5Clg-1; Mon, 25 May 2026 11:16:37 -0400
X-MC-Unique: E0KFfki8NRehT9EJkc5Clg-1
X-Mimecast-MFC-AGG-ID: E0KFfki8NRehT9EJkc5Clg_1779722196
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49047e9ca88so24504515e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 08:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779722196; x=1780326996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pUP3DOSZXs62VtQk1fVchKzZIjmgpgHq+9XvtsuO+Dg=;
 b=U2o1wu5RJq2yWSA4lkz8tUSaFPgBokYyo+9QkNxqeeyBbBhYgqpwsnG88ZPlUBxDua
 uMTztMpQwxEiokFbAdTlJRPAC/FUBX+5jRC3lzFLsJpjvAselaqL1i8Fxr5xUDV7iovm
 5eFLR5azx5cDWVp7GYGSffmbweegW1oFQvcAhhBAXQFtetIzqBGIp0E4OjdqdVqTECFI
 HqbfgaFbY/njxFlpaH4RkrcuRNWtFcfHC/PtmgqbTQBIsvzFYvE4D7/hW7T4/Wkayvyp
 BP/msLda/5QO6050LSbXLiLUjqYyhMGcG3W958lC4ZT+Sg9rXex4hSsafVT78GH+JHaX
 fXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722196; x=1780326996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pUP3DOSZXs62VtQk1fVchKzZIjmgpgHq+9XvtsuO+Dg=;
 b=enhXUmRuZbVZQu1w2rgzEqvHPySkSo5dIm+axFzKbFmYIEzklf7OQgRtGrmRt0m5zT
 ub1my0S3n94J4FrOKEPgqFU+XvY/bI13/opljspHa/r4AnjUuXbR7/SANp8YgVuKsZw4
 Bn4chjErW90HfGnSG10WVScS4c+ckJ/deByJ275oyhHbWUNaSb4zx4OLU9K11PVniDGb
 AuaDNXNS8BceruTJx0BaWtzeARJAqlhAGHXT9SYOPuxWvzjqJ6IaWMe9Mk4wFlKJMhYf
 7Ltr8SevTKnfUbTK5SxNXPH40ufBWlEYw8RfYR3sNPN3T2BD3X7AwvISvWBNNsWSRBhI
 vGBA==
X-Gm-Message-State: AOJu0YwJEuSftYGJLDMTi9IHKDyz+ZdCx7tZwUUh1+ovI7s3FWzjI8Jd
 i0bOva/7Gr+r/y5cjRKoaRTonQcnXziQvUGU7myyCRN8L3DYyiFTDhLeqDbv5oMs0jnIevuoBnx
 UsXv3gEXDwqVAavPiRw4kS3bqJ/UyDZFOqdEcxyDM1zUfK/XRtFyCqPTYYrapdgz0tdmqoWxIsK
 g8fJ7LT93QCkjYVgZHrFZgqapCF55W4pCaoCL0x6Gr
X-Gm-Gg: Acq92OGC6r+mkG2vx/5fZ2SZLuQQWzOt/ZPu1SeyzRSd4vYwzEc7suHomWCDrTjrshf
 rsHwXFf9HifhoMeMGCJZrcZiNb63DbsY7rSL+OzizJPETgikJd4KQRr31lXJg2NeigIj3L+8l3v
 PSEdzNRR7O6pFZllLrIco847mb+y1KKqQIYc4mlhsDnT+jgWhQ6JU3mDcRjp1Uc6zlMUJMTj/i+
 iQ+vI4hiUzDOgPR5jSJZDUmy6lPybwjNQbedKvTthokm0HkRtZ1oMHUbKap/2aNKWL5qnaJh3Mj
 3/TeCzpSNspB5LeE+M6N7+sAZMZn5xCX2twVv6ddXu+ZBWDmE/2qvo0QqjNiIovOYBVN11WD4Ae
 Zgy3YhSL+1zGHk1oc1+h11jyPSkOhFHBSnlqnPezAEHEq02Ynf1acTfAYz0Nm5xq+1kaYgAmEPa
 Gct7Tj2MCUBd0h+Ro4gAeswifLamo4
X-Received: by 2002:a05:600c:a011:b0:490:50ff:7943 with SMTP id
 5b1f17b1804b1-49050ff7b15mr170411715e9.5.1779722196260; 
 Mon, 25 May 2026 08:16:36 -0700 (PDT)
X-Received: by 2002:a05:600c:a011:b0:490:50ff:7943 with SMTP id
 5b1f17b1804b1-49050ff7b15mr170411125e9.5.1779722195731; 
 Mon, 25 May 2026 08:16:35 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904561f2dfsm241323135e9.12.2026.05.25.08.16.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 08:16:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
	qemu-stable@nongnu.org
Subject: [PULL 5/6] mc146818rtc: Fix get_guest_rtc_ns() overflow bug
Date: Mon, 25 May 2026 17:16:20 +0200
Message-ID: <20260525151621.395954-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525151621.395954-1-pbonzini@redhat.com>
References: <20260525151621.395954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 hw/rtc/mc146818rtc.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index ccbb2797169..bcab018c7cd 100644
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
2.54.0


