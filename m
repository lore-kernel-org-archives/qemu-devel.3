Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E4CCFC504
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd88-0005pr-Hs; Fri, 21 Nov 2025 21:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMcs2-0006pA-2K
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:57:03 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMcqQ-00078Z-CK
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:56:59 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-644fcafdce9so4052135a12.1
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 17:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763776500; x=1764381300; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8wnLnzkfTxGkB5nMfGcr42ZPTyrdMDCae7DvzUu+59I=;
 b=YyLYYazPxfOZAzhso0sE4ajB/DNe+34axkxDXR65cIsCW1cjOOYGS0uRHXlfFgdWkE
 qOrTGC9s1YKsBFEuWDFrbW4j3fRaPIZTYk+ydYOPeu5t7QLzCv10GrejF+x62sbr6ori
 x68jBXbbo9StdmJlLQrmYmYrD9CWcdnTQn1SpROk8eyrluONuQ2iACxrKDKKMMj77oWm
 sdV7PITOQsO6zTSwm6VdJfSO0bwnJquPf97fAPCC0aRra0qS5srEiHvVes0U1y3NC9jB
 UR3SNbHM9tcDs0lDc7DGvnPf+DpLhQdWDZDufOJqA+ZRT/8g1OYxQVdKMElfQbSgJjlX
 zUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763776500; x=1764381300;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8wnLnzkfTxGkB5nMfGcr42ZPTyrdMDCae7DvzUu+59I=;
 b=FEYZvSsZu3tDD34ON9orFBcMXYYpMnWfL3Pb/kovPbQ9FqeoQQLAxvaTi2KHG4y/2f
 bzMXPaAe/1dDxmexX8ugr+WAGYdeNirbziKCxQRZYjmiNpRR3/S2Afg1SqQt2ZsVtyKx
 TN9jgWZCPnlTC4sg9cPJIGyPGn4IfqbeDYDjZo36KZLwmOuUBLxdzlPoPrEzbtsi/cLP
 gV0PhDXCB04W/RmrUasoTPLpKgZ8HhdnKeeCq8dqGnvVTQRsga2ExoslPLhzkst9+Cel
 Bgo6SAWg4seshFzKxt3wojwJsMSjcIu9mxNd17UnbRGcX7KdIZfjDwyAh+46TGTvV7xA
 Vp0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlbA5st+wWR8zWUlNZYq8Wc1qjtqtSsQH9I6TpgArp7VMZ7++QK/O366vdksfFLtrOSE9NToXkmPXG@nongnu.org
X-Gm-Message-State: AOJu0YyDiicsZPCO0ESlUXZ4+JO1JWgteVP7Soy4fqgMIeFGmpiQ4J44
 DmMHGWuy8BoD2538xxALHecY4pRroZ4lT4E2vb5GW90x2lisY2rlfZYSZDrhkMYVJrQIZk06qej
 fYhINsPj46g==
X-Gm-Gg: ASbGncudQ6E0cpPtmed/zK7gjm74xkD2TIfh804iyrdZsRkcKLdrPvOnTvKNO17P+Aq
 L1o2cVG4e0m++q2PzvZs+Q7PFaEuKTRY+6iFp11Czd+kRvKoKQI69yXy8yRa+FZ7KhMM7jP/A94
 pDagfdpB3cQakeMoX/oIu5ni6hs8v1cpJMxv5LYleuwoTnX3YrltnVPKhNCi0aACdZsDJrOOmiv
 Q+PUVrAmKEO8jbGT5f1oYGn74Gv/qqCoQ01wWDOwz5Stj+klP/A/lhVtuhmJtyOfpXXWYtNdX7M
 8Tu5U8sGXg1GWrwDyjWROT3+0QKIBC/XLbPNa1dV55lDuMhXPTvrYPoveDlnqgvyxx/SQX21Jh7
 GGTJ8SUj3uuMBLyLFYQO+uLQpcjEz7AS8QdWJOI4xYN1NMMO2chhnvTYr5pOBkOxj0qWpsGyBVq
 BqhIRIFsOnHFMFr8WHPFoVerjcUS0/Yf0AQCaJTYBIacQZQvb4qe+zOw==
X-Google-Smtp-Source: AGHT+IEvAyGK/GgqiFHWPFXhBRSCSYyV5bnV+bp4jB5vxrKf8lIRZtJvyUJO+iivXXMq3TjPC5fXDg==
X-Received: by 2002:a05:6000:2f85:b0:42b:32c3:3949 with SMTP id
 ffacd0b85a97d-42cc1d27ad3mr2317439f8f.31.1763732001195; 
 Fri, 21 Nov 2025 05:33:21 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb9022sm10942917f8f.36.2025.11.21.05.33.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Nov 2025 05:33:20 -0800 (PST)
