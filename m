Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA73CEF148
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 10:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy7Qs-0004d5-TM; Tue, 08 Oct 2024 06:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sy7Qr-0004cw-Bz
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 06:27:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sy7Qp-0006pE-Je
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 06:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728383226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KkzsuZpkUoHA4tnvEk06zqkHt3rqbVbTIi5XjjeJ5Ko=;
 b=NBsl8PXp5Wcc8tdtT3Q+0YA2rzUqi/yDqowBr6UMcUGE+NqVujLWkgDBPKsG/P6ub8MjEM
 RtYsr1BomTSXtFuXlmSCaE7BMWNAIClNA3r2Kf/F/5uPdkwt/LfGg14QSXht4GtHvzsAEq
 KsAv6jDkv9Vw+F3/YXLjqRDYjAqRDZc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-PYLS8sSuMDS9iqjcMvFTaw-1; Tue, 08 Oct 2024 06:27:05 -0400
X-MC-Unique: PYLS8sSuMDS9iqjcMvFTaw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb5f6708aso35000975e9.2
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 03:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728383224; x=1728988024;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KkzsuZpkUoHA4tnvEk06zqkHt3rqbVbTIi5XjjeJ5Ko=;
 b=nEmRAlyWgYgVfiya0n+3WNtNNIoTF4oivdCNojxXii+EaKNxSfnQCZ2OP7z5VdBet4
 IEGjeS4riSN/QiDzQOQ2vpWET+vWJWjFmeqrXk1iSij4NiFbrA7rOKR1KrOAu52S2NtF
 NJE4vXu2293dCOqXA9EUd3bZ3h31ee3td+l5husacwPBJKXZ3vQyYkhCigO7Fli9JD1x
 ogBBgiTs4DIpuj5r7AfmPIX4WXDz0rmbpgem9AIesEyTb3pG6FJuFLZEwitHuwmA6Qq+
 sE/Mw0iob/1NXUbh+phvR1/hWC3asTtIZFdcgeTnwWPBuDmq9837NkW2B+D59OpIbElQ
 gvnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4WQuFri/T8ndX5xHE6fSNC6oOrSCkiU86xMcz9uy7kfe6rv39bi5Cd/GBsWJX6Z70qlEKBUjgnkHe@nongnu.org
X-Gm-Message-State: AOJu0YzST++8D1gN5K8QDdDbo6dAbQBGRK2tlnnLOH9NGjmVFtzdUq2s
 6IasGpKJS1MKpMfI/gQ4tqXFZoKueCsnVl4VYunx9bWj56P2feHK82DBvxB702WPFJutPjSyCds
 1xgsMsEGVV9eBV5uGBV++VaPw9oFNo9c+x0c1OWWgsiX7wFSQ/24h
X-Received: by 2002:a05:600c:5359:b0:430:54a4:5b02 with SMTP id
 5b1f17b1804b1-43054a45cebmr8935595e9.34.1728383223725; 
 Tue, 08 Oct 2024 03:27:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGNQSJxXfxVtcA4f9O95Xk2Y+UK9nwOWbXj4ICSgW+j3Gc2Q8RZBpFu+PUJKPCGC1Y9mGadA==
