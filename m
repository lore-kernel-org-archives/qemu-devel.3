Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D198CD3445
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 08:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKuZp-0006Vl-38; Thu, 07 May 2026 04:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKuZk-0006UT-Vh
 for qemu-devel@nongnu.org; Thu, 07 May 2026 04:59:20 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKuZj-00020d-56
 for qemu-devel@nongnu.org; Thu, 07 May 2026 04:59:20 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-64d5a7926cfso544738d50.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 01:59:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778144358; cv=none;
 d=google.com; s=arc-20240605;
 b=QhJWb4dgqSXa7UTA2yCl4Xn8u1NZD6sI51faTEkZ0W30HwU4vwUyZ4rTu4raIn2Fcu
 oPpyXQ/CtaHJjrreBTVQl7I4DvXB/Lx3r4KWmRioomtMedYoBwqMQt6qbEd6azwq1OMo
 DaHp5FBEFqwixNgvRG0eg2eB4o9OYW/VpSOPHz3z+66QQsEfQGjM1TApQWv0MYgPRV5F
 CLXTw3e9m+zVskU/BMe+rf+4R1v8noauKn+nQfusUg0izs6LBWIXCMlqj1pTooBM/cVA
 sOUPo7A84CM/xa2O/cFCiL5W4JGrzHmCKYMVD/XYEUTue+z7A4fdVV2joy1E/y5py9V6
 104Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gGRZ28sR+VxEZ5C73+RuuigjMnxpYWGNS100EvozcLs=;
 fh=OVBsQUmFFa5C7E86a/hWqq4RkAJRFqCs1t4BeDuet+E=;
 b=Jz2uxZhGioHOzIKU+yzL7yaqdBTgeLn38di5ix/oi12XGz8rblwbMjpeTT50IrNFtx
 o01aoEatPGfQTfh1HbNlx3mNSixwCaRw7YLLnqgsLuVPa0xx4UJ3tBONvgEq4TeOe3TZ
 rSl8t7sxcZzL94LFBt+BE052I2ix4lQmdxNj5qSL0L4KF+vTaLjtLTEr7vE0ln9CKieV
 2LGxGrCQQaHkgIOzPvBx6O+PzV6JC0RCUUY9B/iGMlAh6Ehu9DonrvT2zPax6YA4sp31
 Yavqvk+SN4x6+ZrhZCLHxNh2px+9nclXs2ZqSqW6yZ8TbvFBYd7YNOoucUjBqxx3zJFj
 7O5A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778144358; x=1778749158; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gGRZ28sR+VxEZ5C73+RuuigjMnxpYWGNS100EvozcLs=;
 b=xkBn5R9HiR/SkqzXCAowXWx9DmgQAdMiXvQRTrm+T7a/Zv/uMkWHsQ/XDc26O3LtuS
 X684Ei0TQ+qvoflEJlakMniWn7jrJZCEB8U751sJlRq3Q8hNHmQIVgKY23TttOSjCCec
 nSTIzTR7b/y5IWiDx1XWySXjHhNEX7XAVi1Vzc3sL8YVycvdSIo0Dr0cQjSCdm7CZXDG
 9PVSsl+fo1HMDc9VAemKr0xXUpILvYj3nIKppL7KqzcVVfgrx+paByRXOsSsM4UeSQDX
 cKKUuA4mqz3SDQawzBgTyVZmJcQMvnC6qSSCTB4d01kJ5P1VYaSFyRnUYPxPZ8321woD
 8PwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778144358; x=1778749158;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gGRZ28sR+VxEZ5C73+RuuigjMnxpYWGNS100EvozcLs=;
 b=figp73GPNiHLMeJYrjTkmazx6b8dLlPiVVweN/NeMfqWsm9qZIs9ljN1zIEvOCAVOB
 +/o0drugQMyrn3S/x2LsF6ThfahsnqVJ1ykaliIwbUUiS9U0Z+QMATyRYM6WHloGa5ed
 d7JVdQbYddRpZomrfumQmcBAVoxhFBrAH6U5+P0T/bIyRncWx82IbYWTIaG68ZfydzuL
 j29DRrxhpdootWKqyMNIYc48UOW5iJpFSg2tKv0qnuHqwR9/MBTn4g6oQYjNdsJe4e+S
 2LmhPJYfmwtAValoEYo5XgCcer9lo+BF+G9xGqjFr5TnEJBlEpYTt7sWuMH0fUrC1cYo
 iK5g==
