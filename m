Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36812CC6B0F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 21:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGk5X-00032j-Pg; Tue, 13 Oct 2026 17:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGk5G-00031U-Pv
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 17:30:57 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGk5D-0003OH-At
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 17:30:52 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6acb57c2b88so433463a12.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 14:30:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791927049; cv=none;
 d=google.com; s=arc-20260327;
 b=ZPzHF8zg04Fyx3MucQ6Z4XM9b6ZXfJ0KJEWQeH6zZ/jf7PfY5wdp2Tgo+6p8AmJeQ3
 FMpHwV0/SbSLtiW8p8dRU6n3vuwNeNlQAGGWigklW+HxwbGiSL3t9KLD6xn/98jwJFao
 4rF84/9oXfZ6e3r9LEOKnI7IY8gyMSWR8ZIDGjdmRqPOgrvc+SoLEzHQe5QHSOxGdDOg
 +J+QIzwMf6ANtkb0Ew3fNgUF8KBe1MI21wdq+rG8NgzdKgYq4Tc7oEJmdMFs7M/I30Kg
 BcrisZPeQntxaLDg0i771cceZvMHLcWRTKjh0Tt6wZWbof/nrhWsbn1hxFmS2WggnLxv
 +GWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=ALFIV5O26nsSYvUHOV0g+DM9+uPlrYTCUhfdA8irO6E=;
 fh=QKdANP/nO7rvHn5kIgspvwzO+mszMlwslD4O4YvMNsA=;
 b=Ouwt9OESjkDJars1Zle+8APWmsVAcYQQF10dIodAjyy+0cBLbwQ7xCr64ZssGUjRX0
 /z+Pr3g954j9UrV+JVqbItgKCqHmQ6KnI4brp0RJeVhCttlR/pKYFzfwJYSXdtSY1b/8
 DZdSE8EI8GaX8j7cazVbnOmrzw24aN+EFxWiUb/UFmeP3YYx8QbOPwkUTWf/P2ohfXHr
 dVEOnRMt8MDM5PPZgpJ/4hYHQ7X1ro4xn9VSHFN6KDlHR3BOPImrXOqdTFW2TinX/nhQ
 QckRpd0SdpnocwvWRdmV9DAusklFZ1OWhjNlJBjT5ilaPYJOYkzAHXseDYGyVc8PkXka
 KxbQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791927049; x=1792531849; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ALFIV5O26nsSYvUHOV0g+DM9+uPlrYTCUhfdA8irO6E=;
 b=fUI3BnmWJnUrA4KDZiCNZaLsstiACr/zWuvsM1E7kE0dd9aOPEdZ4+ED8Z+LozBdIS
 PVdz6XaLaFoxGNzmnhswZiRiNzCeIHCyZJVuJxwKHnW+zktIcDtCxXzUcByEj9+3Q16Q
 9wd9103PP1+Ii2G/32L0vx1Pqp6VSTx5p1E3v765LBrQReXCaE5rH7C0TxNOVP8rA+uS
 dHzX28Mlpyk3W/BZXTLc3GYghRSzlyBg8xSHJGFYe/ertOehbfP3AkFslqPLYlPTsBag
 Ud6tPACVHKZra/nAPBXjybWYpLTIc4VPA2fVIFejePTv7CNtykTcHIkXDyeuwqWbFo0u
 QssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791927049; x=1792531849;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ALFIV5O26nsSYvUHOV0g+DM9+uPlrYTCUhfdA8irO6E=;
 b=ATIWmLYxziZvUTLBKS3K1qVwKbk01E8BwXVZWcgDlXaYxrux6B6SR3k3nUTtQTtM5j
 eMymK1AkwQfqqz9ih2bTeipYFaxNQZ33fUreJbN4rhQ4Ux9LelhJFV5KfCqllAfoEBzm
 0Mn6rIv7cZPeQhTYUQCf/c0qbQ634zTh46QNGHA/Wypysm/QYV1RzkK8K4dGFui6/Uaa
 6WBgo3zvdPOG+iBWUz/mqVOKcwx/9EOW19+cPSl8mzLj9ItmYpoAvK9dzG1n2ribp+cN
 h1xuC+rkQa+iGv8b8//eVqwT3gQ72HN96e7YrnCx3lVEOCY0oHFmus5k2pDaNe0Wm1w/
 pbUA==
X-Gm-Message-State: AFq9FYJZvlhuvCzOGpnMuJ6091jiZWas4LaaQf9YfRyudSzj7FvAxyE3
 7cMkb1JODdTO2NSZoy1aET0PHI5LCBOf0mJuGnamyTBSyZbQQZhg+LwlZCAviaQtTI7yND68fZY
 jDuPJGKcK57qM8NzAbdSXsLGo9OitNh4=
X-Gm-Gg: AYBFou20csBUzyUAaSS6iGI5WpXLKOr/UjEtm42Aar+o7PpeTMtFf7eGMx1bpK6dl8p
 6eeCYD9aXFZZLm01LWfGFqNTZ3h29tXMWYgPM2LI1AgrCvQdnILfTSp2SVtw+oeIvwzR3j1NKOa
 +OhDYA/4FIqD6IH2c5dNe40LpWXytlnnDxLcn8DFLYE8Wp7/Q6Q78EM3D27S1kc8YEH/vHh0H14
 6IipqC/3FB9W7gm9QUaWLWxPSqy8X31Vd+RT03/IQzmath4JKu52JGXkQBs4erDcHL4Hov6m2k+
 5tM5h+20yoP6QTtlZqcZH1u30RGaHKn8JT/f8Bs1QPEpTrRfq4ze0Ds=
