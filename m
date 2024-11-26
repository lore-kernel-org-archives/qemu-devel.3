Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DC3D3B996
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 14:47:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFwpp-00043o-27; Tue, 26 Nov 2024 09:46:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tFwpn-00043Z-3j
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:46:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tFwpl-0006Os-2o
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:46:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732632390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OM3KlEC6LYcGl9lOceCER6TDVM2iQDHubZ/D452Bjc4=;
 b=RspOpTNmB7S4kykXQjm5scW37tGBMcUjZ/pIF66EadYz9a9FgYqLpa1Tn6GrFJQ8DLRaoi
 wCs2HqjZrFYReuYP6e9YG3miG8HgC91Awbe5q9SGo4Rwj/6LSxGH3pCCLd6SQlPaJHFh7J
 GiISPSIZ9ri1Nwf1HPJ4iM13etUau5Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-6XdWY0RTNpWUgQ4b_zaNfQ-1; Tue, 26 Nov 2024 09:46:28 -0500
X-MC-Unique: 6XdWY0RTNpWUgQ4b_zaNfQ-1
X-Mimecast-MFC-AGG-ID: 6XdWY0RTNpWUgQ4b_zaNfQ
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38256bf4828so2943489f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 06:46:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732632387; x=1733237187;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OM3KlEC6LYcGl9lOceCER6TDVM2iQDHubZ/D452Bjc4=;
 b=VQPFE2ouehT6BuKOpaO+Gp6wLED4a/lZVba5sbwo4c7vcCZ2s1XZUBDHPAs2saTZYc
 Ef62HuNcIqeydxrITY7RthmaqF/pr6GRUKh5TaaP7BVn4Vio4FtlMv81A3NOiJRxi7hg
 xfx/KFpmgpw8ncvhJxRQ/NCQv7GE72GZSmdV0JCvrBZklKQcOASY6pEYWy5LfiSCF6tG
 a10JieYygeVyXEVo+icBVNW40Vb2s3UCVv9uacO+CoQkpyJtmAvvQVDVHKCWXjV0U03X
 4u5r3N1US8Qog2R7wrwiC7m+DXOqqVJ2xkoqkBSeM/gXQ/MYX1RcALVAxCd2NTXpEqUZ
 GIHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTNsja2c6d7tHq6vO3/g1n858LRssU9KvhMTQQhXHLvvyjw/wXB6nItQsNHaFbVkhuMHnh+DI2qEuV@nongnu.org
X-Gm-Message-State: AOJu0Yw2IGEIlV/HQJPQGcH5/uYpfoWcYiS00uJu8etLgTRvoX4AZ4tu
 SEDFVDSTMxvvi04mbLRHTo16ihSaFpTzSPTSLK4esbE7evgvHHUcHluKJMwFFlQwNaIMW+HRn06
 Mq4cWDHi/DTa2pRd4VQSU5yM2vVAsor/ePOy5uP+nH3TMseyYE/wJ
X-Gm-Gg: ASbGncvLSjpStQMC8a1QL9qiuhpFB8080/cFraOmFVHBP7Z1ZoIlm/fVoidetwtSoiM
 Omj49q2lOcNX1cqZPjMp7xyehHqu1HcqUyCKnHSRcy5k3e4h6YE3SBRZQ4wthHJl+xLyThHzWSB
 dG1r9ssVOyUzEjfNdJgh5jMpBbjfK2xzvyHMdeoxtji+CysebXea+yTJP1G3KOwO+uZXGCn8MmM
 U2CXikBLR+K4Osn+chpg60gydo46lVjoj2HETOouLgp6PKF58uPAZOdiMFAFP7eXslXl9/DMHCt
 u4kqWGM1CnkiYe3vx+lnReKLgpqbLsHBbgT/8cjdKN/OGtxSeQKqJC4U9eYYlacktuIme9QoT5L
 5pw==
X-Received: by 2002:a05:6000:184c:b0:381:ed32:d604 with SMTP id
 ffacd0b85a97d-385bfaea7e1mr3257184f8f.10.1732632387307; 
 Tue, 26 Nov 2024 06:46:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/tyMFoqAS0Uj9qLtt4wdKyd1v6Afnyn6tcsmqYHMHcIEiDRMrmXU5Wn1jJJt5yq9ef8K7Fg==
X-Received: by 2002:a05:6000:184c:b0:381:ed32:d604 with SMTP id
 ffacd0b85a97d-385bfaea7e1mr3257161f8f.10.1732632386897; 
 Tue, 26 Nov 2024 06:46:26 -0800 (PST)
