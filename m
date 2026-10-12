Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC940CA9ED0
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 00:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGPu4-0005gJ-7x; Mon, 12 Oct 2026 19:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPu0-0005e5-IB
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:57:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPtx-0006FC-Hg
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:57:56 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CMiWcl2859374; Mon, 12 Oct 2026 23:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=ZwFmR
 Bh9lrumMOFC1VfWSK98UQN5DpAmc8I14q68V38=; b=KedMnA16hPyy/nwmhqNyO
 GmCaVq8rOIQWwQ69U3lyo/ZFuY7G3GAf7TFJGudsIT1tCH6ttNs3ZZJUOPj/Laq0
 0v1uLjNwYysVJbLJWk7nAZOHuqDqF2vr8U/FY6ySlR6RfVYnqfxbhF08MKv66imp
 hb9AUNpGXzW5opyvspCFXyx7K3WYOfA45BgxcaUmImdBOhorstj+5v2CRenZVPQT
 utTCLBEk4kcVYivYjQRJYRwBRxf526ZBGrUURjXKHAiSoMeDxO3GOjELl0YqG/Z6
 jMGhVBaKO+psxSeLXEaU9m8fa8mlrs9nGcOm7QFlhjUvoMcxAegkQs4HZYHckcru
 w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7demk5v8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:47 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 69CNpiNO015357; Mon, 12 Oct 2026 23:57:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4h7btnuhsq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:46 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CNvfHJ025328;
 Mon, 12 Oct 2026 23:57:45 GMT
Received: from donglzha-e6-vfio-setup.osdevelopmeniad.oraclevcn.com
 (donglzha-e6-vfio-setup.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.255.69])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4h7btnuhra-7; Mon, 12 Oct 2026 23:57:45 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, maciej.szmigiero@oracle.com,
 peterx@redhat.com, farosas@suse.de, mark.kanda@oracle.com,
 bchaney@akamai.com, pierrick.bouvier@oss.qualcomm.com,
 alex@shazbot.org, clg@redhat.com, yi.l.liu@intel.com,
 eric.auger@redhat.com, zhenzhong.duan@intel.com, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com
Subject: [PATCH 06/21] migration/cpr-luo: add LUO session management
Date: Mon, 12 Oct 2026 23:56:02 +0000
Message-ID: <20261012235727.398133-7-dongli.zhang@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=CoEq4X4D c=1 sm=1 tr=0 ts=6acd73fb b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=RtPbJqkYBnmB2BBawVIA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-GUID: 4yW0lYynPi3jjIFHI5Io21-1VKK1GHPt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfX/TDGxIzzCoKP
 dunffwsJQIusZjIZB1H/6OKEl48y2FiAfMTIFkScfdtisNU4KXHYEP/fw64now8sdfFIQtof6S0
 CM6yGMgJ1nbp4zItxRThSQi56ysP876VL+3iehDa0eT5wIyEfghC
X-Proofpoint-ORIG-GUID: 4yW0lYynPi3jjIFHI5Io21-1VKK1GHPt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfX0japKlSht7F1
 Pb5NPFc20g/EJSMvoEX5l5Uv+E6HppddaQm6a4NUSAoTbWOmkDYM1uOo9eGpPmI2S5aJheYfu3C
 ZetsA57YnTJCcQXG6kQeX6jbuC86UpMs3by5XbVAeqJBM24bOCP/FUua9/oBUNdXM8PQiOVJFPK
 z/FNR6S1KWILvvqS2MHFFy/e3COxfjAO+bR6T9fzagWWm4XlUP2coSruOsKSbEiAE3sMbnaXZsG
 ivfaqABGnPncKxxT9BZIfgw21CG5BVm1g/8ojpJ3+t6v1ncgTz/3fMolRnplzDn+JGNdw0kpR3s
 /BucGnz746dZp4dlyus2PfxC49t5yCtiAmWodwO1c4aQiKcsnxIe/g2X1gED3o/r8ZEXjMadqa1
 2AcoMkME2r2MlBB8DFvwKHXROqX9xjGr+jy0MerJPdu0U3nwPPLvtsVgNMxJt9Oko2wNDA6aVVs
 Aau9P8nOI4r4V50ZUBlqT5ua4GO4lBdVlcs3c0OQ=
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

Add helpers to create and retrieve Live Update Orchestrator (LUO)
sessions.

