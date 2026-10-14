Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87D6CC6B2C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH5KW-0002P4-0U; Wed, 14 Oct 2026 16:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xH5KP-0002NH-01; Wed, 14 Oct 2026 16:11:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xH5KN-0004WA-B9; Wed, 14 Oct 2026 16:11:56 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEiL0Z2466142; Wed, 14 Oct 2026 20:11:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=pzUm5DjN0uptqBbQnckkGo6h6CQBTnZDK8TTETmVEcU=; b=eMd3r7xzKX/b
 aQ1P/kjeANyGviPrH4hgQLUZFlx5n/qYJCMsn7E3qmfw42W9Z7t0ssCBTGcTzGYo
 15U9AM2sPbwxyplb+2twEnWb2TU6aRpc8K64+tcXooAR4trTz1kr0sbtoZEIrilN
 UbAMM/4cY9C+Llff7Di8GY6G9aE1JENqkft15QALrUs8PmiGEU+1r1CNio4cR5JJ
 hP2KET7B2sSp7Dwl7tGtGpZPC2DXAGl1agV3uRKmH+T4mmSBf0K5AuTkHGg/0Wwn
 oFBwkjUkS/cX+MHeIEEgGT/qwtTi7C07sncBJyvEuhzL+IxWO0Je+fmef4y9MsgG
 RlaYxsnPWw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1wdwvv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 20:11:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EIcox13639682; Wed, 14 Oct 2026 20:11:15 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9wvg49nc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 20:11:15 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69EKBFt226542780
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Oct 2026 20:11:15 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3592658065;
 Wed, 14 Oct 2026 20:11:15 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC17558059;
 Wed, 14 Oct 2026 20:11:13 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 Oct 2026 20:11:13 +0000 (GMT)
Message-ID: <efcd4689033afefc9726f193e2baa707064ab5c2.camel@linux.ibm.com>
Subject: Re: [PATCH v2 45/50] tests/qtest: ina238: cover the operating modes
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
Date: Wed, 14 Oct 2026 15:11:13 -0500
In-Reply-To: <20261012-bmc-minerva-v2-45-4c3dff084ec9@free.fr>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
 <20261012-bmc-minerva-v2-45-4c3dff084ec9@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX8l37jC4Xxslg
 QtBUF2HDy3ldhPQT2ieaSW4clKdkj53UPPHQZXKpQBGbLXyiprpIZz329Nkt+0mE8ubbC8JGjTa
 3epPQ4ETv8ilR9zRJOvrn/HbqSIda2U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfXwZ9wNfY0WdMP
 pAXpCzp5za/s092OqwOSsUJp2lMZmVTBbxl6lPqY7LJMdVeDMH+09InBo2ECFwSJlc7uh9vfa7M
 6Ki5Qi4lXFJvlQL01bWpO3fMmypk/5dKyUP0tubJEDje4HtStFT3v3yd9zYdiE2FxmHnPb06qo2
 x//2O2E8hMhuBH/hiyFZ7h2fibkgXBRrJWk+8Ud6MAdVVAeF49XYzei2xxNilZHm9P4McqBpQk8
 qMRjoaMny2Hab8h2Ihd1rYn39/I9m87W70Gpda6D0L6DRsdf1J31El8HxL1K/AMx3w25woqJtc4
 u/iao+vw6VmjndqofW+QVY/D8lHWHVkbuGCpvw9sUB/qVzJ4y5kqU2r9AKlT8r380G3cWsa9/Se
 dYgdDTRvakHi7yNpApgE96ec1sJPADYCiOf45ZGkX3QXYZdanab6BfFYxYUu8BwGgjvJ0LGmRIV
 3yNLlZnW+wJ8VCvzAPA==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6acfe1e5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=4wd6QycjSo9Clc8rIX0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 6M9_LG3a2m8ARJE_RsRj1dCKzAkE-aaj