X-Received: by 2002:a05:6402:44c9:b0:6b1:cc39:28ec with SMTP id
 4fb4d7f45d1cf-6b1cc392d02mr3965120a12.42.1791927049057; Tue, 13 Oct 2026
 14:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20261013195606.152-1-luoyonggang@gmail.com>
 <f3649d73-1edf-440a-9534-7b00da4d075d@oss.qualcomm.com>
 <CAE2XoE828e76zdCEkYVcbjRwhcsaSYZF1_UE4akeaoCTqCK3zg@mail.gmail.com>
 <baf81ba3-f29f-48f0-a9a2-6dc4f005d433@oss.qualcomm.com>
In-Reply-To: <baf81ba3-f29f-48f0-a9a2-6dc4f005d433@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Wed, 14 Oct 2026 05:30:36 +0800
X-Gm-Features: AclHuK9TYzFjJ0r0h9_TSAtqU5LCViyTjkWqgkr9j-4xfLbLVuM3RrarZ3GEjV8
Message-ID: <CAE2XoE9L8tuhU2nieJ8D=Cz9svS=W3oqAH+j30RGtZibjp1G=Q@mail.gmail.com>
Subject: Re: [PATCH] target/arm: defer max-v8 initializer selection until CPU
 creation
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52c.google.com
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 14, 2026 at 5:07=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/13/26 1:19 PM, Yonggang Luo wrote:
> > On Wed, Oct 14, 2026 at 4:08=E2=80=AFAM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On 10/13/2026 12:56 PM, Yonggang Luo wrote:
> >>> This is for avoid "max-v8" qom name conflict in multi-target qemu
> >>>
> >>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> >>> ---
> >>>   target/arm/tcg/cpu-max-v8.c | 17 +++++++++++++----
> >>>   1 file changed, 13 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/target/arm/tcg/cpu-max-v8.c b/target/arm/tcg/cpu-max-v8.=
c
> >>> index 65f851f2006..d7323ab431c 100644
> >>> --- a/target/arm/tcg/cpu-max-v8.c
> >>> +++ b/target/arm/tcg/cpu-max-v8.c
> >>> @@ -119,12 +119,21 @@ void aarch32_max_v8_tcg_initfn(Object *obj)
> >>>   #endif
> >>>   }
> >>>
> >>> +static void max_v8_tcg_initfn(Object *obj)
> >>> +{
> >>> +    if (target_aarch64()) {
> >>> +        aarch64_max_v8_tcg_initfn(obj);
> >>> +    } else {
> >>> +        aarch32_max_v8_tcg_initfn(obj);
> >>> +    }
> >>> +}
> >>> +
> >>>   static void cpu_max_v8_register_type(void)
> >>>   {
> >>> -    static const ARMCPUInfo max_v8[2] =3D {
> >>> -        { .name =3D "max-v8", .initfn =3D aarch32_max_v8_tcg_initfn =
},
> >>> -        { .name =3D "max-v8", .initfn =3D aarch64_max_v8_tcg_initfn =
},
> >>> +    static const ARMCPUInfo max_v8 =3D {
> >>> +        .name =3D "max-v8",
> >>> +        .initfn =3D max_v8_tcg_initfn,
> >>>       };
> >>> -    arm_cpu_register(&max_v8[target_aarch64()]);
> >>> +    arm_cpu_register(&max_v8);
> >>>   }
> >>>   type_init(cpu_max_v8_register_type)
> >>
> >> It works for the current need, but will require further changes for
> >> heterogeneous emulation. A more versatile solution could be:
> >>
> >> arm_cpu_register(&aarch32_max_v8, target_arm);
> >> arm_cpu_register(&aarch64_max_v8, target_aarch64);
> >
> > And another way to handle it is like x86. it's comes with two variant f=
or
> >
> > #ifdef TARGET_X86_64
> > #define TYPE_X86_CPU "x86_64-cpu"
> > #else
> > #define TYPE_X86_CPU "i386-cpu"
> > #endif
> >
> > This also solves this issue, which looks more straightforward. no need
> > .targets magic for CPU.
> > Anyway, maybe the best way is to merge "x86_64-cpu" and "i386-cpu"
> > into a single cpu type and
> > add .targets magic? When I am trying to get x86 works, faced this issue
> >
>
> This solves including i386 or x86_64, but not including both at the same
> time. Same goes for arm vs aarch64.
>
> You can take a look at git history in target/arm, to see which kind of
> changes we did to make arm and aarch64 targets linkable. You'll notice
> most of the work was to remove (a lot of) #ifdef TARGET_X.

See it
SHA-1: ec7e5a90fea996f04ea24e81b680a87bc975354a
* target/arm: Remove TYPE_AARCH64_CPU

So I am just doing just the reverse direction, I am fixes x86_64 in a way t=
hat
register both "x86_64-cpu" "i386-cpu" variants, though this way seems
more suitable
for your heterogeneous emulation, but we need to register
everything(CPUs) twice.
I'll post those two patches for a look


>
> Regards,
> Pierrick



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

