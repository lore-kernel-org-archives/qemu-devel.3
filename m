Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0D1CC6B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH5Es-0004hC-H9; Wed, 14 Oct 2026 16:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xH5Ed-0004Zn-0c; Wed, 14 Oct 2026 16:06:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xH5EZ-0003oe-R3; Wed, 14 Oct 2026 16:05:57 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEiSj12327285; Wed, 14 Oct 2026 20:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=Eb+l+gSnZgJ0rv3TV+ye7cjNMJjIdZHwrw9Qr84DkNg=; b=A19tk3A3VjX+
 fxwRhFccORok4X7a9ticneFzRKVGx9VZKTpOfDUjeDxthw9e/hXK/nL8zuuHBUvq
 C2mAzklnNsil2DDEwfqCarJ3ZH8/chmjiHvpSwvjHJd2wocEZwMUB7yPhwtxT5pk
 3Wffgi1a5BwOcLYRINh06XnknjLaRaO6MrrCbgRtVo/wel8mIcnV/JGKyflehW53
 uKfJs9Q95aEargkQO6Uni7+LYHSCi/SJs+S+uYzOI/ZUJ+bKGlSG+4PXoqkdomtC
 yNhn+8pzqjbaN3sYfAQOg8A0L0qyK9L0ml4z9+x5YsosFB+APsw8SjB8hbij9GFv
 lWC+eTSUyg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwj61hd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 20:05:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EIYlH3702834; Wed, 14 Oct 2026 20:05:32 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816h8yr0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 20:05:32 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69EK5VBq58982818
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Oct 2026 20:05:31 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B0A058063;
 Wed, 14 Oct 2026 20:05:31 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E80758064;
 Wed, 14 Oct 2026 20:05:30 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 Oct 2026 20:05:30 +0000 (GMT)
Message-ID: <094500a3de467d2a3965d6b266a5d18152c737d2.camel@linux.ibm.com>
Subject: Re: [PATCH v2 35/50] tests/qtest: ina230: cover the ALERT limit
 functions and CVRF
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
Date: Wed, 14 Oct 2026 15:05:30 -0500
In-Reply-To: <20261012-bmc-minerva-v2-35-4c3dff084ec9@free.fr>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
 <20261012-bmc-minerva-v2-35-4c3dff084ec9@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX3Rn+L+TbcuQf
 jBZr7960AM3Rk6aLr7hy0gdM3KHKeiyocznxy7IoX8sOfjCYwYj7BTRXbooK01loHh2OX7zKIZj
 hkJkIkFV/fYOo+lbUfhh/NWkMDsQEB5N7yEQ63aKlRWI5guejejPe5PiF9gfOn8G5InP2JQjyFv
 ed/0ZDnKXt7U5YftYHfCOGCckbF3Td6DTLmiFxzXxaH/O/Jij40pqNcMnEJYAInAW+nvynnZvi6
 E463kdlNXWJjOL9vB5yg/fI/dzqhIgFr8wDHdWUMDfY2ujYSFzPcv+5QG1JP8hVvxfqFB23F2yA
 EFc6ZmAZdiJvZoHQtXWK4GL3+AIU8hDBaWNcQc2dHblqsmdENhQQCYp13QRFPlIItC2HPW3urRI
 qajTMpqkFPAfPdHG1srfCsg/WnQp0FugMZ0bBWtHpCvyzxTJ1+2IHgIDxp/VH4LYn9ygO75/59q
 GSmRS0lRQcCE7QwGE+A==
