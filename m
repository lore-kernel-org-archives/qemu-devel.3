Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37923CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 18:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umcOr-0003M1-HH; Thu, 14 Aug 2025 14:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1umcOn-0003LU-G2
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 14:10:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1umcOf-0003YC-Tc
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 14:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755194989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KOndcIKxwCFqrtEz7RYMVWx/75cS/9BqMZgHwFEvqkI=;
 b=VCouHluSx36wGWoxtgH/BfqcuBd0iBqZT4pV1qwjqoDOXKFDbyalcIxudHumk9vxqddPuG
 NXi4ix2x199ZiFKnxqC+tmMzpvCEdfDohk+kTJpvYBy3KQQ4FSaV+fADbaUDcg13vtyqby
 t9n9k3ksVcmvHDA26AHIwp4Hxi/W75g=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-XA-EQtrTMxSosTzcB-dB1A-1; Thu, 14 Aug 2025 14:09:48 -0400
X-MC-Unique: XA-EQtrTMxSosTzcB-dB1A-1
X-Mimecast-MFC-AGG-ID: XA-EQtrTMxSosTzcB-dB1A_1755194987
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7e870317642so281908785a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 11:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755194987; x=1755799787;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KOndcIKxwCFqrtEz7RYMVWx/75cS/9BqMZgHwFEvqkI=;
 b=NYHfzuJRWFtQ9S8oq+VtfXH3BKI1Xc5mEwQfNJPMLlJ4QR+ZzV5MzwIYI2hWYiLyuQ
 Gdzv8xfeDh60MAKNftsot0MhpfxQbZkXdlminD8SapsOAzKW7JiJFqZwCUhk1nhYLCH6
 J34ZVPWliYLueXG14GXmq4/gwd2wPMYV1gW7ec3sC7n3DhMZlx3ItT2gerwKWlQuKYjr
 upZwJwXXZxBRrQzoQjM0C2HkIEQoI5BCm101/LNnDzQOp1XIaOVrWo8UJxZHp4fnmbZx
 tKDkx8ckZE3VphW/SHfT2Kop44Y1/hAFdtP1Rzr/4TTgbFLDxkGModEzdJvwGgsj6MUN
 rZ3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVvpxo1Eadpdg7A7DsZ9kSthRLEaI5Z3Ti1tMwgnX+d1m68MMrXpJt8brr9IcVRGjtN0FFCnN50RrX@nongnu.org
X-Gm-Message-State: AOJu0Yyrv5WqVa+qSpDMTYDvJ458p+RSpE76uLYiAhuFGsVqHYZEeKCB
 bbukQbiBqpm6rjrm4+831VL3iYvmhy7g9QMg3S9AtynqsgdAH3ksXe0WivGHwmTxPw8+7cBprJ+
 wAZ1/UwSd+ktd2Io3dNJNRw25Eun/4ofDPJFR1NwWcTe+DoU7vZbG7Hn4
X-Gm-Gg: ASbGncslV+0/L+X01hxZCOYkFhnyRmt2+QzfkjJRyoErcOQ06DMWRuF9Kd1peSgxuWr
 as3YrLCjzsIsnLBbaHXqoh5ZSrt6KC1J+SM1KLZ/GFx63UVJJxSKasI4OvU1EXE9oX0Vdy9u2bi
 iam2WbnISI5QuMiw8oHQ3U2dxOQ8+bz7OikXmtfYXWWrgtSYMh+hUMw6fMq/7YS4yTFTprRZzMZ
 slOnr+doQfv64P66E5xXxdK96+iU2w3nP8huawrbjvQ2Yy/Q09z6VFdVUi+Jk5UoMT1vMu7ZM8Z
 CN8tgVsmaj25/76qUvJ8zXb8O3NB8qC1OthiA4WE/NcSAlQLaIoEgXwuUhtP9edMgtWNa/iEJM1
 jmCbRIWor
X-Received: by 2002:a05:620a:424b:b0:7e6:5ef6:b701 with SMTP id
 af79cd13be357-7e871bba06bmr463662585a.66.1755194987326; 
 Thu, 14 Aug 2025 11:09:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFp3uUAh+qiAKM9/1ZDx0+erwAL9veROiehBssNVuAskq5yz239wte+5Tr5ths8MN7UsDAwg==
