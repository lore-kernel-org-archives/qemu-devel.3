Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEDECD5854
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 11:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdRJO-0006ee-PK; Wed, 07 Jan 2026 06:02:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdRJG-0005On-U0
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 06:02:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdRJD-0004eW-2j
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 06:02:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767783754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=utU9Lhj0q5fwVdPKJ39l15d3V9Ru2O2IkiK9/WifYGg=;
 b=FHpLWOve3log7Cx00IPOsag7qnalAQKMcgYWJCoPU5drSOFW1uv675QgEXf9ttLF9SJTFL
 ylrEbntm3asa0c9ydosK/zouYxZarxlt/0KScEsrH8ZzGa4ToQThrFCutHQ3pn9/MgV8W4
 A79pL0p9sUL3rWsX6DHZuPfYdKOG0Lc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-Ps0-UXvfO1iunNQCSog0Og-1; Wed, 07 Jan 2026 06:02:33 -0500
X-MC-Unique: Ps0-UXvfO1iunNQCSog0Og-1
X-Mimecast-MFC-AGG-ID: Ps0-UXvfO1iunNQCSog0Og_1767783752
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4792bd2c290so19658995e9.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 03:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767783752; x=1768388552; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=utU9Lhj0q5fwVdPKJ39l15d3V9Ru2O2IkiK9/WifYGg=;
 b=ayp5CdtftIlXxcs6HzxsB7WuLHkOnLGzLVp+Mz5vpIcq9996whi50UNIR2GuH+j2sC
 k7cWwZTDKcfACOzLV7l3LAjcAviUyRFm9k68Kqe8rdAnaYY8hvo9do4Z6ESQiVLzE+Fr
 jP3kES21CkRcawbKBPofQzWdDHIJAtE6eTl8SuKAqnf1RGxOj4ulF8PDO76NccXQi302
 WFxTJXNGGrsIwWPYuV8jFETPntcl8kWvT6tEdMlEfrj71gELL8KeN1lVdgVAB4ufyDCw
 Ea50IGgbivViUxK6Bo6JOg87aC+9UXXuaRStaz+z0ZTrQWDrmN0VcIs1Fo1U++KIE0Jh
 CjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767783752; x=1768388552;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=utU9Lhj0q5fwVdPKJ39l15d3V9Ru2O2IkiK9/WifYGg=;
 b=kl0MLsfvQrpAcC3r8smPCwUHW9jx3t9TxAsJfSP/LFXEqeb51X0LOXG+2lTdKt2ZTZ
 1XVro7Ke+v8SQCE+PQcnYAv9A+vZnczPvTlBUjfvHJ+2c/Ql1YBly7BhOsOChFTAVhgn
 y9lsVb9wWc6Et7aAAmZjgHkK8eOHFg2q4cODrhahy+ok+H6sSfIVW3BJJ8tkByKfTJxK
 2P56n4n0JaY++5ZCdIKsWuXYkEg9Bv/VjyH2phKLi9/A2BfAINd5pPdakHS+1SERGngB
 RRqocpPrl0bjDuljKsFXW4iUkv7vRAIza0sXg5+FRQ//OhKwwTx9OZlax4Cayd6V5jkF
 /vng==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0rEsswYunVSXSE5jGx0e0lssBX37hK3cIGfk0dsRj8Nc7ydK+Fq+/f6Z1Q+8TxOJr7uXXsaw+16VS@nongnu.org
X-Gm-Message-State: AOJu0Yytcmi0KR9+UFFYu+pKz3TwVHEkWzUMhKJjB8BdKm3vBxJhi2bA
 obdyF7KttF7chc5g94RHInI2MYxTZ4zK5rlE/Ze1/X6tcq3Kzuj/jV5lWq7yc0la5wCwNXyy2KF
 bsPb+o6Shx/Ii6f1bUQaqLeAxy6192yYw3nd3wmOCGNarXCjMry7dZ5xc
X-Gm-Gg: AY/fxX4lpczVer4+htqpg470wLgTV0YpFTN0MCB5QffYsFKzQgNiqInAIJTuDHIOLvl
 ec7rEbr2xCFWMkRfHTrYHgUWQ5Oaz7tT/iLYM+uStNrEzd3+sRIsTkCdD95I4r7LUPJJwjSyp2A
 HZH4Nj5r0Hx0OkRzH/CK6mDA7pJTIVp8wldfJzGmMmsZcLVNNspJHLd3S71qMgUZ0NIVOY3YY+L
 g9L+KXwdxAX9bbgpTI2sSduSgg1xvys06ZCGAXgKmu5ucf5EWaxUDC9a6kf/w99couwXA6OudK0
 rdw4jldCdAi6V5wuPqRCY7PoYOCh8ONH5B2crPbMAqBzTvzsmENO48VwflqEuezmy2Yeez43i8D
 xp2sjnypkttfoyZvfhTAeoLYOStbCF3Y+vJo=
