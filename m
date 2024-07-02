Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B482C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOWRZ-0007vV-57; Tue, 02 Jul 2024 01:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRX-0007uU-3m
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:43 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRV-0006Tu-18
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1719899561; x=1751435561;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ozTIDtEY7hjZ6/CqnUwPAuiGQBOY2pjpxiBUFYZFZZY=;
 b=lEjzlOLyXTRjZCqTWvzgcf/Q1Q3sughcSTfY11Wkx142ZZaEDgyhCmPZ
 6ply84BUNhDSusknCke3EfGRvxp6Z+ALIQBs0NFRLJB1bPLlzW7fUyzWy
 rmcbC3bKM4WY8gt9CqQKAyXUiG7KdiKSfNEtZeKng0B3s1FkW/6KW8OL5
 8INIcCZsgXmR9YuSVa/JVAiIjix45chvxMn0QcAOxDawkV8ZeBPMWVVOS
 ksj6BBI0ECbQwd0yqKLd9Xw9wL6NtpqeRmAbqvovKX4ypJxa6xcz9KNjK
 KEQhUgYWc9d9NxivbmHJFLbCyvWfzVenr3MAqUj4+9ay7xgqDYWW6iyGP Q==;
X-IronPort-AV: E=Sophos;i="6.09,178,1716242400"; d="scan'208";a="15721576"
X-MGA-submission: =?us-ascii?q?MDG18OMg4f4xBuh0nzXnnu5iU7EXHK8R6Aqa0o?=
 =?us-ascii?q?zSm+RP2I5j7bNA7s+GyP8yIxmTHdKMirYqBGX5vRGPWJJRG+mnHrJYSc?=
 =?us-ascii?q?F9R30G1iDMFSYY3R/3H+gnTqzizdertzzZ7Yynp8+g2Trm2g9Si8i8jz?=
 =?us-ascii?q?sZQgdbjcOnSZLieVydlAkqFw=3D=3D?=
Received: from mail-am6eur05lp2108.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.108])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 07:52:34 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxHh4J0tB2zi1ormagUMPrLxN7szkgsrJeYQ3Q3dKjsNsVGVZdvbYb657V7SixMSDfwf8lKc9sh0ci8bRmvM03ktpJZTw9QMqNQYxhiaMqkal17xxdq16mivXYndGl17olxzTJ8RrHjT0v/vWiWeQMhPp2JS3n2YClSGwtSNFoGpFk2SfBKN7UkOXp3m145XIX7X8Gy9X5c+hw+172H09PrTxf5YdbLyyXx9fRQosjhMIoUbcSYzNnaRoD06QBiGtwUS0VzX+4zGR2R0n6NVgYJ0/TR+CAokPLYuoT8YGX+AJwHtiSxCcHacvCGwCMrG+YPkK4wnownf2B0xXvVmig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozTIDtEY7hjZ6/CqnUwPAuiGQBOY2pjpxiBUFYZFZZY=;
 b=gPoRgIaZtt/j1/eZ93bW0OkG86ty4CBRqRKHKHeXImX4PGMemQuDQLuJsljkUgGQpAXmxOmwKU4/XNXL9nTAoayk2je0+vF/1aCei+k8sYIj5NuLVelvSu5CprCMwd+K5EAG+juD5+7l4Me6SYEXT3MNFQkpiz4IGbqYEmW5ckXwGLlvUC2m0OeVBj3L7AlYx7EppmhBUfB512Zjk4AQZ0ZwXw1fJZVXCegIZTTxwX8VYP8jOzUvjEjiqr9GQi24gWt9d7AsermFJHNSV1u1HdAaj+zwdMdTMKJSSOfYf/tdpm1uE2WgHuHfXoyqBo8zPSGEKZ9a0Gn7pOUTRID6SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozTIDtEY7hjZ6/CqnUwPAuiGQBOY2pjpxiBUFYZFZZY=;
 b=jkV90/WAZOawAaJp7P7PxHF9fJZGIPVgqrWdLC1JzcAtLAd1J0Gl10h4gOhkZJ/mw/fMrQjm/6jITK4KbuAQIrG1dCLgK47p1DUc6++0VTONtKNvOM4a9+JUyewK0+TRI3JJPS2/6UVIUID/2hZzzfFpfxzlHFA0Gseti6oYhwo0t0DRUSVL8JSomevMECO7s+kBtUujnTG2bZAez+Y9CxD8/E3UIEeHC9LRhluflNzW++Y8xYkjW+3DLqSZl1VSI56FJbzxJ0A/Wwyf0iTYjUOpfoTxSYc04s6+iymUdM2dZ3RCebIyzF3ZqUS5pFvV/pXzFWFoI46lkEcY9unKbA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7080.eurprd07.prod.outlook.com (2603:10a6:20b:239::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.21; Tue, 2 Jul
 2024 05:52:33 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 05:52:33 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 03/22] intel_iommu: return page walk level even
 when the translation fails
