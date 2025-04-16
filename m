Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002B0C369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 19:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u582x-0007sp-Mo; Wed, 16 Apr 2025 15:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u582w-0007sb-DN
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:03:42 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u582u-0003z9-BP
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:03:42 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-223fb0f619dso419955ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 12:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744830219; x=1745435019; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GWaw/85VgbqmnW5jtSyMcsIX/+EzF1RIDX7Z6BsLX2Y=;
 b=QtKyJamgyi8bN/F9a99w6Do3fENsO8lc/nEc31dZ1Mv7Yibp9GAJdKS4Iww29IACaH
 3IOnlsiltrrgUHzZgvJz7JHsn62+54Jv26j1g3bkTLkugJscHLNapcAnpbqACIV+vC0O
 dt1qbRVprIhggIO45Q0tKP56FmKz70hzfLiZp832awmb9ltJD1Od0TXPxYZsp7UEM54z
 LySaS3Q7NKDLLgXw2caTUP8atTQBp8rHlzG3bN0pKJGMZnUEYs4VcXfqTwfNbtDZKMoG
 dQRX2/PLwiahu8L78Bs+1yCVVttVUvzYlaKBoX8WwFfOWEFESDnUTqo4+KZuvKjdOKEY
 gMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744830219; x=1745435019;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GWaw/85VgbqmnW5jtSyMcsIX/+EzF1RIDX7Z6BsLX2Y=;
 b=PjLWPeOMBlIK0W3J+ZEACzkGzChIAf5tuSOE02iEqeV74VJ++P1bW0QGjOAgzsyAGF
 hSoN9RfWJOShLJ7od+WL4SxAtRR25R03cX17klhrI4lvRtTTfqqEGppZRZGkCsW+gza/
 6LSUsiCRIQ+VN/wjEz9upY/Jvl2rA6i/EqaonU/WgL5zQDCgEUjuky2QHXObr1TEkoSJ
 eOLC24yFJvFWGrZEcaaW66PB9GLIXz0sXB9pWiNKrg1hb5gl+HlyQIle3E/bj/G/bwIR
 oAXBo+PDLjQrJM4exUqeDx7GbRI44AGj8fQnyLooPQ6wNLD45i02saludSNk5pJ0yrNh
 kutw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzGQCOJ3uKy/+8xl7OEn8SiHvrT5/3SDNQUSeLa/4621xNHVfudLiWST7oNdKdI/a+eQd6i4kbjHiL@nongnu.org
X-Gm-Message-State: AOJu0Ywmrvdc4iX/YmR7KC9x914COXJKKSg8G/Qac6fbVWBTJg0P+0g2
 mXVvPIxiuHbiqLqXitGQoMdj3aHm38euOQXZvBKhyvhHk5eZp62EG52HkgvERJw=
X-Gm-Gg: ASbGncsshoylB4nyCsB9+yhT6mBLTaqZx1CKzeLBlOkaKOEKmLVfaTSDqLRjp/HWnTl
 Weas9rMHhHij+fdv/0RW17gRl55Rl6cxxsHQ2FqWMshMoVhZJcwBFORt2KVanYAtdsm50neFCfO
 BCPuXyV+InMw438PwWCwuKRtheYJO4+1vTgmC7ltoWnuY5EYE3u2zyf1Y9NonmHSDpJ9+E5YAez
 8AUY0xZt8FVv/Uw0A+mou1UfDRRrDr5aRDF7Trd9nZn7bSCGbRPBIl7NcEzu7+01u9TvIm8Z/Rb
 Ti4hKMBWX2KIsJ+5GoGW32PxoXedXrJwk/M7bM9YNwW4xGXnxf+IO0a2I/T7RSbN
X-Google-Smtp-Source: AGHT+IFpf/uGef+ar0V7z3v/9LICm2pkwQFqegrq1bOnoGt1KVUpRZctzSLG2aTVolgLzBQ4S7IMAA==
X-Received: by 2002:a17:903:247:b0:216:410d:4c53 with SMTP id
 d9443c01a7336-22c3597eeb9mr50370385ad.41.1744830218768; 
 Wed, 16 Apr 2025 12:03:38 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33ef1190sm18038275ad.9.2025.04.16.12.03.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 12:03:38 -0700 (PDT)
Message-ID: <2e8510ab-459e-4a37-a37a-b8b74a74146c@linaro.org>
Date: Wed, 16 Apr 2025 12:03:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 116/163] tcg/optimize: With two const operands, prefer
 0 in arg1
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-117-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-117-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 4/15/25 12:24, Richard Henderson wrote:
> For most binary operands, two const operands fold.
> However, the add/sub carry opcodes have a third input.
> Prefer "reg, zero, const" since many risc hosts have a
> zero register that can fit a "reg, reg, const" insn format.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 1b3d0b5b5d..442f5b75e6 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -725,12 +725,18 @@ static int do_constant_folding_cond(TCGType type, TCGArg x,
>   
>   #define NO_DEST  temp_arg(NULL)
>   
> +static int pref_commutative(TempOptInfo *ti)
> +{
> +    /* Slight preference for non-zero constants second. */
> +    return !ti_is_const(ti) ? 0 : ti_const_val(ti) ? 3 : 2;
> +}
> +
>   static bool swap_commutative(TCGArg dest, TCGArg *p1, TCGArg *p2)
>   {
>       TCGArg a1 = *p1, a2 = *p2;
>       int sum = 0;
> -    sum += arg_is_const(a1);
> -    sum -= arg_is_const(a2);
> +    sum += pref_commutative(arg_info(a1));
> +    sum -= pref_commutative(arg_info(a2));
>   
>       /* Prefer the constant in second argument, and then the form
>          op a, a, b, which is better handled on non-RISC hosts. */
> @@ -745,10 +751,10 @@ static bool swap_commutative(TCGArg dest, TCGArg *p1, TCGArg *p2)
>   static bool swap_commutative2(TCGArg *p1, TCGArg *p2)
>   {
>       int sum = 0;
> -    sum += arg_is_const(p1[0]);
> -    sum += arg_is_const(p1[1]);
> -    sum -= arg_is_const(p2[0]);
> -    sum -= arg_is_const(p2[1]);
> +    sum += pref_commutative(arg_info(p1[0]));
> +    sum += pref_commutative(arg_info(p1[1]));
> +    sum -= pref_commutative(arg_info(p2[0]));
> +    sum -= pref_commutative(arg_info(p2[1]));
>       if (sum > 0) {
>           TCGArg t;
>           t = p1[0], p1[0] = p2[0], p2[0] = t;

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


