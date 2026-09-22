Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F903C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x94d8-0003Wh-JJ; Tue, 22 Sep 2026 13:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1x94d4-0003VH-2B; Tue, 22 Sep 2026 13:50:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1x94cz-0008Q4-AL; Tue, 22 Sep 2026 13:50:04 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MF5PAE752278; Tue, 22 Sep 2026 17:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=O2i47t
 IGflFF15uoCCgsqfVi5c/0IYphyi/XvpvpygE=; b=eoU1Mb2fnxkk16X94isjoz
 Cm6ur1gGHmC2fPJDCGQnv1OagNd0nkjM3tICd0PGfFcRfUmaTrIQmbXcihKRohxA
 JA8xH3ISFNbKGLwZuKT/wKEFwHhKimJnk+QIOKcu8N5cwaEeA0gLTk6A9P1XpuaG
 U7hVN0XEbNL76kxukezBCmk6209WHfUPfYlNXi0GgLgFzczZtMgnX705002jhMZR
 mzU8oQLxNN+3HRwc9zoHXXBfGsKvOoBOtVQGihdw+sVLxpHtIrpDP+RbmmgxnCMy
 0YcK5d1wZ7e/nriC2aGJeW7OfI0P7rIv2DB4rmrZIaIPcMVIRwl/ABt+qbrNZzwA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgs77su-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 17:49:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MElav72988047; Tue, 22 Sep 2026 17:49:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53vjxwq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 17:49:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MHnk7k51052952
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 17:49:46 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B09720043;
 Tue, 22 Sep 2026 17:49:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B9AD020040;
 Tue, 22 Sep 2026 17:49:44 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 22 Sep 2026 17:49:44 +0000 (GMT)
Date: Tue, 22 Sep 2026 23:27:31 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: "Kirill A. Korinsky" <kirill@korins.ky>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH 1/5] openpic: Preserve IRQs masked by CTPR
Message-ID: <20260922230838.b097bc21-4d-amachhiw@linux.ibm.com>
Mail-Followup-To: "Kirill A. Korinsky" <kirill@korins.ky>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Chinmay Rath <rathc@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20260903115229.95811-1-kirill@korins.ky>
 <20260903115229.95811-2-kirill@korins.ky>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260903115229.95811-2-kirill@korins.ky>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab2bfc0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=vXUYm7R_-FxaWxOqiHAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: d8iML5t2gBW6olugqV4ErstXQwtfFBaU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI1OCBTYWx0ZWRfX/snP25NIw1bw
 xCEXhIPB2xKkchFCP4UcXLAHwNUdZxXcEr6iFoKXzjhhmMnA+QxKRlgPOT3aRUQweAT7VOr5Owe
 u/BbwgZciXqvRWfP1u9yTkdKASjRT89/9xqYru4wKtqW2nvpv2V0s5GV55QsrkqzknzgEFd73Y0
 dchvw0gXWZ49OvBoSCKIMcm2JPClL9YyZfrr4Kp8E5WLD/s+b3fVBTfPNLUBigX3QvlnaT1sp0+
 +UynZN67iAS0L3xVLvY8ZmyvR8gMd8JXNe+3hObHhd5GeA9gmY0uWdOTGVtg9Tjg2zFOQzLGDfd
 UbhFoamnzG3uVtzoJpfDmRcBQ1FoDoKa3pD6cs8f+iUandK4u5YTrSRW2llLuqUKPUS3M9TLxYG
 9yWq7ia3A/kwCzNzi4RtpDzB0+8XcHIUtvQR5WN8To06sv+p7+w7+qvulDNYEDiybW1llkWTR+A
 QBgCQ0NDBhbr/sDgmsQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI1OCBTYWx0ZWRfX4KtzFm08JkAJ
 ft3vx0fxk438VQ49X/hzGxkBH1KXOEsMadMey53pf1OITiW/sDA538frZkTnUnLUl1bnjxiw6l+
 C2PS3w6AwcWfS6o5i0HCrmwPmTJXGaI=
