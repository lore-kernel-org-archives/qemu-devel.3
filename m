Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A01C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 15:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI99M-0000N6-3f; Fri, 14 Jun 2024 11:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1sI99C-0000MU-Vy; Fri, 14 Jun 2024 11:47:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1sI99A-0003n8-JL; Fri, 14 Jun 2024 11:47:26 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45EFQgN0015338;
 Fri, 14 Jun 2024 15:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:content-type
 :content-transfer-encoding:mime-version; s=pp1; bh=5MFds10zWD3zc
 eWHv0GwXy87AqEaI2GojlTAiivj6EY=; b=YWHihgYa9F0M14N5pcG8TcdT87t3G
 w16rMgPqEns/WlCPg0RWL8aGY5V6DDuCTl8E/15pM0Aj1p4lOs/0gAEA+9GhRF+o
 gQdmUHC3jZ+onoeXCGyCceDIgRndgsueH7O/nAauwBLrs4Tar33VQnryTTo7vgNj
 ngIdxUdQxfFPtPjfSI8q65yYB3rYi5Mpi0varz6aVSV0GtnhaKqS3JIMBk8vV3K7
 uxOWK7+RWt9h6YLstGwcCDaXN0q9VUadO5RfDQrGRoBmVcQNhodif+5ZbVul/4Hx
 2o1noSGzWnl/hZvg3BE7GJlz18+j9H9Qm7MxDZl/niqOQckd6o86MJKoA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yrnwa0hq2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jun 2024 15:47:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45EF8lw6020048; Fri, 14 Jun 2024 15:47:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn34ntshc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jun 2024 15:47:17 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45EFlDWJ54001938
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jun 2024 15:47:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7908E2004D;
 Fri, 14 Jun 2024 15:47:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E0AC20040;
 Fri, 14 Jun 2024 15:47:13 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 14 Jun 2024 15:47:13 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] linux-user: Make TARGET_NR_setgroups affect only the
 current thread
Date: Fri, 14 Jun 2024 17:46:40 +0200
Message-ID: <20240614154710.1078766-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bcSDLV4PhNa2vBS2kKEQ7BMrIrtnfJzV
X-Proofpoint-ORIG-GUID: bcSDLV4PhNa2vBS2kKEQ7BMrIrtnfJzV
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_13,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1011 spamscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406140103
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Like TARGET_NR_setuid, TARGET_NR_setgroups should affect only the
calling thread, and not the entire process. Therefore, implement it
using a syscall, and not a libc call.

Cc: qemu-stable@nongnu.org
Fixes: 19b84f3c35d7 ("added setgroups and getgroups syscalls")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---

v1: https://patchew.org/QEMU/20240131001851.15932-1-iii@linux.ibm.com/
v1 -> v2: Rebase, add Philippe's R-b.

 linux-user/syscall.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b9b5a387b33..e2804312fcd 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7209,11 +7209,17 @@ static inline int tswapid(int id)
 #else
 #define __NR_sys_setresgid __NR_setresgid
 #endif
+#ifdef __NR_setgroups32
+#define __NR_sys_setgroups __NR_setgroups32
+#else
+#define __NR_sys_setgroups __NR_setgroups
+#endif
 
 _syscall1(int, sys_setuid, uid_t, uid)
 _syscall1(int, sys_setgid, gid_t, gid)
 _syscall3(int, sys_setresuid, uid_t, ruid, uid_t, euid, uid_t, suid)
 _syscall3(int, sys_setresgid, gid_t, rgid, gid_t, egid, gid_t, sgid)
+_syscall2(int, sys_setgroups, int, size, gid_t *, grouplist)
 
 void syscall_init(void)
 {
@@ -11891,7 +11897,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
                 unlock_user(target_grouplist, arg2,
                             gidsetsize * sizeof(target_id));
             }
-            return get_errno(setgroups(gidsetsize, grouplist));
+            return get_errno(sys_setgroups(gidsetsize, grouplist));
         }
     case TARGET_NR_fchown:
         return get_errno(fchown(arg1, low2highuid(arg2), low2highgid(arg3)));
@@ -12227,7 +12233,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
                 }
                 unlock_user(target_grouplist, arg2, 0);
             }
-            return get_errno(setgroups(gidsetsize, grouplist));
+            return get_errno(sys_setgroups(gidsetsize, grouplist));
         }
 #endif
 #ifdef TARGET_NR_fchown32
-- 
2.45.1


