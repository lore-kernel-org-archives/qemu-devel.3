Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D1CC36019
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 07:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tz9gJ-0000Wq-SN; Mon, 31 Mar 2025 03:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schnelle@linux.ibm.com>)
 id 1tz9fV-0000OK-5A; Mon, 31 Mar 2025 03:34:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schnelle@linux.ibm.com>)
 id 1tz9fS-0001Uk-Gu; Mon, 31 Mar 2025 03:34:48 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52UKdDk2012078;
 Mon, 31 Mar 2025 07:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ag1gpn
 JGNOWgpD/GU4I5+3ROiYl6WAhVWkeQzMNCG60=; b=YiOkxzdX4AMrsHHT6C/BSK
 xj/ouTs8lkK++AvuvUYaG4hTE1jPl5pbbqFemzMY7MGF1eqFDGMlrkms2pAVh44D
 WbQeepxwUSWByDRKpkgaGY0HIKNNVg8au9Bnrfnt+zoVAT761cDuMv25973RHglu
 fqpqpQLQpz7ecf45My9xOTEVe2zTxHeW7JGvjeWHKEf4WuGJuctgG9YlCvmAWDcM
 o9lOmDhhJoWHgBo8VVJSzlX2gljWmg/QqH9AsUtlXviw8yjxLJBBTjaKVAp3hWNv
 djL8dTALGXdKmC035A3UhoZKxj7iOhraVXHy6x7u+2vjRFPSldOUHtFwVJPA8sTg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45qd601vms-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Mar 2025 07:34:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52V63d6d006609;
 Mon, 31 Mar 2025 07:34:36 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45pwdk4ms3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Mar 2025 07:34:36 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52V7YZl330737104
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Mar 2025 07:34:35 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 616A258054;
 Mon, 31 Mar 2025 07:34:35 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E561C58050;
 Mon, 31 Mar 2025 07:34:32 +0000 (GMT)
Received: from [9.171.48.16] (unknown [9.171.48.16])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Mar 2025 07:34:32 +0000 (GMT)
Message-ID: <f71a386140675de941f363bfcf85d63fdc41f506.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/3] util: Add functions for s390x mmio read/write
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org
Cc: mjrosato@linux.ibm.com, qemu-block@nongnu.org, qemu-s390x@nongnu.org,
 stefanha@redhat.com, fam@euphon.net, philmd@linaro.org,
 kwolf@redhat.com, hreitz@redhat.com, thuth@redhat.com
Date: Mon, 31 Mar 2025 09:34:32 +0200
In-Reply-To: <20250328190627.3025-2-alifm@linux.ibm.com>
References: <20250328190627.3025-1-alifm@linux.ibm.com>
 <20250328190627.3025-2-alifm@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nE73p8REtNh3977-960YfXOa1ZUXHOz8
