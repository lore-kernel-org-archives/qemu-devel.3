Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08D7CD98FA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 10:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waWss-0007mN-0y; Fri, 19 Jun 2026 06:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1waWsq-0007lq-45
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:55:36 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1waWso-0003Ts-7i
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:55:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3ltix6TFxDGd5DQj06+3FoUD/2mVzpf9OiDe5fEEf/QA7At0uUNPAUFckAswDvme388bKQx87XiHwa4EQ8FtjgPIcQMPxmiXnMGp9okGXy5DurSWyPOuMXd0UCmCLhMywDHBHNO6Ku86rMEiDX3qdWx7L2jfiyQXOk/AI0st8yVWArPstKVS+5OgtRSJhBHH80wSCWvyL3ExqHBUDU0MTY7h5Byhqe4sz54IUsoK7WpEy7yxntpI+lUyGVIFJGaEYvfdgOyXsurU1518cqd80RZ+b4Hdq0RasZdUpLHatjGVn6w19+Ya2JWHBcUE2Xxm+nAXTST2bKK4fOiEKBZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiV3GjoVpDRlyekKCVzcF/kD9u5/Dc5SdfxAuBF9yBE=;
 b=pHYWRkfepLKu12VUD546s7aOHl01cajeL4ZoKPeRyfNQvsbIOeaVyXltSE5Vh+SPOyg8grkhKiq1hhkbaI/nXlwB4M++B9rOQydKnMPQixGmeEINUoZgfbMN/M5MdYDHHJOhKKelbMj42/OKEm8kc3Eit8J316f8KiDRAP6jh0av/+erQ2xltw+VThlWT2NKac7DKh8J7hopkQEBDqcKGRahH89A0pvJ9TW67AYaqHaGDkzQP+Osf/66VSY4RTnmRRuRCXioIfqTZhF437HXCITsZogqUZsElaxNDQ4GFkpbRIJ0Fx7QKoY3NtY4q30vR2n3uyagB/IUtWVvLwwFdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiV3GjoVpDRlyekKCVzcF/kD9u5/Dc5SdfxAuBF9yBE=;
 b=lzRYo0zTpMDAXWbIodvg1pRq03MezTknLI65ZpXHrcTQMSlJevNSdKhA3f1M1pSjJq9TGayJw5cARmD+kaGEV6tQFguxK4/+yJbmprGBnjVZ3pTz9WsXfrO5jKwA+p7AcWECLSlfHatXEXXABbowOtByL9/xn2rTQC9fc/xsDzSUwkNr7z2D4+aPTvwanfkyE00Wbps00D1ezVerpgvGr/U+ZOeFaBnrx3LjWoNOLR5BZljvTSHxIG6SGibZSUXEEp5uEHppAORVDacALfx8j7mJDxz+hMUsFWn5+ILQHj9yyDCajEDclQDBg+ubVXgAxGnp8N//Ta6L+scSk1gRfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAXPR08MB6576.eurprd08.prod.outlook.com
 (2603:10a6:102:15a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 10:55:24 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0139.011; Fri, 19 Jun 2026
 10:55:24 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, den@openvz.org, andrey.drobyshev@virtuozzo.com
Subject: [PATCH v2 3/5] vhost: reset vhost devices for CPR
Date: Fri, 19 Jun 2026 13:55:12 +0300
Message-ID: <20260619105514.128812-4-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260619105514.128812-1-andrey.drobyshev@virtuozzo.com>
References: <20260619105514.128812-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIVP296CA0089.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35b::8) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAXPR08MB6576:EE_
X-MS-Office365-Filtering-Correlation-Id: 77241b62-25f2-4b9b-9924-08decdf143fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|52116014|376014|7416014|22082099003|56012099006|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: tC7WyoQOustIXQX4DwZj2j3yNaEv6zAsmYPX0coiQxraRec4otE1hMvV1OMQZ68oyrQQXPFgWx+G/DR8yWlu99ZZpF3Dn8pfpbTnGnn718A7ahXI673hmdQp9tCdZ3Y0Tz0RhfGsq02v+Dpt/tr50YKYPDF2rEH6mGFfkGS+xd8TvDgE7I4iAyrDjrTH3eoJ2QzsPTDzG1KxbDxJcwWZBVM6iQkiFw7HItr2prmj5yxn03VFDkVCa6ZGNnOK5RnD6PNui3V6BHfQdy8fWKsmTuc51/BEnhnAMzTx1emOUVm5tFbqWKqcFuNPTMnO8TRe+NTkfk8yYxcpkAlEb94nLUf+KRfs1r5b9iA99/AWh4Jue/zJUnxuRW/Ae6Ra5GLNQLGuxfnyiK9+6Vj2mceIhJebjR1LBod0hIsiuuKFrc/YWtF90LKrVCp+JwovcpeRwIDr7+xs4l3MASnEmceW4ItXvWFMlYKWHRVpxMK1t8gPUpPmc/AhHsq5yqizCC/jRgn9rJ+Tt1yguj0HBMaZjQW4igWGKOjPLCDr5n0evxXiuqNRGsdd+D4Utj/tAx5jy9VwzMoty7MenpNidgqAyKYDlNAWndaMbnJmgHZN+lGBl3u6BfypicO15qnLJkuTgTgTzmuuxqcjvaK9DEQsT7diF8qdn60/LdzWE5wI87mxAluKMkAJv2CwDekyFz4WUPR+AEH8eHzu3apxOpT1MPTM/SC4R9P4d/SryK7Nojo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(7416014)(22082099003)(56012099006)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gBYMEJc2FMglPUWP/rY3Lc6OajDZxj4iQr9mrgwENSB73fDq7qYehc06A3ZV?=
 =?us-ascii?Q?ho8vY/pp4e/2dARLelMaj1jwaqzPF1SIZPk4tPE2DcaO93fyZ7oV/NbQDPH3?=
 =?us-ascii?Q?4Lo0pP2BYK7NT4M0H8XeFOVSZHfg796oW59vzGE4WkBo01Gq78kPvzi5zd1D?=
 =?us-ascii?Q?ic9xB2U8PIoqD7iVpwj1ElXCzz0/naJ/4pTxfNLsH3IcZ+ZdhWritiHGggFH?=
 =?us-ascii?Q?aml7aIQl1B+m3spQsNgXWn6/CGVvNd7BKTaOyUbV6C/vErKv/aerKdRqKIbT?=
 =?us-ascii?Q?WOCE8SIJdZA/AV7rlN9VcoJagr7YJZ5+cE8UJXdoTlh6lwAOiL9LeeYy335C?=
 =?us-ascii?Q?7CwL1mEqhEJsqHu9s7u67svY77DFkENxCG9dn3om6fJ1WdT8h/VTun8kK++5?=
 =?us-ascii?Q?B7H2qwCAA94yhestAw5w3t1jPchniO2uYLT5VzKP/PrmYEUXGwANEWi5XD1g?=
 =?us-ascii?Q?cSfkoqfFiD4l1GXdwNXx4rZtFHm8vCFp7ETw49wol4vvBoAnOLuTtElLe6b/?=
 =?us-ascii?Q?RsiUr29zStgiP+naUOzERyKJyvC8+ZfHiYSsYG9rAwekUzueTjZoJOf/5vGa?=
 =?us-ascii?Q?vcUrTlukyV1OHsCBxpQi7qwvZcEwyJ7z9l5GVrWacwaYtKHAJcpeG2v5KJcA?=
 =?us-ascii?Q?/dwr0pIQwBcBBGj8E0iolLHQNA0hMSytqUL2eOBrGIuHV+GJaDbYv5gAyu0B?=
 =?us-ascii?Q?vxv0ajLPEQylODTUcmF5wjwaMsckLMzklGYxewoLtvKv9Q2X7yQX+miE0v96?=
 =?us-ascii?Q?5hYGFv9+KWG1jD9jlCu+ezoecUnZ9k7cNLmlEuF8fqeNUWv6AFpm0ABLH1ii?=
 =?us-ascii?Q?5hnkWCMxXc2LE+tjWI5zxbxlJhNKVXDrUBrlYT9Hjn0ntZQDK7KxIevzSBGe?=
 =?us-ascii?Q?d7KtER757Wx1JrCwKQiFMO+U73CyiBbphJuGFHuEmNS2pYeWTXL4noLaG399?=
 =?us-ascii?Q?dxWgSU1hQqnrVsTTNnWzytKEt/oFpLZwFxtqHGRkpmgNFrKBf3mK1jMiOQ3h?=
 =?us-ascii?Q?ekNIKrdgjddcy3xIVbeq6r23VHpOVN+r9CKWBJ9o8L8j80CXNvAy+nDmbn9M?=
 =?us-ascii?Q?1/3plMAcjyspR6ccTtyH7uAjWSKGEGwiuD2vBS+9Z/WKGlOG5QQqmis68T8P?=
 =?us-ascii?Q?336dtZJBI1K0Fdbm9h3X47YY50ukJCxiknjn3lnJIOoMSJ3/6uVrbJJGrlU0?=
 =?us-ascii?Q?l5lM7D/tVVz9sjvGdljjsPTRccE7hsrstuwlaJbLgqVPb94C6eLz2SAKQzmF?=
 =?us-ascii?Q?NcCBkEOfdj1sRTF7ukqUB1o+MXRIUqcZPflxbN16lw6fbD+PVHgAgDOmvQn5?=
 =?us-ascii?Q?SOohTyns77rYf5zHD1UFTxAHEZeB0Dy2ZP+316nQHSX1VbtEzrin4LiVmbjb?=
 =?us-ascii?Q?ewafb1lqV1mMf24isVgzeXFTqBAvPKkew03HJeHtY2PbLEJtax1TxIpGsNWk?=
 =?us-ascii?Q?SQQlXFXExd3xXdK9rk4XTHYbvPA0jPpqVP0LTZCx7EAHewlKxcc/mslkTU1Z?=
 =?us-ascii?Q?5KNnJyJShHeHtw39E8UIAOI1X8pUCFtymcIu1Oj781KnESCXHfiqe4v1h2GP?=
 =?us-ascii?Q?hynVRw2kPbFhXbjmKBqEVK3/JfJOvRKpSQilnjmg03o7exdY/Qc1SWLvmw/9?=
 =?us-ascii?Q?eSP0FV+GdPQn5fiW5BwAKJOuWYqoSqM2muPjkLwFGEDaMbt5Q9rrAl+NbKNO?=
 =?us-ascii?Q?wV/zTXRK0qVV0vDGA/HGWC1EslOtnsfovOeNYTbrAMB3/3pVArheZI5xF+aQ?=
 =?us-ascii?Q?TFM3CDG2Y7L9TCSuWsFZ3uZeQXnxEB0=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77241b62-25f2-4b9b-9924-08decdf143fd
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 10:55:24.5809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4odJzTxD00lv68lgQ4cpoxEYTspQ7h4JZKcHdJuUgx596lj1eDo5dL1tmtJKxgvJWMfJD7/3io4FRFOt9y0XqMWnDKjOkYyFAfZewx0D3H8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6576
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
 hw/virtio/vhost-kernel.c          |  6 ++++++
 hw/virtio/vhost.c                 | 33 +++++++++++++++++++++++++++++++
 include/hw/virtio/vhost-backend.h |  1 +
 include/hw/virtio/vhost.h         |  1 +
 4 files changed, 41 insertions(+)

