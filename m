Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76522C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 12:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDN7F-00087o-Oa; Fri, 09 May 2025 08:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDN7B-00085D-8C
 for qemu-devel@nongnu.org; Fri, 09 May 2025 08:46:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDN75-0003sd-TS
 for qemu-devel@nongnu.org; Fri, 09 May 2025 08:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746794761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fChnALSaFqHti4F3734hR0MDlT/yCQA31mCMPT4g30o=;
 b=adgEVFuMsP5Hcnd59iLi0gMfHsIkolpEoW2Z4M7tBzq0SNLUDiFYyO14EusABE4UcWkdAW
 rca11cdmDlm5o2Kq8o4OMxLDjM4VaduWf7rBe3slOwyvKkPwjVCQ1VZ2UhgWRDBPqC6vrG
 um/Wtv5fBUi+rCcpxb9yFyEMW49mb4s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-Xv9arZdPMA21GQZls3r9sA-1; Fri, 09 May 2025 08:46:00 -0400
X-MC-Unique: Xv9arZdPMA21GQZls3r9sA-1
X-Mimecast-MFC-AGG-ID: Xv9arZdPMA21GQZls3r9sA_1746794759
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43eea5a5d80so11895115e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 05:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746794759; x=1747399559;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fChnALSaFqHti4F3734hR0MDlT/yCQA31mCMPT4g30o=;
 b=LZAwkWoWwtp3lsehrscCBhGDtGUFtsbaqV8kBUzstYZUhXFji1PDXoZOTk9DrMZg/L
 rATnbg0lQy9LnTSKqPJO/wd9dHkUCY4GEj4EoerqqW4gSFBMUlb37P+mMQfHuLV3Je//
 DswAIQWrSWyNSeNoPwnTeOxtqc5Kbr4xjy8jv61pbURRrspM1lqUbEE7X4Ih4bgU8TR1
 qOTsHN9y5N0XMFRuuu83rskG1BiM8pQ/9pnzeQ/8Q3i+2ZM6ONdcbE7Lj9L+qUpXr2RY
 YPvCXvnVujjEzpEMSVPExtk25B7TX9Hw+8EoKNItpmCseTml2LmGqWIt4JxrOuucqgyk
 pnCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNXH3BfWLR1mzu0g5jPfPpcRaCkIXTu5+BSaJS8z/vuRoZji0ePTbgYjGXqgzlS+0UuWQw2xLLUUSC@nongnu.org
X-Gm-Message-State: AOJu0YxDLtsQV8daSTjuO6mgEFWiX9SOxuVPHvoqvA9anWLMcNtw/owa
 /xHzaPvv1kC849oaMOaiO/Zec3OobD4aLWjnKfT1gjyUPiCLVZg5Q8XL1XnY0rpPAxYiGhlJNie
 uqZT3C+LWK+UedgqcbQAr5wqiEhhoP9sGFuyiD/V19OFf8oYTKLQ5
X-Gm-Gg: ASbGncsw3z6TlfWs+1Z85Z9cmqtFFK96PnXcx/xUt1Z0AMwY8DVp7cYYmDdviUElEZH
 d9VKynZR9NKQzm9ZMtC9woQDwOJxaJs8lH13B+lFjpjEMTLMpN56JQZcDMGqeUkr24UYBDJnVtR
 jl2U7oP1fFSqm+y80v/qL+JCGp3UU2hfUMGvIclPEBzPVgQA6unLxsAy89p7SGHb6bUd5mK6CH4
 sw0h7rIzmY1E+vKKbe5yA/n4acaVbTucISP1O4CJL11Sx+ra2Zp/nuayvIqmnCstLs0kTsZXitk
 lm0ytSsZVbdmMMwPO8YEvuv4NzoV5dGx5sWcPQ46OYSx5lcLYXJRvNU=
X-Received: by 2002:a05:600c:528b:b0:43d:2230:303b with SMTP id
 5b1f17b1804b1-442d6dd1e0emr23080905e9.20.1746794758965; 
 Fri, 09 May 2025 05:45:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgIpEx29Tip7fldnqNqk5MkSBk9IC6WmjJhISY3xEjb84fIrAyYY9zLwI4Kgg10feGTsHzeQ==
