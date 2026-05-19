Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F03CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPO75-0003Zl-7N; Tue, 19 May 2026 13:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wPO71-0003Yk-JP
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:20:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wPO6y-00010J-GO
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779211206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Y+GUl2augdWHaeCARA6Yfypdq/dDRlnFNoVSZ4p1Qxg=;
 b=W31DwT+BOQZNRAqMgqNyJt/ppDCKEVBHXoEgmKuqZGl8tXn7x9qlu+aYK2vbG4VMswzeE4
 jyvxYL/t8Snm30FDDUyB+UYGdtfC5MIJ65FrYiQo94CYrt00sDZbEhQtK8tbde7MJPS9kV
 YY7NjwR/sSt7b6jMCDm6RLJVEHzYK8A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-Wk71orOZN2-8kv8u1ofX8g-1; Tue, 19 May 2026 13:20:04 -0400
X-MC-Unique: Wk71orOZN2-8kv8u1ofX8g-1
X-Mimecast-MFC-AGG-ID: Wk71orOZN2-8kv8u1ofX8g_1779211203
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48fed2519daso20299585e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 10:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779211203; x=1779816003; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Y+GUl2augdWHaeCARA6Yfypdq/dDRlnFNoVSZ4p1Qxg=;
 b=LBC87VZxtPxF/rODG4OkWQ/QNzUmTFiGu/R8jDcAIec1M+u+CUriGM/DxU7wQyxGKV
 q/BzP+EeOpEdUANyt2qGzCAKeLdyZzjrY3VA+Bd8mpbb1bo4Br/DuIbeXlHC2KECsu8e
 Axqt5J4dVBhszvNjPQRr9yj9fZtoisJMxSNo9Cf/oN8wk0rd/bktKyhe4TAbuHWFhOGk
 Mq2V4p4RXI2YfCmyZTNVnkDjeyXpmr3Gu0zjnazXPdVVfIBrb6qmQrgoJbG71aaa89hS
 eeQiB7SATSc5+R600vqLPeWwwXFI3trMu0ub0rVQRZuWYROfUUajqSm03L1DkgiuOjcN
 Q+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779211203; x=1779816003;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y+GUl2augdWHaeCARA6Yfypdq/dDRlnFNoVSZ4p1Qxg=;
 b=pujmdNnFV+sDhYjVxdvrIt3LDEF/Dbr24R51BWGkbhFfwrwk1hr/6yewNBVGn2iMTB
 TFIAkScJ8Q5qU/hReD0l7L6nHVJhm8AQJdb8QGpqpLi2ozC9l4oKupaiB3WWUWVz7MbL
 FxH+p5roNuELoii/Glk0Y3+77ASIkj54p7wdtDGC+KXylmloi2OsPAujLMNYYFuutitO
 xHISDw2aXZfKes1wVppTDyuGy+4GBvVrWQJUUEVrVb3C4WTGa8e9skYJLJppSGPl3y+F
 klo66bOqud3DdZbYOun17Y6I9avI4L2/B4WP/jyXg7VhR5oBvvO5j2NOOgGD4BpAPR4w
 805A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8fRFX2vCRmmocXrCtOA3IJi55Ozkz+o4TAQUq1KqA99OpEKngiVPbEKLdKYJHOcPKZtjoG/Z5Qe9JM@nongnu.org
X-Gm-Message-State: AOJu0Ywfb/BVUq3UtfNB4tozqDbXhAvdSJ883U9wXO4QcY98AKpVMZMv
 faYGqzzCLA5+P4ssNlm4KPARlJMNcdrZ46cNIKfuR93vke2+xrk5oXDov4ikca1dRBND8JP+5j0
 ZUIF3YmXuvvmWE1uTz0LuPggWl1Nhn8D+8dfNEI+HIRr4a0oa7Eqg0rRd
X-Gm-Gg: Acq92OGtQ7QneG65pDdaYueSrI/01CpbapxWRjQ4LZ4TyuFnUBgZIvIJZAvbSVCjpb6
 IWGfRHsHfcncb6HpyH8QUAfHzCTgHS3y7MTxNbArms0Bw0cmVwSw3RKimQxKm9CzHPwr7PGZIKZ
 yocHtb0vltBWUICl2kPvcIdBg4w/A4d8RiyJK2n+96qq5SiUoLhi/46T4gXC+aDlvUif7E16Fdd
 s3wOgU+ALhh80F7e2/bXHOJZ7yboCuM7e1mY9Y8QItjhSoeQQ0KKYEe3RJPrtqWfs1S2dQMS9tV
 yfv3pZMP3Dnfv83hGTVrSXHahLTilOuh9M67C8jhUPJCLCtmN3AnAxXZ5UjPz+MSZHa4Tszqd7H
 76Iel6OJXHlkZm9aQ0/iUHkoIVbbiPMI9ARa3VxGH1Z53Ff7+cPBTJ9Mbn72icafWQF1Sdlo=
