Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5232FC35FFF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 11:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvaAQ-0006R2-6V; Fri, 21 Mar 2025 07:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tva9w-0006JJ-Hx
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 07:03:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tva9s-0002Pz-Gm
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 07:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742555002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QHwAjZTPBxxKx9dKt3B//kqaeoWGGIRh8nmF3Z5vYqM=;
 b=g+IUF+rOObf5SgdZalA13BKVZE3JuErJxYnDHcSRvuxoUSTjU+LU6XpwDWugvYoqAtrBD8
 sehM2p27z/fTHglt+Gij4VOnConkA38clalVKKkGr/S/06yjAMUPetAxhcIFdtucItZkxP
 K0oycD/PAalNbPpZXIwtffxTcU4OB0w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-YMHiyfLnPOadsHlZucOozQ-1; Fri, 21 Mar 2025 07:03:21 -0400
X-MC-Unique: YMHiyfLnPOadsHlZucOozQ-1
X-Mimecast-MFC-AGG-ID: YMHiyfLnPOadsHlZucOozQ_1742555000
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cf172ff63so9567745e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 04:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742555000; x=1743159800;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QHwAjZTPBxxKx9dKt3B//kqaeoWGGIRh8nmF3Z5vYqM=;
 b=nAFGJnX8gdRQVle0p5S2fUgl4ixQwvD6cKu3Mg5MHwugklIeeTx33xb1aHjSGEuCL9
 +xWAj2CMR4f5etXTjlQ6DFzkk3kTbb2cff69l1dJDiwvl7k/mBUWaHC+lKt2WbCv8t9n
 1snwscW+xtSUBVxF6zEAt+zCFdWM2JTMD5NX/AIqYmcPfw7VIlPQ8ePFYEEEMn0ZyxdR
 oVWMTZYLdrX3Do6DUt2O9o9yWJekj81M9NqHWSN/eBlgL4z7CjjNJHsLhz3WiX/xntJj
 0hzA7lfpMOSETNrk7RUJuADJG9Zv/Eidlm1b9T5Aq/ZEZrj39rq++WAuu/BOSTW8xpH8
 O6yQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwYGwK51ZP38tXWE/gCtHbNk8S8UjyxivJLlmBGmhQHJ4BbXJ1e/SoINuu1rJdXsNp9QJyvldYmf8N@nongnu.org
X-Gm-Message-State: AOJu0YzF+RTEFhoerGiW1O+Fn42uXOHdMY/XJjt+W+3rq8eKrhK90kE6
 Bs4iHPJ2k4EVRx5BxSlw/CUqiauteFuJVOD5Mh+2B468uiJcbyDtWykmpbPa6rKUmAQknve+Plw
 o1/XMRxDkV2y0EH9vDrLjZSTfQRrpJNaXmsmRFQmQyt/73BIaaTTz
X-Gm-Gg: ASbGncvta01PAyOYxWfx0fiLSjTU8pJO/C9BOKI7eIv9Nlo655fOpuYPxYDcFIMmZCY
 mKrrXcO61lCTz5r13bhNjyQ9FXOOZf249hwQY6ntUR23TY4Bnw77iiJaQTaWbu9fy69Aez3SHUR
 AmYmB0vzN6ZDmQ0sLpt38l02Qf/oJlw/jA0ujx8A8EbBZp4ysEjU1GfNWiEAhHAm6wT4HsLWGwV
 y74JE5waM0g/AiRqW0U/DOF+ShEwlm+8V5lBOsdOZfGlfASDhjS7dXiekiK94xWnLkx/Cg7lUGA
 fUazo1BxZ3uWIk7e7J6PIUk7wS5mSuKKvMRXhVYDdovvnNjM3vmEQA==
X-Received: by 2002:a05:600c:c0b:b0:43d:ed:ad07 with SMTP id
 5b1f17b1804b1-43d50a3c7aamr28401485e9.29.1742554999372; 
 Fri, 21 Mar 2025 04:03:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeBo6mN+m2FUHJR8d/uQZ5ZscAKL5fre3431sX9VWYYHjLcGABdVqBptKuV2fYyOsnG+od5Q==
X-Received: by 2002:a05:600c:c0b:b0:43d:ed:ad07 with SMTP id
 5b1f17b1804b1-43d50a3c7aamr28400665e9.29.1742554998766; 
 Fri, 21 Mar 2025 04:03:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9957c3sm2126285f8f.18.2025.03.21.04.03.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 04:03:18 -0700 (PDT)
