Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837E9C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 19:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFHeI-0004hn-0O; Wed, 14 May 2025 15:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFHSU-000151-A2; Wed, 14 May 2025 15:08:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFHSS-0000vr-CA; Wed, 14 May 2025 15:08:02 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EHZ1a2029614;
 Wed, 14 May 2025 19:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qPPvZp
 Jx/FEjYRlLMGYK1299ZKVapEDdIo+vxqWvZjs=; b=nx755tEF/xCOwj9S4h3HHn
 fMmnxZgAidF07kjMRYZO9DOJVm7luo/Td+Xf8Ph0YGqoUCGi8hlcq9PKXK5Co4+r
 CKsZ9jSjLhPe9/bfUuZe6aS0fUswBaxs63CS2zNnqrOLx3yvSdDKYI2HgMLptcGi
 /9oN0iDE9BF638slY9aM0d5nrF931jf/QUlrgx0RtwHdMQW5GQ5B3Q8AQF032iFH
 MXC8QDCm9bu1NlQm5dzzuxkaXB5mISCU2TpjUSFAqu3xAgcm8Z7IhUNPl3fP1SBJ
 PFyrJl8J2RVrOscIWaWgjwzEcNB0jkCiRPgsXwvXGhuUHVinYyGxPNciE35A7HIA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mr1gk7cw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:07:58 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EJ6nd4004445;
 Wed, 14 May 2025 19:07:58 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mr1gk7ct-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:07:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EGkbIc026912;
 Wed, 14 May 2025 19:07:57 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpdytf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:07:57 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EJ7tvP9962148
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 19:07:56 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9ED6A5803F;
 Wed, 14 May 2025 19:07:55 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 212BB5804E;
 Wed, 14 May 2025 19:07:55 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 19:07:55 +0000 (GMT)
Message-ID: <ecf642af-4531-40ad-988c-27e55350f745@linux.ibm.com>
Date: Wed, 14 May 2025 14:07:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/50] ppc/xive: Explicitly zero NSR after accepting
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-15-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-15-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GggJ58-1whemrG7vz1f672XoSRr3lkgF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE3NCBTYWx0ZWRfXz90c28RzXIPA
 R8yzSa7vtSAiZGi/TAEOxaxTRZS/00hRVf/lcCzNl3vMNXQbvN/VZ9gpT50jy45a0Lxeop/olNQ
 TFqUhcqglWy+kfbfNhW/JIgASYSqoGdX+Ex4DWfmzoMD2WDd8+Yq+/ZHoOxA0lzcklIzfECD8Cz
 3nau3FDVkphZvpdMb8w5sVwY9Vi51vEBJwmgqnrDwmx1sRZ6/7iBckarMxqoKRTS86SYwg7x3rq
 ARKIgOcVijrnrdusDPf6DkJ7heRVLPR/QTjlTMP/zyoUtvhrx7yL6ElOYjHQTP1ade/AqKlDMUE
 20gYSi/+Lb+TM8EFch+csSEzAVd/5hmTj0p95Kx7jxkJm2rgknWiiidl7+iQS1Ey/nfKyGD7sA5
 YO/CBLlSd7W12QZxAJceC1LLA7zE+VkaJ3WobYD1jW68J1MLgycjGZUjj045TdKcLQG9ooFA
X-Proofpoint-GUID: 5WD05RObqwvepOAEcEPyCeBEGf2R40g9
X-Authority-Analysis: v=2.4 cv=QOxoRhLL c=1 sm=1 tr=0 ts=6824ea0e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=wxj7F0bw5xdmOB-2o6UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=670
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140174
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
> Have xive_tctx_accept clear NSR in one shot rather than masking out bits
> as they are tested, which makes it clear it's reset to 0, and does not
> have a partial NSR value in the register.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/intc/xive.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 6293ea4361..bb40a69c5b 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -68,13 +68,11 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
>            * If the interrupt was for a specific VP, reset the pending
>            * buffer bit, otherwise clear the logical server indicator
>            */
> -        if (regs[TM_NSR] & TM_NSR_GRP_LVL) {
> -            regs[TM_NSR] &= ~TM_NSR_GRP_LVL;
> -        } else {
> +        if (!(regs[TM_NSR] & TM_NSR_GRP_LVL)) {


Any reason why you didn't just use the else?  Regardless I am fine 
either way.

Reviewed-by: Michael Kowal <kowal@linux.ibm.com>

Thanks MAK


>               alt_regs[TM_IPB] &= ~xive_priority_to_ipb(cppr);
>           }
>   
> -        /* Drop the exception bit and any group/crowd */
> +        /* Clear the exception from NSR */
>           regs[TM_NSR] = 0;
>   
>           trace_xive_tctx_accept(tctx->cs->cpu_index, alt_ring,

