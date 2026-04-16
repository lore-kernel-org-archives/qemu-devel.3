Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C9DF8E48C
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 22:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDVWd-0002ws-Cr; Thu, 16 Apr 2026 18:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDVWc-0002wi-5i
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 18:49:30 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDVWa-0005xO-HL
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 18:49:29 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ad9516a653so145935ad.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 15:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776379766; x=1776984566; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0Z6R4N4ERWxEmvQadqcvyWhwR3tIcn1DxI6w0HzrxOQ=;
 b=HeqEODwL1WNDbyFx7ZandwdWn/SuJGj1WyezYwR1efPcA5H/4V5UiBsOE3NRK4dNRe
 /DaurHPzAEdKeh+AdYrl28MBLmh053LKl5hGCjU9p1hiQixlkk8nbLrAbj35KWFQ11CF
 fHbRWiFtlcFktfW58B4i9/zjJBtJUSakf7p1DXB4FIhC6cW0+HxeKDZ9hbRUXzMFUTpk
 LlL9t/j1g5pBaGY+nrUQC8sNB/Ae9fQ94GlorQ1aHSU36YpWoJtq/UkLeORYv8j8U1U1
 CGT5wl9keIR98kXkUFfLPoTNs5DCJlSQI4cJiBRTnh3UPDv1nZYP5nvAbol5tu3RxbUt
 vHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776379766; x=1776984566;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Z6R4N4ERWxEmvQadqcvyWhwR3tIcn1DxI6w0HzrxOQ=;
 b=FYCctUUtJXPF1D89dVv7MjJIgQCjfi8kZ5GVbFPxq8f+GOiM8Txya5gE2HPDfJ6s/h
 2765JGqqrd4vO/ZnHn+GlNEyw4xdlwsz630er9lb7yvhssxCsEVpSBllBWeAiRbROdUm
 zKZvQg+JswSmVv2wSEC30u771QFVcsk1d9TUzdwDt95Wbmsl+//NcRgtatLLnCC8vUFC
 j0y9Zrc19dL5b/MWPZu1CUhIwCIzuqWVBzzTB99EB3nC3m2uWsvNKyyiF+FWPFq3x29Q
 wvduxq/da76Wa4U68+50k8hDka1JUnta3d2pObYuXU/fI6QPvqsXLYlK27s9G1tVbqBD
 g4kg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/9gVdqW7d+x75UT22Sda8YaPk/34Z+tC39PWXwLS+W7ys1SmmY/9xVRNaLxthLUs5UfAaiHxwnijF6@nongnu.org
X-Gm-Message-State: AOJu0YwxOsbpaLsmJpZs7W8BY6EWeMAK1xqX9xe/NpT0Nx6+UJ/V4kDz
 3CpsEmy1AP3BpYzMNEABBKe0jazvjvWlUjdAtMleuFH5BTbzJk17Jb+xyrevZRQnzbM=
X-Gm-Gg: AeBDies+pkuikEmTbULHVDHYdc5Leyn7DTD13ve6Stwe6o5IRXhEq5qg41MgNbqnNj6
 BHOp7AfT+1kVy91AWlQgxyJ6HgqBTjV/UhkWhxJmtnc20e2tHC3IErgEthNFCDVfRntbnMFZj1l
 u9dj7kTcyXjWQuiJU7TSzKOroBNMX1H/8R5ISgTKBuA/vmDQXLs4msJA6FqaJ3qr/sEr/S27ioX
 YSQ6h0zUoJJPXYgcSAZCZ2pnC40DAqRqww4neHadvodxX1WFBEe0AWJGHPZZDBhfUtZxsNcPnqE
 yBwDHC6JmImTErOn4XpjWNQXPMAboi2BdasywP1oNOFQiuiuAMygGjqpB11gxAJpAYaCWG6w7Jt
 eYHbalWy2XNfIy3a9+UylFWC98ChCSHrWOhPpPg9NVBk4YjP0ht3rCn4qyCE6ksXDKHLXFCfXIl
 /oAwZMTAOVsxtHcRti70CZPFraajVsNgLV0KP7M7rOlNojY25mSDP8/9zGUv8M+AuxNGQDV0DQb
 stv0emfS0zj+bMd7/bRByDF20XDePzz4qBiUwo+4BX71nvGatDrE+d1Iec9VsO2Vg==
