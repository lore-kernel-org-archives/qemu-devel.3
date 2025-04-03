Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC95C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 17:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0O8R-0000Fa-K9; Thu, 03 Apr 2025 13:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u0O8K-0000Eu-SZ
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 13:13:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u0O8I-00048O-3h
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 13:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743700416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6OghveytHQGHPXuPH/fp8X7PsPqzEkwaZXDN3K50D1M=;
 b=GF4JXEpzQZ8WUpaBsNUZjrNJWlnYD7Xs5Fu4jfz+tBUrRapKMly+L+Q6Fpc5LatDpqmkPX
 kmzR9kOD14wbLBFCg4PVqN83+UIqHcQAjAaL9HUJPcgTfrTS5d9JDM9xdwdV881T+UR8bI
 BWs5SfjxEhUb++w1R4+e+WedywHTaN8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-jitKrOoUOtaV1WHol_KXeA-1; Thu, 03 Apr 2025 13:13:33 -0400
X-MC-Unique: jitKrOoUOtaV1WHol_KXeA-1
X-Mimecast-MFC-AGG-ID: jitKrOoUOtaV1WHol_KXeA_1743700413
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39126c3469fso592179f8f.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 10:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743700412; x=1744305212;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6OghveytHQGHPXuPH/fp8X7PsPqzEkwaZXDN3K50D1M=;
 b=Cpr1Al1IItJpCGynLyULGA7d7nk578xImgsO7tKQQBJparUy2KWU6YyqKPBnif/aJ4
 3gB5T9SUzIjZkV9UYwGKI0LZgd8X2gO7GGiEsxzli52SweboL4ljdOVmmAzVhVy0U0cl
 8rL+MPR29h3ev4O+G5N6K1055B9zEPp7KxErJ7nHLDO05Nsd9Z8OudiEb8NXfenTr1/S
 0qsGoXJ8fSuEeO4qp+0pktgZxTts3pNQx/BD2WBCTXRc0dOLFvkTrqv+9mLKMdnfgyji
 PN01gi63yIKdaP7zPA3j5ASGzB20evuNWYryfqeMneETN+v/SYKJmVrJdQtHZvl+CAJc
 5IIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhuzl99f3EFp3LB/U1wCZt33EnTPWEAo4IoWQIJmZTc08KT+FEmVWX/5JvzGYaB7hIG4XHf551p87Y@nongnu.org
X-Gm-Message-State: AOJu0YzX7NAtolYdrMSzk9folGCvfpX6JSaGL25ICor+H5aD4sRycDNk
 c6x367HLqbm+uhwcS41umhE7w0OFpp3G7Cqm20L7Fl7bZKTdPFIcIfz2V4Cd04EG/ZJ25rpB8I+
 9ey2mimJoZHE6cLqQ+mmN8aMj9fYwREPcA1wWPf5QengUiCwBLlpR
X-Gm-Gg: ASbGncsL238qZL0EVkko7VDMq7shHpIp2pbVsFbt/el9arg2ZdSquJH2HuumHjqqtuM
 cnjc8qvXDB6sR3AX00SeiYq0YkGxFBluiIBLKKHMsmhEiM2digyJVdCryrcAo8MmRqafk0dV/61
 kWBNJD6VA7KlAQUZKwrCfb/UVJ0VqUHC2yQ8fufyxhj3Te1NDV6lOiDh0oyHtDitPaiLqyfzmop
 U0p85Yr7V7W+wLe3nH09/JJPyLU/KbLBeLpcTRbHw675WXP4yZ6Z0bmSO4dizz815fs3VdvTRC1
 NtM+tYBowEM+ZxQr+l2SIiUIYnO92GIWQT1Txwgjun2Y8eFh3Bh39A==
X-Received: by 2002:a5d:648a:0:b0:390:fbba:e65e with SMTP id
 ffacd0b85a97d-39cba932852mr106602f8f.32.1743700412486; 
 Thu, 03 Apr 2025 10:13:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3L5p6m+O67Pk6shj7Z+QzN87/rEywCLT/9XY7apfgup7JMGnN9cPSIuEJr3jSujPOUTTVSg==
X-Received: by 2002:a5d:648a:0:b0:390:fbba:e65e with SMTP id
 ffacd0b85a97d-39cba932852mr106560f8f.32.1743700412023; 
 Thu, 03 Apr 2025 10:13:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a7225sm2300878f8f.26.2025.04.03.10.13.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 10:13:31 -0700 (PDT)
