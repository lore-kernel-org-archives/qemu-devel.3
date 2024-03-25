Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4A2C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 15:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1romKU-0006eo-EY; Mon, 25 Mar 2024 11:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1romKP-0006dl-MH
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:33:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1romKO-0001BM-2h
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:33:37 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42PEMHDi022793; Mon, 25 Mar 2024 15:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=s8Lxfbqk5T5lmWHnpkB0K02TGMHVtc5oC9L4Q9rrCcI=;
 b=oxLU+g7TVi+s3lgy6OFEA/KUfohBt76oUVIWvreFn0MclGWZjlQz8Wl8yr/nnwabW0Sm
 AjWl7F35YoSOHAm+H9j6T4cw1rDyV4Ldf9oyx9vFAPIrqJFYUeozaIgon88ChXPhFyej
 ozRW7NIqbYomUxjQWfVJ3qqiXTm507pPInyMY3GKrFQjZs5ettaiG2COmptWnpb3oYLW
 qGWREVk1xFgDr5ujBH7a1Thn737tZ9rGahyu0cGWA0BGLOfU6NmTvsHBUHXBXkFjjH2V
 c9jRhmk/gq3VxcFY1lHmDdMVfkri/OSyu3K2kH5ubs9JFHnpccWSTnKIIyqB1u/faSQN Tw== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x3aygr5ey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Mar 2024 15:33:33 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42PCkYFH011243; Mon, 25 Mar 2024 15:33:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x2bmkskxr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Mar 2024 15:33:32 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42PFXSEh32047498
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Mar 2024 15:33:30 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 994F12004F;
 Mon, 25 Mar 2024 15:33:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 485452004D;
 Mon, 25 Mar 2024 15:33:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.7.191])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 25 Mar 2024 15:33:28 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 4/4] tests/tcg: Test shmat(NULL)
Date: Mon, 25 Mar 2024 16:07:41 +0100
Message-ID: <20240325153313.526888-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325153313.526888-1-iii@linux.ibm.com>
References: <20240325153313.526888-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gslabpVkM939FpluGfoU3b_3x77c2Cdy
X-Proofpoint-ORIG-GUID: gslabpVkM939FpluGfoU3b_3x77c2Cdy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 adultscore=0 mlxlogscore=901 malwarescore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250086
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a small test to prevent regressions.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/multiarch/linux/linux-shmat-null.c | 38 ++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 tests/tcg/multiarch/linux/linux-shmat-null.c

diff --git a/tests/tcg/multiarch/linux/linux-shmat-null.c b/tests/tcg/multiarch/linux/linux-shmat-null.c
new file mode 100644
index 00000000000..94eaaec371a
--- /dev/null
+++ b/tests/tcg/multiarch/linux/linux-shmat-null.c
@@ -0,0 +1,38 @@
+/*
+ * Test shmat(NULL).
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdlib.h>
+#include <sys/ipc.h>
+#include <sys/shm.h>
+
+int main(void)
+{
+    int shmid;
+    char *p;
+    int err;
+
+    /* Create, attach and intialize shared memory. */
+    shmid = shmget(IPC_PRIVATE, 1, IPC_CREAT | 0600);
+    assert(shmid != -1);
+    p = shmat(shmid, NULL, 0);
+    assert(p != (void *)-1);
+    *p = 42;
+
+    /* Reattach, check that the value is still there. */
+    err = shmdt(p);
+    assert(err == 0);
+    p = shmat(shmid, NULL, 0);
+    assert(p != (void *)-1);
+    assert(*p == 42);
+
+    /* Detach. */
+    err = shmdt(p);
+    assert(err == 0);
+    err = shmctl(shmid, IPC_RMID, NULL);
+    assert(err == 0);
+
+    return EXIT_SUCCESS;
+}
-- 
2.44.0


