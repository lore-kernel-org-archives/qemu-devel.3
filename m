Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1710EE7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJGs-00049u-6B; Thu, 19 Dec 2024 11:21:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tOHgI-0002ti-KV
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 09:39:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tOHgG-0001L5-6s
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 09:39:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734619150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xtMLJyGfqa/RcASDEl89xqpz4+JrkmEyFM0rKS8M3F0=;
 b=h0SRnh1HFXdOBIrm050vzHx4pDs1RjlXtHSEQXfQNST3Xg3dXaHAvyx3zwP4NzlPBOJLTa
 7voYjjojhN6gsKfMENKnW1EBGsuUG28xM0URhlKylef4QgIssyBhV+AgMVvZzS4XrztSGE
 QXHoW7JkosR7B3lobDsofH8IQ0mHQzA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-ri2U-bjMNa-8tG5nmLEsPA-1; Thu, 19 Dec 2024 09:39:09 -0500
X-MC-Unique: ri2U-bjMNa-8tG5nmLEsPA-1
X-Mimecast-MFC-AGG-ID: ri2U-bjMNa-8tG5nmLEsPA
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385ded5e92aso396904f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 06:39:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734619148; x=1735223948;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xtMLJyGfqa/RcASDEl89xqpz4+JrkmEyFM0rKS8M3F0=;
 b=VY56TbMQYTYnYYj1Y6rP3T5+4sOdn4Ly91JEqv0/bw8dh5lsYftsOHzK2HB8d6Hz+l
 OrospFbcTC+rjqLcYTF7uMwyALZECx7ES0QKe92PEN6vShGl0cnXVCVG9DOt0cdnKYiA
 5U8oa9HbHv2bqsKqnUmhRRaXYz7ZSociYyUc0+3JqZzezMUzNvDlZ2zoHD/NJROYsSK/
 tzHEHQQHgJrKQSDXT7wCo9qoWXQrik+loN9FSQLgY05V7n9V4WBRy8Nc3mTdmRtTD39P
 tB6a6PHT9kRA1Im87/+XBFHmGjVzTyLLvsVOmHSM24P3qjTfdv/e3qxsyQgU6V4E25CJ
 ZdFA==
X-Gm-Message-State: AOJu0YzjZul4h4W1C5R29m5BGhL0jgcvo97bPi//BT4rPfExw0rvPuMv
 /Jhz+OW9zu9ASUGp//mR4NmvuVivE05oSXoQjUzwPDK/Lyu00OT+XKCEdsdjSjfVXrmkNq12+qe
 K3bJMd1bkf8xjXafVS/GjghpB31qp8HLm5VSgXCtpGMBIH0wzLktd
X-Gm-Gg: ASbGnctUOP+H4qxtnPHdMxK+j/PESZ4Oz2mbhp6s6nIDxCjj6H5lZg/vfFt6jioicEQ
 lbmchBAO7T0iX9UWQmVL5dPwJboYvlRr/Z+eQ/HviuTPn+x0DsA62oNcd68VEGPvpjLHQi2l7Xu
 XSTfL/lTfMD/DzR35fTgoEpyh0RHxx0VkZDw6NdeD3mAIprp7uBDPwx53BtJhavD6yfN1j+DNO7
 kz6wAUTwVyg9hZ0AIj9xZkc1cGDOzmD6OAnlZbFRoNeZvnydZRv3PdJyueMvt07O333EsVcf5hg
 nZd2BKzJTqky9ERrkpmTBLOmmuWDuFD8QgKV5J6mjx/PTbu/Z9u0hmWFWrZTRg5acXwlAFuCZbs
 eAilBwQ==
X-Received: by 2002:a5d:47cf:0:b0:385:ee40:2d88 with SMTP id
 ffacd0b85a97d-38a19adee76mr3640908f8f.3.1734619148031; 
 Thu, 19 Dec 2024 06:39:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWRe8zhHKOkKENu1EGnmZnhYb8+of/6vFFFwJDWekzRtnGOmPYCYEvYrTzZkAY2EPr3Kr9Yg==
X-Received: by 2002:a5d:47cf:0:b0:385:ee40:2d88 with SMTP id
 ffacd0b85a97d-38a19adee76mr3640890f8f.3.1734619147638; 
 Thu, 19 Dec 2024 06:39:07 -0800 (PST)
Received: from ?IPV6:2003:cb:c749:6600:b73a:466c:e610:686?
 (p200300cbc7496600b73a466ce6100686.dip0.t-ipconnect.de.
 [2003:cb:c749:6600:b73a:466c:e610:686])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366127c4bbsm19539065e9.32.2024.12.19.06.39.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 06:39:07 -0800 (PST)
Message-ID: <abdf69b4-478e-4ff2-9583-8449eae0e1bd@redhat.com>
Date: Thu, 19 Dec 2024 15:39:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio: reset virtio balloon stats on machine reset
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
References: <20241218172912.4170899-1-berrange@redhat.com>
 <d2730488-8468-4639-876c-18a860c6469e@redhat.com>
 <Z2QsebYwZ51ohas7@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z2QsebYwZ51ohas7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
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

On 19.12.24 15:23, Daniel P. Berrangé wrote:
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
> IIUC, the scenario wrt kDump on s390x will be OK in this scenario. If
> you're resetting the balloon device across a kDump, I think it is likely
> desirable for the virtio balloon stats to be reset. The OS which populated
> those stats no longer exists, and has been replaced by the kExec kernel
> performing the kDump IIUC.

Likely. Hopefully there are no other device resets of that kind.

Hopefully the kexec kernel has the balloon driver somehow disabled, just 
imagine if it would try inflating the balloon when the kexec kernel 
usually only has access to a carved out memory region ...

I did not investigate how other archs besides x86,s390x,arm64,riscv 
behave with resets, because virtio-mem only supports these.

But yes, likely resetting stats that the VM will update soon again won't 
be very harmful.

-- 
Cheers,

David / dhildenb


