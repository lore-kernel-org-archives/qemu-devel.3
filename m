Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 744F0C3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH5Ft-0005kW-VS; Wed, 14 Oct 2026 16:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xH5Fe-0005fx-GR; Wed, 14 Oct 2026 16:07:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xH5Fb-00041k-Qy; Wed, 14 Oct 2026 16:07:02 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEiIaC1270128; Wed, 14 Oct 2026 20:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=fAhxV0TKch3DBKe4y9bjamK7GEsUjhNUCkKaQe4qdqQ=; b=fFV6B0ik4ZNf
 voieevLi4EZ2XjqKu8zzUAsgA4OfEx6HBB1hJ7FqSCBc2zFMqYj8jW1E/QXqvDZC
 aIRJcq1y7XWOuk4XCseam+xZjW/Up6ibNbpe2RYXg2F8UXnUPl93hfxyHFEU2PJy
 hINuHeZP3K7U5iJS/WpYkWv0yD5R6k8dejjHkRH/c7QqrR0VdjFCU1gookGK229K
 v2S97F73OaGdfuXpNZV/PvJnZkaOeFAEE7Qk/Zxqn0nnpEkG0SejvsWyPeAUmKwI
 iNIGAMRnQtaWMLKhjWKes72yO9kILhNynh00P7x3GD4Z6SWceCHfUyz2+aOSW3F9
 mylyS9KqXA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv0nxg1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 20:06:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EIdScf714310; Wed, 14 Oct 2026 20:06:35 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9qb6xe0q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 20:06:35 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69EK6YGQ30933622
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Oct 2026 20:06:35 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD42158059;
 Wed, 14 Oct 2026 20:06:34 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 53C5A58067;
 Wed, 14 Oct 2026 20:06:33 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 Oct 2026 20:06:33 +0000 (GMT)
Message-ID: <79e9a5da30b2899b335e06ce77048c914e209ef8.camel@linux.ibm.com>
Subject: Re: [PATCH v2 38/50] tests/qtest: ina230: cover ALERT latch
 persistence
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
Date: Wed, 14 Oct 2026 15:06:32 -0500
In-Reply-To: <20261012-bmc-minerva-v2-38-4c3dff084ec9@free.fr>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
 <20261012-bmc-minerva-v2-38-4c3dff084ec9@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX1NoNC6Pe9i9m
 rliD2XdmvmsAa4OGza3thSU7bqXLNwNYeAmotmeeJwayRX6neWUAyewpx/NjF5eRxYEwE2Wm9zw
 8jkX9k0FbO2pzXuA0nfdkXJiQBSIgHJ87hi3E5Nu/s72xNkZ1GUOy5llnn2BgqFJ4oASZraIo59
 WpYLBseFlp8YhA76fWXGKe/WEEGyAiXeVZx/XNHGrGjGQoJK/xC0i+rSCLx/rvewI1l4Z/lVsNq
 YHb+syvyCkdwLLQTz90oIL0/zIdYSDjCoLNgjEnnfYDdpr2dGGQOObwF94ZrUmh0FejM+KHcLwH
 iPOMxBrbdMFnsQR/DuG0OUlT5I5MllcEXJ/ggM4UNA5tqvfviQ7mBSb95myWIqQQi3+uULBQQ0Q
 eHfCb0vhYv8H6ycT5SUp6hK9VOyXTZYdF6OJD/9ZIshamVDAuh5egoZc9w3WhxLB4QXuoguVZhR
 ipGV/cvhjSXeMLgDVyA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX38h1QPScGgRk
 D2695ddSSJDK6c7BUKwADBjvh5yFatwZwya0qn2qvbKpkPTgXGhRkiJLSxQKNKLb4/hXFDC7DKm
 K0GcNEBc54UnTvtaoao5x6mtnrB6qZQ=
