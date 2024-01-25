Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0796C48285
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 12:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSyt3-0003PL-Uv; Thu, 25 Jan 2024 07:31:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rSysz-0003Lh-FG; Thu, 25 Jan 2024 07:31:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rSysw-0001zb-00; Thu, 25 Jan 2024 07:31:12 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40PARIlN023271; Thu, 25 Jan 2024 12:31:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=MNJbKLRgVm6p0ufGIlf3XdiOukS2mJluK/nZRqsgIQs=;
 b=tMbh8PxDPuCM6zJ3iWy1xeAUXNUDDjvAY1BPYQxJuLA5z+62es3UUpt66U4gtfKeu8+M
 DIhGULKV9uD4QDgPfhUorg+t/iMqwpEuVoaKwGCtb8po2BIVkAiwpx88UgiurYxyzq1T
 24Y6ss3BFszO1bfc+Ej/W0TFxjNt/hh5nfx2NJCGl60kEJUTiL0Kzy4kG2HQ3oN+e4ML
 b8mAWMV2RlnOy8jz3XInkab1kph6cWhX4SUhCCT0ta+yVTbXJA/OJB9oM6dQ3UaAVNn9
 mtOZCcIROWARbNADSGxgHPxK7UbJJgsJ0uCahrjD/r5JNDnFd4V35sWwTGDCAUFwICjM +g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vunwc351t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jan 2024 12:31:07 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40PBgdQR027067;
 Thu, 25 Jan 2024 12:31:07 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vunwc351j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jan 2024 12:31:07 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40PCSfuc025653; Thu, 25 Jan 2024 12:31:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vrsgpcaf5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jan 2024 12:31:06 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40PCV40D7602826
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jan 2024 12:31:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A114520043;
 Thu, 25 Jan 2024 12:31:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7437F20040;
 Thu, 25 Jan 2024 12:31:04 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Jan 2024 12:31:04 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 2/2] tests/tcg/s390x: Test CONVERT TO DECIMAL
Date: Thu, 25 Jan 2024 13:29:45 +0100
Message-ID: <20240125123059.220131-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125123059.220131-1-iii@linux.ibm.com>
References: <20240125123059.220131-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FFJR3QrEpnHnFiUl2X5-ZTzQXPmieG_9
X-Proofpoint-GUID: zgYA0CM0EruDKIof-m7CAJNStQikZqrI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_06,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=811 spamscore=0
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401250086
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

Check the CVD's and CVDG's corner cases.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/s390x/Makefile.target |  1 +
 tests/tcg/s390x/cvd.c           | 42 +++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)
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
index 00000000000..4d12282c6aa
--- /dev/null
+++ b/tests/tcg/s390x/cvd.c
@@ -0,0 +1,42 @@
+/*
+ * Test the CONVERT TO DECIMAL instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdint.h>
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
+    assert(cvd(-1) == 0x1d);
+    assert(cvd(0x7fffffff) == 0x2147483647c);
+    assert(cvd(-0x7fffffff) == 0x2147483647d);
+
+    assert(cvdg(0) == 0xc);
+    assert(cvdg(1) == 0x1c);
+    assert(cvdg(-1) == 0x1d);
+    assert(cvdg(0x7fffffffffffffff) == (m | 0xc));
+    assert(cvdg(-0x7fffffffffffffff) == (m | 0xd));
+}
-- 
2.43.0


