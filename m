Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E65C54EFC
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wodgO-0006qZ-W5; Tue, 28 Jul 2026 05:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wodgM-0006qJ-U2
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 05:01:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wodgK-0007Fw-Tu
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 05:01:02 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S8uIvN1007464; Tue, 28 Jul 2026 09:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=aUI4voTxK7Lrl9nsAqoACXgBMMhTP
 WyG5Bh3JpmCAG4=; b=R6WADr4bCoRurno2UmdImCvLOfiLvzuF9+mdH4ZCk+qWS
 VrRwN1QotiBrezpSNypRUjt+ltx3zpTFGZvY1DSzG3jybI7C+GQ+sSdJsgCRFzlR
 YrPcJpS3y5z/+FSfV1V8KBTp6pA2w5SslT1Iapns9WXoAt3zcArQ6v67R+HGDisd
 E4dfd6X/VOLyUPQcADzNcX1WPWbOntHTODGYIvrlEKR3TzHwKsU3IDrwDSU5rSl+
 AVeZgbLp/K56E2Soz4dZPsr/av0E2BjZUwnidkI8Ve1qfmfAKLd8raMhbRVH0KnY
 +7KKg5qbRzkC8HcN239MTtRJt42oG8euDdIimsGeg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmqyybfwv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jul 2026 09:00:54 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 66S8tYvv027466; Tue, 28 Jul 2026 09:00:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4fnh6peurk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jul 2026 09:00:54 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66S90r8d005792;
 Tue, 28 Jul 2026 09:00:53 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4fnh6peuqt-1; Tue, 28 Jul 2026 09:00:53 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, peterx@redhat.com, farosas@suse.de,
 maciej.szmigiero@oracle.com, mark.kanda@oracle.com, bchaney@akamai.com,
 joe.jin@oracle.com
Subject: [PATCH v3 1/1] migration/cpr: Add HMP support for cpr-transfer
Date: Tue, 28 Jul 2026 01:59:03 -0700
Message-ID: <20260728085903.173265-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607280077
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA3NiBTYWx0ZWRfX5PqkZfBB2f63
 K2hY5bwHCzbCmlfbNDeRbC+s5DXPXRwBbPT3YcTurbZqZ8+Xa3oQgVPi4gahcKCQTaQdhCblQzb
 pE5/5P5+4bdHtnfCEZ9JLm+TwB76oY9dv0oDICulx3VNp0lpC3Ao
X-Proofpoint-GUID: 8rdIexzi3YyIRJpHyCl7BXNJOPIrhq53
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA3NiBTYWx0ZWRfX70xdabhyQKpV
 VpNRkn1PfoK4JDG6EaBRgWIPnBbSWVl3JFuWlF2E2TFXO5bhD5l2gNz9cCuFcitKsOK3EKq5C3L
 yYQtHq3M8r/o3Bii+CsrC7VVG/jzZw18yGBjEQ4Zuv56oY+JIlQ6Z0s+ovogGsNoxxudG2drr1w
 mIkV7uPE3lIlMGGJ8+bdd/3ZH5kKsabSLdpw2H2WtcdE7s9Jz79ylosJrYH9yXubKIGwDayYoJt
 0s0lMKoFmmyaIye4UilFpAnHuhIak7xxE6PVZt4PF2KE2PtMvu4DhQafbKW0OutaHEyEbZzwzne
 S94bfEF0G06prBZ7RNkymoGoOFLqBS4MSgkxxBXX45raxPLuskV5dvYHrNotCPfrHPnMQYLklnr
 7oEYvUoGLEp1E6NGMM/9xKpoYvMXXeVh9NxAUDjnpr4eyswiVS1jGCxrC5OMMR+UyPnyhKKK4p4
 I9Vcbdb1oWfDItdIdLOflsZwBtCH5GfgbkVVhhtA=
X-Authority-Analysis: v=2.4 cv=HNnz0Itv c=1 sm=1 tr=0 ts=6a686fc7 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=3WJfbomfAAAA:8
 a=UmWCymfRQi47eAz9EPkA:9 a=1cNuO-ABBywtgFSQhe9S:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12114
X-Proofpoint-ORIG-GUID: 8rdIexzi3YyIRJpHyCl7BXNJOPIrhq53
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
option is rejected unless the migration mode is cpr-transfer, so existing
HMP migrate usage is unchanged.

For example, source QEMU HMP commands can be something like below. The
"-c unix:/tmp/cpr.sock" is for CPR URI.

(qemu) migrate_set_parameter mode cpr-transfer
(qemu) migrate -c unix:/tmp/cpr.sock tcp:0:50002

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Acked-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
v1->v2:
  - Use the '-c' option in the HMP command reference.
  - Use "a second uri can only be used in cpr-transfer mode" as error
    message.
v2->v3:
  - Use "-c can only be used in cpr-transfer mode".
  - Add Reviewed-by and Acked-by.

 hmp-commands.hx                | 12 ++++++++----
 migration/migration-hmp-cmds.c | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 7ae2468a3d..7f43cf537f 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -928,16 +928,17 @@ ERST
 
     {
         .name       = "migrate",
-        .args_type  = "detach:-d,resume:-r,uri:s",
-        .params     = "[-d] [-r] uri",
+        .args_type  = "detach:-d,resume:-r,uri-cpr:-cs,uri:s",
+        .params     = "[-d] [-r] [-c uri-cpr] uri",
         .help       = "migrate to URI (using -d to not wait for completion)"
-		      "\n\t\t\t -r to resume a paused postcopy migration",
+		      "\n\t\t\t -r to resume a paused postcopy migration"
+		      "\n\t\t\t -c to specify a CPR URI for cpr-transfer mode",
         .cmd        = hmp_migrate,
     },
 
 
 SRST
-``migrate [-d] [-r]`` *uri*
+``migrate [-d] [-r] [-c uri-cpr]`` *uri*
   Migrate the VM to *uri*.
 
   ``-d``
@@ -945,6 +946,9 @@ SRST
     query an ongoing migration process, use "info migrate".
   ``-r``
     Resume a paused postcopy migration.
+  ``-c`` *uri-cpr*
+    Specify the CPR URI for cpr-transfer mode. It must be a UNIX domain
+    socket.
 ERST
 
     {
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index b04fc4489f..b5eb27467c 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -837,9 +837,11 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
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
@@ -847,6 +849,22 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     }
     QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
 
+    if (uri_cpr) {
+        if (migrate_mode() != MIG_MODE_CPR_TRANSFER) {
+            error_setg(&err, "-c can only be used in cpr-transfer mode");
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
2.43.5


