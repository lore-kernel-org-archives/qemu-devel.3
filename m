Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC1BFF886F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 06:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHc4z-0002Rf-PT; Tue, 28 Apr 2026 02:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wHc4x-0002RT-Qk
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 02:37:56 -0400
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wHc4w-0008Rx-F9
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 02:37:55 -0400
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-2c156c4a9efso15143339eec.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 23:37:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777358272; cv=none;
 d=google.com; s=arc-20240605;
 b=db0CoBbxP1I8Q0AgHKitFDKu61wTr8eoh0H/qPLRhEm8JXK5cpOt76hgubut5F7YGK
 OLGrfEtKeF4lCDGb/aQw3DH1gUWE8C3dfRG+ZSJACon/gr14jjRvdrZmohbga6fB13rD
 Ka+gJClmQtckrHnQzRSGz/GkQcbm9nd2graEA+7Z12n0IGlbTOLkvIVooRMbz3MoCzhJ
 mgBpz7VSU1aKwwyRA/nnmtnZo2ketIbv/QmPYeFRLs4exiP0eUSsE4p7yEiBZPe2U9ML
 m2BdFRIfpoACW0QzuCMo2Peoqnj4INLsGh/j8BfBjJLNzNryFNy+86ZDtnb5JFwP11zy
 PBrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DwnNYWToZtZo3CnfRFPbncCR570CNeme7m91QKrNCsU=;
 fh=s2Dydi+Wu7zyQaN6Y8WUD3LgD/NbTcHsN51+8tC3Wu0=;
 b=FPpg2LPVq1wG62sue8v+8Kr+d+bKsyiMTnbWwPRwhf0O55p+89eyvsGDFJ60qT4yFH
 OGzjP0cZNm/UAycN1dT0HMNRCJU9j4Nl+n1IcrScoCQVX9rsU0cl+2C0YKUpZurYqmx1
 UtBqUcOsNzQlbre8RmaEI0iWKiA6hbRsIiQLw+XDheocJ1J8whilu7eoNKGXiUzgp3XU
 l4nno6w6g7qKoR6cRyJSJjmpA9cCkYMeE+llm1Gj0502lkSA979zMzBm2KHRYcYTowwe
 Xk31N1Wpfhasjqxqr4KXU5Y4v+E1mhOmBNYoBPZnO5eBFMBODLxugXzVuqh2HdCH80GZ
 959g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777358272; x=1777963072; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DwnNYWToZtZo3CnfRFPbncCR570CNeme7m91QKrNCsU=;
 b=UY5imZSL+QJRK3XHJ7hEnhP44uczfFKCYbObUqbGQFpXr/+i/jsiS/LoMzJnmZLsiY
 APOyzUeMVsFFZh5LqUlqu2Y6m63imnWEpT0Jz2OhdRNwgxQhduLWIGRH3lG7ZafJeYx+
 Kp+a1ybTDGk5cM+Ef5oOypYuewdkoN0lllKthrTmmg3+Jd+fYhHPU/x5NUXHtutC6NF6
 fStK5KhrWrV0mgjEgXlk5ys/vbCfzJoC04yz8aS8/qsSfPSTJ0gx48WzolGSL2mUWSGR
 dcXATMTC0h40KrzpjIxtHw2KqQ/fRt+IkDw6P6ADu84GZCmJ3qSVjMQL/8oU5t5/BeXA
 jESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777358272; x=1777963072;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DwnNYWToZtZo3CnfRFPbncCR570CNeme7m91QKrNCsU=;
 b=Ekpxx4YC+XdgURjYwwbrURJwSCgFy4IDIM0uANTdHWJQXlYRA7XLTPHTSpaLxo5+dH
 iF+hrOAD5H5T+T74a/6xfGsBNomGKU8yKOXJSXzXFFGQw9EDzn3bcLMGV9V75jgaw3Os
 dLHd0LWRw8wMV0515QwOoTTP5aH58kfE/Qpd/IRG32OO0eHNFMBcs0Lx3wbXGwiYtfjR
 QuH9Lnq7Xget+Y82VYklTV3VIzDkrjVC5cVP4GfqenMMvo4T+3zVWKg8Ctea0D4Tk6c0
 xwTLgeJqn0WP6w7qy12+OV6cVJUg2Z1OxI2SWEAgm0Rg8KDG37WHQawYxk3qOMEv6fAU
 I++w==
