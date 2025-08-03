Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D4FC87FD3
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 00:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiN2x-0002pV-3A; Sat, 02 Aug 2025 20:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiN1U-0001IY-BE
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 20:56:24 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiN1S-0007bt-O1
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 20:56:24 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-741a0ec1a05so332938a34.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 17:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754182577; x=1754787377; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+rftqA7ajs+3ugf3FnPyUpQuYjsHuBmsgaCTrDuvIPM=;
 b=clXecrzqxmrivV99XaP25Ovs9Tw4m5qXBDUyXCdPt2Em8qxy20KgFpDVMK7kh4lBrn
 8jnxwSZDiy+iUxmPKuDU4JdDdRUvBRn9+XrdA4+Af6cZOx2FUXrVIos8lhxuLh0dVKwH
 q1ptLQK7vfpG1Oawzdcg689wtYulH2kJO4NyI9ZZmUBN49KnGyjdjFlTCKgouWGlOlAG
 wYCDOohcHLn7sH/IwsmWSt2EPis8TQ103uqWqAVVlZbaK197HKV+JsnBvpUfWKLeaXO8
 S478omLOsIdxaGNjRa5p1DvxSZiFGVhyrYp43TbnKa3h/ou2L5v10E44ZWFRv0eWFPkk
 tmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754182577; x=1754787377;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+rftqA7ajs+3ugf3FnPyUpQuYjsHuBmsgaCTrDuvIPM=;
 b=l9Xn6NJ7TVAdLo5a8KogE09ew1jHHZ1UrKSSIrGcfYNXrcJm/zm8Xck9gRTmVSO8yU
 cBlP36+8cYg6eqYVVYSYnKKEIZ865TLdjX898JajEJsxaqaMtBp7LFvrBuTNGTex5rPG
 psvLiVf658DzojeriIVjUen7Ws/wyzduRQO+DYUP/iACpfyiNvDqw3OdnCz/uvXr9C5y
 MT0DxuZ77I8hq+8mEEwMXN2BOyhEsnqBKsSDOLO2cVD1af/MVa0PIzWbVJEHTRHgsOyV
 iz6I0qU3ApG5tqI/WhMxKfFFv0mbmLClvm7Z3Ynmx6Op1ioy7mgl+XjeGxqkiEwX2PP8
 Sm3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuU90IxZ2qzEp/uY1EqokqB8rPB0YB68gwtzCp+VZPmJiWlifVXrux3I7zSy1YxeUMt6qk9EnJ3WW0@nongnu.org
X-Gm-Message-State: AOJu0Yzn7ZwoWSH3Lvpt83LCEMJph7uNGjmLtIKj9nsC5kK48ZhNuVde
 nWZMNnKoviDk5O3WsuFkBqBaFhWH9BJS35U+T3RZI2GmDv6eG2jExfIEBglyywpsNE/WKeWO+Vu
 ULaFB/RA=
X-Gm-Gg: ASbGncu9VqGLoEur2i44FNB/RSksUOVLlWcL9ksdoprIsRXPxbIHmEPC5rjciMFDB6j
 vvU93UxPG2ZBNHNmhytl33oriU+xkUR25Hn6pOGgqrB5BukJLVJM25Om4LXhUaVITiSmK4DgqUi
 suG9eW+fUxYoB3qMaLNp4PRpoNcRSTadKyYAF94+8wdVJbQs18erISg2IIlnGT7bOyV86PIJaLH
 Kg/nDrf6d2cvYSJSImhbMu7ga5qDqzZhcSQCO4dWv7O1Vj9LOzwAvQfE9SXdxaJeNUrsu1LBvgP
 o0VZRtA0JCxFCOTKk+/abGY+uwlsVWd8ZQKvySU8/7QzW2Xhs5pGZxS87NwSLDU8lIsS/pmnTF1
 oDp+++6tTeYkgb+J1slOJaHid7cY/r7XpCyeYoeTFgoiuEF4RCaQavrAGLRd7Xb5i
