Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03D8FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 05:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIJm7-00052a-CS; Thu, 30 Apr 2026 01:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJm5-00051x-Mm
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:17:21 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJm4-00057p-1a
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:17:21 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-446fea16729so424829f8f.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777526237; x=1778131037; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AfUFXOIR52nEWaaeSeNstZ6dP+4loBEaZws9D7o2ao4=;
 b=Mw/99TmHOAFoNMXW0VcKQkFXxpjKMgSvDIltv/wmdpHHjAozZBem33R8xChmGNOdYW
 EzHVu/q8jmrvXiF5sBWFQA7L8HUYiqbyEc79i+W7xSDFPD3Mma6s+LbIhot+COTRiakC
 PusqDHVwzrmSxlfgnNJnDNL9Svj0LNKVANbrxWFyCpoD8EE8H51N9ihSMZBEbbw1bVuf
 jxIfltSF8aBB440ar1pmd3fNdozlsCEifoEnVBf/0HlHZwnrCeZ4OBNsNR4Dg1eAlGKt
 Ivggmq2B8ZThPnoFFVCJBLvwlu4p9J618BkwX/H+zDsFLn6LGxFoEFz6R0RBz9SAB2Ft
 Y64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777526237; x=1778131037;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AfUFXOIR52nEWaaeSeNstZ6dP+4loBEaZws9D7o2ao4=;
 b=aFf1/twV54GuhHECuDZakTVZKr1oYyrO4LwHLM6IZR2VJGwHdZjBbAyWRlVxLnCzDb
 5AATFaFUwuWCi94xSa1E3bYdyCqAW528Kfs6yA9ab/2j6Eiguzhp4+RrS03oNTpXrn0V
 t8xLPweA2WIyd/GrUc9awYJ2TlUnNKUzBEYiy39FR+54Arm/GIhridsksBkfjsHmvmJV
 Xy0KkKq8y6q2+rfjtr8AbOy1LUyrayDy1iLYH7SgH+QQqVYLZCeQt+okEAe3m+Eus3Uk
 Z6wzYFLcjgSc+MvhMcdNZTGn/HdfVDgvdBc+8wgVcscmq9XaXOXuyaENiI8379Rct6x0
 D1Rg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+V5G6Fu/6k1r6o/twEPr83uO8z4REMQq8WVKOrOe/OS521FZYFEapyJKaJVc/4buJdieE16Yz+bTe3@nongnu.org
X-Gm-Message-State: AOJu0Yz6hQboQCgXofkF9H4eXSqbYk9lGZhtaPIHcFS25N/xH7HyfZrZ
 CHqWfiRowMb65dFa6GbST/qRXffmJJBIG0Zxa7v3gCzjQjVn0/7UsMqwOdACcWz6uZ8=
X-Gm-Gg: AeBDiev8RAm074ZAoIqifGGA4lV9vU3cfA+B63k548JL9oE9vDu2Nvv3ZKxUEVhO4Q6
 ODDF6s6S3ujiqTRIRieeyTKjbNOCCeBWeExy926T9/dd6xv4cqTuUINlMI7wnabG3u6LNNP5Zjb
 TZ9cREMD5s+SIc55NGiz/6rx2sceiWRr4zjUWBzYFKP0t9dIfDoHVbJP7UKI9s23Q7PmnGoILVp
 3g9ykfxEvUj0TPqGHA/FWuQaPb1THPKgsnC+t38Us0ZzwTGrb9d9rCOpxl5Y49/4oSCn1XflP3m
 3j5v5M/NLvbi9ln1y1PYAm8GunRVvrjzivLup93t/LdvWlFRETG7YB4pj125gBilqyZZL35Ashu
 XrEDyuHtk6KRxkLzg89313TSRK//NE2g4RmKQnzuStX7PIXmSQgbK6PPG/aawtxrw8Dj0wtNJ2V
 eRpP0LDPzR80T1JgUwPcNSuTafZ/DbFp/thjvXLiTVykZ20uXIlWUcx8H30jzLmgRgilb9rlhND
 x3I
X-Received: by 2002:a05:6000:1a8a:b0:439:c18f:5aaf with SMTP id
 ffacd0b85a97d-4493eb6d7cfmr1981083f8f.34.1777526237442; 
 Wed, 29 Apr 2026 22:17:17 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b76e5bf2sm10889987f8f.27.2026.04.29.22.17.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 22:17:16 -0700 (PDT)
Message-ID: <9796771d-4d8f-44f9-ba8c-49f0c39a5a51@linaro.org>
Date: Thu, 30 Apr 2026 07:17:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/40] fpu: Return struct from parts{64,128}_muladd
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260430000524.56046-1-richard.henderson@linaro.org>
 <20260430000524.56046-27-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430000524.56046-27-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Hi Richard,

On 30/4/26 02:05, Richard Henderson wrote:
> At the same time, export.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/fpu/softfloat-parts.h |  9 ++++
>   fpu/softfloat.c               | 83 +++++++++++++++++------------------
>   fpu/softfloat-parts.c.inc     | 38 ++++++++--------
>   3 files changed, 69 insertions(+), 61 deletions(-)


> diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
> index 77465cce6e..09b79f8d44 100644
> --- a/fpu/softfloat-parts.c.inc
> +++ b/fpu/softfloat-parts.c.inc
> @@ -679,9 +679,8 @@ static FloatPartsN *partsN(mul)(FloatPartsN *a, FloatPartsN *b,
>    * Requires A and C extracted into a double-sized structure to provide the
>    * extra space for the widening multiply.
>    */
> -static FloatPartsN *partsN(muladd)(FloatPartsN *a, FloatPartsN *b,
> -                                   FloatPartsN *c,
> -                                   int flags, float_status *s)
> +FloatPartsN partsN(muladd)(const FloatPartsN *a, const FloatPartsN *b,
> +                           const FloatPartsN *c, int flags, float_status *s)
>   {
>       int ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
>       int c_mask = float_cmask(c->cls);
> @@ -719,10 +718,13 @@ static FloatPartsN *partsN(muladd)(FloatPartsN *a, FloatPartsN *b,
>           }
>   
>           /* Narrow with sticky bit, for proper rounding later. */
> -        fracN(truncjam)(a, &p_widen);
> -        a->sign = p_widen.sign;
> -        a->exp = p_widen.exp;
> -        return a;
> +        FloatPartsN r = {
> +            .sign = p_widen.sign,
> +            .exp = p_widen.exp,
> +            .cls = float_class_normal,

It would be clearer if the float_class_normal change start appearing
during previous reorganizative patch:

            a->cls = float_class_normal;

> +        };
> +        fracN(truncjam)(&r, &p_widen);
> +        return r;
>       }

