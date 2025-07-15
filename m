Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC5EC83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubc4I-0006ji-OS; Tue, 15 Jul 2025 05:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc1v-000244-FL; Tue, 15 Jul 2025 05:32:56 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc1n-0005u2-Er; Tue, 15 Jul 2025 05:32:55 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F3UBOs021997;
 Tue, 15 Jul 2025 02:32:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=oeql9jf+mmFt6ViixkLYBFrx40DCC2q2ZAEu4iSFc
 Gs=; b=PJzKtO8+PxIDGroWGCTEPXU9bYKKJpwLnbPRv7GlGpDLvxm6r01ilVWw4
 aV4zXZfoiCxcX80ASpIAo2snLUmFeEswB/mPe/E3cAcaOD9bjs9mUPnCr5tES3gZ
 KPzYxdeHXaqymDIYfcpa+rAWKl3lXJ9qAzz5CMfgQ0EfyhrIY64y5PTaGWxfbpQP
 EeNNzWLu15wOzmpqkcE9RNIAlFITtbXtTfAgvjko6iWoA3F8V5PTORYkFpVV/q+M
 8m3SWFvz+S+m5YpzHHDrqYNgJlMGvYGB/y3w8TVLNygQYpore1m/dzjoDfWItzBq
 aJYV1cXFjmc8opfVmMQOikNT60Ywg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2118.outbound.protection.outlook.com [40.107.237.118])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47untj5xcn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 02:32:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQcJACRjpT0/1pN/w7yA6H73ZoEw837jLjb9FjDtW3guDjYjmOkhlhll+XNyUP1awRX6v7uOUoK2hXXB948V/Wtb4YOA0tMlDigFE1MCeQ0uzNQxBf7CV5U7zdvrc+f8c21g4bH0M4uJ1Q3rGRYqnqC82gVmK4GbN3UbYdG5sUQBh6X6BO1Qko0EMbX6vWzVNRRqjG3TQUyPkMPovX/MuyDlYyYrcyj5Y3uHPg6odrYd6jTHqyO6ZwWSzwQXD/6hjfJI+B1KgILEu5da+F7JRN7/kdre3JClnCL6RYiCEB3Te1wH/ziF+MXmlYbVy5fWiLKVaeYk/bpGqtgmdjQJiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeql9jf+mmFt6ViixkLYBFrx40DCC2q2ZAEu4iSFcGs=;
 b=DEHJrzd0olKoK0jws8hOqb5sdEPdXKtGNaIGSe9rx5SaU/Llk2UlGJOR+ZuGnM2zbUKytVGRoyFa4NvWJMQnUVNeU6q17vd/pl/gUSd4gMMF1AN34OEjOLh/I6tXVXE/XjAjIFdiCuccGT6BTf3QcEhqQEga9OzSeek/LLn5qtlu3nylHZzevExQRcMZ2DcD4/JeB8cEnTv6DhMFsrMbyHNup8fB8odKA7T9nE6IEh77+Y8napyqZTVWw3EdfTpHuTCEuPrHN57Fz5sPPWxUOmRsmF14l+rB41cz6BnRTTtHCVwqw9C5TuquMEoMyfPyWIPQWEKZSEosj1yo8yCdcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeql9jf+mmFt6ViixkLYBFrx40DCC2q2ZAEu4iSFcGs=;
 b=Ptpq09KXCjofjRrndWfjuda9XP38AfXJZgVULPEjUW+6HhGxthadhOqe7Qgggv9H4xqohHKY0MVMf7Vr63oUI7p/sQC81UjicIcqJ57TgPvMNEcf7zsm5NWQOj2J4Swoj88L3pJm4bNhzoLpLMNfCEqdV/EKF4HDOqfG1RhTJtMJGM9qAhpM3Q9mAe6BSFOH4z+ukbrCW2hSD0HlC7lSrHNe9sCmcYb+kmQTvpAxa6hK1mj0YZ6R3oVCOetcJGJ+jWnBZ/EdhdQP+1Oz8rjJSqJtoegcBRGoli+662c0NEMk8aB6OWEetZ86/uHgDA9H7DHDUmAPA3XKsJ9Iw0nj3g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ2PR02MB9770.namprd02.prod.outlook.com (2603:10b6:a03:548::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 15 Jul
 2025 09:32:35 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:32:35 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 22/22] vfio/pci.h: rename VFIOPCIDevice pdev field to
 parent_obj
