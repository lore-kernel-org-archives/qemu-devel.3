Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDDECCF2E3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIm8s-0001lW-Gx; Mon, 19 Oct 2026 08:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm8a-0001LS-15
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:44 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm8Y-0004AX-AO
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:43 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8QSxt3508824; Mon, 19 Oct 2026 05:06:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=aSoQnzPVPKCptsUfYQKIegr73fefTWafbQ2RSswwh
 KA=; b=VK68Y9oM/NpGpHfhaAP1Iqc3P87/lhY6UOghVZeOOXx5cRHLsJpX/xBdk
 JBUANJd6p5OfOWPl7vqjX8v9lUo+vz2e9yjrCcqtJT+BlJxTyJC04aAJl/JoBeOp
 qxSNsfRY93go8/mWECc9fwVvEoM2/y9NY4zApGvlh8mTx7PzSgtI3zwwbyRYxCpy
 w0YhB08kd0k1VwyOs2qzKIYdGLMl8DdrBGkEnRhGBUEbjRmiwRvpkcLVaaTNfOZC
 dTiU+nSFkwQTaMRw+fdv9BnYpa9eNu9xxObIHTJ8eUybxNtuxisiN53JMBYcBycy
 5sI2eOkEv/2pgHE8RLWaZCrHDbB9g==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021112.outbound.protection.outlook.com [40.107.208.112])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hc4x43qqh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:06:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6nx04cexwgcPhULTSsawVbo/t9r7qR6GuCv1lEFdxBu4hA+2ctqWetoaukJYo0s83QBFl8wf7d46x7XZInRQgneZD9SMxw4YyXp8V+hsHHfGhqSdHA8a+FmeIeCy89gxti8+wBAJGS82k2+eZDrBmdiCfQVDs+x/R/w7b5NxlUdsTyPpGlc37sVULTQDUjWjT5dpbJWpLkWFYzgpjYGnzvg4vWkybj9fCRlGyC533vstqZmVXAqqepbj4YBaW7wB8YQ6EFiUUXdrcvnukpDc8FDDGOJ0E0tEhJVtUA0IuJugPfOoTt9fF725EXyG30ROyn2TFD7rXJwOiNpaBfSIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSoQnzPVPKCptsUfYQKIegr73fefTWafbQ2RSswwhKA=;
 b=I4vhN8moj9wzuYqvcu5SQ1etTTMIo+MZBQq+1wF8hG6vZXxFasHZ+8pSJJYGfOngKxkYp4ojzmaZ3GBPMcgmWqjBpYZI1oswFMhsBy85cSKmMjeGcGAaVhdccKaQkev7VHAh+Mvmq4Mwo+yiG4R7+3A0rRstl0l238+sr+76/4EgevHbQnTLr5ZPgEEGPWtwHFt5C5jiVjyduf0ughzJaHqDWDU1kmzA7rDWcdGgPMxak25Y4fOh6MgH21sQQS8v+sQTqcyA8PhyviBWe8mB/98e6IBawo+5IjfqMapAaS0FjQlE3iuc9jzKmi1XVcHCI/XTomQ2dtGlu0fq+QhswQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSoQnzPVPKCptsUfYQKIegr73fefTWafbQ2RSswwhKA=;
 b=PLdkFuc+LxWzdM2OVJm7tuvaNjVFzWcVceLIINxo+4uLeVE3ltZUqbHqVIyb/4w6w+Kz+RdVzl529asHIb7b2CItcqjrKGBXGma+A8Ma70zCaVxssBcjdDtsDT2Ozp5fk/5K/chQp1tyScbco4EQ/QSXIhGGwaWy83VPUKjf+NMlFMrvB38N3RTO+2EjlKVOJ0Y7usT1OOWjY0YG3ALBYB5uf+uwkQD4ACSrBiuuwvP62dIIYRFedHJwg2KsJTkbZPSbUsRS1uUT7v3591GvfrTEISlkU/I4/JgfmOjEXGf7j/y1XuB73ndeOtifrmxMrdhn7cejBbvGr13acPcEjQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MWHPR02MB11820.namprd02.prod.outlook.com (2603:10b6:303:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 12:06:32 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 12:06:32 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v3 22/28] xen-hvm.c: rename xen_interrupt_controller_init() to
 xen_i8259_init()
