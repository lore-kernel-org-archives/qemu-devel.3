Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE48C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 21:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rihKJ-00041n-BS; Fri, 08 Mar 2024 16:00:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rihK7-0003zz-Pm
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:00:13 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rihK5-0001Mt-FH
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:00:11 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 428KTdwp014608; Fri, 8 Mar 2024 13:00:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=mgdMdypUQAUmzKfR9KSEQYGmNi9LvGBf2aXNiMo22
 GA=; b=Z76jk4epxhucBLqj6Rk8VSaHrlo6ij+skJqYfvLFqLA21kh/C9RqaKlEL
 /0uePMD4smxAWEmd+gRiivB5nu4Jx1MRJOqCDV0bXXqci7+ItdPKwTQiBjCVTLr4
 t0+LFkB95Wbf/nY5sytzq9sajeoHoqEMTZkaM9/HfR302R/pBM2RE9hKIBoqmrct
 W46jI4P15TToFN9DFpWSU/z8JbR1j/8YyQKtgLPxTdiCxvwL/XSkkxJotDo3sGKU
 W3xRQeMpfSwzgCtYBSCH+Sjs6iB+LCFQpDACiMLJkBzEewJ720QPvP3zMEnS5LPA
 7vKpvgsqhkQFjvPVmAmuC/QPZ+Opw==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazlp17012018.outbound.protection.outlook.com [40.93.11.18])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wm1avx7wh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 13:00:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VK2cqQBqu1o4mOkM+LpdmAzbtFbJom6s4nTBHZti7kXOd0SGhRWqsRu28osXDb8iWdKhM64KBteJC3xKqsbyYjXk872wZyJvotVXxk8/SWR68/HVGUazdZCkdUUqgXzTv+fZqcfcA2hOsYSaUZbvkWdmATU7XoHxuxtaF2s7QTF5nhsqAa0Wsbs4aQZV9h2C/eO+IHeBfO7kQNWqVt2c3yhGofjzs/sRyWe4ZYdHYAdUhCPu/b31RtddZj/npogMWapKMkEuwQCBTfAWz9qNCeDadKi0YiqOYZ+BSt6F3fJR5MoiWq1jQDkDQG4QRKvLJgYjcPzL7TZNSrDPC/BbuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgdMdypUQAUmzKfR9KSEQYGmNi9LvGBf2aXNiMo22GA=;
 b=gx1SJH7ljz4QisqJXLUqdn0vJmnj23/ri8kdj7QfC2RjoysriGmhVZWUSuTjwzA1AbbxcbDMRhKYfqjSmoTeWO3wjtt4oRctFSAsFax/qB0xcyeKKovE0HaKkuG0SHslOZokBHooQsAhOxkkLWe0qaHP02pHZYcc+xk2Lx8bgqWVmlCxJW0y6dqnNFr/MX67pI6MN3kLIW4pplhh9cXJw2uZnnFAHQweTVR6OmP/JbatqAMVbiE0pRog7BX8awqZd/hie12kF3qgzYiTGpqfOoCsn8GkFnkJDIb6AA1ejL+R0r+/xBxI5Cq0ohUm2tfffPCCab9VvvihZ3JeyT7Avg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgdMdypUQAUmzKfR9KSEQYGmNi9LvGBf2aXNiMo22GA=;
 b=TxqmUZw7T1k6VpssaD7c4t3D6eSIDe1CzJGi6QK2YVg9b3zLjeYElLc1IfxdLKjiyjnVEWzGHEkdebhm3CavWIzEbbsHgvUw0tDNUukuLgjp3mWtO2LF5K1/GfQpVoV/J+ZG/ALiKOQcz1mZrUGwUF6YOp+OmlsbvNWPzh7XpHtx7frVKA4Q/t5bEOq1S5Qh6vfwM+WvRDPoGXKxVWxjHgxzIu/3dwADssG8v0Th2zZVhBin76h+HvwrOwseq05rrViT2NLiiLk3hrtR4N6heJzAuuJgEvgxEzy5ybtFhfO94xdZBHRRNounlXP0EBuyq+TlVmajGMLjb9HF998qJw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by BY5PR02MB6786.namprd02.prod.outlook.com (2603:10b6:a03:210::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 21:00:04 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 21:00:03 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, Het Gala <het.gala@nutanix.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v4 2/8] Replace connect_uri and move
 migrate_get_socket_address inside migrate_qmp
