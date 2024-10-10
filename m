Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E13ECEE323
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 09:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sypUa-0001lx-0x; Thu, 10 Oct 2024 05:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sypUX-0001ks-OK
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 05:29:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sypUV-00042N-Vj
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 05:29:53 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A8K1VO003803;
 Thu, 10 Oct 2024 09:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=ETncT5lCyhzwG
 nMjBB6nolyPPKdi2oajEmG/BBYp5h8=; b=GccHQ2P7W1YOgEJwBnDb1RzxFCkK3
 aR9yCL27axgnamCOgdw4rMRo/cwKpiF8c5zEZkjMG5IucXZFW42u60EMCDQ4udkh
 TBzm9cU8w5Bq9Cmz5DVUbXcl4MZ6fVJqKqaY29RZg9ecMcWjn/i67gQQRI4UvmXV
 4ChA+xw5iVEBwIRAVPIzPFUFynA1DUqAJVD5TqzvVFCkH5SZcCVuZniIoeoTp8d6
 hkTgJcYjnyVlSa4hueAKnfsWWuxwJ8CrYEGi+u8Ig/DIpPtUty+XTsPDc0Kv99FZ
 0vX4S7KMZ6eCkIbZhWhkXorEnbnjaRtJjqEMuayb6NGaCBGSjyudMolzQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 426bapgapu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 09:29:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49A8jhvY011505;
 Thu, 10 Oct 2024 09:29:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423g5xy2xu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 09:29:49 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49A9TlLM29426406
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 09:29:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 809E32004E;
 Thu, 10 Oct 2024 09:29:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3313020040;
 Thu, 10 Oct 2024 09:29:47 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.88.135])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 10 Oct 2024 09:29:47 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 4/4] gdbstub: Factor out gdb_try_stop()
Date: Thu, 10 Oct 2024 11:26:59 +0200
Message-ID: <20241010092938.226868-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241010092938.226868-1-iii@linux.ibm.com>
References: <20241010092938.226868-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: apvGy05YBMZw16HXZYjxSd0gsXoRWazf
X-Proofpoint-GUID: apvGy05YBMZw16HXZYjxSd0gsXoRWazf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_05,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=821
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410100062
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

Move checking and setting allow_stop_reply into a function.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 gdbstub/gdbstub.c   | 15 +++++++++++----
 gdbstub/internals.h |  2 ++
 gdbstub/system.c    |  6 ++----
 gdbstub/user.c      | 11 ++++-------
 4 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index b1def7e71d2..c45934b52b8 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1422,11 +1422,10 @@ static void handle_v_attach(GArray *params, void *user_ctx)
     gdbserver_state.g_cpu = cpu;
     gdbserver_state.c_cpu = cpu;
 
