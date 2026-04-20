Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8F4F5A8AA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 19:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEuL9-0005w6-6a; Mon, 20 Apr 2026 15:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wEuL3-0005v3-Gx
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 15:31:21 -0400
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wEuL0-0002wH-DL
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 15:31:21 -0400
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-95697b46831so2074792241.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 12:31:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776713475; cv=none;
 d=google.com; s=arc-20240605;
 b=ccX7mL4wC8ARNSEniycL0E/XRf+ODQA4nb6wqs8FeMWpRh+vL2h2ai4/oAeuGDEglU
 n9rUswtYJ+Cmhj31w/CKvFwr4kQM2qpfaTzy3Q9LUrrwYgTWsTK5pSC9zjWKV9fBErOq
 SEDf6pUbPVOWHOgxEiHF9rD2L6bg+n0e1qtw+lh00WZ1xi5spQPYxSPNk+NBQwpuRODG
 x1yRTTD0w0hZxMxp1MgtQX8INPM/AiRVrLRNSWbpx6+12gKro+i/Rtqjw/F3hphBWHOf
 M74ysDvvgk58gm8cIB6MRSBEHyXuZCbbGHfBQyOQhZKoGkvfft1A2iD5HxiOiGHSSALb
 ZGkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hnzr194xQ3ktNPkZEBspUGd1lZjV62mXOE8HMCHxZLc=;
 fh=zV8LLzIczfe/+fiSHcky8AVtYW6WRmFrGAGu16hG77k=;
 b=HW1m5BLqePSpvg/qodBF0CQNJfMPGQ8hagPebqfO3UPDgJa8IHqS1j5pSpcutDChpW
 mpVT8K/Z+4QXiYzkPyIQJxLmAmw3bJllSFdsejp1I78x1hBJ1iJsW9DJfTHmEJuCr98k
 FMabMVZG3mIZtEPZ11Svw/21B/0Newl34mTDgk5F2+L3h639y3XEDc/hXNXB/Fwsn+3/
 z7kHkkC2rcZuyStZ7/Kn5+ydQTckvWX8HaycGHfvY2xNRqWpvAUZrw6edxbOx1TBTC7E
 20qSdwqUKfIIi0yiSxeQdiKsmZ9Z0THQ0endPCq0GEUuC1JT2qPGFdFEAXj8u8EOalXV
 zdDg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776713475; x=1777318275; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hnzr194xQ3ktNPkZEBspUGd1lZjV62mXOE8HMCHxZLc=;
 b=TLzMcczbclUAIgAP1gHln5vxpfMZMYujkXpHFW6b7O9oRIDcaNvNDZ851yMvlvnU1i
 ANp+zjYH2z43UFGhbLL+TGcAzKQL18U0WbhsfssvP7YTK5IatPAYrGp35CFcPhCRgnaX
 A5vvu4Kxsi6HMtE66bIrDIRQ9arXuVDbe3JWZxdFnYUumYLJ9XX99mXHeeJl12wGC03/
 HTP/GSpDTnLEmn/ETvEVRMsF2EUdRhYqK0gjAx0LQn+o5Yj54SBAgQBiHVMS9x8W0iN5
 W4Iyu6KNP5d6Wjvh4ssToc+9qKBQiHYZrSYYOgBoP/v9RsJxqLVez3VI8pz5u1Hyx6CA
 sJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776713475; x=1777318275;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hnzr194xQ3ktNPkZEBspUGd1lZjV62mXOE8HMCHxZLc=;
 b=FDdAkOuEVl7wOkFrvyNTtQwR5t11kS8NEgXZcS8UthakkRBDngFW8yZrvSBgo9Zbkt
 Jfpb8ia+JTAHT/47XakRFU/HVnFWozDiFMn0eHbGmWJosxTiKalR5RWK9Fqy581jT29X
 +72bRzoepX7fcEjzwPF6Hvan+14vcsII6eeS/mEFuo+tF/rQSIKJxGM4pZJWOYCqlZJj
 CcxgebDGe1e4QGikhfwiNzjZKu10o07/Rqd9tGBvKnghLKtUMsexUGfeeuNswntsYnTT
 mwWQBBXDqN1ZBsaL6r2zHZwvPy97ERjhbvBcEZdyHtJiVOh36Y8PrLaAKr+2LcwlcrT7
 kLSQ==
