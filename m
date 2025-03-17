Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9FAC35FF8
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 16:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuDG9-0001Xe-Gi; Mon, 17 Mar 2025 12:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuDFp-0001Gr-Ol
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:23:56 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuDFm-0005Zc-Px
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:23:53 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-390f5f48eafso2927357f8f.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 09:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742228627; x=1742833427; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=avfzUeOggfHVdiAQhDfUOVX9Fi+u2OCZ2GM9j7NAP70=;
 b=FLHnh+sovfrCNJMiVgGqVDATRJdJmP9ACN2xobq2l4kCA5QTVo9Eq2Wigw+VLMJR0s
 sbTCXoksdvhPNfCKV38G5E5X8y1y6Fj14uELhDpVSlgfrOgHe/JQk5tAS1+9eo1UmMPv
 pY8TtW/YqZkK1PENMDbww4SmAl5oFRlqfKLgQdGbhtUccS7l1gi2KguJymqhiHRiHNa+
 x7effTHge8nu3ugLV46WskTB7Fp9/VPMPCEhgrxLu5p3pTQ1m8U/GQwwbh3FIGRlgA70
 WT+/A5mqWvbyRcHo2A0FM+U5qVc32W4zLj0pw8No8bY9vq/EKWfhqxkqHGYw5DTCZjG1
 btIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742228627; x=1742833427;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=avfzUeOggfHVdiAQhDfUOVX9Fi+u2OCZ2GM9j7NAP70=;
 b=CrIt8qS5IM18CDV/hxOBZj2K72+Zkklok5RFjCbV01yYtX8rW7OGewhGji9+dPx4+J
 zyLO9tYrsdIWWpbW2qc9FxuCdz9ibY4PbJf5joEEZzMVvZmPuu/GiMGPZDP+TfvwESMd
 ye3Kc/2jb2RyiuCoYlcNIgksXR9rdkQeSqU8NI4tBRQAC3bfSexU2zkhP+OYifkZ1uGI
 uWkc2DDkd9UA2qGyD7ZqUM+EGERZGUu2To2QMFkJ2OiEKkS6V/iW/JRv5oN5xdQJ6XjE
 wmVtFCYehpVLJpUNAHUVuzwap0yxeFIrcGbiH8VodqBnUyvUYiZYSz6xefnBhrpwenSn
 qVzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpHoSUo8nBoP6mosUQi440dgmtu8ZWOnLMgYdMCbKJeGi9HVDBydkRAtwyMHeduWpiqA4wOxOZ7EMi@nongnu.org
X-Gm-Message-State: AOJu0YxTKVl2nGWckO5T6DDV58oW+rdXZFqsdaVozqG4wYO5YlF2uv0L
 SL4e7PKgU7FtWd8EVQOm/HUa1bAMOGduqNzCgE05Ips+vbUhKi+aKUff716Co5Q=
X-Gm-Gg: ASbGncvy5szPrj8VZjXtr7ND5toh/FT+A0G/mZi9On6D6vxhhCl5SoutLHLa+1H+WtM
 Q4Gk0IXX6kAVaeABFmKSq6D/5JUcXr4YVgJw2xaqNC0cni4ZG7ws3UOLzRZOi+gWTlIzbfCUEcj
 TvwZJOqqLPJ1Y9KYSUmPvfNF8irnhT9Tqlyb8qmq1CaZY7M6glWy3xnaEnXyW9HdSvyQnM5ApCQ
 HXu/KMQgcF+UreaLOlmvOe8rOX2+kIymV3XtLd1G5oOH1LCteVCJLXBWSano1xXmwOJSagzEybq
 x7qE5VrGV9R6vcVtgQnvIs0UTWCDtR+R7taysm3f2u338KG7lfHCrMxgl9Z0SG+uuNBrwZn12JI
 NvADX4j0hEg==
X-Google-Smtp-Source: AGHT+IEamG3WdlxD2LrQxwdmg89i4SPc4GJaByF7u76Lrx89qJx15nBJz8iHq3PU1coEHuSB+Sy0JA==
X-Received: by 2002:a05:6000:1ac6:b0:391:48f7:bd8a with SMTP id
 ffacd0b85a97d-3996b467819mr185608f8f.30.1742228627083; 
 Mon, 17 Mar 2025 09:23:47 -0700 (PDT)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c83b6b2bsm15083896f8f.26.2025.03.17.09.23.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 09:23:46 -0700 (PDT)
Message-ID: <d93f6514-6d42-467d-826b-c95c6efd66b1@linaro.org>
Date: Mon, 17 Mar 2025 17:23:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/17] exec/ram_addr: call xen_hvm_modified_memory only
 if xen is enabled
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Durrant <paul@xen.org>, Peter Xu <peterx@redhat.com>,
 alex.bennee@linaro.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-riscv@nongnu.org,
 manos.pitsidianakis@linaro.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Anthony PERARD <anthony@xenproject.org>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>
