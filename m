Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA49C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkG2-00064E-EO; Mon, 11 Mar 2024 14:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkEw-0005Yw-Ew; Mon, 11 Mar 2024 14:19:12 -0400
Received: from mail-vi1eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2613::701]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkEu-0006si-NC; Mon, 11 Mar 2024 14:19:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrXzuJpEl5WkiMca3CjjjsF8xJlxQFUmP9zlkQ5RUWi7XY1lnoJ0H3/I9aFsOwS60NlzO8898zc5iyqRG+wZOIJBEKsiRnWA1Mvc3ylv7aDYDppphgxoprgSKor9eiwX6Rrt6AinyILO8NY2LR8dgX0RwtuK3ZWAXGKInqFFSwQ5sf/m/LEdRY6xiX1LL4qo2HGVNNebQTITWaDTH+2Ex890UnqPuMJy7whnAa0q28m1klBijJDCGHMB8wISWCih6DdCH00BGpoy2OlussXlHFfdIgjmH2Y0oS9YgGK17lTWYJHIhuyWXW9mb3sctJrAOnTZ1v7Ig6Cm74nPlyZyVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKJH/SnE1VYd6dB1J/HgjlmdPDZivDxE/8D7NJc2Hfw=;
 b=PE+s/UvVoXgRoWQSU+UXOygYLjie20TAVi33eyuTTDAPxHa75MRpto7kjze5oB/qoneX9ttm9olWQcydZztQx9nB4cg4aN1BCyY0X76UX40LXEz+hcxqTs2xYijYAwHP/tztge4XnrqP9t3fw4drNfaRPwtY8aZWE+jUo/a7Gzm3Qc8laEMuNx3Bhvy3nmljerESgutVVdVCqQUN4plOCDoHs76y3uuGak8mRpsb6TcE52eWoT0WflKbUNI2lccRZLnudW8L7lQyQD8nJJSza4UDYriHkOBxA7fhf1koD4bBeRXMsRrOX+8ZmpOQJDHZsqhFNrvf7hIJoBsv6+FIdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKJH/SnE1VYd6dB1J/HgjlmdPDZivDxE/8D7NJc2Hfw=;
 b=E0JzcLDP4ufycfUvCNBltCpG0JvmJ/PJBpN50YWJUnYiRT9fGkMsNCZbOj+w7sp+2BiGVKxpPKGNXV1fLQwmeqWiNCgdPUg5sDhHIbVxBgXhbYX8xa7B4rTLefvCRQOQmRg5i/z1RuN9Qbxfo/DVENkPKtS2kZRdyXq8rN88ZME8I/VVzjgrmQP12qV9br/X7HJgCV533aAWNSvSTvCUO4/y1vvzrDQRhgyPdUC8+C1GXubJfs3o3q9x16OBhmxD564Xo19/Xw4m11PB1chDQqu7ZUTHFPrykrFy7GqlA1Gx3C9Pn4Gm7N4sDWynXteIy5By8CPE2QAjG33nTI1n/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com (2603:10a6:10:530::22)
 by DBAPR08MB5653.eurprd08.prod.outlook.com (2603:10a6:10:1a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 18:18:58 +0000
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde]) by DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde%3]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 18:18:58 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v5 01/22] parallels: Set s->used_bmap to NULL in
 parallels_free_used_bitmap()
