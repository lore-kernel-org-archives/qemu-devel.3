Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE3BD1F9B5
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 10:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR6vo-0002i6-EW; Thu, 04 Dec 2025 05:51:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vR6va-0002UJ-6V
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 05:51:14 -0500
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vR6vY-0002Jp-Dp
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 05:51:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7VH8ngWoGPQQ6zNTqirA0hLG0EkYepgZ0KdOQvi6Dl/h2LpI2vfbPYP3kEgDGMwm4BzpaHGC9fSNuRN9ttnx2WFn6gUoYKS24P1h5O2rj5R3Q+MVmtiekdfb8P7x+C0ZJCtgbStiiRhLQ7Ak7VEb8qgp6QMqHGDB8YOS1Bd/THOxAnlZfAdjYVMgWVhXJ+7YUxtqEanNCVu1x/SgtFObJm3aB4FdOomu4SBpniOgBtoB6ZUBh5YFZPgtqJAW8RzGeML19RhYUKWvgmEslOytK8pOvu86yUeEpWAB+vDe+K3GoA159slAvl3W13MmVDMGV0Ve8mLB/XsSuoFzqRC7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkdLg61EAjLiGyTPzAAR9Y5JdjmyslZNraIikIB4ltw=;
 b=fhmQ0Ruh+T0p9DfJJjmLl4jGX+lgHstesV2VHUE6S9Ql3ctGeDtyQD4qvXKP5VLHXvT5ZPdgca1BREByBMfyklf+wcK9Zlv82wOMDXYw5UTX3/248rSaHkjR99wuKd2x0UQVlUdPh9TdN49FE3rCskFpjw+bcH5qOgU5PrdCWJeBmVJtUVEWE6uxbmsgR9rLNHMxqXUP/0nahuexnRgwfaonpJf5v8wuR4/1yKRCD9GY4kc8/hFaZfzSBGy/kPDpSPJogepQjEKAmBMafy7kNBOUxFSzopJg3gBSK/MP2ghH6sZ+8CcOuY0jApWPvGveYc+EpuWYHofAoMHIZJtBiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkdLg61EAjLiGyTPzAAR9Y5JdjmyslZNraIikIB4ltw=;
 b=ge9Wx2L0qGCTmPUKMNhSxBrWO1Gg2YKY6xmUPQh9G5hpU905I/PULDbaY1bTa6dqvxUgVw8kMnJsAfo/ZKb92LuixE8vxhCDg4Xq2dQEWn/m6barH6tbBUqMTTFYqlf1kfNF99IfOQ5lWl7ZXDJIb46pAUW9CNXyd9KzDdtsntYyGzaq+Wl/DQegA4wPICqRDBzC2kU1tdcbIcuukldRL6cB/38pZxKlc8C3yE4NdiplX5O2+uvdV94HIfOKZHPY1No0Wni2t9IIo9hJFto6fxnhHwLqrsEktNJXahKSnWE272EZXIQUvk8LPnWHC2qWOvEtLsmfJX+8RL7BGFMcPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB7718.eurprd08.prod.outlook.com
 (2603:10a6:20b:50a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 10:50:33 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%3]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 10:50:33 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peterx@redhat.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com
Subject: [PATCH v3 1/4] scripts/qemugdb: mtree: Fix OverflowError in mtree
 with 128-bit addresses
