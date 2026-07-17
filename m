Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDC8C4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkj0K-0006Iw-F3; Fri, 17 Jul 2026 09:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wkj0I-0006Hl-35; Fri, 17 Jul 2026 09:53:26 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wkj0G-0002Wl-IE; Fri, 17 Jul 2026 09:53:25 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HCIuSa3907118; Fri, 17 Jul 2026 06:53:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Qi6CvEV8N0Z/quIGLQ195OqIYef5WAoSYWxHlkVzB
 wg=; b=saFCeBVLOvV4xS0VCZx5qAu9iS3VZAIvADlBxLoe/0f+F19Ut0NcfcbUI
 4jFpg4sqbDmW+092TCVXok96b3OF4VRjcx69dzq0nL9P5oYKnCZnVwjZj599EGV8
 wj0qbvKIGKpci2QQ2U1TUrTUy2tYdU4xae6GMSDMY/gCtxWU00TJ1cyskSUj0QCo
 k/tbsOnmxX8m11y3c/irb5BzMDStCRvV4P8jWiq3oBuzOZoLN2OXs7Dcr4S5rSh1
 YmEr8Gs3XpJC2JSp/UfPyBOS93f2Y1RF5j/RAZmbqU3gU+RwioWFxPVKtaIAhaIN
 MzPkHudzi4gZOKZMrdqQW2QKy5ZRA==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023128.outbound.protection.outlook.com
 [40.107.201.128])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4fedvwdqa4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 06:53:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQkKfzRIPdUnaesULMA8rH0I82mB0Ix80tmF83hBNYcp0C7SagtV4LlmSR4grVMmYPx+Cf5sRXryna7Ow3KZNcewRNB9MvaO15vS7bBmHQkYp0lf7tVDxk6+prZ30qiF6PtyKMLpMP5ZJ5h7w/7bSSh0jteHnu1lkRwbCKIsuO09KypgNOq8yYS1aKmTevjLGml0U07PrZvpyqeY4/Fbnh4ATegNaPnfOOyte8eao5QOCfwov2fmdIFs7B2redm+eMiqL+4b8+BQetutE1Vm/YGVDFopy3jhBsBXWhiDB7wOVrupn60JG9ImgS6ueVKk7hMVTGilENXZMvydu49d9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qi6CvEV8N0Z/quIGLQ195OqIYef5WAoSYWxHlkVzBwg=;
 b=OAeOpZupTaDr4riCZPmW7qJp8c8xlncu2vSLGC1Vp5ORVPXi1j/07TSEKaxf3vI6YA84rEbWJLZsYdjGtEJR2aWoNRHqaXsXqohHxChIa+afQUdQtiMVpVnpYAgabMO9p5mkH7c/CgxbOkYNDJEKPMS0pwjuq99EfILKvvon/Q1KDB3v3xfOdQcpO5M/dptkMxHDKS3kQu79Ye6kSDaGFpp4q2kMmNKAjVA8XB8roJV0PEg9Up335x5O5S9SJ9sw3MMmsUwRKhpapywu1AxSIW8l8DKiOq58Xq+fichZYX63PO+pYtPIx4u1mdFThEjc6fOsJO850vjP49Q8iUj0xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qi6CvEV8N0Z/quIGLQ195OqIYef5WAoSYWxHlkVzBwg=;
 b=b80MCC6u+W4M2ie8Swu+sFTlfZzvrq2FCysYjTFdALXQhj+3yOjz7HJYLZRNJ6vf5S56ycEB84sLTqV5AOclmvR2bEIp/ghjDuiSvTkcNUMNasNtfgstY2j/fvjbPDOYT5tqbmWMzk8qAIDdVluWUKNWSTrwDtRkBQB1sC00pSn3CyNWwoZu3Hlu+bTK4SnsFVuGzpY9FEVGgGTwpHEQ1BWHYJ0fNSHkjX5iLUAWV34Eb4L1tZp1pyQG67ffyYGA44TQaQ6V78jZRnmKjNexf1M2tUOXomalTV7+nOhpgiXJu8o74DVbtukKBfc+4X8690d3f2C0NQ8ntOs1Iye4eg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO1PR02MB8540.namprd02.prod.outlook.com (2603:10b6:303:15b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Fri, 17 Jul
 2026 13:53:15 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:53:15 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 pbonzini@redhat.com, berrange@redhat.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 4/6] qom/object.h: rename @child to @targetp in
 object_property_add_link() documentation
