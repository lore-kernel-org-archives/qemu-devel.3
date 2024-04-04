Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02FFCD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 09:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsJ8U-0006hf-Np; Thu, 04 Apr 2024 05:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rsJ8S-0006hM-PJ; Thu, 04 Apr 2024 05:11:52 -0400
Received: from mail-db3eur04on070f.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::70f]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rsJ8Q-0004M1-8A; Thu, 04 Apr 2024 05:11:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiSukamaArkD/LUORLSdM/DEXtINXKwJeg90GRQU4vq7uTXUU3JLzevzAkrqHuT1FgKbZEeP9LEZUutXnEmFthx+5gxoxMkJ1NeHb6FLjCHp5M4222bA1vhs6OFW7yyyvTuavaGGuPTzdPHS96ZB6utqJ3C5CrZhdiNHegyeCFk2s3mktVXPGrjAWuG24/Llc6z0+QQwuUbLTyqFxd8pSc2H/cH2G8Xqi3OXjkvkq/QgXHougPimNoP30cSrBL9POjWceifWRWb+wcC7jn2F5gX5DswlfdL7RSTedr/kCH67T4LZB+sxtuEIKV0yffJJ6841DN10IzGSPmOdu9DxmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XTC4zEQ7vurYWE205AA8K7dmT3VTlQObZN9Q8F5bGk=;
 b=kFHJe4VmT8d5nzy1lO12eR4mpRq9Nh3tyXmKhNfdG9qkHmYZAFMY+iX2vp1xnwPxzXhnYpR615lqQxJHHsrlynpPP8g3Lq9cvzL8C9yNxfxT7l5AONrxApvYLRWw2msSuBNGT+UGN6ByKvjY45bcVTpjtJXJQtEXQU/mjLVFgxCsgUg2QYn2zDwc3vSvQYYaqYEsmrnPp0qOJB0tDsCgGK5ZmG8AFeqEIqkuGK5suftDdR80P6wsOYt4wip2bNojEqc+4rce3aeiWYtbJY7NpVd//HZQmD0AMMiJ/rxCtLrYPRz48dbvUzGYfpbkLeBW+HzzokQfx5mAHgJhd1O3gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XTC4zEQ7vurYWE205AA8K7dmT3VTlQObZN9Q8F5bGk=;
 b=JPuORPQKkiqCzvIuEF/mI9uxdeWqR0tydVwcpncz33VOBPWIDUh/mZ5KHFOoLGfuHzj1QIF4tZht5T7qxvo2oB71g/bCiWRYOQWOZRyIrlkqhQ6UjkIR14DtPX2jgvr/ATAYuBMgqWFDssMXTMkO0HjZBTQ0st5QRh5XKHJzImMsDg7CqfaJ8o7VzdKT2SoFewVoiOoDQ1IzLwXUNvhqZCAstnmeDmX21xC2Y2ny9d61MXWtM5VLTHmPOjTW4Y52NiH0d5RgxfYoCocdwP5jRF5bT0ZXGPV/jQCuscn1OLuWSWAt85o7S1cwO+kzTufm11mxbpstCa20mY+hHTru4w==
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by AS8PR08MB8350.eurprd08.prod.outlook.com
 (2603:10a6:20b:56c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Thu, 4 Apr
 2024 09:11:44 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::c946:79b5:94bf:e8c4]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::c946:79b5:94bf:e8c4%4]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 09:11:43 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com,
 jsnow@redhat.com, vsementsov@yandex-team.ru, kwolf@redhat.com,
 hreitz@redhat.com
