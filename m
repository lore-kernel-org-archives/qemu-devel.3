Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF3DCA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 12:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xER5M-0008Nz-Rb; Wed, 07 Oct 2026 08:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xER5F-0008M5-OL
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 08:49:25 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xER5D-00062C-UD
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 08:49:21 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-677b5148acaso1741906d50.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 05:49:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791377357; cv=none;
 d=google.com; s=arc-20260327;
 b=r1yRlngO7Y9mt4MW1eBu9toxRwLcdVxFv1jBDMI14JPUqFu0Ao8/e2GDSmeGdWurx8
 2MSvE/Wd7vQMGzvGyxbTvXxHtfmYxRRwDFgo23XGb0tur2ll9tP7KVe4heY5FHq1sFPT
 DY/y3yQ5MmCO486jEP7Hzn4Wt/eDOpey1SWzhl5WFZbcIfote7POQAFULpDYgqUf7CfN
 d0LSOOFff6RTzFVIgoSzfyWHh+asoX9LAwj56mr08lRZ2Wj7Zf04Z9u0qnaeLi18fgze
 V/rsc8XOSyMhOG2m6rgE/al/cieasJDqunRDmMcW5PzoVfdXFsyXBDohWB9+ppqO8TvK
 uYWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=R2BoU3XEBISl6YKdYiPiNymMCWepUOJbwJbVJGJfbUk=;
 fh=rc5hG+yrAU1LC3mf7zy8m/XrVRdRKZTrgF3oKBoLHQc=;
 b=nGPANo2eN2DFZBwsYt0pNrIPVS8YE9Vg6SAUNoFPZdOYecSvjyE+cVNqGW843Dk6Lo
 F2B6QmMEWZZg1Fk9+99+Lgt/7tNbxMI3v0kNLltUzAyS8UeU11xZKXBf3YhRSc2fBuiI
 wBriDnwVxOYDO9KHOkISBKkgAXQqv17MPBL/EJNN++F560th+Wk8x1y3hos3rpV2Lzkl
 ieUsPvWhlvI0su41g5anhaMJN2csh46XOM2Qgb4QNJ9L+Rbd/ceIYCR2IQqjkr00om7T
 IZeAoA5sD9cHKszpWlz61wBJ5+6cMBlos3ayFKCVYwn0O7skpTUe+KmtYdsoUeNprsbZ
 Ccmg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791377357; x=1791982157; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R2BoU3XEBISl6YKdYiPiNymMCWepUOJbwJbVJGJfbUk=;
 b=HTVS2xZaozmaOmb3o1q1dEgBi2smLj9/fxmOy7EPRYPQAh+9G6mB+4AQim6T/Ysyd1
 tImItbBuCBABIdfLFu1RJ9vsMq1hWmhc/8Ua7RYTRzyX1ZuPB58IH7Eg4DEf+0KQqIqt
 KQEI+7TrJpR4hNeswuLUsmh09RrkWrOsIwGtv8RIqzFkcynj6NOAttEWpl+tqpWJLXxA
 FpFS9rsratKfMRk1HQGqCC/xyNmXlw76QufEKxFpXtig6wLPd6X1XbQtYr9nBCiNwW66
 vzesoBl8FjmKaSPRzr9CiX3205lSMpdqWPztNwIn8SvKIur56IlOHMEtEVwz96Y96Xop
 FG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791377357; x=1791982157;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R2BoU3XEBISl6YKdYiPiNymMCWepUOJbwJbVJGJfbUk=;
 b=Rdrg+8HIldagb25KMsJQd6HD0TUKmJrby5ibkAlug/8iTsUohdDb6YHDRIhnWCYL3P
 qQkmdagA2nUf5pc5wBB7gZFXQdZlMx0pKmDLJ9Tvt0jGvPsrB/3YzY22iu6dvUrpM9oP
 oz0GeSbit7+3BdmluA1tCuou7D9+QuLnKERIpwgyMZFK26W/52n0n+u2BLewUMUXoZ0z
 5P96vPoenP4s3AScpuacIXRsabcfklbDbaecZuOXPwL9TO2//W9GW3jnZ0WeJgG26ao1
 pFcPqLMGBrc/bk8dPLAN0eIiNLG/NGqaRkS+oSH7Or8f7Toek2K90at2k5MpEVxja/J+
 h9sA==
X-Forwarded-Encrypted: i=1;
 AKwUvByaGz1cMODR+tLlzFBr5H1DJk+9or8MOU+5QLU7cRiEaA33YFiz8WhY304mlaK44lNDCC7773ISMlyJ@nongnu.org
X-Gm-Message-State: AFq9FYLfDcNjAPOmBk5thoMngUymyMEfDFIlsG+3FlwY9Loe1mDWJl67
 3Qn4OVYZOTHJydOG1i8bCS5w8RWR85LHBrkCaW5f1XYGd+bmb72V8hNEDeDNBcSpp3WqMkBwzjW
 yDsJSxTq0I8Pxk39q4k3GSX/+BULU84/Azi4KFFEXDA==
