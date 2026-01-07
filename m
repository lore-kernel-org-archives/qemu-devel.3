Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DC9CFD642
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 14:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdUmj-00089n-5M; Wed, 07 Jan 2026 09:45:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdUmc-0007zQ-O2
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 09:45:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdUmX-0008Tc-7x
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 09:45:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767797098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AzB7XoVN1TUuDZzussjt1YJxJ6imjp9OohtehNqhbj4=;
 b=QX/KmIa7GVbdnWhaACIfRkywy764bBmLIVpTiVWJkQHpp0QVnQC7GXzJS0XOtSvDrHvLT6
 APzMFyOwMCUG3zSJZwDeEi64owhvc3lEgBOUa8SC46w1U7MASQ5IhuRfPI7CLaRiwBA97W
 73DR+I/FEKSjC9k7Iym/TVLY+UmOP84=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-IUFEXgM6MCC946Cu12z8eg-1; Wed, 07 Jan 2026 09:44:56 -0500
X-MC-Unique: IUFEXgM6MCC946Cu12z8eg-1
X-Mimecast-MFC-AGG-ID: IUFEXgM6MCC946Cu12z8eg_1767797095
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4779edba8f3so20306685e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 06:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767797095; x=1768401895; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=AzB7XoVN1TUuDZzussjt1YJxJ6imjp9OohtehNqhbj4=;
 b=l+59lQtEJhksgETff9F5inco07Zk6dBIalpyHZMOivpHM6yx6voKwxH3X27Zv0H51n
 tvrjdCYAswHT3JNkW+yryw+tOj4t0Cx3tITK06jytyC/9yzSXBMv3N9S9wkaUyy+Sy3E
 +rb/4VpSoRVcplVWQo81lsWp5gRa4Uu2DA7zRAORk9bb/JoabnuSd/onVnhHmipgHpuj
 spVJjeiMIVSSw+D9177rVOcmvtlRPTVIsZHGzOSPuQuiloOoBtNtzC7dUAV+a6XOSizK
 TG4xDDYJNKmpXt4QxrlRn9G+ZI14OO8KsLzPSJPrz9dSps8cTrLxTgNenDPlf4FGg6mu
 xxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767797095; x=1768401895;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AzB7XoVN1TUuDZzussjt1YJxJ6imjp9OohtehNqhbj4=;
 b=Nafmagi/vrxRdjNbB31ev06K/HVW4mo6GWtN75XMw8M/q9GPlcUywIfAV7iVs69QVe
 LzhoTgvz33k6cV/vrEjpv1gp6ypPZVanxWpmz5dQE/4/1T2yGRcWCNhkp7d6nXd1zI1S
 d8/OEbClj59wuK/QsFXEdsH1y/uwh1bJh2I+h5yuTFq25Gn8M9ldNHTu+bA7r2BycGkw
 J5QRXJCmdGC6IniY7YwTsND8EsL88m74p9zYDVJRl5PICfcSg37eToIOq6APZT/wTkAg
 y6uj5BjEZf200keVHB29fJbSMsOIDKMMqHI7LPjDjDnQdoFpCHQJ0dDNxKdJQ/wgTC9+
 uBPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgGN+A6f0elUqBZyNw+A7GuCE7XHH3NDjj8oTDknJDrbp3QgVQORvp7fv0/Mho/bJzEGcpBA0L4ILw@nongnu.org
X-Gm-Message-State: AOJu0Yw3kCGnSkF1vDqrmn8jAptykvhklthKjIFioamHb0qvqrM/vqmU
 cPNpGg6t0o5+unAZbDXOroQlrDb8Ledm4soeiThU+p5DOGFBCwmPXw4jwRwlTFB1GdP7cWIINUg
 fNHVNOS0oPD16GarruxwjA1gjeimRFCjsg0+AxN++u+OYlqC1jWBZo75j
X-Gm-Gg: AY/fxX7OnfOU7mGBbdOUg1Gte8hoKrNocdKBmiaJ14AIGYCnLL36Up3BmBfNNnptv2a
 PI0W/y20yhvyxE280MC7FAUSE4BkGuoGEBj/q19Xi00/bGh40kBsIVh/5qdwhXONdCXJ2jh+CEH
 ls7a74XSTPyZc7Ba/029ul0DLtOmgfreVgfmY99v9uKmM2O9VjvApRdkyKUq5DldogJ7ThNjH00
 9l2rTp4oH/OIIYgfg7qEB+CRVMJ1TLl6CEqoTG+jj8lg2fZLWQOuy3GiL3yTO10Doq8TvacvCQ0
 DNpazflnyysoM+A5YhSm0a03pZbToXg52zVq1crdxOFAnj999FJMc7QuIdfxKcwHhtYhwogpOhO
 LeYdNB+r+0jFcKBR3ep+oaY5L0pxa4BOLYlQ=
