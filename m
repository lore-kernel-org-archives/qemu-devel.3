Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94342D0D141
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 16:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdWap-0007au-T9; Wed, 07 Jan 2026 11:41:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vdWah-0007Hs-Er; Wed, 07 Jan 2026 11:40:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vdWaf-0004W6-Hx; Wed, 07 Jan 2026 11:40:59 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6079OliW020721;
 Wed, 7 Jan 2026 16:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=tv76nK
 UtBJWxlJBMS7yXTHdQ2mEd1Co96XCPLEF5Do4=; b=fTrSR/qYr2o0KZIq4WrUT0
 PEPLt5ZxIJqHmfqPEibbUOaGWBWkLr6DkN327YSKwNGEV+seL/4K6xNHFdYymWTe
 p0hMnoWEucjjIHprLI8+nMt+CuGNlAuG6PwLvh6lsGN4eT7vLsXO8eixd1FAGiQw
 vntyHWOM0c5SzheJwrR16o93v/7YMPjKexMi9Vkc/3kdvKHgMuytvWmrNAkjRuXn
 Y/vsxeHnV2KAofgaPPJOS23tW+7rr+datMghOL5FlSsQtShG0EJ7SEn3ugUGbu+K
 9JU6YEYshYYwmNjx5PUkvlNi5QgGtBeOHPzhtndC81ADQp7x/kjp4b7Ape4+xIFA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu6a34r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jan 2026 16:40:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 607FLYJq012604;
 Wed, 7 Jan 2026 16:40:54 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bffnjhyjg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jan 2026 16:40:54 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 607GerkT64487750
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Jan 2026 16:40:53 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7EAEC5805B;
 Wed,  7 Jan 2026 16:40:53 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9AC3F58055;
 Wed,  7 Jan 2026 16:40:52 +0000 (GMT)
Received: from [9.61.39.95] (unknown [9.61.39.95])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  7 Jan 2026 16:40:52 +0000 (GMT)
Message-ID: <07abe281-2917-408e-b6c1-2f97994cf426@linux.ibm.com>
Date: Wed, 7 Jan 2026 11:40:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] pc-bios/s390-ccw: Introduce CLP Architecture
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20251210205449.2783111-1-jrossi@linux.ibm.com>
 <20251210205449.2783111-6-jrossi@linux.ibm.com>
 <3a30e4c5-24be-449d-ac9f-16ce2096b31c@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <3a30e4c5-24be-449d-ac9f-16ce2096b31c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QbNrf8bv c=1 sm=1 tr=0 ts=695e8c97 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=nqNlaSPBC5J-8UOOWoMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: M5CAEPyMsrfsOUDyiid9-8xdJnAMPZUZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEyOCBTYWx0ZWRfXz+YAvOi/EIQi
 OlOT+2RrdsdYQ32Oo3a18rkalXiFs2+qw4eKqtVTi1Sz94YCNELfaVz72qmrr0RbKSryZmFHo/r
 8pJv6EKwV7iLfYvVH/pc2NJyX90RUt9ZcqmcxDqN4qfu1FuPh1Wqcyy8ygStYZl7+SxAtotNMSo
 1kN9UDdwaZn3XgX98/Hv+5gp1jTgvdjV9dceuCaNxzBcoHb6SJoRJeq0vBKARSnwGwLh0meKxYF
 4tC4ZmQxjy5JQ6N8UI8sUEFNsYbFY3AXl9vJ3NyZKIS7nabHskLJEwVB9vRpazOHigp/dy7L8jB
 rQ/6LY2aFhgN0WSZsHqtoi/obaBX7eMOFYQZnB1huGrAzLT/NsQMY27qjxIUIyiyIV4QINorZhB
 LJRCGXrN0kMQew2QAxls95TQXZW9YqlBZaDEzKrrgLEXom7gK1piyKnwRGstFqmqIC1ad+8519e
 UOItqmsjDkW6LCFLfvA==
X-Proofpoint-GUID: M5CAEPyMsrfsOUDyiid9-8xdJnAMPZUZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_02,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601070128
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
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

Hi Thomas,

All of the comments below raise good points, I'll fix them in the next 
version.

Thanks for your reviews.

Regards,
Jared Rossi

