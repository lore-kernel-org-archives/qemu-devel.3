Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5746E7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJGM-0002am-Sb; Thu, 19 Dec 2024 11:20:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tOHFs-0000d3-SD
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 09:11:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tOHFr-0004ri-0L
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 09:11:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734617513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fJO0rroSqzFiaXw/DNWQ74QMy2uzjYI/dlxWA3m3oW8=;
 b=Hwm/chbSX1pLZJiGq2Jo7JvMKuPGubrnkIAn1juAbq+sAGXmYcnY564UPXRAzQB7cVE3EO
 m/J6UaRLN4Rm6FPdWK/m/7bL5UzMKDjj7pgploLNkQ0QrCqlkW/KzU08IUKJK93+CEjhWy
 CK/xlJgQeR05qNfoezidMReEm61PgHA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-kwlcLUgwOfuV3yf89JZnzA-1; Thu, 19 Dec 2024 09:11:51 -0500
X-MC-Unique: kwlcLUgwOfuV3yf89JZnzA-1
X-Mimecast-MFC-AGG-ID: kwlcLUgwOfuV3yf89JZnzA
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3862f3ccf4fso362238f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 06:11:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734617510; x=1735222310;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=fJO0rroSqzFiaXw/DNWQ74QMy2uzjYI/dlxWA3m3oW8=;
 b=fkk0OaaICG+r+0bxQt4KZFhAin6AUSoB4FsdP7ReBuBCZ0vWRQ/R9NT7qGiyJU90hn
 YtNlVQRVLHyJ9f76tATrawq5jw23oE3gFqCZsFMUB/j4d9UiwdPMahBGt+WRf7nmol5m
 DJbzhYeHXi9tDP5+2/2qVoZ0RDWuw7NhTJ8C4CYkzSrz4Zh2yOzoQ/R2qyhaBvBEB68C
 zEYyWkBdOK0umT4VtnnO/7jnwQUkW/Nd/agmbiqNUrfFS4/toY7Ptord8cBC1i4PZqvZ
 yKv9TCXD5/bEbjG1vmuNqzmsQeROmzCpif9ORnkjj4l1QlainaIBSRW2kmImyHPtaT7A
 jLkA==
X-Gm-Message-State: AOJu0YxZr8pBN44evtEdl7WWBGMZa8uClejpWVNp4E69qKYyWEUQy4V6
 Q/T1G/h9kG9iUYj+tCyynQrpwWebWZ2pAnQtyEEbap3pnnLMxxImd0TaKdWGiqtH5UMcvCKwENh
 35h3wmw7KfOOuEYqT/Q7lTm6AUZ3hWoljPMGeRZmjS7Psh9+HVfZe6WCi8kC4duY=
X-Gm-Gg: ASbGncuQTTYVXRWq8EeDOU0iziuGP5zFrEbsVKEOl6VIPc9vehkPuDjt/yEwHjSSh9Q
 uaUBsxaVYoGQ/x8ZLcFsX8LLu4B8L0KwPUD6OcKPHDm0fQLeCSjkZbuZ1TMCkUjvrwUmKhmhMLJ
 BkFesymmT8DkOz01PYoCOukwTftC5NZoRknxbERDltHgyDAIO/z+kDDoXLhGXT/hKCwNFSBIum/
 DYjdIpEIvlRgs7+CVRBx7PAiSIzjeqqQ5UiN5VnTcvBFu3LiL1qRXeb327u/JToxPV0b/3yJRUn
 fRUwS6Crvp1E7apdCracwK2CXzgpNF1SyMtU+VYuRMRAJkKKIaKiLio0YO4V97NtIxBrSjf6l4b
 o3THs0g==
X-Received: by 2002:a05:6000:400b:b0:385:fc32:1ec6 with SMTP id
 ffacd0b85a97d-388e4dada54mr5974154f8f.50.1734617510211; 
 Thu, 19 Dec 2024 06:11:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2pQvV7ADymR1Aq2PuwZzLotBD/HjHGWP43mL/Em1Frcz+5CSkyYmCQvaMInwmAMXTDVg8rA==
X-Received: by 2002:a05:6000:400b:b0:385:fc32:1ec6 with SMTP id
 ffacd0b85a97d-388e4dada54mr5974129f8f.50.1734617509793; 
 Thu, 19 Dec 2024 06:11:49 -0800 (PST)
Received: from ?IPV6:2003:cb:c749:6600:b73a:466c:e610:686?
 (p200300cbc7496600b73a466ce6100686.dip0.t-ipconnect.de.
 [2003:cb:c749:6600:b73a:466c:e610:686])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b0153asm53314395e9.14.2024.12.19.06.11.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 06:11:48 -0800 (PST)
Message-ID: <10d02197-88a7-4aad-afc3-fe9584a5a458@redhat.com>
Date: Thu, 19 Dec 2024 15:11:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio: reset virtio balloon stats on machine reset
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
References: <20241218172912.4170899-1-berrange@redhat.com>
 <d2730488-8468-4639-876c-18a860c6469e@redhat.com>
 <Z2Qo27nyv0uZkUGT@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z2Qo27nyv0uZkUGT@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 19.12.24 15:08, Daniel P. Berrangé wrote:
