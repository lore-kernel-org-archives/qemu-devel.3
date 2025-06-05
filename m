Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DF5C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 23:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNJhK-0003yB-LE; Thu, 05 Jun 2025 19:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uNJhI-0003xj-21
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 19:08:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uNJhE-0005dA-KT
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 19:08:31 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555DbCQt008118;
 Thu, 5 Jun 2025 23:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=Aev6lqh3nmqk2ryh4iJFfKFa6gRm46Sw+r6R0gl8/
 SI=; b=DUpDNZv+3cZtrkffh0vq0J9CS4swMDzjXh6PuCCFD2Y9/ziFxkbRUiMtm
 tLJYnSxNMNZOmwklKcegNO1yOyOwXOAiygsjb+gkClnzMw0fICCVLLglmokkAE67
 wwh5L1rmHa0p8J4GB5LDGr4jDY+eJqhTyHO0IcN9jdN2C8gtrmha+E/I2w0VpBUS
 Eyi6HNb1cyyjtDZx3vq++q0MPgc6YXF2ljEfUlniwi4kg0UaexE9k1aoVAjzRL0n
 6VrCm+K7oi+QycNiPf6lCVbovmyalZ6pBxNRkWR8+pPDLvvrKXVjGepQiyiMUKm/
 +Shez4ONDjUzXb+krLoCn8v/ldmSw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47332yn4ks-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Jun 2025 23:08:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 555KQtFB028434;
 Thu, 5 Jun 2025 23:08:23 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 470eakppbf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Jun 2025 23:08:23 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 555N8LTw62587218
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Jun 2025 23:08:22 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D273058068;
 Thu,  5 Jun 2025 23:08:21 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 921A05805D;
 Thu,  5 Jun 2025 23:08:21 +0000 (GMT)
Received: from IBM-GLTZVH3.ibm.com (unknown [9.61.248.176])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Jun 2025 23:08:21 +0000 (GMT)
From: Jaehoon Kim <jhkim@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, steven.sistare@oracle.com, peterx@redhat.com,
 farosas@suse.de, Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH v1] migration: Wait for cpr.sock file to appear before
 connecting
Date: Thu,  5 Jun 2025 18:08:08 -0500
Message-ID: <20250605230808.1278840-1-jhkim@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zTeEF8xpOOH3xyNIFKN-XBu3n9j6o81o
X-Proofpoint-ORIG-GUID: zTeEF8xpOOH3xyNIFKN-XBu3n9j6o81o
X-Authority-Analysis: v=2.4 cv=SO9CVPvH c=1 sm=1 tr=0 ts=68422368 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=fBJVdqey-f1LBL7MPT8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDIwOSBTYWx0ZWRfX2OMdIi+NuzLp
 UZVamUceQhzXaklxptbRl4KCJgozFRASpcRhFfPCvtzjwuT1WdxNGF++gBrLb666KYa7RwUJfo7
 EuCC4uwu3VdsBGTmfAVyUqkKBw8qQYkakf6bTAjwy1s/uElz77azWIBsj7wtHsCJgu9v/STQWwG
 X1d/xOCNgbKeq5UWDDdndFde6mokfjTBGDaD29dGrV+ywYl26fH0HaUKjrsnsTRClruDuxzdTAa
 nCN2Lgdb/QWaajQMWDDhtRROcINDXp1dADgYQyYQxdfAqAXZnDTRftcy0fw/vpeODrXdwo2she0
 MbVQX8DDzTAhDtMkp/xtFnF6XQIJDsK/Gri01R6xvNL4kZHpqdowDLI+IWtQxliu2VnYNmXrM3F
 WtsqIuuFa4oVTbdf36z1L1Qb0mrFlemxwxBoJCJAUMeA1IvvjqGvse+9W1kLGbRj/G6IMW19
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_07,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 clxscore=1011 spamscore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506050209
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jhkim@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When the source VM attempts to connect to the destination VM's Unix
domain socket(cpr.sock) during CPR transfer, the socket file might not
yet be exist if the destination side hasn't completed the bind
operation. This can lead to connection failures when running tests with
the qtest framework.

To address this, add cpr_validate_socket_path(), which wait for the
socket file to appear. This avoids intermittent qtest failures caused by
early connection attempts.

Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 include/migration/cpr.h  |  1 +
 migration/cpr-transfer.c | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 7561fc75ad..cc9384b4f9 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -23,6 +23,7 @@ MigMode cpr_get_incoming_mode(void);
 void cpr_set_incoming_mode(MigMode mode);
 bool cpr_is_incoming(void);
 
+bool cpr_validate_socket_path(const char *path, Error **errp);
 int cpr_state_save(MigrationChannel *channel, Error **errp);
 int cpr_state_load(MigrationChannel *channel, Error **errp);
 void cpr_state_close(void);
diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
index e1f140359c..3088ed323f 100644
--- a/migration/cpr-transfer.c
+++ b/migration/cpr-transfer.c
@@ -17,6 +17,33 @@
 #include "migration/vmstate.h"
 #include "trace.h"
 
+#define CPR_MAX_RETRIES     50     /* Retry for up to 5 seconds */
+#define CPR_RETRY_DELAY_US  100000 /* 100 ms per retry */
+
+bool cpr_validate_socket_path(const char *path, Error **errp)
+{
+    struct stat st;
+    int retries = CPR_MAX_RETRIES;
+
+    do {
+        if (!stat(path, &st) && S_ISSOCK(st.st_mode)) {
+            return true;
+        }
+
+        if (errno == ENOENT) {
+            usleep(CPR_RETRY_DELAY_US);
+        } else {
+            error_setg_errno(errp, errno,
+                "Unable to check status of socket path '%s'", path);
+            return false;
+        }
+    } while (--retries > 0);
+
+    error_setg(errp, "Socket path '%s' not found after %d retries",
+                                            path, CPR_MAX_RETRIES);
+    return false;
+}
+
 QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp)
 {
     MigrationAddress *addr = channel->addr;
@@ -28,6 +55,14 @@ QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp)
         QIOChannel *ioc = QIO_CHANNEL(sioc);
         SocketAddress *saddr = &addr->u.socket;
 
+        /*
+         * Verify that the cpr.sock Unix domain socket file exists and is ready
+         * before proceeding with the connection.
+         */
+        if (!cpr_validate_socket_path(addr->u.socket.u.q_unix.path, errp)) {
+            return NULL;
+        }
+
         if (qio_channel_socket_connect_sync(sioc, saddr, errp) < 0) {
             return NULL;
         }
-- 
2.49.0


