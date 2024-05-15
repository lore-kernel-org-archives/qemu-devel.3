Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7797CC25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78qH-0004WT-Hn; Wed, 15 May 2024 03:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qE-0004Vn-V7
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:22 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qD-0000oX-AS
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1715757261; x=1747293261;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=C4gBjDFokjMiRkmDgDz/2mxqzwKco7331UmMB/qHfvs=;
 b=Pa2TS8MiyxP36y1fRxmVZmM6yPIzMshHsSiOtXscBpTfwfOPcMXXA+bt
 3QbI1c9r5HDRdzFJW/qFL4r4f0Uj2aGd+hleCQ5UKbCIRWdS7tpi3zC8O
 VwD5Aty0NzNEW/v05vHZI625zAEJ3Q/ZBJ0kl+dR+3BEh//kLQA49Q3Ri
 ZJbydReIY30laZ8zJRL+8v7T7L8KFCotoPwlw0CF437sd6ApTieeGv2KK
 4Y3fwbgBJ8zVWX6p1E9TehSGnw3jEsVYoH3ncMaWl0E6SiinkLFz12ysj
 im6BTCO+f60D2zFcgPXf6ufLJRLcH0A0GInDAErXEEDa0CZrleBPjPPwl w==;
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; d="scan'208";a="12580199"
X-MGA-submission: =?us-ascii?q?MDHzlVTf/YYzHiiVBkoAmIWY6zr6YNDOkdeblV?=
 =?us-ascii?q?n7luMLaDcngjqRtGKQlatIw8RV/TErmQaGaiEZOmys06c7poBObkFNz0?=
 =?us-ascii?q?tJbG4ueCA/cmSIQ/gLWsXjTVmh+8kyni1WDLp2l2R6jAtoNsa8LVBvlK?=
 =?us-ascii?q?9CY8lS0ViEOX0fNikM76Gciw=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 09:14:18 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLALIcBEaaHrmE/Yj0CkxK3cVxz6G7eWGI9c5L4Lk3QdjhNKDQZvD3Mrmjj84r4SFZNJ+OQU6owoFAYb6/IvT55VkDZwB4TmqsmAQjYnLyHM9tUg3kCfVsTiruLXBOdbt7EbDdvpW6cCYwOhSSE2yA1u8lWd2mkxyy1EdjtKFNoOOdi/gp6UhZ33h+LHBvs9sYOupF7G+mwuvZPvCc97ObWczu5hI2af6hwBH0qmZvl8y7FDazogOG8VfOOsQ/SIGq2ksCPAAzIe3CuJUkZ4M2fvHvDiHlBhvpASXRWlisdQFfVb9Mpz198O4Tkfmioh5Xzs3J/r2e1vxF5z5xcBPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4gBjDFokjMiRkmDgDz/2mxqzwKco7331UmMB/qHfvs=;
 b=G3NfbUr6UJvYmPUBjB+hzofl6awblPddcgX1grgSuJ1ed0Z0TQiNIRAW+ZtLc8MEcpIcf16RnnYzf3xe/cXjjAychc+PjNPjwA2T2dHph1qDDuc94dpmAU5PqF3XDZijeM2Sc2iVNzm2Djbsv9RUuaOy3JlPmnzEUHhDefKYllbua79s9q68CQ1JNgpij3PuURU2rbFrA9T6wBHLtw8zLVdp6E/e9AvNwhQ+tBDSYhYRdF6kQSwKR9FeiW8q/VPv5he5YYOVoSkHOjNEDnPg57C0IJ9xIpnSkCJySzwwywmaOcx02M0KHGTjquyvRFBRAjD+6uTVuz6yrQMhpMVD1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS5PR07MB9896.eurprd07.prod.outlook.com (2603:10a6:20b:676::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 07:14:15 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7544.056; Wed, 15 May 2024
 07:14:15 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v2 07/25] intel_iommu: do not consider wait_desc as an
 invalid descriptor
Thread-Topic: [PATCH ats_vtd v2 07/25] intel_iommu: do not consider wait_desc
 as an invalid descriptor
