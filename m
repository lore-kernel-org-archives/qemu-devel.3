Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2869DC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXh7h-0000j6-TR; Fri, 04 Jul 2025 10:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXh7e-0000hG-7k
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:10:38 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXh7W-0004c5-61
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:10:37 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564D9LRK030199;
 Fri, 4 Jul 2025 07:10:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=cH/4EY5NGIVcX
 22QFSOWcSrL+J9vdr0+IZL7a6z0YjA=; b=UEpvv3lA6zw9E/adC67J6v8mLgTl1
 uBrot75fDKQQvC/8O8A5i4gKg2kF1wF1kiPsCf/OXKrWtL0mKStFFVBHE29kyNVf
 2C+WX1D9piYeB6t2j7FDNB6WCb/+5TERIXQW0JhlOcxCfSjRRViWGgGqkh/9ctHL
 +LnjuqJkQV677PIn7zS7ix22D4JnDyEGOmkXTbfaLrZXMep0deOOocIKywlsDDHG
 zE+qLc7HLzu2TVqyfSYgAtdVFbo4A7yP6AOX5v2CiPWeasHnYGJeISJj19T0625q
 Wi6otP0vHuR/KWktxpxAZvVjtn0kqrGOpv42ksk9Xps8vkIEoGwB7pMbA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2103.outbound.protection.outlook.com [40.107.243.103])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47pfk3g3ak-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Jul 2025 07:10:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gsl6Utbr8sEP5dKmf7qpTFd16qaSMiw6kVaygNtdH1VIa7mwADno9m+kdNbHb0xscpeF0YFaxvo95fSe7WbACZdzLSaKdwr3cwScjo3JKUhFzojyLvpQ07eEfG3RWhd+3hImvUyE/g6IVKBCXg9fh3o1Vph/Ee46a8275fE29g7Cpq/ysmPDRfLAwmj6diOxgAoF5+HLAyp31OxWr+Jf46Lx35qsKhjfYdSCjZKivZ1312G0h9N9JovIF97355axbpc1yNNXEocm3iLf5VElrj7rcsqOJe1xJVHDbo+xW8YbbAE2EMOO5NQAmFX+RNCbqUI6Cj8s5FhBTIzh8LlLxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cH/4EY5NGIVcX22QFSOWcSrL+J9vdr0+IZL7a6z0YjA=;
 b=Xkm+VZ/L3uOh+dFqTefWEePQesEb/ELN3OY+StsVYM31gg8n8zd2Bg18zKNcmrSUhkhWJuQOzsbja8SHPvgePYU1qEmT8HxE+nMfuuL059gC7sTr9//6kLInw7ZhDEMS20txFUJTd0Xrck6D5L5rEzdin2sbbnLe/gRiDyfm8NKOdhBB5D6D4t3I+xIylGIVTTuGvHRAD+Pm4GFPI0xF1P8SU16Fs4AEm6ou4rLFN9zJdiFNOmvs92C7Nc9RtACEe+2m4LlqGrbNnxWGJ1tZ9mSaVndO2IBLNu26sg397YR2Jnu3CyL+ONkoZx4Bwi0MErQXqzTnKganv8hdvH95iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cH/4EY5NGIVcX22QFSOWcSrL+J9vdr0+IZL7a6z0YjA=;
 b=ouHxvRUZUAdArteVdVOW8zvO2QUNFrWyXsVyet0ZYLePCuyuO8MpAf/x6FVLqc3bX3QYLJffQW0XhhPUyVhIFDEystn2giUg3ylZCETW9x3+wPbTHHOQbOgnt6/zzXesuJ7ycmv4hixLdkiSMbI9zD95kOdgHVk/RzSauPpWsuuiSpdNUSHNaX8GZmtyU+5QGdcZaxMMjub+IdiBlHC/gTXuqnt3ZGiV/7W+f6LEKqQ60LI17rqhylxEBSqHq3pVDhOiHo+9+49LdHMyISjMk7zSE6GuX7MirxG3Qp/ArIU7TeU6SwZqrHQn/pHLhx7KfZMKi5E93WzqY7cSsrvD+Q==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8045.namprd02.prod.outlook.com (2603:10b6:408:16d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Fri, 4 Jul
 2025 14:10:21 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 14:10:21 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 00/14] hw/i386: separate isapc out from pc_piix
