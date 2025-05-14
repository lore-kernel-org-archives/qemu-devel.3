Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18E3C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 19:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFI4N-0008TO-NO; Wed, 14 May 2025 15:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFI3n-0007wn-00; Wed, 14 May 2025 15:46:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFI3j-0000ur-6w; Wed, 14 May 2025 15:46:34 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EGnIvE012692;
 Wed, 14 May 2025 19:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=LXdzTS
 rx/U11AB0lt5wH/r8LDTwFRY3aeUynqvDreO0=; b=CAW4PtOZpR+iNrjfK02k0U
 kCKyTCffiscJbYdbsYczLdVyCjlO20fq/KpF4XpG6/q1LjWE9ozPI4u2TL1M6j18
 i5VNiFXCKV9AEGeh9PE4LUY6dceJ11Xpr9hTnJ5pR78Wi3911h06WM8hLhRPSNTW
 CuwVwWO/xhRQdNF4ui2QIhuWLfLyE6I8hY+dmVq++nS4BlNcpg7nq6Iso6IBjNZk
 Wq2IwzGxluKiTILhHUrt+QF5z9r3xUPPpcYlm6nyhR4963YGr+jADyZMRHcSlw3i
 2w2fCRMZyIVXqE1tO3RYfsXZWqolhILfG+BN90Pw2RKWGEoU6f1+7GN/l4buWcYA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mrcjb8dt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:46:28 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EJkRiL014365;
 Wed, 14 May 2025 19:46:27 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mrcjb8dr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:46:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EGncSs021574;
 Wed, 14 May 2025 19:46:27 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfrp5vj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:46:27 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EJkQ0n19399392
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 19:46:26 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1855058054;
 Wed, 14 May 2025 19:46:26 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 887535804E;
 Wed, 14 May 2025 19:46:25 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 19:46:25 +0000 (GMT)
Message-ID: <99c13d39-9fc4-4121-97a8-a103d2013fc3@linux.ibm.com>
Date: Wed, 14 May 2025 14:46:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/50] ppc/xive: Add more interrupt notification tracing
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-24-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-24-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZYgdNtVA c=1 sm=1 tr=0 ts=6824f314 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=hmiCZ5762WqYC9sDUSgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: sOtxOkertloPzCc1He5i2p50icWH97tJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE4MCBTYWx0ZWRfX1dz0GHoL4Gl5
 9AZ4yHqHKH4GNmjjE22MukcIu1WnYCCGA7XTIQExtR0hNFY/WjntqB4EeUwIh6oTfnGQ3w+jiQ3
 aTUTCYvJnXEuDgYAG7ZnEW6gHrVAvr20KGnOSyP7w+Vu+hbeHRJ/M6rGfblUxUAT8EcddTUiB0z
 SMoOQdm9utU6oqpsKDQDPxO2tM2pTiWPGDl+4KP07Vt6wuUaf37LrGEH7dEGfsRFY/aqIXfC4JF
 Xtx/+Urws+kDI+/XY4BPoN/QY/6gluGekgv3eSAK7WlY9EvHqWQgX2bXYKp6XZjDtAfu0KlsGeQ
 BM7nwwq0Sl/F/qPmNBYuFhlekRtRyA1UazdbsTwjOZAIwPPGXIFgGwU/6cK6T7qn3BFNthAgCr6
 bWEtfb+6twc73EIW+RhYh8mwJaDsskhsH4O+VqUFU+gwJ6Ao2qlEnMr4Mur4LgOJZlCWWwXP
X-Proofpoint-GUID: -0SW7ISdMGpwdF4TH1QhZXvSDEH1IS-_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140180
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


On 5/11/2025 10:10 PM, Nicholas Piggin wrote:
> From: Glenn Miles <milesg@linux.ibm.com>
>
> Add more tracing around notification, redistribution, and escalation.

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks,  MAK

