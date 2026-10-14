Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5D9CC6B2C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH5DZ-0003kk-Ao; Wed, 14 Oct 2026 16:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xH5DX-0003kF-TI; Wed, 14 Oct 2026 16:04:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xH5DV-0003Z3-Rk; Wed, 14 Oct 2026 16:04:51 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEifKc2466405; Wed, 14 Oct 2026 20:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=2VKUsJoDpEQgE/dG/9G4QGDYmVy9+8S1ui5QZ5zM24s=; b=fttTKnmg4za6
 RpQ2zkyRdsTKQk1a2NBadhaEtybWSqjqowT96vCMSCiKKOfH6MgQqSm+3UvTqeOf
 0m2gNxPBExFrrxt43gtKeG01GoAoY4bACjc1roY6oBNCzbNoFH6lxuhPrTpUvo+2
 uXldHsaja75aX6WpFaXvZNpH0fVdj/6+NBvWlL2nM3wz0h2OAr1S8S7NwLKlEked
 iVx8MBb0OT+BAo7xKbRpXFLMgFhuv4T/2Q3tDKWw4HUggaAriGcQrynuWkpFO6Sv
 7MLKDi3wcp5gyRQIonXW1nnQM2DHH3RgUqFzfZ2WTJfBVc+4EBZvUlb40PxqWeSk
 JfU3zEev/A==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1wdvx1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 20:04:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EIeEwN702844; Wed, 14 Oct 2026 20:04:25 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816h8ykv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 20:04:25 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69EK4Ouj1639132
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Oct 2026 20:04:24 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50ED358063;
 Wed, 14 Oct 2026 20:04:24 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D35958061;
 Wed, 14 Oct 2026 20:04:23 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 Oct 2026 20:04:23 +0000 (GMT)
Message-ID: <0a9be07587f4ca03cee269b535e74b24415ec3de.camel@linux.ibm.com>
Subject: Re: [PATCH v2 33/50] tests/qtest: ina230: add current/voltage/power
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
Date: Wed, 14 Oct 2026 15:04:23 -0500
In-Reply-To: <20261012-bmc-minerva-v2-33-4c3dff084ec9@free.fr>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
 <20261012-bmc-minerva-v2-33-4c3dff084ec9@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX259hSng9FcOi
 /+2RkxgJPPeDg4jh9hliCn3B/V1j1hT9moT4MyMZHs+UCkD6PE/L77KauGU2VfkjjXuUx32xFfZ
 EFyo63jteL3sgMH0FdhV1EVLpTtJA9s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX6biuSjGT33Il
 V3SLYlGnLu4phrhJFxqONAPH3O4n1On6bwEDjklMdvVd2a1gNwI9F03er0wxWSjsmUNXJCdMFxK
 hIzhdC8WDHwcp6BMyVNd5xvUCrofvn96LdgmkTi7dcpVmF2TYZILJwUxaUW9w5FZXjVdqx0DQDR
 wcFJ8hpxUlQn58ZZHpkI8sIEG5FTpRuTE+i5jxYRkQQwjl//4ZlywoCgCFP62KJdHaca9Y9Di8h
 XAB6sTpxWEMKpKmsJxDx7WpEfeL6VQ/IyO7VBwJL1UyBgfyPiATrxRh/1r0SFHdoxN8gnARPuU7
 FOCi6v8nuDy4nNb0cZsrfN1W3k4pRk6sxP9/RkGKtdClsK2q8S4nVUX+LnaRwFflx6LAm9g2+OR
 twe080h3/oAXpLcBZ+Du9RWDCR6mt1Bh1Vtl8cKw+sjlixuSNnYoV/NrwVDLrtK9gJsJ9ieo58V
 OHeAEpQ7jKRNxnNcA9w==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6acfe04a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=sbxFOUD_Rgmoilq90nIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 0Yx10qCISZQ1Mc6tLdWCindVJ0MCa4Lr
