Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0D1C61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1gEz-0001wv-EO; Wed, 02 Sep 2026 04:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x1gEu-0001vk-Qy
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 04:22:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x1gEs-0003mg-LN
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 04:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788337353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=reHRmFroZgyQqTSSM7gtPTfBJgncX3xCxlhPRDWBV1w=;
 b=hJ4nDXEKL+kCu1PcNTzyg0MnLlsPY9D+IE3G5GSOeXKw0jaVfE8jTAd6FxuICXzhDZHmxN
 eLHXQJUK0uVJn5W1et7nEigoc5DJtb+q2HiDNMqpjpmZpY4vyktBe0vMbKyJefoF1tyrST
 r1BwiEYH6lYnDgXfpQnmMSoILmmwlbo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-c1OWfA2fMg2R5kokPUq7JA-1; Wed, 02 Sept 2026 04:22:32 -0400
X-MC-Unique: c1OWfA2fMg2R5kokPUq7JA-1
X-Mimecast-MFC-AGG-ID: c1OWfA2fMg2R5kokPUq7JA_1788337350
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c1c25c44d15so74722366b.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 01:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788337350; x=1788942150; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=reHRmFroZgyQqTSSM7gtPTfBJgncX3xCxlhPRDWBV1w=;
 b=W0Wa4LXsHeeYIPvGoD9Ztih0M7Ufhf/grPDpnfSAPfbqKWx5IMjf5W7Ap1A4hzT/mm
 SQSsTMMC5o5IrgdlEFZ5zG1u8sosUGvh4sWO/FQptM+dDRbVRXzSN27JewDkPZzs5MIl
 oyNDDRViMJaTK/VuLPAtUgoBr0NY5AlhI/Z4hl5xdOYoanQGIkWALxiZkPrW1+OutGSy
 vY+KsluvjtgafLq8R1GV6WyBlVDQMdkJhwcu8dahXpzVBCey5xwqd3OAZymzecDVUXka
 BAZjAYYqydHptt/sd24Q4/qohAmei95qvlsTOGsxpf8QYWPNjAEblvY3ldHbI3CFt/E0
 K7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788337350; x=1788942150;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=reHRmFroZgyQqTSSM7gtPTfBJgncX3xCxlhPRDWBV1w=;
 b=JHpQ02WvMM81Zhs7nMO+i/79Dt+G/alTNt8CbchmQ8E2Ca7RK5JSeZrJd9EluLZYM2
 BCVdt/NlKK1UKv4+kZnT0p4u5eBnmPMkABVq+54bBDrVMW1p9ovW0lgIzKn7GwHXrpmT
 PRu04e5svem+qmqhnkR6mBaeWUck9edZcj64CkAGJBVL5zvVgHVRajFOhb5EggO78wMM
 Y3sFPiU3dZqLmYmiCg1KdoFqNYZmv6tUl7svwMDjcLbp0hjc2nbF1w17B0gaHoavnkqi
 aZbw5LhRJ43ndB2itN+MRk4MUIN2EVumZ51EjCM/Nm6H8cuHwC+ieRQr7cic9Oqwlcl6
 lbiQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwX1B7npfgLp2ghFwWC6rAB8kFofTV4he7qNDs5pBXd+dG4SVqQGAeZpXZBOyhT8s2qvQe+Mi7Ap1H/@nongnu.org
X-Gm-Message-State: AFuF++kzej5td0HlrIgD2x649DqqSKxr/2ANKZ0FjW11izPdw5ubt0Dz
 3yUmuNSw6cbpkBSQiEgN5qaZIlOSQJsGiHxl98RSsuqXV6B3EyPf4KChH4Zxc0LuH1tf5/C46Ny
 bO06MN4WQSpmR/HwIbucW3hZ1UVQM2bHYC/tQ7fbOtwhOgqp578/PwsB+
