Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8E2C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkGH-0006D7-9g; Mon, 11 Mar 2024 14:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkFA-0005ab-CB; Mon, 11 Mar 2024 14:19:27 -0400
Received: from mail-vi1eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2613::701]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkF0-0006sL-Nz; Mon, 11 Mar 2024 14:19:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HH/X8u0NbQZo69dcStYyUS8/Yro7i2XPOIZalIeOx2A1MF52ZcsRgFuJfar4y2VGssZ/eFT0g5uBU2pkX+4yyRPOwxqtdjCiMBMbRZkLGtbAnvLApPgUXQ5ctaD4JRlItcqLpUbIZz4h1DBT7fN36pnmIUM60y7zwlr0ucnHifW8ZCI1MiClbLu9k9vtYk7yfKAFuAbbpq4Sd6eVdYTgfOetvILHoUJkgPYtluUq8MEwFzeGNP1tjAph+BuL1+v5XaYOT7dA8b3GsO952W4dIWUNP4hCyi5+/XaskV56Lrr2COrRuiiItQZ5cRgPr/8lsb0g/Rd5hrg4pm+8/CvDGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5v3lk9kk3kz6DdNPd4PEnGQOTX7Wrrj6wO5h3hqQqvc=;
 b=IbDnrgsrrZ15/Du8itpL9ot756WDrB546ao+P2AlVK++9cIKfSls+UtIDgAWib4Iw/kRUla0obIYuIYJKsnY16on3dzhC+v5syJoFNOEW77Qilg6Zyl9QEIlZP5xEQIJhn2Lq2AGAByXJMLa/xvkz8sWFC8pAERamImaPwcSGFrCEIiXFIOpGj0srYuJFDOpabsRiWY9Rca+dkV/AaJWnAu0JAoccLu4P3/XDhofISA9SyepIsKiSsNuqVo1V8YbdkttbY6tNqxtCZ+WD6K183EW7t7mfBSp6e5tg4SJncdps6vmP47dK/ZHkvMlDDr92GPasjs4VF9aCqCuvFMEAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5v3lk9kk3kz6DdNPd4PEnGQOTX7Wrrj6wO5h3hqQqvc=;
 b=VHeSwO5e9ZdvPpNxfbC17YEiLx4Kbvf4rUoNn8wWHy8soLh3ifxdjpxIvDD8RAABoNQoK/dx50crITHEemrnN9yA1/WkdbzC/Y4m1q2ZQgKvPAw4avMph0EIm+6GMgcxfda5mO4n8+WLmHNz/uyPJmeitGO2Mk3j6WSKAJ7PaptNuIY5rKHmQcb2QhhBnUaXnIvAYX5FaDsW7KCzjZT0hlxibKmU0g2rdmxnV30HDX/TK23MNqPry0J7jk+lo7hfptTokcUG0kyXwrNaBaIHvQLHK+KAKGvNFCtYDxAv69cvgxXNmgCPeLGMFGKlAwPF3BSEUQp7pW7qdOEmnN9iHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com (2603:10a6:10:530::22)
 by DBAPR08MB5653.eurprd08.prod.outlook.com (2603:10a6:10:1a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 18:19:00 +0000
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde]) by DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde%3]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 18:19:00 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v5 05/22] parallels: Add parallels_mark_unused() helper
Date: Mon, 11 Mar 2024 19:18:33 +0100
Message-Id: <20240311181850.73013-6-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: bf3e09ce-d6e6-440f-517d-08dc41f7b9b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DFvfqNXbWwKWbQVwS0tWrD2M/gPEjBU83+6L0DqtU/U+OrCxIf5NBtNhcEPS3yEntGCbyUDqwiUmTMATY35y8IF3o6kv4SUa1a7kRz36sPxzuupx4U+yVrazOunkEhWI1ATB1E28f3Amc65a7xMd0grGfxEuPLyhc6pPICT1RVYsT0czMboAr+Bi29arndlLBIZ0tZjCozrfI1I8r6ZJbELkByi6XbE9GwYHMMGCmd92uItgzIWf0Qg09GI/bjkpgtoS9fMQsNQp6fAG4nS1V/daEK7fCuVq3Yu6i/NMunJZG07uatpP/d4RXzfgCXYjBgVNmVwnN2KRmZ08ugNGG4MImd/BFdRxQ+eC5M3mPj5aVsD/Tj7JF7/wO2abfU3Ff5h7kGlE+dHCP+ZutCCv/NeUUuBMFQNIckHViteWhePkz6RqlEmH4CQPnCOy5gJOjFhzcV7nKJcQ1haP6wIWzsgmodjKt7FYZELRKzEwYFAnwiffyopq9c94SOqYZNAdKH1xtQPLSW4k+EQIw4z41J7EwVgQz0083F28VXByGEGc1d+8JRraXfIYTAIjm0vRjyTX94+noj0Zi9TQu8viF82PXhDUzgdyPM01FPKS5Eb/8PabZ4Os2a2LKJgbnzAptIOZR9kxCmblsCO8/f4bMazA8cVMtyVLqqgyfE39pe5mVkoy56Mbizy8To95avItLvU1DUYCltiTWdM8AvYlYUmVmGzIIzD86tfXrAZSPaE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10721.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(376005)(1800799015)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gYjy4zQlQDJHtZgUg1HSH0bdg1dqBEIdhx/mhjvdbpavqFYpRgouVtGVOqBj?=
 =?us-ascii?Q?nVmU8K2jwn3LUfMgukaPXN6OhfazWiiLv82oGQCchL2bVGoXz0QFeOp7+AiG?=
 =?us-ascii?Q?fMbhr0ma4x8p27m6lZb0rwP2INcyNw+5L5D43NC4qWlIqSf8V2ofVsFrREod?=
 =?us-ascii?Q?QQFa3bSBCQqCslcpiiMBZtt3SQGLImkErcHrW/Dh9qdYoKhd6N5KWb9eQ1hb?=
 =?us-ascii?Q?w2zs2b0GtRaXUfAv7/TzjTTxgJSfJ7rRyS2b+b3IRMUkfxpuXOJ1LuL6l0fM?=
 =?us-ascii?Q?LgNrwaVOINlfZefyNmX/7uTbKIqFl7MT7UtlSntp88eLhkdNnMP5uXvVOXQS?=
 =?us-ascii?Q?ZQ8elCsE6XVwSd4LtoWbLqPmi8yV0pwUyfN1IxXpWiy1YNTlmjohqFLwwsdp?=
 =?us-ascii?Q?jQzG8t22HzagTKY2bfICjeteH6jAA49clX356irOKPotT1fyCPCTbQPIYMEC?=
 =?us-ascii?Q?TQpBiISn/tQc3asRpoGSfrPVvBoxPFl9tsjCUBLMqQ3EJW/OdW+JINE5snqe?=
 =?us-ascii?Q?8pfz3P7mwm7CgOuoatsKP04eShIXTrZtfN3yUPouJTc5G7v3VrBI18BUS9SO?=
 =?us-ascii?Q?PVNf9W4zwtjPDt//f92/V5INNfhfPbJVmDI6OSnj4Be34lCH4ajMcWTBA6Mz?=
 =?us-ascii?Q?e16t0UNOycy1NJWa3LNXZsM3gvsOcp2Az/89kxr2hS9eGS3zUaOJBQocNPz8?=
 =?us-ascii?Q?9Mw9DK8SnRNPaYCuRzLpr2GrR2iVESJID+X4/KMCU/+j0idAp0JaXyTIgC7D?=
 =?us-ascii?Q?FMit80Aija0tpC22c6iObVty1FIbOdZJ0Uhftw3nzXNNJ9lmrigytCZNZgR+?=
 =?us-ascii?Q?ZH936kjAeJOoQkiBQ0hWyOf7PvXoCNBT+nDUc0/QuzQFTb8+2Xh84I72QEh5?=
 =?us-ascii?Q?e129GhM5Zt+8M+9FX76/dXyfYukjHkg0BXydxRzppt1WBiZ3IO7E32E3beY1?=
 =?us-ascii?Q?UpOtu5qMqrkF/yBCL3NbIpnSNCGwWg1jnnNwKLBrYVOGXFUcidTjqGlFrqVq?=
 =?us-ascii?Q?jQrZhSZm5KGRW+eebMkU4cWpp0RwC6VAr5AanfXnKN3hs3equlOyhQgZSrrW?=
 =?us-ascii?Q?MIaQ9/8xBb+f8AG7io2SohE+a2SD3jtLq6ZIlggv53NSRMSTAl7QeGVgxV2i?=
 =?us-ascii?Q?9g1xkXpx+7SZS4HJlm2oVytSWmnrNZRJrh8TOFSrkKLoPpG+BqO0dpTRepdJ?=
 =?us-ascii?Q?iG0G2KNVJdIxSUxzNVPLrHgQAsGwjzCqFel5zplR8WBVllhyZR/HwmEMS2qV?=
 =?us-ascii?Q?c+L4bfhVwp/E4WwuOgHLK3P91kURntcGe2VGrHqii/y/biNcxBgAFfACLs8b?=
 =?us-ascii?Q?K4NaaL29HsFPT7OeOOYAgmOAaiV4nD/CNZWyFWyOlR9A8kG7RhBtihWpP57R?=
 =?us-ascii?Q?f7dOZQd+iN2Hk5ZJPyduSrbhO2pxP2xlLqdQLXZwD6mp94J11CwsgYMR6dgm?=
 =?us-ascii?Q?TNbZF3DKemyVdF0gAIbW7cTFjGg3mNoTzmmatckb7fgf++zDvO4wgdRlN9YT?=
 =?us-ascii?Q?l8by5dfNf9zejYw6CTbW/I/W96jGuAn6kyV75qKMU8TKsQjQTAXQ1MZCkP2L?=
 =?us-ascii?Q?ZRFHbFQ73jeZoNdxM5J8LtwedklouGITQXAoxhMAbOeRwB3exVm9eMYhmQCr?=
 =?us-ascii?Q?539oXXTWMBM6oY9nXft3TkY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3e09ce-d6e6-440f-517d-08dc41f7b9b1
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10721.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 18:19:00.8969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TSv5s4PHQ4Il+R9NHFBQtBDYVeR4P6d4vCURN3VqNVAYb+ATWt79rhLienqL834RS5MSrjnPrrBdXlDO+E1LpkgNRGssur+7kpmoYQ8t7s4=
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

