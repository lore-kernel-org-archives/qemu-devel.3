Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBD5CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 14:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbra-0000yw-2b; Fri, 19 Sep 2025 10:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzbr2-0000TZ-JA
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:12:54 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzbqt-0007St-Ld
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:12:51 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtmm8023181;
 Fri, 19 Sep 2025 14:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=wHeL1wm/V33LTNAX5D4U4fJeD/N74KTXsPJSJ4miq/E=; b=
 VEcCt84Z9iAnp1tV96+Je/5sKs94EYzWHflmbZt1GY0Bg20Ci4W6j3XiFZjyDGBK
 dGw0+2PrzgR/6HIQpPyGku7T6dbV1V/VJHeP3ONLunKqMHSxjXsZ+IH88BlwCPsV
 wtWwQhIpd+9ijthjLmvIHdrr779e+uFCEmnAVTh+1LWG4CPG4HmFNmwKGIUGJvdI
 vo/uhoGRZlKIFqAiVydQb/Yq+jCTtqgQLeZeF7bc5W914OiqFcqt3pia2nwIxmR5
 QAVdPfJiwp9cHE5T+njKoaAPcFVYm9mSczPpjop5kciEajdFwGVUNDfYua9ocVQt
 bJVbxyo6KgfSugmCOBuQtA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx6np7v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 14:12:39 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JD4V6N035195; Fri, 19 Sep 2025 14:12:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2pu94y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 14:12:39 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JECYX9003357;
 Fri, 19 Sep 2025 14:12:38 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 494y2pu924-5; Fri, 19 Sep 2025 14:12:38 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 04/11] tests/qtest: qtest_qemu_spawn_func
Date: Fri, 19 Sep 2025 07:12:26 -0700
Message-Id: <1758291153-349744-5-git-send-email-steven.sistare@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=TqbmhCXh c=1 sm=1 tr=0 ts=68cd64d7 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=GWFuMjjoAsU5Ejt__ZMA:9 cc=ntf
 awl=host:13614
X-Proofpoint-GUID: 5j7fPA6rsw0ukk-9TNTQieiNIyFkF4DP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX3d4Oj3gnrLPD
 UvMMhBI40ogF3NXUDBMRbAPQ0l2JQw758vGWpY1vKMe1RCpYrm84zKaZYfaJLQVLDVbtHiCywcz
 aa+hYs8w6Z93toB8ABW0Jnp+wNEYTcYgUGkmZhN/PhWMGVuCMfTQu4mWHeMdy+lQg3H13Hfn1dp
 DThxaBHQ09XqWw7ytD9i0Y5euUv/JSwKGzxgb+LyxpxeXl28PNxxWHYJCL74rV7hh2x+bIyQ86z
 xVAucrbCJCYqmRIwsXzqX19x29/fQzBOwT7B/UlmsUCsl3JRntKSvOoua/RHcZIy+VFlyP2G/SK
 tM/5Cm8FUS6OO6zmFjHrEzKIvxbiomrsuW9X4LWVq5AU7bwsGHllgczpkfcVrZYDu0tCnpC6CYs
 NGgOuvFaV7/gkO/agziuMVEwNSmOFQ==
X-Proofpoint-ORIG-GUID: 5j7fPA6rsw0ukk-9TNTQieiNIyFkF4DP
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Allow the qtest_qemu_spawn caller to pass the function to be called
to perform the spawn.  The opaque argument is needed by a new spawn
function in a subsequent patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/libqtest.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 3fa9317..d97144e 100644
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


