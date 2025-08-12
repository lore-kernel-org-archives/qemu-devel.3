Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3081CA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 00:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulcTm-0005Ts-NG; Mon, 11 Aug 2025 20:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ulcTj-0005TW-WC
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 20:03:00 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ulcTZ-0003FY-Ah
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 20:02:59 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2401b855635so37023975ad.2
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 17:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754956960; x=1755561760; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=frM4fMqHPKPiASnjXlYhdYeEaYkDuEWkL1rUtbCpK60=;
 b=QsXuN+ad7NWc5fV3f9iL185cWhgmQrvC4UabVGbthQ8bjwAdsHJ4ySOIpEX7adCutQ
 K0tuM0ZUzLUr93X1lit5g9D5rT+PA5yx2VqfBddYDnfgcq7OGPdokLBcZybwN9kQZJb9
 14E9oEs1cimbGdkaAtor2Uuild26vwxEF8hXfurMGWLnr6U3Ym2slnTySZZVmsRx8cyw
 7RbpONxUEz7A6t/rLdh82dE7CAlTV/svTAQltYxoMjqQjnEdAr9bivpDog9xExQ3hV+p
 9CiCPUPD2MFQ1uG59sfcJZF8/YLH3h2PBInKXdkCFqh+HW0rkLIIOqlpglHowe2qxADu
 fHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754956960; x=1755561760;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=frM4fMqHPKPiASnjXlYhdYeEaYkDuEWkL1rUtbCpK60=;
 b=g7yledK7Tz+PZjXRZyURWfFCkunJRU4Doxwg7EqADuLDHVrxqnDNZIxLGbyx8eNNie
 GwaxioWWz4HG4Iryai9OJo3pkYTMZS0AswO8+mRbXKN7OknLo9UonrHMrzAgu5ZGXic0
 TJl3RaM4JnyEmNLrnAkuGs2Cd7lueFqw238r4Gb87Zj6t0scTf2orMrvM12E6+GAYfso
 XulzN51oe+4nYpwrrXY+wcy0GHfGF+igj3ETrtA8PmH256su0JxzIFYYkV/Cjr2corWk
 uUURRz4xXtnzy710P3EAYwQusPR/b7yIBMSK2UfA+hEut1LGOpgvIM997b9I1UGHR/6j
 tsBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyJ/k0KrOb5ScxldBybctBVn4uLz9qoapFtHZoDjelzn4UCufsBVG5P7QE1tTo7bigp165q6iUSE5A@nongnu.org
X-Gm-Message-State: AOJu0YyOzurCjGku5g4Xk8k0OcrxjBOK5F6BJIXf8smY8VTAhmG309wS
 tX6n6xCALYlwCnbhVq0Z4+gppx9O5a/iHW9ui4APLKdKgSxuSuRH8w2vRpiYCd2Q3+E=
X-Gm-Gg: ASbGnctsMIjYiv4rFJDr15h7wJM5qpPoJ46sOMmS8DeZ4C4+cVtRT2/aEaxXL26kWP5
 F/2q4+Im/Q4d+tDsLlEwEN8OdxUcIhJst/R4DQ/xObx/E48OvCm0KH4anp/7hBEVjlpJfiv52Ri
 g2u3aLQjoUWdVNJlHS7aNOo1y2Df6r87uoUBcJ68wTV2BLzIhRU+B+KndupgENXZBeQ78TjCV7K
 rcTpKA90rNv9yzGZigXajWT6Rvdb49W+WzBhXbJEf4l38Q4G9AaJbJFvKMK4l2dJOU4lMBA8r6L
 5Q0dLQhwq4qQJdQKYuaUJYJwqvH0g3f9QbvQtA6ddeTzcVWOhM8dW/zJ70O+QL+EJ1L9O2Qv9Zy
 DF/zLcVjtvUzS+sNIwl12CLiHTegZ1hQgi79BHDpFBBeXmwmodJP6
X-Google-Smtp-Source: AGHT+IG2Vx/elzArhaMbP8/MPLaPbkWfofEh63opJA6l9mNJObIGKYuecvnmBwCs15KjEdIUj7xmQQ==
X-Received: by 2002:a17:903:b8d:b0:242:fb7d:1d57 with SMTP id
 d9443c01a7336-242fc3927f4mr20777185ad.42.1754956960228; 
 Mon, 11 Aug 2025 17:02:40 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef6825sm284820765ad.30.2025.08.11.17.02.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 17:02:39 -0700 (PDT)
Message-ID: <dd4c6078-ffe1-457f-b67b-add1b66da3c8@linaro.org>
Date: Tue, 12 Aug 2025 10:02:35 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/11] target/arm: Restrict PMU to system mode
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250811170611.37482-1-philmd@linaro.org>
 <20250811170611.37482-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250811170611.37482-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 8/12/25 03:06, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/cpu.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index d9a8f62934d..1dc2a8330d8 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1551,7 +1551,6 @@ static const Property arm_cpu_pmsav7_dregion_property =
>               DEFINE_PROP_UNSIGNED_NODEFAULT("pmsav7-dregion", ARMCPU,
>                                              pmsav7_dregion,
>                                              qdev_prop_uint32, uint32_t);
> -#endif
>   
>   static bool arm_get_pmu(Object *obj, Error **errp)
>   {
> @@ -1576,6 +1575,8 @@ static void arm_set_pmu(Object *obj, bool value, Error **errp)
>       cpu->has_pmu = value;
>   }
>   
> +#endif
> +
>   static bool aarch64_cpu_get_aarch64(Object *obj, Error **errp)
>   {
>       ARMCPU *cpu = ARM_CPU(obj);
> @@ -1771,12 +1772,12 @@ static void arm_cpu_post_init(Object *obj)
>       if (arm_feature(&cpu->env, ARM_FEATURE_EL2)) {
>           qdev_property_add_static(DEVICE(obj), &arm_cpu_has_el2_property);
>       }
> -#endif
>   
>       if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
>           cpu->has_pmu = true;
>           object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
>       }
> +#endif
>   
>       /*
>        * Allow user to turn off VFP and Neon support, but only for TCG --


