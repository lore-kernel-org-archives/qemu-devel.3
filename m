Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D55C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbje3-0006u9-M9; Sat, 25 Jan 2025 12:08:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbje1-0006tf-TL
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:08:30 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbje0-0001io-5C
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:08:29 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2166651f752so57393715ad.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737824906; x=1738429706; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PIKYkX99Wy5iJJ1FPJI5WnBZ2X967k3hhgIrClL25Wg=;
 b=ws08gjVdHIYhsQ3fOe4HmtzxJMeYIz09UEPVzgTsNYA5ZKSGB+Kml11YyD/Ftv8670
 Tci1Y9e7rztkVkrBE2htpPNlTMLwcjseWPtIOKyS44qqSSn/woHhZukIIa7+6tpEYqXS
 kGBA7PZUCbGRoerYIALG6atkmwaERdCkdIYEz7K6G12SINfZl8UMQ7XapiayJfXBVDGo
 IiaGr6z/ddxwCE7RCcvIb1Wq2sDN6Hv43R1+DQ49pXQxaAPlVBtnkm8cksYCrXTAifwO
 Aat997At0cxTCINC/mBq14Z0WEVDBmaWVXdIGXb4LxtHBcuRL7lER1MrMJWg6n/9Qj6M
 vlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737824906; x=1738429706;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PIKYkX99Wy5iJJ1FPJI5WnBZ2X967k3hhgIrClL25Wg=;
 b=je0rUItaCwftlWFXdcvIHkg9WbS6f4Wn8XwbioQWJDHWcxLnrElylGbsqP60wQIUvd
 zLMNxvxjzU9XnwxkduSyzjR5cGl8QpxIGcfpYwCXAexcJQy6/enzwIplFV1wIYxQsjua
 fMLltA9OS0VaLOwG8+3riThR89PVXSzj23A9/CWKMByO96trshuIaJ8sqA9VmlwG5tXL
 kAxvebUnAe1vQY85eLQ5VfqtA3FOBDrX3nuYgiiauOE+fNyCVJZAnYlBSVhNZxNVnRCq
 oezl5mvhKFMXrtKpKNkv2sV+oeHO8f4mQA5wkzbK4fWIbihIR9VycmJ20Ov+9zTYBZVX
 Q/0g==
X-Gm-Message-State: AOJu0YzmtFBAZuXAxA4n7OliUOEK0Ee87vx/VGnaEst1Dae+P1YKU+hE
 UoT/Paix1bcZhayrj9k7lIT9TqXG2gL8R5bkJbjcRs1MVqgqZPIjDr49RYY4aCdYYb6mhKHJ2WO
 4
X-Gm-Gg: ASbGnct/9VAByrHUBqr+gy2EoRMeYzBDwVyAJR3o8vq1GBXQvK/F165hKCj+kHYtUdB
 o9uYmWyY5K3v7+QCUntuwLlJ+uynfclWGT5pDcQPNY0TsGTYK29+qGhTyREQTEutqLu546sw8qY
 jiXksjMuqvUy8oHkxlz/a9SejFnPh5igz2HVel7dSrDAVvFd8rXREsipKYKON3I/JtNo/qDeJei
 3HbunwEnHT+aorriS7GD9KGSOFemeUGvDcglnheBf+YT4ydA8YT3+WJV6akiQZ7bPDR/2y/1Pjh
 4DTx7q0q6LF+7dZ2Y4TBBg==
X-Google-Smtp-Source: AGHT+IEwK5qY95Ai4u6dAUSq2VTZ60EIoUggQTh7WPZRncw2vg5fW2yDRw+axvXxjaoAzE1/CI7+xg==
X-Received: by 2002:a05:6a00:21c3:b0:72a:bcc2:7748 with SMTP id
 d2e1a72fcca58-72daf8515f4mr51221606b3a.0.1737824906409; 
 Sat, 25 Jan 2025 09:08:26 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a6b2cf6sm3910221b3a.49.2025.01.25.09.08.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 09:08:26 -0800 (PST)
