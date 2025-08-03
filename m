Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF54C87FD2
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 00:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiMn7-00058b-JM; Sat, 02 Aug 2025 20:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiMn6-00057C-4Z
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 20:41:32 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiMn4-00062U-9C
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 20:41:31 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-741a0ec1a05so329497a34.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 17:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754181688; x=1754786488; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IVMN0ySAkT9ive74mGUsu5V1Wc/xKzRvPh90eXFJpgc=;
 b=AYPKsXdHU2s59fbf1a1HCgQoEqTcpLvitTPxlASqMVe7zo1UM7pgcwyD/kiYfk0WmP
 g6Coyqc1L0L84uo7cH8cHvwTBZ2kP2A3npjbiQnLpdeqfnRU+KAKI1Guh4EW5xMkF6fH
 WUHct5xVzZVzdk1wpQbXyuyHMxqcl4rr5Ua+qvmG6hGPbo/9dRZDgI22re2ts3Evk/Cy
 5CHWP02KAO2LHygBw5/JBAobR1oufAHW96L2N8SqFeFPFXx8QwEMeRJ7l3Srv0dDSp6t
 Dc85JamUrYU6NP/MGqSDRgO5hk9ORqYh1xWHAo4zML4GNy7JP1tru6JjIt1lKSnby+eN
 WZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754181688; x=1754786488;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IVMN0ySAkT9ive74mGUsu5V1Wc/xKzRvPh90eXFJpgc=;
 b=nts4CPsKjnURyHJqi/hPvSmpNVUnHDk2S6ivgyuH/5MOZwjnQCf9ybEBg1oKlbl8ij
 1+BjHn859NpyUbOMBB56V3eThCXhZJD0oyGBRulNAxTZ3T4/z6U7pY2994ftYiHNaXTb
 g9P55WbkuRLx7DZ6gYqIS2quSgtcEekYEepf9kJCitWjh4QHI+PyhjR1ymE5pedFB/hx
 9JRfBZNvfK2PqcR2leWZQXXM5XCuRwZeiMGbAttMm0lF6jWFQazmlhKsIh0yZC4DB62F
 I/c43OVho4601N2yw0pTFLpujH+S/SjmnPekn7m7iLt+pa28DkRwXsYmtwzq+Y1aDQYF
 ZNcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVCOMA2X7dlXHLMRcGnsP8W5TgjEiIvPwtuD0I8W2MIx/XDsfQszl2Bb3c/+5HTm44FcQmYoeTffJV@nongnu.org
X-Gm-Message-State: AOJu0YwNl4a8djjWbdlZsVvxGhQPRrLus/Trlf1aCpT0xXODfzaUMty6
 fFhct6ahnZlUwOZdjM79BmOcecvrxifs08mNUDxwtwuXM/ubRnzzKb+kNGp08o15KmrHBU2Jr5S
 5EIbkvL4=
X-Gm-Gg: ASbGncuAkMJvKIeT0A4rdqnyI8GOFIs7BSjMCXcf+QaM0VPpUTpFSH2qpbYoZVUGz89
 p9R5j/afAy79nOHrnxXMWOSZrrg1bElK8l8J3XmHEQydh2UgMmrxhVo5bqQttPQw+m2BGz9U5i9
 Bz5tV94ZiTSn9oY4Fb0TqCD+mJwXTMx+5n6voZvAeZdTFfkxsfLMjiTeRMoh+Icf0gK7NiC9dnP
 ZX2Tk+7cdFLSUlWpkSe2oFqjLrsJUslKYN8Oi0tU/e6E1YM0CI6H3IOS6KTddfFBXeq/5StljHz
 qdfDIl50cxPEEdajYCQX9aiZG7MNvBd1w36rgaAq9mnQxzlNh0MiKCG1GztxS77vvcIEupTAy9T
 ahSSCkz3u2DCX0ZvTXLw4e4houXI+iZdBXAl36n/8y8+TjpYTjrHn4ytrL8aQRnIv
X-Google-Smtp-Source: AGHT+IHrSB2gmMY0KXw7r1T0O7N7WCMj6WdJoCKLaDlAs7MvWnIJnwGJxdfcwRdZ3O1mjxGaqxy5aQ==
X-Received: by 2002:a05:6830:4120:b0:727:3957:8522 with SMTP id
 46e09a7af769-7419d2c6bb9mr2546667a34.20.1754181688300; 
 Sat, 02 Aug 2025 17:41:28 -0700 (PDT)
