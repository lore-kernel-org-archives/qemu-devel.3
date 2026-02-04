Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6642E9D410
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 16:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnft5-0003eo-8H; Wed, 04 Feb 2026 11:37:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnft2-0003eB-UE
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:37:53 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnfsx-00088d-QI
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:37:50 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2a9004e4239so192355ad.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 08:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770223066; x=1770827866; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FXd3p3lA1NPldpSgA9SXBOFV8bUiW1YgbJf5mBWw0yc=;
 b=NpWAFhGYXTFauUtNcrHeJH1qx6ntzUO7+pJEVm/FSlka4/RdH1DfP3Kmy3TJW/2447
 QuywhMsVo679Jp/IDx5wA1NSnMAk7+zfegFdGhvKts0q6I8OzL54czWN5hne8o3NEN3V
 S3nJ4rMgEwj14piv/oU3Ij6MiS416RjBJlDZb8qH6h421bql5RI2mlhlSWCMeD+uCT1Y
 lDrlRRlTzR4kEcAnbPol+dyKqq56f6KbwfWZXFzjksthE9mi+rVpUmxF5LLoraKz3/XO
 a5galxcRbnPuutaOuyB9RlleA7Tn14mbUuw2zvNYRBQ8XRmvtaFID4NAGs1TnnfTV2/f
 qiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770223066; x=1770827866;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FXd3p3lA1NPldpSgA9SXBOFV8bUiW1YgbJf5mBWw0yc=;
 b=BVOo3YE4M4gS0UbB0f7v5oS5Jt++GY7vGtB/jViBgOgZHpPzT3WT4hl6ufO0l6X5i3
 BfE+3UQgRuDkPRQTAdSohLjGwG1SkwnqClMDANgwnnhY69ay6yzpblnczQvPhyZMl1+0
 umqBqln1HxzuBuiRIjal5Nt+XByUqX21hffFX2XxQJyQ/lXxCtIfpvkp28b7VJJFhHFz
 NLSIl9d0jF9KVDki9FJVB1LzYInAKfI7DaUvet81OqQjVNAnh8VCxSme2X7ZNEB9POjo
 Hcswqb4oqCo5z/Ur5n5jbr5PHxCQ3U9Ued1sbC4XmdkC/oNzEcjEqD4eYbGOMLl4yRwt
 zDkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvr25g3urTfi4WLnVtAynY9Xf42pHnEtaw/3Do8PztcpKanX0MShsXn3zyBGtqiVsiT1Jjj1Mq3HyW@nongnu.org
X-Gm-Message-State: AOJu0YxBPEcGgg2OTglDevD8CCalBpRpzKjjKYHXzHs1fMg/a66ixqY4
 vwplVsBz+pjuSzPMlhyyKX/9tTLvO7SYOs2XxIhVowchsI2W9snUH3pOgNG/FRjx+uQ=
X-Gm-Gg: AZuq6aKVg9n6C2fd3I/BWAj+jSYcYD9Wpyt4Pt9ZPpNJucguvAUJkiIiV8XCsg2pUvw
 l5sct3Ol89e5iBkglIN73TivnaEZI/R5ydlYQb+9uUbMQStrCYRhe9IGhi58QjgIyxfhgOaMGwJ
 01v3W0yRikwsqOiQtCWut668IONDqg5Cy+ynmb3gd2DUTOPDWwcCfBuRRHVd1iJNba4OtxBx/tv
 pHYwbHzFXLYfBIqrK6jLyomdh0fgVS+TUpcAET/13zZ7ntNohRlckgKHUAEpTg6i0AYo0CkxOt/
 FwP2tdMAXAhp7XKGxzc38unt4oY1jWoGmvdnLuNmXeWsjLf8oJk/j7cP2KKiWBGjGmO2c/QGx61
 khwo01Zvq60MNo3RBXkm7QyyApB5RObsPHJYSMwiSkZkHz3riyerpK6oQ8YUzJKzL64ldI5IDb+
 XgQye/HsHM0ndJJs57aM/c34WZnnx1z9u85bhAmWeT2nYNRooiqG0mONcrNgPZqotAcJM=
X-Received: by 2002:a17:903:2c6:b0:29f:2b8a:d3d with SMTP id
 d9443c01a7336-2a933b9d01dmr36926795ad.4.1770223066122; 
 Wed, 04 Feb 2026 08:37:46 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a933898388sm38052075ad.34.2026.02.04.08.37.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 08:37:45 -0800 (PST)
Message-ID: <65f1a050-5822-4025-8292-9ca22062df0c@linaro.org>
Date: Wed, 4 Feb 2026 08:37:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] include/hw/virtio/virtio-access.h: remove target
 specifics define
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20260203205637.3109749-1-pierrick.bouvier@linaro.org>
 <20260203205637.3109749-6-pierrick.bouvier@linaro.org>
 <5b4fca48-2fab-4874-8e0e-4dc8b63087b6@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <5b4fca48-2fab-4874-8e0e-4dc8b63087b6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/3/26 6:10 PM, Richard Henderson wrote:
> On 2/4/26 06:56, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    include/hw/virtio/virtio-access.h | 26 +++++++++++++-------------
>>    1 file changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
>> index f3b4d0075b5..1bea3445979 100644
>> --- a/include/hw/virtio/virtio-access.h
>> +++ b/include/hw/virtio/virtio-access.h
>> @@ -17,27 +17,27 @@
>>    #define QEMU_VIRTIO_ACCESS_H
>>    
>>    #include "exec/hwaddr.h"
>> +#include "qemu/target-info.h"
>>    #include "system/memory_cached.h"
>>    #include "hw/virtio/virtio.h"
>>    #include "hw/virtio/virtio-bus.h"
>>    
>> -#if defined(TARGET_PPC64) || defined(TARGET_ARM)
>> -#define LEGACY_VIRTIO_IS_BIENDIAN 1
>> -#endif
>> -
>>    static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
>>    {
>> -#if defined(LEGACY_VIRTIO_IS_BIENDIAN)
>> -    return virtio_is_big_endian(vdev);
>> -#elif TARGET_BIG_ENDIAN
>> -    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
>> -        /* Devices conforming to VIRTIO 1.0 or later are always LE. */
>> -        return false;
>> +    if (target_ppc64() || target_base_arm()) {
>> +        return virtio_is_big_endian(vdev);
> 
> Why use two predicates like this, effectively calling target_arch() twice?
> Surely it's better to do
>

Yes it can, I simply wrote the simplest change possible. Since this 
function is called only once now at reset time, it definitely looks like 
premature optimization IMHO.

>       switch (target_arch()) {
>       case SYS_EMU_TARGET_ARM:
>       case SYS_EMU_TARGET_AARCH64:
>       case SYS_EMU_TARGET_PPC64:
>           return virtio_is_big_endian(vdev);
>       default:
>           break;
>       }
> 
> Definitely with a comment saying this is about legacy behaviour.
> And does VIRTIO_F_VERSION_1 really not take priority?
>

Not sure about this one, but current implementation has same behaviour 
than previous ifdef based one.
In case that's wrong, I would be happy to change it.

> 
> r~

Regards,
Pierrick

