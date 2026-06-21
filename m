Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F6BCDB466
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 07:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbChe-0003dc-Jr; Sun, 21 Jun 2026 03:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wbChc-0003bV-Mj
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 03:34:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wbCha-0005ZB-Qz
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 03:34:48 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65L7BgPa2863150; Sun, 21 Jun 2026 07:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=cfsFzKbIG808Hv12s4q5hF7RHxD3H
 67mJ2Vb+Lqg5FM=; b=dVt25GTH6dgZ0laew1j+ylFIrQeqyBO4klgrK5w1mssK1
 DDOsgPPaxJNSWXv+jQsXnGhciXKj+rvfv7MV9ZDQUwnJq+t1nRUQnp9qgUp9O/3t
 PdyjiaM7gOPSGQz+2KmsC12Cu3aair++5ye9GGWW7b2c0hSvVeOHp3mChk8RJA6Y
 lDX65cnbnIi5PNjT0sLYt9/EmC0dZoTZiqQx5z3we5lQkMyR2NnldBURlGqGmHnj
 Bfj0zdJONw4cAvbCb2feRGp4r/Z9GJXCRwoboMxa7CsTZZutiMa4pssHcKyJ+pNh
 izvw+3VMlKOm8gBsP//vLfIk1MWmH9cIJtbHcHyDg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewhn2rn8h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 21 Jun 2026 07:34:40 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 65L7X830017951; Sun, 21 Jun 2026 07:34:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4ewha9r38c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 21 Jun 2026 07:34:39 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65L7Yd51020160;
 Sun, 21 Jun 2026 07:34:39 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4ewha9r389-1; Sun, 21 Jun 2026 07:34:39 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, peterx@redhat.com, farosas@suse.de,
 maciej.szmigiero@oracle.com, mark.kanda@oracle.com, bchaney@akamai.com
Subject: [PATCH 1/1] migration/cpr: Add HMP support for cpr-transfer
Date: Sun, 21 Jun 2026 00:26:46 -0700
Message-ID: <20260621072646.517545-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-20_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606210075
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIxMDA3NSBTYWx0ZWRfX5PoeqToURUBx
 BnuVI3JQG6ftzpr0RnI8wzeMj8Y1GGoDlUWWP++1KGNopJbTFIZGWFOT2XPfoWEU9LxhO0uOl9u
 4Gkf2ipAxCiBX34M24jX2/K5F9TA6G1F9I5aDngtrmlNXo+Rk0+sf0HA4pgqn4tGhG1YLOFH20v
 wOlmNrcyFtj37TX39YihPNUmiSiJ+agm2EseLXOR9qaCXIOFpVve6jzJr6qPUEJvi+IRBE+KfbI
 CWSVMQb9UegIvClyqfD6cy16NOXS9gIIXfMUqOqASk+bP8uDmLqEbxDlCH2b77UpiNnsjbzZzu6
 LhJYa0ySO8R36htxZea2f+QKfl2FiPuZRp26agDnIX6icnpyLaYn4rTDxCS7lPif5gLZLs+8GTV
 YG8dbBA7Seq4uN+5ZfnXh2Cu/R8AT/YUcvh27D6XWLx7QeHQwBv4hxQk4GhM8I1rUClwXxwGJZ3
 baV2xmJJT9UaYp5/PKA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIxMDA3NSBTYWx0ZWRfXyYJAT5ssmEFN
 +8z/A3Pz041+SpmVooFOhl9X1Arn8YdLsBufndb75oR8zF71mAnQ8+h/9DJQwPukKnvEFnvws16
 qyuaeCS9E0d9H/u2Rru5wReFHUm4O4DqSTgQATvjPAaWqEk965zs
X-Proofpoint-GUID: UYAtitZQkbDiTbL_2-Ah-3_uyFyP7QTn
X-Authority-Analysis: v=2.4 cv=E479Y6dl c=1 sm=1 tr=0 ts=6a379410 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=4f9o9nRBQE7R8TUuHmkA:9
X-Proofpoint-ORIG-GUID: UYAtitZQkbDiTbL_2-Ah-3_uyFyP7QTn
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Currently the cpr-transfer source QEMU instance cannot be driven entirely
via HMP.  The source must use QMP in order to specify both the
main migration channel and the CPR channel.

Extend the HMP migrate command with an optional CPR channel URI. When the
migration mode is cpr-transfer, HMP uses this URI to build a
CPR MigrationChannel in addition to the main migration channel. The new
argument is rejected unless the migration mode is cpr-transfer, so existing
HMP migrate usage is unchanged.

For example, source QEMU HMP commands can be something like below. The
"unix:/tmp/cpr.sock" is for CPR URI.

(qemu) migrate_set_parameter mode cpr-transfer
(qemu) migrate tcp:0:50002 unix:/tmp/cpr.sock

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 hmp-commands.hx                | 11 +++++++----
 migration/migration-hmp-cmds.c | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 7ae2468a3d..021e51b142 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -928,16 +928,17 @@ ERST
 
     {
         .name       = "migrate",
-        .args_type  = "detach:-d,resume:-r,uri:s",
-        .params     = "[-d] [-r] uri",
+        .args_type  = "detach:-d,resume:-r,uri:s,uri-cpr:s?",
+        .params     = "[-d] [-r] uri [uri-cpr]",
         .help       = "migrate to URI (using -d to not wait for completion)"
-		      "\n\t\t\t -r to resume a paused postcopy migration",
+		      "\n\t\t\t -r to resume a paused postcopy migration"
+		      "\n\t\t\t uri-cpr specifies CPR URI for cpr-transfer mode",
         .cmd        = hmp_migrate,
     },
 
 
 SRST
-``migrate [-d] [-r]`` *uri*
+``migrate [-d] [-r]`` *uri* [*uri-cpr*]
   Migrate the VM to *uri*.
 
   ``-d``
@@ -945,6 +946,8 @@ SRST
     query an ongoing migration process, use "info migrate".
   ``-r``
     Resume a paused postcopy migration.
+  ``uri-cpr``
+    Specify CPR URI for cpr-transfer mode. It must be a UNIX domain socket.
 ERST
 
     {
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 8b385f560e..42ca652bb3 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -836,9 +836,11 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     bool detach = qdict_get_try_bool(qdict, "detach", false);
     bool resume = qdict_get_try_bool(qdict, "resume", false);
     const char *uri = qdict_get_str(qdict, "uri");
+    const char *uri_cpr = qdict_get_try_str(qdict, "uri-cpr");
     Error *err = NULL;
     g_autoptr(MigrationChannelList) caps = NULL;
     g_autoptr(MigrationChannel) channel = NULL;
+    g_autoptr(MigrationChannel) channel_cpr = NULL;
 
     if (!migrate_uri_parse(uri, &channel, &err)) {
         hmp_handle_error(mon, err);
@@ -846,6 +848,22 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     }
     QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
 
+    if (uri_cpr) {
+        if (migrate_mode() != MIG_MODE_CPR_TRANSFER) {
+            error_setg(&err, "uri-cpr requires cpr-transfer mode");
+            hmp_handle_error(mon, err);
+            return;
+        }
+
+        if (!migrate_uri_parse(uri_cpr, &channel_cpr, &err)) {
+            hmp_handle_error(mon, err);
+            return;
+        }
+
+        channel_cpr->channel_type = MIGRATION_CHANNEL_TYPE_CPR;
+        QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel_cpr));
+    }
+
     qmp_migrate(NULL, true, caps, true, resume, &err);
     if (hmp_handle_error(mon, err)) {
         return;
-- 
2.43.7


