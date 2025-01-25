Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE2DC0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 15:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbhvD-0003cn-AN; Sat, 25 Jan 2025 10:18:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbhvB-0003cZ-FN
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:18:05 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbhv9-0002tu-Nn
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:18:05 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso53922545ad.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 07:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737818282; x=1738423082; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nGmr/qwYf+E4m3O5TYe7djPD7f7ZT3QSVUqf2Qic+4w=;
 b=hwdoO1tgVIgqeYBrw0BFCvYBz7WcLxhgTpdZAmP3U8bDQqYTStSL4TQkT0DJrpm13M
 QJ86KCV6HeNvHtKMNUePEVLdl9DLQ+C5b/oyVceaQeZF/FVIyjoqnwkYVCU3iV8L/4Pt
 0ZoJyQXuAnlytV5VQTffx/d16RrZ4atfRHYlskiphaMz5BAXGYUUbLK3Zn8ta8BWY76g
 DDkiBK8UaYVQ1uHfRvF83dMb6P5g94eLGsBWSJvKU0VyH32sTq7w9ig/OJbJPPTJNzYC
 bW4TwJgd5PbgVMT/Uc7ceJGbkrtkxtOw72C+TGcRmrgi2kwvVzZD6H3lOGikATWRgblA
 35eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737818282; x=1738423082;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nGmr/qwYf+E4m3O5TYe7djPD7f7ZT3QSVUqf2Qic+4w=;
 b=fPS5+KAk0NiLpO7v7WePpMXj2+PHxPbZYANcuZhUuo7x06tqTw/W2TzQdYEInsyf5d
 uBGz8aTFqXvHlowTz3VmP7+K0yKuo4Rz8out4AGT7fIk8SIvOhJbCl1oxbI50bxIMDYL
 DvkgDHzCWIqpFrZskzMTBddF6Tz40YwTtpBuKcJTOtGHsqUFT1938jJuM6o1WsSE/bej
 xheQtSiwzwD1LDytiYQ7EqVB7HI/z4J+ODpqhlLv+a7I1RdxBcoixUCMMk2u9PshsaKC
 8URUetT4Bo9tjUW7AmYySCQR2HbSqFvQ2nSPTRu7ftqwiEEHfeIwTw6CqdfzNP4ceLkc
 pUAA==
X-Gm-Message-State: AOJu0YzBTLb1i2lM59Nf/mg+HKJ2WeGqi9cN0l39kDXgbGteehC9wA/p
 TqlIeMWEoeOYpFJWKrHukbW60sBIbw2cvM12/ao6jLjZrMC0egZKkTrYVBqNqqVtXTT8VWe3muI
 Y
X-Gm-Gg: ASbGncvYzr4AS1V7FVDi3gTXrFNvpdHXLHY5GF55nD+7XqeD+2kv6GbG1Go+sDDpRya
 nCrvbxH8YvlD0aKjDZaHD7Xyt9KsOhAgF/AI5AwwKFctED+gUdbIB6XXK4mJUoBBnZDDIpPhikr
 SCDe+2b9qy0oEebW1mSkMT8H1+4PLfxBmX40ZXeqy1T6voBdC7Pl4EHz7aHwb4p2gZ0NtinT2kN
 o/8+z8A41YhuCfb/K6mYC63NUEvekr4YXsj/yq1XBz0JPtOWbOQ3n7Q3bwpvhdm9JHShzeH6PAf
 +TWpd5IMbVFIYZjuyYuBgw==
X-Google-Smtp-Source: AGHT+IGO9/rh58Q9xHPPaYwGm+ay1bppOh+WaIwtGnzZ630mwHJ459v9xJvuziumaHYD2g9DZARruQ==
X-Received: by 2002:a05:6a00:4c90:b0:728:ac38:4bee with SMTP id
 d2e1a72fcca58-72daf9ac957mr48069739b3a.2.1737818282358; 
 Sat, 25 Jan 2025 07:18:02 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a77c75asm3915979b3a.136.2025.01.25.07.18.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 07:18:02 -0800 (PST)
Message-ID: <91f8dab7-181a-4621-8266-502c8a5d2b7c@linaro.org>
Date: Sat, 25 Jan 2025 07:18:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/76] target/arm: Use fp_status_a32 in vfp_cmp helpers
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-10-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/25 08:27, Peter Maydell wrote:
> The helpers vfp_cmps, vfp_cmpes, vfp_cmpd, vfp_cmped are used only from
> the A32 decoder; the A64 decoder uses separate vfp_cmps_a64 etc helpers
> (because for A64 we update the main NZCV flags and for A32 we update
> the FPSCR NZCV flags). So we can make these helpers use the fp_status_a32
> field instead of fp_status.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> We could in theory make A32 use the a64 helpers and do the setting
> of vfp.fpsr NZCV in the generated code from the helper return value,
> but it doesn't seem worthwhile to me.
> ---
>   target/arm/vfp_helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
> index 0671ba3a88b..034f26e5daa 100644
> --- a/target/arm/vfp_helper.c
> +++ b/target/arm/vfp_helper.c
> @@ -373,8 +373,8 @@ void VFP_HELPER(cmpe, P)(ARGTYPE a, ARGTYPE b, CPUARMState *env) \
>           FLOATTYPE ## _compare(a, b, &env->vfp.FPST)); \
>   }
>   DO_VFP_cmp(h, float16, dh_ctype_f16, fp_status_f16)
> -DO_VFP_cmp(s, float32, float32, fp_status)
> -DO_VFP_cmp(d, float64, float64, fp_status)
> +DO_VFP_cmp(s, float32, float32, fp_status_a32)
> +DO_VFP_cmp(d, float64, float64, fp_status_a32)
>   #undef DO_VFP_cmp
>   
>   /* Integer to float and float to integer conversions */

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

