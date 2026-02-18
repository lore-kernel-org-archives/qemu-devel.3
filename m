Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D13E9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 09:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsdPT-0008Gu-OF; Wed, 18 Feb 2026 03:59:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vsdPQ-0008F7-Pv
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 03:59:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vsdPN-0007yW-2z
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 03:59:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771405183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ICTrgTHNqq8iM/P8eMa+c5kjvoOZUF0p8ttYToUxfG0=;
 b=B4uDTdcNYbQBfeh4EsjbvmmfQjcOq4eqBcKimjB1ynKr9hnJCBsKB/qxsWqiQm2/UtRfhY
 gEixoHyFlvLuZs6r9aj1b/BjdErcV7pLIlw+1B3nX+RXm3rZIh11GcBMRWzsooCT8ySuWq
 X1queXsDgkILIgQFioG3uVxd3sdztko=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-R8tnN8gxO5uZ6i-phbA1Pg-1; Wed, 18 Feb 2026 03:59:41 -0500
X-MC-Unique: R8tnN8gxO5uZ6i-phbA1Pg-1
X-Mimecast-MFC-AGG-ID: R8tnN8gxO5uZ6i-phbA1Pg_1771405180
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4837b7903f3so45007385e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 00:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771405180; x=1772009980; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ICTrgTHNqq8iM/P8eMa+c5kjvoOZUF0p8ttYToUxfG0=;
 b=eV0W6bNLOQOykknGnfdb5UCCeMXbAGnT95KYvyenybCsFJD0FAopeL57TO5Dsfpqoq
 PlBgbwVxlfIVKLKsmQqDaUzr75KfrYH9Z3r6h3w9UO2wkcK+3jKkeLLWAqXQO2Gi4fKN
 6Nl0/o68EaoUYlCEjKG91iPppIbci76xz5NDj6DJJCyMV41Lo0jS4HrIczL4QSbB7kHj
 c6tPlDqRbVeGxPEodNNwpMs+EdAc3cGje76RZY5dWFNFw//EqR7GAgXKnU0quO+1bTUO
 STcQ1/R+kVVVce9FEvVVw9NCY4HkJexBAGbf48aefxrXuXmKPhspIR2Vhu+XYioYmrDo
 qoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771405180; x=1772009980;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ICTrgTHNqq8iM/P8eMa+c5kjvoOZUF0p8ttYToUxfG0=;
 b=BypQMjVFB23Z7hxWAo5KcI9YZYPyChrirWPL0xvyDwkVkrZME2D6XmJeckuXk6Au0W
 npo7jz6SjGFsuQk8mEH+LRark5tP/Qn8EiRX3uuBy/bKXAOVbqmBmMZqArVWuHlNlnmk
 0koKeT25GLrd+WhSF4uB1+fDyDxM2yy/WKKhUBvxQgO2Pl0MoUO0dixTLjTpTfQ/YrBg
 ITbFTAGH1P3jP0FTIPIm5D5gcZ/cH7XMYmNR5j81kIxxUjTrk1WICJWWJoJIW6MTCQE9
 uvmEUIBXQgESZsIl/N0cDrC8wtcpM4Ndx4H/EWCl6goTz+i5q880mxktElHhgOSBlH5t
 VxEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaIHyFLcvzIvT3aGPfZQdlVYErHugkneRdZadyg6XFRRhVkbtkxzId+cCI3gWA3lTzFkCyYRnn3DVP@nongnu.org
X-Gm-Message-State: AOJu0YyACSc7NlNK+Eii2MlfV6ojw05uOezCTOqdlBB+V8t8nGwvyJMV
 nnaoj1Xthl5paoR34YJMuQI8+ADyAeBEyb7zJmdVZinlPBvnB77ZH/PqINz3QQ2z7ACXGmAJlW5
 1awWsMtnUtcFpVRiDnLmtKaw/gGkbtekvlLU+CHvIIRTiSVKvbaWP4OGQ
X-Gm-Gg: AZuq6aIepwCB2HVBx24G3zawvoCjp9dMO0WbZ1mzuNCmIV6Cy14lDKTmCvtHorPPD2f
 akd0XAqV0WgK4zo7LiHe+PeRLsYqgeqUKQ81XSODveqyHewGlt4RTlU7fWf/mAuVf/RDUnPebPh
 qCiQWHRJ/KN/tq1p+iS8CpVizXqnVwzkBE/KRcI2LVl5lWE7XBq3BzVFQdIa2mli4BaoWUXWdCY
 aI94Gpljbq8aXXXklnQuksx9Bgtj/tWfDkw46XJlUAEPYiLsivZBUpYVe8lXd5ZkmMEE2puu/uQ
 yOJzy6niDM0Qn6UPZk/sD568GFy62M4SlTn0tiK1C89AzrZG3vQcpX0ICbyzlrFgL+Cb8iz4t+y
 j3k7M3QXvKTU7hdFEakWQfdbO15hibJiOwCyBwUd2aejHVBxKgrV0pSj/BCnA
