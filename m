Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946B9CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmhT-0003pN-7j; Wed, 03 Sep 2025 08:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utmhK-0003oj-UN
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:34:47 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utmhI-0004Nt-1r
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:34:46 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b0415e03e25so500154066b.0
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 05:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756902882; x=1757507682; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vBaHsfDe8P7KwiBlbvzLrVAZAmqGGTji+Gl8IFTgJY8=;
 b=t+7nSwMte9Jpa7jWOVzdHH2xfH8YwnOBjIKS7ysfMumceMDYCKvxgig33O7FG6qicl
 b3oTlyUE2Tu9dcbbXTLd/1qn6HjAKKfXF5LQyjzjqPncpBJcQxa8vv7VT12cKc6pFJSO
 eO4QL2R3Y408AYn5rKs53xV9Sv+oUWA+DFJUhOIe9Z+P03bo/HX8NOjDnlGvjanv7O6P
 WGUiUtpcGog2Oc4MDy5b/hCoB17MxmLiX3qWAj7H74AYdXX5WXoiIwQCWptExbcRvW6D
 VwGvTgcqLjZI70+Qi0vwV7L5i7/P4oOyVZs9Xg6Yj7YkZjGleonTLpwMnXPo0WlcRfC+
 t2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756902882; x=1757507682;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vBaHsfDe8P7KwiBlbvzLrVAZAmqGGTji+Gl8IFTgJY8=;
 b=A9bAzcK8AV2IthlEOCyS3U5wfS6FMfH2pTwmKc6i89iehntjEZxPpRlNV3H3p+kyTQ
 HXV+7doZlXfpw7hLomNOR4kxDoN+3HymwKoI3XY67E18X38hPXn7id9x47RzhMv/5tEG
 8ukLLbEBLheAtYqy2ZwNz4PNWrpZmmZa1Ni2Ope8niDFipa6wvlIwPzpapTsxRhAjWu3
 KgyQXw4mCWKkKuIHA2ARhwwFbNnY0/0kfFQhMLKTT7xZWucax6a55F0sHSyzf9lN7Je7
 UXc3QHzF8LdYJkmuBmqlgAwProhV4J3uF26pM4JovEnZlY6V/aoDLHec0mG1w4VaIm4V
 NYtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzc/6JdjE0YgywkrfZl1IftNQ8SJO1meE6Fd7f9qvx2Kllv8NIEhCKZqQSfuDIxf/JMfXcc3xZpw16@nongnu.org
X-Gm-Message-State: AOJu0YyrBzikzvcmZajLsF8fctil08iGXsIslKrPitaxH2l2rOUhCm8W
 8/yCr0XDuJPkClkmvY+ZpoeziCQlr/bCs9FEnVe/xfUR1wPag2BTuZq6i5GiWet+j5c=
X-Gm-Gg: ASbGncvXo3WuMrw5IZi+iQj/EnmBwhWLfLhX7VMI+Ym7rlkFx1zTTZW5kMKoL/c8ChL
 K23KefwOZ4VreKxEdIUIr3axgIhuf0uKYFYuG38pi25fs/3BfbET+9V+5xmwJAEPYfIBiQQ4hNH
 JYFTEOpvIRdUfsubAO696eBXOfrr2HAqlQTC4HnDEXgAm6BTaZqk1dlyM6VRaFheXpmM1Ux7Q/e
 t/EwxGfHNr1mefA4RFu3yoihugNI0ukyI2L88bfYhjGMG9f2uoFvkIxMjjuphSr1dAda4vZjYEq
 Sf3zh5IZZU6OkVtcfqLoe+Anc32Q7tABHmM89ugTWM5qxcGRgIojRx2Ow0elPtnQSYBLTFj3Bsk
 iU4WaSDdiuk7yrMzV9MD7jqDknKGx66VxldBZ6riVZ9BQtHchj7sxVsZp/zbVxl+c4lgxX14fvf
 7C0I8j6Bxy5Gff25t3
X-Google-Smtp-Source: AGHT+IGs9tZWF0J9Kg15xbJA3ee6hYgAXRw1N9v+gE7WGTMpgiDsxrRV4wB2vuEKU/uX4FyRIv/ncA==
X-Received: by 2002:a17:907:96ac:b0:af9:406d:f0a8 with SMTP id
 a640c23a62f3a-b01d8a7594amr1508198266b.23.1756902879369; 
 Wed, 03 Sep 2025 05:34:39 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b041770913fsm898957766b.107.2025.09.03.05.34.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 05:34:38 -0700 (PDT)
Message-ID: <c51382aa-070f-4441-a707-a29d87093b48@linaro.org>
Date: Wed, 3 Sep 2025 14:34:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/24] target/arm/hvf: Mention hvf_wfi() must run on vCPU
 thread
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250903100702.16726-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62f.google.com
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

On 9/3/25 12:06, Philippe Mathieu-Daudé wrote:
> Since hvf_wfi() calls hv_vcpu_get_sys_reg(), which
> must run on a vCPU, it also must. Mention it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index d87a41bcc53..05fc591b523 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1836,6 +1836,7 @@ static void hvf_wait_for_ipi(CPUState *cpu, struct timespec *ts)
>       bql_lock();
>   }
>   
> +/* Must be called by the owning thread */
>   static void hvf_wfi(CPUState *cpu)
>   {
>       ARMCPU *arm_cpu = ARM_CPU(cpu);

How can it not?  Are all these separate patches and annotations helpful?

r~

