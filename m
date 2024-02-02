Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63236C48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvQ8-0005a1-58; Fri, 02 Feb 2024 10:25:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rVvPv-0005Ro-Nq
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:25:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rVvPs-0006rQ-VO
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:25:23 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 412ESpRJ031480; Fri, 2 Feb 2024 15:25:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=aA6ju2ksrf9A66cSc0F6fQnKqkyRtWncUhddWUQRfdk=;
 b=f5ajDrFATiqOZfIXjBaN/6mLMhGYSB40Xe3cZD6+KQDIufStLVzBg57urSRpkyGVD3b9
 yV8FO9K+Z/t22x6I+Jlg5sQHXXCuBxbMdkc/FGqU0CAheuUtcbgGI0s+Z5rNNN54X6dB
 0TIKw995pigu6Sd2/0vt6zo21Jd8JypWQmLdcsBesFxvFeEUPqeIo+bd2/ukCOWPz+ni
 g5eA4HLOD9NNVIihfjwLuLFmVAe0Mb+RDrM4DXFlrywbYHF4qrwMDQmZknynwHw7h1Qf
 NIDYRuhoPakpAJySNVXwmU95a/wrbnu7YaFPhV04pHislqOTsnPg3/ObEeMX90hLQhM+ iw== 
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w126h9d9p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Feb 2024 15:25:14 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 412D02Lr008234; Fri, 2 Feb 2024 15:25:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwdnmkx74-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Feb 2024 15:25:13 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 412FPBcj61800896
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Feb 2024 15:25:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B7C92004D;
 Fri,  2 Feb 2024 15:25:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 365032004B;
 Fri,  2 Feb 2024 15:25:11 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Feb 2024 15:25:11 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 4/5] gdbstub: Implement catching syscalls
Date: Fri,  2 Feb 2024 16:23:46 +0100
Message-ID: <20240202152506.279476-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202152506.279476-1-iii@linux.ibm.com>
References: <20240202152506.279476-1-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xL6yd-gfqbNnC-P3kSKIeoCDUM8G9nOs
X-Proofpoint-ORIG-GUID: xL6yd-gfqbNnC-P3kSKIeoCDUM8G9nOs
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402020112
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

GDB supports stopping on syscall entry and exit using the "catch
syscall" command. It relies on 3 packets, which are currently not
supported by QEMU:

* qSupported:QCatchSyscalls+ [1]
* QCatchSyscalls: [2]
* T05syscall_entry: and T05syscall_return: [3]

Implement generation and handling of these packets.

[1] https://sourceware.org/gdb/current/onlinedocs/gdb.html/General-Query-Packets.html#qSupported
[2] https://sourceware.org/gdb/current/onlinedocs/gdb.html/General-Query-Packets.html#QCatchSyscalls
[3] https://sourceware.org/gdb/current/onlinedocs/gdb.html/Stop-Reply-Packets.html

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 gdbstub/gdbstub.c   |  9 +++++
 gdbstub/internals.h |  1 +
 gdbstub/user.c      | 95 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 46d752bbc2c..7e73e916bdc 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1617,6 +1617,7 @@ static void handle_query_supported(GArray *params, void *user_ctx)
     if (gdbserver_state.c_cpu->opaque) {
         g_string_append(gdbserver_state.str_buf, ";qXfer:auxv:read+");
     }
+    g_string_append(gdbserver_state.str_buf, ";QCatchSyscalls+");
 #endif
     g_string_append(gdbserver_state.str_buf, ";qXfer:exec-file:read+");
 #endif
@@ -1810,6 +1811,14 @@ static const GdbCmdParseEntry gdb_gen_set_table[] = {
         .schema = "l0"
     },
 #endif
+#if defined(CONFIG_USER_ONLY)
+    {
+        .handler = gdb_handle_set_catch_syscalls,
+        .cmd = "CatchSyscalls:",
+        .cmd_startswith = 1,
+        .schema = "s0",
+    },
+#endif
 };
 
 static void handle_gen_query(GArray *params, void *user_ctx)
diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index aeb0d9b5377..56b7c13b750 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -195,6 +195,7 @@ void gdb_handle_v_file_close(GArray *params, void *user_ctx); /* user */
 void gdb_handle_v_file_pread(GArray *params, void *user_ctx); /* user */
 void gdb_handle_v_file_readlink(GArray *params, void *user_ctx); /* user */
 void gdb_handle_query_xfer_exec_file(GArray *params, void *user_ctx); /* user */
