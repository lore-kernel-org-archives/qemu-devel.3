Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79562C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkGU-0006RI-EU; Mon, 11 Mar 2024 14:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkF0-0005Zx-Mk; Mon, 11 Mar 2024 14:19:23 -0400
Received: from mail-vi1eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2613::701]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkEy-0006si-3s; Mon, 11 Mar 2024 14:19:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gc73ew3GZeBj1A1L/j68ctdjgQxt/3xAgnktL3XZjWIidihrtxhWV9gFYfl7qbItCDR9nbGbG2Io5pCHTl/aVN7f4LWv56Weho6iTRuoLB4lJqUsULWLUuVhMrekb79yI+4Z3UhVkqOks1soSb1o6gtFvtkBAScZ5WzCbpLw6RgeWsUlRj3PWItsAr4jjXM3bTrWngC8uGAgpWQCXCiW53WD8xMfI17cm+KiPx44h3Bycq696HRd2W41ofJMULej+nhZIKYGRN1f1J/Wl7u/MvzvCgRcgQvXjSZ0uyUySRIgp/E0MHYwI/GZe0PhvW0IvsOp6wSTRILVe6ip/5SCgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9h5YCJsBUZfeFWhVhEVU0Ljc8FwvTfbdRMQWNZTLhw=;
 b=LCG+SZlE4MqiBP71GbQBdbTyWscYPh7L1aOIZXvMuMs8HIbLcv2nIgEz6poTlV7SQUwpCNehaHO+ErlqhGnXmW3PIlpNXr9HzVP2ebtglwm4P6m/VqSkp+hbHH4RLrcpR2HjXcJ7Tux39WKiiw10ASseWuFPTDZyXd+9OU9N3pTn7qUBAF3Kzgcc5TmvwvSzUw4h4o5pqULtbOXue0YGAq+dp2FmDC+DhgfuQDqQ/ZUb5+QQbbGOYxCSMCQxT6xKOpeS4OT4rwBzkrYLQJT9y33TfQRhzaSEUFWqF8y5YPjhsnMEZEH6es4hlmsdqDLXneXBIXXOlOMGBMzOIhC2QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9h5YCJsBUZfeFWhVhEVU0Ljc8FwvTfbdRMQWNZTLhw=;
 b=AKC47KHo9e9f/EDzRa4SxTdy2nXeKDvdfH1aGiNfvT2xAllf8f5MykKOLUn8zmQddff8pThpmClEcSPLynLQ/jY5pCEysgCPTzknR36MR0M9+DBir+hwejTtPa+QiIA8Yhi+7AMxVy/KPm1l7dwp4hIxbTtismmJISJfNe/nJrQNguvunXODAQ3TRBV5pzDiFqFfsQrxDOJEq1cxLAQqtu3tqgFQ5JJ3QHBWiekRJIHOye7aKWgoXPCG6PSgTX4ppi9sJmWkqFrzEo6J2w99SXTF0Xi/TYBRy+QvM/4k1LcvIqNUucHkGwAAU+0XLsmNqwXdQPtNZX3PaEoCvR8AAQ==
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
Subject: [PATCH v5 04/22] parallels: Limit search in parallels_mark_used to
 the last marked claster
