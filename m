Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BC9CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 15:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1RAP-0002v4-RV; Wed, 24 Sep 2025 11:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1RAJ-0002uG-V0
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 11:12:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1RAF-0003LQ-5P
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 11:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758726730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QWT1ix0nxWM0RGon3PL4N4QoULiiPzCrkIZc6eATVkg=;
 b=fOrg+IhtPwxsE0Fa5jKJr5ISbn/oIEgAOgWp2FEfo94Fci926JDRAETXQfzlUP10+UmlKs
 gvhQYg1jSebrO6q3sGi6frOKvCnkJ5H74v94xU0AAivLwt02zCryFZoN9gNCkSpur1SF7G
 XOaHyJEJ+jpOLJ3xJMJfKr/oaf69gJ0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-kYCw_pvjNg28OMWlI7Ts8g-1; Wed, 24 Sep 2025 11:12:08 -0400
X-MC-Unique: kYCw_pvjNg28OMWlI7Ts8g-1
X-Mimecast-MFC-AGG-ID: kYCw_pvjNg28OMWlI7Ts8g_1758726727
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3ece14b9231so1649f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 08:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758726727; x=1759331527;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QWT1ix0nxWM0RGon3PL4N4QoULiiPzCrkIZc6eATVkg=;
 b=Zczx1guiDKsyzqTCZlIuIF8D6Pe+OJKeCwCIGP8sEgGxEKuVxeohIfnchdjE3V8s1V
 YXRNHgxIhsq9K6s5ZJ8yAHhS3ot0joaFlQassWd/RSukrFXojyC/WRWrJRE6Hm12pDvh
 U+5V7tcv7WkGdy+3M+2Zih/xLnVNLA827S8AaDxoLwym3NWEumIe8cpQGtA4dStI5g7v
 +rqnVDWx7UliuLnNGnLySaGscsa4pmpjNCllQ6DpKmYHayxVPUrVI2bMetg0/PywJykv
 O8PZSlTeWhMIg8Hh+QsbgtOomnNiKqSBjN3hzRneZ7tD4x0xB5lzwfc8FceU/rlaL4EB
 aRxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/WTxhK4/7knNEdKWXfNW2o8UHJ3+zLjmkjQyX5RfYz6JayVrOj703cKr9jLFya1Y9dWr0xApSddfw@nongnu.org
X-Gm-Message-State: AOJu0YxCrwfNdmZC6qXyttxdy1JLgBnnV2x5AEAV1TmiCVV5A6450L8f
 Dj05MzW3TcJI5zclXJivgPBZU/+F3++Z9Dz0VoRxMhiiYqFObl8O5ITOxUgQaqjpzjNesM/Bw6G
 0fSFECb1+i1jWgNFb4iorpfsfea7HshMNynCi1OWl/Ppxlv0VGHf7jqt0
X-Gm-Gg: ASbGnctFzD5WFLplzRU0FOlTCt9UW49Rj7863BdEd9aRkQWK4HcL/QIeNypPWSph+0W
 PIzD0pmUwlIQklixJ9jsQgHRSnVSR6nkMxAnIWDzfwULaxw9ufCJ1N4rB2XSuV2kJFQdz8cygR8
 4r3B0Hz4esQFDXkk2mDjbw931W2WuDOuHRoW7MhCUYgs2eat7fnocko4tLhFLgiziIfQK13gLX/
 balxQQfysM9PQYVnA9OYYo7tly3VxCmmb8b/2KKNan3IS40KGTo2nfeELKtiZYSI9tA49nABnYD
 7Hpi8nBNKFs7QQTJj4Ev96QxsdGXD05ZyPYCki5xnfgpl6DNQvbSWlhOv1hVi53aklF9GozxAJn
 QOw0=
X-Received: by 2002:a05:6000:40c8:b0:406:87ba:99a2 with SMTP id
 ffacd0b85a97d-40e4ece5882mr263953f8f.38.1758726726976; 
 Wed, 24 Sep 2025 08:12:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4FxQe/TSBIwu9zpf7CCLYYTRNfWflzgIAIpqtDWHdEJnzN0hCKwteU8whg3xTuoJ8YxwrFQ==
X-Received: by 2002:a05:6000:40c8:b0:406:87ba:99a2 with SMTP id
 ffacd0b85a97d-40e4ece5882mr263914f8f.38.1758726726481; 
 Wed, 24 Sep 2025 08:12:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2a998321sm34648405e9.1.2025.09.24.08.12.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 08:12:06 -0700 (PDT)
