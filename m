Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1983C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6kmR-0000d2-AO; Wed, 16 Sep 2026 04:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x6kmL-0000cM-RT
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:14:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x6kmJ-0008Bg-Od
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789546441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zSO1VhWorS44frnPJYIb4waOB4tSEzerdbSOM9t8o5Q=;
 b=VDfosT3GhKqqRU6dsNyiSvCXM26YR8dA+qOBJFZBa8uRC6LdU1jGd5wChA1Tcrpkqd9TiD
 GGyXFSKsH4VU/tT768ivwQA+sMqkTuo+ekMVrTIf9AzyznfeDfiQPKAXKP8Sr2jf+XhHfI
 MnMLC7jDXQ2uiISzTyUYKKdTPmcyO2o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-rPdao5nEMtiuo61nOuVKiw-1; Wed, 16 Sep 2026 04:14:00 -0400
X-MC-Unique: rPdao5nEMtiuo61nOuVKiw-1
X-Mimecast-MFC-AGG-ID: rPdao5nEMtiuo61nOuVKiw_1789546439
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c2580a59d0dso534624466b.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 01:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789546439; x=1790151239; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zSO1VhWorS44frnPJYIb4waOB4tSEzerdbSOM9t8o5Q=;
 b=JvWAl5ziY+7q634mv8pbRDAD3hDJv1/IFDnjuZix6wuZIOlQrUpEbrygYB+y2WvSKM
 kSg+58vPDT+ISRhG7FpBLD9Uj2bupjygvVemckyLapqw9A7+F40GnQly8YfepOEGmhuT
 /37oen/zzZYxd7yz68Pj1DrRjtgLJi3r2iCxHZ5khbi8altghJbTO9QzJWASUijujxBK
 7aTeX9Qah77EZTyhTwgW3OCbd05q7CJadqHCtO3yqvQpxdpdLAtkwGi1D5N7ABDra8nE
 4MHdOp7v1565SV3RXs+JRqa6ApsNO00VjEBrpedGYVi567W5an/nwHc0QXyAhfGlOZ6X
 MMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789546439; x=1790151239;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zSO1VhWorS44frnPJYIb4waOB4tSEzerdbSOM9t8o5Q=;
 b=2rg0rhfoYl/lB1pNQevcu3qZt5WgxUx0K4x8va7dCUlPBqyX9VrXFMgmB3hvIFnB2D
 QDiprAe5Mi8lqIpOf1Inm/K/Nx/u+Ynd/a+dAWIusSJqeNz4cfhrD5Wa37pxA4i/O43w
 uCA3jpsmEI+h2izBMxzQ1iRi0wFU9uhV5AH0s/9In3xUbtAwcXw5kbohNY9acOlwG6EB
 EoVRvHhvm0bfm/iefy2xUGw+DTF+hw9JwjB/MRDSWpRtW9nDbF+eb/N6lbLEKLes9qUv
 YM2OC9n0N3m+9/uCk8pYwiBzvEqx87aOI2x3oJITcqYwvGFUOvM9qOxZmkMbg7Upb5Gi
 BaUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzrccaTJg3Gwyc3qCO+/p6MXGb7ik+tEVYdj80v6fX06DVVeKTwqxJc6jREzNgXRs9RK++zbFQdgmHv@nongnu.org
X-Gm-Message-State: AFuF++m7nptIln2c3F6pUL/Is8C+INEC27rxgclgGI1hizFxmAPrzDiQ
 ZB8aDJmEIAZVTCA49u+KhH4Ei0SxXSnvZ6Fs4/Ff/kHX7tJCPR8U7FVTXF6DBwgE+0IvalnjSQy
 EuShkmqcaj8PVoQT0YeBFTFRsiT9KM1ePLiWQoixMjJAf8lo9pyYiBTn/