X-Gm-Message-State: AOJu0Yy7YpvvACDOjA9d9VfaTjSXrKVWhg+S7th1iXx3QTpRSroNMB/n
 PeoJYKApeB4VM7xsxtXfWRF2gq2pfynIVT+g9iEGsY/7IVcNiRmaFpVSiLnEilgaThBHElxKgCY
 WrKyeni+2ZH1BH+7udBPm5O/IBOXR5dPx/N32UvElXA==
X-Gm-Gg: AeBDieue9uuCLQ1C3xKkYCx1CpM5y1ASe18QonmSpeH0hG9Qo3WE1ycpcvtdeTfdU2F
 3vSEmQghKfOuVu3V+BfP7O8rFi7iVh9gK73RuugHvOVE7i6sz02WYdqaOBIkI2/6ZOBWLbBhCJo
 kpPBtzkbYjVvtZVeVhqnCgSdLY3wwtlWXsoZubPppkCImtSbXP9k329/PQdrPRfuFFsyfON6i91
 rxHoKX4FEmIVs0dyjCfdyqyqzdVKMfpNEMScAB74+TAfOb4aNEqMsETkmhz6ZHsNFqUdIHzoFoT
 NWJYfB9+hDrJDKB6x7s+vnLH0Fhvq3ZcWGYqEFDkHiAsklJhjKTnSKezeOp04+sUXo07ReZoPog
 Ugw==
X-Received: by 2002:a05:690e:134b:b0:653:61a:2cd with SMTP id
 956f58d0204a3-65c79b1f050mr6856243d50.16.1778144357733; Thu, 07 May 2026
 01:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260505170105.228162-1-alex.bennee@linaro.org>
In-Reply-To: <20260505170105.228162-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 May 2026 09:59:06 +0100
X-Gm-Features: AVHnY4KC6hYbjCnF6Az1jfuYawA6hOWCVSNgA0D86neVGNh-bmfk5XzmKiwY2YU
Message-ID: <CAFEAcA-oL9qJ=oXbmCZ-b9jQcv8PNA26irDFA+_yCHkqEMLC1g@mail.gmail.com>
Subject: Re: [RFC PATCH 00/10] AGENTS.md and associated skills
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Tue, 5 May 2026 at 18:03, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Not withstanding the current contributor policy there are a number of
> areas that AI agents could be helpful for. This series introduces an
> AGENTS.md file which is the basic guide to the source tree and a
> number of "skills". Skills are like scripts except far less clearly
> defined. However I have found the issue triage skill quite useful for
> off-loading the drudgery of going through stuff by hand. I've also
> used the issue helper to automate the task of starting a debug session
> by pulling in test cases from the tracker.
>
> These originally where a set of skills for ECA (eca.dev) but I've
> ported them across to the agent agnostic .agents directory. There are
> still some cases where the ECA heritage shows through though
> (specifically the code explorer skill could be better).
>
> I'm not suggesting this is ready for up-streaming but I'm posting the
> collected set for comment and I'd be interested how well these hold up
> across different agentic systems.

I guess my overall comment on this is some mix of:
 * how much of this is generically useful as opposed to
   stuff that's personally helpful to you and should remain
   part of your local setup / preferences?
 * how much do we want to put into git to start with?

I'm in favour of starting with an AGENTS.md that says basically:
 (1) "don't generate code for upstream, point the agent user at
      our AI policy"
 (2) "if you're looking for security issues, read our security
      policy to see what is in scope and what is not"
(in whatever language appears effective)

and then perhaps adding more things gradually where there's
a consensus that they're broadly useful.

thanks
-- PMM

