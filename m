Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E54CCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 06:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB64V-0004GQ-Jl; Tue, 21 Oct 2025 02:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vB64T-0004GA-IS
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 02:42:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vB64P-0001Sr-GA
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 02:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761028927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3GpOeFNpVKsNNUJi3z3BZ+ECcULUmATHVag9n9l2EC4=;
 b=KHH1i0fGWSmOzeIxw2Rmv3BMkXVyDIEda7h1SPhN3Mqzl+b4wGyAZG/e/UoZkmN6fxp8IM
 hVc1wU2sM2sG9kM5VNZkl1fIQSHKqSFxRWGoumznJKiPIg2XC90sA77MBue/UBtbMV3B80
 R/PK9lNtiA9XHEu8saG+Jyu3DGBUrKI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-kRqTp3DDMDW6-Rrd3xKtkA-1; Tue, 21 Oct 2025 02:42:05 -0400
X-MC-Unique: kRqTp3DDMDW6-Rrd3xKtkA-1
X-Mimecast-MFC-AGG-ID: kRqTp3DDMDW6-Rrd3xKtkA_1761028925
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-426feed0016so2041084f8f.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 23:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761028924; x=1761633724;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3GpOeFNpVKsNNUJi3z3BZ+ECcULUmATHVag9n9l2EC4=;
 b=J2l2WsNDceRImEihtc2DsoVbhaH6JDPGTIDyMbNM88ZiN5/J/+pAQf89V10xtzn3az
 eyvdeJEeUM7qMSRGYV5QToxgJ3/zUsZTNKDOdHoLa84kTm0Cuvi8LAyg5f/IMk4jif3g
 nCgoFDYB57QFA4Mof1eIZlRx4ScNip6dyXy8LmfLBV8JKbvpoSTS/pmC5FnzjgfZI/oD
 ftXfRkQSYrwZGPxPH2UBCMfepOfelNwVYWlbCDTex0As8ZAwe9NEmWDcfPIaZSeb3/wW
 3QBRf8d7IK3QG6m5DwjePAahHt5d9oB5jLR35OYY/GPC/0OvCpazmiIMkB3MW7tzn8wY
 z4Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgKnZ2u2AH0eYvh8gm0s1bQ8v1++4O+8KVMWdKeYxVQzPO9dEvaqB1JRfCx5zYWnDwRK8HuRQUAb3d@nongnu.org
X-Gm-Message-State: AOJu0YyPtL8X+slkcwGMFuVSO/uSjv80V3CV5PV/miZSWaroe5dIpGKU
 naB1wxV31hgi2RDDOElY3qNssFpOtkaTqBuliuWQqji1tSuSZnfONEweqb89DGoma93+yWzIEoR
 JCz8XrR5PBh+2yv0dCzzQkhtET2rb37ISaMYg2M/C6ke+0w34oarVpiUX
X-Gm-Gg: ASbGncsrZI5WCnGKssICyHRJWTYcQcmsdWgmbYcx98+xDIbG66HupWr5IG6v1xGhV6o
 +9Jw1kTMMYTnnt/KdZq6uOEviRPC/zTjuP3cee7h5GyCbPGz2fJ52uDzUCn+BLLp7YJHWJ/ww7t
 mD6CKjacYD9kRvRhfUgTmeFySUYB/gpsgpc/g2YTRlFFvjVQHVUqzaXJCdXig4HkV8A5twjEp3H
 2Hw56g8B/5rQbhjGGSXZQrvHNpf6PI0V33fV4dCbV1vRC7k4d7euHMUP5mCnR4nC9ItHhx9zj16
 pUs1yk2OSvZkdNd9g5nqdTcX8xHGK3ldA0ES11bM+mIaFi/k1AiZs9pjnCs/ZwNkvC5cn5oN2N7
 3pNqbPrgzQYqKv0VP4muwUzOP
X-Received: by 2002:a05:6000:2c0c:b0:426:d619:cac7 with SMTP id
 ffacd0b85a97d-42704d9397amr11169970f8f.36.1761028924555; 
 Mon, 20 Oct 2025 23:42:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ8qucLGXUSSNoX3hPSWc23dqofkz/S40AzQL0rgiSjoIpUiv82bcDBBX84/AFFJLCkrlWBw==
