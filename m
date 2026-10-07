Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BC6CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENwg-00052s-GR; Wed, 07 Oct 2026 05:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCH-0001Ip-NE
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:28 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCF-0006wV-Lt
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iw/K/4iofZS27USA6ClmITHAwZs1sBKfno+Uc4GnIC2p6pipsyEYoHZcY84BdnXzLLfhVVJGtP1x9MabykwrYjJ27XIsRD++3xv4GscmgEi13KrxekBC+E9yfva45cktLFeTzmE2l4j/w2pR12Tkd6WmF0EMCyFonjxSWBtTsnv+ADL1c7T0rkxaG+oQh9oRy93dwI4wgsPrffqByrzV5/jEOp2SjXiVC6X8sb00d0opEpA5XqwjWA/l9evy5Yhg5c4oqE0ucRHiqv+qUF58gl9CZNgquQ9ZpnLQkBSrMFouUbaNHjKcfBrVnNkjNW/AwMQa2ZPqd8v3z0pyAZK4dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zZJ89Z45bQcI+MDgmQM5LzF7kuk0PxBH91uljpEleQ=;
 b=PHoVqdIvutnt9J59CAZlafiQtxtmeS7E0cQasq4MNANM9+un5XMyNl3vlbve2wqhhGTl3ICX4hzC/imw4A4uPHeLArWBVOaSDOG5CUyaCQYGR422LsYL3Hk6Penums91639WRKorSJUe/Gr0x2jelydFOfGLlok1BcINprgFDNJy0hVV3zbBhPuMhzfzTPzmGR/P9DBjDDSizuOhElLG1DixjOTXQIJ2feSzhwklY0HqauOvw1/aziHWuEYjcIwupuhpMYNFu9OjaDmZPNNcB9czuIRRrYtVWE1KWpr5FJ46sFiXpQMkAKJI4U0cPgLjW2A/czSWlcleBsvxR5Xz1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zZJ89Z45bQcI+MDgmQM5LzF7kuk0PxBH91uljpEleQ=;
 b=f3WZn//pjdiN6UgUE1ciqr0iOe4TyNklbkIq7npRCj/tZ3AfbyEGZmrb9ZKKZGmy0wEI6mGuBVKbRcIe22x6Rce9PD00G0Kme1e9D/jGGj1BBZA+ZpnIAxwoa1hpVbASUa6PRoskzsJLto8wM0w01kkwU6OHxz1eP5PU83dUwuraVhs487nzBDES7KaxHlH2AUHHVN5bIRTdDre/OLa/s4TH9FNNWnshltRQ2b+kIkwIn2tRIMAlkOFXGWSoTQ6WMq+5D/yTQ1kqrPHkZPFr0bjexjwTYv4ps0chGfOkuHYY7ZJmLHmkurfz6L5RfnvQ7E77iQxj5IQoHNyIPMrJGA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB3PR08MB9058.eurprd08.prod.outlook.com
 (2603:10a6:10:430::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 08:40:05 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 08:40:05 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 07 Oct 2026 11:40:04 +0300
Subject: [PATCH v14 11/22] vhost: factor out vhost_dev_init_backend()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-up-vsock-vhost-v5-v14-11-e16de9962df0@virtuozzo.com>
References: <20261007-up-vsock-vhost-v5-v14-0-e16de9962df0@virtuozzo.com>
In-Reply-To: <20261007-up-vsock-vhost-v5-v14-0-e16de9962df0@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: dwmw2@infradead.org, mst@redhat.com, vsementsov@yandex-team.ru, 
 farosas@suse.de, peterx@redhat.com, dongli.zhang@oracle.com, den@openvz.org, 
 andrey.drobyshev@virtuozzo.com, mark.kanda@oracle.com, sgarzare@redhat.com, 
 maciej.szmigiero@oracle.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 philmd@oss.qualcomm.com, bchaney@akamai.com, clg@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI6PEPF00000236.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8ee) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB3PR08MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d5024a1-b371-4ed2-2d1b-08df244e95c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|23010399003|366016|1800799024|10067099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: tACXkUC2bMkRmLvu/RWtLMemL8RP2GCybMVB+1V4cuzEaDVOXjq5L4S6cWp23+ud3EWVMt+oOO/bKhkdan63NHtDo75eDCKatPmrqFlBJk46LZ7FyDHjdwRGpoJYVOVhp2kYN92k5JTNVxlBSW5Vh54C6byI2e/N9BsOOo7hY7+CO493/z86YCH4rMn8e0LXOvGeHRe2B+uda0FbrNYN7B2d/BwyrGSJEcIQjthWTVocgSXWxMMiQhjEFaFkaZ035OWbAB6m+SSDRGylocioULQGeDRsT0fFOTxS3GYgDPQT4+6OaXM0GGfWEy/xKEPk6srKIB4dUVyLtuUwebqUHx5SuEBQ95vgpYh3yt8kNmh7KKN/nifTqib/wnBPH6bjwqUuMy/z4fhQkhRwpBsTzzRXlczDlUwybXq6RST041GQqM/U4V5w0kjqugIdbU7m7avor+7aM1c+PD/fv3HuU0teK6Q44nbjBBkfVqdmProEZohDEZqV1pxGsW4P8YOLRvQlxb+h+wd/DlZSm1Z9BlaS/zfdUP+7amHGRDUfjTBRltP9j74aaZCPQ3FPzF8rzR0J1ED7TBl3LCctg5OzJt3K35RuxPmZ+XvzGHyn3pDYH0gIwEWM9stmRRCnV0U+nXuW/2uZ5EXBRxhQ09jq98W9EBUwEtTGQM7vpx08GNUgVKr24cFyINFB5zgKeFQ1zRQ90gTb6EMwpF/hmzv1berDVSPiCTRj/3WUW+uBaRM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0pYeno0WitzVmtwVXVGVHdrdVFDMENPYmZncGRhWjlVQjg1TmM4aG54aGo3?=
 =?utf-8?B?d2xpamcrd3ppMEg4Vm1JNS9naG1xWTFKbFVMSFZqdGY0YWk0U21aWGZXbHda?=
 =?utf-8?B?amxEWE5MazJQYnpDelZKcU16K0pqOHpkZHpXUHpRakowdFhzQzNOTUFmNjh2?=
 =?utf-8?B?bHJQb2xRQlhEWlJocElIOXJ1Q3Bxcms3Rk1YNFB6UWFTRTFYMDBKY3UvL3Ey?=
 =?utf-8?B?YUxQem1nUzRyNitkbXFSVVlqaXVMR0cxQUdiM3pKUXZwdk5kMmdUUWlUeXFk?=
 =?utf-8?B?cStpV3l3L1VqbkVWSnYvRHpKR1YxVmtHb2VWN0NVamhhc2RwQXNXdmY0b1p0?=
 =?utf-8?B?aFlySzI3djFsQ2RpS21QWVJqbkRxak9ZdmFmYjhDVWFCbXlwaHdQNERVRWRE?=
 =?utf-8?B?QUFyTzJoNXY2QzRqNVB3TnB0Y2hheFRhd1NSbGNhUHVEVDFYU0U5UlFoSndW?=
 =?utf-8?B?czdnMTRaSWRURzFjalJySldlcmNaVGY1UWgrK1NrZ01JRmk2eWwwblJPaVAr?=
 =?utf-8?B?bWtnWFQ1d3NHS1VjQk9wQndNOExwSUs4R0hBQ0NLZHRTWjZmLzNPSUtuQUg0?=
 =?utf-8?B?a1lyYnEzQnBFRFVsNGFrSTNNcHZkYXE4bWxkRjJYQk0wTEQ5N1NEN0didS8y?=
 =?utf-8?B?S28zT3hCaHVzYWowOXo5dVIvNHh5VFljeWpaT0ZUa0cxNUtyNzdnK2NsTDBw?=
 =?utf-8?B?Z3poemZuZnlnRzdiM3krMlB5VkpNdHlGelJNRFFqVjRUVStGMSt6Tmhwa21v?=
 =?utf-8?B?d3dsU2hLcmF3VkFIK2VwSEJ3Wmt2WDJsNmFoMjJrbERnemNJZEFRTlR3L05V?=
 =?utf-8?B?NjlGeEtzSzVNOWtRVHpXSTNKMXhuZjh5bmhHZDFpNGZjVzBQdTlqbzZXdi9P?=
 =?utf-8?B?OFUxaThWVDlkOGJadGJzVmZ2ZUtaMU82YmUyb2xVTDIwV3JxOHp2SDhQYk52?=
 =?utf-8?B?MVNTdzdLbk4yUmFINm56TExPZEhIK2lqcklidkI2WTF3bDl3Y3loNWJVWWRS?=
 =?utf-8?B?Nm1tQXhYa1Evemd5M0t6ZFlxS3ArU1dKTTk3Q3hTRE9xNDJKbmxreXpMcit4?=
 =?utf-8?B?dkRDT0RPdEs0MlhOaFF3b29kYjlyay9lVG15aEFmVmV2Y2s2Wnplblp0aFBx?=
 =?utf-8?B?aWtDWWpKZkJ6MjNlQlk5b1B1WHlSSEhlQ3d2clpWRnBacGIvait5bkdUQXlT?=
 =?utf-8?B?Nk84LzNRV25pSEZ5K2h2eU53V1lnV0Ewc0VwTW1rUGNoektveDZiL2lyaGxS?=
 =?utf-8?B?T3Q2UU5DM09vM3ByVTBvRkgreHRXelE5RDNEY2wrMGF4UnlzTE1qemdDdW1J?=
 =?utf-8?B?QWNuZEVUOW94ZkdMMjVaR1V0TDh5M1FQZWs0TEJjSkZIMVFlRDlFZEJONGFk?=
 =?utf-8?B?aHQvNEhXN3dRM1NwU0t1UVJvR0wzUGdaWi9qSEZoZVcxdWRBRUlrelduN2VX?=
 =?utf-8?B?NXdadkl0aXV2VXlhQjJDbXp6c1JvVWxoZUdDWkg2NGVGUlNoaUV3RFc4NHh4?=
 =?utf-8?B?a2M5WFprNFNBN2tYT0FOVDdKV0FRS1ZNbUFjWEZXb1lUZEdIejVRK1pQTmVX?=
 =?utf-8?B?NXVwdUhDeXlXZk9tUGROU1gzSnQxK0w5MTdKZ3QvZlAwTXBBenBXelU4VHl5?=
 =?utf-8?B?Nms2SXh6dG1MYzQvUkNDUTJmYlowMnA1TDR4REVYeE92ejRkdGtDdEZIMVNz?=
 =?utf-8?B?Ni9wZXZSWmx3WU02VEx4UXl0Z0xNcU9LTkc5Ynd1T21jNnBHN2xiVk9rYlky?=
 =?utf-8?B?di9LdHArY0kvNHZZeUI5Qi9oblVMRERTR2ZWdVcwMjdBWXVWeDltdWs1cHJp?=
 =?utf-8?B?SHYxekJuNHZXMkZLVTk0TkErZDRpLzg3NnVMand2QldWeTVRdjEvTGE4MHNM?=
 =?utf-8?B?cTdEbzhPSThFdFVSR3l0YldUdXI1UUFnZG9OYXZaTWVkOU9ZOTh1TWFzUis0?=
 =?utf-8?B?VHEwYkcyYmVOWnpxL0lkQlhxbk9jRDBiWGZxMlFZL1BrTG5kaGErRlQ1Wm8y?=
 =?utf-8?B?QVd3TWluUngyQU5Va25RcFdFRExrTDdMZVZlTFFLK08xeFpiWnhLR1M2Mkg5?=
 =?utf-8?B?U0ZDR25RUWVmM0pMeTFWU29KSzViS2hwM3hxaE90Q2toZndjZVpmcEMvakhI?=
 =?utf-8?B?WUpMUjQzbzQvT1BRU0JYYWpHb1pqOHllSmNQdEF1VExGQ0xtSmRjUDZRZzZT?=
 =?utf-8?B?UHVVSkpST0F5MFZ6SHM2VjNyOHBwcUVTdlpJc1lYbzltWWhRQTk2WDdLcFV0?=
 =?utf-8?B?UW40WThPS1R5OUY0cnVaZmZHVTVzbHA4eWw4VndJdit5bjN6M3Y0bjY3Wk1B?=
 =?utf-8?B?UU9qcEpyU1VXVlFHUEZKYTNBNlMwOW5UanRBWXhpeXk0T3F6K0pZNkVuV2pj?=
 =?utf-8?Q?3zxC3Qxz+jV+nUMg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5024a1-b371-4ed2-2d1b-08df244e95c4
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 08:40:04.9968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wtm2sunfveGZ2LeZr+KF6XCPCTgYEpsMKKod4R/5LpNAUa03EXSm/V+zT02VONvx0t4PrK5iB/ru/BSVPUjoRJUsW4N99GE8M72YMRPfbwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB9058
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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

