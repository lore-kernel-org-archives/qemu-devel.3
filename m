Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5BDC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkGE-0006A4-SI; Mon, 11 Mar 2024 14:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkFD-0005aw-2f; Mon, 11 Mar 2024 14:19:28 -0400
Received: from mail-vi1eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2613::701]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkF2-0006si-6U; Mon, 11 Mar 2024 14:19:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivVAWSSe3Yw2IWikUaA7NmvtQlHXg3EblR8gZfA570HKGnU4CxEYK13Fq+sXb9EjkbQdmisnUAfAlDAGYzdocvvDDT905VXDWTczbCcYhfseqZ6KsdBLVNdjt+rV54LBJAk6jcffQhwXVq0k1ifih263EsPoNFsuklX0unobI53mIfT9i46HS7+6XsKmJtG1AK3fHbGxBB2MkFNs7wctCtyHx8s/Khf7HSe5Pbto7WHCZ0v+CIw2zHe9AmB7d4E5rIT7bU0pvUyjsHl/sDRA/wdGe1PEU6HCTTRIubLC4iytgPfbAGPA+SPbnd1KS2TOGSD24EJ5StoC7FfTaFxXJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZBsFCKP6ucJO7Y4OPY81yzWZFw7jqOcVVtyY/T57sc=;
 b=OQCeYroFYOqHyT7AvS9RV8ywgIZonaqUMqykw4hFeEH1MVELDGpvXkz1adEoQOQJXq2nIKNrQfNfe1JGTS5GoQm+f5h7eBsdoTdpGiECV29bll9h/QZHXOWI+rhyCfD2KHiZ8s70Fk3L89h/tNYikdQoyr75/A4qpSnRMWW7mnH/6douNEcCeSVsKEO841/o3a4Lrn7+dx92qwk56PuFtvijIKplosIsEy/lRJIcILQimhHxMGglm5a5ZAjvDDZnY+OnEXwE37ZuMK8Y6FUaeguViIxvDCV0tAtIo4UswgdkUXK2q1wwSHqAqdPzQhLH3CRRiRaBZ0aCbAENkAc2Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZBsFCKP6ucJO7Y4OPY81yzWZFw7jqOcVVtyY/T57sc=;
 b=E/V0qNh+4GllV90AlxD5n+EkxPirCt7U7iBaKIIsfv7kkxWDBiBt3CVH70BVdnvkEFDEgHzLM/mZtnGhzo0yLV0YQCEQuBMT0dKlt9FXObk8QqTaSIkKUnDygYh8DIzRWpssPdZ9aRnDpk1R9RRJ3U0Rg9Pswl8LTN/LPmPojUH1jMjZQpPb2UqCPmOqN6fv/oHSW+DWqorqhPOdEfBXk/CoyzmT1hRhbGjbih9C5aWCXkr32ETAhLocLBfRlJmp5fhz0tXYV4ZfhiDrJ+0x8U4Qd/mAJOd5i2iGHdHWEQ/RY2PRbgg9YBd+NjsQLyItMDLpJ4D4W98a/36NcmNYNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com (2603:10a6:10:530::22)
 by DBAPR08MB5653.eurprd08.prod.outlook.com (2603:10a6:10:1a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 18:19:01 +0000
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde]) by DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde%3]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 18:19:01 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v5 06/22] parallels: Move host clusters allocation to a
 separate function
