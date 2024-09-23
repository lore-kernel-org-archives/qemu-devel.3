Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCA3CF9C6F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 16:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sslpc-0006XM-NP; Mon, 23 Sep 2024 12:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sslpW-0006TC-8m
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:22:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sslpQ-0000bH-QN
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:22:29 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48N7xkQ8012410;
 Mon, 23 Sep 2024 16:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=uMkf2IlyXZQN4
 ANh6mm1/Fa3BXo2aYu81eFDQ0qfVGw=; b=jOueSf0wDe5LXWcEEPWMXO/D3ZTaW
 a+Xf4lg8KyNyHqqNjxLqfDg1CkjZ3BGTANmcI5mrDgQ8x4oxQYu4XrspA9HrKOO4
 LykTj9wiEKPJQAi7zlEq6CE6ji00Itn9AePPbb7qzNg5mHNB3RFYiFEcXzlJNQo/
 DSADgR4qa0vAIkWe5UNbfsEWdQXYbxecxt11XlKzixyhBVJmotcEGuSrCvzZQ4gm
 lGEC8FsTVMAibGbySZykIZeaeevqe6pDvRUwheNqrojfvGB3J3j48I86i5lQG6Gv
 gMLzbHt/O5xcGe8fl6dfNxzH9Pj5n4Z0zrC8M6JveKjGKBizcCX9S6RKg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snt14pcf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:20 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48NGHZWS014888;
 Mon, 23 Sep 2024 16:22:20 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snt14pcc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48NFtG1o020820;
 Mon, 23 Sep 2024 16:22:19 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41tb62y41d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:19 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48NGMIWb34996876
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Sep 2024 16:22:18 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC61120043;
 Mon, 23 Sep 2024 16:22:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 93F8020040;
 Mon, 23 Sep 2024 16:22:17 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.24.235])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Sep 2024 16:22:17 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 03/18] gdbstub: Move gdb_syscall_mode to GDBSyscallState
Date: Mon, 23 Sep 2024 18:12:58 +0200
Message-ID: <20240923162208.90745-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240923162208.90745-1-iii@linux.ibm.com>
References: <20240923162208.90745-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: M_rOjN1FMfvqPioJZsSNErU0xhDxW20W
X-Proofpoint-GUID: B6Rp2P3c-aMiM_eTlpfA_HUGod6nxFL5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_12,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 mlxscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409230121
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Follow the convention that all the pieces of the global stub state must
be inside a single struct.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 gdbstub/syscalls.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/gdbstub/syscalls.c b/gdbstub/syscalls.c
index 4e1295b782d..42307f0abb1 100644
--- a/gdbstub/syscalls.c
+++ b/gdbstub/syscalls.c
@@ -24,6 +24,11 @@
 typedef struct {
     char syscall_buf[256];
     gdb_syscall_complete_cb current_syscall_cb;
+    enum {
+        GDB_SYS_UNKNOWN,
+        GDB_SYS_ENABLED,
+        GDB_SYS_DISABLED,
+    } mode;
 } GDBSyscallState;
 
 static GDBSyscallState gdbserver_syscall_state;
@@ -37,12 +42,6 @@ static bool gdb_attached(void)
     return gdbserver_state.init && gdbserver_state.c_cpu;
 }
 
-static enum {
-    GDB_SYS_UNKNOWN,
-    GDB_SYS_ENABLED,
-    GDB_SYS_DISABLED,
-} gdb_syscall_mode;
-
 /* Decide if either remote gdb syscalls or native file IO should be used. */
 int use_gdb_syscalls(void)
 {
@@ -57,16 +56,17 @@ int use_gdb_syscalls(void)
 
     /* -semihosting-config target=auto */
     /* On the first call check if gdb is connected and remember. */
-    if (gdb_syscall_mode == GDB_SYS_UNKNOWN) {
-        gdb_syscall_mode = gdb_attached() ? GDB_SYS_ENABLED : GDB_SYS_DISABLED;
+    if (gdbserver_syscall_state.mode == GDB_SYS_UNKNOWN) {
+        gdbserver_syscall_state.mode = gdb_attached() ? GDB_SYS_ENABLED :
+                                                        GDB_SYS_DISABLED;
     }
-    return gdb_syscall_mode == GDB_SYS_ENABLED;
+    return gdbserver_syscall_state.mode == GDB_SYS_ENABLED;
 }
 
 /* called when the stub detaches */
 void gdb_disable_syscalls(void)
 {
-    gdb_syscall_mode = GDB_SYS_DISABLED;
+    gdbserver_syscall_state.mode = GDB_SYS_DISABLED;
 }
 
 void gdb_syscall_reset(void)
-- 
2.46.0