diff --git a/hw/virtio/vhost-kernel.c b/hw/virtio/vhost-kernel.c
index 3390b48c6f1..55d316b88e9 100644
--- a/hw/virtio/vhost-kernel.c
+++ b/hw/virtio/vhost-kernel.c
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
index af41841b529..1521b50cbff 100644
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
@@ -1667,6 +1668,32 @@ static int vhost_dev_init_features(struct vhost_dev *hdev)
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
@@ -1678,6 +1705,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
 
     hdev->vdev = NULL;
     hdev->migration_blocker = NULL;
+    hdev->cpr_notifier.notify = NULL;
 
     r = vhost_set_backend_type(hdev, backend_type);
     assert(r >= 0);
@@ -1766,6 +1794,10 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     hdev->log_enabled = false;
     hdev->started = false;
     memory_listener_register(&hdev->memory_listener, &address_space_memory);
+    migration_add_notifier_modes(&hdev->cpr_notifier,
+                                 vhost_cpr_notifier,
+                                 BIT(MIG_MODE_CPR_TRANSFER) |
+                                 BIT(MIG_MODE_CPR_EXEC));
     QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
 
     /*
@@ -1814,6 +1846,7 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
         QLIST_REMOVE(hdev, entry);
     }
     migrate_del_blocker(&hdev->migration_blocker);
+    migration_remove_notifier(&hdev->cpr_notifier);
     g_free(hdev->mem);
     g_free(hdev->mem_sections);
     if (hdev->vhost_ops) {
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index d878d7b733a..6c949e6a38d 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -204,6 +204,7 @@ typedef struct VhostOps {
     vhost_get_features_op vhost_get_features;
     vhost_set_backend_cap_op vhost_set_backend_cap;
     vhost_set_owner_op vhost_set_owner;
+    vhost_set_owner_op vhost_reset_owner;
     vhost_reset_device_op vhost_reset_device;
     vhost_get_vq_index_op vhost_get_vq_index;
     vhost_set_vring_enable_op vhost_set_vring_enable;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 684bafcaadd..1a722ddf16e 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -119,6 +119,7 @@ struct vhost_dev {
     QLIST_ENTRY(vhost_dev) logdev_entry;
     QLIST_HEAD(, vhost_iommu) iommu_list;
     IOMMUNotifier n;
+    NotifierWithReturn cpr_notifier;
     const VhostDevConfigOps *config_ops;
 };
 
-- 
2.47.1


