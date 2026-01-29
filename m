Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7582DD73E9B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 21:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vla1D-0006c7-E0; Thu, 29 Jan 2026 16:57:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vla17-0006Yv-0Q; Thu, 29 Jan 2026 16:57:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vla15-0004tj-6G; Thu, 29 Jan 2026 16:57:32 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60TF15EJ024546;
 Thu, 29 Jan 2026 21:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5MVY1o
 7/M9pGozEs+rslFsV86A78/PIAIxnAIgL6yog=; b=bMfQbweuf7whQFIDu2gnKP
 6D1K7bIk43dcMqM3DqDrszSRAR7G2A2/fCZfJ4fZa2ViVmyhtOV83Hy1AKlOCRnm
 9wpvgvHX083KchYVuiIMSsdy2izpqWxebGx96fWpIiFZmiYa2dvDD9g7SRIfoh+N
 ZYxCV57C8hcvnWuDAo5nUWA/rVsQQaTsHiINJNSKeZyhNqGgcjT3Yot2QiZiEU3l
 e//U63c5Z5e3umX3ft/4reMS1HFgOzr1dPzV59jxPWpydzmpI5BL23fxRdccD7D7
 6jXrb8wiNJ2vm2rcFfa5vNh+Qe+9Vpx9SKVDjfJkJFqt6nqMgHr2cCLiBnVgJWgQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrtu1ph-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 21:57:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60TJcqHC026319;
 Thu, 29 Jan 2026 21:57:23 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9wkksxh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 21:57:23 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60TLvMGI20054782
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jan 2026 21:57:22 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A8545805D;
 Thu, 29 Jan 2026 21:57:22 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B4B458052;
 Thu, 29 Jan 2026 21:57:21 +0000 (GMT)
Received: from [9.61.243.220] (unknown [9.61.243.220])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Jan 2026 21:57:21 +0000 (GMT)
Message-ID: <796690cd-7534-47fc-aaf3-92ff43032f29@linux.ibm.com>
Date: Thu, 29 Jan 2026 13:57:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] pc-bios/s390-ccw: Fix misattributed function
 prototypes
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
 <20260127161547.459443-2-jrossi@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260127161547.459443-2-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p9lkNukFHn-W6MM8vmPikcI_rh_Xz3w5
X-Authority-Analysis: v=2.4 cv=Uptu9uwB c=1 sm=1 tr=0 ts=697bd7c4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=UqOuBkxgFOtGcpOZzq8A:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: p9lkNukFHn-W6MM8vmPikcI_rh_Xz3w5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDE1OSBTYWx0ZWRfXwALP39/Mw+p7
 d1hUEbjq+dejCfJ7Z1oyAxGopTh00gr7lEiRqCS3xXwEqTB7SgQesh2NHriPFLLzbEdsjTjdhhL
 x0SCFyow8SdDnwwAobxbR7L0/k4fdCFbTjBjFuhtI5pFw24Oq57TH4RoAUrvWNRILSOsHJKEl2j
 XBwc52yNTUBKPlWyOpg0cp+Xi0DCBrx0prAOjSOEfA874ETIZnDFlZmHSyrh39u/ArbLyJmowQ1
 O3Hed1IwV40F+ehjJyJMKikPlIhmALN5M88VV5wV0LuXm0iedTUAHBFg1lj/rDtBsLHLDD/HGgG
 dJcZ6t4dnuGaZbiHERu3HjLoVdrmXi4Sx/QnzN58Ld1sc4CyplgXPBDT0kv7DjHnxYFaK3NTXQI
 5b18zVaDGfwETO2hy1TfYPdl75NQc5ov6frYfNzPcjWMxsA+V/0JmAKxiAZMqhRK0keftqvdBe7
 Tq7cvAK4K78OQcDbxrg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601290159
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 1/27/2026 8:15 AM, jrossi@linux.ibm.com wrote:
> From: Jared Rossi<jrossi@linux.ibm.com>
>
> The virtio-blkdev functions are incorrectly listed in s390-ccw.h as belonging to
> virtio.c.  Additionally, virtio_load_direct() has an unused subchan_id argument.
>
> Remove the unused argument and move the prototypes to virtio.h so that they are
> independent from the CCW bus.
>
> Reviewed-by: Thomas Huth<thuth@redhat.com>
> Reviewed-by: Eric Farman<farman@linux.ibm.com>
> Signed-off-by: Jared Rossi<jrossi@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/bootmap.c       | 2 +-
>   pc-bios/s390-ccw/s390-ccw.h      | 4 ----
>   pc-bios/s390-ccw/virtio-blkdev.c | 2 +-
>   pc-bios/s390-ccw/virtio.h        | 7 +++++++
>   4 files changed, 9 insertions(+), 6 deletions(-)

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>




