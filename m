Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADACC44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkMZC-0006oS-IP; Thu, 16 Jul 2026 09:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkMZB-0006nr-8z; Thu, 16 Jul 2026 09:55:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkMZ9-0000dC-GL; Thu, 16 Jul 2026 09:55:57 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GDfrtb3285157; Thu, 16 Jul 2026 13:55:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=udf6AVz8JlV3UFXk18vE9MX6mr73Cl38uQsAnKKLPkY=; b=Xs9ygfmsxIzd
 4MiZigqD+BJ5FTO+w7N1RBCuZomjZOshVgz4XBLBciQ72wbgrjCEaeaNY/KPwNi0
 +B2VN6JucI7iGxNRgaKM+OopR9K8OAQaae/CW9elFzbU1afajLn0Al0F7PUO7i5M
 ZLY6AN49oW2VKc0h6dIJd8PNjQR4cwUYdePdAcCdjGsTp25HhgFZxCMI4oTsAGb5
 P2GxLw5j79yMsIIeQ2icswIMcd0Fi3va+7Ddf6hcWLIwtFnGcBwPzLl/7g5xZESB
 2F2PxUeTBnre7om2aze7H5L1kagOvcOzATLRIN6layOrPOzN/Xd0I40lUnU/PpJa
 li+nIWj8xQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2age8y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 13:55:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GDncHI003295;
 Thu, 16 Jul 2026 13:55:37 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15k57t9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 13:55:37 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GDta7J19464912
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 13:55:36 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 85D375805A;
 Thu, 16 Jul 2026 13:55:36 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B61D35803F;
 Thu, 16 Jul 2026 13:55:35 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 13:55:35 +0000 (GMT)
Message-ID: <e7efa4c311ca0d3b1a3afc604a2b5ba95eae32f7.camel@linux.ibm.com>
Subject: Re: [PATCH 11/29] tests/qtest: pca9555: test output-to-input
 reflection and pull-ups
From: Miles Glenn <milesg@linux.ibm.com>
To: Emmanuel Blot <eblot.ml@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Corey
 Minyard <cminyard@mvista.com>, Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 16 Jul 2026 08:55:35 -0500
In-Reply-To: <20260709-catalina-upgrade-v1-11-82a63fead90c@free.fr>
References: <20260709-catalina-upgrade-v1-0-82a63fead90c@free.fr>
 <20260709-catalina-upgrade-v1-11-82a63fead90c@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE0MSBTYWx0ZWRfXycINuqQ5Zn10
 1ulG+MJ6q2c7Y71mrNymWPtiTOchZXlHwzyfV22K8iDz5WrOQhhw4+HezYq59lLb/2VFrTmKyh1
 kHKulKCMJB8wGesL/MYjtcJK0ekn+2s=
X-Proofpoint-GUID: 50MJj5rSilPDhDBpkcuNZ3yCQ3uXC1QG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE0MSBTYWx0ZWRfX1nEngyrU/YOH
 nBU/cnnAE1MmEbgdcCzgX8xYyeXClkjeMgbwP6O1E8JlDkw1YNytcb6SqJnC1Z00GNq2ulr5eo3
 RgpWi9HIIwxqVPhg2VSmfOkKM7fwf+JO7EFvf5nOCz/Ve6V/zKPN8VQn6d36DEaN1dAbTI/kfeE
 S1rgpuHJ0APNRu7Wul7BIxKYKq/PPbvyd89NA4J+kJNh5Ij6op36KPAJA/k9gLKCmRrSgnDOLFx
 KoClJ1wH+/7IQ62Dyrjak5s0rUKZ93uzXcgayvgFsQQr2y1rKKQmWsoCI7JdICoLOkxtcyegIOW
 6HTLOZp9pwTvskQ0TXcTB3iaVxac+os9sdVCc+c+qIMo/Gq9KG9hgsMqU8F1+vjy/qdlBa3OEdK
 7kj9ie/ds4dUuGrZYkgOFrrZZdj1fSWCqLD3+T8YWMSp5AQC+t7JcVOj5P5U3Qf4Ub2b6wmS3+W
 Occb8pYNtC8auZl8lHg==
