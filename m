Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77703D1D892
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 09:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR5bC-0005wH-9q; Thu, 04 Dec 2025 04:26:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vR5bA-0005vs-3Z
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 04:26:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vR5b8-0006mG-Ge
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 04:26:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764840361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jCZ6WboA9UsLy0y9O5DsJPro6lbWYhRRzq8S4B7GDGQ=;
 b=XSjGRsGasiljga7M+rU6oe+MolfPoub3eZivviNdbKXM12pxHmvpMgP3ZIselyh+yK63Fc
 H8xFGAjeGZCm4c1tBxzcjfwpQZHuFZYw+JmZZRw3GpW0XkPdrpF/u6N0wNne7G+GqdM9LL
 wHulaLTmVaLgVil7bHW4vMwJqNt5vV4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-0O5Bg8nlMra84CyV0PMM3Q-1; Thu, 04 Dec 2025 04:25:49 -0500
X-MC-Unique: 0O5Bg8nlMra84CyV0PMM3Q-1
X-Mimecast-MFC-AGG-ID: 0O5Bg8nlMra84CyV0PMM3Q_1764840348
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42b478551a6so355025f8f.1
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 01:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764840348; x=1765445148; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=jCZ6WboA9UsLy0y9O5DsJPro6lbWYhRRzq8S4B7GDGQ=;
 b=I4HFL1Yp1rXvash8CuicKnQTadVyd7LBKrC86/McGr8sSqv84EJx5OEupU/LhuFHZQ
 NdE9KeslmP8NHIenOnLp8V+I1BLaeR2Fc/WjesDqaZmy+XcmjumBgbTXO5aTaOCBdmA3
 xnsYZ7rP4HVHsyokRajAjwaxol8FHSgUlXS9rZJq01++57JSSCt24DkgUeCsx8mYvlYe
 4LiTOZ7Mog1xmkTbvMqdw/6Ir+1JlPNXpBphcJ7TZOQo56DowS1G8FtxPRDigxm4WHnc
 85TbLBX4FhKdV76BLRZmdM73GUeneR6tdYUVkG8GED8/jSjARgkL7frs/q8NaYXPLBxr
 cXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764840348; x=1765445148;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jCZ6WboA9UsLy0y9O5DsJPro6lbWYhRRzq8S4B7GDGQ=;
 b=RzvIEqrK/JZGs5folC6F5shhUGTyHFBm7UqyQwuhgsfpyEkKAvfvPrSsujhOlFMrky
 VTwV/BOsCWmitY4IiQTzt9Bua5vm6GIdXmaGVQ+U5I1lBYfvg9bagVv8vuaexWy+YwVZ
 sKVD0hyhTEqtb8/IEsYs/PTjaaxqGuEUqSAAyc6sdAv/bSZo936cxVzaZVGw2UJ4CFlk
 90NF2fDFRElyHlhrEdKyPpLJZyoC8P+66y60tYD68lEt+MPXjq0edULQBpwotfK8zRhS
 r06ThR3mp1G3/sitoS7kfMqGwiBLc+HM5urvfJjxXTticrnY5bxIR5gtfmdl3dPYE7sV
 8Bgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUET83DE/7jZROhSIe/kAvoOO9BVV//RzMJo3wQBI89NB/UKZXx3bB0pyMmlOcn+mzkWAKTh4ivqd8m@nongnu.org
X-Gm-Message-State: AOJu0YyojLZR6vaI3sDmviAYjpEGes9RJQIBFFr8nxTiRU+65rWG/6aE
 D8eIuKFuzVwPxuoPG6gsU1SctXUyhQ54boXU/dZsl3urJnDs9uBtcezW9HX4WePK8Wd2iA4Sqxf
 2yFzJ5JpvU6MNv0AkpM4kksTwL63+cr2GH/OWJSB9HoJFdDm/9zIf4hOR
X-Gm-Gg: ASbGncu20dgHkgGKvU57Szc4uEjdw3v8E2hOZZILuJf6zBg1UTSBOaXjox/elzLmzcZ
 D4wul87RRdI4eaR+uDaBPx9q7nTdgqtToKHn7fogUByYWHcgLr7CBV45UoqF5DmEdUt7Shsyf2s
 tXBGPvpzDUIooxjvuN7zyDIiKhBnaeScjH3wxLOFIsdYfGvQpyubNF2ljMgwpnondrRp+a4bLRm
 Pw1+HYUW1gK14unJtqD0NsES5YMdGipeSVRMOMlWFPR0EOyFehSHONTD51O33mNwnBPZwL/8J+M
 D9czoUtI57GC6xDza6Six1wTMX2y9D8cXVO2kcrtXaHtNrj+nXXsC/Wgyjax73TtvDxlr2PAVtp
 H/UFXD0ugchk65O4B+6d6sqH/kRPXiiaNaozQ3dr//IgMP9HieNpUrXwdH1CE8YZf2siy5C+3Y5
 wWGVn+9ykzKN+wHrw=
