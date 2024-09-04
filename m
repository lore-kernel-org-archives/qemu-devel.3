Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8426ECD4F25
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 20:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slwjh-0003xY-T8; Wed, 04 Sep 2024 16:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1slwjf-0003wY-WE
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 16:36:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1slwjd-00033S-PN
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 16:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725482170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=82FLzmSX8u4fim/5W/BAHQ1w/mRikjOncxRicWqMsOY=;
 b=HP1qqWS2N7PqEQUu2ddyF9BYyFZ2sMSjIS6nXykdTsAMCRu37zz7/dBe7niNmWO83AUnNS
 p6IoHDtSHsWvT8knRWEFwFsjgWfb5teBc9rXip2X0kO9NrQWiEiKJ5lshMTt9yd11Kg73/
 +lZM+NTyTgawBP5M74pOk+lF9Wq69e8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-8LO3sGygOJ6bZZyIWTu_TQ-1; Wed, 04 Sep 2024 16:36:08 -0400
X-MC-Unique: 8LO3sGygOJ6bZZyIWTu_TQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42bbd062ac1so52395195e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 13:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725482167; x=1726086967;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=82FLzmSX8u4fim/5W/BAHQ1w/mRikjOncxRicWqMsOY=;
 b=EtqjiHMMxAq4yu7u92FrOZHVke5S8qyC6GrD8HjByg+Ul+ljNh5Tvwulf3j9Nbne7w
 S91qfmMWdJemxJSYTLNKm6nL4lB9pjDX4dPFioSRbKu05n4/iteRAzSaa8NisekBnguC
 RIdSO3ycrB4cf64Apzb4oTfw/uhwA5z1iyVdAh5oWK+yskHwLaER2t/MESjF80jf6pcK
 dcW/yLBN4GEYdyHRffbKf0KOAESz7bUhq58HZ7dlk540TinEeNwQiQWXJq7OK3UOBGuR
 w42TF+cahKDM+ni0hCgEhWLwUQN8AnUkz1l4fLYucTUXuKAeMa5fmxVcoaTbgaTWxqv6
 aePw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeie6XVfVEhzIrxk7Jd9USNy914C9gHBrtDE1BEL6DLfTvjfmobn78TlniA6QWOEJvMFOq7mn0Ptiz@nongnu.org
X-Gm-Message-State: AOJu0Yz6MB+40oOqcAYcSuO+D4YHHiwLk4iKu2eMD0lYswmhlNJnI5iG
 bgVN3yMHGVmQIgaOf5y6/mJckahOI/OIJXC4OY6GFkwrwHP3FLwUVLyI6FimqB1TkjZhQOSQgPd
 yNXFAZkraQ2lnK5SdBN3BiCKX4oNRAAaT48BgUvlZWm0Te9pJ4Abh
X-Received: by 2002:a05:600c:4eca:b0:426:5471:156a with SMTP id
 5b1f17b1804b1-42bdc6334cbmr112937235e9.13.1725482167379; 
 Wed, 04 Sep 2024 13:36:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYY6IXeuEIsp1fFTzjINVd+dUNZotlM8sJqgibAvSLuLwO/4VmLKepiilUnNuMxfl/k0RiCA==
X-Received: by 2002:a05:600c:4eca:b0:426:5471:156a with SMTP id
 5b1f17b1804b1-42bdc6334cbmr112936875e9.13.1725482166387; 
 Wed, 04 Sep 2024 13:36:06 -0700 (PDT)
Received: from [192.168.3.141] (p4ff2399b.dip0.t-ipconnect.de. [79.242.57.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374c07eed5dsm12490386f8f.116.2024.09.04.13.36.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Sep 2024 13:36:05 -0700 (PDT)
Message-ID: <96b8153d-1604-43a0-b0f7-973fd81f6029@redhat.com>
Date: Wed, 4 Sep 2024 22:36:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] KVM: Rename KVMState->nr_slots to nr_slots_max
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20240904191635.3045606-1-peterx@redhat.com>
 <20240904191635.3045606-2-peterx@redhat.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240904191635.3045606-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 04.09.24 21:16, Peter Xu wrote:
> This value used to reflect the maximum supported memslots from KVM kernel.
> Rename it to be clearer, preparing for dynamic sized memslot allocations.

Well, it matches "KVM_CAP_NR_MEMSLOTS" :)

Reviewed-by: David Hildenbrand <david@redhat.com>

> -    for (i = 0; i < s->nr_slots; i++) {
> +    for (i = 0; i < s->nr_slots_max; i++) {
>           mem = &kml->slots[i];
>           /* Discard slots that are empty or do not overlap the section */
>           if (!mem->memory_size ||
> @@ -1720,11 +1720,11 @@ static void kvm_log_sync_global(MemoryListener *l, bool last_stage)
>       kvm_dirty_ring_flush();
>   
>       /*
> -     * TODO: make this faster when nr_slots is big while there are
> +     * TODO: make this faster when nr_slots_max is big while there are
>        * only a few used slots (small VMs).
>        */

Interesting TODO!

-- 
Cheers,

David / dhildenb


