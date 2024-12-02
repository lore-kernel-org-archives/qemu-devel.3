Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E75D78337
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI9sz-0002ty-Ex; Mon, 02 Dec 2024 12:07:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tI9sy-0002ta-Dv
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:07:00 -0500
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tI9sw-0003Ek-Ie
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:06:59 -0500
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b66d08d529so391192585a.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733159217; x=1733764017; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D2lNsWB6jrTNwA3FGnopEuemg7vKHxUjD8hprtVAXFI=;
 b=iYpgO3c51ahcVGpkPcrASyf+ZehpVp68qqbpqehLMvHLvbr14+HWut8UwSIgxpnYAK
 G3cu2RL7lyRSEmg+EWeQ8a7iRAzLLgOidLLE6TUL9J++l/E+piqGsxfgc3+QySRUfFpi
 TNGZSwVMfUbU3OHbCfZut9Sc886fiY++uyeTbohSouyF31xlCuCWjHlEjCt9fcBiLo84
 yFFet6UFYpOPr5C2M+x8lvyO+YbfnJ1u1mEXJS312Zn7JNbHeyQqPmFw4GDbAYyC3X9m
 Cf9ZIpShZ/7k3QDWM/oueY3xsdjZAv5HITSdkm8tAjZhRc47zKjm9M8OE8fMBiEHtWD3
 cMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733159217; x=1733764017;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D2lNsWB6jrTNwA3FGnopEuemg7vKHxUjD8hprtVAXFI=;
 b=hIMnOUjN1jOTSWrhqV7JKX2AUV1ZwYrT6tCOFMAvtb0+heo7V25Eieu5lT65tIsq8e
 RbNEDju3xpatR+FhxL1+G5ml4EglUpbSHg/A9sD/Y602LNM4VKnkp4HwdT2bFd1IHDcW
 OEFhLGora4l5CYMOn6MDxdqqF1qQw7aATO6UTxGd8MTslp9F5UTR+Ungmf03WAtg+rh6
 KjiTmRu9oVTfAP0UIMwycN1zgSMPbU/thIkVYAFjHT5rygoQ8w5I+JyMddB35sidhLv3
 S5Fn2J5u4DVbFqZZ1B3TVmHaSuYoSq3hbMQXZ6Up7n1AkP72Zf5YXn9NSmWW1CJoSSEl
 SDQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiEZwsBoaeXCIMSeoc4RJzTNzvtXenrsR7i1bd+hiG5fmx5RVdKqV6SfJXFGp0LzQGjuJJPr21Xb/B@nongnu.org
X-Gm-Message-State: AOJu0YwOSAFf3smEQikJe1wRcyTKjwg4j8GuEUab2ScHrSue5W7TsWwU
 yqBQdhprwhxIg51o/ef+rK4HgNMcLeQ7i4x4jVb1n+VzgafTMPUNgKQUNEAssgQ=
X-Gm-Gg: ASbGncu1LSKc2PByXm9y5B0YAYO6IM3orEDNQ4L5dfN4zRn2BOxCkHfwTb+GBe5jNR5
 WX1YlC+USQ+WrLYANljYoXvWq3FYcKlU5LoqCgK1p0AmCASSSfGioxumoIjBxjhGbhGRCyyXYOv
 UZwf6+4VEfTfJBbK7gYCgtV4urg/OqNY1n8jjl1b7RChBFAHym/ZWKcigxuJ+lxJ1qpyGGFgB6C
 SmUq/OV3KpXoFT2LuG1Wih81WAYTWc6EaDoULmGpbz2kpMeGYrPkIgTF4CXpd9rmWKWW9s=
X-Google-Smtp-Source: AGHT+IHPly1bFVeFaHmsQoiG2qD5qkNC5PApwHLzJ25rOteGvccwM+IgnyMWULOVgn6/Ef92zYhkpQ==
X-Received: by 2002:a05:620a:3727:b0:7b6:5c7a:52 with SMTP id
 af79cd13be357-7b6839c563cmr3197359185a.4.1733159217323; 
 Mon, 02 Dec 2024 09:06:57 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b684944f32sm423897585a.54.2024.12.02.09.06.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:06:57 -0800 (PST)
Message-ID: <2c435d42-52ec-480c-9748-2fb93ba4522e@linaro.org>
Date: Mon, 2 Dec 2024 11:06:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 11/54] target/x86: Set FloatInfZeroNaNRule
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-12-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x731.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/2/24 07:13, Peter Maydell wrote:
> Set the FloatInfZeroNaNRule explicitly for the x86 target.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v1->v2: Update the comment to give the info from the x86
> spec rather than a TODO comment saying we need to check it...
> ---
>   target/i386/tcg/fpu_helper.c   | 7 +++++++
>   fpu/softfloat-specialize.c.inc | 2 +-
>   2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
> index 53b49bb2977..a98b4f67ff0 100644
> --- a/target/i386/tcg/fpu_helper.c
> +++ b/target/i386/tcg/fpu_helper.c
> @@ -173,6 +173,13 @@ void cpu_init_fp_statuses(CPUX86State *env)
>        */
>       set_float_2nan_prop_rule(float_2nan_prop_x87, &env->mmx_status);
>       set_float_2nan_prop_rule(float_2nan_prop_x87, &env->sse_status);
> +    /*
> +     * Only SSE has multiply-add instructions. In the SDM Section 14.5.2
> +     * "Fused-Multiply-ADD (FMA) Numeric Behavior" the NaN handling is
> +     * specified -- for 0 * inf + NaN the input NaN is selected, and if
> +     * there are multiple input NaNs athey are selected in the order a, b, c.

"athey"

r~

