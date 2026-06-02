Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF82C5DF71
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 07:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUJlv-0004jq-MT; Tue, 02 Jun 2026 03:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wUJls-0004jI-1i
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 03:42:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wUJlo-0003N4-I6
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 03:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780386159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=V+Q217Pbo05hCLvQUW0Kp8q4OJXVUZgq9M8a0NMgfMc=;
 b=dvdGXQe5pqWGgmZdovGsQ/TJip8GWquLFxthKRFiacXrkwSf7h47xvMl+xBydQy6Lcoz2w
 UiJuIHtVN3wqPfgP3hirlpyAFx9TL17QiUb0EgvrGf5EpPYUBXPbpoiyNCrlQ/EVRnsuwt
 YCkCnAkR+zU2suP1sXkc379ncmmHj7U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-ETipnGpZPf2jYPn0ztEALA-1; Tue, 02 Jun 2026 03:42:38 -0400
X-MC-Unique: ETipnGpZPf2jYPn0ztEALA-1
X-Mimecast-MFC-AGG-ID: ETipnGpZPf2jYPn0ztEALA_1780386157
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45f3d008865so1816196f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 00:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780386157; x=1780990957; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=V+Q217Pbo05hCLvQUW0Kp8q4OJXVUZgq9M8a0NMgfMc=;
 b=PQomeHonOKcyOsyUYJJD3+O1ncXkka2JCPV1e7U7H0OVyoezuj6mGjFDe94aDgd7ss
 ZA1uHkTQVnvNkRS99AuzeNlZYB7+s6IJM0Bha5BcaCjEN5CK5+miBjQjj3fVxfrGiXOy
 7YxzG5SciJ5gEJPhlepQ7TVY0k9tvJlpG7fjYy7yvi5aXprYc3ZBxSkVH75s5T0rGsA5
 0phW9ERCWnAFwku/X7u2YHlhMzOGohg7NOMzEkrY7fx522zWscJt5v65F/htkMKOTv3+
 5NnJGvlerImlxhkDR5NHI9gaBw1Vogk08EWJl2uRiuvzplB31yGho5fhSLbnn7QgzH9M
 ALBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780386157; x=1780990957;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V+Q217Pbo05hCLvQUW0Kp8q4OJXVUZgq9M8a0NMgfMc=;
 b=tEujv34LMUaeRinjilAxYxK2k6rVzpENBQBw9h3fx2vtGyMLKIuAXC+PG48Rjh8L52
 R0eZWxU6vQ9tN4mlNhpOmG1XmC1mDvtiMhEFLBIX6z2i0ggkVD0MjCGvv2oako7oejJY
 wdpm9cMwazIrZaF3wc4EkuwZCmwA5UFqPlZh5M+EWGl3gyDTW/y+m2Y9A0B1pwSp0Zlt
 P7wv/P2QmK71W+u3KLUxo9OGdL4dFSvb8jmm16Y24t2108Zd1qnaXbeU1ChT7eYv+Zqo
 EppDQcpzdURUvVu6r8a7oA62QO3Y7tEzqRuS8p5AwcpJLB9bwW3zFVS1zAG4Cp+AstEh
 GN+g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8i0Gpa1VHJBrWmsPwIhffHyCvS3SZDUDlQZxxHqbpHCJoIp8HCaxIX1cOAXFjkK5U4pIxWgjrAHK8r@nongnu.org
X-Gm-Message-State: AOJu0YxW0tkQow/MBJB4t5DNimpB4C07NDMOOF9/F4/GMuS5dthtL3rZ
 XavPobAiEdzpWtHg/FVOe3MfmAxIE0Cd91VMSbI1Edfu4PGmhIRDrzroRYt6sRhcSa3uTgtdwia
 +EBOVyheW7VKz2ZrG9YuCrsQXFmf6AAzfNcCgqfnHfxdDIefQsNotOxBI
X-Gm-Gg: Acq92OHVjZDoypQPbRFiHiEseLpGXvtd7aJLiJOnIloLD/MgdPehCqEmRiuZsGexKkt
 7vH7DCqgLpQdlYQk5kGtOCiWuCVZEo5h78lwmwott7b2UrZMrAtOi0ds7g+mP3t0LSoiMy8wAeD
 uQrWWRL5XYsOwz0Cal6QdlvnOsubPncQDd2v25aB4UcLXZfAsWs5egTzJFTcEUZLORhkYwtn74s
 I728Br3St8BSFpkL+FZttz6M/a/dQzP71BkqwG/WI20P64EBdbkk9get5l6q6WXpdMd4TwVyv/p
 W1Qshz4S9K5YrpcuuvJjNKYgyxPj6AViagDGmDPLt2WYNIpNvc3s7Zo86kje2rE8BGGNWwjby8N
 4MN1adUSF0xQMT9ijIZzPKI1zbBK5icZ65mT/jMpXGcfpcXno3S495H2D4IjNjdg+WA0xAEI=
X-Received: by 2002:a05:6000:18a6:b0:460:11bd:3fde with SMTP id
 ffacd0b85a97d-46018d22a15mr5064866f8f.13.1780386156695; 
 Tue, 02 Jun 2026 00:42:36 -0700 (PDT)
X-Received: by 2002:a05:6000:18a6:b0:460:11bd:3fde with SMTP id
 ffacd0b85a97d-46018d22a15mr5064807f8f.13.1780386156250; 
 Tue, 02 Jun 2026 00:42:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354cd7csm30877334f8f.18.2026.06.02.00.42.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2026 00:42:35 -0700 (PDT)
Message-ID: <f2c3718c-0366-4a3a-8373-2e74e3569e06@redhat.com>
Date: Tue, 2 Jun 2026 09:42:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio/pci: Initialize rom_read_failed in
 vfio_pci_load_rom()
To: Mario Casquero <mcasquer@redhat.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org
References: <20260602070857.356526-1-mcasquer@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260602070857.356526-1-mcasquer@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 6/2/26 09:08, Mario Casquero wrote:
> When vfio_device_get_region_info() fails in vfio_pci_load_rom(),
> the function returns without setting vdev->rom_read_failed to true,
> and without allocating vdev->rom. This leaves vdev->rom as NULL.
> 
> Signed-off-by: Mario Casquero <mcasquer@redhat.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/pci.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)


Applied to

     https://github.com/legoater/qemu vfio-next

Thanks,

C.


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


