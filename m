Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27832C3DA6D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFanw-0003xq-7G; Thu, 15 May 2025 11:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFans-0003qF-NM; Thu, 15 May 2025 11:47:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFanp-0006dv-Nw; Thu, 15 May 2025 11:47:24 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCfuIj016133;
 Thu, 15 May 2025 15:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=JI7ygXOr37orCOJcAr7qTukb3yBSGGyfO9OXrM+T4oA=; b=IcgGCzjw+5kc
 dksmxWrz70Qi96dqW0VnZdUe++4J8JrgDIVXqQy5QkrZCT2CH17ADxdD4zxt6OUJ
 Eca4QcjPHiu+aIgi0ImV1NBFt2MKXwlXRc9TPaMqIMLv4rvZ7jbNOvq7nJ7FlBkv
 fGnTiY/YPgS64M6q8yqA4s5eorA2OtzQcCy24NLtVY8Nh0pQpXMEYNjoJ50rhcCQ
 3SYJds7+4JtXbEZ06fUBzSPEjBdc5BXtEbMS3tiEEjHoU6/EK1Vu7I7seeLc6e/z
 KLht56S0ZJ154uMAMdSkrs+BPFmAMmsq8VuTV8ztZl0Uzmdbr+ah3N1GhNwRcmuS
 JXt9ptIpTA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nd4gt750-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:47:18 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFbvrT018208;
 Thu, 15 May 2025 15:47:17 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nd4gt74v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:47:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEGBRW021861;
 Thu, 15 May 2025 15:47:16 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfpu1r6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:47:16 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFlFo719268206
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:47:15 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F35EA5805B;
 Thu, 15 May 2025 15:47:14 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 72CFB58059;
 Thu, 15 May 2025 15:47:14 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:47:14 +0000 (GMT)
Message-ID: <71e4fbaa7e4022c2c5081fa161f4007cc6b8b481.camel@linux.ibm.com>
Subject: Re: [PATCH 14/50] ppc/xive: Explicitly zero NSR after accepting
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 10:47:14 -0500
In-Reply-To: <20250512031100.439842-15-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-15-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vBbrxO6A2Fw18kW4F0IKGv0zBy71K4Zs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NSBTYWx0ZWRfXwN3tAhdgKWt1
 wZQ9HTtGGZ78B1iDih6kQN4N0dHVsjFcGC6XuZ86WKTLqr5YMq9dCQ+2N4sAPiXOMzUVGer9IuD
 A9vhaLlnABfDKQs1NnqbBL9TA9FvLljCC0I+4EIUmI9ZxQ4yqMZRSfmdrEs7v1MvV2ZwI4Cajej
 niGFs6w9lizDHUW8YMqPnKUDnIwKJ+Fm+gz3FvPTcTlvR6XRqvgbwESmRm6XuCfePpCEdxrovqk
 141Fd/YMT5WlvVR4Mp3C73ieiUVog8+2KvahIKm7T5BtNpSGex6bRERRAtzIxSpDS7goD8IvhQ4
 l3TercL/YizNCcjB059dy4qEbHGnGQfqm/scm2xizxEW31uQ4vbYrsz0Q3D099bIJ7/+9hsaPrW
 fPE20Qn/q304u0m0NQ20LOosLeuhnM9Dk22QjVP/u33ZEStDBCbCF7b4vmiw9RsEW5KvB0ap
X-Proofpoint-ORIG-GUID: pMv4ql8DGtvTYaWkJZVv6zXsmcHKNIJu
X-Authority-Analysis: v=2.4 cv=OsNPyz/t c=1 sm=1 tr=0 ts=68260c86 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=pEHLqOCy1T54nkr0MDsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=564 mlxscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150155
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

On Mon, 2025-05-12 at 13:10 +1000, Nicholas Piggin wrote:
> Have xive_tctx_accept clear NSR in one shot rather than masking out bits
> as they are tested, which makes it clear it's reset to 0, and does not
> have a partial NSR value in the register.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 6293ea4361..bb40a69c5b 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -68,13 +68,11 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
>           * If the interrupt was for a specific VP, reset the pending
>           * buffer bit, otherwise clear the logical server indicator
>           */
> -        if (regs[TM_NSR] & TM_NSR_GRP_LVL) {
> -            regs[TM_NSR] &= ~TM_NSR_GRP_LVL;
> -        } else {
> +        if (!(regs[TM_NSR] & TM_NSR_GRP_LVL)) {
>              alt_regs[TM_IPB] &= ~xive_priority_to_ipb(cppr);
>          }
>  
> -        /* Drop the exception bit and any group/crowd */
> +        /* Clear the exception from NSR */
>          regs[TM_NSR] = 0;
>  
>          trace_xive_tctx_accept(tctx->cs->cpu_index, alt_ring,


