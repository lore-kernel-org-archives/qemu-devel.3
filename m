Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B673E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 02:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSRe1-0006TH-DL; Mon, 30 Dec 2024 21:06:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fuqiang.wng@gmail.com>)
 id 1tSRUs-0004ou-Ce
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 20:56:38 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fuqiang.wng@gmail.com>)
 id 1tSRUp-0003sQ-J8
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 20:56:37 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ee9a780de4so9485600a91.3
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 17:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735610193; x=1736214993; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5bo9JB7Q6KwtbLxQUitkC9AEkI0Sqdz6MLreyLm6lHw=;
 b=ROZErrVhbKlwwr2mWUiINAyjOtVaMkpICJEHrmnuC3RltafZsJsx4J+LD4xLpPQM4q
 IznTlz9JXUEq2JgmBZ0ZncV0+3tJVaHkL/SyefGkQrwEB5j+UsRyq8BsoB80OiZCMUQZ
 IfWDeZJkFwetcoVNz/izUWgvlw+L7hjac2QZmGkxPf8iXfNsAuy6sXLudhn2ZdKLk53B
 7trYsjCo+a3BgYRBB3gwWMOMeYMxKJ85v+Cd3OXyFwlSnuBiTqwmxPMINFFtRQ5IlSl6
 apFMwcsldovShCbiXu5dv7DNNmRe9cSuLiAXjK91LfhgQzOgcqkf57JGGztLI94Vr9k2
 sA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735610193; x=1736214993;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5bo9JB7Q6KwtbLxQUitkC9AEkI0Sqdz6MLreyLm6lHw=;
 b=wyv9+wJKyCY+soAvgKLIp4RUz0eAb4udxSBfRN8hSC7I5fcPFnECg71+Y9XAevgMR4
 D1k5p1wfEs8USzFVLQRfgIQ8+kLhfOKhUHPxY4c+v7EA/i2EjNOsUcXpfkst65bH9Ajk
 KlV7UMO9exhkcthh+ViAgXAnvrlD1kIbIT5VajugY44b5gdYqtkpKqaJwjuxKK731FIa
 rQYbzD+KGExaIq/79rTOPv05nYehxTnNqjdjI1zLutMdyiP3r8ZV/BKbjBaaVzwb3aj2
 6+B8dz3P2y3/I9OgzZcN0WAdHOqIxS9LaKcIiIJYopaRU0tV4Wq62x4shkQfDYM+BT3W
 L+eg==
X-Gm-Message-State: AOJu0YztbTGBr4P0JVxmB4hOVxzt1FCij9M2UCu02nUREd0MIWyXsmpb
 Vo0/pMV5Mh0ptidaupJzSBXwbNE6i3QaHWR3hhFwvBS+DVyeRlXmA5rVu01BRZM=
X-Gm-Gg: ASbGncvFNbIfTjnoko8UFeGXoyeSd2VLssXMrLbaOMmtn1nyxew9tv9jWNvs89eEFxi
 BqAP/kT4HG0wWTiXc9tXDMkfLcDKWUIrLB8hGA//aytgsQXMpRsWXv4nysuya3qw/ohHwGLfYLm
 DG5EUMhbjV/vCs22+wiyacY1tblFLYrUmlYK0GnndyVRHrm4kxkN1G6D7m1U9NGszG9g92CRqJS
 z9G463kI3eZZOCqMfCOt4es6/DqJVGlU3fZ+scix6QjgjtJCTbpTbG/tQhZhkPGgcKBOcib+Vr6
 Yw==
X-Google-Smtp-Source: AGHT+IHrqha+5kQpb6K8gvb7xWnPe/lRVvMjU0ino+CdOiO/vCGpnIcrP2OhoYcSlEmJ9rWR+GX0RQ==
X-Received: by 2002:a17:90b:2c84:b0:2ee:bbe0:98c6 with SMTP id
 98e67ed59e1d1-2f452dfcb28mr61985399a91.8.1735610193679; 
 Mon, 30 Dec 2024 17:56:33 -0800 (PST)
Received: from wangfuqiang49-vm.localdomain ([114.67.220.238])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ed52dfffsm23445223a91.5.2024.12.30.17.56.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 30 Dec 2024 17:56:33 -0800 (PST)
From: fuqiang wang <fuqiang.wng@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hyman Huang <yong.huang@smartx.com>, huaminxu1@jd.com,
 fuqiang wang <fuqiang.wng@gmail.com>, wangfuqiang49 <wangfuqiang49@jd.com>