Message-ID: <52ecc629-4138-4436-bc38-b5f427dd3d7f@redhat.com>
Date: Thu, 3 Apr 2025 19:13:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/28] vfio: split out VFIOKernelPCIDevice
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
 <20250219144858.266455-10-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250219144858.266455-10-john.levon@nutanix.com>
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
> Split out code specific to the kernel-side vfio implementation from the
> VFIOPCIDevice class into a VFIOKernelPCIDevice. The forthcoming
> VFIOUserPCIDevice will share the base VFIOPCIDevice class.

The new VFIOKernelPCIDevice struct is not needed. Please drop it.

I am not sure the new TYPE_VFIO_PCI_BASE class is needed too.
Are the properties the only difference ?


Thanks,

C.



> Originally-by: John Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio/helpers.c |   2 +-
>   hw/vfio/pci.c     | 107 ++++++++++++++++++++++++++++------------------
>   hw/vfio/pci.h     |  16 ++++++-
>   3 files changed, 80 insertions(+), 45 deletions(-)
> 
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index 3c923d23b9..94bbc5747c 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -744,7 +744,7 @@ bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp)
>   VFIODevice *vfio_get_vfio_device(Object *obj)
>   {
>       if (object_dynamic_cast(obj, TYPE_VFIO_PCI)) {
> -        return &VFIO_PCI(obj)->vbasedev;
> +        return &VFIO_PCI(obj)->device.vbasedev;
>       } else {
>           return NULL;
>       }
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index a4f99fc5e0..812743e9dd 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -239,7 +239,7 @@ static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
>   
>   static void vfio_intx_routing_notifier(PCIDevice *pdev)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
>       PCIINTxRoute route;
>   
>       if (vdev->interrupt != VFIO_INT_INTx) {
> @@ -514,7 +514,7 @@ static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
>   static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>                                      MSIMessage *msg, IOHandler *handler)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
>       VFIOMSIVector *vector;
>       int ret;
>       bool resizing = !!(vdev->nr_vectors < nr + 1);
> @@ -619,7 +619,7 @@ static int vfio_msix_vector_use(PCIDevice *pdev,
>   
>   static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
>       VFIOMSIVector *vector = &vdev->msi_vectors[nr];
>   
>       trace_vfio_msix_vector_release(vdev->vbasedev.name, nr);
> @@ -1167,7 +1167,7 @@ static const MemoryRegionOps vfio_vga_ops = {
>    */
>   static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
>       VFIORegion *region = &vdev->bars[bar].region;
>       MemoryRegion *mmap_mr, *region_mr, *base_mr;
>       PCIIORegion *r;
> @@ -1213,7 +1213,7 @@ static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
>    */
>   uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
>       uint32_t emu_bits = 0, emu_val = 0, phys_val = 0, val;
>   
>       memcpy(&emu_bits, vdev->emulated_config_bits + addr, len);
> @@ -1246,7 +1246,7 @@ uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
>   void vfio_pci_write_config(PCIDevice *pdev,
>                              uint32_t addr, uint32_t val, int len)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
>       uint32_t val_le = cpu_to_le32(val);
>   
>       trace_vfio_pci_write_config(vdev->vbasedev.name, addr, val, len);
> @@ -3084,7 +3084,7 @@ static bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
>   static void vfio_realize(PCIDevice *pdev, Error **errp)
>   {
>       ERRP_GUARD();
> -    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
>       VFIODevice *vbasedev = &vdev->vbasedev;
>       int i, ret;
>       char uuid[UUID_STR_LEN];
> @@ -3274,7 +3274,7 @@ error:
>   
>   static void vfio_instance_finalize(Object *obj)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI(obj);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
>   
>       vfio_display_finalize(vdev);
>       vfio_bars_finalize(vdev);
> @@ -3292,7 +3292,7 @@ static void vfio_instance_finalize(Object *obj)
>   
>   static void vfio_exitfn(PCIDevice *pdev)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
>       VFIODevice *vbasedev = &vdev->vbasedev;
>   
>       vfio_unregister_req_notifier(vdev);
> @@ -3316,7 +3316,7 @@ static void vfio_exitfn(PCIDevice *pdev)
>   
>   static void vfio_pci_reset(DeviceState *dev)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI(dev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(dev);
>   
>       trace_vfio_pci_reset(vdev->vbasedev.name);
>   
> @@ -3356,7 +3356,7 @@ post_reset:
>   static void vfio_instance_init(Object *obj)
>   {
>       PCIDevice *pci_dev = PCI_DEVICE(obj);
> -    VFIOPCIDevice *vdev = VFIO_PCI(obj);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
>       VFIODevice *vbasedev = &vdev->vbasedev;
>   
>       device_add_bootindex_property(obj, &vdev->bootindex,
> @@ -3377,28 +3377,15 @@ static void vfio_instance_init(Object *obj)
>       pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
>   }
>   
> -static const Property vfio_pci_dev_properties[] = {
> -    DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
> -    DEFINE_PROP_UUID_NODEFAULT("vf-token", VFIOPCIDevice, vf_token),
> -    DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
> +static const Property vfio_pci_base_dev_properties[] = {
>       DEFINE_PROP_ON_OFF_AUTO("x-pre-copy-dirty-page-tracking", VFIOPCIDevice,
>                               vbasedev.pre_copy_dirty_page_tracking,
>                               ON_OFF_AUTO_ON),
>       DEFINE_PROP_ON_OFF_AUTO("x-device-dirty-page-tracking", VFIOPCIDevice,
>                               vbasedev.device_dirty_page_tracking,
>                               ON_OFF_AUTO_ON),
> -    DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
> -                            display, ON_OFF_AUTO_OFF),
> -    DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
> -    DEFINE_PROP_UINT32("yres", VFIOPCIDevice, display_yres, 0),
>       DEFINE_PROP_UINT32("x-intx-mmap-timeout-ms", VFIOPCIDevice,
>                          intx.mmap_timeout, 1100),
> -    DEFINE_PROP_BIT("x-vga", VFIOPCIDevice, features,
> -                    VFIO_FEATURE_ENABLE_VGA_BIT, false),
> -    DEFINE_PROP_BIT("x-req", VFIOPCIDevice, features,
> -                    VFIO_FEATURE_ENABLE_REQ_BIT, true),
> -    DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
> -                    VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
>       DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
>                               vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
>       DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
> @@ -3409,8 +3396,6 @@ static const Property vfio_pci_dev_properties[] = {
>       DEFINE_PROP_BOOL("x-no-kvm-intx", VFIOPCIDevice, no_kvm_intx, false),
>       DEFINE_PROP_BOOL("x-no-kvm-msi", VFIOPCIDevice, no_kvm_msi, false),
>       DEFINE_PROP_BOOL("x-no-kvm-msix", VFIOPCIDevice, no_kvm_msix, false),
> -    DEFINE_PROP_BOOL("x-no-geforce-quirks", VFIOPCIDevice,
> -                     no_geforce_quirks, false),
>       DEFINE_PROP_BOOL("x-no-kvm-ioeventfd", VFIOPCIDevice, no_kvm_ioeventfd,
>                        false),
>       DEFINE_PROP_BOOL("x-no-vfio-ioeventfd", VFIOPCIDevice, no_vfio_ioeventfd,
> @@ -3421,12 +3406,57 @@ static const Property vfio_pci_dev_properties[] = {
>                          sub_vendor_id, PCI_ANY_ID),
>       DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
>                          sub_device_id, PCI_ANY_ID),
> +    DEFINE_PROP_OFF_AUTO_PCIBAR("x-msix-relocation", VFIOPCIDevice, msix_relo,
> +                                OFF_AUTO_PCIBAR_OFF),
> +};
> +
> +
> +static void vfio_pci_base_dev_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
> +
> +    device_class_set_props(dc, vfio_pci_base_dev_properties);
> +    dc->desc = "VFIO PCI base device";
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    pdc->exit = vfio_exitfn;
> +    pdc->config_read = vfio_pci_read_config;
> +    pdc->config_write = vfio_pci_write_config;
> +}
> +
> +static const TypeInfo vfio_pci_base_dev_info = {
> +    .name = TYPE_VFIO_PCI_BASE,
> +    .parent = TYPE_PCI_DEVICE,
> +    .instance_size = 0,
> +    .abstract = true,
> +    .class_init = vfio_pci_base_dev_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_PCIE_DEVICE },
> +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +        { }
> +    },
> +};
> +
> +static const Property vfio_pci_dev_properties[] = {
> +    DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
> +    DEFINE_PROP_UUID_NODEFAULT("vf-token", VFIOPCIDevice, vf_token),
> +    DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
> +    DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
> +                            display, ON_OFF_AUTO_OFF),
> +    DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
> +    DEFINE_PROP_UINT32("yres", VFIOPCIDevice, display_yres, 0),
> +    DEFINE_PROP_BIT("x-vga", VFIOPCIDevice, features,
> +                    VFIO_FEATURE_ENABLE_VGA_BIT, false),
> +    DEFINE_PROP_BIT("x-req", VFIOPCIDevice, features,
> +                    VFIO_FEATURE_ENABLE_REQ_BIT, true),
> +    DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
> +                    VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
> +    DEFINE_PROP_BOOL("x-no-geforce-quirks", VFIOPCIDevice,
> +                     no_geforce_quirks, false),
>       DEFINE_PROP_UINT32("x-igd-gms", VFIOPCIDevice, igd_gms, 0),
>       DEFINE_PROP_UNSIGNED_NODEFAULT("x-nv-gpudirect-clique", VFIOPCIDevice,
>                                      nv_gpudirect_clique,
>                                      qdev_prop_nv_gpudirect_clique, uint8_t),
> -    DEFINE_PROP_OFF_AUTO_PCIBAR("x-msix-relocation", VFIOPCIDevice, msix_relo,
> -                                OFF_AUTO_PCIBAR_OFF),
>   #ifdef CONFIG_IOMMUFD
>       DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
>                        TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
> @@ -3437,7 +3467,8 @@ static const Property vfio_pci_dev_properties[] = {
>   #ifdef CONFIG_IOMMUFD
>   static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
>   {
> -    vfio_device_set_fd(&VFIO_PCI(obj)->vbasedev, str, errp);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
> +    vfio_device_set_fd(&vdev->vbasedev, str, errp);
>   }
>   #endif
>   
> @@ -3452,25 +3483,16 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>       object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
>   #endif
>       dc->desc = "VFIO-based PCI device assignment";
> -    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>       pdc->realize = vfio_realize;
> -    pdc->exit = vfio_exitfn;
> -    pdc->config_read = vfio_pci_read_config;
> -    pdc->config_write = vfio_pci_write_config;
>   }
>   
>   static const TypeInfo vfio_pci_dev_info = {
>       .name = TYPE_VFIO_PCI,
> -    .parent = TYPE_PCI_DEVICE,
> -    .instance_size = sizeof(VFIOPCIDevice),
> +    .parent = TYPE_VFIO_PCI_BASE,
> +    .instance_size = sizeof(VFIOKernelPCIDevice),
>       .class_init = vfio_pci_dev_class_init,
>       .instance_init = vfio_instance_init,
>       .instance_finalize = vfio_instance_finalize,
> -    .interfaces = (InterfaceInfo[]) {
> -        { INTERFACE_PCIE_DEVICE },
> -        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> -        { }
> -    },
>   };
>   
>   static const Property vfio_pci_dev_nohotplug_properties[] = {
> @@ -3490,12 +3512,13 @@ static void vfio_pci_nohotplug_dev_class_init(ObjectClass *klass, void *data)
>   static const TypeInfo vfio_pci_nohotplug_dev_info = {
>       .name = TYPE_VFIO_PCI_NOHOTPLUG,
>       .parent = TYPE_VFIO_PCI,
> -    .instance_size = sizeof(VFIOPCIDevice),
> +    .instance_size = sizeof(VFIOKernelPCIDevice),
>       .class_init = vfio_pci_nohotplug_dev_class_init,
>   };
>   
>   static void register_vfio_pci_dev_type(void)
>   {
> +    type_register_static(&vfio_pci_base_dev_info);
>       type_register_static(&vfio_pci_dev_info);
>       type_register_static(&vfio_pci_nohotplug_dev_info);
>   }
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 43c166680a..8e79740ddb 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -116,8 +116,13 @@ typedef struct VFIOMSIXInfo {
>       bool noresize;
>   } VFIOMSIXInfo;
>   
> -#define TYPE_VFIO_PCI "vfio-pci"
> -OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI)
> +/*
> + * TYPE_VFIO_PCI_BASE is an abstract type used to share code
> + * between VFIO implementations that use a kernel driver
> + * with those that use user sockets.
> + */
> +#define TYPE_VFIO_PCI_BASE "vfio-pci-base"
> +OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI_BASE)
>   
>   struct VFIOPCIDevice {
>       PCIDevice pdev;
> @@ -182,6 +187,13 @@ struct VFIOPCIDevice {
>       Notifier irqchip_change_notifier;
>   };
>   
> +#define TYPE_VFIO_PCI "vfio-pci"
> +OBJECT_DECLARE_SIMPLE_TYPE(VFIOKernelPCIDevice, VFIO_PCI)
> +
> +struct VFIOKernelPCIDevice {
> +    VFIOPCIDevice device;
> +};
> +
>   /* Use uin32_t for vendor & device so PCI_ANY_ID expands and cannot match hw */
>   static inline bool vfio_pci_is(VFIOPCIDevice *vdev, uint32_t vendor, uint32_t device)
>   {


