Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389C6C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkORM-0002Gq-0U; Thu, 16 Jul 2026 11:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkORJ-0002Ft-MP; Thu, 16 Jul 2026 11:55:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkORH-00041c-DS; Thu, 16 Jul 2026 11:55:57 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GDfbMI3370624; Thu, 16 Jul 2026 15:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=IjHrltQI5ygER9kSTGfyw6HUNSw82AVfj1xXszM96EI=; b=ZnRgFMiZMgQx
 se2x7/7UO105E0ll0o8NSZKEvUOQ784e+uKm5SiNx6g1vP7CWSNh6rUU/xoD7bqo
 xDPrWNC0qGx3R9Lkv7mfZtpdjT/JQXQkU6J46o5uLipbFHD4hwuw6nknUNc94wXi
 pTckMF2DiyQ+1voH8GOKb1J1JDam9NT1ulH2QL/kjiH2VybJ8UJZNySiXdv2+L0F
 A4zAholvI6kF2bIvj1Pm/ffB4kVEgEq6/sIXxHvnSNJYIlkwBusqSOqglrXP3AC5
 XJv4XBbC5lfThhhrMTgHgqQ+IvPqV8IK3ZXxWe5wvcTutHlJt676nQeGcobuXm8p
 x2hsy+qMqA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegtht5r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 15:55:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GFncZv022068;
 Thu, 16 Jul 2026 15:55:35 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgnh3v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 15:55:35 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GFtYcG5505642
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 15:55:34 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E1BD58063;
 Thu, 16 Jul 2026 15:55:34 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ECDFF58043;
 Thu, 16 Jul 2026 15:55:32 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 15:55:32 +0000 (GMT)
Message-ID: <05a578b4e329fd9bffeee76516c30fee2137faf2.camel@linux.ibm.com>
Subject: Re: [PATCH 22/29] tests/qtest: pca9554: test absence of command
 auto-increment
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
Date: Thu, 16 Jul 2026 10:55:32 -0500
In-Reply-To: <20260709-catalina-upgrade-v1-22-82a63fead90c@free.fr>
References: <20260709-catalina-upgrade-v1-0-82a63fead90c@free.fr>
 <20260709-catalina-upgrade-v1-22-82a63fead90c@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ULakXXBWvcaZEObglZHiVKMuUfNCZAON
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2MSBTYWx0ZWRfX4hjbNLqKcGWi
 L2NyOiq+v/80c9MwZSrkwa2D7QrLkSewIJJweAChq7PMQ128CxrPI+gFYUHOcozwrkyyDxk86qt
 S1AqGMVsWg0UXPM2t4Kh8UG7C99TuM4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2MSBTYWx0ZWRfX6+W/5IgMCfWZ
 nPEmjH+M2pEULbNAgtAV607qHgTzZjPfhGHGqUoBd/JuEfqxDG2HCxEKCaqlgqgutLp7eZX/dlM
 iCmFl9/AVtb1hHJ2fOWCSi/EhukEcw30qHAYPiEpOC/fK2z5FHvnFT2q99He/7MBgMHFv//yA6x
 HQw0Cwboi+KP16iUt4sZj2gvA4W8kr+0zqYzCFmyLEAJneaElxy3F+YIogVnT6iv+ygJ2qvW9DV
 hPfBlTcc4qHvqQMPjL+Qlah0GMrg2OJa+Qjgb2ijW2KsTgh2Mt2fCxborV2g0yAbnnw6Jy03VQw
 XAuZFnD0K3hC6v8l5d+hNeZWGrVV2nu8DE3ZW0HVBhQog+4vWCF+BVG8R9V5sIwr5UZhhKJk5g+
 /6M8dI15Y4rEdB6NXu8h4mHTc0cc1KeG5F7eSLHa4xOepGRXRK9sVs491DeZyGDzjG3vhN8xRTw
 60M3dvpdyqdXXTFMxHg==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a58fef8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=fbQuLwj851bMIQCpZIAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 76pK1Pa2AIEq3-B3Kt6i-QyzVll4JLR2
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
> The PCA9554 selects one of its four registers with a single command byte
> and does not auto-increment the register pointer, so a multi-byte I2C
> transfer keeps addressing the register chosen by the command byte instead
> of walking through the register map.
> 
> Add a test covering this: a two-byte read returns the addressed register
> twice, and a two-byte write updates only that register, leaving its
> neighbour untouched.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  tests/qtest/pca9554-test.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/tests/qtest/pca9554-test.c b/tests/qtest/pca9554-test.c
> index 74237df611..0da1f3304b 100644
> --- a/tests/qtest/pca9554-test.c
> +++ b/tests/qtest/pca9554-test.c
> @@ -102,6 +102,33 @@ static void test_polarity_with_output(void *obj, void *data,
>      g_assert_cmphex(i2c_get8(dev, PCA9554_OUTPUT), ==, 0xA5);
>  }
>  
> +/*
> + * The PCA9554 has no auto-increment: the command pointer never advances, so
> + * multi-byte reads and writes all target the addressed register.
> + */
> +static void test_no_autoincrement(void *obj, void *data,
> +                                  QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +    uint8_t buf[2];
> +
> +    /* Distinct values in adjacent registers. */
> +    i2c_set8(dev, PCA9554_OUTPUT, 0xAA);
> +    i2c_set8(dev, PCA9554_POLARITY, 0x33);
> +
> +    /* Two reads from OUTPUT return OUTPUT twice, not OUTPUT then POLARITY. */
> +    i2c_read_block(dev, PCA9554_OUTPUT, buf, 2);
> +    g_assert_cmphex(buf[0], ==, 0xAA);
> +    g_assert_cmphex(buf[1], ==, 0xAA);
> +
> +    /* The second written byte overwrites OUTPUT; POLARITY is untouched. */
> +    buf[0] = 0x12;
> +    buf[1] = 0x34;
> +    i2c_write_block(dev, PCA9554_OUTPUT, buf, 2);
> +    g_assert_cmphex(i2c_get8(dev, PCA9554_OUTPUT), ==, 0x34);
> +    g_assert_cmphex(i2c_get8(dev, PCA9554_POLARITY), ==, 0x33);
> +}
> +
>  static void pca9554_register_nodes(void)
>  {
>      QOSGraphEdgeOptions opts = {
> @@ -120,6 +147,7 @@ static void pca9554_register_nodes(void)
>                   NULL);
>      qos_add_test("polarity-with-output", "pca9554", test_polarity_with_output,
>                   NULL);
> +    qos_add_test("no-autoincrement", "pca9554", test_no_autoincrement, NULL);
>  }
>  
>  libqos_init(pca9554_register_nodes);
> 


