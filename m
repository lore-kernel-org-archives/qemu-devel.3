Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F6EC3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH5MA-0003Yk-SP; Wed, 14 Oct 2026 16:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xH5LU-0003A9-GV; Wed, 14 Oct 2026 16:13:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xH5LS-0004by-IQ; Wed, 14 Oct 2026 16:13:04 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEiAnR2561646; Wed, 14 Oct 2026 20:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=HHi46qyzCsOXPl5STcN6bxjNe1E65jAl+2XZKn/yKzg=; b=XU3j8agYLbTi
 BuYg9meD48BCNSf/ozeAI6n2R2UXH7mg5OaMxH5rPKNBu9QhJBIPM4b7hiZp1bxP
 GVwvJ0k6j1h1gNUFAl9rv6BADGMYZaoIe/nbUpEwek+NkjRFEqtxOUkK/h4mJz+z
 dP+pg61h/asaVsj7tAAVFn8VTuX6pC/Boemqp6v007OxkNSmzYTnHySThZCi0Hc6
 wrwlzSDKtSKBgCwOwDGLoxNZDDWO8i/98c7vBKlrbN9WQBnB6PBiidQaHFaCw6cI
 jaPly3qRYyRkBmSfYSskZ3ryoTgZD7MfZ0FRN+i+NLwdmeKqZLj+4AWxAZt8XigW
 zfWLoNHzYQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dugpj0c-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 20:12:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EIeuBY634438; Wed, 14 Oct 2026 20:12:28 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h9q2ypguc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 20:12:28 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69EKCSXU15467242
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Oct 2026 20:12:28 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1AF8758051;
 Wed, 14 Oct 2026 20:12:28 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3AF005805A;
 Wed, 14 Oct 2026 20:12:27 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 Oct 2026 20:12:27 +0000 (GMT)
Message-ID: <0e5c23a09b897952529f4a7566e5eab5f9858615.camel@linux.ibm.com>
Subject: Re: [PATCH v2 47/50] tests/qtest: ina238: cover a cleared
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
Date: Wed, 14 Oct 2026 15:12:26 -0500
In-Reply-To: <20261012-bmc-minerva-v2-47-4c3dff084ec9@free.fr>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
 <20261012-bmc-minerva-v2-47-4c3dff084ec9@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6acfe22e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=CyY-uauUVvmj6ffrK_IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WKY8-DO2vw_CiQBv7PN1gE5H9mLoAGOU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX03OI2YuYn+Pi
 KVaOM1XbbyiGXFm7pCwC9t+Ec78DF4bf+B0I2lnc468YKKeAAi6HZ0UXm/KGnTmkysTKqNNspya
 tkWrcN6d8g2AYV4SXhjuHMnwJbNQn1nvuFrjvX0hPdjInMmJ0/T9NmRJ0c58m5TJ7fa9q0U+yYX
 3q5wWRerC0tJunmxlDUkGcCqV52Aibzd7mIEASKyQ2jSXualu7z/LOSP9TGgMpGwaDSO0Da+OSE
 EH2RD3e5nEVAa3xPwB6O/ACU4XBR6yBICYD0d0Uv4F2zmFFirrSWh8NgXBWXRne+OgGgvgQNzOs
 GSiUKvX01yppY6z37IMp47vIuULjWGG6gl7Glhfk79s50FQLVp+PWlRL43uNekoN2jqqQIZV030
 WDDhI2S1en/A+Nd/uhtEA1JJK9KoUi9LDmRKmku1Qaor2r9I6qVrU1UZnnN68GGJ8SxX67DJPwO
 mEwLEml55vAIBVM5Sqw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfXwaM2EOedPyZ9
 rLXeiN/YjNJtyI1wxF2YyuUURy8p5hOE+LWsHfD+QczFkqnlFsB0HjGNNYx1e2VbT2ruZ6Egylr
 A9sx66E2RvrFNdZOzRzIgxuweF6FAuo=
