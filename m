Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18E3C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwSm-0004Kp-OD; Fri, 14 Feb 2025 09:14:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwSk-0004IU-7a
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:14:38 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwSi-0004Qk-0g
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:14:37 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECtS7f028514;
 Fri, 14 Feb 2025 14:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=mEVPWwF+UfGeyFbKqf1xWpPBvuAXnhWIm3FJAkaKpMI=; b=
 kFDbSWYruligitQdjUU2emtdLh9rtr5G69DwQoTUNDMmLbeMWQRHYP+dNCuQyqx6
 xila1niW4Out3nzVpo4LlnOq7Q8iR/9cuIOT1YE74UHX2R+ZeKqJ6jke0Q74QeR4
 /f+iw885AwryjNzoZkJQTwKB8CeeHS6iIOqHCS2avb+60++feGZG2fb/h8ZMlasC
 rSxzMIY5dmwK6kOUNj7W2S+S3BcQc+/aHIuiE4oMT8jwiley8PG11F0GtYXPTipS
 gLuyUkthP2/bzG4IK/2Z5vy+F5CFJyBsp3fsLliRZESms6B29BP1hWclHR6XBpyA
 R9WqUWjZD90COfjG9pXMaw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tnbnmm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:14:33 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51EC9vVV025116; Fri, 14 Feb 2025 14:14:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqksg4c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:14:32 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51EEETPH006920;
 Fri, 14 Feb 2025 14:14:32 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 44nwqksg2h-3; Fri, 14 Feb 2025 14:14:31 +0000
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
Subject: [PATCH V2 02/45] migration: cpr helpers
Date: Fri, 14 Feb 2025 06:13:44 -0800
Message-Id: <1739542467-226739-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140104
X-Proofpoint-GUID: ynDWCEE5sMpbu2o6pTGYT7jDRpIrL9QG
X-Proofpoint-ORIG-GUID: ynDWCEE5sMpbu2o6pTGYT7jDRpIrL9QG
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add cpr_needed_for_reuse, cpr_resave_fd helpers, cpr_is_incoming, and
cpr_open_fd, for use when adding cpr support for vfio and iommufd.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/cpr.h |  6 ++++++
 migration/cpr.c         | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 3a6deb7..6ad04d4 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -18,15 +18,21 @@
 void cpr_save_fd(const char *name, int id, int fd);
 void cpr_delete_fd(const char *name, int id);
 int cpr_find_fd(const char *name, int id);
+void cpr_resave_fd(const char *name, int id, int fd);
+int cpr_open_fd(const char *path, int flags, const char *name, int id,
+                bool *reused, Error **errp);
 
 MigMode cpr_get_incoming_mode(void);
 void cpr_set_incoming_mode(MigMode mode);
+bool cpr_is_incoming(void);
 
 int cpr_state_save(MigrationChannel *channel, Error **errp);
 int cpr_state_load(MigrationChannel *channel, Error **errp);
 void cpr_state_close(void);
 struct QIOChannel *cpr_state_ioc(void);
 
+bool cpr_needed_for_reuse(void *opaque);
+
 QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
 QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
 
diff --git a/migration/cpr.c b/migration/cpr.c
index 584b0b9..12c489b 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -95,6 +95,39 @@ int cpr_find_fd(const char *name, int id)
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
+                bool *reused, Error **errp)
+{
+    int fd = cpr_find_fd(name, id);
+
+    if (reused) {
+        *reused = (fd >= 0);
+    }
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
 
@@ -128,6 +161,11 @@ void cpr_set_incoming_mode(MigMode mode)
     incoming_mode = mode;
 }
 
+bool cpr_is_incoming(void)
+{
+    return incoming_mode != MIG_MODE_NONE;
+}
+
 int cpr_state_save(MigrationChannel *channel, Error **errp)
 {
     int ret;
@@ -222,3 +260,9 @@ void cpr_state_close(void)
         cpr_state_file = NULL;
     }
 }
+
+bool cpr_needed_for_reuse(void *opaque)
+{
+    MigMode mode = migrate_mode();
+    return mode == MIG_MODE_CPR_TRANSFER;
+}
-- 
1.8.3.1


