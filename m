Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6CBC5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 11:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuq8J-0002DZ-Rj; Fri, 14 Aug 2026 07:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wuq8H-0002CH-Rb
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 07:31:29 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wuq8F-0006hW-DF
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 07:31:29 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67EAdTA91547207; Fri, 14 Aug 2026 04:31:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=be5M8ydIvLRha
 +ozq9dj/KAhr5S/Sme1y2ejI9DKKqk=; b=HytrvfN3IWQs09fV8wxRhhUgihrMl
 cyovTxrrZArZJHJcIgTYhOu4SNm5k0QqF+nJwGaJ0R4wl9n8RJhdimfv/ZOVpRh1
 M9STDbcXkrgSpyWKfG0o+hsYTIyoSGBD/MRYuJSZxezO293rnuusDsGv08vZYUeY
 ih7ZlNq3KK/d4gHztvLFqDslrXewbY6LTRGXme/vL/wDMXeawVTPMoA8g2lutDdp
 jlrd34EiIIR8zRwRMeRm0l8uv8SGhsoafcV9klVL199z9cfRPvyly3oqC4LNGV7a
 xqu/R9ejn9/LsXL+TIZ+7jV69Vqeu3WlApPYQQv+peL+6wpoSE/pJYlJA==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021089.outbound.protection.outlook.com [52.101.57.89])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g1p1d1dx1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 04:31:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiOcWVYLnuPK+vplIkd0EX+gbXJ2aROzn3cYPcCmSYEOd+l0KBJ5dJdiBu7H35omkYr8otH1y56peJZn6oYU1gNNqHuoz4o1PguZF1UWZeh8H+znFyeLKyQlRcapZxfwnz8q4Z87emaUFvVB+XNYvC4z358/JoBezt7Y6lmJAYFfDrU06c+bot/hlOYxels+uIiZNZfRZdpNz6KWjTBw9eQPoF2TIWC1WITGSc0XhixH0B9C8bv8swcV7QcsqviYOyrzZhbuhiKsrrAAWSeBfJV/2HFLgC1Dlc/SBLkNWsBcmAJU8vvYWonAqQWAL3mmSIervig3BMlefL8wUfwfUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=be5M8ydIvLRha+ozq9dj/KAhr5S/Sme1y2ejI9DKKqk=;
 b=Q+lwvTlX6daJFhuiDZU53H5VcfY7vd5u51L0GknCwB8qk2ORe33337CS8gWg4hBzbF/qpIu3bLzU5Dc4xWhHDFUWQbnzS30KWMp4aKTwUjU37cGiqVTe8gHZ9d26iDkJwqYYMevoNZr6k+4KrwuTuuvUXO69Sic4TvAOsp9rwWFIFpqv1/FHefoGbUd36UKBym6ox/h9BTTZztbg7zRKM0Sg168c2S8jUbl7X6R5goEWyn+3oDVN8F5koAsNuI7Y3c0693QIi7TA59NUl6W1uMNdpOTQxGxcH5DkH667dDZ2hrfjJerT7JqiGsi8Ya5wQnbw8H3kEa6MKF+y3jKM5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=be5M8ydIvLRha+ozq9dj/KAhr5S/Sme1y2ejI9DKKqk=;
 b=lZa/b+V6FHyvMeMS2i+Jx/kRoqxC75JFu9cs0n6VSz/dXa2IVxwbPbkZMsq+GOIfGag4pYD6xn2amUVAPwsZcbqWmTPECszC35ZvbDMohAJpvLKaTP7uJlL8APtOkQObmombps15jDFybNJgroASFuRlbh15EDSV0WEmRJMCQj1mRVvdj379VfMUoF8WE3HlUVYCw0FAQQZIAPHwjXJbEG9TVsUOZ15sGNTYM+9ypKwxGQsJQ8On3svMpR3ZzrTAoGsZSIzFQGy0Q9895F7VgIA/+3ZV2lr/cg3KnDQZyaCmsVvR6wbbpc4c2OTbJvAFzY/HHM+rkOqBTnQZT7zxcA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA3PR02MB11199.namprd02.prod.outlook.com (2603:10b6:208:542::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 11:31:19 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 11:31:13 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PULL 0/6] qom-qdev queue 20260814