Thread-Index: AQHappd+nTq4jyKQGUeJGP8dDaglxA==
Date: Wed, 15 May 2024 07:14:15 +0000
Message-ID: <20240515071057.33990-8-clement.mathieu--drif@eviden.com>
References: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS5PR07MB9896:EE_
x-ms-office365-filtering-correlation-id: 570e829a-6320-4080-4c50-08dc74aea144
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?M3E5dHZzLzdIT0o1eHZ3VjE2ZUExRG1TUWFBT2tiZEM5NkdlN2t5TU4vNFVa?=
 =?utf-8?B?cnV6VS94VmtSWWhWM1ptVUM1QWpaQll0VDkzN0E5MGlMZGVlQWR6NW9rVWVr?=
 =?utf-8?B?WXdSQTYzTVVGZzloTWpDS3IwNlpHY3pYTzVsZloyU0RTMk45T2lqTktkcW8y?=
 =?utf-8?B?ZmZweWlHYjdNN0FieWtvTGlCbDQxcDJwZWFZemRwQ00xalhkbVNsajhiK2NC?=
 =?utf-8?B?V3VkNWR0Nk9OYVkvL2VTZkxRS0JQenp2THU5VldjRGlvRHNiK0ZxWmpNUDIw?=
 =?utf-8?B?MVRXS2pBanB0Qi9ML2cwOGZ5dDJYTnZLbHlheG5Ed283alU4ajhucVVsbEtq?=
 =?utf-8?B?MEczbnV0RU9NTXY4OHVnUWFERnNoOVNtS2U1cTRBZ3llY1FQN296bDA2aGEy?=
 =?utf-8?B?SGJwQ0NFNHE5NWVzRFAzL2E5bkMwMWZWODAybkxIWXc4azBIMll1ZXUyTWl2?=
 =?utf-8?B?WHFpVWx6QUh0NmNxNmR6RkVRK1JtWkxidlEwdVgyS1NHTHd1NXd3R1M5RVdl?=
 =?utf-8?B?VE1NdXQ1UXNkS29wVDJFdTN3UU1jZWMyQjJ1NXdxVHBRV3hBTmo5ZW04T0Vz?=
 =?utf-8?B?elFrenZUcjE5azc2N1BkazJkQ1FOMnZQbHc3TFpHNk5kSkJzNTBiUU0xbFlx?=
 =?utf-8?B?ZEpMRFE1b2N3R2ZmUFlFQllRNWp4aVZ3MXh2ZHhRS3NEQ21ZcXpmd0puWlJy?=
 =?utf-8?B?bU5NelR0NmxOZmI0TXNXbWlZSkZxdVZWM0FsMUpMVEpiWExuV3R0MnN3ajdx?=
 =?utf-8?B?VFljNkFkVVpOSXkxd2tkWkNnUEFIa2JveEE5Y0lYQklCYi9ZT3FMeTBPSGZQ?=
 =?utf-8?B?Q083U0hxRlVjRmhGQzNHcHJBbmo0MGZjMXNkU3p4OHFlTk9DaVJvVS9zZUhn?=
 =?utf-8?B?b3VLbWc1MU5rMG00VkQ4SHllUTBQdnNRNklER1VDWXFDN3JVSGtTb0FaV2wx?=
 =?utf-8?B?UXVJaGxwTjg1YkpCVkRWQXgrUEFVeW1tYmh6SE8rNkZNdGd3dXdQZ043YVh6?=
 =?utf-8?B?ekFaenBjc3JZdm84K3h0bEJzS29SSFVXTEtHQmhYZGhSN1NHUHV3RmY3QUFk?=
 =?utf-8?B?YlhhM0N2WitDMG1lWjRTamhCVC9tS0JmRk9CRDZkYXl4ZWlhbG8wNmduMXZQ?=
 =?utf-8?B?NXBCeDArWnh2TTBrVURwK1NLVUUwQllKaHFUTmdSSmxqczArRjl1eHkzdFVt?=
 =?utf-8?B?NmRKd0NQTTNJWk80emVkMVpmM24vRUdtS3JRNHFreE1QSTBldVI1aGlQSXlw?=
 =?utf-8?B?U1RWU1FFU3hPNUNZTHlBY1BTcG1Sb3lJSnMxWW9OZUp0VTFlWS9na2Vmaksx?=
 =?utf-8?B?Uk5tdU5vZE9mQ2k3dWFjMHF1MkgreUFFaTdRWWhNOFlWN2VLc2poYlRFa2FG?=
 =?utf-8?B?NkxRcDdVZmc5TTVFMzlKK3dzOGd3SXhWQXFjdUowVG8zc2RLT2Zzd0Fxc05X?=
 =?utf-8?B?Q2RzbDg2WFQra3liaDc3am1aNnlRcThnajBhWWRpSmRndUFPQ2hKZE94ZS9z?=
 =?utf-8?B?VjNXT2ErbFMySi95NGZnK3k2eUkxUHpLSHZqb2JqRHhGR25QdE5lbjdPWDdR?=
 =?utf-8?B?K1M3M0M0UGdUeGgrWGhFNUlYamkrTUkyalkzUVlEVlpjL0pXeEkwOXlMaWY3?=
 =?utf-8?B?MllVZURsVzFEeXBhTER1TFpWSjQzRlJPOHBYbVdZYUF4MnpJaUw0RXdVMFNx?=
 =?utf-8?B?WmdvM3lJUFV3Mk5sTEJTcUJsSGRLL2lMdnZZRjZvcTcyVkIyaTVwSlc3M2py?=
 =?utf-8?Q?KG/1oqbjtW6ZCzd0uZdCzrVrjzR3+hREGZ1gSDV?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDZJRTR2OWhBYmozN2JXUFh3ZDh1S0VhRVViM1BibW9uR3BNcS9aRFdzNXFV?=
 =?utf-8?B?Sk5TQW5qajRreWp3ZmZ3OUY0SllSNkNRSDBIajZCUVg2dFhBNU95R3E0YUhW?=
 =?utf-8?B?R1kvTXdkNk1pa01EeXpjZmdRdEEwcXFsSy9pYVhkbytEaTVIcXhqZTFNc25p?=
 =?utf-8?B?czc4T2EwUnBtVm9uOGNDZmRwUUtTNDlvVkUrTlVnZUxXNkIxaSszQnlWWVVG?=
 =?utf-8?B?VG0wV2tVTlhPVjBTYldydUZUbC9PSG9LZ2s4M1VoaDJqY0U2RHc0bkxVWmh4?=
 =?utf-8?B?K1hiZGprU29OM2tsK0JwR0NMRzRXS3JsOGVUZ3BPODhFbTdTRjl2Um5TM3dU?=
 =?utf-8?B?MkUvUC9kcFN3WlIwS2NCMGVCd2FKdGRPb08wWk9UMEVOaXR2QlRDYnFQb3VM?=
 =?utf-8?B?bkNralZOWWFMRHd5b3MyVnkzN1VjWVBpVUg3VExlV3RpcjRmdGg1U2JrOEQ0?=
 =?utf-8?B?YzU3TndZRW1xcVA1bWMrb0RHN0VzMXdIOHFhbkx0UXNsYk51eUVpVWdzekx4?=
 =?utf-8?B?TnovcTVsTk9SZ1gvWS9jSldxSk8yL1I1dnVvRVNRdGptcTVuL1dYMTJMZW9k?=
 =?utf-8?B?WnlGbGdSNnVxcUl0RlhQR2FnbXNXdlJYaTdHQXFLaU95SFgwM1Mya2NKU1lT?=
 =?utf-8?B?T2xjTVo2YTRnTllvSGhtME52bzRJSEh3blZ6WWxHOVQ0aDhycFlyVjBjQkhZ?=
 =?utf-8?B?Mk9QbmtvblpwK3NFekYrbXhvak1JNDdNaG9aQW0yWU94VklkSDYxbkdrVDNR?=
 =?utf-8?B?OHRFbDBYS0E1a05OR3I3VEtCNjVSa216UWNUUW51cFJqSWRyMTlyYXRLWWhn?=
 =?utf-8?B?U1pyZGp0dUxWdk9uUTBUQXRjOHQ2NmVpK3pGNEh5dVNRS2s1YXJGV1dZWURh?=
 =?utf-8?B?OUZwcXExV1ZWN0k3NWF0WWRuSWsrRmd2bDJ2QVY1Y3Fwc0JFWC9tV0JTV2tJ?=
 =?utf-8?B?M2QrNk81Q2RkMnJsYVB4akFMaFg0NlRwMHBtelJHRkVxeDJwb2RNbVJKUHkw?=
 =?utf-8?B?a1lod3BRbnVwV1ZGRXYrRDhnVTFpN1pYMEhNcnlvVkFyRjVUMnpDRHZIRURL?=
 =?utf-8?B?VW9SY0pheS85QVFCc0hMQy9BZnRRaXJwempWOU5XT1FoS2hWWC9YNGU3Y1By?=
 =?utf-8?B?d3A3RThncC84bEEySXI5cEN5RFBCTDBXRyszZk1FbksvcXR0K053YSsyUkFk?=
 =?utf-8?B?QlkrSEdsVktBMUZSazNQYklMRXdTSXRQVy9GOWdKV2ZBR1lGY3hKT1k1bGlz?=
 =?utf-8?B?dDQrQThzTkJNVFM5aEJFeW4zRzlucW5PNFk5VDdsQzBPNzZQMGIyM1pvYVdS?=
 =?utf-8?B?SityNDBEc01RUGdLUUZxMTZ0bHNGb0dSd1o2bC9OcFlWMzBSYmVMSzhJTFAr?=
 =?utf-8?B?aU95bEV4ZXZESDBHeEdaeTdUOWdDc016aE13a0krWnFNNW83OTM4WEhhL2hv?=
 =?utf-8?B?dHgvZVJ3SFhSZkdQVDRuUTJ3RXdMZG94NkkzaHRxSUd4ZmltOTdHNkFHOW82?=
 =?utf-8?B?aVVVcU4xa3JXV2gvZVR5bW9uQm83dDVVOWR2dWgxYlMwdXQvOWF5K1pKU2JF?=
 =?utf-8?B?emg1WjR4M3RIRGRUTVc5cXBpWDBIbWF6R2IwSmFTZFpYMS91TVBXc2FaL1h4?=
 =?utf-8?B?WFVzTzhjaHpFKzU5cm9PUlBaNGxUYXovbVpuNjNmblVsekFBOEJjSklWWGky?=
 =?utf-8?B?WEM3bHI5OHl6REFRVENxVE1NTEpxUHE5RVcyWnFGSWpIWWZCMTBDeEUyK1k2?=
 =?utf-8?B?cWZsSHU4YS9kTlVOdklqNm12ZE5pMGFDVmpMS0hBb0FxOE5jRGtjdkJ0c21F?=
 =?utf-8?B?SXhYeEcxNFlFeFBJOTczd2RFUmNic3BMTld4Smg0MFNCQ0VvOGFBeXdMTXlC?=
 =?utf-8?B?ek8yMFFYMjF6QlVDL0hET0VqTHpOOUpxQ3A0d0ZWNVJ3bkErQUJYZDZra05E?=
 =?utf-8?B?WnQ3ZTFtb0NEZ1lua1FHRUJXdE80aWVWL1VRc0YwNWVsVG1Cbjg0Wkg0b3Vj?=
 =?utf-8?B?YXR1bXZQdE42MFNIdExkQUVYeFdXbWJzWVBwdFJkZ3ZqaVMxRVRLY0M3VFZU?=
 =?utf-8?B?ZXIrZHlQL0ZjRHc4c3UwT1l5bDNNbzJVQnU3aTJ5d2JoRmthdTF3aUh0Q29z?=
 =?utf-8?B?L0gwRS8wbTlkL0dxalhUeFhOcjB0MkhGbm5EU05vMmtsNXI0b005ZDVJaEFQ?=
 =?utf-8?Q?z1i4oi/T4g8g77ecYsuUB00=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC9F69ABC03705429220EB813F2EA39D@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570e829a-6320-4080-4c50-08dc74aea144
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:14:15.7896 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: olNBsh70JBWHc93Owe1We3cbfAuO8fLtMEu5iSNZ7uYKjsJz1gTnR0JILqKRaiBPp8V5BqzTIn7GTfXPHC/4PLpFxjAhOgJ6v2hFinkYVXN1itw8Lya0EQJiXhT/xIto
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB9896
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

