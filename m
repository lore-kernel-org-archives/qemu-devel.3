Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEABCD6E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 05:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUe46-0001vW-Tv; Wed, 03 Jun 2026 01:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUe43-0001uZ-6H
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 01:22:51 -0400
Received: from msg-2.mailo.com ([213.182.54.12] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUe40-0004Kh-Jh
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 01:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780459809; bh=12MkCkMWy2ch9GfU1wYqWXD8Yxcqhd7lgESMEryrAfk=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=oMV0n06xuwPa4TabLhM5b44Rh/kdNSWwMf2lA12oDAS8pV+qpiDyOJuLozYNHaUv/
 Fs0nx4neJzLtTipxN9o0dmLAY+Zt74DMsUs6vnOf58ppco1LuCpj+ofGg7INM5QozM
 sk6gR1N9bzi8pfKrZyduVbLm6jqbvE1ZJCBNnaiQ=
Received: by be1-6.in.mailobj.net [192.168.91.16] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Wed,  3 Jun 2026 06:10:06 +0200 (CEST)
X-EA-Auth: E4wtUl27F7wdYg8NHeyIxMctzVOCkihoxI3M04KeItNQaDAswmrHaDoXJycxSGu9qZsUJntuG9c1wniaHSwhNzk+xE1nnwYj
Message-ID: <caa11d1a-44cd-4c4d-bf1d-646b3b3dd33f@mailo.com>
Date: Wed, 3 Jun 2026 06:10:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio/pci: Initialize rom_read_failed in
 vfio_pci_load_rom()
To: Mario Casquero <mcasquer@redhat.com>, qemu-devel@nongnu.org
Cc: clg@redhat.com, alex@shazbot.org
References: <20260602070857.356526-1-mcasquer@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Content-Language: en-US
In-Reply-To: <20260602070857.356526-1-mcasquer@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.182.54.12; envelope-from=philmd@mailo.com;
 helo=mailo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Hi Mario,

On 2/6/26 09:08, Mario Casquero wrote:
> When vfio_device_get_region_info() fails in vfio_pci_load_rom(),
> the function returns without setting vdev->rom_read_failed to true,
> and without allocating vdev->rom. This leaves vdev->rom as NULL.
> 
> Signed-off-by: Mario Casquero <mcasquer@redhat.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/pci.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 9c06b25e63..9df04fa2d7 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1027,7 +1027,7 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
>       }
>   }
>   
> -static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
> +static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)

Since you are modifying this method signature, a bit nicer would be to
have it take an Error* argument, and propagate it. Anyway my 2 cents.

Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>

>   {
>       VFIODevice *vbasedev = &vdev->vbasedev;
>       struct vfio_region_info *reg_info = NULL;
> @@ -1041,7 +1041,7 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>   
>       if (ret != 0) {
>           error_report("vfio: Error getting ROM info: %s", strerror(-ret));
> -        return;
> +        return false;
>       }
>   
>       trace_vfio_pci_load_rom(vbasedev->name, (unsigned long)reg_info->size,
> @@ -1052,12 +1052,11 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>       vdev->rom_offset = reg_info->offset;
>   
>       if (!vdev->rom_size) {
> -        vdev->rom_read_failed = true;
>           error_report("vfio-pci: Cannot read device rom at %s", vbasedev->name);
>           error_printf("Device option ROM contents are probably invalid "
>                       "(check dmesg).\nSkip option ROM probe with rombar=0, "
>                       "or load from file with romfile=\n");
> -        return;
> +        return false;
>       }
>   
>       vdev->rom = g_malloc(size);
> @@ -1113,6 +1112,8 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>               data[6] = -csum;
>           }
>       }
> +
> +    return true;
>   }
>   
>   /* "Raw" read of underlying config space. */
> @@ -1146,7 +1147,7 @@ static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
>   
>       /* Load the ROM lazily when the guest tries to read it */
>       if (unlikely(!vdev->rom && !vdev->rom_read_failed)) {
> -        vfio_pci_load_rom(vdev);
> +        vdev->rom_read_failed = !vfio_pci_load_rom(vdev);
>       }
>   
>       memcpy(&val, vdev->rom + addr,



