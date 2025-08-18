Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BFBCA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 12:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unzBX-00023V-Ke; Mon, 18 Aug 2025 08:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1unzBU-00022d-Ge
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 08:41:56 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1unzBS-0007Lo-Pd
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 08:41:56 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45a1b0b2d21so18880405e9.2
 for <qemu-devel@nongnu.org>; Mon, 18 Aug 2025 05:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755520912; x=1756125712; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sfmz8/qz9rOuua160TKAH+wxpmWn0p2f1SV2GlUzMOM=;
 b=tqb+TSZxrLjN8cK3UyUxOTC2UoQNYoUQE49BKIbS/U0t4RrcApqbwATZS3zu4O8sPh
 9VMRcR6Ez2tj1EbtBdBQFdH2Ype0BMr+PDAgJvzOk3I90XzwRb2VUY0Gxmph5G/fjCo9
 fJJXbOvd68IXgGL6Gk+PjosceqPW3oAjEVst4I4QzCf//TbVZvOlX1CcYpFbXbqEsYem
 jk8obhT+Ynu/FXziQccTJtbIZENuyfAdeRMRXQi+E2yzznrkNl5H4v21dj347+7gUOJG
 ycnEUhH6HbxxpWNrji3xIleVCO7F3AGMLOwM7i6Hx7lfxbZ626epU62lPaOQcX5cPypp
 nOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755520912; x=1756125712;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sfmz8/qz9rOuua160TKAH+wxpmWn0p2f1SV2GlUzMOM=;
 b=Ko1mm1RSFaBmonMo75nURMGvWH4NUH47xOhV3qBSSY4Gne0UDIUixTw0GdJCjJ1OUf
 rMkiNcOuvHXJWlfRl6rDi/WWmk2zej4TPmlMY9dPpw1Ki2sLdyDsEmfDCwj4snJkI/sQ
 NVeeEin7O9dP63NdkrqytvOy4GDisXsbgrzSJAzZCmFcRwZS3sYWyjpwcMy6gs5tzEXc
 BJSKatZdXp5E+Iit7voc7xOJpV76/9oZTpQ/VRnkCPQ4870ptBk8Hc/dUgB9LzPnejFX
 KYN18oZuv6ZEpvu4gPi9PlDKJLT1wYwI7TPGMuJaNeNGvrimonKLA/bfPWUUB0rTQCjQ
 hZEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgCATIIdwgZW+zvwxpi5/jRC7YdwUI4NlXVVzrY6Oj2qMV3LM9Fb/QKMWgb9foa5Q7RavZKc/veTrT@nongnu.org
X-Gm-Message-State: AOJu0Yyw5HdKioUsgZkjRJ7Qeo8nalmEhiyC4w2jD9vcHH8ILzlWAX6A
 tUKdCGMPJfoEuDlll+Yy2ABhCGJtJ74wyrK0uVWqCIsbQYSXV/Ps54qvhH9Zlxm46Ek=
X-Gm-Gg: ASbGncuNKlLqxzh1Ez9mthZEb+CgLzzp3LwQz1KjDbP1YXvbeSGtCuKWe2lC23KYBsJ
 CWMf1PC0R/14lLKOZsQ3HnH6sVwAYChC6956QEZbJDBjZ3+cniJZN2TNnE63fvDQrve2h4MdTh+
 p9YL6D3vu57NgpD/Bp+OvpfRWQmX9IwfNddO/s5lk7XNWOVkX+dXk57EJrT+6h3sFNSdoWje++V
 kACjaZddd2L+7mdwT+12rRk4uu9IZrrPHpXD+qUDakTd4/7nbt5bQ4le+4n/7fVJTsJRi2SwJPT
 KxthSjP85ecgZDkAPklf+1FUJdhn7feNIYHCnGm45k9R9pR76YstaOpRfFb+r5glq3aHKlZjwEz
 WGQLJJsNhIHPvB/obT1FRitxkUUJerOIIvT+i8ZrIQUZTcwarQjLoD4kR7Qi3ku5TRA==
X-Google-Smtp-Source: AGHT+IEdhUp2jriuW2WAGDRYRtqF2H2q7Kq1eGp1q/cgBRLgytXcKpPAKPCDCcf+61dwh7mxAfOHkA==
X-Received: by 2002:a05:600c:b8d:b0:458:bd31:2c27 with SMTP id
 5b1f17b1804b1-45a21848eb0mr69192395e9.23.1755520912337; 
 Mon, 18 Aug 2025 05:41:52 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a22211395sm131539055e9.4.2025.08.18.05.41.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Aug 2025 05:41:51 -0700 (PDT)