X-Received: by 2002:a17:903:11ce:b0:2b4:5ff5:e51f with SMTP id
 d9443c01a7336-2b5f9f51dfemr3108355ad.36.1776379766475; 
 Thu, 16 Apr 2026 15:49:26 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a60a:7c34:dd75:e66c?
 (bg30dj02y68bx09myf73.ip6.superloop.au.
 [2401:d002:dc0f:2100:a60a:7c34:dd75:e66c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa5b2027sm413765ad.71.2026.04.16.15.49.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 15:49:26 -0700 (PDT)
Message-ID: <73a6d4c3-9108-4172-b1b6-11ee857909fc@linaro.org>
Date: Fri, 17 Apr 2026 08:49:20 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] target/mips: Use probe_access_full() in Atomic
 Load/Store helpers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20260416150649.23671-1-philmd@linaro.org>
 <20260416150649.23671-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260416150649.23671-3-philmd@linaro.org>
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

On 4/17/26 01:06, Philippe Mathieu-Daudé wrote:
> Let the probe_access() API check the address alignment.

The probe_access will not check the alignment.
The use of the memory access before the probe checks the alignment.

> 
> Move env->CP0_LLAddr and env->lladdr assignments so we
> don't update them when an alignment fault occurs.
> 
> Since we have a handy MemOpIdx, replace the legacy
> cpu_ld*_mmuidx_ra() calls by cpu_ld*_mmu() equivalent.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/ldst_helper.c | 21 +++++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
> index b725c6d0333..4ebf72d610e 100644
> --- a/target/mips/tcg/ldst_helper.c
> +++ b/target/mips/tcg/ldst_helper.c
> @@ -28,23 +28,32 @@
>   #include "internal.h"
>   
>   #ifndef CONFIG_USER_ONLY
> +#include "accel/tcg/probe.h"
> +#include "exec/tlb-flags.h"
>   
>   #define HELPER_LD_ATOMIC(name, insn, almask, do_cast)                         \
>   target_ulong helper_##name(CPUMIPSState *env, target_ulong arg,               \
>                              uint32_t memop_idx)                                \
>   {                                                                             \
> -    MemOpIdx oi = memop_idx; \
> -    unsigned mem_idx = get_mmuidx(oi); \
> -    if (arg & almask) {                                                       \
> +    MemOpIdx oi = memop_idx;                                                  \
> +    unsigned mem_idx = get_mmuidx(oi);                                        \
> +    unsigned size = memop_size(get_memop(oi));                                \
> +    uintptr_t ra = GETPC();                                                   \
> +    CPUTLBEntryFull *full;                                                    \
> +    void *host_unused;                                                        \
> +    int flags;                                                                \
> +                                                                              \
> +    env->llval = do_cast cpu_##insn##_mmu(env, arg, oi, ra);                  \

This performs the access, filling the tlb in the process.
If the tlb cannot be filled, access is not permitted an an exception is raised.

> +    flags = probe_access_full(env, arg, size, MMU_DATA_LOAD, mem_idx,         \
> +                              true, &host_unused, &full, ra);                 \

Which means this probe for the tlb entry *must* succeed, because we can't reach here 
unless it was confirmed present by the access above.

> +    if (unlikely(flags & TLB_INVALID_MASK)) {    

Which means this must be

     assert(!(flags & TLB_INVALID_MASK));
                              \
>           if (!(env->hflags & MIPS_HFLAG_DM)) {                                 \
>               env->CP0_BadVAddr = arg;                                          \
>           }                                                                     \
>           do_raise_exception(env, EXCP_AdEL, GETPC());                          \
>       }                                                    

... and the rest of the IF is dead code.


r~

