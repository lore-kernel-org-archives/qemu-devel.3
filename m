Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DF9C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 11:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdTvx-0004Hp-5v; Fri, 23 Feb 2024 06:41:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rdTvr-0004Et-HI
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 06:41:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rdTvo-0007fs-S1
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 06:41:35 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41NBQUkR001815; Fri, 23 Feb 2024 11:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=g2YxLLFyeM3iIfpaniyHQL/cb0ntAFdsPXsagh9+o4I=;
 b=cI37sjNCn53LlqdRG2DX9IxpHov8+yWkavyEJPsLmwrN+EVboon/2jz0hJ6vMt+lyVTE
 f/IhJ3o4oswgarE/h41pcaIrNOJ6jlKCUsuULsLwcFCGvZ0QD5ZVrpYs/HVtwNrP5Omd
 0PYXSykKU/obiwcGecj85tBM4sM0aQ1F4uDDQnN5JycClamZ/djwH+MeSaZv0XvW1F9X
 arYU6bCgmhgL4k4GYH+svMiwQkBmpUGGVdAR7EKKOs36QgSSs8OgtwFlf5kdkDbdKpKd
 Rxi0Sn1iB0jsKWlECB6OE9g4GyxP+uvcpzVZfThh72MWHon+ATAYW8TZJ3PI0UHiRVLi 9Q== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wet26938d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Feb 2024 11:41:28 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41N9o0OH031187; Fri, 23 Feb 2024 11:36:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb9bmckwe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Feb 2024 11:36:03 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41NBZxcB45351318
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Feb 2024 11:36:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 53A5920043;
 Fri, 23 Feb 2024 11:35:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F118420040;
 Fri, 23 Feb 2024 11:35:58 +0000 (GMT)
Received: from heavy (unknown [9.171.81.52])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 23 Feb 2024 11:35:58 +0000 (GMT)
Date: Fri, 23 Feb 2024 12:35:57 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, richard.purdie@linuxfoundation.org, mjt@tls.msk.ru
Subject: Re: [PATCH 3/3] linux-user: Rewrite target_shmat
Message-ID: <jwyuvao4apydvykmsnvacwshdgy3ixv7qvkh4dbxm3jkwgnttw@k4wpaayou7oq>
References: <20240223030309.458451-1-richard.henderson@linaro.org>
 <20240223030309.458451-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223030309.458451-4-richard.henderson@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VxXYAbKjHe8Rvqyrgf-suqneyjCTBkZU
X-Proofpoint-GUID: VxXYAbKjHe8Rvqyrgf-suqneyjCTBkZU
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0 mlxscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230084
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
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

On Thu, Feb 22, 2024 at 05:03:09PM -1000, Richard Henderson wrote:
> Handle combined host and guest alignment requirements.
> Handle host and guest page size differences.
> Handle SHM_EXEC.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/115
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/mmap.c | 146 ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 110 insertions(+), 36 deletions(-)

[...]

> -    /* find out the length of the shared memory segment */
> +    /*
> +     * Because we can't use host shmat() unless the address is sufficiently
> +     * aligned for the host, we'll need to check both.
> +     * TODO: Could be fixed with softmmu.
> +     */

Are there any plans to introduce softmmu to qemu-user?

[...]

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>



Please consider adding the reproducer to the series:

From 964164ada4de55ac01a56613f7b759e538803fc9 Mon Sep 17 00:00:00 2001
From: Ilya Leoshkevich <iii@linux.ibm.com>
Date: Fri, 23 Feb 2024 12:31:40 +0100
Subject: [PATCH] tests/tcg: Check that shmat() does not break /proc/self/maps

Add a regression test for a recently fixed issue, where shmat()
desynced the guest and the host view of the address space and caused
open("/proc/self/maps") to SEGV.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/multiarch/linux/linux-shmat-maps.c | 40 ++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 tests/tcg/multiarch/linux/linux-shmat-maps.c

diff --git a/tests/tcg/multiarch/linux/linux-shmat-maps.c b/tests/tcg/multiarch/linux/linux-shmat-maps.c
new file mode 100644
index 00000000000..4090bc77ba7
--- /dev/null
+++ b/tests/tcg/multiarch/linux/linux-shmat-maps.c
@@ -0,0 +1,40 @@
+/*
+ * Test that shmat() does not break /proc/self/maps.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <sys/ipc.h>
+#include <sys/shm.h>
+#include <unistd.h>
+
+int main(void)
+{
+    char buf[128];
+    int err, fd;
+    int shmid;
+    ssize_t n;
+    void *p;
+
+    shmid = shmget(IPC_PRIVATE, 0x400, IPC_CREAT | 0600);
+    assert(shmid != -1);
+    p = shmat(shmid, (void *)0x800000, 0);
+    assert(p != (void *)-1);
+
+    fd = open("/proc/self/maps", O_RDONLY);
+    assert(fd != -1);
+    do {
+        n = read(fd, buf, sizeof(buf));
+        assert(n >= 0);
+    } while (n != 0);
+    close(fd);
+
+    err = shmdt(p);
+    assert(err == 0);
+    err = shmctl(shmid, IPC_RMID, NULL);
+    assert(err == 0);
+
+    return EXIT_SUCCESS;
+}
-- 
2.34.1


