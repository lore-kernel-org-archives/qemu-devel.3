Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C89CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 12:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v27do-0003Z8-7x; Fri, 26 Sep 2025 08:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v27dj-0003Xz-Fw
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 08:33:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v27dX-0003jc-K0
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 08:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758889995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sAkDEv3GM9i3AB3VpVVFKvUI3wAyQgBFZsGHqzzSQWQ=;
 b=VbfkOoOZ2MwwvSgiX6aF9pLbpkzJ9wPOsmffs4DH2hSlj0AkjzoRSSLY8ZO32HpUBZ0774
 W3b17BJhYDirtm28PUeeFf2KBAuh084Cw8wnKLxOJTfW9EqZsNs0p3OopcPciQjQjAAsse
 I56qIAkc8xdfdm6ZncKdsNXoVTl1aFM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-ThOcTyTINY-W0-A3cYvRgA-1; Fri, 26 Sep 2025 08:33:13 -0400
X-MC-Unique: ThOcTyTINY-W0-A3cYvRgA-1
X-Mimecast-MFC-AGG-ID: ThOcTyTINY-W0-A3cYvRgA_1758889993
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e4335fa87so426495e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 05:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758889993; x=1759494793;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sAkDEv3GM9i3AB3VpVVFKvUI3wAyQgBFZsGHqzzSQWQ=;
 b=xD0LtuFLL/hUcRX9QIF0bC0N+PVoe/OhS9i8TPCoPaip/D4M64ejK2zzzGHzRQDIHe
 EqHn/b4nmvZH8oDdxBqXYsTLZGcRIBaSc1fD5SsQpGdNmqhQUVTdYHeEgPGUFxrpToNl
 yZaMeV/m33P+dgOaVkUBiuaf49Ra338VPD7x0+/myFn0urRBhUU46JPUNPSSNn1X7nJ4
 d10SDZ0jGUDi+kgNdN92EanmzNYj5n1CgfgdegCK2LT0RPbS+jmcrf78/KfJaNg8h0Cj
 7TFnNAF2IRIkW4PoNdkk84wKjaqF2zzR3j2sR1E45t+U10lfRySFa7hfmLSvWWD78AZ6
 ap4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5Vv6hQozCR308st53/12IujNovxDqb28f7ExYV1ng0MjCUJKo1yT33RZA8vzjmiNEnH2yS13P1fNJ@nongnu.org
X-Gm-Message-State: AOJu0Yz81ClPl1WTMTvnO7noubNA0ymFgBNi3Vjz8x4pdW02i8YQWE6U
 0h1wZb/F6AUvDZQlQ1sDL6O8amQPEbKxFhN8eK6hPAiHm0uf7TkjJAN5skGPXSokjiFMl7Y08y4
 OxwdEu1BPh4oLEiNiebicFSK1lNggO0kjzOUWk60TQ7Uyjau2inLSxz3F919J4tSt
X-Gm-Gg: ASbGncuh/ISYC4+cKal+mxcEwYqK8RDkDGMNYU0RAO8Hja4Yx9gR0+tF7wEC+/M3qOv
 zKa7PKRC/uC+IRKc+VBMxw4jCPE9XZU8nvzVBp7Htp4CCSeqssE7/ET4Ja7jwii5ewZEAtIAdvz
 5Fx63bQUS3h3bz6+SoxJfzvfL4TnvKOpGnWqeT5BYyhw3zHetdvg8gOvqistD94L4TLwqcOpJYT
 AeOw+zyMHS0ZyZTc5/uK2n/N5HBP4+ZyD/AZtYfDaJZfCf8yNpjHIiLHGAzfcX3T3Sd203oTeu9
 XsE7hinIrkW4KusLO+VaTwbe3UTLX7hXzHQclRuUKrYK4rL9hpAmbAKP/vize0Ejs+NPY7W03HT
 vntieVQ==
X-Received: by 2002:a05:600c:3551:b0:45b:9a46:69e9 with SMTP id
 5b1f17b1804b1-46e32a14a4amr82894875e9.31.1758889992666; 
 Fri, 26 Sep 2025 05:33:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnbnwoirdfNzALAJG6xcjcf8Tp4CXhkmJANcz78ACAkxPcp/YDFwDgLZ/2iYbeEwBDo/z1ig==
X-Received: by 2002:a05:600c:3551:b0:45b:9a46:69e9 with SMTP id
 5b1f17b1804b1-46e32a14a4amr82894585e9.31.1758889992242; 
 Fri, 26 Sep 2025 05:33:12 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-212.pools.arcor-ip.net.
 [47.64.114.212]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab4897bsm114774635e9.17.2025.09.26.05.33.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 05:33:11 -0700 (PDT)
