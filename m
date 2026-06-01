Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2054CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 15:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU4EJ-0000Nb-Cn; Mon, 01 Jun 2026 11:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wU4EH-0000NK-Uv
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 11:07:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wU4EG-0005Hz-EU
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 11:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780326418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Oy1I3xrureFv7k+OZ03qh3YuJGc2hg+ZykX43Bha1n8=;
 b=R7equujXOJsB+FlwacibVlgTsyPzQs4tlJRt6NPddYTBiT/Mos1u/1LWrjm7jq6yerbFVX
 nA+kb3+WfjvAc/BRHiK/WoMKVkqD4BizWHggqiaOuy6qySVbAaWDzJmxUmKWQuAggEWARS
 VtA/3cAjEljMnnfmWN3lcZ6PRQxTgzs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-5iD1bqC9NWqEyCLGhTTTkA-1; Mon, 01 Jun 2026 11:06:57 -0400
X-MC-Unique: 5iD1bqC9NWqEyCLGhTTTkA-1
X-Mimecast-MFC-AGG-ID: 5iD1bqC9NWqEyCLGhTTTkA_1780326416
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490ae016853so4108365e9.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 08:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780326416; x=1780931216; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Oy1I3xrureFv7k+OZ03qh3YuJGc2hg+ZykX43Bha1n8=;
 b=lVKmJXOAHTet537sdbDjTt32Jivk+5W0SnyM/OMnYWTXejUbAtRGK5tFxxGM0cuWus
 TIhmOinC5uEW4a1uK7lfk6Czr/Oj1VF8FWzGtbEE9ypwk3Tx6gRBkNlFwJ9BhJaAww5j
 Iku49hGiBVd3SfCf965UYoxCe5dVMHJAbK8SsuvEswSgYq38L1YK717l2bAkazLgpZRL
 cdjZAtcUcn1R274fKzJd8YLpaZS01JUdBIAgMZLrwHe7BvJAc+AXqiNo0bLlkkacWtwE
 +KZmL8RkYholjjWMIh762fS1+xVoKqmvDAkQA6F+T7rn26WeDuJnlpanslufYQM6nSKQ
 Kwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780326416; x=1780931216;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oy1I3xrureFv7k+OZ03qh3YuJGc2hg+ZykX43Bha1n8=;
 b=ce9kPN08z1848QsEIf3c4ZcgR0IZSbUNNqrOdm5AAUrCAuR9H4lhPknTyd5ry7HLWE
 8z2gJ9RhQM/+AUi31+f6tsrP6wDSUTNwrrzsm+NtiVwW1gHB34TU8XQWh0GDkW7Lj4j7
 S0UqvySXdEQmPENH5dCA/wNjwiFBhYAA1jzIchUuEZgL0NWMG53BWURkAgylDASXL0bS
 xxp1cDbKe4CJrkK1rNAbTfRmsoD73KNxTqYY0Fqh1y/1yPH/uVn5vXCpUOojEg7aLGKm
 WxW0WqfdC66mjgUFRF5SWzvq9zYhajSBhQvFn4vlcYwmeIkGYKzkX/XRJgykCI3u4Cso
 RNmw==
X-Forwarded-Encrypted: i=1;
 AFNElJ88t4lTwrQwSAIcN1iCqYeY2xZNFPWnWCkHZT/oL4FJqRlNoz378dsz6egF3hLTz8yyHcNexwNr1oZM@nongnu.org
X-Gm-Message-State: AOJu0Yz0K1ermSmhqLzMcVongKAv2agxkaFfueAT48C/evRafAxkYJRn
 0DgnTF5jB6/7a2YrrCMWzlvzKoRkgW9j/bULxCQfMHVH4DvnjIXr++rxifOprC3yByfxZgPdzIx
 cLywKaogIWtVFSsa2y1goqz+5SfXb9l3OtqX6i2rBT2G+3yFMC7F/EVw6
X-Gm-Gg: Acq92OEEZhP8aYu9GtFBGc/FBrAyXBtyG7H/3MrcXfM0AAHbrA9EMZGI+fok6+M++dc
 wG2pyOQwiSciaNU3SmG+sDMXqyeDJ9nqj/hnrGKTEPP7WWoEpT3VQQCfoq+pD/Q/m/vQZgUBl5q
 hv73LhbP/PKyZsPQLzHoYhjr4vihGmywJk+jouGXyiKqME0ITct+PX0iVVzdd9Wno/bieXat6Ti
 HSVxgR3oEUEXkpSLnoqWAPQQa18YrMTdra2cgJm9dWt17uUZ04vnktX3jeNLUOi4hnJnVeafceJ
 5EhEepMJf2dfDG4ra1ps4YcQCYuG4sxEeSfHpQQBzAjNfT5Af6ct6gC/OJb7MPSMAfQsulhJWNL
 F5z9QCe4t2QIZg6s0cSABbe5qiOqPkiZQqhL6G0erKeVqU81EsafauTf+MRlOryg3sOTzs+A=
X-Received: by 2002:a05:600d:8445:10b0:490:3bad:3784 with SMTP id
 5b1f17b1804b1-490a293a0f3mr153016565e9.18.1780326415692; 
 Mon, 01 Jun 2026 08:06:55 -0700 (PDT)
X-Received: by 2002:a05:600d:8445:10b0:490:3bad:3784 with SMTP id
 5b1f17b1804b1-490a293a0f3mr153016155e9.18.1780326415279; 
 Mon, 01 Jun 2026 08:06:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c0aecdfsm79647275e9.13.2026.06.01.08.06.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2026 08:06:54 -0700 (PDT)
Message-ID: <37de178e-e9d6-4c17-a67f-0d79cc222bea@redhat.com>
Date: Mon, 1 Jun 2026 17:06:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/pci: Initialize rom_read_failed in
 vfio_pci_load_rom()
To: Mario Casquero <mcasquer@redhat.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org
References: <20260601144339.339275-1-mcasquer@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260601144339.339275-1-mcasquer@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/1/26 16:43, Mario Casquero wrote:
> When vfio_device_get_region_info() fails in vfio_pci_load_rom(),
> the function returns without setting vdev->rom_read_failed to true,
> and without allocating vdev->rom. This leaves vdev->rom as NULL.
> 
> Signed-off-by: Mario Casquero <mcasquer@redhat.com>
> ---
>   hw/vfio/pci.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 9c06b25e63..d73614d3de 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1027,7 +1027,7 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
>       }
>   }
> 
> -static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
> +static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
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
> @@ -1057,7 +1057,7 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)

One little nit, you could remove the vdev->rom_read_failed assignment here :
  
         vdev->rom_read_failed = true;

Could you send a v2 please ?

Thanks,

C.

>           error_printf("Device option ROM contents are probably invalid "
>                       "(check dmesg).\nSkip option ROM probe with rombar=0, "
>                       "or load from file with romfile=\n");
> -        return;
> +        return false;
>       }
> 
>       vdev->rom = g_malloc(size);
> @@ -1113,6 +1113,8 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>               data[6] = -csum;
>           }
>       }
> +
> +    return true;
>   }
> 
>   /* "Raw" read of underlying config space. */
> @@ -1146,7 +1148,7 @@ static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
> 
>       /* Load the ROM lazily when the guest tries to read it */
>       if (unlikely(!vdev->rom && !vdev->rom_read_failed)) {
> -        vfio_pci_load_rom(vdev);
> +        vdev->rom_read_failed = !vfio_pci_load_rom(vdev);
>       }
> 
>       memcpy(&val, vdev->rom + addr,
> --
> 2.54.0
> 


