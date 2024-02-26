Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D97C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 18:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1refSw-0004Mh-W6; Mon, 26 Feb 2024 13:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1refSu-0004M7-L9
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 13:12:36 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1refSt-0004zz-5Y
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 13:12:36 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-55a179f5fa1so4024353a12.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 10:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708971153; x=1709575953; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ox7RWT5STZ3vTCBI8FQXerl7qSXLzIyeVj2PbM8PsiA=;
 b=CWPnGyc0h8/ulrl4t+Y3IoKculsm2pZRWiMDnETmLNS6JOjXvK8YCzFwZD9sE6apiv
 fVEPISBlPR0af79AUtNCDo/7OXSby53j/ttNiU3FGZ9k+fABo9UFde8CDuI7jCp9OCBW
 Nk3JbrC3yLm415Yy4P+75TujZI7zDcb1BNaTwKc2ksAyeBEg37wZ8s8poGAK0EPY0Iek
 OobmGIBjITb2ffugtVRLZCZzBjiICbuUFxFanxA365cbWLSJwaU9M7OR6F+RwcwKve08
 dtSvAWm3ka1cp9Iu8Rxm7YqPpFOPN2Kl054proPyqT1z9mNeSX70twB3m6H+03+9UaeQ
 pXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708971153; x=1709575953;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ox7RWT5STZ3vTCBI8FQXerl7qSXLzIyeVj2PbM8PsiA=;
 b=FFNITnU/Rwse/CaSdLPYh3Ttsm4pbg/WIdJM3MRLuO4Vd/VvkvQtWrXHoF18nW/R4o
 sWoP/ew/aYPnOigmjTReLxtI2oLOX7qST1JIleF66Mjh+zWDgiWhqKhJ2W4jrRhhQ6iu
 sQCzLW9vILl6I14baY+XefKByEMr63GYeIYBw91fo0BXxHBPRmdxxjaB14Lc2ZLyRN1T
 G3gvN0b0g1sK1YlkeBpxPD+rVsfbVXS7fwpNWfLac0OS+Hq9QKAYIyZS3WsddZ+o2Cm9
 CkCnnFFeA9ZJBHYt3YeAW12ZOYp6uqgYV1PqS3lbRo4+i8/cNdE1p93iQ8KMf2CLpW7+
 yiXg==
X-Gm-Message-State: AOJu0Yyv3Ttm0SO6EaXuIXcy6JptW6Nmy6nAlNpJa7OQWMOml1eV5V/p
 d1Z7rU4YfE0AkOZGd6Lrwb6JPQYKVMlBEwS1TRaUVIi698RePrUG8r8LKyNFFKVakeVRrnb+Cv5
 6ddhUTu4/4C4oKa7UEDnsI23NTLCulMw/pHArjg==
X-Google-Smtp-Source: AGHT+IFikLhffpBCVj153CedmGcZrZUDoXmcJ5Lj+Hlw/BZuBYGi3PB2hz2ng8rZzJVdCmvD1kxawlcICbcFbag+w0E=
X-Received: by 2002:aa7:c385:0:b0:566:ef8:f1fe with SMTP id
 k5-20020aa7c385000000b005660ef8f1femr1368683edq.3.1708971153238; Mon, 26 Feb
 2024 10:12:33 -0800 (PST)
MIME-Version: 1.0
References: <20240226174639.438987-1-alex.bennee@linaro.org>
 <87msrndrus.fsf@draig.linaro.org>
In-Reply-To: <87msrndrus.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 18:12:22 +0000
Message-ID: <CAFEAcA8LMroP5H_jd2Vys+Zp1UA5-E3Q-A8jwmx6W5ZJE5zS+Q@mail.gmail.com>
Subject: Re: [RFC PATCH] tests/vm: avoid re-building the VM images all the time
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 26 Feb 2024 at 18:06, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
> > There are two problems.
> >
> > The first is a .PHONY target will always evaluate which triggers a
> > full re-build of the VM images. Drop the requirement knowing that this
> > introduces a manual step on freshly configure build dirs.
> >
> > The second is a minor unrelated tweak to the Makefile also triggers an
> > expensive full re-build. Solve this be avoiding the dependency and
> > putting a comment just above the bit that matters and hope developers
> > notice the comment.
> >
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >
> > ---
> >
> > This is hacky and sub-optimal. There surely must be a way to have our c=
ake
> > and eat it?
> > ---
> >  tests/vm/Makefile.include | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> > index bf12e0fa3c5..a109773c588 100644
> > --- a/tests/vm/Makefile.include
> > +++ b/tests/vm/Makefile.include
> > @@ -88,10 +88,11 @@ vm-build-all: $(addprefix vm-build-, $(IMAGES))
> >  vm-clean-all:
> >       rm -f $(IMAGE_FILES)
> >
> > +# Rebuilding the VMs every time this Makefile is tweaked is very
> > +# expensive for most users. If you tweak the recipe bellow you will

"below".

But how many people edit tests/vm/Makefile.include ?
It had only 5 changes made to it last year. At that
frequency of changes I think I'd favour "always do the
right thing" over "require manual removal of the cached
image sometimes".

thanks
-- PMM

