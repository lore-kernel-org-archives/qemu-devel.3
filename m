Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C5AC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25b6-0006Tt-Fj; Thu, 03 Sep 2026 07:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25b4-0006NU-RV; Thu, 03 Sep 2026 07:27:10 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25b2-0006k3-Us; Thu, 03 Sep 2026 07:27:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ucqZN3zC8bY1VhEJQRHzcnoON1mKQABT/s5fYS73VsaS/bMgla6DSdozTBkJ6/Gp1g+6nMpMA/xMWZz+oqznr2B28PQEBo12bKocqyM5KTl+SvZhm+Z9m4xTsYQFvp8U7ypJAkRqdruAx/sRQfJr222g6T11ma6pXkkjWjcTz595YAKEW7tNWBmfQqIY48H+MhvVlkOnG+lpw9JvmKFOvdUq7zU2sy9anb+Zw5uhtEWlxvhZOnUC7ExtjCY+fWB6Feh1vwsAo+ykADfYd/31/anVVWecFIb5GPEFzQ26lYGAiiMIJOKv7pJKn5f7ToUapI1aTPn23Y6WsIdUmmBf4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cq5tAAC8bemFOZTPpOXk85OOYatsexKnnY4/lHoaDn4=;
 b=YpcLXZ0CE0QJwyPgjnhrwIF4d56REVe5Kg31uY2q0UdiQWuePcCLrVrhF0kStEl7gpMxbJ0JvhFKZoeIaaL7byk+SKy+kHiSqjUz91D3vSWP2OOd7lAC1UbNYCT9ZKVxmlQPlbwO9rYEftJhMtijAqc0gpm/MUoxWXpvNGwYlyf2Jbrt/5I77VZY2KCh1YLGrkrK/3bY9AUcbKCpX+fl4nVKHbQqqQMUTIRFgGM01g1tVe69U6946L91KxcZ24NXsvQQoPxFDn/lSQWWCteVrSs1oXncIKj3RauYWJkt6DDpvDA3z94Xx0J5MSnvjfysaqTSL2pIJyGunzG02EFGZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cq5tAAC8bemFOZTPpOXk85OOYatsexKnnY4/lHoaDn4=;
 b=cLd2iuqL1aFL1vnSVIVRxVgUIIFQQh+8mFtHg0+5Muat3ENSv2/Gg4NoaQMNi1nYqTvmiMjIeYmn4K9ZqW7bCkh2MJ6/0fimFVAmCwTg+VwMqgDqKvTL+3zeefw4stvWKdclVu1BAa4r+ofooiVXEJwwhcoSVyQQjrzBGIUJk82tQe1xTvxq6tgj+jQXQAPVv8NJWPRWjuBowalhskKNl+WELCHlQ3ewELT1J4zMmMAJ4x0oe3Jv+XYyReSvJVjcCPeDsvuknyBW56C4enOAhMJl7hipTAYgYFIv2A1EG/dRYOBbU2r5T2DM1H9lx9gH8GkdATEtNiSbJDaE4FLdUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by OSNPR02MB8962.apcprd02.prod.outlook.com (2603:1096:604:45b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:26:41 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:26:41 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH 26/33] hw/block: m25p80: Add GigaDevice GD25Q128 flash
