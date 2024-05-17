Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DA5C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 19:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s83ED-0008VQ-Nm; Fri, 17 May 2024 15:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1s83EB-0008Te-KF; Fri, 17 May 2024 15:26:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1s83E8-00008c-2x; Fri, 17 May 2024 15:26:51 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44HImoa4016439; Fri, 17 May 2024 19:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=8zXOvBbOKyt1iLeNCMIa1uZi64NliXHOz5FhA9zBRvY=;
 b=rId1rXtuTbWj7ggwHEJwL+f5mErPpto52/sCCFjlrLcAbZjg8FD0BfmqySI5JTxYoBtu
 C1qaN6VbJ/OYG4q/gqw1u5axDrS4vxCvjicDx/Cruuav3yO/gcLAzMN7FmJpunHlawqb
 KGkB9Sikd0UqLvwnnGJWEzvJ6LMPAhnqMNuRRiR5iW55UVq05Ryb78Xf804gy4xf+h2V
 UGYGPvID3OBq4c/wDljMAukqsWfwidEro4MZ/ok0VHqFK35U7UlUxACi8eImA7XsvEQn
 QAqIc/VfiMkpFzA64Okj8VJNvmLAyTPTVhnLTCyJfaawDdA3iH1vxFOkk5MiObi6LVjf lA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y6ctwg2nt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 May 2024 19:26:42 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44HJQfrw026847;
 Fri, 17 May 2024 19:26:41 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y6ctwg2ns-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 May 2024 19:26:41 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44HHn53A005998; Fri, 17 May 2024 19:26:40 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2mgn1s7w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 May 2024 19:26:39 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44HJQYEu25428712
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 May 2024 19:26:36 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 99C6E5805F;
 Fri, 17 May 2024 19:26:34 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 636CD58051;
 Fri, 17 May 2024 19:26:34 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 May 2024 19:26:34 +0000 (GMT)
Message-ID: <a89426dc95197bfce6acd7f7891a1570ee22a005.camel@linux.ibm.com>
Subject: Re: [PATCH v3 4/5] hw/ppc: SPI controller wiring to P10 chip
From: Miles Glenn <milesg@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: fbarrat@linux.ibm.com, npiggin@gmail.com, clg@kaod.org, calebs@us.ibm.com, 
 chalapathi.v@ibm.com, chalapathi.v@linux.ibm.com,
 saif.abrar@linux.vnet.ibm.com, dantan@us.ibm.com
Date: Fri, 17 May 2024 14:26:34 -0500
In-Reply-To: <20240516163304.25191-5-chalapathi.v@linux.ibm.com>
References: <20240516163304.25191-1-chalapathi.v@linux.ibm.com>
 <20240516163304.25191-5-chalapathi.v@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: V4litPncN5a7X5RdQYY6f7pUNsjehKJA
X-Proofpoint-GUID: 8RVVImiYe5aK-v-xlHZYwqmHf72nr7Cf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-17_09,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 mlxlogscore=782
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405170150
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

-Glenn

