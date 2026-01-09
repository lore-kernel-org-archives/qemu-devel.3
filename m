Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB9BD1A63D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 14:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veDpP-0001jO-VB; Fri, 09 Jan 2026 09:51:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1veDpL-0001bT-QH
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 09:51:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1veDpI-0001px-KG
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 09:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767970253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ja3dFCXFoT/QIhH2mZhtfCuK347Vn2U+zeKS0GAbOrw=;
 b=KjmvSnjq4L2TOpCvk3zbGx9AjTqTLhsXGjikyp5Jj5Doc+iasmi5807dPybZ+MfY3QrrV/
 VoRzXztGW18/Z29g45ChiQLwWSDOg5Nc3dDv5GII/cgxd7QAWaqCemKm11giFIMFQzAkb1
 7/sm71fCdX7vgYKFm61uXwh9HH4lSjI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-GaonyNlzNj-I3J0FT7dF0Q-1; Fri, 09 Jan 2026 09:50:52 -0500
X-MC-Unique: GaonyNlzNj-I3J0FT7dF0Q-1
X-Mimecast-MFC-AGG-ID: GaonyNlzNj-I3J0FT7dF0Q_1767970251
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430f4609e80so2271396f8f.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 06:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767970251; x=1768575051; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Ja3dFCXFoT/QIhH2mZhtfCuK347Vn2U+zeKS0GAbOrw=;
 b=j/ftZaeC0KKZ/1uVv9bZwBsANl4bLv2uuYfWjujioWGAGlxzv4aZ3fb/NjHYrdX8ob
 6WVSK7fK6YVebEXPGxKdTz4eY6d7t/04qRBZ6Djcqo+QYAu6nMeI6bdLYd8miCoMsG1d
 BaNkmOHWJjJxztF1Jo5qfDXMMfomnjuuErJt7ZfmJZ9AEcQGfaIjbEwuM1Vex38Q7485
 niQuXHFlTlOngZ4DVx1iuTDg49wn/RJLcNGnpOUMG9aFjyxLxycblirHa/3VWRCgAzLi
 bH9HtT27AyOP4D2Qrar1h3exQBgXTDCA2+PHWYJ522UH654Q1VpsiRb7gBkq5pteovuP
 G00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767970251; x=1768575051;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ja3dFCXFoT/QIhH2mZhtfCuK347Vn2U+zeKS0GAbOrw=;
 b=guPqze+ojqPekOOY1tKt/2Yy0oVrunFcR8h3kdwulXRtoI93BjUnYMmzEHZoWMgE/4
 Vbbonnm2HPKoTtSvAvATlWzp4NTQO2zOHVtshnKjZKtmx9ilvyFQgRmFtpxK2zVLmYoL
 WyWIZeMci7P4NWBV8hEDJjf5xCOd/32tbyUUP9cLgWy1QC06CdsnV5syY1lVrkWFbSN6
 0EjP25D59HGSvsUQOuovldW4me+10hs8qSV9/bQjNsItsglZSTLQgpFVs3QXv6NarUFL
 t5Omtm9K4zJFfAN0l10Lx5qmYCysCduovQqetOvEbUGUWIYZIyaCZVAUgyP2zl9sd4pf
 ReOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8mW9B4ghv+SFJyR+UXVXQfSGxJv0tZDd1eZyTvGh8DtAWwIpAsk9aMXLjjO5RcUGfZlhrbMp5fTnt@nongnu.org
X-Gm-Message-State: AOJu0Yx4+bewLkh0Er/XmcLZ4UiTCsfCSk1ewa8TLpqGNgzKIqmXPWGF
 EKktVr5evuPiFE7C1CrlTliujQalN8ZZp4Xy6O/BkeAUrtSLdn++quAT+gPj8uTXxKh/KKgk7pV
 lDTj883yGm4m05S0ByP7DB4seKrnpQOcQhJXxwXM8Xg4nfMOS84gTgTGw
X-Gm-Gg: AY/fxX4DJS5dDtknVN7i0S+J9iVKXlhPNRBYCFJ5XOGhEj90YcRxtXSvjngdEOTVgjv
 DUAM2/PvuUtl/W+Bk9cf9clxs5k234ed7Pnb8OZtmTEcelOFKGrodrIwD6yvhQnyKr98bGuw2Oj
 eUNBQdsywIQJEx3Ym5D/505/s7mSD0OsCJaon+sMtSZqe03nBi4TaCtxOR0hQWOJ9GlxSP+BkqG
 9dX+VToLcsIujRpQEYMWnJHCAV3aGrVnqiKVU7ojR2HmvVgy6m4tjxaTv6HevbeQnN57Kq2rcIk
 BCMvBG8/d1LP8Zc0wUA7lWPPp7Z1nXOaUf2yVsT28Fhu9n5XDxaU6xFdBZ5MOLJK3rlG0x+lpAz
 rIW56EESGvx9Mq7EqLeAp5sJb6CYteh1cShlT4hRDACQ7P1SI