X-Proofpoint-ORIG-GUID: sSarJ7c4NA3yFl8VtkFVe1mMpsLFoQJz
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a58e2da cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=ZRbvj7Q4pqp3RGZPE1UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160141
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
> Add tests covering the pin I/O semantics of the expander: output-driven
> pins reflected in the input register, the pull-up seen on input-configured
> pins, and the independence of the two 8-bit ports.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  tests/qtest/pca9555-test.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
> 
> diff --git a/tests/qtest/pca9555-test.c b/tests/qtest/pca9555-test.c
> index 5945c3441e..6b085702c3 100644
> --- a/tests/qtest/pca9555-test.c
> +++ b/tests/qtest/pca9555-test.c
> @@ -28,6 +28,77 @@ static void test_reset_defaults(void *obj, void *data, QGuestAllocator *alloc)
>      g_assert_cmphex(i2c_get8(dev, PCA9535_CONFIG1), ==, 0xFF);
>  }
>  
> +/*
> + * When a pin is configured as output and driven low (output=0, config=0),
> + * the input register should reflect 0 for that pin.
> + * When driven high (output=1, config=0), input should reflect 1.
> + * When configured as input (config=1), PCA5555 pull-up makes it read 1.
> + */
> +static void test_output_drives_input(void *obj, void *data,
> +                                     QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set8(dev, PCA9535_CONFIG0, 0xF0);
> +    i2c_set8(dev, PCA9535_OUTPUT0, 0xFA);
> +
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0xFA);
> +
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT1), ==, 0xFF);
> +
> +    i2c_set8(dev, PCA9535_CONFIG0, 0x00);
> +    i2c_set8(dev, PCA9535_OUTPUT0, 0x00);
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0x00);
> +
> +    i2c_set8(dev, PCA9535_OUTPUT0, 0xFF);
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0xFF);
> +}
> +
> +/*
> + * When all pins are inputs (config=0xFF) and no external driver,
> + * PCA9555 pull-ups should make the input register read all ones.
> + * Switching a pin to output mode with output=0 should drive it low.
> + */
> +static void test_input_pullup(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0xFF);
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT1), ==, 0xFF);
> +
> +    i2c_set8(dev, PCA9535_OUTPUT0, 0x00);
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0xFF);
> +
> +    i2c_set8(dev, PCA9535_CONFIG0, 0x00);
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0x00);
> +}
> +
> +/*
> + * Test that both ports are independent: changing port 0 registers
> + * should not affect port 1 and vice versa.
> + */
> +static void test_port_independence(void *obj, void *data,
> +                                   QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set8(dev, PCA9535_CONFIG0, 0x00);
> +    i2c_set8(dev, PCA9535_OUTPUT0, 0x00);
> +
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0x00);
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT1), ==, 0xFF);
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_CONFIG1), ==, 0xFF);
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT1), ==, 0xFF);
> +
> +    i2c_set8(dev, PCA9535_CONFIG1, 0x00);
> +    i2c_set8(dev, PCA9535_OUTPUT1, 0xAA);
> +
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0x00);
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT1), ==, 0xAA);
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT0), ==, 0x00);
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT1), ==, 0xAA);
> +}
> +
>  static void pca9555_register_nodes(void)
>  {
>      QOSGraphEdgeOptions opts = {
> @@ -39,6 +110,10 @@ static void pca9555_register_nodes(void)
>      qos_node_consumes("pca9555", "i2c-bus", &opts);
>  
>      qos_add_test("reset-defaults", "pca9555", test_reset_defaults, NULL);
> +    qos_add_test("output-drives-input", "pca9555", test_output_drives_input,
> +                 NULL);
> +    qos_add_test("input-pullup", "pca9555", test_input_pullup, NULL);
> +    qos_add_test("port-independence", "pca9555", test_port_independence, NULL);
>  }
>  
>  libqos_init(pca9555_register_nodes);
> 


