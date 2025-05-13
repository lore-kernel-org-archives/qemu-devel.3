Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B1AC3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 11:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEnyp-0005kZ-45; Tue, 13 May 2025 07:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1uEnyZ-0005aN-CH; Tue, 13 May 2025 07:39:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1uEnyV-0000xR-UX; Tue, 13 May 2025 07:39:09 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D8pKlE012755;
 Tue, 13 May 2025 11:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vZ693k
 AQdLAxW2dQCyrBxtWYz+e7/+Ll94xicC8WLZs=; b=WZf6E+SHXS+cyl48qR4uyC
 JTWd+A+BMjcRlBNDfBso7ZR5FPiPPkKzgoXFG2pZ6fl8pF2uO8R0JYFYMhULfI+M
 uEC0VNqo5ABwL96Sm4NIwa3CvCX1YSLn+G6ingNRdiHuGO6KbscO6HiDs9xPBO/O
 b4m4ths7DeNgkORjFVRBJgJhnpSofx/u1fPMr+Ht1Wq636eBi8DxsP5bORvBnOpX
 woT05+k17feKthjmujGwMgNjDzBg/8p1/MPUcOIocjzY5GS3f8jdqsr9lb2+2CLa
 TciV1aRu5XdyddOxLC73m9Oexbpk+RpdLOl+GIvbGGU+6Gt6d4SqC4PJrzXABBkA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46m2xh0t1u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 May 2025 11:39:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54DAIVAw024427;
 Tue, 13 May 2025 11:39:02 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46jjmm2s5e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 May 2025 11:39:02 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54DBd1vV37159594
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 May 2025 11:39:01 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0027A5805A;
 Tue, 13 May 2025 11:39:01 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C011A5805C;
 Tue, 13 May 2025 11:38:59 +0000 (GMT)
Received: from [9.61.132.237] (unknown [9.61.132.237])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 13 May 2025 11:38:59 +0000 (GMT)
Message-ID: <d95ae850-a6d4-4a26-8bae-3c4619fe25f2@linux.ibm.com>
Date: Tue, 13 May 2025 07:38:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 4/4] s390: implementing CHSC SEI for AP config
 change
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com
References: <20250512180230.50129-1-rreyes@linux.ibm.com>
 <20250512180230.50129-5-rreyes@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20250512180230.50129-5-rreyes@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: E6ZuoUOfA4AFwDb4rUyklTdSP1tkn6UC
X-Proofpoint-ORIG-GUID: E6ZuoUOfA4AFwDb4rUyklTdSP1tkn6UC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDExMCBTYWx0ZWRfXyopAjx+Qh8ZF
 fwwxT8SI9cIT0Xo6kAbqDL8kTIwb32Cq1P5u8RV8Viz0FUHzZ23iYvnEcCBqbo15hSICiHrrHFu
 zzs4dTHgscwIUKThs/wo+P8JIPzjS9E9oBNbJfY6Mq+BOm6HDrFz3slVCqTMjDJYVtINdm8u8uO
 cSdFnHmtU9CCQeCJihCrg8/7NmaBNcHPinfOfczHjlKQIEs/zBXvooO4e8RHRe86OQrezwBVoS5
 ypbVzureRuPBKO38EFFEvWNjr30oUQZnaMyqZfiyRjG6di6Z0wStonvgJm9DE8g4SZP/vU0GpGV
 VWdOeMd+P8GeVx/dZ59ssTSieAQLwF1zI6WCOjuFoha8bBEQseDMkNijJtb0sTv+hpcriuyX31K
 cA2/vbY9Lc/Qg8PIiSL3XekFZPvPsQD4wbSon1Vkoa4UyrVeryfKvxFgfe12Z6tiZgCh0c2s
X-Authority-Analysis: v=2.4 cv=e+sGSbp/ c=1 sm=1 tr=0 ts=68232f57 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=7Rm9Gk2U4fTbDqzAm_EA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 bulkscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505130110
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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




On 5/12/25 2:02 PM, Rorie Reyes wrote:
> Handle interception of the CHSC SEI instruction for requests
> indicating the guest's AP configuration has changed.
>
> If configuring --without-default-devices, hw/s390x/ap-stub.c
> was created to handle such circumstance. Also added the
> following to hw/s390x/meson.build if CONFIG_VFIO_AP is
> false, it will use the stub file.
>
> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>

Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>

> ---
>   MAINTAINERS           |  1 +
>   hw/s390x/ap-stub.c    | 25 +++++++++++++++++++++++++
>   hw/s390x/meson.build  |  1 +
>   target/s390x/ioinst.c | 11 +++++++++--
>   4 files changed, 36 insertions(+), 2 deletions(-)
>   create mode 100644 hw/s390x/ap-stub.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 23174b4ca7..070c746c69 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -112,6 +112,7 @@ F: hw/intc/s390_flic.c
>   F: hw/intc/s390_flic_kvm.c
>   F: hw/s390x/
>   F: hw/vfio/ap.c
> +F: hw/s390x/ap-stub.c
>   F: hw/vfio/ccw.c
>   F: hw/watchdog/wdt_diag288.c
>   F: include/hw/s390x/
> diff --git a/hw/s390x/ap-stub.c b/hw/s390x/ap-stub.c
> new file mode 100644
> index 0000000000..e2dacff959
> --- /dev/null
> +++ b/hw/s390x/ap-stub.c
> @@ -0,0 +1,25 @@
> +/*
> + * VFIO based AP matrix device assignment
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Rorie Reyes <rreyes@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/s390x/ap-bridge.h"
> +
> +int ap_chsc_sei_nt0_get_event(void *res)
> +{
> +    return 0;
> +}
> +
> +int ap_chsc_sei_nt0_have_event(void)
> +{
> +    return 0;
> +}
> diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
> index 3bbebfd817..99cbcbd7d6 100644
> --- a/hw/s390x/meson.build
> +++ b/hw/s390x/meson.build
> @@ -33,6 +33,7 @@ s390x_ss.add(when: 'CONFIG_S390_CCW_VIRTIO', if_true: files(
>   ))
>   s390x_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('3270-ccw.c'))
>   s390x_ss.add(when: 'CONFIG_VFIO', if_true: files('s390-pci-vfio.c'))
> +s390x_ss.add(when: 'CONFIG_VFIO_AP', if_false: files('ap-stub.c'))
>   
>   virtio_ss = ss.source_set()
>   virtio_ss.add(files('virtio-ccw.c'))
> diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
> index fe62ba5b06..2320dd4c12 100644
> --- a/target/s390x/ioinst.c
> +++ b/target/s390x/ioinst.c
> @@ -18,6 +18,7 @@
>   #include "trace.h"
>   #include "hw/s390x/s390-pci-bus.h"
>   #include "target/s390x/kvm/pv.h"
> +#include "hw/s390x/ap-bridge.h"
>   
>   /* All I/O instructions but chsc use the s format */
>   static uint64_t get_address_from_regs(CPUS390XState *env, uint32_t ipb,
> @@ -574,13 +575,19 @@ out:
>   
>   static int chsc_sei_nt0_get_event(void *res)
>   {
> -    /* no events yet */
> +    if (s390_has_feat(S390_FEAT_AP)) {
> +        return ap_chsc_sei_nt0_get_event(res);
> +    }
> +
>       return 1;
>   }
>   
>   static int chsc_sei_nt0_have_event(void)
>   {
> -    /* no events yet */
> +    if (s390_has_feat(S390_FEAT_AP)) {
> +        return ap_chsc_sei_nt0_have_event();
> +    }
> +
>       return 0;
>   }
>   


