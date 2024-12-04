Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332CEE7716F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 22:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIxyC-00062J-QY; Wed, 04 Dec 2024 17:35:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tIxy9-00061X-1V
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 17:35:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tIxy7-00082B-Cj
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 17:35:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733351738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cSUs8GewW8HzvuM0pv59YfV77x2cEuwoSXy1+sJ/hw4=;
 b=OcpHbg4TKQ+V77uCJ7wy4jlFoNZZAnzw3WpbroT9t+d1wL4lO8LWTT+jn5WLEttgBL4PAu
 VZ6udK5H/AXE2xKaZPFa2BdUmcpUuEzTpqvV/XygpgkwubDoy8g4A0pvVhAgXbPiQwRVNp
 1bPw5ApskGGBcNjoG9tuiaOKLXqVqUU=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-L7OyOpKqODCX0mvl9lmv4w-1; Wed, 04 Dec 2024 17:35:37 -0500
X-MC-Unique: L7OyOpKqODCX0mvl9lmv4w-1
X-Mimecast-MFC-AGG-ID: L7OyOpKqODCX0mvl9lmv4w
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-841acf1782fso4242239f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 14:35:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733351736; x=1733956536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cSUs8GewW8HzvuM0pv59YfV77x2cEuwoSXy1+sJ/hw4=;
 b=Psf/+9MeFFxbexq8L5I23CSfkrxBmIqqmGDRcseJiQCpAu1QZtB4D7hWzF8lZ+REXu
 Vj3WFgTIYoCdzSOX0D3WmSvFBVEE+WARuPtfd/x4T3zA7RGl3ww0KU+/kyN4ZNCqJynD
 jmPeATsPUKqWfZwQDgR7IdR4MjQCb0gMGkwERwqOz6lDGPEmthss0pzVtFj+LvuTeMwQ
 4N57LxU/AUtHo5psryN67h9h6hWv3G06AouoMVDP9ln/EqdqIC33FsvoFQj96idFP7pI
 SSqOBjbcqGYPXYAqsNu5onGIuAQschHdBQcZFMFrpEUpM0XGtw13I7+nMgn5uBSlZXAG
 R5Tw==
X-Gm-Message-State: AOJu0YyFD8OzSYWVNPquXjOwsmkdZJ0dE/Asykvk1qwqzNhi5NyDvRv7
 KoZhhaIsz14d2Tq+PQN1mHKugCXECvzqHOOlRIQXe39DbWeAXcAebCIwvXYxJPGM7dfEB9jqH16
 +sbWsCI1FEgYMCHyRqQnZhsIpnVsckAgNODxCrQaoGuA9FLbG0hG4JHdFDT/7
X-Gm-Gg: ASbGncvz3HvmtRVwSvQeglcMvaosdWW0BO/ryp/fT5nfixixheR3lQbgbieomZhruT1
 hwXPCgiyC0QIiNjbLPM7HQYLvbsascC9lsSwhYG6vuiRyrCe0bfbmaQWZ9rpVGTQF0tc2YOAeEw
 3Kj5YWpuuiceVN9UMwoGkNHgWx1sGwMGN3/EjRrWiZ2MWAfyEzw2QqHrmBVfJEpveWlGcFIHGdq
 cI1kVeHawPPzYVv6xPcqg7k4/awNVN0nv+f6miQJeI7yAUulWc0wg==
X-Received: by 2002:a05:6e02:b4f:b0:3a7:81cd:5c4a with SMTP id
 e9e14a558f8ab-3a7f9ab968emr23006555ab.7.1733351736161; 
 Wed, 04 Dec 2024 14:35:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNjouLNTmqCMV/SyuPPrP/HV1DC2SLWK3xXlXyJnFB+LRAdR9U8x0PAl5cZr0uMvsQU9V9Vg==
X-Received: by 2002:a05:6e02:b4f:b0:3a7:81cd:5c4a with SMTP id
 e9e14a558f8ab-3a7f9ab968emr23006515ab.7.1733351735871; 
 Wed, 04 Dec 2024 14:35:35 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e28610837fsm27341173.13.2024.12.04.14.35.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 14:35:35 -0800 (PST)
Date: Wed, 4 Dec 2024 15:35:34 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>, Corvin =?UTF-8?B?S8O2aG5l?= <c.koehne@beckhoff.com>
Subject: Re: [PATCH v2 7/9] vfio/igd: emulate GGC register in mmio bar0
Message-ID: <20241204153534.34e76045.alex.williamson@redhat.com>
In-Reply-To: <20241203133548.38252-8-tomitamoeko@gmail.com>
References: <20241203133548.38252-1-tomitamoeko@gmail.com>
 <20241203133548.38252-8-tomitamoeko@gmail.com>
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

On Tue,  3 Dec 2024 21:35:46 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> The GGC register at 0x50 of pci config space is a mirror of the same
> register at 0x108040 of mmio bar0 [1]. i915 driver also reads that
> register from mmio bar0 instead of config space. As GGC is programmed
> and emulated by qemu, the mmio address should also be emulated, in the
> same way of BDSM register.
> 
> [1] 4.1.28, 12th Generation Intel Core Processors Datasheet Volume 2
>     https://www.intel.com/content/www/us/en/content-details/655259
> 
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>  hw/vfio/igd.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 522845c509..bc18fc8cc0 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -483,8 +483,10 @@ static const MemoryRegionOps vfio_igd_quirk_mirror_##name = {           \
>      .endianness = DEVICE_LITTLE_ENDIAN,                                 \
>  };
>  
> +VFIO_IGD_QUIRK_MIRROR_REG(IGD_GMCH, ggc)
>  VFIO_IGD_QUIRK_MIRROR_REG(IGD_BDSM_GEN11, bdsm)
>  
> +#define IGD_GGC_MMIO_OFFSET     0x108040
>  #define IGD_BDSM_MMIO_OFFSET    0x1080C0
>  
>  void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
> @@ -513,9 +515,16 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>          return;
>      }
>  
> -    quirk = vfio_quirk_alloc(1);
> +    quirk = vfio_quirk_alloc(2);
>      quirk->data = vdev;
>  
> +    memory_region_init_io(&quirk->mem[0], OBJECT(vdev),
> +                          &vfio_igd_quirk_mirror_ggc, vdev,
> +                          "vfio-igd-ggc-quirk", 2);
> +    memory_region_add_subregion_overlap(vdev->bars[0].region.mem,
> +                                        IGD_GGC_MMIO_OFFSET, &quirk->mem[0],
> +                                        1);
> +
>      memory_region_init_io(&quirk->mem[1], OBJECT(vdev),
>                            &vfio_igd_quirk_mirror_bdsm, vdev,
>                            "vfio-igd-bdsm-quirk", 8);

Seems like trying to keep these ordered by offset is what introduced
the bug in the previous patch.  Let's not care about that, use the next
index and setup in index order.  Thanks,

Alex


