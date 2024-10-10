Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635F0CF11D0
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 12:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syrtH-0004qk-JQ; Thu, 10 Oct 2024 08:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1syrrv-0002ph-Dn
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 08:02:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1syrrt-0004l1-1R
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 08:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728561727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ipx88RwMSc0im61IFvJ03sgwIeHb/RHoHcAggHp3Tuw=;
 b=iXUrWFtcHfgZ3OHWeBWYnOMP/eE3cj4cilzHrHrWsRRn5gTVm4NQisV/sdRvyF0IpYiDdW
 YQXMTFqwReY9s63L3d2zt5kEFZHGT/IUGcIduIvCNrn9G7SfvMfpHjaD17bGHpyFmgr5P3
 xhz7xSH9RKpxcVVh8CXXB5djnvw5lVA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-Bce9c5WwMrejvsY4iYAoYw-1; Thu, 10 Oct 2024 08:02:03 -0400
X-MC-Unique: Bce9c5WwMrejvsY4iYAoYw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5399524dfbcso837553e87.2
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 05:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728561722; x=1729166522;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ipx88RwMSc0im61IFvJ03sgwIeHb/RHoHcAggHp3Tuw=;
 b=v2HedtxEduZLnRkaRMH1LYb3Ux64PCnLjeLxRANDRs5TjW7uPdttti1xWA94aiWYav
 9TFaMNUllwRrY5ewvi3MDT5QCnkN5OU+Elis5zER2wo76MtKJWG68+g3aRFdhygBegq3
 RfHfRFPtov0AEkZBuZzz96B7slUpNXex/vPilqI8kqi5dyfE5dw0KDONHt5owwBtP4sn
 lhwKXorGG9KwHbKIoz90kgCxDG/Ohsw2a2iipBhJ5idclpp5RaC7rZG6yxJEvbz/GKQA
 2a/ht9BzwuD8I9dOZfZq6gDTQZKVfDa9wYh/VIamwZi2/LSF0h45w8ZXFvHa2zTH6SUN
 NpKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkRwMqVzZNG0zwe/mP/+1iFrXsoa3zFF1T8W3Bt4gYB+N6tSAndc0ZbgZnMhFopPEOo+a+kY10o/7U@nongnu.org
X-Gm-Message-State: AOJu0YzFX5+DpIpXytLUo6iba174gTr9bF70+uwZVdEhElrqd/M0NYuJ
 IVlO1HGBM15LXaXU3GXWOXWOjTqtMUJ4O94VEyyX1qZaZGN5V0yQXmxqfhpC8JDvixXN5IWOnMS
 8PE+1kMtMErsDLO19ojsvYjjt+7oyTPIjg/R8m+vcyWM1OEe/2Vi0
X-Received: by 2002:a05:6512:68f:b0:539:9f52:9e6 with SMTP id
 2adb3069b0e04-539c49728d1mr3817432e87.54.1728561722165; 
 Thu, 10 Oct 2024 05:02:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0ay1XvJb+nDGf+w13Bqmls2zjZLK/YvAiiFLO1eg4xUtB4cLT91W7XEKkpbmg64pbkgsrhQ==
X-Received: by 2002:a05:6512:68f:b0:539:9f52:9e6 with SMTP id
 2adb3069b0e04-539c49728d1mr3817371e87.54.1728561721245; 
 Thu, 10 Oct 2024 05:02:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431183567a6sm14190475e9.35.2024.10.10.05.02.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2024 05:02:00 -0700 (PDT)
Message-ID: <5f2e4501-e018-45dc-9288-f2bdf776cdac@redhat.com>
Date: Thu, 10 Oct 2024 14:01:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/16] crypto/hash-nettle: Implement new hash API
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, kris.conklin@seagate.com, jonathan.henze@seagate.com,
 evan.burgess@seagate.com, peter.maydell@linaro.org,
 Alejandro Zeise <alejandro.zeise@seagate.com>
References: <20241008075724.2772149-1-clg@redhat.com>
 <20241008075724.2772149-6-clg@redhat.com> <ZwexMpP8SidNul6G@redhat.com>
 <Zwe91xD7yeSoiCB4@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <Zwe91xD7yeSoiCB4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 10/10/24 13:43, Daniel P. Berrangé wrote:
