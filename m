Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD7ED5E146
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 12:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVUdP-0008IX-99; Tue, 16 Dec 2025 07:58:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vVUdF-0008I8-Ow; Tue, 16 Dec 2025 07:58:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vVUdE-0003YW-7a; Tue, 16 Dec 2025 07:58:25 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGCdEoM003716;
 Tue, 16 Dec 2025 12:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=xXFqsdGdQGo1Fbe3oG6B4mfSdzX8ns
 69uf8aYmAXg/Y=; b=dBMlHguh3drUV60EmiCbATBCS5fydRu70DlvVAMrJEhAlh
 EVoFwtYxwsQ0UOy5z+LvetM3CTHoAF1wWhI35sv6ZNtjEF9ONpiZ4wDEVG7Eq746
 DVcqc2tXoxg9ck2K6/5RNl+SZEumX2xX/Y8vo51Ka3ajfZGjwrKTMTslInAH4IKI
 U28POSkqGCgpyGCL7oziAwZO0N10Q1cPJRczsGZsSszscOlyzPdMCCm00XsLKga/
 n4cXfHoGRt1pQZPRfNocwzeXFZ2TTWCPmDdSfoK5+d/V74xmFEM0ByK7zwEPUmPT
 o7u6z4eXVKrmVA3uauiTjSoD16ECmJrrklaeBsSA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yvb73uk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 12:58:18 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BGCuVZG032242;
 Tue, 16 Dec 2025 12:58:18 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yvb73uf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 12:58:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGCK6nm005744;
 Tue, 16 Dec 2025 12:58:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1tgntrra-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 12:58:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BGCwDcH29295298
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Dec 2025 12:58:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 72F1420043;
 Tue, 16 Dec 2025 12:58:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E4EF2004B;
 Tue, 16 Dec 2025 12:58:10 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.209.67])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 16 Dec 2025 12:58:09 +0000 (GMT)
Date: Tue, 16 Dec 2025 18:28:07 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Caleb Schlossin <calebs@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 milesg@linux.ibm.com, alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, angeloj@linux.ibm.com
Subject: Re: [PATCH v2 7/7] hw/ppc: Add VMSTATE information to PnvPsi
Message-ID: <ak2xwufxarhtcbaj6nj5mjaimlfhk5p2csty4uxljs4sjrkqol@axobvglzomg7>
References: <20251215171813.1670241-1-calebs@linux.ibm.com>
 <20251215171813.1670241-8-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215171813.1670241-8-calebs@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/JwEOni c=1 sm=1 tr=0 ts=6941576a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=LFsXsVw527B4u8Y2H3YA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: _W3WDgaTpV4YV32imyZlh8LQvSl814RU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX2Qhr86Kmd8Z0
 Q76Uj/8jjQuPRt6rr+JW4jYMXz+J3JovC2vZykQ49Mj/jJKHIbvm4tQK47eowHOcPuQ1b8wuarf
 EhgmkaxacPaxKm9yaQ80SVheQlVlDduO7qSMlgT4E1Ops/0PSIj2o7I7Wz5fVvihABWPDd0bk9I
 9Roi4SYXkTMwFQ+FSfb4/YYt0TfKIC94B7GG1vWimZAHv+/8gujOQfdJKDbdDWTuXMptjBBFZ1Q
 KDWIeO2E8a3+ZdFcR1xiVtKrjPt27yFqNE4tko7o3sgdTu4munYSyWPbfYyyByT6MWGF0xD5MhD
 JAw8LqbhDPcetwIHCOejT0lHnUtyfWgyWFH6dikaQDFYZuepJuixEY7MWfRIyE+YJZGocrOlXxc
 rQaTZ2WL9UW2xREukGkd1dhCmn5glA==
X-Proofpoint-ORIG-GUID: u3plJ41tx2l1o4ou1NnGvhbV6ccsGl0K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
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

Hello Caleb,

On 25/12/15 11:18AM, Caleb Schlossin wrote:
> <...snip...>
>
> --- a/hw/ppc/pnv_psi.c
> +++ b/hw/ppc/pnv_psi.c
> @@ -25,6 +25,7 @@
>  #include "qemu/module.h"
>  #include "system/reset.h"
>  #include "qapi/error.h"
> +#include "migration/vmstate.h"
>  
>  
>  #include "hw/ppc/fdt.h"
> @@ -35,6 +36,8 @@
>  
>  #include <libfdt.h>
>  
> +#undef PSI_DEBUG
> +

Is this intended or got left over from debugging ?

>  #define PSIHB_XSCOM_FIR_RW      0x00
>  #define PSIHB_XSCOM_FIR_AND     0x01
>  #define PSIHB_XSCOM_FIR_OR      0x02
> @@ -130,12 +133,11 @@ static void pnv_psi_set_bar(PnvPsi *psi, uint64_t bar)
>  {
>      PnvPsiClass *ppc = PNV_PSI_GET_CLASS(psi);
>      MemoryRegion *sysmem = get_system_memory();
> -    uint64_t old = psi->regs[PSIHB_XSCOM_BAR];
>  
>      psi->regs[PSIHB_XSCOM_BAR] = bar & (ppc->bar_mask | PSIHB_BAR_EN);
>  
>      /* Update MR, always remove it first */
> -    if (old & PSIHB_BAR_EN) {
> +    if (memory_region_is_mapped(&psi->regs_mr)) {
>          memory_region_del_subregion(sysmem, &psi->regs_mr);
>      }
>  
> @@ -975,6 +977,40 @@ static void pnv_psi_register_types(void)
>  
>  type_init(pnv_psi_register_types);
>  
> +#ifdef PSI_DEBUG
> +static void psi_regs_pic_print_info(uint64_t *regs, uint32_t nr_regs,
> +                                    GString *buf) {
> +    uint i, prev_idx = -1;
> +    uint64_t  reg1, prev_reg1 = -1;
> +    uint64_t  reg2, prev_reg2 = -1;
> +    uint64_t  reg3, prev_reg3 = -1;
> +    uint64_t  reg4, prev_reg4 = -1;

Very minor nitpick, 2 spaces in the declaration between type and name.
checkpatch doesn't point it out, so it's okay with me.

Looks good to me overall. Please just see if the #undef was intentional,
if so:

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>

Thanks,
- Aditya G


