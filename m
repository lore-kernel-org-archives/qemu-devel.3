Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C98D5E378
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 14:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVWAS-00008f-1B; Tue, 16 Dec 2025 09:36:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vVWAO-00007z-NR; Tue, 16 Dec 2025 09:36:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vVWAM-00059k-7t; Tue, 16 Dec 2025 09:36:44 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BG8esfO025635;
 Tue, 16 Dec 2025 14:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=3Oawvon6PszhHkCqo7+kJH6/MDdkQi
 HuHZKI/kj2kc8=; b=tsYtZfeeKmC/i46LfywuLAdQhBfkoJImsjf2pCfzihlcYF
 2z8qMxIhGwMbBoSeaLZDr88UU9JwK8ZpeM0+c6QlX3VmWsX6/tbn224ZXqj9Ju2s
 uM/NWmC2rOQlj5iirlw2NH9hGDn3MNapNOSadL8OBTwwZQKsoZ4ujxaqkan/U27H
 CEFiXdlqChqUTKNIcAXE+iyBErrsSllvuLk15eD5+fMcNLj8bX8eWDKQKZ883rZR
 nFt64bahlG+WghWuTPPet1jOJ2JQo3A3UeazTXoVyh+r6nhyX+hCTqIQ576dySkR
 1vcG4Nc/CjhqdsJ3lPfK3WTZBsPGUYJ488qitCRw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytv7j1y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 14:36:37 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BGETZ2B027439;
 Tue, 16 Dec 2025 14:36:36 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytv7j1v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 14:36:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGCZKi6026808;
 Tue, 16 Dec 2025 14:36:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1jfscu6p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 14:36:35 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BGEaVJA46203262
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Dec 2025 14:36:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D91FC20043;
 Tue, 16 Dec 2025 14:36:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 566652004D;
 Tue, 16 Dec 2025 14:36:27 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.209.67])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 16 Dec 2025 14:36:27 +0000 (GMT)
Date: Tue, 16 Dec 2025 20:06:25 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Caleb Schlossin <calebs@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 milesg@linux.ibm.com, alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, angeloj@linux.ibm.com
Subject: Re: [PATCH v2 7/7] hw/ppc: Add VMSTATE information to PnvPsi
Message-ID: <vmvjec6njy2f5sfriqtcstg5ypzldibobs7vstyvpc36vmfkrm@rr3fgx3ezlif>
References: <20251215171813.1670241-1-calebs@linux.ibm.com>
 <20251215171813.1670241-8-calebs@linux.ibm.com>
 <ak2xwufxarhtcbaj6nj5mjaimlfhk5p2csty4uxljs4sjrkqol@axobvglzomg7>
 <51ce8be6-a13b-4916-85ba-383187418601@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51ce8be6-a13b-4916-85ba-383187418601@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX5z8usZu/LgZI
 1TKIisZFg+jfDS8+7IPey0zsfLmg7zkyLsDoHtnwUKR1N5puW2gEpjUDmL/oErtXdLZGU6FFhfB
 j5uc8/wM8M37yCDzHjfjkGi1ex8Od4hJpYKkaqD9UK+k5+MALiFGwgzKKu9A6b1oRmNugoOGMr5
 EUNnXKJb4UYzc2ph0XnMBk8byMw0yWR68GuFdTg3QVuXcv9YolMOUqhcisCxNAar6fR2TN47/+D
 2/yh0+kESw5wsNJMk/JnikhnHAgOaTh3qTI+4asdKKhvpfADsnzd86VYo7urTV1FeBSYGfCxHZ+
 hsO/SVQ6hxWf3ucdG4nwrSvxru8E5SKh+HsJLZhz1oHJwMVtvQffClbtgCLKwmYVgMD4FKQBkZ4
 F5g5yuVquKdpCcbgiMfcj/ziAg1Y7w==
X-Proofpoint-ORIG-GUID: 2qux3USXvJuima0e4JkgujavOqjKOJ5S
X-Authority-Analysis: v=2.4 cv=QtRTHFyd c=1 sm=1 tr=0 ts=69416e75 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=OXLunwfInWpPE1gpIFAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 3rVhxs0l1AtdhvuVZcNTHxR8ibVst0_2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 25/12/16 07:35AM, Caleb Schlossin wrote:
> 
> 
> On 12/16/25 6:58 AM, Aditya Gupta wrote:
> > Hello Caleb,
> > 
> > On 25/12/15 11:18AM, Caleb Schlossin wrote:
> >> <...snip...>
> >>
> >> --- a/hw/ppc/pnv_psi.c
> >> +++ b/hw/ppc/pnv_psi.c
> >> @@ -25,6 +25,7 @@
> >>  #include "qemu/module.h"
> >>  #include "system/reset.h"
> >>  #include "qapi/error.h"
> >> +#include "migration/vmstate.h"
> >>  
> >>  
> >>  #include "hw/ppc/fdt.h"
> >> @@ -35,6 +36,8 @@
> >>  
> >>  #include <libfdt.h>
> >>  
> >> +#undef PSI_DEBUG
> >> +
> > 
> > Is this intended or got left over from debugging ?
> 
> This was indented to aid future debug, if needed.
> 

If so, i believe this should be removed.

With this we just unconditionally noped out the #ifdef PSI_DEBUG
portions in this file, even if the user explicitly compiles with PSI_DEBUG

What do you say ?

- Aditya G

> > 
> >>  #define PSIHB_XSCOM_FIR_RW      0x00
> >>  #define PSIHB_XSCOM_FIR_AND     0x01
> >>  #define PSIHB_XSCOM_FIR_OR      0x02
> >> @@ -130,12 +133,11 @@ static void pnv_psi_set_bar(PnvPsi *psi, uint64_t bar)
> >>  {
> >>      PnvPsiClass *ppc = PNV_PSI_GET_CLASS(psi);
> >>      MemoryRegion *sysmem = get_system_memory();
> >> -    uint64_t old = psi->regs[PSIHB_XSCOM_BAR];
> >>  
> >>      psi->regs[PSIHB_XSCOM_BAR] = bar & (ppc->bar_mask | PSIHB_BAR_EN);
> >>  
> >>      /* Update MR, always remove it first */
> >> -    if (old & PSIHB_BAR_EN) {
> >> +    if (memory_region_is_mapped(&psi->regs_mr)) {
> >>          memory_region_del_subregion(sysmem, &psi->regs_mr);
> >>      }
> >>  
> >> @@ -975,6 +977,40 @@ static void pnv_psi_register_types(void)
> >>  
> >>  type_init(pnv_psi_register_types);
> >>  
> >> +#ifdef PSI_DEBUG
> >> +static void psi_regs_pic_print_info(uint64_t *regs, uint32_t nr_regs,
> >> +                                    GString *buf) {
> >> +    uint i, prev_idx = -1;
> >> +    uint64_t  reg1, prev_reg1 = -1;
> >> +    uint64_t  reg2, prev_reg2 = -1;
> >> +    uint64_t  reg3, prev_reg3 = -1;
> >> +    uint64_t  reg4, prev_reg4 = -1;
> > 
> > Very minor nitpick, 2 spaces in the declaration between type and name.
> > checkpatch doesn't point it out, so it's okay with me.
> > 
> > Looks good to me overall. Please just see if the #undef was intentional,
> > if so:
> > 
> > Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
> > 
> > Thanks,
> > - Aditya G
> > 
> 

