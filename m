Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7E3CC6B2C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH5Jb-0001c4-2O; Wed, 14 Oct 2026 16:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xH5JY-0001ZN-Q2; Wed, 14 Oct 2026 16:11:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xH5JW-0004TC-T5; Wed, 14 Oct 2026 16:11:04 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEiAkL2426472; Wed, 14 Oct 2026 20:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=y1o8XAEl+swq07fBCjmnX/z09AWv2jyZ1e71avxGLtg=; b=f3QtkMP7kLHk
 FcN/pCLJHR16iZejj8Jbk01U7pX37GuI/hCg2khcn4au84nncTfzbcqDGL+uIUpn
 LvufBxUORoPxG1EE90KqliM2jHaP+ZVQgkiShqZ4a4JCkmko3VwB0cm+uJlEdwum
 yAH9NfB0gFeToei+9P/Y6comJZq+k1K0AChdFXTgVQa9S/6fhEPrep3y1Nw45ms4
 5mFjkL90vBmju7MmgruWU0TJFT0TzRIIk/Sph+71ISYXvO4mBWVgS3qLWuYe/m4o
 eQ4K402pDVWu3eytkWBttVdnEKDi0IpS3U1B1i0FDLamNPM7G5kHZ00qZnks0PiO
 fKdWKr8dIA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv3pg9w-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 20:10:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EIV9oO3639694; Wed, 14 Oct 2026 20:10:40 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9wvg49fm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 20:10:40 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69EK9qXL16122424
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Oct 2026 20:09:53 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01E2F58069;
 Wed, 14 Oct 2026 20:10:39 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2413858071;
 Wed, 14 Oct 2026 20:10:38 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 Oct 2026 20:10:38 +0000 (GMT)
Message-ID: <b4524f635d031e9a401cb297468e29e32c81ee37.camel@linux.ibm.com>
Subject: Re: [PATCH v2 44/50] tests/qtest: ina238: cover the
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
Date: Wed, 14 Oct 2026 15:10:37 -0500
In-Reply-To: <20261012-bmc-minerva-v2-44-4c3dff084ec9@free.fr>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
 <20261012-bmc-minerva-v2-44-4c3dff084ec9@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: CQpXNpPFlW6sRcwz7g2MYQxq7lj0RZC5
