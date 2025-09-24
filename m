Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AEFCAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 14:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1QYd-0005jb-Mu; Wed, 24 Sep 2025 10:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1QYc-0005j4-AD
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 10:33:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1QYV-0004lh-A9
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 10:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758724390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=G2VzgHC66RWtrJvxzZEWFuAPdJTI6vmRTIkMxsrklOI=;
 b=Tyyz3DXIIulGMpL1SYjXJTtHpf40Z9tZBfRBKvD73kauGFa4joP4e9GpGrWcPVICBaJTo/
 lwlRU7tGERHcSxlT5FMpGnLjw59ZL+teIe1Dgr1k+yyNNb+XOR/+d4d8qNXq1pIDYFumPS
 k0dfqMvF+vPDVy7lopeysx9zyh1iC+w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-WhkplpFhO-i6Mmwme9mINQ-1; Wed, 24 Sep 2025 10:33:08 -0400
X-MC-Unique: WhkplpFhO-i6Mmwme9mINQ-1
X-Mimecast-MFC-AGG-ID: WhkplpFhO-i6Mmwme9mINQ_1758724387
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e19f9d18cso19296285e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 07:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758724387; x=1759329187;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G2VzgHC66RWtrJvxzZEWFuAPdJTI6vmRTIkMxsrklOI=;
 b=O9Yqt9ZcxdS12FgABfZyeVTUFwrDJzxRdf0ETlWdrDJ5LUotRdtWsFd4bqjfwvnrPg
 pOF1Fhvd0804EnHa/0eY7EnLG8DOQ+g2wxShGkXGupSHBaDKM0o9TGE5jntkU1qDEpNs
 73MR2g8UAaCLQj50tKV2aUTjLyaQUyUId0tPdqocFzYkExW+T6hFut1NxbAkzZxQecDt
 CtqMKq8zfUn/pi2jj1CUBcd8FTmwVGm1ET5CBqk+C12H5Xvl6GwpevkhhDrfKWtapPGv
 MWaT7CUjIV/202SyHMBEEuX6mKdsX1iP8Igp9z/PcmL+VYexJ96tix0YPCEnrz29eoIx
 uEbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuvuX3BxaaBo6hIo3B0AP4w0BB3zetzn43GCC2/Hmp5P3PxtqiZMUmWd/MtKFjG4N+TgEvQIg7oFfW@nongnu.org
X-Gm-Message-State: AOJu0Yz/78SD6OEqbXie6bG0Y3/Itiboq2SLXS9xjmvgq5aAwaaiXaap
 PcrJwwAosF72MzVZH2SymMavoPhXAApqjc2VfTDe/6RQZXBn+wMCSGS991+VLpLkauSHZM0xLew
 FD+zedTnIMK0pMMJXpLpCaLunW+Fs82HhzFmluJW/M6HFCcS3jIaz4WQf
X-Gm-Gg: ASbGnctU5ozc0aN5PcQqz6+RgnNJyDpKFLZ9lzp6OZrxdJCXKX7brbXhK1+FTEze3x5
 KhlbyR1h693+yxMhUsehys77MSTD6HmnNTHSVo34smQXF0eECYVV5fatACD+T5VlH+Vnjda4aqd
 jABTGcCouSD/JV/2EN30hiv7GHpV2e7uF7n3CwOIALlJ6vS0Tljs3SlnhYe+R6qWU97+cbOpZlM
 EIhQpUFKo56cPdjO/mIChWbEysRF37biaGx4eO2UwuloH90szhstLUZNShEMWDRa85MFBlFYI5w
 yTQcOg2tuJ0qTDilQd+CSO8FCTMDjWh3Y0xzXKU37z9DIkteGgdAYQjvKgbp/LSUvS963Uma+/1
 COHU=
X-Received: by 2002:a05:600c:1f84:b0:46d:7fa2:7579 with SMTP id
 5b1f17b1804b1-46e329adce6mr923855e9.9.1758724387339; 
 Wed, 24 Sep 2025 07:33:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYOy0K8Qo7Gy4vthOkOuUNAl1ClX6mhVgixRZ/zlp/XIJ1arltJkagiPYpYZq10Z0ScQuQhg==
X-Received: by 2002:a05:600c:1f84:b0:46d:7fa2:7579 with SMTP id
 5b1f17b1804b1-46e329adce6mr923645e9.9.1758724386888; 
 Wed, 24 Sep 2025 07:33:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab31ea3sm33593355e9.12.2025.09.24.07.33.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 07:33:06 -0700 (PDT)
Message-ID: <d8669861-a6b3-4f9c-950e-f2d46732bde0@redhat.com>
Date: Wed, 24 Sep 2025 16:33:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/27] vfio/pci.c: rename vfio_pci_dev_info to
 vfio_pci_info
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 harshpb@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
 <20250923135352.1157250-16-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250923135352.1157250-16-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 9/23/25 15:53, Mark Cave-Ayland wrote:
> This changes the prefix to match the name of the QOM type.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/vfio/pci.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 3c0e678723..6e8b872275 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3916,7 +3916,7 @@ static void vfio_pci_class_init(ObjectClass *klass, const void *data)
>                                             "multifd channels");
>   }
>   
> -static const TypeInfo vfio_pci_dev_info = {
> +static const TypeInfo vfio_pci_info = {
>       .name = TYPE_VFIO_PCI,
>       .parent = TYPE_VFIO_PCI_BASE,
>       .class_init = vfio_pci_class_init,
> @@ -3974,7 +3974,7 @@ static void register_vfio_pci_dev_type(void)
>       vfio_pci_migration_multifd_transfer_prop.realized_set_allowed = true;
>   
>       type_register_static(&vfio_pci_base_dev_info);
> -    type_register_static(&vfio_pci_dev_info);
> +    type_register_static(&vfio_pci_info);
>       type_register_static(&vfio_pci_nohotplug_dev_info);
>   }
>   


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



