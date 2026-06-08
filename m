Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D90CD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWcJZ-0007gx-6n; Mon, 08 Jun 2026 11:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWcJC-0007Yq-Nw
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:54:42 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWcJ8-0002bg-2R
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:54:36 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-66077c46c5cso3852340d50.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 08:54:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780934070; cv=none;
 d=google.com; s=arc-20240605;
 b=TJw99eqSf6XGCSZBv4is/j3Rw857nwiSTsp2r/BdhA1C/AiPE9ruMKUJXo316kD6QM
 hRmkAFe6vJdSyzH62FQ7kNNSqDTZW6gIUmSHRXI1y4hnzF8UgYkXejSxHFMYaWjp2R4p
 UG5yTXu7FDuRCs1eKx+b0xmLGw8Uu7V4/JNHRK6QKdINNxr+2b6S1dEihqJpYtE4UiOL
 Yu4UE7bZ/wdMhY5YLuNl/qowmCfSe8N4PhLUiKIo9JmwOCXFYv6aIcePdSZ9n8Av+4oz
 16EKhthIxlshRok23lAnYiSutbYDtjL8jIiJrPbXzYgnSPkK3j/Yv/Cfd2qqv6q+r2Gm
 ybqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=s2/D3mnSjO7qP/IJ61hhyERcAo/83C6MsnIZ0N9mtts=;
 fh=27JGi1vXTNl9hrhX20mPbsADtWPes3gHon/d+U8mG1k=;
 b=l1KpixhdLaNh6JLFssX4V5a23Olr7O+RRrFelrFAQs7FXsBsOofPXfBTzosQgzOD34
 lGrKqvfK1/o/Zr2W32BcxZQclR8g0gktLNasbtHstG0FJZC+XmSDWQS1cgI56YrVoIsH
 rCd90bKOxdQLP4gX+wRbZgwqBh8N/rckoxvsmFMqd4BV/ku6sUT7t2qvgwgxvgm7x+K+
 Et3C3sagHPBtzAOwHMt8sDtBNuLFXshZpyN9EKziiOH2tMhZtYuPRdeXegK+4efOglQF
 RgI2tq9Z0jOqlb70yg8++345YdoPJHBPYc87SqeSXAI22OSVVgbQENZrh1ggtjxH9IcA
 awhQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780934070; x=1781538870; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s2/D3mnSjO7qP/IJ61hhyERcAo/83C6MsnIZ0N9mtts=;
 b=FH5sMhoUpCejmOdH7hOhBrKPyJUhwHrnjjJPjW2evfFhLW+NZxq15Ztw6eCmxzSfic
 Pah6OmdZmfXBIyoFfb7MRzCT5LduqP3nJnbRz+RjMROOJf8XO4IaL+uSOSmr5sDkkSZz
 hiX1lrQH105AQfAdBV3IXwa8qYuilFzp3JKsk1fRaz9Mn1mT5aCed7wXoJ2GFLzBvzoN
 7Bo+RfCOw72dd45ISLNRCuvOKg9ExHs1wyqzJqXEy1OH0QsHZ2aFMlpMKqrJhgBFlxkV
 4wOW1YjNuRvP8C6c0shJBJprjlrxNMI7bDEELwMd8x5zWcGxW0BNT6yrDDlrrsB3+HCq
 Ge5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780934070; x=1781538870;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s2/D3mnSjO7qP/IJ61hhyERcAo/83C6MsnIZ0N9mtts=;
 b=Efhy2jEhnlwiiSFVoWMlgW6U8OCxn7a7ZrXR+3BMBG7HIlKbTBjzFehOkgNFtCGs/e
 oCB4+0exfUwsdINtNSHNGMOfHV4CLUKOy/1zgjr/wBjJ8gITH5UUxJA7o7AZma39twVo
 1WgV2mbMsAlATZSl49ZiBUfVmYocSuX8GNRW1/QEegPvHGW+SvS6bCLBKgoYHfu1dfH+
 YkX5oTYFf3tWwN6GQVl9E+8qvaqFZdvrY8tkuFw+kt8sSX6ibYxbd0yGVm44tgo9RDp9
 /nCx+WxFPTYwjWAL5sL6YhFX2YXG0ToejBmVfAretnMKsUhp47Qbhpq9pdwYFRGGGQPR
 G1+A==
X-Gm-Message-State: AOJu0Yzc75T+kHAcAwhjMfB3rJDFzCc5SdWWkyoJ4DsEDhjFR7DfhvTP
 JOO3FlgznCyjf8nG8gkapbC5Di1hI1ZfxRU0xXaxKujO7yYq9Z9ckhIx4fd1/5mmEsuC8s+/i5m
 yd1c9lMUipuZJk4jWHyLaMuz2RRIWEF/xDyivxjbLqQ==