Date: Mon, 19 Oct 2026 13:04:54 +0100
Message-ID: <20261019120517.1448687-23-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0192.namprd05.prod.outlook.com
 (2603:10b6:a03:330::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MWHPR02MB11820:EE_
X-MS-Office365-Filtering-Correlation-Id: d13180f8-6229-467f-86bd-08df2dd96a2d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2xHenfZFJXFV6Tj3130LQ9b8nJZ4yRuDDWUJnAHPja1gzBzpCvoB2whdGzN7u+dm0NWzXm4wJ6o60d47GnLzt8ffyiG3j9cWSE8uIjmPoOpAAcJ/pZa/c/2xBowG9yvxiBrHak0sbLSugWt9bn2F/qLQr+1FN0LPqVuaN7cUDWWwJKtbG5YZE5Be8SDZLVQQjPUW4C+k3RvoEejh8MXglRghoXnEz0bBzUGGJqPCtTrBGHgtigFv9agpRr2z/umeL9r7R9FBsEHdCfq/KsKdO+I1xETSPyFSAn/pk4goXSL3A30N7+HufmqCmTs5L3Ti73YQiseO1IgWkeQBIIvUja2J7Fj88Xs63sMfYp70ALthal3ejM4mqv9p/IW0lC5+kQk4eQtQbwcIn7B4Zys586VF4MQa+6nEtAwAwrORSW8EMeaL8hBNmNSMq9zWqt6KYjDcxvES1XjiWrbb2+off3KN4lGOpDllTFEzqMq8MQgzxByb/DYuyAlea7y18mBye/bAjneMn8S4fHAps4Xaw+UTtDDPzxBwRbRKUvG+EHjUWmza7i7fehLss+Qly7U1863Emp9KE9VzXbiti7GTl1XkDXcdoqCCYAHPidhO4TJuXCsTOIYoP4llPKEZp2/EELMDtcPAR/PbrIlkLE1aPR7URq86DP75Q6RFMEOdBNU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2mVvgeEhxrZQJBg2RFXKtRROj4cG//vCg03GYhAKvjhUqJZAo8dOL6Jv2vCH?=
 =?us-ascii?Q?EB5yOxVzEaKP7VMETzAV8Cnhkjalj9IaojnAeAOrP9iQYKTmC9C52EhVq3Ft?=
 =?us-ascii?Q?HD5ckpJKJgZkT7Wd2l/JNPvt30t0EiX4fTfaE0Ny1YsPE7g9qpAT6/ypaZqs?=
 =?us-ascii?Q?lp3dgLbK/8kqxBCo1PqZuTRcFNiDqHSXfOimOYU/mOk6aqw2voU1Km/iO/R6?=
 =?us-ascii?Q?yf7HifT4AZ/s4gf27OQX3F8hM+t9d7zuE5F18ehjABG2abP+ymX6xS96Cmaa?=
 =?us-ascii?Q?LoCbhw8VK8LUmJAgAZITjUS1FK6VWX6wyngMA3k+ywbegVEhvj+er2YHPshs?=
 =?us-ascii?Q?JnDdsYBxYknuB2JRkOlUhzpEVPJ/MU3A0Z4M4YwosrqBWp/I/mm2HLA9QcSd?=
 =?us-ascii?Q?0TJsDKrTGgLrbU9HyXXuuTwPs2KjYh37G7K+d23VVQGaxOemIw0kciqguEkx?=
 =?us-ascii?Q?N9MPwh5SsOEi9Wvq88+FreSZjh5x44wlZRR1gfXkRBSGNz6UONKw5ZHTOfH1?=
 =?us-ascii?Q?y31spXJOi/0yrqOiXS7WzhkKA4brXxzxFcXsBpcZMqDZTtSWZSIWrpNn6dC6?=
 =?us-ascii?Q?rVFL+OvFUy4jqmgJEJJ//4K1FUBaobl4/p4OugkCbwdXATDQht/GL9lVC+bv?=
 =?us-ascii?Q?Pd0HU8yLWM+WCtEryYX/xySBa4itVGECTBjkW793OAkKQ6HS4EyNNIL4DL0y?=
 =?us-ascii?Q?YcpcT6y58p1noiWCKofDcAjKq1e8Du9cG4v27KbQ1Awz6EBTRh0pj7+igBg9?=
 =?us-ascii?Q?MJyd9OGut2McLQjnQI9t7UxQ0h5gdbwGkdvV9JPY+reMmhWmCta2RZv1w3Su?=
 =?us-ascii?Q?6UpXbC6bl9JSGCpyj4T74PfJUcjx6YG9RNrj60MpMyYciF5I+OUsSotIlUvx?=
 =?us-ascii?Q?Q0C57UwL4zl6vUZoCzALmbaEY0SINcP1PvGf7WX5BnFu62xFTBcXxntD5eFs?=
 =?us-ascii?Q?OgGofg7Og6cYpeZwCn10z8GdIAmKSKtGljonNEw6T6nn5mT7zoGOd7h/0HW1?=
 =?us-ascii?Q?TA2iZTdDQJ1nFDAnJAa9gul2JSuU/JD0t05Q2tjiri5mv4ZifZaWqb2TzpZN?=
 =?us-ascii?Q?cM23gyQvsrpoXMU7iGu0si/uhLRzObUQeeU52A5FfQ6SMX4HJJ0cfT+mNTbN?=
 =?us-ascii?Q?eWtgGjwwyUN6ohKvcT51Lp8Cl5IK1BXt7LCTRuerUDpYLYPohDNxNyN5BSL6?=
 =?us-ascii?Q?mUeP/R0V1sRBq9aCVt4qBMZbGN9m2wUCpTA6pWNSMnKrbRg78eJTR7Ypdhrt?=
 =?us-ascii?Q?bm07P1RehKsrWB+xfZxYORgEzijzbHLnWFGlXuxuaUiam1jZbQ9kIta3sMBB?=
 =?us-ascii?Q?SUtHJJxXNdsUS+mqXERxvLuo5HeS1coIe4aAHiTiATKmf21JdEaKIUBUkuOK?=
 =?us-ascii?Q?FEPIxyMJnwiDXiggeeaiFTXwkS9/vhRvNDlXa+O1VoeoZ4+zccISB5Qhg0EW?=
 =?us-ascii?Q?ly5bxCU7j2UceUUy8gIWRPRH1COVN2IMwzre7sPQ/ijvMBV4RO/+Ip0PcEz3?=
 =?us-ascii?Q?YrgKMih0PlRa5a4Z4oEaxROUfbA2kmL4v8o730RYyer01DC7LCcURn+POpVh?=
 =?us-ascii?Q?gmU97M+quToOkNZkbcM74C6OWmL/VY5vnAESMPmVSFvqCONxILpQZ2SEuzdF?=
 =?us-ascii?Q?ZLFzEzOp3VSUEKgafCOfnUhLrJiR8QpHGKkBcOFZRueHWpiJr17bNehMuGq8?=
 =?us-ascii?Q?HlVfu8aQFd8/JZaWp5z8noVOZgBa97EHQ1+mRhytkSbrnnsNzuzC6ZY19xvL?=
 =?us-ascii?Q?puS6ubWWRsQ71FblJdTWJcpzT5l+lOI=3D?=
X-Exchange-RoutingPolicyChecked: fKgK8mZEXBJuS7tQLcuNr4494lnBTK8uwwt38x/YDcVLR2y093eT31cpQK/SMDO1A142ylMi1k0Hlm9KWNjUrqE2cRS0r6lz0vU/i5CXhf0MkECJZrw31p9Ro1R+x6yGduPH9vcLIHCo0eD3UNe57V/9Hcd99uVy5sdWT3lJIxUyi3LiEVX0zhiMyNxBwfeegCY7LGSS9NR6UR0DjJB5MhgW5d+dM1GuiVp2TpzI0XLkQ9CmSGz40hKqhcM164IXaX3/cIyptUe8MvhnGvH0LXXJGdb5/zQpeoXSSONwerPqSRuM+qo787su1DcDPqIM+dJryIrd4YNXC8N8tBfykg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d13180f8-6229-467f-86bd-08df2dd96a2d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 12:06:32.4994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NaYxCez8D25gqwHMCh8wRJ3uPJsTjnlSAF6Xky8WkbhkLKDC1LYE7tTAlKqZ4DQoJwqOwFeuAzidk2uuxLGLDQAdkWKXp9SgwU5AGqPbrS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB11820
X-Proofpoint-ORIG-GUID: CgsKdAUEX5Kq2m1WKwMuMd3f41NK1D-t
X-Proofpoint-GUID: CgsKdAUEX5Kq2m1WKwMuMd3f41NK1D-t
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX7z2mrku/Sugc
 0twb3jd2yIwEMFDyOli5EU7Vcmr6hr2dj9vT+u9DKBF4RxqL3MRFmmVUgGwChoU3kiFxCk4WcOw
 F0EW62qChxx//mAptHaUApIFdmF+XOM=
X-Authority-Analysis: v=2.4 cv=DqHDa2/+ c=1 sm=1 tr=0 ts=6ad607cb cx=c_pps
 a=wTfA4ZSRtyUhnooKhWOBPw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=ufYRZG4kn_nPcl-B8swA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX/A9NLfRIIpUl
 4BgcYpG1UXAYkEqB+UD9alliCEWIG0ELmS94/wAAsPdkZEahG8rybVFYPK51+aLXwvyis3Gbhc6
 XtjJ7bHZLZQ6WAtaR8bCsXIv8rRA4Ey4BkXvEO5nEkWmKaN77MFELgIrEnbSIFwEnsHl5R0fwPq
 FnzJ5mVjnVo8LhfUcY9iK/r4Ha0IabtW9U7El4xuvmlchUzlYLqVcXSgfSnFz//iFkjeTVY//Wv
 EoG0xefIfS1Y0WPTzoW4eI3UwhmRuTaGKu7cevd+eVn+omfSYa2dLLIWtlTsioRVrxniFxG24/X
 wEzkMcCm1lqQJ0CaWvUT8MTJLSoxJlKT5D19upB9KQOUldke4TLA39+vz03YESwMDZqMRDEiPgV
 eJ5zYI4PP8L/norf7UyetGHKOuYfILoLzpZpWeEpDbMjOTVGU6gOsAdbF6PX8VStndpBXJNK6p9
 1hVaWmEgcHnL00HXnJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

This clarifies that the interrupt controller being modelled is an emulated
i8259 implementation, and brings the naming convention in line with the
in-built i8259 and KVM i8259 implementations.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/xen/xen.h  | 2 +-
 hw/i386/pc.c          | 2 +-
 hw/i386/xen/xen-hvm.c | 2 +-
 stubs/xen-hw-stub.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index e94c6e5a31..ee4ed4f11b 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -42,7 +42,7 @@ void xen_intx_set_irq(void *opaque, int irq_num, int level);
 void xen_hvm_inject_msi(uint64_t addr, uint32_t data);
 int xen_is_pirq_msi(uint32_t msi_data);
 
-qemu_irq *xen_interrupt_controller_init(void);
+qemu_irq *xen_i8259_init(void);
 
 void xen_register_framebuffer(struct MemoryRegion *mr);
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2d8c87b0e3..dbfd55de30 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1167,7 +1167,7 @@ void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs)
     if (kvm_pic_in_kernel()) {
         i8259 = kvm_i8259_init(isa_bus);
     } else if (xen_enabled()) {
-        i8259 = xen_interrupt_controller_init();
+        i8259 = xen_i8259_init();
     } else {
         i8259 = i8259_init(isa_bus, x86_allocate_cpu_irq());
     }
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index d3ce082e07..af3a90987c 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -112,7 +112,7 @@ static void xen_set_irq(void *opaque, int irq, int level)
     xen_set_isa_irq_level(xen_domid, irq, level);
 }
 
-qemu_irq *xen_interrupt_controller_init(void)
+qemu_irq *xen_i8259_init(void)
 {
     return qemu_allocate_irqs(xen_set_irq, NULL, 16);
 }
diff --git a/stubs/xen-hw-stub.c b/stubs/xen-hw-stub.c
index 6cf0e9a4c1..b3e27f0292 100644
--- a/stubs/xen-hw-stub.c
+++ b/stubs/xen-hw-stub.c
@@ -29,7 +29,7 @@ int xen_is_pirq_msi(uint32_t msi_data)
     return 0;
 }
 
-qemu_irq *xen_interrupt_controller_init(void)
+qemu_irq *xen_i8259_init(void)
 {
     return NULL;
 }
-- 
2.43.0


