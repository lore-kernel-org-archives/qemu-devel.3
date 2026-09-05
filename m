Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3073FC624DB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 03:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2hFz-0005LQ-RN; Fri, 04 Sep 2026 23:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1x2hFy-0005L9-V9
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 23:39:54 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1x2hFx-0002iV-DO
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 23:39:54 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-66c7127a73dso2444086d50.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 20:39:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788579592; cv=none;
 d=google.com; s=arc-20260327;
 b=HmdRmrIVp4kvEO7QlXTcNeCxFOJ+ienIhh8Xkv/5x6J/zJUjdtocF4peCbIEMRpMFC
 7/TQ/bv/CGAC5xjc04Nd8MMQcqo83/l/5PQWjJEsmEWM2L7CwzE87J7s2GyPpYr5tsds
 ElCMonhH+GfrWSia0b2uc8ebxsMsfe1CW9aDi/Ju94FsfULkFt0CxlWSMwOHABiY/+u0
 1y+ojpnbBZSqDQgBVUvq99JFwQcsuzLT7MEsDNGtilNuMHy/SjCqdBNzHOV5kC8cS+It
 t/p1SZOTSbpa7DdPua5NHXKWrpVxHrNzZamLIz6eFirRURKWINL67nVBdlS6ja8lDTXE
 qT0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rzbwC/ilmvK8jnnL7I9sI0lsBoFFsh2E9mngGh+h4bw=;
 fh=XC/mZUE8zvZZmrK4c9AfUtCT4yUyMrejdNTZ8kkYNSo=;
 b=jJT+Cr6RCRj+EukRpWcop2eTixNGSmE/9hV19gkP0GuybCTOjE9rncrT42fCZWXF8Q
 uFzjrj/n8q4kASC/MVWgwTm2CorFdMskB94xBHXh7Wq7f6F47ifDHbapimcXZwnoomjD
 SZ9RNJwGhKbeDSEv/nkBi+FulKHXB+hIz34FGyyWKfmj+0NcOR8RbcerNWv4acXFmHQk
 nqDVrQXoVysAJHLOkm5yOCQBbcudrKSRa2A3bTUFWXsU2lUjPPxQF/X/4nGYhjS0Ht0O
 D2MGARdFxNuV9Khv153CfoAdwLzxvuFlXgv7E0EjhZ9KccOUOQfHVz3Zb1i+jw93suC8
 JRaQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788579592; x=1789184392; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rzbwC/ilmvK8jnnL7I9sI0lsBoFFsh2E9mngGh+h4bw=;
 b=oxx8dGPQC0dw7MuMU/DFbNDG1ResInLp/EVISYxNowoPcfX2p1eF/BCVLtN4mldxFc
 YDQmOrL2WDgW4w3qC4r++D/BoG5gyV9z5bYI1B9CM64ogm9Tfb3UWRDxFN2OU6ojV+6P
 3hDwjWkTH73XG17GKRDFaXovMy88JwBtGNnfOxXrIYIk484HCvg8oZs4iEkc5mLv+EgR
 2gDDRyh+5Mlj4UREcpOuksC4BpnWyO6l2ZUUT8RFyXXdtDeZjxPT/TLTctaVReY9Z6W+
 KCWT8SebdxICuK8tVjfABfgd2lexCGKz01zQw2GSVT8uewmOhLWesxqSkqh2OvQqCjvq
 AQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788579592; x=1789184392;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rzbwC/ilmvK8jnnL7I9sI0lsBoFFsh2E9mngGh+h4bw=;
 b=K5TesyrmgpyeelBDhcdIiYeTPjHbrmxdNhOV9d2RT0Ab8/myrBROBWUyja1Pydsst6
 NIgod/+cCA8lUFhs8Mnsjz3pwJLt0FjwygdH9amP/C5zkC0re32SfJjLKEthWZI7UjUd
 0pL6khsBvKvYI6fTlysWZLjaLDsDMt7mR1UzvCKbXxJdPl+0TEofTY9xcTfRQwAA97Sb
 LQdIcA40Slvm4q+kCeX3cDfpo9SqC6L8IfCAosdnBsdLhtUxaN+XKBS35dwBm0jRB5HA
 eBFqvubhFv+KHU+Ka00WSsQZ9N87J+5SQZauf3GZAfPFUcB5ll2cSTFUU7EXpek2fg1f
 34Ug==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJ3kDnM3S3wCSoqt/evJPz78U/6lBrzP39rlhKdC2mqjfBiHEwe0PrQ28FfTmH7lJP2oDmMYSImsw4@nongnu.org