Date: Mon, 11 Mar 2024 19:18:34 +0100
Message-Id: <20240311181850.73013-7-alexander.ivanov@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: DBBPR08MB10721:EE_|DBAPR08MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ec2706-e86e-4fe2-1fd9-08dc41f7ba15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UiOmmm8dYsAI16x9rbF/VPxK2BIKoaNF/Jm3dy7VGX0vfLZEma8vII1eUcruq/qIlL9Cx28+Vjs7+gJ47VY8ZODS/xJ21SxjtYw1+VmmmnT6PORAOjgJb4zNhD6NPtorZ+rbgp3N/7du3AGu9t0lzp8Y0IPY7XZQGr8RiWIytPyljOiYKky0Gqv3fEvtt7/I5CcK6rv3RDVzY/qFnhD4ZJdMMounql47DHYuFBFsK3EhLo3HJ6DTc0ca9zly2zSqEvWLQzFevMPfC4MKyx+iV0olfjVm1PEdrGwxlu68qxlfcF/eRFDw0MG/YY/PNpv/HK+QpFRjWHxd64notK4oFRTy8671UeJtA3uicISGRgyyBxwNsv6XXp9fMiuGsZfe2giPhFcULgUutg7+AyOEjXSQf+4OlESmJaJgw6YPMGZNSEZAylClGAGq4CzJRYHU6aF3ogREhYb4Xnn/2etEkMPxWAmWaf+QoAjKm6+GVrIkZetBs/XzM4NC7wEcFOh9xIMk85qwEGTVdW3S43ngQTXU7LNP7Qiw97EEW8U+P6UhSUSPhu8lR9cvnkUGVdshjVY+p+JH0d8hTQ5fZH2fRLVHS2I503Haomeo6wkIY9vAdyeIoI1VRvKjZvux3eSdrs8xVxXBQjQlnrSX4a6PV2/RhpqRy4jYddjbujAdj7aTCervWxUFBW+4TO3lzPnumXdmcPJD7JYbL/ULfjyhQG3SjzXIQ2wWWZyy/yQtviU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10721.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(376005)(1800799015)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gXXFbKv/oxEm3rCsjHPfUdmGZaTjWVBqOh4BUrPKZNJrBNXDg1skgLPw/JDX?=
 =?us-ascii?Q?yqKXguDY+F4Z0QqkX159Xp0K0sQLXqg3PsGclE1y1syAGdotuH+eO++7GghX?=
 =?us-ascii?Q?OLIf1ayNcg/fDEmI8o5y3EExQtK7CMiOs9SksN2Sd/Pp+XzgnsYXbENfew9y?=
 =?us-ascii?Q?VGTQZZg6e6vBw9DYWYpViMd+4S/GeiqzMbLKRXG3AswLiCJvexJu5sVee5zk?=
 =?us-ascii?Q?sWeaG2hN5VZavcZMM7IbY+rIaLnZgBQDi0UcGoH4gzyslzG8lWgfPYkI9ZTw?=
 =?us-ascii?Q?GfssnGptJGeO0NiVnkVkzQaUVYznr6ruVk5A5XkfVyZ9UYxmdZeD3OweKbhl?=
 =?us-ascii?Q?UmkUz05dwTiQ5Ny1VfpYJJwTf2MnT8M4f+Ju1n4wethuAvUDK1baOlaKTxYn?=
 =?us-ascii?Q?ZyeCtf5ZhIEVJdVKcyQ+6hcU/bGGhWJzcZTFq9UxUKm9qo0/iB/CDo2w6JmT?=
 =?us-ascii?Q?K4nAHiYxa+2dWzA5Ob2H22p8z7jVb0WUekhUCwx8fLN6+MY8MqrcRjHc3g/8?=
 =?us-ascii?Q?BuDJB9ENbOQrsP4kk0P7tWb4Q/LZXcQe0O5NlRmy5w5KjHzuJ1L4c7yO+zje?=
 =?us-ascii?Q?ebXkgSRi5zzgucZTKIBOYA4PEdX15j2rEG34p2nJD55NE44QddaAEF7NNFXf?=
 =?us-ascii?Q?ygZ1/ye409if6OHIZDq8/RQ+YTZzaOX/ySSMg8UkYw5fNqyVXoMZvUH4/bZe?=
 =?us-ascii?Q?cBMpl4MdV+ZHDBF+nBb3pbFx9WrrBBGqbTUhZ8lDDVdKzgU4vdR3HQLym1vH?=
 =?us-ascii?Q?7bQ23dPHdD3+/DDArWWoh1OzCcZCwJaH8NRgXzk3snauJ3zoa5l22fe3qKoR?=
 =?us-ascii?Q?Jcx8/D8aJLa1YFI0mopC0Wovgo5f6yKsImC21hgTPsqgZSFdEkPbx/gsXNiM?=
 =?us-ascii?Q?Z2TAqP0AG5k6oItXwjhB0NsN+9wTNFwJXaB3fjPytIbTldLbAINrUP2kVaa9?=
 =?us-ascii?Q?49WBZy+UVXX+cLe+5JTsQYtjiSTKEOXjfnwQr9//X7Dp8K7TV2SG1y5jG2js?=
 =?us-ascii?Q?VOCU7TkWuyr8DTPpGaS6dHv4n1iAapW2CSsPnKqrwmJbeKgcDa8gi+Ts0CFj?=
 =?us-ascii?Q?SVH82qQYvfK8pP/hbMnHEjxHtMwGG7nz5Izc+KuvxrprOsps4n663teuxWLp?=
 =?us-ascii?Q?BD+EE19hU/BbnBp227GiOPXj4YqaoEOoycseV8n+6BjjdhN4bnMRGxZD60YI?=
 =?us-ascii?Q?45Dz2FMQIrrG2BTTcgEx6LIhutJmxFHmfW3FsDmdDmwCJTg7DqANdG4WHcZ0?=
 =?us-ascii?Q?q4eZkrUdSXqyqV2QzcvE3DXU963CStSTBc83pwgc63kOl0kn0UNoEal7bc6M?=
 =?us-ascii?Q?SDgqitOPE2fHoR7YKz0MEluE0tDaOW0hXXmfmMadQNe5JSYkI3iCbKVvUf9m?=
 =?us-ascii?Q?pEGj+rOZ1Sjv8ETI/Gwq+4HeCh7orbNNmYGM0ovPnKJXCvEkh+qR6E3On6gn?=
 =?us-ascii?Q?XQLtF5af0xrt2m5ExXneA9axovB/sREGknQQTuJ+LHnFY/0a8H91vbYSlBDm?=
 =?us-ascii?Q?r7FNhfJ1KVoYkyO8fmUGs1KtL7+uvIHbyCX6c2Qc9ddWvvAiLHO9X3OO+Jfr?=
 =?us-ascii?Q?4Ad+J5LxT8oWHFYdVRcqfnbxwO8YW/gAJBmzyaK5TKClnBKTsMoC63ilOHCG?=
 =?us-ascii?Q?jEmd/0uOMtvPSZgYmAPyOu0=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ec2706-e86e-4fe2-1fd9-08dc41f7ba15
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10721.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 18:19:01.5581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DicKhyIr/TmMWG5KbgmhetpIod3Zd+Ji3zUbOqdpdbYhxRAUxfnPxX92cGDUSLkm+zJBOd3rqDI2iUuYL76+aMLwu0glTej77JGSWeumtwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5653
Received-SPF: pass client-ip=2a01:111:f403:2613::701;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
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

