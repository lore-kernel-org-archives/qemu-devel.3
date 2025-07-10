Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E4AC83F18
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 08:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZn35-0001cH-9S; Thu, 10 Jul 2025 04:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn32-0001GB-6H
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:54:33 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn2o-0003d8-GK
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:54:28 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569Mgvc2018518;
 Thu, 10 Jul 2025 01:54:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=AJ/B4wHG2OAUgiSFCGwBj5GgqSqT7WnagOhH7rcyy
 rU=; b=XjQk6jp4Y1TJisiIvMB54+8QibqKOnvwvXRCoJUpi4Q7M+EeCSZATfnZ7
 ohT0EHiQzZuSff7pm1/gOfTboyQ+svJi4vgi2QPInT4qFuAn5dEviq+FO87kAsUJ
 iYoFJvyd4dlbki/4CYSzNk5rCM2MOCZv8rcFK5rIy1TWIr2YWHyvMjzCk6MvgPml
 Gq5tC4KoK1thnzlaKN9ufBRX6kHDpdmXBzC9d9e6qaswR/7WSEmAJEF9RY4z+jBJ
 7gh+CIJgER6aveHhkTt1aW851Z4kPbNgOASG30lBIFNfuhjMpgH4b6E1DjBGA23i
 KQ9nMIIyT0JfM94o6cb/QxjUv2Jiw==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11022079.outbound.protection.outlook.com
 [40.93.200.79])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47q3m150mt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Jul 2025 01:54:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QoVmImFmux5bg1H2ebuQuV0pCLHgB7dosk0Z7c+nm27GayRyJKc/rORxuq88AhQ/kUCpilmdFWKqMsdebsnLtN3UQyg/4l758ryTuhJ42Ftd9e5YNVGomHFVWUvIjfiVLZvHUK0NnzL8YBkW+H9QPKW26siYU1fSJOx4Xi6FOeU8tJ/mXK62h3AGR91lNIiwPiVNKNpKecvgDl3WI8cvT7sbVcKvU/2ESxKgizvwGr/EwzhDxxlh5ONtp1dhaPassnOd7aH3jPVL+IVkDveIaaB8dHadTjlS11Dy0HOpPOrMz7pWJils/VxwpIsB/2srTgvsx7ifcvuzEcC15aymIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJ/B4wHG2OAUgiSFCGwBj5GgqSqT7WnagOhH7rcyyrU=;
 b=VCaFfViD8dFoqooEi9mtxs7dJfJ1JN0ujLH6rkpX5j1+i1DbfrQPx1vlfhBBovtsh9df1V4HjwPzNnx3iwFfz3EjhbZPXRvlzAGc3+OnpJZcLNJJviHvSahw/uTaN5ro9diocRAXms3/gmUXRHscQOAlpgCbwbHydKXD9JmjF2BhA9Eq/lf/m3Mys4C7864V1Rwt5pgrbY2R9rQ5M+jJuSW2uvecaDLbRi5SCAgrZ2bOXiC84H5WBE4shNaQzfd3Qg2zbPoYs9tZHxNZgyZM3Bln5TSDZ5i3jfRe4JDqHvfvY0ELycFlqbXbsK8d0bevcXNdQFnMgNJqsCinxHutCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJ/B4wHG2OAUgiSFCGwBj5GgqSqT7WnagOhH7rcyyrU=;
 b=uzjolfQ5JM5Zy7rU++BU5eWxDAfUq+/a+IrtSmsvO3r3QQUkKtcJ+dEGEcWgiSZHg1RQMgI2yiyeaMDeKNturpdG1kHg4Y9BN6lRMD/RIOU9g38hAh/mKsU4uvndOmdUOwugfX1VB/Yynl0zVB+RFPwqt0hDroaD5sMG26IR6MpjOWEY6/EEzzkpVPV+dftEBTIaTMfOQU8DRoPwdcbGuH/Sv9ZWqi/qyPi982FD/dX7pBsYtwAHY6zwlq542CUGkXcAIM27K52chHfR88uwD3BuwtbwUsnKJKUYiEHWTDMm0TyYcW++ktmnoL2cEOZ7V1E+vpU71YdRax2aJ+StDA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8048.namprd02.prod.outlook.com (2603:10b6:408:16a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 08:54:12 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 08:54:12 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 17/18] hw/i386/pc_piix.c: replace rom_memory with pci_memory