X-Proofpoint-ORIG-GUID: om-fMx9Hqiopi6OuaWbSxvVoWlCX8ej-
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6acfe0cc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=Ogg6Cib4d_kmUnUIKOoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: GDZ1mip4Wy6y-dkl9YfVN_xI_EV8ybe1
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
> Verify what releases a latched alert and what can bring it back: a
> Mask/Enable read and a Configuration write both clear it, and only a
> conversion that re-samples the fault on a channel it converted asserts
> it again.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  tests/qtest/ina230-test.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 
> diff --git a/tests/qtest/ina230-test.c b/tests/qtest/ina230-test.c
> index f8b982686a..591927e551 100644
> --- a/tests/qtest/ina230-test.c
> +++ b/tests/qtest/ina230-test.c
> @@ -364,6 +364,88 @@ static void test_alert_latch(void *obj, void *data, QGuestAllocator *alloc)
>  }
>  
>  /* Bus over-limit alert */
> +static void test_alert_latch_persist(void *obj, void *data,
> +                                     QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +    i2c_set16(dev, REG_ALERT_LIMIT, 0x1000);
> +    i2c_set16(dev, REG_MASK_ENABLE, ME_SOL | ME_LEN);
> +
> +    qmp_ina230_set("shunt-voltage", 20000000);
> +
> +    /* First read shows the latched AFF and clears the latch */
> +    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_AFF, ==, ME_AFF);
> +
> +    /* Fault still present but no new conversion: AFF stays cleared */
> +    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_AFF, ==, 0);
> +
> +    qmp_ina230_set("shunt-voltage", 20000000);
> +    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_AFF, ==, ME_AFF);
> +}
> +
> +/* A Configuration write releases the latch as a Mask/Enable read does. */
> +static void test_alert_latch_config(void *obj, void *data,
> +                                    QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +    i2c_set16(dev, REG_ALERT_LIMIT, 0x1000);
> +    i2c_set16(dev, REG_MASK_ENABLE, ME_SOL | ME_LEN);
> +
> +    /* Latch a fault, then bring the input back below the limit */
> +    qmp_ina230_set("shunt-voltage", 20000000);
> +    qmp_ina230_set("shunt-voltage", 2500000);
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_POR);
> +    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_AFF, ==, 0);
> +
> +    /* With the fault present, the reconversion latches it again */
> +    qmp_ina230_set("shunt-voltage", 20000000);
> +    i2c_set16(dev, REG_CONFIG, CONFIG_POR);
> +    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_AFF, ==, ME_AFF);
> +}
> +
> +/* The releasing write need not reconvert: a power-down leaves it clear. */
> +static void test_alert_latch_shutdown(void *obj, void *data,
> +                                      QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +    i2c_set16(dev, REG_ALERT_LIMIT, 0x1000);
> +    i2c_set16(dev, REG_MASK_ENABLE, ME_SOL | ME_LEN);
> +
> +    qmp_ina230_set("shunt-voltage", 20000000);
> +
> +    i2c_set16(dev, REG_CONFIG, 0x0000); /* power-down */
> +    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_AFF, ==, 0);
> +}
> +
> +/*
> + * A conversion only re-samples the alert of a channel it converted: the bus
> + * register a shunt-only conversion left stale must not re-latch.
> + */
> +static void test_alert_channel(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +    i2c_set16(dev, REG_ALERT_LIMIT, 0x2000);
> +    i2c_set16(dev, REG_MASK_ENABLE, ME_BOL | ME_LEN);
> +
> +    qmp_ina230_set("bus-voltage", 12000000);
> +    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_AFF, ==, ME_AFF);
> +
> +    /* Shunt-only mode: the bus register keeps its over-limit value */
> +    i2c_set16(dev, REG_CONFIG, 0x0005);
> +    qmp_ina230_set("shunt-voltage", 20000000);
> +    g_assert_cmphex(i2c_get16(dev, REG_BUS), ==, 0x2580);
> +    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_AFF, ==, 0);
> +}
> +
>  static void test_alert_bus(void *obj, void *data, QGuestAllocator *alloc)
>  {
>      QI2CDevice *dev = (QI2CDevice *)obj;
> @@ -481,6 +563,13 @@ static void ina230_register_nodes(void)
>      qos_add_test("edges-overflow", "ina230", test_edges_overflow, NULL);
>      qos_add_test("alert-shunt-over", "ina230", test_alert_shunt_over, NULL);
>      qos_add_test("alert-latch", "ina230", test_alert_latch, NULL);
> +    qos_add_test("alert-latch-persist", "ina230", test_alert_latch_persist,
> +                 NULL);
> +    qos_add_test("alert-latch-config", "ina230", test_alert_latch_config,
> +                 NULL);
> +    qos_add_test("alert-latch-shutdown", "ina230", test_alert_latch_shutdown,
> +                 NULL);
> +    qos_add_test("alert-channel", "ina230", test_alert_channel, NULL);
>      qos_add_test("alert-bus", "ina230", test_alert_bus, NULL);
>      qos_add_test("alert-power", "ina230", test_alert_power, NULL);
>      qos_add_test("cvrf", "ina230", test_cvrf, NULL);
> 


