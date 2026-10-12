Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD17CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 23:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGPu6-0005hI-6f; Mon, 12 Oct 2026 19:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPu2-0005eo-2W
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:57:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPtz-0006Fn-9w
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:57:57 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CMhWDf1096788; Mon, 12 Oct 2026 23:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=IjyIj
 igLJ3Gienjs/gX9tr5e6M1XBRTtPCdE3EPoNJQ=; b=Tq6IECiNivC6kH2676Wqs
 0tBhj28Rnh8+0Rb46oC97J5THQmV+m0mbohZYEtyjJEYnXD9im3Ppm8gxrJd29Py
 7WGOZsx+hfc1V085xYsAsf6VKt+upnZsIz78IxJFIuB3cv9zBZdayLdASKlC3SP/
 xQo/isyLqR1iBGRvvDPt5D5Ki/2rgtWVHVoAHeLxTwLHXFv9mS4pERGjI8JIHSPl
 sGtz6u6D63NYFSSNIDCEmKszhGK/zK7rxyEtnoq63emKJQm9BW9NFIMbfyf4G76W
 wHgg48GFYryZaqtPg9D5mXcfwF9ttfAxhMm/HehuPl6n4g6iG67D2lcmC1bRmhM4
 Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7df7u5nq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:50 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 69CNpeoq015094; Mon, 12 Oct 2026 23:57:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4h7btnuhu1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:49 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CNvfHV025328;
 Mon, 12 Oct 2026 23:57:49 GMT
Received: from donglzha-e6-vfio-setup.osdevelopmeniad.oraclevcn.com
 (donglzha-e6-vfio-setup.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.255.69])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4h7btnuhra-13; Mon, 12 Oct 2026 23:57:49 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, maciej.szmigiero@oracle.com,
 peterx@redhat.com, farosas@suse.de, mark.kanda@oracle.com,
 bchaney@akamai.com, pierrick.bouvier@oss.qualcomm.com,
 alex@shazbot.org, clg@redhat.com, yi.l.liu@intel.com,
 eric.auger@redhat.com, zhenzhong.duan@intel.com, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com
Subject: [PATCH 12/21] migration/cpr-luo: add state fd helpers
Date: Mon, 12 Oct 2026 23:56:08 +0000
Message-ID: <20261012235727.398133-13-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261012235727.398133-1-dongli.zhang@oracle.com>
References: <20261012235727.398133-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610120095
X-Authority-Analysis: v=2.4 cv=N+a8hG9B c=1 sm=1 tr=0 ts=6acd73ff b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=AWsMrHjo68BcSfqt8SUA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfX8tJ4zRKGlgNf
 dRXIGgTcJ+q4QDG5TiqGQeQmSfDjCQwM4e0zzMWws4FX1xvPkwtlIeVKGbzacDgcLsWmxHm7bmI
 oV62qGyKNvzX7Epe5wT80QQTWu2oc2MW2iz8WU7/5kNu9Z3M/0woJv4kYHi6p5qBMruWB39z+6B
 h4MH29RgW4b+WNUQI3TrABOGxK32ua2DShDmJhu5yWYHoz9SuZo6AqrK0zFUYt8y4zbcajieMiq
 7hV8mzA6olP6joVUB5o+kKaYrXz19+vqOLVRTL0aJXtuGUNvvJJliqt4/yllSufBKHu78CPoYMO
 7XZTBrYaHnupTxrg+RQuqtr1z2ioizQSVPoRJRMpS7MESWgH3JUnVWgy9dty9mxN6rcaSTYI6YM
 qH+x8eFRDkAfl7Ca0nkK56C72uSs0Gd778fCzzunQKMoacmyVATZRNf5UjpfutkPYXaDcJ2qFc9
 7BZAuQ2H8jlrXFSw4WwC/OOapqEDD+MWK2XWlBM8=
X-Proofpoint-ORIG-GUID: 717C4nXrmAWYqsLLUMcnZhMkRXPfJTw1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfXxcyBjGPqHUqj
 UxQKnTXyKm1wQ8rXFXT45pgPAjPWpbBFOuEFJI9P/P8DGB/4UdPm/kQvj1gu3d+GYAK30KK42IV
 0kqqvLSR5E1fUmvI2EjkJJg6+fjNDgLTJe4QSJq/YsSO380Om1OT
X-Proofpoint-GUID: 717C4nXrmAWYqsLLUMcnZhMkRXPfJTw1
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

It is necessary to migrate fd information to the target QEMU instance.
cpr-exec preserves fd information in a memfd and uses an environment
variable to share the memfd with the target QEMU instance. cpr-transfer
uses a UNIX domain socket to pass fd information.

For cpr-luo, we save the fd information (i.e., names and tokens) in a
memfd and preserve the memfd using dedicated token 1.

Add helpers to create, preserve, and retrieve the cpr-luo state memfd.

Once the state memfd is preserved through LUO, it remains alive even if we
explicitly close it, until we explicitly close the session fd or terminate
the source QEMU instance.