X-Received: by 2002:a05:600c:3104:b0:488:ab1d:dcc5 with SMTP id
 5b1f17b1804b1-48fe651b57fmr294922655e9.27.1779211202992; 
 Tue, 19 May 2026 10:20:02 -0700 (PDT)
X-Received: by 2002:a05:600c:3104:b0:488:ab1d:dcc5 with SMTP id
 5b1f17b1804b1-48fe651b57fmr294922125e9.27.1779211202529; 
 Tue, 19 May 2026 10:20:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4900c16c744sm167347335e9.3.2026.05.19.10.20.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 10:20:01 -0700 (PDT)
Message-ID: <20b87f67-71e3-4263-a58c-3b8b8448f554@redhat.com>
Date: Tue, 19 May 2026 19:20:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/15] intel_iommu: Enable PASID support for
 passthrough device
To: =?UTF-8?Q?Cl=C3=A9ment_MATHIEU--DRIF?= <clement.mathieu--drif@bull.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex@shazbot.org" <alex@shazbot.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "xudong.hao@intel.com" <xudong.hao@intel.com>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
 <83576adbe6c19d562df2633d118173af4295f3b9.camel@bull.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <83576adbe6c19d562df2633d118173af4295f3b9.camel@bull.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Clément,

On 5/16/26 10:38, Clément MATHIEU--DRIF wrote:
> Hi Zhenzhong,
> 
> The series passed our non-regression test suite for emulated svm.

Is that svm suite something you could share, even upstream ?

C.

