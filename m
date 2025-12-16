Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D6BD609AF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 15:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVX3Z-0006Po-WC; Tue, 16 Dec 2025 10:33:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vVX3Y-0006PM-Fo; Tue, 16 Dec 2025 10:33:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vVX3W-0003vx-8l; Tue, 16 Dec 2025 10:33:44 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGCdE55003716;
 Tue, 16 Dec 2025 15:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=wQ2yfCQiJbqS/bzpyn/WgA94CffNAsNaZbjceGprUR0=; b=IYmTYxQFw9f+
 3rVVmhHHGVXshSEa0KBzvXeAljaQF1hSFSH0qavjEN5PgizelapIyNGd5tP0jkgW
 DhK0k00E0ePYG7WR/fWANPxEDhOiiujD4fU1OZHw2Ygk/1Kjf835A/TEBGjc8bIB
 cRNyVmB716pBFlTXnlTKkx+3K1bFM1AW23fZ3D/8pXIVRXqie4z4T7ANX/Kd44U0
 rhFRUJx2x3zOlu7IQRK6mpUzcDWelSInYWljaeReMf6YqaU3tFP4poHGiUYs8Thg
 UGt99QqfHh5cyo+Ktfz6oDBzaCSnPxuyv6hIGdBqOfViibgt9dun+NvkFr0KLvfW
 cprg6xARqg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yvb7v2j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 15:33:37 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BGFN11L023501;
 Tue, 16 Dec 2025 15:33:37 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yvb7v2g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 15:33:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGFXYZb026786;
 Tue, 16 Dec 2025 15:33:36 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1jfsd4xk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 15:33:36 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BGFXZDQ25166556
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Dec 2025 15:33:35 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2AE275805C;
 Tue, 16 Dec 2025 15:33:35 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C4D758054;
 Tue, 16 Dec 2025 15:33:34 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Dec 2025 15:33:34 +0000 (GMT)
Message-ID: <5d980de82045897e33690d9fbb5000c9984ac88b.camel@linux.ibm.com>
Subject: Re: [PATCH] pnv/psi: Add VMSTATE information to PnvPsi
From: Miles Glenn <milesg@linux.ibm.com>
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, adityag@linux.ibm.com, npiggin@gmail.com,
 kowal@linux.ibm.com
Date: Tue, 16 Dec 2025 09:33:34 -0600
In-Reply-To: <f1900417-7fca-4885-a748-fec12f61b643@linux.ibm.com>
References: <20251211170012.2220477-1-calebs@linux.ibm.com>
 <7f76d2e8b1a1d6fda09806882bd2ad354840271a.camel@linux.ibm.com>
 <f1900417-7fca-4885-a748-fec12f61b643@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/JwEOni c=1 sm=1 tr=0 ts=69417bd1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=SONJ_9cpsW4br2Y24R4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: x9s3QRxzmlA6WYltwu1sHTsIaL9zO6A6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX4bzC6QrSnCHF
 HYJBfyzYsqAggAE8MbDF6Fl9GEOCFYU0o11/Ut7F6Q8gkNTF7lapKN7+cBAJ3Sgdm0yWknjue78
 Cgd+PYTr7dtf3dj+mhQavThiCE4opXBU8WA0d5cRT3OmlvdSg2Ry+6HaKTEdmgNmfDqUvsc0dsa
 QR+RHA3BffwMLfvUI7Ue4Ka3L7HJxAMZmQXtpj5WiQHpZhcPddi3XcYNFu9LCXbuOcMvIXjB3XE
 o7vpYupqJdNXQ0P3LcjeWrP57Busus4bH/iaK7HhZq4HXTFREObC1v8WhKtAM1Zecr3cRkuze63
 rhPZ6qCk82Osc5tPlAO/f4Qbv1Jr39C2FpxigmcARq7o5IdjmiLgiC6uBO/Kyv+r1LVEiJ1tEM+
 SBmgqzSXGdxZ3toQuZ/XctTVODuqCQ==
X-Proofpoint-ORIG-GUID: BqDEDzaf14b-u5GTeTSGU41DyX3ZKcwN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023
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

On Mon, 2025-12-15 at 07:07 -0600, Caleb Schlossin wrote:
> I can do that, if others agree. I see the commit msg should really be "hw/ppc: ...", so it would fit with the others.
> 
> - Caleb
> 