Date: Fri,  8 Mar 2024 20:59:45 +0000
Message-Id: <20240308205951.111747-3-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240308205951.111747-1-het.gala@nutanix.com>
References: <20240308205951.111747-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0011.namprd17.prod.outlook.com
 (2603:10b6:510:324::20) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|BY5PR02MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: 7944b6b8-a791-4764-18af-08dc3fb2b9fb
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 87EcAJp7lW9eNYSkOWRz8gDeN2801cSQulaOFjJdZhQwGN8B98PARBxV3aDXU4MT9Zpj9AXgU5d27V8sTDG1NiVFM/1i2M6bQAnnfXwv/UdJkXc/UAllMCEJHULMZks5Ad5ogT0dk7nxtJqvKIy4vYh9cOoS7oN5mfSNWMe/e11marjShb3vjo948QB3/rLGgqN2fsW28d3TSqwgfA8PRdr58OSfGmI3cAi6aaW8ukPg50Rgweswse52dXphSGOlw3t6yOIQyVK+p6QGSi3JlRGfAkXx6eqV+hib7NK2mkuG1IVoimnqAWtNDm9oqj04H2Pdgm0wGUlYZLKY7vQvARnPfqntHek1Q+cY3qewnK7CD0ullIS5xByZQAZzq4y+MlLglWJmr0SB9znAPN9gC52+KIIgtFXJQWyzOs4WPPhNG2DRhoOcRz46dl22wW+aTe2BSRQMGLIou2r1pgWhzyTm8HxHufaSLz8aoLavySMlX3Uz8isCw+l77WWSsdHDar8fQwqR0xUaCGC3CiNcyFkr/xunRPViMVfrLb2cmVXMEtxBmsYmzoRs6xxmKE+rfHapwdDLA4RboDmAcw7yDcG2zU+C+PivhmsnD4NWRBi0mzocWD53eBBYmnZixMgpVd9L8MGriYl7jRN250+XnZfgXDwdP1zrPGEhFDzjHZB1nrfAslkaic24d/c4ROyD74qfyQilYFKzsmU7bWxnNIOn55RZ8yQL1ry7jU9faW0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(52116005)(1800799015)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vGjy7EBDzd8T6GKxv+H9NoMslBwYZdgum/iXxNOqtU10U4M2NmlMlt9DH8VA?=
 =?us-ascii?Q?885uWLXZwzAYuJ7zao+RvD1jl2r21Eq11p1wo5omuThRm64tY4PGpI8vfF62?=
 =?us-ascii?Q?3wSNrBaSCRasYcVOgeNy3sJcSSQKTtcYOiCtyPHnrrwUDauyNuATpmS/a65+?=
 =?us-ascii?Q?2K6Jfri2l8Uc+Pkee7qk0q94myNXJPvzmS/JGrN6J+BV6P9tlQeDARtDfQIF?=
 =?us-ascii?Q?yX5dZlYHeZbPmNMUbvRXRw3LyGNzgb3rS9B6DzGVTeXerNFuVaEtUo+8Q0EZ?=
 =?us-ascii?Q?RfYUl5Lh7zwOBmj8gpvzt0MWnDNWwN6dhX8YfpqoosM8cz93x5MM/hyAM/Yl?=
 =?us-ascii?Q?CbOg1cGemlbdbTUjUQn7vHU3ICi6rdF7/tne3eSC/Mj2xVcfTBWq7Wxmeqzg?=
 =?us-ascii?Q?VuiRsKLxJxagU5ybGpDYACDSArK0yjX6Ks3r9fsNbKNLvWriS2aGx16XuHdJ?=
 =?us-ascii?Q?snT89fGL7phHfclXbRR/wH0/ST9yg/zESdrVRJt7WUwNeY4vRKqT+mK2KIGo?=
 =?us-ascii?Q?nzFN+/FBlfWQkCV40PW19k+/qpM7y4ZAGYViY9JBdRpzbEjCqJC8VytCgO+d?=
 =?us-ascii?Q?kdTju3+Ij9RcHV42o4h0lrCeIOmlAEdzcgUHYSS5/IfU6HjxxIMhaOp6r/7+?=
 =?us-ascii?Q?89h6VqCqEIxp3lxrXW5IPHjsK8Qr+keg4QsLOJC85aCG6CL9Tqv33IMxMxZA?=
 =?us-ascii?Q?hP8BI5tbS24ZnELQiAkPDFCxUWhGpZ0hyGjSy1EWSr1Rf4KBBw7gV6ztCRIW?=
 =?us-ascii?Q?bhIKLJekNkHhiGoJ0ML6zMleED/WSIyK8r0P6aIBYBi+6vVVOzylZGcYsjlS?=
 =?us-ascii?Q?CqSWQ7dwmptgzJZ4MBDJfH9VIONFvsvl6078rNJ1Gyi03z8t2oeu3UNu2d3v?=
 =?us-ascii?Q?TosKP90DRKEUu9tVT6wJkHYC1aZC2+JGCyYKXwOJSyULS447fuTmPBn4dvt1?=
 =?us-ascii?Q?bRG72WuqBshGnQIipM19OSax7+ad+y4LgfvFMKcbolTY9U+F1XehGpY0pvQD?=
 =?us-ascii?Q?7i8Mqq4SdZGELV8aQzP2DvRuomZ73SwZeJEnrAe0DCxYh924Cc7GCDDsjqxW?=
 =?us-ascii?Q?ON3cqGSkJPxHgDq5bucbSB2+Yi+6XII5PmD5VbjgnX9YjJMnHqtALvv4pG+A?=
 =?us-ascii?Q?R01i2nMtJaQ74dnQ3H3h6n0Q1KXKWpYD8W+O5ll/WQrAM2/IeZL5jl40volL?=
 =?us-ascii?Q?AlKlASI0NesNKJCdAAQp1vuJ4toj53upQI+rqjVu2QOdNOBoK28ifma1jeIx?=
 =?us-ascii?Q?1KSsyt2qyuQDZe1l4UIDdPvRTGAHX9MxziCwh8OMYsci1oxTygQ4Q+hCPVlp?=
 =?us-ascii?Q?6oUQg+/2mzjmU2MnKLyZy6Kd4sRBZaxOtodfwgAG3DWVQc1YZnd3A0R3+8U4?=
 =?us-ascii?Q?qNyqWSAV53aBMce+kAFQDI+8ZEAv/FwLfNoe7u2xSDmVrSsh2dG0yyflgN7u?=
 =?us-ascii?Q?Ca+HBV+NuSOZ01ymzCC7XxKMKGuQPPQlbgUvH7UUr4JbAzuihbRWp7xJd8vS?=
 =?us-ascii?Q?y34R0Wh9z3AHTI+ZTNdp9dsq2g81iIrdPKpelULISAVhdX7rGqY+OBP6LOHs?=
 =?us-ascii?Q?ela2MompSYLvosJmCXW/e7QjhPOhgK2qzWdsdYBy?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7944b6b8-a791-4764-18af-08dc3fb2b9fb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 21:00:03.7854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swvcE1W0cAstGaOb6BCXgV96UUjnmnktRRfKvXZiVyhMQtxYuC/8ms+BiAbsjZiMpZOdZ80kvMJZenMLU3QmZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6786
