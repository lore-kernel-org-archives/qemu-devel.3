Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79248CFC293
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 12:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0gFs-0007mG-IE; Tue, 15 Oct 2024 08:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0gFn-0007lZ-PC
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 08:02:20 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0gFk-0008WR-Tg
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 08:02:19 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-539f8490856so2136131e87.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 05:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728993710; x=1729598510; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W7WlxhTZk3LLaEpBNUlCQG1kKWGOoSjBnIrpQlq7+P4=;
 b=rBwwfArYrAx/BjWpdU7Xyav0uQoRKfbilfEcIsQJhyuDKejMq6AOqioinQljQi6rIS
 F1U0PtSbRfFk39j711H6SsWAjm4uRL7Pnp1JD73Mn0gya3/+DCvcpq+/AhkCyAuBM7I+
 VnEtop4E0o7tSsJyZTOBb5TWZkVRQcBaHJrOrbUyIISDPeBLnl8Lx/DxzdVoXxCAcxa7
 x3Yck6NPXBojBAE9jKvVKTHuFAb7tcqm1+T0Svvaeg1VK/R35NJVJExK2JA5Bl433R4O
 jmCIJxFRzkmG66WhxSR6b2uxs0rzyC36ZvzFESZhNKOOrefelXAd3JxrsR8u6lkCX7bW
 XlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728993710; x=1729598510;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W7WlxhTZk3LLaEpBNUlCQG1kKWGOoSjBnIrpQlq7+P4=;
 b=k1lRn3g8OtbSa929V4ILSrOt5u7Z5jI//Xt3wceAjo62o4HZEcBECibktIlvSw1ALl
 otiCykHcbi0+7ErMLvykeatZI8daCAA9+PSG88qIb5mp3AHbckOvHUKqmlWixNYQUcyH
 ue0Dv/OBnh4u6qSBmBci/fqPVQ77dKJBkULjx6f681QLuTrSEoPx7/oiJeyTf9KSN5AU
 gngOMDmz3dH3KRxNTbwg3WVjcxgD4PhbX6yqlNPWDx5B+6/Yv+Wc3aMasn+GV4DSk/KE
 a0MDKwNOfeWXbjs+r9iq67oM/Uzz0q2MG7ovKRFWUKtyl10YbQRnQOCXl+GrdE0q+Eov
 35XQ==
X-Gm-Message-State: AOJu0YyidyuVzn59MiKQ5DgrfFc3nFgKaBzGdlYqCsSDiWWsPgfupFdv
 uw994OFCG52S9RiRtqHaxGJvou/wGbVOr4tZ/nicOr9avQOBIrub9CHfRcEoG57gVnVkq52oyiG
 oUKJH45O2/OSiD8x9nib+rIcirWL+RWRLKPRpog==
X-Google-Smtp-Source: AGHT+IH5DYi5b37DwBtuD5jIX3Ss1+2BSPBloRMAbcNndie/9UU5j5IMWOZcjGdc6FaXioET1R5mUhC//aL2QgSTap0=
X-Received: by 2002:a05:6512:1290:b0:539:a4ef:675a with SMTP id
 2adb3069b0e04-539da4f62d2mr6508943e87.34.1728993709512; Tue, 15 Oct 2024
 05:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20241015113705.239067-1-peter.maydell@linaro.org>
 <24e57088-ebbc-4a9e-919d-5d05cfca00a4@redhat.com>
In-Reply-To: <24e57088-ebbc-4a9e-919d-5d05cfca00a4@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Oct 2024 13:01:37 +0100
Message-ID: <CAFEAcA_QWnxWfZn=rqbpVC8HrhZ5eBi6BcFc45UBKqVX9cLY=A@mail.gmail.com>
Subject: Re: [PATCH] tests/qtest: Raise the ide-test timeout
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
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

On Tue, 15 Oct 2024 at 12:42, Thomas Huth <thuth@redhat.com> wrote:
>
> On 15/10/2024 13.37, Peter Maydell wrote:
> > The ide-test occasionally times out: on the system I run
> > vm-build-openbsd on, it usually takes about 18 seconds, but
> > occasionally hits the 60s timeout, likely when the host machine is
> > under heavy load.  I have also seen this test hit its time limit on
> > the s390x CI runner.
> >
> > Double the timeout for this test so that it won't hit its timeout
> > even when the host is running more slowly than usual.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   tests/qtest/meson.build | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> > index b207e386965..e8be8b3942d 100644
> > --- a/tests/qtest/meson.build
> > +++ b/tests/qtest/meson.build
> > @@ -4,6 +4,7 @@ slow_qtests = {
> >     'bios-tables-test' : 910,
> >     'cdrom-test' : 610,
> >     'device-introspect-test' : 720,
> > +  'ide-test' : 120,
> >     'migration-test' : 480,
> >     'npcm7xx_pwm-test': 300,
> >     'npcm7xx_watchdog_timer-test': 120,
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
> PS: It's a bit weird that we see more and more timeout problems recently ...
> I think I've also seen some local ones on my laptop when my system was under
> load, but not really reproducible. I wonder whether we have a performance
> degradation somewhere in the code...?

If it is, it's one where it's intermittent whether it hits or not
(e.g. I grepped a bunch of my local logs for this test and there's
a lot of 18s and a 30s and a couple of 60s) and it tends to hit for
multiple tests in a single CI run when it does hit. e.g.

https://gitlab.com/qemu-project/qemu/-/jobs/8065512834

https://gitlab.com/qemu-project/qemu/-/jobs/8069311713

are a failure and a pass of the same git hash for "clang-system".
The 'make check' stage on the failure took just under 40 minutes;
the same 'make check' on the passing job took less than 3 !
The 'make' stage also had a similar gap in timing between the
two, and I don't think that's entirely because of ccache caching
effects because the stats at the bottom of the passing job
say the hitrate was >90%.

-- PMM

