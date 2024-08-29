Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0B0C87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 20:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjlkh-0005h3-Pl; Thu, 29 Aug 2024 16:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sjlkg-0005fw-Ks; Thu, 29 Aug 2024 16:28:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sjlkc-0007Bf-NC; Thu, 29 Aug 2024 16:28:18 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47THeSBI017477;
 Thu, 29 Aug 2024 20:28:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-type:message-id:date:mime-version:subject:to:cc
 :references:from:in-reply-to; s=pp1; bh=Qu7J91/zSOSMH5juCtRFm+Rt
 FCadjw8hDPRDF9S5c0E=; b=goZ0dWFYYS7uM7xjN/UJCCZ/jLu0kC+XLSvgh7oQ
 G+xVfgG5qu2qu4D7OJQVd2KW/sQEENZAMYmhw4PBHJxG8ol9wJdLoXIpW1yzno2C
 ApebiQtznN/g2u81ZsFuuTU7Z1TLdzDofzmeYchap1Tyl+M6CJM5dWadScQCk8w2
 e4FmX2jfnUjo3h7vrISJT4DNk3k/PpFUmpZtvt0UZR5TrxgdEO+U8My9vjc7gRxI
 8KBTIY5B71C2CC4l5lJ4sY3zkpLd7XGDT3CRDXQxoN6bPOFInBjHHnGCUhF5Hbek
 FWY09dVe+u52Qsmm5iCJy38LvmbS2OGEDT/kPk8YvtgmKA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8ptcj4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Aug 2024 20:28:04 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47TKP5Tk031090;
 Thu, 29 Aug 2024 20:28:04 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8ptcj2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Aug 2024 20:28:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47TIYMJV027960;
 Thu, 29 Aug 2024 20:28:02 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 417ubneje8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Aug 2024 20:28:02 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 47TKS1CM3015184
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Aug 2024 20:28:01 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 52DC058059;
 Thu, 29 Aug 2024 20:28:01 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C3A705804B;
 Thu, 29 Aug 2024 20:28:00 +0000 (GMT)
Received: from [9.10.80.165] (unknown [9.10.80.165])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Aug 2024 20:28:00 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------UxQMWkvr4K0a9t4YwcfAFGIP"
Message-ID: <6df33f25-d429-466a-98fa-48b6695366ac@linux.ibm.com>
Date: Thu, 29 Aug 2024 15:27:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] pnv/xive: Add special handling for pool targets
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240801203008.11224-1-kowal@linux.ibm.com>
 <20240801203008.11224-11-kowal@linux.ibm.com>
 <2673ff94-ffc7-49a9-9754-04ad58d4fdf4@kaod.org>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <2673ff94-ffc7-49a9-9754-04ad58d4fdf4@kaod.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3-5Jjm-bxUBsJO1qK2xX3IHpk-WEzkmc
