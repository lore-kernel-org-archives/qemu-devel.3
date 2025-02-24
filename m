Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5AE0C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 14:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmZpG-0003Zd-Ss; Mon, 24 Feb 2025 09:52:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmZpE-0003Yx-WC
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 09:52:53 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmZpC-0000PA-Tv
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 09:52:52 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6f6ae4846c7so36038137b3.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 06:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740408769; x=1741013569; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CCVwFU30iRIVDUkhO8+T1DaSlcaCUl6Lrdm8AEwgjvM=;
 b=CEhk9QrSqjitwzVMqQ43y6Hg66Y3MHjxG5OwViwdXip9wdrAuTFP90j4T6lirGmims
 WnubL/Jeo/lzsAoHl3n0R7MDFzUcyGja2WnM0qONu0M6KODWpoOyEqtmssHMHUUaYdcG
 C41Nv8AQOP3DzWU73iLrEErw8FhXVlE9sTlcB94atbqj+g0V9zn5rYSkWjV5BmQsqqGJ
 +CHLEdr6rY+B8WYfVwh4JRN2Pt+lgGp61Wy0Luw/6C09Ja6T6nY5E2FjB2bC+T6IZcPO
 IZJtFokVPZNCtkH1bHf4tZModTqtGziicq0h/MvXT9dj1b4ckKV4xhbFwjnpahhw57Eq
 Z/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740408769; x=1741013569;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CCVwFU30iRIVDUkhO8+T1DaSlcaCUl6Lrdm8AEwgjvM=;
 b=tmqjg4o74cnt+RlYqK0Z5K/b8iYfz6fhl39SBwWkQJhLZjSeJH3lXQZ/j0xVAH5x6W
 k5/QIqD8+N8UXZRTJaI+Er1bCxQg//FMlwatOM5rNjkG/dYZpnRlr2tgDtEqX3i10NU9
 BhSUPrTJbm84gz1damVsXhQgRdREkwWtQImM/txE0Gof+tbCpBSdkdeQ4gOFeYg9yU12
 nJOVeg6ZnuK/dIrnDXP5dPDpe1pSeJ/VOaTdwbB9nhb3KbUiylIbFELuyvGdKReFN01Z
 79Jy7mTbz/Vm/kFkSR8wml1CWLKO6PkMXVVLjq7NyC8fubiO8d9yflE75SHJ/Bdlb4u9
 zFCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgHWM7zTC+herDya3aKBO9ucUuuA3iTNXs7m9dkMo1hggDizj5llOI2V6gqap5nBLDu0mo/tPFiGy2@nongnu.org
X-Gm-Message-State: AOJu0YzlMY7wSY1MmCLcYc1S79fksUI3SthWK2bFxDMs83n3+xh/P6NP
 6NNgagkD9hyBhAcP6Jy3GpDrj9HIVzWxrOl30J4PnPVY6yLCFnixbiASIonj4e0lW/3/vpNr96/
 TmaZCJ09/l0AjJ0F4Q4J+JDuRYiG90wM44i9+tA==
X-Gm-Gg: ASbGnctO+Onr3ANv6nw5m7SPaSfXiOOnb3H0P3+yUyz/IEQmzRogJ8BPUkqqYO93Hpe
 RLfrVRxsOQHfqZJ+D19TzgA7durJVoga1Cq6MZRg8B8scPj45Lg6pr7BAYfCzhqEaoTrmkj+kZw
 irhgJHL7Tl
X-Google-Smtp-Source: AGHT+IGJ7//z/viz6CX9wR+A/D7zOKGUa8JHhsNi9AAn39cZTjnPkyDlqv3tL6vJfuAFl3VN5kTc6H3ny6F6VeuI0Vk=
X-Received: by 2002:a05:690c:6a12:b0:6ef:5097:5daa with SMTP id
 00721157ae682-6fbcc856ce4mr114955077b3.34.1740408769655; Mon, 24 Feb 2025
 06:52:49 -0800 (PST)
