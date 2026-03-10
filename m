Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AC4FD88D3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 00:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w07CR-0008RG-I7; Tue, 10 Mar 2026 20:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jorge.merlino@canonical.com>)
 id 1w06C4-0007uk-Nh
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:08:52 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jorge.merlino@canonical.com>)
 id 1w06C2-0001pJ-HG
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:08:52 -0400
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EBB7F40010
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 23:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1773184127;
 bh=Qy1Q1GVHYiipkytfhmoOJvOigEaHFHXkCgngTGuaYk8=;
 h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc;
 b=sBfjdZ4TW3UAgbDdtUk7calHvNdPwNbEjqC4i2hsqOo2tb8x7Tujl/N57mIHBwQO7
 T23xf8y0CqwOaEmJpy8yKAJJkOlNqpW6hHTQRtTscnJ+Nert+gI6BXJuE6Aa52JBZH
 429kXWmhKrE6ljOBhOQwSssh82pqJ7rvyelLJRqJxYi6VKg5M6/s9WZ+0Jvd+cOmaU
 sDf+l7qXZCTR0BcRo9bCvN0ocDH+Xu3V+NrNyTyaiPI1RrtLTcPvbcAmjQDJo4Yu2E
 kIf3sKLuKg7IwxyV2Awz7VzxmB8x/fp695K6uiecivJTSthq5Jk1xcmjlXsNco5M4j
 ou9vivFALNbaiTb8gli0mBkqIM78wX1xQyLw5YUfAiagEYDKP+RzA01c0Cr3/vTXwx
 QUh5IxHobaRIJmkUQNCuh8hcoBeyBAuJgKRcldB4Hsi5ZXOZ69c0qL9seGCOWDm0Ft
 5UZi6P3W+B8tyX/NECIXkc2mD6EL4ITtu0/kT6WpuG/38lWnrkYDV+BqMgVzr0h0bJ
 DcjrF81XXeG5BeYJMoPrkyEPnz99QPdJRYsdyioitKNCTS83hPs9TYf4YrBAo2NHw2
 ioivF3jzj2wwH2qoLpuyCwG/M9WSHRgXtB8ONzPs+1fMAHYnla5GCMQHrNw8QHn8u+
 jcHs82Wkkub3JwAfM+XWPvUw=
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-127337c8e52so45710887c88.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 16:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773184126; x=1773788926;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qy1Q1GVHYiipkytfhmoOJvOigEaHFHXkCgngTGuaYk8=;
 b=t5OlVkU3e+ZANusJ12TsGxVcnWCXiX6lSSF1PP5VB5+JdAFH7DZFbbSKEFDFlHMajQ
 spLsPpzTj+TzL8gEMYMmlxySWzDT5AWJ5aLcRy6ymE5xV3ho3oBCp5Cu2GcSt8X0Tjxh
 k4jtrxoWgeFtgOTqHcklmNJY3sjz03FyIXAYjoIk6D6bfDVC5r3o/DNBbegD4e/Uk7Tx
 lZHkX1Vz/Oket+dz/Y190RRxy+KGur3mOBT41JNhMRrMZmIjV/qLYQwa5HmHtVaG4bJm
 Hb5nmFcbv54C2aeOi89iMmtNbUvE6kss2EUrLqQfLu6Yfg0mOHR0pSBqCyBnDGbbU30R
 FlTQ==
X-Gm-Message-State: AOJu0YzSzKdwS/pV/fqXXhr7+pWAijDKjr0jQIYzmCsoNI8FDH2JpdXY
 cnBCkDxI0URMhlRMHzdBi2S2owWaiJiM0/dUYTcID4Gi7QwAAnvyB3ZdMnbm401l1GGPQ5S1fqy
 BEt+T547/Rtcx6fvhj+7Wn2zbKaO3YnWvYFP7ImPY0Tmh3MHdYxxlh23iK1TR9oIjvrQbTkzv