X-Proofpoint-GUID: 9M_gqLIVENxBIvw9-QjkNMZqidXymVNM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_06,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 bulkscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408290141
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is a multi-part message in MIME format.
--------------UxQMWkvr4K0a9t4YwcfAFGIP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/29/2024 7:14 AM, Cédric Le Goater wrote:
> On 8/1/24 22:30, Michael Kowal wrote:
>> From: Glenn Miles <milesg@linux.vnet.ibm.com>
>>
>> Hypervisor "pool" targets do not get their own interrupt line and 
>> instead
>> must share an interrupt line with the hypervisor "physical" targets.
>> This also means that the pool ring must use some of the registers 
>> from the
>> physical ring in the TIMA.  Specifically, the NSR, PIPR and CPPR 
>> registers:
>>
>>    NSR = Notification Source Register
>>    PIPR = Post Interrupt Priority Register
>>    CPPR = Current Processor Priority Register
>>
>> The NSR specifies that there is an active interrupt.  The CPPR
>> specifies the priority of the context and the PIPR specifies the
>> priority of the interrupt.  For an interrupt to be presented to
>> a context, the priority of the interrupt must be higher than the
>> priority of the context it is interrupting (value must be lower).
>>
>> The existing code was not aware of the sharing of these registers.
>> This commit adds that support.
>>
>> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
>> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
>> ---
>>   hw/intc/xive.c | 36 ++++++++++++++++++++++++++----------
>>   1 file changed, 26 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index 9d85da0999..5c4ca7f6e0 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -67,25 +67,35 @@ static qemu_irq xive_tctx_output(XiveTCTX *tctx, 
>> uint8_t ring)
>>   static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
>>   {
>>       uint8_t *regs = &tctx->regs[ring];
>> -    uint8_t nsr = regs[TM_NSR];
>> +    uint64_t nsr = regs[TM_NSR];
>
> why ?


I asked Glenn the same question.  I think was worried about overflow on 
the return statement below.  I can find an alternative.

return (nsr << 8) | regs[TM_CPPR];

>
>>       uint8_t mask = exception_mask(ring);
>>         qemu_irq_lower(xive_tctx_output(tctx, ring));
>>         if (regs[TM_NSR] & mask) {
>>           uint8_t cppr = regs[TM_PIPR];
>> +        uint8_t alt_ring;
>> +        uint8_t *aregs;
>
> I would prefer keeping the same prefix :
>
>         uint8_t *alt_regs;
>
>
> Thanks,
>
> C.
>
>
>> +
>> +        /* POOL interrupt uses IPB in QW2, POOL ring */
>> +        if ((ring == TM_QW3_HV_PHYS) && (nsr & (TM_QW3_NSR_HE_POOL 
>> << 6))) {
>> +            alt_ring = TM_QW2_HV_POOL;
>> +        } else {
>> +            alt_ring = ring;
>> +        }
>> +        aregs = &tctx->regs[alt_ring];
>>             regs[TM_CPPR] = cppr;
>>             /* Reset the pending buffer bit */
>> -        regs[TM_IPB] &= ~xive_priority_to_ipb(cppr);
>> -        regs[TM_PIPR] = ipb_to_pipr(regs[TM_IPB]);
>> +        aregs[TM_IPB] &= ~xive_priority_to_ipb(cppr);
>> +        regs[TM_PIPR] = ipb_to_pipr(aregs[TM_IPB]);
>>             /* Drop Exception bit */
>>           regs[TM_NSR] &= ~mask;
>>   -        trace_xive_tctx_accept(tctx->cs->cpu_index, ring,
>> -                               regs[TM_IPB], regs[TM_PIPR],
>> +        trace_xive_tctx_accept(tctx->cs->cpu_index, alt_ring,
>> +                               aregs[TM_IPB], regs[TM_PIPR],
>>                                  regs[TM_CPPR], regs[TM_NSR]);
>>       }
>>   @@ -94,13 +104,19 @@ static uint64_t xive_tctx_accept(XiveTCTX 
>> *tctx, uint8_t ring)
>>     static void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring)
>>   {
>> +    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
>> +    uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : 
>> ring;
>> +    uint8_t *aregs = &tctx->regs[alt_ring];
>>       uint8_t *regs = &tctx->regs[ring];
>>   -    if (regs[TM_PIPR] < regs[TM_CPPR]) {
>> +    if (aregs[TM_PIPR] < aregs[TM_CPPR]) {
>>           switch (ring) {
>>           case TM_QW1_OS:
>>               regs[TM_NSR] |= TM_QW1_NSR_EO;
>>               break;
>> +        case TM_QW2_HV_POOL:
>> +            aregs[TM_NSR] = (TM_QW3_NSR_HE_POOL << 6);
>> +            break;
>>           case TM_QW3_HV_PHYS:
>>               regs[TM_NSR] |= (TM_QW3_NSR_HE_PHYS << 6);
>>               break;
>> @@ -108,8 +124,8 @@ static void xive_tctx_notify(XiveTCTX *tctx, 
>> uint8_t ring)
>>               g_assert_not_reached();
>>           }
>>           trace_xive_tctx_notify(tctx->cs->cpu_index, ring,
>> -                               regs[TM_IPB], regs[TM_PIPR],
>> -                               regs[TM_CPPR], regs[TM_NSR]);
>> +                               regs[TM_IPB], aregs[TM_PIPR],
>> +                               aregs[TM_CPPR], aregs[TM_NSR]);
>>           qemu_irq_raise(xive_tctx_output(tctx, ring));
>>       }
>>   }
>> @@ -217,14 +233,14 @@ static uint64_t xive_tm_vt_poll(XivePresenter 
>> *xptr, XiveTCTX *tctx,
>>   static const uint8_t xive_tm_hw_view[] = {
>>       3, 0, 0, 0,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-0 
>> User */
>>       3, 3, 3, 3,   3, 3, 0, 2,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-1 
>> OS   */
>> -    0, 0, 3, 3,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-2 
>> POOL */
>> +    0, 0, 3, 3,   0, 3, 3, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-2 
>> POOL */
>>       3, 3, 3, 3,   0, 3, 0, 2,   3, 0, 0, 3,   3, 3, 3, 0, /* QW-3 
>> PHYS */
>>   };
>>     static const uint8_t xive_tm_hv_view[] = {
>>       3, 0, 0, 0,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-0 
>> User */
>>       3, 3, 3, 3,   3, 3, 0, 2,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-1 
>> OS   */
>> -    0, 0, 3, 3,   0, 0, 0, 0,   0, 3, 3, 3,   0, 0, 0, 0, /* QW-2 
>> POOL */
>> +    0, 0, 3, 3,   0, 3, 3, 0,   0, 3, 3, 3,   0, 0, 0, 0, /* QW-2 
>> POOL */
>>       3, 3, 3, 3,   0, 3, 0, 2,   3, 0, 0, 3,   0, 0, 0, 0, /* QW-3 
>> PHYS */
>>   };
>
--------------UxQMWkvr4K0a9t4YwcfAFGIP
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 8/29/2024 7:14 AM, Cédric Le Goater
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:2673ff94-ffc7-49a9-9754-04ad58d4fdf4@kaod.org">On 8/1/24
      22:30, Michael Kowal wrote:
      <br>
      <blockquote type="cite">From: Glenn Miles
        <a class="moz-txt-link-rfc2396E" href="mailto:milesg@linux.vnet.ibm.com">&lt;milesg@linux.vnet.ibm.com&gt;</a>
        <br>
        <br>
        Hypervisor "pool" targets do not get their own interrupt line
        and instead
        <br>
        must share an interrupt line with the hypervisor "physical"
        targets.
        <br>
        This also means that the pool ring must use some of the
        registers from the
        <br>
        physical ring in the TIMA.  Specifically, the NSR, PIPR and CPPR
        registers:
        <br>
        <br>
           NSR = Notification Source Register
        <br>
           PIPR = Post Interrupt Priority Register
        <br>
           CPPR = Current Processor Priority Register
        <br>
        <br>
        The NSR specifies that there is an active interrupt.  The CPPR
        <br>
        specifies the priority of the context and the PIPR specifies the
        <br>
        priority of the interrupt.  For an interrupt to be presented to
        <br>
        a context, the priority of the interrupt must be higher than the
        <br>
        priority of the context it is interrupting (value must be
        lower).
        <br>
        <br>
        The existing code was not aware of the sharing of these
        registers.
        <br>
        This commit adds that support.
        <br>
        <br>
        Signed-off-by: Glenn Miles <a class="moz-txt-link-rfc2396E" href="mailto:milesg@linux.vnet.ibm.com">&lt;milesg@linux.vnet.ibm.com&gt;</a>
        <br>
        Signed-off-by: Michael Kowal <a class="moz-txt-link-rfc2396E" href="mailto:kowal@linux.ibm.com">&lt;kowal@linux.ibm.com&gt;</a>
        <br>
        ---
        <br>
          hw/intc/xive.c | 36 ++++++++++++++++++++++++++----------
        <br>
          1 file changed, 26 insertions(+), 10 deletions(-)
        <br>
        <br>
        diff --git a/hw/intc/xive.c b/hw/intc/xive.c
        <br>
        index 9d85da0999..5c4ca7f6e0 100644
        <br>
        --- a/hw/intc/xive.c
        <br>
        +++ b/hw/intc/xive.c
        <br>
        @@ -67,25 +67,35 @@ static qemu_irq xive_tctx_output(XiveTCTX
        *tctx, uint8_t ring)
        <br>
          static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
        <br>
          {
        <br>
              uint8_t *regs = &amp;tctx-&gt;regs[ring];
        <br>
        -    uint8_t nsr = regs[TM_NSR];
        <br>
        +    uint64_t nsr = regs[TM_NSR];
        <br>
      </blockquote>
      <br>
      why ?
      <br>
    </blockquote>
    <p><br>
    </p>
    <p>I asked Glenn the same question.  I think was worried about
      overflow on the return statement below.  I can find an
      alternative.</p>
    <p>
    </p>
    <div
style="font-family: &quot;Consolas&quot;; font-size: 11.0pt; color: #000000;background-color: #FFFFFF; font-style: normal; font-weight: normal; text-decoration: none;">
      <pre><font face="Courier New, Courier, monospace"><span
      style="color:#FF0000;font-weight: bolder;">return</span> (nsr &lt;&lt; 8) | regs[TM_CPPR];</font>

</pre>
    </div>
    <blockquote type="cite"
      cite="mid:2673ff94-ffc7-49a9-9754-04ad58d4fdf4@kaod.org">
      <br>
      <blockquote type="cite">      uint8_t mask = exception_mask(ring);
        <br>
                qemu_irq_lower(xive_tctx_output(tctx, ring));
        <br>
                if (regs[TM_NSR] &amp; mask) {
        <br>
                  uint8_t cppr = regs[TM_PIPR];
        <br>
        +        uint8_t alt_ring;
        <br>
        +        uint8_t *aregs;
        <br>
      </blockquote>
      <br>
      I would prefer keeping the same prefix :
      <br>
      <br>
              uint8_t *alt_regs;
      <br>
      <br>
      <br>
      Thanks,
      <br>
      <br>
      C.
      <br>
      <br>
      <br>
      <blockquote type="cite">+
        <br>
        +        /* POOL interrupt uses IPB in QW2, POOL ring */
        <br>
        +        if ((ring == TM_QW3_HV_PHYS) &amp;&amp; (nsr &amp;
        (TM_QW3_NSR_HE_POOL &lt;&lt; 6))) {
        <br>
        +            alt_ring = TM_QW2_HV_POOL;
        <br>
        +        } else {
        <br>
        +            alt_ring = ring;
        <br>
        +        }
        <br>
        +        aregs = &amp;tctx-&gt;regs[alt_ring];
        <br>
                    regs[TM_CPPR] = cppr;
        <br>
                    /* Reset the pending buffer bit */
        <br>
        -        regs[TM_IPB] &amp;= ~xive_priority_to_ipb(cppr);
        <br>
        -        regs[TM_PIPR] = ipb_to_pipr(regs[TM_IPB]);
        <br>
        +        aregs[TM_IPB] &amp;= ~xive_priority_to_ipb(cppr);
        <br>
        +        regs[TM_PIPR] = ipb_to_pipr(aregs[TM_IPB]);
        <br>
                    /* Drop Exception bit */
        <br>
                  regs[TM_NSR] &amp;= ~mask;
        <br>
          -        trace_xive_tctx_accept(tctx-&gt;cs-&gt;cpu_index,
        ring,
        <br>
        -                               regs[TM_IPB], regs[TM_PIPR],
        <br>
        +        trace_xive_tctx_accept(tctx-&gt;cs-&gt;cpu_index,
        alt_ring,
        <br>
        +                               aregs[TM_IPB], regs[TM_PIPR],
        <br>
                                         regs[TM_CPPR], regs[TM_NSR]);
        <br>
              }
        <br>
          @@ -94,13 +104,19 @@ static uint64_t xive_tctx_accept(XiveTCTX
        *tctx, uint8_t ring)
        <br>
            static void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring)
        <br>
          {
        <br>
        +    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers
        */
        <br>
        +    uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ?
        TM_QW3_HV_PHYS : ring;
        <br>
        +    uint8_t *aregs = &amp;tctx-&gt;regs[alt_ring];
        <br>
              uint8_t *regs = &amp;tctx-&gt;regs[ring];
        <br>
          -    if (regs[TM_PIPR] &lt; regs[TM_CPPR]) {
        <br>
        +    if (aregs[TM_PIPR] &lt; aregs[TM_CPPR]) {
        <br>
                  switch (ring) {
        <br>
                  case TM_QW1_OS:
        <br>
                      regs[TM_NSR] |= TM_QW1_NSR_EO;
        <br>
                      break;
        <br>
        +        case TM_QW2_HV_POOL:
        <br>
        +            aregs[TM_NSR] = (TM_QW3_NSR_HE_POOL &lt;&lt; 6);
        <br>
        +            break;
        <br>
                  case TM_QW3_HV_PHYS:
        <br>
                      regs[TM_NSR] |= (TM_QW3_NSR_HE_PHYS &lt;&lt; 6);
        <br>
                      break;
        <br>
        @@ -108,8 +124,8 @@ static void xive_tctx_notify(XiveTCTX *tctx,
        uint8_t ring)
        <br>
                      g_assert_not_reached();
        <br>
                  }
        <br>
                  trace_xive_tctx_notify(tctx-&gt;cs-&gt;cpu_index,
        ring,
        <br>
        -                               regs[TM_IPB], regs[TM_PIPR],
        <br>
        -                               regs[TM_CPPR], regs[TM_NSR]);
        <br>
        +                               regs[TM_IPB], aregs[TM_PIPR],
        <br>
        +                               aregs[TM_CPPR], aregs[TM_NSR]);
        <br>
                  qemu_irq_raise(xive_tctx_output(tctx, ring));
        <br>
              }
        <br>
          }
        <br>
        @@ -217,14 +233,14 @@ static uint64_t
        xive_tm_vt_poll(XivePresenter *xptr, XiveTCTX *tctx,
        <br>
          static const uint8_t xive_tm_hw_view[] = {
        <br>
              3, 0, 0, 0,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0, 0, /*
        QW-0 User */
        <br>
              3, 3, 3, 3,   3, 3, 0, 2,   3, 3, 3, 3,   0, 0, 0, 0, /*
        QW-1 OS   */
        <br>
        -    0, 0, 3, 3,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0, 0, /*
        QW-2 POOL */
        <br>
        +    0, 0, 3, 3,   0, 3, 3, 0,   3, 3, 3, 3,   0, 0, 0, 0, /*
        QW-2 POOL */
        <br>
              3, 3, 3, 3,   0, 3, 0, 2,   3, 0, 0, 3,   3, 3, 3, 0, /*
        QW-3 PHYS */
        <br>
          };
        <br>
            static const uint8_t xive_tm_hv_view[] = {
        <br>
              3, 0, 0, 0,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0, 0, /*
        QW-0 User */
        <br>
              3, 3, 3, 3,   3, 3, 0, 2,   3, 3, 3, 3,   0, 0, 0, 0, /*
        QW-1 OS   */
        <br>
        -    0, 0, 3, 3,   0, 0, 0, 0,   0, 3, 3, 3,   0, 0, 0, 0, /*
        QW-2 POOL */
        <br>
        +    0, 0, 3, 3,   0, 3, 3, 0,   0, 3, 3, 3,   0, 0, 0, 0, /*
        QW-2 POOL */
        <br>
              3, 3, 3, 3,   0, 3, 0, 2,   3, 0, 0, 3,   0, 0, 0, 0, /*
        QW-3 PHYS */
        <br>
          };
        <br>
          </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------UxQMWkvr4K0a9t4YwcfAFGIP--


