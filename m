Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E923FD59D77
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 17:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU6Xq-0001Yv-W3; Fri, 12 Dec 2025 12:03:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vU6Xa-0001Rl-Gb
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 12:02:55 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vU6XY-00066i-B8
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 12:02:49 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c730af8d69so828257a34.1
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 09:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765558966; x=1766163766; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z5Cu90afDU2S+/4qFGaIGP5W3CGLy3gUPuya1AVDzx0=;
 b=QzAiF9HBFyY2OWgi/lj1k/t3ypZzDXo4YQ7GcPKXCdvYrVaRNcgOasTHpSzek9Fn5q
 HzaomZJR+Q5L/CCDN0SLo1ukelADzH6Kcbtfl0He+KyqVj4079ZzFF0RYLBHd3bbKMdn
 +1vM45uMW8CRB9++T3IsdpnR9r/JaNfCHNlllczc0DcE+zhieM4BZ2l94+N/zYEykIoy
 eAE1SU0wiBK0tAvu3FdFEcbm3ET+XFYGYtNJ25f9VZDi0h+LwP0m3Q/3Ii2L9PBZJv2N
 adq4N7zIXsivk6ocPOX6SpXARzTncBv2gKo+oshRM9cIQ3Jlpvmh/WLICGw8N1yxUbPu
 dFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765558966; x=1766163766;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z5Cu90afDU2S+/4qFGaIGP5W3CGLy3gUPuya1AVDzx0=;
 b=w+4/MesRv2nfMzoB2c0CKgNAFVeQOsoHyJd2Vptq3jCUvAbyA1eR+pd2ZUnr6WgKeu
 a7kyeCXFJDFpicd3BsoacutxbwAlZxwWMFdEpWVfL+pcxZbnhrdXsoxjTB9W4in4kwno
 0M4+QoBIqzxJZZ9HlQcrMRRELWp6MMW5QFBV1S0/T7ur90rxG6uxt9UvJ1ra195QuVZD
 k0rkBQG2fGFp9thqf8yUkuM5muOwgsgNmv3J9G3M2l8lBlnNck7tBHUMAWBBmh6HhPsf
 vzWBf/RN7RpruYy+tE4g4m7C6ti1L/f+Uv6iMUKTfnPchI4D39/Wb9FQCogsLCWfH4Q1
 kYDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXun83B/dd/bIsQeuKzr7N0dolPN4ytWueM489WL6YsH1TUqKz5qSZrSdD0gNXWyfD72Zz/OqQP98ay@nongnu.org
X-Gm-Message-State: AOJu0Ywr16fBb7lXOILZiMFIt3ujx7yZd46i7PRAd31W0JuybeVdvyq8
 cRoMamUvDW6x4JgpnnbW/6/kg28Y5bKZoGJzChkEvVCJ2COpiSXHo/pmxcpW9q9vfGX+oEqLLaY
 KPGyWtQw=
X-Gm-Gg: AY/fxX6IhrLGCPAk6H1lUiPndwLbZQJxlYotYRkz2H45la2tsrnmJ6vG/adIYlAhvOE
 hP5FnuX0ggaw9idW9o1izapC1twLGG//+Cnj4uGK+Ql8fJNl+auJQyF++KtSmzLQfovNpOkdyfP
 c99+HvXr4VwXqpIBYNnallq30pwakGGzNk2DB3LIDRiC4nzt7YeK+ibqDdzGPneLnjRD84ZTZ/k
 EEURDn91Sibf1DRxBOkkzNskbXmQi7HjCSnDBJ1GwX3RNuaXQnFBbPFi+Zycd8VI87QQ4UOvMoQ
 W6zM2H4CVpKPZc4R8TF45ZY2CY0kJPMJMTjROuXP2syrY6gx58ZleSJxq7sFaudlLwtKkqX4UJ/
 5yfxZyfvlxMmq+bUAMQ3zv5Bib4XV3iHwDJlCzPJkhgAgtXJkw8+1fDS2fulWg0AJhk9GUoH4PU
 hWSgdLQw+MI0P6cKWNuRMU/6yka4Lt
