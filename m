Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6F0C54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 10:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhorD-0006Si-37; Wed, 06 Mar 2024 05:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rhorA-0006RP-6s
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:50:40 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rhor8-0000FO-0G
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:50:39 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 426021Ot012934; Wed, 6 Mar 2024 02:50:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=XsLx1tyDhrgXnDNxozer/65JyvH6vtmF85Szz8+hE
 aI=; b=qLNhQFrAgYoCy6aJgmCryavW6U2kUYnk4htW6mAL9GOzFj8FSckD85bW+
 2RNhrSPhPtJkeURjsZJtL5irO1WFO2pX+gc8xm7mXvys9krGYAJJbn4udq2+Z7B7
 yo46CtW00Vfdkm8xOTstgzw8AXvg7vmm/YGHY89JUGFpFEKSKt8MzaIDIpYKju5F
 mqoCkB7bqqgalpDX4/Zf6EwoYrakhTKrEs/dnFIVn46RLlgAjOdVDYCqrznDLHzH
 2lPul6u6qJUhl/Ozr4yqi/ih3y5Mcfip5UOPyYec3tWhetfTwfEb04BPJK9jLENu
 55iRND/IKFqXeKGrpmJIYpA5raZzg==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wm1avrpj6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Mar 2024 02:50:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ioqkgIjYUJfpzdTWQXr1ZxwrD3M2xX68/tv0NcuYD6rbvuSJGmIomgBUCm8DgpizBKgHbDd1IQvmtvuVn6LDQN1visgRyyaUCvC0V0yeymIk0d6iSrM5MZ9DH/TD9wiCOMkE8Jvn3hZj6IGq853mufuDwow1QO2575TkWvDciHRa3KF1Z3jefNyZA09DMir6Fbiolyyqvgp3XTXEHdeEmJzUM1yRDVuipdHQGxw3z4dL4r+gu4OBwCb1VJ53wX+pigdFtnvz9hiP0JiNK3QisylPZDnC7/gOUDZQqAHvOvq+AI4PCg/PA2qgM3OcYNqpAivsNzc/15ZOGf7OOvCaAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsLx1tyDhrgXnDNxozer/65JyvH6vtmF85Szz8+hEaI=;
 b=br1k3OfqOKic1i0mZ2jy+jDHp9UNVhKOMmIMFxkXHFPSE/IjmjkNCVzCEpOQkzJz6DE1NW8okBbutsvLff3eHhYyW0aOx22JaAbzOyw1yP/g1pOwg9ckm6WjYPav0iJJ8GLYJAd1Xckgn6f1euNKOoGYLyLZkqpuN+rh9bUq/i+UxgXwt20O6W6SPXha540jxNa51+iiaPCXQFdVsvdlxdQhUei5zk1bQVfRdFIyl7AzMyXQTP0LU0Ssn67S05nJ/0lu81fe4XRrT4v9ULmMEHRqZYgKJAHtUiAK2/AZE3m5+xi8vEi1wR2LIG1Ay07if49DXkjmG/fQ1r+61LRr7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsLx1tyDhrgXnDNxozer/65JyvH6vtmF85Szz8+hEaI=;
 b=jx2lzIFOiICewq6e4NueSfZB/F692DnT1fY0UkP5ysZTxjYndU2Q8OocnCZbncuWARify9+A9sCUr3FFeEa9yRnQMPFcsv+nPMPsiDZB9U2pP2B8+twxipPv4an+Gvhra2gwWDpDtNAQugrv/NYMukAPqFB2upohVOrNdBuj4909bRO9pI6FX26YjNHN9+6CSWfxgJak4OxBgB+YfyB6b21PXfr9aqAGo+4RaNIY9mP+jm3rzXHjLIYs2FK0HU/8hoxeDVW0MQsF+rMCOBatWg7ILsrW70/FS15rjnnQwGR7rBMMaFQx0LA6909gWzFA68O5S7Vxy4TycAnSzEhh1A==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by DS0PR02MB9617.namprd02.prod.outlook.com (2603:10b6:8:f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.41; Wed, 6 Mar
 2024 10:50:34 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 10:50:34 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v3 5/7] Add channels parameter in migrate_qmp
Date: Wed,  6 Mar 2024 10:49:56 +0000
Message-Id: <20240306104958.39857-6-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240306104958.39857-1-het.gala@nutanix.com>
References: <20240306104958.39857-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0011.namprd21.prod.outlook.com
 (2603:10b6:a03:114::21) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|DS0PR02MB9617:EE_
