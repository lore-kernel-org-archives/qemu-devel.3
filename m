Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF0DCA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xERcW-0000p7-6U; Wed, 07 Oct 2026 09:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xERcU-0000op-AR
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:23:42 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xERcS-0001QF-I3
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:23:42 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8ae8541a2f0so18650717b3.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 06:23:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791379419; cv=none;
 d=google.com; s=arc-20260327;
 b=HJ0G2Jkh1ebexvW3W3X4B8HcNlNGC2/0G86z3g54z4Li6fHpJB7iAbCg5SzE/X/aT5
 mOYqTnEp7uxiyISVQbZ4XGg9jMs6wyodMYQFo8TQLPJyUYby1ME5Eb+TzGGcQhgLIx9O
 GZrDhK2UgsW5JPRHSlo5rQm2n69/NDtf5zV3DZHrMuj1OLAC7YZRGyheVQ/+t7B5T+BX
 vd8H4qv4AzCZfOV5PmObu5/0f4L7Qok3b+JodqjK5OMRfSTOE8EpfADkdfgWrWEuFCZ2
 tx8s10tf1K0KBtNfMOTN5Yzu5s3HKqCOQkcQmhdWWDJLH5xIaRqv9QOfczUB8PRBC313
 BbIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aUJ5IAi2AORpFFqWJB4T93SJdjQ02ynmxKXHuvOmbQA=;
 fh=bLLXV/PoH1ogoOYBOJONEMKqiD0ji/imS7rWyJEOc8w=;
 b=C2RaBM4r3Wt8JlKRapO+f1AiuTbeCyk6kd9x7F1IquGmS6MI43ngtctA3gX0HtbksF
 /Fn5dTiCrUrDdIcYOHWG7ZAg1m2iW8E9d1+OoZI156ZpAvJDqmF2F2u9+c3rNLc0wFya
 F7riFB33T8RSO1k5wklQrVMTzqdndyxxwZ+Brhor6PreEmvs3EH81Q0E4CH+HW4LhnMF
 xbYi52K089s/5Nzgy0nDV7M+x+qMCrlT3iWoARjv4sdn8tfuLhMdQLK7NlbRLzuSwr0q
 JnoVXF9xG76b/hph6tmuuWpVPB3XS1gjjP4IcIFtpYOZxhokiy/KTwBsWagMbngfchbS
 IxJw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791379419; x=1791984219; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aUJ5IAi2AORpFFqWJB4T93SJdjQ02ynmxKXHuvOmbQA=;
 b=IkyKbsZQZ3r6zzG60INtYB1JNJlF4JitkPdzN8JlhvVKn87Ws9cLQ/BWbt1YHJLcgo
 j5+MaUyMSUnQK2S0TaFlqvrqV5nu0oTYJPNYir9ikFnVdPemexQAYIb+K2Ko/0qgdzBa
 AmVx2PiUkUjkR8VOu2sJORlsDbuD2jMLuD/Ia5VRfMV39SOd8JYzezpdvwQ820JXegqd
 QIedai6hovLR2ZkMa9pafD0a+r1rq6ugtx+Sj9Xu+EIxNUPUnfPpxHHEotbWbLS/YoW0
 YVKQbea4qsP+43D78bwqk2UcXEv/9lZV05xbWcrlWZL3rcFWk0kxKtj/1stPbM73kZHY
 NTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791379419; x=1791984219;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aUJ5IAi2AORpFFqWJB4T93SJdjQ02ynmxKXHuvOmbQA=;
 b=l8H+VeEtFYqi2fDEojmJk4dGqEn51AwhDZCe3cEmDCQzpuFPm5IlP5INfZazvrJ3N9
 AdQEUfTY01ODx0Cqp3/YT0ztBNxSA5pboWDKVRh2vnMSXyfgMO7uiBq02Hgg7CoJHCDF
 VAmeqiaYGcqGRpT2Ihd1/qlVAV5Swl56nJIKuVQ0KWuMKa1HMQmTN1toNfREvVH8XlM1
 cfaEB3Gbm76SBRCXh4yul1+o0hQjcly+GCBo7cMKfOohDEpfLRtFuP13co9G9zJm09SE
 FQMzCxTeiNOLHqe0GmB95MeUl8udrtw758Pgyvn8vzl5quhFrlbOWQd0AlzmsA6mhwAq
 P5/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwkNOmvsnOu8UxGgtZ0hoxAe17ah9eyv8RmN75ZjtNpamzbOUoCgzCVhEoVZhM9IHID6ISqNm6PB8ws@nongnu.org
