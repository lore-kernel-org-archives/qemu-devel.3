Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A11BC5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwgVe-0000z3-1d; Wed, 19 Aug 2026 09:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwgVZ-0000vy-IA; Wed, 19 Aug 2026 09:39:11 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwgVX-0000l9-GF; Wed, 19 Aug 2026 09:39:09 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JCoeSW144596; Wed, 19 Aug 2026 06:38:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Ik0uQMoi2H28YgZ4J/aN0bfZpsLl14h6fINqnJASL
 Kw=; b=OAWH0NyAEOxSgB/zULU7DjpOO/yuIvdHON0JY2nuMZMdQ5O53jg3HqMj7
 1ft5bZ2U+ASL3UVr8sW3NGVMrMcLm3Z95CkG18nEaksgy5ReRxPTxWLHZXeLghrT
 48OmnUCffPzv7u1IOmVqJVX7UDN6QU3UMtBelKieJeZ4OyGcsroQyCckroei2Z3G
 yh+bDcJRedPryKf1j7DL3oxeUYJ0IwF4fpE03H2pY/fqhRWCTv7jEDYWOPSLHKc4
 gmO/mw/rvvQBlgYLowV3INdtrHiocVML+qGL793B0lGWoY2ohv6SvBLVFQVP0jEd
 sgOaNza/QDGyrCsl7GWbpTJRs3HuA==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020139.outbound.protection.outlook.com [52.101.201.139])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g4uw5jqwg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 06:38:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBMNgzPXN8gPgrOUNFL0/BI7HDz8NZawYMMhXfwvYuK5ePDETVIRsEfONvCaFs8MVZoCc8I8CQWwBZooAttpAkbny80PhbRUoDJ6OZBiyHOttUiJaSaNF3PqOy6RQAmBlWTnnfd/1hYs7C6S1+sIrpbBuKYN6Hvnp9EQxbYO0NeLsVZsuP8N9AYJZ4yhOKgnU9jwHKbGRj9OHfLtBkztW54U4HhqdPyDeDSQbxepMogF3YVrfe36Ve0qU74/OGRDsgwOLmSFxwyPbCYTpleIs26LSt0bbLwTtwW6CxJHA8M6xOD+17Fc6RqaUSjhJEBNcY24TR/k3VqIMlu0v5xLIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ik0uQMoi2H28YgZ4J/aN0bfZpsLl14h6fINqnJASLKw=;
 b=OYubYYo2Fnm8Op+aThIJwl0Q/PYyReISOrL41Y1WV6hIXZ26gdKDYmLa4wtUL2ediKo8Sx1wXgtUbrfrzGfUmY2jQ3dgJL+WlarwnUFgd/7CwhXmb20TubnFKaKqrFRCoon1u5wgiBl0b4Du0hxFNeuRUN4Qurk5KgufXEo1RVY/hB7q9W01bpjmWz6578I1BGoSqfskxglR1sVLua+AYDuQCKPRj6ewSZkTzEHbcB24QtXHMSkdkMJBEnXlIAya9tjydYXYD15gM4PhZjId9TCFm2PTECMx1BVluO3c8y+GfRPN2RFnvtezelmvIkGIKNvVbjOM67fQ1iIJyj6soQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ik0uQMoi2H28YgZ4J/aN0bfZpsLl14h6fINqnJASLKw=;
 b=e6DgR4p1JM3FaTtFYWMefBBjABeiFkC4r6EiuZEd7i48ViBFkZUSotmA1EiiZb8vhlzqrU+TFAZFWJuZzAp5Dy9jnyhwqKQB1CC3eHjICVpTFhQ/vJY7eW/VrU6+nDorUjIJAmOakuvLJJMZgkPmoEyzSa2494I8ySG38hdX6xOr5y4YXSfEmkD4lgMZEQK3n9TORtdnF7SxeU8roFixaI7ZXt1AQEufjKJmUwn091sb/Euf3FOHa4ed6IElUpDrXQojQsWiyCl+5+b69Wcdi8uuTKF/WszkgluxjO9V2pQYTV7jUJQzEuDxjy+nNEAck3D0JlxL2VtKt20ttWzv0g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB7336.namprd02.prod.outlook.com (2603:10b6:510:d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 13:38:52 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 13:38:52 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v3 09/15] qom/object.c: add
 object_class_property_add_bool_ptr()