X-Received: by 2002:a05:6000:178a:b0:430:f449:5f18 with SMTP id
 ffacd0b85a97d-432c37644b4mr13124630f8f.46.1767970250905; 
 Fri, 09 Jan 2026 06:50:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkaOPu8Zgx/2miNmt3aV1z117gw7WVrChuwWRIBBS4NNWRRKVTtIRBibO6NFfabPCHAfuU0g==
X-Received: by 2002:a05:6000:178a:b0:430:f449:5f18 with SMTP id
 ffacd0b85a97d-432c37644b4mr13124591f8f.46.1767970250434; 
 Fri, 09 Jan 2026 06:50:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e6784sm22920607f8f.19.2026.01.09.06.50.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 06:50:49 -0800 (PST)
Message-ID: <8085d705-7b62-4098-8ad9-7addc9069a9a@redhat.com>
Date: Fri, 9 Jan 2026 15:50:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/4] Implement ERRATA_772415 quirk for VTD
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20260106062808.316574-1-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260106062808.316574-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/6/26 07:28, Zhenzhong Duan wrote:
> Hi,
> 
> Based on Cédric's suggestions[1], The nesting series v8 is split to
> "base nesting series" + "ERRATA_772415_SPR17 quirk series", this is the
> ERRATA_772415_SPR17 quirk series.
> 
> On a system influenced by ERRATA_772415, IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17
> is repored by IOMMU_DEVICE_GET_HW_INFO. Due to this errata, even the readonly
> range mapped on second stage page table could still be written.
> 
> Reference from 4th Gen Intel Xeon Processor Scalable Family Specification
> Update, Errata Details, SPR17.
> Link https://edc.intel.com/content/www/us/en/design/products-and-solutions/processors-and-chipsets/eagle-stream/sapphire-rapids-specification-update/
> Backup link https://cdrdv2.intel.com/v1/dl/getContent/772415
> 
> Also copied the SPR17 details from above link:
> "Problem: When remapping hardware is configured by system software in
> scalable mode as Nested (PGTT=011b) and with PWSNP field Set in the
> PASID-table-entry, it may Set Accessed bit and Dirty bit (and Extended
> Access bit if enabled) in first-stage page-table entries even when
> second-stage mappings indicate that corresponding first-stage page-table
> is Read-Only.
> 
> Implication: Due to this erratum, pages mapped as Read-only in second-stage
> page-tables may be modified by remapping hardware Access/Dirty bit updates.
> 
> Workaround: None identified. System software enabling nested translations
> for a VM should ensure that there are no read-only pages in the
> corresponding second-stage mappings."
> 
> QEMU code can be found at [2], it's based after below two series:
> 
> [PATCH v10 00/19] intel_iommu: Enable first stage translation for passthrough device
> [PATCH v6 0/9] vfio: relax the vIOMMU check
> 
> Thanks
> Zhenzhong
> 
> Changelog:
> v10:
> - All headers under include/hw/ have been moved to include/hw/core/, do
>    the same for iommu.h (Cédric)
> 
> v9:
> This is a new split from nesting series, see the link[3] for history changelog.
> 
> [1] https://lore.kernel.org/qemu-devel/bbc8412b-25c3-4c95-9fde-a1c9c29b54ce@redhat.com/
> [2] https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_ERRATA_772415.v10
> [3] https://lore.kernel.org/qemu-devel/20251117093729.1121324-1-zhenzhong.duan@intel.com/
> 
> 
> Zhenzhong Duan (4):
>    hw/pci: Introduce pci_device_get_host_iommu_quirks()
>    intel_iommu_accel: Implement get_host_iommu_quirks() callback
>    vfio/listener: Bypass readonly region for dirty tracking
>    Workaround for ERRATA_772415_SPR17
> 
>   docs/devel/vfio-iommufd.rst      |  9 ++++++
>   hw/i386/intel_iommu_accel.h      |  5 ++++
>   include/hw/core/iommu.h          |  5 ++++
>   include/hw/pci/pci.h             | 31 ++++++++++++++++++++
>   include/hw/vfio/vfio-container.h |  1 +
>   include/hw/vfio/vfio-device.h    |  3 ++
>   hw/i386/intel_iommu.c            |  2 ++
>   hw/i386/intel_iommu_accel.c      | 21 ++++++++++++++
>   hw/pci/pci.c                     | 12 ++++++++
>   hw/vfio/device.c                 | 14 +++++++++
>   hw/vfio/iommufd.c                |  9 +++++-
>   hw/vfio/listener.c               | 50 +++++++++++++++++++++++++-------
>   hw/vfio/trace-events             |  1 +
>   13 files changed, 151 insertions(+), 12 deletions(-)
> 


Applied to vfio-next.

Thanks,

C.