> On Thu, Oct 10, 2024 at 11:49:22AM +0100, Daniel P. Berrangé wrote:
>> On Tue, Oct 08, 2024 at 09:57:12AM +0200, Cédric Le Goater wrote:
>>> From: Alejandro Zeise <alejandro.zeise@seagate.com>
>>>
>>> Implements the new hashing API in the nettle hash driver.
>>> Supports creating/destroying a context, updating the context
>>> with input data and obtaining an output hash.
>>>
>>> Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
>>> [ clg: - Dropped qcrypto_hash_supports() in qcrypto_nettle_hash_new() ]
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>>   crypto/hash-nettle.c | 70 ++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 70 insertions(+)
>>
>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>>
>>>
>>> diff --git a/crypto/hash-nettle.c b/crypto/hash-nettle.c
>>> index 8b08a9c67531..07e18ce26cba 100644
>>> --- a/crypto/hash-nettle.c
>>> +++ b/crypto/hash-nettle.c
>>
>>> +static
>>> +int qcrypto_nettle_hash_update(QCryptoHash *hash,
>>> +                               const struct iovec *iov,
>>> +                               size_t niov,
>>> +                               Error **errp)
>>> +{
>>> +    union qcrypto_hash_ctx *ctx = hash->opaque;
>>> +
>>> +    for (int i = 0; i < niov; i++) {
>>> +        /*
>>> +         * Some versions of nettle have functions
>>> +         * declared with 'int' instead of 'size_t'
>>> +         * so to be safe avoid writing more than
>>> +         * UINT_MAX bytes at a time
>>> +         */
>>
>> This is copying the pre-existing code, and I've just
>> realized this is now obsolete. We bumped min nettle
>> to 3.4 ages ago and >= 3.0 is using size_t, so we can
>> simplify now.
>>
>> No need to change this though. I'll do that as a
>> distinct patch to make it a visible change.
>>
>>> +        size_t len = iov[i].iov_len;
>>> +        uint8_t *base = iov[i].iov_base;
>>> +        while (len) {
>>> +            size_t shortlen = MIN(len, UINT_MAX);
>>> +            qcrypto_hash_alg_map[hash->alg].write(ctx, len, base);
>>> +            len -= shortlen;
>>> +            base += len;
>>> +        }
>>> +    }
>>> +
>>> +    return 0;
>>> +}
> 
> I'm going to add the following patch on the end of your series:
> 
> commit 638ae66c176f8077ccaac10028812e177224a99f
> Author: Daniel P. Berrangé <berrange@redhat.com>
> Date:   Thu Oct 10 12:40:49 2024 +0100
> 
>      crypto: drop obsolete back compat logic for old nettle
>      
>      The nettle 2.x series declared all the hash functions with 'int' for
>      the data size. Since we dropped support for anything older than 3.4
>      we can assume nettle is using 'size_t' and thus avoid the back compat
>      looping logic.
>      
>      Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> diff --git a/crypto/hash-nettle.c b/crypto/hash-nettle.c
> index 570ce8a645..3b847aa60e 100644
> --- a/crypto/hash-nettle.c
> +++ b/crypto/hash-nettle.c
> @@ -135,20 +135,9 @@ int qcrypto_nettle_hash_update(QCryptoHash *hash,
>       union qcrypto_hash_ctx *ctx = hash->opaque;
>   
>       for (int i = 0; i < niov; i++) {
> -        /*
> -         * Some versions of nettle have functions
> -         * declared with 'int' instead of 'size_t'
> -         * so to be safe avoid writing more than
> -         * UINT_MAX bytes at a time
> -         */
> -        size_t len = iov[i].iov_len;
> -        uint8_t *base = iov[i].iov_base;
> -        while (len) {
> -            size_t shortlen = MIN(len, UINT_MAX);
> -            qcrypto_hash_alg_map[hash->alg].write(ctx, len, base);
> -            len -= shortlen;
> -            base += len;
> -        }
> +        qcrypto_hash_alg_map[hash->alg].write(ctx,
> +                                              iov[i].iov_len,
> +                                              iov[i].iov_base);
>       }
>   
>       return 0;



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


