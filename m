Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30484C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzI39-0000sq-2m; Wed, 26 Aug 2026 14:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wzI34-0000nb-Uc
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:08:30 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wzI32-0003xB-Ct
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:08:30 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6a374bea882so1763555a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 11:08:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787767706; cv=none;
 d=google.com; s=arc-20260327;
 b=X6JwaPS0DllD67eLW9hwH1z1GRWpD6diyNWCgSXBSKXXU7ZKJjLAhrZY6LEL9SLwJq
 W7k4kj6LUVsrENCHB0W6jjTs3a+IJLVbtXIuOJ4ZeocMO+QTWD8VsTABqc1bHSzikE+m
 vwvO8nDMXKZV3PDKY9eiTCnaQvt60vr2LCb79O9bC97IMjfrtbQ6eDRGZr9+vHqlaODD
 oLpyUwecXs/LHuVdFqLXKoSkrkTsLvlKRenTRwT82iGj7Tw6Aw9G/Jzx2F7ff/ruWnoP
 3I1+ubQ4FpMa0AWliGTS3JRYIvlfGvva6NP+mBShSfpOwxCBxdiIDxkjLYleBke0oDbK
 P7zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vUI2dmumAc/ZuuXwPfR8wUM66u3ZGuEVxOt5lLWRNFo=;
 fh=I1KOidj8ukFWesb+EHjS2tWNMZp4xtQ6n+aeU5MdnFs=;
 b=LR30X2xa7qexfxfvKGHuwGfNtb+OjH1me6L1dw8qRuL9qTb0UQEGlKjxhlbx3hFOxM
 XGFm9v1JIjuFqs5ekZqDrhuahocRS/HmTlPfthvRZu1qP0T9z4KAiKROKatmyIDcFtDE
 H2dK3cnPRxiaLzrffnox8tHM7zAnawBIGoTWDuHowCB/TVTje7apixWnEyRVXpXddJ8U
 WaCDxIzNfSTK7WPjj5tcnRQM5nBOqMO/cuQ7L8heKucp8FH9EbJrwvVbkbMAI+mUVcGm
 29hM5fAuCGCIqpfWvw8Q2V+Km8lX+RfI+kKMgNqYTxOKkEfYJZMNxAJY4vukdf7ogcEp
 pZCg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787767706; x=1788372506; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vUI2dmumAc/ZuuXwPfR8wUM66u3ZGuEVxOt5lLWRNFo=;
 b=DrqRpEPyMu1WV/89NIOvQtiSZpCNU/GykvfCYPgEJwkmE9LY4FxGPcjHlBKdNSo/e3
 HPQWP4wBY4gQc7soV9ybytEKUu2ui+Oi1Mhy/zP2V8OiUyw2yD6NEosg5s3mTEoakD33
 lhuAr+ouM+b7wEtDmfSxIc2ibqU74F+T+gh0M1zlcBaTPRmxlvl6Cm64L6o4jzfhb4S9
 7Ue8vVJL1v+6CxlS5u9AiYZ5IB6nc8o76FhBTzY0H+axEh/LjYbhCQWq0PxmMBkLua2P
 qJjRqldsBVl39u92FKesUH7/Gv2jRFE3z40SEWEd4XrfEE8BIoNfso89gfCdjaX6hwpW
 9zQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787767706; x=1788372506;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vUI2dmumAc/ZuuXwPfR8wUM66u3ZGuEVxOt5lLWRNFo=;
 b=ODMiVsFn1HeYsk/fQHrr5cfVw4pTo0VZk3todnNhBuiC/Tz+9jI64AhA9hMZii1Tg1
 nSg1eJAis6INhysSjrN0lPDLFsOLVtinhfpMTDHTpLB6IA9oTI3+eSjE+J+KaLuvs0JD
 K5r1hcx0m/baZ1kA5+HZNlQ3WUoHTiZaWv2JusWDTvwPazx4lNtjFISrlLGb8bL1zsKL
 boqoS85YvYmeqZrTzOd8WppHtfFyfZAhrucvj9w+465RDJnAgOc+LzGthhBkkPgUMhvk
 VkVfYO2O1yF4VVHxOHKJnUtlQsvJoF/WK14K/B3zwCofqcZJpev8F+iHjLH8H+Mcgnn5
 4CZg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5KKyQBw2DdZ/TpQUEbfJVrnjLZRiII2j1cJrNqnCdlMZVdHaMi1nEAqU0vCTv1JJ8RQV4zSUcxFlA@nongnu.org
