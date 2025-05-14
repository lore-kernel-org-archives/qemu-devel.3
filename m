Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71634C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 18:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFH3o-0003lc-VL; Wed, 14 May 2025 14:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFH3O-0003XT-Ea; Wed, 14 May 2025 14:42:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFH3L-0003rt-K8; Wed, 14 May 2025 14:42:05 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EG0fNp016967;
 Wed, 14 May 2025 18:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qQLB3K
 S+5TDpEDu/+yiwMuJl+zh54JOQS2HOnaqrKDI=; b=Vg1jBQw2AahCpKLyG6VVYL
 EhtlimO5UCkwQ9mfOztdsb5BcsrgRzQ/2LZQLUw1HPmIGAB8covbgA+jCFRhLmkf
 jLSK8Yu1KtoPSOStR+fYrc7QBiFn6ZE/qLBPLR8vWDwVYmKyUiZ2bLyXcJPXOTPK
 9bB2qua+/w0LWSZQcr11BqwCjaMWDJ85NoTGntHieo/1zYUAu64MnFnhSYMdcOfR
 dnVRDHaVNRc5iDJfD16AG8hXUfJCUPY750L3EvFfwqRsKDzBnnex1emZiddGkn7A
 VjEvDVBw7f2dnxouOaX07V6OTfm6wytjM9nHV6Y69hTzmqKYEW8KVFwfCSPxNXfw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mbq8p9rb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:41:58 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EIZADQ032205;
 Wed, 14 May 2025 18:41:57 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mbq8p9r9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:41:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EGV29c024309;
 Wed, 14 May 2025 18:41:56 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfs5uwv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:41:56 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EIft6W24445646
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 18:41:55 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 09B4D58054;
 Wed, 14 May 2025 18:41:55 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 838DC5803F;
 Wed, 14 May 2025 18:41:54 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 18:41:54 +0000 (GMT)
Message-ID: <ef6c4b43-b2e0-445e-86cf-63f4d258f555@linux.ibm.com>
Date: Wed, 14 May 2025 13:41:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/50] ppc/xive: Fix xive trace event output
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-2-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2sOkAMXboQG97-qkAB5j6RrPODoMg3rh
X-Authority-Analysis: v=2.4 cv=GrRC+l1C c=1 sm=1 tr=0 ts=6824e3f6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=AibCl0OSh4XQIFcVlNQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE2OSBTYWx0ZWRfX17p9LPQYH5oS
 j4ipjqn8RxhfjtRo4qkonf34tP5lgpHOmS7SPMlXOp8EI2qFbvON/50lo4h+fzzD41XRP1GI40B
 LV7zXLyMILMXRnkYNC0eEA+B+kW8Zxjeo3Iiqxh/8m6nqurms3lqVCJAk1ZPomyu2Rug4aYWF29
 apyzGgOjdse015OOwiHGRDmDecZ/MBiLJ6RI+EIK1yVAuc8WPLaDX1Dex52UrmjLkXTW8SsoBiO
 duBMhbbcgLbc0OLsqCAovf6HLjWv4sjOtyUVzlcD4uYL9f/HM5/4TdbEk+xcrH/ShBByhRg9nDE
 PHJUttr0Y/OPtXBxxBRYTEwMVT79Dv1hBDpn1bXYEafnKisIL5ASLYOwVwjrxYkcqVtmxgU71Kb
 wUEei2KL40SIZCmwcjKBntj75c1TOZy0oAUQz/aOm79PsDaqFKBq0Q02Jx3Nb964IKJxLSFi
X-Proofpoint-GUID: TYDEKL3xZ4q2aawISGI9EF5t9-nrag7R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 clxscore=1011
 mlxlogscore=999 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140169
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
> Typo, IBP should be IPB.


Reviewed-by: Michael Kowal <kowal@linux.ibm.com>

Thanks MAK


> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/intc/trace-events | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/intc/trace-events b/hw/intc/trace-events
> index 0ba9a02e73..f77f9733c9 100644
> --- a/hw/intc/trace-events
> +++ b/hw/intc/trace-events
> @@ -274,9 +274,9 @@ kvm_xive_cpu_connect(uint32_t id) "connect CPU%d to KVM device"
>   kvm_xive_source_reset(uint32_t srcno) "IRQ 0x%x"
>   
>   # xive.c
> -xive_tctx_accept(uint32_t index, uint8_t ring, uint8_t ipb, uint8_t pipr, uint8_t cppr, uint8_t nsr) "target=%d ring=0x%x IBP=0x%02x PIPR=0x%02x CPPR=0x%02x NSR=0x%02x ACK"
> -xive_tctx_notify(uint32_t index, uint8_t ring, uint8_t ipb, uint8_t pipr, uint8_t cppr, uint8_t nsr) "target=%d ring=0x%x IBP=0x%02x PIPR=0x%02x CPPR=0x%02x NSR=0x%02x raise !"
> -xive_tctx_set_cppr(uint32_t index, uint8_t ring, uint8_t ipb, uint8_t pipr, uint8_t cppr, uint8_t nsr) "target=%d ring=0x%x IBP=0x%02x PIPR=0x%02x new CPPR=0x%02x NSR=0x%02x"
> +xive_tctx_accept(uint32_t index, uint8_t ring, uint8_t ipb, uint8_t pipr, uint8_t cppr, uint8_t nsr) "target=%d ring=0x%x IPB=0x%02x PIPR=0x%02x CPPR=0x%02x NSR=0x%02x ACK"
> +xive_tctx_notify(uint32_t index, uint8_t ring, uint8_t ipb, uint8_t pipr, uint8_t cppr, uint8_t nsr) "target=%d ring=0x%x IPB=0x%02x PIPR=0x%02x CPPR=0x%02x NSR=0x%02x raise !"
> +xive_tctx_set_cppr(uint32_t index, uint8_t ring, uint8_t ipb, uint8_t pipr, uint8_t cppr, uint8_t nsr) "target=%d ring=0x%x IPB=0x%02x PIPR=0x%02x new CPPR=0x%02x NSR=0x%02x"
>   xive_source_esb_read(uint64_t addr, uint32_t srcno, uint64_t value) "@0x%"PRIx64" IRQ 0x%x val=0x%"PRIx64
>   xive_source_esb_write(uint64_t addr, uint32_t srcno, uint64_t value) "@0x%"PRIx64" IRQ 0x%x val=0x%"PRIx64
>   xive_router_end_notify(uint8_t end_blk, uint32_t end_idx, uint32_t end_data) "END 0x%02x/0x%04x -> enqueue 0x%08x"

