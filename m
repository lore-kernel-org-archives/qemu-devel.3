Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280D6C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 13:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raxxK-0008Fd-Nr; Fri, 16 Feb 2024 08:08:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1raxxH-0008C1-05
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:08:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1raxxD-0001P6-4v
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:08:38 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41GD5S1J023495; Fri, 16 Feb 2024 13:08:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Mc9zz5N2kH8Z25bo+x2bSIe9DIAYjxVJXbxKk4VQUbE=;
 b=ZkAh5+5/lfJKtd/gBmxuFxH7DWqR1WleK5VK3y7YHUR+zQyaBdJOs5JshfGFV+AXKXx3
 yNDMt8OJuA4Vf9/eesYoRAZh9NZZxlIfK6ouswCe/KT3FuUS7bEO4p7iS/Hs0zUrVIGW
 aATaHfh9dpAaDKeXi7xC8u5Xuy6yL8TtvyaVZ+0u222SCB1MYS/wii7O4ga7KtgouNWy
 Ifjmf/Q8eT6Wud6L4AWpOSbBA9vMR+iLcFeBXRhBGjevINW8kNzxUTO7K9RoNgu3oJMV
 AHu4xEGknJA2oGvo/fQOlvS1V4vGkE9EGLvjq+X2nxUVr+RHmeFHFh8iy0brl42OWZ7Q tg== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wa6fq2es3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Feb 2024 13:08:30 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41GB0xL4010045; Fri, 16 Feb 2024 13:08:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6npmb0j4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Feb 2024 13:08:29 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41GD8Qqu61407552
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Feb 2024 13:08:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 26D3020043;
 Fri, 16 Feb 2024 13:08:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E21FD20040;
 Fri, 16 Feb 2024 13:08:25 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 16 Feb 2024 13:08:25 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 06/11] gdbstub: Call gdbserver_fork() both in parent and in
 child
Date: Fri, 16 Feb 2024 14:05:33 +0100
Message-ID: <20240216130817.369377-7-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216130817.369377-1-iii@linux.ibm.com>
References: <20240216130817.369377-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8joy5lQGrxvtrRZJM1nhRXRKFIS4Ur0M
X-Proofpoint-GUID: 8joy5lQGrxvtrRZJM1nhRXRKFIS4Ur0M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_11,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 spamscore=0 priorityscore=1501 mlxlogscore=961 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160106
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

The upcoming follow-fork-mode child support requires post-fork message
exchange between the parent and the child. Prepare gdbserver_fork() for
this purpose. Rename it to gdbserver_fork_end() to better reflect its
purpose.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 bsd-user/main.c        | 3 ++-
 gdbstub/user.c         | 5 ++---
 include/gdbstub/user.h | 6 +++---
 linux-user/main.c      | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index e8c658eda5d..1890d6365f7 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -131,10 +131,11 @@ void fork_end(abi_long pid)
          */
         qemu_init_cpu_list();
         ((TaskState *)thread_cpu->opaque)->ts_tid = qemu_get_thread_id();
-        gdbserver_fork(pid);
+        gdbserver_fork_end(pid);
     } else {
         mmap_fork_end(child);
         cpu_list_unlock();
+        gdbserver_fork_end(pid);
         end_exclusive();
     }
 }
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 69b9857e5b6..6ac9b684427 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -374,10 +374,9 @@ static void disable_gdbstub(void)
     }
 }
 
-/* Disable gdb stub for child processes.  */
-void gdbserver_fork(pid_t pid)
+void gdbserver_fork_end(pid_t pid)
 {
-    if (!gdbserver_state.init || gdbserver_user_state.fd < 0) {
+    if (pid != 0 || !gdbserver_state.init || gdbserver_user_state.fd < 0) {
         return;
     }
     disable_gdbstub();
diff --git a/include/gdbstub/user.h b/include/gdbstub/user.h
index 66dd0d319cf..dd03dbdd6df 100644
--- a/include/gdbstub/user.h
+++ b/include/gdbstub/user.h
@@ -51,10 +51,10 @@ void gdb_signalled(CPUArchState *as, int sig);
 void gdbserver_fork_start(void);
 
 /**
- * gdbserver_fork() - disable gdb stub for child processes.
- * @cs: CPU
+ * gdbserver_fork_end() - inform gdb of the completed fork()
+ * @pid: 0 if in child process, -1 if fork failed, child process pid otherwise
  */
-void gdbserver_fork(pid_t pid);
+void gdbserver_fork_end(pid_t pid);
 
 /**
  * gdb_syscall_entry() - inform gdb of syscall entry and yield control to it
diff --git a/linux-user/main.c b/linux-user/main.c
index ad1c6394520..dde5081e2f4 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -164,10 +164,10 @@ void fork_end(abi_long pid)
         }
         qemu_init_cpu_list();
         ((TaskState *)thread_cpu->opaque)->ts_tid = qemu_get_thread_id();
-        gdbserver_fork(pid);
     } else {
         cpu_list_unlock();
     }
+    gdbserver_fork_end(pid);
     /*
      * qemu_init_cpu_list() reinitialized the child exclusive state, but we
      * also need to keep current_cpu consistent, so call end_exclusive() for
-- 
2.43.0