Thread-Topic: [PATCH ats_vtd v5 03/22] intel_iommu: return page walk level
 even when the translation fails
Thread-Index: AQHazEQIX64drBolXUuuM+UyOsesIA==
Date: Tue, 2 Jul 2024 05:52:33 +0000
Message-ID: <20240702055221.1337035-4-clement.mathieu--drif@eviden.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7080:EE_
x-ms-office365-filtering-correlation-id: 6740b182-17a7-441c-f0db-08dc9a5b2afc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QlNtSExRS3E1NlVCMVRIb1RuKzRSV0RIZnBvTFRCSTZHRVpKUnd4c1NqOWpB?=
 =?utf-8?B?UnRDSkUxSGtrOFNTUjY5RVRMUE93eU54aEJxd1R1QjU5WFc2ejNXQVJNYWNH?=
 =?utf-8?B?emFETWcway9XRmhLKzcyRVVkL0RuUFRGK2Q3T0NpNHN5MzJidmRhTmh3cm4v?=
 =?utf-8?B?Q1BhTHZDams0N3dxQjk5OGtob0Z2Z3dMNHFsMDZiNGdoRk9uWGtGR1ZyNlph?=
 =?utf-8?B?V09ENjBkSC9hRW5ZN2Z6OFNVSUUvZlhTWDd6d2JxWndObUdhWDEwUGprLzdo?=
 =?utf-8?B?VFVoSm5HRkhGL2JLelgxZG1scGp4R2R3RmtmQ0pndndsTDg2MGJFbnEvNlpk?=
 =?utf-8?B?Z2IyOXJKdEUvUE5iMk5jRFE1R0JTRFFFNjdYY2o4QUJocEVZcjdyOERKaVNs?=
 =?utf-8?B?T082QXZwSUdaQTJGZGUyODJ6eFp2NHN1dnpMU2ZET3QzMlA3L01Db2xrYWZR?=
 =?utf-8?B?dHplNW42MmljOUVsVmRVVldaUXRrOUxOVkNSNWJwOG9YTjZlSGhnSWpBRWVs?=
 =?utf-8?B?T1dxbnhNYW9qUklrcEpMWVFFcFVHbUs2S1YzTEhYU250aG9DZEcvOGJzRFVo?=
 =?utf-8?B?cEJ2SGQ0N2wwT2hQajYzMmpmYVpNNkhGS0l5RzFBMFA1c29LTG9BOXFtdmo0?=
 =?utf-8?B?cFRzZHUvSmk1T05Sb3BVRENsVGtoR3hTNUI5cHZmUWs4R3pQVzhaaU11UEk1?=
 =?utf-8?B?NTVISVFVTlFrTFhZNkY5NTRuSkxTZnFLa0xtc0dDYlhDUFJ6NHczZjRvWnl2?=
 =?utf-8?B?M1VOZlVjZi9lY1pRamNORC9USW0rU1VVRWdTNzN6WncrYzV6eEdoaUxCRm94?=
 =?utf-8?B?MWxFbUN5eTVtbHJCaW10clhpQlVVTjEwVTJnNE9vcms5MnlEUXRWeU52UGVt?=
 =?utf-8?B?YUhTSGdiU0dEQ1ZRL0ZjcHRYOGhZWEhFWG5BY3Z4cXRUYWpXNTRpQmEvR2l3?=
 =?utf-8?B?NXpicm9UMUdFK1ROMEIyeUxEMGxnUEl3OHJhb0xkM3IyektyMzlOYlp3dWJM?=
 =?utf-8?B?OXArd09FS1dFamVUbkFFcExjdm5XNUllNTJCU2RaZ1BaZ2FtY3JYZTJLS2pj?=
 =?utf-8?B?MDUyOW1jcTVib1UzQVFvbmovNlBRVW1TcDgrb21PbDZXVzlWenZMMHVJTXhQ?=
 =?utf-8?B?cytHSE16NWwxaWRqQUUzaGRLSWlVZ2ZoR0ptdkx5OC9aOFZscHROWE1jQkFi?=
 =?utf-8?B?WEhyNktTVFZKamtSME1PcTFYbW9iV1phYndGZVhsOW92bHdWS0UrQkhkSnNQ?=
 =?utf-8?B?TmtYM0pXWllQeFFsTU1WdVYzMjNTWThMaWs5VWNLanY1ZzBkUndvWFkxNkxl?=
 =?utf-8?B?U1FJYSt3eklFVDVjMlNoSzBEaDF6emJSZ0dJbi90ajZFNjEyeXNSNVZpbitm?=
 =?utf-8?B?TkUyZlpWTXZIWW13ejR4ZVlQWFYxcDIwV01pdzhoVE9tT0dWbkNkbTZVcndN?=
 =?utf-8?B?MHJab3NXZ3F4N2Jya1FXcFJhMWU4U0dEZTlWSGtLZ0dvdU5IODc3TXNZdDJs?=
 =?utf-8?B?OC9VMHFERU1WZUZySnBJNkEyZERDN2FHOG9vS0h3ZnUwc2ltVjZJK0lEdTVC?=
 =?utf-8?B?YzF0MzJxK0VUN2NQODBCS3ZEN0JYTlMzRENNSzVHQy8rcmU2ZGp3NzlncWU1?=
 =?utf-8?B?blYyRUd0TmxrejFtRHZkbFZGWUFVTU9RYWFyL0hNTllFN0hKUStPajBqdDFv?=
 =?utf-8?B?alZmZE54ZUl4Slk0cG1QTmtCakE0U2t3ZXJXR1E0Y25jc1NZcFZIVlQyUVZT?=
 =?utf-8?B?c00wRUFldWlnNHk5Mm9FSUc2N0YzRDJJcFZ6UTNtb2xXaWhzL1FneVhNMVRD?=
 =?utf-8?B?VEdNUnpLZGJVcVVvZThHVDkyWHNaRGYwS1JqUjRKSXBsOUhhUDBZTmNmSHFt?=
 =?utf-8?B?Z3dVWmlFMHpKU29ZVFJVMkV4YzhvYXcrU01CNkhXNG5YVGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3JtOXh1aGxjSXJwQjRDVnVtRWU2eHk3TU50NU1TUmJJTVJKbUZINmdvRTBO?=
 =?utf-8?B?emxmQ1pSY3NBUjhBR1hVN0NqTzUvN2VwdmJ1cVhRcjd0TGVJWEl1SEFqUndT?=
 =?utf-8?B?TytLbUJnTXlrOStxVHF2c29YZ0RyMU8rU1FHUEE0akpjVTRnYkVFemQrMDkx?=
 =?utf-8?B?SWI0VWgxUjVZa0g0am1qN3d4dHlGbFV1cE9md1hXTEVTVm1PZ2JVU2ZaNnQ5?=
 =?utf-8?B?elpEc0R0VzZOcFN0Nm42dG9tM2NtSjBzVE5qL2MwalZ6U1ZuWWdnTGxJVWVG?=
 =?utf-8?B?VGFFUWNpZ25oT1pOQW9HbVFLOTdtaWZlazBRVmdzTHErZmxFcWxlMFVHQ1NQ?=
 =?utf-8?B?OGErcUZEVXBaV3dQYVZnYVFvMTlTMXNUR1FCRWkvOVpZbGoxR0haNk1qVlVH?=
 =?utf-8?B?ZzF2VWkzUU1jS0hyZWZYRUQ5VEFoak52TVJ4enV1U05zRkU0d3RsVzdvcDhu?=
 =?utf-8?B?WUIxdXc1eXF5SjcxdjZDNVFRRGpTVEUvNzI5S0FzZVNEOFFjQk45UjlHaVNz?=
 =?utf-8?B?OUhBMTAyMEdaeEZrWC9LZHRQcjQ4ZWp5eWM3ZlZsdVJhaXZGYkV0QTJ3dEtE?=
 =?utf-8?B?citkTnZCVkVIWHdiQzFEYTkvdVNNb0luRStWTnp2anhhS2ZvRkJCNDJrZGJ1?=
 =?utf-8?B?bitJa29SWTQzc1k5bm1vOW95Zm1TYUJjYXc4S3pzY25OZXZOZ1BEaU1LZDBx?=
 =?utf-8?B?NlI3OFQ4a2xVU09pL2xqV1JmL2VoUzJ2dHpGT0tzeWZHcUQ3V2wyR2VRbzU2?=
 =?utf-8?B?ejJhUjQ3L3BJUXVoSDc1RnRuS0RsZnh3bllMVzVXNGI5UTlSY2VHbTRSWFow?=
 =?utf-8?B?bmQySEdIMGt5T0h2TG9QeklxVWtZbzdTNzQrVjBmcnFLOEQ4T1luVDBSU1Vp?=
 =?utf-8?B?S1pGZ0VTNDhTSmVWZjNLSW1NdVVBbEhMdWtxWkNGR2dHRFlLdTlvdFF5QS9a?=
 =?utf-8?B?a3NBakNneTcweHBPN0dRZ2N5MnVMVmVqdzFLZDk2NmVnV2xzK09vNk5ZTGZU?=
 =?utf-8?B?RG1zWU5WcFJpaWMwREc0T0tDUFhiUlhGaTdDOUZzR0t2NVZSSHlqWDA4dkQw?=
 =?utf-8?B?MFJzbVgvdTBLbW1IQy80c0lLYWZmVnhjbCtGN3dIY0U2d25TTkdwQmFDamxJ?=
 =?utf-8?B?SE5YQU0yOVZJd053VVlGa2hZRFRYcEo0N3ZOcXpGamFzMTBGVXYrWTdFS0Z0?=
 =?utf-8?B?dzBacHlETUhjVU9FYUlTWDJPVXBQakVSdTIvZGtteUhYVTBHd2VmblN3MWNr?=
 =?utf-8?B?VWs1a0JGeHFEL2ZneWdkcU9aZTZQdmExT0dyTmxwZnYwOVd0ZWVXVHpUN1Fa?=
 =?utf-8?B?VkMxVjlxak5CdTlqUlRsYUFvWDRzYk8rcTZWa3VqTm1sQ0tJMmlRWEhnYlAx?=
 =?utf-8?B?OTFDTFE5QXQ4Y2lFMnBlK1BSVFJvNGJrcTVSczJ4QUR3MlNxSGRxNDRsWnVB?=
 =?utf-8?B?c3pwUVlDQngxdnJRZGZ4SittVzVNSjZ3dTcweDVKWUdmMm52NzRKWkJ3STln?=
 =?utf-8?B?VkgyRHkwSXhYVGV3a0ZDRG5SWHYvQlg3MmxvaTVJUTRtTXNSOElDQ0RXTEQy?=
 =?utf-8?B?ZHE4WnpsVHdWN1hTZXJGWDBXS1JFN0pYZFZsTHNnaVYrc2d3ek84S0VNam9l?=
 =?utf-8?B?ejBVdm9jQmNNSjM5RTZZM2FPSUZCazVKNDZNUXVQSnNjYlIwVVZyZHJSWklN?=
 =?utf-8?B?eFFEZnoxRGpldzRuWnl6Qm5BNEM4c2FzNFUyNEJyTWw5L3VWUmgzTyt4VE9I?=
 =?utf-8?B?MExVWkx0akZvaDh3N2VVTnlnbWxNTnhWTUZuQjlpUHFsa3IyVTZ5M0RlT1V6?=
 =?utf-8?B?aHR0cjBvMGkxRUhQTDZPQ2hVenFmaG9wVWVBNHJoWjQzMWpsTGtvNmQ3SWY1?=
 =?utf-8?B?UWlBQ2dkZHFYRUQ2VnNGZ1JOak5IVm9xZnZ2NHhzSW1YMit4eGdqaHVqNjRr?=
 =?utf-8?B?WTZZTlRtSFFzL2YwKzdsY1RqSlZPRUtLckZ3ZjFnNys3amhQYWZ4TDZDU256?=
 =?utf-8?B?eXFKVEtLVVh1ZXZwRVBScVVMKzdGWWlrZkZFRFpVemVaWTR2VW10azdpRis3?=
 =?utf-8?B?Vk9BYkxsek1MdHBnNVVNZi9sbW5LVmoxVGFOeEJ0S1VKYlY3eXJ3NldTbi9h?=
 =?utf-8?B?eEZiaHFYNEtTQ285MFNOUk1ockY2aXhtMndJa0d5VS9hRTB5aUlvcVlaQ1Iv?=
 =?utf-8?Q?ZeZWtK3NqqCYPRDm0+f4fjM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F03BB60A4371545BB01E4B3D59AD471@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6740b182-17a7-441c-f0db-08dc9a5b2afc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 05:52:33.3587 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JSY0UtuwjBJn4CRdGuoldqUw85aqyFoNJQSqE4vnpFRp1Bxx02utsUO5LO8bXyd0LQSQUAzboqM1A5ct+83+PPcCRybfdBY7Zz+xAYtyJv7+QJX4tDeTh0OX/VXxZnLn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7080
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
bi5jb20+DQoNCldlIHVzZSB0aGlzIGluZm9ybWF0aW9uIGluIHZ0ZF9kb19pb21tdV90cmFuc2xh
dGUgdG8gcG9wdWxhdGUgdGhlDQpJT01NVVRMQkVudHJ5IGFuZCBpbmRpY2F0ZSB0aGUgY29ycmVj
dCBwYWdlIG1hc2suIFRoaXMgcHJldmVudHMgQVRTDQpkZXZpY2VzIGZyb20gc2VuZGluZyBtYW55
IHVzZWxlc3MgdHJhbnNsYXRpb24gcmVxdWVzdHMgd2hlbiBhIG1lZ2FwYWdlDQpvciBnaWdhcGFn
ZSBpb3ZhIGlzIG5vdCBtYXBwZWQgdG8gYSBwaHlzaWNhbCBhZGRyZXNzLg0KDQpTaWduZWQtb2Zm
LWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVu
LmNvbT4NCi0tLQ0KIGh3L2kzODYvaW50ZWxfaW9tbXUuYyB8IDE1ICsrKysrKystLS0tLS0tLQ0K
IDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQoNCmRpZmYg
LS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCmlu
ZGV4IGM2NDc0YWU3MzUuLjk4OTk2ZWRlZGMgMTAwNjQ0DQotLS0gYS9ody9pMzg2L2ludGVsX2lv
bW11LmMNCisrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KQEAgLTIwOTYsOSArMjA5Niw5IEBA
IHN0YXRpYyBpbnQgdnRkX2lvdmFfdG9fZmxwdGUoSW50ZWxJT01NVVN0YXRlICpzLCBWVERDb250
ZXh0RW50cnkgKmNlLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgcGFz
aWQpDQogew0KICAgICBkbWFfYWRkcl90IGFkZHIgPSB2dGRfZ2V0X2lvdmFfcGd0YmxfYmFzZShz
LCBjZSwgcGFzaWQpOw0KLSAgICB1aW50MzJfdCBsZXZlbCA9IHZ0ZF9nZXRfaW92YV9sZXZlbChz
LCBjZSwgcGFzaWQpOw0KICAgICB1aW50MzJfdCBvZmZzZXQ7DQogICAgIHVpbnQ2NF90IGZscHRl
Ow0KKyAgICAqZmxwdGVfbGV2ZWwgPSB2dGRfZ2V0X2lvdmFfbGV2ZWwocywgY2UsIHBhc2lkKTsN
CiANCiAgICAgaWYgKCF2dGRfaW92YV9mbF9jaGVja19jYW5vbmljYWwocywgaW92YSwgY2UsIHBh
c2lkKSkgew0KICAgICAgICAgZXJyb3JfcmVwb3J0X29uY2UoIiVzOiBkZXRlY3RlZCBub24gY2Fu
b25pY2FsIElPVkEgKGlvdmE9MHglIiBQUkl4NjQgIiwiDQpAQCAtMjEwNywxMSArMjEwNywxMSBA
QCBzdGF0aWMgaW50IHZ0ZF9pb3ZhX3RvX2ZscHRlKEludGVsSU9NTVVTdGF0ZSAqcywgVlREQ29u
dGV4dEVudHJ5ICpjZSwNCiAgICAgfQ0KIA0KICAgICB3aGlsZSAodHJ1ZSkgew0KLSAgICAgICAg
b2Zmc2V0ID0gdnRkX2lvdmFfbGV2ZWxfb2Zmc2V0KGlvdmEsIGxldmVsKTsNCisgICAgICAgIG9m
ZnNldCA9IHZ0ZF9pb3ZhX2xldmVsX29mZnNldChpb3ZhLCAqZmxwdGVfbGV2ZWwpOw0KICAgICAg
ICAgZmxwdGUgPSB2dGRfZ2V0X3B0ZShhZGRyLCBvZmZzZXQpOw0KIA0KICAgICAgICAgaWYgKGZs
cHRlID09ICh1aW50NjRfdCktMSkgew0KLSAgICAgICAgICAgIGlmIChsZXZlbCA9PSB2dGRfZ2V0
X2lvdmFfbGV2ZWwocywgY2UsIHBhc2lkKSkgew0KKyAgICAgICAgICAgIGlmICgqZmxwdGVfbGV2
ZWwgPT0gdnRkX2dldF9pb3ZhX2xldmVsKHMsIGNlLCBwYXNpZCkpIHsNCiAgICAgICAgICAgICAg
ICAgLyogSW52YWxpZCBwcm9ncmFtbWluZyBvZiBjb250ZXh0LWVudHJ5ICovDQogICAgICAgICAg
ICAgICAgIHJldHVybiAtVlREX0ZSX0NPTlRFWFRfRU5UUllfSU5WOw0KICAgICAgICAgICAgIH0g
ZWxzZSB7DQpAQCAtMjEyOCwxMSArMjEyOCwxMSBAQCBzdGF0aWMgaW50IHZ0ZF9pb3ZhX3RvX2Zs
cHRlKEludGVsSU9NTVVTdGF0ZSAqcywgVlREQ29udGV4dEVudHJ5ICpjZSwNCiAgICAgICAgIGlm
IChpc193cml0ZSAmJiAhKGZscHRlICYgVlREX0ZMX1JXX01BU0spKSB7DQogICAgICAgICAgICAg
cmV0dXJuIC1WVERfRlJfV1JJVEU7DQogICAgICAgICB9DQotICAgICAgICBpZiAodnRkX2ZscHRl
X25vbnplcm9fcnN2ZChmbHB0ZSwgbGV2ZWwpKSB7DQorICAgICAgICBpZiAodnRkX2ZscHRlX25v
bnplcm9fcnN2ZChmbHB0ZSwgKmZscHRlX2xldmVsKSkgew0KICAgICAgICAgICAgIGVycm9yX3Jl
cG9ydF9vbmNlKCIlczogZGV0ZWN0ZWQgZmxwdGUgcmVzZXJ2ZWQgbm9uLXplcm8gIg0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICJpb3ZhPTB4JSIgUFJJeDY0ICIsIGxldmVsPTB4JSIg
UFJJeDMyDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImZscHRlPTB4JSIgUFJJeDY0
ICIsIHBhc2lkPTB4JSIgUFJJWDMyICIpIiwNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBfX2Z1bmNfXywgaW92YSwgbGV2ZWwsIGZscHRlLCBwYXNpZCk7DQorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgX19mdW5jX18sIGlvdmEsICpmbHB0ZV9sZXZlbCwgZmxwdGUsIHBhc2lk
KTsNCiAgICAgICAgICAgICByZXR1cm4gLVZURF9GUl9QQUdJTkdfRU5UUllfUlNWRDsNCiAgICAg
ICAgIH0NCiANCkBAIC0yMTQwLDE5ICsyMTQwLDE4IEBAIHN0YXRpYyBpbnQgdnRkX2lvdmFfdG9f
ZmxwdGUoSW50ZWxJT01NVVN0YXRlICpzLCBWVERDb250ZXh0RW50cnkgKmNlLA0KICAgICAgICAg
ICAgIHJldHVybiAtVlREX0ZSX0ZTX0JJVF9VUERBVEVfRkFJTEVEOw0KICAgICAgICAgfQ0KIA0K
LSAgICAgICAgaWYgKHZ0ZF9pc19sYXN0X3B0ZShmbHB0ZSwgbGV2ZWwpKSB7DQorICAgICAgICBp
ZiAodnRkX2lzX2xhc3RfcHRlKGZscHRlLCAqZmxwdGVfbGV2ZWwpKSB7DQogICAgICAgICAgICAg
aWYgKGlzX3dyaXRlICYmDQogICAgICAgICAgICAgICAgICh2dGRfc2V0X2ZsYWdfaW5fcHRlKGFk
ZHIsIG9mZnNldCwgZmxwdGUsIFZURF9GTF9EKSAhPQ0KICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTUVNVFhfT0spKSB7
DQogICAgICAgICAgICAgICAgICAgICByZXR1cm4gLVZURF9GUl9GU19CSVRfVVBEQVRFX0ZBSUxF
RDsNCiAgICAgICAgICAgICB9DQogICAgICAgICAgICAgKmZscHRlcCA9IGZscHRlOw0KLSAgICAg
ICAgICAgICpmbHB0ZV9sZXZlbCA9IGxldmVsOw0KICAgICAgICAgICAgIHJldHVybiAwOw0KICAg
ICAgICAgfQ0KIA0KICAgICAgICAgYWRkciA9IHZ0ZF9nZXRfcHRlX2FkZHIoZmxwdGUsIGF3X2Jp
dHMpOw0KLSAgICAgICAgbGV2ZWwtLTsNCisgICAgICAgICgqZmxwdGVfbGV2ZWwpLS07DQogICAg
IH0NCiB9DQogDQotLSANCjIuNDUuMg==

