Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2971DC3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH5GS-0006RX-IV; Wed, 14 Oct 2026 16:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xH5GM-0006Pu-2Y; Wed, 14 Oct 2026 16:07:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xH5GK-000455-9J; Wed, 14 Oct 2026 16:07:45 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEiWPX695316; Wed, 14 Oct 2026 20:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=3gVgh01T6XHGCtUQcxcpZ4+mdX9UPK6M30IjCSHGT7o=; b=Egi+bu7NQOSN
 7ZJRh1KWcRVjPLlS6NJjC796209AvBWXKXTPMR5SlWmq9/Uf1Oij1GjyhrOJpWCd
 eMgXSmpnyQlQ6jeAPk9bHqwLwUCA9z8hliqos1gGksKiZxP6Pcx0VurIiF0BRsWh
 wp6qWQ6WXaMAIkDbybV4NyWRNZ9lyHdE354MSyR2mv9CT5R7+QV8S7Id2aule7Xz
 Z2WixQ1CVBo/mK+uPh9GjR78abQ+dAzxW9FOziy5du8WyhFygE0ak3hlrYPlWe/D
 Kw5dQWKOVZ/jU6DXD0DpnnpfsgrEoCApIn0Jko8+tSNYs50aFqTSk/YZJ7wY+AfY
 AA42VIpWOw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhphgb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 20:07:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EIddIl634399; Wed, 14 Oct 2026 20:07:21 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h9q2ypg4k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 20:07:21 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69EK7K1g29753942
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Oct 2026 20:07:21 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CFC4B58064;
 Wed, 14 Oct 2026 20:07:20 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0666A58062;
 Wed, 14 Oct 2026 20:07:20 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 Oct 2026 20:07:19 +0000 (GMT)
Message-ID: <dc882e3f95928500daec69164154cb147e3de536.camel@linux.ibm.com>
Subject: Re: [PATCH v2 39/50] tests/qtest: ina230: cover a cleared
 calibration per channel
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
Date: Wed, 14 Oct 2026 15:07:19 -0500
In-Reply-To: <20261012-bmc-minerva-v2-39-4c3dff084ec9@free.fr>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
 <20261012-bmc-minerva-v2-39-4c3dff084ec9@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX9ciW6cSggXDX
 GD0OHmRpKqTMML4WHbXoKvSAH9E0JEQqZ/om/B/xembHH23hhHOC/G2CmM9MZwszn3XELS9DaIn
 15CkniJOjk2A+1pNhzCyJjj5ZFe75Ns=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfXzkBhVLrFRJe3
 cC1e8Hc4LPGzCW+hblGjlHMJAWJMam1RX8RpUFNWcmrYbGlw5AEICttHKr92qU/3j00hzajFgg0
 ZN3WHYe+CCiNEoFDDYKVJ+SSeQtpLSRKZJYePvUmEjRqiIc/GCQbR0/MTl8VB/Ddn4UymeEjk8N
 Qn09smmnXxG9Mdr32kqg8lRwkzXTbmVS+W+dGhnu61GvRYO9PhuIhmGFkoEXXnpKKr1+noeW9Xh
 FwxJCf16BLaKrrrfioN0yjPczfWP+YbgqnZlyCrYMGoU+V60VRn6RifY3qCCxlXJe9sK+aolKDt
 zsOTrU749jgIeKUosBpt1OKdr6ZUMbSN2oGPEzwkJFa9XWvleyEwjvzR76WpOGIuv0s03BLLj4x
 aFXfOlyiy0qF1po34w7W0/zNfB1qXhX9w7rU8H2HhQFoinSIqcqZsmlw2NhTkDFCSoVjf8QSSYD
 p7JjE0+ueWIUBeeymmA==
X-Proofpoint-GUID: l0JbdhCRrIKtXPsPoTtfJfWkOXmLjHee
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6acfe0fb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=Ruqeh8-80aeie2z8IXUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: jYXQdTQwD-WW93ayOpI2Pd_u580amLz4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
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
> Verify that without a calibration value the current and power
> registers read zero, whichever channels the mode converts.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  tests/qtest/ina230-test.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/tests/qtest/ina230-test.c b/tests/qtest/ina230-test.c
> index 591927e551..5749b0bd46 100644
> --- a/tests/qtest/ina230-test.c
> +++ b/tests/qtest/ina230-test.c
> @@ -301,6 +301,30 @@ static void test_zero_cal(void *obj, void *data, QGuestAllocator *alloc)
>      g_assert_cmphex(i2c_get16(dev, REG_POWER), ==, 0x0000);
>  }
>  
> +/* Clearing the Calibration zeroes both derived registers in any mode */
> +static void test_zero_cal_channels(void *obj, void *data,
> +                                   QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +    static const uint8_t modes[] = { 0x5, 0x6, 0x7 };
> +    size_t idx;
> +
> +    for (idx = 0; idx < ARRAY_SIZE(modes); idx++) {
> +        i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +        i2c_set16(dev, REG_CALIBRATION, 0x0A00);
> +        qmp_ina230_set("shunt-voltage", 20000000);
> +        qmp_ina230_set("bus-voltage", 11980000);
> +        g_assert_cmphex(i2c_get16(dev, REG_CURRENT), !=, 0x0000);
> +        g_assert_cmphex(i2c_get16(dev, REG_POWER), !=, 0x0000);
> +
> +        i2c_set16(dev, REG_CONFIG, modes[idx]);
> +        i2c_set16(dev, REG_CALIBRATION, 0x0000);
> +
> +        g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x0000);
> +        g_assert_cmphex(i2c_get16(dev, REG_POWER), ==, 0x0000);
> +    }
> +}
> +
>  /* Clamping at full scale and the OVF (math overflow) flag */
>  static void test_edges_overflow(void *obj, void *data, QGuestAllocator *alloc)
>  {
> @@ -560,6 +584,7 @@ static void ina230_register_nodes(void)
>                   NULL);
>      qos_add_test("power", "ina230", test_power, NULL);
>      qos_add_test("zero-cal", "ina230", test_zero_cal, NULL);
> +    qos_add_test("zero-cal-channels", "ina230", test_zero_cal_channels, NULL);
>      qos_add_test("edges-overflow", "ina230", test_edges_overflow, NULL);
>      qos_add_test("alert-shunt-over", "ina230", test_alert_shunt_over, NULL);
>      qos_add_test("alert-latch", "ina230", test_alert_latch, NULL);
> 


