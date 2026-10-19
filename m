Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144E1CCF2D6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIm9D-0002Tc-Bf; Mon, 19 Oct 2026 08:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm92-00028L-12
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:07:13 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm90-0004J1-8L
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:07:11 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8QSQX3508828; Mon, 19 Oct 2026 05:06:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=SZiLewJ31Wd7JJfgU0jxATyKUq9AnyFgswSLPaZDy
 F0=; b=dqjQ1RYgGFuytr8VYNLkAFaoXMl3TnF3/I5eu2iBSTYxj6YxRPcv6FlLL
 Yjtw+DUNBdcmkY2PT7iwejzx9V2XCZckDb/kppuppgSCyDbpB202ODHNG/VU15Zs
 fi9haNZit8QuE8KVAZgO8Cc446ay2aDSdqzYb1geT9+aEBwZqv86cLWbKIk2MxzE
 FLXqlisAQC2qXlT5kzaING2+I6CW+DABySDyk+7SMNkbTbnnLj0kzgrkW2H6Oy2Z
 ypjF7exuByOnJqwKG+27pMIZ9aTL+o/TGni9xt4rQNY35iFxAd7mjVCmqSAaOiUD
 WuC5yaZp2IdgbuRAsMjXG3DCMWDjw==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021083.outbound.protection.outlook.com [40.107.208.83])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hc4x43qrw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:06:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRZQ8C6fAfyy96MoxUzpVha+2XHULH0uU93VZD9XPIOwmPE4UYdFtjDdf12FIS5g7FApd763OcEdQ/OMTLesAtB5EqJivH5R6k/MtzJQUNgJhE0dZUz2602Rz1XYAGTsxCTtPBgKEEjs0YBMFQs+He1qLvKdWh8ADqumm2ws68kmm82KS750r8XL67xuPDxjPDC/3fktGFvFBpLC7OqsYBrLgMSwDO/p5asi7mS5AYtO7mp7yq5+rcICC8Jz1lYdncS5rovcDWbq5a053GtfDTqs+x+pZnPSr6SlHAt5JtE+GfnaOcUTB436CkbtFxpuyKFYZQJsQZb9sx2w8DREbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZiLewJ31Wd7JJfgU0jxATyKUq9AnyFgswSLPaZDyF0=;
 b=yZSx9MaMomJeipZvKrHJFLt9y62Gw3HnNTiSVbW6K0qXxW4mdZ1gVKCUFdgqc99IJyVbg2pqgI1Jpn3cmiiHI1nhQ+69zzxm6G0WholvLcP7qZkR7edponaHA5xCtL2XcTeBjDd+Lcck1V1ydiT9e2Sj1at/ecLTp9w6yPVMwwnKWleaFdxe/ZZry3JOAzt1h7QeMaP0lz1P73Mc2SjMbfIWm/zgSwSGXEj0kHrZsLihSel11Q3C8fq9rKRZxZgIv4XzOyXNIWAua32dsg1IX0Zm9XrhwvKAM8K3y3b74tNUjn83p4umlqT6Bob5irbedavlwWgvxjBmgwF75EqOIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZiLewJ31Wd7JJfgU0jxATyKUq9AnyFgswSLPaZDyF0=;
 b=E5OwtLC5fUFO+JZ/HwzAPNhK5CElp0oSziLEXPiaZBTCsM5xMhKpBkm6n5cL0zAPeYporY6WhBGhEqa9mhygt102PM9SU7/4eEmqLJcKK1iLxsWUHIv+6zeqGpK1L/qF9Wsl+BwM5wx/Dh5WAKyHl7BgrS6zRze1FElKwnNqoHqyHWZBQEXBKtQJugsinx7rRIIOUjPH5Z1pZ/+hnJUxLz2lXaLi6bHlQPUXRDLfStn7w9peUNsIPCJX45ndjmaxclmlGWQPjkGUSwVSRRl4htk1j48QytEuU874hOawgmh5U7Ufa+rpLeEHtRC9jTRKsljCfS9Eo9uIZxzSgnfZ7Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MWHPR02MB11820.namprd02.prod.outlook.com (2603:10b6:303:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 12:06:51 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 12:06:51 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v3 28/28] i8259_common.c: add missing 0x prefixes to "info
 pic" output
