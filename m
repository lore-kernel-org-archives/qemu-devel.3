Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F05C3601A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 15:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Mlj-0007yZ-Ge; Thu, 03 Apr 2025 11:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u0Mlh-0007y7-Su
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:46:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u0Mlf-00079Y-Pn
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743695168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lKTt1wdmmK2D+NO/6PQw1kzzmDLff4PFxsZjm5tyY80=;
 b=E6axfsLqBk1VnYJf3+Em9wZWWE+S+F/w+E/hzr8iNCZywKU2zqC8CF0Qaz2ZnFDOdfJwE1
 nigYGHrSXiv6wCUu6XnQIRri6ldNuTX4ndJk0FF4Of5W8Q4PZN9Vrsv7ByW9kb/TWdFQJK
 9sF7u6kV4dB80nsM/CqOGUz34MMYiOs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-ZqMSy4I6OJqQdKo_Kg2cMw-1; Thu, 03 Apr 2025 11:46:07 -0400
X-MC-Unique: ZqMSy4I6OJqQdKo_Kg2cMw-1
X-Mimecast-MFC-AGG-ID: ZqMSy4I6OJqQdKo_Kg2cMw_1743695166
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ac737973c9bso86728766b.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 08:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743695166; x=1744299966;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lKTt1wdmmK2D+NO/6PQw1kzzmDLff4PFxsZjm5tyY80=;
 b=C518j9Fa0YApKwNsmF+LzT3pHDaIFAwFVX3gGZT1OfKwDkEFLFQEEEOKDKjizL4jYW
 WA12pwykWaBAD+Ylq25e3pJiQsLzyTx8o0Ux4JB1K1ivLbJvHkV6dyjsMSohSlxj0ICv
 avWr1aeSgwyFalaNGPIbmgKcbOcby+qdv9LawUSwXJjAuthHg1s6GRXlv8hysOTV/ZQX
 +f+P9otv6JDQiNoMtqa9mILuCd8Caxfu7voDpoDNryB4BIYXI0+rUicfORWJPJ4kks6l
 4XB/LMRemEORsQIs+KBLcwJBcSCU8pQaYD/OG5YeploS6dBNdwacFCf5DYYNqr1ZokT8
 7ndg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ+p+dn6k2qQFRj2heBNGLH/kV0Keiws2A1f0WjtVBsysP6D7Fba+h4NFhFULaRdv7EOIukB19ZRi3@nongnu.org
X-Gm-Message-State: AOJu0YyULVCFAgOgaiBkQIgDUPRMl+uJXfwTxr2LVS/ZIHRWSHagSpPg
 Y2YpZRJkTXWM7i6/7/7vxaIncU3iB3phxwtMshNLyjmoqnxnOnPQ3iRa5ys2d4w+um/RCmtxTBM
 BqTzFKwm+ecCRv7MQbfYQx1V5Aqkc/SwMsEpNsaFsXcLmOdJ2RSJI
X-Gm-Gg: ASbGncvml2pXmzLrGc3G+sFff3GNT5U9dyn1OeIerAbQr7KwTaGdDgRWN8KSMB/3kTi
 HrqafE9uWYUylTRLwXHGeIDU8V5sJSxlbOVqJBDPifOhTXLOa63VBCDoK8ucP52xu7fuQJgFs9k
 3hI1WTUz64qVErqF/sWiyIPv7qUwoBzuC9G2eEq7moDrjaxDMerrmO8eRN5AgeVKLFP9c4pCWLH
 GgwFSIypAaZasYZrpmgJFODaIOVGdbOu2JkpTQKbUgS2AY1rcWBfyK+AEtZYFy6VXvoE/c8nTz9
 g56Cw+ljeFhMyMXfsfM9qcZ7VYqa60AdwmU1YGvEG3xQhnGxWTMX6A==
X-Received: by 2002:a17:907:7e88:b0:ac7:738c:996f with SMTP id
 a640c23a62f3a-ac7d1755403mr8555966b.15.1743695165693; 
 Thu, 03 Apr 2025 08:46:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtIgEDH3VWKMMilxnaUsF4zYh0Y5Kre8MabhOymNFUXtGPijluzSevL9MmXXwNOCS8mEiXyw==
X-Received: by 2002:a17:907:7e88:b0:ac7:738c:996f with SMTP id
 a640c23a62f3a-ac7d1755403mr8551466b.15.1743695165206; 
 Thu, 03 Apr 2025 08:46:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7c013fd8asm110935166b.111.2025.04.03.08.46.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 08:46:04 -0700 (PDT)
