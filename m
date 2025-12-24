Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9394EE74916
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 11:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYMvr-0005ji-Jg; Wed, 24 Dec 2025 06:21:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vYMvq-0005jW-0M
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 06:21:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vYMvo-0007xj-4L
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 06:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766575285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FoJrvKNvXSjo3hL0j+4DD+vxUI2nQYAH4ZvRIuDbNzg=;
 b=AHUuk2RjgaM9RK8T/dUhbFXbCkRGv4uWL+FJewv36qWWbuo2YJJV8JZHwQlWoE6KRjNVpT
 v615HfTIVeCC8I2tPPuB3VJ8Ni5Yg4BkWaLiR+ZQ2bMIP0P+Ap7nV47lWLUBG3Xe6NSBDl
 59tpRKQqI122w7NksZEdw1gI3L8n1cY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-Mj-3zV27M6eL6mIp7zfCCw-1; Wed, 24 Dec 2025 06:21:23 -0500
X-MC-Unique: Mj-3zV27M6eL6mIp7zfCCw-1
X-Mimecast-MFC-AGG-ID: Mj-3zV27M6eL6mIp7zfCCw_1766575282
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-432488a0ce8so4856593f8f.2
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 03:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766575282; x=1767180082; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=FoJrvKNvXSjo3hL0j+4DD+vxUI2nQYAH4ZvRIuDbNzg=;
 b=TL/ol/iLSiKLTLWkH5DY9ufFsdcVmIO5pLYigC3o1YbQVGme2WerFysfsc+JX0h9Kg
 dqHnsURCsQIO8662BWt2sQ8M84/hU6u826tjBHw8VDqXeUQEIL7zuFaPkQnHQpchgJzS
 AX7HYsf4+G4dzChjv1lP5Xnj0VRhvdPLnTTkMqWFh6HJRob+/+ZUH/ydUAGwGYrbLHgB
 k6VKxer0sbNP7xVLPDE+Waouz1lD5E913ea3GjKanzoULd/RhDeWZOAnYJKdOkdnFacp
 LtdvwED+wtq1WckSerdeyJZmByE2+4EvRHo17pWovkSWDXkmxc/sX+MpXVbWeN0xmHT0
 ogFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766575282; x=1767180082;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FoJrvKNvXSjo3hL0j+4DD+vxUI2nQYAH4ZvRIuDbNzg=;
 b=dcehl6cOtkZhbnbOjMBJnFXG3HyF28vPFmFtQZPg5JCb8sqT7WLWKbuZRxJQjvBAW2
 B6WftMatki8RFtwPs4wNJUkFGy5qvxqHwy8veX1zDjaOSwRo+tRdpFKEMUkxYkqqqjyV
 uo1XmBAt/kjVq7TPx77F3hoaHp8qzf3CvIyCMxbIa/+MALgZO4bNjMtuPiKvrA4Mng21
 KIZmqgS6Ut5/MHmCIDApMv5JJQZ2fd67XugsvMj1at1ciE5n8J2idwBFWXvA6VQajvI5
 QtwMKtnL7XkSmodQOIPEhGSa5BQHdb3uO9Z1rYdcSAyO/jyRTkX/FhBMVYnMYlyzhLVC
 nczQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/3hYucbbPYl4b6BPo7FvKvPdoSHYqdlzbGipBfgXsj77Y7i1AmlMVOqZV9i480dw9ZjhCkFnvKzNa@nongnu.org
X-Gm-Message-State: AOJu0Yzyb9426xdzZuPIsq67FETo+IACwHYYOQmoUKfJ4dZrR8lz8l4c
 8bVoyiwconmqM45rxz2yUHRrNuhnHHU9hCtmMMJQ8+sFJnVd2OO4OgT8epv9/NneuhFC4SwQp1B
 lJ3vq5Ory8M9CBGV0YU1itn/q8DDh8KwowllzMZhERAkywSTfCnRvO2Ay
X-Gm-Gg: AY/fxX5qFZAkEQPnfmDMYki95YHC1ehlbFgZ4MbMSsxp9fIc7feqBIHy1JYKgYWYiKT
 nsL0gB711D4L6UpcD6QZlQKqmUIT50VDVgv9rYlIw5GWWX11AhuybefWHMgIlSQFClWGFqMdewB
 /ldmpjkPyofe3QsUF73fEEouFJzZLeNFm7vEPO7lnMF3AkGRcZK3USrx0azz41JFg7k7eN5i3/i
 RH9jE73Bj6/voahey3Ip+Y1s2/oaXWkLSDJCOG8d7IraFXAXyYxWEwQQNb97hZXGH/EUAc0yqR7
 Agvf4+Zry6TEU65kY0lTOIIB59G6qBlDqNs5TOrJ2XEBUxr4Xm3cAG4ssAQjIIly/wN7ITmdzCN
 Y9f2E+3OGga5Mph7j15+aYWwYLXX6YKi+ZAfZVxZ9GL/bqg==
