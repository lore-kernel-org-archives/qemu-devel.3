Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF175C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkFx-0005uF-H5; Mon, 11 Mar 2024 14:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkF8-0005aK-42; Mon, 11 Mar 2024 14:19:27 -0400
Received: from mail-am6eur05on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2612::700]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkF1-0006tQ-G0; Mon, 11 Mar 2024 14:19:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edVA7hK6GNobUiViUhBNZePoI2UqD/VAp7iVD5GdAeoO5wBJk3cbdXQEgDYasI1aHdXAW1mPkYuBO8XoZxmRPB1DLfg2RcDWwzk9fLtqoS6hnRD9I6zoaZw4y6TlsswEiE3PufFJqY1k4fvXvFnqQKnR1g300lyJZU0GQRykzjmZQFk7yFzzHWquasGDrYWq+5pLwL6mSiBp6MpdtPKD0m/9qh1lWX0nUGlTpO6FQPFkWvhnZT+fnv93Ij3sZOxKVCymCFryvdaAVVlYyL92sLsJGG89UJ1CsgD08O2fxwRN9wBwynbbjv8hTYXiK3+d7kLuf9s0UowEmOUEjy6mqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oX1D4PUxGm82OGjNEQxAqHw0qyeurc109PkwG00xY7Q=;
 b=EVpXfxzckgr9WxvyFowmA8UjXUH2Ak6AeWCidcKxEvAxQsMNAH+ujn/jVxS7JbJTACigBToWpomgCHQXX1CCRv8+8tfyqV9Tk2kaH27faxKpISMuDaj7SOfOzy+7W0+PxEqDg0gb8fn7D8RYicm7TWNRBoQ2xo7JrDn3qxnuHvMUpTTAtz9y557powzyNhRhHXLPFg9i2RZdpIyPhf8kHIgQbqJEW0b9mVYwKBItJszMX6MeWxUQFt8qemswMY0a6PGviJ1ujBqHDpsM0wxT7wWPdu5AECBleUfiLHZ3zhktmOQyb6rLH6tyThU+MQ7eUXFXYBWmPL4wwWzwtT72yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oX1D4PUxGm82OGjNEQxAqHw0qyeurc109PkwG00xY7Q=;
 b=t/Zure1wlOnh+UI8m3WO+BVOzgLI0JJgyrR8X63TqA29CGhMtOk6v1ZgXQfDTqn+Y5n0J1nRv3h2bl1BWvl32aiG2HDrH96+dI3YrsD59yeHkRyHz2zNZpYeS5Yoaf/ODgR6+tVK8i1TTwtR7vGQy5wkZcofBAYpe4ScLAwoV5NLPIogZghzqYzxCMFT8q6nmeX2xz9c4Ohalh7HkCl/ll72ZkDt8lRHQRjBneYnu9Na/Hw/6qp0wwXC6EmwxEZiSXvyYu5FJE6EWSjFgQZ22YmNK3r6sEHMLpAL/SvQ1XDe7S6tiC2K11iQOUpnCUe9UUdDNt0QhNR6wE+SCVhe3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com (2603:10a6:10:530::22)
 by GVXPR08MB10762.eurprd08.prod.outlook.com (2603:10a6:150:152::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Mon, 11 Mar
 2024 18:19:08 +0000
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde]) by DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde%3]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 18:19:08 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v5 15/22] parallels: Handle L1 entries equal to one
Date: Mon, 11 Mar 2024 19:18:43 +0100
Message-Id: <20240311181850.73013-16-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240311181850.73013-1-alexander.ivanov@virtuozzo.com>
References: <20240311181850.73013-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0230.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::20) To DBBPR08MB10721.eurprd08.prod.outlook.com
 (2603:10a6:10:530::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10721:EE_|GVXPR08MB10762:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e6f18de-25e6-41bc-6598-08dc41f7bdf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rO3ffqiEmhETfqtqMB/igAQFKmKECR22U/uAweHUvLV9xO5VZDd95kNjCSVmIJOMOSsqSK0N8C/JWLZsyj7lD4KBBvqIQ3PsuXvaeElsAIK2W7NPL8pg6yRHDpr4qX5lOOOWbF8oHXMT4pcvlDexQQgTnoP7hS/88AqtW3jYHX3NXNMEPu9c8mHq/q0IUlXNbR33sgN3RoH5p8ZWBpP6WZKchuhfVOztDWNDB31A4Bs4EGDZ+mB+eDmXHqTt/Okk/4gmU+wdTjUxXwHM9vWdfwNKWgcGGAZtmbuu7mFXSjjaF6+es1tvjPhf0PbsEo0EWB/qQ2M7a+KFbKw7h3SMRbmtuf0z383mvpi9/zfzd3hiKbXJmzWnMR+19k7Khsc722mOczGcIsMi7RZykwYmBOOYHR2fX9RFj5NphgZFVnOr8N4dmuOa9C3DI2lZbP/xU+yx1N7rkCOzvCenb3xaFW1UJqHz08sa2sJiurkj7TSHPrZNSvEGFVXvtFy3TdEHPrvLBspnAcNy+4GZvCwZXxRn2a8Z55yFHtWuyCtbTArYaqRXNPthc97AQ3+ZgNV7znDg239EibawKzaAKTO0DoiES/ejToZwFqt9crbrjSgLItjXlKMRqs/8E4Y/Svbfe+jye/Qo9w5f2HrdCmcGv108/YmUE3lWHYxqGn1E2+G31lp73CBRvqNrsDhXrE9UPlOF2UKmBL5DU8ssq18XOXLdDcP8hIvFQQ/GpgcLymU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10721.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(52116005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PGjrWL/LVJb6Oh8y/63p0vKnzqn0RWRdltd5pfEQzhGSwUySWSFGQbUQ2sRW?=
 =?us-ascii?Q?lf8uMNAoz2vni4nESQK61UiEId0rd1Ay0wdedJLDEYOLU+5p85SUyGT6mR1j?=
 =?us-ascii?Q?Jl/U4e/pCQBTL+bXbN7tuAk3rREUVUYNiJMn60UgJRmE1qQ5u4xeEwL2un4O?=
 =?us-ascii?Q?Zn78TCDC+V1RZrarXTSwi5bAHdQA7TBqqbhTPYOxgtmVQ7KzMKeb3T1h5MA+?=
 =?us-ascii?Q?8DFnKdGo0Uh8xrLo0t3wkg8GgsXsnEvGmUzRlQXJ2mhPy3gWEUu0ZucEwVig?=
 =?us-ascii?Q?lbjwPZFgFg4318npenB6By0mp3povolIdo+znxXzJMEFcmSS112lIxxI0+/u?=
 =?us-ascii?Q?g+4Xa5ffmZ9bfJnO4AwufzVzNZN5LNP+0A7weKFLwMXz2x36eapm/ZKBIa3K?=
 =?us-ascii?Q?9bt/hnMj7UocOEf89GM8/kE5vDn9GW3Yz2qwrKijK8Wiz71NGuG9FFGuooCm?=
 =?us-ascii?Q?gCQiOLnGJ29e5A7n/WK+8+5hUA2lEz08gVCvi521tv/ZEZ57S/5jhdwwDdPn?=
 =?us-ascii?Q?vasxwN7pTIX7ykaaGOVhwF022BuC+JNyqWGDZWuZJ6p4Thim1x+tVS9Ey9w7?=
 =?us-ascii?Q?mGlUUxwzC/wR5w0o7yy/0YzRs1ONUNtMxb2SclAKMvAsdVgv6mmr7KQmcP+k?=
 =?us-ascii?Q?N4g8SeO5ur+pKYS+pstqyx67mMXCts8QKsEttWbfZr1jZxjXMZ1Rx146gNnX?=
 =?us-ascii?Q?9g5K1n+xY+izqSRK/SzO0BgHInSb/DM8vejwf0LLsJP2p9wlxYwqR2QERXtn?=
 =?us-ascii?Q?vbg9OtlMTyiBDdL1dfG5ARyt15VpQWw0Q04x0Kvlzh2zIkdJ8ji9O4oEFCOo?=
 =?us-ascii?Q?ldo8Dkunx4ZVi4UO8JOabDEaw59funjq+X+PHfBTTw/TfIVXRtpkhBhLaEcG?=
 =?us-ascii?Q?US90EOzbVu6HoSh52j0lWj3D2hF3BNA7biCFntx3LsXvlIQgqL6YFeZGeBu2?=
 =?us-ascii?Q?bb2tAU/IzdJ6ssL3dihKXj2uoTt1bqsnmLDtGJsWd6YdK89Oy5Tmh1Zmm0l9?=
 =?us-ascii?Q?spVmVOcJDrbh2TNhXcMxQ9FOVd/0wQdxqKXpsBKNdOkqPL7DAwELlkN+gqx7?=
 =?us-ascii?Q?h2k9CUVdrxo6I+/Mx6BeUgEZehd1OPSuB96hApbTAFDzl1/k1whEvszZBuVV?=
 =?us-ascii?Q?vfFRadm8tkwNooEckkkWAf3Ra4PlospPp0uLWAA9E0j1kbvdCylLhxnEwcAu?=
 =?us-ascii?Q?zGlQAMnEbFLz64kbNSoLHa8SCl89TMxfe7WsbAfSNdMkjxvdSz5NqG5YDw/f?=
 =?us-ascii?Q?+HwBookdS18Zd23cklHIjeNc5PaS1XzOWD+FgV/C+vuub2ZpsRHjvdNKAfM/?=
 =?us-ascii?Q?l0tcf9e1DGDhiK4S4+vpnoi6r/rMVPQN1lGRFeMNwCpMP8zIdbOCFpdo//87?=
 =?us-ascii?Q?ZWpVyhw/3mXHn1r37reQpqUaND7b0+HVJ2B/oaWKN5qHjUs0296ZWN3baZK4?=
 =?us-ascii?Q?hJXXdB9cOLOUxmQtUGolR+g50vS2w+1PMbaFa7TPRtDy9vySqXFggKMQq4oy?=
 =?us-ascii?Q?B3nIW7x/3hr/p++rKMkaTBQ44LQKpW8fG9gh0WUTCNF2QcEoVJQ0Z2YkW2xu?=
 =?us-ascii?Q?byRIva/vCDF9JqsAQk1DP09Rys38bKtL/HivdgyVu8TIJVONQuGXspyj7RvE?=
 =?us-ascii?Q?43UnrE2z9kDPxy/VPPesxE0=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6f18de-25e6-41bc-6598-08dc41f7bdf0
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10721.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 18:19:08.0750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/SXrj+tuRdAEkWlnrVgTc8M3Xz4FJNsXj08NuVeEyAe2znmr34D0opwq//PNr3P7c4fR5ie4VMOyD4HOOAmq9fAxcNrSo781o7NMsk3x58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10762
Received-SPF: pass client-ip=2a01:111:f403:2612::700;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

If all the bits in a dirty bitmap cluster are ones, the cluster shouldn't
be written. Instead the corresponding L1 entry should be set to 1.

Check if all bits in a memory region are ones and set 1 to L1 entries
corresponding clusters filled with ones.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels-ext.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 1ec23aa1e7..67fa3b73c2 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -383,7 +383,7 @@ static void GRAPH_RDLOCK parallels_save_bitmap(BlockDriverState *bs,
     offset = 0;
     while ((offset = bdrv_dirty_bitmap_next_dirty(bitmap, offset, bm_size)) >= 0) {
         idx = offset / bits_per_cluster;
-        int64_t cluster_off, end, write_size;
+        int64_t cluster_off, end, write_size, first_zero;
 
         offset = QEMU_ALIGN_DOWN(offset, bits_per_cluster);
         end = MIN(bm_size, offset + bits_per_cluster);
@@ -398,6 +398,16 @@ static void GRAPH_RDLOCK parallels_save_bitmap(BlockDriverState *bs,
 
         l1_table[idx] = 0;
 
+        first_zero = bdrv_dirty_bitmap_next_zero(bitmap, offset, bm_size);
+        if (first_zero < 0) {
+            goto clean_allocated_clusters;
+        }
+        if (first_zero - offset >= s->cluster_size) {
+            l1_table[idx] = 1;
+            offset = end;
+            continue;
+        }
+
         cluster_off = parallels_allocate_host_clusters(bs, &alloc_size);
         if (cluster_off <= 0) {
             error_report("Can't save dirty bitmap '%s': cluster allocation error",
-- 
2.40.1


