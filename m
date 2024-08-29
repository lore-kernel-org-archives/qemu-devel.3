Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2560C87FDA
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 20:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjlrp-0007gG-HI; Thu, 29 Aug 2024 16:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sjlrl-0007dm-Tq; Thu, 29 Aug 2024 16:35:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sjlrj-00083P-Mf; Thu, 29 Aug 2024 16:35:37 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47THePQo021195;
 Thu, 29 Aug 2024 20:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=N
 WZFRyYMhecImfWify7gj2O51ky/s8GmbQDoNEMcW5k=; b=Waz2vfGozxXLW5x3v
 B8IxPLlyyiihuaa/MexZjuZ0Ud5pHv7jsXd9CbJAkJyhtCykNZARTZbrWQBUp4Fz
 LZCCKXRiSEWlKvc3/0yxl96nkHBBDLjyPc++piATSn3G+Ee/X8d2LbGb62QGRYBC
 vZUsyBq8DQ/bwoS8ALO7TAAwijMOPWBEjBpQlFzjHg+M7BG53sxl9I6E/pc/xyZO
 lc8O6Pq0A0EgFbt9L+aM8h3Ss2XyATerhx2Hj9ZXldjyq0/8wioedoxk8w6PQywh
 0WFfTp/rdmy71ZrnPTIL1CNNJsvVwWQqYYq9bgW8aIbuSu4k4E/Lbx6y68IVOB8q
 vzNeQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8p2dbm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Aug 2024 20:35:30 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47TKZUsH023699;
 Thu, 29 Aug 2024 20:35:30 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8p2dbk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Aug 2024 20:35:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47TJSlLg024622;
 Thu, 29 Aug 2024 20:35:29 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 417vj3pd21-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Aug 2024 20:35:29 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 47TKZS6J23069272
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Aug 2024 20:35:28 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EAD8258059;
 Thu, 29 Aug 2024 20:35:27 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 819515805B;
 Thu, 29 Aug 2024 20:35:27 +0000 (GMT)
Received: from [9.10.80.165] (unknown [9.10.80.165])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Aug 2024 20:35:27 +0000 (GMT)
Message-ID: <16bbfc74-e7c0-41b6-a91f-c2d121296986@linux.ibm.com>
Date: Thu, 29 Aug 2024 15:35:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] pnv/xive: Update PIPR when updating CPPR
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240801203008.11224-1-kowal@linux.ibm.com>
 <20240801203008.11224-12-kowal@linux.ibm.com>
 <5dad962a-0815-40b8-b62a-d0c67612fa5f@kaod.org>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <5dad962a-0815-40b8-b62a-d0c67612fa5f@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZSxLouGNB5m6k7mD-Z_2haE8nEyEEuxY
X-Proofpoint-ORIG-GUID: WxKxIaCw2vc6EZF4qG1AFA4sRsjEjOqv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_06,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408290145
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


On 8/29/2024 7:29 AM, Cédric Le Goater wrote:
> On 8/1/24 22:30, Michael Kowal wrote:
>> From: Glenn Miles <milesg@linux.vnet.ibm.com>
>>
>> Current code was updating the PIPR inside the xive_tctx_accept() 
>> function
>> instead of the xive_tctx_set_cppr function, which is where the HW would
>> have it updated.
>
> Did you confirm with the HW designer ?
>
> AFAIR, the PIPR is constructed from the IPB and the later is it updated
> the better. However, if now, both PIPR (HW and Pool) are required to
> identify the ctx to notify, I agree set_cppr() needs a change but what
> about xive_tctx_ipb_update() which is called when an interrupt
> needs a resend ?


This was fix to a bug and matches what  is specified in the XIVE2 
architecture document CPPR flows (MMIO CPPR xxx processing).


>
>
> Thanks,
>
> C.
>
>
>
>> Moved the update to the xive_tctx_set_cppr function which required
>> additional support for pool interrupts.
>>
>> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
>> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
>> ---
>>   hw/intc/xive.c | 34 ++++++++++++++++++++++++++++++++--
>>   1 file changed, 32 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index 5c4ca7f6e0..d951aac3a0 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -89,7 +89,6 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, 
>> uint8_t ring)
>>             /* Reset the pending buffer bit */
>>           aregs[TM_IPB] &= ~xive_priority_to_ipb(cppr);
>> -        regs[TM_PIPR] = ipb_to_pipr(aregs[TM_IPB]);
>>             /* Drop Exception bit */
>>           regs[TM_NSR] &= ~mask;
>> @@ -143,6 +142,8 @@ void xive_tctx_reset_signal(XiveTCTX *tctx, 
>> uint8_t ring)
>>   static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, 
>> uint8_t cppr)
>>   {
>>       uint8_t *regs = &tctx->regs[ring];
>> +    uint8_t pipr_min;
>> +    uint8_t ring_min;
>>         trace_xive_tctx_set_cppr(tctx->cs->cpu_index, ring,
>>                                regs[TM_IPB], regs[TM_PIPR],
>> @@ -154,8 +155,37 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, 
>> uint8_t ring, uint8_t cppr)
>>         tctx->regs[ring + TM_CPPR] = cppr;
>>   +    /*
>> +     * Recompute the PIPR based on local pending interrupts. The PHYS
>> +     * ring must take the minimum of both the PHYS and POOL PIPR 
>> values.
>> +     */
>> +    pipr_min = ipb_to_pipr(regs[TM_IPB]);
>> +    ring_min = ring;
>> +
>> +    /* PHYS updates also depend on POOL values */
>> +    if (ring == TM_QW3_HV_PHYS) {
>> +        uint8_t *pregs = &tctx->regs[TM_QW2_HV_POOL];
>> +
>> +        /* POOL values only matter if POOL ctx is valid */
>> +        if (pregs[TM_WORD2] & 0x80) {
>> +
>> +            uint8_t pool_pipr = ipb_to_pipr(pregs[TM_IPB]);
>> +
>> +            /*
>> +             * Determine highest priority interrupt and
>> +             * remember which ring has it.
>> +             */
>> +            if (pool_pipr < pipr_min) {
>> +                pipr_min = pool_pipr;
>> +                ring_min = TM_QW2_HV_POOL;
>> +            }
>> +        }
>> +    }
>> +
>> +    regs[TM_PIPR] = pipr_min;
>> +
>>       /* CPPR has changed, check if we need to raise a pending 
>> exception */
>> -    xive_tctx_notify(tctx, ring);
>> +    xive_tctx_notify(tctx, ring_min);
>>   }
>>     void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb)
>

