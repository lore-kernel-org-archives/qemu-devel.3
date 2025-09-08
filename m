Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0261DCAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 12:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvbC9-0001IO-V8; Mon, 08 Sep 2025 08:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvbC6-0001HQ-TJ
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 08:42:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvbBs-0004RG-D3
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 08:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757335297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aRk2i4rdANUGtkgPrFNm8od4DdKZ1jSbsT5UBU0yylw=;
 b=G7n2JnyKF9fPLA4v6Rvn7QoKbMnec14JCeXltzNi2HQP94ZJ+N7ZaC+IECOeLzi29N3AAd
 Z4a24DiEIImjt4SYvt0o2kCeqOoTXhgbSKjIpnlHje1gZfBZ4BTK/SKeI2bUSWhn6thqaa
 FURA+3nbfLR/MerERU4U3IME5GYgAeo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-R_uhWvDXO--izkr5lLByBw-1; Mon, 08 Sep 2025 08:41:35 -0400
X-MC-Unique: R_uhWvDXO--izkr5lLByBw-1
X-Mimecast-MFC-AGG-ID: R_uhWvDXO--izkr5lLByBw_1757335294
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3df19a545c2so3359302f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 05:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757335294; x=1757940094;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aRk2i4rdANUGtkgPrFNm8od4DdKZ1jSbsT5UBU0yylw=;
 b=c3D8omqazpB4ri8xtwgn32z43A1y+uYZ5iO/u3dJGYGajsNNeuf5Xl7j8SIGGD92Ih
 5+ZxWex2nJnOEfuKox7LTYfagPFlA8VKvnE0UkYYCBqNVSTOdNXkJV9fo/Sv1YzKJw7G
 CvPDEWQgsd3BZGUc+wXvHTGPsVwQA39eBetmoDWEMnXyKYZVVt1rP8ML13kNjh44QjwP
 jak6tBIiwqbsrxx9p4mU4sGCgSTtUhL/pWxTzA8eSB7dlVFdtdpLjm4Haz3zYf/kz62G
 S/IJEFSNzHIWWMoWuUxRvRkCcZa17MxBi0IQhL6RJ0cTdpmTmJsEHKgOC8yEUNYq3RRG
 jhhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6JQ2wvr7CdNzN25vM6K1cTtG5agJxeRQrQzh6NVgBPgt6fcTH8wJXBQcUXqmCiobkDiSw8QCMcYUy@nongnu.org
X-Gm-Message-State: AOJu0Yy+GBNkxmHnMg8V5RYI9eLhzD5xrJXaAFLgmJkwmVT+4rGjbt4P
 PsUaLsY69Cwe8HLEASNJwgTUolqVW0Wb+qzlTbjWQal4MA3Nx6z8UXVNGFnJe2EbyOivuLcK/M4
 GtE8S2R3OoTMpq++Ik/SEnhz8NPlv/9nl12O19HxdzPco7GhTbQfqN+JS
X-Gm-Gg: ASbGnctuBQaEi7Q6QpuGJ8d+RBaJORX13D6rvvls7yYCrf/XNFMFa9MDRwKjM+yR+UE
 FfrEYILQw6I4M66Z6xBrhrRrSKCWpqxcjvbSlihqK2dlfNQ2LdZAllKqSydO3K9yIxM/LvDWLjQ
 Bt28UfmFI3J64RqIx1jFqkvTg/lR4c+MJBVCzNLF1OwCi6pwey8l0H0blTDFJNVSXclKk+XZN12
 vns6Ac8w7qbDjzsyInChbRboe+AdmactTqne1dvdmiStMsIwOQz36lVNh5CWTjAmrWeWjSl0h0V
 d013fX/Qy8kfUysB25OKQtw6/ys/b8rq6CdhmFDCGJDALFn37kdn2SBA9YhtCCdzIHCplZ6Vt3q
 bQ+o=
X-Received: by 2002:a5d:5f92:0:b0:3e1:4d93:5580 with SMTP id
 ffacd0b85a97d-3e643ff64ecmr4109519f8f.37.1757335293669; 
 Mon, 08 Sep 2025 05:41:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/X3C9gCc818vXg8qnyCm/ohn2uHvAJGe5IjpAuJ+b30KomNwIDk8Fff7v6yd7J/rUPyfYxA==
