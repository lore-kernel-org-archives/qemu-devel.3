Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0E5C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 13:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukLzc-0004Et-UE; Fri, 08 Aug 2025 08:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1ukLzY-0003zD-TR
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 08:14:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1ukLy2-0000as-Pa
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 08:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754655178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uZGwOPWhCEXGzT5mW8sGJbLfQe3OeHqPBz8qka+frOI=;
 b=TWgKDUul18NOOddcq7GVXkXehPahZ7oy6T73bXnW32oY6nd4afaTHE+buCJI0IzOCp2rJ6
 hHjj8Hl3k4ReyfyTuyGTNhuwo5qhUKn7CeHBgkkRbvw8OHPo3tNtJtlHTEPDcE2v6J9fO9
 flWNLtGebFGa8kXemzZocJjeSbCeH9w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-0r3KOR5-Ns6aEVrBQLcFlw-1; Fri, 08 Aug 2025 08:12:57 -0400
X-MC-Unique: 0r3KOR5-Ns6aEVrBQLcFlw-1
X-Mimecast-MFC-AGG-ID: 0r3KOR5-Ns6aEVrBQLcFlw_1754655176
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-458b9ded499so14625625e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 05:12:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754655176; x=1755259976;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=uZGwOPWhCEXGzT5mW8sGJbLfQe3OeHqPBz8qka+frOI=;
 b=pHEtvRMdboCvnfKyZTJxN2rLGrtV31VuKq2gxLP7AR5zMBylaTwzkt1Dd7GtBmOPlw
 2TXBoSG1kYmX/hHhbKVHPGcL5uHUDVg9t4ojNmjJTou5b7QA8OnznSbHAl+iTOAdsakN
 yoEF8KbgnZabRYHP2nfI3bpy97PvdGcPYNn4LukqxDgajHsJ4knF4aEYBLN/HI6VgzIT
 iW38jIq8IUv3hCsImAhPaC3lGXGEbO0luugDUjBza7fYU8rcTF80RRreJVdg+25eqIgE
 xNNSvMbb/EqthRE1AI45E+d3Mot5SCfpEuGfeX/e2ALnAb1y1KsXciJBs2ldj2LdeDT1
 JSwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9aTXwTBiVEq+j06PeUTqPcDa/nvOBGritymRA+tYRLOWtBi/cYPjebvhucV/IviFEV6y4959IFP3Z@nongnu.org
X-Gm-Message-State: AOJu0Ywjd1QRWzV7OOwHp+xe2MNyuT92sZaKLGuMPECVV7lTuS5FQ2bz
 VZ+JE4XqSSlVQs1Uw+tV4yAq4Cwt0P6Dje+kgTHLPbP+/sBlXX3a8qYJgyvLpnYKo9uB7+5metH
 EyCa4fjLS2EsujasCEmjlJmbNluxY/3pepfoW77tUNP7EB2JlKRwOB4kL
X-Gm-Gg: ASbGncu+hXCx0CPgQm7OsCOy/Grw3GM/AWxsO2Sz1xqFzNYSbi2IngIBe1sKwR41wJy
 gAkuwD6lT4B6JLJbj682JO8Ix+ATlFoPLsqO6wfmAm55Og/ZUl5EG8Gi5Tg569lkdGmtUpDYy6j
 g+pZuxpW8cvO65eAEoAcarFuBHcxHVA3N022+k2e8VkiAyTviWj4Z4ZV98mBdWhvXpmyJaTVNta
 H7M6x6d9zQ/gu3GpVquYDp0c+gTbc+mnLDa5SwWULHdetJFfPdC/Csyc2BNQEigdpP+uVE798bz
 C6ULs2DCEeAw0fYsXLBavaK1Atc/CXNjcKHjVcVsekW/dahhh5qtQjK8WY+BJ7SZiJObMwE7jBL
 Sw9533KXqmRNQOJ6D6knZWQ+M2ZEwGYrWGKXQi4SYBo9ci2qaYbzbUgHxzpFdZuyx
X-Received: by 2002:a05:600c:1f06:b0:456:25e7:bed with SMTP id
 5b1f17b1804b1-459f4f652f2mr26714965e9.14.1754655176148; 
 Fri, 08 Aug 2025 05:12:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcdtL1PI5drrxmMJmEP3BOlE8EcFd5J2zzqJtfq3ybZdFCLcxT/XJVHbaFC8yMatWH/fXoIA==
X-Received: by 2002:a05:600c:1f06:b0:456:25e7:bed with SMTP id
 5b1f17b1804b1-459f4f652f2mr26714675e9.14.1754655175742; 
 Fri, 08 Aug 2025 05:12:55 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:900:2e1e:d717:2543:c4d6?
 (p200300d82f2509002e1ed7172543c4d6.dip0.t-ipconnect.de.
 [2003:d8:2f25:900:2e1e:d717:2543:c4d6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5873c43sm145980265e9.22.2025.08.08.05.12.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 05:12:54 -0700 (PDT)
Message-ID: <2de4fa21-a9ec-454a-9c10-39dd77e16f38@redhat.com>
Date: Fri, 8 Aug 2025 14:12:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] memory: reintroduce BQL-free fine-grained
 PIO/MMIO
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, peterx@redhat.com,
 philmd@linaro.org, mtosatti@redhat.com
References: <20250808120137.2208800-1-imammedo@redhat.com>
 <20250808120137.2208800-2-imammedo@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250808120137.2208800-2-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 08.08.25 14:01, Igor Mammedov wrote:
> This patch brings back Jan's idea [1] of BQL-free IO access
> 
> This will let us make access to ACPI PM/HPET timers cheaper,
> and prevent BQL contention in case of workload that heavily
> uses the timers with a lot of vCPUs.
> 
> 1) 196ea13104f (memory: Add global-locking property to memory regions)
>     ... de7ea885c539 (kvm: Switch to unlocked MMIO)
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v3:
>    add comment for 'mr->disable_reentrancy_guard = true'
>      Peter Xu <peterx@redhat.com>
> ---
>   include/system/memory.h | 10 ++++++++++
>   system/memory.c         | 15 +++++++++++++++
>   system/physmem.c        |  2 +-
>   3 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/include/system/memory.h b/include/system/memory.h
> index e2cd6ed126..d04366c994 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -833,6 +833,7 @@ struct MemoryRegion {
>       bool nonvolatile;
>       bool rom_device;
>       bool flush_coalesced_mmio;
> +    bool lockless_io;
>       bool unmergeable;
>       uint8_t dirty_log_mask;
>       bool is_iommu;
> @@ -2341,6 +2342,15 @@ void memory_region_set_flush_coalesced(MemoryRegion *mr);
>    */
>   void memory_region_clear_flush_coalesced(MemoryRegion *mr);
>   
> +/**
> + * memory_region_enable_lockless_io: Enable lockless (BQL free) acceess.
> + *
> + * Enable BQL-free access for devices with fine-grained locking.
> + *
> + * @mr: the memory region to be updated.
> + */
> +void memory_region_enable_lockless_io(MemoryRegion *mr);

Is this safe to use on any IO region, or could actually something break 
when mis-used? In case it's the latter, I assume we would want to 
carefully document under which scenarios this is safe to use.

-- 
Cheers,

David / dhildenb