Split the first part of vhost_dev_init(): selecting the backend, calling
its .vhost_init() and reading the supported features - into a new
vhost_dev_init_backend() helper, and call it from vhost_dev_init().

This is in preparation for CPR restore of vhost-vsock, which needs to learn
the backend's features at realize time to negotiate them when loading the
incoming virtio state, but also must defer taking ownership of the device
to post_load.  vhost_dev_init_backend() does exactly the pre-ownership part.

As a result VHOST_SET_OWNER now follows the feature query rather than
precedes it.  This should be safe, as no backend requires ownership before
VHOST_GET_FEATURES - the kernel and vdpa backends do not check ownership
for it, and vhost-user already does query features from its .vhost_init()
before set_owner().

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         | 33 +++++++++++++++++++++++----------
 include/hw/virtio/vhost.h | 22 ++++++++++++++++++++++
 2 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 68a8e404818..99561ac5868 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1681,6 +1681,28 @@ static int vhost_dev_init_features(struct vhost_dev *hdev)
     return r;
 }
 
+int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
+                           VhostBackendType backend_type, Error **errp)
+{
+    int r;
+
+    r = vhost_set_backend_type(hdev, backend_type);
+    assert(r >= 0);
+
+    r = hdev->vhost_ops->vhost_init(hdev, opaque, errp);
+    if (r < 0) {
+        return r;
+    }
+
+    r = vhost_dev_init_features(hdev);
+    if (r < 0) {
+        error_setg_errno(errp, -r, "vhost_init_features failed");
+        return r;
+    }
+
+    return 0;
+}
+
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type, uint32_t busyloop_timeout,
                    Error **errp)
