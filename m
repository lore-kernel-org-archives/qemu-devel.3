Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68F0F3D337
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCFa-0006Po-IE; Thu, 05 Mar 2026 12:12:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyCFK-0006JG-Tu
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:12:25 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyCFI-00057u-Qh
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:12:22 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48372efa020so73896155e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 09:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772730739; x=1773335539; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yh0cwudrIwPmvaWJ2oJ7YlHyhKk2UdElu9Gw84AKPQk=;
 b=Id0JPj/xkhGujgHtgfTAT5f7FHZkb65iqDv8tHUkif/fgCZHgmrTmPeUfRDKw1JWtU
 tdfZMUI34GrazG7kKkMW5Us6qh0dG5aOzPokq1hgT7E9XhnSQuotqj+tGztfDlGdU6/Z
 6pDH7ZePLkL+oT2qyrdD9E1WopB9atxAigHqqw8u7oGoECibQPpnPJq0l32ODXH9n4CJ
 T/2R3yVcnYyUiYfflfsjJupU5VOhFCbDa99DawrYyqCHLX2fnDAjXBOZgwyOV3m5IPav
 kI8B2ReDwO/fl7gGJXIX0WpESd2hCyvXABo2LA+spw3SAqYpjh8D3fUPMO/eM1YY1a6t
 hebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772730739; x=1773335539;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yh0cwudrIwPmvaWJ2oJ7YlHyhKk2UdElu9Gw84AKPQk=;
 b=rKISaXY/MvR9mchUoa6l+2xUjvlfhWAfofSoxrlxvkC6F5fkdNaFlxbiCwf3uM63xz
 CBOitdyLWF7a8XLv2GKDeLL/xjSTJuYegKOku6zzzVQuuxJOEWmTElZUZ+sKJyEDaI7E
 eCgoE+0e708cRa+gbe1mZq/sfN6o57qBIK25thGCaJDWIgsuSXtx6RyYOct1/U582Aew
 8xll5K5csvRxANRNhVImhyRmz8vB0z8HxgO7fTlRZ2hAtzulpTJmYzd40Ir2uKYwSaZP
 naejDyV8Dh7YNt5aKqKgsV71TL0Bl+L6GYqaj1qqatiMKmN+qemgM0MPesc16W0IRIcp
 IGpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcuO25vva+vWUbx8SUCTiRsGbJztXYFRm1IS2fP1wx/lRrYlmqSqXIWklqLqgo+INAY5ah0UYIrTTM@nongnu.org
X-Gm-Message-State: AOJu0YwpwVKXVw4iVMGupNYJepOjSOcjbcjM6hu+Xr+MWMSgNOO/cRAT
 yzqQBexDiQQZa0rV6XhYJ+tiUInIyLT4pKs2Nx3EAAfPHtlqqmvaqLWLJKfIsph4XtY=
X-Gm-Gg: ATEYQzzH6SHc0DkwRG7KW1Tvz4mDk7fmfT+KjLfsDDrbZMdj6MWZyPAoGe/Sqif4LOR
 pLpxsyzqxcrd8HTJOisrZewVaBVna8r4L7VelGY9PInMJKsrF2iPF/B6eDAs85Atj8MikxqA1UJ
 U6/GQoWJdYQTwGmPxlMY80qaKLrN8NQaMN1BICza7qkAKHEk4F6sl/6XG2kwnGe9Oz70HqqWTv5
 uDOn9Q/E3rpwkWhuhAVXOu3AXNTk/vtCx8JIXdz4f1gSOYuRxJ/xOCM+mHlcjAfqFyJgNm3pjkk
 tZIpWpNPzZOgU56Ay+I+RCASpfwuvWjfYJo6Eb4EsiRTuJkVzwNsDXE6JlEEVscY5lrlLJnvEdX
 ROVLkMBWp6CtIgPknId/KxXc7REER4BakI/3l7M/b0d32vzSG9848FdeePR3Dw0PfUI3fqAWkp5
 ERNwb8S7un1cDNKNtSpXuVbtS0pcUj/rVHuj/AEtlHO3C+NbkVFZLtYzIZvd2Cm/irwQ==
X-Received: by 2002:a05:600c:6291:b0:47e:e20e:bbb0 with SMTP id
 5b1f17b1804b1-48519837bbdmr96375175e9.6.1772730738513; 
 Thu, 05 Mar 2026 09:12:18 -0800 (PST)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b1b97927sm38007618f8f.28.2026.03.05.09.12.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2026 09:12:18 -0800 (PST)
Message-ID: <1c974eed-8291-4000-bf8d-cdc991b23f6a@linaro.org>
Date: Thu, 5 Mar 2026 18:12:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 10/12] hvf: sync registers used at EL2
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>
References: <20260228220837.35275-1-mohamed@unpredictable.fr>
 <20260228220837.35275-11-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260228220837.35275-11-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 28/2/26 23:08, Mohamed Mediouni wrote:
> When starting up the VM at EL2, more sysregs are available. Sync the state of those.
> 
> In addition, sync the state of the EL1 physical timer when the vGIC is used, even
> if running at EL1. However, no OS running at EL1 is expected to use those registers.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   target/arm/hvf/hvf.c        | 37 ++++++++++++++++++++++++++----
>   target/arm/hvf/sysreg.c.inc | 45 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 78 insertions(+), 4 deletions(-)


> +#define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID},
> +#define DEF_SYSREG_EL2(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID, .el2 = true},
> +#define DEF_SYSREG_VGIC(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID, .vgic = true},
> +#define DEF_SYSREG_VGIC_EL2(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID, true, true},
> +
> +struct hvf_sreg {
> +    hv_sys_reg_t sreg;
> +    bool vgic;
> +    bool el2;
> +};
>   
> -#define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2)  HVF_ID,
> -
> -static const hv_sys_reg_t hvf_sreg_list[] = {
> +static struct hvf_sreg hvf_sreg_list[] = {
>   #include "sysreg.c.inc"
>   };
>   
> @@ -1052,11 +1073,19 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>   
>       /* Populate cp list for all known sysregs */
>       for (i = 0; i < sregs_match_len; i++) {
> -        hv_sys_reg_t hvf_id = hvf_sreg_list[i];
> +        hv_sys_reg_t hvf_id = hvf_sreg_list[i].sreg;
>           uint64_t kvm_id = HVF_TO_KVMID(hvf_id);
>           uint32_t key = kvm_to_cpreg_id(kvm_id);
>           const ARMCPRegInfo *ri = get_arm_cp_reginfo(arm_cpu->cp_regs, key);
>   
> +        if (hvf_sreg_list[i].vgic && !hvf_irqchip_in_kernel()) {
> +            continue;
> +        }
> +
> +        if (hvf_sreg_list[i].el2 && !hvf_nested_virt_enabled()) {
> +            continue;
> +        }
Nice :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


