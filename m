Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BB6D374A8
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 15:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1SDA-0007Bc-Jo; Thu, 17 Oct 2024 11:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SD8-0007BM-Qt
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:14:46 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SD7-00016G-96
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:14:46 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBcgJ025032;
 Thu, 17 Oct 2024 15:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=dB4HCRsy8IFj/zUVwchannUOHLDV6S6nVpfFBtaBAXE=; b=
 QzLs9vFrkNBOzP8y/ysnA9sMK5423ywIBAXQC/AKPcy0ORf8ShC7RJoN89rOCahW
 Yu19sEsOBxpOHgEfm8oL+EO9nfvZKoi6wy0rdhRrRhMKPwiXh7GO9OTsv7jUKLUj
 bVmXsi/orQICGaXGZUfQqw3MHlk9yzvNkLE7LjeRGKMJxMffSg/LPDV8n+dK1KAw
 m4C900tyOA2szOPC1zPCSrYAg167WPnhyOuFRpQymcqZroyqCO7IlAe7RKndrwYK
 2LL3Fe8ArmPHRVanBev9E6Z6b+d2XIF5jzPObgm2wARK/G9tegsWMpFIbHh0zjyo
 qwG7M8bXVMHaBNX/YUC/3A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1apg28-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:14:39 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49HEx45S027314; Thu, 17 Oct 2024 15:14:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 427fjgy6hd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:14:37 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49HFEHgt017147;
 Thu, 17 Oct 2024 15:14:37 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 427fjgy62e-15; Thu, 17 Oct 2024 15:14:37 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 14/14] migration: allow commands during precreate and
 preconfig
Date: Thu, 17 Oct 2024 08:14:15 -0700
Message-Id: <1729178055-207271-15-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_16,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410170105
X-Proofpoint-GUID: fiSzgF2sQTmP4Pkbvt_qT7ZTyMXGMZU5
X-Proofpoint-ORIG-GUID: fiSzgF2sQTmP4Pkbvt_qT7ZTyMXGMZU5
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Allow various migration commands during the precreate and preconfig phases
so migration may be set up and initiated at that time.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hmp-commands.hx     |  2 ++
 qapi/migration.json | 16 +++++++++++-----
 qapi/misc.json      |  3 ++-
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 06746f0..c0f34e9 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -959,6 +959,7 @@ ERST
         .params     = "uri",
         .help       = "Continue an incoming migration from an -incoming defer",
         .cmd        = hmp_migrate_incoming,
+        .flags      = "p",
     },
 
 SRST
@@ -1000,6 +1001,7 @@ ERST
         .help       = "Enable/Disable the usage of a capability for migration",
         .cmd        = hmp_migrate_set_capability,
         .command_completion = migrate_set_capability_completion,
+        .flags      = "p",
     },
 
 SRST
diff --git a/qapi/migration.json b/qapi/migration.json
index 3af6aa1..0468c07 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -373,7 +373,8 @@
 #           }
 #        }
 ##
-{ 'command': 'query-migrate', 'returns': 'MigrationInfo' }
+{ 'command': 'query-migrate', 'returns': 'MigrationInfo',
+  'allow-preconfig': true }
 
 ##
 # @MigrationCapability:
@@ -527,7 +528,8 @@
 #     <- { "return": {} }
 ##
 { 'command': 'migrate-set-capabilities',
-  'data': { 'capabilities': ['MigrationCapabilityStatus'] } }
+  'data': { 'capabilities': ['MigrationCapabilityStatus'] },
+  'allow-preconfig': true }
 
 ##
 # @query-migrate-capabilities:
@@ -551,7 +553,9 @@
 #           {"state": false, "capability": "x-colo"}
 #        ]}
 ##
-{ 'command': 'query-migrate-capabilities', 'returns':   ['MigrationCapabilityStatus']}
+{ 'command': 'query-migrate-capabilities',
+  'returns':   ['MigrationCapabilityStatus'],
+  'allow-preconfig': true }
 
 ##
 # @MultiFDCompression:
@@ -1297,7 +1301,8 @@
 #        }
 ##
 { 'command': 'query-migrate-parameters',
-  'returns': 'MigrationParameters' }
+  'returns': 'MigrationParameters',
+  'allow-preconfig': true }
 
 ##
 # @migrate-start-postcopy:
@@ -1751,7 +1756,8 @@
 { 'command': 'migrate-incoming',
              'data': {'*uri': 'str',
                       '*channels': [ 'MigrationChannel' ],
-                      '*exit-on-error': 'bool' } }
+                      '*exit-on-error': 'bool' },
+  'allow-preconfig': true }
 
 ##
 # @xen-save-devices-state:
diff --git a/qapi/misc.json b/qapi/misc.json
index 559b66f..ce60493 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -241,7 +241,8 @@
 { 'command': 'human-monitor-command',
   'data': {'command-line': 'str', '*cpu-index': 'int'},
   'returns': 'str',
-  'features': [ 'savevm-monitor-nodes' ] }
+  'features': [ 'savevm-monitor-nodes' ],
+  'allow-preconfig': true }
 
 ##
 # @getfd:
-- 
1.8.3.1


