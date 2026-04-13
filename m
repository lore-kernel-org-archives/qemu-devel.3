Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1CEEBFD10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 07:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCByo-0005Yt-Ta; Mon, 13 Apr 2026 03:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wCByg-0005YT-UP
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 03:45:02 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wCByd-0008Hr-NC
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 03:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776066300; x=1807602300;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ckqTEPHqZQIE5d9HpYrOOFUwdXDRA3JDxgSnNWftiUo=;
 b=GzG6GII+7+/tsclIwzQGT6DjOGNp82j4hzYXFy4ew1g4sttG11bv9To8
 L5GjipUpF+IDzTPsZva0qHiOwbfCC+I4ix1C0gEpXlWcV/rU7ch+RVXUP
 UU4Z2LzhLp4nz2+tsxFz3CfNLG39+6l5tS57dc25F96/IdeNqBu3bkotk
 JM+bb4H+zGnUGfwrlN4kkg0dqZcrcphYNzPMO0iEEJW355SB4LV7XImOk
 wN7SMI3TzWWGxGDVSTWVm3ZtpqtJlZE6ETrfBZJZSnS/WmoGdrsviw1s8
 FyNWh7oPcyZBU/X6il4XQ462d46Hu+xEaTtkpKKwZklBjtDcm0KoK9gwG w==;
