Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82346C4829E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 20:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZdGT-0005oJ-JR; Mon, 12 Feb 2024 15:50:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rZdGK-0005kX-F7
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 15:50:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rZdG8-0003QH-KB
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 15:50:48 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41CKjskK010146; Mon, 12 Feb 2024 20:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=d2phFJJlULUL7w6epIsmhj+QJe2pXN6zPUlCSNfC8Z8=;
 b=Nau3QGCHZGF0bDC/G2/fb9UR/84xDyECXDo5z1GZ2Kdz5UC2O24p5vIb2AVArhBkYxDt
 IviN43Q1TE0/iqUruQX88oEiENXhmPOzhYOb7SQLP5EIzfqOMllUESaP7M3P1SPmK/Ll
 NsYYCuUXQk2+9b6Bl8l9161kvdRbwLbbyri1lOSQkPUXXrCLcOttMmBr1QqbgI7LYM07
 TMM4Q148Wlav+sb/4PEJvEQCJnTZLIYfKMy8Vonl51a0DuSn26arsQSAUfK0uRlAvFJL
 q25O6+d8gT390yE+OfxqvpfIWvuzL8eFVcAeMeC0OxghT+/xPF81ACLZnyHmWyE6i2BL NA== 
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7tf8r8ab-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Feb 2024 20:50:35 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41CJeVj0024961; Mon, 12 Feb 2024 20:50:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mfp337b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Feb 2024 20:50:34 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41CKoU1A20054626
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 20:50:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 507C32004F;
 Mon, 12 Feb 2024 20:50:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E40E720043;
 Mon, 12 Feb 2024 20:50:29 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.4.126])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 12 Feb 2024 20:50:29 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 2/2] tests/tcg: Add SIGRTMIN/SIGRTMAX test
Date: Mon, 12 Feb 2024 21:45:43 +0100
Message-ID: <20240212205022.242968-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212205022.242968-1-iii@linux.ibm.com>
References: <20240212205022.242968-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: y8VjxJ4XrRLxheZ_r0w0idaz2Ch8uSq7
X-Proofpoint-ORIG-GUID: y8VjxJ4XrRLxheZ_r0w0idaz2Ch8uSq7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_16,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=735
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402120161
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Test the lowest and the highest real-time signals.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/multiarch/linux/linux-sigrtminmax.c | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 tests/tcg/multiarch/linux/linux-sigrtminmax.c

diff --git a/tests/tcg/multiarch/linux/linux-sigrtminmax.c b/tests/tcg/multiarch/linux/linux-sigrtminmax.c
new file mode 100644
index 00000000000..773383a3fef
--- /dev/null
+++ b/tests/tcg/multiarch/linux/linux-sigrtminmax.c
@@ -0,0 +1,41 @@
+/*
+ * Test the lowest and the highest real-time signals.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+static bool seen_sigrtmin, seen_sigrtmax;
+
+static void handle_signal(int sig)
+{
+    if (sig == SIGRTMIN) {
+        seen_sigrtmin = true;
+    } else if (sig == SIGRTMAX) {
+        seen_sigrtmax = true;
+    } else {
+        _exit(1);
+    }
+}
+
+int main(void)
+{
+    struct sigaction act;
+
+    memset(&act, 0, sizeof(act));
+    act.sa_handler = handle_signal;
+    assert(sigaction(SIGRTMIN, &act, NULL) == 0);
+    assert(sigaction(SIGRTMAX, &act, NULL) == 0);
+
+    assert(kill(getpid(), SIGRTMIN) == 0);
+    assert(seen_sigrtmin);
+    assert(kill(getpid(), SIGRTMAX) == 0);
+    assert(seen_sigrtmax);
+
+    return EXIT_SUCCESS;
+}
-- 
2.43.0


