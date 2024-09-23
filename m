Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EE5CF9C6F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 15:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssl7U-0000i7-56; Mon, 23 Sep 2024 11:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ssl7S-0000ey-QE
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 11:36:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ssl7Q-0003kx-ME
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 11:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727105814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Hyek+wJWpNZov1gtEfwMCKYIeL26USqKTUz6zIYO6hs=;
 b=QvXpH03F0PpkwU8ZC8laQ1oHuhwtoxeaicq4jvgdaVS3zcLtf+Vt2usZeX1ew5iEHH8KJi
 N6UM6OryPPeunWpHQklgASWNTmUiGVZwoATd1+PWxI8jIT9dCykpdFOncFiFRFBGbXVyDI
 tl+znuvvXOhHSGlMK9ry2JPQr5BVcrY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-B8vVHbCxP9uWPhqKJOEFyQ-1; Mon, 23 Sep 2024 11:36:52 -0400
X-MC-Unique: B8vVHbCxP9uWPhqKJOEFyQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2f75a817a3eso30856021fa.0
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2024 08:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727105811; x=1727710611;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hyek+wJWpNZov1gtEfwMCKYIeL26USqKTUz6zIYO6hs=;
 b=g5xTLNaGjMSqpj0LBidXkMskjtUkA+oTzH+B8FAnV8sg+pnWeLkq/7OV3NW00LMqFn
 PTe4dXcVTFx3SXj1szAR9zlWkY8GxukIUen4khMjU6YVl495hp8Dbd/fjbDm4zzwwDrr
 Sj8Yn0w6dgw5bPGPrI6YVJAq335c8+6sovviKelNE6vg7GN+wT+7ZhQ/vZJfw46L7Y5i
 1WBma1nm+sZ9UVQ7zsa6TZMv4iFv/RLHe2PrAzoHQ7y9oOEoVd+7tiRX+TBDDJUklpxl
 LCwNc8LDbjGNthB/v0JI4htFrS3LmBehkZnDu5QNGHO9FYEKzJrtzsx3/WP6NbGKu6tQ
 +u7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6HxdMdcjW7D5fHhJm/bm5oJNzDuCPxSmcv8Ex6xO0Lj3wlmyg8+4aGB/dtmW2FAFM4Fycs6mHjewq@nongnu.org
X-Gm-Message-State: AOJu0Yzle6UZnZhmO484F5lyLGE50VZWvJdUajXzr+BS4fGcvYcXDdtN
 F+npiXN2i4oSt7+QdpRmNUcf1WZ9qlE6x4fgt/lxOjIVfpZBGAwfz/gjYyBI/QOTf4G6UWI1vk5
 22WWyOMeL76tAkzdpPDeipLmD+zp8AKH6K7Tqj9U6v25H4faEGaV3nZtaElBdgpQ=
X-Received: by 2002:a2e:a586:0:b0:2f4:f255:4fc1 with SMTP id
 38308e7fff4ca-2f7cb2ed763mr67542401fa.11.1727105810610; 
 Mon, 23 Sep 2024 08:36:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe0arg6WAadbIfOXn8JvqGRfmx75ELZpr5517krTehj7Cy1Rx9igLlPAdbQSkX6rHZyqECKQ==
X-Received: by 2002:a2e:a586:0:b0:2f4:f255:4fc1 with SMTP id
 38308e7fff4ca-2f7cb2ed763mr67542241fa.11.1727105810174; 
 Mon, 23 Sep 2024 08:36:50 -0700 (PDT)
Received: from [10.5.48.57] (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bb539b9sm10579227a12.33.2024.09.23.08.36.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Sep 2024 08:36:49 -0700 (PDT)
Message-ID: <6c0d80ec-f5c1-42d3-acc6-df96876287b7@redhat.com>
Date: Mon, 23 Sep 2024 17:36:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/14] s390x/s390-virtio-ccw: don't crash on weird RAM
 sizes
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
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
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <8503e69e-f5fa-437f-8ff9-e61f297ce6c2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 23/09/2024 11.19, David Hildenbrand wrote:
> On 10.09.24 19:57, David Hildenbrand wrote:
>> KVM is not happy when starting a VM with weird RAM sizes:
>>
>>    # qemu-system-s390x --enable-kvm --nographic -m 1234K
>>    qemu-system-s390x: kvm_set_user_memory_region: KVM_SET_USER_MEMORY_REGION
>>      failed, slot=0, start=0x0, size=0x244000: Invalid argument
>>    kvm_set_phys_mem: error registering slot: Invalid argument
>>    Aborted (core dumped)
>>
>> Let's handle that in a better way by rejecting such weird RAM sizes
>> right from the start:
>>
>>    # qemu-system-s390x --enable-kvm --nographic -m 1234K
>>    qemu-system-s390x: ram size must be multiples of 1 MiB
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   hw/s390x/s390-virtio-ccw.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 18240a0fd8..e30cf0a2a1 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -180,6 +180,17 @@ static void s390_memory_init(MemoryRegion *ram)
>>   {
>>       MemoryRegion *sysmem = get_system_memory();
>> +    if (!QEMU_IS_ALIGNED(memory_region_size(ram), 1 * MiB)) {
>> +        /*
>> +         * The SCLP cannot possibly expose smaller granularity right now 
>> and KVM
>> +         * cannot handle smaller granularity. As we don't support NUMA, the
>> +         * region size directly corresponds to machine->ram_size, and the 
>> region
>> +         * is a single RAM memory region.
>> +         */
>> +        error_report("ram size must be multiples of 1 MiB");
>> +        exit(EXIT_FAILURE);
>> +    }
> 
> I'll switch to
> 
>      error_setg(&error_fatal, "ram size must be multiples of 1 MiB");
> 
> here, to avoid the manual exit().
> 
> Please someone shout if I should keep it as is.

Please keep it, according to include/qapi/error.h:

  * Please don't error_setg(&error_fatal, ...), use error_report() and
  * exit(), because that's more obvious.

  Thanks,
   Thomas