X-Proofpoint-ORIG-GUID: _oeQL1gDu3ClkOZ4zlD1I9nuW_OF2VaQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140078
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
>  tests/qtest/ina238-test.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/tests/qtest/ina238-test.c b/tests/qtest/ina238-test.c
> index e7dd50a822..4e4146461c 100644
> --- a/tests/qtest/ina238-test.c
> +++ b/tests/qtest/ina238-test.c
> @@ -282,6 +282,30 @@ static void test_zero_cal(void *obj, void *data, QGuestAllocator *alloc)
>      g_assert_cmpuint(i2c_get24(dev, REG_POWER), ==, 0);
>  }
>  
> +/* Clearing SHUNT_CAL zeroes both derived registers in any mode */
> +static void test_zero_cal_channels(void *obj, void *data,
> +                                   QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +    static const uint16_t modes[] = { 0x9000, 0xA000, 0xF000 };
> +    size_t idx;
> +
> +    for (idx = 0; idx < ARRAY_SIZE(modes); idx++) {
> +        i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +        i2c_set16(dev, REG_SHUNT_CAL, 0x0FD2);
> +        qmp_ina238_set("shunt-voltage", 97200000);
> +        qmp_ina238_set("bus-voltage", 48000000);
> +        g_assert_cmphex(i2c_get16(dev, REG_CURRENT), !=, 0x0000);
> +        g_assert_cmpuint(i2c_get24(dev, REG_POWER), !=, 0);
> +
> +        i2c_set16(dev, REG_ADC_CONFIG, modes[idx]);
> +        i2c_set16(dev, REG_SHUNT_CAL, 0x0000);
> +
> +        g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x0000);
> +        g_assert_cmpuint(i2c_get24(dev, REG_POWER), ==, 0);
> +    }
> +}
> +
>  /* ADCRANGE changes the shunt LSB, not the current divisor. */
>  static void test_adcrange(void *obj, void *data, QGuestAllocator *alloc)
>  {
> @@ -458,6 +482,27 @@ static void test_alert_power(void *obj, void *data, QGuestAllocator *alloc)
>      g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_POL, ==, 0);
>  }
>  
> +/* Clearing SHUNT_CAL drops the power alert with the power reading */
> +static void test_alert_power_zero_cal(void *obj, void *data,
> +                                      QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +    qmp_ina238_set("shunt-voltage", 97200000);
> +    qmp_ina238_set("bus-voltage", 48000000);
> +    i2c_set16(dev, REG_SHUNT_CAL, 0x0FD2);
> +    i2c_set16(dev, REG_PWR_LIMIT, 0x0100);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_POL, ==, DIAG_POL);
> +
> +    /* Continuous shunt-only: the power register is not reconverted. */
> +    i2c_set16(dev, REG_ADC_CONFIG, 0xA000);
> +    i2c_set16(dev, REG_SHUNT_CAL, 0x0000);
> +
> +    g_assert_cmpuint(i2c_get24(dev, REG_POWER), ==, 0);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_POL, ==, 0);
> +}
> +
>  /* Two thresholds crossed at once are reported simultaneously (multi-alert) */
>  static void test_alert_multi(void *obj, void *data, QGuestAllocator *alloc)
>  {
> @@ -733,6 +778,7 @@ static void ina238_register_nodes(void)
>                   NULL);
>      qos_add_test("power", "ina238", test_power, NULL);
>      qos_add_test("zero-cal", "ina238", test_zero_cal, NULL);
> +    qos_add_test("zero-cal-channels", "ina238", test_zero_cal_channels, NULL);
>      qos_add_test("adcrange", "ina238", test_adcrange, NULL);
>      qos_add_test("mode-shutdown", "ina238", test_mode_shutdown, NULL);
>      qos_add_test("mode-triggered", "ina238", test_mode_triggered, NULL);
> @@ -742,6 +788,8 @@ static void ina238_register_nodes(void)
>      qos_add_test("alert-bus", "ina238", test_alert_bus, NULL);
>      qos_add_test("alert-temp", "ina238", test_alert_temp, NULL);
>      qos_add_test("alert-power", "ina238", test_alert_power, NULL);
> +    qos_add_test("alert-power-zero-cal", "ina238", test_alert_power_zero_cal,
> +                 NULL);
>      qos_add_test("alert-multi", "ina238", test_alert_multi, NULL);
>      qos_add_test("alert-latch", "ina238", test_alert_latch, NULL);
>      qos_add_test("alert-latch-persist", "ina238", test_alert_latch_persist,
> 


