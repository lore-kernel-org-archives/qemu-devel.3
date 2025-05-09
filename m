Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6931BC3ABCA
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 10:25:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDKuV-0005r6-0C; Fri, 09 May 2025 06:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDKuN-0005qj-DL
 for qemu-devel@nongnu.org; Fri, 09 May 2025 06:24:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDKuL-0003No-Ad
 for qemu-devel@nongnu.org; Fri, 09 May 2025 06:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746786284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+ag56/h52vegOk9uwi262TPfIrt+lXhnC8IbBYJxWf0=;
 b=ZNtNKQ9uoxwaRouTYbbtAPXZJq7mbUjJ81crsJHRka+SXhPpKmH6NeNDDsSxeVMnzUbB/U
 FqjUIQpM/a6C9isjze9KzfAbpZOnLxLhWIcFdZwAoowj0kaCm2JQT7lZrwElM4VzNutyzh
 aoAtlhYPonh/KNDDrf3msdskS2oQtqU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-kpEFb22cPvuSChGeng-SPg-1; Fri, 09 May 2025 06:24:43 -0400
X-MC-Unique: kpEFb22cPvuSChGeng-SPg-1
X-Mimecast-MFC-AGG-ID: kpEFb22cPvuSChGeng-SPg_1746786282
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a0b589a2c6so825623f8f.0
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 03:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746786282; x=1747391082;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ag56/h52vegOk9uwi262TPfIrt+lXhnC8IbBYJxWf0=;
 b=v727dmi4MVKwumcrGARZfJhuCkUqzhNgc3kMyze70JlMteXlRllr/UFJ2cs5lCua+j
 Iq3/uqV1UOmPEFTczEkIdH6Af+ZL5QNNpXjcq3M24LkkejrpBEsHkG9AGvYLJkAkhL92
 oWlmfgdMiQJQQtnjkWKpWv7jnaiEr3CLAgurCccA1UgGt9zvxpmGVQamKzaS63UUrglr
 2waVSK+92zLW8YY259OTY6QTu+hdMA3wMB+dcCbHprpnG7lazNcAqAtAALvWxnPpO9ht
 Bx8KKRKC4egNa7iRPyNFaBBbm4sxE7gEtDFrloYU4zHh0OHsSTBTpOrTOBbNiNapnFTl
 kNNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWa/CRWS9jc76WmyjnI58+CtpC9s8RQAM/cFFPL3mxvJx28N7e6o52cAn0euhiP/7BXeAhVDlNe8ny@nongnu.org
X-Gm-Message-State: AOJu0YzNEOrMSeJdKqOT6bocb2hr0EhMwBVrVU9i0RMU67GVRfc6vCpH
 rSf9oe9/nbE6SxCWbkzLvpI/oqw2qN76Jc8CBHwdx1IJGYZJ2c+grHEZGOXZ57EH9gAQwxnkjuL
 LIXxsT1rrzvkQiWARHcYIcORM3Ks3kGK2WJPiNnbja57OwZaYKBhj
X-Gm-Gg: ASbGncs5tWM4BNXY3wiEd5WZdOO1aExLY1TNDZBqAG2fzQLD16kmuZKU7iHDRfW85eI
 1+y2t0xhsJITqOmOOr0xX9nqS5k4HVfSQ7NTZNJe3iBi1liBrExXIiY3QacFh0l3TaH2kPV2Osb
 Fxtb1qB4yLSRA/hecB+mSdrt5igt0W0lktrsZIh/1YdZtTYgCeEUhT8thJZB1u5m/2Ca58RECqB
 CT5KQNkp+yap/KjuuMyNEw6i249lNvG5gG17A8o5MPkRsWVsZrPtyXevoMIycfI7i1AjHFewlJ/
 4AALy2P6PGGJxHgJt2TFgk7iu7wD/3k1RPq72HbAzh0z5OClfcHIMIqP
X-Received: by 2002:a05:6000:2410:b0:3a0:b930:b370 with SMTP id
 ffacd0b85a97d-3a1f643cef8mr2398807f8f.28.1746786281773; 
 Fri, 09 May 2025 03:24:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJQ9Q44R9LXZIe2FX6xaU/ZU3CKtixjANIWhyI2bFbhNqupxx47gHDuA3EV+M0/5f+Ky9vRw==
X-Received: by 2002:a05:6000:2410:b0:3a0:b930:b370 with SMTP id
 ffacd0b85a97d-3a1f643cef8mr2398777f8f.28.1746786281400; 
 Fri, 09 May 2025 03:24:41 -0700 (PDT)
Received: from ?IPV6:2a01:cb1d:89d7:6e00:da58:edc2:d8ef:4b9f?
 ([2a01:cb1d:89d7:6e00:da58:edc2:d8ef:4b9f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f57ddfd6sm2777235f8f.4.2025.05.09.03.24.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 03:24:40 -0700 (PDT)
Message-ID: <92196d3c-4bb5-4b88-9d8b-38f2c7ebb385@redhat.com>
Date: Fri, 9 May 2025 12:24:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/15] vfio: preparation for vfio-user
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, Jason Herne <jjherne@linux.ibm.com>
References: <20250507152020.1254632-1-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250507152020.1254632-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
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

On 5/7/25 17:20, John Levon wrote:
> Hi, this series is against the vfio-next tree:
> https://github.com/legoater/qemu/commits/vfio-next
> 
> The series contains patches to vfio to prepare for the vfio-user
> implementation. A previous version of these patches can be found at
> https://patchew.org/QEMU/20250430194003.2793823-1-john.levon@nutanix.com/
> 
> The changes have been rebased on vfio-next, and include changes from previous
> series code review comments.
> 
> An old version of the full vfio-user series can be found at
> https://lore.kernel.org/all/7dd34008-e0f1-4eed-a77e-55b1f68fbe69@redhat.com/T/
> ("[PATCH v8 00/28] vfio-user client"). Please see that series for justification
> and context.
> 
> thanks
> john
> 
> John Levon (15):
>    vfio: add vfio_device_prepare()
>    vfio: add vfio_device_unprepare()
>    vfio: add vfio_attach_device_by_iommu_type()
>    vfio: add vfio_device_get_irq_info() helper
>    vfio: consistently handle return value for helpers
>    vfio: add strread/writeerror()
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
>   hw/vfio/pci.h                         |  10 +-
>   include/hw/vfio/vfio-container-base.h |  21 ++-
>   include/hw/vfio/vfio-device.h         |  82 ++++++++
>   include/system/memory.h               |   4 +-
>   hw/vfio/ap.c                          |  19 +-
>   hw/vfio/ccw.c                         |  25 ++-
>   hw/vfio/container-base.c              |  14 +-
>   hw/vfio/container.c                   |  62 ++++---
>   hw/vfio/device.c                      | 183 ++++++++++++++++--
>   hw/vfio/igd.c                         |  10 +-
>   hw/vfio/iommufd.c                     |  35 ++--
>   hw/vfio/listener.c                    |  82 +++++---
>   hw/vfio/pci.c                         | 257 ++++++++++++++++----------
>   hw/vfio/platform.c                    |   6 +-
>   hw/vfio/region.c                      |  19 +-
>   hw/virtio/vhost-vdpa.c                |   2 +-
>   system/memory.c                       |   7 +-
>   17 files changed, 603 insertions(+), 235 deletions(-)
> 

I am waiting for an update of patch 12 to apply 01-14 to vfio-next.

patch 15 should be addressed independently.

Thanks,

C.