X-Gm-Gg: ATEYQzx1icc22GndZP0G56rRYy6t6b//6ZmZ+8SymVaclI8GBvcOjCuPQ80C+fAK3/m
 XIKFPwygc9/YkqV3Ke5aMnjHVSChcGZFiHrKfBdmhlg2HG5PDWDK9AGH87fgkTz6CGT7503gBUO
 hqQh5RZx2w2unYGDPJGMtovg/4NQP1e49iNDohwH9JKcxMOXnPLieNXj+uDRWezlZFoDIO/35NQ
 gR3LF6oQomqI8qX9WxRK4F01al0vgVTZhuV4cjUa/h6f+Ic6NbpUxNQ1MVYSH8XI84o9mdn57Rl
 E2QxGFZys4NXc4un+9vM9LXrszEaBd+c3s5bKAjTGa6BkvRejcHDMaOP5UcsEUKF5SAAq39hMPr
 NznLoyRQq1CUtWno8EFbv
X-Received: by 2002:a05:693c:2c92:b0:2b0:4c56:be16 with SMTP id
 5a478bee46e88-2be8a580c0fmr172312eec.29.1773184126443; 
 Tue, 10 Mar 2026 16:08:46 -0700 (PDT)
X-Received: by 2002:a05:693c:2c92:b0:2b0:4c56:be16 with SMTP id
 5a478bee46e88-2be8a580c0fmr172294eec.29.1773184125937; 
 Tue, 10 Mar 2026 16:08:45 -0700 (PDT)
Received: from [127.0.1.1] ([2001:67c:1562:8007::aac:4084])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be8aa7413esm303434eec.24.2026.03.10.16.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 16:08:45 -0700 (PDT)
From: Jorge Merlino <jorge.merlino@canonical.com>
Date: Tue, 10 Mar 2026 20:08:36 -0300
Subject: [PATCH] throttle-group: fix race condition when using iothreads
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-fix-race-condition-b4-v1-1-09b9b9262a58@canonical.com>
X-B4-Tracking: v=1; b=H4sIAHOksGkC/x2MQQqAMAzAviI9W9hUhvoV8eC6qr1M2USE4d8tH
 gNJCmROwhnGqkDiW7IcUcHWFdC+xI1RgjI0pnGmtQZXeTAtxEhHDHKpjr5Dsj7Y3lE3OAZtz8Q
 q/t9pft8PR04lhGcAAAA=
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Jorge Merlino <jorge.merlino@canonical.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3423;
 i=jorge.merlino@canonical.com; h=from:subject:message-id;
 bh=MDMCX6w3IEXt7W+Bghjb9eOygo+xIKDwM5YgSr0Q6ls=;
 b=owEBbAKT/ZANAwAKAbCmxgD4DSg7AcsmYgBpsKR4wqcUmDPEDe4+Sj+rUxlQKsKP1AyE4fze6
 J7lw387qpKJAjIEAAEKAB0WIQSX6BDfnZ5646Dykg6wpsYA+A0oOwUCabCkeAAKCRCwpsYA+A0o
 O6/AD/iro7v9KXOXOydHjh+UsLIppaMsCmOM4VoPJpBqXbApeLp8epAKEL2hIeRz3XkezjWcA4d
 6isR/0P6I3UmQysV63ez1UydQF8EyycwQ+44J3CrSIMAoAhd4fTnUQdnIx16TIxfqL8Mhs0vn6j
 8/1yQjQuWm0juiI2Hi5DqXfNGZy416YTdYcwkbCcSCovBNXRVqyo5mjswv7INcdP6eNEzOG9TaG
 OHBhA7kjIST+okZzkXGD5bE2p9YMyOTPHYmhDhwBndME9ieH3hUzuzsMtvUBfJMkGXpAvjWxPe9
 S/RQX3c5Guqd02UnfUvZxmHdifqvYS6LwC/KTgVuTp1XqvX0RA5Wmw7j3Nw2eyk5cF4FROXD7di
 8dEaSNAGCaYmXr48/L1VX9wyYmA2r8S6izdQ0hUlIH2GuJ99pKIhCX7XuTv0ozZEBdcONzo6ZT2
 hWxjvksTB/+GNFRjz9vYbTsVas7j8wWz1AWYPiboBrphyCcVyrex0nNY5JsaEon+A6+ghBK5mDz
 hkXCFj9iU/GB7js0yRo6WbTUzMlG5hbKvdr5HOfhcpiqDGXylayAEdZzt4ctQu6A5NnfVSr5n24
 jMsgjutpahZGOTaUm0/gy+j8pVKwWPUmNv2bBI2xvyknHqd5rBcX/kwDQmnbsuZz+Zp8OTPg1Tg
 RUxsUvzh7yscr
