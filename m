Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81163C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 21:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjnbf-0002yX-Q4; Mon, 11 Mar 2024 17:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjnbQ-0002th-9d
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:54:36 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjnbM-0003Bb-Ep
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:54:35 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42BD9aGl009722; Mon, 11 Mar 2024 14:54:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=3l3bMBC8Trpkn7vCOkiQAOET6Cayivg6A4Sma1s+Y
 Nc=; b=sW96tFvuiMSkHJ7URTxEpe0r8IfdOa9TKfKesLGl5nmPOF3Y9ygR7t5Dz
 006DQBxWuRv2GdTIaolgqkERcVsbN7wLCMnfrTNcMblkVHxTAwvPo600TST2csiJ
 cHJTIdLDcokDW2sAltZ6L9DLcBKAAZbRIPGTNjbbnEx2T5wM46vLHlP0gVPQS5uD
 Fz8OzNzKZ06v9XuJeoa49fxCjVjzrQKoiXfmrLxK8Rw6iunMXXxiuMVJ5bZ41DFo
 b/B/I1DHEkvkM6yGvO0Db8vi2qhRcql+/dPhvd0Ob/ZagdMMs1s4cQ1g6HUijUX3
 a15unuIqjsy4zM0xM3yNAJrx9jb7w==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrqygmc7y-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Mar 2024 14:54:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWO1T1vVDtk7fQ3hRg6l+p1hAjsKBu1ux0t+qmP+Cy6LyPUZk1MmLT6y6qLsdOicPBnKdpyhiIv/az0xwRFvlQ51+BWNcX4Pdr+ndYmeGA5lg+PA/dk4k8FxoxHwZkViM+s+jRMHXmnaD3Kc1cX8Fd3MYrL09MAzUpht7PddHZLYIDLN95Sb0StafWSL+hvCAbqfagcqnKjRmv9Zmx1Ks0o53SSyvirmOL5QetEewiafOgeLpUWC+ayCIbDceGI0BrAtj/jH04FXFRCcXkwXA1rd8jqbXXOjt0xMTX7ua3OMSv9kyrrAIt+M9lP1PHqMjTqBRPs1Hns0N/UM8xiNRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3l3bMBC8Trpkn7vCOkiQAOET6Cayivg6A4Sma1s+YNc=;
 b=ReTPAfI5335jekHJDVcaNvi+TQvNEynXzMTD3xonFncjWWOXaMEKwfSS2qsOJTFI1Q/p7mJFVyM7XwnKuVYjKkhOX9dYudsokh04AemIE0gRMtlVPI254I53k/qVyiGfeIKFT7uKvRjfE0mRUO0ocJfH91p7SwMDcqPxa/pZdtM8jtj+2K6BVXT96UmBkzNu4Jt5zlg3NHnHzBc4LspeD1aPg38Pba3C1fTKrEKc05LGxuXikBy5b9w8rTmsWsX5ytLdrtm+cRUtvI1H5DAoLzxYQGYzou+dUmaKmDjVSLDnlI6AgPJYleJx6eLpHzp841Dv4oBGilouQv1XTVdVtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3l3bMBC8Trpkn7vCOkiQAOET6Cayivg6A4Sma1s+YNc=;
 b=db58QKwRqQkQTzTzCNAIASOXaJZXnsqOnMT0PI+3DN4mUb8H4jsprP94vlJLbr4w66WlqRklY5xOMtgS2Fs8vLIr37ZHTn4PFo6kIxZE+yu0NYpIW/93VOkkpj8aX6nV8NvhmnbIP/xyhES1+oOhtSJ+n0Ny3a/u/uTMUw3Qq3EU6/nHEGKgG7dyUqm0+Bh4cRJ5DX9s1zvKdMkPKqjI47Ktq4SfWVCCyo7SeW8f4NjvZ/2ROggmIovHUqoewSKs11prHnc289UCt7ByP3/DQD1tLs5WpeBjZc4z70lAAY9abK/woJy/TSKiN7njyMHUyi+KE7eJimB0l6OBO79yDQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by BY5PR02MB6849.namprd02.prod.outlook.com (2603:10b6:a03:20c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 21:54:25 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 21:54:25 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v5 5/8] Add migrate_set_ports into migrate_qmp to update
 migration port value
