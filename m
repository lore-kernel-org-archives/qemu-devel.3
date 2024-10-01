Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7577DCEACFC
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 19:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svicE-0002Ee-LE; Tue, 01 Oct 2024 15:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1svicA-0002CX-D7
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 15:32:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1svic7-0000wp-W5
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 15:32:53 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491JOafH031948;
 Tue, 1 Oct 2024 19:32:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=sF2BU2LK10BL4i6hQOdXJvt9zX
 hxIEFv6oe8WWodwSs=; b=GxIwRtkFV2R+QpykVoMCPg4CE5T+Z30kXDm3dAmXKf
 WzdkGSKlFPqsKel+GUyF9XdXP46i0RjF8TVwFzN0Ab8UzttkxZaP7nK2HyB/NWSw
 6i97FCPZZ6WS9qtJpT1FkO3QD4j9CKsgqcL5UoAbC5sAeYhRVOA0OtdkgKr3Im5I
 UzLmEKvzK64v0fJ+YKOMU/SZ+qnDr6JkoYl5+nHsZeTspCJCKFyUUFedXZSd+F49
 dEwDB9gBQvk0e7wQTIrvETKfKsWCpld9Yyp3VOhgjL0NO2tnvq/i0UNIM0+oWy+J
 4tRoRdkrjw/d/Z3Uj/OsaPAZX2k/b705tvnb2RpEAy0g==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420q7a015x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 19:32:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 491II1HB017852;
 Tue, 1 Oct 2024 19:32:48 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xw4mxc1u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 19:32:48 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 491JWkfP32703004
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2024 19:32:46 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4240920043;
 Tue,  1 Oct 2024 19:32:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BDCF620040;
 Tue,  1 Oct 2024 19:32:45 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.29.119])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2024 19:32:45 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] linux-user: Trace wait4()'s and waitpid()'s wstatus
Date: Tue,  1 Oct 2024 21:32:08 +0200
Message-ID: <20241001193244.14939-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fVJXtAfoAmZu71IcMlYJTklPHrL5CbcI
X-Proofpoint-GUID: fVJXtAfoAmZu71IcMlYJTklPHrL5CbcI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_14,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0 clxscore=1015
 mlxlogscore=891 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010123
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

Borrow the code for formatting the most frequent WIFEXITED() and
WIFSIGNALED() special cases from from the strace's printstatus().

Output examples:

    474729 wait4(-1,0x7f00767ff0a0,0,(nil)) = 474733 (wstatus={WIFEXITED(s) && WEXITSTATUS(s) == 1})
    475833 wait4(-1,0x7f7de61ff0a0,0,(nil)) = 475837 (wstatus={WIFSIGNALED(s) && WTERMSIG(s) == SIGKILL})
    1168 waitpid(1171,0x7f44eea00340,0) = 1171 (wstatus={WIFSIGNALED(s) && WTERMSIG(s) == SIGKILL})

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 linux-user/strace.c    | 61 ++++++++++++++++++++++++++++++++++++++++++
 linux-user/strace.list |  6 +++--
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index b4d1098170e..d5d1f18304d 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -4168,6 +4168,67 @@ print_ioctl(CPUArchState *cpu_env, const struct syscallname *name,
 }
 #endif
 
+#if defined(TARGET_NR_wait4) || defined(TARGET_NR_waitpid)
+static void print_wstatus(int wstatus)
+{
+    if (WIFSIGNALED(wstatus)) {
+        qemu_log("{WIFSIGNALED(s) && WTERMSIG(s) == ");
+        print_signal(WTERMSIG(wstatus), 1);
+        if (WCOREDUMP(wstatus)) {
+            qemu_log(" && WCOREDUMP(s)");
+        }
+        qemu_log("}");
+    } else if (WIFEXITED(wstatus)) {
+        qemu_log("{WIFEXITED(s) && WEXITSTATUS(s) == %d}",
+                 WEXITSTATUS(wstatus));
+    } else {
+        print_number(wstatus, 1);
+    }
+}
+
+static void print_ret_wstatus(abi_long ret, abi_long wstatus_addr)
+{
+    if (!print_syscall_err(ret)) {
+        qemu_log(TARGET_ABI_FMT_ld " (wstatus=", ret);
+        if (wstatus_addr == 0) {
+            qemu_log("NULL");
+        } else {
+            int wstatus;
+
+            get_user_s32(wstatus, wstatus_addr);
+            print_wstatus(wstatus);
+        }
+        qemu_log(")");
+    }
+
+    qemu_log("\n");
+}
+#endif
+
+#ifdef TARGET_NR_wait4
+static void
+print_syscall_ret_wait4(CPUArchState *cpu_env,
+                        const struct syscallname *name,
+                        abi_long ret, abi_long arg0, abi_long arg1,
+                        abi_long arg2, abi_long arg3, abi_long arg4,
+                        abi_long arg5)
+{
+    print_ret_wstatus(ret, arg1);
+}
+#endif
+
+#ifdef TARGET_NR_waitpid
+static void
+print_syscall_ret_waitpid(CPUArchState *cpu_env,
+                          const struct syscallname *name,
+                          abi_long ret, abi_long arg0, abi_long arg1,
+                          abi_long arg2, abi_long arg3, abi_long arg4,
+                          abi_long arg5)
+{
+    print_ret_wstatus(ret, arg1);
+}
+#endif
+
 /*
  * An array of all of the syscalls we know about
  */
diff --git a/linux-user/strace.list b/linux-user/strace.list
index dfd4237d14e..2bb6f2726a8 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1659,13 +1659,15 @@
 { TARGET_NR_vserver, "vserver" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_wait4
-{ TARGET_NR_wait4, "wait4" , "%s(%d,%p,%d,%p)", NULL, NULL },
+{ TARGET_NR_wait4, "wait4" , "%s(%d,%p,%d,%p)", NULL,
+                   print_syscall_ret_wait4 },
 #endif
 #ifdef TARGET_NR_waitid
 { TARGET_NR_waitid, "waitid" , "%s(%#x,%d,%p,%#x)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_waitpid
-{ TARGET_NR_waitpid, "waitpid" , "%s(%d,%p,%#x)", NULL, NULL },
+{ TARGET_NR_waitpid, "waitpid", "%s(%d,%p,%#x)", NULL,
+                     print_syscall_ret_waitpid },
 #endif
 #ifdef TARGET_NR_write
 { TARGET_NR_write, "write" , "%s(%d,%#x,%d)", NULL, NULL },
-- 
2.46.2


