Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0DC108B8E6
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 09:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3WXQ-0003eF-4C; Fri, 20 Mar 2026 05:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3WXN-0003e3-Vo
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:53:01 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3WXM-0005k9-43
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:53:01 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-64ca6595c8aso351738d50.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 02:52:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774000379; cv=none;
 d=google.com; s=arc-20240605;
 b=QnYExMdmZVoR2mOJmuvumS2Xr0NQjkrh9e+xsIiHlWm9ky1vvG87dvVGMV2YcbtmK/
 XoUthhdveIBemtbSWvYcX6ShQQcdH1qYTvZyynFmVBF1s5R7aKiqYRFnL91amNsYnmYp
 ZSOF0BEkYQklqyQnqiE4o/DBmIYbgcsGw+vytPN/12COfNmytP5ebuq7YJgyo2YNYd8G
 EOqX3ZWnG6FgL6Dj480714tuR/WsGEXp2dirBW08ZFQ2FYzkL4Y8IFGpJvSBkWStwbl+
 KbWKQOkIa0RRhLZXfUYf3zq0dIfYX/vrz21ZvCSThfO8fD9q3Bhg/NP4CeZ6F8dKFqaD
 hIuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KDqOkgTsxIj2pLe4dKikFxZGA6CGw0gaArlIAepaY6A=;
 fh=WibSQDncNgWSyywKvPHAKYpHRJ63hQ7/by0Ly3U6FhU=;
 b=BkV4KAv6LD7sZOLWHBz6pUzI0IN5qiuAyzHP6Fv4DHcDqpzF6Cmc1MzaalqzucmywI
 S5IAL1SzvJZp1YvzHlpbiwO05ldtXn2v7RVct3ePkv9r0aBZDNrpiF3pzzK7yI2TZjCF
 gjJNpxfw5jW/GDnylsoHbV9nzbPuUYTG/1GFUhbiiK1u63xS3u4UIBYMuW2kbXSguVHy
 ylPMW1YXV+kcYx98o+sdHVCB1DZJ3gZrNAcAWSaG4hsW1Z79vKLgv3ABTgdEd/Zoz3vZ
 /CpRJEKQ4EoiLwFh+qmIuLdPy7yznSEetFXoYnLTLoDmKbqSDGYczZulWHN4RIt+ob1N
 1tvQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774000379; x=1774605179; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KDqOkgTsxIj2pLe4dKikFxZGA6CGw0gaArlIAepaY6A=;
 b=pzqK5/11nD2FKNhuBOfO4Vpw/X5uCrhYU7eE4ytXYOiISPo4q3vJNgmNEc5Uxyn9Yl
 OMD9Ds0ED9+WLy6KCs74GwNRUlKcEzrzqUfK3tPmdPt1DLa45qfoBer+KiiQ+i6bp09g
 4CAYWyVuWdccuO4ZMmQHHSHSBD7z8lNqs5tLFZLMQvkI1Pe/tTQZY/T6pfqFfsZgwPfG
 kBNNUHKFr/PB16p8kFyw8fEQ0HsVuTctuE18KO+FwLOHMU+Yu3ZGMdL1CG1/yYuJdkXP
 R9473L1gKZHQovai/tLtQfzNGgEAIOr8Gjfe4N+s5mCpu1URV6Osh7KWfDeTHqIjveNI
 BY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774000379; x=1774605179;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KDqOkgTsxIj2pLe4dKikFxZGA6CGw0gaArlIAepaY6A=;
 b=dl2XcCFg3+FKvsZS9M5n7KFfGl4cAbh2PNV1iltHRF3GMJtpXLcTeBL5CLRIM593Xg
 qDnBseqUW2PM0cJ5063AWuTEuF9jpXAV558KgSDb32QXoU1k9vSWzBD+K84slXsUvtkw
 gCigBEq95C5/zbK7zxwHAREx8EzksLg8IE3d4by32bKGHj3/40gGRwZdEFifnY5uU1Hp
 siduddpLOr5us+AXcLzUV1Q4FYngwVJ9nWAXkeV43NRLz/cCL8tdv/R3yHNtuKn0FDkW
 3ygBlwllcBKQSnKyb4xBi8r2JuL0kyzoXaYm6MRDWnNU9UrZnhHi3UJ6dAFbfdyuhkaM
 H6/Q==
X-Gm-Message-State: AOJu0YzvqYLehQv4Tl64SosdRb4BZ/riBng5WKU7P+65CdmPjM8VM8iF
 h4Tvx0b8KZYY6RYJ1MHyTPu0AkkGxyoP58EGRUfOaCbQoY7/8sQhsfnsNvQ0H1worQ9RHyUNxhK
 375B9cbT8ze8/xbzOx4dT3YwDfIYrInLQl+HMAR7tZS1sLQ7xPjbY
