Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDFFC87FD1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 11:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujc2K-00062h-JQ; Wed, 06 Aug 2025 07:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujc2I-000612-PE
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 07:10:22 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujc2E-0004rw-UH
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 07:10:22 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b7961cf660so5400214f8f.1
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 04:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754478617; x=1755083417; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FaUV9WtCruzm1PZMeMIoKA/+XprDd/r1ebYWtGj0Bmw=;
 b=AY+tuTP4HaQyub1/C4p1yC86Uo7ku4sdC0+kOux9549ghh720WoEeOOfCT41Q7BxEO
 IbFrfa7MCvEIoIaeFhc3F4Y/AWKwlpPC3XNtGIE7xtcX//PWUaz9Rj0Tj9WBsDe5ohJp
 0n8H7QkfEnxyn21inb91DZ5sbz124KdMPB1AtlYGw2bcH6Tx42K3CJVZJ+t9FqxehRi1
 78qTSj5Ji0XhGxn5wlMwrDzoGXX747DgcPQQ9njfa37AEbZxOemKlijKXFDDC8vmAxgV
 TIRyxCJDD9qgIXkRCmwLPTdeGr81dsdiwzXOp+KAwtwctECau7pBEge/ZM/6n/LjY/xT
 DU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754478617; x=1755083417;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FaUV9WtCruzm1PZMeMIoKA/+XprDd/r1ebYWtGj0Bmw=;
 b=F495lIPJC7/kq5MTv7+lQenfTVBHX52MoZtLrcQleeXBQ9djITyw+LnSuzt8X4cCgG
 QQPPWMiDVUHoqgIsWZJqH3MPfT2u1J4baGCr3Uj3nqf0FRxvdb/ZVhmSWgNodTozaEXs
 zVadz5C7RWUtlE6sQ7TxKekGzvUNq1KHUJtZ7ovtMLwcOAzWtPbU01R3cUXZAV8aTa4y
 yzr76LdYyBpPfB320Y0iUjetTreZw7CfRuUshFYxFoePUkBshw/+0YVJ77sBZxuqdWu9
 YaExZXdApm2lOCEAQ/dizy+tgyC91uyDsWZGxzusROVFats1LrLqaboUE7PBM5cB3CSM
 gGRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDsWvJNzjLuGDoQBvz7gXDz93kiswoV8QCxAS/uYYmgnib7iY0drF+ittNr2wfio3KS3rLjN3wap1E@nongnu.org
X-Gm-Message-State: AOJu0Yx6ToUtqb9a2Ov4cAneUl0UYEq4xEgXPPURYdyV3i0I02CN2TUx
 SYkK5IO5V0ZMupHtxwy8AcjLtsD97sjxzTl5rkpkTLZlCpRej2FCKGz/TG89DWKkcfE=
X-Gm-Gg: ASbGnctu2xAswFYnTyfcDvcqfaxtTTbk1i0ddIoqvQsoyaVo+nQWtLIByeTAB352w81
 0x2Sz0sEkiZ0FYCAyOmcC3P624UawbH8MW9jiylRU4jgluSGk2ncXiyFZHFMscK3S384v66ClXl
 MYIrhz/e1m9qYbLL/29KeHA7X1UQlFPCBh6Rfd8NQ2AOET7ryFzrG8bvc7u7NpzdDxlvdV/EkKV
 hwOAb/aAGIKqEa/0ccGReSwHY/lD4z3++IqLhihoQ/YTHT3jeAIGoVXXTDZGGSCPqrbQHk3KG+U
 +SjaL4VTP2ElktUtRSRVeXi052L8U/WQUKzyMRot0ssN2NtLruT2C37FgLGx/DvHUz4g9E0wwMA
 cXriDVg3ZcrhKm2FkdCm8XBT125nk0ow32Kz9Fc/FClJypc8sVfMHgDHUR30Am76gbw==
X-Google-Smtp-Source: AGHT+IFHzWF0sfB6N6vK97/zqKubI0KkeI+eb7HWqhDn3/OWNK/1HNqqSdtqCgYKMIQ2xuCtxx0j4Q==
X-Received: by 2002:a5d:64c3:0:b0:3b4:9721:2b31 with SMTP id
 ffacd0b85a97d-3b8f48de428mr1968891f8f.5.1754478616579; 
 Wed, 06 Aug 2025 04:10:16 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5852e28sm43789195e9.9.2025.08.06.04.10.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Aug 2025 04:10:16 -0700 (PDT)
