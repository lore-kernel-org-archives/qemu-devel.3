Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AC7C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 20:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk8iB-0002CW-OK; Tue, 12 Mar 2024 16:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk8i6-0002Ah-Aj
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:26:54 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk8i0-0003AJ-5n
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:26:53 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42CCX4uQ012798; Tue, 12 Mar 2024 13:26:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=lggMEGI2IW/k9MFI8/VUwWezZOPlK4o83eTiatX81
 U0=; b=oKv/6uvx4c5ua2DuNtoh3gtTrF2kd/9R4EE0ueCZeEeUAqrfBSrJYF7Wn
 OSgKjrl5w8nKiIuy1ypyCTZVO1vMUsbindCf3AAVYromVG21+72PCrPSXX+kOIqB
 DVqTUeHEqcz59Z7Av7XgDn5HmrM80zesKvsYK13Q6gJH5dBNLTi1qSDD9l4q0v/x
 1pxD1rWSYX8LS39v3v/s+T8R9Ax8SlIPEdiRtuRBwSK0R2tPXNsba1ANm4qaLsZh
 OevaY7nTNOZSEcsM0LLjL1DFNouQ7qeBimA5Mk+VlZQvuX71mFIp5uDaTIBv/4nI
 ty78WjmyLbuF23aKiId8OxgxB6xww==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrqygpuec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 13:26:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IttPINEAgVt4S1u/qld1uNgv1PFHHtMBwroUBHETfEjcxqgLB/RbCJiiRuK9wkzoQ7440O8cvE5f/qfTA1joEyYaMzsjJBgOjiislw00F3dCxdCztWhALjN9m0hH2N6DQxWOUZUv8q3xgwSXif2ZCczOIDY3CHYbWRuPNFOPvv4JJHslr7TL1MDqyH7A3IF7+/0JLZgi262n0k+z91O3ZjECwep/yKvN6rQBdHEt29IKrk40NcEQ5D9+QcyNP5EKLzB6T4QaMnlS9OOvAQS7zIIcvfC+oUS7ZujoHTqmWAkVfZnfZZI/ZSr9uK/tGh/5J0qLKpL2sIfcPIjjgmpfBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lggMEGI2IW/k9MFI8/VUwWezZOPlK4o83eTiatX81U0=;
 b=Qp1hi3twzirisIzUg9iD1D9ZCIKY2zOwJ0aGVOqr/ykEg7Uj5jHY0Nhj4/Qi85+wvAdBxhwnjE0Lx0H8yMfgjlmjWF+T4nHsl5DvL0UknYsgfVowIplCMSbvBjB/tJbVLV8fJTFMt/MiEjoilvg932ByLXZkrwDcQASvbB8FW4v56Bn0EIdKQLKEwjQFytEu8CBgnWBrHKLFqbbWMM8MaMJON92fWts1JVfYcOoF0uTt29amPyfWxDCBbrbZwAzaLn4j9YitKcKC1c+LeccK/a4B9AhfCJJTrlA+6z4WgyIUWOXGH8FmSbDb18cz8BM7rK6N8lZD11EphZiY4Y8hyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lggMEGI2IW/k9MFI8/VUwWezZOPlK4o83eTiatX81U0=;
 b=WGt4qYsV28TfhtEkXUeZrxYbzb2vq0XOWzifliWRz1wQjuTazfMqWh2C81boePn04O6IqXI0GLRr45yYmTRI/OOLb3qW5DUeENQaR6o4U2og+fAzvKQ4TwgTKLwUC9DSclMAVES4OjFXbGZy8GAYccumD9JMn68S+EVh06XKqoOQrSW0KbFTihd+Qq/NHL8/R4A77stTbAhP2WAZZERMgg94FUyfqcUtIIYskJItO3sUQj4RsUEKUNxCOf+UsCSNtK/G2uiVb5nzA4Haz3WYiNTTiRsW0H+3YeAnt29xDc8Z46lzFO+1T7cGmcaMbnpCQ/zTntaF6mRL/5I1dx8xAg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CH3PR02MB10057.namprd02.prod.outlook.com (2603:10b6:610:19b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 20:26:39 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 20:26:39 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v7 2/8] tests/qtest/migration: Replace connect_uri and move
 migrate_get_socket_address inside migrate_qmp
