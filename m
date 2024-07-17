Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C0CC3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 12:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU3lA-00064a-Ks; Wed, 17 Jul 2024 08:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sU3kp-0005ga-R3
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 08:27:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sU3kj-0003Lb-Vt
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 08:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721219245;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oDp3uC5BdBNSM7ssGokX01wC3sNV5SbpGMCGyuC5oLQ=;
 b=gYmLQCrJYQtJYVVLjFMZkPlgSM1nKwRzfHT56l2uy7/arQPA2qlMaFEbpDnF/7RlbCw/bR
 F8ISKHlZnQOwr8M8cJJXoU2e/iZ5IwLxw12ZZ0t1ytVi95MNSdKnV02P1ERZYV0/IgVVAT
 IT6qOWbnXvrY+dxk+QC7m5L/NFQFV1g=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-_yf9HHH2Pm-prvdc_-RVIw-1; Wed, 17 Jul 2024 08:27:23 -0400
X-MC-Unique: _yf9HHH2Pm-prvdc_-RVIw-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-447e7239ea5so91703651cf.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 05:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721219243; x=1721824043;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oDp3uC5BdBNSM7ssGokX01wC3sNV5SbpGMCGyuC5oLQ=;
 b=kJBw5Tot4ld7UL9xGqX5yhJQoAPd8bJSrxo9oPjFJSlOFAZTfnv5kHrIsFnzzsChvu
 uMoYGUKcAfd0ak7nAcnCkhPDHY/lYImqkcBUGAKBuru1MYEeBwTrFMm1jGbxKM6MgBuA
 Z+gj+tJC1hjlSTC1R1N7TmBGxeyEU2yjxFOl64fWdFZzrRvjGbua8M88YhNxcm7nHIiR
 IxefpNUss9DpPh32A9868jrepJrqIwem3ar6ZvkYjpV4t4WnZCCd+1xeiZ8hkPKA3RH3
 6T8F7ha2K/Dc8ledNxzWphczXyXsUujVtWGymrJXI8aBSg0n4OOT8OtrKNQVMUXYr33o
 RZsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO5rc8TEiZFdgpgBEKcnDXew+4VbiuflIc3HQBflyDJDe2BRFscQEEqNoZsC+iO3zFTxvcogg0eR5ENBMLFShXSerBs8M=
X-Gm-Message-State: AOJu0YwXY+MNpy/uUSpkwh9/NPaFNV1SP7cSAOWDBqUR2kIeddfe/jp2
 U8/j7zkafO67Qf18kpJUCdwEcksaKduTGYrd0Q2829CeKe/LsQybR04z7jD+pP8/VTb5h2l7YjR
 l8UlpkPYWnjP/acXCHz2i31uvx33SXjpkn7Zbz0rgC8l/SvGZMSkq
X-Received: by 2002:a05:622a:1a0a:b0:447:ecd7:c040 with SMTP id
 d75a77b69052e-44f861c0728mr16666721cf.22.1721219243329; 
 Wed, 17 Jul 2024 05:27:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVApkA22VIQFpAHca2MkeGtNS/U1AEI5SVuVImam5wfpqSUMbr5ODnGNhGew+4kqXPw26YjA==
X-Received: by 2002:a05:622a:1a0a:b0:447:ecd7:c040 with SMTP id
 d75a77b69052e-44f861c0728mr16666471cf.22.1721219242924; 
 Wed, 17 Jul 2024 05:27:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44f5b7f6689sm46837141cf.49.2024.07.17.05.27.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 05:27:22 -0700 (PDT)
Message-ID: <6001b538-c191-4a78-a3bb-3d57de1b64cd@redhat.com>
Date: Wed, 17 Jul 2024 14:27:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/12] vfio/iommufd: Probe and request hwpt dirty
 tracking capability
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-9-joao.m.martins@oracle.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240712114704.8708-9-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Joao,

On 7/12/24 13:47, Joao Martins wrote:
> Probe hardware dirty tracking support by querying device hw capabilities via
> IOMMUFD_GET_HW_INFO.
this is not what the patch brings. GET_HW_INFO is always in place.
>
> In preparation to using the dirty tracking UAPI, request dirty tracking in the
> HWPT flags when the IOMMU supports dirty tracking.
this is what the patch brings.
>
> The auto domain logic allows different IOMMU domains to be created when DMA
> dirty tracking is not desired (and VF can provide it) while others doesn't have
don't
> it and want the IOMMU capability. This is not used in this way here given how
> VFIODevice migration capability checking takes place *after* the device
> attachment.
Id on't understand the above sentence

Eric
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  include/hw/vfio/vfio-common.h |  1 +
>  hw/vfio/iommufd.c             | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 2dd468ce3c02..760f31d84ac8 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -97,6 +97,7 @@ typedef struct IOMMUFDBackend IOMMUFDBackend;
>  
>  typedef struct VFIOIOASHwpt {
>      uint32_t hwpt_id;
> +    uint32_t hwpt_flags;
>      QLIST_HEAD(, VFIODevice) device_list;
>      QLIST_ENTRY(VFIOIOASHwpt) next;
>  } VFIOIOASHwpt;
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index d34dc88231ec..edc8f97d8f3d 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -246,6 +246,15 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>          }
>      }
>  
> +    /*
> +     * This is quite early and VFIODevice isn't yet fully initialized,
so what's the problem exactly with the above?
> +     * thus rely on IOMMU hardware capabilities as to whether IOMMU dirty
> +     * tracking is going to be needed.
> +     */
> +    if (vbasedev->hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
> +        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
> +    }
> +
>      if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>                                      container->ioas_id, flags,
>                                      IOMMU_HWPT_DATA_NONE, 0, NULL,
> @@ -255,6 +264,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>  
>      hwpt = g_malloc0(sizeof(*hwpt));
>      hwpt->hwpt_id = hwpt_id;
> +    hwpt->hwpt_flags = flags;
>      QLIST_INIT(&hwpt->device_list);
>  
>      ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
> @@ -267,6 +277,8 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>      vbasedev->hwpt = hwpt;
>      QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>      QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
> +    container->bcontainer.dirty_pages_supported |=
> +                              (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING);
>      return true;
>  }
>  


