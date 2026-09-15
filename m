Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA48C88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6WNJ-0007ye-KZ; Tue, 15 Sep 2026 12:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x6WNG-0007y3-Jd
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:51:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x6WNC-00084v-FH
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789491068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GOixx6abFBVd1Ht1jJ5j+0ZQJz9VDeWAXuG8x0WDNps=;
 b=atSLc2+/n14rRJe74fHVV8Q/8XhlTYPKg5X+H5webcoZ00sTgCTUgcqzzQGVYYyKfv4WPx
 on+WgRqNJTECA3wcUcvfDXaA6qGhOvgrWDhTeTIl1QGQfQy40h8+fbLA/BFq0grGZPIeQa
 5dgSDfQ07qdYNjMeGuTnsAnVWSL/TGk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-5Ualh7FkOHihj8LN2bTmLA-1; Tue, 15 Sep 2026 12:50:58 -0400
X-MC-Unique: 5Ualh7FkOHihj8LN2bTmLA-1
X-Mimecast-MFC-AGG-ID: 5Ualh7FkOHihj8LN2bTmLA_1789491057
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-487038bc9b8so1254995f8f.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789491057; x=1790095857; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GOixx6abFBVd1Ht1jJ5j+0ZQJz9VDeWAXuG8x0WDNps=;
 b=syp3kW8+TMtIhmWpmiPcjmQzqENrLxn2LrcBkk+uI9jX0blzc1fL/ne/v+xOynJt+N
 PkFU1Or1AAE8wOKYbNKKz29YtQfpzE2g0T+UFlGhxaXM5/CdczbT45b7pIRMNv80PEZT
 EB5Cs6Og7cY0OogSZ5HhIPcHi6WioEmXeXwm77ebfIt6So4CvgvTGlHNeg2nMpf7S2nR
 a1jDiN37TYAEM2K7jocv5xvWKiRTrAiPX9vZf5Hx3n8S3zEc87jTEJKv8P/cf6Vd2ORi
 1WJkxQuuZwLQtVuJI0VoWMwnnBADryDIUqK6KQHRWopGOxVwehlNRabfz9rcCtX9Z2uV
 ODQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789491057; x=1790095857;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GOixx6abFBVd1Ht1jJ5j+0ZQJz9VDeWAXuG8x0WDNps=;
 b=LZNDXHfVbUkp3ph7qkrDx+GcfuwEDKyjtSeXUHDKztV6Hzq82Z4grLzkK7CMsmhzI7
 pH/s9lDpd9ek0M7McVoP5LMz4skf1MMJRin+BPb8gBuigJGKovLS9bIFnUQ/bd+LtbDS
 fvUF8dFFkhRbIhylIpd1o3xCr5LS3u1U01a6yUpGFOC/yva+vtyoc9C0imjB8IXvxxYN
 kSK6hIRdNI018GACAmwDtldEy0BpYeS/47yErbsryLa8gvjbdfjIoh64B+RAFzOMvOfM
 Kp96R06pcAZRJBKJt1OOpxyBYV9u/evQFpJXf2vS3ZTOBLbDP+BaeC84Zv4Lra8YqMnP
 jdCA==
X-Forwarded-Encrypted: i=1;
 AKwUvByw4SZ5AqkRvqnm4xlVK/lXOpMmY2bKEWfcLIV0cLWEmWV4jkc0BySzv/BFe49OkwefBxMn8BeQlZWL@nongnu.org
X-Gm-Message-State: AFuF++lQH90+IdKSGRlaVzSZqIt7F9R0uEjgT47SbfUQcQv77Sy5GOmT
 WUrcMJ6HapElES3Iqw45JXQ4ZtYUCBLqhL3YYHap/6SLMmH8AYL64rJ6UXZgkijR1TWp0vMm0PG
 VGEoTYKx29gf+bWxSxGPIVSX6SnFcBTnQ8YplL+XG6zevii/Zt3Q47BIG
X-Gm-Gg: AYBFou1GAxqsdWvPiyGyjn0yfbl6jdd8Ufe4xBGHL4potZIMcV22tM+fEcGKMTcm+qq
 pLRghybIuPWBjU2RX6RAQY6Ldr/DbgOJ2rlpCSBmhrFDs5FsZ/61sER7+yGFKr4xbb9CEQ+RplQ
 H6KPlgqNcT2egNnBslTv4ej+JJ5Ieb7ZApdC+aUNHXfrLGemocK94PxA0v8WLDfBTIJdf3SrGtX
 0Yu75QJ7rhEAMxD17EsZl0PaP+LQdzrqtXraheo07Xxf94y34zN4EC8Tcf1657NEKg7rEDO4MNB
 fM4cbzo7UxZbEZXPKVtCiqqVz+oIUsxjDrrr2cyQFHBNb8dr7rLgcZ5bTQ53OJQodQgWedHjN58
 hY65T89MFMxFHzS3EgBxi28qqzT7C
