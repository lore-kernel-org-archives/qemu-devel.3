Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F718C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 15:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFDl0-0004Hg-4k; Wed, 14 May 2025 11:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFD9s-0007d7-3K; Wed, 14 May 2025 10:32:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFD9q-0006ko-Ik; Wed, 14 May 2025 10:32:31 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EDnNOg004330;
 Wed, 14 May 2025 14:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=HIEpe2
 6oAhlRl6fpL691IFrzt1fHEVVbVGzvRrv1In4=; b=DjLrBabEedV9l+NosPH/0H
 g5luhjAzD3aTTL8Aq7EoK6/2qkYwu/2B6vTjIDB1SqkeIDz20cv7ZqQQKFh4x1Z2
 VpohCYarRcv377YAoZUu27R74e85XE2zj3J3PzaTLRxZer3fq4A5x0k2aA4mwfa7
 aQlRDkgJSkKPcisXqwogjH+EEwFuDi6DXn/RzXMytHqZR3jpoQE157PApMmlVx1z
 c3NDnhKFjbP3sarsUqXAhL4JMx9t1qzJ2rwlAqQDH9kGjVSKrpcMEWlf+C1drj9Z
 HyPBRgDPCVysmUuFiPCbf5JbBlkCdrMGcLbJNM7ju3mzex7sqAqMtrr05rhUDPGA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mvd3884d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:32:28 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EEMMYp019045;
 Wed, 14 May 2025 14:32:28 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mvd3884c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:32:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EDcHr6024281;
 Wed, 14 May 2025 14:32:27 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfs4nkc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:32:27 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EEWQql22545088
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 14:32:26 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E07C58052;
 Wed, 14 May 2025 14:32:26 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A2DEF58056;
 Wed, 14 May 2025 14:32:25 +0000 (GMT)
Received: from [9.10.255.115] (unknown [9.10.255.115])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 14:32:25 +0000 (GMT)
Message-ID: <eaeea5f4-5364-45af-88e9-20dfea447b50@linux.ibm.com>
Date: Wed, 14 May 2025 09:32:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/50] ppc/xive2: Do not present group interrupt on
 OS-push if precluded by CPPR
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-12-npiggin@gmail.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <20250512031100.439842-12-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aXyrzQ8Ekv9iq8WUkwGcYZ6Q1jhiJ_15
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDEyNSBTYWx0ZWRfX7ndCgDyHXylO
 Hgr8JUebzDbwUtPLXQHf0QoATUTfdvPk7L5il3n9xOXX7svhx++crmxCgFBOBfRwmOxFGliDcEw
 1hC5RaWsp8sqSCG0V9FX398iYXBajlafRcYTvHxLClYUuU1jIPGIA2mkY0mwRK/O27M48EvFLy+
 eYc2NQYmYnNc0uf7M7gLh7FgX/7t65M8IMmBgYG07sjHOQcGeeCxfil/ITcaOOMWFpasOp6rX5j
 BjfH2SVHpPNEul6IzHhF8HafOklzz9HnooKYnkxeKv02fRTokwiJdst1++fE6u72Q+srjP9D4SY
 cAq7CImFFY8FReQbeHbCbCPUMOkh6yemd/OIQGW3IMgSOe8hI/XciBMzUAhUc2etidogeLpnWtb
 /68S5ciiwCJpau/NM2NA+0X/hkyRPDai6PaW1caM+3tbMzkX4n3q5gZhlwbP8B3BwD/zhoE6
X-Proofpoint-ORIG-GUID: l3cmFL9sezwf04BlKbKG2XgMlWZh8ev5
X-Authority-Analysis: v=2.4 cv=GbEXnRXL c=1 sm=1 tr=0 ts=6824a97c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=6PrcOua1sW-wYeWJZ4UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 mlxlogscore=690 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140125
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
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
X-Mailman-Approved-At: Wed, 14 May 2025 11:10:35 -0400
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

Looks good.

Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>

On 5/11/25 10:10 PM, Nicholas Piggin wrote:
> Group interrupts should not be taken from the backlog and presented
> if they are precluded by CPPR.
> 
> Fixes: 855434b3b8 ("ppc/xive2: Process group backlog when pushing an OS context")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive2.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 1971c05fa1..8ede95b671 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -845,7 +845,9 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
>          group_prio = xive2_presenter_backlog_scan(xptr, nvp_blk, nvp_idx,
>                                                    first_group, &group_level);
>          regs[TM_LSMFB] = group_prio;
> -        if (regs[TM_LGS] && group_prio < backlog_prio) {
> +        if (regs[TM_LGS] && group_prio < backlog_prio &&
> +            group_prio < regs[TM_CPPR]) {
> +
>              /* VP can take a group interrupt */
>              xive2_presenter_backlog_decr(xptr, nvp_blk, nvp_idx,
>                                           group_prio, group_level);


