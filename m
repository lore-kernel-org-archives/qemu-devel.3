Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25548C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 16:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk4rr-0003Iz-43; Tue, 12 Mar 2024 12:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk4rn-0003IT-W2
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:20:40 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk4rj-0000iT-WC
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:20:38 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42C8KOtl002774; Tue, 12 Mar 2024 09:20:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=CxCJbh1J+F1g/3hkhkhwxypNhNvcLs4MqSzGo8O+S
 /I=; b=YBzdgeHG7GRDy/DuwMaILyHSqK4OV+uqqpi8BZ3pk91iSgZ3h6bfGOcNy
 UtcIepG9WN6IE+onR/UHPBzKD7Adtcpu0YyHWKFZxw0W8LOAaTX7TcpJb+pofQXf
 IQeY1QzfOF9dmTs+K53Q93Dt7OC4XSVxjAm5mMkep85CxR1SF6+1OG7QK3qjKc/X
 KsC8KAr3AK1d1UIJPxW5BZfcDg7reQCH708sm++9ZDvRqTtrLctk/k0xaJ62eu9e
 sG3hi5O/QMfEeQMOoSAC+HC/ZVIENyCYDGow18qTvrz7IdP/Lx8Wbli3R3BXYIkB
 gb434Rl9jWlViOGq+u9TLJvcdx/pg==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrmj9ph0g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 09:20:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcJtxyN56Zrg/ceznGJAY3x3e8HPyfsEW+YuxT5gbHy7d7Vz9ZCYCQJTiRauNDTDwjl55JwoDfBoc+AC9b6ADHsH1zpONmKpzi4ZPEQvoNf5W1iDi17brC3MYgG7ZaGrFO8AnbvXYw3ZCcXTDr4cMNPVXQhQknXa7G98AivRswqE0aSSrIStoqPA7AUlutCpxV3s5Gb6gL9rvzJkY2kODEcHqHUCHA+rqV//Pk7wmmP96+eJl8DRsiPMMGwMQHbh6VpE6+5rMD4hJOCrMkEmXRlYQat3939Mk0VkvYy2l/lHzPJNeBSBp6O33/5FuUA2TRmzASKDTHjA1XimQMoHpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxCJbh1J+F1g/3hkhkhwxypNhNvcLs4MqSzGo8O+S/I=;
 b=aom3yNzv2VYVrLra+5KRMp0mLTGXnGZMyqOAWKwDUYIMqXeERJgrvJBCykQhTjAzgXVmw5chDbFWJ36MXVOAXSfP3p2w+w7pyCVWvehkE/w7zQms6iT9M/XFfCKw2tGFkbIUMNvVS5canokbMfHlVCxQ5HIHoPesk/MCRM25omuEkgR8hrRJqv52rleFpRZpqW7Fmj+iWtYYytawzrdmblABkzdEzsd5buLkRqMm0A9KS7Lb2tWxE6oX797h/Le1P0hIrnRMzL5Yj4zQT94Aq8p4qxyJ+yUcOrPgWAjDIwnnPiMhCzJH0hLSmGUpiv4Tvm9D/xsM9v9+ReXRCTpMMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxCJbh1J+F1g/3hkhkhwxypNhNvcLs4MqSzGo8O+S/I=;
 b=UAZlDLDa/HhCOJkmp7TGErZEDxRi7RivuOuNbJ68T0GvMYty39K5DCCB4KZW5Y/2XT31wzgNdjY2eeeC05glwjnadfQg5lwm2hNMHCmbyt0qhGxgInms+mFdbujmRqB9Bi1OT1DbxU45/SLOzBZQF0d/J5XK9+bGXEnkbKE7QqKbvQTS4w2yZJqwOJI8RzmI6Ph2gOMqugEooJ/oaI8ruvfxcqW+XubnPPMiEclpfWuu5kUVNLG6UsasX06/MJUFZIVOSR1mt1bsHHtM5LK3DOQqNyla3+1xnthq6m+Iau1L+46/JDGbnZ7O2wp4NBNAyJ//py/TygGsC57bXpRcVg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CYXPR02MB10225.namprd02.prod.outlook.com (2603:10b6:930:d7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 16:20:32 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 16:20:32 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v6 2/8] Replace connect_uri and move
 migrate_get_socket_address inside migrate_qmp
