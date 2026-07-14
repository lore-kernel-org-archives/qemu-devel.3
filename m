Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818BEC44507
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 20:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjjno-0006mz-Fm; Tue, 14 Jul 2026 16:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjjnm-0006m3-9e; Tue, 14 Jul 2026 16:32:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjjnk-00055O-Ms; Tue, 14 Jul 2026 16:32:26 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EJBxfJ2199128; Tue, 14 Jul 2026 20:32:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=pRFgcf6db+x2w9ggR
 JU0I/2CFKOvcgW5RxyIWYFF6QU=; b=bvbkbuu4dlN33PL8fykvvNWDvtEjY+ALs
 caVhYMka8C092So95IGk4T1slrtTeHWkBC2Txf1yKaUgQZlW8b95FztAI7aJXVXX
 vS/RSVCT0hI32V3tYguombRFXe3/23q+wCcZGMJIEUEFOMFEDhT/wffPUFtMUNBt
 7YODVOcGzlJPm9Zxj+8kolslofO2SbCbb6uo6iOuKTDdiDTIr99g1TorHAfK46Uf
 Iw4iwMeZ2RuBCdbIt3a7hj/7sX2y5/rE/orCq+DnDAMWubyKmr1WXpkufdB77zhE
 /bOdBGAHjrgh8/8DKXJdqU5sR7eXTDYfpz7Tzohis0plxHOGgA1Sw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxg72c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 20:32:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EKJalr029930;
 Tue, 14 Jul 2026 20:32:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uy4amp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 20:32:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66EKWDwn43778328
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 20:32:13 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F41320043;
 Tue, 14 Jul 2026 20:32:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3DCB520078;
 Tue, 14 Jul 2026 20:32:12 +0000 (GMT)
Received: from li-d2cd37cc-2ca3-11b2-a85c-84ed3706e5a0.ibm.com (unknown
 [9.111.27.233]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 20:32:12 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 2/2] tests/tcg/s390x: Test STCKF condition code on a
 faulting store
Date: Tue, 14 Jul 2026 22:29:55 +0200
Message-ID: <20260714203206.363028-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714203206.363028-1-iii@linux.ibm.com>
References: <20260714203206.363028-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6G-e9HOHIk3SGkGb9O_F2Gx6J-32PjuS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDIwOCBTYWx0ZWRfX3/6ckuKITi/U
 AtXWm/3C26SWXvJ2rVmUx0u7GqraFcj5IVVloK4zOlWDcAj6pHFSxDQbr/1exb1TZE1i05mOt2b
 MewHZBe7hVyLWQ8uaMzwJPH24qH+b4E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDIwOCBTYWx0ZWRfX5bAVDipzYiuP
 B1tQAfTFU9BewDHO+yKs/bmjPxZxJSDxSSYvTS3gzV3JJvqV/m0vEwsj4I0S2/3HcoFlYOf82z/
 lJ81QkbM9OuqbPCTx2yvWzDfG4a00Sp64lTXBQ2D/CjCRVEexabSLeWggOYvShcm+nY4dIl4MH0
 BLgRChMON6u9/MHAT8ynjRrQHABJvmbycHU2CFLNBrS0eFuVEUUJhqaYvpcI79xmA2V4P8V+8Kb
 q5HpiunYbakmdyEMQQSrmzR5E5ZTDRTXdZ4JC24R6C+WSGiTxnxK87EzX2AP5N6nP0UmKkWFzJY
 y5QwDN9Sbkre9WXAsDOvxRnPbY2yBi/hYPzQZ8Ks1vOS7WvZMRiPpxhsvYF5OhEFKNflTJCNFuh
 jtFWM2JBg0Sfhw2fnGQNJMOKPCsEkFbp9Db3sHgs+F66RBxN/y9I9I0hrb1OwipOZE0HYahwHHh
 v3v3nvwjbyPTUba1VPg==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a569cd4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=voN85A6LZXnEbzZ90_0A:9
X-Proofpoint-ORIG-GUID: 6G-e9HOHIk3SGkGb9O_F2Gx6J-32PjuS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_05,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140208
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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
 tests/tcg/s390x/stckf.c         | 44 +++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 tests/tcg/s390x/stckf.c

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 0ca030ded01..6a5bf8b7813 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -50,6 +50,7 @@ TESTS+=cvb
 TESTS+=ts
 TESTS+=ex-smc
 TESTS+=divide-to-integer
+TESTS+=stckf
 
 cdsg: CFLAGS+=-pthread
 cdsg: LDFLAGS+=-pthread
diff --git a/tests/tcg/s390x/stckf.c b/tests/tcg/s390x/stckf.c
new file mode 100644
index 00000000000..51c8c9df9f8
--- /dev/null
+++ b/tests/tcg/s390x/stckf.c
@@ -0,0 +1,44 @@
+/*
+ * Test that a faulting STORE CLOCK FAST does not clobber the condition code.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+static void handle_sigsegv(int sig, siginfo_t *info, void *ucontext)
+{
+    mcontext_t *mcontext = &((ucontext_t *)ucontext)->uc_mcontext;
+
+    /* The condition code must be the one set by SLGR, not garbage. */
+    _exit(((mcontext->psw.mask >> 44) & 3) == 3 ? EXIT_SUCCESS : EXIT_FAILURE);
+}
+
+int main(void)
+{
+    struct sigaction act = {
+        .sa_sigaction = handle_sigsegv,
+        .sa_flags = SA_SIGINFO,
+    };
+    int err;
+
+    err = sigaction(SIGSEGV, &act, NULL);
+    assert(err == 0);
+
+    asm volatile(
+        "lghi %%r1,100\n"
+        "lghi %%r2,0\n"
+        "clgr %%r1,%%r2\n"  /* CC_OP_LTUGTU_64 */
+                            /* cc_src=100 is not valid for CC_OP_SUBU */
+        "ipm %%r0\n"        /* force cc_src to env */
+        "lghi %%r3,5\n"
+        "lghi %%r4,3\n"
+        "slgr %%r3,%%r4\n"  /* CC_OP_SUBU, cc=3 */
+        "lghi %%r5,0\n"
+        "stckf 0(%%r5)\n"   /* faults; cc must stay 3 */
+        : : : "r0", "r1", "r2", "r3", "r4", "r5", "cc", "memory");
+
+    return EXIT_FAILURE;
+}
-- 
2.55.0


