Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2A0C88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6WdT-0005SW-VZ; Tue, 15 Sep 2026 13:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdL-0005QS-5S
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:52 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdJ-0003WC-BQ
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:50 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-4843e397f74so687735f8f.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 10:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789492068; x=1790096868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ePTbrn2QKUyDHGcC3OCZ2qXD2RHWJ0SPyZ9KMWVdQl8=;
 b=znFetpSd8YJuHfranjpR46kDIgIMWbHBqs60WBLID8rPSgShghpbsuBw97wKVKAUm0
 HwbXcHIuzOhQshdYB8i6PtUagjFt14diVU+2vQqvLA0XxXOwKYAV7Fx2wLw/f6J7mL15
 AZmlxOdzNN2B9fo7xTGSx4s1ND538/S1U2SR/cdmtLK0lyYBZ6ETr+qbf7Xx1uGNxWxt
 7ZuTyeXaQ5yKFW1Z73Y9SXkxMo/elqbaY4eiphuDX+ai10/+bDM3/T0aY0yQJrZIXya0
 VfPBFdQgIX4qlfJERuZ9p6XYjnlp9E5tNIXdHso1ewE9SVczVZdBH8d2thDEttSgmMry
 UVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789492068; x=1790096868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ePTbrn2QKUyDHGcC3OCZ2qXD2RHWJ0SPyZ9KMWVdQl8=;
 b=TrZ3/vzzHFTe0o5nHrpfWuGxB0Fso9gHQXuqAV904My4ePXj+rkZUshFSu/7AJCPPe
 L9LN772ClOgEfg4jmjNRIJ3stNJ5YrHeHjRBfvpHBSrMhrPpfY2yZSzvZyvkNUW/Yw6a
 M5Wws43B5avDC3FQhYiHCqvekDEhB8lvR8HRqZxOGz9bniMxDa3YRAzuNF2dPlFyha/P
 PFDLE+0Z3sQ23/OD7qChYk05BypwndXQwV75Ddo5TmoBztlZ8HHaV6Bt4G0gFT9pRjF0
 Z4/OSkr7cW2+RkjIW/z2MSRSyuL7u7t+lCzxRKc6yjsMo3qpwIq28l0e/Owggiy1dWyU
 q9/w==
X-Gm-Message-State: AFuF++nLK1m6DIDas27JUSrgFkRA6jwuc+EEE6xT/dikwtIZgBfNOgmS
 V/ipodMyhCn282USwBb/YYIo6cUBZRF1qj6/WYICF1LdReButXDgEi4XvYMDb5cY+xBaOlz2iRt
 QtRoE5is=
X-Gm-Gg: AYBFou1VTuawe3yWHKylI61t2hAWmpihhpbeYkPnjkSiRIJBhpzm66gXmVAde91+Dt5
 1YXsAewJThwj4h1/FDUs0ySeyXVvMQqOJ4koxb49HhueqoEwMJGIo7JJpVIxcLczAuZY9ozt8rc
 wnW9WSjByWrjSqkicNj8awAT5rfK0lhKwTjpCqG5PuVhe1wvR315hsKJjl3T1sENdnmt3T1lbDB
 9Li/na4Bifm+BnL+B9F3Ufs7l8nUjnQZiJzaA3qfncZiuWnqggAhlGmjQUlQUeoq8oIb5vCVPju
 RFbXVm2TNyax9aYBPnkr0zUXnv/N33AX0oPaRh0uEqeuRwgus86ZgordDnPZan7kljiHn7OdSFl
 JoU4mMjnEvxKdGHOVIvoniVBowGSLsTCHspHLZCT12tkRI8jS5nTcZVEzJp6ZW9SpniEtes4duJ
 yh1MBvkShWqF6t8ZvyWZdnygtdtVBPXMybq3DrCuCySEN/NNnLZv+nHlDpJF1uh7ON3Hk7cLRrC
 pNgjTe9aUFe4NzAVIAqRZdk3sRm5tn1xc/5mTEDWsoZYM77pC+nLw2ihrjVtGSp6xONQlcG2+OR
 LLRq
X-Received: by 2002:a05:6000:4718:b0:485:9309:6ec1 with SMTP id
 ffacd0b85a97d-48705b665c1mr7484552f8f.13.1789492067863; 
 Tue, 15 Sep 2026 10:07:47 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf33e01sm431826f8f.23.2026.09.15.10.07.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 10:07:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/20] sbsa-gwdt: don't arm timer for compare values above
 INT64_MAX
Date: Tue, 15 Sep 2026 18:07:24 +0100
Message-ID: <20260915170735.425445-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915170735.425445-1-peter.maydell@linaro.org>
References: <20260915170735.425445-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Igor Mammedov <imammedo@redhat.com>

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
Message-id: 20260902122646.2848464-6-imammedo@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/watchdog/sbsa_gwdt.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index 5b4f241fcb3..c5e88bf3d36 100644
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
@@ -135,7 +151,7 @@ static void sbsa_gwdt_wor_update_timer(SBSA_GWDTState *s, WdtRefreshType rtype)
     s->wcvu = timeout >> 32;
     s->wcvl = timeout;
 
-    timer_mod(s->timer, timeout);
+    sbsa_gwdt_set_timer(s, timeout);
 }
 
 static void sbsa_gwdt_rwrite(void *opaque, hwaddr offset, uint64_t data,
-- 
2.43.0


