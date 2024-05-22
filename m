Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEC4C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 07:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9gHI-0005It-M6; Wed, 22 May 2024 03:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9gHH-0005Gm-AY
 for qemu-devel@nongnu.org; Wed, 22 May 2024 03:20:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9gHF-0007S9-Do
 for qemu-devel@nongnu.org; Wed, 22 May 2024 03:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716362444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MmoTuLmNiln7XWt3wnZoe4SX4bvQ2heESeO6ilAj+AE=;
 b=I95ZSFFf3wy77uyZ8JlkVeeDcgINAILxkBdAYigfe005DZTLGWKkrQRy8pKDXSYw9X8vUs
 OKzDlzbqIhNoSXwYLIFWXAl8ZACWxE3QRoZEIC3qPrsCeD3fympyRPoaxDAQF1DaqNt8s7
 KOmlFBZCJldhHcphh/SiB2cJCYaGz1A=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-fvRfPg_fMT2QOmns2CusYA-1; Wed, 22 May 2024 03:20:42 -0400
X-MC-Unique: fvRfPg_fMT2QOmns2CusYA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6a1530209deso11435156d6.1
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 00:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716362442; x=1716967242;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MmoTuLmNiln7XWt3wnZoe4SX4bvQ2heESeO6ilAj+AE=;
 b=Bmy6Gr2HIISfYGllGqO3R29N/fhYmICCgOH6Nc9VULU9BjYQXDo3M7A7AMmoTrllFA
 v1vagYWxoN8jSvIwBi0ySmM5+rjP0h8VxYsU9JWstBbf09KNBmRwq/JTlIxBsVkvEwRg
 +nFvStVaDyeuc2KKhl8HszNgytKO3AEYUY6P3CgvKKNdBBMqIA1tHFDmRTWB43tNRRBb
 rmQdOytIDTGYrwVE90Pd9QI4mi8rXLTYMJzSqD5JcfWUH6L5uhpFyMMEnvG41H0KXbTJ
 clhQ9o2KA819uCbJOwUMXjOdsosBt3aPYg/Ml8XHppIsOZIqXJ/Nkxg8YHaHA4zevGG3
 EByQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgdncnXB5hCr3kKEGO0MgdnKlzDBfy41QAP5cB4kdr6BoEjHuoVf9xvu7rqXPDF8EvL4ztN4XGycXyTIFLvO2le3pU998=
X-Gm-Message-State: AOJu0YwcDNNOsIwsxTsfuxEcShQE6VrmOapLDY6NLslLGTPWMmasS88v
 yayPYSeBdcUT/MjEiMgt07H2Q6v1tm51rqrFsFSHTID2XotZAFFXZEIoLOx5HSgTmHxVCfWlvgx
 h1HKH2Fp/14t0C96xmEKRADT/MSXL4TXDogrCJwWZMWWta2oGscHt
X-Received: by 2002:a05:6214:1c82:b0:6a0:f0eb:1679 with SMTP id
 6a1803df08f44-6a84202b1d9mr198067176d6.8.1716362441724; 
 Wed, 22 May 2024 00:20:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOASzkGHJZSwU0MDuWPvNmE9H6baBVq9KVLOk//1k7K7hc7NPBaXn0aWM+dz7OVlhXsCxaZg==
X-Received: by 2002:a05:6214:1c82:b0:6a0:f0eb:1679 with SMTP id
 6a1803df08f44-6a84202b1d9mr198066926d6.8.1716362441191; 
 Wed, 22 May 2024 00:20:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a8c2d39d7esm39459936d6.95.2024.05.22.00.20.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 00:20:39 -0700 (PDT)
Message-ID: <cc246f70-e877-4d14-b0eb-fa210f354be3@redhat.com>
Date: Wed, 22 May 2024 09:20:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/20] vfio: Use g_autofree in all call site of
 vfio_get_region_info()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com
References: <20240522044015.412951-1-zhenzhong.duan@intel.com>
 <20240522044015.412951-18-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240522044015.412951-18-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/22/24 06:40, Zhenzhong Duan wrote:
