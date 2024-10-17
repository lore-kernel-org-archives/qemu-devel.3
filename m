Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707C6D21262
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 09:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Maz-0006MX-Q7; Thu, 17 Oct 2024 05:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t1Max-0006ML-Eo
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 05:14:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t1Mav-0002iD-9k
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 05:14:59 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GNoQjR020876;
 Thu, 17 Oct 2024 09:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=pxwZSXXB56005n+wHaRMpfxl1QNNxqci35YzG6AEQ
 Cs=; b=JdQaxOOILXv1oyP5EhWDkxu98gwa0UeAR3SQn6b/75rSvlUamUo5sch1i
 33QXVF2UgKjK0yd8/Ro47HexJMcjCL6T9GLmi6OAfLkFJU2w78d/ohOXaX7dbP/w
 8hegurGEUGZn3wOONJ4k8CWtkhpPeMX1WLrMjLb7aMAtAXAfF1Hzfv86LALsHb2+
 8OB/2zhJDxLkfmQcTjRA5SeUzSLTB/Vbe8i6aMBR8bxA53F756+3fwot9uzn4DAq
 s020jIYdncpGtejxKzbhI7T6B8Otb77WDF0iRmNAZgc2COdLlTU+tMdQXCGIoDEb
 hcayUtZGdbCWdm4UieM9N3An5F5vA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42aqgr1vs5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2024 09:14:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49H5EXQC002426;
 Thu, 17 Oct 2024 09:14:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284emwwfj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2024 09:14:52 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49H9Eoal55902612
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 09:14:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A94492005A;
 Thu, 17 Oct 2024 09:14:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A21B2004E;
 Thu, 17 Oct 2024 09:14:50 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.92.150])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Oct 2024 09:14:50 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] linux-user: Trace rt_sigprocmask's sigsets
Date: Thu, 17 Oct 2024 11:14:37 +0200
Message-ID: <20241017091449.443799-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: G-HGmVDmsyTE1mUqWo4kMgGgnwUMo0k-
X-Proofpoint-GUID: G-HGmVDmsyTE1mUqWo4kMgGgnwUMo0k-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410170058
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Add a function for formatting target sigsets. It can be useful for
other syscalls in the future, so put it into the beginning of strace.c.
For simplicity, do not implement the strace's ~[] output syntax.

Add a rt_sigprocmask return handler.

Example outputs:

    4072707 rt_sigprocmask(SIG_BLOCK,[SIGHUP SIGINT SIGQUIT SIGALRM SIGTERM SIGTSTP SIGTTIN SIGTTOU],[],8) = 0
    4072853 rt_sigprocmask(SIG_UNBLOCK,[32 33],NULL,8) = 0

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 linux-user/strace.c    | 84 ++++++++++++++++++++++++++++++++++++------
 linux-user/strace.list |  3 +-
 2 files changed, 75 insertions(+), 12 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index c3eb3a2706a..1fdbd9854ba 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -161,19 +161,20 @@ static const char * const target_signal_name[] = {
 };
 
 static void
-print_signal(abi_ulong arg, int last)
+print_signal_1(abi_ulong arg)
 {
-    const char *signal_name = NULL;
-
     if (arg < ARRAY_SIZE(target_signal_name)) {
-        signal_name = target_signal_name[arg];
+        qemu_log("%s", target_signal_name[arg]);
+    } else {
+        qemu_log(TARGET_ABI_FMT_lu, arg);
     }
+}
 
-    if (signal_name == NULL) {
-        print_raw_param("%ld", arg, last);
-        return;
-    }
-    qemu_log("%s%s", signal_name, get_comma(last));
+static void
+print_signal(abi_ulong arg, int last)
+{
+    print_signal_1(arg);
+    qemu_log("%s", get_comma(last));
 }
 
 static void print_si_code(int arg)
@@ -718,6 +719,51 @@ print_ipc(CPUArchState *cpu_env, const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_rt_sigprocmask
+static void print_target_sigset_t_1(target_sigset_t *set, int last)
+{
+    bool first = true;
+    int i, sig = 1;
+
+    qemu_log("[");
+    for (i = 0; i < TARGET_NSIG_WORDS; i++) {
+        abi_ulong bits = 0;
+        int j;
+
+        __get_user(bits, &set->sig[i]);
+        for (j = 0; j < sizeof(bits) * 8; j++) {
+            if (bits & ((abi_ulong)1 << j)) {
+                if (first) {
+                    first = false;
+                } else {
+                    qemu_log(" ");
+                }
+                print_signal_1(sig);
+            }
+            sig++;
+        }
+    }
+    qemu_log("]%s", get_comma(last));
+}
+
+static void print_target_sigset_t(abi_ulong addr, abi_ulong size, int last)
+{
+    if (addr && size == sizeof(target_sigset_t)) {
+        target_sigset_t *set;
+
+        set = lock_user(VERIFY_READ, addr, sizeof(target_sigset_t), 1);
+        if (set) {
+            print_target_sigset_t_1(set, last);
+            unlock_user(set, addr, 0);
+        } else {
+            print_pointer(addr, last);
+        }
+    } else {
+        print_pointer(addr, last);
+    }
+}
+#endif
+
 /*
  * Variants for the return value output function
  */
@@ -3312,10 +3358,26 @@ print_rt_sigprocmask(CPUArchState *cpu_env, const struct syscallname *name,
     case TARGET_SIG_SETMASK: how = "SIG_SETMASK"; break;
     }
     qemu_log("%s,", how);
-    print_pointer(arg1, 0);
-    print_pointer(arg2, 0);
+    print_target_sigset_t(arg1, arg3, 0);
+}
+
+static void
+print_rt_sigprocmask_ret(CPUArchState *cpu_env, const struct syscallname *name,
+                         abi_long ret, abi_long arg0, abi_long arg1,
+                         abi_long arg2, abi_long arg3, abi_long arg4,
+                         abi_long arg5)
+{
+    if (is_error(ret)) {
+        print_pointer(arg2, 0);
+    } else {
+        print_target_sigset_t(arg2, arg3, 0);
+    }
     print_raw_param("%u", arg3, 1);
     print_syscall_epilogue(name);
+    if (!print_syscall_err(ret)) {
+        qemu_log(TARGET_ABI_FMT_ld, ret);
+    }
+    qemu_log("\n");
 }
 #endif
 
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 0d69fb3150d..fdf94ef32ad 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1189,7 +1189,8 @@
 { TARGET_NR_rt_sigpending, "rt_sigpending" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_rt_sigprocmask
-{ TARGET_NR_rt_sigprocmask, "rt_sigprocmask" , NULL, print_rt_sigprocmask, NULL },
+{ TARGET_NR_rt_sigprocmask, "rt_sigprocmask" , NULL, print_rt_sigprocmask,
+                            print_rt_sigprocmask_ret },
 #endif
 #ifdef TARGET_NR_rt_sigqueueinfo
 { TARGET_NR_rt_sigqueueinfo, "rt_sigqueueinfo" , NULL, print_rt_sigqueueinfo, NULL },
-- 
2.47.0


