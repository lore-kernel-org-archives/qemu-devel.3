Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C80DC3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 18:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFHAw-00025c-Pq; Wed, 14 May 2025 14:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFHAt-00020O-AF; Wed, 14 May 2025 14:49:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFHAr-00052m-Nr; Wed, 14 May 2025 14:49:51 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EGabUL024756;
 Wed, 14 May 2025 18:49:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Xy7qDf
 kwPjxgm50jsHxaUdnfUoJ8QQjX4DBnvee+njo=; b=lDkQiu8TkdnAuIS30mViRP
 2bEUUVn3ozZQ33yFUcyc9sXogd7xV+1yeZ6WTGefzj9csYTRxJSUGRgBhNmUtE0A
 rYS0jhIJqPM22/B+nxMzfcO/INjBcloYj4ZjucITjPrYsWLi5XHA4nvmF4knSrY2
 dQgQYHsqp34IEHKHjFAJGugS4GVEmj/mxI7YsRA6X56Ubzl2F0cA1XY+MpvoGIY1
 9Mf7ciHSEgUxWbx0DiXxxiGGu8SNnE72AfHFCPluWJL6Ush0zevL2c99YtIoXswi
 bB37M0LBmSTY1pjwgFsb//uItko2OCMMg/8mTYorV7mmu/bCV3fJwO9wQgZnFh7Q
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mbs6p482-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:49:48 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EImexv032705;
 Wed, 14 May 2025 18:49:47 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mbs6p480-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:49:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EGSfvf021828;
 Wed, 14 May 2025 18:49:47 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfpnw9y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:49:47 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EInjG024052278
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 18:49:46 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A037958054;
 Wed, 14 May 2025 18:49:45 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2749058056;
 Wed, 14 May 2025 18:49:45 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 18:49:45 +0000 (GMT)
Message-ID: <acf69b83-2af6-4a78-b7ce-5c9f40d1b3b6@linux.ibm.com>
Date: Wed, 14 May 2025 13:49:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/50] ppc/xive: Fix PHYS NSR ring matching
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-7-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-7-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE2OSBTYWx0ZWRfXw3XqjmHj7W7y
 he5++/hm7f6WIaqbSEV1GtRaAmIyRFkdgAGP9QVGWwEYa9A6AhfMSXCene99LtE3FM+JMa/BWXy
 FgnkmiE6GMpPtKsc0KoMBIKtKw/WUSrLx6kD+q2kLB7NVdUqBkWLIOsbvr7Ho5l5VeVipptZnrC
 r0M3r0S8kHAw2z/a1okZsb2Qjzvl8fSbHFYKuSQ6MG+lYRObAE6+2Ao2JvrHVz2c1zMkc3JoaKD
 5dVpvFar0o/j45AdU1631WOJ0qMH2IkrmECjyausEQuG2OYlgO1Iv7HQJgo5jHz81ogdPfq846L
 ViHaC90TIqyLNR2i0XFPnabwnfMZBvSsGOFOAHiyo+MT/AJrRrkD/EVayGQmwcq/DBpUzMy/VUn
 Wzu7uLi2mfyjiNJL45aKqIV9nWIElX1dkmEspkwOjZCpc8bwl6hiDTYTkWQSD2I64o0EEbzS
X-Proofpoint-ORIG-GUID: Lmp7flx51yxytakB0ijhXNV8P4SZvJvF
X-Authority-Analysis: v=2.4 cv=d5f1yQjE c=1 sm=1 tr=0 ts=6824e5cc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=cvhWS9GGLzrGVX_1QB8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0PHj8_qTrBagzi-OcpIg0SEcp71g0H1M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 spamscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 impostorscore=0 adultscore=0 phishscore=0
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
> Test that the NSR exception bit field is equal to the pool ring value,
> rather than any common bits set, which is more correct (although there
> is no practical bug because the LSI NSR type is not implemented and
> POOL/PHYS NSR are encoded with exclusive bits).

Reviewed-by: Michael Kowal <kowal@linux.ibm.com>

Thanks MAK


>
> Fixes: 4c3ccac636 ("pnv/xive: Add special handling for pool targets")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/intc/xive.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 80b07a0afe..cebe409a1a 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -54,7 +54,8 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
>           uint8_t *alt_regs;
>   
>           /* POOL interrupt uses IPB in QW2, POOL ring */
> -        if ((ring == TM_QW3_HV_PHYS) && (nsr & (TM_QW3_NSR_HE_POOL << 6))) {
> +        if ((ring == TM_QW3_HV_PHYS) &&
> +            ((nsr & TM_QW3_NSR_HE) == (TM_QW3_NSR_HE_POOL << 6))) {
>               alt_ring = TM_QW2_HV_POOL;
>           } else {
>               alt_ring = ring;

