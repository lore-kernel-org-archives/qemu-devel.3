Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D99CA0EC4
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 07:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1um5nE-0000Wk-RF; Wed, 13 Aug 2025 03:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1um5n2-0000VK-83
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 03:20:53 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1um5mz-0005QH-Vi
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 03:20:51 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-458b885d6eeso40146375e9.3
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 00:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755069648; x=1755674448; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2Zhj4lI0OABTDGI89H8lBd5DvpZBOYeRtqOec8Dl59M=;
 b=m1wvpmDIKxCgxo9EkeOPLrXi9t3yJuqlJip24yKfTLxQy4PJLflJ364Ux+hkAL4R3E
 RDXoXeI+yrTGp6r1rlrqo3pc3kRYa6GvafaWDuscwZ1WwFe16HN/epv6Hl7nij59rKKP
 4pQT2+nsdzj3d1FkXwwdMiBBzXaUNm0oy39ULDoFTkAwauJUFkn50BWlKBu08NCKHaKS
 5iyHRNl7jvkGF06MkVKFAJvPyb5cKnSXO+MV6nPyWOiLaMTCps5Z3VJCfCK22ORNeHMi
 grjsydZgN0paAnBCZNSTwcjziFVUXtcn5QmG/X847n+buytteCobqo6MO5td+i1b7Mku
 vQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755069648; x=1755674448;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2Zhj4lI0OABTDGI89H8lBd5DvpZBOYeRtqOec8Dl59M=;
 b=rj7gxR0JPZGI4su27tTAoJov9eOY2zNZ7seePSivKBabxcwHcnuQjFPLg3aSIXWF/j
 vSp+IutYpE4V0S1dyYuY4kjEEqR7pxu8dZdx8ur0LOkm2uxcy4VcjUtLjyxiS/2hHDax
 DBe7jFFKb5ge0OuYuRSQrQGDI41DXYnLu+AsFLzCFiplagLEgw7E4pwr/AncWD3OlDRz
 5HmArFtjjjzf2ghhsNKMk+t/lzffXcdChUbzZaT0Aq1x+sTAsKnPNhpdTsypy59RtpRc
 Bth8SmHf/EL3PFbH5Gn4ux+0hSShKOUAOKn4b7h2myMqqxFJ23SOL0KurSRGHp1TAp4m
 +C3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOiJ0uaGUxxB9IoAnpnU/Ow4zfnZLz9NCVG94itTJTCIpXsEu8H+obmQIE3SQVYcrREJYlk7+Mwc8z@nongnu.org
X-Gm-Message-State: AOJu0YwDk/zFIhI6XOsX1GZJj6jBtw4j64N0dIuCrbG0jbKPa8WUq5+S
 v0/kDGLiL2qd+1OYAZurM+AupkkC3ctBdtvDCvxkWq3MfoXcZAiqAoEn490LVHYsi5T9Qq+743W
 YYtUh
X-Gm-Gg: ASbGncu1LdiIymeP5nHGTEnH3Mxbq5jho8Vi+m36aGWhxp10VH/RYEyRl1GbGjvDiC6
 TMrqowsVw/Zqcg0EprenOhjfpL2H+pl6ddZm8kbxa709VsDuwSopXwRgk7bsxfcZVhozHMghC7p
 DEuQkXxSjk+U1ta9C3cmRHMAhjo5lxNIaStmi/bG2mJ91wewup1F2ErWeQ1rlptxhLupXK/cCuF
 IcfYHEY/J4f+Fd9HCyr9z2lPZmOsYua91y56W1uqn3q9V0SGn+n/R3gy/ddIMRdn4sBiCLF9toG
 i/J/PKKS6DG9Ku7VLWoQtA6hYBftdpSwyZYwFhWI7SpUwnaeuEz+s80LA9ITUBpvF2ax04wpsgC
 5hWtwCoJBg+NwLsUYy73uG17o58Gt/ftnpn5uCvVkMHSuriQDUpnwhVWn6VtWfNe7zg==
X-Google-Smtp-Source: AGHT+IHk+eEhrh+zwmlck/MikMNtCePcL6bxysClBPzCIpwCiTDu77+jUALk/a07ZqghpNnp7bBM6w==
X-Received: by 2002:a05:6000:2c01:b0:3b9:10c5:bd7d with SMTP id
 ffacd0b85a97d-3b917d1e304mr1327118f8f.10.1755069647803; 
 Wed, 13 Aug 2025 00:20:47 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4a2848sm45965548f8f.71.2025.08.13.00.20.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Aug 2025 00:20:47 -0700 (PDT)
