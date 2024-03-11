Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EAD1C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkFu-0005wq-Cn; Mon, 11 Mar 2024 14:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkEy-0005ZT-C9; Mon, 11 Mar 2024 14:19:16 -0400
Received: from mail-vi1eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2613::701]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkEw-0006sL-Gv; Mon, 11 Mar 2024 14:19:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+SnGS8VVg2OBCoOKfP22b9qTPqh07cnK+GvX+NGNCKR5RkkRVTia51AWHe1uxCtLdmqgkweB2SotZO1RLNC5Uu9HoB8LzxvDfMG+JQBF1qwUZWZZ8MIDVGx8gKSYyE4M4IYaOWST7wX1wvHvmXU8zwvWyVrXdGnPySX+x+BOvfesN27C10296xMcpaSmi+Eh+H0F5DjoutAZZHIlcSliqMR5JzWWHCZlIyf6HrJdUPD2fgta0hR6InexOSrtxotgsyrIf1QbAyw+gGkBKJnVJuJsTa1sSYUuANqWR8xlXeLwtzZN6XiSPdg8iskkUrOT/uK0PkWbCASZ9g2S0L3iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZAYmTt6a8iWzR3ObMRJXGIqRa8RVqoX0brRg6ZAt0Q=;
 b=Q6tySheIECceHn5npC3+A+3H7Ie0YN043oSytuB2JAv18LA2JhWNgj8J8sdoOis5ZX7rXOms8kP+NvVjCdmhotiRqDNZX/2ydOhR5IDLjksaLRFG6jQzHvrV/UpEMi1ZXRUNn1KI51fznywqfg5YQqIFSON/RNY2JtjoprfbequOY2mCpGJRi7hnKRHzcHm6t2QrQgtE5IwqNQ92EgxTPdfSxrKh9uY/hQ98SqKmT81mlmP6o0D7t6NBgFugUly2e6OLGH35R6ytRm8ReXtyfuwf0bIIu6ovAAbD544NEMRo6uHd+Tssam23mZnprW9vD/ChsOQPJlNcdaIvyEbyzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZAYmTt6a8iWzR3ObMRJXGIqRa8RVqoX0brRg6ZAt0Q=;
 b=A+ITjWSsv2P7vadMfDKxUBzx9bXW/LB7l23yZZoDTJHFfVq+ZhfNefGhmHLmHvn2FLaGi4G1Q9fCVABZrHfpihvkDuUQ2gHDM5PN0BvOzjTRmN/35lAOdwMnMI76Ejy+UY6G89cHdwPenib6y1TfaR4qFQ3dF5fKfpFMjlpsXNKRPEPDqaj0rVSupgui4KM3+SK3Tx5bPcU8o0nmBXxmj3TPMnHJY3tT9CICykWzr65rbGS4reWjDWC++RYY7tpPGNhb0nvKdrcWZo2HUcwIDai5ibsm/AgYQ4aEF2zeQmfILAvc98zAlx/DXjhVI7pbbRL1wMG1JdYG8zbG0oYMfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com (2603:10a6:10:530::22)
 by DBAPR08MB5653.eurprd08.prod.outlook.com (2603:10a6:10:1a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 18:18:59 +0000
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde]) by DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde%3]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 18:18:59 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v5 03/22] parallels: Make mark_used() a global function
Date: Mon, 11 Mar 2024 19:18:31 +0100
Message-Id: <20240311181850.73013-4-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 14144f72-9241-4948-8da7-08dc41f7b8df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9SoDRhKBJwXu8fKDBIDYIrghpO6aliooU9aeGwHx/ecDYA0QCeq03nwDbq6cL7CbxLsDuw45JRrCTPA5mXi6Mb/97vpKNVT+AvWfpzqnWxBsc5oKkKpwBa0QyIbCk/n0gp+LDtifR7PFI09mJyOZVaOsXA4JPSETOebdyAgt0Rxs5KZxjvWN8z5Nuf0HCDCZb38ZBhyzXOvPp44i4zkgTK7s6PJIxbA27i++/hzevgHt1ehOwxuJWvJ6Hfolp8mmVriLNSLi9h4qMjnHKj2K2i6qsMoBxXtfqOctGh2ksZslSjoABO8/xAKDxCTO2CCHDQiXD+KdEAazFFYhU+WywFosvHSLxcwziPGoImefrMUquAmUiVsvF97JVIqi7VMOGhugFxVsi0kD/WQIF4h5tT8pVZBw50A6oTK4abUXsNN48dgu+4xEo8VFrsmnQdwBGm5cUqO+Cwy6cVe8s7gUra71ItdJPHO44JKE+VgFJOAPU7EnHMcJtj3YpKdYdVwQYb1Pz1AEegZvnpaathebfTrgqXLBkxxbWVrY4cAUno+gMJX8b2rkYJ5ro1WiTZFVppS3Si3geI9EUrbKPEalt5c+OHgiUmEDc9kWfGWkNsS343X8g4Bc/gibjJ2V8V1yblBxpRajgqv48bqgvrf4BV7vK3iTL/46/OC2lN8dbLYvl+jaa+a5lkKllgYhC2k6JmEtDX41D7Qc/inQxqkAMB70Zdahg7LXMdHlDT+VNY8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10721.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(376005)(1800799015)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f32Fc/mtmyexJqiew/8yoNm89R+R+7JgkT+AqJf21vnBTQwup4plGJf13S3P?=
 =?us-ascii?Q?6djklz/nBDHhDtr0H+JJUQCWRlxLQPQ57HPj9tRIP8A07F++6RL4lsnCya5i?=
 =?us-ascii?Q?k4ECVi/bzm/LJTWqwWgb1hEoqKrp3tSv+mnoJiMwtko+pHZMFBCMIBpr+qe6?=
 =?us-ascii?Q?Ve0OXpTrumWI2wNHUJLWv5qU4+NYNCyhv2DSFRjxLwq9PVSfJjgIdZKy17+T?=
 =?us-ascii?Q?Mk/m3y2vSIjHYvVuuvox2PZieYpcXfdW+YcNRDcZYdrPqJkUDrvxbC5x3QH0?=
 =?us-ascii?Q?oapOyk+N8sW56+LuajoB3KAH/X5aIIiI80meSr5+su20f8ae4Op3kJlNdL1s?=
 =?us-ascii?Q?XUM+SjwnziciEy36ybujIlzuwioGjZQor0R+W0cm6nDC878idKEnCnXXD/KQ?=
 =?us-ascii?Q?YkBV6qndJRgKTFLgc4YtZu5kr4aBQHcW0dhT7yZKZcv0iTO3XYNttNBxef4D?=
 =?us-ascii?Q?mTZ/VUeGivrMGGALwHgwcqw/uRILsOPTKdKCpWqbZ+n8XUDsXOnzzREVSZL5?=
 =?us-ascii?Q?iVok+rP7U9IiJgwNaKjLqeSP6fyXUvQYk8t5+9dD6Lfkh6HoeRHGN29RvLE7?=
 =?us-ascii?Q?r27wtL8gwIPDM8X7QMdHn7TGkUPCmxSKLqtbSIB4VbHmgIpQgpNeZ4Xpn9BK?=
 =?us-ascii?Q?3QbCsCT8OOEG3Q1lC/QzyjCjcDU5BdlhRfpd6v4Bc6Vs3j7anMGOiqS2R6UK?=
 =?us-ascii?Q?hpOA4MLaQWThjLKEPQ0j0VDp5f2R6NwFSPKhpOvK+ONDWxtNkSiX4YsEA2za?=
 =?us-ascii?Q?HXernFsL5fRmKU8lyngh53fYj2GKzZtr7tmu0NarADRyzhPKXh4HAySIBHyD?=
 =?us-ascii?Q?oWdKC2HVt0+IPxVYmZ81gNXx24OSWKqrFWhFfBrpqZ0nhb/SpbiiiGZ59BIO?=
 =?us-ascii?Q?mR64KGcTiey91sZJjKi7evNJ22KAfJkRUrGlf6dAAyfgRyQ4LJjzD1TYgjra?=
 =?us-ascii?Q?dBVAEv03H4Edt6ddN9G1PDKdIZXqNVumUWkmpUBEMR+xSFW3Yd9Pf8SQ8cOg?=
 =?us-ascii?Q?KE0ehIr8Uqk2LD8IQytSphZOw2yKPfV41v/wNfYA56j8F0PLrRIt/MDhgz1s?=
 =?us-ascii?Q?hgBsmN2GasOE5C3FFUCNq7OQrNUXPFC/tVvlGvgKY1+agMM1YRFqCivrrT8/?=
 =?us-ascii?Q?1p6Hn4Xr0+JDaD37MbCGoD1nMppa/r3peAqlI5OmZ8THHbGePmFB+VY56iuH?=
 =?us-ascii?Q?3DfCafbARfBzj5wrxJsAyzax2mUea92MZNYipetb7t4sK8jdObhM7Hqhu2wb?=
 =?us-ascii?Q?wh/6eh8TumnLbNREd/BsoRQHopDxSaSV+j7mx5Xnh+ZiAPR+q36WKWuYVeyU?=
 =?us-ascii?Q?iREgwCJCMRBu0FGMG/v3iaissVjviyNO0cdXOqOS6WdvrkYqO+VOUQv1+Oj6?=
 =?us-ascii?Q?jf2u7fCeFkIwtK6Yq5Uk6ZrJUuDc1BiSfCsKaKJw2zA7OZK8NA1oVRI3P008?=
 =?us-ascii?Q?bIst/D5T/lc3E562nFD0eeHzoBqR+tXiPAdR6Ue6V+VQWEtsz/M8SNqsxHm0?=
 =?us-ascii?Q?qX+Y5UEu1aFamAnk1ogVmyLUOEW2vtwQjaWECjBp69Mhq7QFQ6QiXPxaO9xS?=
 =?us-ascii?Q?/zSHmshdVf1Dt7tqdqTtjjmO8hF+qRXJkBR1JDtYeTMrG2JvVPQaCBko1vmR?=
 =?us-ascii?Q?YxjqjDleyToZcBWAvk9b6Vk=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14144f72-9241-4948-8da7-08dc41f7b8df
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10721.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 18:18:59.5232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrkk21Z1HuZrQBPE6ExLpr5rYG4bPk0NsxaqZi76FIw8nWuCkr0e+ss0eWnx4myCCegmwvQKiq4/SKogkD7+tNN/lO3sDbuYILY5FoTtCUs=
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