X-Received: by 2002:a05:600c:8b2c:b0:47d:3690:7490 with SMTP id
 5b1f17b1804b1-47d84b1849emr22123425e9.9.1767783751865; 
 Wed, 07 Jan 2026 03:02:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqCbW4WKaxlzlVzsOazm3HG8C2a/k6/ziQoicBHjo9ZwLpc9bt48IKue+QyY3ok1hRPR56jw==
X-Received: by 2002:a05:600c:8b2c:b0:47d:3690:7490 with SMTP id
 5b1f17b1804b1-47d84b1849emr22123025e9.9.1767783751427; 
 Wed, 07 Jan 2026 03:02:31 -0800 (PST)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e6784sm9481944f8f.19.2026.01.07.03.02.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 03:02:30 -0800 (PST)
Message-ID: <073b4bfc-cd4c-48ab-bcf0-0a011e5fb4b2@redhat.com>
Date: Wed, 7 Jan 2026 12:02:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] pc-bios/s390-ccw: Introduce PCI device
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20251210205449.2783111-1-jrossi@linux.ibm.com>
 <20251210205449.2783111-7-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251210205449.2783111-7-jrossi@linux.ibm.com>
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

On 10/12/2025 21.54, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Define selected s390x PCI instructions and extend IPLB to allow PCI devices.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/pci.h    |  88 ++++++++++
>   pc-bios/s390-ccw/pci.c    | 331 ++++++++++++++++++++++++++++++++++++++
>   pc-bios/s390-ccw/Makefile |   2 +-
>   3 files changed, 420 insertions(+), 1 deletion(-)
>   create mode 100644 pc-bios/s390-ccw/pci.h
>   create mode 100644 pc-bios/s390-ccw/pci.c
...
> diff --git a/pc-bios/s390-ccw/pci.c b/pc-bios/s390-ccw/pci.c
> new file mode 100644
> index 0000000000..c149789386
> --- /dev/null
> +++ b/pc-bios/s390-ccw/pci.c
> @@ -0,0 +1,331 @@
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
> +#include "bswap.h"
> +#include <stdio.h>
> +#include <stdbool.h>
> +
> +/* PCI load */
> +static inline int pcilg(uint64_t *data, uint64_t req, uint64_t offset, uint8_t *status)
> +{
> +    union register_pair req_off = {.even = req, .odd = offset};
> +    int cc = -1;
> +    uint64_t __data;
> +
> +    asm volatile (
> +        "     .insn   rre,0xb9d20000,%[data],%[req_off]\n"
> +        "     ipm     %[cc]\n"
> +        "     srl     %[cc],28\n"
> +        : [cc] "+d" (cc), [data] "=d" (__data),
> +          [req_off] "+d" (req_off.pair) :: "cc");
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
> +        : [cc] "+d" (cc), [req_off] "+d" (req_off.pair)
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
> +static int pci_write(uint32_t fhandle, uint64_t offset, uint8_t pcias,
> +                     uint64_t data, uint8_t len)
> +{
> +
> +    uint64_t req = ZPCI_CREATE_REQ(fhandle, pcias, len);
> +    uint8_t status;
> +    int rc;
> +
> +    /* writes must be non-zero powers of 2 with a maximum of 8 bytes per read */
> +    switch (len) {
> +    case 1:
> +    case 2:
> +    case 4:
> +    case 8:
> +        rc = pcistg(data, req, offset, &status);
> +        break;
> +    default:
> +        rc = -1;
> +    }
> +
> +    /* Error condition detected */
> +    if (rc == 1) {
> +        printf("PCI store failed with status condition %d\n", status);
> +        return -1;
> +    }
> +
> +    return rc ? -1 : 0;
> +}
> +
> +/* Write an arbitrary length of data without byte swapping */
> +int pci_write_flex(uint32_t fh, uint64_t offset, uint8_t pcias, void *data, int len)

You don't seem to use the pci_write_flex() functions in any later patches 
... could it be dropped?

> +{
> +    uint8_t writelen, tmp;
> +    int rc;
> +    int remaining = len;
> +
> +    /* write bytes in powers of 2, up to a maximum of 8 bytes per read */
> +    while (remaining) {
> +        if (remaining > 7) {
> +            writelen = 8;
> +        } else {
> +            writelen = 1;
> +            while (true) {
> +                tmp = writelen * 2;
> +                if (tmp > remaining) {
> +                    break;
> +                }
> +
> +                writelen = tmp;
> +            }
> +        }
> +
> +        /* Access next data based on write size */
> +        switch (writelen) {
> +        case 1:
> +            rc = pci_write(fh, offset, pcias, ((uint8_t *)data)[0], 1);
> +            break;
> +        case 2:
> +            rc = pci_write(fh, offset, pcias, ((uint16_t *)data)[0], 2);
> +            break;
> +        case 4:
> +            rc = pci_write(fh, offset, pcias, ((uint32_t *)data)[0], 4);
> +            break;
> +        case 8:
> +            rc = pci_write(fh, offset, pcias, ((uint64_t *)data)[0], 8);
> +            break;
> +        default:
> +            rc = -1;
> +        }
> +
> +        if (rc) {
> +            return -1;
> +        }
> +
> +        remaining -= writelen;
> +        data += writelen;
> +        offset += writelen;
> +    }
> +
> +    return 0;
> +}
> +
> +int pci_write_byte(uint32_t fhandle, uint64_t offset, uint8_t pcias, uint8_t data)
> +{
> +    return pci_write(fhandle, offset, pcias, (uint64_t)data, 1);
> +}
> +
> +/* Wrappers to byte swap common data sizes then write */
> +int pci_bswap16_write(uint32_t fhandle, uint64_t offset, uint8_t pcias, uint16_t data)
> +{
> +    uint64_t le_data = bswap16(data);
> +    return pci_write(fhandle, offset, pcias, le_data, 2);
> +}
> +
> +int pci_bswap32_write(uint32_t fhandle, uint64_t offset, uint8_t pcias, uint32_t data)
> +{
> +    uint64_t le_data = bswap32(data);
> +    return pci_write(fhandle, offset, pcias, le_data, 4);
> +}
> +
> +int pci_bswap64_write(uint32_t fhandle, uint64_t offset, uint8_t pcias, uint64_t data)
> +{
> +    uint64_t le_data = bswap64(data);
> +    return pci_write(fhandle, offset, pcias, le_data, 8);
> +}
> +
> +static int pci_read(uint32_t fh, uint64_t offset, uint8_t pcias, void *buf, uint8_t len)
> +{
> +    uint64_t req, data;
> +    uint8_t status;
> +    int rc;
> +
> +    req = ZPCI_CREATE_REQ(fh, pcias, len);
> +    rc = pcilg(&data, req, offset, &status);
> +
> +    /* Error condition detected */
> +    if (rc == 1) {
> +        printf("PCI load failed with status condition %d\n", status);
> +        return -1;
> +    }
> +
> +    switch (len) {
> +    case 1:
> +        *(uint8_t *)buf = data;
> +        break;
> +    case 2:
> +        *(uint16_t *)buf = data;
> +        break;
> +    case 4:
> +        *(uint32_t *)buf = data;
> +        break;
> +    case 8:
> +        *(uint64_t *)buf = data;
> +        break;
> +    default:
> +        return -1;
> +    }
> +
> +    return rc ? -1 : 0;
> +}
> +
> +/* Read to an arbitrary length buffer without byte swapping */
> +int pci_read_flex(uint32_t fh, uint64_t offset, uint8_t pcias, void *buf, int len)
> +{
> +    uint8_t readlen, tmp;
> +    int rc;
> +    int remaining = len;
> +
> +    /* Read bytes in powers of 2, up to a maximum of 8 bytes per read */
> +    while (remaining) {
> +        if (remaining > 7) {
> +            readlen = 8;
> +        } else {
> +            readlen = 1;
> +            while (true) {
> +                tmp = readlen * 2;
> +                if (tmp > remaining) {
> +                    break;
> +                }
> +
> +                readlen = tmp;
> +            }
> +        }

This looks cumbersome ... maybe rather something like this (untested):

	for (int i = 3; i >= 0; i--) {
		readlen = 1 << i;
		if (remaining >= readlen)
			break;
	}

?

> +        rc = pci_read(fh, offset, pcias, buf, readlen);
> +        if (rc) {
> +            return -1;
> +        }
> +
> +        remaining -= readlen;
> +        buf += readlen;
> +        offset += readlen;
> +    }
> +
> +    return 0;
> +}

  Thomas



