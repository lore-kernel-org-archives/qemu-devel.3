Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2711CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN7C-00038P-P0; Wed, 07 Oct 2026 04:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEI4D-00017h-Cz; Tue, 06 Oct 2026 23:11:45 -0400
Received: from mail-japanwestazon11022095.outbound.protection.outlook.com
 ([40.107.75.95] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEI3n-0008Pu-Mh; Tue, 06 Oct 2026 23:11:32 -0400
Received: from SI3PR02MB9388.apcprd02.prod.outlook.com (2603:1096:4:2a6::8) by
 KUZPR02MB9164.apcprd02.prod.outlook.com (2603:1096:d10:61::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Tue, 6 Oct 2026 20:56:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJfo0UVklt5Fm5xrFWQ6grHnV9tya2I5nu/oo1w5CTOu33CtnN6OH6OUvek6EiaQm/2kE0EAILOzJic2M/iDvgROW5h25uye/gxVSFp8+QhadM4r1OwhV3h9YOfWB2higMKtiDlWOfVtOY5flcQCnZJXh7HDtfF5XVSGw8ILYulcM/d9BpYrelUGSYdmFyyPhHtfUDH/DyuZi3qs3Zup8rtSxaHVrUkNmDG5NEddv1CV4j7OzsSw+Bg/mUFz55uqpHUPXC5MNglPYVRfZaDHx6+ehmWZgf7DvLaINPo/Nd+XwnmkUqWK4GNNMHCd0PtnpGrZPE/ST7EhkMGKqj9Mng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AR69SsXYDwKErFiVCT+ubAn9A/PlNUlI66r8ngq9wzM=;
 b=bQINWXRE7QFXMEkqbwPhPTI1hwGND2EtIlpzXs3LQIn6AZojvfTeYaw1kwy4bk3ynoKQs2bpEf+yBDGKDFrhz6pifwYR3DsoYx49HVR7nC/P6xDQy8GyOsNh9Jqm7GhgSStEDR5TlfjmaObxP7y2Rl2pJba/+7NmUOqjkiUAKfaAz747YFhkRICQ5uY8YgBHxKyswbMQWjd89sM5XpNM1DIQEEV35Q4JGILyP8yIAox3v3kBzczoXmG0c3os1NzJ5nfm95A/BxBx4Z1BmEahFF9RuyHJjXhZz6+bYzpYLCIgNF8Zx6/+KpSl8Pib/99FvuWule3PLe8agV5F4c+5mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AR69SsXYDwKErFiVCT+ubAn9A/PlNUlI66r8ngq9wzM=;
 b=mtyH2q/x1PEEdBh7kiduRBPh2zeSkHwkHg3BU40dXtvc84dUk/cvSqmqaKVuHMhfmcYyqY+2Gd/kK+AwPKjuaoc3vuhGMymHiANPAp9Voq22e8yTOs/NqesBfGmZNMXy4eEkD+/ku7/PiKyyc3dnpYlKkzM8cLr3GgcG/XWtVzqyfnUDqX3GawXj6cxzuElvRIHaQDBz35XocfAOk96LYs1lIkdBahJCRvOWG0zgA1edlKeESV0Wv+noNUgcqWMaHiTQCTKbWYG1CFf+fPDz+XZDC3MbvGagudT0uB6jHkE1gdoH3JFg2OvZBEPx+5vTTiChG6zN2zo0ARSNgiwszw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by SI3PR02MB9388.apcprd02.prod.outlook.com (2603:1096:4:2a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 09:50:41 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 09:50:41 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH 13/17] target/ppc: Enable byte comparison and parity on e5500
 and e6500
Date: Tue,  6 Oct 2026 17:49:08 +0800
Message-ID: <20261006094921.110871-14-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: d2d3b4e8-385c-4d31-7bd1-08df238f4877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|10067099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: Tv2sxFefUWtrzvWWvI9P2UkW6PkQOmjTkxn4lr4oIM5CWSbQ+4qSDHzm67UYFOjZz6L+kUXYKWbcnGJXT1ty91VKkh5Qw1UW3qCU9FvJZRLeNJSJV/blTA6vfe0+w4ecQdQ8TeFobnsqgFX3gNZcYyXJocDE/CFj2J/veHWAh4gn+Ix0QAIdWsxgfokvahpO8QjIq6pWL0C61Cs2S4L4mk5vG/son6ImfhmRg4BH9M8AMJgeIv5QHWC5U2Rz/zs42+kL1g8v/r2zcDR2nbw11L6wgwcg7Q/Rs33/fAo4oR1VBjycLP/k8zdmUgJ5Sk0L4noP9eCe/S5I7cHB4Laj5lHf0F1qAsixqS7HSOR24+0IwiXyUTBt9SeM0Lnh2VDvsCXu7iRPraOWCIz2Ys9rO+M9gYUcN4qjlZYcHE7inmAIZ9+qs9C5CNamM81mBEUgkqs1tqxKnPzLoXxzzw9pDz6e439IHMqqbnomm/AH20RBZJYdpRxvGfJw1FrKYfG6US3r+Kl2/1YHrAj9bDx/YB5jt2ltKVa6xbEurtmC87P3H+j21UBsISJSPsnvuf27Mn19Je75QoG4HnAyAm/Xo6PjtvsFIx69JiFS0pNnIVhAQUW+FFWC4YdlgUBYTJxRb6P3bwXQFMfBVBA6ERYyC3UHmfEJ3CIFwRUN9ylGtPY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(10067099003)(3023799007)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IX0DbBaB2Kj/0yJBz03H2n5a626YLco78gHppoq3OvIiyo6de+AZfJz821It?=
 =?us-ascii?Q?yxoDQ4PZKphNB6UL8tYGaQkPCwKVJYsqCrRlnjQ4RF4L3BVotMVnxG0tvhk9?=
 =?us-ascii?Q?dSzzZmy4AmjQtqNRCSgbbp8VvUZG17f1QG3lOMy3LTiY9y+bd4p4bVOOliAs?=
 =?us-ascii?Q?YI/uFlCsO5UFPK2t6ZeBfgr+sMSGly2pMc5X/CI6rbk1ZJI+X9/oafaTCuzi?=
 =?us-ascii?Q?j/gTOARgdHZuhXEKYDmInmRQ3XGl8DQtecsCNHzYUaQ/2magJvZXTuR3UXF/?=
 =?us-ascii?Q?MJCad8xSSk2bFfrDiwOwrRGToavbJTJ52AkeKV1LaT5JskzIB2BpKJT2eCfB?=
 =?us-ascii?Q?3vuB8d/VpD2e6OZwzIDRUpNLDmQaxD84Qqn4YSp8jDWsIpt/6OwbXQXr+PGt?=
 =?us-ascii?Q?OLJErnxDK+J+RBrxHtyRFjiH11MuTVBrekwxtwaefHhLBQ7869ngFdGDhx+w?=
 =?us-ascii?Q?p2S+1tel9FF5L6EpNxyorWj4awkgtQ75wzdhFnQGFP3v1ItxJtgHFw7BhaUs?=
 =?us-ascii?Q?WmuJ00fFRqrHDeDCi6s42cFXd4ljHl0KfTsp+Rp9bmb/2ahAg0zg0GJ8OUxg?=
 =?us-ascii?Q?YWkhygfV036Y9+xJmmTecVvdDcs+93+I+pw0sCaRhBnHngWQfiFqI3X+HjD1?=
 =?us-ascii?Q?cWA+XAArEOtsQVo34cYrAUFpDfaLjy0Jp7+VYKw/aiKf6ow7RI0Uk3Cblllj?=
 =?us-ascii?Q?SKKntNe3Tl1kOnuhLSKrtc0sUtkqSQ75MV7JMCrmRoHlM7pZ9l5mXTaETYMW?=
 =?us-ascii?Q?SvLXn4D7Y4N/Kq+hk8pJpATGNXTKPweoU/qnykPKkr0x2oq4B1iBcgm9EN06?=
 =?us-ascii?Q?iM4L2soyZ35LledVYkhUgv7jjA3NV5oRvHMTpJm4cburARe8KBlPYtNGM+wm?=
 =?us-ascii?Q?sTiIv/kJ0/7y9OCvm/Bj1M9FatvpDn/QzAAxdipEM5D2y+Ru5z7PtJtwuRB9?=
 =?us-ascii?Q?NB2JVBSooQqdWeIOSiFkC6mVJGJLzfXtfaR1uATzs9y/z9cNgVU2QP/CSgtD?=
 =?us-ascii?Q?8TmlPQr00UDpUMw5eq/BlMkTK4jTGZUBOZIqNdOfk9o87f5rYKeDDwlowqui?=
 =?us-ascii?Q?wNCMDNkmq58pHDRKLUqvml/LKeYBpF0Ti/6qJrqJlHPfNjFZex8/qL/Q5XgD?=
 =?us-ascii?Q?irGOKHKmI+1gr/wBJ6tzLFVDVg2cHQjGbhqv+KGllbxsbWs+y2zxeURFAkAs?=
 =?us-ascii?Q?jgdJ8a9PxY1QeN36mx9NfFz24ENxv6BK/7YTh6WmjUOg3mGtUTwyEooolkVi?=
 =?us-ascii?Q?Y93Vh1UEOc33d3o/P56LIxpnt9pkEwvZVpencbX83RlIX4eCw+2x8SnpwJcc?=
 =?us-ascii?Q?cX72McTshvZLfCcoTELDm1oaMPosOgOpv2bbvctQ65dvFUOjt/MgX2etDgs+?=
 =?us-ascii?Q?HkSiXdZOMv9tpEL+BDFEjzXlt92aDQJ95BVO4/8/J2RyILtgYXRLqjsr8J+7?=
 =?us-ascii?Q?NHGtnV5syeFwjuZH35Ce2CWNAOplZ5gTcv8pMSBcuPGNTn3vELoOJeFeywUV?=
 =?us-ascii?Q?RjVlnGlGmp3EUZoqGFyMheHBs1flBsLWsI5S4gH/2K6ED2CJCQIRL1Hee793?=
 =?us-ascii?Q?7wTSss3plDCz1+Htn2fQSBXBSvrU/2S6uaSm2Sml2OQ6O/MDOzAQWjEEunfZ?=
 =?us-ascii?Q?snBpRZSnrJaDsl3WOOLvmicwZmn+jDNBzrSGY5gEH2gl5Gcljebcukmk17DW?=
 =?us-ascii?Q?Nvm422pmKXeam0mgkQz7FWVgQk5F0B+ypQ3l+AtX9Cr5d3S9qBdZ7Mm1Ffmy?=
 =?us-ascii?Q?u6D9JF/BWaAp36G9N+KxPpVmz0cJwfY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d3b4e8-385c-4d31-7bd1-08df238f4877
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:50:41.5458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4TQiyeI9ouSaNU/n3BbAr4V3AuKmB7Mkntz2vxIO0OKIOCBoVyxr8fMl5oCmjh8NVuLDinB/TbJvTo7NGHhJ2huR24ZYe2/s/G5WRAFYyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR02MB9388
X-OriginatorOrg: processmission.com
Received-SPF: pass client-ip=40.107.75.95;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

The e5500 and e6500 implement cmpb, prtyw and prtyd, as listed in
table 3-7 of their reference manuals.

Enable only the byte comparison and parity feature flags on these
cores. The e500mc explicitly excludes cmpb and prtyw in table 3-1,
so keep these features disabled there. Unsupported floating-point
instructions and extended FPSCR access remain disabled.

Reference:
- E500MCRM (Rev.3), section 3.1.1
  https://www.nxp.com/docs/en/reference-manual/E500MCRM.pdf
- E5500RM (Rev.4), section 3.1.1 and 3.4.3.1.3
  https://www.nxp.com/webapp/Download?colCode=E5500RM
- E6500RM (Rev.0), section 3.1.1 and 3.4.3.1.3
  https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 target/ppc/cpu_init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index f2a342b076..1c02354e11 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -3216,7 +3216,7 @@ POWERPC_FAMILY(e5500)(ObjectClass *oc, const void *data)
                        PPC_MEM_TLBSYNC | PPC_TLBIVAX | PPC_MEM_SYNC |
                        PPC_64B | PPC_POPCNTB | PPC_POPCNTWD;
     pcc->insns_flags2 = PPC2_BOOKE206 | PPC2_PRCNTL | PPC2_PERM_ISA206 |
-                        PPC2_FP_CVT_S64;
+                        PPC2_FP_CVT_S64 | PPC2_CMPB_ISA205 | PPC2_PRTY_ISA205;
     pcc->msr_mask = (1ull << MSR_CM) |
                     (1ull << MSR_GS) |
                     (1ull << MSR_UCLE) |
@@ -3265,7 +3265,8 @@ POWERPC_FAMILY(e6500)(ObjectClass *oc, const void *data)
                        PPC_MEM_TLBSYNC | PPC_TLBIVAX | PPC_MEM_SYNC |
                        PPC_64B | PPC_POPCNTB | PPC_POPCNTWD | PPC_ALTIVEC;
     pcc->insns_flags2 = PPC2_BOOKE206 | PPC2_PRCNTL | PPC2_PERM_ISA206 |
-                        PPC2_FP_CVT_S64 | PPC2_ATOMIC_ISA206;
+                        PPC2_FP_CVT_S64 | PPC2_ATOMIC_ISA206 |
+                        PPC2_CMPB_ISA205 | PPC2_PRTY_ISA205;
     pcc->msr_mask = (1ull << MSR_CM) |
                     (1ull << MSR_GS) |
                     (1ull << MSR_UCLE) |
-- 
2.53.0


