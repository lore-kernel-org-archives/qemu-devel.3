Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C6CC77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 09:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTdWy-0001Po-Av; Mon, 23 Jun 2025 05:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uTdWw-0001KF-8x
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 05:31:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uTdWu-00016G-GI
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 05:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750671115;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0i9D7n3jAD+mFQ7jAPCCEum/OJW1AkCc/E04brWmxw4=;
 b=ZsaKAVyYNuEd4ouvhrHHmqEXZE0+fedsVnjJE7qU35o5aV+nwviHV1MU/ipuLQEJw77vVU
 OsY3/5A+RYfzt6szZ+cIlGPzvR7UbnazY50ZArdPTdWO7w8XbQJtRMg2jlDk2hxF5uqBAW
 yHt70au4ATS15PIaB0ZYzK1t/FtfEL8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-uE_AU_DKNlWt45mfsFLpFA-1; Mon, 23 Jun 2025 05:31:52 -0400
X-MC-Unique: uE_AU_DKNlWt45mfsFLpFA-1
X-Mimecast-MFC-AGG-ID: uE_AU_DKNlWt45mfsFLpFA_1750671111
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-451ecc3be97so19879925e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 02:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750671111; x=1751275911;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0i9D7n3jAD+mFQ7jAPCCEum/OJW1AkCc/E04brWmxw4=;
 b=S4cBKqRQ8DuLj0FlV85q3JMdiK2vUxDs0cF4hz78RgbeopyWSJlK/zoh3gBeYxOqyc
 U4AUe2M/qLTfdSf0TbmpfsoUcl9/bsrIh0lRgHtZiEAJQZ57tK6pQS3W+LN31eKl4TPT
 l6TdFHy+wEeOx7tQTSi3g5imyQNj1PZxyAPe0MICn746i+ENkiEc2AyZFzwpeAYCiWS9
 gjmyZT6d72yZFhWzH77bXndCIC2XrQHiK7a3mjL3emDzmVD9HCoJ3hcG1CnQRWVhCq3n
 pS/MQjpwjS5/ezSnp/XIxopEOKo9onNPQXnaSoEkqzAvp54YYoeCV1WKO+jKZXmX0Us4
 fUiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNhTlgBporXeKQZVEwCVfl8KArqVwVrYYsOaO+raXGBQVcNSyo014kluOvWOOeT25W4ClzRKwnLusN@nongnu.org
X-Gm-Message-State: AOJu0YzDHCUS0oU6sPYLoAV0+a2NllNUSCUmBCI+/O6qnwQEMb7xwXgJ
 CJiNvfC1la/Wj8r0qr2F8xVH8LspKdqorqXUuKrbzhaHPtqU+xJMB2w0FgXrufyqAIzN7vZm/RQ
 mpcbLWdY1Fz+2MVdHDHsZMjkkpc4F4JeMIK4NfYXbFClnV7wg6Cz4Z2zW
X-Gm-Gg: ASbGncu3f+Ar0/ToRxxriOXOXYY1Q+MwK3oU/61Muv8b+4wDRjY6AgSgAkABdKRD6wu
 OgwyagyfDlcHE2S3bo1bq74CwQUCk1j3JmxLIlBSf2t3Z4c/6NuAuNA6RX2cUzx435GlO9ayv6P
 R4AIvQYinM5H28xDfQ8Sc3PgRaYgnlclsVRQf5aIk1Qjqf9MBcXh1S7JUVrgT96AnfZvfZw/kJr
 BgT0pz8Rka+h/TUwRb328xzEJOoMbzyaM5R4oCz5J9yttquu9P3ogtR0LRjjIMG4Yk7uOJcSc8D
 3B6JZrDRc3yVmSYzHmcVa7v68lk3xOYBWvqV92xzSZLmqxqZG7Sc9aDubdkhOvcUs/WeLA==
X-Received: by 2002:a05:600c:3e8c:b0:43c:f81d:34 with SMTP id
 5b1f17b1804b1-4536e087050mr63113615e9.9.1750671110664; 
 Mon, 23 Jun 2025 02:31:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnmmHLExx6x+HhVwCqQcajMyIT/2JjEeSp8B/Jq4OtEm60lvywVX29zWqBn3sekziEUt8jBA==
X-Received: by 2002:a05:600c:3e8c:b0:43c:f81d:34 with SMTP id
 5b1f17b1804b1-4536e087050mr63113245e9.9.1750671110212; 
 Mon, 23 Jun 2025 02:31:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535ead202asm138005765e9.27.2025.06.23.02.31.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 02:31:49 -0700 (PDT)
Message-ID: <e3c392ba-d3f7-4c5b-bd42-024a42ff1d73@redhat.com>
Date: Mon, 23 Jun 2025 11:31:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/19] hw/pci: Export pci_device_get_iommu_bus_devfn()
 and return bool
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-6-zhenzhong.duan@intel.com>
 <6d472e7f-864f-4456-a036-1b5f61516aaa@redhat.com>
 <IA3PR11MB9136E06A48EC0FAF421522959279A@IA3PR11MB9136.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <IA3PR11MB9136E06A48EC0FAF421522959279A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/23/25 4:47 AM, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: Re: [PATCH v2 05/19] hw/pci: Export pci_device_get_iommu_bus_devfn()
>> and return bool
>>
>> Hi Zhenzhong,
>>
>> On 6/20/25 9:17 AM, Zhenzhong Duan wrote:
>>> Returns true if PCI device is aliased or false otherwise. This will be
>>> used in following patch to determine if a PCI device is under a PCI
>>> bridge.
>>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>  include/hw/pci/pci.h |  2 ++
>>>  hw/pci/pci.c         | 12 ++++++++----
>>>  2 files changed, 10 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>>> index 829757b2c2..3029cdf26f 100644
>>> --- a/include/hw/pci/pci.h
>>> +++ b/include/hw/pci/pci.h
>>> @@ -640,6 +640,8 @@ typedef struct PCIIOMMUOps {
>>>                              bool is_write);
>>>  } PCIIOMMUOps;
>>>
>>> +bool pci_device_get_iommu_bus_devfn(PCIDevice *dev, PCIBus
>> **piommu_bus,
>>> +                                    PCIBus **aliased_bus, int *aliased_devfn);
>> if I am correct you have a single caller of the helper using the
>> returned value, in intel_iommu.c, whereas all the existing callers are
>> not using the returned value. You may simply pass a non NULL aliased_bus
>> and aliased_devfn and check whether they differ from the original
>> bus/devfn. Besides the patch looks ok to me.
> I do this way initially, but it doesn't work if PCI device is the first device under
> PCIE-to-PCI bridge, e.g., 01:00.0, in this case aliased BDF==real BDF.
I see.

Thank you for the explanation

Eric
>
> Thanks
> Zhenzhong