Message-ID: <e467a9aa-56a0-4761-adfc-923d13af655d@linaro.org>
Date: Wed, 6 Aug 2025 13:10:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/13] hvf: sync registers used at EL2
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Igor Mammedov
 <imammedo@redhat.com>, qemu-arm@nongnu.org, Alexander Graf
 <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Cameron Esfahani <dirty@apple.com>
References: <20250728134114.77545-1-mohamed@unpredictable.fr>
 <20250728134114.77545-11-mohamed@unpredictable.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250728134114.77545-11-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 28/7/25 15:41, Mohamed Mediouni wrote:
> When starting up the VM at EL2, more sysregs are available. Sync the state of those.
> 
> In addition, sync the state of the EL1 physical timer when the vGIC is used, even
> if running at EL1. However, no OS running at EL1 is expected to use those registers.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   target/arm/hvf/hvf.c | 53 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 7699669e73..a1e928ddfa 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -406,6 +406,8 @@ static const struct hvf_reg_match hvf_fpreg_match[] = {
>   struct hvf_sreg_match {
>       int reg;
>       uint32_t key;
> +    bool vgic;
> +    bool el2;
>       uint32_t cp_idx;
>   };
>   
> @@ -551,6 +553,41 @@ static struct hvf_sreg_match hvf_sreg_match[] = {
>       { HV_SYS_REG_CNTV_CTL_EL0, HVF_SYSREG(14, 3, 3, 3, 1) },
>       { HV_SYS_REG_CNTV_CVAL_EL0, HVF_SYSREG(14, 3, 3, 3, 2) },
>       { HV_SYS_REG_SP_EL1, HVF_SYSREG(4, 1, 3, 4, 0) },
> +    /* vGIC */
> +    { HV_SYS_REG_CNTP_CTL_EL0, HVF_SYSREG(14, 2, 3, 3, 1), true },
> +    { HV_SYS_REG_CNTP_CVAL_EL0, HVF_SYSREG(14, 2, 3, 3, 2), true },
> +#ifdef SYNC_NO_RAW_REGS
> +    { HV_SYS_REG_CNTP_TVAL_EL0, HVF_SYSREG(14, 2, 3, 3, 0), true},
> +#endif
> +    /* vGIC + EL2 */
> +    { HV_SYS_REG_CNTHCTL_EL2, HVF_SYSREG(14, 1, 3, 4, 0), true, true },
> +    { HV_SYS_REG_CNTHP_CVAL_EL2, HVF_SYSREG(14, 2, 3, 4, 2), true, true },
> +    { HV_SYS_REG_CNTHP_CTL_EL2, HVF_SYSREG(14, 2, 3, 4, 1), true, true },
> +#ifdef SYNC_NO_RAW_REGS
> +    { HV_SYS_REG_CNTHP_TVAL_EL2, HVF_SYSREG(14, 2, 3, 4, 0), true, true },
> +#endif
> +    { HV_SYS_REG_CNTVOFF_EL2, HVF_SYSREG(14, 0, 3, 4, 3), true, true },
> +    /* EL2 */
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
>   };
>   
>   int hvf_get_registers(CPUState *cpu)
> @@ -594,6 +631,14 @@ int hvf_get_registers(CPUState *cpu)
>               continue;
>           }
>   
> +        if (hvf_sreg_match[i].vgic && !hvf_irqchip_in_kernel()) {
> +            continue;
> +        }
> +
> +        if (hvf_sreg_match[i].el2 && !hvf_arm_el2_enabled()) {

FYI this triggers an assertion when testing with my split-accel series
where we emulate EL2. Not your series issue, I need to distinct between
EL2 enabled by HW or SW.

> +            continue;
> +        }
> +
>           if (cpu->accel->guest_debug_enabled) {
>               /* Handle debug registers */
>               switch (hvf_sreg_match[i].reg) {
> @@ -731,6 +776,14 @@ int hvf_put_registers(CPUState *cpu)
>               continue;
>           }
>   
> +        if (hvf_sreg_match[i].vgic && !hvf_irqchip_in_kernel()) {
> +            continue;
> +        }
> +
> +        if (hvf_sreg_match[i].el2 && !hvf_arm_el2_enabled()) {
> +            continue;
> +        }
> +
>           if (cpu->accel->guest_debug_enabled) {
>               /* Handle debug registers */
>               switch (hvf_sreg_match[i].reg) {


