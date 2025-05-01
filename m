Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4B6C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 19:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAZEx-0002cH-CL; Thu, 01 May 2025 15:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAZEt-0002bf-Vo
 for qemu-devel@nongnu.org; Thu, 01 May 2025 15:06:32 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAZEl-00054H-22
 for qemu-devel@nongnu.org; Thu, 01 May 2025 15:06:24 -0400
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3d93c060279so4794465ab.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 12:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746126382; x=1746731182; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qj22zgHL05O6e85jZdMZPreQfGsPPd3ympYXool2RfE=;
 b=PEJhKJkF7/bQ+Iu2VFfYZXAysv2N2nZ5FPaqaX47JCT/7NT+CqgaiGyErSdXbaAta4
 uBrpQxrMIX8TyqFMcrct3XJd9i/QaEnOysHxwLtQZpfAhuIsnMCV7WAsTm4Q/f2ZIjYG
 bjaeoUxxqbzlVsoCZTvuxB7vTw4BDC2CNfqU4TYjfyPc8IY4XFbNz997w6HcEuywRa3G
 s9mRh36ZQJVYrf8ZkFr29/zVl+mKtenX5xFpfeef/IU0SfAvQ8NImliYmdy63P83MTTb
 REZol20QfZVp1yggT2M+bGSXJkKkEQkCvU2JHbJPH4Xi4S25gncvZo5noKlfnh0UkctR
 kOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746126382; x=1746731182;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qj22zgHL05O6e85jZdMZPreQfGsPPd3ympYXool2RfE=;
 b=lOyrRibRuaMFSD3P2+MTQIepKUX1YEtsLffuEn4nuggJDWlka+F4AlDDwrhu4xvM1j
 seutieRgRaxzonCPDbjEmMOjD3FjvB9INdM1pRRu6wl4IAuwjHBt0m1bh2MApVTeSWqW
 pE/jfAGejLvybFBom4gk1yr6boNzg1jHR2a5ASf7gG/vk+bfKpG8EuwZObzra2ptNi9S
 HPGK0kfHTwWOdgmraWHNYgJENTOyWWaPGV+z+F/4eQ4KJNTiWPghFDnN5JDnicgstgdm
 FxSj4yqzH9TxGhAiRrRvkR6AqHFVln3y9HUccnbOZdz05bOParuDG93Btt2E0JGy6ttH
 o8nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/YnzAD23Qc4MPio/btuY9rUIvJ4Es18DkvM/0FWLU190dh4F8vCCUVlYMCH31u99e6XZYHDujcRmg@nongnu.org
X-Gm-Message-State: AOJu0YyxDmrDymoO2byxVz8pVN5ERnoyGnJvmpe5jcOO7+wxSqzcUV+H
 5QE3sAFCBtKTDVMyNDsCl75M1HibY0tHn/+8R9qYLviiWvxt6ByR7O8P9rh+sI4=
X-Gm-Gg: ASbGncu/QYJQJEA20GZezphDLwNMG80Wj3IsCIAPMHIVVuMXCChLGMgOFVNIhKAWVsX
 5AvUUaeuZO+mC2ye7n+8iH7b70ImXG4FlKlUZEoD2HmBqn7u8t2BXIPKzZCye5w/tN1tHjXA6KB
 pFRa0MIlrJU+SkqAThR49BcAiTjFOqeg7qT+MBRHw+e06jc9zbbeDm6E/LBqpa2PsG7l6q6yj1k
 RploUQTMc1iHJcEdTgPg7XF0aqlOWpak9Nl6CJ5jNrkt+wA1SlYHWzZt1fyYdPKMdW+o5TjkOfP
 AssbQNkBkoYMyrBRh/CNcvUmp9GeqLwvKMr4mJU3gRmRIsQ8Z76uXCCBNoLKItlwrBiK2lyXvME
 28SqW6ucenFTcgg==
X-Google-Smtp-Source: AGHT+IEmRiAS2i9D2r6MeZjyjnR/NC+zjy6ATHPXH1vxn6/jW+cvSw68CoxCLQSSGuusRfck9NKyEg==
X-Received: by 2002:a05:6e02:218c:b0:3d8:1b0b:c930 with SMTP id
 e9e14a558f8ab-3d97c129edbmr736955ab.5.1746126381678; 
 Thu, 01 May 2025 12:06:21 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d975e27c99sm2745345ab.5.2025.05.01.12.06.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 12:06:21 -0700 (PDT)
Message-ID: <24662e56-d6cf-4c17-b792-e4d1ece6e241@linaro.org>
Date: Thu, 1 May 2025 21:06:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/33] target/arm/cpu: remove TARGET_AARCH64 around
 aarch64_cpu_dump_state common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng, kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-10-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250501062344.2526061-10-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-il1-x130.google.com
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

Missing the "Why?". Answer, because it is guarded by is_a64().

Should we assert on is_a64() on entry?

On 1/5/25 08:23, Pierrick Bouvier wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/cpu.c | 11 -----------
>   1 file changed, 11 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 37b11e8866f..00ae2778058 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1183,8 +1183,6 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
>   #endif
>   }
>   
> -#ifdef TARGET_AARCH64
> -
>   static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>   {
>       ARMCPU *cpu = ARM_CPU(cs);
> @@ -1342,15 +1340,6 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>       }
>   }
>   
> -#else
> -
> -static inline void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
> -{
> -    g_assert_not_reached();
> -}
> -
> -#endif
> -
>   static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>   {
>       ARMCPU *cpu = ARM_CPU(cs);