X-Received: by 2002:a05:620a:424b:b0:7e6:5ef6:b701 with SMTP id
 af79cd13be357-7e871bba06bmr463658485a.66.1755194986701; 
 Thu, 14 Aug 2025 11:09:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e87b504cdfsm7765685a.79.2025.08.14.11.09.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Aug 2025 11:09:46 -0700 (PDT)
Message-ID: <ea1cdeca-204f-43bd-8b1d-905a2752c0b6@redhat.com>
Date: Thu, 14 Aug 2025 20:09:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 55/59] include/user: Use vaddr in guest-host.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
 <20250501212113.2961531-56-richard.henderson@linaro.org>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <20250501212113.2961531-56-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
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

Hi,

this commit breaks something when I try to debootstrap an etch-m68k chroot (not fixed in 
5836af078321):

unshare --time --ipc --uts --pid --fork --kill-child --mount --mount-proc --root 
chroot/m68k/etch-m68k apt-get update --yes
Get:1 http://archive.debian.org etch-m68k Release.gpg [835B]
Hit http://archive.debian.org etch-m68k Release
Err http://archive.debian.org etch-m68k Release

Get:2 http://archive.debian.org etch-m68k Release [8670B]
Ign http://archive.debian.org etch-m68k Release
Ign http://archive.debian.org etch-m68k/main Packages/DiffIndex
Hit http://archive.debian.org etch-m68k/main Packages
Fetched 9505B in 0s (12.9kB/s)
Reading package lists... Error!
W: GPG error: http://archive.debian.org etch-m68k Release: The following signatures 
couldn't be verified because the public key is not available: NO_PUBKEY 9AA38DCD55BE302B
E: Unable to write mmap - msync (12 Cannot allocate memory)
E: The package lists or status file could not be parsed or opened.

(it's using my create_chroot.sh from https://github.com/vivier/linux-user-test-scrips.
set RELEASES=etch in targets.conf, then run ./create_all.sh)

Thanks,
Laurent

On 01/05/2025 23:21, Richard Henderson wrote:
> Replace abi_ptr and abi_ulong with vaddr.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/user/guest-host.h | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/user/guest-host.h b/include/user/guest-host.h
> index 8e10d36948..0656f2e356 100644
> --- a/include/user/guest-host.h
> +++ b/include/user/guest-host.h
> @@ -8,7 +8,7 @@
>   #ifndef USER_GUEST_HOST_H
>   #define USER_GUEST_HOST_H
>   
> -#include "user/abitypes.h"
> +#include "exec/vaddr.h"
>   #include "user/guest-base.h"
>   #include "cpu.h"
>   
> @@ -30,29 +30,29 @@ extern unsigned long reserved_va;
>   extern unsigned long guest_addr_max;
>   
>   #ifndef TARGET_TAGGED_ADDRESSES
> -static inline abi_ptr cpu_untagged_addr(CPUState *cs, abi_ptr x)
> +static inline vaddr cpu_untagged_addr(CPUState *cs, vaddr x)
>   {
>       return x;
>   }
>   #endif
>   
>   /* All direct uses of g2h and h2g need to go away for usermode softmmu.  */
> -static inline void *g2h_untagged(abi_ptr x)
> +static inline void *g2h_untagged(vaddr x)
>   {
>       return (void *)((uintptr_t)(x) + guest_base);
>   }
>   
> -static inline void *g2h(CPUState *cs, abi_ptr x)
> +static inline void *g2h(CPUState *cs, vaddr x)
>   {
>       return g2h_untagged(cpu_untagged_addr(cs, x));
>   }
>   
> -static inline bool guest_addr_valid_untagged(abi_ulong x)
> +static inline bool guest_addr_valid_untagged(vaddr x)
>   {
>       return x <= guest_addr_max;
>   }
>   
> -static inline bool guest_range_valid_untagged(abi_ulong start, abi_ulong len)
> +static inline bool guest_range_valid_untagged(vaddr start, vaddr len)
>   {
>       return len - 1 <= guest_addr_max && start <= guest_addr_max - len + 1;
>   }
> @@ -62,7 +62,7 @@ static inline bool guest_range_valid_untagged(abi_ulong start, abi_ulong len)
>   
>   #define h2g_nocheck(x) ({ \
>       uintptr_t __ret = (uintptr_t)(x) - guest_base; \
> -    (abi_ptr)__ret; \
> +    (vaddr)__ret; \
>   })
>   
>   #define h2g(x) ({ \