X-CSE-ConnectionGUID: a/FrS6HZTLeyNuThDbi/bA==
X-CSE-MsgGUID: cdBuSl3AS2abSa00rOJx8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="77111326"
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; d="scan'208";a="77111326"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2026 00:44:56 -0700
X-CSE-ConnectionGUID: zFkQFRmJQmS1RkOAtd80iQ==
X-CSE-MsgGUID: +tsE74vUQAq9WB3xfmny0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; d="scan'208";a="225434559"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2026 00:44:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 00:44:54 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 13 Apr 2026 00:44:54 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.32)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 00:44:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STI4UBJ8rpupIubajdb9UtB2U5AYFWcV903X98u2Y9chIr/4+2YDTB2ZVXkXCjJb2JADmnyQhS+R8xmkh+ew2pZ5LVmKgtm4G942+Qq5waxTgrbIEJWJI5LWelSTc7vTJHCuOM45yaV/ZlXhrq7HOG80Vomm/r4Ua/iTFLtjWd+BGQ79V3oyVVY1jR2gedy34I3L6Y2CPHvyTncih4IqOBA+4klcwsVQ+t7DBeODEYqZHcPcQ0tD8Rf/GUZYbXM9k5RFkg7yMm8BpyMwOseR2/gRnFldndxifQ2E4eW2DlrXAuvFZejD8kPYlKfkKivsnit6PDxZrqx2zc5WozcYzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckqTEPHqZQIE5d9HpYrOOFUwdXDRA3JDxgSnNWftiUo=;
 b=P9uryPUVRS5GQk65IGAOSeB3Kd98NAL67cYL2nuSXRaqFg05WwG0zmXE4uhnqgEPl9wQJYvmsu2swmWD9hVTwmJ4gygvTLfEaY3R1ZvCugS8TL3ft0/UczwPu4SsDalcGz0s9E0zyYwy4Y63cOmcnH652DENP0ndpw5fC+Oz/A+767XO/KsHuK0zibcu5ICd0hLqJZJXqLqZD14JUbeIeKmfMq+fnGEDmJIvF0WNIQBYgTvDSXlBYdBfJA2DPao3NBQlHGk05jBzrMHQsdHWb51iDcI/gc1eD/TH+Z3onrXVyzWHNer2R+kmcgFYPucxHiNS50JBlKsTght1YdiWYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH7PR11MB8552.namprd11.prod.outlook.com (2603:10b6:510:2fe::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.45; Mon, 13 Apr
 2026 07:44:52 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9769.011; Mon, 13 Apr 2026
 07:44:52 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: RE: [PATCH v3 07/14] intel_iommu: Use IOMMU_NO_PASID and delete
 PASID_0
Thread-Topic: [PATCH v3 07/14] intel_iommu: Use IOMMU_NO_PASID and delete
 PASID_0
Thread-Index: AQHcwx3XpF37AMW/tUWEni2aXnED6bXciNyAgAAMJsCAABEB0A==
Date: Mon, 13 Apr 2026 07:44:52 +0000
Message-ID: <IA3PR11MB9136D85693ADE8F64988219292242@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260403035541.18355-1-zhenzhong.duan@intel.com>
 <20260403035541.18355-8-zhenzhong.duan@intel.com>
 <ed6326ee98963e263a9bb90d7351c85c4b34562c.camel@bull.com>
 <IA3PR11MB913682E6FB02317659E980C192242@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB913682E6FB02317659E980C192242@IA3PR11MB9136.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH7PR11MB8552:EE_
x-ms-office365-filtering-correlation-id: 48e7d132-192d-41fb-3dbe-08de99308c1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: GS1Wq2maI4lpspDkAWGPt6QzwWm71ByQvvaQ669TI/0867+wPZibZPx8jkMtJNsH1UPplieGridFaHwOrpFEb4/wBpyZDfrJgOImjL/4TCOTefoKo4grkd9oNATM9GPtCvNEbZX2lOcG1s4V8Y8YaFQELQotM+BkmbL1LxnDb6hkF1ZR71ct4YgH/d8uiN29+0kmAuobdP5ITXjD2z4lkuA2bv+ow6+4/VtuALvUGoBYbAHPxAnuGjkRY+q5MgbT5zUXtP4Vh1nBlidtF3148fwZC9qh1nNej19/3XlO/a03iwzsiRGqYpaMMP16HbRDTPIwh74dufpp3dqOXHyfGaWdXZQ43dei+WYJJ5VX3cBY72N4GihZJQZWrHa+JuuV7tt4HMu2r6TCKcLyxoDVjatcByqDQYKRL77j7cwXR/abTTOh/Vpb8NzcYZHRUPQufQhX+B7rGSIxghT9Xam5/Xj0sYNCkc1b0HGnvgkTvuH00FZajeHprDlLWuqqYUJOEkMkY7I8y5Tl5DModJJK2ZLHUW1IH1+Z69m0Rb8PikYe4+EwQSkLWAWggETGfP24qXB2XVIpzPuFPVviBJ64xPeITtSmK2ytHzD1ym/6sDYOjZOsf7Ty4Y+9OuWgq1i0NakOR+eZqwOPLU4dRX8YYu5YeqtX1Coa2oMRb2lag4p5qz7/Q5TcDgEkG8RhCw4OhVebAY2UCs32vwgR81LVBmHQNpDfB98h3k4oxoatsBf7Aglw6/adZk2dCb5zgOai1KlTkFqbexYnGac27aVXt9DcynJbTyjgO5hqW+Cxxgg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXZoNm5ZcmtRS1JlL0I2Zk9Ma3k4TndKNXMyaURNYkFwUldzSU9zU0NJc0gy?=
 =?utf-8?B?bzhQVS8rWTFYZTJPbWpIZC94UnZXUnBzUTlQSC9TdFVMc1lQd1lDMXdiSE1P?=
 =?utf-8?B?NHAzV1VTTzJiWmZmQ0JZN1UrWmtQNWhHT0pFb2c0VTVPUHV4aklVbnhFbllU?=
 =?utf-8?B?ek10emhJWXhKL3RXUnZwT2lIaHFqU0RIQ0huT0Q3TWNzR2REQ2Vnc0V2bk9D?=
 =?utf-8?B?czNTekErSUE4dSsrbHV6b0tTRkVMWm8vcjc4bk9ua0Y0L1FYcnVFNjQwZGd3?=
 =?utf-8?B?Y3NMd2lqaE1DejhCdHI5UE1FSEF3UFZtVEFNUkdKS0MyMEdRalN1TWdKTXIy?=
 =?utf-8?B?Sm9ZRU9HalZablZRcjdjT25NMVVYNGI5dEV2T2llUlAycmREVUYxS1MvV01m?=
 =?utf-8?B?emJXNnBXUXhYRk5naFNyNElDWXN4NzhzWGhDT3JJUVMvSFJWMzhRTDVUMXVa?=
 =?utf-8?B?TGh4VGVVbG1acDdwbVU2NHZZRWppMlJSUzhlRGlQRmdpZnlzSkFOMkdVYStF?=
 =?utf-8?B?eDhJOGYyOTRmdW1pRWowWjRNMng4ZkpjZkRHazZ0YUNCN0Zja2kvU1QrYWJi?=
 =?utf-8?B?c2lUQSsxWjl3ODh6QngvZk9FK2lqazh6cGxNaDRXYjFLTHo4c0lmeElocXlT?=
 =?utf-8?B?QXZnN3hKK1p1ZXErRHhPNWZQNHlXc1R3b0pnR0RBS29lWGtNVEVKeW5iV1dW?=
 =?utf-8?B?VytWTWxUVG94a3d1a0NUT1NWQ2FqYzA0cURidzNEM3BlMHNKWjZWemJ6ekRX?=
 =?utf-8?B?VW1NcmNmd1BXUUo1YjRjUFhtUHRpR3RCMmZocXBNRW5MT3lpRHRydlFRRlht?=
 =?utf-8?B?d1ZOUDdESXFCUk5QZzZSMVBncVhUWmppdGZaOGlhR0E4YTVwZWRYam9iMytW?=
 =?utf-8?B?Z1VtSkk2U2tmdDZpMWNRL1ZaLzZsZ3JBWnRGcW9zaWRhTEJzTWIxZ1Y0eS9k?=
 =?utf-8?B?bHBWeEpLMkNabUZVb0V0ZEhGQ052Si80WFphS00veG9mU3oxczh5T1hCZHZ0?=
 =?utf-8?B?eXdFdGhsZW00OXJzeVNyLzM0Ti9oNDNHSHNUZ3g5NnZDQ1kxSDdqR3VCcGx1?=
 =?utf-8?B?MjM1cjVyeXVFN0w3VmNIWUFNc2VFOTBUZ2xqMFVMSVlNQW5hcGFpL3Q4ZU5k?=
 =?utf-8?B?WGNmMTdNcURRR3dRWmJic2JldXZLQXFUSndQY2REZ1p2bEEwRFp3TkxvVGN3?=
 =?utf-8?B?RGVDeThyUFl0aEsybWdnRzVHQWN2N1pOZDJJV29YSDQ4cVMzdGJ6UWF2N1lC?=
 =?utf-8?B?azU4MDZhU2Q2aUVSWVBNdklsYlZBQzBDWjhSSkpMcSt3WW42aGk1QjFzUWw5?=
 =?utf-8?B?MnZzQm9HVDNHQnNtZ0tKZWVKTWNSRFM0L0M1YUtCUE9PT3ZoUnNaQ2N5OHds?=
 =?utf-8?B?eEFMblcxbFlMNTRHRkdBZU1teWZvL0w5bGFLTFNmZ0lwQXJmRk54VzZvT29L?=
 =?utf-8?B?VGJQa2UyMVg3STBBNm1FUit6MWpJRTlRSHBPUlUvcUQrVmNNb1pFRjl3UWFO?=
 =?utf-8?B?RTFLd05ZQ01ZZmVoNmtoOUQ3RkxoSis3d1Y3V2tsK0pUYWYzdVE2WmswcWFI?=
 =?utf-8?B?dVROUlozczQ0RzczckplYTIwOHlycXRZS0VyT1VadUpSeGNlbjhYRDgwdlBs?=
 =?utf-8?B?MUJLdW0zWVk4L0tnMjBhbzJPcUxpMnQwU0Y4cHdtc0Jva1JrNXhpaTdqMEs0?=
 =?utf-8?B?UUluWk55R0FTU1A5M25PSUJ6YldYQW8rc1hHUk9adndMYUZNc0N1TmRIM0xF?=
 =?utf-8?B?SElwU21UbXQ2SS9FS0JrMnhRSXZDUTV1UW9QOFhUbGtLZFRMbC9CeGJYWTNI?=
 =?utf-8?B?SmJEQVg3QmVsNW56dVA4bEtkNllDOVB0UnZhcmdLOTJ4ZGh4VERsY2RMZDVo?=
 =?utf-8?B?RHJLM0xLQ0NxS0Z5eFh6NFBmTVUrNXNmZHZiaDkvU05SZGNhUUR6RE9TZ1NL?=
 =?utf-8?B?WlJ1azliL1VFY05tV1JwRTBDeVREblcveHc3NGw4cXh6T2JoQ0ZhZUEwbnZ4?=
 =?utf-8?B?RWMxUFpVc2o2ZXc1RjI0dEJVblMyeG9hc0JXVjRla2l2Zkg3clJBOUk2VXh6?=
 =?utf-8?B?N3owMGRuTExpdTNPQW5oWXU5N1JLa3hsTFY2cEgvbStRNURTNWtzVFBIYXhn?=
 =?utf-8?B?b2hjSGRIc2ExTjY3UVZTNDBNYWx0eE1jOXhpVnlUbWs0T1cxUXRxbEtNdHZy?=
 =?utf-8?B?WHJlbDc4U01MRnBtcGFyTEs1S0d1RjRLQkRSWTJPckRvZEJGbXZKU2luYjV3?=
 =?utf-8?B?c0lvNHlKM1Urd0ZYQUNvQ3IwWTdNcnZQVUN0N2pKbndDYlpZUFdPWG03NjY4?=
 =?utf-8?B?ZXFyZkNTTjAxN2xtVDA1cnZXbzVCQmJjVEhFVy9oWGFIUXphQnVjZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tO633O3dsMzoUPeSIPCpUr8j/mPk98BSnB5uo9MBtXIPiFOYDMVh/kV9ONo+uMClIeFy34G99vp98q/vs5N5vKluNOAOD+bNfGE9l2DPff1RZSI1cikzjU1RXHfGDmNEgn9iCB2ElqzciezHqlhOzxMWvVQLAU3ktZsyf2/g/LcU3bp00G3ZdrJmrJfGtwmaj0vD/s1uHGRun+53CqyG+jYvdaHvSmKYmHGp5T+xXeyUz3zGWwTB8j6Lo1lMQ+t/nI1Cg02PWEjhX2Xg8Cqbs7nt52dSEaYmcbtIoqRiOEQAf8jaOObh2G2HdoptfRfV+qdUzwQnoeR3YKR48XSzsw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e7d132-192d-41fb-3dbe-08de99308c1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 07:44:52.0795 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9cg2xLYPx78LlYEiDpc5gaprYrbueMjUbQOgEHE7o6x8xMtfXcKlU70NHZOULfThDim8RBbqIPtc71b1ophm+8WFUxiZ4WIwgfafrByS75s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8552
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

T2gsIHNvcnJ5LCB5b3UgYXNrZWQgUENJX05PX1BBU0lEIGFuZCBJIHJlYWQgaXQgYXMgSU9NTVVf
Tk9fUEFTSUQuDQoNCk15IHVuZGVyc3RhbmRpbmcgaXM6DQpQQ0lfTk9fUEFTSUQoLTEpIGlzIGEg
ZGVmaW5pdGlvbiBpbiBQQ0kgc3ViLXN5c3RlbSwgSU9NTVVfTk9fUEFTSUQgaXMgdXNlZCBpbg0K
dklPTU1VLiBXZSBzaG91bGQgbm90IGNyb3NzIHVzaW5nIHRoZW0gaW4gZGlmZmVyZW50IHN1Yi1z
eXN0ZW1zLg0KU28gbmVlZCB0byB0cmFuc2xhdGUgUENJX05PX1BBU0lEIHRvIElPTU1VX05PX1BB
U0lEIGluIGNyb3NzIHN1Yi1zeXN0ZW0NCmNvbW11bmljYXRpb24uDQoNClRoYW5rcw0KWmhlbnpo
b25nDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IER1YW4sIFpoZW56aG9u
Zw0KPlN1YmplY3Q6IFJFOiBbUEFUQ0ggdjMgMDcvMTRdIGludGVsX2lvbW11OiBVc2UgSU9NTVVf
Tk9fUEFTSUQgYW5kIGRlbGV0ZQ0KPlBBU0lEXzANCj4NCj5IaSBDbGVtZW50LA0KPg0KPkluIGtl
cm5lbCB3ZSBkZWZpbmVkIGl0IGFzOg0KPg0KPiNkZWZpbmUgSU9NTVVfTk9fUEFTSUQgICgwVSkg
LyogUmVzZXJ2ZWQgZm9yIERNQSB3L28gUEFTSUQgKi8NCj4NCj5JbiBpbnRlbF9wYXNpZF9nZXRf
ZW50cnkoKSwgSU9NTVVfTk9fUEFTSUQgaXMgdXNlZCB0byBpbmRleCB0aGUgcGFzaWQgdGFibGUN
Cj5kaXJlY3RseS4NCj4NCj5JbiBxZW11LCBQQVNJRF8wIGlzIHVzZWQgZm9yIERNQSB3L28gUEFT
SUQsIHNvIHdlIHRoaW5rIGl0J3MgZHVwbGljYXRlZCB3aXRoDQo+SU9NTVVfTk9fUEFTSUQuDQo+
DQo+VGhhbmtzDQo+Wmhlbnpob25nDQo+DQo+Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
PkZyb206IENsw6ltZW50IE1BVEhJRVUtLURSSUYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBidWxs
LmNvbT4NCj4+U3ViamVjdDogUmU6IFtQQVRDSCB2MyAwNy8xNF0gaW50ZWxfaW9tbXU6IFVzZSBJ
T01NVV9OT19QQVNJRCBhbmQgZGVsZXRlDQo+PlBBU0lEXzANCj4+DQo+PkhpIFpoZW56aG9uZywN
Cj4+DQo+PkNvdWxkIHlvdSBqdXN0IGNsYXJpZnkgaG93IHRoaXMgaW50ZXJyYWN0cyB3aXRoIFBD
SV9OT19QQVNJRD8NCj4+DQo+Pk5vIHN1cmUgSSB1bmRlcnN0YW5kIHByb3Blcmx5IDovDQo+Pg0K
Pj5PbiBUaHUsIDIwMjYtMDQtMDIgYXQgMjM6NTUgLTA0MDAsIFpoZW56aG9uZyBEdWFuIHdyb3Rl
Og0KPj4+IEluIHByZXZpb3VzIHBhdGNoIHdlIGludHJvZHVjZWQgYSBnbG9iYWwgbWFjcm8gSU9N
TVVfTk9fUEFTSUQoMCkgZm9yDQo+Pj4gUmVxdWVzdHMtd2l0aG91dC1QQVNJRCwgdGhpcyBtYWtl
cyB0aGUgbG9jYWwgbWFjcm8gUEFTSURfMCByZWR1bmRhbnQuDQo+Pj4gRGVsZXRlIGl0IGFuZCB1
c2UgSU9NTVVfTk9fUEFTSUQgaW5zdGVhZC4NCj4+Pg0KPj4+IFN1Z2dlc3RlZC1ieTogWWkgTGl1
IDxbeWkubC5saXVAaW50ZWwuY29tXShtYWlsdG86eWkubC5saXVAaW50ZWwuY29tKT4NCj4+PiBT
aWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbg0KPj48W3poZW56aG9uZy5kdWFuQGludGVsLmNv
bV0obWFpbHRvOnpoZW56aG9uZy5kdWFuQGludGVsLmNvbSk+DQo+Pj4gVGVzdGVkLWJ5OiBYdWRv
bmcgSGFvDQo+PjxbeHVkb25nLmhhb0BpbnRlbC5jb21dKG1haWx0bzp4dWRvbmcuaGFvQGludGVs
LmNvbSk+DQo+Pj4gLS0tDQo+Pj4gwqBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggfMKg
IDEgLQ0KPj4+IMKgaHcvaTM4Ni9pbnRlbF9pb21tdS5jwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTgg
KysrKysrKysrLS0tLS0tLS0tDQo+Pj4gwqBody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmPCoMKg
wqAgfMKgIDIgKy0NCj4+PiDCoDMgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMTEg
ZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9p
bnRlcm5hbC5oIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+Pj4gaW5kZXggYzdl
MTA3ZmU4Ny4uMDE0MTMxNmY4MyAxMDA2NDQNCj4+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11
X2ludGVybmFsLmgNCj4+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+
PiBAQCAtNjE1LDcgKzYxNSw2IEBAIHR5cGVkZWYgc3RydWN0IFZURFJvb3RFbnRyeSBWVERSb290
RW50cnk7DQo+Pj4gwqAjZGVmaW5lIFZURF9DVFhfRU5UUllfTEVHQUNZX1NJWkXCoMKgwqDCoCAx
Ng0KPj4+IMKgI2RlZmluZSBWVERfQ1RYX0VOVFJZX1NDQUxBQkxFX1NJWkXCoMKgIDMyDQo+Pj4N
Cj4+PiAtI2RlZmluZSBQQVNJRF8wwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgMA0KPj4+IMKgI2RlZmluZSBWVERfU01fQ09OVEVYVF9FTlRS
WV9SU1ZEX1ZBTDAoYXcpwqAgKDB4MWUwVUxMIHwNCj4+flZURF9IQVdfTUFTSyhhdykpDQo+Pj4g
wqAjZGVmaW5lIFZURF9TTV9DT05URVhUX0VOVFJZX1JTVkRfVkFMMcKgwqDCoMKgwqAgMHhmZmZm
ZmZmZmZmZTAwMDAwVUxMDQo+Pj4gwqAjZGVmaW5lIFZURF9TTV9DT05URVhUX0VOVFJZX1BSRcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgMHgxMFVMTA0KPj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2lu
dGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+PiBpbmRleCBhYTY3Yzg5ZTcz
Li4zYjhkM2E5NmQyIDEwMDY0NA0KPj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+
ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+IEBAIC05NDEsNyArOTQxLDcgQEAgaW50
IHZ0ZF9jZV9nZXRfcGFzaWRfZW50cnkoSW50ZWxJT01NVVN0YXRlICpzLA0KPj5WVERDb250ZXh0
RW50cnkgKmNlLA0KPj4+IMKgwqDCoMKgIGRtYV9hZGRyX3QgcGFzaWRfZGlyX2Jhc2U7DQo+Pj4N
Cj4+PiDCoMKgwqDCoCBpZiAocGFzaWQgPT0gUENJX05PX1BBU0lEKSB7DQo+Pj4gLcKgwqDCoMKg
wqDCoMKgIHBhc2lkID0gUEFTSURfMDsNCj4+PiArwqDCoMKgwqDCoMKgwqAgcGFzaWQgPSBJT01N
VV9OT19QQVNJRDsNCj4+PiDCoMKgwqDCoCB9DQo+Pj4gwqDCoMKgwqAgcGFzaWRfZGlyX2Jhc2Ug
PSBWVERfQ0VfR0VUX1BBU0lEX0RJUl9UQUJMRShjZSk7DQo+Pj4gwqDCoMKgwqAgcmV0dXJuIHZ0
ZF9nZXRfcGVfZnJvbV9wYXNpZF90YWJsZShzLCBwYXNpZF9kaXJfYmFzZSwgcGFzaWQsIHBlKTsN
Cj4+PiBAQCAtOTU4LDcgKzk1OCw3IEBAIHN0YXRpYyBpbnQgdnRkX2NlX2dldF9wYXNpZF9mcGQo
SW50ZWxJT01NVVN0YXRlICpzLA0KPj4+IMKgwqDCoMKgIFZURFBBU0lERW50cnkgcGU7DQo+Pj4N
Cj4+PiDCoMKgwqDCoCBpZiAocGFzaWQgPT0gUENJX05PX1BBU0lEKSB7DQo+Pj4gLcKgwqDCoMKg
wqDCoMKgIHBhc2lkID0gUEFTSURfMDsNCj4+PiArwqDCoMKgwqDCoMKgwqAgcGFzaWQgPSBJT01N
VV9OT19QQVNJRDsNCj4+PiDCoMKgwqDCoCB9DQo+Pj4gwqDCoMKgwqAgcGFzaWRfZGlyX2Jhc2Ug
PSBWVERfQ0VfR0VUX1BBU0lEX0RJUl9UQUJMRShjZSk7DQo+Pj4NCj4+PiBAQCAtMTUwMSw5ICsx
NTAxLDkgQEAgc3RhdGljIGludCB2dGRfY2VfcGFzaWRfMF9jaGVjayhJbnRlbElPTU1VU3RhdGUN
Cj4qcywNCj4+VlREQ29udGV4dEVudHJ5ICpjZSkNCj4+Pg0KPj4+IMKgwqDCoMKgIC8qDQo+Pj4g
wqDCoMKgwqDCoCAqIE1ha2Ugc3VyZSBpbiBTY2FsYWJsZSBNb2RlLCBhIHByZXNlbnQgY29udGV4
dCBlbnRyeQ0KPj4+IC3CoMKgwqDCoCAqIGhhcyB2YWxpZCBwYXNpZCBlbnRyeSBzZXR0aW5nIGF0
IFBBU0lEXzAuDQo+Pj4gK8KgwqDCoMKgICogaGFzIHZhbGlkIHBhc2lkIGVudHJ5IHNldHRpbmcg
YXQgSU9NTVVfTk9fUEFTSUQuDQo+Pj4gwqDCoMKgwqDCoCAqLw0KPj4+IC3CoMKgwqAgcmV0dXJu
IHZ0ZF9jZV9nZXRfcGFzaWRfZW50cnkocywgY2UsICZwZSwgUEFTSURfMCk7DQo+Pj4gK8KgwqDC
oCByZXR1cm4gdnRkX2NlX2dldF9wYXNpZF9lbnRyeShzLCBjZSwgJnBlLCBJT01NVV9OT19QQVNJ
RCk7DQo+Pj4gwqB9DQo+Pj4NCj4+PiDCoC8qIE1hcCBhIGRldmljZSB0byBpdHMgY29ycmVzcG9u
ZGluZyBkb21haW4gKGNvbnRleHQtZW50cnkpICovDQo+Pj4gQEAgLTE1NjQsNyArMTU2NCw3IEBA
IGludCB2dGRfZGV2X3RvX2NvbnRleHRfZW50cnkoSW50ZWxJT01NVVN0YXRlICpzLA0KPj51aW50
OF90IGJ1c19udW0sDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoCB9DQo+Pj4gwqDCoMKgwqAgfSBlbHNl
IHsNCj4+PiDCoMKgwqDCoMKgwqDCoMKgIC8qDQo+Pj4gLcKgwqDCoMKgwqDCoMKgwqAgKiBDaGVj
ayBpZiB0aGUgcHJvZ3JhbW1pbmcgb2YgcGFzaWQgc2V0dGluZyBvZiBQQVNJRF8wDQo+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqAgKiBDaGVjayBpZiB0aGUgcHJvZ3JhbW1pbmcgb2YgcGFzaWQgc2V0dGlu
ZyBvZiBJT01NVV9OT19QQVNJRA0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAqIGlzIHZhbGlkLCBh
bmQgdGh1cyBhdm9pZHMgdG8gY2hlY2sgcGFzaWQgZW50cnkgZmV0Y2hpbmcNCj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgKiByZXN1bHQgaW4gZnV0dXJlIGhlbHBlciBmdW5jdGlvbiBjYWxsaW5nLg0K
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAqLw0KPj4+IEBAIC0yMTIyLDcgKzIxMjIsNyBAQCBzdGF0
aWMgYm9vbA0KPj52dGRfZG9faW9tbXVfdHJhbnNsYXRlKFZUREFkZHJlc3NTcGFjZSAqdnRkX2Fz
LCBQQ0lCdXMgKmJ1cywNCj4+PiDCoMKgwqDCoCB2dGRfaW9tbXVfbG9jayhzKTsNCj4+Pg0KPj4+
IMKgwqDCoMKgIGlmIChwYXNpZCA9PSBQQ0lfTk9fUEFTSUQgJiYgcy0+cm9vdF9zY2FsYWJsZSkg
ew0KPj4+IC3CoMKgwqDCoMKgwqDCoCBwYXNpZCA9IFBBU0lEXzA7DQo+Pj4gK8KgwqDCoMKgwqDC
oMKgIHBhc2lkID0gSU9NTVVfTk9fUEFTSUQ7DQo+Pj4gwqDCoMKgwqAgfQ0KPj4+DQo+Pj4gwqDC
oMKgwqAgLyogVHJ5IHRvIGZldGNoIHB0ZSBmcm9tIElPVExCICovDQo+Pj4gQEAgLTI1MDgsMTAg
KzI1MDgsMTAgQEAgc3RhdGljIHZvaWQNCj4+dnRkX2lvdGxiX3BhZ2VfaW52YWxpZGF0ZV9ub3Rp
ZnkoSW50ZWxJT01NVVN0YXRlICpzLA0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICog
SW4gbGVnYWN5IG1vZGUsIHZ0ZF9hcy0+cGFzaWQgPT0gcGFzaWQgaXMgYWx3YXlzIHRydWUuDQo+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBJbiBzY2FsYWJsZSBtb2RlLCBmb3IgdnRk
IGFkZHJlc3Mgc3BhY2UgYmFja2luZyBhIFBDSQ0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICogZGV2aWNlIHdpdGhvdXQgcGFzaWQsIG5lZWRzIHRvIGNvbXBhcmUgcGFzaWQgd2l0aA0K
Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBQQVNJRF8wIG9mIHRoaXMgZGV2aWNlLg0K
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBJT01NVV9OT19QQVNJRCBvZiB0aGlzIGRl
dmljZS4NCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLw0KPj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBpZiAoISh2dGRfYXMtPnBhc2lkID09IHBhc2lkIHx8DQo+Pj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHZ0ZF9hcy0+cGFzaWQgPT0gUENJX05PX1BB
U0lEICYmIHBhc2lkID09IFBBU0lEXzApKSkgew0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICh2dGRfYXMtPnBhc2lkID09IFBDSV9OT19QQVNJRCAmJiBwYXNpZCA9PQ0K
PklPTU1VX05PX1BBU0lEKSkpDQo+PnsNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBjb250aW51ZTsNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPj4+DQo+Pj4g
QEAgLTMwMjIsNyArMzAyMiw3IEBAIHN0YXRpYyB2b2lkDQo+PnZ0ZF9waW90bGJfcGFzaWRfaW52
YWxpZGF0ZShJbnRlbElPTU1VU3RhdGUgKnMsDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAoIXZ0
ZF9kZXZfdG9fY29udGV4dF9lbnRyeShzLCBwY2lfYnVzX251bSh2dGRfYXMtPmJ1cyksDQo+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB2dGRfYXMtPmRldmZuLCAmY2UpICYmDQo+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGRvbWFpbl9pZCA9PSB2dGRfZ2V0X2RvbWFpbl9pZChzLCAmY2UsIHZ0
ZF9hcy0+cGFzaWQpKSB7DQo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCh2dGRfYXMt
PnBhc2lkICE9IFBDSV9OT19QQVNJRCB8fCBwYXNpZCAhPSBQQVNJRF8wKSAmJg0KPj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGlmICgodnRkX2FzLT5wYXNpZCAhPSBQQ0lfTk9fUEFTSUQgfHwg
cGFzaWQgIT0gSU9NTVVfTk9fUEFTSUQpICYmDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgdnRkX2FzLT5wYXNpZCAhPSBwYXNpZCkgew0KPj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOw0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9
DQo+Pj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYyBiL2h3L2kzODYv
aW50ZWxfaW9tbXVfYWNjZWwuYw0KPj4+IGluZGV4IGJkMTIzNmMwNzAuLjg5NDBkMjQwYTEgMTAw
NjQ0DQo+Pj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jDQo+Pj4gKysrIGIvaHcv
aTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jDQo+Pj4gQEAgLTIxNyw3ICsyMTcsNyBAQCBzdGF0aWMg
dm9pZCB2dGRfZmx1c2hfaG9zdF9waW90bGJfbG9ja2VkKGdwb2ludGVyIGtleSwNCj4+Z3BvaW50
ZXIgdmFsdWUsDQo+Pj4NCj4+PiDCoMKgwqDCoCBkaWQgPSBWVERfU01fUEFTSURfRU5UUllfRElE
KCZwY19lbnRyeS0+cGFzaWRfZW50cnkpOw0KPj4+DQo+Pj4gLcKgwqDCoCBpZiAocGlvdGxiX2lu
Zm8tPmRvbWFpbl9pZCA9PSBkaWQgJiYgcGlvdGxiX2luZm8tPnBhc2lkID09IFBBU0lEXzApIHsN
Cj4+PiArwqDCoMKgIGlmIChwaW90bGJfaW5mby0+ZG9tYWluX2lkID09IGRpZCAmJiBwaW90bGJf
aW5mby0+cGFzaWQgPT0NCj4+SU9NTVVfTk9fUEFTSUQpIHsNCj4+PiDCoMKgwqDCoMKgwqDCoMKg
IEhvc3RJT01NVURldmljZUlPTU1VRkQgKmhpb2RpID0NCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgSE9TVF9JT01NVV9ERVZJQ0VfSU9NTVVGRCh2dGRfaGlvZC0+aGlvZCk7DQo+Pj4gwqDC
oMKgwqDCoMKgwqDCoCB1aW50MzJfdCBlbnRyeV9udW0gPSAxOyAvKiBPbmx5IGltcGxlbWVudCBv
bmUgcmVxdWVzdCBmb3Igc2ltcGxpY2l0eSAqLw0K

