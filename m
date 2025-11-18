Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A749CEBF93
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 08:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLHQz-00057G-Hb; Tue, 18 Nov 2025 03:51:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLHQx-000573-3g
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 03:51:31 -0500
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLHQv-0002aI-Ea
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 03:51:30 -0500
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-4335726d0f2so19362275ab.1
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 00:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763455888; x=1764060688; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AeCMlJ0oFDB6DCdqA9G02/nnVAqKEFijozNBwGkclCU=;
 b=avxPFaF96KHzwVhsKrss2raouWvnUIQdAdaDVXCV09lYtu+CLbFMR3pUTqdsAfpWSH
 rrbCTu2zaW13lVh4rqvTVPBmnkCK/vZQBQH6Lt9p0VnAG1dvfvPAPx/YzJPyhcUJQkSj
 XYpql1VXAywEllxSRvZIXHkvi/s8DqLm3I2xpeIgJKDA0wJc9l+rTiYLdN4p0HoIs8If
 ZyRI9A59e0UkE/zENJTSbNxHgoMifbv2XWQaan4QUtH6V21AB3dKXI3lnjFMVGjvGR1E
 1hXftpS6pxD0w+3+eYc0UF7CkYdYbaJsZZT6iSOOS6pDltcCbLfqFJxqNmgYhPeH8ue2
 FU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763455888; x=1764060688;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AeCMlJ0oFDB6DCdqA9G02/nnVAqKEFijozNBwGkclCU=;
 b=MdLVEEnfK4kDXkrhMQKkXMSFLfM1W0bNCv1dYXS6oijbZsrPdWmaDpMvdFtqHbClqt
 hDdbOSBn1S7rKZ1+HTQfcvXyfVytS3UI76wrqd4dp9rQdabxiB56gyqMVIvf8UIa9QdW
 oyJteoEBbC7jkaPRE5HT0Q0Fiwayrf2gCU2p7oik3CmFOenyhp+WX8W2KpBJm1cr9F6+
 2uxR4ZcMSb0jfmibdIxxwdsGUHEhi7iwYPCsqTHXDEHMApSDvMHmUZVsSKPNEEzVUctN
 GgWVFnboty8Gf1oUz7gSEQqnCP7vFQO1cdHeg6B31N8xBR5IV3BcrQ42i2IOtn8TMCTL
 s8Kg==
X-Gm-Message-State: AOJu0Yy/Z7IF/vrhtlKy2cXaXSPUp+1p5TVf/ne4SOHmt1A/I0wNGM0v
 0RGlTJcbRZz8iRn0wXFVJNa9vh+tsBViHho85QnYeHEuVfbq5hZKki/iMQ8L+VHsY5dzCTrEhuU
 dvP8YWfI=
X-Gm-Gg: ASbGncttvQCG+i9l5Ir9qiqK/8eFSY6G9/hFR3xIDW6IAvl44wsiNuthdUbc/laSj/G
 KDMgLatpZuGEInfgebQkMB1KZ7v1QfArsQmiAzc2VBdV5oH9Wfoy4rVOwiqixxcURRnyfZXHc2X
 gJbsIOzZn5COyAa6HPXRN4gGVAur7A40GS9Kjsl8csWZBzAQK1ZQ6zS519E9f62DLFHBRN+RnqB
 i44aEqx8WdT+fp2sCJN0aWoAdlm49f4dMjLvG8GBmUNzUywk8rIcR7+72pnv4iZ4aTOTvUmMNnj
 xcYzwo7R/31qpmDyj8aOGZOjk1lGX/i4ywBXcQUSykZ9G2w/DvUMUJo7cpLF0TxRIkuaWWDvEAQ
 HuSdSU+F984nisMJ2Yj9w8AiQMW63PlGkpMqpm5i5gnNW7qhdhC5YreO4m7ZzjsdKn9G7h5BKBT
 PgJfwH7iIbjG7rCurYCeKCMXU4NhMdNBwLmjJSTm+L1jdI3iW/nAHufcDnDVmoVcTgEbZGedSf4
 gdP0A==
X-Google-Smtp-Source: AGHT+IGAWq8aBEW9GP9m37+HFNa5SEeUOW00vlnqIp8A66hQthCJz0RkVbohyNTdxSqPOw45+AgkhQ==
X-Received: by 2002:a92:cacb:0:b0:435:9247:12c6 with SMTP id
 e9e14a558f8ab-43592471494mr27943835ab.34.1763455888115; 
 Tue, 18 Nov 2025 00:51:28 -0800 (PST)
Received: from [10.89.10.227] ([172.59.191.229])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-5b7bd3171cbsm5819424173.32.2025.11.18.00.51.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 00:51:27 -0800 (PST)
Message-ID: <c3643b7e-fe13-4659-a510-0e2cc15c3acd@linaro.org>
Date: Tue, 18 Nov 2025 09:51:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.2 3/3] target/arm/tcg: Undefine Solaris FSCALE
 definition as a kludge
To: qemu-devel@nongnu.org
References: <20251117203834.83713-1-philmd@linaro.org>
 <20251117203834.83713-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251117203834.83713-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 11/17/25 21:38, Philippe Mathieu-Daudé wrote:
>   CONFIG_SOLARIS_FSCALE
> 
> Solaris defines FSCALE in <sys/param.h>:
> 
>    301 /*
>    302  * Scale factor for scaled integers used to count
>    303  * %cpu time and load averages.
>    304  */
>    305 #define FSHIFT  8               /* bits to right of fixed binary point */
>    306 #define FSCALE  (1<<FSHIFT)
> 
> When emulating the SVE FSCALE instruction, we defines the same name
> in decodetree format in target/arm/tcg/sve.decode:
> 
>    1129:FSCALE          01100101 .. 00 1001 100 ... ..... .....    @rdn_pg_rm
> 
> This leads to a definition clash:
> 
>    In file included from ../target/arm/tcg/translate-sve.c:21:
>    ../target/arm/tcg/translate.h:875:17: error: pasting "trans_" and "(" does not give a valid preprocessing token
>      875 |     static bool trans_##NAME(DisasContext *s, arg_##NAME *a) \
>          |                 ^~~~~~
>    ../target/arm/tcg/translate-sve.c:4205:5: note: in expansion of macro 'TRANS_FEAT'
>     4205 |     TRANS_FEAT(NAME, FEAT, gen_gvec_fpst_arg_zpzz, name##_zpzz_fns[a->esz], a)
>          |     ^~~~~~~~~~
>    ../target/arm/tcg/translate-sve.c:4249:1: note: in expansion of macro 'DO_ZPZZ_FP'
>     4249 | DO_ZPZZ_FP(FSCALE, aa64_sve, sve_fscalbn)
>          | ^~~~~~~~~~
>    ../target/arm/tcg/translate-sve.c:4249:12: error: expected declaration specifiers or '...' before numeric constant
>     4249 | DO_ZPZZ_FP(FSCALE, aa64_sve, sve_fscalbn)
>          |            ^~~~~~
>    ../target/arm/tcg/translate.h:875:25: note: in definition of macro 'TRANS_FEAT'
>      875 |     static bool trans_##NAME(DisasContext *s, arg_##NAME *a) \
>          |                         ^~~~
>    ../target/arm/tcg/translate-sve.c:4249:1: note: in expansion of macro 'DO_ZPZZ_FP'
>     4249 | DO_ZPZZ_FP(FSCALE, aa64_sve, sve_fscalbn)
>          | ^~~~~~~~~~
>    ../target/arm/tcg/translate.h:875:47: error: pasting "arg_" and "(" does not give a valid preprocessing token
>      875 |     static bool trans_##NAME(DisasContext *s, arg_##NAME *a) \
>          |                                               ^~~~
>    ../target/arm/tcg/translate-sve.c:4205:5: note: in expansion of macro 'TRANS_FEAT'
>     4205 |     TRANS_FEAT(NAME, FEAT, gen_gvec_fpst_arg_zpzz, name##_zpzz_fns[a->esz], a)
>          |     ^~~~~~~~~~
>    ../target/arm/tcg/translate-sve.c:4249:1: note: in expansion of macro 'DO_ZPZZ_FP'
>     4249 | DO_ZPZZ_FP(FSCALE, aa64_sve, sve_fscalbn)
>          | ^~~~~~~~~~
>    In file included from ../target/arm/tcg/translate-sve.c:100:
>    libqemu-aarch64-softmmu.a.p/decode-sve.c.inc:1227:13: warning: 'trans_FSCALE' used but never defined
>     1227 | static bool trans_FSCALE(DisasContext *ctx, arg_FSCALE *a);
>          |             ^~~~~~~~~~~~
>    ../target/arm/tcg/translate-sve.c:4249:30: warning: 'sve_fscalbn_zpzz_fns' defined but not used [-Wunused-const-variable=]
>     4249 | DO_ZPZZ_FP(FSCALE, aa64_sve, sve_fscalbn)
>          |                              ^~~~~~~~~~~
>    ../target/arm/tcg/translate-sve.c:4201:42: note: in definition of macro 'DO_ZPZZ_FP'
>     4201 |     static gen_helper_gvec_4_ptr * const name##_zpzz_fns[4] = { \
>          |                                          ^~~~
> 
> As a kludge, check the definition existence with meson, then undefine
> it locally in target/arm/tcg/translate-sve.c file.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   meson.build                    | 3 +++
>   target/arm/tcg/translate-sve.c | 3 +++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index 72edd6097a4..65dd2bc6873 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2779,6 +2779,9 @@ config_host_data.set('HAVE_TCP_KEEPINTVL',
>                        #endif
>                        int main(void) { return 0; }''',
>                        name: 'Win32 TCP_KEEPINTVL'))
> +if host_os == 'sunos'
> +  config_host_data.set('CONFIG_SOLARIS_FSCALE', cc.has_header_symbol('sys/param.h', 'FSCALE'))
> +endif
>   
>   # has_member
>   config_host_data.set('HAVE_SIGEV_NOTIFY_THREAD_ID',
> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
> index 07b827fa8e8..b6fd069aa0c 100644
> --- a/target/arm/tcg/translate-sve.c
> +++ b/target/arm/tcg/translate-sve.c
> @@ -4246,6 +4246,9 @@ DO_ZPZZ_AH_FP_B16(FMAX_zpzz, aa64_sve, sve_fmax, sve_ah_fmax)
>   DO_ZPZZ_FP_B16(FMINNM_zpzz, aa64_sve, sve_fminnum)
>   DO_ZPZZ_FP_B16(FMAXNM_zpzz, aa64_sve, sve_fmaxnum)
>   DO_ZPZZ_AH_FP(FABD, aa64_sve, sve_fabd, sve_ah_fabd)
> +#ifdef CONFIG_SOLARIS_FSCALE
> +#undef FSCALE /* Kludge for Solaris which defines FSCALE in <sys/param.h> */
> +#endif
>   DO_ZPZZ_FP(FSCALE, aa64_sve, sve_fscalbn)
>   DO_ZPZZ_FP(FDIV, aa64_sve, sve_fdiv)
>   DO_ZPZZ_FP(FMULX, aa64_sve, sve_fmulx)

You don't need an ifdef for undef, just undef it.


r~