X-MS-Office365-Filtering-Correlation-Id: 38bf2206-ba33-4e4c-70d6-08dc3dcb401a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TqNho2wVP8Nag04jUdeLv9smO+je+puPNYt9c34yL25y4TnTp+1bmo9rMk74nogRLESKa2yGEiPpRHPp+qq9OPx6V/CLaASDJCeO3GCE9FUVacPjvVWcjuf3giWvnAg9INAla9i7R3Qk1R+hLyUp/VoQXmXhcQ8FxKXIx+0C2cJsQZEXNzjorc+fm2g3rokd7V95PweoLGUHgOqmUocB4WYX2xVxa4v+6Jv0CjTsgtJawIH/jv1J2lOk5qc+FWli8JuwEpfqmxYMEJklNpPKLhxGudBd7+AXYFX4mz1amYPQ+faZD/goawJwht4nwdf3iE3GrxXK0NoAAUD79glNEfiTNVP4E5zNKpyfBy1LUvtT1O2bk9IMcwfVK3Mw906dJ03CptQS0ALQuhoGhXxNccbm99NXdNwcD8wvDuTJlJC6Vz3RtWKMdZQSUAtWkOjS4wCwUOeCZKvw3E0hMAUBjNYItcEYakIHsq9tUSS2Jr48ADOuJ7OF0/tVttIdytJ9R4zrKtPnC0kIq6JeXob1LMQ8E6hV8zGBWX2/pyn12rFiVxyOEIhcgOOxHmjhECem7b4wCHS9iy/ylZt8sVJhCQEtKKHX5OIYy/lUAfNTvVCXQsNJS66wpz5GXdjOJOnaAhs3rFO1GAWWaip5g1Qa8adrJqksFwrs+L88Rgf/gRA5Uh1XFTQdqgZ7TEt1kxuVNk1aE5smd3EFRE4lIvHTIzJZsdbPviMBB6+nTN3nsxw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wpYHtyRH0G4JJpNW7o4B6VmsM4vdc5GCtJNHWVe1nDzsrFAHq27K4mLAmaH9?=
 =?us-ascii?Q?i4+pueUxat3oCvn1dLucIY2YdgsWsSBHAcejixtorQhrIlJMa49k845ErKKv?=
 =?us-ascii?Q?0Cx8z6rsZ4Vt8ZtudY7M0gEBrz9LeXhMb5uPaOGQzFC+Apix5nVNYVCh0DdM?=
 =?us-ascii?Q?iPj/0EwaYPQ8q4BKtHkR8cjkvQd2Mk9oq6rjRN7OSVPrV/ED39MF2v5GwlES?=
 =?us-ascii?Q?OIZ09FhAwpBU2fR3D3NC8Yxw8jWViyKrkFsIIvyQdx1Rhk5D09Wd9ldMVP9U?=
 =?us-ascii?Q?wCrcGsBqRAZOMO/ntfZqlCQTEC1NbDmGlcHChGSFeKAG9nS6YfWK1j08di5j?=
 =?us-ascii?Q?9KZzWw4ruQXHjdSlCZL0wMN+HK/o6aZCjzvRO7LgRxP2mqGvNeLMumknoBbs?=
 =?us-ascii?Q?f1laGgY3Rbic07Jv3NGXFxXSfrYDtGkLqjmAA036HFOjsw0m84zPAWR1DTg0?=
 =?us-ascii?Q?yaMVT/DFSICpSteKtiIApNXBPnDXfq/EgEuq/MXblU0jX/L2PbuKFIPQMiPt?=
 =?us-ascii?Q?XVHC+vLTno9/Iw55rSdgw2ueFjr019Lp6Q8f12hj9jqRQn2hMPYym0H+2NDO?=
 =?us-ascii?Q?PqLNZEXzwGwaEpUarMHA1jODSOmZ7cwriYkFMh8JuHKFgSBVUAUYUR+jFayK?=
 =?us-ascii?Q?oybKRTPYrh5yUKECn4Uc8n27rzb5IG2S7OvnGdOJAMfHi7NIyzGS4vARPk2u?=
 =?us-ascii?Q?UN8m7WR2aUlK0kU4En+CGvJ2kv6ZX7lfXmvjzpLLght+S5PP0622peR2w37d?=
 =?us-ascii?Q?uzdATGDgQOZpD75dehNty5ySGLsN4LjpPLKyIkAJGhHTXwgdH3le2ZYVk8wy?=
 =?us-ascii?Q?Si+ivAiO3Qcp5Go4vKops+Hhh7SDEAwKd7N615u6XVg9Z4JT31RXvEbgjo1B?=
 =?us-ascii?Q?V5MxnsrzxKodOAAAkuDeFcmsadiI/cepXZC2RXFl8dZ+UnqhfCmnTKiHc0DE?=
 =?us-ascii?Q?/z4enCcyZTRoeckGtfdQRcgp2IH64C9MiXKjtfAvQYxX2EJNi7CASfWCrl8y?=
 =?us-ascii?Q?m44SgcUoLswGB8YrFhuI8sLmjIPbgw+OLVUN+T2MbPpunI3kGT05JizXZWgl?=
 =?us-ascii?Q?SnjTlqMSXQmVL6A8OQoOWCtUSBug73163RAx4ORs5tqJjrbrrxs2Cj5Jx/TB?=
 =?us-ascii?Q?+xTiee72fN1Z6JsBqqRRf8cZRFJSPNd7GcpNuyOLi0IQg59Lbmh3I4ha5fPd?=
 =?us-ascii?Q?NoXFIeuxrWgflwAC+zmN5FXPsfpEng+h7qHCVqVkszE4dstGRDZSiVCNtPcl?=
 =?us-ascii?Q?PvK1wjRrbvXzRVMtR8PRCRQC9jbwyhsVLZUp7fK7Bq3kqU7RAqjOtTWOs9E7?=
 =?us-ascii?Q?dcWObOggTt3ac8Mt5OJ0r+YanvTsDosBuhzi2wsnoih5Ho32uZ3boUbJve5z?=
 =?us-ascii?Q?xtitukQdRZXAPnCxArTW4flzH4Hcs4Q0Tlqo+ojyjQ3h+A6nW6g8jPG4T2pE?=
 =?us-ascii?Q?OdvlXjvV8DJbT04e+hwHuS41sQK03gQll/SUrvNwtZAXgZUmBdx2J25AzNzX?=
 =?us-ascii?Q?7vKUfaaWqUC21/0Fz6M6RieK44ti2Sso9aiQ5qXQcGIvkvdjl9wF8RxWGa1D?=
 =?us-ascii?Q?Sai8bU3Ws+Bwow3s4pp6529y7IAB5Hx9wfTpDC1E?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38bf2206-ba33-4e4c-70d6-08dc3dcb401a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 10:50:34.3915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCett0x+pkiL+L6ianpdSzvbkK5d0TEqRq45/YmmSSRzL2SBTBOWUc2e+AhLO4lPzYMg6gcAmZlGVnV2iNkfmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9617
