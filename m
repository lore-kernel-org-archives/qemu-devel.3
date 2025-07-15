Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5561BC83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubc2X-0003Hg-El; Tue, 15 Jul 2025 05:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc17-0000mN-RM; Tue, 15 Jul 2025 05:32:06 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc11-0005mJ-Ks; Tue, 15 Jul 2025 05:32:05 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F7oUTZ028852;
 Tue, 15 Jul 2025 02:31:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=R5kxK7TFW3V6BkCo4ZnMlk2s8Uo1pwTIgMn34CW8U
 jQ=; b=OsbT3ngZTLHCgwyO8vM+FxLiJWIi2sU7qtbJ28HVV/T0gVqAgSHSFaUfT
 Dn6mr2sXCnJow0jmTNgNmlRoqt+OSVz7cfri4Ri4B0/w204pVLc5lDSoPWw4J++0
 f/i8AN1XlE0nG1g+nja6cMGw5bWzFDlyCaogEW05xzic/nPtzY46xBM1oKmIHrPP
 ukW4BR0Z+5twBaLCY4UrTRZM7/p2mUMeUyDTbvZIoWEPeNlq9JVR1rdSZT0PmSQA
 KI37SjoMPyndzx/HkcD2zZ8hrK4vMub0Qxv2pugF7DsKCEuHvVEqp1ZLb3Uylcmo
 RTpSOIT8cvJVqTjb6mVhoJVgN2rDQ==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2122.outbound.protection.outlook.com [40.107.92.122])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47upsh5p1h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 02:31:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiQQOiPORdyTtR0cNY4eiOqWxWwtt1JeXwvx9Ou5alO4QRFJQJC7zKD/mpB+sz1sm1Pw6GIZQYKgo3OF7MDaZpIrcLTVJaGFTDzRN/N+NSxYUDUAn3VTSoxVw2tOdFTfKNOcNo91aIPSxNOvPOHlmPyAzkfThi2uKFTsUN5BBmjsm/7wA3JUf27g3jD8aZvao1EbHHQ+OTp4B6HYH9+fSyueTcnBD7A+cPXzz8ESW6+j6g3hFpYDaq6tL/xx2iiPxmkiXM8IYD1hUwkopq19bC+UzQ3o63G/UIDgKx/Qlj37+k2n83FcY+0izKLHSQ70RfbnA2yPwNCg1U++rTu/Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5kxK7TFW3V6BkCo4ZnMlk2s8Uo1pwTIgMn34CW8UjQ=;
 b=iCsXyFU8TdDSI78kgr37xMWEj1kCdTz+d5FKA6iHxaGf1i+MDgiO0lhYyLZWTvwdL/SPuEubPSJpsJh8pwgalfN0V2GbCMXD6BidkSuHWhzJCZw6Q0+IvvvrFMkri4fCJOFcfyvDNcYVt2Kxvn6Q1BIx/XzCMhzvo367DCNNgD1ECgORnnC5Xc3Q7ksy1yMMJ5PNOtdSh0WIpzZN4VKCGbPJ4L2RUAd5YjY0us16pM7xbbW0KoQDUhJAqkeqEu3j1m4YuEr3xdet2YynvsT5aBeUCTctKTWk61WBFaSU7TNpnphTqewwT8Ik+imlHWuQyDJQd/UhxSyL79LRa9sEyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5kxK7TFW3V6BkCo4ZnMlk2s8Uo1pwTIgMn34CW8UjQ=;
 b=NHAfy1b2OXtesl+B5oIEDXuuGU2uOeHXiGHkHWQg6dTsqbuaaeWChs0YbXkr0NutvRcf0U0Xj2gFtppZjbsOzimVmuiM4rMqJ+8chEqy7Y0ytUQnRwvAo4VfZTEMgaIkoRBHjZDOit2IoHdQtfEA9QQat+T79JOpNdzG6aX4fC8O4sUA4NZFz69g+hBNq40t5DYFxGY2kxF5DYn2lK+oXm/qwY7nucHEzxShN9yr/+WAUym/EPhKXkODdMwI0oeVDYOagkDbClgw1iAbOivSl7mYOBO/KGE937h2J1efa1Hj07fKSZB5BIggsW2K7Xlbz96fsukHb6ZTPHCUuGSQWw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ2PR02MB9770.namprd02.prod.outlook.com (2603:10b6:a03:548::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 15 Jul
 2025 09:31:50 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:31:50 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 10/22] vfio-user/container.h: rename VFIOUserContainer
 bcontainer field to parent_obj
