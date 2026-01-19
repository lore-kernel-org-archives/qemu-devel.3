Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8948BCA5FFF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 07:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhjvJ-0001pL-2s; Mon, 19 Jan 2026 02:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vhjua-0001hm-H7; Mon, 19 Jan 2026 02:42:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vhjuV-0002cP-7b; Mon, 19 Jan 2026 02:42:54 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60INj2Tu030226;
 Mon, 19 Jan 2026 07:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=MRKknXDWhEOjMt1S8OgigU33DPDB/f
 HbjSC3FE07Rc4=; b=LOwZDJ92Cn4Kng51a4BGdE1Y6lTvGubQ1PFddcpuWibcc6
 Z9s+QhDpOv3/8wPR8afiGtujaRXdinJvAmXtGhgm6iZKHczhyeAiMlhkR3INGiIq
 Y7G6u/ygkaf2J3Tn0oZFsmq0mZieqryVIjAIGkMqcHCMBrrZJPYQaURUxGkbYcSI
 V1FRrlEjLl/tLx/cEyYY3UQ2+wjdgp3YnYjV47Eh1eM0ximR4LPTxlYV/7N2Ws2T
 RTK3MFSsnSTALCfBEyDui/FP5FjKyPjO2TZtIi79WGyn4rGveaKMrPpgQUB/9yU0
 +K4qU6ubeXxW7lMPZNzCqOylamYwGO2AoJnuep2g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br0uf6h9a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jan 2026 07:42:49 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60J7fGKf029777;
 Mon, 19 Jan 2026 07:42:49 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br0uf6h98-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jan 2026 07:42:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60J6tKkK016668;
 Mon, 19 Jan 2026 07:42:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brn4xnj8g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jan 2026 07:42:48 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60J7gipP60817738
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Jan 2026 07:42:44 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6834C20040;
 Mon, 19 Jan 2026 07:42:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9933C20043;
 Mon, 19 Jan 2026 07:42:41 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.21.137]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 19 Jan 2026 07:42:41 +0000 (GMT)
Date: Mon, 19 Jan 2026 13:12:38 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Caleb Schlossin <calebs@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 milesg@linux.ibm.com, rathc@linux.ibm.com, fbarrat@linux.ibm.com,
 chalapathi.v@linux.ibm.com
Subject: Re: [PATCH] ppc/pnv: Add a nest MMU model
Message-ID: <aW3YurqVBVVOWR9D@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20251223145919.2540097-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223145919.2540097-1-calebs@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BhNOdVQ8123mW489mI-xA3u5Ubi9FgFE
X-Proofpoint-ORIG-GUID: xAso3TVkEpvLmZ8S6gRO2QIWLxldy27e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA1OSBTYWx0ZWRfX5lbfV9YG3fdW
 /2N9qIJQE0CHHn4wYRmnu5wRdNk9sKDMy/dqgnTc7flqQCq3jQBIu/+m5dLVvpOjfQPV9w93TrS
 AXDhrwYnjStj4ELP4Gcj4zHYxKIaCacytorWl6lYt6Al2vgTuwsBsUHVOseWeACZL2g5UGO4yGG
 Kq6LMS/1Uhrl0kCqWJvToX+v0MbREFxFBVKCTN5hEsUEmvTmRwpUxuLOWx3TQflCj4FvEzky//v
 T1vZm9VkAXZWDSY9d6NmQWLNxbS0m7byEguufyUBquv+QUVZyHz3o+OUXZte+b8k5QzKFXR3K+5
 /3IuICd8DSSrSX+bvXwX1DDeFBeS75aRqxsbpNQpbUTMmGySvJCiT1HqklpqWe0b5NWsBYuMrcQ
 2tJB5ZtdECIc9fEE7Do8g3GaUPT1CDPhqRLPTaW8qQlJjKvWioM4wQpBYgrlIjpWCAdfuGCnLyJ
 D2mfvql/1zcMgZVYlyw==
X-Authority-Analysis: v=2.4 cv=bopBxUai c=1 sm=1 tr=0 ts=696de079 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=gMGx47IG0rqLUk0jqDcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_01,2026-01-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601190059
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Thanks for adding Nest MMU, Caleb !

Currently seeing a build failure due to recent changes in upstream,
details and reviews below.

On 25/12/23 08:59AM, Caleb Schlossin wrote:
> The nest MMU is used for translations needed by I/O subsystems
> on Power10. The nest is the shared, on-chip infrastructure
> that connects CPU cores, memory controllers, and I/O.
> 
> This patch sets up a basic skeleton with its xscom
> area, mapping both needed xscom regions. Support required
> for PowerVM bringup.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
> ---
>
> > <...snip...>
>
> diff --git a/hw/ppc/pnv_nmmu.c b/hw/ppc/pnv_nmmu.c
> new file mode 100644
> index 0000000000..37c739b242
> --- /dev/null
> +++ b/hw/ppc/pnv_nmmu.c
> @@ -0,0 +1,132 @@
> +/*
> + * QEMU PowerPC nest MMU model
> + *
> + * Copyright (c) 2025, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/qdev-properties.h"

With below commit, the header `hw/qdev-properties.h` has moved to
`hw/core/qdev-properties.h`

This causes the compile to fail, can you rebase on upstream and send
this again as v2 ?

	commit 78d45220b4e6385c6a90302fbc84fdacb415580c
	Author: Paolo Bonzini <pbonzini@redhat.com>
	Date:   Thu Nov 27 08:38:05 2025 +0100
	
	    include: move hw/qdev-properties.h to hw/core/

>
> > <...snip...>
>
> +static int pnv_nmmu_dt_xscom(PnvXScomInterface *dev, void *fdt,
> +                             int offset)
> +{
> +    PnvNMMU *nmmu = PNV_NMMU(dev);
> +    char *name;
> +    int nmmu_offset;
> +    const char compat[] = "ibm,power10-nest-mmu";

OPAL looks for compat property "ibm,power9-nest-mmu", as NMMU is treated
the same in Power9 and Power10 (atleast from opal's perspective)

The Linux kernel asks OPAL itself to do Nest MMU set ptcr, so kernel
doesn't care about the compat string.

Can we use same ibm,power9-nest-mmu compat string here too ? What do you
say ?

Other than above reviews, the code looks good to me, Thanks !

- Aditya G