X-Gm-Gg: AYBFou3qL9WFJnsDmwcb8zSW6rMZEblLWZy7VdL7fmOE6nWgGCywazboEoVXqTsfr4k
 4T6EFwkUaIPCivqLvpUwcC83YQrT3/OhKEBK8YTmM7Gnb79zo58Gq4ekcDybPvSj8tmvacvH3ci
 S0LG0yd3e7YTd7E51e84S8L9xokuXlNYn6CqqDYP6fejFOkiWnKgSBnVQP4a8YabGM0XAWt5hgT
 pOVYqUeJqf82VMilCmzW+yT7MlbT2tmtK61FYFd3MVue6z3GAgOGAvHxXmj382iKxflaqn79tQD
 fV3z9jTQYXPxHBl0XW0HXrX5OM36lQrwGsN4qp8krZ2VQieNgdjK1p5CBavHoC86aZBfz16uj/R
 WUZtHh2YVHF7puyDZ5slAPpmnViAoPU+Sa03Q8KI=
X-Received: by 2002:a05:690e:4197:b0:677:c52c:9c47 with SMTP id
 956f58d0204a3-6790a457495mr1104695d50.136.1791377356613; Wed, 07 Oct 2026
 05:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <20261004090500.3082641-1-bin.meng@processmission.com>
 <20261004090500.3082641-2-bin.meng@processmission.com>
 <CAFEAcA_U-Aoo1MmvAm61_HxhbA+1A-YX1g+oh=1THsi9QKBeOg@mail.gmail.com>
 <CAEUhbmWxS3XRfP4-Uj8MuMoeBb05YCyhHAzJc+_My6kj7L_qKA@mail.gmail.com>
In-Reply-To: <CAEUhbmWxS3XRfP4-Uj8MuMoeBb05YCyhHAzJc+_My6kj7L_qKA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Oct 2026 13:49:05 +0100
X-Gm-Features: AclHuK-YcxSX-08uOhRkB6sdmLOVkJGjrnvgM5J94oEA0f7-LKUhkXZwXWZClwQ
Message-ID: <CAFEAcA_KfCt-K3jb1+AzM74FH7x_ZfuzT7puJ4S=-p_C8SCQVQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] hw/cpu: a15mpcore: Model the reserved page as
 RAZ/WI
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Wed, 7 Oct 2026 at 11:09, Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Peter,
>
> On Wed, Oct 7, 2026 at 4:41=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
> >
> > On Sun, 4 Oct 2026 at 10:05, Bin Meng <bin.meng@processmission.com> wro=
te:
> > >
> > > U-Boot's shared i.MX6 identification code reads PERIPHBASE + 0x4 on
> > > MCIMX6UL-EVK. The first private peripheral page is currently unmapped=
,
> > > so that access causes a data abort before the console is ready.
> > >
> > > The GIC-400 register map reserves offsets 0x0000 through 0x0fff and
> > > specifies read-as-zero, write-ignored accesses to reserved locations.
> > > Model that page in the private peripheral device.
> > >
> > > Reference: GIC-400 TRM (ARM DDI 0471B), sections 3.1 and 3.2
> > > https://documentation-service.arm.com/static/5e8f15e27100066a414f7424
> >
> > The Cortex-A15's internal GIC isn't a GIC-400, as far as I know.
>
> The Linux kernel says it is a GIC-400 on i.MX6UL
> https://github.com/torvalds/linux/blob/master/arch/arm/boot/dts/nxp/imx/i=
mx6ul.dtsi#L158
>
> intc: interrupt-controller@a01000 {
>     compatible =3D "arm,gic-400", "arm,cortex-a7-gic";

Ah, is this a Cortex-A7? The TRM for the A7 says

https://support.arm.com/documentation/ddi0464/f/Generic-Interrupt-Controlle=
r/GIC-functional-description/GIC-memory-map?lang=3Den#CHDEBJAJ

"Access to reserved regions can result in a data abort exception to the
requesting processor."

I'm not sure why that vaguely says "can" rather than "will", or
whether it's significant that the language is softer than the
A15 TRM uses.

In any case, I think the DTB compat strings the kernel DTB uses
aren't necessarily indications of what the real hardware is.
See the commit message in kernel commit 61efb56e30:

    The arm,gic-400 compatible is probably the best matching string for the
    GIC in most modern SoCs, but was only introduced later into the kernel.
    For historic reasons and to keep compatibility, some SoC DTs were thus
    using a combination of this name and one of the older strings

[i.e. "arm,gic-400", "arm,cortex-a7-gic"]

Kernel code correctly using the DTB binding will never touch the
reserved area, so it's not important that the DTB binding be able
to distinguish whether it faults or not.

> > > Signed-off-by: Bin Meng <bin.meng@processmission.com>
> >
> > RAZ/WI doesn't match the documented behaviour of the Cortex-A15
> > for this region in its TRM:
> >
> > https://support.arm.com/documentation/ddi0438/i/generic-interrupt-contr=
oller/gic-functional-description/gic-memory-map?lang=3Den
> >
> > "Read access to reserved regions results in a Data Abort exception to
> > the requesting processor. Write access to reserved regions results in
> > the assertion of nINTERRIRQ."
> >
>
> It seems the A15 manual and GIC-400 manual are contradictory. I am not
> sure how to proceed.

Do we have real hardware where we can check what the actual
behaviour is? It's not unknown for TRMs to have errors, especially
in areas where the documentation is really saying "don't do this"
and the question is what exactly happens when software does
something it shouldn't. If we're confident the TRM documentation
is wrong we can follow the actual behaviour, as long as we have
some clear commentary about it.

Also, has anybody filed a bug against u-boot? This is clearly
a software bug to be trying to read this address at all. We
should record that bug issue number in the commit message here.

thanks
-- PMM