X-Gm-Message-State: AFq9FYJbuwM6b/Stxpnbcjz93HBtgrAztMOkzmucfd1l7GSLuc3rJawS
 ywGwqVSrvHv9JdewGiPqBCnd4/M01CKjeDzh+pbwSKHoOwFnX/RNTDxmYiG1iGPF13uB8KCAehI
 f1uN6NhXkz5iywlF0uMaB8czGtWQhd80=
X-Gm-Gg: AYBFou3Jb0QXMsoFcRtXZPhXL3Rj7nuC4zQta9ZRinAudgZnwZzPZFJIzJg7N8iqbIr
 fLUQgx1K5mTuUg/vMRFS7egSastIPwH24OHtF91M3obs32Ud7pOQiqV8ZvFi6tLJDmja7JohM0b
 0c+Ma0uMrCC3AogkhOH2QYwglTEAbcSLLmxt9zuCjNj8IemHhHhkI2OGaRJbEqiacNnJm6LV+EZ
 FRKTMlMyOI+iS4YBuPfwjis2TVm36vppVM3YwHZO5ChRyYN2jkWqr1h+iMygDsJOtB7GW2d0QbZ
 /VVKP9QhxW46q4xlOTxhNSa/fqIeUBkuLsMRhfZlAB2z1MYTxNfaFzrPMXfA4WqbrezrZbPL6QF
 3lw==
X-Received: by 2002:a05:690c:580c:b0:887:f4fc:ee35 with SMTP id
 00721157ae682-8b05b01c556mr14046337b3.19.1791379418877; Wed, 07 Oct 2026
 06:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20261004090500.3082641-1-bin.meng@processmission.com>
 <20261004090500.3082641-2-bin.meng@processmission.com>
 <CAFEAcA_U-Aoo1MmvAm61_HxhbA+1A-YX1g+oh=1THsi9QKBeOg@mail.gmail.com>
 <CAEUhbmWxS3XRfP4-Uj8MuMoeBb05YCyhHAzJc+_My6kj7L_qKA@mail.gmail.com>
 <CAFEAcA_KfCt-K3jb1+AzM74FH7x_ZfuzT7puJ4S=-p_C8SCQVQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_KfCt-K3jb1+AzM74FH7x_ZfuzT7puJ4S=-p_C8SCQVQ@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 7 Oct 2026 21:23:27 +0800
X-Gm-Features: AclHuK9ExQ-5XxgAgrc_en-t6L4XHk2apzH6Qu_YUppIP-yU8ZmcSAQyzMqYCP8
Message-ID: <CAEUhbmVm=8Q5Q+yPnKtPEqUcHC5zk6JhopF-Q5nNGcz4tSki=Q@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] hw/cpu: a15mpcore: Model the reserved page as
 RAZ/WI
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>, 
 qemu-arm@nongnu.org, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Oct 7, 2026 at 8:49=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Wed, 7 Oct 2026 at 11:09, Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > Hi Peter,
