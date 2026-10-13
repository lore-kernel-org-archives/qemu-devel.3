Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF2BCC6B1D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 20:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGiy0-00054l-Sq; Tue, 13 Oct 2026 16:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGixz-00054X-C7
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 16:19:19 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGixx-0004gB-La
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 16:19:19 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6afbc363efeso349486a12.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 13:19:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791922756; cv=none;
 d=google.com; s=arc-20260327;
 b=My1fua7pl1DpMrGRynFZUA7+VsPAJZv1ONIuF6/2TmChGpM8VRR/RK361qIq6tT7mk
 UFF9YKuDtmOxFFrOeHfTkTTPXnt3pCqiiPAFiQk4usMLK1L2ntNyOgqWRfkSMyWaONCk
 fCC3FPnRLdu/fZ7Rr4+IrV1TEhEFvpZfw0vPG1puo3/iti6NNz9JALljw3a44Ej62ckl
 Zp5Tp1hKdmJ8YYGsCsppZqp1/ku5SHyYH/mmOcQ/RaeqLZNQtpKMYZTob3tYRvXUNFPC
 vECVV/ppn6HgHcdtyuAC+cpyv0UrVRPAKHJFJG7Lgjvhm4EUfAFJ9PwA5fFoCHL0aI8t
 GXmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=UP4lpP0kar3gNdYX8OFAipp90Yk+JYoBHM/fAy1NcWU=;
 fh=QKdANP/nO7rvHn5kIgspvwzO+mszMlwslD4O4YvMNsA=;
 b=Z3ycg/axTf+6MJtyVk0ndUimzTK/Qyl/jbyGc+75NPTkypYSeGgRkiyAiyZxBrPRRF
 Glnb4kuzKiectBMwc7cPRXvDYXLop+EtWXPwDJWqyXzcZw4wKOtZn/HfUNJvL3gnEqdL
 kA8riQ0RrOwKPf5I5eHlMGfFKIJfoqL2W/jWfRHnR4PYWe7yFBOKzipwbgWCPlAHJkKu
 d8P1EPAfPzqpmgjrQbCpnKtBVllDFcTHQ0QRrgv5PBgBaBCsiBe2ggbixsX96NYFiWCV
 3thcq8U/SS0yJe94ofP0A95Uu2RtTw6BA6nbWKDsUnP16oUNrmAaztdXeigN5kU6of9v
 UvCw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791922756; x=1792527556; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UP4lpP0kar3gNdYX8OFAipp90Yk+JYoBHM/fAy1NcWU=;
 b=Wi8Kz/alJ/yjoNAlUIQFHodrlFwldjqCvRZgxoYGla3lUsi1bVwoLErbZPinBG7fxN
 x5xkQyGebkNEhT3JLuFJ2eTuH3k8yp6Wj5dN+IpaKJdMDP+hDFpmU33zseTZLAw1g3Ut
 7JXlN7WMt7tPG8NG06UQjOxlM2HcF+Ww7JXIkU1KxJe+R6IBoJ8x/9XWZuO0KlGsRNUB
 GsggFF2ZbeJD5oVxc6gXUP35bkhq17RkGLo90rXtD9GUSulV3HAiqUBS/k1OH03mNvvX
 pPw3leqD5NC/8pC9pSy3PzzDDvj/YIBuZDhDHIne08Kte4pasJAdLkAhXyxS+hgCpKm/
 nfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791922756; x=1792527556;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UP4lpP0kar3gNdYX8OFAipp90Yk+JYoBHM/fAy1NcWU=;
 b=tEHKR/SeFB89P77JzutPhBj0wgEQ98a00dxIyUi5tvaJACqkMyZMMUpw9jieEYtDMF
 cfho1vVprrlAKNe1dR/iwSAJX4vhEoCcsavFEzHr+5JsyqJJ5OpQTcDSc5tpqxxhCuH5
 ZnJYxbeuxc7ijAehrU1AoErsskAS1xWtdNN0x1P0pPJm+QbeO2x3S0L9BHLW8qipARrL
 9tQBDuZjfuPFkK7KaElvR/tNsD5r9jrAD1/oVHbMSDXVPhdI4uMNoXYDhZJl53phv2il
 1cuC9hbWirm08rXiukmoXZBrDrnMFKS/v3Xb69XySIxbbOQkLn1GNu0ZtkFEZZ20lCSO
 9KFA==
X-Gm-Message-State: AFq9FYJiDRoewIMU9i2dPalUQPu5N45HSEKJ5A45nga47nvWdKGUZUdy
 EBSA3lKtLCvkHxd5MqVXZ0oXSH6JyESsfDuqKvDCl8kNczfh522D9btGJmpxryH9/MNOENshzNQ
 e+Vcj0MuDIM0DCZ1klgNks83KX4yrtEo=
