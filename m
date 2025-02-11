Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9490CC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 15:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thsR8-0001EF-S4; Tue, 11 Feb 2025 10:44:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thsR4-0001CF-7z
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 10:44:30 -0500
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thsR1-0007RI-9F
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 10:44:28 -0500
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e549b0f8d57so4926140276.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 07:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739288666; x=1739893466; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oWOYYEa+6s/NbH3ZPeR9OuuWzJMhNpe0oTscVGP6bVc=;
 b=V0QZdewSOathB8b8lDWVcrhmuiug/oUQXj8c6GGECLFK2KJLwHghhu5mNrf8zacqpk
 W8ERf27TagjT2O0Q7CzzoceRghrXpZYMaKTpso1ZnVViMxB2ZCSkORH1llmaU4RPTk8E
 fOD/pHXqKOLk+w1BkpFxsbrasOy4ILPFIV2zp4XISTYRnXJ59ZVLl/fvChO/rlRZLLmZ
 eJDKb9p3ZAYBQE6Wda9KY3WTETa0ESwXtuUNjwX0TUvc399pmT5wOdo/8GtUfbPeTXbL
 LG7a1NEGlf0SuskuVh5TnOakvi61O5aSLz+ZLYSO/qdRjMm4CzdIZBqcO+6xwqAb4Zn7
 V03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739288666; x=1739893466;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oWOYYEa+6s/NbH3ZPeR9OuuWzJMhNpe0oTscVGP6bVc=;
 b=v5E1TtHJ7x5LTLYOMZIIJPN5ucmb5aqLG9IoE9t0KlbCwX4Vrr5CObfnR2z3mFAJu1
 WnhoNEmGG0D8sl9mkGxTZMEqjcdegSFg8rZwY8dogwmeRbwHtPGyJtUhEYv66YE6gbsZ
 LcTFWOiYuH9K44HpJgSW7D8YAV+yPqv6uLjXaWDBk6hqbbOp1dcRJbOEn/WTcikqD44H
 gEy6Fc3TZuaTxog7L7e2/SK4qCq3YV9xF25jCuoI9f/2rhhgdPV4t0cGaESlnAlMaVY6
 636M/Ru0jRTWUaSt5NzAB+DvFDw+h12NFfuLiNV34+g1q2H/ViudhXkMmA6OJb8WKmAj
 AOVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNuFiDnT1deh6SAJkgAZKGuCSd/EByvpc4mqhK6WX1/U90Dwlk/24O5li2KF23v74lBMNVhbc3OCT1@nongnu.org
X-Gm-Message-State: AOJu0YzFf61FU6jXRX56xjlCm3i1scTFE1DaJf7or8TGZsR7o0LgaVz+
 3IYlVYrZ9SQ5q4NyUkd+Ptz92QUac/ZdB9OgSGB5B8Ufm5148TrExwNKZzduuyKzwJ7r+ADSXuS
 ol/E5BaDF0muznnFd64XjL9MVX25SrmNXbkEuMA==
X-Gm-Gg: ASbGncvZjNqPI4vdWbXX7ljl2/k5KpLxnAhzGdrcwv8MY3DQ9R3jYP5/i0bK7qjb+qH
 DQ50l8e3Pu9p5/1BDZG+bVCPRhJ74fKyr8ckpx24T1eI2LLGazbkD89FDg8txsdKzEmR4j4r/gQ
 ==
X-Google-Smtp-Source: AGHT+IEcQM4m1pJ4IdDJ7qIHjRli/apzMMJXvuiv/2L0e3P+e9Wvq4PFAeSqHSizjpSv9erR7oFadMvEShJvKH3hjgs=
X-Received: by 2002:a05:6902:1201:b0:e5b:43f5:fa3d with SMTP id
 3f1490d57ef6-e5b461ea0acmr15194271276.24.1739288666087; Tue, 11 Feb 2025
 07:44:26 -0800 (PST)
MIME-Version: 1.0
References: <20250127112715.2936555-1-peter.maydell@linaro.org>
 <44f75f64-4480-4cd2-a907-cf0638568e55@linaro.org>
 <CAFEAcA_BF_b8r8cOJVsk13qEQZg0BS5F16s9M6NFLQVHZBfq4Q@mail.gmail.com>
 <27599be5-9669-466e-8e34-4ec0831c91cc@linaro.org>
In-Reply-To: <27599be5-9669-466e-8e34-4ec0831c91cc@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Feb 2025 15:44:13 +0000
X-Gm-Features: AWEUYZlLug6vg8uUi3v3dMnBV8jqUW9o3FIS9K-GNtXu8BRkxpQA_ht1kqFKtVA
Message-ID: <CAFEAcA8RX527GvvxKwCViynqyGA+g_wUbtmaaoyz9Sak2brjow@mail.gmail.com>
Subject: Re: Deprecate nwfpe emulation?
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On Mon, 27 Jan 2025 at 21:02, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 1/27/25 09:46, Peter Maydell wrote:
> > On Mon, 27 Jan 2025 at 17:27, Philippe Mathieu-Daud=C3=A9 <philmd@linar=
o.org> wrote:
> >> On 27/1/25 12:27, Peter Maydell wrote:
> >>> We have one test case in check-tcg which purports to be checking
> >>> iwMMXt. In fact it is doing no such thing: it runs the test without
> >>> selecting an iwMMXt CPU, which means the iwMMXt insns are interpreted
> >>> as FPA11 insns by the linux-user emulate_arm_fpa11() code. So the tes=
t
> >>> prints garbage and then succeeds anyway.
> >>
> >> Uh...
> >
> > It had me confused for a while, because I'd convinced myself
> > by code inspection that we only enabled iwMMXt if you
> > manually asked for a pxa2xx CPU and not in the default 'max'
> > CPU, and then I found this test case that we were running
> > with the default CPU type and which was apparently passing :-)
>
> Any chance we can deprecate the fpa11 stuff too?

I had wondered about that from the QEMU side, but it's
a little trickier than the iwmmxt deprecation because
we enable the fpa11 emulation by default, so it's harder
to tell if any users are still using it. (In practice I'm
pretty sure it'll only being used if people are running
old binaries that used the ancient "floating point return
values go in an FPA register" ABI.)

-- PMM