X-Proofpoint-GUID: VC89RKpTlIXkU-fwVAJDRU8WvLKGkeBE
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
> Add coverage for the ADC_CONFIG MODE field: shutdown modes perform no
> conversion and leave the measurement registers and CNVRF untouched,
> triggered modes convert once per ADC_CONFIG write, and continuous
> channel-select modes refresh only the enabled measurement registers.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  tests/qtest/ina238-test.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/tests/qtest/ina238-test.c b/tests/qtest/ina238-test.c
> index 74912424c0..fb7bcc265c 100644
> --- a/tests/qtest/ina238-test.c
> +++ b/tests/qtest/ina238-test.c
> @@ -304,6 +304,73 @@ static void test_adcrange(void *obj, void *data, QGuestAllocator *alloc)
>      g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x1F40);
>  }
>  
> +/* Shutdown converts nothing: registers are held, CNVRF stays clear. */
> +static void test_mode_shutdown(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +    i2c_set16(dev, REG_SHUNT_CAL, 0x1000);
> +    qmp_ina238_set("shunt-voltage", 20000000);
> +    qmp_ina238_set("bus-voltage", 12000000);
> +    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x0FA0);
> +    g_assert_cmphex(i2c_get16(dev, REG_VBUS), ==, 0x0F00);
> +
> +    /* Clear CNVRF, then enter shutdown (MODE = 0). */
> +    (void)i2c_get16(dev, REG_DIAG_ALRT);
> +    i2c_set16(dev, REG_ADC_CONFIG, 0x0000);
> +
> +    /* Injecting while shut down performs no conversion: registers are held. */
> +    qmp_ina238_set("shunt-voltage", 40000000);
> +    qmp_ina238_set("bus-voltage", 24000000);
> +    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x0FA0);
> +    g_assert_cmphex(i2c_get16(dev, REG_VBUS), ==, 0x0F00);
> +
> +    /* No conversion completed, so CNVRF stays clear. */
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_CNVRF, ==, 0);
> +}
> +
> +/* Triggered modes convert once per ADC_CONFIG write. */
> +static void test_mode_triggered(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +    i2c_set16(dev, REG_SHUNT_CAL, 0x1000);
> +    qmp_ina238_set("shunt-voltage", 20000000);
> +
> +    /* Enter triggered bus+shunt+temp mode: one conversion. */
> +    i2c_set16(dev, REG_ADC_CONFIG, 0x7000);
> +    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x0FA0);
> +
> +    /* A new input does not convert until the next trigger. */
> +    qmp_ina238_set("shunt-voltage", 40000000);
> +    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x0FA0);
> +
> +    /* Re-triggering with another ADC_CONFIG write samples the new input. */
> +    i2c_set16(dev, REG_ADC_CONFIG, 0x7000);
> +    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x1F40);
> +}
> +
> +/* A bus-only mode refreshes the bus register alone; the rest are held. */
> +static void test_mode_channels(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +    i2c_set16(dev, REG_SHUNT_CAL, 0x1000);
> +    qmp_ina238_set("shunt-voltage", 20000000);
> +    qmp_ina238_set("bus-voltage", 12000000);
> +
> +    /* Continuous bus-only mode. */
> +    i2c_set16(dev, REG_ADC_CONFIG, 0x9000);
> +    qmp_ina238_set("shunt-voltage", 40000000);
> +    qmp_ina238_set("bus-voltage", 24000000);
> +
> +    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x0FA0);
> +    g_assert_cmphex(i2c_get16(dev, REG_VBUS), ==, 0x1E00);
> +}
> +
>  /* Clamping at full scale and the MATHOF flag */
>  static void test_overflow(void *obj, void *data, QGuestAllocator *alloc)
>  {
> @@ -548,6 +615,9 @@ static void ina238_register_nodes(void)
>      qos_add_test("power", "ina238", test_power, NULL);
>      qos_add_test("zero-cal", "ina238", test_zero_cal, NULL);
>      qos_add_test("adcrange", "ina238", test_adcrange, NULL);
> +    qos_add_test("mode-shutdown", "ina238", test_mode_shutdown, NULL);
> +    qos_add_test("mode-triggered", "ina238", test_mode_triggered, NULL);
> +    qos_add_test("mode-channels", "ina238", test_mode_channels, NULL);
>      qos_add_test("overflow", "ina238", test_overflow, NULL);
>      qos_add_test("alert-shunt", "ina238", test_alert_shunt, NULL);
>      qos_add_test("alert-bus", "ina238", test_alert_bus, NULL);
> 