Message-ID: <803dd0a8-8b78-4e47-9c28-46af413c6967@linaro.org>
Date: Fri, 21 Nov 2025 14:33:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/ppc: Use probe_access for LSW, STSW
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>
Cc: hsp.cat7@gmail.com, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au,
 Chinmay Rath <rathc@linux.ibm.com>
References: <20200129235040.24022-1-richard.henderson@linaro.org>
 <20200129235040.24022-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20200129235040.24022-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Hi,

(old patch merged as commit bb99b391896f3c7a477777e3d47a2524fd795357)

On 30/1/20 00:50, Richard Henderson wrote:
> Use a minimum number of mmu lookups for the contiguous bytes
> that are accessed.  If the lookup succeeds, we can finish the
> operation with host addresses only.
> 
> Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/ppc/mem_helper.c | 148 ++++++++++++++++++++++++++++++++++------
>   1 file changed, 128 insertions(+), 20 deletions(-)
> 
> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
> index e8e2a8ac2a..508d472a2f 100644
> --- a/target/ppc/mem_helper.c
> +++ b/target/ppc/mem_helper.c
> @@ -56,6 +56,32 @@ static inline target_ulong addr_add(CPUPPCState *env, target_ulong addr,
>       }
>   }
>   
> +static void *probe_contiguous(CPUPPCState *env, target_ulong addr, uint32_t nb,
> +                              MMUAccessType access_type, int mmu_idx,
> +                              uintptr_t raddr)
> +{
> +    void *host1, *host2;
> +    uint32_t nb_pg1, nb_pg2;
> +
> +    nb_pg1 = -(addr | TARGET_PAGE_MASK);
> +    if (likely(nb <= nb_pg1)) {
> +        /* The entire operation is on a single page.  */
> +        return probe_access(env, addr, nb, access_type, mmu_idx, raddr);
> +    }
> +
> +    /* The operation spans two pages.  */
> +    nb_pg2 = nb - nb_pg1;
> +    host1 = probe_access(env, addr, nb_pg1, access_type, mmu_idx, raddr);
> +    addr = addr_add(env, addr, nb_pg1);
> +    host2 = probe_access(env, addr, nb_pg2, access_type, mmu_idx, raddr);
> +
> +    /* If the two host pages are contiguous, optimize.  */
> +    if (host2 == host1 + nb_pg1) {
> +        return host1;
> +    }
> +    return NULL;
> +}
> +
>   void helper_lmw(CPUPPCState *env, target_ulong addr, uint32_t reg)
>   {
>       for (; reg < 32; reg++) {
> @@ -84,23 +110,65 @@ void helper_stmw(CPUPPCState *env, target_ulong addr, uint32_t reg)
>   static void do_lsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
>                      uint32_t reg, uintptr_t raddr)
>   {
> -    int sh;
> +    int mmu_idx;
> +    void *host;
> +    uint32_t val;
>   
> -    for (; nb > 3; nb -= 4) {
> -        env->gpr[reg] = cpu_ldl_data_ra(env, addr, raddr);

This target-endian call ...

> -        reg = (reg + 1) % 32;
> -        addr = addr_add(env, addr, 4);
> +    if (unlikely(nb == 0)) {
> +        return;
>       }
> -    if (unlikely(nb > 0)) {
> -        env->gpr[reg] = 0;
> -        for (sh = 24; nb > 0; nb--, sh -= 8) {
> -            env->gpr[reg] |= cpu_ldub_data_ra(env, addr, raddr) << sh;
> -            addr = addr_add(env, addr, 1);
> +
> +    mmu_idx = cpu_mmu_index(env, false);
> +    host = probe_contiguous(env, addr, nb, MMU_DATA_LOAD, mmu_idx, raddr);
> +
> +    if (likely(host)) {
> +        /* Fast path -- the entire operation is in RAM at host.  */
> +        for (; nb > 3; nb -= 4) {
> +            env->gpr[reg] = (uint32_t)ldl_be_p(host);

... is replaced by a big-endian one here ...

> +            reg = (reg + 1) % 32;
> +            host += 4;
> +        }
> +        switch (nb) {
> +        default:
> +            return;
> +        case 1:
> +            val = ldub_p(host) << 24;
> +            break;
> +        case 2:
> +            val = lduw_be_p(host) << 16;
> +            break;
> +        case 3:
> +            val = (lduw_be_p(host) << 16) | (ldub_p(host + 2) << 8);
> +            break;
> +        }
> +    } else {
> +        /* Slow path -- at least some of the operation requires i/o.  */
> +        for (; nb > 3; nb -= 4) {
> +            env->gpr[reg] = cpu_ldl_mmuidx_ra(env, addr, mmu_idx, raddr);
> +            reg = (reg + 1) % 32;
> +            addr = addr_add(env, addr, 4);
> +        }
> +        switch (nb) {
> +        default:
> +            return;
> +        case 1:
> +            val = cpu_ldub_mmuidx_ra(env, addr, mmu_idx, raddr) << 24;
> +            break;
> +        case 2:
> +            val = cpu_lduw_mmuidx_ra(env, addr, mmu_idx, raddr) << 16;

... while still using target-endianness here, why?

> +            break;
> +        case 3:
> +            val = cpu_lduw_mmuidx_ra(env, addr, mmu_idx, raddr) << 16;
> +            addr = addr_add(env, addr, 2);
> +            val |= cpu_ldub_mmuidx_ra(env, addr, mmu_idx, raddr) << 8;
> +            break;
>           }
>       }
> +    env->gpr[reg] = val;
>   }
>   
> -void helper_lsw(CPUPPCState *env, target_ulong addr, uint32_t nb, uint32_t reg)
> +void helper_lsw(CPUPPCState *env, target_ulong addr,
> +                uint32_t nb, uint32_t reg)
>   {
>       do_lsw(env, addr, nb, reg, GETPC());
>   }
> @@ -130,17 +198,57 @@ void helper_lswx(CPUPPCState *env, target_ulong addr, uint32_t reg,
>   void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
>                    uint32_t reg)
>   {
> -    int sh;
> +    uintptr_t raddr = GETPC();
> +    int mmu_idx;
> +    void *host;
> +    uint32_t val;
>   
> -    for (; nb > 3; nb -= 4) {
> -        cpu_stl_data_ra(env, addr, env->gpr[reg], GETPC());
> -        reg = (reg + 1) % 32;
> -        addr = addr_add(env, addr, 4);
> +    if (unlikely(nb == 0)) {
> +        return;
>       }
> -    if (unlikely(nb > 0)) {
> -        for (sh = 24; nb > 0; nb--, sh -= 8) {
> -            cpu_stb_data_ra(env, addr, (env->gpr[reg] >> sh) & 0xFF, GETPC());
> -            addr = addr_add(env, addr, 1);
> +
> +    mmu_idx = cpu_mmu_index(env, false);
> +    host = probe_contiguous(env, addr, nb, MMU_DATA_STORE, mmu_idx, raddr);
> +
> +    if (likely(host)) {
> +        /* Fast path -- the entire operation is in RAM at host.  */
> +        for (; nb > 3; nb -= 4) {
> +            stl_be_p(host, env->gpr[reg]);
> +            reg = (reg + 1) % 32;
> +            host += 4;
> +        }
> +        val = env->gpr[reg];
> +        switch (nb) {
> +        case 1:
> +            stb_p(host, val >> 24);
> +            break;
> +        case 2:
> +            stw_be_p(host, val >> 16);
> +            break;
> +        case 3:
> +            stw_be_p(host, val >> 16);
> +            stb_p(host + 2, val >> 8);

(ditto)

> +            break;
> +        }
> +    } else {
> +        for (; nb > 3; nb -= 4) {
> +            cpu_stl_mmuidx_ra(env, addr, env->gpr[reg], mmu_idx, raddr);
> +            reg = (reg + 1) % 32;
> +            addr = addr_add(env, addr, 4);
> +        }
> +        val = env->gpr[reg];
> +        switch (nb) {
> +        case 1:
> +            cpu_stb_mmuidx_ra(env, addr, val >> 24, mmu_idx, raddr);
> +            break;
> +        case 2:
> +            cpu_stw_mmuidx_ra(env, addr, val >> 16, mmu_idx, raddr);
> +            break;
> +        case 3:
> +            cpu_stw_mmuidx_ra(env, addr, val >> 16, mmu_idx, raddr);
> +            addr = addr_add(env, addr, 2);
> +            cpu_stb_mmuidx_ra(env, addr, val >> 8, mmu_idx, raddr);
> +            break;
>           }
>       }
>   }