X-Received: by 2002:a05:600c:848d:b0:479:3a87:208f with SMTP id
 5b1f17b1804b1-47d38848706mr48614535e9.36.1766575282422; 
 Wed, 24 Dec 2025 03:21:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvbG2ME5d8jpX+DavdgrlaxZHCnAr+/U1ZKxnHKQlip71/vWyU8K8ocBREK/GjHZP2EJUYVA==
X-Received: by 2002:a05:600c:848d:b0:479:3a87:208f with SMTP id
 5b1f17b1804b1-47d38848706mr48614335e9.36.1766575282024; 
 Wed, 24 Dec 2025 03:21:22 -0800 (PST)
Received: from ?IPV6:2a01:e0a:165:d60:107a:63db:9521:6057?
 ([2a01:e0a:165:d60:107a:63db:9521:6057])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be273f147sm351425235e9.7.2025.12.24.03.21.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Dec 2025 03:21:21 -0800 (PST)
Message-ID: <dc8b4613-46ba-406a-aeb3-24542df48e77@redhat.com>
Date: Wed, 24 Dec 2025 12:21:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per region
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex@shazbot.org" <alex@shazbot.org>, "cohuck@redhat.com"
 <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "kjaju@nvidia.com" <kjaju@nvidia.com>
References: <20251222135357.143339-1-skolothumtho@nvidia.com>
 <20251222135357.143339-4-skolothumtho@nvidia.com>
 <CH3PR11MB717754BE949E8270DC18A8F0F8B5A@CH3PR11MB7177.namprd11.prod.outlook.com>
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
In-Reply-To: <CH3PR11MB717754BE949E8270DC18A8F0F8B5A@CH3PR11MB7177.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Vivek,

On 12/23/25 21:43, Kasireddy, Vivek wrote:
> Hi Shameer, Cedric,
> 
>> Subject: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per region
>>
>> From: Nicolin Chen <nicolinc@nvidia.com>
>>
>> Linux now provides a VFIO dmabuf exporter to expose PCI BAR memory for
>> P2P
>> use cases. Create a dmabuf for each mapped BAR region after the mmap is
>> set
>> up, and store the returned fd in the region's RAMBlock. This allows QEMU
>> to
>> pass the fd to dma_map_file(), enabling iommufd to import the dmabuf and
>> map
>> the BAR correctly in the host IOMMU page table.
>>
>> If the kernel lacks support or dmabuf setup fails, QEMU skips the setup
>> and continues with normal mmap handling.
>>
>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>> ---
>>   hw/vfio/region.c     | 57
>> +++++++++++++++++++++++++++++++++++++++++++-
>>   hw/vfio/trace-events |  1 +
>>   2 files changed, 57 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
>> index b165ab0b93..6949f6779c 100644
>> --- a/hw/vfio/region.c
>> +++ b/hw/vfio/region.c
>> @@ -29,6 +29,7 @@
>>   #include "qemu/error-report.h"
>>   #include "qemu/units.h"
>>   #include "monitor/monitor.h"
>> +#include "system/ramblock.h"
>>   #include "vfio-helpers.h"
>>
>>   /*
>> @@ -238,13 +239,52 @@ static void vfio_subregion_unmap(VFIORegion
>> *region, int index)
>>       region->mmaps[index].mmap = NULL;
>>   }
>>
>> +static int vfio_region_create_dma_buf(VFIORegion *region)
> Would it make sense to consolidate this implementation with the one from my
> series: https://lore.kernel.org/qemu-devel/20251122064936.2948632-7-vivek.kasireddy@intel.com/
> so that it is a bit more generic and can also be invoked from outside of VFIO?

I would prefer to start by the generic dmabuf support in VFIO, as
it covers multiple use cases. Then, we can look at virtio-gpu.

> Or, is it ok to have two dmabuf implementations: one that is internal to VFIO
> and takes a VFIORegion as input like this one and another one that takes a
> VFIODevice and iovec as input and can be invoked externally?
May be this approach can be revisited a bit ? I haven't looked yet.

Thanks,

C.


