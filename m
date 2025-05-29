Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE38C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKisQ-0004Cv-JN; Thu, 29 May 2025 15:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisJ-00047u-BH
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:11 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisF-0000QL-7r
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:10 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfpx7022094;
 Thu, 29 May 2025 19:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=ZBnuRiGNb3IW9ufqKm9Mzf1gmIUYumg/Y7/g89K/NSs=; b=
 ZP7blGGDKXBAWRNH1Mj/+/hVCpSZ7VlMITQZfEe19PX0wVbWDFKpGqDuTt20lHry
 3d0zMy6o9ZUxS2M6evsuXyM7z3Y6OAVz/+nq/F7YrGuNU8ewcgj1I1fIHicojbl1
 YNbAcI4hAQfRBvbChXSMp+U/YNcLASVlMW3F0CfhACPaomCOV2U+YgpvVVnckz8R
 YpABqSmEvWkq097JDXBKfOdIPU46doVP1qAe5wVV3Sm/Nzzulna85pyGqIle8HT3
 77N5ydp5Z3OrLgCuVFNb8largYZGixf63Wm/f0C0IFMAowXUbD4OKo+zrPNQbJEJ
 mJ1Wo83MozZxpDrcgXAsSw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0g2h185-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:04 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54TJLPvE020301; Thu, 29 May 2025 19:25:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4vyr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:03 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeRf022158;
 Thu, 29 May 2025 19:25:02 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-28; Thu, 29 May 2025 19:25:02 +0000
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
Subject: [PATCH V4 27/43] migration: cpr_get_fd_param helper
Date: Thu, 29 May 2025 12:24:23 -0700
Message-Id: <1748546679-154091-28-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_09,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290189
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfX8xDk5cWyC2kQ
 9nLmn0EzeY28a2FyfJJLp5dcBTyNaCuqSfeDYT2lPg3yRVwWM3zi/Zt15Wj+i3FvIGUiD9Z8mGb
 cQxdVqxdWoOOUcjn29AwMy1AfHpNxZHTYMiGt+HGPtc8Rf5KmuLllZQvguP431kzpcWrSo5XfHJ
 31Q9EtsTwhNkzsBIbFjCneP1rZ1mPkt3v7Rcl2DH5whUPEnBnddc8Sf0z7MyKaoZRk8eQ0mNBCB
 d1ujw+4M22xpLiE4fqcWnzIcVDF19svlI8EZvoTIpqg0o0UZvBndSkFfYMwvoP+qdPLZBp1jJVN
 nKIuyJ7yLOGQ4fntuld1Ozfky384GkVJeNBQABHwEjVCb4/nGOf47msHu1jewG0fMrkSZzWN0v+
 /lioKdBk/j9kjEhJYfUXAbuI82D+azWwNKyGOVrnjn2n/lhUdtSxN7fz4xiiQ9NSvK3DJwJG
X-Authority-Analysis: v=2.4 cv=NJLV+16g c=1 sm=1 tr=0 ts=6838b490 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=xj5pLq7tU-gV2qsf3bMA:9
X-Proofpoint-ORIG-GUID: 65WZ-QqrgIMM_mv1p7G1uoR0TgRKcsWn
X-Proofpoint-GUID: 65WZ-QqrgIMM_mv1p7G1uoR0TgRKcsWn
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/cpr.h |  2 ++
 migration/cpr.c         | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index d09b657..7fd8065 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -33,6 +33,8 @@ struct QIOChannel *cpr_state_ioc(void);
 
 bool cpr_incoming_needed(void *opaque);
 void cpr_kvm_close(void);
+int cpr_get_fd_param(const char *name, const char *fdname, int index,
+                     Error **errp);
 
 void cpr_transfer_init(void);
 QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
diff --git a/migration/cpr.c b/migration/cpr.c
index 49fb0a5..4574608 100644
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
@@ -272,3 +273,39 @@ void cpr_kvm_close(void)
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
+ * @errp: returned error message
+ *
+ * If CPR is not being performed, then use @fdname to find the fd.
+ * If CPR is being performed, then ignore @fdname, and look for @name
+ * and @index in CPR state.
+ *
+ * On success returns the fd value, else returns -1.
+ */
+int cpr_get_fd_param(const char *name, const char *fdname, int index,
+                     Error **errp)
+{
+    ERRP_GUARD();
+    int fd;
+
+    if (cpr_is_incoming()) {
+        fd = cpr_find_fd(name, index);
+        if (fd < 0) {
+            error_setg(errp, "cannot find saved value for fd %s", fdname);
+        }
+    } else {
+        fd = monitor_fd_param(monitor_cur(), fdname, errp);
+        if (fd >= 0) {
+            cpr_save_fd(name, index, fd);
+        } else {
+            error_prepend(errp, "Could not parse object fd %s:", fdname);
+        }
+    }
+    return fd;
+}
-- 
1.8.3.1