X-Gm-Gg: AYBFou13wL3PhYlObPbni8WIz2v424I+qJZa5ohnZRgh52wh6DTjfjuCeF48fCZSOKu
 Xrwl7CnEorZo3KNOlmW7ixa3jgsK/vc5jWt75vHBuTsv+C8WFu2d2bE+pky9R4iSSpX29fYOvSg
 fc+wjOsx+fMPZZjLL0JuoeGFHK/quLs8JxOsysJxeW4Rto8KQwHT3NCrtSDYWT+PWmbc5FFfwM6
 Ouuxvp06olbPYkqFCBBRK1slL8tprUR5oLr5Se9e8NtEZyeAkXl8895nb2+XgIxvzwWsnwPwBd2
 nVS/o/qtY9o2WzNFK9khklYZ9k3gCJc/VM2Mkwh1d3P5H/0wsZULbqUPwdNefzfNVI8w/+kHdUk
 cMsJTch5/khLi+2GOw3QV/HXImtRjTUmkT5niMLc=
X-Received: by 2002:a05:6402:3897:b0:6a0:ffb0:273b with SMTP id
 4fb4d7f45d1cf-6a6817ddb44mr2241626a12.0.1788337349871; 
 Wed, 02 Sep 2026 01:22:29 -0700 (PDT)