X-Gm-Gg: AYBFou1+y/Iuwk0VJUUE3NTUaeYrC9SJGqLMk40AzyUehS8yRN0ZVS2JmquQcJxWVKr
 AXYAKW5TYYVh4XwxsP4r39iQPU5uJy0cdC37LOekK/jVx9Nz3odpdde4ycD0JoILwm0heaDYTtj
 Qud6zXuYyQS7f+yloacjJyTKzLI6F/2/2UAd1/cljz/U76ozlJO/V1QfxZJdtaD5LDhohLBXPFP
 v7k8gBhE8TP0PD84lGzglvR87TsGTgnjGqS78ZwOS25hNQx0zxf4MihGo7NkDDBUAozCH/pNlka
 6J2yApmvyVCoI5uHcmxrCJHZQAJEksPLEGqnA9xYa+jlJnCtQEn20DOcxPGtxX+Bj1G7//sqhO/
 /WWQK9Xocq6fVYcG3s4ynSNxly+CE4LqWwiM3PiKaIA==
X-Received: by 2002:a17:907:80a:b0:c29:349e:7c1d with SMTP id
 a640c23a62f3a-c29e5444aebmr99182466b.49.1789546438778; 
 Wed, 16 Sep 2026 01:13:58 -0700 (PDT)
