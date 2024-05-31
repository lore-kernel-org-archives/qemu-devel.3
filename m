Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F66C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 09:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCz0s-0000Yx-De; Fri, 31 May 2024 05:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCz0q-0000YS-Nl
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:57:28 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCz0o-0004t2-8m
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:57:28 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-57857e0f45eso2140959a12.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 02:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717149444; x=1717754244; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e4FQ3vNtU3m1PcRGN45PKbcYE+qV7GC9NH8Mioabx8M=;
 b=RXA5p2jPN15I66bGzMTwkiVInxivlM5/oIflq4FTzMgdvBmvnQt3PfCl5XmPMjUNqn
 /JP5rKH4OI8WiZ2LzkiatEkju8HfghEJB84ByU6pbLEfH42BsIblJsJ9Mobr46b7M/o/
 TZh4akrQnYRGqSn9bobn33vdo2otib9o0UeixAgFHz5ftc7P6kaFMB6LemwYaFypqgk4
 MoVsFKjhILhf9ZS2zyKVWe+JjxzhAWvp1J7Bxl82FBKDMlr+2TyxAHHWIJ0MmuUywQGy
 LE3z2Cnb7L+eL6PmsKf436XxTjxH2L14dUKSX6ZTVxUyQJFm21yG/pZJIXGUVQTkj9Sz
 AB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717149444; x=1717754244;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e4FQ3vNtU3m1PcRGN45PKbcYE+qV7GC9NH8Mioabx8M=;
 b=aRIlYm1vtGtyKUstrLpceF/ZzJ2lMJciZzrgZDyo+1TYocF6Sg8qNSnaSj06GszgzV
 I0RIpdRXvgsTpvpFW4tKu8+cdqHsn+B8LhvHemImgcI9Dg1mcmfJr1H5SUZW+R38gH5X
 jYFKay2D7QmAV9M2+/YJknSK67g+BliJJ0pAMnMTqHfohMkzQLPO9Y3WA+ubhQAadZsv
 cqA1hgm8OnDM2w7NX9HKyU5sIotwhNvG61vWQzYFUNCtBuaAp56lVGrIf69gcgD712Qs
 EVYHoIktzWcRUszXFJvSaAsJJXnX0m1qXbYQLcsZIW64vLBLBf0KVgUH2gHnk7L3iMDn
 SycQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9uUEV3k9llM2JsGJW5TCxRq9XyKmTxSMmHJ+DKzIT7iYO4Ef2ApS4zzBk4xV8Pzp9/UX0DMMov7IPu+7RT5JhIM1cpzA=
X-Gm-Message-State: AOJu0Yxh3x0Jg2fyOE1VskV8R3SADqz1ktb5tPt4fi/CxXJ3uChIVXmq
 h7FMiqJiKi3dSDx30HmP8hnOgbe6zexFj9zwgSIJvKLq0zSic6no8ahCuKjywUoDomrJ7qeh6hc
 9y5tq1H9iHMnmU2/Q6V9FGZDCGUO3z6a67ATmew==
X-Google-Smtp-Source: AGHT+IFXCCTkrJlsppGHHe6DDTrtH7wsSFUJN+Xr/v5fvKqZheTXtChUMxUes/c8TWSwzOCCmgpesO5hsAQSqbJKqBc=
X-Received: by 2002:a50:c8cd:0:b0:579:cee1:9139 with SMTP id
 4fb4d7f45d1cf-57a365b2bccmr1098585a12.28.1717149444546; Fri, 31 May 2024
 02:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <0C6F517A-5686-4BCE-8D08-1CED02CB470E@linux.dev>
 <4e7aa598-1a5d-47e1-aaa3-78af05947eeb@linaro.org>
 <CB05CAA2-9301-45F6-8AE3-A2E27A160CDF@linux.dev>
In-Reply-To: <CB05CAA2-9301-45F6-8AE3-A2E27A160CDF@linux.dev>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 May 2024 10:57:13 +0100
Message-ID: <CAFEAcA-gye9B1yJNKyT0fcZzR7TukNvaQyc7QkKQ_1FUGfAaYw@mail.gmail.com>
Subject: Re: Unexpected error in rme_configure_one() at
 ../target/arm/kvm-rme.c:159
To: Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu-arm <qemu-arm@nongnu.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 31 May 2024 at 05:20, Itaru Kitayama <itaru.kitayama@linux.dev> wro=
te:
>
>
>
> > On May 30, 2024, at 22:30, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.o=
rg> wrote:
> >
> > Cc'ing more developers
> >
> > On 30/5/24 06:30, Itaru Kitayama wrote:
> >> Hi,
> >> When I see a Realm VM creation fails with:
> >> Unexpected error in rme_configure_one() at ../target/arm/kvm-rme.c:159=
:
> >> qemu-system-aarch64: RME: failed to configure SVE: Invalid argument
> >> test.sh: line 8:  2502 Aborted                 qemu-system-aarch64 -M =
'virt,acpi=3Doff,gic-version=3D3' -cpu host -enable-kvm -smp 2 -m 512M -ove=
rcommit 'mem-lock=3Don' -M 'confidential-guest-support=3Drme0' -object 'rme=
-guest,id=3Drme0,measurement-algo=3Dsha512,num-pmu-counters=3D6,sve-vector-=
length=3D256' -kernel Image -initrd rootfs.cpio -append 'earycon console=3D=
ttyAMA0 rdinit=3D/sbin/init' -nographic -net none
> >> do I need to suspect first the VMM, QEMU, or the Image? The kernel is =
built with LLVM, does it matter?
> >> Thanks,
> >> Itaru.
> >
>
> I=E2=80=99m testing Jean=E2=80=99s repo at:
>
> https://git.codelinaro.org/linaro/dcap/qemu/-/tree/cca/v2?ref_type=3Dhead=
s

OK, we should cc Jean-Philippe then.

I'm wondering if this is as simple as "RME via KVM doesn't support SVE yet"=
,
perhaps.

thanks
-- PMM

