Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5787CC6B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH5F9-00055s-QG; Wed, 14 Oct 2026 16:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xH5F5-0004yZ-Jb; Wed, 14 Oct 2026 16:06:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xH5F3-0003qJ-Qc; Wed, 14 Oct 2026 16:06:27 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEich02466332; Wed, 14 Oct 2026 20:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=Gj5yCen+2dfCCilbM8S+3EHR/BnQC9YhiRa96GP8nUo=; b=IT8gOGAG2/8M
 UfjJ1wOI/rVzrAeHCxQGyaMWeGcmDV9jvfXsJUT6XDPY1iOnf7qwgzoBSZL0HdOE
 z5iHbamsfTOoAh/SZtVKUInTacrW0JNkFu7q2TaTyaWrBmPNVmbAF3mY9yHewQub
 MeUHQe3rhO5X1OpnProW+9H1yRp+B7m0O+1hIf5eHbTaqYz5yP5F8i2mi4L6TIc1
 SD8IGWB3hHHeeIECmO78298TPUvvnXa/CpACNAmCNvf1wg2BqdzG4OUBOY5igOgc
 f5dM6X3bY+ctQKEAWRzTtrxB7MCcEWltuAMYIl8bPNUfGLDFev5yjlBiPsZRWyhh
 pBqZLDljjw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1wdw5c-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 20:06:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EIW58w714371; Wed, 14 Oct 2026 20:06:02 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9qb6xdy1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 20:06:02 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69EK61T930343744
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Oct 2026 20:06:02 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A77B65805D;
 Wed, 14 Oct 2026 20:06:01 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C941C58055;
 Wed, 14 Oct 2026 20:06:00 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 Oct 2026 20:06:00 +0000 (GMT)
Message-ID: <dbf69fefb1069890a71d0bf5317c3f13935b913b.camel@linux.ibm.com>
Subject: Re: [PATCH v2 36/50] tests/qtest: ina230: cover the
 injection-property limits
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
Date: Wed, 14 Oct 2026 15:06:00 -0500
In-Reply-To: <20261012-bmc-minerva-v2-36-4c3dff084ec9@free.fr>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
 <20261012-bmc-minerva-v2-36-4c3dff084ec9@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX3P3mbixUK0MI
 vwavcPmn6Iv6LsQxguwoM7jsScJZkx7nP1t3YmHFYE1ZIPILP6iweP4aVlv4VtknfcK4LSHZs96
 DzBM3GzmmNBcMiJR982kfhfSiA41Tn8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX3R2crEHd+Xkx
 wIfJvYm1QP3Zx/JQ3GRrXKXeLJZYHSgRFwLHlarM4PJF9wAk169eBJpnSbug4uiL95NZL7wSb++
 UCI0vrZ1y3wBRq5rgLNPifWLVOiiTercxR16lnMFZh5jlxzz3OV7FUjfLLk8+qxdEOMoUF26rZj
 1m/qANVgYNewCzX3as2+N5bfZpDA0vE1sKvnPUTJytJvnUbdTxuRom05cP8ph9EmS7sK/WwxXW+
 LekKBj/+eDlmE920Ct7P3wWOLIlRZPw/08pOunTDLRcZkFFivQShlmAkAg9lqKwAvGEQmJNOSJo
 eUztpZ8F4zZzSvnaeJ0zZO+p14YxpS+On1xItRH6Z9wlcL35y/12McOffNhj7ShbOK/xmgxGW9J
 3IEt5JA1l3nHkQJANXbZ/P4RjIaLjw2HB5KFbt1AnLuRVMPyDihCM1Qqwi9Q06CtLmoFDkWw7Y8
 +md7HgClC1wRuSLEHyg==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6acfe0ab cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=QfumlfGxchuXkGhP4sYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ubCUTM8TXNYAZphBN2_dSLLIGZ75bly5
