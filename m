Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FA5CEACDC
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sveJL-0000zi-Fo; Tue, 01 Oct 2024 10:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1sveJE-0000yu-8N; Tue, 01 Oct 2024 10:57:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1sveJ7-0007CJ-2I; Tue, 01 Oct 2024 10:57:00 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4917K4BR007343;
 Tue, 1 Oct 2024 14:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=rYxRlyCjh93bOX7MimlaXgYcND
 R8YrYmDIx/1ZAhFIQ=; b=rFrEaZEdDB0KJV0qO/pNnwuIbBX6g1YsmiGQ7XFnKC
 WaKdQjuU+vhzul4B1YkOn2impCgxqpLtiVFFbI8M2QFhxv3AxYAuCt6XT5Bjtdf9
 +bQXXBA4eqOJ9OcnEbfjvopOqOcj9PHtt7pwmKLm4uITvH4ehklnbEQ1nU+4G7Gf
 JTTQrnpOHMGivJ5oyTPt1O6wPxdIfSKYedIW3zgGxWdT/9AA5YoKyUyxd/eCpV1k
 zFDZWMU0Il0p09cBUbRuL0XsCo1SvulzG1SZprC7TLqGQbjhDFe5X/JvJ1SS/GTZ
 bqA2Qadlr8+uMPgEadK79wzM3+0Zn3h2727VrHqRdm7g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420ckjafch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 14:56:42 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 491Eufw7020003;
 Tue, 1 Oct 2024 14:56:41 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420ckjafc7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 14:56:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 491COoBu018356;
 Tue, 1 Oct 2024 14:56:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xw4mw232-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 14:56:40 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 491Eucjk53936560
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2024 14:56:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54DF72004B;
 Tue,  1 Oct 2024 14:56:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F36F320043;
 Tue,  1 Oct 2024 14:56:37 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.29.119])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2024 14:56:37 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] tests/tcg/s390x: Test modifying an EXECUTE target
Date: Tue,  1 Oct 2024 16:56:18 +0200
Message-ID: <20241001145634.9786-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qmFvQZ5PftcKYyAgRbDwt6_ha2UDliIB
X-Proofpoint-GUID: fFA5PWhhDIfP108BxttKX7juttj4siBy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_11,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 mlxlogscore=901 suspectscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410010096
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

QEMU correctly implements the tracking of EXECUTE target modifications
by storing the instruction text in env->ex_value and tb->cs_base, the
latter of which is used for lookups.

Still, EXECUTE is a tricky corner of the s390x emulation, which can
benefit from having a regression test.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/s390x/Makefile.target |  1 +
 tests/tcg/s390x/ex-smc.c        | 57 +++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 tests/tcg/s390x/ex-smc.c

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index a8f86c94498..2dab4f45822 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -48,6 +48,7 @@ TESTS+=lae
 TESTS+=cvd
 TESTS+=cvb
 TESTS+=ts
+TESTS+=ex-smc
 
 cdsg: CFLAGS+=-pthread
 cdsg: LDFLAGS+=-pthread
diff --git a/tests/tcg/s390x/ex-smc.c b/tests/tcg/s390x/ex-smc.c
new file mode 100644
index 00000000000..f403640d6ba
--- /dev/null
+++ b/tests/tcg/s390x/ex-smc.c
@@ -0,0 +1,57 @@
+/*
+ * Test modifying an EXECUTE target.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdlib.h>
+
+/* Make sure we exercise the same EXECUTE instruction. */
+extern void execute(unsigned char *insn, unsigned char mask,
+                    unsigned long *r1_r5);
+asm(".globl execute\n"
+    "execute:\n"
+    "lg %r1,0(%r4)\n"
+    "lg %r5,8(%r4)\n"
+    "ex %r3,0(%r2)\n"
+    "stg %r5,8(%r4)\n"
+    "stg %r1,0(%r4)\n"
+    "br %r14\n");
+
+/* Define an RWX EXECUTE target. */
+extern unsigned char lgfi[];
+asm(".pushsection .rwx,\"awx\",@progbits\n"
+    ".globl lgfi\n"
+    "lgfi: lgfi %r0,0\n"
+    ".popsection\n");
+
+int main(void)
+{
+    unsigned long r1_r5[2];
+
+    /* Create an initial TB. */
+    r1_r5[0] = -1;
+    r1_r5[1] = -1;
+    execute(lgfi, 1 << 4, r1_r5);
+    assert(r1_r5[0] == 0);
+    assert(r1_r5[1] == -1);
+
+    /* Test changing the mask. */
+    execute(lgfi, 5 << 4, r1_r5);
+    assert(r1_r5[0] == 0);
+    assert(r1_r5[1] == 0);
+
+    /* Test changing the target. */
+    lgfi[5] = 42;
+    execute(lgfi, 5 << 4, r1_r5);
+    assert(r1_r5[0] == 0);
+    assert(r1_r5[1] == 42);
+
+    /* Test changing both the mask and the target. */
+    lgfi[5] = 24;
+    execute(lgfi, 1 << 4, r1_r5);
+    assert(r1_r5[0] == 24);
+    assert(r1_r5[1] == 42);
+
+    return EXIT_SUCCESS;
+}
-- 
2.46.2