Date: Mon, 11 Mar 2024 21:53:55 +0000
Message-Id: <20240311215358.27476-6-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240311215358.27476-1-het.gala@nutanix.com>
References: <20240311215358.27476-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH2PEPF0000385C.namprd17.prod.outlook.com
 (2603:10b6:518:1::6a) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|BY5PR02MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: 45723cbf-840b-4de2-e314-08dc4215cc94
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 63S+XIIqxVkMpGkAFJOmN8oOQXAbQXGNkNJNj7mjRiEADatKZMitC3AueLyCcMlDNlU7UrrhuLPUIY5DrVmjjLzLcgk/Yqw5XvuwpZcl88mZgf7dp3MLDWMcVKbN5lIkPmj8rsQ6KYR/9jazlE64mx+hpWJR23D04q9KMpB8GPhrtXnGMQYcuCAjmT1zLi4uDURysES0WxQCOSm2GpkxDzAPUolU0FZr4/fTf3TGOL2ys+BVeAomorAsi2k16lcs42tU6hpQzoPCUOSrtd+OiZhPZH2doXM5uCkbzdZgl6tFEZCpY3HVaXsFpEiQHzE4hYFmq5gWdfeNATzb22ubQFqxmxLWr5YZhD8yP3diGjAIG6RYFSBBI0eIPWS51NvjmKbejlBiGPwMbn41l5Qmxd3tXHeAvnHRGo+n2M5BH9d8yz1BCk4Uj6MjnxUw+7EZMCORHOfH/Xl2gdpQtRVZOyv+BzjQjcNZkz4f/vlCRqxTqDMPcT2h4vlEUm+0vE1c0BF1pE+Ap5MQqEoEtil8E3nMXCRtO4UGgaSGgccRC+XHH9MYY43DANELZWRol5HF+m1u2VQuFypwrtkIYb/88Am/Hx0CcF15m/kFMIfLUt24AR9gJXRdvYE0EEzBAsYOCbPAh4LAxF6LIsOueiv3xcdrI9A/jEslqqARxXQEOQGCRmAy6ZMfegPHdjE09i1I/QvFyXEUOPeR6ozSZUcTCYS3qnjTvnqZjc5PLJ1pKPA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(1800799015)(376005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WEqSHnJbFq5CrbmuRIV7yh+BXtq5AMshqAx8+Tnj+X3KASzB02446TEK5KDG?=
 =?us-ascii?Q?6ZVtGE7at7LaWjL2Bxx6OOC/yPuheeo5TBdjpS0LvQkS2V8ZPxey+UyeAy9U?=
 =?us-ascii?Q?B4WpxUBh2EVmHYszUVX0PZNJMCeFmlzUlMlKQXehcn3bcq0aZM0fumj7qLHg?=
 =?us-ascii?Q?PSGjTuJQlGI8MYPH444Dy7B6fgOEJejsSO2nkLzqivXjvlAVN6GLDIf/EyZi?=
 =?us-ascii?Q?sEH31vb67rHQM6X7h9shHIC/UPxbSS5Ypp1YybJ3f6K1fYGR1ReqhlH7XsPD?=
 =?us-ascii?Q?IA6YETqyM4ARE89+dLzdr11TV8aztyFGuFfBQRkgP1ENjJHPyg+t/n0+DyTt?=
 =?us-ascii?Q?Fr+KHgsW5VxNla07ZotlRr3RG1hI/PggD5WR5HVipUt/8Js6O6sz0sNHlPgh?=
 =?us-ascii?Q?cwejftqDyXMSswWAAovo4iKCg+7iRCTjK4imATnaG6tuDNSkw5Oy9pfwRVOx?=
 =?us-ascii?Q?X4HsjiOlKWvxRVDCAfrorfP5vLd+X43ohA0NkRuuHRvEq/LsS3lDPHvLADge?=
 =?us-ascii?Q?uKsvaxZS2RxvR/TUn40B4iVTgORiGN7K27m8kKXDisnbHGWBIPJ6kUVD5H+p?=
 =?us-ascii?Q?k1uuR74C4DF9r1Gn5EgX2poIaWA4fSNb0uITsu4frs+DLtTCqUGo1NbewGw+?=
 =?us-ascii?Q?4zx/1jelWhyQORSIbv/PNQ3iE+MaEJ39DoKRekXFY43zeRheP45yO+hjW7QQ?=
 =?us-ascii?Q?o+Cy71PC85VaTemmQt/RZWsMIpnA7sZTtWB7wtnlDJ1P48Iqap7TgluYJ4sk?=
 =?us-ascii?Q?T5AbcklpJcrnq9xG3oaRdaYBCk8Qf5DO4fdeFkeQNY60Vz7g3w4TVFSZHpF9?=
 =?us-ascii?Q?S6EQe5n0G978RCgVKz0KBcahlaYPvUbgsp7RCcBKBVDMiKY9TI4UUOG6+8I+?=
 =?us-ascii?Q?Jj/21Kv23Hgaq6HZg9vWnAxoRN6Lv4loETwgDptWuFpbvzUZValkyra8ESUp?=
 =?us-ascii?Q?lF3k4WA9jdeHuVNShRnYq4Xb9IERTsG/+e66diVfY9vzCnmparK+n4au7757?=
 =?us-ascii?Q?KFWs003hE/d3ukI3FFdApPobw8WLJ+TlGRWlYKTG8zvX3d+DqN5YJ53OOlbK?=
 =?us-ascii?Q?lxWIuDHrAngCCgjB0LXG3Leyhgb1663aMM29U12LmREjWrs60vW20nzJMjVV?=
 =?us-ascii?Q?88wn+KS2F1ZtVm9631/ZvWBrvqi0OnHQTK6nlh+pV5CN+8Ays9AV65caSi+T?=
 =?us-ascii?Q?1AokcjShY9m47NvwNNAQEuAbtJ4yzLPNSk2zkrTQyqNvogUDNKamKFnjxbib?=
 =?us-ascii?Q?YKMkNTsepfytEjo6/Epu7WW/cCrVj9e4pzffd6mb7db+oQ9LpI1JbK4NfkxF?=
 =?us-ascii?Q?bA0rDVnjnPiY7MsaSDD7iuhHYdfXlnWHZuAI75KSTImfBa6GIi8gijS8Y4+l?=
 =?us-ascii?Q?H3gP5pvc/WwnILkyJGG2iiKXcv4hZHn+LwxOYrthgkOA7FSOhrl8YZ+J7YHO?=
 =?us-ascii?Q?FBnH0kLbaDMoxwjfTfoPXoPFIP66yt5piWs7FIRXMANAywH9uRq8xwv6//un?=
 =?us-ascii?Q?s2qIb7D+59Tf6TNtuzCIX1ms5u10RofRNUT/jCZX4tmflsUwWTlniX3MJ7a9?=
 =?us-ascii?Q?5IgsqBDpJLwAbpdStKVoIFrosa7D/eYJlYKb5Q7pjDC1HuDoHek/AtLZGNkd?=
 =?us-ascii?Q?6Q=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45723cbf-840b-4de2-e314-08dc4215cc94
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 21:54:17.4894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MwhWh9b45yJOcVK314flVbVxbH6s8BOVHZwlM+iow0s+A3dz8Rb9/f6BXXMbfwY38+75epuVwCDxzlt3EKzS3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6849
X-Proofpoint-ORIG-GUID: QwciuwYm2-31GiieWL44xC9qEYtYs2TK
X-Proofpoint-GUID: QwciuwYm2-31GiieWL44xC9qEYtYs2TK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
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

migrate_get_connect_qdict gets qdict with the dst QEMU parameters.

migrate_set_ports() from list of channels reads each QDict for port,
and fills the port with correct value in case it was 0 in the test.

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c | 75 +++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index f215f44467..ed8d812e9d 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -16,6 +16,8 @@
 #include "qapi/qapi-visit-sockets.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qlist.h"
+#include "qemu/cutils.h"
 
 #include "migration-helpers.h"
 
@@ -48,6 +50,37 @@ static char *SocketAddress_to_str(SocketAddress *addr)
     }
 }
 