The LUO API is available only on Linux. Provide error stubs on other
hosts.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 include/migration/cpr.h  |  3 ++
 migration/cpr-luo-stub.c | 26 ++++++++++++++
 migration/cpr-luo.c      | 74 ++++++++++++++++++++++++++++++++++++++++
 migration/meson.build    |  6 ++++
 4 files changed, 109 insertions(+)
 create mode 100644 migration/cpr-luo-stub.c
 create mode 100644 migration/cpr-luo.c

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index e33eaf588b..f8b161b3d6 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -74,4 +74,7 @@ bool cpr_exec_persist_state(QEMUFile *f, Error **errp);
 bool cpr_exec_has_state(void);
 void cpr_exec_unpersist_state(void);
 void cpr_exec_unpreserve_fds(void);
+
+int cpr_luo_create_session(const char *name, Error **errp);
+int cpr_luo_retrieve_session(const char *name, Error **errp);
 #endif
diff --git a/migration/cpr-luo-stub.c b/migration/cpr-luo-stub.c
new file mode 100644
index 0000000000..ca060ae8c8
--- /dev/null
+++ b/migration/cpr-luo-stub.c
@@ -0,0 +1,26 @@
+/*
+ * Copyright (c) 2026 Oracle and/or its affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "migration/cpr.h"
+#include "qapi/error.h"
+
+static int cpr_luo_unsupported(Error **errp)
+{
+    error_setg(errp, "cpr-luo requires Linux");
+    return -1;
+}
+
+int cpr_luo_create_session(const char *name, Error **errp)
+{
+    return cpr_luo_unsupported(errp);
+}
+
+int cpr_luo_retrieve_session(const char *name, Error **errp)
+{
+    return cpr_luo_unsupported(errp);
+}
diff --git a/migration/cpr-luo.c b/migration/cpr-luo.c
new file mode 100644
index 0000000000..48288ed5f9
--- /dev/null
+++ b/migration/cpr-luo.c
@@ -0,0 +1,74 @@
+/*
+ * Copyright (c) 2026 Oracle and/or its affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include <sys/ioctl.h>
+
+#include "linux-headers/linux/liveupdate.h"
+#include "migration/cpr.h"
+#include "qapi/error.h"
+
+static int luo_open(Error **errp)
+{
+    return qemu_open("/dev/liveupdate", O_RDWR, errp);
+}
+
+int cpr_luo_create_session(const char *name, Error **errp)
+{
+    struct liveupdate_ioctl_create_session create = { 0 };
+    int fd;
+
+    if (g_strlcpy((char *)create.name, name, sizeof(create.name)) >=
+        sizeof(create.name)) {
+        error_setg(errp, "LUO session name is too long");
+        return -1;
+    }
+
+    fd = luo_open(errp);
+    if (fd < 0) {
+        return -1;
+    }
+
+    create.size = sizeof(create);
+    if (ioctl(fd, LIVEUPDATE_IOCTL_CREATE_SESSION, &create) < 0) {
+        error_setg_errno(errp, errno, "failed to create LUO session '%s'",
+                         (char *)create.name);
+        close(fd);
+        return -1;
+    }
+
+    close(fd);
+    return create.fd;
+}
+
+int cpr_luo_retrieve_session(const char *name, Error **errp)
+{
+    struct liveupdate_ioctl_retrieve_session retrieve = { 0 };
+    int fd;
+
+    if (g_strlcpy((char *)retrieve.name, name, sizeof(retrieve.name)) >=
+        sizeof(retrieve.name)) {
+        error_setg(errp, "LUO session name is too long");
+        return -1;
+    }
+
+    fd = luo_open(errp);
+    if (fd < 0) {
+        return -1;
+    }
+
+    retrieve.size = sizeof(retrieve);
+    if (ioctl(fd, LIVEUPDATE_IOCTL_RETRIEVE_SESSION, &retrieve) < 0) {
+        error_setg_errno(errp, errno, "failed to retrieve LUO session '%s'",
+                         (char *)retrieve.name);
+        close(fd);
+        return -1;
+    }
+
+    close(fd);
+    return retrieve.fd;
+}
diff --git a/migration/meson.build b/migration/meson.build
index 4ab9d99cea..a6363c2bf7 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -54,3 +54,9 @@ system_ss.add(when: qatzip, if_true: files('multifd-qatzip.c'))
 system_ss.add(when: 'CONFIG_VFIO',
               if_true: files('vfio.c'))
 stub_ss.add(files('vfio-stub.c'))
+
+if host_os == 'linux'
+  system_ss.add(files('cpr-luo.c'))
+else
+  system_ss.add(files('cpr-luo-stub.c'))
+endif
-- 
2.43.5