>
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>   hw/intc/trace-events |  6 ++++++
>   hw/intc/xive.c       |  3 +++
>   hw/intc/xive2.c      | 13 ++++++++-----
>   3 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/hw/intc/trace-events b/hw/intc/trace-events
> index f77f9733c9..9eca0925b6 100644
> --- a/hw/intc/trace-events
> +++ b/hw/intc/trace-events
> @@ -279,6 +279,8 @@ xive_tctx_notify(uint32_t index, uint8_t ring, uint8_t ipb, uint8_t pipr, uint8_
>   xive_tctx_set_cppr(uint32_t index, uint8_t ring, uint8_t ipb, uint8_t pipr, uint8_t cppr, uint8_t nsr) "target=%d ring=0x%x IPB=0x%02x PIPR=0x%02x new CPPR=0x%02x NSR=0x%02x"
>   xive_source_esb_read(uint64_t addr, uint32_t srcno, uint64_t value) "@0x%"PRIx64" IRQ 0x%x val=0x%"PRIx64
>   xive_source_esb_write(uint64_t addr, uint32_t srcno, uint64_t value) "@0x%"PRIx64" IRQ 0x%x val=0x%"PRIx64
> +xive_source_notify(uint32_t srcno) "Processing notification for queued IRQ 0x%x"
> +xive_source_blocked(uint32_t srcno) "No action needed for IRQ 0x%x currently"
>   xive_router_end_notify(uint8_t end_blk, uint32_t end_idx, uint32_t end_data) "END 0x%02x/0x%04x -> enqueue 0x%08x"
>   xive_router_end_escalate(uint8_t end_blk, uint32_t end_idx, uint8_t esc_blk, uint32_t esc_idx, uint32_t end_data) "END 0x%02x/0x%04x -> escalate END 0x%02x/0x%04x data 0x%08x"
>   xive_tctx_tm_write(uint32_t index, uint64_t offset, unsigned int size, uint64_t value) "target=%d @0x%"PRIx64" sz=%d val=0x%" PRIx64
> @@ -289,6 +291,10 @@ xive_end_source_read(uint8_t end_blk, uint32_t end_idx, uint64_t addr) "END 0x%x
>   # xive2.c
>   xive_nvp_backlog_op(uint8_t blk, uint32_t idx, uint8_t op, uint8_t priority, uint8_t rc) "NVP 0x%x/0x%x operation=%d priority=%d rc=%d"
>   xive_nvgc_backlog_op(bool c, uint8_t blk, uint32_t idx, uint8_t op, uint8_t priority, uint32_t rc) "NVGC crowd=%d 0x%x/0x%x operation=%d priority=%d rc=%d"
> +xive_redistribute(uint32_t index, uint8_t ring, uint8_t end_blk, uint32_t end_idx) "Redistribute from target=%d ring=0x%x NVP 0x%x/0x%x"
> +xive_end_enqueue(uint8_t end_blk, uint32_t end_idx, uint32_t end_data) "Queue event for END 0x%x/0x%x data=0x%x"
> +xive_escalate_end(uint8_t end_blk, uint32_t end_idx, uint8_t esc_blk, uint32_t esc_idx, uint32_t esc_data) "Escalate from END 0x%x/0x%x to END 0x%x/0x%x data=0x%x"
> +xive_escalate_esb(uint8_t end_blk, uint32_t end_idx, uint32_t lisn) "Escalate from END 0x%x/0x%x to LISN=0x%x"
>   
>   # pnv_xive.c
>   pnv_xive_ic_hw_trigger(uint64_t addr, uint64_t val) "@0x%"PRIx64" val=0x%"PRIx64
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 1a94642c62..7461dbecb8 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1276,6 +1276,7 @@ static uint64_t xive_source_esb_read(void *opaque, hwaddr addr, unsigned size)
>   
>           /* Forward the source event notification for routing */
>           if (ret) {
> +            trace_xive_source_notify(srcno);
>               xive_source_notify(xsrc, srcno);
>           }
>           break;
> @@ -1371,6 +1372,8 @@ out:
>       /* Forward the source event notification for routing */
>       if (notify) {
>           xive_source_notify(xsrc, srcno);
> +    } else {
> +        trace_xive_source_blocked(srcno);
>       }
>   }
>   
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 34fc561c9c..968b698677 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -616,6 +616,7 @@ static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx,
>       uint8_t prio_limit;
>       uint32_t cfg;
>   
> +    trace_xive_redistribute(tctx->cs->cpu_index, ring, nvp_blk, nvp_idx);
>       /* convert crowd/group to blk/idx */
>       if (group > 0) {
>           nvgc_idx = (nvp_idx & (0xffffffff << group)) |
> @@ -1455,6 +1456,7 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
>       }
>   
>       if (!redistribute && xive2_end_is_enqueue(&end)) {
> +        trace_xive_end_enqueue(end_blk, end_idx, end_data);
>           xive2_end_enqueue(&end, end_data);
>           /* Enqueuing event data modifies the EQ toggle and index */
>           xive2_router_write_end(xrtr, end_blk, end_idx, &end, 1);
> @@ -1631,11 +1633,11 @@ do_escalation:
>            * Perform END Adaptive escalation processing
>            * The END trigger becomes an Escalation trigger
>            */
> -        xive2_router_end_notify(xrtr,
> -                               xive_get_field32(END2_W4_END_BLOCK,     end.w4),
> -                               xive_get_field32(END2_W4_ESC_END_INDEX, end.w4),
> -                               xive_get_field32(END2_W5_ESC_END_DATA,  end.w5),
> -                               false);
> +        uint8_t esc_blk = xive_get_field32(END2_W4_END_BLOCK, end.w4);
> +        uint32_t esc_idx = xive_get_field32(END2_W4_ESC_END_INDEX, end.w4);
> +        uint32_t esc_data = xive_get_field32(END2_W5_ESC_END_DATA, end.w5);
> +        trace_xive_escalate_end(end_blk, end_idx, esc_blk, esc_idx, esc_data);
> +        xive2_router_end_notify(xrtr, esc_blk, esc_idx, esc_data, false);
>       } /* end END adaptive escalation */
>   
>       else {
> @@ -1652,6 +1654,7 @@ do_escalation:
>           lisn = XIVE_EAS(xive_get_field32(END2_W4_END_BLOCK,     end.w4),
>                           xive_get_field32(END2_W4_ESC_END_INDEX, end.w4));
>   
> +        trace_xive_escalate_esb(end_blk, end_idx, lisn);
>           xive2_notify(xrtr, lisn, true /* pq_checked */);
>       }
>   

