Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C8FFC677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP26v-0001qz-3f; Tue, 10 Jun 2025 12:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uP0b0-0007o2-IK
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:09:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uP0ay-0001od-2W
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:09:01 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A99CAF011492;
 Tue, 10 Jun 2025 15:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=m+Df7iFknAkzi8J/Pdf6Bl4e+8Tm725ZRtY+s6HTc
 gk=; b=FrgqWY4uNewekSALhtLIRdO4DxQZNc1JQ/bOuLVQYdgCAaFN/u5kl90H6
 TxIZko22oItR4NOLgjXNoX+Uv/xCwJ3Tkp72noirc0fFCMHi8v4GiuAkKEc245cs
 YL76Ny5vqj+v3EbWlVSOz0OgO4ZVmSdaHRDhUWFJBatHdtBizqMcQz9Y72FGxf5B
 cmtzJqtqdgxC7WTwfsZTMyJlNNafqiY6orLXbME2wkCgrc1ORNpFMZTmYMhIPZcm
 lFIH0nFxFoOY0N7vsO3sDDuyN762qmKPc9taTYfMzskPmn/qAXsIfqzES4b8rXU0
 IgrFjFCgxPmQYm11cO6HsN4g3CjVQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474cxj7436-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Jun 2025 15:08:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55ADjH5L027957;
 Tue, 10 Jun 2025 15:08:53 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47518mauny-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Jun 2025 15:08:53 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55AF8qnB26870324
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:08:52 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11D1058052;
 Tue, 10 Jun 2025 15:08:52 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A740E58065;
 Tue, 10 Jun 2025 15:08:51 +0000 (GMT)
Received: from IBM-GLTZVH3.ibm.com (unknown [9.61.254.209])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Jun 2025 15:08:51 +0000 (GMT)
From: Jaehoon Kim <jhkim@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, steven.sistare@oracle.com, peterx@redhat.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH v2] migration: Setup pre-listened cpr.sock to remove
 race-condition.
Date: Tue, 10 Jun 2025 10:08:49 -0500
Message-ID: <20250610150849.326194-1-jhkim@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Xggg3JowEquoSc6eCyAipDHZ9bPhgLr0
X-Proofpoint-GUID: Xggg3JowEquoSc6eCyAipDHZ9bPhgLr0
X-Authority-Analysis: v=2.4 cv=fZWty1QF c=1 sm=1 tr=0 ts=68484a86 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=-bihOfDufEW2raR66WQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDExNyBTYWx0ZWRfX7yCTHUPf4wcp
 MymW62Il39YaIZ/Qu3AbuRA46gge2aGIkFBvqD1la75ehh71w+7XfKwFMwQCtynXLW5W5RYJWFV
 pG127VcYw6xJ4vdgSnNxRB5nzdy6+GpD0bvBmTr8L+9CKm/jeZZvGsJr8qnrHT3/bX8tfWkEEYC
 i0581gi5LLQeseLIgqhDs+qH3GD0nFiSjuB1NEesgfOm6Y8NhDZAEjbyUjNShcDsdtj65rWIsxc
 OiS5HPtxgLYIMNTI/wYyu5igJHj33lcw1rsGZcTxC2O3P/QuDICSOnGD+9DHD4+dY2wFLtLWe1B
 yEB5Kt9lHUy+sf6U6RevLv+9A+oEbaqzIz7Dp/GcZegd1GD5Ib3lVKN/i6rYhSzR19Vp7KwmsQH
 elj3T24ffcsefsKSLmzJ1maa50tvNmKwvDsLe86I+70rt8D8Bn1KkWT6MehYrblH+4QkwZ5t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_06,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506100117
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jhkim@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When the source VM attempts to connect to the destination VM's Unix
domain socket (cpr.sock) during a cpr-transfer test, race conditions can
occur if the socket file isn't ready. This can lead to connection
failures when running tests.

This patch creates and listens on the socket in advance, and passes the
pre-listened FD directly. This avoids timing issues and improves the
reliability of CPR tests.

Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>

---
Changes since v1:
- In v1, the patch added a wait loop to poll the existence of the socket
  file (cpr_validate_socket_path()).

- This version instead creates the socket beforehand and passes its FD
  to the destination QEMU, eliminating the race condition entirely.

- Commit title and message changed accordingly.
---
 migration/cpr-transfer.c          |  3 +-
 tests/qtest/migration/cpr-tests.c | 72 ++++++++++++++++++++++++++++++-
 2 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
