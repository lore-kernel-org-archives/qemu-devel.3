Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D957DCC6B3D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 14:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHMJR-0001Ai-0O; Thu, 15 Oct 2026 10:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xHMJJ-000187-Lu; Thu, 15 Oct 2026 10:19:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xHMJH-0003kB-Hx; Thu, 15 Oct 2026 10:19:57 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F9kDvD667554; Thu, 15 Oct 2026 14:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=GE7OgHykCjkvno9cq0CLxmpxnq49ITCLNUyDfWX8sY4=; b=EJPnLXCO6rPL
 H6JjunkcoNa9AHpPbQr3SS4h+d0XdMWO9f0Z5YADRSLvVCHDWIg1NMIo7R0IhOBb
 ZJBvWJ3Fg9sDPn7fkfAYayHDgGfc1UETtVNfcQ4hmoid1tjo7XqUS8rKL/MkYYlB
 nO5LJ9OVsO/E4TREBCVVEhENk3ysHEGTh6ExhhRhhS6N4S9kWlVnhJCsXzRX7+cf
 o1StC5XfYdAomXtp7qGJ6jZRp3MDcMHD2AmrTcO9ADUCpv/YwP96QhnwZLg+Tlim
 oUeTGRRAL+n3s3TVDmdYRFucaKhWgID4QQcMk0iH0vLcwKRzQnGE7XNKexvFo/Lh
 cIJpiW+RxQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dugtdya-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 15 Oct 2026 14:19:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FE0HfT1974785; Thu, 15 Oct 2026 14:19:29 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9qb71sy1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Oct 2026 14:19:29 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69FEJTE830737034
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Oct 2026 14:19:29 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E27758055;
 Thu, 15 Oct 2026 14:19:29 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8ABFC58059;
 Thu, 15 Oct 2026 14:19:28 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 Oct 2026 14:19:28 +0000 (GMT)
Message-ID: <788018be1890d261409a9ac86d2a31ef452d5923.camel@linux.ibm.com>
Subject: Re: [PATCH v3 37/50] tests/qtest: ina230: cover operating modes and
 triggered conversions
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
Date: Thu, 15 Oct 2026 09:19:28 -0500
In-Reply-To: <20261015-bmc-minerva-v3-37-7d50c8a108e5@free.fr>
References: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
 <20261015-bmc-minerva-v3-37-7d50c8a108e5@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6ad0e0f3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=ahjBMUgcp2ig2-Mr0kAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9uodHzUlFeCXHzwE0DZYk9sE0HInFQ1-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1NiBTYWx0ZWRfX9XdB2AtPsaf7
 FcUEovGmsLu1/2/ZdwiRsXny6uxlDSXL78QkoY3mKL54q/rJSHoxquWdbFnX9zOvpqp3WkJM4+t
 /ZYxia1DE0KH1UuggVDwA7Bzbwdn38MjwPJLhBSS+G99bZlfW/CmVIOmANoFG7SJuuP7NOHO9Vc
 IMzKOEFBw3WuC9CKRVDu06MRbzIZuNLtE5WHwYV7b5fYm2U/7vBqoxTfKIPeRpf4+avXL4FUgU3
 XSq0XMeO4IRMMLWoNmCsB/nuUw74clyeTjrHpwIF21URfD9jN76xYb6tjthGuCZgf/vLfjCMm1i
 w85RzuDFh7kZIk2XQxkbb/ZjWCLuYpxI1abNbfvnH28b/dEtL/B4YNtQU4xEiZR1Anw4aPTlxot
 34m4J83Gx17we5zq+WxBOfiaakaxED9SlxTVbl2P+TQ4WuEPQj4LWs6WK1Wi85vlFOey1oCBr9j
 pNRbLxBD8StOGQYjvMw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1NiBTYWx0ZWRfX4Fm0p+jRGXYt
 RorZ6Bp5NG7TZyGsEb0hlP4Y3za74JO9RXwTaWK7M+W0jnXRZGgUQstNGHCzX0PuCCQVWHL6pGM
 xxXwSiu5RA3QiTWmgmvycWzyOcTzEAY=
X-Proofpoint-ORIG-GUID: vmvbs1va1ZDA9y0an5-J6EUOrOqD8Ey4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150056
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