> There are some exceptions when pointer to vfio_region_info is reused.
> In that case, the pointed memory is freed manually.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/helpers.c |  7 ++-----
>   hw/vfio/igd.c     |  5 ++---
>   hw/vfio/pci.c     | 13 +++----------
>   3 files changed, 7 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index 4b079dc383..27ea26aa48 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -343,7 +343,7 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
>   int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
>                         int index, const char *name)
>   {
> -    struct vfio_region_info *info;
> +    g_autofree struct vfio_region_info *info = NULL;
>       int ret;
>   
>       ret = vfio_get_region_info(vbasedev, index, &info);
> @@ -376,8 +376,6 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
>           }
>       }
>   
> -    g_free(info);
> -
>       trace_vfio_region_setup(vbasedev->name, index, name,
>                               region->flags, region->fd_offset, region->size);
>       return 0;
> @@ -594,14 +592,13 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
>   
>   bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
>   {
> -    struct vfio_region_info *info = NULL;
> +    g_autofree struct vfio_region_info *info = NULL;
>       bool ret = false;
>   
>       if (!vfio_get_region_info(vbasedev, region, &info)) {
>           if (vfio_get_region_info_cap(info, cap_type)) {
>               ret = true;
>           }
> -        g_free(info);
>       }
>   
>       return ret;
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 402fc5ce1d..1e79202f2b 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -367,8 +367,8 @@ static const MemoryRegionOps vfio_igd_index_quirk = {
>   
>   void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>   {
> -    struct vfio_region_info *rom = NULL, *opregion = NULL,
> -                            *host = NULL, *lpc = NULL;
> +    g_autofree struct vfio_region_info *rom = NULL;
> +    struct vfio_region_info *opregion = NULL, *host = NULL, *lpc = NULL;
>       VFIOQuirk *quirk;
>       VFIOIGDQuirk *igd;
>       PCIDevice *lpc_bridge;
> @@ -609,7 +609,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>       trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, ggms_mb + gms_mb);
>   
>   out:
> -    g_free(rom);
>       g_free(opregion);
>       g_free(host);
>       g_free(lpc);
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 35ad9b582f..74a79bdf61 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -879,7 +879,7 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
>   
>   static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>   {
> -    struct vfio_region_info *reg_info;
> +    g_autofree struct vfio_region_info *reg_info = NULL;
>       uint64_t size;
>       off_t off = 0;
>       ssize_t bytes;
> @@ -897,8 +897,6 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>       vdev->rom_size = size = reg_info->size;
>       vdev->rom_offset = reg_info->offset;
>   
> -    g_free(reg_info);
> -
>       if (!vdev->rom_size) {
>           vdev->rom_read_failed = true;
>           error_report("vfio-pci: Cannot read device rom at "
> @@ -2668,7 +2666,7 @@ static VFIODeviceOps vfio_pci_ops = {
>   bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
>   {
>       VFIODevice *vbasedev = &vdev->vbasedev;
> -    struct vfio_region_info *reg_info;
> +    g_autofree struct vfio_region_info *reg_info = NULL;
>       int ret;
>   
>       ret = vfio_get_region_info(vbasedev, VFIO_PCI_VGA_REGION_INDEX, &reg_info);
> @@ -2685,7 +2683,6 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
>           error_setg(errp, "unexpected VGA info, flags 0x%lx, size 0x%lx",
>                      (unsigned long)reg_info->flags,
>                      (unsigned long)reg_info->size);
> -        g_free(reg_info);
>           return false;
>       }
>   
> @@ -2694,8 +2691,6 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
>       vdev->vga->fd_offset = reg_info->offset;
>       vdev->vga->fd = vdev->vbasedev.fd;
>   
> -    g_free(reg_info);
> -
>       vdev->vga->region[QEMU_PCI_VGA_MEM].offset = QEMU_PCI_VGA_MEM_BASE;
>       vdev->vga->region[QEMU_PCI_VGA_MEM].nr = QEMU_PCI_VGA_MEM;
>       QLIST_INIT(&vdev->vga->region[QEMU_PCI_VGA_MEM].quirks);
> @@ -2736,7 +2731,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
>   static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>   {
>       VFIODevice *vbasedev = &vdev->vbasedev;
> -    struct vfio_region_info *reg_info;
> +    g_autofree struct vfio_region_info *reg_info = NULL;
>       struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info) };
>       int i, ret = -1;
>   
> @@ -2790,8 +2785,6 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>       }
>       vdev->config_offset = reg_info->offset;
>   
> -    g_free(reg_info);
> -
>       if (vdev->features & VFIO_FEATURE_ENABLE_VGA) {
>           if (!vfio_populate_vga(vdev, errp)) {
>               error_append_hint(errp, "device does not support "


