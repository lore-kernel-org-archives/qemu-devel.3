Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF08AC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 18:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFHFx-0007pA-RJ; Wed, 14 May 2025 14:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFHFg-0007Zv-Dz; Wed, 14 May 2025 14:54:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFHFe-00067c-IG; Wed, 14 May 2025 14:54:47 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EHjfEu013015;
 Wed, 14 May 2025 18:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=M8AX0w
 zGGcPXpoKh6ZQtK/SE/mWdy0zckkGc2Vxq/bE=; b=E534Jt5VcLbus++DJ2AMfz
 QCR3ykvddeUoyCflE9uh9kpAgYBmY8d9D7B+sGqjVOFGlVJePKvb/9WWGI3mlNqT
 3xV3nhFfY2mhiLCt7oIcNi5r4ngSz07lduseMJlsSeaq34UYAERxvi8yNODh5jvm
 KiIDRFSYMB2QEmPzTLt6if01pkWV8yM8cHELEFz+t1S4An+obQ7zYmaThfzuKnTZ
 Qy7x1XCYvQIwh7Ys9B5LN82e4h6bSLD30EcTiVmMcdFXPr7x2LnXPRX9IOhz34O9
 7zY/g/cTiXEcTGSm9hUxgDrycOg3j2WLCWXgFbQzB3ddSJa3vOHqkEFE7QXrox7g
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mrcjayp2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:54:43 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EIowBx019370;
 Wed, 14 May 2025 18:54:43 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mrcjayp0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:54:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EGncBj021574;
 Wed, 14 May 2025 18:54:42 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfrnwwp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:54:42 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EIseCu27460274
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 18:54:41 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D85E858054;
 Wed, 14 May 2025 18:54:40 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 591935804E;
 Wed, 14 May 2025 18:54:40 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 18:54:40 +0000 (GMT)
Message-ID: <46316a96-d768-4098-a2d2-31c8fbacf156@linux.ibm.com>
Date: Wed, 14 May 2025 13:54:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/50] ppc/xive2: Do not present group interrupt on
 OS-push if precluded by CPPR
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-12-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-12-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZYgdNtVA c=1 sm=1 tr=0 ts=6824e6f3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=Wj05kcf0ZfV7km4k54cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: WqdJawkJg1YHkoTNya0FoKNOstkGddTu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE2OSBTYWx0ZWRfXz3ctuOn+ZQhH
 FTX0GImHudmE1UXIisOeQmVDh7gjDGQSSESfGhu6K2b9nt3iW9uiXij3EUjFM0X2mMw8OxinTkn
 PYPfB2MWQs/L4Z49iK7s0lJlZ8mQXP3UtVkEJFaEFHZW83A5pW1CJQOwP2lz95Gk/titmAOtG6g
 DHVg1aP3s/mAolAhGnISM6IAfCCg3L8euCbNw75fVJ24P2WguX6CVN68w+RxFEW2ZUvOUkg67dg
 By0y5Lj9LtCMxgD7yAoDl/WoCcoobF/eYSnwUM8/VYoVIzPsA5kOMmIp3pZ/CxfPLXHZYv3N/8B
 dLkAJ+BKYqfqVnQ3ZjUG7MlPS32I70CikF81/iQCZXWcQONmHB7qabgURDLageCCnfH7/G3zjHc
 K9su6/Tw6LvkeTEds9vvnpgEfw6DHVMcI78w9TUV/xpwph7APk9oO9ohc3QayZ+hNujnssU3
X-Proofpoint-GUID: BnjkIxfR5Gs3nQ5of5JpKObDtCnXZjC9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=783 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140169
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
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


On 5/11/2025 10:10 PM, Nicholas Piggin wrote:
> Group interrupts should not be taken from the backlog and presented
> if they are precluded by CPPR.

Reviewed-by: Michael Kowal <kowal@linux.ibm.com>

Thanks MAK


>
> Fixes: 855434b3b8 ("ppc/xive2: Process group backlog when pushing an OS context")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/intc/xive2.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 1971c05fa1..8ede95b671 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -845,7 +845,9 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
>           group_prio = xive2_presenter_backlog_scan(xptr, nvp_blk, nvp_idx,
>                                                     first_group, &group_level);
>           regs[TM_LSMFB] = group_prio;
> -        if (regs[TM_LGS] && group_prio < backlog_prio) {
> +        if (regs[TM_LGS] && group_prio < backlog_prio &&
> +            group_prio < regs[TM_CPPR]) {
> +
>               /* VP can take a group interrupt */
>               xive2_presenter_backlog_decr(xptr, nvp_blk, nvp_idx,
>                                            group_prio, group_level);