X-Google-Smtp-Source: AGHT+IHO7zsm1eQ1zfXLuC/IzJOGo2yMXH0yD9PV4Yi0O2LNFKRbbzbp1ukS2CWr6IVoY7Tr+lyUvA==
X-Received: by 2002:a05:6808:bc3:b0:453:860a:fed with SMTP id
 5614622812f47-455ac9366e0mr1134062b6e.36.1765558965967; 
 Fri, 12 Dec 2025 09:02:45 -0800 (PST)
Received: from [10.229.62.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-45598b43e76sm2885853b6e.2.2025.12.12.09.02.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 09:02:45 -0800 (PST)
Message-ID: <6c2e05cc-608b-4835-a37f-be0164ab50eb@linaro.org>
Date: Fri, 12 Dec 2025 11:02:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 v3 22/22] accel/tcg: Remove non-explicit endian
 cpu_ld/st*_data*() helpers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20251126202200.23100-1-philmd@linaro.org>
 <20251126202200.23100-23-philmd@linaro.org>
 <d6d5cd40-ac5c-41f2-85f9-db038fa8b5a6@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <d6d5cd40-ac5c-41f2-85f9-db038fa8b5a6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

On 11/26/25 14:32, Philippe Mathieu-Daudé wrote:
> On 26/11/25 21:21, Philippe Mathieu-Daudé wrote:
>> All uses were converted to the explicit cpu_ld/st*_{be,le}_data*()
>> helpers, no need for the non-explicit versions anymore.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/accel/tcg/cpu-ldst.h | 46 ------------------------------------
>>   1 file changed, 46 deletions(-)
>>
>> diff --git a/include/accel/tcg/cpu-ldst.h b/include/accel/tcg/cpu-ldst.h
>> index 0de7f5eaa6b..12dd38599a6 100644
>> --- a/include/accel/tcg/cpu-ldst.h
>> +++ b/include/accel/tcg/cpu-ldst.h
>> @@ -428,52 +428,6 @@ cpu_stq_le_data(CPUArchState *env, abi_ptr addr, uint64_t val)
>>       cpu_stq_le_data_ra(env, addr, val, 0);
>>   }
>> -#if TARGET_BIG_ENDIAN
>> -# define cpu_lduw_data        cpu_lduw_be_data
>> -# define cpu_ldsw_data        cpu_ldsw_be_data
>> -# define cpu_ldl_data         cpu_ldl_be_data
>> -# define cpu_ldq_data         cpu_ldq_be_data
>> -# define cpu_lduw_data_ra     cpu_lduw_be_data_ra
>> -# define cpu_ldsw_data_ra     cpu_ldsw_be_data_ra
>> -# define cpu_ldl_data_ra      cpu_ldl_be_data_ra
>> -# define cpu_ldq_data_ra      cpu_ldq_be_data_ra
>> -# define cpu_lduw_mmuidx_ra   cpu_lduw_be_mmuidx_ra
>> -# define cpu_ldsw_mmuidx_ra   cpu_ldsw_be_mmuidx_ra
>> -# define cpu_ldl_mmuidx_ra    cpu_ldl_be_mmuidx_ra
>> -# define cpu_ldq_mmuidx_ra    cpu_ldq_be_mmuidx_ra
>> -# define cpu_stw_data         cpu_stw_be_data
>> -# define cpu_stl_data         cpu_stl_be_data
>> -# define cpu_stq_data         cpu_stq_be_data
>> -# define cpu_stw_data_ra      cpu_stw_be_data_ra
>> -# define cpu_stl_data_ra      cpu_stl_be_data_ra
>> -# define cpu_stq_data_ra      cpu_stq_be_data_ra
>> -# define cpu_stw_mmuidx_ra    cpu_stw_be_mmuidx_ra
>> -# define cpu_stl_mmuidx_ra    cpu_stl_be_mmuidx_ra
>> -# define cpu_stq_mmuidx_ra    cpu_stq_be_mmuidx_ra
>> -#else
>> -# define cpu_lduw_data        cpu_lduw_le_data
>> -# define cpu_ldsw_data        cpu_ldsw_le_data
>> -# define cpu_ldl_data         cpu_ldl_le_data
>> -# define cpu_ldq_data         cpu_ldq_le_data
>> -# define cpu_lduw_data_ra     cpu_lduw_le_data_ra
>> -# define cpu_ldsw_data_ra     cpu_ldsw_le_data_ra
>> -# define cpu_ldl_data_ra      cpu_ldl_le_data_ra
>> -# define cpu_ldq_data_ra      cpu_ldq_le_data_ra
>> -# define cpu_lduw_mmuidx_ra   cpu_lduw_le_mmuidx_ra
>> -# define cpu_ldsw_mmuidx_ra   cpu_ldsw_le_mmuidx_ra
>> -# define cpu_ldl_mmuidx_ra    cpu_ldl_le_mmuidx_ra
>> -# define cpu_ldq_mmuidx_ra    cpu_ldq_le_mmuidx_ra
>> -# define cpu_stw_data         cpu_stw_le_data
>> -# define cpu_stl_data         cpu_stl_le_data
>> -# define cpu_stq_data         cpu_stq_le_data
>> -# define cpu_stw_data_ra      cpu_stw_le_data_ra
>> -# define cpu_stl_data_ra      cpu_stl_le_data_ra
>> -# define cpu_stq_data_ra      cpu_stq_le_data_ra
>> -# define cpu_stw_mmuidx_ra    cpu_stw_le_mmuidx_ra
>> -# define cpu_stl_mmuidx_ra    cpu_stl_le_mmuidx_ra
>> -# define cpu_stq_mmuidx_ra    cpu_stq_le_mmuidx_ra
>> -#endif
>> -
> 
> Missing to squash:

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> -- >8 --
> diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
> index c906c6509ee..e956aece673 100644
> --- a/docs/devel/loads-stores.rst
> +++ b/docs/devel/loads-stores.rst
> @@ -152,3 +152,3 @@ store: ``cpu_st{size}{end}_mmuidx_ra(env, ptr, val, mmuidx, retaddr)``
>   ``end``
> - - (empty) : for target endian, or 8 bit sizes
> + - (empty) : for 8 bit sizes
>    - ``_be`` : big endian
> @@ -157,4 +157,4 @@ store: ``cpu_st{size}{end}_mmuidx_ra(env, ptr, val, mmuidx, retaddr)``
>   Regexes for git grep:
> - - ``\<cpu_ld[us]\?[bwlq]\(_[bl]e\)\?_mmuidx_ra\>``
> - - ``\<cpu_st[bwlq]\(_[bl]e\)\?_mmuidx_ra\>``
> + - ``\<cpu_ld[us]\?\(b\|[wlq]\(_[bl]e\)\)_mmuidx_ra\>``
> + - ``\<cpu_st\(b\|[wlq]\(_[bl]e\)\)_mmuidx_ra\>``
> 
> @@ -190,3 +190,3 @@ store: ``cpu_st{size}{end}_data_ra(env, ptr, val, ra)``
>   ``end``
> - - (empty) : for target endian, or 8 bit sizes
> + - (empty) : for 8 bit sizes
>    - ``_be`` : big endian
> @@ -195,4 +195,4 @@ store: ``cpu_st{size}{end}_data_ra(env, ptr, val, ra)``
>   Regexes for git grep:
> - - ``\<cpu_ld[us]\?[bwlq]\(_[bl]e\)\?_data_ra\>``
> - - ``\<cpu_st[bwlq]\(_[bl]e\)\?_data_ra\>``
> + - ``\<cpu_ld[us]\?\(b\|[wlq]\(_[bl]e\)\)_data_ra\>``
> + - ``\<cpu_st\(b\|[wlq]\(_[bl]e\)\)_data_ra\>``
> 
> @@ -229,3 +229,3 @@ store: ``cpu_st{size}{end}_data(env, ptr, val)``
>   ``end``
> - - (empty) : for target endian, or 8 bit sizes
> + - (empty) : for 8 bit sizes
>    - ``_be`` : big endian
> @@ -234,4 +234,4 @@ store: ``cpu_st{size}{end}_data(env, ptr, val)``
>   Regexes for git grep:
> - - ``\<cpu_ld[us]\?[bwlq]\(_[bl]e\)\?_data\>``
> - - ``\<cpu_st[bwlq]\(_[bl]e\)\?_data\+\>``
> + - ``\<cpu_ld[us]\?\(b\|[wlq]\(_[bl]e\)\)_data\>``
> + - ``\<cpu_st\(b\|[wlq]\(_[bl]e\)\)_data\+\>``
> ---


