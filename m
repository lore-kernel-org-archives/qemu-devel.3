Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867BDC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 17:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsm5W-0007mr-MQ; Thu, 13 Mar 2025 13:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsm5V-0007mQ-Bg
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:11:17 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsm5T-00066v-9y
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:11:17 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-224100e9a5cso26556855ad.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 10:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741885873; x=1742490673; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TYJMDXe93IbmqpAWYj4ZSaALtOGxukMghTQ5y2YoeXc=;
 b=BtsbfG/K4TgXJ0kRIj2lfVdbtQpe+0SpR20dVwA2AiKIMLYMPqvsPBIPKx4KGcRMIY
 LDB6UBG38wOuMn4AqH8TkkqGoHuoNSP1J14SBJD+uvE+jNrlSK2AlaNCtfUetcbbB0xB
 mIqwwwfvTTNYugxDwe6dMFEkTfn8wiYMr60YhlHm4za0HEul/Ae3Z6qR9A28h2SdkPei
 uT0QLghPLlpirpyj3Z+kQQxSakbJguKwcyBFr1EFibrq5JAERBv/9y/mhlzWQU5Y7RrL
 WkIxQ1rHrnHWyjNW3uyzMfkPeJXANMlLdzfQhF5HJ2zKX2YdiIqbQDVgrT/xzurhIELM
 7unw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741885873; x=1742490673;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TYJMDXe93IbmqpAWYj4ZSaALtOGxukMghTQ5y2YoeXc=;
 b=fDD13xuWBVVuykt+irAiZXObsdLvRZ+nntnEYfR7PhYbBOd2AY47zrXAZYdSgm7v5r
 dsQRkYsqUxrgTLGcucAOc2pseYirleIAUgrj7A9Qc31uPUbBlrfIiJVF4vYbzISyAopw
 Jrku5KesDe2++YacLVS3Y9sN0lk2sHuWj+sZ8pILhogoDAa15BhkAE2EWYHpjYdf1iZF
 dRR4lK1qkeBHHuzNKwCAi1OWQ+79ID4lebHENhZZ5q0Q5f5kpuX35tO2fe5FovSCPICu
 BaDb/q2zdQYl7sj0sp/Qf5WvYBwvb6iZ1KYo+ok05j8uaTjo1vznKxIiY917tV+NRd6w
 OwIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQ/ddy60iJZ8trV3aCtzAAwn3BPMfUAmIdI83mT6dKAJPhzU47HKtYxF89ZVU/j2hFMa9Bw6guzJFp@nongnu.org
X-Gm-Message-State: AOJu0YxfMGMIWyfmIYq/dVm+Gq9K9O7GunqSFwgwqHSYlEzkgGON0M1P
 SuS+PQw0cZd/0KuE7XdQlZwVIMvbYyZ0xgO3QwOZb8w9S2AQhdIEVcDMX6CEU8s=
X-Gm-Gg: ASbGncud6mqiWabI/Brb2CYPFAOzn3AeYtMj3O/tvjJ/Aoy5zkFH9ZuU5oCI4laLzTs
 4fataMkUbts911Ak0YnKmLZD8JR7MjpMCMq86dNvdNkFKGMAejTcy/HeKmatIjyIpKs3jozXJNy
 TvcE87I/9esGQkQVDBLrs4O8ygTBJuuNBQUxk96S1WStfS7krSReU6AP2UcwdWaouuRKo8vgLyU
 QMzNdaLlUiG2rubu7oJLa/4RgyVr4nOKkdkkY79BMcrdVhmheeGhjzN0f++XqdA6OLaHGE7nfGa
 Hsll4mBNWaFNocbViYYoUvg9mKhWxY5ApApjghxFuIV6b6MpZf2eDIBtIg==
X-Google-Smtp-Source: AGHT+IFsT5irgvAmGcuFIjkmXalbNAkUWvM6ykXzr9F0Thci5pGzjP1AxyFUAU6Rwg02upLCow4YPA==
X-Received: by 2002:a05:6a00:b4c:b0:736:50c4:3e0f with SMTP id
 d2e1a72fcca58-7371f0d4cc4mr354268b3a.10.1741885872790; 
 Thu, 13 Mar 2025 10:11:12 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711557e9fsm1636684b3a.51.2025.03.13.10.11.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 10:11:12 -0700 (PDT)
Message-ID: <c26694d8-3629-464c-910d-1999e51a1004@linaro.org>
Date: Thu, 13 Mar 2025 10:11:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/37] include/exec: Inline *_mmuidx_ra memory operations
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-6-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 3/12/25 20:44, Richard Henderson wrote:
> These expand inline to the *_mmu api with trivial
> massaging of the arguments.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu_ldst.h     | 163 ++++++++++++++++++++++++++++--------
>   accel/tcg/ldst_common.c.inc | 118 --------------------------
>   2 files changed, 129 insertions(+), 152 deletions(-)
> 
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index 1fbdbe59ae..b33755169e 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -118,41 +118,136 @@ void cpu_stl_le_data_ra(CPUArchState *env, abi_ptr ptr,
>   void cpu_stq_le_data_ra(CPUArchState *env, abi_ptr ptr,
>                           uint64_t val, uintptr_t ra);
>   
> -uint32_t cpu_ldub_mmuidx_ra(CPUArchState *env, abi_ptr ptr,
> -                            int mmu_idx, uintptr_t ra);
> -int cpu_ldsb_mmuidx_ra(CPUArchState *env, abi_ptr ptr,
> -                       int mmu_idx, uintptr_t ra);
> -uint32_t cpu_lduw_be_mmuidx_ra(CPUArchState *env, abi_ptr ptr,
> -                               int mmu_idx, uintptr_t ra);
> -int cpu_ldsw_be_mmuidx_ra(CPUArchState *env, abi_ptr ptr,
> -                          int mmu_idx, uintptr_t ra);
> -uint32_t cpu_ldl_be_mmuidx_ra(CPUArchState *env, abi_ptr ptr,
> -                              int mmu_idx, uintptr_t ra);
> -uint64_t cpu_ldq_be_mmuidx_ra(CPUArchState *env, abi_ptr ptr,
> -                              int mmu_idx, uintptr_t ra);
> -uint32_t cpu_lduw_le_mmuidx_ra(CPUArchState *env, abi_ptr ptr,
> -                               int mmu_idx, uintptr_t ra);
> -int cpu_ldsw_le_mmuidx_ra(CPUArchState *env, abi_ptr ptr,
> -                          int mmu_idx, uintptr_t ra);
> -uint32_t cpu_ldl_le_mmuidx_ra(CPUArchState *env, abi_ptr ptr,
> -                              int mmu_idx, uintptr_t ra);
> -uint64_t cpu_ldq_le_mmuidx_ra(CPUArchState *env, abi_ptr ptr,
> -                              int mmu_idx, uintptr_t ra);

Not related to the change, but the naming _ra is very confusing, since 
it means the opposite of what it seems. *NO* requirement alignment, when 
you expect the opposite.

