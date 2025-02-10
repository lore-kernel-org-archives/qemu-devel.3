Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30819C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 18:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thY7v-0005M8-BH; Mon, 10 Feb 2025 13:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thY7H-0005Ao-BH
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 13:02:44 -0500
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thY7F-0007ik-JI
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 13:02:42 -0500
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e461015fbd4so3642931276.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 10:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739210560; x=1739815360; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uqH2AE5SNm8gHbGrysSz+Efk5ie7Lp/oyn2NiJoVcYs=;
 b=V5MfRWgIA7ruF7jgCelxbGaMN1hDuIH1113FWw7596xS94meui9b+Zriv0zqEeF1IW
 yq//T9UxvVCrLy8lzQX6Kb+mQYB54jtnTEcc+N4kLBcWwr65ebCxno/AQniOC3c6xsIO
 G9dFGLmuttEfgWmZXjgyZJpKbfB3BUE/Nh/xK4rCkmrZL0XLSZ7TJHS+z4bMhQ2OdgKt
 ilkgF7P+Iyj2b7WywWobVtCn3hw4ALhcwrw7bQJ7EU9ud8lQF0cNhQsqIjhaTuSlYz7Q
 +C+qRAK1M1/mxMCdewZQ2kjQHn7xqoMzvm2ZVU+2BuatTK2+QIGnARve9cJURldsE30r
 eQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739210560; x=1739815360;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uqH2AE5SNm8gHbGrysSz+Efk5ie7Lp/oyn2NiJoVcYs=;
 b=sqNWcMwfJjUzWmAalkkD1l0qpruyl/oUizuj4ilJ4ccH6i8eGYEhC0qgOSihb41U4x
 PC3HeNgt3CHO5dBGlWNvtoQ9LaYfcZc/iACLAf/rnm8JgkSPwFxa0tOy96gnqWbCR6zj
 q02Xe8YQ7mhxOAkR52i++Re5woMD7uafTLuCu4f4VTRWVRmb8/a55/ipWALoQPv+OfUK
 DaEL5Y2Y424U2GXVWzrY6aVtkBJqNsNmrjZeLUjDM+UzI6I8/NQm1POofrMuDv9fAsMH
 NHOpAsngmfgxt3pbB6DxmUR9vMIIi/Hlx96/D9wOVcd0+/uA0nlzOrSPaKl9nnmcJoFV
 qhKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaVPz3f1WrEl3o47It9nRppeD6Mzq84YqUesI+cd5NHaoS27XJK98WZyTes6h/ItN5QAla2CHZU2ty@nongnu.org
X-Gm-Message-State: AOJu0YyMhITOI7Ugvp5AuDtPDlJmYYJsnKIBPvNHxvzFxMcervooqJeF
 izHSPi1d6UEpRurIS0e6ki6XqyslJa/BgDcctADlNT3bDEOK7aXhafPcPVIxrvbnsVyrHkDlre3
 vFgkilkS/rmOPyN8JDB0gv0nd8zlXuLrETCm3kQ==
X-Gm-Gg: ASbGncvot8e/QX+Y1kRkfUHeVc6jIN83HcH2lajJU5LxoqYjoAQihqmj1dOC/7ttNk5
 BQh9qMk125j0g4ZAN7hcFZar31r7uOv2GAbx6g7zaJO2yEpA0I7ixOmDf/kftf33DKGPdaf675w
 ==
X-Google-Smtp-Source: AGHT+IEX8rykgJcjhEM1jsSJbj9aQQ8BMFCHJxnIdG02Yaqj6ZGriODVQqqmY7abeAeRjEhGezXV+TtLsYOhscIkENc=
X-Received: by 2002:a05:6902:168f:b0:e25:ca37:b669 with SMTP id
 3f1490d57ef6-e5b461e366cmr11739935276.24.1739210560285; Mon, 10 Feb 2025
 10:02:40 -0800 (PST)
MIME-Version: 1.0
References: <20250210135804.3526943-1-peter.maydell@linaro.org>
 <CAFEAcA97TpSfRVpNOg025GMw3pduR+73gr2LDmncoCpTDfV3jg@mail.gmail.com>
In-Reply-To: <CAFEAcA97TpSfRVpNOg025GMw3pduR+73gr2LDmncoCpTDfV3jg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Feb 2025 18:02:28 +0000
X-Gm-Features: AWEUYZlRF2sH9Wxq2UhlG70fyBOuI8f9qZGhmjfnU3rW4ChOZ0EKoSc-3gdHLbQ
Message-ID: <CAFEAcA96VYUbp6L33O9A461=0GWbyBB8gP0rbDm+QkamY8daHg@mail.gmail.com>
Subject: Re: [PATCH] util/qemu-timer.c: Don't warp timer from timerlist_rearm()
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Mon, 10 Feb 2025 at 14:08, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 10 Feb 2025 at 13:58, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > Currently we call icount_start_warp_timer() from timerlist_rearm().
> > This produces incorrect behaviour, because timerlist_rearm() is
> > called, for instance, when a timer callback modifies its timer.  We
> > cannot decide here to warp the timer forwards to the next timer
> > deadline merely because all_cpu_threads_idle() is true, because the
> > timer callback we were called from (or some other callback later in
> > the list of callbacks being invoked) may be about to raise a CPU
> > interrupt and move a CPU from idle to ready.5A
>
> (oops, stray editor damage "5A" at end of line)
>
> >
> > The only valid place to choose to warp the timer forward is from the
> > main loop, when we know we have no outstanding IO or timer callbacks
> > that might be about to wake up a CPU.
>
> This raises actually another question: should the call to
> icount_start_warp_timer() in main_loop_wait() maybe go after
> qemu_clock_run_all_timers() rather than before? (Haven't tested
> whether that breaks anything ;-))

After further thought, I don't think this matters. If we
call warp_timer before the run_all_timers callback then
the warp will only warp the timer forward to at most the
earliest timer deadline (and then run_all_timers will
execute it); if there's already a timer whose deadline
has expired then warp_timer won't do anything.
If we call warp_timer after the run_all_timers callback
then I think the only difference is that we would go
round the loop another time before executing the
timer callback. Either way, that bit of the code doesn't
need changing.

-- PMM

