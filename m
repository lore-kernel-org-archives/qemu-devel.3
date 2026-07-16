Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71139C44511
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkOTO-0002uB-NG; Thu, 16 Jul 2026 11:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkOTM-0002tU-SV; Thu, 16 Jul 2026 11:58:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkOTK-0004Jd-Gx; Thu, 16 Jul 2026 11:58:03 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GDg7nC3348875; Thu, 16 Jul 2026 15:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=HfpPWW/HCyd+V+dZZxuM58AnRvAtg50LGLNGQASB3xE=; b=tRtTOy3+WKDJ
 0oodzDs6+mQyp5mQNFf8NEbra7oqd8igwQ70OhadExqLBeqtCQs3Ng9QpavKkuXm
 rpi4BAX5QXXatXkXfONbINEFaY5jpR8ZDgHGMBtfqv7MhFtQMsrv2f4+IYJ35qWz
 wDqccdymCjAuDb8XI0L3iFky8JGdH3SWSB6gYPAqHVN2fwTBb2kpvuBJA+z//H2V
 ljI0i/+ASlY8CjUx+r9ydf+awTA3cs3H/W3AnFLuJ9L86BEuNAd/mQ5cNJGywZmS
 YsO4GXHt4oLhrXNqLruTVKpIHLv89yFkDkmqa926IEfv1u0FXKXz//l0sH33ptCF
 kxAfSKMyRA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegc1106-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 15:57:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GFnblf016697;
 Thu, 16 Jul 2026 15:57:38 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hwdue5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 15:57:38 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GFvbKJ37093968
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 15:57:38 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CAB3D5804B;
 Thu, 16 Jul 2026 15:57:37 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 89A2258055;
 Thu, 16 Jul 2026 15:57:36 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 15:57:36 +0000 (GMT)
Message-ID: <db71a6365211a840caef08548eaa95e6fa49cceb.camel@linux.ibm.com>
Subject: Re: [PATCH 23/29] tests/qtest: pca9554: test the PCA9536 4-bit variant
From: Miles Glenn <milesg@linux.ibm.com>
To: Emmanuel Blot <emmanuel.blot@free.fr>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Corey
 Minyard <cminyard@mvista.com>
Date: Thu, 16 Jul 2026 10:57:36 -0500
In-Reply-To: <20260709-catalina-upgrade-v1-23-82a63fead90c@free.fr>
References: <20260709-catalina-upgrade-v1-0-82a63fead90c@free.fr>
 <20260709-catalina-upgrade-v1-23-82a63fead90c@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a58ff73 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=chtLON8zQLDBo5PjSsAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2MSBTYWx0ZWRfX5AFie3iCAeZh
 b88ZG+JcT/FiCniGTtRzP6n0co1hpNB6LF/GXf1aoR9KZuBaE4MGG3XDvEHfJcVsdKVrjpgNeDq
 7tlhwXL+cA1GmZf8nuS4o7GfqSGVUdlpscu7cgTCb0/XUQmYL4UK+HT4eWaj6ZRzTNN9OyplD1v
 Q1E1S00Q1j8IyEIfyfwTKrfXQTlVpJoZCwEQR0s/tVqfcxERrsHOXAcQjbpqS/TsByfR6vB7QLW
 TKGxe40eKtBIlpdth5jpqmv1l9/zU86xUuSN1HuHiOCLH2XAg27LhNc/X9xbjQhLEqujeN+SBvD
 qXufWvbIwXewBuGAbx4JVEViz04xp8MmioVILXzRNlud+c8ZV01FbTvSiJM5W2DZQsESGMJOrq2
 IPz0zx+vjLFar7bfp2D9EVWlbl0+sIlou/CfAIyG9YrbFnO2j4rvhK5Folm3gpCcuKTY20u6dCW
 +bSptGjFNDzdmqfXI2A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2MSBTYWx0ZWRfX7bFEEymLoZTX
 ly2HuChUjgzLHJFV5sbn/oJ9G2IBF2zDlVhXL5V7ljDDcL5mdQKWM4RFQIt/afoxWvrd/FVoEFj
 TSnQ+2fguvTglUdPNnX8wZB3gUImVUU=