> I will try to test upcoming versions as well.
> 
> cmd
> 
> On Sat, 2026-05-09 at 00:07 -0400, Zhenzhong Duan wrote:
>> Hi,
>>
>> Now we already support first stage translation with passthrough device
>> backed by nested translation in host, but only for IOMMU_NO_PASID.
>>
>> Structure VTDAddressSpace includes some elements suitable for emulated
>> device and passthrough device without PASID, e.g., address space,
>> different memory regions, etc, it is also protected by vtd iommu lock,
>> all these are useless and become a burden for passthrough device with
>> PASID.
>>
>> When there are lots of PASIDs used in one device, the AS and MRs are
>> all registered to memory core and impact the whole system performance.
>>
>> So instead of using VTDAddressSpace to cache pasid entry for each pasid
>> of a passthrough device, we define a light weight structure
>> VTDAccelPASIDCacheEntry with only necessary elements for each pasid. We
>> will use this struct as a parameter to conduct binding/unbinding to
>> nested hwpt, to record the current binded nested hwpt and even future
>> PRQ support. It's also designed to support IOMMU_NO_PASID.
>>
>> The potential full definition of VTDAccelPASIDCacheEntry may like:
>>
>>    typedef struct VTDAccelPASIDCacheEntry {
>>        VTDHostIOMMUDevice *vtd_hiod;
>>        VTDPASIDEntry pasid_entry;
>>        uint32_t pasid;
>>        uint32_t fs_hwpt_id;
>>        uint32_t fault_id;
>>        int fault_fd;
>>        QLIST_HEAD(, VTDPRQEntry) vtd_prq_list;
>>        IOMMUPRINotifier pri_notifier_entry;
>>        IOMMUPRINotifier *pri_notifier;
>>        QLIST_ENTRY(VTDAccelPASIDCacheEntry) next;
>>    } VTDAccelPASIDCacheEntry;
>>
>> Based on newest master branch.
>> GIT branch: [https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_pasid.v5](https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_pasid.v5)
>>
>> PATCH01-08: Some preparing work
>> PATCH09-13: Handle PASID entry addition/removal and bind/unbind
>> PATCH14-15: Add PASID related check and enable PASID for passthrough device
>>
>> Tests:
>> Tested with DSA device which driver uses 2 PASIDs by default.
>>
>> Thanks
>> Zhenzhong
>>
>> Changelog:
>> v5:
>> - use %u for pasid print (Shammer)
>> - s/attachment/detachment in API doc (Shammer)
>> - save iommu pasid in vtd_as to avoid the check of PCI pasid whenever possible (Clement)
>> - commit log minor tweak on patch3 and patch7 (Liuyi)
>> - use name 'pasid-bits' for pasid property (Liuyi)
>>
>> v4:
>> - improve documents of VIOMMU_FLAGs (Cédric)
>> - add a cleanup patch to simplify the check between PCI pasid and VTD pasid (Clement)
>> - rebase to newest master branch
>>
>> v3:
>> - fix @Pasid parameter's comment (Liuyi)
>> - introduce a wrapper vtd_accel_delete_pc() (Liuyi)
>> - drop patch12 in v2 to avoid a race condition (Clement)
>> - s/PASID_0/IOMMU_NO_PASID s/gloal/global s/as_it/hiod_it (Liuyi)
>> - make trace_vtd_device_at/detach_hwpt use IOMMU_NO_PASID (Liuyi)
>> - change _accel subfix style naming to vtd_accel_ prefix style (Liuyi)
>> - drop unnecessary parameter vtd_hiod* from vtd_destroy_old_fs_hwpt() (Liuyi)
>> - introduce a new flag VIOMMU_FLAG_WANT_PASID_ATTACH for pasid attach (Nicolin)
>>
>> v2:
>> - move the check "s->pasid > PCI_EXT_CAP_PASID_MAX_WIDTH" to patch5 (Clement)
>> - move #include "hw/core/iommu.h" before #include "hw/core/qdev.h" (Liuyi)
>> - polish the comment about @Pasid parameter (Liuyi)
>> - s/pe/pasid_entry, s/as_it/hiod_it, s/vtd_find_add_pc/vtd_accel_fill_pc (Liuyi)
>> - s/VTDACCELPASIDCacheEntry/VTDAccelPASIDCacheEntry (Liuyi)
>> - add explanation in code about PASID removal before addition (Liuyi)
>> - polish the comment about scope of VTDAccelPASIDCacheEntry vs VTDPASIDCacheEntry (Liuyi)
>> - add an optimization to bypass PASID entry addition for PASID selective pv_inv_dsc (Liuyi)
>>
>> v1:
>> - use naming pattern "XXX_SET_THENAME" same as smmu (Clement)
>> - fix s->pasid check (Clement)
>>
>> RFCv2:
>> - extend attach/detach_hwpt() instead of introducing new callbacks (Shammer)
>> - Define IOMMU_NO_PASID for device attachment without pasid (Nicolin)
>> - update vtd_destroy_old_fs_hwpt()'s parameter for naming consistency (Clement)
>> - check pasid bits size to be no more than 20 bits (Clement)
>> - initialize local variable max_pasid_log2 to 0 (Cédric)
>>
>>
>> Zhenzhong Duan (15):
>>    vfio/iommufd: Extend attach/detach_hwpt callback implementations with
>>      pasid
>>    iommufd: Extend attach/detach_hwpt callbacks to support pasid
>>    vfio/iommufd: Create nesting parent hwpt with IOMMU_HWPT_ALLOC_PASID
>>      flag
>>    intel_iommu: Create the nested hwpt with IOMMU_HWPT_ALLOC_PASID flag
>>    intel_iommu: Rename pasid property to "pasid-bits" and define it as
>>      type uint8
>>    intel_iommu: Export some functions
>>    intel_iommu: Use IOMMU_NO_PASID and delete PASID_0
>>    intel_iommu: Refactor PASID processing to use IOMMU_NO_PASID
>>      internally
>>    intel_iommu_accel: Handle PASID entry addition for pc_inv_dsc request
>>    intel_iommu_accel: Handle PASID entry removal for pc_inv_dsc request
>>    intel_iommu_accel: Bypass PASID entry addition for just deleted entry
>>    intel_iommu_accel: Handle PASID entry removal for system reset
>>    intel_iommu_accel: Switch to VTDAccelPASIDCacheEntry for PASID
>>      bind/unbind and PIOTLB invalidation
>>    intel_iommu_accel: Add pasid bits size check
>>    intel_iommu: Expose flag VIOMMU_FLAG_PASID_SUPPORTED and
>>      VIOMMU_FLAG_WANT_PASID_ATTACH
>>
>>   hw/i386/intel_iommu_accel.h    |  20 +-
>>   hw/i386/intel_iommu_internal.h |  44 +++-
>>   include/hw/core/iommu.h        |  13 ++
>>   include/hw/i386/intel_iommu.h  |   4 +-
>>   include/hw/vfio/vfio-device.h  |   1 +
>>   include/system/iommufd.h       |  18 +-
>>   include/system/memory.h        |   2 +-
>>   backends/iommufd.c             |   9 +-
>>   hw/arm/smmuv3-accel.c          |  12 +-
>>   hw/i386/intel_iommu.c          | 254 +++++++++-----------
>>   hw/i386/intel_iommu_accel.c    | 414 +++++++++++++++++++++++++++------
>>   hw/vfio/device.c               |  11 +
>>   hw/vfio/iommufd.c              |  56 +++--
>>   hw/vfio/trace-events           |   4 +-
>>   14 files changed, 607 insertions(+), 255 deletions(-)
>>


