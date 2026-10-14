Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A317DC3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH5J5-0000pe-3l; Wed, 14 Oct 2026 16:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xH5J0-0000gq-3A; Wed, 14 Oct 2026 16:10:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xH5Iy-0004ON-5M; Wed, 14 Oct 2026 16:10:29 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEiTLQ2327308; Wed, 14 Oct 2026 20:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=92joCC02wi8uwedHK5pr98VMPEBl+RcfC9Zuz+BfDvY=; b=N7tuqt7vQevM
 DQ/jX8iiLy8KlUMoDsbgxxFfmmqzAx1XIMlSkd/Wocx8r5Jpck3pNqgqiRnOeOJK
 ArI9snkUTGIFeM8kUSeY6JqIJQRS+crlncD8xHGlM0aZUnx3OaKUWyhwtG7DJl3I
 KO988mJRVCgGf6ddU0lmB1MxXspy6tvUWN7/jAsKjnf/HSiuouc99pcjFQVL7BZX
 ETKLBe/ciV/17WDVf6aLmj9LcbsNCmzdekKpeVe0kQgr5K9hREZrO3Arrl9mAPeL
 cW+5oHN5lMATj2Ps+evmou4gQRSYPSASV2oJ6dWbJT5TsW3S5i6hhpcGxz64vh8z
 RZ2LgBxXug==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwj61yv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 20:09:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EIl1BL669873; Wed, 14 Oct 2026 20:09:56 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h9ypq3weg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 20:09:56 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69EK9taE51314972
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Oct 2026 20:09:55 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8FD065803F;
 Wed, 14 Oct 2026 20:09:55 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23C6F58056;
 Wed, 14 Oct 2026 20:09:54 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 Oct 2026 20:09:54 +0000 (GMT)
Message-ID: <3f5d3a0a78e882e24e008eb64d74a837d3328947.camel@linux.ibm.com>
Subject: Re: [PATCH v2 43/50] tests/qtest: ina238: cover the ALERT path and
 conversion-ready flag
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
Date: Wed, 14 Oct 2026 15:09:53 -0500
In-Reply-To: <20261012-bmc-minerva-v2-43-4c3dff084ec9@free.fr>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
 <20261012-bmc-minerva-v2-43-4c3dff084ec9@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX+ZGziGkjSy0d
 +CTgqTwTbzOhlp/TGSK6eLZMqKQAD/9KDu0XtQcLX8frvVx0q24Ssy/xNpIH0xyLvGCN9cHJKde
 eVsyE1/hnnmdN65xmniVNPbqv5u31vUPHRatqaI5CfpRSAZwCQpf1jdgN61/fIRIINcGMzD3tKX
 qs10od/HeWYLx7m9x6Jpy4f67KlYuZi5ZouRYUYuBTZJp7NpeLFyAujoM5WpDGrJyXWd7+kSmwy
 nHp94XSCICugK3hUfU9K9gCByrpHrduq8PQ6B9Vgm8IQjR4eB20yoPuNvSDqHlwyDdPifpHB5u8
 05ME/B0oHV7yQ+qK1XToRkYnY+kgkIax+oOeOmNJAvBi3QL3YgzIp039IscdDH9d/ptb/49Vj19
 /+y8dDOkerUnXii1SxIV9vsrCLRFyqTgLtjjxpYIUwSgNfrtAadoZ2PhdSH4KtVfg4oRYLBhlVy
 i+eyOhTMQkB8iwk4iAA==
X-Proofpoint-GUID: p1p4eB10hv0rV3jwyaF6YsBEBG0317vB
X-Proofpoint-ORIG-GUID: h_rb8gGiJ1wu6qDQKtTs8kNXU5al4Lwd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX7h8SmENMnhMd
 tQ29WPYBFEErLO+S3RyTDnQExxJn4yKU2kWJu8BAywTq9SzX24bLDZLhjPFW5NJAtsmvSvbMIX0
 2Jjo6vMDVwSmiCYb96b9f9KkrHNur+E=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6acfe195 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=KK12PQLjfu8lHadZ5AAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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