Date: Mon, 19 Oct 2026 13:05:00 +0100
Message-ID: <20261019120517.1448687-29-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::13) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MWHPR02MB11820:EE_
X-MS-Office365-Filtering-Correlation-Id: 461d40c1-2576-45d8-1d94-08df2dd97565
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|261009223027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 4YaEciYVjNuTGnSbh+bbPombjnODIe1YZ+9tyI4YjtYjop5gJuVOGua25oQ/5+tmj8pJ3ataCcu0Af9nGfb7P3bscC9ZTWqs3rTJMSNhwotqveb20xOQYtr2Yu4VkhH8xWHQNzw9Pe5C80Cww0qvKyNMHjr3JMSj6uuufaAX3efH/DxxHiRrK9OSo6cEfSDK1WHIDZ6JwLxao7U2aVh2jP65La+iPVDpo3TunwB9xdLxnJKPinyQmpZDFTsPTuZvewLg5HhkXbS5VjTWaZGZ8hkSS5EXTSG7N+7OXmUF+8e9ExRc/zneIN6UHNb8mvttWJyjWyYgo2COCgbp/T5q0yqUXUeoOAosJ56OIbo75Oh0fH/lOaMFg38Ge4Sgu4Z85dJTPhUDU9gd3lvJNK9iHGOl7N5lSHlK0oMNTw22Zd3Vcantp1oT1ONBzOAOECA8oo8R1r4m7Auk6FEFsqWgO5JmO6k5sHND5QBToY/GFn//BvXlUI0bUufkTAuVMvy98D/CR2hVgf0vmTDkBPz0GsqU72r1fH1jwzcJM+ff/4+nYIMAYBVp/8IcfdqgGdjlIWK6XtJ5DMaMz6zW3dGmnnjC4V5ZxR1oa+sXeoJhYqXDsIXhK16hPVQzy5NScs9Yjq3czKY8J9/VJeMh7hr0S/1oIGlgmsUctTuHgMNbnsQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MGL4eORQGFRSnqXbfB/8polufm3OvAZm4BwI3SeFxTRDFWPv3NPUB0bjcvBx?=
 =?us-ascii?Q?+HYt/GlF0ZctavCH0stbECVKmig1r0NtFNifHTnsQG/03OJu/RhkWcDp7UoH?=
 =?us-ascii?Q?1mmieqbp0yPf4xxnTHuQYUPao26iPCJE4QZExKhNAM691tfIluQD41VJplcg?=
 =?us-ascii?Q?ImHhMtgMDfKpvpiEk7p20B6z2zoyRhurI7gVlWtVCgojMl8sFw1v2c6/EBow?=
 =?us-ascii?Q?3SDvSnHoPFVF1IRqTsTXh8edr01YeyyzeTPSY7biJ+JYeD8ZXs8XGEJ49ecQ?=
 =?us-ascii?Q?etBAg+p0cMaX+akv7CwjahayEdR2Z7LDXSiPAIaYFImy5/7G+vN+BWV6/9+r?=
 =?us-ascii?Q?XMLtVM6E5KohhIUZ/B1UxDmLBvTiw+thA8BwuxtlXa3GtBPaKFg2wg8ZzrCM?=
 =?us-ascii?Q?/fNnXq3G1MXv74taEtUAh7KYBQTJsGpe4W+ccFAwW0n3voaDFgd6JeFw6/ry?=
 =?us-ascii?Q?SnXlavFNrQQabafzyH13yrSdkZkD1JTA4WaLoXhPLYqdPfysgu1nvzrbYyr6?=
 =?us-ascii?Q?a0AbWuiKGbB3upwJrW322nPiiKVHQk7f/N2xw5QQHstnPwyd3rWsXcQpmMWT?=
 =?us-ascii?Q?gdS7+09y91Z4wpOeukQPRmMgnb9v9jpo62J5SzENTl0B3br5tIFrWBzMxHYK?=
 =?us-ascii?Q?o9zW9Q0hbbc2RlOQv3GYH4SYGFepoBM7iiIPTrQ8op+DNP10iLHToG7um3cn?=
 =?us-ascii?Q?SC06k3MPUCBBF3zNk8qPtcOtGT2v+mFbuwfzMc0EmxUmiJ9rKUIFzgRs+EWS?=
 =?us-ascii?Q?NO49J1TJ1Q/BlIHbe1Tm98k5AU628NlWZYww2Jt8B37HTlHzL5Whhg29DotI?=
 =?us-ascii?Q?CgIy147t1aSmghc/F9ALRqSgiYzM38I6C4xvIKyU2xTZW/jKfMLnpbA2zCvV?=
 =?us-ascii?Q?mUBxbdw4bMwbrqX5ttQZqMNxZnWtI7Qfjsq44TvhlbMyejzijlOl3ryNdmJN?=
 =?us-ascii?Q?bVrVymdFm30Q2vAPjR7oOtq7Rfv/c/H/Sf4nwTLDagNbW7/LL7yDm7UI/KMR?=
 =?us-ascii?Q?36AvNtAHlmRd1skui60ZhBJuH8H8D3KPtT0eYgOx9uaYWu43K860imI6SCXN?=
 =?us-ascii?Q?CZ7zrw3K1H6akAUslMP7sBpHV/3KAsi24jDm4w9/K/bZ1xYZm4dxePsPzk+E?=
 =?us-ascii?Q?5bzQ6BQ9M1Mock5mvcXtxlsC0Pu2asWkQbH3cy/kEa9pUkX6PKZu9vqLBdNr?=
 =?us-ascii?Q?6P0u4C6TVPe02gdGUOZQclpE0aeB50xfA/HPNPjQ7mDhnMg4PhOTnhrkvwvZ?=
 =?us-ascii?Q?frK/s6PDA8JcTNqiZsI6c8sr1b7palxaVznIDIdMq13euWOxc9Nv7xKCDsep?=
 =?us-ascii?Q?AaU2QLrK3G+yfeJDO+lleFN607TB3iaPTzK/nVudeUBwrBOW4pRl8fh0Ttpv?=
 =?us-ascii?Q?pcQ7eTouj/9W3+V87mQfgLJWcA8n/3vLjqA0sPzAbg2vzpxBTDdmDBrUmypy?=
 =?us-ascii?Q?0rbcORsU9zGORmAhkcKfBSxnMPpctLX5Q2gOU+Z16YR3KhalPMNFnUFpX54x?=
 =?us-ascii?Q?Ab/32YQFdCUhnKnYpQ2X0+g/5tm6mL5NOsTUCXEAmdUXdEHNAeckKyUswRGB?=
 =?us-ascii?Q?4Qep6vt4i/2Q82nYAdZUhVmGG09S6UM44LTkTZpwDW1st9j/GuH38Db1cPLr?=
 =?us-ascii?Q?MlDmnCySPdDfH0O/WD2WS+V+aVAEUlhSTJWpxb9toQGU/egyP3/CrsYZx6Je?=
 =?us-ascii?Q?WEH0r4WVgwj5ctaqnSOO3ACoqc82Wz1AJl7zF7CMBYTEYQLsjoAGF2OMHmVn?=
 =?us-ascii?Q?2lZ613Se+0qsoBmAYZRjd+k6QX2FsrE=3D?=
