Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C888E6FE23
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 17:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY62X-0004v2-9K; Tue, 23 Dec 2025 12:19:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@inux.ibm.com>)
 id 1vY62U-0004u8-C2; Tue, 23 Dec 2025 12:19:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@inux.ibm.com>)
 id 1vY62R-0006gg-Lx; Tue, 23 Dec 2025 12:19:13 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BNGNE9L004476;
 Tue, 23 Dec 2025 17:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=05PCs0oRBY6PI7wwfCGG9QqsCWIJtz
 XemdxUl2vXbZo=; b=BVbgvOffEPhNj7K5ZQ44oC1Bo+AqIC0OCyWwFB+61YlsCm
 WX9aJ/amryRXhnNfFlO5mhF5lEJgWM0H5DgftwZZ266cGWs1xxu+GzDrlWbe9Lpl
 eF4nCv99lXfQz/g+DrmmdNSea5llsGvRWTUoIZFozZxT5WGbA9nlr467RkJ1T9uk
 4XimcsuEFIIBrZEIdBFskdMJiNUcqR9BjxX59Rfy2hS5iFExRNHjswiZyJwcxDZb
 NyP9X8RFdgbPHOZcEo5CRJlv5yHGmPstnmOl8GgdGwFgC6KiYh9APrSIpF+caiFD
 3xKwKmhfrIxkn1OwlyvJIt+yZaRZ3lMl31t+AYqQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5ketwcvh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Dec 2025 17:19:09 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BNHBtVk006331;
 Tue, 23 Dec 2025 17:19:09 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5ketwcve-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Dec 2025 17:19:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BNH8KP2030352;
 Tue, 23 Dec 2025 17:19:08 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b66gxvdag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Dec 2025 17:19:08 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BNHIoHr25625286
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Dec 2025 17:18:50 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E17BA58053;
 Tue, 23 Dec 2025 17:19:06 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 480155805F;
 Tue, 23 Dec 2025 17:19:03 +0000 (GMT)
Received: from [9.43.4.97] (unknown [9.43.4.97])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Dec 2025 17:19:02 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------ZFskvR0oGTL0PkwuFZLN7fEx"
Message-ID: <1d42d1b2-a88f-417a-91fe-c585119eced0@inux.ibm.com>
Date: Tue, 23 Dec 2025 22:49:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/pnv: Add a nest MMU model
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, rathc@linux.ibm.com, fbarrat@linux.ibm.com,
 chalapathi.v@linux.ibm.com
References: <20251223145919.2540097-1-calebs@linux.ibm.com>
Content-Language: en-US
From: Chalapathi V <chalapathi.v@inux.ibm.com>
In-Reply-To: <20251223145919.2540097-1-calebs@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xFgcbFwnS30YeVRcKZBnPu2mnZ-K4-WZ
X-Authority-Analysis: v=2.4 cv=Qdxrf8bv c=1 sm=1 tr=0 ts=694acf0d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=VnNF1IyMAAAA:8 a=gM0zXL-81yXsbAeTnIgA:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
 a=r03UDPAKYrhx904b1scA:9 a=xb7swxq1s-UOHf8K:21 a=_W_S_7VecoQA:10