On 1/7/26 5:25 AM, Thomas Huth wrote:
> On 10/12/2025 21.54, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> Call Logical Processor (CLP) Architecture is used for managing PCI 
>> functions on
>> s390x. Define and include the structures and routines needed to 
>> interact with
>> PCI devices during IPL.
>>
>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>> ---
>>   pc-bios/s390-ccw/clp.h    | 24 ++++++++++
>>   pc-bios/s390-ccw/clp.c    | 96 +++++++++++++++++++++++++++++++++++++++
>>   pc-bios/s390-ccw/Makefile |  2 +-
>>   3 files changed, 121 insertions(+), 1 deletion(-)
>>   create mode 100644 pc-bios/s390-ccw/clp.h
>>   create mode 100644 pc-bios/s390-ccw/clp.c
>>
>> diff --git a/pc-bios/s390-ccw/clp.h b/pc-bios/s390-ccw/clp.h
>> new file mode 100644
>> index 0000000000..1ac2f8c177
>> --- /dev/null
>> +++ b/pc-bios/s390-ccw/clp.h
>> @@ -0,0 +1,24 @@
>> +/*
>> + * Call Logical Processor (CLP) architecture definitions
>> + *
>> + * Copyright 2025 IBM Corp.
>> + * Author(s): Jared Rossi <jrossi@linux.ibm.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef CLP_H
>> +#define CLP_H
>> +
>> +#ifndef QEMU_PACKED
>> +#define QEMU_PACKED __attribute__((packed))
>> +#endif
>> +
>> +#include <stdint.h>
>> +#include <s390-pci-clp.h>
>> +
>> +int clp_pci(void *data);
>> +int find_pci_function(uint32_t fid, ClpFhListEntry *entry);
>> +int enable_pci_function(uint32_t *fhandle);
>> +
>> +#endif
>> diff --git a/pc-bios/s390-ccw/clp.c b/pc-bios/s390-ccw/clp.c
>> new file mode 100644
>> index 0000000000..6dc72c685c
>> --- /dev/null
>> +++ b/pc-bios/s390-ccw/clp.c
>> @@ -0,0 +1,96 @@
>> +/*
>> + * Call Logical Processor (CLP) architecture
>> + *
>> + * Copyright 2025 IBM Corp.
>> + * Author(s): Jared Rossi <jrossi@linux.ibm.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "clp.h"
>> +#include <stdio.h>
>> +#include <string.h>
>> +
>> +int clp_pci(void *data)
>> +{
>> +    struct { uint8_t _[2048]; } *req = data;
>> +    int cc = 3;
>> +
>> +    asm volatile (
>> +        "     .insn   rrf,0xb9a00000,0,%[req],0,2\n"
>> +        "     ipm     %[cc]\n"
>> +        "     srl     %[cc],28\n"
>> +        : [cc] "+d" (cc), "+m" (*req)
>> +        : [req] "a" (req)
>> +        : "cc");
>> +    return cc;
>> +}
>> +
>> +/*
>> + * Get the PCI function entry for a given function ID
>> + * Return 0 on success, 1 if the FID is not found, or a negative RC 
>> on error
>> + */
>> +int find_pci_function(uint32_t fid, ClpFhListEntry *entry)
>> +{
>> +    int count = 0;
>> +    int limit = PCI_MAX_FUNCTIONS;
>> +    ClpReqRspListPci rrb;
>> +
>> +    rrb.request.hdr.len = 32;
>> +    rrb.request.hdr.cmd = 0x02;
>> +    rrb.request.resume_token = 0;
>> +    rrb.response.hdr.len = sizeof(ClpRspListPci);
>> +
>> +    do {
>> +        if (clp_pci(&rrb) || (rrb.response.hdr.rsp != 0x0010)) {
>
> You could drop the parentheses around rrb.response.hdr.rsp != 0x0010 
> here.
>
>> +            puts("Failed to list PCI functions");
>> +            return -1;
>> +        }
>> +
>> +        /* Resume token set when max enteries are returned */
>> +        if (rrb.response.resume_token) {
>> +            count = CLP_FH_LIST_NR_ENTRIES;
>> +            rrb.request.resume_token = rrb.response.resume_token;
>> +        } else {
>> +            count = (rrb.response.hdr.len - 32) / 
>> sizeof(ClpFhListEntry);
>> +        }
>> +
>> +        limit -= count;
>> +
>> +        for (int i = 0; i < count; i++) {
>> +            if (rrb.response.fh_list[i].fid == fid) {
>> +                memcpy(entry, &rrb.response.fh_list[i], 
>> sizeof(ClpFhListEntry));
>> +                return 0;
>> +            }
>> +        }
>> +
>> +    } while (rrb.request.resume_token && limit);
>
> Maybe check for "limit > 0", just in case... ?
>
>> +    puts("No function entry found for FID!");
>> +
>> +    return 1;
>> +}
>> +
>> +/*
>> + * Enable the PCI function associated with a given handle
>> + * Return 0 on success or a negative RC on error
>> + */
>> +int enable_pci_function(uint32_t *fhandle)
>> +{
>> +    ClpReqRspSetPci rrb;
>> +
>> +    rrb.request.hdr.len = 32;
>> +    rrb.request.hdr.cmd = 0x05;
>> +    rrb.request.fh = *fhandle;
>> +    rrb.request.oc = 0;
>> +    rrb.request.ndas = 1;
>> +    rrb.response.hdr.len = 32;
>> +
>> +    if (clp_pci(&rrb) || (rrb.response.hdr.rsp != 0x0010)) {
>
> Drop parentheses, please.
>
>> +        puts("Failed to enable PCI function");
>> +        return -1;
>> +    }
>> +
>> +    *fhandle = rrb.response.fh;
>> +    return 0;
>> +}
>> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
>> index 259cff09db..9c29548f84 100644
>> --- a/pc-bios/s390-ccw/Makefile
>> +++ b/pc-bios/s390-ccw/Makefile
>> @@ -35,7 +35,7 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
>>     OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o 
>> netmain.o \
>>         virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o 
>> dasd-ipl.o \
>> -      virtio-ccw.o
>> +      virtio-ccw.o clp.o
>>     SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
>
>  Thomas
>


