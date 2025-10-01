Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051AECCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 21:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v43z3-0000tV-KN; Wed, 01 Oct 2025 17:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v43yw-0000s3-UU
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:03:27 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v43yg-00048z-58
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:03:22 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-78a9793aa09so464306b3a.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 14:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759352579; x=1759957379; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TVyQQB+Wmr9wiHfhpv1Q0vD0koj+NE+rQBNo24Jg+8c=;
 b=UQbR08FXQM6cgjIEGwoeDPqbjSKxjdcUiv8oCpgI0GqOz09EVyLkG/IbQb2KRD3E1D
 aJA1LasFHdZK1ZlthnX0WcJtxRTQKkRLGxh4raXV+igMfd9SrsU5QOiM5tcKQZKkviZC
 N3KvEYYKn4hlu+e2xZm5fPKNAEXOkAse/5blWZbqn1+prr023UZXNQdPLrM4ViD4T1Sb
 RaoHHBJJhYlVrI/xImb/IXMSLPwoWcAYBsSKD0XeUWRwpoeViiWihGEJPkNIzpVfNF0c
 kq0ePe3FFY4pidhkmGP/LGbKrUO4Dty63IY4RwUyMfvX2VManLReMQi02UZO3ofA1bBT
 Y9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759352579; x=1759957379;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TVyQQB+Wmr9wiHfhpv1Q0vD0koj+NE+rQBNo24Jg+8c=;
 b=B7eQuRm+V649/3n7Z0+1dRWkitZoXzZ8axZSELdDE0TJwEVRH46vkGBKfqOSC/LkXT
 5TnhOQIhUDM071y1kI6nekM051gpX9NAYxZ7EMO4hNhAWCQs4pD9c3utoF6BypQnS39p
 h7fEsz4DkSxbpE6diB4JcGfrH+1usl6j3Tmf/8wXzK/bZYlAh3kgks9IiPomjMLGoMn2
 K5+Zt3pndzFQrFrtqLC9VM3aeTrH4yVUqPAxWTL1GzDUHjaR+0BN5dsyyF8XwLOeke67
 w9gG+zYaqXQj/eZX6wwW59pKe9iFiJTYWA4gLjjccbTjNpy6IXci1t9W+XNPkOHF/Sdc
 JfwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkKkV8+A/JmQHkLBAJ39rXl7tThLsa8rm2pAQvuoToWe1omIfxof8mGTIE8/gKlTQU7kFfKRvJVnf+@nongnu.org
X-Gm-Message-State: AOJu0YzpADZQabLm/MoQLj9TNjkr8h05JnH3gqJXb3dx5dxno1d9fC7b
 dewaourbeYGpLU76MXF5OMJc9csWN2nSt8Pg34gQkzqTWw3arWwQ67LZB1obkrpe4Sk=
X-Gm-Gg: ASbGncsDew+aR/vNZ8i+xdtwKqrUnPhBvzma4ha4QbzrlZHJ3KnOV6R7aAnfQjNGMUB
 L5IzXs95w8HnlCqsY8Pc9Ryom3Z+YjrwVmtuoH32tRuWzl2hqwR7qwDalP3bJpqaEVncsJkQ8Z6
 iP/deE82oTreDz9K3vzW5gfEA4YslHmniGtG5Ay44cZr23/WW7iUAo3A4OF21pFXRguF1B7P1Iw
 Kpb9NgzgMnv2NrLv7OEE0S3mdJ5bCp279Ti0cy+IHSjxZ9tKJSnNoWvdHYcX9a9GrbucPhso8iP
 aklq6FlS5OulDvaf0Suy3zSH+6hVqB1aIJ2iPmKk95vQdYR69DPRDkURCuttwKoj8rgf9Ra1nJa
 Z6Bav/n9L6y3tcqw3AujEFhm7pHFkZmABkUAuiix8XVQ/5WRnoLKXX+AeHQ3y
X-Google-Smtp-Source: AGHT+IF7yK2d5OhlOk2zuF/JBEnY8Tk0IxeJcaQU8ZwgxhbKMJ9tPMbVc9dRybkbnnQOcP+NOcEr1g==
X-Received: by 2002:a05:6a20:3946:b0:2e3:a914:aa93 with SMTP id
 adf61e73a8af0-321e477bf0dmr6715698637.30.1759352578852; 
 Wed, 01 Oct 2025 14:02:58 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b02094847sm561906b3a.89.2025.10.01.14.02.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 14:02:58 -0700 (PDT)
Message-ID: <7974c867-b7c4-470a-afaa-87583a20d467@linaro.org>
Date: Wed, 1 Oct 2025 14:02:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] system/ramblock: Remove obsolete comment
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Peter Xu <peterx@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>
References: <20251001164456.3230-1-philmd@linaro.org>
 <20251001164456.3230-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251001164456.3230-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/1/25 09:44, Philippe Mathieu-Daudé wrote:
> This comment was added almost 5 years ago in commit 41aa4e9fd84
> ("ram_addr: Split RAMBlock definition"). Clearly it got ignored:
> 
>    $ git grep -l system/ramblock.h
>    hw/display/virtio-gpu-udmabuf.c
>    hw/hyperv/hv-balloon.c
>    hw/virtio/vhost-user.c
>    migration/dirtyrate.c
>    migration/file.c
>    migration/multifd-nocomp.c
>    migration/multifd-qatzip.c
>    migration/multifd-qpl.c
>    migration/multifd-uadk.c
>    migration/multifd-zero-page.c
>    migration/multifd-zlib.c
>    migration/multifd-zstd.c
>    migration/multifd.c
>    migration/postcopy-ram.c
>    system/ram-block-attributes.c
>    target/i386/kvm/tdx.c
>    tests/qtest/fuzz/generic_fuzz.c
> 
> At this point it seems saner to just remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>   include/system/ramblock.h | 5 -----
>   1 file changed, 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