Date: Fri,  4 Jul 2025 15:09:27 +0100
Message-ID: <20250704141018.674268-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR06CA0108.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::49) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: cebe25fa-f95d-40ad-2d4b-08ddbb048365
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmRrdDZNZU5XWnJtZ1FabG1QcWNDRjJZbmc0c3Y5NzZjOXprN25PR05wM0RI?=
 =?utf-8?B?cjNVT1dhYXZGaGZTall0OTFJN3NrWjF4MzlYVW1Icms3anNla1p4NEdjdUNS?=
 =?utf-8?B?TWZvcUQ0L0tVNjV1cWVzR3c0cG14cWpjbW9xSUJLRjZyT2RYVEkxUHZVc0E3?=
 =?utf-8?B?N1B6c1ErNmFaejBKcmVtRmxqckFXOXdscHlZSU5oTG1vaEg5Umk2SU1kSU1X?=
 =?utf-8?B?L05OdklmRllwQllSYThpRWQ3d3l3RWM4UVdDbnZOV0dMQWpyaE0zMDlDL1pC?=
 =?utf-8?B?NCtxdTBNV0tWalNCaGJtV3hTbUFCKytXUWNyMzJoTFlVQkpSYkJ6V3ZSZUlz?=
 =?utf-8?B?ZXhXVytDR3pNVlFPYlY4OFIwMFVrSkZzSUNBWVVVZGM5alRkU05ZYnNJdDR0?=
 =?utf-8?B?NjNhZGtlaFYyYXNPaUJFNUtTQzltVnhTakFtNmlwV1U1VS9WUEZvTnZpR0hV?=
 =?utf-8?B?Yi9tQnYwMmhrUDMzWjB4UTdpNXFTR1RyZkpVYXJNRVpqTU9ubE1LazMvUlpR?=
 =?utf-8?B?UVpxMFZ5NEZ5aGlQbnFJbm43UWNqT1ZTUkFBcG1naU9FTFh1bE1NQ2V2c201?=
 =?utf-8?B?ZHM4Z2w4RElPMHl6ZmREMUZrd0l2aWxEaVJtbzNFWDVpRUVpYTYyajUwYy8y?=
 =?utf-8?B?Rjd3MldIVkZOQjVNWThsQnd4NXJRNHZkeGgzNTF4dVh3dlVBdy9WTzMvTmJZ?=
 =?utf-8?B?Wk9WcER1U3hzSFViZTJHd2JDU1lmVklCR2tKQVlqV2RMendCQ2FpM1pqNGp5?=
 =?utf-8?B?VFRtOEZKMFROd0M5MTRzVVlFbE9uOHAraDhoNksvcGhSUFJLelFWeFkxQlZv?=
 =?utf-8?B?NWh5d1M3VDVPcEVsa21tMFhjYTJubExDendRZXFpbnRaZ0RkTkI5VzEva01y?=
 =?utf-8?B?RUY3SkdranJCTnN6UmV2S3I2QUdQUnJjY3JCRjhXbS9VS2p6QnBEM3hWYTFO?=
 =?utf-8?B?WUgrRlBBcUFnVXlSd2JxcUdlQ0loc0NKN3VDaTU4MDFRcmJ3ejdLL3BVUHhy?=
 =?utf-8?B?T2hLRDh6SmpXUXF0d1ZFcG1aVkp2QlFyRVNsR2txd0JJNytXeE5kM21zdUZD?=
 =?utf-8?B?VVV5SndtWG5jMVhRVmo5YU9nbUgyaXhaSmdVWGZubkNKMzd2Szk0OS9IVTZ4?=
 =?utf-8?B?c2hLa0paYXRpT0x0MkFYSksxNUZ6ck9jRGJ2U2s0NjFjNU5sQmhZYzVyMExB?=
 =?utf-8?B?N1laLzhNT3RiWHMyOUJJRUxwTHltL21VZkt1WkdBQjg0ajNuNmhTWWVIcCsv?=
 =?utf-8?B?NE92eDlmUmNBdXFpR2tYU1VwanMrYXNKNWFZUk94bWEvZE1vUkwybUlOdEdG?=
 =?utf-8?B?b01RaS9ZcnkvQ0ZWRUlLUC9VZVdLQjE5UUk2OE9vUWNLMkh4NVRHUU5vdHdT?=
 =?utf-8?B?WmVnZGZyUUtGY1d4V3ZpTHhsbVBQdGJCWVFjanFJbzZSN1ZqU2FEY21kbjJF?=
 =?utf-8?B?cUs1WmJHWTR1dTlnM2tHTWZHbXg3Y1l2ejNZU0RpZUFqWXhrYnYxYnpLYjFh?=
 =?utf-8?B?NExxRVYraUZVMGhRUEdUVXFNQVVXMHMwbGNmdGFJeSs2TzcvSVVpY2JoUVVJ?=
 =?utf-8?B?bmJrY3dvd2lnU1RJYks3TlgwNWFWcWNIU2QyaUxCbnFMRnV2ZTZnMnR1QUla?=
 =?utf-8?B?K3pqdU43ZkNrK1EzUkR4YktITnhmUVprUjhyaFNlVHhObnZiYkpNTDRldSty?=
 =?utf-8?B?SS9VMnRnd0RkRXpUU3VtWlMrT3BWcU90QlNwRElENkFzdU04bTVnNUEydDVM?=
 =?utf-8?B?OHl3Y3FNTEhrL2lrdjBNd2ZVM3I5RzFwdkIyL25DVFVnamhFZ2FGb3pjakxh?=
 =?utf-8?B?dGpxSGg3SnpTRWdQWHB1YUpDMG1pcWVacnNOUDcxMEo4R0xqSHVSTTlCU2Jh?=
 =?utf-8?B?L0k5ODNRMXVJaEYyTTd4ZEpIbEVlVDdMaVAyTTR3VEdKYVBudXExeTJzSk10?=
 =?utf-8?Q?M821QjXJbIs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1RReVpIdU4wL1d3cXllRVdmbU1jNmY4bzE1SU42bDl4T29IRE9sZFN4dkhI?=
 =?utf-8?B?ZERLQXJ3VXczNEo2RFdPc1dBQjZVVlpMRzRySjdQY0s5RG9BRnEzdEh6bEZN?=
 =?utf-8?B?cFFxdnVjdEk4eU5BTEpId2puVWJnVlRHRzBmSEFjTDhSdnI4L3ZldTVsUUxM?=
 =?utf-8?B?ZWs4ZXFEb3RpNld6bGVKS1VTeUdRZEpVUUVvZXFkeTg2dVpUdmJNQmJrNURu?=
 =?utf-8?B?cy9ZMFlMdVJ2OXhOTkRUeUdPZzZJQTF1M09zbEdqNTBoSUtuSk9RaGFPcjZy?=
 =?utf-8?B?eklva2d2blN1TFYwMkF0TnFrS3pkSHFKN2VpWUx3YjhqMWt3MWJzVVEyVm9t?=
 =?utf-8?B?ZTJqMGV6ZDR3QzBwY1RWT1JOTHM1cjRKU2hPc2d4OXdhT1cxMWVsdmIwckpj?=
 =?utf-8?B?SlcxeWlKa3RSWW1Kbjl3RkUvNjBVTzhqYTRkbDVrUmRzN1VJcHVIZzVaWmxD?=
 =?utf-8?B?VThKY1dESjNtQmErNHlvMkE1ekZmMkVUeHp1Y0FZZ0hmZDU4UkNkOGZoS3VS?=
 =?utf-8?B?UFVxRCtza3BaVHBDN2I4dThPMjg5bEhGUnFobDBaVUF3REIycGwwanlISlZM?=
 =?utf-8?B?ak5hRGJ1U2dacUNSN0NCREJkeXljOXJXTktETC9BcmtjdVpSSm0zMW9OUGpl?=
 =?utf-8?B?MDhjV3hBY3RjTlJjR2JjcEZnNWx4aklPMVJKWGdLKy8rTllXU1JPMWdRbmtL?=
 =?utf-8?B?YitOQTgxT2ViNDZhdmE0UnlSblJiV3Nza1UyekRyYWt2Z2FCV3JsRDFERUlX?=
 =?utf-8?B?dHdZcXFvZGhOTmVWZHJscG1SSmt4djNCNEZNTWxRS1JCQjN5b1V6ZkY1WGNr?=
 =?utf-8?B?UzM3dStVQUV0TmZ2TFpzYU9NQTdGT0pSb3ZlelFRajJDOUNQNW83Um1rd2pX?=
 =?utf-8?B?L3F0V0I3RHFKeStPNVdSK1lwVkVzRklVNUZyK2wwSnFaZC90K1FNQ3B4T1pv?=
 =?utf-8?B?dGZuR3IvdDg1a0VHb1htOFY5bUNqd0xVT1VtTmllSnZvV29Dd3hBY09ReUhG?=
 =?utf-8?B?UStiTmU4ZU1FZ1pZclQ5R1RadkxTSzF3dkxpUEthMGtKZFNWQjAyT0FnYXRm?=
 =?utf-8?B?ZXNId2x0MHduN013TnBFM3VLcDlYNDZYc1ZTdmpFdkJaVys0NmRZRWJCNkVa?=
 =?utf-8?B?UTdUZEV4Z3NwSDNOdmtwSEc1UkNLR09yTm85eVIvR1ZXbzlIS1RtalhZZzJr?=
 =?utf-8?B?ZHorcVJSTXlPaTh5WEJyMk0zc29VYUQzK1ZCRXRJOU5MUW5WbEJCVzJub054?=
 =?utf-8?B?S3NwdWU5dkhKYnQ4eGFrR1cyRHhuaHNGUjR2K1FZajNqQjdaZU94SkMzRXJY?=
 =?utf-8?B?OXY4OG1oYkVLVlpWd2x2L2ZBbThCTDZIR0VIemhOUXlweUtHNzlIYzA4cFEy?=
 =?utf-8?B?M1dzTG9JWDMxWnAva1VzYUhkYnBPYUk2enlId0FoZ0tnbzNXOGs2UEZlS1Yz?=
 =?utf-8?B?aVVmUi8yM1pJZmc1V0RzQ3lKTS9pV2s5NmxEdjNoMy9DY3NIUGJEWUh5a0Iz?=
 =?utf-8?B?UE1XMXdhdG1EVmN6VE9JVVh4ZHdXVUtzcU93TmY1K0ZiUnZ5Z1JLREZwdmhC?=
 =?utf-8?B?WUlST1dnKzZYa0RPTDFKZTJnUjYxUkY2TDU5aFlPQ1ZNL0QwT1crZmlncHZk?=
 =?utf-8?B?MFBqdjN6V090eXRHY2kwV0RDNThUNFZ6aWxJSHRjMnQwZnN6WE80R0VwNG1U?=
 =?utf-8?B?dHVOUVEyK3pUNGNuMGhxcjNEVVc5Q3FXQXpmalZDMHhydGJwNEtoRXJqdERs?=
 =?utf-8?B?MWhnelJRMWRhVkpkLzIzSEVTTjZDcE5DYVRJQitobStlUlNPbWNwd1gzbFFB?=
 =?utf-8?B?azN1TnlocVVqS1JnYVBXTlpXWDRNcjgweE4wQllVSVdBckVrakRzZWtiR0VY?=
 =?utf-8?B?ZnhnK01kTXZOZVkxK1VtclVuam9OVnRCdUN2SWJHNmxYREcrMXdWQTEwQXdq?=
 =?utf-8?B?c2YreGVUK21LVm5BdU5JN0pvelVyVUxxVmp3L3F6anBhc2NkMEtmZk91TkZ3?=
 =?utf-8?B?dFExTVMrUURTWlVHcFhZakp5WU1qYVNVeVB2S3pyLzBpZU1oaGZ4dDlZMDJI?=
 =?utf-8?B?UFVvZW9ZaFlwUEtMaFRIZW9OZUtoYnpCN2piL3hYNnhMTE01eGNSbE45ODdO?=
 =?utf-8?B?aWdrSWNKRUZ0UWtlNTFDVHExd2VBUlVpRWpoQVU1YVlLSm1rY25oZFE2UGUz?=
 =?utf-8?B?ejFWNWl4V2JlZEw2WUsvc3p3alduQW11YXhlcFhVSGpYZVgxRXdQUHVZUkIv?=
 =?utf-8?B?SkVLSmJscjdTYU9VYlRrOGZIRXVnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cebe25fa-f95d-40ad-2d4b-08ddbb048365
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 14:10:21.6255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6D+GQOQLkOJZCq+6ZPG5/1BUFFJH8e1Sb9rH0VrxN9tYB9RbpK7VfmLmctevGLFZdteafpF9gXM8aIxlMvRsIPYYD85Mh2f7BasoBNZLimg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8045
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwNyBTYWx0ZWRfX2Ptbar4b9x3J
 cTV4ZyEHLlT0BmPTUXEveQh/W6fK2sx5m23QPXwk8C8eRmGvdnNlmvajvQb9BvLhU54ATRCeCF8
 M8hSBgMVmSnX6BxyQB3z/jk8gtsBCB6K8BUSwOEuSqwDGEUqSIzEnvPwOoUpVvzB+rwS3GF8vy9
 xtw3CU+hUyyh1P80msxRC9aTb51uxRXroigAWUF6W4k9FETnyVxoekz+Zgt9ULEEJA0q7rXq1Ur
 fKfrDClWXXKxI8ivdlwJkhRU/5t0DOVgK+JCemS2QOmsVMVXd3jhd88Drabk0oBAPG2zRPF4qC5
 oKTK10U+4fjM2G4igvJVU5B/aQtoh37/6AnZM1YKQD6Xr67su5yVuJCZXF8Xz2Q56iXy+VLU5ab
 nBNUglYQM48Sw41wwDhBAvJfCf2oCiO85RrT4X09IobupRNU06Hcn6dCss44dWfJGPb1uK4R