On Thu, 2026-10-15 at 11:28 +0200, Emmanuel Blot via qemu development
wrote:
> Add coverage for the MODE field: power-down retains the last results,
> the shunt/bus channel-enable bits gate which registers track new inputs,
> triggered modes convert once per Config write, and bus-only mode still
> derives power from the retained current.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  tests/qtest/ina230-test.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 94 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/ina230-test.c b/tests/qtest/ina230-test.c
> index 36c899efee..4d601c74b5 100644
> --- a/tests/qtest/ina230-test.c
> +++ b/tests/qtest/ina230-test.c
> @@ -142,7 +142,97 @@ static void test_config_wmask(void *obj, void *data, QGuestAllocator *alloc)
>      g_assert_cmphex(i2c_get16(dev, REG_CONFIG), ==, 0x7FFF);
>  }
>  
> -/* Shunt voltage register, including two's-complement negatives */
> +/* Operating modes */
> +static void test_modes(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +    static const struct {
> +        uint8_t mode;
> +        uint16_t shunt, bus, current, power;
> +    } cases[] = {
> +        /* Power-down: no conversion, every register retains the baseline */
> +        { 0x0, 0x1F40, 0x2570, 0x2710, 0x12B8 },
> +        { 0x4, 0x1F40, 0x2570, 0x2710, 0x12B8 },
> +        /* Shunt only (continuous): shunt and current track the probe */
> +        { 0x5, 0x0FA0, 0x2570, 0x1388, 0x12B8 },
> +        /* Shunt and bus (continuous): every register tracks the probe */
> +        { 0x7, 0x0FA0, 0x12C0, 0x1388, 0x04B0 },
> +    };
> +    size_t idx;
> +
> +    for (idx = 0; idx < ARRAY_SIZE(cases); idx++) {
> +        i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +        i2c_set16(dev, REG_CALIBRATION, 0x0A00);
> +        qmp_ina230_set("shunt-voltage", 20000000);
> +        qmp_ina230_set("bus-voltage", 11980000);
> +
> +        i2c_set16(dev, REG_CONFIG, cases[idx].mode);
> +        qmp_ina230_set("shunt-voltage", 10000000);
> +        qmp_ina230_set("bus-voltage", 6000000);
> +
> +        g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, cases[idx].shunt);
> +        g_assert_cmphex(i2c_get16(dev, REG_BUS), ==, cases[idx].bus);
> +        g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, cases[idx].current);
> +        g_assert_cmphex(i2c_get16(dev, REG_POWER), ==, cases[idx].power);
> +    }
> +}
> +
> +/*
> + * Triggered modes perform exactly one conversion per trigger, where the
> + * trigger is a Configuration-register write. Injected input changes
> + * between triggers are ignored until the next write.
> + */
> +static void test_triggered(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +    i2c_set16(dev, REG_CALIBRATION, 0x0A00);
> +
> +    qmp_ina230_set("shunt-voltage", 20000000);
> +    qmp_ina230_set("bus-voltage", 11980000);
> +
> +    i2c_set16(dev, REG_CONFIG, 0x03);
> +    g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, 0x1F40);
> +    g_assert_cmphex(i2c_get16(dev, REG_BUS), ==, 0x2570);
> +
> +    qmp_ina230_set("shunt-voltage", 10000000);
> +    qmp_ina230_set("bus-voltage", 6000000);
> +    g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, 0x1F40);
> +    g_assert_cmphex(i2c_get16(dev, REG_BUS), ==, 0x2570);
> +
> +    i2c_set16(dev, REG_CONFIG, 0x03);
> +    g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, 0x0FA0);
> +    g_assert_cmphex(i2c_get16(dev, REG_BUS), ==, 0x12C0);
> +
> +    i2c_set16(dev, REG_CONFIG, 0x07);
> +    qmp_ina230_set("shunt-voltage", 20000000);
> +    g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, 0x1F40);
> +}
> +
> +/*
> + * In a bus-only mode the current register is retained, but the power register
> + * is still refreshed on each bus conversion from that retained current.
> + */
> +static void test_bus_only_power(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +    i2c_set16(dev, REG_CALIBRATION, 0x0A00);
> +    qmp_ina230_set("shunt-voltage", 20000000);
> +    qmp_ina230_set("bus-voltage", 11980000);
> +    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x2710);
> +
> +    i2c_set16(dev, REG_CONFIG, 0x06);
> +    qmp_ina230_set("bus-voltage", 6000000);
> +
> +    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x2710);
> +    g_assert_cmphex(i2c_get16(dev, REG_BUS), ==, 0x12C0);
> +    g_assert_cmphex(i2c_get16(dev, REG_POWER), ==, 0x0960);
> +}
> +
> +/* Shunt voltage register */
>  static void test_shunt_injection(void *obj, void *data, QGuestAllocator *alloc)
>  {
>      QI2CDevice *dev = (QI2CDevice *)obj;
> @@ -377,6 +467,9 @@ static void ina230_register_nodes(void)
>      qos_add_test("defaults", "ina230", test_defaults, NULL);
>      qos_add_test("soft-reset", "ina230", test_soft_reset, NULL);
>      qos_add_test("config-wmask", "ina230", test_config_wmask, NULL);
> +    qos_add_test("modes", "ina230", test_modes, NULL);
> +    qos_add_test("triggered", "ina230", test_triggered, NULL);
> +    qos_add_test("bus-only-power", "ina230", test_bus_only_power, NULL);
>      qos_add_test("shunt-injection", "ina230", test_shunt_injection, NULL);
>      qos_add_test("bus-injection", "ina230", test_bus_injection, NULL);
>      qos_add_test("shunt-limits", "ina230", test_shunt_limits, NULL);
> 


