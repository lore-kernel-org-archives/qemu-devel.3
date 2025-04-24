Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D29EC369D8
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 16:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7z5r-00029D-E8; Thu, 24 Apr 2025 12:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7z5o-00028r-Q0
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 12:06:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7z5l-0006ee-JI
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 12:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745510782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YzNkTPMC4elLV1mmZdU6w0j/VBZPOj9ULGu0EDe+j+c=;
 b=ebk5vyDkLv0HqDfq34k2kSbcKxaWhCr5QB7tf41Ll+Y4tBvjumgbiENXTTRHKRlPqtPU8V
 nbXFFbfuR3W4UGABT+ZhdiEba/5bUeJYbXMEpSBunrsFOeOF9MBB5hN76DznIbC2kHXlYh
 PhFcWmLXqa7WwjzWB5D4Z20H7Sd/yQA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-wqJwq8ceN-eSZWevPfLldQ-1; Thu, 24 Apr 2025 12:06:21 -0400
X-MC-Unique: wqJwq8ceN-eSZWevPfLldQ-1
X-Mimecast-MFC-AGG-ID: wqJwq8ceN-eSZWevPfLldQ_1745510780
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43e9a3d2977so9042685e9.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 09:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745510780; x=1746115580;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YzNkTPMC4elLV1mmZdU6w0j/VBZPOj9ULGu0EDe+j+c=;
 b=wPiT0n6xuOyclr9bw/karzL6Ic7kZy1teK27t3ttwGw8tU2CQxxJ65Y9ZyGFr8YJXl
 x2RhfPLf07mR/SWRlQW9rRDbgh48FKBNh+Zy9cEHWNIkB3TRM+98QdSuh0MzcoNwMCEr
 DcvHq/ImodCEDvL3pZ+Wg3hdBJwSbGl10CYWBOyF34GW/wwU9FWID3fLhMCauICES6XC
 HbWLBovS4gVRETonlrGmYNjmZNPVcIXC59wYSIJSp1F4FIzGLW4pHSN5F90AAzBZ17OO
 eZPU2Sw4MDWB3XlIkBZgY2PNtlYBJ+QUVjbjK+j26G14U/iav1Kccy2yY2tgS/ZfmwUo
 +KbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHvNyIjZQr1iIEptSw1IAtHqfe/DuGdKVEo+onQ4PanTeTinZK/bPqSuftLBLc2p3BF4/MlvVT9s0Z@nongnu.org
X-Gm-Message-State: AOJu0YzU+jO0haUxF/0baIqzzrMcmzybvnOM3l+94FHvkxCk9qgMLIQ2
 6L4wikbW0zE9AlirmCKZ90/9TxLJkUq2A839PfUQZdp1mL41cUVRQqLzZzlq4GYRC3al710mqZa
 M5EBeLwqmk6LaQ2Fi79tUoVeDj14kML9r5ZJMEwrkWgy1QX71lCjV
X-Gm-Gg: ASbGnctZS9oJx8PR2tV+9hqKTPl94ZEm9sLxq847mNnm/6JHy+47owZUB2MSfBGrW7g
 vvHYo24Itby1YRd+njpFF594/tUsVkjqn6Ge9tuvh/PT5W/75bPR+O/nc72N7Bc6ghDAU+6sjkO
 A6BMEzVIR/CnVHJ+8PgH8mDxderTLdg8Ume3q4w2VERuYEFREiUAiNtu/rDb6/taLifWZ62QTeJ
 o477Pc7qCTLoFgdbd8qxGu3tN7+Vpt/jD0EN5W2CxCuoAPEuS4BhTupxaj+YdC0dsa36If5d38V
 nkSmjb6Vvs/ZL8uPwuJv2yQVPS3heZi9YKE64gAXGiLQiSs=
X-Received: by 2002:a05:600c:b94:b0:43c:ec97:75db with SMTP id
 5b1f17b1804b1-440a310855emr720945e9.11.1745510779661; 
 Thu, 24 Apr 2025 09:06:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF52aVH9nLHbTjMy+F1ByUDlpU+2nCKDV2ig+OqTGSGOjF2XdF9Xr992CBb/vrx0iJ8Ohd9Yw==
X-Received: by 2002:a05:600c:b94:b0:43c:ec97:75db with SMTP id
 5b1f17b1804b1-440a310855emr720055e9.11.1745510778956; 
 Thu, 24 Apr 2025 09:06:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a11e52cbsm9691565e9.2.2025.04.24.09.06.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 09:06:18 -0700 (PDT)
