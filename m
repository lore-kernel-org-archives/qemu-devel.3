Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F06C3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 19:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFHLy-0004hm-5f; Wed, 14 May 2025 15:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFHLD-00043C-35; Wed, 14 May 2025 15:00:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFHLB-0007Dw-4F; Wed, 14 May 2025 15:00:30 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EGwWcF012727;
 Wed, 14 May 2025 19:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=tM4+py
 7p1nNocXm0YVyxwdgLw4raQWegx7SKpJVoKWs=; b=hsfGnW4avAlHjSYmIzy7FR
 C6RESWHY7BRdraS+kyWO5EMRb5Mt/SvZd4LkA68nRbd4HEQ5JCOkxD9wujTpe1Ym
 lAPkmJh/jzxl0vnLbIa8+WvI+8lvQHWgJNvxlykT8OWB2AM7dtxNFvSusFM1dIL9
 PZzHsjzqs3hOytQOqAW8m0KteDG6g6C/tH7n48uS2HnLwNE/Oi6or9oxAYeQz5k4
 KgOO/k3lyVVCiZ8tM4huxdztv1zUCwlb1uC5xGXBqQyGZGKkMeCwLLrD+Jx5BYs+
 FEqr08JdmRgQxEB6EcbzfrW9WRt+MwKp37qtbXAuYsd0JiVBW4aOyIzDn74oELfA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mrcjb0x2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:00:26 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EIw0bh003457;
 Wed, 14 May 2025 19:00:25 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mrcjb0wy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:00:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EGPOlH026656;
 Wed, 14 May 2025 19:00:25 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpdxhj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:00:25 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EJ0Nl417105528
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 19:00:24 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB52358055;
 Wed, 14 May 2025 19:00:23 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E52C5804E;
 Wed, 14 May 2025 19:00:23 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 19:00:23 +0000 (GMT)
Message-ID: <814e39f3-c3a7-4b15-b929-a76bcf3adec5@linux.ibm.com>
Date: Wed, 14 May 2025 14:00:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/50] pnv/xive2: Support ESB Escalation
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-18-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-18-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZYgdNtVA c=1 sm=1 tr=0 ts=6824e84a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=2e-aJQAviZZ-V43xsP8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: YGTC30LSn685wqfScgxe1DJ23eO3RBFR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE2OSBTYWx0ZWRfX2c6LREnEYIaJ
 ApWGssqoX1Jnx/X/ZSqU6KuTZZ0aib+AFl7/aAPcjTqnl96nzNmrRbAWQ6mPHg7BzRv23iTB79h
 Mz1E/83kSSx5XBe0Th9iwQi+XwGpEY35riifNn8Ja+KA8cOAB/Rtm75qe3k3j59mz0HStT8cthy
 kYN9rL4ZNtB99uDvedExwxLTCOE+V/fCIxA9Set7uC3yj8VBkOyPM0cmWGEb8uLgPdSO3bv/DL7
 U/iCB3wRGe3UwqjZFxu1F0sKknIjPkUat2w9QlGqjfQCTbhIpnolSJBaL6jJaEz2bSeAy3E60DY
 +6nIW0Um+dw4Z5FIeDdyZ+AUox+2gJDZs2kPahQIDgZM3dmq8ygQ9C5K0Wo+9cj5MEARwPQ6llA
 fcy2R8+k3wgo9QR2UF33aj8RvnwpVNzBZewXKUJ6oCvtIgWAkSxSI4SBR1SPfdp8OGwGNvki
X-Proofpoint-GUID: S-Lq4mFQYpJ2BkAm44YOZiMlieXYapi2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140169
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
> From: Glenn Miles <milesg@linux.vnet.ibm.com>
>
> Add support for XIVE ESB Interrupt Escalation.

Reviewed-by: Michael Kowal <kowal@linux.ibm.com>

Thanks MAK


