Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9758EC5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 12:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKFc7-0000Qx-8p; Wed, 28 May 2025 08:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1uKFZu-0007Jr-SN; Wed, 28 May 2025 08:08:22 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1uKFZq-0002pA-Jx; Wed, 28 May 2025 08:08:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIVJHhJR3rr80h4oPrgXpN7vseh513BkdfFgGtK/j9XgZWDWGqK9QB1sVAy8Eohuxr/a+nqGyrnfvLIVEUpc3HpfIHFuuFV/BfVwOqt4ZyiRG2dXmbVOQlEetRHqbYAOGcv08okxsIgo0xt+q12Z6KDogtCim/R5gSRtrldzhVSgYX8f/2KjPdG0CIWbG0chHIrU7cuPBm27zX4p0DiSDA8pEfnkPLWdSAf78SjYQwI8pj5EHp3iTPMe29zQkFWRYaQf2KZtGmjnk+leJPY/0pCGXzwTF55iu2nnDSeHAZ602iCoOgogHqBLqgUgRkBMorYE2l3uc/JuYapyzHxKZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXHoMgYU/1N+SeUYzJ3iVtezLtziMQieijRGjFdhiNI=;
 b=TK5QVtyxapSBwU13uo+7P40C9hmMwPDN5393w2JhvVSrMtVyThag+VeCiFTCtut0GatZVYC9GVskO9mpJeeuexjHdcD8SnZ4vA2QIn8SsYcVwE9wuzeBc10zqGdbXocLzO1CUN5DxqWQXOx2i7JcYMbq6/dJOBad20KlK960QRe63fDLHYKsHX0LwujJNDgAn1wWGEz0RemIRaBaLycjkJV5Mw6BO5bMoQbO5NebuEZ3dwJvsynBFKlMG7PlixA5SYR7ckgS0oOdj4Cfc6yDu/46gC95bHEESPJTgjuzhB/cT7AxQijLAfalhmzyGtPHSTWN2O/AFbGcaEWpuP3QCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXHoMgYU/1N+SeUYzJ3iVtezLtziMQieijRGjFdhiNI=;
 b=DVodF/KkFqiK9/de9lt6p4/nm/IRQ2sWu3VMpPOXy/vZU68LFzD9Hx1CN8J/Ho+7KWs/uk1ORGMlOQXc6R6nEWxNXzBM8k3zmsuOOF4wEhMdyL4PRVHQKTj0E5lnkvdbKizNRTVH8BOIIoKCg+zEZ+xXoAorDCRAHtEx3CHsPhR0V/1t9fgaxcpcsHYiCjWPy+fDdPLr2QhEZB0j7L8FpY6EQXPwzZA6l7pOBlleGKtQfxpRlar7tGSl07ihGORDwCbmXCVfyJZ+iy6vMmid8jvBL5Jo/iDL0iehuThUD2LKJH183y+fWr28SsMMHx2uAQXNoNSY6L+G8ZtkawUzNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM8PR08MB5732.eurprd08.prod.outlook.com (2603:10a6:20b:1d4::16)
 by GV2PR08MB9277.eurprd08.prod.outlook.com (2603:10a6:150:d5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 12:07:51 +0000
Received: from AM8PR08MB5732.eurprd08.prod.outlook.com
 ([fe80::e543:a83c:a260:602b]) by AM8PR08MB5732.eurprd08.prod.outlook.com
 ([fe80::e543:a83c:a260:602b%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 12:07:51 +0000
From: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
To: vsementsov@yandex-team.ru,
	eblake@redhat.com
Cc: qemu-block@nongnu.org, jsnow@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, qemu-devel@nongnu.org, andrey.drobyshev@virtuozzo.com,
 den@virtuozzo.com
Subject: [PATCH v2 1/4] hbitmap: drop meta bitmap leftovers
Date: Wed, 28 May 2025 14:07:28 +0200
Message-ID: <20250528120732.2247150-2-andrey.zhadchenko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528120732.2247150-1-andrey.zhadchenko@virtuozzo.com>
References: <20250528120732.2247150-1-andrey.zhadchenko@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::8) To AM8PR08MB5732.eurprd08.prod.outlook.com
 (2603:10a6:20b:1d4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR08MB5732:EE_|GV2PR08MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: 041e1826-4adf-485c-7aa4-08dd9de04502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hVnJybEo5M8k1yOhJoFEvXwDOFpqfrAQ4uVJ63HCec9JJZqh6wMOqfbv2x/P?=
 =?us-ascii?Q?T9x77BRYj+HryiSWEzwNZZX/Ukv/MmKQyinbPOjAPZj8UKM9ehIiAzZEJfoo?=
 =?us-ascii?Q?lITPaF6cMKPXO3El8sVXR1udXAa0VdiWMLHOvZeBnAFUofI2iZHK7y6XciAf?=
 =?us-ascii?Q?T66OHSe/T1Z53cY1yp74V19fmJNaGHVn2Fklo2QQiHWKh7gDZ/MSxXEY9Syu?=
 =?us-ascii?Q?jr5uxNm8durVPXxncjEM5eEgtWRZ3cYI8WOG35jp6OHLOlW4EYqV5oqjNMkC?=
 =?us-ascii?Q?lHKTtH/5g+BC64nDVa0bBKD3w66umtunkFVbDz1LifuHbJ5Nn6UZG0s39isj?=
 =?us-ascii?Q?pkV82Cd6x+s9Fh1tsN1kYbCP/uKG3k7WviJ86wssLMElRZ/zYIU/Oo0T3stN?=
 =?us-ascii?Q?4a8wLxbdFXWQSaOB3mcYQ3LeFeLUZ5b8F1FDvL2w3SVrMLT707dqNkq/DZJw?=
 =?us-ascii?Q?29M3EvgQxsJ5qc3GUqChdaR7YYwTrPZiBjmbZPxKppexCHmxUGgHguAWE7OV?=
 =?us-ascii?Q?9k4b2abBmj93WvXePGKn0ppjmDEl0bMb7mEhGcCr4C+/8oqJYPAvdha3zD33?=
 =?us-ascii?Q?1d1bZjW7La1Jwm/SUssrfCIuYQze4RuotSNTyYVWA3CClIxf9kdDy5/u61c5?=
 =?us-ascii?Q?Yg3z/OmsyXYjQ1Rjn33TUXrwWJHZTaS2WCsUWXbjA0RKyQMw5/YD9cL5HsQA?=
 =?us-ascii?Q?8VWtu4r5lIPYbPI3HafhgL6+GDrc2oiJR+01NRp5sP0HX4gBqKKRlIzVjRq1?=
 =?us-ascii?Q?xM+zoK8flPo4mioJEPi1jZM9aPWHAHbdoolWIc7UrVVAMdVUwGvQPm75A92T?=
 =?us-ascii?Q?7FyQF5/VoU7xyZwSgpWNy6EXsuYCI9Dfh0d7vQHAAO1tD0L9rxvr1U+7C5GZ?=
 =?us-ascii?Q?34ajINNsxci+cQYo568SSc0cJ0MFUsh700IrZ7YIhoZNT0Ku7RTKzM0gjw3c?=
 =?us-ascii?Q?Dtx3vEycen0XciTvv8oJWqpeKbf68FccSEQuZ2RpgeRen5w+6h93W7YTHj6p?=
 =?us-ascii?Q?ypmd7n/91TnXNX3aBb5zzGmhLZMWl3srnEqnvxUloqYhCjZvAQKjZo1G50mi?=
 =?us-ascii?Q?z+Dn7cNWxxKO/F56uBIHU8BbxzOuS+5FDEWe0Ca6ZBvDphzaY0XKqoGYjE8c?=
 =?us-ascii?Q?XRRiuFj37PlltN0Tnzob7LqBjPR0jP8iC1ZlN7FXafFecOPHx34wa8zAtnf7?=
 =?us-ascii?Q?kLD8s8ZALPr9qlm6r569/2duJFdvvu6QuvHN+0/pkuQgKqhmEfQgxxMqQ0dW?=
 =?us-ascii?Q?yVvLEC3Gz4hnAbgAZLu2zwyYouT1pB5VUHqIOetRmMrMspW8LClUyVAtx+Dq?=
 =?us-ascii?Q?Zi9X9VBocLgeWHIHzVeeNY0mkMYb3BW/KvmQwNcOejGAK6ZV9/0x1msiuLvR?=
 =?us-ascii?Q?STKjEHazBqJsTxdcL+3VLsTMhnAoJZLarILPILmwuQg9L+4eretB9DPuW6LW?=
 =?us-ascii?Q?YSy6ZD1SYK8UQtM0H5xX6ckDKobSVWL8yTRMt6z+46a/SCW4mCfbDA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR08MB5732.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XnrezfRbI79qU8ahLmvXb5Xditlqe2y43T8VCtOEk7uqI6LshZLrzrrCRu4e?=
 =?us-ascii?Q?A4TSGmZEyKpqb4X6hFsQ4xYVtSu1OAaPGtAIo/uLG8MJkfOsygvJsrg8Crp4?=
 =?us-ascii?Q?T5amvl9Siq7AKtx6q9f37p7xmpozLyB+6OqABKin2rp5d4PUX3ZiOY+TjpHl?=
 =?us-ascii?Q?SifNjnajv1QDLgey5mL9AoqnYDRK47yko+9YuUmZ2zdutKAnUu3aQC2NkSn3?=
 =?us-ascii?Q?n287KZ/TCxd2NI/LYzC09/oJN4GdYMbYQkk6Wlj8mEyfs5mjtqMevU/82zQz?=
 =?us-ascii?Q?MCfk22wN3m8MP+xXKbWbjYftR2le80cqtSLzKsqKlFVG88ioG5fTuPwaZz2C?=
 =?us-ascii?Q?OjXzH/NaYiP6+9skitN/oL44zoBsg9C9u25egZOde+YI6W+2UyT16pQClUbA?=
 =?us-ascii?Q?4BM+v16vcYOsw/OLMlQGdBEEI/kmwvfl0LHKvFdIJPrQm9WxcjlynkJOu+3i?=
 =?us-ascii?Q?1WzkUTnzjRvNZY9mQBpS4hyQCtyamyzBpdm0PMKDKLcLnZ8K/dPFci+CRn+x?=
 =?us-ascii?Q?Gwjxv4zUKl68Sf85IN+qRPk4HDyz/eGERW8kKQogJZVBFRDCP1XxmQvzk3z2?=
 =?us-ascii?Q?E4pJ33VuFAzGR0mXPRH4KCaZbqRMFq/uMfKP8RQre+ENqhKN2k0rIYG/ze5G?=
 =?us-ascii?Q?EmRCqTXdnSvo0Vikb9xkFBvhiZa23WBFpgJwDpTQWqcv+jjr+iYDdd90rpE2?=
 =?us-ascii?Q?gNECT8xg5Yvb1LPTijoUwzcUDFb1jQsGN3jURFOP8MIwh7bFa9MInZvV1YNo?=
 =?us-ascii?Q?7VUw0JOj60QQYY5412U9TF3PdrsR6cJ5sw3vp6EcwfCp6HTyH3piYTO2TRNE?=
 =?us-ascii?Q?Q2ONcuexQFhkDCqucM9T/79UnR1B+OQY2LeQcGzhz5ZraKdWkpcStdldE6/q?=
 =?us-ascii?Q?UTIvelVl95n75C0e4Jjsv/OJu46Vq7RxAdFHFLY3qcdd7UF/i8VRCzb6+VKx?=
 =?us-ascii?Q?+0Vmj4tpjfXnoSvoRh7mI0Mg59y/PNinjJ5v5J8v0fqh4dklQHqZ1gS6KNj4?=
 =?us-ascii?Q?w4a0zPTqZEs6UR8NucZBDjy4BeseZ553JPI3Ool1If1YAxcOPIi0bSGO5CKA?=
 =?us-ascii?Q?ACLNxMORd5ngWws1nVEgv3lkbn9SQoh52Z3S8OtCOJhkyzAlEUlqpLpKV9Qu?=
 =?us-ascii?Q?dOGk0CDDcmKNaTcVmBFIn/8cGcqI8I1UeYULKCgJurrPvsFNA8m0huERsJXF?=
 =?us-ascii?Q?Xn/cOprGeFCkdCAQ4RDdwHOg/F+58TW9fTUBzgyn1OoDs86rIl/pd8/qfnY3?=
 =?us-ascii?Q?fWRKv4k+Gqmjd2POF8pHisOPfx4ePXhTRGemJ5Qr/sbLq9xv5rHuaNIOI8s7?=
 =?us-ascii?Q?9s+kmxFcPGIOxNmhpaPpn710ljOksShW+Chj4XJgKuJYCqAW9B7Nzm+8KmPf?=
 =?us-ascii?Q?Kq0WC6GwUs6Qjlg4IqB5c7EJ4YKPYr8zHsZK/WT9ANFptZ/AK4k6qUAhlb8h?=
 =?us-ascii?Q?RmJ3C8bpihyCoJfvcktJMLaf1gpc9P1jkSlSgZ93AL8M2FLdSqvPpcuIQGjG?=
 =?us-ascii?Q?SDZcnvJh687TuyKlUGslMFuDWH7jkIVqQ6b8a1GgqSzk/SJI+sKCr84YtrZK?=
 =?us-ascii?Q?qrLi9nWqnjXgOJFY4ZqILnGVrOl2WZ4ZaEnP60znTULfDf8Bz3FGh7g9fgUJ?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 041e1826-4adf-485c-7aa4-08dd9de04502
X-MS-Exchange-CrossTenant-AuthSource: AM8PR08MB5732.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 12:07:51.4292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YVWGDj/xExYHn09lVwoGXxLyUaREAUQF2DMsTUcmFGVfDLQ0e3G+ClYvUN3SBnTJfKAniwUtcOx9Np38qJXbmPmZsoNAx0pXrhJ0bfjmRG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9277
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=andrey.zhadchenko@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

API to manipulate meta bitmap was removed with commit 0c88f1970c76

Signed-off-by: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 util/hbitmap.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/util/hbitmap.c b/util/hbitmap.c
index d9a1dabc63..16674f33e4 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -84,9 +84,6 @@ struct HBitmap {
      */
     int granularity;
 
-    /* A meta dirty bitmap to track the dirtiness of bits in this HBitmap. */
-    HBitmap *meta;
-
     /* A number of progressively less coarse bitmaps (i.e. level 0 is the
      * coarsest).  Each bit in level N represents a word in level N+1 that
      * has a set bit, except the last level where each bit represents the
@@ -480,10 +477,7 @@ void hbitmap_set(HBitmap *hb, uint64_t start, uint64_t count)
     n = last - first + 1;
 
     hb->count += n - hb_count_between(hb, first, last);
-    if (hb_set_between(hb, HBITMAP_LEVELS - 1, first, last) &&
-        hb->meta) {
-        hbitmap_set(hb->meta, start, count);
-    }
+    hb_set_between(hb, HBITMAP_LEVELS - 1, first, last);
 }
 
 /* Resetting works the other way round: propagate up if the new
@@ -577,10 +571,7 @@ void hbitmap_reset(HBitmap *hb, uint64_t start, uint64_t count)
     assert(last < hb->size);
 
     hb->count -= hb_count_between(hb, first, last);
-    if (hb_reset_between(hb, HBITMAP_LEVELS - 1, first, last) &&
-        hb->meta) {
-        hbitmap_set(hb->meta, start, count);
-    }
+    hb_reset_between(hb, HBITMAP_LEVELS - 1, first, last);
 }
 
 void hbitmap_reset_all(HBitmap *hb)
@@ -784,7 +775,6 @@ void hbitmap_deserialize_finish(HBitmap *bitmap)
 void hbitmap_free(HBitmap *hb)
 {
     unsigned i;
-    assert(!hb->meta);
     for (i = HBITMAP_LEVELS; i-- > 0; ) {
         g_free(hb->levels[i]);
     }
@@ -868,9 +858,6 @@ void hbitmap_truncate(HBitmap *hb, uint64_t size)
                    (size - old) * sizeof(*hb->levels[i]));
         }
     }
-    if (hb->meta) {
-        hbitmap_truncate(hb->meta, hb->size << hb->granularity);
-    }
 }
 
 /**
-- 
2.43.0


