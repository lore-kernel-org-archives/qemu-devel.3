Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24685C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 08:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDIvw-0005dO-LS; Fri, 09 May 2025 04:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uDIvu-0005dD-U9
 for qemu-devel@nongnu.org; Fri, 09 May 2025 04:18:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uDIvt-0002cT-1F
 for qemu-devel@nongnu.org; Fri, 09 May 2025 04:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746778691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1x06izvVlQwWF9V0u7S11ymywAn59aCIl/Jh5sZhW+w=;
 b=X8CisSnoYl9B3T1uakqzOvC31ypF7hqUwjpwMPMbB/WJpXMcd0m3crvN9cVQ/Ioo2iUQfA
 XpuegPaNQf1hdlhUUcvm7KSSOMJjIKBYFlNzKgiS/qbapx9l32ndMEzH2aAUObOYjHo4BJ
 JUAwQXAxSI2DTEdmgBgqoY1C+EVDGv8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-4ymNrQmvM4ShXMST-a9M3Q-1; Fri, 09 May 2025 04:18:09 -0400
X-MC-Unique: 4ymNrQmvM4ShXMST-a9M3Q-1
X-Mimecast-MFC-AGG-ID: 4ymNrQmvM4ShXMST-a9M3Q_1746778688
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d733063cdso14632255e9.0
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 01:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746778688; x=1747383488;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1x06izvVlQwWF9V0u7S11ymywAn59aCIl/Jh5sZhW+w=;
 b=h2MmF8DEhrzZzEno3gPqzhqWmuab7qy/jh3M3hA1tRjZBCD+bC53vdllFeH5SK1yj3
 opY6Z+uBdXreyYRM5FQLrrr3yVDEnVQKeDxpEqxWxC+G71UEHej2o+3ZBBQ0yJp10Pj3
 68b9/C1RR5pAI76RE35jHkqtqulqk05VMYYLa8Kmtw/enEvzhg44xX2UHeiy16Vl5O3x
 T1U7KVdxyJTiEed2bv3KHyS7FOB+vK1NM4ZGaS9AOosbGaMujCd/V32WdhytQcNMexZb
 uVZNzOBPkqRdp7qKb4aO8Qz0Lk1xOw4gwWYChoIEkFxFV38mQvXrx2YwUIS8SHRXB56Q
 cwxA==
X-Gm-Message-State: AOJu0YwO/KnbjV5y3rqCHbeSXkC3a75NtDCeBHlrFwiyeWk4AyMdMST9
 KiQzEIWttAHDq5es4U7mrUFCHe/Hy9kUfrNbleJ5sHoq+UDgTAYUFsrSchy9IY/xCjq6OsztO81
 fC7dztAU96LxKTMoKul8j9z7/IygNGlff3dQAZu9bea7Z8FjLy/pS
X-Gm-Gg: ASbGnctbdVyOSDVLBx2mXvGCj7T3cbGkCgkSH8ESTewRtYv7rmRO/51aMo2iYLwk5Dv
 EvXzOzRfxosTOdg1KXesK+/yFVtsZHL5E6hSCwSDFdQa9rwiNSVIPnRRggPsjJOdWDnVR6nonNC
 JlW6w1SjxXvHFbUM6wMzxoG3zxOllKdxUbfeKRXEBOK01oCbd/Di8r7loR4SPM0cbgHXAnQtjJo
 u0rE07N56P2QRYAMlw4KWn0wsmCDNrntOdyz5hiPaYYhh+r/J9YQWh2GYi2RCC5b+75KhJn8XkE
 cebf3Dt0FpkOwIeNiS3yVn6JQVMat4sTgKKSxgFVexUeDWREU+s0ZsmtuJsk9ZcVa78HerkjntJ
 K1grVpu20iAKpnOEVogynwyzl8QgfMJMHn1yK1U0=
X-Received: by 2002:a05:600c:3b85:b0:43c:fb8e:aec0 with SMTP id
 5b1f17b1804b1-442d6d0aa92mr14925245e9.1.1746778688212; 
 Fri, 09 May 2025 01:18:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGy+YPL7ZFC8nu1GKQDoFus1h7+tpsHfYsS7kxrVQSgYLIcRwdGKfFuVIBuBy8BKKf3/PijZQ==
X-Received: by 2002:a05:600c:3b85:b0:43c:fb8e:aec0 with SMTP id
 5b1f17b1804b1-442d6d0aa92mr14925065e9.1.1746778687810; 
 Fri, 09 May 2025 01:18:07 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f45:5500:8267:647f:4209:dedd?
 (p200300d82f4555008267647f4209dedd.dip0.t-ipconnect.de.
 [2003:d8:2f45:5500:8267:647f:4209:dedd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d685c2d7sm20802795e9.30.2025.05.09.01.18.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 01:18:07 -0700 (PDT)
Message-ID: <96ab7fa9-bd7a-444d-aef8-8c9c30439044@redhat.com>
Date: Fri, 9 May 2025 10:18:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/13] ram-block-attribute: Introduce RamBlockAttribute
 to manage RAMBLock with guest_memfd
To: Chenyi Qiang <chenyi.qiang@intel.com>, Baolu Lu
 <baolu.lu@linux.intel.com>, Alexey Kardashevskiy <aik@amd.com>,
 Peter Xu <peterx@redhat.com>, Gupta Pankaj <pankaj.gupta@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
References: <20250407074939.18657-1-chenyi.qiang@intel.com>
 <20250407074939.18657-8-chenyi.qiang@intel.com>
 <013b36a9-9310-4073-b54c-9c511f23decf@linux.intel.com>
 <b547c5a7-5875-4d65-adea-0da870b4b1c2@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <b547c5a7-5875-4d65-adea-0da870b4b1c2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

>>>
>>> Signed-off-by: Chenyi Qiang<chenyi.qiang@intel.com>
>>
>> <...>
>>
>>> +
>>> +int ram_block_attribute_realize(RamBlockAttribute *attr, MemoryRegion
>>> *mr)
>>> +{
>>> +    uint64_t shared_bitmap_size;
>>> +    const int block_size  = qemu_real_host_page_size();
>>> +    int ret;
>>> +
>>> +    shared_bitmap_size = ROUND_UP(mr->size, block_size) / block_size;
>>> +
>>> +    attr->mr = mr;
>>> +    ret = memory_region_set_generic_state_manager(mr,
>>> GENERIC_STATE_MANAGER(attr));
>>> +    if (ret) {
>>> +        return ret;
>>> +    }
>>> +    attr->shared_bitmap_size = shared_bitmap_size;
>>> +    attr->shared_bitmap = bitmap_new(shared_bitmap_size);
>>
>> Above introduces a bitmap to track the private/shared state of each 4KB
>> page. While functional, for large RAM blocks managed by guest_memfd,
>> this could lead to significant memory consumption.
>>
>> Have you considered an alternative like a Maple Tree or a generic
>> interval tree? Both are often more memory-efficient for tracking ranges
>> of contiguous states.
> 
> Maybe not necessary. The memory overhead is 1 bit per page
> (1/(4096*8)=0.003%). I think it is not too much.

It's certainly not optimal.

IIRC, QEMU already maintains 3 dirty bitmaps in
ram_list.dirty_memory (DIRTY_MEMORY_NUM = 3) for guest ram.

With KVM, we also allocate yet another dirty bitmap without 
KVM_MEM_LOG_DIRTY_PAGES.

Assuming a 4 TiB VM, a single bitmap should be 128 MiB.

-- 
Cheers,

David / dhildenb


