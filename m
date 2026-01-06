Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A14CE9D7F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 16:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdA8F-0000is-Er; Tue, 06 Jan 2026 11:42:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vdA8C-0000dj-5Q; Tue, 06 Jan 2026 11:42:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vdA89-0007L6-Uf; Tue, 06 Jan 2026 11:42:03 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 606GM0S4015376;
 Tue, 6 Jan 2026 16:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=G6IYTBY+mpI7dnn2sfx4bzoHUtpeUbQWMeiIEUUq5us=; b=jWxl6Q8NmtWO
 GIHQLSUhzPwazd3MK74g1PyprRCBc6PmZJM4cI2JFClaTJohq1lU/FqzDkyC2msM
 a1/hrCBX9dPSf+azv/eLGrm4kCOEm0+y7/qU0euk1tT/IPGS71NuwGGdjrXTUMCt
 bbeUmpv/QxCPYfLGtNO4CUyXwAOhtLvOSUNeOAmDbaX8H6WHwNDMsRwGkDyukys/
 Pu2/+3RcPiWa9zbLbsOFvXb1lCARJiojhuaxjdiRUG09PMy9KkCO2CbbK7JJs3nH
 TgNi0dEtuevpTBda7OfKb17nlZDseP8wWFzckNo1K107Gq5ajniBRZodqSV4aoJC
 ktwCywaq6g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtkyaw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 16:41:59 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 606GbBqS016861;
 Tue, 6 Jan 2026 16:41:58 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtkyat-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 16:41:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 606GDYOC014496;
 Tue, 6 Jan 2026 16:41:58 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfeemvenf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 16:41:58 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 606GfunO29295194
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Jan 2026 16:41:56 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 90FAA58054;
 Tue,  6 Jan 2026 16:41:56 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE55B58045;
 Tue,  6 Jan 2026 16:41:55 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Jan 2026 16:41:55 +0000 (GMT)