Date: Thu,  4 Dec 2025 12:50:16 +0200
Message-ID: <20251204105019.455060-2-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251204105019.455060-1-andrey.drobyshev@virtuozzo.com>
References: <20251204105019.455060-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::8) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd8a6f1-e4e1-4d26-d54e-08de3322f26b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WT0BdfOwaPmBz9RUV9hYqM8n8Im/dUpiwT+sjEo7QIqJz3J6Oh3In7pkGEko?=
 =?us-ascii?Q?jil+yuS/5QHwiQ3ik2cq+Q99B1NiBq6JxMMfrXR58z71T9pYEVhnJAEW2eV0?=
 =?us-ascii?Q?PfUHZE6+EF5z0gMwOWbCPoN5vwZypnbd4kyaYEiCbMGbVdbkkRTdz/mfpzpO?=
 =?us-ascii?Q?vXJkmrZ0zhrYcZXgTbAFl6OjHuEMXeWGNkjnfJqW/ZIyacxYeUzV8G7GudO0?=
 =?us-ascii?Q?7FYjKuAw9/hUMMSJAyeBSumixIZjQSd0VPvlF8zjUyIVoQ+HUAuJh85fwq0o?=
 =?us-ascii?Q?Pwyh1J14NUgGSlZgAkxI4WlACzh6o6eZuLn3oSIXfUsZoIqQ+k0grL4SjopK?=
 =?us-ascii?Q?NDHx+tCWPNJfRnYIvyN0qIu/e+/DhfLXnPFdODW4ae0wF/V2oes3aalQxMwW?=
 =?us-ascii?Q?PPiRnewiLlvSzQ1Qah13F1gdHSUMcoh1yZu6M3AjdvbNEDYOWv78EKqyRlzY?=
 =?us-ascii?Q?+qPkYVFYdc2roMVL+cBJT8K2ehosU+kFe4r7RTt/bsgr/kno891truTQtamT?=
 =?us-ascii?Q?WYXcdZtIus2k2XXbiwHaiy0/UyEZZgbMMtyeJ79RdabPRQK9RSVwLW1K7TDh?=
 =?us-ascii?Q?5XpCxCRicBYng7LMjfTXy6M8qlmfnIdLVl/lBg7I9n9WxoCpZiSc8EMmsD9e?=
 =?us-ascii?Q?D6cSAgPQpJ5hpZkLIcU/2O+r4RVgS684AhRIlR/CA+k7XC5WavoHAa5MmGQm?=
 =?us-ascii?Q?Ur2Lh2d1wJU/7SM9RAEgI6j21X47H49+QBEHdc5VZFD3HEqqcmwE4uWjY1MJ?=
 =?us-ascii?Q?8BfC/AC7U//9u4+YifvuFtdfx/yWh6c4OFK8gbpBbnACUekrMyQdLiuUBFq2?=
 =?us-ascii?Q?y8gsiWa65+iMa1wf4ckbVClyrO9nKQN2Vr0Zd9S2+FzzCaTXNbsuxV7NbuFy?=
 =?us-ascii?Q?+nwBtkb17hPhoGZPTwhcP6SUeSCn3ZXPoJ4stOJ1TIMqkRthNsHJ9bn79kzh?=
 =?us-ascii?Q?UBOp4wI8PfYjrZ1RGusjxemUY7K6zMnbgKg0QMKY3R41cZxSBisJRkfUckKf?=
 =?us-ascii?Q?NYqnLtx3ZWFiwfWlxqJy6oa4rurqmd1En7EaSNa2dVHz+6menJLC5gkVxEK/?=
 =?us-ascii?Q?KMZ0utQCF5ywwSvfPCdU5IlFTqqi3eI21bK7fOAyinAuWrEiCJ0sUPsOLBof?=
 =?us-ascii?Q?YUoHvOVky6Wj2/mE+jkv8Rl/pzPgjCeTHy8HU+Be+HjrX1dlf+5E/ETUrknS?=
 =?us-ascii?Q?QaNQPShAsCttNeYRkbcgOxlGft+PY0p3JaMprKYtEGGvF/kNxEy9u+4Jl9SW?=
 =?us-ascii?Q?S9hrWiuqSEFjPngM+s5yMcA+0U/vmKdhsmgL3W08OeXnMut8i2QDZwaHlnsk?=
 =?us-ascii?Q?/pHM2MMWlBvNgyUKlj/JBNoi0YuZqmrjj9NNKtGV5FHmF1nZbpxwIavn/AI6?=
 =?us-ascii?Q?LN1dT59Vvg08DcJVoA1wh/239uODBDfwN5mbofdQ2VYXeYTxVJFL7ANugHkC?=
 =?us-ascii?Q?qWwpO5Z6ZgQB22CLnryyR6KYiw859rjPh1HjE71c31l9479eoR60EMud4IGQ?=
 =?us-ascii?Q?X9EkXMBL1wU9OIDyeI0IAagzFTuPWPj22sOH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tykS/NtHMLboyaaasXVsgJCh8HNncIKXs/5mlr5fEB3LzynWV+4m4OylfWX8?=
 =?us-ascii?Q?ZfPOeiQmVphRD/PVeaR8XQwFkfzs8ipIjoItruSjQBNY/f1vjiNxMsnNInSH?=
 =?us-ascii?Q?Q2JWnz2DjzzqBiB4hcVwQHL4+rry0D3PzRag3QSi52UOQpQKBU/Pi9SDaOTn?=
 =?us-ascii?Q?vo24FLzTVXzwgiIc4/Q+DkFmR6EkbTyJtn83XkHhcX8ireMHXtMHqm6QH4Xv?=
 =?us-ascii?Q?oZecbyoBEkjkg5Y363LjghAv+3Vod2qni1A9dC1jL5MvG1fMPp1EScADY5Yh?=
 =?us-ascii?Q?kl7dNJ5hPBZhICQwlQ6DuAnX2y0JzBJKdS2We5IYeZAbstKt8z6SbW8d4MUt?=
 =?us-ascii?Q?QLgSdXYzVw8KrRNDNkbt/L8b90aJ2lVqdr2a0KaR2uCl6uI0wIuneyO173uu?=
 =?us-ascii?Q?nFnmShLbnJ/b354sutvwo5kv+uFA55eYp/mwj5I1bg/Cq+xcSF7VxNx61Vnv?=
 =?us-ascii?Q?BzkErM/xK50X8A9LTEjTwcxUU+RO7Kec1W3/uPOJUcgZzQm3VRAnIB85y67C?=
 =?us-ascii?Q?dB3P7aJuwMKzIhvI55rQodLND/pneV3yC6P4u7AnmTmHsusSl5GkuIAWNb92?=
 =?us-ascii?Q?H71NnI/wLD8bMKwEGsDaBBDcgef0y/YC8AjQclN5o5agqTWm84tRfyQVE0mL?=
 =?us-ascii?Q?8MvpVZKLNlDmYyGmPims5BQzciVBSMynRwUL3gD07HwTCvCjUhSZhS/tmX9+?=
 =?us-ascii?Q?GDqYkHGBcVqtGUjclbYufwFXEE4u974x/Tp4zf74xf6UIUIubnqx/XQfJ286?=
 =?us-ascii?Q?PoQ3RK0MnYzrRNyjq1HtQX7OCfoskvVM1lFDFxAgWfyAB+NmwTf3h4TtOm2L?=
 =?us-ascii?Q?WtI8DchV5n6BgiqWiLz2zjdWhXiPq80HWAnRXbN461jrS7NVYG54zx5aMK5B?=
 =?us-ascii?Q?QSpOEbyxgCqbmFYJMDCaEOcGhuIamNCONAAqEv+uNxw7/1IjaCD3UDmE/Aam?=
 =?us-ascii?Q?/71nl2/c7HHt4fveALf/6OJyxfdZYSvId3ohXUalKDzVpppyHM6v8Ox5hDeW?=
 =?us-ascii?Q?MuHUFncI0iH/s5uehc7USsyi5oLMp5X8HMuzfcGlIpd8OZTmAq2BHq2quPU2?=
 =?us-ascii?Q?BSndhXb6bRxI28c+c/mq470RRTtmYSen/cflbdye//sG61PKdqOp8NprrWc8?=
 =?us-ascii?Q?Y2awmbE1LWo4dN3RoNl67C7e9c/YwlKJSE60IxRAJu8hGg26fCOHmVQ1oVFf?=
 =?us-ascii?Q?aURZaXjaf7p6MiRGPlJ124CNiIlJ5Zm463QdspYwKy5L41TmzJIteWrdJJ5Y?=
 =?us-ascii?Q?kDljWR5BcWJM6ziPJNq5V3pwO/re86Tn7J0/S67600clrWziitZAkweQ+Ohh?=
 =?us-ascii?Q?Fse3TUMR+YkKG+LFibnTL5ygg63tgJIrkP17kn0ufNSw1UmJdo7AnM6HI2sj?=
 =?us-ascii?Q?lDjjkFBXlusF+byzQe1JSpnPqCHm5Be0WibZLCTDN7jHWAr7MhgG2ZviLvec?=
 =?us-ascii?Q?uaAXgEodzZinkTyby9Db7RnUYFiqgsYn08KtuurWf8GWAiMwVv8JcwmnpEVK?=
 =?us-ascii?Q?H4CqUVSKbw1figiyeu4pi3Qdwb+RzxvYTQff177dgz6RmBXgZrMdGwcqbP6k?=
 =?us-ascii?Q?XBQBVnxc1G3HZhl7rVoYmv5XGvRm6pt2eyY9IAaCuoJBCfy3w5rpm/liXBQX?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd8a6f1-e4e1-4d26-d54e-08de3322f26b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 10:50:32.4693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f68gWMm2PNo8fbqf/g/zIxmpqx1YZl4/O500aIF/jKhpAqJ22/2vSJ833y4ed7UYG9zPgzv/QiCVhiASv8F0BFuv0lDTHHI8Fa352WvUjIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7718
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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

The 'qemu mtree' command fails with "OverflowError: int too big to
convert" when memory regions have 128-bit addresses.

Fix by changing conversion base from 16 to 0 (automatic detection based
on string prefix).  This works more reliably in GDB's embedded
Python.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/qemugdb/mtree.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qemugdb/mtree.py b/scripts/qemugdb/mtree.py
index 8fe42c3c12..77603c04b1 100644
--- a/scripts/qemugdb/mtree.py
+++ b/scripts/qemugdb/mtree.py
@@ -25,7 +25,7 @@ def int128(p):
     if p.type.code == gdb.TYPE_CODE_STRUCT:
         return int(p['lo']) + (int(p['hi']) << 64)
     else:
-        return int(("%s" % p), 16)
+        return int(("%s" % p), 0)
 
 class MtreeCommand(gdb.Command):
     '''Display the memory tree hierarchy'''
-- 
2.43.5


