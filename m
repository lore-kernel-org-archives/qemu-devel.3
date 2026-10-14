Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C40CC6B2F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH5Hi-0007a3-F5; Wed, 14 Oct 2026 16:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xH5Hf-0007YD-Uz; Wed, 14 Oct 2026 16:09:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xH5Hd-000480-Nn; Wed, 14 Oct 2026 16:09:07 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEiSjO1270237; Wed, 14 Oct 2026 20:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=I7lyoxFS7pcrfgo3ghwjzdmWBxgPuNwO8AFA0sE/Yjw=; b=O4pB3ud9m+BL
 qzelXAfTalEQubHsZ+RcX0Bibx8VE3YjuO+99k+YgEwK5CoiXCnmZA5RBUVMlxWT
 d4g+H6Rn77lELNjT4i/ZCejPIyZ9/o0KoUZSj7ywW5rPg1Vc2PPa42p5MuUS64Rj
 WF7d0ZjcYQ3cLSY0365O8fnClRjPl9FXTas6yOdk3fe6ISBcFsMako7GGfpeCjkB
 b1uX7TBuEUzbKGl7wMwJ0Sce2JcGLjGrS+wgDaCagSUsIZSrfqVkz02ism1uIxIO
 UbsEsmPHfMNuo03FTx8ygK82iAHMIYiCFRT9pa9NYPntZw+s6PYYxJpwnIk9m4jj
 RBnaMiHXIQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv0nxq5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 20:08:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EIYQNd3639707; Wed, 14 Oct 2026 20:08:48 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9wvg4988-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 20:08:48 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69EK8lIv9896518
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Oct 2026 20:08:47 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B8CD58056;
 Wed, 14 Oct 2026 20:08:47 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65E5458062;
 Wed, 14 Oct 2026 20:08:46 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 Oct 2026 20:08:46 +0000 (GMT)
Message-ID: <497b3c7bf49c5ca783c7740e448941793b81ad43.camel@linux.ibm.com>
Subject: Re: [PATCH v2 41/50] tests/qtest: ina238: add current/voltage/power
 monitor test
From: Miles Glenn <milesg@linux.ibm.com>
To: Emmanuel Blot <emmanuel.blot@free.fr>, qemu-devel@nongnu.org
Cc: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy
 Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, Patrick Leis
 <venture@google.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 15:08:46 -0500
In-Reply-To: <20261012-bmc-minerva-v2-41-4c3dff084ec9@free.fr>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
 <20261012-bmc-minerva-v2-41-4c3dff084ec9@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX3Wm0o1hd765A
 1eyc6x7+iYEruW8r9ny1X/HofGhL7mfqSy3klfc1a7pFskXnzl8llaFMfhgzWpGLmeaV17eje/r
 7cZ+FdQqNdtV8XEUtYvRZ/AxAT+lC76aWo/K6BJLUqgJeYjQKxt3lKMJzpzZYlvlJKTP60TmWWc
 tp6b9PEV2b5cYl5WvDe+ZsPBRY45SzZEivfaxoX1rtRvbrKEg+0yDY64B67eNb71ubESNBbE5KA
 tsXFqIDunuOHcJ8Ymlc/SLwrPesVq1ub+ixraUu/b3+87lOtw3FJvR59ZFUhSAnGqBcnSu1Vd/5
 KFPLfh/AgXMtjChnTA26Rt0Wln8zWRpnJlo+1XskaHC4UzXUl7kHy+xp7v59jEW0oqPRUl1CBcM
 nOvTzyUYPFvyH7yEo3ZorTySBoAUt+h2/dFmWFi3ZpVwwfa5eC5GxS8gYZV10YwYtAxO++dpBXe
 VnM6AXJuHkKPuyz3dtQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX7P2q/ZCX9t+A
 /W0ijupVswGkHKYAEVCbQQ3MRZzF2AZKrhkdmLrkcTaDYJKK2m0NAPGcUkrrky5j9kAK0WTOAFg
 wqW2F85weNX5522/EzJvgypW2ANAGwU=
