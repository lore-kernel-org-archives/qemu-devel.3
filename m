Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDB7CAC5BB
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 21:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1tHB-0001gg-TW; Thu, 25 Sep 2025 17:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1tH8-0001fD-BA
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 17:13:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1tGy-000540-QN
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 17:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758834777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eEA7wmatUbGp1/XHIm/HpZCtbrxxyvMApsEjfdxMo4s=;
 b=IGeu2NzsvQKSIfWDJHGFf1JGyGj3hXqMDdXk4V/Gj7BJ6iptcMqaP2ApR2DKJFyhd6nQOC
 VkfDLIxh4/x32xM8VzjJBl9sTkGx1ZOYRNmyiFpv135PNlQrHVZCazPGkcpsvxzlO1fLc4
 HH67+uUTzrDFgAD9sML5ji+mxBHe/3Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-d7U6XOJ7PUyowZ_tejXz-A-1; Thu, 25 Sep 2025 17:12:55 -0400
X-MC-Unique: d7U6XOJ7PUyowZ_tejXz-A-1
X-Mimecast-MFC-AGG-ID: d7U6XOJ7PUyowZ_tejXz-A_1758834774
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46cde0b2226so3922755e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 14:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758834774; x=1759439574;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eEA7wmatUbGp1/XHIm/HpZCtbrxxyvMApsEjfdxMo4s=;
 b=FxfG8m2dTb8vgHmIaTsR8REvTIBZMVhMmrRR/KzNfdecYXqW9xYn9wQtcOLwaKcXM0
 4/biyqNlGsX6ViCuzKBXgoFq06bvhPELHJ6VErEitU/eysBGAJr1Wo1ccl6wDCUtK3ew
 U2WL8zh/wVOT80nhS+pO8JL4eWfM9aqtPMJSAWQFxabQ5xKbtIjsSnYr9i/I4xEF3mf/
 FPyMilu450vcfbwoN/lue/aZQpjjBWfpTZcwM8hQ60mLpRTveoebP69mp7vE34YGQpxR
 s2KUhX7srTTqltwsWbb6QToH0hoChh0ajF0UV2buE9KedW8kPuu8eJaxVRuR1jL04HmI
 FjBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc2Xfjy2ypxrA0kyCft2Ae2BJ+0QNHBubYNVC1gL5mX6Oh6rit7dd97e43ONA42wHRBphekLAZiexD@nongnu.org
X-Gm-Message-State: AOJu0YxX1TS9kzSSuFBf+trZj2grqmUtRPcv0bBlOILBUQXmrDrFRXxV
 BFNZCMgFgX0ERKJeqGnU6sd2L0CcOZdIKCyZK0pIAeG5wgwcYFR/mEcwhxFxr3Qjk4ifTqEgC7s
 6a6nO13DuWouT2x8hg0CJUkr5Llbop1BHgDGAhKRLPjJBp6VipwmN+sTl
X-Gm-Gg: ASbGncsPIUsUDksH6Sv+PiSprIddzJYmq/j7S/6T5/iKpqjmI2wUG1x6sFJd7rZMUbi
 iVOjV7gEsQjo0DLdONlK0osxhWFNbfIWFQ3JirHVp4LYFGk/VMsQOhpxD/QAm4DnByLnPvn9cDm
 Jl3PrCSFFmbud74Gfd4DjLRw+kla2ALOXNy86FBW2ifkLESaQ20HGQMb9R6z9ZQ9l9ov2K71KSn
 q0rw88404qne+FjSA+sfCzFMas9P4nstljZlQ09uraSikwqeZ3zI4cMHzNVt/5kDiXx/7DehIvw
 +iMdlYsoJuTp7RHWJ1Knfvx3KJJpU6Z2qNakLykyCQYhX5p23MIepIuxYn6bBKWLdCIYkcIraVX
 pt8Y=
X-Received: by 2002:a05:600c:4b16:b0:46e:21ed:b39e with SMTP id
 5b1f17b1804b1-46e32a0bc27mr37355305e9.25.1758834774189; 
 Thu, 25 Sep 2025 14:12:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ/kXEh0riBXTmmVJlvd6OMMAYgyYoERolmdnYgUQI11fK9/tJqcK8iHseJpltavzZitwMow==
X-Received: by 2002:a05:600c:4b16:b0:46e:21ed:b39e with SMTP id
 5b1f17b1804b1-46e32a0bc27mr37355085e9.25.1758834773731; 
 Thu, 25 Sep 2025 14:12:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb89fb19fsm4421330f8f.21.2025.09.25.14.12.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 14:12:53 -0700 (PDT)
Message-ID: <196e0a04-1241-4500-934b-6966124df485@redhat.com>
Date: Thu, 25 Sep 2025 23:12:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/8] Power11 support for QEMU [PowerNV]
To: Aditya Gupta <adityag@linux.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, Mike Kowal <kowal@linux.ibm.com>,
 Miles Glenn <milesg@linux.ibm.com>, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20250925173049.891406-1-adityag@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250925173049.891406-1-adityag@linux.ibm.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/25/25 19:30, Aditya Gupta wrote:
> Overview
> ============
> 
> Add support for Power11 powernv machine type.
> 
> As Power11 core is same as Power10, hence much of the code has been reused
> from Power10.
> 
> Power11 PSeries already added in QEMU in:
>    commit 273db89bcaf4 ("ppc/pseries: Add Power11 cpu type")
> 
> Git Tree for Testing
> ====================
> 
> QEMU: https://github.com/adi-g15-ibm/qemu/tree/p11-powernv-v10
> 
> The patches apply cleanly on below commit:
>    95b9e0d2ade5 ("Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging")
> 
> Tests ran:
> * `make check`
> * '-M powernv' / '-M powernv10' / '-M powernv11'
> * '-smp' option tested
> * 'e1000e' device
> * tested changing irq affinities to remote chips for xive functionality
> * compile test with --without-default-devices


