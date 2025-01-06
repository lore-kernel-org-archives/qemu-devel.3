Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EACE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 15:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUp30-0004jU-5j; Mon, 06 Jan 2025 10:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fuqiang.wng@gmail.com>)
 id 1tUp2z-0004jK-3K
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 10:29:41 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fuqiang.wng@gmail.com>)
 id 1tUp2x-0005X3-3g
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 10:29:40 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-216728b1836so189862415ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 07:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736177367; x=1736782167; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8yT5bsRIVQoU81G0Nie1hNTJZ3gKKPF8hlKF0TMo3BM=;
 b=IRidnRwtWXiJ5jXO2gZVVn2IBguE3KiWlTVWvUR6I1Oh0tjocGbNHu36drkrV8V5Ch
 ToshvdWfzhufiRYxTWJm02FBMNJOY/XrqgqfrrVelRY9xO0K8hcHADV0ds4s5dYmqZM9
 dNbpVjYZw8aZg3kFGiJLy/UtTRjNHxTrekTKdKu6UxxN4by4PYWiwcaUUyLZqgUfq4QZ
 KDtlKsRMa/cJhtyrXMEtlunkzFSdC3Xw7rAOXsB04xXJ3eqRBMNkDT6S8ZnkWMkU9MrV
 +lbJORdb+7fpso49DJI8UQbdi6X/iEiyPDNfBIw98mAVH1i2U7zVWabBRQD+F1d7DeIr
 JvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736177367; x=1736782167;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8yT5bsRIVQoU81G0Nie1hNTJZ3gKKPF8hlKF0TMo3BM=;
 b=L2sJ25na7gbyPTMb/Wd1RrrJLuHUh9zhjvIRw/3Rh6vyfPQSM2MH3VoncGkvkyER6y
 Xj09aRQjALR1WviWXPqL+N38KZXYl8jXtGMI+3c45xE/tLRjYV3MH8HuT0Bl4//vfHos
 w+++c+Dpp6nbGK2mdS09F9qiB1XcqtC/Ks1H3G4bIjlfKWA1LizNzV7hIoS5wRaGfqWX
 prEILcgNFTBoRlmbgvOjL+LWDhG4gzkDFsxK3m2KWgx1/hL1QEqdaXmjgQc5Y3UCxKh2
 8VODaJiekuCbqeDfml8Sygpc3DWqkimEitSIuoF3jIbmWJQBrXH0TMO2DyW+lwOwjWaQ
 WFMQ==
X-Gm-Message-State: AOJu0YwxM7Q/2vwBRjXHIsmK35ugpXUNE0HJNjs3mXFQ7OBTZ/cV0PQk
 1J2Syp+WTL27f/4zpInIFtvW659kxsOnUBA9J0jWJ1UnewqTP5V8a4NSRbuX
X-Gm-Gg: ASbGncsJeBOJCHWgk+59VefhK80LY955POQBsj4FgzT4Qy9tOxvPPhea4wG+kodwEMF
 h6vEacIw4xEOskDGUneCIPYtSV6oQmUbsAM5mHuuawaT4nJwKK+VdhSaXv1mI9qkcBiPHnxokXn
 M5f+qSneXQiy6ja+dQ6Nm9Em1CpGriXhxIAMbsZR+a0Yn+aV6fC3qfXXi8VJVHY0Zx+ryvjv4FD
 zx79Q7HbOv4xClJ2cNpz7TygmnZF6/FCD7uTJVvdKXcTf3lfjft7lqETphCN2BcRFvTUSVvs2iE
 bEII0oHx8u9FfA==
X-Google-Smtp-Source: AGHT+IHhvGmmjuXLXHnv0noAdidbEkvU0SxNHn/s96LHpiq7RXCYZvLQOtW2tt+Y2oGJV/zshBpJ0w==
X-Received: by 2002:a17:902:c943:b0:216:6d48:9177 with SMTP id
 d9443c01a7336-219e6e8c7e8mr890985955ad.11.1736177367445; 
 Mon, 06 Jan 2025 07:29:27 -0800 (PST)
