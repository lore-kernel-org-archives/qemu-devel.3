Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751B0C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 13:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6sXF-0004fb-A8; Tue, 14 May 2024 09:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1s6sXD-0004fQ-Fb
 for qemu-devel@nongnu.org; Tue, 14 May 2024 09:49:39 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1s6sX8-0001nV-ES
 for qemu-devel@nongnu.org; Tue, 14 May 2024 09:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1715694568; x=1716299368; i=deller@gmx.de;
 bh=5a0pFd9HCJ1afTRkH7pnP77K/qMybXDxhB9eUlZqJqQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=WuTQot4KCN3+QdBnmLvMrpuxBVVINigRs1/dME0ehSrCpbjG6nOajRun6CGIyNlp
 ZwObv6ZX0nfotIJEjVXCZeWeN9OQ2T0wn8+SMZWn+QN5SchQJMgOalJuqgAAoglQn
 w5WHb8xIMhGSE/FoMr3u/YTTzd220Ty+NDvp41ZiC+bnUbDrl4vjSwkCyknVRBh3+
 hOlaJ0rKYDzDKvbRp1UU1O7v9UCC093QTdm4QUZ8PNiGReVcso7/vC+SDrfj28HvE
 pvy9dRhghKe1vct+DSvnu61HeqP5+bNYhclv9Dl+ZmUpPVgw8hyupp/VnwmrtEq7z
 JjVq9lgtS/gF4P6BaQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([89.244.186.200]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1My32F-1sVQhT1tnj-00zWqq; Tue, 14
 May 2024 15:49:28 +0200
Message-ID: <6981f2e4-93b6-4220-bb21-1ee169514a99@gmx.de>
Date: Tue, 14 May 2024 15:49:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/45] target/hppa: Move cpu_get_tb_cpu_state out of
 line
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-2-richard.henderson@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240513074717.130949-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zxjSTXJYMyBxDyJthIYVkLYgoMXo/QoUOLjS86qD5k5MvJlj9t1
 lKROX0Uj6SYFEir8JZGoIkldc6ORiJmwXuyenZ8lzWIK4ltrS+/Nb01KscxfFvqfrleEmHu
 QwphRGPsaFdbO0Q0LWgWjQrDN7mgDzBC3pLym/cJtzSuf6CytquIgo1WXO6or3FqzN2TwQ0
 6Epq3AULSLJiYpKkLfeSg==
UI-OutboundReport: notjunk:1;M01:P0:8FOKjZ7vT+0=;5b6PjE9xixAot9kGn17BQFbtvVw
 LnSu9SJhrzuFYG+/i4r8YpGyGvkV+O95RX96g6afoQ3/Ow97RAqF7vlg1GF90cjHtsj6UF86i
 LGtTpCDU6gngKP1r0PG+aPlchIeXUQgTtQR1doU0vacAftkffZk+gzDPKHvSWb0F2j0iRnaWN
 J3h+6Y3p61ThV4B03HEab3UYcyVHFxjDDVgqNElONecomhxPn9f+Y1a4210PNPjBcIMTZq9is
 Ywz0DtTpAVQY1pGI5Cti0BBUzD6RaVGfrPs7Y0ps7CCDKNc/7I3bGEUDtlN9x0yBz3bK/KRcE
 IeK1Z8rqHsNukmLHTJTMn4hqtzNFgrdkikDahMjWzO7VpBO/Bz5kXTDagEOEjh46E8NI5r/Xn
 ukvlfr+YrEr2/2diG9EmaHIj4If/C6NE7uSLhxtJbrRocGGvel14KOUt+NtEKQ8gY4zr62Ob4
 BgvMTUiI6giwrezs/GmI30b4eMaXXkleFvkL7NDcy1MOfe7vOCFciK/8WS1uRIS67lq/WEvSU
 zuinb+7ECo/K9OEpp5C9lR3fYybk04fpnRDBTPVWx1euhJf9D2lzjkyO397xUAivKw1zGPsNT
 pLU/65dXj8LTfUfhcsCP2MrqE3TLpc2qsheCIBeLyH8f22dEv0uj3rMsW6BAW0lSdyJpLlWg8
 wjWqz4j90VXmPy+4FPLKL8FDlpAec0ZthAIFm2ja8th+z1q8P2Z8p/LH7Xbr/oQNxuQzFs8Gs
 pFC9e5ptHSfwvwGTZ91yFwFkhGM1ZiI/hS0fdtvIQDGiEEprjUSkKFtYvgtvFwhbo8LDBFFZP
 OkwMNZii4zp8fl1yvXtQHES8OnIdSgj92pn49R0SeNVh4=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/13/24 09:46, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

