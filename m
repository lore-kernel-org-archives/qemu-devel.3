Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BF0C44511
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkOLr-0007np-BS; Thu, 16 Jul 2026 11:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkOLo-0007i4-PQ; Thu, 16 Jul 2026 11:50:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkOLm-0002rj-W5; Thu, 16 Jul 2026 11:50:16 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GDgHnS3372645; Thu, 16 Jul 2026 15:49:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=FdoFNdgAiBc2PTT1QwIau3AqesypJ5PWb0l3H2chTD8=; b=CckzIFcSjwsi
 4U6Gu0TW+i5wfDJezQHB0q28/+iM8x0Us894pvHSY7tRhGfTO9HWOOWH/VtM/JIA
 XrtJNQX8/iF0lb4uB1f1MXj9+XEPGcVWUdoKQzhM9QxZ+0mExwxKEDO1/w4M/RZL
 V8GnkM8QGWbDcG2Q0f6iNjy73dhcjCXxqVa4bG1mpIqFBa4ZYI2Q0XKWBLg0DDUz
 JV3Y/4oI26xySkinzG83lll7SvRsY3bB4Xcif325SFiU/+JWzsCkj9fBw22FYCk6
 0gdwlt8m9DeWg6PMWIPcobWtrkLFIY87ioB5HkI/75VO21nXtXoNcShMhRrnFeKP
 A8axQ0nS2g==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegthse5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 15:49:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GFncAi032030;
 Thu, 16 Jul 2026 15:49:57 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05qdwd1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 15:49:57 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GFnupp31523420
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 15:49:56 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 19BF25805C;
 Thu, 16 Jul 2026 15:49:56 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 574F158051;
 Thu, 16 Jul 2026 15:49:55 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 15:49:55 +0000 (GMT)
Message-ID: <bb38d276e0dd91041c49eafb72f1c7e44d5da34a.camel@linux.ibm.com>
Subject: Re: [PATCH 20/29] tests/qtest: pca9554: test output-to-input
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
Date: Thu, 16 Jul 2026 10:49:55 -0500
In-Reply-To: <20260709-catalina-upgrade-v1-20-82a63fead90c@free.fr>
References: <20260709-catalina-upgrade-v1-0-82a63fead90c@free.fr>
 <20260709-catalina-upgrade-v1-20-82a63fead90c@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 51x5XG4bXH7DUtZ436cpSx8mkpdFav9m
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2MSBTYWx0ZWRfX/+sl6rP1kL/7
 yFGtVMTwPHnewzlthmDb3t3OhfESLdVnFDqejNOfS7KjwciJLrFIX2STZ7dpCBxSC8rA8GWZZmG
 WGCPcV/KTuK6OMD2DjJXjuSLq7rAxJc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2MSBTYWx0ZWRfXwrpww3/+gLPX
 EI4Vep8YX4FSt1aXfvdIgUVP3z4c7Zd3nPURlwY2tNIr+0twVxggb+kpI8L18AmhsfFcVL4rwf3
 a6b7IAXgQobez5yixbw/es0hrRj1hkn+juHZtiRksKOCQUKmHZNw+ONmNqJ6khw1MeQLcnJ1mUp
 gCa1EOpLLv5whwgzWvAGTWrnn/ND8TYu3N89WW/KIOcvBXxLkxsAtLaC/jngqUQSpKFV2jujO8j
 +7sf4eTIaqKtjkEm2z/OzuDLnYLMDgxKVj0o0vVDgvS+vCXrfq4/knHc3rSHcOFkfDTw+b0n8XT
 +/mfxs/SU++M9qFKg4Q2LWpSihUUFZMEllyrUR7zDCaFR1mHJLQ529+cRYiVuPMKWmnNWWss2c9
 M7RnURBGz1xNdzhyfaJ6KLx5ZeNa2cCxDA8EzBgdBkZxUREk9SzXtj2xLhB8lUw73CERuZneMQi
 uJD0WbzFMK2KR+4gRLA==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a58fda6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=Sfwnj-ir4w40EHbk1sMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: XJOJE5-G1IeE9ZUbNAf695uRp0dOU0pO
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
> Check that a pin configured as output drives its OUTPUT register level
> onto the pin (push-pull) as reflected by the INPUT register, and that a
> pin configured as input floats high through its pull-up.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  tests/qtest/pca9554-test.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/tests/qtest/pca9554-test.c b/tests/qtest/pca9554-test.c
> index a5f213a59c..ce6e90f3f8 100644
> --- a/tests/qtest/pca9554-test.c
> +++ b/tests/qtest/pca9554-test.c
> @@ -25,6 +25,48 @@ static void test_reset_defaults(void *obj, void *data, QGuestAllocator *alloc)
>      g_assert_cmphex(i2c_get8(dev, PCA9554_CONFIG), ==, 0xFF);
>  }
>  
> +/*
> + * A pin configured as output (config=0) drives its OUTPUT register level onto
> + * the pin (push-pull), which the INPUT register reflects. A pin configured as
> + * input (config=1) floats high through its pull-up.
> + */
> +static void test_output_drives_input(void *obj, void *data,
> +                                     QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    /* Low nibble output, high nibble input (pull-up). */
> +    i2c_set8(dev, PCA9554_CONFIG, 0xF0);
> +    i2c_set8(dev, PCA9554_OUTPUT, 0xFA);
> +    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0xFA);
> +
> +    /* All outputs, driven low then high. */
> +    i2c_set8(dev, PCA9554_CONFIG, 0x00);
> +    i2c_set8(dev, PCA9554_OUTPUT, 0x00);
> +    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0x00);
> +
> +    i2c_set8(dev, PCA9554_OUTPUT, 0xFF);
> +    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0xFF);
> +}
> +
> +/*
> + * With all pins configured as inputs the pull-ups make the INPUT register read
> + * all ones regardless of the OUTPUT register; switching a pin to output with
> + * output=0 drives it low.
> + */
> +static void test_input_pullup(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0xFF);
> +
> +    i2c_set8(dev, PCA9554_OUTPUT, 0x00);
> +    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0xFF);
> +
> +    i2c_set8(dev, PCA9554_CONFIG, 0x00);
> +    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0x00);
> +}
> +
>  static void pca9554_register_nodes(void)
>  {
>      QOSGraphEdgeOptions opts = {
> @@ -36,6 +78,9 @@ static void pca9554_register_nodes(void)
>      qos_node_consumes("pca9554", "i2c-bus", &opts);
>  
>      qos_add_test("reset-defaults", "pca9554", test_reset_defaults, NULL);
> +    qos_add_test("output-drives-input", "pca9554", test_output_drives_input,
> +                 NULL);
> +    qos_add_test("input-pullup", "pca9554", test_input_pullup, NULL);
>  }
>  
>  libqos_init(pca9554_register_nodes);
> 