Message-ID: <893f98db-672e-4352-ab6a-043892c8aba5@redhat.com>
Date: Fri, 26 Sep 2025 14:33:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/memory: Split address_space_write_rom_internal
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250922192940.2908002-1-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250922192940.2908002-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 22/09/2025 21.29, Richard Henderson wrote:
> In 2dbaf58bbe7 we conditionally skipped the increment
> of buf because ubsan warns incrementing NULL, and buf
> is always NULL for FLUSH_CACHE.  However, the existence
> of the test for NULL caused Coverity to warn that the
> memcpy in the WRITE_DATA case lacked a test for NULL.
> 
> Duplicate address_space_write_rom_internal into the two
> callers, dropping enum write_rom_type, and simplify.
> This eliminates buf in the flush case, and eliminates
> the conditional increment of buf in the write case.
> 
> Coverity: CID 1621220
> Fixes: 2dbaf58bbe7 ("system/physmem: Silence warning from ubsan")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   system/physmem.c | 90 ++++++++++++++++++++----------------------------
>   1 file changed, 37 insertions(+), 53 deletions(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index ae8ecd50ea..5f76a5f767 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3187,63 +3187,33 @@ void cpu_physical_memory_rw(hwaddr addr, void *buf,
>                        buf, len, is_write);
>   }
>   
> -enum write_rom_type {
> -    WRITE_DATA,
> -    FLUSH_CACHE,
> -};
> -
> -static inline MemTxResult address_space_write_rom_internal(AddressSpace *as,
> -                                                           hwaddr addr,
> -                                                           MemTxAttrs attrs,
> -                                                           const void *ptr,
> -                                                           hwaddr len,
> -                                                           enum write_rom_type type)
> -{
> -    hwaddr l;
> -    uint8_t *ram_ptr;
> -    hwaddr addr1;
> -    MemoryRegion *mr;
> -    const uint8_t *buf = ptr;
> -
> -    RCU_READ_LOCK_GUARD();
> -    while (len > 0) {
> -        l = len;
> -        mr = address_space_translate(as, addr, &addr1, &l, true, attrs);
> -
> -        if (!memory_region_supports_direct_access(mr)) {
> -            l = memory_access_size(mr, l, addr1);
> -        } else {
> -            /* ROM/RAM case */
> -            ram_ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
> -            switch (type) {
> -            case WRITE_DATA:
> -                memcpy(ram_ptr, buf, l);
> -                invalidate_and_set_dirty(mr, addr1, l);
> -                break;
> -            case FLUSH_CACHE:
> -                flush_idcache_range((uintptr_t)ram_ptr, (uintptr_t)ram_ptr, l);
> -                break;
> -            }
> -        }
> -        len -= l;
> -        addr += l;
> -        if (buf) {
> -            buf += l;
> -        }
> -    }
> -    return MEMTX_OK;
> -}
> -
>   /* used for ROM loading : can write in RAM and ROM */
>   MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
>                                       MemTxAttrs attrs,
>                                       const void *buf, hwaddr len)
>   {
> -    return address_space_write_rom_internal(as, addr, attrs,
> -                                            buf, len, WRITE_DATA);
> +    RCU_READ_LOCK_GUARD();
> +    while (len > 0) {
> +        hwaddr addr1, l = len;
> +        MemoryRegion *mr = address_space_translate(as, addr, &addr1, &l,
> +                                                   true, attrs);
> +
> +        if (!memory_region_supports_direct_access(mr)) {
> +            l = memory_access_size(mr, l, addr1);
> +        } else {
> +            /* ROM/RAM case */
> +            void *ram_ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
> +            memcpy(ram_ptr, buf, l);
> +            invalidate_and_set_dirty(mr, addr1, l);
> +        }
> +        len -= l;
> +        addr += l;
> +        buf += l;
> +    }
> +    return MEMTX_OK;
>   }
>   
> -void cpu_flush_icache_range(hwaddr start, hwaddr len)
> +void cpu_flush_icache_range(hwaddr addr, hwaddr len)
>   {
>       /*
>        * This function should do the same thing as an icache flush that was
> @@ -3255,9 +3225,23 @@ void cpu_flush_icache_range(hwaddr start, hwaddr len)
>           return;
>       }
>   
> -    address_space_write_rom_internal(&address_space_memory,
> -                                     start, MEMTXATTRS_UNSPECIFIED,
> -                                     NULL, len, FLUSH_CACHE);
> +    RCU_READ_LOCK_GUARD();
> +    while (len > 0) {
> +        hwaddr addr1, l = len;
> +        MemoryRegion *mr = address_space_translate(&address_space_memory,
> +                                                   addr, &addr1, &l, true,
> +                                                   MEMTXATTRS_UNSPECIFIED);
> +
> +        if (!memory_region_supports_direct_access(mr)) {
> +            l = memory_access_size(mr, l, addr1);
> +        } else {
> +            /* ROM/RAM case */
> +            void *ram_ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
> +            flush_idcache_range((uintptr_t)ram_ptr, (uintptr_t)ram_ptr, l);
> +        }
> +        len -= l;
> +        addr += l;
> +    }
>   }

Thanks for untangling the mess!

Reviewed-by: Thomas Huth <thuth@redhat.com>


