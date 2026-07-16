Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E14EC44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkN7g-0001ZD-QP; Thu, 16 Jul 2026 10:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkN7d-0001XP-L7; Thu, 16 Jul 2026 10:31:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkN7a-0005EP-LR; Thu, 16 Jul 2026 10:31:33 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GDfdlM3359884; Thu, 16 Jul 2026 14:31:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=wPFPkHnrMKAtZ5WU9SXmfL8BWWH/cTkjh2iQ+MzUJPA=; b=lkGUomHyVWkg
 VteOPlqlHn6aRY7Jbu06aJ1pQ27nJx87q8bRaseG4tCYSMHwlZWcalA7j2UrzoIQ
 iv7etf8malQAbsYqHgrDiIpsDYAbN3fpUJaQ8AvYRjvEbs/ikvv90hy0wc0ysIzs
 2arZx2Oh9WHbrYfMoRdTHk8T+yW5uiOfCnYhpsddZEXarb3h0wb/Kv+ugH5tpwA3
 gHgv+ch6tI33t5a6C0V9gM1Xww53tgFF9/Zjsi+OnrlSf2bhxiBjurOio+iFk9Ye
 7sAsTSasE5DRTqI1m6hzt7S9QxBgM/Y+pCt4awVw9/5kQ9n7xkvPYxPdxCGYNvhC
 uNOQIUY3yw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxsbs7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 14:31:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GEJjMr018236;
 Thu, 16 Jul 2026 14:31:06 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hwdgyx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 14:31:06 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GEV5Ar25166350
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 14:31:05 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 31DE458054;
 Thu, 16 Jul 2026 14:31:05 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E06CB5803F;
 Thu, 16 Jul 2026 14:31:03 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 14:31:03 +0000 (GMT)