X-Proofpoint-GUID: DCGL9oh9n074NTHcokIoVPYPwr20t8Bk
X-Proofpoint-ORIG-GUID: DCGL9oh9n074NTHcokIoVPYPwr20t8Bk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_06,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Alter migrate_qmp() to allow use of channels parameter, but only
fill the uri with correct port number if there are no channels.
Here we don't want to allow the wrong cases of having both or
none (ex: migrate_qmp_fail).

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c | 20 +++++++++++++++-----
 tests/qtest/migration-helpers.h |  4 ++--
 tests/qtest/migration-test.c    | 28 ++++++++++++++--------------
 3 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index df4978bf17..0b891351a5 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -19,7 +19,6 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qlist.h"
 
-
 #include "migration-helpers.h"
 
 /*
@@ -154,10 +153,12 @@ void migrate_qmp_fail(QTestState *who, const char *uri,
  * qobject_from_jsonf_nofail()) with "uri": @uri spliced in.
  */
 void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
-                 const char *fmt, ...)
+                 const char *channels, const char *fmt, ...)
 {
     va_list ap;
     QDict *args;
+    Error *error_abort = NULL;
+    QObject *channels_obj = NULL;
     g_autofree char *connect_uri = NULL;
 
     va_start(ap, fmt);
@@ -165,11 +166,20 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
     va_end(ap);
 
     g_assert(!qdict_haskey(args, "uri"));
-    if (!uri) {
+    if (uri) {
+        qdict_put_str(args, "uri", uri);
+    } else if (!channels) {
         connect_uri = migrate_get_socket_address(to, "socket-address");
+        qdict_put_str(args, "uri", connect_uri);
+    }
+
+    g_assert(!qdict_haskey(args, "channels"));
+    if (channels) {
+        channels_obj = qobject_from_json(channels, &error_abort);
+        QList *channelList = qobject_to(QList, channels_obj);
+        migrate_set_ports(to, channelList);
+        qdict_put_obj(args, "channels", channels_obj);
     }
-    migrate_set_ports(to, NULL);
-    qdict_put_str(args, "uri", uri ? uri : connect_uri);
 
     qtest_qmp_assert_success(who,
                              "{ 'execute': 'migrate', 'arguments': %p}", args);
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index 4e664148a5..1339835698 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -25,9 +25,9 @@ typedef struct QTestMigrationState {
 bool migrate_watch_for_events(QTestState *who, const char *name,
                               QDict *event, void *opaque);
 
-G_GNUC_PRINTF(4, 5)
+G_GNUC_PRINTF(5, 6)
 void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
-                 const char *fmt, ...);
+                 const char *channels, const char *fmt, ...);
 
 G_GNUC_PRINTF(3, 4)
 void migrate_incoming_qmp(QTestState *who, const char *uri,
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 19bb93cb7d..f94fe713b2 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1305,7 +1305,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     wait_for_serial("src_serial");
     wait_for_suspend(from, &src_state);
 
-    migrate_qmp(from, to, NULL, "{}");
+    migrate_qmp(from, to, NULL, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -1455,7 +1455,7 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to)
     g_assert_cmpint(ret, ==, 1);
 
     migrate_recover(to, "fd:fd-mig");
-    migrate_qmp(from, to, "fd:fd-mig", "{'resume': true}");
+    migrate_qmp(from, to, "fd:fd-mig", NULL, "{'resume': true}");
 
     /*
      * Make sure both QEMU instances will go into RECOVER stage, then test
@@ -1543,7 +1543,7 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
      * Try to rebuild the migration channel using the resume flag and
      * the newly created channel
      */
-    migrate_qmp(from, to, uri, "{'resume': true}");
+    migrate_qmp(from, to, uri, NULL, "{'resume': true}");
 
     /* Restore the postcopy bandwidth to unlimited */
     migrate_set_parameter_int(from, "max-postcopy-bandwidth", 0);
@@ -1624,7 +1624,7 @@ static void test_baddest(void)
     if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
         return;
     }
-    migrate_qmp(from, to, "tcp:127.0.0.1:0", "{}");
+    migrate_qmp(from, to, "tcp:127.0.0.1:0", NULL, "{}");
     wait_for_migration_fail(from, false);
     test_migrate_end(from, to, false);
 }
