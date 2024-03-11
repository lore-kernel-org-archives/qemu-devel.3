Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56397C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkIV-0000IA-NO; Mon, 11 Mar 2024 14:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkFG-0005cc-66; Mon, 11 Mar 2024 14:19:31 -0400
Received: from mail-am6eur05on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2612::700]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkFD-0006sy-RV; Mon, 11 Mar 2024 14:19:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mO5hDO+/UWOWFb7Hhwsm3knqLcgEUjXZ2z+k5l9FhjCDAYULBPcRH2Mx7GHl3NkIR5YLx5l4OzXLldG+016bz3plpnRcy9SQUPbjFMnIxw9FoUTNLednCxitU5eU2CnxqoLnv0C/gwbOu93+iYc3h0shFPGvNV8eI4HD3llm3vY5o0OlQFg7ARgsbtf7V3ZuDEpOj9J9NEuoOrypHacs2z1qqP56ZDpBS5aUYXTSKlUTNBV6K2JMFqqgY3lDsnDKoDgI/pRsIMt2BjcURPt3S1K2qDujBg/wWWj4CxuNbz6XIa1O0bwF3XDwAMPmvrq0WHzYjM0CbvSeolyJheVpZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DeEOhLB6J2Ik27zCD+EZAyNpNW6luKkLi1HhunJyH8=;
 b=NWTU+f2JN5b3/0BLit0ncsDAuxSFzVtTD7DiDAyL5qtTU0tVDD88ZRVLdes64CrQ+XPpumYb249PCJtPWyW51x/6Uu5jZEqCZZtsLZYMeJ4Wr6ydj40Z+Vd/YZ/btzlNW8qtXdMGh7PM5/nZGCamVHj0dTp+6DuWowIIe7/Pw4bD/t3Dz4Z8y5aSlsP/BGM4zdWX8zwZEIQ3CEuyZ01hVPbqyIMyGEoJdUw1oiQ8mFnxfb0sH8jFztpU4NUlK/3n3P1NOecdI1Oh/HfAN2NJWd0ffSEFeWsnEYmiAmJNF/uuyQ3nIoT3obK5xGt8XwirMAGxYcdf4HuC7HCg7e2/rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DeEOhLB6J2Ik27zCD+EZAyNpNW6luKkLi1HhunJyH8=;
 b=BFNzxBeRG7jYIdzRDLguqJifLlgBcYr/hP0ZQ3YoMS8VrAENiHpfmYw/gImrMsV5LeNkUyLvr8ITUh3f35l4hxpUcMJ1mUgnfirNe8t8YQPnz6XOibLs2oyTkaqvaWRgtmSJ+TvtkIg0fGCCOglRRsGY9ti78g1ad6RL9Otj+PPxGQlz7M+BYloVZxJFrjkrzAt+hjLGbK17FFQwPpcUIPSr92Wwam6RBfJryauLVbmEwbUg7hDbe2MR8xVQF6Pgw8IxTzPiQmCWwRmtjEcNkKvjJ/uR8pzSf9kgWi6dcvOflHroHwsNrnMbMIO+IQmTRnkMbjSCOvV/i+mMNEgl4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com (2603:10a6:10:530::22)
 by GVXPR08MB10762.eurprd08.prod.outlook.com (2603:10a6:150:152::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Mon, 11 Mar
 2024 18:19:08 +0000
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde]) by DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde%3]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 18:19:08 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v5 16/22] parallels: Make a loaded dirty bitmap persistent
Date: Mon, 11 Mar 2024 19:18:44 +0100
Message-Id: <20240311181850.73013-17-alexander.ivanov@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: DBBPR08MB10721:EE_|GVXPR08MB10762:EE_
X-MS-Office365-Filtering-Correlation-Id: f0192423-1ba4-41df-06c8-08dc41f7be69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8KNPOvJ8OVekN4M+NShjp8490RFVGm/CjE17Bxm0pgasY4QFniGL9GnOQo3Z+Px8vRmX306vSvdnXkgTy/IIC7ioUcnv2YxtdKc/mY6mtOFwqE+5mObmAymq8idFKryyF4atzhGmbreFBRN/f3tQ57z54j2WeAZKhSmMESi8fyNUTE35kri05emijL6M17FhEvZf0XRJRx15F6LehY7hBFfRNUjKjffS1Zyg8M1LAsNt7svBBexLe5N2M6wOrBKKvYPZgM4o6EiwdpT3T/uJh66PymapQmUMw4fi+A1GOm4mYtWZKYc5HYPp6Uq77LIeOnjXwDl5yQtcabJfaBGHwD3frGGcIByIkcWE5b7vQnxOTkkvfinyk64mUlxF/9NGTSE/mierCShs9US3x9L7ClSQEUI1PkF6iICf5WDhVxaEeLYql+BDiCLyipP8RgF+WvYNGelyOvEkwL+vmF4FXLA0e7so+09z3FOWfBclbanxaSsbGfUHBJuYGS4Eq/Ea/3x1060997FokBVDX3zlczPXYj25OecRElyyXejlnExhAz24zT1JoNvXlGT+YacfrzfpAg7Yy1vcPaiwIysHpRfst8w7ZiRExgaRNWwRMnZtVaK2ap50LoBl7g2vmkDM77WCvGshB4p4ShUsvkl8+zKtxbP49kX5OZvIx+rw0yAj/zm3hoIfDeBADgwn/VbnqZZQdB0yVsmAwTwdjDGB+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10721.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(52116005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2oqnzCws9stCXvu8CO57jpuhtprQvO78cG7Zdpo/Dld7QF8tPR7NciV6Z7OF?=
 =?us-ascii?Q?TG8hXasw3Pj0mT6uxq0GjPcTGVtl6Mt867xSzYSyA9/F9lp0w46oZMYqMzio?=
 =?us-ascii?Q?Ze8XCTzlQGPq2uEfOzdzO/D1d3kexQ47Ig5FiHEEsOt1O1ojwk+sdjF8t6Zp?=
 =?us-ascii?Q?Vl/o0flxzrZfuauCCCYovtyWg3yh4PceBjoc0kd0sAMsAd+zggwsDhqUfl13?=
 =?us-ascii?Q?x6hajcf75iUAV3sATNc3AmUaBLVOWEocbUnhSuhOXrg8GCspWdn+hFQ49vYw?=
 =?us-ascii?Q?f1pmhhtx96Vj9MK6jTyf0MmrtcD/z4n9YCZS84gs4L5KU1Vb+L0uNquZZ5a2?=
 =?us-ascii?Q?WumCmf2zmr/os3NYyRj4+O/4i4TwApMqDoeMOaa4KpoZzMbXHWNh6gb9ntdN?=
 =?us-ascii?Q?5TmKF94MMSyea8ktlW8Pqr78MSOfDRebozGtScGz1j9iWE5R0X4Q8XF+gtbL?=
 =?us-ascii?Q?CbhBBxS5eWLuawrGkn6ZJUnB0dpdsYeINbuq1TvVjHKUmXX3IJIEjwQnj5m8?=
 =?us-ascii?Q?55TlMtZVnSYw1DDfWK5kVwuVUrHvqK+jXwXPvjIcdONTalFdRgQtrkDAx8K2?=
 =?us-ascii?Q?1jWjLeW8LczE7ZoHmm0e9ahpn9sCHRfoH5p5MHwmCg7IFunXUxpcL9k8QNo4?=
 =?us-ascii?Q?3Y50T23No0YoV/PcE214bGLPzsXBGVAXFMIKm24p8l4zd0fF9tfZ/Z0wM2a/?=
 =?us-ascii?Q?vF2pCb8lD1LxafT133UrTMQXXqH26Hls7pxb12oOggOQ+w4bU8yE8pysoVbl?=
 =?us-ascii?Q?YTMkvTtFZbhiKpNTkiDpSH1oCbWj9smxM7bvbov3+zPA4bA3a5pz1PkOljW/?=
 =?us-ascii?Q?kB0YaRhjBtP7W/8EG+548yuOBH8gLsw8gDG3Sp0zLuf24Vsj7rBNR/i/Rvf4?=
 =?us-ascii?Q?bgUyOsg/0d1XkGqqWcxrAhypQGEoWuEDO6vJ84qsRmy5ri+SsJPZiZO7ghDX?=
 =?us-ascii?Q?snAeNZJP/pm61S3Fb4UrQ7HdPF4B2Kbdd8pAzVu/xbCPXZ1pdDRxXjZBPuXG?=
 =?us-ascii?Q?Miq7iL+RbZqDJy2wNrAj7333/cQURBY9iYPS8vQ/LjXHldXjzsXBoRYPqi8Y?=
 =?us-ascii?Q?ZvJTHlJOvqbygP8KhLlMkNQGgJg46Z+SlIxL4EuyrmiYYSW/wo4WKcYpuM9r?=
 =?us-ascii?Q?GTiKcHPsqXEyrvFf7hSX3kNMAELaAtm7j4RFBq5yP+KHIpy3lin+JhN9dn1p?=
 =?us-ascii?Q?o00j+tcYCIk39gB1zDbnEBt1+iQOonk+hpuHjAWzW159eKxG/bFjsqN9kbQ3?=
 =?us-ascii?Q?QPiTzf2RdNiAiJeYR7dvHQ7TwFqmyIbgQzfxyE+BCgHCsh7NzjtsgnlczKw4?=
 =?us-ascii?Q?cLw4AN6y7ICeAlYeLxzxFKyb/utd/jbzohNdKG87zqRNHexGGf6QP/ctiGSE?=
 =?us-ascii?Q?3JeAWqItYnHC6TMlD46FBZ5km2ajuuXn9SjsmY97mgorZ/SkUXV/d35uVmE2?=
 =?us-ascii?Q?Yy7wo9IwE8jbustejhaDC+7xiUxnzENEkw6xarWZk/CQDw7qMV1tcsBlt2h8?=
 =?us-ascii?Q?v+2u0GfeJT17ugBzvyuiB4AEPE9S7k+1T8r3dizgouna7tfJ0wevXOZBhGbM?=
 =?us-ascii?Q?0njL+IDXTeCeukGKX2lJ6Qwtv5ejJejrRCTFq+9KIU/DYkW/3HHB2Man5Ly4?=
 =?us-ascii?Q?qQ9blyXSwozJJsSZlIkcWuA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0192423-1ba4-41df-06c8-08dc41f7be69
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10721.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 18:19:08.8577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dh/ZcqnHUHo8i/wX+6NKtnuvLgp27CO+HzV5yj7xQ5j3DIt8lDeBFeayIgp3BHgL5A2KF+zffV8z5rZvYFDFZO77cVY1QZX8SpFP16lTFEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10762
Received-SPF: pass client-ip=2a01:111:f403:2612::700;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
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

After bitmap loading the bitmap is not persistent and is removed on image
saving. Set bitmap persistence to true.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels-ext.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 67fa3b73c2..0816b9dc07 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -278,6 +278,7 @@ parallels_parse_format_extension(BlockDriverState *bs, int64_t ext_off,
             if (!bitmap) {
                 goto fail;
             }
+            bdrv_dirty_bitmap_set_persistence(bitmap, true);
             bitmaps = g_slist_append(bitmaps, bitmap);
             break;
 
-- 
2.40.1


