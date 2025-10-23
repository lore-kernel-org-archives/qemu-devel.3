Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8EDBCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 17:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBz9j-0007bJ-JV; Thu, 23 Oct 2025 13:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vBz9h-0007Ya-4e; Thu, 23 Oct 2025 13:31:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vBz9e-0000o1-94; Thu, 23 Oct 2025 13:31:16 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NH7faM014602;
 Thu, 23 Oct 2025 17:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=F4I5JC
 0BrLfo7ZNv0rRMokmQ3oJaEeJbKeJf2nEExVA=; b=Ey71sFknplAFSwWb7Y+jeq
 LttzQN5A2ILDwZDd8J7tZTKMMJsZz3eBXrXCDLbcy695sQTr8rieVJMpIheXIN6p
 ZGRr6LWkNjoXXhHQkE7zZb1dVS9Gj5SZMx/NBJlekNQ4U6AaJ0jx9Di8mRgIQOsR
 Dly7uoLEb7YIMej+dGXzgXbPSw6KJeIM7cLFl53MD60qtBqAd04OUl+/ft4Bb0Ww
 2ynFbuvEqd8bmUKxdnfalFO23Mm0HuOq5c8Sri6a+z0OVJEtmU/+6MI+9j9xKULS
 UbOYBcgz59EYlZ66llDNFcriV7R0wfNg2f2dwcLreInRvthYc6P+KrfgOeXBpBJA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31sbk84-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 17:31:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NGdkRM017061;
 Thu, 23 Oct 2025 17:31:08 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vnky74fv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 17:31:08 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NHV7Cs27918890
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 17:31:07 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F02F5805D;
 Thu, 23 Oct 2025 17:31:07 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EEBA058057;
 Thu, 23 Oct 2025 17:31:06 +0000 (GMT)
Received: from [9.61.246.20] (unknown [9.61.246.20])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 17:31:06 +0000 (GMT)
Message-ID: <49301ff9-894c-4341-bd9e-7b2213aa184b@linux.ibm.com>
Date: Thu, 23 Oct 2025 10:31:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Farhan Ali <alifm@linux.ibm.com>
Subject: Re: [PATCH 4/7] pc-bios/s390-ccw: Introduce PCI device IPL format
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com
Cc: jjherne@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
References: <20251020162023.3649165-1-jrossi@linux.ibm.com>
 <20251020162023.3649165-5-jrossi@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20251020162023.3649165-5-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: t9xlhXe-9TS8pnTX4SxMU8WMfKTIaidF
X-Proofpoint-GUID: t9xlhXe-9TS8pnTX4SxMU8WMfKTIaidF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX3DXaN5JkqkWK
 4fORfOT6EDkKzpzrfDhUgIhzq7n4kUhL674W3KyU71KT62H2aquypjAIaqQoACoy480tGrbbRiH
 Qe4yKKpfTRviMmNsVYs4Ht/YlbwHjxnti59CSafNnc0PpMxWTXIIuYvWhfcWb/Q/oHrMSeOBYr4
 F4mw+l7n74hhNV70XQ88fwejAzJbMA3jLxe/B8U+75WoOoGJUkv9Kz+RshBjo0YTcpv/VrtqztE
 PYSCwZAkq22AVBYPrH0XEhW8IaYnbpssQ0iYKiLeg44hk7ybgomSXgfJd7ABo6OOM03xkXZpthD
 SCtnqMYV2VIWF/3zN7HQs5qiB7tXCNa3VvxWxFZJ7fxkIl02InE8MyoKBY5l0ZcSV8/5A7j8KEX
 DUgnTI0KQtYZcKk50yuzyHjLl7BF3Q==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68fa665e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=WrN3LOE88S3Oh2TfRc0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Jared,

