Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE0CC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 00:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUyLP-0000kW-5r; Tue, 30 Jan 2024 19:20:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rUyLN-0000kB-6k; Tue, 30 Jan 2024 19:20:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rUyLL-0002gj-HO; Tue, 30 Jan 2024 19:20:44 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40UMvsin026643; Wed, 31 Jan 2024 00:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=XGAEzcsJtQBtV0CR9MG9dsaKQLIQJKcj4JS4UHvcmDg=;
 b=FkqiB8LktRtOGGp/gRm0m2yv7QuLQrMnBTXIX9DCpY1zZwR19YeK38MdmaOztX9HEbS3
 AcQuEzNeGJO+lMvAZl04R6qqnuaupyF3kWrQtGm1yBP7R+Kr6wz7+MTOJEWJ20giU+ly
 dVOZqN9jl4ChxD4gLjiwOp1m42Z92CDpT/vpN5XgzAoW7HzqRrkf4xdWBQ4xqCoOkXjB
 BxLZOnoL7xi+qKaS9UXq2ZyUHiXPwgbm3r3TM/o++bmCVA/yLjZDinELOvk9timWgRyC
 5fVbeQ6BqA2VQ1Bl8O2mWefc/DSWeivmM0OfeMPae9rbVaDcZlNeijgyTjw3urmAjZsf 3A== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vyac91x40-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 00:20:36 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40UNevre011231; Wed, 31 Jan 2024 00:19:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vweckht8s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 00:19:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40V0Iw1q38535528
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jan 2024 00:18:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 949B920043;
 Wed, 31 Jan 2024 00:18:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E45020040;
 Wed, 31 Jan 2024 00:18:58 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.12.102])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 31 Jan 2024 00:18:58 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH] linux-user: Make TARGET_NR_setgroups affect only the current
 thread
Date: Wed, 31 Jan 2024 01:18:46 +0100
Message-ID: <20240131001851.15932-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lTT5oxqpMHvs5E3DoZWrLBfQfowP74vs
X-Proofpoint-GUID: lTT5oxqpMHvs5E3DoZWrLBfQfowP74vs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_13,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=938 bulkscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401310001
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

Like TARGET_NR_setuid, TARGET_NR_setgroups should affect only the
calling thread, and not the entire process. Therefore, implement it
using a syscall, and not a libc call.

Cc: qemu-stable@nongnu.org
Fixes: 19b84f3c35d7 ("added setgroups and getgroups syscalls")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 linux-user/syscall.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ff245dade51..da15d727e16 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7203,11 +7203,17 @@ static inline int tswapid(int id)
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
@@ -11772,7 +11778,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
                 unlock_user(target_grouplist, arg2,
                             gidsetsize * sizeof(target_id));
             }
-            return get_errno(setgroups(gidsetsize, grouplist));
+            return get_errno(sys_setgroups(gidsetsize, grouplist));
         }
     case TARGET_NR_fchown:
         return get_errno(fchown(arg1, low2highuid(arg2), low2highgid(arg3)));
@@ -12108,7 +12114,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
                 }
                 unlock_user(target_grouplist, arg2, 0);
             }
-            return get_errno(setgroups(gidsetsize, grouplist));
+            return get_errno(sys_setgroups(gidsetsize, grouplist));
         }
 #endif
 #ifdef TARGET_NR_fchown32
-- 
2.43.0


