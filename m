Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8AB7C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4Si-0007nf-UP; Mon, 19 Feb 2024 09:17:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rc4SW-0007ct-V4
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:17:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rc4SS-0000c5-RR
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:17:27 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41JDVKF3019634; Mon, 19 Feb 2024 14:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=RIpyKs5zla7kVBoVyvou+c9ak55u87vmshrxWJS0Ay8=;
 b=fqFiNDhU9XOSJiB1IUXt/m8KYokYfzLpt9m81Kp2BpgrIkVVnIMKSsOK9GocgpM5F8cQ
 LjYrz9uZmorS23I/s+xlXA/W3nyS1h8V5H3hVYwvN11BbD1mJcIHbjkI28hOeD3FmIeG
 +F6mQJr5YHeSGh1UdxlspAVSI60LkomH6Fpv4BuhzT6o34MMxtRkDs0R/banmXA5ujhW
 W+zCk+59H8mSS1jY0ojdHypTc0wHKrAzAl2OTwTOf1fNIQoUVny6N6Ni0o8d+WZ2D7iP
 24HNIjS8ddzpO78NwGd/HXtPe0rdPZGRydob7cZesJUC+g5Zt6rmxWjJrpgmW8ZDYqjI MQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wb2p8kj2u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 14:17:05 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41JDVGxj018717;
 Mon, 19 Feb 2024 14:17:05 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wb2p8kj1t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 14:17:05 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41JBqAtd017257; Mon, 19 Feb 2024 14:17:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb8mm1gdv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 14:17:03 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41JEGxjh24314554
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Feb 2024 14:17:01 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A6C620040;
 Mon, 19 Feb 2024 14:16:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E44E320063;
 Mon, 19 Feb 2024 14:16:58 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Feb 2024 14:16:58 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 07/12] gdbstub: Call gdbserver_fork() both in parent and in
 child
Date: Mon, 19 Feb 2024 15:15:55 +0100
Message-ID: <20240219141628.246823-8-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219141628.246823-1-iii@linux.ibm.com>
References: <20240219141628.246823-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YSw-G3O2oHRbW4YRzIz4VaZciNCGsfLs
X-Proofpoint-GUID: ZMuLrhGEh3VZziTuTUxqtNtYpjGIwO8r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_10,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190107
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 bsd-user/main.c        | 3 ++-
 gdbstub/user.c         | 5 ++---
 include/gdbstub/user.h | 5 +++--
 linux-user/main.c      | 2 +-
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 9c5b5c7e1dc..9e23578c4e7 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -131,10 +131,11 @@ void fork_end(pid_t pid)
          */
         qemu_init_cpu_list();
         get_task_state(thread_cpu)->ts_tid = qemu_get_thread_id();
-        gdbserver_fork(thread_cpu, pid);
+        gdbserver_fork_end(thread_cpu, pid);
     } else {
         mmap_fork_end(child);
         cpu_list_unlock();
+        gdbserver_fork_end(thread_cpu, pid);
         end_exclusive();
     }
 }
diff --git a/gdbstub/user.c b/gdbstub/user.c
index c61e1a0d1f6..866a25f9c06 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -374,10 +374,9 @@ static void disable_gdbstub(CPUState *thread_cpu)
     tb_flush(thread_cpu);
 }
 
-/* Disable gdb stub for child processes.  */
-void gdbserver_fork(CPUState *cpu, pid_t pid)
+void gdbserver_fork_end(CPUState *cpu, pid_t pid)
 {
-    if (!gdbserver_state.init || gdbserver_user_state.fd < 0) {
+    if (pid != 0 || !gdbserver_state.init || gdbserver_user_state.fd < 0) {
         return;
     }
     disable_gdbstub(cpu);
diff --git a/include/gdbstub/user.h b/include/gdbstub/user.h
index 3f9f45946e0..4c4e5c4c582 100644
--- a/include/gdbstub/user.h
+++ b/include/gdbstub/user.h
@@ -51,10 +51,11 @@ void gdb_signalled(CPUArchState *as, int sig);
 void gdbserver_fork_start(void);
 
 /**
- * gdbserver_fork() - disable gdb stub for child processes.
+ * gdbserver_fork_end() - inform gdb of the completed fork()
  * @cs: CPU
+ * @pid: 0 if in child process, -1 if fork failed, child process pid otherwise
  */
-void gdbserver_fork(CPUState *cs, pid_t pid);
+void gdbserver_fork_end(CPUState *cs, pid_t pid);
 
 /**
  * gdb_syscall_entry() - inform gdb of syscall entry and yield control to it
diff --git a/linux-user/main.c b/linux-user/main.c
index bc78c1a4b03..b7294b9cee2 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -164,10 +164,10 @@ void fork_end(pid_t pid)
         }
         qemu_init_cpu_list();
         get_task_state(thread_cpu)->ts_tid = qemu_get_thread_id();
-        gdbserver_fork(thread_cpu, pid);
     } else {
         cpu_list_unlock();
     }
+    gdbserver_fork_end(thread_cpu, pid);
     /*
      * qemu_init_cpu_list() reinitialized the child exclusive state, but we
      * also need to keep current_cpu consistent, so call end_exclusive() for
-- 
2.43.2


