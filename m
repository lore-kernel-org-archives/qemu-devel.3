Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C7AC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 12:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8IHR-0003va-3f; Fri, 25 Apr 2025 08:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1u8IHO-0003vJ-DW
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:35:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1u8IHA-0005pR-Be
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745584525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oCSYk21fTvbCfROTPzWI57OHSkghy+8C+pEVm/cbo1E=;
 b=b9AhdiEz2pCVvRAlX2ICk92VI3FFOm/Dyp0LwYigb03nsQ2gA8DaljTJ6+4wfTYGgbkEWj
 rIez8PMcLW2oolvztzQFjeNRShgTw2B2TC7EyJ42dHDrBJdwERqY4j4dhiLSWblnW8WUyW
 Cx/kJg5qhyAkV0eTa0R0OgAL0O6YabQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-QLbHxF3LOp2cANUOkCoRhQ-1; Fri, 25 Apr 2025 08:35:22 -0400
X-MC-Unique: QLbHxF3LOp2cANUOkCoRhQ-1
X-Mimecast-MFC-AGG-ID: QLbHxF3LOp2cANUOkCoRhQ_1745584521
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39135d31ca4so832740f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 05:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745584521; x=1746189321;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=oCSYk21fTvbCfROTPzWI57OHSkghy+8C+pEVm/cbo1E=;
 b=rgYQBB4PeCurLzFoLfV356FYezChwiggS/RuNNbkrp0hbEoM8n/76pgjNRw0Ftl7Dz
 Q6JMsG7h82d0t64GmJpDGzPu9BSaB0Q79VxiyUtyCUZ2vWDX+/H4gN6JfPXf600ICChp
 evn6ev3dResqvw5btsXGAzeTH60EaCYBOfWfBqVyDCxQJ0VReOCxUv0n0dgYea5lT/Ud
 x4QO1/Dv5nY2SNPJ5GhUBlJu+dK+z6C/Zh8wb9rxa4/T1mLlmQXolLCoIy7teZaAVA9N
 H5dRMUeTNN8RYCIbQyqmwPhRof7XXJIkk/ZaL4e3k/N/xjsuvzV2OfWu3v1gAHiQzzrm
 nJgQ==
X-Gm-Message-State: AOJu0YxRMth1Ouhhc4xQV4gMkTN7BC4CgEaDX7ojP8iWL49Vi8YoFObg
 wdUTiTkbHJ2s7YQDbokCA3fA0mXfjiWf4joaXq8NuSVrCygb5enLft/gRsSQKlNG0qtew2xJaEH
 4/T+K6xox0mUDqF4c1eziDdY7TS5Ny5CXLPtI6nBZu/YemVnS7eGG
X-Gm-Gg: ASbGnctACCTkWiznWPkLJWYr7CwiXGbk93v8ILAFBfv3saO3TaoJV1Gdbl7IuQdLing
 cCEEB8ceHOwrdJaGr2NU8VtbetUALPMnwt6WE3+rbBvAnkseFOi5Aynjb9RJgUznItxyNNiY1F9
 kLHrMHBpMkDs7bazp/qIBAHwKdCzuLGx1mhQ2r168E2IxT1LuVK18j9FRmsS1lpzYqyCi1f/QHU
 3PceoRQI1DAmcq/K25d+ApezQi8YD5i2M0y9ND9NC5T8yT25u4tgqZkqzdzEkK2qpYzuO99Ug4g
 wsaYh/KP7ka/RzWX1/lsPqLWX7Turv+Dyp0fplMzmg==
X-Received: by 2002:a05:6000:4313:b0:391:386d:5971 with SMTP id
 ffacd0b85a97d-3a06d66d21cmr5292602f8f.14.1745584521284; 
 Fri, 25 Apr 2025 05:35:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF35EBNlLy12KC3xCfWWQicrt19aNwkw/jItNvq1tEUmbDBEF5INyWJtfJlOJfNi6XEu53FLw==
X-Received: by 2002:a05:6000:4313:b0:391:386d:5971 with SMTP id
 ffacd0b85a97d-3a06d66d21cmr5292568f8f.14.1745584520824; 
 Fri, 25 Apr 2025 05:35:20 -0700 (PDT)
Received: from [192.168.3.141] (p4ff23df8.dip0.t-ipconnect.de. [79.242.61.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a536a02csm23854305e9.27.2025.04.25.05.35.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 05:35:20 -0700 (PDT)
Message-ID: <39ae9a9e-9108-464f-9e2e-03e16976607a@redhat.com>
Date: Fri, 25 Apr 2025 14:35:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/13] memory: Change
 memory_region_set_ram_discard_manager() to return the result
To: Chenyi Qiang <chenyi.qiang@intel.com>, Alexey Kardashevskiy
 <aik@amd.com>, Peter Xu <peterx@redhat.com>,
 Gupta Pankaj <pankaj.gupta@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
References: <20250407074939.18657-1-chenyi.qiang@intel.com>
 <20250407074939.18657-3-chenyi.qiang@intel.com>
 <d4b44d77-3522-42bd-b02f-fe2e9be65857@amd.com>
 <7436cdd9-513c-483a-a994-8602142c7551@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <7436cdd9-513c-483a-a994-8602142c7551@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

                               RamDiscardManager *rdm);>>>      /**
>>>     * memory_region_find: translate an address/size relative to a
>>> diff --git a/system/memory.c b/system/memory.c
>>> index b17b5538ff..62d6b410f0 100644
>>> --- a/system/memory.c
>>> +++ b/system/memory.c
>>> @@ -2115,12 +2115,16 @@ RamDiscardManager
>>> *memory_region_get_ram_discard_manager(MemoryRegion *mr)
>>>        return mr->rdm;
>>>    }
>>>    -void memory_region_set_ram_discard_manager(MemoryRegion *mr,
>>> -                                           RamDiscardManager *rdm)
>>> +int memory_region_set_ram_discard_manager(MemoryRegion *mr,
>>> +                                          RamDiscardManager *rdm)
>>>    {
>>>        g_assert(memory_region_is_ram(mr));
>>> -    g_assert(!rdm || !mr->rdm);
>>> +    if (mr->rdm && rdm) {
>>> +        return -EBUSY;
>>> +    }
>>> +
>>>        mr->rdm = rdm;
>>> +    return 0;
>>
>> This is a change which can potentially break something, or currently
>> there is no way to trigger -EBUSY? Thanks,
> 
> Before this series, virtio-mem is the only user to
> set_ram_discard_manager(), there's no way to trigger -EBUSY. With this
> series, guest_memfd-backed RAMBlocks become the second user. It can be
> triggered if we try to use virtio-mem in confidential VMs.

Right. I have plans on looking into using virtio-mem for confidential 
VMs, so far it's not compatible.

One challenge will be resolving how to deal with two sources of information.

Assume virtio-mem says "memory is now plugged", we would have to check 
with guest_memfd if it is also in the "shared" state. If not, no need to 
notify anybody.

Similarly, if guest_memfd says "memory is now shared", we would have to 
check with guest_memfd if it is in the "plugged" state.


I don't know yet how exactly the solution would look like.

Possibly, we have a list of such "populate/discard" information sources, 
and a real "manager" on top, that gets notified by these sources.

That real "manager" would then collect information from other sources to 
make a decision whether to propagate the populate / shared notification.

-- 
Cheers,

David / dhildenb


