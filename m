Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264E2C5B543
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKis2-0003z7-Lx; Thu, 29 May 2025 15:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKirz-0003xm-JE
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:24:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKirw-0000By-N0
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:24:51 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGftKg028811;
 Thu, 29 May 2025 19:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=uZGUXMSmbtq39efu63Sbazug68ZW/BBCBTfR+C7S4/I=; b=
 NxapDXQ5ouzrdo0d7CAAeAxeI1KYgBgt3RPR3KhQD1MfEptsYo50epNiHHgI3k1H
 0rRoEH/NZXNtmTa7PNO+3CoISJCZy03qrNN2hdyC7+SM1GrkAi0TftwbKopMv9sC
 E+jWCohAk44t86KoTFy6QYgTGrt28L234XDSQvjej/2Qf2q7SP7iHVrsdcCfIWlS
 Ytg4CW6n8EuEySmLZaFts53JVe2qYY6Vm7KU5Dxj+1MZLBEDRXxD0Sj7k69KWmcE
 26FYOwEJUygd4KseKA7OKwGBrDXASGlGDh6IN6ST06wHCkoZY54f0oAh/qLqX2ko
 /ym+CXyAg0NJCo+xu+JGMA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v3pd8qw5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:46 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54THg2aq020361; Thu, 29 May 2025 19:24:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4vnd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:45 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeQv022158;
 Thu, 29 May 2025 19:24:44 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-6; Thu, 29 May 2025 19:24:44 +0000
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
Subject: [PATCH V4 05/43] migration: cpr helpers
Date: Thu, 29 May 2025 12:24:01 -0700
Message-Id: <1748546679-154091-6-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_09,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290189
X-Proofpoint-ORIG-GUID: deDKzVWDNXYwdlmCXtvrkSuSG48kYrpA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfXwJ/i1NgTSgIs
 DeYqCg6aXvvWhVoO123yISu6tYMTKI19JwdjnwOYtg73HWi7178C2ViJYGbKuk/2bZF2r/B+hE3
 5jSY2/9WrXhaW6XfXABw2nq79hyIFP2EyXYuYH41g2KJpG5mx9/uiF5mdCt2qk21otTeZ3XDGEw
 GhllNUCJMCdvV+dp6F9mFPH6iu8R9qDlPmojm560v6p+MA4H9uyWXKOMcWn6V3CTMBKsezALkU9
 O51WrJs+QvTs6ogu7cowM0qU7bWPZ0CcjWLvpLteHRLXDyg5DZ1bm+PWRNv9RhVsDarYdGYNBZU
 mo0QQU7Yuhnt5wQy5SS/HezwOvMTLiYwyo1gHAsdpn3FGEiSrRn7gDFDXxWxhS0plV8ZebL93T0
 0TzLAHCcWDuDxUFwZGUGOsJOGxJzQGRF8LS7iuFJEMB+Y/micrEjkmgQ/4oKpDk9hR6Ho1jz
X-Authority-Analysis: v=2.4 cv=UZNRSLSN c=1 sm=1 tr=0 ts=6838b47e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=carzgWJGtDMVDRLNIhcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: deDKzVWDNXYwdlmCXtvrkSuSG48kYrpA
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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