X-Gm-Gg: Acq92OFzU1yos3W3nOULxOvIK8muJzRea09QVBvE5lpBFCTRC87A85IdGqlxnnj/Y07
 VJIcCRzLu231NBu9ih4fhdNGCL7+HwazJbGLjNy7x/EJsqBmf/a3Nfx1CXitfwjGj6iyprX6vJT
 EGPNEj33WzdVfUmANStuBte6rU/yC1x2QDyo9FPWrysO2qvwT6jDCtzT3gcSdOiLNdgzTdxnaTL
 +mLd4rr1sQBvKz2YbHSG5FY5PrcGCB4Zb854xMTTe0O0S0V+Jk1Q0pY+YnRz5RB03mXAl7fwj5N
 7bM2oonEjtm2iE3RtTJh9SKQSeG5X5dwC3rgCboKcwvYyfnBxcuc5760iFQ8tdfjUSfNOBrIM0V
 omA==
X-Received: by 2002:a05:690e:43ce:b0:660:9c4e:a453 with SMTP id
 956f58d0204a3-66106e12449mr9133744d50.16.1780934069939; Mon, 08 Jun 2026
 08:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260529082948.363931-1-alex.bennee@linaro.org>
 <CAFEAcA94+mh_pigFDi+tEPRJ416fSWfxsQ1Lj8Byemug9kBp6w@mail.gmail.com>
In-Reply-To: <CAFEAcA94+mh_pigFDi+tEPRJ416fSWfxsQ1Lj8Byemug9kBp6w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 16:54:17 +0100
X-Gm-Features: AVVi8Cfcobky8tPd6t0Cm9SbpBYctPY7IQ1CxUYmRia6Q_QAliEI2uVYwa0G1l0
Message-ID: <CAFEAcA_5uw3z9ePV83Ni1fsVj_m3340i7E2X-DO0=st-ZDqxEg@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] target/arm: fully model WFxT instructions for
 A-profile
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexander Graf <agraf@csgraf.de>, Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Mon, 8 Jun 2026 at 14:51, Peter Maydell <peter.maydell@linaro.org> wrote=
:
>
> On Fri, 29 May 2026 at 09:29, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> >
> > This series fully models the behaviour of WFxT instructions. We
> > already had support for WFE for M-profile but we left off A-profile as
> > it has more potential sources of wake-ups. The main one is the event
> > stream which includes events from significant bits of the timer
> > ticking over.
> >
> > The refactoring from the previous iterations of the patch have now
> > been merged.
> >
> > I've dropped trying to fully model the global monitor in favour of
> > taking advantage of the architectural flexibility to have an IMPDEF
> > event wake up for any reason. We treat the setting of exclusive_addr
> > as such a reason because it indicates the current vCPU is in a ldstx
> > exclusive region and we don't want the guest to deadlock. This does mea=
n
> > the system won't sleep on WFE enabled locks but people shouldn't be
> > relying on QEMU to model real world sleep patterns anyway given the
> > efficiency of emulation compared to real HW.
> >
> > I've written a test case using kvm-unit-tests:
> >
> >   Message-ID: <20260527111822.1563679-1-alex.bennee@linaro.org>
> >   Date: Wed, 27 May 2026 12:18:21 +0100
> >   Subject: [kvm-unit-tests PATCH v2] arm: add wfx test case
> >   From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.or=
g>
> >
> > All patches are now reviewed.
>
>
>
> Applied to target-arm.next, thanks.

This turns out to cause failures in "make check-functional": some
tests now time out. It looks like the patch that triggers this
is the "enable event stream on WFE instructions".

13/79 func-thorough+func-arm-thorough+thorough -
qemu:func-arm-aspeed_rainier               ERROR            36.17s
exit status 1
74/79 func-thorough+func-arm-thorough+thorough -
qemu:func-arm-smdkc210                     TIMEOUT          90.01s
killed by signal 15 SIGTERM
75/79 func-thorough+func-arm-thorough+thorough - qemu:func-arm-raspi2
                     TIMEOUT         120.01s   killed by signal 15
SIGTERM
76/79 func-thorough+func-arm-thorough+thorough -
qemu:func-arm-quanta_gsj                   TIMEOUT         240.01s
killed by signal 15 SIGTERM
77/79 func-thorough+func-arm-thorough+thorough - qemu:func-arm-bpim2u
                     TIMEOUT         500.01s   killed by signal 15
SIGTERM
78/79 func-thorough+func-arm-thorough+thorough -
qemu:func-arm-orangepi                     TIMEOUT         540.01s
killed by signal 15 SIGTERM
79/79 func-thorough+func-aarch64-thorough+thorough -
qemu:func-aarch64-sbsaref_freebsd      TIMEOUT         720.02s
killed by signal 15 SIGTERM


I've kept the first 4 patches, but dropped patches 5-8.
I also noticed a problem with patch 5 which I've commented on.

thanks
-- PMM