Message-ID: <94eab92c-9b55-404f-8e61-f9e80dc49703@linaro.org>
Date: Wed, 13 Aug 2025 09:20:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 08/10] target/arm/hvf: Sync registers used at EL2
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250812172823.86329-1-philmd@linaro.org>
 <20250812173157.86934-1-philmd@linaro.org>
 <30f26e53-9976-4826-a25c-9cb7bb551280@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <30f26e53-9976-4826-a25c-9cb7bb551280@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 13/8/25 00:31, Richard Henderson wrote:
> On 8/13/25 03:31, Philippe Mathieu-Daudé wrote:
>> +    { HV_SYS_REG_CPTR_EL2, HVF_SYSREG(1, 1, 3, 4, 2), .el2 = true },
>> +    { HV_SYS_REG_ELR_EL2, HVF_SYSREG(4, 0, 3, 4, 1), .el2 = true },
>> +    { HV_SYS_REG_ESR_EL2, HVF_SYSREG(5, 2, 3, 4, 0), .el2 = true },
>> +    { HV_SYS_REG_FAR_EL2, HVF_SYSREG(6, 0, 3, 4, 0), .el2 = true },
>> +    { HV_SYS_REG_HCR_EL2, HVF_SYSREG(1, 1, 3, 4, 0), .el2 = true },
>> +    { HV_SYS_REG_HPFAR_EL2, HVF_SYSREG(6, 0, 3, 4, 4), .el2 = true },
>> +    { HV_SYS_REG_MAIR_EL2, HVF_SYSREG(10, 2, 3, 4, 0), .el2 = true },
>> +    { HV_SYS_REG_MDCR_EL2, HVF_SYSREG(1, 1, 3, 4, 1), .el2 = true },
>> +    { HV_SYS_REG_SCTLR_EL2, HVF_SYSREG(1, 0, 3, 4, 0), .el2 = true },
>> +    { HV_SYS_REG_SPSR_EL2, HVF_SYSREG(4, 0, 3, 4, 0), .el2 = true },
>> +    { HV_SYS_REG_SP_EL2, HVF_SYSREG(4, 1, 3, 6, 0), .el2 = true},
>> +    { HV_SYS_REG_TCR_EL2, HVF_SYSREG(2, 0, 3, 4, 2), .el2 = true },
>> +    { HV_SYS_REG_TPIDR_EL2, HVF_SYSREG(13, 0, 3, 4, 2), .el2 = true },
>> +    { HV_SYS_REG_TTBR0_EL2, HVF_SYSREG(2, 0, 3, 4, 0), .el2 = true },
>> +    { HV_SYS_REG_TTBR1_EL2, HVF_SYSREG(2, 0, 3, 4, 1), .el2 = true },
>> +    { HV_SYS_REG_VBAR_EL2, HVF_SYSREG(12, 0, 3, 4, 0), .el2 = true },
>> +    { HV_SYS_REG_VMPIDR_EL2, HVF_SYSREG(0, 0, 3, 4, 5), .el2 = true },
>> +    { HV_SYS_REG_VPIDR_EL2, HVF_SYSREG(0, 0, 3, 4, 0), .el2 = true },
>> +    { HV_SYS_REG_VTCR_EL2, HVF_SYSREG(2, 1, 3, 4, 2), .el2 = true },
>> +    { HV_SYS_REG_VTTBR_EL2, HVF_SYSREG(2, 1, 3, 4, 0), .el2 = true },
> 
> Again, el2 = op2 == 4.

Sorry I forgot about this :/

> 
>> @@ -608,6 +630,11 @@ int hvf_get_registers(CPUState *cpu)
>>               continue;
>>           }
>> +        if (hvf_sreg_match[i].el2
>> +            && !host_cpu_feature_supported(ARM_FEATURE_EL2)) {
>> +            continue;
>> +        }
> 
> I thought you were going to change this to arm_feature(&cpu->env, 
> ARM_FEATURE_EL2).

Replied in v1:
https://lore.kernel.org/qemu-devel/08f2c3ff-a509-4a96-a515-b3ceae2ea9ea@linaro.org/



