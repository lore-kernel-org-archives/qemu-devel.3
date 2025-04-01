Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1E1C36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 13:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbGz-0004Os-KD; Tue, 01 Apr 2025 09:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1tzbGS-00044G-3E; Tue, 01 Apr 2025 09:02:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1tzbGN-0007p6-NI; Tue, 01 Apr 2025 09:02:46 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5318H4vv031663;
 Tue, 1 Apr 2025 13:02:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=sKXRMF
 nLLEPke4M+WOEPOpV7BhiNDdKP+JnzaWuETKw=; b=jJZpB4uCSJ/DgtfwRSHaod
 n3OBj5QmXQlDJMHmYCEl0t9BUvhNCdOlTld2i7rK1B2n0OdLK27hMIt090L9JHTr
 PcOyG2xeUU5/yQ+kahCjRFemnHMsghXbqLSkMPUbJDVdND8DXYijBqQBISKOWFCZ
 yaQ7E6Y/xkzeyb6gDdsGhWhu53eJvioFtzN/8CAk0oNuJLBfZnZZbLxbHPMIqPlK
 jTcmi7Z9vkb1ELgpNGLOhtzEe/Sf/gbdIINshYDFupr5Te2Q3OdiXuRYD/pOBNLn
 ohQV0OyF7+QhDoGzAW8QNpnlUuwfw1HHimDN+6qpSFEP6is6XL2zps4zngpYMbRw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45r27q3qbb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Apr 2025 13:02:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5319JGqo001719;
 Tue, 1 Apr 2025 13:02:33 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45rddkrs5a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Apr 2025 13:02:33 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 531D2Wtw31261296
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Apr 2025 13:02:32 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F69158059;
 Tue,  1 Apr 2025 13:02:32 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0783258053;
 Tue,  1 Apr 2025 13:02:31 +0000 (GMT)
Received: from [9.61.240.231] (unknown [9.61.240.231])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  1 Apr 2025 13:02:30 +0000 (GMT)
Message-ID: <20f92b8e-969f-4a0a-a2c8-62fe95b88690@linux.ibm.com>
Date: Tue, 1 Apr 2025 06:02:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] include: Add a header to define PCI MMIO functions
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, mjrosato@linux.ibm.com, schnelle@linux.ibm.com,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, fam@euphon.net,
 philmd@linaro.org, kwolf@redhat.com, hreitz@redhat.com, thuth@redhat.com
References: <20250328190627.3025-1-alifm@linux.ibm.com>
 <20250328190627.3025-3-alifm@linux.ibm.com> <20250331134656.GC190936@fedora>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20250331134656.GC190936@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MLCOVzT8jRWhBS8waEcNilGwAFqKIn4r
