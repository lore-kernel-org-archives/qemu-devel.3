Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E6FC44511
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkONV-0008Pg-5Q; Thu, 16 Jul 2026 11:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkONT-0008PI-D0; Thu, 16 Jul 2026 11:51:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkONR-00034F-Kc; Thu, 16 Jul 2026 11:51:59 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GDfnh73371413; Thu, 16 Jul 2026 15:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=sU/JpBX20BKTlCadB7WpFmhZzDmT+tM6RqKGXcTWIdI=; b=f4I+Zrnh+Etg
 bJjnpygWhNP0sEcadkiO5zlZKplvMmOfgXp8JJJAZz0mzuF73rT8qnZUo2VANpWd
 KPMFaI7LnIzrgQaMHpYz0fdRroUy5EwBJ2ALEuLGmJTg7PWA+Ir54EmSM8WGk0P3
 88uWrAxBcy2HIZLtBWySZv3jKhX7q8FK2EIpRy1CWozwvUjU3YZS3vs/n9MtX2dk
 wFKW0vw99QKZwL31OP3UX4PLpFSBzLakn7SEWfI031bgIXPRvye8YYsMCu4XzjAy
 C6it40aG2H8mBUweDY3eWHUtQ2qp/h78Ges9KAwMfVh+uNQEmQ8qRJhdzOCvGI66
 6PvaxI7k6g==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegthsky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 15:51:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GFnj3G019628;
 Thu, 16 Jul 2026 15:51:27 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhnmeh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 15:51:27 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GFpRq85899146
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 15:51:27 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1403658050;
 Thu, 16 Jul 2026 15:51:27 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BBCA958045;
 Thu, 16 Jul 2026 15:51:25 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 15:51:25 +0000 (GMT)
Message-ID: <943e0e90db29f092b9514072b8d81da1fb707a3b.camel@linux.ibm.com>
Subject: Re: [PATCH 21/29] tests/qtest: pca9554: test polarity inversion
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
Date: Thu, 16 Jul 2026 10:51:25 -0500
In-Reply-To: <20260709-catalina-upgrade-v1-21-82a63fead90c@free.fr>
References: <20260709-catalina-upgrade-v1-0-82a63fead90c@free.fr>
 <20260709-catalina-upgrade-v1-21-82a63fead90c@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: UqXHy_e8mGpPhyTrCUvSHQjwG1Y_5pfV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2MSBTYWx0ZWRfX9kHUl84R3UTP
 9lFraXKGuD1/6uXjc6m38ia1HZr8lrPklgTyseO2xK7q8VLBI8+jfaCmqjVkbksZAIKpDS2Q0ZN
 ieN4yE9gUBKpmn4HrWXzEwqd47BmNVI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2MSBTYWx0ZWRfX4re65H6HrRNb
 Y1e8NeEotBP3Boe4r7E1AatAJ6f5Vrk2TVXYDdDUaMrcpMyYeCpwTm+whaqOEM370JLsZwTKdkq
 ZIt5CbWBmT0U6C3xQBaeMWc55iLMaNmj64TKTAR3YaYP+eU/IvRl0h/OYtQqjdh9tDoXa/ky0gf
 EnGZZzL2Ro1wWOFkdW9yGQxCOTkgELjIZSGz+9AXOV7wQVWgqgm2SImNVme00vzByJItfOq6ffv
 doAZkwSXSvo6heKWlbyKCtBDyfURQFnP6cOBv8IWYvnAUxd5+OeCnTGyhiO8yRlX6IGUJOO8rof
 aV7MkviWuIZd3GreE6wdHgNybiBway/eHCkLe2skVjaszjt86xQCj1UA/ovIyX0flDdHJMB71rY
 m/oXH+HTCBIIgYr5Jny0VzNYYtvaVMz8dnTnS9qZFQ7Po3xWU9ZasWb1/J4z5Nm7RRH/b3EszuT
 DGz/950d505F7K0OzYA==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a58fe01 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=t2Ogn3mOXeZJ2jJl_pgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _CuUngDmCmcDzAGjm6HcafxB2vZQ_CCB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160161
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
> Verify that the polarity register inverts the value read back from the
> INPUT register, both on pulled-up inputs and on output-driven pins, while
> leaving the OUTPUT register itself unchanged.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  tests/qtest/pca9554-test.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/tests/qtest/pca9554-test.c b/tests/qtest/pca9554-test.c
> index ce6e90f3f8..74237df611 100644
> --- a/tests/qtest/pca9554-test.c
> +++ b/tests/qtest/pca9554-test.c
> @@ -67,6 +67,41 @@ static void test_input_pullup(void *obj, void *data, QGuestAllocator *alloc)
>      g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0x00);
>  }
>  
> +/*
> + * Polarity inversion: reading INPUT returns the XOR of the pin levels and the
> + * polarity register.
> + */
> +static void test_polarity_inversion(void *obj, void *data,
> +                                    QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0xFF);
> +
> +    i2c_set8(dev, PCA9554_POLARITY, 0xFF);
> +    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0x00);
> +
> +    i2c_set8(dev, PCA9554_POLARITY, 0x0F);
> +    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0xF0);
> +}
> +
> +/* Polarity inversion combined with output-driven pins. */
> +static void test_polarity_with_output(void *obj, void *data,
> +                                      QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set8(dev, PCA9554_CONFIG, 0x00);
> +    i2c_set8(dev, PCA9554_OUTPUT, 0xA5);
> +    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0xA5);
> +
> +    i2c_set8(dev, PCA9554_POLARITY, 0xFF);
> +    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0x5A);
> +
> +    /* Inversion only affects the INPUT read, not the OUTPUT register. */
> +    g_assert_cmphex(i2c_get8(dev, PCA9554_OUTPUT), ==, 0xA5);
> +}
> +
>  static void pca9554_register_nodes(void)
>  {
>      QOSGraphEdgeOptions opts = {
> @@ -81,6 +116,10 @@ static void pca9554_register_nodes(void)
>      qos_add_test("output-drives-input", "pca9554", test_output_drives_input,
>                   NULL);
>      qos_add_test("input-pullup", "pca9554", test_input_pullup, NULL);
> +    qos_add_test("polarity-inversion", "pca9554", test_polarity_inversion,
> +                 NULL);
> +    qos_add_test("polarity-with-output", "pca9554", test_polarity_with_output,
> +                 NULL);
>  }
>  
>  libqos_init(pca9554_register_nodes);
> 


