Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B5ACC6B25
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGr36-0006hD-Hj; Wed, 14 Oct 2026 00:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGr2l-0006aR-Ah; Wed, 14 Oct 2026 00:56:48 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGr2i-0008JJ-Ej; Wed, 14 Oct 2026 00:56:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ElKK+utGmxI41YrzphaH2RLesRBn2uu5pFxkscHLgXwu6wQoriZJ7zOFzEWSHsFNMjftiUBE3NzjaGSOITLzsM7/C6DGP5GOZsLrB8kjq5XYIhYwmYwwTiZt9egqIYHo8asWrVVl+5EMZWA/GfcErMqkANkBk6GCnfjEpML7P8xWN8kF2m1nuQDshz+IBp0mZTvYHUxEKirpNSonPtTOo+6/oJ3M52eYf2WCcBEE0jv5i+r0aehKZWU6EXcDlK6TBp5nuHTAcS4MttOYxcLGu6SlqWvQK8wN8bvovV1Hob3U1f6DLAH/0Bkbf8ikTatR+jbAQ32+E8t2X+sXSmzJWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFkH+FxzzXdpSNXj7I6qAD6vZ7uTcOgjP293Bd191pI=;
 b=OTh0lAX7EGbZf8saCNKxVkVMFjJfkG7pQSmfI2L2oobgmmOf203W5WcUoWLdNNxjr9PKLLbI0H+EHiXErnGGMSsrN4ZKljzczLem+kbKd6UYuqZY8c59WrituUP4laLfz9wrbWjEWLFGlRuh5rLr2a6xxlChUzJpah92oVj5M1urjVf1lgWf9N6bfgnFzeQdg3FGf4UvcT42EO1R9VRZ6TEL+TfCJC18Dwf8avX+ZRQUmc0wuoo3LLLaxbl6ohIFJLf3+CXSuaBpaIcfQfUCEZm6rYuxplh2+lInm0Ftg1v7kIAMtDPE/6LOjsxgpJnipfxy0/YrWkNgTFl85wj55g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFkH+FxzzXdpSNXj7I6qAD6vZ7uTcOgjP293Bd191pI=;
 b=EULj4oslEo77QdIuxuQ5MyBY9+J2i380d1xBql0GKdk2a/fACAjt+XDslqgJ+M6VnzZCHvOchAIetZjQ7YPR34MJrXihmwY92Jq9CAe4Ai0EHQ7tI1znJojPKJZLsCA2WK/M7+aIwy0X09DpqQ+V3R9l7kJrnC4Sh1/Six8ocymkVmu8QfTO1ZSvX8DyiFUBjfXeAammDh3048kMLXGv6reLyoPlc1gNnlDaUckbho+iXHogfQ0c2V9RDy4YVqvRfMpatgBsTRB85lgDbT1mGgC50VwV9d1GeJh9IjwZ6qWIeSu+T0xx4Ih/kuAwmJyNnirOSACo/WpJ3HspcMw2Dg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by JH0PR02MB7213.apcprd02.prod.outlook.com (2603:1096:990:67::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 04:56:30 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 04:56:29 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v4 02/10] hw/misc: imx6ul_ccm: Update PMU_MISC0 reset value