X-Proofpoint-GUID: eeDzX8O45IB9aj3oOi1AlTs72Etth16g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1011 bulkscore=0 priorityscore=1501
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
> Verify that the extremes of the shunt- and bus-voltage injection ranges
> round-trip through the QOM property without truncation or wraparound,
> and that values just outside are rejected rather than silently wrapped.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  tests/qtest/ina230-test.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/tests/qtest/ina230-test.c b/tests/qtest/ina230-test.c
> index 1c55028fcb..36c899efee 100644
> --- a/tests/qtest/ina230-test.c
> +++ b/tests/qtest/ina230-test.c
> @@ -47,6 +47,11 @@
>  #define SHUNT_LSB_NV        2500
>  #define BUS_LSB_UV          1250
>  
> +/* Injection-property limits (see ina230.c) */
> +#define SHUNT_MIN_NV        (-81920000)
> +#define SHUNT_MAX_NV        81917500
> +#define BUS_MAX_UV          36000000
> +
>  #define DIE_ID_VAL          0x2310
>  
>  /* QMP helpers for injecting the physical inputs */
> @@ -76,6 +81,18 @@ static int qmp_ina230_get(const char *property)
>      return ret;
>  }
>  
> +/* A qom-set expected to be rejected (value outside the supported range) */
> +static void qmp_ina230_set_fail(const char *property, int64_t value)
> +{
> +    QDict *resp;
> +
> +    resp = qmp("{ 'execute': 'qom-set', 'arguments':"
> +               " { 'path': %s, 'property': %s, 'value': %lld } }",
> +               INA230_TEST_ID, property, (long long)value);
> +    g_assert(qdict_haskey(resp, "error"));
> +    qobject_unref(resp);
> +}
> +
>  /* Power-on-reset default values and the Die ID */
>  static void test_defaults(void *obj, void *data, QGuestAllocator *alloc)
>  {
> @@ -307,6 +324,46 @@ static void test_cvrf(void *obj, void *data, QGuestAllocator *alloc)
>      g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_CVRF, ==, 0);
>  }
>  
> +/* Shunt-voltage injection limits */
> +static void test_shunt_limits(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +
> +    qmp_ina230_set("shunt-voltage", SHUNT_MAX_NV);
> +    g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, 0x7FFF);
> +    g_assert_cmpint(qmp_ina230_get("shunt-voltage"), ==, SHUNT_MAX_NV);
> +
> +    qmp_ina230_set("shunt-voltage", SHUNT_MIN_NV);
> +    g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, 0x8000);
> +    g_assert_cmpint(qmp_ina230_get("shunt-voltage"), ==, SHUNT_MIN_NV);
> +
> +    qmp_ina230_set_fail("shunt-voltage", (int64_t)SHUNT_MAX_NV + 1);
> +    qmp_ina230_set_fail("shunt-voltage", (int64_t)SHUNT_MIN_NV - 1);
> +    g_assert_cmpint(qmp_ina230_get("shunt-voltage"), ==, SHUNT_MIN_NV);
> +    g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, 0x8000);
> +}
> +
> +/* Bus-voltage injection limits. */
> +static void test_bus_limits(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +
> +    qmp_ina230_set("bus-voltage", 0);
> +    g_assert_cmphex(i2c_get16(dev, REG_BUS), ==, 0x0000);
> +
> +    qmp_ina230_set("bus-voltage", BUS_MAX_UV);
> +    g_assert_cmphex(i2c_get16(dev, REG_BUS), ==, 0x7080);
> +    g_assert_cmpint(qmp_ina230_get("bus-voltage"), ==, BUS_MAX_UV);
> +
> +    qmp_ina230_set_fail("bus-voltage", (int64_t)BUS_MAX_UV + 1);
> +    qmp_ina230_set_fail("bus-voltage", -1);
> +    g_assert_cmpint(qmp_ina230_get("bus-voltage"), ==, BUS_MAX_UV);
> +}
> +
>  static void ina230_register_nodes(void)
>  {
>      QOSGraphEdgeOptions opts = {
> @@ -322,6 +379,8 @@ static void ina230_register_nodes(void)
>      qos_add_test("config-wmask", "ina230", test_config_wmask, NULL);
>      qos_add_test("shunt-injection", "ina230", test_shunt_injection, NULL);
>      qos_add_test("bus-injection", "ina230", test_bus_injection, NULL);
> +    qos_add_test("shunt-limits", "ina230", test_shunt_limits, NULL);
> +    qos_add_test("bus-limits", "ina230", test_bus_limits, NULL);
>      qos_add_test("calibration-current", "ina230", test_calibration_current,
>                   NULL);
>      qos_add_test("power", "ina230", test_power, NULL);
> 