For parallels images extensions we need to allocate host clusters
without any connection to BAT. Move host clusters allocation code to
parallels_allocate_host_clusters().

This function can be called not only from coroutines so all the
*_co_* functions were replaced by corresponding wrappers.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 123 +++++++++++++++++++++++++---------------------
 block/parallels.h |   3 ++
 2 files changed, 71 insertions(+), 55 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 13726fb3d5..c6d82961c9 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -268,42 +268,21 @@ static void parallels_free_used_bitmap(BlockDriverState *bs)
     s->used_bmap = NULL;
 }
 
-static int64_t coroutine_fn GRAPH_RDLOCK
-allocate_clusters(BlockDriverState *bs, int64_t sector_num,
-                  int nb_sectors, int *pnum)
+int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
+                                                      int64_t *clusters)
 {
-    int ret = 0;
     BDRVParallelsState *s = bs->opaque;
-    int64_t i, pos, idx, to_allocate, first_free, host_off;
-
-    pos = block_status(s, sector_num, nb_sectors, pnum);
-    if (pos > 0) {
-        return pos;
-    }
-
-    idx = sector_num / s->tracks;
-    to_allocate = DIV_ROUND_UP(sector_num + *pnum, s->tracks) - idx;
-
-    /*
-     * This function is called only by parallels_co_writev(), which will never
-     * pass a sector_num at or beyond the end of the image (because the block
-     * layer never passes such a sector_num to that function). Therefore, idx
-     * is always below s->bat_size.
-     * block_status() will limit *pnum so that sector_num + *pnum will not
-     * exceed the image end. Therefore, idx + to_allocate cannot exceed
-     * s->bat_size.
-     * Note that s->bat_size is an unsigned int, therefore idx + to_allocate
-     * will always fit into a uint32_t.
-     */
-    assert(idx < s->bat_size && idx + to_allocate <= s->bat_size);
+    int64_t first_free, next_used, host_off, prealloc_clusters;
+    int64_t bytes, prealloc_bytes;
+    uint32_t new_usedsize;
+    int ret = 0;
 
     first_free = find_first_zero_bit(s->used_bmap, s->used_bmap_size);
     if (first_free == s->used_bmap_size) {
-        uint32_t new_usedsize;
-        int64_t bytes = to_allocate * s->cluster_size;
-        bytes += s->prealloc_size * BDRV_SECTOR_SIZE;
-
         host_off = s->data_end * BDRV_SECTOR_SIZE;
+        prealloc_clusters = *clusters + s->prealloc_size / s->tracks;
+        bytes = *clusters * s->cluster_size;
+        prealloc_bytes = prealloc_clusters * s->cluster_size;
 
         /*
          * We require the expanded size to read back as zero. If the
@@ -311,15 +290,14 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
          * force the safer-but-slower fallocate.
          */
         if (s->prealloc_mode == PRL_PREALLOC_MODE_TRUNCATE) {
-            ret = bdrv_co_truncate(bs->file, host_off + bytes,
-                                   false, PREALLOC_MODE_OFF,
-                                   BDRV_REQ_ZERO_WRITE, NULL);
+            ret = bdrv_truncate(bs->file, host_off + prealloc_bytes, false,
+                                PREALLOC_MODE_OFF, BDRV_REQ_ZERO_WRITE, NULL);
             if (ret == -ENOTSUP) {
                 s->prealloc_mode = PRL_PREALLOC_MODE_FALLOCATE;
             }
         }
         if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE) {
-            ret = bdrv_co_pwrite_zeroes(bs->file, host_off, bytes, 0);
+            ret = bdrv_pwrite_zeroes(bs->file, host_off, prealloc_bytes, 0);
         }
         if (ret < 0) {
             return ret;
@@ -329,15 +307,15 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
         s->used_bmap = bitmap_zero_extend(s->used_bmap, s->used_bmap_size,
                                           new_usedsize);
         s->used_bmap_size = new_usedsize;
+        if (host_off + bytes > s->data_end * BDRV_SECTOR_SIZE) {
+            s->data_end = (host_off + bytes) / BDRV_SECTOR_SIZE;
+        }
     } else {
-        int64_t next_used;
         next_used = find_next_bit(s->used_bmap, s->used_bmap_size, first_free);
 
         /* Not enough continuous clusters in the middle, adjust the size */
-        if (next_used - first_free < to_allocate) {
-            to_allocate = next_used - first_free;
-            *pnum = (idx + to_allocate) * s->tracks - sector_num;
-        }
+        *clusters = MIN(*clusters, next_used - first_free);
+        bytes = *clusters * s->cluster_size;
 
         host_off = s->data_start * BDRV_SECTOR_SIZE;
         host_off += first_free * s->cluster_size;
@@ -349,14 +327,59 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
          */
         if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE &&
                 host_off < s->data_end * BDRV_SECTOR_SIZE) {
-            ret = bdrv_co_pwrite_zeroes(bs->file, host_off,
-                                        s->cluster_size * to_allocate, 0);
+            ret = bdrv_pwrite_zeroes(bs->file, host_off, bytes, 0);
             if (ret < 0) {
                 return ret;
             }
         }
     }
 
