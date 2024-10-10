Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE566CF07D5
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 08:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syp0z-0001nG-FE; Thu, 10 Oct 2024 04:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1syp0v-0001mx-Td
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 04:59:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1syp0t-0000lJ-R9
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 04:59:17 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A3q0Dm010535;
 Thu, 10 Oct 2024 08:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=0k/90225PfmsawXvOrc4u45sff
 LLNM+hO3b+T8MZoCE=; b=Cx/tb2IBuI6V3sN+m8220HH7fkcDWzbiIGANETpToV
 nsvJBE6dlPpjPOp20lEpuhNrGaCbj4bvFfhvjIakXSng1eWBrOk8lE4l3OCxrGdr
 ZQ41OYSlhsu1jwMLn17kkbLr1FJfC+zUjUMkUs7bY/MzT0ZloeocTOPIy+4z34lG
 eK/uJvVslBUynERLwoiW3c0pYuLv9o761rZVL+ogcLMPvT0zcS9u56WRfXZgo2qE
 NpVK8VDDEYTJIpOufg6UuCYDpwRxHnJQAuLdopiD5ZclWOfQWD/Wvis1iJhKzLdX
 5zONMRg1Fl7pMxM62lmoVbX5CE8gllkbTgq3pebgOhEw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4267cmsde9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 08:59:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49A8tGlx013833;
 Thu, 10 Oct 2024 08:59:11 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 423fsseyy6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 08:59:11 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49A8x77p53149974
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 08:59:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C4FA2004E;
 Thu, 10 Oct 2024 08:59:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A8CC20040;
 Thu, 10 Oct 2024 08:59:07 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.88.135])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 10 Oct 2024 08:59:07 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] tests/tcg: Do not use inttypes.h in multiarch/system/memory.c
Date: Thu, 10 Oct 2024 10:58:55 +0200
Message-ID: <20241010085906.226249-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zcSvPXeL6-1uo30zgKK91f6CtIHwzN-K
X-Proofpoint-GUID: zcSvPXeL6-1uo30zgKK91f6CtIHwzN-K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_05,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=964 mlxscore=0 spamscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410100056
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

make check-tcg fails on Fedora with the following error message:

    alpha-linux-gnu-gcc [...] qemu/tests/tcg/multiarch/system/memory.c -o memory [...]
    qemu/tests/tcg/multiarch/system/memory.c:17:10: fatal error: inttypes.h: No such file or directory
       17 | #include <inttypes.h>
          |          ^~~~~~~~~~~~
    compilation terminated.

The reason is that Fedora has cross-compilers, but no cross-glibc
headers. Fix by hardcoding the format specifiers and dropping the
include.

An alternative fix would be to introduce a configure check for
inttypes.h. But this would make it impossible to use Fedora
cross-compilers for softmmu tests, which used to work so far.

Fixes: ecbcc9ead2f8 ("tests/tcg: add a system test to check memory instrumentation")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/multiarch/system/memory.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tests/tcg/multiarch/system/memory.c b/tests/tcg/multiarch/system/memory.c
index 65a6038a241..7508f6b916d 100644
--- a/tests/tcg/multiarch/system/memory.c
+++ b/tests/tcg/multiarch/system/memory.c
@@ -14,7 +14,6 @@
 
 #include <stdint.h>
 #include <stdbool.h>
-#include <inttypes.h>
 #include <minilib.h>
 
 #ifndef CHECK_UNALIGNED
@@ -511,8 +510,8 @@ int main(void)
     int i;
     bool ok = true;
 
-    ml_printf("Test data start: 0x%"PRIxPTR"\n", &test_data[0]);
-    ml_printf("Test data end: 0x%"PRIxPTR"\n", &test_data[TEST_SIZE]);
+    ml_printf("Test data start: 0x%lx\n", (unsigned long)&test_data[0]);
+    ml_printf("Test data end: 0x%lx\n", (unsigned long)&test_data[TEST_SIZE]);
 
     /* Run through the unsigned tests first */
     for (i = 0; i < ARRAY_SIZE(init_ufns) && ok; i++) {
@@ -529,8 +528,8 @@ int main(void)
         ok = do_signed_reads(true);
     }
 
-    ml_printf("Test data read: %"PRId32"\n", test_read_count);
-    ml_printf("Test data write: %"PRId32"\n", test_write_count);
+    ml_printf("Test data read: %lu\n", (unsigned long)test_read_count);
+    ml_printf("Test data write: %lu\n", (unsigned long)test_write_count);
     ml_printf("Test complete: %s\n", ok ? "PASSED" : "FAILED");
     return ok ? 0 : -1;
 }
-- 
2.46.2


