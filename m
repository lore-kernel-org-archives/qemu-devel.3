Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78A6CF2598
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 07:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLcvR-000720-V1; Wed, 19 Nov 2025 02:48:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLcvO-00071K-8p
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 02:48:22 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLcvL-00030z-BY
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 02:48:21 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-477b1cc8fb4so1899465e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 23:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763538497; x=1764143297; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dc3fw7l8Q3MOjjyPrAjJy3J1HK2uS6osBsWTcoWyKOA=;
 b=UOFd3OxM8ZelO6n9VR7AL07JgijgX8xI4kOCpqnPcv+FIj4znWsRhP0G8/cT9AKf+j
 xYxJXKdvfvjqQISe+2q6GOlJTO3fgTXSQOkVQUD9WrhkLu24L1pOaIOR5pXBDDF5nDMX
 2raPQSiiUPW3fFBnSmmQVMf+3iW3tFeF6R3TsPPqgNTK7g3+wcxLxOvJIbbP/9+pykEh
 evT4EzQ871uNSd/LOnCGsjLlI17bQx2EJtjGj49BBFqZyEm3ngER0/LQBviK8rHbzDkU
 EVqxOzRIbpamIC8mML9K6DUJu3x010oRKH1o+lR6vh2LtNE5FyWR3gwb938yPRctEuPF
 Zwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763538497; x=1764143297;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dc3fw7l8Q3MOjjyPrAjJy3J1HK2uS6osBsWTcoWyKOA=;
 b=w6+EjKPE2/9w9+7EI95ZfWrqFgy6ccg+wTaukwuCtBNyAgfNu7mMbRlTmvltrAJXT9
 MlC6aQ1q2uIx1My39BBYoPjZoXLVMDUS57d7KoFhe/00qYJ4DdzSTrNUzBUYQ49FU4bj
 /MvIBkIWH+8tMPEksFIjI+nnS/5ckTK9CTmWSQ2wazfaJz/zWmnD5r5Nx2EYznukoyYT
 tblF2vOmv+sbWHn4k2c+99aDJfTq4M1Q9EUPXFgVASS0xb5/vYwNHjK5M+Wn2Bp8tQ6i
 qzXJcEULrGS56T8gvSv4u9Qha072vSuwS0BQZEngIMLuPUkX5WBeVkfMWOTCHFsDu1+s
 AUzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAFLgKzv3C6JbtiI5x0/IDHET0bdudxSC0HC28mjTVlOX/9cOqnmSbaAFVjS4znTQOeHLaWztq99ON@nongnu.org
X-Gm-Message-State: AOJu0Ywp2mI4OCNfdizNlhoyeD0UfyXnZbRtUQoRTDa+VCM41kzoI/Nv
 vQv+BTbgsRhWw3uh7jQSU8ANZDG7irBIb316+YZqlPHO5NNQtb8I2fASUq+eeqpqdBc=
X-Gm-Gg: ASbGncup2FiFL9ITVgmnEbPgRgMLghJWor6vsfccZW10KUIhm2yQKD80Y99OBLlFUWz
 S4fEoMO1Bt/ms8xZZp8LiO3dwZeyfAz9nIrlR2tlkgx7CWZ9zBOCwJM2o3o56e2+MU/DwAUSlU6
 26Zf5NPRWBDTLw8r3AbBA4WTBPTskWYoYVpJgl4ocD9HSNRbpwpMlfQOiaGDbLwf08F3bP71A1m
 wMyCseDuTEx8lJPS8c1NUUDRc3pKdxzZcO4atgSyqAsIrATPYFelbWSTJe9F44La4YSlLWp/6aa
 NdLcKoBClu+ZK+GJ1ldrJHDs1AzhKaZ5XOWBvBOQqKTrSsPXRE6/68Usu7ud5t5PjxcQeNmIGox
 iHXZpyMUcf6Rkr4Lq1yIN3DLolY5ty/h+PNlnjGEd2e/jDoIaKPyJyb/WQnLBgC8uauM+oEjHVA
 nNa53jBnfWeWUwIwTbaiiDbCl6NqcAe1rSEUJXeuwJQCwkIvO4QqWGtYUlTRVOziQ8ikk=
X-Google-Smtp-Source: AGHT+IHzz+QMue0cy/N4ly7F24guDGtJuVu7Yy6kIanR0QecLPcmQvtinQv3RSzDCxKdiOC8xTAbRA==
X-Received: by 2002:a05:600c:8b42:b0:477:942:7521 with SMTP id
 5b1f17b1804b1-4778fe683e1mr162260945e9.14.1763538497524; 
 Tue, 18 Nov 2025 23:48:17 -0800 (PST)
Received: from ?IPV6:2a01:e0a:ed5:b1f0:90e8:1fdb:2cba:9db1?
 ([2a01:e0a:ed5:b1f0:90e8:1fdb:2cba:9db1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b102a3a1sm32315295e9.9.2025.11.18.23.48.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 23:48:17 -0800 (PST)
Message-ID: <f3ba257b-44c4-4365-8735-30642518ca3b@linaro.org>
Date: Wed, 19 Nov 2025 08:48:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 08/10] target/arm: storing to canonical tags faults
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org
References: <20251116-feat-mte4-v2-0-9a7122b7fa76@gmail.com>
 <20251116-feat-mte4-v2-8-9a7122b7fa76@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251116-feat-mte4-v2-8-9a7122b7fa76@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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

On 11/17/25 02:40, Gabriel Brookman wrote:
> According to ARM ARM, section "Memory region tagging types", tag-store
> instructions targeting canonically tagged regions cause a stage 1
> permission fault.
> 
> Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
> ---
>   target/arm/tcg/mte_helper.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 47 insertions(+)
> 
> diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
> index ddb68e11fc..9eb3777fe2 100644
> --- a/target/arm/tcg/mte_helper.c
> +++ b/target/arm/tcg/mte_helper.c
> @@ -196,6 +196,23 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
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
> +    /* bit 42 is TnD */
> +    syn = (1l << 42) | syn_data_abort_no_iss(arm_current_el(env) != 0,
> +            0, 0, 0, 0, 1, 0b1110);
> +    raise_exception_ra(env, EXCP_DATA_ABORT, syn, exception_target_el(env), ra);
> +    g_assert_not_reached();
> +
> +}
> +
> +
> +

"l" is wrong.

Better as

     syn = syn_data_abort_no_iss(...);
     syn |= BIT_ULL(42);

Watch the myriad newlines.


r~