+static QDict *SocketAddress_to_qdict(SocketAddress *addr)
+{
+    QDict *dict = qdict_new();
+
+    switch (addr->type) {
+    case SOCKET_ADDRESS_TYPE_INET:
+        qdict_put_str(dict, "type", "inet");
+        qdict_put_str(dict, "host", addr->u.inet.host);
+        qdict_put_str(dict, "port", addr->u.inet.port);
+        break;
+    case SOCKET_ADDRESS_TYPE_UNIX:
+        qdict_put_str(dict, "type", "unix");
+        qdict_put_str(dict, "path", addr->u.q_unix.path);
+        break;
+    case SOCKET_ADDRESS_TYPE_FD:
+        qdict_put_str(dict, "type", "fd");
+        qdict_put_str(dict, "str", addr->u.fd.str);
+        break;
+    case SOCKET_ADDRESS_TYPE_VSOCK:
+        qdict_put_str(dict, "type", "vsock");
+        qdict_put_str(dict, "cid", addr->u.vsock.cid);
+        qdict_put_str(dict, "port", addr->u.vsock.port);
+        break;
+    default:
+        g_assert_not_reached();
+        break;
+    }
+
+    return dict;
+}
+
 static SocketAddress *migrate_get_socket_address(QTestState *who)
 {
     QDict *rsp;
@@ -81,6 +114,46 @@ migrate_get_connect_uri(QTestState *who)
     return connect_uri;
 }
 
