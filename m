Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727DAD59D77
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 17:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU6aZ-0004Kg-8z; Fri, 12 Dec 2025 12:05:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vU6aR-0004Hd-TC; Fri, 12 Dec 2025 12:05:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vU6aQ-000765-7O; Fri, 12 Dec 2025 12:05:47 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BCE7iJO004373;
 Fri, 12 Dec 2025 17:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=nB5O7zTXHwey6ueZLa3szFfn7Qhxmql81gbvFT66UwU=; b=hFcSpHnE0bif
 LMKKOWf3qshphI/yZs7LCy4bPOFkOVLwGC+5CvLdTJE3CmXDKkuYUDA+F7eayDFR
 dYhk50yXQkUhHK647bjIjRpMWzZlEHcTlw2f9E5T8UBkQcsussyLiwF4ZYfsNRjE
 YXGBDu8Tr/7VQMig8v6w6LB8FInxTTVjy1vNATD62nrpP3YB1+Oi/KSR4ujyARkG
 xHEkJzkfjCgEEjq0iDw938mHfS3162mp6lvhMbbycEeoHey328dn6h/wi5dvylzD
 cCfK1LhUyYlU+N0PkOD8igYNJ2dESRZndyCf5FpWseYICznHr9O7FqG127j3PVpx
 aQY1FnfBWg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc61xkay-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 17:05:43 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BCGDXAK009014;
 Fri, 12 Dec 2025 17:05:42 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc61xkau-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 17:05:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BCEI62E012807;
 Fri, 12 Dec 2025 17:05:41 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aw0akd0my-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 17:05:41 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BCH5eBd48824726
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Dec 2025 17:05:40 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E227458056;
 Fri, 12 Dec 2025 17:05:39 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8BBA058052;
 Fri, 12 Dec 2025 17:05:39 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Dec 2025 17:05:39 +0000 (GMT)
Message-ID: <7f76d2e8b1a1d6fda09806882bd2ad354840271a.camel@linux.ibm.com>
Subject: Re: [PATCH] pnv/psi: Add VMSTATE information to PnvPsi
From: Miles Glenn <milesg@linux.ibm.com>
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, adityag@linux.ibm.com, npiggin@gmail.com,
 kowal@linux.ibm.com
Date: Fri, 12 Dec 2025 11:05:39 -0600
In-Reply-To: <20251211170012.2220477-1-calebs@linux.ibm.com>
References: <20251211170012.2220477-1-calebs@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX824LdWrRUhSw
 3kYBCujSNu2rNlW4L8EJMh/7spS4DVDgWz3dYp2STI4NAQPbDOuNjt5lCD94lJWACDgMivbqVD6
 Lppb7OxDUpbwKbfR73ksoBfq3GYYFrIM52f/Hv2kGp6LQza/k3HLjFCdbE6CE3qhKK2PxynlyMy
 L0m3qiRI5y7Zn3iy2hFU1N3CUmpE38kz26VNSjS8WRSIKsUjiw+8nUzc4IYalIaNQICY+RL5xCq
 g3gPRtb6XaHci8E/RMz2mzhQOK77T/rmN7QP5yA1iUgwpKI1HO/gw7nesp2eU0w5RMGDLx/7GC5
 doJnWaKdSPrj6W/rhMQ0G3RxfMuU3dnEmztxkhxJ9htg3Yqenewn1e/sMOrCByWLQqfv3rHQECY
 KUi+EX/rvy11jGid0D1J2DFNcAt52w==
X-Proofpoint-GUID: 8OKxw8I80obubsPSZQ6JTI-V6i8CCioA
X-Proofpoint-ORIG-GUID: QhgQ4eNJzl6lswf6-Jd9-KTp8VjK8SuN
X-Authority-Analysis: v=2.4 cv=O/U0fR9W c=1 sm=1 tr=0 ts=693c4b67 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=6cxi4RDW2u8cD750MQgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_04,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Caleb, why not add this commit to your other submission of patches
titled "Snapshot support for several ppc devices"?

-Glenn

On Thu, 2025-12-11 at 11:00 -0600, Caleb Schlossin wrote:
> PnvPsi needs to be able to save/load snapshots.  Add VMSTATE information
> to the device class and a post_load() method to restore dynamic data items and
> memory region mappings.
> 
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
> ---
>  hw/ppc/pnv_psi.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index 5d947d8b52..88d5f1d45d 100644
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
> +    for (i = 0; i < nr_regs; i = i + 4) {
> +        /* Don't print if values do not change, but print last*/
> +        reg1 = regs[i];
> +        reg2 = regs[i + 1];
> +        reg3 = regs[i + 2];
> +        reg4 = regs[i + 3];
> +        if (reg1 == prev_reg1 && reg2 == prev_reg2 &&
> +            reg3 == prev_reg3 && reg4 == prev_reg4 &&
> +            i < (nr_regs - 4)) {
> +            if (i == (prev_idx + 4)) {
> +                g_string_append_printf(buf, "        . . .\n");
> +            }
> +            continue;
> +        }
> +
> +        g_string_append_printf(buf, "  [%03X] 0x%016lX %016lX %016lX %016lX\n",
> +            i, reg1, reg2, reg3, reg4);
> +        prev_idx = i;
> +        prev_reg1 = reg1;
> +        prev_reg2 = reg2;
> +        prev_reg3 = reg3;
> +        prev_reg4 = reg4;
> +    }
> +}
> +#endif
> +
>  void pnv_psi_pic_print_info(Pnv9Psi *psi9, GString *buf)
>  {
>      PnvPsi *psi = PNV_PSI(psi9);
> @@ -985,4 +1021,10 @@ void pnv_psi_pic_print_info(Pnv9Psi *psi9, GString *buf)
>      g_string_append_printf(buf, "PSIHB Source %08x .. %08x\n",
>                             offset, offset + psi9->source.nr_irqs - 1);
>      xive_source_pic_print_info(&psi9->source, offset, buf);
> +#ifdef PSI_DEBUG
> +    /* Print PSI registers */
> +    g_string_append_printf(buf, "\nPSI Regs[0x0..%X]\n",
> +                           PSIHB_XSCOM_MAX);
> +    psi_regs_pic_print_info(psi->regs, PSIHB_XSCOM_MAX, buf);
> +#endif
>  }


