Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C95C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Dz1-0003s3-QQ; Fri, 25 Apr 2025 04:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Dyc-0003jp-TU
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:00:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8DyV-00063e-G6
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745567994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/xfgKUgN1P4+ut2TtJRTae9Hux6WGWMdzq+xPSpOUG0=;
 b=GSoV7f7kP8AsnZBq2SkU4WykXAMZVfIXqagy85roE5pkg7uqx2xteRQ+xPOl0RXBCDAjFk
 5OYTA6pO/W9pxbdAseHaFZRdOcicwUmBiSWEFCWUOKKLgARB/q192KhOGEG6ELuTuLyZFL
 NTj5GE3Gqbu+bc+s6dRnCawBJHvO3CE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-1IpFAuLMPZCews_O-L9k-w-1; Fri, 25 Apr 2025 03:59:52 -0400
X-MC-Unique: 1IpFAuLMPZCews_O-L9k-w-1
X-Mimecast-MFC-AGG-ID: 1IpFAuLMPZCews_O-L9k-w_1745567991
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cfda30a3cso10268015e9.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 00:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745567990; x=1746172790;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/xfgKUgN1P4+ut2TtJRTae9Hux6WGWMdzq+xPSpOUG0=;
 b=FUH+Ze8WmFZ0FCY+YhtGMGYaOJwtBY7RTwe4SpJtpb1VxXbcE+lBc1jYbZSGYMHzaw
 /PsRC4WRNYJxfrEgvr4JtWTW0L5r9me5r2lINHo+7Du4Vh2yg4kKkHHj0DeIJczv3+aH
 IAFllNbkYZKp0kj1afFGanMD2cbY+ynw69i6ltnyf4bDmoTa/I4pabE4bar4t6hOpWaY
 yXL1mK2jNMW9mvPeIt07akKYltvUdi1mHOsangu0YgJZ6b9Z3GGbK8+yrDDSIMiHO5ze
 EXa+xVwOkq3VfTCjcEOvtMUIh5YYDajRgurZfKv23/eGOwo6/DYaCm5Wt50PAW4RDFBG
 h6Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq0R5Tv7iDUN8XUpIGdJazUnI/N6+cw6YN7wlWvvEGP904qEKiH3hJ6DIMcCojQdIGeg0sAmTVfBR/@nongnu.org
X-Gm-Message-State: AOJu0YzwO4fSquZUIl8ivJ8Eehv7xhELz5liTomvIHKG/L1YNg+KzCcg
 rVOkkCK8h+JNkq9cYGbmRyUPCJzMHXm39yXx38QYRN7lQTu01afTQdLlSzaDpDblnuO6WoOYvTT
 sKJG48WuIctUAJykGVdIdm8DGuWMoA4D2NGiMaRS0yVjhAbZy3KeR
X-Gm-Gg: ASbGncs/6/x6fcAZrZeoXT2vh6yT/SNi+OvT6w2xrtgvkWor9UgvGZ4sdMmUHx2naON
 VIYsdd1iHOWKWoa65rCLFwaicQFPacNzv34YPCFA5WMglHjFARJrvgXz1IhiC+7iFJRoDLLfnrc
 j4MRNXt1lDpzsl2Xdu9xEnYBhNVjRW+KwqGpHJ7ZCkARBD8v1SXxTTE3jybkfDm2Zx1KuJdPcOW
 aKQxyNiyGDYs6gMpGpccsokcIZpLl9tXiD4lvMBj+FyC08y7K6p1w2oReSSfexq2Ku7Q/POWm+T
 OyhV2XiaSU61e4lz/Nx5JxleTGaghDmJ85HZbTJiDJPrmuA=
X-Received: by 2002:a05:6000:248a:b0:391:49f6:dad4 with SMTP id
 ffacd0b85a97d-3a074f3aa1fmr889306f8f.41.1745567990555; 
 Fri, 25 Apr 2025 00:59:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdvOazJv4ApAt3lTPEHSqgpTzAVKfE55eTQalUVa7ybpq2GyOXbpt6ROk0vDsu5vrUKITX5g==
X-Received: by 2002:a05:6000:248a:b0:391:49f6:dad4 with SMTP id
 ffacd0b85a97d-3a074f3aa1fmr889284f8f.41.1745567990131; 
 Fri, 25 Apr 2025 00:59:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8d1a5sm1630953f8f.13.2025.04.25.00.59.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 00:59:49 -0700 (PDT)
Message-ID: <9960fee7-3261-49aa-9174-a683a2345e94@redhat.com>
Date: Fri, 25 Apr 2025 09:59:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] vfio: preparation for vfio-user
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>
References: <20250409134814.478903-1-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250409134814.478903-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/9/25 15:48, John Levon wrote:
> Hi, this series is based on Cédric Le Goater's vfio cleanup series:
> https://github.com/legoater/qemu/commits/vfio-10.1
> 
> The series contains patches to vfio to prepare for the vfio-user
> implementation. A previous version of these patches can be found at
> https://lore.kernel.org/all/7dd34008-e0f1-4eed-a77e-55b1f68fbe69@redhat.com/T/
> ("[PATCH v8 00/28] vfio-user client"); roughly corresponding to patches 1-10.
> 
> Please see that series for justification and context.
> 
> The following changes have been made since the previous series:
> 
>   - rebased on top of vfio-10.1 cleanup series
>   - split unmap all patch into two, fixed some nits, dropped unmap all detection
>   - fix two vfio_interrupt_setup() cleanup bugs
>   - various renames as per review
>   - new vfio_device_get_irq_info()
>   - split out device ops patch into smaller chunks
>   - region cache renames for clarity
>   - commit author corrected for several patches
> 
> thanks
> john
> 
> John Levon (14):
>    vfio: refactor out vfio_interrupt_setup()
>    vfio: refactor out vfio_pci_config_setup()
>    vfio: add vfio_prepare_device()
>    vfio: add vfio_attach_device_by_iommu_type()
>    vfio/container: pass listener_begin/commit callbacks
>    vfio: add flags parameter to DMA unmap callback
>    vfio: specify VFIO_DMA_UNMAP_FLAG_ALL to callback
>    vfio: add vfio-pci-base class
>    vfio: add vfio_device_get_irq_info() helper
>    vfio: consistently handle return value for helpers
>    vfio: add vfio_pci_config_space_read/write()
>    vfio: add region info cache
>    vfio: add device IO ops vector
>    vfio/container: pass MemoryRegion to DMA operations
> 
>   hw/vfio/ap.c                          |  21 +-
>   hw/vfio/ccw.c                         |  27 +-
>   hw/vfio/container-base.c              |  14 +-
>   hw/vfio/container.c                   |  74 ++-
>   hw/vfio/device.c                      | 178 ++++++-
>   hw/vfio/igd.c                         |   8 +-
>   hw/vfio/iommufd.c                     |  35 +-
>   hw/vfio/listener.c                    |  82 ++--
>   hw/vfio/pci.c                         | 672 +++++++++++++++-----------
>   hw/vfio/pci.h                         |  12 +-
>   hw/vfio/platform.c                    |   8 +-
>   hw/vfio/region.c                      |  19 +-
>   hw/virtio/vhost-vdpa.c                |   2 +-
>   include/exec/memory.h                 |   4 +-
>   include/hw/vfio/vfio-container-base.h |  10 +-
>   include/hw/vfio/vfio-device.h         |  34 +-
>   system/memory.c                       |   7 +-
>   17 files changed, 784 insertions(+), 423 deletions(-)
> 

Applied patch 1,2 to vfio-next.

Thanks,

C.



