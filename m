Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602A1D609C3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 09:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGEUD-0004fr-30; Wed, 27 Nov 2024 04:37:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tGEUA-0004fJ-8s
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 04:37:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tGEU8-0003kg-Q2
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 04:37:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732700242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aAy+X/wiZX7TshisqenZ6nOGmeL+IPOiIH1O88pWFMA=;
 b=ccho8M6e7WqXwSh1Y2rJDQeU+vpUK7ufl4iiTK4nELCS+V5ey0Mmyz8iwcRp86SnYGNvM9
 1EFg0GlCLC/H0TchOObuvSBUSeuD6kN62cqxsNT5tp13qAnUvtdHBm9clBj16dQLwyJMwW
 Md7ey0ApmZVDNILfbU4xMx5qlyAI4LE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-zQNy_rP5PvyVRcLhF9jgZQ-1; Wed, 27 Nov 2024 04:37:18 -0500
X-MC-Unique: zQNy_rP5PvyVRcLhF9jgZQ-1
X-Mimecast-MFC-AGG-ID: zQNy_rP5PvyVRcLhF9jgZQ
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ffd1bb0f13so10982871fa.3
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 01:37:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732700235; x=1733305035;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=aAy+X/wiZX7TshisqenZ6nOGmeL+IPOiIH1O88pWFMA=;
 b=WUcQkIpxSdehswxYQ6deb8db19qHaFX5NVziL5hbyUPLGe6ABybNiFLB9xi4FM6+5I
 3UNAemhrNem3TRT5kmw/jg4Xq72mog17Yfbkuvg6EGNptzgFP54Fgo8/cfKkwhqnoiDm
 rfsIi9jSquGJQQ9adrg+5aFYfhIgphglxhpWKuElZV5AAsQYM7eLJBN+FwG4fIp7A5rC
 poj3qmZKplsrQ6wU5IZAj0vNoZ7jI2ITpcgl4Ka/y9H9P1y9OyDKE3p00RTseMbeE3wo
 r4EURDeqb40CCKADbxLQ4EMHy4KFqAIPgBuG4h6PVu0paHXSlGfu+qzznK2auMG9sne4
 megA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVs7sMzJ/tH1DnsL2IKfjgnk/wdyPcyw0/heCVFRVBgGEOjaWTH20kWCT3auid6rk8HKCTr3AC479r4@nongnu.org
X-Gm-Message-State: AOJu0YznkoasB7a9pbSoybO2+9iAuQcCmb5XUtyxOrXdhCmDy0tFwJ8s
 QuyamnRk+TIIr6s1hZeKS+OmCz3rgAk3OuooaaHkj1upKctRHkHIGaYLrcPv56c2CmrFHfjrbr2
 /OOrWSHnj4YvAuIOlxxb1j/W6vicKFI877FNVC7BYCTj9bMnHVmoU
X-Gm-Gg: ASbGnctSl2KkqnZHRT7l4jzaeNgUlo0VJ18dVNuS43XsVx2hrNO3+pa2g1uN1lFDekc
 K8vSwbuiMt/y3sI5JvKQM+ZvM9idb7xIHQBu4pJQgGRofT/4v8D4iRvlbws0FFNOx93cIbYt71l
 phtzxsw8kGjcjZxao+x0AqcVbmCaXhnTIjIRtC4BA+YQFsGjAGEQvao2y3glpQUmS+j25lSjAgy
 LTEP8zzMse2Ib7w9nQHrGjKXaSgCUqDleKUkcDxG8XS3NwIrZVO88x7ChIpd+KzSfcajYXluBub
 CDAcX25jqpNlTJpdorwXGrzUalqHNBVxCagG5oiiAjMWtYKtmnr0dxPJCjNCUykmXt5S4ySSO6a
 /oQ==
X-Received: by 2002:a05:6512:400f:b0:53d:a93c:649e with SMTP id
 2adb3069b0e04-53df0109024mr1232154e87.35.1732700235074; 
 Wed, 27 Nov 2024 01:37:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5sVjzI37672hl/NSIKUWk/NkXG+B4QhnPMEInZogGK9+cOlhPetO4a2ujfscOB8UZxQknaQ==
