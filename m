Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0B4C48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 11:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWx4D-0001nt-9e; Mon, 05 Feb 2024 06:23:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rWx4B-0001nA-1y
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 06:23:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rWx49-0006lt-By
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 06:23:10 -0500
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 415BHFWY007378; Mon, 5 Feb 2024 11:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=zdxcbEECknBBaQKnY2r1RZzvv98LbHHMVVggcu9cuUc=;
 b=cyGyyyRf0xGkXEhIvpj5gUbHu1NYC3XXfASIRJvKWVoq1nL2pVKlSP1VuxuB/SwPvuV3
 TukXDPwQId+RoNAsfbPO1QxxiUwVOO4xZOlU3zdsNey7YOlatg5sgu28kI8ksXg8Upb4
 42VLumcr9QPSlPJE0197KAKv36prpaFKYe/vfV0wtmfsMjGtkfTPVlSKtmoXFCNRcKIG
 HI/vBnfcKZqY19qFu6jOrDQPximPgKyi7X8PN8YjiDb5ITo8ry8f53y3IcwngoPT2mDE
 a+pM7vRrGe/HCryIpTyNFQoopz2jgDqMaqdp+WPIctuQhEFzvB0bKcpcFfQB8osY2nuo 2A== 
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w2xntr5c6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 11:23:05 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 415AAXNH008765; Mon, 5 Feb 2024 11:23:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w206y87wg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 11:23:03 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 415BN1qd2949746
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Feb 2024 11:23:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A3D1320049;
 Mon,  5 Feb 2024 11:23:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 375DA20040;
 Mon,  5 Feb 2024 11:23:01 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.32.247])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Feb 2024 11:23:01 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 07/11] gdbstub: Introduce gdb_handle_query_supported_user()
Date: Mon,  5 Feb 2024 12:22:21 +0100
Message-ID: <20240205112251.121569-8-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205112251.121569-1-iii@linux.ibm.com>
References: <20240205112251.121569-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: THsOqnncQqFwkvCgoRj14W50LyXileeF
X-Proofpoint-GUID: THsOqnncQqFwkvCgoRj14W50LyXileeF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0
 phishscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=952 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050086
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

The upcoming follow-fork-mode child support requires advertising the
fork-events feature, which is user-specific. Introduce a user-specific
hook for this.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 gdbstub/gdbstub.c   | 12 +++++++++---
 gdbstub/internals.h |  1 +
 gdbstub/user.c      |  4 ++++
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 7e73e916bdc..43d79dfdd59 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1599,6 +1599,7 @@ static void handle_query_thread_extra(GArray *params, void *user_ctx)
 
 static void handle_query_supported(GArray *params, void *user_ctx)
 {
+    const char *gdb_supported;
     CPUClass *cc;
 
     g_string_printf(gdbserver_state.str_buf, "PacketSize=%x", MAX_PACKET_LENGTH);
@@ -1622,9 +1623,14 @@ static void handle_query_supported(GArray *params, void *user_ctx)
     g_string_append(gdbserver_state.str_buf, ";qXfer:exec-file:read+");
 #endif
 
-    if (params->len &&
-        strstr(get_param(params, 0)->data, "multiprocess+")) {
-        gdbserver_state.multiprocess = true;
+    if (params->len) {
+        gdb_supported = get_param(params, 0)->data;
+        if (strstr(gdb_supported, "multiprocess+")) {
+            gdbserver_state.multiprocess = true;
+        }
+#if defined(CONFIG_USER_ONLY)
+        gdb_handle_query_supported_user(gdb_supported);
+#endif
     }
 
     g_string_append(gdbserver_state.str_buf, ";vContSupported+;multiprocess+");
diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 56b7c13b750..e6063835b1f 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -196,6 +196,7 @@ void gdb_handle_v_file_pread(GArray *params, void *user_ctx); /* user */
 void gdb_handle_v_file_readlink(GArray *params, void *user_ctx); /* user */
 void gdb_handle_query_xfer_exec_file(GArray *params, void *user_ctx); /* user */
 void gdb_handle_set_catch_syscalls(GArray *params, void *user_ctx); /* user */
+void gdb_handle_query_supported_user(const char *gdb_supported); /* user */
 
 void gdb_handle_query_attached(GArray *params, void *user_ctx); /* both */
 
diff --git a/gdbstub/user.c b/gdbstub/user.c
index df5a618e789..2b8c67972c0 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -382,6 +382,10 @@ void gdbserver_fork_end(pid_t pid)
     disable_gdbstub();
 }
 
+void gdb_handle_query_supported_user(const char *gdb_supported)
+{
+}
+
 /*
  * Execution state helpers
  */
-- 
2.43.0