Subject: [PATCH v5] blockcommit: Reopen base image as RO after abort
Date: Thu,  4 Apr 2024 11:11:36 +0200
Message-Id: <20240404091136.129811-1-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0140.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::24) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|AS8PR08MB8350:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NsD9Ka7uICVCMye484C1tsPOQKbelhaCVFeU4EmivLdOGUzlVPSb2w3kyTPQZc2n+y8mKa8GrA6DY/K7GSY0qX63ro/v08oBiCMN8NrQT/rXO9/+fOJ91TPoh30diCzS17YT4aK/VTU2VM1hqr7ZaCugMMk9HxgbKfn3+3ZqbTSMO1mwN0/3J05nDGBOeX8SIi+8/6EBQeEtiJghMo4eztkbAlgTFjK5YXxy0ty2oft0XyfXSFYHnSVq0sJs7JOZYCGnqWGIwHO86DNc3VR8nj+sxOrsGuKUmIk2rKvT+XScnTibDM3sNLQMSEL8wWg1qm29lS6s38VEcLOvfLTfdgWPgw0vv++DOt4oX9sLlJfLYknYRDv0EhjbT7KHnxsVHZAmyM2Oy7FTTp4TKM5p4ScqwClvNLJ08E2Loxc7vNaXbCfuozB61S1EByGz/02a6GQWwjpkDsZxedotY9S4U4yxoEhw4PdAuXpTl5Lv97z5A6jAhSxRRThsszaEuLQQd6K4Xn1xx7KMOM8IR7lLIkDDrC7jAA/oaPHiyvFusQ8Cg4+3xNwQ/hndgUAxogywV51twu4knbrDl+GPo/EBgKvJJlkb6YeOu2SYrCSl+SSqtTh+obEzpXD7+e8ko7MF9nHJ6Y1mWZsAwD9f4m58ewofJS5zwlCuM4Y8JUQJmN4jjgooQ4f7AT1jIugFcUHm+vo1/Yz2wN3BzuuRp4U/TcygoXj0N8H9LG+wZVmc0+Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(376005)(1800799015)(366007)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?twA1dPh7NeMqLK8EPnVwNKssjB6tFLWUGgqI7jQnsJ1E237pDTFcNISV7dLV?=
 =?us-ascii?Q?qUT6BqPVffilRwpVuHCRJ0bjNbwsoXpAnFBoUd41AllB8IHhr+EWEIscL4uu?=
 =?us-ascii?Q?KPu1uH2waBFeIm17QQTf0JnhJYB1SRkaC5B5/bHprpRMBRrTr5FTwvm3RIKJ?=
 =?us-ascii?Q?GizV8jVOEXYWcw26aaigAQt/0B5r87dYBGdTa4O+6An22UyOMyAfHLor9TOa?=
 =?us-ascii?Q?FKxvRoNwIHU59U7Bh34YBb/KFBJtGI7PlgTBl7pKoTW9JD5ZNvF+GMrDlf9i?=
 =?us-ascii?Q?UswbLezj+K9hpbFJKx0LLbNNVE/l55VOYjolTKk6KAfBW+fimUVH0hadlQvG?=
 =?us-ascii?Q?TfdVpP3+Vb3Iea/sCk1jiu37CCbycMV1sGNMQJHOcS2WuS4Y+TBUdZVJkraC?=
 =?us-ascii?Q?avMjxtRZsZLxKeATzuIpnOxqMoLZ+aldgPCgMG2xAfFwjgLnvyaU4OMKqQl7?=
 =?us-ascii?Q?X/EFPA8Dx3Cm3UNL+o8TvrflaEGmBdhW5l9QZJ2ud9gEHIVzD+FKJSXzkSgK?=
 =?us-ascii?Q?cT9AiMnp++LRhi5wiYvPhOkDVdnvH7w/LO/ScZpVmx5IIMllYkcy8yWiRUTS?=
 =?us-ascii?Q?QhQkopJxjWtwVglK6yEz6MWLEMnmBF4L75HEWVDauEOBT86UHCBJqvmsG403?=
 =?us-ascii?Q?68wQpM8fNnFQGGH8oP4BJDdhgozPGw7QFETl8ZSCpEkeGiSBCRssFeLWhaTx?=
 =?us-ascii?Q?eljUkt0ovqZZEJqUccBIJNta5eEVEQVqIq083of9tJcxCjwzU/eSwJs0VU3L?=
 =?us-ascii?Q?d5aSoSCZihPSk6bcqFnMO0wkw16v4R2DTG3BWmdzO2R4+PnItw+8YJAYVXI1?=
 =?us-ascii?Q?AxfBtLfToN4y59MImuGyzL0SBXKzsqUApUJcsPTn5WT7X8YbqzeNdJWL1dnE?=
 =?us-ascii?Q?Yd7XEBqGEOZzI3kkYRRUWdjrJvn69vjDVnp+ZFzjTYNLhNBd0tausKK/4JSV?=
 =?us-ascii?Q?F8v3exbxSDPpeIl8wv5HnUs8dmASKX8e+xMA7BCFmUG9lnMl3Wblk4NPiHQm?=
 =?us-ascii?Q?0ZhGArR7vyEco44iGkHYMQ9544R7wcb8R7zsDGZCOYQ62LBlNmmy28rLY/DI?=
 =?us-ascii?Q?9OBYLIKvDsb+eYmg4dFfyzWqfTY5HGSyEwnipGE0rfY/QnmnAgR9tnKzUt6S?=
 =?us-ascii?Q?eIdvHDXlZqlsVF8UOZuPZKYCmrdZzJhXOIrc7aSrh79/pvvE/MV28VhWpsrK?=
 =?us-ascii?Q?2zdTU+rziaHnXfODxR4rSEODTuFi/o1DeNkhI6RgsW0InRWqRcUTMLqLLjCM?=
 =?us-ascii?Q?L4AaucLZJd1cSdReQIdCakFSNE8NwkNL3HmqnotXV9PKBEsi4TqXUuykOuTw?=
 =?us-ascii?Q?uUutNutd7otA+POd3S/dK6WJPmlVvKTUikTpAGlkPA2PbmG3jRgd/kEJNWUg?=
 =?us-ascii?Q?3iU4u5ITEsniKpC7SBp2wIAtAOIZh5pZM+mM57SVtDdKOAMqBQv34XEoshRy?=
 =?us-ascii?Q?mcwR8anXElqbfExS15ecNhR4/YRU9ZE071BMjO2dyTrLzNEV4NQpQSTltNHL?=
 =?us-ascii?Q?Q8cOZL04/sd3wlVl+q6TOjSncyLbTkg+cX3NhiV4Wa9Qlppzx3aUYDPf+FJR?=
 =?us-ascii?Q?0KV+ruXOS4EbhxuqYyyazzCBRIYVKpPAA7ol42NDc3GIJQfb3xLzaMgVthcR?=
 =?us-ascii?Q?NLYX078XhVEhe5UKrFl+nsY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75277ace-64d5-4b7b-784e-08dc54873f25
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 09:11:43.8227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /AqEctI33fuzmpz7I9fOd7UxhfPhPX6P0l+j5P8/GqFPQUATdY+l94NcFpEnltBQE5HTPR61oZKoWvbWbFaCmTUMWC43tg58PvGZdyh3d2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8350
Received-SPF: pass client-ip=2a01:111:f400:fe0c::70f;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
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

