Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8CDC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 17:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuCbY-0001Yx-FG; Wed, 12 Aug 2026 13:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuCZz-0000CF-Po; Wed, 12 Aug 2026 13:17:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuCZw-0000rw-52; Wed, 12 Aug 2026 13:17:27 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CH1RCT2217797; Wed, 12 Aug 2026 17:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=V8ptzNmyKPu+vshmq
 8One2xrd6HnqQ3TnrA9WxtukJE=; b=pSRaPObeDpVW1AFtS2yWLCZ7ktSAp2XLN
 x62NAzMNUhl9Sp2lCGTRm8fg0AyinoydoSWRBI1igsGHJ9DF4T+KM3Rd/svEZHUO
 XQf1l5PcNGpLrjc90aj8+21xKGreuU1DhFVMvTrkSGJKB2WtKhC+ToNV8WjZTRO7
 f7KGSg6FOBRVM1rmYdvjgMafOC+14+flk8UqWkmlQ+dWbBfGTG/rz8k5PuAZ9otj
 tST/B3K1OZc0LBA4D0kzXcyedj6uQjHxNDjZRsWhRJqZjRqaIv2gB/47h5AyHVMh
 b1sF+j3vM1M0s5q0cwDwOg3RiQhNpuR4lO3krMkBXGKxx/s58w0KA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk03qc2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:17:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CHBGZV026634;
 Wed, 12 Aug 2026 17:17:20 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gf0dr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:17:20 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67CHHJ7p33358400
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 17:17:19 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7AE2D58051;
 Wed, 12 Aug 2026 17:17:19 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E7FA45805C;
 Wed, 12 Aug 2026 17:17:18 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.61.74]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Aug 2026 17:17:18 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 12/15] tests/tcg/s390x: Test STCKF condition code on a faulting
 store
Date: Wed, 12 Aug 2026 13:17:04 -0400
Message-ID: <20260812171707.1605637-13-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812171707.1605637-1-farman@linux.ibm.com>
References: <20260812171707.1605637-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX+gUCSQ5ayV8j
 KDKSmVyNEnF7e8wJVrx6GDWb273DM0iHetlddATANXk8WuyIu6bHlbwIdJaP/g866Fe+/VAzAAu
 wRkk2uZlvHmlZ82LcpZilaWd8F63wyAm5TGM6OjsOWKWGTCW31Zmo0YF6sZeOl53kvuc+FgkOMe
 WxnKNUiDGZFaRfDTFtzBL3bhdX/bcFWavIu46HvX6Nvk6pXkZjONY36uIiEUJXezicK2Adsre2c
 KK579FsM8aBv1mB8sz2CqS4ak66/s0Y3NQ++ie1Znyk1yFDl719smpH1wsHkNQHtebJQpXEvQqn
 pPo+xHE9sDf/oSNyjueuGVJM7OZFyiUlWgd+rYZfx/bZE0AtM2zY1pB/bK2LAeAMJ9GLEJwprWk
 4BaOxR/w1Kf/jaK026VGLB+WyVfSN5tB29aUs4VolYt0zoWy+fqM7xPfU00rjtWxtfLYFTdKei8
 9bW2TbXG770kFK3zlPA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfXxW9Wfs9whloe
 b8UTLxjUKORXmCTWPO+PqCw8oQiOi5BUPMymgPs54rMcKzSqyTNlU0eLpAqLAinV603ncs6sUaS
 MyRKsNkBud1aakcMkupwsDhrPBfVRXQ=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7caaa1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=WP8Cd5ww1JR6ZgQUb_gA:9
X-Proofpoint-GUID: JZBn4a5r-82JgeQe2O_SOe_2oV1rkkMB
X-Proofpoint-ORIG-GUID: JZBn4a5r-82JgeQe2O_SOe_2oV1rkkMB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120138
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Add a small test to prevent regressions.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260714203206.363028-3-iii@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 tests/tcg/s390x/Makefile.target |  1 +
 tests/tcg/s390x/stckf.c         | 44 +++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 tests/tcg/s390x/stckf.c

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 48cba4cdfa..97c0f02190 100644
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
index 0000000000..51c8c9df9f
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


