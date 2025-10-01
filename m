Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF12CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yrL-0005ME-MU; Wed, 01 Oct 2025 11:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yrI-0005IL-94
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:35:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yqq-0006Rb-Nx
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:35:08 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591FMqsH005628;
 Wed, 1 Oct 2025 15:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=evWC+nVTsrGtY8L50B4VWQLYNlVhbuaTtGvFQGJyeQw=; b=
 UTtEuNt25bh5zALmC06tyBUkWibyOeJaUgQWXZ5pXW5ReBe31jlE4ISQ9ElMIRVi
 6f5BWJxLkZXTp2kGjX/Ub7KEZYvg3xRiAcILpB1pk3vAOFdGnMkKJnj389VxZ1mv
 dhhP2k04WDtzhhXDZoBKk2xYjTPG84sKHCnh/g7Ax95NHEEzMFL1WLXb2xf/kOOY
 g7Pda2MK1R2LOLaw5SMgO0KxSsI7TshXvANGyAc0bnd688ZUIgriwSt4rBD3E59a
 yamXwiRNWn+nPQ8MVz5ZB0kkpKvYImLn0tKZZBnbIsn8SBZmVocODN4k8r+dGsxV
 QyorC3s+ensr+eqRtb32qQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gmcq1pq7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 15:34:22 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 591EmvLc023181; Wed, 1 Oct 2025 15:34:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6caaw71-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 15:34:20 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 591FYCr0014790;
 Wed, 1 Oct 2025 15:34:20 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 49e6caaw0k-12; Wed, 01 Oct 2025 15:34:20 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 11/19] tests/qtest: qtest_create_test_state
Date: Wed,  1 Oct 2025 08:34:03 -0700
Message-Id: <1759332851-370353-12-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
References: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510010134
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2NiBTYWx0ZWRfXyNjpQHGoCSDT
 vJxVXpilZ+Fv2Db143z1picHSZ3I6en3QDsjzHc4dre7lphnXU/6H1wUm4AIgwjg7on9L3IkEtB
 PoyuG7WWGCnd2VpsI7TQ85Q0+TvoLhQvDYspc25lDOcY8xF1YQu+sjxn9aaH8EzkqrirnjAV099
 qEGI2vOMiq57mtXh1hs7rGVVXuF2Lyl44fHmAjHY2kpoyuGKYWQOJ5vNShXFrSzH+CyRugLGgDx
 agRIAXyq54L38wjXFP0Q47DaZ3r8ZbhTwDOWRy8l5DZefFFqPFzwXZQSG0i9sPSc2D583Wq/dnx
 4Crb0eu3ctrnL7RCCUiDOMtc9JJZBE39BqizHZDPEcxlA75Hj8B4yyTK1TUwAYVBfknfEE0QXUD
 oeSM3UUPXMcNMK0FjOI0bgn5AcjELA==
X-Proofpoint-ORIG-GUID: pfB2QjN7NFfi3K1JaVZiimqt0TaEyxns
X-Authority-Analysis: v=2.4 cv=c7amgB9l c=1 sm=1 tr=0 ts=68dd49fe b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=Df2fqW_L1vg5yVQ28mgA:9
 a=EBa_rOYxF3VBboPlVeQ_:22
X-Proofpoint-GUID: pfB2QjN7NFfi3K1JaVZiimqt0TaEyxns
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Refactor qtest_spawn_qemu and create a subroutine to create a QTestState
object, to be used in a subsequent patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index b3b3fc2..e1ecd38 100644
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