Subject: [PATCH 1/2] optimize the dirtylimit_throttle_pct trace event
Date: Tue, 31 Dec 2024 09:56:13 +0800
Message-Id: <1735610174-37467-2-git-send-email-fuqiang.wng@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1735610174-37467-1-git-send-email-fuqiang.wng@gmail.com>
References: <1735610174-37467-1-git-send-email-fuqiang.wng@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=fuqiang.wng@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 30 Dec 2024 21:06:00 -0500
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

The current dirtylimit_throttle_pct trace event is triggered when the
throttle time is adjusted linearly. Modify the trace event so that it
can record non-linear adjustments. Additionally, since the throttle time
might be adjusted again at the end of the dirtylimit_set_throttle
function, move the trace event to after this process and calculate the
final adjustment time and sleep percent.

This patch can fix the following issue:

1. The current dirty rate at 1000MB/s and the dirty limit value at
   10000MB/s, before merge this patch, this trace event will print:

     CPU[2] throttle percent: 98, throttle adjust time 191590 us
     CPU[2] throttle percent: 98, throttle adjust time 191002 us
     CPU[2] throttle percent: 98, throttle adjust time 191002 us

   After merge this patch, there will be no print.

2. The current dirty rate is 1000MB/s and the dirty limit rate value is
   333MB/s, before merge this patch, this trace event will print:

     CPU[3] throttle percent: 98, throttle adjust time 32666634 us

   It will only print linear adjustment, and the adjust time
   will be larger and only have positive values.

   After merge this patch, print as following:
     CPU[2] throttle percent: 97, throttle adjust time 128766 us
     CPU[2] throttle percent: 94, throttle adjust time -61131 us
     CPU[2] throttle percent: 92, throttle adjust time -16634 us
     ...
     CPU[2] throttle percent: 74, throttle adjust time -390 us
     CPU[2] throttle percent: 73, throttle adjust time -390 us

Signed-off-by: wangfuqiang49 <wangfuqiang49@jd.com>
---
 system/dirtylimit.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index 7c071248bb..c7f663e5b9 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -281,31 +281,30 @@ static void dirtylimit_set_throttle(CPUState *cpu,
 {
     int64_t ring_full_time_us = 0;
     uint64_t sleep_pct = 0;
+    uint64_t throttle_pct = 0;
     uint64_t throttle_us = 0;
+    int64_t throtlle_us_old = cpu->throttle_us_per_full;
 
     if (current == 0) {
         cpu->throttle_us_per_full = 0;
-        return;
+        goto end;
     }
 
     ring_full_time_us = dirtylimit_dirty_ring_full_time(current);
 
     if (dirtylimit_need_linear_adjustment(quota, current)) {
         if (quota < current) {
-            sleep_pct = (current - quota) * 100 / current;
+            throttle_pct  = (current - quota) * 100 / current;
             throttle_us =
-                ring_full_time_us * sleep_pct / (double)(100 - sleep_pct);
+                ring_full_time_us * throttle_pct / (double)(100 - throttle_pct);
             cpu->throttle_us_per_full += throttle_us;
         } else {
-            sleep_pct = (quota - current) * 100 / quota;
+            throttle_pct = (quota - current) * 100 / quota;
             throttle_us =
-                ring_full_time_us * sleep_pct / (double)(100 - sleep_pct);
+                ring_full_time_us * throttle_pct / (double)(100 - throttle_pct);
             cpu->throttle_us_per_full -= throttle_us;
         }
 
-        trace_dirtylimit_throttle_pct(cpu->cpu_index,
-                                      sleep_pct,
-                                      throttle_us);
     } else {
         if (quota < current) {
             cpu->throttle_us_per_full += ring_full_time_us / 10;
@@ -323,6 +322,19 @@ static void dirtylimit_set_throttle(CPUState *cpu,
         ring_full_time_us * DIRTYLIMIT_THROTTLE_PCT_MAX);
 
     cpu->throttle_us_per_full = MAX(cpu->throttle_us_per_full, 0);
+
+end:
+    if (cpu->throttle_us_per_full - throtlle_us_old) {
+        if (current) {
+            sleep_pct = ring_full_time_us * 100 / (ring_full_time_us +
+                    cpu->throttle_us_per_full);
+        } else {
+            sleep_pct = 0;
+        }
+        trace_dirtylimit_throttle_pct(cpu->cpu_index,
+                                      sleep_pct,
+                                      cpu->throttle_us_per_full -
+                                      throtlle_us_old); }
 }
 
 static void dirtylimit_adjust_throttle(CPUState *cpu)
-- 
2.47.0