Message-ID: <a7667b85-2e00-4eb4-9dc5-f91141eaa806@redhat.com>
Date: Wed, 24 Sep 2025 17:12:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/27] hw/vfio/types.h: rename TYPE_VFIO_PCI_BASE to
 TYPE_VFIO_PCI_DEVICE
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 harshpb@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
 <20250923135352.1157250-17-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250923135352.1157250-17-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 9/23/25 15:53, Mark Cave-Ayland wrote:
> This brings the QOM type name in line with the underlying VFIOPCIDevice structure.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/s390x/s390-pci-vfio.c | 14 +++++++-------
>   hw/vfio-user/pci.c       | 13 +++++++------
>   hw/vfio/device.c         |  2 +-
>   hw/vfio/pci.c            | 28 ++++++++++++++--------------
>   hw/vfio/pci.h            |  2 +-
>   hw/vfio/types.h          |  4 ++--
>   6 files changed, 32 insertions(+), 31 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
> index 7760780aff..9e31029d7a 100644
> --- a/hw/s390x/s390-pci-vfio.c
> +++ b/hw/s390x/s390-pci-vfio.c
> @@ -62,7 +62,7 @@ S390PCIDMACount *s390_pci_start_dma_count(S390pciState *s,
>   {
>       S390PCIDMACount *cnt;
>       uint32_t avail;
> -    VFIOPCIDevice *vpdev = VFIO_PCI_BASE(pbdev->pdev);
> +    VFIOPCIDevice *vpdev = VFIO_PCI_DEVICE(pbdev->pdev);
>       int id;
>   
>       assert(vpdev);
> @@ -108,7 +108,7 @@ static void s390_pci_read_base(S390PCIBusDevice *pbdev,
>   {
>       struct vfio_info_cap_header *hdr;
>       struct vfio_device_info_cap_zpci_base *cap;
> -    VFIOPCIDevice *vpci = VFIO_PCI_BASE(pbdev->pdev);
> +    VFIOPCIDevice *vpci = VFIO_PCI_DEVICE(pbdev->pdev);
>       uint64_t vfio_size;
>   
>       hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_BASE);
> @@ -162,7 +162,7 @@ static bool get_host_fh(S390PCIBusDevice *pbdev, struct vfio_device_info *info,
>   {
>       struct vfio_info_cap_header *hdr;
>       struct vfio_device_info_cap_zpci_base *cap;
> -    VFIOPCIDevice *vpci = VFIO_PCI_BASE(pbdev->pdev);
> +    VFIOPCIDevice *vpci = VFIO_PCI_DEVICE(pbdev->pdev);
>   
>       hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_BASE);
>   
> @@ -185,7 +185,7 @@ static void s390_pci_read_group(S390PCIBusDevice *pbdev,
>       struct vfio_device_info_cap_zpci_group *cap;
>       S390pciState *s = s390_get_phb();
>       ClpRspQueryPciGrp *resgrp;
> -    VFIOPCIDevice *vpci = VFIO_PCI_BASE(pbdev->pdev);
> +    VFIOPCIDevice *vpci = VFIO_PCI_DEVICE(pbdev->pdev);
>       uint8_t start_gid = pbdev->zpci_fn.pfgid;
>   
>       hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_GROUP);
> @@ -264,7 +264,7 @@ static void s390_pci_read_util(S390PCIBusDevice *pbdev,
>   {
>       struct vfio_info_cap_header *hdr;
>       struct vfio_device_info_cap_zpci_util *cap;
> -    VFIOPCIDevice *vpci = VFIO_PCI_BASE(pbdev->pdev);
> +    VFIOPCIDevice *vpci = VFIO_PCI_DEVICE(pbdev->pdev);
>   
>       hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_UTIL);
>   
> @@ -291,7 +291,7 @@ static void s390_pci_read_pfip(S390PCIBusDevice *pbdev,
>   {
>       struct vfio_info_cap_header *hdr;
>       struct vfio_device_info_cap_zpci_pfip *cap;
> -    VFIOPCIDevice *vpci = VFIO_PCI_BASE(pbdev->pdev);
> +    VFIOPCIDevice *vpci = VFIO_PCI_DEVICE(pbdev->pdev);
>   
>       hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_PFIP);
>   
> @@ -314,7 +314,7 @@ static void s390_pci_read_pfip(S390PCIBusDevice *pbdev,
>   
>   static struct vfio_device_info *get_device_info(S390PCIBusDevice *pbdev)
>   {
> -    VFIOPCIDevice *vfio_pci = VFIO_PCI_BASE(pbdev->pdev);
> +    VFIOPCIDevice *vfio_pci = VFIO_PCI_DEVICE(pbdev->pdev);
>   
>       return vfio_get_device_info(vfio_pci->vbasedev.fd);
>   }
> diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
> index e2c309784f..efceae69de 100644
> --- a/hw/vfio-user/pci.c
> +++ b/hw/vfio-user/pci.c
> @@ -234,9 +234,10 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
>   {
>       ERRP_GUARD();
>       VFIOUserPCIDevice *udev = VFIO_USER_PCI(pdev);
> -    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
>       VFIODevice *vbasedev = &vdev->vbasedev;
>       const char *sock_name;
> +
>       AddressSpace *as;
>       SocketAddress addr;
>       VFIOUserProxy *proxy;
> @@ -346,7 +347,7 @@ error:
>   static void vfio_user_instance_init(Object *obj)
>   {
>       PCIDevice *pci_dev = PCI_DEVICE(obj);
> -    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
> +    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(obj);
>       VFIODevice *vbasedev = &vdev->vbasedev;
>   
>       device_add_bootindex_property(obj, &vdev->bootindex,
> @@ -371,7 +372,7 @@ static void vfio_user_instance_init(Object *obj)
>   
>   static void vfio_user_instance_finalize(Object *obj)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
> +    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(obj);
>       VFIODevice *vbasedev = &vdev->vbasedev;
>   
>       if (vdev->msix != NULL) {
> @@ -387,7 +388,7 @@ static void vfio_user_instance_finalize(Object *obj)
>   
>   static void vfio_user_pci_reset(DeviceState *dev)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI_BASE(dev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(dev);
>       VFIODevice *vbasedev = &vdev->vbasedev;
>   
>       vfio_pci_pre_reset(vdev);
> @@ -421,7 +422,7 @@ static void vfio_user_pci_set_socket(Object *obj, Visitor *v, const char *name,
>       VFIOUserPCIDevice *udev = VFIO_USER_PCI(obj);
>       bool success;
>   
> -    if (VFIO_PCI_BASE(udev)->vbasedev.proxy) {
> +    if (VFIO_PCI_DEVICE(udev)->vbasedev.proxy) {
>           error_setg(errp, "Proxy is connected");
>           return;
>       }
> @@ -464,7 +465,7 @@ static void vfio_user_pci_dev_class_init(ObjectClass *klass, const void *data)
>   
>   static const TypeInfo vfio_user_pci_dev_info = {
>       .name = TYPE_VFIO_USER_PCI,
> -    .parent = TYPE_VFIO_PCI_BASE,
> +    .parent = TYPE_VFIO_PCI_DEVICE,
>       .instance_size = sizeof(VFIOUserPCIDevice),
>       .class_init = vfio_user_pci_dev_class_init,
>       .instance_init = vfio_user_instance_init,
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 963cefc053..64f8750389 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -423,7 +423,7 @@ bool vfio_device_hiod_create_and_realize(VFIODevice *vbasedev,
>   VFIODevice *vfio_get_vfio_device(Object *obj)
>   {
>       if (object_dynamic_cast(obj, TYPE_VFIO_PCI)) {
> -        return &VFIO_PCI_BASE(obj)->vbasedev;
> +        return &VFIO_PCI_DEVICE(obj)->vbasedev;
>       } else {
>           return NULL;
>       }
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 6e8b872275..6d2ca710c8 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -305,7 +305,7 @@ static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
>   
>   static void vfio_intx_routing_notifier(PCIDevice *pdev)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
>       PCIINTxRoute route;
>   
>       if (vdev->interrupt != VFIO_INT_INTx) {
> @@ -660,7 +660,7 @@ void vfio_pci_vector_init(VFIOPCIDevice *vdev, int nr)
>   static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>                                      MSIMessage *msg, IOHandler *handler)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
>       VFIOMSIVector *vector;
>       int ret;
>       bool resizing = !!(vdev->nr_vectors < nr + 1);
> @@ -755,7 +755,7 @@ static int vfio_msix_vector_use(PCIDevice *pdev,
>   
>   static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
>       VFIOMSIVector *vector = &vdev->msi_vectors[nr];
>   
>       trace_vfio_msix_vector_release(vdev->vbasedev.name, nr);
> @@ -1346,7 +1346,7 @@ static const MemoryRegionOps vfio_vga_ops = {
>    */
>   static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
>       VFIORegion *region = &vdev->bars[bar].region;
>       MemoryRegion *mmap_mr, *region_mr, *base_mr;
>       PCIIORegion *r;
> @@ -1392,7 +1392,7 @@ static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
>    */
>   uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
>       VFIODevice *vbasedev = &vdev->vbasedev;
>       uint32_t emu_bits = 0, emu_val = 0, phys_val = 0, val;
>   
> @@ -1426,7 +1426,7 @@ uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
>   void vfio_pci_write_config(PCIDevice *pdev,
>                              uint32_t addr, uint32_t val, int len)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
>       VFIODevice *vbasedev = &vdev->vbasedev;
>       uint32_t val_le = cpu_to_le32(val);
>       int ret;
> @@ -3396,7 +3396,7 @@ bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
>   static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
>   {
>       ERRP_GUARD();
> -    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
>       VFIODevice *vbasedev = &vdev->vbasedev;
>       int i;
>       char uuid[UUID_STR_LEN];
> @@ -3556,14 +3556,14 @@ error:
>   
>   static void vfio_pci_finalize(Object *obj)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
> +    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(obj);
>   
>       vfio_pci_put_device(vdev);
>   }
>   
>   static void vfio_exitfn(PCIDevice *pdev)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
>       VFIODevice *vbasedev = &vdev->vbasedev;
>   
>       vfio_unregister_req_notifier(vdev);
> @@ -3587,7 +3587,7 @@ static void vfio_exitfn(PCIDevice *pdev)
>   
>   static void vfio_pci_reset(DeviceState *dev)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI_BASE(dev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(dev);
>   
>       /* Do not reset the device during qemu_system_reset prior to cpr load */
>       if (cpr_is_incoming()) {
> @@ -3632,7 +3632,7 @@ post_reset:
>   static void vfio_pci_init(Object *obj)
>   {
>       PCIDevice *pci_dev = PCI_DEVICE(obj);
> -    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
> +    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(obj);
>       VFIODevice *vbasedev = &vdev->vbasedev;
>   
>       device_add_bootindex_property(obj, &vdev->bootindex,
> @@ -3673,7 +3673,7 @@ static void vfio_pci_base_dev_class_init(ObjectClass *klass, const void *data)
>   }
>   
>   static const TypeInfo vfio_pci_base_dev_info = {
> -    .name = TYPE_VFIO_PCI_BASE,
> +    .name = TYPE_VFIO_PCI_DEVICE,
>       .parent = TYPE_PCI_DEVICE,
>       .instance_size = sizeof(VFIOPCIDevice),
>       .abstract = true,
> @@ -3762,7 +3762,7 @@ static const Property vfio_pci_dev_properties[] = {
>   #ifdef CONFIG_IOMMUFD
>   static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
> +    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(obj);
>       vfio_device_set_fd(&vdev->vbasedev, str, errp);
>   }
>   #endif
> @@ -3918,7 +3918,7 @@ static void vfio_pci_class_init(ObjectClass *klass, const void *data)
>   
>   static const TypeInfo vfio_pci_info = {
>       .name = TYPE_VFIO_PCI,
> -    .parent = TYPE_VFIO_PCI_BASE,
> +    .parent = TYPE_VFIO_PCI_DEVICE,
>       .class_init = vfio_pci_class_init,
>       .instance_init = vfio_pci_init,
>       .instance_finalize = vfio_pci_finalize,
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index e0aef82a89..0f78cf9cdb 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -120,7 +120,7 @@ typedef struct VFIOMSIXInfo {
>       MemoryRegion *pba_region;
>   } VFIOMSIXInfo;
>   
> -OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI_BASE)
> +OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI_DEVICE)

Could you please add to your .gitconfig :

     [diff]
	orderFile = /path/to/qemu/scripts/git.orderfile

So that header files come first in the patch. It helps understanding
the changes.


>   
>   struct VFIOPCIDevice {
>       PCIDevice parent_obj;
> diff --git a/hw/vfio/types.h b/hw/vfio/types.h
> index c19334ff25..5482d90808 100644
> --- a/hw/vfio/types.h
> +++ b/hw/vfio/types.h
> @@ -9,11 +9,11 @@
>   #define HW_VFIO_VFIO_TYPES_H
>   
>   /*
> - * TYPE_VFIO_PCI_BASE is an abstract type used to share code
> + * TYPE_VFIO_PCI_DEVICE is an abstract type used to share code
>    * between VFIO implementations that use a kernel driver
>    * with those that use user sockets.
>    */
> -#define TYPE_VFIO_PCI_BASE "vfio-pci-base"
> +#define TYPE_VFIO_PCI_DEVICE "vfio-pci-device"
>   
>   #define TYPE_VFIO_PCI "vfio-pci"
>   /* TYPE_VFIO_PCI shares struct VFIOPCIDevice. */



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



