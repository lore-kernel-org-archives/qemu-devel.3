Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5F8C55184
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 15:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrGyt-0001b7-DU; Tue, 04 Aug 2026 11:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wrGyr-0001aY-U4
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 11:23:01 -0400
Received: from mail-swedencentralazon11023103.outbound.protection.outlook.com
 ([52.101.83.103] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wrGyq-0005Lb-Di
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 11:23:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0eccT6+YUbX731RUBWob2siz1hu7BLjqKtAVlzH9eiJG8PbhEJvl9oJCwa8y33MA8BX3oDLYWizgarihKmaGrvNyf1fAOXB3gnzv5+SoJW+XyWqm2G81POhzrPN0bHoep0v1udukyM7/2krQ6o8rw+yf7arNTmKYZF2DTSQCmUO2u5U/U+821BDbrO73VTh/zd2lCSqyO1d+WILjlYSznjwFLZSLqe7UUpEaRjBLX0gbcnXD4qTsN9xpm0rld6TpNX2ozVncNKH4TAhURkWFt3X+Y8qxGXqWV7mn7tQfJtSIFwuQguqX61mMXpNbPpEiIbtaWbuMtRSH8QZCY+WEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JKt7Fv6D8ktmtyfDf8FIxaMiq78r4n0C8q3HHoz7ag=;
 b=CQChImUMtEO+LQJ9m1A8SM1IJRMWzB47pE22dM13w5m+pPCcAXZbb2uvgfKItduyPGbsfhfMIKJbd74CaNIiympejYs+vNTryej+bZHGNLYvc5noAfnCq47PZhroTjFvfY0CC8Bf28qWVv8a63whMTYd8BouNThW833AJQpBQlXFNKVjRwEP126iEkTvfAOrKZ6187O2B6K4OGOMS36W0wG/AP57cbZKG8jajUQNlr0fVXiDXJRJ5wB43iyaUq6/PA5gX4C7TVEg7TQ0NJk9clv6mKHR4MrOz1U+y2YfjjYLSYepihFX+9AfY8Kpb1GYsoJvWfCBhJfq7EksX/+llw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JKt7Fv6D8ktmtyfDf8FIxaMiq78r4n0C8q3HHoz7ag=;
 b=l20DJOujEb1jhi2cQYaokIWH9V5l6OO08onqcrkc6Q2UHVn1i42xw/UCbOhTvilCTFnFxvqzC3D3XqybOj+5B6w54L6FeoJyanzqbQxIKm50DkBxoWD+yH78xD2l8x206GWJlQqkJ/meLK9ONsTmFQ5gLRuTiHOCvb1lAJNjv/S4rnAq2ciOnJYrnJyIl2dsIsU8IGhi4hiHHOkl3p5ZbFA2jr/cjFIK5NY0K6h6tX8vUTbLZ57KS0wgh7eZm0jUBCm4EkecmsuEUmsj7AQDp2GfAX31cZrYX/Khkx/ODRdnnZQDgH++his94kSwm0hkeP07gjKS+uf/gjLtOvWGLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB10317.eurprd08.prod.outlook.com
 (2603:10a6:102:330::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 15:17:55 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 15:17:54 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, kwolf@redhat.com, peterx@redhat.com,
 andrey.drobyshev@virtuozzo.com
Subject: [PATCH 3/9] scripts/qemugdb: coroutine: Only attempt to restore regs
 in coredump
Date: Tue,  4 Aug 2026 18:17:37 +0300
Message-ID: <20260804151743.937694-4-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260804151743.937694-1-andrey.drobyshev@virtuozzo.com>
References: <20260804151743.937694-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0148.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::32) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAWPR08MB10317:EE_
X-MS-Office365-Filtering-Correlation-Id: ea9980d7-64ce-4a82-b7c6-08def23b8ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|23010399003|366016|38350700014|6133799003|5023799004|10067099003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KmGXX9sTFCoLkaEpGpannaMugpSiKQdnOroiE05191K0jBa07quLgf8LoWL8b+67XSraqiFjOcRYFzcy5yi7XoJeS1lmdREbVBmdeBEGApATzUs3aarYot2NQHyZRtK7WE1h81cjHQGpTwmTpcnTuxMfpY787JLbtOrrhlUtFtqa4/cSj9u/oQiTBmKBbD9KBo5vcpvl4AsrnOadheD0gXcDtaY9UUDinYtLoAW+WrL9/d3aoLv0sGjPrdlzxixwffiSJd5nAm0APThqlQ8Nevb+P1wPk4IoOTRnWVZ5P5zDzAvCOEE4j0eFHqgDQC+PCtDWRC5i333gbO+pEb7QcNIem3eFUnQqh6CuW4Aw2ttwQkFcBZc68I5NI3V8paenuCQ/UC8OMTHVu96xoEizY4mhkHhnQmnHHZm9ge7YGHkZ5/cuLsRJDOuhW1ZPTm5z7j863u81ARCDtjw1uwu+K56UM+BgsB+LF2qi4W240l5LxAuddXGP+8Iz2cnMahN3Q9BOB6I0eo3wkRNGvdAJ3eIu0pNQxCzEUDSBH7itdkG07kKd9esIqqG6/65t26qCEgkC1qmpOhkJjMwQ9CrCPuhKnX6e7uEb1WK4JERDMW0JZnOk/nQkKHRWea/Z4FSjIPZT+L/Annr6IgM3GafCTzOCKPlts5/uXRzAtrVa5VKdXV8Jjw5QfqYoqEa8ahVnbFrnKxA1lrcZHRfZ1NQGrBhNG/3gqaFJN61OA0X+fnI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(23010399003)(366016)(38350700014)(6133799003)(5023799004)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F68RnJZwS6ndnCgjt6pFJ2CDfNhZpdPb89Y+zu5zyFY74OfRfpn9YAwJL9BJ?=
 =?us-ascii?Q?Ea2JybqAqDRyhmRZoisTfRJxGfBwjIf/0MBpgk2f5o72IM9Y7uw9VsUbvXho?=
 =?us-ascii?Q?0V27+g9Qu2Rb12QFaamUyvVchS4V9h+VOW/akRy+Pt6jbiwo3SfTkeR1hJnG?=
 =?us-ascii?Q?47ptktziL4TAmRC2zfSLy0DWUpE/hGDtaLFgqmonBlIXL31qfxqG+p+N4t+c?=
 =?us-ascii?Q?gfdHQvhvYOEGr2qV8YrUUWrrOf+/WFN3iv/PsWsS1E0iePNNsiHasPJva5y7?=
 =?us-ascii?Q?XOaoLZj63nMRxdpTM6/acPWTgz9K4g0O4QvvkJ2HObojcInVvbpKgMqYxi4F?=
 =?us-ascii?Q?YFyk0u9M8AWOC3Gf+PA+qWAuuRCw9XU+62ChbjmRUyXu/AdHVEBKawhWa3Gj?=
 =?us-ascii?Q?rkSF4AjxEGcES9Tz618u9aQOq0C41SLQVkOFkP75qXvDw5APDll3O8CHt6mv?=
 =?us-ascii?Q?UN59ucCfmpBTt1/O2sahQ7L0j0IeSN6ptioQ86yDBJ4naa/bBfJxLOqlFIIB?=
 =?us-ascii?Q?En9KiR6EP5x6ZBhEYYZHCuG2fBCu/f7VDHZ3gmfEIHy0/f32GFZh417OoL0S?=
 =?us-ascii?Q?tGXC6MlCO41fr99Uz3KNwvJm++Hg9dxRQtn+RqSLY+D/5LyeS3y2ky8KLTgl?=
 =?us-ascii?Q?hSic839eFNDuFF0h0Smd6D5MdSNtyFD+xE78zt8fO3levT4/6BHOTZEgcLvK?=
 =?us-ascii?Q?HGFpsHpPl48WtHwlZONLRvBbypKlf9nGOY+8K32TUnzTCKc8GBwNzt7TT5ng?=
 =?us-ascii?Q?7UrPOrXcj5/uM1fWSlmCHEprHBmXXWV83xr3GzUY6MDqjcoIit/EHjWVL7/3?=
 =?us-ascii?Q?J4N+KfTH1F3+fJIKuDD0qHVNqSzKMoEx5vCY2xf8uxMPbgt5I1S9PyCud0Jy?=
 =?us-ascii?Q?TriAjffuyHcEtzP3hDIy1yNyCFr+6cuecj/lz5jWiT2nsggG8465vp0+rEA0?=
 =?us-ascii?Q?tuLErPuyJQ75bziji9nLceWKsQVZ1VG0023DoVm8pPSskqg7FN1/dYECCt+O?=
 =?us-ascii?Q?4QDjtBv9AHN45tz0Qn6wbEg4tq3fY7bnpaVibiC/4+I/uwoVEDiNzVSR3iGI?=
 =?us-ascii?Q?9f/piBdJGoDQL/nwDcv+p96vfUTydNVfD2IYp1TAMmBcPmWUYH/Vk+dcKlpP?=
 =?us-ascii?Q?2dLzyLfyZmvAaICz8Ult11yY47fyK6oNjR2abi94dKilY451/HmNWu8LotdY?=
 =?us-ascii?Q?wceNBwBFOZ7tKPhRFDhaBrprKOm9sem+/t7KORTmq8/jBL8OG2DN4VfievF4?=
 =?us-ascii?Q?PzXfy55RpbqIjR81gueTDPV8ldttETQaQ2YTJqzE/cDr+eaARmb5pSK0nbwo?=
 =?us-ascii?Q?zw9dcK1E4qwK3Cfea5w+z5Ud54xzskhQ+F0uxFXJMkHEtzlkcgccaSOm/FS5?=
 =?us-ascii?Q?xPgwyWKBriUZ2E+xaZXHOq15CJN/60YeaoWEOVytiu4sTKAz8R5KImRrIUn3?=
 =?us-ascii?Q?kdm/gnrHD+MBzfi/MnlRih8s1WPYda8q9mnEd3bvZNLbSyErzkoxyVgbQEpL?=
 =?us-ascii?Q?ewxXZIFcxhqhSXciaB1yUCQX/tEfoLBTsmh7vEeqURVVoqDQrmJ0TEoaEhWa?=
 =?us-ascii?Q?MCWfrPfJKHIBsYayNwJYKE+a/z/b/c1Jepm3hLL5o4CoYrVf2BX7A/XVldFk?=
 =?us-ascii?Q?88Ngq8sud13ksJ9S4tXBjhTOvYSSrHE+hs9XOBR8NCjFSGYBHocSU+C+xI8Y?=
 =?us-ascii?Q?vVw7g/F7ZsB78bb8bgiIIMvjSH7mhJVHAkAgyOPTgiqAaPstLoo7gfQkIO/6?=
 =?us-ascii?Q?9GFRuBoMVT2mwLZBes4p4arzyhO251U=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea9980d7-64ce-4a82-b7c6-08def23b8ec1
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 15:17:54.7386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gw+8ycRuYaf5QHLd+eYS4ZttRr9WMG2Aj63aGvOXK2DW7lQ2+tnwZb5xrk8u1pd+ubvbUKBB8/jAbyweQu/oMrnEn2ntBIQdlBVs8dJjqZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10317
Received-SPF: pass client-ip=52.101.83.103;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

When calling 'qemu bt' / 'qemu coroutine' in a live process, we get:

    AttributeError: 'NoneType' object has no attribute 'restore_regs'

That's because for both commands finally: blocks attempt to restore
patched regs unconditionally.  Fix this by guarding regs restoration by
'if is_coredump'.

Fixes: 42f3c143c3a0 ("scripts/qemugdb: coroutine: Add option for obtaining detailed trace in coredump")
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 scripts/qemugdb/coroutine.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index d3f31bab9fe..649579378db 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -354,7 +354,8 @@ def invoke(self, arg, from_tty):
             bt_jmpbuf(coroutine_to_jmpbuf(gdb.parse_and_eval(argv[0])),
                       is_coredump, detailed=detailed)
         finally:
-            coredump.restore_regs()
+            if is_coredump:
+                coredump.restore_regs()
 
 class CoroutineBt(gdb.Command):
     __doc__ = textwrap.dedent("""\
@@ -409,7 +410,8 @@ def invoke(self, arg, from_tty):
                 bt_jmpbuf(coroutine_to_jmpbuf(co_ptr), is_coredump,
                           detailed=detailed)
         finally:
-            coredump.restore_regs()
+            if is_coredump:
+                coredump.restore_regs()
 
 class CoroutineSPFunction(gdb.Function):
     def __init__(self):
-- 
2.47.1