Date: Fri, 17 Jul 2026 14:51:44 +0100
Message-ID: <20260717135254.508701-5-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717135254.508701-1-mark.caveayland@nutanix.com>
References: <20260717135254.508701-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR13CA0058.namprd13.prod.outlook.com
 (2603:10b6:930:11::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO1PR02MB8540:EE_
X-MS-Office365-Filtering-Correlation-Id: 57142ba4-8c0b-49ca-291f-08dee40abff9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: P7JN6LqEXD4+ouAmwEKLXMs0xpGCLXks8GFP+QwNwhqA12iomULKZQcIRvOFfBF2tJHxdaqFEMMOLHVrEcXlMcFtA2vChuszyFq68W7hs6rdkfiM3nvOBuNwtgHwp+6n4mgBwQWXH1XtbN8a2rFOvKSUBaUN2H/ySk8n3bsx7QlnNKNBn6W/9Rb4U84kafheC0ZjX7vR33Qmgo8IHIMHMvsvH44vtltYFFVGpvjYGtNHtkZDKEifuQEeZlAZ8tVLyqIt7ru2h/ONsw7tZ30hsxWnofoJc+6icPOu5Z82GNSEWt08Ts1VOuffX3dsf3RSmBpPdeAshJTtA6cU6LyNBLUN+J/WsUDCofbViilvW7DEDrf3Se+v+5ENNwunJRGcz07jmwTOtnNwYrp3rcWOCzQs1Qd2ipTTWIYLsKMPlsySoqSdXtuFUQZvqh3UoQdbrJ+thuGwP6cKVwsLMUAWFLt5mY17wUZJjgAKFOsY33aZtjXJ9SGJtgy7vqyWimeqaxpTVf9RCsCIe3ssMFPTl/QnI09LScLHAI93S6uAhf5nA+znZ3rx1koYW0HSfdhYqw7Xwi4YiffyzLZpKX96Ef/CcYAW/lCjCcMX4WRZr/lX9La0esSBx9NHeLFyLk0e3zqc3LEkPoYrtTnUSyh1Z0fx7MP5jSUGfwplc4MIHlg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uQrHjvKIhv904TjycctpHvwcMcX3x067TrCp4jnIm/s42ak4X1W/tKcAMuv3?=
 =?us-ascii?Q?9eM6Be5wcl2kttf4M4fBAC9sqkC4iGWe12rHSFQSbInguLWDR/6tA7A+Cljf?=
 =?us-ascii?Q?PAimE2CrIBfA9dJm4P7E4wsl9DNf19JkdFVqGtg6aHDTcsqu/1n57TV9Uxcv?=
 =?us-ascii?Q?SW3DMmZRjWp3MmUaZ+YTVt6Cw1mylAZ9r5LKcAQw7+e5NMBEZLAfnkBqQxBM?=
 =?us-ascii?Q?vM6ErB6DWHUrfOipLiY1Dzd853AggifrrGr2Xqcd2JYANeNpL4JRFzO0A87W?=
 =?us-ascii?Q?sPa4ayaMoUQ2UT1VejyzMEzrNEeqWXA/HDHz6t9EppenOdO4w0Zn32pbkEpn?=
 =?us-ascii?Q?+EwByXopZkLRYrfQHuTyUzFOds+4eKvxQJhw6hnt6FZNXKfs+ksVJe4mzg7S?=
 =?us-ascii?Q?ripY6LjBSj4Yh5+yD6AAldeyk1rKiPTpirGqidkv6TNa8cUu8Ts2JucTDhvN?=
 =?us-ascii?Q?8M0wZCHoEkd8onSblDTH6FTSm4o/NFORvCEAcMp6DkgJsblVErNexqimFRGe?=
 =?us-ascii?Q?AZkN2Wa0AEfTmKxxPu5PEJkynxcOOQyreE/hUripXqPOQLpjf6XDwFH6OCKA?=
 =?us-ascii?Q?qi4jeohzM5SSItIQxXLzejDi/hCLIvrowNbVL1LU0b6akJPGITwQ/jcAMm/+?=
 =?us-ascii?Q?CO1dRcIhKwpM08UevpBYIu/acMjqdXPbyu2OuGWIKt+kenMcJkVDRvxwci3w?=
 =?us-ascii?Q?KYSN+73jEncW8tT+WIsGx5I8QdHLs0KOHy6dQVYgqbpnKDSawewOzstyuv1n?=
 =?us-ascii?Q?fL1cG/TVpSO7ltiS0m4J+O+fUE9wxVkBBj+GU/tRhRmEeBcg4L7wQ2gR/TrY?=
 =?us-ascii?Q?cLu/TB2TWsjO50VDW4q0uymTMIiiidN/QBrQJJl1RsPXhX5uvsOdmwMWIp5W?=
 =?us-ascii?Q?+cmDyzsgXIGJqgTMMAglSFvYMNQ/t2G9nRUO+3AjAp/znuEoPE9Flw2Tso7E?=
 =?us-ascii?Q?UElAQFKFNCYcBypRqqwl4Eit5QESQx2lICWRTVp02aQU03Z2k5byX/VWivTn?=
 =?us-ascii?Q?IHLF5Uf+sxC/ruHwS3THYgiI+WL4th8++8Mv09x7dUmKw3ZR4gHbUZUSc9GY?=
 =?us-ascii?Q?TcSZ7gx4+CtcVNu0ucR2drigf1hB+5onDvC/jGnxlke+ca5H4q6aBhqDpcfH?=
 =?us-ascii?Q?CePAuS+y2dj+/hht+obfjD7Ph6+qG33NWkd7W1KXsUCS6/NpgDZ7wqq6S0Ad?=
 =?us-ascii?Q?/XhlwP3QPM8VDOMSNq992pgRpVC6rJA39KtjzhNLpmLf5GHAwwEkYMTQliEO?=
 =?us-ascii?Q?Gse8bD/LjyjTgrWJ90EWqHikRS/PC5DQbwtHJycVvVApZYVFWjRhx5bAzrFp?=
 =?us-ascii?Q?/c5p76Wt+39/dYrf82O8ftZ++ApdPa8kNeWcmovS83EnoyL5Ytkf92G62Wk2?=
 =?us-ascii?Q?MGYc/Txn9V7Cfrz+1Jd+t0U/ozPjMQQg8LNq9Q0ckANNkox5wZbaYJK3BkI8?=
 =?us-ascii?Q?jRoivJ69v4c3CEd+LXZD/Pi6e1yTbdX1T8pwfV3Yc2n8OpEMmmXmYxowgxGx?=
 =?us-ascii?Q?CdqRA+/PTYZmX09gTqU+F397nnKVCd5cGT+S2WDngV86VVMRBnoSHa5EthDs?=
 =?us-ascii?Q?KlEE46i1yLdIDgW9rRDzLLRV+xsVVkazPvklCjXC6nlX51pMWx3yy4D5qVl6?=
 =?us-ascii?Q?ZT42LXwAkLoltSmIhzvScHVuLBn8XgA/dgjZvjro3UgA8k04SeW3ZIbiO1Rb?=
 =?us-ascii?Q?eEP4bchE9Tm78c+gZweS2tnY1wmceBtUpj9FKvhmCPrbkIeqzl4vKvtsVZmu?=
 =?us-ascii?Q?+KTZdLj7aUTGZtA9BvNMqLmawMGsqSU=3D?=
X-Exchange-RoutingPolicyChecked: Ii7AXiwNaLcF951IYK3UXcwB8/wnQMG7dleHuhlGjSZyauFELuUwX6QWi7/aSx+M1BUcALzFPp+tMjtNbfDAV1akJbPd9G+Xuz/BO83pXhOzlDgp+AyeIkF0HxDsdJlWehixwTOXgOG1U2MICnKkBJvdjvrcwxEk4zoual5xm12GLlPPO1+NawGKjXVto1lESdo1DY+kGpGsxDKckAdVE4R/LrNSDKw9+VlvQ0HC2WMUWVwtt7J2d1JaEdHJUl6m/RjETdE4otltFnNrC1Yz0CzswzJV85XLT4fpg7Mee8GJXsUBaj5aqZjqxX2x9mSYjM63w2b6Pw0elJfL69Nbhw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57142ba4-8c0b-49ca-291f-08dee40abff9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:53:15.5456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5kkSiEkYZilDRs3KYihD9NL+ctQgy+IZifGHqcdhAXIGbYpK3cRBQAiEyzaUU+k64q3kgwvfgZwQ9ZutxZIhmWd2ND/6ha6TJMVVPTuKrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8540
X-Proofpoint-GUID: Fs2J8Br2dPvp56OnOWNYFsgkf18ui0i1
X-Authority-Analysis: v=2.4 cv=ZOTnX37b c=1 sm=1 tr=0 ts=6a5a33cd cx=c_pps
 a=oKUGrOEB3UyG4cVvJxNfUA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=pqCvvIL9VGPUZBSA2hUA:9
X-Proofpoint-ORIG-GUID: Fs2J8Br2dPvp56OnOWNYFsgkf18ui0i1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE0MSBTYWx0ZWRfX4zzR1VLXJRpn
 3lpiwy/mMjFhhj6gjpsVszceKHkuncCZ80gMdP2nceQfGQbrZptut6bat4fWSabZ5B9bMhp8u4N
 K1g426hUJ1OmgzgonhT3zuFDh4duJlEpdn2HHTs/wLD/Op9UrGXcjHs7uLj9P6wgh0bR6DhrGJD
 OMnYCpYj6xHSrRhrjYmizQITMawsy6/rG6bbrjk+4ik7/hpN2oQ8OfDD2hss/8/ZN2ALeo7zbD4
 L+gq1xtXoo8goH7c5rifZTWRS60qs/C9I02BOi7beIBXtAAMohqlAgXRPWrYyr86As2tfDyc72J
 XHl2E5Zy77d3gq3jRjidAPIwPVytDF0tZw4/nH0CAAjOr85wO5Wca8a86mRsxNYblGCf/ItWgDN
 Z9nAomP2dAg9GjyELAO1QsMf30FfyfeQWClJS0iBuLJbq6IcK02uBNaGofh55DQF6b0sGBZJ9Kj
 O/aMioW/xG9B2gVi8fg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE0MSBTYWx0ZWRfX0LDwN6Fe6JlS
 M8mXtEDPLWOixWqkZP4uGrEUU2tvptJ6rRmP0TsU8j7pKtorymUPvM3DIaGaa6plHU4SbTN0HMM
 24NNBu6RSseVE7+q3ntBEeoU69ojK3Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This was missed when updating the parameter name in commit 36854207f0 ("object:
rename link "child" to "target"").

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Fixes: 36854207f0 ("object: rename link "child" to "target"")
---
 include/qom/object.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 11f55613fc..4e7fe2af7c 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1802,8 +1802,8 @@ void object_property_allow_set_link(const Object *obj, const char *name,
  * property is read-only and cannot be set. Care must be taken to handle NULL
  * values for @val.
  *
- * Ownership of the pointer that @child points to is transferred to the
- * link property.  The reference count for *@child is
+ * Ownership of the pointer that @targetp points to is transferred to the
+ * link property.  The reference count for *@targetp is
  * managed by the property from after the function returns till the
  * property is deleted with object_property_del().  If the
  * @flags %OBJ_PROP_LINK_STRONG bit is set,
-- 
2.43.0


