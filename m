Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B56DC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4Sj-0007p8-DF; Mon, 19 Feb 2024 09:17:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rc4SW-0007cs-UD
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:17:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rc4SS-0000bf-Ri
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:17:28 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41JECuZl006251; Mon, 19 Feb 2024 14:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lJFfD0PKIMGiSZAoFDZxv8dou+CjwtMZXqdMwKn6Qc0=;
 b=OHAsjmz0Pnoe71KjOk3tlhVNQ8vtmn2EV4G8FRF9pVYyDbMpYMeJ4CRKDmQRAdP/uG1W
 L+Ec9t5xwxe/LRp+lvMTf0SRLTNdHN8UYUaOvz1RrsaRuNUOrPQhTDeolSj8kEl3ZiGp
 G+JYyXYgLMj7HRRX608Qy7QcH7tYbza2sCfORsbt4v2b2HHMTw6UqKmb9h4NzxI5+z4G
 XsIPe9I1A7Ecg7vOFbfkYHyb/GCVsKdzx2L9WbjmrS1PBqtJMsAlEM70HKK5AVaquxmT
 UcSdzDP9WBzZjZIJo7eSs1m71c2VaaN6nfUS/TncZ6SaLj72mEgug9Qme7j3iy9CykTC fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wc4vhe8r4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 14:17:05 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41JE5eDw022870;
 Mon, 19 Feb 2024 14:17:05 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wc4vhe8qm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 14:17:04 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41JE1oMi009541; Mon, 19 Feb 2024 14:17:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb84p1n4r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 14:17:03 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41JEGxMX17957552
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Feb 2024 14:17:01 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A40720065;
 Mon, 19 Feb 2024 14:16:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 311F32004B;
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
Subject: [PATCH v4 08/12] gdbstub: Introduce gdb_handle_query_supported_user()
Date: Mon, 19 Feb 2024 15:15:56 +0100
Message-ID: <20240219141628.246823-9-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219141628.246823-1-iii@linux.ibm.com>
References: <20240219141628.246823-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TLpq_YdmeY3lXKK7jPO-KRdB2ktLnT-C
X-Proofpoint-GUID: YAa_H3tbJxzbzH4-NfZctGnJ_QnGp6gN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_10,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

The upcoming follow-fork-mode child support requires advertising the
fork-events feature, which is user-specific. Introduce a user-specific
hook for this.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 gdbstub/gdbstub.c   | 12 +++++++++---
 gdbstub/internals.h |  1 +
 gdbstub/user.c      |  4 ++++
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 7e73e916bdc..898a108b7f1 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1622,9 +1622,15 @@ static void handle_query_supported(GArray *params, void *user_ctx)
     g_string_append(gdbserver_state.str_buf, ";qXfer:exec-file:read+");
 #endif
 
-    if (params->len &&
-        strstr(get_param(params, 0)->data, "multiprocess+")) {
-        gdbserver_state.multiprocess = true;
+    if (params->len) {
+        const char *gdb_supported = get_param(params, 0)->data;
+
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
index 866a25f9c06..c9e8b83d720 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -382,6 +382,10 @@ void gdbserver_fork_end(CPUState *cpu, pid_t pid)
     disable_gdbstub(cpu);
 }
 
+void gdb_handle_query_supported_user(const char *gdb_supported)
+{
+}
+
 /*
  * Execution state helpers
  */
-- 
2.43.2


