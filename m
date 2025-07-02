Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8E7C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 22:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX5Tz-0003Oc-Gk; Wed, 02 Jul 2025 17:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5Tw-0003NB-Ou
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5Tu-0003eh-IO
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:08 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562LQdeX014113;
 Wed, 2 Jul 2025 21:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=K9Cr+WwDzYFyrMScvxDpCli0GEbYl8olOvU5EQz9sZg=; b=
 g8jHSziksBlihccNo03tqXcjLyFb0K76V3ev2Gmg6IjkGArp84RVFMPFu8+ijPLu
 Yt1LCmMIKvYCBJilHvtE2+OqvnEsldFJwupI3dq7lXohdGz16V6VOjWWBlAnYcfi
 +P4Is5IyT1RtQD8/KKMip/OcQN/TwypY7P/b0B6hBABeVlpUZNsiYUIbE98ebKlw
 UwvptrY9G1xN4S5H9XbOXU8FhYrwxcyanCRuGQObTXvbrg4tvoHX4yGl9bXOnin7
 8K7ILPJSTNsO+l42eR/ygmvtV8YAhJK5MgmjzwSbmrIkQbYZZQQX3MlFwMoDYZlp
 HPrO9hmD2qw9WdPnc+fuJg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j704fxkr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:03 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562Lt1rm033641; Wed, 2 Jul 2025 21:59:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6ubtd0w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:03 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 562Lwxg2020012;
 Wed, 2 Jul 2025 21:59:02 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47j6ubtcxb-5; Wed, 02 Jul 2025 21:59:02 +0000
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
Subject: [PATCH V6 04/21] migration: cpr_get_fd_param helper
Date: Wed,  2 Jul 2025 14:58:41 -0700
Message-Id: <1751493538-202042-5-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
References: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020182
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE4MiBTYWx0ZWRfX/0bxD0jWuAvX
 MANgzENymiHZVdHIdEiEIriF5ISqRLPPdMBwJar6oi6ATmvDfXX38OChEU3a1S5Xcq/sdzjryMG
 DQeixpzA++7OPsUyZQCngwKdjsMtHKaqIneoruBKi+xD5LniJkusmBNhfV6D5zSmOEkHmVxMHCw
 3uu1i/qI8y7MQew3HhGeI9lNGjI32dug12nsFT/V1QIz+NCPhmurhoa1BolhzJe+1Bfte6IvN6b
 cZQwDc9jXRVkIFRFvkjIeWXFgd4gqut0do7q9oCy2nFVr3VjWsgj4t/pKxudx5O2AJvIowupJQe
 k41N3ORaiFkKBjeRByiqGnsCaT+AAfZWaSNaUMKL8x8RZzAYDVHyLywjlSib61x73aem0SkfF5A
 01kP9IoFVpT/bXfaC0Xn7+vSLFNlwr67H6cea0WgO+33diow6CwPgEA/lMbqUV/LeJSPLkoo
X-Authority-Analysis: v=2.4 cv=LcU86ifi c=1 sm=1 tr=0 ts=6865aba7 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=xj5pLq7tU-gV2qsf3bMA:9
X-Proofpoint-GUID: YhOfrRgr4FbD6MSTQzx1IhzGCvvl0vJg
X-Proofpoint-ORIG-GUID: YhOfrRgr4FbD6MSTQzx1IhzGCvvl0vJg
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
index 07858e9..eb27a93 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -32,6 +32,8 @@ void cpr_state_close(void);
 struct QIOChannel *cpr_state_ioc(void);
 
 bool cpr_incoming_needed(void *opaque);
+int cpr_get_fd_param(const char *name, const char *fdname, int index,
+                     Error **errp);
 
 QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
 QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
diff --git a/migration/cpr.c b/migration/cpr.c
index a50a57e..535d587 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -13,6 +13,7 @@
 #include "migration/qemu-file.h"
 #include "migration/savevm.h"
 #include "migration/vmstate.h"
+#include "monitor/monitor.h"
 #include "system/runstate.h"
 #include "trace.h"
 
@@ -264,3 +265,39 @@ bool cpr_incoming_needed(void *opaque)
     MigMode mode = migrate_mode();
     return mode == MIG_MODE_CPR_TRANSFER;
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