Date: Wed, 19 Aug 2026 14:35:48 +0100
Message-ID: <20260819133816.3497033-10-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
References: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0076.namprd11.prod.outlook.com
 (2603:10b6:806:d2::21) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: ffb2fd07-b412-48df-fd0b-08defdf7352f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|23010399003|921020|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jkL/ftjdYY3SMi3qLP0I3NIrEQ8S0SnFcQETs01JQTO0G52FuZ1AUIb8GQuCxQTavsq8Xy289dxrIsUohSSSR/uR7hb+Z/bxz8DiHNA5WQv1P+Uc/cI2cpAvw0wZRf8scGWgzYO3cl8SxF7RW07vs6f9FBF2N/8eMxri3Uqtfz40f2hj80YFKcbkpYcr8/dXuCozfKGJa1sSCaWpK/SiXzflmIDDI3a3vRTlQPQo6taL/wnYJOO+mqtWNYa/XYM1qji3CjP0dkRXz7q4Rl89fK0zAECfRBLJsW4A+ymZRS58lxjylfVmkAmDs/fteJfXMFunlPaFbjzO3lSlMrij0eXmdV5tCqa5IAHiGapWO1sNPbG711CKF/iM1+2IqAViz2dWw75jhLKFmeMwpHQay/iB+qUwMwHryVVcQN/gjdxcsoma4hEIlGsQa4wTxtauHnP3eiMZE23+dA+ng7ymb+PTQYwGF97dfqyX2mTGKA1oWjGlbpNzl29cMpbLhqomwNnMbpKfvkd4C+2OBkcrfOJw12ayXGHNmhpZwKe0ofqudsIvSw8MBG9JiMAHi87rd/DiVfDPrPGzDOL5xncVE29CpFkd+o7P9/8o0mNfp1a7Lz66DPP0BTP1acNO1C5krIevdJZlOH2VW93VgvDTnTyWootZCHvl2D+wWyATNIjtaIIRX6vmX75p/FGH51XayfQQptOsDAOcxBeh7p3kAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(921020)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AdNwcumnxdDDTmx9KylnOkb4l/m+mGQ3409oN1WXpA/t+oVyyVOIq4MOa2+I?=
 =?us-ascii?Q?R/IUauUA2B1MWqQBWqD9SukOREIoNNuMqN8LkgdRspWZ3nfsnjzbbVApxsHs?=
 =?us-ascii?Q?0YWKyDk5jrmUFFfa0uzSV0CpfVjIOTpjh1Y09MX4Zx4InvnwgUdvTSOFNfaL?=
 =?us-ascii?Q?h80GKSF+B/HbeXZzMtg67RSKwUJl3YGRjBdPGx1Uagf957bzldN8CtLNrt6t?=
 =?us-ascii?Q?OEW/K1rksqyLavx09JUFAKl/chwimkuCU/X39aPcvtKMqrK1lY3QU9KVBgvK?=
 =?us-ascii?Q?mIy/yYMA/ZGTDbIiwrDSaORKyOCioKNj6IaRGjwmG+7DwUiE9k2dsOyeZgDg?=
 =?us-ascii?Q?X7l3gL+H2RROXznZWl+87FlybHnse/8eVISYwceDRektC5MsEjrRO7ITXBEZ?=
 =?us-ascii?Q?bjzNOVsT0gkr3ssFlv57g6dnxMFPCMPuRFadt0YAZ9ixQNMmTwpKR9FSxIHH?=
 =?us-ascii?Q?GZJbDxb8k+phWsAWgFcYJkiaRAMTtY+3PhpZZpNmHsC1QWCXR344y0zu/crd?=
 =?us-ascii?Q?yz4gotlBMqLBRst3MXLhxDJCOoN5xx/fLb2GJopem9CcF/VW+IVuokKPKVjI?=
 =?us-ascii?Q?2VNNGI/8ohBpMRfQvn8DgnaifHAdLAM2tL1TIZZRWC+pC3ZwriwE46ugfbmn?=
 =?us-ascii?Q?jskTf7hO8aA89qIUckJRGgc7DIqzqL/NbG3XVoirkb2NG27hgdWnmHD6XcTF?=
 =?us-ascii?Q?WOLAF98OEBdQpoulasGNkBF0MoBj8HE0t/24qJqI6/Oqp40EHvHDOAG1wL6N?=
 =?us-ascii?Q?85mNkqir3qhMr55wdvqqNpAMFkvUe0RuY2zdcvapAZHUUXhRY2b9MgxJzmPd?=
 =?us-ascii?Q?n15CmV8PK2EasnYWZne0UOf0y7+hE9DXrud9eERf+SpQ1+ihmTOvDUww/GLN?=
 =?us-ascii?Q?VGfKWQ6+HZQsbPCByjBPXKJJ4T+HdWPbQeuEcrqsPx8ZDIlGeB+mffYqqjhD?=
 =?us-ascii?Q?13SOxbOYvjgCJsjjk2evti17mwBZitq17jBqeepjUMK0b6pQGKNFiVYeyyJd?=
 =?us-ascii?Q?Jam3CHpwyLE2D8ZQTCUzxWhNPL2Z52WiHgkiaCWI/vK+zwcHDR+Au29ItS+C?=
 =?us-ascii?Q?AM+L+/zx7J0lobQ0VCfneu1L/4h2audTjx+S8yrg+R5cw4ix7tMEzt6MB5Xt?=
 =?us-ascii?Q?Th5XPIJdRsKeJD3GYZakAhQd32wbUG/G8pGTPGNBPFmxpbnwYlA8t1IxOBY0?=
 =?us-ascii?Q?dOl8DJeuu6+Z0FLUB1hnvkkdoNAbLl8w7uIptFSNEqtEwjHezDtvUg+R39+J?=
 =?us-ascii?Q?/NprtjCvrEBY/WMUrk+0ldWUKnUJNJluYK5kdt/9ZCIfwqlqxByopq0xorXE?=
 =?us-ascii?Q?c3Trk15tBLzCHpoptp5hYY4Iyz9kBV07Grh6YhmgcYDut9TFm/r7jY1TKvBy?=
 =?us-ascii?Q?YxVOfoi8mzUp3IGNbDjBCO7nMQl2dpMUfxSR8QvT6apZ/wN/xAAeWwatM+MK?=
 =?us-ascii?Q?SMZ3zElXv/0gEY7U2GBCAz9grbzytrWLgRhAYWghO/ZzIFHvzBO6z5Ma4S+c?=
 =?us-ascii?Q?yrMyZ/kskhYrWRwEpbHEo9phHedOGWO6dl25mbYR09kzD2R4qTsIis77Pm86?=
 =?us-ascii?Q?+cWdarjCaZyTXL5vE4kiXDUh5j8fagaC/zvXRtgjquEJ6gyC264B4qqNu+ok?=
 =?us-ascii?Q?SgClp5gBf/0a6NNI4EHVlQOTwbHKUiYNuWetjcv5ph9WvQcC/eA4M+FPRceu?=
 =?us-ascii?Q?T7+sHyqH/L0pSIcg7jQk+CxkCxWk0gjW2cGuNQk4dXSGFrG829iwTFgONkTo?=
 =?us-ascii?Q?K6jqA/CUDaWtVM+GLVpuH1tgM12MtrM=3D?=
