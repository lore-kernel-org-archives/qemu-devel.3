Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7BDC47DB3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 23:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVJim-0007AV-TT; Wed, 31 Jan 2024 18:10:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rVJiQ-00076b-C7; Wed, 31 Jan 2024 18:10:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rVJiO-0000Kx-OZ; Wed, 31 Jan 2024 18:09:58 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40VMILbQ006744; Wed, 31 Jan 2024 23:09:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=2QPGWHq4+h1+zRL0qablFV0HHBXadUmRLKNwT+Njx+U=;
 b=SsbSNzH4+swbt44drKDIYXrVyYFUI4v/TkduLsgR4+y+gtRgqVPAfMTwF0Z6WwxlaN0h
 JKrSm3vob81PyuU7r7e14rLMzKHwDK+wRsvUuDhMlLPqNkN7XweXeYApYzShcgXF37z/
 2WsUvkXaaF8e+chJYTWIMSzH4N4iMvEAXNOyWhGesCOXRLJ7EDqrkDy8kXwvoq0XBwS8
 OrVFS0beXHRZ9TDuK1bECRJjKhiAt/A4NtPKFQvzHeLMoxRBihIGgr76m+MCeUo0j9EV
 wgcjdI7vBMjl5Sc0eNO/jUIHOFtRJwLmX7L+7BpuLxJrlub5je6+9oWnr6Oi9HKx2Uiw KQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vyxvq8yhu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 23:09:53 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40VMIMYw006789;
 Wed, 31 Jan 2024 23:09:53 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vyxvq8yhr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 23:09:53 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40VLBspg010535; Wed, 31 Jan 2024 23:09:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwd5p0e4y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 23:09:52 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40VN9ovX15139428
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jan 2024 23:09:50 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 981EF20043;
 Wed, 31 Jan 2024 23:09:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A24120040;
 Wed, 31 Jan 2024 23:09:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.74.74])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 31 Jan 2024 23:09:50 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Subject: [PATCH v3 4/4] tests/tcg/s390x: Test CONVERT TO BINARY
Date: Thu,  1 Feb 2024 00:07:13 +0100
Message-ID: <20240131230938.325919-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131230938.325919-1-iii@linux.ibm.com>
References: <20240131230938.325919-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: muIeQsakNJlalcv1Y9XQOvaqAPRkF9_x
X-Proofpoint-ORIG-GUID: m47RkaQjCvDSq8iHvOHJzWJW6b6xpeMK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=785
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310178
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

Check the CVB's and CVBG's corner cases.

Co-developed-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/s390x/Makefile.target |  1 +
 tests/tcg/s390x/cvb.c           | 47 +++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)
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
index 00000000000..47b7a7965f4
--- /dev/null
+++ b/tests/tcg/s390x/cvb.c
@@ -0,0 +1,47 @@
+/*
+ * Test the CONVERT TO DECIMAL instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdint.h>
+#include <stdlib.h>
+
+static int32_t cvb(uint64_t x)
+{
+    uint32_t ret;
+
+    asm("cvb %[ret],%[x]" : [ret] "=r" (ret) : [x] "R" (x));
+
+    return ret;
+}
+
+static int64_t cvbg(__uint128_t x)
+{
+    int64_t ret;
+
+    asm("cvbg %[ret],%[x]" : [ret] "=r" (ret) : [x] "T" (x));
+
+    return ret;
+}
+
+int main(void)
+{
+    __uint128_t m = (((__uint128_t)0x9223372036854775) << 16) | 0x8070;
+
+    assert(cvb(0xc) == 0);
+    assert(cvb(0x1c) == 1);
+    assert(cvb(0x25594c) == 25594);
+    assert(cvb(0x1d) == -1);
+    assert(cvb(0x2147483647c) == 0x7fffffff);
+    assert(cvb(0x2147483647d) == -0x7fffffff);
+
+    assert(cvbg(0xc) == 0);
+    assert(cvbg(0x1c) == 1);
+    assert(cvbg(0x25594c) == 25594);
+    assert(cvbg(0x1d) == -1);
+    assert(cvbg(m | 0xc) == 0x7fffffffffffffff);
+    assert(cvbg(m | 0xd) == -0x7fffffffffffffff);
+
+    return EXIT_SUCCESS;
+}
-- 
2.43.0


