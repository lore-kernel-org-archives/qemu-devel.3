Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B221C25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 14:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxkA-0004US-7i; Tue, 28 May 2024 10:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1sBxk6-0004Tj-BQ; Tue, 28 May 2024 10:23:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1sBxk4-00018V-87; Tue, 28 May 2024 10:23:58 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44SEHCxO004356; Tue, 28 May 2024 14:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : reply-to : subject : to; s=pp1;
 bh=Y0j9SVZj5JAxFd0wXrkGlEEGAhIaKYwQtr3CU9gTCuY=;
 b=V8pO4uRcEDZiE+ZNEJehw2s9YivRq588Lx6RxaLKUKQ+yR1c8K86x3wBTcwk/7N8zYtE
 K6cD61CF5HBEfQlIN6mzXxF7kFvXOWU5fTiJIvR3cjFWAm4curild/yR7KdL7nrH6wG8
 1s2fHhmov5BVX9HOcaINin7OZqWqbgvfLErgLyqa4HjCMfxiSDLJvqvgbpajcgtSoIRt
 gOJrJ1RVP+a8nrM0/83Y2kak+XE/iNtQ0CBbgUnjbtXwoBfdMpbMuIWG6MJU6/uIcaN1
 IOj9OdGIU1qGxt5x1eDs5KcIE6JKtgqirtyKXzfuaQrB0lTQdlcspFKVq1UKL6Sz+2uI nA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ydgw300ft-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 14:23:39 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44SENcpf016416;
 Tue, 28 May 2024 14:23:38 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ydgw300fr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 14:23:38 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44SEI4C1027089; Tue, 28 May 2024 14:23:37 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ybvhkpx1m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 14:23:37 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44SENX5X21758554
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 May 2024 14:23:36 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD0725806D;
 Tue, 28 May 2024 14:23:33 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A400C58063;
 Tue, 28 May 2024 14:23:33 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 May 2024 14:23:33 +0000 (GMT)
Message-ID: <ba7fe24a38b5cf1954cdde91ea3c777324b78c82.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] ppc/pnv: Fix loss of LPC SERIRQ interrupts
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater
 <clg@kaod.org>, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, qemu-devel@nongnu.org
Date: Tue, 28 May 2024 09:23:33 -0500
In-Reply-To: <20240528062045.624906-2-npiggin@gmail.com>
References: <20240528062045.624906-1-npiggin@gmail.com>
 <20240528062045.624906-2-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1-VLlfEGbv5RlFEuLwwsm0dVtZ9AsJyd
X-Proofpoint-ORIG-GUID: guKIb3on-4cM9crAESqxANX3bZpneXiG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_10,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 mlxlogscore=889 suspectscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280108
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 2024-05-28 at 16:20 +1000, Nicholas Piggin wrote:
> From: Glenn Miles <milesg@linux.vnet.ibm.com>
> 
> The LPC HC irq status register bits are set when an LPC IRQSER input
> is
> asserted. These irq status bits drive the PSI irq to the CPU
> interrupt
> controller. The LPC HC irq status bits are cleared by software
> writing
> to the register with 1's for the bits to clear.
> 
> Existing register write was clearing the irq status bits even when
> the
> input was asserted, this results in interrupts being lost.
> 
> This fix changes the behavior to keep track of the device IRQ status
> in internal state that is separate from the irq status register, and
> only allowing the irq status bits to be cleared if the associated
> input is not asserted.
> 
> [np: rebased before P9 PSI SERIRQ patch, adjust changelog/comments]
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  include/hw/ppc/pnv_lpc.h |  3 +++
>  hw/ppc/pnv_lpc.c         | 22 +++++++++++++++++++---
>  2 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
> index 5d22c45570..97c6872c3f 100644
> --- a/include/hw/ppc/pnv_lpc.h
> +++ b/include/hw/ppc/pnv_lpc.h
> @@ -73,6 +73,9 @@ struct PnvLpcController {
>      uint32_t opb_irq_pol;
>      uint32_t opb_irq_input;
>  
> +    /* LPC device IRQ state */
> +    uint32_t lpc_hc_irq_inputs;
> +
>      /* LPC HC registers */
>      uint32_t lpc_hc_fw_seg_idsel;
>      uint32_t lpc_hc_fw_rd_acc_size;
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index d692858bee..252690dcaa 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -505,7 +505,14 @@ static void lpc_hc_write(void *opaque, hwaddr
> addr, uint64_t val,
>          pnv_lpc_eval_irqs(lpc);
>          break;
>      case LPC_HC_IRQSTAT:
> -        lpc->lpc_hc_irqstat &= ~val;
> +        /*
> +         * This register is write-to-clear for the IRQSER (LPC
> device IRQ)
> +         * status. However if the device has not de-asserted its
> interrupt
> +         * that will just raise this IRQ status bit again. Model
> this by
> +         * keeping track of the inputs and only clearing if the
> inputs are
> +         * deasserted.
> +         */
> +        lpc->lpc_hc_irqstat &= ~(val & ~lpc->lpc_hc_irq_inputs);
>          pnv_lpc_eval_irqs(lpc);
>          break;
>      case LPC_HC_ERROR_ADDRESS:
> @@ -803,11 +810,20 @@ static void pnv_lpc_isa_irq_handler_cpld(void
> *opaque, int n, int level)
>  static void pnv_lpc_isa_irq_handler(void *opaque, int n, int level)
>  {
>      PnvLpcController *lpc = PNV_LPC(opaque);
> +    uint32_t irq_bit = LPC_HC_IRQ_SERIRQ0 >> n;
>  
> -    /* The Naples HW latches the 1 levels, clearing is done by SW */
>      if (level) {
> -        lpc->lpc_hc_irqstat |= LPC_HC_IRQ_SERIRQ0 >> n;
> +        lpc->lpc_hc_irq_inputs |= irq_bit;
> +
> +        /*
> +	 * The LPC HC in Naples and later latches LPC IRQ into a bit
> field in
> +	 * the IRQSTAT register, and that drives the PSI IRQ to the IC.
> +	 * Software clears this bit manually (see LPC_HC_IRQSTAT
> handler).
> +         */
> +        lpc->lpc_hc_irqstat |= irq_bit;
>          pnv_lpc_eval_irqs(lpc);
> +    } else {
> +        lpc->lpc_hc_irq_inputs &= ~irq_bit;
>      }
>  }
>  


