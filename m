Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0DECDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 18:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc5nX-0003b1-Dl; Tue, 23 Jun 2026 14:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1wc5nR-0003aO-Rd; Tue, 23 Jun 2026 14:24:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1wc5nP-0000Rl-74; Tue, 23 Jun 2026 14:24:29 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NBmOXo1805234; Tue, 23 Jun 2026 18:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Hx5i3c
 7I7kIGFmWfL6N73nfytU9+L0ADY3lLsDuifzA=; b=XYtaQiRujfg61N0YxIOwVr
 M7L3Hxd5RDOOB83PByBB5lJ5nqqAqRi9TWnsFFsLUjZoBfQrFiiRxHcXJhOZ+nP+
 dZn0sfanLMJfe1H4gSXc59YmDG9JuE/7QY4V9xywRiAJuSlg5Q/ioV1bHASuIOXn
 M/Mm3i0o2tbS29sCNss0m09AjeHDkIUZHEiwQcyBWqipEq54yk+bQn6OGsAB9oZw
 +TQLX2xksfcDsitdQXq7VYYco3Tf1uEipdnQ+jxygU6hxazXFwEWQCsmu1ccuMxK
 iDkSn3v/uLGPuJzEZkV5Q+kDXWtZfpAa+8CrsGbGXCZjjhh2sMW4LRW5UXenMvOw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gg4v8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 18:24:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NIJhH3004673;
 Tue, 23 Jun 2026 18:24:13 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qcxfe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 18:24:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65NIOCVS24576698
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 18:24:12 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3DB365805A;
 Tue, 23 Jun 2026 18:24:12 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B8E55805C;
 Tue, 23 Jun 2026 18:24:10 +0000 (GMT)
Received: from [9.61.241.143] (unknown [9.61.241.143])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 18:24:10 +0000 (GMT)
Message-ID: <24526df8-2788-47ad-a740-ebf238c1d9d1@linux.ibm.com>
Date: Tue, 23 Jun 2026 13:24:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/9] qtest/phb5: Add testbench for PHB
To: Saif Abrar <saif.abrar@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, milesg@linux.ibm.com,
 jishnuvw@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com
References: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
 <20260617095058.652789-2-saif.abrar@linux.ibm.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <20260617095058.652789-2-saif.abrar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: AR2rURWhQjzmuepQJQFzM-EhD38af-X8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE1MSBTYWx0ZWRfX7lwjJihup/KJ
 L+Lu0DT8Gf6/65+SJRwrGfXP98P06zpCOaymVtqgf89HRt+LYPTfGzV5qs++7J708SX/kvS9Tm0
 HHzcajQGrtGd1pEC38HaXgiBs5CbXiM=
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3acf4e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=SB0furjbP_0JqXJp7Y0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE1MSBTYWx0ZWRfX8Y6CiLTOj/ev
 FEcwFeNgaev5ZuP070JaZ0pY8lmcxtiZnIuUIy3Ow0tqJk28LRn7U91yWNa6g4i0DAOZMkqzYp4
 3NXKrQg9/E5tvndBE98m19Tx3RKrPlW1aV39WCTMDf9QhLrRy4YEZbuyzwmqbSwTIrf7zXeRbc5
 gDhbQhKgXrz+9/B9ZzPPS/lUaJrFMITTyAaS8xpzqVHohiNmjyU5tZ9FER/RvvwQ/qJ0KZD9pOV
 fGqqGjloKJygHvN3b7xi77TsnsLlpcZGeZe9UqEIsCDTXP8sNAL4PuoelBFA7zv2e1oanPY0d6P
 yycgF5PQ3Vqg18Kmgb1E02L5M3rJcM7qBKI4O+Lt+W8cR8JIP41KpGHe+pJtHKyjTHWGK5S9KZ/
 cJmx6LYGeEn1qgMV0mxerAEJ/LGkKN3M0XYxSHZocuXOlyFzxM9i5Yl98ZDwNUzfaEsMNPafnZG
 /rIbyOl4POZtuN3R9SA==
X-Proofpoint-ORIG-GUID: 4kShmGfalW_vnX9TFrcTMK3rVodvWQKF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230151
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>