X-Received: by 2002:a05:6000:3c8:b0:486:f533:daa5 with SMTP id
 ffacd0b85a97d-48702ab92d8mr10360404f8f.24.1789491057396; 
 Tue, 15 Sep 2026 09:50:57 -0700 (PDT)
X-Received: by 2002:a05:6000:3c8:b0:486:f533:daa5 with SMTP id
 ffacd0b85a97d-48702ab92d8mr10360373f8f.24.1789491057013; 
 Tue, 15 Sep 2026 09:50:57 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-41-176-3.web.vodafone.de. [109.41.176.3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf344bfsm292808f8f.27.2026.09.15.09.50.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 09:50:56 -0700 (PDT)
Message-ID: <5673b15b-22fb-474d-b3c4-89f9c3c0c8c6@redhat.com>
Date: Tue, 15 Sep 2026 18:50:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PATCH] hw/s390x/s390-hypercall: fix potential NULL dereference in
 handle_virtio_ccw_notify
To: =?UTF-8?B?0J3QuNC60L7Qu9Cw0Lkg0JfQvtGA0LjQvQ==?= <zorin@swemel.ru>,
 qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Cc: mst@redhat.com, stefanha@redhat.com, kwolf@redhat.com,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>
References: <13ad0871-44dd-40eb-aad1-d08cc2d7dfe5@swemel.ru>
 <597e1a7a-8720-4356-91ed-a7c9fa416312@redhat.com>
 <1749cad8-1651-4543-8a2b-aad3c1168328@swemel.ru>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <1749cad8-1651-4543-8a2b-aad3c1168328@swemel.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 15/09/2026 18.42, Николай Зорин wrote:
> This is the reaction of the (dynamic) static analyzer. We conducted research 
> (at the request of the quality department) and found out that it could work. 
> So we created a patch.If you're sure it will never happen, then, of course, 
> skip it (and I'll have to work hard, because the quality department is 
> digging into everything).

Ok, but please don't send patches for such super theoretical problems found 
by some static analyzers. The QEMU project is already badly suffering from 
hundreds of AI-generated bug reports in the past months where we had to 
filter out a lot of AI slop, so please always make sure that a problem can 
also be really triggered before sending such a patch. Thanks!

  Thomas


> 15.09.2026 19:32, Thomas Huth пишет:
>> On 15/09/2026 18.17, Николай Зорин wrote:
>>> SWSA#4992cdf0-415c-45c1-be1a-71213467347d
>>>
>>> The `virtio_ccw_get_vdev()` function can return a `NULL` pointer if the
>>> corresponding subchannel driver data (`sch->driver_data`) is not initialized
>>> or has been cleared.
>>>
>>> If `vdev` is `NULL`, passing it directly into `virtio_queue_get_num(vdev, 
>>> vq_idx)`
>>> results in a `NULL` pointer dereference, which can lead to a hypervisor
>>> crash or unexpected termination of the QEMU process.
>>>
>>> Fix this by adding an explicit check for `!vdev` before verifying the
>>> queue index and its capacity, returning `-EINVAL` early if the device
>>> is missing or not bound to the subchannel.
>>>
>>> Signed-off-by: Nikolay N Zorin <zorin@swemel.ru>
>>> ---
>>>   hw/s390x/s390-hypercall.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/s390x/s390-hypercall.c b/hw/s390x/s390-hypercall.c
>>> index ac1b08b2..fd2972c0 100644
>>> --- a/hw/s390x/s390-hypercall.c
>>> +++ b/hw/s390x/s390-hypercall.c
>>> @@ -44,7 +44,7 @@ static int handle_virtio_ccw_notify(uint64_t subch_id, 
>>> uint64_t data)
>>>       }
>>>
>>>       vdev = virtio_ccw_get_vdev(sch);
>>> -    if (vq_idx >= VIRTIO_QUEUE_MAX || !virtio_queue_get_num(vdev, 
>>> vq_idx)) {
>>> +    if (!vdev || vq_idx >= VIRTIO_QUEUE_MAX || ! 
>>> virtio_queue_get_num(vdev, vq_idx)) {
>>>           return -EINVAL;
>>>       }
>>
>>  Hi!
>>
>> How did you trigger this problem? It should not exist anymore since:
>>
>> https://gitlab.com/qemu-project/qemu/-/commit/e5cb62e7b6f9
>>
>> which has been included since QEMU v10.2.
>>
>> So please provide some description how to reproduce it if it still happens 
>> with the latest version of QEMU.
>>
>>  Thanks,
>>   Thomas
>>
>> PS: The list of maintainers for the s390x part of QEMU also has recently 
>> been changed. Please use the MAINTAINERS file and scripts/ 
>> get_maintainer.pl from the latest version to check before sending patches. 
>> Thanks!
>>
> 


