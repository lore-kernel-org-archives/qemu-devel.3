Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE9FC54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 20:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpDO3-0005u7-L6; Tue, 26 Mar 2024 16:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rpDNv-0005tW-FN
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 16:27:05 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rpDNs-0002Ig-OY
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 16:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1711484817; x=1712089617; i=deller@gmx.de;
 bh=fXzuk3I+yXhEIJ0mHJAeSdZjdt8HvscnFKR2NAO9Rj8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=iwVGfwgI5gKA7F91474R+N+I7D5zF2LXQtG9g4zs3ndeID9YlAmdC3kj6Flba0+n
 vz8Qr/LsT03dmILsUAomrSi9IeEAho8p0bdEhCCbWCMrFOnuLh4EajQ/11Hwklx57
 mJrP3zn8qEXjDxk09TYlM37j0j6Dh+JvsAnnHyixz+ZoSt97XjLqTAOOjSCccPY+4
 xa6ytiKFVoNiV849znYCEp2hlEihv6Ld+nlzwBfg55Ew6HGaQyoRLIz0mU5hIvKmT
 CYnLujflJ1OJ/dodfw691yOL4R13S8dROasaS3L+zEXJc91j8K/6xT7iczHE1blaO
 Edp/J8/Uj81GnedNcw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([89.244.180.193]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQ5vW-1sBIdV0Yme-00M76V; Tue, 26
 Mar 2024 21:26:57 +0100
Message-ID: <bc5a001c-a911-4a79-afd1-d0724d18608f@gmx.de>
Date: Tue, 26 Mar 2024 21:26:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] target/hppa: Generate getshadowregs inline
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@kernel.org
References: <20240326181028.332867-1-richard.henderson@linaro.org>
 <20240326181028.332867-2-richard.henderson@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240326181028.332867-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:huPtU6alvZpPBhdbV004XASnSXHYfRcGCoavh1+FjsFhoz77xzH
 n56U/j48S+rKpLmioPSzVkle0SX0wI/GjplZtImPT8riPKDYKmO6NvhoJ0SnK/B7B0TkzGC
 wd/oYZNGqGjZ3/+r8l3WMuZR8mRBa0/NzHIxX2A6cG8Q2gA1h0DX0IxKpm/8UWbTwLOloJY
 CogMXWD4ND2uZUCXfLqoA==
UI-OutboundReport: notjunk:1;M01:P0:wr1JBIiRDas=;Wp4gEFVXToXK/IEDZ7zSIki/g2y
 JKDgF3GaSzO5S4fRoaVmfwUo97TPJ+wmrlH5U0Q5NaNtMjfvWKXnvMUpl3j8nsb5YEW15lScL
 l+M9vqePOL2989otfZKat0IisO89kekxS2NYVYOvi+PA6VqtV+zEzjr3HAocZZq2yUC1xVBwb
 cQYJbq1eQIiivSJ+1nwjUVYl9Af21heXaTF/nj5vpXdFZuOmDIqOBj/hg6CyKUQdbkoN2xGjh
 6Nc0R3Y52Yzc3VZ5l/4m1kbGaT5v6AmS0OJW04ffBeQdJWoRGkUi78Nagnch4M1IIx5YFwaAM
 Wj9i4gTTTtPQWKpzOEH5O4sEGu0b8diMTuQmPOneXKdZBC2EeYCo+jjYoClFlKj4+Hn7v6o2+
 9V7z3WuCMDsePg/r53Zho2iqvjvPO6ylaIWNkQbjTVRjcFmS9G0vsD9J3PP/LXxhcIwtaWI81
 wYXC/Ma+2qJSguMBGsouGDNYGzY8tAel/sheVDBXZri1jktO83T0uA65AYjqY6xNdRuYS41d8
 ESg3ZYfW+tM+XdEIj4KNw1R2V2fQnxOY1/tuv5fQJbciGIJGSG/jt9IHqzsyUD2sHZqCO5KWa
 aVFdzvgjGqvonStoVlaY/eYSvIz0hjYlYf8J8y5q48ymkasrHLHu2bPDMdqlLfPvR/ScP7A0A
 Q1/KME8fi+1TTaA/Td9TR7st84TmNc1SE0acUOwhPhRmNCyeVcrp/SBGhNezGp3wu01y+sYvy
 HX4y1geoDuPtm7QyTXis4TbpcbbSV+j94eeHyUmSe+bybkPXZL5R4eEqvRT3chFxzSksaJTIr
 sdx6m8TqZvAEIeY7Qs3exGptJwfo1lg7Ko+gByPAJuYw8=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
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