X-Proofpoint-ORIG-GUID: IFJBCDwacx1lpxYwlWBblnYSyt5ki0wd
X-Authority-Analysis: v=2.4 cv=AO34vM+d c=1 sm=1 tr=0 ts=6867e0d0 cx=c_pps
 a=z61krFjoy38gr3L9Xg80mg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=mDV3o1hIAAAA:8 a=64Cc0HZtAAAA:8 a=t_fk4poXdalvXVda_iIA:9 a=QEXdDO2ut3YA:10
 a=Y4I1g1QRc_YA:10
X-Proofpoint-GUID: IFJBCDwacx1lpxYwlWBblnYSyt5ki0wd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For various historical reasons the initialisation of the isapc machine is closely
intertwined with the initialisation of the pc machine, which is preventing some
future improvements to the pc machine initialisation logic.

Since the consensus [1] was that the isapc is still useful for testing and running
older OSs, this series splits the isapc machine and its main initialisation
routine pc_init_isa() into a separate isapc.c file to reduce the maintenance
burden on pc machine developers.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

[1] https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg06137.html

(Patches still needing review: 1, 5, 7, 9, 13 and 14)


v3:
- Rebase onto master
- Add patch 1 to restrict isapc machine to 32-bit x86 CPUs as suggested by
  Philippe
