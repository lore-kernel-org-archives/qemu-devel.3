Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E385E7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 16:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ7bT-0003OR-06; Tue, 24 Dec 2024 11:17:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tQ7bG-0003KD-CA
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 11:17:39 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tQ7bD-0003CZ-TR
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 11:17:38 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BOEfZIj018357;
 Tue, 24 Dec 2024 16:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=x1r3MHbwhGu9+6WhSICUvyGJtjt1NsH8cLxIw6fO/EI=; b=
 MJSlXycsYp6QCt3SiNl9RPaK+SWLvbuAHwOQqdKLvPtcfwMJA3sZnWd80EcFovX3
 8ltCkamwG03iFPms05vSxR1Xpth1uAYhBmmM1kZBWzPGtOr+FsxgeEYxfxt/sHok
 AD+cELDe8tw5NXyvxJpnBPWJIO2Nv+n8CJiuRBAHU5ZlOeRLhbKbL62oiv2DaIV2
 d8XevmDrZ2gQ+gntxd0F+v5WQpQoROK4D2xJfNjbGUsc4YOxoeA82QP2PFWXpoAj
 UsNAB0rNBZUa1r+t+YeXwWS8NRD4vqJe3kOnaxA5G1saolQ7zrc/KAh/L/sHXvwf
 DWCtLKpv8Sm87kFAwd+Q2w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq7rmg0j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Dec 2024 16:17:21 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BOF0MYx022579; Tue, 24 Dec 2024 16:17:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43nm484gne-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Dec 2024 16:17:21 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4BOGH9Xo021973;
 Tue, 24 Dec 2024 16:17:20 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 43nm484ggj-18; Tue, 24 Dec 2024 16:17:20 +0000
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
Subject: [PATCH V5 17/23] tests/qtest: optimize migrate_set_ports
Date: Tue, 24 Dec 2024 08:17:02 -0800
Message-Id: <1735057028-308595-18-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_06,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412240141
X-Proofpoint-GUID: Ha7TK6qYHx-1iWuDXVso7IfQjOoVkhAY
X-Proofpoint-ORIG-GUID: Ha7TK6qYHx-1iWuDXVso7IfQjOoVkhAY
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

Do not query connection parameters if all port numbers are known.  This is
more efficient, and also solves a problem for the cpr-transfer test.
At the point where cpr-transfer calls migrate_qmp and migrate_set_ports,
the monitor is not connected and queries are not allowed.  Port=0 is
never used for cpr-transfer.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/migration/migration-util.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tests/qtest/migration/migration-util.c b/tests/qtest/migration/migration-util.c
index 525bf1e..ed46fab 100644
--- a/tests/qtest/migration/migration-util.c
+++ b/tests/qtest/migration/migration-util.c
@@ -131,25 +131,32 @@ migrate_get_connect_qdict(QTestState *who)
 
 void migrate_set_ports(QTestState *to, QList *channel_list)
 {
-    QDict *addr;
+    g_autoptr(QDict) addr = NULL;
     QListEntry *entry;
     const char *addr_port = NULL;
 
-    addr = migrate_get_connect_qdict(to);
-
     QLIST_FOREACH_ENTRY(channel_list, entry) {
         QDict *channel = qobject_to(QDict, qlist_entry_obj(entry));
         QDict *addrdict = qdict_get_qdict(channel, "addr");
 
-        if (qdict_haskey(addrdict, "port") &&
-            qdict_haskey(addr, "port") &&
-            (strcmp(qdict_get_str(addrdict, "port"), "0") == 0)) {
+        if (!qdict_haskey(addrdict, "port") ||
+            strcmp(qdict_get_str(addrdict, "port"), "0")) {
+            continue;
+        }
+
+        /*
+         * Fetch addr only if needed, so tests that are not yet connected to
+         * the monitor do not query it.  Such tests cannot use port=0.
+         */
+        if (!addr) {
+            addr = migrate_get_connect_qdict(to);
+        }
+
+        if (qdict_haskey(addr, "port")) {
             addr_port = qdict_get_str(addr, "port");
             qdict_put_str(addrdict, "port", addr_port);
         }
     }
-
-    qobject_unref(addr);
 }
 
 bool migrate_watch_for_events(QTestState *who, const char *name,
-- 
1.8.3.1