X-Proofpoint-GUID: 8TfdN488Yg3mTrfcP9L-dy66FLhe83A6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140078
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
> Introduce the INA230 qtest: the qgraph node and the register map. Cover
> the power-on-reset defaults and Die ID, the software reset, and the
> Configuration register write mask. The QMP voltage-injection helpers
> arrive with the following commit that exercises them.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  tests/qtest/ina230-test.c | 115 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/qtest/meson.build   |   1 +
>  2 files changed, 116 insertions(+)
> 
> diff --git a/tests/qtest/ina230-test.c b/tests/qtest/ina230-test.c
> new file mode 100644
> index 0000000000..f7aefd2d97
> --- /dev/null
> +++ b/tests/qtest/ina230-test.c
> @@ -0,0 +1,115 @@
> +/*
> + * QTest testcase for the INA230 current/voltage/power monitor
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
> +#define INA230_TEST_ID      "ina230-test"
> +#define INA230_TEST_ADDR    0x40
> +
> +/* Register pointer addresses */
> +#define REG_CONFIG          0x00
> +#define REG_SHUNT           0x01
> +#define REG_BUS             0x02
> +#define REG_POWER           0x03
> +#define REG_CURRENT         0x04
> +#define REG_CALIBRATION     0x05
> +#define REG_MASK_ENABLE     0x06
> +#define REG_ALERT_LIMIT     0x07
> +#define REG_DIE_ID          0xFF
> +
> +/* Configuration register bits */
> +#define CONFIG_POR          0x4127
> +#define CONFIG_RST          0x8000
> +
> +/* Mask/Enable register bits */
> +#define ME_LEN              0x0001
> +#define ME_APOL             0x0002
> +#define ME_OVF              0x0004
> +#define ME_CVRF             0x0008
> +#define ME_AFF              0x0010
> +#define ME_CNVR             0x0400
> +#define ME_POL              0x0800
> +#define ME_BUL              0x1000
> +#define ME_BOL              0x2000
> +#define ME_SUL              0x4000
> +#define ME_SOL              0x8000
> +
> +/* Injected-input scaling (datasheet fixed LSBs) */
> +#define SHUNT_LSB_NV        2500
> +#define BUS_LSB_UV          1250
> +
> +#define DIE_ID_VAL          0x2310
> +
> +/* Power-on-reset default values and the Die ID */
> +static void test_defaults(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    g_assert_cmphex(i2c_get16(dev, REG_CONFIG), ==, CONFIG_POR);
> +    g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, 0x0000);
> +    g_assert_cmphex(i2c_get16(dev, REG_BUS), ==, 0x0000);
> +    g_assert_cmphex(i2c_get16(dev, REG_POWER), ==, 0x0000);
> +    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x0000);
> +    g_assert_cmphex(i2c_get16(dev, REG_CALIBRATION), ==, 0x0000);
> +    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE), ==, 0x0000);
> +    g_assert_cmphex(i2c_get16(dev, REG_ALERT_LIMIT), ==, 0x0000);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIE_ID), ==, DIE_ID_VAL);
> +}
> +
> +/* Software reset via the Configuration RST bit */
> +static void test_soft_reset(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CALIBRATION, 0x1234);
> +    i2c_set16(dev, REG_MASK_ENABLE, ME_SOL);
> +    i2c_set16(dev, REG_ALERT_LIMIT, 0x0500);
> +
> +    g_assert_cmphex(i2c_get16(dev, REG_CALIBRATION), ==, 0x1234);
> +    g_assert_cmphex(i2c_get16(dev, REG_ALERT_LIMIT), ==, 0x0500);
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +
> +    g_assert_cmphex(i2c_get16(dev, REG_CONFIG), ==, CONFIG_POR);
> +    g_assert_cmphex(i2c_get16(dev, REG_CALIBRATION), ==, 0x0000);
> +    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE), ==, 0x0000);
> +    g_assert_cmphex(i2c_get16(dev, REG_ALERT_LIMIT), ==, 0x0000);
> +}
> +
> +/* Every bit except the self-clearing RST is writable and reads back */
> +static void test_config_wmask(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    /* Reserved bits are not forced: the guest value is retained */
> +    i2c_set16(dev, REG_CONFIG, 0x0007);
> +    g_assert_cmphex(i2c_get16(dev, REG_CONFIG), ==, 0x0007);
> +
> +    i2c_set16(dev, REG_CONFIG, 0x7FFF);
> +    g_assert_cmphex(i2c_get16(dev, REG_CONFIG), ==, 0x7FFF);
> +}
> +
> +static void ina230_register_nodes(void)
> +{
> +    QOSGraphEdgeOptions opts = {
> +        .extra_device_opts = "id=" INA230_TEST_ID ",address=0x40"
> +    };
> +    add_qi2c_address(&opts, &(QI2CAddress) { INA230_TEST_ADDR });
> +
> +    qos_node_create_driver("ina230", i2c_device_create);
> +    qos_node_consumes("ina230", "i2c-bus", &opts);
> +
> +    qos_add_test("defaults", "ina230", test_defaults, NULL);
> +    qos_add_test("soft-reset", "ina230", test_soft_reset, NULL);
> +    qos_add_test("config-wmask", "ina230", test_config_wmask, NULL);
> +}
> +libqos_init(ina230_register_nodes);
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index e23eb9bbca..e413a0cc75 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -330,6 +330,7 @@ qos_test_ss.add(
>    'e1000-test.c',
>    'eepro100-test.c',
>    'es1370-test.c',
> +  'ina230-test.c',
>    'lsm303dlhc-mag-test.c',
>    'isl_pmbus_vr-test.c',
>    'max34451-test.c',
> 