Message-ID: <4312974c-9b7e-48c2-a190-071ea72da33f@linaro.org>
Date: Mon, 18 Aug 2025 14:41:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] target/arm/hvf: Add KVMID_TO_HVF, HVF_TO_KVMID
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mads@ynddal.dk, agraf@csgraf.de, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20250818041354.2393041-1-richard.henderson@linaro.org>
 <20250818041354.2393041-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250818041354.2393041-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 18/8/25 06:13, Richard Henderson wrote:
> Conversion between KVM system registers ids and the HVF system
> register ids is trivial.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index f0e4b75e6a..2577dc1c0c 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -403,6 +403,26 @@ struct hvf_sreg_match {
>       uint32_t cp_idx;
>   };
>   
> +/*
> + * QEMU uses KVM system register ids in the migration format.
> + * Conveniently, HVF uses the same encoding of the op* and cr* parameters
> + * within the low 16 bits of the ids.  Thus conversion between the
> + * formats is trivial.
> + */
> +
> +#define KVMID_TO_HVF(KVM)  ((KVM) & 0xffff)
> +#define HVF_TO_KVMID(HVF)  \
> +    (CP_REG_ARM64 | CP_REG_SIZE_U64 | CP_REG_ARM64_SYSREG | (HVF))
> +
> +/* Verify this at compile-time. */
> +
> +#define DEF_SYSREG(HVF_ID, ...) \
> +  QEMU_BUILD_BUG_ON(HVF_ID != KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));

Rebasing Mohamed's work I'm getting:

In file included from ../../target/arm/hvf/hvf.c:413:
../../target/arm/hvf/sysreg.c.inc:156:1: error: static assertion failed 
due to requirement '!(HV_SYS_REG_MDCR_EL2 != (((((1 << 28) | (19 << 16) 
| ((3) << 14) | ((4) << 11) | ((1) << 7) | ((1) << 3) | ((1) << 0)) | 
13510798882111488ULL)) & 65535))': not expecting: HV_SYS_REG_MDCR_EL2 != 
KVMID_TO_HVF(KVMID_AA64_SYS_REG64(1, 1, 3, 4, 1))
   156 | DEF_SYSREG(HV_SYS_REG_MDCR_EL2, 1, 1, 3, 4, 1)
       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Having in <Hypervisor.h> -> <Hypervisor/hv_vcpu_types.h>:
     // Exception Level 2 (EL2) registers.
     // These registers are only available if EL2 was enabled in the VM 
configuration.
     HV_SYS_REG_CNTHCTL_EL2 = 0xe708,
     HV_SYS_REG_CNTHP_CTL_EL2 = 0xe711,
     HV_SYS_REG_CNTHP_CVAL_EL2 = 0xe712,
     HV_SYS_REG_CNTHP_TVAL_EL2 = 0xe710,
     HV_SYS_REG_CNTVOFF_EL2 = 0xe703,
     HV_SYS_REG_CPTR_EL2 = 0xe08a,
     HV_SYS_REG_ELR_EL2 = 0xe201,
     HV_SYS_REG_ESR_EL2 = 0xe290,
     HV_SYS_REG_FAR_EL2 = 0xe300,
     HV_SYS_REG_HCR_EL2 = 0xe088,
     HV_SYS_REG_HPFAR_EL2 = 0xe304,
     HV_SYS_REG_MAIR_EL2 = 0xe510,
     HV_SYS_REG_MDCR_EL2 = 0xe019,   <----
     HV_SYS_REG_SCTLR_EL2 = 0xe080,
     HV_SYS_REG_SPSR_EL2 = 0xe200,
     HV_SYS_REG_SP_EL2 = 0xf208,
     HV_SYS_REG_TCR_EL2 = 0xe102,
     HV_SYS_REG_TPIDR_EL2 = 0xe682,
     HV_SYS_REG_TTBR0_EL2 = 0xe100,
     HV_SYS_REG_TTBR1_EL2 = 0xe101,
     HV_SYS_REG_VBAR_EL2 = 0xe600,
     HV_SYS_REG_VMPIDR_EL2 = 0xe005,
     HV_SYS_REG_VPIDR_EL2 = 0xe000,
     HV_SYS_REG_VTCR_EL2 = 0xe10a,
     HV_SYS_REG_VTTBR_EL2 = 0xe108,

> +
> +#include "sysreg.c.inc"
> +
> +#undef DEF_SYSREG
> +
>   #define DEF_SYSREG(HVF_ID, crn, crm, op0, op1, op2) \
>       { HVF_ID, HVF_SYSREG(crn, crm, op0, op1, op2) },
>   