X-Google-Smtp-Source: AGHT+IE8fq4kVP2Z39puGtMFndXDXEkytUwBFIbMKs4GGe48Dgej8KUuIbgSne3SUD90hEmDRMJ5Yw==
X-Received: by 2002:a05:6870:1b0f:b0:2ff:b00f:a544 with SMTP id
 586e51a60fabf-30b67562674mr2716317fac.3.1754182576908; 
 Sat, 02 Aug 2025 17:56:16 -0700 (PDT)
Received: from [10.153.194.227] ([172.58.111.133])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-307a7411a42sm1806009fac.28.2025.08.02.17.56.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Aug 2025 17:56:16 -0700 (PDT)
Message-ID: <b5e787c2-347d-4009-80c4-8ec29c497ddb@linaro.org>
Date: Sun, 3 Aug 2025 10:56:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/14] whpx: add arm64 support
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
References: <20250802081800.76030-1-mohamed@unpredictable.fr>
 <20250802081800.76030-8-mohamed@unpredictable.fr>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250802081800.76030-8-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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

On 8/2/25 18:17, Mohamed Mediouni wrote:
> +struct whpx_sreg_match {
> +    WHV_REGISTER_NAME reg;
> +    uint32_t key;
> +    bool global;
> +    uint32_t cp_idx;
> +};
> +
> +static struct whpx_sreg_match whpx_sreg_match[] = {

const.

> +#ifdef SYNC_NO_RAW_REGS
> +    /*
> +     * The registers below are manually synced on init because they are
> +     * marked as NO_RAW. We still list them to make number space sync easier.
> +     */
> +    { WHvArm64RegisterMidrEl1, WHPX_SYSREG(0, 0, 3, 0, 0) },
> +    { WHvArm64RegisterMpidrEl1, WHPX_SYSREG(0, 0, 3, 0, 5) },
> +    { WHvArm64RegisterIdPfr0El1, WHPX_SYSREG(0, 4, 3, 0, 0) },
> +#endif
> +    { WHvArm64RegisterIdAa64Pfr1El1, WHPX_SYSREG(0, 4, 3, 0, 1), true },
> +    { WHvArm64RegisterIdAa64Dfr0El1, WHPX_SYSREG(0, 5, 3, 0, 0), true },
> +    { WHvArm64RegisterIdAa64Dfr1El1, WHPX_SYSREG(0, 5, 3, 0, 1), true },
> +    { WHvArm64RegisterIdAa64Isar0El1, WHPX_SYSREG(0, 6, 3, 0, 0), true },
> +    { WHvArm64RegisterIdAa64Isar1El1, WHPX_SYSREG(0, 6, 3, 0, 1), true },
> +#ifdef SYNC_NO_MMFR0
> +    /* We keep the hardware MMFR0 around. HW limits are there anyway */
> +    { WHvArm64RegisterIdAa64Mmfr0El1, WHPX_SYSREG(0, 7, 3, 0, 0) },
> +#endif
> +    { WHvArm64RegisterIdAa64Mmfr1El1, WHPX_SYSREG(0, 7, 3, 0, 1), true },
> +    { WHvArm64RegisterIdAa64Mmfr2El1, WHPX_SYSREG(0, 7, 3, 0, 2), true },
> +    { WHvArm64RegisterIdAa64Mmfr3El1, WHPX_SYSREG(0, 7, 3, 0, 3), true },

All of these are id registers.  I can understand reading them once at startup, to populate 
-cpu host, but they need not be synced otherwise.

> +static uint64_t whpx_get_gp_reg(CPUState *cpu, int rt)
> +{
> +    if (rt >= 31) {
> +        return 0;
> +    }

assert?  Or return 0 for 31 and assert <= 32?

> +    WHV_REGISTER_NAME reg = WHvArm64RegisterX0 + rt;
> +    WHV_REGISTER_VALUE val;
> +    whpx_get_reg(cpu, reg, &val);
> +
> +    return val.Reg64;
> +}
> +
> +static void whpx_set_gp_reg(CPUState *cpu, int rt, uint64_t val)
> +{
> +    if (rt >= 31) {
> +        abort();
> +    }

assert.  Or ignore write to 31 and assert <= 32?

> +    if (cm) {
> +        /* We don't cache MMIO regions */
> +        abort();
> +        return 0;
> +    }

assert.


r~

