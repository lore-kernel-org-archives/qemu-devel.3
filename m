Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E76C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 14:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVuIT-0007lU-Dw; Fri, 02 Feb 2024 09:13:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rVuIQ-0007ky-TJ; Fri, 02 Feb 2024 09:13:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rVuIO-00048a-No; Fri, 02 Feb 2024 09:13:34 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 412Dqe9C026143; Fri, 2 Feb 2024 14:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fAScaTNRMCZarWKXn2J2iMtXgXaYIfZjQ8qJiL/ahYY=;
 b=I8yYEOAiqxnWRZL5TW3SydgZz6FqSiDheMAS5xdXSNOlgeYQy3vAwutTTjIOBG4bsPMS
 UNXgsJqL9WBY2Z072tLs/Sbf0m1zhmdsrKd7Pjxk3F2kdNTyO9yZh6gOexHW0Jcq//0n
 0A8+iNAFU637lWqOfSuzYKdwYto+npjSltc9iuzcLJi4cWlFg1q/RGG9yoj9qUOCaBLg
 6LCux+Gucj8iZ7HXkYM59DlS5sSyhpP7riaUgBYHUc1eHRc4mK+ZAY1EBiQChbfEmAw4
 RqJOj0mer23sJoGxNgORK3+32vK/Hvthue7/MLczE9kxOhesTuoY0/wG7z/NkMokKfll Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w11ng0jt7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Feb 2024 14:13:28 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 412Dr6aN027608;
 Fri, 2 Feb 2024 14:13:28 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w11ng0jsp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Feb 2024 14:13:27 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 412BaP4X002223; Fri, 2 Feb 2024 14:13:27 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwc5tuyd7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Feb 2024 14:13:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 412EDPwA14549642
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Feb 2024 14:13:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 12A7B20043;
 Fri,  2 Feb 2024 14:13:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D9DD720040;
 Fri,  2 Feb 2024 14:13:24 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Feb 2024 14:13:24 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Subject: [PATCH v4 4/4] tests/tcg/s390x: Test CONVERT TO BINARY
Date: Fri,  2 Feb 2024 15:12:00 +0100
Message-ID: <20240202141318.95962-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202141318.95962-1-iii@linux.ibm.com>
References: <20240202141318.95962-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eCmjBOpOqXv3n3xdx9856kkdkPpBO6xv
X-Proofpoint-ORIG-GUID: 6O-T1QDB-wMfa-a1nmCEy94nAFviShlJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0
 clxscore=1015 mlxlogscore=723 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402020104
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

Check the CVB's, CVBY's, and CVBG's corner cases.

Co-developed-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/s390x/Makefile.target |   1 +
 tests/tcg/s390x/cvb.c           | 102 ++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)
 create mode 100644 tests/tcg/s390x/cvb.c

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 04e4bddd83d..e2aba2ec274 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -46,6 +46,7 @@ TESTS+=laalg
 TESTS+=add-logical-with-carry
 TESTS+=lae
 TESTS+=cvd
+TESTS+=cvb
 
 cdsg: CFLAGS+=-pthread
 cdsg: LDFLAGS+=-pthread
diff --git a/tests/tcg/s390x/cvb.c b/tests/tcg/s390x/cvb.c
new file mode 100644
index 00000000000..e1735f6b81c
--- /dev/null
+++ b/tests/tcg/s390x/cvb.c
@@ -0,0 +1,102 @@
+/*
+ * Test the CONVERT TO BINARY instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <signal.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+
+static int signum;
+
+static void signal_handler(int n)
+{
+    signum = n;
+}
+
+#define FAIL 0x1234567887654321
+#define OK32(x) (0x1234567800000000 | (uint32_t)(x))
+
+static int64_t cvb(uint64_t x)
+{
+    int64_t ret = FAIL;
+
+    signum = -1;
+    asm("cvb %[ret],%[x]" : [ret] "+r" (ret) : [x] "R" (x));
+
+    return ret;
+}
+
+static int64_t cvby(uint64_t x)
+{
+    int64_t ret = FAIL;
+
+    signum = -1;
+    asm("cvby %[ret],%[x]" : [ret] "+r" (ret) : [x] "T" (x));
+
+    return ret;
+}
+
+static int64_t cvbg(__uint128_t x)
+{
+    int64_t ret = FAIL;
+
+    signum = -1;
+    asm("cvbg %[ret],%[x]" : [ret] "+r" (ret) : [x] "T" (x));
+
+    return ret;
+}
+
+int main(void)
+{
+    __uint128_t m = (((__uint128_t)0x9223372036854775) << 16) | 0x8070;
+    struct sigaction act;
+    int err;
+
+    memset(&act, 0, sizeof(act));
+    act.sa_handler = signal_handler;
+    err = sigaction(SIGFPE, &act, NULL);
+    assert(err == 0);
+    err = sigaction(SIGILL, &act, NULL);
+    assert(err == 0);
+
+    assert(cvb(0xc) == OK32(0) && signum == -1);
+    assert(cvb(0x1c) == OK32(1) && signum == -1);
+    assert(cvb(0x25594c) == OK32(25594) && signum == -1);
+    assert(cvb(0x1d) == OK32(-1) && signum == -1);
+    assert(cvb(0x2147483647c) == OK32(0x7fffffff) && signum == -1);
+    assert(cvb(0x2147483648d) == OK32(-0x80000000) && signum == -1);
+    assert(cvb(0x7) == FAIL && signum == SIGILL);
+    assert(cvb(0x2147483648c) == OK32(0x80000000) && signum == SIGFPE);
+    assert(cvb(0x3000000000c) == OK32(0xb2d05e00) && signum == SIGFPE);
+    assert(cvb(0x2147483649d) == OK32(0x7fffffff) && signum == SIGFPE);
+    assert(cvb(0x3000000000d) == OK32(0x4d2fa200) && signum == SIGFPE);
+
+    assert(cvby(0xc) == OK32(0));
+    assert(cvby(0x1c) == OK32(1));
+    assert(cvby(0x25594c) == OK32(25594));
+    assert(cvby(0x1d) == OK32(-1));
+    assert(cvby(0x2147483647c) == OK32(0x7fffffff));
+    assert(cvby(0x2147483648d) == OK32(-0x80000000));
+    assert(cvby(0x7) == FAIL && signum == SIGILL);
+    assert(cvby(0x2147483648c) == OK32(0x80000000) && signum == SIGFPE);
+    assert(cvby(0x3000000000c) == OK32(0xb2d05e00) && signum == SIGFPE);
+    assert(cvby(0x2147483649d) == OK32(0x7fffffff) && signum == SIGFPE);
+    assert(cvby(0x3000000000d) == OK32(0x4d2fa200) && signum == SIGFPE);
+
+    assert(cvbg(0xc) == 0);
+    assert(cvbg(0x1c) == 1);
+    assert(cvbg(0x25594c) == 25594);
+    assert(cvbg(0x1d) == -1);
+    assert(cvbg(m + 0xc) == 0x7fffffffffffffff);
+    assert(cvbg(m + 0x1d) == -0x8000000000000000);
+    assert(cvbg(0x7) == FAIL && signum == SIGILL);
+    assert(cvbg(m + 0x1c) == FAIL && signum == SIGFPE);
+    assert(cvbg(m + 0x2d) == FAIL && signum == SIGFPE);
+    assert(cvbg(((__uint128_t)1 << 80) + 0xc) == FAIL && signum == SIGFPE);
+    assert(cvbg(((__uint128_t)1 << 80) + 0xd) == FAIL && signum == SIGFPE);
+
+    return EXIT_SUCCESS;
+}
-- 
2.43.0


