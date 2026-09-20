Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4667C982D8
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 21:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8PXN-0004se-HF; Sun, 20 Sep 2026 17:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x8PXK-0004sB-F1
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 17:57:26 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x8PXI-0000OX-Sf
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 17:57:26 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2dd4b43b20bso15681915ad.1
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2026 14:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789941443; x=1790546243; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4gbkGphwB5Kd54DONWc6rHfQpiTir2lRc7BBaxNJPNg=;
 b=WlZshW6I7L5PB0C3K4mFIfY6WaINNz2I8aRMuuWC5O4pYJl+A9/COftuZUxmr8VFGi
 CWoICNTmebKEXhl55rvUa5UdFmE0bFt4TsM6bcfMt9AD3/M25f2tD6Iq2TNZHB7HLIqI
 WYaHxTz4WcoorL8dUV6D+FQzDrg0omek8Y1e8jV/QF6RpvpOpo/deryBe/58MREkrLXE
 v80BWzN3wyEV3f644NzzY+uM/Qz64aVpoKF02bKBKpQ04xFS+eTg9iWKQdMdbujEYno6
 W5vq8cvfLmtCZ3RgLC52elRBMPWrpBM1225jqQn4UsGWzG798810zexe2EoWhkZLhqfq
 E2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789941443; x=1790546243;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4gbkGphwB5Kd54DONWc6rHfQpiTir2lRc7BBaxNJPNg=;
 b=S/njJVL8Ge4GhM4hNMdCejEVmcPpWm24Vl0OBZMOpHe6Rl2s67xFblQMiNyneFPl+m
 RNLTbzlDoS6kNaCt9hdfdCzPdia7wI2SigdPAEjYRs4DZ+cpseENYDM2R6EPTSAiZHKh
 ogwmf0oNdtWEgS/ZAoMnu6p/kRyMTg42/dg9EryiZGy+PxUeyIHH95BjOjmr1GSn2Qk4
 0tKJJNNhcahS0qpSEw3q68N04ZPVjgGPIyncwteld90fT6MSY+kmXQwW87Win1hM32Vk
 jvI19w4KGXHj2vewzLwk5qIZn/5wR81Fj7W3DwDNVheEFgwfcDMnBcPHItM92vdV9qfC
 auxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxrKdqKuBx5VlsVv7sXSfjwe9gdJRjDDz8ucstJTq6lj1bZYowHz73ehCCTmJx9+PGHrffW+RHCnDsw@nongnu.org
X-Gm-Message-State: AFuF++nLVUPEgXpIYlC8Xu/URAJ+ItB1AzxfG+f9yBGwdlRn0eulGOXt
 sqfnI42bwCWZhE4waPtI78IYdbTOmcMBiNBdzGArNol1a3eEk5HNne6DC4Wh4zEnPJo=
X-Gm-Gg: AYBFou1eVhwnEnjUVPuvLxdfPJEX9lroKRU7ro2vf31LiosS7Sov/yUcU2G8xOmLq8H
 BRdZUk6dGWiGjdHTLvFHhG3ENkWumqycsL1x6ZOffdNpEl/5s8Le5Od/bVOZtr8CCS3IA/0Ndyv
 2TGfReNbszqSSK/BU5JHNm+XyPH8+zvrrHOALlfiGA80d5BX0kwAoEHS9B4Gl/WxB7bOiBN/unS
 WX8noK7KUm8e4zH+/e6dHqUcNSyDH4Z3b4c7mPVxJZiQ1Thb9OoQlBhwUr1Cl4ld10kJk3cReV9
 H1oMZ4nlC01aJfzXeTMCo6H6IwJnXP7cqAjjpkJTH9QDW3sBTpOgulMj2odiBdtIH+Ly3TQtgSQ
 f0xZ9d+odLN0SZsKZuaI0U1Gad+r6SdNQBwWFld1k+Xjqd0t8cPZimnu6oAvWWWliA91TXQ8odo
 PYA+a9r+qPVH+Q2qEgDnHEkwHBwGrsxX7cu/rlNUBeVRzQEPSTzn47B/8m0iuPkAs2b9JGgk9/O
 3O3u2NzqjwSnBp01HGU2g7hkihu1CsPdd44QS51dr8qkPvWVZL4SieLIrtCfQ==
