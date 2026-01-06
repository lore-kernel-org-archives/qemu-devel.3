Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E20FCD042A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 01:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcw2f-0002yB-CH; Mon, 05 Jan 2026 20:39:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcw2Z-0002wS-6H
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 20:39:19 -0500
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcw2X-0003PH-9U
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 20:39:18 -0500
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-8b2d7c38352so235936585a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 17:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767663556; x=1768268356; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ug2sH7XEPHxKeX9YiZItlFjKWujIjaN1UMm65t2RKnc=;
 b=mT7zOXiMUH2N7DDYgGHhkyPltI7tWyxza0v5yjearjfzsuMEUuwDH1AsgVyMxsoblO
 tN0Kik1zDDFdxjtAQfTGPHo2eSOU1NZekLnafHgnqz9Ye0buKKh7R5/txgHG4cA9pHG3
 IBdsx4J3XLYywXFxnYvL5RDD3abve0gR4r0eEjntIxcO8lhXCGxYpCe6OkmMRnz2VAJV
 bwFdW5QaNRjOt0BbCL/UzgKbM0n/jztkDX9iy1P+XoBV8SJ5jknmncVmYAUMp+ORjKy0
 MPtqWO/JDENeEinf+Eo+xjeyCP0ttKsagmeaFYplfSa0VJDkXGxB/wHJ2ZuVE5iZxKCE
 y0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767663556; x=1768268356;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ug2sH7XEPHxKeX9YiZItlFjKWujIjaN1UMm65t2RKnc=;
 b=YxGWJBf33DvAOmhQIXjQO7RpZJiU7As4CGav6A7eYtXMRyIPoMyqtc7dDoef8C+HSJ
 71U8V4L19/skKsUy3n/40s4PSYT8wTpkxfIWllF8Rn9bU2BZJgu32NGb9ZwuNV467sHj
 Hybc7HJd1kdLrlRHb5Y05IUyNdzCkT4MYUjLqayV1Q2TdiVsD2qhwLmncl9ibG1Ej1kb
 n9imZZpv52DyyY1KCmzW6ACWCxGAUx3XOZihRMJtmfi3JhaTnbYmZN1bRKcZjVEBlVMe
 hHV6pBBNz+yC9NJpt4FApjS5BUPjMwvSV929a6By2P6nYwmowLCczTiW1QurjmPCHJBw
 KYdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRpO6MmT/Xc5s/OSJZY9KSF57kXHzbM77gpD7pFZeJBDX3uj0pFb6Fo3uMVyk6GilJ4956xR+VIo8Y@nongnu.org
X-Gm-Message-State: AOJu0Yxe8VMCIYiisydrQq89HvL7NVfAAHYaP11vvdOG3/r737wTe/8W
 BAPEARirZRcV21AFhcP2MKvH+iAw2C8hjtFeanDdzTdY3Kk+tn7/FpC1zBJwFhdC7fk=
X-Gm-Gg: AY/fxX60LHXf1p5QJHIBwMq0qYoRQ2e/s4FdXvvr/cVnnfTlerjtdGJeo1PK2wuFu4I
 AjlKzlwOtm73VuDM1tF+5Tr/CWMIBvtIypLKNJX+qjdpelOwbISe1SEOawQgN34zuUFYuinoUue
 uXfX1Tom/NaZ9AIQf6h7uJ9bSdDDl1zwTPqrHVzJ05WeRb4Y/2i0B1EAbAsZfxGtqbwVj3EK1ui
 2IEQ5l7OBZ2SxouaF6GqurQtfImsCNqvUe5ZotRoLke5N9h4M8V5EwKbqI4nKaog5LOg7jDB8T7
 47H3IAvJbDTkK+n44ehTcvcR4D9jwjkUIY1oo9M/QtjceCKPVMyAlg8b7mtvRcmqicwDZxRi75d
 IfY2G7HP7jtvwAHQa2s+KoCCf5GiWSwL9cT5tAcrTi1SqpX9NJH5pHmptTyqIJa7asNVlIqbdlj
 x1z5YBwTiHJr9xkomcgh8bH0UDsqvwygHf2X0axPQjxUnVs31eadE2xXZ0aKLt/8ytCDWb21b4m
 Z9G5obz
X-Google-Smtp-Source: AGHT+IHZfdZBPPaWxaIxt7cwRyvurfMD+9lgoVdWZcxDQFY1TCf31FAZn1VxqqbTpRQSjdswbiYBAA==
X-Received: by 2002:a05:620a:2548:b0:8bb:6a17:cd62 with SMTP id
 af79cd13be357-8c37f4d72b7mr174119785a.15.1767663556024; 
 Mon, 05 Jan 2026 17:39:16 -0800 (PST)
Received: from [10.212.166.227] ([172.59.187.201])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89077253305sm4994996d6.41.2026.01.05.17.39.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jan 2026 17:39:15 -0800 (PST)
Message-ID: <2a8b62ca-efdd-4b40-b3e2-41c446c72479@linaro.org>
Date: Tue, 6 Jan 2026 12:39:04 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 08/12] target/arm: storing to canonical tags faults
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
References: <20260105-feat-mte4-v3-0-86a0d99ef2e4@gmail.com>
 <20260105-feat-mte4-v3-8-86a0d99ef2e4@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260105-feat-mte4-v3-8-86a0d99ef2e4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x734.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/6/26 05:14, Gabriel Brookman wrote:
> According to ARM ARM, section "Memory region tagging types", tag-store
> instructions targeting canonically tagged regions cause a stage 1
> permission fault.
> 
> Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
> ---
>   target/arm/tcg/mte_helper.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
> 
> diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
> index 795a5ad20b..8f06ed3162 100644
> --- a/target/arm/tcg/mte_helper.c
> +++ b/target/arm/tcg/mte_helper.c
> @@ -227,6 +227,20 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
>   #endif
>   }
>   
> +static void canonical_tag_write_fail(CPUARMState *env,
> +                                uint64_t dirty_ptr, uintptr_t ra)
> +{
> +    uint64_t syn;
> +
> +    env->exception.vaddress = dirty_ptr;
> +
> +    syn = syn_data_abort_no_iss(arm_current_el(env) != 0, 0, 0, 0, 0, 1, 0);
> +    syn |= BIT_ULL(42); /* TnD is bit 42 */
> +
> +    raise_exception_ra(env, EXCP_DATA_ABORT, syn, exception_target_el(env), ra);
> +    g_assert_not_reached();
> +}
> +
>   static uint8_t *allocation_tag_mem(CPUARMState *env, int ptr_mmu_idx,
>                                      uint64_t ptr, MMUAccessType ptr_access,
>                                      int ptr_size, MMUAccessType tag_access,
> @@ -363,6 +377,11 @@ static inline void do_stg(CPUARMState *env, uint64_t ptr, uint64_t xt,
>       int mmu_idx = arm_env_mmu_index(env);
>       uint8_t *mem;
>   
> +    if (mtx_check(env, 1 & (ptr >> 55))) {
> +        canonical_tag_write_fail(env, ptr, ra);
> +        return;
> +    }
> +
>       check_tag_aligned(env, ptr, ra);

These are mis-placed, as the alignment check has priority, as does pte_attrs == 0xf0.
Compare S1DecodeMemAttrs vs allocation_tag_mem_probe.


r~

