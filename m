Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720A3CD8CA8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 07:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXwl2-0003h0-2h; Fri, 12 Jun 2026 03:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wXwkz-0003gV-V7
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 03:56:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wXwkx-0005fH-Sh
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 03:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781251006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XmD44FnM2EE1iQdmLWVSFo+TF1q0GBI3+JlCE2dcAbo=;
 b=Zrh6WI70II3sPpoErDnEExQ65PbSvjZU7FP/1zvF5M3JOnipUW7Wcgry0HP7P8ELmdkgJx
 c33C/ykZtoYcaU8gTbkfNY7ZNIVnXrfH5KCRiuZKLBPFKulXa49In+BLrhxjNTjYIet8kI
 aDWWCLbggtgtEh5U2wUV/kUokBELSI0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-jfpJHYgbNhyZ3F43OF4wbw-1; Fri, 12 Jun 2026 03:56:45 -0400
X-MC-Unique: jfpJHYgbNhyZ3F43OF4wbw-1
X-Mimecast-MFC-AGG-ID: jfpJHYgbNhyZ3F43OF4wbw_1781251004
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-46010392f89so603703f8f.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 00:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781251004; x=1781855804; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=XmD44FnM2EE1iQdmLWVSFo+TF1q0GBI3+JlCE2dcAbo=;
 b=T+9jW7wGyoQxyllCdCMPH98/tnXTnOpNJCvSUOvHc1sU0nkrvUBYQF1MMZCJ50qaiH
 s98h+VqJXpZ1RhbjAJz8iI08CvgGtGsQExTjX/DezaZXbsD32E09fQcxzEFQHegNJeeX
 f98QRnwWeFB7QaE9vhzgT+kZnHOYWV6r7Su0HxDYXM6rcS0JGTwGdc6kRS9rXk2q0gOX
 IyLTnuthVWF26fUG+cBpUcWAcRb8sdDrvLI9KitHWlevUhqx9JWg2dv6Lmcw3+WRv+a9
 WRLnowbMfc0UW4aoM0II0fiX2Ox21K/ubmHp64VZa51wTs1Bd2k2K4yXg82XJ8iM+49A
 JR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781251004; x=1781855804;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XmD44FnM2EE1iQdmLWVSFo+TF1q0GBI3+JlCE2dcAbo=;
 b=Yx4Cm08MKEFUZpBFFzlSAg92uWINDJhx2uS+LudfwCtn2gQvGZGYJyU340/jQQmZYP
 5aATlBl0csmX+kAiLZOhbJVx4CbvyEea2l/s1FdSfO9U06NLLgIUzfjzZ97bLfFhREBI
 eAxREh7CURydQLkdhlSky5VMEKen8yR8e7muGn/asvztkbnUQ++9qtNOdIXsW70bZPl6
 jafdVwAJZAdYz9yFu/IbHW4ThM+RvdU5tniQJ1ey3jOALkd9p8kR6v/9RYfce1IXtN69
 ftbRVhrdWJafn1UAsj1OZFb83CFsGiRcLrsE3MILdRA51AXTCBo3NHNkfSTjLIgBP8u8
 BYFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/zKAkM9v1BpJQXKRhaIDWDCwaqIj5MIZ6oHRRyG7z0yvCJMhMfJ1mzP+ysaXZpxNLk/V9oFV21EuEP@nongnu.org
X-Gm-Message-State: AOJu0YxCvzW65521euFihLfiffSlB0RH0dRqsE9sIcxXpOJ+xTFQHPuW
 BFQwRQquBBh0pPH8i9h2LDQRT2jZznfnC3Y7SwcDFUBUisuhWT77MseRCuRfaU4xVdwy7jXdO74
 oPvTiVr2jJd7yY7lrL5pdyydzNVmm44a9weszA113orHyNfsv24t2gIYo
X-Gm-Gg: Acq92OExMaI93B2RtGhyP6MWJmgarEOjlAZKUaE23brhG0ynpEvvEDCVQTcSBKDD0PV
 S1Km+bDcW+biHYRuIOShHqaEEm9WJ8cAvN4I5bnX8ikCPOLzDFSG+WHqw6ABt9ELBfv47QtfvWV
 uZl0eYpZRoQA266o30Rv17w9ufO1ZWCIDaJhy5ZZnvX7Eb8ga9X17R3DjLBaEg/p10dAwucZjBO
 EUf5cZJMWYil1hrcbFa43nImooFEXaq1qv8I+4+/QaYbKWPg+iGl1TZWOg6mDhAG+owoPykMist
 d/RM7IC8b2UQZuI+dZzcxspO7kmit6QilK3BBgcimU1mU8Iohi3tkji1ChSqQwr1wxqq7WEesN+
 gqSFzWoeYMVnglyaJjd4dH+fauU2dKyH7DlnGlOKX6mXW79ms7XZDrp+u+SxO
