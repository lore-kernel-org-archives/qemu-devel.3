Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FB7C4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkMqS-00068F-Gz; Thu, 16 Jul 2026 10:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkMqQ-000675-E9; Thu, 16 Jul 2026 10:13:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkMqO-0002oT-QJ; Thu, 16 Jul 2026 10:13:46 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GDfnBk3273886; Thu, 16 Jul 2026 14:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=DkRj4IQjAAWkvQEAAUfC42BwQbmAUOw464DnzLMT8mk=; b=iP8LWQ7fqLbN
 DifwfJx7xaByqrrxHpRIU2kS1ZeGPFjUYwlDrFUWDCQ9FYnHjzPfpmr5rIXOTgOE
 he7+bVOjTkQODirggIGkobIhKnaPNQlOMgsmDzeTQt5nrAV0UTE1aAaqjOWL3+Ex
 6OXLguv7nc3VdkJRSq/qA1sUEp/SuzyX0YXInRd3pqs4qanCaKbJ8et69fof183V
 qiR6MJXbhhsJyVfkOfNSLaGyFzpYnMwW43BCCaWAx0fL3aygTho8kvipwaO3x3HD
 bziSd8/lg+/cVs1lhsclU7yhYey9vBjVYjY8OgQ04CLBU9FktG5UXD9bE7b6bzJx
 ZDk5xQfIag==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexx0f2p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 14:13:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GE4drr005219;
 Thu, 16 Jul 2026 14:13:26 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhn8hf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 14:13:26 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GEDQ7K30474942
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 14:13:26 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B2795805E;
 Thu, 16 Jul 2026 14:13:26 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6105E58056;
 Thu, 16 Jul 2026 14:13:25 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 14:13:25 +0000 (GMT)
