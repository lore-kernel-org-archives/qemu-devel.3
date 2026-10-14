Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D17CC6B2C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH5Kx-0002k9-5D; Wed, 14 Oct 2026 16:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xH5Kn-0002bS-Pw; Wed, 14 Oct 2026 16:12:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xH5Kl-0004Xj-1i; Wed, 14 Oct 2026 16:12:21 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEiMHS1270169; Wed, 14 Oct 2026 20:11:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=PnJwtGDoWq9Wnu1Py/oYaRavW9GjpHz12ud108XOQDI=; b=WS1TfzzFWf8i
 y4Wz7J7Y/uvg4TEYUen23O34D3nLIqZdn2L0ujERtYHPNhgwcEBLx/7UguuQx5sw
 sNVZ9UydguHCp0FeiaLGWE4sO/rkbDzgKlwHHpBnjnnR7Hw/KneAAnpU3w6GGcza
 zwspFvDrF1Pn9OcezAExyb0WNk0MWrDEIO05z6fQ/eRI+qVh1lLIRth19KwOTiXv
 zUPreROsklx74B7EC5sQIIDItkRYp8+6Mc03875haEhfkJK2VF8jwhSIgmG8Iu8w
 S8XA6Eyc2MXjyWbYqGv59nBTfwUhxcVAPJz3HbkN/nKv7HTRVhTzMYU0SFWwDzgL
 5WVLVQjlnQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv0ny9w-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 20:11:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EIW2Z1660147; Wed, 14 Oct 2026 20:11:55 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9pb3prjn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 20:11:55 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69EKBsIt31064712
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Oct 2026 20:11:54 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F99858066;
 Wed, 14 Oct 2026 20:11:54 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 26C8D58064;
 Wed, 14 Oct 2026 20:11:53 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 Oct 2026 20:11:53 +0000 (GMT)
Message-ID: <68f7a84c2a01bf820a357980ef01488c43f8f38f.camel@linux.ibm.com>
Subject: Re: [PATCH v2 46/50] tests/qtest: ina238: cover conversion-ready
 and alert-latch semantics
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
Date: Wed, 14 Oct 2026 15:11:52 -0500
In-Reply-To: <20261012-bmc-minerva-v2-46-4c3dff084ec9@free.fr>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
 <20261012-bmc-minerva-v2-46-4c3dff084ec9@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX42qMlCGkjTcz
 ACT33ajdCVhpvKcRh5QBMou1ygpfeFaYyF4lMLgHc9WUhNtSjE6lRRZcF18CWKLy0dFingjFh0X
 m5QyrmMGLbRSTRB0ABIDB7z11n2ErSuhRNNcmPyJZFmcSJCM45SMIk1rkJOFQFcLPaDw/GpRRPT
 5nZ7q+dqIccy02YLLxCmnOI9rlt8rXhAOFcgwzO7UO96Qd8YCcN7vsETMFiSTkl10Hm8PkgeZjG
 LX5gUGL/yoVZBozP7LFlGpKB3Wa8CMSk+8K2TAA+P+H/eABGruyQA9sqbekQtANjfo58+r6ubCt
 3hYYEZ5tUqw2YSsBPCdM86JS7Aog92RMgA39hf+zFXigZ8G7A34d47KW1iqTZML7Y6dNj7goO+w
 Fwku5ammH/FQ/RETT80+ikm7qp0yg5QOpL2/+s+0I/yWvGDZRtFuk8GwApJjypjbYcq3E8cyi/h
 3K9azHonTRSuy9ArhUQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfXyAi8ABUIugJJ
 zGW3gIYDVr5xs5+QwVRuyiwUFqA2DdqrcivIkEk3ileTI80n/gakZ0fdQUrp7N7FtQk14FS7g03
 g5gSn6Ut4ULCYSt4I5+sxoR9ZKNi2f8=