X-Gm-Message-State: AOJu0YwEVEGHfWKhe0emzumFnjIxjZ7A3qfBJc9g04FhZbyPuBZQgfeL
 +3aIPm9d05Hq2zkJEq9vkXd+qCT6XsO+j0y2VU0n9nGREAW+gDZ6rJE8lVa5/rStbfCsOVCGh5B
 skenV7+RGYEwOow5aObQhwMWv/XUgyYo=
X-Gm-Gg: AeBDies57iokhyQd1Ow3GhkNXHMqLFoEeeKz5hbw8x/aEFhxzN7O9Lzeq+ywj2ujuR0
 mEczZs/qE4jcTyuJv+C9w5AIrketvFLydWkt6yBD0W1mRBkJgbyxhYyihB6Kd1c97bUQx532O2S
 jeTZxKM1TnIO3VAywtXhiIO0Owg1CjfpmQo5rPxrRXl98EvnzS4ipjQddopEHeC+Nc6Os1rf4jG
 v7rjnWH820K9o2sGllt3fyTBlu6hynhRzyX/HtEbsSVJZRBgkZfZbVjohm3OHp7sC7696Tf2Nfj
 FrRPMtVIj1NWAonsi3nCOhVDWIGaXyIhVymSO7oyFf/C2Gb/TAA7j1OQYonxHI+aw6RRsjWYX3M
 YWj7kTIZ63tt49qQ=
X-Received: by 2002:a05:6102:1621:b0:605:2df4:c5dd with SMTP id
 ada2fe7eead31-616f7624fd7mr6474407137.26.1776713475209; Mon, 20 Apr 2026
 12:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260411070637.72421-1-james.hilliard1@gmail.com>
 <20260411070637.72421-2-james.hilliard1@gmail.com>
 <b78cb17a-65fe-4394-8d62-8caa3447065b@linaro.org>
In-Reply-To: <b78cb17a-65fe-4394-8d62-8caa3447065b@linaro.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 20 Apr 2026 13:31:03 -0600
X-Gm-Features: AQROBzAxUQiyjmIojLUBQzXNsjqAE7R-zt_YzmwgSoKfo6RCFMJY-pnQWd88iRE
Message-ID: <CADvTj4oXh8iNk3e7uffR2m9rJDKmrAjVZ-_BbAZ1LEJmR0uniA@mail.gmail.com>
Subject: Re: [PATCH 2/9] target/mips: add Octeon arithmetic and memory
 instructions
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>, owl <owl129@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ua1-x92c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sun, Apr 12, 2026 at 12:21=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi James,
>
> On 11/4/26 09:06, James Hilliard wrote:
> > Octeon CPUs define additional integer, memory, and multiply operations
> > beyond the base MIPS64 ISA. Add the missing decode and helper support
> > for the remaining regular Octeon instructions used by existing user-mod=
e
> > workloads.
> >
> > This covers the indexed unaligned load/store forms, cache block zero
> > operations, the Octeon multiply family, population count handling, and
> > related arithmetic and memory operations in the translator and helper
> > layer.
>
> Thanks for this series! (Please include a cover letter for v2).
>
> For historical background, see my previous question regarding testing:
> https://lore.kernel.org/qemu-devel/a616c83d-068e-46a0-80b7-878425005317@l=
inaro.org/