X-Gm-Message-State: AFuF++ka4ZTO1o3WQcaRA+WJPDg5e2NWJbuqL0s/QLqpHxsD9LnzSutR
 oVHI/b4LhZOBDy4s6bntY2FRakhkpsm68c2SN72LO09zZ+FleGwc6VFpnv80kU78laHN76F9ItO
 VVWW/nVrLIk0gGjNps2jhMlFjde/9luo=
X-Gm-Gg: AR+sD10ILvXVtVQWr+W4dZiS5xpWI/AsnHeZaOX0cOuF9PFyDoqI6RPorHvvvpWUlQh
 Wrk3lgPj2E3tHyXJO4HovUA/YOazUs7CqhRLYred1pYt0JkdY/YthY/v8G+Cl1s7ClzLhN+MUtK
 kNTQZnpB/LiNjL72OfnjWIh328R+++V6e6G1WiiIt0Kv3TC8x2GzcEizqstY6MymbuF3tTjsVy8
 UGTN4/Z4/ye3BjhdGmX8NF1RIcSCJ4YG9S4Iw2sb6jzZA/INFz8SBGmKeo3Pc3SQnY0vq9+agMx
 aJWw8zq9ilMR/aUKlG20sw6/eWQ3Lq8XV2k5CyX2pCdv
X-Received: by 2002:a17:906:8d8b:b0:c25:30ec:bec3 with SMTP id
 a640c23a62f3a-c2530ecbfbfmr489969666b.8.1787767705980; Wed, 26 Aug 2026
 11:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260823150731.896-1-luoyonggang@gmail.com>
 <20260823150731.896-13-luoyonggang@gmail.com>
 <b9f0853b-adda-457d-94e1-add9bb2a2548@oss.qualcomm.com>
 <ao7jWx-zfmB9AUEb@redhat.com>
 <d7d5e491-430b-4781-8746-eebcc1e4177e@oss.qualcomm.com>
 <c36279c6-6595-48e9-8cad-2896064e9e33@oss.qualcomm.com>
In-Reply-To: <c36279c6-6595-48e9-8cad-2896064e9e33@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Thu, 27 Aug 2026 02:08:12 +0800
X-Gm-Features: AcwNN1XeE7VXxRVKW4BE-0HJijgWwXdHPoAZBG0GotpwqCzKWMeB3Is0fDC15zM
Message-ID: <CAE2XoE8SHaiS7irUanA_kOTj6F2argpPp+QEbYMtjg2xc+aSDw@mail.gmail.com>
Subject: Re: [PATCH 12/12] meson: link ARM and RISC-V into qemu-system
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>, 
 Alistair Francis <alistair.francis@wdc.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-riscv@nongnu.org, 
 Alexander Bulekov <alxndr@bu.edu>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Farman <farman@linux.ibm.com>, 
 Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <17746591750@163.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 David Hildenbrand <david@kernel.org>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Fabiano Rosas <farosas@suse.de>, Aurelien Jarno <aurelien@aurel32.net>, 
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>, 
 Darren Kenny <darren.kenny@oracle.com>
Content-Type: multipart/alternative; boundary="0000000000000e574e0659f71b73"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000000e574e0659f71b73
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I took some ideas from you and improved it to be smaller. I'll send a v2
patches I think it's better, your review concerns are all addressed.

