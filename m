Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8666BCCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kD9-0003cR-FG; Fri, 17 Oct 2025 09:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v9kCi-00039t-HS
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:09:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v9kCY-0004Vr-En
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760706533;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wD9m0MqNs8AycWDX567nhwaXGPoa/Fxx7YOxRbdO0Og=;
 b=ittGgSmQnGXZj8DwZmRNIjdajNn0C88ORGXqvriGZql25Fexl87Yqi3qHn4Z2fEMROnrnv
 Ex7DpDn7LR6dEHYaH9F2YYxd48U8jJ6nqYdwG0AjOp+tuv+xtcZByWUa0xblELb1doiFob
 FDbJlZEC2FeFQw88UEGQm8tMlaXM53w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-6ErSticvNcmwS41bya5lfw-1; Fri, 17 Oct 2025 09:08:50 -0400
X-MC-Unique: 6ErSticvNcmwS41bya5lfw-1
X-Mimecast-MFC-AGG-ID: 6ErSticvNcmwS41bya5lfw_1760706529
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-426d4f59cbcso1700491f8f.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760706529; x=1761311329;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wD9m0MqNs8AycWDX567nhwaXGPoa/Fxx7YOxRbdO0Og=;
 b=VmFFRUyWDltvfYEQ/MlKlpthzKlriIS5rSWb/1Z/hLb1fADwj6/9Kh5D3OXvzxMZrb
 ZNFV1b5nK4HYsy3azKh99j1rugUsmPhgGNmeIA+Ie35knqkrsHbM2sLog2qwNgHi2uRh
 2MIJTzFAd2c3tpSiqE8xQ4roI/hRsXGsWLcE0GHswxzXXPbgLpeUZZ0ItBFZQKgeh/QM
 vSelrsGEN6HVAl+St05EPZhNAqIUpwxzNY8lHI75LuXp9t24Mk5E/pNkSFTutQhrC/3C
 f1VzbqmVU7PPQgFFUxMrmf/pg65/vW1S0bzTHlp/7uWiix8Uv1SLLvO1YIIdEFRS7ZbV
 u11g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGUZxzvCy746xF091XsPyK9Kk6eusZ9elMMC0HOYwTl8ouzRoyRK8C/ptEUUl7udlQPD4qnjB1RZqM@nongnu.org
X-Gm-Message-State: AOJu0YyNYs1eynI9EDY6nwRby1xlMMJCD96gyeW8rUMbacgwY+g5nAre
 lpLZGWBV7e+JNFsu4hXNwUGlQ8+JJRefFO43HuLh7pXUQclQC4mRj1FRmb1fUYxjDz5Nogmk/NJ
 LoK9ZZfRjvjJna35+0OOYZhj8sZmdpyXIqpxnhMHITlKb3bFU2YvT/RNH
X-Gm-Gg: ASbGnctqPSxgYyu2ekJ6H0HPLs0/S6ZKT04NdPQNxHVz910iEsrvWcU6mxyGVkhEnt9
 vwS6TWY0uC2hlUz7026E6PektqQFBUaBRP6rTL3hvEeFlZj2xF6qvGN9dRwnq1ppA7kD7ePNH7o
 wYE40mX5u1DEM9y56pWy/IkjsjtO+sAzPiFV0ops271bd+dm9rbZ3Pq2rTTaMEeJuQubL9CmTZG
 qrqy/F9843d/dMlobjv/Iz5DEOBYEgdRqiZs+ZyZm0a9fKsnA6b7MHG0MLi5YgtpMPmjsZ6NcnT
 pQXQTGGs0AXTYY9WS3NBOWFWVrVVuo1PoLMrU8xbIMfyFom18Yrc+B1BEufp3z7KKXFFRCupWdH
 8K/BPKOjzP3otwHxkyV7ghO9gvCjnOqhiOPcTK2t/ir4N5A==
X-Received: by 2002:a05:6000:1a86:b0:407:d776:4434 with SMTP id
 ffacd0b85a97d-426fb9b5505mr5525771f8f.30.1760706529198; 
 Fri, 17 Oct 2025 06:08:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfhyNSH5Mts8E+f/30Tt84/ASyBY4InO89LVZDJTHBNGIQJdd7WB8bfad3ImzEINxGpX/Bwg==
X-Received: by 2002:a05:6000:1a86:b0:407:d776:4434 with SMTP id
 ffacd0b85a97d-426fb9b5505mr5525725f8f.30.1760706528741; 
 Fri, 17 Oct 2025 06:08:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e0a03sm40993368f8f.37.2025.10.17.06.08.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Oct 2025 06:08:48 -0700 (PDT)
Message-ID: <95d5e2a0-4907-47c2-96f8-ed6d31faee9b@redhat.com>
Date: Fri, 17 Oct 2025 15:08:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/27] hw/arm/smmuv3-accel: Allocate a vDEVICE object
 for device
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
 <20250929133643.38961-11-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250929133643.38961-11-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Allocate and associate a vDEVICE object for the Guest device with the