Date: Mon, 11 Mar 2024 19:18:32 +0100
Message-Id: <20240311181850.73013-5-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: b37977ed-9fc7-412d-00a7-08dc41f7b94b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KJefuVJZCC05zcCBhLyCFyXzHUTOnKdVCgSqeKVgYkuTwag6JUDEAC5+McIU/7eVFZ73Gp3PXRw9PxMRg8rtuWZX0V123pN94un3gXbAs5N4Y8xqZdEseVBwnJzSV0drxidbJhTzJAF2edH122BrJS7nohQWoPfKTXiM5r0vgqhNxd6/Y+rUczrrfx2zYgS5+2op+tVARdeDZNy+iMAGmjOov8x/epKgDVz1Y+G5ihZTyB8Y0PONfnnw1XGurRpF6ybqNmGFWNJ2EBOUBOTH3Jeu0neSkWOIXyrpJaOZnzQqDRZ1FOHLD8wGFnwytPJeR5/PMF4JkBL5npFi57knylO+0lLA7zOU9dZqu566oiNgEgtsQKewMYPYrTgZoTHRuQUUN1IZCNUcqRLr4fOjtwozepaQ33Fsx/H/QqrjOKZXbHF7IV8ybIh8QxXiApATigaWrUFBtGywyNsJci3JinvXEPZRuHwoeAa/9v04VDB0GfOi5PJyNRKBndvriwMGuAqGpENGSZibz34u22lqCQ/IH9MPWejlYAn+efcJE5UiCd+Zv8fq9JwTBHfpVTWUZwVZIBY/a8jdo/V7s9qAgyyAtk2BTywy1GxMRzs7nyEtMpiAQiaR9YAiZa18VFvFU/STzjhV5oWtBoDm/JsaAEDt2nZE7+mt6CHjLnvjJtfEhJfUT7F/v2T7HAwN54AYJm/GXUif+gxYVBhncb3SrC+9UQ0PptkO9AROJhx+L5s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10721.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(376005)(1800799015)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0mwR+1CAi6g04TgGCdjiNBh1uTbOIkAoW9uLHvodZbfjye76otzzli9lOwJh?=
 =?us-ascii?Q?wB0aZQtZUJWFNoKgS6ztPC4vzCcQXxNL6+Fex+yOi5ANpHyqdbozNUTKI7Lf?=
 =?us-ascii?Q?8wSLHBtn/oZgsiXveHrTXxLaiRVPJNnVxUJ4BbutDvi4WzbeDtq5g1l63oaQ?=
 =?us-ascii?Q?1B6rCkBEccusoWQpJY2oc+c5VXE/C0ncgFxTs/lovkqIYsIjwaldkAF0abEP?=
 =?us-ascii?Q?hdqoYX2LqTEX+hVnOAv8p3VYTJ925zuaOsjEfCfekncpScA9PHLxiCBrcyk3?=
 =?us-ascii?Q?Oc+0N6VZV251WDpzQY0o9+WvpVGGUY//W0fn7MHLVlmElHE931xRA3gIlSMO?=
 =?us-ascii?Q?KcMcAldal9DbgY35IZNkQnWwzSTB2BIZnp0TaYEIi7oU07TGMmztGwID/oFI?=
 =?us-ascii?Q?SwU91swJYlb36ig/oAPGIYI9hO8hSZNm6r7UsKu0EnvYisGN9bO8DkUYCur6?=
 =?us-ascii?Q?3QX7TujTJuyur1QJqhMBQz2ce+bJK1OD+M0x+3kmojbT1j2AI8jGK2MlWfVc?=
 =?us-ascii?Q?qjp9bryC1JDPlH5DZgp87nGBSXIttn7zgMaXUrnM4k/mrGwJw2DRzXovRetP?=
 =?us-ascii?Q?Yi3o8aqp6b7gCFC2qy+cbw91HasNJiCYnJ2DmDr3laHoPdAIwkcQJXPAqW9B?=
 =?us-ascii?Q?2ywBELHc32W5kIAu/xx1r0mZbUJzaErlKUuhmwXVC/bhE/L5O0M4UwzgB1Os?=
 =?us-ascii?Q?wdkRU8qPSawUpcl3y52blV7FsJLUq+qv2djkPZXs/9UJnoS7pBdTNgWFcTS5?=
 =?us-ascii?Q?3FLhVrWYb1e7KMibU+APA+PckBgHf0QydBY2IHYBcmtY+cnmnkAQC3Fr6H7b?=
 =?us-ascii?Q?n5aLKlPIK4B0RaWbvsGrV4iKq6xV/Na09sMk/3vszctxRj0giVUMKHd3exaD?=
 =?us-ascii?Q?ZAdqSkSXRG6Zaji2fPXESpU7PTXNG8xY67PSPLDZVWq0JNIwodZ+KD3JAFJf?=
 =?us-ascii?Q?sSdEBYYKrxe4RH5vHIEYgAo5nDS3eQsF8pTaXRyGlT6Gke/kssslVQ49d+4j?=
 =?us-ascii?Q?qWSOlxgxbUpXPHbpTvpcngHiN8en/qjiheq0s8TKGjHBJP1oAG4md/T6xSHc?=
 =?us-ascii?Q?RiWn8tAHIL0jhxjSum/zenKBeOt3tPYs66kgqGMzFX3bkhKt7AXV1z+tn7lP?=
 =?us-ascii?Q?NoLB1Ba+S3Wobrj2iUKODakY0K4grd904tmsY/JxA51SZG5G23C3MbKCDEzr?=
 =?us-ascii?Q?uCiu2IfFD3uxp5bV5wSJJ3LF0ssDx/B1OsFUbmtTIxRLXF3QNrG+gzk2WOvQ?=
 =?us-ascii?Q?EWQsjMXQtVxU849ZyRWSnvDkEEwjbADUsBMOeZG4ylhxdCTzed8MacxEukAt?=
 =?us-ascii?Q?U5muspfpyb2DgDZ6G64OjCyjEv6mub3W9/AT97d4hoDwTNRKoYG0cm4JLAHZ?=
 =?us-ascii?Q?ZEJShuwOPtO+WQNJq6RcDnPzB0TYygkEbdwzvlshF0tBGi0+nSLp2qQSZWlI?=
 =?us-ascii?Q?qYPLy8jKnuwDFhWBJh6oOhjLnNeqtwocXPP/U1Umbbx/dUXZ7f2QONdPXCNr?=
 =?us-ascii?Q?7cuxFwQknCHFlppzj0ulGriK9O+EsgCUQwRmqiTKR/ywVFzIuyDJORcfn3tQ?=
 =?us-ascii?Q?aRIrLJo1U3rad7tEcIcSUhgUQLtQ0Ebt66uq9jXf4nO0BQCQ+Iz+MXFvkjmQ?=
 =?us-ascii?Q?kVEp8N8DlWAfmsraQIjVXAA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37977ed-9fc7-412d-00a7-08dc41f7b94b
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10721.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 18:19:00.2593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYrElvYMHn5KMEpTCpcJxTGz4dMrUhwIIh+WaR5Q3vn3GQrDCG8IryyiCmmg6Pa4eHSNSgPOHRyuUaSqRYIdXlqKABtUzXejxmhB3YbW08o=
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

There is no necessity to search to the end of the bitmap. Limit the search
area as cluster_index + count.

Add cluster_end variable to avoid its calculation in a few places.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index ae524f1820..4470519656 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -182,13 +182,14 @@ int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
                         uint32_t bitmap_size, int64_t off, uint32_t count)
 {
     BDRVParallelsState *s = bs->opaque;
-    uint32_t cluster_index = host_cluster_index(s, off);
+    uint32_t cluster_end, cluster_index = host_cluster_index(s, off);
     unsigned long next_used;
-    if (cluster_index + count > bitmap_size) {
+    cluster_end = cluster_index + count;
+    if (cluster_end > bitmap_size) {
         return -E2BIG;
     }
-    next_used = find_next_bit(bitmap, bitmap_size, cluster_index);
-    if (next_used < cluster_index + count) {
+    next_used = find_next_bit(bitmap, cluster_end, cluster_index);
+    if (next_used < cluster_end) {
         return -EBUSY;
     }
     bitmap_set(bitmap, cluster_index, count);
-- 
2.40.1


