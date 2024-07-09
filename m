Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A09CC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 06:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR4BE-0000qx-BG; Tue, 09 Jul 2024 02:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sR4BC-0000l1-MX
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 02:18:22 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sR4B4-00080Y-9D
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 02:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720505892; x=1752041892;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=u/EE/MVYvmwVs8wPu6Il6DxMESvsWjmJtHWqiv7M++c=;
 b=c2j3YLxpTs1D3C3/w6uJAdjMbNrPqsZFBDiXTK855uGoq7d/hjivey2N
 gmWw/w3M5LZ5GzIreFohPLTc9MsF9ngrFN8LUo2oi+8GtQ2KjebGl8TrQ
 6pv5MQSi8cJqMsd8P6Mr2ba4YKRkHlZTLbc6F6a4c7AfjDVioDusKOiLO
 5BKOMfHsESf2CoqUA7rbXHdi5oEwXuXWgxnibmqLDIDk07k0DP53P97FB
 QHQktWfXc+HjNxs2oFXyGg5D7tpWpYaC3H6ukrO3aqCaPxsyESqx4gJYy
 sYykCphttpQyRIzY9A2XqcZVtKuRnUWmzo6cwPoeY7nECUQFGzYYVwmrC Q==;
X-IronPort-AV: E=Sophos;i="6.09,194,1716242400"; d="scan'208";a="16131806"
X-MGA-submission: =?us-ascii?q?MDFZkqDnocJs0Ve7nOf5mK0LcPgE+m5APfHnug?=
 =?us-ascii?q?irGUpw6OOBO7dZ4uNmwwOS0OVXXyV+If3x0YJIt2osAXlDSJ1/F+yZG1?=
 =?us-ascii?q?ZqUbj8/Mt29liI47xn2HYTdIuEpxVy1A4QMHGDUdwMwEAOxj9bn9u8F2?=
 =?us-ascii?q?2zW8LIEGWidm3RLMdW9Xh9bg=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2024 08:18:08 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKsznQQ4g39mbFBVWIHPQZtUXO29S/9KnpUsIVNZBq1OMpDrD6v+mB91WEHvWZBWrCGNKoZNFnF7GwrmhFDre/ytlzyAGw5GKA0KCa0PE4wORU52BE61wv82X++/swzgYNocgaTMl1Fk2jAgvyjK7S/QA41xQYSO+XBONYZQie3vDlpIbc2xRFuC4puPWxpGmV8V9YY8ytel6fhB0RVdpBeop1JoVgidCci1KFQVJuYJSRdElHaxldVZvK2k8V/rww3Y52Ac3IJyeld22TcLSMBhHPnKWLmXRu4zDlV0Ulgc/ecSQ69rGaQubThGKn75YlMoig/gtpsnzAYAqhzx8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/EE/MVYvmwVs8wPu6Il6DxMESvsWjmJtHWqiv7M++c=;
 b=e2fyPuoU3hoKwmZA6bzmrgDiAtgzcS5SOmD2KzF+D9cE/VYAy6jR5/tei3zum2nZIbs7yAM+Z1pP456G48pma6QKZ+W4yzV8LlfeUh/h2eVFEE81lwEbu5sjMY1acsaYcA2gCca0bppaMBJHfJ4yw28as/3ZecUWes1hafgofg7sXrP8sFA7oSmR8GrqSDbtG1AGN4BqYGdJjsN5GbPi6pNm1GdWp+IIqF7vxZyfhs5Nky3tAfYPVcwKahXb1xgLNhwDeiP6klIFKe+w0oHvv/e12ff4/dTHoPOcF6SGgZmB9iE6SOcpGUsymKyfvJqnqeOsmqXaEPIP9DGQ+CWY0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/EE/MVYvmwVs8wPu6Il6DxMESvsWjmJtHWqiv7M++c=;
 b=Qwh6Ld7xr6W8HTtP3L6L+tuylo+HKiKeA0x4Y9m2kHLut4BL4tfSYA6BfL0NbxU0x1RjxNYW083OQzpGOeGsh6bFFMSu7MXh+fauLXpPZ6DbjmWOJwxeeLKZq6J0AcgJHZcmi1vv7ugkobvlL/X39urKupR8zsu3rc+LULEt763GOCumXnkte/y/wK7daaBi2rpmNeh1hgtzqwv5OlEXS3LmpqQF//tUxkwVrUbpeZ78OPcAUf7TIqtqxWjuRU494wyb47V/ozC9DzGyO2NlziQCrOHOCU615TfFrJsUkqf/IPyFPZ57+bZjo+q4SmQ3yENCSuH4y+pg1VMjE05hOA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DU0PR07MB8466.eurprd07.prod.outlook.com (2603:10a6:10:355::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Tue, 9 Jul
 2024 06:18:07 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7762.016; Tue, 9 Jul 2024
 06:18:07 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>, Minwoo Im <minwoo.im@samsung.com>
