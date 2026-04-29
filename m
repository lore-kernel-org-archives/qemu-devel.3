Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F398BCCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 12:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI3rh-0004HP-IC; Wed, 29 Apr 2026 08:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wI3rY-0004FS-JY
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 08:17:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wI3rW-0000rU-0H
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 08:17:56 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63T9o1Fs031301; Wed, 29 Apr 2026 12:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=RPYk52kl6otr6Xnss
 Nb00wwkaB+5NLppj3t3DP2ngOo=; b=AgPSqV2tF7D09hK5H19QInVq4QBwVknkB
 SloOzCF0/z/rIi5TkvaFQg/yMqu4zKFIqDmbhbpKUyTgIlZIFdpWV8/kwoDgbGUA
 GXprdZeASWY4o9y1JWgpfIBEWIQns+TAkZhJweR5WHGKlTwg4pJ1IwRJc6pTN/YR
 JeU6sdJkJ36fYZYEZG3nO7wDYnDW3LNIMBrDIsgzjbY7nW63jn2SjgqsM78NLkNz
 SP3dmn0iCpLYvX7EgDAR791wHp0cnNk/bEKiFfPXE7gKuoQiEfVpvrwoeZPt985T
 erE+BBznTZkVSjI8nqcyTDvMI8tzCX8Htk56qkwYlJqDj2jGC2yeA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1e0ydx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 12:17:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TC8iNi027713;
 Wed, 29 Apr 2026 12:17:52 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8xk66he-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 12:17:52 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63TCHqp15768038
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Apr 2026 12:17:52 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9EF158045;
 Wed, 29 Apr 2026 12:17:51 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F9DB58050;
 Wed, 29 Apr 2026 12:17:51 +0000 (GMT)
Received: from mycroft-2.pok.ibm.com (unknown [9.47.158.222])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Apr 2026 12:17:51 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armenon@redhat.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 5/6] tests: Check whether the I2C master flag is set
Date: Wed, 29 Apr 2026 12:17:42 +0000
Message-ID: <20260429121743.1346635-6-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429121743.1346635-1-stefanb@linux.ibm.com>
References: <20260429121743.1346635-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: waqY89nkt9ueGhY4DyNyMoKw0tPY2zFF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEyNSBTYWx0ZWRfX9nAG1FW1C6ma
 3uo8LkNxY8PmPSurDy+Qsb2STtkfQ77yqetqHTyAv2Fx+uynLb0we8+g42ZrqcX7iR2me/sGzTm
 VANXYJw085aQyMRCQL4Jv8V6Y43paqOy2rv+Mtj9AKXh5osij3Wj3PVr8+jEFi/vL3TTlsODwJc
 D61rH7H8T+ft58sr8NjG7wsn7ZJftyGboTauKeE8XfkxnOqSUa+tIRpFlZJUuk0HE8ltHhmsYo/
 Fq5zQrZRa8nyaYmYb8efjIEvP91Uu0/6ZPrG60d+koUacHL8Gq6fA0x5c6L0u5A8DHlnRTm3KnV
 lVhJp5E+AMfD1sUa9eCW8zdOwmRXwaHrK6cwynQ88VV4qtscRLH1lOUHI5iQuSDsQykJtEoNiin
 yVUmmdbTx9tiyE8deOgRw+Cm0Gd21VGE4M7pVJMvBiTLyvmOvW8gvOG7XhaCUm8XedByCiunWrC
 +lPMpAXLzlB0Die5OEw==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69f1f6f0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=hDG30pTYrb-JhymLzFwA:9
X-Proofpoint-GUID: waqY89nkt9ueGhY4DyNyMoKw0tPY2zFF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290125
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
2.43.0


