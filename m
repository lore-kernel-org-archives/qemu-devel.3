Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF71C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 15:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFDl3-0004JR-Cx; Wed, 14 May 2025 11:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFDBH-0007vQ-Kf; Wed, 14 May 2025 10:34:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFDBE-0006qE-SX; Wed, 14 May 2025 10:33:59 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E8pQJ5029665;
 Wed, 14 May 2025 14:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Zc1Ko0
 LIQFtEjp2U5ETEzQlXJ63vOJ2gB4ToaICElok=; b=K9qQrFthTCfYPtK32uiuS6
 MxXPW0oFM5fd9Zrq1aLGvowDMrcNB7V0x2XFNXlK0PBuKb6ErSnrWMJs56dX5HfO
 xLcBeNgKGsnS5Z3YgND2MBesxjkmDyD4xuKS1knq43uVguyyowDF4GpueTDLd4Ls
 hQ+seKyAslUtrvJ3MYPh3gumKvuaRLA0plFuEg1TAnXkVryL6TW2wXghzck0+QX8
 ktTQ3RvkYYjRiCJhJ7TTCK+o8fNWnwNTzA7mxEgA0l8wlkH/t9KIXGnkP4A4foHz
 WDAkvv7J6sSQnz7HwXC6pzmjUn9ZdGoYY9kCWKF6f1MECCHKjBaSMPsAXeLuKDWQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mr1ghp8j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:33:55 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EEJYJl012846;
 Wed, 14 May 2025 14:33:54 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mr1ghp8g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:33:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EDZJbp021396;
 Wed, 14 May 2025 14:33:53 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfrmns7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:33:53 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EEXqlF29164106
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 14:33:52 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 251485805E;
 Wed, 14 May 2025 14:33:52 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD6D458052;
 Wed, 14 May 2025 14:33:51 +0000 (GMT)
Received: from [9.10.255.115] (unknown [9.10.255.115])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 14:33:51 +0000 (GMT)
Message-ID: <3f56965d-32c4-4923-ba37-886d0cae2a50@linux.ibm.com>
Date: Wed, 14 May 2025 09:33:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/50] ppc/xive: tctx_notify should clear the precluded
 interrupt
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-14-npiggin@gmail.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <20250512031100.439842-14-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vu4UFV8ltlXBXjbJWjwiFqMHMLKpD-Av
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDEyNSBTYWx0ZWRfXx3jT8ZlXQrQy
 SA459a84sLOgPqCsNTnWqxkiQuuuUVRRNkgC7hJ0iqyGKApF2yJanfx2ZQdO8gQflNdeqgwWDjM
 LCK+g4PYjTsj34wOQbnSaWJ0qR0mOp19Bv4ESxZF3wLZ7B9PwhuqbvBzn4pR+nR1bTU7Xawzj5X
 1/q4nfkenXogQaCYXf4Wu3DDyrR3THwTi/ISvGt38yVa1sxW7yMYSpb5GtLkEwx9JFJrQSFykgq
 QB3W0x4a7HtG4Dzp/mkl5UdMYDIieGO+8/CwmKcc9D/pwyaLIrEDawsjNIx19RfB4ZvwSa8v/Mg
 bSdWDII9a8c+LPdV+EcSSfUDLUvX092wnwrES2V4tvHLVk1rga3GpUeo4X1DUjItNr17uycR20i
 iRCvNG78mMPrB+ANVWihgI342eTPfhaU5kQJOMQi1ApMnrWcUOCBC78rXEMgguubcgOi3a0R
X-Proofpoint-GUID: 79xOeskAg975Mquvu--J9sUhh3nWEUsu
X-Authority-Analysis: v=2.4 cv=QOxoRhLL c=1 sm=1 tr=0 ts=6824a9d3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=E6w-Va-w5m49zset5ocA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=797
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140125
Received-SPF: pass client-ip=148.163.156.1; envelope-from=calebs@linux.ibm.com;
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
X-Mailman-Approved-At: Wed, 14 May 2025 11:10:35 -0400
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
> If CPPR is lowered to preclude the pending interrupt, NSR should be
> cleared and the qemu_irq should be lowered. This avoids some cases
> of supurious interrupts.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index cebe409a1a..6293ea4361 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -110,6 +110,9 @@ void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring, uint8_t group_level)
>                                 regs[TM_IPB], alt_regs[TM_PIPR],
>                                 alt_regs[TM_CPPR], alt_regs[TM_NSR]);
>          qemu_irq_raise(xive_tctx_output(tctx, ring));
> +    } else {
> +        alt_regs[TM_NSR] = 0;
> +        qemu_irq_lower(xive_tctx_output(tctx, ring));
>      }
>  }
> 