- Include logic in patch 1 to handle the case if an isapc machine is
  launched with -cpu max as suggested by Daniel
- Add patch 13 to tidy-up pc_init1() for the i440fx-pc machine in the same
  way as patch 11 does for the isapc machine as suggested by Bernhard

v2:
- Rebase onto master to account for the fix in commit 0b006153b7
  ("hw/i386/pc_piix: Fix RTC ISA IRQ wiring of isapc machine")
- Replace verbatim MIT licence text with SPDX identifier as discussed
  with Daniel


Mark Cave-Ayland (14):
  hw/i386/pc_piix.c: restrict isapc machine to 32-bit CPUs
  hw/i386/pc_piix.c: duplicate pc_init1() into pc_isa_init()
  hw/i386/pc_piix.c: remove pcmc->pci_enabled dependent initialisation
    from pc_init_isa()
  hw/i386/pc_piix.c: remove SMI and piix4_pm initialisation from
    pc_init_isa()
  hw/i386/pc_piix.c: remove SGX initialisation from pc_init_isa()
  hw/i386/pc_piix.c: remove nvdimm initialisation from pc_init_isa()
  hw/i386/pc_piix.c: simplify RAM size logic in pc_init_isa()
  hw/i386/pc_piix.c: hardcode hole64_size to 0 in pc_init_isa()
  hw/i386/pc_piix.c: remove pc_system_flash_cleanup_unused() from
    pc_init_isa()
  hw/i386/pc_piix.c: always initialise ISA IDE drives in pc_init_isa()
  hw/i386/pc_piix.c: assume pcmc->pci_enabled is always false in
    pc_init_isa()
  hw/i386/pc_piix.c: hardcode pcms->pci_bus to NULL in pc_init_isa()
  hw/i386/pc_piix.c: assume pcmc->pci_enabled is always true in
    pc_init1()
  hw/i386: move isapc machine to separate isapc.c file

 hw/i386/Kconfig     |   3 -
 hw/i386/isapc.c     | 169 ++++++++++++++++++++++++++++++++
 hw/i386/meson.build |   1 +
 hw/i386/pc_piix.c   | 231 +++++++++++++++-----------------------------
 4 files changed, 246 insertions(+), 158 deletions(-)
 create mode 100644 hw/i386/isapc.c

-- 
2.43.0


