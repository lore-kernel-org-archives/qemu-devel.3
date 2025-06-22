Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DA9C71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 03:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTBG7-0004qc-Fj; Sat, 21 Jun 2025 23:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTBG5-0004qE-KB
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:20:41 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTBG3-0006PW-Vx
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:20:41 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2352400344aso31270505ad.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 20:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750562438; x=1751167238; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R3mbxnJiXCoiociAsXeyCnH+9nL+9UnVQduFnfCwU6Q=;
 b=b/5hddwNpJenEBboYDF0KZh4kD8AxPQA9SQf+yl0ha1Ubtfz/GmrhctWOS5qC4aL4O
 iMTZlUAbNNkNNNOGR8DnNPc7LIhHZ7u0la/nFhgywq90vPaKpWUW1GsUJWrz6/p/3Uk9
 o1Vpiz8HHzPBdJgG+904mIR6bxhGWvunu/1nruUcBi8KH/ZguqYjYllMqiITXFGTVGD+
 auoQMnc47X/ZBpPklRijP/1eIY3Rb/A53grE5XHKIIkRUBhiQhh0Ao+ejCMS3gbjYIg6
 lumhCEzT9PDC2zxbc9nyZASV6p7hZPG8OwSjEc8rtymUgeq5XdQ/Ghn2Q9gJcRY/GOh1
 RNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750562438; x=1751167238;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R3mbxnJiXCoiociAsXeyCnH+9nL+9UnVQduFnfCwU6Q=;
 b=TYZ7YbZ213Fc1CgJwqGTr7ZOIztoyHbagXG8R16yFlqGWuy5U27+6NyHMkXgnsJHtg
 DCAyAqvXYEug7WkmMYKr2RVBVtcIoI5Gkrdgo4Yzd1RD65jxuq+3+63Y8j9/V0oh3fZw
 vXeL57oE5POl9lJd5HinN4CFceqWovCkXmUfjSY5WSjc+DyYVeRNeCXyrOLuwA/pJnD6
 Hjl3EHpWFWY8NZOE8nrPp9jSeMlDp98miGO4gRNI5sTRuOroNH2Yeh2aCoiVUKKXekrS
 x97M8VXoVxS/aLiFLs8t9GNTYQZ/hBq2d7gaegwQVYTWf1Fd8GTRy6arDicSV/oZHYiy
 HpVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5T81qSEL1cJlC0bR8FCAuQY9o52VZgDDzSiS3XxqtvxOU+n+7VndQE/O8Y/UPuCGDop11ppC0bQ9O@nongnu.org
X-Gm-Message-State: AOJu0YxcdxKGwT5YMJ9VZJka6wZ7WDBfliDic/TZGv9YTdH4N2SdIaRp
 O2nnPhlqXQf6si7ZiwivzIBLaka5RqSdCPjII8kxL6LqCrFrQD+wTR875Xlg8iEN/UxzbbGmaOH
 kzltuMFk=
X-Gm-Gg: ASbGnculjUtCNHWDL8Ths3zs30iQ5rIzqbYPpOJ//SVaxlahYcgtrsakNgvL8q1yt2g
 Ih2Vn6aTgYzqJ++pZS6cfSuwzIDwGKK89I+4iqu4aj1XJljqGXs+54zmnFWZ5oBmGn24uJjYOsi
 HQzjJkTDm2+Rstey9B/BvEJ56ThaBHMu77RWnwLACg4L4hoTOOpD27k3x1TReJW7NYKTjqVcpe5
 tKs8ItUBZ2ZlLsYLC6+GKh9zcVI00eajM4nj0M8xAy3UO//CElrd8PSY7gkTp6Aemx5M3A6ZJpZ
 JPdCIdBZaVyrXOz6XVHQKy41vHR2TKC3LW/S6CyA49mUMIepU7lOaZMPLdEL+Rfm6jH8KpYem81
 0g7HB2ei2hPuPxFsifYfso7TTsf8y
X-Google-Smtp-Source: AGHT+IHf9T2nfiWvEY/54e0nzedi1KG4ouXPkTHTqBrguKikBFybc4F/l3svrYXtxZoHFXPvw9dlUg==
X-Received: by 2002:a17:902:d541:b0:235:f3e6:4680 with SMTP id
 d9443c01a7336-237d989699dmr120202935ad.21.1750562438436; 
 Sat, 21 Jun 2025 20:20:38 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d86d5efasm52488105ad.208.2025.06.21.20.20.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 20:20:38 -0700 (PDT)
Message-ID: <b0ae7077-720a-4943-9c76-42614cccd2dc@linaro.org>
Date: Sat, 21 Jun 2025 20:20:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 35/42] target/arm: Emulate EL2 under TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-36-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-36-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
> When using hardware acceleration and TCG is available,
> expose EL2 and EL3 features as available (they will be
> emulated).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/cpu64.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 200da1c489b..b5c2796f3a1 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -738,20 +738,23 @@ static void aarch64_a53_initfn(Object *obj)
>   
>   static void aarch64_host_initfn(Object *obj)
>   {
> -#if defined(CONFIG_KVM)
>       ARMCPU *cpu = ARM_CPU(obj);
> +#if defined(CONFIG_KVM)
>       kvm_arm_set_cpu_features_from_host(cpu);
>       if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
>           aarch64_add_sve_properties(obj);
>           aarch64_add_pauth_properties(obj);
>       }
>   #elif defined(CONFIG_HVF)
> -    ARMCPU *cpu = ARM_CPU(obj);
>       hvf_arm_set_cpu_features_from_host(cpu);
>       aarch64_add_pauth_properties(obj);
>   #else
>       g_assert_not_reached();
>   #endif
> +    if (tcg_enabled()) {
> +        set_feature(&cpu->env, ARM_FEATURE_EL2);
> +        set_feature(&cpu->env, ARM_FEATURE_EL3);
> +    }
>   }
>   
>   static void aarch64_max_initfn(Object *obj)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

