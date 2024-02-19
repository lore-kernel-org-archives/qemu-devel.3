Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E37EC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4Si-0007mV-3U; Mon, 19 Feb 2024 09:17:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rc4SY-0007d5-Eg
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:17:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rc4SS-0000bY-Ru
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:17:29 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41JDVFqJ018654; Mon, 19 Feb 2024 14:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=x3uNjHH6UNNh8vWfniT7uBFZt8+XW1AS3Xo7jwIOqHQ=;
 b=fKrJbIAhcI359/TlHM+bwsl0C3IDzxO+6GuW9qinLH7X434MjN7S6c33ZvKFczA/OE+W
 pBewDmTPs7bfkavi42hV4UibbtfOCfrz9Xa9Qgfc54RJwhCgGiCcbZTgWCfXKcZBd7dR
 4qWqJHr4PLnUOZHMPg2Bek9k4eqMtlzPJiiw3KG9dH3VxOTPgj17K+l/tmBcvA8m0kFn
 1QeSkRd/jgdOM+EopvfJ2S8Z0phMApnUeW/00Cpo8q0NdWNb9o2dNDyinmEp7G+OR3ky
 8mj7p0nRlVv7BDXUS8fjXrIGL6tz+sreWwOfz0KXaEZioLbvpXm+Gdirjby1zEl1Uq2+ zg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wb2p8kj2f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 14:17:05 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41JDVL4a019749;
 Mon, 19 Feb 2024 14:17:04 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wb2p8kj1v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 14:17:04 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41JCmjsr014343; Mon, 19 Feb 2024 14:17:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb9u2942y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 14:17:03 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41JEGxDJ63373574
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Feb 2024 14:17:01 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AAE982004B;
 Mon, 19 Feb 2024 14:16:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70EF42004D;
 Mon, 19 Feb 2024 14:16:59 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Feb 2024 14:16:59 +0000 (GMT)
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
Subject: [PATCH v4 09/12] gdbstub: Introduce gdb_handle_set_thread_user()
Date: Mon, 19 Feb 2024 15:15:57 +0100
Message-ID: <20240219141628.246823-10-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219141628.246823-1-iii@linux.ibm.com>
References: <20240219141628.246823-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: icTVyvboR5UvPRy9Re-R3HQFl6PiqM7j
X-Proofpoint-GUID: wH-7G-TxAVTpcvbIQbkPYAfBUt4YPvNd
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

The upcoming follow-fork-mode child support needs to perform certain
actions when GDB switches between the stopped parent and the stopped
child. Introduce a user-specific hook for this.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 gdbstub/gdbstub.c   | 11 +++++++++--
 gdbstub/internals.h |  1 +
 gdbstub/user.c      |  5 +++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 898a108b7f1..05fcdd86527 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1066,6 +1066,7 @@ static void handle_cont_with_sig(GArray *params, void *user_ctx)
 
 static void handle_set_thread(GArray *params, void *user_ctx)
 {
+    uint32_t pid, tid;
     CPUState *cpu;
 
     if (params->len != 2) {
@@ -1083,8 +1084,14 @@ static void handle_set_thread(GArray *params, void *user_ctx)
         return;
     }
 
-    cpu = gdb_get_cpu(get_param(params, 1)->thread_id.pid,
-                      get_param(params, 1)->thread_id.tid);
+    pid = get_param(params, 1)->thread_id.pid;
+    tid = get_param(params, 1)->thread_id.tid;
+#ifdef CONFIG_USER_ONLY
+    if (gdb_handle_set_thread_user(pid, tid)) {
+        return;
+    }
+#endif
+    cpu = gdb_get_cpu(pid, tid);
     if (!cpu) {
         gdb_put_packet("E22");
         return;
diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index e6063835b1f..b4905c7181a 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -197,6 +197,7 @@ void gdb_handle_v_file_readlink(GArray *params, void *user_ctx); /* user */
 void gdb_handle_query_xfer_exec_file(GArray *params, void *user_ctx); /* user */
 void gdb_handle_set_catch_syscalls(GArray *params, void *user_ctx); /* user */
 void gdb_handle_query_supported_user(const char *gdb_supported); /* user */
+bool gdb_handle_set_thread_user(uint32_t pid, uint32_t tid); /* user */
 
 void gdb_handle_query_attached(GArray *params, void *user_ctx); /* both */
 
diff --git a/gdbstub/user.c b/gdbstub/user.c
index c9e8b83d720..b048754c4f8 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -386,6 +386,11 @@ void gdb_handle_query_supported_user(const char *gdb_supported)
 {
 }
 
+bool gdb_handle_set_thread_user(uint32_t pid, uint32_t tid)
+{
+    return false;
+}
+
 /*
  * Execution state helpers
  */
-- 
2.43.2


