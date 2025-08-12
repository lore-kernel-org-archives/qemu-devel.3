Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F56CA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 22:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulxXY-0002zs-Ve; Tue, 12 Aug 2025 18:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ulxXW-0002zT-56
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 18:32:18 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ulxXM-0007qQ-0b
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 18:32:16 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-76bdea88e12so5157878b3a.0
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 15:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755037922; x=1755642722; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7NcA2ibZA6OD/D3dyrnG+kVDrjyeC84AhvKY/xmgzcY=;
 b=DMr3dsTXc6uuzpeQ7CvVk6IthgleGyTDuvSYAOgjnf6+lXgHpmGMFFaDISO++unvzT
 VJglC/tJoViQtssBt/gzWEUmfgxpxz4mi7ZZ7N7Un52vmDMqQ//XBMGKNeYCCWtvEOjQ
 i007UyxQuMatAoZXWs2BIEGEG32B8+SlgN1UI9ZWL6y52DuJu/HS8dULwRZ8pfoY9rQ8
 2NpYoOcdWeCjEDJfmRIey4MOs4bym92tMmPQMFER4+QMvLL9c9gRVVEMFTVlNMg2YGO3
 5VSq5s5n7SfwTi0mNCGl8Pxd0QH0hhkDHH3J+ti6BlDg1b1WPuBqGMMx6r8I9+gV7Zjn
 zWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755037922; x=1755642722;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7NcA2ibZA6OD/D3dyrnG+kVDrjyeC84AhvKY/xmgzcY=;
 b=iC8h69WUe7rPi+5zbGOSRYcWjbBFlFAMbzq2uQrQ7RvDv/PnqPPX7WQQWaPKPCZmYQ
 37nq+mueZPGhr/mTgpuP1/5cSie7DeK/yELcM8gSu4NntKHnp48TFsA6wObDF3iU9UCI
 LpjXPd+cg9d3pDDzIVkO6fRKLC3cVFWVTwiN7bypXKUUyuPhcFV9eECzxeuMy8dkl0GK
 aJ3oU0Kcm9SV8gXx9F6bWVhsYsXc2QoNm2S8Golu+eskodvevSLVCkP4Xw19HYgeGse9
 dSuVj/SH3QL5RfubuSfC6FpEHkH+K6l+JXuLN8K/APIGvjWs8+8/bpUziJUXdQWd3moA
 cXcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnVvOMF6bHux21pNfRFVaXqmndQ0xH/OG1NXf8XT3wC2cRyrscz4IOKOvkUYTWrYWC8KkHNoSnbQN2@nongnu.org
X-Gm-Message-State: AOJu0YxZF+cnXN8ngoynOkLPwjXh+VC3vBG7WFbaGu1p04ZsM/oXpMie
 NxEbhGJhn/O2DTVx+TP3zbc+98u8+AiYGoGrvh16TOygwlmAjojYH8aWi1w4sJBXcJk=
X-Gm-Gg: ASbGncuE3FuJtWbx/LIAQXVj+k0vOpVhozEnasJmp4MSIp0k1fTrJ0GrYBWMWxeMScl
 IMI9qu2rEqy939fRNqbX7E90EiEHgbe9qgp6ee+IryatqPIgXjo9UwmVk9l1CeiPAdraDpqFRB5
 erGcfDvsR29GQ20yRquWUyiMtzmua24+1cAE31RbRsmOFJe8cZtyEmwIMVBUlVZ8JXpqUPSs1QW
 8OlbhGcqq8B301ULgcsGipRuOepV4yz4+Hj03Zwj3jt4C5gc+6rXjHcH7y6jspy6ehn1Qr8vh3+
 g/6iWv0BVgJzxdyPUN/eJHIb6Wt7VdBaOp95/uNb6+EBRnrzPSvnyPxTPZhHAR9AaOOKLJhfjjJ
 L5ckYLacXnfT5uXIbR5cJm7bw3dNJWBPsxjn/1qpa