If a blockcommit is aborted the base image remains in RW mode, that leads
to a fail of subsequent live migration.

How to reproduce:
  $ virsh snapshot-create-as vm snp1 --disk-only

  *** write something to the disk inside the guest ***

  $ virsh blockcommit vm vda --active --shallow && virsh blockjob vm vda --abort
  $ lsof /vzt/vm.qcow2
  COMMAND      PID USER   FD   TYPE DEVICE   SIZE/OFF NODE NAME
  qemu-syst 433203 root   45u   REG  253,0 1724776448  133 /vzt/vm.qcow2
  $ cat /proc/433203/fdinfo/45
  pos:    0
  flags:  02140002 <==== The last 2 means RW mode

If the base image is in RW mode at the end of blockcommit and was in RO
mode before blockcommit, reopen the base BDS in RO.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/mirror.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 1bdce3b657..61f0a717b7 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -93,6 +93,7 @@ typedef struct MirrorBlockJob {
     int64_t active_write_bytes_in_flight;
     bool prepared;
     bool in_drain;
+    bool base_ro;
 } MirrorBlockJob;
 
 typedef struct MirrorBDSOpaque {
@@ -794,6 +795,10 @@ static int mirror_exit_common(Job *job)
     bdrv_replace_node(mirror_top_bs, mirror_top_bs->backing->bs, &error_abort);
     bdrv_graph_wrunlock();
 
+    if (abort && s->base_ro && !bdrv_is_read_only(target_bs)) {
+        bdrv_reopen_set_read_only(target_bs, true, NULL);
+    }
+
     bdrv_drained_end(target_bs);
     bdrv_unref(target_bs);
 
@@ -1717,6 +1722,7 @@ static BlockJob *mirror_start_job(
                              bool is_none_mode, BlockDriverState *base,
                              bool auto_complete, const char *filter_node_name,
                              bool is_mirror, MirrorCopyMode copy_mode,
+                             bool base_ro,
                              Error **errp)
 {
     MirrorBlockJob *s;
@@ -1800,6 +1806,7 @@ static BlockJob *mirror_start_job(
     bdrv_unref(mirror_top_bs);
 
     s->mirror_top_bs = mirror_top_bs;
+    s->base_ro = base_ro;
 
     /* No resize for the target either; while the mirror is still running, a
      * consistent read isn't necessarily possible. We could possibly allow
@@ -2029,7 +2036,7 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
                      speed, granularity, buf_size, backing_mode, zero_target,
                      on_source_error, on_target_error, unmap, NULL, NULL,
                      &mirror_job_driver, is_none_mode, base, false,
-                     filter_node_name, true, copy_mode, errp);
+                     filter_node_name, true, copy_mode, false, errp);
 }
 
 BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
@@ -2058,7 +2065,7 @@ BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
                      on_error, on_error, true, cb, opaque,
                      &commit_active_job_driver, false, base, auto_complete,
                      filter_node_name, false, MIRROR_COPY_MODE_BACKGROUND,
-                     errp);
+                     base_read_only, errp);
     if (!job) {
         goto error_restore_flags;
     }
-- 
2.40.1