U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQpSZXZpZXdlZC1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5k
dWFuQGludGVsLmNvbT4NCi0tLQ0KIGh3L2kzODYvaW50ZWxfaW9tbXUuYyB8IDUgKysrKysNCiAx
IGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9ody9pMzg2L2lu
dGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCmluZGV4IGRiZGYxMzQ3MGQuLjM3
M2YzZDI1NGEgMTAwNjQ0DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCisrKyBiL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYw0KQEAgLTMzNjIsNiArMzM2MiwxMSBAQCBzdGF0aWMgYm9vbCB2dGRf
cHJvY2Vzc193YWl0X2Rlc2MoSW50ZWxJT01NVVN0YXRlICpzLCBWVERJbnZEZXNjICppbnZfZGVz
YykNCiAgICAgfSBlbHNlIGlmIChpbnZfZGVzYy0+bG8gJiBWVERfSU5WX0RFU0NfV0FJVF9JRikg
ew0KICAgICAgICAgLyogSW50ZXJydXB0IGZsYWcgKi8NCiAgICAgICAgIHZ0ZF9nZW5lcmF0ZV9j
b21wbGV0aW9uX2V2ZW50KHMpOw0KKyAgICB9IGVsc2UgaWYgKGludl9kZXNjLT5sbyAmIFZURF9J
TlZfREVTQ19XQUlUX0ZOKSB7DQorICAgICAgICAvKg0KKyAgICAgICAgICogU1cgPSAwLCBJRiA9
IDAsIEZOID0gMQ0KKyAgICAgICAgICogTm90aGluZyB0byBkbyBhcyB3ZSBwcm9jZXNzIHRoZSBl
dmVudHMgc2VxdWVudGlhbGx5DQorICAgICAgICAgKi8NCiAgICAgfSBlbHNlIHsNCiAgICAgICAg
IGVycm9yX3JlcG9ydF9vbmNlKCIlczogaW52YWxpZCB3YWl0IGRlc2M6IGhpPSUiUFJJeDY0Iiwg
bG89JSJQUkl4NjQNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICIgKHVua25vd24gdHlwZSki
LCBfX2Z1bmNfXywgaW52X2Rlc2MtPmhpLA0KLS0gDQoyLjQ0LjANCg==

