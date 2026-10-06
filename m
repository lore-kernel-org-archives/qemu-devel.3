Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30FACA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN9G-00081t-4R; Wed, 07 Oct 2026 04:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEI5U-0001Nh-Cz; Tue, 06 Oct 2026 23:13:28 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEI5P-0008UJ-5c; Tue, 06 Oct 2026 23:12:59 -0400
Received: from SI3PR02MB9388.apcprd02.prod.outlook.com (2603:1096:4:2a6::8) by
 KUZPR02MB9164.apcprd02.prod.outlook.com (2603:1096:d10:61::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Tue, 6 Oct 2026 20:56:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxvs6myqKlKmx8gM4KUQ+wH5h1jk/2sEW1gAD+yBff1eJ/W64O0hHtkSPDVQMpmeBhJ4jhpUyV5MnZsI6xYguy614kqHp7oi5ySc8yQ601MH7z2yYlh0N+nEJ7O5vGlJ6dUXWyI1uuke6kpkMIEt1KQHIuLlQCl9GghW7QSvHIFgXLLu8DpKghaNeV566V58Y7fTsNclWA1+kegTODnOSV0rq28NaCSr4LuyAsrpjArrmJTZfUY4/e2uCq46hPehttEu79+J+WOQbJhxiCrMDOIq6ormHFrju56jStwgsO8k0DVaE2bZJo3l1D755tcDsUMev/IPzTwUwlqUtBUG1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Abw0xp5GPGPA+xSL66CrfAC8G5BT+vYb0A4JukosmBI=;
 b=ORALFz3dUKN4Xpyva7AVLvn/QZY3zS270Xjxa8TMtjT9ZpL+69qApFXQnzvTQYj5R1AYrZkzLbd/wGK8UCX2ILV2n7UAwzLtugdl/g0JOYYvu2PEiNhJuy9INjv5/9l0uMYwxDaQLWOgMslDr/MHdDmdrXiws9xIWajcLJdrmykk2tbFIbVO+AtlUTcdU/1EK17aCLBe2KWHGDWqvZGhYZQBN9hYGK6QetqMHwtqyqZQlg5UkRntGUgp5M0IjG/iHantVUI5zjI4nYHViZ7xEmAxzEQc/IQNwaClxnNqWu5iuBYF1V5I8BRufAMArmet/ajHVejK3rEwwDc0RcqliQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Abw0xp5GPGPA+xSL66CrfAC8G5BT+vYb0A4JukosmBI=;
 b=tlnovCYTjkbzXJJlvfmg/8oEPnFoKnaLesDk7H4IDw6VqYwLAYFp9e1tYL1/iY8COmQJ1J1KLPVzvirsFLWH9Py0Os9FeO8puKejCGtenY3cggnpN0ioUmNfsbcAEpvB0d35W5w/AeFcj6fYrf4iu2d3EIemsYzEjMM1hI7EulSA1fC3Rw/T0yPNmbkSg23NZtJGus7/1pLHOIqELQ7HJSvTOrJdmeh/antoeEguPTOmi//KRGqs6SFgkjnJB4SfaoC0JrJzqzcsXH8m67f9rOphkmWZWvHFyesgLJLAgiEgQXDbfy1lJQ7Ylwtgir+q7fKXyGrdB/891Q7W7nsoEA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by SI3PR02MB9388.apcprd02.prod.outlook.com (2603:1096:4:2a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 09:50:22 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 09:50:21 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH 06/17] target/ppc: Drop redundant e6500 L1 cache geometry bits
Date: Tue,  6 Oct 2026 17:49:01 +0800
Message-ID: <20261006094921.110871-7-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006094921.110871-1-bin.meng@processmission.com>
References: <20261006094921.110871-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0136.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::6) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|SI3PR02MB9388:EE_|KUZPR02MB9164:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf299b8-a65d-4e65-1f7c-08df238f3cc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: o++7eRZ/0ckj3ncyZ6yM9Erw1Aydw0umnrf08eVpU3KC6rNEmErcB9rD4PgxAougyxFSGcRN5UgY1cBoxoAwoDFHhiKnZQUi6t99P0cJ1M4TIqAyHHrIqrkw8sV/RKlXWVYJLFZJZNIPWJE1SIdyqGV07jUHIfpvLj0qsVcxsQx/QIQIQPYqqJiis5BLE/jYGEfUtO8Y1j28s/N7X3vrTybRT9Nhcqn9AAY/RqSG7iCjuuV2bKTkIQJNM/TilrbwuyfEOMMIsUW3HuhTlepLjYFoh3osH/egu0xtF2gKcOg+7ftMVim1yxveDNj4LHiJyEOHi8i61njJXvFy/ag/A+SIzPWGktfgChYRfPcbpAUbl/kGAlP9bSIZzmnLVe7m1JFQIvGJkX/z39SDJRh1ej6LEHxKDpFdwWGbwlQxQyEuIsR5Aejtmz5Llf6g64WjUvuS3C36TiQ2Bp3IPtn79eW48X4Gwy2z8FqXZG9sppthlZhMjSihR13vYg8O6hicrVZrRSA0m3kE1KigXbvU7W4YzMp4T9AhUX6SS2EVCQ6+KuvOi20EgXncum18eUfAUjc14mdM6+4n3UEUtEV6AgpsalnUS8TNoFlZV5VHzSmXts+Qppmc42D0VyupYmwWVRAPA8OZyA+U8PURvMkUEyx4cjER9nAasHJJTN/rv4k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sMP7BIeuEGOXbcjxQr4+RIChB4Amqbm+URGgFi3LekAKCnrHnBxIy1H6nnB9?=
 =?us-ascii?Q?KK/6ZApP0hbaIDP/cdG9NlPXGlgLPZGlZtXxCa+9tNRgE7jkSlQHULahtRMR?=
 =?us-ascii?Q?lSn2TGNOCf4v/lE+ph7kyIhRPAoqwBL/78bE+JEGI+tFLETZW4DmtaqEpSco?=
 =?us-ascii?Q?H1C51g5p/mqFklJDF3tDlxmfKg0JgLGtVIZboaHH7D02uVdgEYcH1Ch58Xgp?=
 =?us-ascii?Q?gGVfjHPgXSKy7QMCjbi0+FqYCUveL1t7uoQi8l8ayWWn6VljIleNqFdCrMAI?=
 =?us-ascii?Q?hnyarQXs8+lI2Qo83X30Jh5Yl2kZSgj0BjbpnZmE7S6MgRNDi16oYDyLLbr5?=
 =?us-ascii?Q?WKpDrtFX+GAONNl/y5FuYvBnAsBt8oENkhbxtYBgUyAQZiyUT1e41GJlDkia?=
 =?us-ascii?Q?gvyIgxHe9d1qfeI93POUilYpG/T/ldif9zDB6/Gs+3xzR35zV4Ovj+W3TQHd?=
 =?us-ascii?Q?4RI1nky2nJeQJTEUznJo7e/pOvME+wDH68XznBU077mbikcyB2klhFaSbYaJ?=
 =?us-ascii?Q?Gpw6N99R+KuTw1Esd0rSA3V0Za3BMq1njI1yfJX31eOeInTGWuk7DAQ8cknt?=
 =?us-ascii?Q?+FGXbuUsVTm2MRzRyzPWPIHc0ccS+xZnT6JWaF2JgHh1INl/PmXDQo1Uy7va?=
 =?us-ascii?Q?9qSGnnSMIc7wCs+uwlfGSnR+BTH2CIJauShW/iG0ReVWss/SUvJDTnbVtJmK?=
 =?us-ascii?Q?VCU4gcpFuAmJEX+OT1UQFIJ6MuvWXqXFKAWzcR2w5hkCGPvNhYJRsf+ILF9m?=
 =?us-ascii?Q?5WXGFONghRQOT90U41fop1xGaFwJ4I6MOIPhBNEOvaWf9xiVO+fc6Ru2Sci2?=
 =?us-ascii?Q?qPfqCPpGyWP1ximQaart5Gxau1hRUyXA9Y83pOpBrPz6riZg8zhjQSweDunX?=
 =?us-ascii?Q?0gj4oRpoXVMyyNdx3ukmb3iNv4P0StJPIRntA2aUfzwOYc34Vw/CNq3lkVOs?=
 =?us-ascii?Q?Urd9N+iLnOU+ZUpHfzKGMUqrGbb51cEArtApmauxg39QFDlgWiGsOtVexC2s?=
 =?us-ascii?Q?kjtvivtBsk/lfZT9enbWBW5TwkAx1yxFTPntW/iMweg7v8VNoIPnbmO1E2cX?=
 =?us-ascii?Q?bc9hVQesDQO/h/ibD6FqtIBIAP4D14ANP/vGV4uefATkb1Y+ZvfnKIw/25nH?=
 =?us-ascii?Q?riVujpn5qdh3YEPdH7GseqKiN5mq1nGK8FGd9ZpgBGsh/gNDrNmlWq0xxUTd?=
 =?us-ascii?Q?LulkMRy4IiYHBlNElOht+Yi1R5cdEdMGH980o0Xjtqjx5/c6Ws5o/bQL4D18?=
 =?us-ascii?Q?8qVkwSqhRPVrF3PhbEAzQ5/7bmJ3VUuA2OkTUYCQQckZimobA9MPqS61VVTy?=
 =?us-ascii?Q?rS85rD7QV3n9jDtAGw4SJyR+tSgMl6CUHnsbe30vOUh3/ajTfUJXnnaQv+q+?=
 =?us-ascii?Q?MpeFhs58fSRSWZ0vZSVFVbxGALv5ul092ZgfzkwHBQTAvdLwA7/0Uc4rL1As?=
 =?us-ascii?Q?Ey3uqBL5B3ShJD8Ut42Ae+MAsxpcrInT98HRgmZdSYLEXUTxBlf2mTklmQ+V?=
 =?us-ascii?Q?qlyThpa+dSsRjEnCQPxyl/PIDJTmwVkebfhOdJtb7pjlxszNVpE/ntawbu+8?=
 =?us-ascii?Q?INDyVAG2KxP1Y+q5fCIv18pOwUQuHpAzAOeUSIVk2Kui8VzhmR+72L5CMslN?=
 =?us-ascii?Q?MBs4t1T50Pl4EMjAqS+Kj4Y/UBgT3uSRf3OvukSKT4rlcd38AO7GCJjmWIUs?=
 =?us-ascii?Q?32nyI5yOV/OL/vy07c6C30UQW+146vVm1tV1l5wn9bsYSqPABuDkcBpuVjqR?=
 =?us-ascii?Q?dcsFZ6Fb5oGOhxn5X6raDEtscEM1sc4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf299b8-a65d-4e65-1f7c-08df238f3cc1
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:50:21.8514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1c59bNWWuG8ipvM/XizerVW9C+IWX6f3/4wXKRjI9Ir1SoBd1e8fPt0wlYEM+2HVI5VcKoVX3VaFHHYMMuGRo7H/0qn0TOs0xanuAHcIZh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR02MB9388
X-OriginatorOrg: processmission.com
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

The shared L1CFG0 and L1CFG1 initializers already set 0x3820 for
eight ways and 32 KiB. The e6500 masks repeat those same bits.
Keep only the e6500-specific upper fields in the masks.

Reference: E6500RM (Rev.0), section 2.11.4 and 2.11.5
https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 target/ppc/cpu_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index fec672a8a6..23f25a56c0 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2893,8 +2893,8 @@ static void init_proc_e500(CPUPPCState *env, int version)
     case fsl_e6500:
         env->dcache_line_size = 64;
         env->icache_line_size = 64;
-        l1cfg0 |= 0x0F83820;
-        l1cfg1 |= 0x0B83820;
+        l1cfg0 |= 0x00F80000;
+        l1cfg1 |= 0x00B80000;
         break;
     default:
         cpu_abort(env_cpu(env), "Unknown CPU: " TARGET_FMT_lx "\n",
-- 
2.53.0