Date: Wed, 14 Oct 2026 12:55:52 +0800
Message-ID: <20261014045605.399684-3-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014045605.399684-1-bin.meng@processmission.com>
References: <20261014045605.399684-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::7) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|JH0PR02MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa1e219-3e36-49d2-2ef9-08df29af8277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: bLunymUJmg/8JXQntZUTpUenhkHJO/Ar4W63nIuG9/V0ULEPvjiDj30iJQ4sTOsCIr+xZgvFPpgq7fnZHMrrrXdMvcLS6fvuhXDX5jsWlUbx3ij6ie2tTa+mRIQAagrmlBsg7oFh0UDw/Uau1t94rdSYRVJTR5BhPcDB+dY/OaID30tjfMOUBzw63m7Gf+bTX/bhfxi07Qq7umZ4ZzxgoKI2kOxj6ac4fxTI/Cd4BGV3KviX3ZIvVZtCE9PjcReTLFb3tHQyPS7+FYcBoc+R42XmHWluh+UkGbfvY+9kX1jgnmlMm+tyVSbAD57ECfqM406/MuF+wrvAb8/ivLOOkHkoJzZ4n2eAhsJ6/ICdQoBiPg335PUk44JzzHqiOhEo92PRuIQvEVkEwo62V3OcFDJFBav2dkAKeqTYiw8nvcBZfpRyw6IFuKQtz+h2Y4Ph2/dQZnhNyQJvbkixjtdSMjxrhISYD3RIsLN5fW45HXF1Vug8ulQSUOZKwfJYZerrjuvmCYibiQjI9XXqhOgehEl/MwZO2vuUUHL0cDrSi1fR6OEK17E93V08tNJDkhOldJeEi8KxtgaRoTSa7YrEucM/OFS12glR8LO4fO22rIYlErc27EQ4b2ZpqTOugwIrM7uW7uiVa6iMW/znJHkyzeRncT/nBKcRnLtLoaSvy+s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L+hPAKnef8d0QnZDDagvBaQxpvEFGkKWnd/Ib5wF0kw8Zcp9UcY3mOQrOfz5?=
 =?us-ascii?Q?EOLWK48o82DttISm7R7aZ/YnFLy6KXwidBEeCcn0or8Dbc7cBarWkVOmg13f?=
 =?us-ascii?Q?kkYn2RO2AfvLrz/OH29sC5kdZG87OixFLQ3GzVQbiFP9Ze3+1ak7vXsUqqM/?=
 =?us-ascii?Q?/e8lI4hBe/ZUzjZXL/kKI2W/UYc4TlcUlwklKP+SylvzveqYCzfu2a7rsJ0t?=
 =?us-ascii?Q?Iy+bRsNL/JZg1hjDsdAWHhCPuEYBu0gJx6x5VshKDhHY5YYZeyuYwAja9IW6?=
 =?us-ascii?Q?3ottw8yEcQidR3oMzq4k2HWPwNjbM9Ro3V/WLnKd+1+LoAsDnTaRVgKm4HqP?=
 =?us-ascii?Q?qqdgmMrwIPv41GnXv2ynHKC++es5PkKHIHGkUlh6nBUM2eF5dhIZ48ETERbc?=
 =?us-ascii?Q?OSQ7t9rMEpFGSJMTyjfku51TWx5FYlEPMiHSVnPGDbOob6HdHyGEJXhShPXk?=
 =?us-ascii?Q?+S8bngzM8XBPtp1o2wnm+Sqt7MnKlY5ZP9J54KBHUQo3VIaeNsfSCEvxtndU?=
 =?us-ascii?Q?uDf7lxSvjsKqlVUYFOE9aSZy+EvE9Rrt2LOHqqStUTJyOuUr0WSPbSVRDxXL?=
 =?us-ascii?Q?7kkzmF9kwMnKCPfi6WIpYyHnVzEG6wmUar6fT//h8XP+HwYxt9nj4dWIRTWr?=
 =?us-ascii?Q?ZHSYkoHIH8wVixpb0b+tWx4TGUAT6isfnglpKxsnMOP3mmrvaD9/oDWazzAp?=
 =?us-ascii?Q?eIwoQUzZHdfgzqG5UhlpZm51NxHomeooeRK/L4NWo1xYk0wxtaV+BslPRMol?=
 =?us-ascii?Q?vGZO75K45+4Xk4L4u3TMh5mEosr5CrK3kVWzH0RsPvtHG3S+iiCkgnVSgpyY?=
 =?us-ascii?Q?N5Ze/BgWf2dh5lUzpBaMOFeCrYjKkRAqOM+apxJgs1L6hXME3+8ZT2zArLka?=
 =?us-ascii?Q?SL4/JQoMk/L/2vxBkFO96SqkzVZhNaUmmhLJ2luF+H7MDNwmXSgpg0jAaMBA?=
 =?us-ascii?Q?1e4shAppDnH26dZTPoN23cJfnWdYT6fANaMxnLUR/aq97mqL0rgL+PNghgDu?=
 =?us-ascii?Q?drToJwVQV3mu6Bus9QpUDqEtr2CCnMOuy7gBdiceZqoJikFyaKVxyGWee3Ja?=
 =?us-ascii?Q?shOfMgmOuE/bVkyMvHrozf3Etoc0hVnedCn2de9cGrjSg8zJGbSTOBk8ZIql?=
 =?us-ascii?Q?eBNBPJKKCIfFt+uT+CiAIn0J3ihdBiR1t3xIXI9SrvGrjSklwAFdospLRX0c?=
 =?us-ascii?Q?IYGEbVvSfU/gpQHiUXSFKLmTMVa+XX+s7kf1lzxzBxrFx0C3J6kuylF9S88i?=
 =?us-ascii?Q?EguNTCGMiRxM4SHBmd4vQtJXMnL1wk7t453DDJV74ZDOSy248ic3xtioYmdH?=
 =?us-ascii?Q?rWcc2dxN5Gi6DAdQfw3zmXxBoOVXhYw47yaJd+oaFp2nUZ4vcEXTWnCBNX2X?=
 =?us-ascii?Q?fi2zqbHmjA4GfvJdMoTsiH8109eEL9pMaiQAjnNA8vV6bH+83CfipsF9l1Dd?=
 =?us-ascii?Q?O1udPA14082t+nzQiX4WHroS+SQMvKp3AQ9/NodUe0iIi55hzpMFcRPM6ZYb?=
 =?us-ascii?Q?/i+6HX3BXy+mV1QERwmu04AR5bvWb4KrhvotSaYZjTF99w0rI53qs0zFd9Cm?=
 =?us-ascii?Q?8cVL+zwUkMuwTuTR797TM1xPAB9L/GnyRdgugCW1grLunuOA6FPg56LDC4Cp?=
 =?us-ascii?Q?Fg7kpodw0sXXyNPV6QcDv2gk3PZMDUOQXAICDd7KoGKTRRTfNLoBVtPH6Awu?=
 =?us-ascii?Q?uZi2269IwG0FyLqIxy5Nzj8+Co15uM5UyM56LyLf9e0gknZk1F3Yj+pXp1SO?=
 =?us-ascii?Q?onUzzJg4fnoAfXcRFQXax/RztvYc3E8=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa1e219-3e36-49d2-2ef9-08df29af8277
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 04:56:29.7272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /A6X90XGgrP/yKr+kgo/aOd+eiDlBbEIpqSp8TYaRpxLJael2LkzcTq2Wql22e8Mb9fjw5arLKjfr1mvdxmDLVOUu0R7pjSawwUWZPb3V2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB7213
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

