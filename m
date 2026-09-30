Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F76CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrJX-0000fd-JI; Wed, 30 Sep 2026 06:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJV-0000f8-OU
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:25 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJU-00045T-2H
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uw5Sq7Q7NogZPQV1gkDLgium5KjeegPX0bfj33jCwvAh6+hqMH38lMJE1xzp+DkE7MrKoquopnxnCNlq68HxBkW70bpmMD/Mttp1tiPaEGmH2e7w3doCGqiJ1BaS7XLl0xHXbjlEGlEFCldTJL1jQBSpDeOY4Bn15B2WEgda7LwiEm7RAblRrdsw5uw9/THN8O/4p+cUstwmYd49+sduEd5LCaXlp0SGFN9xHGMz6xXOz+DgdFg32BNjBcJzFJ0jM7Ym3WskhUC1XwQ5M9a3yFiQ07JGIjDXkr1pICA6G04K+NRUSqqamBtkixj0FG7BBcQ6quHgZHJkOrGpx+o5bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzhhEOopcN3KOOtfWAhLZROUNYy2FrEKLzdoJ27vb+k=;
 b=Jw5MarrjAdeMs0Vht4WlV54cWHLG4sNiSqszUmcJ+wrKh7OIn4UXX+vs3SsnTGs24cn/UiFs7mMdVLwBuV22IV3JCaanmihYO0Jpogvu/9Bw+qytrLtitR9x/uWB3+DwwGeU2xqZF0cFIDcPb0Ec3J2jeeWs0bMl/4CaKcS3pRgla/z7n586ChZDBdFTKcd4mS1JIcFvrek9Wi3PKKeDciSs2P52NdRWhJqR1aSBiYL/OS7tD3zv+qOMaMd0TYe+tFm+AAYtiQWiv/66WkilIhcAvuk4rEY2gF0Rk/TFkZHJdyhVutuTLg72VHi2WxquFavzCdpOO1nqHUNGOdQjrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzhhEOopcN3KOOtfWAhLZROUNYy2FrEKLzdoJ27vb+k=;
 b=BMaSTfZE0B0CNUBgzT5NHVvPQk4SS7J1llfvAT47cBfSqXFOQYrq3BbJAVR9Kj9vSjLBitgYzNhVv2tg5ICN6v/gHctreB7SkWJFZyR8ggY4ro9TlzOZ64kEKowVvXjJbftUp0WPL4V8DXT/dJDGFDLK/KIeC9XBnm0WwPQHdVHLYsttmlsLockjVDz6dsRDZYUvPYnCDNILNga7W428WPvLJioRAMq1UVHbpHxrQaiBWKY/HXq+RYoyipLkz8jOrLrQZeILSoLfV9asnry3fnlei3kbgTOmlBENELZPUOyBV+ci10xMxzsLxf4+/OSfsiFlFRmyeKTYwydUHn+5WA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM8PR08MB6420.eurprd08.prod.outlook.com
 (2603:10a6:20b:314::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.9; Wed, 30 Sep
 2026 10:13:17 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Wed, 30 Sep 2026
 10:13:17 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 30 Sep 2026 13:13:01 +0300
Subject: [PATCH v9 02/18] tests/unit: add test for duplicate keys in CPR FD
 table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-up-vsock-vhost-v5-v9-2-e9096f629770@virtuozzo.com>
References: <20260930-up-vsock-vhost-v5-v9-0-e9096f629770@virtuozzo.com>
In-Reply-To: <20260930-up-vsock-vhost-v5-v9-0-e9096f629770@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: andrey.drobyshev@virtuozzo.com, clg@redhat.com, mst@redhat.com, 
 sgarzare@redhat.com, maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, 
 bchaney@akamai.com, philmd@oss.qualcomm.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 farosas@suse.de, mark.kanda@oracle.com, dwmw2@infradead.org, 
 peterx@redhat.com, vsementsov@yandex-team.ru, den@openvz.org
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0066.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:337::10) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM8PR08MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 870d0686-b001-4734-98f1-08df1edb725b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|23010399003|366016|1800799024|10067099003|56012099006|3023799007|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: OLuzDXDa0Rjp1QcTbem8aZaIYd2fNmw5+627Z8gRN6NbtNyZMAiMaVWkX/VX9NPdfk54KaXLfLPtz1xOl0iacrh6jkhcH5H4a+Mb1r+LoO6camnqvqMn5tnFq33QIKaijd9rP+FdgN7Xv4irnDTfPFOU8TPPQ0AFpBcTOiQsF3PrAR/hlfj5AqdszSp0CVUw+V3wEDv5pNTSDdPZ5oXjv9+w6FcK77NuXRVb+RTHdii47ZgFSHsDKAy0fwdBy1HHL7jm/q4rO7RDTMe0RejgYKe0dZkyZUs9Zp9KbjxFd39t1Bg0u1Fqz+lkmA8BQ2RvhEpyVZiU8COVJYybAiT4APgAendliJf7qDSo4DcJbBhi95QifoIWMlWOfvHNMW7DmURbEUgYiG7Dm9Sx+xA6V5n6gQhfdkLryIrL32fL7/9YcknM+nffMVdcEgMCehu5pWXO9au9Jyp3OKz3i+u6JsK9X8zTmHc71YSE3h2MKrG1LpsMJE2evC69yGTZo8QGyYw7n1TrvHbiPd16vyJDzc3GufTYtHSiGDt4MJfgIsldBvsg0sTudXTfkiNQj1qnhK9x8gzD/tzIiElUvjAsRLJbKFvJGXCM9cGGP9yfXm+BnlVTUK5uHgMx41AelE8aGYOaIkVtzlm1Mknfs29hTe3V7XlT0+CbovE4GD69EJHoQ7Y3CRzF7IGSZEQvts/vxcTohQTQYORYpB0ol3IXnGDj1FoB7r8GaO550lcGA5E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFZ6WVNjWXpBUzFQYXV1MnFQQVlrbHU1NXUzbkVYTVNZd29LVmo1a1VWb2lH?=
 =?utf-8?B?amo1cTQxb0s4RHh2RTZTQktCdXY1cFRzdFVibUJEZ2N1SVNmaC9MTlZiM3JM?=
 =?utf-8?B?eVEwWFBpb0FlTm1aRWt4MUs1MWo5TXQ5bUZ4L0xCVXQvTWU4YUJCcmlVTnNz?=
 =?utf-8?B?VzBrYUdReHpIbUxoWUQvbGhEU2dJTHpNbDRhYTV3aUVXM2pzenIzYThSWUIv?=
 =?utf-8?B?Q3gvOFdldnQvamJNRk0vbUNUTTlUNWNOTldhOU03dmZVL2F6MGNQdUtZMi9s?=
 =?utf-8?B?Z256ZGU4V1pOMnNjSXdGN21lRWt5ZDZpRENjaDljSjd6Z2Q3OGZ3c29pdm1T?=
 =?utf-8?B?L0FxaEhDYUdEUkd4dXdwMTZiMHVTRFNXNVd6djUyS2tIQk0rcDVlRzJmRVRW?=
 =?utf-8?B?SW1tRjVVUnZ5UUozU1h6N24wNWVzSDNQRlR4Q3NMVGhrZ0R1MkRtNzZtbzI2?=
 =?utf-8?B?ZGNXSHp4NHZ2MzltaVNpayt0MTdDM0NlRy9jeEd5TGlvUnU0QWdjVVZIbzVl?=
 =?utf-8?B?S3NMeHp5UnZUb1BMV2hnTkd5NUhndU5rakVEQVlnRFViMkJlY1NZeFg3aGdU?=
 =?utf-8?B?YXpxOUNNZjhOMlpMMVUxNnk2N1piYUN2dUtQRHFwT0pkSEw0Q1I1bU1ZS1FC?=
 =?utf-8?B?Z2h4cEZYMDRzSElySjZ0TTZSSlJtaitaTDNKdFgzZENmSU8wY1dqd2o4SXZX?=
 =?utf-8?B?STIweVVZd2dnTUpFTXEwb3pzWFgzTmFTKzRPS0JaSEZOalhibTNwZk9UV3Bi?=
 =?utf-8?B?VGdiWk1ac1lqaktjdzRZVFpCQS9XVG1MSUlpUVNqYkYwRm13RG9vTklyTzVP?=
 =?utf-8?B?NXlJdXY2Q1h3ZjNYSzI3eHRlcEt2T21Femo3clM2a3RHek9md3lMVzlTazZm?=
 =?utf-8?B?cjdNODR3ZXloM3lGUmRnNXpWeWtpZ2VYdWNwMTNoNnlPNURNeFBhamd2c2cv?=
 =?utf-8?B?b1ExMGYrQS9BN1VLbW4wK0hZb2pqRHArOXZJWHR5elNYa3ZNdnNnK1dOYkJp?=
 =?utf-8?B?cG5CZnB3TGZPeG81ZGdNaHhLanBFVUdlc3AzSk01NXZZcFFYTjBySE5TRjhq?=
 =?utf-8?B?cW1lWlZteEcxaFR1TjBmWTVRM2JJK3dSa3AxSE56U2dmczJlMTNML1F5R0Fi?=
 =?utf-8?B?WjdoS2JUbHhpV1A2OW8vdzc5ejh0b0h6V3ZWK3BRWkcyMXp1SXhia01XN3or?=
 =?utf-8?B?cndjSTlaSWt5bkpQNzhzdThEREJiK05uRlRiRGUwV2kwR200QTBkdWg5ck9p?=
 =?utf-8?B?ZU9XQWdTSndXcm5UOVpyODAxUzhMUTlVWklGYjZuWE1YTExQUmkwaDY4clJ3?=
 =?utf-8?B?b28vRzE4cnJCcHBwOXVOVEJmRE54aGxieG9nZHc0M2ZBUzhlaThYNFpidUJY?=
 =?utf-8?B?K3NVUk1yVnFVK3ovOTBicTdUU2FRMVd6N3N2OThmNkdhOFhoRUhncFRiMjFE?=
 =?utf-8?B?YVh0dkJseDhuamYrNHJ6dHdNTnJzMFVlWENzNW05Qi9BM0lzd3RUaGdZR1Fj?=
 =?utf-8?B?K1VhQmhIZUtCcjlQckZKaXBuMHRrc0IxZ2FDK2N0WkZOK0ZyR2tnaE1XbFZz?=
 =?utf-8?B?YlJyc0dmL3NQeVJCM29zUDFrM2ozUEJOTDJKaWg5NmhGWjNHdjUvYkZTSlE2?=
 =?utf-8?B?cmhVaUdqc0hDME92bjNqMnhjd09RbVNWeVpDSUd3R0crcG4vUTE5blFhOXFo?=
 =?utf-8?B?MFRiVFB3Wm5peXg1TWN1MzJ1cDZNRVU5Q0xlb1kwTzMxUEZWZkVMdHd3bjVp?=
 =?utf-8?B?cEpzNlVNTTNMOVpMVEFuQ2xmRDB0bEFCZC8yeU5NaE1ydklZZFNHYUlDT1F4?=
 =?utf-8?B?aHlWeERRYm0vWVFsUzNJT0FHcDNsODRCeTZMV1AyRmFJcjFQTnZrSUhZVk9R?=
 =?utf-8?B?OWVTOEszUzlzNmNJQVR6Z3hlYU1CU0ZOb0tZNmliRExMSnE2cmhFNmpHcmVy?=
 =?utf-8?B?Y2RSVDdTblVvenU2Q2d0RjRPVzlmRzlUMU1BWUxFa2lxWnZvRHhMbUtaQXJh?=
 =?utf-8?B?dENnbWh4TXA4ZTZidWVwTHdwMGVpM29kTXMwVXhyeUFmc2lMRC84bjl0UzRE?=
 =?utf-8?B?enphT0srdjFGVngvaXBKYWNBLzZmSGpiTFlPZldyMTNBOUdHRTBMSVdKN1oz?=
 =?utf-8?B?OVNwWGR6WHJtSWcrYlhtdVV6QUxDYnJ1bTZSTFZwTVdNSGpJQlAySjU0ZU84?=
 =?utf-8?B?L2h1KzgyYVd4ZE9ocU91dUFleUxzL3d4VDVMTDBKM2hQSFZ1d3pmblB6TVpX?=
 =?utf-8?B?LzVBL0VzNllWSVpvdVpKcE9lRGJqYUtnMHdCOFJYNlEzVmJQanp5bjREQitm?=
 =?utf-8?B?bmw4dU51TGFPcWVhTng1Q3ZJZEdxVEFwRkZDQmk2U3I0QnZXNnN1RXZpVDB2?=
 =?utf-8?Q?6FspKBWVWJNjPCIo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870d0686-b001-4734-98f1-08df1edb725b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:13:17.6343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1m8UT0wVxQQKMdQfbbjDz+m42LfzuR60kvfv32oRIen5LMwUQ34RdyzKLJmcYbMyM0VwxPHMe2y9Zc/qewkUDE1nM4RgFsR0jT8wE408+sg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6420
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
index d17435c1877..5d2b413fcab 100644
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


