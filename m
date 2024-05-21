Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FADC25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 05:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Hl7-0003Yh-1V; Tue, 21 May 2024 01:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9Hl1-0003Vd-Cf
 for qemu-devel@nongnu.org; Tue, 21 May 2024 01:09:52 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9Hky-00044e-EJ
 for qemu-devel@nongnu.org; Tue, 21 May 2024 01:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1716268188; x=1747804188;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ETuMgj1BO5CxYkupeG+CZl1tEANTDGprVkcVaws5eMY=;
 b=iZ2VPkNEzGjZ4X1+ZSnx+8keOaIC6uSZISVq/ydnKb00rPHR/a2TcDat
 jowonCzm6mHfR92cmAAxMbq4NrYwp0s0CaYBqfUDDQr4vwMGbwBuu1fk9
 fVWt3DEOSYMZvqWflxLuYhAVtGoULBTCJ51AXUCb9gSKtboNQFiDPUFWa
 piXSLEfgz8ClIdZIZiqWNNOC3yzkKV46ltWLQJqhSYk/1R+OW8iOzNdjA
 3Yblkt7xN9B6Fj/YUL6NwjL8BCERFfVZAdWp18e7Gb1L4Exdw5qC+Zv6R
 FSZAoAbRDuTcdHbve9mbZuC9PDQkPnayF4MZD/lLoydmVn+liGoqFS1Nu A==;
X-IronPort-AV: E=Sophos;i="6.08,176,1712613600"; d="scan'208";a="12959694"
X-MGA-submission: =?us-ascii?q?MDFQ64Yyu9JszNrOWwq1ITMoGNxdXv6oThbaSF?=
 =?us-ascii?q?WSS8m+rHcmRg2iVo3RQtmY2OFjvptQPAmtQRbHjACVQWpvQAQ/5rbbmQ?=
 =?us-ascii?q?AT8uXagGCNVKtlZL0NWm0duOXvVfM1Xl8e3Qs/474XjLvP4besRQTLtY?=
 =?us-ascii?q?YemulKDcYQk/OTE2kGwh9vXA=3D=3D?=