Date: Fri, 14 Aug 2026 12:30:18 +0100
Message-ID: <20260814113044.2416794-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0099.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA3PR02MB11199:EE_
X-MS-Office365-Filtering-Correlation-Id: f17c965f-39bf-422d-b1cf-08def9f78bc0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: DltcCqey4HXAylMgYF4++LK6n3W6EUYXV8QUBoHTnqgnxSeQ90AhPoCyvQTdGneHFuWVB8zoONIg6wgO+MyAisRh+8ZB0AReVeFi5b50Hs/GXKM/+cq9YEYDreQErub1E1WHKxTZwZueLr0yV6nerZ6MPAzPMt92f3P0gxMw8y96umu0a1eRLyhknZaFh/oyzGokNAbLX3GE3QIM0/gXnK34vJVl39qIFC9fEsIw3M3YFUxA4vDspn2pKQ2a9Mr9rISQ5OkSZpvpJJJH3lvx5vrhmRGcGdbVrkMr5dxbPJYRpLxigpvzl72aPLcaw2f1fBRh/yUVwSHZvXK6upJk09I0X/ALmyFZQo8eKKjmPVA0WgHfxu8T+Y3VjP4qD0JYX7kg55jvI/WioRnCc5Y248Sse7AB4/2lJhkFQy02anPTDh8GKfxP4Pat8g2tNdNGTlLIwc4uRHst/5vE1PIFaTOzIghlZ5OmG0c1ualPlSfdqmrd2fyOFvfxfwQYtgU3OTcsdbJPC8BLk+K4wgzafNIbDpG+4QrvtjhNBmmEMJQJpVedDxhXQK2YRBJkC/Rk3cZgSJLpq/XLW3OIvJ+gNuZhKYNDBxI+htGA8j2duEIFbAhewvLth34885RmHbMj+L6csZky7c827l9HtiKxuVrWpX3lWvQZsZbCyUCzhUA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVM0RHk1RmRuM1dqektOVElDb1BENHVaYWx5MWd0QnZWQ3FpK2pOU2xPMHkv?=
 =?utf-8?B?dzh0YUZDckZEVldYNzRPN3lWcURLbGJQVDN2dmxHMG1CTVEzODVZTnA0MlRT?=
 =?utf-8?B?a0FtMjJUZUlDalBHS0hrSmdraGc2RzJRbElvM2ozNVhmcnJHSCszbjVXQ2p4?=
 =?utf-8?B?MnNyRy9YSHVsWjQyMklrZUU1UW9IOXRWSjJHdzNtRlFseGZub21CK1ZXdS9o?=
 =?utf-8?B?ZzMzTG5oZmZyK1Y0eVRpalRFTVd6b1I2ZDYwTUNyL0d3azBMTHFpeW1Wa1Qr?=
 =?utf-8?B?bVdwaW9WNlFsMzNnbGN1TXV0UHVCRE1yWVR5S2gvNW9KNmo4SDRDbmExM3Bk?=
 =?utf-8?B?SGphS3R5ZjhWVGt3VlRKVFZDQ0d4akFLMnVxSThRSkdaTlh6Q0xSdUhQV1pt?=
 =?utf-8?B?bjU3M0pUNzNtRk1BNFJSSUFnWDVXNmRkYXFUTlV2bUZYTjVHUTVtYm9odXdt?=
 =?utf-8?B?Qk55SkN6SUhoSnpJSVdlUkRXMjVIbFk0QVJCa2lmMnVRbEpCZTJ6QzZGWnRo?=
 =?utf-8?B?Q2dGZWZBclkxUzZMa3ZOdU5nUG1GZVppRFBaSHpzNXVXejBiWW11WWZZNWtU?=
 =?utf-8?B?WEpSSGhqSlBGRVAvK29kd2ZkaG5jQnlxajcrWllqa1hqMkxHZjMyWjJzRUxM?=
 =?utf-8?B?OTBPeUh5YldaanNacTNkODhWcGVndjF5bEFwRFByb0FBb0gyRitacmczMkFI?=
 =?utf-8?B?cGVaRlAvd1RJVlNyYWVlSXVpcHQ2VTA0eEQ1SnBEdEthQm9Kc2VyOHlUTjMr?=
 =?utf-8?B?d0VIVGExZDhyaDh4Vk9DY1VVWElqdFlVK01sQ2dRK0pkdXVNZ0gyMWlPT0F0?=
 =?utf-8?B?V2ZTb0tHM21QSlhJdEhiREwySjNQTmRkL2dnMTE0Q2NxTUR3VkFpY2x5c0ZP?=
 =?utf-8?B?enZGUGIxbWdSN0lXb2ZrcU54N0R6elYrUVpGSGZFK1kvNzlqVzdVNzRSRzZK?=
 =?utf-8?B?M0JNZmsvcE0rZmdQa3BSQURiVzFxUVU0NVRzRktKNnJyVTBVd2JaWUxVdzkw?=
 =?utf-8?B?TG9BdXpHdlh6a3VXcmVTbUthVU1LYzFTaFAzdTlwSnFOTlVJR3l3ZWN3SEh4?=
 =?utf-8?B?Zit3NnFNWU15WEF4K1RaMHF0eGE2VEYrMVMyK1dzc0dWV0NpN3o2bm80Zmly?=
 =?utf-8?B?MkhoNEFwTkpXWHRFczBNdkplK0d4RjdKS1VmYzdES3Y2M0haOWR4dldrYllV?=
 =?utf-8?B?alpuQ3p1V0xaNWNxcFN4VGhnbCsxN1dpaGJZeEtEV2REcEg0Yml2WkhzRkR6?=
 =?utf-8?B?L2EzOVIzM2pNbHdTek1TUjdhQnZXUktIY3hpMUtKSEp5TG5OTWVYSFZoeTJa?=
 =?utf-8?B?MTZ0VmVncHdPQkhaMFkvVmZwRm54VnlqMXlCZFFaVlFEb2dCLzN1aG5KU3hP?=
 =?utf-8?B?a0FYQWVuR21MdmYrcWJPd082L3BLWkJUS0Y5cGRLT25uRTNGWlN3enlrd3JQ?=
 =?utf-8?B?WEg1Wk92bzljcGxEYTBEVWFPNTZwU2NvYzdxM3RrU012R01sU040VnRxR0pW?=
 =?utf-8?B?SCtxNkpmaTVQaFhqSVFOTGYyRVByMkpvSTFEQm5JUEEvQm9LNUZ0VDVnNUNw?=
 =?utf-8?B?VmVvaVpkR3NjZnoyMmZSYko2ZisvU2ZiNEtpQ2c1L3JUaGoycnNUZVhXdzZK?=
 =?utf-8?B?VVF4aHNXSnNNK2orZmZuWWxuc0t6ZzkyQjFXaGZqWkoxOEZSQU5VbitkTFRR?=
 =?utf-8?B?cjJuaTdQZ1FnakcrSmk3Mm5TbHM0WlY2Q0xKRzd4QUxLcGJxcTFydHhpYWJh?=
 =?utf-8?B?UVJoam5OR3dlcUo2VVUzOFV3NjY4aEhnUm9iajNxUkZnb3FSRy93Z1d4RUxW?=
 =?utf-8?B?L0crSEwzZmd2UXNzdE1XU3phamkxQnFoM0x3VUFQd0xUeVZLby9CWXNaVlB2?=
 =?utf-8?B?SXJOZmhqVk5IU0FmOGdZT2FLVkdaNDNzV1FRTFNVWGRnWnVHaHNLQ2pmcVFZ?=
 =?utf-8?B?T095V2tLeWpJVnY0djJyclA1SW9tMzhJb09QN0c1UnYvTzhoMFN5QkN6YzFk?=
 =?utf-8?B?VDZqY3YzaEFLWkZnMmx5VXVuMFAwek96L3M2QlVILytOaWZYSGMxWVVqaFNU?=
 =?utf-8?B?THBmVjEwZW1CTDBHMTQweU9BQ05ZTUl6RWhRSGtzREd5MWY2YjJPT1ZKU09I?=
 =?utf-8?B?K25DcXU3UkQ1ejdnbnloTUVtMTg5dEJJNmZFV1lXMmdwWCtYdU9yZFI4ZTdx?=
 =?utf-8?B?NTZULzM1UVd5aTQ0dTZjU3phZHlXS0YwTzhncXBGb1R6ZjNDSWlqUXJtb3B2?=
 =?utf-8?B?dGVRYkFua3ovUkFRSHNDbEozWWk4dmtUcXlVQllEcjY1NTJVVFZ0S2ZvdjZI?=
 =?utf-8?B?bFJuL3FsSUpvQ0ZRbExBdWdmZDJ2dXA4dHlGNjBDUStQangzaVJxVlBxcWRG?=
 =?utf-8?Q?viCpAJTVvQ3h5dbQ=3D?=