On 6/17/26 4:50 AM, Saif Abrar wrote:
> From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
> 
> New qtest testbench added for PHB[345].
> Testbench reads PHB Version register and asserts that
> bits[24:31] have value 0xA3, 0xA4 and 0xA5 respectively.
> 
> Signed-off-by: Saif Abrar <saif.abrar@linux.ibm.com>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
> Reviewed-by: Jishnu Warrier <Jishnu.Warrier@ibm.com>
> ---
> v5:
> - Rename qtest file and all methods to phb5.
> - New file for common defitions "pnv-qtest-common.h"
> v3: Updates for coding guidelines.
> v2: Added version check for PHB3 and PHB4 also.
> 
> 
>  tests/qtest/meson.build         |   1 +
>  tests/qtest/pnv-host-i2c-test.c |  13 +----
>  tests/qtest/pnv-phb-test.c      | 100 ++++++++++++++++++++++++++++++++
>  tests/qtest/pnv-qtest-common.h  |  24 ++++++++
>  tests/qtest/pnv-xive2-common.h  |   7 +--
>  5 files changed, 127 insertions(+), 18 deletions(-)
>  create mode 100644 tests/qtest/pnv-phb-test.c
>  create mode 100644 tests/qtest/pnv-qtest-common.h
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 2ae720156f..d3fc532dcd 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -186,6 +186,7 @@ qtests_ppc64 = \
>    (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-xive2-test'] : []) +                 \
>    (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-spi-seeprom-test'] : []) +           \
>    (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-host-i2c-test'] : []) +              \
> +  (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-phb-test'] : []) +                  \
>    (config_all_devices.has_key('CONFIG_PSERIES') ? ['numa-test'] : []) +                      \
>    (config_all_devices.has_key('CONFIG_PSERIES') ? ['rtas-test'] : []) +                      \
>    (slirp.found() ? ['pxe-test'] : []) +              \
> diff --git a/tests/qtest/pnv-host-i2c-test.c b/tests/qtest/pnv-host-i2c-test.c
> index 51e613ebdc..5867416b26 100644
> --- a/tests/qtest/pnv-host-i2c-test.c
> +++ b/tests/qtest/pnv-host-i2c-test.c
> @@ -11,18 +11,7 @@
>  #include "hw/gpio/pca9554_regs.h"
>  #include "hw/gpio/pca9552_regs.h"
>  #include "pnv-xscom.h"
> -
> -#define PPC_BIT(bit)            (0x8000000000000000ULL >> (bit))
> -#define PPC_BIT32(bit)          (0x80000000 >> (bit))
> -#define PPC_BIT8(bit)           (0x80 >> (bit))
> -#define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
> -#define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
> -                                 PPC_BIT32(bs))
> -
> -#define MASK_TO_LSH(m)          (__builtin_ffsll(m) - 1)
> -#define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
> -#define SETFIELD(m, v, val) \
> -        (((v) & ~(m)) | ((((typeof(v))(val)) << MASK_TO_LSH(m)) & (m)))
> +#include "pnv-qtest-common.h"
>  
>  #define PNV10_XSCOM_I2CM_BASE   0xa0000
>  #define PNV10_XSCOM_I2CM_SIZE   0x1000
> diff --git a/tests/qtest/pnv-phb-test.c b/tests/qtest/pnv-phb-test.c
> new file mode 100644
> index 0000000000..2eda521249
> --- /dev/null
> +++ b/tests/qtest/pnv-phb-test.c
> @@ -0,0 +1,100 @@
> +/*
> + * QTest testcase for PowerNV PHB
> + *
> + * Copyright (c) 2026, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "hw/pci-host/pnv_phb4_regs.h"
> +#include "pnv-xscom.h"
> +#include "pnv-qtest-common.h"
> +
> +#define PHB3_PBCQ_SPCI_ASB_ADDR      0x0
> +#define PHB3_PBCQ_SPCI_ASB_DATA      0x2
> +
> +/* Index of PNV_CHIP_POWER10 in pnv_chips[] within "pnv-xscom.h" */
> +#define PHB4_XSCOM              0x40084800ull
> +
> +/* SCOM to PCBA address conversion */
> +#define SCOM_TO_PCBA(scom, addr) (((scom) >> 3) + (addr))
> +
> +/*
> + * Indirect XSCOM read::
> + * - Write 'Indirect Address Register' with register-offset to read.
> + * - Read 'Indirect Data Register' to get the value.
> + */
> +static uint64_t pnv_phb_xscom_read(QTestState *qts, const PnvChip *chip,
> +        uint64_t scom, uint32_t indirect_addr, uint32_t indirect_data,
> +        uint64_t reg)
> +{
> +    qtest_writeq(qts, pnv_xscom_addr(chip, SCOM_TO_PCBA(scom, indirect_addr)),
> +                 reg);
> +    return qtest_readq(qts, pnv_xscom_addr(chip, SCOM_TO_PCBA(scom,
> +                                                              indirect_data)));
> +}
> +
> +/* Assert that 'PHB - Version Register' bits[24:31] are as expected */
> +static void phb_version_test(const void *data)
> +{
> +    const PnvChip *chip = (PnvChip *)data;
> +    QTestState *qts;
> +    const char *machine = "powernv8";
> +    uint64_t phb_xscom = 0x4809e000;
> +    uint64_t reg_phb_version = PHB_VERSION;
> +    uint32_t indirect_addr = PHB3_PBCQ_SPCI_ASB_ADDR;
> +    uint32_t indirect_data = PHB3_PBCQ_SPCI_ASB_DATA;
> +    uint32_t expected_ver = 0xA3;
> +    uint64_t ver;
> +
> +    if (chip->chip_type == PNV_CHIP_POWER9) {
> +        machine = "powernv9";
> +        phb_xscom = 0x68084800;
> +        indirect_addr = PHB_SCOM_HV_IND_ADDR;
> +        indirect_data = PHB_SCOM_HV_IND_DATA;
> +        reg_phb_version |= PPC_BIT(0);
> +        expected_ver = 0xA4;
> +    } else if (chip->chip_type == PNV_CHIP_POWER10) {
> +        machine = "powernv10";
> +        phb_xscom = PHB4_XSCOM;
> +        indirect_addr = PHB_SCOM_HV_IND_ADDR;
> +        indirect_data = PHB_SCOM_HV_IND_DATA;
> +        reg_phb_version |= PPC_BIT(0);
> +        expected_ver = 0xA5;
> +    }
> +
> +    qts = qtest_initf("-M %s -accel tcg -cpu %s", machine, chip->cpu_model);
> +
> +    ver = pnv_phb_xscom_read(qts, chip, phb_xscom,
> +                                indirect_addr, indirect_data, reg_phb_version);
> +
> +    /* PHB Version register bits [24:31] */
> +    ver = (ver & PPC_BITMASK(24, 31)) >> (63 - 31);
> +    g_assert_cmpuint(ver, ==, expected_ver);
> +
> +    qtest_quit(qts);
> +}
> +
> +/* Verify versions of all supported PHB's */
> +static void add_phbX_version_test(void)
> +{
> +    for (int i = 0; i < ARRAY_SIZE(pnv_chips); i++) {
> +        char *tname = g_strdup_printf("pnv-phb/%s",
> +                                      pnv_chips[i].cpu_model);
> +        qtest_add_data_func(tname, &pnv_chips[i], phb_version_test);
> +        g_free(tname);
> +    }
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    /* PHB[345] tests */
> +    add_phbX_version_test();
> +
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/pnv-qtest-common.h b/tests/qtest/pnv-qtest-common.h
> new file mode 100644
> index 0000000000..c2d1bae7bb
> --- /dev/null
> +++ b/tests/qtest/pnv-qtest-common.h
> @@ -0,0 +1,24 @@
> +/*
> + * PNV QTest common definitions
> + *
> + * Copyright (c) 2026, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef TEST_PNV_QTEST_COMMON_H
> +#define TEST_PNV_QTEST_COMMON_H
> +
> +#define PPC_BIT(bit)            (0x8000000000000000ULL >> (bit))
> +#define PPC_BIT32(bit)          (0x80000000 >> (bit))
> +#define PPC_BIT8(bit)           (0x80 >> (bit))
> +#define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
> +#define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
> +                                 PPC_BIT32(bs))
> +
> +#define MASK_TO_LSH(m)          (__builtin_ffsll(m) - 1)
> +#define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
> +#define SETFIELD(m, v, val) \
> +        (((v) & ~(m)) | ((((typeof(v))(val)) << MASK_TO_LSH(m)) & (m)))
> +
> +#endif
> diff --git a/tests/qtest/pnv-xive2-common.h b/tests/qtest/pnv-xive2-common.h
> index 3b84227424..4b823a57e2 100644
> --- a/tests/qtest/pnv-xive2-common.h
> +++ b/tests/qtest/pnv-xive2-common.h
> @@ -9,12 +9,7 @@
>  #ifndef TEST_PNV_XIVE2_COMMON_H
>  #define TEST_PNV_XIVE2_COMMON_H
>  
> -#define PPC_BIT(bit)            (0x8000000000000000ULL >> (bit))
> -#define PPC_BIT32(bit)          (0x80000000 >> (bit))
> -#define PPC_BIT8(bit)           (0x80 >> (bit))
> -#define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
> -#define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
> -                                 PPC_BIT32(bs))
> +#include "pnv-qtest-common.h"
>  #include "hw/intc/pnv_xive2_regs.h"
>  #include "hw/ppc/xive_regs.h"
>  #include "hw/ppc/xive2_regs.h"