> >
> > On Wed, Oct 7, 2026 at 4:41=E2=80=AFPM Peter Maydell <peter.maydell@lin=
aro.org> wrote:
> > >
> > > On Sun, 4 Oct 2026 at 10:05, Bin Meng <bin.meng@processmission.com> w=
rote:
> > > >
> > > > U-Boot's shared i.MX6 identification code reads PERIPHBASE + 0x4 on
> > > > MCIMX6UL-EVK. The first private peripheral page is currently unmapp=
ed,
> > > > so that access causes a data abort before the console is ready.
> > > >
> > > > The GIC-400 register map reserves offsets 0x0000 through 0x0fff and
> > > > specifies read-as-zero, write-ignored accesses to reserved location=
s.
> > > > Model that page in the private peripheral device.
> > > >
> > > > Reference: GIC-400 TRM (ARM DDI 0471B), sections 3.1 and 3.2
> > > > https://documentation-service.arm.com/static/5e8f15e27100066a414f74=
24
> > >
> > > The Cortex-A15's internal GIC isn't a GIC-400, as far as I know.
> >
> > The Linux kernel says it is a GIC-400 on i.MX6UL
> > https://github.com/torvalds/linux/blob/master/arch/arm/boot/dts/nxp/imx=
/imx6ul.dtsi#L158
> >
> > intc: interrupt-controller@a01000 {
> >     compatible =3D "arm,gic-400", "arm,cortex-a7-gic";
>
> Ah, is this a Cortex-A7? The TRM for the A7 says
>
> https://support.arm.com/documentation/ddi0464/f/Generic-Interrupt-Control=
ler/GIC-functional-description/GIC-memory-map?lang=3Den#CHDEBJAJ
>
> "Access to reserved regions can result in a data abort exception to the
> requesting processor."
>
> I'm not sure why that vaguely says "can" rather than "will", or
> whether it's significant that the language is softer than the
> A15 TRM uses.
>
> In any case, I think the DTB compat strings the kernel DTB uses
> aren't necessarily indications of what the real hardware is.
> See the commit message in kernel commit 61efb56e30:
>
>     The arm,gic-400 compatible is probably the best matching string for t=
he
>     GIC in most modern SoCs, but was only introduced later into the kerne=
l.
>     For historic reasons and to keep compatibility, some SoC DTs were thu=
s
>     using a combination of this name and one of the older strings
>
> [i.e. "arm,gic-400", "arm,cortex-a7-gic"]
>
> Kernel code correctly using the DTB binding will never touch the
> reserved area, so it's not important that the DTB binding be able
> to distinguish whether it faults or not.
>
> > > > Signed-off-by: Bin Meng <bin.meng@processmission.com>
> > >
> > > RAZ/WI doesn't match the documented behaviour of the Cortex-A15
> > > for this region in its TRM:
> > >
> > > https://support.arm.com/documentation/ddi0438/i/generic-interrupt-con=
troller/gic-functional-description/gic-memory-map?lang=3Den
> > >
> > > "Read access to reserved regions results in a Data Abort exception to
> > > the requesting processor. Write access to reserved regions results in
> > > the assertion of nINTERRIRQ."
> > >
> >
> > It seems the A15 manual and GIC-400 manual are contradictory. I am not
> > sure how to proceed.
>
> Do we have real hardware where we can check what the actual
> behaviour is? It's not unknown for TRMs to have errors, especially
> in areas where the documentation is really saying "don't do this"
> and the question is what exactly happens when software does
> something it shouldn't. If we're confident the TRM documentation
> is wrong we can follow the actual behaviour, as long as we have
> some clear commentary about it.
>

I don't have real hardware at hand right now, but I bet hardware
doesn't data abort otherwise it won't sit in the U-Boot codes for
years.

> Also, has anybody filed a bug against u-boot? This is clearly
> a software bug to be trying to read this address at all. We
> should record that bug issue number in the commit message here.
>

I've just sent a patch to U-Boot upstream (Cc Tom)
https://lore.kernel.org/u-boot/20261007110316.143181-1-bin.meng@processmiss=
ion.com/T/#u

Regards,
Bin

