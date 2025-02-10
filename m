Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CF7C0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 19:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thZjz-0005hg-4I; Mon, 10 Feb 2025 14:46:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thZjp-0005g4-7F
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 14:46:38 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thZjc-0001yg-Fj
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 14:46:27 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ab7a342ef4eso489114366b.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 11:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739216782; x=1739821582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rlGruTHGycd5Vly3E7rODSdEcDVmQ8nL9itLwPeqvGs=;
 b=oJ31LY6BJ0FnTTcZLmwXX//Z7aiqYdOd/hMUcUMdY72dA2uWCf5n7Y6/hee4/VO5bp
 zbnr5n4Br+0twMjLSL7HbFfYlF7YC+ane3NeDUgVu/vY+dAEGnRVT3AKwn5GyWlKxcap
 QUBnvasFVjeX6EqS3LbrfURBU6tS3bnvTPXOjKFd3pXhJpqugtUe93C6j5nZdXJ1jabY
 gTg0/DpoK5Ab/Uup99vU0uKqHdhTVEQN8cFYe77RacEPa4LLwJKp9OLORnUI/XJusVaC
 FgkOthMaG13jq4HjR2qSxlk3/tfsAFiKH+oOyxTknkkdL/ybGNCXPMWCjQ+8lOYjCyfr
 XTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739216782; x=1739821582;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rlGruTHGycd5Vly3E7rODSdEcDVmQ8nL9itLwPeqvGs=;
 b=fVWewDnHXOXSo5XIPohvDNvWPvbPH2Ka82J2vRFGlZQLqCt7cmFroHJMf1UFhlLObK
 wL0nf7mFbSZgx+GKDhx8FN2YkkK6P9OBJI9imdNMboBNvvJfb5F8YZx2WNwAbhURfc41
 twZeKsGY7tg2v8VXyBWW7e/JBvOnz9rScvs+EO84YYnf6olE9tklD/ID/LgLg9HaXctF
 6vqBSyuzPEhn74EGB9vRBu5ETPp+U2iPG//IK2HR76rx0NVJ2eJn8leX8e9zO8697quS
 6umHzawwF2NANtTtILtRyjd4r8DFGKVT0eW0IQtrWJa3Jf2LZb1kRaTBA6Cqv1MozIqg
 3/RQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN74EiiiTzwaZxONGOrXrgyweNNfRylmNEvRjktv7cP3qBosbjjlN7NstBzBZkoM8kgiTJyyaCAmbY@nongnu.org
X-Gm-Message-State: AOJu0YyBC8IOHXtI+XSdEXvB8upZGRBvOpoEr015wA47tJsqLQ/AxqH2
 zeuCQ3OHUQJiantbFH2b8OBuYr0hJM8LNLscVJWvVMRJFt8Qv7qYeWR6soqDFN0=
X-Gm-Gg: ASbGncsQWifZOJZ+V4OExC0adEeR1mdXFUUHg4iafqvcnKP3uXnnG6GArndxD69Nhpa
 Zcsj49HYtKyJToERM0LFm22HcVZLU6HoAIqh5sBJTuog6UUZkX/6AnCcUsQBe8Rnf9c+3WGr/3k
 G5O/ftRwE4WWUH6b9Wb5EBrsVXqwihHWBcyOT5P4mRbmpJdHBInq2fovI3JCdYp7btUaOVi4Y19
 pAYWk1Eh90iMaQzeymThYYfSN1PSPkOMeQSXpc9W09mPqFzm/5DR0CM4rlVGm/etNHwlR1TI7vm
 FATa8yxniGDUW8fPSw==
X-Google-Smtp-Source: AGHT+IEd3xxgA8iCLYYSobPPJgoNMtPNjoZYhW+y7r3rJYOt1INyc9B9/ucUm1m7emTU1fa06W7yFA==
X-Received: by 2002:a17:907:c12:b0:ab7:d87:50f2 with SMTP id
 a640c23a62f3a-ab789c485bemr1476871966b.44.1739216782321; 
 Mon, 10 Feb 2025 11:46:22 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7db5ef658sm20916966b.42.2025.02.10.11.46.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 11:46:21 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0A6995F8CF;
 Mon, 10 Feb 2025 19:46:21 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] util/qemu-timer.c: Don't warp timer from timerlist_rearm()
In-Reply-To: <20250210135804.3526943-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Mon, 10 Feb 2025 13:58:04 +0000")
References: <20250210135804.3526943-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 10 Feb 2025 19:46:20 +0000
Message-ID: <87ikphr3ar.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

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

Yeah as far as I can tell in all the situations we do this with icount
we should always be exiting the loop anyway. Changing our mind about
when the next time slice ends while in a block would break things. For
IO triggered events we already know the block is about to end anyway and
things be rectified.

I did wonder if pmuevents (under icount) might suffer because they call
timer_mod_anticipate_ns in pmccntr_op_finish but my kvm-unit-test smoke
test was fine.

So:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> ---
>  util/qemu-timer.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/util/qemu-timer.c b/util/qemu-timer.c
> index 0e8a453eaa1..af6e1787e57 100644
> --- a/util/qemu-timer.c
> +++ b/util/qemu-timer.c
> @@ -409,10 +409,6 @@ static bool timer_mod_ns_locked(QEMUTimerList *timer=
_list,
>=20=20
>  static void timerlist_rearm(QEMUTimerList *timer_list)
>  {
> -    /* Interrupt execution to force deadline recalculation.  */
> -    if (icount_enabled() && timer_list->clock->type =3D=3D QEMU_CLOCK_VI=
RTUAL) {
> -        icount_start_warp_timer();
> -    }
>      timerlist_notify(timer_list);
>  }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

