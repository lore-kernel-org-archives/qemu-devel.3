Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F137BC36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 17:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Z49-0007Z6-Uo; Wed, 09 Apr 2025 13:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1u2Z42-0007V8-Tl
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 13:18:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1u2Z40-0006L8-MT
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 13:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744219089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E6wWaMN7nMlIMX3SOSgPIMNtBpxYv2zG6jqcxjifE9E=;
 b=WwTJcpzyUtCzq4EDYpUFeqpDNkHOoxnITswl6+GENd35YhVMiXHJmSdH2nAs7hqkyBwP2Q
 LqMn5socx0NsJoHLY8alBqbU0JnUmPfxL9XMBgLtysxtTJIXh8N85O6vWiWrKEpsRQX7DO
 4Mxuh7d+D+9z4kRJHx9GiUtAqEp9eog=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-lIn4YhbRM2y7z9_AHm-v8Q-1; Wed, 09 Apr 2025 13:18:06 -0400
X-MC-Unique: lIn4YhbRM2y7z9_AHm-v8Q-1
X-Mimecast-MFC-AGG-ID: lIn4YhbRM2y7z9_AHm-v8Q_1744219086
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-3d451ad5b2fso3951685ab.2
 for <qemu-devel@nongnu.org>; Wed, 09 Apr 2025 10:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744219085; x=1744823885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E6wWaMN7nMlIMX3SOSgPIMNtBpxYv2zG6jqcxjifE9E=;
 b=H/OKanEbMoxgD4S272jO04l2OvCt/ZThmurUsO7uelL/+QVkuKpz8oeOsrSOPx4j7q
 zzAIkuAO7RSvtBP8/J1KlWvxW7BHATnqlqnDPkk4OpQNkQeTwvuFKquA9VhWJEy6uAkG
 9FcHpRuAdR9UIdG4GaghPI6c+bmfmliTJWIo4x4kAVSdsYlA/c2cCVXpTC1U8OJ4sSLk
 UqRKf32zxTLxq5mWbntmzhNjFETVfB02+c08GBVm/eU+ZEvBNndEmDdLJ5GPJBuBPKRp
 DAxWTAz6KGss+XQ3h+XIV5xNLnKLVfzz5fK33rPkcL/jNa2usBmlXh+gfwMmyv9wElvn
 qpbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULVp6E3OnIKz6bVGD/OjPvG2Q8yma4Qg1m5FS0x3dMSu+ByKZ0CMHY+4tMAyVfc2veVfTCnrV5C5x+@nongnu.org
X-Gm-Message-State: AOJu0YwE0C7GF3UD0jcB24tBsyMFJePI7wD7/AMNXJQ4oS1SosI+4VuJ
 clBmDebOovsyltUvu4Y3gulDYcwJzPZnDT1KqGd8bpvM7jWh7RE2a+MFTiB4b3vd6b638WwIIwz
 KVqwY6oIMJZ/VpKVXwpWTNV8FdvQUEcnTXxhQ/JlLxJRuDmg3ixBbEaPm85BD
X-Gm-Gg: ASbGncshKUPBGF5NLZRfTx95+v4ynqubS0gbPp4kCY5MYoD4NqT4nH/DsVHVHswSisf
 1OEaTnleaytlvP5GYSg1H7YH6g+2Y/eFA3V/8siUhup4jPGJNQrSLhTOtLGI++APtxLeyLazHN2
 snuDuFdi9Z8fhHwG3SIwF+bjWlG040WZ6vNy6mgLuCu6DQsQndZ4dCgufAwJty15C5uDHqh2hKj
 TxvFYkCEha9Q/tky/rGneUZstG2x56FZJUKEVt/BeVgy2mMv7p+O95AKTXSWoFyREFh/itw6Sq6
 BY3fdW1IRBch4Dc=
X-Received: by 2002:a05:6e02:1a82:b0:3d1:35c6:a846 with SMTP id
 e9e14a558f8ab-3d77c302710mr11597835ab.7.1744219084985; 
 Wed, 09 Apr 2025 10:18:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkXUfhutRIPZ1D3G9H1yp5cN5IbQf7EYEF/jGdYGWNdar65eljwHTedw+wcJUrVwdFPMD8bA==
X-Received: by 2002:a05:6e02:1a82:b0:3d1:35c6:a846 with SMTP id
 e9e14a558f8ab-3d77c302710mr11597745ab.7.1744219084612; 
 Wed, 09 Apr 2025 10:18:04 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d7dc582742sm3476925ab.44.2025.04.09.10.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 10:18:03 -0700 (PDT)
Date: Wed, 9 Apr 2025 11:18:01 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] vfio/igd: Check host PCI address when probing
Message-ID: <20250409111801.4c97022f.alex.williamson@redhat.com>
In-Reply-To: <20250325172239.27926-1-tomitamoeko@gmail.com>
References: <20250325172239.27926-1-tomitamoeko@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 26 Mar 2025 01:22:39 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> So far, all Intel VGA adapters, including discrete GPUs like A770 and
> B580, were treated as IGD devices. While this had no functional impact,
> a error about "unsupported IGD device" will be printed when passthrough
> Intel discrete GPUs.
> 
> Since IGD devices must be at "0000:00:02.0", let's check the host PCI
> address when probing.
> 
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>  hw/vfio/igd.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 265fffc2aa..ff250017b0 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -53,6 +53,13 @@
>   * headless setup is desired, the OpRegion gets in the way of that.
>   */
>  
> +static bool vfio_is_igd(VFIOPCIDevice *vdev)
> +{
> +    return vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) &&
> +           vfio_is_vga(vdev) &&
> +           vfio_pci_host_match(&vdev->host, "0000:00:02.0");
> +}

vfio-pci devices can also be specified via sysfsdev= rather than host=,
so at a minimum I think we'd need to test against vdev->vbasedev.name,
as other callers of vfio_pci_host_match do.  For example building a
local PCIHostDeviceAddress and comparing it to name.  This is also not
foolproof though if we start taking advantage of devices passed by fd.

Could we instead rely PCIe capabilities?  A discrete GPU should
identify as either an endpoint or legacy endpoint and IGD should
identify as a root complex integrated endpoint, or maybe older versions
would lack the PCIe capability altogether.

Also I think the comments that were dropped below are still valid and
useful to transfer to this new helper.  I think those are actually
referring to the guest address of 00:02.0 though, which should maybe be
a test as well.  Thanks,

Alex

> +
>  /*
>   * This presumes the device is already known to be an Intel VGA device, so we
>   * take liberties in which device ID bits match which generation.  This should
> @@ -427,13 +434,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>      VFIOConfigMirrorQuirk *ggc_mirror, *bdsm_mirror;
>      int gen;
>  
> -    /*
> -     * This must be an Intel VGA device at address 00:02.0 for us to even
> -     * consider enabling legacy mode. Some driver have dependencies on the PCI
> -     * bus address.
> -     */
> -    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
> -        !vfio_is_vga(vdev) || nr != 0) {
> +    if (nr != 0 || !vfio_is_igd(vdev)) {
>          return;
>      }
>  
> @@ -490,13 +491,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>      bool legacy_mode_enabled = false;
>      Error *err = NULL;
>  
> -    /*
> -     * This must be an Intel VGA device at address 00:02.0 for us to even
> -     * consider enabling legacy mode.  The vBIOS has dependencies on the
> -     * PCI bus address.
> -     */
> -    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
> -        !vfio_is_vga(vdev)) {
> +    if (!vfio_is_igd(vdev)) {
>          return true;
>      }
>  


