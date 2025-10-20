Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425F1CCD1A7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 16:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAszM-0007n6-TL; Mon, 20 Oct 2025 12:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vAszL-0007mS-6d
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 12:44:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vAszJ-0004GM-GI
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 12:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760978639;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qPj3Vwu54LX9v8fMsZBp5Ek+ELZ3NQBdO0d0GVUn33w=;
 b=I3XblUa7HHbP41Ut45xq+oHGPw75tYfSZPve9gp1SyrPjr9RDIMEvftrfD/F0ViOgaSWcg
 CGBqEcc4V+GKB7y38SkO7mFZrCmo3tD0yZ3ttlGpZvJEQs+Ir21bjfJrRs+SGHGQj32tOW
 qBHNURcTPQanAKYan2IiSnVCAXzS/5M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-2XFwgcjYPzanaP-9UZtHYg-1; Mon, 20 Oct 2025 12:43:58 -0400
X-MC-Unique: 2XFwgcjYPzanaP-9UZtHYg-1
X-Mimecast-MFC-AGG-ID: 2XFwgcjYPzanaP-9UZtHYg_1760978637
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46b303f6c9cso53258745e9.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 09:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760978637; x=1761583437;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qPj3Vwu54LX9v8fMsZBp5Ek+ELZ3NQBdO0d0GVUn33w=;
 b=jST9r83Az7L90lUeD62+FjQn2foHXgOc2V4wbea3XDFt7t6TdoX9kX+Jrp14YEAxc1
 jI1rWo1BFcNUaCGCKhsyuukDWM2nxS//UuypH97MrlOsg7U5Hk3UALkRhKsmj9Nb+Uwp
 7F09cOjJ6Rr28YHd+o/jS/r+2+igqNDXg+ycnJyZriwiiqXG4StrJS8/v9zQCovek3dj
 Sf64gQa93sIDaX7v7TCfzspIsvRoPUKa8yHeEi5eDse9M8K+KfRzi7uckvuHQ9KKzS1U
 HhGEujexG1mWcuRsUHxNbMp20DMoejVzlcr9/svIm2da8roBgmGdKYfZhhtnKusx+tJ/
 27wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8QYRwh6f9a0WFvC6a2NOVep8H64pRSWSaRv3yt2oDDLqxofwoiQNALqZ3RSxNLkCmYYhouO9ywwlr@nongnu.org
X-Gm-Message-State: AOJu0YxTPskhlL0WGbXB0BhQPpCfJV/Yz9ysvvtZYDf04b9fUcJ4x5km
 Y89QALLeKFuvZdrTLKBEm2+h2ZGeNF5KG70fqAJs4uckxtOJwevbOqy7ZIz2j8JNmRq47F1YVsh
 UhGyKdOpUCEyQiQXCka+PgfckU06x9ShV1t1VrjR/kLHubamV2zEhrqGM
X-Gm-Gg: ASbGncsO34YBbw4oZplUZn1FxbYJJYIoJpCQKfk69aitSWdn6PbsT+6bJHjRgzl97Fc
 YfJ5h1Nnz0lBdaiXZG/FkqZNurssa7i0gd3t6nKDSObl5ec/z1kkF9hA3jIOFJ10mUoaRVtcuXW
 9ZOYgC5nVUlMvNkW5HkVSNaK6owZXscgGDC1VUvnf06frZd+P2ARK8gP4MyhaAl5U+dY2mvF2Q4
 Fd6g6oVFhMdYnCGF098HUlGG5UDCK3GqH4UGGUughHL5F46ptjIlA8QAHONZ05DZszHB1i3JxQu
 Hpam2ECOWF0ZcUgArcnSCI77zXrhXYnicc+d0KQoBxOqYoOaWNAZVkpbfDyhalLGbnWj3VaMhVo
 9XqId
X-Received: by 2002:a05:6000:1863:b0:425:742e:7823 with SMTP id
 ffacd0b85a97d-42704d7e91dmr9125751f8f.12.1760978636840; 
 Mon, 20 Oct 2025 09:43:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0xk5vTMSAX5abQSEf/PTOM6nTtoqWfX4WNj27pZNJ3V3w528fwCnQ4XG7RoOr3Z90vRvgbg==
X-Received: by 2002:a05:6000:1863:b0:425:742e:7823 with SMTP id
 ffacd0b85a97d-42704d7e91dmr9125730f8f.12.1760978636471; 
 Mon, 20 Oct 2025 09:43:56 -0700 (PDT)
Received: from [192.168.43.95] ([37.166.134.90])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f009a797sm16144976f8f.27.2025.10.20.09.43.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 09:43:56 -0700 (PDT)
Message-ID: <8ce5574e-3e31-456c-9579-0fbf8526651f@redhat.com>
Date: Mon, 20 Oct 2025 18:43:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/27] hw/arm/smmuv3-accel: Make use of
 get_msi_address_space() callback
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 shameerkolothum@gmail.com
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-13-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250929133643.38961-13-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,

On 9/29/25 3:36 PM, Shameer Kolothum wrote:
> Here we return the IOMMU address space if the device has S1 translation
> enabled by Guest. Otherwise return system address space.
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 790887ac31..f4e01fba6d 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -387,6 +387,26 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
>      }
>  }
>  
> +static AddressSpace *smmuv3_accel_find_msi_as(PCIBus *bus, void *opaque,
> +                                              int devfn)
> +{
> +    SMMUState *bs = opaque;
> +    SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
> +    SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
> +    SMMUDevice *sdev = &accel_dev->sdev;
> +
> +    /*
> +     * If the assigned vfio-pci dev has S1 translation enabled by
> +     * Guest, return IOMMU address space for MSI translation.
> +     * Otherwise, return system address space.
> +     */
> +    if (accel_dev->s1_hwpt) {
> +        return &sdev->as;
> +    } else {
> +        return &address_space_memory;
> +    }
At the moment I don't understand this code either. In case of emulated
device it then returns address_space_memory whereas I would have
expected the opposite. I definitively need to trace things ;-)

Thanks

Eric
> +}
> +
>  static bool smmuv3_accel_pdev_allowed(PCIDevice *pdev, bool *vfio_pci)
>  {
>  
> @@ -475,6 +495,7 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
>      .get_viommu_flags = smmuv3_accel_get_viommu_flags,
>      .set_iommu_device = smmuv3_accel_set_iommu_device,
>      .unset_iommu_device = smmuv3_accel_unset_iommu_device,
> +    .get_msi_address_space = smmuv3_accel_find_msi_as,
>  };
>  
>  void smmuv3_accel_init(SMMUv3State *s)


