Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BC6CCF2D4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 02:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xId4A-0006R5-8U; Sun, 18 Oct 2026 22:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xId47-0006LC-Tt
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 22:25:31 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xId46-0001ka-1h
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 22:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792376730; x=1823912730;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Oz5W1wjKA+Lk7xkDZILfhEf45elAzifPrQpHGfy3qxs=;
 b=ZmmXaYvmIP+TenTLi1nYpvQA1ctpa6fGRCWlUayueh3UkJthExm1ICLN
 m2WDw7nqv8cYDTlqDBqJreaqLQmAIErp/47Vh2E2GIfqvuA2mxTWOnnzF
 cYsV/RIk8OYcYxQMqrCZuexGJ6SahPX6rlLgCk/vdHRwynNjbHDkOItBZ
 bCRjh7IjZfhoezaTiHxTDp62SJztsBiY8DumNHfiXa/63O/wgwPjd10K5
 gzqD7pzg/TQl+XrG0J6UIkehaoCoOEXdFc1VAXqC54OOqGB1LL6kO7O1Z
 6n288ISvxRnDpqLW4Knu1Cczo+FMRCeskwWl4yIgnA2TIOpvwYzXVTkXH Q==;
X-CSE-ConnectionGUID: ShvMcxbYS66AYdYxkTaLeQ==
X-CSE-MsgGUID: qo1/FnMsS6G6gLkwSz5zfA==
X-IronPort-AV: E=Sophos;i="6.27,166,1786982400"; d="scan'208";a="158416765"
Received: from mail-westus3azon11010051.outbound.protection.outlook.com (HELO
 PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.51])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 19 Oct 2026 10:25:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ett8cboGNpLWHhWCoFMKH0mOsAclo6Hr9RUwuA3Kdgh7ys76KNjXxfipcD0yuLQo4CMMfoeuG5HunYv5quIM5Y85ioWlN3WEOo7Z/n1f8xFHiOW6K19SpjKQS9Uc2yhqt0qckz+PEVltj3/GCn0VRH1+nnITDsuxeGon1gs0/+iu9TUTCIjdMsCT9r9vz33ryBrVXL44dKI5xHEdUm0dPrjtl/Q63ho0oWeook+F0dkd0fYaaj0sF06nt0woq83WJ4MRKUgg9wP40dEN83dwUZmvG/znoFnidYMWy2ZsuVOcMsgSwOl90xr+yHN9PhgRJyebt/wRPBySQGr0qnuKDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oz5W1wjKA+Lk7xkDZILfhEf45elAzifPrQpHGfy3qxs=;
 b=no4NhrsMb1/P51b93wNJ/TjvxpIDdx04J5GpHYdnldPiuoYCTvrVAFuDMTQGA7Kue2UVOZmxXFSLio6ppH39kFHIyYnw+BmB+Q0gb7GEUTAFGyMbmYOI8ElN1Uuw61/J9S/+d2WtfBQD5/WpDXPVXuvdkyBOc2kQcBjS/j9DHE0vZdIxNgYmvxSYwgFEdIIJhjyDY905QzCNRm5O9coiXadTRb3szyqv3sN/tNLcQgOiEJrJDWOHewrsMnP8MnEd0LPwogKJBptEj2E1AzdgRPvc4NXm+qqBj7XuKseBaiU/l1KzE1jSVhu4SJzLj21Ij2q07ZXU5ZzLkML9IAkLOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oz5W1wjKA+Lk7xkDZILfhEf45elAzifPrQpHGfy3qxs=;
 b=Ps1Fx2wa3aicg9Ox/TdfX3YtsnUVeVa2k3cyi2MAF0w8jChu5LNEYdxfqnIcHEnP3vyv43uV+8gC9MQeWLCcHKkUnlGMt27ocYcs4jm2ftc+QmrA08793Hs+elmZVX6QXdKJ8nSFF7tEkTpyotNs8qe6mdQOAote0IdmO6pU6EA=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by MN6PR04MB9336.namprd04.prod.outlook.com (2603:10b6:208:4f1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 02:25:25 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 02:25:25 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "anjo@rev.ng" <anjo@rev.ng>
Subject: Re: [PATCH v2 3/9] test/unit/multi-target: check QOM types can be
 initialized with any target
Thread-Topic: [PATCH v2 3/9] test/unit/multi-target: check QOM types can be
 initialized with any target
Thread-Index: AQHdXcVUc/tSqx0CSUC7+YOdNzWBVrcEJqYA
Date: Mon, 19 Oct 2026 02:25:25 +0000
Message-ID: <f55ca838548174e9180d41feb1325b97aacb0183.camel@wdc.com>
References: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016232304.1215119-4-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20261016232304.1215119-4-pierrick.bouvier@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|MN6PR04MB9336:EE_
x-ms-office365-filtering-correlation-id: 46e27d3d-dff0-48fe-e2f3-08df2d883c35
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|10070799003|23010399003|1800799024|261009223027099003|10067099003|56012099006|22082099003|18002099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: qE6ntVxeSDZnMJCMNLzbJF12FQ4ZIml20sc2cFKIuUszcI9wDu0ddMcqVaXUHozOvP/BjkrnhndqrkrQwk8nzZQQx4EmMqhqO8IZMFksvDEl45OOD7S6lGY2X1uRf8Cx57V2Lp+D6sE+ZAC16Xkk54hz6iUAGNKxOCQmO8eQNP7IP5zUZt47unjzcXEMLqw91ofe21LVbtJUU5Eo/QLyxPjeSS3zF4f/0X33n8XXQ27t4XroznOb32Jesj3zciWO7GZPfLRrGNhQFZw0W7ZPYwv69NRmkDjmSgK8r1l5wEK1835rqREEn5XZAl+IXFbbuGz2Rs++1OJEMCVl9vwHIydyaP0/Sz3UJR3y0DnrQQwUdkasB7RVpMJVnkmb190Pw2o8SB+u/u8+Ujqj9jCQt6/vrmoGofdmThvo2VNZszI9LrVt2RhXC6BCi/M+iLZZyOOFhNueu5kdAHtUn4irLetZLMNpZ194i7glzost8BwYC82dXdHEALJjTs4H0JJAoFn3p+C4jTAfG7ZwkxnIG+7qXo6imfomUpNFrViSM3KBHe/7jBaVwHD3RzuOkib4TWnfBG7LzKO0WFRPBHCFxmWuFfeRMZjvYUXfjAY730Q40FWO+HSj+HkO+243FX5Jtw6+68+L13WRoC3AAIaq1Nkt7H6/DQjEe9vuoI7Df/0gEB9wfw0GmXUqge04ZkDgGZZCgix8INzkoZUFxynWRAH5OZFrvEJFf7D3Hbv7+II=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(10070799003)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3VXTUQzdU00VmZQUER6VjhYSGxhQmV5ZVdZcmpTZm05QmZ4cTU5UmxIZkpx?=
 =?utf-8?B?VE11a1ZCKzJkSGlNSFJ4NVVHc3FHa2tpdGI2b2NucTh6R3d6akVLMGQ3YVhp?=
 =?utf-8?B?K2h0WjFobTVZL0FndXlOSVBia1Y3allhRFJPckRLZnBwbmxFNkh3S1ZaVWZV?=
 =?utf-8?B?TDVLWUpWWlFDdW1ZVTNGWmlpWUI0RWRLeVYwU3V6Nk1qWmprMnhXY2RlbXJu?=
 =?utf-8?B?MHVNUzNkZGVKdDc4SmNDN3ovdGdDWUtCYzNuSHJVUDVIT055VzdXVk9ralJ6?=
 =?utf-8?B?aVVMeko1SHk5cnhvTWQxL2J4UGEwaC92NWVjeGM3UnQwZlJIUGhnZXhMeWln?=
 =?utf-8?B?azR0RlJIS2c4SW1qQjJIL3VuOFdkVXVUcTAxTTlxcUU2bWJoT0ttR05iZSt2?=
 =?utf-8?B?NnVVaVhNNi93SlROSDBuZ29FYysyMExlUFNReitZcktXZUxXSlg4ZEMxYW1a?=
 =?utf-8?B?YzdLU2pORXpTdk5tMktsczJMblNzQzBaS1lPSUNEaVlsVDcyRzF6d0xob0tC?=
 =?utf-8?B?dkJweXJ5bzR0SXF3eXZHeC9hNXNUYTJrRjBHWnh5eEk4VU15MG5TZmZkaHo0?=
 =?utf-8?B?aWw0blBrUEhtZmtzdVZMVzIyT1NqMzVkUk9xRktIeHJ5WnFKa0RwcjBQZXEz?=
 =?utf-8?B?R1NZOWhQMk5LTFd2T2FiVXlBZUIxVzhPSk81YzcydCsxbTRlWHgvRXVnTzAy?=
 =?utf-8?B?dXlSUWxhUXU1ak1tVlhlVTZoSGlEY0FUalZwbHRvMXpjRDBaUTFyekcya0NO?=
 =?utf-8?B?VlBaMGlCQnU2NmY4Tnl1TXMrQ2NPWW90VWMra25DZXlTTFgycWJUb3h6RmRL?=
 =?utf-8?B?ekhnZ204dUdGUXQyNnZGQXhHT0VubXJCTGhJenhpUTl4STlRdW5KNHR6V2Vr?=
 =?utf-8?B?Y3JlMDlSdkxuUW9zQVF1UmZsVFJ5RFd2TFVvUXNRaVM2VnV1Z2ZSYndVZDhD?=
 =?utf-8?B?KzhoK01GUTVHbFk1ZHo4MSs1Z3MzeGR4WGZOSEU5U1dMeUkzcmFGdVNqUFht?=
 =?utf-8?B?RTJQNnR3QnFkbjJGaFJBVjJZbXBseTY3QTdhaFBxZHYwWFdFUGk4YmhYdElD?=
 =?utf-8?B?QkhzU2kvQ01aR3Jib054aGUrTHNCS3pXUVJZVGdWMUdhME14SWlabC9LeEFJ?=
 =?utf-8?B?K1M2aXVPYjEyck11U04rZzJFbTBRWnB6YlU3RnFKMXM2bE9PWHJxK3ZzYjBq?=
 =?utf-8?B?UlFUZUFGK1F4MmUzc0M1TW90UnVKWEU5TGx5eDdIM29FMUsxb0RQYmRzaXli?=
 =?utf-8?B?cnNxVVJiQWwzQ09PM1RpbFZkYkltQ0t4bmh2R1lxdTJoUVcvbStrcjBscCth?=
 =?utf-8?B?WVZxeUV3SUgwSXY3TTNGS0YvNlhMcFdpK0h4dkpZK043RXZvc3ZDYVZ4MUt4?=
 =?utf-8?B?Rm0raVpYcHBSZ3hCZ0RyNkpFdFQ1V0pQaG0rOFJjRWs1M3JCc3U0VVZvZWt6?=
 =?utf-8?B?bTMybHNrZlAxb2VjSmt5cUxRRmJIVVRSY2RqMStZbWxmOExrYUx0dkx6ZUVz?=
 =?utf-8?B?dlRheDNpTVRwTUxxTERlSnlJUkNvS2NDRktpdUh1S2xvNlBicUNwQW5QeTZn?=
 =?utf-8?B?ZkRXcEJ0dGJEQWxMRWpRaDRRSytxNWJhWGFoNE1LSXozN3Z4ZGNNTDR4Vk9q?=
 =?utf-8?B?MXA0NVE4M3U0WFRLL2pKR0NFSmVNTjU2SEcrcGdIVWZHSDdaVDZTS1c5aDJ2?=
 =?utf-8?B?NnladTFHMDQ3RDBUZlhJZDN2WVU4a2ZnanprTnhVa0VGS2lvZUZxQ2hVNDUy?=
 =?utf-8?B?Zm5Bakd4dldNS3ZoU0M4QzB2RWpMQUs3WTNyOGV0NFlYZHJUZTUwWDdoZzFO?=
 =?utf-8?B?bkRMWkl1VkQvQk95YUEwVGxzZkZxeWtUakdvWVZrTmhBRE9GSERMcmkvQmMr?=
 =?utf-8?B?S2FwcWFkOHYzVHh3b2tUWXQ1VDVKaVlVd1NESUhReDFpcFBZSUs5VVU0c0ov?=
 =?utf-8?B?SW5CS0dJMFducDV1b2RLYjRaYjd5dXJ5K292WG52WExOYU5uK3lYOVRZZHNm?=
 =?utf-8?B?WkZkKy8vOXJlKzQ3TGZ2aUdma3hiSWxDNkU5VEtFeXNGcFEzSW9RdWhGbXoz?=
 =?utf-8?B?a3RpYXlIQXBidjhxZm9HZjF2VEVZamVSTkVucWhBQy9hSDhJbnMzUm00Rks4?=
 =?utf-8?B?L1VXNGk4cWd4TmZOYzNQRjBERlZiaGwrU05TbkRGVEovL09kWFZGZko3c2RW?=
 =?utf-8?B?b1IzOU8rZGdiSUdLWDlOSHVyc2EydlZYcUlkS1ptY3o3TWRhTVJCZjYvWWgz?=
 =?utf-8?B?bHc3SW9kVFdoRllkRWhTcVhxN1dIa1FLMjdoSXNKRWkyWVA2aWxoZE5jNHVH?=
 =?utf-8?B?cWlvU2VNY0ZSVzhqaVpGSzZtVDZTczJPR1k5S09ML0tkeGZhQXMwV1h0VnJU?=
 =?utf-8?Q?f9gmhubux1Ij/YUdYLbum5w8+an/H5S4p/a1dzOW6Uor9?=
x-ms-exchange-antispam-messagedata-1: bIhjX8jxIbBz+v/7SUlpy7s4Emp2qUTA8TQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <640076F9F2BC0145AE7A0735B435D155@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rp0xBwSJ7NuhR/gbp0wpKEwswLkfxtENrwBBss53ve5AesR3kHsuG7TqdrQQEHt8sL1Ey7g51Tmx+z0ZDCmCztkJ2SzETROqXrCiHAi5rcyMqlBnkccCWiKCREbPbvP4pir34n3O/hUhP2FdAFckDepz0A7PbEwIFbrFcxNyHD7o7tckYiFFFr6xEKyjHMAs2d0MWSsi4AKvJBva887f7y9pEuqxb7hDrqhRKQkVUMWxDNkuXjBwKwEpMSY+81nlxK4kLBrGLEWSs6xNDiGbWzmr88/vlQMAUj27h42/iQCHyL8ZQoiXayQXi9saoO6SbNWr5Y/TmzN656Oc5sWY/Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PMskFFLMWcaMVP4w+0Rg9syhB3dKrvRA3MwwKtm121Ib/S8cFaOgxk3blnyUTInv96298Fqa2bf/bdO1R30v/X95n7iS/OctZNZEnn45KUKDf8cRGWeQ/uaZVEeVCRNRJi5gbAJSdvghbKwrFPwB2qgk9GNA8M7SwBw7AI4Wh4Vhxg+7LfS44mlVieEkHKkuoO75vdzqs15AVxSuCVSmSjOOgiIRuKSDDi5xvxntEYnhAw0mMxkx+IlrvDyqr6rCj6trA9ii7P+65wnvGo6N0/78PWmmLWxK2H5j89XCDxpOrMnsNqg/pIkK/XFGIOmX2m42ASo085cAJBbIapq1onrbu6/YlqEGpfASjIpVCYRgzWiEONnSoo3I179xHKZY97ZiwoilxYS6CkThM9lZFe/w9oEqoEPhp4TqIoaoNeim5BgcWOhaVE675oiF5BdiNkqqLxUd1dzsSB8l13h4eQQD+zcXra6tDE8SjmObsdm6QLe18D3zO9j32Vz5pZ/HkeIj6Fx3Y/39piVLFqQTS9v3qUXW8iECnDx0l/4onuKVHfdyiBIZDx4lKfF6mPtsg8bVFKITZ836We+mGlJtUqh1vUGH9zmYE8/FDEg8f/C3sS0SFbVv25aJ6JnP2UIB
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e27d3d-dff0-48fe-e2f3-08df2d883c35
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 02:25:25.8390 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ApvaL8dkJEMjKmbyJWtmfbyzdWJ9mJ6aJ4wGnLLlsN4Fz6Xcyg0QzOBMoZHHQZJcGL44ZRl0locI8I06wEsYhoiyxh95d8hs6VoyzqzEYvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9336
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=7454c2a62=Alistair.Francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

T24gRnJpLCAyMDI2LTEwLTE2IGF0IDE2OjIyIC0wNzAwLCBQaWVycmljayBCb3V2aWVyIHdyb3Rl
Og0KPiBDdXJyZW50bHksIHdlIGFyZSBpbml0aWFsaXppbmcgUU9NIHR5cGUgYWZ0ZXIgaGF2aW5n
IHNldCB0YXJnZXQgdG8NCj4gdGhlDQo+IGZpcnN0IG9uZSBhdmFpbGFibGUuIFRoYXQncyBub3Qg
ZW5vdWdoIHRvIGNhdGNoIGNvbmZsaWN0cyBhbW9uZyB0eXBlcw0KPiB3aXRoaW4gdGFyZ2V0cy4g
SW5kZWVkLCB3ZSdsbCBtaXNzIHNvbWUgY29uZmxpY3RzIHNpbmNlIHNvbWUgdHlwZXMNCj4gYXJl
DQo+IHJlZ2lzdGVyZWQgY29uZGl0aW9ubmFsbHkgdGhyb3VnaCAuaXNfYXZhaWxhYmxlLg0KPiAN
Cj4gVG8gZW5zdXJlIGZ1bGwgY292ZXJhZ2UsIHdlIGRldGVjdCBhbGwgdGFyZ2V0cyBhdmFpbGFi
bGUsIGFuZA0KPiBnZW5lcmF0ZSBhDQo+IHN1YiB0ZXN0IGZvciBlYWNoIG9mIHRoZW0uIFRoZW4s
IHVzaW5nIGdfdGVzdF90cmFwX3N1YnByb2Nlc3MoKSwgd2UNCj4gY2FuDQo+IHJlY3Vyc2l2ZWx5
IGNhbGwgb25seSB0aGlzIHRlc3QgaW4gYSBjaGlsZHJlbiBwcm9jZXNzLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0u
Y29tPg0KDQpBY2tlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMu
Y29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoHRlc3RzL3VuaXQvdGVzdC1tdWx0aS10YXJn
ZXQuYyB8IDM0ICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+IC0tDQo+IMKgMSBm
aWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvdGVzdHMvdW5pdC90ZXN0LW11bHRpLXRhcmdldC5jIGIvdGVzdHMvdW5pdC90ZXN0
LW11bHRpLQ0KPiB0YXJnZXQuYw0KPiBpbmRleCA4OWI1NWJiMTYzMi4uYzc1NTk4MjdhMDggMTAw
NjQ0DQo+IC0tLSBhL3Rlc3RzL3VuaXQvdGVzdC1tdWx0aS10YXJnZXQuYw0KPiArKysgYi90ZXN0
cy91bml0L3Rlc3QtbXVsdGktdGFyZ2V0LmMNCj4gQEAgLTMwLDEzICszMCwyMCBAQA0KPiDCoC8q
IHN0dWIgZm9yIHN5c3RlbS9tYWluLmMgKi8NCj4gwqBpbnQgKCpxZW11X21haW4pKHZvaWQpOw0K
PiDCoA0KPiAtc3RhdGljIHZvaWQgdGVzdF9xb21fdHlwZXNfYXJlX3VuaXF1ZSh2b2lkKQ0KPiAr
c3RhdGljIHZvaWQgdGVzdF9xb21fdHlwZXNfYXJlX3VuaXF1ZShjb25zdCB2b2lkICpkYXRhKQ0K
PiDCoHsNCj4gLcKgwqDCoCBtb2R1bGVfY2FsbF9pbml0KE1PRFVMRV9JTklUX1RBUkdFVF9JTkZP
KTsNCj4gLcKgwqDCoCBnX2F1dG9wdHIoR1NMaXN0KSB0YXJnZXRzID0NCj4gb2JqZWN0X2NsYXNz
X2dldF9saXN0KFRZUEVfVEFSR0VUX0lORk8sIGZhbHNlKTsNCj4gLcKgwqDCoCBnX2Fzc2VydCh0
YXJnZXRzKTsNCj4gLcKgwqDCoCBjb25zdCBUYXJnZXRJbmZvICpmaXJzdF90aSA9IFRBUkdFVF9J
TkZPX0NMQVNTKHRhcmdldHMtPmRhdGEpLQ0KPiA+dGFyZ2V0X2luZm87DQo+IC3CoMKgwqAgdGFy
Z2V0X2luZm9fcW9tX3NldF90YXJnZXRfaW5mbyhmaXJzdF90aSk7DQo+ICvCoMKgwqAgY29uc3Qg
VGFyZ2V0SW5mbyAqdGkgPSBkYXRhOw0KPiArDQo+ICvCoMKgwqAgLyogUU9NIHR5cGVzIGNhbiBi
ZSBpbml0aWFsaXplZCBvbmx5IG9uY2UsIHNvIGRvIGl0IGluIGENCj4gc3VicHJvY2Vzcy4gKi8N
Cj4gK8KgwqDCoCBpZiAoIWdfdGVzdF9zdWJwcm9jZXNzKCkpIHsNCj4gK8KgwqDCoMKgwqDCoMKg
IC8qIHBhcmVudCBwcm9jZXNzIHBhdGggLSByZXNwYXduIHRoaXMgZXhhY3QgdGVzdCBwYXRoICov
DQo+ICvCoMKgwqDCoMKgwqDCoCBnX3Rlc3RfdHJhcF9zdWJwcm9jZXNzKE5VTEwsIDAsDQo+IEdf
VEVTVF9TVUJQUk9DRVNTX0lOSEVSSVRfU1RERVJSKTsNCj4gK8KgwqDCoMKgwqDCoMKgIGdfdGVz
dF90cmFwX2Fzc2VydF9wYXNzZWQoKTsNCj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4gK8Kg
wqDCoCB9DQo+ICvCoMKgwqAgLyogY2hpbGQgcHJvY2VzcyBwYXRoICovDQo+ICsNCj4gK8KgwqDC
oCB0YXJnZXRfaW5mb19xb21fc2V0X3RhcmdldF9pbmZvKHRpKTsNCj4gwqANCj4gwqDCoMKgwqAg
LyogcmVnaXN0ZXIgYWxsIHR5cGVzICovDQo+IMKgwqDCoMKgIG1vZHVsZV9jYWxsX2luaXQoTU9E
VUxFX0lOSVRfUU9NKTsNCj4gQEAgLTQ3LDcgKzU0LDE4IEBAIHN0YXRpYyB2b2lkIHRlc3RfcW9t
X3R5cGVzX2FyZV91bmlxdWUodm9pZCkNCj4gwqBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFy
Z3YpDQo+IMKgew0KPiDCoMKgwqDCoCBnX3Rlc3RfaW5pdCgmYXJnYywgJmFyZ3YsIE5VTEwpOw0K
PiAtwqDCoMKgIGdfdGVzdF9hZGRfZnVuYygiL211bHRpLXRhcmdldHMvcW9tLXR5cGVzLWFyZS11
bmlxdWUiLA0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRlc3RfcW9t
X3R5cGVzX2FyZV91bmlxdWUpOw0KPiArDQo+ICvCoMKgwqAgbW9kdWxlX2NhbGxfaW5pdChNT0RV
TEVfSU5JVF9UQVJHRVRfSU5GTyk7DQo+ICvCoMKgwqAgZ19hdXRvcHRyKEdTTGlzdCkgdGFyZ2V0
cyA9DQo+IG9iamVjdF9jbGFzc19nZXRfbGlzdF9zb3J0ZWQoVFlQRV9UQVJHRVRfSU5GTywNCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBmYWxzZSk7DQo+ICvCoMKgwqAgZ19hc3NlcnQodGFyZ2V0cyk7DQo+ICvCoMKgwqAg
Zm9yIChHU0xpc3QgKmVsZW0gPSB0YXJnZXRzOyBlbGVtOyBlbGVtID0gZWxlbS0+bmV4dCkgew0K
PiArwqDCoMKgwqDCoMKgwqAgY29uc3QgVGFyZ2V0SW5mbyAqdGkgPSBUQVJHRVRfSU5GT19DTEFT
UyhlbGVtLT5kYXRhKS0NCj4gPnRhcmdldF9pbmZvOw0KPiArwqDCoMKgwqDCoMKgwqAgZ19hdXRv
ZnJlZSBjaGFyICpwYXRoID0NCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ19zdHJkdXBfcHJp
bnRmKCIvbXVsdGktdGFyZ2V0cy9xb20tdHlwZXMtYXJlLQ0KPiB1bmlxdWUvJXMiLA0KPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRpLT50
YXJnZXRfbmFtZSk7DQo+ICvCoMKgwqDCoMKgwqDCoCBnX3Rlc3RfYWRkX2RhdGFfZnVuYyhwYXRo
LCB0aSwgdGVzdF9xb21fdHlwZXNfYXJlX3VuaXF1ZSk7DQo+ICvCoMKgwqAgfQ0KPiArDQo+IMKg
wqDCoMKgIHJldHVybiBnX3Rlc3RfcnVuKCk7DQo+IMKgfQ0K

