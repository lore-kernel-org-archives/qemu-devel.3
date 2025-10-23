Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B29CCF9E2
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwKN-00019S-RI; Thu, 23 Oct 2025 10:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vBwK3-0000sG-QM
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:29:48 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vBwK1-0001Lj-6s
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:29:47 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59N7EDBT3927941; Thu, 23 Oct 2025 07:29:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=/FzWYLAxVv96mv1ngoGDToKMmsQEgbnH2Zxf4fyRy
 GM=; b=oWffVxtYLBy6G6qKC4GHVFN09hXjTRgk1Y9Ld0mmoM0eZHS74mwbCi09R
 lY76HMhHdeeAQwkbBwmMJkfmh5qMzMQdO1HNdgN47QWDywMklzz43XvviwSV5mLO
 Mv749yYCZBmVfehJuPPLiW5XoJoz9dxaVlrfTjf5aSbZPM7bhOhiNqWHC4kyHP6G
 mv2GWIkMckgCwSe0R12+fofjPFG4wMmz4YpAkkpC0aonig3RffCdgtDeu/wLmsdG
 FQXdHpaCSD6S8Y3oZ6cUEhJQiz0fW8raor+f5Xxv4eI3q7oyhOZ7uK1lEJ5vRpoi
 Q0gdWy1yMrcnInrWGw6keHcIJRCFA==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021100.outbound.protection.outlook.com [52.101.62.100])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49yfss8vtc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 07:29:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7JnV+vNwbVM0kIW2whT19HSV5j0pv41NnEbtIZkkLGi91oWL0EvhNbfkAwH0pS6PiZqGNJ+nrJfARQoTrMzqxApeiMQ0fqRUXtbdcWytWHNwDk5lY5yVX/u7togKSo3M9hyp2HgAUrqYJe3ApCycgg9dpZTW7CTiJ0O8KpZi8Tpx99NZ/20GU4fHxj/VikVYAcpC/JmZfIvd3YIb/82N5qia6/gBzdqDKtSVzcMg7xWkrm/8eHcGy1/1OQgJHUDzsbPYFKWPwMIots3zcf++VyZFSJIPzV9++agp1+1a9ODmaT7ZqaEWnPFsh6VQOnZG3BUHYLRAgnt5yQqIwzidA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FzWYLAxVv96mv1ngoGDToKMmsQEgbnH2Zxf4fyRyGM=;
 b=SG5gLOcuj1Nt7OqHQe8+ipYHm+SlkjJXEuz/07K6b/C6nhwkq025BJnZZoITYHc3vpSa/13JO8N6POjCYcUlUBg9B9POKRA1ZMLvXIYCUsQNN3CpoKaRbDHgjT2KSsQA/LT7YCTgGepEr7o23Uq2qGqxP6lxcrtIa8+xEndRZBLmJtif+7mHBwsv6K/mm3vOmsdmB160igM7uOLdj33H5UCi930u8KDf6BDhZL6PX/r8lEc7UXsoY2GgO2RIXRxAKSqMpMWGEAi+PddEgRBsUJyh5uHr6oms43KWr2jRCEJucO95bNw/KQWOls7rsihhuF9AO2t3N6Kxeg0jPtamVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FzWYLAxVv96mv1ngoGDToKMmsQEgbnH2Zxf4fyRyGM=;
 b=RMm70XUIIt5U5ueVRGijzHG7Uc6wPAzT1BBA84FM3UN2bBUiIgWQDrHViiv7Pa4UuZYZEAvbz4gz2KlgBqLa1+AdopdXLcZbHfrAGhRIMX7ZXI/llTXwhUi45LnbmnDT5wwOhneSRd1p4yufCqSKHklxDSq/xMoMBkW51xD6eDCom29c9jLuMtb3Zbu6bSmlpa5bWI/CUybDSX1QA1BWPPk8y0wrL9hGyhPY3Lr8DeKJP+QlfnwaZcmFX9KdzdB25qyiGXaVtmX1pEOLCKldsKcpc8wdMI8FPSObi4FPOnwCh0EZwEMRTHzAbc1+Y74I+FmrQyFYGd/BYNHDleldNg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SN7PR02MB9331.namprd02.prod.outlook.com (2603:10b6:806:329::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 14:29:38 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9228.016; Thu, 23 Oct 2025
 14:29:37 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: imammedo@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 qemu-devel@nongnu.org
Subject: [PATCH 2/2] docs/about/deprecated.rst: document isapc deprecation for
 modern x86 CPU models
Date: Thu, 23 Oct 2025 15:28:10 +0100
Message-ID: <20251023142926.964718-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023142926.964718-1-mark.caveayland@nutanix.com>
References: <20251023142926.964718-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0133.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SN7PR02MB9331:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c17582-ca3c-4941-a515-08de12409861
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gxEe9hiSsu5lilWxUMAsL/e1+oL+giwnyKHUjL9pYi/Rx63wtsLhSIa49+js?=
 =?us-ascii?Q?obDuHnh264FmjAk9yO9rrz0N7Vuk22f56JNpP4BFoSf6v1LQ4FIU2NvDrw1m?=
 =?us-ascii?Q?aebN7roIGoWnlKoJ+lh+9tUhfVl9y/yfltOXEFT64U2/f06y317jK6iw/HbG?=
 =?us-ascii?Q?mPZQuL0bxOc9a3wB+5TB5II2zH2NT/bpFHOO4j3osFDdX/PyaIZ2d6ThEETd?=
 =?us-ascii?Q?ZoLCt6ZonuWL5BmRT2sJYzvyXrxP+3iFn//iDGTlzXbIQNlqHowU5gLwKDf7?=
 =?us-ascii?Q?JigIKlCd3IYtkaP9dvq4nSLbo/ffjy1s1bRvZfyDrpV4cUrUSmucIRJM0vjU?=
 =?us-ascii?Q?Igi8XjDcxZeOMseP1gp38JJxKRpuueU7nfokz/eUDOSLcyn6DZCxQl8J8chZ?=
 =?us-ascii?Q?ssQ0NrDryQ9ohuOv3PXwqs5dAkiqPZsaOWZMefX6fCvWASIeWij8I0uY+aSu?=
 =?us-ascii?Q?fitEZyj9ZJ7x8B9cGPRd7HPJJludnewiXPhHlDre6mAnCywek5QKdku2lt/o?=
 =?us-ascii?Q?ocOlVW91MHBMpQKea/4ZR/EQA1BosWYkTFDeP7QdOGQLMPcJZu2YVw0U0Of1?=
 =?us-ascii?Q?r8lq/X1CYjGrUIhRWy//7N3Un5ApQCZUUA+cA8MICywAm5CuR8iGHLY89EJ6?=
 =?us-ascii?Q?n/DUtU2HP/H34RbIucsnXDbXpHk+IEWwL8HIMgGWFrMOlAlaML35PDRe220D?=
 =?us-ascii?Q?XP81Dq2IOwhiSZuFtLUTSTdPYoPYAJX9q68bNTxRL2J0UgIGVm3lYTzgeYot?=
 =?us-ascii?Q?FoQpjPh7T/NwSk4JcXGbG9Vp+ahAEgM1W6vA94+5S2ukxFJFjDmADVXumuyP?=
 =?us-ascii?Q?wtXuAIodEBpoZnmAIRrn9JrM+x1XuFsRgZ72b0onuKsjccgt/fglM0Ky+fzl?=
 =?us-ascii?Q?LebPYmPmFYLfVvNfbB5OSei1KdP0r1stxbmvskZF4OPjSg0/ldPbBaFuR1ta?=
 =?us-ascii?Q?asJWkcLxLQ+IiMDjNc7As40elEK3pllxXNnz3USDRvysiWf2NbdpN4Jf1Dl/?=
 =?us-ascii?Q?K2bNYMxpI5PpPIUP6WWi4yUK5TIJ9Cj77b72NezKGf9JDuQtqtc8nQnvJakU?=
 =?us-ascii?Q?S/XUTI4AE27768mSu/epzH3HTb7kWLVjXHu5K/61G1GA3emYo3wUpURD8VLs?=
 =?us-ascii?Q?Avms5sAspjFjSRuY86mQNKHSlzPrVO1cdQjLKhfgJzdiEE84GaH4nt2AKHSz?=
 =?us-ascii?Q?5mrkDqJ27CyXi0WxWrmie1ndG3UedOE7rvkJgVvqAcbOQBuBF+E7R/IAJ5i/?=
 =?us-ascii?Q?XHUCyzE51nRFII7rQ71Qv7WAewjAR8esxNSWW3b6ny4JqTYR+V3S6VGo9GDd?=
 =?us-ascii?Q?diewwPr68UH8RBqp8Wov1ZpRwjLOLphNFjtRw/Ct5j+dYz21Hbou1uS921tP?=
 =?us-ascii?Q?QL+u7jPkFh103Gltw3S28fJRSODoMVP9FZx0chqAlNvP+pHwV2g9wgN+DSAS?=
 =?us-ascii?Q?OmURwJtqEdMlVe5QwVDFW8t62rtyc95k?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kj9VzBWLRbsKfZ4qSut/W4+ao5OUVdOMls49vsi2nM2+8KYKxSGL/F+zohKC?=
 =?us-ascii?Q?w6xjQUkcbXGy31D0ExCjtDp113MUhRNwI/D/hLHcv1UjXs4fkrllAF7SRJde?=
 =?us-ascii?Q?S3UqjJ6taZXIAffaXPsOaWRkNZ60nrHmblAghRJ5uARCibAp6r35yqz3Vvae?=
 =?us-ascii?Q?QUEihT2IdGRThrJhzqlBXG3mZXHtma1zcyMEii+g7DKroV3pW3F2w91OaVmp?=
 =?us-ascii?Q?LI5Ea8Nb3WKCE4t3tEoinDv0E5PLScDzoAPeBbwgg55H8wj1fCRFgawQ/oCC?=
 =?us-ascii?Q?zpPOnNNYCssqRua1qerFM/Dia4GLJur8aZv3OuZPONq4M7NrilwQ1OBScWzi?=
 =?us-ascii?Q?sypU4SdzmzBox/14oKfZuv75R0HtJ3dd9mBXcGWQiezJzOBF/7d18n62LD3Y?=
 =?us-ascii?Q?Un6gWVjRRZozqXHRQTzKCpio1gdf8SkJJn09h8JPTbTCRnHgSAlPPcVc2azM?=
 =?us-ascii?Q?t80Bs0XizssJU0Uoqsr4Dr/yxDC6Dg4TPJZ5I2SraEicwkRC1ON0jdIVor94?=
 =?us-ascii?Q?imSpV/cTt2zmSAh8nyJoC509htlkKcxnd1uvZBSsHdHYOXtHSZ7gNfCLsbea?=
 =?us-ascii?Q?L2xzMS2OwSASEGpK8+3mMELHNjeZqnyEzFfUgiXmdzIpx0/pD0e1kY2qfSfi?=
 =?us-ascii?Q?D75zQvgwbnRXWTNIqu1c3u6TUVRTTKzkPggoipnOZFRYnEQm+MdAcbLoxEEx?=
 =?us-ascii?Q?uwaGUPAiTm0KznI+1hunDCrpOV22AS2fBCBOhtKtN918hE8H+Cilcf5b/A0J?=
 =?us-ascii?Q?nErZNAGQrsVWr2GxK20oycPXTfYXJAvR9Iv19PvgojcH42Y3zPyoQ3CMyY3g?=
 =?us-ascii?Q?JQ5jadUqPibDIx7syBGPNhPME2FaeeYrntDrI0X3xTYugKszlH5E2TYAJKhf?=
 =?us-ascii?Q?IMJbKB5bonCtPQUhgrm1eBbCOqSB5lzHuMh+jiTdJeOyqF3ziMXK/c5dYkes?=
 =?us-ascii?Q?a4Oz2LZsBnIVzDH5Q1xps0Ld5IjAca1QMzEzky7IecmvOUkdWmYOgUooSsGs?=
 =?us-ascii?Q?vrhXiUOaSi7dA/y7BAmKNXvZ0U3ecsBwmfbLRmGU9UBy+5vWIX9EtSCUgJ6k?=
 =?us-ascii?Q?paS+JGy5/jLphmcTuJxRIrh3kqhfg8BHImOopkTNn4VX0Zg1hL9U9xybEiFT?=
 =?us-ascii?Q?7gkIYIlkqmuFCNusHwJOSjGiEPlOzofW+r7VayEzLrgC9bC8DZSWn0HKLeQB?=
 =?us-ascii?Q?C3a108HgHK7O0T6ZZbe6ulARGcgQUqsVtRw5APIvyUFxWMuc/chZpw554nZA?=
 =?us-ascii?Q?6BR6HCMxRlF+sWnTfLmTj2iD/JwnG6BumzAi92IjlQkLyy7U/k1uJs0MK4JX?=
 =?us-ascii?Q?SP8hl3/+w08OO266GWfIw9oJHZ20Uc1WNDYKcSHxDPeDp2kAZCIDezwq3+PL?=
 =?us-ascii?Q?f7noOlxuel1OO7dmky1CqWIy2kqslhv5Nq8OgiwdjUxIpwWolT48AUGGEh1Y?=
 =?us-ascii?Q?uj+xQYOmGRwzeXVwjDkaauh4ItNJIaWEjvX/TQK1JVyHjlC1UoKlJWFk5Tkw?=
 =?us-ascii?Q?Dy8QfcwAoCR7arZYy2H1Q5DKilSXQrq+EbTuHmRHJ3lempGnGeBurB6KVwLg?=
 =?us-ascii?Q?VaSMNO2QRllHBk03luojUDAe2kGTGSYbfgJeso55ctdpfojcFZ/KWqwyJS8s?=
 =?us-ascii?Q?ERMLauwV0kd6xRcji/xc3yV+2NHEZTjQFdYpFLtxq2rAuiHAhao9xlZQaxCR?=
 =?us-ascii?Q?e2oW+A=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c17582-ca3c-4941-a515-08de12409861
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 14:29:37.8741 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+Vx3hpeyW7/H9/SBuJwicZF+knBYvaA0eHbbHsFCCcPxJ6HFYRFUeNOi3YgwwnvmJWl+PCVtD0DNyq3avJymP6AYVW0M6fCvzTSth7wMTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR02MB9331
X-Proofpoint-ORIG-GUID: EzsdGajSrDRYfnQGCvvIuFLUIcijWL7A
X-Proofpoint-GUID: EzsdGajSrDRYfnQGCvvIuFLUIcijWL7A
X-Authority-Analysis: v=2.4 cv=IoETsb/g c=1 sm=1 tr=0 ts=68fa3bd3 cx=c_pps
 a=qXr7QywujOwG71/BKD+DQg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=MBvpz3Z36PH11TwarkUA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDEzMiBTYWx0ZWRfX1qQFTGkmlsK+
 VKxSe/aUeOtHRHYozzcZltixKEcNS7Xl4Y9MGlUwOFW8eepwqcAxKbilWWLJ85I6HNJZycc39nn
 wcPfD8YJYTsSnvqldhBLtST2zWBNNQdyEkYw31Ax2VukPItgimzElAX7bpF3Dj6m2s0IbznVbeY
 CrkoEApHHQErLFZ4uZB16BB21hBAwRRzCeGTmXiV4VT5Pc0QF/YbPF15ITQLzOctmZkGa665RP8
 nfkD/i5SyFeR3RTYwdhRQaphelorxyBlgLP373QmIV13tDOh+6hOupFSl8b4S9aLRbWjeaGYed7
 KOZTnfzFt9pZEA+Sh31K+s1SGQisIA1qMbTHWmR/a1rGMod22dRVK+Jc3ua4ZFjhVQruegzwIs3
 IKjjIqhy6YhuHEw9JxOVN548GzYaTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a new paragraph in the "Backwards compatibility" section documenting that
using modern x86 CPU models with the isapc machine is deprecated, and will be
rejected in a future release.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 docs/about/deprecated.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index dacf2882e4..020610132f 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -544,6 +544,20 @@ available firmwares that are using the current (wrong) name.  The
 property is kept as is in 9.1, together with "riscv,delegation", to
 give more time for firmware developers to change their code.
 
+x86 "isapc" board use of modern x86 CPUs (since 10.2)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The "isapc" board represents a historical x86 ISA PC and is intended for
+older 32-bit x86 CPU models, defaulting to a 486 CPU model.  Previously it
+was possible (but non-sensical) to specify a more modern x86 CPU, including
+``-cpu host`` or ``-cpu max`` even if the features were incompatible with many
+of the intended guest OSs.
+
+If the user requests a modern x86 CPU model (i.e. not one of ``486``,
+``athlon``, ``kvm32``, ``pentium``, ``pentium2``, ``pentium3``or ``qemu32``)
+a warning will be displayed until a future QEMU version when such CPUs will
+be rejected.
+
 Migration
 ---------
 
-- 
2.43.0


