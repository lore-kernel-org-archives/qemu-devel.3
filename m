Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625B8C19F32
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 01:15:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpzpj-0003eF-KY; Wed, 05 Mar 2025 20:15:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpzpV-0003VL-BP
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 20:15:17 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpzpT-0005AQ-7Z
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 20:15:16 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-224100e9a5cso1225785ad.2
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 17:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741223714; x=1741828514; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=peS1IFpFZGPqH0XWzCyVnBhmWH03rjRCu+gaSVoubTk=;
 b=h9M19mzEEn2b0kuRlI6gS3k0NMtx4RHW0O2vpK7qS3ZZn8oEaud99itmJhKjvF1jAH
 d+cpg0wL1v57EXOsMftXSYBs0y4JPlALlu730uftD5rO28Oj1aMHSlFdB0qRBMhUVmjp
 hkJ9JvuUTzwFgboF0hRH46bs1hympHDy29DAbynjgIjtFrItyc3rNPURZo0U3k2zxAS+
 EapS4/MBbRZ9/BvzCYk6Xtxa8xHkxaLfEscqTAVlcyvIWFQz16ZwHQXFeIgquRnKwYJE
 SZe/2xyx3nafm/VGK9JLY3Byy10lhHZotpDet57Lot0MY3jtgs94PgpLeOg9T/JCkDEU
 SHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741223714; x=1741828514;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=peS1IFpFZGPqH0XWzCyVnBhmWH03rjRCu+gaSVoubTk=;
 b=AHyd8gcZ3Bl7R/TWFQ1yrcBuQcws8es4BpTKWHCiGSGaKa5lc0otHV1+b7XvBKakUw
 6kMRwynZXNyvNMNATV1nbvJhj5b3DH7axI1h4xKlnIn3uOfGrle82T+ZyCJ4R7aHJK7C
 bkEkCV8Ob5APas97a9NsZ1ImFK3Du8UuChuIzIEcKPXS4c/RkYdOZTVevQ5qd93is56I
 uWWAMQ7NwprUWDb5XYSQMqWa7R+2PA2tSsEbOWCPJvoU4m2wP76vIHUEGr05U3LZ7MZE
 +Ae3qWZBBy7srWsDLvnMQXmhfIybOM1dEk8UdnL+PmFUV/6QFGHvkarz6iY/vDHK3s48
 Kz/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIK4k1TufUu6hfp2D8x9n6vNQsrsyJcf7BZ3wXIDG3OUb17ZoY3D/3YCU7ZEsuj639SokMYZV+PvVl@nongnu.org
X-Gm-Message-State: AOJu0YwWc7BC/4Yae6BCxityz81fBY1my0xdITBXBxxP8kN7wUcEcBew
 ls0PnNc393FNBw42prGa9q0fRWdEeNwbsmKzzLLWDu2CVK6oN/YW+lgwWbCYfdc=
X-Gm-Gg: ASbGncuKksAEKLOux1KDz3YHhDYSPdB5CNwCCZJ7vpxvDemfg5qoY7bFIqzg50QQ+xi
 JbAWAUyMLpr6WXoB+5oMTkoPg5KNfn6dhX8mpps9fPA1klu0dy9dtTpwwUCZIZi2dpgI780pWsf
 eP50R1DF3dDE67fmHy/lODhesx0On0OscauzgCF2HcU/9wkIg0cbIoy5PtlbwAQf7bOj4+QN/g+
 2vGEqZtIYN+WkdpvzCczNtaPocCPFNw7lQ+xT0Qy7QOxg+U3H1W6lK8lsTsticdIh8HYNj5rWDl
 oDgDMc6atIFZD/gV9tm7SccZsorAoat08WErD8ruDiXO6U3+O+BBBMERbR1BBx3YeDQcyegjwQK
 cbOXaqkfe
X-Google-Smtp-Source: AGHT+IEm4Zr/o8mBAYJfCJvPksIFAdJ6dDYUh7Izp35zc5IRAKDVWpRwvIo/IodsT6vudxaXTakfsg==
X-Received: by 2002:a05:6a00:4b01:b0:736:4110:5579 with SMTP id
 d2e1a72fcca58-73682b4ad97mr7747773b3a.2.1741223713591; 
 Wed, 05 Mar 2025 17:15:13 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7369824402bsm95490b3a.49.2025.03.05.17.15.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 17:15:13 -0800 (PST)