> Cover the shunt/bus/temperature/power alert thresholds, the multi-alert
> OR behaviour, the alert latch, the DIAG_ALRT control bits and the
> conversion-ready (CNVRF) flag.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  tests/qtest/ina238-test.c | 146 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 145 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/ina238-test.c b/tests/qtest/ina238-test.c
> index 693139f988..08813377c9 100644
> --- a/tests/qtest/ina238-test.c
> +++ b/tests/qtest/ina238-test.c
> @@ -306,7 +306,143 @@ static void test_overflow(void *obj, void *data, QGuestAllocator *alloc)
>                      DIAG_MATHOF);
>  }
>  
> -/* Shunt over-limit alert (transparent mode) */
> +/* Shunt over-limit alert */
> +static void test_alert_shunt(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +    i2c_set16(dev, REG_SOVL, 0x1000);
> +
> +    qmp_ina238_set("shunt-voltage", 5000000);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==, 0);
> +
> +    qmp_ina238_set("shunt-voltage", 97200000);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==,
> +                    DIAG_SHNTOL);
> +
> +    qmp_ina238_set("shunt-voltage", 5000000);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==, 0);
> +}
> +
> +/* Bus over-limit alert */
> +static void test_alert_bus(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +    i2c_set16(dev, REG_BOVL, 0x1000);
> +
> +    qmp_ina238_set("bus-voltage", 12000000);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_BUSOL, ==, 0);
> +
> +    qmp_ina238_set("bus-voltage", 48000000);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_BUSOL, ==, DIAG_BUSOL);
> +}
> +
> +/* Over-temperature alert */
> +static void test_alert_temp(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +    i2c_set16(dev, REG_TEMP_LIMIT, 0x0A00);
> +
> +    qmp_ina238_set("die-temperature", 10000);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_TMPOL, ==, 0);
> +
> +    qmp_ina238_set("die-temperature", 25000);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_TMPOL, ==, DIAG_TMPOL);
> +}
> +
> +/* Power over-limit alert */
> +static void test_alert_power(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +    qmp_ina238_set("shunt-voltage", 97200000);
> +    qmp_ina238_set("bus-voltage", 48000000);
> +    i2c_set16(dev, REG_SHUNT_CAL, 0x0FD2);
> +
> +    i2c_set16(dev, REG_PWR_LIMIT, 0x0100);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_POL, ==, DIAG_POL);
> +
> +    i2c_set16(dev, REG_PWR_LIMIT, 0x7FFF);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_POL, ==, 0);
> +}
> +
> +/* Two thresholds crossed at once are reported simultaneously (multi-alert) */
> +static void test_alert_multi(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +    uint16_t diag;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +    i2c_set16(dev, REG_SOVL, 0x1000);
> +    i2c_set16(dev, REG_BOVL, 0x1000);
> +
> +    qmp_ina238_set("shunt-voltage", 97200000);
> +    qmp_ina238_set("bus-voltage", 48000000);
> +
> +    diag = i2c_get16(dev, REG_DIAG_ALRT);
> +    g_assert_cmphex(diag & DIAG_SHNTOL, ==, DIAG_SHNTOL);
> +    g_assert_cmphex(diag & DIAG_BUSOL, ==, DIAG_BUSOL);
> +}
> +
> +/* Latch mode holds the flag until the DIAG_ALRT register is read */
> +static void test_alert_latch(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +    i2c_set16(dev, REG_SOVL, 0x1000);
> +    i2c_set16(dev, REG_DIAG_ALRT, DIAG_ALATCH);
> +
> +    qmp_ina238_set("shunt-voltage", 97200000);
> +    qmp_ina238_set("shunt-voltage", 5000000);
> +
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==,
> +                    DIAG_SHNTOL);
> +
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==, 0);
> +}
> +
> +/* DIAG_ALRT control bits are writable; status bits are read-only */
> +static void test_diag_control(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +    uint16_t diag;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +
> +    i2c_set16(dev, REG_DIAG_ALRT,
> +              DIAG_ALATCH | DIAG_CNVR | DIAG_SLOWALERT | DIAG_APOL);
> +    diag = i2c_get16(dev, REG_DIAG_ALRT);
> +    g_assert_cmphex(diag & DIAG_ALATCH, ==, DIAG_ALATCH);
> +    g_assert_cmphex(diag & DIAG_CNVR, ==, DIAG_CNVR);
> +    g_assert_cmphex(diag & DIAG_SLOWALERT, ==, DIAG_SLOWALERT);
> +    g_assert_cmphex(diag & DIAG_APOL, ==, DIAG_APOL);
> +    /* MEMSTAT stays set */
> +    g_assert_cmphex(diag & DIAG_MEMSTAT, ==, DIAG_MEMSTAT);
> +}
> +
> +/* Every DIAG_ALRT read clears CNVRF, whatever the alert-latch mode. */
> +static void test_cnvrf(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +    qmp_ina238_set("shunt-voltage", 20000000);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_CNVRF, ==, DIAG_CNVRF);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_CNVRF, ==, 0);
> +
> +    i2c_set16(dev, REG_DIAG_ALRT, DIAG_ALATCH);
> +    qmp_ina238_set("shunt-voltage", 20000000);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_CNVRF, ==, DIAG_CNVRF);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_CNVRF, ==, 0);
> +}
> +
>  static void ina238_register_nodes(void)
>  {
>      QOSGraphEdgeOptions opts = {
> @@ -329,5 +465,13 @@ static void ina238_register_nodes(void)
>      qos_add_test("zero-cal", "ina238", test_zero_cal, NULL);
>      qos_add_test("adcrange", "ina238", test_adcrange, NULL);
>      qos_add_test("overflow", "ina238", test_overflow, NULL);
> +    qos_add_test("alert-shunt", "ina238", test_alert_shunt, NULL);
> +    qos_add_test("alert-bus", "ina238", test_alert_bus, NULL);
> +    qos_add_test("alert-temp", "ina238", test_alert_temp, NULL);
> +    qos_add_test("alert-power", "ina238", test_alert_power, NULL);
> +    qos_add_test("alert-multi", "ina238", test_alert_multi, NULL);
> +    qos_add_test("alert-latch", "ina238", test_alert_latch, NULL);
> +    qos_add_test("diag-control", "ina238", test_diag_control, NULL);
> +    qos_add_test("cnvrf", "ina238", test_cnvrf, NULL);
>  }
>  libqos_init(ina238_register_nodes);
> 


