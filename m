Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F4BC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 09:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thQB7-00031M-0T; Mon, 10 Feb 2025 04:34:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thQB0-0002zp-G1
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 04:34:05 -0500
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thQAy-0001bL-95
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 04:34:02 -0500
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e461015fbd4so3191771276.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 01:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739180035; x=1739784835; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zbzce1JeM8K739t+w3wJvg+8MysR5ashRFokl5gUKN8=;
 b=u9pj2ud9OYXuIaWqppv9q0sdT0SDzLVE8VeDUQw71fDP0rTrHKRh0mLe/QYuXSpfYV
 au2d266V+OwgYm83sx+Do9Sd0pv1j+sXhR2lCfd4MwwlrvBXvpanaF5BF9Q5Fp5cEi9i
 01S8O/fHR2hug1FRFc7PJst2h1A4krUC402g+vNaO2Dkkm+BJqPwI80bZVyurY0aa+PT
 nYwSbDMoHve72S7IDENXZvuAsSh8/taSpL3eTOE1IEcw0T4yx1jN+h60NydqIeBWwyay
 e9LiBjYaqITYCk1Hl8HJr0b6+ZmXBluhrPxSaxgjlY3pXtIdvVnl8KldwSIfeCtudLLy
 U2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739180035; x=1739784835;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zbzce1JeM8K739t+w3wJvg+8MysR5ashRFokl5gUKN8=;
 b=D99NMEs4UN0bG/Czuv41kWPHQtc6nifk/TULtI3Ki+ffF0KreZOMLR3uIHy7ryADeK
 94wjyH/04jDTGqNT+1KwfNit0xHvHRiKItPpQAz/1H1yS3Vf6JT8MRpHzv+uvGotosgt
 AjH2wj/VgCwOdfE+3mR5k3kFQWbmPvaIOyrPL5yj5EeQYMIbGjJ7pkWXlCDhsnsKfG0Y
 dkNdmyNqbAXrbKx7zHygv6I4g016dB83hfIGKu7FQbf+GYJ+ldNuIo2fp0gI0qtZUnNg
 P8/VKgkfbkJUzTN/hk3V7ois69AoDB0YaOeCNACHWAl7hHVnF6tWJpShotWFifwt42c2
 A5yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1BSJ+HNrxu9wr1JRv0pTGjwcYk7RfLjA8H4pL0RwgyqBbpbJsORMVQfoUBYiK6ieE7AoVmlOYi81Q@nongnu.org
X-Gm-Message-State: AOJu0YwhB5ZnQJGWyA1W4sIA6tAz03FPeNvd4iT8FH/SFlc9VjXyxJQz
 muxq3uaVSobZCIrYFXMuxwumafAe70fw5Ai3+83AVZzJ4QLYGY5RTyXfx1NlpT9I9DWQVXHvb1g
 VJ3rjmWHTvkbzz9FD+7M5hf5y3rdAKODhIQsgSQ==
X-Gm-Gg: ASbGnct3RXBd6Rd1/tA7xiU+1TNDC17tI46t4oz2lm569Wd+13k7ZPUVvscCaqGK7/V
 ArGaYI59X1AmBvDaabGiHYwgVU5MpdSsq5eQvWKzUq1oJr1Yic61vn0+YxC1xqT2HC3U6cibA6A
 ==
X-Google-Smtp-Source: AGHT+IH+LpIg3DfIs0EJDk2wfnMLR3zmxIhh+xfMnqKNw65LHDaxqpqdKVHcC25fGTb6WHCGIBSZdsKjqhpmqkj+eiI=
X-Received: by 2002:a05:6902:1249:b0:e5b:248a:bf2f with SMTP id
 3f1490d57ef6-e5b4626c51cmr10924092276.31.1739180035342; Mon, 10 Feb 2025
 01:33:55 -0800 (PST)