X-Proofpoint-ORIG-GUID: khGChg3aRjMb9LahDgQE82CiI3KE5P0d
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6acfe20c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=5uQUhoKbu6oh5c5nzIwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: uGqLiCNjlxUfEvuAP_LyREjbhazc4idU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140078
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
> Add coverage for the DIAG_ALRT flag-clearing rules: which of a read and
> a write clears CNVRF and the limit flags in each alert mode, and that a
> conversion only re-evaluates the flags of the channels it converted.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  tests/qtest/ina238-test.c | 127 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 127 insertions(+)
> 
> diff --git a/tests/qtest/ina238-test.c b/tests/qtest/ina238-test.c
> index fb7bcc265c..e7dd50a822 100644
> --- a/tests/qtest/ina238-test.c
> +++ b/tests/qtest/ina238-test.c
> @@ -494,6 +494,106 @@ static void test_alert_latch(void *obj, void *data, QGuestAllocator *alloc)
>      g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==, 0);
>  }
>  
> +/* In latch mode a read releases the flag even while the fault persists. */
> +static void test_alert_latch_persist(void *obj, void *data,
> +                                     QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +    i2c_set16(dev, REG_SOVL, 0x1000);
> +    i2c_set16(dev, REG_DIAG_ALRT, DIAG_ALATCH);
> +
> +    qmp_ina238_set("shunt-voltage", 97200000);
> +
> +    /* First read shows the latched flag and clears it */
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==,
> +                    DIAG_SHNTOL);
> +
> +    /* Fault still present but no new conversion: the flag stays cleared */
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==, 0);
> +
> +    qmp_ina238_set("shunt-voltage", 97200000);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==,
> +                    DIAG_SHNTOL);
> +}
> +
> +/*
> + * In transparent mode a limit flag follows the live condition: a read leaves
> + * it set while the fault persists.
> + */
> +static void test_alert_transparent_persist(void *obj, void *data,
> +                                           QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +    i2c_set16(dev, REG_SOVL, 0x1000);
> +
> +    qmp_ina238_set("shunt-voltage", 97200000);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==,
> +                    DIAG_SHNTOL);
> +
> +    /* Repeated reads do not clear the flag while the fault is still present. */
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==,
> +                    DIAG_SHNTOL);
> +
> +    /* A conversion with the fault gone clears it. */
> +    qmp_ina238_set("shunt-voltage", 5000000);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==, 0);
> +}
> +
> +/* A DIAG_ALRT write releases a latched limit flag as a read does. */
> +static void test_alert_latch_write_clears(void *obj, void *data,
> +                                          QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +    i2c_set16(dev, REG_SOVL, 0x1000);
> +    i2c_set16(dev, REG_DIAG_ALRT, DIAG_ALATCH);
> +
> +    qmp_ina238_set("shunt-voltage", 97200000);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==,
> +                    DIAG_SHNTOL);
> +
> +    /* The read above cleared it; re-latch it with another conversion. */
> +    qmp_ina238_set("shunt-voltage", 97200000);
> +
> +    /* A write (keeping latch mode) clears the flag while the fault persists. */
> +    i2c_set16(dev, REG_DIAG_ALRT, DIAG_ALATCH);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==, 0);
> +
> +    /* The next conversion re-asserts the still-present fault. */
> +    qmp_ina238_set("shunt-voltage", 97200000);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==,
> +                    DIAG_SHNTOL);
> +}
> +
> +/*
> + * A conversion only re-evaluates the flags of the channels it converted: the
> + * shunt register a bus-only conversion left stale must not resurrect one.
> + */
> +static void test_alert_channel(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +    i2c_set16(dev, REG_SOVL, 0x1000);
> +    i2c_set16(dev, REG_DIAG_ALRT, DIAG_ALATCH);
> +
> +    qmp_ina238_set("shunt-voltage", 97200000);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==,
> +                    DIAG_SHNTOL);
> +
> +    /* Continuous bus-only mode */
> +    i2c_set16(dev, REG_ADC_CONFIG, 0x9000);
> +    qmp_ina238_set("bus-voltage", 12000000);
> +
> +    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x4BF0);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==, 0);
> +}
> +
>  /* DIAG_ALRT control bits are writable; status bits are read-only */
>  static void test_diag_control(void *obj, void *data, QGuestAllocator *alloc)
>  {
> @@ -529,6 +629,25 @@ static void test_cnvrf(void *obj, void *data, QGuestAllocator *alloc)
>      g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_CNVRF, ==, 0);
>  }
>  
> +/* A DIAG_ALRT write clears CNVRF only in latch mode. */
> +static void test_cnvrf_write(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    /* Latch mode: a write clears CNVRF. */
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +    i2c_set16(dev, REG_DIAG_ALRT, DIAG_ALATCH);
> +    qmp_ina238_set("shunt-voltage", 20000000);
> +    i2c_set16(dev, REG_DIAG_ALRT, DIAG_ALATCH);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_CNVRF, ==, 0);
> +
> +    /* Transparent mode: a write does not clear CNVRF. */
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +    qmp_ina238_set("shunt-voltage", 20000000);
> +    i2c_set16(dev, REG_DIAG_ALRT, 0x0000);
> +    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_CNVRF, ==, DIAG_CNVRF);
> +}
> +
>  /* Shunt-voltage injection limits */
>  static void test_shunt_limits(void *obj, void *data, QGuestAllocator *alloc)
>  {
> @@ -625,7 +744,15 @@ static void ina238_register_nodes(void)
>      qos_add_test("alert-power", "ina238", test_alert_power, NULL);
>      qos_add_test("alert-multi", "ina238", test_alert_multi, NULL);
>      qos_add_test("alert-latch", "ina238", test_alert_latch, NULL);
> +    qos_add_test("alert-latch-persist", "ina238", test_alert_latch_persist,
> +                 NULL);
> +    qos_add_test("alert-transparent-persist", "ina238",
> +                 test_alert_transparent_persist, NULL);
> +    qos_add_test("alert-latch-write-clears", "ina238",
> +                 test_alert_latch_write_clears, NULL);
> +    qos_add_test("alert-channel", "ina238", test_alert_channel, NULL);
>      qos_add_test("diag-control", "ina238", test_diag_control, NULL);
>      qos_add_test("cnvrf", "ina238", test_cnvrf, NULL);
> +    qos_add_test("cnvrf-write", "ina238", test_cnvrf_write, NULL);
>  }
>  libqos_init(ina238_register_nodes);
> 


