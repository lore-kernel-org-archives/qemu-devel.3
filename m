Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2774ECA600A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN7K-00041R-SO; Wed, 07 Oct 2026 04:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEI4V-0001BP-Ki; Tue, 06 Oct 2026 23:11:59 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEI4H-0008Ps-B0; Tue, 06 Oct 2026 23:11:56 -0400
Received: from SI3PR02MB9388.apcprd02.prod.outlook.com (2603:1096:4:2a6::8) by
 KUZPR02MB9164.apcprd02.prod.outlook.com (2603:1096:d10:61::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Tue, 6 Oct 2026 20:56:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uaer+SkL094bs+Z09z9H4OT4rKWO6TxiAthhvBbydTxIFHKoBx67dGB5OP/jWztf02FhQzF3su0oHf/9fQhkqv1i0A5ckThJeSh4l04r+C78Dg8hocctPNZL8bc0eo9kuSV+yM3I5ftAj1aGbPmqqvE/8OPo7b84kbh4CTTSvsnC2pTe5PAUNWeIOAQNQZrwVjK6HdS5uYAUKPhrEO3ilTRGs/XmwdkG/4owx4TDkXalx1gE//sLRCzUWUn5wxbg0u8Ihqqy2Z42NnBGHzA8WVUo291b4sfxxdM3IEWeQiAoM6L1DRxRUtb7QmxZX4oZFNBlNEsOQyAsuTHy1v7yRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHSjh9Q0SqqNOORWC5+xT03sPzPS7XlvavFR2Eua0g0=;
 b=YabiuzWiS90XSg490QefWMjNHAuzhy5tjI5fhBBKR4NGU7yuIY8QrDkGIQZpgjA0CCtOsFn4Vrh+PGfvUvWLevP6HQc13ETvJL2CJld25+jVxmG4H50FbATvoco483bDik0I131lC0oUK20KDlBZoWFv4DG3KJMtj7tMF3r5GjhNm7u0DvudeBkOxc+wSj7SL0W9CF+datjHRUISIrTKYFFFfXtMba+jN7Ek/eyqztd8maPJ6mUx36IF/AigUgwNZKPUNMF2ijRVIqRgZEtzNrtcjzG08DCMNXOhTaLOLPYH8R2N2Mw5/8xuKxmbAzpLIiJKlYxrWv88X8tRo3qvXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHSjh9Q0SqqNOORWC5+xT03sPzPS7XlvavFR2Eua0g0=;
 b=ntnfG4LOVj7xwNJWgOZEYJ//Ck156JQoXdQAHeElTk8PDvbBXNedkduEO9wd9O5OE1kUz/m76IUZJybVPRyvI1Cv7oUKYnHyoz8+4t96HKpORlroTrEpZCWN4BzMoN764H+Y333fyIpYfxfayhu6EMYmTk6LvQRImQNGD3kbSDYfjOZ58AyAT07BJ090k44fbBYI0F3zi1eBHYrYD5aPSejYVx5Ggi2AQdgT/fyKtwNHJ1q07a7cFfQ1IWLC+CxJf8tHlK7bhxkKyhV3wpIvccuG57ieyQ95Jn9S2DnqNbarXyW6BgZt+wZJ1ajqdfdd1flQ4xTsOMyM9TgjLRrcXw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by SI3PR02MB9388.apcprd02.prod.outlook.com (2603:1096:4:2a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 09:50:16 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 09:50:16 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH 04/17] target/ppc: Correct cache line size for e6500
Date: Tue,  6 Oct 2026 17:48:59 +0800
Message-ID: <20261006094921.110871-5-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4ba4bc2d-b030-49ec-affa-08df238f3975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|6133799003|10067099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: 7aarpWQHGBhdB8IffypjyqEq7xlI+qQeLRd3g3QYd+KIid1E1ewQBGhCkT9uyET0c1OOMCOP9JhMLZHT3amLD8NRCJrQDcGWulArTZsyKyLEZI4V9M7CU2MtLARrAVPOjK5H1b78CHXsJzJOzhNvEQME9jo1kXZbiRrLl0ZnxuT2pbiC4Zo+qOHbvqxpjqhVnb9Ic99sOh9eouK6DSa9VDP00aSGa/ThJ2xJYjF7bDxz/V9F8DlOw4J1aTURkn5zzPLa5UkqZV+PHJCGphCZHUSkKeXa6C/5sC/JT3xVuUP0AIuVN4iWhkmX61i6Q44kcUbSlctkHO1u3kuTY7ysNEpvb/usMuv/t+jdAJxFEEp6PvFYysDxEX9LHH4UXRyGdXyuhFpCs3Va7u7/QDXWtDUWuVZEbxPic4nhRwBVapBTNISKUEe5VU2Y/I18cMqNhttP++G2QE3fmlyXTkBqFj35Dj3A8z0NKE8meOmcY+oUyHPo2+eYHxzxx3m6wliAz+fZpbfJ1gnJpqS3vVsqfZx8rH8U8vLx6tzIRG6ZUwTvsDlzPBaYgaUueqp4YeKDvmIQmZTThmhF4mH2FF32p2Y9hdXxIcA4OCqfGcJSzrQox5yqDoJ/mDOdBhKVc6/MO8q4vf+jQmdVGKwDtVQAW3+bQkQo8exEF/j9omZwC74=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sapiOyj+eQN8MTCzJ5iRYKeMqhWsH7MOMh+SEvrC/+p0UELPEiZiRS1FRO9D?=
 =?us-ascii?Q?u2/zF5L+aUoKAclBMGRGWqQiAK+NAP0peI2CfDHAD+RvXv6ow/ewLpZSiqYd?=
 =?us-ascii?Q?i/MECuCHnhxeugsZHsb8HtxZqLmPk4zgi2pHvjP+D9qHMaA3z426biDWBfiA?=
 =?us-ascii?Q?y3h97FJyf8Jso9+eKjTVPLVcB/hCkrJSCvFSHwHbidzgqm9EA7u4myob11l7?=
 =?us-ascii?Q?swqscJsNcWK9cK4JSb0SrmTYyhb9yDC6jGkmzWa+oBHWqp3k+mSftQIemjVj?=
 =?us-ascii?Q?dWnpYXaAK2UrSlH2ydCoPZfGexdm+/xgacan47xmiOawqIvw8nkVa+QdFeSJ?=
 =?us-ascii?Q?RPzTBzlnApzosC9vq0ik4LTFq1UAhrS6SbfQTZwVMnGn/UB5nbTBD20URgGi?=
 =?us-ascii?Q?sC5r2N8dILejR1HZb1lKywM24HBGAAs46Mfuywf8HtI54CUN2KPr+0ZQx05f?=
 =?us-ascii?Q?wMInzXyTavrtEwm2XgvJITPXIzFPuerP8qdlTgnLjL9KuYxmmWRXFMqkrcJP?=
 =?us-ascii?Q?2gvZ8WNLrb6akgjxdi8GL2FZZSK8rr9C9mCBm9ohN1Mn2zMvYxIrwnae5aMe?=
 =?us-ascii?Q?F+0UWQScZHdl7q7Yo6CIP6VTF3JskC3yE0gHjaFnwXyYbejd7DF1jjS1Xcsz?=
 =?us-ascii?Q?NYbm3BRZQKPGJOrP6gtp4Qt6CPhDHremFeLs+m+XX9KyPml9VI1FDPbawkbg?=
 =?us-ascii?Q?6SxrKKtBU4C1y2tMSwviexPudcr1ytUoMYjt/kq3GB8g5y8XTYRa3RUDuN1e?=
 =?us-ascii?Q?0aRGYqJNyFrqqz89dH4taWdRymS0SEdNsBi0qy4Zpqi7USyCHkouZ3Wa3/2U?=
 =?us-ascii?Q?qALI54nGNx8jHjjWEnyvvWYuxdK98w3pcIaR2KbmndrlkE9ThYRVXEvMoDok?=
 =?us-ascii?Q?5hzI8Xh4lkWK2BVtsTTNxhJUO2KT8XfEnDzkxT08PYwawicuhj999/Cc9u4U?=
 =?us-ascii?Q?x/4rj3+uu3hf8S5vmfVw468LTuuSqqwUW055U0IMFI3Sc/Y3tBC966Mk1HZt?=
 =?us-ascii?Q?ZvU0QC41K76e/R/5Vl37RNv55Ud6wQkXnP2LBrR1PxSA2EWXj6Ehx7jYX/bQ?=
 =?us-ascii?Q?dNgG84jCd4nky9n4mS4ZYlu6K2lLHLXQLUVZ3iBGbO0br4eX4Qg4swH/E0WD?=
 =?us-ascii?Q?bSRgsqm3CgH+BcS6LVHcZoarMnVywRgyqouXNYuiHXHx6HMIrWxt9r44AQ1O?=
 =?us-ascii?Q?tz7kOKTMIjpaLMa7WQILpu9rcKRkm8O4ZZcZ3+0GRungHrsFSiGJyuughCyl?=
 =?us-ascii?Q?/EFrQbh+t7sqiAMZ+4/FU5ksvRvZRoh1ZdDlD2FRGPkDU2/LkfTw8ZBq9OEW?=
 =?us-ascii?Q?VLaNqIBk+Iw3jJiKnoONRu3qtcGM9xdwr+y143hr86elY8Q/WbUlSXmVxXQK?=
 =?us-ascii?Q?imhsd1De4m03LMhHUBOip7iD86BAf9/YlIKdOdsE3I5r2hBXpyqL/17DhRSL?=
 =?us-ascii?Q?S6dDhCD57kUNVpSFdvtInx2hEBvmV3bJkRfGP9Bf6a/AXxExWLXPfE2NqJSA?=
 =?us-ascii?Q?oKSThBD8jSaWCwOvEEAL6pUIv8B0VGLryKyTShRcbw+u5k40RCIsn4yJ4RD7?=
 =?us-ascii?Q?jTQ5tH9HsLHUg7Jli3nI6SCtF+nzPFt/deSIKfZcyq1QAE8jPWyXulvSsfsP?=
 =?us-ascii?Q?RKt8bR2BVpFDkfdYqn+Q6vMW4NEAay8rIB1qH7YwnyhzXizbmEp+8UtWY4vh?=
 =?us-ascii?Q?5OXcvzfd56XMYKegWftJA7LOBgpoGvacosQzZ9jMqxHt7ykgBu4TZSDlvyg+?=
 =?us-ascii?Q?7PDmCDXwubdzI1eS5PJY8GdCqGuIXfg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba4bc2d-b030-49ec-affa-08df238f3975
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:50:16.3323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6//41+nJCSFp88KxY1ak/JLLgkvbHBdSpCqtl2CTbJl82Ww4XMdrChldA0APrqK0j/k7d8CpUQl+8/ZLNa/D1I0mUNjQ6Y0G16T+J6i7uZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR02MB9388
X-OriginatorOrg: processmission.com
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The e6500 L1 instruction and data caches use 64-byte cache lines.
The cache configuration registers already describe this geometry,
but the translator used 32-byte lines for cache operations.

Match the line sizes to the hardware so that guest cache management
and dcbz agree with the reported configuration.

Reference: E6500RM (Rev.0), section 2.11.4 and 2.11.5
https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf

Fixes: 54a50dae93fa ("ppc64: introduce e6500")
Cc: qemu-stable@nongnu.org
Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 target/ppc/cpu_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index db807f64c2..29f28be7e0 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2890,8 +2890,8 @@ static void init_proc_e500(CPUPPCState *env, int version)
         l1cfg1 |= 0x00800000; /* 64 byte cache block size */
         break;
     case fsl_e6500:
-        env->dcache_line_size = 32;
-        env->icache_line_size = 32;
+        env->dcache_line_size = 64;
+        env->icache_line_size = 64;
         l1cfg0 |= 0x0F83820;
         l1cfg1 |= 0x0B83820;
         break;
-- 
2.53.0


