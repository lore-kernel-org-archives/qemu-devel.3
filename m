Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B69C28B24
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 17:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqEmX-0001Ig-5W; Thu, 06 Mar 2025 12:13:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqEmU-0001GI-B5
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 12:13:10 -0500
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqEmS-0000v7-1Z
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 12:13:09 -0500
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6f77b9e0a34so7991347b3.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 09:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741281184; x=1741885984; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OnGqp95hpVSR2EPuWhYM5ayIMFa2k31Tt3SBgjd5u4M=;
 b=p1yeAJ6SpTnbgOYlYsAEBDAFihn91JL+v+PWzncWzbX1TCeiu0DvGklds6C4ThE/VZ
 sCoY5piMGQCY4rh8vU3R5U1+D1Q2gOuhTPeObvkZ7Qp7eJkcBqaxr++LeGbFJeQLAa0d
 ZtMmARGku77pIyIkcoyMSJWn1T67jYW/2eDO3VuNqSXW3nRsFfi0+bB+XX0YNYywFAZ0
 +sac4MhG7M5HYyClgFlsZJzOwGmolAiFPse2EpkLXV15ozD8goEPJc3z4J8X2zGGN2OT
 OFwmYUagan3qk8OXPATPw/Bgn30gqTt6Iqpz7resDJKy/nxcbHHXqPfjf3wIlu/RG/lx
 hMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741281184; x=1741885984;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OnGqp95hpVSR2EPuWhYM5ayIMFa2k31Tt3SBgjd5u4M=;
 b=qU/scxSorqz25a9qnV9u150fv/IbPQ8DDWGwzPlqzqzVcR7fs1gKWmKEn+NzIPsgzJ
 fJmz4ke5LUPwb1KUp9Ey8y0hTDNsZfX9D4IR4zFEhtIapYc3OxtMZciKmkDrTZkAAVNA
 kDV93E59QRAwOit4NjxUaSIRhBLjcKVs8KOeQ277VQZzPn7W447tl4td6Sjstdtt5MTC
 SuP1GhGpI6UXj9jeXG3WbGqJ43PDKZdCH+2oQVZ51sVNoPAF+IKxDtNA/Ls+w2AiROig
 4OvCOm2pMkXQWj9TGtuI6hZFxWlYRA+FGj6xNhxUqWEPhLDZLjzcjwTkeRn2BNCXJ6e6
 1EdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrcHHSMPWaipAQXYMuhvHbrWDTabc9wUxvI8cdWJoL8LWi6Jq7cKU9FGT8nkvT6NfZnvW9aMhWjVcN@nongnu.org
X-Gm-Message-State: AOJu0YxoUKYkOOWhV12Byd+FFpHjhrh5n+vEOKeonmRoPadqnjY+gxng
 AvbTx8LnZ18WOkrt/QjTw7NF/aliFGy7miRFPfVcWuFnNU/Vo6ykCpSKZCglYCGu9sK57At2rVk
 qaaXwHhLcCP7NkdrrofLkqa/UZl2Zuv1M6b9GjR6Sh5sAhTWa
X-Gm-Gg: ASbGncv4tJPVwnDQoWFlqTQRJErLd8q9ALaajxXRP17gwfCL1RvfCnCrWzhVgzMYDKR
 wDNgSJM2GhhMRzfu3dDJZa1kI9x32kbS1XmWZhoTSwllCuLE0gMCWWI39PtoPXsXGrZi+Vr2o9l
 zXDc4MaqVA/+PzdCqn4UvL9uIaIA0=
X-Google-Smtp-Source: AGHT+IEleANxErlxpeIMw4Du1pwgHSSS2vmrjMsD7j/9s/rFMJVtKylTEEspARPZjHt6+4o7dk+oYReq6ahFEFjqn1Q=
X-Received: by 2002:a05:690c:700d:b0:6f9:82fa:6d96 with SMTP id
 00721157ae682-6febf2d4218mr2683857b3.11.1741281184194; Thu, 06 Mar 2025
 09:13:04 -0800 (PST)
MIME-Version: 1.0
References: <20250306163925.2940297-1-peter.maydell@linaro.org>
 <20250306163925.2940297-8-peter.maydell@linaro.org>
In-Reply-To: <20250306163925.2940297-8-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Mar 2025 17:12:52 +0000
X-Gm-Features: AQ5f1Jrd5h7phx93Vgd8rufGdEURHDGrNxe2BY0DxOM-rWpWFNyJa4ji9Gxei_A
Message-ID: <CAFEAcA8iY1ND+kTxKfuwiQdDus5G24BbTswGK4dzH3nug4QRPA@mail.gmail.com>
Subject: Re: [PATCH 07/10] target/arm: SCR_EL3.RW should be treated as 1 if
 EL2 doesn't support AArch32
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Thu, 6 Mar 2025 at 16:39, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The definition of SCR_EL3.RW says that its effective value is 1 if:
>  - EL2 is implemented and does not support AArch32, and SCR_EL3.NS is 1
>  - the effective value of SCR_EL3.{EEL2,NS} is {1,0} (i.e. we are
>    Secure and Secure EL2 is disabled)
>
> We implement the second of these in arm_el_is_aa64(), but forgot the
> first (because currently all our CPUs with AArch64 support AArch32 at
> all exception levels).
>
> Provide a new function arm_scr_rw_eff() to return the effective
> value of SCR_EL3.RW, and use it in arm_el_is_aa64() and the other
> places that currently look directly at the bit value.
>
> (scr_write() enforces that the RW bit is RAO/WI if neither EL1 nor
> EL2 have AArch32 support, but if EL1 does but EL2 does not then the
> bit must still be writeable.)
>
> This will mean that if code at EL3 attempts to perform an exception
> return to AArch32 EL2 when EL2 is AArch64-only we will correctly
> handle this as an illegal exception return: it will be caught by the
> "return to an EL which is configured for a different register width"
> check in HELPER(exception_return).
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/internals.h | 24 +++++++++++++++++++++---
>  target/arm/helper.c    |  4 ++--
>  2 files changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index b3f732233f4..82a0e1f785f 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -392,6 +392,25 @@ static inline FloatRoundMode arm_rmode_to_sf(ARMFPRounding rmode)
>      return arm_rmode_to_sf_map[rmode];
>  }
>
> +/* Return the effective value of SCR_EL3.RW */
> +static inline bool arm_scr_rw_eff(CPUARMState *env)
> +{
> +    /*
> +     * SCR_EL3.RW has an effective value of 1 if:
> +     *  - we are NS and EL2 is implemented but doesn't support AArch32
> +     *  - we are S and EL2 is enabled (in which case it must be AArch64)
> +     */
> +    ARMCPU *cpu = env_archcpu(env);
> +    bool ns_and_no_aarch32_el2 = arm_feature(env, ARM_FEATURE_EL2) &&
> +        (env->cp15.scr_el3 & SCR_NS) &&
> +        !cpu_isar_feature(aa64_aa32_el1, cpu);

should be "aa64_aa32_el2"...

> +    bool s_and_el2_enabled =
> +        (env->cp15.scr_el3 & (SCR_NS | SCR_EEL2)) == SCR_EEL2;
> +
> +    return ns_and_no_aarch32_el2 || s_and_el2_enabled ||
> +        (env->cp15.scr_el3 & SCR_RW);
> +}
>


-- PMM