X-Developer-Key: i=jorge.merlino@canonical.com; a=openpgp;
 fpr=EAEE4B9833141159D1CD846907F02065E74A8FC3
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=jorge.merlino@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 10 Mar 2026 20:13:17 -0400
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

There is a race condition on the value of throttle_timers on the
ThrottleGroupMember structure. Those timers should be protected by the
ThrottleGroup lock but sometimes are read without the lock and the code
expects their value to remain constant.

In particular, there is an assertion that can be false as the timers can
change between their value is checked and the assertion is run.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3194

Signed-off-by: Jorge Merlino <jorge.merlino@canonical.com>
---
This patch fixes a race condition on an assertion on the value of the
ThrottleGroupMember throttle_timers.

The patch is minimal as it changes only a few lines. It will probably
have to be refactored, maybe removing part of the code of the
throttle_group_restart_queue procedure and duplicating it before the
call. As it is now, this procedure needs to be called with the
ThrottleGroup lock held as it will unlock it during its execution.

I left it as is now so that the changes are clear for review. As I'm
messing with locks and I'm not an expert on this codebase I'm not sure if
there could be side effects I'm not aware of. 
---
 block/throttle-groups.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 5329ff1fdb..54daf7841d 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -423,6 +423,8 @@ static void throttle_group_restart_queue(ThrottleGroupMember *tgm,
 {
     Coroutine *co;
     RestartData *rd = g_new0(RestartData, 1);
+    ThrottleState *ts = tgm->throttle_state;
+    ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
 
     rd->tgm = tgm;
     rd->direction = direction;
@@ -433,6 +435,7 @@ static void throttle_group_restart_queue(ThrottleGroupMember *tgm,
     assert(!timer_pending(tgm->throttle_timers.timers[direction]));
 
     qatomic_inc(&tgm->restart_pending);
+    qemu_mutex_unlock(&tg->lock);
 
     co = qemu_coroutine_create(throttle_group_restart_queue_entry, rd);
     aio_co_enter(tgm->aio_context, co);
@@ -441,11 +444,15 @@ static void throttle_group_restart_queue(ThrottleGroupMember *tgm,
 void throttle_group_restart_tgm(ThrottleGroupMember *tgm)
 {
     ThrottleDirection dir;
+    ThrottleState *ts = tgm->throttle_state;
+    ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
 
     if (tgm->throttle_state) {
         for (dir = THROTTLE_READ; dir < THROTTLE_MAX; dir++) {
             QEMUTimer *t = tgm->throttle_timers.timers[dir];
+            qemu_mutex_lock(&tg->lock);
             if (timer_pending(t)) {
+                qemu_mutex_unlock(&tg->lock);
                 /* If there's a pending timer on this tgm, fire it now */
                 timer_del(t);
                 timer_cb(tgm, dir);
@@ -505,7 +512,6 @@ static void timer_cb(ThrottleGroupMember *tgm, ThrottleDirection direction)
     /* The timer has just been fired, so we can update the flag */
     qemu_mutex_lock(&tg->lock);
     tg->any_timer_armed[direction] = false;
-    qemu_mutex_unlock(&tg->lock);
 
     /* Run the request that was waiting for this timer */
     throttle_group_restart_queue(tgm, direction);

---
base-commit: ae56950eac7b61b1abf42003329ee0f3ce111711
change-id: 20260310-fix-race-condition-b4-c1bd186c496e

Best regards,
-- 
Jorge Merlino <jorge.merlino@canonical.com>