> vIOMMU. This will help the host kernel to make a virtual SID --> physical
> SID mapping. Since we pass the raw invalidation commands(eg: CMD_CFGI_CD)
> from Guest directly to host kernel, this provides a way to retrieve the
> correct physical SID.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  hw/arm/smmuv3-accel.h |  1 +
>  2 files changed, 42 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 5c3825cecd..790887ac31 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -39,6 +39,35 @@
>  #define STE1_MASK     (STE1_ETS | STE1_S1STALLD | STE1_S1CSH | STE1_S1COR | \
>                         STE1_S1CIR | STE1_S1DSS)
>  
> +static bool
> +smmuv3_accel_alloc_vdev(SMMUv3AccelDevice *accel_dev, int sid, Error **errp)
> +{
> +    SMMUViommu *viommu = accel_dev->viommu;
> +    IOMMUFDVdev *vdev;
> +    uint32_t vdev_id;
> +
> +    if (!accel_dev->idev || accel_dev->vdev) {
> +        return true;
> +    }
> +
> +    if (!iommufd_backend_alloc_vdev(viommu->iommufd, accel_dev->idev->devid,
> +                                   viommu->core.viommu_id, sid,
> +                                   &vdev_id, errp)) {
> +            return false;
> +    }
> +    if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->idev,
> +                                               viommu->bypass_hwpt_id, errp)) {
> +        iommufd_backend_free_id(viommu->iommufd, vdev_id);
> +        return false;
> +    }
> +
> +    vdev = g_new(IOMMUFDVdev, 1);
> +    vdev->vdev_id = vdev_id;
> +    vdev->dev_id = sid;
That's confusing to me it should be virt_id and not dev_id which usually
refers to an iommu object id.

Would be nice in general to stick to the kernel uapi terminology. For
instance vdev_id shall rather vdevice_id although in that case it is
understandable.

+bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
+                                uint32_t viommu_id, uint64_t virt_id,
+                                uint32_t *out_vdev_id, Error **errp)

 * struct iommu_vdevice_alloc - ioctl(IOMMU_VDEVICE_ALLOC)
 * @size: sizeof(struct iommu_vdevice_alloc)
 * @viommu_id: vIOMMU ID to associate with the virtual device
 * @dev_id: The physical device to allocate a virtual instance on the vIOMMU
 * @out_vdevice_id: Object handle for the vDevice. Pass to IOMMU_DESTORY
 * @virt_id: Virtual device ID per vIOMMU, e.g. vSID of ARM SMMUv3,
vDeviceID
 *           of AMD IOMMU, and vRID of Intel VT-d



> +    accel_dev->vdev = vdev;
> +    return true;
> +}
> +
>  static bool
>  smmuv3_accel_dev_uninstall_nested_ste(SMMUv3AccelDevice *accel_dev, bool abort,
>                                        Error **errp)
> @@ -127,6 +156,10 @@ smmuv3_accel_install_nested_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
>          return true;
>      }
>  
> +    if (!smmuv3_accel_alloc_vdev(accel_dev, sid, errp)) {
> +        return false;
> +    }
> +
>      ret = smmu_find_ste(sdev->smmu, sid, &ste, &event);
>      if (ret) {
>          error_setg(errp, "Failed to find STE for Device 0x%x", sid);
> @@ -311,6 +344,7 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
>      SMMUPciBus *sbus = g_hash_table_lookup(bs->smmu_pcibus_by_busptr, bus);
>      SMMUv3AccelDevice *accel_dev;
>      SMMUViommu *viommu;
> +    IOMMUFDVdev *vdev;
>      SMMUDevice *sdev;
>      uint16_t sid;
>  
> @@ -337,6 +371,13 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
>      trace_smmuv3_accel_unset_iommu_device(devfn, sid);
>  
>      viommu = s->s_accel->viommu;
> +    vdev = accel_dev->vdev;
> +    if (vdev) {
> +        iommufd_backend_free_id(viommu->iommufd, vdev->vdev_id);
> +        g_free(vdev);
> +        accel_dev->vdev = NULL;
> +    }
> +
>      if (QLIST_EMPTY(&viommu->device_list)) {
>          iommufd_backend_free_id(viommu->iommufd, viommu->bypass_hwpt_id);
>          iommufd_backend_free_id(viommu->iommufd, viommu->abort_hwpt_id);
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index f631443b09..6242614c00 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -31,6 +31,7 @@ typedef struct SMMUv3AccelDevice {
>      SMMUDevice  sdev;
>      HostIOMMUDeviceIOMMUFD *idev;
>      SMMUS1Hwpt *s1_hwpt;
> +    IOMMUFDVdev *vdev;
>      SMMUViommu *viommu;
>      QLIST_ENTRY(SMMUv3AccelDevice) next;
>  } SMMUv3AccelDevice;
Thanks

Eric