Message-ID: <f2ef8c18ae5b725dc7d75ad0c9e3db59638958e8.camel@linux.ibm.com>
Subject: Re: [PATCH] ppc/pnv: Add a nest MMU model
From: Miles Glenn <milesg@linux.ibm.com>
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 rathc@linux.ibm.com, fbarrat@linux.ibm.com, chalapathi.v@linux.ibm.com
Date: Tue, 06 Jan 2026 10:41:55 -0600
In-Reply-To: <20251223145919.2540097-1-calebs@linux.ibm.com>
References: <20251223145919.2540097-1-calebs@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=aaJsXBot c=1 sm=1 tr=0 ts=695d3b57 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=gM0zXL-81yXsbAeTnIgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: D9LT0UTVlRV099BPfHU6IwtEvzdE0KwO
X-Proofpoint-ORIG-GUID: lgXl53gNRUS2CBda02hQjL2aXHhFpKWc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE0MSBTYWx0ZWRfX/HNWf1/ikyGd
 mH3NZXeDwrh+2UL9X4XCB3GFk+rlyeqh1zpvx/JEmd3xD1DSMQAZovPdICsFVXGDBibbdhYC8qx
 S4xy84EzMwdZqLZErlI/6eGICobh0K5aYJ9ZkVQQWTIUPxBsJGhXjqzB2UYFuo7aJqbErfYyvjK
 TblAb8WlOtXuX2Y5UjQFF75snNlzm3S0XWWXHZ+tVgsEB5LnnXnCxpzENbMnDA8xqT9m8OR9C6Y
 YsJKJX6PBrydroGAJLVwzWqitGl0IFpeN70LrYNGN++sSG2g5e6rvZf0K6FWg6DcW/KjwXZs2ub
 56r6r+FPs/V3fIITNiFchBS0LhFkUzxq5gvqNypwb5jb2do4JLO1/j52Lbr16f2faf+fmv0gQLn
 AXyBLysrzNpVgOSX8kDOYFx0PPYLgUjhsYpkdDz+U1tyTpfKppjCp+mFi7FSlWDUcqBe88Q/dL/
 rkUVR4HFAqgkeps4l3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601060141
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Tue, 2025-12-23 at 08:59 -0600, Caleb Schlossin wrote:
> The nest MMU is used for translations needed by I/O subsystems
> on Power10. The nest is the shared, on-chip infrastructure
> that connects CPU cores, memory controllers, and I/O.
> 
> This patch sets up a basic skeleton with its xscom
> area, mapping both needed xscom regions. Support required
> for PowerVM bringup.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
> ---
>  hw/ppc/meson.build         |   1 +
>  hw/ppc/pnv.c               |  20 ++++++
>  hw/ppc/pnv_nmmu.c          | 132 +++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/pnv_chip.h  |   3 +
>  include/hw/ppc/pnv_nmmu.h  |  28 ++++++++
>  include/hw/ppc/pnv_xscom.h |   4 ++
>  6 files changed, 188 insertions(+)
>  create mode 100644 hw/ppc/pnv_nmmu.c
>  create mode 100644 include/hw/ppc/pnv_nmmu.h
> 
> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
> index f7dac87a2a..69e2fc34c4 100644
> --- a/hw/ppc/meson.build
> +++ b/hw/ppc/meson.build
> @@ -56,6 +56,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
>    'pnv_pnor.c',
>    'pnv_nest_pervasive.c',
>    'pnv_n1_chiplet.c',
> +  'pnv_nmmu.c'
>  ))
>  # PowerPC 4xx boards
>  ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 895132da91..8d24570607 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -2195,6 +2195,11 @@ static void pnv_chip_power10_instance_init(Object *obj)
>                                  TYPE_PNV_PHB5_PEC);
>      }
>  
> +    for (i = 0; i < PNV10_CHIP_MAX_NMMU; i++) {
> +        object_initialize_child(obj, "nmmu[*]", &chip10->nmmu[i],
> +                                TYPE_PNV_NMMU);
> +    }
> +
>      for (i = 0; i < pcc->i2c_num_engines; i++) {
>          object_initialize_child(obj, "i2c[*]", &chip10->i2c[i], TYPE_PNV_I2C);
>      }
> @@ -2409,6 +2414,21 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>      pnv_xscom_add_subregion(chip, PNV10_XSCOM_N1_PB_SCOM_ES_BASE,
>                             &chip10->n1_chiplet.xscom_pb_es_mr);
>  
> +    /* nest0/1 MMU */
> +    for (i = 0; i < PNV10_CHIP_MAX_NMMU; i++) {
> +        object_property_set_int(OBJECT(&chip10->nmmu[i]), "nmmu_id",
> +                                i , &error_fatal);
> +        object_property_set_link(OBJECT(&chip10->nmmu[i]), "chip",
> +                                 OBJECT(chip), &error_abort);
> +        if (!qdev_realize(DEVICE(&chip10->nmmu[i]), NULL, errp)) {
> +            return;
> +        }
> +    }
> +    pnv_xscom_add_subregion(chip, PNV10_XSCOM_NEST0_MMU_BASE,
> +                            &chip10->nmmu[0].xscom_regs);
> +    pnv_xscom_add_subregion(chip, PNV10_XSCOM_NEST1_MMU_BASE,
> +                            &chip10->nmmu[1].xscom_regs);
> +
>      /* PHBs */
>      pnv_chip_power10_phb_realize(chip, &local_err);
>      if (local_err) {
> diff --git a/hw/ppc/pnv_nmmu.c b/hw/ppc/pnv_nmmu.c
> new file mode 100644
> index 0000000000..37c739b242
> --- /dev/null
> +++ b/hw/ppc/pnv_nmmu.c
> @@ -0,0 +1,132 @@
> +/*
> + * QEMU PowerPC nest MMU model
> + *
> + * Copyright (c) 2025, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/qdev-properties.h"
> +
> +#include "hw/ppc/pnv.h"
> +#include "hw/ppc/pnv_xscom.h"
> +#include "hw/ppc/pnv_nmmu.h"
> +#include "hw/ppc/fdt.h"
> +
> +#include <libfdt.h>
> +
> +#define NMMU_XLAT_CTL_PTCR 0xb
> +
> +static uint64_t pnv_nmmu_xscom_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    PnvNMMU *nmmu = PNV_NMMU(opaque);
> +    int reg = addr >> 3;
> +    uint64_t val;
> +
> +    if (reg == NMMU_XLAT_CTL_PTCR) {
> +        val = nmmu->ptcr;
> +    } else {
> +        val = 0xffffffffffffffffull;
> +        qemu_log_mask(LOG_UNIMP, "nMMU: xscom read at 0x%" PRIx32 "\n", reg);
> +    }
> +    return val;
> +}
> +
> +static void pnv_nmmu_xscom_write(void *opaque, hwaddr addr,
> +                                 uint64_t val, unsigned size)
> +{
> +    PnvNMMU *nmmu = PNV_NMMU(opaque);
> +    int reg = addr >> 3;
> +
> +    if (reg == NMMU_XLAT_CTL_PTCR) {
> +        nmmu->ptcr = val;
> +    } else {
> +        qemu_log_mask(LOG_UNIMP, "nMMU: xscom write at 0x%" PRIx32 "\n", reg);
> +    }
> +}
> +
> +static const MemoryRegionOps pnv_nmmu_xscom_ops = {
> +    .read = pnv_nmmu_xscom_read,
> +    .write = pnv_nmmu_xscom_write,
> +    .valid.min_access_size = 8,
> +    .valid.max_access_size = 8,
> +    .impl.min_access_size = 8,
> +    .impl.max_access_size = 8,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +};
> +
> +static void pnv_nmmu_realize(DeviceState *dev, Error **errp)
> +{
> +    PnvNMMU *nmmu = PNV_NMMU(dev);
> +
> +    assert(nmmu->chip);
> +
> +    /* NMMU xscom region */
> +    pnv_xscom_region_init(&nmmu->xscom_regs, OBJECT(nmmu),
> +                          &pnv_nmmu_xscom_ops, nmmu,
> +                          "xscom-nmmu",
> +                          PNV10_XSCOM_NMMU_SIZE);
> +}
> +
> +static int pnv_nmmu_dt_xscom(PnvXScomInterface *dev, void *fdt,
> +                             int offset)
> +{
> +    PnvNMMU *nmmu = PNV_NMMU(dev);
> +    char *name;
> +    int nmmu_offset;
> +    const char compat[] = "ibm,power10-nest-mmu";
> +    uint32_t nmmu_pcba = PNV10_XSCOM_NEST0_MMU_BASE + nmmu->nmmu_id * 0x1000000;
> +    uint32_t reg[2] = {
> +        cpu_to_be32(nmmu_pcba),
> +        cpu_to_be32(PNV10_XSCOM_NMMU_SIZE)
> +    };
> +
> +    name = g_strdup_printf("nmmu@%x", nmmu_pcba);
> +    nmmu_offset = fdt_add_subnode(fdt, offset, name);
> +    _FDT(nmmu_offset);
> +    g_free(name);
> +
> +    _FDT(fdt_setprop(fdt, nmmu_offset, "reg", reg, sizeof(reg)));
> +    _FDT(fdt_setprop(fdt, nmmu_offset, "compatible", compat, sizeof(compat)));
> +    return 0;
> +}
> +
> +static const Property pnv_nmmu_properties[] = {
> +    DEFINE_PROP_UINT32("nmmu_id", PnvNMMU, nmmu_id, 0),
> +    DEFINE_PROP_LINK("chip", PnvNMMU, chip, TYPE_PNV_CHIP, PnvChip *),
> +};
> +
> +static void pnv_nmmu_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PnvXScomInterfaceClass *xscomc = PNV_XSCOM_INTERFACE_CLASS(klass);
> +
> +    xscomc->dt_xscom = pnv_nmmu_dt_xscom;
> +
> +    dc->desc = "PowerNV nest MMU";
> +    dc->realize = pnv_nmmu_realize;
> +    device_class_set_props(dc, pnv_nmmu_properties);
> +}
> +
> +static const TypeInfo pnv_nmmu_info = {
> +    .name          = TYPE_PNV_NMMU,
> +    .parent        = TYPE_DEVICE,
> +    .instance_size = sizeof(PnvNMMU),
> +    .class_init    = pnv_nmmu_class_init,
> +    .interfaces    = (InterfaceInfo[]) {
> +        { TYPE_PNV_XSCOM_INTERFACE },
> +        { }
> +    }
> +};
> +
> +static void pnv_nmmu_register_types(void)
> +{
> +    type_register_static(&pnv_nmmu_info);
> +}
> +
> +type_init(pnv_nmmu_register_types);
> diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
> index a5b8c49680..b6382407c9 100644
> --- a/include/hw/ppc/pnv_chip.h
> +++ b/include/hw/ppc/pnv_chip.h
> @@ -7,6 +7,7 @@
>  #include "hw/ppc/pnv_core.h"
>  #include "hw/ppc/pnv_homer.h"
>  #include "hw/ppc/pnv_n1_chiplet.h"
> +#include "hw/ppc/pnv_nmmu.h"
>  #include "hw/ssi/pnv_spi.h"
>  #include "hw/ppc/pnv_lpc.h"
>  #include "hw/ppc/pnv_occ.h"
> @@ -126,6 +127,8 @@ struct Pnv10Chip {
>      PnvN1Chiplet     n1_chiplet;
>  #define PNV10_CHIP_MAX_PIB_SPIC 6
>      PnvSpi pib_spic[PNV10_CHIP_MAX_PIB_SPIC];
> +#define PNV10_CHIP_MAX_NMMU 2
> +    PnvNMMU      nmmu[PNV10_CHIP_MAX_NMMU];
>  
>      uint32_t     nr_quads;
>      PnvQuad      *quads;
> diff --git a/include/hw/ppc/pnv_nmmu.h b/include/hw/ppc/pnv_nmmu.h
> new file mode 100644
> index 0000000000..d3ba46ecf4
> --- /dev/null
> +++ b/include/hw/ppc/pnv_nmmu.h
> @@ -0,0 +1,28 @@
> +/*
> + * QEMU PowerPC nest MMU model
> + *
> + * Copyright (c) 2025, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + */
> +
> +#ifndef PPC_PNV_NMMU_H
> +#define PPC_PNV_NMMU_H
> +
> +#define TYPE_PNV_NMMU "pnv-nmmu"
> +#define PNV_NMMU(obj) OBJECT_CHECK(PnvNMMU, (obj), TYPE_PNV_NMMU)
> +
> +typedef struct PnvNMMU {
> +    DeviceState parent;
> +
> +    struct PnvChip *chip;
> +
> +    MemoryRegion xscom_regs;
> +    uint32_t nmmu_id;
> +    uint64_t ptcr;
> +} PnvNMMU;
> +
> +#endif /*PPC_PNV_NMMU_H */
> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
> index 610b075a27..6dab803d1f 100644
> --- a/include/hw/ppc/pnv_xscom.h
> +++ b/include/hw/ppc/pnv_xscom.h
> @@ -196,6 +196,10 @@ struct PnvXScomInterfaceClass {
>  #define PNV10_XSCOM_N1_PB_SCOM_ES_BASE      0x3011300
>  #define PNV10_XSCOM_N1_PB_SCOM_ES_SIZE      0x100
>  
> +#define PNV10_XSCOM_NEST0_MMU_BASE      0x2010c40
> +#define PNV10_XSCOM_NEST1_MMU_BASE      0x3010c40
> +#define PNV10_XSCOM_NMMU_SIZE      0x20
> +
>  #define PNV10_XSCOM_PEC_NEST_BASE  0x3011800 /* index goes downwards ... */
>  #define PNV10_XSCOM_PEC_NEST_SIZE  0x100
>  


