Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203EFC677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 07:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPFkP-0006w7-Ny; Wed, 11 Jun 2025 03:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPFkA-0006o5-Ei
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 03:19:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPFk5-00083B-11
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 03:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749626362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5r5fF7ieGtkj0LzxiM9xt6tktotQ7XFPwUcsZWeMWRQ=;
 b=e7TzrF9kUvZJaRDv4RZRTTq7gbPyegnjGb4xLzLuHZVJOpEXVhOiYSuO36GOQacTTJTKtz
 LK/yn+wKdjGLhopfu1m79JXayLIP3DuTeKw+qcEJuRUTO7eU275UwOd5BwAGQ4RFWOwjPV
 Es0uzsifQ0GeHf8e9zxnYj5UPY5ddac=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-O1nZao07MFaLjgptBAXaAA-1; Wed, 11 Jun 2025 03:19:21 -0400
X-MC-Unique: O1nZao07MFaLjgptBAXaAA-1
X-Mimecast-MFC-AGG-ID: O1nZao07MFaLjgptBAXaAA_1749626360
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f858bc5eso4530375f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 00:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749626360; x=1750231160;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5r5fF7ieGtkj0LzxiM9xt6tktotQ7XFPwUcsZWeMWRQ=;
 b=a2A1K0w+3pO7VY4rlDh0zD8uB1BgJADS9/O0ODTOZtZaoa9juviccoZ0EFfkawhNLc
 bLQiw8DgctMu4y9MuLPHocMNtd905mQNzPylos2ggLvkrP8g7YVkfZ8iB5dBblfch7H1
 oHHwnMLCcYgTJOa8gyFre+vmnSgEbZ27q5InJGlYbCLM6uQcaEchSM6rGmK9S6Pmk1w7
 hOW/K0HgakR6dw72Bm1O2V2BbBhVPxM0ewn8pltSNTXxoz5hhP0xHL5D9M/z8Vib87m2
 Z/e5NhkbSTwJcJA2Bb3jW7NfbXwZYLiZ1HIzBu0d7FRayUU/shcHmFeJJkhr4hy4GN8t
 gU3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB+VSvhEPqTBsx/FuQG1zDYgBodvocMBVWcGOpPoa8X424izNGmLGvI7HzG4TNYgK2g6vBiz+xeW4I@nongnu.org
X-Gm-Message-State: AOJu0YzkDTk9+dABnqCCiW/Eae4v+trxyqjuL62Nkq7GPw/cOlvCgK+H
 xr0zrHVdV+u6gzy3/apfKmHegD1PjSRn87xpD4DGE5TrZ6L90nhVzwkYAUW8Rg7LI5Ga0Fne+1k
 WT2fMO9Y2A7TvjcNKNm7rvgBjpsCQ/LHAuc6GmbEUHvzHL1gRQiTraHdKwFglFfru
X-Gm-Gg: ASbGnctoIFDs4yUDSE0gboIZmN1bRygxd0/BpGZOSsBLuZxJoEHYygq+RAp/FRKwtFr
 Zr3Sl58VwqBUDXkinqILTb54LWB7LngPY5M9RbRJQME6N3pdwvbZFkB7snzkn8AaNO3CZqOFTQj
 dd5P2xZk31sSoK5ihLcE8o3bavZ+Ov6EmCqnKwIs+DiWTyMjskKnZktZ6X626nb6ha3gCr1QRB3
 nMaJp627p0A3KXOjgW7Qo352bbacV4hzPThXOE5g/bEgABgNRHVWjH9EwHGXn2IMyBUaBseBB0H
 DZ6FTHxhPpTG8QaHyX8Dq9o5bFVY+u46lYggBq3Iy2EoZdcDPT9H7AlHRqze
X-Received: by 2002:a5d:5f88:0:b0:3a4:fbaf:664a with SMTP id
 ffacd0b85a97d-3a55881dc04mr1363714f8f.29.1749626360180; 
 Wed, 11 Jun 2025 00:19:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJDTVxNsv01XUdS2JhaQ24U15sPPTcyL9y4a1tpgbfnZDXVFSoXn6vu0D9IUeQ9YKRdoT+gQ==
X-Received: by 2002:a5d:5f88:0:b0:3a4:fbaf:664a with SMTP id
 ffacd0b85a97d-3a55881dc04mr1363694f8f.29.1749626359780; 
 Wed, 11 Jun 2025 00:19:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244fd02sm14251600f8f.75.2025.06.11.00.19.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 00:19:19 -0700 (PDT)
Message-ID: <58e02d61-7f6e-41bb-a7a5-f1058e52af31@redhat.com>
Date: Wed, 11 Jun 2025 09:19:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/pci: Fix instance_size of VFIO_PCI_BASE
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: john.levon@nutanix.com, chao.p.peng@intel.com,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250611024228.423666-1-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250611024228.423666-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/11/25 04:42, Zhenzhong Duan wrote:
> Currently the final instance_size of VFIO_PCI_BASE is sizeof(PCIDevice).
> It should be sizeof(VFIOPCIDevice), VFIO_PCI uses same structure as
> base class VFIO_PCI_BASE, so no need to set its instance_size explicitly.
> 
> This isn't catastrophic only because VFIO_PCI_BASE is an abstract class.
> 
> Fixes: d4e392d0a99b ("vfio: add vfio-pci-base class")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Hey, we were discussing this issue on IRC yesterday (#qemu on OFTC)

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Applied to vfio-next.

Thanks,

C.


> ---
>   hw/vfio/pci.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 92562898e4..03f52a9b8f 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3478,7 +3478,7 @@ static void vfio_pci_base_dev_class_init(ObjectClass *klass, const void *data)
>   static const TypeInfo vfio_pci_base_dev_info = {
>       .name = TYPE_VFIO_PCI_BASE,
>       .parent = TYPE_PCI_DEVICE,
> -    .instance_size = 0,
> +    .instance_size = sizeof(VFIOPCIDevice),
>       .abstract = true,
>       .class_init = vfio_pci_base_dev_class_init,
>       .interfaces = (const InterfaceInfo[]) {
> @@ -3701,7 +3701,6 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, const void *data)
>   static const TypeInfo vfio_pci_dev_info = {
>       .name = TYPE_VFIO_PCI,
>       .parent = TYPE_VFIO_PCI_BASE,
> -    .instance_size = sizeof(VFIOPCIDevice),
>       .class_init = vfio_pci_dev_class_init,
>       .instance_init = vfio_instance_init,
>       .instance_finalize = vfio_instance_finalize,