+static QDict *
+migrate_get_connect_qdict(QTestState *who)
+{
+    SocketAddress *addrs;
+    QDict *connect_qdict;
+
+    addrs = migrate_get_socket_address(who);
+    connect_qdict = SocketAddress_to_qdict(addrs);
+
+    qapi_free_SocketAddress(addrs);
+    return connect_qdict;
+}
+
+static void migrate_set_ports(QTestState *to, QList *channel_list)
+{
+    QDict *addr;
+    QListEntry *entry;
+    g_autofree const char *addr_port = NULL;
+
+    if (channel_list == NULL) {
+        return;
+    }
+
+    addr = migrate_get_connect_qdict(to);
+
+    QLIST_FOREACH_ENTRY(channel_list, entry) {
+        QDict *channel = qobject_to(QDict, qlist_entry_obj(entry));
+        QDict *addrdict = qdict_get_qdict(channel, "addr");
+
+        if (qdict_haskey(addrdict, "port") &&
+            qdict_haskey(addr, "port") &&
+            (strcmp(qdict_get_str(addrdict, "port"), "0") == 0)) {
+                addr_port = qdict_get_str(addr, "port");
+                qdict_put_str(addrdict, "port", addr_port);
+        }
+    }
+
+    qobject_unref(addr);
+}
+
 bool migrate_watch_for_events(QTestState *who, const char *name,
                               QDict *event, void *opaque)
 {
@@ -139,6 +212,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
 {
     va_list ap;
     QDict *args;
+    QList *channel_list = NULL;
     g_autofree char *connect_uri = NULL;
 
     va_start(ap, fmt);
@@ -149,6 +223,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
     if (!uri) {
         connect_uri = migrate_get_connect_uri(to);
     }
+    migrate_set_ports(to, channel_list);
     qdict_put_str(args, "uri", uri ? uri : connect_uri);
 
     qtest_qmp_assert_success(who,
-- 
2.22.3


