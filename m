Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCAC9C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 16:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsOsh-0003c8-Ql; Wed, 12 Mar 2025 12:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tsOs1-0003VQ-Gi
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 12:23:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tsOrz-0002Q7-7e
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 12:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741796625;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b2z/VGOPk/+7T1T04VaFT1kEYO4PDK/MXQ7RuZ6Izao=;
 b=M0AZCyV+PcAHd7zGDB13ytlv3y3S8mG6KD6QBDuPk/md7S2WQskBQeQazjYhowJmC2tnGT
 HvXRLwWUX7kzH9ryDbdETbQcGbY1ybQ6dpClIJprap1tPZGpe0070DH6OVR+R9C43NbFMZ
 fgfyJuk+1JAM7+AoC4k9c3DuQFgfA2w=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-cqOBm9_GN0On6Kk7fGodvw-1; Wed, 12 Mar 2025 12:23:43 -0400
X-MC-Unique: cqOBm9_GN0On6Kk7fGodvw-1
X-Mimecast-MFC-AGG-ID: cqOBm9_GN0On6Kk7fGodvw_1741796623
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6e916df0d5dso1113236d6.2
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 09:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741796622; x=1742401422;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b2z/VGOPk/+7T1T04VaFT1kEYO4PDK/MXQ7RuZ6Izao=;
 b=SMferDZqK+FMr5SoBgtWuIiN2Iov7RqLdbe//l7a3gX9u+pSo9nuyJpb7J2L9eQALQ
 FxxsZY2YUluomtB9NZLtMwrAeGnmoP2O8Zo/Yg3xm1zaNMrHsqJJHpcgafTp5O3+2u1h
 bjJVKWDUfXnKStulx24inxVt91GGhHBshiQ6MoS6jE2XV+TDMWkPyCg7qZPKv1Ufu8Om
 DBJc8R3Hwstmu8GXswwGAd82AHHf6JFAa3OylE3TEBtyR8kkzVPDfUhweEjSRAXUmRFa
 8/FYgRdScZkFJlroALD0a9sutfrIP3wGJlC37vpBj5vJnroIQbovTK+d77uVWdEhzhHV
 SU0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVId02ij+nYksTjl/RQXdSDuYnogwAKlU0v7+gqYkv1OXELhXcxhhY4ilmT9WZlXra2dc/l7xrXrblc@nongnu.org
X-Gm-Message-State: AOJu0Yxc7uayYgdf3sQ1z6viwZu9nkWdEyXwk+/gK5ceKMM2BPmHCKM+
 4H8obW5wfVf7a5JVAbinryC+D2U9cjuaaV7QKp3jFabfznXiwRyjY0oBUbgJYnqrubPpeyI/bfE
 sEZIzYK0jYqII3oqCLLScdcKUPWzIe4OO2NRjjq3L1wp3W5piWRGe
X-Gm-Gg: ASbGncu85FCzVs1FpBe+esKhrEfFHFoiSeXAkk7GmgfZQAbY1rpwluGF2NTNtUtTcBB
 lKxhbWhU6o2/WVGufPo2GAW7aMWkDtnfWr0p7cy/cFLZs1ygo1+PDm0Pph/uQla6abx6TY4ZIzJ
 L/M+GBovo0etGuNxx7f55ElskxZtqGswM/vzJCyUoh1ueJEkbXSk6xaxIvj5GHN+ses3agxqpcz
 U3zJsDZ57VkJcVroOg8IrYqEg41BMtVvr3IbWNtMg7AZpfT1b+aoOMV0PVD5ER8eqkr3m6CmP2b
 KaS55yHEeryOCc4/mtBsK6HFR/c39Lw9m1UiNFJ3VAd1JyGIZQds/oDmOhRZG6k=
X-Received: by 2002:a05:6214:21eb:b0:6e8:fcde:58d5 with SMTP id
 6a1803df08f44-6ea3a6a9638mr124860436d6.42.1741796622694; 
 Wed, 12 Mar 2025 09:23:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGE7hqa0dtUyfYZemJmdDfqPZcfeebFrHBhxxUmvQ+8quj5ifAGl5G4Z3OQNOPqdGA3mbnGmA==
X-Received: by 2002:a05:6214:21eb:b0:6e8:fcde:58d5 with SMTP id
 6a1803df08f44-6ea3a6a9638mr124860186d6.42.1741796622358; 
 Wed, 12 Mar 2025 09:23:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f71725b8sm86288546d6.118.2025.03.12.09.23.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 09:23:41 -0700 (PDT)
Message-ID: <fe047856-b564-4776-8651-daa65c02133b@redhat.com>
Date: Wed, 12 Mar 2025 17:23:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 07/20] hw/arm/smmu-common: Introduce callbacks for
 PCIIOMMUOps
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-8-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250311141045.66620-8-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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




On 3/11/25 3:10 PM, Shameer Kolothum wrote:
> Subsequently smmuv3-accel will provide these callbacks
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/smmu-common.c         | 27 +++++++++++++++++++++++++++
>  include/hw/arm/smmu-common.h |  5 +++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 83c0693f5a..9fd455baa0 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -865,6 +865,10 @@ static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
>      SMMUState *s = opaque;
>      SMMUPciBus *sbus = smmu_get_sbus(s, bus);
>  
> +    if (s->accel && s->get_address_space) {
> +        return s->get_address_space(bus, opaque, devfn);
> +    }
> +
why do we require that new call site? This needs to be documented in the
commit msg esp. because we don't know what this cb will do.
>      sdev = sbus->pbdev[devfn];
>      if (!sdev) {
>          sdev = sbus->pbdev[devfn] = g_new0(SMMUDevice, 1);
> @@ -874,8 +878,31 @@ static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
>      return &sdev->as;
>  }
>  
> +static bool smmu_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
> +                                      HostIOMMUDevice *hiod, Error **errp)
> +{
> +    SMMUState *s = opaque;
> +
> +    if (s->accel && s->set_iommu_device) {
> +        return s->set_iommu_device(bus, opaque, devfn, hiod, errp);
> +    }
> +
> +    return false;
> +}
> +
> +static void smmu_dev_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
> +{
> +    SMMUState *s = opaque;
> +
> +    if (s->accel && s->unset_iommu_device) {
> +        s->unset_iommu_device(bus, opaque, devfn);
> +    }
> +}
> +
>  static const PCIIOMMUOps smmu_ops = {
>      .get_address_space = smmu_find_add_as,
> +    .set_iommu_device = smmu_dev_set_iommu_device,
> +    .unset_iommu_device = smmu_dev_unset_iommu_device,
>  };
>  
>  SMMUDevice *smmu_find_sdev(SMMUState *s, uint32_t sid)
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 80ff2ef6aa..7b05640167 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -160,6 +160,11 @@ struct SMMUState {
>  
>      /* For smmuv3-accel */
>      bool accel;
> +
> +    AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque, int devfn);
> +    bool (*set_iommu_device)(PCIBus *bus, void *opaque, int devfn,
> +                             HostIOMMUDevice *dev, Error **errp);
> +    void (*unset_iommu_device)(PCIBus *bus, void *opaque, int devfn);
I think this should be exposed by a class and only implemented in the
smmuv3 accel device. Adding those cbs directly in the State looks not
the std way.

Eric
>  };
>  
>  struct SMMUBaseClass {