X-Received: by 2002:a05:600c:190e:b0:477:7c7d:d9b7 with SMTP id
 5b1f17b1804b1-47d84b4099amr35250515e9.33.1767797095137; 
 Wed, 07 Jan 2026 06:44:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZrcqwr3LvAyaUQOo65QtHjSQCT9JRW+WjdTW8uzRUZsNlvISWPEyecREctFDez0vkl2pGtw==
X-Received: by 2002:a05:600c:190e:b0:477:7c7d:d9b7 with SMTP id
 5b1f17b1804b1-47d84b4099amr35250035e9.33.1767797094635; 
 Wed, 07 Jan 2026 06:44:54 -0800 (PST)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f4184e1sm100639185e9.4.2026.01.07.06.44.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 06:44:54 -0800 (PST)
Message-ID: <386824c5-d0f9-4384-a4de-d2ff5a3445d7@redhat.com>
Date: Wed, 7 Jan 2026 15:44:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] pc-bios/s390-ccw: Add support for virtio-blk-pci IPL
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20251210205449.2783111-1-jrossi@linux.ibm.com>
 <20251210205449.2783111-8-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <20251210205449.2783111-8-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 10/12/2025 21.54, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Enable virt-queue PCI configuration and add routines for virtio-blk-pci devices.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   include/hw/s390x/ipl/qipl.h      |  10 +
>   pc-bios/s390-ccw/virtio-pci.h    |  79 +++++++
>   pc-bios/s390-ccw/virtio.h        |   1 +
>   pc-bios/s390-ccw/main.c          |  60 +++++-
>   pc-bios/s390-ccw/virtio-blkdev.c |   3 +
>   pc-bios/s390-ccw/virtio-pci.c    | 360 +++++++++++++++++++++++++++++++
>   pc-bios/s390-ccw/virtio.c        |   5 +
>   pc-bios/s390-ccw/Makefile        |   2 +-
>   8 files changed, 517 insertions(+), 3 deletions(-)
>   create mode 100644 pc-bios/s390-ccw/virtio-pci.h
>   create mode 100644 pc-bios/s390-ccw/virtio-pci.c
> 
> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
> index 8199b839f0..5c7779a1c3 100644
> --- a/include/hw/s390x/ipl/qipl.h
> +++ b/include/hw/s390x/ipl/qipl.h
> @@ -22,6 +22,7 @@
>   
>   #define S390_IPL_TYPE_FCP 0x00
>   #define S390_IPL_TYPE_CCW 0x02
> +#define S390_IPL_TYPE_PCI 0x04
>   #define S390_IPL_TYPE_PV 0x05
>   #define S390_IPL_TYPE_QEMU_SCSI 0xff
>   
> @@ -105,6 +106,14 @@ struct IplBlockQemuScsi {
>   } QEMU_PACKED;
>   typedef struct IplBlockQemuScsi IplBlockQemuScsi;
>   
> +struct IplBlockPci {
> +    uint32_t reserved0[80];
> +    uint8_t  opt;
> +    uint8_t  reserved1[3];
> +    uint32_t fid;
> +} QEMU_PACKED;
> +typedef struct IplBlockPci IplBlockPci;

Is this supposed to have the same positions for "fid" and "opt" as in the 
ipl_pb0_nvme structure in the kernel (arch/s390/include/uapi/asm/ipl.h)?

