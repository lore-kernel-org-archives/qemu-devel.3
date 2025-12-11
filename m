Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DD0D41D67
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 16:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTjTY-0005tL-AK; Thu, 11 Dec 2025 11:25:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTjTS-0005nb-TQ
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:25:04 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTjTR-0001G9-58
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:25:02 -0500
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7c7613db390so162452a34.2
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 08:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765470300; x=1766075100; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nV2VtpWWa8VeTaTesTbiIhHAtYaDZ6xWXQU5KQ9yejk=;
 b=NFz3VwgLf0nfHfcpDiQuRSxS1euChy/jH4xo8fLYgO6qkj0ZUxS8AzcansJAsUiOAC
 2FP4hhi/IbDIrYIJ6AruqYDrs3J0ECB1pWhkuR2tx0ul2Ubj493a40f5Uq7MsefoEenl
 JDsOV0eslpjvYevLxbDF4ugh9czOtP5O9X/fq7uFTdhiYIETO5NbmKsibzIWpIyd9UDD
 7iTI2gQgfNNh+nC5TIOBrCz2uDDMe9r3elcPOjMbh11Y6aRPtS9j9Dp4CzrrE8ABqNPU
 4/NZXDP+b1ifsU9+YNS0734c43dJd+TX5v5VKPSEYMt7upHwV5eSrYVFbxdTaGGZfhcX
 nevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765470300; x=1766075100;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nV2VtpWWa8VeTaTesTbiIhHAtYaDZ6xWXQU5KQ9yejk=;
 b=rs5qMBXKYhh+SPIdo6ZMAzOQyFYR2gQKL7y17Zu1ds23ZZHExZBHC3SN0llunjX/ic
 TbhLqpU94sbW9xPsIE5XtIoLxOcZGF1DjNrAKw2AZuOTrIe4tQBKBnK35YN1x37lNwHU
 54Mx6ZSv2Ml+neRx0r1AStFEjE54OWxHVMEUQw3WqHgNr08Kut+qs+PxRNqcpZXJxGdW
 J4WLeWMQeZWiCdnaNk87/JitUh/R/f/nsJAp4u590D+Xx1fcvicsR7i1N/OVzqxwKh18
 nAnc8RCxkCWbz+TO/DCbW5WM55eTytNj+Z8nw+vuxw0ZulrVi5AmasXULvFtHhHPsDtv
 8CoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHCa1wD073vVnfZfkj23HZMvSXDNT4gLsDVPj4XVoaLfE86gJLXGxYOxNaazTI6m3M07q5SFBhvriU@nongnu.org
X-Gm-Message-State: AOJu0YwHNP5bZWtCO9h0bEr8LMy8E4mksKHDoRAQpNvkVN0tgsKtl0Ev
 vLGbG12U24PcB+PvX/MxC5sR53PwGzm/07wxlFeLKeR+caxIMAROtG5p4j26yq8mumU=
X-Gm-Gg: AY/fxX6KiNXnBpmk31iJNlsRSsqHPu9mss5IfhueGeOpYfzAOS97scGutslO1jpo1VZ
 f1XSquY8/unFcmMe2cUH99WdiQUnollx1H1bU5eaZllm7yZKB0+UPuQx2Yh66ff1DpWV4PfTAjT
 oYVISJZcFfdkfv0hctLYNzs4Wc/7k9AVOI6n4toOD0aq6W2SEPCCUgwfVBqbNpcSQiOGh9gYQMN
 Y52jIpwNYto7mL7GD5d09FQJaW3zG9B9f1DGX7JElZn7IuzNQd0kYX7qCfKT5CLm1h064tJdOBA
 XhVSZ3tgpZcLHYklj1MMLsHKwIthOBz9CMeF8jb6JHaF2XnOjNI8fi5MoSwJ0YiyVDRl9D0x+wX
 ylhx8otXUvhVAdnRwZ/8TBZ2g1FtcB+iF34C9CFfmjzIZXwflZZOudG2kUXWGY9AcQekzXD9e8N
 13sBoYTKcquoNdw1I4nmorBsDWXmwoT1jVkuaVG8lX3pqSwRW2DNv0pXHS0m5Qaz6T
X-Google-Smtp-Source: AGHT+IEoomivtGtTENL2L4DohWX19tmEYxrjcXtZxWAThU1jAsYHAGMQpxDcF9adLX+qgReGxnu+ZQ==
X-Received: by 2002:a05:6830:2406:b0:7c7:2cdb:ff4b with SMTP id
 46e09a7af769-7cacec35756mr3596514a34.20.1765470299778; 
 Thu, 11 Dec 2025 08:24:59 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cadb1d0e44sm1816054a34.4.2025.12.11.08.24.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 08:24:59 -0800 (PST)
Message-ID: <efaeeaf6-953d-454c-8e33-5eb3c912e198@linaro.org>
Date: Thu, 11 Dec 2025 10:24:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/18] target/i386/tcg: reuse gen_helper_fp_arith_ST0_FT0
 for fcom STn and fcomp STn
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20251210131653.852163-1-pbonzini@redhat.com>
 <20251210131653.852163-12-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251210131653.852163-12-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

On 12/10/25 07:16, Paolo Bonzini wrote:
> Treat specially the undocumented ops, instead of treating specially the
> two d8/0 opcodes that have undocumented variants: just call
> gen_helper_fp_arith_ST0_FT0 for all opcodes in the d8/0 encoding.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index 3c55b62bdec..8f50071a4f4 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -2777,7 +2777,7 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
>                   break;
>               }
>               break;
> -        case 0x00: case 0x01: case 0x04 ... 0x07: /* fxxx st, sti */
> +        case 0x00 ... 0x07: /* fxxx st, sti */
>               gen_helper_fmov_FT0_STN(tcg_env,
>                                       tcg_constant_i32(opreg));
>               gen_helper_fp_arith_ST0_FT0(op & 7);
> @@ -2790,12 +2790,10 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
>                   gen_helper_fpop(tcg_env);
>               }
>               break;
> -        case 0x02: /* fcom */
>           case 0x22: /* fcom2, undocumented op */
>               gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
>               gen_helper_fcom_ST0_FT0(tcg_env);
>               break;
> -        case 0x03: /* fcomp */
>           case 0x23: /* fcomp3, undocumented op */
>           case 0x32: /* fcomp5, undocumented op */
>               gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

