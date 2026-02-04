Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98943EA7946
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 21:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnkgn-0002YL-9t; Wed, 04 Feb 2026 16:45:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnkgl-0002Wz-PV
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 16:45:31 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnkgc-0003Gy-8J
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 16:45:31 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a933b9b591so2673455ad.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 13:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770241425; x=1770846225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aeLRGdDBj1AFRA3wa25z+MfxygATpUoUYj0qwjGdUZg=;
 b=pIiI0gFDtkpTo0lKD3IBWTGbD09Dw3oVzRIu7FOqgMZgxjxM1epKI8pVeMfqCYQr++
 ncaFQNmbvMzrroz9TulbQ329z7ZqqvW7IRAjt4FEjPN7lNqUP9YOS0RlSsh4SqkN/y1W
 vc1Jse/G69B0N4pEhk1ktN5MR5Bh2JvEUIS15P4LVTTxKqYokuySm8z/SlKqMRoItU4V
 1iwe2HEhA/ASu8WwO2CdfVKt7+um2QijNieMGf6hrOUKQZRPENeV47H75nl1kq1nj29b
 scUsMFRgUNEiDKwGb1XC70W1xgLtBpIcSrw6VDceUi/sxTrnuNStVsc9DxW956Exi0Zg
 Cm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770241425; x=1770846225;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aeLRGdDBj1AFRA3wa25z+MfxygATpUoUYj0qwjGdUZg=;
 b=MI8A49YOXnlPuyc1GY4cTPrfYxv2D9zcPRciXKWgQiyiwTL1XbP+y+Ixplbyx+aHXW
 AsCV66dC/XUxbs3l6/mJ2tSR97vPTi2yekiTLzRrJf8LsHcwStHXMVlT7+yMxPj1TWfs
 XVqI5aYyTJTBAEIUNWmMEZTK0ycmyYQbi/5q7qcOyyebmhKNermn67c5yJhi5axBk95G
 3wE0DC5BTWbnh/w2ReGedciOUQA+PJ0mNbu1Gi7+m29C+lZ8QCZPTU2OGepkdilkMs8f
 BsWTz4R6iHylkMIzrOCx7DwOt1EIDRKivsfeQQ2RcGwsMm4eRdZvtYw7K/2oZjzyP/3g
 AfbQ==
X-Gm-Message-State: AOJu0Yz8HqQWgg0V2OcFZuzQWgz36/tJERW4cOq5AsahmCxg/TZAj6gh
 WV3pyj4XdYW+xpH+P2ERhUJBZH3m+ViiPH3e0x1LDXCJ8nUHrGSLwtXQe6RB5Y0UNULwWejEuRn
 VAuT+z3RrlA==
X-Gm-Gg: AZuq6aKL9iiaftKcAUpUyaKIgFzTRts3vCHi3QWegzQxEztgjPRheXu0bcLXv/2llsR
 8F0Pz9o6Fe9ihA7EymrdS74IXYiht1ik5MbYSA+x9wG3xGHkTcn8Golg0kgU9BuaFt3lbj15YSG
 2y2vyQg1eSfnSKmwEQxMzA/6UBUJQDJHmlNLNUQPAcaiPl0pBQwBcQQjIR3Ub9XA9haq6liM7/Y
 w57WiJlJNaamVujmt50nWcqALEaKAZl5NQR+mRUe083ZHfPVB7R1gdbC+DKZjdug5b2TTYi6UbX
 axTpIwuRRrE1/ZrbhqJvoEZC2NmxnnqnbzzjuV86EtBsv85J9dNV7LFBZOd77W8Y4rQlzR8LO0c
 QFVml7gKB6Wl294uAwfGfsDhGwtuOTrECU6xNnAIQQEQtXDyjBx5BypjAaVKZSlwZp7rBLb8XMZ
 gQJQ2lmjbYlY28f3PtQhdCiu0km0OCRkm/6zkzxO0jfbh7s74y8VrJC8CM4pQvWr+mW1WF/6OV
X-Received: by 2002:a17:903:faf:b0:2a0:d692:5681 with SMTP id
 d9443c01a7336-2a933d1f2b1mr38181005ad.24.1770241424964; 
 Wed, 04 Feb 2026 13:43:44 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:110e:c2b5:eb10:f92d?
 ([2401:d002:dc0f:2100:110e:c2b5:eb10:f92d])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a93394e7ffsm33869155ad.50.2026.02.04.13.43.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 13:43:44 -0800 (PST)