X-Gm-Gg: AYBFou213AgZ9m4MIGyCa1Q3B22hz8K+C/w/f3Ms0ZpYd/V7jcSrnUuPIQwN+EQUdar
 NsRZ/guuDLLZ/JeZCqZQU45gxNfjle5GAjRRD/DOHLC/Q9O12Whnsu0mbW9rMVxWp0MUOw5RzUF
 nIRO4Z1d+FrLCajpWfG9OXXdyC6qDjKFjhpNCrdOvOCQ3dT24erBYaMXF6iVCT0DjetShBfWQfh
 +iZdZEIgJ8T7kLVjRfaK4/d2Kd4pr5oKwzjlLjBQLF4w4eP1JX34HenD5HQl8l6dPb3RPmd9Hp9
 bEq4u+5d9/rzbUOtXUGdXBbRrzBjPa2jGXpmwTG5MMYazD7kPdZfwwc=
X-Received: by 2002:a05:6402:1cc2:b0:6ae:fc0f:e19 with SMTP id
 4fb4d7f45d1cf-6b17c4ee3e2mr10891431a12.42.1791922755767; Tue, 13 Oct 2026
 13:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <20261013195606.152-1-luoyonggang@gmail.com>
 <f3649d73-1edf-440a-9534-7b00da4d075d@oss.qualcomm.com>
In-Reply-To: <f3649d73-1edf-440a-9534-7b00da4d075d@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Wed, 14 Oct 2026 04:19:02 +0800
X-Gm-Features: AclHuK-qiDOyENcAxtS5FxBQhp230EV57isL1AmEc2Jx2vN8tsNe7QFYIjLw1-o
Message-ID: <CAE2XoE828e76zdCEkYVcbjRwhcsaSYZF1_UE4akeaoCTqCK3zg@mail.gmail.com>
Subject: Re: [PATCH] target/arm: defer max-v8 initializer selection until CPU
 creation
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 14, 2026 at 4:08=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/13/2026 12:56 PM, Yonggang Luo wrote:
> > This is for avoid "max-v8" qom name conflict in multi-target qemu
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  target/arm/tcg/cpu-max-v8.c | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/target/arm/tcg/cpu-max-v8.c b/target/arm/tcg/cpu-max-v8.c
> > index 65f851f2006..d7323ab431c 100644
> > --- a/target/arm/tcg/cpu-max-v8.c
> > +++ b/target/arm/tcg/cpu-max-v8.c
> > @@ -119,12 +119,21 @@ void aarch32_max_v8_tcg_initfn(Object *obj)
> >  #endif
> >  }
> >
> > +static void max_v8_tcg_initfn(Object *obj)
> > +{
> > +    if (target_aarch64()) {
> > +        aarch64_max_v8_tcg_initfn(obj);
> > +    } else {
> > +        aarch32_max_v8_tcg_initfn(obj);
> > +    }
> > +}
> > +
> >  static void cpu_max_v8_register_type(void)
> >  {
> > -    static const ARMCPUInfo max_v8[2] =3D {
> > -        { .name =3D "max-v8", .initfn =3D aarch32_max_v8_tcg_initfn },
> > -        { .name =3D "max-v8", .initfn =3D aarch64_max_v8_tcg_initfn },
> > +    static const ARMCPUInfo max_v8 =3D {
> > +        .name =3D "max-v8",
> > +        .initfn =3D max_v8_tcg_initfn,
> >      };
> > -    arm_cpu_register(&max_v8[target_aarch64()]);
> > +    arm_cpu_register(&max_v8);
> >  }
> >  type_init(cpu_max_v8_register_type)
>
> It works for the current need, but will require further changes for
> heterogeneous emulation. A more versatile solution could be:
>
> arm_cpu_register(&aarch32_max_v8, target_arm);
> arm_cpu_register(&aarch64_max_v8, target_aarch64);

And another way to handle it is like x86. it's comes with two variant for

#ifdef TARGET_X86_64
#define TYPE_X86_CPU "x86_64-cpu"
#else
#define TYPE_X86_CPU "i386-cpu"
#endif

This also solves this issue, which looks more straightforward. no need
.targets magic for CPU.
Anyway, maybe the best way is to merge "x86_64-cpu" and "i386-cpu"
into a single cpu type and
add .targets magic? When I am trying to get x86 works, faced this issue


> /* and fix other call sites */
> And arm_cpu_register could take a new parameter, to set
> TypeInfo.is_available with the callback passed in.
>
> @Peter: do you have a preference on this? I'm fine with having current
> patch and delay further changes to arm_cpu_register until we have proper
> heterogeneous support if you prefer.
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

