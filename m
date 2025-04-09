Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10F8C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 15:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2XiC-0007ft-Bx; Wed, 09 Apr 2025 11:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u2XiA-0007UZ-9W; Wed, 09 Apr 2025 11:51:34 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u2Xi1-0008FB-SS; Wed, 09 Apr 2025 11:51:33 -0400
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2264aefc45dso90386615ad.0; 
 Wed, 09 Apr 2025 08:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744213884; x=1744818684; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WPD0Bnyr5glbuKloHjTPB8g2HZ1zCH1NNENQGFlOtZA=;
 b=mHdD5ZmXwc5Iw5+eTJqOFFp2vI4gurNmUF/jrGAtUZsFpfyu1qSAKE37LrKJMfcvob
 f6Ia+RhWY8gKG9jVFG9Wr0sF/SEr/O9piZskpHyzjJ3z13Tp1E2HCCFV15aqCq4wvevb
 3FrbIoPl8xXTnTx1bdHYPjhZRM0oZtQM3xHtiKNKy30dP5nHrosDJvC7vhODFsYp0LDL
 ptdvzGZYpRd6+QlwAOO40d9yaesP7cSXztt2HQRnnU6W0vC4E1+9KueyWIi3bKTEMx9y
 8EiUOxXe21uIrcdvaX3SVFtvoZPLx15FIxnad82Qrj/V76ow1fAGsHv9deggTsq7TKsF
 yG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744213884; x=1744818684;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WPD0Bnyr5glbuKloHjTPB8g2HZ1zCH1NNENQGFlOtZA=;
 b=a8YQ5AjaV1qHmfPc9D+15SNZKSCT0Y3a/GCclZAfNI/7p7YR92ewiJ+yzRbycEPQIz
 j4mixDcdh2CIMqGRLxf+QABCQ9cT5rY8+rtftTu1aebCaLdkIxrGQsZh8cA1P3VYVIs3
 +fO8PGrI8cDEJDzB4hHe73DESNa1Lt05PgfLG+69Ep0OeOWRzVAX4VpIVADynlQGtenU
 NEeIxNNDcHlAYeQXw4W24b4FuvLNkza9KL0IyUI/xkkRovfKbFFodr9BJEO6Nw/uXvWz
 jUnO+hubpehOU5q6pNb0kcbseBGjAkyf8KiyR91IPspno+ce+ubd17KsQzHha39EVCuC
 NjCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo4FoIkx93kkpKXliLET48gm1n0zyHEsrXsoRAwKxe1p2K+uk4BKqneE+cVSXN4cWDQx7BMKx2Y3dR@nongnu.org,
 AJvYcCXDEKOYXnFp27XWfgtKIKMcjXMbCvtbUPnYxDHUXmVqq8EJZGVG3a4qI5tlzuRKbvSkvH2dowUD37n0SA==@nongnu.org
X-Gm-Message-State: AOJu0Yw/pqQfPKSLowof6bu4tzIz0UHg/uIgjEOEOhGexlqSjDlj+caA
 QEiiTJRjk7PZurm16/kGaIYxEWYs2uGOTncSS8p0U9njsSPOkSs=
X-Gm-Gg: ASbGncumlmoBdcHawWo6F+edm3RU0JbRdE+3CbgukhJVbMJ5XuYAh+vvFnKx8nxJuIG
 INGXCP1SonloE6QE4L2BMkgtE/+i77WexmJT8VQ4RgAak3sjFrQuLa/xJQXyxHvcDuNygkg81Ew
 TSqnW/9BVVtkFo7QPp3JJOPcULtwYXIHxOS3f+1UqfpOTYtk2GLZ2eiT22Tk0r5YX/HbtYsaAd9
 H/0LXSBuNqWFnmN1iIdK+qsGf0SBJDy50Lg66vMg6hTWa8fwu9T2uRB/7CC0AxMQTAyP3C4BfDL
 XaF/sm4uyaWpz/SMRC5N620szBeAnOCmY71yl5WnrLiygtvv5TLKG00a
X-Google-Smtp-Source: AGHT+IFkWCrGBh/RG2i0rH3S28QpTo1lK6jLZwje5ydFVkFU38nFp2XKCpmnLdQIfesRnfqESGUTzg==
X-Received: by 2002:a17:903:2346:b0:220:f59b:6e6 with SMTP id
 d9443c01a7336-22ac296c215mr34225175ad.8.1744213884022; 
 Wed, 09 Apr 2025 08:51:24 -0700 (PDT)
Received: from [192.168.0.113] ([139.227.17.72])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7cb5463sm13656005ad.195.2025.04.09.08.51.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Apr 2025 08:51:23 -0700 (PDT)
Message-ID: <ed4d5a1e-61dc-4041-a24d-c1a0bd49fa3e@gmail.com>
Date: Wed, 9 Apr 2025 23:51:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] vfio: add vfio_pci_config_space_read/write()
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>
References: <20250409134814.478903-1-john.levon@nutanix.com>
 <20250409134814.478903-12-john.levon@nutanix.com>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <20250409134814.478903-12-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x644.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 4/9/25 21:48, John Levon wrote:
> Add these helpers that access config space and return an -errno style
> return.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>  hw/vfio/pci.c | 134 ++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 91 insertions(+), 43 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index ddeee33aa9..c3842d2f8d 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -964,6 +964,28 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>      }
>  }
>  
> +/* "Raw" read of underlying config space. */
> +static int vfio_pci_config_space_read(VFIOPCIDevice *vdev, off_t offset,
> +                                      uint32_t size, void *data)

Returning ssize_t here might be better here to avoid casting issues,
though we would never read/write something exceeds INT32_MAX.