The global session fd is stored at CprState.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 include/migration/cpr.h  |  5 ++++
 migration/cpr-luo-stub.c | 22 ++++++++++++++++
 migration/cpr-luo.c      | 57 ++++++++++++++++++++++++++++++++++++++++
 migration/cpr.c          |  4 ++-
 4 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 23751fc015..4897d302f1 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -36,6 +36,7 @@ typedef QLIST_HEAD(CprVFIODeviceList, CprVFIODevice) CprVFIODeviceList;
 typedef struct CprState {
     CprFdList fds;
     CprVFIODeviceList vfio_devices;
+    int luo_session_fd;
 } CprState;
 
 extern CprState cpr_state;
@@ -88,4 +89,8 @@ int cpr_luo_retrieve_session(const char *name, Error **errp);
 int cpr_luo_preserve_fd(int session_fd, int fd, uint64_t token,
                         Error **errp);
 int cpr_luo_retrieve_fd(int session_fd, uint64_t token, Error **errp);
+QEMUFile *cpr_luo_output(Error **errp);
+QEMUFile *cpr_luo_input(int session_fd, Error **errp);
+bool cpr_luo_persist_state(int session_fd, QEMUFile *f, Error **errp);
+void cpr_luo_abort(void);
 #endif
diff --git a/migration/cpr-luo-stub.c b/migration/cpr-luo-stub.c
index ab64e1f99b..fb2e649534 100644
--- a/migration/cpr-luo-stub.c
+++ b/migration/cpr-luo-stub.c
@@ -35,3 +35,25 @@ int cpr_luo_retrieve_fd(int session_fd, uint64_t token, Error **errp)
 {
     return cpr_luo_unsupported(errp);
 }
+
+QEMUFile *cpr_luo_output(Error **errp)
+{
+    cpr_luo_unsupported(errp);
+    return NULL;
+}
+
+QEMUFile *cpr_luo_input(int fd, Error **errp)
+{
+    cpr_luo_unsupported(errp);
+    return NULL;
+}
+
+bool cpr_luo_persist_state(int fd, QEMUFile *f, Error **errp)
+{
+    cpr_luo_unsupported(errp);
+    return false;
+}
+
+void cpr_luo_abort(void)
+{
+}
diff --git a/migration/cpr-luo.c b/migration/cpr-luo.c
index f6e0e23657..5b6bd6e191 100644
--- a/migration/cpr-luo.c
+++ b/migration/cpr-luo.c
@@ -8,9 +8,15 @@
 
 #include <sys/ioctl.h>
 
+#include "io/channel-file.h"
 #include "linux-headers/linux/liveupdate.h"
 #include "migration/cpr.h"
+#include "migration/qemu-file.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/memfd.h"
+
+#define CPR_LUO_STATE_NAME "QEMU_CPR_LUO_STATE"
 
 static int luo_open(Error **errp)
 {
@@ -105,3 +111,54 @@ int cpr_luo_retrieve_fd(int session_fd, uint64_t token, Error **errp)
 
     return retrieve.fd;
 }
+
+QEMUFile *cpr_luo_output(Error **errp)
+{
+    int fd = qemu_memfd_create(CPR_LUO_STATE_NAME, 0, false, 0, 0, errp);
+
+    if (fd < 0) {
+        return NULL;
+    }
+
+    return cpr_file_new_fd_output(fd, CPR_LUO_STATE_NAME);
+}
+
+QEMUFile *cpr_luo_input(int session_fd, Error **errp)
+{
+    int fd = cpr_luo_retrieve_fd(session_fd, CPR_LUO_STATE_TOKEN, errp);
+
+    if (fd < 0) {
+        return NULL;
+    }
+
+    lseek(fd, 0, SEEK_SET);
+    return cpr_file_new_fd_input(fd, CPR_LUO_STATE_NAME);
+}
+
+bool cpr_luo_persist_state(int session_fd, QEMUFile *f, Error **errp)
+{
+    QIOChannelFile *fioc = QIO_CHANNEL_FILE(qemu_file_get_ioc(f));
+
+    /*
+     * The file size (the memfd in this case) cannot be changed after it
+     * is preserved. Flush all data before preserving the state fd.
+     */
+    if (qemu_fflush(f) < 0) {
+        error_setg(errp, "failed to flush cpr-luo state");
+        return false;
+    }
+
+    return cpr_luo_preserve_fd(session_fd, fioc->fd,
+                               CPR_LUO_STATE_TOKEN, errp) == 0;
+}
+
+void cpr_luo_abort(void)
+{
+    int session_fd = cpr_state.luo_session_fd;
+
+    if (session_fd >= 0) {
+        close(session_fd);
+    }
+
+    cpr_state.luo_session_fd = -1;
+}
diff --git a/migration/cpr.c b/migration/cpr.c
index 3e8e94e5fe..2253fddb42 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -24,7 +24,9 @@
 /*************************************************************************/
 /* cpr state container for all information to be saved. */
 
-CprState cpr_state;
+CprState cpr_state = {
+    .luo_session_fd = -1,
+};
 static GHashTable *cpr_fds_hash;
 
 /****************************************************************************/
-- 
2.43.5