Message-ID: <3e6ab807-37df-40ba-840e-4693071691f7@linaro.org>
Date: Thu, 5 Feb 2026 07:43:40 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/arm: implement FEAT_E2H0
To: qemu-devel@nongnu.org
References: <20260204131353.2977855-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260204131353.2977855-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 2/4/26 23:13, Alex Bennée wrote:
> FEAT_E2H0 is a formalisation of the existing behaviour of HCR_EL2.E2H
> being programmable to switch between EL2 host mode and the
> "traditional" nVHE EL2 mode. This implies at some point we might want
> to model CPUs without FEAT_E2H0 which will always have EL2 host mode
> enabled.
> 
> There are two values to represent no E2H0 systems of which 0b1110 will
> make HCR_EL2.NV1 RES0 for FEAT_NV systems. For FEAT_NV2 the NV1 bit is
> always valid.
> 
> Message-ID: <20260130181648.628364-1-alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>    - new helper and properly handling NV1
> ---
>   docs/system/arm/emulation.rst |  1 +
>   target/arm/cpu-features.h     | 12 ++++++++++++
>   target/arm/helper.c           | 16 +++++++++++++---
>   3 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
> index e0d5f9886e1..7787691853e 100644
> --- a/docs/system/arm/emulation.rst
> +++ b/docs/system/arm/emulation.rst
> @@ -54,6 +54,7 @@ the following architecture extensions:
>   - FEAT_DotProd (Advanced SIMD dot product instructions)
>   - FEAT_DoubleFault (Double Fault Extension)
>   - FEAT_E0PD (Preventing EL0 access to halves of address maps)
> +- FEAT_E2H0 (Programming of HCR_EL2.E2H)
>   - FEAT_EBF16 (AArch64 Extended BFloat16 instructions)
>   - FEAT_ECV (Enhanced Counter Virtualization)
>   - FEAT_EL0 (Support for execution at EL0)
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index e0b7a45b7bd..78ff761ae06 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -347,6 +347,7 @@ FIELD(ID_AA64MMFR3, ADERR, 56, 4)
>   FIELD(ID_AA64MMFR3, SPEC_FPACC, 60, 4)
>   
>   FIELD(ID_AA64MMFR4, ASID2, 8, 4)
> +FIELD(ID_AA64MMFR4, E2H0, 24, 4)
>   
>   FIELD(ID_AA64DFR0, DEBUGVER, 0, 4)
>   FIELD(ID_AA64DFR0, TRACEVER, 4, 4)
> @@ -1378,6 +1379,17 @@ static inline bool isar_feature_aa64_asid2(const ARMISARegisters *id)
>       return FIELD_EX64_IDREG(id, ID_AA64MMFR4, ASID2) != 0;
>   }
>   
> +static inline bool isar_feature_aa64_e2h0(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64_IDREG(id, ID_AA64MMFR4, E2H0) == 0;
> +}

 From D24.1.3 Principles of the ID scheme for fields in ID registers, this field is 
signed, so: FIELD_SEX64_IDREG(...) >= 0

> +
> +static inline bool isar_feature_aa64_noe2h0_and_nv1_res0(const ARMISARegisters *id)
> +{
> +    /* 0b1110 is not permitted unless we have FEAT_NV */
> +    return isar_feature_aa64_nv(id) && FIELD_EX64_IDREG(id, ID_AA64MMFR4, E2H0) == 0b1110;
> +}

FIELD_SEX64_IDREG(...) <= -2

And you don't need the nv check because that would otherwise be an invalid value, as you 
say.  We don't need to double-check invalid ID register settings at this point.

I would probably drop the noe2h0_and_ substring, because it's not really relevant to what 
you're wanting to test.


> @@ -3801,10 +3802,13 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
>               valid_mask |= HCR_GPF;
>           }
>           if (cpu_isar_feature(aa64_nv, cpu)) {
> -            valid_mask |= HCR_NV | HCR_NV1 | HCR_AT;
> +            valid_mask |= HCR_NV | HCR_AT;
> +            if (!cpu_isar_feature(aa64_noe2h0_and_nv1_res0, cpu)) {
> +                valid_mask |= HCR_NV1;
> +            }
>           }
>           if (cpu_isar_feature(aa64_nv2, cpu)) {
> -            valid_mask |= HCR_NV2;
> +            valid_mask |= HCR_NV1 | HCR_NV2;

Why add NV1 here?

>           }
>       }
>   
> @@ -3823,6 +3827,12 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
>           value |= HCR_RW;
>       }
>   
> +    /* Strictly E2H is RES1 unless FEAT_E2H0 relaxes the requirement */
> +    if (arm_feature(env, ARM_FEATURE_AARCH64) &&
> +        !cpu_isar_feature(aa64_e2h0, cpu)) {
> +        value |= HCR_E2H;
> +    }

Merge the aarch64 test with the previous block.


r~

