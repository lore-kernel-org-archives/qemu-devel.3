Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86300CA0EFD
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 17:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk55Q-0003K8-Ot; Fri, 30 Aug 2024 13:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sk55N-00037i-DX; Fri, 30 Aug 2024 13:06:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sk55L-0000XH-33; Fri, 30 Aug 2024 13:06:57 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UFo6iw018292;
 Fri, 30 Aug 2024 17:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=U
 z4NoSBBs6o4DSgatSi+xDxQp4qB0CPpZJull+pRkPY=; b=dlzItnQVgbE+fQsEn
 O/9NUKo8XgMOIvVXt3JiKa5XIrwQsANRG89S/5aBGrAjSOmXdHFP3CCVHWOM7wE/
 ZYCeBj5UGcY7k61UYVfH8OK7OvPO4ZFqBGUnfL+wUTQoIRE/HyAt4f1TklzXFMJ5
 PSHOfvLHeZn+KvWcyfU/bZ8K83MLx9TmNsTezicGRCOKEdSDSDTjtjzcA6ZXzBOT
 QgQAReq29ZG1sLt5yP/SHwZjr+1Q5vuExoQnAV599r9hywKbQPdR8OkK/+C0Ob++
 n3oXMTvuQZvFeBqz7mMTyMMJsxk0oBTk5o4DfhMhfjQZyl/4J6RywLCi+rNAAD0M
 o7PnQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8q0yyh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Aug 2024 17:06:43 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47UH6haU016486;
 Fri, 30 Aug 2024 17:06:43 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8q0yyd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Aug 2024 17:06:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47UGSRlr021748;
 Fri, 30 Aug 2024 17:06:42 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 417suuw9dv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Aug 2024 17:06:42 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 47UH6fiN46661960
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Aug 2024 17:06:41 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B9655805D;
 Fri, 30 Aug 2024 17:06:41 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E1D9358057;
 Fri, 30 Aug 2024 17:06:40 +0000 (GMT)
Received: from [9.10.80.165] (unknown [9.10.80.165])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 30 Aug 2024 17:06:40 +0000 (GMT)
Message-ID: <6527910d-aa34-4abb-a57f-e5c1789d059c@linux.ibm.com>
Date: Fri, 30 Aug 2024 12:06:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] pnv/xive: Update PIPR when updating CPPR
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240801203008.11224-1-kowal@linux.ibm.com>
 <20240801203008.11224-12-kowal@linux.ibm.com>
 <5dad962a-0815-40b8-b62a-d0c67612fa5f@kaod.org>
 <16bbfc74-e7c0-41b6-a91f-c2d121296986@linux.ibm.com>
 <cd6dee9a-8a98-49c8-832d-692a55dba909@kaod.org>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <cd6dee9a-8a98-49c8-832d-692a55dba909@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _WrcI2TrmWUrNihN7v8FnWi6015cTCtW
