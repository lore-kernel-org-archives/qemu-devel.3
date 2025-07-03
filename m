Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7D2C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 14:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXL9d-0003FO-IL; Thu, 03 Jul 2025 10:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uXL9b-0003F1-E2; Thu, 03 Jul 2025 10:43:11 -0400
Received: from mail-bn8nam11on2060a.outbound.protection.outlook.com
 ([2a01:111:f403:2414::60a]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uXL9W-0004DF-Dx; Thu, 03 Jul 2025 10:43:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bF8I3mH4tNpma9u4It1w9LAz8c0Oc+VMAuqQeZDgpEHTXcCUWzMFcjkMsBQ6j1nGHXr3n8/knFS6JqM/VxkFYD82g8VixUrE7QHVPxuO+d0s245tmJqmYMR6GuFkDDXmvjcNAvZCTOZVO3Oeoz5sF7AKX45WV93anvHbo5SceuJtAPSqZi0wXokYlhHjjpq7TzqPueMIaJT6C2Qj7of6B5RfFXVJHV/uKNq0RNkpi1ucWamCkM7d3+jmzACQko59m9DtwxEV+9NJkpnPbLrYPi2nHbW3XZscKf/QbztB0Bw7wGWf3ExKgBs5+yM1NVqpOGXGb/KZ6rBNaI4Pj2nEkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hQ530f/2drTFEYAHoDlRkHUUbTy5gSlXNWdBfnXk3A=;
 b=PwB8d8Fyxo0aLUzgx0yeziQZZ8Ki6dpK59Vmvn1wxcVCYWLmT6A4sD6Nw9fYE02rQ/eHpzE4TlJE3kVZnGWDQCPTqe5+n0JnQtBEsnGE5BnBnGYD01mA5wBCOMjeY3az4g6vSt1lDa1jtYkDOLXeUrDRh+TWD60FNrK20bX0JtjwmYl1B28EzWQqCnvEUmHyGyLTdP762khuYA7WEgHozqIUHFWXUsM/8HK7Or5txOhPuuXjNK0W9KZHQ2aENVZY0Fc/7MUrV95O9QF6Ewgyi/PhUzkLCmaDYYMhvVf2TffHLtqTV1wRrRXMkab/PWhXvgzm6XC1nfrnWH1RifZ/4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hQ530f/2drTFEYAHoDlRkHUUbTy5gSlXNWdBfnXk3A=;
 b=iEQQOqOoQDZdyPFywLbZRyT72DIB7SxkBE6cUqzMzbVsCjgsmiAh8t9gJCv9KQPvkarAVVwJKUXsPildr8torKcWrHc/4XNWScVy0cGBiE+iA/QAawtfm4tustKHoO58exFpVtJt1z/VloksB+yijEq9i676JiNn8RFdK1nLRHvU24uBgd/0xZY9ollYa2+f8x8Z7K7aTARV1nzu7QWlBYAs73sGb4g+N/yx20dyk7RF04VZ1mNw/CpTdxp8kL43x/LcYa87pUsq4PbZMXHIwtXxy7ULVqQt+CCNwWEuKEHZl8bJxQhF9LMOQxMnzumPRMOMBjvzhVAkQrQb1wW53w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23)
 by SN7PR12MB7836.namprd12.prod.outlook.com (2603:10b6:806:34e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Thu, 3 Jul
 2025 14:42:57 +0000
Received: from CH2PR12MB4277.namprd12.prod.outlook.com
 ([fe80::8857:98e9:8b64:787]) by CH2PR12MB4277.namprd12.prod.outlook.com
 ([fe80::8857:98e9:8b64:787%4]) with mapi id 15.20.8880.021; Thu, 3 Jul 2025
 14:42:57 +0000
From: Ed Tanous <etanous@nvidia.com>
To: qemu-devel@nongnu.org
Cc: Troy Lee <leetroy@gmail.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Ed Tanous <etanous@nvidia.com>
Subject: [PATCH v2 2/4] docs: add support for gb200-bmc
Date: Thu,  3 Jul 2025 07:42:47 -0700
Message-ID: <20250703144249.3348879-3-etanous@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250703144249.3348879-1-etanous@nvidia.com>
References: <20250703144249.3348879-1-etanous@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::14) To CH2PR12MB4277.namprd12.prod.outlook.com
 (2603:10b6:610:ae::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4277:EE_|SN7PR12MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e21175-9755-43a8-251e-08ddba3fe6bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZM6iva2CYpqZTvwUyzTEoaq5PSsn3paYE86rxSXYeN1FHcX1lw38rmItfNVZ?=
 =?us-ascii?Q?37TyNLmmeRq0oyvwkc1snsiVQ+kR9rcbDTBkMaFz+hpQpOcYTHZGvruykoUE?=
 =?us-ascii?Q?bjLCqxYA/uCRZYB0i+AfQUptS+Dhld/DYlepm7htPkPgNLMfE6ivnUeWNY3v?=
 =?us-ascii?Q?cFpCb8NUlO0QfdLgL58h0GfSTTWofdLhanzbHQxCBvarp91WrgP0N7wncDmK?=
 =?us-ascii?Q?F29sL/YwunuSusCbVuOd5Tt3s1XKywxkMboWwHRG2Rbp/JDQ/5PDuumjv25q?=
 =?us-ascii?Q?wGYdb+raSCSYsEO1UDuJ/BewYcUPE1GWljwayObwiMboxQd8vKdIu05r78zB?=
 =?us-ascii?Q?n7JVqg5BP3kyicZJp8I9bc91XKSxGMTsL8ayIVDY6o0S5jLS6iUqDYeqLOl4?=
 =?us-ascii?Q?q+HxaAW1OVOIBLXN3lBPPU4E9Vlz+3c2DH3+IszXzcZXx1Kd+pGcoSKg98SF?=
 =?us-ascii?Q?YMtuv7ukLsmaLzOUEILqGZ3CMgLd7BwnQlhKgSAewT0pqj2n1n2326zb7dkD?=
 =?us-ascii?Q?tX/90QyJUFCiCgRmU4jbHijxi8adeufUXc6moPg0ToE4JFGqf8aHXUlgRZpk?=
 =?us-ascii?Q?He0iAA1vg/Vy9v1JmLIaf0HbWBJA/NFfanSF8aAtK75wlfS4l+m5ijz1HKQr?=
 =?us-ascii?Q?XAGkUz9xVorfByjYfpPIWpy8r5Tr+gXh6t6gUrJzCAM0sqjaFWSsS+Ft8fJj?=
 =?us-ascii?Q?eIoGPV8Pvjm0UPD7Oi18RYwiZeXnKQtjbvgU/yWIouEs+Unm5GH3sWkUjvzI?=
 =?us-ascii?Q?Ca+EfrqlcsxYqIo/wSvpe/nAT369kT1kTO/Y2X0fvf9gpn3p5rn3+lH2Ynb9?=
 =?us-ascii?Q?El+nMN7/yanjMVIaN003e/BGdJf1+WE4H1xffDrNe1rBWqxd91T7x6f8kbkw?=
 =?us-ascii?Q?PZb91xPkBHgEGR3Stz59mpTSTtqs82KAcIkjW28K6nKaBinA/SEub7KKyzw/?=
 =?us-ascii?Q?HBU72aQVsLz+SkRgwOlWs+4hZGnvs7VMlcquKvOJbQn+l30Wv8QaffAeTGA3?=
 =?us-ascii?Q?oqFxsV0D7ZqUUaVY0B4zukyfqiT7FnH5vBgrA1AJzWFrIJYB3pbFZmXn+opu?=
 =?us-ascii?Q?HaQjCKMLqAM3pb4oiM0H1MAIGkwtgjnm5Ya2ENAHDM0VWa6Pmx/JU+BXdsS5?=
 =?us-ascii?Q?1HdP9kDkLaH0Z14Cb2RiDbgriTJ1Bki+nsQKrNY3Agw00OGALF6YdReLltij?=
 =?us-ascii?Q?rcd3+jLRttxBFIg3ZoAu5R/V19FJdEc3dKo2lmR68gLsPxcnrHXdkzpXV74Z?=
 =?us-ascii?Q?J8NTMen+Jt0Hlowxzo7PcsTTvfaeO3S/okkAZyA3Jlm1rw1X6RkH74cPAIV4?=
 =?us-ascii?Q?+OcGfQpjY8HBInYiq4YvWutZHhsPAhYe+fqgINuSv/QdihBnWpcNaqEsUGdi?=
 =?us-ascii?Q?iLXQVY8B0RECHhOVftFMdS7snfC1uZrtlaNUNGtZbUIn4RCKnXQI8uJMZnC6?=
 =?us-ascii?Q?IkDFUuzEjvQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4277.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uRBkDoLVuTsBU4p8iCDKAVRekQuNxbnzpar1ZMMEikJVLD4wNd+Gt5WaMC2m?=
 =?us-ascii?Q?BQpDCcF7fDDsCFHwtU/h9JproJrBGm7LYr3e+PXdZmBn5DSzT567Co2ts9/H?=
 =?us-ascii?Q?6xsBU7XJ3hjBteqd4m3WIAn6xwgZFbdnbmMBW5FLE4ZMweNzTSKbP6aCr5UC?=
 =?us-ascii?Q?9xJcnW9GM7UsKlvUT5YRFT+5aCseUvkA/cxeCjCwT7AkVXEkAdEHAEA1o9A6?=
 =?us-ascii?Q?NzkMPH+vKJRYS3vjQ1X/lE01BVwSDeCWkq7PPsnyIFxMk8D8DKZl53hfFntf?=
 =?us-ascii?Q?9/sytByHcN39le8j8MzM1bRvvKTqC8JU5Dp4yK/kOBt0j7pwsrWgV4ld8UBf?=
 =?us-ascii?Q?d6YPiHvI/FORfmFqrB+cn90FwDtVym5HXhESDAlMfGzv0WPZmjyIoYE6jMrd?=
 =?us-ascii?Q?mBtoaui9ngwVI4DGnp3c2+vBppPoVBvDyv3oNocRv8wRTsg1cBvAqhMuODNM?=
 =?us-ascii?Q?NYd9kO9gO1OqrwLQy6ZTXVftSFZstw2G7b7P6DSskoPzeZ1w4yij/bsxmD8D?=
 =?us-ascii?Q?PUdPrWkdpDXwUx5L7k212Z56s0GNXFJP7p0hNBdfqXse5G9acVLz4oZeVaeG?=
 =?us-ascii?Q?AWO6oEZO7BCodL43UavDqOeB1TfBxw0CmiI0UdyVw82D/4AJjDWKRVonHuWf?=
 =?us-ascii?Q?iyqYszQFCRJKjmHrLBBHYOq1c92TBnGS/cU6stlaRhQT5aOVTo6/xjX43F1d?=
 =?us-ascii?Q?OFurEWfN0viutmYMNp5/EayhLbJDbk7XaNHzm77xSj4SxL/4dZsX1hc+hJox?=
 =?us-ascii?Q?GmuCU9vK9SWitNphTLKea2lBWx3+wIFWfk1F5F3GDCgCaR/Kw79r0p0awpHP?=
 =?us-ascii?Q?nb9Yajj20bEUtDPEOK9jIdmqi6XNG65hA/cHRY456E2B6zf6kCQtaVY3CdPr?=
 =?us-ascii?Q?aZ5PZAhT22lf5tKOcpu484r5S6y3PJwBj+1H5H3BhtQHJ52DClKqqUBqSmhn?=
 =?us-ascii?Q?AneU4hslN2HyI2eugxSu6lD5k/ASJIL14xH4rz6q6KQztix/jOUJWqlUIQiq?=
 =?us-ascii?Q?zoastBZUKgyKil945XPgzwq5IfQGrD1MHgOZzy69Q2Fn2OtRKEYiLIoDoGb+?=
 =?us-ascii?Q?QSU12cMeZ0+oR8ZaBQWYcPwX3zvkfsNB1ygE8bW7ZpIZcPkI8VcbiyOmyK1B?=
 =?us-ascii?Q?QC1TyCOr8JNyit0z1WoCGQBsy64jY9+rPF5fkLgBwStYwQUPpl/wUvH2yoQG?=
 =?us-ascii?Q?wFawfw+BvSZBXLZcGVheIZVAMTidTzbYLnMixkp7WASwTSVmIBfKP7zNzoo6?=
 =?us-ascii?Q?RqGkSUEiVO9Ml+bDvqyWCuJ7f4m6eYSNykPzmXz0SgN7QMG8wxYoVUamG92J?=
 =?us-ascii?Q?Tb/5FkkfpI0SlFsSA7hLHpSqoBvla1j3YcYAOh5OL78BCOyVElMtWARuPCiZ?=
 =?us-ascii?Q?pk7no5VTo8zYsPoxtdy8t1rwuxM9wXO9T/P7ooqj5qnIiM1W63x6b0ab7+tu?=
 =?us-ascii?Q?ZDVI/+yFE4lX1bxKC3rYMqS/lv4MBXsdDOJ0ct268iUdeDxo6TGkBPWYtFBh?=
 =?us-ascii?Q?9QG/sEN95H7+tyPlbM2zNgPC2kbvIl6aAe79s1E309FIopqzXFpw1Vy5mTnz?=
 =?us-ascii?Q?nCK8rvAjTqWPyFtbFA+kGkZvNVYiIPeNVx3nxM4u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e21175-9755-43a8-251e-08ddba3fe6bd
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 14:42:57.6526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i2SulIOStP3TdSrKEhmAidDPskNR7D9wLAHZrcBe9NANZnsYk2smgnqA2zfASWpnuwjPZCsxweYbs/IUWFiL1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7836
Received-SPF: permerror client-ip=2a01:111:f403:2414::60a;
 envelope-from=etanous@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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