X-Google-Smtp-Source: AGHT+IEQH6BfqWsI8lNloCKE73bFye1ZrAElGm4359xfNS3q8cKGA/6QPyQ4QxHqiW5daRyNOeszMQ==
X-Received: by 2002:a05:6a00:bc3:b0:76b:f06f:3bca with SMTP id
 d2e1a72fcca58-76e20f75393mr969654b3a.11.1755037922034; 
 Tue, 12 Aug 2025 15:32:02 -0700 (PDT)
Received: from [192.168.4.112] ([168.140.255.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76c61705bd7sm9367042b3a.31.2025.08.12.15.31.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 15:32:01 -0700 (PDT)
Message-ID: <30f26e53-9976-4826-a25c-9cb7bb551280@linaro.org>
Date: Wed, 13 Aug 2025 08:31:54 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 08/10] target/arm/hvf: Sync registers used at EL2
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250812172823.86329-1-philmd@linaro.org>
 <20250812173157.86934-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250812173157.86934-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

On 8/13/25 03:31, Philippe Mathieu-Daudé wrote:
> +    { HV_SYS_REG_CPTR_EL2, HVF_SYSREG(1, 1, 3, 4, 2), .el2 = true },
> +    { HV_SYS_REG_ELR_EL2, HVF_SYSREG(4, 0, 3, 4, 1), .el2 = true },
> +    { HV_SYS_REG_ESR_EL2, HVF_SYSREG(5, 2, 3, 4, 0), .el2 = true },
> +    { HV_SYS_REG_FAR_EL2, HVF_SYSREG(6, 0, 3, 4, 0), .el2 = true },
> +    { HV_SYS_REG_HCR_EL2, HVF_SYSREG(1, 1, 3, 4, 0), .el2 = true },
> +    { HV_SYS_REG_HPFAR_EL2, HVF_SYSREG(6, 0, 3, 4, 4), .el2 = true },
> +    { HV_SYS_REG_MAIR_EL2, HVF_SYSREG(10, 2, 3, 4, 0), .el2 = true },
> +    { HV_SYS_REG_MDCR_EL2, HVF_SYSREG(1, 1, 3, 4, 1), .el2 = true },
> +    { HV_SYS_REG_SCTLR_EL2, HVF_SYSREG(1, 0, 3, 4, 0), .el2 = true },
> +    { HV_SYS_REG_SPSR_EL2, HVF_SYSREG(4, 0, 3, 4, 0), .el2 = true },
> +    { HV_SYS_REG_SP_EL2, HVF_SYSREG(4, 1, 3, 6, 0), .el2 = true},
> +    { HV_SYS_REG_TCR_EL2, HVF_SYSREG(2, 0, 3, 4, 2), .el2 = true },
> +    { HV_SYS_REG_TPIDR_EL2, HVF_SYSREG(13, 0, 3, 4, 2), .el2 = true },
> +    { HV_SYS_REG_TTBR0_EL2, HVF_SYSREG(2, 0, 3, 4, 0), .el2 = true },
> +    { HV_SYS_REG_TTBR1_EL2, HVF_SYSREG(2, 0, 3, 4, 1), .el2 = true },
> +    { HV_SYS_REG_VBAR_EL2, HVF_SYSREG(12, 0, 3, 4, 0), .el2 = true },
> +    { HV_SYS_REG_VMPIDR_EL2, HVF_SYSREG(0, 0, 3, 4, 5), .el2 = true },
> +    { HV_SYS_REG_VPIDR_EL2, HVF_SYSREG(0, 0, 3, 4, 0), .el2 = true },
> +    { HV_SYS_REG_VTCR_EL2, HVF_SYSREG(2, 1, 3, 4, 2), .el2 = true },
> +    { HV_SYS_REG_VTTBR_EL2, HVF_SYSREG(2, 1, 3, 4, 0), .el2 = true },

Again, el2 = op2 == 4.

> @@ -608,6 +630,11 @@ int hvf_get_registers(CPUState *cpu)
>               continue;
>           }
>   
> +        if (hvf_sreg_match[i].el2
> +            && !host_cpu_feature_supported(ARM_FEATURE_EL2)) {
> +            continue;
> +        }

I thought you were going to change this to arm_feature(&cpu->env, ARM_FEATURE_EL2).


r~

