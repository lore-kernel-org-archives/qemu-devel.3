Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D9BC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 22:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXoRQ-0001tw-IO; Fri, 04 Jul 2025 17:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXoRP-0001tN-4w
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 17:59:31 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXoRN-0000GY-FM
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 17:59:30 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-611b246727cso730125eaf.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 14:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751666367; x=1752271167; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ev7KsC0b9BR/+p9nRfGPqAOeby21hJM34Dq1OG5FbAQ=;
 b=H/C9VwIZ9JB8fpI7CJIq1+W/Kztr303wcqEFQCUwVEcLu/ISceUJPe8Dgdl9qclBXm
 etEels9wMqMPmX0rzCpCOLdt+NunNQr6VxK9xSfu/bTT4psEC0p71U95BgwQWpB3h/X6
 QDI9gJBy89nvjJDIf9SF5gdBYUbW+7fbKh1/fRItqw4aJo4i6O838OZhRQLveBZCOCdQ
 i5e/G62qjOZSLnMuiFMf3soj/UIkmF31y2FsHmqdHlk3PkpQCHPZ7lWcaY1im2x+ZJto
 cXxmv12GLel/CSyEbbZ2Es0jsNiNlIeuy+7eurZmFIz9H3raIfMxGeCOMrRujo9gEYgB
 AfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751666367; x=1752271167;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ev7KsC0b9BR/+p9nRfGPqAOeby21hJM34Dq1OG5FbAQ=;
 b=vQCn0T6aJCnhQGsh6kfcCzrkzU08xdGnctknSTXakzrYeN+sv5dT3FlWHZZPOnTL2p
 MsFQ5WHWmDatQy6mPk32a4H/+KPN2Jvt/kpRNIW81GTwDqNGHUzhbGMm61ZHrFUgbTXq
 VtU8KVXADLRr6f6kn6sSo5LASiI8Dz9xs71S98jRfKiqi9IJHP60uiPgJ1uW8H+0vQav
 z6PzqPbJH2bxCdvE1ZDiWwK4lI80l/OaDFWbmdcGKwwrCQ/p1b/p3fyyWQ7E5DeCRn82
 QqknU8FffzmBUmU5pwlxz3fx5sGIO8Tx5CMgWzh4eQbDOYsrsNLheagw1xl/4mqleRDW
 9UkQ==
X-Gm-Message-State: AOJu0YwJrqQuyoYc6+WeuaXZH724Edt6oheiixQB4DCb+h3KRTfXY6Al
 ILIOJklsU/k+coBa+0JrjH0iwFA2Zo2Op8Ux/2CNhyB+PsjdcbtbIAlfTkzesjMF3mI=
X-Gm-Gg: ASbGnctSY3PjPcHIV3d/+jg0WB4uTaInrj0/vNxxrAUqeC1s3dR5BF6swBBeztndqb6
 YDIAAgF6MD0Y0LFTWn42+clk7OrkCmXT1Zv+Yx/VJnigZlaWpA2Yqt9FXo2fIt9DXo6oqzQGkIL
 yKKU+uySOTt4kX9Eq7q2legAa8kFRXfwziBddwwhuqEE24kv1BHSFv1BCHh0IqKxBbpIUNdLXNd
 pP0HCFmMEQoUxk4taydMKo7rGtoZQ0wCSKNqjFdt3sDvh919sGefMmgFJzsKxEBE553+ZZrCnL1
 36LPDSjNsuC6Mzl4HcFVDzA8PD8GJ7NsYA0niqbIxGJQrbR/jicBDxyCCsxfyzzxwYU5DVnYuKA
 KGCWaczICub2AXotTS9ytrlcgmoZPvfwkkQBDu8ZeSCVpvPmVEgo=
X-Google-Smtp-Source: AGHT+IEsrDtFGguJ116PDfJMP2MxORvHetPFKsc4Ot8546vGb6vyVsLQS+OAP5EogM/1YV4/208bvA==
X-Received: by 2002:a05:6808:2191:b0:40c:fcb9:90b9 with SMTP id
 5614622812f47-40d0737f61bmr2536416b6e.16.1751666367379; 
 Fri, 04 Jul 2025 14:59:27 -0700 (PDT)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40d02adbd55sm432967b6e.40.2025.07.04.14.59.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jul 2025 14:59:26 -0700 (PDT)