X-Proofpoint-ORIG-GUID: sD8_ku_BMaklQOfBspJZoGQ_tUq9Z_L-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDE0MyBTYWx0ZWRfX+r0lqJSDhL3L
 BvtDLivFx6m7lHr9HKuLglGbMXiCavpHoB31gZdocxVvMXh7KoBfkf2y/1887UdXQQwNlMBWyWg
 BNzF5NwUf+nR9i6uipCsLw3ZJhiqcG4jGVkZVCM1UA+2NvgsKjWPUSC0eooPl/E4qBTIiS/Ss4p
 Q7uN4oNG2RZypJ1ssuZwaxWLbqg3Df2Mru8yBC2eQ+h6z32Aw3AsrcFvhLwNI0suue607fZaYvG
 3DTcrFXG43gTyQKWqbpc2KU6v53JhthCTAkjYpJilF7oGsUMLfSoK6P1MdoJMo+s0Lj0iu8FExq
 BSChxlyCBuwSJBblGfudJnyn9zjvE66gXvJlxUMCSES33l1sj3UtHyqoOX7p88J1ivhsvgdk2aw
 hafeIGnc8giRsZNhmfEOUQV53Rh3J5K+tfmStHHTZscFeaDvX/Vr/BgqfImmykq+Iz27UzbLKIr
 5vQjQkS6SKed9D9QkyQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_04,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1034
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512230143
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=chalapathi.v@inux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------ZFskvR0oGTL0PkwuFZLN7fEx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Chalapathi V <chalapathi.v@linux.ibm.com> 
<mailto:milesg@linux.ibm.com>


Thank You,

Chalapathi