Message-ID: <2a3403c1-be3e-45fd-b837-86915483f4e1@redhat.com>
Date: Thu, 24 Apr 2025 18:06:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] vfio: add vfio_pci_config_space_read/write()
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>
References: <20250409134814.478903-1-john.levon@nutanix.com>
 <20250409134814.478903-12-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250409134814.478903-12-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 4/9/25 15:48, John Levon wrote:
> Add these helpers that access config space and return an -errno style
> return.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio/pci.c | 134 ++++++++++++++++++++++++++++++++++----------------
>   1 file changed, 91 insertions(+), 43 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index ddeee33aa9..c3842d2f8d 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -964,6 +964,28 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>       }
>   }
>   
> +/* "Raw" read of underlying config space. */
> +static int vfio_pci_config_space_read(VFIOPCIDevice *vdev, off_t offset,
> +                                      uint32_t size, void *data)
> +{
> +    ssize_t ret;
> +
> +    ret = pread(vdev->vbasedev.fd, data, size, vdev->config_offset + offset);
> +
> +    return ret < 0 ? -errno : (int)ret;
> +}
> +
> +/* "Raw" write of underlying config space. */
> +static int vfio_pci_config_space_write(VFIOPCIDevice *vdev, off_t offset,
> +                                       uint32_t size, void *data)
> +{
> +    ssize_t ret;
> +
> +    ret = pwrite(vdev->vbasedev.fd, data, size, vdev->config_offset + offset);
> +
> +    return ret < 0 ? -errno : (int)ret;
> +}
> +
>   static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
>   {
>       VFIOPCIDevice *vdev = opaque;
> @@ -1016,10 +1038,9 @@ static const MemoryRegionOps vfio_rom_ops = {
>   
>   static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
>   {
> +    VFIODevice *vbasedev = &vdev->vbasedev;
>       uint32_t orig, size = cpu_to_le32((uint32_t)PCI_ROM_ADDRESS_MASK);
> -    off_t offset = vdev->config_offset + PCI_ROM_ADDRESS;
>       char *name;
> -    int fd = vdev->vbasedev.fd;
>   
>       if (vdev->pdev.romfile || !vdev->pdev.rom_bar) {
>           /* Since pci handles romfile, just print a message and return */
> @@ -1036,11 +1057,12 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
>        * Use the same size ROM BAR as the physical device.  The contents
>        * will get filled in later when the guest tries to read it.
>        */
> -    if (pread(fd, &orig, 4, offset) != 4 ||
> -        pwrite(fd, &size, 4, offset) != 4 ||
> -        pread(fd, &size, 4, offset) != 4 ||
> -        pwrite(fd, &orig, 4, offset) != 4) {
> -        error_report("%s(%s) failed: %m", __func__, vdev->vbasedev.name);
> +    if (vfio_pci_config_space_read(vdev, PCI_ROM_ADDRESS, 4, &orig) != 4 ||
> +        vfio_pci_config_space_write(vdev, PCI_ROM_ADDRESS, 4, &size) != 4 ||
> +        vfio_pci_config_space_read(vdev, PCI_ROM_ADDRESS, 4, &size) != 4 ||
> +        vfio_pci_config_space_write(vdev, PCI_ROM_ADDRESS, 4, &orig) != 4) {
> +
> +        error_report("%s(%s) ROM access failed", __func__, vbasedev->name);
>           return;
>       }
>   
> @@ -1220,6 +1242,7 @@ static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
>   uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
>   {
>       VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
> +    VFIODevice *vbasedev = &vdev->vbasedev;
>       uint32_t emu_bits = 0, emu_val = 0, phys_val = 0, val;
>   
>       memcpy(&emu_bits, vdev->emulated_config_bits + addr, len);
> @@ -1232,12 +1255,13 @@ uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
>       if (~emu_bits & (0xffffffffU >> (32 - len * 8))) {
>           ssize_t ret;
>   
> -        ret = pread(vdev->vbasedev.fd, &phys_val, len,
> -                    vdev->config_offset + addr);
> +        ret = vfio_pci_config_space_read(vdev, addr, len, &phys_val);
>           if (ret != len) {
> -            error_report("%s(%s, 0x%x, 0x%x) failed: %m",
> -                         __func__, vdev->vbasedev.name, addr, len);
> -            return -errno;
> +            const char *err = ret < 0 ? strerror(-ret) : "short read";

These "short read/write" messages, here and below, are a bit invasive
in the code but they are interesting to keep. I wonder if we could
improve readability with some helper.



> +
> +            error_report("%s(%s, 0x%x, 0x%x) failed: %s",
> +                         __func__, vbasedev->name, addr, len, err);
> +            return -1;

-1 (all ones) seems more correct than returning -errno as before.

>           }
>           phys_val = le32_to_cpu(phys_val);
>       }
> @@ -1253,15 +1277,19 @@ void vfio_pci_write_config(PCIDevice *pdev,
>                              uint32_t addr, uint32_t val, int len)
>   {
>       VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
> +    VFIODevice *vbasedev = &vdev->vbasedev;
>       uint32_t val_le = cpu_to_le32(val);
> +    int ret;
>   
>       trace_vfio_pci_write_config(vdev->vbasedev.name, addr, val, len);
>   
>       /* Write everything to VFIO, let it filter out what we can't write */
> -    if (pwrite(vdev->vbasedev.fd, &val_le, len, vdev->config_offset + addr)
> -                != len) {
> -        error_report("%s(%s, 0x%x, 0x%x, 0x%x) failed: %m",
> -                     __func__, vdev->vbasedev.name, addr, val, len);
> +    ret = vfio_pci_config_space_write(vdev, addr, len, &val_le);
> +    if (ret != len) {
> +        const char *err = ret < 0 ? strerror(-ret) : "short write";
> +
> +        error_report("%s(%s, 0x%x, 0x%x, 0x%x) failed: %s",
> +                     __func__, vbasedev->name, addr, val, len, err);
>       }
>   
>       /* MSI/MSI-X Enabling/Disabling */
> @@ -1349,9 +1377,12 @@ static bool vfio_msi_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
>       int ret, entries;
>       Error *err = NULL;
>   
> -    if (pread(vdev->vbasedev.fd, &ctrl, sizeof(ctrl),
> -              vdev->config_offset + pos + PCI_CAP_FLAGS) != sizeof(ctrl)) {
> -        error_setg_errno(errp, errno, "failed reading MSI PCI_CAP_FLAGS");
> +    ret = vfio_pci_config_space_read(vdev, pos + PCI_CAP_FLAGS,
> +                                     sizeof(ctrl), &ctrl);
> +    if (ret != sizeof(ctrl)) {
> +        const char *errmsg = ret < 0 ? strerror(-ret) : "short read";
> +
> +        error_setg(errp, "failed reading MSI PCI_CAP_FLAGS: %s", errmsg);
>           return false;
>       }
>       ctrl = le16_to_cpu(ctrl);
> @@ -1558,30 +1589,39 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
>       uint8_t pos;
>       uint16_t ctrl;
>       uint32_t table, pba;
> -    int ret, fd = vdev->vbasedev.fd;
>       struct vfio_irq_info irq_info;
>       VFIOMSIXInfo *msix;
> +    int ret;
>   
>       pos = pci_find_capability(&vdev->pdev, PCI_CAP_ID_MSIX);
>       if (!pos) {
>           return true;
>       }
>   
> -    if (pread(fd, &ctrl, sizeof(ctrl),
> -              vdev->config_offset + pos + PCI_MSIX_FLAGS) != sizeof(ctrl)) {
> -        error_setg_errno(errp, errno, "failed to read PCI MSIX FLAGS");
> +    ret = vfio_pci_config_space_read(vdev, pos + PCI_MSIX_FLAGS,
> +                                     sizeof(ctrl), &ctrl);
> +    if (ret != sizeof(ctrl)) {
> +        const char *err = ret < 0 ? strerror(-ret) : "short read";
> +
> +        error_setg(errp, "failed to read PCI MSIX FLAGS: %s", err);
>           return false;
>       }
>   
> -    if (pread(fd, &table, sizeof(table),
> -              vdev->config_offset + pos + PCI_MSIX_TABLE) != sizeof(table)) {
> -        error_setg_errno(errp, errno, "failed to read PCI MSIX TABLE");
> +    ret = vfio_pci_config_space_read(vdev, pos + PCI_MSIX_TABLE,
> +                                     sizeof(table), &table);
> +    if (ret != sizeof(table)) {
> +        const char *err = ret < 0 ? strerror(-ret) : "short read";
> +
> +        error_setg(errp, "failed to read PCI MSIX TABLE: %s", err);
>           return false;
>       }
>   
> -    if (pread(fd, &pba, sizeof(pba),
> -              vdev->config_offset + pos + PCI_MSIX_PBA) != sizeof(pba)) {
> -        error_setg_errno(errp, errno, "failed to read PCI MSIX PBA");
> +    ret = vfio_pci_config_space_read(vdev, pos + PCI_MSIX_PBA,
> +                                     sizeof(pba), &pba);
> +    if (ret != sizeof(pba)) {
> +        const char *err = ret < 0 ? strerror(-ret) : "short read";
> +
> +        error_setg(errp, "failed to read PCI MSIX PBA: %s", err);
>           return false;
>       }
>   
> @@ -1741,10 +1781,12 @@ static void vfio_bar_prepare(VFIOPCIDevice *vdev, int nr)
>       }
>   
>       /* Determine what type of BAR this is for registration */
> -    ret = pread(vdev->vbasedev.fd, &pci_bar, sizeof(pci_bar),
> -                vdev->config_offset + PCI_BASE_ADDRESS_0 + (4 * nr));
> +    ret = vfio_pci_config_space_read(vdev, PCI_BASE_ADDRESS_0 + (4 * nr),
> +                                     sizeof(pci_bar), &pci_bar);
>       if (ret != sizeof(pci_bar)) {
> -        error_report("vfio: Failed to read BAR %d (%m)", nr);
> +        const char *err =  ret < 0 ? strerror(-ret) : "short read";
> +
> +        error_report("vfio: Failed to read BAR %d: %s", nr, err);
>           return;
>       }
>   
> @@ -2448,21 +2490,25 @@ void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
>   
>   void vfio_pci_post_reset(VFIOPCIDevice *vdev)
>   {
> +    VFIODevice *vbasedev = &vdev->vbasedev;
>       Error *err = NULL;
> -    int nr;
> +    int ret, nr;
>   
>       if (!vfio_intx_enable(vdev, &err)) {
>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>       }
>   
>       for (nr = 0; nr < PCI_NUM_REGIONS - 1; ++nr) {
> -        off_t addr = vdev->config_offset + PCI_BASE_ADDRESS_0 + (4 * nr);
> +        off_t addr = PCI_BASE_ADDRESS_0 + (4 * nr);
>           uint32_t val = 0;
>           uint32_t len = sizeof(val);
>   
> -        if (pwrite(vdev->vbasedev.fd, &val, len, addr) != len) {
> -            error_report("%s(%s) reset bar %d failed: %m", __func__,
> -                         vdev->vbasedev.name, nr);
> +        ret = vfio_pci_config_space_write(vdev, addr, len, &val);
> +        if (ret != len) {
> +            const char *errmsg = ret < 0 ? strerror(-ret) : "short write";
> +
> +            error_report("%s(%s) reset bar %d failed: %s", __func__,
> +                         vbasedev->name, nr, errmsg);
>           }
>       }
>   
> @@ -3099,6 +3145,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>       int i, ret;
>       char uuid[UUID_STR_LEN];
>       g_autofree char *name = NULL;
> +    size_t config_space_size;

why not use uint32_t ?


Thanks,

C.


>   
>       if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
>           if (!(~vdev->host.domain || ~vdev->host.bus ||
> @@ -3153,13 +3200,14 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>           goto error;
>       }
>   
> +    config_space_size = MIN(pci_config_size(&vdev->pdev), vdev->config_size);
> +
>       /* Get a copy of config space */
> -    ret = pread(vbasedev->fd, vdev->pdev.config,
> -                MIN(pci_config_size(&vdev->pdev), vdev->config_size),
> -                vdev->config_offset);
> -    if (ret < (int)MIN(pci_config_size(&vdev->pdev), vdev->config_size)) {
> -        ret = ret < 0 ? -errno : -EFAULT;
> -        error_setg_errno(errp, -ret, "failed to read device config space");
> +    ret = vfio_pci_config_space_read(vdev, 0, config_space_size,
> +                                     vdev->pdev.config);
> +    if (ret < (int)config_space_size) {
> +        ret = ret < 0 ? -ret : EFAULT;
> +        error_setg_errno(errp, ret, "failed to read device config space");
>           goto error;
>       }
>   