We will need this function and a function for marking unused clusters (will
be added in the next patch) in parallels-ext.c too. Let it be a global
function parallels_mark_used().

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 14 ++++++++------
 block/parallels.h |  3 +++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 992362ce29..ae524f1820 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -178,8 +178,8 @@ static void parallels_set_bat_entry(BDRVParallelsState *s,
     bitmap_set(s->bat_dirty_bmap, bat_entry_off(index) / s->bat_dirty_block, 1);
 }
 
-static int mark_used(BlockDriverState *bs, unsigned long *bitmap,
-                     uint32_t bitmap_size, int64_t off, uint32_t count)
+int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
+                        uint32_t bitmap_size, int64_t off, uint32_t count)
 {
     BDRVParallelsState *s = bs->opaque;
     uint32_t cluster_index = host_cluster_index(s, off);
@@ -232,7 +232,8 @@ static int GRAPH_RDLOCK parallels_fill_used_bitmap(BlockDriverState *bs)
             continue;
         }
 
-        err2 = mark_used(bs, s->used_bmap, s->used_bmap_size, host_off, 1);
+        err2 = parallels_mark_used(bs, s->used_bmap, s->used_bmap_size,
+                                   host_off, 1);
         if (err2 < 0 && err == 0) {
             err = err2;
         }
