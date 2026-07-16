Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3629C4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkN6U-00019w-Q0; Thu, 16 Jul 2026 10:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkN6G-00010Y-KH; Thu, 16 Jul 2026 10:30:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkN6C-0004ok-2a; Thu, 16 Jul 2026 10:30:06 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GDgMU73361652; Thu, 16 Jul 2026 14:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=i3N99XXUhzZ/JoqtxrSdRe/ZdGxWQ2zDc+hU/+q92aE=; b=NFzHcrXjffTP
 t+5PcW43UUJjWTXFph3MV2e2uEdPu5iOQt+se7cNYqGuZ+8rdpGadl55VZxmAVSZ
 kJ082GqB4OrnUGzCL2KGl+hoE/+Iq1feZtn1B0cRK1S/GfYNW/OL/QTqqQvASn1C
 ETmWN6lrdtHQGgYuejC8TpAbvRsfPW5jXWAi27m8ZXh/+h9nciQlH0p1ad+aniuI
 0eW49jrXZg66G0bDlWE6kgelsDNrWk27rgfQFBt4373sYF56zofRkS6LJ6OE5b9Z
 Ngnc00xhSkV/OPdfSKAosAKSXnPH7IGWkSnrZDDsXZbNUZf1yFwrayG86hvqNapE
 05jemz++OQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxsb9k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 14:29:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GEJnIL023176;
 Thu, 16 Jul 2026 14:29:38 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgn6j9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 14:29:38 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GETbHu31457926
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 14:29:37 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE10958052;
 Thu, 16 Jul 2026 14:29:37 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E86D458065;
 Thu, 16 Jul 2026 14:29:36 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 14:29:36 +0000 (GMT)
Message-ID: <e32a3161806c1fd056cf86fe674a0fbde21c8b00.camel@linux.ibm.com>
Subject: Re: [PATCH 12/29] tests/qtest: pca9555: test polarity inversion
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
Date: Thu, 16 Jul 2026 09:29:36 -0500
In-Reply-To: <20260709-catalina-upgrade-v1-12-82a63fead90c@free.fr>
References: <20260709-catalina-upgrade-v1-0-82a63fead90c@free.fr>
 <20260709-catalina-upgrade-v1-12-82a63fead90c@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 9ZbT8F4IZ4U8LWjLvh8uBF66-mtJUXA3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE0NiBTYWx0ZWRfX+R3PO9mFu4nB
 igl6xsuEH8qB/JCQKs1ZurVMGpdT4xpCXnUmw5949e+y5gjISyZEsbbZu3plEdWY64M/MQA2q8G
 aqsK1h1ggsscCA6w+VVZj1MIlyXx4SQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE0NiBTYWx0ZWRfX+SbiryyNufEE
 MELVEe4RFIJlHdEjzAKI4X/f9NCgqbge3lENf6ZEXSDBWi/sytipZRiVvWHv6+V1ZWhOkz+TplC
 InE2TaN7kXlFgshR3vBasd/2k7tPgryQ5yUknYHi1uTwiii4q5k9SA35fCW+BUZs9nWvCbb2nxO
 eBbI6VYeNbHyugz8BnAdRnZyp74NASN8V4v/qi9rSOYxb466oJHKww4TBE45k4ClSS8xOMBZQpf
 nwHcEukoc1AERixoLtOLY7E7UCE3I71BN5WnsaYrbXu93QzO9foXl7dz9kIJyu81S3jXg97luu0
 o2qRImDj79rKGukxu3QC2OmTS9eDNQjYQH/tNb5xCcRDyTYZcAzphRmNy8BE6mnSzYwQ21lL8sQ
 uR201ntssd8KJ/5b3P/Qep1r35E98jM9LLYRGJzyHwX9eV6+afdrUoEzfYzoRfRweT+1veUWXqp
 JaxaD5Ji/w8hWqp7rhA==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a58ead3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=yaGZh0SbKlrZijkgEIsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9H1RJs6DbarfMTKLxj1MbxLc-zu9gIaS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160146
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
> Add tests for the polarity inversion register: the inversion is applied
> when reading the INPUT register, both for input pins (pull-up) and for
> output-driven pins, and it does not affect the OUTPUT register readback.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  tests/qtest/pca9555-test.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/tests/qtest/pca9555-test.c b/tests/qtest/pca9555-test.c
> index 6b085702c3..2afa061bd2 100644
> --- a/tests/qtest/pca9555-test.c
> +++ b/tests/qtest/pca9555-test.c
> @@ -99,6 +99,46 @@ static void test_port_independence(void *obj, void *data,
>      g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT1), ==, 0xAA);
>  }
>  
> +/*
> + * Polarity inversion: reading INPUT with polarity bits set should
> + * return the XOR of the actual input state and the polarity register.
> + */
> +static void test_polarity_inversion(void *obj, void *data,
> +                                    QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0xFF);
> +
> +    i2c_set8(dev, PCA9535_POLARITY0, 0xFF);
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0x00);
> +
> +    i2c_set8(dev, PCA9535_POLARITY0, 0x0F);
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0xF0);
> +
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT1), ==, 0xFF);
> +
> +    i2c_set8(dev, PCA9535_POLARITY1, 0xAA);
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT1), ==, 0x55);
> +}
> +
> +/* Polarity inversion combined with output-driven pins. */
> +static void test_polarity_with_output(void *obj, void *data,
> +                                      QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set8(dev, PCA9535_CONFIG0, 0x00);
> +    i2c_set8(dev, PCA9535_OUTPUT0, 0xA5);
> +
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0xA5);
> +
> +    i2c_set8(dev, PCA9535_POLARITY0, 0xFF);
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0x5A);
> +
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT0), ==, 0xA5);
> +}
> +
>  static void pca9555_register_nodes(void)
>  {
>      QOSGraphEdgeOptions opts = {
> @@ -114,6 +154,10 @@ static void pca9555_register_nodes(void)
>                   NULL);
>      qos_add_test("input-pullup", "pca9555", test_input_pullup, NULL);
>      qos_add_test("port-independence", "pca9555", test_port_independence, NULL);
> +    qos_add_test("polarity-inversion", "pca9555", test_polarity_inversion,
> +                 NULL);
> +    qos_add_test("polarity-with-output", "pca9555", test_polarity_with_output,
> +                 NULL);
>  }
>  
>  libqos_init(pca9555_register_nodes);
> 