Message-ID: <df4d9cf39e0d09dbd0184a38f55531bef3555b14.camel@linux.ibm.com>
Subject: Re: [PATCH 13/29] tests/qtest: pca9555: test auto-increment and
 command wrapping
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
Date: Thu, 16 Jul 2026 09:13:25 -0500
In-Reply-To: <20260709-catalina-upgrade-v1-13-82a63fead90c@free.fr>
References: <20260709-catalina-upgrade-v1-0-82a63fead90c@free.fr>
 <20260709-catalina-upgrade-v1-13-82a63fead90c@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: cJ7M7uWIWwBB7BO5TCySf7Wp2nmrgq03
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE0NiBTYWx0ZWRfX/VHHB6vjBLMq
 s4rkla3uJIcVop0jGQgBc4s1f6rTVHub7jjIitiCiFZEkX43N7LDinFi7hcaz01ptLFtLrxLrQd
 yELJNqMGD/gOhF6CTyPzaY0ORob0W/PQiOuNnoUr6jV/drs4i9kX9Uikd8Opb5R4u6LnCuCtj8P
 8XnYzfGVoSoJv+wB0LN5WGk7vIg9XNVwbjIwuC6mRrB2+cePlW94o+MJ/HtYPd9E9XPlqief+lF
 bhK66RuD+m6Nd7Benp7ZjnyQbbqYcYDVVh2kzcXy6dca98IIQ9mwBmseaujSC43pwkPkfvam4lc
 s3HtiYgQW8OVdTtMH7x3F0cQ6XbhWvRcgKhLx0W8G1dci+FxHqOb4OCPycReAlNMPfKrS7JuvSp
 MJt4iy32P0noP//AWDWBWdfOO9gmqZB+B+YKmlS8P6QNoEkZH1Hs6WDJyLdJZj1BIMtQXNjIU4V
 8UX2gefn+AvGK5qKtgQ==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a58e708 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=2m9YVKBKTLHlkAwVmdwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: SWPOI-s0HdNhfgqen460QXkPBiAgt650
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE0NiBTYWx0ZWRfX2LWz2h7nknx6
 SLEKSwoKRZWF09TB8HTITi1kjagGLqEpjv4SMe3E9yJkEv1aQIyU1PmdMZxLBzPefc3RzW+LsRu
 I4pBCV3Tx+LMn5kcX6+clzncnu7Gs9o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160146
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
> Add tests for the I2C command protocol of the GPIO variant: the
> auto-increment that toggles bit 0 within a register pair on reads and
> writes, and the 3-bit command wrapping that aliases out-of-range register
> addresses back into the register window.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  tests/qtest/pca9555-test.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
> 
> diff --git a/tests/qtest/pca9555-test.c b/tests/qtest/pca9555-test.c
> index 2afa061bd2..84d771bcbb 100644
> --- a/tests/qtest/pca9555-test.c
> +++ b/tests/qtest/pca9555-test.c
> @@ -139,6 +139,87 @@ static void test_polarity_with_output(void *obj, void *data,
>      g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT0), ==, 0xA5);
>  }
>  
> +/*
> + * The PCA9555 auto-increments by toggling bit 0 of the command pointer
> + * within a register pair. Reading two bytes from INPUT0 should yield
> + * INPUT0 then INPUT1.
> + */
> +static void test_auto_increment_read(void *obj, void *data,
> +                                     QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +    uint8_t buf[2];
> +
> +    i2c_set8(dev, PCA9535_CONFIG0, 0x00);
> +    i2c_set8(dev, PCA9535_CONFIG1, 0x00);
> +    i2c_set8(dev, PCA9535_OUTPUT0, 0xAA);
> +    i2c_set8(dev, PCA9535_OUTPUT1, 0x55);
> +
> +    i2c_read_block(dev, PCA9535_INPUT0, buf, 2);
> +    g_assert_cmphex(buf[0], ==, 0xAA);
> +    g_assert_cmphex(buf[1], ==, 0x55);
> +
> +    i2c_read_block(dev, PCA9535_OUTPUT0, buf, 2);
> +    g_assert_cmphex(buf[0], ==, 0xAA);
> +    g_assert_cmphex(buf[1], ==, 0x55);
> +}
> +
> +/*
> + * Auto-increment write: writing two data bytes after a command byte
> + * should write to port 0 then port 1 of the addressed register pair.
> + */
> +static void test_auto_increment_write(void *obj, void *data,
> +                                      QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +    uint8_t buf[2];
> +
> +    buf[0] = 0x12;
> +    buf[1] = 0x34;
> +    i2c_write_block(dev, PCA9535_OUTPUT0, buf, 2);
> +
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT0), ==, 0x12);
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT1), ==, 0x34);
> +
> +    buf[0] = 0x0F;
> +    buf[1] = 0xF0;
> +    i2c_write_block(dev, PCA9535_CONFIG0, buf, 2);
> +
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_CONFIG0), ==, 0x0F);
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_CONFIG1), ==, 0xF0);
> +}
> +
> +/*
> + * Auto-increment toggles within the pair: starting from port 1 should
> + * wrap back to port 0 (toggle bit 0).
> + */
> +static void test_auto_increment_toggle(void *obj, void *data,
> +                                       QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +    uint8_t buf[2];
> +
> +    i2c_set8(dev, PCA9535_OUTPUT0, 0xAA);
> +    i2c_set8(dev, PCA9535_OUTPUT1, 0x55);
> +
> +    i2c_read_block(dev, PCA9535_OUTPUT1, buf, 2);
> +    g_assert_cmphex(buf[0], ==, 0x55);
> +    g_assert_cmphex(buf[1], ==, 0xAA);
> +}
> +
> +/*
> + * Verify the command byte wraps at 3 bits: register addresses
> + * beyond 7 should alias to the same register (bits [2:0] only).
> + */
> +static void test_command_wrapping(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set8(dev, PCA9535_OUTPUT0, 0x42);
> +
> +    g_assert_cmphex(i2c_get8(dev, 0x0A), ==, 0x42);
> +}
> +
>  static void pca9555_register_nodes(void)
>  {
>      QOSGraphEdgeOptions opts = {
> @@ -158,6 +239,13 @@ static void pca9555_register_nodes(void)
>                   NULL);
>      qos_add_test("polarity-with-output", "pca9555", test_polarity_with_output,
>                   NULL);
> +    qos_add_test("auto-increment-read", "pca9555", test_auto_increment_read,
> +                 NULL);
> +    qos_add_test("auto-increment-write", "pca9555", test_auto_increment_write,
> +                 NULL);
> +    qos_add_test("auto-increment-toggle", "pca9555", test_auto_increment_toggle,
> +                 NULL);
> +    qos_add_test("command-wrapping", "pca9555", test_command_wrapping, NULL);
>  }
>  
>  libqos_init(pca9555_register_nodes);
> 