X-Proofpoint-GUID: 20ccIbQ14dPszO5cLD3IicKYZMQCCB0H
X-Proofpoint-ORIG-GUID: O4n-JoobOohGgiYdyymFMbJdoPqy5kG6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfXxxR8NyoaxiFV
 7/AbRKxQSgOq7xOpZu3crnQFaBy6Np/QlUd3ClUVvkvgirlqRKK3+6z4Lu9PQFL0e5C0ocU76Cf
 y1h+yPE8tKXpBgWd1nrKnhpDdYnw5Dw=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6acfe08d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=1PLVCyDoYtK9kODSvwUA:9 a=QEXdDO2ut3YA:10
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
> Cover the shunt/bus/power alert-limit functions, the alert latch
> behaviour and the conversion-ready flag.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  tests/qtest/ina230-test.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
> 
> diff --git a/tests/qtest/ina230-test.c b/tests/qtest/ina230-test.c
> index b01f9445d1..1c55028fcb 100644
> --- a/tests/qtest/ina230-test.c
> +++ b/tests/qtest/ina230-test.c
> @@ -215,6 +215,98 @@ static void test_edges_overflow(void *obj, void *data, QGuestAllocator *alloc)
>      g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_OVF, ==, ME_OVF);
>  }
>  
> +/* Shunt over-limit alert (transparent mode) sets the AFF flag */
> +static void test_alert_shunt_over(void *obj, void *data,
> +                                  QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +
> +    i2c_set16(dev, REG_ALERT_LIMIT, 0x1000);
> +    i2c_set16(dev, REG_MASK_ENABLE, ME_SOL);
> +
> +    qmp_ina230_set("shunt-voltage", 2500000);
> +    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_AFF, ==, 0);
> +
> +    qmp_ina230_set("shunt-voltage", 20000000);
> +    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_AFF, ==, ME_AFF);
> +
> +    qmp_ina230_set("shunt-voltage", 2500000);
> +    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_AFF, ==, 0);
> +}
> +
> +/* Latch mode holds the alert until the Mask/Enable register is read */
> +static void test_alert_latch(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +    uint16_t me;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +
> +    i2c_set16(dev, REG_ALERT_LIMIT, 0x1000);
> +    i2c_set16(dev, REG_MASK_ENABLE, ME_SOL | ME_LEN);
> +
> +    qmp_ina230_set("shunt-voltage", 20000000);
> +    qmp_ina230_set("shunt-voltage", 2500000);
> +
> +    me = i2c_get16(dev, REG_MASK_ENABLE);
> +    g_assert_cmphex(me & ME_AFF, ==, ME_AFF);
> +
> +    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_AFF, ==, 0);
> +}
> +
> +/* Bus over-limit alert */
> +static void test_alert_bus(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +
> +    i2c_set16(dev, REG_ALERT_LIMIT, 0x2000);
> +    i2c_set16(dev, REG_MASK_ENABLE, ME_BOL);
> +
> +    qmp_ina230_set("bus-voltage", 5000000);
> +    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_AFF, ==, 0);
> +
> +    qmp_ina230_set("bus-voltage", 12000000);
> +    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_AFF, ==, ME_AFF);
> +}
> +
> +/* Power over-limit alert */
> +static void test_alert_power(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +
> +    qmp_ina230_set("shunt-voltage", 20000000);
> +    qmp_ina230_set("bus-voltage", 11980000);
> +    i2c_set16(dev, REG_CALIBRATION, 0x0A00);
> +
> +    i2c_set16(dev, REG_ALERT_LIMIT, 0x1000);
> +    i2c_set16(dev, REG_MASK_ENABLE, ME_POL);
> +    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_AFF, ==, ME_AFF);
> +
> +    i2c_set16(dev, REG_ALERT_LIMIT, 0x2000);
> +    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_AFF, ==, 0);
> +}
> +
> +/* Conversion Ready Flag: set on conversion, cleared by reading Mask/Enable */
> +static void test_cvrf(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +
> +    /* A conversion (triggered by injection) sets CVRF */
> +    qmp_ina230_set("shunt-voltage", 20000000);
> +    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_CVRF, ==, ME_CVRF);
> +
> +    /* The previous read cleared CVRF; no conversion since, so it stays clear */
> +    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_CVRF, ==, 0);
> +}
> +
>  static void ina230_register_nodes(void)
>  {
>      QOSGraphEdgeOptions opts = {
> @@ -235,5 +327,10 @@ static void ina230_register_nodes(void)
>      qos_add_test("power", "ina230", test_power, NULL);
>      qos_add_test("zero-cal", "ina230", test_zero_cal, NULL);
>      qos_add_test("edges-overflow", "ina230", test_edges_overflow, NULL);
> +    qos_add_test("alert-shunt-over", "ina230", test_alert_shunt_over, NULL);
> +    qos_add_test("alert-latch", "ina230", test_alert_latch, NULL);
> +    qos_add_test("alert-bus", "ina230", test_alert_bus, NULL);
> +    qos_add_test("alert-power", "ina230", test_alert_power, NULL);
> +    qos_add_test("cvrf", "ina230", test_cvrf, NULL);
>  }
>  libqos_init(ina230_register_nodes);
> 


