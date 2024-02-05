Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6BDC48295
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 11:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWx49-0001mN-3X; Mon, 05 Feb 2024 06:23:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rWx47-0001lD-4J
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 06:23:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rWx45-0006lC-Go
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 06:23:06 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 415BMsRW029676; Mon, 5 Feb 2024 11:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TdF6dGlEQA62TycdHWNgYXYndkqxqgOSYaVmXiUrvzA=;
 b=jE4hbhh3Tka7FePMQpkcHCO5nLD18KN22LP8+pMGznOBWQCDY6f3Y0Gkiv5X91JlkT3i
 nGEUNgO/V8p6pVrctoe2sGOVChbN2YSue1QjHiBMS4oCUU3q8ECZ9U7VNbejiT/x2CeD
 YpAF45wYgEv6reZhUmrtCAL3Ot7eAg9LTo4/Zns1PjJBe6c2NqUSMyc5KluVuZwFOIT5
 QhfBgQPxO6RMu7CsNENb8V6jby53Z5InQmtv4MSksLf3oQDz3bZBQ2l5YVKUpT/nmxAK
 yyFRUPPp//TXQIIXQcw/jUfZljDJ9IWBDCX2QmWrnRyoafg+5tN6d9VI3aJ3ss7NjjuZ ew== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w2xrb002d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 11:23:02 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41593G1l008487; Mon, 5 Feb 2024 11:23:01 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w221jqq0f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 11:23:01 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 415BN0uF25035386
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Feb 2024 11:23:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0375820049;
 Mon,  5 Feb 2024 11:23:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C47520040;
 Mon,  5 Feb 2024 11:22:59 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.32.247])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Feb 2024 11:22:59 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 05/11] {linux,bsd}-user: Pass pid to gdbserver_fork()
Date: Mon,  5 Feb 2024 12:22:19 +0100
Message-ID: <20240205112251.121569-6-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205112251.121569-1-iii@linux.ibm.com>
References: <20240205112251.121569-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7FhqQp9mtayTrrFRHhQPFF1pvRdIhjSd
X-Proofpoint-GUID: 7FhqQp9mtayTrrFRHhQPFF1pvRdIhjSd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=893 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050086
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
index 85fd44b6aa9..d3a749f3e7e 100644
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