> On Thu, Dec 19, 2024 at 02:51:21PM +0100, David Hildenbrand wrote:
>> On 18.12.24 18:29, Daniel P. Berrangé wrote:
>>> When a machine is first booted, all virtio balloon stats are initialized
>>> to their default value -1 (18446744073709551615 when represented as
>>> unsigned).
>>>
>>> They remain that way while the firmware is loading, and early phase of
>>> guest OS boot, until the virtio-balloon driver is activated. Thereafter
>>> the reported stats reflect the guest OS activity.
>>>
>>> When a machine reset is performed, however, the virtio-balloon stats are
>>> left unchanged by QEMU, despite the guest OS no longer updating them,
>>> nor indeed even still existing.
>>>
>>> IOW, the mgmt app keeps getting stale stats until the guest OS starts
>>> once more and loads the virtio-balloon driver (if ever). At that point
>>> the app will see a discontinuity in the reported values as they sudden
>>> jump from the stale value to the new value. This jump is indigituishable
>>> from a valid data update.
>>>
>>> While there is an "last-updated" field to report on the freshness of
>>> the stats, that does not unambiguously tell the mgmt app whether the
>>> stats are still conceptually relevant to the current running workload.
>>>
>>> It is more conceptually useful to reset the stats to their default
>>> values on machine reset, given that the previous guest workload the
>>> stats reflect no longer exists. The mgmt app can now clearly identify
>>> that there are is no stats information available from the current
>>> executing workload.
>>>
>>> The 'last-updated' time is also reset back to 0.
>>>
>>> IOW, on every machine reset, the virtio stats are in the same clean
>>> state they were when the macine first powered on.
>>>
>>> A functional test is added to validate this behaviour with a real
>>> world guest OS.
>>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>
>>> One side-thought I have, is whether it makes sense to add a
>>> 'reset-count' field in the virtio stats, alongside the
>>> 'last-updated' field. While apps can infer a reset from seeing
>>> the stats all go back to their defaults, an explicit flag is
>>> simpler...
>>>
>>>    MAINTAINERS                             |   1 +
>>>    hw/virtio/virtio-balloon.c              |  30 ++++-
>>>    include/hw/virtio/virtio-balloon.h      |   4 +
>>>    tests/functional/test_virtio_balloon.py | 161 ++++++++++++++++++++++++
>>>    4 files changed, 195 insertions(+), 1 deletion(-)
>>>    create mode 100755 tests/functional/test_virtio_balloon.py
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 822f34344b..1380d53d03 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -2234,6 +2234,7 @@ F: include/hw/virtio/virtio-balloon.h
>>>    F: system/balloon.c
>>>    F: include/sysemu/balloon.h
>>>    F: tests/qtest/virtio-balloon-test.c
>>> +F: tests/functional/test_virtio_balloon.py
>>>    virtio-9p
>>>    M: Greg Kurz <groug@kaod.org>
>>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
>>> index ab2ee30475..fe0854e198 100644
>>> --- a/hw/virtio/virtio-balloon.c
>>> +++ b/hw/virtio/virtio-balloon.c
>>> @@ -31,7 +31,7 @@
>>>    #include "trace.h"
>>>    #include "qemu/error-report.h"
>>>    #include "migration/misc.h"
>>> -
>>> +#include "sysemu/reset.h"
>>>    #include "hw/virtio/virtio-bus.h"
>>>    #include "hw/virtio/virtio-access.h"
>>> @@ -910,6 +910,8 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
>>>        }
>>>        reset_stats(s);
>>> +    s->stats_last_update = 0;
>>> +    qemu_register_resettable(OBJECT(dev));
>>>    }
>>>    static void virtio_balloon_device_unrealize(DeviceState *dev)
>>> @@ -917,6 +919,7 @@ static void virtio_balloon_device_unrealize(DeviceState *dev)
>>>        VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>>        VirtIOBalloon *s = VIRTIO_BALLOON(dev);
>>> +    qemu_unregister_resettable(OBJECT(dev));
>>>        if (s->free_page_bh) {
>>>            qemu_bh_delete(s->free_page_bh);
>>>            object_unref(OBJECT(s->iothread));
>>> @@ -987,6 +990,27 @@ static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t status)
>>>        }
>>>    }
>>
>> Using qemu_register_resettable() can have unfortunate side effects that this
>> code is triggered when the device is reset, not necessarily when the
>> complete machine.
>>
>> For virtio-mem at least that's an issue, and here is how I'll fix it:
>>
>> https://lore.kernel.org/qemu-devel/20241218105303.1966303-2-david@redhat.com/
> 
> Urgh, that's a rather horrible situation. While your patch works around
> it quite effectively, it is pretty heavy weight, and of course relies on
> maintainers knowing this scenario exists - they won't learn this easily
> from the Resettable API design, nor its docs :-(

Yes.

> 
> Shouldn't we put to extend the Resettable design to make this scenario
> more explicity distinguishable in the Resettable callback implementations.

I'd be happy if I wouldn't need that heavy-weight stuff in virtio-mem 
code as well, so if you have ideas on how to avoid that in the future, 
that'd be great.

-- 
Cheers,

David / dhildenb


