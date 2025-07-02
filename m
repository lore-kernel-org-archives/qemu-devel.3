Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6012C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 14:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWyd5-0007Qz-0U; Wed, 02 Jul 2025 10:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWyd1-0007ON-Lt
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:40:03 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWycz-0005hP-LJ
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:40:03 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-72c14138668so2176663a34.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 07:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751467198; x=1752071998; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UygajXREWh/6Qif0N8ANsLkmI2+id1aySwIN1k/UCMM=;
 b=CF/QfaUkUA2nyA4iGDQKMDFtQYGmRXLwceCeYU0QlfGjG7U8RFvR33f0Kqi3VGMO0w
 A3UWbDEMrY1siK9d6dKTLeOdt2ssMREKz6RChwnZkMGQAn7VWRkBS75EIyhvSQXVXljU
 ZmUucWSr/cMjpNqEqFEjroZZHB1vrSzzAi5P357xw8fJq7UlH9MSOjwH+Y0xaPwsu7MV
 dbFNl+B1mmbt2R0bJWWJs++zmR577ezJcD1ffQI6aZv4tQ9feST/N6Ml20HJZAtu/Xb2
 hYSSfC1oe7297QHn0/RE6uEDmzDwUF6x7F+kr+zu7u9dR4LLIr0uWJVWCcwRhXQqFJIr
 wJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751467198; x=1752071998;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UygajXREWh/6Qif0N8ANsLkmI2+id1aySwIN1k/UCMM=;
 b=u9zJ4cnKnlcgQAiXeG58jdVj11VkwA00Kdi6cVUM7NO2nH5nl3CLZ+N5o4H2ynxP5r
 o3Dy/d89GGklTC3SCpft/YqU/T0+WbD0QFPqSZQDGC2/ek8/Xr8W0m7q7IqypDAiHhMZ
 EMumySa6hwI5MDzlH0tjb9vh0F8z/v0pCLr8FGfJyEj/3QmAv5c+FgUy4576QFY6yOCJ
 g7aiqJvO886Zrq/nHN4mEq0JJ/Id7FbaH1b7E6htPR+Yu2TBKiYXVlcl4YgL/wxsYyBt
 GzycBaYkKK963/HMykHhW1CI1tdbdAYMaMQvw8yaON0u8y2nV9SjmXwvxQwgBEYtByFR
 lYzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk/FVqB+hDm9jwmhqKeDA+vRunlSx0jVHNL1/2QfpKoYbN5qchdQSQRpMVuv14QUOCMGvvRthlZVZG@nongnu.org
X-Gm-Message-State: AOJu0Yy+c85xIagQM62P+FWu9Ea2SdVAr6B2oimdQ+Zvjv2V4Z+9JFUX
 SbepKciqkUD6NJ762BS1KdPW1j8mbJamjN7ZAly2chwKoWaY3exs6E0GmHl4Jp/G2FI=
X-Gm-Gg: ASbGncsGnRH4+0sjhPp2H1N94JftFlUWB1COQvkBoJwflPGTyl87UkevzF8bSE2/HQK
 uJXcdmtiHuYjqpaykGFyqyyGU6hftmn0nGiCIkZ9aKzpLfeLg0dCsqkDpbwFeka3G8CrH/FyeGu
 Rmh0CnjRVjtf8kT3sQgizFllJ3EuMzX6MnioP4tI/PG4bYLd7+BYdCy1QINjuPDF87Lf6i4q8/4
 Ru7zbSM0S+VDKFU1Ru59MLpksTGSGIbr/rVrWtFLFcleYdSlcaVb8Onc1MxGfWnybYUBe28kvyA
 xQUIdnPhxUdPsUOwvOouMrhoinEtfZx9u8uMtxN4xf/2E6Eaueo7GVrEUuD2J80IKd1LKlykWzl
 Q
X-Google-Smtp-Source: AGHT+IEcgD1luY6Sa9zXTMB9jrp2h3rjMnbC2aD/ifMq8Xo9sXpl1YDEAqpX3Qp1TaYyOhpYbdeLhw==
X-Received: by 2002:a05:6830:8008:b0:727:36a0:a2ae with SMTP id
 46e09a7af769-73b4d07aacemr2019556a34.14.1751467197901; 
 Wed, 02 Jul 2025 07:39:57 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb103f97sm2535157a34.53.2025.07.02.07.39.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 07:39:57 -0700 (PDT)
Message-ID: <909f6432-19da-4ccf-954c-bff423bde864@linaro.org>
Date: Wed, 2 Jul 2025 08:39:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/12] target/arm: Fix VLDR helper load alignment checks
To: William Kosasih <kosasihwilliam4@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250702111954.128563-1-kosasihwilliam4@gmail.com>
 <20250702111954.128563-5-kosasihwilliam4@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250702111954.128563-5-kosasihwilliam4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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

