Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5838C3DA6D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 16:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFbAQ-0000pu-D9; Thu, 15 May 2025 12:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFbAK-0000nS-2g; Thu, 15 May 2025 12:10:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFbAH-0001A2-2p; Thu, 15 May 2025 12:10:35 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FDnA9D032351;
 Thu, 15 May 2025 16:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=W9SlWlZN6ntE0iCOnb5dzGaDSwMvrPTY8KRycaWGVnM=; b=JEW6MgQ5IX6C
 OgOz0jFUzeG895k++WMAdj08tUPFw8wPGbelWDokGB8mvBk8uXUwNlwYXHkXLLXy
 vppXQ4wRg5Bw81KUKnPsANPUnehUuc6OSfpbAddvd3pXd63YxC8cMPTVja4QnW0K
 38XyZjGFGsbtGjm8M4WrvDoFiO/nQdc9gT7zWLM1uOBy2wh5Jo8vVemymeM3T7z3
 xPpEbyTZNNIxlyUpcGotvvnfIwpXzU12dGZR2gwKQW39Zlt7Kra87i3nEftzDFM7
 dpbwqe5EBuHRgF9Lojy9v4fEQOHdQP1AzkMr4HFPI+7bashVbEdg9pO8IeCIgmfZ
 QWMMECb64A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nhg30spq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:10:31 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FG6gTq031775;
 Thu, 15 May 2025 16:10:30 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nhg30spp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:10:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEL95V021574;
 Thu, 15 May 2025 16:10:30 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfru4ke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:10:30 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FGAS3x24445668
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 16:10:28 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 639345805A;
 Thu, 15 May 2025 16:10:28 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 154665803F;
 Thu, 15 May 2025 16:10:28 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 16:10:28 +0000 (GMT)
Message-ID: <50e2ea494c3a152f3975c0b7b0aac41b6f75a0b8.camel@linux.ibm.com>
Subject: Re: [PATCH 41/50] ppc/xive2: Prevent pulling of pool context losing
 phys interrupt
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 11:10:27 -0500
In-Reply-To: <20250512031100.439842-42-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-42-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cf0I5Krl c=1 sm=1 tr=0 ts=682611f7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=N5jOW-pyvUPM4XXbhVEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE2MCBTYWx0ZWRfX2l2JS5zeg2PO
 RZGRV5yBbD0j2S+//+qISrqBV1Ya8nHArzP2+OgYsp7VanrkkTzVLHMUnIYtKI/OPLNSZ9ZPYFR
 VS2ka3IN49uUvdk+JuR5PGwFMJYPVtqq6IB6G9jEPtnxwqyEyc04jdEIb6bM89nicDz609r7u90
 iYezdOyb27UchQvt5DglEDBD3T1aZpfCXr7IodXE/fPDkBD4Y8li5tfsSyI3KbhuYUpKKq9aA1k
 tbM+oDbF+C8cyiCuKVRuFX9j0f7cvn11/OjYGWQuglRoVtm3/fEa19mx2DGEvS8kLEfan6QIfOZ
 UTdPhXQhRic8L8VPDQEkuG0x/sqpMvlhOIfBm0IVjT37V8wPpHkxbbzrsfofydqzok7qj7ZEPl6
 K2XwOKHbsyvR9MyETS+ziSTonnu6iRcX4JxPDYrSpeT93Q6i8w4oMKdfdbBeTO59PWXhGRhO
X-Proofpoint-GUID: vlchBaZmzRzK78elzkaWAwe0jIGwrC--
X-Proofpoint-ORIG-GUID: 7XO8vyeFhw4-F3mDpvLSpeyeW-CXtY0n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=812
 impostorscore=0 phishscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150160
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

On Mon, 2025-05-12 at 13:10 +1000, Nicholas Piggin wrote:
> When the pool context is pulled, the shared pool/phys signal is
> reset, which loses the qemu irq if a phys interrupt was presented.
> 
> Only reset the signal if a poll irq was presented.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive2.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index d899c1fb14..aeeb901b6a 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -727,20 +727,22 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>                  xive2_redistribute(xrtr, tctx, cur_ring);
>              }
>          }
> +
> +        /*
> +         * Lower external interrupt line of requested ring and below except for
> +         * USER, which doesn't exist.
> +         */
> +        if (xive_nsr_indicates_exception(cur_ring, nsr)) {
> +            if (cur_ring == xive_nsr_exception_ring(cur_ring, nsr)) {
> +                xive_tctx_reset_signal(tctx, cur_ring);
> +            }
> +        }
>      }
>  
>      if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_save) {
>          xive2_tctx_save_ctx(xrtr, tctx, ring, nvp_blk, nvp_idx);
>      }
>  
> -    /*
> -     * Lower external interrupt line of requested ring and below except for
> -     * USER, which doesn't exist.
> -     */
> -    for (cur_ring = TM_QW1_OS; cur_ring <= ring;
> -         cur_ring += XIVE_TM_RING_SIZE) {
> -        xive_tctx_reset_signal(tctx, cur_ring);
> -    }
>      return target_ringw2;
>  }
>  


