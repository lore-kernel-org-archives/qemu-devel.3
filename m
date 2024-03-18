Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE9B1C54E69
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 20:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmJaA-0008Qb-JS; Mon, 18 Mar 2024 16:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rmJa8-0008QG-4L; Mon, 18 Mar 2024 16:27:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rmJa6-0001t8-3K; Mon, 18 Mar 2024 16:27:39 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42IK5tNb019408; Mon, 18 Mar 2024 20:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Rj/Dru9v1iiUhONbRa34Pe88TGw+K4f+Z5rajGHtgIY=;
 b=boyttm31MY47q+oTdMsi+ko23S8PnNtmvd8db7u3uB8RhKxhVmuffMSC35PCzcSGY/kP
 vUpCGd1lQd0uU2IRimqxNQRsESW3aEVGyw3Sxk9ugMP8T+U9eaWcGbyXKQJr+oGz7mh7
 HFiGoWJuKRce9Fo6PuUMLabsibJHwTRsOu6qPj5C+R93N38Imkn5Xzn69vAUDfQjxw5j
 Co5BUbmvD93CiKd7NLfesyu36s5cDpOP71G35ocg/5EfdjCWdyV7ynIY0dsxVUA0Jkb2
 Q0RER1iCEdmbecP3mV5O2fqDbQ2i0onCSlCddcvCh6YDIVX/ZIJeBSDLQ5P+SH//qeYH nA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wxumv8ats-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Mar 2024 20:27:32 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42IKPPx2027088;
 Mon, 18 Mar 2024 20:27:32 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wxumv8atm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Mar 2024 20:27:31 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42IJ65Lh011606; Mon, 18 Mar 2024 20:27:30 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwq8ktxr3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Mar 2024 20:27:30 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42IKRQFC51052878
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Mar 2024 20:27:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8AD1120043;
 Mon, 18 Mar 2024 20:27:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F1C620040;
 Mon, 18 Mar 2024 20:27:26 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.85.188])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 18 Mar 2024 20:27:26 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 2/2] tests/tcg/s390x: Test TEST AND SET
Date: Mon, 18 Mar 2024 21:27:11 +0100
Message-ID: <20240318202722.20675-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318202722.20675-1-iii@linux.ibm.com>
References: <20240318202722.20675-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9t2YczurIOe1cxO-060KKug2PW33ZH8M
X-Proofpoint-ORIG-GUID: f_klG75pEUpjqSkbC4KffVKzACR38t1S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 mlxlogscore=823 mlxscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403180155
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Add a small test to prevent regressions.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/s390x/Makefile.target |  1 +
 tests/tcg/s390x/ts.c            | 35 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 tests/tcg/s390x/ts.c

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index e2aba2ec274..a8f86c94498 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -47,6 +47,7 @@ TESTS+=add-logical-with-carry
 TESTS+=lae
 TESTS+=cvd
 TESTS+=cvb
+TESTS+=ts
 
 cdsg: CFLAGS+=-pthread
 cdsg: LDFLAGS+=-pthread
diff --git a/tests/tcg/s390x/ts.c b/tests/tcg/s390x/ts.c
new file mode 100644
index 00000000000..441faf30d98
--- /dev/null
+++ b/tests/tcg/s390x/ts.c
@@ -0,0 +1,35 @@
+/*
+ * Test the TEST AND SET instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdlib.h>
+
+static int ts(char *p)
+{
+    int cc;
+
+    asm("ts %[p]\n"
+        "ipm %[cc]"
+        : [cc] "=r" (cc)
+        , [p] "+Q" (*p)
+        : : "cc");
+
+    return (cc >> 28) & 3;
+}
+
+int main(void)
+{
+    char c;
+
+    c = 0x80;
+    assert(ts(&c) == 1);
+    assert(c == 0xff);
+
+    c = 0x7f;
+    assert(ts(&c) == 0);
+    assert(c == 0xff);
+
+    return EXIT_SUCCESS;
+}
-- 
2.44.0


