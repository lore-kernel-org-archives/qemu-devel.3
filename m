Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72813D59D77
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 17:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU6gi-0006lQ-St; Fri, 12 Dec 2025 12:12:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vU6gh-0006l9-EK; Fri, 12 Dec 2025 12:12:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vU6gf-0000XC-Ri; Fri, 12 Dec 2025 12:12:15 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BCFJITK000613;
 Fri, 12 Dec 2025 17:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=k1omdPacnWkmELZX8CxLa2AGC7IWRiEyhSq1QH/Vc9o=; b=IGlwDPOf0wkm
 xL7qDopz2Qk1rZmy1qqcWP+fCVOBFNW1Qyb7Bl8ptIMov7Rg9JcpdgVfWN+0SiWl
 Tock6vwSAq/E1o7zJZ6tWFVK9K2F/p405GL+YhI/acqFNlxDk1yJk5ppeKd/hzIT
 2ETJvI8kGk/fLkyS6qc+jjBVB7xfVZ/hV8MzJTVHLS+BQ3cPCJJ4nzY+B4uYtLs/
 YHlFTi5OKU35Me/3HLElzAO2l4Bd7hyyCOUVhfWkOPuux7yhkjiMRtr5JW9Evy1n
 O3CiqyY090zvBVSIJvBKN+2JhEX5/k36pUXvkAye3hmsD7kNAC9QOXS5K4jU5kzV
 Bku7dqMxTw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc0kemgv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 17:12:09 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BCHC9bV003273;
 Fri, 12 Dec 2025 17:12:09 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc0kemgq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 17:12:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BCH7NNu012432;
 Fri, 12 Dec 2025 17:12:08 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aw0akd1gb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 17:12:08 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BCHC6fL63242584
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Dec 2025 17:12:06 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 82D0358064;
 Fri, 12 Dec 2025 17:12:06 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1508758057;
 Fri, 12 Dec 2025 17:12:06 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Dec 2025 17:12:06 +0000 (GMT)
Message-ID: <2d8f202116a38c2894b543cbb68867ae14ec7622.camel@linux.ibm.com>
Subject: Re: [PATCH 1/6] hw/ppc: Add VMSTATE information for LPC model
From: Miles Glenn <milesg@linux.ibm.com>
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, angeloj@linux.ibm.com
Date: Fri, 12 Dec 2025 11:12:05 -0600
In-Reply-To: <20251211220926.2865972-2-calebs@linux.ibm.com>
References: <20251211220926.2865972-1-calebs@linux.ibm.com>
 <20251211220926.2865972-2-calebs@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cf8FJbrl c=1 sm=1 tr=0 ts=693c4ce9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=H4sycyl6Zx4OkLDMWMYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ztgkZynSjEQ2voAVUbNh51qxHxYHcJlh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAxNiBTYWx0ZWRfX2ePbo0tnnc2q
 2CnjA9GgWI2At4JxaA9fjtrwmkogd4LWlKAJiT+c8piyhbEykmbmUwEZraoqf1I1JWbXFuDKhDt
 M/H6IfV4wOyiIVafq2WeZFzBdTGePKqJnkSAsoLpTVnUIidpSokdBwfLPEq6B4gq7c5QbmoqkaH
 nOju5kHQTyb1H1xAB7sHDcniYhuAd8Jy8LXbIarlDNvY9ECdrz44aDPLs9y00w5DUMx5z6Pg08h
 C9RarqBnqh++c8QmInm80IelT6FIFcRvbDL5T7f9JsKWedvW0EOQE6n20cDGq+qTvtOk2DXN9v0
 5No6Q4l9cMDvtPyxaRFITwZ7yePFAmRBylh0JoN+M0JEanETrWdI4y4A7FgLrHqotlahRE3sUtk
 /EXyvfrvuTSRj95ZTwnC3xnpxWkw4A==
X-Proofpoint-GUID: ntfWn0vv-MEn3phzEfSfz3Q56JPWIJn6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_04,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2512060016
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

On Thu, 2025-12-11 at 16:09 -0600, Caleb Schlossin wrote:
> The PNV LPC model needs snapshot/migration support.  Added a VMSTATE
> descriptor to save model data and an associated post_load() method.
> 
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
> ---
>  hw/ppc/pnv_lpc.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index f6beba0917..7f11fd312a 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -30,6 +30,7 @@
>  #include "hw/ppc/pnv_lpc.h"
>  #include "hw/ppc/pnv_xscom.h"
>  #include "hw/ppc/fdt.h"
> +#include "migration/vmstate.h"
>  
>  #include <libfdt.h>
>  
> @@ -777,11 +778,49 @@ static const TypeInfo pnv_lpc_power9_info = {
>      .class_init    = pnv_lpc_power9_class_init,
>  };
>  
> +static int vmstate_pnv_lpc_post_load(void *opaque, int version_id)
> +{
> +    PnvLpcController *lpc = PNV_LPC(opaque);
> +
> +    memory_region_set_alias_offset(&lpc->opb_isa_fw,
> +                                   lpc->lpc_hc_fw_seg_idsel * LPC_FW_OPB_SIZE);
> +    pnv_lpc_eval_serirq_routes(lpc);
> +
> +    pnv_lpc_eval_irqs(lpc);
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_pnv_lpc = {
> +    .name = TYPE_PNV_LPC,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .post_load = vmstate_pnv_lpc_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT64(eccb_stat_reg,       PnvLpcController),
> +        VMSTATE_UINT32(eccb_data_reg,       PnvLpcController),
> +        VMSTATE_UINT32(opb_irq_route0,      PnvLpcController),
> +        VMSTATE_UINT32(opb_irq_route1,      PnvLpcController),
> +        VMSTATE_UINT32(opb_irq_stat,        PnvLpcController),
> +        VMSTATE_UINT32(opb_irq_mask,        PnvLpcController),
> +        VMSTATE_UINT32(opb_irq_pol,         PnvLpcController),
> +        VMSTATE_UINT32(opb_irq_input,       PnvLpcController),
> +        VMSTATE_UINT32(lpc_hc_irq_inputs,   PnvLpcController),
> +        VMSTATE_UINT32(lpc_hc_fw_seg_idsel, PnvLpcController),
> +        VMSTATE_UINT32(lpc_hc_irqser_ctrl,  PnvLpcController),
> +        VMSTATE_UINT32(lpc_hc_irqmask,      PnvLpcController),
> +        VMSTATE_UINT32(lpc_hc_irqstat,      PnvLpcController),
> +        VMSTATE_UINT32(lpc_hc_error_addr,   PnvLpcController),
> +        VMSTATE_UINT32(lpc_hc_fw_rd_acc_size,     PnvLpcController),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static void pnv_lpc_power10_class_init(ObjectClass *klass, const void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
>      dc->desc = "PowerNV LPC Controller POWER10";
> +    dc->vmsd = &vmstate_pnv_lpc;
>  }
>  
>  static const TypeInfo pnv_lpc_power10_info = {