MIME-Version: 1.0
References: <20250210135804.3526943-1-peter.maydell@linaro.org>
In-Reply-To: <20250210135804.3526943-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Feb 2025 14:52:37 +0000
X-Gm-Features: AWEUYZkP0tpN-ueTrtqF1asomW7jXOP8tBH0MmuW-H8alHZx7JaGuMcnTIAf0Ks
Message-ID: <CAFEAcA-SbHjBu8xo8Uy11n2N22LtUejARHC7w8ucu24kg15Xog@mail.gmail.com>
Subject: Re: [PATCH] util/qemu-timer.c: Don't warp timer from timerlist_rearm()
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

This has been reviewed, but nobody's picked it up. Paolo,
MAINTAINERS says qemu-timer.c is part of your "Main loop"
responsibilities. Did you want to pick it up? Or I could
throw it in to target-arm.next if you prefer.

thanks
-- PMM

On Mon, 10 Feb 2025 at 13:58, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Currently we call icount_start_warp_timer() from timerlist_rearm().
> This produces incorrect behaviour, because timerlist_rearm() is
> called, for instance, when a timer callback modifies its timer.  We
> cannot decide here to warp the timer forwards to the next timer
> deadline merely because all_cpu_threads_idle() is true, because the
> timer callback we were called from (or some other callback later in
> the list of callbacks being invoked) may be about to raise a CPU
> interrupt and move a CPU from idle to ready.5A
>
> The only valid place to choose to warp the timer forward is from the
> main loop, when we know we have no outstanding IO or timer callbacks
> that might be about to wake up a CPU.
>
> For Arm guests, this bug was mostly latent until the refactoring
> commit f6fc36deef6abc ("target/arm/helper: Implement
> CNTHCTL_EL2.CNT[VP]MASK"), which exposed it because it refactored a
> timer callback so that it happened to call timer_mod() first and
> raise the interrupt second, when it had previously raised the
> interrupt first and called timer_mod() afterwards.
>
> This call seems to have originally derived from the
> pre-record-and-replay icount code, which (as of e.g.  commit
> db1a49726c3c in 2010) in this location did a call to
> qemu_notify_event(), necessary to get the icount code in the vCPU
> round-robin thread to stop and recalculate the icount deadline when a
> timer was reprogrammed from the IO thread.  In current QEMU,
> everything is done on the vCPU thread when we are in icount mode, so
> there's no need to try to notify another thread here.
>
> I suspect that the other reason why this call was doing icount timer
> warping is that it pre-dates commit efab87cf79077a from 2015, which
> added a call to icount_start_warp_timer() to main_loop_wait().  Once
> the call in timerlist_rearm() has been removed, if the timer
> callbacks don't cause any CPU to be woken up then we will end up
> calling icount_start_warp_timer() from main_loop_wait() when the rr
> main loop code calls rr_wait_io_event().
>
> Remove the incorrect call from timerlist_rearm().
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> As far as I can tell, this is the right thing, and it fixes the
> "icount warps the timer when it should not" bug I'm trying to
> address, but I'm not super familiar with the icount subsystem or its
> evolution, so it's possible I've accidentally broken some other setup
> here.  This does pass the tcg, functional and avocado tests,
> including the record-and-replay ones.  I've cc'd it to stable as a
> bugfix, but it definitely merits careful review first.
> ---
>  util/qemu-timer.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/util/qemu-timer.c b/util/qemu-timer.c
> index 0e8a453eaa1..af6e1787e57 100644
> --- a/util/qemu-timer.c
> +++ b/util/qemu-timer.c
> @@ -409,10 +409,6 @@ static bool timer_mod_ns_locked(QEMUTimerList *timer_list,
>
>  static void timerlist_rearm(QEMUTimerList *timer_list)
>  {
> -    /* Interrupt execution to force deadline recalculation.  */
> -    if (icount_enabled() && timer_list->clock->type == QEMU_CLOCK_VIRTUAL) {
> -        icount_start_warp_timer();
> -    }
>      timerlist_notify(timer_list);
>  }
>
> --
> 2.34.1