Did you run 'make check-functional' ?


This config looks fine :

Architecture:             ppc64le
   Byte Order:             Little Endian
CPU(s):                   16
   On-line CPU(s) list:    0-15
Model name:               Power11, altivec supported
   Model:                  18.0 (pvr 0082 1200)        <-- is that a bug ?
   Thread(s) per core:     4
   Core(s) per socket:     2
   Socket(s):              2
   Frequency boost:        enabled
   CPU(s) scaling MHz:     64%
   CPU max MHz:            3800.0000
   CPU min MHz:            2000.0000
Caches (sum of all):
   L1d:                    128 KiB (4 instances)
   L1i:                    128 KiB (4 instances)
NUMA:
   NUMA node(s):           2
   NUMA node0 CPU(s):      0-7
   NUMA node1 CPU(s):      8-15



Tested-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> 
> skiboot with Power11 support: https://github.com/open-power/skiboot, since
> commit 785a5e3
> 
> Linux with Power11 support: https://github.com/torvalds/linux, since v6.9-rc1
> 
> Changelog
> =========
> v10:
>    + [PATCH 1/8]: Do same change for Power11 as done for Power10 in commit 46d03b,
>      as changes required for successful build with --without-default-devices
>    + [PATCH 3/8]: Added new patch to remove assuming chip as Power10 in xive2
>    + rebase to upstream
> 
> v9 (https://lore.kernel.org/qemu-devel/20250808115929.1073910-1-adityag@linux.ibm.com/):
>    + [PATCH 1/7]: apply hunks from commit cf0eb929e59cb, and commit
>      24c8fa968a6d8, for changes that were done for Power10, as those changes
>      make sense for Power11 also
>    + [PATCH 3/7]: fixed build breakage identified with QEMU CI, due to changes
>      in upstream function pointer types
> 
> v8 (https://lore.kernel.org/qemu-devel/20250608182842.2717225-1-adityag@linux.ibm.com/):
>    + rebase to upstream
>    + propose myself as a powernv reviewer
> 
> v7 (https://lore.kernel.org/qemu-devel/20250327200738.1524401-1-adityag@linux.ibm.com/):
>    + use Power10 models of homer, sbe, occ, psi, lpc. As they are same.
>    + switch powernv tests to use buildroot images instead of op-build images
>    + add functional test for powernv11
>    - remove dynamic sysbus device for PHBs, so no more dynamic number of
>    PHBs in Power11 as it became complex to handle it and not much used
> 
> v6 (https://lore.kernel.org/qemu-devel/20250325112319.927190-1-adityag@linux.ibm.com/):
>    + make Pnv11Chip's parent as PnvChip, instead of Pnv10Chip
>    + rebase on upstream/master
> 
> v5 (https://lore.kernel.org/qemu-devel/57ce8d50-db92-44f0-96a9-e1297eea949f@kaod.org/):
>    + add chiptod
>    + add instance_init for P11 to use P11 models
>    + move patch introducing Pnv11Chip to the last
>    + update skiboot.lid to skiboot's upstream/master
> 
> v4:
>    + patch #5: fix memory leak in pnv_chip_power10_quad_realize
>    - no change in other patches
> 
> v3:
>    + patch #1: version power11 as power11_v2.0
>    + patch #2: split target hw/pseries code into patch #2
>    + patch #3,#4: fix regression due to Power10 and Power11 having same PCR
>    + patch #5: create pnv_chip_power11_dt_populate and split pnv_chip_power10_common_realize as per review
>    + patch #6-#11: no change
>    - remove commit to make Power11 as default
> 
> v2:
>    + split powernv patch into homer,lpc,occ,psi,sbe
>    + reduce code duplication by reusing power10 code
>    + make power11 as default
>    + rebase on qemu upstream/master
>    + add more information in commit descriptions
>    + update docs
>    + update skiboot.lid
> 
> 
> Aditya Gupta (8):
>    ppc/pnv: Introduce Pnv11Chip
>    ppc/pnv: Introduce Power11 PowerNV machine
>    ppc/pnv: Add PnvChipClass handler to get reference to interrupt
>      controller
>    ppc/pnv: Add XIVE2 controller to Power11
>    ppc/pnv: Add PHB5 PCIe Host bridge to Power11
>    ppc/pnv: Add ChipTOD model for Power11
>    tests/powernv: Switch to buildroot images instead of op-build
>    tests/powernv: Add PowerNV test for Power11
> 
>   docs/system/ppc/powernv.rst            |   9 +-
>   hw/intc/pnv_xive2.c                    |   4 +-
>   hw/ppc/pnv.c                           | 560 +++++++++++++++++++++++++
>   hw/ppc/pnv_chiptod.c                   |  59 +++
>   hw/ppc/pnv_core.c                      |  17 +
>   include/hw/ppc/pnv.h                   |  38 ++
>   include/hw/ppc/pnv_chip.h              |   8 +
>   include/hw/ppc/pnv_chiptod.h           |   2 +
>   include/hw/ppc/pnv_xscom.h             |  49 +++
>   tests/functional/ppc64/test_powernv.py |  34 +-
>   10 files changed, 760 insertions(+), 20 deletions(-)
> 