@@ -1693,10 +1715,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     hdev->vdev = NULL;
     hdev->migration_blocker = NULL;
 
-    r = vhost_set_backend_type(hdev, backend_type);
-    assert(r >= 0);
-
-    r = hdev->vhost_ops->vhost_init(hdev, opaque, errp);
+    r = vhost_dev_init_backend(hdev, opaque, backend_type, errp);
     if (r < 0) {
         goto fail;
     }
@@ -1707,12 +1726,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    r = vhost_dev_init_features(hdev);
-    if (r < 0) {
-        error_setg_errno(errp, -r, "vhost_init_features failed");
-        goto fail;
-    }
-
     limit = hdev->vhost_ops->vhost_memslots_limit(hdev);
     if (limit < MEMORY_DEVICES_SAFE_MAX_MEMSLOTS &&
         memory_devices_memslot_auto_decision_active()) {
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 0a322efec1d..b2b644c0d1c 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -156,6 +156,28 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type,
                    uint32_t busyloop_timeout, Error **errp);
 
+/**
+ * vhost_dev_init_backend() - set up the backend and query its features
+ * @hdev: the common vhost_dev structure
+ * @opaque: opaque ptr passed to backend (vhost/vhost-user/vdpa)
+ * @backend_type: type of backend
+ * @errp: error handle
+ *
+ * Select the backend, initialise the backend instance and read its supported
+ * features into @hdev, without issuing VHOST_SET_OWNER, setting up the
+ * virtqueues or registering the memory listener.  This is the part of
+ * vhost_dev_init() that precedes taking ownership; it can be used on its own
+ * so feature negotiation can happen before ownership is acquired (e.g. by CPR
+ * restore).
+ *
+ * On failure the backend may be left partially initialised; the caller must
+ * still call vhost_dev_cleanup() to release it.
+ *
+ * Return: 0 on success, non-zero on error while setting errp.
+ */
+int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
+                           VhostBackendType backend_type, Error **errp);
+
 /**
  * vhost_dev_cleanup() - tear down and cleanup vhost interface
  * @hdev: the common vhost_dev structure

-- 
2.47.1