X-Received: by 2002:a17:903:11cc:b0:2bf:27b2:4b80 with SMTP id
 d9443c01a7336-2ddb1b7a31dmr134916365ad.14.1789941442801; 
 Sun, 20 Sep 2026 14:57:22 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:5f56:e854:5df2:d786?
 ([2603:800c:7900:ed00:5f56:e854:5df2:d786])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c33186490sm12242614eec.18.2026.09.20.14.57.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2026 14:57:22 -0700 (PDT)
Message-ID: <252dc44d-be07-479e-87fc-6719a50d2a68@linaro.org>
Date: Sun, 20 Sep 2026 11:57:19 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] bsd-user: HOST_BIG_ENDIAN and TARGET_BIG_ENDIAN are
 always
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Rick Richard <rick@sloservers.com>
References: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
 <20260919-misc-2025q4-v1-1-ebfa61049bd7@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260919-misc-2025q4-v1-1-ebfa61049bd7@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/19/26 19:20, Warner Losh wrote:
> From: Rick Richard <rick@sloservers.com>
> 
> TARGET_BIG_ENDIAN and HOST_BIG_ENDIAN are always defined.
> 
> lseek and target_offset64() transpose upper and lower halves
> on 32-bit ABIs, -strace prints wrong off_t.
> 
> Signed-off-by: Rick Richard <rick@sloservers.com>
> [ fixed defined() too ]
> Reviewed-by: Warner Losh <imp@bsdimp.com>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/bsd-file.h          | 2 +-
>   bsd-user/freebsd/os-misc.h   | 2 +-
>   bsd-user/freebsd/os-thread.h | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/bsd-user/bsd-file.h b/bsd-user/bsd-file.h
> index 0fefc07232..a2c2e38e50 100644
> --- a/bsd-user/bsd-file.h
> +++ b/bsd-user/bsd-file.h
> @@ -986,7 +986,7 @@ static abi_long do_bsd_lseek(CPUArchState *env, abi_long arg1, abi_long arg2,
>           ret = get_errno(res);
>           set_second_rval(env, 0xFFFFFFFF);
>       } else {
> -#ifdef TARGET_BIG_ENDIAN
> +#if TARGET_BIG_ENDIAN
>           ret = ((res >> 32) & 0xFFFFFFFF);
>           set_second_rval(env, res & 0xFFFFFFFF);
>   #else
> diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
> index 0f87b21cc8..e9f9eed4b4 100644
> --- a/bsd-user/freebsd/os-misc.h
> +++ b/bsd-user/freebsd/os-misc.h
> @@ -336,7 +336,7 @@ static inline abi_long do_freebsd_kldsym(abi_long fileid, abi_long cmd,
>   #if TARGET_ABI_BITS == 32
>   static inline uint64_t target_offset64(uint32_t word0, uint32_t word1)
>   {
> -#ifdef TARGET_BIG_ENDIAN
> +#if TARGET_BIG_ENDIAN
>       return ((uint64_t)word0 << 32) | word1;
>   #else
>       return ((uint64_t)word1 << 32) | word0;

These first two should be converted to C if's.

r~


> diff --git a/bsd-user/freebsd/os-thread.h b/bsd-user/freebsd/os-thread.h
> index 4258b24095..6552c60337 100644
> --- a/bsd-user/freebsd/os-thread.h
> +++ b/bsd-user/freebsd/os-thread.h
> @@ -18,7 +18,7 @@
>   int safe_thr_suspend(struct timespec *timeout);
>   int safe__umtx_op(void *, int, unsigned long, void *, void *);
>   
> -#if defined(HOST_BIG_ENDIAN) == defined(TARGET_BIG_ENDIAN) && \
> +#if HOST_BIG_ENDIAN == TARGET_BIG_ENDIAN && \
>       (TARGET_ABI_BITS == HOST_LONG_BITS || defined(UMTX_OP__32BIT))
>   #define _UMTX_OPTIMIZED
>   #if defined(TARGET_ABI32)
> 