X-Received: by 2002:a5d:5f92:0:b0:3e1:4d93:5580 with SMTP id
 ffacd0b85a97d-3e643ff64ecmr4109476f8f.37.1757335293128; 
 Mon, 08 Sep 2025 05:41:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45dd2304e16sm188006785e9.7.2025.09.08.05.41.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Sep 2025 05:41:32 -0700 (PDT)
Message-ID: <e2c61959-e02b-4fe2-8195-78c1e10621af@redhat.com>
Date: Mon, 8 Sep 2025 14:41:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/22] vfio/pci-quirks.c: use QOM casts where appropriate
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-18-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250715093110.107317-18-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/15/25 11:25, Mark Cave-Ayland wrote:
> Use QOM casts to convert between VFIOPCIDevice and PCIDevice instead of
> accessing pdev directly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/pci-quirks.c | 48 ++++++++++++++++++++++++++------------------
>   1 file changed, 29 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index 3f002252ac..c97606dbf1 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -113,6 +113,7 @@ static uint64_t vfio_generic_window_quirk_data_read(void *opaque,
>   {
>       VFIOConfigWindowQuirk *window = opaque;
>       VFIOPCIDevice *vdev = window->vdev;
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       uint64_t data;
>   
>       /* Always read data reg, discard if window enabled */
> @@ -120,7 +121,7 @@ static uint64_t vfio_generic_window_quirk_data_read(void *opaque,
>                               addr + window->data_offset, size);
>   
>       if (window->window_enabled) {
> -        data = vfio_pci_read_config(&vdev->pdev, window->address_val, size);
> +        data = vfio_pci_read_config(pdev, window->address_val, size);
>           trace_vfio_quirk_generic_window_data_read(vdev->vbasedev.name,
>                                       memory_region_name(window->data_mem), data);
>       }
> @@ -133,9 +134,10 @@ static void vfio_generic_window_quirk_data_write(void *opaque, hwaddr addr,
>   {
>       VFIOConfigWindowQuirk *window = opaque;
>       VFIOPCIDevice *vdev = window->vdev;
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>   
>       if (window->window_enabled) {
> -        vfio_pci_write_config(&vdev->pdev, window->address_val, data, size);
> +        vfio_pci_write_config(pdev, window->address_val, data, size);
>           trace_vfio_quirk_generic_window_data_write(vdev->vbasedev.name,
>                                       memory_region_name(window->data_mem), data);
>           return;
> @@ -156,6 +158,7 @@ static uint64_t vfio_generic_quirk_mirror_read(void *opaque,
>   {
>       VFIOConfigMirrorQuirk *mirror = opaque;
>       VFIOPCIDevice *vdev = mirror->vdev;
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       uint64_t data;
>   
>       /* Read and discard in case the hardware cares */
> @@ -163,7 +166,7 @@ static uint64_t vfio_generic_quirk_mirror_read(void *opaque,
>                              addr + mirror->offset, size);
>   
>       addr += mirror->config_offset;
> -    data = vfio_pci_read_config(&vdev->pdev, addr, size);
> +    data = vfio_pci_read_config(pdev, addr, size);
>       trace_vfio_quirk_generic_mirror_read(vdev->vbasedev.name,
>                                            memory_region_name(mirror->mem),
>                                            addr, data);
> @@ -175,9 +178,10 @@ static void vfio_generic_quirk_mirror_write(void *opaque, hwaddr addr,
>   {
>       VFIOConfigMirrorQuirk *mirror = opaque;
>       VFIOPCIDevice *vdev = mirror->vdev;
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>   
>       addr += mirror->config_offset;
> -    vfio_pci_write_config(&vdev->pdev, addr, data, size);
> +    vfio_pci_write_config(pdev, addr, data, size);
>       trace_vfio_quirk_generic_mirror_write(vdev->vbasedev.name,
>                                             memory_region_name(mirror->mem),
>                                             addr, data);
> @@ -211,7 +215,8 @@ static uint64_t vfio_ati_3c3_quirk_read(void *opaque,
>                                           hwaddr addr, unsigned size)
>   {
>       VFIOPCIDevice *vdev = opaque;
> -    uint64_t data = vfio_pci_read_config(&vdev->pdev,
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
> +    uint64_t data = vfio_pci_read_config(pdev,
>                                            PCI_BASE_ADDRESS_4 + 1, size);
>   
>       trace_vfio_quirk_ati_3c3_read(vdev->vbasedev.name, data);
> @@ -563,6 +568,7 @@ static uint64_t vfio_nvidia_3d0_quirk_read(void *opaque,
>   {
>       VFIONvidia3d0Quirk *quirk = opaque;
>       VFIOPCIDevice *vdev = quirk->vdev;
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       VFIONvidia3d0State old_state = quirk->state;
>       uint64_t data = vfio_vga_read(&vdev->vga->region[QEMU_PCI_VGA_IO_HI],
>                                     addr + 0x10, size);
> @@ -573,7 +579,7 @@ static uint64_t vfio_nvidia_3d0_quirk_read(void *opaque,
>           (quirk->offset & ~(PCI_CONFIG_SPACE_SIZE - 1)) == 0x1800) {
>           uint8_t offset = quirk->offset & (PCI_CONFIG_SPACE_SIZE - 1);
>   
> -        data = vfio_pci_read_config(&vdev->pdev, offset, size);
> +        data = vfio_pci_read_config(pdev, offset, size);
>           trace_vfio_quirk_nvidia_3d0_read(vdev->vbasedev.name,
>                                            offset, size, data);
>       }
> @@ -586,6 +592,7 @@ static void vfio_nvidia_3d0_quirk_write(void *opaque, hwaddr addr,
>   {
>       VFIONvidia3d0Quirk *quirk = opaque;
>       VFIOPCIDevice *vdev = quirk->vdev;
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       VFIONvidia3d0State old_state = quirk->state;
>   
>       quirk->state = NONE;
> @@ -599,7 +606,7 @@ static void vfio_nvidia_3d0_quirk_write(void *opaque, hwaddr addr,
>           if ((quirk->offset & ~(PCI_CONFIG_SPACE_SIZE - 1)) == 0x1800) {
>               uint8_t offset = quirk->offset & (PCI_CONFIG_SPACE_SIZE - 1);
>   
> -            vfio_pci_write_config(&vdev->pdev, offset, data, size);
> +            vfio_pci_write_config(pdev, offset, data, size);
>               trace_vfio_quirk_nvidia_3d0_write(vdev->vbasedev.name,
>                                                 offset, data, size);
>               return;
> @@ -815,7 +822,7 @@ static void vfio_nvidia_quirk_mirror_write(void *opaque, hwaddr addr,
>   {
>       VFIOConfigMirrorQuirk *mirror = opaque;
>       VFIOPCIDevice *vdev = mirror->vdev;
> -    PCIDevice *pdev = &vdev->pdev;
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       LastDataSet *last = (LastDataSet *)&mirror->data;
>   
>       vfio_generic_quirk_mirror_write(opaque, addr, data, size);
> @@ -1005,6 +1012,7 @@ static void vfio_rtl8168_quirk_address_write(void *opaque, hwaddr addr,
>   {
>       VFIOrtl8168Quirk *rtl = opaque;
>       VFIOPCIDevice *vdev = rtl->vdev;
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>   
>       rtl->enabled = false;
>   
> @@ -1013,7 +1021,7 @@ static void vfio_rtl8168_quirk_address_write(void *opaque, hwaddr addr,
>           rtl->addr = (uint32_t)data;
>   
>           if (data & 0x80000000U) { /* Do write */
> -            if (vdev->pdev.cap_present & QEMU_PCI_CAP_MSIX) {
> +            if (pdev->cap_present & QEMU_PCI_CAP_MSIX) {
>                   hwaddr offset = data & 0xfff;
>                   uint64_t val = rtl->data;
>   
> @@ -1021,7 +1029,7 @@ static void vfio_rtl8168_quirk_address_write(void *opaque, hwaddr addr,
>                                                       (uint16_t)offset, val);
>   
>                   /* Write to the proper guest MSI-X table instead */
> -                memory_region_dispatch_write(&vdev->pdev.msix_table_mmio,
> +                memory_region_dispatch_write(&pdev->msix_table_mmio,
>                                                offset, val,
>                                                size_memop(size) | MO_LE,
>                                                MEMTXATTRS_UNSPECIFIED);
> @@ -1049,11 +1057,12 @@ static uint64_t vfio_rtl8168_quirk_data_read(void *opaque,
>   {
>       VFIOrtl8168Quirk *rtl = opaque;
>       VFIOPCIDevice *vdev = rtl->vdev;
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       uint64_t data = vfio_region_read(&vdev->bars[2].region, addr + 0x70, size);
>   
> -    if (rtl->enabled && (vdev->pdev.cap_present & QEMU_PCI_CAP_MSIX)) {
> +    if (rtl->enabled && (pdev->cap_present & QEMU_PCI_CAP_MSIX)) {
>           hwaddr offset = rtl->addr & 0xfff;
> -        memory_region_dispatch_read(&vdev->pdev.msix_table_mmio, offset,
> +        memory_region_dispatch_read(&pdev->msix_table_mmio, offset,
>                                       &data, size_memop(size) | MO_LE,
>                                       MEMTXATTRS_UNSPECIFIED);
>           trace_vfio_quirk_rtl8168_msix_read(vdev->vbasedev.name, offset, data);
> @@ -1297,7 +1306,7 @@ static void vfio_radeon_set_gfx_only_reset(VFIOPCIDevice *vdev)
>   
>   static int vfio_radeon_reset(VFIOPCIDevice *vdev)
>   {
> -    PCIDevice *pdev = &vdev->pdev;
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       int i, ret = 0;
>       uint32_t data;
>   
> @@ -1454,7 +1463,7 @@ static bool is_valid_std_cap_offset(uint8_t pos)
>   static bool vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
>   {
>       ERRP_GUARD();
> -    PCIDevice *pdev = &vdev->pdev;
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       int ret, pos;
>       bool c8_conflict = false, d4_conflict = false;
>       uint8_t tmp;
> @@ -1547,6 +1556,7 @@ static bool vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
>   static bool vfio_add_vmd_shadow_cap(VFIOPCIDevice *vdev, Error **errp)
>   {
>       ERRP_GUARD();
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       uint8_t membar_phys[16];
>       int ret, pos = 0xE8;
>   
> @@ -1565,7 +1575,7 @@ static bool vfio_add_vmd_shadow_cap(VFIOPCIDevice *vdev, Error **errp)
>           return false;
>       }
>   
> -    ret = pci_add_capability(&vdev->pdev, PCI_CAP_ID_VNDR, pos,
> +    ret = pci_add_capability(pdev, PCI_CAP_ID_VNDR, pos,
>                                VMD_SHADOW_CAP_LEN, errp);
>       if (ret < 0) {
>           error_prepend(errp, "Failed to add VMD MEMBAR Shadow cap: ");
> @@ -1574,10 +1584,10 @@ static bool vfio_add_vmd_shadow_cap(VFIOPCIDevice *vdev, Error **errp)
>   
>       memset(vdev->emulated_config_bits + pos, 0xFF, VMD_SHADOW_CAP_LEN);
>       pos += PCI_CAP_FLAGS;
> -    pci_set_byte(vdev->pdev.config + pos++, VMD_SHADOW_CAP_LEN);
> -    pci_set_byte(vdev->pdev.config + pos++, VMD_SHADOW_CAP_VER);
> -    pci_set_long(vdev->pdev.config + pos, 0x53484457); /* SHDW */
> -    memcpy(vdev->pdev.config + pos + 4, membar_phys, 16);
> +    pci_set_byte(pdev->config + pos++, VMD_SHADOW_CAP_LEN);
> +    pci_set_byte(pdev->config + pos++, VMD_SHADOW_CAP_VER);
> +    pci_set_long(pdev->config + pos, 0x53484457); /* SHDW */
> +    memcpy(pdev->config + pos + 4, membar_phys, 16);
>   
>       return true;
>   }


