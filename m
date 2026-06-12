Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A9BCD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 16:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY56c-0001eY-Ew; Fri, 12 Jun 2026 12:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wY56a-0001dz-3z
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 12:51:40 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wY56Y-0000Xb-AQ
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 12:51:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MiocptnBS/U3+TPAdqP3mBrjDqtVkbEcHsI+ulodm4dClFYaHgw9V9wd5Y6ljF6RwLfBykEC64L58JAfrdB7sj85htS17XIgL2bzyF+jAIIOWGyR7lq+cyYpF20uy7wYzleZzCsSa3hVL9dgqoIcrDx8fvaUCTO/vLS+zlQVlRmPm8BXyfohaGYvucwOhQqIIM/H6ZYUornPcAJm5nDFFjIq6e3/Q9X/TbPw/kbrJoA2MrxdB8KOBhy2dXayqYfhUVpRS9xHs+KeMuwWigZ1wosHTYD8KZ7GoprT5bxcxi+Yh6YFQ3FcqJdS59pg39cPgYl5Bd4cM6lwszw706e0Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tL5UG9IDROI3zAu/GrvuVfQLwc771g41b6c8WwnmJdc=;
 b=VCv/j6sEgSC0X9eOs9oXr6wmmyMbfklCuPZWS9BsnemJhUy9dY3eDOMDubzcjkfvCWC3++ZPAjE0xfyZjxhUqM+CPiOGDuskYV1NTF+w9/9Bsdb6QHJMiAN4VmKtCVmi8M3GLs9LFkXZCkYkFidE6dOkAB8twUDuhspeV/izp1hce0SVo9yco79H/qKl5WUv8CH8KZFSz0PEDzHD1v3WoAJcuUY7ziDUlJyzDQhTvqExtMlFGw7tO59pXXTLRNOljToxzLogatqkocSoofU9Z4UI3DXVFTjNzBNk6I+3CLleBoKGxBSTfTaVHjMQ8PnarwlIiDRGBVGmwVMtX3BQlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tL5UG9IDROI3zAu/GrvuVfQLwc771g41b6c8WwnmJdc=;
 b=xYwlauxo+U9+tDPLkxP0pnseQGw7UUl/zCDcU2wwL7OwpkoJXyGv8++QF3QujUt2mQjNk7PlVf6eyr2C3yaSTGvo9IcKGC3NcQtF1rVZvufZ2iPAY4YhvmwE71N+TexA0uY9FZ0dhhn+HZelZNU6R1vNIhA3MSKI65nAm9vNRAjGclnDJzWXhQZ1ZztbJ83E0YAjQr+kjfoAj00pWaUxNm7gvOTDELgwSWx6YTjBdUQMKb755NIuyTFu4huA7GukrGueKb0SWncK4fAtP7p0IUeQueeyiHnlxQraWfuvetaQsEynm6UnNDLWiJ+69j4ZzaEiijcOU7KhDQvkpWpPDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB9097.eurprd08.prod.outlook.com
 (2603:10a6:102:330::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Fri, 12 Jun
 2026 16:51:23 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 16:51:23 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com,
 den@openvz.org, andrey.drobyshev@virtuozzo.com
Subject: [PATCH 3/5] vhost: reset vhost devices for CPR
Date: Fri, 12 Jun 2026 19:51:08 +0300
Message-ID: <20260612165110.431376-4-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260612165110.431376-1-andrey.drobyshev@virtuozzo.com>
References: <20260612165110.431376-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0021.eurprd02.prod.outlook.com
 (2603:10a6:803:14::34) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAWPR08MB9097:EE_
X-MS-Office365-Filtering-Correlation-Id: 559cfcbc-06d7-475a-0c5c-08dec8a2d5b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|52116014|1800799024|56012099006|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: 0Ob2aVUSERK7ZxfDF3KBEwGSzR0G/BLFlcg14I+E7dg7Jyy8RpknoZQjx7WmH9yAfOkLva3fwCSxjPOf6q3rGiYMx7gCyCraDcz51dLmind2Mj99klQ4pyVuPmTtyHUnFUI3ptRSkBJTzI2kJiNpIosdX4Ohd5BCHh5KVxS46D7PigjXlCO/hPj3DI/lLIg/ed8csWlNsZirQq8A7p1i1jjKAzVqjqju6peV0VSRZJE3auR28F9tAZhDZDMO3RYPxREVIRKbNKb83YZ6MvuCwPHuhzTDyggodZK9z/9j0GDdZvMg4H51qNpQXY9+I6D0ySKwI8qeshxEZ+RPLTKuFzzYp7Lx+bUwVHITdQGWXpTjXfYCCp9o55UKuyR63chOyDux4J8pcKKfS/um71b2/LhTZN+s2h8X1I9wum5jUd9e1ElYKnFTV7FRBZxKa6PfjkF/mFcXOATyrd2JR2gDeMX5qX+nQzxCurFMC9QP9DhJmuNtGsqbivrT/GGLKQp6LGsTbQS8T6rSDgYsM867uwbukqXIhHUU5d9j/0Uwz1b02qpU8bGH6sZsbhULNxN3jnpA5lzPrS3I9bunxcn05AeJQjJmpbT2fHzt0ke81sIESPbbGpypezojRH5lHLd+Y4qGDHiCdXjay9DBrJy3ZYwyzwJ4yITzaubZ9xKVvA9PSLZj29LCZLPWIPcnsdiw5pcFZ19/cyF+kF66pVmlC0oRos/iDhe2t5Fe1vZVyNlH2YFDoUn0bxCBh8Ttlh5F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(52116014)(1800799024)(56012099006)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iHTSIWQHk8q8UDRRSuVitpEYaKw88dzC8EOOyy12ZkoY8Jh/Mbf/Y246jtAK?=
 =?us-ascii?Q?iKJSFrnDLK0P4PGZLNjLDWuWRtcY37BXRuzKk9QOxDUrm0WwpekwoMXbQCny?=
 =?us-ascii?Q?vVdjnfkvv0M35hS6ksa/Z7bxOK8iUhfh86+7Jz5I6Ye7cq6zxWXxEoxt0/q0?=
 =?us-ascii?Q?w5mmaRNqaKCrqeigLtumKRRnok0XaTCjyern22yOTOKA78gSwNvBcAU1AkIB?=
 =?us-ascii?Q?752K0qHM0+vJwfaNr/sc6wJDPU14QhOYVBIe5F4UbmScb5a5cXjQGfeZHpa0?=
 =?us-ascii?Q?HIoDRNYGGF8NTW1p3cyLkLuY3KUkwmdCVoArciq/pfxtpgiy2ekFfjZbDMOi?=
 =?us-ascii?Q?6XuaiBkz0hG1UjW06sHFiRfKdyD+bJXR1bS+4pby8ordr3lMq9jyWPLpOOuA?=
 =?us-ascii?Q?fDBL+2jHsxX1msnYj6v4+GmAGnZe/scDfjcjmTnt9EQTBGT2YygXhN6zL7KY?=
 =?us-ascii?Q?q62X8iJgOyMZW+FKpbNucq05DAtnzlBj7jV56FYNu8M67Tw/k6Nf3XZ6mEN/?=
 =?us-ascii?Q?G1sX5zHexv56TiymJQmLS7VIUgvdmS/y+1TMHvr1jNTDh6AmzYHnlpB3/6VN?=
 =?us-ascii?Q?QKfF5yG6Y3en5Qxk3WX5TJfvjAmFixFLxPy3DKYuyEVoRLUh6hvGyJHR/hbw?=
 =?us-ascii?Q?Nq/aqO5ipnXPYQqi0XciYZvRtNuZ+9bcCi4d3Xx8Ghs0fb9C5jjMYwuXTAF+?=
 =?us-ascii?Q?NFBqRCzoGH0+qko1PrV2PDCGEgsWb2eyH6S8JIqXfZ6tIc3dJmjYmq1AF21u?=
 =?us-ascii?Q?XWS24Lfy+zRb+zwg90TAdH/qzuBxQmCzJFYZP7o/VpFHZjy/eb6FxwiBsBtD?=
 =?us-ascii?Q?ZL9KQm8pIz8yvI89u6+NVRQlxPCmbfgnAvlKqx/zN1ZZ5Yx+Nk9TdTkDCJHw?=
 =?us-ascii?Q?65u16aiHkznbdEjJRB6DeHpXWi1uBPXkg37BmZMS76p0KqQ85UXmyYNyS1tc?=
 =?us-ascii?Q?KmXAkQlmgFooP/47paeCgpzhFCc500rt3dB2S1Np9vSBrz5sCZ2MzkyJ1MdV?=
 =?us-ascii?Q?b0zV1tz48gjoWYfhN8dmxVi8ZDCBVY7X0OeMC5EpSJU14iP85S3MQdPjGwsi?=
 =?us-ascii?Q?iE1YIYFmtYaWr7N0gpiKxgsfiBzGfEGIfmJb1DNHg/fTDOe6z96TNCqxDkW+?=
 =?us-ascii?Q?DzrkCX3d7/9HFFfE5s0qdN6X1jnoGis04FV/K/xfumrvCvV2ZhScc7RPwdph?=
 =?us-ascii?Q?Y2vxRnX7hu5mBSPF223ynKJtqlB/6DN0o36dbKxiYib+U4MgAR4aFMK6MjgX?=
 =?us-ascii?Q?LUUY+gy0PsGqUB6YEnuJMMY9/z5L9rf0d48Fa8D97iAm0mPvWQCIb7Ojn0oG?=
 =?us-ascii?Q?WdhqrI0EOPnr5WLuvUBwtWntKTPK7vKtdYm2ZjH9A4HArOA5EYkgUW9oPbHG?=
 =?us-ascii?Q?zRNdMyGiZ/nBGq6ocLxJ9VlOQldfWp7ddkQD/SFzthfy+nck+XiBoJeJ4qCl?=
 =?us-ascii?Q?83zzFItmKta8DwlJsdcYaEDXFUR2YqR8dpQA2UjBzHE4CJLs6BPILQCG8k2w?=
 =?us-ascii?Q?ZKWZM2lYpqEiv6JWxqzV94LfTli+T7X++GRI2x26E0XcGFfPDZrFmAlOzCsL?=
 =?us-ascii?Q?D6Bflujt3/Ttb86+Pc9XYqSLNQ78DVSjPR2v7OEug9avi18QX9DBqV/flQjA?=
 =?us-ascii?Q?/nkmx6GDwaKg/YGfgAVBRrH6dVOBnzAVDkVWIHmhiKcea0aRAcFRlZf6ZLqw?=
 =?us-ascii?Q?KLi9zVUFPFjO7dlQB1wnZdHDYUWx9jDRC1jyvXBve/O+vS4QwnQi7NIms/oq?=
 =?us-ascii?Q?UL9tP1ia09k/PVOUeFRIXpKnq7qDIb8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559cfcbc-06d7-475a-0c5c-08dec8a2d5b7
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 16:51:23.0095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MG+yiPFyWo51oDblLBE7SrQo7K9MgtK17Ld/CqxQDmRFIUlo4k7tF+vqYP6BxPDolFXDAYiLDuqu91h4SFRP3kGxW3T2yueGDUayShmwX7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9097
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

When preserving a vhost fd using CPR, call VHOST_RESET_OWNER prior to CPR
in old QEMU.  Otherwise, new QEMU will fail when it calls VHOST_SET_OWNER
during vhost_dev_init.

This patch is a rework of the change originally proposed by Steve, Ben
and Mark at [0].

[0] https://lore.kernel.org/qemu-devel/20260128-cpr-tap-v4-0-48e334d4216b@akamai.com

Originally-by: Mark Kanda <mark.kanda@oracle.com>
Originally-by: Steve Sistare <steven.sistare@oracle.com>
Originally-by: Ben Chaney <bchaney@akamai.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-backend.c         |  6 ++++++
 hw/virtio/vhost.c                 | 33 +++++++++++++++++++++++++++++++
 include/hw/virtio/vhost-backend.h |  1 +
 include/hw/virtio/vhost.h         |  1 +
 4 files changed, 41 insertions(+)

diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 4367db0d951..1447d129630 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -261,6 +261,11 @@ static int vhost_kernel_set_owner(struct vhost_dev *dev)
     return vhost_kernel_call(dev, VHOST_SET_OWNER, NULL);
 }
 
