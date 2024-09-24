Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDECCCF9C6F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 12:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st4hZ-0001s8-Jz; Tue, 24 Sep 2024 08:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1st4hU-0001rF-Pj
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 08:31:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1st4hS-0004Pk-Mx
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 08:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727181085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xR3cBksH8YBYZKKSMhl3OBxctJvhAZnllvDWo8+OKmM=;
 b=iFMVJHrHm8nt+KoU86SfRP2PSvscMNSEaZuw1bgwWIDUy3UIUUmpxcUnIJEka3RMG5mqPf
 sE+VWbgR7fmiPc3bZUZxXv1/cBZF6dA32EqfE+sNo9HYzid0gsNOJqKUAiCJFybeGjnp9o
 /aGpDlXvBgOXnoUgFxKZ96gbrwerH+Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-rpvSq0FyMv-o6HEaSuxbuQ-1; Tue, 24 Sep 2024 08:31:24 -0400
X-MC-Unique: rpvSq0FyMv-o6HEaSuxbuQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42cb6f3c476so42911215e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 05:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727181083; x=1727785883;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xR3cBksH8YBYZKKSMhl3OBxctJvhAZnllvDWo8+OKmM=;
 b=ACttoa0tRnUR6cIaQmWghhEl3Ajm7NxKQ2FtnWxoq3VPBA8+yrPmfgxfiQspjAGPBa
 9dLFC3ygO5yH6dffexcQYy/3K/yx6VGB02hrnx+KWCB3q7t9KH45vuX2Mw0brcV4kG8J
 y83YffwKH1BgXpxvMNj4/uLIAaze+cg4Ahzh4EOsag4RDrwdmstqfV1EcwbCYTurZgZX
 IVpcZyh0UmCa/w56ZeaZfMDMFPoqm7f9N/xMx/qQK/w4CazmuYdPN3mMfwRxRqEIxHS3
 7DuYS/0x7SCctmPmVXt453Rpn8h+kE3njIX5k/qXuUzjk4oYrIHU57jYo75WoJbTGBRn
 YeLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1FGi2YjFVkNuMczSbSmOvwnRwnD2Y44cyVW5QMWSFHVXzharM/brre6IzfqixbZ1N06W1tEiL1Xae@nongnu.org
X-Gm-Message-State: AOJu0YwGbCmrRzYpEPK/LmyxOXxHL+74+LZj+zxI00EgQn/qubjGxXvR
 y0TaW+gGY0kePzZk8i2gq0GNyC0338h+uRbuQw0/I6KPyRTPmYZMvQ2bDJLCsnDkzeDIi2MiBaz
 LRqF+DSMMLZ1jLboQhTIWDjJThKTxH7+IhJ+mlmoQeryvnKw0SRAv
X-Received: by 2002:a05:600c:4ecb:b0:42c:b3e5:f688 with SMTP id
 5b1f17b1804b1-42e7abe51cfmr106300955e9.4.1727181082750; 
 Tue, 24 Sep 2024 05:31:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5blEd7G6wu2dHQmJ23dxOiRCgV+66Q58b0K4v+juHAg3Mxiog8EHOFgsjVWc8IXItjKuf9Q==
X-Received: by 2002:a05:600c:4ecb:b0:42c:b3e5:f688 with SMTP id
 5b1f17b1804b1-42e7abe51cfmr106300635e9.4.1727181082343; 
 Tue, 24 Sep 2024 05:31:22 -0700 (PDT)
Received: from [10.202.151.204] (nat-pool-brq-u.redhat.com. [213.175.37.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e902b67adsm21037885e9.34.2024.09.24.05.31.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2024 05:31:21 -0700 (PDT)
Message-ID: <8d7b35ba-f9fa-446f-ac8b-471587c7666e@redhat.com>
Date: Tue, 24 Sep 2024 14:31:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] virtio-pci: fix memory_region_find for
 VirtIOPCIRegion's MR
To: Gao Shiyuan <gaoshiyuan@baidu.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: zuoboqun@baidu.com, thuth@redhat.com, alxndr@bu.edu, peterx@redhat.com,
 qemu-devel@nongnu.org, imammedo@redhat.com
References: <20240924011156.48252-1-gaoshiyuan@baidu.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240924011156.48252-1-gaoshiyuan@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.09,
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

On 24.09.24 03:11, Gao Shiyuan wrote:

Make sure to version your patch series. For example, via
	$ git format-patch -v1 ...

> As shown below, if a virtio PCI device is attached under a pci-bridge, the MR
> of VirtIOPCIRegion does not belong to any address space. So memory_region_find
> cannot be used to search for this MR.

I'm starting to wonder if memory_region_find() is really the right fun

> 
> Introduce the virtio-pci and pci_bridge_pci address spaces to solve this problem.
> 
> Before:
> memory-region: pci_bridge_pci
>    0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
>      00000000fe200000-00000000fe200fff (prio 1, i/o): virtio-blk-pci-msix
>        00000000fe200000-00000000fe20016f (prio 0, i/o): msix-table
>        00000000fe200800-00000000fe200807 (prio 0, i/o): msix-pba
>      000000a000400000-000000a000403fff (prio 1, i/o): virtio-pci
>        000000a000400000-000000a000400fff (prio 0, i/o): virtio-pci-common-virtio-blk
>        000000a000401000-000000a000401fff (prio 0, i/o): virtio-pci-isr-virtio-blk
>        000000a000402000-000000a000402fff (prio 0, i/o): virtio-pci-device-virtio-blk
>        000000a000403000-000000a000403fff (prio 0, i/o): virtio-pci-notify-virtio-blk
> 
> After:
> address-space: pci_bridge_pci
>    0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
>      00000000fe200000-00000000fe200fff (prio 1, i/o): virtio-blk-pci-msix
>        00000000fe200000-00000000fe20016f (prio 0, i/o): msix-table
>        00000000fe200800-00000000fe200807 (prio 0, i/o): msix-pba
>      000000a000400000-000000a000403fff (prio 1, i/o): virtio-pci
>        000000a000400000-000000a000400fff (prio 0, i/o): virtio-pci-common-virtio-blk
>        000000a000401000-000000a000401fff (prio 0, i/o): virtio-pci-isr-virtio-blk
>        000000a000402000-000000a000402fff (prio 0, i/o): virtio-pci-device-virtio-blk
>        000000a000403000-000000a000403fff (prio 0, i/o): virtio-pci-notify-virtio-blk
> 
> address-space: virtio-pci
>    000000a000400000-000000a000403fff (prio 1, i/o): virtio-pci
>      000000a000400000-000000a000400fff (prio 0, i/o): virtio-pci-common-virtio-blk
>      000000a000401000-000000a000401fff (prio 0, i/o): virtio-pci-isr-virtio-blk
>      000000a000402000-000000a000402fff (prio 0, i/o): virtio-pci-device-virtio-blk
>      000000a000403000-000000a000403fff (prio 0, i/o): virtio-pci-notify-virtio-blk
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2576
> Fixes: ffa8a3e ("virtio-pci: Add lookup subregion of VirtIOPCIRegion MR")

Commit id is not unique. Use 12 digits please.

I'm still not quite sure if memory_region_find() is really the right 
thing to use here, but I'm no expert on that so I'm hoping virtio/PCI 
people can review.

-- 
Cheers,

David / dhildenb