MIME-Version: 1.0
References: <20240615185423.49474-1-florian.lugou@provenrun.com>
 <CAFEAcA_+WrzM4fXQMUxMi3L5yiUWMrUGTSZH=NDdYDKUCP+8NQ@mail.gmail.com>
 <20240620135627.qxcrkdx5v7wdurx4@flugou-latitude5401>
 <CAFEAcA-ngrrEUDD7eA_sOLGF+_wRCuQVxTwuCA4pXjRcuJucmA@mail.gmail.com>
 <20240621140725.f4hsasmhrhh4joxm@flugou-latitude5401>
 <CAFEAcA9c9hbpsdyc7+=QEOZGrNY2m-urk6VrWdwCdfk9ipkwpw@mail.gmail.com>
 <20240820113024.53tmzejw2omm6bbx@flugou-latitude5401>
 <CAFEAcA9X0w5QW2qnnhF2k72ZrS8SALWiXV7uNr1e=jQnZvrQ7Q@mail.gmail.com>
 <CAFEAcA-MrouAPdwpsyojMC-bx4aFtuL=tYZD=2pBS1vP5iicaw@mail.gmail.com>
 <5ee77b8c-e6a4-421b-b729-a6535fdf1e6d@linaro.org>
 <87a5axr4l4.fsf@draig.linaro.org>
In-Reply-To: <87a5axr4l4.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Feb 2025 09:33:44 +0000
X-Gm-Features: AWEUYZks7N5joTM2FfdiQcWhg1B3GGmwDm1C_TyYlrkh2oHdflFuHEhWeKy_Jq8
Message-ID: <CAFEAcA89Wm-cZZV7swdmzVxjR3h3QfGpgROA=AAt6ABJLbOOsw@mail.gmail.com>
Subject: Re: [PATCH] target/arm/helper: Fix timer interrupt masking when
 HCR_EL2.E2H == 0
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Florian Lugou <florian.lugou@provenrun.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 7 Feb 2025 at 18:29, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Richard Henderson <richard.henderson@linaro.org> writes:
>
> > On 2/7/25 07:45, Peter Maydell wrote:
> >> This is where things go wrong -- icount_start_warp_timer()
> >> notices that all CPU threads are currently idle, and
> >> decides it needs to warp the timer forwards to the
> >> next deadline, which is at the end of time -- INT64_MAX.
> >> But once timer_mod_ns() returns, the generic timer code
> >> is going to raise an interrupt (this goes through the GIC
> >> code and comes back into the CPU which calls cpu_interrupt()),
> >> so we don't want to warp the timer at all. The clock should
> >> stay exactly at the value it has and the CPU is going to
> >> have more work to do.
> >> How is this supposed to work? Shouldn't we only be doing
> >> the "start moving the icount forward to the next deadline"
> >> once we've completed all the "run timers and AIO stuff" that
> >> icount_handle_deadline() triggers, not randomly in the middle
> >> of that when this timer callback or some other one might do
> >> something to trigger an interrupt?
> >
> > I don't understand timer warping at all.  And you're right, it doesn't
> > seem like this should happen outside of a specific point in the main
> > loop.
>
> This has come up before - and the conclusion was we don't know what
> sleep=3Don/off is meant to mean. If the processor is asleep and there are
> no timers to fire then nothing will happen.
>
> It was off-list though:
>
>   Subject: Re: qemu-system-aarch64 & icount behavior

No, that was a different situation. That thread was about
when there genuinely is nothing to do (all CPUs asleep and
no timers active) for the rest of the life of the simulation.

The bug in this thread is that icount incorrectly prematurely
decides it should warp the timer forwards, when in fact
there is going to be something the CPU should be doing
right now (i.e. responding to the interrupt the timer callback
is about to raise). It becomes very obvious when there's
no other timer callback, because the place that icount
incorrectly warps us to is end-of-time, but I'm pretty sure
that even when there is another timer active icount will
still be wrongly warping time -- it will just be less obvious
because the interrupt gets incorrectly delayed to whatever
that subsequent timer callback time is, rather than forever.

thanks
-- PMM