>   union IplParameterBlock {
>       struct {
>           uint32_t len;
> @@ -120,6 +129,7 @@ union IplParameterBlock {
>               IplBlockFcp fcp;
>               IPLBlockPV pv;
>               IplBlockQemuScsi scsi;
> +            IplBlockPci pci;
>           };
>       } QEMU_PACKED;
>       struct {
...
> diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
> new file mode 100644
> index 0000000000..838231d86c
> --- /dev/null
> +++ b/pc-bios/s390-ccw/virtio-pci.c
> @@ -0,0 +1,360 @@
> +/*
> + * Functionality for virtio-pci
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Jared Rossi <jrossi@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "clp.h"
> +#include "pci.h"
> +#include "helper.h"
> +#include "s390-ccw.h"
> +#include "virtio.h"
> +#include "bswap.h"
> +#include "virtio-pci.h"
> +#include "s390-time.h"
> +#include <stdio.h>
> +
> +/* Variable offsets used for reads/writes to modern memory regions */
> +VirtioPciCap c_cap; /* Common capabilities  */
> +VirtioPciCap d_cap; /* Device capabilities  */
> +VirtioPciCap n_cap; /* Notify capabilities  */
> +uint32_t notify_mult;
> +uint16_t q_notify_offset;
> +
> +static int virtio_pci_set_status(VDev *vdev, uint8_t status)
> +{
> +    int rc = pci_write_byte(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_STATUS,
> +                             c_cap.bar, status);
> +    if (rc) {
> +        puts("Failed to write virtio-pci status");
> +        return -EIO;
> +    }
> +
> +    return 0;
> +}
> +
> +static int virtio_pci_get_status(VDev *vdev, uint8_t *status)
> +{
> +    int rc = pci_read_byte(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_STATUS,
> +                           c_cap.bar, status);
> +    if (rc) {
> +        puts("Failed to read virtio-pci status");
> +        return -EIO;
> +    }
> +
> +    return 0;
> +}
> +
> +/*
> + * Find the position of the capability config within PCI configuration
> + * space for a given cfg type.  Return the position if found, otherwise 0.
> + */
> +static uint8_t find_cap_pos(uint32_t fhandle, uint8_t cfg_type)
> +{
> +    uint8_t next, cfg;
> +    int rc;
> +
> +    rc = pci_read_byte(fhandle, PCI_CAPABILITY_LIST, PCI_CFGBAR, &next);
> +    rc |= pci_read_byte(fhandle, next + 3, PCI_CFGBAR, &cfg);
> +
> +    while (!rc && (cfg != cfg_type) && next) {
> +        rc = pci_read_byte(fhandle, next + 1, PCI_CFGBAR, &next);
> +        rc |= pci_read_byte(fhandle, next + 3, PCI_CFGBAR, &cfg);
> +    }
> +
> +    return rc ? 0 : next;
> +}
> +
> +static int virtio_pci_get_hfeatures(VDev *vdev, uint64_t *features)
> +{
> +    uint32_t feat0, feat1;
> +    int rc;
> +
> +    rc = pci_bswap32_write(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_DFSELECT,
> +                           c_cap.bar, 0);
> +
> +    rc |= pci_read_bswap32(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_DF,
> +                           c_cap.bar, &feat0);
> +
> +    rc |= pci_bswap32_write(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_DFSELECT,
> +                            c_cap.bar, 1);
> +
> +    rc |= pci_read_bswap32(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_DF,
> +                               c_cap.bar, &feat1);
> +
> +    if (rc) {
> +        puts("Failed to get PCI feature bits");
> +        return -EIO;
> +    }
> +
> +    *features = (uint64_t) feat1 << 32;
> +    *features |= (uint64_t) feat0;
> +
> +    return 0;
> +}
> +
> +static int virtio_pci_set_gfeatures(VDev *vdev)
> +{
> +    int rc;
> +
> +    rc = pci_bswap32_write(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_GFSELECT,
> +                           c_cap.bar, 0);
> +
> +    rc |= pci_bswap32_write(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_GF,
> +                            c_cap.bar, vdev->guest_features[1]);
> +
> +    rc |= pci_bswap32_write(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_GFSELECT,
> +                            c_cap.bar, 1);
> +
> +    rc |= pci_bswap32_write(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_GF,
> +                                c_cap.bar, vdev->guest_features[0]);
> +
> +    if (rc) {
> +        puts("Failed to set PCI feature bits");
> +        return -EIO;
> +    }
> +
> +    return 0;
> +}
> +
> +static int virtio_pci_get_blk_config(VDev *vdev)
> +{
> +    return pci_read_flex(vdev->pci_fh, d_cap.off, d_cap.bar, &vdev->config.blk,
> +                         sizeof(VirtioBlkConfig));

I'm a little bit surprised that there does not seem to be any endianess 
swapping for the config.blk data anywhere here ... isn't that config space 
data supposed to be in little endian?

... oh, wait, you're not negotiating VIRTIO_F_VERSION_1, are you? ... so the 
config space is still in big endian for legacy virtio? ... hmm, I guess it's 
ok for now, but in the long run, I think we should rather use VERSION_1 instead.

> +}
> +
> +/* virtio spec v1.3 section 4.1.2.1 */
> +void virtio_pci_id2type(VDev *vdev, uint16_t device_id)
> +{
> +    switch (device_id) {
> +    case 0x1001:
> +        vdev->dev_type = VIRTIO_ID_BLOCK;
> +        break;
> +    case 0x1000: /* Other valid but currently unsupported virtio device types */
> +    case 0x1004:
> +    default:
> +        vdev->dev_type = 0;
> +    }
> +}
> +
> +/*
> + * Read PCI configuration space to find the offset of the Common, Device, and
> + * Notification memory regions within the modern memory space.
> + * Returns 0 if success, 1 if a capability could not be located, or a
> + * negative RC if the configuration read failed.
> + */
> +static int virtio_pci_read_pci_cap_config(VDev *vdev)
> +{
> +    uint8_t pos;
> +    int rc;
> +
> +    /* Common capabilities */
> +    pos = find_cap_pos(vdev->pci_fh, VPCI_CAP_COMMON_CFG);
> +    if (!pos) {
> +        puts("Failed to locate PCI common configuration");
> +        return 1;
> +    }
> +
> +    rc = pci_read_byte(vdev->pci_fh, pos + VPCI_CAP_BAR, PCI_CFGBAR, &c_cap.bar);
> +    if (rc || pci_read_bswap32(vdev->pci_fh, pos + VPCI_CAP_OFFSET, PCI_CFGBAR,
> +                               &c_cap.off)) {
> +        puts("Failed to read PCI common configuration");
> +        return -EIO;
> +    }
> +
> +    /* Device capabilities */
> +    pos = find_cap_pos(vdev->pci_fh, VPCI_CAP_DEVICE_CFG);
> +    if (!pos) {
> +        puts("Failed to locate PCI device configuration");
> +        return 1;
> +    }
> +
> +    rc = pci_read_byte(vdev->pci_fh, pos + VPCI_CAP_BAR, PCI_CFGBAR, &d_cap.bar);
> +    if (rc || pci_read_bswap32(vdev->pci_fh, pos + VPCI_CAP_OFFSET, PCI_CFGBAR,
> +                               &d_cap.off)) {
> +        puts("Failed to read PCI device configuration");
> +        return -EIO;
> +    }
> +
> +    /* Notification capabilities */
> +    pos = find_cap_pos(vdev->pci_fh, VPCI_CAP_NOTIFY_CFG);
> +    if (!pos) {
> +        puts("Failed to locate PCI notification configuration");
> +        return 1;
> +    }
> +
> +    rc = pci_read_byte(vdev->pci_fh, pos + VPCI_CAP_BAR, PCI_CFGBAR, &n_cap.bar);
> +    if (rc || pci_read_bswap32(vdev->pci_fh, pos + VPCI_CAP_OFFSET, PCI_CFGBAR,
> +                               &n_cap.off)) {
> +        puts("Failed to read PCI notification configuration");
> +        return -EIO;
> +    }
> +
> +    rc = pci_read_bswap32(vdev->pci_fh, pos + VPCI_N_CAP_MULT, PCI_CFGBAR, &notify_mult);
> +    if (rc || pci_read_bswap16(vdev->pci_fh, d_cap.off + VPCI_C_OFFSET_Q_NOFF,
> +                               d_cap.bar, &q_notify_offset)) {
> +        puts("Failed to read notification queue configuration");
> +        return -EIO;
> +    }
> +
> +    return 0;
> +}
> +
> +int virtio_pci_reset(VDev *vdev)
> +{
> +    int rc;
> +    uint8_t status = VPCI_S_RESET;
> +
> +    rc = virtio_pci_set_status(vdev, status);
> +    rc |= virtio_pci_get_status(vdev, &status);
> +
> +    if (rc || status) {
> +        puts("Failed to reset virtio-pci device");
> +        return 1;
> +    }
> +
> +    return 0;
> +}
> +
> +int virtio_pci_set_selected_vq(VDev *vdev, uint16_t queue_num)
> +{
> +    return pci_bswap16_write(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_Q_SELECT,
> +                             c_cap.bar, queue_num);
> +}
> +
> +int virtio_pci_set_queue_size(VDev *vdev, uint16_t queue_size)
> +{
> +    return pci_bswap16_write(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_Q_SIZE,
> +                             c_cap.bar, queue_size);
> +}
> +
> +static int virtio_pci_set_queue_enable(VDev *vdev, uint16_t enabled)
> +{
> +    return pci_bswap16_write(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_Q_ENABLE,
> +                             c_cap.bar, enabled);
> +}
> +
> +static int set_pci_vq_addr(VDev *vdev, uint64_t config_off, void *addr)
> +{
> +    return pci_bswap64_write(vdev->pci_fh, c_cap.off + config_off, c_cap.bar,
> +                             (uint64_t) addr);
> +}
> +
> +int virtio_pci_setup(VDev *vdev)
> +{
> +    VRing *vr;
> +    int rc;
> +    uint64_t pci_features;
> +    uint8_t status;
> +    int i = 0;
> +
> +    vdev->config.blk.blk_size = 0;

For really getting blk_size, I think you should negotiate 
VIRTIO_BLK_F_BLK_SIZE ?

Also, I assume the generic part of this function should rather be agnostic 
of virtio-block specific settings instead, so it can be used for 
virtio-net-pci and virtio-scsi-pci later? So the above line should likely 
rather go into the "case VIRTIO_ID_BLOCK" part below?

> +    vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
> +    vdev->cmd_vr_idx = 0;
> +
> +    if (virtio_reset(vdev)) {
> +        return -EIO;
> +    }
> +
> +    status = VPCI_S_ACKNOWLEDGE;
> +    rc = virtio_pci_set_status(vdev, status);
> +    if (rc) {
> +        puts("Virtio-pci device Failed to ACKNOWLEDGE");
> +        return -EIO;
> +    }
> +
> +    rc = virtio_pci_read_pci_cap_config(vdev);
> +    if (rc) {
> +        printf("Invalid PCI capabilities");
> +        return -EIO;
> +    }
> +
> +    switch (vdev->dev_type) {
> +    case VIRTIO_ID_BLOCK:
> +        vdev->nr_vqs = 1;
> +        vdev->cmd_vr_idx = 0;
> +        virtio_pci_get_blk_config(vdev);
> +        break;
> +    default:
> +        puts("Unsupported virtio device");
> +        return -ENODEV;
> +    }
> +
> +    status |= VPCI_S_DRIVER;
> +    rc = virtio_pci_set_status(vdev, status);
> +    if (rc) {
> +        puts("Set status failed");
> +        return -EIO;
> +    }
> +
> +    /* Feature negotiation */
> +    rc = virtio_pci_get_hfeatures(vdev, &pci_features);
> +    if (rc || virtio_pci_set_gfeatures(vdev)) {
> +        return -EIO;
> +    }
> +
> +    /* Configure virt-queues for pci */
> +    for (i = 0; i < vdev->nr_vqs; i++) {
> +        VqInfo info = {
> +            .queue = (unsigned long long) virtio_get_ring_area() + (i * VIRTIO_RING_SIZE),
> +            .align = KVM_S390_VIRTIO_RING_ALIGN,
> +            .index = i,
> +            .num = 0,
> +        };
> +
> +        vr = &vdev->vrings[i];
> +
> +        if (pci_read_flex(vdev->pci_fh, VPCI_C_COMMON_NUMQ, c_cap.bar, &info.num, 2)) {
> +            return -EIO;
> +        }
> +
> +        vring_init(vr, &info);
> +
> +        if (virtio_pci_set_selected_vq(vdev, vr->id)) {
> +            puts("Failed to set selected virt-queue");
> +            return -EIO;
> +        }
> +
> +        if (virtio_pci_set_queue_size(vdev, VIRTIO_RING_SIZE)) {
> +            puts("Failed to set virt-queue size");
> +            return -EIO;
> +        }
> +
> +        rc = set_pci_vq_addr(vdev, VPCI_C_OFFSET_Q_DESCLO, vr->desc);
> +        rc |= set_pci_vq_addr(vdev, VPCI_C_OFFSET_Q_AVAILLO, vr->avail);
> +        rc |= set_pci_vq_addr(vdev, VPCI_C_OFFSET_Q_USEDLO, vr->used);
> +        if (rc) {
> +            puts("Failed to configure virt-queue address");
> +            return -EIO;
> +        }
> +
> +        if (virtio_pci_set_queue_enable(vdev, true)) {
> +            puts("Failed to set virt-queue enabled");
> +            return -EIO;
> +        }
> +    }
> +
> +    status |= VPCI_S_FEATURES_OK | VPCI_S_DRIVER_OK;
> +    return virtio_pci_set_status(vdev, status);
> +}

  Thomas