X-Received: by 2002:a05:6000:2c0c:b0:426:d619:cac7 with SMTP id
 ffacd0b85a97d-42704d9397amr11169950f8f.36.1761028924057; 
 Mon, 20 Oct 2025 23:42:04 -0700 (PDT)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5bab52sm18548145f8f.22.2025.10.20.23.42.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 23:42:03 -0700 (PDT)
Message-ID: <fd0301da-686f-4dbe-a403-9cb1faebb8df@redhat.com>
Date: Tue, 21 Oct 2025 08:42:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] pc-bios/s390-ccw: Introduce PCI device IPL format
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20251020162023.3649165-1-jrossi@linux.ibm.com>
 <20251020162023.3649165-5-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251020162023.3649165-5-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 20/10/2025 18.20, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Define selected s390x PCI instructions and extend IPLB to allow PCI devices.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   include/hw/s390x/ipl/qipl.h |   9 ++
>   pc-bios/s390-ccw/pci.h      |  77 +++++++++++++++
>   pc-bios/s390-ccw/pci.c      | 191 ++++++++++++++++++++++++++++++++++++
>   pc-bios/s390-ccw/Makefile   |   2 +-
>   4 files changed, 278 insertions(+), 1 deletion(-)
>   create mode 100644 pc-bios/s390-ccw/pci.h
>   create mode 100644 pc-bios/s390-ccw/pci.c
> 
> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
> index aadab87c2e..efd7b3797c 100644
> --- a/include/hw/s390x/ipl/qipl.h
> +++ b/include/hw/s390x/ipl/qipl.h
> @@ -104,6 +104,14 @@ struct IplBlockQemuScsi {
>   } QEMU_PACKED;
>   typedef struct IplBlockQemuScsi IplBlockQemuScsi;
>   
> +struct IplBlockPci {
> +    uint32_t reserved0[80];
> +    uint8_t  opt;
> +    uint8_t  reserved1[3];
> +    uint32_t fid;
> +} QEMU_PACKED;

Looks like all members of this struct are naturally aligned ... I think you 
could likely drop the QEMU_PACKED here.

