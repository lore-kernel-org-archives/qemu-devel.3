Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A576FC3DA6D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFam7-0007G5-6u; Thu, 15 May 2025 11:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFalR-0006BT-DY; Thu, 15 May 2025 11:44:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFalK-0006C1-53; Thu, 15 May 2025 11:44:53 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCg41c004682;
 Thu, 15 May 2025 15:44:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=MEU99Q
 AjbQse3kgRUIgZzRB4eadWgNdwn2GelvLmdnQ=; b=Ob1IWj1mQTA7TDNs0508Rm
 027XTCyZsUu8PeI98yUg0ZXKm1U68gmKJJlx2tNJDIpxRswFnHNdTxuRcOty+7aM
 pntOP3R5aZMesLd9/bY11BJ+Gr1TKjmUr4eSbN0R9qNRiLGtgTd4IdELxBzOFNNV
 fAXDEWaWs3+q6Rr95WzX7mHYcYsBsgkcco3qJkUp3W4sRM0f3YVAUW6TU9nYZt51
 5WIvgR8eddL7pjpIeExEbW2enoehLE4idpAcZoNRze61H+MaDnV3FG+HOh7GtLxN
 mSz6aY7tNjEc3S3Vw+x9jTHWQKeqPSzOQZjFvsyxnetS5EL4Q6FTLfqFSV8Ec7pQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46navu2vuv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:44:34 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFXjAP029496;
 Thu, 15 May 2025 15:44:33 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46navu2vut-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:44:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FE3XpF021793;
 Thu, 15 May 2025 15:44:32 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfpu1ck-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:44:32 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFiVHZ27525762
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:44:31 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6FBB858059;
 Thu, 15 May 2025 15:44:31 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23ACE58058;
 Thu, 15 May 2025 15:44:31 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:44:31 +0000 (GMT)
Message-ID: <4fd5d6f8-beee-4e5d-adf7-baa6288a9e83@linux.ibm.com>
Date: Thu, 15 May 2025 10:44:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 45/50] ppc/xive2: redistribute group interrupts on context
 push
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-46-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-46-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: N2nt5qAv8b0oSmWfcey5hLm0TKE3r-MJ
X-Authority-Analysis: v=2.4 cv=XK4wSRhE c=1 sm=1 tr=0 ts=68260be2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=89eXdJJYgY74zT-coKsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VQBXvFZLX93NgHoRFVch7GwCPbhjkA8x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NSBTYWx0ZWRfX3WqftHDbhRnV
 yKthhlj6o0IrI5afmXBijhOWH1FqbQs9kBHy9Ja/2z6UgOare2l0wGRrAaPJT6iS0WDJgGw3vSR
 lr8yrY8EzQ6XJIH7zNZQ8SjLtB7rG91CRl3KcE6ckP66qVJfgXF90iUMwPMJmkBMIZoSP30X+MF
 rJJb6cBuJvX75M1pOYqw3sh2AqS6Laper0rZiy4ieiG2IzRopMIe6EBUoQ0DM7cFNkZaIHfPbNe
 lbN5bt4reaBRsIGOpFZPqq4n099NiKJMXKeSZvb7gu+VUYFkMMZjqPQ2IF2oNNuFdfZJC8rBHe5
 3eE7hnjk8nxNKMTAU8j4hqyD9qPhpw7aDa0G6fHDRm9PW4XzR2eeyk+5N9g14Sdpnm2fp9kJ4Jy
 by0DyAce3sfosvYATo9jDfqtGlhyb4C6Jb9E0ihX1vJlX9MdOUNlRaqS/qKg3aJOvQ/m2Q0p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=910 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150155
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
> When pushing a context, any presented group interrupt should be
> redistributed before processing pending interrupts to present
> highest priority.
>
> This can occur when pushing the POOL ring when the valid PHYS
> ring has a group interrupt presented, because they share signal
> registers.

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks,  MAK
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/intc/xive2.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 21cd07df68..392ac6077e 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -945,8 +945,9 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
>                                      uint8_t nvp_blk, uint32_t nvp_idx,
>                                      bool do_restore)
>   {
> +    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
>       uint8_t *regs = &tctx->regs[ring];
> -    uint8_t ipb;
> +    uint8_t ipb, nsr = sig_regs[TM_NSR];
>       Xive2Nvp nvp;
>   
>       /*
> @@ -978,6 +979,11 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
>       /* IPB bits in the backlog are merged with the TIMA IPB bits */
>       regs[TM_IPB] |= ipb;
>   
> +    if (xive_nsr_indicates_group_exception(ring, nsr)) {
> +        /* redistribute precluded active grp interrupt */
> +        g_assert(ring == TM_QW2_HV_POOL); /* PHYS ring has the grp interrupt */
> +        xive2_redistribute(xrtr, tctx, xive_nsr_exception_ring(ring, nsr));
> +    }
>       xive2_tctx_process_pending(tctx, ring == TM_QW2_HV_POOL ?
>                                            TM_QW3_HV_PHYS : ring);
>   }