On 7/2/25 05:19, William Kosasih wrote:
> This patch adds alignment checks in the load operations in the VLDR
> instruction.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
> Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
> ---
>   target/arm/tcg/mve_helper.c | 24 +++++++++++++-----------
>   1 file changed, 13 insertions(+), 11 deletions(-)

Much better, thanks.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
> index 506d1c3475..1db626bb26 100644
> --- a/target/arm/tcg/mve_helper.c
> +++ b/target/arm/tcg/mve_helper.c
> @@ -148,13 +148,15 @@ static void mve_advance_vpt(CPUARMState *env)
>   }
>   
>   /* For loads, predicated lanes are zeroed instead of keeping their old values */
> -#define DO_VLDR(OP, MSIZE, LDTYPE, ESIZE, TYPE)                         \
> +#define DO_VLDR(OP, MFLAG, MSIZE, MTYPE, LDTYPE, ESIZE, TYPE)           \
>       void HELPER(mve_##OP)(CPUARMState *env, void *vd, uint32_t addr)    \
>       {                                                                   \
>           TYPE *d = vd;                                                   \
>           uint16_t mask = mve_element_mask(env);                          \
>           uint16_t eci_mask = mve_eci_mask(env);                          \
>           unsigned b, e;                                                  \
> +        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
> +        MemOpIdx oi = make_memop_idx(MFLAG | MO_ALIGN, mmu_idx);        \
>           /*                                                              \
>            * R_SXTM allows the dest reg to become UNKNOWN for abandoned   \
>            * beats so we don't care if we update part of the dest and     \
> @@ -163,7 +165,7 @@ static void mve_advance_vpt(CPUARMState *env)
>           for (b = 0, e = 0; b < 16; b += ESIZE, e++) {                   \
>               if (eci_mask & (1 << b)) {                                  \
>                   d[H##ESIZE(e)] = (mask & (1 << b)) ?                    \
> -                    cpu_##LDTYPE##_data_ra(env, addr, GETPC()) : 0;     \
> +                    (MTYPE)cpu_##LDTYPE##_mmu(env, addr, oi, GETPC()) : 0;\
>               }                                                           \
>               addr += MSIZE;                                              \
>           }                                                               \
> @@ -185,20 +187,20 @@ static void mve_advance_vpt(CPUARMState *env)
>           mve_advance_vpt(env);                                           \
>       }
>   
> -DO_VLDR(vldrb, 1, ldub, 1, uint8_t)
> -DO_VLDR(vldrh, 2, lduw, 2, uint16_t)
> -DO_VLDR(vldrw, 4, ldl, 4, uint32_t)
> +DO_VLDR(vldrb, MO_UB, 1, uint8_t, ldb, 1, uint8_t)
> +DO_VLDR(vldrh, MO_TEUW, 2, uint16_t, ldw, 2, uint16_t)
> +DO_VLDR(vldrw, MO_TEUL, 4, uint32_t, ldl, 4, uint32_t)
>   
>   DO_VSTR(vstrb, 1, stb, 1, uint8_t)
>   DO_VSTR(vstrh, 2, stw, 2, uint16_t)
>   DO_VSTR(vstrw, 4, stl, 4, uint32_t)
>   
> -DO_VLDR(vldrb_sh, 1, ldsb, 2, int16_t)
> -DO_VLDR(vldrb_sw, 1, ldsb, 4, int32_t)
> -DO_VLDR(vldrb_uh, 1, ldub, 2, uint16_t)
> -DO_VLDR(vldrb_uw, 1, ldub, 4, uint32_t)
> -DO_VLDR(vldrh_sw, 2, ldsw, 4, int32_t)
> -DO_VLDR(vldrh_uw, 2, lduw, 4, uint32_t)
> +DO_VLDR(vldrb_sh, MO_UB, 1, int8_t, ldb, 2, int16_t)
> +DO_VLDR(vldrb_sw, MO_UB, 1, int8_t, ldb, 4, int32_t)
> +DO_VLDR(vldrb_uh, MO_UB, 1, uint8_t, ldb, 2, uint16_t)
> +DO_VLDR(vldrb_uw, MO_UB, 1, uint8_t, ldb, 4, uint32_t)
> +DO_VLDR(vldrh_sw, MO_TEUW, 2, int16_t, ldw, 4, int32_t)
> +DO_VLDR(vldrh_uw, MO_TEUW, 2, uint16_t, ldw, 4, uint32_t)
>   
>   DO_VSTR(vstrb_h, 1, stb, 2, int16_t)
>   DO_VSTR(vstrb_w, 1, stb, 4, int32_t)