On Thu, Aug 27, 2026 at 2:05=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <
philmd@oss.qualcomm.com> wrote:
>
> On 26/8/26 19:40, Pierrick Bouvier wrote:
> > On 8/26/2026 6:00 AM, Daniel P. Berrang=C3=A9 wrote:
> >> On Mon, Aug 24, 2026 at 09:20:38AM -0700, Pierrick Bouvier wrote:
> >>> On 8/23/2026 8:07 AM, Yonggang Luo wrote:
> >>>> - Build qemu-system (and qemu-systemw on Windows) from aarch64
> >>>>    common/system objects plus RISC-V arch objects taken from the
> >>>>    existing riscv64 lib.
> >>>> - Pull 32-bit TargetInfo and 32-only boards from the arm/riscv32
> >>>>    libs so hw/arm and target/riscv are not compiled twice.
> >>>> - Skip linking qemu-system-{arm,aarch64,riscv32,riscv64} and the
> >>>>    Windows *w variants; symlink those names to qemu-system so
> >>>>    argv[0] still selects TargetInfo.
> >>>>
> >>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> >>>> ---
> >>>>   meson.build | 156
+++++++++++++++++++++++++++++++++++++++++++++++++---
> >>>>   1 file changed, 147 insertions(+), 9 deletions(-)
> >>
> >> I think this approach of taking common/system from aarch64
> >> and adding in riscv specific objects only works by luck.
> >>
> >> That's not obvious from your patch, but Pierrick's counterproposal
> >> below will expose it with a little  tweak....
> >>
> >>
> >>>  From 6261b0c255e1a8f0df2b41928b8dfb365d0fa488 Mon Sep 17 00:00:00
2001
> >>> From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> >>> Date: Tue, 14 Apr 2026 10:56:15 -0700
> >>> Subject: [PATCH] meson: build single binary
> >>>
> >>> This is not built by default.
> >>> Build with: ninja -C build qemu-system
> >>>
> >>> All available *-softmmu targets are aggregated, ./configure
> >>> --target-list can be used to restrict which targets are included.
> >>>
> >>> In case user has targets that are not supported, we emit an error
> >>> message when build qemu-system target. This way, it's not necessary t=
o
> >>> have a custom configure flag, and qemu-system can live next to
existing
> >>> binaries without complexifying the workflow more than it is already.
> >>>
> >>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> >>> ---
> >>>   meson.build | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
> >>>   1 file changed, 48 insertions(+)
> >>>
> >>> diff --git a/meson.build b/meson.build
> >>> index 553df3e7f053..4a31a520d9eb 100644
> >>> --- a/meson.build
> >>> +++ b/meson.build
> >>> @@ -4264,6 +4264,9 @@ if host_os =3D=3D 'darwin'
> >>>   endif
> >>>
> >>>   traceable =3D []
> >>> +single_binary_libs =3D []
> >>> +single_binary_deps =3D []
> >>> +single_binary_crates =3D []
> >>>   emulators =3D {}
> >>>   foreach target : target_dirs
> >>>     config_target =3D config_target_mak[target]
> >>> @@ -4419,6 +4422,10 @@ foreach target : target_dirs
> >>>                    build_by_default: false)
> >>>
> >>>     if target.endswith('-softmmu')
> >>> +    single_binary_libs +=3D lib
> >>> +    single_binary_deps +=3D arch_deps
> >>> +    single_binary_deps +=3D target_stubs
> >>> +    single_binary_crates +=3D main_rs
> >>>       execs =3D [{
> >>>         'name': 'qemu-system-' + target_name,
> >>>         'win_subsystem': 'console',
> >>> @@ -4500,6 +4507,47 @@ foreach target : target_dirs
> >>>     endforeach
> >>>   endforeach
> >>>
> >>> +single_binary_objects =3D []
> >>> +foreach lib: single_binary_libs
> >>> +  single_binary_objects +=3D lib.extract_all_objects(recursive: true=
)
> >>> +endforeach
> >>> +
> >>> +single_binary_link_args =3D emulator_link_args
> >>> +single_binary_link_args +=3D enable_modules ? ['@block.syms',
'@qemu.syms'] : []
> >>> +
> >>> +supported_targets =3D [
> >>> +  'aarch64-softmmu',
> >>> +  'arm-softmmu',
> >>> +]
> >>
> >> Adding in riscv64-softmmu to this list and building with
> >> configure --target-list=3Daarch64-softmmu,riscv64-softmmu
> >> will fail with this meson approach.
> >>
> >
> > Maybe it's now more obvious why our original goal, presented at KVM
> > Forum 2025, was to have only arm/aarch64/microblaze, and not riscv.
> > It just requires more work to have it, and iteration is key. But we nee=
d
> > a minimum viable product to start somewhere.
> >
> > It is still our goal to this date.
> >
> >> Specifically we'll hit duplicate symbols to to taking
> >> different KConfig branches, resulting in building in
> >> both the real impl and the stubs:
> >>
> >>    /usr/bin/ld.bfd:
libsystem.a.p/hw_pci-bridge_pci_expander_bridge_stubs.c.o: in function
`pxb_cxl_hook_up_registers':
> >>
/home/berrange/src/virt/qemu/build-alt/../hw/pci-bridge/pci_expander_bridge=
_stubs.c:14:
multiple definition of `pxb_cxl_hook_up_registers';
libsystem.a.p/hw_pci-bridge_pci_expander_bridge.c.o:/home/berrange/src/virt=
/qemu/build-alt/../hw/pci-bridge/pci_expander_bridge.c:214:
first defined here
> >>
> >
> > There is nothing new here, and we discovered all that more than a year
> > ago. That's why we started using stub_ss more, as it provides the weak
> > symbol semantic we need. It's not the end of the story though, as we'll
> > have to adapt some functions to this new "multi target" world.
> > But to be able to test and debug that, we need to have a single-binary
> > first.
>
> I will try to find time to finish that 'HOWTO convert to single-binary'
> document I proposed to Daniel Barboza and Anton Johansson which is
> structured as "why / how / commit references", that could help Yonggang
> and others to understand why this effort is taking so long.



--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000000e574e0659f71b73
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I took some ideas from you and improved it to be smaller. =
I&#39;ll send a v2 patches I think it&#39;s better, your review concerns ar=
e all addressed.<br><br>On Thu, Aug 27, 2026 at 2:05=E2=80=AFAM Philippe Ma=
thieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@oss.qualcomm.com">philmd@oss.=
qualcomm.com</a>&gt; wrote:<br>&gt;<br>&gt; On 26/8/26 19:40, Pierrick Bouv=
ier wrote:<br>&gt; &gt; On 8/26/2026 6:00 AM, Daniel P. Berrang=C3=A9 wrote=
:<br>&gt; &gt;&gt; On Mon, Aug 24, 2026 at 09:20:38AM -0700, Pierrick Bouvi=
er wrote:<br>&gt; &gt;&gt;&gt; On 8/23/2026 8:07 AM, Yonggang Luo wrote:<br=
>&gt; &gt;&gt;&gt;&gt; - Build qemu-system (and qemu-systemw on Windows) fr=
om aarch64<br>&gt; &gt;&gt;&gt;&gt; =C2=A0 =C2=A0common/system objects plus=
 RISC-V arch objects taken from the<br>&gt; &gt;&gt;&gt;&gt; =C2=A0 =C2=A0e=
xisting riscv64 lib.<br>&gt; &gt;&gt;&gt;&gt; - Pull 32-bit TargetInfo and =
32-only boards from the arm/riscv32<br>&gt; &gt;&gt;&gt;&gt; =C2=A0 =C2=A0l=
ibs so hw/arm and target/riscv are not compiled twice.<br>&gt; &gt;&gt;&gt;=
&gt; - Skip linking qemu-system-{arm,aarch64,riscv32,riscv64} and the<br>&g=
t; &gt;&gt;&gt;&gt; =C2=A0 =C2=A0Windows *w variants; symlink those names t=
o qemu-system so<br>&gt; &gt;&gt;&gt;&gt; =C2=A0 =C2=A0argv[0] still select=
s TargetInfo.<br>&gt; &gt;&gt;&gt;&gt;<br>&gt; &gt;&gt;&gt;&gt; Signed-off-=
by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com">luoyonggang@g=
mail.com</a>&gt;<br>&gt; &gt;&gt;&gt;&gt; ---<br>&gt; &gt;&gt;&gt;&gt; =C2=
=A0 meson.build | 156 +++++++++++++++++++++++++++++++++++++++++++++++++---<=
br>&gt; &gt;&gt;&gt;&gt; =C2=A0 1 file changed, 147 insertions(+), 9 deleti=
ons(-)<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; I think this approach of taking co=
mmon/system from aarch64<br>&gt; &gt;&gt; and adding in riscv specific obje=
cts only works by luck.<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; That&#39;s not ob=
vious from your patch, but Pierrick&#39;s counterproposal<br>&gt; &gt;&gt; =
below will expose it with a little =C2=A0tweak....<br>&gt; &gt;&gt;<br>&gt;=
 &gt;&gt;<br>&gt; &gt;&gt;&gt; =C2=A0From 6261b0c255e1a8f0df2b41928b8dfb365=
d0fa488 Mon Sep 17 00:00:00 2001<br>&gt; &gt;&gt;&gt; From: Pierrick Bouvie=
r &lt;<a href=3D"mailto:pierrick.bouvier@oss.qualcomm.com">pierrick.bouvier=
@oss.qualcomm.com</a>&gt;<br>&gt; &gt;&gt;&gt; Date: Tue, 14 Apr 2026 10:56=
:15 -0700<br>&gt; &gt;&gt;&gt; Subject: [PATCH] meson: build single binary<=
br>&gt; &gt;&gt;&gt;<br>&gt; &gt;&gt;&gt; This is not built by default.<br>=
&gt; &gt;&gt;&gt; Build with: ninja -C build qemu-system<br>&gt; &gt;&gt;&g=
t;<br>&gt; &gt;&gt;&gt; All available *-softmmu targets are aggregated, ./c=
onfigure<br>&gt; &gt;&gt;&gt; --target-list can be used to restrict which t=
argets are included.<br>&gt; &gt;&gt;&gt;<br>&gt; &gt;&gt;&gt; In case user=
 has targets that are not supported, we emit an error<br>&gt; &gt;&gt;&gt; =
message when build qemu-system target. This way, it&#39;s not necessary to<=
br>&gt; &gt;&gt;&gt; have a custom configure flag, and qemu-system can live=
 next to existing<br>&gt; &gt;&gt;&gt; binaries without complexifying the w=
orkflow more than it is already.<br>&gt; &gt;&gt;&gt;<br>&gt; &gt;&gt;&gt; =
Signed-off-by: Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@oss.=
qualcomm.com">pierrick.bouvier@oss.qualcomm.com</a>&gt;<br>&gt; &gt;&gt;&gt=
; ---<br>&gt; &gt;&gt;&gt; =C2=A0 meson.build | 48 ++++++++++++++++++++++++=
++++++++++++++++++++++++<br>&gt; &gt;&gt;&gt; =C2=A0 1 file changed, 48 ins=
ertions(+)<br>&gt; &gt;&gt;&gt;<br>&gt; &gt;&gt;&gt; diff --git a/meson.bui=
ld b/meson.build<br>&gt; &gt;&gt;&gt; index 553df3e7f053..4a31a520d9eb 1006=
44<br>&gt; &gt;&gt;&gt; --- a/meson.build<br>&gt; &gt;&gt;&gt; +++ b/meson.=
build<br>&gt; &gt;&gt;&gt; @@ -4264,6 +4264,9 @@ if host_os =3D=3D &#39;dar=
win&#39;<br>&gt; &gt;&gt;&gt; =C2=A0 endif<br>&gt; &gt;&gt;&gt; =C2=A0 <br>=
&gt; &gt;&gt;&gt; =C2=A0 traceable =3D []<br>&gt; &gt;&gt;&gt; +single_bina=
ry_libs =3D []<br>&gt; &gt;&gt;&gt; +single_binary_deps =3D []<br>&gt; &gt;=
&gt;&gt; +single_binary_crates =3D []<br>&gt; &gt;&gt;&gt; =C2=A0 emulators=
 =3D {}<br>&gt; &gt;&gt;&gt; =C2=A0 foreach target : target_dirs<br>&gt; &g=
t;&gt;&gt; =C2=A0 =C2=A0 config_target =3D config_target_mak[target]<br>&gt=
; &gt;&gt;&gt; @@ -4419,6 +4422,10 @@ foreach target : target_dirs<br>&gt; =
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0build_by_default: false)<br>&gt; &gt;&gt;&gt; =C2=A0 <br>&gt; &gt;&g=
t;&gt; =C2=A0 =C2=A0 if target.endswith(&#39;-softmmu&#39;)<br>&gt; &gt;&gt=
;&gt; + =C2=A0 =C2=A0single_binary_libs +=3D lib<br>&gt; &gt;&gt;&gt; + =C2=
=A0 =C2=A0single_binary_deps +=3D arch_deps<br>&gt; &gt;&gt;&gt; + =C2=A0 =
=C2=A0single_binary_deps +=3D target_stubs<br>&gt; &gt;&gt;&gt; + =C2=A0 =
=C2=A0single_binary_crates +=3D main_rs<br>&gt; &gt;&gt;&gt; =C2=A0 =C2=A0 =
=C2=A0 execs =3D [{<br>&gt; &gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;n=
ame&#39;: &#39;qemu-system-&#39; + target_name,<br>&gt; &gt;&gt;&gt; =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &#39;win_subsystem&#39;: &#39;console&#39;,<br>&gt; &=
gt;&gt;&gt; @@ -4500,6 +4507,47 @@ foreach target : target_dirs<br>&gt; &gt=
;&gt;&gt; =C2=A0 =C2=A0 endforeach<br>&gt; &gt;&gt;&gt; =C2=A0 endforeach<b=
r>&gt; &gt;&gt;&gt; =C2=A0 <br>&gt; &gt;&gt;&gt; +single_binary_objects =3D=
 []<br>&gt; &gt;&gt;&gt; +foreach lib: single_binary_libs<br>&gt; &gt;&gt;&=
gt; + =C2=A0single_binary_objects +=3D lib.extract_all_objects(recursive: t=
rue)<br>&gt; &gt;&gt;&gt; +endforeach<br>&gt; &gt;&gt;&gt; +<br>&gt; &gt;&g=
t;&gt; +single_binary_link_args =3D emulator_link_args<br>&gt; &gt;&gt;&gt;=
 +single_binary_link_args +=3D enable_modules ? [&#39;@block.syms&#39;, &#3=
9;@qemu.syms&#39;] : []<br>&gt; &gt;&gt;&gt; +<br>&gt; &gt;&gt;&gt; +suppor=
ted_targets =3D [<br>&gt; &gt;&gt;&gt; + =C2=A0&#39;aarch64-softmmu&#39;,<b=
r>&gt; &gt;&gt;&gt; + =C2=A0&#39;arm-softmmu&#39;,<br>&gt; &gt;&gt;&gt; +]<=
br>&gt; &gt;&gt;<br>&gt; &gt;&gt; Adding in riscv64-softmmu to this list an=
d building with<br>&gt; &gt;&gt; configure --target-list=3Daarch64-softmmu,=
riscv64-softmmu<br>&gt; &gt;&gt; will fail with this meson approach.<br>&gt=
; &gt;&gt;<br>&gt; &gt;<br>&gt; &gt; Maybe it&#39;s now more obvious why ou=
r original goal, presented at KVM<br>&gt; &gt; Forum 2025, was to have only=
 arm/aarch64/microblaze, and not riscv.<br>&gt; &gt; It just requires more =
work to have it, and iteration is key. But we need<br>&gt; &gt; a minimum v=
iable product to start somewhere.<br>&gt; &gt;<br>&gt; &gt; It is still our=
 goal to this date.<br>&gt; &gt;<br>&gt; &gt;&gt; Specifically we&#39;ll hi=
t duplicate symbols to to taking<br>&gt; &gt;&gt; different KConfig branche=
s, resulting in building in<br>&gt; &gt;&gt; both the real impl and the stu=
bs:<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; =C2=A0 =C2=A0/usr/bin/ld.bfd: libsyst=
em.a.p/hw_pci-bridge_pci_expander_bridge_stubs.c.o: in function `pxb_cxl_ho=
ok_up_registers&#39;:<br>&gt; &gt;&gt; /home/berrange/src/virt/qemu/build-a=
lt/../hw/pci-bridge/pci_expander_bridge_stubs.c:14: multiple definition of =
`pxb_cxl_hook_up_registers&#39;; libsystem.a.p/hw_pci-bridge_pci_expander_b=
ridge.c.o:/home/berrange/src/virt/qemu/build-alt/../hw/pci-bridge/pci_expan=
der_bridge.c:214: first defined here<br>&gt; &gt;&gt;<br>&gt; &gt;<br>&gt; =
&gt; There is nothing new here, and we discovered all that more than a year=
<br>&gt; &gt; ago. That&#39;s why we started using stub_ss more, as it prov=
ides the weak<br>&gt; &gt; symbol semantic we need. It&#39;s not the end of=
 the story though, as we&#39;ll<br>&gt; &gt; have to adapt some functions t=
o this new &quot;multi target&quot; world.<br>&gt; &gt; But to be able to t=
est and debug that, we need to have a single-binary<br>&gt; &gt; first.<br>=
&gt;<br>&gt; I will try to find time to finish that &#39;HOWTO convert to s=
ingle-binary&#39;<br>&gt; document I proposed to Daniel Barboza and Anton J=
ohansson which is<br>&gt; structured as &quot;why / how / commit references=
&quot;, that could help Yonggang<br>&gt; and others to understand why this =
effort is taking so long.<br><br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>You=
rs<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div>

--0000000000000e574e0659f71b73--