Received: from ?IPV6:240f:c0ff:0:4::6c19? ([2408:80e0:41fc:0:fe2d::6c19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9f4fbcsm294099235ad.174.2025.01.06.07.29.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 07:29:26 -0800 (PST)
Message-ID: <9ce92f26-8de7-47b7-97a8-3c514cc4c1c6@gmail.com>
Date: Mon, 6 Jan 2025 23:29:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] optimize the dirtylimit_throttle_pct trace event
From: fuqiang wang <fuqiang.wng@gmail.com>
To: Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, huaminxu1@jd.com,
 wangfuqiang49 <wangfuqiang49@jd.com>
References: <1735610174-37467-1-git-send-email-fuqiang.wng@gmail.com>
 <1735610174-37467-2-git-send-email-fuqiang.wng@gmail.com>
 <CAK9dgmZV4NCe3RrA-rKsAvsG2aXeoqKStXVO5Wrc7dXS19V8PQ@mail.gmail.com>
 <7dde8164-d461-4b7b-85f4-702675cd5818@gmail.com>
In-Reply-To: <7dde8164-d461-4b7b-85f4-702675cd5818@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=fuqiang.wng@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/1/6 21:38, fuqiang wang wrote:

I'm sorry for getting back to you after a few days.

> 在 2025/1/3 00:40, Yong Huang 写道:
> >
> >
> > On Tue, Dec 31, 2024 at 9:56 AM fuqiang wang <fuqiang.wng@gmail.com> wrote:
> >
> >     The current dirtylimit_throttle_pct trace event is triggered when the
> >     throttle time is adjusted linearly. Modify the trace event so that it
> >     can record non-linear adjustments. 
> >
> >
> > Please target the optimization mentioned above in a single patch.
> > .
Thank you for your suggestions. I will do it in next version.
> >
> >     Additionally, since the throttle time
> >     might be adjusted again at the end of the dirtylimit_set_throttle
> >     function, move the trace event to after this process and calculate the
> >     final adjustment time and sleep percent.
> >
> >
> > If need, I'd advise dividing this into a different patch.
> >
Thanks. I will do it.
> >
> >     This patch can fix the following issue:
> >
> >     1. The current dirty rate at 1000MB/s and the dirty limit value at
> >        10000MB/s, before merge this patch, this trace event will print:
> >
> >          CPU[2] throttle percent: 98, throttle adjust time 191590 us
> >          CPU[2] throttle percent: 98, throttle adjust time 191002 us
> >          CPU[2] throttle percent: 98, throttle adjust time 191002 us
> >
> >        After merge this patch, there will be no print.
> >
> >     2. The current dirty rate is 1000MB/s and the dirty limit rate value is
> >        333MB/s, before merge this patch, this trace event will print:
> >
> >          CPU[3] throttle percent: 98, throttle adjust time 32666634 us
> >
> >        It will only print linear adjustment, and the adjust time
> >        will be larger and only have positive values.
> >
> >        After merge this patch, print as following:
> >          CPU[2] throttle percent: 97, throttle adjust time 128766 us
> >          CPU[2] throttle percent: 94, throttle adjust time -61131 us
> >          CPU[2] throttle percent: 92, throttle adjust time -16634 us
> >          ...
> >          CPU[2] throttle percent: 74, throttle adjust time -390 us
> >          CPU[2] throttle percent: 73, throttle adjust time -390 us
> >
> >     Signed-off-by: wangfuqiang49 <wangfuqiang49@jd.com>
> >     ---
> >      system/dirtylimit.c | 28 ++++++++++++++++++++--------
> >      1 file changed, 20 insertions(+), 8 deletions(-)
> >
> >     diff --git a/system/dirtylimit.c b/system/dirtylimit.c
> >     index 7c071248bb..c7f663e5b9 100644
> >     --- a/system/dirtylimit.c
> >     +++ b/system/dirtylimit.c
> >     @@ -281,31 +281,30 @@ static void dirtylimit_set_throttle(CPUState *cpu,
> >      {
> >          int64_t ring_full_time_us = 0;
> >          uint64_t sleep_pct = 0;
> >     +    uint64_t throttle_pct = 0;
> >          uint64_t throttle_us = 0;
> >     +    int64_t throtlle_us_old = cpu->throttle_us_per_full;
> >
> >          if (current == 0) {
> >              cpu->throttle_us_per_full = 0;
> >     -        return;
> >     +        goto end;
> >
> >
> > The current dirty rate is zero, indicating nothing needs to be done,
> >
> > including displaying the trace event. return directly seems justified.
My original goal is to report every change in throttle_us_per_full using the
trace event including when throttle_us_per_full is zero. When testing
test/migration/stress, it generally occurs when the stress process 
migrates to
another core. I would like to seek your advice again on whether this is
necessary.
> >
> >          }
> >
> >          ring_full_time_us = dirtylimit_dirty_ring_full_time(current);
> >
> >          if (dirtylimit_need_linear_adjustment(quota, current)) {
> >              if (quota < current) {
> >     -            sleep_pct = (current - quota) * 100 / current;
> >
> >
> > s/sleep_pct/throttle_pci/ , why ?
I modified the sleep_pct variable to record the actual percentage of sleep
time, while the original sleep_pct records the percentage of each sleep time
adjustment.

However, this doesn't seem to be a good change. How about keeping the 
original
sleep_pct variable and adding a new sleep_pct_full variable to store the 
actual
percentage of sleep time?
> >
> >     +            throttle_pct  = (current - quota) * 100 / current;
> >                  throttle_us =
> >     -                ring_full_time_us * sleep_pct / (double)(100 - sleep_pct);
> >     +                ring_full_time_us * throttle_pct / (double)(100 -
> >     throttle_pct);
> >                  cpu->throttle_us_per_full += throttle_us;
> >              } else {
> >     -            sleep_pct = (quota - current) * 100 / quota;
> >     +            throttle_pct = (quota - current) * 100 / quota;
> >                  throttle_us =
> >     -                ring_full_time_us * sleep_pct / (double)(100 - sleep_pct);
> >     +                ring_full_time_us * throttle_pct / (double)(100 -
> >     throttle_pct);
> >                  cpu->throttle_us_per_full -= throttle_us;
> >              }
> >
> >     -        trace_dirtylimit_throttle_pct(cpu->cpu_index,
> >     -                                      sleep_pct,
> >     -                                      throttle_us);
> >          } else {
> >              if (quota < current) {
> >                  cpu->throttle_us_per_full += ring_full_time_us / 10;
> >     @@ -323,6 +322,19 @@ static void dirtylimit_set_throttle(CPUState *cpu,
> >              ring_full_time_us * DIRTYLIMIT_THROTTLE_PCT_MAX);
> >
> >          cpu->throttle_us_per_full = MAX(cpu->throttle_us_per_full, 0);
> >     +
> >     +end:
> >     +    if (cpu->throttle_us_per_full - throtlle_us_old) {
> >     +        if (current) {
> >     +            sleep_pct = ring_full_time_us * 100 / (ring_full_time_us +
> >     +                    cpu->throttle_us_per_full);


I'm very sorry, it seems I sent an old version of the patch. It should be:

+    if (cpu->throttle_us_per_full - throtlle_us_old) {
+        if (current) {
+            sleep_pct = cpu->throttle_us_per_full * 100 / 
(ring_full_time_us +
+                    cpu->throttle_us_per_full);

The test records in the commit message are based on the new version.


> >     +        } else {
> >     +            sleep_pct = 0;
> >     +        }
> >     +        trace_dirtylimit_throttle_pct(cpu->cpu_index,
> >     +                                      sleep_pct,
> >     + cpu->throttle_us_per_full -
> >     +                                      throtlle_us_old); }
> >
> >
> > This changes the interface of the trace event,  We can keep
> > the throttle_us and add the delta meanwhile:
> > trace_dirtylimit_throttle_pct(cpu->cpu_index,
> >                       sleep_pct,
> >                       throttle_us,
> >                       cpu->throttle_us_per_full - throtlle_us_old)
> >
> >      }
> >
> >      static void dirtylimit_adjust_throttle(CPUState *cpu)
> >     -- 
> >     2.47.0
> >
> >
> >
> > -- 
> > Best regards
"cpu->throttle_us_per_full - throttle_us_old represents the adjustment value
for throttle us in this update." And throttle_us is as well. However,
throttle_us is always a positive value and now it includes both positive and
negative values. The change to throttle_us alone doesn't seem to alter the
interface of trace_event.

However, as mentioned earlier, the meaning of sleep_pct has changed.
Previously, it was used to indicate the percentage of the current 
adjustment,
and now it is used to represent the actual percentage of sleep time.(I'm not
sure if I misunderstood your meaning or if I have a misunderstanding of the
code.) So, is it necessary to also report the adjustment of sleep time 
in this
update? I would appreciate any suggestions you might have.

fuqiang

THX