Message-ID: <49f1651f-89f6-41ba-92cd-dac25b3eba14@linaro.org>
Date: Sat, 25 Jan 2025 09:08:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/76] target/arm: Define FPCR AH, FIZ, NEP bits
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-28-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-28-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/25 08:27, Peter Maydell wrote:
> The Armv8.7 FEAT_AFP feature defines three new control bits in
> the FPCR:
>   * FPCR.AH: "alternate floating point mode"; this changes floating
>     point behaviour in a variety of ways, including:
>      - the sign of a default NaN is 1, not 0
>      - if FPCR.FZ is also 1, denormals detected after rounding
>        with an unbounded exponent has been applied are flushed to zero
>      - FPCR.FZ does not cause denormalized inputs to be flushed to zero
>      - miscellaneous other corner-case behaviour changes
>   * FPCR.FIZ: flush denormalized numbers to zero on input for
>     most instructions
>   * FPCR.NEP: makes scalar SIMD operations merge the result with
>     higher vector elements in one of the source registers, instead
>     of zeroing the higher elements of the destination
> 
> This commit defines the new bits in the FPCR, and allows them to be
> read or written when FEAT_AFP is implemented.  Actual behaviour
> changes will be implemented in subsequent commits.
> 
> Note that these are the first FPCR bits which don't appear in the
> AArch32 FPSCR view of the register, and which share bit positions
> with FPSR bits.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpu-features.h |  5 +++++
>   target/arm/cpu.h          |  3 +++
>   target/arm/vfp_helper.c   | 11 ++++++++---
>   3 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index 30302d6c5b4..7bf24c506b3 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -802,6 +802,11 @@ static inline bool isar_feature_aa64_hcx(const ARMISARegisters *id)
>       return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, HCX) != 0;
>   }
>   
> +static inline bool isar_feature_aa64_afp(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, AFP) != 0;
> +}
> +
>   static inline bool isar_feature_aa64_tidcp1(const ARMISARegisters *id)
>   {
>       return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, TIDCP1) != 0;
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 2213c277348..7ba227ac4c5 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1713,6 +1713,9 @@ void vfp_set_fpscr(CPUARMState *env, uint32_t val);
>    */
>   
>   /* FPCR bits */
> +#define FPCR_FIZ    (1 << 0)    /* Flush Inputs to Zero (FEAT_AFP) */
> +#define FPCR_AH     (1 << 1)    /* Alternate Handling (FEAT_AFP) */
> +#define FPCR_NEP    (1 << 2)    /* SIMD scalar ops preserve elts (FEAT_AFP) */
>   #define FPCR_IOE    (1 << 8)    /* Invalid Operation exception trap enable */
>   #define FPCR_DZE    (1 << 9)    /* Divide by Zero exception trap enable */
>   #define FPCR_OFE    (1 << 10)   /* Overflow exception trap enable */
> diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
> index 3c8f3e65887..8c79ab4fc8a 100644
> --- a/target/arm/vfp_helper.c
> +++ b/target/arm/vfp_helper.c
> @@ -242,6 +242,9 @@ static void vfp_set_fpcr_masked(CPUARMState *env, uint32_t val, uint32_t mask)
>       if (!cpu_isar_feature(any_fp16, cpu)) {
>           val &= ~FPCR_FZ16;
>       }
> +    if (!cpu_isar_feature(aa64_afp, cpu)) {
> +        val &= ~(FPCR_FIZ | FPCR_AH | FPCR_NEP);
> +    }

I suppose this aa64 check, without is_a64(), is ok because the a32 caller has already 
applied FPSCR_FPCR_MASK.  And similarly for the ebf16 check below.

>   
>       if (!cpu_isar_feature(aa64_ebf16, cpu)) {
>           val &= ~FPCR_EBF;

But it does feel like we could usefully move these to vfp_set_fpcr, or such?


r~

