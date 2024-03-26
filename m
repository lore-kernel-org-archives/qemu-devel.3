Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A3ECD11DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 20:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpDVv-0000Sm-NN; Tue, 26 Mar 2024 16:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rpDVp-0000S0-IK
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 16:35:13 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rpDVn-0005An-BL
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 16:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1711485308; x=1712090108; i=deller@gmx.de;
 bh=7F6NAQM3sQ/f5huVM7PpeVv5dNoLYWUF+8mrLyQrJ98=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=RSwDFVoGrUWqMvEJX3kAn05Qjlzsq5U8lNA1OAIpBOEc8dtJQL9IW2EQJzyDTNwj
 eS49Hrf05NJLUytcKQe5eoKmPvpgdgIObjYL7FJEC8n0nqz4QDfllpUbiso/y0kZq
 uvArxK20ZDDkhYzCxB9KoJJVQ3v38WExuqeHz4QfDCVIzdnFyZThNUMLz/8aZHPpi
 qZ1XH5LJQZ+uxgCiRxoLJ+67v7Iz1qazWH8A6ceQtA7zJ78o3sJ6hN0BA4RWB8Qbb
 4tn/9lQd2netf+B9BTw0res2DFvLRTi626L6hEgNrwNvHl2IrPUBFbLiaSXOIIPjx
 VI6BWEAh3oXKJ2St+w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([89.244.180.193]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZTqW-1sKaWQ1U06-00WWuO; Tue, 26
 Mar 2024 21:35:08 +0100
Message-ID: <7b9ef2af-d137-4db4-a286-9c5ea996bff9@gmx.de>
Date: Tue, 26 Mar 2024 21:35:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] target/hppa: Fix diag instructions to set/restore
 shadow registers
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@kernel.org
References: <20240326181028.332867-1-richard.henderson@linaro.org>
 <20240326181028.332867-4-richard.henderson@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240326181028.332867-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y4sVKX2uYhW58AXuF8RevPdjthNLhQGf+j5oHzmp9b2JqZeUmeJ
 v5T9OCiV+wW72KLrt9C6wGFpEsVXEl9360xO+SAQueVwfEzkoCsRMkEbCVvYmME9M4sHUEU
 +2ppOikqZYBm0ZTqCQ6NpjkAR6E2u3rKCcSpl9rLSGnOflRlu+5MaRRa5qm+A7FgfoAr3qL
 f2m2h0bk2WcbZcxInzqZA==
UI-OutboundReport: notjunk:1;M01:P0:J228zLC89Rw=;aVynI/Wb53yDYbsRknNNeNRH7OU
 HtAfLVxeRKuxV+WIeYsRTIrNeluCwfXAJIFz0iyzTn2KzCPnq3mTKBVQJcdkfojKfqRCSfHJe
 ACUttfwv80ZHS96qGMWb6eVJ5r42ODpWhfE94AAvRYzXjU+ogKCVTzMMyO4a2LxFS8aimpBnW
 xMTccqRu/bgtRHiz2OrcJpidnAwEFT4AaaQoOkiMp3WOvZSYEQ3nAAZ7fV2acJZsMJU1/ERXs
 fUAYH4eFFqowbEtmoNOSfFQnUEhY8fkpb7QWz3m2Uyxb+cdRmfQc4fE5WjS9yoyNjXiYohYYl
 Jvj2Oj+Z5iqXlmkTssheQ5IbvyuO7XTrl8OlA+LkJoN6QQXwNLtvdeU2lFY8B5qu6W0bPqNLP
 c4molBKo9GMb9rmwtEh2VvjMe9jSXigg/LUtJC5XjvqrJwiZSX392KsKR+rONeRmTao8j6xHh
 LuQTrZLBKanPsGKis/7T4RX3gcKxsZtoe7gRB51QA04u/MGX1cuzF62E8tPqYgKnkq+Dj31UI
 h+NUPk0aXwMPPOpXkKE8XpI/2LJmTn+hCXBLemsW07BPW39BgnqpbaOmByslqqvxu1ooJu3DB
 fKaaSKkOs4GvJi8yaIw6ljtUEbK4Sd4HEUK8hjwQt0qWo3pns3jV3P+WzTmp+z1yG+qdJ4lQ5
 DerSmZoBoIbDNL68Wg5VhfDNheQpBMFuQOKrELQrWFIvT9pw9ilgMmIprPHF73MtsRUbn64ul
 SULcTC/jJ50gHJGxvkWzlNK2llyTH1dkXcPkRwn901bL1dcsB98x97sZzbwgtsifMTlxihE5y
 MG4ysauHZZsJ3vjZV9ik1Ebd9zLi9voqbsp3lybtFxa38=
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
> The 32-bit 7300LC CPU and the 64-bit PCX-W 8500 CPU use different

