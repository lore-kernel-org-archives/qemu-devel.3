Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7B9C35FF1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 20:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tspe4-00028o-0f; Thu, 13 Mar 2025 16:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspde-0001gX-6u
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:58:49 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspda-00060E-HD
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:58:44 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-301302a328bso3006937a91.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 13:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741899521; x=1742504321; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jkwl8cB0M5AvsMlumN/jwh7dF1WLuuewWvrHbVg1mIE=;
 b=TKST3wrwtW0m1Jo1wSQeheJt9JS+hJ9g2LQQnDfWXyIf29Icaxzs6FfeAHruuSo62M
 E+7rRsGR4uK0M+lRqny3spAsy9qo8OyYpf3fHO2NlnDl1/j3fiUVP7q4ZdoCjlE7554V
 KzTVTUrZbOCs53N8bdZi6Y5Vjlz0hzqqewwKWNvtD96qM0/t7F4ymF+zXhXjzSEG+a73
 Ah73f4Wk8NOkjZbatz5VK4OlebLQH3ZADNBG5azP5roUypVnKmgE0+YPquSm0P7WmU6j
 j2N5Gj9HI9hBoAMdJzgoeQjpwEHzOnV0nTNz3C+2ca48sNXXBrDlbil4kCLW01wx11Gm
 8/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741899521; x=1742504321;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jkwl8cB0M5AvsMlumN/jwh7dF1WLuuewWvrHbVg1mIE=;
 b=j7KRBt0hkfxO08rzI3JNbKRXBSGwkuOSlwds1q9lz2VyjpuMZon7hm13URSsxz+1pR
 WiUSM0fwfUH7ES8yfdHgl+eXkCnx1FcrfNqFu4SNEP7Qbpkvv8n8abHFnfz2uQimwHee
 TXa914GfQsGAbx38d/7vH9Qoq8Yq0fGOVaVejpTuPJ5XHLiZeXqFG45k9s5CuMtevzCc
 isnontJT5glQwXLMdiSINh0y4iJ4Mo0rn9t6jbrP6BrhnmYpIFNlZj7aSsWB/5svLkcC
 Y5H6oYel0PzsxOciOspnaTISD3uSR8/Vm1iLNbKvHaDFJjxa6sQaU94Yvan4fCM3ZYF0
 qelQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWoxeYE3i5O/k8wKZkER/+wJ5AB6yXkvzXjnVtLEPDabvg24MSKv6/ipvcqiNDugkez0Fe2p5TSu2y@nongnu.org
X-Gm-Message-State: AOJu0YybETZed+xkhCChuDJnzw4wSNqY5gmbJ+2JlwpV7JGMyWIx+jEw
 Momfyy3idPVoQQ9ZY/PcpFCgkesFi4GIUzgMV/HepIXvPukE3FXu4Tg5N7DqEdQ=
X-Gm-Gg: ASbGncsb8Xh5xrhDrZf5Cy/7rOx1Xx1DEPDwpsH4zvLJrX+e6QVSSLXzq4bGsRFLU2U
 lK62iXGh3RQ2oPXQDhKyT2dmN4Pfc4dN1RsthDNUDaYDYe87Ph4VFmNswc3tU+2SdYU8FmceatB
 P99knuLe1LeaTxBhQmYrQs8+T/korhX8gggfS2qFp4NnCKaRhyh8PmxDAKzi+ZKrhXlo7HgTGeB
 mMZ19shL1u8Cb9mC2vidTjA2KM/A5x+ADhK/ecZGKCIpnMoDStTVqUW8mEiNzCQskBAMA+tbewV
 nK521i1x1se7r9kpVqBhUMufYpJip+LrEsVk40QXvN5DLChcJR8wopXVv/uJuGkjeS/k
X-Google-Smtp-Source: AGHT+IGK+EOCMIfFxbcEmUyrIoO1qE+O7YBJj7h6cUeE7QFMCL7oDtAtbvV/czZ4Rqvw9wA8rawFQA==
X-Received: by 2002:a17:90b:5403:b0:2ee:fa0c:cebc with SMTP id
 98e67ed59e1d1-3014e861c18mr1117930a91.20.1741899521096; 
 Thu, 13 Mar 2025 13:58:41 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30138b476a1sm1846683a91.17.2025.03.13.13.58.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 13:58:40 -0700 (PDT)
Message-ID: <4184b67c-d069-471d-be39-b47d17a02a1b@linaro.org>
Date: Thu, 13 Mar 2025 13:58:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/37] include/exec: Drop ifndef CONFIG_USER_ONLY from
 cpu-common.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-31-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-31-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
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

On 3/12/25 20:45, Richard Henderson wrote:
> We were hiding a number of declarations from user-only,
> although it hurts nothing to allow them.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-common.h | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index be032e1a49..9b83fd7ac8 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -9,9 +9,7 @@
>   #define CPU_COMMON_H
>   
>   #include "exec/vaddr.h"
> -#ifndef CONFIG_USER_ONLY
>   #include "exec/hwaddr.h"
> -#endif
>   #include "hw/core/cpu.h"
>   #include "tcg/debug-assert.h"
>   #include "exec/page-protection.h"
> @@ -40,8 +38,6 @@ int cpu_get_free_index(void);
>   void tcg_iommu_init_notifier_list(CPUState *cpu);
>   void tcg_iommu_free_notifier_list(CPUState *cpu);
>   
> -#if !defined(CONFIG_USER_ONLY)
> -
>   enum device_endian {
>       DEVICE_NATIVE_ENDIAN,
>       DEVICE_BIG_ENDIAN,
> @@ -176,8 +172,6 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length);
>   int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
>                                           size_t length);
>   
> -#endif
> -
>   /* Returns: 0 on success, -1 on error */
>   int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
>                           void *ptr, size_t len, bool is_write);

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


