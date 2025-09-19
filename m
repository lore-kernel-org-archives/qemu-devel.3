Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179BCCAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 14:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbrY-0000v8-Qt; Fri, 19 Sep 2025 10:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzbqy-0000R8-JW
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:12:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzbqs-0007Sn-Ui
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:12:45 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDuOQG016253;
 Fri, 19 Sep 2025 14:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=IirLX65VcmUSLYw1Y2R4b+U1BUr3BFuwJGPwD/Bai6s=; b=
 ENitvL3+t4OuGlozWoWYw5H0chpR3UCN9NBKMpEZGlm7zEKz7SkbOj7sqrTOIvfZ
 ifvw0yAB7n+N/Asz9sx2a2s8Y8mvhbh8Q7O5tLwC9NmoxBFxMt5sGffhQOflO4HC
 xRVLnerpT1FROc8ePe1DKw2zXMCtEhXiAQsfWKMU8jlibIOnTM9iNPZ0d3+wxUeI
 GW41u7HvLHb1LbXR+pBXujVyWNRFt50SLqjJqcHnXgyFKK3nXc8tlbchSF5VR58K
 8vOFeldeePJU1UCj5xnrsXDnrvK1xrLYSy01S0DQaOqTMCo+senILvj5IZxHtE2+
 VCQTXd2+iTYFwPDenSLYNQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxbwnhy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 14:12:39 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JCo4kN035235; Fri, 19 Sep 2025 14:12:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2pu94j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 14:12:38 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JECYX7003357;
 Fri, 19 Sep 2025 14:12:37 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 494y2pu924-4; Fri, 19 Sep 2025 14:12:37 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 03/11] tests/qtest: qtest_create_test_state
Date: Fri, 19 Sep 2025 07:12:25 -0700
Message-Id: <1758291153-349744-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1758291153-349744-1-git-send-email-steven.sistare@oracle.com>
References: <1758291153-349744-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509190132
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX0CxsgDUL3TUL
 7DXO8BVybofOvhtJgNr0ZzeOd/3x2jv88iYEAeUfEmMHFFkabEbbtOVF5BnzdJH1of0oTzy7bcI
 Ao+HGXSBFHbwHsPp5TK5jxxrYBTlREWM70RFXhGfthGi4QrZncymeV/gju4fIAxAsJa8qmndnHG
 kOsYWRU4Az+GdT+twk9qAeyedraKQL01sH+ePuy1Qu27tfoBCpIS09fwRe+/tPWPdh0iOnAXUoh
 g8M2xTQYWcfQsazIFaOrQPxhsGqaAkb86dF0LuL/aeGZZJHn78jy9X3EQDGNmwC0gigmhJUQMIY
 ueO0MEJYy45+d/ceYUaD1wpX9zJNU9WX7MAhOtFA18Sk1+4Z0LtCm1UGzxOie7t0dZ5nOdEHJGm
 AB0zMVqJBh7shQzXphwT69Tql5LuOQ==
X-Authority-Analysis: v=2.4 cv=X5RSKHTe c=1 sm=1 tr=0 ts=68cd64d7 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=e7BPDN4iQOm0AXFvdZ8A:9 cc=ntf
 awl=host:13614
X-Proofpoint-GUID: NUiEIfFzdq5j01Q7ZrfJN4xWsDwgWL5V
X-Proofpoint-ORIG-GUID: NUiEIfFzdq5j01Q7ZrfJN4xWsDwgWL5V
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Refactor qtest_spawn_qemu and create a subroutine to create a QTestState
object, to be used in a subsequent patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/libqtest.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 551bc8c..3fa9317 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -409,22 +409,29 @@ static pid_t qtest_create_process(char *cmd)
 }
 #endif /* _WIN32 */
 
-static QTestState *qtest_spawn_qemu(const char *qemu_bin, const char *args)
+static QTestState *qtest_create_test_state(int pid)
 {
     QTestState *s = g_new0(QTestState, 1);
+
+    s->qemu_pid = pid;
+    qtest_add_abrt_handler(kill_qemu_hook_func, s);
+    return s;
+}
+
+static QTestState *qtest_spawn_qemu(const char *qemu_bin, const char *args)
+{
+    int pid;
     g_autoptr(GString) command = g_string_new("");
 
     g_string_printf(command, CMD_EXEC "%s %s", qemu_bin, args);
 
-    qtest_add_abrt_handler(kill_qemu_hook_func, s);
-
     if (!silence_spawn_log) {
         g_test_message("starting QEMU: %s", command->str);
     }
 
 #ifndef _WIN32
-    s->qemu_pid = fork();
-    if (s->qemu_pid == 0) {
+    pid = fork();
+    if (pid == 0) {
 #ifdef __linux__
         /*
          * Although we register a ABRT handler to kill off QEMU
@@ -447,10 +454,10 @@ static QTestState *qtest_spawn_qemu(const char *qemu_bin, const char *args)
         exit(1);
     }
 #else
-    s->qemu_pid = qtest_create_process(command->str);
+    pid = qtest_create_process(command->str);
 #endif /* _WIN32 */
 
-    return s;
+    return qtest_create_test_state(pid);
 }
 
 static char *qtest_socket_path(const char *suffix)
-- 
1.8.3.1