X-Gm-Gg: ATEYQzzzGejvRBTFIxT2Q8/31cgGRz3panuJrWauc0M5CaG2tsLWDxg2kITwZdm0kPH
 pnQDfk6VY4ryLcPBkLLwm39soPFM8Qiv/8VF3JeradyzGl6QbVEC9k4ZpS2ZO3YmgvC3/u/Jub5
 w3ycBj04Sybc0UlreNjQG131bbTjL77iIU1ljYiAyl1QOOA32XlkFtHsRr/JlTkOuxP1sUijNux
 mwgdp6xHKubNhU2RLlv0Ds0j2Jws8bpKrWOtNhui2kTy4d5RCJE7xEujx4ypSHoG2bIXQ4c5pMp
 eqcjtSM/rUrdaRzIBIrZP7FcyOQ18PuYJKDdljLeLfvGqGPCyHr8QQCMYDQ4CPzoUXO2ydDqjWz
 8Wg==
X-Received: by 2002:a05:690e:e83:b0:64e:8d44:5afa with SMTP id
 956f58d0204a3-64eaa705756mr2887083d50.27.1774000378774; Fri, 20 Mar 2026
 02:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260314221529.47841-1-mohamed@unpredictable.fr>
 <20260314221529.47841-4-mohamed@unpredictable.fr>
 <CAFEAcA8v59wSwRvig6NRjWHyvBGY=gPhWFN1B_jD9k+aXqo9Ng@mail.gmail.com>
 <4387E53A-E140-48E9-80C3-721F9C0B9A9D@unpredictable.fr>
 <CAFEAcA_wVD+mMFhwzDyHx1pY_aMtBvdHjZqQoFoniM_JUCcceA@mail.gmail.com>
 <8B799F60-05AD-49F3-8BAC-4D36EBA8E196@unpredictable.fr>
In-Reply-To: <8B799F60-05AD-49F3-8BAC-4D36EBA8E196@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Mar 2026 09:52:47 +0000
X-Gm-Features: AaiRm53oHuu_FAyfnuZav8w0bseS4L158S9D-_DdhqEfw4tbVqL-Z_UE7TvgKDk
Message-ID: <CAFEAcA99pdJAzxNKKVvCDHbvtaQDa-upxH3Kvn1CexpQUgYWtw@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] whpx: arm: enable more enlightements
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 qemu-arm@nongnu.org
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

On Fri, 20 Mar 2026 at 09:50, Mohamed Mediouni <mohamed@unpredictable.fr> w=
rote:
>
>
> > On 20. Mar 2026, at 10:17, Peter Maydell <peter.maydell@linaro.org> wro=
te:
> >
> > On Thu, 19 Mar 2026 at 18:50, Mohamed Mediouni <mohamed@unpredictable.f=
r> wrote:
> >>
> >>
> >>> On 19. Mar 2026, at 19:13, Peter Maydell <peter.maydell@linaro.org> w=
rote:
> >>>
> >>> On Sat, 14 Mar 2026 at 22:15, Mohamed Mediouni <mohamed@unpredictable=
.fr> wrote:
> >>>>
> >>>> Linux uses AccessVpRegs without checking availability and panics if =
it's not there. Expose it unconditionally.
> >>>
> >>> The commit message subject says we're enabling enlightenments...
> >>>
> >>>> @@ -953,13 +953,15 @@ int whpx_accel_init(AccelState *as, MachineSta=
te *ms)
> >>>>    synthetic_features.Bank0.AccessPartitionReferenceTsc =3D 1;
> >>>>    synthetic_features.Bank0.AccessHypercallRegs =3D 1;
> >>>>    synthetic_features.Bank0.AccessVpIndex =3D 1;
> >>>> -    synthetic_features.Bank0.AccessHypercallRegs =3D 1;
> >>>
> >>> ...but the code change seems to be removing one as well as
> >>> adding the three new ones. Intentional?
> >> Hello,
> >>
> >> The AccessHypercallRegs bit was set twice - with the first one being t=
wo
> >> lines earlier - removed a spurious one of the two.
> >
> > Ah, right. How about this for a commit message ?
> >
> >
> >    whpx: arm: enable more enlightenments
> >
> >    Unconditionally enable some more enlightenments for whpx. In
> >    particular, linux uses AccessVpRegs without checking availability an=
d
> >    panics if it's not there, so it's important to expose it.
> >
> >    We also had a duplicate line where we set AccessHypercallRegs =3D 1
> >    twice; remove the duplicate.
> >
> >
> > If you have more rationale/info about the other two we're enabling,
> > that would also be nice to include.

> ```
> whpx: arm: enable more enlightenments
>
> Enable some more enlightenments for whpx for -accel whpx,hyperv=3Don.
> In particular, Linux uses AccessVpRegs without checking availability when
> Hyper-V enlightenments are exposed and panics if it's not there.
>
> We also had a duplicate line where we set AccessHypercallRegs =3D 1
> twice; remove the duplicate.
>
> Microsoft=E2=80=99s VMM exposes SyncContext on arm64 and FastHypercallOut=
put
> regardless of architecture unconditionally, so add those two to match
> that configuration.
>
> ```

Thanks -- I've updated the commit message for this patch in
target-arm.next to that.

-- PMM

