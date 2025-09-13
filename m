Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F83CAC587
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 03:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxHJt-000288-0I; Fri, 12 Sep 2025 23:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxHJr-00027v-Um
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 23:52:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxHJo-0006CT-RI
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 23:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757735570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=slp1MAvstM1nWPMP/d8PIrasA/SyjQwoLDmXI7z0c70=;
 b=GdugVH4JEfVl0RySiMeJtwqXbnCInj8TVTNXtBtjF+gitqHzNefVJ/5vP2Rkw95c0ZCOl0
 UXiboGf4wLAQbuTeTGVAxhp6HTkvy3qksRGBMMWRhWg3+IEH3jSg6+f4D84iOQkvi/Rvgk
 cJE9PvnIGGoZgBHAMn5GW4ds41h4LWs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-eyd-CWzfO7mJ8IDaO90_vQ-1; Fri, 12 Sep 2025 23:52:49 -0400
X-MC-Unique: eyd-CWzfO7mJ8IDaO90_vQ-1
X-Mimecast-MFC-AGG-ID: eyd-CWzfO7mJ8IDaO90_vQ_1757735568
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3db4cfcc23eso1116870f8f.3
 for <qemu-devel@nongnu.org>; Fri, 12 Sep 2025 20:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757735568; x=1758340368;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=slp1MAvstM1nWPMP/d8PIrasA/SyjQwoLDmXI7z0c70=;
 b=PfXsLJNZaUBsEMAF3PMhEwXj2wQni4AzxxVp20qydX1iksWkfbrNOeA70wXxvycKcB
 fHQOa4z58LKyGaqT5cXDs9xwwB5t4tI1rM3DWeiCh0w7NZSHfa8FvD5NvF+7vMcLJryJ
 Y0Dga4WXaL39G4Z5kO726BHDQ69irkkm8dVRqFzrDpmArCCPII09zlqAkO4QamK5LfAP
 Aopbfz+xKGBqm7DUPuEHuhItWlFu3oeLzuGNdA74b2SE1EQ4yNQPs4qCCs8cxWTavMLV
 fA4LRzNcFM9phzMd/kbgJfelHlWeyRi7JAOPXKNkr/ELjlef9+AxuoOjFaZ5WbnMNRKJ
 /OLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGRPdVcnyVKM7aZC1kN7jCBBSFsZgNxHc9vbauAVdy8zGFBRfTCe44OoCcfKGGpYJXRP+N2m9wY2rz@nongnu.org
X-Gm-Message-State: AOJu0YyVspdJs6vVfagJuSJNzOYW68g4DHZST+1VuiAC3VYOWgakI4R3
 PKwpN5VN4ofBSKslkcSB/FhLQmh1ManJOowjgf5z3wtqL1Dw6RdgvYT4HKNddKwH9UL/fCH7rYp
 0dw2KvxO0fVVvC337+dZq7aptKxiOLSbr5wbvlOwpR0hzzRBSyiY7u0n+
X-Gm-Gg: ASbGnctibU8VL14L7JK9p5liFJaKbno0hr6sFWN+WBEll1O9yN3QZauaJLk/ssGub0Q
 U4Z/1o4S3qA1ENeqKpHAEbNMoS2iTy3j4TLNeRhStemAvMD9b4BbKM5j2bbCn3N3PifkXK149CU
 7V9B+xz/WG3gVXmmzvRgDq9juP1KDMuviMgNQkHQr6tXxro4j5FGRbdcNjKvG3mmPDXF7kXWIgH
 sDKH3FJpb2f6FhJ7qY5TFUOuzKF4UcPR2h/nrCVPoCIi7mAMpzXbHtt3YZu0MVpiQNkQHYZxZXU
 iou114stwoUc9esvG6AdJjOUsHXCK+fNZxTFJHDy+5svOpIHUBvp7Y/X8+66tvNQomNyNmmM+u0
 GqPeiVh0uJmgJrZacE1lDdDQxeM9UVL6GAdn0KuEmzLs=