index e1f140359c..7c9de70bad 100644
--- a/migration/cpr-transfer.c
+++ b/migration/cpr-transfer.c
@@ -46,7 +46,8 @@ QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp)
     MigrationAddress *addr = channel->addr;
 
     if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET &&
-        addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX) {
+        (addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX ||
+            addr->u.socket.type == SOCKET_ADDRESS_TYPE_FD)) {
 
         g_autoptr(QIOChannelSocket) sioc = NULL;
         SocketAddress *saddr = &addr->u.socket;
diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 5536e14610..6f90160e21 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -50,6 +50,51 @@ static void *test_mode_transfer_start(QTestState *from, QTestState *to)
     return NULL;
 }
 
+/*
+ * Create a pre-listened UNIX domain socket at the specified path.
+ *
+ * This is used to eliminate a race condition that can occur
+ * intermittently in qtest during CPR tests. By pre-creating and
+ * listening on the socket, we avoid timing-related issues.
+ */
+static int setup_socket_listener(const char *path)
+{
+    struct sockaddr_un un;
+    size_t pathlen;
+    int sock_fd;
+
+    sock_fd = socket(PF_UNIX, SOCK_STREAM, 0);
+    if (sock_fd < 0) {
+        g_test_message("Failed to create Unix socket");
+        return -1;
+    }
+
+    pathlen = strlen(path);
+    if (pathlen >= sizeof(un.sun_path)) {
+        g_test_message("UNIX socket path '%s' is too long", path);
+        close(sock_fd);
+        return -1;
+    }
+
+    memset(&un, 0, sizeof(un));
+    un.sun_family = AF_UNIX;
+    strncpy(un.sun_path, path, sizeof(un.sun_path) - 1);
+
+    if (bind(sock_fd, (struct sockaddr *)&un, sizeof(un)) < 0) {
+        g_test_message("Failed to bind socket to %s", path);
+        close(sock_fd);
+        return -1;
+    }
+
+    if (listen(sock_fd, 1) < 0) {
+        g_test_message("Failed to listen on socket %s", path);
+        close(sock_fd);
+        return -1;
+    }
+
+    return sock_fd;
+}
+
 /*
  * cpr-transfer mode cannot use the target monitor prior to starting the
  * migration, and cannot connect synchronously to the monitor, so defer
@@ -60,13 +105,13 @@ static void test_mode_transfer_common(bool incoming_defer)
     g_autofree char *cpr_path = g_strdup_printf("%s/cpr.sock", tmpfs);
     g_autofree char *mig_path = g_strdup_printf("%s/migsocket", tmpfs);
     g_autofree char *uri = g_strdup_printf("unix:%s", mig_path);
+    g_autofree char *addr_type, *addr_key, *addr_value;
+    g_autofree char *opts_target;
 
     const char *opts = "-machine aux-ram-share=on -nodefaults";
     g_autofree const char *cpr_channel = g_strdup_printf(
         "cpr,addr.transport=socket,addr.type=unix,addr.path=%s",
         cpr_path);
-    g_autofree char *opts_target = g_strdup_printf("-incoming %s %s",
-                                                   cpr_channel, opts);
 
     g_autofree char *connect_channels = g_strdup_printf(
         "[ { 'channel-type': 'main',"
@@ -75,6 +120,29 @@ static void test_mode_transfer_common(bool incoming_defer)
         "              'path': '%s' } } ]",
         mig_path);
 
+    /*
+     * Determine socket address type and value.
+     * If socket creation fails, provide the socket path to the target,
+     * so it can create the Unix domain socket itself.
+     * Otherwise, use the pre-listened socket file descriptor directly.
+     */
+    int cpr_sockfd = setup_socket_listener(cpr_path);
+
+    if (cpr_sockfd < 0) {
+        addr_type = g_strdup("unix");
+        addr_key = g_strdup("path");
+        addr_value = g_strdup(cpr_path);
+    } else {
+        addr_type = g_strdup("fd");
+        addr_key = g_strdup("str");
+        addr_value = g_strdup_printf("%d", cpr_sockfd);
+    }
+
+    opts_target = g_strdup_printf("-incoming cpr,addr.transport=socket,"
+                                  "addr.type=%s,addr.%s=%s %s",
+                                  addr_type, addr_key, addr_value, opts);
+
+
     MigrateCommon args = {
         .start.opts_source = opts,
         .start.opts_target = opts_target,
-- 
2.49.0