Date: Mon, 11 Mar 2024 19:18:29 +0100
Message-Id: <20240311181850.73013-2-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: cebdef90-0d91-468b-ffb6-08dc41f7b7e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UaYdUNJ+9r+gvf+fRpJeRKIPbtX2+zdOYLeMVZw/opLXWeQBWb80fOWjkgetVn+WUt7yT1l6RcyV+1bOsI9EG3E+MC4XlOcCryLRB5MnWuIfUJrOOsBGJwPncd9o/EtwH2jFmF3G/U3v50vNv/GVMO4WD6o+6iHZv01sDSXXN16Snfb2sBP6MbDwYxf9un7iCPbJj4INQWJc4fJwZ9A4YloCQiSeA5ucxGnTp/EwfSjjSnsCByTc/LBZxXLIATkIH5eaMU1rmLNgCEfyQaqaC7mbAv1Kls0kCus1/vJy2o4aoUc0P/qBC7S3p05boNTR4Z9RGFx894XreRNbcGIl4RMDpbAQrEnkf4lnbHWJ4qTUws9l23CQMY+Y5nAIrkkV/30ZO7+7BJ/Q6QwxJw5v0troH/DFvi7EYaLcgbmVqyLemi3E8yIhKDE6EqedqdGkBfdF0qjOHszXl5+xkYUrq/rCutZ9F2X6RhaWgNJvxp/3s0xSoN5YsjtwpdwXOys0F5bsElf5sYhVRyDSiPPfIORVd/EfmAbJPJysIpAh+AWVa6zIl1dD2SgdRFCeCcXke6US7OT04QdRPbCgt4LEKVCAKcNyJuPl3GcUHYC2CCzr8W7NzdtVl2ryLO6+AIo2a2GQ8FpuaZsQrJevPir7PSE1f20/TOZhcuUUUbHxq2vw1/r7cIpz/6XGMFkTNLEZguezvGgbIQT1OpLz7vE2ZXWG4CD6GszTMyhxwJlKLKI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10721.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(376005)(1800799015)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5MY36428H+pYy78djzHiiUUVjvImG7/7LZ9rDFjhfDHeT4BIovGpoZ2MC3O0?=
 =?us-ascii?Q?HubwNJEs6BgjoqyIrFPlJelG3IbcPU/bSLgTN1FVVNQx6DS25pT85XtWCfTc?=
 =?us-ascii?Q?3H2HMHAeKy9LwECTUPqL7/Fham4BszZmarTa70CEGvGLa5m6LgqXmwjt3qqe?=
 =?us-ascii?Q?JRGbx4DazZRdNDzwDhw6MBaj9ihSTK9w5gcsJvjYMNFGzDVpvCUG77vtrghm?=
 =?us-ascii?Q?uHFEKVg543zZDDv9NPSIB/mPpO5ETQfHmKNamtSqaxzY9N2qCyb8iK38/kMh?=
 =?us-ascii?Q?ffN9h/7AXFP8JFkTTkZF8vBQPkjhTWmvzZobkq277E+mcfvwz72D1k/BvRb3?=
 =?us-ascii?Q?bzOAlU5uUVUodYkDWOToqw+Pnhg1H9DD5mvHMTa3XIN/cLLGADCbhU8ygCgn?=
 =?us-ascii?Q?orM8iJ1Wt69oB7orNcAH6b3B6RMBQ5Lr05uVUs+bLQB/qLpzG+AK9gXiZbIz?=
 =?us-ascii?Q?R0iiZvhqMyYRAQ5w9JBQ0P+Zudr36WQHVkhJhx3KsJxZ7vS0KmQNfrDawAJb?=
 =?us-ascii?Q?64tLdcjCPhHR5z8aLOp3vTzWRJWUBxxRgmBS9NU0+dXn3I+dbHFK/yD/Tprk?=
 =?us-ascii?Q?lHj0rXYWffvIizS3eMo7IVXGpEFnZnNfN80BMDG8rSVi5UwdBV6i75vOjcoJ?=
 =?us-ascii?Q?hHza9/zaoWMRKXiHniRyPGwcWni/q1fslcqs1IWCqgZb/ODwwHhYFN0vHczV?=
 =?us-ascii?Q?XqfmFQwT+4mZ7y7x72cMQk7e+7bZC3IXDEucWTj4aS5b/qDmnQG84BZbyM13?=
 =?us-ascii?Q?vOfzMNmEE6fq8/Tta36fgitAi3+oivGIYXPISYeLjCCMXcVYYjWgzrPQbF6v?=
 =?us-ascii?Q?VXw0vWkkZjFmHY1IZ1BOe2ORnhriEZeOqZ6ARLnTced+3Pkziu9+0KZEsJIG?=
 =?us-ascii?Q?eDhcT9rcNaqetKvawCCw2uWbiy5KNN93H7pRH8vXjjs//MGLtKYU3hE72hWJ?=
 =?us-ascii?Q?XiwBWJamozO5JnNhZ7hdZQ3pa6EkhwTalG4L+cZLl3r2YuIc09+Quf+AAk4s?=
 =?us-ascii?Q?azndX9YprW0MlnPpkJg6sAvkpmVUcb28DIxxkZWeGPGVOOz9zs+3JhN0wpgV?=
 =?us-ascii?Q?J9zp7BfebYgq6RK7r9BXSf14UmSTTqnWZS6m3Cak59b5/rjeIDK6+XcLpI7k?=
 =?us-ascii?Q?++xA3cM4RL6xZ+YXm1UXK/TBy0QPggN7sQQsgHNHyDjBQAn/TaYOA1rwlwMA?=
 =?us-ascii?Q?0iAe1zUaAWYEZ6jQUCUDYS3M4TcbG1TCKiYWCibf0e8vw2YIby7cLqgwb+H/?=
 =?us-ascii?Q?hLA/k9BS5FmwA+5nn/SGKVKk/jhxW3TMaIDXdmWtcLSWzvMYGdnHmoiikKew?=
 =?us-ascii?Q?xykijpFBF7IwNvE1cG+70bh1KBQD+VOFxMuX1syPJxuVzSCMxPDqazigJ1bA?=
 =?us-ascii?Q?SmLjId994Qiizu5SFQnEg1EmrLpXuA5hqToD+wbTPA33rCSLFczq6YOMNPb9?=
 =?us-ascii?Q?Gd1+E4iL86fW0lh0H6b16iC60BV9oeHPhJ+CmQGCWUvkiEltVQINeiIuZ6NH?=
 =?us-ascii?Q?2fPtacf97u9VqBboSFn7DlN5CYzcq3x6VMxAwChxRI0R8CVeBolOX1/ahXQG?=
 =?us-ascii?Q?VPqdIfu5hsbmLEmB5l+9ATWoyS8jIRjeZYrusxjBjbBldOvjMuhyKNKA3CUE?=
 =?us-ascii?Q?66vG272NNWQkEcvPjfjjXvg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cebdef90-0d91-468b-ffb6-08dc41f7b7e3
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10721.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 18:18:58.0327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7qoTao8VeZRcmQTVs9r884ehixDWIYW+uHMGluTXBNSAfm6p6pxY2SJdvOm/v64d7gcdRzIvsEKzM4cVQrI40hkUiWd99jjtAuvP9C5jlM=
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

After used bitmap freeng s->used_bmap points to the freed memory. If we try
to free used bitmap one more time it leads to double free error.

Set s->used_bmap to NULL to exclude double free error.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/parallels.c b/block/parallels.c
index 9205a0864f..072b1efd78 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -245,6 +245,7 @@ static void parallels_free_used_bitmap(BlockDriverState *bs)
     BDRVParallelsState *s = bs->opaque;
     s->used_bmap_size = 0;
     g_free(s->used_bmap);
+    s->used_bmap = NULL;
 }
 
 static int64_t coroutine_fn GRAPH_RDLOCK
-- 
2.40.1