On Thu, 2024-05-16 at 11:33 -0500, Chalapathi V wrote:
> In this commit, create SPI controller on p10 chip and connect cs irq.
> 
> The QOM tree of spi controller and seeprom are.
> /machine (powernv10-machine)
>   /chip[0] (power10_v2.0-pnv-chip)
>     /pib_spic[2] (pnv-spi-controller)
>       /pnv-spi-bus.2 (SSI)
>       /xscom-spi-controller-regs[0] (memory-region)
> 
> /machine (powernv10-machine)
>   /peripheral-anon (container)
>     /device[0] (25csm04)
>       /WP#[0] (irq)
>       /ssi-gpio-cs[0] (irq)
> 
> (qemu) qom-get /machine/peripheral-anon /device[76] "parent_bus"
> "/machine/chip[0]/pib_spic[2]/pnv-spi-bus.2"
> 
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> ---
>  include/hw/ppc/pnv_chip.h   |  3 +++
>  hw/ppc/pnv.c                | 21 ++++++++++++++++++++-
>  hw/ppc/pnv_spi_controller.c |  8 ++++++++
>  3 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
> index 8589f3291e..d464858f79 100644
> --- a/include/hw/ppc/pnv_chip.h
> +++ b/include/hw/ppc/pnv_chip.h
> @@ -6,6 +6,7 @@
>  #include "hw/ppc/pnv_core.h"
>  #include "hw/ppc/pnv_homer.h"
>  #include "hw/ppc/pnv_n1_chiplet.h"
> +#include "hw/ssi/pnv_spi.h"
>  #include "hw/ppc/pnv_lpc.h"
>  #include "hw/ppc/pnv_occ.h"
>  #include "hw/ppc/pnv_psi.h"
> @@ -118,6 +119,8 @@ struct Pnv10Chip {
>      PnvSBE       sbe;
>      PnvHomer     homer;
>      PnvN1Chiplet     n1_chiplet;
> +#define PNV10_CHIP_MAX_PIB_SPIC 6
> +    PnvSpiController pib_spic[PNV10_CHIP_MAX_PIB_SPIC];
>  
>      uint32_t     nr_quads;
>      PnvQuad      *quads;
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 6e3a5ccdec..6850592a85 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1829,6 +1829,11 @@ static void
> pnv_chip_power10_instance_init(Object *obj)
>      for (i = 0; i < pcc->i2c_num_engines; i++) {
>          object_initialize_child(obj, "i2c[*]", &chip10->i2c[i],
> TYPE_PNV_I2C);
>      }
> +
> +    for (i = 0; i < PNV10_CHIP_MAX_PIB_SPIC ; i++) {
> +        object_initialize_child(obj, "pib_spic[*]", &chip10-
> >pib_spic[i],
> +                                TYPE_PNV_SPI_CONTROLLER);
> +    }
>  }
>  
>  static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error
> **errp)
> @@ -2043,7 +2048,21 @@ static void
> pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>                                qdev_get_gpio_in(DEVICE(&chip10->psi),
>                                                 PSIHB9_IRQ_SBE_I2C));
>      }
> -
> +    /* PIB SPI Controller */
> +    for (i = 0; i < PNV10_CHIP_MAX_PIB_SPIC; i++) {
> +        object_property_set_int(OBJECT(&chip10->pib_spic[i]),
> "spic_num",
> +                                i, &error_fatal);
> +        /* pib_spic[2] connected to 25csm04 which implements 1 byte
> transfer */
> +        object_property_set_int(OBJECT(&chip10->pib_spic[i]),
> "transfer_len",
> +                                (i == 2) ? 1 : 4, &error_fatal);
> +        if (!sysbus_realize(SYS_BUS_DEVICE(OBJECT
> +                                        (&chip10->pib_spic[i])),
> errp)) {
> +            return;
> +        }
> +        pnv_xscom_add_subregion(chip, PNV10_XSCOM_PIB_SPIC_BASE +
> +                                i * PNV10_XSCOM_PIB_SPIC_SIZE,
> +                                &chip10-
> >pib_spic[i].xscom_spic_regs);
> +    }
>  }
>  
>  static void pnv_rainier_i2c_init(PnvMachineState *pnv)
> diff --git a/hw/ppc/pnv_spi_controller.c
> b/hw/ppc/pnv_spi_controller.c
> index e87f583074..3d47e932de 100644
> --- a/hw/ppc/pnv_spi_controller.c
> +++ b/hw/ppc/pnv_spi_controller.c
> @@ -1067,9 +1067,17 @@ static void
> operation_sequencer(PnvSpiController *s)
>  static void do_reset(DeviceState *dev)
>  {
>      PnvSpiController *s = PNV_SPICONTROLLER(dev);
> +    DeviceState *ssi_dev;
>  
>      trace_pnv_spi_reset();
>  
> +    /* Connect cs irq */
> +    ssi_dev = ssi_get_cs(s->ssi_bus, 0);
> +    if (ssi_dev) {
> +        qemu_irq cs_line = qdev_get_gpio_in_named(ssi_dev,
> SSI_GPIO_CS, 0);
> +        qdev_connect_gpio_out_named(DEVICE(s), "cs", 0, cs_line);
> +    }
> +
>      /* Reset all N1 and N2 counters, and other constants */
>      s->N2_bits = 0;
>      s->N2_bytes = 0;


