Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217A3E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 22:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIxyT-000646-OL; Wed, 04 Dec 2024 17:36:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tIxyQ-00063t-Tg
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 17:36:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tIxyP-00083C-Bu
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 17:35:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733351754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iLmVD1fTUnbcAkuS12BDjXNawIlAxnhtpc75FUCxZJE=;
 b=clL4Ix4xZZCja07HHYoesBVwGHqJvQjtvDdG3TKZ7qcD6UCP67RDCih299dWAc3g7qUYWA
 hf3S9IxzGsrrBhrB1DX6ijlgXW17XOUTTNHOBbnuznD/5XQMRj+EtuSIvmHYbRA/M4fWWT
 Uhcsz9vDJIf5UFGjuueqAECLrrQuj+M=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-FdUNA37pOaGYeWeCu2n-Fg-1; Wed, 04 Dec 2024 17:35:51 -0500
X-MC-Unique: FdUNA37pOaGYeWeCu2n-Fg-1
X-Mimecast-MFC-AGG-ID: FdUNA37pOaGYeWeCu2n-Fg
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-843e2e46265so3858039f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 14:35:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733351750; x=1733956550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iLmVD1fTUnbcAkuS12BDjXNawIlAxnhtpc75FUCxZJE=;
 b=UhE/ZQhSOezi3OWDOBGU6LJe3HiUVTkxNNg5iyVuBs5DpDUVSd1+1rTOAsUQ//1zkR
 IolBRO2CwDKuQlSTflnYtXSsHdQz2du95qD5YLmkpLQUEEks7u+a66UF9/9z0B9f3HDx
 HZ0VMewnuuWj3dk4Tr/wsvipYfO0U6CA65qclDxfzGN5RiuvHa1NlCSgJc8yNdpVNzTN
 nkGAY8tUJXRVsy/lHHPBJJFMp6kdm1axlNeQJNC7mP6OzV/pVqyo194CMPFaayIbO5nJ
 l5Uzr+6O60rEyyAagUibf+Jm1HSgrKBQRO/k11nZNMhJ6OjkqwsmrUAiNAw8CyK7MrYd
 8MDA==
X-Gm-Message-State: AOJu0YwCYyrsnAbZpNfECeQ4mkv8jTuTfuezRik4qUg+4p2raw68jGeK
 bKDi6iXX2+TJszsRIEtrEbGDQm6Y8z5hEi/WKTkt3ZozoImKlqoAP7V8kJGgMIRtIyVys7tPUhj
 GA5uVx6Z3K1arSR6/s4prSqgtBGdyW4P25QFiBWx2kDN9fDiAFtWd
X-Gm-Gg: ASbGncs6x11jb37rW5IWdBRvhAq0nGs1SXgQ5ZF6ZANdIk+MPXh6lT9hzQUtMSyxoit
 XuL9Dd1xji/v2XM06rVWZ22sH7TX95i65U4GsTS0qxQyOjY6X/ovvdf6wKR/WYIzA+uXCsAR7sz
 JFGDDQNu+tNZLDqTLE540H5Af+lPRuL03nG1wjRAxD2MlFthmRTm1nhDqLCkShrEa9LjqARxl8l
 2pO3nsNDn2qN4sefG7iYPOwqKTq3Q/Dl9494gZTx5mQNCvgXrpm+Q==
X-Received: by 2002:a05:6602:6013:b0:841:a62b:4732 with SMTP id
 ca18e2360f4ac-8445b554822mr202297739f.2.1733351750440; 
 Wed, 04 Dec 2024 14:35:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEM2kCxtD0YuYYmw/LDa8l5ExHS7NXff3omuGDFa9LjKtHKOdFVJqNV499k+5jxFsCJ4pIEuA==
X-Received: by 2002:a05:6602:6013:b0:841:a62b:4732 with SMTP id
 ca18e2360f4ac-8445b554822mr202296739f.2.1733351750146; 
 Wed, 04 Dec 2024 14:35:50 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861d72f4sm25087173.101.2024.12.04.14.35.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 14:35:49 -0800 (PST)
Date: Wed, 4 Dec 2024 15:35:49 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>, Corvin =?UTF-8?B?S8O2aG5l?= <c.koehne@beckhoff.com>
Subject: Re: [PATCH v2 6/9] vfio/igd: add macro for declaring mirrored
 registers
Message-ID: <20241204153549.2453c3a5.alex.williamson@redhat.com>
In-Reply-To: <20241203133548.38252-7-tomitamoeko@gmail.com>
References: <20241203133548.38252-1-tomitamoeko@gmail.com>
 <20241203133548.38252-7-tomitamoeko@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue,  3 Dec 2024 21:35:45 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> igd devices have multipe registers mirroring mmio address and pci