X-Received: by 2002:a05:6000:144d:b0:3e7:6312:a98f with SMTP id
 ffacd0b85a97d-3e765a48205mr5472651f8f.45.1757735567831; 
 Fri, 12 Sep 2025 20:52:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyORB/4/pM2rskl1fvtHxm0xSrLJlsdRf6mOyIp20WcwQ4frC/NpGHPzAvCl96qgb4jAocLQ==
X-Received: by 2002:a05:6000:144d:b0:3e7:6312:a98f with SMTP id
 ffacd0b85a97d-3e765a48205mr5472637f8f.45.1757735567380; 
 Fri, 12 Sep 2025 20:52:47 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-45e016b5a2esm86030015e9.13.2025.09.12.20.52.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Sep 2025 20:52:46 -0700 (PDT)
Message-ID: <15a04956-df98-4c3a-b2c7-b4812106b25b@redhat.com>
Date: Sat, 13 Sep 2025 05:52:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: when to use MemoryRegionCache vs direct address space read/write
 vs address_space_map?
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA80LakER=eZY1yK4X8CJA9Uwd-9ckLP=p4D3BJLpSTXqQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA80LakER=eZY1yK4X8CJA9Uwd-9ckLP=p4D3BJLpSTXqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/12/25 17:51, Peter Maydell wrote:
> (3) address_space_cache_init(), which initializes a MemoryRegionCache
>      which you can then use for hopefully faster read and write
>      operations via address_space_read_cached() and
>      address_space_write_cached().

(And the cached ld/st variants as well)

>      Again, subject to limitations: must operate on RAM;

You can operate on non-RAM but it will not be any faster.

>      you might not be able to access the whole
>      range you wanted. This currently seems to be used solely by
>      virtio.

Indeed.  The APIs compare like this

              fast            gives void*          limits
direct         -                  -                  -
map            y                  y           1 MR, 1 bounce buffer
cached         y                  -                1 MR

MemoryRegionCache has the additional complication of needing a 
MemoryListener to invalidate the cache, if the MemoryRegionCache is long 
lived.  This could be done globally, it just wasn't necessary while 
virtio was the only user.

You could create a MemoryRegionCache for the duration of (say) a single 
function call, and then you don't need to deal with invalidation; but 
then the single bounce buffer limitation is not a problem and map/unmap 
is probably easier to use.

> In particular, I'm working on a GICv5 model. This device puts a
> lot of its working data structures into guest memory, so we're going
> to be accessing guest memory a lot. The device spec says if you point
> it at not-RAM you get to keep both pieces, and requires the guest
> not to try to change the contents of that memory underfoot without
> notifying it, so this seems like it ought to be a good candidate
> for some kind of "act like you have this memory cached so you don't
> need to keep looking it up every time" API...

Yes, that is indeed a good use.

> Does the MemoryRegionCache API cover all the use cases we use
> address_space_map() and dma_memory_map() for? (i.e. could we
> deprecate the latter and transition code over to the new API?)

No, there's no way to get a void* from MemoryRegionCache (you could get 
one when the underlying block is RAM by peeking at the struct members; 
but there's no bounce buffering by design).

> Incidentally, on the subject of the dma.h wrappers -- I've never
> really been very clear why we have these. Some devices use them,
> but a lot do not. 

All PCI devices use them.

> The fact that the dma wrappers put in smp_mb()
> barriers leaves me wondering if all those other devices that
> don't use them have subtle bugs, but OTOH I've never noticed
> any problems...

The idea was that PCI specifies the ordering of DMA operations and the 
memory barrier provides that ordering when the operations are performed 
by the host CPU.

In practice the cases in which ordering is required are limited, and 
personally I prefer to write these barriers in the device model so that 
the synchronization algorithm is documented.  That means you can use 
map/unmap or MemoryRegionCache instead, both of which are also faster.

The original and more unique DMA wrapper is dma_blk_io(), which is a 
wrapper around block layer APIs that supports cross-memory-region 
operations and the fact that the address_space_map() bounce buffer is 
only 1 page long.  This one, which works together with QEMUSGList, is 
used in several block device models (IDE, SCSI, NVMe).

Paolo