Message-ID: <d0f99d52-4d8d-4b1e-9e83-ec39b5357a44@redhat.com>
Date: Thu, 3 Apr 2025 17:46:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/28] vfio: add region cache
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Jason Herne <jjherne@linux.ibm.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
References: <20250219144858.266455-1-john.levon@nutanix.com>
 <20250219144858.266455-9-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250219144858.266455-9-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/19/25 15:48, John Levon wrote:
> From: Jagannathan Raman <jag.raman@oracle.com>
> 
> Instead of requesting region information on demand with
> VFIO_DEVICE_GET_REGION_INFO, maintain a cache: this will become
> necessary for performance for vfio-user, where this call becomes a
> message over the control socket, so is of higher overhead than the
> traditional path.
> 
> Originally-by: John Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio/ccw.c                 |  5 -----
>   hw/vfio/common.c              | 12 ++++++++++++
>   hw/vfio/container.c           | 10 ++++++++++
>   hw/vfio/helpers.c             | 21 ++++++++++++++++-----
>   hw/vfio/igd.c                 |  8 ++++----
>   hw/vfio/pci.c                 |  8 ++++----
>   include/hw/vfio/vfio-common.h |  1 +
>   7 files changed, 47 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 67bc137f9b..22378d50bc 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -510,7 +510,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
>   
>       vcdev->io_region_offset = info->offset;
>       vcdev->io_region = g_malloc0(info->size);
> -    g_free(info);
>   
>       /* check for the optional async command region */
>       ret = vfio_get_dev_region_info(vdev, VFIO_REGION_TYPE_CCW,
> @@ -523,7 +522,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
>           }
>           vcdev->async_cmd_region_offset = info->offset;
>           vcdev->async_cmd_region = g_malloc0(info->size);
> -        g_free(info);
>       }
>   
>       ret = vfio_get_dev_region_info(vdev, VFIO_REGION_TYPE_CCW,
> @@ -536,7 +534,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
>           }
>           vcdev->schib_region_offset = info->offset;
>           vcdev->schib_region = g_malloc(info->size);
> -        g_free(info);
>       }
>   
>       ret = vfio_get_dev_region_info(vdev, VFIO_REGION_TYPE_CCW,
> @@ -550,7 +547,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
>           }
>           vcdev->crw_region_offset = info->offset;
>           vcdev->crw_region = g_malloc(info->size);
> -        g_free(info);
>       }
>   
>       return true;
> @@ -560,7 +556,6 @@ out_err:
>       g_free(vcdev->schib_region);
>       g_free(vcdev->async_cmd_region);
>       g_free(vcdev->io_region);
> -    g_free(info);
>       return false;
>   }
>   
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 4434e0a0a2..1866b3d3c5 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1569,6 +1569,16 @@ retry:
>       return info;
>   }
>   
> +static void vfio_get_all_regions(VFIODevice *vbasedev)
> +{
> +    struct vfio_region_info *info;
> +    int i;
> +
> +    for (i = 0; i < vbasedev->num_regions; i++) {
> +        vfio_get_region_info(vbasedev, i, &info);
> +    }
> +}
> +
>   void vfio_prepare_device(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
>                            VFIOGroup *group, struct vfio_device_info *info)
>   {
> @@ -1586,6 +1596,8 @@ void vfio_prepare_device(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
>       }
>   
>       QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
> +
> +    vfio_get_all_regions(vbasedev);
>   }
>   
>   bool vfio_attach_device_by_iommu_type(const char *iommu_type, char *name,
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 37a3befbc5..36cd245c92 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -886,6 +886,16 @@ static bool vfio_get_device(VFIOGroup *group, const char *name,
>   
>   static void vfio_put_base_device(VFIODevice *vbasedev)
>   {
> +    if (vbasedev->regions != NULL) {
> +        int i;
> +
> +        for (i = 0; i < vbasedev->num_regions; i++) {
> +            g_free(vbasedev->regions[i]);
> +        }
> +        g_free(vbasedev->regions);
> +        vbasedev->regions = NULL;
> +    }
> +
>       if (!vbasedev->group) {
>           return;
>       }
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index 4b255d4f3a..3c923d23b9 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -345,7 +345,7 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
>   int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
>                         int index, const char *name)
>   {
> -    g_autofree struct vfio_region_info *info = NULL;
> +    struct vfio_region_info *info = NULL;
>       int ret;
>   
>       ret = vfio_get_region_info(vbasedev, index, &info);
> @@ -562,6 +562,17 @@ int vfio_get_region_info(VFIODevice *vbasedev, int index,
>   {
>       size_t argsz = sizeof(struct vfio_region_info);
>   
> +    /* create region cache */
> +    if (vbasedev->regions == NULL) {
> +        vbasedev->regions = g_new0(struct vfio_region_info *,
> +                                   vbasedev->num_regions);
> +    }
> +    /* check cache */
> +    if (vbasedev->regions[index] != NULL) {
> +        *info = vbasedev->regions[index];
> +        return 0;
> +    }
> +

why not populate vbasedev->regions[index] in vfio_get_all_regions() ?


Thanks,

C.



>       *info = g_malloc0(argsz);
>   
>       (*info)->index = index;
> @@ -581,6 +592,9 @@ retry:
>           goto retry;
>       }
>   
> +    /* fill cache */
> +    vbasedev->regions[index] = *info;
> +
>       return 0;
>   }
>   
> @@ -599,7 +613,6 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
>   
>           hdr = vfio_get_region_info_cap(*info, VFIO_REGION_INFO_CAP_TYPE);
>           if (!hdr) {
> -            g_free(*info);
>               continue;
>           }
>   
> @@ -611,8 +624,6 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
>           if (cap_type->type == type && cap_type->subtype == subtype) {
>               return 0;
>           }
> -
> -        g_free(*info);
>       }
>   
>       *info = NULL;
> @@ -621,7 +632,7 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
>   
>   bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
>   {
> -    g_autofree struct vfio_region_info *info = NULL;
> +    struct vfio_region_info *info = NULL;
>       bool ret = false;
>   
>       if (!vfio_get_region_info(vbasedev, region, &info)) {
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index b1a237edd6..b5425ba9c0 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -490,10 +490,10 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>   
>   void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>   {
> -    g_autofree struct vfio_region_info *rom = NULL;
> -    g_autofree struct vfio_region_info *opregion = NULL;
> -    g_autofree struct vfio_region_info *host = NULL;
> -    g_autofree struct vfio_region_info *lpc = NULL;
> +    struct vfio_region_info *rom = NULL;
> +    struct vfio_region_info *opregion = NULL;
> +    struct vfio_region_info *host = NULL;
> +    struct vfio_region_info *lpc = NULL;
>       VFIOQuirk *quirk;
>       VFIOIGDQuirk *igd;
>       PCIDevice *lpc_bridge;
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 83fe329474..a4f99fc5e0 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -879,7 +879,7 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
>   
>   static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>   {
> -    g_autofree struct vfio_region_info *reg_info = NULL;
> +    struct vfio_region_info *reg_info = NULL;
>       uint64_t size;
>       off_t off = 0;
>       ssize_t bytes;
> @@ -2665,7 +2665,7 @@ static VFIODeviceOps vfio_pci_ops = {
>   bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
>   {
>       VFIODevice *vbasedev = &vdev->vbasedev;
> -    g_autofree struct vfio_region_info *reg_info = NULL;
> +    struct vfio_region_info *reg_info = NULL;
>       int ret;
>   
>       ret = vfio_get_region_info(vbasedev, VFIO_PCI_VGA_REGION_INDEX, &reg_info);
> @@ -2730,7 +2730,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
>   static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>   {
>       VFIODevice *vbasedev = &vdev->vbasedev;
> -    g_autofree struct vfio_region_info *reg_info = NULL;
> +    struct vfio_region_info *reg_info = NULL;
>       struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info) };
>       int i, ret = -1;
>   
> @@ -3177,7 +3177,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>   
>       if (!vdev->igd_opregion &&
>           vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) {
> -        g_autofree struct vfio_region_info *opregion = NULL;
> +        struct vfio_region_info *opregion = NULL;
>   
>           if (vdev->pdev.qdev.hotplugged) {
>               error_setg(errp,
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index ae3ecbd9f6..304030e71d 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -151,6 +151,7 @@ typedef struct VFIODevice {
>       IOMMUFDBackend *iommufd;
>       VFIOIOASHwpt *hwpt;
>       QLIST_ENTRY(VFIODevice) hwpt_next;
> +    struct vfio_region_info **regions;
>   } VFIODevice;
>   
>   struct VFIODeviceOps {


