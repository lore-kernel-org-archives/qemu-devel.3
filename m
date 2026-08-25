Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FA3C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 17:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyuqC-0005gW-1O; Tue, 25 Aug 2026 13:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wyuq8-0005gC-78
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 13:21:36 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wyuq6-00058O-Kg
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 13:21:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWpB7LrQJb+otXAenI5t2nCKMa5YpQt65/I7ITNDAyv+DLvrZd/f5WQvjwSzW7hhNGDKXJ2vMVrytSF+TK/MRr5LAPZCogOWxqfKthYzb9jOc767wMEdJA+JLtlaKb3y1Smi2KNKsioF+vk/XKuCiJ5KMAAhyNGaUcltyQiibaAcmFXOTFFHxgjY30LjMAH0eM44z8qb901OK7gqJEK5OeJ5hjzzCnptFwrAXVe0JRoONBiLhKgfhc0pEpizLFmN9qXymps5Ri886tahgKTfBfDqsIanr8RUA9n+R9HARD2+GWf5oucoOHwQmgjn1dm+WTfyH49phDiQyXQfXB1/Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlArGzS65w65k3ejPuGa8vJ3QekM/Pu+4o7teo7qfdA=;
 b=l81i2ys19nl/JIjvaLkBY7L+NPJLtZaOV0SmOc74T6BOcKYAUu7afPTxyh7WE5txzQH2O4dPjgkqKXxu5XLCJQrS5Lw/OkPW4qHpssdIxAZEwLIw3RHOFfP6hNqyRGfNzVlmdEGCBkyE2zIkxtt/8Wa0Q3bCZYcvzMVGtHE9beK8vOXFlcOXeNY4t8sv3QcXArn40LtfALa/vVx51ENFJot0FtuswQ4Ednts7AOZkYXV/ikBSVJpTnw/biQRzA7oLqVv3MpQqVs2wAGVb8PIBrFxF109SL5OeSz+jofTDr+A3G506yoLqeitFRZeI+yGx3zbIbmSQtmHsd6iUrtdYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlArGzS65w65k3ejPuGa8vJ3QekM/Pu+4o7teo7qfdA=;
 b=cs995QVzCqYOBNnLHapKU4re13Qp357C8PE+y9hcULQ1rr9DZ7ox7uXl288l7WKlbB1XRTP9hEOUJs3B180kN5YogwzJjCCQMibesI3YUqBQlUFNwyjI5pfDetKUG3iyS8D9zuY0UHirqgTpnTFUTCgFrWD8r8eaOu49FzgDZaP/npRWWcf2gBNE69YEImor8Wa1xNtSvh72Zvz9lJOUTqFEXUnpzAikDauzJhI2zEI0hFQazdukOe43JAEfg/fFRJxARSxxUARCguIfdQXfCXA6BpsSKB+zCvE9F2udwt5si667lmJHqJhJtupLHTLi+0cmLmDjObPb1XvTA1wQfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PA4PR08MB5902.eurprd08.prod.outlook.com
 (2603:10a6:102:e0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 17:20:59 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 17:20:59 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, philmd@oss.qualcomm.com, den@openvz.org,
 andrey.drobyshev@virtuozzo.com
Subject: [PATCH 2/3] hw/display/qxl: validate replayed commands in
 qxl_post_load
Date: Tue, 25 Aug 2026 20:20:50 +0300
Message-ID: <20260825172051.435372-3-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260825172051.435372-1-andrey.drobyshev@virtuozzo.com>
References: <20260825172051.435372-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIVP296CA0001.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:357::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PA4PR08MB5902:EE_
X-MS-Office365-Filtering-Correlation-Id: a93cdcff-9fa0-47ae-98c6-08df02cd3b27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|52116014|1800799024|23010399003|38350700014|3023799007|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0d+ZHPsBC+n7GxN6rjh9bkOP1KMNWhg4NOiFbgkx8n6CJJV4x6pSG6R69ESw7wjN6GO5BjbJej++hakhBEWQiBKyrVTFXeWv7sdLxKQ9jLrtVhJi+irNH6EQcU6V0Yh65bk5bJw+DPMgh6fDDRbFTNAgJsp+VFpy5fqC+/HWh72ZMgwv4LrMej1UB1Dz2D8uwuBXLymj5BIh+Nssb8BCIce64SirUyTMk0UNHh8Jh1AEIZk52aUog6eQxaRJswfvWUbIcgSS7+8cnpekxevWTHud7EYTdFIpgi+VExcuIDKOU8gJzjAwqqO3trZBUkQLCmCiQsI1dXcqchWPw0NNQ50bgGB1noefrh9eHnGfliCgHtg3ulzas79axMjW+jihBMKut1mrikH7lk6X/LGGhrEbMa5fYeSxzk/N0uOSvxEhjNXdXVGM4Twh4/Z8T6q6BSk5+VHitLAomTolJQZt2GFjWBfX53QkBHbBiJQ3xGlIiky8FkXtKJr30KikypvaTxbWp1D/Jkuxa3/VWsSkSBWfkj7OS6ERZvdFdOkJUz3WRkRsbwU8XOmWM9mbx3nmDgYGO8DumFxjRsumvwoxYKueWkRJv4C615HqWdVU0cdNspMy7jq4Z1UPA9atCh2QyMhNdEWYXBNXZ+QrKf9pl358Er0tReti1uT1l/3Xew/+0DcJMZFde1BXLfoP9bR/+Dvq2bIQu7jdpdnvJLH4eCSh0GQBtWJGdMotgJHzGFE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(52116014)(1800799024)(23010399003)(38350700014)(3023799007)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JbybY4AknGViSzvLYl5AkwARUH7yWhlv9ReROHgc8Id448e0c8Vepfi5tmkT?=
 =?us-ascii?Q?pyqg4ChGwUp0/U9bj5xvzfMeMxee4CCubbl+cIOGoGHJ4KtGFzsdAprsYIpn?=
 =?us-ascii?Q?rholQgYYwd6XXoxMleD0OyVsjs11hYALHl8G7PJVD37f2++gIkLNCYV3zFyx?=
 =?us-ascii?Q?w4db+ShF2QPrikpG1Pdjay4axZJNLCTaIMC6sL3QO/eYJrfOyMItEHLUVJiz?=
 =?us-ascii?Q?NVThnWnZrad3AU377oSxo/kaMK4ikupqMDm9adgnd15oI9eIPB2EiioY7EAG?=
 =?us-ascii?Q?sIcdAl+MItYJKkOPx+ptKphbZ3GKi5lFzfw3cVhhk3haN2RTiCnnoE6vQ+pr?=
 =?us-ascii?Q?VBTyzV36JKHg0oqf84bXyszZSdJrc0huU1j2Sk+l+gwZBaVtjn6GMA5JdMVr?=
 =?us-ascii?Q?KDsBYmvahvIfFANac6Q3cfV7iwy32+zSH83HaBdgfgOwDp9NOrNzfJ2fEWcf?=
 =?us-ascii?Q?aUCOti2PVH7llz/UYJTZFx78g+Arw8GM8pqFBKnleuwbdXp9+6w74GmYX4Rn?=
 =?us-ascii?Q?2Dhb1ff9rZwL2Sy8D2J2F1WQ5enUOuiN6S/xtsJ/uM3XxO3SGIS87YLjMhhu?=
 =?us-ascii?Q?OBPSB9XPRG0t7Jv8sb/P5HkjVegBJMjkK6ijYerg3ONR/7wxzByBwnmZnErx?=
 =?us-ascii?Q?nI4W9nQr/r51HaEJoPTfwB7i91pR1deD3idoXSd8EsAQGoeKpzt+ZiVhj17M?=
 =?us-ascii?Q?7/4rc1xlLG1Itp4dotoE6fSraFw0e35qfdNUy3Qclj8YZtXQwWKFyxxQsgf8?=
 =?us-ascii?Q?S+xq/HK6g5MPEN69wN7JTRwp5gdhKp3QLHBZ499lnNm+pmShFaCVVxIZ1fnG?=
 =?us-ascii?Q?nFRYQX/rw8IPqSCmnLlwEXVw8ZCsZphwQzbjLmYXJackTVN7evsDul3tOJBZ?=
 =?us-ascii?Q?nWenh7MwyTWwSFeB6RgpxbA97OSwijw2eK+m9zsVXYoQtY1Bfa1HleNAWmXB?=
 =?us-ascii?Q?RJO/Y9gY/MJrC8UlSBbE7THo1DpTWLCRV/fJM6Z4tPT3MSpUtVH3RJm4xIZb?=
 =?us-ascii?Q?IfcAvTxSHaa0HzbEU9QDJ3biDBkjyRqowcq5DvTnKO5DmcoHn/J/foZQUMpQ?=
 =?us-ascii?Q?nhOgPE1xrr0CUkDIzWbJFYjFeQWi87En1+c1aAkEJB7MYUDhnW+y/ACdthlT?=
 =?us-ascii?Q?y4JCWAJY6a9Ujnc9EghfzsySHkVauMCZ94uxIgTSjxAajAiylacGIHaqkDUh?=
 =?us-ascii?Q?8U1kTzK0rx01hvACvjCc4yD/zcc4uMpZVgw8Ta8lggJ+JOfhjnF3nE+ZlPWX?=
 =?us-ascii?Q?4aplWJqHPu+8xX9vJI2ic+IWdeeiPuYlBpk3oL5Bnv60b3MB7Gl4yS7u85rt?=
 =?us-ascii?Q?AG0WhgX8LLGhySoZVqv78VMxagZpmkpdeM+mtrNQM//QqMJ1xvFj3Qoi2SjE?=
 =?us-ascii?Q?IQGkv/Y86NLYg4vZtEepk35jHp0XurCM8xD/dczyMIJ866PfwH3jW3lw2apj?=
 =?us-ascii?Q?owmn+JEkNRqb8pVGf40/YAFECcvPLSijD6CzEoj8T5XxodFnT0WDh+VliTNS?=
 =?us-ascii?Q?5YXVhVHyJyPWotA6CfTXyZlFE/YIIYnZrcgDxitL4mr8ToQjMngMSrOo4vZE?=
 =?us-ascii?Q?+YQBIJKiE01mC1sL7rt4bPiTPxX7vUIlZBHrmrMqHthLdcV6XJUkWaiImLQ0?=
 =?us-ascii?Q?BHoaE1HekZxE7Q7c7ESnXGXqJ14hybX1Rug9iXtp5xe8l2QSkN0qUDnKC8i+?=
 =?us-ascii?Q?eKQuVSAUblDDaY0KEvouBFiNpxEU4EgmdEkPXZwU5rgRzyOSP0CDp5QiHZjB?=
 =?us-ascii?Q?sRSvw3l5UWIi+EhUXRCwKXnqgolr4nM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a93cdcff-9fa0-47ae-98c6-08df02cd3b27
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 17:20:59.5614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yg56s/0yPTOHunlF83UO2SCs20cgqKCQZPMrOUha2LHeGSrbsWmKDhYgzqpNgwHHbyFp6w+yzmH8C9q7m5grKRHzaW3cJ0fDCFDcbnCC7Hg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5902
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On incoming migration qxl_post_load() replays the tracked cursor and
surface commands by handing their guest addresses straight to spice,
without revalidating them. Those addresses were checked when the guest
submitted them, but the guest may have freed or reused that memory
before migration, so qxl's tracked pointer can be stale. spice-server
then re-parses the command from that memory and, for a stale cursor,
reads a garbage shape pointer -- aborting the target in memslot_get_virt()
(again, spice-server function) and failing the migration.

Validate each replayed command with qxl_guest_phys2virt(report_bug=false)
before adding it to the replay list, and for a cursor also validate the
nested shape pointer. Commands that no longer resolve are skipped rather
than replayed. report_bug is false so a stale pointer is not mistaken for
a live guest error, which would needlessly disable a healthy guest's
display.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/display/qxl.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index be620b9c94d..b9b19849738 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2329,6 +2329,37 @@ static void qxl_create_memslots(PCIQXLDevice *d)
     }
 }
 
