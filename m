Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F8EC5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 23:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuIRJ-0004Rm-RR; Wed, 12 Aug 2026 19:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wuIRF-0004PZ-Fo
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 19:32:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wuIRC-0001Ry-Bl
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 19:32:49 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CEp8Bu881332; Wed, 12 Aug 2026 23:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=xBJSt
 eVHeVjPgQPJGO+lEqSC736TcxpesbTTLQrXF/I=; b=DLktV+hUygPeuEByTYMp3
 Hyl/y6UJmeDyu/DvQNWPPFFMQTi7su5nAz1Y5cC4Lg1Gi51F7tQJxdpt/oFACNMG
 dUadnm7jCIt2kwu7694sWaCygzWIi+Id0aHurjA2rzDzhAmObwyfXyXPYqJ9ivUY
 x7t2L2792tS2rAGnrbTW8hmZYx4C6rzHmMldp2DyDAtyvjZ5cwV6mLJd8s/Exf3M
 e2MKFesqWg8LwEJhXiE8POrViPmC7m50upE4YZZEzVQzX3jvc0oBUtKcocw+VWxw
 DYmsPN/KOD0YOaj8idNfNSmqfUztlpUdrrE5Vfl4XopwhEV9CiNsOfyDxTgaohDD
 A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fwvh2fk8n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 23:32:40 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 67CNTxOj017347; Wed, 12 Aug 2026 23:32:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4fwtwfngru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 23:32:39 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67CNWbHa025569;
 Wed, 12 Aug 2026 23:32:39 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4fwtwfngqu-3; Wed, 12 Aug 2026 23:32:39 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com, 
 maciej.szmigiero@oracle.com, mark.kanda@oracle.com, bchaney@akamai.com,
 pierrick.bouvier@oss.qualcomm.com, joe.jin@oracle.com
Subject: [PATCH 2/5] migration: Add generic memfd channel helpers
Date: Wed, 12 Aug 2026 16:27:47 -0700
Message-ID: <20260812232842.470225-3-dongli.zhang@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=M6V97Sws c=1 sm=1 tr=0 ts=6a7d0298 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=tdSjP6V1gMc4Ygz-QPUA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: kqyyHZ67ULOhhOd5EAlxMbz0L4Oan2K0
X-Proofpoint-ORIG-GUID: kqyyHZ67ULOhhOd5EAlxMbz0L4Oan2K0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE5MCBTYWx0ZWRfX3lwyeYBRi2Xa
 V2eb2rjLz6wBKTh3LRXZIvBB/6LNaru0iaua2vSqRjF6k9BtJ5lQXZPefmcUwAO4hFCRsswDQzZ
 hV7rZhIt5T7+FzQkFX98iy6SvUKstmwf39JXkabWEuheuqNuh6B6vVsgEVNuiR/BRBrLH76qLb+
 Zp1XmgjkLOeRSkgbCfaI3NphXgWF5miMIZWAykGnNaXk0PDeql09///9l+gqACCbAiPMww6LmLE
 sQ7U7zTpQwNURfpyED2bS1j5KYlWpEAKx9YYkGZQ1LNjLsEnaPC3lZdBg5x6ilWgddFX8GNJ3UP
 PD+/XYnVJFPvoJmf8dUDkl0QglInB0f4RggOCQLlsVOFlNLLulaWUOZcRwlljtXO+I73g+9joZT
 mtlepBKxMNAIPkfiB3Ff6tqrTYRn328wqonjuCUiJxEMLC5o0tZBnucjlVrucUB5L98/Z9yyoOX
 Bxg2aQcjFcDxibjOUlw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE5MCBTYWx0ZWRfX1V4xD4uAWM92
 8zERj6Zo/If4XLCPP8pEnyndqf0PVgEpa4NzvEWsrhpUa1m3iHXRgi95Q8SLjOVqsjavvKmE1JG
 jdzNKqhSirTxnU7QMCz6LHMHxKecaogyovURLAIGg7fpSnBy324I
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

Add helpers for creating an outgoing memfd-backed migration channel and for
wrapping an existing memfd fd as an incoming migration channel. The
outgoing helper can optionally duplicate the memfd fd for the caller.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 migration/memfd.c     | 67 +++++++++++++++++++++++++++++++++++++++++++
 migration/memfd.h     | 17 +++++++++++
 migration/meson.build |  1 +
 3 files changed, 85 insertions(+)
 create mode 100644 migration/memfd.c
 create mode 100644 migration/memfd.h

diff --git a/migration/memfd.c b/migration/memfd.c
new file mode 100644
index 0000000000..0b5ef0234f
--- /dev/null
+++ b/migration/memfd.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * QEMU live migration via memfd
+ *
+ * Copyright (c) 2026 Oracle and/or its affiliates.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/cutils.h"
+#include "qemu/memfd.h"
+#include "memfd.h"
+
+QIOChannel *memfd_create_outgoing(const char *name, int *dup_fdp,
+                                  Error **errp)
+{
+    QIOChannelFile *fioc;
+    QIOChannel *ioc;
+    int fd;
+
+#ifdef CONFIG_LINUX
+    fd = qemu_memfd_create(name, 0, false, 0, 0, errp);
+#else
+    fd = -1;
+    error_setg(errp, "memfd migration is only supported on Linux");
+#endif
+
+    if (fd < 0) {
+        return NULL;
+    }
+
+    if (dup_fdp) {
+        int dup_fd = dup(fd);
+
+        if (dup_fd < 0) {
+            error_setg_errno(errp, errno,
+                             "failed to duplicate memfd migration fd");
+            close(fd);
+            return NULL;
+        }
+
+        qemu_set_cloexec(dup_fd);
+        *dup_fdp = dup_fd;
+    }
+
+    fioc = qio_channel_file_new_fd(fd);
+    ioc = QIO_CHANNEL(fioc);
+    qio_channel_set_name(ioc, name);
+    return ioc;
+}
+
+QIOChannel *memfd_open_incoming(int fd, const char *name, Error **errp)
+{
+    QIOChannelFile *fioc;
+    QIOChannel *ioc;
+
+    if (lseek(fd, 0, SEEK_SET) < 0) {
+        error_setg_errno(errp, errno, "failed to rewind memfd migration fd");
+        close(fd);
+        return NULL;
+    }
+
+    fioc = qio_channel_file_new_fd(fd);
+    ioc = QIO_CHANNEL(fioc);
+    qio_channel_set_name(ioc, name);
+    return ioc;
+}
diff --git a/migration/memfd.h b/migration/memfd.h
new file mode 100644
index 0000000000..cb6afe3eeb
--- /dev/null
+++ b/migration/memfd.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * QEMU live migration via memfd
+ *
+ * Copyright (c) 2026 Oracle and/or its affiliates.
+ */
+
+#ifndef QEMU_MIGRATION_MEMFD_H
+#define QEMU_MIGRATION_MEMFD_H
+
+#include "io/channel-file.h"
+
+QIOChannel *memfd_create_outgoing(const char *name, int *dup_fdp,
+                                  Error **errp);
+QIOChannel *memfd_open_incoming(int fd, const char *name, Error **errp);
+
+#endif
diff --git a/migration/meson.build b/migration/meson.build
index 0a9a5d0d37..1d852b8c6d 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -23,6 +23,7 @@ system_ss.add(files(
   'fd.c',
   'file.c',
   'global_state.c',
+  'memfd.c',
   'migration.c',
   'multifd.c',
   'multifd-device-state.c',
-- 
2.43.5