Received: from mail-he1eur04lp2051.outbound.protection.outlook.com (HELO
 EUR04-HE1-obe.outbound.protection.outlook.com) ([104.47.13.51])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 07:09:42 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zp8KnqeFL4xoIPRwoFuHOvKKr6kM1PGNvhjeBjOJAhRSVgB1nQfUTi3I4cvJ1QZtrBb6s0hF+Ztfx/92qydu4nA4XD/M89LaNewxlxdDk8OL7D0mYAfEp6bOBYJttE8N6mttHPXHDQMwzTEBxcImW88WY/wNq9vuLG3US6BybF6hMk2japG9c06ejEoYin/7DCi3butR7f4LGEdp122kPuMy5jl+ZJN7yxrNQHpBrwnu1BWIh96ti9LcMlT+C0cX2d+EmLO2UNCXykd5zGfy6aaAy7NVhg0aPqBjjhX6R1Or1la9UV6w/zcbCqIpZOjDc1M+/IpcIzHk5pCWfSEhyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETuMgj1BO5CxYkupeG+CZl1tEANTDGprVkcVaws5eMY=;
 b=QCRYsKAKlvA+vR91WjktUuZoifogBAdT7mfrgEJ4INmOxB0FOE61UerxhzO/uqnB9chN7s1vFPqsl1gMv1vVNLSCiL9GWX1vylZNSPkNADTclp3h0NJ7bHtXB3GIqt41JI/wRiotpmkyxb77d4DkNI3y+9UQQ2+c8MjPqMDeGcVop0v/7xCiJyaaBAyyzJm7tUvfB9wO+fqhfpIpQsu/sX9EHs/WQwG3F1GcubkBmx209sPctEqgYI+zZeUdFnTxxJ/B5XVBQGYkerV8boCPudJxFbWfGDOKEnfGgG0OUdLm12x30E59vIOa1cQjlFG3T9wwlZ8VVl828xuknV3kOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS4PR07MB8629.eurprd07.prod.outlook.com (2603:10a6:20b:4ff::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34; Tue, 21 May
 2024 05:09:40 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 05:09:40 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>
Subject: Re: [PATCH ats_vtd v2 20/25] intel_iommu: fill the PASID field when
 creating an instance of IOMMUTLBEntry
Thread-Topic: [PATCH ats_vtd v2 20/25] intel_iommu: fill the PASID field when
 creating an instance of IOMMUTLBEntry
Thread-Index: AQHappeALIV+LSCFtU2DUckW7CrvT7GbQBqAgAAIqoCABcM+gIAAIN6A
Date: Tue, 21 May 2024 05:09:40 +0000
Message-ID: <b29561fa-70e8-48c6-ae8f-9cc43bc19a4d@eviden.com>
References: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
 <20240515071057.33990-21-clement.mathieu--drif@eviden.com>
 <SJ0PR11MB674421DBE60D5C9CF3584C6C92EE2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <2f86f14d-67dd-4390-99d8-469945279c04@eviden.com>
 <SJ0PR11MB674405DBEDD710A2B38E0E1192EA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB674405DBEDD710A2B38E0E1192EA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS4PR07MB8629:EE_
x-ms-office365-filtering-correlation-id: 31b275ae-a22c-4926-d2cc-08dc79543819
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?eFhYVERlOFB3MG55VzV5cFd3b3gvcGg3VEk1RVRMWnJDTm9mZ2FvYXdiSHVm?=
 =?utf-8?B?ZjFmUmY2S0JyZXZySk9CWkJnWkxKNE1oNXh3OEJZdkVvOFVkcnY2Mm1MbWpX?=
 =?utf-8?B?UUhKeHcwWmpwd2NLTDducmtqd0prNGQ4OU11WEN5b25uZjFiclpwYUlTQ0Zt?=
 =?utf-8?B?NVNtQTFpeXlGZkhuUmtMcStCaGs3VEE1REkxYTMzNGdMQ3Fucjg2Y0FBRGsz?=
 =?utf-8?B?SnVPbkNhVkxTOEJiN1YwRDF5aitzWEt4ci9HL2JKL0FkVlUxbjdUSGNIN0Vv?=
 =?utf-8?B?SUhzZjVGTjVURHprWG51V1hlVm9FZVVSTmtieVk4UWNtWlpMQ3RpZGVmVWUy?=
 =?utf-8?B?T3hZUWVNTE42cVJVZTdraEtPUS9QSnF4UGdGaGlyNGtPQmEzcWFVaWhpRGIr?=
 =?utf-8?B?TTBoVStjNTFFVEVlcnREMmROc2oyb1BnM1hTNUlyTHE2OTA4KzRxVTBHVGho?=
 =?utf-8?B?UXlSV3JidjIzTnZ4SVF3dFRGcHBhY2hYcCs0SCs1cGZpUmFaODhncnZwNFh6?=
 =?utf-8?B?SnQ2c0M3RnFicXBQREQ2cENaZk4waWt3SWlGSnUwbHI3KytLOGF1SUIyenZP?=
 =?utf-8?B?WTBvdGJ0MlZxNjNVQllRNUZqanNtZEt1MVE2aGlEeFVxRTIycjdFNG1RanIx?=
 =?utf-8?B?bGVHM3dkU3cySkdFbXJxRUowVFI2SGVMT3M5R09kQUVuVW5TRXEwbGdjS3lM?=
 =?utf-8?B?Sk1rZkQ2Wkk0dzQrVFM0TlhLaDFCaUNTOFl6RWR1NktySVpNMFh3TlZ5ZElC?=
 =?utf-8?B?ZWtPbEJtc0JsUGVwN0pWTjdSY0ovYTh5R3hTK1QvY1JRM2IrQWJrdlgzOEUx?=
 =?utf-8?B?S2tEZVNGWlcyUVNvSXhxSWJUSmlOTmJPZlBzaWxWVjc0cmw1TTlMTmthUGZ2?=
 =?utf-8?B?NUZmQjBRV2tiVDJzWXlOQzBwY1Azd28vZWRFOHFLREV5L1V3eTNvR0hEZkI3?=
 =?utf-8?B?NHRMZmdKNzdGcGpIUXBlZ2M4dWhLbk1BL2VlUUZZK0FXYXJvV0lJZTF4TE5i?=
 =?utf-8?B?QWJ3STZOa1VXYjA3MmM5WEtRMVdlMHd3Z2NJK2lxUXV3TnYwQlFraVJabEdD?=
 =?utf-8?B?d0hEOU1vODZFbjdQbEMxRnFiRUVSZGJ3azJuVkRMcGhXMG94Slh4WkpyVkI1?=
 =?utf-8?B?RnNnZzA4Z01TM1hTQzJ2Qk95QjM4WGNveVpRWmt5cFZBR0tqLzd5d3BCVDhV?=
 =?utf-8?B?RG5BVmRwc2djSFQ4UTd0YVlsSHFyRW1HeEhBMWNKZW1XRVVVSGwrNndqUlla?=
 =?utf-8?B?L0t5eFQydTljU0psR3NJdy9tZWhqZFJuQTR6NU5DVm5JK1VkOVF0aVFRRk4y?=
 =?utf-8?B?VTFoL3puV0lOdEpBZ1UyNCtwNXFWOElMMWNkQjlPM3l1T2NYRXdNdVk5M21R?=
 =?utf-8?B?MFBIcGpBMUtzTlR2WlFTemo4YXhZYkUwTkRSUXdXSVhocXdiRWZMb3FoNS9D?=
 =?utf-8?B?Z09wcFBmbDM3MGNGVExXN1FrenlLb0g5TTFiRWlYQ05OWmF3RElnVHZaSEE1?=
 =?utf-8?B?czMvcUlJSFJ1b0NHUERPNi80OTFpMGVTZ3psV2FNQVliMFZBK1pLRE1DeHlz?=
 =?utf-8?B?cW1aUjRPMWZsYU0zZWRoa1kyRlBIOFJvY2J1OXo4ZkthWWtwMDBDVXlRM2RF?=
 =?utf-8?B?Z00xSTZkQ0U5Y2hoQ2xKR09YMlV4VG9lRGt3M29xSEFuQmVlTE5WQ3c0ZGNO?=
 =?utf-8?B?SkpHTGpnTVM3VFdhdDZhZXc0QXZTbEgyRndEQjBxb1hCb2pFa0lSb0V5SGha?=
 =?utf-8?B?L1dLSVQ4ZCtrV05xUjZhV1V3MjdFbWR0OWl3Q1A3V1FKcndza2d0Znp2Ylc5?=
 =?utf-8?B?WGt1QTBRRXB3MmtWTmpuZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3ZjNGFRM3J6OGd2d3pnK0JHVXliZkNyY2ZSMXpQVDV3NUhKMjc4RTE1Uisw?=
 =?utf-8?B?c1p0YnFQaXRxZ2w0RUxhcWpCN3VIbWVlTEJBblJIaGY2dkIvMW9oNmpza1BG?=
 =?utf-8?B?dXpwSEx3U0U5dTNHWGxXcldlNURDUXFGQjkxYnFWNnY4NHN3azB0UlVna2k2?=
 =?utf-8?B?WXd1RWpJWHNDYTB3N2ZYVk5DYTlzaFBkWml0SmY3dlkydzY1TTg5cFZCMU1E?=
 =?utf-8?B?KzF2WHdnQitiYXd1c0Vib0pkYWF2TW9wV0JhaTE1T0ZJamI1T0swbkxBY3Ji?=
 =?utf-8?B?S3QvR0dVTHJwWk1GMmtCRkNrakpNS1V5elNpRzNxWU1uRTU0S084cUFsS0Rs?=
 =?utf-8?B?K1FhUHNWS2NYWFJXN1ZqSHRRczVEamRPY0czZ3E3cGFPK08ydFFLNENLREsy?=
 =?utf-8?B?SUlXUkpJUjVzUmZsZXphUnRmVjlUZ0ovTHk2ZjAxS1p0S2JZQWZiUkVMK1Ja?=
 =?utf-8?B?ZGJLd0VHYXpPdFcxUjk4UEtSSzlPTG4wWXZETVlqMHhtaTNHRHhKNEZWOEsy?=
 =?utf-8?B?UmR6clVGQktsN3o2Z3ZOL1BOanVTWnR4eEdPMmdYMjRkOCtGNDF5aHJXYjA0?=
 =?utf-8?B?RWt3N3FCNGUzcjErZUJxVUxxV2s1YzN4M1U0SDcvQktTVHVyWTlsSmxlM2d3?=
 =?utf-8?B?bnRxaGdCaXhnd0trc0JnekQrQ3I3VkVkYkNQeDl0ayt2a3VmYmZkVDd6cDhT?=
 =?utf-8?B?WS92c2Zja213OGwyblBnYVVZVDV1aUZpM0pVZDNXbHZRbVV2aE9ub0hHRkNF?=
 =?utf-8?B?YVNSNnM1d1hNaWdzcjdTaTlFbFJvL0oweVhteUdJbG1UN2xGQlZ2WVAxOVVY?=
 =?utf-8?B?L0ZpcVlEQ3Q0Mmt6NC93TXFZQTBKbW5pYWxITGJvUi9FVHBJb3lVU1BsbEtE?=
 =?utf-8?B?WkNSY0JodzFEY2lmYlBUTGI3RWthdW84ck42Vk1Oa25ENkR0dXhxTWVJMWdX?=
 =?utf-8?B?U1gxaWRiMHcvbmpiQWc3bEtmM3VCTWNTTld4OFhKYnhjNWVpUExrTjcxTFhD?=
 =?utf-8?B?MjFYblVnNm1EQU84ZW9yczdIdGExVVN3c21rZWppTFVCMkp1VWVpRWdUZ2J0?=
 =?utf-8?B?ZGdCOVdINUh0dG9BSkxNSkxsQ1cwTFR1VEdNSDNDUXgwRkVSOU9RSEJBYnlR?=
 =?utf-8?B?elNWbEZ2eWNDQ1VCWGJscXROTFFIdEJhd3R5SlhUU0JwTHRkVHhGK1QzeEF6?=
 =?utf-8?B?L2htUkN2YVJQcVpvcDN5MHJHQndka0c3QmJ1bTRMdU82YzdLSUZxSnJKVmRj?=
 =?utf-8?B?bUpVamgxdUNDa2wxUGhqSnZ2eTFLQ0lCTGNsbnNsQUI0cXJidDBuZDlsTmNa?=
 =?utf-8?B?SkcyeWcwQVFPRU9ncDlZWW5mYkhhVWsvMVF2ejhlREIySTdwcjF5QXJNdzc5?=
 =?utf-8?B?UFdXVHV5MEFxQ1p2VjNWM2htOUhkMXR6Yzk0Tk1zQ2R5cUIrQlJUZEptdklN?=
 =?utf-8?B?UmE4Q0lNcmRIY3JrcU9RVTlzemRFN0pacVpKUExOdTBlQlJaTnkydEZ0THBP?=
 =?utf-8?B?dTJnRlVBRXY4UWFTZEhTbGdUc3h4aWlXUHpGL2ZmSkVab2pOeXB2STM2Smht?=
 =?utf-8?B?Z05lQXExVzM4N056NHk5UTBlb2R1N2FDY2RWRTQ2K1JsSjNVZEVBSjVxYXNo?=
 =?utf-8?B?ZWsrUTJEcUl5NlpEaDNPODJyTTlvaWdia0tUcW9LeEtEaGRzMW92bm04eTFa?=
 =?utf-8?B?Q3lHbGNuOVgxRnBieThMNDgvQnI0Qk53OHJ0QnAxMVgrR0ZuS2toa3dDcEQ2?=
 =?utf-8?B?cEM3aVNnV3VEVWtwYmxXR2FuSGgyYUhxQ2xrc21BMXhEYWltVnprVytXNlNa?=
 =?utf-8?B?S2h1ZnVlNVgyelVWajY5R1hKMTUwdU1wcXk4RVBCOWN5UjlSMEd0Z3ozV3Vh?=
 =?utf-8?B?VFBRc25EbytkTkRIUG0xVU9EVG9zT3NFdWpSL2lPQmM3VEVnOVpSeGZuN1pk?=
 =?utf-8?B?M2cxOSt5eGZPN0k3SU1uNVRKOGFVaDV4aXlzQ1dhWmt1OE5ycG1VQks0Vmwr?=
 =?utf-8?B?ZDMwSzlremhFemlIVmIrcGM2Q203YWxQQTZreXBVaHBvSnkveXl5dkJmdUlw?=
 =?utf-8?B?S3V6K1lvV3E0R1hybWtGMU5nQnY2dHhtVC8ycFVrdEtWZUNIaWZaN1hTaHA1?=
 =?utf-8?B?c1pOQnh2R0I2SzF2OCtPM25zaENqcVRUOTlNTERENE1XU2dRck1FR2VBbnFD?=
 =?utf-8?Q?QBZUHr7DuxgVqy7WYt+OSvA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07FA1E053820C146830E8649074F8992@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b275ae-a22c-4926-d2cc-08dc79543819
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 05:09:40.4696 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XQzNKFc9sesVgu/JHWKZqaAmXWqkDg/tSKsZ2L0iCOyDI1/VfjSvd7g8NZQJT3jP73t0eiWOuxxVfzQXUyqmpNK373a8jt9moKFXF6PJsj+kAiAgZWvPKUKydppCQVbQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8629
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

DQpPbiAyMS8wNS8yMDI0IDA1OjExLCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+IENhdXRpb246
IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywg
dW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4NCj4NCj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+PiBGcm9tOiBDTEVNRU5UIE1BVEhJRVUtLURSSUYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBl
dmlkZW4uY29tPg0KPj4gU3ViamVjdDogUmU6IFtQQVRDSCBhdHNfdnRkIHYyIDIwLzI1XSBpbnRl
bF9pb21tdTogZmlsbCB0aGUgUEFTSUQgZmllbGQgd2hlbg0KPj4gY3JlYXRpbmcgYW4gaW5zdGFu
Y2Ugb2YgSU9NTVVUTEJFbnRyeQ0KPj4NCj4+DQo+PiBPbiAxNy8wNS8yMDI0IDEyOjQwLCBEdWFu
LCBaaGVuemhvbmcgd3JvdGU6DQo+Pj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBv
cGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcw0KPj4gZW1haWwgY29t
ZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4N
Cj4+Pg0KPj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+PiBGcm9tOiBDTEVNRU5U
IE1BVEhJRVUtLURSSUYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KPj4+PiBT
dWJqZWN0OiBbUEFUQ0ggYXRzX3Z0ZCB2MiAyMC8yNV0gaW50ZWxfaW9tbXU6IGZpbGwgdGhlIFBB
U0lEIGZpZWxkIHdoZW4NCj4+Pj4gY3JlYXRpbmcgYW4gaW5zdGFuY2Ugb2YgSU9NTVVUTEJFbnRy
eQ0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVt
ZW50Lm1hdGhpZXUtLQ0KPj4gZHJpZkBldmlkZW4uY29tPg0KPj4+PiAtLS0NCj4+Pj4gaHcvaTM4
Ni9pbnRlbF9pb21tdS5jIHwgNyArKysrKysrDQo+Pj4+IDEgZmlsZSBjaGFuZ2VkLCA3IGluc2Vy
dGlvbnMoKykNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBi
L2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+PiBpbmRleCA1M2YxN2Q2NmMwLi5jNGViZDQ1Njll
IDEwMDY0NA0KPj4+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+Pj4gKysrIGIvaHcv
aTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4+IEBAIC0yMjk5LDYgKzIyOTksNyBAQCBvdXQ6DQo+Pj4+
ICAgICAgIGVudHJ5LT50cmFuc2xhdGVkX2FkZHIgPSB2dGRfZ2V0X3NscHRlX2FkZHIocHRlLCBz
LT5hd19iaXRzKSAmDQo+Pj4+IHBhZ2VfbWFzazsNCj4+Pj4gICAgICAgZW50cnktPmFkZHJfbWFz
ayA9IH5wYWdlX21hc2s7DQo+Pj4+ICAgICAgIGVudHJ5LT5wZXJtID0gYWNjZXNzX2ZsYWdzOw0K
Pj4+PiArICAgIGVudHJ5LT5wYXNpZCA9IHBhc2lkOw0KPj4+IEZvciBQQ0lfTk9fUEFTSUQsIGRv
IHdlIHdhbnQgdG8gYXNzaWduIFBDSV9OT19QQVNJRCBvciByaWQycGFzaWQ/DQo+PiB3ZSBoYXZl
IHRoZSBmb2xsb3dpbmcgc3RhdGVtZW50IGEgZmV3IGxpbmVzIGFib3ZlIDoNCj4+IGlmIChyaWQy
cGFzaWQpIHsNCj4+ICAgICAgICAgIHBhc2lkID0gVlREX0NFX0dFVF9SSUQyUEFTSUQoJmNlKTsN
Cj4+IH0NCj4+DQo+PiBzbyB3ZSBzdG9yZSByaWQycGFzaWQgaWYgdGhlIGZlYXR1cmUgaXMgZW5h
YmxlZC4NCj4+DQo+PiBCdXQgbWF5YmUgd2Ugc2hvdWxkIHN0b3JlIFBDSV9OT19QQVNJRCBiZWNh
dXNlIHRoZSByZXN0IG9mIHRoZSB3b3JsZCBpcw0KPj4gbm90IHN1cHBvc2VkIHRvIGJlIGF3YXJl
IG9mIHdoYXQgd2UgYXJlIGRvaW5nIHdpdGggcmlkMnBhc2lkLg0KPj4NCj4+IERvZXMgaXQgbG9v
ayBnb29kIHRvIHlvdT8NCj4gWWVzLCB0aGF0IG1ha2Ugc2Vuc2UuDQpvaywgd2lsbCBkbw0KPg0K
Pj4+IFRoYW5rcw0KPj4+IFpoZW56aG9uZw0KPj4+DQo+Pj4+ICAgICAgIHJldHVybiB0cnVlOw0K
Pj4+Pg0KPj4+PiBlcnJvcjoNCj4+Pj4gQEAgLTIzMDcsNiArMjMwOCw3IEBAIGVycm9yOg0KPj4+
PiAgICAgICBlbnRyeS0+dHJhbnNsYXRlZF9hZGRyID0gMDsNCj4+Pj4gICAgICAgZW50cnktPmFk
ZHJfbWFzayA9IDA7DQo+Pj4+ICAgICAgIGVudHJ5LT5wZXJtID0gSU9NTVVfTk9ORTsNCj4+Pj4g
KyAgICBlbnRyeS0+cGFzaWQgPSBQQ0lfTk9fUEFTSUQ7DQo+Pj4+ICAgICAgIHJldHVybiBmYWxz
ZTsNCj4+Pj4gfQ0KPj4+Pg0KPj4+PiBAQCAtMzQ5Nyw2ICszNDk5LDcgQEAgc3RhdGljIHZvaWQN
Cj4+Pj4gdnRkX3Bpb3RsYl9wYXNpZF9pbnZhbGlkYXRlX25vdGlmeShJbnRlbElPTU1VU3RhdGUg
KnMsDQo+Pj4+ICAgICAgICAgICAgICAgICAgIGV2ZW50LmVudHJ5LnRhcmdldF9hcyA9ICZhZGRy
ZXNzX3NwYWNlX21lbW9yeTsNCj4+Pj4gICAgICAgICAgICAgICAgICAgZXZlbnQuZW50cnkuaW92
YSA9IG5vdGlmaWVyLT5zdGFydDsNCj4+Pj4gICAgICAgICAgICAgICAgICAgZXZlbnQuZW50cnku
cGVybSA9IElPTU1VX05PTkU7DQo+Pj4+ICsgICAgICAgICAgICAgICAgZXZlbnQuZW50cnkucGFz
aWQgPSBwYXNpZDsNCj4+Pj4gICAgICAgICAgICAgICAgICAgZXZlbnQuZW50cnkuYWRkcl9tYXNr
ID0gbm90aWZpZXItPmVuZCAtIG5vdGlmaWVyLT5zdGFydDsNCj4+Pj4gICAgICAgICAgICAgICAg
ICAgZXZlbnQuZW50cnkudHJhbnNsYXRlZF9hZGRyID0gMDsNCj4+Pj4NCj4+Pj4gQEAgLTM2Nzgs
NiArMzY4MSw3IEBAIHN0YXRpYyB2b2lkDQo+Pj4+IHZ0ZF9waW90bGJfcGFnZV9pbnZhbGlkYXRl
KEludGVsSU9NTVVTdGF0ZSAqcywgdWludDE2X3QgZG9tYWluX2lkLA0KPj4+PiAgICAgICAgICAg
ICAgIGV2ZW50LmVudHJ5LnRhcmdldF9hcyA9ICZhZGRyZXNzX3NwYWNlX21lbW9yeTsNCj4+Pj4g
ICAgICAgICAgICAgICBldmVudC5lbnRyeS5pb3ZhID0gYWRkcjsNCj4+Pj4gICAgICAgICAgICAg
ICBldmVudC5lbnRyeS5wZXJtID0gSU9NTVVfTk9ORTsNCj4+Pj4gKyAgICAgICAgICAgIGV2ZW50
LmVudHJ5LnBhc2lkID0gcGFzaWQ7DQo+Pj4+ICAgICAgICAgICAgICAgZXZlbnQuZW50cnkuYWRk
cl9tYXNrID0gc2l6ZSAtIDE7DQo+Pj4+ICAgICAgICAgICAgICAgZXZlbnQuZW50cnkudHJhbnNs
YXRlZF9hZGRyID0gMDsNCj4+Pj4NCj4+Pj4gQEAgLTQzMzUsNiArNDMzOSw3IEBAIHN0YXRpYyB2
b2lkDQo+Pj4+IGRvX2ludmFsaWRhdGVfZGV2aWNlX3RsYihWVERBZGRyZXNzU3BhY2UgKnZ0ZF9k
ZXZfYXMsDQo+Pj4+ICAgICAgIGV2ZW50LmVudHJ5LmlvdmEgPSBhZGRyOw0KPj4+PiAgICAgICBl
dmVudC5lbnRyeS5wZXJtID0gSU9NTVVfTk9ORTsNCj4+Pj4gICAgICAgZXZlbnQuZW50cnkudHJh
bnNsYXRlZF9hZGRyID0gMDsNCj4+Pj4gKyAgICBldmVudC5lbnRyeS5wYXNpZCA9IHZ0ZF9kZXZf
YXMtPnBhc2lkOw0KPj4+PiAgICAgICBtZW1vcnlfcmVnaW9uX25vdGlmeV9pb21tdSgmdnRkX2Rl
dl9hcy0+aW9tbXUsIDAsIGV2ZW50KTsNCj4+Pj4gfQ0KPj4+Pg0KPj4+PiBAQCAtNDkxMSw2ICs0
OTE2LDcgQEAgc3RhdGljIElPTU1VVExCRW50cnkNCj4+Pj4gdnRkX2lvbW11X3RyYW5zbGF0ZShJ
T01NVU1lbW9yeVJlZ2lvbiAqaW9tbXUsIGh3YWRkciBhZGRyLA0KPj4+PiAgICAgICBJT01NVVRM
QkVudHJ5IGlvdGxiID0gew0KPj4+PiAgICAgICAgICAgLyogV2UnbGwgZmlsbCBpbiB0aGUgcmVz
dCBsYXRlci4gKi8NCj4+Pj4gICAgICAgICAgIC50YXJnZXRfYXMgPSAmYWRkcmVzc19zcGFjZV9t
ZW1vcnksDQo+Pj4+ICsgICAgICAgIC5wYXNpZCA9IHZ0ZF9hcy0+cGFzaWQsDQo+Pj4+ICAgICAg
IH07DQo+Pj4+ICAgICAgIGJvb2wgc3VjY2VzczsNCj4+Pj4NCj4+Pj4gQEAgLTQ5MjMsNiArNDky
OSw3IEBAIHN0YXRpYyBJT01NVVRMQkVudHJ5DQo+Pj4+IHZ0ZF9pb21tdV90cmFuc2xhdGUoSU9N
TVVNZW1vcnlSZWdpb24gKmlvbW11LCBod2FkZHIgYWRkciwNCj4+Pj4gICAgICAgICAgIGlvdGxi
LnRyYW5zbGF0ZWRfYWRkciA9IGFkZHIgJiBWVERfUEFHRV9NQVNLXzRLOw0KPj4+PiAgICAgICAg
ICAgaW90bGIuYWRkcl9tYXNrID0gflZURF9QQUdFX01BU0tfNEs7DQo+Pj4+ICAgICAgICAgICBp
b3RsYi5wZXJtID0gSU9NTVVfUlc7DQo+Pj4+ICsgICAgICAgIGlvdGxiLnBhc2lkID0gUENJX05P
X1BBU0lEOw0KPj4+PiAgICAgICAgICAgc3VjY2VzcyA9IHRydWU7DQo+Pj4+ICAgICAgIH0NCj4+
Pj4NCj4+Pj4gLS0NCj4+Pj4gMi40NC4w