X-Received: by 2002:a17:907:80a:b0:c29:349e:7c1d with SMTP id
 a640c23a62f3a-c29e5444aebmr99180066b.49.1789546438177; 
 Wed, 16 Sep 2026 01:13:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:e939:7a09:c368:e5d5?
 ([2a01:e0a:1292:d530:e939:7a09:c368:e5d5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29de5b6712sm84651766b.39.2026.09.16.01.13.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 01:13:57 -0700 (PDT)
Message-ID: <b71cc588-f0f9-4c1e-9207-5ddd103a002e@redhat.com>
Date: Wed, 16 Sep 2026 10:13:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] s390x/pci: Add PCI error handling for vfio pci
 devices
To: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com,
 alex@shazbot.org, armbru@redhat.com
References: <20260914174420.12309-1-alifm@linux.ibm.com>
 <20260914174420.12309-3-alifm@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260914174420.12309-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/14/26 19:44, Farhan Ali wrote:
> Add an s390x specific handler for vfio error notifier. For s390x pci devices,
> we have platform specific error information. We need to retrieve this error
> information for passthrough devices. This is done via a VFIO_DEVICE_FEATURE
> ioctl which exposes that information.
> 
> Once this error information is retrieved we can then inject an error into
> the guest, and let the guest drive the recovery.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-bus.c          |   6 ++
>   hw/s390x/s390-pci-vfio-stubs.c   |   6 ++
>   hw/s390x/s390-pci-vfio.c         | 115 +++++++++++++++++++++++++++++++
>   include/hw/s390x/s390-pci-bus.h  |   1 +
>   include/hw/s390x/s390-pci-vfio.h |   1 +
>   5 files changed, 129 insertions(+)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 2eb4e8cec4..b2967dacba 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -1085,6 +1085,7 @@ static void s390_pcihost_plug(const HotplugHandler *hotplug_dev, DeviceState *de
>       S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
>       PCIDevice *pdev = NULL;
>       S390PCIBusDevice *pbdev = NULL;
> +    Error *local_err = NULL;
>       int rc;
>   
>       if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
> @@ -1175,6 +1176,11 @@ static void s390_pcihost_plug(const HotplugHandler *hotplug_dev, DeviceState *de
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
> index db6de00bd2..6c072005fd 100644
> --- a/hw/s390x/s390-pci-vfio.c
> +++ b/hw/s390x/s390-pci-vfio.c
> @@ -10,6 +10,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   
>   #include <sys/ioctl.h>
>   #include <linux/vfio.h>
> @@ -105,6 +106,85 @@ void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt)
>       }
>   }
>   
> +static bool s390_pci_get_feature_err(VFIOPCIDevice *vfio_pci,
> +                                    PciCcdfErr *ccdf,
> +                                    uint32_t ccdf_err_length,
> +                                    Error **errp)
> +{
> +    int ret;
> +    size_t total_size;
> +    struct vfio_device_feature_zpci_err *err;
> +    g_autofree void *buf = NULL;

could be  buf = g_malloc(ccdf_err_length);


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
> +        return false;

returning false without setting errp :/

> +    }
> +
> +    memcpy(ccdf, (PciCcdfErr *) err->data, ccdf_err_length);
> +
> +    return true;
> +}
> +
> +static void s390_pci_err_handler(void *opaque)
> +{
> +    VFIOPCIDevice *vfio_pci;
> +    S390PCIBusDevice *pbdev;
> +    Error *errp = NULL;

a 'local_err' name would be preferred.
> +    PciCcdfErr ccdf;
> +    bool ret = true;
> +
> +    vfio_pci = opaque;
> +    if (!event_notifier_test_and_clear(&vfio_pci->err_notifier)) {

This means that the vfio_pci->err_notifier eventfd was initialized.
IOW, pci_aer is true.

Is that the case for Z ? If not, this needs its own eventfd setup.

> +        return;
> +    }
> +
> +    pbdev = s390_pci_find_dev_by_target(s390_get_phb(),
> +                                        DEVICE(&vfio_pci->parent_obj)->id);
> +
> +    if (!pbdev) {
> +        error_report("No matching zpci device found");
> +        return;
> +    }
> +    pbdev->state = ZPCI_FS_ERROR;
> +
> +    if (sizeof(ccdf) != pbdev->ccdf_err_length) {
> +        error_report(
> +                   "CCDF size mismatch expected size=%zu, provided size=%d",
> +                   sizeof(ccdf), pbdev->ccdf_err_length);
> +        return;
> +    }
> +
> +    while (ret) {
> +        ret = s390_pci_get_feature_err(vfio_pci, &ccdf,
> +                                       pbdev->ccdf_err_length, &errp);
> +        if (!ret) {
> +            if (errp) {
> +                error_report_err(errp);
> +            }
> +            break;

The 'local_err' not being set with a 'false' returned value is not
following the qapi/error.h guidelines. This is unexpected.
It is also wrong. ERRP_GUARD() is needed. please read qapi/error.h.



> +        }
> +        s390_pci_generate_error_event(ccdf.pec, pbdev->fh, pbdev->fid,
> +                                      ccdf.faddr, ccdf.e);
> +    }
> +
> +    return;
> +}
> +
>   static void s390_pci_read_base(S390PCIBusDevice *pbdev,
>                                  struct vfio_device_info *info)
>   {
> @@ -134,6 +214,10 @@ static void s390_pci_read_base(S390PCIBusDevice *pbdev,
>       /* Store function type separately for type-specific behavior */
>       pbdev->pft = cap->pft;
>   
> +    if (hdr->version >= 3) {
> +        pbdev->ccdf_err_length = cap->ccdf_err_length;

So ccdf_err_length can be 0. Is that expected ?

> +    }
> +
>       /*
>        * If the device is a passthrough ISM device, disallow relaxed
>        * translation.
> @@ -371,3 +455,34 @@ void s390_pci_get_clp_info(S390PCIBusDevice *pbdev)
>       s390_pci_read_util(pbdev, info);
>       s390_pci_read_pfip(pbdev, info);
>   }
> +
> +bool s390_pci_setup_err_handler(S390PCIBusDevice *pbdev, Error **errp)
> +{
> +    int ret;
> +    int32_t fd;
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
> +    fd = event_notifier_get_fd(&vfio_pci->err_notifier);
> +    qemu_set_fd_handler(fd, s390_pci_err_handler, NULL, vfio_pci);

Shouldn't we check ccdf_err_length before installing the handler ? because
it won't run cleanly anyhow.

Thanks,

C.


> +
> +    return true;
> +}
> diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
> index 9228523ce8..c2348ede86 100644
> --- a/include/hw/s390x/s390-pci-bus.h
> +++ b/include/hw/s390x/s390-pci-bus.h
> @@ -364,6 +364,7 @@ struct S390PCIBusDevice {
>       bool forwarding_assist;
>       bool aif;
>       bool rtr_avail;
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