Add a helper to set unused areas in the used bitmap.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 18 ++++++++++++++++++
 block/parallels.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index 4470519656..13726fb3d5 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -196,6 +196,24 @@ int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
     return 0;
 }
 
+int parallels_mark_unused(BlockDriverState *bs, unsigned long *bitmap,
+                          uint32_t bitmap_size, int64_t off, uint32_t count)
+{
+    BDRVParallelsState *s = bs->opaque;
+    uint32_t cluster_end, cluster_index = host_cluster_index(s, off);
+    unsigned long next_unused;
+    cluster_end = cluster_index + count;
+    if (cluster_end > bitmap_size) {
+        return -E2BIG;
+    }
+    next_unused = find_next_zero_bit(bitmap, cluster_end, cluster_index);
+    if (next_unused < cluster_end) {
+        return -EINVAL;
+    }
+    bitmap_clear(bitmap, cluster_index, count);
+    return 0;
+}
+
 /*
  * Collect used bitmap. The image can contain errors, we should fill the
  * bitmap anyway, as much as we can. This information will be used for
diff --git a/block/parallels.h b/block/parallels.h
index 68077416b1..02b857b4a4 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -92,6 +92,8 @@ typedef struct BDRVParallelsState {
 
 int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
                         uint32_t bitmap_size, int64_t off, uint32_t count);
+int parallels_mark_unused(BlockDriverState *bs, unsigned long *bitmap,
+                          uint32_t bitmap_size, int64_t off, uint32_t count);
 
 int GRAPH_RDLOCK
 parallels_read_format_extension(BlockDriverState *bs, int64_t ext_off,
-- 
2.40.1


