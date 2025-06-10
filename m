Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7A3C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP26v-0001rN-FU; Tue, 10 Jun 2025 12:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP153-0004Ko-OA
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:05 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP14z-0005vN-Rl
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:04 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXYUf029083;
 Tue, 10 Jun 2025 15:39:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=uZGUXMSmbtq39efu63Sbazug68ZW/BBCBTfR+C7S4/I=; b=
 mwTazbvd6M/HD7aEgIZ0RAuNMTy5vAhMUe3gbV9ukaGUrsWWAsGZrdYOMEuogtZ8
 6inV9He45yV/7i8o1Pe8zvhO8kj/zAFcZSQUVSITsmewmUOy5Un8jclgigOWmaLM
 o/udzj+dSOK9zpuwSYCZb6Aw/Jp8yNNfUsABgKNj4T/W2kMgbYsQzDnVkzYfcjtN
 Ty116NpBi2dhbS8YiOmWDA/oOMu/quQ7PcAhY96Dccc6muCJkFOc/4yFJ38bYPEn
 08PzlfvpKBZR6q1gUC142NbyulSn+68zrn3+51KAUzW7syKBkcQdsT58aBKwwImP
 Vnrz2Wv/UQ+2bHKs7setWA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474d1v4jf2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:39:55 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55AEn3EJ003965; Tue, 10 Jun 2025 15:39:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv8wakw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:39:55 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AFdrf9028825;
 Tue, 10 Jun 2025 15:39:54 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 474bv8wak1-2; Tue, 10 Jun 2025 15:39:54 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 01/38] migration: cpr helpers
Date: Tue, 10 Jun 2025 08:39:14 -0700
Message-Id: <1749569991-25171-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100125
X-Proofpoint-GUID: IWpJTCzYJE7gszPnoySe5qk3ADGU_Z6i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyNiBTYWx0ZWRfX2Asm8iQxNp4v
 fIF+eHDBYM0cOnsj4+SF+HLyTmA6h6CUOxY8m9R17ici843/3hfRGO16mhpUFjXKJFDiddeAnFw
 BVb+bs2ZaFcYoZeCnZzsG71H4uXrrB8Z9R4/c6Ci9rqiXcuvor2ybPEW8I8KaAHZKTNuGADzY4i
 SzbpRzJtPmIYE/A8RbNocStj9KDOARmiP0dtXtYQNIGZeRIb7kq6ugBabZ6sg7lmgzJK64NAD6T
 M4undAA0GqKwBjRaKtmXWzN7FPsl7fyuby4b5TPfB+WCbjwp4HXNSV0pNW6lHuzNOoSZUV0tnkF
 nN54W840IOTXFXS4U/q2g9N51BaT/00eS/II4Q77bPKjDhOs/DqzWxWlU6xBagl1RZ3nyPCHUFq
 S5l8/l9X3cOWpV+rHRbIB6BXMJXBIQXfbm6QAVRPYwvZEuji5qH+gFlV2hjWHRePp76+0q3W
X-Proofpoint-ORIG-GUID: IWpJTCzYJE7gszPnoySe5qk3ADGU_Z6i
X-Authority-Analysis: v=2.4 cv=d731yQjE c=1 sm=1 tr=0 ts=684851cb b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=carzgWJGtDMVDRLNIhcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add the cpr_incoming_needed, cpr_open_fd, and cpr_resave_fd helpers,
for use when adding cpr support for vfio and iommufd.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/migration/cpr.h |  5 +++++
 migration/cpr.c         | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 7561fc7..07858e9 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -18,6 +18,9 @@
 void cpr_save_fd(const char *name, int id, int fd);
 void cpr_delete_fd(const char *name, int id);
 int cpr_find_fd(const char *name, int id);
+void cpr_resave_fd(const char *name, int id, int fd);
+int cpr_open_fd(const char *path, int flags, const char *name, int id,
+                Error **errp);
 
 MigMode cpr_get_incoming_mode(void);
 void cpr_set_incoming_mode(MigMode mode);
@@ -28,6 +31,8 @@ int cpr_state_load(MigrationChannel *channel, Error **errp);
 void cpr_state_close(void);
 struct QIOChannel *cpr_state_ioc(void);
 
+bool cpr_incoming_needed(void *opaque);
+
 QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
 QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
 
diff --git a/migration/cpr.c b/migration/cpr.c
index 42c4656..a50a57e 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -95,6 +95,36 @@ int cpr_find_fd(const char *name, int id)
     trace_cpr_find_fd(name, id, fd);
     return fd;
 }
+
+void cpr_resave_fd(const char *name, int id, int fd)
+{
+    CprFd *elem = find_fd(&cpr_state.fds, name, id);
+    int old_fd = elem ? elem->fd : -1;
+
+    if (old_fd < 0) {
+        cpr_save_fd(name, id, fd);
+    } else if (old_fd != fd) {
+        error_setg(&error_fatal,
+                   "internal error: cpr fd '%s' id %d value %d "
+                   "already saved with a different value %d",
+                   name, id, fd, old_fd);
+    }
+}
+
+int cpr_open_fd(const char *path, int flags, const char *name, int id,
+                Error **errp)
+{
+    int fd = cpr_find_fd(name, id);
+
+    if (fd < 0) {
+        fd = qemu_open(path, flags, errp);
+        if (fd >= 0) {
+            cpr_save_fd(name, id, fd);
+        }
+    }
+    return fd;
+}
+
 /*************************************************************************/
 #define CPR_STATE "CprState"
 
@@ -228,3 +258,9 @@ void cpr_state_close(void)
         cpr_state_file = NULL;
     }
 }
+
+bool cpr_incoming_needed(void *opaque)
+{
+    MigMode mode = migrate_mode();
+    return mode == MIG_MODE_CPR_TRANSFER;
+}
-- 
1.8.3.1


