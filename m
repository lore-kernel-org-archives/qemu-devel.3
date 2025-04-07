Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10C3C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 06:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1gM3-0004F8-7V; Mon, 07 Apr 2025 02:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u1gLn-0004EP-MY
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 02:53:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u1gLk-0004fL-Rf
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 02:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744008770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Mj7Veh0oIrsRiqoOHjCgOYZv18qEG6kSZp2O6NDVnBw=;
 b=QQkc4oW86loPCchCAYiTdAGstm1tHwRlscHmtytziEWd478V2Qt5OV6UZRs6Xuw2OFFuZu
 Al8X6Z+8jg9aoJcWnqUBLVTHjPO5iHOd3tT8bzO4sB86RO8shDX0kaY7Sn3vDBkqi8Azwr
 5l/4jQflu7pZcU9cZyp2Sb1Dfud2utc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-eCyAZjQsMpOE4q9-x1DWNw-1; Mon, 07 Apr 2025 02:52:48 -0400
X-MC-Unique: eCyAZjQsMpOE4q9-x1DWNw-1
X-Mimecast-MFC-AGG-ID: eCyAZjQsMpOE4q9-x1DWNw_1744008767
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3912e4e2033so1771165f8f.0
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 23:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744008767; x=1744613567;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mj7Veh0oIrsRiqoOHjCgOYZv18qEG6kSZp2O6NDVnBw=;
 b=qYJ1OCT8C3r5xAb0JM8o8uB2LJluPlzkkmWp+hK7YeOFXznrAyHHQzR24bU8jjMDiI
 5XRmROYnJOLatM5bO1xMWJVyyXB0EdxK9B9RomGSj25r3kO8/SFPXHivEK8p5GYdqx4t
 oYD0WJwGndM+aSXFTv0HMbpCko7gHWTT66yMQsmV/zaWIkUdyzyeq5oMNnsmKK6yc1N1
 iHlVEGfV2g2cV82z9QlJ+kgBmhxWywVeUv/COT5pYonIihdXLUA9UgEnv3EV1mM/yp8B
 wZpO/NxP6SJONHjEpcD8Yyi6KA871hFVkyN8DRAv8UmNZjVxcRflcmoe19wNMAS/F3a+
 d0Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ6Ezr7b5qjT6PH4d53Ov4Bf0YXURNdDiGbKcU0Ewg19nLNQndlu66ipc1Bo+VTe3oUwI8cvA3Ikfr@nongnu.org
X-Gm-Message-State: AOJu0Yxx1iEEHR6/VW4DFglV7STeLuPPj8XXDoZzjgLhWuuSsp5aPNZB
 xRNNvSfY9M6XRYGiSdf2KnSns92uDo+e2eyIR3gwPvCtRNRKNvzILmc91LhT+DZQTB9VoVDIDcn
 xXORAiZjBe0663uOlb9Q/kyC+lU7cNb8ZkPU0LbApJ/tq9paxqtr0BbVK4Mc3
X-Gm-Gg: ASbGncsyMk4x+zj2bU2XkAFPymgfDszGg+cWNh2nB0G1VS0esKwTF2/KhMEev8vob5+
 6Kx9f1vu5JLaMoTH3EJMyy+rKpUaqj8ASawbFYuWs0QJC8bsrq4NJ5vlhTj8Zeoxl5vke1/F1xO
 IVcP2fufp42kcjrKCAqeL5tmZppsxN7ofeCZR5lvcQnimI9kjxKNLmYhVDwDhpOSKSvXfJ5cFr2
 0e+HUWJp2BNCyOjyYWGe+caKAyCEgiS81IfcfYQm7JsuK/qSqBRSE0HCTyXVX+Xy6mwU3S5E6A1
 XAhi+TxMKWG5nhpq4olad3Ea98dytPAFd5wT79+RFn32I08BqPEWgg==