Date: Tue, 12 Mar 2024 16:20:19 +0000
Message-Id: <20240312162025.44212-3-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240312162025.44212-1-het.gala@nutanix.com>
References: <20240312162025.44212-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:510:23d::12) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CYXPR02MB10225:EE_
X-MS-Office365-Filtering-Correlation-Id: fc5f242e-ef68-4135-9352-08dc42b0573f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DrVPuIYGt+gHUZWl9vXI9VOz6k1NG1jWK3Rze4ZG6ODQcSr+YVxrfq52fl8W/ppXG/7Ig7/8uyt8lOyPJUzhSuKPB3dd7VbErHC/n/5nLFvV/28sUeL7layFbljr/kDQc6Me+8G/O7O2jNbqSvjtWdHCziXymjvPvKR5JHSRTHNllp2Et17tNVSuCjC/dwBk7Lot+GbtzDcLAKEEgtYiZf5S5I7VlzKkcASwUXv/7o2qA4Xp+IP2tVncSjqre5ny3PlkZpNTU/DxSHFPhCDGynaOi3Q1jX3jUprygDl+xWanGYYsztdrkVhbaklEBJjREuXxMHZWSZTzEPUBHPF74LgzxUaSv+KzeleyPrfUTsUqNPm29mfWRfxZjNpykCJ0ivyKwsKe1lykrIuI2AZlSnlsWzqvrZIeITXTRQBg3W5mPqDt+Mq5uhQWay6how1XEL5n3Cj+dDzKV9j1YTU0mPO2pknZpwMGURsuOttsI83fgkxaKKJ3mTVFk2VcfqNS3BBJH9jVHYl0eOUGxFTQWpiQ2stfQQPssKShh6Z0jytSddYmUCACoJ7PtZNs1RrxZC1NpA+cyViyQpF1GbpptJvEL1/jteZ1TrCkMdh73GZEHzlgy+r4JsXtaw9IIQCDbM3REbz8poeM0HT2D1CRx6t+2Ro/lbWomu5NH46vkUj13r6pHVlwvIjNYCEpCTOIutH2t/mU3GfWG2QjapY4y3KvCsJqqQUdqWJytm5IO2s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(376005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hygO/DGoGMvisWPCCxY8+VDfZ9eGQiaSOWS8pt2AKxbWO0RGWkQ4PESQ/vUJ?=
 =?us-ascii?Q?GTuu41W/E/uUJctJV3t0Ro8y4NI88o1SGUQWjw+eAek5n6wKdjUTh5W7mOAs?=
 =?us-ascii?Q?CxFUVx/34JW/MAaKhBxhu+lA/SKvGlzVG7j5MiK8G15GMyo+SYqnYREIo9g2?=
 =?us-ascii?Q?kld1a2pCJpRFkrsW3StKT+8VwITz2KfUZDdBLv2vNOO/v5eLL+58IPIpwmf5?=
 =?us-ascii?Q?9QHmX22/BfybQ8vlKk8pmyYkY5gYIqTk34Qv/xcDl7pmX/qE4/moZ/WtaSLV?=
 =?us-ascii?Q?TuD/RjfasGmqT/I08EmrDraLEO2KWAUDC5AjLTigqiUMoxayzRw8n45NGLZI?=
 =?us-ascii?Q?MLbyCuVj1hEgeqhvqsqfAsTCCmfxJFsO7af7UyvGMy9Cl+K3ElqJIOXp3thz?=
 =?us-ascii?Q?mziDtF+gZovZ+kjYfoZxlanxGE2AUTTLA8EKuG6cPsL1HnMEfea1Qv3K0CSo?=
 =?us-ascii?Q?DPerWZW5UY3DmeIQJfvA+2Zu6elYL11/xS6h+UbRNaQgh7tdl7KE1XMcGNO7?=
 =?us-ascii?Q?SCTwiNUk3SvYVigUX/XAz417B7pORtFo76pe4rwP0j5kjb6NbyN0tWU8wQw6?=
 =?us-ascii?Q?cF1xunLseN7Oa5Jf2p+VEIsGOhxLSYPx1LW6iYa9MXmT2sQhk0z7VfBEuMr2?=
 =?us-ascii?Q?OO4lE9vkUt3WC65kGkOfEJ3nDSG9+NzcE+GKyBJnYZESDYg/0oYSmZu+v1KM?=
 =?us-ascii?Q?/a2O/S8M0JnXkGtDYQZbb6RQb+RcBBLXChhvfz6K0P9UI4XdRLwntcV9fnZR?=
 =?us-ascii?Q?CoJXnsIPg+/WQX6F2k/t9W2VrOmTlANiDZ4htv5CjfVrsDLyLNLS5DJC/P5c?=
 =?us-ascii?Q?Z7vI1J0AxmhZ48CLGb23+Ozt5vpVEXB7fk4+7BRLVjDieYyTC2+KZB0VOmK1?=
 =?us-ascii?Q?0niexG5/JCSHBLFtrgOUnsHiIM7kbk/xy92q4LHwa551vTv0v3hYHEjIRC1S?=
 =?us-ascii?Q?e/D8NGscaZYOURigmjacp84rUl8tlNzVzwLsGd3bmUV7rziP7KtPq8Or/3DO?=
 =?us-ascii?Q?A76mkGPPRbvZvT021RPrZtFAb6EWctNs37jOq52xjKxbPEv13cVhPoEs3q60?=
 =?us-ascii?Q?udLYbm1J2MkALmwiURoemyVx99gKixiffPdynhJUUBqGFxxwHhoP3yFU+6wn?=
 =?us-ascii?Q?cComS2HxrPt8k/nyMzEeetksYajZ6OKpt/ZxiDLDaLbdyMPkl/H0GdWWNcVf?=
 =?us-ascii?Q?5m9TIG2AG3Obzv8rGbrRVrORKm0v/GC9oVgFnzNEMmIKmkBnXzT7kpTPwVhZ?=
 =?us-ascii?Q?y8V17NbEEpG3TBUUEpzn24iQPfiyJRmdbmLfha/lWPKV3Tv/K9KATi1M+Ceq?=
 =?us-ascii?Q?R9PnNWJpuoC2YAkwFZz326LVuArSkOh8vctkMf6Kya+vtDPPuXlkNjAAAyZf?=
 =?us-ascii?Q?+hA+QL9eXUaUIOls/xltPi31zz8aBO7LR4sTi+jtR3uzGZplEOgArgxgWOkh?=
 =?us-ascii?Q?RdQnLRMyLse3XwSv/p1jlxA1XQuQBIPLQ8SkdxWPTb2hviqe1HwLVoVQxbNG?=
 =?us-ascii?Q?7WNr1LVFxmw4QLr8BQyJiHUKJbaByIBC9jzqSUMVC7uo9SDc6zvxxOnQohOP?=
 =?us-ascii?Q?XwLGv+sF9Mjo2347ARg6nW5uNlaH2twfJYQ6VzKwkAdlQwPumvabBNkr0i3L?=
 =?us-ascii?Q?8Q=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5f242e-ef68-4135-9352-08dc42b0573f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 16:20:32.6584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsSGtNaRy8vzw+t0qkq+Eq3d62KLIn3rNKO60SH+Lk8HCzr3PfaLMHI/KnShzho5tKJngUW8QpXLTv9E+RQ73Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR02MB10225
X-Proofpoint-GUID: ttZaiK3Qko3JJUoW4Kk5dq4vyCFZSlxv
X-Proofpoint-ORIG-GUID: ttZaiK3Qko3JJUoW4Kk5dq4vyCFZSlxv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_10,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

Move the calls to migrate_get_socket_address() into migrate_qmp().
Get rid of connect_uri and replace it with args->connect_uri only
because 'to' object will help to generate connect_uri with the
correct port number.

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c | 54 ++++++++++++++++++++-
 tests/qtest/migration-test.c    | 83 ++++-----------------------------
 2 files changed, 63 insertions(+), 74 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index b6206a04fb..3e8c19c4de 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -13,6 +13,9 @@
 #include "qemu/osdep.h"
 #include "qemu/ctype.h"
 #include "qapi/qmp/qjson.h"
+#include "qapi/qapi-visit-sockets.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/error.h"
 
 #include "migration-helpers.h"
 
@@ -24,6 +27,51 @@
  */
 #define MIGRATION_STATUS_WAIT_TIMEOUT 120
 
+static char *SocketAddress_to_str(SocketAddress *addr)
+{
+    switch (addr->type) {
+    case SOCKET_ADDRESS_TYPE_INET:
+        return g_strdup_printf("tcp:%s:%s",
+                               addr->u.inet.host,
+                               addr->u.inet.port);
+    case SOCKET_ADDRESS_TYPE_UNIX:
+        return g_strdup_printf("unix:%s",
+                               addr->u.q_unix.path);
+    case SOCKET_ADDRESS_TYPE_FD:
+        return g_strdup_printf("fd:%s", addr->u.fd.str);
+    case SOCKET_ADDRESS_TYPE_VSOCK:
+        return g_strdup_printf("tcp:%s:%s",
+                               addr->u.vsock.cid,
+                               addr->u.vsock.port);
+    default:
+        return g_strdup("unknown address type");
+    }
+}
+
+static char *
+migrate_get_socket_address(QTestState *who, const char *parameter)
+{
+    QDict *rsp;
+    char *result;
+    SocketAddressList *addrs;
+    Visitor *iv = NULL;
+    QObject *object;
+
+    rsp = migrate_query(who);
+    object = qdict_get(rsp, parameter);
+
+    iv = qobject_input_visitor_new(object);
+    visit_type_SocketAddressList(iv, NULL, &addrs, &error_abort);
+    visit_free(iv);
+
+    /* we are only using a single address */
+    result = SocketAddress_to_str(addrs->value);
+
+    qapi_free_SocketAddressList(addrs);
+    qobject_unref(rsp);
+    return result;
+}
+
 bool migrate_watch_for_events(QTestState *who, const char *name,
                               QDict *event, void *opaque)
 {
@@ -73,13 +121,17 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
 {
     va_list ap;
     QDict *args;
+    g_autofree char *connect_uri = NULL;
 
     va_start(ap, fmt);
     args = qdict_from_vjsonf_nofail(fmt, ap);
     va_end(ap);
 
     g_assert(!qdict_haskey(args, "uri"));
-    qdict_put_str(args, "uri", uri);
+    if (!uri) {
+        connect_uri = migrate_get_socket_address(to, "socket-address");
+    }
+    qdict_put_str(args, "uri", uri ? uri : connect_uri);
 
     qtest_qmp_assert_success(who,
                              "{ 'execute': 'migrate', 'arguments': %p}", args);
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index d9b4e28c12..9bb24fd7c5 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -13,16 +13,12 @@
 #include "qemu/osdep.h"
 
 #include "libqtest.h"
-#include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/range.h"
 #include "qemu/sockets.h"
 #include "chardev/char.h"
-#include "qapi/qapi-visit-sockets.h"
-#include "qapi/qobject-input-visitor.h"
-#include "qapi/qobject-output-visitor.h"
 #include "crypto/tlscredspsk.h"
 #include "qapi/qmp/qlist.h"
 
@@ -369,50 +365,6 @@ static void cleanup(const char *filename)
     unlink(path);
 }
 
-static char *SocketAddress_to_str(SocketAddress *addr)
-{
-    switch (addr->type) {
-    case SOCKET_ADDRESS_TYPE_INET:
-        return g_strdup_printf("tcp:%s:%s",
-                               addr->u.inet.host,
-                               addr->u.inet.port);
-    case SOCKET_ADDRESS_TYPE_UNIX:
-        return g_strdup_printf("unix:%s",
-                               addr->u.q_unix.path);
-    case SOCKET_ADDRESS_TYPE_FD:
-        return g_strdup_printf("fd:%s", addr->u.fd.str);
-    case SOCKET_ADDRESS_TYPE_VSOCK:
-        return g_strdup_printf("tcp:%s:%s",
-                               addr->u.vsock.cid,
-                               addr->u.vsock.port);
-    default:
-        return g_strdup("unknown address type");
-    }
-}
-
-static char *migrate_get_socket_address(QTestState *who, const char *parameter)
-{
-    QDict *rsp;
-    char *result;
-    SocketAddressList *addrs;
-    Visitor *iv = NULL;
-    QObject *object;
-
-    rsp = migrate_query(who);
-    object = qdict_get(rsp, parameter);
-
-    iv = qobject_input_visitor_new(object);
-    visit_type_SocketAddressList(iv, NULL, &addrs, &error_abort);
-    visit_free(iv);
-
-    /* we are only using a single address */
-    result = SocketAddress_to_str(addrs->value);
-
-    qapi_free_SocketAddressList(addrs);
-    qobject_unref(rsp);
-    return result;
-}
-
 static long long migrate_get_parameter_int(QTestState *who,
                                            const char *parameter)
 {
@@ -1349,8 +1301,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     wait_for_serial("src_serial");
     wait_for_suspend(from, &src_state);
 
-    g_autofree char *uri = migrate_get_socket_address(to, "socket-address");
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -1733,7 +1684,6 @@ static void test_precopy_common(MigrateCommon *args)
 {
     QTestState *from, *to;
     void *data_hook = NULL;
-    g_autofree char *connect_uri = NULL;
 
     if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return;
@@ -1766,18 +1716,12 @@ static void test_precopy_common(MigrateCommon *args)
         }
     }
 
-    if (!args->connect_uri) {
-        connect_uri = migrate_get_socket_address(to, "socket-address");
-    } else {
-        connect_uri = g_strdup(args->connect_uri);
-    }
-
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, connect_uri, "{}");
+        migrate_qmp_fail(from, args->connect_uri, "{}");
         goto finish;
     }
 
