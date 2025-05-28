Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0056C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 12:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKFbg-0008N1-Js; Wed, 28 May 2025 08:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1uKFaI-0007ba-Pz; Wed, 28 May 2025 08:08:44 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1uKFaG-0002rr-Qa; Wed, 28 May 2025 08:08:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7vJPU1+38B5akR1OWGykOAlU+OeirhHE2xHx3/JvKVgrRKLvJWxBfJS2YD8F8c1FKTnn+dz6uxbSOWOaJt8XCMRBvE9yx2vr35Hj2v1ZJfRTKk/zDgv6lV1v3TyFFhGonKFQIkSx651apfY3XDzGoEDm3CawOZcpaHXB+UI95DrPQqeSvp/10m4RGA0lm5hgafPgI1HGTft4pi8zpyDGmu3We+t2ROc995zIPzlk8VWMHtJOHAJjDhQLvz/HVrrh2aPlvEp+XGMINDh8TAlZ8hx83/3S5AR6qC8HZw18sUnw527NfAJAiOQooTbPod1SntDtg+pal4zRMZuFpfrfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yE5x+6tUdpFOQQzXQCu+7y6SMrxcYjq76xzhp0+Vrpk=;
 b=i74uXqe7CyOoVNGIOJgvZxpmP0gFoQOcjb0Tl/PCYDS9TDf6GFuW1N5s2vZoS8T0HT/06lUUxlvT/ixciVCDRIngRZh6mf4Fg1ey44/y64XbKX77oPZN3jRWuyi7SZwGHbSDmwH2o4UjILLlmAE4pSsF5W0G/XEAKY7Bjnzkaz5SowDCKntMulr7RxoYXUi+TOnLGdFDwXCoFX7cAScj+KyMFl3sxIGBkgkshyF4Rik8RAYavq2QNBYP5R00v/oFBXiEoORAvGJ1Sz/ilhO6z5/IUvjNCDUpr9IxQkiEF1g2Hnlt3jX2pkBZ4zWONXGO8vG7QzROCjnYVr88wfS65Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yE5x+6tUdpFOQQzXQCu+7y6SMrxcYjq76xzhp0+Vrpk=;
 b=Z2EwrxZ64LKjjYzSYst+rHQNbbySBYDx4Ykm1iuqtBtmYzKJYrOdnkqVTFS19DVVwHcTybCqf0zmFe1s27lJEqZtInEaQWPAlGhHYvXcjTQFk/r2ViV0+6qRsN8MEavqsNV4eZVYMmQRETfAN2MDclgTXQvyw1rFbyfozHW+cBdVuapa0xzo30+CJhbSVkeaQHSYAeJn5nDiwCliQs9LofmAl9AQ4aiw5JdFCQtTHBP+DhvLFw7TnBw3o+m8+WgdXA9w/ayDwwlAlGhoVGOroSk2MQp3aWdh9whdTtNW6c/8rNYYPyp5nrgJI8TccaGCSpzoazmhZopYjCMYDcVKNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM8PR08MB5732.eurprd08.prod.outlook.com (2603:10a6:20b:1d4::16)
 by GV2PR08MB9277.eurprd08.prod.outlook.com (2603:10a6:150:d5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 12:07:54 +0000
Received: from AM8PR08MB5732.eurprd08.prod.outlook.com
 ([fe80::e543:a83c:a260:602b]) by AM8PR08MB5732.eurprd08.prod.outlook.com
 ([fe80::e543:a83c:a260:602b%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 12:07:54 +0000
From: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
To: vsementsov@yandex-team.ru,
	eblake@redhat.com
Cc: qemu-block@nongnu.org, jsnow@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, qemu-devel@nongnu.org, andrey.drobyshev@virtuozzo.com,
 den@virtuozzo.com
Subject: [PATCH v2 4/4] block/copy-before-write: report partial block status
 to snapshot
Date: Wed, 28 May 2025 14:07:31 +0200
Message-ID: <20250528120732.2247150-5-andrey.zhadchenko@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 20f3cef6-1f45-4fb0-61dd-08dd9de0463f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iWmcjTv+kJX6BO+XRY8CtoEWxci0eZRGpekEjZaiJoP8NXZ874RFDLl9b1K7?=
 =?us-ascii?Q?z6rL5Nv7WspQOAyHprBl1MRiHVFtVqL2dq3IZ+ZqT0gm0VMBH1Hy0xnssswz?=
 =?us-ascii?Q?Y974msFewVeeQC4J5wMLOEawf/AICbl1E4CE926f+HNp8DTXEHSp2DE20M2L?=
 =?us-ascii?Q?deimXnryOC/nvzn0Be/LRy/1iwKam7GJpJT4rHkuebvHCforXK++aX+EG6VI?=
 =?us-ascii?Q?XYdByKG635ksYF8KHBQwck6cKYNEqfac/HebFXimO6+IQwdWRXueuIKSClOE?=
 =?us-ascii?Q?JnOzLvOlBjjWeWb2HGGlfeV70NksIjCV3vLG7bDrYq4urKgD/a1xrEi/c1HY?=
 =?us-ascii?Q?ZDyqpqSyGJRMgS4oMZDXsczDagpkiZ5EuiWO74zdoENQCX2fD3dFPK4LzXxC?=
 =?us-ascii?Q?c2wxuRElI7VZ2Z6GtGU2bE3sLZlfFZgW9v3JCkOdMyG18TFjQOGZcuyqVxC0?=
 =?us-ascii?Q?x+EsM7NbL+/VsmzThpGGvjImIq2uLFWB53M31vLYZ8dX/fliqACSvFJ8lHyg?=
 =?us-ascii?Q?vNi8Y1wFX7ZJ6x5kM3KLJ8fj4JF3xj8lx785bOTJu728M68bPTIkMZfdEzos?=
 =?us-ascii?Q?PQMZKGMere6IlIO8fy83bHdyHsPv4cLlNIX62el0Y6qVS+xd6d49guqaEkv2?=
 =?us-ascii?Q?dar+VFggLuUbg9Jt/teO1GMBAbSPin2Of84+vm6tOiCQOT4N/fg5FiRohScl?=
 =?us-ascii?Q?BQbA9f5YQpAySwHToj5+zcTvQiTqAb3q4aSD90H03NONQ4y6lrSC956b7pa8?=
 =?us-ascii?Q?p58GFr613oYFPFeHVmG52I5qkAmXwaoCoIRsvUBjBe4pY1RhZ2EcvtXKX0nE?=
 =?us-ascii?Q?hgKOUnYdubPLOn2Zi/3n0GljbaoUPZaKEoTqVim74tHp41SGgT8uZPoIMGFd?=
 =?us-ascii?Q?7yOhjikwSXLt8Ej6Crq/5bnFsmTw8cBRnv9Sayvt7trh1AsfCINc1gB21xMm?=
 =?us-ascii?Q?/txCkjcRQxsbQh3nvuAZAPBt0smjVL+qxwFzVa6AsoeF0eKQCjLkoH2NgTA0?=
 =?us-ascii?Q?QP/2er6iNKEuFkvnaAV8e8jIxuTv2iTd2g0vzPB2FUb76GiSL/+2EE7x+K9X?=
 =?us-ascii?Q?puiNPRZmw872JtyRAugVmYKXdiNXcwzIQ+xXo5hiNtNvhIINwJOf1OKgRIYu?=
 =?us-ascii?Q?0bAYrzOQYPSzelGI2sPIpaiue+HVnL+DOQXdST4oXq0C5l0zt6pUGYs/pV+c?=
 =?us-ascii?Q?SM452vMpau2X7qBH9iXAnEgkaGPxZZxPVPBLAi0Cr6cDakB4jNjN+yqscQGJ?=
 =?us-ascii?Q?DoGmLxQP7vCnYgsS4w7zorgE7PlJArqXgTAwHh7ZkGtqQrPFwWl2AI8US83/?=
 =?us-ascii?Q?YBlLDsmtYGx7pyojyH3OMAP9vFEeVXesHUieBc7rYb2Jly0EgZx2U4Hxxwuc?=
 =?us-ascii?Q?kq/WOYGXBJGDjTlD2rPZITptf9jsvJ67Lct3FytxVEq3sRypWcPVcStxAs4h?=
 =?us-ascii?Q?lA4ik5Jlhb+Sw4ntC/nJEwyXHdWgUeWzOB7hElORPh16ijJnC2UWjg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR08MB5732.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PFH3mErEyelgdLjAxJHFU+rYyMeF3Qixb03nAfJyuTjIzkSckTSM0sHDoHE/?=
 =?us-ascii?Q?Q8aKOAu3Na0Um01aNT6Uf79d5qph84pRzj/WJ3OOepkm5KjQcPvoMQXewkLm?=
 =?us-ascii?Q?ra65EuxntgMbsAShMehDry8+5CaZvEnDWNuk6ZOHLybytAfPf5cubs+NSpzN?=
 =?us-ascii?Q?B/Rzv/30I+E2g85F8ikJmWdq5Yuezq4kh4HFTFD5s7THpKR/DJhushPcGRP0?=
 =?us-ascii?Q?H0tnCFXSksp623sWn/+UDvtijzKD3moC52Usv+Ar1Ciy/L1PBJugD1TiQI8t?=
 =?us-ascii?Q?9bEzEY8SWDglNRGuIO0YWRPoM1sp96sfhACRk3xX0ztJzP7cijMpXgqi71mY?=
 =?us-ascii?Q?GApaIWM9Vn2cYWfHKq53wRM5tsJXbJPF42ZXVX5oU4ZIPdcyZhrOzeAO3ZvS?=
 =?us-ascii?Q?jUGD3B8zHNXjFDsQ1yu2Mx+MBK1GwRegJL8qgzMs1v1oCJ3Bg+ihasFXKGRa?=
 =?us-ascii?Q?X7A54MK43IQc77j6Guuqbe9SJlD9ygx4KgmmpXVKe6pp6Gb0NmBiq25qpK9z?=
 =?us-ascii?Q?djZbctWFO645qNq3jejoPp+4daAiJZMypbySYs6TSDNMtWbGygUUek/tCAAQ?=
 =?us-ascii?Q?E6TOamlRRyxl2/jrsL+TzTnXKidDu2ljkqCJF8KTqXyT9IJa0l5uPUBFjl8w?=
 =?us-ascii?Q?7nY086vMsknw2w3CeWjIy20FRtRbtSbOIX4YnmVpWE3k+H9xxIl6AEE8ShMX?=
 =?us-ascii?Q?Gj9zKe/BH83z74orTPyC/fVvnVOelyhwMipjAgu5THcoQsgTn3ZN9t3Ygtfa?=
 =?us-ascii?Q?iLU4pa4bqUX1RXuHFWQ/Mcp9tq0dcEiZYUr3dylsDQ0NHwtuVfd3QchLXoJ6?=
 =?us-ascii?Q?eGnBq+ylciXZGjDOE1TBN77nFrO84v8l8IHRO+OA/SPArsctzaGBfyu7pdqQ?=
 =?us-ascii?Q?6c5Vtl0gtc8oaVhVJFlIfH/vlHI6E7WvHPdSnO9APHHJ1GFdXs/GXtcEBWQg?=
 =?us-ascii?Q?Xl4BzFW3eWxPTnUHMimi7eveTTImwQK2uS9doOW2wJtHpWcZKFAcBiDCc/qG?=
 =?us-ascii?Q?nXIpYOnVLNejZ776dVqRyEmfj0qhODsrg9Mvv5RaP32tbbYO4gOJkogaYQUy?=
 =?us-ascii?Q?JmiQ9hYn8G/4MbcYSng6jRONTlHy1KHCc1PA6KrTw/f+DaTzaVFPqGFwwSe/?=
 =?us-ascii?Q?p4Oyb15T8PzAI3f3dU/ATvX+eTCbKvv5p5TE4Dkxs7aCy2sRZPEaalpVofdD?=
 =?us-ascii?Q?1KqkbDXDuInrLGyMNX8WZfsAmTqkrJAZecUBtJUfgAgKjUm/3+W+kRcl8DO1?=
 =?us-ascii?Q?MW9sM59lf+TpZc0Q4Hur80hGDDlPnOOouemd93eL2McjMlouwUfngkjr4zQm?=
 =?us-ascii?Q?Z04lPWMWuLNh1cr/LzRzd+5NPUIKVlUAjwJ1yxAvkwKc/h0ZpJbwUDwmEOkW?=
 =?us-ascii?Q?QIEU8KpzuoWm/QrPDty8myyFLg2e4rXNZQzoYLiRl3qfgFmM7BXJKhrQdk/8?=
 =?us-ascii?Q?JpnFBR5p9cx8IMxg7dBbhBliAcLvtoSYZHZR4W8NRhfVbSyZh+zDLirHg+Nt?=
 =?us-ascii?Q?BxREdYyjvAQP7EVVNUbQNjB3bozZ9opbqJy+uURn5wL3MItAq7hLxEdBllJj?=
 =?us-ascii?Q?W7nqYuzWQrjv43rtBGGKoTLdopqgyk9qPvaaFk+Fiv4Xwbok4IaDlvxRCkcW?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f3cef6-1f45-4fb0-61dd-08dd9de0463f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR08MB5732.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 12:07:53.4793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 24fN8IDzJEdKkpc35x7kqRQV4YLqoxTMJvmJfvipNM29p56+dDuF7DrDvRTqxWIB4NeRxfAh2xpMAtY6Ueu9MLl5HfHvJqAsU/+Iqj+oyH4=
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

until the non-accessible area

Signed-off-by: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
---
 block/copy-before-write.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index 7e074ad569..c5e6e1c112 100644
--- a/block/copy-before-write.c
+++ b/block/copy-before-write.c
@@ -207,10 +207,11 @@ static int coroutine_fn GRAPH_RDLOCK cbw_co_flush(BlockDriverState *bs)
  */
 static BlockReq * coroutine_fn GRAPH_RDLOCK
 cbw_snapshot_read_lock(BlockDriverState *bs, int64_t offset, int64_t bytes,
-                       int64_t *pnum, BdrvChild **file)
+                       int64_t *pnum, BdrvChild **file, bool query)
 {
     BDRVCopyBeforeWriteState *s = bs->opaque;
     BlockReq *req = g_new(BlockReq, 1);
+    int64_t next_dirty;
     bool done;
 
     QEMU_LOCK_GUARD(&s->lock);
@@ -220,9 +221,13 @@ cbw_snapshot_read_lock(BlockDriverState *bs, int64_t offset, int64_t bytes,
         return NULL;
     }
 
-    if (bdrv_dirty_bitmap_next_dirty(s->access_bitmap, offset, bytes) != -1) {
-        g_free(req);
-        return NULL;
+    next_dirty = bdrv_dirty_bitmap_next_dirty(s->access_bitmap, offset, bytes);
+    if (next_dirty != -1) {
+        if (!query || next_dirty == offset) {
+            g_free(req);
+            return NULL;
+        }
+        bytes = offset + bytes - next_dirty;
     }
 
     done = bdrv_dirty_bitmap_status(s->done_bitmap, offset, bytes, pnum);
@@ -270,7 +275,8 @@ cbw_co_preadv_snapshot(BlockDriverState *bs, int64_t offset, int64_t bytes,
     while (bytes) {
         int64_t cur_bytes;
 
-        req = cbw_snapshot_read_lock(bs, offset, bytes, &cur_bytes, &file);
+        req = cbw_snapshot_read_lock(bs, offset, bytes, &cur_bytes, &file,
+                                     false);
         if (!req) {
             return -EACCES;
         }
@@ -302,7 +308,7 @@ cbw_co_snapshot_block_status(BlockDriverState *bs,
     int64_t cur_bytes;
     BdrvChild *child;
 
-    req = cbw_snapshot_read_lock(bs, offset, bytes, &cur_bytes, &child);
+    req = cbw_snapshot_read_lock(bs, offset, bytes, &cur_bytes, &child, true);
     if (!req) {
         return -EACCES;
     }
-- 
2.43.0


