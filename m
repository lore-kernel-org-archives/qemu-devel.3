Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D269CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yrG-0005I9-8W; Wed, 01 Oct 2025 11:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yqy-0004yo-CZ
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:34:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yqc-0006RY-W5
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:34:51 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591FMuuW005646;
 Wed, 1 Oct 2025 15:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=CcZWgF3T7PGFzWQ04xt18QHjl3fuUEAHThnz05VqWXE=; b=
 D4Cy7jKr5T/Qu+4Ikj1zIQD2j5IbEQmyGdYIMrqqfjD3OChfUHpWNw42j9z9o3Eo
 6qiJxuaU7J6SH10ufv7/OQclRFXGuCaqO/4kMgVtAZRQKqIzSqQ+1ZESvuNd+tov
 Pd2LoLJUnVsK8joIE2nKrKnnXKWQvVGWMKKdcvdnpRZWQsZ7lyRdD6neIp7hKWGB
 DOVgrKRECtyFlI7rkfmP/34nQVOXPTN9apQTrXjpWPPMHwXNhsgNYlcwn7koqQ76
 1dzSlqp2g0LTeq7+Z6bELpIoyQEjJwC5lv26GhkYtlfdnl8FlpslM6CabckYXHCT
 Zd59vTQGrfhD+MBTI6VB/g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gmcq1pq9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 15:34:22 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 591EmWsd023147; Wed, 1 Oct 2025 15:34:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6caaw7t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 15:34:21 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 591FYCr2014790;
 Wed, 1 Oct 2025 15:34:21 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 49e6caaw0k-13; Wed, 01 Oct 2025 15:34:21 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 12/19] tests/qtest: qtest_qemu_spawn_func
Date: Wed,  1 Oct 2025 08:34:04 -0700
Message-Id: <1759332851-370353-13-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2NiBTYWx0ZWRfX05ZfGM3pT/bh
 uFDr5XoiCYunkb0F6MO7Ppz47GYwTkzXXHI4eaBlcSEwawNuxw4uxWxxpjMzLjhJLeTzj0VWdcz
 8sYx1OZho9K9nPKPff/WU7Ds3oeFZr/1x5QBUuRLFnBsmQ6BkJtQSVYTHZSFzvdwxf9+TAaLYRj
 UjwmB0wVfxynQ7ZWN9qbmBnckf2ON+W1TKALDQrWRGiYviXhKY8wkZ+R2K2rOauO7PICSkSwp+P
 xS85DaFnFsQ3Z3sK3O5O+ZWStWJUGIzmZGItR/Rod2WSlxChSTMW+o+TMAImSt+X4Vgm9xrNhxB
 684mXZl0P3YjXVuNyoAqAPbr1F0VLXfZ1vhFCegPpNh+1Qw9L5mH3hW6X1ZBGjvTgIHQ1OxMH5F
 7S87LlE+xFUTwJyMS0JnfU0lY5+iFg==
X-Proofpoint-ORIG-GUID: aeFoBgwXZTfsDfk4-26qGkQAYGOhI3BO
X-Authority-Analysis: v=2.4 cv=c7amgB9l c=1 sm=1 tr=0 ts=68dd49ff b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=GWFuMjjoAsU5Ejt__ZMA:9
X-Proofpoint-GUID: aeFoBgwXZTfsDfk4-26qGkQAYGOhI3BO
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Allow the qtest_qemu_spawn caller to pass the function to be called
to perform the spawn.  The opaque argument is needed by a new spawn
function in a subsequent patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index e1ecd38..644c634 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -418,7 +418,8 @@ static QTestState *qtest_create_test_state(int pid)
     return s;
 }
 
-static QTestState *qtest_spawn_qemu(const char *qemu_bin, const char *args)
+static QTestState *qtest_spawn_qemu(const char *qemu_bin, const char *args,
+                                    void *opaque)
 {
     int pid;
     g_autoptr(GString) command = g_string_new("");
@@ -492,9 +493,15 @@ gchar *qtest_qemu_args(const char *extra_args)
     return args;
 }
 
+typedef QTestState *(*qtest_qemu_spawn_func)(const char *qemu_bin,
+                                             const char *extra_args,
+                                             void *opaque);
+
 static QTestState *qtest_init_internal(const char *qemu_bin,
                                        const char *extra_args,
-                                       bool do_connect)
+                                       bool do_connect,
+                                       qtest_qemu_spawn_func spawn,
+                                       void *opaque)
 {
     QTestState *s;
     int sock, qmpsock, i;
@@ -515,7 +522,7 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
     sock = init_socket(socket_path);
     qmpsock = init_socket(qmp_socket_path);
 
-    s = qtest_spawn_qemu(qemu_bin, args);
+    s = spawn(qemu_bin, args, opaque);
 
     qtest_client_set_rx_handler(s, qtest_client_socket_recv_line);
     qtest_client_set_tx_handler(s, qtest_client_socket_send);
@@ -570,7 +577,8 @@ void qtest_connect(QTestState *s)
 
 QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
 {
-    return qtest_init_internal(qtest_qemu_binary(NULL), extra_args, true);
+    return qtest_init_internal(qtest_qemu_binary(NULL), extra_args, true,
+                               qtest_spawn_qemu, NULL);
 }
 
 void qtest_qmp_handshake(QTestState *s, QList *capabilities)
@@ -593,7 +601,7 @@ QTestState *qtest_init_ext(const char *var, const char *extra_args,
                            QList *capabilities, bool do_connect)
 {
     QTestState *s = qtest_init_internal(qtest_qemu_binary(var), extra_args,
-                                        do_connect);
+                                        do_connect, qtest_spawn_qemu, NULL);
 
     if (do_connect) {
         qtest_qmp_handshake(s, capabilities);
-- 
1.8.3.1