X-Received: by 2002:a05:6000:2484:b0:42b:3e20:f1b3 with SMTP id
 ffacd0b85a97d-42f73173f46mr6063499f8f.9.1764840347812; 
 Thu, 04 Dec 2025 01:25:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7qdi3Qqo0V0aByWFEl71ReUj4psU4+prKoECGOsqS2HFZnHJ6Bzo3ZIlQv+rUUMkbEyxuGw==
X-Received: by 2002:a05:6000:2484:b0:42b:3e20:f1b3 with SMTP id
 ffacd0b85a97d-42f73173f46mr6063472f8f.9.1764840347427; 
 Thu, 04 Dec 2025 01:25:47 -0800 (PST)
Received: from [192.168.10.81] ([176.206.119.13])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-42f7d222506sm2450700f8f.28.2025.12.04.01.25.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 01:25:46 -0800 (PST)
Message-ID: <19f01d31-01f5-458e-873b-4859e2f8b3d9@redhat.com>
Date: Thu, 4 Dec 2025 10:25:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] block: reduce files included by block/aio.h
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.omc
References: <20251203185133.2458207-1-pbonzini@redhat.com>
 <20251203185133.2458207-4-pbonzini@redhat.com>
 <bbbf42c5-98c6-4f24-929b-7bbb2853f5c9@linaro.org>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <bbbf42c5-98c6-4f24-929b-7bbb2853f5c9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/4/25 09:35, Philippe Mathieu-Daudé wrote:
> On 3/12/25 19:51, Paolo Bonzini wrote:
>> Avoid including all of qdev everywhere (the hw/core/qdev.h header in fact
>> brings in a lot more headers too), instead declare a couple structs for
>> which only a pointer type is needed.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   include/block/aio.h                |  7 +++----
>>   include/block/block-copy.h         |  1 +
>>   include/block/block-global-state.h |  1 +
>>   include/block/block-io.h           |  1 +
>>   include/block/dirty-bitmap.h       |  1 +
>>   include/hw/core/qdev.h             |  6 +-----
>>   include/qemu/job.h                 |  1 +
>>   include/qemu/main-loop.h           |  2 +-
>>   include/qemu/mem-reentrancy.h      | 10 ++++++++++
>>   net/net.c                          |  1 +
>>   util/async.c                       |  1 +
>>   11 files changed, 22 insertions(+), 10 deletions(-)
>>   create mode 100644 include/qemu/mem-reentrancy.h
>>
>> diff --git a/include/block/aio.h b/include/block/aio.h
>> index 59c56d695ee..8cca2360d1a 100644
>> --- a/include/block/aio.h
>> +++ b/include/block/aio.h
>> @@ -23,9 +23,8 @@
>>   #include "qemu/lockcnt.h"
>>   #include "qemu/thread.h"
>>   #include "qemu/timer.h"
>> -#include "block/graph-lock.h"
>> -#include "hw/core/qdev.h"
>> +struct MemReentrancyGuard;
>>   typedef struct AioHandler AioHandler;
>>   typedef QLIST_HEAD(, AioHandler) AioHandlerList;
>> @@ -211,7 +210,7 @@ struct AioContext {
>>        * of nodes and edges from block graph while some
>>        * other thread is traversing it.
>>        */
>> -    BdrvGraphRWlock *bdrv_graph;
>> +    struct BdrvGraphRWlock *bdrv_graph;
>>       /* The list of registered AIO handlers.  Protected by ctx- 
>> >list_lock. */
>>       AioHandlerList aio_handlers;
>> @@ -393,7 +392,7 @@ void aio_bh_schedule_oneshot_full(AioContext *ctx, 
>> QEMUBHFunc *cb, void *opaque,
>>    * device-reentrancy issues
>>    */
>>   QEMUBH *aio_bh_new_full(AioContext *ctx, QEMUBHFunc *cb, void *opaque,
>> -                        const char *name, MemReentrancyGuard 
>> *reentrancy_guard);
>> +                        const char *name, struct MemReentrancyGuard 
>> *reentrancy_guard);
> 
> I suppose these changes were before you move the declarations to their
> own "qemu/mem-reentrancy.h" header?

Yes, but also qemu/mem-reentrancy.h is not included here.

Paolo