On 10/20/2025 9:20 AM, jrossi@linux.ibm.com wrote:
> From: Jared Rossi<jrossi@linux.ibm.com>
>
> Define selected s390x PCI instructions and extend IPLB to allow PCI devices.
>
> Signed-off-by: Jared Rossi<jrossi@linux.ibm.com>
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
> diff --git a/pc-bios/s390-ccw/pci.h b/pc-bios/s390-ccw/pci.h
> new file mode 100644
> index 0000000000..b5dc5bff35
> --- /dev/null
> +++ b/pc-bios/s390-ccw/pci.h
> @@ -0,0 +1,77 @@
> +/*
> + * s390x PCI definitions
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Jared Rossi<jrossi@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef PCI_H
> +#define PCI_H
> +
> +#include <stdint.h>
> +#include "clp.h"
> +
> +#define ZPCI_CREATE_REQ(handle, space, len)                    \
> +    ((uint64_t) handle << 32 | space << 16 | len)
> +
> +union register_pair {
> +    unsigned __int128 pair;
> +    struct {
> +        unsigned long even;
> +        unsigned long odd;
> +    };
> +};
> +
> +#define PCIFIB_FC_ENABLED      0x80
> +#define PCIFIB_FC_ERROR        0x40
> +#define PCIFIB_FC_BLOCKED      0x20
> +#define PCIFIB_FC_DMAREG       0x10
> +
> +#define PCIST_DISABLED         0x0
> +#define PCIST_ENABLED          0x1
> +
> +#define PCI_CAPABILITY_LIST    0x34 /* Offset of first capability list entry */
> +
> +struct PciFib {
> +    uint32_t reserved0[2];
> +    uint8_t fcflags;
> +    uint8_t reserved1[3];
> +    uint32_t reserved2;
> +    uint64_t pba;
> +    uint64_t pal;
> +    uint64_t iota;
> +    uint16_t isc:4;
> +    uint16_t noi:12;
> +    uint8_t reserved3:2;
> +    uint8_t aibvo:6;
> +    uint8_t s:1;
> +    uint8_t reserved4:1;
> +    uint8_t aisbo:6;
> +    uint32_t reserved5;
> +    uint64_t aibv;
> +    uint64_t aisb;
> +    uint64_t fmba;
> +    uint32_t reserved6[2];
> +};
> +typedef struct PciFib PciFib;
> +
> +struct PciDevice {
> +    uint16_t device_id;
> +    uint16_t vendor_id;
> +    uint32_t fid;
> +    uint32_t fhandle;
> +    uint8_t status;
> +    PciFib fib;
> +};
> +typedef struct PciDevice PciDevice;
> +
> +int pci_write(uint32_t fhandle, uint64_t offset, uint64_t data, uint8_t len);
> +int pci_read(uint32_t fhandle, uint64_t offset, uint8_t picas, void *buf, uint8_t len);
> +uint8_t find_cap_pos(uint32_t fhandle, uint64_t cfg_type);
> +int pci_dev_enable(PciDevice *pcidev);
> +int get_fib(PciFib *fib, uint32_t fhandle);
> +int set_fib(PciFib *fib, uint32_t fhandle, uint8_t dma_as, uint8_t opcontrol);
> +
> +#endif
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
> + * Author(s): Jared Rossi<jrossi@linux.ibm.com>
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

Why is __data initialized to 0x92?


> +    asm volatile (
> +        "     .insn   rre,0xb9d20000,%[data],%[req_off]\n"
> +        "     ipm     %[cc]\n"
> +        "     srl     %[cc],28\n"
> +        : [cc] "+d" (cc), [data] "=d" (__data),
> +          [req_off] "+&d" (req_off.pair) :: "cc");
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

This assumes that we will only read to BAR 4? I think we should pass the 
PCIAS here as well if we want to generalize this function?


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

Shouldn't this be offset + (i * readlen)? but I guess this works because 
we will only increment i on reads greater than 8 bytes. Maybe we could 
try to simplify this and have a single pci_read function and several 
other helper functions that uses pci_read to read sizes of 1/2/4/8 
bytes. For reads greater than 8 bytes we can have another function 
(similar to zpci_memcpy_from_io, in the kernel). From what I can tell 
most of the pci_read calls reads are 8 bytes in the rest of the patches, 
except maybe for one case which reads greater than 8?


> +        ((uint64_t *)buf)[i] = data;
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
> +    uint64_t req, next, cfg;
> +    uint8_t status;
> +    int rc;
> +
> +    req = ZPCI_CREATE_REQ(fhandle, 0xf, 1);
> +    rc = pcilg(&next, req, PCI_CAPABILITY_LIST, &status);
> +    rc = pcilg(&cfg, req, next + 3, &status);

Why are we reading next + 3 into cfg? If I understand this correctly 
next will be the address of the first capability in the linked list, and 
so we should just read the first byte from next to get the capability 
id? I think we should have helper function like qpci_find_capability to 
find the capabilities?


> +
> +    while (!rc && (cfg != cfg_type) && next) {
> +        rc = pcilg(&next, req, next + 1, &status);
> +        rc = pcilg(&cfg, req, next + 3, &status);

Same question here?


> +    }
> +
> +    return rc ? 0 : next;
> +}
> +

[..snip..]