Subject: [PATCH v6 1/4] intel_iommu: fix FRCD construction macro
Thread-Topic: [PATCH v6 1/4] intel_iommu: fix FRCD construction macro
Thread-Index: AQHa0cfDyRBjQJXZs02vrGVT0F2j9A==
Date: Tue, 9 Jul 2024 06:18:07 +0000
Message-ID: <20240709061756.56347-2-clement.mathieu--drif@eviden.com>
References: <20240709061756.56347-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240709061756.56347-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DU0PR07MB8466:EE_
x-ms-office365-filtering-correlation-id: ee56422e-ddcc-4e86-4998-08dc9fdee621
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cE5XRFhsS3dZOWNwSlV4eDZLSm1ZQVBxZDNsc2pubDZCTzBBMkYybkQ5RGdm?=
 =?utf-8?B?azNMZytiTXdzckZVa2lCdUpFRmpMdGRjSTg4YytlM2QyekU1Zmp4T3k2djV3?=
 =?utf-8?B?R0tzR0NrbVdpd3N6SWhSNkxlR0VUbEVTb2lCVEVyNzd6VTVKNXlvT3Q0dVMw?=
 =?utf-8?B?NjNucnlmVy9LbWZoQ0czQ0ExNXRrLytRKzFxY0J2aXc2UTgrYndUbkRZTkZ0?=
 =?utf-8?B?UjhtaEkwaFJiYXQrTHRiZ1JKeWpwL1VrYW9SSTA3dnp0SDd2SW12Q2JDdVU1?=
 =?utf-8?B?cE9vc2R6dlJCV1NYRUtXWHBtclY2QzY3T2Q5ZDJ4WUppM0NSUUlvbTNFWklJ?=
 =?utf-8?B?c3doVFhkOUhyWnA4K2x1SlZDbjRObG9pVDMyWTBteFNZcWVPNVZwa29GSjk3?=
 =?utf-8?B?UTBXaHdNOHg0Tzd3OE9ZeHgvaEZXcG1wUFVtYWhodGNKZDVCOUR0WW1iT0lo?=
 =?utf-8?B?SUEvQmZYYzJuci93T0ZQY3JLK2dDVkNybFhvNTluS1psNUJSdnZMTlVFUUUv?=
 =?utf-8?B?bVBkR1pZUWNhZjhhWVJ4TVV0OXBOd0ZJdmp0cnRXN1ZQTkdzTmRHaWovbUpm?=
 =?utf-8?B?SGhXdE00b1diL2grK2hBMUdiVTNyNE1uYWZVM1dkeWV3Tjg0UkJTTGNGY0cr?=
 =?utf-8?B?RmV5L08wRVZuMUVqQzhTeFFPdndKYitMajJ0d0RvVjl4eDZQUm5oV21hZ2hH?=
 =?utf-8?B?dk52RFR6RW0yaUdmblNDbjVNZWdaRy9XYzc4cHY2N2lnTVA2djlHcmFUc2p4?=
 =?utf-8?B?cG5ENXRtM200TFZkb0R0Vk96eWowQ0lOaU1vOGd6cGcvVktXT0FnZmxZV0JT?=
 =?utf-8?B?RzlaQ2VxWGh5WnhDT3JPRitOYVRvSk1zVDVwVTVQY3hnOGdsd3lXL3VFNjg5?=
 =?utf-8?B?TURsUkVqZFYyd25sYXBhcWpyYmNIN1dtQTJEclJwcXFmUnQ0NnY2M2VUSkQx?=
 =?utf-8?B?U2JwZk5teExWNEZTOFJmV1J4YU5Zd2tmcHQ0a3VaWUpLWkordTBpa0VITDNt?=
 =?utf-8?B?dmppei95RmJOYkF2ajVQZFlZTFg4WnlDSWlvZHBrbkpJNk5kR0NaWmNxeExs?=
 =?utf-8?B?UG5oWnVJRkJtNkFwWUVMRHhvTHhNdXR2SHRXTEtCblp5U2tGWnpOMFNuVEFQ?=
 =?utf-8?B?VmdiYitUNjRlYVRGa1VEWVZsT0hrRkF5NE16NngyalVUV1JrVkQwVklHSGpv?=
 =?utf-8?B?RkJSTjdzMGl5ZXRCMzN2RGRCQllOME84OU9ha2lDUXp1NEtUdmJtZnRJek9F?=
 =?utf-8?B?cVFkaGhpbUw2M3dnMFNuOGtsdHovU2Nac1RyN1ExK0tJTzZkOVhYU2xNNTJR?=
 =?utf-8?B?MVVKOFBvdEQvRlRidmRadVZWQUpTODVYcWltc0daMTk4YmF5QmFDR0J4bnMz?=
 =?utf-8?B?a1hPZ2h4SXMvVzRUNC9zeDhTb09tVHZVTWlsTE5KSjJ1UUU3cUllMVhFZWdr?=
 =?utf-8?B?ODFnWE9ENU5adUg5bHJpQ3RBRVhLVkw2NndzSjlaYWZnckVIOS83emMwTjM0?=
 =?utf-8?B?NTZNU0tOKzNkeWV3aUtrRlViTjIvTmtNTmxkeFBhZGNESXRBNy90YkxJWGhn?=
 =?utf-8?B?Yi9zMitpU0VKS1QrN0JGVnI2RVcyRGh3dTMrYUNyM3IzTEF0MkRtbi9COTFO?=
 =?utf-8?B?T3piNmh3U3EybCtQZmlMMHQ0ZTVHWE1reS9iZWVoa2F5c0dUanB3MzJ0aG1y?=
 =?utf-8?B?T3llSStsMUJOTDEzbmtsR2t2cXV4Uzg4WTNwTHQvdHRzUzZGODMvTURZWkNy?=
 =?utf-8?B?ckZTOHIyL2Q3YVRLRERlM3BMR3NOTzNmTURGZGl1azBWa1ZzUzdxa2ZLZ0do?=
 =?utf-8?B?Z2pKNHFoWGkvS3VMdVNCTEtRY2YxM1RnMzBiWE5LUjhMS0lKYklhUzRidlVt?=
 =?utf-8?B?TEMzRG53bHBWeWl5aWx4bmNucXp0Snh5N3R4UUswTFFmMkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1N2TDRpaldERytYTjVQVUU2clI4VkN5ZDJVRjZ5T2Rhb2FuYlhLN3Z0TUdY?=
 =?utf-8?B?TGFPS3h2YVNNUkE1RnhxSHdlTGNxRURiMWVIZDAxUDhjVGRlME5uMjJ0ME0v?=
 =?utf-8?B?RnNxaVlzNlJBUmlPQ1lIWHZ6TzVuMGVNdWpuZHNoeEIyTHdWZlFTeDgwOWJF?=
 =?utf-8?B?Y3pXR2RjUHFOVEpmWlJ3WkNLS1hMMXhBTk1VWmhpaHBiTE9GSDZjTEIxNVZC?=
 =?utf-8?B?cXBpa05UWjhKM0N3RTBvV3MzbklKVDdmQ001MHV4MDNFdE1RdExMb2c5dHpV?=
 =?utf-8?B?T0E3OUM0OCtvTCtCUWhFNjFvWi9SYTlSMXlqQjZ2LzRUUitaYndXenFTK3pv?=
 =?utf-8?B?VUw4RnVZVHBQRHV3RVM0MXM0Q3VzM3k3QUx0S1RraEhnWWFibkN3WG53dVJC?=
 =?utf-8?B?NU0xTElVcW1MVjFjWlBEZWFRN1FFVlR0cFBYcWJsbG5lUTNEQjYyZy9KaHhX?=
 =?utf-8?B?ZHhyckNla2tEYVBWbTdVT2Naa3psTkVxNmhOaC9LYjg5ekl1VHFQNnBRZFFx?=
 =?utf-8?B?ekU4WTJYREZmSWZ2RXJlY3JlVGpRRW5Qc3Q4SG1QVDF2TnVpMTJRMVdHYWp3?=
 =?utf-8?B?MFpGRGRqWngxTkFqMGlkbExaZU1MNTA3d2UwTGxGaHoxK0RSekNKY0l6alh5?=
 =?utf-8?B?aEFYK1ZHY0Q5R1J6TEVzR0ZZNCtKSGVaYzZHOEoxdk9KcTQwVk5YQXVnOTky?=
 =?utf-8?B?U0FNMVk0Q3dZWjY4ODZHOVNtWkM0QXo1dkl5Y1pFZC8rU2ZvdDZXT28wTjF0?=
 =?utf-8?B?THlnMUNsVytMalAwZW1WdHBZMHFjN0VOaDVDU2Z6TXlpMlBFSVJweEdrcEJM?=
 =?utf-8?B?MEM2Vy9oS0ZOYUkwSVltZDVXQklvcktubkpXR3c2RktPSUhRdkpVbHQzUDhk?=
 =?utf-8?B?Y2V6YnppU3k5VmxjNmVzLzdOYmU4bTdMMFpjNVVQMXh0dVVIdnZlZ0J3MFNi?=
 =?utf-8?B?S3prMXlGQ29xRytIOVZMMlBCT2F2Zk4zaG9aakFETjdxY0xhUmxGNzhOdGxC?=
 =?utf-8?B?SWtaMmpSeXFmMzh1SWZaekp6WHg4RXpPU3VPZmFXNGdaQVRqcjhBanNxSHcz?=
 =?utf-8?B?WVM3RXEzRGpoelh6ZFdxOU1ySTRmQ3hOOFcvT0VsbzZDbjV5ZEQxbzFNdElC?=
 =?utf-8?B?MkNlNUdIZlJuUUs5dzBudS9KYmZKOGZJOU9mU21XWXVyc3A0aFNjREd0elhu?=
 =?utf-8?B?Y05BbTB3NmpVVUFTclVZQVVQM1NBM2gxSmp2dmljaHI5MFdQRTNTYmxHL2JL?=
 =?utf-8?B?YnA4M2doMW8rYTNmN0hmakZHakNCN2tqeHk0aXlWNGdnYVB1UVpWRDVXN2tR?=
 =?utf-8?B?RjV0a04rM1dQWU5iMlFEMFZ5eUYxVEJ0bmprN3c3Z3RoVWxHTFI1YkgzRzkv?=
 =?utf-8?B?MTFMRWt4dllmNURGdlYwckpVcjRURG5HdTJQMHcvaGQ1aGk3cHZ2ZUpzVVU5?=
 =?utf-8?B?aUptR2Y4WGFOYmpQeHlCKzhqWDZvUlgxSEFUVmVKUDlKbzVTZVZjMVh0VXI1?=
 =?utf-8?B?VzBIMzFkOWFmbk5rUVdqNnY5VElGSDR1OFdXMDlYcjQ2aVd0L3hyVGFIcXEw?=
 =?utf-8?B?Y3h4Vno4bDcwRys2eDN2RjI2c2RjbGFXMHhEc3RTT1FhVm5xNHJkTWQxOERi?=
 =?utf-8?B?emU2SjBPRmp6emM5QUJja1dpZ3RjbkhRS2NTcDZQVEpiVWpEQ0FlUG9NWjJp?=
 =?utf-8?B?NVZZM1pqYmNvcDZJeDJIOVh1a2tUY0tSY0FTeWhXVkJnSFlxejJKWSt4QmE1?=
 =?utf-8?B?R2EwVXlndkJKeGRkUkI3ei9XR0p4TlptaU1pWW05QVpabzNzNDErdFcyTGtu?=
 =?utf-8?B?b21aVjdPSzlrUEFjTXI2MEJzSURTT2VqTDJQL2dwakJya3FnZy8rclJ1a2wx?=
 =?utf-8?B?QnB1b1VFMnZwcDYzczMwV0tsNGY1MWhIc2hoWGQ3bkVweGZlRE9sQ0IwdWVO?=
 =?utf-8?B?di94emg5d2E2d0RMV25wYVk1UHUvaHZoaVVOYnV5Zk9Gd1dvZlcxbDgwL282?=
 =?utf-8?B?L0htRE42a3ZHMnBmL09NTW9idDBiTW9yQ0dWWUNQeDMyZ0swbjBFVmpWTEJs?=
 =?utf-8?B?YjBoWUxqaEQ0bUQ3Q0kyN3luL3M0cFFPMWEwSnNESHM3TTd2NUpJYURuRFZT?=
 =?utf-8?B?S2RrZ1hCTFVJSFRUNFh3VGNsdmI1RFFsNjVFa2UxS0JkaDdWSWMrdDdsZmZq?=
 =?utf-8?Q?UOqNY+LcAxHrFkHhieKFnAE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D968C6DF70E089489764DAE0F8343773@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee56422e-ddcc-4e86-4998-08dc9fdee621
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 06:18:07.1829 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HB9AsLjF9b9QPhovnEWOyT+8s2SOl2+w2D6X4KUPL9CTJP47Mb2xJohQoq3UpE0HtEh/rYhiAy31bznWy02Ap39hWNpPbP6ZXfPGq4bVUMxuMWtpgmKfm7CM2pDIg4BN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8466
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClRoZSBjb25zdGFudCBtdXN0IGJlIHVuc2lnbmVkLCBvdGhlcndpc2UgdGhlIHR3
bydzIGNvbXBsZW1lbnQNCm92ZXJyaWRlcyB0aGUgb3RoZXIgZmllbGRzIHdoZW4gYSBQQVNJRCBp
cyBwcmVzZW50Lg0KDQpGaXhlczogMWIyYjEyMzc2YzhhICgiaW50ZWwtaW9tbXU6IFBBU0lEIHN1
cHBvcnQiKQ0KU2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5t
YXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQpSZXZpZXdlZC1ieTogWWkgTGl1IDx5aS5sLmxpdUBp
bnRlbC5jb20+DQpSZXZpZXdlZC1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGlu
dGVsLmNvbT4NClJldmlld2VkLWJ5OiBNaW53b28gSW0gPG1pbndvby5pbUBzYW1zdW5nLmNvbT4N
Ci0tLQ0KIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8IDIgKy0NCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2h3L2kz
ODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwu
aA0KaW5kZXggZjhjZjk5YmRkZi4uY2JjNDAzMDAzMSAxMDA2NDQNCi0tLSBhL2h3L2kzODYvaW50
ZWxfaW9tbXVfaW50ZXJuYWwuaA0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5o
DQpAQCAtMjY3LDcgKzI2Nyw3IEBADQogLyogRm9yIHRoZSBsb3cgNjQtYml0IG9mIDEyOC1iaXQg
Ki8NCiAjZGVmaW5lIFZURF9GUkNEX0ZJKHZhbCkgICAgICAgICgodmFsKSAmIH4weGZmZlVMTCkN
CiAjZGVmaW5lIFZURF9GUkNEX1BWKHZhbCkgICAgICAgICgoKHZhbCkgJiAweGZmZmZVTEwpIDw8
IDQwKQ0KLSNkZWZpbmUgVlREX0ZSQ0RfUFAodmFsKSAgICAgICAgKCgodmFsKSAmIDB4MSkgPDwg
MzEpDQorI2RlZmluZSBWVERfRlJDRF9QUCh2YWwpICAgICAgICAoKCh2YWwpICYgMHgxVUxMKSA8
PCAzMSkNCiAjZGVmaW5lIFZURF9GUkNEX0lSX0lEWCh2YWwpICAgICgoKHZhbCkgJiAweGZmZmZV
TEwpIDw8IDQ4KQ0KIA0KIC8qIERNQSBSZW1hcHBpbmcgRmF1bHQgQ29uZGl0aW9ucyAqLw0KLS0g
DQoyLjQ1LjINCg==