X-Received: by 2002:a05:6402:3897:b0:6a0:ffb0:273b with SMTP id
 4fb4d7f45d1cf-6a6817ddb44mr2241595a12.0.1788337349231; 
 Wed, 02 Sep 2026 01:22:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:2cd2:7ace:8238:f7f4?
 ([2a01:e0a:280:24f0:2cd2:7ace:8238:f7f4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a67f952ed9sm657009a12.27.2026.09.02.01.22.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 01:22:28 -0700 (PDT)
Message-ID: <5e59ad40-e50e-4671-b55f-2d891898b6e7@redhat.com>
Date: Wed, 2 Sep 2026 10:22:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] s390x/pci: Add PCI error handling for vfio pci
 devices
To: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com,
 alex@shazbot.org, armbru@redhat.com
References: <20260831183151.12626-1-alifm@linux.ibm.com>
 <20260831183151.12626-4-alifm@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260831183151.12626-4-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/31/26 20:31, Farhan Ali wrote:
> Add an s390x specific callback for vfio error handling. For s390x pci devices,
> we have platform specific error information. We need to retrieve this error
> information for passthrough devices. This is done via a VFIO_DEVICE_FEATURE
> ioctl which exposes that information.
> 
> Once this error information is retrieved we can then inject an error into
> the guest, and let the guest drive the recovery.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-bus.c          |   9 +++
>   hw/s390x/s390-pci-vfio-stubs.c   |   6 ++
>   hw/s390x/s390-pci-vfio.c         | 100 +++++++++++++++++++++++++++++++
>   include/hw/s390x/s390-pci-bus.h  |   2 +
>   include/hw/s390x/s390-pci-vfio.h |   1 +
>   5 files changed, 118 insertions(+)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 9ecf3c30ad..b2db7f3df4 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -160,6 +160,8 @@ static void s390_pci_perform_unplug(S390PCIBusDevice *pbdev)
>   {
>       HotplugHandler *hotplug_ctrl;
>   
> +    qemu_mutex_destroy(&pbdev->err_handler_lock);
> +
>       if (pbdev->pft == ZPCI_PFT_ISM) {
>           notifier_remove(&pbdev->shutdown_notifier);
>       }
> @@ -1123,6 +1125,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>       S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
>       PCIDevice *pdev = NULL;
>       S390PCIBusDevice *pbdev = NULL;
> +    Error *local_err = NULL;
>       int rc;
>   
>       if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
> @@ -1189,6 +1192,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>           pbdev->iommu->pbdev = pbdev;
>           pbdev->state = ZPCI_FS_DISABLED;
>           set_pbdev_info(pbdev);
> +        qemu_mutex_init(&pbdev->err_handler_lock);
>   
>           if (object_dynamic_cast(OBJECT(dev), "vfio-pci")) {
>               /*
> @@ -1213,6 +1217,11 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>               pbdev->iommu->dma_limit = s390_pci_start_dma_count(s, pbdev);
>               /* Fill in CLP information passed via the vfio region */
>               s390_pci_get_clp_info(pbdev);
> +            /* Setup error handler for error recovery */
> +            if (!s390_pci_setup_err_handler(pbdev, &local_err)) {
> +                warn_report_err(local_err);
> +            }
> +
>               if (!pbdev->interp) {
>                   /* Do vfio passthrough but intercept for I/O */
>                   pbdev->fh |= FH_SHM_VFIO;
> diff --git a/hw/s390x/s390-pci-vfio-stubs.c b/hw/s390x/s390-pci-vfio-stubs.c
> index d9882b7aad..9fc84ca135 100644
> --- a/hw/s390x/s390-pci-vfio-stubs.c
> +++ b/hw/s390x/s390-pci-vfio-stubs.c
> @@ -30,3 +30,9 @@ bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh)
>   void s390_pci_get_clp_info(S390PCIBusDevice *pbdev)
>   {
>   }
> +
> +bool s390_pci_setup_err_handler(S390PCIBusDevice *pbdev, Error **errp)
> +{
> +    error_setg(errp, "VFIO not available, cannot setup error handler");
> +    return false;
> +}
> diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
> index db6de00bd2..9a63040e22 100644
> --- a/hw/s390x/s390-pci-vfio.c
> +++ b/hw/s390x/s390-pci-vfio.c
> @@ -105,6 +105,73 @@ void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt)
>       }
>   }
>   
> +static int s390_pci_get_feature_err(VFIOPCIDevice *vfio_pci,

returning a bool would be preferred unless the errno is important

> +                                    PciCcdfErr *ccdf,
> +                                    uint32_t ccdf_err_length,
> +                                    Error **errp)
> +{
> +    int ret;
> +    size_t total_size;
> +    struct vfio_device_feature_zpci_err *err;
> +    g_autofree void *buf = NULL;
> +    g_autofree struct vfio_device_feature *feature = NULL;
> +
> +    total_size = sizeof(*feature) + sizeof(*err);
> +    feature = g_malloc(total_size);
> +    feature->argsz = total_size;
> +    feature->flags = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_ZPCI_ERROR;
> +
> +    buf = g_malloc(ccdf_err_length);
> +    err = (void *)feature->data;
> +    err->data = (uint64_t)buf;
> +    ret = vfio_device_get_feature(&vfio_pci->vbasedev, feature);
> +
> +    if (ret) {
> +        if (ret != -ENOMSG) {
> +            error_setg(errp, "Failed feature get VFIO_DEVICE_FEATURE_ZPCI_ERROR"
> +                              " (rc=%d)", ret);
> +        }
> +        return ret;
> +    }
> +
> +    memcpy(ccdf, (PciCcdfErr *) err->data, ccdf_err_length);
> +
> +    return 0;
> +}
> +
> +static bool s390_pci_err_handler(VFIOPCIDevice *vfio_pci, Error **errp)
> +{
> +    S390PCIBusDevice *pbdev;
> +    PciCcdfErr ccdf;
> +    bool success = false;

This means errp should be set. It is not obvious from the code below.

> +    int ret = 0;
> +
> +    pbdev = s390_pci_find_dev_by_target(s390_get_phb(),
> +                                        DEVICE(&vfio_pci->parent_obj)->id);

can pbdev be NULL ?

   if (!pbdev) {
       error_setg(errp, "No matching zpci device found");
       return false;
   }
> +
> +    QEMU_LOCK_GUARD(&pbdev->err_handler_lock);
> +    pbdev->state = ZPCI_FS_ERROR;
> +
> +    if (sizeof(ccdf) != pbdev->ccdf_err_length) {
> +        error_setg(errp,
> +                   "CCDF size mismatch expected size=%zu, provided size=%d",
> +                   sizeof(ccdf), pbdev->ccdf_err_length);
> +        return false;
> +    }
> +
> +    while (ret == 0) {
> +        ret = s390_pci_get_feature_err(vfio_pci, &ccdf,
> +                                       pbdev->ccdf_err_length, errp);
> +        if (ret) {
> +            success = ret == -ENOMSG ? true : false;
> +            break;
> +        }
> +        s390_pci_generate_error_event(ccdf.pec, pbdev->fh, pbdev->fid, 0, 0);

why not use ccdf.e and ccdf.faddr for more diagnostic details ?


> +    }
> +
> +    return success;
> +}
> +
>   static void s390_pci_read_base(S390PCIBusDevice *pbdev,
>                                  struct vfio_device_info *info)
>   {
> @@ -134,6 +201,10 @@ static void s390_pci_read_base(S390PCIBusDevice *pbdev,
>       /* Store function type separately for type-specific behavior */
>       pbdev->pft = cap->pft;
>   
> +    if (hdr->version >= 3) {
> +        pbdev->ccdf_err_length = cap->ccdf_err_length;
> +    }
> +
>       /*
>        * If the device is a passthrough ISM device, disallow relaxed
>        * translation.
> @@ -371,3 +442,32 @@ void s390_pci_get_clp_info(S390PCIBusDevice *pbdev)
>       s390_pci_read_util(pbdev, info);
>       s390_pci_read_pfip(pbdev, info);
>   }
> +
> +bool s390_pci_setup_err_handler(S390PCIBusDevice *pbdev, Error **errp)
> +{
> +    int ret;
> +    VFIOPCIDevice *vfio_pci = VFIO_PCI_DEVICE(pbdev->pdev);
> +    uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
> +                              sizeof(uint64_t))] = {};
> +    struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
> +
> +    feature->argsz = sizeof(buf);
> +    feature->flags = VFIO_DEVICE_FEATURE_PROBE | VFIO_DEVICE_FEATURE_ZPCI_ERROR;
> +
> +    ret = vfio_device_get_feature(&vfio_pci->vbasedev, feature);
> +
> +    if (ret != 0) {
> +        if (ret == -ENOTTY) {
> +            error_setg(errp, "Automated error recovery unavailable for device");
> +        } else {
> +            error_setg(errp,
> +                       "Failed to probe for VFIO_DEVICE_FEATURE_ZPCI_ERROR (ret=%d)",
> +                       ret);
> +        }
> +        return false;
> +    }
> +
> +    vfio_pci->err_handler = s390_pci_err_handler;
> +
> +    return true;
> +}
> diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
> index 9228523ce8..bc67f7e065 100644
> --- a/include/hw/s390x/s390-pci-bus.h
> +++ b/include/hw/s390x/s390-pci-bus.h
> @@ -364,6 +364,8 @@ struct S390PCIBusDevice {
>       bool forwarding_assist;
>       bool aif;
>       bool rtr_avail;
> +    QemuMutex err_handler_lock;
> +    uint32_t ccdf_err_length;
>       QTAILQ_ENTRY(S390PCIBusDevice) link;
>   };
>   
> diff --git a/include/hw/s390x/s390-pci-vfio.h b/include/hw/s390x/s390-pci-vfio.h
> index f7d6149daf..c7886b63ea 100644
> --- a/include/hw/s390x/s390-pci-vfio.h
> +++ b/include/hw/s390x/s390-pci-vfio.h
> @@ -20,5 +20,6 @@ S390PCIDMACount *s390_pci_start_dma_count(S390pciState *s,
>   void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt);
>   bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh);
>   void s390_pci_get_clp_info(S390PCIBusDevice *pbdev);
> +bool s390_pci_setup_err_handler(S390PCIBusDevice *pbdev, Error **errp);
>   
>   #endif


