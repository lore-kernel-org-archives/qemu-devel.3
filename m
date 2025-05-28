Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C1EC5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 12:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKFal-0007p2-3j; Wed, 28 May 2025 08:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1uKFa0-0007Nb-9E; Wed, 28 May 2025 08:08:24 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1uKFZx-0002pA-3P; Wed, 28 May 2025 08:08:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOrg9U5RpnHfNsoAe14FNxYclGRB8ROwaIeS0vvOAUFS6i7ALMiEGVCIn72gNsFjSOnxUg6frUHmasoMRbWv6/YzgTSH/Rbh+9IpS9oMfav+GnDEp4ftbHFnZmIORQ+16LahKkX5y1wGTXBiVkXVq6ZQeSoLJh2hzrF0ZVPTp6B0y4GFlcuXYG5FdY9gcgwKtj72pO6mwCtBnr+4MoY5DlaYPVR9wmJ0gywcmfJ2py/x7PqAmBy8xYbzw+iAIME7tvZQ5A/n7FESwtkAAxKkhr+fS1gRqHRzz9li4xBXneP94i+8XnZskApUg9xPAbBe4p58xPwOblq2YddT8MJ6xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNA5xcG5R4h9hgBBEowVZpjrvEajtKUdoxsg4jnRibc=;
 b=c13pYrYuX1V0lPhC2YuIVSF7qvi6+FeNfHzV14HVSlr4sWtYpb1+DJ6yrXQmhgj3KsomfKS+mwjLp1Ae74OmeMdySLnzECpnfse1cZBBEpErNl2b8UExJVL5fWbApxffB80tbzxDKKgsPQtS7O/qGAnJa3jBoob195vWZ52CQvs0/GbNebUDBTgB9z0r1JmNJ9cTbYUF43op0C8fR+dGLLpGWQcwY1zr7tvDSm1TI4v3OXOWWQxc7jt5XyQGhEUwFOJ6IealLipaU06lCUNKSRqJTI8jsQjcgyA+NgstPPceMXMB+d++MywMqLT386UG5WFdxDrYlyuSwICqMZyxDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNA5xcG5R4h9hgBBEowVZpjrvEajtKUdoxsg4jnRibc=;
 b=KrnY1TS1DWQE96K6n7Vr6ADSRuTxCa/sIWIpehhksxFa3o/sfhgaCbEBxTKB9KX7GILwL0oIjmqktZJYVjRN4DYpB0KewSP++I+TCycPMENdt8MSzAM4nHNI2ryhqKVu8foB7SNHwOmOaOvOaKZ/Y18AoS80g0PI0sEZMr4rjNpyCfeVd0hUYW6kj1T8ySsTGuMEf3VvAcaIlkmVqzq5qL+/gWVM2VSQTbgLbb2Rgz/e0f5m2abAfxxhq5LpeGWSSjn2oXWpH3J3BI7AGKdXCenR4CHiUUbyMOGoWlMIdnNnU8IjEP/GUDpLX91Sp6pnXLEL1nrsMMHYWW7pZeq8vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM8PR08MB5732.eurprd08.prod.outlook.com (2603:10a6:20b:1d4::16)
 by GV2PR08MB9277.eurprd08.prod.outlook.com (2603:10a6:150:d5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 12:07:53 +0000
Received: from AM8PR08MB5732.eurprd08.prod.outlook.com
 ([fe80::e543:a83c:a260:602b]) by AM8PR08MB5732.eurprd08.prod.outlook.com
 ([fe80::e543:a83c:a260:602b%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 12:07:53 +0000
From: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
To: vsementsov@yandex-team.ru,
	eblake@redhat.com
Cc: qemu-block@nongnu.org, jsnow@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, qemu-devel@nongnu.org, andrey.drobyshev@virtuozzo.com,
 den@virtuozzo.com
Subject: [PATCH v2 2/4] hbitmap: introduce hbitmap_inverse()
Date: Wed, 28 May 2025 14:07:29 +0200
Message-ID: <20250528120732.2247150-3-andrey.zhadchenko@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c8094c4a-7bb3-4fb8-1eaa-08dd9de04562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l7TvAqx4EGWmrXp5DZlqtSwZc7WXDnR6fz3IpNKQEUQjet5Hd0+ZdvdeXyLG?=
 =?us-ascii?Q?RTBT7Ynrc8kLvkPd+vbqwIC6+lqR3IzqPsaM5RMuDgNZ3Cdu1YV2UTVHnxzL?=
 =?us-ascii?Q?tMdDJn7lLBskT2Vxgn8yNpkj5Q5mpDSWJA4rjEAI6yFXK50MjnEobQFR742B?=
 =?us-ascii?Q?ArTitnMz/RCLg5yZWANv/H/FYnTSEzKfwVCfWJv2OvTOdeMUuk/kamQv6ykl?=
 =?us-ascii?Q?yVuM0icD+USb6Mfq1QFYv/0I0SBx4O/QAkAw6/1TvIU6B2kMuWVGbLgUtgrB?=
 =?us-ascii?Q?uXuix7hycw6E+WzMDbATCYtM0pKL3LDoeFGEX0OxIqCcBc45RFMf83sAi3pR?=
 =?us-ascii?Q?UnzPgsB/QVA3N03DM8goXYMqK9OsfK+P9vR3w+sBnHL2YGBcwzt5HR9vtgxz?=
 =?us-ascii?Q?8JO3sS9h2OrUEjaXNmM18xD75BKHeo2zh6IBCqvugGjpzUrhEt4dWiI3Dftd?=
 =?us-ascii?Q?lwRZUjjZNOw0Znge7gkvARriD+sLwIr8LrvxQjtjlIe50dmY+K2IipLpugTA?=
 =?us-ascii?Q?P7H5cZAsnGo8sdqejOFPWZL6+lh8elHTsZPT7IWYdcIdAzj0rH04SL6eZbWY?=
 =?us-ascii?Q?UVPZcWsBupOIYnOJBgUyQjIUMIOtn2X4ZcIE2wVniNZpGyCyLp7Oo5aAfLJM?=
 =?us-ascii?Q?VPCFPkxV3GgKx//BP0/hrw7QYjTIaGtorp2f4ic+sp6ChsFoysyYLSxIqlXA?=
 =?us-ascii?Q?e8F5s7BvhsXaiEwkNIJCZq9NLLP78zG99NJYYl/ikQ4isi6zE2uUGQWSPbc6?=
 =?us-ascii?Q?Pr6kcJaEx2hTnllpTKpRJy2SCVJue7/ueSC027BjGzeMCbohvnWsPx7LtBH2?=
 =?us-ascii?Q?mFdUp43sEigPVxMeJVfbz8Rmn89l7oUch4hpWoaNeyXtG965u68juhXq959A?=
 =?us-ascii?Q?YupDMfroECQQFrQbCbnkVEQGICEfNs313bllAPb40KjBYWWm2JPr5rjKX1EE?=
 =?us-ascii?Q?jcblmwQGgOSEvtChBqhr/cXDxCR+bC5OAiCd6fuGO7BFLcP0TWiA9vk+tR3U?=
 =?us-ascii?Q?OJgFE8/IFwi5Xo99ofjfbu4vRVw3qIEyFUPchujP1cKQeCUYenqcIdL+l+jw?=
 =?us-ascii?Q?fSTgDPsgpg6qoNuZgb4KnJMdAqqzTJW8bbgnyMHWXaKfd9qjuX5RL/0RIRZQ?=
 =?us-ascii?Q?SusT/FoC39H7D1vAZDUogGVRC6cSRFdYWts5NEbNrFfTBwvTV3xC4TqzLkrv?=
 =?us-ascii?Q?DB4O4VVMcko3Z182+1GDvc5oV+Yh5fAvr30NoYXPEVjpxf9wBQiYeLX69y2T?=
 =?us-ascii?Q?TLive7EKgKrNa7YYF2WIeDcZlliCLkEWVhP1MmT+/2T2l6dxwPVsgaGJ48Xw?=
 =?us-ascii?Q?Y+jxMzLf094vSH/H7jSrE0ukSvVulYgdD6onY0bKG1L+HVaHVhMJi2gsbYds?=
 =?us-ascii?Q?z4PrmK65p2HusKR89osRpHxMhrdg6xTwNceglvgXVpU7HfyUBEHuOe9cHZAH?=
 =?us-ascii?Q?Ke8xAJIS98tdIRdYZ2idu22zGqwHxc5qbqtljai5KRvrl1j/4OSCRA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR08MB5732.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xIOR+HpY6McgX84UxCvCGiisUBR5p4mJ53Wdgo0OsnJCoPC6Bte9VAu3QKwE?=
 =?us-ascii?Q?XiajmI3d/XP+HQ7wh1J5DS7aUi4sxP9WfehiI8BXBCcN3jT54d5Le4l6c9lK?=
 =?us-ascii?Q?24KdogcltL6B+pm32LN9jagKNEqm0sNOo2WqvmPRGx7gh/Hgdl3l4r9ymLxy?=
 =?us-ascii?Q?BROcoUXAdNJ0y1FJ7qYC5K5AanpkTV2d+xVXml+3Qw+AdHPDdau+XOKaBC8j?=
 =?us-ascii?Q?gt6mTLaYGKkfFUyjIjRo7/9LDmLApPO3mrE5fRvDH5L024kzpuE74hiKgZlm?=
 =?us-ascii?Q?ff5j4mHfi/LJBdf3wshXZWIk4s6+cL2jxLsa0mlPufSvoMU4kCGsI+rECkf4?=
 =?us-ascii?Q?fCtjoYM4p3jC0fa2FcMgAbs7souIYAhysR5g/M+xp9xGkPR5hLz1aeZ/oi+a?=
 =?us-ascii?Q?VHv3qGg4TSlahUs7RJ0xynOvtfm5yy0CHDnaZcNCRUjSRFYr7uectUeJbxb1?=
 =?us-ascii?Q?waE8Rj/+s3Lx0FX2Rzx7/AnRERGx8OAt9ooPM/wXjBdA8evhpLdJ/qjNNV2t?=
 =?us-ascii?Q?dWDXwn4P2qh7TFTFTgxfggrzsGNxdPZ4hfq258Zab26jcI9JxZ1EeAwELhAg?=
 =?us-ascii?Q?QjfAbaPP9xkaxYl/80Tmn6jRRhqb0dUa1XcXRJreULfnu7CnGTDjExcO3zxG?=
 =?us-ascii?Q?H2H72gFMCzXQD4+NfKhVpIXh7m13FcxujjuiNUK0HaH6cX3xekQgmjtnZwiV?=
 =?us-ascii?Q?oTSmArKBHCzTzlN+GBVNDSsFF4LmuLGo+g3jVoTxsodr4CqbQVxXAN42tEzJ?=
 =?us-ascii?Q?QL1DdkLrsTPcx6qNFNkysAe14KUJZY6R/OevEbWuxza8UIXw+yZhYgAq5rAy?=
 =?us-ascii?Q?Uf6jgnxO3YcO+fS8up+jMPCycgfbQxWnVsij351PKN4mqxjicg5YkCDw1cnK?=
 =?us-ascii?Q?GTKBEP90IXROG5XBEKP/2MIFQGYsCZL+hEAV3vdqZnS8ZfaTItPlA2aw7Brb?=
 =?us-ascii?Q?zjxjqM2XFAGmyuHAUr3spB2VCeohxdaOQCnxwHx1XvN8vLQKWPWdUsOzCEp4?=
 =?us-ascii?Q?mpv1Wuy7U/R6pvP+cmyBUXepb73AeIULsYieSH2N4Hx6kvk0prBcZmUwANm2?=
 =?us-ascii?Q?mqjH3RJmFgVcJ+7eouRPa3mhlF8fD3aiv4vIJCu9MVEcuw48JeHgHmJiwaGR?=
 =?us-ascii?Q?LNvEIwDc4mqIVwnboAMQCpad8eCqhifNhgMH2MXDFxW8bJ3YBAO79rFGYfeQ?=
 =?us-ascii?Q?8M7+7Ed8gYhuFVR6gKLz2rOleXx+tz3Y6w5Qh96FTuR7X7ALDxWcTVT2lwaE?=
 =?us-ascii?Q?VY6kmTNRXxcV3X0eGbI5RCLKikXMbqTR1H1NffXMf77htYrCKf9A35ItHum+?=
 =?us-ascii?Q?O5aqPn5E8SIncth/TNxxSvCeFI/xoHbdngU4uRmJiEu0tlO9tksSZKxd0bSR?=
 =?us-ascii?Q?KYd76temKoM9YeAenHyJpPt98iNGJrufN7xkV3Bn8D/1k5YO1pDjhfV1Ybln?=
 =?us-ascii?Q?GgEEm8iZJB6D4dlWwS8jm1+SknY20fGavWp+K86mjXdIzAgl32Jh1Nr9Fjza?=
 =?us-ascii?Q?4nbd7DKI4VVHyI89L0Ai7z1DsmYDR/rTs7tSNNONEIUbOOzDP2aVMK1Fz3d2?=
 =?us-ascii?Q?IJQzeu8SzaPfsVOhCfCckdJG7PUyBiMLhZizX8tTlKd//IGBIELJ067onr8+?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8094c4a-7bb3-4fb8-1eaa-08dd9de04562
X-MS-Exchange-CrossTenant-AuthSource: AM8PR08MB5732.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 12:07:52.0398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayCxs7TVrCa4LKTiPFEzHC6rZ+Zz3JDid6MCHZTWyMbQMCv8mj7efFIRCro3cIbX9pJlvf2kpxQakv5dNAeH2otx36OjT30Qglp7AHX4YcE=
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

and bdrv_dirty_bitmap_inverse() helper

Signed-off-by: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
---
 block/dirty-bitmap.c         |  9 +++++++++
 include/block/block_int-io.h |  1 +
 include/qemu/hbitmap.h       |  8 ++++++++
 util/hbitmap.c               | 15 +++++++++++++++
 4 files changed, 33 insertions(+)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 13a1979755..80ba8bd3f0 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -888,3 +888,12 @@ void bdrv_dirty_bitmap_merge_internal(BdrvDirtyBitmap *dest,
         }
     }
 }
+
+void bdrv_dirty_bitmap_inverse(BdrvDirtyBitmap *bitmap)
+{
+    assert(!bdrv_dirty_bitmap_readonly(bitmap));
+    assert(!bdrv_dirty_bitmap_inconsistent(bitmap));
+    bdrv_dirty_bitmaps_lock(bitmap->bs);
+    hbitmap_inverse(bitmap->bitmap);
+    bdrv_dirty_bitmaps_unlock(bitmap->bs);
+}
diff --git a/include/block/block_int-io.h b/include/block/block_int-io.h
index 4a7cf2b4fd..7b2642af36 100644
--- a/include/block/block_int-io.h
+++ b/include/block/block_int-io.h
@@ -109,6 +109,7 @@ void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out);
 void bdrv_dirty_bitmap_merge_internal(BdrvDirtyBitmap *dest,
                                       const BdrvDirtyBitmap *src,
                                       HBitmap **backup, bool lock);
