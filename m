Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD6BECA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 23:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGPu5-0005hD-Sp; Mon, 12 Oct 2026 19:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPu0-0005e9-Ne
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:57:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPty-0006Fa-Dk
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:57:56 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CMfxGI2762693; Mon, 12 Oct 2026 23:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=0uArC
 AURFDRetClqrl0/l9ewQQyuvpxe9hlBRsQ2QJc=; b=EPXr6ge3rIt2DhdndcgpM
 Pl9YeyJoIuxewA7Q8mKb76uuh2Meqc1wXIW/8Hz9axLP5gZ7Tg8mmYzgaUDHJsIm
 9HxEvIers85+8V5TJPmfXE/FHuXi4P/aLNUQwRLSBPQPdv51gyN4kXxMs4Y5tle5
 XdCWcXcoWwUIa+hBXnj15OQbnT5DY/tbCadvAM6sj0MgBPTgM9XXZXxGEsAo+YrI
 9WVeq9eloRD9D57D3OZQiQ2K8Qc6ccJjhGjlwYfYwIv8x40rdBjVV3BYNkssBiUF
 Z5pI4vtkF0eH0UuB2NofZLPhRnjmqijswzz8oRpyNEXuN/PPvRgslk/FJ2hu4H7i
 A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7ddgk6rr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:49 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 69CNpeAM015093; Mon, 12 Oct 2026 23:57:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4h7btnuhtt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:49 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CNvfHT025328;
 Mon, 12 Oct 2026 23:57:48 GMT
Received: from donglzha-e6-vfio-setup.osdevelopmeniad.oraclevcn.com
 (donglzha-e6-vfio-setup.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.255.69])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4h7btnuhra-12; Mon, 12 Oct 2026 23:57:48 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, maciej.szmigiero@oracle.com,
 peterx@redhat.com, farosas@suse.de, mark.kanda@oracle.com,
 bchaney@akamai.com, pierrick.bouvier@oss.qualcomm.com,
 alex@shazbot.org, clg@redhat.com, yi.l.liu@intel.com,
 eric.auger@redhat.com, zhenzhong.duan@intel.com, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com
Subject: [PATCH 11/21] migration/cpr: move QEMUFile fd helpers to common code
Date: Mon, 12 Oct 2026 23:56:07 +0000
Message-ID: <20261012235727.398133-12-dongli.zhang@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=EeZd0/mC c=1 sm=1 tr=0 ts=6acd73fd b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=JSUPLgrZ2TeJEUTcGQwA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-ORIG-GUID: 2qb2j-1-iR0t04cStrlYqkqTpoS7Svj-
X-Proofpoint-GUID: 2qb2j-1-iR0t04cStrlYqkqTpoS7Svj-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfX3RgNvgRkEXnQ
 +HVKPlGPgt9ad1yj5vxjb75taWXf5C2w/mC4yhK68pdS6uwSo0hOBpLPOQab1Uk5vpgbDYpOm4H
 vIznq9V88Wef6lxLEgzOx+7tvG42hjnzbunKjYg3gIz8C7czEsAc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfX9t0oeB8Nbjkd
 C/wHuxwbh39APvwBHil1WmVxuCmgEQB74HNRRklhOsFLWF7TPF4Y9WKU3MXjUimUgNBsIKjqulZ
 Bun3I6gul/ZAfeYtIi0LIrXLLMO5gv2Wz/E1dVI7SY4vOOrzS58BIUB3t3CB8lQbR2BUHd/f8P7
 TAwhrC7J3dUuwlJoPuPcu3YQ4MNA69vPpXA9BwuuL1lfTYBbxAwy2dLBkdeomnPmh5yrrqxqIXw
 Rbgzp+xasOj7HQetWA10Md5x9qX/YFO3OfW3ncuXGJOYL4M+BifnGH3yqZpULZd7rEf4oIqgCtJ
 +VSopGiyw0tGqvVNWwNNC7u9a+s639y/elJnRmRbFScW7qpchsXyJ9AO682sY3sKDaMgxtCYBBm
 yIFhi3xDKAbGi0LSy0X1L8pAooqJ2SjLzpaoa2lg2pEACi4vgTBd8mTVzbOeSrnHDKN5dYI0HAg
 pDGZlZ+nDfYyY0oqg3sNQbZMHv6E2fpPyt0dJThM=
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

