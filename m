Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04ABEC48298
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 20:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX639-0007S2-RU; Mon, 05 Feb 2024 15:58:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rX638-0007Qa-5E; Mon, 05 Feb 2024 15:58:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rX636-00038Q-HC; Mon, 05 Feb 2024 15:58:41 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 415KwEGW013294; Mon, 5 Feb 2024 20:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=um2qKXc2MSorld9t564Pujtj6Or0bFx9IPMySrXmbKc=;
 b=rmTDmOUY31S6hxAPIVlwqQCWWaCKs9OmhzXbLn/cwYqwnRrzbbsLdwxRM0AZTClb8Z4d
 K1vn+pQi/NCrCYo2BWX/d9BEjOusD0dJ94IRkpcCoYlsML7GRbeJHgF+ZX6FYTHl6bfV
 zm1/jjspxPWxu5RYr1TIYDHvZ5Qj9bxBw9N/qQW47V0KBLXpF7XHz//DCzlu6+M8RGXc
 QOd8lYDgxTFd948zZOhoDfPRyt9swwYXS+zF+e8gaXvPe7BIfQrCgpQbUCtpvLjat/hJ
 zYb30ebdOLKlJ2Y7r0KN1sGnld8ABlbB/7qT3n/Ke5BDWHc6As25GkuZqlwg3EG7E4qS 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w3764g0c4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 20:58:37 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 415KwbQ6014211;
 Mon, 5 Feb 2024 20:58:37 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w3764g0br-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 20:58:37 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 415IjjT9020371; Mon, 5 Feb 2024 20:58:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w1ytsu4sy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 20:58:36 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 415KwYuO20185772
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Feb 2024 20:58:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 893282004B;
 Mon,  5 Feb 2024 20:58:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 264E120043;
 Mon,  5 Feb 2024 20:58:34 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.57.170])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Feb 2024 20:58:34 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v5 3/4] tests/tcg/s390x: Test CONVERT TO DECIMAL
Date: Mon,  5 Feb 2024 21:54:55 +0100
Message-ID: <20240205205830.6425-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205205830.6425-1-iii@linux.ibm.com>
References: <20240205205830.6425-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _iepIo7I7CL2FolEVQsewBPuKa-J1-Ts
X-Proofpoint-ORIG-GUID: kXzlIhH-JuCaMADLvb9G3vzWYmvUaU9U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_14,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 mlxlogscore=824
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402050157
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

Check the CVD's, CVDY's, and CVDG's corner cases.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/s390x/Makefile.target |  1 +
 tests/tcg/s390x/cvd.c           | 63 +++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 tests/tcg/s390x/cvd.c

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 30994dcf9c2..04e4bddd83d 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -45,6 +45,7 @@ TESTS+=clc
 TESTS+=laalg
 TESTS+=add-logical-with-carry
 TESTS+=lae
+TESTS+=cvd
 
 cdsg: CFLAGS+=-pthread
 cdsg: LDFLAGS+=-pthread
diff --git a/tests/tcg/s390x/cvd.c b/tests/tcg/s390x/cvd.c
new file mode 100644
index 00000000000..d776688985e
--- /dev/null
+++ b/tests/tcg/s390x/cvd.c
@@ -0,0 +1,63 @@
+/*
+ * Test the CONVERT TO DECIMAL instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdint.h>
+#include <stdlib.h>
+
+static uint64_t cvd(int32_t x)
+{
+    uint64_t ret;
+
+    asm("cvd %[x],%[ret]" : [ret] "=R" (ret) : [x] "r" (x));
+
+    return ret;
+}
+
+static uint64_t cvdy(int32_t x)
+{
+    uint64_t ret;
+
+    asm("cvdy %[x],%[ret]" : [ret] "=T" (ret) : [x] "r" (x));
+
+    return ret;
+}
+
+static __uint128_t cvdg(int64_t x)
+{
+    __uint128_t ret;
+
+    asm("cvdg %[x],%[ret]" : [ret] "=T" (ret) : [x] "r" (x));
+
+    return ret;
+}
+
+int main(void)
+{
+    __uint128_t m = (((__uint128_t)0x9223372036854775) << 16) | 0x8070;
+
+    assert(cvd(0) == 0xc);
+    assert(cvd(1) == 0x1c);
+    assert(cvd(25594) == 0x25594c);
+    assert(cvd(-1) == 0x1d);
+    assert(cvd(0x7fffffff) == 0x2147483647c);
+    assert(cvd(-0x80000000) == 0x2147483648d);
+
+    assert(cvdy(0) == 0xc);
+    assert(cvdy(1) == 0x1c);
+    assert(cvdy(25594) == 0x25594c);
+    assert(cvdy(-1) == 0x1d);
+    assert(cvdy(0x7fffffff) == 0x2147483647c);
+    assert(cvdy(-0x80000000) == 0x2147483648d);
+
+    assert(cvdg(0) == 0xc);
+    assert(cvdg(1) == 0x1c);
+    assert(cvdg(25594) == 0x25594c);
+    assert(cvdg(-1) == 0x1d);
+    assert(cvdg(0x7fffffffffffffff) == (m + 0xc));
+    assert(cvdg(-0x8000000000000000) == (m + 0x1d));
+
+    return EXIT_SUCCESS;
+}
-- 
2.43.0


