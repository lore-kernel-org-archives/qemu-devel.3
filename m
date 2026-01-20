Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B4ED2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 14:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viCre-0006sG-Do; Tue, 20 Jan 2026 09:37:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1viCrd-0006pd-D7; Tue, 20 Jan 2026 09:37:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1viCrb-0005uR-Lw; Tue, 20 Jan 2026 09:37:49 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60K8EUYB027782;
 Tue, 20 Jan 2026 14:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=DW2E5y
 /tAGsotUppqqK8WTcEpaQJpDzAV63txj1k+sM=; b=bKPxzPtfQj+/5qBKzll2uC
 BPxYtKuP+Vd2qc6w1Z/T/YRORdclfB2i7M7xOt/8e0h2chcrBq7fAPTQFQLQqYEL
 qHQPBAqKwK0iBK/z+slWH46wh6E4XuRLp84w6+Sr3dDGs5niikyPBfGbVuPZ6kGQ
 4KP368AuoCxfpfpUTB5dgbtARQ/d0Q1zeUdjctBuzt0tAia4hvheguTfmTt5M6NV
 J4CSi6HP+UvcVFMuBKYY1CGBQf5jCIFNqAvvyej9kQGfoQ1JjSGn5lXoASmrbSt9
 0/FMDf1W/TbE/u+hpQYdMHLyH4syvkkK/F+oKO8+tImXo7ISjXfgJZHan8knZPfA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt6121nre-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Jan 2026 14:37:46 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60KEbj9R002954;
 Tue, 20 Jan 2026 14:37:45 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt6121nr8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Jan 2026 14:37:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60KBU9uK006424;
 Tue, 20 Jan 2026 14:37:44 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brqf1d3qe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Jan 2026 14:37:44 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60KEbhZ432113350
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Jan 2026 14:37:43 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3709458053;
 Tue, 20 Jan 2026 14:37:43 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88F525805D;
 Tue, 20 Jan 2026 14:37:42 +0000 (GMT)
Received: from [9.10.80.137] (unknown [9.10.80.137])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Jan 2026 14:37:42 +0000 (GMT)
Message-ID: <018b80f0-9e8c-47ac-afb5-2637645bcb73@linux.ibm.com>
Date: Tue, 20 Jan 2026 08:37:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/pnv: Add a nest MMU model
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 milesg@linux.ibm.com, rathc@linux.ibm.com, fbarrat@linux.ibm.com,
 chalapathi.v@linux.ibm.com
References: <20251223145919.2540097-1-calebs@linux.ibm.com>
 <aW3YurqVBVVOWR9D@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <aW3YurqVBVVOWR9D@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ShMuHIBr6EVb7c3y4L2b5smC-VXEnL7f
X-Authority-Analysis: v=2.4 cv=LaIxKzfi c=1 sm=1 tr=0 ts=696f933a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=AbRaTJqPVgk_HY5UopYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: i0_a7kwU-gmBLd-w1WG1qaZase5eR-w1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDExOCBTYWx0ZWRfX6PrOo8olnvo7
 1h9zbfS+7con8oj+HesXSIGYp1OpNlhN1N8e2sKgJ6oRX0CNrTBlkILAJIbZBG3wkrDxZMy9Eq1
 j1HgYKW6jmgq8kGL8k/oE55QuNoIl6UxH0vg/iCqvRT+zLipQId9SDojh0k2+J5igFHcbZPE7Ac
 +RiLheR8NIaUgrh2DxigGkAvggurY9/Zkb1sfTBlZ0hUyGvEQDXRumL86uOib2YS4thvKuP2pFL
 mk3LL3QGvzIHzo5FAUlQIJSHRsdxKlfT84K+TnMEti+MCwAFp7ST0q1Fpiaucf3RUP8i5kxYvk8
 CESONdGSCdbgZPwq1S5neFW9ztPahNUrKhOOuB8fiQxkP8QzdV0kqymWbkqDdrPkVCvK5O2VhY5
 eCKeSKYKwP5fCJNQyQ1UK/LKF58Pd9baPRU/x0sGx59+R+b4ow9/YSNAKewvI85lJBK/Q5UodyI
 BXNnnGAhAfoPMRDIgxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_03,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601200118
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 1/19/26 1:42 AM, Aditya Gupta wrote:
> Thanks for adding Nest MMU, Caleb !
> 
> Currently seeing a build failure due to recent changes in upstream,
> details and reviews below.
> 
> On 25/12/23 08:59AM, Caleb Schlossin wrote:
>> The nest MMU is used for translations needed by I/O subsystems
>> on Power10. The nest is the shared, on-chip infrastructure
>> that connects CPU cores, memory controllers, and I/O.
>>
>> This patch sets up a basic skeleton with its xscom
>> area, mapping both needed xscom regions. Support required
>> for PowerVM bringup.
>>
>> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
>> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
>> Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
>> ---
>>
>>> <...snip...>
>>
>> diff --git a/hw/ppc/pnv_nmmu.c b/hw/ppc/pnv_nmmu.c
>> new file mode 100644
>> index 0000000000..37c739b242
>> --- /dev/null
>> +++ b/hw/ppc/pnv_nmmu.c
>> @@ -0,0 +1,132 @@
>> +/*
>> + * QEMU PowerPC nest MMU model
>> + *
>> + * Copyright (c) 2025, IBM Corporation.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + *
>> + * This code is licensed under the GPL version 2 or later. See the
>> + * COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/log.h"
>> +#include "hw/qdev-properties.h"
> 
> With below commit, the header `hw/qdev-properties.h` has moved to
> `hw/core/qdev-properties.h`
> 
> This causes the compile to fail, can you rebase on upstream and send
> this again as v2 ?
> 
> 	commit 78d45220b4e6385c6a90302fbc84fdacb415580c
> 	Author: Paolo Bonzini <pbonzini@redhat.com>
> 	Date:   Thu Nov 27 08:38:05 2025 +0100
> 	
> 	    include: move hw/qdev-properties.h to hw/core/
> 
>>
>>> <...snip...>

Yup, I'll get this fixed in v2.

>>
>> +static int pnv_nmmu_dt_xscom(PnvXScomInterface *dev, void *fdt,
>> +                             int offset)
>> +{
>> +    PnvNMMU *nmmu = PNV_NMMU(dev);
>> +    char *name;
>> +    int nmmu_offset;
>> +    const char compat[] = "ibm,power10-nest-mmu";
> 
> OPAL looks for compat property "ibm,power9-nest-mmu", as NMMU is treated
> the same in Power9 and Power10 (atleast from opal's perspective)
> 
> The Linux kernel asks OPAL itself to do Nest MMU set ptcr, so kernel
> doesn't care about the compat string.
> 
> Can we use same ibm,power9-nest-mmu compat string here too ? What do you
> say ?
> 
> Other than above reviews, the code looks good to me, Thanks !
> 
> - Aditya G
> 

That should be fine, I'll make that update in v2.

Thanks,
Caleb