> config space, more than a single BDSM register. To support this,
> the read/write functions are made common and a macro is defined to
> simplify the declaration of MemoryRegionOps.
> 
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>  hw/vfio/igd.c | 60 ++++++++++++++++++++++++++++++---------------------
>  1 file changed, 35 insertions(+), 25 deletions(-)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index fea9be0b2d..522845c509 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -418,16 +418,9 @@ static const MemoryRegionOps vfio_igd_index_quirk = {
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };
>  
> -#define IGD_BDSM_MMIO_OFFSET 0x1080C0
> -
> -static uint64_t vfio_igd_quirk_bdsm_read(void *opaque,
> -                                          hwaddr addr, unsigned size)
> +static uint64_t vfio_igd_pci_config_read(VFIOPCIDevice *vdev, uint64_t offset,
> +                                         unsigned size)
>  {
> -    VFIOPCIDevice *vdev = opaque;
> -    uint64_t offset;
> -
> -    offset = IGD_BDSM_GEN11 + addr;
> -
>      switch (size) {
>      case 1:
>          return pci_get_byte(vdev->pdev.config + offset);
> @@ -438,21 +431,17 @@ static uint64_t vfio_igd_quirk_bdsm_read(void *opaque,
>      case 8:
>          return pci_get_quad(vdev->pdev.config + offset);
>      default:
> -        hw_error("igd: unsupported read size, %u bytes", size);
> +        hw_error("igd: unsupported pci config read at %lx, size %u",
> +                 offset, size);
>          break;
>      }
>  
>      return 0;
>  }
>  
> -static void vfio_igd_quirk_bdsm_write(void *opaque, hwaddr addr,
> -                                       uint64_t data, unsigned size)
> +static void vfio_igd_pci_config_write(VFIOPCIDevice *vdev, uint64_t offset,
> +                                      uint64_t data, unsigned size)
>  {
> -    VFIOPCIDevice *vdev = opaque;
> -    uint64_t offset;
> -
> -    offset = IGD_BDSM_GEN11 + addr;
> -
>      switch (size) {
>      case 1:
>          pci_set_byte(vdev->pdev.config + offset, data);
> @@ -467,17 +456,37 @@ static void vfio_igd_quirk_bdsm_write(void *opaque, hwaddr addr,
>          pci_set_quad(vdev->pdev.config + offset, data);
>          break;
>      default:
> -        hw_error("igd: unsupported read size, %u bytes", size);
> +        hw_error("igd: unsupported pci config write at %lx, size %u",
> +                 offset, size);
>          break;
>      }
>  }
>  
> -static const MemoryRegionOps vfio_igd_bdsm_quirk = {
> -    .read = vfio_igd_quirk_bdsm_read,
> -    .write = vfio_igd_quirk_bdsm_write,
> -    .endianness = DEVICE_LITTLE_ENDIAN,
> +#define VFIO_IGD_QUIRK_MIRROR_REG(reg, name)                            \
> +static uint64_t vfio_igd_quirk_read_##name(void *opaque,                \
> +                                           hwaddr addr, unsigned size)  \
> +{                                                                       \
> +    VFIOPCIDevice *vdev = opaque;                                       \

I'm not sure if QEMU coding style requires this, but I'd still prefer
to see a blank line after variable declaration, even in a macro.

> +    return vfio_igd_pci_config_read(vdev, reg + addr, size);            \
> +}                                                                       \
> +                                                                        \
> +static void vfio_igd_quirk_write_##name(void *opaque, hwaddr addr,      \
> +                                        uint64_t data, unsigned size)   \
> +{                                                                       \
> +    VFIOPCIDevice *vdev = opaque;                                       \
> +    vfio_igd_pci_config_write(vdev, reg + addr, data, size);            \
> +}                                                                       \
> +                                                                        \
> +static const MemoryRegionOps vfio_igd_quirk_mirror_##name = {           \
> +    .read = vfio_igd_quirk_read_##name,                                 \
> +    .write = vfio_igd_quirk_write_##name,                               \
> +    .endianness = DEVICE_LITTLE_ENDIAN,                                 \
>  };
>  
> +VFIO_IGD_QUIRK_MIRROR_REG(IGD_BDSM_GEN11, bdsm)
> +
> +#define IGD_BDSM_MMIO_OFFSET    0x1080C0
> +
>  void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>  {
>      VFIOQuirk *quirk;
> @@ -507,10 +516,11 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>      quirk = vfio_quirk_alloc(1);
>      quirk->data = vdev;
>  
> -    memory_region_init_io(&quirk->mem[0], OBJECT(vdev), &vfio_igd_bdsm_quirk,
> -                          vdev, "vfio-igd-bdsm-quirk", 8);
> +    memory_region_init_io(&quirk->mem[1], OBJECT(vdev),
> +                          &vfio_igd_quirk_mirror_bdsm, vdev,
> +                          "vfio-igd-bdsm-quirk", 8);
>      memory_region_add_subregion_overlap(vdev->bars[0].region.mem,
> -                                        IGD_BDSM_MMIO_OFFSET, &quirk->mem[0],
> +                                        IGD_BDSM_MMIO_OFFSET, &quirk->mem[1],

As Corvin notes, changing the quirk memory region index here is a bug.
Thanks,

Alex


