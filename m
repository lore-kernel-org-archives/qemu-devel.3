Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59F2C5DF67
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 23:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuIRL-0004SI-QY; Wed, 12 Aug 2026 19:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wuIRF-0004Pb-NP
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 19:32:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wuIRB-0001S8-VI
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 19:32:49 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CEolwK882217; Wed, 12 Aug 2026 23:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=NHGL6
 gqgzgo4eylSEkzkqCivtUSlItAo/tb0HO7TG5E=; b=BB08GFGD4wiOIe2Q1Z0yr
 R7S/3NEhHFU7thDzdI6aH43RE5mgNwC8LTtnBVm/T1odf+bYn81OmOKZq7Us93mt
 3mpaAxOBGv1HQCDziwsSm0rSKLhlXBPkrkkTbtTsQ+4Yz4P6a+67ysYo+CdHnDE9
 HV0SPT2ZElEiXEFcuhaiMU7tYeQOJA2v8KAWaSK8DkiRbA7XpuAEERKif+NRPKMW
 A97I9KB2CBTVkM84I6Z8KpzLEydZtA26KZ8bjtx8a0qou1fp6iZ+luaFkuBsRmHv
 xpQsmGcAg+R7xPJ6dCBDQNQ7W6u/l8e790DpwRmuqKb3KZL/leirsoV6mOOz642i
 Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fwvfxyncj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 23:32:41 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 67CNTxLW017409; Wed, 12 Aug 2026 23:32:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4fwtwfngs4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 23:32:40 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67CNWbHc025569;
 Wed, 12 Aug 2026 23:32:39 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4fwtwfngqu-4; Wed, 12 Aug 2026 23:32:39 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com, 
 maciej.szmigiero@oracle.com, mark.kanda@oracle.com, bchaney@akamai.com,
 pierrick.bouvier@oss.qualcomm.com, joe.jin@oracle.com
Subject: [PATCH 3/5] migration/cpr-exec: Add memfd helpers
Date: Wed, 12 Aug 2026 16:27:48 -0700
Message-ID: <20260812232842.470225-4-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260812232842.470225-1-dongli.zhang@oracle.com>
References: <20260812232842.470225-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_07,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 spamscore=0
 phishscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608120190
X-Proofpoint-GUID: bJHAlme1hr80meaLcwBwka_lhBVZYZ8o
X-Authority-Analysis: v=2.4 cv=K/sS2SWI c=1 sm=1 tr=0 ts=6a7d0299 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=JsEZA-e_2lCJjq3I3kcA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: bJHAlme1hr80meaLcwBwka_lhBVZYZ8o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE5MCBTYWx0ZWRfX46KF9TlN3FgR
 ViLFyZIDa1adrIeyjA4PXlhv30EhRsX26OusRpG1rueOpvcM+OVs7V0ipQjwP3goQIFxBgUz+yt
 QPyuB+jfoyj4COhzt0DsjBnfRjX40LA56aN/Hzk6lbEnxyTgX4NWjJ9V84M5oljEgr9KWoyRxWn
 rost/eoBJrGtuwv/vJMwuR8FWACughIIWdno8kd6BiyPw/JzhopZQK6q7XUoVmi/5UByAHStpdd
 CWH+36mauoVcJ3EN3Pcxr2WE/eKGv4wWb8Vx9NvTiJTkm0qENntZx3dFV3vIArX1+eVRaFUDl/4
 +M2se+uBjOhgXUMk2gQYT4CjetyZwuTjeuyP3bL8siYHWS6YpImXsHfuvWNvoAKlz83seebHnVC
 ujgFkYKblS2rs18rc/jVm/szfAc64YwwupT4UKEIjHLnt34sfOPG7do0CAg+FGGhJOQqRXG/+cA
 E8GsyCHRrEvavNzgYCw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE5MCBTYWx0ZWRfX+RKdDkCV9BIZ
 Y8ICK6K0ljCiPIa3A7Wwut8Y1EY/BeeP1CV+9M18u3O+eHhFjGR7ucznpOrx9+I5GigZL3PbKOw
 dKWSWFxlYVP5PRRP0Ca9KYaQjdC36nYr3+7MuYd7mXn1EE6H4Z+2
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add cpr-exec specific helpers for using a memfd as the main migration state
channel. The helpers create the outgoing memfd channel, preserve the
duplicated fd across exec via an environment variable, claim the fd on the
incoming side, and clean up the saved fd on failure paths.

