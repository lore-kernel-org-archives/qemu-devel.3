Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2200C36008
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 06:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzV3b-00066l-HQ; Tue, 01 Apr 2025 02:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzV3Y-00063v-9B
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 02:25:04 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzV3W-00023l-2Y
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 02:25:03 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so9900715e9.1
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 23:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743488700; x=1744093500; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zeef2Ly/Moi+fsHNp+a4aXn6+8tfdmYQqpksJD9tXnQ=;
 b=bBdt+FYeyVITkz8gcqWdLuBQD1pbYvbPfQf/4EmUAb1425Lc30muL47JD/bTv5vPqD
 fiSKv9nnZ5Xjatg4tmhVRaPR/wFH/zNVw6nJxbcZsz4SupwxTUgi23/mUz4iUzoSyzNp
 bpkEaGlq+xUWZU6/Qr+M+SV7Hb61g2GldTe9JuOqjmEcmDwAqNy0oS3Mym2YesmFy+PB
 wjAFXMG1bryPL9mWOV33MqxLDZ1RjDpVSj15NsVL23f6GztxGP/21uZEKh1dWaWo8/Ox
 tctxf2stMAYzCZHZ8l3jROURw3JzhF5i1C24pAOGpETkoo2vSpgGi8HVU+CNhKxsjps8
 7W3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743488700; x=1744093500;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zeef2Ly/Moi+fsHNp+a4aXn6+8tfdmYQqpksJD9tXnQ=;
 b=Qlmt3oJSe6JibyxNmxRqMYVq1m1tuCWmveU6f9KdXt9Zd0AONYavAck2/nNP9m94z1
 EGuLy4izLV09wTIrIvdsJHEg58wF5GjYlL9vp+t1VyK/iXDPhUr8zpvMHe9JlAs5TD4G
 xRQi4IvCVSwt9ilPH+Q7DDscF/N/pYNw7ez0QsEXy75p1otILmYvjTWeh+KCGfN8MAyy
 kNIa+cyicbKlWP9S9M/I8Lw6/AF12iusTnBFL0bQ6RPlC9R2NZnxaoT1eBFNPKgWj2FN
 BYVqhOVBKSftBwh/dOR7dPd777B9VgVK19RMECRKkZQLyK5wVVPRc9hF9bSI9pMHxMOH
 YHbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvobEM0o4Ad8Pi6G6DLOkDvq/jb0MTAfh+bEQXFDAelieKpP7czvBF4FyJKgumpmOKy6VtmBhwAKQW@nongnu.org
X-Gm-Message-State: AOJu0YzKVdLothnVBzSAh3XmGNOjvfnBIcvlUJnAdEIFCjG92PS8nW4V
 EjQKtEc4D8+HwLoJRAQ8d+R0umFVL/sM0PFEaSkx+XUQbbVzyFYfHDUmy0OWdO4=
X-Gm-Gg: ASbGnct5CZnhWtnjs0/jjN1AA5fRIcC/3Y+A/w4pULhmmF7O5lhrU0cXVEfNlwnS2UT
 5xXLMzIWvdKxPU+zgDckX1DExRpTKaoeMhNo+TE6TSKno0pE4YrD8/rx8Qbo+6grJmK4dmd4J/a
 FzJIOPfpyxaELBoAEZrw2OoGzU8ci8x6yGsGcKBvzBePmVjDf2KtU7VaGkVPWKpwTXzM9KSdjFq
 ZC9Lbpcc5Bgm0A9H95fjak548PseM8f3o3SAdP7bDLZGy+V5YthbSPdNn5LgzD+7s4GpQYXQF9Z
 dqTVl4ts6Nep1rJpc1GUq2/bR6VHsBT5xS6OImrlsxqwTv0Ar77k4PDgkrjFSdEVcz4J+B4vkdT
 rNvHfwRsMmYSH
X-Google-Smtp-Source: AGHT+IHz5E1UDBCgmxoLSeolKbSowDB1FFARtty45EetBMglO+so4J7A49Ttc4RDZxps9F9NtFQANA==
X-Received: by 2002:a05:600c:34d0:b0:43c:ec0a:ddfd with SMTP id
 5b1f17b1804b1-43db61e0308mr93547995e9.6.1743488700349; 
 Mon, 31 Mar 2025 23:25:00 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b60a9ddsm13411214f8f.0.2025.03.31.23.24.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 23:24:59 -0700 (PDT)