+static int vhost_kernel_reset_owner(struct vhost_dev *dev)
+{
+    return vhost_kernel_call(dev, VHOST_RESET_OWNER, NULL);
+}
+
 static int vhost_kernel_get_vq_index(struct vhost_dev *dev, int idx)
 {
     assert(idx >= dev->vq_index && idx < dev->vq_index + dev->nvqs);
@@ -385,6 +390,7 @@ const VhostOps kernel_ops = {
         .vhost_get_features_ex = vhost_kernel_get_features,
         .vhost_set_backend_cap = vhost_kernel_set_backend_cap,
         .vhost_set_owner = vhost_kernel_set_owner,
+        .vhost_reset_owner = vhost_kernel_reset_owner,
         .vhost_get_vq_index = vhost_kernel_get_vq_index,
         .vhost_vsock_set_guest_cid = vhost_kernel_vsock_set_guest_cid,
         .vhost_vsock_set_running = vhost_kernel_vsock_set_running,
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index b9dc4ed13ba..fc474a9edd8 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -24,6 +24,7 @@
 #include "standard-headers/linux/vhost_types.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/mem/memory-device.h"
+#include "migration/misc.h"
 #include "migration/blocker.h"
 #include "migration/qemu-file-types.h"
 #include "system/dma.h"
@@ -1549,6 +1550,32 @@ static int vhost_dev_get_features(struct vhost_dev *hdev,
     return r;
 }
 
+static int vhost_cpr_notifier(NotifierWithReturn *notifier,
+                              MigrationEvent *e, Error **errp)
+{
+    struct vhost_dev *dev;
+    int r;
+
+    dev = container_of(notifier, struct vhost_dev, cpr_notifier);
+
+    if (dev->vhost_ops->backend_type != VHOST_BACKEND_TYPE_KERNEL) {
+        return 0;
+    }
+
+    if (e->type == MIG_EVENT_SETUP) {
+        r = dev->vhost_ops->vhost_reset_owner(dev);
+        if (r < 0) {
+            VHOST_OPS_DEBUG(r, "vhost_reset_owner failed");
+        }
+    } else if (e->type == MIG_EVENT_FAILED) {
+        r = dev->vhost_ops->vhost_set_owner(dev);
+        if (r < 0) {
+            VHOST_OPS_DEBUG(r, "vhost_set_owner failed");
+        }
+    }
+    return 0;
+}
+
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type, uint32_t busyloop_timeout,
                    Error **errp)
@@ -1559,6 +1586,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
 
     hdev->vdev = NULL;
     hdev->migration_blocker = NULL;
+    hdev->cpr_notifier.notify = NULL;
 
     r = vhost_set_backend_type(hdev, backend_type);
     assert(r >= 0);
@@ -1659,6 +1687,10 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     hdev->log_enabled = false;
     hdev->started = false;
     memory_listener_register(&hdev->memory_listener, &address_space_memory);
+    migration_add_notifier_modes(&hdev->cpr_notifier,
+                                 vhost_cpr_notifier,
+                                 BIT(MIG_MODE_CPR_TRANSFER) |
+                                 BIT(MIG_MODE_CPR_EXEC));
     QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
 
     /*
@@ -1711,6 +1743,7 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
         QLIST_REMOVE(hdev, entry);
     }
     migrate_del_blocker(&hdev->migration_blocker);
+    migration_remove_notifier(&hdev->cpr_notifier);
     g_free(hdev->mem);
     g_free(hdev->mem_sections);
     if (hdev->vhost_ops) {
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index ff94fa17342..18ce5ea9a07 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -196,6 +196,7 @@ typedef struct VhostOps {
     vhost_get_features_op vhost_get_features;
     vhost_set_backend_cap_op vhost_set_backend_cap;
     vhost_set_owner_op vhost_set_owner;
+    vhost_set_owner_op vhost_reset_owner;
     vhost_reset_device_op vhost_reset_device;
     vhost_get_vq_index_op vhost_get_vq_index;
     vhost_set_vring_enable_op vhost_set_vring_enable;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 89817bd8486..2545f57097d 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -133,6 +133,7 @@ struct vhost_dev {
     QLIST_ENTRY(vhost_dev) logdev_entry;
     QLIST_HEAD(, vhost_iommu) iommu_list;
     IOMMUNotifier n;
+    NotifierWithReturn cpr_notifier;
     const VhostDevConfigOps *config_ops;
 };
 
-- 
2.47.1


