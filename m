Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04829C5DF65
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 23:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuIRI-0004Qw-Vg; Wed, 12 Aug 2026 19:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wuIRE-0004PT-Jo
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 19:32:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wuIRC-0001S2-Dd
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 19:32:48 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CEq3uG2061644; Wed, 12 Aug 2026 23:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=2iAAH
 zkxxl+aTx1UHB5srahyUI/g4UfINfpnU9fcf7E=; b=aMOqq4t38D9GbN7IEhR9V
 VkFzgcvRJngcAB7coGawmSaOMXO82b6PKsqDOBiILff5V987f3GYWvisOEsmqL1r
 xKU20WXEtZb8wxaGsuVYwlGjy4DDJ6lZlc/yNqMfQmIHPyC2vW7b8q7PeE7Qmxea
 WUfBinyrLaiKp/kI1Tmc6g1VNHX+d9SIvwCDTXnlJ8meHyuvU2rhp6+lAZHGEIrq
 PPqgJNPAGuOY5zz1rS+2Zu7q04GjQWK9frkbnbpf0jrY5Iw+3PKwS9Q59r/mhVbz
 Y3QgwHSvHhYE3ktbQl+wvFk+wpPEAPLBM8ORT62ZrmwtYY/+K/6zCoe1CJS9i/yW
 Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fwvhdyssv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 23:32:42 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 67CNU0Ed017432; Wed, 12 Aug 2026 23:32:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4fwtwfngsa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 23:32:41 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67CNWbHe025569;
 Wed, 12 Aug 2026 23:32:40 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4fwtwfngqu-5; Wed, 12 Aug 2026 23:32:40 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com, 
 maciej.szmigiero@oracle.com, mark.kanda@oracle.com, bchaney@akamai.com,
 pierrick.bouvier@oss.qualcomm.com, joe.jin@oracle.com
Subject: [PATCH 4/5] migration/cpr-exec: Support diskless memfd transport
Date: Wed, 12 Aug 2026 16:27:49 -0700
Message-ID: <20260812232842.470225-5-dongli.zhang@oracle.com>
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
X-Proofpoint-ORIG-GUID: 0gTV_cw7ZAN7CAdaNDjOPpguoMShJKCn
X-Proofpoint-GUID: 0gTV_cw7ZAN7CAdaNDjOPpguoMShJKCn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE5MCBTYWx0ZWRfX6Xv4AvkeS9F5
 djqLTLhPeeLt7MpTjQ2SvIOjc+Xf8+K8S6ah79u5sw5ty1VmpBdr8777NLPXWiUNRVDA5qqVCTD
 1/HVxq4LAWBG5d6285H5yZVBWLpfNh87moSoCOSm3XQkFwofZT2USxulVQjPmf2Za7M4IhM38Uw
 honLT8OzfDHV6hvSxYRuZlSQtXyeFFMyegWZo23m9p3EAJvbExdGkp476jSFiBJOSr6YIi9KutT
 BoTJm9TXujXJ4oPshWFXDNrWth5rweb1EdB4h+ZoHyHVPleyjdvDTKOwgcxqoepwjOZ7VYR56SV
 sk5PLbGWVoty8wBtCWJXbVc6snNxH922+6aTtiXUFoZxlcCTyZpXGG9Mb8uMiLfCTyQMDLIjyoz
 c/lfAIycW9u5WQCisrFHhnm2PKiLGK8Bkv7CBXTJi1+LfQharQ6u+J1WZktjeoOwfeppO6hPNTT
 ZgZDeB9OlnhKm3e1LKA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE5MCBTYWx0ZWRfX6zNIFKu6tTfn
 wpp7R3xB+d+yZ22mGyHiu9aprctaDIlHgO/JPC6EP1EQDq232nShi9nLDGv+8EeUzmVwDRHKpYM
 P4ak6+UqFfx5PpAtC32TDEAiOS/G8HwysyD6rMxQBKbnQPJ/6u10
X-Authority-Analysis: v=2.4 cv=L/YtheT8 c=1 sm=1 tr=0 ts=6a7d029a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=l6aH6V--89kVnUN-eIUA:9
 a=O8hF6Hzn-FEA:10
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

Currently cpr-exec uses a file to pass the VM and device state between the
old and new QEMU processes. Support using memfd as a migration transport so
this state can be passed without creating a state file.

Here is an example of using the new memfd transport with cpr-exec.

(qemu) migrate_set_parameter mode cpr-exec
(qemu) migrate_set_parameter cpr-exec-command qemu-kvm ... -incoming defer
(qemu) migrate -d memfd:
QEMU 11.1.50 monitor - type 'help' for more information

(qemu) info status
VM status: paused (inmigrate)
(qemu) migrate_incoming memfd:
(qemu) info status
VM status: running

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 migration/channel.c   |  7 +++++++
 migration/cpr-exec.c  |  9 +++++++++
 migration/memfd.c     | 23 +++++++++++++++++++++++
 migration/memfd.h     |  2 ++
 migration/migration.c |  9 +++++++++
 5 files changed, 50 insertions(+)

diff --git a/migration/channel.c b/migration/channel.c
index 1e2935f926..96de40c108 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -18,6 +18,7 @@
 #include "file.h"
 #include "io/channel-socket.h"
 #include "io/channel-tls.h"
