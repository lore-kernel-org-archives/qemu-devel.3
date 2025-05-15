Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062CFC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFaKJ-0000uJ-5z; Thu, 15 May 2025 11:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFaKC-0000q2-VH; Thu, 15 May 2025 11:16:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFaKA-0001mx-RH; Thu, 15 May 2025 11:16:44 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCftsG016085;
 Thu, 15 May 2025 15:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=II5EhX
 B0znHW7h72l4NNDTv/5/Z0VFygGdP6S7g60cQ=; b=Jc0G+8esyw2ZDN/xFcCAvE
 gaVbcbQzf1MzMOqRa3xe04QZJ80pruFCYy3vyNxLB+tjwwnB9QoFCyp7X2r7y05m
 3EBRRMD28HWfXSaRoXd85c9ZU+FVlc8nxnTPmqJp2k3RhISazN/TyyqWK8tNse1i
 xM7oYGskKVcUNJU1wFs8P/dxClKQEOjotQBJP5N739Yc4gAAgWP/VS6L81tP+Qld
 S1/uFDRCXKa2sLlQEEhj8RQP+o8n+vR1iLYRXCGtt2TWaXUnGHkm5ftKhC5RV8UI
 yCt3iKHtMVRdEG7RakL+kqOVvX4d/GS1yMpLRhdULM2k6IEILlIOgcsC6BnqTMhg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nd4gt0rd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:16:38 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FF71TR005852;
 Thu, 15 May 2025 15:16:38 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nd4gt0r6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:16:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FDr5jA024273;
 Thu, 15 May 2025 15:16:37 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfsavn9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:16:37 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFGZOv28050086
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:16:36 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CDF9F58061;
 Thu, 15 May 2025 15:16:35 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8369758057;
 Thu, 15 May 2025 15:16:35 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:16:35 +0000 (GMT)
Message-ID: <e361e136-ec17-4b0e-a036-23aa3242d9d5@linux.ibm.com>
Date: Thu, 15 May 2025 10:16:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/50] ppc/xive: tctx_accept only lower irq line if an
 interrupt was presented
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-35-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-35-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bRaTvQNmS8Fqm6JiK08UJ10Fv5oCNlc_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1MCBTYWx0ZWRfX8VMWCC8aUqlp
 +H4QqZGrgm7ERzT9Jm2GbRubZegOWmFH1jPuSdPLImvaIjTjP2dMHS9iA6P9L3LMcvmIINrJ0q3
 qc+DuNfbdsi2obLxoESMBUzcbN9z+kK8SpgVDtBzV0kqDhxfDFDeBGgjO00tmpmVWJRsL5YQXjG
 pl4s6964TD+vY/F00ubzWQZjIgE/7PbWfaSfvjDiQAWkK5aA/zd3wCfzA4xywixM8ADfE7iC58D
 s8PsJUMuFYoQGmFeNUawuBE8rEX7u74jtxb2gjn01VQfab9SL6aturjU+PGYMNOUrPZxG3B5lPm
 gbNhDvDgZ+jVuQXGKP6q24dy0IwTsfhBY/AHbXNSK3bMZqWKtAP7osXl+e0YeJBnFA5vf7kuVh5
 tX/bJrL1dU2EIw0/2p2ZSaCLAbKIdvDm5gpurB1eqsTgdCQ+BV+8UHWcFlKyxXg/Nr7dG0Qx
X-Proofpoint-ORIG-GUID: GjY3yGJ6Nr5dazd-TpjQ-XHqiZaqh-zB
X-Authority-Analysis: v=2.4 cv=OsNPyz/t c=1 sm=1 tr=0 ts=68260556 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=pGLkceISAAAA:8 a=vhC_EM8RM9Nu0soLip8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=993 mlxscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150150
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
> The relationship between an interrupt signaled in the TIMA and the QEMU
> irq line to the processor to be 1:1, so they should be raised and

...needs to be...


> lowered together and "just in case" lowering should be avoided (it could
> mask

I think you missed the rest of the line...

MAK


>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/intc/xive.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 4e0c71d684..d5dbeab6bd 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -95,8 +95,6 @@ uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t sig_ring)
>       g_assert(tctx->regs[TM_QW2_HV_POOL + TM_PIPR] == 0);
>       g_assert(tctx->regs[TM_QW2_HV_POOL + TM_CPPR] == 0);
>   
> -    qemu_irq_lower(xive_tctx_output(tctx, sig_ring));
> -
>       if (xive_nsr_indicates_exception(sig_ring, nsr)) {
>           uint8_t cppr = sig_regs[TM_PIPR];
>           uint8_t ring;
> @@ -117,6 +115,7 @@ uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t sig_ring)
>   
>           /* Clear the exception from NSR */
>           sig_regs[TM_NSR] = 0;
> +        qemu_irq_lower(xive_tctx_output(tctx, sig_ring));
>   
>           trace_xive_tctx_accept(tctx->cs->cpu_index, ring,
>                                  regs[TM_IPB], sig_regs[TM_PIPR],

