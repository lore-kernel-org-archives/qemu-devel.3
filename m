Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476DBC44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkMc8-0008FR-1X; Thu, 16 Jul 2026 09:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkMc7-0008EZ-1O; Thu, 16 Jul 2026 09:58:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkMc5-0000yV-Bc; Thu, 16 Jul 2026 09:58:58 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GDfkrE3273658; Thu, 16 Jul 2026 13:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=/t/Wu6vEP4jAY8d/J+a5skgBm69K8EAeuuBjfEFVA9s=; b=MU3YnUIePoLn
 RKeYbs9a8J/WQtLqbu0JoyuycBQ1zk0Dj8vFkSfeT0CqksupctkrnZKWD/uc7aRm
 9+6CSEXw0/z9tpoGKSObI8LbaKyfCZiDTHWafvOvo52/gs0hRpzc9M7+de+a9ZZ7
 o8mSEVMuWSYX+rkkcNILfVQD8unzKOGSH5VjaaOZPO0xls5QglHGnyC7xqzcTRAA
 Y+ijTcLZmoEvHcT3XxtPd7H+4RDI0JePbMk6hb7cQmWffBU6s2hQJ43AdD66IN5Y
 CxFarG46+9f8UK3Ld8RizOijeY+A+24Wz+yz+M6Tv97P7lY4hJpxtz2CV35gdELx
 66VYyskxEQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexx0cn6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 13:58:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GDnd8C021348;
 Thu, 16 Jul 2026 13:58:33 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhn6gh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 13:58:33 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GDwWaK26411600
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 13:58:32 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 29C8758056;
 Thu, 16 Jul 2026 13:58:32 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED99A5803F;
 Thu, 16 Jul 2026 13:58:30 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 13:58:30 +0000 (GMT)
Message-ID: <5da27eef8c07b6d742d46dca19035e221cac402a.camel@linux.ibm.com>
Subject: Re: [PATCH 11/29] tests/qtest: pca9555: test output-to-input
 reflection and pull-ups
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
Date: Thu, 16 Jul 2026 08:58:30 -0500
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
X-Proofpoint-GUID: hu97qlDmYLwpqiJQKiYGv2HpRlV59_UM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE0MSBTYWx0ZWRfXx9vGInn6M2nn
 nU4IhnbGPJIT8ZaEmgGMmWZx8qPYpvJax7aTEJr50UBMyJd3o9bXrIMJeBCYszTCD2jfjxCnuu/
 aSw5JJMLB94JvZFEB64+v5NouzeEMEpNuac9CUfg+SFTUm0tuiAs9verFFaEMyD+qfhfahwKu0q
 5/E5SIvvNR7wx4Qx0lHL2v8OekvWmZgAI5N2UVhtBCC/DGswDq9Li7Har9emTURCqELzK/yT/W7
 sCXipig8/KNb+Ekjym9seWwtdAX5h8fHC4kiVh0ymw1DwgQS9jpEqX+fX3GjdoFjpKlS3FW5E2S
 QzNUK0gSo8qiU40rRPZudoyCKsWUioZIIlMw3SDrlmjIxwkt4gii9cM6Flr/4kvg7n2+sfYO3/k
 13sXZjCMRzk19d1BKKl6fnX9iIC1CSmNzLdGlPaGjoo3A52zNPUhAsRVR0MTAlzJo3Bs/KnkFnU
 A42uEEu2Yk+vhaujiBQ==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a58e38a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=ZRbvj7Q4pqp3RGZPE1UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: gDenUSNtj7BgC6QZ6xDFW2ONRrSCjtva
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE0MSBTYWx0ZWRfX2m8idNa5OpE5
 5W24esJJmf/lLHYAvPXVBpigY7MQwU5byhL+VLp5jz7DqWD3kpbCIiMWt1c02gNvqzsRDcafGaW
 60jjpx9hZPDmUGOyqdq3I5aXGQ+8V6Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
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

Not sure why patch 11 was sent twice (once from two different emails),
but...

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


