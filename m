Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B217CD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 18:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs5DJ-0001tR-5M; Wed, 03 Apr 2024 14:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rs5DH-0001t3-Dc
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 14:19:55 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rs5DF-0006Z8-3h
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 14:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1712168388; x=1712773188; i=deller@gmx.de;
 bh=sfVTu/leg0XsqnB2t9zKYFS4bpIsDNPcUzHUXNNIuQw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=YR3bQFEYXnAX88jt2cPxdmi2at5In66gDbt8UjANqVTwPcL/kxxbMC4me0Y61Shh
 vibnCAg46SUnpaBsd4JlWv3IDrxJeq9GJOzi4g+VWgjj4Ey5NIeE+DYgQ/8YLX/NE
 cW4Gt2D/ABUARblgGTNmAsV6qAsVheFlAPRcEfiVG5l0IqMxrSwuD8W3gVlPUoJ74
 MqAjB0ohDrBxQvamUY0TsgD48frOla67Y1mcK9QR7ZwvxtZUmUEbh3vrc8P9XE1SF
 AX5ovTywK8U8i6tGB1OLD/tmC+AqZzOUnH92SHMXKG6QewiOMJG0te4dmw2YnAMl9
 QLgH+ovsl0jv4Iys+w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.10] ([78.94.87.245]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYvY8-1sMy0p406S-00Uq32; Wed, 03
 Apr 2024 20:19:48 +0200
Message-ID: <b2e83db7-7786-47ac-b47a-906bc3eb7e1e@gmx.de>
Date: Wed, 3 Apr 2024 20:19:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hppa: Fix IIAOQ, IIASQ for pa2.0
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>
References: <20240402012504.177097-1-richard.henderson@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240402012504.177097-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YIbmRe7QHhZq2wfvpp9m+I+nuV9xKgITvNs1fW8MeMRIbxcIuX8
 2kET8MRXRs+IrGVRZrNmXLcGwqUG+OS3/oUpSxXnCwTEkLpg8k+9J4QUVfkOIN+lcWcbf9X
 4+2qERclW/RcowRDwVgJ5YRRoMjBtKUkdKOsQ8mzGYoow6X+0fY4uwQCk1yA8aYXCYb3/O5
 KPrCqfVvH8VJdtnNVfx1w==
UI-OutboundReport: notjunk:1;M01:P0:FR3P6vbDbRQ=;PSsp5pV+1OwSwSChbzuCByg1vj2
 tv+q5czqQl53p746ReMoUX4ebLXrRXsT2ZnWJf+PMhE6oxSUXXoqJG9zCH8VYETBoi1OfWFDM
 Xk1O8szRrPyRLQUtNezqzSPyjNCvLQIa5JW5MR/xTaDP//Dk3DDxa1krwBveX1vI5Umj8XRgA
 H/yyL7rS6uU+Ire50g7NnkzJxlwDpL69qZcdIhL3XF/GcssDsXAQGhjfxMrINA6ul1EMSl2Ia
 n5k09vS3fIpJY5CwO6jM3zIzqvwSCqtJXo0QN16+O+NNInu8wG9Xz9vyMN8eNfDyjWA9v6I/4
 aNUosPo9W/n7t/VUsLzIUu3tnl/ELrvo/hSg0IhKwdu4mphVXNDWFpEXa5+zNDg2TDuY2r8eP
 XV2c09uGUO/MMVPJMpO7mDDaqSJ97GIWmd6ypF0xfcjNDYSJkGaJB+s2Za/Z/Ejq4A2FsVvfs
 armQ8hQgX58TLLiVVchasa3Z2cH2xHV5yZMNjHUXPcznxm/hLdXTS8pkAhosAFKUKmWe0YLer
 IjkATYs2xqN9t30gEuBfiy+L/Nw2v46sDu+I31h1HxeSJi1fBHwzeijcDLrOIFPUw2ocD6/WE
 xsMnUO8y/M8meC3F2GXkqsro2FsMWp4v58p9hPasW0TkHZticFGnB9HI+0ivlhYpZXLZXX+0c
 XRuit0rbjunPIYEeXj6fLgfta5HyvWMbs1XBvsernRiK9AhwsWdPHot+IEo9GwdpXQunFZdBi
 Y/GaXl3WiRvH9wrZrzDzIMd27ejyW3TyUvlB2m2IWJdykZiQHfQ0giDVInnsFBNwc8kiIwvVi
 xzXnBJhn3jF2/6j6GUWgPcPjqj9zjMQXJwoX5UD99AwI8=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/2/24 03:25, Richard Henderson wrote:
> The contents of IIAOQ depend on PSW_W.
> Follow the text in "Interruption Instruction Address Queues",
> pages 2-13 through 2-15.
>
> Reported-by: Sven Schnelle <svens@stackframe.org>
> Fixes: b10700d826c ("target/hppa: Update IIAOQ, IIASQ for pa2.0")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Tested-by: Helge Deller <deller@gmx.de>

Helge

> ---
>
> Sven, I looked again through IIAOQ documentation and it does seem
> like some of the bits are wrong, both on interrupt delivery and RFI.
>
>
> r~
>
> ---
>   target/hppa/int_helper.c | 20 +++++++++++---------
>   target/hppa/sys_helper.c | 18 +++++++++---------
>   2 files changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
> index 90437a92cd..a667ee380d 100644
> --- a/target/hppa/int_helper.c
> +++ b/target/hppa/int_helper.c
> @@ -107,14 +107,10 @@ void hppa_cpu_do_interrupt(CPUState *cs)
>
>       /* step 3 */
>       /*
> -     * For pa1.x, IIASQ is simply a copy of IASQ.
> -     * For pa2.0, IIASQ is the top bits of the virtual address,
> -     *            or zero if translation is disabled.
> +     * IIASQ is the top bits of the virtual address, or zero if transla=
tion
> +     * is disabled -- with PSW_W =3D=3D 0, this will reduce to the spac=
e.
>        */
> -    if (!hppa_is_pa20(env)) {
> -        env->cr[CR_IIASQ] =3D env->iasq_f >> 32;
> -        env->cr_back[0] =3D env->iasq_b >> 32;
> -    } else if (old_psw & PSW_C) {
> +    if (old_psw & PSW_C) {
>           env->cr[CR_IIASQ] =3D
>               hppa_form_gva_psw(old_psw, env->iasq_f, env->iaoq_f) >> 32=
;
>           env->cr_back[0] =3D
> @@ -123,8 +119,14 @@ void hppa_cpu_do_interrupt(CPUState *cs)
>           env->cr[CR_IIASQ] =3D 0;
>           env->cr_back[0] =3D 0;
>       }
> -    env->cr[CR_IIAOQ] =3D env->iaoq_f;
> -    env->cr_back[1] =3D env->iaoq_b;
> +    /* IIAOQ is the full offset for wide mode, or 32 bits for narrow mo=
de. */
> +    if (old_psw & PSW_W) {
> +        env->cr[CR_IIAOQ] =3D env->iaoq_f;
> +        env->cr_back[1] =3D env->iaoq_b;
> +    } else {
> +        env->cr[CR_IIAOQ] =3D (uint32_t)env->iaoq_f;
> +        env->cr_back[1] =3D (uint32_t)env->iaoq_b;
> +    }
>
>       if (old_psw & PSW_Q) {
>           /* step 5 */
> diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
> index 208e51c086..22d6c89964 100644
> --- a/target/hppa/sys_helper.c
> +++ b/target/hppa/sys_helper.c
> @@ -78,21 +78,21 @@ target_ulong HELPER(swap_system_mask)(CPUHPPAState *=
env, target_ulong nsm)
>
>   void HELPER(rfi)(CPUHPPAState *env)
>   {
> -    env->iasq_f =3D (uint64_t)env->cr[CR_IIASQ] << 32;
> -    env->iasq_b =3D (uint64_t)env->cr_back[0] << 32;
> -    env->iaoq_f =3D env->cr[CR_IIAOQ];
> -    env->iaoq_b =3D env->cr_back[1];
> +    uint64_t mask;
> +
> +    cpu_hppa_put_psw(env, env->cr[CR_IPSW]);
>
>       /*
>        * For pa2.0, IIASQ is the top bits of the virtual address.
>        * To recreate the space identifier, remove the offset bits.
> +     * For pa1.x, the mask reduces to no change to space.
>        */
> -    if (hppa_is_pa20(env)) {
> -        env->iasq_f &=3D ~env->iaoq_f;
> -        env->iasq_b &=3D ~env->iaoq_b;
> -    }
> +    mask =3D gva_offset_mask(env->psw);
>
> -    cpu_hppa_put_psw(env, env->cr[CR_IPSW]);
> +    env->iaoq_f =3D env->cr[CR_IIAOQ];
> +    env->iaoq_b =3D env->cr_back[1];
> +    env->iasq_f =3D (env->cr[CR_IIASQ] << 32) & ~(env->iaoq_f & mask);
> +    env->iasq_b =3D (env->cr_back[0] << 32) & ~(env->iaoq_b & mask);
>   }
>
>   static void getshadowregs(CPUHPPAState *env)


