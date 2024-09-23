Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35998CF9C72
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 16:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sslpi-0006ge-Hy; Mon, 23 Sep 2024 12:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sslpW-0006TF-A9
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:22:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sslpQ-0000bL-9Z
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:22:26 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NFT66b019038;
 Mon, 23 Sep 2024 16:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=Cgy2qk6HjG5JJ
 0WOIKaJYPb+2l7viaNGKxXp7rBP3wA=; b=BY34Lw+Za2uXpz3BekbNO9Tocry5z
 HvNpyS/3UJtG27CQDK4mQ9OKma2oXyrpv/qHUN2j7Ict5Wy6RRkQ1nwH+TB+8s03
 zBPXp1neVmjjM8rp4/kc+oojFxJto3mgBcFfKLoTilnSJup76pu4Hro/BX8JAvz4
 Na2qzvXqzsU3+ovIj4O7hw5TeZS980PTGx/+S8rE8vhXbYESoEJS8nGYgSgj/xoB
 5oNtKgikWYN2JXf88T2Dp62XaJvODGMhL2p/9IabbiE1Te9Z3JqvTr0MzTREpEJT
 JMCrRgT1QwFO0lzEuGA7CxhVNBu6cZBy2bCXgSMFqayTL1kTnBAg2d1XA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41skjrd0eh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:21 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48NGML0P024405;
 Mon, 23 Sep 2024 16:22:21 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41skjrd0ee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48NDoOSU000622;
 Mon, 23 Sep 2024 16:22:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41t8fufp6m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:20 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48NGMIjW34996878
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Sep 2024 16:22:18 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63ABE20043;
 Mon, 23 Sep 2024 16:22:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E11C20040;
 Mon, 23 Sep 2024 16:22:18 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.24.235])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Sep 2024 16:22:17 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 04/18] gdbstub: Factor out gdb_try_stop()
Date: Mon, 23 Sep 2024 18:12:59 +0200
Message-ID: <20240923162208.90745-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240923162208.90745-1-iii@linux.ibm.com>
References: <20240923162208.90745-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xakpJiLLpjgt5mD9eqLYmM4nzM1TwfPA
X-Proofpoint-ORIG-GUID: D1d0S_wUiDJIIZLAL65EciPuO6IrQ_2R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_12,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=878 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409230117
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

Move checking and setting allow_stop_reply into a function.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 gdbstub/gdbstub.c   | 15 +++++++++++----
 gdbstub/internals.h |  2 ++
 gdbstub/system.c    |  6 ++----
 gdbstub/user.c      | 11 ++++-------
 4 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index d08568cea0e..a096104b07a 100644
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
index 5ce357c6c2b..fbe9528569c 100644
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
index 6a493c5ba3a..77ba227fc3b 100644
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
2.46.0