Message-ID: <ab22bba9872d1ee5f9da5b06042046e735aad339.camel@linux.ibm.com>
Subject: Re: [PATCH 14/29] tests/qtest: pca9552: test behaviour specific to
 the LED variant
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
Date: Thu, 16 Jul 2026 09:31:03 -0500
In-Reply-To: <20260709-catalina-upgrade-v1-14-82a63fead90c@free.fr>
References: <20260709-catalina-upgrade-v1-0-82a63fead90c@free.fr>
 <20260709-catalina-upgrade-v1-14-82a63fead90c@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 9Hk5U0-zbqC77sxqTnu9viaRJ1VooXuw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE0NiBTYWx0ZWRfX+qI076p2/bN2
 wAPlibxYhRFMNfGIC+FAUcwV7oIyv634aIH5LrO3jrmsDBhoeHiBfcP+DLyODN16+X5OnmWmqLU
 bBqRZ44Ns5B3AfqN/NOY9vHR/b0/hFA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE0NiBTYWx0ZWRfX5KVjbfxcM9/z
 mIRQbzHleLJBj8YiRa2ZVXB3nL3/Wbduk0f7+OICvXq3Rps0YgNkYuT+Pr9rL15qjn8HbRy6l3D
 YuJ/6hTNyS2oYNF8bD8cmfV2JnkDkd+/k1aoBbFC+OV8r+GYbTZDT1TJ/OlppAWSi3tcZ35Bzwq
 Yo7jeprjad5NHR0OSTiW6cOUppLbcnXvFKL3rR3Oi7ffn+19sobWsMPgMusroQ6VykWNSrUuX6q
 EIbmv/WMdT2lLYTJuV6l+bydb0oY8NTCk5qNS8pi7YeNiKUWDpj4Sjf0um5s6U4gj2NaiwQWRxi
 bOHIHzftstLQApMv3hxgDddR2R++2AuFPpAW1oxtL4FlR/vcRT30LeBBqxZ+BJqDAqvLEYg1pve
 qdhSgpA2H/UJATUP8wnwPecLEgdooarFnBEb8NsT6FGgfwMJadazqNbxcmv1/iPllXJQ4seoUkU
 wogmZRSqP+cYqYtYWpg==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a58eb2b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=bBjh46LIgEFOdmwQBDIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GTbVTvB6p-cOMs0mK4FMowGWTtTzVRQU
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
> The PCA9552 shares its device model with the PCA9535/PCA9555 GPIO
> expanders but decodes registers differently. Add tests for the behaviour
> that is specific to the LED variant and diverges from the PCA9555:
> 
>   - the power-on reset defaults of the prescaler, PWM and LED-selector
>     registers;
>   - the prescaler/PWM registers (2-5), which are OUTPUT/POLARITY on the
>     PCA9555, as plain read/write storage;
>   - the auto-increment, which only advances when the AI command bit is set
>     and wraps modulo the full 10-register map (rather than toggling bit 0
>     within a register pair);
>   - the 4-bit command decode, where an out-of-range register reads back
>     0xFF instead of aliasing into the register window.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  tests/qtest/pca9552-test.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/tests/qtest/pca9552-test.c b/tests/qtest/pca9552-test.c
> index 74749576923..3718dfbd227 100644
> --- a/tests/qtest/pca9552-test.c
> +++ b/tests/qtest/pca9552-test.c
> @@ -77,6 +77,76 @@ static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
>      g_assert_cmphex(value, ==, 0xEF);
>  }
>  
> +/* Verify the power-on reset defaults. */
> +static void test_reset_defaults(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *i2cdev = (QI2CDevice *)obj;
> +
> +    /* Prescalers, PWM duty cycles and LED selectors (all LEDs off) */
> +    g_assert_cmphex(i2c_get8(i2cdev, PCA9552_PSC0), ==, 0xFF);
> +    g_assert_cmphex(i2c_get8(i2cdev, PCA9552_PWM0), ==, 0x80);
> +    g_assert_cmphex(i2c_get8(i2cdev, PCA9552_PSC1), ==, 0xFF);
> +    g_assert_cmphex(i2c_get8(i2cdev, PCA9552_PWM1), ==, 0x80);
> +    g_assert_cmphex(i2c_get8(i2cdev, PCA9552_LS0), ==, 0x55);
> +    g_assert_cmphex(i2c_get8(i2cdev, PCA9552_LS1), ==, 0x55);
> +    g_assert_cmphex(i2c_get8(i2cdev, PCA9552_LS2), ==, 0x55);
> +    g_assert_cmphex(i2c_get8(i2cdev, PCA9552_LS3), ==, 0x55);
> +
> +    /* All LEDs off, so every pin floats high through its pull-up */
> +    g_assert_cmphex(i2c_get8(i2cdev, PCA9552_INPUT0), ==, 0xFF);
> +    g_assert_cmphex(i2c_get8(i2cdev, PCA9552_INPUT1), ==, 0xFF);
> +}
> +
> +/*
> + * The PCA9552 only advances the command pointer when the AI bit is set, and
> + * it wraps modulo the full 10-register map.
> + */
> +static void test_autoinc_requires_ai_bit(void *obj, void *data,
> +                                         QGuestAllocator *alloc)
> +{
> +    QI2CDevice *i2cdev = (QI2CDevice *)obj;
> +    uint8_t reg;
> +    uint8_t resp;
> +
> +    /*
> +     * With the AI bit, reading from LS3 (register 9) rolls over to INPUT0
> +     * (register 0), not to a sibling in a register pair. All LEDs are off
> +     * after reset so the input ports read 0xFF.
> +     */
> +    reg = PCA9552_LS3 | PCA9552_AUTOINC;
> +    qi2c_send(i2cdev, &reg, 1);
> +    qi2c_recv(i2cdev, &resp, 1); /* LS3 */
> +    g_assert_cmphex(resp, ==, 0x55);
> +    qi2c_recv(i2cdev, &resp, 1); /* wraps to INPUT0 */
> +    g_assert_cmphex(resp, ==, 0xFF);
> +    qi2c_recv(i2cdev, &resp, 1); /* INPUT1 */
> +    g_assert_cmphex(resp, ==, 0xFF);
> +
> +    /*
> +     * Without the AI bit the pointer must not advance: repeated reads keep
> +     * returning the same register.
> +     */
> +    i2c_set8(i2cdev, PCA9552_LS0, 0x54);
> +    reg = PCA9552_LS0;
> +    qi2c_send(i2cdev, &reg, 1);
> +    qi2c_recv(i2cdev, &resp, 1);
> +    g_assert_cmphex(resp, ==, 0x54);
> +    qi2c_recv(i2cdev, &resp, 1);
> +    g_assert_cmphex(resp, ==, 0x54);
> +}
> +
> +/*
> + * The PCA9552 decodes a 4-bit command and has no register past LS3 (9), so
> + * addressing register 0x0A reads back 0xFF.
> + */
> +static void test_command_out_of_range(void *obj, void *data,
> +                                      QGuestAllocator *alloc)
> +{
> +    QI2CDevice *i2cdev = (QI2CDevice *)obj;
> +
> +    g_assert_cmphex(i2c_get8(i2cdev, 0x0A), ==, 0xFF);
> +}
> +
>  static void pca9552_register_nodes(void)
>  {
>      QOSGraphEdgeOptions opts = {
> @@ -89,5 +159,11 @@ static void pca9552_register_nodes(void)
>  
>      qos_add_test("tx-rx", "pca9552", send_and_receive, NULL);
>      qos_add_test("rx-autoinc", "pca9552", receive_autoinc, NULL);
> +    qos_add_test("reset-defaults", "pca9552", test_reset_defaults, NULL);
> +    qos_add_test("autoinc-requires-ai-bit", "pca9552",
> +                 test_autoinc_requires_ai_bit, NULL);
> +    qos_add_test("command-out-of-range", "pca9552", test_command_out_of_range,
> +                 NULL);
>  }
> +
>  libqos_init(pca9552_register_nodes);
> 


