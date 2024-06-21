Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E68C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 06:37:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKXtD-0007mX-9F; Fri, 21 Jun 2024 02:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKXtC-0007mK-1v
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 02:36:50 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKXtA-0008Bf-1o
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 02:36:49 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a6f85f82ffeso193919166b.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 23:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718951806; x=1719556606; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P7NsGwqjm/7EDad7tIWfUEkw3hUdKkMiiR0U4Q2Hkhc=;
 b=A74yjuBrImEn0vcLH7EPBxMUPTuBDBHTOhO29uRKPooy6qzsioNIS/8EzJ5+afoJYj
 JYqFQunS9sLboAsGlg3BgHszIMiyRWx4cuAgmEubi1zc8Y9CS7ABxiFBf3VOj7ucBGPF
 iOpFIOjCybsP0y+rL0haoPDj35P4Mu6RJrl27z7mf7oWl0gN4/zb9Yy450KbSSyMCtCw
 fFN8xuv/pBI6HGy5fQX2s/H0/zq7xhPmA37jziuLXv8CUXM1Bcwf6x80for5fFWIHJMr
 HZwCd0/fAnLoBCWQUiTG235bg13iIU7xvWuFSLxkSIKi10vWTH6p/EKvW63C1fTtKg47
 P4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718951806; x=1719556606;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P7NsGwqjm/7EDad7tIWfUEkw3hUdKkMiiR0U4Q2Hkhc=;
 b=QrumNsgbt3wEZxwCRnUEK4cBf5kjtaqOBbuOIwHLl8srGuk+AUWyJpWTaIdIrfyisJ
 1CuyY2w6KiausunOdCw3VEzUoX1MBEFrX5dGC2CDXs2HmUWd4nI937PAkSSAafb6gVGD
 wneow12yMvo5CoMOCmJvuOm+gMvhfsi1fkZ0t/HFdlLdLRqK4ao1MkNnMzu2qZApeZBM
 5Zdao+gJS6gCWxfK88MvWjCdlAZKRcAWZaVxmcLU+4SNryhkOgOAi/1P1oIhhlF6qoaj
 4s/3wiQgBtU67Tt+irxyFQrowCHiBOVKHuTu3bw+yN06Q/HSZDNXphr9uadxxMULSo1X
 2oTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjJMceshjKCWJMvib36ptk8uLWncoJVnUh8VCn4bMWPor0SiPRl8u+slISZ1dOTAPiTBcwhibbriii2FA6+G6DBeiZtnw=
X-Gm-Message-State: AOJu0Ywlc535Qz3qKAEKVEC4hw+RfV0eE+ZrNm8g39GG3WJ6AX4SCcPN
 ZrOwwmbg3c9ya3R7s8VQnASUoC31Fr5Bu1nA4kv+OFYl1ANHwSW3tdgVVEmVvdI=
X-Google-Smtp-Source: AGHT+IE+4Ye3xmT+YTzQMyCsP4cYiPEvvD2BdzbiLs7F6LBFT1cCLrRdD1IXKY9Fjw53fon9clHrvg==
X-Received: by 2002:a17:907:c713:b0:a6f:54fc:d921 with SMTP id
 a640c23a62f3a-a6fab605ee4mr579598866b.16.1718951805864; 
 Thu, 20 Jun 2024 23:36:45 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.128.209])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fcf56063dsm48122666b.147.2024.06.20.23.36.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 23:36:45 -0700 (PDT)
Message-ID: <2c1c5bfa-da3f-4f09-b7d7-832bcc399be2@linaro.org>
Date: Fri, 21 Jun 2024 08:36:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] exec: use char* for pointer arithmetic
To: Roman Kiryanov <rkir@google.com>, richard.henderson@linaro.org,
 qemu-devel@nongnu.org
