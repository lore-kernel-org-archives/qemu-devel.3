Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A21ED277C9
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Jan 2026 02:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vePAL-0008NF-Ne; Fri, 09 Jan 2026 21:57:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vePAJ-0008Jy-Qf
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 21:57:23 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vePAI-0001R3-81
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 21:57:23 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-34c27d14559so2816562a91.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 18:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768013840; x=1768618640; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6wxSBX++JDw/2z7MchHt2bUcUCXN25mdkMzMnDoTZn0=;
 b=fGYi7w0efyuxgN65rW/tbD5BdPqS2kr4dTBjcvIYgsLJfHciuipJ2+EI0drmJjX8nV
 Oq94kFc8mMhWb9TsvgfeU+l8aG/EHZB1rh5lVaDbxnumXr9+NS2XlNkXrcHTprBP3mde
 eGoVShdILhDuCru1UooSUEQiI9YQCOBM7aiLb4Z0JGxsotGdy54ooJP81FjdAFRUldfL
 9ZTcCCWH9SWbYg38nOCSu2CsdTNnM3GwArnqUhCdkXGPMnRmrzC21BNDbfGpnQOOib9i
 yCLYcWYsNyZ0KOrmvaGFV97eENK18xNKalhCMwrqpTgdx88A9XP8I9Mc9V6WEKWeK1Ld
 iLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768013840; x=1768618640;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6wxSBX++JDw/2z7MchHt2bUcUCXN25mdkMzMnDoTZn0=;
 b=bUt1XaA8nsGR9oQ6QOytSqx2QpCueB9xS/8inPVsWVlEfzIKhlp7OSLU0S+2nYbULW
 pL6Vc/SqybcGTBaqb0WCYMHa5b3bhcr3iesfXEnAnfBa0VGqW1vBURK9mshvq+0IK4ps
 IRUQrHR6mROPL9rxfenbHfKlzF/8YZTG3Y65EhEk4C5YBab90eJ+idD+FaEJXMyiywxF
 3lzayguClCITKbhKGAIbLwpr+ZtKzvAohToElXS/a5OlpGLyEeBKKaspWuqpKpgFULFc
 4vcpVm5DFtAX4DkcZcWCQ2H/x+ASqyaZwarEmGQOiY9Gj83DYC6+O89we9LVY3tFThPe
 h50g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnBMqK6WyVdMDSbG+CPcZ9dCcbHCs8m/8k2WY7SSHDbaPVqMtC0HaYfCNs+4aHpau7FTDPf6N+ndk+@nongnu.org
X-Gm-Message-State: AOJu0YxcC8BSzutB/o9g2FnemXMvtTYLzbkiiXFyYu4iszznlSrLZpWh
 9K4CZpIvalL9NaJgDlpCkycE8Q/r5UdfjwakE9TicoJXfqV4FzjqgI1gTR7D5gDjpuo=
X-Gm-Gg: AY/fxX61w+67FVnrthExK4vvXs1zJVaN9JK8Jja1NLtzl5zvAi8DTWBsBPm0Wa5Fclf
 kRoi+FV6go5JAelyAuyBsNhTyn0CQH4H0Th6T0CSNlfODKtDjEOJzxN9nGFvUq/sMlMvCkSIHWq
 wNcQHQrLC++nQQ061vlnYR4oHo7/9gb7NmfDN6ImrpsWkK7XEkLsfXhlt58VUuJJuF0gfohbpZc
 8/TsqlXGNsLW5mUKDZBED5pEgRUfZtAY/8cnZMkW5pO1PwnHS81Jwy5Q+M4/u1Dk8KGiv25dAK/
 PiSoXct1IbeTtlBFI2/RTBvyCEg+QVGPOIEpUe20PhuPAtOAoj9EGRfyGV3xX+S2VrdqgbkxpM6
 P8wU6EnVvwpBkh4qnATYPaQwMun/rXL+dFnI93lNAXj4z0DEq2gxS8Ipm2BmX1RtVYsOIMew+wW
 wWIakDfR38vrEWqDGhj/tNBHzWX+pVgGgjMSPJ
