Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26F8C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 19:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txtIB-0000Oy-JY; Thu, 27 Mar 2025 15:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1txtI2-0000OM-DR; Thu, 27 Mar 2025 15:53:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1txtHz-0006kb-OC; Thu, 27 Mar 2025 15:53:22 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RDfHpI029887;
 Thu, 27 Mar 2025 19:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=dWC4rE
 0bNxlCdwDd0jxwSEKlaw4DSwqvsP8O0fhegDo=; b=Phlzd6eQkE5H3+g0ntzVvf
 +2+l/v3snrN//yn6RNQnUYgIg93jBxvE+pvKENQOCMAAP6AcDHvphw7voWncsN9o
 eOoBLH/nyi2yC4PGlGn733vTMoe4rxv3hSlL3h9ZjVhq3AKVaMSFj25swF/E5NwI
 1yhC1AlGhyCwZR/WdTF+3kOxRDM9+Jz3e2LTddIHWMAfcdnAP5ZLa2sqcx8fEFDJ
 Tc/NxmuJBemXmvGTIpNDygUMoL2ma5GEJlyDrrPgpICmZAW/jFWPArVbSkRYEplT
 itENClGs+kh5IJ57VcC6Bzu+L5sgmKpdP9khSgZY0BvirCEmTLk6zyBSCafxA7gw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45my29cy40-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Mar 2025 19:53:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52RJoQHL012250;
 Thu, 27 Mar 2025 19:53:12 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j91mexty-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Mar 2025 19:53:12 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52RJrBkU25297478
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Mar 2025 19:53:11 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B1575805A;
 Thu, 27 Mar 2025 19:53:11 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 800BA5805C;
 Thu, 27 Mar 2025 19:53:10 +0000 (GMT)
Received: from [9.61.251.62] (unknown [9.61.251.62])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Mar 2025 19:53:10 +0000 (GMT)
Message-ID: <a2bae416-8d95-44ea-9cf5-fff5f9bf09f8@linux.ibm.com>
Date: Thu, 27 Mar 2025 12:53:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] util: Add functions for s390x mmio read/write
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, mjrosato@linux.ibm.com, schnelle@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-block@nongnu.org, fam@euphon.net,
 philmd@linaro.org, kwolf@redhat.com, hreitz@redhat.com, thuth@redhat.com
References: <20250326181007.1099-1-alifm@linux.ibm.com>
 <20250326181007.1099-2-alifm@linux.ibm.com> <20250327192052.GC46883@fedora>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20250327192052.GC46883@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YHgfqaW2V_JXAkAPsfZpN3RQ1oSk0VxS
X-Proofpoint-ORIG-GUID: YHgfqaW2V_JXAkAPsfZpN3RQ1oSk0VxS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_03,2025-03-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=946 suspectscore=0 impostorscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503270131
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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


On 3/27/2025 12:20 PM, Stefan Hajnoczi wrote:
> On Wed, Mar 26, 2025 at 11:10:06AM -0700, Farhan Ali wrote:
>> Starting with z15 (or newer) we can execute mmio
>> instructions from userspace. On older platforms
>> where we don't have these instructions available
>> we can fallback to using system calls to access
>> the PCI mapped resources.
>>
>> This patch adds helper functions for mmio reads
>> and writes for s390x.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   include/qemu/s390x_pci_mmio.h |  17 ++++++
>>   util/meson.build              |   2 +
>>   util/s390x_pci_mmio.c         | 105 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 124 insertions(+)
>>   create mode 100644 include/qemu/s390x_pci_mmio.h
>>   create mode 100644 util/s390x_pci_mmio.c
>>
>> diff --git a/include/qemu/s390x_pci_mmio.h b/include/qemu/s390x_pci_mmio.h
>> new file mode 100644
>> index 0000000000..be61b5ae29
>> --- /dev/null
>> +++ b/include/qemu/s390x_pci_mmio.h
>> @@ -0,0 +1,17 @@
>> +/*
>> + * s390x PCI MMIO definitions
>> + *
>> + * Copyright 2025 IBM Corp.
>> + * Author(s): Farhan Ali <alifm@linux.ibm.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +#ifndef S390X_PCI_MMIO_H
>> +#define S390X_PCI_MMIO_H
>> +
>> +uint64_t s390x_pci_mmio_read_64(const void *ioaddr);
>> +uint32_t s390x_pci_mmio_read_32(const void *ioaddr);
>> +void s390x_pci_mmio_write_64(void *ioaddr, uint64_t val);
>> +void s390x_pci_mmio_write_32(void *ioaddr, uint32_t val);
>> +
>> +#endif
>> diff --git a/util/meson.build b/util/meson.build
>> index 780b5977a8..acb21592f9 100644
>> --- a/util/meson.build
>> +++ b/util/meson.build
>> @@ -131,4 +131,6 @@ elif cpu in ['ppc', 'ppc64']
>>     util_ss.add(files('cpuinfo-ppc.c'))
>>   elif cpu in ['riscv32', 'riscv64']
>>     util_ss.add(files('cpuinfo-riscv.c'))
>> +elif cpu == 's390x'
>> +  util_ss.add(files('s390x_pci_mmio.c'))
>>   endif
>> diff --git a/util/s390x_pci_mmio.c b/util/s390x_pci_mmio.c
>> new file mode 100644
>> index 0000000000..2e0825d617
>> --- /dev/null
>> +++ b/util/s390x_pci_mmio.c
>> @@ -0,0 +1,105 @@
>> +/*
>> + * s390x PCI MMIO definitions
>> + *
>> + * Copyright 2025 IBM Corp.
>> + * Author(s): Farhan Ali <alifm@linux.ibm.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include <unistd.h>
>> +#include <sys/syscall.h>
>> +#include "qemu/osdep.h"
> This should be the first #include in the file. From
> docs/devel/style.rst:
>
>    Include directives
>    ------------------
>    
>    Order include directives as follows:
>    
>    .. code-block:: c
>    
>        #include "qemu/osdep.h"  /* Always first... */
>        #include <...>           /* then system headers... */
>        #include "..."           /* and finally QEMU headers. */
>
> Otherwise:
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Will fix in next revision. Thanks!