X-Received: by 2002:a05:6512:400f:b0:53d:a93c:649e with SMTP id
 2adb3069b0e04-53df0109024mr1232137e87.35.1732700234689; 
 Wed, 27 Nov 2024 01:37:14 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:be00:66fa:83a6:8803:977e?
 (p200300cbc70dbe0066fa83a68803977e.dip0.t-ipconnect.de.
 [2003:cb:c70d:be00:66fa:83a6:8803:977e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa7e5285sm15260005e9.40.2024.11.27.01.37.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 01:37:13 -0800 (PST)
Message-ID: <a140606e-5f86-4e8b-a818-2db2493ab8a6@redhat.com>
Date: Wed, 27 Nov 2024 10:37:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio/virtio-mem: Prohibit unplugging when size <=
 requested_size
To: zhi zhang <zzhangphd@gmail.com>
Cc: Wei Chen <weichenforschung@gmail.com>, qemu-devel@nongnu.org,
 mst@redhat.com, yuval.yarom@rub.de, genkin@gatech.edu
References: <20241126080213.248-1-weichenforschung@gmail.com>
 <2ac194a7-9790-4aa7-bb41-65f8bb21f616@redhat.com>
 <f02565f6-c584-44d0-944f-26c062cc2be9@gmail.com>
 <553cf07a-a603-402d-8e86-b4ada42a2dcd@redhat.com>
 <93616a1e-3614-49ca-9515-697f1c9205b6@gmail.com>
 <9eafe8fa-de09-40e3-9687-573255ce37de@redhat.com>
 <CAD-9bcdm+gupZQ91Q-JMjuPikVmfVhCdJuwq=ptfaipL7Peevg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAD-9bcdm+gupZQ91Q-JMjuPikVmfVhCdJuwq=ptfaipL7Peevg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 27.11.24 03:00, zhi zhang wrote:
> 
> 
> On Tue, Nov 26, 2024 at 11:52 PM David Hildenbrand <david@redhat.com 
> <mailto:david@redhat.com>> wrote:
> 
>     On 26.11.24 16:31, Wei Chen wrote:
>      >   > How can you be sure (IOW trigger) that the system will store
>      >   > "important data" like EPTs?
>      >
>      > We cannot, but we have designed the attack (see below) to improve the
>      > possibility.
>      >
>      >   > So is one magic bit really that for your experiments, one needs a
>      >   > viommu?
>      >
>      > Admittedly the way we accomplish a VM escape is a bit arcane.
> 
>     That's what I imagined :)
> 
>      >
>      > We require device passthrough because it pins the VM's memory
>     down and
>      > converts them to MIGRATE_UNMOVABLE.
> 
>     Interesting, that's news to me. Can you share where GUP in the kernel
>     would do that?
> 
> 
> In /drivers/vfio/vfio_iommu_type1.c, there is a function called 
> vfio_iommu_type1_pin_pages where VM's memory is pinned down.

That doesn't explain the full story about MIGRATE_UNMOVABLE. I assume 
one precondition is missing in your explanation.

VFIO will call pin_user_pages_remote(FOLL_LONGTERM). Two cases:

a) Memory is already allocated (which would mostly be MIGRATE_MOVABLE, 
because it's ordinary user memory). We'll simply longterm pin the memory 
without changing the migratetype.

b) Memory is not allocated yet. We'll call 
faultin_page()->handle_mm_fault(). There is no FOLL_LONGTERM 
special-casing, so you'll mostly get MIGRATE_MOVABLE.


Now, there is one corner case: we disallow longterm pinning on 
ZONE_MOVABLE and MIGRATE_CMA. In case our user space allocation ended up 
on there, check_and_migrate_movable_pages() would detect that the memory 
resides on ZONE_MOVABLE or MIGRATE_CMA, and allocate a destination page 
in migrate_longterm_unpinnable_folios() using "GFP_USER | __GFP_NOWARN".

So I assume one precondition is that your hypervisor has at least some 
ZONE_MOVABLE or CMA memory? Otherwise I don't see how you would reliably 
get MIGRATE_UNMOVABLE.

> 
> 
>      > Hotplugged memory will also be
>      > converted to MIGRATE_UNMOVABLE.
> 
>     But that's in the VM? Because we don't hotplug memory in the hypervisor.
> 
> 
> Yes, the virtio-mem driver in the VM is modified to actively release 
> memory vulnerable to Rowhammer.

I think I now understand that statement: Memory to-be-hotplugged to the 
VM will be migrated to MIGRATE_UNMOVABLE during longterm pinning, if it 
resides on ZONE_MOVABLE or MIGRATE_CMA.

> For more details, would you be interested in reading our paper? It was 
> recently submitted to ASPLOS for publication and we are happy to share 
> it with you.

Yes, absolutely! Please send a private mail :)

-- 
Cheers,

David / dhildenb