X-Exchange-RoutingPolicyChecked: gSBtdlG2V9SQS/4rjzN8f88aTT5FKmcRNn00l6N0PU+fIk4AmcgQ8nfiEb6w+TztaBnSl3P4voyGGUokjVWAL2dqRe9f6kBaCpXCHPFQzKfP7gJiSE/nZ/6huN/7/tqOL6MuvxuBr7Pk6/dRxyPp3QpNZYu11SWxhUPTyzirOOSHN7Tprbcns2LGurZUK6gd3e1XHqEY6b9TOWsAkert1Kq18KN2+zj90w0WIPYa4JKvojsMRHNpz44JqhyiAhqyEDRQtg0y2T5wb7jWUl7FNLm54+xldaVHW0EfUr+oOr8I0prrLjoDTEU+sdQnKBry2rvbYlooCtzAXKJ5guj1VA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 461d40c1-2576-45d8-1d94-08df2dd97565
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 12:06:51.1907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4KDtwg/z8YNr543baV19SftsND+MO90+1SSeAldTX4Q4YbfrS23B5NXL61IUD2DTaI8hUn0j+EPaNY9EgIjXQHvle6qJr56+4bO0T+Ygz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB11820
X-Proofpoint-ORIG-GUID: 7dvhmcvLOxLDbKaXDcl534pefhzMiX5o
X-Proofpoint-GUID: 7dvhmcvLOxLDbKaXDcl534pefhzMiX5o
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX4UaFWQehI5z8
 xalCs1udqy5zLEisVJxm2SlhvnGIgPmkeHKX6r+6eQi4PYswI48s/N+IS6LE37/ExLrJG15Nq6b
 vhVE2+0OWAOA0KCB0J+cw/7UpqdaD7Y=