The generic memfd helper remains unchanged. The cpr-exec specific helpers
use it for channel creation and keep exec inheritance local to cpr-exec.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 migration/cpr-exec-memfd.c | 90 ++++++++++++++++++++++++++++++++++++++
 migration/cpr-exec-memfd.h | 18 ++++++++
 migration/meson.build      |  1 +
 3 files changed, 109 insertions(+)
 create mode 100644 migration/cpr-exec-memfd.c
 create mode 100644 migration/cpr-exec-memfd.h

diff --git a/migration/cpr-exec-memfd.c b/migration/cpr-exec-memfd.c
new file mode 100644
index 0000000000..2bc15f644e
--- /dev/null
+++ b/migration/cpr-exec-memfd.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * CPR exec migration via memfd
+ *
+ * Copyright (c) 2026 Oracle and/or its affiliates.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/cutils.h"
+#include "channel.h"
+#include "cpr-exec-memfd.h"
+#include "memfd.h"
+
+#define CPR_EXEC_MEMFD_NAME "qemu-cpr-exec-migration"
+#define CPR_EXEC_MEMFD_ENV "QEMU_CPR_EXEC_MIGRATION_FD"
+
+static int cpr_exec_memfd_fd = -1;
+
+static int cpr_exec_memfd_claim_fd(Error **errp)
+{
+    const char *val = g_getenv(CPR_EXEC_MEMFD_ENV);
+    int fd;
+
+    if (!val) {
+        error_setg(errp, "missing %s environment variable",
+                   CPR_EXEC_MEMFD_ENV);
+        return -1;
+    }
+
+    if (qemu_strtoi(val, NULL, 10, &fd) < 0) {
+        error_setg(errp, "bad %s value %s", CPR_EXEC_MEMFD_ENV, val);
+        return -1;
+    }
+
+    g_unsetenv(CPR_EXEC_MEMFD_ENV);
+    return fd;
+}
+
+QIOChannel *cpr_exec_memfd_connect_outgoing(Error **errp)
+{
+    return memfd_create_outgoing(CPR_EXEC_MEMFD_NAME, &cpr_exec_memfd_fd,
+                                 errp);
+}
+
+void cpr_exec_memfd_connect_incoming(Error **errp)
+{
+    g_autoptr(QIOChannel) ioc = NULL;
+    int fd = cpr_exec_memfd_claim_fd(errp);
+
+    if (fd < 0) {
+        return;
+    }
+
+    ioc = memfd_open_incoming(fd, CPR_EXEC_MEMFD_NAME, errp);
+    if (!ioc) {
+        return;
+    }
+
+    migration_channel_process_incoming(ioc);
+}
+
+bool cpr_exec_memfd_preserve_fd(Error **errp)
+{
+    char val[16];
+
+    if (cpr_exec_memfd_fd < 0) {
+        return true;
+    }
+
+    qemu_clear_cloexec(cpr_exec_memfd_fd);
+    snprintf(val, sizeof(val), "%d", cpr_exec_memfd_fd);
+    if (!g_setenv(CPR_EXEC_MEMFD_ENV, val, 1)) {
+        error_setg(errp, "Setting env %s = %s failed",
+                   CPR_EXEC_MEMFD_ENV, val);
+        return false;
+    }
+
+    return true;
+}
+
+void cpr_exec_memfd_cleanup(void)
+{
+    g_unsetenv(CPR_EXEC_MEMFD_ENV);
+
+    if (cpr_exec_memfd_fd >= 0) {
+        close(cpr_exec_memfd_fd);
+        cpr_exec_memfd_fd = -1;
+    }
+}
diff --git a/migration/cpr-exec-memfd.h b/migration/cpr-exec-memfd.h
new file mode 100644
index 0000000000..1c74c7bfde
--- /dev/null
+++ b/migration/cpr-exec-memfd.h
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * CPR exec migration via memfd
+ *
+ * Copyright (c) 2026 Oracle and/or its affiliates.
+ */
+
+#ifndef QEMU_MIGRATION_CPR_EXEC_MEMFD_H
+#define QEMU_MIGRATION_CPR_EXEC_MEMFD_H
+
+#include "io/channel-file.h"
+
+QIOChannel *cpr_exec_memfd_connect_outgoing(Error **errp);
+void cpr_exec_memfd_connect_incoming(Error **errp);
+bool cpr_exec_memfd_preserve_fd(Error **errp);
+void cpr_exec_memfd_cleanup(void);
+
+#endif
diff --git a/migration/meson.build b/migration/meson.build
index 1d852b8c6d..2e8a89637e 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -17,6 +17,7 @@ system_ss.add(files(
   'cpr.c',
   'cpr-transfer.c',
   'cpr-exec.c',
+  'cpr-exec-memfd.c',
   'cpu-throttle.c',
   'dirtyrate.c',
   'exec.c',
-- 
2.43.5