On 23/12/25 8:29 pm, Caleb Schlossin wrote:
> The nest MMU is used for translations needed by I/O subsystems
> on Power10. The nest is the shared, on-chip infrastructure
> that connects CPU cores, memory controllers, and I/O.
>
> This patch sets up a basic skeleton with its xscom
> area, mapping both needed xscom regions. Support required
> for PowerVM bringup.
>
> Signed-off-by: Frederic Barrat<fbarrat@linux.ibm.com>
> Signed-off-by: Chalapathi V<chalapathi.v@linux.ibm.com>
> Signed-off-by: Caleb Schlossin<calebs@linux.ibm.com>
> ---
>   hw/ppc/meson.build         |   1 +
>   hw/ppc/pnv.c               |  20 ++++++
>   hw/ppc/pnv_nmmu.c          | 132 +++++++++++++++++++++++++++++++++++++
>   include/hw/ppc/pnv_chip.h  |   3 +
>   include/hw/ppc/pnv_nmmu.h  |  28 ++++++++
>   include/hw/ppc/pnv_xscom.h |   4 ++
>   6 files changed, 188 insertions(+)
>   create mode 100644 hw/ppc/pnv_nmmu.c
>   create mode 100644 include/hw/ppc/pnv_nmmu.h
>
> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
> index f7dac87a2a..69e2fc34c4 100644
> --- a/hw/ppc/meson.build
> +++ b/hw/ppc/meson.build
> @@ -56,6 +56,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
>     'pnv_pnor.c',
>     'pnv_nest_pervasive.c',
>     'pnv_n1_chiplet.c',
> +  'pnv_nmmu.c'
>   ))
>   # PowerPC 4xx boards
>   ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 895132da91..8d24570607 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -2195,6 +2195,11 @@ static void pnv_chip_power10_instance_init(Object *obj)
>                                   TYPE_PNV_PHB5_PEC);
>       }
>   
> +    for (i = 0; i < PNV10_CHIP_MAX_NMMU; i++) {
> +        object_initialize_child(obj, "nmmu[*]", &chip10->nmmu[i],
> +                                TYPE_PNV_NMMU);
> +    }
> +
>       for (i = 0; i < pcc->i2c_num_engines; i++) {
>           object_initialize_child(obj, "i2c[*]", &chip10->i2c[i], TYPE_PNV_I2C);
>       }
> @@ -2409,6 +2414,21 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>       pnv_xscom_add_subregion(chip, PNV10_XSCOM_N1_PB_SCOM_ES_BASE,
>                              &chip10->n1_chiplet.xscom_pb_es_mr);
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
>       /* PHBs */
>       pnv_chip_power10_phb_realize(chip, &local_err);
>       if (local_err) {
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
>   #include "hw/ppc/pnv_core.h"
>   #include "hw/ppc/pnv_homer.h"
>   #include "hw/ppc/pnv_n1_chiplet.h"
> +#include "hw/ppc/pnv_nmmu.h"
>   #include "hw/ssi/pnv_spi.h"
>   #include "hw/ppc/pnv_lpc.h"
>   #include "hw/ppc/pnv_occ.h" @@ -126,6 +127,8 @@ struct Pnv10Chip { PnvN1Chiplet n1_chiplet; 
> #define PNV10_CHIP_MAX_PIB_SPIC 6 PnvSpi 
> pib_spic[PNV10_CHIP_MAX_PIB_SPIC]; +#define PNV10_CHIP_MAX_NMMU 2 + 
> PnvNMMU nmmu[PNV10_CHIP_MAX_NMMU]; uint32_t nr_quads; PnvQuad *quads; 
> diff --git a/include/hw/ppc/pnv_nmmu.h b/include/hw/ppc/pnv_nmmu.h new 
> file mode 100644 index 0000000000..d3ba46ecf4 --- /dev/null +++ 
> b/include/hw/ppc/pnv_nmmu.h @@ -0,0 +1,28 @@ +/* + * QEMU PowerPC nest 
> MMU model + * + * Copyright (c) 2025, IBM Corporation. + * + * 
> SPDX-License-Identifier: GPL-2.0-or-later + * + * This code is 
> licensed under the GPL version 2 or later. See the + * COPYING file in 
> the top-level directory. + */ + +#ifndef PPC_PNV_NMMU_H +#define 
> PPC_PNV_NMMU_H + +#define TYPE_PNV_NMMU "pnv-nmmu"
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
>   #define PNV10_XSCOM_N1_PB_SCOM_ES_BASE      0x3011300
>   #define PNV10_XSCOM_N1_PB_SCOM_ES_SIZE      0x100
>   
> +#define PNV10_XSCOM_NEST0_MMU_BASE      0x2010c40
> +#define PNV10_XSCOM_NEST1_MMU_BASE      0x3010c40
> +#define PNV10_XSCOM_NMMU_SIZE      0x20
> +
>   #define PNV10_XSCOM_PEC_NEST_BASE  0x3011800 /* index goes downwards ... */
>   #define PNV10_XSCOM_PEC_NEST_SIZE  0x100
>   
--------------ZFskvR0oGTL0PkwuFZLN7fEx
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>
    </p>
    <p style="margin:0in;font-family:Calibri;font-size:11.0pt"
      lang="en-US">Reviewed-by:
      Chalapathi V <a href="mailto:milesg@linux.ibm.com">&lt;chalapathi.v@linux.ibm.com&gt;</a></p>
    <p style="margin:0in;font-family:Calibri;font-size:11.0pt"
      lang="en-US"><br>
    </p>
    <p style="margin:0in;font-family:Calibri;font-size:11.0pt"
      lang="en-US">Thank You,</p>
    <p style="margin:0in;font-family:Calibri;font-size:11.0pt"
      lang="en-US">Chalapathi</p>
    <div class="moz-cite-prefix">On 23/12/25 8:29 pm, Caleb Schlossin
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20251223145919.2540097-1-calebs@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">The nest MMU is used for translations needed by I/O subsystems
on Power10. The nest is the shared, on-chip infrastructure
that connects CPU cores, memory controllers, and I/O.

This patch sets up a basic skeleton with its xscom
area, mapping both needed xscom regions. Support required
for PowerVM bringup.

Signed-off-by: Frederic Barrat <a class="moz-txt-link-rfc2396E" href="mailto:fbarrat@linux.ibm.com">&lt;fbarrat@linux.ibm.com&gt;</a>
Signed-off-by: Chalapathi V <a class="moz-txt-link-rfc2396E" href="mailto:chalapathi.v@linux.ibm.com">&lt;chalapathi.v@linux.ibm.com&gt;</a>
Signed-off-by: Caleb Schlossin <a class="moz-txt-link-rfc2396E" href="mailto:calebs@linux.ibm.com">&lt;calebs@linux.ibm.com&gt;</a>
---
 hw/ppc/meson.build         |   1 +
 hw/ppc/pnv.c               |  20 ++++++
 hw/ppc/pnv_nmmu.c          | 132 +++++++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv_chip.h  |   3 +
 include/hw/ppc/pnv_nmmu.h  |  28 ++++++++
 include/hw/ppc/pnv_xscom.h |   4 ++
 6 files changed, 188 insertions(+)
 create mode 100644 hw/ppc/pnv_nmmu.c
 create mode 100644 include/hw/ppc/pnv_nmmu.h

diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index f7dac87a2a..69e2fc34c4 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -56,6 +56,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
   'pnv_pnor.c',
   'pnv_nest_pervasive.c',
   'pnv_n1_chiplet.c',
+  'pnv_nmmu.c'
 ))
 # PowerPC 4xx boards
 ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 895132da91..8d24570607 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2195,6 +2195,11 @@ static void pnv_chip_power10_instance_init(Object *obj)
                                 TYPE_PNV_PHB5_PEC);
     }
 
