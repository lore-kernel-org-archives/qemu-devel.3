Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6359CC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 12:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBvIN-00080c-A8; Mon, 05 May 2025 08:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBvIK-00080J-Iu
 for qemu-devel@nongnu.org; Mon, 05 May 2025 08:51:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBvII-0006u8-AO
 for qemu-devel@nongnu.org; Mon, 05 May 2025 08:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746449497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OxyDiQJ5I5H2do/VyJM55TDBiZhxPow7pX9jouwjFbU=;
 b=NIkSsF+6w3l45+tjS+YgasUVEkGgXi4lSHk/0VE70aRAlVUZuYRejZgH8v8qu8O5u3jcpV
 9zp6KTgM3kOjg66QqQxydBfD7GnLXy+U7pqaHJkDPaK6SsCj3OltiFrCsg7dAOjfci9THH
 uMQcDLk6pR3PZqE8zS8HeHxQVPnwPAQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-0Q2tR9FyPnixSQCOQu2trQ-1; Mon, 05 May 2025 08:51:35 -0400
X-MC-Unique: 0Q2tR9FyPnixSQCOQu2trQ-1
X-Mimecast-MFC-AGG-ID: 0Q2tR9FyPnixSQCOQu2trQ_1746449495
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cf44b66f7so24091055e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 05:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746449494; x=1747054294;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OxyDiQJ5I5H2do/VyJM55TDBiZhxPow7pX9jouwjFbU=;
 b=Pn0byN8l0prww9sN3VO6fJQYfkt4jEmZyXdyJ/W0zkPAaEfXsYmWU/aWns+AhJpDqe
 ceJgEY9KWDmVV8qody89B4rwRcHnuzaE7jUBJNpBHxRBmN+9kl+r8Sr0FvXaBFqCAIti
 BRPinq7W8PpdZIID1AvOEkTKAzLOrUyUqvktaA2V98lIbrDMU2/9eomu/7XMrOeb4+6p
 VO+UlYUPYPOwgqsVxXyDEyl/UK3Duf14jsCl54yFGz4VppWNWONRv6Cs1bbpWq8kw5Lb
 Jar8Zu9EFzb9XdJhzLGBPiVl5VoNggKK86bgSgzf2ExuEv653InohYEmBInNmZFsktug
 yHNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX21qxO10nkrPtdBmEWVK+a2aIbQJ5jGKa9EL2qnQ86+AHNsqdQTTTChs36SXnVeXaQZLe3xWVhrO87@nongnu.org
X-Gm-Message-State: AOJu0Yx7xOt9M+1373gyOqKN4LSEBzq8+8og+TEb1AvOLFX/yOIhruxL
 /TRmOW17a/6FRYS6X9+Kxl00v2aqb8OwaLUTB3cTUwuF2mjWUuIt25Sa7hvJEOq/57t7vprTHPY
 YaHnO5SATYh8Bp20rYQ37I+4Un1c9yH0VeJ/V2KCEsMsukvD61YIp
X-Gm-Gg: ASbGncvfTiDsB0W3lU5yy3p4jI8HiKc/ni9f1owtd0s9ao2SWtHAK2Rn/ssk24gsvH1
 3bEBYbGhrhJI8ToaroOzAFhQ1DCQEqqMhF4NXaa90zdU/NBMmUx9SZW9HZ8I52wJsKLcYz1ziEF
 Yyu0RTuJwEKed1e3nyrsfsedphexwSIwXLXtW2aUyiUXNZZzvpAW0xCAROFKAiZE6YHeY4n5DFW
 XqwpctcdUxp05PHI0zQT3u6lAwLL3T0KVpHFSf2TGa7i/u6zsR0DGTRwZ6IYCD9w4iOU7IsiPLy
 IAPn3C4I+tCtMSR+UNffKwNWvJ0p7FopIaLBDm+E6wds9QIRFg==
