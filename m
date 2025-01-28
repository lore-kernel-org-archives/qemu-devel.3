Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261D2C02188
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 00:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcZEl-0003PE-EG; Mon, 27 Jan 2025 19:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1tcZEj-0003On-Jv; Mon, 27 Jan 2025 19:13:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1tcZEh-0006Il-QU; Mon, 27 Jan 2025 19:13:49 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RLIT9f009912;
 Tue, 28 Jan 2025 00:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=iE2QPbXBHPnJLR/Ve
 anUbCPNMxTxeG+WbsXSBXVqRxU=; b=UdcKiv5850/9X2SsnXY+oxpdAUXb1v2sx
 Iqinxph6toLtQzVM5YsTVG2TlhukIHB5KKqv1VFRxtvIw3NSY6UqRh27HlEvBlFH
 vAYdGKq/RSc+UgtxVOR/8l3yrHjZvM1pjI19f/oSgezv8p3T7c/3AiXNynqMdeQS
 YfbJ8trUyCr5ZaS4gHDHhq/1tbVyq16zvKpTTl80Y1wZhmRQArvrf+Zox9pYG5RR
 l53QRGd4L6GEtYtsL/BVfwBdoZHjcwKjHPlpq9vJ1AJoLlNs/N1DBVhw11Y8CuB7
 jEveBcanxMJRpB23uc6gl6ZryNukAMrbsDOPOh16ScDr54VuscjBQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ecdyabwt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 00:13:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50RM0ZSD018886;
 Tue, 28 Jan 2025 00:13:42 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44dd018b9u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 00:13:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50S0DfTE35783214
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jan 2025 00:13:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 223D52016F;
 Tue, 28 Jan 2025 00:13:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CAED520171;
 Tue, 28 Jan 2025 00:13:40 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.23.68])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Jan 2025 00:13:40 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 2/2] tests/tcg/s390x: Test modifying code using the MVC
 instruction
Date: Tue, 28 Jan 2025 01:12:43 +0100
Message-ID: <20250128001338.11474-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250128001338.11474-1-iii@linux.ibm.com>
References: <20250128001338.11474-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: X2D8XIpzxHe3yFdtvYMlhIQhU91i5W09
X-Proofpoint-ORIG-GUID: X2D8XIpzxHe3yFdtvYMlhIQhU91i5W09
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_11,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270188
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
 tests/tcg/s390x/Makefile.softmmu-target |  1 +
 tests/tcg/s390x/mvc-smc.c               | 82 +++++++++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100644 tests/tcg/s390x/mvc-smc.c

diff --git a/tests/tcg/s390x/Makefile.softmmu-target b/tests/tcg/s390x/Makefile.softmmu-target
index 7adde2fa087..8cd4667c63b 100644
--- a/tests/tcg/s390x/Makefile.softmmu-target
+++ b/tests/tcg/s390x/Makefile.softmmu-target
@@ -42,6 +42,7 @@ $(ASM_TESTS): LDFLAGS += -Wl,-T$(LINK_SCRIPT) -Wl,--build-id=none
 $(ASM_TESTS): $(LINK_SCRIPT)
 TESTS += $(ASM_TESTS)
 
+MULTIARCH_TESTS += mvc-smc
 S390X_MULTIARCH_RUNTIME_OBJS = head64.o console.o $(MINILIB_OBJS)
 $(MULTIARCH_TESTS): $(S390X_MULTIARCH_RUNTIME_OBJS)
 $(MULTIARCH_TESTS): LDFLAGS += $(S390X_MULTIARCH_RUNTIME_OBJS)
diff --git a/tests/tcg/s390x/mvc-smc.c b/tests/tcg/s390x/mvc-smc.c
new file mode 100644
index 00000000000..d68f60caa85
--- /dev/null
+++ b/tests/tcg/s390x/mvc-smc.c
@@ -0,0 +1,82 @@
+/*
+ * Test modifying code using the MVC instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <minilib.h>
+
+#define PAGE_SIZE 4096
+#define BR_14_SIZE 2
+#define RWX_OFFSET 2
+
+static unsigned char rw[PAGE_SIZE + BR_14_SIZE];
+static unsigned char rwx[RWX_OFFSET + sizeof(rw)]
+    __attribute__((aligned(PAGE_SIZE)));
+
+typedef unsigned long (*function_t)(unsigned long);
+
+static int emit_function(unsigned char *p, int n)
+{
+    int i = 0, val = 0;
+
+    while (i < n - 2) {
+        /* aghi %r2,1 */
+        p[i++] = 0xa7;
+        p[i++] = 0x2b;
+        p[i++] = 0x00;
+        p[i++] = 0x01;
+        val++;
+    }
+
+    /* br %r14 */
+    p[i++] = 0x07;
+    p[i++] = 0xfe;
+
+    return val;
+}
+
+static void memcpy_mvc(void *dest, void *src, unsigned long n)
+{
+    while (n >= 256) {
+        asm("mvc 0(256,%[dest]),0(%[src])"
+            :
+            : [dest] "a" (dest)
+            , [src] "a" (src)
+            : "memory");
+        dest += 256;
+        src += 256;
+        n -= 256;
+    }
+    asm("exrl %[n],0f\n"
+        "j 1f\n"
+        "0: mvc 0(1,%[dest]),0(%[src])\n"
+        "1:"
+        :
+        : [dest] "a" (dest)
+        , [src] "a" (src)
+        , [n] "a" (n)
+        : "memory");
+}
+
+int main(void)
+{
+    int expected, size;
+
+    /* Create a TB. */
+    size = sizeof(rwx) - RWX_OFFSET - 4;
+    expected = emit_function(rwx + RWX_OFFSET, size);
+    if (((function_t)(rwx + RWX_OFFSET))(0) != expected) {
+        return 1;
+    }
+
+    /* Overwrite the TB. */
+    size += 4;
+    expected = emit_function(rw, size);
+    memcpy_mvc(rwx + RWX_OFFSET, rw, size);
+    if (((function_t)(rwx + RWX_OFFSET))(0) != expected) {
+        return 2;
+    }
+
+    return 0;
+}
-- 
2.48.1


