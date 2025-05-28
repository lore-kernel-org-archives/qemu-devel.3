Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20272C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 12:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKFb4-000837-Go; Wed, 28 May 2025 08:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1uKFaA-0007UF-9M; Wed, 28 May 2025 08:08:34 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1uKFa5-0002pA-TE; Wed, 28 May 2025 08:08:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbiF+LfAm8nSMinXtRZoXSZELouH2w2cOqEg3ICNnRPGiJKmGQVMxB3W1BwNODuZR0tDwDLPyO7N4crZW6JY0seOHygVNncLLS0pjWVA31MAeghoFWdDecanJWTaKtkmxjWmp2qQ/Mo1lhBJjzQJDTDwvdjtIz1kmzVAnHdhbXp99oHaX+zfRQLLZxZwvBWLWFXwnOGU6IjDl7Y/MKjJrd9+N0PenGdBQ4uXUOV1PJOgz3amGgR13bv8oiXbeLSl//Fg4BVrLLfNEng4arZfjdT7a+zNCb9XB+JNxay/7MAIGBcvNHKh807ki7Mc529yNywnUE0u6PPTG4nEK6NrIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5kXyUg8kfAOe7FoTUI2XKQfaM6zNy/ZUZxKY8hWyTA=;
 b=ffjdBXKfrn+cKq91ZFY5s5uhVA0oz0L1Qm9XGPYRxtNVbWtM4VeZb109vMJHHk24FkvlhP1LQMInq3i41U/e3nc6ZhLelTvDoId4ZsEMKjnJ1lUd8m+OU5x7BB9RIRq9T+3Co/fKOP70JFPxvtGE1RkjeWRJu/C0im3oDoo9gZBV+mpqYs1rNJCpN9OuNy+7ukimqqZf/FJTQpiXskcKYsPKZQfGsaOiTqr+fTu1C+IpmgVunvE5r+DRzxq0gExBFePmq5HDATU/vT1/ZIIQ60rYcUdotfZg6DZT/qxIzls18Z5gV1lGtgG/kB6n7LfqqcrertIlJxr38loZIbZ4Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5kXyUg8kfAOe7FoTUI2XKQfaM6zNy/ZUZxKY8hWyTA=;
 b=e6GmWYnrH8DecVDDQ32uErj4t8VgB+IrSKkiqxtEcLQQQ5W9wyXr7ZLtCY3cTuKuJ9PaRT7K9ICLZXrfq9Zjm5bTOtbRjG6TzIfqL5RCd3uubK4diE26jn5UXeIswiPqhUjtjIf/9kX3AJER2iCPViofNZkxeaK9xWWsO5UJ4qY5KKj4gNUYKMNchCwFsbQbo14xxAVoqnr34O4zfm2W/X+JyDMyQ6Ivi3IEnLHLypIXAaM1vMg5RV9ovvdE9Tb+ejql+OtqRSOlcmb5Mrmy6EeNU2KuPPZYnNIsm5gTXBkm2ovV5OnQF8IemsDMXBWUPBd+7V75qAugU3FsoLPUOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM8PR08MB5732.eurprd08.prod.outlook.com (2603:10a6:20b:1d4::16)
 by GV2PR08MB9277.eurprd08.prod.outlook.com (2603:10a6:150:d5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 12:07:53 +0000
Received: from AM8PR08MB5732.eurprd08.prod.outlook.com
 ([fe80::e543:a83c:a260:602b]) by AM8PR08MB5732.eurprd08.prod.outlook.com
 ([fe80::e543:a83c:a260:602b%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 12:07:53 +0000
From: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
To: vsementsov@yandex-team.ru,
	eblake@redhat.com
Cc: qemu-block@nongnu.org, jsnow@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, qemu-devel@nongnu.org, andrey.drobyshev@virtuozzo.com,
 den@virtuozzo.com
Subject: [PATCH v2 3/4] block/copy-before-write: inverse access bitmap
Date: Wed, 28 May 2025 14:07:30 +0200
Message-ID: <20250528120732.2247150-4-andrey.zhadchenko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528120732.2247150-1-andrey.zhadchenko@virtuozzo.com>
References: <20250528120732.2247150-1-andrey.zhadchenko@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::8) To AM8PR08MB5732.eurprd08.prod.outlook.com
 (2603:10a6:20b:1d4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR08MB5732:EE_|GV2PR08MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: bd53365f-1313-4253-7186-08dd9de045c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3M4hSuC9v2yj9ZiGAVPosC+f8fXLKSgH/3uhj9vaf/aVsXsTTJkiFeclq0uf?=
 =?us-ascii?Q?GC9+KBfPBxbkh/5CNvgL7/xFWOhJfymQ4Jx502JUI+JIGcSWH21QJUbbmvt0?=
 =?us-ascii?Q?f75WMf/94iVAJ0tF2qe410G+/ITo3f0Vc4RiMEL0Mo5IEwocuZH2uKdj0EP+?=
 =?us-ascii?Q?8wuc7YMwPl2ID0b9ahsQlFFI4toQTrvjkNpwhPfVsPwkWTKj1jBCztJ4y85X?=
 =?us-ascii?Q?SdRG+3oePGsBf7681YhRFyTUZohIEaF2yv5cPa7X4QG4eIoH9tNoJ6/EQY2j?=
 =?us-ascii?Q?q2Yk315dAz1iy/584uAfGRYtD6hpvu3xSrFuWmz7twvrx5d0W8C3ZkA6ar/5?=
 =?us-ascii?Q?cFzNv+Z6zl5nq1wK+SaNqrcHtV5Oo+8SBG0WlKs5UAKN2HLkVOMSB85Q0F1U?=
 =?us-ascii?Q?KrbOi0ThhUfyoCM2Kpsp8F7fx5TS9KW5HEYIx6rG8wAIAFRKbP69U8V0XPYU?=
 =?us-ascii?Q?gvdRicHz3MeK4GTwgu/J76isPaUOyyznhBKnEFBxhq9MkwdiTHlwuTra8Vjn?=
 =?us-ascii?Q?VmOS1j1c4sBX85sHJYyrcGHI4gisj07qtp2M3Hfhg1cC85oxea2pY7YF9k5w?=
 =?us-ascii?Q?DsrmK0NjuCt7ciIxOTHp+hFdnH7gPvlP339PDs5ju3c9+dWBaOPaUzJJpOb8?=
 =?us-ascii?Q?Z28JrsVHVmI45C9X8pQcXTCKT3ZZuvCkEP+kQZejuPkNplGWu6q+arlYpNrY?=
 =?us-ascii?Q?QxcaqztgRAaJhcvUIUgTu7jqljDFYkWZKYZrrdncg7FfIW2jApOdn3x9ZEzI?=
 =?us-ascii?Q?tv0inpg7Qet34bLq8caTIMjqNbz6xeQvHFNLZZCesmyU1/p34zbUu9lwRgQA?=
 =?us-ascii?Q?EQ6t5WLP9T/Q+3qONoCuTmrcGyFuXCA6eHUoJXBBo3uELnll+e+AOrzXuDmu?=
 =?us-ascii?Q?uXiBNsGzO1OaIhXVY4IpYlm1qBTuOqdoYvsegnwJ0eHzLbLcFnJOLAZNH6h4?=
 =?us-ascii?Q?xORcaxuosf/ahSojuvLWEt/0A3RTfsrZfKyxoGlVopDacR3xsQnAH9FgWBlt?=
 =?us-ascii?Q?5qK0jtc99NsppzWabVTGzjJxuRpYFKKKcK6rwQ1+7hOWDFQeIzDHO5IyWWHO?=
 =?us-ascii?Q?38rAoD6s80bcmib3ZsOSVHoAvYUbEZ8P01CmhO/9S+BlqWX+Owbq17cejiJu?=
 =?us-ascii?Q?9m3aAXEJ8i8m1Fg3h7s+lQqUo+CPV5WQJXo1kz8jZFJB/tvD+f/4uttxwRV+?=
 =?us-ascii?Q?rktBacPRyTb4+DmMtn6pO/u4f5wFR7beHZgBNcfTb2FWNqIu0VkewE4YZFtN?=
 =?us-ascii?Q?SXSqO8BNQe8VXx54fWTlWC4qFqZUBob3VAYgjDyxEzdLV7W8chQ94hEYcZ6Q?=
 =?us-ascii?Q?0T9vHvjgRExT3iB4TVVB5UaH5U9wlKpqCCG4Fr4BQtCk8Tmsu0vDDxxnZ5DI?=
 =?us-ascii?Q?odS2gjSkH070yHiTE8pvbBF8YUbJi4xts+ksWox5vSpzt853ZBXARs8DPu7y?=
 =?us-ascii?Q?nU/bo0GdvGj22PmH82pqk5INbyvg86JeHASM0jJE1R1Y1ilY8sio0Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR08MB5732.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RDqDbtcxEA/7+496SBkuwLaFgxq1v7tF+73IFZoSDmGYHwlAmZUSLs13h3D5?=
 =?us-ascii?Q?tPXn2JMEy6grXdyw5BtkWMJoqSpnYwnKbc3ATtnGj8zHB31U6E90x9Qu8eGp?=
 =?us-ascii?Q?6BKhqdxg1RM8Cmcdaxd11Mh0f56/Xns8wGZxZKUcEvOw/B3G0lrqVKnma6fF?=
 =?us-ascii?Q?8xImn2DXTLUgxKp0uZGZebzUmgrgDFs2CAc60F4LcMTEBBFK6dG05egXTcF9?=
 =?us-ascii?Q?S96+tzxrXw297J4BXnQ7JKUWbJbrnydvLZY+AVxQRCTXBSTp4kotCrmMyEyM?=
 =?us-ascii?Q?STCEodJKKprMIsinUlCmbSjMX3PkgPkAlloKSCShw0QR/usf2maE8DQObM+6?=
 =?us-ascii?Q?TFfiaOMFYeq7KmdZMgn24X3TadZFYAxVgRf+A1RViPCV/PEt84QZ4t3m2con?=
 =?us-ascii?Q?LI5XGjjHNYken1Rrwz9EmtTx6jYl68Ma10WZqkHWvmEu5feHfwj7Z0QJxg+u?=
 =?us-ascii?Q?HYbwsjs3D76TmRhF9nDgF5EOaOjA4XCSBh1TvVmGoOq8z0pq5VXseX0ZnC5R?=
 =?us-ascii?Q?dByz9VwmdyaLwwAEpJLUrj4wc7GV0aqT/S/EXBjM4H3e158RHC0HCcK5Is0c?=
 =?us-ascii?Q?cND6ZbThKtGBaD08gxbiQ0J0dCAQyZwBGdxEpQdYmG77ozhTrad2kLEoEJ6b?=
 =?us-ascii?Q?v6EIxdERp56siXL2KjKwTV5LwVooINjoDUYqgBjyaZigFWa/tI/psmSdpDlh?=
 =?us-ascii?Q?nysenuXIw3045LfCal4hr04z0QsPnJHikrBGDSrp6dU8EXLtuHlgiVhRctZl?=
 =?us-ascii?Q?ThyEzju/2Y1laKYFkxFiYnDTR904+VCgcwxCHOeG8HQKLtJCe5FbJEXAnsrI?=
 =?us-ascii?Q?xOKzjayJqmMPpvA0C7yhC66F5HhIliiipi2cw2EentLFfYSttKVcxaQ1+tqE?=
 =?us-ascii?Q?b4dRTps8meMIRbeOBt3n43REdmrHpSQfLrHd7W2irXTnYAyDv7jUzYAWS/CJ?=
 =?us-ascii?Q?pVqIwQiCZjq9TnzACIUSc5MKSA1aJTpDUFjMtpkB9QteXw0raRKaEsCyvnKh?=
 =?us-ascii?Q?tTWF4lvitzRKzn6iwshXr3IwE1ElXx4qzihqj511QTsfIbEF88LnBtfXyMim?=
 =?us-ascii?Q?7u7qzxw73LWg4ejdf2BSD6x32R4kHi6vwkXg3nvEcigbK30o2sXzbN8mzKJT?=
 =?us-ascii?Q?+N2r7bKxxeK0ffqS6rEEkcszkTm3tt3WC527Qye/JlWPMWxEikr9tTCisQSd?=
 =?us-ascii?Q?w6Fvii92Q6MoqsmBdBIBHxCfm6U/pVtUec1e+UiKCUzZDaCxYdSyxTkmhP5S?=
 =?us-ascii?Q?Sg0yZmCWW/wEES5hSVb2agZweQzhqy9CpDafHqVyKV61MoVboHrxJE+7zWqh?=
 =?us-ascii?Q?cclaiiU448av9/xK3Pko6WLQoaAXOFzMHgPQzJvY2GHL0E1PFVANinMHVjPO?=
 =?us-ascii?Q?/09AnHTHcZJY9Wv4LiuIkhMI+ItyfI+RTY9y5zsHz7nK4BteSCifR6hhBNZ7?=
 =?us-ascii?Q?xo18JjHkJAbo6SdllvZJW4AIUNnPAkfEOv3td/+7Gmm+VeCG1F8feCODgtNX?=
 =?us-ascii?Q?LA3ivpBeldimL+FQPSwmGbVpRStWRjX2QM92PTMVrGSuyd5aj1HvtwAeOftj?=
 =?us-ascii?Q?zl4Cq+guwyBQCJTUguq81W9GqTRFIXiPy9RLjlPSW6hjQOLlrygWL7QQp4iB?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd53365f-1313-4253-7186-08dd9de045c4
X-MS-Exchange-CrossTenant-AuthSource: AM8PR08MB5732.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 12:07:52.6560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OcPA36EfY/i2c/iDBiwUdUE6yMrchBk4Xv1QaaealhLbsctJBUZMf995LSbUjGMvDOHx0fd7ntxBJFB6883LmtGAAuwCfr/6PYLrLlUouuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9277
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=andrey.zhadchenko@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

HBitmaps allow us to search set bits pretty fast. On the contrary,
when searching zeroes, we may be forced to fully traverse the lower
level.
When we run blockdev-backup with mode=full on top of snapshot filter
+ cbw filter, the job fills copy bitmap by calling block_status()
with range (X, virtual_size). The problem is that we check for zeroes
in this whole range. We also hit the worst case here, as access
bitmap is fully set and we need to scan the entire lowest level.
After scanning the full bitmap we actually ask the block status of
original image, which may return significantly lower amount of empty
clusters.
Beacuse of this, the backup job 'hangs' on block copy initializaiton
for a long time with 100% CPU.

Example copy bitmap buildup time for image with clu_size=65536 and
preallocated metadata
size                 10T   11T
blockdev-backup      52s   57s
cbw + snap           325s  413s
cbw + snap + patch   55s   61s

To fix it, inverse the access bitmap in cbw filter: rather set it
when the user is not allowed to read the cluster.

Update qemu-iotest 257: now access bitmap have count 0 instead of
the image size 67108864

Signed-off-by: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
---
 block/copy-before-write.c  | 17 ++++++++++-------
 tests/qemu-iotests/257.out | 28 ++++++++++++++--------------
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index fd470f5f92..7e074ad569 100644
--- a/block/copy-before-write.c
+++ b/block/copy-before-write.c
@@ -53,7 +53,7 @@ typedef struct BDRVCopyBeforeWriteState {
     CoMutex lock;
 
     /*
-     * @access_bitmap: represents areas allowed for reading by fleecing user.
+     * @access_bitmap: represents areas disallowed for reading by fleecing user.
      * Reading from non-dirty areas leads to -EACCES.
      */
     BdrvDirtyBitmap *access_bitmap;
@@ -220,7 +220,7 @@ cbw_snapshot_read_lock(BlockDriverState *bs, int64_t offset, int64_t bytes,
         return NULL;
     }
 
-    if (bdrv_dirty_bitmap_next_zero(s->access_bitmap, offset, bytes) != -1) {
+    if (bdrv_dirty_bitmap_next_dirty(s->access_bitmap, offset, bytes) != -1) {
         g_free(req);
         return NULL;
     }
@@ -338,8 +338,8 @@ cbw_co_pdiscard_snapshot(BlockDriverState *bs, int64_t offset, int64_t bytes)
     aligned_bytes = aligned_end - aligned_offset;
 
     WITH_QEMU_LOCK_GUARD(&s->lock) {
-        bdrv_reset_dirty_bitmap(s->access_bitmap, aligned_offset,
-                                aligned_bytes);
+        bdrv_set_dirty_bitmap(s->access_bitmap, aligned_offset,
+                              aligned_bytes);
     }
 
     block_copy_reset(s->bcs, aligned_offset, aligned_bytes);
@@ -501,9 +501,12 @@ static int cbw_open(BlockDriverState *bs, QDict *options, int flags,
         return -EINVAL;
     }
     bdrv_disable_dirty_bitmap(s->access_bitmap);
-    bdrv_dirty_bitmap_merge_internal(s->access_bitmap,
-                                     block_copy_dirty_bitmap(s->bcs), NULL,
-                                     true);
+    if (bitmap) {
+        bdrv_dirty_bitmap_merge_internal(s->access_bitmap,
+                                         block_copy_dirty_bitmap(s->bcs), NULL,
+                                         true);
+        bdrv_dirty_bitmap_inverse(s->access_bitmap);
+    }
 
     qemu_co_mutex_init(&s->lock);
     QLIST_INIT(&s->frozen_read_reqs);
diff --git a/tests/qemu-iotests/257.out b/tests/qemu-iotests/257.out
index c33dd7f3a9..55efb418e6 100644
--- a/tests/qemu-iotests/257.out
+++ b/tests/qemu-iotests/257.out
@@ -109,7 +109,7 @@ write -P0x67 0x3fe0000 0x20000
     "backup-top": [
       {
         "busy": false,
-        "count": 67108864,
+        "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
@@ -585,7 +585,7 @@ write -P0x67 0x3fe0000 0x20000
     "backup-top": [
       {
         "busy": false,
-        "count": 67108864,
+        "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
@@ -854,7 +854,7 @@ write -P0x67 0x3fe0000 0x20000
     "backup-top": [
       {
         "busy": false,
-        "count": 67108864,
+        "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
@@ -1330,7 +1330,7 @@ write -P0x67 0x3fe0000 0x20000
     "backup-top": [
       {
         "busy": false,
-        "count": 67108864,
+        "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
@@ -1599,7 +1599,7 @@ write -P0x67 0x3fe0000 0x20000
     "backup-top": [
       {
         "busy": false,
-        "count": 67108864,
+        "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
@@ -2075,7 +2075,7 @@ write -P0x67 0x3fe0000 0x20000
     "backup-top": [
       {
         "busy": false,
-        "count": 67108864,
+        "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
@@ -2344,7 +2344,7 @@ write -P0x67 0x3fe0000 0x20000
     "backup-top": [
       {
         "busy": false,
-        "count": 67108864,
+        "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
@@ -2820,7 +2820,7 @@ write -P0x67 0x3fe0000 0x20000
     "backup-top": [
       {
         "busy": false,
-        "count": 67108864,
+        "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
@@ -3089,7 +3089,7 @@ write -P0x67 0x3fe0000 0x20000
     "backup-top": [
       {
         "busy": false,
-        "count": 67108864,
+        "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
@@ -3565,7 +3565,7 @@ write -P0x67 0x3fe0000 0x20000
     "backup-top": [
       {
         "busy": false,
-        "count": 67108864,
+        "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
@@ -3834,7 +3834,7 @@ write -P0x67 0x3fe0000 0x20000
     "backup-top": [
       {
         "busy": false,
-        "count": 67108864,
+        "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
@@ -4310,7 +4310,7 @@ write -P0x67 0x3fe0000 0x20000
     "backup-top": [
       {
         "busy": false,
-        "count": 67108864,
+        "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
@@ -4579,7 +4579,7 @@ write -P0x67 0x3fe0000 0x20000
     "backup-top": [
       {
         "busy": false,
-        "count": 67108864,
+        "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
@@ -5055,7 +5055,7 @@ write -P0x67 0x3fe0000 0x20000
     "backup-top": [
       {
         "busy": false,
-        "count": 67108864,
+        "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
-- 
2.43.0