X-Gm-Message-State: AOJu0YzqD7RUZq091J8si7WKpGQnxlllGn3l4CrwLAXE446bWyoOXM0L
 XiFIx12nVyjZs7u08FLUZkMOo6r7KKnwZJWjci1C5v4EXcxpKcdRJxxoIO02KesaqgtvttsYF0+
 su6lBYHs4feSSNizXnXsvSoZZcrbeEvM=
X-Gm-Gg: AeBDiesS+R40HPdT14Y2P9Yqt4ZFHuFQj5OjJdHJ3WjNyMYQaYd63wb3EYU/8NPAvPS
 +zDpW87337b0glLDAWGGFjdP6sdXUh3rHuQxBJx+tPRWgDh3Ab/SGFI7T4Y3z4GcYdrew2o3cxH
 A9CVxf1COEGfSme+8GKpl2QVhpRTAPLc14DG2JwiCavpVUFDz0Z+gR2XZWWAp0JGZJ2YfHVU6ma
 G/TTkhZtGkI8A7Ly+ZpMiL7Zn9Bv9HvfXJdj1Ee1F190052/BdA8W+DGtgrFl6vecEx+va3ngFX
 uIS1Jek0+uV4qhCsFwQIL6fEgXhOnbXemH3mMnsrFTSMcy5XSEs=
X-Received: by 2002:a05:693c:37c8:b0:2ed:e14:e954 with SMTP id
 5a478bee46e88-2ed0e14ea48mr408025eec.30.1777358272017; Mon, 27 Apr 2026
 23:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-41-c413f3605311@redhat.com>
 <CAFEAcA_7LT-gpArvYpabe9UiFPDGDMEsGOTMeivw90SVDjabeg@mail.gmail.com>
In-Reply-To: <CAFEAcA_7LT-gpArvYpabe9UiFPDGDMEsGOTMeivw90SVDjabeg@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 28 Apr 2026 10:37:39 +0400
X-Gm-Features: AVHnY4KtHkkKhqGGlbiImDkCZp65HO3_QH_LyvmTsE4f-uGytyjE2xsjDe5YpzI
Message-ID: <CAJ+F1CJ1u16q+KBqsO3ofYTVERSvLC-w2MhA_oUF_tvd-mPZWQ@mail.gmail.com>
Subject: Re: [PATCH 41/41] qtest: add "qom-tests" command
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1329;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1329.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Peter

On Tue, Apr 28, 2026 at 12:08=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> On Mon, 27 Apr 2026 at 20:50, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > Add a new "qom-tests" to exercise basic object lifecycle. Instantiate
> > all non-abstract objects, get and set properties and unref.
> >
> > This should quickly find leaks and other related issues that are
> > eventually triggerable at run-time with QMP qom commands.
>
> Can we have a comment please that says what you think the
> basic object lifecycle is?

Hmm, what is not clear about the comment above and its list?

> Also, the qom-test already has coverage of "init the object,
> introspect its properties, unref it" -- how does this differ?

It does introspect on already living and reachable objects, over QMP.
It doesn't instantiate, set, or unref.

> Does it duplicate parts of it? (qom-test is already a very
> slow test so we don't want to duplicate work if we can avoid it.)

I wouldn't say they overlap much. I wrote it as a qtest command to
make the test relatively fast (~100ms per target), and easy to invoke
on CLI (-qtest stdio <<< qom-tests). Its purpose is not to exercise
QMP. I agree though that adding a 1-2 seconds to CI is costly. We may
run it under g_test_thorough().

