Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB75C7115C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 07:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRmv1-0001E3-18; Wed, 18 Jun 2025 03:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRmux-000183-FJ
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 03:09:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRmuv-0003F6-Ke
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 03:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750230544;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X4s7PqshNPkXUBnc1XC76Zg7SlnAPmhgqvmWbSKBBso=;
 b=H3YPcl1ObfZSn/7e+ac+GpZJkl/C2AYG0D72siOvN1MF2B9qUZiz/emhm1QZc1gwP6DVKQ
 jxZ2dbUy1QRYgNHlOK749NHcR7dI6p+3IPNJ7v+1NMzmWtPvb+6mOzWWYrZOAlXkDuiGFM
 BGePjIxxjDdL3OXkcKLOAh5l9qUd0ng=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-DTt4fokSMgi2PxqSlRarJQ-1; Wed, 18 Jun 2025 03:09:02 -0400
X-MC-Unique: DTt4fokSMgi2PxqSlRarJQ-1
X-Mimecast-MFC-AGG-ID: DTt4fokSMgi2PxqSlRarJQ_1750230542
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45311704cdbso33802725e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Jun 2025 00:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750230541; x=1750835341;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X4s7PqshNPkXUBnc1XC76Zg7SlnAPmhgqvmWbSKBBso=;
 b=YPt/M9IvBh8Hn2xQrYqEy3TaELPyZRVYijti1uybV/IpOvbrqzmcyVQzG3dnWJ8/f1
 7aaAJP/Lu+woEaGWX5c9lm6jiZ5FuWaY24XS4pWd+RoPOI3HKDnm/O+9l5OCy5w24Vym
 pJYr3YOv/Ja9BEsHe5j+UxHsPOuX/HPWIVY9BbIJYryYU3ffQ+1xiTKMYD9AlrmPxeLu
 dS4TwCx8sXd3oAp/5oUawUN1spbqvpJebB/4TetRMKPcoWRibpKqeE+ODLQJdQdfFhht
 aFC5zdmCfjXr16G//aKz32BtES3OFyeC86STZF1OdyyG6MZ3B6b39BFnUjUpXavlJkxP
 yP5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp4wB6aJdOFTNR9bVwe6GDYzOxbz0LhRLf6pIe+Q9Hg1hqWu3dNyO4AXtDG+7yfkiTOdbk4npgDJdk@nongnu.org
X-Gm-Message-State: AOJu0YxHQWnbTaXcVXCyNrlC/frll2N7CnCwDbv+cl/tClFAYWqXIuWm
 A5EdnEtnj2ayN5xwY8Oz9ArNmnWD4CBryaMGhJG+UKeguvmFKJPta+MkwjR5XVyempjIHFpokWC
 Kn4NEbBW0Ckv717kXSMVd3jBewdWJrYd2EpkI4z+4v2dXG7Atso45VDgq
X-Gm-Gg: ASbGncvNvSKBnNiXl0ttFBZhK0luKMmll4HdxMwIpS0j8nViU34vfMkon2n0ZyMcdxY
 AajhqFCd5YTpoytj4vFMa62IzW8Z1pnphESfXe1us5Ow2xEBh4j+N5G8dvmCO8cuFWWMOvMhwB3
 jKO40eLfSlfyXZ76nFHi6GTLNBuKqZK/PGdvB11noCVAHUlGC6C5LYzIT/lCuj2HxY8Mbq+R9lD
 uKpILb5EQT9spuIazg7Lfnmb/RKe5twF6j8g866o1owmWTAR+hmFdbHf2OWnKZugtentM00mTx2
 XzxmEjhYXP12alESjnLjWZagHKTgbAPZ16C7FQxu9LDc1CfI+HMwEChxxZvaT1+H3+Xikw==
X-Received: by 2002:a05:600c:5026:b0:43d:9f2:6274 with SMTP id
 5b1f17b1804b1-4533ca7790fmr160329025e9.14.1750230541593; 
 Wed, 18 Jun 2025 00:09:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuPX/dE2QXjOdsx6lR8LeRnxSeXRTsF3QO+FMu6IbzQJAXwo5UNZhK1EHVbOOh2xlZQRKILg==
X-Received: by 2002:a05:600c:5026:b0:43d:9f2:6274 with SMTP id
 5b1f17b1804b1-4533ca7790fmr160328555e9.14.1750230541150; 
 Wed, 18 Jun 2025 00:09:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e16a097sm203442985e9.33.2025.06.18.00.08.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Jun 2025 00:09:00 -0700 (PDT)
Message-ID: <b16b1a54-ff27-4b14-87e5-1123ec87d5c7@redhat.com>
Date: Wed, 18 Jun 2025 09:08:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/15] intel_iommu: Optimize context entry cache
 utilization
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
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250606100416.346132-1-zhenzhong.duan@intel.com>
 <20250606100416.346132-3-zhenzhong.duan@intel.com>
 <e75d6344-9858-400a-9c73-1359789e15a9@redhat.com>
 <IA3PR11MB91363AC7DBFB6988CA1FAD229272A@IA3PR11MB9136.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <IA3PR11MB91363AC7DBFB6988CA1FAD229272A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/18/25 4:10 AM, Duan, Zhenzhong wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: Re: [PATCH v1 02/15] intel_iommu: Optimize context entry cache
>> utilization
>>
>> Hi Zhenzhong,
>>
>> On 6/6/25 12:04 PM, Zhenzhong Duan wrote:
>>> There are many call sites referencing context entry by calling
>>> vtd_dev_to_context_entry() which will traverse the DMAR table.
>>>
>>> In most cases we can use cached context entry in vtd_as->context_cache_entry
>>> except when its entry is stale. Currently only global and domain context
>>> invalidation stale it.
>>>
>>> So introduce a helper function vtd_as_to_context_entry() to fetch from cache
>>> before trying with vtd_dev_to_context_entry().
>>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>  hw/i386/intel_iommu.c | 36 +++++++++++++++++++++++-------------
>>>  1 file changed, 23 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index f0b1f90eff..a2f3250724 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -1597,6 +1597,22 @@ static int
>> vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
>>>      return 0;
>>>  }
>>>
>>> +static int vtd_as_to_context_entry(VTDAddressSpace *vtd_as,
>> VTDContextEntry *ce)
>>> +{
>>> +    IntelIOMMUState *s = vtd_as->iommu_state;
>>> +    uint8_t bus_num = pci_bus_num(vtd_as->bus);
>>> +    uint8_t devfn = vtd_as->devfn;
>>> +    VTDContextCacheEntry *cc_entry = &vtd_as->context_cache_entry;
>>> +
>>> +    /* Try to fetch context-entry from cache first */
>>> +    if (cc_entry->context_cache_gen == s->context_cache_gen) {
>>> +        *ce = cc_entry->context_entry;
>>> +        return 0;
>>> +    } else {
>>> +        return vtd_dev_to_context_entry(s, bus_num, devfn, ce);
>>> +    }
>>> +}
>>> +
>> While the patch looks good to me can't you use the helper also in
>> vtd_do_iommu_translate()?
>> See " /* Try to fetch context-entry from cache first */"
> It can, but it finally calls into vtd_dev_to_context_entry() so we can call vtd_dev_to_context_entry() directly.
> I will drop this patch following Yi's suggestion.
OK

Cheers

Eric
>
> Thanks
> Zhenzhong