Thanks,
Moeko

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
>  static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
>  {
>      VFIOPCIDevice *vdev = opaque;
> @@ -1016,10 +1038,9 @@ static const MemoryRegionOps vfio_rom_ops = {
>  
>  static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
>  {
> +    VFIODevice *vbasedev = &vdev->vbasedev;
>      uint32_t orig, size = cpu_to_le32((uint32_t)PCI_ROM_ADDRESS_MASK);
> -    off_t offset = vdev->config_offset + PCI_ROM_ADDRESS;
>      char *name;
> -    int fd = vdev->vbasedev.fd;
>  
>      if (vdev->pdev.romfile || !vdev->pdev.rom_bar) {
>          /* Since pci handles romfile, just print a message and return */
> @@ -1036,11 +1057,12 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
>       * Use the same size ROM BAR as the physical device.  The contents
>       * will get filled in later when the guest tries to read it.
>       */
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
>          return;
>      }
>  
> @@ -1220,6 +1242,7 @@ static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
>  uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
>  {
>      VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
> +    VFIODevice *vbasedev = &vdev->vbasedev;
>      uint32_t emu_bits = 0, emu_val = 0, phys_val = 0, val;
>  
>      memcpy(&emu_bits, vdev->emulated_config_bits + addr, len);
> @@ -1232,12 +1255,13 @@ uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
>      if (~emu_bits & (0xffffffffU >> (32 - len * 8))) {
>          ssize_t ret;
>  
> -        ret = pread(vdev->vbasedev.fd, &phys_val, len,
> -                    vdev->config_offset + addr);
> +        ret = vfio_pci_config_space_read(vdev, addr, len, &phys_val);
>          if (ret != len) {
> -            error_report("%s(%s, 0x%x, 0x%x) failed: %m",
> -                         __func__, vdev->vbasedev.name, addr, len);
> -            return -errno;
> +            const char *err = ret < 0 ? strerror(-ret) : "short read";
> +
> +            error_report("%s(%s, 0x%x, 0x%x) failed: %s",
> +                         __func__, vbasedev->name, addr, len, err);
> +            return -1;
>          }
>          phys_val = le32_to_cpu(phys_val);
>      }
> @@ -1253,15 +1277,19 @@ void vfio_pci_write_config(PCIDevice *pdev,
>                             uint32_t addr, uint32_t val, int len)
>  {
>      VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
> +    VFIODevice *vbasedev = &vdev->vbasedev;
>      uint32_t val_le = cpu_to_le32(val);
> +    int ret;
>  
>      trace_vfio_pci_write_config(vdev->vbasedev.name, addr, val, len);
>  
>      /* Write everything to VFIO, let it filter out what we can't write */
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
>      }
>  
>      /* MSI/MSI-X Enabling/Disabling */
> @@ -1349,9 +1377,12 @@ static bool vfio_msi_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
>      int ret, entries;
>      Error *err = NULL;
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
>          return false;
>      }
>      ctrl = le16_to_cpu(ctrl);
> @@ -1558,30 +1589,39 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
>      uint8_t pos;
>      uint16_t ctrl;
>      uint32_t table, pba;
> -    int ret, fd = vdev->vbasedev.fd;
>      struct vfio_irq_info irq_info;
>      VFIOMSIXInfo *msix;
> +    int ret;
>  
>      pos = pci_find_capability(&vdev->pdev, PCI_CAP_ID_MSIX);
>      if (!pos) {
>          return true;
>      }
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
>          return false;
>      }
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
>          return false;
>      }
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
>          return false;
>      }
>  
> @@ -1741,10 +1781,12 @@ static void vfio_bar_prepare(VFIOPCIDevice *vdev, int nr)
>      }
>  
>      /* Determine what type of BAR this is for registration */
> -    ret = pread(vdev->vbasedev.fd, &pci_bar, sizeof(pci_bar),
> -                vdev->config_offset + PCI_BASE_ADDRESS_0 + (4 * nr));
> +    ret = vfio_pci_config_space_read(vdev, PCI_BASE_ADDRESS_0 + (4 * nr),
> +                                     sizeof(pci_bar), &pci_bar);
>      if (ret != sizeof(pci_bar)) {
> -        error_report("vfio: Failed to read BAR %d (%m)", nr);
> +        const char *err =  ret < 0 ? strerror(-ret) : "short read";
> +
> +        error_report("vfio: Failed to read BAR %d: %s", nr, err);
>          return;
>      }
>  
> @@ -2448,21 +2490,25 @@ void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
>  
>  void vfio_pci_post_reset(VFIOPCIDevice *vdev)
>  {
> +    VFIODevice *vbasedev = &vdev->vbasedev;
>      Error *err = NULL;
> -    int nr;
> +    int ret, nr;
>  
>      if (!vfio_intx_enable(vdev, &err)) {
>          error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>      }
>  
>      for (nr = 0; nr < PCI_NUM_REGIONS - 1; ++nr) {
> -        off_t addr = vdev->config_offset + PCI_BASE_ADDRESS_0 + (4 * nr);
> +        off_t addr = PCI_BASE_ADDRESS_0 + (4 * nr);
>          uint32_t val = 0;
>          uint32_t len = sizeof(val);
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
>          }
>      }
>  
> @@ -3099,6 +3145,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>      int i, ret;
>      char uuid[UUID_STR_LEN];
>      g_autofree char *name = NULL;
> +    size_t config_space_size;
>  
>      if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
>          if (!(~vdev->host.domain || ~vdev->host.bus ||
> @@ -3153,13 +3200,14 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>          goto error;
>      }
>  
> +    config_space_size = MIN(pci_config_size(&vdev->pdev), vdev->config_size);
> +
>      /* Get a copy of config space */
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
>          goto error;
>      }
>  