X-Proofpoint-ORIG-GUID: V2b5mPGYeRRHFT3McoQ_EjsoGUb9qlNY
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6acfe1c1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=7KmHHMH6RqfjYMQ9tJgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfXxYFmk6PYmwN4
 rTyVKi1fFBra6BpT6vhvvBBU7LeqyAZk+j09ICBzvohNfcw/cj7dmR9GJ1Tiergvzl5UdkZdsra
 BbOkUyBgny4+N/vc5mQeu9ZEXXDyzo0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX7KEaUL+0aMUa
 ZkTkmUY93fJ6WuYMEKoLDm0PHBw1l8PkLmR0+XGZVxrNXQkop3O625r0QqxOY4BLKNNTb+2+0r+
 5WfCVubRS2lYiySmI/+T/M4F8G4IiHTWIp/32Xk4Q+BYRLRSf3/nSerPsgu0KtxzP01GboFdg1v
 o+L7cIx5G1jYLr6l35PuHjl9bFjizBZ977qB5nCnkTrUU1S137TEunfWD1vmAjzL1nZEqq/ix4s
 M7PZDF+d2lJ6y8xyqcKsS5W1Dby+PYg9MoVtHHe78sUI/c40N1P49LT4ThMU/7XGOUpKE4ElTnX
 vB8QPT9qqCDXWjMjo9bPtpQUuc+S1ZGLFhqVArj6QNQiV8hm6mrTWYxmiegh0wuY6EdsCzm1xwL
 M9CBCQ5ptoeUjySaZrafR+6FZZ9wVtG/D3jqnc7X+6riIgwtZQqtwjDG0aAwQA0zu4kNLLRjmti
 5+7WaThMX1f6UXWGGkA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
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
> Verify that the extremes of the shunt-voltage, bus-voltage and
> die-temperature injection ranges round-trip through the QOM property
> without truncation or wraparound, and that values just outside are
> rejected rather than silently wrapped.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  tests/qtest/ina238-test.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/tests/qtest/ina238-test.c b/tests/qtest/ina238-test.c
> index 08813377c9..74912424c0 100644
> --- a/tests/qtest/ina238-test.c
> +++ b/tests/qtest/ina238-test.c
> @@ -67,6 +67,13 @@
>  #define MANUFACTURER_ID_VAL 0x5449
>  #define DEVICE_ID_VAL       0x2381
>  
> +/* Injection-property limits (see ina238.c) */
> +#define SHUNT_MIN_NV        (-163840000) /* -32768 * 5 uV  */
> +#define SHUNT_MAX_NV        163835000    /*  32767 * 5 uV  */
> +#define BUS_MAX_UV          85000000     /* 27200 * 3.125 mV */
> +#define TEMP_MIN_MC         (-40000)     /*  -320 * 125 m-degC */
> +#define TEMP_MAX_MC         125000       /*  1000 * 125 m-degC */
> +
>  /* Read the 24-bit POWER register (MSB first) */
>  static uint32_t i2c_get24(QI2CDevice *dev, uint8_t reg)
>  {
> @@ -103,6 +110,18 @@ static int qmp_ina238_get(const char *property)
>      return ret;
>  }
>  
> +/* A qom-set expected to be rejected (value outside the supported range) */
> +static void qmp_ina238_set_fail(const char *property, int64_t value)
> +{
> +    QDict *resp;
> +
> +    resp = qmp("{ 'execute': 'qom-set', 'arguments':"
> +               " { 'path': %s, 'property': %s, 'value': %lld } }",
> +               INA238_TEST_ID, property, (long long)value);
> +    g_assert(qdict_haskey(resp, "error"));
> +    qobject_unref(resp);
> +}
> +
>  /* Power-on-reset default values and the ID registers */
>  static void test_defaults(void *obj, void *data, QGuestAllocator *alloc)
>  {
> @@ -443,6 +462,68 @@ static void test_cnvrf(void *obj, void *data, QGuestAllocator *alloc)
>      g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_CNVRF, ==, 0);
>  }
>  
> +/* Shunt-voltage injection limits */
> +static void test_shunt_limits(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +
> +    qmp_ina238_set("shunt-voltage", SHUNT_MAX_NV);
> +    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x7FFF);
> +    g_assert_cmpint(qmp_ina238_get("shunt-voltage"), ==, SHUNT_MAX_NV);
> +
> +    qmp_ina238_set("shunt-voltage", SHUNT_MIN_NV);
> +    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x8000);
> +    g_assert_cmpint(qmp_ina238_get("shunt-voltage"), ==, SHUNT_MIN_NV);
> +
> +    qmp_ina238_set_fail("shunt-voltage", (int64_t)SHUNT_MAX_NV + 1);
> +    qmp_ina238_set_fail("shunt-voltage", (int64_t)SHUNT_MIN_NV - 1);
> +    g_assert_cmpint(qmp_ina238_get("shunt-voltage"), ==, SHUNT_MIN_NV);
> +    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x8000);
> +}
> +
> +/* Bus-voltage injection limits */
> +static void test_bus_limits(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +
> +    qmp_ina238_set("bus-voltage", 0);
> +    g_assert_cmphex(i2c_get16(dev, REG_VBUS), ==, 0x0000);
> +
> +    qmp_ina238_set("bus-voltage", BUS_MAX_UV);
> +    g_assert_cmphex(i2c_get16(dev, REG_VBUS), ==, 0x6A40);
> +    g_assert_cmpint(qmp_ina238_get("bus-voltage"), ==, BUS_MAX_UV);
> +
> +    qmp_ina238_set_fail("bus-voltage", (int64_t)BUS_MAX_UV + 1);
> +    qmp_ina238_set_fail("bus-voltage", -1);
> +    g_assert_cmpint(qmp_ina238_get("bus-voltage"), ==, BUS_MAX_UV);
> +    g_assert_cmphex(i2c_get16(dev, REG_VBUS), ==, 0x6A40);
> +}
> +
> +/* Die-temperature injection limits */
> +static void test_temp_limits(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +
> +    qmp_ina238_set("die-temperature", TEMP_MAX_MC);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIETEMP), ==, 0x3E80);
> +    g_assert_cmpint(qmp_ina238_get("die-temperature"), ==, TEMP_MAX_MC);
> +
> +    qmp_ina238_set("die-temperature", TEMP_MIN_MC);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIETEMP), ==, 0xEC00);
> +    g_assert_cmpint(qmp_ina238_get("die-temperature"), ==, TEMP_MIN_MC);
> +
> +    qmp_ina238_set_fail("die-temperature", (int64_t)TEMP_MAX_MC + 1);
> +    qmp_ina238_set_fail("die-temperature", (int64_t)TEMP_MIN_MC - 1);
> +    g_assert_cmpint(qmp_ina238_get("die-temperature"), ==, TEMP_MIN_MC);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIETEMP), ==, 0xEC00);
> +}
> +
>  static void ina238_register_nodes(void)
>  {
>      QOSGraphEdgeOptions opts = {
> @@ -459,6 +540,9 @@ static void ina238_register_nodes(void)
>      qos_add_test("shunt-injection", "ina238", test_shunt_injection, NULL);
>      qos_add_test("bus-injection", "ina238", test_bus_injection, NULL);
>      qos_add_test("temp-injection", "ina238", test_temp_injection, NULL);
> +    qos_add_test("shunt-limits", "ina238", test_shunt_limits, NULL);
> +    qos_add_test("bus-limits", "ina238", test_bus_limits, NULL);
> +    qos_add_test("temp-limits", "ina238", test_temp_limits, NULL);
>      qos_add_test("calibration-current", "ina238", test_calibration_current,
>                   NULL);
>      qos_add_test("power", "ina238", test_power, NULL);
> 