-    migrate_qmp(from, to, connect_uri, "{}");
+    migrate_qmp(from, to, args->connect_uri, "{}");
 
     if (args->result != MIG_TEST_SUCCEED) {
         bool allow_active = args->result == MIG_TEST_FAIL;
@@ -1843,7 +1787,6 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
 {
     QTestState *from, *to;
     void *data_hook = NULL;
-    g_autofree char *connect_uri = g_strdup(args->connect_uri);
 
     if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return;
@@ -1869,18 +1812,18 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, connect_uri, "{}");
+        migrate_qmp_fail(from, args->connect_uri, "{}");
         goto finish;
     }
 
-    migrate_qmp(from, to, connect_uri, "{}");
+    migrate_qmp(from, to, args->connect_uri, "{}");
     wait_for_migration_complete(from);
 
     /*
      * We need to wait for the source to finish before starting the
      * destination.
      */
-    migrate_incoming_qmp(to, connect_uri, "{}");
+    migrate_incoming_qmp(to, args->connect_uri, "{}");
     wait_for_migration_complete(to);
 
     if (stop_src) {
@@ -3006,7 +2949,6 @@ static void test_multifd_tcp_cancel(void)
         .hide_stderr = true,
     };
     QTestState *from, *to, *to2;
-    g_autofree char *uri = NULL;
 
     if (test_migrate_start(&from, &to, "defer", &args)) {
         return;
@@ -3027,9 +2969,7 @@ static void test_multifd_tcp_cancel(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    uri = migrate_get_socket_address(to, "socket-address");
-
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -3054,14 +2994,11 @@ static void test_multifd_tcp_cancel(void)
     /* Start incoming migration from the 1st socket */
     migrate_incoming_qmp(to2, "tcp:127.0.0.1:0", "{}");
 
-    g_free(uri);
-    uri = migrate_get_socket_address(to2, "socket-address");
-
     wait_for_migration_status(from, "cancelled", NULL);
 
     migrate_ensure_non_converge(from);
 
-    migrate_qmp(from, to2, uri, "{}");
+    migrate_qmp(from, to2, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to2);
 
@@ -3394,7 +3331,7 @@ static void test_migrate_dirty_limit(void)
     migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
 
     /* Start migrate */
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, args.connect_uri, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
@@ -3435,7 +3372,7 @@ static void test_migrate_dirty_limit(void)
     }
 
     /* Start migrate */
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, args.connect_uri, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
-- 
2.22.3