+void bdrv_dirty_bitmap_inverse(BdrvDirtyBitmap *bitmap);
 
 void bdrv_inc_in_flight(BlockDriverState *bs);
 void bdrv_dec_in_flight(BlockDriverState *bs);
diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index 8136e33674..7cb6d6e7ec 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -350,4 +350,12 @@ bool hbitmap_status(const HBitmap *hb, int64_t start, int64_t count,
  */
 int64_t hbitmap_iter_next(HBitmapIter *hbi);
 
+/**
+ * hbitmap_inverse:
+ * @bitmap: The HBitmap to operate on
+ *
+ * Inverse the bits in the bitmap. For example, 00011 will become 11100.
+ */
+void hbitmap_inverse(HBitmap *bitmap);
+
 #endif
diff --git a/util/hbitmap.c b/util/hbitmap.c
index 16674f33e4..ad083b2927 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -940,3 +940,18 @@ char *hbitmap_sha256(const HBitmap *bitmap, Error **errp)
 
     return hash;
 }
+
+void hbitmap_inverse(HBitmap *bitmap)
+{
+    int64_t pnum, pos = 0;
+    int64_t size = bitmap->orig_size;
+
+    while (pos < size) {
+        if (hbitmap_status(bitmap, pos, size - pos, &pnum)) {
+            hbitmap_reset(bitmap, pos, pnum);
+        } else {
+            hbitmap_set(bitmap, pos, pnum);
+        }
+        pos += pnum;
+    }
+}
-- 
2.43.0