X-Authority-Analysis: v=2.4 cv=DqHDa2/+ c=1 sm=1 tr=0 ts=6ad607dd cx=c_pps
 a=JzGR8r3o28cAtrGeABx37g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=4lKoNvaWMPz1F08twPcA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX2jSHLgTU1Qxp
 NV8XfamzJQTS59ywkTcNjGQlxP8ETsnbM7Ukl/U60JK1jD/pSoiQMvzsVHdVbhL7+ZY3IO/ZEPr
 uJlCBu3jbhTVDGe38lt89nfOq1CHPv4qmt17whpcZDMkkZZC49p7SYd9pJph1oGq/wXAGk1PaeH
 5cTOFWZd25wZGScNMYYKq+S3KXLoP6qL2IqaMh4cOUPV6kudXb96DMbaCWfvt0IocI0ARUVZrof
 DhGLhAE71Tm+GpWKtNZEXOWJHH+nWtCDTkKXiv+s05oDc7wsLJhwpfiS1SW1ecBnESv6W2S6Yk9
 fEPK8uHNcn8eYHYuHD63hqBK78hMSUf94iJQ6JFs1iVvrV6PP7NkPm5NvAnJB0E1k57bTN8nHiG
 EETJ6RAuc6AJlmziUj8jmMV1yIR106iB6mpMHPRROKxLrDuyohZncFnh7Bp7va0hYVwGNOBpwdb
 SObPMy0d9fKlcMjlaoA==
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

This indicates that the specified register values are being output in hex.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/i8259_common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index 3bafd81ea7..ee325a659a 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -119,8 +119,9 @@ static void i8259_common_print_info(InterruptStatsProvider *obj, GString *buf)
     I8259CommonState *cs = I8259_COMMON(obj);
 
     i8259_common_dispatch_pre_save(cs);
-    g_string_append_printf(buf, "pic%d: irr=%02x imr=%02x isr=%02x hprio=%d "
-                           "irq_base=%02x rr_sel=%d elcr=%02x fnm=%d\n",
+    g_string_append_printf(buf,
+                           "pic%d: irr=0x%02x imr=0x%02x isr=0x%02x hprio=%d "
+                           "irq_base=0x%02x rr_sel=%d elcr=0x%02x fnm=%d\n",
                            cs->master ? 0 : 1, cs->irr, cs->imr, cs->isr,
                            cs->priority_add,
                            cs->irq_base, cs->read_reg_select, cs->elcr,
-- 
2.43.0


