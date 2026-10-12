Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980D1CA9ED0
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 00:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGPu7-0005hy-6F; Mon, 12 Oct 2026 19:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPu2-0005fA-NK
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:57:58 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPu0-0006Gd-Sm
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:57:58 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CMfwX52851116; Mon, 12 Oct 2026 23:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=NiGum
 nuYoNrIIrGA7kYai50232HdlR1UwQiQBeCT8IU=; b=F+VKm0aTHFy/U4rGftC40
 b95AzFDZhW4rYgX9aIhBezNaqQ9VevNb/GVG8omo6FA7js90JSYmgkHN1Uuym4US
 G6yTlrXM+Yj2dZUB+UkVDryfNPGcf7xvVQ0D6kgboyE0mct50c5GvhR23ykWYATk
 y+UE8xx8r4D2vUXl6Q76/BXr33m/AjmNFJ6JDIiIl6wKDhI9DO33tpiSNYxKsP9y
 teo8JUgK3st8QSjSEhISQRvHxNvfWO6LlL3A0LJCabp8v8ysOwtZMAVljttRnb3T
 NKjjyQMeCABbeUP1sXRZ1OcON2Md4mdsgFk+c07j5fLtmMS2V7/KaKTfPFtA10ko
 g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7dcsb68q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:52 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 69CNpe12015081; Mon, 12 Oct 2026 23:57:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4h7btnuhuv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:51 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CNvfHb025328;
 Mon, 12 Oct 2026 23:57:50 GMT
Received: from donglzha-e6-vfio-setup.osdevelopmeniad.oraclevcn.com
 (donglzha-e6-vfio-setup.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.255.69])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4h7btnuhra-16; Mon, 12 Oct 2026 23:57:50 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, maciej.szmigiero@oracle.com,
 peterx@redhat.com, farosas@suse.de, mark.kanda@oracle.com,
 bchaney@akamai.com, pierrick.bouvier@oss.qualcomm.com,
 alex@shazbot.org, clg@redhat.com, yi.l.liu@intel.com,
 eric.auger@redhat.com, zhenzhong.duan@intel.com, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com
Subject: [PATCH 15/21] migration/cpr-luo: enable cpr-luo mode for source side
 preservation
Date: Mon, 12 Oct 2026 23:56:11 +0000
Message-ID: <20261012235727.398133-16-dongli.zhang@oracle.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfXwwfgC1xlZDHR
 tOUXXVr6h/zAod2ArOI8T3vJCFGHjdT1uWwtnFVyBZemYPi/9FdOyFZU3wMLuN1vBe5pawURi1d
 M+W4muF1eUK62SzdVQbTMQcm3E/bfgsNx83WA+eL0FRTZeHiXlsm
X-Proofpoint-GUID: G7FW6IFdY2Gk3hWVfLHZIq5Z-RcCm_xu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfXyTtVfV+Z+G8V
 B4KxGXFt7b34sFBbbHCQZkaLjIjJC+SSv29ViF6q37y7p1d+Fiby7VODvC80FXzRx/JYlOMoNM2
 NM2yuRLZ9/a35y6bS8NE/CIQq+6ISN+46/5JMVq+1+4DV+xvVnR+i28QtXBCEdTTLOU6Itu9OQS
 frjpAArHKI7nAEdGGNSZMvckhiRoUbnaOLLdBEF4eNIa9KO24kzqoExb5VvOzKfloCs5gHZ5WNP
 U+Y7MLHjlrAxi4bfGdOPcQ6SBRSbFfRoo3XjaG09XWoGDBzyvOJRP7TXQ9PVF/1HRdKhPd1zU+R
 XzHFwUAdSPCojdR5fy+QH0bitoxdOtLC/E4VRvebFG+MMoiAghmXRKFUAfMRuzucosb91wkv7NY
 mvkjhItuCiaE9YdKrqEslmYEMsL+qF1P9vl6HmI29s2R+7Fa2JFZVLGxRz6kPkeu5Ju/X9GTuxX
 aMzujkc3oc5BiVhIp3+SSTgiAfuw6JQC2WMkTIlk=
X-Proofpoint-ORIG-GUID: G7FW6IFdY2Gk3hWVfLHZIq5Z-RcCm_xu
X-Authority-Analysis: v=2.4 cv=EdZd0/mC c=1 sm=1 tr=0 ts=6acd7400 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=g97pKK-uvjQKAlel0SQA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
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

As with cpr-exec and cpr-transfer, call the cpr-luo APIs from
cpr_state_save() to preserve both the state memfd and all LUO-supported
fds.

Use the explicit machine UUID to form the LUO session name.

Close and clean up the session if an error occurs.

A migration notifier will be added in a future commit to clean up the
session if migration later fails.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
A cleanup of existing code can help remove an unnecessary
migrate_mode().

 include/migration/cpr.h  |  1 +
 migration/cpr-luo-stub.c |  5 ++++
 migration/cpr-luo.c      | 50 ++++++++++++++++++++++++++++++++++++++++
 migration/cpr.c          |  7 ++++++
 migration/migration.c    |  3 ++-
 migration/ram.c          |  1 +
 6 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index bfb2bb0b50..62426bd3e0 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -94,5 +94,6 @@ QEMUFile *cpr_luo_input(int session_fd, Error **errp);
 bool cpr_luo_persist_state(int session_fd, QEMUFile *f, Error **errp);
 bool cpr_luo_preserve_fds(Error **errp);
 bool cpr_luo_retrieve_fds(Error **errp);