@@ -366,7 +367,8 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
         }
     }
 
-    ret = mark_used(bs, s->used_bmap, s->used_bmap_size, host_off, to_allocate);
+    ret = parallels_mark_used(bs, s->used_bmap, s->used_bmap_size,
+                              host_off, to_allocate);
     if (ret < 0) {
         /* Image consistency is broken. Alarm! */
         return ret;
@@ -827,7 +829,7 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
             continue;
         }
 
-        ret = mark_used(bs, bitmap, bitmap_size, host_off, 1);
+        ret = parallels_mark_used(bs, bitmap, bitmap_size, host_off, 1);
         assert(ret != -E2BIG);
         if (ret == 0) {
             continue;
@@ -887,7 +889,7 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
          * considered, and the bitmap size doesn't change. This specifically
          * means that -E2BIG is OK.
          */
-        ret = mark_used(bs, bitmap, bitmap_size, host_off, 1);
+        ret = parallels_mark_used(bs, bitmap, bitmap_size, host_off, 1);
         if (ret == -EBUSY) {
             res->check_errors++;
             goto out_repair_bat;
diff --git a/block/parallels.h b/block/parallels.h
index 423b2ad727..68077416b1 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -90,6 +90,9 @@ typedef struct BDRVParallelsState {
     Error *migration_blocker;
 } BDRVParallelsState;
 
+int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
+                        uint32_t bitmap_size, int64_t off, uint32_t count);
+
 int GRAPH_RDLOCK
 parallels_read_format_extension(BlockDriverState *bs, int64_t ext_off,
                                 Error **errp);
-- 
2.40.1