X-Received: by 2002:a05:600c:4508:b0:43d:209:21fd with SMTP id
 5b1f17b1804b1-441c1d73992mr72388655e9.30.1746449494715; 
 Mon, 05 May 2025 05:51:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUmPOt6SL7v247NgobRlVzO3tOrAXTnfRVhK8b4Ur3lfuippLsPkpg9jzYvIqfTjAJOApaQg==
X-Received: by 2002:a05:600c:4508:b0:43d:209:21fd with SMTP id
 5b1f17b1804b1-441c1d73992mr72388415e9.30.1746449494375; 
 Mon, 05 May 2025 05:51:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441ae456d7dsm124609275e9.1.2025.05.05.05.51.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 05:51:33 -0700 (PDT)
Message-ID: <a29b50e7-1364-4f57-ac31-9827ffddef06@redhat.com>
Date: Mon, 5 May 2025 14:51:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] vfio: preparation for vfio-user
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Tony Krowiak
 <akrowiak@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
References: <20250430194003.2793823-1-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250430194003.2793823-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

Hello John,

On 4/30/25 21:39, John Levon wrote:
> Hi, this series is against the vfio-next tree:
> https://github.com/legoater/qemu/commits/vfio-next
> 
> The series contains patches to vfio to prepare for the vfio-user
> implementation. A previous version of these patches can be found at
> https://lore.kernel.org/all/20250409134814.478903-1-john.levon@nutanix.com/
> 
> The changes have been rebased on vfio-next, and include changes from previous
> series code review comments.
> 
> An old version of the full vfio-user series can be found at
> https://lore.kernel.org/all/7dd34008-e0f1-4eed-a77e-55b1f68fbe69@redhat.com/T/
> ("[PATCH v8 00/28] vfio-user client"). Please see that series for justification
> and context.

We are nearly there. Please address the little issues in v3, the
build breakage being the most important. Last patch is not under
the VFIO jurisdiction though.


Thanks,

C.






  
> thanks
> john
> 
> John Levon (15):
>    vfio: add vfio_prepare_device()
>    vfio: add vfio_unprepare_device()
>    vfio: add vfio_attach_device_by_iommu_type()
>    vfio: add vfio_device_get_irq_info() helper
>    vfio: consistently handle return value for helpers
>    include/qemu: add strread/writeerror()
>    vfio: add vfio_pci_config_space_read/write()
>    vfio: add unmap_all flag to DMA unmap callback
>    vfio: implement unmap all for DMA unmap callbacks
>    vfio: add device IO ops vector
>    vfio: add region info cache
>    vfio: add read/write to device IO ops vector
>    vfio: add vfio-pci-base class
>    vfio/container: pass listener_begin/commit callbacks
>    vfio/container: pass MemoryRegion to DMA operations
> 
>   hw/vfio/ap.c                          |  19 +-
>   hw/vfio/ccw.c                         |  25 ++-
>   hw/vfio/container-base.c              |  14 +-
>   hw/vfio/container.c                   |  66 ++++---
>   hw/vfio/device.c                      | 192 +++++++++++++++++--
>   hw/vfio/igd.c                         |   8 +-
>   hw/vfio/iommufd.c                     |  35 ++--
>   hw/vfio/listener.c                    |  82 +++++---
>   hw/vfio/pci.c                         | 257 ++++++++++++++++----------
>   hw/vfio/pci.h                         |  12 +-
>   hw/vfio/platform.c                    |   6 +-
>   hw/vfio/region.c                      |  19 +-
>   hw/virtio/vhost-vdpa.c                |   2 +-
>   include/hw/vfio/vfio-container-base.h |  10 +-
>   include/hw/vfio/vfio-device.h         |  67 +++++++
>   include/qemu/error-report.h           |  14 ++
>   include/system/memory.h               |   4 +-
>   system/memory.c                       |   7 +-
>   18 files changed, 604 insertions(+), 235 deletions(-)
> 