Date: Tue, 12 Mar 2024 20:26:28 +0000
Message-Id: <20240312202634.63349-3-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240312202634.63349-1-het.gala@nutanix.com>
References: <20240312202634.63349-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::34) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CH3PR02MB10057:EE_
X-MS-Office365-Filtering-Correlation-Id: d188ce96-3120-4e49-83b7-08dc42d2b90a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Fwk4bldD0bOM9rDZKRiWnVeAV3vEbLbd+K3VqBcPXaDCYRiYFp95GAJj+M7MPgvkOBahsWOkxyV7TRb0c3YGv9phSPql3HueJ7bP2QTETYpHAocbqDHOqQSnvSdsZ22jfVXJsDbqL+hN9Gd/v/VRVLigtsN/pchwU3QbIk6hu4i/QyFZO0tZ+T0e4puu4iAyBZj8pB0fY8qPzcEcZBptPZilym1V8pxp+VwGMCJxdQrrXMy6vc2k00xuF+bttTnZ0V4rnzQB6b6bHFz0UrTvGYBNMEWO8+4E/z0mohO8SW/coFEftIogiF0PrklVNvkzUpp6c7ZIXchUyWdGJTgh6nzKuGSEitu+hpW49kTE19+mt/PDO//6V8cU9JdfLlkZGyPMDvk8eLqzQayOSeN0M1Vs5UsinBctVMlfd1q6gf2IwV0KbOxznLrJaL/gAS3ERhlbOTnG/wweaqQRKKaAsbFtj8TcgEQJA+OMwU3uuiaXY8YSG0LyRmJhrMUGPaylQVxXINvTRZfDCDWkgA9cMzX5CCf5O9tMOeaAe2ue+uLWjOPCpQpSTzeou9znkA6Sv9aPlhrs0alg1ui7EOU3yUo8kNJxe/T8yrzps262k9E687eiWpJUe9pbil8L1KYUqBM6tVLFcbtWMd7DMksO3Vw2lPdxD9rNe16mjFjWK4Tx2It9pTPndTzI7HHjLGuvy5Dw0PbSJfF3Dlt+zxpX7cjz1l4C6cB74z8KdVpJ58=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(52116005)(1800799015)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cJ2JDx35WczLLJdDGKXvC5NMzfBkjjYzlkRp9TC8V+bMrY03tKgyCPS7ovnJ?=
 =?us-ascii?Q?QGTeoDAXgPaIfyNA+C4JE1IB05zt8tXguf3EyEKTgypun14sr6iaiDWnffgO?=
 =?us-ascii?Q?RnZX8uSMS9KnoNDPSTxbBQuBx7RE5SnY0kp+2+nKwSbruVH0phZMtG0bNO/t?=
 =?us-ascii?Q?b3+pxggEs+Z7skb6LSMzTT6aG4lpGfarXDM0UCkcLfNbRIrbfhWA+N2LxQmU?=
 =?us-ascii?Q?gjtjh7qohjVhMGVGy598CjtEhlTzeIqzJZrmZ7IStRAEwAffwZ6Hs6h/DEVs?=
 =?us-ascii?Q?EQFvBZM8VM2txQKXG6408TRXscEzaaC2niCfhHVjPaowUx2XBVEa5/QZx3jS?=
 =?us-ascii?Q?bb8c05fvJPzjeAyhJiYx7sX1CY9R0FZ5lYuN+Ke1HqVqOhgRfp9FBevOfF3r?=
 =?us-ascii?Q?lHp1xolP6UsrVayyX/WWCsvGROWwde922JbIyBF4/0VOlkbu8lKMBoCpxKc2?=
 =?us-ascii?Q?mrb7mF11rVkcH2MdnI8evAtWfmR6LHfqzBeySUbLtrTgcnWjW4fc4SyNChjB?=
 =?us-ascii?Q?xk7a+PKfWyg4pqfv4/tGTAZ7yPvyJVh7tHDMVYPqBamfaulMBkE1jdgM1Gz3?=
 =?us-ascii?Q?3w4r0UGRNg5HvsOoYJGfm0jM2vY4zSCA/YlXx6qPE7dWfhuzWdSJYlEZC2BW?=
 =?us-ascii?Q?bDdPQPZ1doTP5Z99c7aroebX9rQ1CmfksGnWBFfSzEDIA5OxqZ9szTbNd1eM?=
 =?us-ascii?Q?YHNLZEb/htn1iO5X3L3EPpjheBkOO5oVUeBELmLXKR0wzr7+0CWvYrAqvNSI?=
 =?us-ascii?Q?y2uW4rHCs6n259rGJIn2isUyU0u3+7FrDuNz7F8dX2ysDS7J9uSjMGQnqodj?=
 =?us-ascii?Q?lNSwBaMr0xzYpnaEUtZKE5HFQpo0FfiklTpRTHXF5osrjloT/R0ppR43MeYE?=
 =?us-ascii?Q?4fNj5/qMGH26BxUUXFv8qH8V4evM2LLf4cGolIJ9oqhLdZgxq9bQ3ziwhZtX?=
 =?us-ascii?Q?eKEubLTkgPAVVpoAz+MetVtXrTDq09VMvELheTVPMB0lSnXbKdnwk+wh26zO?=
 =?us-ascii?Q?D0Z/iCHLDBn3xf+FhuviUDPplTgpbURMbRjPmy684B+DMvCzATkUyZp/9+ZO?=
 =?us-ascii?Q?G0rf5RErFzt3A29c9QZI8qXgjeNhCZWKDWCo8trRjewCQc86XAZ0GSq7+YRI?=
 =?us-ascii?Q?gt19C6J3v4erKKDwdtkp/mo38X2ACRydt8bGsnXBsguTbwplTPtfjze4ZOTd?=
 =?us-ascii?Q?2Ev4VON6rlQOrUNWU0bfJ+69Ck9o6/N0ywjHUMe0NAX+FdQAFG6Mdklmbdy7?=
 =?us-ascii?Q?AiUaf/1QYlVEnl5PmCHTWywBQhKs/rDuypSbk7xh8vFgo2GaD6pd770ZDmUk?=
 =?us-ascii?Q?jCrQFlwCTN1mmCqKGex7BBcQOLjy4EfEGq6cg31rdnOQsrElGYVw08Zeppx3?=
 =?us-ascii?Q?efqxIfmIg/VWThXlhlrJQhlIpzeP/koopt4MzQF5XIrKAzUNlCshMrQ/yYvQ?=
 =?us-ascii?Q?WS0vz+MDMdETdkgb5nRiKP6A3lDZ6+PmU+au9yNPC7L4PLdaG0KGMoskEUha?=
 =?us-ascii?Q?KsldEAIyLCpUUa8srJYfuxujFaIecHViGVuDwoukrWVK0WTFdgowTH3w1DpR?=
 =?us-ascii?Q?F9pRFBMtuDc1zQYdlYeamuTxsB2V5pqo/xNcBz8/g7QO3cFPafstMKExAzKq?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d188ce96-3120-4e49-83b7-08dc42d2b90a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 20:26:39.6017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQhvcvYyTH8ugKJzg3lAx17l3l9UEA2UbvqAqMLGsWIh/crNIXmWkovnSXD5gl3p75qcw5KpHCz+mhLBQv4iSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10057
X-Proofpoint-ORIG-GUID: 93U9awH9ipzq64FEj2g58oh5yBumzP7O
X-Proofpoint-GUID: 93U9awH9ipzq64FEj2g58oh5yBumzP7O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_13,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
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
index dc1fc002f5..7f6a14b19a 100644
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
@@ -3054,7 +2997,6 @@ static void test_multifd_tcp_cancel(void)
         .hide_stderr = true,
     };
     QTestState *from, *to, *to2;
-    g_autofree char *uri = NULL;
 
     if (test_migrate_start(&from, &to, "defer", &args)) {
         return;
@@ -3075,9 +3017,7 @@ static void test_multifd_tcp_cancel(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    uri = migrate_get_socket_address(to, "socket-address");
-
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -3102,14 +3042,11 @@ static void test_multifd_tcp_cancel(void)
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
 
@@ -3442,7 +3379,7 @@ static void test_migrate_dirty_limit(void)
     migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
 
     /* Start migrate */
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, args.connect_uri, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
@@ -3483,7 +3420,7 @@ static void test_migrate_dirty_limit(void)
     }
 
     /* Start migrate */
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, args.connect_uri, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
-- 
2.22.3


