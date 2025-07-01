Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C638DC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 20:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWhgK-0002BD-1o; Tue, 01 Jul 2025 16:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uWhgH-0002Ae-UW; Tue, 01 Jul 2025 16:34:18 -0400
Received: from mail-bn7nam10on20606.outbound.protection.outlook.com
 ([2a01:111:f403:2009::606]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uWhgG-0000h4-AE; Tue, 01 Jul 2025 16:34:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sM045BrvCPKJuRHJTydoY92Tyyg107mHypa3oUJ838mQ3WEHGRXdWP3h47mZAqJQEUEMdI1kp7sSndm/RY0iTlvAT2nJu9MouXdxCVolT/3PcD6CpqIEzVsa0Qq7LuISWgNGBLLKjnrs7GKPGAwPFhWNPCaCKoIYOyqXyZTh3a1zCo/gnZwDNe2z2DBvzBSwgUAhoZO2Zi7/uecoB6zbfZXOQbASw49hRHo5qv1IoLxVIqImrEAINBCeLpMPyUEu+KnzSvrjlN93ZkDyx4kVmMi5lvqZH1HcvLjF8GZffuZDtAZKVwhg4mJKqkQTPw8QjZl5KQLECknGZCR7L38YJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hQ530f/2drTFEYAHoDlRkHUUbTy5gSlXNWdBfnXk3A=;
 b=ljcIaD27QywZbPVEF6sWE9DxN8ezE9r5IBb+n10YUBHRV0vfOrWMYfuNLqhqRKfWQ7hsfbaiNA8r92X6BzvaAQrouZTPrJwZeHmTJIJw34Z/gjnmkmlAjALS7UawS4UR8SrpFGz2HxIVmt/3K0+SvB2FePlPNJBYyi6iSeZ146I7wJAdQ2K2tb9M7Q44TymxG+7+9FAcBfm/sIaSnKQjqbpOMwxS3NxxD3v981y/H7twhayLXYPMblF07iVCBxiiDesg+gX/cjQ9Txpm6gG+7LIfRDmpczFo7R1boz/owgziASsO2iWskOgUYGKuTpYfKF+tc1UD8mQ8U/r5sZD3Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hQ530f/2drTFEYAHoDlRkHUUbTy5gSlXNWdBfnXk3A=;
 b=NdaY+qNnDfeeaxNTXapc5mvRads62aFd079UJoy5yCvqqTOjb5PnKSwt0Vazq6C68EfFSqU7XsQ/CctAWPxaYQq2tSS8KYxEERpyZjpS7SJ++/JB3f6zS/jPtfASx1F7Ssw6JfNraiUJ07rjjZZ6XItI62ftOkBabbEnVLGxEKfoUsg5F1/ClrENLTBhf6OK/Muq90GDORGpAjV333cA+ZUyv9+n+40+V43l54dTW81U6fUSb0xu6gbZntfuhriM0OVxeS4Rj2JprbKDB9BYIBgbp6N3cwAy5gazbmgPMnyCHofxGD6zyvsganjziTaUQyw/rpRMNno43tdcR/qSUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23)
 by BN7PPF0FD1DEA27.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6c8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 1 Jul
 2025 20:34:07 +0000
Received: from CH2PR12MB4277.namprd12.prod.outlook.com
 ([fe80::8857:98e9:8b64:787]) by CH2PR12MB4277.namprd12.prod.outlook.com
 ([fe80::8857:98e9:8b64:787%4]) with mapi id 15.20.8880.021; Tue, 1 Jul 2025
 20:34:07 +0000
