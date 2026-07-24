Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8ADCC531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnCQc-0000v4-FO; Fri, 24 Jul 2026 05:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wnCQa-0000tV-AD
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:42:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wnCQV-0004YB-OY
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:42:48 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66O3mEq32464259; Fri, 24 Jul 2026 09:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=tRpDYrC+oQTmcopvJC++rXfQYIpHd
 W0JU5lZAru6IY4=; b=Uq+00YLgWqNmNIW2tckkC0453c5zUEsKgkcW6+LxFsFF3
 HpkFMHZhDnqQc9wMiKlECa3/ChlzbY5Ug5aywwVHD66eb1dRyfDo5YbS6JoxzaRZ
 gIi1ro6vxj6vcgPs477hsy8unRCjjViZE6FR48X7O0fpaExVYN4x9JtpVg4QQ817
 HbPjvvFhO47xCOK01bPTgs/VBb3ETB5SyBMPA5Ct3ihUGgwt0kdM1R3mPC6Dxvhe
 67Sfv2jgbO19rOhQhSFrsgidVfmJY3ROvNcz5qdGG5HXpqwW13evWuPmOAw+R/Yu
 kJnalxAvf5pqtV/cHjqf/FAXuKoZu7f9z2MNnJYDg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fg1n3r9pb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 09:42:38 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 66O9c0l7013343; Fri, 24 Jul 2026 09:42:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4fgts23m4t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 09:42:37 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66O9gaYI029170;
 Fri, 24 Jul 2026 09:42:36 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4fgts23m4f-1; Fri, 24 Jul 2026 09:42:36 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, peterx@redhat.com, farosas@suse.de,
 maciej.szmigiero@oracle.com, mark.kanda@oracle.com, bchaney@akamai.com
Subject: [PATCH v2 1/1] migration/cpr: Add HMP support for cpr-transfer
Date: Fri, 24 Jul 2026 02:41:19 -0700
Message-ID: <20260724094119.90581-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607240088
X-Proofpoint-GUID: 5EFRpQdGgWgTTs1SxVYT7zcombaFLgEs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA4OCBTYWx0ZWRfX1FOCXfYyYYq3
 wQuNUuXw+G9NSaVyqvaTOJLPFKLqEaBjVZok2OiXwpdDi3mEKx/Fr9mo3KF64CP01CHaFoPperw
 nmuR22Cefyo96r0wxAcT7DyZHVgOj+z2i0EKwiMBIAXh+DqDRmIl
X-Proofpoint-ORIG-GUID: 5EFRpQdGgWgTTs1SxVYT7zcombaFLgEs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA4OCBTYWx0ZWRfX+t/vn/EMwDcP
 NUQrqitHY6qJG3yvzrXciQTHaBC+Lb6EW2yX5azKDJkJLIM6+JyvTkuOQ2sg6iAXrGPce7yXBXt
 8+8PZF49x866KY1ySuBmA4xkvJ93bWysho8Wf2ji5neKCLXeB9U+EJpJd3YlmQa4iMbHiaqjpvN
 Z8exM5wTNUUS5S+/jV4F5FcR4lLySFfoxCrShxRfOYLKcSOr8/e3k6haXQsfw8tM8Ta+LUT3bG6
 UYQdb9mAUbMfoAYZ/1p3uZmU0ogDhEzh3iFMiSDDJvLh8UogjsGgq8A5pe/GoRBQ3yRqYwiYvZv
 Ybl4NehqIiWMmk61zsx1mgG/HDhuKMRGl5c/JfSshDwEpvmc7JTkFYxgjmlRlepJvdveVLjRNRK
 bN7Fje/xnywDsjfrDyBfpuJ77hQ8ye3vfSMyi//L/Boant79wTRjUNDjMZw9lYVHY82OvwhUR0K
 Xl1sVWDWqAssZuBCDcw==
X-Authority-Analysis: v=2.4 cv=PryjqQM3 c=1 sm=1 tr=0 ts=6a63338e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=UmWCymfRQi47eAz9EPkA:9
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
---
v1->v2:
  - Use the '-c' option in the HMP command reference.
  - Use "a second uri can only be used in cpr-transfer mode" as error
    message.

 hmp-commands.hx                | 12 ++++++++----
 migration/migration-hmp-cmds.c | 19 +++++++++++++++++++
 2 files changed, 27 insertions(+), 4 deletions(-)

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
index b04fc4489f..4ca2c962c2 100644
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
@@ -847,6 +849,23 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     }
     QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
 
+    if (uri_cpr) {
+        if (migrate_mode() != MIG_MODE_CPR_TRANSFER) {
+            error_setg(&err,
+                       "a second uri can only be used in cpr-transfer mode");
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


