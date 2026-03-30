Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9563410D14A4
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 12:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7BSg-0004MW-T7; Mon, 30 Mar 2026 08:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w7BRm-0004H4-K6
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 08:10:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w7BRk-00028m-Sj
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 08:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774872614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bsnUaQg3LhmHfs9GIGrqPORbGbPBN6TH4AVpLin2XeE=;
 b=eeZXo2EmJolhJZb/PIs6UC5xklIrIkGBeWqKjoKUCAPCafHa/m7PdWmy4DoQl1NVOnSGi4
 1oBHm1DWjvRUElb6TTC/2mgFHkCs2oQCkYWXt32umeT3/K2qCqtgrXQeg4sRMUuFtOrk3k
 fA16soyyhnRerjqq+3aT5ls8iUf1p7s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-8Za-EgTyPneeWCoyYecwBA-1; Mon, 30 Mar 2026 08:10:07 -0400
X-MC-Unique: 8Za-EgTyPneeWCoyYecwBA-1
X-Mimecast-MFC-AGG-ID: 8Za-EgTyPneeWCoyYecwBA_1774872598
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4853466655dso27378945e9.3
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 05:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774872596; x=1775477396; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=bsnUaQg3LhmHfs9GIGrqPORbGbPBN6TH4AVpLin2XeE=;
 b=kdG25v+RQgH6MT7O9UMCMAf49axxk0n53MnuME/ci4f4LQhHlaxLJQDmNOTanaJgEf
 DG6oL8I5T76YJ//ISaymKYnbUQitJZfZ0kT75bP0d+QDXo0YmjkKOX//c4zen5KIdPMc
 ZP2JKv4fKhWnsUEGZWpaD1RQeAf49/kC+SIu5p52kfD6hvjTRhdZ0gBLkcWk6rJnZ4Po
 Pd0psinzhQYUSSPEQN2mHWoub37FkElXBTTyr+B6Q3oBy4k/Fr4d0xdZeD2vg8g70H8X
 0nte+F9ZtBMgYLAKzz/CosbZPk2TKqWKh5M4GEAMJaVSjZFJHx3JOTpes9ub1EMItfgt
 39KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774872596; x=1775477396;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bsnUaQg3LhmHfs9GIGrqPORbGbPBN6TH4AVpLin2XeE=;
 b=JsiLe+IaTsKM9ZLTES+0FlUqQzE+IAHEpmGctOkKi/pa8uxl+gUCwVFMy32xhlXHWY
 Q83dBIDHSjW0eBndZPdmG0dCGG3QgT95e5QEooEUmIG/m0hcctyco7L+n1oraY6CyX7L
 4gbVwVQtI5WJg3JhxR99I3s0Jxzas+OC8gWueM4OvPM08lY3A4IJgavHNHcBUSNdAXaV
 p+Mas0FM1q3rZsM212xaRKljJZiLyD0enuqB/PKYAf1Q991oSD1MJQ3lwdIk3QKKuaTu
 eWOmFq8+230u/jpKxoXk/RSJn0MqdRAwnH+HwNiTDyqdGTq05DQohSncBkjOheusuDqw
 QuSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlkT/Sj9MTPKcmYvh8I9+iSPSTnHLPTwur8L7j9DLhLr2VTD8h4iPzyrmqLYQcywWsf/H+0wftEJ6K@nongnu.org
X-Gm-Message-State: AOJu0Yw1mGji/XRU2dzW7g5cio7i3VzhEqknRmZ7aCqoMi5AIqr6tHHO
 DYNwUu9JnoNprdcpkdpheBZqjqy58F8Sps+pl9cRoG+nzCb3A0CIUWAzcq6Tr2Hu6PPS64yDBe0
 nRt0l6DrBGxtL+fAq9yE2OT/FPWuov/hGVmi/gQW8+zvxh5P4+wEWsag+
