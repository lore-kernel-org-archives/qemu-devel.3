Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B994C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 12:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5MzX-0003U2-Eg; Sat, 12 Sep 2026 08:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1x5MzV-0003TV-Co; Sat, 12 Sep 2026 08:37:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1x5MzT-00022k-NK; Sat, 12 Sep 2026 08:37:57 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68CC25EY469127; Sat, 12 Sep 2026 12:37:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=xoU0x2yVDLTASpUCdCfkjiF5R3GQdr
 xmsnZ2NVQ56Ww=; b=rjMkTXVZqfErD3tWG3k4Q9S4Ge3Gb2pq4laUaVr+Wr2viN
 HcK4ZPHgYmx247lDq8ljbvzlKx6lJ7a5ankI7XtWvDhnU+ckSU5saPmlXDpvmSbO
 0TmU02WDI7j2o7C079iEow3/xoPPhpY+HNlPrNDAYmmW5xOq5paYGmspG/U+iGHT
 jNq/0NpsE+oSUxNc7ElbA0NSKEkIYTxgeoIUn/QxVXNnVCvVPxXLRdFmT+4jcjae
 rcMaSvuPQv+N8RHmlKkJdtb4K5QjfsH3jPKQeFTQ+PdzrCR3HWtP4cuzgV2Tbuwm
 NJmJLbmWgjDRt70/tXaGRrwCwHCgdaWd9bFCsCJw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf4h9t8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 12 Sep 2026 12:37:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68CBbFkN3260380; Sat, 12 Sep 2026 12:37:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gn3w2gf8m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 12 Sep 2026 12:37:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68CCbdGh49349000
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 12 Sep 2026 12:37:39 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 49EBC20043;
 Sat, 12 Sep 2026 12:37:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8FD4520040;
 Sat, 12 Sep 2026 12:37:34 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.87.143.209])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Sat, 12 Sep 2026 12:37:34 +0000 (GMT)
Date: Sat, 12 Sep 2026 18:07:31 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Saif Abrar <saif.abrar@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, harshpb@linux.ibm.com,
 clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 kowal@linux.ibm.com, chalapathi.v@linux.ibm.com, calebs@linux.ibm.com,
 milesg@linux.ibm.com, jishnuvw@linux.ibm.com, amachhiw@linux.ibm.com
Subject: Re: [PATCH v6 1/9] qtest/phb5: Add testbench for PHB
Message-ID: <aqVG7Lwttp09t6iC@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260831123005.1485518-1-saif.abrar@linux.ibm.com>
 <20260831123005.1485518-2-saif.abrar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831123005.1485518-2-saif.abrar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: cnJ3PjtBs-5cyutHQC47j3cyayJJxL2-
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDE4MSBTYWx0ZWRfX0aLGiYcCkuSR
 On8TKc09i7NnI3qvqgcL2PUj/k2wM7fj7Ze/WiZMqmnKg0I8wGvgsY9jgSIvWuVcv/tXbzYgFnv
 jiFaX6I7cs972glELFb/MYYsBPGhmvY=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aa54798 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=RHt9xJug9SURXYNH6wEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Sny_1sGvcMLwgUTFHQSlYh2XzeTm_VVZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDE4MSBTYWx0ZWRfX3elSD8OAO4JW
 YPmv7fvKhKc2OC2zBYLYfCfwOcNz9IJ3Cbd6gSMWHFRRiHmZJdiT16QXhwmLsq+Qy9CibnqHZOS
 glO1ScDxzRW/ogC+tfAJHtZ6hAOsQwtpYOYKr2cbsW+p7XKyqzj99tkdvuSO9CENnP1FIXboYG9
 PwhXmBGFfux/7ZneAhWir0X0f0VuRtz2Ii5cZBF9R1r9HRBox+MXOA7lU33wdk3uUHcQuN6Ug2d
 sbgNlEquhr76NC/A91daZbRGx50ifHlLVVQSYDZ6vOLOSODyEWTQo2vzPkV67vKV0zXs7CHMPPC
 0aAyI7GB3h0q58BAcZEL2Lr4GgofVbFv61RPtXQzqN8EotBd5y00zQRHXNvAaws/F9ezNydwPvx
 R1VkHdbuzgJ4ipVrF5V08PKpjsYrfiT2x0mH5kCmXA9ltWagD0LDzv54QvxFlqhWhyIq9gvL9QU
 tmvfqlQff6ykJMH0Clw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_04,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609120181
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 26/08/31 07:29AM, Saif Abrar wrote:
> From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
> > <...snip...>
> --- /dev/null
> +++ b/tests/qtest/pnv-phb-test.c
> @@ -0,0 +1,100 @@
> +/*
> + * QTest testcase for PowerNV PHB
> + *
> + * Copyright (c) 2026, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "hw/pci-host/pnv_phb4_regs.h"
> +#include "pnv-xscom.h"
> +#include "pnv-qtest-common.h"
> +
> +#define PHB3_PBCQ_SPCI_ASB_ADDR      0x0
> +#define PHB3_PBCQ_SPCI_ASB_DATA      0x2
> +
> +/* Index of PNV_CHIP_POWER10 in pnv_chips[] within "pnv-xscom.h" */

minor nit: seems like a leftover comment from patch #3

please feel free to retain the rb with above removed:

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>

Thanks,
- Aditya G