+    for (i = 0; i &lt; PNV10_CHIP_MAX_NMMU; i++) {
+        object_initialize_child(obj, "nmmu[*]", &amp;chip10-&gt;nmmu[i],
+                                TYPE_PNV_NMMU);
+    }
+
     for (i = 0; i &lt; pcc-&gt;i2c_num_engines; i++) {
         object_initialize_child(obj, "i2c[*]", &amp;chip10-&gt;i2c[i], TYPE_PNV_I2C);
     }
@@ -2409,6 +2414,21 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     pnv_xscom_add_subregion(chip, PNV10_XSCOM_N1_PB_SCOM_ES_BASE,
                            &amp;chip10-&gt;n1_chiplet.xscom_pb_es_mr);
 
+    /* nest0/1 MMU */
+    for (i = 0; i &lt; PNV10_CHIP_MAX_NMMU; i++) {
+        object_property_set_int(OBJECT(&amp;chip10-&gt;nmmu[i]), "nmmu_id",
+                                i , &amp;error_fatal);
+        object_property_set_link(OBJECT(&amp;chip10-&gt;nmmu[i]), "chip",
+                                 OBJECT(chip), &amp;error_abort);
+        if (!qdev_realize(DEVICE(&amp;chip10-&gt;nmmu[i]), NULL, errp)) {
+            return;
+        }
+    }
+    pnv_xscom_add_subregion(chip, PNV10_XSCOM_NEST0_MMU_BASE,
+                            &amp;chip10-&gt;nmmu[0].xscom_regs);
+    pnv_xscom_add_subregion(chip, PNV10_XSCOM_NEST1_MMU_BASE,
+                            &amp;chip10-&gt;nmmu[1].xscom_regs);
+
     /* PHBs */
     pnv_chip_power10_phb_realize(chip, &amp;local_err);
     if (local_err) {
diff --git a/hw/ppc/pnv_nmmu.c b/hw/ppc/pnv_nmmu.c
new file mode 100644
index 0000000000..37c739b242
--- /dev/null
+++ b/hw/ppc/pnv_nmmu.c
@@ -0,0 +1,132 @@
+/*
+ * QEMU PowerPC nest MMU model
+ *
+ * Copyright (c) 2025, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/qdev-properties.h"
+
+#include "hw/ppc/pnv.h"
+#include "hw/ppc/pnv_xscom.h"
+#include "hw/ppc/pnv_nmmu.h"
+#include "hw/ppc/fdt.h"
+
+#include &lt;libfdt.h&gt;
+
+#define NMMU_XLAT_CTL_PTCR 0xb
+
+static uint64_t pnv_nmmu_xscom_read(void *opaque, hwaddr addr, unsigned size)
+{
+    PnvNMMU *nmmu = PNV_NMMU(opaque);
+    int reg = addr &gt;&gt; 3;
+    uint64_t val;
+
+    if (reg == NMMU_XLAT_CTL_PTCR) {
+        val = nmmu-&gt;ptcr;
+    } else {
+        val = 0xffffffffffffffffull;
+        qemu_log_mask(LOG_UNIMP, "nMMU: xscom read at 0x%" PRIx32 "\n", reg);
+    }
+    return val;
+}
+
+static void pnv_nmmu_xscom_write(void *opaque, hwaddr addr,
+                                 uint64_t val, unsigned size)
+{
+    PnvNMMU *nmmu = PNV_NMMU(opaque);
+    int reg = addr &gt;&gt; 3;
+
+    if (reg == NMMU_XLAT_CTL_PTCR) {
+        nmmu-&gt;ptcr = val;
+    } else {
+        qemu_log_mask(LOG_UNIMP, "nMMU: xscom write at 0x%" PRIx32 "\n", reg);
+    }
+}
+
+static const MemoryRegionOps pnv_nmmu_xscom_ops = {
+    .read = pnv_nmmu_xscom_read,
+    .write = pnv_nmmu_xscom_write,
+    .valid.min_access_size = 8,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 8,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void pnv_nmmu_realize(DeviceState *dev, Error **errp)
+{
+    PnvNMMU *nmmu = PNV_NMMU(dev);
+
+    assert(nmmu-&gt;chip);
+
+    /* NMMU xscom region */
+    pnv_xscom_region_init(&amp;nmmu-&gt;xscom_regs, OBJECT(nmmu),
+                          &amp;pnv_nmmu_xscom_ops, nmmu,
+                          "xscom-nmmu",
+                          PNV10_XSCOM_NMMU_SIZE);
+}
+
+static int pnv_nmmu_dt_xscom(PnvXScomInterface *dev, void *fdt,
+                             int offset)
+{
+    PnvNMMU *nmmu = PNV_NMMU(dev);
+    char *name;
+    int nmmu_offset;
+    const char compat[] = "ibm,power10-nest-mmu";
+    uint32_t nmmu_pcba = PNV10_XSCOM_NEST0_MMU_BASE + nmmu-&gt;nmmu_id * 0x1000000;
+    uint32_t reg[2] = {
+        cpu_to_be32(nmmu_pcba),
+        cpu_to_be32(PNV10_XSCOM_NMMU_SIZE)
+    };
+
+    name = g_strdup_printf("nmmu@%x", nmmu_pcba);
+    nmmu_offset = fdt_add_subnode(fdt, offset, name);
+    _FDT(nmmu_offset);
+    g_free(name);
+
+    _FDT(fdt_setprop(fdt, nmmu_offset, "reg", reg, sizeof(reg)));
+    _FDT(fdt_setprop(fdt, nmmu_offset, "compatible", compat, sizeof(compat)));
+    return 0;
+}
+
+static const Property pnv_nmmu_properties[] = {
+    DEFINE_PROP_UINT32("nmmu_id", PnvNMMU, nmmu_id, 0),
+    DEFINE_PROP_LINK("chip", PnvNMMU, chip, TYPE_PNV_CHIP, PnvChip *),
+};
+
+static void pnv_nmmu_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PnvXScomInterfaceClass *xscomc = PNV_XSCOM_INTERFACE_CLASS(klass);
+
+    xscomc-&gt;dt_xscom = pnv_nmmu_dt_xscom;
+
+    dc-&gt;desc = "PowerNV nest MMU";
+    dc-&gt;realize = pnv_nmmu_realize;
+    device_class_set_props(dc, pnv_nmmu_properties);
+}
+
+static const TypeInfo pnv_nmmu_info = {
+    .name          = TYPE_PNV_NMMU,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(PnvNMMU),
+    .class_init    = pnv_nmmu_class_init,
+    .interfaces    = (InterfaceInfo[]) {
+        { TYPE_PNV_XSCOM_INTERFACE },
+        { }
+    }
+};
+
+static void pnv_nmmu_register_types(void)
+{
+    type_register_static(&amp;pnv_nmmu_info);
+}
+
+type_init(pnv_nmmu_register_types);
diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index a5b8c49680..b6382407c9 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -7,6 +7,7 @@
 #include "hw/ppc/pnv_core.h"
 #include "hw/ppc/pnv_homer.h"
 #include "hw/ppc/pnv_n1_chiplet.h"