Commit 56a11a9b7580 ("hw/misc: imx6_ccm: Update PMU_MISC0 reset value")
updated the i.MX6 CCM model so U-Boot sees PMU_MISC0[REFTOP_VBGUP]
set after reset. The i.MX6UL CCM model still returns this bit clear,
causing U-Boot init_bandgap() to wait for a state that the model
never reaches.

Apply the same reset behavior to the i.MX6UL CCM model so U-Boot
can observe that the bandgap has stabilized.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 hw/misc/imx6ul_ccm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/imx6ul_ccm.c b/hw/misc/imx6ul_ccm.c
index c4f6e372fe..4accbcbeed 100644
--- a/hw/misc/imx6ul_ccm.c
+++ b/hw/misc/imx6ul_ccm.c
@@ -592,7 +592,7 @@ static void imx6ul_ccm_reset(DeviceState *dev)
     s->analog[PMU_REG_3P0] = 0x00000F74;
     s->analog[PMU_REG_2P5] = 0x00001073;
     s->analog[PMU_REG_CORE] = 0x00482012;
-    s->analog[PMU_MISC0] = 0x04000000;
+    s->analog[PMU_MISC0] = 0x04000080;
     s->analog[PMU_MISC1] = 0x00000000;
     s->analog[PMU_MISC2] = 0x00272727;
     s->analog[PMU_LOWPWR_CTRL] = 0x00004009;
-- 
2.53.0