X-Exchange-RoutingPolicyChecked: A30MLTGg2oKE3C+kYgllphTumIFNdarlxNTcqf1E5U08vVxDsFZQpqKMmllBUo5RiIgomJDNfsr2T7zY3ucNhlBSD0hro4uw02hd6P/O7lLj6tI3bDmCBnGqLHICCWd5vTqWoH2K8AllnaGRC9MtEIZAgsUSMHaQ4qVmfZ/0eJ1h/lBKmr9FrBPOuIR8phyUH7xPaiaLA/xB3ONQN91ksH3k7+sIiEbwagJMWelrk9i8PrIIdSWYSFLme0pxzp7PrYOpUM+WsmOjm53I65fP8XMO98gdVQxS/UVv46HegiQtWWLs+T2Z3jnMHcAI7cvhveYPPCDv43EDAALj/nwrpA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb2fd07-b412-48df-fd0b-08defdf7352f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 13:38:52.7113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6x0okmC3hHXnBqlPvxloJyePUhwmqabMCdtfsP3qV3cLmxbQe9vypefMg+TEUvOpL04uZRkU5V6kGiMQ/0H1o2/Agf0ZjDh/haFtDGEzcIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7336
X-Authority-Analysis: v=2.4 cv=INwyzAvG c=1 sm=1 tr=0 ts=6a85b1ee cx=c_pps
 a=m5u7UkoT2y3MSdrnBkr6Vg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=kDmwn9SJQQ73BrzAQp4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwNiBTYWx0ZWRfX2ZnQAO0DhgB4
 QvxDoqWkHMYtaxxGNLOB0nCA7nPtHPQp2+L+/IJC2kihBbaEkg5NivubCfOxHcrtcrwISFa554a
 +LnjRi7HbYcd6XbhisDDEYgT9v3lIoA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwNiBTYWx0ZWRfXw2Int0DroWsB
 tZjLQ8YqmyDNnheexw4BeGuYE14lPHjdKMAy+AaO95bLvtHTXNtg+8wdf+cKZodDwkeAiDJl12k
 8JtU1NJ0J93DjpGudDE8VAjZXUbH7q6H/jVj4VGw0VawZKfbFKle9AJmpdCU7YEEM4NRztfD99p
 LyGnfJwDrgBTx2ATOZjkK+SF3Yp2AWfIHWTxOCmdsUT2TGpxNSD4cjGreMuFRa+6OxpWRYCjIBR
 cOsovDjkh1S1RTQYuCFe+NB8BqtrTloJLpsRyhYDhxFgLTPVzZ7PrtlYjOMAOZm5izN3qEMO3Yj
 rpj/MUARXktVs8QbHLc6BsFKtPw5uRBLS+bqbOkAlONwBKHS1/MXaFSeVhTsfmBejQP0Ypdt7lX
 6xKnKK7jstDjewz8mROn9ouYF7zF3GhUgLgUfk0yqtkv6PfaW9YkOKLtJSdv+zuU5tOXcXcMtv1
 h1HQaDss+qVMPGE+Wbg==
