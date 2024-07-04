Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49081C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 14:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPNko-0003SA-DR; Thu, 04 Jul 2024 10:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPNkm-0003RE-CT
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 10:48:08 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPNkk-0003Mu-J9
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 10:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720104486; x=1751640486;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=QQb36lRclXYTkFjtwY0m8Lyj053oQOM+CfZ9/7UX5G0=;
 b=BYXF9B67ECto9NruHiUBh/LPTSuLOjRN4UK1+g8xBmqFyOQek45qaCpN
 /KogIaKwyKFvQXQtk4YsiB9nSmD3W1IUeaYnyzWrGvfOS+Qy5F87j1Yim
 +M9EOpxzcQdvknEc5znGHlhIiTO3eFOXGnqu1Na34Z86BCtipmE5rb/Ru
 yzL7EOfXyt3bNJsEN2IojELYWvuka4K3cL9f8O69ddRd5ZERnL/60u9vw
 EnnpwBhUnaTGCR1FNYSafGFF+Y/ltn7MPu0TGYogbDguMKhaxgpqyu6ow
 1HhSPImxzBqfJTz/v/bsdPNK1FvHhsqEfCuKyexaKrJac0PwzTsaGatMd Q==;
X-IronPort-AV: E=Sophos;i="6.09,183,1716242400"; d="scan'208";a="15900767"
X-MGA-submission: =?us-ascii?q?MDE+WswcBz3JFwimMrhWkbhout1gA3DnuuzYTs?=
 =?us-ascii?q?vXwuP+7meO8zIjdl9RShBbQVmTV24g1iaJ7dMzvJ5rSIg/zDFycmFXW1?=
 =?us-ascii?q?UKb7IkxXc/3krlXdpKkKpS69AZLfjRPNBvK8GqhXxfsUVx7EmPPdRblm?=
 =?us-ascii?q?zDA2McNQjdZH+kb5R0mZb5zQ=3D=3D?=
Received: from mail-db8eur05lp2105.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.105])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 16:48:02 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPns+1ZQlcWikVS6E3wwOM1rHfGjWcTc6ye8KFT2VpbQsNymZNI7YTw0FirzV/0le7eVwLMsoKMa1a3mlmHDoVhLJF8Hkg6kW72enGS83N7du6mavzkSDxhao5jWPAOsOGzbQoqNZItqfKOkOSBRr/xzzifz9Sg91X0hCfMxkWg/xwhd4sO7h3WixxBPudDwLMyIiTIDnhqdtOLde8FME6h/MSnQvLsUoiQStIsdCrX/9iZzEcpnfkCx9AytXlZwv3ILFYfjsyjZhq8E7bar4UEnxu/lqegDeha1mHJd31BjyezPpxO7b0TXnRcwqAsZFMG/F3Np8unABtt7p3GZzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQb36lRclXYTkFjtwY0m8Lyj053oQOM+CfZ9/7UX5G0=;
 b=Kvc7I5d/DJCq2Ys1jHK42uwoBnyJEoUM/+xWRGrsC6tEBWb/n45RYJEpdyWErCDzC3eWKKaHivGfmDBeiHP/20dh18XqAmHaePxHd6fcz2tUhDk2ht0tGZs5yhVgWDFEARRUngqcVwu0rMRmVKE+qaf2jAPftAyiB26mfBteJJfXjEn01ny8SGMFnkJ6WDIOMnZkVvO6Psgmh/5qmhbtv2+RjvqzhX90V29lYT6ptr3nBpdWkw+HtRyXFk+t3eny33H831HPoFtoEI+1WpGdS4iEd3maDz/4R8uxvoFn/jEAyimRF+O2K+iCwOo/pRzKTNQA9NRk43Dipo3iiC+k8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQb36lRclXYTkFjtwY0m8Lyj053oQOM+CfZ9/7UX5G0=;
 b=LRSmNWLT82D4/6//I31gSEoeTM0gnWMlxR7ebQgtWXmpFFdWzoKv5EOx9kVuUSxqWMunlbN9YlaUSEkjGzx3cNTMeVzf5+er4V5QkpmUHrNyG1Ag3G5PxR0RUkoJEJF4GMfVuEpMDk4sYaUdyeCH1RCiJ09H3XSoRR3vavevcKN9p6DifUbp/GoZIonZZ9uV1q+d9YPIS34ITBQ4top1dWRvcQ8isaXfDNG3WQBq5+Kd3eKNGt3dnViB9XgI2iBkq0m4cVscAbwtn439h1a6SPuosfnmmmXWe60ga6NStSgVIZOVSFZ3/IMsyYmzSauW4w7RuGmiWHudQSnsdju3tA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB9499.eurprd07.prod.outlook.com (2603:10a6:800:1c8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Thu, 4 Jul
 2024 14:48:00 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 14:48:00 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, Clement Mathieu--Drif <cmdetu@gmail.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH  v1 3/3] intel_iommu: Bypass barrier wait descriptor
