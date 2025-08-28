Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB32CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 08:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urXz7-0002xA-Gs; Thu, 28 Aug 2025 04:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urXz4-0002vS-8M
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 04:27:50 -0400
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urXz0-0006QT-UJ
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 04:27:50 -0400
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e96e1c82b01so428710276.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 01:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756369664; x=1756974464; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f4Eg/6x/m9e+ER1Y74rgIuNm7K7yt8ADIBCmjfcHBAo=;
 b=XZhXLcus6Z8cpDfjybPfrB8DocQ+VoskwE+Ws5qQYlKk6XdwUOdOUnNffuJODKJ4c2
 sRfbsHU5WNmUzfME76Mf3r/UP2zxfZNCee+aK0gBiOrrGJhxkdRhisLyePL5537gauBj
 /gFhCfhr+lt6Apf+vKaj2QqSvVWDRk3JpKzPq0OhZ4MhJGKyOW7kdVPkrUGFysh2jh4l
 +dgqnFVd0bzN2nHklamCIEiDjrny7UuHykAY0X7Sj1uis/zYltNsLe0AVAQxhMuEfTFe
 EGT2kcHNJHTha72IzA8/DifXy+8FTur7MUJcDQVOkxa0NGJUyRmD8JWt8M3AmTk1psOk
 EBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756369664; x=1756974464;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f4Eg/6x/m9e+ER1Y74rgIuNm7K7yt8ADIBCmjfcHBAo=;
 b=n8Kz0fXYuu1ARnjmR5hbBEemgHedx4NLGChsMfEDo8Nzxsz+dp1RfuDN2VcTFmDXFJ
 /V/NrtDccLxbDmPoerFAn1dZ6gSRggeorQZT7Gdh80zJziayaRzO/mLBoTVGKJse0GxJ
 JOkNHe8j+3eu81OnDqiwdaQAgoho82Oe0uaD3UstBMRChHzcAeQ2vBXiS5oPoRMTcw3Y
 NIUc+r51eN4HExgk692hVfx5akvOBXv5ZcQEOcLc/4IIqJV2rKmBvZavTGYFezMhCFcs
 XRQ6QffctkIb0envpflGESaingY7jDFTDjnRvklpT23444BMarnqDNQdkeThAoCfqmhi
 0NFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlo5AsEK+YleYNMR5UFXZ1mGTzlOmdO1Q5UVtBPxwGnnSHtxTAG39eCp7oa5iYeQkLTsspDPfGzGOp@nongnu.org
X-Gm-Message-State: AOJu0YwYGlG7/aP5ZIca4p5NwkNGA2+ENuv50+5awKBjxlnZdxZDSuPd
 wBA5QLmgQB+7CnUATdvQNulnpRYQgcVar/NZUq+oJ66Lfnz3dzJ0lYISL27IFNRyGRjV4o3S+sE
 n7B6RlNfn2UtldFwcYYLBWsLIabOZQULrGsh/aUZgYg==
X-Gm-Gg: ASbGnctdr9k2idShZmFiXA63ouojWQH0ltL3n0M+4LnPngf/H3aitfCHDy4creBJgpc
 rn8Nbt49ubgkyVRBIBiz0hAwWcVH106w5TwKFvPYcwjYg/ZAqAh2qM8Vi/jjTSM6+BweaRIGnhP
 UqjM4ks962dGn27dI1ykvfuriKxXjr6ELqsJU1bnNf6UO8pN81Nk8PE3oJB6MdERbjbEdoKLCvz
 KPbLGrM+xdREOtp7Xo=
X-Google-Smtp-Source: AGHT+IHge415xNSig9bQ10zZibhqpU39MD7aIRvcNq/JejFD03YkCiXM4TqE0tYiHN+KXYSRFfEU6p+1Lop0O/Tk/Qo=
X-Received: by 2002:a05:690c:6f8e:b0:721:5b31:54cc with SMTP id
 00721157ae682-7215b316b46mr28377327b3.31.1756369663904; Thu, 28 Aug 2025
 01:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250727074202.83141-1-richard.henderson@linaro.org>
 <20250727074202.83141-3-richard.henderson@linaro.org>
 <CAFEAcA_ZQ13qMRUQsieJiEPV=ULrDbz8=EJaW4_kw=yEysob0w@mail.gmail.com>
 <87349s4kfz.fsf@draig.linaro.org>
 <3d59d45f-79f1-4701-ad3b-402513ce4e72@linaro.org>
In-Reply-To: <3d59d45f-79f1-4701-ad3b-402513ce4e72@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 09:27:31 +0100
X-Gm-Features: Ac12FXwDYMmTix2gl8Lqkfui396j7Ro6Wf-LNZp8Vl7o1V4uRqgtXpa3r21RFTA
Message-ID: <CAFEAcA9ryysJQK8hxNxpF=00yC=t3==aFqt2pubD3CjM9T+WLg@mail.gmail.com>
Subject: Re: [PATCH v9 2/6] tests/functional/test_aarch64_rme: update image
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
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

On Sat, 16 Aug 2025 at 01:09, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 8/15/25 9:29 AM, Alex Benn=C3=A9e wrote:
> > Peter Maydell <peter.maydell@linaro.org> writes:
> >
> >> On Sun, 27 Jul 2025 at 08:42, Richard Henderson
> >> <richard.henderson@linaro.org> wrote:
> >>>
> >>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> >>>
> >>> TF-A needs to be patched to enable support for FEAT_TCR2 and
> >>> FEAT_SCTLR2. This new image contains updated firmware.
> >>>
> >>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> >>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >>> Message-ID: <20250719035838.2284029-3-pierrick.bouvier@linaro.org>
> >>
> >> I see this test failing in local runs of 'make check-functional'
> >> sometimes, complaining that it can't create the scratch/out/EFI
> >> directory because it already exists:
> >>
> >> stderr:
> >> Traceback (most recent call last):
> >>    File "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/functional/t=
est_aarch64_rme_sbsaref.py",
> >> line 49, in test_aarch64_rme_sbsaref
> >>      os.mkdir(efi)
> >
> >    os.makedirs(efi, exist_ok=3DTrue)
> >
> > would solve that.
> >
>
> Yes, probably safer to add that if we can't guarantee correctly that
> scratch folder gets deleted everytime. I wrote the test assuming this
> behaviour.

I folded the os.makedirs() fix into my copy of this patch in
target-arm.next.

-- PMM