X-Received: by 2002:a05:600c:5359:b0:430:54a4:5b02 with SMTP id
 5b1f17b1804b1-43054a45cebmr8935385e9.34.1728383223301; 
 Tue, 08 Oct 2024 03:27:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72f:c700:a76f:473d:d5cf:25a8?
 (p200300cbc72fc700a76f473dd5cf25a8.dip0.t-ipconnect.de.
 [2003:cb:c72f:c700:a76f:473d:d5cf:25a8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86a0a8a0sm123138475e9.6.2024.10.08.03.27.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2024 03:27:02 -0700 (PDT)
Message-ID: <9db8c23d-aac4-45bc-b771-8ba62e75dfe7@redhat.com>
Date: Tue, 8 Oct 2024 12:27:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] virtio-pci: fix memory_region_find for
 VirtIOPCIRegion's MR
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gao Shiyuan <gaoshiyuan@baidu.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, zuoboqun@baidu.com,
 thuth@redhat.com, alxndr@bu.edu, peterx@redhat.com, qemu-devel@nongnu.org,
 imammedo@redhat.com
References: <20240924011156.48252-1-gaoshiyuan@baidu.com>
 <8d7b35ba-f9fa-446f-ac8b-471587c7666e@redhat.com>
 <20240930100043-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240930100043-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
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

On 30.09.24 16:00, Michael S. Tsirkin wrote:
> On Tue, Sep 24, 2024 at 02:31:20PM +0200, David Hildenbrand wrote:
>> On 24.09.24 03:11, Gao Shiyuan wrote:
>>
>> Make sure to version your patch series. For example, via
>> 	$ git format-patch -v1 ...
>>
>>> As shown below, if a virtio PCI device is attached under a pci-bridge, the MR
>>> of VirtIOPCIRegion does not belong to any address space. So memory_region_find
>>> cannot be used to search for this MR.
>>
>> I'm starting to wonder if memory_region_find() is really the right fun
>>
>>>
>>> Introduce the virtio-pci and pci_bridge_pci address spaces to solve this problem.
>>>
>>> Before:
>>> memory-region: pci_bridge_pci
>>>     0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
>>>       00000000fe200000-00000000fe200fff (prio 1, i/o): virtio-blk-pci-msix
>>>         00000000fe200000-00000000fe20016f (prio 0, i/o): msix-table
>>>         00000000fe200800-00000000fe200807 (prio 0, i/o): msix-pba
>>>       000000a000400000-000000a000403fff (prio 1, i/o): virtio-pci
>>>         000000a000400000-000000a000400fff (prio 0, i/o): virtio-pci-common-virtio-blk
>>>         000000a000401000-000000a000401fff (prio 0, i/o): virtio-pci-isr-virtio-blk
>>>         000000a000402000-000000a000402fff (prio 0, i/o): virtio-pci-device-virtio-blk
>>>         000000a000403000-000000a000403fff (prio 0, i/o): virtio-pci-notify-virtio-blk
>>>
>>> After:
>>> address-space: pci_bridge_pci
>>>     0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
>>>       00000000fe200000-00000000fe200fff (prio 1, i/o): virtio-blk-pci-msix
>>>         00000000fe200000-00000000fe20016f (prio 0, i/o): msix-table
>>>         00000000fe200800-00000000fe200807 (prio 0, i/o): msix-pba
>>>       000000a000400000-000000a000403fff (prio 1, i/o): virtio-pci
>>>         000000a000400000-000000a000400fff (prio 0, i/o): virtio-pci-common-virtio-blk
>>>         000000a000401000-000000a000401fff (prio 0, i/o): virtio-pci-isr-virtio-blk
>>>         000000a000402000-000000a000402fff (prio 0, i/o): virtio-pci-device-virtio-blk
>>>         000000a000403000-000000a000403fff (prio 0, i/o): virtio-pci-notify-virtio-blk
>>>
>>> address-space: virtio-pci
>>>     000000a000400000-000000a000403fff (prio 1, i/o): virtio-pci
>>>       000000a000400000-000000a000400fff (prio 0, i/o): virtio-pci-common-virtio-blk
>>>       000000a000401000-000000a000401fff (prio 0, i/o): virtio-pci-isr-virtio-blk
>>>       000000a000402000-000000a000402fff (prio 0, i/o): virtio-pci-device-virtio-blk
>>>       000000a000403000-000000a000403fff (prio 0, i/o): virtio-pci-notify-virtio-blk
>>>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2576
>>> Fixes: ffa8a3e ("virtio-pci: Add lookup subregion of VirtIOPCIRegion MR")
>>
>> Commit id is not unique. Use 12 digits please.
>>
>> I'm still not quite sure if memory_region_find() is really the right thing
>> to use here, but I'm no expert on that so I'm hoping virtio/PCI people can
>> review.
> 
> I donnu, what would you use?

I assume there is currently not better alternative. Scanning all address 
spaces to find+walk a flatview sounds quite wasteful during each 
virtio_address_space_lookup ...

So this change here looks ok to me for the time being.

-- 
Cheers,

David / dhildenb