Thread-Topic: [PATCH  v1 3/3] intel_iommu: Bypass barrier wait descriptor
Thread-Index: AQHaziEqYSd3fPOVYk+uet6FPduJ+A==
Date: Thu, 4 Jul 2024 14:48:00 +0000
Message-ID: <20240704144737.996889-4-clement.mathieu--drif@eviden.com>
References: <20240704144737.996889-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240704144737.996889-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB9499:EE_
x-ms-office365-filtering-correlation-id: f34f8d91-3a57-4517-6f3e-08dc9c384d40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UWM2d05tbUxxS1pocC8yeXBtR0t0d2hUV2NveHFUK05PaFVIZ0ZZa28rYmpi?=
 =?utf-8?B?K2N5OXZ2VHViMHI5dml4dzdzS01CYW5kSzh6QWJ0ZTArR0JPTml3N2Jzd3dT?=
 =?utf-8?B?TG1TcFhDKzg0VXIvanNVaXB5cExvc043K1VrTmdiVHUvY0xJMjg2TDNnZmZU?=
 =?utf-8?B?VW5KaFVVWHoybVFVMExLZ0dQSVFXTmV2bndkNFJXUXZVaG5XU2NLcGhBUFdO?=
 =?utf-8?B?dWNadVN2dTZWT0JzaUpYRGc1cVQ0RHpvclM1bXllL1VNaHVyR0pJTFhHWHZy?=
 =?utf-8?B?TUVhUFpNNnRqNC9PZjVObWc4REJaMHN0bHI1RUxxVXA3T2k2TEJmNVZEUUc4?=
 =?utf-8?B?YWlNc1hnYWlnTlN4K0ZOVzJsNkxOT081SG4yOTl6Y2I5MWs0LzBFY3lXb1RP?=
 =?utf-8?B?cUFkVzFnY1JpWS84MnpZOVROclBNSkgzRS9aN2xwYWYrYjBQQ2NXdTJzTEJX?=
 =?utf-8?B?NmViQndzWGhWQ3IyeFVmeDRaeGd5MkljRlY0QVZqbS81UzZWeERacWtzUy8w?=
 =?utf-8?B?eHF3a1QwK0RZWGdiQ0owR1A3RElZU0NuajlIaEpJWVJrRjI1Ukc0MmlEWFdy?=
 =?utf-8?B?c091ci9ZczBQdlkwREU0NjlpOXoyeVBJS1ZhY0JMR0tmc1FPNVRlUmRhSnlM?=
 =?utf-8?B?b21jMkZlemJzcGQ1RzYzdzM3V1NTMEVuTkdmajRXTXBsQS9qeVowSTlvRDEx?=
 =?utf-8?B?R1IyQ2NDSnBpZDZqRmZvUjdwQnFRaDliWW5FYTlNL01iOGZmckFva0V6R2Z4?=
 =?utf-8?B?N092QkltRTlhM2tmTThUSS82UlJWVmVFQ2FHZWNYR2hBeWE1TzF6ZFAxSkdF?=
 =?utf-8?B?RUMvK3FXOXN1YlYweEEzVmU2SVFHMGNHYTV3R3paaGhENmROd1RGemVXWnVC?=
 =?utf-8?B?TU5TRVVacXRjUU9GZlNwNEpBb1JjbklaSmdGNEhmM3hTb1A3S1hEZ2wybnUr?=
 =?utf-8?B?Rnk5MVVGLzd2eU1CeDJaN0E5Nko1bG5iY2lrRFFDV1F6WCsvTFR3ZmdKZTNn?=
 =?utf-8?B?V2I5OG5SdmRCT1NsZmRWZnNpV21MYXhTN2FZUEVFaDd6V0Q0UWZUeUczcGJJ?=
 =?utf-8?B?UjdaWlhDdG9VMnYzL3ZPeTkwRXl4QnpFNDBsNjRKWi9MTGlTRW5zYzR2eTBk?=
 =?utf-8?B?NGo4RUEyUzBUTDRIYXV3Q25wUmxEdGRmd2RoT211VlZrd0JEeTQ0UFBPbTBI?=
 =?utf-8?B?WkVkcXZuTXJxeDRvVlFwY243Ukl4cUFENXc4UkpwaHNZVEx4WHZBb2FzcExo?=
 =?utf-8?B?b005Y0ZFUXowZ2E4dFJaMGhFU0d5ejUzR1FnTnFubmNqeHhWRWxpb3JaS2JC?=
 =?utf-8?B?eEtJbXIwaEN2di92YjJvSmxOditIbHd2ZVJObE9pRkFKYlBzc0t6ellNNHJU?=
 =?utf-8?B?K2dNUXUxRXRMbGQyNUZQdDlYUjdSbFE5dHd1WWhhTzc0blN0ZEQzdStGVHBL?=
 =?utf-8?B?ZjZkS2drOFZxWFQ5OHR2OFlDSVNKQ3Z6RW1EMVdlTjUrL25OWldnKzVPNUlZ?=
 =?utf-8?B?ek1lTklOeldUSE8xbmRiSk9tdURVS3AvcnpHMDYwa3hvR1dxQTRRYTdiR29p?=
 =?utf-8?B?TDQ1WTZ2bmYwemo3RGVpeU13QituK2hlV0Ywd1RFV2tqdUJYLzZxaytneTJT?=
 =?utf-8?B?bDlrc2htVVVpM3JTb0o2aXREWHBQc28rejVzZnFGVERtdlBEVm0yTEFHRm9x?=
 =?utf-8?B?Vk00SmZhNklFa2NrbEtrdldwcFVXM1JPYUxSeDBsU0NSTkcvOVZCNkxGVDh4?=
 =?utf-8?B?V25zNDEwN2srVEdUbEFCU0JIRGZHdHlNRUQ1b242aWRjbTVDdk1kZ0JqSDhU?=
 =?utf-8?B?NUx0MUg4RkZ0cW9ubnN2T2FtUGlqOE4zSlRBNW04Q2FFSVZpWkxkTjREdzJY?=
 =?utf-8?B?WmpwMjFSa2FqV0FSd1FoSEtsWDMwTm55dFJLRlVHS2Z6UHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azNSdTVSV2Z5eExDWWpqRFBCdXJNdXJXU1FKTzc2RFRhSEkxaEE3d1JJZmVk?=
 =?utf-8?B?L0FBejZicDZ1T1ptU01ncEN2VlFaUXFRK0hoMVgyM08rbGxyRi9yY1NkdXY2?=
 =?utf-8?B?RVZCMVBSZXlMem5VZnFDSEJVT0J6MEdqdmFBdzR0Q1F3OUk1TTRlcVlpSFBp?=
 =?utf-8?B?dUxTU3U3djJZVjlVWkZRUWNubjVvRG5QbGw4MmtUTzRKM2J6eGZXbkEvemE0?=
 =?utf-8?B?eXVqQ2o5d0lmcXJrbkV4eHJFM1QraTQyZFNHWUhjeW5PakdKYTU5WmFJY0RK?=
 =?utf-8?B?bnBxMythd29sUDBqekdaQTgyWmlrcDZHTVc3ZFpjaEhoK3NUdVJsMDBNS0lN?=
 =?utf-8?B?T1hxWkxVVHdVUEcybGN3RzBhVkU1TWw2VG53Q0xyY3phd2crWkM4SDFEVllq?=
 =?utf-8?B?YTAxbkZhaW1ZbVNCeHMzL3VLYUFFMW9TK1hsSFZ1akFTU1UrYklwZk01cFB6?=
 =?utf-8?B?S3FtZDhiSGgrdGFlNGl6N3VMNzJyTHgrd3hlSmNGRTdNbHZ0Wk84REl4aDUz?=
 =?utf-8?B?NmxnQXlaN0x1UWJ5ZFptK083d1VvMExST3BpczlDMWxVODVrQVplbkNXT2Jt?=
 =?utf-8?B?dWQ5OGtMd3c0Y0IrNlZ6NDRUaGcxWkdtZGxlMkRKWTc3L25GdVd2NWsremZ6?=
 =?utf-8?B?ZjJxT0FVQkh0NVlaaFBVZ2RqMTkxc3NRUzM4NzFoTmxmWmFEMHJOTjhiWVdT?=
 =?utf-8?B?M0d3OVZLM21ucTZadWhNZ0ZycnFxZ2lsUlRHUHJ0OUtIMWNTNWpNeDFRaDgz?=
 =?utf-8?B?cFNBWFQ4RDhaalMyc2lCSDl2L2M4TThWMFRlUGtXcUhpN1p5WkUyYkRFUVdO?=
 =?utf-8?B?Q0hGeHErNlREODEwcnEyZnBoQlhoTTN5dFVOMlV3V3NiVEVOclBySmJiVXBC?=
 =?utf-8?B?QnVtQkJXZVk2Z3VzQ250Y25YTlVVVGxIVGcwNkpEMDBDem44b3BwWGptSmxT?=
 =?utf-8?B?THVnTGVXV1dRMC9Pb1VJSmdLOG5IemQzY3lNWnRDaVcxbEhTVXVHR0ErcEhs?=
 =?utf-8?B?VWxaMXNzNDlOOWJhN2RUSlBiNGRHdkxWS2k2V2RxU09yVGxNQmd4V0t1Q0w2?=
 =?utf-8?B?RXhWTkJFVGJhbWNGWDJZK2EycXNJMVRzYXNKOUQ5S0gxRTZ6eTVFY016YTFY?=
 =?utf-8?B?YmhYMFZVVHJmRHlMcWRSYmhtWkpUSFJlNzM2MXBJUjF4eEhmMlhHMlZOU0w5?=
 =?utf-8?B?ZnVwcFNyY1czTGRZOG9ieEUrZU5pb240ZWZvNVFGVkRRbnhjMmROeWFveHZq?=
 =?utf-8?B?ZWpIblNzeHJISURwWHNPbS9vTDYvdDcwRzBlMHBzMkRHQjdDK2VEd1U0cVB4?=
 =?utf-8?B?Z1NxbGVsL1ZmSVg2R1RuVG5oNk9NUmxvem02TjUvcGhMaEVlaFBYNTA4QUY4?=
 =?utf-8?B?RnVDdEU0UVhOdUZxMnhnaENNU2oyVmlCa045VmpzUUJiNm5jSFduY2tRNk1W?=
 =?utf-8?B?ay9mbWxuSWVsTElIcy80Y1h4QzE4NVpRQ1VPQ0hmQ1lzQk4wUkxIUlNqa09W?=
 =?utf-8?B?N1B2MkM3UzVRYnRTYWFlWUlkSHJyVGY1d3BreDhBQndnMkthbnFKTnNvOGRo?=
 =?utf-8?B?S3lrY3FaZHpnK25ONGdWWG1jeS85ZTJFdWdZUnV1c0QrSzVpUnRaYTRRRHFF?=
 =?utf-8?B?MGhwa3BvSjB1S21XeW5pbDBkdzdPOUVQZXV3eDAzZVBMKzZZYndLYTQxcHpI?=
 =?utf-8?B?NS9JTm84NytlbStqOFBZWWVFTkhtQ1NMWWp4cXRoZ1pwUUI0Q0lPRjZINnlL?=
 =?utf-8?B?NWRyWGZRdExtQklHQVNYS2tBbi9JNGl5Y2ViQzNQOGk2QnZZem9raWR2MnJv?=
 =?utf-8?B?bzgyT3NWZWRTK21BVm1JVmNNL0F5cTdMUStRSTAzR0ZIUUYrME9zUExKWkZ0?=
 =?utf-8?B?aDYwWlRaai9hd0d3T0N4M2hpWmVvTnFYQXRsMUxReTN6dGluQ3NJT0J5L2pr?=
 =?utf-8?B?dzRjdlhXbTVpT1JvdENETncyL1RpRXlEdXNEVC9TZy9acHRObkxxNlZpajBv?=
 =?utf-8?B?dThOdERIOVBONkJ3VVFBK0lEQk5ZK3hxZ24wcDBmU3BXY0o2aFQyUVZ3ZWFl?=
 =?utf-8?B?anQ1cjVaTFJFazA0R2xlVnJSWXhVTXd2TWNEK2VRdWZzcEw3cVN3Z3pDdDRl?=
 =?utf-8?B?ZGYrUk5IcmVKbGhMaGZDbGUzSGpTTEhFRUM1a3pxdEFtRCtaTVhqWitYYm1E?=
 =?utf-8?Q?KQEkWKUmhBmj9veZrZb975Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CEE83A19AF94A14EA1D87E918FBB7808@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f34f8d91-3a57-4517-6f3e-08dc9c384d40
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 14:48:00.7514 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3uw6qK4VvCH60Qegk9xsPdXFvvgOBtf8hz3mv05GBpkH8qyz3X9dkVDgWnGWP/mknT3bYPs405WWy+bTGsvPm7XB3KObl5hC1QtpA1hAi8MpLjw05uAt/XFRJeFMCeuL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9499
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