Received: from [10.153.194.227] ([172.58.111.133])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-74186ca9602sm1521648a34.8.2025.08.02.17.41.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Aug 2025 17:41:27 -0700 (PDT)
Message-ID: <712da351-3bf6-4a31-92e6-b198d5dc21ff@linaro.org>
Date: Sun, 3 Aug 2025 10:41:20 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/14] whpx: ifdef out some x86-only code paths
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
References: <20250802081800.76030-1-mohamed@unpredictable.fr>
 <20250802081800.76030-5-mohamed@unpredictable.fr>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250802081800.76030-5-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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
> winhvemulation is x86_64 only.
> Exception exit bitmaps are also x86_64 only
> Others are just variable definitions not used on arm64.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   accel/whpx/whpx-common.c       | 20 ++++++++++++++++++--
>   include/system/whpx-all.h      |  2 ++
>   include/system/whpx-common.h   |  2 ++
>   include/system/whpx-internal.h |  7 ++++++-
>   4 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
> index b5e5fda696..eeefaea329 100644
> --- a/accel/whpx/whpx-common.c
> +++ b/accel/whpx/whpx-common.c
> @@ -41,7 +41,9 @@
>   bool whpx_allowed;
>   static bool whp_dispatch_initialized;
>   static HMODULE hWinHvPlatform;
> +#ifdef __x86_64__
>   static HMODULE hWinHvEmulation;
> +#endif
>   
>   struct whpx_state whpx_global;
>   struct WHPDispatch whp_dispatch;
> @@ -106,11 +108,16 @@ int whpx_first_vcpu_starting(CPUState *cpu)
>                * whpx_translate_cpu_breakpoints(). WHPX breakpoints must
>                * now be recomputed.
>                */
> +#ifdef __x86_64__
>               whpx_translate_cpu_breakpoints(&whpx->breakpoints, cpu, i);
> +#endif
>           }
> +#ifdef __x86_64__
>           /* Actually insert the breakpoints into the memory. */
>           whpx_apply_breakpoints(whpx->breakpoints.breakpoints, cpu, true);
> +#endif
>       }

These are still static in target/i386/whpx/whpx-all.c, so the split in the previous patch 
didn't work.  You probably want arm to *have* these functions, even if they're empty.

> +#ifdef __x86_64__
>       HRESULT hr;
>       uint64_t exception_mask;
>       if (whpx->step_pending ||
> @@ -132,6 +139,7 @@ int whpx_first_vcpu_starting(CPUState *cpu)
>                        "hr=%08lx.", hr);
>           return 1;
>       }
> +#endif

I'm not quite sure what this is doing, but it probably needs to be split out to a new 
function which can be specialized between architectures.

> @@ -238,8 +246,10 @@ void whpx_destroy_vcpu(CPUState *cpu)
>       struct whpx_state *whpx = &whpx_global;
>   
>       whp_dispatch.WHvDeleteVirtualProcessor(whpx->partition, cpu->cpu_index);
> +#ifdef __x86_64__
>       AccelCPUState *vcpu = cpu->accel;
>       whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
> +#endif

Does the os function exist on arm?  The answer to that determines whether we must split 
this out to an architecture function or if we can do

     if (vcpu->emulator) {
         destroy
     }

> @@ -414,8 +424,12 @@ static bool load_whp_dispatch_fns(HMODULE *handle,
>           LIST_WINHVPLATFORM_FUNCTIONS(WHP_LOAD_FIELD)
>           break;
>       case WINHV_EMULATION_FNS_DEFAULT:
> +#ifdef __x86_64__
>           WHP_LOAD_LIB(WINHV_EMULATION_DLL, hLib)
>           LIST_WINHVEMULATION_FUNCTIONS(WHP_LOAD_FIELD)
> +#else
> +        abort();
> +#endif

Use g_assert_not_reached not abort.

That said, it might be cleaner to split this into two functions, rather than select pieces 
of the function via an enumerator.  At which point I could see the entire set of emulation 
code staying in target/i386/.


r~