X-Proofpoint-GUID: X7hacLi52aARbKo2Pjq2gn3ZhHjpxhkZ
X-Proofpoint-ORIG-GUID: X7hacLi52aARbKo2Pjq2gn3ZhHjpxhkZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c | 55 ++++++++++++++++++++++-
 tests/qtest/migration-test.c    | 79 +++++----------------------------
 2 files changed, 64 insertions(+), 70 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index b6206a04fb..9af3c7d4d5 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -13,6 +13,10 @@
 #include "qemu/osdep.h"
 #include "qemu/ctype.h"
 #include "qapi/qmp/qjson.h"
+#include "qemu/sockets.h"
+#include "qapi/qapi-visit-sockets.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/error.h"
 
 #include "migration-helpers.h"
 
@@ -24,6 +28,51 @@
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
@@ -73,13 +122,17 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
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
index d9b4e28c12..01255e7e7e 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -369,50 +369,6 @@ static void cleanup(const char *filename)
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
@@ -1349,8 +1305,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     wait_for_serial("src_serial");
     wait_for_suspend(from, &src_state);
 
-    g_autofree char *uri = migrate_get_socket_address(to, "socket-address");
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -1733,7 +1688,6 @@ static void test_precopy_common(MigrateCommon *args)
 {
     QTestState *from, *to;
     void *data_hook = NULL;
-    g_autofree char *connect_uri = NULL;
 
     if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return;
@@ -1766,18 +1720,12 @@ static void test_precopy_common(MigrateCommon *args)
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
@@ -1843,7 +1791,6 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
 {
     QTestState *from, *to;
     void *data_hook = NULL;
-    g_autofree char *connect_uri = g_strdup(args->connect_uri);
 
     if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return;
@@ -1869,18 +1816,18 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
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
@@ -3006,7 +2953,6 @@ static void test_multifd_tcp_cancel(void)
         .hide_stderr = true,
     };
     QTestState *from, *to, *to2;
-    g_autofree char *uri = NULL;
 
     if (test_migrate_start(&from, &to, "defer", &args)) {
         return;
@@ -3027,9 +2973,7 @@ static void test_multifd_tcp_cancel(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    uri = migrate_get_socket_address(to, "socket-address");
-
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -3054,14 +2998,11 @@ static void test_multifd_tcp_cancel(void)
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
 
@@ -3394,7 +3335,7 @@ static void test_migrate_dirty_limit(void)
     migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
 
     /* Start migrate */
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, args.connect_uri, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
@@ -3435,7 +3376,7 @@ static void test_migrate_dirty_limit(void)
     }
 
     /* Start migrate */
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, args.connect_uri, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
-- 
2.22.3