References: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
 <20250314173139.2122904-12-pierrick.bouvier@linaro.org>
 <ad7cdcaf-46d6-460f-8593-a9b74c600784@linaro.org>
 <edc3bc03-b34f-4bed-be0d-b0fb776a115b@linaro.org>
 <9c55662e-0c45-4bb6-83bf-54b131e30f48@linaro.org>
Content-Language: en-US
In-Reply-To: <9c55662e-0c45-4bb6-83bf-54b131e30f48@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 17/3/25 17:22, Philippe Mathieu-Daudé wrote:
> On 17/3/25 17:07, Pierrick Bouvier wrote:
>> On 3/17/25 08:50, Philippe Mathieu-Daudé wrote:
>>> On 14/3/25 18:31, Pierrick Bouvier wrote:
>>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> ---
>>>>    include/exec/ram_addr.h | 8 ++++++--
>>>>    1 file changed, 6 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
>>>> index f5d574261a3..92e8708af76 100644
>>>> --- a/include/exec/ram_addr.h
>>>> +++ b/include/exec/ram_addr.h
>>>> @@ -339,7 +339,9 @@ static inline void 
>>>> cpu_physical_memory_set_dirty_range(ram_addr_t start,
>>>>            }
>>>>        }
>>>> -    xen_hvm_modified_memory(start, length);
>>>> +    if (xen_enabled()) {
>>>> +        xen_hvm_modified_memory(start, length);
>>>
>>> Please remove the stub altogether.
>>>
>>
>> We can eventually ifdef this code under CONFIG_XEN, but it may still 
>> be available or not. The matching stub for xen_hvm_modified_memory() 
>> will assert in case it is reached.
>>
>> Which change would you expect precisely?
> 
> -- >8 --
> diff --git a/include/system/xen-mapcache.h b/include/system/xen-mapcache.h
> index b68f196ddd5..bb454a7c96c 100644
> --- a/include/system/xen-mapcache.h
> +++ b/include/system/xen-mapcache.h
> @@ -14,8 +14,6 @@
> 
>   typedef hwaddr (*phys_offset_to_gaddr_t)(hwaddr phys_offset,
>                                            ram_addr_t size);
> -#ifdef CONFIG_XEN_IS_POSSIBLE
> -
>   void xen_map_cache_init(phys_offset_to_gaddr_t f,
>                           void *opaque);
>   uint8_t *xen_map_cache(MemoryRegion *mr, hwaddr phys_addr, hwaddr size,
> @@ -28,44 +26,5 @@ void xen_invalidate_map_cache(void);
>   uint8_t *xen_replace_cache_entry(hwaddr old_phys_addr,
>                                    hwaddr new_phys_addr,
>                                    hwaddr size);
> -#else
> -
> -static inline void xen_map_cache_init(phys_offset_to_gaddr_t f,
> -                                      void *opaque)
> -{
> -}
> -
> -static inline uint8_t *xen_map_cache(MemoryRegion *mr,
> -                                     hwaddr phys_addr,
> -                                     hwaddr size,
> -                                     ram_addr_t ram_addr_offset,
> -                                     uint8_t lock,
> -                                     bool dma,
> -                                     bool is_write)
> -{
> -    abort();
> -}
> -
> -static inline ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
> -{
> -    abort();
> -}
> -
> -static inline void xen_invalidate_map_cache_entry(uint8_t *buffer)
> -{
> -}
> -
> -static inline void xen_invalidate_map_cache(void)
> -{
> -}
> -
> -static inline uint8_t *xen_replace_cache_entry(hwaddr old_phys_addr,
> -                                               hwaddr new_phys_addr,
> -                                               hwaddr size)
> -{
> -    abort();
> -}
> -
> -#endif
> 
>   #endif /* XEN_MAPCACHE_H */

(sorry, the include/system/xen-mapcache.h change is for the next patch)

> diff --git a/include/system/xen.h b/include/system/xen.h
> index 990c19a8ef0..04fe30cca50 100644
> --- a/include/system/xen.h
> +++ b/include/system/xen.h
> @@ -30,25 +30,16 @@ extern bool xen_allowed;
> 
>   #define xen_enabled()           (xen_allowed)
> 
> -void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
> -void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
> -                   struct MemoryRegion *mr, Error **errp);
> -
>   #else /* !CONFIG_XEN_IS_POSSIBLE */
> 
>   #define xen_enabled() 0
> -static inline void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t 
> length)
> -{
> -    /* nothing */
> -}
> -static inline void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
> -                                 MemoryRegion *mr, Error **errp)
> -{
> -    g_assert_not_reached();
> -}
> 
>   #endif /* CONFIG_XEN_IS_POSSIBLE */
> 
> +void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
> +void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
> +                   MemoryRegion *mr, Error **errp);
> +
>   bool xen_mr_is_memory(MemoryRegion *mr);
>   bool xen_mr_is_grants(MemoryRegion *mr);
>   #endif
> ---