I have not yet attempted full system/kernel emulation, only qemu-user
userspace binary emulation so far, I've mostly tested this patch
series against a mixture of proprietary cavium octeon binaries along
with a modified version of the cavium cpri sdk cross compiled with a
cavium octeon vendor
toolchain(https://github.com/jameshilliard/cavium-cpri) for validating
that various crypto test vectors produce their expected outputs. I
also validated some of the instructions against
https://github.com/wolfSSL/wolfssl compiled with cavium octeon crypto
instructions enabled.

> We need few pieces of guest code to test this feature, because we
> don't want to maintain bitrotten code.

What sort of tests would we want for that?

>
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> >   target/mips/cpu-defs.c.inc         |  10 +-
> >   target/mips/cpu.h                  |  12 +++
> >   target/mips/helper.h               |   2 +
> >   target/mips/system/machine.c       |  43 ++++++++
> >   target/mips/tcg/octeon.decode      |  28 ++++-
> >   target/mips/tcg/octeon_translate.c | 163 +++++++++++++++++++++++++++-=
-
> >   target/mips/tcg/op_helper.c        |  84 +++++++++++++++
> >   7 files changed, 331 insertions(+), 11 deletions(-)
> >
> > diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
> > index d93b9d341a..6c084fcaea 100644
> > --- a/target/mips/cpu-defs.c.inc
> > +++ b/target/mips/cpu-defs.c.inc
> > @@ -997,7 +997,8 @@ const mips_def_t mips_defs[] =3D
> >           .CP0_PRid =3D 0x000D9100,
> >           .CP0_Config0 =3D MIPS_CONFIG0 | (0x1 << CP0C0_AR) | (0x2 << C=
P0C0_AT) |
> >                          (MMU_TYPE_R4000 << CP0C0_MT),
> > -        .CP0_Config1 =3D MIPS_CONFIG1 | (0x3F << CP0C1_MMU) |
> > +        .CP0_Config1 =3D MIPS_CONFIG1 | (1 << CP0C1_FP) |
> > +                       (0x3F << CP0C1_MMU) |
> >                          (1 << CP0C1_IS) | (4 << CP0C1_IL) | (1 << CP0C=
1_IA) |
> >                          (1 << CP0C1_DS) | (4 << CP0C1_DL) | (1 << CP0C=
1_DA) |
> >                          (1 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C=
1_EP),
> > @@ -1011,7 +1012,12 @@ const mips_def_t mips_defs[] =3D
> >           .CP0_PageGrain =3D (1 << CP0PG_ELPA),
> >           .SYNCI_Step =3D 32,
> >           .CCRes =3D 2,
> > -        .CP0_Status_rw_bitmask =3D 0x12F8FFFF,
> > +        .CP0_Status_rw_bitmask =3D 0x36F8FFFF,
> > +        .CP1_fcr0 =3D (1 << FCR0_F64) | (1 << FCR0_3D) | (1 << FCR0_PS=
) |
> > +                    (1 << FCR0_L) | (1 << FCR0_W) | (1 << FCR0_D) |
> > +                    (1 << FCR0_S) | (0x00 << FCR0_PRID) | (0x0 << FCR0=
_REV),
> > +        .CP1_fcr31 =3D 0,
> > +        .CP1_fcr31_rw_bitmask =3D 0xFF83FFFF,
> >           .SEGBITS =3D 42,
> >           .PABITS =3D 49,
> >           .insn_flags =3D CPU_MIPS64R2 | INSN_OCTEON,
>
> Exposing these CPU features to the guest should be the last patch.
>
> > diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> > index ac81470576..98cd7ae83e 100644
> > --- a/target/mips/cpu.h
> > +++ b/target/mips/cpu.h
> > @@ -497,6 +497,18 @@ struct TCState {
> >       target_ulong CP0_TCScheFBack;
> >       int32_t CP0_Debug_tcstatus;
> >       target_ulong CP0_UserLocal;
> > +    target_ulong MPL0;
> > +    target_ulong MPL1;
> > +    target_ulong MPL2;
> > +    target_ulong MPL3;
> > +    target_ulong MPL4;
> > +    target_ulong MPL5;
> > +    target_ulong P0;
> > +    target_ulong P1;
> > +    target_ulong P2;
> > +    target_ulong P3;
> > +    target_ulong P4;
> > +    target_ulong P5;
>
> This CPU only exists in 64-bit variant, so please directly start with
> uint64_t (we try to remove target_ulong uses).
>
> We usually model banked registers as array:
>
>    uint64_t MPL[2 * 3];
>
> Although maybe having an octeon field could make the code easier to
> follow (like the other octeon_crypto structure you introduce):
>
>    struct {
>        uint64_t MPL[2 * 3];
>        uint64_t P[2 * 3];
>    } octeon;
>
> >
> >       int32_t msacsr;
> >
> > diff --git a/target/mips/helper.h b/target/mips/helper.h
> > index b6cd53c853..3c9f67ec40 100644
> > --- a/target/mips/helper.h
> > +++ b/target/mips/helper.h
> > @@ -24,6 +24,8 @@ DEF_HELPER_FLAGS_1(dbitswap, TCG_CALL_NO_RWG_SE, tl, =
tl)
> >   DEF_HELPER_3(crc32, tl, tl, tl, i32)
> >   DEF_HELPER_3(crc32c, tl, tl, tl, i32)
> >   DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
> > +DEF_HELPER_3(octeon_vmulu, tl, env, tl, tl)
> > +DEF_HELPER_3(octeon_v3mulu, tl, env, tl, tl)
> >
> >   /* microMIPS functions */
> >   DEF_HELPER_4(lwm, void, env, tl, tl, i32)
> > diff --git a/target/mips/system/machine.c b/target/mips/system/machine.=
c
> > index 473d3ab036..1ea5907e55 100644
> > --- a/target/mips/system/machine.c
> > +++ b/target/mips/system/machine.c
> > @@ -118,6 +118,27 @@ static const VMStateDescription vmstate_inactive_t=
c =3D {
> >       .fields =3D vmstate_tc_fields
> >   };
> >
> > +static const VMStateDescription vmstate_octeon_multiplier_tc =3D {
> > +    .name =3D "cpu/tc/octeon_multiplier",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .fields =3D (const VMStateField[]) {
> > +        VMSTATE_UINTTL(MPL0, TCState),
> > +        VMSTATE_UINTTL(MPL1, TCState),
> > +        VMSTATE_UINTTL(MPL2, TCState),
> > +        VMSTATE_UINTTL(MPL3, TCState),
> > +        VMSTATE_UINTTL(MPL4, TCState),
> > +        VMSTATE_UINTTL(MPL5, TCState),
> > +        VMSTATE_UINTTL(P0, TCState),
> > +        VMSTATE_UINTTL(P1, TCState),
> > +        VMSTATE_UINTTL(P2, TCState),
> > +        VMSTATE_UINTTL(P3, TCState),
> > +        VMSTATE_UINTTL(P4, TCState),
> > +        VMSTATE_UINTTL(P5, TCState),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> >   /* MVP state */
> >
> >   static const VMStateDescription vmstate_mvp =3D {
> > @@ -237,6 +258,27 @@ static const VMStateDescription mips_vmstate_timer=
 =3D {
> >       }
> >   };
> >
> > +static bool mips_octeon_multiplier_needed(void *opaque)
> > +{
> > +    MIPSCPU *cpu =3D opaque;
> > +
> > +    return cpu->env.insn_flags & INSN_OCTEON;
> > +}
> > +
> > +static const VMStateDescription mips_vmstate_octeon_multiplier =3D {
> > +    .name =3D "cpu/octeon_multiplier",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .needed =3D mips_octeon_multiplier_needed,
> > +    .fields =3D (const VMStateField[]) {
> > +        VMSTATE_STRUCT(env.active_tc, MIPSCPU, 1,
> > +                       vmstate_octeon_multiplier_tc, TCState),
> > +        VMSTATE_STRUCT_ARRAY(env.tcs, MIPSCPU, MIPS_SHADOW_SET_MAX, 1,
> > +                             vmstate_octeon_multiplier_tc, TCState),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> >   const VMStateDescription vmstate_mips_cpu =3D {
> >       .name =3D "cpu",
> >       .version_id =3D 21,
> > @@ -353,6 +395,7 @@ const VMStateDescription vmstate_mips_cpu =3D {
> >       },
> >       .subsections =3D (const VMStateDescription * const []) {
> >           &mips_vmstate_timer,
> > +        &mips_vmstate_octeon_multiplier,
> >           NULL
> >       }
> >   };
> > diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.dec=
ode
> > index 102a05860d..d90a194b54 100644
> > --- a/target/mips/tcg/octeon.decode
> > +++ b/target/mips/tcg/octeon.decode
> > @@ -30,6 +30,8 @@ BBIT         11 set:1 . 10 rs:5 ..... offset:s16 p=3D=
%bbit_p
> >   # SNEI rt, rs, immediate
> >
> >   @r3          ...... rs:5 rt:5 rd:5 ..... ......
> > +&cmp3        rs rt rd ne
> > +&cmpi        rs rt imm ne
> >   %bitfield_p  0:1 6:5
> >   @bitfield    ...... rs:5 rt:5 lenm1:5 ..... ..... . p=3D%bitfield_p
> >
> > @@ -38,12 +40,34 @@ DMUL         011100 ..... ..... ..... 00000 000011 =
@r3
> >   EXTS         011100 ..... ..... ..... ..... 11101 . @bitfield
> >   CINS         011100 ..... ..... ..... ..... 11001 . @bitfield
> >   POP          011100 rs:5 00000 rd:5 00000 10110 dw:1
> > -SEQNE        011100 rs:5 rt:5 rd:5 00000 10101 ne:1
> > -SEQNEI       011100 rs:5 rt:5 imm:s10 10111 ne:1
> > +SEQ          011100 rs:5 rt:5 rd:5 00000 101010 &cmp3 ne=3D0
> > +SNE          011100 rs:5 rt:5 rd:5 00000 101011 &cmp3 ne=3D1
> > +SEQI         011100 rs:5 rt:5 imm:s10 101110 &cmpi ne=3D0
> > +SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi ne=3D1
> > +&r2          rs rt
> > +MTM0         011100 rs:5 rt:5 00000 00000 001000 &r2
> > +MTP0         011100 rs:5 rt:5 00000 00000 001001 &r2
> > +MTP1         011100 rs:5 rt:5 00000 00000 001010 &r2
> > +MTP2         011100 rs:5 rt:5 00000 00000 001011 &r2
> > +MTM1         011100 rs:5 rt:5 00000 00000 001100 &r2
> > +MTM2         011100 rs:5 rt:5 00000 00000 001101 &r2
> > +VMULU        011100 ..... ..... ..... 00000 001111 @r3
> > +V3MULU       011100 ..... ..... ..... 00000 010001 @r3
> > +
> > +&saa         base rt
> > +@saa         ...... base:5 rt:5 ................ &saa
> > +SAA          011100 ..... ..... 00000 00000 011000 @saa
> > +SAAD         011100 ..... ..... 00000 00000 011001 @saa
> > +
> > +&zcb         base
> > +ZCB          011100 base:5 00000 00000 11100 011111 &zcb
> >
> >   &lx          base index rd
> >   @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
> >   LWX          011111 ..... ..... ..... 00000 001010 @lx
> >   LHX          011111 ..... ..... ..... 00100 001010 @lx
> > +LHUX         011111 ..... ..... ..... 10100 001010 @lx
> >   LBUX         011111 ..... ..... ..... 00110 001010 @lx
> > +LWUX         011111 ..... ..... ..... 10000 001010 @lx
> > +LBX          011111 ..... ..... ..... 10110 001010 @lx
> >   LDX          011111 ..... ..... ..... 01000 001010 @lx
> > diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeo=
n_translate.c
> > index b2eca29e06..67b8634dff 100644
> > --- a/target/mips/tcg/octeon_translate.c
> > +++ b/target/mips/tcg/octeon_translate.c
> > @@ -13,6 +13,8 @@
> >   /* Include the auto-generated decoder.  */
> >   #include "decode-octeon.c.inc"
> >
> > +typedef void gen_helper_lmi(TCGv, TCGv_ptr, TCGv, TCGv);
> > +
> >   static bool trans_BBIT(DisasContext *ctx, arg_BBIT *a)
> >   {
> >       TCGv p;
> > @@ -45,7 +47,7 @@ static bool trans_BADDU(DisasContext *ctx, arg_BADDU =
*a)
> >   {
> >       TCGv t0, t1;
> >
> > -    if (a->rt =3D=3D 0) {
> > +    if (a->rd =3D=3D 0) {
>
> Bug fix? Distinct patch please.
>
> >           /* nop */
> >           return true;
> >       }
> > @@ -56,7 +58,8 @@ static bool trans_BADDU(DisasContext *ctx, arg_BADDU =
*a)
> >       gen_load_gpr(t1, a->rt);
> >
> >       tcg_gen_add_tl(t0, t0, t1);
> > -    tcg_gen_andi_i64(cpu_gpr[a->rd], t0, 0xff);
> > +    tcg_gen_andi_tl(t0, t0, 0xff);
> > +    gen_store_gpr(t0, a->rd);
> >       return true;
> >   }
> >
> > @@ -64,7 +67,7 @@ static bool trans_DMUL(DisasContext *ctx, arg_DMUL *a=
)
> >   {
> >       TCGv t0, t1;
> >
> > -    if (a->rt =3D=3D 0) {
> > +    if (a->rd =3D=3D 0) {
>
> Ditto.
>
> >           /* nop */
> >           return true;
> >       }
> > @@ -74,7 +77,8 @@ static bool trans_DMUL(DisasContext *ctx, arg_DMUL *a=
)
> >       gen_load_gpr(t0, a->rs);
> >       gen_load_gpr(t1, a->rt);
> >
> > -    tcg_gen_mul_i64(cpu_gpr[a->rd], t0, t1);
> > +    tcg_gen_mul_tl(t0, t0, t1);
> > +    gen_store_gpr(t0, a->rd);
> >       return true;
> >   }
> >
> > @@ -122,14 +126,14 @@ static bool trans_POP(DisasContext *ctx, arg_POP =
*a)
> >       t0 =3D tcg_temp_new();
> >       gen_load_gpr(t0, a->rs);
> >       if (!a->dw) {
> > -        tcg_gen_andi_i64(t0, t0, 0xffffffff);
> > +        tcg_gen_andi_tl(t0, t0, 0xffffffff);
>
> No, please avoid *_tl() helpers in this 64-bit only translator.
>
> >       }
> >       tcg_gen_ctpop_tl(t0, t0);
> >       gen_store_gpr(t0, a->rd);
> >       return true;
> >   }
> >
> > -static bool trans_SEQNE(DisasContext *ctx, arg_SEQNE *a)
> > +static bool trans_seqne(DisasContext *ctx, const arg_cmp3 *a)
> >   {
> >       TCGv t0, t1;
> >
> > @@ -152,7 +156,17 @@ static bool trans_SEQNE(DisasContext *ctx, arg_SEQ=
NE *a)
> >       return true;
> >   }
> >
> > -static bool trans_SEQNEI(DisasContext *ctx, arg_SEQNEI *a)
> > +static bool trans_SEQ(DisasContext *ctx, arg_cmp3 *a)
> > +{
> > +    return trans_seqne(ctx, a);
> > +}
> > +
> > +static bool trans_SNE(DisasContext *ctx, arg_cmp3 *a)
> > +{
> > +    return trans_seqne(ctx, a);
> > +}
> > +
> > +static bool trans_seqnei(DisasContext *ctx, const arg_cmpi *a)
> >   {
> >       TCGv t0;
> >
> > @@ -175,6 +189,16 @@ static bool trans_SEQNEI(DisasContext *ctx, arg_SE=
QNEI *a)
> >       return true;
> >   }
> >
> > +static bool trans_SEQI(DisasContext *ctx, arg_cmpi *a)
> > +{
> > +    return trans_seqnei(ctx, a);
> > +}
> > +
> > +static bool trans_SNEI(DisasContext *ctx, arg_cmpi *a)
> > +{
> > +    return trans_seqnei(ctx, a);
> > +}
>
> Please move these changes in a preliminary patch to help reviewers.
>
> >   static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
> >   {
> >       gen_lx(ctx, a->rd, a->base, a->index, mop);
> > @@ -182,7 +206,132 @@ static bool trans_lx(DisasContext *ctx, arg_lx *a=
, MemOp mop)
> >       return true;
> >   }
> >
> > +static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
> > +{
> > +    TCGv addr =3D tcg_temp_new();
> > +    MemOp amo =3D mo_endian(ctx) | mop | ctx->default_tcg_memop_mask;
> > +
> > +    gen_base_offset_addr(ctx, addr, a->base, 0);
> > +
> > +    if (mop =3D=3D MO_UQ) {
> > +        TCGv value =3D tcg_temp_new();
> > +        TCGv old =3D tcg_temp_new();
> > +
> > +        gen_load_gpr(value, a->rt);
> > +        tcg_gen_atomic_fetch_add_tl(old, addr, value, ctx->mem_idx, am=
o);
> > +    } else {
> > +        TCGv value =3D tcg_temp_new();
> > +        TCGv_i32 value32 =3D tcg_temp_new_i32();
> > +        TCGv_i32 old =3D tcg_temp_new_i32();
> > +
> > +        gen_load_gpr(value, a->rt);
> > +        tcg_gen_trunc_tl_i32(value32, value);
> > +        tcg_gen_atomic_fetch_add_i32(old, addr, value32, ctx->mem_idx,=
 amo);
> > +    }
> > +
> > +    return true;
> > +}
> > +
> > +static bool trans_ZCB(DisasContext *ctx, arg_zcb *a)
> > +{
> > +    TCGv addr =3D tcg_temp_new();
> > +    TCGv line =3D tcg_temp_new();
> > +    TCGv zero =3D tcg_constant_tl(0);
> > +
> > +    gen_base_offset_addr(ctx, addr, a->base, 0);
> > +
> > +    /*
> > +     * Octeon zcb operates on a cache block. Model it as zeroing the
> > +     * containing 128-byte line in memory.
> > +     */
> > +    tcg_gen_andi_tl(line, addr, ~((target_ulong)127));
> > +
> > +    for (int i =3D 0; i < 16; i++) {
> > +        TCGv slot =3D tcg_temp_new();
> > +
> > +        tcg_gen_addi_tl(slot, line, i * 8);
> > +        tcg_gen_qemu_st_tl(zero, slot, ctx->mem_idx, mo_endian(ctx) | =
MO_UQ);
> > +    }
> > +
> > +    return true;
> > +}
> > +
> > +static void octeon_store_tc_field(ptrdiff_t offset, TCGv value)
> > +{
> > +    tcg_gen_st_tl(value, tcg_env, offset);
> > +}
> > +
> > +static void octeon_zero_partial_product_state(void)
> > +{
> > +    TCGv zero =3D tcg_constant_tl(0);
> > +
> > +    octeon_store_tc_field(offsetof(CPUMIPSState, active_tc.P0), zero);
> > +    octeon_store_tc_field(offsetof(CPUMIPSState, active_tc.P1), zero);
> > +    octeon_store_tc_field(offsetof(CPUMIPSState, active_tc.P2), zero);
> > +    octeon_store_tc_field(offsetof(CPUMIPSState, active_tc.P3), zero);
> > +    octeon_store_tc_field(offsetof(CPUMIPSState, active_tc.P4), zero);
> > +    octeon_store_tc_field(offsetof(CPUMIPSState, active_tc.P5), zero);
> > +}
> > +
> > +static bool trans_mtm(DisasContext *ctx, arg_r2 *a, ptrdiff_t offset,
> > +                      ptrdiff_t high_offset)
> > +{
> > +    TCGv value =3D tcg_temp_new();
> > +
> > +    gen_load_gpr(value, a->rs);
> > +    octeon_store_tc_field(offset, value);
> > +    gen_load_gpr(value, a->rt);
> > +    octeon_store_tc_field(high_offset, value);
> > +    octeon_zero_partial_product_state();
> > +    return true;
> > +}
> > +
> > +static bool trans_mtp(DisasContext *ctx, arg_r2 *a, ptrdiff_t offset,
> > +                      ptrdiff_t high_offset)
> > +{
> > +    TCGv value =3D tcg_temp_new();
> > +
> > +    gen_load_gpr(value, a->rs);
> > +    octeon_store_tc_field(offset, value);
> > +    gen_load_gpr(value, a->rt);
> > +    octeon_store_tc_field(high_offset, value);
> > +    return true;
> > +}
> > +
> > +static bool trans_vmul(DisasContext *ctx, arg_decode_ext_octeon1 *a,
> > +                       gen_helper_lmi *helper)
> > +{
> > +    TCGv lhs =3D tcg_temp_new();
> > +    TCGv rhs =3D tcg_temp_new();
> > +    TCGv result =3D tcg_temp_new();
> > +
> > +    gen_load_gpr(lhs, a->rs);
> > +    gen_load_gpr(rhs, a->rt);
> > +    helper(result, tcg_env, lhs, rhs);
> > +    gen_store_gpr(result, a->rd);
> > +    return true;
> > +}
> > +
> > +TRANS(SAA,  trans_saa, MO_UL);
> > +TRANS(SAAD, trans_saa, MO_UQ);
> > +TRANS(LBX,  trans_lx, MO_SB);
> >   TRANS(LBUX, trans_lx, MO_UB);
> >   TRANS(LHX,  trans_lx, MO_SW);
> > +TRANS(LHUX, trans_lx, MO_UW);
> >   TRANS(LWX,  trans_lx, MO_SL);
> > +TRANS(LWUX, trans_lx, MO_UL);
> >   TRANS(LDX,  trans_lx, MO_UQ);
> > +TRANS(MTM0, trans_mtm, offsetof(CPUMIPSState, active_tc.MPL0),
> > +      offsetof(CPUMIPSState, active_tc.MPL3));
> > +TRANS(MTM1, trans_mtm, offsetof(CPUMIPSState, active_tc.MPL1),
> > +      offsetof(CPUMIPSState, active_tc.MPL4));
> > +TRANS(MTM2, trans_mtm, offsetof(CPUMIPSState, active_tc.MPL2),
> > +      offsetof(CPUMIPSState, active_tc.MPL5));
> > +TRANS(MTP0, trans_mtp, offsetof(CPUMIPSState, active_tc.P0),
> > +      offsetof(CPUMIPSState, active_tc.P3));
> > +TRANS(MTP1, trans_mtp, offsetof(CPUMIPSState, active_tc.P1),
> > +      offsetof(CPUMIPSState, active_tc.P4));
> > +TRANS(MTP2, trans_mtp, offsetof(CPUMIPSState, active_tc.P2),
> > +      offsetof(CPUMIPSState, active_tc.P5));
>
> TRANS() takes a VARARG list, so using the array suggestion we can
> easily rework the helpers and have simply:
>
> TRANS(MTM0, trans_mtm, 0)
> TRANS(MTM1, trans_mtm, 1)
> TRANS(MTM2, trans_mtm, 2)
> TRANS(MTP0, trans_mtp, 0)
> TRANS(MTP1, trans_mtp, 1)
> TRANS(MTP2, trans_mtp, 2)
>
> > +TRANS(VMULU, trans_vmul, gen_helper_octeon_vmulu);
> > +TRANS(V3MULU, trans_vmul, gen_helper_octeon_v3mulu);
> > diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
> > index 4502ae2b5b..d2398b6426 100644
> > --- a/target/mips/tcg/op_helper.c
> > +++ b/target/mips/tcg/op_helper.c
> > @@ -144,6 +144,90 @@ target_ulong helper_rotx(target_ulong rs, uint32_t=
 shift, uint32_t shiftx,
> >       return (int64_t)(int32_t)(uint32_t)tmp5;
> >   }
> >
> > +static void octeon_addc(uint64_t *res, int count, uint64_t value, int =
index)
> > +{
> > +    while (index < count) {
> > +        uint64_t old =3D res[index];
> > +
> > +        res[index] +=3D value;
> > +        if (res[index] >=3D old) {
> > +            break;
> > +        }
> > +        value =3D 1;
> > +        index++;
> > +    }
> > +}
> > +
> > +target_ulong helper_octeon_vmulu(CPUMIPSState *env, target_ulong arg1,
> > +                                 target_ulong arg2)
>
> s/target_ulong/uint64_t/
>
> > +{
> > +    uint64_t lo, hi;
> > +    uint64_t res[3] =3D {};
> > +
> > +    mulu64(&lo, &hi, env->active_tc.MPL0, arg1);
>
> (See, you implicitly use target_ulong as uint64_t)
>
> > +    res[0] =3D lo;
> > +    res[1] =3D hi;
> > +
> > +    mulu64(&lo, &hi, env->active_tc.MPL1, arg1);
> > +    octeon_addc(res, 3, lo, 1);
> > +    octeon_addc(res, 3, hi, 2);
> > +
> > +    octeon_addc(res, 3, arg2, 0);
> > +    octeon_addc(res, 3, env->active_tc.P0, 0);
> > +    octeon_addc(res, 3, env->active_tc.P1, 1);
> > +
> > +    env->active_tc.P0 =3D res[1];
> > +    env->active_tc.P1 =3D res[2];
> > +    return res[0];
> > +}
> > +
> > +target_ulong helper_octeon_v3mulu(CPUMIPSState *env, target_ulong arg1=
,
> > +                                  target_ulong arg2)
>
> Ditto.
>
> > +{
> > +    uint64_t lo, hi;
> > +    uint64_t res[7] =3D {};
> > +
> > +    mulu64(&lo, &hi, env->active_tc.MPL0, arg1);
> > +    res[0] =3D lo;
> > +    res[1] =3D hi;
> > +
> > +    mulu64(&lo, &hi, env->active_tc.MPL1, arg1);
> > +    octeon_addc(res, 7, lo, 1);
> > +    octeon_addc(res, 7, hi, 2);
> > +
> > +    mulu64(&lo, &hi, env->active_tc.MPL2, arg1);
> > +    octeon_addc(res, 7, lo, 2);
> > +    octeon_addc(res, 7, hi, 3);
> > +
> > +    mulu64(&lo, &hi, env->active_tc.MPL3, arg1);
> > +    octeon_addc(res, 7, lo, 3);
> > +    octeon_addc(res, 7, hi, 4);
> > +
> > +    mulu64(&lo, &hi, env->active_tc.MPL4, arg1);
> > +    octeon_addc(res, 7, lo, 4);
> > +    octeon_addc(res, 7, hi, 5);
> > +
> > +    mulu64(&lo, &hi, env->active_tc.MPL5, arg1);
> > +    octeon_addc(res, 7, lo, 5);
> > +    octeon_addc(res, 7, hi, 6);
> > +
> > +    octeon_addc(res, 7, arg2, 0);
> > +    octeon_addc(res, 7, env->active_tc.P0, 0);
> > +    octeon_addc(res, 7, env->active_tc.P1, 1);
> > +    octeon_addc(res, 7, env->active_tc.P2, 2);
> > +    octeon_addc(res, 7, env->active_tc.P3, 3);
> > +    octeon_addc(res, 7, env->active_tc.P4, 4);
> > +    octeon_addc(res, 7, env->active_tc.P5, 5);
> > +
> > +    env->active_tc.P0 =3D res[1];
> > +    env->active_tc.P1 =3D res[2];
> > +    env->active_tc.P2 =3D res[3];
> > +    env->active_tc.P3 =3D res[4];
> > +    env->active_tc.P4 =3D res[5];
> > +    env->active_tc.P5 =3D res[6];
> > +    return res[0];
> > +}
> > +
> >   /* these crc32 functions are based on target/loongarch/tcg/op_helper.=
c */
> >   target_ulong helper_crc32(target_ulong val, target_ulong m, uint32_t =
sz)
> >   {
>