Date: Tue, 15 Jul 2025 10:25:50 +0100
Message-ID: <20250715093110.107317-11-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715093110.107317-1-mark.caveayland@nutanix.com>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0102.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::43) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ2PR02MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: eeed2027-ed90-4470-b5df-08ddc3826d7a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ik8EEjWtM7W8EYdAI+mK0lTdBtdb4ItdvQx1WpCEiA5t+lDf6+kqh6GFwM0M?=
 =?us-ascii?Q?e7S4oAe/n8fjMY8x/rIckNhYe+QTz2XgY4ew27IvvJYzHIUV5yVQtng0tdkD?=
 =?us-ascii?Q?s0Du27XKeuPY2P4R7KBE0dr1AAJp9wtrZjYCzbR16uzyE85zS163zbIVGsvF?=
 =?us-ascii?Q?Bopns8OXft7AIKiHIo5Dw7f1MSY821vFAfciHjF6kcYjT18zN8DigE3papsy?=
 =?us-ascii?Q?KFkhWyDhD9e41iS7PDHGo/3hgNQ3ekcik/zphWyYqasl4V3vCbUXP4evt5FC?=
 =?us-ascii?Q?RWsuoqnlhTQebJW7K8G/m4vBMV+k/Qmddi49WLr+clA02/c+c+3ZzqTkw4PC?=
 =?us-ascii?Q?6ToprOWIkE4EOekRjcOt7sCubiMysdjOs89x1pvm5NaJCzhVqKHW6vZvA6gk?=
 =?us-ascii?Q?FOO8jE55+TMjxnsbEODaqRvc0IZMUXhaXXk5ltWaHdYa/XoCEYGUGzdi3Ju1?=
 =?us-ascii?Q?w//7xbwgxKsyN5eEl0ebgXcpL1r0QjaPu9Xn7vIBEUUrhtLLmfcGE8DmgD5d?=
 =?us-ascii?Q?TxcSE9dU8z2yXeGlH+dQwGeHOP7Hzta/7wvsJh6kt4bJRA2AiviHuPKb4jT8?=
 =?us-ascii?Q?oiF8BgpSl8xDKG0jxoY3pZZIVmQd6p3BeN7Wpu2gq0JBrVDdkMXoAETM4JxN?=
 =?us-ascii?Q?xyE0Cc+Zo07hZOAsEjyNPtO2QAiVFx2yqQ/DPiqRE8Z0KbLmMwj/o6m8OU2y?=
 =?us-ascii?Q?FZa1fJmAduwjULbUJm++iBKiHP8egtdxw8/C2t99go7yXr4hnuL0gxjV5UMp?=
 =?us-ascii?Q?Im6G1Jq3qWZBZU1S6oTZieshyGZTQjD5YxwtK1YuW0Q5MG6Xoi+QL3zSLAzN?=
 =?us-ascii?Q?SCBc9QPaNAspsxktdA1pQaYy8OnfTTD8fK1Wz3VTWxOwf7Oi5qUmBZLtTjU9?=
 =?us-ascii?Q?DXZc3E0Z7u3Sx6lY+CZfCYyRlqGyOsXdNHrPLZ9vJTldHdGCxXXAS0HjDkmR?=
 =?us-ascii?Q?xaUYk71BI2vCTdgfaMUGQqFA8geYlw8X5xSwoUCwjC7h4s9WHQPT4tmgamqe?=
 =?us-ascii?Q?bau8qvsDw2GiEeBaX0fXS4UFVlAqHL5pZzrf4ROQ0lzlDVPStOmns6c9eGiN?=
 =?us-ascii?Q?VeYVMSMfr6tRKltKrjF44bcHkVTYzdbPZ8pJhvPqqJHOm5um6WZ5tmzZRJdv?=
 =?us-ascii?Q?uFgSpmCbrK2cBHEKnxnLnDfp1Yc0oWVMhWkTUcfpZUV2sHm97p1/5Q491P16?=
 =?us-ascii?Q?XurJ1UobJ2kmTzsAPG6oG34ExLuXh51w6OxA8+lAyJW6Pd9hvKx5/dOmAtNM?=
 =?us-ascii?Q?MHH7c6Arbfro1WmmxDVSQSFlif7zain9CTI42VoPlDZbYEiLYGihJuAvqRxS?=
 =?us-ascii?Q?tS+oVPDhfJwpvvvYWPZYQxaAutPuHUVbNx7mKv4Bx238DhazJ5LLa3T+/FWd?=
 =?us-ascii?Q?TTDuwvErasQvbgI962jmA3ucciDuSGmL8RH6Qhw2ZirM8so+ZLGghd4kWsZL?=
 =?us-ascii?Q?FNTAnvrwvmm6Xyt18zoiktijln22HflKhRQr4GhYttSUKJLwPRS8CA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CqQjV2mNVOmsih+h1J3P6diEKBWyGuluj7/+AzC051ySDtynYKAkMBhucQ8o?=
 =?us-ascii?Q?VqYpCxm6BRRzSnv1c62lUY5iv1slHWDCFpsdFxJvZ18KQEy2ERo03GNQBRtb?=
 =?us-ascii?Q?aIbNUNsgISMcVu9BCzUGienp1YrI04roNgz6qNhz6+k74AYQC3z3TxiGin6M?=
 =?us-ascii?Q?N4MbO1lnu1PwZbm4Ls6ZzHwfUwjWj3FqOjOQB8QRYKlXYHs96j+LnGNrOm+X?=
 =?us-ascii?Q?+LktwCDgCHjOAApqaUrxHcEYoQufLEN1tKRwpGItzAiSXAgTzmNVOiG5lOLN?=
 =?us-ascii?Q?RkOdPJNacm+TUZJYIzzR/Ni++cjyrG33i4zIRLI1Zd8k0r0R1/lF0SxkcJSf?=
 =?us-ascii?Q?FFGHKWihbgg+fBlCYPdKh7Y9LoFPoWzF2g0tqoSfgmNznLcz0pIiYkTJ2svo?=
 =?us-ascii?Q?Tfg2zObyL9Nu1hPnL4/GQRcjE6LJlCz2c8riDBtjlOCkHadvq/pe2AX15B7s?=
 =?us-ascii?Q?diT4b/QcmVKddvtE5U3VdlyW+MMlORqf5LoWdH0k4gagMKgK1l8yPU3WYHEl?=
 =?us-ascii?Q?jDWv0zPXSWapGJvyPJxdpyckZk50CK3WFO7Tj4FeWMtVmpEbRwALpF2PU6bz?=
 =?us-ascii?Q?pGsHV69+psmJdF4GM17EdXjAIOXHRUyBPfxBaQgXcEjO3pHENtf5oZxJFDIt?=
 =?us-ascii?Q?oT3AAFMmM2oAxQhjl6t7xoUh2CPBqa3a7qR6NXlg0h+O38xzD8dunrSBjWJH?=
 =?us-ascii?Q?D/jnmIC64bQ3eyU6RLKbdcAFI7C9Oh23hxw06YvrV36cRitrIC10j8dOZUFu?=
 =?us-ascii?Q?YNusUu1q6C2JzJaeKFLF9Ri2HIkoiLNyxcTTOglaNQ/MwaOKrUn2GAC8sa6V?=
 =?us-ascii?Q?nB4IYHznG2IzXm4TDDAfdICbcs1kCRGZzX4CYxggCnZ8NInlkaXw8fDQNvHH?=
 =?us-ascii?Q?ZKRS22YT+W0/RRThYnrf4SVFMl2LDJbkhthzrZ2B2+7bajtOVtVriDWUMUb+?=
 =?us-ascii?Q?+pn1Wtm9bbeTpongq90FVOBK3bmwYuw/WCvytPPOloscGxR/iKQ4fmTm0kwo?=
 =?us-ascii?Q?hcYnnHePwcBRUg2DNRnO0NOHJUY3nfQGF00jbhGJa+MavXXps8xG8ecJ/1h3?=
 =?us-ascii?Q?cUg2p2WsFPH06h7bKD1bXhTbrM8DDY3um+Nb0sszDOt9NerLVvxmK/cdGx/A?=
 =?us-ascii?Q?ZoPegao95TANOLDuOPLZScdpFBEnovOYd9GPrlFCs3vGsaJdTsXqmW9D7FDO?=
 =?us-ascii?Q?TddtcxVaG2m3GPSkyXU8aJscu9aeXRGKZYp/hYQFZ6gP/vj0OHMXIbTkm8qR?=
 =?us-ascii?Q?5HrgqRfQhG9F8H8vrfJSpbYvyUD1aNtx+OWQNuQCIDdxn/cNFtboqNiH4aL0?=
 =?us-ascii?Q?m8V6GPOQpilXEXeiVfPNmlSrD0C/foheXIZM+QLZMDO7F00SVAIUQjbWb7K6?=
 =?us-ascii?Q?SlV70JYaKSxQdXIOIzSYAtaRKApuCVvzzHDfUAot9tWhbEN5MMgwhTeP6Se+?=
 =?us-ascii?Q?daMm1camUo6eORK6RQpvTzRSjSmYAZccODKBzt9VWYD81VDkcFqdJffvR25N?=
 =?us-ascii?Q?Q0VIclxOQdz5ksMozJT1fUUeNdB3khcrLcqSv49XjaZMTW0Qk/7EOM58yr1g?=
 =?us-ascii?Q?cVs4mYJMCOBn2ZbHASeG9jiW0Hk5l4QRmdUmBm8bVqIOpaEApJnQWS61nT9X?=
 =?us-ascii?Q?b6maCSnfZb7ZaFPznxJo/brWDc/Gr3akDZeJJuLqnSrz6R1rzZ2KE6CAoxil?=
 =?us-ascii?Q?vYXmIg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeed2027-ed90-4470-b5df-08ddc3826d7a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:31:50.7197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9W6kwh4KeqG3WYNqyV7BAIII9ijh+BS2rNsD8khZorQMpTcwMQEwYYBDJxPdR1UxOYxGWJay78VA/2rj/uto0/V87EE5eAG9z7UU2ezocQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9770
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4NSBTYWx0ZWRfX2iIJzZH18uMQ
 PNl31wPVojHI871BI2TzStwsd/cF9ZDdw3IFK6g7RBHf2vsk1gNP+R2PctlWCThL5Pk6Q0FhEg7
 Ex7d+nSj/hWbU7TNwVsi2heLItlt029rjT+x/S/Pskv6fWBHzHDo9bdFaeyNBtIBn8DHZqGurDE
 YPcG+P1zqs47W4+RWR9NDVYS8W2BN5h9wxGpTbSD80Vd0h133lddyBCr2Ijj6Hi2q8gXu8AdYHj
 Qitq8APuTPfZqdXZ9KCnv6X44qda7wCFg6X2pNA31VTHdrJtMpb6p1K9T1Lv6TSmZxcG2rOLkNj
 pdPKquQjVLykFFf6fazXeq06+yigf1laJvhX3nMrqNPFOk0fS+ehK43jg4sruYJTN/NxVEImyu5
 7LlA/oGQaDUoqK2aZjkryhFkLvLto91vkcH6KeROaB4hVvptr8e6ISzgSEgOJrV0cG33/HIf
X-Proofpoint-ORIG-GUID: d3stl61HVHAVL39QnzkC0nz7ODo2ydqu
X-Proofpoint-GUID: d3stl61HVHAVL39QnzkC0nz7ODo2ydqu
X-Authority-Analysis: v=2.4 cv=AoTu3P9P c=1 sm=1 tr=0 ts=68762009 cx=c_pps
 a=ITavxs4S4at15BTzwWu3Ng==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=fXDhKcHIyMRBIq9MyuEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Now that nothing accesses the bcontainer field directly, rename bcontainer to
parent_obj as per our current coding guidelines.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio-user/container.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio-user/container.h b/hw/vfio-user/container.h
index d5d2275af7..96aa6785d9 100644
--- a/hw/vfio-user/container.h
+++ b/hw/vfio-user/container.h
@@ -14,7 +14,7 @@
 
 /* MMU container sub-class for vfio-user. */
 struct VFIOUserContainer {
-    VFIOContainerBase bcontainer;
+    VFIOContainerBase parent_obj;
 
     VFIOUserProxy *proxy;
 };
-- 
2.43.0