@@ -1663,7 +1663,7 @@ static void test_analyze_script(void)
     uri = g_strdup_printf("exec:cat > %s", file);
 
     migrate_ensure_converge(from);
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, uri, NULL, "{}");
     wait_for_migration_complete(from);
 
     pid = fork();
@@ -1725,7 +1725,7 @@ static void test_precopy_common(MigrateCommon *args)
         goto finish;
     }
 
-    migrate_qmp(from, to, args->connect_uri, "{}");
+    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
 
     if (args->result != MIG_TEST_SUCCEED) {
         bool allow_active = args->result == MIG_TEST_FAIL;
@@ -1820,7 +1820,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
         goto finish;
     }
 
-    migrate_qmp(from, to, args->connect_uri, "{}");
+    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
     wait_for_migration_complete(from);
 
     /*
@@ -1976,7 +1976,7 @@ static void test_ignore_shared(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, uri, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -2441,7 +2441,7 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, uri, NULL, "{}");
 
     if (should_fail) {
         qtest_set_expected_status(to, EXIT_FAILURE);
@@ -2544,7 +2544,7 @@ static void test_migrate_auto_converge(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, uri, NULL, "{}");
 
     /* Wait for throttling begins */
     percentage = 0;
@@ -2852,7 +2852,7 @@ static void test_multifd_tcp_cancel(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, to, NULL, "{}");
+    migrate_qmp(from, to, NULL, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -2881,7 +2881,7 @@ static void test_multifd_tcp_cancel(void)
 
     migrate_ensure_non_converge(from);
 
-    migrate_qmp(from, to2, NULL, "{}");
+    migrate_qmp(from, to2, NULL, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to2);
 
@@ -3214,7 +3214,7 @@ static void test_migrate_dirty_limit(void)
     migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
 
     /* Start migrate */
-    migrate_qmp(from, to, args.connect_uri, "{}");
+    migrate_qmp(from, to, args.connect_uri, NULL, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
@@ -3255,7 +3255,7 @@ static void test_migrate_dirty_limit(void)
     }
 
     /* Start migrate */
-    migrate_qmp(from, to, args.connect_uri, "{}");
+    migrate_qmp(from, to, args.connect_uri, NULL, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
-- 
2.22.3