Message-ID: <7b57e8c0-076b-44dc-859a-2829a68cf669@linaro.org>
Date: Tue, 1 Apr 2025 08:24:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/42] include/exec: Inline *_data memory operations
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-10-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250318213209.2579218-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 18/3/25 22:31, Richard Henderson wrote:
> These need to be per-target for 'abi_ptr'.  Expand inline to
> the *_data_ra api with ra == 0.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu_ldst.h     | 123 ++++++++++++++++++++++++++++++------
>   accel/tcg/ldst_common.c.inc |  89 --------------------------
>   2 files changed, 104 insertions(+), 108 deletions(-)
> 
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index a2a90c7554..d084da0b5f 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -74,25 +74,6 @@
>   #include "user/guest-host.h"
>   #endif /* CONFIG_USER_ONLY */
>   
> -uint32_t cpu_ldub_data(CPUArchState *env, abi_ptr ptr);
> -int cpu_ldsb_data(CPUArchState *env, abi_ptr ptr);
> -uint32_t cpu_lduw_be_data(CPUArchState *env, abi_ptr ptr);
> -int cpu_ldsw_be_data(CPUArchState *env, abi_ptr ptr);
> -uint32_t cpu_ldl_be_data(CPUArchState *env, abi_ptr ptr);
> -uint64_t cpu_ldq_be_data(CPUArchState *env, abi_ptr ptr);
> -uint32_t cpu_lduw_le_data(CPUArchState *env, abi_ptr ptr);
> -int cpu_ldsw_le_data(CPUArchState *env, abi_ptr ptr);
> -uint32_t cpu_ldl_le_data(CPUArchState *env, abi_ptr ptr);
> -uint64_t cpu_ldq_le_data(CPUArchState *env, abi_ptr ptr);
> -
> -void cpu_stb_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
> -void cpu_stw_be_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
> -void cpu_stl_be_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
> -void cpu_stq_be_data(CPUArchState *env, abi_ptr ptr, uint64_t val);
> -void cpu_stw_le_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
> -void cpu_stl_le_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
> -void cpu_stq_le_data(CPUArchState *env, abi_ptr ptr, uint64_t val);
> -
>   static inline uint32_t
>   cpu_ldub_mmuidx_ra(CPUArchState *env, abi_ptr addr, int mmu_idx, uintptr_t ra)
>   {
> @@ -342,6 +323,110 @@ cpu_stq_le_data_ra(CPUArchState *env, abi_ptr addr, uint64_t val, uintptr_t ra)
>       cpu_stq_le_mmuidx_ra(env, addr, val, mmu_index, ra);
>   }
>   
> +/*--------------------------*/
> +
> +static inline uint32_t

Pre-existing, but why don't we use 'unsigned int' like for the signed
variants, or the plain int8_t type?

> +cpu_ldub_data(CPUArchState *env, abi_ptr addr)
> +{
> +    return cpu_ldub_data_ra(env, addr, 0);
> +}
> +
> +static inline int
> +cpu_ldsb_data(CPUArchState *env, abi_ptr addr)
> +{
> +    return (int8_t)cpu_ldub_data(env, addr);
> +}
> +
> +static inline uint32_t
> +cpu_lduw_be_data(CPUArchState *env, abi_ptr addr)
> +{
> +    return cpu_lduw_be_data_ra(env, addr, 0);
> +}
> +
> +static inline int
> +cpu_ldsw_be_data(CPUArchState *env, abi_ptr addr)
> +{
> +    return (int16_t)cpu_lduw_be_data(env, addr);
> +}
> +
> +static inline uint32_t
> +cpu_ldl_be_data(CPUArchState *env, abi_ptr addr)
> +{
> +    return cpu_ldl_be_data_ra(env, addr, 0);
> +}
> +
> +static inline uint64_t
> +cpu_ldq_be_data(CPUArchState *env, abi_ptr addr)
> +{
> +    return cpu_ldq_be_data_ra(env, addr, 0);
> +}
> +
> +static inline uint32_t
> +cpu_lduw_le_data(CPUArchState *env, abi_ptr addr)
> +{
> +    return cpu_lduw_le_data_ra(env, addr, 0);
> +}
> +
> +static inline int
> +cpu_ldsw_le_data(CPUArchState *env, abi_ptr addr)
> +{
> +    return (int16_t)cpu_lduw_le_data(env, addr);
> +}
> +
> +static inline uint32_t
> +cpu_ldl_le_data(CPUArchState *env, abi_ptr addr)
> +{
> +    return cpu_ldl_le_data_ra(env, addr, 0);
> +}
> +
> +static inline uint64_t
> +cpu_ldq_le_data(CPUArchState *env, abi_ptr addr)
> +{
> +    return cpu_ldq_le_data_ra(env, addr, 0);
> +}
> +
> +static inline void
> +cpu_stb_data(CPUArchState *env, abi_ptr addr, uint32_t val)
> +{
> +    cpu_stb_data_ra(env, addr, val, 0);
> +}
> +
> +static inline void
> +cpu_stw_be_data(CPUArchState *env, abi_ptr addr, uint32_t val)
> +{
> +    cpu_stw_be_data_ra(env, addr, val, 0);
> +}
> +
> +static inline void
> +cpu_stl_be_data(CPUArchState *env, abi_ptr addr, uint32_t val)
> +{
> +    cpu_stl_be_data_ra(env, addr, val, 0);
> +}
> +
> +static inline void
> +cpu_stq_be_data(CPUArchState *env, abi_ptr addr, uint64_t val)
> +{
> +    cpu_stq_be_data_ra(env, addr, val, 0);
> +}
> +
> +static inline void
> +cpu_stw_le_data(CPUArchState *env, abi_ptr addr, uint32_t val)
> +{
> +    cpu_stw_le_data_ra(env, addr, val, 0);
> +}
> +
> +static inline void
> +cpu_stl_le_data(CPUArchState *env, abi_ptr addr, uint32_t val)
> +{
> +    cpu_stl_le_data_ra(env, addr, val, 0);
> +}
> +
> +static inline void
> +cpu_stq_le_data(CPUArchState *env, abi_ptr addr, uint64_t val)
> +{
> +    cpu_stq_le_data_ra(env, addr, val, 0);
> +}


