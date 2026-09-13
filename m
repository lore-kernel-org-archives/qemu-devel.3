Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C84FC88E5C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 22:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5sHe-0002Os-Pv; Sun, 13 Sep 2026 18:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5sHd-0002Oc-2e
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 18:02:45 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5sHb-0003BI-Jv
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 18:02:44 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccafb74fso1437512a91.3
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 15:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789336962; x=1789941762; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PxOi6MnfMKOFb+92FpbN1IPkvCi9zOGIRu503Gk9470=;
 b=VEmQtWj2xQ7JMvp6RbD8FOOujtNwlsEwa/AMe5D4K8DNWIeKOrFPZz0Rbnvmj6Pm61
 1W4muh1cD7dxDVZ3J/6MHZM8jybzL1FqjotSMSf32pzBUpw58jtqemknHQrY3cdXr2PM
 0rCPZ/ERqEG5XQLy57bg18fuTcdAuUow04CGcYDQMl/nFG9Yxo1qTHibt5WWXrVQ2UjV
 wnCBMwuP3MrmFwkE8URkKDu76s6CkJ6H3MTKmLsWnNZUpX0BrL7V1eqBiCssoWil3gwQ
 qZyMd8GYwgk6M89iPVYSOHAQS5HlqXMYwqvTIxZWISFEMX7n4OgZKd1HWQT/vLqkSNa0
 vcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789336962; x=1789941762;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PxOi6MnfMKOFb+92FpbN1IPkvCi9zOGIRu503Gk9470=;
 b=Dm2qgUnR+ojDhxiIT1Qyd+kzeM12zJp0MCG5fLHXDJp3DmEv4tAYl5dhk8GnvIDrk9
 ajhvYYs9BVCrIvW4SC0l9GYjB/UQPyVM0DoDWJG2OS0+Eqg5UEWGnh40LB001fAj7/8J
 47MbrKsAVV066vpy44OlNxbbEu2f1kXSbB1K8UAmwfyK8tb04lsRvomtLQYcOBM2xLq6
 SJu+oxJJKl3DdW3/WeAMzPCx5NLvnBL6VAYpoa2e/peIImT+mMjtX/Xjm3kJROm34BuG
 4yQ6tbBjXu1GatShguRP7509Qh9qpDsxVUG1vYsmdWUU4LUetKu3g94GkaDmrnDuyXAi
 WuYg==
X-Forwarded-Encrypted: i=1;
 AKwUvBygLB7Bkda3lCSOhAxQFmN5eGZcnC9zLUG9pUVdzSadhIjIBqykEaXxHzhoKoFZvEm0RpMRHtlUtWP5@nongnu.org
X-Gm-Message-State: AFuF++kDKljbFw/P9LDabGp3IclpY1FAXhERTBaie38T/JeF0f328B87
 fFa6Cn2p3bD1wPiiS53LuAVRDXtfJBbC4CnOcAsROmKR+uyTmu4JJ+tz7HsZRvQXGuo=
X-Gm-Gg: AYBFou1qj6ODnaqZk0Gbu9eJqp4VXy/7muaEdRwQgSr8TGx2FJ1PrVQbDMf+xwI9TJx
 D8581OrrvTRR7Xs7iTFrGTWtU6tGyu4rxsGTFc1EjR2ChnlQSIb/2acsjOmOFveC+Qec/4FR9Zl
 xOy/HrtDyO4aBx4ef5SMOpjp8xwpeHj7VC+STkvyjKz5NxVtRxTE74QDrF9uV0KaLnecVFfIqsa
 0A9m8NU1QPhmR8a8vzBeFyLSCZCk/6bmxfjZBzALxdjf0nCBZbe1f6gOq8wDfgXShF89tQGIKFM
 FrVmBARQMKFsEorJOD6q8Y3RgODxO2sR2u4WGW/JBNYwYJWPJsyWErdBvhnm5p5yMszWDtuSQ0o
 x8VIItKVCxRVMZe5UUhAE6sZwVs2NbjQVxpZJDo8D0r5WXKtsiCYgMm0JHQyLz77f/kUZmO2FMS
 hv2TpSWoo2tTPXqReGD7H7O6wPE1bXT3tEx6z2OZqTd745V1rR1/q9TYGYgXDoYCu1PGkXL4CEG
 F39S9qe/BChUF9VO7nWm7MbsJxy5NzlL16L1NUrEdOcDN/H0qARMuEtgcyy/J8=
X-Received: by 2002:a17:90b:1f8e:b0:398:b88c:2b7b with SMTP id
 98e67ed59e1d1-39d9bd9917cmr29348384a91.8.1789336961961; 
 Sun, 13 Sep 2026 15:02:41 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:1665:91c0:9a80:f870?
 ([2603:800c:7900:ed00:1665:91c0:9a80:f870])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm23250295eec.24.2026.09.13.15.02.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2026 15:02:41 -0700 (PDT)
Message-ID: <4c019cf7-5984-449b-815d-44c31807c1e3@linaro.org>
Date: Sun, 13 Sep 2026 12:02:38 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] target/hexagon: share HVX contexts among CPUs
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, Helge Deller <deller@gmx.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
References: <20260913155928.365928-1-brian.cain@oss.qualcomm.com>
 <20260913155928.365928-6-brian.cain@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260913155928.365928-6-brian.cain@oss.qualcomm.com>
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

On 9/13/26 05:59, Brian Cain wrote:
> +++ b/linux-user/main.c
> @@ -244,6 +244,9 @@ CPUArchState *cpu_copy(CPUArchState *env)
>   
>       new_cpu->tcg_cflags = cpu->tcg_cflags;
>       memcpy(new_env, env, sizeof(CPUArchState));
> +#if defined(TARGET_HEXAGON)
> +    HEXAGON_CPU(new_cpu)->hvx_ctx = HEXAGON_CPU(cpu)->hvx_ctx;
> +#endif
>   #if defined(TARGET_I386) || defined(TARGET_X86_64)
>       new_env->gdt.base = target_mmap(0, sizeof(uint64_t) * TARGET_GDT_ENTRIES,
>                                       PROT_READ | PROT_WRITE,

Why did you put the context in the greater "cpu" structure instead of 
"env"?  It would have avoided this oddity...

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