X-Proofpoint-ORIG-GUID: 2C438X0HqycWApJ8nmaJ3BuIVMx0S6hp
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6acfe151 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=hTvPPykMyHyLrdisSnMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: PFNwv_cWR69i8W2XaLzSEeIt6aLkZ9u3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140078
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Mon, 2026-10-12 at 16:32 +0200, Emmanuel Blot via qemu development
wrote:
> Introduce the INA238 qtest: the qgraph node, the QMP injection helpers
> and the register map. Cover the reset defaults, the software reset, and
> the Configuration register write mask.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  tests/qtest/ina238-test.c | 177 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/qtest/meson.build   |   1 +
>  2 files changed, 178 insertions(+)
> 
> diff --git a/tests/qtest/ina238-test.c b/tests/qtest/ina238-test.c
> new file mode 100644
> index 0000000000..6e59ed30b5
> --- /dev/null
> +++ b/tests/qtest/ina238-test.c
> @@ -0,0 +1,177 @@
> +/*
> + * QTest testcase for the INA238 current/voltage/power monitor
> + *
> + * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqos/i2c.h"
> +#include "libqos/qgraph.h"
> +#include "libqtest-single.h"
> +#include "qobject/qdict.h"
> +
> +#define INA238_TEST_ID      "ina238-test"
> +#define INA238_TEST_ADDR    0x40
> +
> +/* Register pointer addresses */
> +#define REG_CONFIG          0x00
> +#define REG_ADC_CONFIG      0x01
> +#define REG_SHUNT_CAL       0x02
> +#define REG_VSHUNT          0x04
> +#define REG_VBUS            0x05
> +#define REG_DIETEMP         0x06
> +#define REG_CURRENT         0x07
> +#define REG_POWER           0x08
> +#define REG_DIAG_ALRT       0x0B
> +#define REG_SOVL            0x0C
> +#define REG_SUVL            0x0D
> +#define REG_BOVL            0x0E
> +#define REG_BUVL            0x0F
> +#define REG_TEMP_LIMIT      0x10
> +#define REG_PWR_LIMIT       0x11
> +#define REG_MANUFACTURER_ID 0x3E
> +#define REG_DEVICE_ID       0x3F
> +
> +/* Configuration register bits */
> +#define CONFIG_RST          0x8000
> +#define CONFIG_ADCRANGE     0x0010
> +
> +/* DIAG_ALRT register bits */
> +#define DIAG_MEMSTAT        0x0001
> +#define DIAG_CNVRF          0x0002
> +#define DIAG_POL            0x0004
> +#define DIAG_BUSUL          0x0008
> +#define DIAG_BUSOL          0x0010
> +#define DIAG_SHNTUL         0x0020
> +#define DIAG_SHNTOL         0x0040
> +#define DIAG_TMPOL          0x0080
> +#define DIAG_MATHOF         0x0200
> +#define DIAG_APOL           0x1000
> +#define DIAG_SLOWALERT      0x2000
> +#define DIAG_CNVR           0x4000
> +#define DIAG_ALATCH         0x8000
> +
> +/* Reset values */
> +#define CONFIG_POR          0x0000
> +#define ADC_CONFIG_POR      0xFB68
> +#define SHUNT_CAL_POR       0x1000
> +#define DIAG_ALRT_POR       0x0001
> +#define SOVL_POR            0x7FFF
> +#define SUVL_POR            0x8000
> +#define BOVL_POR            0x7FFF
> +#define BUVL_POR            0x0000
> +#define TEMP_LIMIT_POR      0x7FF0
> +#define PWR_LIMIT_POR       0xFFFF
> +#define MANUFACTURER_ID_VAL 0x5449
> +#define DEVICE_ID_VAL       0x2381
> +
> +/* Read the 24-bit POWER register (MSB first) */
> +static uint32_t i2c_get24(QI2CDevice *dev, uint8_t reg)
> +{
> +    uint8_t resp[3];
> +
> +    i2c_read_block(dev, reg, resp, sizeof(resp));
> +    return (resp[0] << 16) | (resp[1] << 8) | resp[2];
> +}
> +
> +/* QMP helpers for injecting the physical inputs */
> +
> +static void qmp_ina238_set(const char *property, int value)
> +{
> +    QDict *resp;
> +
> +    resp = qmp("{ 'execute': 'qom-set', 'arguments':"
> +               " { 'path': %s, 'property': %s, 'value': %d } }",
> +               INA238_TEST_ID, property, value);
> +    g_assert(qdict_haskey(resp, "return"));
> +    qobject_unref(resp);
> +}
> +
> +/* Power-on-reset default values and the ID registers */
> +static void test_defaults(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    g_assert_cmphex(i2c_get16(dev, REG_CONFIG), ==, CONFIG_POR);
> +    g_assert_cmphex(i2c_get16(dev, REG_ADC_CONFIG), ==, ADC_CONFIG_POR);
> +    g_assert_cmphex(i2c_get16(dev, REG_SHUNT_CAL), ==, SHUNT_CAL_POR);
> +    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x0000);
> +    g_assert_cmphex(i2c_get16(dev, REG_VBUS), ==, 0x0000);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIETEMP), ==, 0x0000);
> +    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x0000);
> +    g_assert_cmphex(i2c_get24(dev, REG_POWER), ==, 0x000000);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT), ==, DIAG_ALRT_POR);
> +    g_assert_cmphex(i2c_get16(dev, REG_SOVL), ==, SOVL_POR);
> +    g_assert_cmphex(i2c_get16(dev, REG_SUVL), ==, SUVL_POR);
> +    g_assert_cmphex(i2c_get16(dev, REG_BOVL), ==, BOVL_POR);
> +    g_assert_cmphex(i2c_get16(dev, REG_BUVL), ==, BUVL_POR);
> +    g_assert_cmphex(i2c_get16(dev, REG_TEMP_LIMIT), ==, TEMP_LIMIT_POR);
> +    g_assert_cmphex(i2c_get16(dev, REG_PWR_LIMIT), ==, PWR_LIMIT_POR);
> +    g_assert_cmphex(i2c_get16(dev, REG_MANUFACTURER_ID), ==,
> +                    MANUFACTURER_ID_VAL);
> +    g_assert_cmphex(i2c_get16(dev, REG_DEVICE_ID), ==, DEVICE_ID_VAL);
> +}
> +
> +/* Software reset via the Configuration RST bit */
> +static void test_soft_reset(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_SHUNT_CAL, 0x1234);
> +    i2c_set16(dev, REG_SOVL, 0x0500);
> +    i2c_set16(dev, REG_TEMP_LIMIT, 0x0A00);
> +    i2c_set16(dev, REG_DIAG_ALRT, DIAG_ALATCH);
> +
> +    qmp_ina238_set("shunt-voltage", 97200000);
> +    qmp_ina238_set("bus-voltage", 48000000);
> +    qmp_ina238_set("die-temperature", 25000);
> +
> +    g_assert_cmphex(i2c_get16(dev, REG_SHUNT_CAL), ==, 0x1234);
> +    g_assert_cmphex(i2c_get16(dev, REG_SOVL), ==, 0x0500);
> +    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x4BF0);
> +    g_assert_cmpuint(i2c_get16(dev, REG_CURRENT), !=, 0);
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +
> +    g_assert_cmphex(i2c_get16(dev, REG_CONFIG), ==, CONFIG_POR);
> +    g_assert_cmphex(i2c_get16(dev, REG_SHUNT_CAL), ==, SHUNT_CAL_POR);
> +    g_assert_cmphex(i2c_get16(dev, REG_SOVL), ==, SOVL_POR);
> +    g_assert_cmphex(i2c_get16(dev, REG_TEMP_LIMIT), ==, TEMP_LIMIT_POR);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT), ==, DIAG_ALRT_POR);
> +
> +    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x0000);
> +    g_assert_cmphex(i2c_get16(dev, REG_VBUS), ==, 0x0000);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIETEMP), ==, 0x0000);
> +    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x0000);
> +    g_assert_cmpuint(i2c_get24(dev, REG_POWER), ==, 0);
> +}
> +
> +/* CONFIG keeps only the writable ADCRANGE/CONVDLY bits and self-clears RST */
> +static void test_config_wmask(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_ADCRANGE | 0x0040);
> +    g_assert_cmphex(i2c_get16(dev, REG_CONFIG), ==, CONFIG_ADCRANGE | 0x0040);
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +    g_assert_cmphex(i2c_get16(dev, REG_CONFIG), ==, CONFIG_POR);
> +}
> +
> +static void ina238_register_nodes(void)
> +{
> +    QOSGraphEdgeOptions opts = {
> +        .extra_device_opts = "id=" INA238_TEST_ID ",address=0x40"
> +    };
> +    add_qi2c_address(&opts, &(QI2CAddress) { INA238_TEST_ADDR });
> +
> +    qos_node_create_driver("ina238", i2c_device_create);
> +    qos_node_consumes("ina238", "i2c-bus", &opts);
> +
> +    qos_add_test("defaults", "ina238", test_defaults, NULL);
> +    qos_add_test("soft-reset", "ina238", test_soft_reset, NULL);
> +    qos_add_test("config-wmask", "ina238", test_config_wmask, NULL);
> +}
> +libqos_init(ina238_register_nodes);
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index e413a0cc75..7005509d4d 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -331,6 +331,7 @@ qos_test_ss.add(
>    'eepro100-test.c',
>    'es1370-test.c',
>    'ina230-test.c',
> +  'ina238-test.c',
>    'lsm303dlhc-mag-test.c',
>    'isl_pmbus_vr-test.c',
>    'max34451-test.c',
> 