Message-ID: <bffb3cf0-25ce-41fe-bca9-5ce387f7f02e@linaro.org>
Date: Fri, 4 Jul 2025 15:59:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [WIP-for-10.1 v2 3/5] target/arm: Add FEAT_SCTLR2
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org
References: <20250704151431.1033520-1-gustavo.romero@linaro.org>
 <20250704151431.1033520-4-gustavo.romero@linaro.org>
Content-Language: en-US
In-Reply-To: <20250704151431.1033520-4-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc35.google.com
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

On 7/4/25 09:14, Gustavo Romero wrote:
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index 4452e7c21e..a42d1133c2 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -296,6 +296,11 @@ static inline bool isar_feature_aa32_ats1e1(const ARMISARegisters *id)
>       return FIELD_EX32(id->id_mmfr3, ID_MMFR3, PAN) >= 2;
>   }
>   
> +static inline bool isar_feature_aa64_sctlr2(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64(id->id_mmfr3, ID_AA64MMFR3, SCTLRX) == 1;
> +}

!= 0.  Value 2 will mean "value 1, plus ..."

This also needs updating for the IDREG reorg that landed this week.

> @@ -1692,6 +1706,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
>   #define SCR_HXEN              (1ULL << 38)
>   #define SCR_TRNDR             (1ULL << 40)
>   #define SCR_ENTP2             (1ULL << 41)
> +#define SCR_SCTLR2EN          (1ULL << 42)

44.  Bit 42 is RCWMASKEn.

> +static CPAccessResult sctlr2_access(CPUARMState *env, const ARMCPRegInfo *ri,
> +                                    bool isread)
> +{
> +    int el = arm_current_el(env);
> +
> +    if (!cpu_isar_feature(aa64_sctlr2, env_archcpu(env))) {
> +        return CP_ACCESS_UNDEFINED;
> +    }

Not needed, because the cpregs will not be registered otherwise.

> +    if ((el < 3)  && !(env->cp15.scr_el3 & SCR_SCTLR2EN)) {

Remove extra () and extra space.

For SCTLR2_EL1, this is missing the TVM/TRVM check (use access_tvm_trvm first), and the 
HCRX_EL2.SCTLR2En check.

> +static void sctlr2_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +                         uint64_t value)
> +{
> +    int el = arm_current_el(env);
> +    uint64_t valid_mask = 0ULL;

ULL is unnecessary.

> +
> +    if (el > 1 && cpu_isar_feature(aa64_mec, env_archcpu(env))) {
> +        /* SCTLR2_EL1 does not implement the EMEC bit */

Incorrect test for SCTLR2_EL1: EL is the current cpu state, nothing to do with the 
register.  You might notice that all three registers have different sets of supported 
bits.  If you want to properly validate, you might as well you three different functions.

> +static const ARMCPRegInfo sctlr2_reginfo[] = {
> +    { .name = "SCTLR2_EL1", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 0, .opc2 = 3, .crn = 1, .crm = 0,
> +      .access = PL1_RW, .accessfn = sctlr2_access,
> +      .writefn = sctlr2_write,
> +      .fieldoffset = offsetof(CPUARMState, cp15.sctlr2_el[1]) },

Missing .fgt = FGT_SCTLR_EL1, .nv2_redirect_offset.

> +    { .name = "SCTLR2_EL2", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 4, .opc2 = 3, .crn = 1, .crm = 0,
> +      .access = PL2_RW, .accessfn = sctlr2_access,
> +      .writefn = sctlr2_write,
> +      .fieldoffset = offsetof(CPUARMState, cp15.sctlr2_el[2]) },
> +    { .name = "SCTLR2_EL3", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 6, .opc2 = 3, .crn = 1, .crm = 0,
> +      .access = PL3_RW, .accessfn = sctlr2_access,

No accessfn.


r~

