Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36323CF9C72
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 15:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sslAO-0005IO-AG; Mon, 23 Sep 2024 11:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sslAI-0005GF-Dd
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 11:39:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sslAF-00048C-1S
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 11:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727105990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HFjVcLssyUzXd9o+Ef79ahpGJsfsIidqba1wCrK4IAY=;
 b=NYFUYgIWFX2wUnITTZX9PikLzhC3N8HHDM/XU+HjbyIHsJPSZae9CjoBlq09vgwceDb0P6
 mgXbeomOfqmL90qYvkbab9zD+LUVFQlr8+v8GAoaHTopsz7zBnUHlKCJ3l0bBKunIcIaEL
 PU8nGxXhZ3kO0Kji1tZs1StmY/K1ZxM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-jHMQi9NDOtusmCjW6JStLw-1; Mon, 23 Sep 2024 11:39:48 -0400
X-MC-Unique: jHMQi9NDOtusmCjW6JStLw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-374c294d841so3045987f8f.1
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2024 08:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727105987; x=1727710787;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=HFjVcLssyUzXd9o+Ef79ahpGJsfsIidqba1wCrK4IAY=;
 b=J/Uti0qlxqdomOQNnBepX2xzNB82qYUuTM4JG59dpeqIXy/EE+GiWFA9X2NlxDccMg
 /2NlEof4jO788gmLzxlUW0gJz875ESj/umEWoeBgb0G2gbi3FH3lBG3X2DE905iQci0y
 L0nEIYWgm7kjph1Xbig5iIpYgRMxTPNUINQtMMjEW5xVidhMxB2efEnHvxP4+iUTSsTU
 0AZZDWPfn1HSgo6Ns5rmFHe1C+oFVGIlV/E5QdbQKQzMMao9axkQAUJwzluHX8ULKoo/
 Ob5/sOAZ12cWCsbi++K4SAP6NkvZCWivVeIXky5kLLwpzZX+Nnsv2zC4M49cObbCOmGb
 MHZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyHZPH6J6TckJVls9M1U0txHQNgbF6I3KzVJefhxGIK5EVos3qMozPQI7IJWmPZtNmRpoU13zqZR6X@nongnu.org
X-Gm-Message-State: AOJu0YyrFeaBNqNMoThtpD3w5CkzMDAliIMm76vHmweAvj1RsIyrUDtN
 tw9PZ71QaMcoXbbGx5P6utF3LZTgfkQVcq3DUBCCfuPCaO8yKjkUn6QUV6LKIVy9JxHMGiGH3yE
 zksDPUjFjaaD+dMnLQiMYG5ZJN1rXfsyO22jVZp5BeWi71qtNLJiZ
X-Received: by 2002:a05:6000:d0a:b0:374:c328:620a with SMTP id
 ffacd0b85a97d-37a422c7647mr9831718f8f.29.1727105987288; 
 Mon, 23 Sep 2024 08:39:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXktItx7WADi9T+Ol5UHSvR9Fdd8UNrIXjAuEN1SUdBcZDeCtE+fZGC6tYs8oZ86FDYqlyHA==
X-Received: by 2002:a05:6000:d0a:b0:374:c328:620a with SMTP id
 ffacd0b85a97d-37a422c7647mr9831689f8f.29.1727105986850; 
 Mon, 23 Sep 2024 08:39:46 -0700 (PDT)
Received: from [10.5.48.152] (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610f44fasm1243023466b.79.2024.09.23.08.39.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Sep 2024 08:39:46 -0700 (PDT)
Message-ID: <fe5f15e7-a9c5-47f0-9463-9c8c8811038a@redhat.com>
Date: Mon, 23 Sep 2024 17:39:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/14] s390x/s390-virtio-ccw: don't crash on weird RAM
 sizes
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20240910175809.2135596-1-david@redhat.com>
 <20240910175809.2135596-2-david@redhat.com>
 <8503e69e-f5fa-437f-8ff9-e61f297ce6c2@redhat.com>
 <6c0d80ec-f5c1-42d3-acc6-df96876287b7@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6c0d80ec-f5c1-42d3-acc6-df96876287b7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 23.09.24 17:36, Thomas Huth wrote:
> On 23/09/2024 11.19, David Hildenbrand wrote:
>> On 10.09.24 19:57, David Hildenbrand wrote:
>>> KVM is not happy when starting a VM with weird RAM sizes:
>>>
>>>     # qemu-system-s390x --enable-kvm --nographic -m 1234K
>>>     qemu-system-s390x: kvm_set_user_memory_region: KVM_SET_USER_MEMORY_REGION
>>>       failed, slot=0, start=0x0, size=0x244000: Invalid argument
>>>     kvm_set_phys_mem: error registering slot: Invalid argument
>>>     Aborted (core dumped)
>>>
>>> Let's handle that in a better way by rejecting such weird RAM sizes
>>> right from the start:
>>>
>>>     # qemu-system-s390x --enable-kvm --nographic -m 1234K
>>>     qemu-system-s390x: ram size must be multiples of 1 MiB
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>    hw/s390x/s390-virtio-ccw.c | 11 +++++++++++
>>>    1 file changed, 11 insertions(+)
>>>
>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>>> index 18240a0fd8..e30cf0a2a1 100644
>>> --- a/hw/s390x/s390-virtio-ccw.c
>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>> @@ -180,6 +180,17 @@ static void s390_memory_init(MemoryRegion *ram)
>>>    {
>>>        MemoryRegion *sysmem = get_system_memory();
>>> +    if (!QEMU_IS_ALIGNED(memory_region_size(ram), 1 * MiB)) {
>>> +        /*
>>> +         * The SCLP cannot possibly expose smaller granularity right now
>>> and KVM
>>> +         * cannot handle smaller granularity. As we don't support NUMA, the
>>> +         * region size directly corresponds to machine->ram_size, and the
>>> region
>>> +         * is a single RAM memory region.
>>> +         */
>>> +        error_report("ram size must be multiples of 1 MiB");
>>> +        exit(EXIT_FAILURE);
>>> +    }
>>
>> I'll switch to
>>
>>       error_setg(&error_fatal, "ram size must be multiples of 1 MiB");
>>
>> here, to avoid the manual exit().
>>
>> Please someone shout if I should keep it as is.
> 
> Please keep it, according to include/qapi/error.h:
> 
>    * Please don't error_setg(&error_fatal, ...), use error_report() and
>    * exit(), because that's more obvious.
> 

Controversial, but will do. Thanks!

-- 
Cheers,

David / dhildenb