X-Proofpoint-GUID: AfaQcU8oqXeq8aMBzKPyxoMdWbEcw4EI
X-Proofpoint-ORIG-GUID: xmA2eImDozOVADK1geiBKAqS-Y6fcmVf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160161
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On Thu, 2026-07-09 at 17:23 +0200, Emmanuel Blot wrote:
> The PCA9536 shares the PCA9554 register map and code path but exposes
> only four pins. Add a pca9536 node and check its reset defaults and
> output-to-input reflection are masked to the low nibble.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  tests/qtest/pca9554-test.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/tests/qtest/pca9554-test.c b/tests/qtest/pca9554-test.c
> index 0da1f3304b..5366e71984 100644
> --- a/tests/qtest/pca9554-test.c
> +++ b/tests/qtest/pca9554-test.c
> @@ -129,6 +129,66 @@ static void test_no_autoincrement(void *obj, void *data,
>      g_assert_cmphex(i2c_get8(dev, PCA9554_POLARITY), ==, 0x33);
>  }
>  
> +/*
> + * The PCA9536 shares the PCA9554 register map but only has four pins, so its
> + * reset defaults and pin logic are masked to the low nibble.
> + */
> +static void test_pca9536_reset_defaults(void *obj, void *data,
> +                                        QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0x0F);
> +    g_assert_cmphex(i2c_get8(dev, PCA9554_OUTPUT), ==, 0x0F);
> +    g_assert_cmphex(i2c_get8(dev, PCA9554_POLARITY), ==, 0x00);
> +    g_assert_cmphex(i2c_get8(dev, PCA9554_CONFIG), ==, 0x0F);
> +}
> +
> +/* Only the four low pins are driven; the upper nibble stays low. */
> +static void test_pca9536_output_drives_input(void *obj, void *data,
> +                                             QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set8(dev, PCA9554_CONFIG, 0x00);
> +
> +    i2c_set8(dev, PCA9554_OUTPUT, 0x0A);
> +    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0x0A);
> +
> +    i2c_set8(dev, PCA9554_OUTPUT, 0x00);
> +    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0x00);
> +}
> +
> +/*
> + * The four upper bits address pins that do not exist on the PCA9536, so writes
> + * to the register map discard them: the writable registers read back with bits
> + * [7:4] cleared, and driving them onto the pins never surfaces in INPUT.
> + */
> +static void test_pca9536_ignores_upper_bits(void *obj, void *data,
> +                                            QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    /* Bits [7:4] are dropped on write; bits [3:0] survive. */
> +    i2c_set8(dev, PCA9554_OUTPUT, 0xFA);
> +    g_assert_cmphex(i2c_get8(dev, PCA9554_OUTPUT), ==, 0x0A);
> +
> +    i2c_set8(dev, PCA9554_POLARITY, 0xF5);
> +    g_assert_cmphex(i2c_get8(dev, PCA9554_POLARITY), ==, 0x05);
> +
> +    i2c_set8(dev, PCA9554_CONFIG, 0xF3);
> +    g_assert_cmphex(i2c_get8(dev, PCA9554_CONFIG), ==, 0x03);
> +
> +    /*
> +     * With all four pins as outputs, driving 0xFF only affects the low
> +     * nibble.
> +     */
> +    i2c_set8(dev, PCA9554_POLARITY, 0x00);
> +    i2c_set8(dev, PCA9554_CONFIG, 0x00);
> +    i2c_set8(dev, PCA9554_OUTPUT, 0xFF);
> +    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0x0F);
> +}
> +
>  static void pca9554_register_nodes(void)
>  {
>      QOSGraphEdgeOptions opts = {
> @@ -148,6 +208,16 @@ static void pca9554_register_nodes(void)
>      qos_add_test("polarity-with-output", "pca9554", test_polarity_with_output,
>                   NULL);
>      qos_add_test("no-autoincrement", "pca9554", test_no_autoincrement, NULL);
> +
> +    qos_node_create_driver("pca9536", i2c_device_create);
> +    qos_node_consumes("pca9536", "i2c-bus", &opts);
> +
> +    qos_add_test("reset-defaults", "pca9536", test_pca9536_reset_defaults,
> +                 NULL);
> +    qos_add_test("output-drives-input", "pca9536",
> +                 test_pca9536_output_drives_input, NULL);
> +    qos_add_test("ignores-upper-bits", "pca9536",
> +                 test_pca9536_ignores_upper_bits, NULL);
>  }
>  
>  libqos_init(pca9554_register_nodes);
> 


