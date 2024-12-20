Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F434E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 10:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOaEo-0004WU-NZ; Fri, 20 Dec 2024 05:28:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tOaEn-0004WK-8C
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 05:28:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tOaEl-0000Ww-KT
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 05:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734690482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+qyzaYgetTgkHINlfW9YHRzo5n7XImuXHqpP733L+EU=;
 b=Hf/Hkhynm4NiyxIlT+JsxwwrzMjQnwmaOM8anRhrsJVwO2EwTlDCrUxE7iZwfo0Tu/4ldc
 QzrAtF/L3r/TBqvqkygm1/X9GxVzABc4p3kFPhSIgwj0vY9UBIaZImSbP3JngWMesMElF4
 WicfazlTsIlwbwFeQu8a+o+s5h4B3Y4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-RJwcvQhfMRyiuY-L8QPY7A-1; Fri, 20 Dec 2024 05:28:00 -0500
X-MC-Unique: RJwcvQhfMRyiuY-L8QPY7A-1
X-Mimecast-MFC-AGG-ID: RJwcvQhfMRyiuY-L8QPY7A
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43628594d34so10175125e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 02:28:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734690480; x=1735295280;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+qyzaYgetTgkHINlfW9YHRzo5n7XImuXHqpP733L+EU=;
 b=AX9RRAFKdJqIsUzqJKvbmG/X0imd3Q+vesU9LYgtmeoVoXA2iswB6OQKigkxGuIPtH
 KqpF7W+dHtsBkXtvZkDXxETkl1h80m+sSBTdx+kohM63fOHy3jLlt2sUH8LLtrO9q0v5
 2YMggJK7vt/Ne5QcLvlQywLZfvvmp9Fndmxl9USoPU1iBFZGcK2NV6WI8g715qZrxk/J
 ssDOo8viXaxGg3yRqrSNsnePatyuv/+uB47pTUYBA1DAxbwWVgh77iv4MoXDKdcEDY+I
 z0Xc3oiKy7nyMyQjFyB6p1FOAI+BxbcsQC0aXroUieTR1RdDipMPh9jsv/ElqUMDZ2Of
 ChnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGQqaZidoLYzDIQkg7FbPNVQYWYet2wNf8Z+KdZid1Fe4qTWv+5AKrLY8cn88HPr+UdeVkOAjCpbjV@nongnu.org
X-Gm-Message-State: AOJu0Yy4SaAa33/T/ejUr+7oM2/fEFJGk4WE0BU2PiYtfUAGADEQePQK
 HY89a29D5XPe6gn2VVsNuI6iFW3zrBH5Eg8clLwHtz/mnm/ebPuZjRvuW9YGyINVQLzGHTa0hA5
 FlpTOlQLUjPhF+0gnB5vn7l8BDqpFtxK3cwiZRF1PwAeMqbawfMHu
X-Gm-Gg: ASbGncsFO+qpUCE2K8ms6D8MpqxII+b05h7CunrWnhC+1pWjL4ridluRWoZoBKuVf4g
 tcT+8xjHwM/awKO5AViw+hQEAXipkdIcrDnAj5ojMVwN46A7aALY1GKN47qKdedKRgnplWicJf6
 AaQTP6wb8FBq8KwgeZrX2L2Fc7lSpjTwFTYX90Hl7Im7aGDxW4BUaFNV/wiIx4iX87/SCqhx8BE
 I4AGJkoZlf8PkUA0XAkfFMu8iRUsn7jyujSPNWJPCrBF88UI7Y8CqdKoYUS/COBI6WIngvn5VKK
 rgglbfNUUDo2XRFNdd+9XHDN274mScpLVy33Qw1xVblSxNzJwM4bWLpVQ58+yrrOa8NST3mk3Wx
 NxSPf9my1
X-Received: by 2002:a5d:64c2:0:b0:385:e968:f189 with SMTP id
 ffacd0b85a97d-38a22408262mr2150035f8f.51.1734690479742; 
 Fri, 20 Dec 2024 02:27:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0wk9fhe79Xa9L695jxVQ4YV43gbJtv+eMdpvFdgLiqUmLXNBNXftNqOVqLHVszaYeFXCcdA==
X-Received: by 2002:a5d:64c2:0:b0:385:e968:f189 with SMTP id
 ffacd0b85a97d-38a22408262mr2149999f8f.51.1734690479400; 
 Fri, 20 Dec 2024 02:27:59 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:9d00:edd9:835b:4bfb:2ce3?
 (p200300cbc7089d00edd9835b4bfb2ce3.dip0.t-ipconnect.de.
 [2003:cb:c708:9d00:edd9:835b:4bfb:2ce3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8475cesm3688659f8f.57.2024.12.20.02.27.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 02:27:58 -0800 (PST)
Message-ID: <d9dd59dd-ab22-4edb-941e-160b2a1b7d61@redhat.com>
Date: Fri, 20 Dec 2024 11:27:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] physmem: allow cpu_memory_rw_debug to write to MMIO
 devices
To: Stefan Zabka <git@zabka.it>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241218193153.151578-1-git@zabka.it>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241218193153.151578-1-git@zabka.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 18.12.24 20:31, Stefan Zabka wrote:
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/213
> Signed-off-by: Stefan Zabka <git@zabka.it>
> ---
>   system/physmem.c | 22 ++++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index dc1db3a384..53cdccefcb 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3556,6 +3556,7 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
>       hwaddr phys_addr;
>       vaddr l, page;
>       uint8_t *buf = ptr;
> +    bool is_memcpy_access;
>   
>       cpu_synchronize_state(cpu);
>       while (len > 0) {
> @@ -3574,11 +3575,24 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
>               l = len;
>           phys_addr += (addr & ~TARGET_PAGE_MASK);
>           if (is_write) {
> -            res = address_space_write_rom(cpu->cpu_ases[asidx].as, phys_addr,
> -                                          attrs, buf, l);
> +            /* if ram/rom region we access the memory
> +              via memcpy instead of via the cpu */

Coding style says: "Multiline comment blocks should have a row of stars 
on the left, and the initial /* and terminating */ both on their own lines:"

> +            hwaddr mr_len, addr1;
> +            AddressSpace *as = cpu->cpu_ases[asidx].as;
> +            MemoryRegion *mr = address_space_translate(as, phys_addr, &addr1, &mr_len, is_write, attrs);
> +
> +            is_memcpy_access = memory_region_is_ram(mr) || memory_region_is_romd(mr);
> +            if(!is_memcpy_access) {
> +                l = memory_access_size(mr, l, addr1);
> +            }
> +        } else {
> +            is_memcpy_access = false;
> +        }

Is this really required? The additional address_space_translate() is 
nasty, and flatview_write_continue_step() will perform a memmove 
directly to the RAMBlock if memory_access_is_direct() allows for it.


Would it be possible to always use address_space_rw()?

If there is a reason we need the address_space_write_rom(), could we 
simply fallback to it if address_space_rw(true) failed? That might make 
it all simpler.

> +
> +        if (is_write && is_memcpy_access) {
> +            res = address_space_write_rom(cpu->cpu_ases[asidx].as, phys_addr, attrs, buf, l);
>           } else {
> -            res = address_space_read(cpu->cpu_ases[asidx].as, phys_addr,
> -                                     attrs, buf, l);
> +            res = address_space_rw(cpu->cpu_ases[asidx].as, phys_addr, attrs, buf, l, is_write);
>           }
>           if (res != MEMTX_OK) {
>               return -1;


-- 
Cheers,

David / dhildenb


