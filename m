Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004A7C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFp1-0001XB-Bk; Mon, 18 Mar 2024 12:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rmFoz-0001Ww-TW; Mon, 18 Mar 2024 12:26:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rmFoy-0006Y1-DS; Mon, 18 Mar 2024 12:26:45 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42IG6mpl015864; Mon, 18 Mar 2024 16:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Rj/Dru9v1iiUhONbRa34Pe88TGw+K4f+Z5rajGHtgIY=;
 b=Fn0VvFPw6Z0S+q6t/dujfmzP+xYI1OoNR12DX3xGvvFkb+IyVZFDUZJoUp0iwcDW13qZ
 fyW9smKajQuEGsIg4IrJpf/A37gyceZZxF+DTQyr2uT6NOJqgAE6awZO6iH03guGKITb
 dTHmhbKqEhWuAewvKd5tnbl42gj42/yF4hLn0eKsx9p7cjBb8uzl0zM3oZncZZIdig+W
 O8RJ/opdDQ5jRSyETrzamsihHdapC9eg1mYuyaIrcr9jOtu9dSoQM8DcFkFYBq+biTh0
 7xSJ3n16gUs92mVfJrlNJWsBPNVPFiGpzS0ceMWF3hbiRA1PLX7aTZBjkuTmsnC+BKK3 ig== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wxqttgk2x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Mar 2024 16:26:40 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42IGPIOZ025560;
 Mon, 18 Mar 2024 16:26:40 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wxqttgk2n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Mar 2024 16:26:40 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42IG0e4a011606; Mon, 18 Mar 2024 16:26:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwq8kstwv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Mar 2024 16:26:39 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42IGQZbc39322000
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Mar 2024 16:26:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE2F120075;
 Mon, 18 Mar 2024 16:26:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6CA0720040;
 Mon, 18 Mar 2024 16:26:35 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.85.188])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 18 Mar 2024 16:26:35 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 2/2] tests/tcg/s390x: Test TEST AND SET
Date: Mon, 18 Mar 2024 17:26:06 +0100
Message-ID: <20240318162633.13017-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318162633.13017-1-iii@linux.ibm.com>
References: <20240318162633.13017-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: huPjsMf7ZMZWIOW1Kuh8r_z8WUJEiJmP
X-Proofpoint-ORIG-GUID: bliOuRkP8V7RRHDHtcr4pF1ssO8ll4iF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1011 mlxlogscore=823
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403180122
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