X-Proofpoint-GUID: nE73p8REtNh3977-960YfXOa1ZUXHOz8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_03,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 clxscore=1011 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503310052
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=schnelle@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, 2025-03-28 at 12:06 -0700, Farhan Ali wrote:
> Starting with z15 (or newer) we can execute mmio
> instructions from userspace. On older platforms
> where we don't have these instructions available
> we can fallback to using system calls to access
> the PCI mapped resources.
>=20
> This patch adds helper functions for mmio reads
> and writes for s390x.
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  include/qemu/s390x_pci_mmio.h |  23 ++++++
>  util/meson.build              |   2 +
>  util/s390x_pci_mmio.c         | 148 ++++++++++++++++++++++++++++++++++
>  3 files changed, 173 insertions(+)
>  create mode 100644 include/qemu/s390x_pci_mmio.h
>  create mode 100644 util/s390x_pci_mmio.c
>=20
> diff --git a/include/qemu/s390x_pci_mmio.h b/include/qemu/s390x_pci_mmio.=
h
> new file mode 100644
> index 0000000000..aead791475
> --- /dev/null
> +++ b/include/qemu/s390x_pci_mmio.h
> @@ -0,0 +1,23 @@
> +/*
> + * s390x PCI MMIO definitions
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Farhan Ali <alifm@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef S390X_PCI_MMIO_H
> +#define S390X_PCI_MMIO_H
> +
> +uint8_t s390x_pci_mmio_read_8(const void *ioaddr);
> +uint16_t s390x_pci_mmio_read_16(const void *ioaddr);
> +uint32_t s390x_pci_mmio_read_32(const void *ioaddr);
> +uint64_t s390x_pci_mmio_read_64(const void *ioaddr);
> +
> +void s390x_pci_mmio_write_8(void *ioaddr, uint8_t val);
> +void s390x_pci_mmio_write_16(void *ioaddr, uint16_t val);
> +void s390x_pci_mmio_write_32(void *ioaddr, uint32_t val);
> +void s390x_pci_mmio_write_64(void *ioaddr, uint64_t val);
> +
> +
> +#endif
> diff --git a/util/meson.build b/util/meson.build
> index 780b5977a8..acb21592f9 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -131,4 +131,6 @@ elif cpu in ['ppc', 'ppc64']
>    util_ss.add(files('cpuinfo-ppc.c'))
>  elif cpu in ['riscv32', 'riscv64']
>    util_ss.add(files('cpuinfo-riscv.c'))
> +elif cpu =3D=3D 's390x'
> +  util_ss.add(files('s390x_pci_mmio.c'))
>  endif
> diff --git a/util/s390x_pci_mmio.c b/util/s390x_pci_mmio.c
> new file mode 100644
> index 0000000000..820458a026
> --- /dev/null
> +++ b/util/s390x_pci_mmio.c
> @@ -0,0 +1,148 @@
> +/*
> + * s390x PCI MMIO definitions
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Farhan Ali <alifm@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include <unistd.h>
> +#include <sys/syscall.h>
> +#include "qemu/s390x_pci_mmio.h"
> +#include "elf.h"
> +
> +union register_pair {
> +    unsigned __int128 pair;
> +    struct {
> +        uint64_t even;
> +        uint64_t odd;
> +    };
> +};
> +
> +static bool is_mio_supported;
> +
> +static __attribute__((constructor)) void check_is_mio_supported(void)
> +{
> +    is_mio_supported =3D !!(qemu_getauxval(AT_HWCAP) & HWCAP_S390_PCI_MI=
O);
> +}
> +
> +static uint64_t s390x_pcilgi(const void *ioaddr, size_t len)
> +{
> +    union register_pair ioaddr_len =3D { .even =3D (uint64_t)ioaddr,
> +                                       .odd =3D len };
> +    uint64_t val;
> +    int cc;
> +
> +    asm volatile(
> +        /* pcilgi */
> +        ".insn   rre,0xb9d60000,%[val],%[ioaddr_len]\n"
> +        "ipm     %[cc]\n"
> +        "srl     %[cc],28\n"
> +        : [cc] "=3Dd"(cc), [val] "=3Dd"(val),
> +        [ioaddr_len] "+&d"(ioaddr_len.pair) :: "cc");
> +
> +    if (cc) {
> +        val =3D -1ULL;
> +    }
> +
> +    return val;
> +}
> +
> +static void s390x_pcistgi(void *ioaddr, uint64_t val, size_t len)
> +{
> +    union register_pair ioaddr_len =3D {.even =3D (uint64_t)ioaddr, .odd=
 =3D len};
> +
> +    asm volatile (
> +        /* pcistgi */
> +        ".insn   rre,0xb9d40000,%[val],%[ioaddr_len]\n"
> +        : [ioaddr_len] "+&d" (ioaddr_len.pair)
> +        : [val] "d" (val)
> +        : "cc", "memory");
> +}

I can confirm that the PCI MIO inline assembly looks good to me.
Pretty much exactly matches what I did for rdma-core a while back.

> +
> +uint8_t s390x_pci_mmio_read_8(const void *ioaddr)
> +{
> +    uint8_t val =3D 0;
> +
> +    if (is_mio_supported) {
> +        val =3D s390x_pcilgi(ioaddr, sizeof(val));
> +    } else {
> +        syscall(__NR_s390_pci_mmio_read, ioaddr, &val, sizeof(val));
> +    }
> +    return val;
> +}
> +
>=20
--- snip ---
> +
> +void s390x_pci_mmio_write_64(void *ioaddr, uint64_t val)
> +{
> +    if (is_mio_supported) {
> +        s390x_pcistgi(ioaddr, val, sizeof(val));
> +    } else {
> +        syscall(__NR_s390_pci_mmio_write, ioaddr, &val, sizeof(val));
> +    }
> +}
> +

Thanks for the great work!

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>