+#include "hw/ppc/pnv_nmmu.h"
 #include "hw/ssi/pnv_spi.h"
 #include "hw/ppc/pnv_lpc.h"
 #include "hw/ppc/pnv_occ.h<a class="moz-txt-link-rfc2396E" href="mailto:@@-126,6+127,8@@structPnv10Chip{PnvN1Chipletn1_chiplet;#definePNV10_CHIP_MAX_PIB_SPIC6PnvSpipib_spic[PNV10_CHIP_MAX_PIB_SPIC];+#definePNV10_CHIP_MAX_NMMU2+PnvNMMUnmmu[PNV10_CHIP_MAX_NMMU];uint32_tnr_quads;PnvQuad*quads;diff--gita/include/hw/ppc/pnv_nmmu.hb/include/hw/ppc/pnv_nmmu.hnewfilemode100644index0000000000..d3ba46ecf4---/dev/null+++b/include/hw/ppc/pnv_nmmu.h@@-0,0+1,28@@+/*+*QEMUPowerPCnestMMUmodel+*+*Copyright(c)2025,IBMCorporation.+*+*SPDX-License-Identifier:GPL-2.0-or-later+*+*ThiscodeislicensedundertheGPLversion2orlater.Seethe+*COPYINGfileinthetop-leveldirectory.+*/++#ifndefPPC_PNV_NMMU_H+#definePPC_PNV_NMMU_H++#defineTYPE_PNV_NMMU">"
