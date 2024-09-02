Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEADCD13CF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 10:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl4Pz-0002wi-D3; Mon, 02 Sep 2024 06:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sl4PX-0002Hf-Qh
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 06:35:55 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sl4PV-00016O-QP
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 06:35:51 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c263118780so402967a12.2
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 03:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725273347; x=1725878147; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DrO0NN7TpZLbpe+HBSCuoRGUUnzv9V5wyRAMMNfsEZU=;
 b=YsIAtzrk0Mp0WC1+mxPl1DD55tLQDTAqK2HUjKDnmCkP0nFPpJpqrUiFC+5lvgoJNV
 Frx0yV8nJ58S4D6Ng4UejRdpbw5OStpd/IjBqU4Rx9dOiQ4dc+9JnlhBaaIBFKKxtyrk
 7RYsXpf6nleUDF+Cv2B3ySZx1FRJWtCzTOfD2whIfweoqr+xRtSHSB4IOx+5SSrCEcw4
 lU37MOsCG5Ef9DMUw3ffTFWmw3meNPO3v3B5Ov0AlutINrT7oAdHpwdGUqKATL0bFe9M
 D3fn/0l7KmwDJptz0U/hrxwL6sk3b6E7CcCENWdx5iKyThODbSr3CSonXiWeQe5JE9Px
 1+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725273347; x=1725878147;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DrO0NN7TpZLbpe+HBSCuoRGUUnzv9V5wyRAMMNfsEZU=;
 b=i3uZKZSSQGnl8LwWjh6u+6C3Rv0PemJYyZAhWq6C63nt7u/jHJTdJBtAuC7Xa1kqKY
 LGhPOZGhqp1Xxq+hz1zUuJ1o7HrapQRs1xhooFK6ZJ83nDrbYFndGMS/Ep/qlOrvevDk
 +uewb3AGnNEQb656TAhcV3acRJqQP3k2WVfQAuyTXogUNIZQJbOg+x2TR+8fgZGrfvMS
 DJX744Q4zb5XNp/USIRkiuTi0ncRAAuUKuk6CgCRpLGgx3Xhzxxx0qabPRoYuCBQcia9
 Y3ESmH/bG9mAXWDnOcLpZ3psLXaFh2PPKjEHIwYgFVnJAXNnRMb2qmnHfhV21czfMIBE
 CyZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIqOnogTnjfx0bHj4xeX+NrHTfZUT2LLb1IL6iH9BOCVwUsM+vXfsIrE8zUVJuHK+z9FckJdVy/AG7@nongnu.org
X-Gm-Message-State: AOJu0YxR4lWJRWqbBh+JkWE7L1cPLHo9Zle7SCWED/WmCFOWa4k7kNr1
 d+Pq8s11lTVP8+PBbBY4xyI914TkTFEo5g5lZH90VoPaFu9ULXsfdqG+obAxpMViQ2KfOGvXA57
 is1gyIuc9X/vwnpnZ383Z0npvjyBWOkdg/H4dXw==
X-Google-Smtp-Source: AGHT+IEbxZxFAA4AAeN0VR5sa2RzmvdaswtRdfS6t+GR2BmntHwO/d9tsKFbmP69W1JivmXdZ6Rvun7SRURy5WSXTxI=
X-Received: by 2002:a05:6402:1d56:b0:5c0:ad76:f70e with SMTP id
 4fb4d7f45d1cf-5c25f22d8a6mr1440048a12.6.1725273346716; Mon, 02 Sep 2024
 03:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240830184713.224-1-alireza.sanaee@huawei.com>
 <87r0a2cpsq.fsf@draig.linaro.org>
In-Reply-To: <87r0a2cpsq.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Sep 2024 11:35:35 +0100
Message-ID: <CAFEAcA_4E5j-M+iKnivdWJRkYUvXD7R_hq-=J=_=w701xOdh7w@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm/tcg: refine cache descriptions with a
 wrapper
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Alireza Sanaee via <qemu-arm@nongnu.org>, qemu-devel@nongnu.org, 
 Alireza Sanaee <alireza.sanaee@huawei.com>, linuxarm@huawei.com, 
 richard.henderson@linaro.org, shameerali.kolothum.thodi@huawei.com, 
 Jonathan.Cameron@huawei.com, jiangkunkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Mon, 2 Sept 2024 at 11:28, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Alireza Sanaee via <qemu-arm@nongnu.org> writes:
>
> > This patch allows for easier manipulation of the cache description
> > register, CCSIDR. Which is helpful for testing as well. Currently
> > numbers get hard-coded and might be prone to errors.
> >
> > Therefore, this patch adds wrappers for different types of CPUs
> > available in tcg to decribe caches. Two functions `make_ccsidr32` and
> > `make_ccsidr64` describing descriptions. The 32 bit version receives
> > extra parameters that became unknown later in 64 bit.
> >
> > For CCSIDR register, 32 bit version follows specification [1].
> > Conversely, 64 bit version follows specification [2].
> >
> > [1] B4.1.19, ARM Architecture Reference Manual ARMv7-A and ARMv7-R
> > edition, https://developer.arm.com/documentation/ddi0406
> > [2] D23.2.29, ARM Architecture Reference Manual for A-profile Architect=
ure,
> > https://developer.arm.com/documentation/ddi0487/latest/
> >
> > Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> > ---
> >  target/arm/cpu-features.h | 53 ++++++++++++++++++++++++
> >  target/arm/cpu64.c        | 19 ++++++---
> >  target/arm/tcg/cpu64.c    | 86 ++++++++++++++++++---------------------
> >  3 files changed, 105 insertions(+), 53 deletions(-)
> >
> > diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> > index c59ca104fe..00a0f0d963 100644
> > --- a/target/arm/cpu-features.h
> > +++ b/target/arm/cpu-features.h
> > @@ -1022,6 +1022,59 @@ static inline bool isar_feature_any_evt(const AR=
MISARegisters *id)
> >      return isar_feature_aa64_evt(id) || isar_feature_aa32_evt(id);
> >  }
> >
> > +static inline uint64_t make_ccsidr32(unsigned assoc, unsigned linesize=
,
> > +                                     unsigned cachesize, uint8_t flags=
)
> > +{
>
> isn't this returning a 32 bit value?
>
> > +    unsigned lg_linesize =3D ctz32(linesize);
> > +    unsigned sets;
> > +
> > +    /*
> > +     * The 32-bit CCSIDR_EL1 format is:
> > +     *   [27:13] number of sets - 1
> > +     *   [12:3]  associativity - 1
> > +     *   [2:0]   log2(linesize) - 4
> > +     *           so 0 =3D=3D 16 bytes, 1 =3D=3D 32 bytes, 2 =3D=3D 64 =
bytes, etc
> > +     */
> > +    assert(assoc !=3D 0);
> > +    assert(is_power_of_2(linesize));
> > +    assert(lg_linesize >=3D 4 && lg_linesize <=3D 7 + 4);
> > +
> > +    /* sets * associativity * linesize =3D=3D cachesize. */
> > +    sets =3D cachesize / (assoc * linesize);
> > +    assert(cachesize % (assoc * linesize) =3D=3D 0);
> > +
> > +    return ((uint64_t)(flags) << 28)
> > +        | ((sets - 1) << 13)
> > +        | ((assoc - 1) << 3)
> > +        | (lg_linesize - 4);
>
> This is a nice improvement but using deposit() will ensure you don't
> accidentally overflow fields with the shift/or combos. So something
> like:
>
>   uint32_t ccsidr32 =3D 0;
>   ..
>   ccsidr32 =3D deposit32(ccsidr32, 28,  4, flags);
>   ccsidr32 =3D deposit32(ccsidr32, 13, 14, sets - 1);
>   ccsidr32 =3D deposit32(ccsidr32,  3, 10, assoc - 1);
>   ccsidr32 =3D deposit32(ccsidr32,  0,  3, lg_linesize - 1);
>
> And leave the compiler to simplify everything (not that it matters that
> much for an init function).
>
> Actually I note CCSIDR already has some field definitions so it would
> be:
>
>   ccsidr32 =3D FIELD_DP32(ccsidr32, CCSIDR_EL1, LINESIZE, lg_linesize -1)=
;
>
> etc. Although I notice it two sets of defines to account for FEAT_CCIDX

Mmm. Though I feel like we (me absolutely included) are rather
getting into bikeshedding a fairly simple refactoring patch...

thanks
-- PMM