X-Proofpoint-ORIG-GUID: vRZM7eiKMBRlupowt7WcDT1WHNMVjQxz
X-Proofpoint-GUID: vRZM7eiKMBRlupowt7WcDT1WHNMVjQxz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

This adds a class property that references a bool within the object instance
and is intended to be used as a replacement for object_class_property_add_bool()
where possible.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/qom/object.h | 18 ++++++++++++++++++
 qom/object.c         | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index e0c88453b1..b469740782 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2017,6 +2017,24 @@ typedef enum {
     OBJ_PROP_FLAG_READWRITE = (OBJ_PROP_FLAG_READ | OBJ_PROP_FLAG_WRITE),
 } ObjectPropertyFlags;
 
+/**
+ * object_class_property_add_bool_ptr:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @offset: the offset from the object instance where the bool value is
+ *   stored
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an integer property in memory.  This function will add a
+ * property of type 'bool'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *object_class_property_add_bool_ptr(ObjectClass *klass,
+                                         const char *name,
+                                         ptrdiff_t offset,
+                                         ObjectPropertyFlags flags);
+
 /**
  * object_property_add_uint8_ptr:
  * @obj: the object to add a property to
diff --git a/qom/object.c b/qom/object.c
index fe032c9619..b82f10376a 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2749,6 +2749,49 @@ DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint32)
 #undef DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS
 
 
+static void property_class_get_bool_ptr(Object *obj, Visitor *v,
+                                        const char *name,
+                                        void *opaque, Error **errp)
+{
+    bool value = *(bool *)object_class_prop_ptr(obj, (ptrdiff_t)opaque);
+
+    visit_type_bool(v, name, &value, errp); \
+}
+
+static void property_class_set_bool_ptr(Object *obj, Visitor *v,
+                                        const char *name,
+                                        void *opaque, Error **errp)
+{
+    bool *field = (bool *)object_class_prop_ptr(obj, (ptrdiff_t)opaque);
+    bool value;
+
+    if (!visit_type_bool(v, name, &value, errp)) {
+        return;
+    }
+
+    *field = value;
+}
+
+ObjectProperty *
+object_class_property_add_bool_ptr(ObjectClass *klass, const char *name,
+                                   ptrdiff_t offset,
+                                   ObjectPropertyFlags flags)
+{
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_class_get_bool_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_class_set_bool_ptr;
+    }
+
+    return object_class_property_add(klass, name, "bool",
+                                     getter, setter, NULL, (void *)offset);
+}
+
 ObjectProperty *
 object_property_add_uint8_ptr(Object *obj, const char *name,
                               const uint8_t *v,
-- 
2.43.0


