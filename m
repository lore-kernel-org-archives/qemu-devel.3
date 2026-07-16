Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDEAC4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkMXJ-0005t1-3C; Thu, 16 Jul 2026 09:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkMXD-0005sN-0x; Thu, 16 Jul 2026 09:53:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkMXA-00005Z-G5; Thu, 16 Jul 2026 09:53:54 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GDfshg3361030; Thu, 16 Jul 2026 13:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=5W58qFRB7VEArcD6p6H5aiP/zVGPWyIGPUXAXm0jqpw=; b=hVhz+CP/ixAs
 qb773/4UUoQf5GqTDhVRHgkO9ZMEXAGE5N1Tw/MDlcIkHLtjOmbs3anTybdPWpAe
 0QNyGpBUI5lTJprmJDs4pvoowgxxYJnlX+rFGt4T8cqBQ6VRWbqlThaeyGoBss9W
 n19TqPUHGy8tA+mKIDVyjyiOTUc0LZne0LAFGeCyGkhBStSSfdXN5MvVZW9v23b9
 D+0cqORRrBLLWvr2yQRdnHvYdvqLKqxqgdymigVZuGNoC96CC4LAZgGLLqr9U9xT
 HIhaExq1D23YwSp11OrMJVie+zWTK/D8lpjn9W617Fg/seaA613Jx4bOjfqJ9IRe
 LXt4y9xehw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxs57h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 13:53:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GDncKY003301;
 Thu, 16 Jul 2026 13:53:33 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15k57kq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 13:53:33 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GDrWr122872592
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 13:53:32 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C6B358052;
 Thu, 16 Jul 2026 13:53:32 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7650758056;
 Thu, 16 Jul 2026 13:53:31 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 13:53:31 +0000 (GMT)
Message-ID: <aa6d9c079173083fbfe745d3d8116950292fe35d.camel@linux.ibm.com>
Subject: Re: [PATCH 10/29] tests/qtest: add PCA9555 register access tests
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
Date: Thu, 16 Jul 2026 08:53:31 -0500
In-Reply-To: <20260709-catalina-upgrade-v1-10-814575bc076b@free.fr>
References: <20260709-catalina-upgrade-v1-0-814575bc076b@free.fr>
 <20260709-catalina-upgrade-v1-10-814575bc076b@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 6ROMvE7CWnHx1mRcOk8WMnBamNmlcNYk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE0MSBTYWx0ZWRfXzqCjP2IWzRsi
 NA/4/xwUlxQLR3c0UvsAwVLEdNSPU57ju1HsSI9+ZLDnilQ3bAToljvPub29r5YDC0bjjQG3pYW
 QV2lTbA02PRjQ4hI4I7rcHJ48rJN+IQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE0MSBTYWx0ZWRfX9FF6Yq4oOkvQ
 tojO4VhXddrkUCMOHI6F9AnpOJRspsYNB89RSTsePXgqvQlW2GgTrOSZsQVFmS4BamuLYCj+JXN
 sMhE2FKRhXW1chj0/nqtuLl21m/ickBjs+TWmXnWawHbwaSWNqn0B6Iqinz/QnaJPCR8cMfnVTk
 Bxah6WbX8UJ+9lFmnQvL43CaaRRhSHN7ZplsPVtwrDEqw3LJyKpwyzRThFoZIuF5iYY3W07CpOe
 UHtdKcvQ0iCJufnf8e92EFlpJyXgtZSI3VTy7X5sPks52NCjEX46i0bla3dgHvx1D+NVJje0eFe
 6NzUB20quQ+jwnvOx5Gc8hBbVdhgMgrqiAyLkuozvS83oOjbqgjTtL/e/lnowbVHN4M995XBQJm
 m/P+EwKaxJ6SJk8xanCdd6dz55R1v03SYj7FLgSXKpTDB/8OtBZE2g2Oz3nFHSX8Swb0XzYxNNG
 XU+3t2xxmmsZ2PAZsKQ==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a58e25e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=P69FplKQNIv0u7DI7F0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: wSpkQhWtwwOSLNkQVzO_Iv_sr3UrPofO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160141
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
> Introduce a qtest for the PCA9555 16-bit I/O port expander.
> 
> This first set covers the power-on reset defaults and the read/write
> behaviour of the OUTPUT, CONFIG and POLARITY register pairs.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  tests/qtest/meson.build    |  1 +
>  tests/qtest/pca9555-test.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 56ff860e21..2c283708a5 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -318,6 +318,7 @@ qos_test_ss.add(
>    'tulip-test.c',
>    'nvme-test.c',
>    'pca9552-test.c',
> +  'pca9555-test.c',
>    'pci-test.c',
>    'pcnet-test.c',
>    'rs5c372-test.c',
> diff --git a/tests/qtest/pca9555-test.c b/tests/qtest/pca9555-test.c
> new file mode 100644
> index 0000000000..5945c3441e
> --- /dev/null
> +++ b/tests/qtest/pca9555-test.c
> @@ -0,0 +1,44 @@
> +/*
> + * QTest testcase for the PCA9555 16-bit I/O port expander
> + *
> + * Copyright (c) Meta Platforms, Inc. and affiliates.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/gpio/pca9552_regs.h"
> +#include "libqos/i2c.h"
> +#include "libqos/qgraph.h"
> +
> +#define PCA9555_TEST_ADDR 0x20
> +
> +/* Verify power-on reset defaults match the PCA9555 datasheet. */
> +static void test_reset_defaults(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0xFF);
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT1), ==, 0xFF);
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT0), ==, 0xFF);
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT1), ==, 0xFF);
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_POLARITY0), ==, 0x00);
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_POLARITY1), ==, 0x00);
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_CONFIG0), ==, 0xFF);
> +    g_assert_cmphex(i2c_get8(dev, PCA9535_CONFIG1), ==, 0xFF);
> +}
> +
> +static void pca9555_register_nodes(void)
> +{
> +    QOSGraphEdgeOptions opts = {
> +        .extra_device_opts = "address=0x20"
> +    };
> +    add_qi2c_address(&opts, &(QI2CAddress) { PCA9555_TEST_ADDR });
> +
> +    qos_node_create_driver("pca9555", i2c_device_create);
> +    qos_node_consumes("pca9555", "i2c-bus", &opts);
> +
> +    qos_add_test("reset-defaults", "pca9555", test_reset_defaults, NULL);
> +}
> +
> +libqos_init(pca9555_register_nodes);
> 