I initially should have used the correct naming in my patch.
So this sentence above should read:
The 32-bit PA-7300LC (PCX-L2) CPU and the 64-bit PA8700 (PCX-W2) CPU use d=
ifferent....


> diag instructions to save or restore the CPU registers to/from
> the shadow registers.
>
> Implement those per-CPU architecture diag instructions to fix those
> parts of the HP ODE testcases (L2DIAG and WDIAG, section 1) which test
> the shadow registers.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> [rth: Use decodetree to distinguish cases]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/insns.decode | 10 ++++++++++
>   target/hppa/translate.c  | 34 ++++++++++++++++++++++++++++++++++
>   2 files changed, 44 insertions(+)
>
> diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
> index 9f6ffd8e2c..c2acb3796c 100644
> --- a/target/hppa/insns.decode
> +++ b/target/hppa/insns.decode
> @@ -65,6 +65,8 @@
>   # Argument set definitions
>   ####
>
> +&empty
> +
>   # All insns that need to form a virtual address should use this set.
>   &ldst           t b x disp sp m scale size
>
> @@ -638,6 +640,14 @@ xmpyu           001110 ..... ..... 010 .0111 .00 t:=
5    r1=3D%ra64 r2=3D%rb64
>     [
>       diag_btlb               000101 00 0000 0000 0000 0001 0000 0000
>       diag_cout               000101 00 0000 0000 0000 0001 0000 0001
> +
> +    # For 32-bit 7300C

For 32-bit PA-7300LC (PCX-L2) CPU:


> +    diag_getshadowregs_pa1  000101 00 0000 0000 0001 1010 0000 0000
> +    diag_putshadowregs_pa1  000101 00 0000 0000 0001 1010 0100 0000
> +
> +    # For 64-bit PCX-W 8500

For 64-bit PA8700 (PCX-W2) CPU:


other than that:
Reviewed-by: Helge Deller <deller@gmx.de>
Tested-by: Helge Deller <deller@gmx.de>

Thanks a lot for the nice rewrite & cleanup!!
Helge


> +    diag_getshadowregs_pa2  000101 00 0111 1000 0001 1000 0100 0000
> +    diag_putshadowregs_pa2  000101 00 0111 0000 0001 1000 0100 0000
>     ]
>     diag_unimp                000101 i:26
>   }
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 42dd3f2c8d..143818c2d9 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -2399,6 +2399,20 @@ static bool do_getshadowregs(DisasContext *ctx)
>       return nullify_end(ctx);
>   }
>
> +static bool do_putshadowregs(DisasContext *ctx)
> +{
> +    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
> +    nullify_over(ctx);
> +    tcg_gen_st_i64(cpu_gr[1], tcg_env, offsetof(CPUHPPAState, shadow[0]=
));
> +    tcg_gen_st_i64(cpu_gr[8], tcg_env, offsetof(CPUHPPAState, shadow[1]=
));
> +    tcg_gen_st_i64(cpu_gr[9], tcg_env, offsetof(CPUHPPAState, shadow[2]=
));
> +    tcg_gen_st_i64(cpu_gr[16], tcg_env, offsetof(CPUHPPAState, shadow[3=
]));
> +    tcg_gen_st_i64(cpu_gr[17], tcg_env, offsetof(CPUHPPAState, shadow[4=
]));
> +    tcg_gen_st_i64(cpu_gr[24], tcg_env, offsetof(CPUHPPAState, shadow[5=
]));
> +    tcg_gen_st_i64(cpu_gr[25], tcg_env, offsetof(CPUHPPAState, shadow[6=
]));
> +    return nullify_end(ctx);
> +}
> +
>   static bool trans_getshadowregs(DisasContext *ctx, arg_getshadowregs *=
a)
>   {
>       return do_getshadowregs(ctx);
> @@ -4594,6 +4608,26 @@ static bool trans_diag_cout(DisasContext *ctx, ar=
g_diag_cout *a)
>   #endif
>   }
>
> +static bool trans_diag_getshadowregs_pa1(DisasContext *ctx, arg_empty *=
a)
> +{
> +    return !ctx->is_pa20 && do_getshadowregs(ctx);
> +}
> +
> +static bool trans_diag_getshadowregs_pa2(DisasContext *ctx, arg_empty *=
a)
> +{
> +    return ctx->is_pa20 && do_getshadowregs(ctx);
> +}
> +
> +static bool trans_diag_putshadowregs_pa1(DisasContext *ctx, arg_empty *=
a)
> +{
> +    return !ctx->is_pa20 && do_putshadowregs(ctx);
> +}
> +
> +static bool trans_diag_putshadowregs_pa2(DisasContext *ctx, arg_empty *=
a)
> +{
> +    return ctx->is_pa20 && do_putshadowregs(ctx);
> +}
> +
>   static bool trans_diag_unimp(DisasContext *ctx, arg_diag_unimp *a)
>   {
>       CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);