Move the helpers qemu_file_new_fd_input() and qemu_file_new_fd_output(),
that create input and output QEMUFiles backed by existing file descriptors
from cpr-exec to common CPR code. This allows cpr-luo to reuse them.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 include/migration/cpr.h |  3 +++
 migration/cpr-exec.c    | 20 ++------------------
 migration/cpr.c         | 17 +++++++++++++++++
 3 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 77e753a278..23751fc015 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -60,6 +60,9 @@ bool cpr_state_load(MigrationChannel *channel, Error **errp);
 void cpr_state_close(void);
 struct QIOChannel *cpr_state_ioc(void);
 
+QEMUFile *cpr_file_new_fd_input(int fd, const char *name);
+QEMUFile *cpr_file_new_fd_output(int fd, const char *name);
+
 bool cpr_incoming_needed(void *opaque);
 int cpr_get_fd_param(const char *name, const char *fdname, int index,
                      Error **errp);
diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
index daa50916d2..b31ec3e59f 100644
--- a/migration/cpr-exec.c
+++ b/migration/cpr-exec.c
@@ -24,22 +24,6 @@
 
 #define CPR_EXEC_STATE_NAME "QEMU_CPR_EXEC_STATE"
 
-static QEMUFile *qemu_file_new_fd_input(int fd, const char *name)
-{
-    g_autoptr(QIOChannelFile) fioc = qio_channel_file_new_fd(fd);
-    QIOChannel *ioc = QIO_CHANNEL(fioc);
-    qio_channel_set_name(ioc, name);
-    return qemu_file_new_input(ioc);
-}
-
-static QEMUFile *qemu_file_new_fd_output(int fd, const char *name)
-{
-    g_autoptr(QIOChannelFile) fioc = qio_channel_file_new_fd(fd);
-    QIOChannel *ioc = QIO_CHANNEL(fioc);
-    qio_channel_set_name(ioc, name);
-    return qemu_file_new_output(ioc);
-}
-
 bool cpr_exec_persist_state(QEMUFile *f, Error **errp)
 {
     QIOChannelFile *fioc = QIO_CHANNEL_FILE(qemu_file_get_ioc(f));
@@ -99,7 +83,7 @@ QEMUFile *cpr_exec_output(Error **errp)
         return NULL;
     }
 
-    return qemu_file_new_fd_output(mfd, CPR_EXEC_STATE_NAME);
+    return cpr_file_new_fd_output(mfd, CPR_EXEC_STATE_NAME);
 }
 
 QEMUFile *cpr_exec_input(Error **errp)
@@ -107,7 +91,7 @@ QEMUFile *cpr_exec_input(Error **errp)
     int mfd = cpr_exec_find_state();
 
     lseek(mfd, 0, SEEK_SET);
-    return qemu_file_new_fd_input(mfd, CPR_EXEC_STATE_NAME);
+    return cpr_file_new_fd_input(mfd, CPR_EXEC_STATE_NAME);
 }
 
 static bool preserve_fd(int fd)
diff --git a/migration/cpr.c b/migration/cpr.c
index 700e833003..3e8e94e5fe 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -10,6 +10,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/vfio/vfio-cpr.h"
+#include "io/channel-file.h"
 #include "migration/cpr.h"
 #include "migration/misc.h"
 #include "migration/options.h"
@@ -242,6 +243,22 @@ bool cpr_walk_fd(cpr_walk_fd_cb cb)
     return true;
 }
 
+QEMUFile *cpr_file_new_fd_input(int fd, const char *name)
+{
+    g_autoptr(QIOChannelFile) fioc = qio_channel_file_new_fd(fd);
+    QIOChannel *ioc = QIO_CHANNEL(fioc);
+    qio_channel_set_name(ioc, name);
+    return qemu_file_new_input(ioc);
+}
+
+QEMUFile *cpr_file_new_fd_output(int fd, const char *name)
+{
+    g_autoptr(QIOChannelFile) fioc = qio_channel_file_new_fd(fd);
+    QIOChannel *ioc = QIO_CHANNEL(fioc);
+    qio_channel_set_name(ioc, name);
+    return qemu_file_new_output(ioc);
+}
+
 static const VMStateDescription vmstate_cpr_luo_state = {
     .name = CPR_LUO_STATE,
     .version_id = 1,
-- 
2.43.5


