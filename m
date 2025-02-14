Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F33C021A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwTl-0006EX-Mr; Fri, 14 Feb 2025 09:15:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwTS-00060J-3b
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:15:22 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwTQ-0004hX-7T
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:15:21 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECtqIr019380;
 Fri, 14 Feb 2025 14:15:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=fwO6yKzZT3BvW6kLmf13EnVUAuSfTwaAxRHjTF7t7OU=; b=
 AdmKBmE2GDh31wrtbpvFxnsrlrE46FtkwoZhPQO8Sni/q8LNwwn5XDy95DG62k/E
 a6LybqYn6ZouFVcT2vONz8islFQBcRmgb/Rb1etPeXmbumWivLbk624V/Qs+JaUN
 mrJRYnX5/DSiLn1y471wnee4z6lNXv9frppYdL3vfjmF2IGWI9w/r/XVLs80Ykvu
 +7grKjoIcKPREsQBIjE9CqXKgKTID2WThlosf1iE5pywiC/8yXOoYu06qS71Rm5G
 j3yk4HHdMNsF4qwwMMm9q1Q6388jP0ZyDjwE+S5mwKJUy9BD3rKNgmV+/K0grKsL
 QZw8HbnB8XPdqr28ci/tyw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0t4bmv4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:15:07 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51ECSnir025242; Fri, 14 Feb 2025 14:15:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqksgqy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:15:06 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51EEETQ7006920;
 Fri, 14 Feb 2025 14:15:05 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 44nwqksg2h-28; Fri, 14 Feb 2025 14:15:05 +0000
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
Subject: [PATCH V2 27/45] migration: cpr_get_fd_param helper
Date: Fri, 14 Feb 2025 06:14:09 -0800
Message-Id: <1739542467-226739-28-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: swOtxUWr5BrwHFzqZuKiNheOFV1v5YXh
X-Proofpoint-GUID: swOtxUWr5BrwHFzqZuKiNheOFV1v5YXh
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

Add the helper function cpr_get_fd_param, to use when preserving
a file descriptor that is opened externally and passed to QEMU.
cpr_get_fd_param returns a descriptor number either from a QEMU
command-line parameter, from a getfd command, or from CPR state.

When a descriptor is passed to new QEMU via SCM_RIGHTS, its number
changes.  Hence, during CPR, the command-line parameter is ignored
in new QEMU, and over-ridden by the value found in CPR state.

Similarly, if the descriptor was originally specified by a getfd
command in old QEMU, the fd number is not known outside of QEMU,
and it changes when sent to new QEMU via SCM_RIGHTS.  Hence the
user cannot send getfd to new QEMU, but when the user sends a
hotplug command that references the fd, cpr_get_fd_param finds
its value in CPR state.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/cpr.h |  2 ++
 migration/cpr.c         | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index c5c191d..23d0af4 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -33,6 +33,8 @@ struct QIOChannel *cpr_state_ioc(void);
 
 bool cpr_needed_for_reuse(void *opaque);
 void cpr_kvm_close(void);
+int cpr_get_fd_param(const char *name, const char *fdname, int index,
+                     bool *reused, Error **errp);
 
 void cpr_transfer_init(void);
 QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
diff --git a/migration/cpr.c b/migration/cpr.c
index 351e12d..c903b24 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -14,6 +14,7 @@
 #include "migration/qemu-file.h"
 #include "migration/savevm.h"
 #include "migration/vmstate.h"
+#include "monitor/monitor.h"
 #include "system/kvm.h"
 #include "system/runstate.h"
 #include "trace.h"
@@ -274,3 +275,42 @@ void cpr_kvm_close(void)
     kvm_close();
     vfio_kvm_device_close();
 }
+
+/*
+ * cpr_get_fd_param: find a descriptor and return its value.
+ *
+ * @name: CPR name for the descriptor
+ * @fdname: An integer-valued string, or a name passed to a getfd command
+ * @index: CPR index of the descriptor
+ * @reused: returns true if the fd is found in CPR state, else false.
+ * @errp: returned error message
+ *
+ * If CPR is not being performed, then use @fdname to find the fd.
+ * If CPR is being performed, then ignore @fdname, and look for @name
+ * and @index in CPR state.
+ *
+ * On success returns the fd value, else returns -1.
+ */
+int cpr_get_fd_param(const char *name, const char *fdname, int index,
+                     bool *reused, Error **errp)
+{
+    ERRP_GUARD();
+    int fd;
+
+    if (cpr_is_incoming()) {
+        fd = cpr_find_fd(name, index);
+        if (fd < 0) {
+            error_setg(errp, "cannot find saved value for fd %s", fdname);
+        }
+        *reused = true;
+    } else {
+        fd = monitor_fd_param(monitor_cur(), fdname, errp);
+        if (fd >= 0) {
+            cpr_save_fd(name, index, fd);
+        } else {
+            error_prepend(errp, "Could not parse object fd %s:", fdname);
+        }
+        *reused = false;
+    }
+    return fd;
+}
-- 
1.8.3.1