@@ -126,6 +127,8 @@ struct Pnv10Chip {
     PnvN1Chiplet     n1_chiplet;
 #define PNV10_CHIP_MAX_PIB_SPIC 6
     PnvSpi pib_spic[PNV10_CHIP_MAX_PIB_SPIC];
+#define PNV10_CHIP_MAX_NMMU 2
+    PnvNMMU      nmmu[PNV10_CHIP_MAX_NMMU];
 
     uint32_t     nr_quads;
     PnvQuad      *quads;
diff --git a/include/hw/ppc/pnv_nmmu.h b/include/hw/ppc/pnv_nmmu.h
new file mode 100644
index 0000000000..d3ba46ecf4
--- /dev/null
+++ b/include/hw/ppc/pnv_nmmu.h
@@ -0,0 +1,28 @@
+/*
+ * QEMU PowerPC nest MMU model
+ *
+ * Copyright (c) 2025, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#ifndef PPC_PNV_NMMU_H
+#define PPC_PNV_NMMU_H
+
+#define TYPE_PNV_NMMU "</a>pnv-nmmu"
+#define PNV_NMMU(obj) OBJECT_CHECK(PnvNMMU, (obj), TYPE_PNV_NMMU)
+
+typedef struct PnvNMMU {
+    DeviceState parent;
+
+    struct PnvChip *chip;
+
+    MemoryRegion xscom_regs;
+    uint32_t nmmu_id;
+    uint64_t ptcr;
+} PnvNMMU;
+
+#endif /*PPC_PNV_NMMU_H */
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 610b075a27..6dab803d1f 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -196,6 +196,10 @@ struct PnvXScomInterfaceClass {
 #define PNV10_XSCOM_N1_PB_SCOM_ES_BASE      0x3011300
 #define PNV10_XSCOM_N1_PB_SCOM_ES_SIZE      0x100
 
+#define PNV10_XSCOM_NEST0_MMU_BASE      0x2010c40
+#define PNV10_XSCOM_NEST1_MMU_BASE      0x3010c40
+#define PNV10_XSCOM_NMMU_SIZE      0x20
+
 #define PNV10_XSCOM_PEC_NEST_BASE  0x3011800 /* index goes downwards ... */
 #define PNV10_XSCOM_PEC_NEST_SIZE  0x100
 
</pre>
    </blockquote>
  </body>
</html>

--------------ZFskvR0oGTL0PkwuFZLN7fEx--


