Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1275CA0FE4
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 11:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk0FK-0007VK-0l; Fri, 30 Aug 2024 07:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sk0FD-0007JJ-Al
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:56:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sk0FA-0002rV-Fz
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:56:46 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U7tVM6014619;
 Fri, 30 Aug 2024 11:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=t08mOsZ64EUWO6kYmUjbH59vvPkEfVV+gDSxH4efXhI=; b=
 aK4x0cbd807BAqsayROfyft/tRCO3/ToFqnrNyLw8vlriKkzG0TgKh9EzMTAIrGk
 8PJPscjGmeH/yj5TFq6rXkrZDtsBx4Sgt3nz9Niy4SqSIkEpthxa6jsF01PgaR1a
 gGUb4dXbfZ+fP0r+VtLcOpHhh66r2BwdF9FMUP5wi989qmUVZfWXZTEtJl5gImlV
 ZDDWwzRVREcUB0SLmNuYCauGXMEDsUwoxT9xGGKBIeGxGfqzGF9BP3+z0H9cm8xe
 EmKNGPpAIaIH17K5J+J5NFuG+3tz+LoXxf5dUgRefPM+N/zZOBLl2FYxLq7XYqQj
 eDtiyatTxM0+wLMB9AYe/Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pugxg1b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Aug 2024 11:56:43 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 47UArKZo036567; Fri, 30 Aug 2024 11:56:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4189jpg9d0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Aug 2024 11:56:42 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47UBucxO028887;
 Fri, 30 Aug 2024 11:56:42 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 4189jpg9ae-5; Fri, 30 Aug 2024 11:56:42 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Euan Turner <euan.turner@nutanix.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 4/6] migration: cpr_get_fd_param helper
Date: Fri, 30 Aug 2024 04:56:35 -0700
Message-Id: <1725018997-363706-5-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1725018997-363706-1-git-send-email-steven.sistare@oracle.com>
References: <1725018997-363706-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_06,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300090
X-Proofpoint-GUID: At_FfmOTgp4eWg-cOiJQuDg-B1ZSf7SZ
X-Proofpoint-ORIG-GUID: At_FfmOTgp4eWg-cOiJQuDg-B1ZSf7SZ
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add the helper function cpr_get_fd_param, for use by tap and vdpa.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/cpr.h |  2 ++
 migration/cpr.c         | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 9a76365..b5fa264 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -27,6 +27,8 @@ void cpr_set_cpr_uri(const char *uri);
 int cpr_state_save(Error **errp);
 int cpr_state_load(Error **errp);
 bool cpr_needed_for_reuse(void *opaque);
+int cpr_get_fd_param(const char *name, const char *fdname,
+                     int index, Error **errp);
 
 QEMUFile *cpr_exec_output(Error **errp);
 QEMUFile *cpr_exec_input(Error **errp);
diff --git a/migration/cpr.c b/migration/cpr.c
index 096d684..0940ee2 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -13,6 +13,7 @@
 #include "migration/qemu-file.h"
 #include "migration/savevm.h"
 #include "migration/vmstate.h"
+#include "monitor/monitor.h"
 #include "sysemu/runstate.h"
 #include "trace.h"
 
@@ -268,3 +269,28 @@ bool cpr_needed_for_reuse(void *opaque)
     MigMode mode = migrate_mode();
     return mode == MIG_MODE_CPR_EXEC || mode == MIG_MODE_CPR_TRANSFER;
 }
+
+int cpr_get_fd_param(const char *name, const char *fdname, int index,
+                     Error **errp)
+{
+    int fd;
+
+    /*
+     * fd's are passed by name to the monitor when a NIC is hot plugged, but
+     * the name is not known to qemu after cpr.  The manager can pass -1 for
+     * the fd "name" in the new qemu args to indicate that qemu should search
+     * for a saved name.
+     */
+    if (!strcmp(fdname, "-1")) {
+        fd = cpr_find_fd(name, index);
+        if (fd < 0) {
+            error_setg(errp, "cannot find saved value for fd %s", fdname);
+        }
+    } else {
+        fd = monitor_fd_param(monitor_cur(), fdname, errp);
+    }
+    if (fd >= 0) {
+        cpr_resave_fd(name, index, fd);
+    }
+    return fd;
+}
-- 
1.8.3.1