+#include "memfd.h"
 #include "migration.h"
 #include "multifd.h"
 #include "options.h"
@@ -62,6 +63,8 @@ void migration_connect_outgoing(MigrationState *s, MigrationAddress *addr,
         ioc = exec_connect_outgoing(s, addr->u.exec.args, errp);
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
         ioc = file_connect_outgoing(s, &addr->u.file, errp);
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_MEMFD) {
+        ioc = memfd_connect_outgoing(errp);
     } else {
         error_setg(errp, "uri is not a valid migration protocol");
     }
@@ -92,6 +95,8 @@ void migration_connect_incoming(MigrationAddress *addr, Error **errp)
         exec_connect_incoming(addr->u.exec.args, errp);
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
         file_connect_incoming(&addr->u.file, errp);
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_MEMFD) {
+        memfd_connect_incoming(errp);
     } else {
         error_setg(errp, "unknown migration protocol");
     }
@@ -394,6 +399,8 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
                               errp)) {
             return false;
         }
+    } else if (g_str_equal(uri, "memfd:")) {
+        addr->transport = MIGRATION_ADDRESS_TYPE_MEMFD;
     } else {
         error_setg(errp, "unknown migration protocol: %s", uri);
         return false;
diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
index daa50916d2..388cfba80d 100644
--- a/migration/cpr-exec.c
+++ b/migration/cpr-exec.c
@@ -21,6 +21,7 @@
 #include "migration/vmstate.h"
 #include "system/runstate.h"
 #include "trace.h"
+#include "cpr-exec-memfd.h"
 
 #define CPR_EXEC_STATE_NAME "QEMU_CPR_EXEC_STATE"
 
@@ -143,6 +144,11 @@ static void cpr_exec_cb(void *opaque)
      * earlier because they should not persist across miscellaneous fork and
      * exec calls that are performed during normal operation.
      */
+    if (!cpr_exec_memfd_preserve_fd(&err)) {
+        g_clear_pointer(&argv, g_strfreev);
+        cpr_exec_memfd_cleanup();
+        goto fail;
+    }
     cpr_exec_preserve_fds();
 
     trace_cpr_exec();
@@ -155,7 +161,9 @@ static void cpr_exec_cb(void *opaque)
     error_setg_errno(&err, errno, "execvp %s failed", argv[0]);
     g_clear_pointer(&argv, g_strfreev);
     cpr_exec_unpreserve_fds();
+    cpr_exec_memfd_cleanup();
 
+fail:
     error_report_err(error_copy(err));
     migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
 
@@ -189,6 +197,7 @@ static int cpr_exec_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
         qemu_notify_event();
     } else if (e->type == MIG_EVENT_FAILED) {
         cpr_exec_unpersist_state();
+        cpr_exec_memfd_cleanup();
     }
     return 0;
 }
diff --git a/migration/memfd.c b/migration/memfd.c
index 0b5ef0234f..4ed185d844 100644
--- a/migration/memfd.c
+++ b/migration/memfd.c
@@ -10,6 +10,9 @@
 #include "qemu/cutils.h"
 #include "qemu/memfd.h"
 #include "memfd.h"
+#include "cpr-exec-memfd.h"
+#include "migration/cpr.h"
+#include "options.h"
 
 QIOChannel *memfd_create_outgoing(const char *name, int *dup_fdp,
                                   Error **errp)
@@ -65,3 +68,23 @@ QIOChannel *memfd_open_incoming(int fd, const char *name, Error **errp)
     qio_channel_set_name(ioc, name);
     return ioc;
 }
+
+QIOChannel *memfd_connect_outgoing(Error **errp)
+{
+    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
+        return cpr_exec_memfd_connect_outgoing(errp);
+    }
+
+    error_setg(errp, "memfd transport is only supported with cpr-exec");
+    return NULL;
+}
+
+void memfd_connect_incoming(Error **errp)
+{
+    if (cpr_get_incoming_mode() == MIG_MODE_CPR_EXEC) {
+        cpr_exec_memfd_connect_incoming(errp);
+        return;
+    }
+
+    error_setg(errp, "memfd transport is only supported with cpr-exec");
+}
diff --git a/migration/memfd.h b/migration/memfd.h
index cb6afe3eeb..9c50c84ad5 100644
--- a/migration/memfd.h
+++ b/migration/memfd.h
@@ -13,5 +13,7 @@
 QIOChannel *memfd_create_outgoing(const char *name, int *dup_fdp,
                                   Error **errp);
 QIOChannel *memfd_open_incoming(int fd, const char *name, Error **errp);
+QIOChannel *memfd_connect_outgoing(Error **errp);
+void memfd_connect_incoming(Error **errp);
 
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 9df6da131c..9f3afe5a3a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -248,6 +248,15 @@ migration_channels_and_transport_compatible(MigrationAddress *addr,
         return false;
     }
 
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_MEMFD) {
+        if (migrate_mode() != MIG_MODE_CPR_EXEC &&
+            cpr_get_incoming_mode() != MIG_MODE_CPR_EXEC) {
+            error_setg(errp,
+                       "memfd transport is only supported with cpr-exec");
+            return false;
+        }
+    }
+
     return true;
 }
 
-- 
2.43.5