+    ret = parallels_mark_used(bs, s->used_bmap, s->used_bmap_size,
+                              host_off, *clusters);
+    if (ret < 0) {
+        /* Image consistency is broken. Alarm! */
+        return ret;
+    }
+
+    return host_off;
+}
+
+static int64_t coroutine_fn GRAPH_RDLOCK
+allocate_clusters(BlockDriverState *bs, int64_t sector_num,
+                  int nb_sectors, int *pnum)
+{
+    int ret = 0;
+    BDRVParallelsState *s = bs->opaque;
+    int64_t i, pos, idx, to_allocate, host_off;
+
+    pos = block_status(s, sector_num, nb_sectors, pnum);
+    if (pos > 0) {
+        return pos;
+    }
+
+    idx = sector_num / s->tracks;
+    to_allocate = DIV_ROUND_UP(sector_num + *pnum, s->tracks) - idx;
+
+    /*
+     * This function is called only by parallels_co_writev(), which will never
+     * pass a sector_num at or beyond the end of the image (because the block
+     * layer never passes such a sector_num to that function). Therefore, idx
+     * is always below s->bat_size.
+     * block_status() will limit *pnum so that sector_num + *pnum will not
+     * exceed the image end. Therefore, idx + to_allocate cannot exceed
+     * s->bat_size.
+     * Note that s->bat_size is an unsigned int, therefore idx + to_allocate
+     * will always fit into a uint32_t.
+     */
+    assert(idx < s->bat_size && idx + to_allocate <= s->bat_size);
+
+    host_off = parallels_allocate_host_clusters(bs, &to_allocate);
+    if (host_off < 0) {
+        return host_off;
+    }
+
+    *pnum = MIN(*pnum, (idx + to_allocate) * s->tracks - sector_num);
+
     /*
      * Try to read from backing to fill empty clusters
      * FIXME: 1. previous write_zeroes may be redundant
@@ -373,33 +396,23 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
 
         ret = bdrv_co_pread(bs->backing, idx * s->tracks * BDRV_SECTOR_SIZE,
                             nb_cow_bytes, buf, 0);
-        if (ret < 0) {
-            qemu_vfree(buf);
-            return ret;
+        if (ret == 0) {
+            ret = bdrv_co_pwrite(bs->file, host_off, nb_cow_bytes, buf, 0);
         }
 
-        ret = bdrv_co_pwrite(bs->file, s->data_end * BDRV_SECTOR_SIZE,
-                             nb_cow_bytes, buf, 0);
         qemu_vfree(buf);
         if (ret < 0) {
+            parallels_mark_unused(bs, s->used_bmap, s->used_bmap_size,
+                                  host_off, to_allocate);
             return ret;
         }
     }
 
-    ret = parallels_mark_used(bs, s->used_bmap, s->used_bmap_size,
-                              host_off, to_allocate);
-    if (ret < 0) {
-        /* Image consistency is broken. Alarm! */
-        return ret;
-    }
     for (i = 0; i < to_allocate; i++) {
         parallels_set_bat_entry(s, idx + i,
                 host_off / BDRV_SECTOR_SIZE / s->off_multiplier);
         host_off += s->cluster_size;
     }
-    if (host_off > s->data_end * BDRV_SECTOR_SIZE) {
-        s->data_end = host_off / BDRV_SECTOR_SIZE;
-    }
 
     return bat2sect(s, idx) + sector_num % s->tracks;
 }
diff --git a/block/parallels.h b/block/parallels.h
index 02b857b4a4..493c89e976 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -95,6 +95,9 @@ int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
 int parallels_mark_unused(BlockDriverState *bs, unsigned long *bitmap,
                           uint32_t bitmap_size, int64_t off, uint32_t count);
 
+int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
+                                                      int64_t *clusters);
+
 int GRAPH_RDLOCK
 parallels_read_format_extension(BlockDriverState *bs, int64_t ext_off,
                                 Error **errp);
-- 
2.40.1