Message-ID: <8f4b598e-d09d-4d2e-afcc-317a6997ad02@linaro.org>
Date: Wed, 5 Mar 2025 17:15:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] arm/kvm: add accessors for storing host features
 into idregs
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20250305163819.2477553-1-cohuck@redhat.com>
 <20250305163819.2477553-3-cohuck@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250305163819.2477553-3-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 3/5/25 08:38, Cornelia Huck wrote:
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   target/arm/cpu-sysregs.h |  3 +++
>   target/arm/cpu64.c       | 25 +++++++++++++++++++++++++
>   target/arm/kvm.c         | 12 ++++++++++++
>   3 files changed, 40 insertions(+)
> 
> diff --git a/target/arm/cpu-sysregs.h b/target/arm/cpu-sysregs.h
> index de09ebae91a5..54a4fadbf0c1 100644
> --- a/target/arm/cpu-sysregs.h
> +++ b/target/arm/cpu-sysregs.h
> @@ -128,4 +128,7 @@ static const uint32_t id_register_sysreg[NUM_ID_IDX] = {
>       [CTR_EL0_IDX] = SYS_CTR_EL0,
>   };
>   
> +int get_sysreg_idx(ARMSysRegs sysreg);
> +uint64_t idregs_sysreg_to_kvm_reg(ARMSysRegs sysreg);
> +
>   #endif /* ARM_CPU_SYSREGS_H */
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 8188ede5cc8a..9ae78253cb34 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -736,6 +736,31 @@ static void aarch64_a53_initfn(Object *obj)
>       define_cortex_a72_a57_a53_cp_reginfo(cpu);
>   }
>   
> +#ifdef CONFIG_KVM
> +
> +int get_sysreg_idx(ARMSysRegs sysreg)
> +{
> +    int i;
> +
> +    for (i = 0; i < NUM_ID_IDX; i++) {
> +        if (id_register_sysreg[i] == sysreg) {
> +            return i;
> +        }
> +    }
> +    return -1;
> +}
> +
> +uint64_t idregs_sysreg_to_kvm_reg(ARMSysRegs sysreg)
> +{
> +    return ARM64_SYS_REG((sysreg & CP_REG_ARM64_SYSREG_OP0_MASK) >> CP_REG_ARM64_SYSREG_OP0_SHIFT,
> +                         (sysreg & CP_REG_ARM64_SYSREG_OP1_MASK) >> CP_REG_ARM64_SYSREG_OP1_SHIFT,
> +                         (sysreg & CP_REG_ARM64_SYSREG_CRN_MASK) >> CP_REG_ARM64_SYSREG_CRN_SHIFT,
> +                         (sysreg & CP_REG_ARM64_SYSREG_CRM_MASK) >> CP_REG_ARM64_SYSREG_CRM_SHIFT,
> +                         (sysreg & CP_REG_ARM64_SYSREG_OP2_MASK) >> CP_REG_ARM64_SYSREG_OP2_SHIFT);
> +}
> +
> +#endif

Why are these here, with an ifdef, instead of in kvm.c?

Rather than a loop over an array, you could do

#define DEF(NAME, OP0, OP1, CRN, CRM, OP2) \
     case SYS_##NAME: return NAME##_IDX;

int get_sysreg_idx(ARMSysRegs sysreg)
{
     switch (sysreg) {
#include "cpu-sysregs.h.inc"
     }
     g_assert_not_reached();
}

#undef DEF

> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index da30bdbb2349..2381c87e4ba1 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -246,6 +246,18 @@ static bool kvm_arm_pauth_supported(void)
>               kvm_check_extension(kvm_state, KVM_CAP_ARM_PTRAUTH_GENERIC));
>   }
>   
> +/* read a sysreg value and store it in the idregs */
> +static int get_host_cpu_reg(int fd, ARMHostCPUFeatures *ahcf, ARMIDRegisterIdx index)
> +{
> +    uint64_t *reg;
> +    int ret;
> +
> +    reg = &ahcf->isar.idregs[index];
> +    ret = read_sys_reg64(fd, reg,
> +                         idregs_sysreg_to_kvm_reg(id_register_sysreg[index]));
> +    return ret;
> +}

Surely this patch doesn't compile by itself,
because this will Werror for the unused function.


r~

