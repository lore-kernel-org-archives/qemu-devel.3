Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7AE4CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN8e-0005L8-ED; Wed, 07 Oct 2026 04:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEI4V-0001BM-I5; Tue, 06 Oct 2026 23:11:59 -0400
Received: from mail-japaneastazon11022119.outbound.protection.outlook.com
 ([52.101.126.119] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEI4H-00083P-Bc; Tue, 06 Oct 2026 23:11:57 -0400
Received: from SI3PR02MB9388.apcprd02.prod.outlook.com (2603:1096:4:2a6::8) by
 KUZPR02MB9164.apcprd02.prod.outlook.com (2603:1096:d10:61::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Tue, 6 Oct 2026 20:56:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4R8xhkoVUpnXqWyptQb5rpDw3v4qJ8vXO6vQULbFmj3Ng4mbP6V3aWqd+jG34pkAa1J79lzVsqLUM9Td/98pcZQegBZFVFqnFQSATwvIMsE2Z8BEN+ceVixngo8azP4oc8ilH1GFhuYWIqSrkVa4SF0y3K04l82Bx1rgIDEKzs9mnVAJdDfEyvRfOTSCHSAgMn+5cPQAdekC0aIY46Oa95xVND49xyn4tqEjNT1i3+NJQHh9RDOd/v6LnVip4kGDJXS0ypjEw/Z29rXZrUTYS1Tp54meAMhJqu7kWSnJqsgtRCm+NjjmG4LSu/SIIiIjT+vYLj2mHbkfFY9T3gdWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CUaUBwmVUKXHQnSKhs8Nk9DOnPjSTwMODBEqGdD39o=;
 b=vW2tfJzwmewX3pECRY9+x1ZstjFcWLSWzGWjoXqBTjluZNhaYfJTuXzRqRRqwmvj5mKFQeV0kYi9QdOleqE7WR4yHCYmYU3rq5JJpBlnK7rbZWcZkLZ6SdO/P6cD1+tBbo04ATOJsW0K9FV/3MsmYejHjr7XyJGJduLnltLb9L0vEM5nZJGH9kP6YiE+5kBdc1+8rHz4rLui/DpA6NLd91gQMHKPVoZacnQeJzGwUdJSQFdyJSWlFSAP0Qk0GtR6SoMuKEpdwU5w35FymGXR7mjH9A3mJSVhimTO/nqj0w7b060uCPznnJX2Htwesgvq2mQKGH8qkMg3cqHMCo57Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CUaUBwmVUKXHQnSKhs8Nk9DOnPjSTwMODBEqGdD39o=;
 b=IkaaMBLUy0VFmR9V2AzYJAX0cK0nUBRVv+eKebwWaxse4M1mMEONLv5IxD40dnzlbiJO1dfoMiVkE5j0T1kPjeymBqKCSa2ZczH97X5c7UmR8JElRfy5xYos0sqiiOuaSeLijZlvLHrjHXPMhgxjqLbGdIXbWdekXL6tKILtQtftwHl7cHhNFfUY6U3fXWepdW9M+QTMAJErqthztUpk3ps8wZvbn8daqdKsUhC+rt/Ik6dOTuPSU7cr5SpHq+yob/N1amm9ET8EG+TmlWqVs+Knz+Ih7PU4QpjpTZybp84jMlxhEiiK+m7gcgUUOrvG1NO4GNpXXRte9YQRwPHRyw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by SI3PR02MB9388.apcprd02.prod.outlook.com (2603:1096:4:2a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 09:50:13 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 09:50:13 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH 03/17] target/ppc: Correct the e500mc and e5500 cache block
 size fields
Date: Tue,  6 Oct 2026 17:48:58 +0800
Message-ID: <20261006094921.110871-4-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006094921.110871-1-bin.meng@processmission.com>
References: <20261006094921.110871-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0136.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::6) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|SI3PR02MB9388:EE_|KUZPR02MB9164:EE_
X-MS-Office365-Filtering-Correlation-Id: d4547a3f-ad86-4677-ff72-08df238f37b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: nMplTiISE5AojGpOcuKy5j9q+7iEyoMgmOaYMeMlIAicxxHgG43Wgs99GVjz+LBZ+5HlkPIC9DE35paMa3RBvb/It4sGGozfoqNijz6ajQbyGF/Op7pmXbxvN1miLLw4vS0ubm4SVrhxKJdno6N5hOcOOC2eEmi58FUocZKqyJb+vFyUReIrEERFTunu+0PSCuT1tZdp7MVgNRHbKoiwF7v748t1WKoagivobGCbxzjL1vN5qq1HpMS7i2aY/J/2xMi7N89umb3EOkQx6rKuSbbfd89QcriBPzu8Z1VMlr0y5Itf1llMf3abDEcOpKjjTnNonz0fbPjC+wzQbkxRMO/yGB6A+6+ypiSgAi+pl/Fv07l7HExDLhfxWS3e0rgSDpG3Kjomk3mNpfuodgpTL/qwxWPn2LhhH91W1cU0opz3upA9J7YHA+YxijYnOpIkMI4gKTkPp1o9EKR77TXSvXkzTdi1vZllUYvesvZn5wKFqapFQcNkOi3YihwdVTdPhQDklshmFEaaupnXXgHIwm4pRmQiBAt3E0/PvJgm+CE8vR6oGyZWLY09gsgRLcKHc0RxhGl2XgS/hHiaI7kc0l2EbwyfFOE65cM3BTTzRsJKHJrrB0FU7EbgeB+XRyZvchzvbaYkCtEc0mi4rrVID2TAczNHNmTfDMnavGNE9GE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RDL9BwIyIpJ/pt3hti0yBKCjdfUc0ftby593EMtbMCcVf+KhBDIntiZ5roAz?=
 =?us-ascii?Q?Hq6SF4DGUvLCv6i65TcZ0K+sXQJmH1dw2UkvklniK1E/oYXWrCkfJ0+KkF+U?=
 =?us-ascii?Q?blC6wl0zftB8YycQpw7Wffe3u/i519c0U3WD7jV9HAbvtNX9PqLj6eM0Y4CM?=
 =?us-ascii?Q?wT9Ln14ZJ/JgG8NHOCuHUjFlJtuuhqengNnp5yiK6XhMd9KyLx6YSLTxyLxU?=
 =?us-ascii?Q?IDKqjHS87uVDC3ZZQ7Bn+C7uIN4Xg2oQnAZgq+ADeANdc4ami5KQh0GOd4/9?=
 =?us-ascii?Q?PON0XhmGJouEmqV7Et1ZilJ2LxLuVudIhNemOxM+GLnZhQh+D99ck2NqbF7j?=
 =?us-ascii?Q?am4BPu8J8j60XOBUnHnvdgq/bO2t6ZMHd8C0j9bJ+gzmC+GbKQYAWF4VVski?=
 =?us-ascii?Q?pJX/Vsh+ZobVyLUPmDX9vlTanSLxKvJokb5JDkE1rxf3Ga2Q8BirLJN3qPoz?=
 =?us-ascii?Q?mO8oXyK0x38BcJbdu8vWyDaUC2/rbIuZmWNERiTYWT3JO94uXRFfUszgVGNP?=
 =?us-ascii?Q?rU1v7S0HkISAVtiG4vjQEXRWX8oAJzBMtoG1sfhiD9Uxzh8Nzee4/ZPAbNrA?=
 =?us-ascii?Q?njMjeSeFo/VR1Sa5KFi0F3gPdu2N+fJeTPAtGm0nMohOh4OxlErAJLKMVpxh?=
 =?us-ascii?Q?5fZyU0b1MrTK3md1m/UV++9fnoQQfngCQpvFhcmkt99OVi49taCXO//Uq1bY?=
 =?us-ascii?Q?qm0FTLvu3K4v2NHO7HvLx3aV+h/RI/9SkeEpyT1D3Ylh1vaO2MlP+4A4GyB7?=
 =?us-ascii?Q?5mzoIOvIV7QzZ9s8EPBSbr+cCq7/+K/S1LNwcbuhRr4TvJv0pQ/Yq32YJivf?=
 =?us-ascii?Q?JuCaY8D4v2BVFYRDCYGxDVpgdVBcbjcKKYJnLaLBerDfdI8JWqkCHfeYJryf?=
 =?us-ascii?Q?O4virBWegGOIHS94rvRldnUxPAsAr7d/vZUXMBARdpOuYlZr16czxS4HwJqN?=
 =?us-ascii?Q?mPcnWrtmT9Fl5V5+Yo4QXRbrTGCmPDoiH/5hKn/WHSn8UchuNXn5vt9K2sCH?=
 =?us-ascii?Q?hKqVt7sg2MQp6ACq5jFnAqTZvRWUQJ0QteTPlRfJp+/7lskSmsBm8AAPzyZx?=
 =?us-ascii?Q?iONbd86q4WKMKAJyuRusj7y7JyrJfNFQWYBmZmxhYmgMQNLr3WHVwakNY3yr?=
 =?us-ascii?Q?/ZcLe8DZu+nKqPWVub6Dlkwi6hy+MMWJZr1SK20/3eodyXsB2FrYqKJ4SDvq?=
 =?us-ascii?Q?u2U2cgdLIT0UcvC86GXVjVemMsxP3P/kAsZMiD6/o1fYFU24HX3quZx35k4P?=
 =?us-ascii?Q?nHIzzf9pSjwvr/ZprxwqA99P45WOkrUga3TNX2/BgLF50Yze+ST8vca+vRre?=
 =?us-ascii?Q?9xmaUsfyEHVxOsId2adnssUbWxK201RSyISqNhFF+PAkDT/nJ7YyUrNODyJU?=
 =?us-ascii?Q?D5+iF+VCTKcHiG+heKJXuUcojYSPOpMJZ5VLF9ST8sgDI/7RAFxENwSoU1MY?=
 =?us-ascii?Q?r7ocuG6MLexcYQMk8BDcKSnu8UB33uK5H6gkEx7/SRm3AWSLbLuuVWVRtPEa?=
 =?us-ascii?Q?TEKFa/yhPSkV353PGS9iRS0OIDgXLYGuYsJhflFQVguh1BowqeggAxuBUNqJ?=
 =?us-ascii?Q?uIdRcfrz8FJwdnziy4L5U9XYO4NJmXC8efpXbDNuVUFoqXMdzsaiNjXlAmdw?=
 =?us-ascii?Q?DU5hb55zSAoxILyTONXzEcZVj0mkhgQmvAy6N5YmAms6+JzvZh45cs4CfOr5?=
 =?us-ascii?Q?JVX+QjYu70rSTxccvVL0q4Qi7/aWm1V/iUJMUWQwHkpe2HpFgJsaVHlycfvd?=
 =?us-ascii?Q?zZMoufeUNMdTXK/mb+8k1Z6Hwt+ild0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4547a3f-ad86-4677-ff72-08df238f37b6
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:50:13.2614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0mdg2vd95duKMg1Gu3Ks1BDQgx5AZ+EWN0LY0gsIQJ2zw/VwO9FQ7N+doQmrnmWHOYDx/dqi1WZj7qNX/IF8pq1HIAYhdcF6rdk2D2IW3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR02MB9388
X-OriginatorOrg: processmission.com
Received-SPF: pass client-ip=52.101.126.119;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

The L1 configuration registers encode a 64-byte cache block with
CBSIZE=1. The models instead set CBSIZE=2, advertising 128 bytes
despite using 64 bytes for cache operations.

Use the correct field value for both caches.

Reference:
- E500MCRM (Rev.3), sections 2.14.4 and 2.14.5
  https://www.nxp.com/docs/en/reference-manual/E500MCRM.pdf
- E5500RM (Rev.4), sections 2.14.4 and 2.14.5
  https://www.nxp.com/webapp/Download?colCode=E5500RM

Fixes: a496e8eeba51 ("PPC: E500: Populate L1CFG0 SPR")
Fixes: d2ea2bf740c5 ("PPC: Add L1CFG1 SPR emulation")
Cc: qemu-stable@nongnu.org
Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 target/ppc/cpu_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 96bae6a6d1..db807f64c2 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2886,8 +2886,8 @@ static void init_proc_e500(CPUPPCState *env, int version)
     case fsl_e5500:
         env->dcache_line_size = 64;
         env->icache_line_size = 64;
-        l1cfg0 |= 0x1000000; /* 64 byte cache block size */
-        l1cfg1 |= 0x1000000; /* 64 byte cache block size */
+        l1cfg0 |= 0x00800000; /* 64 byte cache block size */
+        l1cfg1 |= 0x00800000; /* 64 byte cache block size */
         break;
     case fsl_e6500:
         env->dcache_line_size = 32;
-- 
2.53.0


