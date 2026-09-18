Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA3CC982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Z0t-000859-Qj; Fri, 18 Sep 2026 09:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7Z0r-00084m-Ii
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:52:25 -0400
Received: from mail-francecentralazon11023120.outbound.protection.outlook.com
 ([40.107.162.120] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7Z0p-0003od-Qt
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:52:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Anm4hp7Sxzhx0IOMB+ueSijfkmadnqNBQsS7AbxS1Zrdob9Rt55PSv/7EnfUEXyJ4SSAmhjTguDduuMa7R/Uo8CbKOHJddorQmJJrjAl0uOYmhIESef0cK5uTa/USJAx7112lwy8fkWfGoGyl/HA9DYi7BKQ32jTcxHbmvHxZMUmyFerYwrysV7QF/SjU7i6bSSbQ7i+x3n57RpWaEuUjG04kImaEfe4DoZFEshOkAbPZBoQqcI//nIi5NS/yDc1WfhmOp2fMSBYFu+2hRNnZt6hhzo9YMJoxaQGd8umiF9n4tIsqshR7LODPYxaK/S+ldvHVGD1OIWVl+a+8aqbLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1BPlhQEjh1ve1t5MaJwKpaCjZIQvshKVhE9sp4dYpE=;
 b=VYxPeAyaF5jBLP+eNs21EGaTHvMe/GsryqAA4oNL9x/tuYGQticZZXOcLcUEfyxKTUH2KFIpTjQaNFwUbSQwWXJ4J2NIKTpnC8Ja1whp46peEHyR620Q0WZ2bcsSq8J1gEvvAFoyyofQY679QfNsFpGlTnSzTCmgn80JrcGMgPOtbaNaytPOCsWyLfHkKUgzfwVhd7Bg2KkbZhPpBpxxun4gtPX0IYxE4mPMORAXnzP0OzN1ldx3S7oET0Vsoq7a68czX/EqIfs2rgyEB6dQcYsP/6z3vsO5CPXvs+eKJx0UQMUTuYsjSdVl24AH7P9lAUxEIix7YRV5KbgQbOlirw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1BPlhQEjh1ve1t5MaJwKpaCjZIQvshKVhE9sp4dYpE=;
 b=XCoDy/5FdalpPtJcTbmtFGZ0i1YXEvwgAyK4n5AynFHVdwuJ7M/yzCAcM0sTE1ZMslNlshWxr11DxBC/N+hwKoB3tBl+We4WkJ50GGHCKTPBoBjOmRuSAq4Lrd1WGjwdHiyYdHlZvW6W4qB1+zKZLGoP+zerfd9e/lOAik4I8IFLPTMYO9ijlZCApxD8kmLP/VO1Q9Obttdf3rswr8rD6nZKTDB7gGo1BCu4Jcnkob9om4yFJws08mDcbUhfID9LBUFKii0oaQmQSzRoZDbhpCQCl87UoxOaVZQvLz6Lql/vshTrbokRMzDOLdqlqYbeoKIoB3ad/iK3KVh7bg8I8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB4PR08MB7933.eurprd08.prod.outlook.com
 (2603:10a6:10:37b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 13:47:18 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Fri, 18 Sep 2026
 13:47:17 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 18 Sep 2026 16:46:53 +0300
Subject: [PATCH v7 02/16] tests/unit: add test for duplicate keys in CPR FD
 table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-up-vsock-vhost-v5-v7-2-6ef9ef033c35@virtuozzo.com>
References: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
In-Reply-To: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, bchaney@akamai.com, mark.kanda@oracle.com, 
 philmd@oss.qualcomm.com, vsementsov@yandex-team.ru, 
 andrey.drobyshev@virtuozzo.com, maciej.szmigiero@oracle.com, 
 dongli.zhang@oracle.com, mst@redhat.com, clg@redhat.com, peterx@redhat.com, 
 den@openvz.org, sgarzare@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR07CA0292.eurprd07.prod.outlook.com
 (2603:10a6:800:130::20) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB4PR08MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: f4530d5f-df8c-4809-1be5-08df158b5aae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|52116014|366016|56012099006|10067099003|3023799007|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: GiqHoezY86L2tTtkjBzi3xD9n0WO/uvPNUpmntI+WbMElhIn3oxBjxA6IDjODeV75HG6jRAvg+f7PTVKIiFKtgudAVkPphiGakt4XcWd0A2D34h/+ehLBTsi9wsqcEZyVlhYqurqyV0YXAS9UBqONo5U1OJWFANWBnJPGRKCFiXtHI+jNBAVKlEVMr3kpHfHnibxwZqAjni3339x+hmbXVRz1pywUaxHytKKUkzeR3Yoa6FzP/f3flk2mVAyuVITwOQh53J0ssjTsT0FQ515j2/hyT8l16JyXPkoATsQldCwMrjH40+4zts9QoKqUQ5CsU6Dkbgyz/TenhAAvGofG0HXWY0NMQecth26ULGFL4i0Mwnrdta/VI3oCXhfyUTpZcwOAOGixNbUigMthtejh6+K+pVLfHy5HACmZiEbOcEQC0O5obYWZKBJPobomPkDPBd2y2DBjbzRqIj6B111wEhNlBoOZaNcwsjIxj1UuJQMYEehCliseyNvbC/SH0wliOkOeOFxYxkWuDPVyX3HhdHWt0W59yUBQqc3uvWULGQh6XqaTUsqhYAvPcFYC5fZe9m1XcICLBUuosdUXURu4NxdHy2NirP2/9xRvoIJlz3fqN+3k2Vp/8dh+KLRPg8CD1oo7+i9K0l8IeGCA0xz/rcodMOKx9GFedEqeoH/uFRaSZ2FXqHNib62c/yAXcA0e1SMTss1CpnAkrkwwQ+SrqEP5dmaRHdGHWSvbDy1kGo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(52116014)(366016)(56012099006)(10067099003)(3023799007)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWowY3NWRVdScmphN2xYL0REcCtVQXZtSEVkS1V5TC9oVnhTR1FZdjIxVUNs?=
 =?utf-8?B?YkxjT3htK3FaWE52Nkc5WVJPVklDVkRTMTl6c3VqVFpaMG1nNkRNSFh1Ykh0?=
 =?utf-8?B?a1pZNXMyU3hZcUVKYVpEOExKQnJCNWJLRG1KdFBBZURwZklTQjJOZEdITmNm?=
 =?utf-8?B?eXhPNm9KalBtL1FkWU1ISUtoTElJcHVzT2VYbEJ2Z3FBZUNBaWY5RDJYMi9o?=
 =?utf-8?B?aDh3RXFXY2pvNHY3SDk2a0RORE8xLzVGQTJzVnNNNDd5enJ3dTBKZmxVWExz?=
 =?utf-8?B?VnNQeTU1U3ZYZit4cm94RkRWVUJjeVp4MDFRaERSY1NDbWExaFdKT1k3K0w4?=
 =?utf-8?B?RHZ2NTB6T3hKSVJlcTVic1M4VUNpUktFNmNEamEvZ0hLcGdwZTZYMlllT0tP?=
 =?utf-8?B?OWlEQzZpK25ORm1XZEtqd0RMOUYyWlpKVE5JR0JQTU9TNmZLRjlPR2RDZEs1?=
 =?utf-8?B?RnR1N3hONzlzSjVYU0c1bjRyY0YraE1seHN6akk3M2R6TnNCbUJyQ2lYTGJs?=
 =?utf-8?B?TmZ6bEtOY3pPSWtvenQzYlJOZUlvMGt3ZWRTaGVscjI1N2FzT2pWd1RjckRn?=
 =?utf-8?B?enhpOVYvbWtqRlViNzBlbUs4b2gyTkpZWDhEWUt4anNMNTNEVVF2b210a1ZR?=
 =?utf-8?B?cFlnUnVmbW9wNTB3TTJNOVlya0dZSTduYzhrRGNaN1hMREFHdWhIT0pYejBH?=
 =?utf-8?B?SzhiMjVwUnBTR2hOVThyMlVhbm5SZG1aM1FydEJHaXM5dU5kMnkwNTJ2QVNE?=
 =?utf-8?B?eWVycU1wcEx5SVhOWjV4b0NZTlQ4R0Ura0hFZXp3NEtka1ExT1hXc2plZmox?=
 =?utf-8?B?c2JIeGZHVFpxRUMrWEJRTXVEbWpURmtLcFpOUitrZkpJdG5Ga2YzNVI3a1RF?=
 =?utf-8?B?ejZ2SExTOENwdVpZSEdhOHVrME92c2wvaFFCSjk0bVoxcDlBOC9TdVc0MXp6?=
 =?utf-8?B?UVlObnIvRUtsSW4rb2ZWTitOUFhKaStIbGpzYUNhTFJyNkFmbUtRV2FYQS9q?=
 =?utf-8?B?N0dJaHVxckh4K0lQeVBaTU9PN0Q2YjVSd0JWbWNrZk5lbWRDNk1WNWlIYmRa?=
 =?utf-8?B?WGVCQTRwM0wrZk40M240WHduRWVRVWpHWjF6TzJ4WXcrOW04R0dVOXBBRDA0?=
 =?utf-8?B?cEp0OWVzVEMxUG5PbmhxVTlvK2hlTVdzYU5LWGpVNzRaYXczdExVOEc4Vnlt?=
 =?utf-8?B?S2prREM1THdyNCs4T29ZZGZISHpZMXNtZ0VRYUV1OGJkeEppK09WOGppemVV?=
 =?utf-8?B?OGZtQ2s4em8yemZuUGVic2lRY3N0RUszcG5PcjBNTzNtbVB5MzFoMWwrVXdT?=
 =?utf-8?B?ZklZOVF4WEk0N1dON3UrUjdBa3ZHYVBkZTdZVDJtN00vRW5CUE1aRVI0cjgw?=
 =?utf-8?B?NGMxcVVvVzFoc0owdkZwZExWVlUwZ01VNHAxRkR5ak85U3NBTDg3c0pTZU56?=
 =?utf-8?B?MlFqcWJEek5pT1JpY2lod2NpVitEeHdkRWIxRCtMZXhIc0Y3N0RiZkI2RjhK?=
 =?utf-8?B?SCtrRE5xOGtCdkFLcloreGlYZUdBNGxQUkNZRURsQmRyS1NoZXMwM2hSTkpu?=
 =?utf-8?B?NGtiUG13aU5VQkdqQkhkY0VsNFlvMjZqL3FJZXUrTGJSYnNuZW15ajBzY3o5?=
 =?utf-8?B?NkFkYzFNV1Uvd3MyK3RUakhmVkJ5Ykp2ZlJqQm9pK05OWTNxUnJFMVpmdUQy?=
 =?utf-8?B?RS9kMHdiZXZaRGtiMUJ1S2pCcjNsc2R0dUh6NmZPL1lFV1A3S29kbkNpVGtG?=
 =?utf-8?B?QzBabDdibGNwRjVwTUNmVmNnQVRIWVFjOC9SZlF1b0RvV29ya2ZCS1U2QVJm?=
 =?utf-8?B?Slo2RndnZ0tPZDFLWkl1Rks0Z0l1TGg5SnlYZWVVeDgzRWZQTzRJamdQNWla?=
 =?utf-8?B?WTZZWHE4SEorOFR4V2xIcEVZTStkTEZ1NHUzRlp5UVkyM3FYdjJ1QzdXZWJm?=
 =?utf-8?B?MGppWXZXczNKTm5DNUs3MmprS0F2MDhabzdYaFVzOWZuNHZHMkJORDM3T1Ex?=
 =?utf-8?B?NWZ6UHFFZWxtRnNselBZWUpvVFpwOTFQSUFvczIzbGRyMEpkUlpBYmN0anUw?=
 =?utf-8?B?Tjg1Q3ZiM25VS2ZGODBRQlgrWjlQS0FVK2xDZlRMQVkyWU9oUkIxamwvSy9J?=
 =?utf-8?B?R3hERk1qMVBIZ1ZlbzQxZTYvVEpoUDY0cktwUmJNUXdVWmt3MFJtNk85alNS?=
 =?utf-8?B?ZExOSkIwOGs5MTV0bVgzMXdOYXF4Y2gzYjdpaGFGZHhtWW5XNTIzRG1jOTMw?=
 =?utf-8?B?WDJuZW9mVGdhcHgrQ3UwaEhmR0NJbUFUT09FYXNIYy9DU0xaSXdPbWF3aXB4?=
 =?utf-8?B?MktzdXMwcGJpb01YTUhseE5NcVZJNXIrSHd5TkdTZU9QbisvNEZFUWhqZHB2?=
 =?utf-8?Q?7xXxvL/WWBgAL4L8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4530d5f-df8c-4809-1be5-08df158b5aae
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:47:17.8317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMu+CmNS7ceVwSwSRtpzBtQHeppMFfeEfI2XwwTocQJTNPq6w+T4qijopoft+KM76rBIGU4AYe+T4YcN4I/Ym7UewKx7vaqDCbRKWCSpvAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB7933
Received-SPF: pass client-ip=40.107.162.120;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

cpr_save_fd() now refuses to register an FD under a (name, id) key which
is already taken.  Add a test which checks that 2nd registration fails
with an error while the 1st one is left intact, that different names
or ids don't clash, and that the key can be reused once deleted.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/unit/meson.build |  1 +
 tests/unit/test-cpr.c  | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index e47bc7225ab..8d229ff60e6 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -140,6 +140,7 @@ if have_system
     'test-bufferiszero': [],
     'test-smp-parse': [qom, meson.project_source_root() / 'hw/core/machine-smp.c'],
     'test-vmstate': [migration, io],
+    'test-cpr': [migration, io, meson.project_source_root() / 'migration/cpr.c'],
     'test-yank': ['socket-helpers.c', qom, io, chardev],
     'test-ram-discard-manager': [
       'test-ram-discard-manager.c',
diff --git a/tests/unit/test-cpr.c b/tests/unit/test-cpr.c
new file mode 100644
index 00000000000..dfc6b1f2ec0
--- /dev/null
+++ b/tests/unit/test-cpr.c
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Unit tests for the CPR fd table
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "migration/cpr.h"
+#include "migration/vmstate.h"
+#include "monitor/monitor.h"
+#include "hw/vfio/vfio-cpr.h"
+
+/* Stubs for the parts of migration/cpr.c that these tests don't exercise */
+
+const VMStateDescription vmstate_cpr_vfio_devices = {
+    .name = "cpr vfio devices",
+    .fields = (const VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+QEMUFile *cpr_exec_output(Error **errp)
+{
+    g_assert_not_reached();
+}
+
+QEMUFile *cpr_exec_input(Error **errp)
+{
+    g_assert_not_reached();
+}
+
+bool cpr_exec_persist_state(QEMUFile *f, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+bool cpr_exec_has_state(void)
+{
+    return false;
+}
+
+void cpr_exec_unpreserve_fds(void)
+{
+}
+
+int monitor_fd_param(Monitor *mon, const char *fdname, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+static void test_cpr_fd_duplicate(void)
+{
+    Error *err = NULL;
+
+    g_assert_true(cpr_save_fd("dup", 0, 10, &error_abort));
+
+    /* A second registration of the same (name, id) key must be refused */
+    g_assert_false(cpr_save_fd("dup", 0, 11, &err));
+    g_assert_nonnull(err);
+    g_assert_nonnull(strstr(error_get_pretty(err), "already registered"));
+    error_free(err);
+
+    /* and the first registration must be left intact */
+    g_assert_cmpint(cpr_find_fd("dup", 0), ==, 10);
+
+    /* A different id or name is a different key */
+    g_assert_true(cpr_save_fd("dup", 1, 12, &error_abort));
+    g_assert_true(cpr_save_fd("other", 0, 13, &error_abort));
+    g_assert_cmpint(cpr_find_fd("dup", 1), ==, 12);
+    g_assert_cmpint(cpr_find_fd("other", 0), ==, 13);
+
+    /* Once deleted, the key can be registered again */
+    cpr_delete_fd("dup", 0);
+    g_assert_cmpint(cpr_find_fd("dup", 0), ==, -1);
+    g_assert_true(cpr_save_fd("dup", 0, 14, &error_abort));
+    g_assert_cmpint(cpr_find_fd("dup", 0), ==, 14);
+
+    cpr_delete_fd("dup", 0);
+    cpr_delete_fd("dup", 1);
+    cpr_delete_fd("other", 0);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/cpr/fd/duplicate", test_cpr_fd_duplicate);
+    return g_test_run();
+}

-- 
2.47.1