X-Exchange-RoutingPolicyChecked: SQpHu3kICu9vIsjiYOSdNruKAh70qQio5kT5dEFifRfPZ5CbMPi3oxLobmcWdNUQKHahooHmxnPBhu2A2PxYfopsQcmJIasY2JAPpFlEQNQ0RNmW1c4G28JQtCzWcxYfGmdAEZPhMc0chPXtkWV5oy/ZbD0IWsDStc+fgrR0UMKGxkFHQBehLABTbKEIJu9TE44j1MCJwypVH2w5nDq1zmqOihhQ9EqDHwT370btvPz0ppKQNKe5Qhfy7I0yzbaEnyK4GhRFWmy3hAR7qm2N0E5GVddNmlJRmtOfPba/IL51FwWEIo7JZVjQYmP457MW5AT6EsnuyuAFherKQll+Zg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f17c965f-39bf-422d-b1cf-08def9f78bc0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 11:31:13.1164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEYIitiUPtu3EwHFii1ZN1arGeCzWdZu2cSo3EKDZVd8q0cF+8pMCOK3YAGLanGUWqzVzMBwx7vK2eqjrx183WqYK/lzRw7svQTjQ0nyE1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB11199
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA4NyBTYWx0ZWRfX/vLTto81tWL2
 q5ZbUoErMce+WiNSjXTmgNBPJdSyvjPDZkBicxHvCNlTCy/S48SxxuWvEUNT3pkeoM/bvtj4l8l
 rOZippnsJ2HubmRS3ofbGi4nO0bP7QKAU33+qz3XisACwiOAT+GSxn1bs62wrKi175Mt+HpmJDu
 BDmOgXgzQmIVyaCQQSKR3xwsps/XWh+ZVAp4CqVLNu0Fn23SRznpCZXYp1uwBwQjhjR4yqG9xzo
 EI6ZLa6fnqpJPexxo0warfaqwFIj4uslBFJwwoE3Rs8uDDA/ItNWPrRhifjJWs93/u5EDQkl2dP
 pCkhzSST2a4s8BwWCo/CeeqeKSXOePgi52TWDcUjAFA8RDLRe/ccoCjP5A5Lv8STlUoyEw8tZCK
 NvKWgIrxqEKmv1MKvWoFz6TgC/0I41snvhq8fw+96IHSxpD4FG/M+aa0cIlw1xP8qceSC/og3sD
 bVrLKJ6ndvxU1Ikz6EA==
