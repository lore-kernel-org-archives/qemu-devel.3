Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F60C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 15:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFDkx-0004ED-FH; Wed, 14 May 2025 11:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFD7a-0006VP-Pp; Wed, 14 May 2025 10:30:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFD7Y-0006Vs-Ur; Wed, 14 May 2025 10:30:10 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E9EuJS012686;
 Wed, 14 May 2025 14:30:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mLhb6D
 vAbC604urS6e8lLrty700GuZ+7Yqlf2chSZAU=; b=F1zdk2BohQB2Bc7OPa5Y5L
 0TNH6OTE6+w0+GKdT9qSeb9471I0ZU5sgNM7pxZRj3vevzuF9FPs3kTSvhXGaQnR
 7nieoRVpB8/ZpekRT4OaQiOoDCi7b7Qj5MaOFQk5iublyth8bn7kMLYPWPY+zO3x
 Wq26o6fe3w+G/aCROioDUaPo0xySnCW1Fa35UTYwvHAjC7UHCno8+MTftXFLLA7P
 lqjCL21twiomZa+srthBCJjIPdju6RhmFOT8FSOlTfV5gSu+96B9mG8uNtmafK4D
 E9qALy7+c9YaXfbmPafSIzhPjEkq4qoPXjlPta6cI6u48iZaqBWcCiBvvp2pUsXA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mrcj9he8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:30:07 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EEQTHe024637;
 Wed, 14 May 2025 14:30:06 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mrcj9he5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:30:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EDcPgt026939;
 Wed, 14 May 2025 14:30:06 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpcn4d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:30:06 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EEU4xw15467182
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 14:30:04 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D54658066;
 Wed, 14 May 2025 14:30:04 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5CE058063;
 Wed, 14 May 2025 14:30:03 +0000 (GMT)
Received: from [9.10.255.115] (unknown [9.10.255.115])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 14:30:03 +0000 (GMT)
Message-ID: <4ce8bae6-b914-444c-9384-5944b03905bb@linux.ibm.com>
Date: Wed, 14 May 2025 09:30:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/50] ppc/xive2: fix context push calculation of IPB
 priority
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-6-npiggin@gmail.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <20250512031100.439842-6-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZYgdNtVA c=1 sm=1 tr=0 ts=6824a8ef cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=yJ9lfIZagGyyCFpBJUMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: VzG-wxLtM5zz7uQS7ESyn3TfFLcXCtnC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDEyNSBTYWx0ZWRfX+o+VqZqq7OAL
 nyMAWNAjg85xti5kj7APGhR3LlUqE9EjLSAkeDCGL1GFxcc8JCBR5ZUAYlq8qB31f3ltNU7I0xU
 kch52hVHL6dYGAHQBBzNY8TD7Qso2DLEAGnSXKX2lJevzq5PVhP/ioHcIRK1Zn/Aj2FIEe8mYMq
 mlinzwIFDESx9R/vhvFtK8z8RkHIBP5q4fNJe4CgF5TWrtKAlcCasLvgmQcwzkd++lMXvIifSDS
 1ES7F3YxS15zK/ny1iOhOuEI7ZnYQPPS4XelF/3nwEoO1/1DJvIkH/3bD+c7nnwkp2RpkZf7WNI
 lCW9pGYhZ5XV0UZZHe712ypFn+ar2Aa3AZrY/0eA8TjRMja3zWggmFWkkgBu1hAyp1O/YpkZr1Y
 D+WNxld6HoqxUhwLH2OjsmxzezcH2/oD9znSMJeazNuUA2u26wRg6JrkrlzHZ+mwV1HI7H5c
X-Proofpoint-GUID: eK9wNyuqJ0MEKLZIEqhq6__LOUgUq9Xh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=752 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
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
X-Mailman-Approved-At: Wed, 14 May 2025 11:10:33 -0400
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
> Pushing a context and loading IPB from NVP is defined to merge ('or')
> that IPB into the TIMA IPB register. PIPR should therefore be calculated
> based on the final IPB value, not just the NVP value.
> 
> Fixes: 9d2b6058c5b ("ppc/xive2: Add grouping level to notification")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive2.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 790152a2a6..4dd04a0398 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -835,8 +835,9 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
>          nvp.w2 = xive_set_field32(NVP2_W2_IPB, nvp.w2, 0);
>          xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, &nvp, 2);
>      }
> +    /* IPB bits in the backlog are merged with the TIMA IPB bits */
>      regs[TM_IPB] |= ipb;
> -    backlog_prio = xive_ipb_to_pipr(ipb);
> +    backlog_prio = xive_ipb_to_pipr(regs[TM_IPB]);
>      backlog_level = 0;
> 
>      first_group = xive_get_field32(NVP2_W0_PGOFIRST, nvp.w0);


