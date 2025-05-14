Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0CEC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 18:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFHAD-0000xm-1T; Wed, 14 May 2025 14:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFH9Z-0000GC-Dg; Wed, 14 May 2025 14:48:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFH9X-0004o1-CH; Wed, 14 May 2025 14:48:28 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EFrJ0Y024793;
 Wed, 14 May 2025 18:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=FJ77hN
 XmAB2868Y+/W8F7X9Fhyj6Smm+x3sOCaylIWI=; b=DJiCHXeLaJCPbkMHlSLaWi
 cr48AE1MM0825AfQu6dWeb/ICmrXTyFRUI+CnZmm50x646lrV4XUAZNnnOXnBKKi
 M5tUcVcr2raW7IlOZKEB94QaoOouBLJZEVDhdp66ftGHli1hYQLNPrExyGxewUsT
 dJpptCQGdD658Y3/kgdZ020CWc9jOzLsX9rtUqqIOTos557cinr+6bzRQ6Hs6rSs
 MYOCKpKVRKwkFe6ZaflUM2Fse2rURpV1ET/vF7ER+G0SUfWAcwyZvqf/PXY74vgk
 EFAcaP1xhsj8U8dRMtp5hJZe1UOxdQOIFbgJVB3utrLdj7awWGieZvqlFnBtzHRg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mbs6p42w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:48:25 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EImPXI031975;
 Wed, 14 May 2025 18:48:25 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mbs6p42v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:48:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EGXw7g015300;
 Wed, 14 May 2025 18:48:24 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpwvu4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:48:24 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EImNxH66322850
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 18:48:23 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 24CEC58054;
 Wed, 14 May 2025 18:48:23 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9EE2E5803F;
 Wed, 14 May 2025 18:48:22 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 18:48:22 +0000 (GMT)
Message-ID: <64a0f991-e57f-488f-b3a6-496d44210387@linux.ibm.com>
Date: Wed, 14 May 2025 13:48:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/50] ppc/xive2: fix context push calculation of IPB
 priority
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-6-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-6-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE2OSBTYWx0ZWRfX6N4GkQyYBzLK
 ezEdqXdU0uur+TA/MWxHccf+NU4uh/9o+qi9b428eVkSuEt6FOhPG0cPxPr0X5xBjCy56WzaTMH
 9FCjpWE4EHdLljR8Ow0c2Z9R+/XWj7UfNGvHeBYtW3U8zZKlpwUu4a0g1vZ2cJU3eXyAza/oOqw
 olL+IJQ9ScUANZ2fqDQV7tGzDzCdH3fUn7cCy9cq2/B0enNsdA/dlv8rpCUdVllgI3tz+eOmhrt
 NmRkR6Da6SiphI4whsliwRTcpt3J0vmuSb3E4DD/aO+Xs+xhc+w32v7Z9CDd5xUqbKeO45qpFJw
 gaS3Im0zqvD4gdVyKmolLxF31zGbuiqPQzAp2LS/kHSPUvgMZpqwdPun4JwNOChxAE4VAemGYJK
 wY7BxWUNFqDtj1r/7naZXTdV5SSdT+Sw12cQhi4jAXlO2boZJvKeZuzdKzTfH8OMxB+FTl9C
X-Proofpoint-ORIG-GUID: DWeIEuUJgM8tcjGtCrDfnsb_HIL4EA_E
X-Authority-Analysis: v=2.4 cv=d5f1yQjE c=1 sm=1 tr=0 ts=6824e579 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=yJ9lfIZagGyyCFpBJUMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8_Dm_JmTVpst0Vs7KF3i0sYFyasNm8PP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 spamscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 mlxlogscore=844 impostorscore=0 adultscore=0 phishscore=0
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
> Pushing a context and loading IPB from NVP is defined to merge ('or')
> that IPB into the TIMA IPB register. PIPR should therefore be calculated
> based on the final IPB value, not just the NVP value.
>
> Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
>
> Thanks MAK
>
> Fixes: 9d2b6058c5b ("ppc/xive2: Add grouping level to notification")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/intc/xive2.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 790152a2a6..4dd04a0398 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -835,8 +835,9 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
>           nvp.w2 = xive_set_field32(NVP2_W2_IPB, nvp.w2, 0);
>           xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, &nvp, 2);
>       }
> +    /* IPB bits in the backlog are merged with the TIMA IPB bits */
>       regs[TM_IPB] |= ipb;
> -    backlog_prio = xive_ipb_to_pipr(ipb);
> +    backlog_prio = xive_ipb_to_pipr(regs[TM_IPB]);
>       backlog_level = 0;
>   
>       first_group = xive_get_field32(NVP2_W0_PGOFIRST, nvp.w0);