On 3/26/24 19:10, Richard Henderson wrote:
> This operation is trivial and does not require a helper.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

Helge

> ---
>   target/hppa/helper.h     |  1 -
>   target/hppa/sys_helper.c |  4 ++--
>   target/hppa/translate.c  | 17 +++++++++++++----
>   3 files changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/target/hppa/helper.h b/target/hppa/helper.h
> index 8fd7ba65d8..5900fd70bc 100644
> --- a/target/hppa/helper.h
> +++ b/target/hppa/helper.h
> @@ -86,7 +86,6 @@ DEF_HELPER_FLAGS_0(read_interval_timer, TCG_CALL_NO_RW=
G, tl)
>   #ifndef CONFIG_USER_ONLY
>   DEF_HELPER_1(halt, noreturn, env)
>   DEF_HELPER_1(reset, noreturn, env)
> -DEF_HELPER_1(getshadowregs, void, env)
>   DEF_HELPER_1(rfi, void, env)
>   DEF_HELPER_1(rfi_r, void, env)
>   DEF_HELPER_FLAGS_2(write_interval_timer, TCG_CALL_NO_RWG, void, env, t=
l)
> diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
> index 4a31748342..208e51c086 100644
> --- a/target/hppa/sys_helper.c
> +++ b/target/hppa/sys_helper.c
> @@ -95,7 +95,7 @@ void HELPER(rfi)(CPUHPPAState *env)
>       cpu_hppa_put_psw(env, env->cr[CR_IPSW]);
>   }
>
> -void HELPER(getshadowregs)(CPUHPPAState *env)
> +static void getshadowregs(CPUHPPAState *env)
>   {
>       env->gr[1] =3D env->shadow[0];
>       env->gr[8] =3D env->shadow[1];
> @@ -108,7 +108,7 @@ void HELPER(getshadowregs)(CPUHPPAState *env)
>
>   void HELPER(rfi_r)(CPUHPPAState *env)
>   {
> -    helper_getshadowregs(env);
> +    getshadowregs(env);
>       helper_rfi(env);
>   }
>
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 6da9503f33..29e4a64e40 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -2385,14 +2385,23 @@ static bool trans_reset(DisasContext *ctx, arg_r=
eset *a)
>   #endif
>   }
>
> -static bool trans_getshadowregs(DisasContext *ctx, arg_getshadowregs *a=
)
> +static bool do_getshadowregs(DisasContext *ctx)
>   {
>       CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
> -#ifndef CONFIG_USER_ONLY
>       nullify_over(ctx);
> -    gen_helper_getshadowregs(tcg_env);
> +    tcg_gen_ld_i64(cpu_gr[1], tcg_env, offsetof(CPUHPPAState, shadow[0]=
));
> +    tcg_gen_ld_i64(cpu_gr[8], tcg_env, offsetof(CPUHPPAState, shadow[1]=
));
> +    tcg_gen_ld_i64(cpu_gr[9], tcg_env, offsetof(CPUHPPAState, shadow[2]=
));
> +    tcg_gen_ld_i64(cpu_gr[16], tcg_env, offsetof(CPUHPPAState, shadow[3=
]));
> +    tcg_gen_ld_i64(cpu_gr[17], tcg_env, offsetof(CPUHPPAState, shadow[4=
]));
> +    tcg_gen_ld_i64(cpu_gr[24], tcg_env, offsetof(CPUHPPAState, shadow[5=
]));
> +    tcg_gen_ld_i64(cpu_gr[25], tcg_env, offsetof(CPUHPPAState, shadow[6=
]));
>       return nullify_end(ctx);
> -#endif
> +}
> +
> +static bool trans_getshadowregs(DisasContext *ctx, arg_getshadowregs *a=
)
> +{
> +    return do_getshadowregs(ctx);
>   }
>
>   static bool trans_nop_addrx(DisasContext *ctx, arg_ldst *a)


