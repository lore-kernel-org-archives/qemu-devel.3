Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FADC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 19:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFIDX-0002Fc-T9; Wed, 14 May 2025 15:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFICe-0001cJ-Ii; Wed, 14 May 2025 15:55:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFICX-0002fn-6o; Wed, 14 May 2025 15:55:38 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EIoJkD031031;
 Wed, 14 May 2025 19:55:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Zxp3AI
 GtTq6XfPyeTfnCrYVfzxgwTo5s6O0D78nJN2g=; b=oP4RQjYjmh8v79z7e7jilP
 KhJTLapfaacWUHXjnXvARPOM33g4mAetBSFKxCGgFIRm8qBzfsmIbJwQQkqzEHBE
 BDT7ItR4L8JE2fH2j2DWlVKgHrywqQhXBJrkZMEa0pLdVjuvltHhROez6T38Nwu0
 8WALYnIGWopHvnU7d8qzmKTXNfg8lw1++6yZVdNpyukPlbbFRgCccK/knfb9Qexl
 ZbndL6SIPxtgX6LjjJ1uRH0infuk0EqG8u5mOMlEBXPiHg+xb+gBg3we+KJ88uUm
 Nnx/0aCdfW8U1yeJ3dMWMRZeDZetrvd/d8YL73A+N+E3xMwg/yQXulrZ7YloYG9g
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0t98brw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:55:35 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EJtYoY011733;
 Wed, 14 May 2025 19:55:34 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0t98brt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:55:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EJjYiO021797;
 Wed, 14 May 2025 19:55:33 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfpp872-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:55:33 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EJtW9Z19596026
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 19:55:32 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2834258054;
 Wed, 14 May 2025 19:55:32 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9EE615804E;
 Wed, 14 May 2025 19:55:31 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 19:55:31 +0000 (GMT)
Message-ID: <08a08e3f-2de5-424c-a253-595fa43fa298@linux.ibm.com>
Date: Wed, 14 May 2025 14:55:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/50] ppc/xive2: Redistribute group interrupt preempted
 by higher priority interrupt
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-30-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-30-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=etzfzppX c=1 sm=1 tr=0 ts=6824f537 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=h6Ax321QG256VOZq6v8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE4MCBTYWx0ZWRfX0bmMQU7ZN3my
 N4tOBO9iiRkmCJ3X1UitAvekBNvuYGkS7gqdaU7YW7ULYUFXWk0Ixrt+0r+lZpj6IT364uUtMuU
 l45eWkYn60b6vtdO3ytJr2PeGCxBe/TCilUCk0v4rq4FeBIXJcWkEpQ3RK+l5Y/qNPgcsAYwZof
 7PFkVOZPIh7QZJnQT2p52yMVyfsSoJo/ES3VtBwKUqKANuIs3HpEkBWGEuiZrZ6QpXsLo5Wpz5j
 IB7yX0JOWWuLgGc6U0DfkS6hZV3ybLSYIDi3t8TCG8BXuKLDpefy4iqXE+YWxm1MpODzpGeCWt8
 81jTLrgscz3jdekTRMIluiTpO7qRTHGQR31earbPflrgmunAcpce0IVZBQTcjpAzAQ9Ndd2eXcj
 YHGIbTvYnsbrd7qLin3jiHDLt3SlEMLAmcLAx3NiKbgfwoPusvE7iDq2EcCFqEgXxf7c2Rl1
X-Proofpoint-ORIG-GUID: dvSyao52Mn1mYpuITAkQ4asrJzYUe1mI
X-Proofpoint-GUID: ph7K5kKKfHWNyrg1Btr9CzvgzwRuHds4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140180
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
> A group interrupt that gets preempted by a higher priority interrupt
> delivery must be redistributed otherwise it would get lost.

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks,  MAK

>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/intc/xive2.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 6e136ad2e2..cae4092198 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -1638,11 +1638,21 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
>                                crowd, cam_ignore, priority,
>                                xive_get_field32(END2_W7_F1_LOG_SERVER_ID, end.w7),
>                                &match)) {
> +        XiveTCTX *tctx = match.tctx;
> +        uint8_t ring = match.ring;
> +        uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
> +        uint8_t *aregs = &tctx->regs[alt_ring];
> +        uint8_t nsr = aregs[TM_NSR];
>           uint8_t group_level;
>   
> +        if (priority < aregs[TM_PIPR] &&
> +            xive_nsr_indicates_group_exception(alt_ring, nsr)) {
> +            xive2_redistribute(xrtr, tctx, alt_ring);
> +        }
> +
>           group_level = xive_get_group_level(crowd, cam_ignore, nvx_blk, nvx_idx);
> -        trace_xive_presenter_notify(nvx_blk, nvx_idx, match.ring, group_level);
> -        xive_tctx_pipr_update(match.tctx, match.ring, priority, group_level);
> +        trace_xive_presenter_notify(nvx_blk, nvx_idx, ring, group_level);
> +        xive_tctx_pipr_update(tctx, ring, priority, group_level);
>           return;
>       }
>   