+/*
+ * Validate a command tracked for loadvm replay before handing its guest
+ * address to spice-server.
+ */
+static bool qxl_loadvm_cmd_valid(PCIQXLDevice *d, QXLPHYSICAL data,
+                                 uint32_t type)
+{
+    switch (type) {
+    case QXL_CMD_SURFACE:
+        return qxl_guest_phys2virt(d, data,
+                                   sizeof(QXLSurfaceCmd), false) != NULL;
+
+    case QXL_CMD_CURSOR: {
+        QXLCursorCmd *cmd = qxl_guest_phys2virt(d, data, sizeof(QXLCursorCmd),
+                                                false);
+
+        if (!cmd) {
+            return false;
+        }
+        if (le32_to_cpu(cmd->type) == QXL_CURSOR_SET) {
+            return qxl_guest_phys2virt(d, le64_to_cpu(cmd->u.set.shape),
+                                       sizeof(QXLCursor), false) != NULL;
+        }
+        return true;
+    }
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static int qxl_post_load(void *opaque, int version)
 {
     PCIQXLDevice* d = opaque;
@@ -2367,12 +2398,17 @@ static int qxl_post_load(void *opaque, int version)
             if (d->guest_surfaces.cmds[in] == 0) {
                 continue;
             }
+            if (!qxl_loadvm_cmd_valid(d, d->guest_surfaces.cmds[in],
+                                      QXL_CMD_SURFACE)) {
+                continue;
+            }
             cmds[out].cmd.data = d->guest_surfaces.cmds[in];
             cmds[out].cmd.type = QXL_CMD_SURFACE;
             cmds[out].group_id = MEMSLOT_GROUP_GUEST;
             out++;
         }
-        if (d->guest_cursor) {
+        if (d->guest_cursor &&
+            qxl_loadvm_cmd_valid(d, d->guest_cursor, QXL_CMD_CURSOR)) {
             cmds[out].cmd.data = d->guest_cursor;
             cmds[out].cmd.type = QXL_CMD_CURSOR;
             cmds[out].group_id = MEMSLOT_GROUP_GUEST;
-- 
2.47.1