+void gdb_handle_set_catch_syscalls(GArray *params, void *user_ctx); /* user */
 
 void gdb_handle_query_attached(GArray *params, void *user_ctx); /* both */
 
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 2ba01c17faf..8f3affbad47 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -10,6 +10,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bitops.h"
 #include "qemu/cutils.h"
 #include "qemu/sockets.h"
 #include "exec/hwaddr.h"
@@ -21,11 +22,20 @@
 #include "trace.h"
 #include "internals.h"
 
+#define GDB_NR_SYSCALLS 1024
+typedef unsigned long GDBSyscallsMask[BITS_TO_LONGS(GDB_NR_SYSCALLS)];
+
 /* User-mode specific state */
 typedef struct {
     int fd;
     char *socket_path;
     int running_state;
+    /*
+     * Store syscalls mask without memory allocation in order to avoid
+     * implementing synchronization.
+     */
+    bool catch_all_syscalls;
+    GDBSyscallsMask catch_syscalls_mask;
 } GDBUserState;
 
 static GDBUserState gdbserver_user_state;
@@ -503,10 +513,95 @@ void gdb_syscall_handling(const char *syscall_packet)
     gdb_handlesig(gdbserver_state.c_cpu, 0);
 }
 
+static bool should_catch_syscall(int num)
+{
+    if (gdbserver_user_state.catch_all_syscalls) {
+        return true;
+    }
+    if (num < 0 || num >= GDB_NR_SYSCALLS) {
+        return false;
+    }
+    return test_bit(num, gdbserver_user_state.catch_syscalls_mask);
+}
+
 void gdb_syscall_entry(CPUState *cs, int num)
 {
+    if (should_catch_syscall(num)) {
+        g_autoptr(GString) reason = g_string_sized_new(24);
+
+        g_string_printf(reason, "syscall_entry:%x;", num);
+        gdb_handlesig_reason(cs, gdb_target_sigtrap(), reason->str);
+    }
 }
 
 void gdb_syscall_return(CPUState *cs, int num)
 {
+    if (should_catch_syscall(num)) {
+        g_autoptr(GString) reason = g_string_sized_new(24);
+
+        g_string_printf(reason, "syscall_return:%x;", num);
+        gdb_handlesig_reason(cs, gdb_target_sigtrap(), reason->str);
+    }
+}
+
+void gdb_handle_set_catch_syscalls(GArray *params, void *user_ctx)
+{
+    const char *param = get_param(params, 0)->data;
+    GDBSyscallsMask catch_syscalls_mask;
+    bool catch_all_syscalls;
+    unsigned int num;
+    const char *p;
+
+    /* "0" means not catching any syscalls. */
+    if (strcmp(param, "0") == 0) {
+        gdbserver_user_state.catch_all_syscalls = false;
+        memset(gdbserver_user_state.catch_syscalls_mask, 0,
+               sizeof(gdbserver_user_state.catch_syscalls_mask));
+        gdb_put_packet("OK");
+        return;
+    }
+
+    /* "1" means catching all syscalls. */
+    if (strcmp(param, "1") == 0) {
+        gdbserver_user_state.catch_all_syscalls = true;
+        gdb_put_packet("OK");
+        return;
+    }
+
+    /*
+     * "1;..." means catching only the specified syscalls.
+     * The syscall list must not be empty.
+     */
+    if (param[0] == '1' && param[1] == ';') {
+        catch_all_syscalls = false;
+        memset(catch_syscalls_mask, 0, sizeof(catch_syscalls_mask));
+        for (p = &param[2];; p++) {
+            if (qemu_strtoui(p, &p, 16, &num) || (*p && *p != ';')) {
+                goto err;
+            }
+            if (num >= GDB_NR_SYSCALLS) {
+                /*
+                 * Fall back to reporting all syscalls. Reporting extra
+                 * syscalls is inefficient, but the spec explicitly allows it.
+                 * Keep parsing in case there is a syntax error ahead.
+                 */
+                catch_all_syscalls = true;
+            } else {
+                set_bit(num, catch_syscalls_mask);
+            }
+            if (!*p) {
+                break;
+            }
+        }
+        gdbserver_user_state.catch_all_syscalls = catch_all_syscalls;
+        if (!catch_all_syscalls) {
+            memcpy(gdbserver_user_state.catch_syscalls_mask,
+                   catch_syscalls_mask, sizeof(catch_syscalls_mask));
+        }
+        gdb_put_packet("OK");
+        return;
+    }
+
+err:
+    gdb_put_packet("E00");
 }
-- 
2.43.0