X-Gm-Gg: ATEYQzz3G3p9SbkSnmfrMY8EpWVlvXquqvnYaA7SehVIO4rOE9Sox7T989LAY6o/zcz
 c1FuG7vZwkfXLHaKJtH/+rCFQOREn/XVi32XagR5O2IQ6YuQ57LXI6sB9ocucDDL2tW7JTmFsuU
 9vbTuVKijPt/zDI+juKau5voY/IyFmpWdcUOqB6DHXy7kIS7HVzw5oaOZeXXURO7cWrmMXw5Je8
 2Ms8/nhoyUYk15500g5QMqdFRdGZrjb4rnF4Xe2fJoqFBNO3t/LaDqi6VEdJZMtgF78bMFRE9jA
 sV6VKJsiDvzl4Cg6ICJZ32Q4X9S3qXIcWYYy/iXLpKGv3TmhODipmAmxJhknD7tvKXSdI8SVwfw
 D4nbZ+qFHMk5Kywh+LoRPR2g1/SGLinlwuZIG0JROCcj9/JWakpdcg5s0zRsL
X-Received: by 2002:a05:600c:4744:b0:485:2a4b:7bc3 with SMTP id
 5b1f17b1804b1-48727d5d6femr201692055e9.4.1774872596084; 
 Mon, 30 Mar 2026 05:09:56 -0700 (PDT)
X-Received: by 2002:a05:600c:4744:b0:485:2a4b:7bc3 with SMTP id
 5b1f17b1804b1-48727d5d6femr201691485e9.4.1774872595627; 
 Mon, 30 Mar 2026 05:09:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722d236a9sm485466015e9.11.2026.03.30.05.09.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 05:09:54 -0700 (PDT)
Message-ID: <ac9f2403-c5d7-46ad-baa0-7ab33d50c446@redhat.com>
Date: Mon, 30 Mar 2026 14:09:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] iommufd: Extend attach/detach_hwpt callbacks to
 support pasid
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex@shazbot.org" <alex@shazbot.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Hao, Xudong" <xudong.hao@intel.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-3-zhenzhong.duan@intel.com>
 <acWwwzfNEzBg4n96@nvidia.com>
 <IA3PR11MB9136FC71017C3B05CE3C881D9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <acX9/RjKaO0bBI/d@nvidia.com>
 <IA3PR11MB9136D9DAD0B8698841CEF4429257A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <e97aec85-c9f0-449c-99e9-bc4b4f2d33d8@redhat.com>
 <acbt8FaZwzDaXtmT@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <acbt8FaZwzDaXtmT@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/27/26 21:52, Nicolin Chen wrote:
> On Fri, Mar 27, 2026 at 10:34:01AM +0100, Cédric Le Goater wrote:
>> On 3/27/26 07:44, Duan, Zhenzhong wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>> Subject: Re: [PATCH v2 02/14] iommufd: Extend attach/detach_hwpt callbacks to
>>>> support pasid
>>>>
>>>> On Fri, Mar 27, 2026 at 02:32:57AM +0000, Duan, Zhenzhong wrote:
>>>>>> -----Original Message-----
>>>>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>>>> Subject: Re: [PATCH v2 02/14] iommufd: Extend attach/detach_hwpt callbacks
>>>> to
>>>>>> support pasid
>>>>>>
>>>>>> On Thu, Mar 26, 2026 at 05:11:16AM -0400, Zhenzhong Duan wrote:
>>>>>>> @@ -138,14 +138,16 @@ struct HostIOMMUDeviceIOMMUFDClass {
>>>>>>>         *
>>>>>>>         * @idev: host IOMMU device backed by IOMMUFD backend.
>>>>>>
>>>>>> Not commenting against this patch, but I just found the "host IOMMU
>>>>>> device" and the "HostIOMMUDeviceIOMMUFD" a bit ambiguous. It's not
>>>>>> an "IOMMU device" right? Perhaps somebody can help me understand :)
>>>>>
>>>>> A host device under host IOMMU?
>>>>
>>>> "host device" would make sense, not "host IOMMU device", right?
>>>
>>> We want to emphasize that it's a "host device" backed by "host IOMMU",
>>> "host device" is not enough, I think.
>> Yes. These are related to the Host IOMMU device backends :
>>
>>    - VFIO IOMMU Type1, a.k.a legacy backend
>>    - IOMMUFD,
>>
>> There are other implementations. VFIO IOMMU Type1 is versioned and
>> a ppc flavor exists.
> 
> But the @idev here is a passthrough device (VFIO/PCI)?
> 
> "IOMMU device" would be SMMU, VT-d...

The 'idev' above is for a 'host IOMMU device backed by IOMMUFD backend'
AFAICT.

  
> Especially we are adding @pasid parameter. Relating it to SMMU or
> VT-d sounds weird.
host IOMMU device variables are usually named 'hiod' and the class 'hiodc'.

Thanks,

C.