From: Ed Tanous <etanous@nvidia.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Ed Tanous <etanous@nvidia.com>
Subject: [PATCH 3/4] docs: add support for gb200-bmc
Date: Tue,  1 Jul 2025 13:33:59 -0700
Message-ID: <20250701203400.71677-4-etanous@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701203400.71677-1-etanous@nvidia.com>
References: <20250701203400.71677-1-etanous@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0020.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::33) To CH2PR12MB4277.namprd12.prod.outlook.com
 (2603:10b6:610:ae::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4277:EE_|BN7PPF0FD1DEA27:EE_
X-MS-Office365-Filtering-Correlation-Id: 39535cf5-1002-4174-cec9-08ddb8dea07e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cAa0jblmCmfM3ZnkSc8PB1OEpsfTcq4ZDtc5NoONdA7biCO12oOCGvJrgVbC?=
 =?us-ascii?Q?6etwt0+K1ojXqbqUt6lqlRqNhcFCdIGz7XD6TVZYq576oZP3KTWJv0hMWFvu?=
 =?us-ascii?Q?5T2NSw7hoMo6uDRxTcANsmmfo2xOwwxyWB3ZZ2OaeSnJAkc0+B7QIgS/Ddcu?=
 =?us-ascii?Q?Gu/+7V7iXaX4Zi+leDukM3x5ezT0lsW/4mMBIoyYTcdatPQgirhh4P54OwuZ?=
 =?us-ascii?Q?RrYqC1KyFpdTAPa5DgbAwW46GWm+y8TCWVyYzxAb/JqZoZTpK2vbNJM/nSji?=
 =?us-ascii?Q?RkuqBd0fxBaAabEtrTn9eT/f1BWT9NDqCPWQFuiOd1TsA1SKGug1haUgQ7Xe?=
 =?us-ascii?Q?x5GWYfQAIxCHQ44VU1h61Tgol4ltRHU3z5odFFLTLGqAc7oOo7n96YxHk4UB?=
 =?us-ascii?Q?VzMUx2BfWizMgjNpWhpVw2skS1fUQDLXsK625QdXy1G3n/BdYqZLUiUEej2/?=
 =?us-ascii?Q?rT3v8Bih2gez0/RbQHHDvej3LcJLIQAHNisvMqZ90VyONT0PNVJLWRQ+/Y9Z?=
 =?us-ascii?Q?9LtQOTJ2nmwUSRVVMfWquYVzWSBZUfqPn1NoBfwetn8TfbAl/LPY1NBpHhwS?=
 =?us-ascii?Q?/3GuTAI1E9kDw7t/5kDtuyjnGmjL+3UUr9aKLKf9WBYzvPOw6pgDA8K07zeH?=
 =?us-ascii?Q?Z33fdBGHOKT4ED3d62BYIeFQAV4n8o+jaJbTMzT4Uh/6tmMuPkY6bKMmKLOv?=
 =?us-ascii?Q?cryaE/yEIpnXF0MgAMGtmeqJVlN0m1cae+I5b1MR4wko6yRUod2QM4ZmSLE2?=
 =?us-ascii?Q?JJFC5rtSIbktbe8+JupTEd5MKMd6NOtAWzU2NKFMOaAH3vbuts0qHr2GGZLH?=
 =?us-ascii?Q?uHgSESyaI0Tm2XVBvRgaLVeqOchetyDibtb5M+Gyn7gFggan/pB3luUgT3OB?=
 =?us-ascii?Q?GducW1iXdtSY+06Pwbukn2gX3uJWmNiIrpnckpT0A4Z2W+XvuqgJ9tNRgVeX?=
 =?us-ascii?Q?3OczfavoOY57rsFzraUxafIvH470zOB5j8sdwXlMxvNdeDTkZ+jwWp01u+ME?=
 =?us-ascii?Q?Y6Lv374h1K1VllCR1Xf1HkKaUHd1SMI9RfYebnnyGoBkDZvsm8nARc+MPocH?=
 =?us-ascii?Q?8AjNJDpVvZpVzMHChUE6J+/nI+QhCtUdjcGuAssUaMPonHBvUpEaKdzaZ09q?=
 =?us-ascii?Q?ClbxhLx+y+92Ea+qhAQ3oVSlmlWYLVLDHvpdkyB+3XbZ9yGfDfAfrvPiaw19?=
 =?us-ascii?Q?po8IZ+JAVMexuyyaM4O+Wlo46Hs0xU9kZ+BaoiYRmknPacHrpVgIbF5FA6Dn?=
 =?us-ascii?Q?pXmaKVuQOODbs9TglxSwxKLwJssmCNlC92V8ei6Uvgb8rftzThDLOjrr3Yov?=
 =?us-ascii?Q?Dm8l+8PRKDWk1ccVECH9fpLEpgG7ZE1IiXLtTO8xBYdJfgFwymjBLLiiJHWF?=
 =?us-ascii?Q?EAqslsxhrk0kkEAuw7Frh/HX6jmzQeMUoAcaXceNhSEeMykwejlCCIHWN2m+?=
 =?us-ascii?Q?ho1rr2ryEc4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4277.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zdJFYWIBdN2uNf/eBUFpA4rb4uNepNVTCqZhILwyDBmuUyGUqyacSzPlBsSe?=
 =?us-ascii?Q?TPDADGF9eLFdzsjAl++9PBUKJqaHANlfeUCavtNP/Cgv2o/MXkwZOO0Hs2xl?=
 =?us-ascii?Q?5Dpuxc5oXs6QSENtdbR642cpQ8abOvwJqo6NR++kVT4rioJcXcyhz7OX3wur?=
 =?us-ascii?Q?SWO1HZFlxOcUSK06he09rjstuuEjuI92CnUu9vgo+IYLTUE0zRCO2Sr935nQ?=
 =?us-ascii?Q?zn1yvinArPQS774N34MYWi5UZ1SrEKb5ZVaHgEE9fi2WKx/5lZpHzIPjFAXS?=
 =?us-ascii?Q?FqifbZ+R4sLMghhjmQZiCyfXjabGqiJj6gbsPl70QviBY8JJYQq+wqibhyEH?=
 =?us-ascii?Q?YbQKBhwoFAb6I7ahSV9H2R8BgioTxrmK7xkV+hgK5opX9hd8vxZfOKGLgMx3?=
 =?us-ascii?Q?f1nIfYjXJQP5RTPXNGVi1QHCkt3Y/cGvP2R/Yz+uQQBIYdYadKgnDsRHD/pl?=
 =?us-ascii?Q?TgiLWsb5hqlj/xjm3QRLoDq2ZZcv0xtJmYC2H+wJb6KsKoc+AMB/Crz7FZqM?=
 =?us-ascii?Q?Q+bXOHyNiTr9mixLsU1E0zWyHbgncDpC7Gx70DZ/cHu0vOEVgM1bOZcq5/cQ?=
 =?us-ascii?Q?aPoFMAtMM/yKa3fImv0MVacBg6YImK1kJWZqBT84m1NlD98wkkOAFG/q0gxd?=
 =?us-ascii?Q?gfP7coxF+x40OHCsONW0oBcnOcrh7EFRdHB8mmyh+Pubw+YOc0Rtj/GBx0Am?=
 =?us-ascii?Q?Y4rAfNfljKZXfmFCk2BLcKaGnMr+bAuEMt652VxF/xuePQRjMz5xXIx7i51Q?=
 =?us-ascii?Q?JVfonh3OSwSffKOckKIbSCuqtuDC5FHh4xOxQ4fdEYoWkZ3ZWBvu9RaiMljO?=
 =?us-ascii?Q?MRuQPgOQdmDWbJeDaA11tjV9l+PBmk4cywz17nVXgsAO2lp54IiM8GXaHzgA?=
 =?us-ascii?Q?9BLV1zPxxytjJfueRFNsEOhtQNWDWR5Zjf80KSuDR6h1FZjpgOb3BOVSaMRO?=
 =?us-ascii?Q?Bl+OhKJ1JzkRBCsWWf0UhJW01hHSdDotzQnSGmE6kRYW5GpVDNllM3Mg4Cyj?=
 =?us-ascii?Q?dG45iFwYYeuZO8jQfXJZNV06RsqONjkr8b9sI0Pwv7BzbES3U/pf6XQKNVUP?=
 =?us-ascii?Q?enLJpALvsU+F38SMQRD2Vk7osMaJITROIR7AgeIj00yBAEAXJ8ujro9mGvnJ?=
 =?us-ascii?Q?S3Mkh/cBi8+JHAvzI90r9L+IMz/tYEsSM55/A9kiSYiCYA2JJH4pJpRv2ybV?=
 =?us-ascii?Q?yH1UCdS8rSrckd+BSjkCEmcdYJCkqJuttGsduK2M5PWi/U7y2aXAAA+AE4Lu?=
 =?us-ascii?Q?5/XV1KRsq5q5z3U7IDlA5hsKLFTgwTJm6/6Hg78sd2iLoWAfkJPakYZmf99h?=
 =?us-ascii?Q?uG/RKnF3INc5ThUdn5PYatEXFoMX1lBTxEviG8A/n8AmT3QJzXacNCIOr8iF?=
 =?us-ascii?Q?euOnvYIzjs4eQGUguuU35ZnKwgOjb1rEYjCuc+oAHrQ7z5K9+FgHPsv+5+KC?=
 =?us-ascii?Q?8LRKAl/4Cbe38iWggQFEVzCkIsQ1vSGxDKg7ixso2a7T7nZeQeLzWDZRjdZQ?=
 =?us-ascii?Q?HKfRbWk7bEL3Ajg2r1IdHY3us3L3MtXyl582zp3c1hTMymplJ62e0LJ1+k70?=
 =?us-ascii?Q?SFcI3D14KNiW+GCwZrkUE9AbiT/+B/TFE9mo3HfE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39535cf5-1002-4174-cec9-08ddb8dea07e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 20:34:07.3068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: leAg/9pK4VhSb7Y7KT+noBWgZJ1Vededg57Z2H/yqAKlKf6YI7kHziPISj6o62F4qhreSnm2Ky+ivCdYApV4nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0FD1DEA27
Received-SPF: permerror client-ip=2a01:111:f403:2009::606;
 envelope-from=etanous@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch updates the docs for support of gb200-bmc.

Signed-off-by: Ed Tanous <etanous@nvidia.com>
---
 docs/system/arm/aspeed.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index 43d27d83cb..bec0a1dfa8 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -1,5 +1,4 @@
-Aspeed family boards (``ast2500-evb``, ``ast2600-evb``, ``ast2700-evb``, ``bletchley-bmc``, ``fuji-bmc``, ``fby35-bmc``, ``fp5280g2-bmc``, ``g220a-bmc``, ``palmetto-bmc``, ``qcom-dc-scm-v1-bmc``, ``qcom-firework-bmc``, ``quanta-q71l-bmc``, ``rainier-bmc``, ``romulus-bmc``, ``sonorapass-bmc``, ``supermicrox11-bmc``, ``supermicrox11spi-bmc``, ``tiogapass-bmc``, ``witherspoon-bmc``, ``yosemitev2-bmc``)
-=================================================================================================================================================================================================================================================================================================================================================================================================================================
+Aspeed family boards (``ast2500-evb``, ``ast2600-evb``, ``ast2700-evb``, ``bletchley-bmc``, ``fuji-bmc``, ``gb200nvl-bmc``, ``fby35-bmc``, ``fp5280g2-bmc``, ``g220a-bmc``, ``palmetto-bmc``, ``qcom-dc-scm-v1-bmc``, ``qcom-firework-bmc``, ``quanta-q71l-bmc``, ``rainier-bmc``, ``romulus-bmc``, ``sonorapass-bmc``, ``supermicrox11-bmc``, ``supermicrox11spi-bmc``, ``tiogapass-bmc``, ``witherspoon-bmc``, ``yosemitev2-bmc``)
 
 The QEMU Aspeed machines model BMCs of various OpenPOWER systems and
 Aspeed evaluation boards. They are based on different releases of the
@@ -35,6 +34,7 @@ AST2600 SoC based machines :
 - ``fuji-bmc``             Facebook Fuji BMC
 - ``bletchley-bmc``        Facebook Bletchley BMC
 - ``fby35-bmc``            Facebook fby35 BMC
+- ``gb200nvl-bmc``         Nvidia GB200nvl BMC
 - ``qcom-dc-scm-v1-bmc``   Qualcomm DC-SCM V1 BMC
 - ``qcom-firework-bmc``    Qualcomm Firework BMC
 
-- 
2.43.0