X-Gm-Message-State: AFuF++kvYGi5RE6d8sfbh4dGdNjIcxyBWFKHRhjJlGB9CScf0kwObBYk
 IqQDMeIIrlSypDDgFsrpv58VkivWLXf3ZMOrmyCqP1AD8bfhmXiZ7KEFbFCQlBXeZwrcWjzF/R6
 fmMKCVovxoO2r5DdnHk//yD/r7pu9dBI=
X-Gm-Gg: AYBFou0MQepN/ScOauks9LdhvtZFJHRP+DrD8h0ZUIkc8aig2xHL5jkrDTl4IyDwJ1I
 +RaBu3D34GnyDaZ152dmDeZ10cuWaYaHg/4PgibLNV3vxd45Djn+XEcikJm+JX2MC/0d36k5Vi2
 ZurUT1J8NZDPmOR/eZOZ1CyXZX55utNkqsvX7PcW9dv2u2hwVIS4sHKX71mv9ncXWCPdtXPNTY2
 aB/1Iv6x87VeQSnvFhWoFAUiv1CZIldT6aRVsGLxeUddDuyyCG3C6Q8rbMY+ogyLYVKzOxtGntZ
 AZyduMlAAqUjHzeFERZ0Z7N0yZ/GlZgvsmDZO9HStngh
X-Received: by 2002:a05:690c:a785:b0:855:f387:98c0 with SMTP id
 00721157ae682-87127d27776mr43840637b3.29.1788579591883; Fri, 04 Sep 2026
 20:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260903112532.3276678-1-bin.meng@processmission.com>
 <20260903112532.3276678-2-bin.meng@processmission.com>
 <87se3qpf4x.fsf@draig.linaro.org>
In-Reply-To: <87se3qpf4x.fsf@draig.linaro.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sat, 5 Sep 2026 11:39:40 +0800
X-Gm-Features: AcwNN1WTEVDvs7JUX3hpWoNfiCqb5XmV5RroKj4RSGCZC9Le6xo1Dixu7v5-QZo
Message-ID: <CAEUhbmVU6Ccwaqr8xW78+VCc1BHWcjMvpejgbNe8GxWg1fKQnQ@mail.gmail.com>
Subject: Re: [PATCH 01/33] target/arm: Add Phytium FTC310 and FTC664 CPU models
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb132.google.com
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

Hi Alex,

On Thu, Sep 3, 2026 at 10:48=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> Bin Meng <bin.meng@processmission.com> writes:
>
> > The Phytium E2000Q combines two FTC310 cores and two FTC664 cores.
> > Its EL3 firmware accesses implementation-defined system registers
> > while setting up the cores. Using generic Cortex-A72 CPUs leaves
> > these registers undefined and traps firmware before it can reach
> > U-Boot.
> >
> > Add FTC310 and FTC664 CPU types using Cortex-A72 as their common
> > execution base. Provide conservative RAZ/WI and NOP stubs for the
> > firmware-visible E2000 controls that have no modeled behavior.
> >
> > Set each CPU DT compatible string, MIDR, instruction feature fields,
> > AArch32 floating-point feature fields, and CTR_EL0.L1Ip field to
> > values observed on an E2000Q board. The FTC310 reports a VIPT
> > instruction cache, while the FTC664 reports a PIPT instruction cache.
> >
> > Signed-off-by: Bin Meng <bin.meng@processmission.com>
> > ---
> >
> >  target/arm/tcg/cpu64.c | 81
> >  ++++++++++++++++++++++++++++++++++++++++++
>
> I wonder if cpu64 is the best place to model this? The alternative is to
> treat it like other SoCs (e.g. the Pi's BCM SoCs). Was the reason it
> ended up here because you needed access to aarch64_a72_initfn? Could you
> not instantiate:
>
>     soc_base->cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a72");
>
> and then at realize:
>
>     object_initialize_child(OBJECT(dev), "cpu[*]", &s->cpu[n].core,
>                                 soc_base->cpu_type);
>
> or does that not allow for tweaking the CP regs?
>

I followed your advice and that worked like a charm. Will move the
Phytium-specific CPU type in the SoC/machine codes in v2.

>
> >  1 file changed, 81 insertions(+)
> >
> > diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> > index affd87a3ae..0fd2f79bbc 100644
> > --- a/target/arm/tcg/cpu64.c
> > +++ b/target/arm/tcg/cpu64.c
> > @@ -336,6 +336,85 @@ static void aarch64_a72_initfn(Object *obj)
> >      define_cortex_a72_a57_a53_cp_reginfo(cpu);
> >  }
> >

Regards,
Bin