X-Received: by 2002:a05:600c:64c5:b0:47e:e2ec:995b with SMTP id
 5b1f17b1804b1-48398a7dd3amr24717125e9.9.1771405180059; 
 Wed, 18 Feb 2026 00:59:40 -0800 (PST)
X-Received: by 2002:a05:600c:64c5:b0:47e:e2ec:995b with SMTP id
 5b1f17b1804b1-48398a7dd3amr24716715e9.9.1771405179566; 
 Wed, 18 Feb 2026 00:59:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48397318a23sm26034915e9.2.2026.02.18.00.59.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Feb 2026 00:59:39 -0800 (PST)
Message-ID: <d9440811-0d9b-4f93-a5bd-3035e805b3e9@redhat.com>
Date: Wed, 18 Feb 2026 09:59:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] hw/vfio: Enable hugepfnmap for non-power-of-2
 device memory regions
To: ankita@nvidia.com, vsethi@nvidia.com, jgg@nvidia.com,
 skolothumtho@nvidia.com, alex@shazbot.org
Cc: aniketa@nvidia.com, cjia@nvidia.com, kwankhede@nvidia.com,
 targupta@nvidia.com, zhiw@nvidia.com, mochs@nvidia.com, kjaju@nvidia.com,
 qemu-devel@nongnu.org
References: <20260217153010.408739-1-ankita@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260217153010.408739-1-ankita@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2/17/26 16:30, ankita@nvidia.com wrote:
> From: Ankit Agrawal <ankita@nvidia.com>
> 
> This series enables hugepfnmap support in QEMU for VFIO device memory
> regions that have non-power-of-2 sizes. This specifically addresses the
> needs of Grace-based systems (GB200) where device memory is exposed
> as a BAR.
> 
> ## Problem
> 
> On Grace-based systems, device memory regions can have sizes like
> 0x2F00F00000 (not power-of-2). The current QEMU VFIO mapping code
> aligns each sparse mmap area independently using the trailing zeros
> of its size (ctz64), which results in suboptimal alignment for the
> overall VMA.
> 
> This prevents the kernel from using hugepfnmap that enables huge
> page mappings for device memory. Without proper alignment, the
> mapping falls back to PTE, significantly impacting performance
> due to increased TLB pressure and page table overhead for large
> memory regions.
> 
> ## Solution
> 
> Patch 1: Sort sparse mmap regions by offset during setup and validate
>           that they don't overlap. This ensures predictable mapping
>           order and enables gap detection.
> 
> Patch 2: Adds Error parameter to vfio_region_setup() for better error
>           handling and reporting.
> 
> Patch 3: Change the alignment strategy from per-sparse-region to
>           whole-region alignment using pow2ceil(region->size). Create
>           a single aligned base mapping for the entire region, then
>           overlay sparse areas with MAP_FIXED. Gaps between sparse
>           regions are explicitly unmapped.
> 
> v4
> * Replace lx with PRIx64 in the error in 1/3 (Cedric)
> * Error** param for vfio_setup_region_sparse_mmaps in 2/3 (Cedric)
> * Comment to notify that the mapping algorithm expect sorted offset.
>    (Cedric)
> 
> v3: https://lore.kernel.org/all/20260215084950.4657-1-ankita@nvidia.com/
> * New patch 2/3 to add Error **param in vfio_region_setup (Cedric)
> 
> v2: https://lore.kernel.org/all/20260211030615.3202-1-ankita@nvidia.com/
> * Fixed the code returning early without trace (Shameer, Alex)
> 
> v1: https://lore.kernel.org/all/20260130040649.42485-1-ankita@nvidia.com/
> 
> Ankit Agrawal (3):
>    hw/vfio: sort and validate sparse mmap regions by offset
>    vfio: Add Error ** parameter to vfio_region_setup()
>    hw/vfio: align mmap to power-of-2 of region size for hugepfnmap
> 
>   hw/vfio/display.c     |   6 +-
>   hw/vfio/pci.c         |   3 +-
>   hw/vfio/region.c      | 140 ++++++++++++++++++++++++++++++++----------
>   hw/vfio/vfio-region.h |   2 +-
>   4 files changed, 114 insertions(+), 37 deletions(-)
> 


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