Date: Thu,  3 Sep 2026 19:25:06 +0800
Message-ID: <20260903112532.3276678-27-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903112532.3276678-1-bin.meng@processmission.com>
References: <20260903112532.3276678-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::11) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|OSNPR02MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 194e7226-a856-4dbf-f102-08df09ae39d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: wh2KMklJI+Cf3fB8FQNCoDNxguu1eVXDCfBgwWGe5euuc27bPsCbXT9JF0oei+DO0MQ71eS/DtwZqx53cUHAUJLkJwhnpi5a8B20bY4aQ7FaPMM/vydTuHHvWK+xtM3QXLTj9pkLQVaYNR3m8bzNEPThD/ghOvblZudrxUgOTJ+ODgRnGt1uV+RT26xj9l6KRtWkBLwGsMRz6lCIMbEtwz7qXaFfWAtjfnwXIkcAIeUg+SU4Du6Ph+LPM69dAiQ0mMYeUJxnjfZYzOala9qL4ITd4hQYYAXgD22v0tKKWwUy7y7PjtBJWlzZWjtrHoYBfjzGUH5XW5c5l3nQySZQ2D2Ealq83dvCH9ZpznE3FkSfzk13cnBjcvRxPix6Lv2Pavpu4NyBhm+iJ2NQNxNSRgVcBmcyeNthAXTAcsz4VMaYdONtfHjVD23i4mJTTlrKYCmypg4+uvl3Rll8w5cZBu2t5g//NPZoBa7/iBQOAJQR4jioTYTGLkKxH9vcPLUqYUUg5V6DmelXPbAYG3SvhY5R6TKQAAANIL2TtcbmZxKq8g/UDvoa0NL+abiXKCSMzCzCpKn+6BIoG47qECsNigOcM1CMBqu+LfkdqtT9lRfnyfw2l2cUP4ipndiA68wDEYyJjKz+9TTUylZLm7DqhXB5DzLtx5IWv6Bnp0xBzUk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7C+vaWAC61fscB3yS4Doe1DF/LN+mS7h3K7QFk6azQmJFQlxRALtuMWk2210?=
 =?us-ascii?Q?xfWatanMKMpHudGT/TL/JBw3n+4CaQPrpb2O+NvPbB0yDQrDpRGyM7uEdrb5?=
 =?us-ascii?Q?WpmOCeqb7Au+hMCJ8nMyd1X69YGZ/6BoDZXGxpySe9Rz+8etOOVzsxMm8C6G?=
 =?us-ascii?Q?5biDQPuIKXuJNAIyQdCVpnfIOa1NomJwSGrFHofnZfVfRblMC2PIsDzIdsPZ?=
 =?us-ascii?Q?rUmCHR4spfsAHC1WlBpCGBRhImW1YjQ2sUwClqYwjP0u3KcJALfJJ3uiqDGP?=
 =?us-ascii?Q?n2bCn2OWykdrkfXa7WuFrwIDgP/yaqzcUrq/7m37ChXVPtVFV72FeFR96Fp2?=
 =?us-ascii?Q?zQ1A+Y6VxDyB91SQWr+h2lag0cS52qA8qknJ9RDFsUs73qdUHQMB+OSIeU6F?=
 =?us-ascii?Q?hw3wg6kFZprGhJIvyZb2BvtllT3oX7rXIHywVZg/w9wa7f5gcoDBtG8UGz3B?=
 =?us-ascii?Q?Eaq0c01jnm91TRjckQigkk316YEDGOpF7oFXhn6nYG7gqVl2E6OwwsYup473?=
 =?us-ascii?Q?1I457CyUfP6FheTuVItJ+JyZRuwEzVCDUXwmizwr95DNFe5OmthQPOQvL5nV?=
 =?us-ascii?Q?8FLNy3Gp8py11j83nzJ63QjmhMdP0WbiTQeKs4bedtn0FcW6TCb7lSYVvYKP?=
 =?us-ascii?Q?ihFOP74jAcsSzJECKdN9JUB0KQcVLdMkbzzKEbSpUtXgoQuK2m9EC9AzkYUr?=
 =?us-ascii?Q?RmEoOgScAac7VVS32//YNiaHSP1uFHAPuRalRSYxtDNxhiiV2ciQxMeoNjqG?=
 =?us-ascii?Q?Z+QD5FJYX3uowUUoyxIhzg60Tt4pdlfU9GMw8OPZwAqyaey5l1wIbIqdeaKT?=
 =?us-ascii?Q?uDXO1D+j7J3RyWribJ/sHlk60kV611xqJ8hD7Tn+9Dhwhoq8J89R/y4hETBH?=
 =?us-ascii?Q?4lJfWhOwWLyPXw2tXFxB6H5xCjtNByce+sdKN5ZkO9ossV4WLZxzGBfBhmdh?=
 =?us-ascii?Q?9j4unjsMdkhLy61IFtCv1yfBki2TcEyQVL7bJCLdgwrOP0LI3XpDNXmNbOq0?=
 =?us-ascii?Q?Y6u3fJWTetpLn0PIROgs/9/RLN9CqkZ9LNmCNm98ezvBqngJR9HtpVYQTNl1?=
 =?us-ascii?Q?JsZJCVp+yDl/kTB+9h7pNvJu+8qIarJY8tx5RNN30XGZfAU3zHwgHjeLRBO0?=
 =?us-ascii?Q?UFL/uKZMA5KFEj+dC0y0gl5VYUyjLlbXAo6ITBUiG959UvgKqk9a8Ufl3JtO?=
 =?us-ascii?Q?O+V8DojgLKCdY/e6bIYg1XbxhIr76HwGdMXXDnBe32UYaE+SlroZo4dHGzAe?=
 =?us-ascii?Q?dLFhSDSRmlfn6oCL9C84ZViCWvMOpsz6AwsAAC5n3jmIQahenXi3K6Ct3rB4?=
 =?us-ascii?Q?KJkUiu7h1vKepamnv/LeF+Mcdt/wMz2vKEuPQUsLHaur0LHfJL7ITOoH+ymj?=
 =?us-ascii?Q?uYODZmrdo4KJbtDpYX/UL7RoaWEyuYx6Q1XfrrL2RmFiAt9OAzMxO41qSSV+?=
 =?us-ascii?Q?rkjcB15eiEy6S6V1WnZGHXJuMCNKacq74SpZB1q6/5rBw89v7oq6Maf9mxbP?=
 =?us-ascii?Q?xpVogKZ5P3MET1v7TMVv2rahjPvbet6eJThoPLnAmVXZzD/qq4yXlTmVkWRh?=
 =?us-ascii?Q?y7G414MWh0pCc+Qw6lPleCmQwIXeRtraDp8cGBNiiE32ZK/BNu/O8wfqIlGt?=
 =?us-ascii?Q?xU11ZlFZKXd23EfUIcZ3A8zMm+JqjgB/cgTC5ZPiLmYnkaXXeuAdSV8usOD+?=
 =?us-ascii?Q?dPKQhYFUQCZtAcfB0pPrkjWDmzXzEayWKomDRJ4pUiDSnjD9q6mnL8asCCJx?=
 =?us-ascii?Q?ElV3jhgNMBOMNRGy62iJ00TcKIOWkf0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194e7226-a856-4dbf-f102-08df09ae39d7
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:26:41.1069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKhZfuSjW4aZVqDUrSLQPpJuaQUVv0sO2mJCAP1p4j9umElGfa55euDAuTFdmZvfyWjTaRwkMwr5EtwvgKpj2q7UqtjFiOcDaZRfTexmpdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR02MB8962
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

Add the 128-Mbit GigaDevice GD25Q128 SPI NOR flash with JEDEC ID
0xc84018, 64 KiB sectors, and 4 KiB erase support.

The Phytium E2000Q COMe board uses this device for its QSPI boot flash.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/block/m25p80.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 545e0b5728..60a9b1f8d5 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -207,6 +207,7 @@ static const FlashPartInfo known_devices[] = {
     /* GigaDevice */
     { INFO("gd25q32",     0xc84016,      0,  64 << 10,  64, ER_4K) },
     { INFO("gd25q64",     0xc84017,      0,  64 << 10, 128, ER_4K) },
+    { INFO("gd25q128",    0xc84018,      0,  64 << 10, 256, ER_4K) },
 
     /* Intel/Numonyx -- xxxs33b */
     { INFO("160s33b",     0x898911,      0,  64 << 10,  32, 0) },
-- 
2.53.0