X-Google-Smtp-Source: AGHT+IEUOtrWUPQ5mDmdsd+Hq+Uk8XWKMsHIfVQqTim3yXhSpJcqCB9y2kI2U97mCKtx8Nx4ZllZRg==
X-Received: by 2002:a17:90b:5830:b0:340:ec8f:82d8 with SMTP id
 98e67ed59e1d1-34f68b6816bmr12494604a91.12.1768013840184; 
 Fri, 09 Jan 2026 18:57:20 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819c59e8010sm11786583b3a.52.2026.01.09.18.57.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 18:57:19 -0800 (PST)
Message-ID: <bfdd6d82-e252-45c0-8eff-a93430691dbb@linaro.org>
Date: Sat, 10 Jan 2026 13:57:12 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/18] fpu/softfloat: Add OCP(Open Compute Project) OFP8
 data type
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260108151650.16329-1-max.chou@sifive.com>
 <20260108151650.16329-3-max.chou@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260108151650.16329-3-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 1/9/26 02:16, Max Chou wrote:
> +bool float8_e4m3_is_quiet_nan(float8_e4m3 a_, float_status *status)
> +{
> +    return float8_e4m3_is_any_nan(a_);
> +}
> +
> +bool float8_e5m2_is_quiet_nan(float8_e5m2 a_, float_status *status)
> +{
> +    if (no_signaling_nans(status) || status->ocp_fp8e5m2_no_signal_nan) {

What is this new thing?

> +        return float8_e5m2_is_any_nan(a_);
> +    } else {
> +        uint8_t a = float8_e5m2_val(a_);
> +        if (snan_bit_is_one(status)) {
> +            return (((a >> 1) & 0x3F) == 0x3E) && (a & 0x1);
> +        } else {
> +            return ((a >> 1) & 0x3F) == 0x3F;
> +        }
> +    }
> +}
...
> +bool float8_e4m3_is_signaling_nan(float8_e4m3 a_, float_status *status)
> +{
> +    if (no_signaling_nans(status)) {
> +        return false;
> +    } else {
> +        if (snan_bit_is_one(status)) {
> +            return float8_e4m3_is_any_nan(a_);
> +        } else {
> +            return false;
> +        }
> +    }
> +}
> +
> +bool float8_e5m2_is_signaling_nan(float8_e5m2 a_, float_status *status)
> +{
> +    if (no_signaling_nans(status)) {

... which is not also reflected here?

> +        return false;
> +    } else {
> +        uint8_t a = float8_e5m2_val(a_);
> +        if (snan_bit_is_one(status)) {
> +            return ((a >> 1) & 0x3F) == 0x3F;
> +        } else {
> +            return (((a >> 1) & 0x3F) == 0x3E && (a & 0x1));
> +        }
> +    }
> +}

(0) We really should clean up this code so that there's not so much duplication.
FOO_is_quiet_nan and FOO_is_signaling_nan really should share code.
That would have caught the above.

(1) RISC-V always uses default nan mode, the OCP spec declines to define SNaN vs QNaN, 
leaving the 8 unique NaN encodings unspecified, and RISC-V does not do so either.  You 
assert later:

+     * RISC-V uses only quiet NaNs in its OCP FP8 implementation.

Is this out-of-band discussion with engineers?
Because it's missing from the (remarkably short) document.

(2) Arm does specify (see FP8Unpack in the ARM pseudocode), doing the usual thing in 
taking the msb of the mantissa for SNaN.  Which means that E4M3 is *always* SNaN.

Both architectures then immediately convert to FP16 default nan, however Arm *does* raise 
invalid operand exception for the SNaN, so we can't just ignore it.

Given that there's exactly one RISC-V instruction for which this matters, 
vfwcvtbf16.f.f.v, it seems like it might be better to simply adjust 
float_status.no_signaling_nans within the helper rather than introduce 
ocp_fp8e5m2_no_signal_nan.

> +    /*
> +     * When true, OCP FP8 formats use the same canonical NaN representation
> +     * (0x7F) for all NaN outputs. RISC-V specifies a single canonical NaN
> +     * for both E4M3 and E5M2.
> +     */
> +    bool ocp_fp8_same_canonical_nan;

Similarly you could adjust the canonical nan around the 4 FP16->FP8 conversion insn helpers:

     /* Default NaN value: sign bit clear, all frac bits set */
     set_float_default_nan_pattern(0b01111111, &env->fp_status);

In either case, "bool" doesn't seem appropriate.

FWIW, Arm retains the msb set pattern as for all other fp formats (FP8DefaultNaN).


r~

