Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B8DC3601E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 08:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1hof-0000pd-HS; Mon, 07 Apr 2025 04:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u1hoc-0000pK-DU
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 04:26:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u1hoZ-0002Lv-7S
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 04:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744014401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rw0hx7M785dug5yAWHxbDxo/c6pNH/3vM+pfKNy+tP0=;
 b=hj5V3TiSzWm5cJmTJFGoFC/9KnUtPKv+1GeAEE2GmfZ7j2kxLBhPfB+yEzimcEBFC7qVIV
 UK+OpWzKx6Kon9fb6wT/tLhORcL5rajdkt/w3xE85ZBOQnLFSjdZmDKXUJMk2WVbDpkjEd
 dG50W2uFxdUiM8XMZ3cIXw+XBZDWBY8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-f-1AqxK0M7iWBaO4FGX4hg-1; Mon, 07 Apr 2025 04:26:39 -0400
X-MC-Unique: f-1AqxK0M7iWBaO4FGX4hg-1
X-Mimecast-MFC-AGG-ID: f-1AqxK0M7iWBaO4FGX4hg_1744014398
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3912539665cso2604652f8f.1
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 01:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744014398; x=1744619198;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rw0hx7M785dug5yAWHxbDxo/c6pNH/3vM+pfKNy+tP0=;
 b=rwQdeZ7Oovs3kJJFs4c9JziG5wh/nvB4zXOrK5Nktddxop32OgO1gumvpd8Uob1mrr
 +whH2YaA8lK3n4z0tijROqSpWKBKX4aSdJkmChaQTi6wPjNUHtnYaX+pTas3RFdJ7JF1
 OnrELqjIvU3zmzszLTQ1blwqRheh5qEsOC6OxajM1SVsEmnrKiMnUaE+e9EvG6bbEi7m
 EVsI6tiPsUsFAD5LVmRg7HlREt3dLqOek4SuSCSIoR+rnXnobR3AUZkQd+hMZw1ErAKO
 fxfN2YA1KOYcDlYuZvhFpOKQPcDWrBqRqanxeI1VW/3oYFJQDS0HesLETQjzmoQhL/Rj
 CANQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWMx78UpfNvjXHDiIOrbX0+9qb3wu8lenoiSsmtk1doxApdxgNxGnA+OQGqaX5A4VJH5Bxw9Do46i3@nongnu.org
X-Gm-Message-State: AOJu0YzhxAtMl49Q9OZbM8UrCWSoDDaV5/rC17xCAojJoxheWmJojxAP
 WDPxLjDqkwYWbxgQwdiJF1G7aHt/4RSi2M+aVT1IdwREyRpxv3eJCW21WVzNYrMk0JwkNClyo+i
 6wVO2Mv1DbPqBy1rtP9Rsr0SivnVgrMXIJ4Bz3k0RGhAcRdAcF/c0
X-Gm-Gg: ASbGncvlV5taCgDC9GfJBnhgcSUrA/PXmmO99jms2ohETwW9GKO9bOAe7/RKOD5TITP
 r9G6ihNaJWLhsJ4ylr7kWXf24QCdJIPeQTtt/4Bn0bZr8H/DFPd5shzQBDm4uwVgQVGBtUUjmek
 oQT6/ULLea6Gshut5k75p2ZkGt3AaLLduXRdKzzlxLSvI3H8auss6EsYmu16EYfQsXDXDkOtbur
 uMTANCProtWqELl+fCLp/XR9wP0rTYfL+OXf9Q1KwDkxJ0tcdPVeGnznsPQwKp71fF3JVkO5X1l
 7kgECp8t8g8hm0COXXL/2a/iWn0Ep2YXeAFCf7zNyTIFTcJ7y7YMaA==
X-Received: by 2002:a05:6000:400e:b0:39c:e0e:b6d1 with SMTP id
 ffacd0b85a97d-39c2e6112ddmr13186604f8f.12.1744014398387; 
 Mon, 07 Apr 2025 01:26:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUo406xmTmBdiQBd4OSO6DDwUjYE4If1FN2FdqTl96krCe2gNAnUKv84d3RzD9huTiw7ipZg==
X-Received: by 2002:a05:6000:400e:b0:39c:e0e:b6d1 with SMTP id
 ffacd0b85a97d-39c2e6112ddmr13186587f8f.12.1744014398055; 
 Mon, 07 Apr 2025 01:26:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec366aa29sm122496235e9.39.2025.04.07.01.26.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 01:26:37 -0700 (PDT)
Message-ID: <0a3e113d-2ffe-4d7f-9d12-cc0f2fcd16ad@redhat.com>
Date: Mon, 7 Apr 2025 10:26:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 v2 11/37] vfio: Introduce new files for
 VFIORegion definitions and declarations
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 John Levon <john.levon@nutanix.com>, Joao Martins <joao.m.martins@oracle.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-12-clg@redhat.com>
 <SJ0PR11MB6744636C2266BA6A6837CB8D92A12@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <b0b5b230-4be8-4406-9ed2-978e9bcd4713@redhat.com>
 <SJ0PR11MB6744784C71F86B276A0B31BD92AA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <SJ0PR11MB6744784C71F86B276A0B31BD92AA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.659,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 4/7/25 09:53, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH for-10.1 v2 11/37] vfio: Introduce new files for VFIORegion
>> definitions and declarations
>>
>> On 3/27/25 10:37, Duan, Zhenzhong wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Cédric Le Goater <clg@redhat.com>
>>>> Subject: [PATCH for-10.1 v2 11/37] vfio: Introduce new files for VFIORegion
>>>> definitions and declarations
> ...
>> 3f002252acfb7ac809107c99bdbdbaf66d56a50d..4591ec68da877b307f43ea1a83
>>>> 0c315721b57e9e 100644
>>>> --- a/hw/vfio/pci-quirks.c
>>>> +++ b/hw/vfio/pci-quirks.c
>>>> @@ -26,6 +26,7 @@
>>>> #include "hw/qdev-properties.h"
>>>> #include "pci.h"
>>>> #include "pci-quirks.h"
>>>> +#include "hw/vfio/vfio-region.h"
>>>
>>> This looks unnecessary as pci.h already include it,
>>
>> It doesn't but it should. I will include "hw/vfio/vfio-region.h"
>> in "pci.h" and remove it from  "pci-quirks.c" and "pci.c" instead.
> 
> hw/vfio/pci.h includes hw/vfio/vfio-display.h which further includes include/hw/vfio/vfio-region.h, build pass if only remove #include on my env.

Indeed. Still, I'd rather add "hw/vfio/vfio-region.h" in "pci.h" too
because it is used in VFIOBAR.


Thanks,

C.