Date: Thu, 10 Jul 2025 09:52:32 +0100
Message-ID: <20250710085308.420774-18-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710085308.420774-1-mark.caveayland@nutanix.com>
References: <20250710085308.420774-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: f824f8fb-40af-4c56-dfaa-08ddbf8f576e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aQjHf9jvJda1ZUXxmsuZb9PJ4sZi8Fo+DBAxxcZ0NhH76c5EFNyx9PA7DoNQ?=
 =?us-ascii?Q?qRXN3s580P7H0BdKPi2dFL6EEBB1cQBh42XrYfIcZliVBl4WvsWK/sEhgnfc?=
 =?us-ascii?Q?le+OZ+HTTk63Eg1QFrTwKqpL3sy7fvS0OC3U2CGQQAovNNZPue7ESO7a4Zw1?=
 =?us-ascii?Q?pvlAI3aPIYwNAE5qrRSy3Q0/dwFBUn3rcH9JhKV2o3R3VEL3EqWIaZKBbZkJ?=
 =?us-ascii?Q?b5LzGWT/k0e7c8RJ7sSWyf2uyp8o/5uns+0qnkLcwpx5YDiChOBk+chb7kGE?=
 =?us-ascii?Q?/pnXEgg/A/zwHQIG3ZqCavqSfasg6fKNArVHkpIa2Xp49XIP4cOlQOj1nte1?=
 =?us-ascii?Q?tHmRhBWGqsMt1tr7zOJzOzF0efcl9Yk5I7lS/Z9wS077UXbl4u6u9Oz7ze1C?=
 =?us-ascii?Q?Wh7nEIls9MJDX0EqGj+p8lm6GNpLi5oSPcYOailRoiR+2Ha0XxHFXS2hFTiu?=
 =?us-ascii?Q?PZcs0NzHbrP16twWwKMWFzelXUo1KjGmeEpxhprFODm41X8fJXsTwHjEbiMO?=
 =?us-ascii?Q?unwoigu+RYMVO13JWl9SV1KSqooyUgcDLtnbk8jlrobFpQPQ4hiCeTQjNBwz?=
 =?us-ascii?Q?+WdqeSVHqSCBpZsn5Javjm4aE66FBG84X48vZA/NTPfFXUQmz1u/iA9B2Vrg?=
 =?us-ascii?Q?RVBQLiFPqBPZ7heprwIl/VErc1Z8buMXJ1YtIJZiyt6s6VUSHFKohu/C6NN+?=
 =?us-ascii?Q?Bz1sXnz47jJUlFBi0SaiIzA0Qsp2w0f13/qivgMYs23kl46qnwighZvYpooL?=
 =?us-ascii?Q?GXELysBnImroHjziZ7gbSwOER3mib3flEnM33wLzLFDBYi/o5ld1an6oSi3g?=
 =?us-ascii?Q?kHS6HYmqvj2VXr5oeOPvJRoAEkbcIT4xUWDMf5gU3hmrWCqEMaK9ri4v3Mkd?=
 =?us-ascii?Q?CfISNIoUKm5AjWDrfkbO5aHxVgnGSt2j89wMSBSP+GFWRq2/5DK4U7uZ8FRl?=
 =?us-ascii?Q?aSlgwnLaOSEKy+j5OuLjODQrMhC+tFC61r1N/0hmooiryB0EJQpi3g+0na1J?=
 =?us-ascii?Q?9qGjf4AS4B5D0PlqPSx9yMkBWNHl2L+IWN/GYgScrwblJ2mzHM5BZneeG2za?=
 =?us-ascii?Q?qmUUZfgkNNxQPDocV5AtewGusQ5oUOmkrNiMh+FwgxbHQifl5+FRdcQub0vs?=
 =?us-ascii?Q?EvOzVqxCi4Ntg4JgCOiGnhN4DBARbtm4so/qrB27R0CO2hx5scIVUwv4ap83?=
 =?us-ascii?Q?qfBlwjY4fUeO0LIdUsk26oS1ZCfj4CoTRT5qsXpQyqcvHZQXQsBRDE5ceVmd?=
 =?us-ascii?Q?EYDWMCFAdEsqTgD9Avhb5+kXvJLf6y0dvnjGFS4ScAOc3mAbz4h0qxLBlo69?=
 =?us-ascii?Q?gN3dDUMvD8hRmvoAuRj4z2KqwicPJndBWV/X/43KbuI7DHj+HFBCOJqP17Tj?=
 =?us-ascii?Q?ShvISoYtAlKdaO1IvMh0N6m8W/IxtgDecTaLtxbdkqM6KIW/N7w3RioNvncU?=
 =?us-ascii?Q?D4/J60FAyks=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CKioLQb1xvPgnqMzrV1CSzhjnWrADjlSy/RuPS6Bqt1e94VW22Kfkkj84+zM?=
 =?us-ascii?Q?rVMKnj2nwIVkLewDTpjyuKLNzuvLzmqbbo0cFecphV60arrVuS1VURtaGVk4?=
 =?us-ascii?Q?C2ntaX6LIc9Pn+Oty1yYtKlHdqB12WoHNp9FsqzmVmEeZbjGr/WkTPF7zvMj?=
 =?us-ascii?Q?e0XyI1Nn4doPmTE+Ad5e1qqxTFee9aXDdGfuF0g8gWBP5M3Z3k3oZBR4oBzk?=
 =?us-ascii?Q?6yzM50vjHxLC0rHPXmRDUw3JeR7ORNO179DrVL/oM/I9nFBnGfstVfutbKpd?=
 =?us-ascii?Q?E541ZZj/Y9WIpskKJDJ0trVSNR8SadL9t86jCH/HAGJYRwmVc+auWPzQT+SG?=
 =?us-ascii?Q?YOYOeMgit2tMG+XsLfrkpQm5avkr4YVz+A6QPQP35tKpgEmb+ag/AAQdOtyd?=
 =?us-ascii?Q?Of/z6L3u+FG+YoSPBS6iXKUyuyHUjyMjMoG84exnk7xgFl9m1ai+A6yQVXaS?=
 =?us-ascii?Q?KoUzoqzEPcTE7kInib+yeVAbWlKMTBCvkc4HtLgDH8X36PrU15nJSovZsFUr?=
 =?us-ascii?Q?TSST5rpzR7jtFLmyfUeVPYaRK5cQ4dBk4PdqoeMLEs8blOqGy50gCXER8kkr?=
 =?us-ascii?Q?slPoJUWcHeDUES2NaDgyp5zzoqKWQNQYJ+TtJvRE4TQgcEZOx7Jea0IJ8TKt?=
 =?us-ascii?Q?Vv1vIN1WBbF4YCdrBGLtzFdksGpir3di3ZtaciuPKHplyJvpGXz+GL97v7YS?=
 =?us-ascii?Q?y9KHPcLwJ0RRd56cF1ImVQon/vo2CtVrmjwyQUyySvTQrPyzXUuVMd28fMd/?=
 =?us-ascii?Q?xw0wpoHbmRIsVualV+0ZdFLw1lWXlr18RfvI14mHv325UhKVi/BJYzIFG7Xk?=
 =?us-ascii?Q?e4NYPSpUVwwipbHIyRfNFQT3lZfQcsO8oMeWh0MnAMpTXlxjxMAtIu2PojIC?=
 =?us-ascii?Q?BOImx0lT1o9qbQYI2NRUeRt+Hqo75CwUGvBOb80WK1jM/rob6An3M7M7mVXE?=
 =?us-ascii?Q?32ovpcOcErruLMKorxTfcMnTGbAa74JIfbpE5tMk7i2vqVN2x1BRX9QFrPk7?=
 =?us-ascii?Q?UrPcXAqyg9k9jbUhyYx5u5n9hjGcHxYaJPVTxRD/pkmMMawd7itp8ZUaVgX8?=
 =?us-ascii?Q?TWVxHqKqVGSiB9QGeuWB/lRnNvGj0y1M3E5/CquwAfeA4xPPohD+9Zj8TqWE?=
 =?us-ascii?Q?UZEj5tEzijSXjvxotVco1yfn78WpSzTxLiSOnaa+MUlSQAdJkbAoPmWs2r/U?=
 =?us-ascii?Q?I5ca2vNCLiBxLJ86MessoDYRgLzr2tmxI3NKDECjoSu0MobCiFKF0FYz/sew?=
 =?us-ascii?Q?ScYnifqiQ4z786AXUtSv4YMVcb3R5FZBHm1lOD2y+zLBg8XErl+VNvxPlHxv?=
 =?us-ascii?Q?nditLMKvfbpqviV42dLC/VRVvWZD2ykGNJGxz8V7lP/xHgmU+cjCLuyNHOaT?=
 =?us-ascii?Q?K0pHFmtAog0c8/WOblzTS/7hvzKRwdYtDlaANixRW9rdjajUGL/iBKaQ6wzJ?=
 =?us-ascii?Q?kJ22v893q5183QJ5KEsWK7UwRMd1TKYd9WXwt26TGCv1hNrEM+GIX0RKalRU?=
 =?us-ascii?Q?1UWUejpe3+86d3Tx+efS6bgN/HWQdg2p8+ul9MA9u0zeK+RpFn8p+hxKcs2v?=
 =?us-ascii?Q?Av1SzDCTEq8pUfV24DNbYY1oiMRbOH20W+IM/5Ja697GBODyv1/TAInEOcnj?=
 =?us-ascii?Q?F9mXBaSlhBh7zzJJTA/brH9s8+5dGLYSp9zSsqDMlq4ospAE19fDQ6NjtOxb?=
 =?us-ascii?Q?ONxGtA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f824f8fb-40af-4c56-dfaa-08ddbf8f576e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:54:12.5206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2wdGv2AT2CGwETySwt5qIc0o203ivlXKKr3CHsD9JVBLiuAh4nfZ1uhrZYuPS/iDFrp6FuqKpAiCWm4kB/cZghFm5eslOQXTodmB7kQRm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8048