X-Proofpoint-GUID: MLCOVzT8jRWhBS8waEcNilGwAFqKIn4r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_05,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=868
 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504010080
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 3/31/2025 6:46 AM, Stefan Hajnoczi wrote:
> On Fri, Mar 28, 2025 at 12:06:26PM -0700, Farhan Ali wrote:
>> Add a generic QEMU API for PCI MMIO reads/writes.
>> The functions access little endian memory and returns
>> the result in host cpu endianness.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   include/qemu/pci-mmio.h | 116 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 116 insertions(+)
>>   create mode 100644 include/qemu/pci-mmio.h
>>
>> diff --git a/include/qemu/pci-mmio.h b/include/qemu/pci-mmio.h
>> new file mode 100644
>> index 0000000000..2ef92455b1
>> --- /dev/null
>> +++ b/include/qemu/pci-mmio.h
>> @@ -0,0 +1,116 @@
>> +/*
>> + * QEMU PCI MMIO API
> QEMU also emulates PCI devices that handle MMIO accesses. It is easy to
> get confused between host PCI MMIO accesses and emulated guest PCI MMIO
> accesses if the name is just "PCI MMIO API".
>
> Please update the commit message, filenames, function names, and doc
> comments to make it clear that this is only for host PCI MMIO accesses
> (e.g. Linux VFIO BAR accesses).
>
> For example "qemu/host-pci-mmio.h", "API for host PCI MMIO accesses
> (e.g. Linux VFIO BARs)", and host_pci_mmio_read_8().

yeah this makes sense. Will update the API names in v3.


>> + *
>> + * Copyright 2025 IBM Corp.
>> + * Author(s): Farhan Ali <alifm@linux.ibm.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef QEMU_PCI_MMIO_H
>> +#define QEMU_PCI_MMIO_H
>> +
>> +#ifdef __s390x__
>> +#include "s390x_pci_mmio.h"
>> +#endif
>> +
>> +static inline uint8_t qemu_pci_mmio_read_8(const void *ioaddr)
>> +{
>> +    uint8_t ret = 0;
>> +#ifdef __s390x__
>> +    ret = s390x_pci_mmio_read_8(ioaddr);
>> +#else
>> +    /* Prevent the compiler from optimizing away the load */
>> +    ret = *((volatile uint8_t *)ioaddr);
>> +#endif
>> +
>> +    return ret;
>> +}
>> +
>> +static inline uint16_t qemu_pci_mmio_read_16(const void *ioaddr)
>> +{
>> +    uint16_t ret = 0;
>> +#ifdef __s390x__
>> +    ret = s390x_pci_mmio_read_16(ioaddr);
>> +#else
>> +    /* Prevent the compiler from optimizing away the load */
>> +    ret = *((volatile uint16_t *)ioaddr);
>> +#endif
>> +
>> +    return le16_to_cpu(ret);
>> +}
>> +
>> +static inline uint32_t qemu_pci_mmio_read_32(const void *ioaddr)
>> +{
>> +    uint32_t ret = 0;
>> +#ifdef __s390x__
>> +    ret = s390x_pci_mmio_read_32(ioaddr);
>> +#else
>> +    /* Prevent the compiler from optimizing away the load */
>> +    ret = *((volatile uint32_t *)ioaddr);
>> +#endif
>> +
>> +    return le32_to_cpu(ret);
>> +}
>> +
>> +static inline uint64_t qemu_pci_mmio_read_64(const void *ioaddr)
>> +{
>> +    uint64_t ret = 0;
>> +#ifdef __s390x__
>> +    ret = s390x_pci_mmio_read_64(ioaddr);
>> +#else
>> +    /* Prevent the compiler from optimizing away the load */
>> +    ret = *((volatile uint64_t *)ioaddr);
>> +#endif
>> +
>> +    return le64_to_cpu(ret);
>> +}
>> +
>> +static inline void qemu_pci_mmio_write_8(void *ioaddr, uint8_t val)
>> +{
>> +
>> +#ifdef __s390x__
>> +    s390x_pci_mmio_write_8(ioaddr, val);
>> +#else
>> +    /* Prevent the compiler from optimizing away the store */
>> +    *((volatile uint8_t *)ioaddr) = val;
>> +#endif
>> +}
>> +
>> +static inline void qemu_pci_mmio_write_16(void *ioaddr, uint16_t val)
>> +{
>> +    val = cpu_to_le16(val);
>> +
>> +#ifdef __s390x__
>> +    s390x_pci_mmio_write_16(ioaddr, val);
>> +#else
>> +    /* Prevent the compiler from optimizing away the store */
>> +    *((volatile uint16_t *)ioaddr) = val;
>> +#endif
>> +}
>> +
>> +static inline void qemu_pci_mmio_write_32(void *ioaddr, uint32_t val)
>> +{
>> +    val = cpu_to_le32(val);
>> +
>> +#ifdef __s390x__
>> +    s390x_pci_mmio_write_32(ioaddr, val);
>> +#else
>> +    /* Prevent the compiler from optimizing away the store */
>> +    *((volatile uint32_t *)ioaddr) = val;
>> +#endif
>> +}
>> +
>> +static inline void qemu_pci_mmio_write_64(void *ioaddr, uint64_t val)
>> +{
>> +    val = cpu_to_le64(val);
>> +
>> +#ifdef __s390x__
>> +    s390x_pci_mmio_write_64(ioaddr, val);
>> +#else
>> +    /* Prevent the compiler from optimizing away the store */
>> +    *((volatile uint64_t *)ioaddr) = val;
>> +#endif
>> +}
>> +
>> +#endif
>> -- 
>> 2.43.0
>>