Even if that wasn't the case, a commit series is not required to
address a single component (they often don't) and the cover letter
subject doesn't even need to have the "hw/ppc:" prefix in it.

-Glenn

> On 12/12/25 11:05 AM, Miles Glenn wrote:
> > Caleb, why not add this commit to your other submission of patches
> > titled "Snapshot support for several ppc devices"?
> > 
> > -Glenn
> > 
> > On Thu, 2025-12-11 at 11:00 -0600, Caleb Schlossin wrote:
> > > PnvPsi needs to be able to save/load snapshots.  Add VMSTATE information
> > > to the device class and a post_load() method to restore dynamic data items and
> > > memory region mappings.
> > > 
> > > Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> > > Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
> > > ---
> > >  hw/ppc/pnv_psi.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 44 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> > > index 5d947d8b52..88d5f1d45d 100644
> > > --- a/hw/ppc/pnv_psi.c
> > > +++ b/hw/ppc/pnv_psi.c
> > > @@ -25,6 +25,7 @@
> > >  #include "qemu/module.h"
> > >  #include "system/reset.h"
> > >  #include "qapi/error.h"
> > > +#include "migration/vmstate.h"
> > >  
> > >  
> > >  #include "hw/ppc/fdt.h"
> > > @@ -35,6 +36,8 @@
> > >  
> > >  #include <libfdt.h>
> > >  
> > > +#undef PSI_DEBUG
> > > +
> > >  #define PSIHB_XSCOM_FIR_RW      0x00
> > >  #define PSIHB_XSCOM_FIR_AND     0x01
> > >  #define PSIHB_XSCOM_FIR_OR      0x02
> > > @@ -130,12 +133,11 @@ static void pnv_psi_set_bar(PnvPsi *psi, uint64_t bar)
> > >  {
> > >      PnvPsiClass *ppc = PNV_PSI_GET_CLASS(psi);
> > >      MemoryRegion *sysmem = get_system_memory();
> > > -    uint64_t old = psi->regs[PSIHB_XSCOM_BAR];
> > >  
> > >      psi->regs[PSIHB_XSCOM_BAR] = bar & (ppc->bar_mask | PSIHB_BAR_EN);
> > >  
> > >      /* Update MR, always remove it first */
> > > -    if (old & PSIHB_BAR_EN) {
> > > +    if (memory_region_is_mapped(&psi->regs_mr)) {
> > >          memory_region_del_subregion(sysmem, &psi->regs_mr);
> > >      }
> > >  
> > > @@ -975,6 +977,40 @@ static void pnv_psi_register_types(void)
> > >  
> > >  type_init(pnv_psi_register_types);
> > >  
> > > +#ifdef PSI_DEBUG
> > > +static void psi_regs_pic_print_info(uint64_t *regs, uint32_t nr_regs,
> > > +                                    GString *buf) {
> > > +    uint i, prev_idx = -1;
> > > +    uint64_t  reg1, prev_reg1 = -1;
> > > +    uint64_t  reg2, prev_reg2 = -1;
> > > +    uint64_t  reg3, prev_reg3 = -1;
> > > +    uint64_t  reg4, prev_reg4 = -1;
> > > +    for (i = 0; i < nr_regs; i = i + 4) {
> > > +        /* Don't print if values do not change, but print last*/
> > > +        reg1 = regs[i];
> > > +        reg2 = regs[i + 1];
> > > +        reg3 = regs[i + 2];
> > > +        reg4 = regs[i + 3];
> > > +        if (reg1 == prev_reg1 && reg2 == prev_reg2 &&
> > > +            reg3 == prev_reg3 && reg4 == prev_reg4 &&
> > > +            i < (nr_regs - 4)) {
> > > +            if (i == (prev_idx + 4)) {
> > > +                g_string_append_printf(buf, "        . . .\n");
> > > +            }
> > > +            continue;
> > > +        }
> > > +
> > > +        g_string_append_printf(buf, "  [%03X] 0x%016lX %016lX %016lX %016lX\n",
> > > +            i, reg1, reg2, reg3, reg4);
> > > +        prev_idx = i;
> > > +        prev_reg1 = reg1;
> > > +        prev_reg2 = reg2;
> > > +        prev_reg3 = reg3;
> > > +        prev_reg4 = reg4;
> > > +    }
> > > +}
> > > +#endif
> > > +
> > >  void pnv_psi_pic_print_info(Pnv9Psi *psi9, GString *buf)
> > >  {
> > >      PnvPsi *psi = PNV_PSI(psi9);
> > > @@ -985,4 +1021,10 @@ void pnv_psi_pic_print_info(Pnv9Psi *psi9, GString *buf)
> > >      g_string_append_printf(buf, "PSIHB Source %08x .. %08x\n",
> > >                             offset, offset + psi9->source.nr_irqs - 1);
> > >      xive_source_pic_print_info(&psi9->source, offset, buf);
> > > +#ifdef PSI_DEBUG
> > > +    /* Print PSI registers */
> > > +    g_string_append_printf(buf, "\nPSI Regs[0x0..%X]\n",
> > > +                           PSIHB_XSCOM_MAX);
> > > +    psi_regs_pic_print_info(psi->regs, PSIHB_XSCOM_MAX, buf);
> > > +#endif
> > >  }


