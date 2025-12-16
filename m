Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4BCD609CE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 16:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVXrC-0005M3-IY; Tue, 16 Dec 2025 11:25:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vVXrA-0005Kr-Tr; Tue, 16 Dec 2025 11:25:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vVXr9-0001v1-5H; Tue, 16 Dec 2025 11:25:00 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BG8BeFm021029;
 Tue, 16 Dec 2025 16:24:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=t3/G9eMMLO69p+TQf7o2bhh2mqZyEL0lP+5AsqOR4T4=; b=OzoqeviWKSI2
 3ZR1sJ7mmHG212Ysho1pwbNR3VxGciSpQ/7rxgGkZ86kZL0EPTPjpq9zl/1DjiV9
 Q/kdd6edYoDER2K/tkVJQo7v3mxLyDhUi2j9hokgHy3vofh91s+1IWsbtI9CUHEH
 o1m0D6wrVGuXB/NDf/A0DKvVdntjepmT5ZOteMX0SpUiiJVuR8uI0x6nQd5VXJxe
 5AKyJCB2d7e6H+oAdYProEGaP2I2yG0f/n2paQPwgX17cA8NQ9/Nn6XZsHfwTOcn
 3FKnAzucXssFbkAsA9hGjW9Rit4Q14ZQeUm1hGdvmrUCK4g93PIlBx226IY/ivhH
 UVa0lxU7sQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytv83yp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 16:24:55 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BGG946o014084;
 Tue, 16 Dec 2025 16:24:54 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytv83yh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 16:24:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGE93de002948;
 Tue, 16 Dec 2025 16:24:53 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b1kykn1sy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 16:24:53 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BGGOqh124904370
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Dec 2025 16:24:52 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E1C258056;
 Tue, 16 Dec 2025 16:24:52 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D428758052;
 Tue, 16 Dec 2025 16:24:51 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Dec 2025 16:24:51 +0000 (GMT)
Message-ID: <2570f988a46615022b9180b2aad228a733e3b7ff.camel@linux.ibm.com>
Subject: Re: [PATCH v3 7/7] hw/ppc: Add VMSTATE information to PnvPsi
From: Miles Glenn <milesg@linux.ibm.com>
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, angeloj@linux.ibm.com
Date: Tue, 16 Dec 2025 10:24:51 -0600
In-Reply-To: <20251216151359.418708-8-calebs@linux.ibm.com>
References: <20251216151359.418708-1-calebs@linux.ibm.com>
 <20251216151359.418708-8-calebs@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX9j+7Ob9boaI4
 VtOD3ECOlbeaJlmoQtyx1tnpF80rXEGJzMEYyjEUHAcvBMXSbBaXBceCSSFG4VgguoRUuicHCbw
 lZVjoBP1YV9+9cXD52HJXhGldipfjrCm+sl5KkGeBU8Rzx9Eo8k4z3GDIZJRIv59cBuXv6vtBVb
 Oyo+4bKhptQMwBDJR729bTbMjGn5ybyPreaBekD7ELMYIeKpiLiSHpEvms3RLb4jtqpCxY+4/r4
 peqj1c7MvOcWFuMLe97K9Kl4IhaL9oBtdZzC/QhHDOTgRA0E9deMrlSewJqSt5RJFLP8MZ711Xi
 QM8GiZagMgs+qhiwzhlVlfJuXtciJ4e54465uJAm4iRE3vyJIO3/tXVQyrD+P3BFaI4PFz2/LpR
 qMjff8tZ6gwAB+6MJCHHPHguovKDNA==
X-Proofpoint-ORIG-GUID: N5WrE2fVbznFlSqpDmKBQnVf5_taLOVI
X-Authority-Analysis: v=2.4 cv=QtRTHFyd c=1 sm=1 tr=0 ts=694187d7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=i99o-4Xi_ac2l2A7azgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Rod0kepnA6RHrLjDmqBMd5dtxrA9cB9z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1015
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

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Tue, 2025-12-16 at 09:13 -0600, Caleb Schlossin wrote:
> PnvPsi needs to be able to save/load snapshots.  Add VMSTATE information
> to the device class and a post_load() method to restore dynamic data items and
> memory region mappings.
> 
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
> ---
>  hw/ppc/pnv_psi.c | 36 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index 5d947d8b52..67bc911e4b 100644
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
> @@ -130,12 +131,11 @@ static void pnv_psi_set_bar(PnvPsi *psi, uint64_t bar)
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
> @@ -919,6 +919,37 @@ static const TypeInfo pnv_psi_power9_info = {
>      },
>  };
>  
> +static int vmstate_pnv_psi_post_load(void *opaque, int version_id)
> +{
> +    PnvPsi *psi = PNV_PSI(opaque);
> +    Pnv9Psi *psi9 = PNV9_PSI(psi);
> +    MemoryRegion   *sysmem = get_system_memory();
> +    uint64_t esb_bar;
> +    hwaddr esb_addr;
> +
> +    /* Set the ESB MMIO mapping */
> +    esb_bar = psi->regs[PSIHB_REG(PSIHB9_ESB_CI_BASE)];
> +
> +    if (esb_bar & PSIHB9_ESB_CI_VALID) {
> +        esb_addr = esb_bar & PSIHB9_ESB_CI_ADDR_MASK;
> +        memory_region_add_subregion(sysmem, esb_addr,
> +                                    &psi9->source.esb_mmio);
> +    }
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_pnv_psi = {
> +    .name = TYPE_PNV_PSI,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .post_load = vmstate_pnv_psi_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT64_ARRAY(regs, PnvPsi, PSIHB_XSCOM_MAX),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static void pnv_psi_power10_class_init(ObjectClass *klass, const void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -926,6 +957,7 @@ static void pnv_psi_power10_class_init(ObjectClass *klass, const void *data)
>      static const char compat[] = "ibm,power10-psihb-x\0ibm,psihb-x";
>  
>      dc->desc    = "PowerNV PSI Controller POWER10";
> +    dc->vmsd = &vmstate_pnv_psi;
>  
>      ppc->xscom_pcba = PNV10_XSCOM_PSIHB_BASE;
>      ppc->xscom_size = PNV10_XSCOM_PSIHB_SIZE;


