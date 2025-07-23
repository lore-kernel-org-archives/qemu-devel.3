Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E2BC83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 12:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueYdk-00061C-EI; Wed, 23 Jul 2025 08:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ueYdi-00060w-Of
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 08:32:06 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ueYdg-0002yl-6f
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 08:32:06 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-455b00283a5so40730785e9.0
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 05:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753273922; x=1753878722; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E16f9yXyg47PgMZfSj8JQG8D3htZTPeYtNlE8lRWRlU=;
 b=ZMWxMy/m+hnGkn8+9lqsGBomfIGF/tTWJEVx0b3/5+e37WBELpGiCX5BcTHEndBssT
 s1fNytzZq5DvEIAlpqBH+dv6k8Sqhceyrhe4epvD6vtU7w9ucj2XVLRn1F6aQFgr6Ery
 cDbVs4CntGQ2Qx1UDQnFeUIJ5gV1xIv7OJxrbuJ2JliZ3XvH0AvuSLeH0u1A9dv7Gw+l
 3CqlvjzqaeKiyDen4Fv0ZhTA8uYpvRQ0z4GETZ+M+SHQz8jGrQujSTHOGkMkL7wLablY
 Tl6vLFYnqRpajpD/ap3ie77Iha8PvnqtFnnXKl+dx93ZjiSkDHdaJtrrpF2bXj8OGFvH
 wx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753273922; x=1753878722;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E16f9yXyg47PgMZfSj8JQG8D3htZTPeYtNlE8lRWRlU=;
 b=YnkBf5VjzbP2h92TwMoYaVw2Q8oTiv83WgUWijFs1lL36cqdWOMaCJXb5eFfLKD7l+
 eiLTNmSvjoa7aCdlEp+zNfRuB2ARQw6N/Ojq7Y9IOZVeqlZdBKHHsXxyj99RlVzd0ldI
 ikQYShDojTTE9ce00cVzTpEt3k8z8ijNBwBdnmWSEtVTPiZsOcw7TCCCJwmCJ1U2OpDL
 54D/hRnNF24ALI8KuI6dj/uj0Oetq3klcpS/r2hkPBp5NMwzeN7I34Krerguiw3bCh3s
 /dSWk16c2GXVvzwWU3J3EZg8cVHWNmfHTiCP06IrcM69bK+8b3f6ZU4CfFc71tIr7x4h
 OP7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKBynMa5t3XKhUlJ4x+DkdxVbrNjFZFe5slvTtiWklIk2r4+AuughWMV4XoWnGX3HVIrhyl/dyq7/q@nongnu.org
X-Gm-Message-State: AOJu0YwGAiZTP44i6FOnq1w9g7R4Wi0xkVPDgoTAyEw2vBJBk7eAAXcW
 +I0HAa39J6xEHWmC3sdFVHBY3dLYT5RbJN3GakC0diL7kJtd8jDmqgHN89y7d+3iqWI=
X-Gm-Gg: ASbGncspRcKXeUZt2/pAGb5JQqqDmdSFu6y650P/xYkg57b991Ctqv3dMFiMLTr8TAr
 chXfSRONSk1HgA4swM3VqHKGzZL5lvx5AfOHtypY/Ewxebdrn8ssOatXegMvQ71o9oUtWiNHA9j
 U2iYmFiwJVGe6MSC52hipJCYzlpyQOTwnmwG9jgWFNpxxLk7yNu3KRfAFacXwpFKW0QbRIf2PYu
 WYZbRalkHjHKbmpjf6SbxFbQhpaSYhnLgnhcW7TGhW0ULklVxwVkdfoq0/MB6akhnrj0WMVOoG6
 3tmBePjn6oS2yG3Mu9WxOt9RqtDvAERjOIjR3G9fPQ2HUORP+noobWSfdrbz9DsgcKltfFbxL/n
 Zas7RVUqSInsGd89SpRv/dmJmxDT0CzMyOFJ7V90rjQDg4dTHD32ppIyu3MDFQRqmbZEJCZs=
X-Google-Smtp-Source: AGHT+IE0+sqa6LADhyC2sVpaMPARbW1giz/7bh7kJq9dgChdgFVJAmfLtGsUsIRHn/OemEsA4NRQSg==
X-Received: by 2002:a05:600c:8718:b0:456:43c:dcdc with SMTP id
 5b1f17b1804b1-45868d7ec4amr19568975e9.33.1753273921735; 
 Wed, 23 Jul 2025 05:32:01 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4586919f07bsm21329505e9.16.2025.07.23.05.32.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jul 2025 05:32:01 -0700 (PDT)
Message-ID: <f35f2cfc-2bc1-40b4-8dd2-f7ac34cbd317@linaro.org>
Date: Wed, 23 Jul 2025 14:32:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] memory.c: improve refcounting for RAM vs MMIO regions
To: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, peterx@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
References: <20250723121920.1184928-1-aesteve@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250723121920.1184928-1-aesteve@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Hi,

On 23/7/25 14:19, Albert Esteve wrote:
> In the last version of the SHMEM MAP/UNMAP [1] there was a
> comment [2] from Stefan about the lifecycle of the memory
> regions.
> 
> After some discussion, David Hildenbrand proposed
> to detect RAM regions and handle refcounting differently
> to clear the initial concern. This RFC patch is
> meant for gathering feedback from others
> (i.e., Paolo Bonzini and Peter Xu).
> 
> [1] https://patchwork.ozlabs.org/project/qemu-devel/list/?series=460121
> [2] https://patchwork.ozlabs.org/comment/3528600/
> 
> ---
> 
> This patch enhances memory_region_ref() and memory_region_unref()
> to handle RAM and MMIO memory regions differently, improving
> reference counting semantics.
> 
> RAM regions now reference/unreference the memory region object
> itself, while MMIO continue to reference/unreference the owner
> device as before.
> 
> An additional qtest has been added to stress the memory
> lifecycle. All tests pass as these changes keep backward
> compatibility (prior behaviour is kept for MMIO regions).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com >
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>   system/memory.c            | 22 +++++++++++++----
>   tests/qtest/ivshmem-test.c | 50 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 67 insertions(+), 5 deletions(-)
> 
> diff --git a/system/memory.c b/system/memory.c
> index 5646547940..48ab6e5592 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -1826,6 +1826,14 @@ Object *memory_region_owner(MemoryRegion *mr)
>   
>   void memory_region_ref(MemoryRegion *mr)
>   {
> +    /* Regions without an owner are considered static. */
> +    if (!mr || !mr->owner) {
> +        return;
> +    }
> +    if (mr->ram) {
> +        object_ref(OBJECT(mr));
> +        return;
> +    }
>       /* MMIO callbacks most likely will access data that belongs
>        * to the owner, hence the need to ref/unref the owner whenever
>        * the memory region is in use.
> @@ -1836,16 +1844,20 @@ void memory_region_ref(MemoryRegion *mr)
>        * Memory regions without an owner are supposed to never go away;

What are the use cases for MRs without QOM owner?

>        * we do not ref/unref them because it slows down DMA sensibly.
>        */
> -    if (mr && mr->owner) {
> -        object_ref(mr->owner);
> -    }
> +    object_ref(mr->owner);
>   }
>   
>   void memory_region_unref(MemoryRegion *mr)
>   {
> -    if (mr && mr->owner) {
> -        object_unref(mr->owner);
> +    /* Regions without an owner are considered static. */
> +    if (!mr || !mr->owner) {
> +        return;
> +    }
> +    if (mr->ram) {
> +        object_unref(OBJECT(mr));
> +        return;
>       }
> +    object_unref(mr->owner);
>   }