X-Received: by 2002:a05:6000:1787:b0:39c:1f0a:ee0 with SMTP id
 ffacd0b85a97d-39cb3575da2mr10105105f8f.2.1744008766899; 
 Sun, 06 Apr 2025 23:52:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZmlvfl1FMEEjfc7mA/8l0m+5hKzmB69xzXrioKO/fKQBhXU16hflVdLSZrjN1/DHnBAtSWw==
X-Received: by 2002:a05:6000:1787:b0:39c:1f0a:ee0 with SMTP id
 ffacd0b85a97d-39cb3575da2mr10105077f8f.2.1744008766501; 
 Sun, 06 Apr 2025 23:52:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec17b18easm122715805e9.38.2025.04.06.23.52.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Apr 2025 23:52:46 -0700 (PDT)
Message-ID: <b0b5b230-4be8-4406-9ed2-978e9bcd4713@redhat.com>
Date: Mon, 7 Apr 2025 08:52:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 v2 11/37] vfio: Introduce new files for
 VFIORegion definitions and declarations
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 John Levon <john.levon@nutanix.com>, Joao Martins <joao.m.martins@oracle.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-12-clg@redhat.com>
 <SJ0PR11MB6744636C2266BA6A6837CB8D92A12@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSJDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+wsGRBBMBCAA7FiEEoPZlSPBIlev+awtgUaNDx8/7
 7KEFAmTLlVECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQUaNDx8/77KG0eg//
 S0zIzTcxkrwJ/9XgdcvVTnXLVF9V4/tZPfB7sCp8rpDCEseU6O0TkOVFoGWM39sEMiQBSvyY
 lHrP7p7E/JYQNNLh441MfaX8RJ5Ul3btluLapm8oHp/vbHKV2IhLcpNCfAqaQKdfk8yazYhh
 EdxTBlzxPcu+78uE5fF4wusmtutK0JG0sAgq0mHFZX7qKG6LIbdLdaQalZ8CCFMKUhLptW71
 xe+aNrn7hScBoOj2kTDRgf9CE7svmjGToJzUxgeh9mIkxAxTu7XU+8lmL28j2L5uNuDOq9vl
 hM30OT+pfHmyPLtLK8+GXfFDxjea5hZLF+2yolE/ATQFt9AmOmXC+YayrcO2ZvdnKExZS1o8
 VUKpZgRnkwMUUReaF/mTauRQGLuS4lDcI4DrARPyLGNbvYlpmJWnGRWCDguQ/LBPpbG7djoy
 k3NlvoeA757c4DgCzggViqLm0Bae320qEc6z9o0X0ePqSU2f7vcuWN49Uhox5kM5L86DzjEQ
 RHXndoJkeL8LmHx8DM+kx4aZt0zVfCHwmKTkSTQoAQakLpLte7tWXIio9ZKhUGPv/eHxXEoS
 0rOOAZ6np1U/xNR82QbF9qr9TrTVI3GtVe7Vxmff+qoSAxJiZQCo5kt0YlWwti2fFI4xvkOi
 V7lyhOA3+/3oRKpZYQ86Frlo61HU3r6d9wzOwU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhW
 pOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNLSoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZ
 KXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVUcP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwp
 bV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6
 TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFU
 CSLB2AE4wXQkJbApye48qnZ09zc929df5gU6hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iS
 YBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616dtb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6g
 LxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7
 JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1cOY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0Sdu
 jWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/Jx
 IqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k
 8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoXywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjK
 yKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9j
 hQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Tad2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yop
 s302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it+OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/p
 LHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1nHzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBU
 wYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVISl73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lU
 XOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfA
 HQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4PlsZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQ
 izDiU6iOrUzBThaMhZO3i927SG2DwWDVzZltKrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gD
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <SJ0PR11MB6744636C2266BA6A6837CB8D92A12@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.659,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 3/27/25 10:37, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: [PATCH for-10.1 v2 11/37] vfio: Introduce new files for VFIORegion
>> definitions and declarations
>>
>> Gather all VFIORegion related declarations and definitions into their
>> own files to reduce exposure of VFIO internals in "hw/vfio/vfio-common.h".
>> They were introduced for 'vfio-platform' support in commits
>> db0da029a185 ("vfio: Generalize region support") and a664477db8da
>> ("hw/vfio/pci: Introduce VFIORegion").
>>
>> To be noted that the 'vfio-platform' devices have been deprecated and
>> will be removed in QEMU 10.2. Until then, make the declarations
>> available externally for 'sysbus-fdt.c'.
>>
>> Cc: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>> hw/vfio/vfio-display.h          |   1 +
>> include/hw/vfio/vfio-common.h   |  32 +--
>> include/hw/vfio/vfio-platform.h |   2 +
>> include/hw/vfio/vfio-region.h   |  47 ++++
>> hw/core/sysbus-fdt.c            |   1 +
>> hw/vfio/helpers.c               | 363 -----------------------------
>> hw/vfio/pci-quirks.c            |   1 +
>> hw/vfio/pci.c                   |   1 +
>> hw/vfio/platform.c              |   1 +
>> hw/vfio/region.c                | 394 ++++++++++++++++++++++++++++++++
>> hw/vfio/meson.build             |   1 +
>> hw/vfio/trace-events            |  16 +-
>> 12 files changed, 459 insertions(+), 401 deletions(-)
>> create mode 100644 include/hw/vfio/vfio-region.h
>> create mode 100644 hw/vfio/region.c
>>
>> diff --git a/hw/vfio/vfio-display.h b/hw/vfio/vfio-display.h
>> index
>> 99b8cb67ef7558d3eefe3105a831e3fcb30afc4d..2606c34b396a88cec3e8f884adb
>> 158e48e8105f1 100644
>> --- a/hw/vfio/vfio-display.h
>> +++ b/hw/vfio/vfio-display.h
>> @@ -11,6 +11,7 @@
>>
>> #include "ui/console.h"
>> #include "hw/display/ramfb.h"
>> +#include "hw/vfio/vfio-region.h"
>>
>> typedef struct VFIODMABuf {
>>      QemuDmaBuf *buf;
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index
>> 8d48f5300a791d8858fe29d1bb905f814ef11990..3d470d79325526e0508683c445
>> a7635c78a57e34 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -39,25 +39,6 @@ enum {
>>      VFIO_DEVICE_TYPE_CCW = 2,
>>      VFIO_DEVICE_TYPE_AP = 3,
>> };
>> -
>> -typedef struct VFIOMmap {
>> -    MemoryRegion mem;
>> -    void *mmap;
>> -    off_t offset;
>> -    size_t size;
>> -} VFIOMmap;
>> -
>> -typedef struct VFIORegion {
>> -    struct VFIODevice *vbasedev;
>> -    off_t fd_offset; /* offset of region within device fd */
>> -    MemoryRegion *mem; /* slow, read/write access */
>> -    size_t size;
>> -    uint32_t flags; /* VFIO region flags (rd/wr/mmap) */
>> -    uint32_t nr_mmaps;
>> -    VFIOMmap *mmaps;
>> -    uint8_t nr; /* cache the region number for debug */
>> -} VFIORegion;
>> -
>> struct VFIOGroup;
>>
>> typedef struct VFIOContainer {
>> @@ -168,17 +149,7 @@ void vfio_unmask_single_irqindex(VFIODevice
>> *vbasedev, int index);
>> void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index);
>> bool vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
>>                              int action, int fd, Error **errp);
>> -void vfio_region_write(void *opaque, hwaddr addr,
>> -                           uint64_t data, unsigned size);
>> -uint64_t vfio_region_read(void *opaque,
>> -                          hwaddr addr, unsigned size);
>> -int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
>> -                      int index, const char *name);
>> -int vfio_region_mmap(VFIORegion *region);
>> -void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled);
>> -void vfio_region_unmap(VFIORegion *region);
>> -void vfio_region_exit(VFIORegion *region);
>> -void vfio_region_finalize(VFIORegion *region);
>> +
>> void vfio_reset_handler(void *opaque);
>> struct vfio_device_info *vfio_get_device_info(int fd);
>> bool vfio_device_is_mdev(VFIODevice *vbasedev);
>> @@ -194,7 +165,6 @@ int vfio_kvm_device_del_fd(int fd, Error **errp);
>> bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
>> void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
>>
>> -extern const MemoryRegionOps vfio_region_ops;
>> typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
>> typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
>> extern VFIOGroupList vfio_group_list;
>> diff --git a/include/hw/vfio/vfio-platform.h b/include/hw/vfio/vfio-platform.h
>> index
>> c414c3dffcc840a2f40a1b252d0f7b4e309c78d4..3191545717da51abc41d10cd364
>> 6cd047b4a676c 100644
>> --- a/include/hw/vfio/vfio-platform.h
>> +++ b/include/hw/vfio/vfio-platform.h
>> @@ -47,6 +47,8 @@ typedef struct VFIOINTp {
>> /* function type for user side eventfd handler */
>> typedef void (*eventfd_user_side_handler_t)(VFIOINTp *intp);
>>
>> +typedef struct VFIORegion VFIORegion;
>> +
>> struct VFIOPlatformDevice {
>>      SysBusDevice sbdev;
>>      VFIODevice vbasedev; /* not a QOM object */
>> diff --git a/include/hw/vfio/vfio-region.h b/include/hw/vfio/vfio-region.h
>> new file mode 100644
>> index
>> 0000000000000000000000000000000000000000..9dc0535e7ce46fbb671e70918
>> b93cb115857efe6
>> --- /dev/null
>> +++ b/include/hw/vfio/vfio-region.h
>> @@ -0,0 +1,47 @@
>> +/*
>> + * VFIO region
>> + *
>> + * Copyright Red Hat, Inc. 2025
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef HW_VFIO_REGION_H
>> +#define HW_VFIO_REGION_H
>> +
>> +#include "exec/memory.h"
>> +
>> +typedef struct VFIOMmap {
>> +    MemoryRegion mem;
>> +    void *mmap;
>> +    off_t offset;
>> +    size_t size;
>> +} VFIOMmap;
>> +
>> +typedef struct VFIODevice VFIODevice;
>> +
>> +typedef struct VFIORegion {
>> +    struct VFIODevice *vbasedev;
>> +    off_t fd_offset; /* offset of region within device fd */
>> +    MemoryRegion *mem; /* slow, read/write access */
>> +    size_t size;
>> +    uint32_t flags; /* VFIO region flags (rd/wr/mmap) */
>> +    uint32_t nr_mmaps;
>> +    VFIOMmap *mmaps;
>> +    uint8_t nr; /* cache the region number for debug */
>> +} VFIORegion;
>> +
>> +
>> +void vfio_region_write(void *opaque, hwaddr addr,
>> +                           uint64_t data, unsigned size);
>> +uint64_t vfio_region_read(void *opaque,
>> +                          hwaddr addr, unsigned size);
>> +int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
>> +                      int index, const char *name);
>> +int vfio_region_mmap(VFIORegion *region);
>> +void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled);
>> +void vfio_region_unmap(VFIORegion *region);
>> +void vfio_region_exit(VFIORegion *region);
>> +void vfio_region_finalize(VFIORegion *region);
>> +
>> +#endif /* HW_VFIO_REGION_H */
>> diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
>> index
>> e85066b905637b1ca34b5965f383df341f3a4eb7..c339a27875cbee8131b064674a
>> a09adf4b9efa25 100644
>> --- a/hw/core/sysbus-fdt.c
>> +++ b/hw/core/sysbus-fdt.c
>> @@ -35,6 +35,7 @@
>> #include "hw/vfio/vfio-platform.h"
>> #include "hw/vfio/vfio-calxeda-xgmac.h"
>> #include "hw/vfio/vfio-amd-xgbe.h"
>> +#include "hw/vfio/vfio-region.h"
>> #include "hw/display/ramfb.h"
>> #include "hw/uefi/var-service-api.h"
>> #include "hw/arm/fdt.h"
>> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
>> index
>> 4b255d4f3a9e81f55df00c68fc71da769fd5bd04..89403943a7a219e491b6812d50b
>> 27b7f1fd7b4a4 100644
>> --- a/hw/vfio/helpers.c
>> +++ b/hw/vfio/helpers.c
>> @@ -147,118 +147,6 @@ bool vfio_set_irq_signaling(VFIODevice *vbasedev, int
>> index, int subindex,
>>      return false;
>> }
>>
>> -/*
>> - * IO Port/MMIO - Beware of the endians, VFIO is always little endian
>> - */
>> -void vfio_region_write(void *opaque, hwaddr addr,
>> -                       uint64_t data, unsigned size)
>> -{
>> -    VFIORegion *region = opaque;
>> -    VFIODevice *vbasedev = region->vbasedev;
>> -    union {
>> -        uint8_t byte;
>> -        uint16_t word;
>> -        uint32_t dword;
>> -        uint64_t qword;
>> -    } buf;
>> -
>> -    switch (size) {
>> -    case 1:
>> -        buf.byte = data;
>> -        break;
>> -    case 2:
>> -        buf.word = cpu_to_le16(data);
>> -        break;
>> -    case 4:
>> -        buf.dword = cpu_to_le32(data);
>> -        break;
>> -    case 8:
>> -        buf.qword = cpu_to_le64(data);
>> -        break;
>> -    default:
>> -        hw_error("vfio: unsupported write size, %u bytes", size);
>> -        break;
>> -    }
>> -
>> -    if (pwrite(vbasedev->fd, &buf, size, region->fd_offset + addr) != size) {
>> -        error_report("%s(%s:region%d+0x%"HWADDR_PRIx", 0x%"PRIx64
>> -                     ",%d) failed: %m",
>> -                     __func__, vbasedev->name, region->nr,
>> -                     addr, data, size);
>> -    }
>> -
>> -    trace_vfio_region_write(vbasedev->name, region->nr, addr, data, size);
>> -
>> -    /*
>> -     * A read or write to a BAR always signals an INTx EOI.  This will
>> -     * do nothing if not pending (including not in INTx mode).  We assume
>> -     * that a BAR access is in response to an interrupt and that BAR
>> -     * accesses will service the interrupt.  Unfortunately, we don't know
>> -     * which access will service the interrupt, so we're potentially
>> -     * getting quite a few host interrupts per guest interrupt.
>> -     */
>> -    vbasedev->ops->vfio_eoi(vbasedev);
>> -}
>> -
>> -uint64_t vfio_region_read(void *opaque,
>> -                          hwaddr addr, unsigned size)
>> -{
>> -    VFIORegion *region = opaque;
>> -    VFIODevice *vbasedev = region->vbasedev;
>> -    union {
>> -        uint8_t byte;
>> -        uint16_t word;
>> -        uint32_t dword;
>> -        uint64_t qword;
>> -    } buf;
>> -    uint64_t data = 0;
>> -
>> -    if (pread(vbasedev->fd, &buf, size, region->fd_offset + addr) != size) {
>> -        error_report("%s(%s:region%d+0x%"HWADDR_PRIx", %d) failed: %m",
>> -                     __func__, vbasedev->name, region->nr,
>> -                     addr, size);
>> -        return (uint64_t)-1;
>> -    }
>> -    switch (size) {
>> -    case 1:
>> -        data = buf.byte;
>> -        break;
>> -    case 2:
>> -        data = le16_to_cpu(buf.word);
>> -        break;
>> -    case 4:
>> -        data = le32_to_cpu(buf.dword);
>> -        break;
>> -    case 8:
>> -        data = le64_to_cpu(buf.qword);
>> -        break;
>> -    default:
>> -        hw_error("vfio: unsupported read size, %u bytes", size);
>> -        break;
>> -    }
>> -
>> -    trace_vfio_region_read(vbasedev->name, region->nr, addr, size, data);
>> -
>> -    /* Same as write above */
>> -    vbasedev->ops->vfio_eoi(vbasedev);
>> -
>> -    return data;
>> -}
>> -
>> -const MemoryRegionOps vfio_region_ops = {
>> -    .read = vfio_region_read,
>> -    .write = vfio_region_write,
>> -    .endianness = DEVICE_LITTLE_ENDIAN,
>> -    .valid = {
>> -        .min_access_size = 1,
>> -        .max_access_size = 8,
>> -    },
>> -    .impl = {
>> -        .min_access_size = 1,
>> -        .max_access_size = 8,
>> -    },
>> -};
>> -
>> int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size)
>> {
>>      vbmap->pages = REAL_HOST_PAGE_ALIGN(size) / qemu_real_host_page_size();
>> @@ -306,257 +194,6 @@ vfio_get_device_info_cap(struct vfio_device_info
>> *info, uint16_t id)
>>      return vfio_get_cap((void *)info, info->cap_offset, id);
>> }
>>
>> -static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
>> -                                          struct vfio_region_info *info)
>> -{
>> -    struct vfio_info_cap_header *hdr;
>> -    struct vfio_region_info_cap_sparse_mmap *sparse;
>> -    int i, j;
>> -
>> -    hdr = vfio_get_region_info_cap(info,
>> VFIO_REGION_INFO_CAP_SPARSE_MMAP);
>> -    if (!hdr) {
>> -        return -ENODEV;
>> -    }
>> -
>> -    sparse = container_of(hdr, struct vfio_region_info_cap_sparse_mmap,
>> header);
>> -
>> -    trace_vfio_region_sparse_mmap_header(region->vbasedev->name,
>> -                                         region->nr, sparse->nr_areas);
>> -
>> -    region->mmaps = g_new0(VFIOMmap, sparse->nr_areas);
>> -
>> -    for (i = 0, j = 0; i < sparse->nr_areas; i++) {
>> -        if (sparse->areas[i].size) {
>> -            trace_vfio_region_sparse_mmap_entry(i, sparse->areas[i].offset,
>> -                                            sparse->areas[i].offset +
>> -                                            sparse->areas[i].size - 1);
>> -            region->mmaps[j].offset = sparse->areas[i].offset;
>> -            region->mmaps[j].size = sparse->areas[i].size;
>> -            j++;
>> -        }
>> -    }
>> -
>> -    region->nr_mmaps = j;
>> -    region->mmaps = g_realloc(region->mmaps, j * sizeof(VFIOMmap));
>> -
>> -    return 0;
>> -}
>> -
>> -int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
>> -                      int index, const char *name)
>> -{
>> -    g_autofree struct vfio_region_info *info = NULL;
>> -    int ret;
>> -
>> -    ret = vfio_get_region_info(vbasedev, index, &info);
>> -    if (ret) {
>> -        return ret;
>> -    }
>> -
>> -    region->vbasedev = vbasedev;
>> -    region->flags = info->flags;
>> -    region->size = info->size;
>> -    region->fd_offset = info->offset;
>> -    region->nr = index;
>> -
>> -    if (region->size) {
>> -        region->mem = g_new0(MemoryRegion, 1);
>> -        memory_region_init_io(region->mem, obj, &vfio_region_ops,
>> -                              region, name, region->size);
>> -
>> -        if (!vbasedev->no_mmap &&
>> -            region->flags & VFIO_REGION_INFO_FLAG_MMAP) {
>> -
>> -            ret = vfio_setup_region_sparse_mmaps(region, info);
>> -
>> -            if (ret) {
>> -                region->nr_mmaps = 1;
>> -                region->mmaps = g_new0(VFIOMmap, region->nr_mmaps);
>> -                region->mmaps[0].offset = 0;
>> -                region->mmaps[0].size = region->size;
>> -            }
>> -        }
>> -    }
>> -
>> -    trace_vfio_region_setup(vbasedev->name, index, name,
>> -                            region->flags, region->fd_offset, region->size);
>> -    return 0;
>> -}
>> -
>> -static void vfio_subregion_unmap(VFIORegion *region, int index)
>> -{
>> -    trace_vfio_region_unmap(memory_region_name(&region-
>>> mmaps[index].mem),
>> -                            region->mmaps[index].offset,
>> -                            region->mmaps[index].offset +
>> -                            region->mmaps[index].size - 1);
>> -    memory_region_del_subregion(region->mem, &region->mmaps[index].mem);
>> -    munmap(region->mmaps[index].mmap, region->mmaps[index].size);
>> -    object_unparent(OBJECT(&region->mmaps[index].mem));
>> -    region->mmaps[index].mmap = NULL;
>> -}
>> -
>> -int vfio_region_mmap(VFIORegion *region)
>> -{
>> -    int i, ret, prot = 0;
>> -    char *name;
>> -
>> -    if (!region->mem) {
>> -        return 0;
>> -    }
>> -
>> -    prot |= region->flags & VFIO_REGION_INFO_FLAG_READ ? PROT_READ : 0;
>> -    prot |= region->flags & VFIO_REGION_INFO_FLAG_WRITE ? PROT_WRITE : 0;
>> -
>> -    for (i = 0; i < region->nr_mmaps; i++) {
>> -        size_t align = MIN(1ULL << ctz64(region->mmaps[i].size), 1 * GiB);
>> -        void *map_base, *map_align;
>> -
>> -        /*
>> -         * Align the mmap for more efficient mapping in the kernel.  Ideally
>> -         * we'd know the PMD and PUD mapping sizes to use as discrete alignment
>> -         * intervals, but we don't.  As of Linux v6.12, the largest PUD size
>> -         * supporting huge pfnmap is 1GiB (ARCH_SUPPORTS_PUD_PFNMAP is only
>> set
>> -         * on x86_64).  Align by power-of-two size, capped at 1GiB.
>> -         *
>> -         * NB. qemu_memalign() and friends actually allocate memory, whereas
>> -         * the region size here can exceed host memory, therefore we manually
>> -         * create an oversized anonymous mapping and clean it up for alignment.
>> -         */
>> -        map_base = mmap(0, region->mmaps[i].size + align, PROT_NONE,
>> -                        MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>> -        if (map_base == MAP_FAILED) {
>> -            ret = -errno;
>> -            goto no_mmap;
>> -        }
>> -
>> -        map_align = (void *)ROUND_UP((uintptr_t)map_base, (uintptr_t)align);
>> -        munmap(map_base, map_align - map_base);
>> -        munmap(map_align + region->mmaps[i].size,
>> -               align - (map_align - map_base));
>> -
>> -        region->mmaps[i].mmap = mmap(map_align, region->mmaps[i].size, prot,
>> -                                     MAP_SHARED | MAP_FIXED,
>> -                                     region->vbasedev->fd,
>> -                                     region->fd_offset +
>> -                                     region->mmaps[i].offset);
>> -        if (region->mmaps[i].mmap == MAP_FAILED) {
>> -            ret = -errno;
>> -            goto no_mmap;
>> -        }
>> -
>> -        name = g_strdup_printf("%s mmaps[%d]",
>> -                               memory_region_name(region->mem), i);
>> -        memory_region_init_ram_device_ptr(&region->mmaps[i].mem,
>> -                                          memory_region_owner(region->mem),
>> -                                          name, region->mmaps[i].size,
>> -                                          region->mmaps[i].mmap);
>> -        g_free(name);
>> -        memory_region_add_subregion(region->mem, region->mmaps[i].offset,
>> -                                    &region->mmaps[i].mem);
>> -
>> -        trace_vfio_region_mmap(memory_region_name(&region->mmaps[i].mem),
>> -                               region->mmaps[i].offset,
>> -                               region->mmaps[i].offset +
>> -                               region->mmaps[i].size - 1);
>> -    }
>> -
>> -    return 0;
>> -
>> -no_mmap:
>> -    trace_vfio_region_mmap_fault(memory_region_name(region->mem), i,
>> -                                 region->fd_offset + region->mmaps[i].offset,
>> -                                 region->fd_offset + region->mmaps[i].offset +
>> -                                 region->mmaps[i].size - 1, ret);
>> -
>> -    region->mmaps[i].mmap = NULL;
>> -
>> -    for (i--; i >= 0; i--) {
>> -        vfio_subregion_unmap(region, i);
>> -    }
>> -
>> -    return ret;
>> -}
>> -
>> -void vfio_region_unmap(VFIORegion *region)
>> -{
>> -    int i;
>> -
>> -    if (!region->mem) {
>> -        return;
>> -    }
>> -
>> -    for (i = 0; i < region->nr_mmaps; i++) {
>> -        if (region->mmaps[i].mmap) {
>> -            vfio_subregion_unmap(region, i);
>> -        }
>> -    }
>> -}
>> -
>> -void vfio_region_exit(VFIORegion *region)
>> -{
>> -    int i;
>> -
>> -    if (!region->mem) {
>> -        return;
>> -    }
>> -
>> -    for (i = 0; i < region->nr_mmaps; i++) {
>> -        if (region->mmaps[i].mmap) {
>> -            memory_region_del_subregion(region->mem, &region->mmaps[i].mem);
>> -        }
>> -    }
>> -
>> -    trace_vfio_region_exit(region->vbasedev->name, region->nr);
>> -}
>> -
>> -void vfio_region_finalize(VFIORegion *region)
>> -{
>> -    int i;
>> -
>> -    if (!region->mem) {
>> -        return;
>> -    }
>> -
>> -    for (i = 0; i < region->nr_mmaps; i++) {
>> -        if (region->mmaps[i].mmap) {
>> -            munmap(region->mmaps[i].mmap, region->mmaps[i].size);
>> -            object_unparent(OBJECT(&region->mmaps[i].mem));
>> -        }
>> -    }
>> -
>> -    object_unparent(OBJECT(region->mem));
>> -
>> -    g_free(region->mem);
>> -    g_free(region->mmaps);
>> -
>> -    trace_vfio_region_finalize(region->vbasedev->name, region->nr);
>> -
>> -    region->mem = NULL;
>> -    region->mmaps = NULL;
>> -    region->nr_mmaps = 0;
>> -    region->size = 0;
>> -    region->flags = 0;
>> -    region->nr = 0;
>> -}
>> -
>> -void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled)
>> -{
>> -    int i;
>> -
>> -    if (!region->mem) {
>> -        return;
>> -    }
>> -
>> -    for (i = 0; i < region->nr_mmaps; i++) {
>> -        if (region->mmaps[i].mmap) {
>> -            memory_region_set_enabled(&region->mmaps[i].mem, enabled);
>> -        }
>> -    }
>> -
>> -    trace_vfio_region_mmaps_set_enabled(memory_region_name(region->mem),
>> -                                        enabled);
>> -}
>> -
>> int vfio_get_region_info(VFIODevice *vbasedev, int index,
>>                           struct vfio_region_info **info)
>> {
>> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
>> index
>> 3f002252acfb7ac809107c99bdbdbaf66d56a50d..4591ec68da877b307f43ea1a83
>> 0c315721b57e9e 100644
>> --- a/hw/vfio/pci-quirks.c
>> +++ b/hw/vfio/pci-quirks.c
>> @@ -26,6 +26,7 @@
>> #include "hw/qdev-properties.h"
>> #include "pci.h"
>> #include "pci-quirks.h"
>> +#include "hw/vfio/vfio-region.h"
> 
> This looks unnecessary as pci.h already include it,

It doesn't but it should. I will include "hw/vfio/vfio-region.h"
in "pci.h" and remove it from  "pci-quirks.c" and "pci.c" instead.


Thanks,

C.


  
>> #include "trace.h"
>>
>> /*
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index
>> 158deca06cb240622a254f5059c47873e5fcc7de..7457e81cdb07bc6657bb151434
>> 9c172a152cb540 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -45,6 +45,7 @@
>> #include "migration/qemu-file.h"
>> #include "system/iommufd.h"
>> #include "vfio-migration-internal.h"
>> +#include "hw/vfio/vfio-region.h"
> 
>
> Same here, otherwise
> 
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> 
> Thanks
> Zhenzhong
> 


