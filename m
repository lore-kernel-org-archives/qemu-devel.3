Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE28D59D79
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 17:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU6xE-0006Mb-QP; Fri, 12 Dec 2025 12:29:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vU6xC-0006M2-5d; Fri, 12 Dec 2025 12:29:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vU6x9-0004FB-Px; Fri, 12 Dec 2025 12:29:17 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BCA5Ar1029441;
 Fri, 12 Dec 2025 17:29:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=IXdDhSkV76mJAxN076VOYm1w75SrlhthoaZK/DdcvhU=; b=PgiPKGPC98yW
 ogMtt3McjTy1jnKT2Vc6rSBh9j1hbNQdrACLD58A/uNnjKZZcZqvtm2lNqzxmEv9
 Wl40vhq1M+PLOD2IBTPh9j1VVfFBuP2Eifh/iJTKO8up4zR4Q1zWKwVXAJvzKMe3
 jP4aDp+ZIz5OJsnGDiwzSNlauXq2bQ39XJA/iu3jYkkVw1sS8v2odwkBm71hQHn7
 bO/RsTIhGuYnVj81Y688ckBKjpSDkdAPtZt0Hq7W9pgfOJ3I7LYTImVUSt5iXOl/
 TbL+PluQt0BCN9icyeqd/niVuRXbhiLOzhnfAt6uS3syFZcvEoPBaTIQhG3SMMZe
 U63LFRzRkQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc7cep6x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 17:29:11 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BCHNAlv004002;
 Fri, 12 Dec 2025 17:29:11 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc7cep6s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 17:29:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BCF0fYr002031;
 Fri, 12 Dec 2025 17:29:10 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw11jvyj8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 17:29:10 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BCHT8gi9962110
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Dec 2025 17:29:08 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6513C58058;
 Fri, 12 Dec 2025 17:29:08 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E59D558059;
 Fri, 12 Dec 2025 17:29:07 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Dec 2025 17:29:07 +0000 (GMT)
Message-ID: <9fa24dd11d17c8b8bfd5e05cdff99b90a5e86b96.camel@linux.ibm.com>
Subject: Re: [PATCH 2/6] hw/ppc: Add pnv_spi vmstate support
From: Miles Glenn <milesg@linux.ibm.com>
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, angeloj@linux.ibm.com
Date: Fri, 12 Dec 2025 11:29:07 -0600
In-Reply-To: <20251211220926.2865972-3-calebs@linux.ibm.com>
References: <20251211220926.2865972-1-calebs@linux.ibm.com>
 <20251211220926.2865972-3-calebs@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yJ1hQ1WWF_1EZPVewWEPUT1pEu3X6JJG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX/H4jQVH8AHPc
 fym5JjWeOk6DvFuBDoNZTO+Glk2n8at+ItLkC6dMYQx1Cfj0aMMw6nl9t/yz3ZaEas7/1niFcZZ
 +0qFIrLtlnoL+EiEMbcQTNA9Cl2bCg+Xdvw+IaqVuMB15Rit1by5BwuGV9WCmiHgZJjAF70um/t
 200N24LTjWGEfAA0JK6ZTic+JRU+YsIW3dXmAdxBdZvP077cKHsIZeivElvh5qns1bESG05yf6f
 ACejzkHKF9eViYsz7M4GO9YLKygF0tG0FZ8sOrb+wpYBtmo2PWpw/lLkKa0cZ8eTruK0m5FGSd+
 SgD8ZGLCvIqyJmqqzBxQLNrYRrSChMBqT0/4wjJq2q4vXFtfev9b06O5zVTn31Uf67pyrf36QjJ
 9w97Rl84uI1qrfNcgK+aEYs07wWvag==
X-Proofpoint-GUID: isSr2emYh6lyMPyVsaYhVZh2F3DAF1Mq
X-Authority-Analysis: v=2.4 cv=FpwIPmrq c=1 sm=1 tr=0 ts=693c50e8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=RYQ7Hoy1Khi-nIyfzpQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_04,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
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

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

On Thu, 2025-12-11 at 16:09 -0600, Caleb Schlossin wrote:
> - Add support for needed PnvSpi structure variables
> 
> Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
> ---
>  hw/ssi/pnv_spi.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
> index f40e8836b9..389a2cca6b 100644
> --- a/hw/ssi/pnv_spi.c
> +++ b/hw/ssi/pnv_spi.c
> @@ -13,6 +13,7 @@
>  #include "hw/ssi/pnv_spi.h"
>  #include "hw/ssi/pnv_spi_regs.h"
>  #include "hw/ssi/ssi.h"
> +#include "migration/vmstate.h"
>  #include <libfdt.h>
>  #include "hw/irq.h"
>  #include "trace.h"
> @@ -1199,6 +1200,31 @@ static int pnv_spi_dt_xscom(PnvXScomInterface *dev, void *fdt,
>      return 0;
>  }
>  
> +static const VMStateDescription pnv_spi_vmstate = {
> +    .name = TYPE_PNV_SPI,
> +    .version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT8(fail_count, PnvSpi),
> +        VMSTATE_UINT8(transfer_len, PnvSpi),
> +        VMSTATE_UINT8(responder_select, PnvSpi),
> +        VMSTATE_BOOL(shift_n1_done, PnvSpi),
> +        VMSTATE_UINT8(loop_counter_1, PnvSpi),
> +        VMSTATE_UINT8(loop_counter_2, PnvSpi),
> +        VMSTATE_UINT8(N1_bits, PnvSpi),
> +        VMSTATE_UINT8(N2_bits, PnvSpi),
> +        VMSTATE_UINT8(N1_bytes, PnvSpi),
> +        VMSTATE_UINT8(N2_bytes, PnvSpi),
> +        VMSTATE_UINT8(N1_tx, PnvSpi),
> +        VMSTATE_UINT8(N2_tx, PnvSpi),
> +        VMSTATE_UINT8(N1_rx, PnvSpi),
> +        VMSTATE_UINT8(N2_rx, PnvSpi),
> +        VMSTATE_UINT64_ARRAY(regs, PnvSpi, PNV_SPI_REGS),
> +        VMSTATE_UINT8_ARRAY(seq_op, PnvSpi, PNV_SPI_REG_SIZE),
> +        VMSTATE_UINT64(status, PnvSpi),
> +        VMSTATE_END_OF_LIST(),
> +    },
> +};
> +
>  static void pnv_spi_class_init(ObjectClass *klass, const void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -1209,6 +1235,7 @@ static void pnv_spi_class_init(ObjectClass *klass, const void *data)
>      dc->desc = "PowerNV SPI";
>      dc->realize = pnv_spi_realize;
>      device_class_set_legacy_reset(dc, do_reset);
> +    dc->vmsd = &pnv_spi_vmstate;
>      device_class_set_props(dc, pnv_spi_properties);
>  }
>  