Date: Tue, 15 Jul 2025 10:26:02 +0100
Message-ID: <20250715093110.107317-23-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715093110.107317-1-mark.caveayland@nutanix.com>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0043.eurprd04.prod.outlook.com
 (2603:10a6:208:1::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ2PR02MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ef9d2e-84b8-4abb-fe66-08ddc3828859
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gy2sUgwJbRpQGoupi097FSFu72dUuJsQb74oxg7ht/D+GNh7EZmtjoEqidF+?=
 =?us-ascii?Q?xHCo5Ir5+9KO/iV6fzwjyhiUetT86oihq4V+Si5/a6cvZJbi/XG5iChcRuuc?=
 =?us-ascii?Q?Qe9yqzePrDs6VPWaXJ1RPzIgoXSPVQd/OzdStvaxiTrnU3KuH1wheWljhZCv?=
 =?us-ascii?Q?80eYQyjZEt+HUUoBh3QhVhUqX+Qip4y529MXC8Qa2ks2BEeNamBg28/UxGyS?=
 =?us-ascii?Q?DPDun9OJnKIdpWLlw0aEN3Ea4g4HmUGF8FlkguU0QppE7KI3Wy4+YEqyulyW?=
 =?us-ascii?Q?byArMng8PrFYDIQDdlJcEX9QCesW3mAIuJFFASDzlJ1MD6lY1KjKgmO9Ujme?=
 =?us-ascii?Q?KIV6AO0kotESGcVN8j0bKMtESslR9HCUifTrSGCC7SCSC0KfqWQkgXq7FHYf?=
 =?us-ascii?Q?7xcDUML4U4ujJxswuN1EJhQbpMQM6vFM0WoijHeMIXuJP8AA7as6easVNTs+?=
 =?us-ascii?Q?0+eNWkrACRZmNDjvi6kT2OjghpNEHufiQtTCLNnswNOwwLTpyE4f9AFQX+01?=
 =?us-ascii?Q?vSCmoKn0yPB+KoA/5G8tHSGvUAkQ8gFZKNNB1OB0O6LATR7F1WMpNfNcvXVR?=
 =?us-ascii?Q?E4T9ApTMtWliAkw6WNKAhsV+gXqxE8AOoQvjoV/0C+TsJsziFn+9FqYhh11u?=
 =?us-ascii?Q?1IJumY66OA2d+9jCkvhAhM523lJQllBiT1kiJ+/PpUYAMoCrjBKVM5dXX6UZ?=
 =?us-ascii?Q?0PUhL68/eYSO6a8TgtC2bdzxgtrSd4liOkGO3VhKrHUChpmD9gEMQV7Bt1pq?=
 =?us-ascii?Q?/nJKwHXL6jRWyf5BQ7DeRNTDoGqsVe4rFnVZwYPLwxJCwpcgVyvn6c666bGq?=
 =?us-ascii?Q?Bxx9fjXAPvbvCDrwYKld0Sp0CzexNHfcoZU4zNzjJONf7w5Hgg0TGe78lPFQ?=
 =?us-ascii?Q?4+mjcF8GNeFOl0B2SBGwbrWM4thBLdwnd0lPulXv4jqDe1Qsn/RQEv1BP0cV?=
 =?us-ascii?Q?HduzPw8mZTsZjBvNduWOnSiD9eQ/VzryjINNkSaH1yiTn58RTRoRGXCBJ18J?=
 =?us-ascii?Q?JB5fWBvyxBj97yEF6TnekUPdGsR6R7f/fPRMd0e8+cB6Uzknir1Q2NbJ6o4f?=
 =?us-ascii?Q?U4akKDMWMQEYX+YkEou1NuQj5nSSPxnF/AAzSIbzQCX98pcn8n4sMmmJEfzc?=
 =?us-ascii?Q?NNT7/yJLHJ6TVIP5lBxFnOUgrN06wOpsJtX8HQ7GEZAHh2SUjEUW1wHxa6pb?=
 =?us-ascii?Q?Lx7mLdiJqYN0Fw/ig/5KdQE9pjhMlO6Dxr3/+hF2L0n8dvADtcQ8qWIQMYZy?=
 =?us-ascii?Q?9ADy8FWlGzIiecxTro9Y1ITOve6yl5nIZNAAyU6IzNa8M6ldpGbQpmUUJsEN?=
 =?us-ascii?Q?/jJFgmhHvF4EooZG87DmWXke2k4UAIGJG04fuK2OyKouCyK/++23NsXJuXxJ?=
 =?us-ascii?Q?DB52REVY+m4nJDHMCzIvLjaxUD9LB7AgKMKMUhg3Z4ix9XkBKvcDU9YG85sK?=
 =?us-ascii?Q?1XamXDjdfofACHt+dOeXinWKj19D9iQ+4l5/r8fw+nKS1djP7UEp2Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qFtzLKbHlc5g/93+uQk2AlR9O6eeOloskdpJo5lcucyToW3nbHcNQ3Zllv0F?=
 =?us-ascii?Q?hoTEijEoXgT4mzK4rZVhZ2giPtosC9Npp2+IO6kf2mZBz6oG41d3lDMjqZT0?=
 =?us-ascii?Q?B4sjM/Ao7FEaKz2r5z8y7vTnKGBPfOrgeFleWCGrHltn2xfx05ABTEcIAdzl?=
 =?us-ascii?Q?TW6r6Lf79vjsoA3M30ZvxnOKM22bBZaPtjQmBCs7ki6aQnTbxA91QOUy9Dw1?=
 =?us-ascii?Q?6MEldF0nQ8OgLzPeY9UMxYRfeyEL8NyXi+mOO6on/XVp+fpICSZlLebqyF2w?=
 =?us-ascii?Q?WBpo3rkV9PCkrX45jLKGetde4s6z2xQzJk4fJ6EW7xwfqdys6JlcfSf42ZUv?=
 =?us-ascii?Q?g5z9X+xzw92x+97QrmYoW8O4ekcaXikhg53rymlBUgauobxKpTsQgMKMpVdt?=
 =?us-ascii?Q?IVtbfD1fIxQ90FRI7WMqGOm8LVXcE4FjB6Wvrb9RE1JcwaD53UiGDz7JyDWj?=
 =?us-ascii?Q?dO0Y553G52l7Zq0vMPE5bnxUGWGu3XwfVyJ1/VldqRStXqsjQE6CcFWBqcm5?=
 =?us-ascii?Q?+fGEpSuc6LujyIJtxJjyu9H6HAPA0RHEh+lj4oEASiaCFZIaTyzpcoQYI05X?=
 =?us-ascii?Q?G1tl56v5f69ZVxfuUzssv5czdMJGLbMyc+DC5njVhHqbp8MJG0wo13AxBaN4?=
 =?us-ascii?Q?6o+BUi7DAhu8jgwMyl1lEgDvgdiAfY+2jSkbob8fmvFNg6QC82Zm+uFfvM0s?=
 =?us-ascii?Q?tlaOFeRLkrsF0noXQYHZazIK8lKtrrxPeJ5r1ypG2tAh2fXMdq1CP7JpZdg+?=
 =?us-ascii?Q?IaYnL7nVLuZP7fCNd0vzQdc81p3IgR3OGz06ZddJg8D6Cfuo0pZYxfJT8WFr?=
 =?us-ascii?Q?lqd4UHfpb+m4c7SwVd6WKAeUOMrZZ65SquXtYZb5fpOgfeK2ThmBvMk9593Q?=
 =?us-ascii?Q?r8rFJz4c+Oq8t5qXQeReSS7Fuzne2Bniry6tuhMSKQRFZUW5/eYjsOKDo7nI?=
 =?us-ascii?Q?WR4LlLgTFbWfhPX8+DJgPYFAYcq+OXaaNDhFMBQY3m4wQn2OxYX+BXzE9tsp?=
 =?us-ascii?Q?3RhyLH4Ndb+zcJtFz77S21IEff9QExxPJu3E/SBRYxLm9rT3X6m/bHymf43X?=
 =?us-ascii?Q?xHDdSUJS+fCgzuOAuUPfJu16Hq13rW/P94fE3ewddVKuh5ptiHWsGcFDWJbq?=
 =?us-ascii?Q?ba7D726JLT2/a8UgqPldjbpUK2D3h90eBoX4aEBt9ofgYi7gkws977mxMn30?=
 =?us-ascii?Q?YPfMU3AKXhIrXSLe501mnhPCxuY+Qk1Thi7S7mVHIVT9rbaocyNEAOIIKkH/?=
 =?us-ascii?Q?XMQDqZHYGCO5QDaj3OIGMFckkBy1fpLu4DaYMBIxaPVUNu6T2sFxVtpsIeSg?=
 =?us-ascii?Q?JjxBBUV/rc83EvoefMP1misKKwrOj7GfHtdu6MW+sb3nvha31M+bwCnO5Pr/?=
 =?us-ascii?Q?DUHxvmBH+DjoiVmkp7tFpJFOdTV9GatCpXm5zUOLMdU+gzG+ahdQEeNAh1i+?=
 =?us-ascii?Q?iyDIeDf63/lFAcSx9t8NSyHgBu4lToFskcgdJZOMThWuAUHUzaBz1joYu3rR?=
 =?us-ascii?Q?rfwQFE0ZA7JfoPzt+U1+1Tusis1saw46/z3iGdno3588PFfUGOd6XBtIXv0+?=
 =?us-ascii?Q?9uZ11kZnKH22umgrwN8hlVad2xHAWV4TpqfSUNz6j4ymwUuIVAp9VWzImSIj?=
 =?us-ascii?Q?aQ+Ny1qhDDDT/LuGQXUnFnp63nFUhZfR9E6mGoTf++pTKGDsghGjwcQ8tYIV?=
 =?us-ascii?Q?0WYMRg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ef9d2e-84b8-4abb-fe66-08ddc3828859
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:32:35.8300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/LZ9DEDic4nZPH52W1Ht91QTA2OEDS4QaeXX/J+9ooBQDXIbXZj/h11PvBQa3DKsnN2zy+QhVFhLAR766wsLzQ6FZ0fywhCp6e60vrUgj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9770
X-Proofpoint-GUID: o5Wi1te9Lolvgaa9Jx-qMkuoK5nWXq7i
X-Proofpoint-ORIG-GUID: o5Wi1te9Lolvgaa9Jx-qMkuoK5nWXq7i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4NiBTYWx0ZWRfX5zvks5xNHjke
 BtVkF1GMf7zD6zPswt4sO5ayyaPb2cmIrHxfP/cPziUeFk0DvIdGeujxs1+xr1avnEIydoFoxwg
 wOpohUUrueD+2IDn7vQYTX/+LrwjRPSC9QAK26tMi66bohygW79ahM1E7ROqN//e2oI37PKjGqF
 rtv7wyX8njGpzf47OyxVKjYwzvpsvURLjTvfEvQm7TXImwM5CApg9+BZOEJrkNfEkgNpGagJ+sz
 QXloa+B91rDnB70YwnhsiCJXlSOPXUkMNz9uriBlg49WgZQkoKOGRBXzrNG/lCeIV25C0m3Hupu
 89N3AC4Glbix7WMGHZxh7q5qOCnjT1yXzo/WP5FnaLttMMIctf8U2cVMs8EKEzfxZFUFRbuHsSl
 dpWlfqXaxdH9u0EvZqof1qpr62xQW3OjQ4GEwVhyC89QBClMRrehuHTxjfnAP+wppQidZoTX
X-Authority-Analysis: v=2.4 cv=PYb/hjhd c=1 sm=1 tr=0 ts=68762035 cx=c_pps
 a=cREajeUs7dwWx3wSMBFr+A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=vvrUWx9EApP6drf7YMMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Now that nothing accesses the pdev field directly, rename pdev to
parent_obj as per our current coding guidelines.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio/cpr.c | 4 ++--
 hw/vfio/pci.c | 4 ++--
 hw/vfio/pci.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index 3e3f4035ab..366490c908 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -171,8 +171,8 @@ const VMStateDescription vfio_cpr_pci_vmstate = {
     .post_load = vfio_cpr_pci_post_load,
     .needed = cpr_incoming_needed,
     .fields = (VMStateField[]) {
-        VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
-        VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, pci_msix_present),
+        VMSTATE_PCI_DEVICE(parent_obj, VFIOPCIDevice),
+        VMSTATE_MSIX_TEST(parent_obj, VFIOPCIDevice, pci_msix_present),
         VMSTATE_VFIO_INTX(intx, VFIOPCIDevice),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index fb9eb58da5..1db6be8f21 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2804,8 +2804,8 @@ static const VMStateDescription vmstate_vfio_pci_config = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
-        VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
-        VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, vfio_msix_present),
+        VMSTATE_PCI_DEVICE(parent_obj, VFIOPCIDevice),
+        VMSTATE_MSIX_TEST(parent_obj, VFIOPCIDevice, vfio_msix_present),
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index c0c3d68742..37d8b996f5 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -131,7 +131,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI_BASE)
 /* TYPE_VFIO_PCI shares struct VFIOPCIDevice. */
 
 struct VFIOPCIDevice {
-    PCIDevice pdev;
+    PCIDevice parent_obj;
 
     VFIODevice vbasedev;
     VFIOINTx intx;
-- 
2.43.0


