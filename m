Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13048C27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 23:38:10 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFb55-0000W6-R8; Fri, 07 Jun 2024 11:00:40 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1sFb53-0000Vf-Vb; Fri, 07 Jun 2024 11:00:38 -0400
Received: from mail-he1eur04on20721.outbound.protection.outlook.com
 ([2a01:111:f403:260f::721]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1sFb51-0007T0-K6; Fri, 07 Jun 2024 11:00:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQRgBIrqzotdY+UKVVgcsNS4ymlj12CkTNgN5NXWiiPiLxuthb1hrgOlr3p6FETPhXLDWBztBUlQRkRRPhS5coCpC31EgyT4+uup+SW+n13AFqYEC014tj6ZZPYRNWq4HoawEuYb18CXLkP3a8CH7ei2QC2az1VqmXlHvrQzbw8SBxwIFtnHfMl9VuV7tGIQE5mRVMlBdcX5sMrRfc4M6NvCd4G4+EdYhJQYxu/T5kXQjSOQdIcHGsO8bxAxdznGQNqHv1iXCFUXGRKFq5xrc//s0MdAVeCcu2giqQilfNIETyGx+FrsvsqZrqED+TAI/laBkOfreVLrN8QK4OBWzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdnHrKrY9dARdDaugMOOW83+AVtVGc9qAaOLohRp5kA=;
 b=Ht8dHJvpH23tws9K12uKJocn/2WA0b9809G2dYCTferYNzBwIEFsIkgmahpivjQK8Z4maB9hEOfF5x8+Iqo88QEW0Ai7FgNZpucgjCiRZmxdCQcDHsR0sZs5joUUBIvkAIbjDnBDEnmtR5w2MZRKukq2hMJq89oi09A3sMAcCR9snz1OuKGHUNDfAbdpCedQ4ARMbb5piihd3S+opBxLtviJdZfp6OeowunWVp9cYnarrTY8YxGnQ/DzOC9gJpUAxYrx+4giquiF1wH1zBNeAQ6qRikXEz4ypfAkaV39voOngPz4Pv/qeW4VjUEJpmVLWNvuvJTctelCNhHVFd95yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdnHrKrY9dARdDaugMOOW83+AVtVGc9qAaOLohRp5kA=;
 b=uII+oSdsD0L6GOS+diRJ6lInJW8hYltHCBMvjUZuwz/980zdLgsaWYH/1UkoHXWvmLsg+ynKYArWtoOaF5/6vxh4gvpSYFM9DsoWzbrxK/CiX9sA0wydQQxsfXa0W7cSa69nFyqLxQDQ5NxXipOaZJVJQNjxNFaCXQAcjdxpvQPiATQYm54ukMBJ3l2Eneuh5ySkcxgxJhpqsfe0CgB6D1saZUpeT6nLTUuPK1/40cSNoWQL+HcZ0SCL/nXyybizEnXgHiGBPmYDPdqaSOEEztFmZPNEtLlkFp/i/TTFUgvDqbGRbC4q0phBhH44ufiIAu/LnABHqXfr6yCYeHYFHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by DU0PR08MB9395.eurprd08.prod.outlook.com
 (2603:10a6:10:422::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Fri, 7 Jun
 2024 15:00:28 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5%7]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 15:00:28 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com,
 eblake@redhat.com, vsementsov@yandex-team.ru, kwolf@redhat.com,
 hreitz@redhat.com
Subject: [PATCH] nbd: Prevent NULL pointer dereference in
 nbd_blockdev_client_closed()
Date: Fri,  7 Jun 2024 17:00:21 +0200
Message-ID: <20240607150021.121536-1-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0029.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::29) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|DU0PR08MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: 25190286-e82b-4cec-b2ad-08dc8702917a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|52116005|1800799015|376005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VG4yjAvv0u1WNu6IWgsuSGsZ9ZvqZFvpNJHD2vrYJuMwGTwQyrd4TZJ94vlv?=
 =?us-ascii?Q?mKGwaTElE+CcDlPJQrEX+eD98Izz6uABCLsFRR9c4EXtsVuFPAdGzw6Cy0No?=
 =?us-ascii?Q?jFE5fg8tpLV3+aNJkLtbA4DFxAM3epwsCP+Wp6U0Dcb997sOV6Yns2rJWirQ?=
 =?us-ascii?Q?3QcznJXlrzvVL3ai1q8w2OJYCw+CDq7ESXWu79j+mulr4gb4N8d+1TQPRSy7?=
 =?us-ascii?Q?Cs1RL+U8/nCtIIVQuUjUHslLD+uf/x07ysUgePgpDwzCPbe5Eo5py6eROmpo?=
 =?us-ascii?Q?Vwc0tm4yD6mQc09zNo25ZrVokWGwvCQRky6M4NSBv+Rj2HO8Bb6yGv2C7ZA0?=
 =?us-ascii?Q?3ZGj2ND0Aek3D6ydHnlEStZNmbGP7nfv0gLEZRu7eSYJcMXYCTxndCavBK2a?=
 =?us-ascii?Q?k9BlgL/Fb9TUdAAggf1fvWoR8LtyxdOZUydnayA83pESLZe9WEjgVJY3F66f?=
 =?us-ascii?Q?YWRhFy0eBSjNRaRtl88oo/o8EgsnMyEtFV8xkWcUQBkXKFwr0fgG2VUCHiFw?=
 =?us-ascii?Q?lFJQzXLq/r0xvAYe0MSLzDwrr3s9xlJ10+gtBk/rhOeSaABaUqqjxyuophWc?=
 =?us-ascii?Q?rKFTTBhcDymhnf0qy34B8m7vRYCXPUdLTC3MpoE8KOpVN/Gc+sUAQDU7+s5a?=
 =?us-ascii?Q?4igZx/mkV+ZGAautv3r0X0G/EaYkY/o35KL6mC2IQBJf92JRFvK19emIY7TR?=
 =?us-ascii?Q?+FhMIV7mxq+IGcnjh4PbLH+2NPslBtu/sKfozo4tK+q7IGbrRTNLE/hgndct?=
 =?us-ascii?Q?j3THdB3jQEL7OPFjcCBtx/Pi/9jaDhhoP0MHCdJL24x9GCl2s35H3a5enAYq?=
 =?us-ascii?Q?eW7yLnYrMwfSpylHrVGNg2aPrAU6hEvDaHjGBd7Trrv1SQ2vY9/G53D2F3nk?=
 =?us-ascii?Q?1FVLOeIdkDqyBKzf8yw63WCCmQ008nJwu7vOYnG5Jkmp/Fz2binElMQPTZ8A?=
 =?us-ascii?Q?L9hyWuNNMbFvnt7xTCUuiGjnRXhQn6/Yy5BAjYjSPTpkUV+QLuQgElr/pgrz?=
 =?us-ascii?Q?dPND9U3en57v0B4KMh4ED0Liw3v2L8jH32nEdRkdZaJArr/8yQuYunXNhHOx?=
 =?us-ascii?Q?+uFMwhObnynBSakigAae7EHPAVdCT2vOM2d0XYQqBcv59X7bvyi0A10iwfCP?=
 =?us-ascii?Q?57km1vLzsX/0KKIQ8h6sPeN98U8fjbeHmhfQ72+pFKIyFJ/JlXO6HQbWXVUE?=
 =?us-ascii?Q?0Jcc/bxu+G95gmcTcHhNmio+8zp4gNSoI8rdbMbmb5j6Cmkb81VaXvMJ0d9r?=
 =?us-ascii?Q?k26ofzkAt5aB6p2yJqNawTKIyW7ksu0pBmxJPwtn8PTAJrtR+IZepWYD43Ul?=
 =?us-ascii?Q?7prr71a+oUpQiZBtcaYorBz52Cbh/OHK80SObewavEd9fZ+GMTG4YuX7m673?=
 =?us-ascii?Q?iN4KozA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(52116005)(1800799015)(376005)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cB8UI0cCUV24aHpPgUCPcJaOjmJPdU7v4SGpSvyixATcartbZs50JCrvGXLj?=
 =?us-ascii?Q?zRGA3uiiR7fZmTMrx9Hrgp3c3F7X0vJcNj9qHr3gXgEMPlNdy/5LXeG+et6/?=
 =?us-ascii?Q?V9xeJq70K5xM1PKi4Up105Bl+T2ZqJP7azzA67phIqHQLn3BWC8PFi37VL5J?=
 =?us-ascii?Q?AgLinTljH9vGY7XSejkICJnsrUiVYumUzPcd8ci6gSLl0u37DI8beDhVBvzr?=
 =?us-ascii?Q?el1TVWaNR0b3fi/O/HKMA/WW37Qbkk0EmzS+CacGH+vXASmxHqg34/g276na?=
 =?us-ascii?Q?hSD0wEbPwBca4HbR8HA0NTc7u3JlQfhgIZ8qm8jFSkjao8myF07t7frn0GIc?=
 =?us-ascii?Q?ncZbAXMlqEi6q4tpX6wXHBtDJL3Uc2d154JUhFinE4JgMjRd3Wxx9Xc9Ahrs?=
 =?us-ascii?Q?4mKQoZ18lcE2FvVG7x9ughr3LZMAhWz5oSXuCGPt01Ltru5eIcIt5Dqb7T4e?=
 =?us-ascii?Q?gsLvg+6CEYmR1M9TSrim6EhwzaOT9CLaSTD3rcgZMX+IIL5VgwB584q/vLlM?=
 =?us-ascii?Q?n2HfweF/SfS9X4PreHFq8kGFWLo3hxdzHUBNDHBf7Wq28bXb2j8fco7LBEdD?=
 =?us-ascii?Q?4OlYB26ifFALO+v5dctAKm7651xE1jD0/9Phx5GXBJu7O1QMKAIsE1uqL9ym?=
 =?us-ascii?Q?gvtfza58QbRrbrYuwbIhlsOW1rhiPnGChjvExyCbgzcIo/8+0N7BU59y05mR?=
 =?us-ascii?Q?KRsIMfBcUxJE6evVDfva+IfrrcUepUZWe04hVZ2rj5yIOqlHuS5dddcXKMJj?=
 =?us-ascii?Q?HhgYDUboUI9vN1VZaGQYiEGYfBzds0WZ1ZP+BEPlBl/U1OG2kBi/iXK/IYA7?=
 =?us-ascii?Q?r40bj2McolexSGer+NhwM2tGkZHO9RIy0immovnNAOGQtfLVv1tIu4zICCYE?=
 =?us-ascii?Q?8kz3Rdg+Sampp5aRPV72vamjcUhM84Ew4VQKZslNg/+BhDa8FePu5D8xqU6d?=
 =?us-ascii?Q?ICARcHxWneph/d/SyKx0zOLMqmt/RqSvJsOchAkznHnJNrBdjQnljnCKdtqJ?=
 =?us-ascii?Q?DMOyFDwUrFU6pbWgokRelRfdfqRP6QWftlVO7HvY4GfoedQUkpcGnCC4pJSW?=
 =?us-ascii?Q?13NavmjuHH0di6GlxezWdmXp+jh2XQxrRwZSPpmSeGqnSkuSYIHN6TDm0bra?=
 =?us-ascii?Q?24tH09C1qpNV0l4oVBn/QgCMGDdK5qDCVxKXzr0a1CZH86eWm4Facpoo/VDV?=
 =?us-ascii?Q?OYLseIy0GxTo8xRJGGFqdiyj0HU6PA0jHUBcMMijDiSxU3hP96/a/lnGx3u3?=
 =?us-ascii?Q?mX5i0BByoGdWFkKmWTUkx1GvwgDxzZxjUauz+2xDNC7nYIeZVwTBN7Gl8JYT?=
 =?us-ascii?Q?rNIZN5L8I2oNFiwnMo0Ia9a++mRix0sHip1usN7weCq2ah5xAfe4Dz2z286D?=
 =?us-ascii?Q?VyOG1+ehsS8wEXgUWWQO+zrLY0mv8JA4YI7DFeMmM7ZPni+Cttht40My7+4a?=
 =?us-ascii?Q?7n0QbPRNQES518TTh6iFpOrLY/BTTaqKdoSs3mgVQz1Nd4YjoTmgowhKsib9?=
 =?us-ascii?Q?lwEHy6opUZulEZlWyJNaHo8BXtoVsiiTPaDorAAtcYb7j1cqC9BIW9mMkUmj?=
 =?us-ascii?Q?KB/4ejTaSFT+AzjH2J2hYS10UFiwhxpENtO0QhyHcykZhBZvhOg/mRqwBGwC?=
 =?us-ascii?Q?K9GAJ01rUVpl5lMJYQgfZQo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25190286-e82b-4cec-b2ad-08dc8702917a
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 15:00:28.1945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9NzZJcSpfUzyc3hHSTbbk/4l+SDmwAk+Um9jgl74pVYMEkFncp+vOVQARGsv9kthMb7YO0HudXD2WNFtTBB92H4K6BJ0ZpO4UW904v/HL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9395
Received-SPF: pass client-ip=2a01:111:f403:260f::721;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
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

In some cases, the NBD server can be stopped before
nbd_blockdev_client_closed() is called, causing the nbd_server variable
to be nullified. This leads to a NULL pointer dereference when accessing
nbd_server.

Add a NULL check for nbd_server to the nbd_blockdev_client_closed()
function to prevent NULL pointer dereference.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 blockdev-nbd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 213012435f..fb1f30ae0d 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -52,6 +52,9 @@ int nbd_server_max_connections(void)
 static void nbd_blockdev_client_closed(NBDClient *client, bool ignored)
 {
     nbd_client_put(client);
+    if (nbd_server == NULL) {
+        return;
+    }
     assert(nbd_server->connections > 0);
     nbd_server->connections--;
     nbd_update_server_watch(nbd_server);
-- 
2.43.0