RnJvbTogQ2xlbWVudCBNYXRoaWV1LS1EcmlmIDxjbWRldHVAZ21haWwuY29tPg0KDQp3YWl0X2Rl
c2Mgd2l0aCBTVz0wLElGPTAsRk49MSBtdXN0IG5vdCBiZSBjb25zaWRlcmVkIGFzIGFuDQppbnZh
bGlkIGRlc2NyaXB0b3IgYXMgaXQgaXMgdXNlZCB0byBpbXBsZW1lbnQgc2VjdGlvbiA3LjEwIG9m
DQp0aGUgVlQtZCBzcGVjDQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYg
PGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaHcvaTM4Ni9pbnRlbF9p
b21tdS5jIHwgNiArKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQoNCmRp
ZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMN
CmluZGV4IGJlMGNiMzliNWMuLjEyZWEzYTlhYTAgMTAwNjQ0DQotLS0gYS9ody9pMzg2L2ludGVs
X2lvbW11LmMNCisrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KQEAgLTI1NjEsNiArMjU2MSwx
MiBAQCBzdGF0aWMgYm9vbCB2dGRfcHJvY2Vzc193YWl0X2Rlc2MoSW50ZWxJT01NVVN0YXRlICpz
LCBWVERJbnZEZXNjICppbnZfZGVzYykNCiAgICAgfSBlbHNlIGlmIChpbnZfZGVzYy0+bG8gJiBW
VERfSU5WX0RFU0NfV0FJVF9JRikgew0KICAgICAgICAgLyogSW50ZXJydXB0IGZsYWcgKi8NCiAg
ICAgICAgIHZ0ZF9nZW5lcmF0ZV9jb21wbGV0aW9uX2V2ZW50KHMpOw0KKyAgICB9IGVsc2UgaWYg
KGludl9kZXNjLT5sbyAmIFZURF9JTlZfREVTQ19XQUlUX0ZOKSB7DQorICAgICAgICAvKg0KKyAg
ICAgICAgICogU1cgPSAwLCBJRiA9IDAsIEZOID0gMQ0KKyAgICAgICAgICogVGhpcyBraW5kIG9m
IGRlc2NyaXB0b3IgaXMgZGVmaW5lZCBpbiBzZWN0aW9uIDcuMTAgb2YgVlQtZA0KKyAgICAgICAg
ICogTm90aGluZyB0byBkbyBhcyB3ZSBwcm9jZXNzIHRoZSBldmVudHMgc2VxdWVudGlhbGx5DQor
ICAgICAgICAgKi8NCiAgICAgfSBlbHNlIHsNCiAgICAgICAgIGVycm9yX3JlcG9ydF9vbmNlKCIl
czogaW52YWxpZCB3YWl0IGRlc2M6IGhpPSUiUFJJeDY0IiwgbG89JSJQUkl4NjQNCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICIgKHVua25vd24gdHlwZSkiLCBfX2Z1bmNfXywgaW52X2Rlc2Mt
PmhpLA0KLS0gDQoyLjQ1LjINCg==

