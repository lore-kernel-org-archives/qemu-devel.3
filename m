Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4863BCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 16:37:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urJ8I-00064E-AD; Wed, 27 Aug 2025 12:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urJ8F-00063A-UT
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 12:36:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urJ8D-00043C-0m
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 12:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756312574;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EMZfyzEp0y/MsQEdgng4cmTsFytN5+SO1/xJwn4sC5U=;
 b=SB5d+u1oWL5LGKV+rM6fbSsaDgz+K0RWa1Va09XhLoaHUuiC0qHQGNDS3UCfYvSGoEIQ4P
 16Dwvp+kiOmw2dcPO0/iH/9C1URKpWZxLWZTulVkWGNpjQOqQpsaT8asm9HHPXiA/6WD+Y
 Tbjpelv0O3lLhVazSd6puYl7arzuFjQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-h792kCwMPQuqOYjEnlDf8A-1; Wed, 27 Aug 2025 12:36:12 -0400
X-MC-Unique: h792kCwMPQuqOYjEnlDf8A-1
X-Mimecast-MFC-AGG-ID: h792kCwMPQuqOYjEnlDf8A_1756312571
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45a1b04f817so30520575e9.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 09:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756312571; x=1756917371;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EMZfyzEp0y/MsQEdgng4cmTsFytN5+SO1/xJwn4sC5U=;
 b=D3VyhIjkyigItcG/3La05OTqZz5mp+kKXFtB8MoerNWeT14UD2v9TQFz1PIirc3CrN
 iOi/CNklLVw+IKr5SbAU3l8GJMqYnspb8QD8Ddijbfj1mh9ji/aG7UAZPpLa4UpvAgDv
 4Kb2qKCwLTg8FQ9/1CKsPWJFxLXgs5ZSnSaUia7wVQE83Da9VjwwvOPCse9UTvDjGo20
 RXgxe+xQ5DZ1mYQRxYmfhmPn+znTJV+0ZHIBaFsuCwVP3vbBntgvvM7r6/SDkn5gWlJV
 FWtR/qiAu1QnxjU9q0s2gyyQvDqFLsTwm+eMz15D77Va6J/NnCgf6zEOrS4RtkoKE6jE
 vcrA==
X-Gm-Message-State: AOJu0YxoKt/tMmYWf0Bog9NJG6DPDLEgJ4XMNIEYHPIoeZU9aOG1No1u
 zr1FRiDEqmLZfaiKFUsgunHjHtYNXzdvEvZwszMMzgBFmdDJPAIPI6jaGtDB+s1gFGl6UOymTcN
 fuPK6RRvO3M34mtYwCDwVLZ+Dv8ED/HcBXgTLCFrnhzYWm2XVTHID3rZL
X-Gm-Gg: ASbGncu9t2oGhhahQpmDd/TPR7whBdazHhevNeKAB8abLIjtQCidehcfA8LKqGWhN3U
 2tcjuf5OqEGJt5zkmiBSXh1wkL0rd91aKtBLuBd0Yw48z1xWKABDYLzdjV2eKCMvA/djNGr/D2p
 +8gx0rujkWsTfQZ4aBR3THsxXjXWpeuv40ZMbyrsHKvOqInnDOOT6AoLkM+eHBaI6pWFWLV2K1Z
 X2ZF36/9luUYuwF1sdPMby6NfHzYmgKmv3CU/a2w7juozPldZRh7v6jJ0TX/jTnibVhYV/RbGu8
 gNIRulPdIQ7DZI8EBIp+BOstc0E9nY8ouP1I39x8G15CU9TtnsuiRf7s29pSNSqa3ZqVVfS+DD4
 PIgugZCS1rho=
X-Received: by 2002:a05:600c:350b:b0:459:d5d1:d602 with SMTP id
 5b1f17b1804b1-45b6153d946mr93688285e9.3.1756312571208; 
 Wed, 27 Aug 2025 09:36:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6Z6B+wLfUhe2p+dYbf44TkecgapkVgY2IWL+C1jE4uCw4eGwptiNWSowZ/Rmzly9ZyXxCuA==
X-Received: by 2002:a05:600c:350b:b0:459:d5d1:d602 with SMTP id
 5b1f17b1804b1-45b6153d946mr93688065e9.3.1756312570819; 
 Wed, 27 Aug 2025 09:36:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b73cf86f4sm17357735e9.6.2025.08.27.09.36.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 09:36:10 -0700 (PDT)
Message-ID: <b5e4d5ef-c7f0-4b3c-aec5-3916755f92ef@redhat.com>
Date: Wed, 27 Aug 2025 18:36:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/21] intel_iommu: Introduce a new structure
 VTDHostIOMMUDevice
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, yi.l.liu@intel.com
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, chao.p.peng@intel.com
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-8-zhenzhong.duan@intel.com>
 <aK3tAUUn5t61VPyk@Asurada-Nvidia>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <aK3tAUUn5t61VPyk@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Nicolin,

On 8/26/25 7:21 PM, Nicolin Chen wrote:
> Hi Zhenzhong/Yi,
>
> On Fri, Aug 22, 2025 at 02:40:45AM -0400, Zhenzhong Duan wrote:
>> @@ -4371,6 +4374,7 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>>                                       HostIOMMUDevice *hiod, Error **errp)
>>  {
>>      IntelIOMMUState *s = opaque;
>> +    VTDHostIOMMUDevice *vtd_hiod;
>>      struct vtd_as_key key = {
>>          .bus = bus,
>>          .devfn = devfn,
> I wonder if the bus/devfn here would always reflect the actual BDF
> numbers in this function, on an x86 VM.
>
> With ARM, when the device is attached to a pxb bus, the bus/devfn
> here are both 0, so PCI_BUILD_BDF() using these two returns 0 too.
>
> QEMU command for the device:
>  -device pxb-pcie,id=pcie.1,bus_nr=1,bus=pcie.0 \
>  -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1,accel=on \
>  -device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1,io-reserve=0 \
>  -device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.port1,rombar=0,id=dev0,iommufd=iommufd0
>
> QEMU log:
> smmuv3_accel_set_iommu_device: bus=0, devfn=0, sid=0
>
> The set_iommu_device op is invoked by vfio_pci_realize() where the
> the BDF number won't get ready for this kind of PCI setup until a
> later stage that I can't identify yet..
>
> Given that VTD wants the BDF number too, I start to wonder whether
> the set_iommu_device op is invoked in the right place or not..
>
> Maybe VTD works because it saves the bus pointer v.s. bus_num(=0),
> so its bus_num would be updated when later code calculates the BDF
> number using the saved bus pointer (in the key). Nonetheless, the
> saved devfn (in the key) is 0, which wouldn't be updated later as
> the bus_num. So, if the device is supposed to have a devfn (!=0),
> this wouldn't work?

in hw/arm/smmu-common.c, along with smmu_find_smmu_pcibus() there is a
comment about late computation of bus number. This looks like a safe
place where the bus_num is known.

Thanks

Eric
>
> Thanks
> Nicolin
>