> +typedef struct IplBlockPci IplBlockPci;
> +
>   union IplParameterBlock {
>       struct {
>           uint32_t len;
> @@ -119,6 +127,7 @@ union IplParameterBlock {
>               IplBlockFcp fcp;
>               IPLBlockPV pv;
>               IplBlockQemuScsi scsi;
> +            IplBlockPci pci;
>           };
>       } QEMU_PACKED;
>       struct {
...
> diff --git a/pc-bios/s390-ccw/pci.c b/pc-bios/s390-ccw/pci.c
> new file mode 100644
> index 0000000000..f776bc064c
> --- /dev/null
> +++ b/pc-bios/s390-ccw/pci.c
> @@ -0,0 +1,191 @@
> +/*
> + * s390x PCI funcionality
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Jared Rossi <jrossi@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "clp.h"
> +#include "pci.h"
> +#include <stdio.h>
> +
> +/* PCI load */
> +static inline int pcilg(uint64_t *data, uint64_t req, uint64_t offset, uint8_t *status)
> +{
> +    union register_pair req_off = {.even = req, .odd = offset};
> +    int cc = -1;
> +    uint64_t __data = 0x92;
> +
> +    asm volatile (
> +        "     .insn   rre,0xb9d20000,%[data],%[req_off]\n"
> +        "     ipm     %[cc]\n"
> +        "     srl     %[cc],28\n"
> +        : [cc] "+d" (cc), [data] "=d" (__data),
> +          [req_off] "+&d" (req_off.pair) :: "cc");

What's the "&" good for here?

> +    *status = req_off.even >> 24 & 0xff;
> +    *data = __data;
> +    return cc;
> +}
> +
> +/* PCI store */
> +int pcistg(uint64_t data, uint64_t req, uint64_t offset, uint8_t *status)
> +{
> +    union register_pair req_off = {.even = req, .odd = offset};
> +    int cc = -1;
> +
> +    asm volatile (
> +        "     .insn   rre,0xb9d00000,%[data],%[req_off]\n"
> +        "     ipm     %[cc]\n"
> +        "     srl     %[cc],28\n"
> +        : [cc] "+d" (cc), [req_off] "+&d" (req_off.pair)

dito

> +        : [data] "d" (data)
> +        : "cc");
> +    *status = req_off.even >> 24 & 0xff;
> +    return cc;
> +}
> +
> +/* store PCI function controls */
> +int stpcifc(uint64_t req, PciFib *fib, uint8_t *status)
> +{
> +    uint8_t cc;
> +
> +    asm volatile (
> +        "     .insn   rxy,0xe300000000d4,%[req],%[fib]\n"
> +        "     ipm     %[cc]\n"
> +        "     srl     %[cc],28\n"
> +        : [cc] "=d" (cc), [req] "+d" (req), [fib] "+Q" (*fib)
> +        : : "cc");
> +    *status = req >> 24 & 0xff;
> +    return cc;
> +}
> +
> +/* modify PCI function controls */
> +int mpcifc(uint64_t req, PciFib *fib, uint8_t *status)
> +{
> +    uint8_t cc;
> +
> +    asm volatile (
> +        "     .insn   rxy,0xe300000000d0,%[req],%[fib]\n"
> +        "     ipm     %[cc]\n"
> +        "     srl     %[cc],28\n"
> +        : [cc] "=d" (cc), [req] "+d" (req), [fib] "+Q" (*fib)
> +        : : "cc");
> +    *status = req >> 24 & 0xff;
> +    return cc;
> +}
> +
> +int pci_write(uint32_t fhandle, uint64_t offset, uint64_t data, uint8_t len)
> +{
> +
> +    uint64_t req = ZPCI_CREATE_REQ(fhandle, 4, len);
> +    uint8_t status;
> +    int rc;
> +
> +    rc = pcistg(data, req, offset, &status);
> +    if (rc == 1) {
> +        return status;
> +    } else if (rc) {
> +        return rc;
> +    }
> +
> +    return 0;
> +}
> +
> +int pci_read(uint32_t fhandle, uint64_t offset, uint8_t picas, void *buf, uint8_t len)
> +{
> +    uint64_t req;
> +    uint64_t data;
> +    uint8_t status;
> +    int readlen;
> +    int i = 0;
> +    int rc = 0;
> +
> +    while (len > 0 && !rc) {
> +        data = 0;
> +        readlen = len > 8 ? 8 : len;
> +        req = ZPCI_CREATE_REQ(fhandle, picas, readlen);
> +        rc = pcilg(&data, req, offset + (i * 8), &status);
> +        ((uint64_t *)buf)[i] = data;

This looks somewhat dangerous ... what if buf points to a buffer where its 
lengths is not divisible by 8? ... you'll happily overwrite the data that is 
right behind the buffer in memory.

> +        len -= readlen;
> +        i++;
> +    }
> +
> +    if (rc == 1) {
> +        return status;
> +    } else if (rc) {
> +        return rc;
> +    }
> +
> +    return 0;
> +}
> +
> +/*
> + * Find the position of the capability config within PCI configuration
> + * space for a given cfg type.  Return the position if found, otherwise 0.
> + */
> +uint8_t find_cap_pos(uint32_t fhandle, uint64_t cfg_type) {

Curly bracket on the next line, please.

> +    uint64_t req, next, cfg;
> +    uint8_t status;
> +    int rc;
> +
> +    req = ZPCI_CREATE_REQ(fhandle, 0xf, 1);
> +    rc = pcilg(&next, req, PCI_CAPABILITY_LIST, &status);
> +    rc = pcilg(&cfg, req, next + 3, &status);

Assigning rc just to discard the value again in the next line does not make 
sense... if you're lazy, use "rc |= ..." in the second line. Otherwise 
please explicitly check the "rc" after the first call.

> +    while (!rc && (cfg != cfg_type) && next) {
> +        rc = pcilg(&next, req, next + 1, &status);
> +        rc = pcilg(&cfg, req, next + 3, &status);

dito

> +    }
> +
> +    return rc ? 0 : next;
> +}

  Thomas