X-Proofpoint-GUID: xhQEzgN2rBvPPsuLsjL5WxT76IrtF1Md
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 bulkscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408300127
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On 8/30/2024 3:25 AM, Cédric Le Goater wrote:
> On 8/29/24 22:35, Mike Kowal wrote:
>>
>> On 8/29/2024 7:29 AM, Cédric Le Goater wrote:
>>> On 8/1/24 22:30, Michael Kowal wrote:
>>>> From: Glenn Miles <milesg@linux.vnet.ibm.com>
>>>>
>>>> Current code was updating the PIPR inside the xive_tctx_accept() 
>>>> function
>>>> instead of the xive_tctx_set_cppr function, which is where the HW 
>>>> would
>>>> have it updated.
>>>
>>> Did you confirm with the HW designer ?
>>>
>>> AFAIR, the PIPR is constructed from the IPB and the later is it updated
>>> the better. However, if now, both PIPR (HW and Pool) are required to
>>> identify the ctx to notify, I agree set_cppr() needs a change but what
>>> about xive_tctx_ipb_update() which is called when an interrupt
>>> needs a resend ?
>>
>>
>> This was fix to a bug and matches what  is specified in the XIVE2 
>> architecture document CPPR flows (MMIO CPPR xxx processing).
>
> ok. I was also wondering if this was fixing a bug. Do you think this
> is the correct commit id ?
>
>  cdd4de68edb6 ("ppc/xive: notify the CPU when the interrupt priority 
> is more privileged")
>
> If so, could you please add a Fixes tags ?
>
> Thanks,
>
> C.
>

Many of these parts have been changed multiple time for different 
things.   I am not sure which commit this fixes.  I am upstreaming other 
peoples work  that was done over the last couple of years so it hard to 
tell.  Also,  the original xive support was only complete enough to 
support Linux.   Much of this I would consider 'new development' 
expanding XIVE support for Power VM.   If you think it should still have 
a fixes-tag, I will add it.

MAK


>
>
>>
>>
>>>
>>>
>>> Thanks,
>>>
>>> C.
>>>
>>>
>>>
>>>> Moved the update to the xive_tctx_set_cppr function which required
>>>> additional support for pool interrupts.
>>>>
>>>> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
>>>> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
>>>> ---
>>>>   hw/intc/xive.c | 34 ++++++++++++++++++++++++++++++++--
>>>>   1 file changed, 32 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>>>> index 5c4ca7f6e0..d951aac3a0 100644
>>>> --- a/hw/intc/xive.c
>>>> +++ b/hw/intc/xive.c
>>>> @@ -89,7 +89,6 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, 
>>>> uint8_t ring)
>>>>             /* Reset the pending buffer bit */
>>>>           aregs[TM_IPB] &= ~xive_priority_to_ipb(cppr);
>>>> -        regs[TM_PIPR] = ipb_to_pipr(aregs[TM_IPB]);
>>>>             /* Drop Exception bit */
>>>>           regs[TM_NSR] &= ~mask;
>>>> @@ -143,6 +142,8 @@ void xive_tctx_reset_signal(XiveTCTX *tctx, 
>>>> uint8_t ring)
>>>>   static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, 
>>>> uint8_t cppr)
>>>>   {
>>>>       uint8_t *regs = &tctx->regs[ring];
>>>> +    uint8_t pipr_min;
>>>> +    uint8_t ring_min;
>>>>         trace_xive_tctx_set_cppr(tctx->cs->cpu_index, ring,
>>>>                                regs[TM_IPB], regs[TM_PIPR],
>>>> @@ -154,8 +155,37 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, 
>>>> uint8_t ring, uint8_t cppr)
>>>>         tctx->regs[ring + TM_CPPR] = cppr;
>>>>   +    /*
>>>> +     * Recompute the PIPR based on local pending interrupts. The PHYS
>>>> +     * ring must take the minimum of both the PHYS and POOL PIPR 
>>>> values.
>>>> +     */
>>>> +    pipr_min = ipb_to_pipr(regs[TM_IPB]);
>>>> +    ring_min = ring;
>>>> +
>>>> +    /* PHYS updates also depend on POOL values */
>>>> +    if (ring == TM_QW3_HV_PHYS) {
>>>> +        uint8_t *pregs = &tctx->regs[TM_QW2_HV_POOL];
>>>> +
>>>> +        /* POOL values only matter if POOL ctx is valid */
>>>> +        if (pregs[TM_WORD2] & 0x80) {
>>>> +
>>>> +            uint8_t pool_pipr = ipb_to_pipr(pregs[TM_IPB]);
>>>> +
>>>> +            /*
>>>> +             * Determine highest priority interrupt and
>>>> +             * remember which ring has it.
>>>> +             */
>>>> +            if (pool_pipr < pipr_min) {
>>>> +                pipr_min = pool_pipr;
>>>> +                ring_min = TM_QW2_HV_POOL;
>>>> +            }
>>>> +        }
>>>> +    }
>>>> +
>>>> +    regs[TM_PIPR] = pipr_min;
>>>> +
>>>>       /* CPPR has changed, check if we need to raise a pending 
>>>> exception */
>>>> -    xive_tctx_notify(tctx, ring);
>>>> +    xive_tctx_notify(tctx, ring_min);
>>>>   }
>>>>     void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t 
>>>> ipb)
>>>
>

