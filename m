Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701F5C3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH5IS-0000BS-JD; Wed, 14 Oct 2026 16:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xH5IN-00007M-8G; Wed, 14 Oct 2026 16:09:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xH5IL-0004A6-3H; Wed, 14 Oct 2026 16:09:50 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEiU3f695299; Wed, 14 Oct 2026 20:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=3WG0JtmpqLDIJbS/+UNHCfOYYAu/C09vEpGXbtFiBK0=; b=RTg1EaQRmj1r
 3Ziqp88QgtyTtENZkMMHFH5pbkkPMwSheB7hiij7YrAGwBnKuGyf/wPSSAefIM7b
 K+EVbjY/upiGvHGUf+Mz1LFZJyM9aGSgd40F6Yau68/FVQiZxoiJok6j0C0mw+f+
 J53LVCV1cD7B+wrVyE2H64QTOG47lg2kykfilzztVN+futtLBezqLx2vfovp7QFA
 XAYIsRmRzJAlzTiGsyxmPrDETb1S7K1TqUjV1emRhrLaxTn6XgKI066v/QUZ8FYw
 1NaOJ0bjh1o4DGQFrIn4H68rm+tqYDzXihRyZDZtQWR3691yB0SBP9FNnvlOYf+i
 Xsz1MDu5CA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhphpp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 20:09:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EIe1BY3639841; Wed, 14 Oct 2026 20:09:18 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9wvg499t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 20:09:18 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69EK8ViL19726886
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Oct 2026 20:08:31 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BADAE58059;
 Wed, 14 Oct 2026 20:09:17 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC6E458055;
 Wed, 14 Oct 2026 20:09:16 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 Oct 2026 20:09:16 +0000 (GMT)
Message-ID: <a0ebf6ef33670ce46aa51b50ba113ceba1f3f5f5.camel@linux.ibm.com>
Subject: Re: [PATCH v2 42/50] tests/qtest: ina238: cover voltage/temperature
 injection and derivation
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
Date: Wed, 14 Oct 2026 15:09:16 -0500
In-Reply-To: <20261012-bmc-minerva-v2-42-4c3dff084ec9@free.fr>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
 <20261012-bmc-minerva-v2-42-4c3dff084ec9@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX+lVAoCprbmUW
 X4PoQXlUS6sR+HkGRNHXkH991tcZsTwvbliQ+3NPy4ThkSxKhbcHyw0QIWKJwv7ZzLAsOLPaDTG
 E9j1ePDeNfssFOQh0HYefHnG4ePFJ9s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfXzgkRQROXKnCe
 B6RPa1HZN8JGh/H52UF8/vUYFRxQteVxk3KNgXDDLsdZT1WDu8s5nOoxjfOI+PNXRO+n/hq1ZtD
 hiqYvCRdIWZRSqxgbXL5NKFypH9RnbspoLL9upoo+ZFi4wZpPQBS9Psn7AUBKMfX9ZysWOOAsY/
 K2Oe4fD5FOth0njg4PJ8k3OgxXrHjX6tizFwXpaG1DBdDhyE4XoB2CPvl1ll/AHM1HqGw9QsD4f
 uqLsHFwvrqBVLr4Dnfv6F8sQwERthD6zbWpOGQOvESZG/YFYmTlmT8awFKXhoNHRepKSx6gEp8r
 8WBXND9r/jDmCP4vVOH0mOFqyFx3hWj8KwsxWxOAfkUyldfRIlc2Al6BlFpHfzkdXmCyWkIv+qm
 c7q4CCVATGEnYq5mD7b/uYWgJ+ClhoVLT75d6glLdVua/QrRPi8sof5mb48cUwWonky8KEHLk+8
 YXo6uhOHv7J9eOyBhcg==
