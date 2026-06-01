Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01ACCD6E60
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 21:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUAaj-0006cF-Tw; Mon, 01 Jun 2026 17:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wUAag-0006aW-9z
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:54:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wUAad-0003qK-Mo
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:54:34 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651EYswP867987; Mon, 1 Jun 2026 21:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=AVcIyrH3cFL80WBc2
 kgpR87P3qLBk9N1sWKrDncjlbs=; b=qFHbgBxP5EQ7LjVMWZ495Wn5g8AwuROsE
 AruuQDsF7p1fHgyuI0Ys3HGGsP5AhwX4dAqDT15A6GJDWutjISYGSE91hLeTPwvE
 yfykTcxNt9yHeauVc0qEBdUE9rc5g7mKyKmZ2jrLWXb/L26kNThTAPwv/5J34ojo
 TqZY2o8w3eFtdJWAe77B5A3cXGZsZ1BnYd1EpdTgZrGk9NUvicB/ekt2+jqADHPa
 BEvaQdULsUsjL/ZVWR3u0Gll0yUGcVpIT3EjzgfnoGHfrhRocSagIAcisUTpTgvh
 g6hueKN5odEf2/j/16+QdBo03hdcPFQZ6n8gEr6B08FxWwbEsbarw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjq32d1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 21:54:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651Ls63d005268;
 Mon, 1 Jun 2026 21:54:28 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakvrctb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 21:54:28 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 651LsSfv3342870
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Jun 2026 21:54:28 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E977258054;
 Mon,  1 Jun 2026 21:54:27 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7260A5805C;
 Mon,  1 Jun 2026 21:54:27 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  1 Jun 2026 21:54:27 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.ibm.com>,
 Arun Menon <armenon@redhat.com>
Subject: [PULL v1 05/16] tests: Check whether the I2C master flag is set
Date: Mon,  1 Jun 2026 17:53:58 -0400
Message-ID: <20260601215410.517009-6-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601215410.517009-1-stefanb@linux.ibm.com>
References: <20260601215410.517009-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DWgbgdj3gq5xZhXMVX7Zg_hnDwjVjX3Y
X-Proofpoint-GUID: DWgbgdj3gq5xZhXMVX7Zg_hnDwjVjX3Y
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a1dff95 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=hDG30pTYrb-JhymLzFwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDIxMSBTYWx0ZWRfX9e7EUFWhwECG
 GgMUiL/1lKneu/xee8vBzdqnQS4zs9dqrpIev+JMw5J5wYBgtyO7SlhHsAK7/Gt53GKv6qkvJSA
 S4NaiY6zq/53XjnhnCjSJgh4n2C2D9VYg8+hnB2CwDqscDddH4jnAQndCgtKmB77AT3XA2veizn
 ejXw23ToUBQd/PlT/KdcUaoYUdu0bhEYf2MCGiJaWXW/9OIRIIpwjNfb3XfKBd15DCESooQs5RY
 wUaTpxVQrFFkkdprDIvXGoz+lAqol3mwBYyENGF3F7QSEV6d2SzVSRb3+VZF7ALo5+sXzJjxYIj
 8BdkOrhMwl2YPhLlycDLvyR/t/EEuq+1xxkH6fkgp1Cf8hZjw6cNm17j+5cAi965dGL9GzLGjmH
 abnZTY9tt6jlF4D3pSEqOUjJ2g4H25u5FedcHW1jALlBxTpsDeVVyH/0VkxqG3dEQ2zGiDdnYPK
 3xgjwDUifhKG79FUjUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010211
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Replace the 'once' variable with a check for whether the master flag is
set so that the flag can be set when needed.

Reviewed-by: Arun Menon <armenon@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260429121743.1346635-6-stefanb@linux.ibm.com
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/qtest/qtest_aspeed.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/qtest_aspeed.c b/tests/qtest/qtest_aspeed.c
index f6da9adea9..7bf5abb9be 100644
--- a/tests/qtest/qtest_aspeed.c
+++ b/tests/qtest/qtest_aspeed.c
@@ -15,18 +15,21 @@
 #include "qtest_aspeed.h"
 #include "hw/i2c/aspeed_i2c.h"
 
+static bool aspeed_i2c_is_master_enabled(QTestState *s, uint32_t baseaddr)
+{
+    return qtest_readl(s, baseaddr + A_I2CC_FUN_CTRL) & A_I2CD_MASTER_EN;
+}
+
 static void aspeed_i2c_startup(QTestState *s, uint32_t baseaddr,
                                uint8_t slave_addr, uint8_t reg)
 {
     uint32_t v;
-    static int once;
 
-    if (!once) {
+    if (!aspeed_i2c_is_master_enabled(s, baseaddr)) {
         /* one time: enable master */
        qtest_writel(s, baseaddr + A_I2CC_FUN_CTRL, 0);
        v = qtest_readl(s, baseaddr + A_I2CC_FUN_CTRL) | A_I2CD_MASTER_EN;
        qtest_writel(s, baseaddr + A_I2CC_FUN_CTRL, v);
-       once = 1;
     }
 
     /* select device */
-- 
2.54.0