X-Authority-Analysis: v=2.4 cv=Nffm13D4 c=1 sm=1 tr=0 ts=686f7fb6 cx=c_pps
 a=gS6jynj8eUnyaxK4LccMmw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=HsFdn5qcwZwCtpCsMvAA:9
X-Proofpoint-GUID: uTrzvBCjZtDeiwDOVwNCv0e9-qyN1i_3
X-Proofpoint-ORIG-GUID: uTrzvBCjZtDeiwDOVwNCv0e9-qyN1i_3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA3NSBTYWx0ZWRfX2mXDYRLwuJZY
 ByVRRqeaAnbejUPL8nVzbluisLPVLfdKSlk9fJ2Y0TBkeG8ENFB+D1Q0dwSazEoFtpDUB7bTHVF
 fBXzUFSp6gmOFsq0B0YpaHyTMaqN3iaXQW6kXWpU47L2HrtfCnq0BR+WXKAAA7AkddhNL/9ctzO
 TvslDqzNMFOveA9qOqJ9VA6fRGMY4w5efXCzAmvpM7M86TrJQG7O9QX4LjNTj9V7AXiS/mb7CpF
 222k9hnqORbkJD5WswTzP4HY0w7qoXWNFFl3nJTzGNKyezs44Lvch4uSKOR2/+VYDJLKiLkbuFX
 MBbRIgY3+ztVKVVenI1R6aLVDnLbK0Phh5Iwg9I/M+YrEXlz8JsXJdrDoQxgcDRYu+kEM0EM5qM
 uaR6LrcVu88+Id5elhPgb1Yz5PMTInwzsd1aY7wL7MgSsYJu92fWh4k+J338nhjwRMgVvBtv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, T_SPF_HELO_TEMPERROR=0.01,
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

Now that we can guarantee the i440fx-pc machine will always have a PCI bus, any
instances of rom_memory can be replaced by pci_memory and rom_memory removed
completely.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ed5a313500..ede7b68946 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -105,7 +105,6 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *pci_memory = NULL;
-    MemoryRegion *rom_memory = system_memory;
     ram_addr_t lowmem;
     uint64_t hole64_size = 0;
     PCIDevice *pci_dev;
@@ -183,7 +182,6 @@ static void pc_init1(MachineState *machine, const char *pci_type)
 
     pci_memory = g_new(MemoryRegion, 1);
     memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
-    rom_memory = pci_memory;
 
     phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
     object_property_add_child(OBJECT(machine), "i440fx", phb);
@@ -214,7 +212,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
 
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
-        pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
+        pc_memory_init(pcms, system_memory, pci_memory, hole64_size);
     } else {
         assert(machine->ram_size == x86ms->below_4g_mem_size +
                                     x86ms->above_4g_mem_size);
-- 
2.43.0