X-Proofpoint-ORIG-GUID: g_Y9BYepHYSTyJi7rVA7LNXfC-X1_nsn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA4NyBTYWx0ZWRfX1drLDpbt7JZO
 ewrRZzde45j554y6LJu8cz29hunJvyGar7qM69ESGaD8UPHcbn2j3sRMDqQvrHALwiBOXqN2Ct8
 pBT+fJWbA6rdTTvi7ov/zOb0+cvdx08=
X-Authority-Analysis: v=2.4 cv=ApbeGu9P c=1 sm=1 tr=0 ts=6a7efc8a cx=c_pps
 a=Sq/50nUKxlEOOe6u8VXKPA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=i0ApSXBnrZvD6-t7BtUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: g_Y9BYepHYSTyJi7rVA7LNXfC-X1_nsn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.751,
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

[MCA: This PR is signed using a new, separate Nutanix key: please update your
 gpg keys first before processing! ]

The following changes since commit 539bc315538afe036a4b99088659aa82e3b489f2:

  Merge tag 'pull-loongarch-20260813' of https://github.com/bibo-mao/qemu into staging (2026-08-13 07:16:25 -0700)

are available in the Git repository at:

  https://gitlab.com/mcayland-ntx/qemu.git tags/qom-qdev-20260814

for you to fetch changes up to 6b97f3d4d6a5c3017f6f7655019097c777f5eb86:

  qom/object.c: rename object_class_property_uint*_ptr() to object_class_static_property_uint*_ptr() (2026-08-14 11:31:18 +0100)

----------------------------------------------------------------
qom-qdev queue

----------------------------------------------------------------
Mark Cave-Ayland (6):
      qom/object.c: introduce OBJECT_PROPERTY_SCALAR_GETTER(type) macro
      qom/object.c: introduce OBJECT_PROPERTY_SCALAR_SETTER(type) macro
      qom/object.c: introduce DEFINE_OBJECT_PROPERTY_SCALAR_METHODS() macro
      qom/object.h: rename @child to @targetp in object_property_add_link() documentation
      qom/object.h: add missing documentation for object_class_* property functions
      qom/object.c: rename object_class_property_uint*_ptr() to object_class_static_property_uint*_ptr()

 include/qom/object.h | 172 +++++++++++++++++++++++++++++++++++++++++++++++++--
 hw/riscv/spike.c     |   5 +-
 qom/object.c         | 126 ++++++++++++++-----------------------
 3 files changed, 215 insertions(+), 88 deletions(-)