X-Received: by 2002:a05:6000:4615:b0:43b:5b25:67f8 with SMTP id
 ffacd0b85a97d-4606dbdf91emr2382619f8f.20.1781251004110; 
 Fri, 12 Jun 2026 00:56:44 -0700 (PDT)
X-Received: by 2002:a05:6000:4615:b0:43b:5b25:67f8 with SMTP id
 ffacd0b85a97d-4606dbdf91emr2382574f8f.20.1781251003702; 
 Fri, 12 Jun 2026 00:56:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0c35sm3527331f8f.22.2026.06.12.00.56.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jun 2026 00:56:43 -0700 (PDT)
Message-ID: <981b9398-6da9-4862-a5c6-370b220b2bc9@redhat.com>
Date: Fri, 12 Jun 2026 09:56:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] vfio/pci: add vfio-pci ATS control property
To: Nathan Chen <nathanc@nvidia.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Alex Williamson <alex@shazbot.org>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260612014322.2918836-1-nathanc@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260612014322.2918836-1-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hello Nathan,

On 6/12/26 03:43, Nathan Chen wrote:
> Hi,
> 
> This series adds an ATS control property to vfio-pci and wires iommufd
> support reporting so vfio-pci can decide whether to expose the ATS PCIe
> extended capability to the guest. This series is a follow-up to the
> previous patch included in the "hw/arm/smmuv3-accel: Resolve AUTO
> properties" series [0].
> 
> The new vfio-pci property is:
>    ats=on|off|auto (default: auto)
> 
> Behavior:
> - off: always masks ATS from guest view
> - on: requires ATS support; fails realize if kernel reports
>        IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED
> - auto: masks ATS only when kernel reports
>          IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED
> 
> To preserve machine compatibility for older machine types, this series adds:
>    { "vfio-pci", "ats", "on" } to hw_compat_11_0.
> 
> Please note that no linux-headers sync patch is included in this series
> because IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED is already present in
> linux-headers/linux/iommufd.h in the current base.
> 
> Testing:
> Verified ATS capability visibility changes with vfio-pci ats=off/on/auto
> on an NVIDIA Grace system:
> - ats=on + ATS supported by kernel => propagate ATS extended cap to
>    guest view
> - ats=auto + ATS supported by kernel => propagate ATS extended cap to
>    guest view
> - ats=on + hiod_iommufd_support_ats modified to return false (mimic
>    kernel-reported unsupported ATS) => realize failure
> - ats=auto + hiod_iommufd_support_ats modified to return false (mimic
>    kernel-reported unsupported ATS) => ATS masked
> - ats=off => ATS masked

What about ats=on and no ATS support in the physical device ?

I agree it is a bit of a corner case. A warning would be nice,
it can be addressed as a follow up change.

Thanks,

C.

  
> Changes from "Resolve AUTO properties" series:
> - Split into separate patches for support_ats() handler introduction and
>    iommufd implementation, "ats" property addition, and compat property fix
> - Rebase on vfio-next
> - Remove unnecessary includes for hw/vfio/pci.c
> - Rename ats_need to ats_needed for vfio_pci_ats_requested_and_supported()
> - Move the vfio_pci_ats_requested_and_supported() call to
>    vfio_pci_add_capabilities() so we can propagate the Error **, and then pass
>    ats_needed as a new input arg to vfio_add_ext_cap
> - Fix indent error in vfio_add_ext_cap()
> - Break and add a pcie_add_capability() call for the PASID case in
>    vfio_add_ext_cap()
> - Update comment about return value for support_ats()
> 
> Thanks,
> Nathan
> 
> [0] https://lore.kernel.org/qemu-devel/20260401010231.4166776-5-nathanc@nvidia.com/
> 
> Nathan Chen (3):
>    iommufd: Introduce handler for device ATS support
>    vfio/pci: Add ats property
>    hw/core/machine: Add new compat for vfio-pci ats property
> 
>   hw/vfio/pci.h                      |  1 +
>   include/system/host_iommu_device.h | 10 ++++
>   backends/iommufd.c                 |  8 ++++
>   hw/core/machine.c                  |  1 +
>   hw/vfio/pci.c                      | 74 ++++++++++++++++++++++++++++--
>   5 files changed, 91 insertions(+), 3 deletions(-)
> 