+bool cpr_luo_save(QEMUFile *f, Error **errp);
 void cpr_luo_abort(void);
 #endif
diff --git a/migration/cpr-luo-stub.c b/migration/cpr-luo-stub.c
index fb2e649534..04a5bd816a 100644
--- a/migration/cpr-luo-stub.c
+++ b/migration/cpr-luo-stub.c
@@ -54,6 +54,11 @@ bool cpr_luo_persist_state(int fd, QEMUFile *f, Error **errp)
     return false;
 }
 
+bool cpr_luo_save(QEMUFile *f, Error **errp)
+{
+    return cpr_luo_unsupported(errp);
+}
+
 void cpr_luo_abort(void)
 {
 }
diff --git a/migration/cpr-luo.c b/migration/cpr-luo.c
index f20ba1f30c..1d112e7865 100644
--- a/migration/cpr-luo.c
+++ b/migration/cpr-luo.c
@@ -15,8 +15,10 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/memfd.h"
+#include "system/system.h"
 
 #define CPR_LUO_STATE_NAME "QEMU_CPR_LUO_STATE"
+#define CPR_LUO_SESSION_PREFIX "qemu-cpr-luo-"
 
 static int luo_open(Error **errp)
 {
@@ -211,6 +213,54 @@ bool cpr_luo_retrieve_fds(Error **errp)
     return cpr_walk_fd(cpr_luo_retrieve_one, errp);
 }
 
+static bool cpr_luo_session_name(char name[LIVEUPDATE_SESSION_NAME_LENGTH],
+                                 Error **errp)
+{
+    char uuid[UUID_STR_LEN];
+
+    if (!qemu_machine_uuid_is_set()) {
+        error_setg(errp, "cpr-luo requires a non-null machine UUID");
+        return false;
+    }
+
+    qemu_uuid_unparse(&qemu_uuid, uuid);
+    snprintf(name, LIVEUPDATE_SESSION_NAME_LENGTH, "%s%s",
+             CPR_LUO_SESSION_PREFIX, uuid);
+
+    return true;
+}
+
+bool cpr_luo_save(QEMUFile *f, Error **errp)
+{
+    char name[LIVEUPDATE_SESSION_NAME_LENGTH];
+    int session_fd;
+
+    if (!cpr_luo_session_name(name, errp)) {
+        return false;
+    }
+
+    session_fd = cpr_luo_create_session(name, errp);
+    if (session_fd < 0) {
+        return false;
+    }
+
+    cpr_state.luo_session_fd = session_fd;
+
+    if (!cpr_luo_persist_state(session_fd, f, errp)) {
+        goto fail;
+    }
+
+    if (!cpr_luo_preserve_fds(errp)) {
+        goto fail;
+    }
+
+    return true;
+
+fail:
+    cpr_luo_abort();
+    return false;
+}
+
 void cpr_luo_abort(void)
 {
     int session_fd = cpr_state.luo_session_fd;
diff --git a/migration/cpr.c b/migration/cpr.c
index bc4d1e979d..b91f2fdcd7 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -335,6 +335,8 @@ bool cpr_state_save(MigrationChannel *channel, Error **errp)
         f = cpr_transfer_output(channel, errp);
     } else if (mode == MIG_MODE_CPR_EXEC) {
         f = cpr_exec_output(errp);
+    } else if (mode == MIG_MODE_CPR_LUO) {
+        f = cpr_luo_output(errp);
     } else {
         return true;
     }
@@ -355,6 +357,11 @@ bool cpr_state_save(MigrationChannel *channel, Error **errp)
             qemu_fclose(f);
             return false;
         }
+    } else if (mode == MIG_MODE_CPR_LUO) {
+        if (!cpr_luo_save(f, errp)) {
+            qemu_fclose(f);
+            return false;
+        }
     }
 
     /*
diff --git a/migration/migration.c b/migration/migration.c
index 6a51f212ca..c8055a1d98 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1698,7 +1698,8 @@ bool migrate_mode_is_cpr(void)
     MigMode mode = migrate_mode();
     return mode == MIG_MODE_CPR_REBOOT ||
            mode == MIG_MODE_CPR_TRANSFER ||
-           mode == MIG_MODE_CPR_EXEC;
+           mode == MIG_MODE_CPR_EXEC ||
+           mode == MIG_MODE_CPR_LUO;
 }
 
 int migrate_init(MigrationState *s, Error **errp)
diff --git a/migration/ram.c b/migration/ram.c
index e6db3bf523..34e327a9de 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -230,6 +230,7 @@ bool migrate_ram_is_ignored(RAMBlock *block)
     return !qemu_ram_is_migratable(block) ||
            mode == MIG_MODE_CPR_TRANSFER ||
            mode == MIG_MODE_CPR_EXEC ||
+           mode == MIG_MODE_CPR_LUO ||
            (migrate_ignore_shared() && qemu_ram_is_shared(block)
                                     && qemu_ram_is_named_file(block));
 }
-- 
2.43.5


