Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C88C624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1k4k-0006TP-SF; Wed, 02 Sep 2026 08:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1x1k4a-0006S4-09
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:28:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1x1k4Y-0004tY-83
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788352089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6FwNxnqOnBzLJoyDXwQFuQ68X47X5CSDm+eORTuw6vM=;
 b=QziZV6EYBOybcLTGN9rF7bMT9P3ZdsFbW28wWyESISq7IL9WvapwxsrphnaFG3sfF+Admw
 xGVMUgasizlepz3SVf86ydrt22OaSpsj+oGlir6TURvjBKV8YsUwrVqqyd2LSL/FYi2ywP
 VPy4in50q131YNc7iLcfMsB36RLOgJE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-0pNmsET_N7G70XL127YHUA-1; Wed,
 02 Sept 2026 08:27:01 -0400
X-MC-Unique: 0pNmsET_N7G70XL127YHUA-1
X-Mimecast-MFC-AGG-ID: 0pNmsET_N7G70XL127YHUA_1788352020
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D8DD1829E3E; Wed,  2 Sep 2026 12:26:59 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 15D343000223; Wed,  2 Sep 2026 12:26:57 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, leif.lindholm@oss.qualcomm.com, eauger@redhat.com
Subject: [PATCH 5/6] sbsa-gwdt: don't arm timer for compare values above
 INT64_MAX
Date: Wed,  2 Sep 2026 14:26:45 +0200
Message-ID: <20260902122646.2848464-6-imammedo@redhat.com>
In-Reply-To: <20260902122646.2848464-1-imammedo@redhat.com>
References: <20260902122646.2848464-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

QEMU timer subsystem uses int64_t, so a WCV value with bit 63 set
would overflow and cause the timer to fire immediately. The SBSA
spec defines WCV as an unsigned 64-bit compare value, so such
values are valid per spec and represent far-future deadlines
(however unpractical).

The current code is not affected: WCV writes don't reschedule the
timer yet, so a guest-supplied compare value never reaches the
timer API. The follow-up patch ("sbsa-gwdt: reschedule timer on
direct WCV load") changes that, at which point an out-of-range WCV
would overflow the timer. For example, Windows in GTDT mode writes
WCV in two 32-bit halves while the watchdog is running:

 sbsa-gwdt_control_write [0x8]  <- 0xffffffff    # WOR (~4 sec)
 sbsa-gwdt_control_write [0x0]  <- 0x1           # WCS enable
 sbsa-gwdt_control_write [0x14] <- 0xffffffff    # WCVU (intermediate)
 sbsa-gwdt_control_write [0x10] <- 0xa906ca28    # WCVL
 sbsa-gwdt_control_write [0x14] <- 0xecb1        # WCVU (final)

The intermediate WCVU write (0xffffffff) yields a WCV above
INT64_MAX; once WCV writes arm the timer, this overflows QEMU's
signed timer and fires immediately -- triggering WS0 => WS1 =>
reboot before the final WCVU write lands.

Add the guard first, before the WCV rescheduling patch, so the
tree stays bisectable. Instead of arming the timer with an
unsupported deadline, leave it disarmed. This reuses
hw/timer/sse-timer.c:sse_set_timer() (commit 0b8ceee822
"hw/timer/sse-timer: Model the SSE Subsystem System Timer").

Introduce a sbsa_gwdt_set_timer() helper for this and route the
WOR-based timeout through it.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/watchdog/sbsa_gwdt.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index 1211f1ca65..0a1d981072 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -99,6 +99,22 @@ static uint64_t sbsa_gwdt_read(void *opaque, hwaddr addr, unsigned int size)
     return ret;
 }
 
+static void sbsa_gwdt_set_timer(SBSA_GWDTState *s, uint64_t deadline)
+{
+    /*
+     * WCV is an unsigned 64-bit compare value, but QEMUTimer stores the
+     * expiry as a signed int64_t. A deadline with bit 63 set would be seen
+     * as already expired and fire the watchdog immediately. Such a deadline
+     * is unreachable within any guest runtime, so treat it as "never" and
+     * leave the timer disarmed instead.
+     */
+    if (deadline <= INT64_MAX) {
+        timer_mod(s->timer, deadline);
+    } else {
+        timer_del(s->timer);
+    }
+}
+
 static void sbsa_gwdt_wor_update_timer(SBSA_GWDTState *s, WdtRefreshType rtype)
 {
     uint64_t timeout = 0;
@@ -129,7 +145,7 @@ static void sbsa_gwdt_wor_update_timer(SBSA_GWDTState *s, WdtRefreshType rtype)
     s->wcvu = timeout >> 32;
     s->wcvl = timeout;
 
-    timer_mod(s->timer, timeout);
+    sbsa_gwdt_set_timer(s, timeout);
 }
 
 static void sbsa_gwdt_rwrite(void *opaque, hwaddr offset, uint64_t data,
-- 
2.52.0