Cc: jansene@google.com, mett@google.com, jpcottin@google.com
References: <20240619000450.893463-1-rkir@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240619000450.893463-1-rkir@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 19/6/24 02:04, Roman Kiryanov wrote:
> void* pointer arithmetic is not in the
> C standard. This change allows using
> the QEMU headers with a C++ compiler.
> 
> Google-Bug-Id: 331190993
> Change-Id: I5a064853429f627c17a9213910811dea4ced6174
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
> v2: change `char*` into `char *` (add the missing space).
> 
>   include/exec/memory.h                 |  8 ++++----
>   include/exec/memory_ldst_cached.h.inc | 12 ++++++------
>   2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index d7591a60d9..a6d64e39a5 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -2839,7 +2839,7 @@ static inline uint8_t address_space_ldub_cached(MemoryRegionCache *cache,
>   {
>       assert(addr < cache->len);
>       if (likely(cache->ptr)) {
> -        return ldub_p(cache->ptr + addr);
> +        return ldub_p((char *)cache->ptr + addr);
>       } else {
>           return address_space_ldub_cached_slow(cache, addr, attrs, result);
>       }
> @@ -2850,7 +2850,7 @@ static inline void address_space_stb_cached(MemoryRegionCache *cache,
>   {
>       assert(addr < cache->len);
>       if (likely(cache->ptr)) {
> -        stb_p(cache->ptr + addr, val);
> +        stb_p((char *)cache->ptr + addr, val);
>       } else {
>           address_space_stb_cached_slow(cache, addr, val, attrs, result);
>       }
> @@ -3123,7 +3123,7 @@ address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
>       assert(addr < cache->len && len <= cache->len - addr);
>       fuzz_dma_read_cb(cache->xlat + addr, len, cache->mrs.mr);
>       if (likely(cache->ptr)) {
> -        memcpy(buf, cache->ptr + addr, len);
> +        memcpy(buf, (char *)cache->ptr + addr, len);
>           return MEMTX_OK;
>       } else {
>           return address_space_read_cached_slow(cache, addr, buf, len);
> @@ -3144,7 +3144,7 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
>   {
>       assert(addr < cache->len && len <= cache->len - addr);
>       if (likely(cache->ptr)) {
> -        memcpy(cache->ptr + addr, buf, len);
> +        memcpy((char *)cache->ptr + addr, buf, len);
>           return MEMTX_OK;
>       } else {
>           return address_space_write_cached_slow(cache, addr, buf, len);
> diff --git a/include/exec/memory_ldst_cached.h.inc b/include/exec/memory_ldst_cached.h.inc
> index d7834f852c..9426663524 100644
> --- a/include/exec/memory_ldst_cached.h.inc
> +++ b/include/exec/memory_ldst_cached.h.inc
> @@ -30,7 +30,7 @@ static inline uint16_t ADDRESS_SPACE_LD_CACHED(uw)(MemoryRegionCache *cache,
>       assert(addr < cache->len && 2 <= cache->len - addr);
>       fuzz_dma_read_cb(cache->xlat + addr, 2, cache->mrs.mr);
>       if (likely(cache->ptr)) {
> -        return LD_P(uw)(cache->ptr + addr);
> +        return LD_P(uw)((char *)cache->ptr + addr);
>       } else {
>           return ADDRESS_SPACE_LD_CACHED_SLOW(uw)(cache, addr, attrs, result);
>       }
> @@ -42,7 +42,7 @@ static inline uint32_t ADDRESS_SPACE_LD_CACHED(l)(MemoryRegionCache *cache,
>       assert(addr < cache->len && 4 <= cache->len - addr);
>       fuzz_dma_read_cb(cache->xlat + addr, 4, cache->mrs.mr);
>       if (likely(cache->ptr)) {
> -        return LD_P(l)(cache->ptr + addr);
> +        return LD_P(l)((char *)cache->ptr + addr);
>       } else {
>           return ADDRESS_SPACE_LD_CACHED_SLOW(l)(cache, addr, attrs, result);
>       }
> @@ -54,7 +54,7 @@ static inline uint64_t ADDRESS_SPACE_LD_CACHED(q)(MemoryRegionCache *cache,
>       assert(addr < cache->len && 8 <= cache->len - addr);
>       fuzz_dma_read_cb(cache->xlat + addr, 8, cache->mrs.mr);
>       if (likely(cache->ptr)) {
> -        return LD_P(q)(cache->ptr + addr);
> +        return LD_P(q)((char *)cache->ptr + addr);
>       } else {
>           return ADDRESS_SPACE_LD_CACHED_SLOW(q)(cache, addr, attrs, result);
>       }
> @@ -76,7 +76,7 @@ static inline void ADDRESS_SPACE_ST_CACHED(w)(MemoryRegionCache *cache,
>   {
>       assert(addr < cache->len && 2 <= cache->len - addr);
>       if (likely(cache->ptr)) {
> -        ST_P(w)(cache->ptr + addr, val);
> +        ST_P(w)((char *)cache->ptr + addr, val);
>       } else {
>           ADDRESS_SPACE_ST_CACHED_SLOW(w)(cache, addr, val, attrs, result);
>       }
> @@ -87,7 +87,7 @@ static inline void ADDRESS_SPACE_ST_CACHED(l)(MemoryRegionCache *cache,
>   {
>       assert(addr < cache->len && 4 <= cache->len - addr);
>       if (likely(cache->ptr)) {
> -        ST_P(l)(cache->ptr + addr, val);
> +        ST_P(l)((char *)cache->ptr + addr, val);
>       } else {
>           ADDRESS_SPACE_ST_CACHED_SLOW(l)(cache, addr, val, attrs, result);
>       }
> @@ -98,7 +98,7 @@ static inline void ADDRESS_SPACE_ST_CACHED(q)(MemoryRegionCache *cache,
>   {
>       assert(addr < cache->len && 8 <= cache->len - addr);
>       if (likely(cache->ptr)) {
> -        ST_P(q)(cache->ptr + addr, val);
> +        ST_P(q)((char *)cache->ptr + addr, val);
>       } else {
>           ADDRESS_SPACE_ST_CACHED_SLOW(q)(cache, addr, val, attrs, result);
>       }

Superseded by 
https://lore.kernel.org/qemu-devel/20240620201654.598024-1-rkir@google.com/.

