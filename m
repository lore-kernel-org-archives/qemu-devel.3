Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDD1C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFaOh-0006xZ-Mn; Thu, 15 May 2025 11:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFaOY-0006s8-4R; Thu, 15 May 2025 11:21:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFaOU-0002hQ-5R; Thu, 15 May 2025 11:21:12 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCg4j1002178;
 Thu, 15 May 2025 15:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=UmDDXg
 qCj3A+5S6IOy2/wjk4Vi304qYtPAn1OWoGARo=; b=bhMi64z0W8eegzcLqvfgt7
 CueIeBCjN8/aB13w2rosWVlLQzI8/0fRk1h8MrqzFGc60hRuF9lh0Mcf8+QnEavk
 /BEuOsyXaATjsd5Wwj4eXzs74sr5msQXeIkQpU7PndcHg6aPQYCwr2Q0dUDzM9r7
 /lvFOYSmP7ptJtvFtXv7SJyKwmoBcLBzMlthAp1rgodHZ2KTOyeebXx9b0WwSN2D
 qjI9RjUNE/g4L+qwLxSHYy/fUvO2H1Ott29G6z74D3VzAMVE23WDVZQErYpy8mqc
 KGJo4cL+s380l1vwR06NPwZQm9Q5xaZNSjsHAhf7KTPvkefSDIl2yeYzC8/UJr6Q
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6n8j3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:21:07 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FF48ak014960;
 Thu, 15 May 2025 15:21:06 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6n8hu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:21:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEHnpt021424;
 Thu, 15 May 2025 15:21:06 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfrtvga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:21:06 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFL4Ps28770822
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:21:04 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6456258062;
 Thu, 15 May 2025 15:21:04 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D01D58064;
 Thu, 15 May 2025 15:21:04 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:21:04 +0000 (GMT)
Message-ID: <71aaca95-08fd-4d99-8a96-412f795e1020@linux.ibm.com>
Date: Thu, 15 May 2025 10:21:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/50] ppc/xive: Add xive_tctx_pipr_present() to present
 new interrupt
From: Mike Kowal <kowal@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-31-npiggin@gmail.com>
 <0ed60dc4-0986-46be-adda-0539d356e2db@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <0ed60dc4-0986-46be-adda-0539d356e2db@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqAecK/g c=1 sm=1 tr=0 ts=68260663 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=an0ll-fgga2B6gs6qWEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: tJU4RLZl1dP0N6omya_def8AjangiABu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1MCBTYWx0ZWRfXyDk89lljynS1
 Guq6BjpYLQC7lzWT8clFhi3bDQQKomVMYBFhbxx6ExWK3XpTUd+FFmrygr7btjv2RvKLSfgSPbx
 JK4gNU+gAg/zHOVdte5HkWk/3dCLtaEvbRydUzo4gDkx9E3u0ksc+2sGKLsM1VenJp0QmN5EMLA
 yRXxAHElYtdjnNHBFN7wOAjxzssdZu3/MEutZ2U51rNuoZ8aNph6kBTqtbnrFIjQBCCXV7Kd7aD
 Ea3mAdwcDbV+Uq6corZBggPchJuUrDS3rG1pUdLLqqnN8V2NpfIfE4DoA+e+PdWi3LDl6jm7GE8
 Xg2Vce8Kb+j8Z4tS4ZnSrneqMN/n4qICJp1fY9CcR2Kr9tqzJaBCNa2n1be6wVnnYTDbpT1RL2x
 6KRx4FnxOsFvPYbHEuXIceUz1ro2s4Aj1GTqykQvlKA8KQ+g8LXebHojI8F4y6nnDfTK8A7R
X-Proofpoint-GUID: fYHPtDf2PqEktnLlQtWABlzn1s_S-p0T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150150
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


On 5/14/2025 3:10 PM, Mike Kowal wrote:
>
> On 5/11/2025 10:10 PM, Nicholas Piggin wrote:
>> xive_tctx_pipr_update() is used for multiple things. In an effort
>> to make things simpler and less overloaded, split out the function
>> that is used to present a new interrupt to the tctx.
>
>
> Why is this a separate commit fro 30?   The change here does not do 
> anything different.
> Regardless, taken this patch set as a whole, it's good by me.


Okay,  I see the rest  or this is done in patch set 35...


>
> Reviewed-by: Michael Kowal<kowal@linux.ibm.com>
>
> Thanks,  MAK
>
>
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   hw/intc/xive.c        | 8 +++++++-
>>   hw/intc/xive2.c       | 2 +-
>>   include/hw/ppc/xive.h | 2 ++
>>   3 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index 27b5a21371..bf4c0634ca 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -225,6 +225,12 @@ void xive_tctx_pipr_update(XiveTCTX *tctx, 
>> uint8_t ring, uint8_t priority,
>>       xive_tctx_notify(tctx, ring, group_level);
>>    }
>>   +void xive_tctx_pipr_present(XiveTCTX *tctx, uint8_t ring, uint8_t 
>> priority,
>> +                            uint8_t group_level)
>> +{
>> +    xive_tctx_pipr_update(tctx, ring, priority, group_level);
>> +}
>> +
>>   /*
>>    * XIVE Thread Interrupt Management Area (TIMA)
>>    */
>> @@ -2040,7 +2046,7 @@ void xive_router_end_notify(XiveRouter *xrtr, 
>> XiveEAS *eas)
>> xive_get_field32(END_W7_F1_LOG_SERVER_ID, end.w7),
>>                                &match)) {
>>           trace_xive_presenter_notify(nvt_blk, nvt_idx, match.ring, 0);
>> -        xive_tctx_pipr_update(match.tctx, match.ring, priority, 0);
>> +        xive_tctx_pipr_present(match.tctx, match.ring, priority, 0);
>>           return;
>>       }
>>   diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
>> index cae4092198..f91109b84a 100644
>> --- a/hw/intc/xive2.c
>> +++ b/hw/intc/xive2.c
>> @@ -1652,7 +1652,7 @@ static void xive2_router_end_notify(Xive2Router 
>> *xrtr, uint8_t end_blk,
>>             group_level = xive_get_group_level(crowd, cam_ignore, 
>> nvx_blk, nvx_idx);
>>           trace_xive_presenter_notify(nvx_blk, nvx_idx, ring, 
>> group_level);
>> -        xive_tctx_pipr_update(tctx, ring, priority, group_level);
>> +        xive_tctx_pipr_present(tctx, ring, priority, group_level);
>>           return;
>>       }
>>   diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>> index 8152a9df3d..0d6b11e818 100644
>> --- a/include/hw/ppc/xive.h
>> +++ b/include/hw/ppc/xive.h
>> @@ -562,6 +562,8 @@ void xive_tctx_reset(XiveTCTX *tctx);
>>   void xive_tctx_destroy(XiveTCTX *tctx);
>>   void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t 
>> priority,
>>                              uint8_t group_level);
>> +void xive_tctx_pipr_present(XiveTCTX *tctx, uint8_t ring, uint8_t 
>> priority,
>> +                            uint8_t group_level);
>>   void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring);
>>   void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring, uint8_t 
>> group_level);
>>   uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring);

