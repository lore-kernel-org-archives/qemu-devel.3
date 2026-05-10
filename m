Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66682CD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 16:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM6lV-0006AE-DY; Sun, 10 May 2026 12:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wM6lR-00069g-R3
 for qemu-devel@nongnu.org; Sun, 10 May 2026 12:12:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wM6lQ-0002TI-Bg
 for qemu-devel@nongnu.org; Sun, 10 May 2026 12:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778429538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HkQWUcM+ITwnxDKblycpj8OkEki5YrXO4oNe4MWcU2I=;
 b=FhU7WSwH4zkO1Ks+gTzVUYfz2HZubUnt1C/fhIP3I2n0xzeBq9W/upwaqzC8dObo4axAJQ
 NXbrwVAZNye11NX5eUQuZ7yojS+Vm+Pnpf4cjUpdWmm/JN2dgKrSLGSVQ5NC53MlOyknKO
 yzfDKSWAnwgSOUwL+19Tm4kCRWzgNcg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-BCvdihFyN3WXt06sI7hZqg-1; Sun, 10 May 2026 12:12:16 -0400
X-MC-Unique: BCvdihFyN3WXt06sI7hZqg-1
X-Mimecast-MFC-AGG-ID: BCvdihFyN3WXt06sI7hZqg_1778429535
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48d035e8593so23049115e9.0
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 09:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778429535; x=1779034335; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=HkQWUcM+ITwnxDKblycpj8OkEki5YrXO4oNe4MWcU2I=;
 b=mh6eiFv04Qv6ZYWBUZa+FSZHxbBcjDhDSesZSyMv50qiukQKxZPO+kx4FgxgAsG3jf
 q4ASdKJFFvrQh2r0Jo3MP4n1qPfOOEwTdAPVrgpzzYQS0re8H/6pXJsWw4eMWnQa4SUy
 0bfIz8ygnzRzGHScxaZsamKN6G/+BHgBc3HNqZYufvcI7eDBKvKWyvZi11XxO3AVgoGY
 QXGESfKmYnKnvVuTsdW8gWXhv3fUC1qCBcqekpFP/ls9XsI9RygctbNtYtt0ujQwtGS4
 2CsZb8qX/93nkQLFGZSKwkv6mXEtaSIblKVYcppCiTP93DWkKJ/6j1ILCJGjlEkcCbOg
 fbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778429535; x=1779034335;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HkQWUcM+ITwnxDKblycpj8OkEki5YrXO4oNe4MWcU2I=;
 b=Z69S9nbnG89UO6umMBD0Hx8tfgXX4C8JP7HV0GXxIHrmzKT3svi3uQKucLT1QcWf+h
 R/b48pxMTb8VBDYK56eVqFV5+IupUSrHsK/vlQOCWWdv5UchExvXlUmnpdYq3/pxVMup
 1Qg+xbW/BApLk4RrcDv8QtmTi56+ZGE4DnjdYqXA1KvPxME0mGGxajbrqKFTEUoqYEyH
 CmByoc4gFFCUNOYJC1NJukyeO+4Xy60x2JR4HfhNNG9WcSYwfJzl2zBdsP4f58lqH1Qz
 pQ2yeAac83e7H4cJufzLzWooZzkATg5SfZ73jrSCTki2+qY/LUA0cUVy6FzEaBPeEgSR
 T6lg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ALv5hYEmksj66SJbWfjkRxuhuke3psqyHNrw5nWX1P7utska1kR2Pw7Wo040Sopi+D8rRgybBIBxO@nongnu.org
X-Gm-Message-State: AOJu0YzFP5/ePVFURyr3qDxBNCcSbMx5FyaBeGIRVwP8Hg29WgJf6uaN
 RNuIK6gkdoCd8spU5+MStGgTha8uTRBI+W2heOGsHJVwWQsXNsATTaJrcNzJbC2M1uR4ZMBqPL3
 7LQ4kLmvUDrfJOp8NaKLsc+h98Uev+QiunqLR0SO0dDfuTTdPYZRXUdlo