X-Received: by 2002:a05:600c:528b:b0:43d:2230:303b with SMTP id
 5b1f17b1804b1-442d6dd1e0emr23080635e9.20.1746794758477; 
 Fri, 09 May 2025 05:45:58 -0700 (PDT)
Received: from ?IPV6:2a01:cb1d:89d7:6e00:da58:edc2:d8ef:4b9f?
 ([2a01:cb1d:89d7:6e00:da58:edc2:d8ef:4b9f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58ebec4sm3209488f8f.36.2025.05.09.05.45.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 05:45:57 -0700 (PDT)
Message-ID: <a8f7fbec-c9c3-4d25-9480-fbf380528768@redhat.com>
Date: Fri, 9 May 2025 14:45:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/15] vfio: preparation for vfio-user
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
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
 <92196d3c-4bb5-4b88-9d8b-38f2c7ebb385@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <92196d3c-4bb5-4b88-9d8b-38f2c7ebb385@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/9/25 12:24, Cédric Le Goater wrote:
> On 5/7/25 17:20, John Levon wrote:
>> Hi, this series is against the vfio-next tree:
>> https://github.com/legoater/qemu/commits/vfio-next
>>
>> The series contains patches to vfio to prepare for the vfio-user
>> implementation. A previous version of these patches can be found at
>> https://patchew.org/QEMU/20250430194003.2793823-1-john.levon@nutanix.com/
>>
>> The changes have been rebased on vfio-next, and include changes from previous
>> series code review comments.
>>
>> An old version of the full vfio-user series can be found at
>> https://lore.kernel.org/all/7dd34008-e0f1-4eed-a77e-55b1f68fbe69@redhat.com/T/
>> ("[PATCH v8 00/28] vfio-user client"). Please see that series for justification
>> and context.
>>
>> thanks
>> john
>>
>> John Levon (15):
>>    vfio: add vfio_device_prepare()
>>    vfio: add vfio_device_unprepare()
>>    vfio: add vfio_attach_device_by_iommu_type()
>>    vfio: add vfio_device_get_irq_info() helper
>>    vfio: consistently handle return value for helpers
>>    vfio: add strread/writeerror()
>>    vfio: add vfio_pci_config_space_read/write()
>>    vfio: add unmap_all flag to DMA unmap callback
>>    vfio: implement unmap all for DMA unmap callbacks
>>    vfio: add device IO ops vector
>>    vfio: add region info cache
>>    vfio: add read/write to device IO ops vector
>>    vfio: add vfio-pci-base class
>>    vfio/container: pass listener_begin/commit callbacks
>>    vfio/container: pass MemoryRegion to DMA operations
>>
>>   hw/vfio/pci.h                         |  10 +-
>>   include/hw/vfio/vfio-container-base.h |  21 ++-
>>   include/hw/vfio/vfio-device.h         |  82 ++++++++
>>   include/system/memory.h               |   4 +-
>>   hw/vfio/ap.c                          |  19 +-
>>   hw/vfio/ccw.c                         |  25 ++-
>>   hw/vfio/container-base.c              |  14 +-
>>   hw/vfio/container.c                   |  62 ++++---
>>   hw/vfio/device.c                      | 183 ++++++++++++++++--
>>   hw/vfio/igd.c                         |  10 +-
>>   hw/vfio/iommufd.c                     |  35 ++--
>>   hw/vfio/listener.c                    |  82 +++++---
>>   hw/vfio/pci.c                         | 257 ++++++++++++++++----------
>>   hw/vfio/platform.c                    |   6 +-
>>   hw/vfio/region.c                      |  19 +-
>>   hw/virtio/vhost-vdpa.c                |   2 +-
>>   system/memory.c                       |   7 +-
>>   17 files changed, 603 insertions(+), 235 deletions(-)
>>
> 
> I am waiting for an update of patch 12 to apply 01-14 to vfio-next.
Applied 01-14 to vfio-next.

Thanks,

C.



