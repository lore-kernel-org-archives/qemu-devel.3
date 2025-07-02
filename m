Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A54C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWzTh-0008Si-BR; Wed, 02 Jul 2025 11:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWzTf-0008SZ-MT
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:34:27 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWzTZ-0006Ct-JF
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:34:27 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4067ac8f6cdso3279544b6e.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 08:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751470456; x=1752075256; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KZqByTgtYClNr6HEsdiv2mNbHB8Ur9EtUIXf7eoGIdM=;
 b=kVw4Os2e3O+KHRyPgMk44y5YaKY9ihKQGtO3GiK8NcyDSqgyPxhpL+/fqi6TIkGqiW
 eT1bejJuDUYzQCvPstVg0MsJT/I6emrHV96ir7DqnaSaugr5lV8s+KW7yVzQfLk7eusH
 64/TXPp5T1tzNmipwrgr9cy6jnqA6AGVOVy7SjY/3nkTNnBEp9uGnPHOD+uql7zSRxzK
 VHXJpu33/dtN1FFBs2zCGM1xAtPQ4Ii8ulRO7B+jH4IMMqIa2CNUWuH3sIOwT2kboede
 8ZVfnkfYibURRQw1M51WHIKuBBv0y3uPcPIgCijVlK4+Znz3JCNfh/bOXk68Sue2ZIZ2
 K7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751470456; x=1752075256;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KZqByTgtYClNr6HEsdiv2mNbHB8Ur9EtUIXf7eoGIdM=;
 b=QWJ/UuafsXtHWATqtuxzSjhfCpmulj/4mlFVtXQsd0m7KgAmoH7cDYcI36KzTk/64Y
 yiynb5yfYzkwa1fqOA5bGio8M5uYCJc7zbxheNFnaMFEp7R+2/iSVybk7X/X67pVll5O
 RWefe0VXm2Zcqwg3ikVJOv1i1u7NueXEYAZ1IcvpWJpXsmAjQc0I0D1/U1F+91dBkLC+
 tm1fq8VNOuaRs/YiamKDEQvc2hNMUYR3OMlD9mpXpkbhai8w3s/KZVBqx9QFBAMLBqOv
 d+JgzKqCaJzL0qg1del8zs+dO9vxLLl4JaeS6diZtmqMIA4et2aLPb7utBUxLK3OZF35
 4Wlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpyrc3L+sgpLiEo5uisDUk9hBmgZdQtsiwq8RGpuaT0fvjoEoS8057gHjSGOSX5N1UKgJXMGlsToUG@nongnu.org
X-Gm-Message-State: AOJu0YxiKQ6BSG/fLqAVbfNdAMuaytrRsrsCgWVyH14LQNjJK7hJbodJ
 KSFEOmKURaTOkBhwBlH/WmLkzR5sIUBSFN1Olryg/Wsq5fBCMUcpKwcTD50nN4TDUAo=
X-Gm-Gg: ASbGncsCvRn2n0f/DzUhveFDJsTdFJSRqeZ8PHehPSIrcI/QWwPEKI0HGj6TiCpju88
 ptL1vzQvbUDY7Eh8kHUerQ0XblToGAqszOPhpCmWoa4ZX8DzKFTCLyVixHUyFNV3jJjUj5FQHM1
 nHGeCPt0wAWHpDS/rsUAxPMxRIVZntlyQ6TuBkmjA9Ih28s39oYPsQGV9xeKF1H8td0g5QFElxR
 BHUEM0mU8K56ZErDlKnvOgKda8rwP7DxEp/exWV7Zya/J8nzjaR+yW5eNi7G6ttJa7I6ysz3r+P
 Rc5jIVMWwdLpF1Okv9YJR7bmZGZw195zKl5o9h977SiqQQ4yjFhEtCi033LSIJ5UPsI5Vruq0i3
 cjrzUKpoKspg=
X-Google-Smtp-Source: AGHT+IGk8WHdXuWa6ZZ9RZMNYF7Ge6CpZzIPKDaoqth9/+7sbqUZgjYpoVlHYMTLofVJEnw3sMjJvw==
X-Received: by 2002:a05:6808:2202:b0:3fa:f848:8dfa with SMTP id
 5614622812f47-40b8911f14fmr2768222b6e.30.1751470455782; 
 Wed, 02 Jul 2025 08:34:15 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-611b85a0d93sm1713991eaf.28.2025.07.02.08.34.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 08:34:15 -0700 (PDT)
Message-ID: <a856e1ba-4382-41e8-80cf-b626cc388f7c@linaro.org>
Date: Wed, 2 Jul 2025 09:34:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 62/68] accel/tcg: Add rr_vcpu_destroy() stub
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-63-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250701144017.43487-63-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/1/25 08:40, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/tcg-accel-ops-rr.h | 2 ++
>   accel/tcg/tcg-accel-ops-rr.c | 5 +++++
>   2 files changed, 7 insertions(+)
> 
> diff --git a/accel/tcg/tcg-accel-ops-rr.h b/accel/tcg/tcg-accel-ops-rr.h
> index a73fe5b94a6..4234ef2f706 100644
> --- a/accel/tcg/tcg-accel-ops-rr.h
> +++ b/accel/tcg/tcg-accel-ops-rr.h
> @@ -20,4 +20,6 @@ void rr_start_vcpu_thread(CPUState *cpu);
>   
>   int rr_cpu_exec(CPUState *cpu);
>   
> +void rr_vcpu_destroy(CPUState *cpu);
> +
>   #endif /* TCG_ACCEL_OPS_RR_H */
> diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
> index a9150802369..95c7d3a3172 100644
> --- a/accel/tcg/tcg-accel-ops-rr.c
> +++ b/accel/tcg/tcg-accel-ops-rr.c
> @@ -137,6 +137,11 @@ static void rr_deal_with_unplugged_cpus(void)
>       }
>   }
>   
> +void rr_vcpu_destroy(CPUState *cpu)
> +{
> +    /* Already dealt with in rr_deal_with_unplugged_cpus() */
> +}
> +
>   static void rr_force_rcu(Notifier *notify, void *data)
>   {
>       rr_kick_next_cpu();

Why?  Is this hook mandatory?

r~