X-Proofpoint-GUID: 7BvHeaCkK4TWCuk1KJIl8Cw2yDaXObWF
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6acfe170 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=7v0_3JnuglIbc8E0cOcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: F6MSuzESv6y5jKM3VW0DIErSQQDpCWhC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140078
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
> Cover the shunt-, bus- and die-temperature injection properties and the
> current and power values derived through the Shunt Calibration register,
> including the zero-calibration case, the ADCRANGE rescaling and the
> clamp/overflow edges.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  tests/qtest/ina238-test.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 156 insertions(+)
> 
> diff --git a/tests/qtest/ina238-test.c b/tests/qtest/ina238-test.c
> index 6e59ed30b5..693139f988 100644
> --- a/tests/qtest/ina238-test.c
> +++ b/tests/qtest/ina238-test.c
> @@ -89,6 +89,20 @@ static void qmp_ina238_set(const char *property, int value)
>      qobject_unref(resp);
>  }
>  
> +static int qmp_ina238_get(const char *property)
> +{
> +    QDict *resp;
> +    int ret;
> +
> +    resp = qmp("{ 'execute': 'qom-get', 'arguments':"
> +               " { 'path': %s, 'property': %s } }",
> +               INA238_TEST_ID, property);
> +    g_assert(qdict_haskey(resp, "return"));
> +    ret = qdict_get_int(resp, "return");
> +    qobject_unref(resp);
> +    return ret;
> +}
> +
>  /* Power-on-reset default values and the ID registers */
>  static void test_defaults(void *obj, void *data, QGuestAllocator *alloc)
>  {
> @@ -160,6 +174,139 @@ static void test_config_wmask(void *obj, void *data, QGuestAllocator *alloc)
>      g_assert_cmphex(i2c_get16(dev, REG_CONFIG), ==, CONFIG_POR);
>  }
>  
> +/* Shunt voltage register */
> +static void test_shunt_injection(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +
> +    qmp_ina238_set("shunt-voltage", 97200000);
> +    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x4BF0);
> +
> +    qmp_ina238_set("shunt-voltage", -80000000);
> +    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0xC180);
> +
> +    g_assert_cmpint(qmp_ina238_get("shunt-voltage"), ==, -80000000);
> +}
> +
> +/* Bus voltage register */
> +static void test_bus_injection(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +
> +    qmp_ina238_set("bus-voltage", 48000000);
> +    g_assert_cmphex(i2c_get16(dev, REG_VBUS), ==, 0x3C00);
> +
> +    qmp_ina238_set("bus-voltage", 12000000);
> +    g_assert_cmphex(i2c_get16(dev, REG_VBUS), ==, 0x0F00);
> +}
> +
> +/* Die temperature register */
> +static void test_temp_injection(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +
> +    qmp_ina238_set("die-temperature", 25000);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIETEMP), ==, 0x0C80);
> +
> +    qmp_ina238_set("die-temperature", -25000);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIETEMP), ==, 0xF380);
> +
> +    g_assert_cmpint(qmp_ina238_get("die-temperature"), ==, -25000);
> +}
> +
> +/* Calibration-derived current */
> +static void test_calibration_current(void *obj, void *data,
> +                                     QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +    qmp_ina238_set("shunt-voltage", 97200000);
> +
> +    i2c_set16(dev, REG_SHUNT_CAL, 0x0000);
> +    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x0000);
> +
> +    i2c_set16(dev, REG_SHUNT_CAL, 0x0FD2);
> +    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x4CCC);
> +}
> +
> +/* Calibration-derived power */
> +static void test_power(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +    qmp_ina238_set("shunt-voltage", 97200000);
> +    qmp_ina238_set("bus-voltage", 48000000);
> +    i2c_set16(dev, REG_SHUNT_CAL, 0x0FD2);
> +
> +    g_assert_cmpuint(i2c_get24(dev, REG_POWER), ==, 4718400);
> +}
> +
> +/* With SHUNT_CAL == 0 the current and power registers stay zero */
> +static void test_zero_cal(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +    i2c_set16(dev, REG_SHUNT_CAL, 0x0000);
> +    qmp_ina238_set("shunt-voltage", 97200000);
> +    qmp_ina238_set("bus-voltage", 48000000);
> +
> +    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x0000);
> +    g_assert_cmpuint(i2c_get24(dev, REG_POWER), ==, 0);
> +}
> +
> +/* ADCRANGE changes the shunt LSB, not the current divisor. */
> +static void test_adcrange(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +
> +    qmp_ina238_set("shunt-voltage", 20000000);
> +    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x0FA0);
> +
> +    i2c_set16(dev, REG_SHUNT_CAL, 0x0800);
> +    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x1F40);
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_ADCRANGE);
> +    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x3E80);
> +
> +    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x7D00);
> +
> +    i2c_set16(dev, REG_SHUNT_CAL, 0x2000);
> +    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x1F40);
> +}
> +
> +/* Clamping at full scale and the MATHOF flag */
> +static void test_overflow(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_ADCRANGE);
> +    qmp_ina238_set("shunt-voltage", 97200000);
> +    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x7FFF);
> +    qmp_ina238_set("shunt-voltage", -97200000);
> +    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x8000);
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_POR);
> +    qmp_ina238_set("shunt-voltage", 163835000);
> +    i2c_set16(dev, REG_SHUNT_CAL, 0x0001);
> +    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x7FFF);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_MATHOF, ==,
> +                    DIAG_MATHOF);
> +}
> +
> +/* Shunt over-limit alert (transparent mode) */
>  static void ina238_register_nodes(void)
>  {
>      QOSGraphEdgeOptions opts = {
> @@ -173,5 +320,14 @@ static void ina238_register_nodes(void)
>      qos_add_test("defaults", "ina238", test_defaults, NULL);
>      qos_add_test("soft-reset", "ina238", test_soft_reset, NULL);
>      qos_add_test("config-wmask", "ina238", test_config_wmask, NULL);
> +    qos_add_test("shunt-injection", "ina238", test_shunt_injection, NULL);
> +    qos_add_test("bus-injection", "ina238", test_bus_injection, NULL);
> +    qos_add_test("temp-injection", "ina238", test_temp_injection, NULL);
> +    qos_add_test("calibration-current", "ina238", test_calibration_current,
> +                 NULL);
> +    qos_add_test("power", "ina238", test_power, NULL);
> +    qos_add_test("zero-cal", "ina238", test_zero_cal, NULL);
> +    qos_add_test("adcrange", "ina238", test_adcrange, NULL);
> +    qos_add_test("overflow", "ina238", test_overflow, NULL);
>  }
>  libqos_init(ina238_register_nodes);
> 