>
> Suggested-by: Michael Kowal <kowal@linux.ibm.com>
> [This change was taken from a patch provided by Michael Kowal.]
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> ---
>   hw/intc/xive2.c             | 62 ++++++++++++++++++++++++++++++-------
>   include/hw/ppc/xive2.h      |  1 +
>   include/hw/ppc/xive2_regs.h | 13 +++++---
>   3 files changed, 59 insertions(+), 17 deletions(-)
>
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index de139dcfbf..0993e792cc 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -1552,18 +1552,39 @@ do_escalation:
>           }
>       }
>   
> -    /*
> -     * The END trigger becomes an Escalation trigger
> -     */
> -    xive2_router_end_notify(xrtr,
> -                           xive_get_field32(END2_W4_END_BLOCK,     end.w4),
> -                           xive_get_field32(END2_W4_ESC_END_INDEX, end.w4),
> -                           xive_get_field32(END2_W5_ESC_END_DATA,  end.w5));
> +    if (xive2_end_is_escalate_end(&end)) {
> +        /*
> +         * Perform END Adaptive escalation processing
> +         * The END trigger becomes an Escalation trigger
> +         */
> +        xive2_router_end_notify(xrtr,
> +                               xive_get_field32(END2_W4_END_BLOCK,     end.w4),
> +                               xive_get_field32(END2_W4_ESC_END_INDEX, end.w4),
> +                               xive_get_field32(END2_W5_ESC_END_DATA,  end.w5));
> +    } /* end END adaptive escalation */
> +
> +    else {
> +        uint32_t lisn;              /* Logical Interrupt Source Number */
> +
> +        /*
> +         *  Perform ESB escalation processing
> +         *      E[N] == 1 --> N
> +         *      Req[Block] <- E[ESB_Block]
> +         *      Req[Index] <- E[ESB_Index]
> +         *      Req[Offset] <- 0x000
> +         *      Execute <ESB Store> Req command
> +         */
> +        lisn = XIVE_EAS(xive_get_field32(END2_W4_END_BLOCK,     end.w4),
> +                        xive_get_field32(END2_W4_ESC_END_INDEX, end.w4));
> +
> +        xive2_notify(xrtr, lisn, true /* pq_checked */);
> +    }
> +
> +    return;
>   }
>   
> -void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked)
> +void xive2_notify(Xive2Router *xrtr , uint32_t lisn, bool pq_checked)
>   {
> -    Xive2Router *xrtr = XIVE2_ROUTER(xn);
>       uint8_t eas_blk = XIVE_EAS_BLOCK(lisn);
>       uint32_t eas_idx = XIVE_EAS_INDEX(lisn);
>       Xive2Eas eas;
> @@ -1606,13 +1627,30 @@ void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked)
>           return;
>       }
>   
> +    /* TODO: add support for EAS resume */
> +    if (xive2_eas_is_resume(&eas)) {
> +        qemu_log_mask(LOG_UNIMP,
> +                      "XIVE: EAS resume processing unimplemented - LISN %x\n",
> +                      lisn);
> +        return;
> +    }
> +
>       /*
>        * The event trigger becomes an END trigger
>        */
>       xive2_router_end_notify(xrtr,
> -                             xive_get_field64(EAS2_END_BLOCK, eas.w),
> -                             xive_get_field64(EAS2_END_INDEX, eas.w),
> -                             xive_get_field64(EAS2_END_DATA,  eas.w));
> +                            xive_get_field64(EAS2_END_BLOCK, eas.w),
> +                            xive_get_field64(EAS2_END_INDEX, eas.w),
> +                            xive_get_field64(EAS2_END_DATA,  eas.w));
> +    return;
> +}
> +
> +void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked)
> +{
> +    Xive2Router *xrtr = XIVE2_ROUTER(xn);
> +
> +    xive2_notify(xrtr, lisn, pq_checked);
> +    return;
>   }
>   
>   static const Property xive2_router_properties[] = {
> diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
> index 8cdf819174..2436ddb5e5 100644
> --- a/include/hw/ppc/xive2.h
> +++ b/include/hw/ppc/xive2.h
> @@ -80,6 +80,7 @@ int xive2_router_write_nvgc(Xive2Router *xrtr, bool crowd,
>   uint32_t xive2_router_get_config(Xive2Router *xrtr);
>   
>   void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked);
> +void xive2_notify(Xive2Router *xrtr, uint32_t lisn, bool pq_checked);
>   
>   /*
>    * XIVE2 Presenter (POWER10)
> diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
> index 3c28de8a30..2c535ec0d0 100644
> --- a/include/hw/ppc/xive2_regs.h
> +++ b/include/hw/ppc/xive2_regs.h
> @@ -39,15 +39,18 @@
>   
>   typedef struct Xive2Eas {
>           uint64_t       w;
> -#define EAS2_VALID                 PPC_BIT(0)
> -#define EAS2_END_BLOCK             PPC_BITMASK(4, 7) /* Destination EQ block# */
> -#define EAS2_END_INDEX             PPC_BITMASK(8, 31) /* Destination EQ index */
> -#define EAS2_MASKED                PPC_BIT(32) /* Masked                 */
> -#define EAS2_END_DATA              PPC_BITMASK(33, 63) /* written to the EQ */
> +#define EAS2_VALID         PPC_BIT(0)
> +#define EAS2_QOS           PPC_BIT(1, 2)       /* Quality of Service(unimp) */
> +#define EAS2_RESUME        PPC_BIT(3)          /* END Resume(unimp) */
> +#define EAS2_END_BLOCK     PPC_BITMASK(4, 7)   /* Destination EQ block# */
> +#define EAS2_END_INDEX     PPC_BITMASK(8, 31)  /* Destination EQ index */
> +#define EAS2_MASKED        PPC_BIT(32)         /* Masked */
> +#define EAS2_END_DATA      PPC_BITMASK(33, 63) /* written to the EQ */
>   } Xive2Eas;
>   
>   #define xive2_eas_is_valid(eas)   (be64_to_cpu((eas)->w) & EAS2_VALID)
>   #define xive2_eas_is_masked(eas)  (be64_to_cpu((eas)->w) & EAS2_MASKED)
> +#define xive2_eas_is_resume(eas)  (be64_to_cpu((eas)->w) & EAS2_RESUME)
>   
>   void xive2_eas_pic_print_info(Xive2Eas *eas, uint32_t lisn, GString *buf);
>   