X-Proofpoint-GUID: fdfmAakQ4ntxSZWl39jfaJdufqrIQSAn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1011 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220258
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/09/03 01:50 PM, Kirill A. Korinsky wrote:
> OpenBSD exposes this by raising CTPR while handling interrupts. If an
> edge remains pending when EOI lowers the servicing priority, QEMU
> reasserts INT without checking CTPR; IACK then returns the spurious
> vector and consumes the masked edge before CTPR permits delivery.
> 
> Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
> ---
>  hw/intc/openpic.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
> index 99d2a1e65e..6f9a562163 100644
> --- a/hw/intc/openpic.c
> +++ b/hw/intc/openpic.c
> @@ -1033,8 +1033,9 @@ static void openpic_cpu_write_internal(void *opaque, hwaddr addr,
>          n_IRQ = IRQ_get_next(opp, &dst->raised);
>          if (n_IRQ != -1) {
>              src = &opp->src[n_IRQ];
> -            if (s_IRQ == -1 ||
> -                IVPR_PRIORITY(src->ivpr) > dst->servicing.priority) {
> +            if (IVPR_PRIORITY(src->ivpr) > dst->ctpr &&
> +                (s_IRQ == -1 ||
> +                 IVPR_PRIORITY(src->ivpr) > dst->servicing.priority)) {

The original condition only gated the INT re-assertion on the servicing
priority, missing the CTPR dimension entirely.  The new guard mirrors exactly
what IRQ_local_pipe() already does at the assertion path (line 292), so the
three callsites are now consistent.

>                  DPRINTF("Raise OpenPIC INT output cpu %d irq %d",
>                          idx, n_IRQ);
>                  qemu_irq_raise(opp->dst[idx].irqs[OPENPIC_OUTPUT_INT]);
> @@ -1070,12 +1071,13 @@ static uint32_t openpic_iack(OpenPICState *opp, IRQDest *dst, int cpu)
>      }
>  
>      src = &opp->src[irq];
> -    if (!(src->ivpr & IVPR_ACTIVITY_MASK) ||
> -            !(IVPR_PRIORITY(src->ivpr) > dst->ctpr)) {
> +    if (!(src->ivpr & IVPR_ACTIVITY_MASK)) {
>          error_report("%s: bad raised IRQ %d ctpr %d ivpr 0x%08x",
>                  __func__, irq, dst->ctpr, src->ivpr);
>          openpic_update_irq(opp, irq);
>          retval = opp->spve;
> +    } else if (IVPR_PRIORITY(src->ivpr) <= dst->ctpr) {
> +        return opp->spve;

Splitting the old combined condition is the right approach.  The !IVPR_ACTIVITY
and prio <= ctpr cases are semantically distinct:

- A missing ACTIVITY bit on a raised IRQ is a genuine inconsistency and deserves
  the existing error_report + openpic_update_irq treatment.
- A CTPR-masked IRQ in raised.queue is expected by design — openpic_update_irq
  intentionally keeps IRQs there even when masked - the below comment at
  hw/intc/openpic.c:282 mentions about it.  Treating it as a bug and calling
  openpic_update_irq on it was incorrect.

    /*
     * Even if the interrupt doesn't have enough priority,
     * it is still raised, in case ctpr is lowered later.
     */

The return opp->spve (early return) for the CTPR-masked case is also important —
it skips the edge-sensitive cleanup block that follows:

  if (!src->level) {
      src->ivpr &= ~IVPR_ACTIVITY_MASK;
      src->pending = 0;
      IRQ_resetbit(&dst->raised, irq);
  }

Without the early return, a CTPR-masked edge IRQ would have its activity bit
cleared and be removed from raised.queue — silently losing it before CTPR
permits delivery.

Note: I'm not an OpenPIC expert, so take this as a code-walkthrough review, but
based on my understanding the logic looks correct to me.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

