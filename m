Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F70CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN6f-0001GN-Ru; Wed, 07 Oct 2026 04:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEI3Q-00011q-QL; Tue, 06 Oct 2026 23:11:04 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEI36-0008UJ-2Z; Tue, 06 Oct 2026 23:10:43 -0400
Received: from SI3PR02MB9388.apcprd02.prod.outlook.com (2603:1096:4:2a6::8) by
 KUZPR02MB9164.apcprd02.prod.outlook.com (2603:1096:d10:61::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Tue, 6 Oct 2026 20:56:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrnYRXoNHeWOfG6bqywEVT7MKu/3OnL6Q1sZFSXkWV74Oq9KPQbKeJH5Yi2GCBO9lGATuhlmq5VSp4hoWNctHKoxrGm8c2rQ4j9gq/kWrOHas6ta99cTrt0nQvaCN/Y0gMpwY4OQAuLjr6/PFP4T4o2kVpMb3YMFvYKM1fXDcSbr8nU3VmR1L95ZwMWBih/3Fwdp3VPpRtD44WDcmB0UXCgmiOwQdFZHi1bAN18nnWattxVncxbCOPDEj7Fe/IkqJS76Rmnin3WOMQKuFcRXDDeUhBfbRv2KcRTMZzvFejPi8Uf2PEjsZX16Np4YIRQ4uxJjU+W1eBiNRH8Oo6hAVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbgqJtB6PEeslXw/MvEGKDrlct8x0GXOTuZsX3/Iffc=;
 b=YD+sjlUiR4tkOIruiq62or6Mdhiwd4pTVnRlaYkszaHUSM/QBGGUVQFzqLqnzanUOqPaM/EaES/7COsqLASGK9pJtp9vGuyPtGfUQNJb3NBdXtgAyD/UARAYwk+Ns4CoxZYCMcBYOkG4ddSXiHU4DjYcFqyRFUcSJXMlTS4zQHWn0siVRh6ETks9qalUp32N/nALOL1JXx0+nC9YvNd4uzyePNUUXTin2R4rt8wQbmlnPU259+K1MyDeT5ZaSBuc8oSCRwu8rUlFI/U41LdzG6hQjFfnYpFMg6Og2ivjTNqjM61RuA/eYdakhpHXvGrB39nlV/oAEz26iwH3hghFmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbgqJtB6PEeslXw/MvEGKDrlct8x0GXOTuZsX3/Iffc=;
 b=ZyFF7BSKEwKEO0hTItQaJVPEok6/hPLsMazNPZihA5NLyrEWerOagaIYEvst7/55ikqlpkBTQK3q15Lt6UibLT3tLVp1AXS4MSpIfARJN+gkql5xwbWps1fXbV40xh3vprR92aitI95wwyrWHO6wVAxcO5l5yG0ubb5lYyVd/A7h891VzFb0BGzFoeqmVgXu9vnzyQNihjqok5/bUaklIGn9SFou8rI0JWic51vaLAFBdU6Tu+QUPqgscV0pMdOf2AncumdCobnYcV+PbVO19cizHk7XHyCYJKMtGyrEY5RgoTHyZnUZ6FYzF/g8/raliDKLZCX0q80pbMdY7Sub4Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by SI3PR02MB9388.apcprd02.prod.outlook.com (2603:1096:4:2a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 09:50:10 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 09:50:10 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH 02/17] target/ppc: Correct the MAS5 SPR number
Date: Tue,  6 Oct 2026 17:48:57 +0800
Message-ID: <20261006094921.110871-3-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 450f7bba-5190-458a-4923-08df238f35fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: SZPjaRj1jL5pTHxMFTMYcl+a2A2V7ndXTcEUreiPQfmY20uBwmZuoygo6wvysVqeBfjb53DPZ0hrd+EYMcoFVSMv23zzhPtUvqRLzOAd6yTrOXGOR/nioi5UIpfAcKzrD6huk+mzQ5NOempPBzi5f07pZCelnEvnhATfkFx0A7esNdIfhcLgzcScrBsX+gKmJEc/erqld3+G6Q1z+WjmcTRcDvJWuBu5cXGifoewOZ6qxRisxlwLDWKuzSySZqh6U8gK53teBBCNCMbY4vsO3fjpU2/pUWyI92R2dlOpEmI3Aj5g8aB80XIKIGAKtzWoSmFDd5RYjQIatEBnMgYd8orP90j4IPIZWNhibB4jTY9GbDzM1orj9m4zxD2e/Y5EwUAGBGHAWVL3ya8KsHdSXUE8G2Ef5g/Em021ziiNLnqcoJJI7WbArhqePKEaxXGj/nHK3Kus2TuiiYPXlZVLcleWP0hGfaFJk2MLv5PMjVL+ARryuEcteoYNBVXG73S3yGrx6kuPar49Y92DlGoioUjFhh8GDY59411D8NuFpDahymr+tlAPGJnz9RngLyLdtGhY8ikobTAlQBqPsTQkVbEwGJC1f91X9PRFMD7kAf6sIlEwCcSjjHTtCPYSzuCOSJ1m+DgzG/NXzZ8ltJuyp6TROxR12fuqzDXE97gto8g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n4zZTaMW52i6fztb6NZKUEDi599vCg2zk5nsVnAc6typeokCXVgBrOwkBYPU?=
 =?us-ascii?Q?/f8LLx0tFILv7RQY3aIjbUUBl2rmVvPskhM5oIANJ38NSFS82VUFyFv64BVj?=
 =?us-ascii?Q?/5UMIFdEY4yWrfwF6OkqU5ijklAO6Ne2HqterCXcitAkU04PmaYonKX/SGDE?=
 =?us-ascii?Q?6ADUC4NCp7TjTXCrWoEzVm1EZFNtyZUsEMLndQ/FQ0Nkwo+QRGIYPMkpCcOi?=
 =?us-ascii?Q?KSrNrhQkkuqfcgUi3kSPYkzL6IP4RX6qmV3cdaASiZQH+qdn0EdmiOD6Md33?=
 =?us-ascii?Q?eslu/WM8EQt7aCHGqtnXu5m0Gd22aBWNhMtfCfvhgWLs6goXY+OCPWGg6mCM?=
 =?us-ascii?Q?1E0XhaE7viB5w0zfsnQNPHhM12SY0ygdzg6dE3w9rOW4Xjm2aGlSanLImwcO?=
 =?us-ascii?Q?vVin0UfQNq0fPldUtnNfb82GFeZW9hYc2w+qKfWOGny9HiY0kldGZKOBhTA2?=
 =?us-ascii?Q?ahR4iVeYcBXRPzOMxwi438uzywovHyQGPjkxxcewRdDuAuYweHY4+f4sPhud?=
 =?us-ascii?Q?d0GK3MWBIa1My10ijIWh66V7ZMK60awURHMrgB5fEW2jYgF27rPZl0yQYTl6?=
 =?us-ascii?Q?YGtVtG4ZmtFuDmUbHFCLHRNMNiebT0K5+YMOBLmik+DdEoHAdsJbgGFdnRPy?=
 =?us-ascii?Q?NQx3of7tNTbfDq0kp8nG6mBi+LiD1aAHyawUZNqvH1k5FSOmrBnA0XjobM4F?=
 =?us-ascii?Q?FmSxpkvrfIQkiAuH7c+04urjZLcsayjDRgPclj90GLsH3tfYT7XKRCYuXuX7?=
 =?us-ascii?Q?aJtfXkw3h+G3IJPESsXK5nzNeA72HoeJtYl0U0mK4Sm9u6y8nzpxqiaSQJXB?=
 =?us-ascii?Q?e+jVDVfEB29b3eM4+O3jGrQawapov2ab/BCr8BVFr01qx50TUVfUQiV1LDeV?=
 =?us-ascii?Q?7cjtZNhMMPPimM64rolb7mHJRT5qS/RwSMoqBk1idQM/Yy0sFHDE+wK4MPHD?=
 =?us-ascii?Q?YeF2B+9VnhXGhVIRgUUcBdJppQ4xfKdqDQo/lQQazxXxFOpUFQJKGGMT9V/9?=
 =?us-ascii?Q?nnwn4ywoYGGz38nhQMSpXNEbaYv5/ug6ZKJVJZj4imhqA+sSmGC6fOTm61pM?=
 =?us-ascii?Q?nGwe7Sl2i5EnXQYcakwGdUSIJibv2flgrcsoqCxaYZjO5mQdbPyvihbs8S64?=
 =?us-ascii?Q?eQTDDV6K44vtG4FaTyRF/Fnb1dZ1LO8WKcHxy3quum7qJ/7KMnEZMsWSdICH?=
 =?us-ascii?Q?6ND8S7MgI91/U/xox2e+MIGIxN8/FnANo3x4UEtTCHNh6l4VcYscb0Krk7RL?=
 =?us-ascii?Q?Kr1qSYUPas1/g+jayM1OTxUN0PUM0AoUz4YEsGKOwsMTRq3Y5fZ86hrOOqOF?=
 =?us-ascii?Q?vRjge+J/6s2a84GWZOxQC3E+TxAGmHwkWrUfVL63VEpZ/4Z12emYnen31WD5?=
 =?us-ascii?Q?36DLhys2XVyDeucTgW2HPQisZPL6QW/TUogv5mTG/w86fcu+5tcSagQISgsI?=
 =?us-ascii?Q?y5XhCczM9UjCcdx82EPEPTyKEHn/3GREmV7HRrtbuUk+Zg9ej12/dUcJcjkJ?=
 =?us-ascii?Q?ivALahYa5yS8QUMBUKxEHZ+L+TurR2Y1p83OaM3Dc2tTv35f8woDAnfMiFl6?=
 =?us-ascii?Q?gWQB4gSa5k7oWvTbgZTdqxiCZWL3JkbEZ0dRDfhndL8si6Amq1fqEDbkwY2c?=
 =?us-ascii?Q?dpP6QetrfoWmaoBhM5xUiLe38wBEMNwXN+h6vecB2BoPSe/PEA85L6cpw1vZ?=
 =?us-ascii?Q?fUodTdkjd7YY3uzwIef55FsCLIi/RfSReyHUfBxQMA0CKLY7J8BoLFlZ99rs?=
 =?us-ascii?Q?Bzh78l62qrPmf2ISGNeuM8G3X/k0uwc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 450f7bba-5190-458a-4923-08df238f35fe
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:50:10.3735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BIR7+dRtYxu2IkEv+zecvl4AkTww9tRQzeFOKrioGESczLHoyZJcQwjYSJeegTuWUJcx81ULwIv2P/DkaxoV57+USgs98UJMnjqo1FTcYwQ=
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

The e500mc, e5500 and e6500 core manuals define MAS5 as SPR 339
(0x153), but the existing definition assigns it number 629 (0x275).
Correct the number and place the definition in its numeric group.

While we are here, adjust the order of SPR_HEIR so that it is
inserted in ascending order.

Reference: EREF_RM (Rev.1), section 4.2.2 and 4.12.10.6
https://www.nxp.com/webapp/Download?colCode=EREF_RM

Fixes: 80d11f4467c4 ("Add definitions for Freescale PowerPC implementations")
Cc: qemu-stable@nongnu.org
Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 target/ppc/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 3fb51bbeb8..abcbcf3c18 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1926,8 +1926,9 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_HMER              (0x150)
 #define SPR_HMEER             (0x151)
 #define SPR_PCR               (0x152)
-#define SPR_HEIR              (0x153)
 #define SPR_BOOKE_LPIDR       (0x152)
+#define SPR_HEIR              (0x153)
+#define SPR_BOOKE_MAS5        (0x153)
 #define SPR_BOOKE_TCR         (0x154)
 #define SPR_PPE42_TCR         (0x154)
 #define SPR_BOOKE_TLB0PS      (0x158)
@@ -2042,7 +2043,6 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_BOOKE_MAS2        (0x272)
 #define SPR_BOOKE_MAS3        (0x273)
 #define SPR_BOOKE_MAS4        (0x274)
-#define SPR_BOOKE_MAS5        (0x275)
 #define SPR_BOOKE_MAS6        (0x276)
 #define SPR_BOOKE_PID1        (0x279)
 #define SPR_BOOKE_PID2        (0x27A)
-- 
2.53.0