Received: from ?IPV6:2003:cb:c72d:e900:38f3:8bdd:52f7:5e83?
 (p200300cbc72de90038f38bdd52f75e83.dip0.t-ipconnect.de.
 [2003:cb:c72d:e900:38f3:8bdd:52f7:5e83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb36612sm13446807f8f.59.2024.11.26.06.46.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 06:46:26 -0800 (PST)
Message-ID: <553cf07a-a603-402d-8e86-b4ada42a2dcd@redhat.com>
Date: Tue, 26 Nov 2024 15:46:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio/virtio-mem: Prohibit unplugging when size <=
 requested_size
To: Wei Chen <weichenforschung@gmail.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, yuval.yarom@rub.de, genkin@gatech.edu,
 Zhi Zhang <zzhangphd@gmail.com>
References: <20241126080213.248-1-weichenforschung@gmail.com>
 <2ac194a7-9790-4aa7-bb41-65f8bb21f616@redhat.com>
 <f02565f6-c584-44d0-944f-26c062cc2be9@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f02565f6-c584-44d0-944f-26c062cc2be9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
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

On 26.11.24 15:20, Wei Chen wrote:
>   > Please provide more information how this is supposed to work
> 

Thanks for the information. A lot of what you wrote belongs into the 
patch description. Especially, that this might currently only be 
relevant with device passthrough + viommu.

> We initially discovered that virtio-mem could be used by a malicious
> agent to trigger the Rowhammer vulnerability and further achieve a VM
> escape.
> 
> Simply speaking, Rowhammer is a DRAM vulnerability where frequent access
> to a memory location might cause voltage leakage to adjacent locations,
> effectively flipping bits in these locations. In other words, with
> Rowhammer, an adversary can modify the data stored in the memory.
> 
> For a complete attack, an adversary needs to: a) determine which parts
> of the memory are prone to bit flips, b) trick the system to store
> important data on those parts of memory and c) trigger bit flips to
> tamper important data.
> 
> Now, for an attacker who only has access to their VM but not to the
> hypervisor, one important challenge among the three is b), i.e., to give
> back the memory they determine as vulnerable to the hypervisor. This is
> where the pitfall for virtio-mem lies: the attacker can modify the
> virtio-mem driver in the VM's kernel and unplug memory proactively.

But b), as you write, is not only about giving back that memory to the 
hypervisor. How can you be sure (IOW trigger) that the system will store 
"important data" like EPTs?

> 
> The current impl of virtio-mem in qemu does not check if it is valid for
> the VM to unplug memory. Therefore, as is proved by our experiments,
> this method works in practice.
> 
>   > whether this is a purely theoretical case, and how relevant this is in
>   > practice.
> 
> In our design, on a host machine equipped with certain Intel processors
> and inside a VM that a) has a passed-through PCI device, b) has a vIOMMU
> and c) has a virtio-mem device, an attacker can force the EPT to use
> pages that are prone to Rowhammer bit flips and thus modify the EPT to
> gain read and write privileges to an arbitrary memory location.
> 
> Our efforts involved conducting end-to-end attacks on two separate
> machines with the Core i3-10100 and the Xeon E2124 processors
> respectively, and has achieved successful VM escapes.

Out of curiosity, are newer CPUs no longer affected?

> 
>   > Further, what about virtio-balloon, which does not even support
>   > rejecting requests?
> 
> virtio-balloon does not work with device passthrough currently, so we
> have yet to produce a feasible attack with it.

So is one magic bit really that for your experiments, one needs a viommu?

The only mentioning of rohammer+memory ballooning I found is: 
https://www.whonix.org/pipermail/whonix-devel/2016-September/000746.html

> 
>   > I recall that that behavior was desired once the driver would support
>   > de-fragmenting unplugged memory blocks.
> 
> By "that behavior" do you mean to unplug memory when size <=
> requested_size? I am not sure how that is to be implemented.

To defragment, the idea was to unplug one additional block, so we can 
plug another block.

> 
>   > Note that VIRTIO_MEM_REQ_UNPLUG_ALL would still always be allowed
> 
> That is true, but the attacker will want the capability to release a
> specific sub-block.

So it won't be sufficient to have a single sub-block plugged and then 
trigger VIRTIO_MEM_REQ_UNPLUG_ALL?

> 
> In fact, a sub-block is still somewhat coarse, because most likely there
> is only one page in a sub-block that contains potential bit flips. When
> the attacker spawns EPTEs, they have to spawn enough to make sure the
> target page is used to store the EPTEs.
> 
> A 2MB sub-block can store 2MB/4KB*512=262,144 EPTEs, equating to at
> least 1GB of memory. In other words, the attack program exhausts 1GB of
> memory just for the possibility that KVM uses the target page to store
> EPTEs.

Ah, that makes sense.

Can you compress what you wrote into the patch description? Further, I 
assume we want to add a Fixes: tag and Cc: QEMU Stable 
<qemu-stable@nongnu.org>

Thanks!

-- 
Cheers,

David / dhildenb