-    if (gdbserver_state.allow_stop_reply) {
+    if (gdb_try_stop()) {
         g_string_printf(gdbserver_state.str_buf, "T%02xthread:", GDB_SIGNAL_TRAP);
         gdb_append_thread_id(cpu, gdbserver_state.str_buf);
         g_string_append_c(gdbserver_state.str_buf, ';');
-        gdbserver_state.allow_stop_reply = false;
 cleanup:
         gdb_put_strbuf();
     }
@@ -2016,12 +2015,11 @@ static void handle_gen_set(GArray *params, void *user_ctx)
 
 static void handle_target_halt(GArray *params, void *user_ctx)
 {
-    if (gdbserver_state.allow_stop_reply) {
+    if (gdb_try_stop()) {
         g_string_printf(gdbserver_state.str_buf, "T%02xthread:", GDB_SIGNAL_TRAP);
         gdb_append_thread_id(gdbserver_state.c_cpu, gdbserver_state.str_buf);
         g_string_append_c(gdbserver_state.str_buf, ';');
         gdb_put_strbuf();
-        gdbserver_state.allow_stop_reply = false;
     }
     /*
      * Remove all the breakpoints when this query is issued,
@@ -2493,3 +2491,12 @@ void gdb_create_default_process(GDBState *s)
     process->target_xml = NULL;
 }
 
+bool gdb_try_stop(void)
+{
+    if (!gdbserver_state.allow_stop_reply) {
+        return false;
+    }
+
+    gdbserver_state.allow_stop_reply = false;
+    return true;
+}
diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 5acc36846f3..310861e581b 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -215,4 +215,6 @@ void gdb_breakpoint_remove_all(CPUState *cs);
 int gdb_target_memory_rw_debug(CPUState *cs, hwaddr addr,
                                uint8_t *buf, int len, bool is_write);
 
+bool gdb_try_stop(void);
+
 #endif /* GDBSTUB_INTERNALS_H */
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 2e31e42f7dd..64cfcf25221 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -141,7 +141,7 @@ static void gdb_vm_state_change(void *opaque, bool running, RunState state)
         return;
     }
 
-    if (!gdbserver_state.allow_stop_reply) {
+    if (!gdb_try_stop()) {
         return;
     }
 
@@ -211,7 +211,6 @@ static void gdb_vm_state_change(void *opaque, bool running, RunState state)
 
 send_packet:
     gdb_put_packet(buf->str);
-    gdbserver_state.allow_stop_reply = false;
 
     /* disable single step if it was enabled */
     cpu_single_step(cpu, 0);
@@ -428,10 +427,9 @@ void gdb_exit(int code)
 
     trace_gdbstub_op_exiting((uint8_t)code);
 
-    if (gdbserver_state.allow_stop_reply) {
+    if (gdb_try_stop()) {
         snprintf(buf, sizeof(buf), "W%02x", (uint8_t)code);
         gdb_put_packet(buf);
-        gdbserver_state.allow_stop_reply = false;
     }
 
     qemu_chr_fe_deinit(&gdbserver_system_state.chr, true);
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 1fef5201f4e..17bcb9d70d9 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -181,10 +181,9 @@ void gdb_exit(int code)
 
     trace_gdbstub_op_exiting((uint8_t)code);
 
-    if (gdbserver_state.allow_stop_reply) {
+    if (gdb_try_stop()) {
         snprintf(buf, sizeof(buf), "W%02x", (uint8_t)code);
         gdb_put_packet(buf);
-        gdbserver_state.allow_stop_reply = false;
     }
 
 }
@@ -222,7 +221,7 @@ int gdb_handlesig(CPUState *cpu, int sig, const char *reason, void *siginfo,
 
     if (sig != 0) {
         gdb_set_stop_cpu(cpu);
-        if (gdbserver_state.allow_stop_reply) {
+        if (gdb_try_stop()) {
             g_string_printf(gdbserver_state.str_buf,
                             "T%02xthread:", gdb_target_signal_to_gdb(sig));
             gdb_append_thread_id(cpu, gdbserver_state.str_buf);
@@ -231,7 +230,6 @@ int gdb_handlesig(CPUState *cpu, int sig, const char *reason, void *siginfo,
                 g_string_append(gdbserver_state.str_buf, reason);
             }
             gdb_put_strbuf();
-            gdbserver_state.allow_stop_reply = false;
         }
     }
     /*
@@ -276,13 +274,12 @@ void gdb_signalled(CPUArchState *env, int sig)
     char buf[4];
 
     if (!gdbserver_state.init || gdbserver_user_state.fd < 0 ||
-        !gdbserver_state.allow_stop_reply) {
+        !gdb_try_stop()) {
         return;
     }
 
     snprintf(buf, sizeof(buf), "X%02x", gdb_target_signal_to_gdb(sig));
     gdb_put_packet(buf);
-    gdbserver_state.allow_stop_reply = false;
 }
 
 static void gdb_accept_init(int fd)
@@ -502,7 +499,7 @@ void gdbserver_fork_end(CPUState *cpu, pid_t pid)
         gdbserver_user_state.fork_peer_pid = pid;
         gdbserver_user_state.fork_peer_tid = pid;
 
-        if (!gdbserver_state.allow_stop_reply) {
+        if (!gdb_try_stop()) {
             goto fail;
         }
         g_string_printf(gdbserver_state.str_buf,
-- 
2.46.2


