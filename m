Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E1A7CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 15:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1RC6-0003vj-53; Wed, 24 Sep 2025 11:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1RBz-0003lZ-Vw
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 11:14:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1RBn-0003Ym-Ou
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 11:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758726828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JueuBo3ymy+RrIJ59TcNbja8SK3wWyLXVU6ZQnADhbs=;
 b=Tp4IpUexCW8JjJ8RQ2I2ImvWrh/j3+Ils95kgBzcHch1H0CB2zkH3zzOUBck1/AukpqFNn
 mEAcdi5zfo7Lf9vxFc4QZOEUgH1xcZgJMb4yRZonKntnBHgAtCoChMg1U7OT8Q5DiuNnvK
 inwvLAp42u88oYFLwpuo1e5ab4hDNPI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-Zz0RiAEdM1aw4N9hrAtd3w-1; Wed, 24 Sep 2025 11:13:47 -0400
X-MC-Unique: Zz0RiAEdM1aw4N9hrAtd3w-1
X-Mimecast-MFC-AGG-ID: Zz0RiAEdM1aw4N9hrAtd3w_1758726825
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46c84b3b27bso29388605e9.2
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 08:13:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758726825; x=1759331625;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JueuBo3ymy+RrIJ59TcNbja8SK3wWyLXVU6ZQnADhbs=;
 b=IrP2ZQhZ9B5bajohBJjv656EYq5bALqmkhG8xXB9+1rcaKUTGXNgDKX8H6xik8lQaf
 7ALJrFaCAiMDHhzb+9X/NYQ5ffdh6uVtfGWi0ILFWWL5x3XaW+oMur9fD0lL8EQlkBVx
 rNZC9g38QxWqJgtlsUp2YV9dtg8zVtBaHPrEkUhbh/4JBTB1RcBMXVV0/0uxXecg3wLg
 20vS/KLiRy2s/WMt6wnk3tS+hACz5j/WeRyjQ7EfT+Ow3rbfo0u2ixxFT1+qVe2qTN2N
 GkB7bKo9+2ATNzbHxEjOo4M0LVkfLU8O4DOD/YeMA2b6g7XHA+TRlPTRQ2EWo+2nVHqc
 yFIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq87vNe2ZN+YHqdt+TmvrLvCcv3QE/pvq+NKT6Py+JN5P6egDmAh2D5VQzxl9cWPXuofhlT4kUXhXt@nongnu.org
X-Gm-Message-State: AOJu0YzKmzggSCcw5oCS6T/KNkgHKm/4dtCtU4lnFJpBsXLRtHLMdpdX
 hsxrKAMPMxp0y1WXyniWPE9jSGyp1nCAAfobiVNUEQmw/g2Rc+K9xZMhY8s/nmaWd0o7XxVuedB
 YvKyy5Jf3Qse2g1WQ8Akwvhx3m7IhrHRBJiZCOkwSAjwQQ6E8rx6xkcaJ
X-Gm-Gg: ASbGnctq7ekiCWT5ti8CSMvNmTeSDhGDWfeQ4XPjBC9RHMI6CTA584b2kVRVWmGUZkY
 c6+AlYSJ8S4ZifnEm21NuearbNzrBUtpGl5tiqiLKf0CgVa2gbZRS+oGKQpvF7WhUoagR67yq9O
 M970U5agoEbqREXfiAPaQtg5jx6AD6lnGXQrJLYCDPcCATbW3PBnK4mIYs0IUP+SJYuulYYNxn3
 2s1rBFFq2P30rm1/huGrPMJ1mrn/wTblcIHEhhMmHVq98zO7oHvAzAxHKe4g/DhszkKoZ+J21mu
 Qm1Pvzv+pwGjG4lcvlNIZ1JuCXkyY6BlCYm8VAUGMtw6UpfiHoz8xWm3iSdFjavXS4SoEcwgbYL
 ng8k=
X-Received: by 2002:a05:600c:64cf:b0:46e:29a3:26c4 with SMTP id
 5b1f17b1804b1-46e329a48cemr2395155e9.2.1758726825368; 
 Wed, 24 Sep 2025 08:13:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4/a4jQXZvh+l68pRh94BEXmVVhReAGufG5rM/V30bidshgugIm0zsXTgwiot+FSIy4wRdRw==
X-Received: by 2002:a05:600c:64cf:b0:46e:29a3:26c4 with SMTP id
 5b1f17b1804b1-46e329a48cemr2394865e9.2.1758726824985; 
 Wed, 24 Sep 2025 08:13:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e1dab52d7sm39229255e9.2.2025.09.24.08.13.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 08:13:44 -0700 (PDT)
Message-ID: <7d002e1e-9bf2-41fb-957b-49157ffa1ccc@redhat.com>
Date: Wed, 24 Sep 2025 17:13:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/27] vfio-user/pci.c: rename
 vfio_user_pci_dev_properties[] to vfio_user_pci_properties[]
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 harshpb@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
 <20250923135352.1157250-25-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250923135352.1157250-25-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
>   hw/vfio-user/pci.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
> index e2c5b5744c..30f485fdbb 100644
> --- a/hw/vfio-user/pci.c
> +++ b/hw/vfio-user/pci.c
> @@ -400,7 +400,7 @@ static void vfio_user_pci_reset(DeviceState *dev)
>       vfio_pci_post_reset(vdev);
>   }
>   
> -static const Property vfio_user_pci_dev_properties[] = {
> +static const Property vfio_user_pci_properties[] = {
>       DEFINE_PROP_UINT32("x-pci-vendor-id", VFIOPCIDevice,
>                          vendor_id, PCI_ANY_ID),
>       DEFINE_PROP_UINT32("x-pci-device-id", VFIOPCIDevice,
> @@ -452,7 +452,7 @@ static void vfio_user_pci_class_init(ObjectClass *klass, const void *data)
>       PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
>   
>       device_class_set_legacy_reset(dc, vfio_user_pci_reset);
> -    device_class_set_props(dc, vfio_user_pci_dev_properties);
> +    device_class_set_props(dc, vfio_user_pci_properties);
>   
>       object_class_property_add(klass, "socket", "SocketAddress", NULL,
>                                 vfio_user_pci_set_socket, NULL, NULL);


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



