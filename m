Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0EFFFF885D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 13:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHiAM-0006Yo-0i; Tue, 28 Apr 2026 09:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wHiA6-0006TC-0A
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 09:07:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wHiA3-0001KK-3Q
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 09:07:37 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63RLOqRv1456647; Tue, 28 Apr 2026 13:07:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=SWRNRb01m0v6U5QU+
 YiQjy4XqmU4JddHXVnkxZ0iXGs=; b=rACPE0SITAuUdA+ejQwXY4cYGNFvJ0QOx
 Pz624e4ZnFfFokJRylW3IFhms5IDysaIv79T4X6TS4YJqqqtT/x5V3FeABSvH0LH
 otC/jfDdKWxGwYpZwVIN0407AjeIbR7YJ1aJjzu30SuDOpSg2ySIb9W7dBGPwZ0t
 ahBPeE8G5yzfG4zneMWBd7pBusf1VT8ErSo/og0i6yMOzvCjaXuLjorDGkn70wgn
 CRBLmYgW8Qp+HY4bV4SG4IOOPKYuVMKz8rUyW/bQXuwGpUKK2+gsimAatPsF4oOk
 eZdDW97J5Jw2JoYl/aNlI3rwWZeslCS90ITGHVlHcvSaY06W4ZscQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8vccdb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2026 13:07:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SCw6kq032355;
 Tue, 28 Apr 2026 13:07:30 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamy9hw0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2026 13:07:30 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63SD7TR230147302
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Apr 2026 13:07:29 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6347658062;
 Tue, 28 Apr 2026 13:07:29 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1EE5A58052;
 Tue, 28 Apr 2026 13:07:29 +0000 (GMT)
Received: from mycroft-2.pok.ibm.com (unknown [9.47.158.222])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Apr 2026 13:07:29 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armenon@redhat.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 5/6] tests: Implement aspeed_i2c_restart to reenable selection
 of master
Date: Tue, 28 Apr 2026 13:07:17 +0000
Message-ID: <20260428130718.1325177-6-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428130718.1325177-1-stefanb@linux.ibm.com>
References: <20260428130718.1325177-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69f0b113 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=h_94E6iZm1Z49o2US0QA:9
X-Proofpoint-ORIG-GUID: AHIMFklNcJ6lXKa3MNwjtiaLsLR8QPYY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDExOCBTYWx0ZWRfX+C0X+G3bKv/B
 yCDjifqarmUtwRebZfjy6q6K6mjYh7MVosuTSwlSCXD/v+abCfdmNYISme/M7bYk9IFu0TRORy/
 iGQTYbpERO5SnZhKREx+1B1RKHnkwPpF97Jkn2qFjfWoMwJLJCmfaOG4Xk3gPQ4gJz3wtOkJyXL
 /buUvyF/tVJP3RWOeQ0iCS1IQYBDjVUqOLBsQB1zGHUTUGJC7bJY7CEwygD217rxLRbNObi4Ias
 Bk/Ml3HfrMhWImcpuMRrbVARsadfft9iCkiHfioCBW3+ZfHdawL47kbg2NnH4NCHrN7kpgebC/S
 6sZyGzmbM0moquLYseCg/Dxny5h5pxltmYxk3h5AmM3yA0GvD4+JFR9nWoRwrFtLkNVBa6E39xo
 YodTk2ha2XT3z3uP3VKy36BClscbi2rp3PjFyAIhc5FXPvBpWoyna/Vq/IFywOCzNyGc8PxaQBE
 A1WoS6+JNUwb1YdlRYA==
X-Proofpoint-GUID: AHIMFklNcJ6lXKa3MNwjtiaLsLR8QPYY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280118
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

For some TPM  I2C tests it is important to be able to reenable the
selection of the master. Implement aspeed_i2c_restart to enable this.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/qtest/qtest_aspeed.c | 8 +++++++-
 tests/qtest/qtest_aspeed.h | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/qtest_aspeed.c b/tests/qtest/qtest_aspeed.c
index f6da9adea9..13934cc660 100644
--- a/tests/qtest/qtest_aspeed.c
+++ b/tests/qtest/qtest_aspeed.c
@@ -15,11 +15,17 @@
 #include "qtest_aspeed.h"
 #include "hw/i2c/aspeed_i2c.h"
 
+static int once;
+
+void aspeed_i2c_restart(void)
+{
+    once = false;
+}
+
 static void aspeed_i2c_startup(QTestState *s, uint32_t baseaddr,
                                uint8_t slave_addr, uint8_t reg)
 {
     uint32_t v;
-    static int once;
 
     if (!once) {
         /* one time: enable master */
diff --git a/tests/qtest/qtest_aspeed.h b/tests/qtest/qtest_aspeed.h
index d35b0c7cba..c0a095bb46 100644
--- a/tests/qtest/qtest_aspeed.h
+++ b/tests/qtest/qtest_aspeed.h
@@ -23,6 +23,8 @@ static inline uint32_t ast2600_i2c_calc_bus_addr(uint8_t bus_num)
     return AST2600_ASPEED_I2C_BASE_ADDR + 0x80 + bus_num * 0x80;
 }
 
+void aspeed_i2c_restart(void);
+
 uint8_t aspeed_i2c_readb(QTestState *s,
                          uint32_t baseaddr, uint8_t slave_addr, uint8_t reg);
 uint16_t aspeed_i2c_readw(QTestState *s,
-- 
2.43.0


