Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A55C48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvQ7-0005Y8-FF; Fri, 02 Feb 2024 10:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rVvPy-0005SK-CH
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:25:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rVvPt-0006rq-Ql
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:25:26 -0500
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 412EsnL9026664; Fri, 2 Feb 2024 15:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=gfNDszcFWQRwzjOUtlj9edt1h/Nvyvw6bMbOjrrz4oA=;
 b=pA1AJ8DReRzpyPzh1bvIiC8e9C0rQMb2pVlPFcuGL2lvKkXvPmBDyokQQV/3LdnruV/G
 E0vpbRjU0RsIiJTs/BLkBJ9FbrUnTyFlFqr6TvMSqzDDon5KGMg2kBRaeld8gNgxsIUc
 CYhiXlY6r8RJdZXN+KxepbVUMmwmBRZ8IBBviHsmaIBVLpetcFjwpDvjp+TmuKHI0/od
 +46jLN0jV7sleEZcN8rapDOZSKnz8Pfhh8jJf3Pnf0YAa04QR1qFrInzE74al1z/AkJ7
 ZwARtcL2BIBlLx4tNJc71MdmKOSLD1GcCBN55UpPu6eYI88nH9xrYrmafl65Pzq/0Tc1 ww== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w0yhedsvn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Feb 2024 15:25:13 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 412DwHA9010887; Fri, 2 Feb 2024 15:25:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwecm3s07-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Feb 2024 15:25:12 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 412FPAg915270468
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Feb 2024 15:25:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D79A12004B;
 Fri,  2 Feb 2024 15:25:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A2BC02004E;
 Fri,  2 Feb 2024 15:25:10 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Feb 2024 15:25:10 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 3/5] gdbstub: Add syscall entry/return hooks
Date: Fri,  2 Feb 2024 16:23:45 +0100
Message-ID: <20240202152506.279476-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202152506.279476-1-iii@linux.ibm.com>
References: <20240202152506.279476-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: E4823ZshbS7QLECf_8VExKy4Cbb9aaZ9
X-Proofpoint-ORIG-GUID: E4823ZshbS7QLECf_8VExKy4Cbb9aaZ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 spamscore=0 impostorscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402020112
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

The upcoming syscall catchpoint support needs to get control on syscall
entry and return. Provide the necessary hooks for that, which are
no-ops for now.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 gdbstub/user.c               |  8 ++++++++
 include/gdbstub/user.h       | 13 +++++++++++++
 include/user/syscall-trace.h |  7 +++++--
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/gdbstub/user.c b/gdbstub/user.c
index 63edca131ab..2ba01c17faf 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -502,3 +502,11 @@ void gdb_syscall_handling(const char *syscall_packet)
     gdb_put_packet(syscall_packet);
     gdb_handlesig(gdbserver_state.c_cpu, 0);
 }
+
+void gdb_syscall_entry(CPUState *cs, int num)
+{
+}
+
+void gdb_syscall_return(CPUState *cs, int num)
+{
+}
diff --git a/include/gdbstub/user.h b/include/gdbstub/user.h
index 1fc43e04af5..68b6534130c 100644
--- a/include/gdbstub/user.h
+++ b/include/gdbstub/user.h
@@ -51,5 +51,18 @@ void gdb_signalled(CPUArchState *as, int sig);
  */
 void gdbserver_fork(CPUState *cs);
 
+/**
+ * gdb_syscall_entry() - inform gdb of syscall entry and yield control to it
+ * @cs: CPU
+ * @num: syscall number
+ */
+void gdb_syscall_entry(CPUState *cs, int num);
+
+/**
+ * gdb_syscall_entry() - inform gdb of syscall return and yield control to it
+ * @cs: CPU
+ * @num: syscall number
+ */
+void gdb_syscall_return(CPUState *cs, int num);
 
 #endif /* GDBSTUB_USER_H */
diff --git a/include/user/syscall-trace.h b/include/user/syscall-trace.h
index 557f881a79b..b48b2b2d0ae 100644
--- a/include/user/syscall-trace.h
+++ b/include/user/syscall-trace.h
@@ -11,6 +11,7 @@
 #define SYSCALL_TRACE_H
 
 #include "exec/user/abitypes.h"
+#include "gdbstub/user.h"
 #include "qemu/plugin.h"
 #include "trace/trace-root.h"
 
@@ -20,7 +21,7 @@
  * could potentially unify the -strace code here as well.
  */
 
-static inline void record_syscall_start(void *cpu, int num,
+static inline void record_syscall_start(CPUState *cpu, int num,
                                         abi_long arg1, abi_long arg2,
                                         abi_long arg3, abi_long arg4,
                                         abi_long arg5, abi_long arg6,
@@ -29,11 +30,13 @@ static inline void record_syscall_start(void *cpu, int num,
     qemu_plugin_vcpu_syscall(cpu, num,
                              arg1, arg2, arg3, arg4,
                              arg5, arg6, arg7, arg8);
+    gdb_syscall_entry(cpu, num);
 }
 
-static inline void record_syscall_return(void *cpu, int num, abi_long ret)
+static inline void record_syscall_return(CPUState *cpu, int num, abi_long ret)
 {
     qemu_plugin_vcpu_syscall_ret(cpu, num, ret);
+    gdb_syscall_return(cpu, num);
 }
 
 
-- 
2.43.0