> ---
>   target/hppa/cpu.h | 43 ++-----------------------------------------
>   target/hppa/cpu.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 44 insertions(+), 41 deletions(-)
>
> diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
> index fb2e4c4a98..61f1353133 100644
> --- a/target/hppa/cpu.h
> +++ b/target/hppa/cpu.h
> @@ -314,47 +314,8 @@ hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr);
>   #define TB_FLAG_PRIV_SHIFT  8
>   #define TB_FLAG_UNALIGN     0x400
>
> -static inline void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
> -                                        uint64_t *cs_base, uint32_t *pf=
lags)
> -{
> -    uint32_t flags =3D env->psw_n * PSW_N;
> -
> -    /* TB lookup assumes that PC contains the complete virtual address.
> -       If we leave space+offset separate, we'll get ITLB misses to an
> -       incomplete virtual address.  This also means that we must separa=
te
> -       out current cpu privilege from the low bits of IAOQ_F.  */
> -#ifdef CONFIG_USER_ONLY
> -    *pc =3D env->iaoq_f & -4;
> -    *cs_base =3D env->iaoq_b & -4;
> -    flags |=3D TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
> -#else
> -    /* ??? E, T, H, L, B bits need to be here, when implemented.  */
> -    flags |=3D env->psw & (PSW_W | PSW_C | PSW_D | PSW_P);
> -    flags |=3D (env->iaoq_f & 3) << TB_FLAG_PRIV_SHIFT;
> -
> -    *pc =3D hppa_form_gva_psw(env->psw, (env->psw & PSW_C ? env->iasq_f=
 : 0),
> -                            env->iaoq_f & -4);
> -    *cs_base =3D env->iasq_f;
> -
> -    /* Insert a difference between IAOQ_B and IAOQ_F within the otherwi=
se zero
> -       low 32-bits of CS_BASE.  This will succeed for all direct branch=
es,
> -       which is the primary case we care about -- using goto_tb within =
a page.
> -       Failure is indicated by a zero difference.  */
> -    if (env->iasq_f =3D=3D env->iasq_b) {
> -        target_long diff =3D env->iaoq_b - env->iaoq_f;
> -        if (diff =3D=3D (int32_t)diff) {
> -            *cs_base |=3D (uint32_t)diff;
> -        }
> -    }
> -    if ((env->sr[4] =3D=3D env->sr[5])
> -        & (env->sr[4] =3D=3D env->sr[6])
> -        & (env->sr[4] =3D=3D env->sr[7])) {
> -        flags |=3D TB_FLAG_SR_SAME;
> -    }
> -#endif
> -
> -    *pflags =3D flags;
> -}
> +void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
> +                          uint64_t *cs_base, uint32_t *pflags);
>
>   target_ulong cpu_hppa_get_psw(CPUHPPAState *env);
>   void cpu_hppa_put_psw(CPUHPPAState *env, target_ulong);
> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index 393a81988d..582036b31e 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -43,6 +43,48 @@ static vaddr hppa_cpu_get_pc(CPUState *cs)
>       return cpu->env.iaoq_f;
>   }
>
> +void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
> +                          uint64_t *cs_base, uint32_t *pflags)
> +{
> +    uint32_t flags =3D env->psw_n * PSW_N;
> +
> +    /* TB lookup assumes that PC contains the complete virtual address.
> +       If we leave space+offset separate, we'll get ITLB misses to an
> +       incomplete virtual address.  This also means that we must separa=
te
> +       out current cpu privilege from the low bits of IAOQ_F.  */
> +#ifdef CONFIG_USER_ONLY
> +    *pc =3D env->iaoq_f & -4;
> +    *cs_base =3D env->iaoq_b & -4;
> +    flags |=3D TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
> +#else
> +    /* ??? E, T, H, L, B bits need to be here, when implemented.  */
> +    flags |=3D env->psw & (PSW_W | PSW_C | PSW_D | PSW_P);
> +    flags |=3D (env->iaoq_f & 3) << TB_FLAG_PRIV_SHIFT;
> +
> +    *pc =3D hppa_form_gva_psw(env->psw, (env->psw & PSW_C ? env->iasq_f=
 : 0),
> +                            env->iaoq_f & -4);
> +    *cs_base =3D env->iasq_f;
> +
> +    /* Insert a difference between IAOQ_B and IAOQ_F within the otherwi=
se zero
> +       low 32-bits of CS_BASE.  This will succeed for all direct branch=
es,
> +       which is the primary case we care about -- using goto_tb within =
a page.
> +       Failure is indicated by a zero difference.  */
> +    if (env->iasq_f =3D=3D env->iasq_b) {
> +        target_long diff =3D env->iaoq_b - env->iaoq_f;
> +        if (diff =3D=3D (int32_t)diff) {
> +            *cs_base |=3D (uint32_t)diff;
> +        }
> +    }
> +    if ((env->sr[4] =3D=3D env->sr[5])
> +        & (env->sr[4] =3D=3D env->sr[6])
> +        & (env->sr[4] =3D=3D env->sr[7])) {
> +        flags |=3D TB_FLAG_SR_SAME;
> +    }
> +#endif
> +
> +    *pflags =3D flags;
> +}
> +
>   static void hppa_cpu_synchronize_from_tb(CPUState *cs,
>                                            const TranslationBlock *tb)
>   {