Message-ID: <726cc7ba-267c-435b-98a9-a0d177d11c0d@redhat.com>
Date: Fri, 21 Mar 2025 12:03:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 26/32] vfio: Rename vfio-common.h to vfio-device.h
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-27-clg@redhat.com>
 <6fb5efb1-5e61-4ac3-9cc0-d4ff40cd5f07@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <6fb5efb1-5e61-4ac3-9cc0-d4ff40cd5f07@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 3/19/25 15:27, Avihai Horon wrote:
> 
> On 18/03/2025 11:54, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> "hw/vfio/vfio-common.h" has been emptied of most of its declarations
>> by the previous changes and the only declarations left are related to
>> VFIODevice. Rename it to "hw/vfio/vfio-device.h" and make the
>> necessary adjustments.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/vfio/migration-multifd.h                      | 2 +-
>>   hw/vfio/pci.h                                    | 2 +-
>>   include/hw/s390x/vfio-ccw.h                      | 2 +-
>>   include/hw/vfio/{vfio-common.h => vfio-device.h} | 0
>>   include/hw/vfio/vfio-platform.h                  | 2 +-
>>   backends/iommufd.c                               | 2 +-
>>   hw/vfio/ap.c                                     | 2 +-
>>   hw/vfio/ccw.c                                    | 2 +-
>>   hw/vfio/container-base.c                         | 2 +-
>>   hw/vfio/container.c                              | 2 +-
>>   hw/vfio/cpr.c                                    | 2 +-
>>   hw/vfio/device.c                                 | 2 +-
>>   hw/vfio/dirty-tracking.c                         | 2 +-
>>   hw/vfio/helpers.c                                | 2 +-
>>   hw/vfio/iommufd.c                                | 2 +-
>>   hw/vfio/migration-multifd.c                      | 2 +-
>>   hw/vfio/migration.c                              | 2 +-
>>   hw/vfio/region.c                                 | 4 ++--
>>   18 files changed, 18 insertions(+), 18 deletions(-)
>>   rename include/hw/vfio/{vfio-common.h => vfio-device.h} (100%)
>>
>> diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
>> index a664051eb8ae03bc41cb7f9362ace840f41066ff..0bab63211d30cef04c50e50b3ea57840915ffc2a 100644
>> --- a/hw/vfio/migration-multifd.h
>> +++ b/hw/vfio/migration-multifd.h
>> @@ -12,7 +12,7 @@
>>   #ifndef HW_VFIO_MIGRATION_MULTIFD_H
>>   #define HW_VFIO_MIGRATION_MULTIFD_H
>>
>> -#include "hw/vfio/vfio-common.h"
>> +#include "hw/vfio/vfio-device.h"
>>
>>   bool vfio_multifd_setup(VFIODevice *vbasedev, bool alloc_multifd, Error **errp);
>>   void vfio_multifd_cleanup(VFIODevice *vbasedev);
>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index c84bba81487136d205ca30049c812d00e832c377..d33237c275551897164878705d44e7881c372ab0 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -14,7 +14,7 @@
>>
>>   #include "exec/memory.h"
>>   #include "hw/pci/pci_device.h"
>> -#include "hw/vfio/vfio-common.h"
>> +#include "hw/vfio/vfio-device.h"
>>   #include "qemu/event_notifier.h"
>>   #include "qemu/queue.h"
>>   #include "qemu/timer.h"
>> diff --git a/include/hw/s390x/vfio-ccw.h b/include/hw/s390x/vfio-ccw.h
>> index 4209d27657c1fbde44c160445396bcab3f3fd2b0..1e0922dca11e6caada08c2aae82bd3462ace35f5 100644
>> --- a/include/hw/s390x/vfio-ccw.h
>> +++ b/include/hw/s390x/vfio-ccw.h
>> @@ -14,7 +14,7 @@
>>   #ifndef HW_VFIO_CCW_H
>>   #define HW_VFIO_CCW_H
>>
>> -#include "hw/vfio/vfio-common.h"
>> +#include "hw/vfio/vfio-device.h"
>>   #include "hw/s390x/s390-ccw.h"
>>   #include "hw/s390x/ccw-device.h"
>>   #include "qom/object.h"
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-device.h
>> similarity index 100%
>> rename from include/hw/vfio/vfio-common.h
>> rename to include/hw/vfio/vfio-device.h
>> diff --git a/include/hw/vfio/vfio-platform.h b/include/hw/vfio/vfio-platform.h
>> index 3191545717da51abc41d10cd3646cd047b4a676c..256d8500b70a2e985e975b0895e3cfca435ed8ed 100644
>> --- a/include/hw/vfio/vfio-platform.h
>> +++ b/include/hw/vfio/vfio-platform.h
>> @@ -17,7 +17,7 @@
>>   #define HW_VFIO_VFIO_PLATFORM_H
>>
>>   #include "hw/sysbus.h"
>> -#include "hw/vfio/vfio-common.h"
>> +#include "hw/vfio/vfio-device.h"
>>   #include "qemu/event_notifier.h"
>>   #include "qemu/queue.h"
>>   #include "qom/object.h"
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index d57da44755be3d7fdba74f7dbecfe6d1c89921ba..9587e4d99b131e88674326a5196cfd2079560430 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -18,7 +18,7 @@
>>   #include "qemu/error-report.h"
>>   #include "monitor/monitor.h"
>>   #include "trace.h"
>> -#include "hw/vfio/vfio-common.h"
>> +#include "hw/vfio/vfio-device.h"
>>   #include <sys/ioctl.h>
>>   #include <linux/iommufd.h>
>>
>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>> index c7ab4ff57ada0ed0e5a76f52b5a05c86ca4fe0b4..4fdb74e33c427595a9b0a4d28b2b5a70df951e4e 100644
>> --- a/hw/vfio/ap.c
>> +++ b/hw/vfio/ap.c
>> @@ -15,7 +15,7 @@
>>   #include <linux/vfio.h>
>>   #include <sys/ioctl.h>
>>   #include "qapi/error.h"
>> -#include "hw/vfio/vfio-common.h"
>> +#include "hw/vfio/vfio-device.h"
>>   #include "system/iommufd.h"
>>   #include "hw/s390x/ap-device.h"
>>   #include "qemu/error-report.h"
>> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
>> index e5e0d9e3e7ed124f242b3eda345bc973e418a64c..a40169bc85e51406822247f5b3ef6da1f7f92881 100644
>> --- a/hw/vfio/ccw.c
>> +++ b/hw/vfio/ccw.c
>> @@ -21,7 +21,7 @@
>>   #include <sys/ioctl.h>
>>
>>   #include "qapi/error.h"
>> -#include "hw/vfio/vfio-common.h"
>> +#include "hw/vfio/vfio-device.h"
>>   #include "system/iommufd.h"
>>   #include "hw/s390x/s390-ccw.h"
>>   #include "hw/s390x/vfio-ccw.h"
>> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
>> index 83e83ab9e67de8b004dfaf0067e4c466a6c88451..ace9de18103e8c1ed9f7a51adbf16c36be01bd7c 100644
>> --- a/hw/vfio/container-base.c
>> +++ b/hw/vfio/container-base.c
>> @@ -15,7 +15,7 @@
>>   #include "qemu/error-report.h"
>>   #include "system/reset.h"
>>   #include "hw/vfio/vfio-container-base.h"
>> -#include "hw/vfio/vfio-common.h" /* for vfio_device_list */
>> +#include "hw/vfio/vfio-device.h" /* for vfio_device_list */
>>   #include "trace.h"
>>
>>   static QLIST_HEAD(, VFIOAddressSpace) vfio_address_spaces =
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index e88dfe12edd6dee469c06ee2e46ab9c8b5019ae7..e300d2d90f2fbde329609b7c63245c523766fb60 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -22,7 +22,7 @@
>>   #include <sys/ioctl.h>
>>   #include <linux/vfio.h>
>>
>> -#include "hw/vfio/vfio-common.h"
>> +#include "hw/vfio/vfio-device.h"
>>   #include "exec/address-spaces.h"
>>   #include "exec/memory.h"
>>   #include "exec/ram_addr.h"
>> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
>> index e1bba1726402f41ee394f25b6e613d27f44b2a2c..43b99680f6d7db27c4d7e518520aef5ade2ebcf4 100644
>> --- a/hw/vfio/cpr.c
>> +++ b/hw/vfio/cpr.c
>> @@ -6,7 +6,7 @@
>>    */
>>
>>   #include "qemu/osdep.h"
>> -#include "hw/vfio/vfio-common.h"
>> +#include "hw/vfio/vfio-device.h"
>>   #include "migration/misc.h"
>>   #include "qapi/error.h"
>>   #include "system/runstate.h"
>> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
>> index e6a1bbcda2297f9e6272fff9b1c228b6772457ce..0d443b53d23d392729cef84e419d3e089fe64298 100644
>> --- a/hw/vfio/device.c
>> +++ b/hw/vfio/device.c
>> @@ -22,7 +22,7 @@
>>   #include "qemu/osdep.h"
>>   #include <sys/ioctl.h>
>>
>> -#include "hw/vfio/vfio-common.h"
>> +#include "hw/vfio/vfio-device.h"
>>   #include "hw/vfio/pci.h"
>>   #include "hw/hw.h"
>>   #include "trace.h"
>> diff --git a/hw/vfio/dirty-tracking.c b/hw/vfio/dirty-tracking.c
>> index 447e09ed84993e3fbe1ed9b27a8269a9f0f46339..143cc5cf62b0165565e91f8a2ca166026f16b1eb 100644
>> --- a/hw/vfio/dirty-tracking.c
>> +++ b/hw/vfio/dirty-tracking.c
>> @@ -22,7 +22,7 @@
>>   #include <sys/ioctl.h>
>>   #include <linux/vfio.h>
>>
>> -#include "hw/vfio/vfio-common.h"
>> +#include "hw/vfio/vfio-device.h"
>>   #include "hw/vfio/pci.h"
>>   #include "exec/memory.h"
>>   #include "exec/ram_addr.h"
>> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
>> index e99d312a9f5c7462644ea3d0de2e9de38979f851..b7907aab80f8adb308ebae60baa20c911d9393d7 100644
>> --- a/hw/vfio/helpers.c
>> +++ b/hw/vfio/helpers.c
>> @@ -23,7 +23,7 @@
>>   #include <sys/ioctl.h>
>>
>>   #include "system/kvm.h"
>> -#include "hw/vfio/vfio-common.h"
>> +#include "hw/vfio/vfio-device.h"
>>   #include "hw/hw.h"
>>   #include "qapi/error.h"
>>   #include "helpers.h"
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 9335a17920b32dc2bf9cb4eeb2b8f57382f14ac8..7f354d86cd14270a70dc990860ad5b69f0310719 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -15,7 +15,7 @@
>>   #include <linux/vfio.h>
>>   #include <linux/iommufd.h>
>>
>> -#include "hw/vfio/vfio-common.h"
>> +#include "hw/vfio/vfio-device.h"
>>   #include "qemu/error-report.h"
>>   #include "trace.h"
>>   #include "qapi/error.h"
>> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
>> index 285f9a9a18dd8f0847ac5ac3fdaa304779a2d0db..1ba703e595db99f3786bfc1a2edeb0e061f9e01b 100644
>> --- a/hw/vfio/migration-multifd.c
>> +++ b/hw/vfio/migration-multifd.c
>> @@ -10,7 +10,7 @@
>>    */
>>
>>   #include "qemu/osdep.h"
>> -#include "hw/vfio/vfio-common.h"
>> +#include "hw/vfio/vfio-device.h"
>>   #include "hw/vfio/vfio-migration.h"
>>   #include "migration/misc.h"
>>   #include "qapi/error.h"
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 6fd825e435bde96d1008ec03dfaba25db3b616fc..338fafb83f41460e0c244dcc27524198322eec67 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -16,7 +16,7 @@
>>   #include <sys/ioctl.h>
>>
>>   #include "system/runstate.h"
>> -#include "hw/vfio/vfio-common.h"
>> +#include "hw/vfio/vfio-device.h"
>>   #include "hw/vfio/vfio-migration.h"
>>   #include "migration/misc.h"
>>   #include "migration/savevm.h"
>> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
>> index 87bf5e046a432dfedf3be3c1c7e8f33e006da004..ade4466eb622248b5aa50f9df7e5c683bfa78a11 100644
>> --- a/hw/vfio/region.c
>> +++ b/hw/vfio/region.c
>> @@ -22,8 +22,8 @@
>>   #include "qemu/osdep.h"
>>   #include <sys/ioctl.h>
>>
>> -#include "hw/vfio/vfio-common.h"
>> -#include "hw/vfio/pci.h"
>> +#include "hw/vfio/vfio-region.h"
> 
> Doesn't the above belong to patch #10?


maybe. I will check for v2.


Thanks,

C.


> Thanks.
> 
>> +#include "hw/vfio/vfio-device.h"
>>   #include "hw/hw.h"
>>   #include "trace.h"
>>   #include "qapi/error.h"
>> -- 
>> 2.48.1
>>
> 


