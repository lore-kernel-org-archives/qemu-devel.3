Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00F4C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 13:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raxxG-0008Ba-2F; Fri, 16 Feb 2024 08:08:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1raxxD-0008AN-7P
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:08:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1raxxB-0001OY-LL
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:08:34 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41GBZvFc021566; Fri, 16 Feb 2024 13:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=5SH4lmlhtxankpHZyJAHPFYjbaLcrNA/dcKnK5HraLw=;
 b=cjXp19Eehc5i3BZkA8RUzN19KIyE22+tMyt53OH2wRsew7zWwVrQUj9ckVwUAL+ZIj0L
 BwPDVNtnVWd+C2GfDBwueMt6SivZzkuHbZFkT7r3nUjp32h6PlU9aViNFEVXSI/HSdtK
 qFRR42+40FR1N0tjZ1EyPtFK8EpUiXtBXoh5r+C/1PpgkPG6CfL7cguKtJZumJMPfG3C
 /6/kKH1z4H56BL0vW3goQiSH/Q72+eN7bCnNrJPfSg1x23IKjULFs1ZFUAUQbvZJ162Y
 1o1vZyWABDGpSuOKiU+hjaHUw1enV34MKqPRLn+dSHNORlZ4u6Y/SBMWFryfq9liAxTJ Sw== 
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wa5f7ujdf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Feb 2024 13:08:30 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41GCHpt8032596; Fri, 16 Feb 2024 13:08:29 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6kfu3kgr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Feb 2024 13:08:29 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41GD8PQn14025400
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Feb 2024 13:08:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 854E52004E;
 Fri, 16 Feb 2024 13:08:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4CB8C20043;
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
Subject: [PATCH v3 05/11] {linux,bsd}-user: Pass pid to gdbserver_fork()
Date: Fri, 16 Feb 2024 14:05:32 +0100
Message-ID: <20240216130817.369377-6-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216130817.369377-1-iii@linux.ibm.com>
References: <20240216130817.369377-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ubIl9gZnQM1ftqeY9WvsEDk8kaCaIfq1
X-Proofpoint-GUID: ubIl9gZnQM1ftqeY9WvsEDk8kaCaIfq1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_11,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 mlxlogscore=982 lowpriorityscore=0 priorityscore=1501 adultscore=0
 mlxscore=0 clxscore=1015 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160106
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

The upcoming follow-fork-mode child support requires knowing the child
pid. Pass it down.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 bsd-user/main.c        | 2 +-
 gdbstub/user.c         | 2 +-
 include/gdbstub/user.h | 2 +-
 linux-user/main.c      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index bc233a85cef..e8c658eda5d 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -131,7 +131,7 @@ void fork_end(abi_long pid)
          */
         qemu_init_cpu_list();
         ((TaskState *)thread_cpu->opaque)->ts_tid = qemu_get_thread_id();
-        gdbserver_fork(thread_cpu);
+        gdbserver_fork(pid);
     } else {
         mmap_fork_end(child);
         cpu_list_unlock();
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 5024c670f85..69b9857e5b6 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -375,7 +375,7 @@ static void disable_gdbstub(void)
 }
 
 /* Disable gdb stub for child processes.  */
-void gdbserver_fork(CPUState *cpu)
+void gdbserver_fork(pid_t pid)
 {
     if (!gdbserver_state.init || gdbserver_user_state.fd < 0) {
         return;
diff --git a/include/gdbstub/user.h b/include/gdbstub/user.h
index e33f8d9a9a6..66dd0d319cf 100644
--- a/include/gdbstub/user.h
+++ b/include/gdbstub/user.h
@@ -54,7 +54,7 @@ void gdbserver_fork_start(void);
  * gdbserver_fork() - disable gdb stub for child processes.
  * @cs: CPU
  */
-void gdbserver_fork(CPUState *cs);
+void gdbserver_fork(pid_t pid);
 
 /**
  * gdb_syscall_entry() - inform gdb of syscall entry and yield control to it
diff --git a/linux-user/main.c b/linux-user/main.c
index f1a0267816b..ad1c6394520 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -164,7 +164,7 @@ void fork_end(abi_long pid)
         }
         qemu_init_cpu_list();
         ((TaskState *)thread_cpu->opaque)->ts_tid = qemu_get_thread_id();
-        gdbserver_fork(thread_cpu);
+        gdbserver_fork(pid);
     } else {
         cpu_list_unlock();
     }
-- 
2.43.0