X-Gm-Gg: Acq92OHlgSWo8eYv7y08jJkGAkJjhfDGJqHpXtViaKHe2jZ+reGCliBdR9vCk7ERRds
 5btnCDuvKs8+MATNHpQgtl8J768CrbV/bRvCfuz09CIgpOYLKJJmTKJCXMTSSajwRkhP2+MRHOL
 XniyhS5RQtavJlWuqIWqjJ3JMMIEKheZ1EBdP2WQXb8CwSwgslVbCXhAiUrrUteykDI2VNnpbQf
 njGybXe7X0rgSPY4GClvgnGuPfCMYeOSrkHxCO/tLtZ1dZvxOuboaAtKQtU45Mk9JgriWEbp5/i
 KpWhuW4KmxSKsK9JUtUMIb8qCjf+K58T+wFr9qL6ERUO7mTNzw0n6Dr5oTCNYrbfAazsaAepIL2
 V6D6cuREbN4344NB4I+PnEvT+PP4FoPgDn1k2aEgZ9AphvOp1vilaVfZu1xIh
X-Received: by 2002:a05:600c:8594:b0:485:39b2:a47c with SMTP id
 5b1f17b1804b1-48e676b65a9mr130457915e9.25.1778429535156; 
 Sun, 10 May 2026 09:12:15 -0700 (PDT)
X-Received: by 2002:a05:600c:8594:b0:485:39b2:a47c with SMTP id
 5b1f17b1804b1-48e676b65a9mr130457615e9.25.1778429534693; 
 Sun, 10 May 2026 09:12:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e6d8d6988sm44203395e9.5.2026.05.10.09.12.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 May 2026 09:12:14 -0700 (PDT)
Message-ID: <62e9d0a9-e787-47dd-9a6c-da520a587e09@redhat.com>
Date: Sun, 10 May 2026 18:12:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/pci: Replace abort() with g_assert_not_reached()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>
References: <20260506152353.1657838-1-clg@redhat.com>
 <7bfd11f9-66be-4e4f-8e9e-a031d848f890@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <7bfd11f9-66be-4e4f-8e9e-a031d848f890@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/7/26 15:16, Philippe Mathieu-Daudé wrote:
> On 6/5/26 17:23, Cédric Le Goater wrote:
>> This check was originally introduced in commit b3ebc10c373e
>> ("vfio-pci: Add debug config options to disable MSI/X KVM support") as
>> part of a debug block to retrieve the MSI/MSIX message, and was later
>> moved by commit 0de70dc7bab1 ("vfio/pci: Rename MSI/X functions for
>> easier tracing") into the main interrupt handling path, becoming
>> production code.
>>
>> Under normal conditions, this code path cannot be reached because the
>> BQL serializes all handler registration, vdev->interrupt updates, and
>> handler removal. Replace abort() with g_assert_not_reached(), which is
>> preferred nowdays, and add a comment clarifying the purpose.
>>
>> Cc: Alex Williamson <alex@shazbot.org>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/vfio/pci.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 09acd3f6082b0a9c5223780bf7e9847b57424cf7..7ca2ff4e7c1cb570cd60d35454b33b5506dae36e 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -453,7 +453,12 @@ static void vfio_msi_interrupt(void *opaque)
>>           get_msg = msi_get_message;
>>           notify = msi_notify;
>>       } else {
>> -        abort();
>> +        /*
>> +         * Interrupt state transitions (MSI/MSI-X -> NONE/INTx) are
>> +         * protected by the BQL, and eventfd handlers are strictly
>> +         * unregistered before vdev->interrupt is modified.
>> +         */
>> +        g_assert_not_reached();
>>       }
> 
> Could be more readable using switch(vdev->interrupt).
> 

I agree. But let's have another patch for it if you don't mind.
This change is about the rational for the abort() and it was
reported to the security list.

Thanks,

C.


