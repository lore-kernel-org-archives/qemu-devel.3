Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA4DC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCXo-00065r-Pk; Wed, 15 Jan 2025 18:11:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=103277e90=wilfred.mallawa@wdc.com>)
 id 1tYCXl-00065a-U5; Wed, 15 Jan 2025 18:11:26 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=103277e90=wilfred.mallawa@wdc.com>)
 id 1tYCXj-0002Yq-3b; Wed, 15 Jan 2025 18:11:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1736982682; x=1768518682;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=FxIPv82UZibCAmTAXyKFC9LPqRmDH6bSFLo92pINE/k=;
 b=etCBoiOQJjrF//rDm/YMfNNod/WFBexM4MOj3PL3sRO9hu40Fnaxg49s
 hUvIh8Elh/KHJ6mtpQD5goQlCfyT+kf9q4XydL6dxCeBceRjAMYRbKLFQ
 KL6pC/Z9u/kYUzZI18jI3vELazeFXwnoONpV2lrUlhg+AhgSAS2rg281l
 JZsF8bSgNx0Ph6L+/zir37AyxWfP+UfjIAbT+340/lHDTBDrg7Q6cNSz6
 0SNQ3Tn51H//hOlrD6aVWWe1v+IX1MokCE1OsBIjEyFeyhYaEQQOlaQ3h
 OzFMYCnK/KHBhXGvIgzFXjHN83tJtdjZ1qeYIh+2yWOYztbokJ3lEom/f Q==;
X-CSE-ConnectionGUID: UUTezQPOSrS4a6jgH50KrQ==
X-CSE-MsgGUID: KDz7dCmCQri+qtNiTIul1A==
X-IronPort-AV: E=Sophos;i="6.13,207,1732550400"; d="scan'208";a="35808126"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
 by ob1.hgst.iphmx.com with ESMTP; 16 Jan 2025 07:11:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oi+BR8GsE6W6IUwoH9XVGorFiaDtA+SgLx2bOK6GkrMXoDlSfFtK2Poo5aA3R7YBwmnLOfIEY9cFhnjebf/fQgFPHmSObEi03FepParQE+4Be8Odfis/WeriHMiN8o3jyDqCjEuCcZiosgdliCoHDPq8p2Ls815tMWpH3TcfcoYkTQs51DDeKyoxVoOKp8BjRI4e3LE5LDV+fUzXxm5p3umA48vdoYL91mpX59uwtOwCjl8fJtFBy8UCVXGAqW2TvlIdJKb8Ac3Yy6nJfXTXm58Z1Ue6pHeLencldT3Kpyhqwjk+xfQYkQTNpMVT+6RIJdbj/cYR0o4W5IRgJDpFaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxIPv82UZibCAmTAXyKFC9LPqRmDH6bSFLo92pINE/k=;
 b=tdJwDaAsNrQc3MxK6w0HKwxkGDZy/NinirhzCqoHapk9ZfLoy5kLcpqWn0GE8DXYDDJhD/3cS26WjlcXT2CUsXX4B8bBsxeCvjMi+GkyDBI2MtGNI6XeunYgRTJYGi7ZXyKzCTMcFKutptqvLEw6eId5ifW5GswhWJbW5JzAaOtAi4DcLatN7tbLSYR8hw7h028NJM483nm/rKrohCujYKD8ObxgDwacJiNlmj1p/GPVmfOAwg9okbsc1VSQFN0m1y3RfpBdGvl67ySCLjVOZu2tR+5VwvbMhJRiRQv7MXOayFwSYSAcocw8dX1nzqsXgIFJvLdCWjOSsEz1ASSpfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxIPv82UZibCAmTAXyKFC9LPqRmDH6bSFLo92pINE/k=;
 b=e3n39iDNRYZr//0NAi9PukIAbVzFvHGFKh+r5444LxyblrJUVLca47Bfq6Eb14MXMay2DSUxDV9DEd19NBgu8j0oLEC872r+0XjD83lExqP6mbhWjOpZIdHfAwkAooKJgq21xR0PiDIk7JBU6UvpFrlKjK+8NQ8l8RBsh+Vv2Tw=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by SA1PR04MB8221.namprd04.prod.outlook.com (2603:10b6:806:1e4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Wed, 15 Jan
 2025 23:11:13 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%6]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 23:11:13 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "alistair23@gmail.com" <alistair23@gmail.com>
CC: "its@irrelevant.dk" <its@irrelevant.dk>, "hreitz@redhat.com"
 <hreitz@redhat.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "stefanha@redhat.com"
 <stefanha@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "foss@defmacro.it"
 <foss@defmacro.it>, "philmd@linaro.org" <philmd@linaro.org>,
 "kwolf@redhat.com" <kwolf@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>
Subject: Re: [RFC 1/4] spdm-socket: add seperate send/recv functions
Thread-Topic: [RFC 1/4] spdm-socket: add seperate send/recv functions
Thread-Index: AQHbYNI5X2MsXUJtqEG7FuaKWnmy9rMXKLIAgAFbMgA=
Date: Wed, 15 Jan 2025 23:11:13 +0000
Message-ID: <9792472e2e70f115b69fba8149070d0020d5bd15.camel@wdc.com>
References: <20250107052906.249973-2-wilfred.mallawa@wdc.com>
 <20250107052906.249973-4-wilfred.mallawa@wdc.com>
 <CAKmqyKOE+_7sq4zpCPjymaQZ9TV=+8owVKOyPO3wPeGovY9TUQ@mail.gmail.com>
In-Reply-To: <CAKmqyKOE+_7sq4zpCPjymaQZ9TV=+8owVKOyPO3wPeGovY9TUQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|SA1PR04MB8221:EE_
x-ms-office365-filtering-correlation-id: 40e20251-ea31-4c4a-9e6d-08dd35b9e7dc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?aXBIVXJZd0xNaEJNTlAxRHh5aGZUcXNmaXVSU0NQSlkrblJ5dHhEQTBDRzBX?=
 =?utf-8?B?bVdhM1d2MnFpV2Y5Z1l1Myt2OUpPVjBmVkxteGZjeW1LVFVZcW5wa1NTOTlm?=
 =?utf-8?B?dWRSd2xSeWNKMFVUL1dqdXdhcjhtdk9tOTBKb3B5elZWZkVFSUkyQWN0WFQw?=
 =?utf-8?B?bGNYVEJiV0dIOUhXeWwxQXJPd1ZnMjRzYUpyVHdlVG9hbXF6YUx5ZzVSblRm?=
 =?utf-8?B?aDNidkh5L3A5M2Y1Z2kyZEJLZDZZT0NubWRrdFMxaUZWVzZQY1RzRFJMZ1Fa?=
 =?utf-8?B?YytHbXdrR2JLSTZjVmR6VHpiRFpEU1ZRM0k3MC82N0EyWkQxeFJSYUZIN1U0?=
 =?utf-8?B?TXlWNGlGNExMQXZTVjdzUGtPNFA1QzNyWTV3MWZGaWgxaWJUa2JqenAzT1Vx?=
 =?utf-8?B?cWhzRTVBbXJ2T1hsdE1IWjZQTVBqOGV3SnFLNWI5dkZYWDlrcmlBMU1jVkxp?=
 =?utf-8?B?NWFSdzg4eVM3OGxNTDdsUlpqWU41S29BR3Myd3lzVTNlRnIxZ0xMT1kyZnNw?=
 =?utf-8?B?bVRFTXJFSWk0MHh1NDZNUjZ2MXFuSm00NERFVzlzUEhmT0o4Tk5tcW1EeVVp?=
 =?utf-8?B?MUgySkQvOXRuZGZ1TG56c3ZuTHBFMnNSbnY4OVJCaEhQT2VJN3JjbUZGN0Zn?=
 =?utf-8?B?MGNDM1pSQURYcFNHVDZPMDlKU00xNHdWUWVHZnB3NERqUmJCMnlreFNzeERC?=
 =?utf-8?B?YWpDMTZaSVViUzVWeExUVE9HVlZrZzBicXcyTUJ0U09FVFJ6dGNoRjVzejhC?=
 =?utf-8?B?dHNYT0YyVkFNVHFnZ00rbVNWN0l6WUxuTU9MaEtSR0ZFbjg2UUcxYnNoOTYy?=
 =?utf-8?B?dXljUTVmaGJiajA1Ky9abVR5d05scXpIWE83Q2ZSb3JvYjMzdXRLZ2dSL2FT?=
 =?utf-8?B?K081QVBpbnVpUVpyMVU5aUlOQlJTNjFoYVBnS3hZTE1GelhLRjcwUEdTMTYy?=
 =?utf-8?B?WUIxcG1iYWwxYVpybVdjUHRuVlpMTTl2WUZtZmJ1Y0lZeGUxa3owYUo1c1Vk?=
 =?utf-8?B?R3NNaFFiRjNnYXFTUnFCdlRRWHBGMGpDTW9vV1MwYmpXa013emVlaXZUaVdF?=
 =?utf-8?B?cEpzZ3lIeStnRytDcFoxOVczZE8xY1dsL2xJZ3pxZUFuTm5SMmk4QTExWUg4?=
 =?utf-8?B?K1JjLzVPOU5neUVMOHZmMXNmbTJQRGNTR0RhT05wVGtGbVhocUNwWjdnOGtC?=
 =?utf-8?B?R2JRelRwOHpQcnVLenVOa0E0ZEtoOXVESzZKMER6Y0M5ODRka01aU3Z5Rzh1?=
 =?utf-8?B?OGw1YmpXMzdDQ1U0bUE2WktjY2FCWTRMSHN1WmZvQkJoa09wb1hzUnVsWHRJ?=
 =?utf-8?B?SGp6akJsVkVGeWN6YWhtaUFhSTFUbkdwWEtUSjUxYnF4VjE5SGE4VU40cC9y?=
 =?utf-8?B?aUtWdjY2Wm5acHEwZ0tnYnRNQVNLTFNYdnhxUVozM3FMSW4yNmRuUXFJS2FZ?=
 =?utf-8?B?WmJqbGJCNXBUWDZFQXJUNktDd3pjenRMeDFMKzgyYXpOdVNwU1VqUzc0WmZn?=
 =?utf-8?B?RUwzVUhjU0UrYURWQzZQU1ArNDVWUWFUbzBxUDFJbHJ2WmFQQVRLUDRqb1Ey?=
 =?utf-8?B?ejZHWGdzSHJaaThzRGpNVUdEY3NRY2kxL1ZxSVpYT3A5Q29wMmpzQ1ZvUUxN?=
 =?utf-8?B?bjdjSzkrVnZ4QitBek1XVSs5M2Q0OEV3QXlBT1pGTUxvTEs1TjJDeUNNY0hz?=
 =?utf-8?B?NGtOc2RwdVI4dStIcTFuUkxTZzdvcStnbmpzVHJQWEdOT05zQUxSVkF5SGNY?=
 =?utf-8?B?dU5pNmR6YjJDNTkvY3hweU1HSGt2Vk5SdVJiRm5LSkpFQ3pWaXhpbm8zLzlu?=
 =?utf-8?B?dXE1eDc3bG9YVjRLMnVoZ0hTczVkaWVJenJldEFJaEZvSTV6K0cvd0NhVnZU?=
 =?utf-8?B?c1c5WU9WblZMaGZTeExOaEdWZVFBcWgwaFovRUJVV3R1OHU4Ri9NMS9HeGJU?=
 =?utf-8?Q?b+MRACJFxcCilD2U3eKtG94IDM0EYGIu?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR04MB8549.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTM3WnNVQTl0dHNOSkVHLytpV29sL0xaUGNJczRYSWVPT2lMOVdvek9ia09N?=
 =?utf-8?B?NS9hc0Y5U3AyaEEyK1BiVHl1S3FFdWlteWdCSUQ4cDlzbjhSdmYxNEVJdTdE?=
 =?utf-8?B?eEhoekR1d1RjY1duSXY5SFNJOUt0aUpjV3crWW5pQlRRZU5DNm5ITG04ZmFL?=
 =?utf-8?B?QW1hMElMNklHUlRmbUd6QjVyOVZRL2dpcFJHUG9QbzFCalN1WU5mZXliRzMy?=
 =?utf-8?B?eVBXeE1zLzNPOWRJaU1KLzY4WWc4MHNkb054VjhNMC9FZE9lYjRNcFhUcFA4?=
 =?utf-8?B?T3pUdEgrYkU0M3M4VmtIL1VNazFETElQNXh6VTRTdVFJS1QxdDk2cVllTWhW?=
 =?utf-8?B?byt5My9aYldObFV3WGljcUJVdWxwZXBmbjNHUGpLeTRxWVQyYk92L0lwcHNE?=
 =?utf-8?B?Q2I3VXYxUncrZ1JHN0ZhaXlRVEl0N1NMZ2JmaGJ1K0MweE03U0pGT2grNzN4?=
 =?utf-8?B?OG5RYnlnRnAydGZEald4bGY2MlV1TGNBWTJ5UVBNbmxLYitXMEtwaXRrRnlU?=
 =?utf-8?B?d0UxbzE4OE1tZE1COCthdTZxNnU3UHVKMXVBempuQXlVNklOK0hWTEtNQmFL?=
 =?utf-8?B?UXNBUjE2TXdMODlCcFhpdGRpN3VCRzlyQW82enM2NDl2NkUrZGthNXdOQVox?=
 =?utf-8?B?VUVzcU9Xb3VFZ3ppVlBXdzFFQUFjOXhtSUM0Rk9nR1VtMWZKdm8zcXRZL29W?=
 =?utf-8?B?SDhwemVteWVhNzRuU21IVnBubmZNRURZb3I0aVYzNDQ4ZTNPWjNiMlBsd0V6?=
 =?utf-8?B?QjJ0ZThRSTNVM1FycVdnbllJdG1lSVh5TXB5R0J5eEhVK2NrRzJwNUNWSkhk?=
 =?utf-8?B?VEs0ZGhKcEFrcWsrN1RlNnQvMHFqbW1IYWVBdkQvZjBWOWRuY1pnNzJER2pa?=
 =?utf-8?B?YkdwWTV2NE5LWGltaE5qUzJDTlE2ZnhEaHk4MVlJMmRPeURCRzIzNTM3blND?=
 =?utf-8?B?ZnVON01oYnRSZVlzcmEyTTRDSzd4Wk1yTHRQRml5dGQyL2JUdzEzUWVSU0lw?=
 =?utf-8?B?eVVvMjlNWHczR1BCSXlmS2dub0lML0oxWVNtUzZVaUJVbDV3NnRYTUVqQ29y?=
 =?utf-8?B?b1ZBMHk2eXNKM1pMcVEvbFBDU2RHTnV0eXh4dTR2R0IyT3lXeHZqeUd3dnBx?=
 =?utf-8?B?T3JaOXdqTFJNcUdLc2VDK0R2aWlmNElFWU13Z2FqUDZZSHVwS2IwZmpUYzNu?=
 =?utf-8?B?SldYZ0hnUmRHd2VWWXAxS1BLYno2eVBDUFJaaWhaRncraE51cDd6eVJCbWhZ?=
 =?utf-8?B?QTd0K2hqRi9SZUNGcm05ckhHV3I3ckhFdUYvTWVteFpNM0JweHVzZ21ZcDE1?=
 =?utf-8?B?YkFvY2RTaFN2bGhuaEpBbWZKN0VmRXc1Mmc0aUN2YkVaZktzbmJWeGcxVFdw?=
 =?utf-8?B?b1VDNENkOUtkSUY2RlAzclU3SUFYaGI1MStCNnlhVUxoV2F6YVNrZHMyd3Jw?=
 =?utf-8?B?TGhoNXNXK283UlR6UkdiYThzTks0YzNTNmtqZEtHeHNHay9BWFFUZCtqRG1E?=
 =?utf-8?B?b2gzSGpHV1Y3cDlLenBBUy9xK3lkbFVkcHZyUVRpM25OU1NIcDNKV3JFZU9h?=
 =?utf-8?B?Z1UrdC9HMWxOZS9rNWdDeGhydEhqcWxNVGYweFJPcmQzQjJCVFJtYnQ4TlVE?=
 =?utf-8?B?eEVDNUZMUzdjUXBuUnRzOVk4TkFJb09aK3BXT1VNMUJ0R2crOTl0NERSY3Vx?=
 =?utf-8?B?ZmFDRTAyRThKSkl5MXgyZnlNQ0JZZTB3cVk2RGVyUjhtVVZ5OWRLOXFjRjZr?=
 =?utf-8?B?K0oxejlmZlVSTHdrTy9LRWgvTzF1c1V3M1JhZjRFT0NxdUEvaGdsVEE3ck43?=
 =?utf-8?B?TEZtUTBzUnRRaVdzS0lUK3RLZ1g5QlRtd0xQdFhFOFlVYXpvRVpOZjh6Wmxy?=
 =?utf-8?B?eU5RNEpVUXgwQzF1TE5McFUrQWkvYXdPRGh2TFNvTmttRHpIY0lPOGg0ODBY?=
 =?utf-8?B?UzlwQ2tHL0oxYkEwVkZJZlRlQkNHeGE4NVZoSjJUeXZ0WGdTeTNyd001R21L?=
 =?utf-8?B?T2k4cGZIQ0tlbHQ2a1N4L1RDbzVjM3hJWC9sSksrS2FBUDNpSTJlS3U3QnR1?=
 =?utf-8?B?UDY0UFZoaEZTM2Z2VVlmTlpXRFMwbElpbGxIVGphUzVXaFRtSFZzOFdId2o0?=
 =?utf-8?B?eDFnWGxPVWhxTkJnbTdta2pKSHhnNWdtNHlnMGx1RG9sa0tDVnFaeDA0aXRj?=
 =?utf-8?B?dFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43681C4480586F48BD9F376E5241AB3C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5Kyrp+f+g+CJKW4Pw1fWa0q15WIBKb2DJOrajcMCEYWnGPzXfipfVTv1gNVvjThqpbgQYj6mjzMixp1yWrCGqVwFqnGGWfCqn8WXe9bZL2FdU9SoLLd1k0+o4Mmmz40cBd2u63fP7R821e/1CkhakKujtosEq+ljSETe2JuwrQUqZn9hZ8qWLmWNfba4oP4xurMbp4T9tjtofy0h/3DQcSQangX2xSJS2Toed8ls9ZO7Y5Q+VFxIEdURIGdHoaJLrlHWVHbu82MeQCc6norNJ4kZg6o9Rd9hxxInqtSbvhPQnJzryAVnKi3twi/0BuyO17i6JBfve+NrDEJGdIPc3boZbN9a+A2/HqePT+H3Ag3MZzmibFNZbHxygDwBGCU+BQGSuiozvkNO/7yrUt7gwXLGvqUdW5HNaRQFvUYYFfihlQd+PTi2x4w92lFmHKpPwbxfaKvdIb7CuUX0FZ3xZUSmiJXTYFwGjephHZ2QJs6yjsMGTRZBkDnmOK64sJ+9VsbGaAguywagNmEWFTIEdiXtrvd3q757vmaI+whMes0XYezqQ7o3u+E0Yona3S6GAYF/Jo6KGTPSt8tzs5cLFsjR+aBGEpDMp+4hP0ilnhEC4wu7gESoYzghGMDqjovk
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e20251-ea31-4c4a-9e6d-08dd35b9e7dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 23:11:13.1639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +SjaL5bzlSFLqMRoz5lxWjl1TnKtEFkyyrc097AVnzG2h+1tsz17wGNoxKCyAcEKscCvAfZ4tK1gKJUMGdqBTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8221
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=103277e90=wilfred.mallawa@wdc.com; helo=esa6.hgst.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

T24gV2VkLCAyMDI1LTAxLTE1IGF0IDEyOjI4ICsxMDAwLCBBbGlzdGFpciBGcmFuY2lzIHdyb3Rl
Og0KPiBPbiBXZWQsIEphbiA4LCAyMDI1IGF0IDEyOjA04oCvQU0gV2lsZnJlZCBNYWxsYXdhIHZp
YQ0KPiA8cWVtdS1kZXZlbEBub25nbnUub3JnPiB3cm90ZToNCj4gPiANCj4gPiBUaGlzIGlzIHRv
IHN1cHBvcnQgdW5pLWRpcmVjdGlvbmFsIHRyYW5zcG9ydHMgc3VjaCBhcyBTUERNDQo+ID4gb3Zl
ciBTdG9yYWdlLiBBcyBzcGVjaWZpZWQgYnkgdGhlIERNVEYgRFNQMDI4Ni4NCj4gPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBXaWxmcmVkIE1hbGxhd2EgPHdpbGZyZWQubWFsbGF3YUB3ZGMuY29tPg0K
PiA+IC0tLQ0KPiA+IMKgYmFja2VuZHMvc3BkbS1zb2NrZXQuY8KgwqDCoMKgwqDCoCB8IDI1ICsr
KysrKysrKysrKysrKysrKysrKysrKysNCj4gPiDCoGluY2x1ZGUvc3lzdGVtL3NwZG0tc29ja2V0
LmggfCAzNQ0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gwqAy
IGZpbGVzIGNoYW5nZWQsIDYwIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEv
YmFja2VuZHMvc3BkbS1zb2NrZXQuYyBiL2JhY2tlbmRzL3NwZG0tc29ja2V0LmMNCj4gPiBpbmRl
eCAyYzcwOWM2OGM4Li40NDIxYjVjNTMyIDEwMDY0NA0KPiA+IC0tLSBhL2JhY2tlbmRzL3NwZG0t
c29ja2V0LmMNCj4gPiArKysgYi9iYWNrZW5kcy9zcGRtLXNvY2tldC5jDQo+ID4gQEAgLTE4NCw2
ICsxODQsMzEgQEAgaW50IHNwZG1fc29ja2V0X2Nvbm5lY3QodWludDE2X3QgcG9ydCwgRXJyb3IN
Cj4gPiAqKmVycnApDQo+ID4gwqDCoMKgwqAgcmV0dXJuIGNsaWVudF9zb2NrZXQ7DQo+ID4gwqB9
DQo+ID4gDQo+ID4gK3VpbnQzMl90IHNwZG1fc29ja2V0X3JlY2VpdmUoY29uc3QgaW50IHNvY2tl
dCwgdWludDMyX3QNCj4gPiB0cmFuc3BvcnRfdHlwZSwNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdm9pZCAqcnNwLCB1aW50MzJf
dCByc3BfbGVuKQ0KPiA+ICt7DQo+ID4gK8KgwqDCoCB1aW50MzJfdCBjb21tYW5kOw0KPiA+ICvC
oMKgwqAgYm9vbCByZXN1bHQ7DQo+ID4gKw0KPiA+ICvCoMKgwqAgcmVzdWx0ID0gcmVjZWl2ZV9w
bGF0Zm9ybV9kYXRhKHNvY2tldCwgdHJhbnNwb3J0X3R5cGUsDQo+ID4gJmNvbW1hbmQsDQo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICh1aW50OF90ICopcnNwLCAmcnNwX2xlbik7DQo+ID4gKw0KPiA+ICvCoMKg
wqAgaWYgKCFyZXN1bHQpIHsNCj4gPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7DQo+ID4gK8Kg
wqDCoCB9DQo+ID4gKw0KPiA+ICvCoMKgwqAgYXNzZXJ0KGNvbW1hbmQgIT0gMCk7DQo+IA0KPiBU
aGlzIHNob3VsZCByZXR1cm4gYW4gZXJyb3IgaW5zdGVhZCBvZiBhc3NlcnQNCj4gDQo+ID4gKw0K
PiA+ICvCoMKgwqAgcmV0dXJuIHJzcF9sZW47DQo+ID4gK30NCj4gPiArDQo+ID4gK2Jvb2wgc3Bk
bV9zb2NrZXRfc2VuZChjb25zdCBpbnQgc29ja2V0LCB1aW50MzJfdCBzb2NrZXRfY21kLA0KPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3QgdHJh
bnNwb3J0X3R5cGUsIHZvaWQgKnJlcSwgdWludDMyX3QNCj4gPiByZXFfbGVuKQ0KPiA+ICt7DQo+
ID4gK8KgwqDCoCByZXR1cm4gc2VuZF9wbGF0Zm9ybV9kYXRhKHNvY2tldCwgdHJhbnNwb3J0X3R5
cGUsDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgc29ja2V0X2NtZCwgcmVxLCByZXFfbGVuKTsNCj4gPiArfQ0KPiA+ICsNCj4g
PiDCoHVpbnQzMl90IHNwZG1fc29ja2V0X3JzcChjb25zdCBpbnQgc29ja2V0LCB1aW50MzJfdA0K
PiA+IHRyYW5zcG9ydF90eXBlLA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHZvaWQgKnJlcSwgdWludDMyX3QgcmVxX2xlbiwNCj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2b2lkICpyc3As
IHVpbnQzMl90IHJzcF9sZW4pDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvc3lzdGVtL3NwZG0t
c29ja2V0LmggYi9pbmNsdWRlL3N5c3RlbS9zcGRtLQ0KPiA+IHNvY2tldC5oDQo+ID4gaW5kZXgg
NWQ4YmQ5YWE0ZS4uMmI3ZDAzZjgyZCAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL3N5c3RlbS9z
cGRtLXNvY2tldC5oDQo+ID4gKysrIGIvaW5jbHVkZS9zeXN0ZW0vc3BkbS1zb2NrZXQuaA0KPiA+
IEBAIC01MCw2ICs1MCwzNSBAQCB1aW50MzJfdCBzcGRtX3NvY2tldF9yc3AoY29uc3QgaW50IHNv
Y2tldCwNCj4gPiB1aW50MzJfdCB0cmFuc3BvcnRfdHlwZSwNCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2b2lkICpyZXEsIHVpbnQzMl90IHJl
cV9sZW4sDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdm9pZCAqcnNwLCB1aW50MzJfdCByc3BfbGVuKTsNCj4gPiANCj4gPiArLyoqDQo+ID4g
KyAqIHNwZG1fc29ja2V0X3JzcDogUmVjZWl2ZSBhIG1lc3NhZ2UgZnJvbSBhbiBTUERNIHNlcnZl
cg0KPiA+ICsgKiBAc29ja2V0OiBzb2NrZXQgcmV0dXJuZWQgZnJvbSBzcGRtX3NvY2tldF9jb25u
ZWN0KCkNCj4gPiArICogQHRyYW5zcG9ydF90eXBlOiBTUERNX1NPQ0tFVF9UUkFOU1BPUlRfVFlQ
RV8qIG1hY3JvDQo+ID4gKyAqIEByc3A6IHJlc3BvbnNlIGJ1ZmZlcg0KPiA+ICsgKiBAcnNwX2xl
bjogcmVzcG9uc2UgYnVmZmVyIGxlbmd0aA0KPiA+ICsgKg0KPiA+ICsgKiBSZWNlaXZlcyBhIG1l
c3NhZ2UgZnJvbSB0aGUgU1BETSBzZXJ2ZXIgYW5kIHJldHVybnMgdGhlIG51bWJlcg0KPiA+IG9m
IGJ5dGVzDQo+ID4gKyAqIHJlY2VpdmVkIG9yIDAgb24gZmFpbHVyZS4gVGhpcyBjYW4gYmUgdXNl
ZCB0byByZWNlaXZlIGEgbWVzc2FnZQ0KPiA+IGZyb20gdGhlIFNQRE0NCj4gPiArICogc2VydmVy
IHdpdGhvdXQgc2VuZGluZyBhbnl0aGluZyBmaXJzdC4NCj4gPiArICovDQo+ID4gK3VpbnQzMl90
IHNwZG1fc29ja2V0X3JlY2VpdmUoY29uc3QgaW50IHNvY2tldCwgdWludDMyX3QNCj4gPiB0cmFu
c3BvcnRfdHlwZSwNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgdm9pZCAqcnNwLCB1aW50MzJfdCByc3BfbGVuKTsNCj4gPiArDQo+
ID4gKy8qKg0KPiA+ICsgKiBzcGRtX3NvY2tldF9yc3A6IFNlbmRzIGEgbWVzc2FnZSB0byBhbiBT
UERNIHNlcnZlcg0KPiA+ICsgKiBAc29ja2V0OiBzb2NrZXQgcmV0dXJuZWQgZnJvbSBzcGRtX3Nv
Y2tldF9jb25uZWN0KCkNCj4gPiArICogQHNvY2tldF9jbWQ6IHNvY2tldCBjb21tYW5kIHR5cGUg
KG5vcm1hbC9pZl9yZWN2L2lmX3NlbmQNCj4gPiBldGMuLi4pDQo+ID4gKyAqIEB0cmFuc3BvcnRf
dHlwZTogU1BETV9TT0NLRVRfVFJBTlNQT1JUX1RZUEVfKiBtYWNybw0KPiA+ICsgKiBAcmVxOiBy
ZXF1ZXN0IGJ1ZmZlcg0KPiA+ICsgKiBAcmVxX2xlbjogcmVxdWVzdCBidWZmZXIgbGVuZ3RoDQo+
ID4gKyAqDQo+ID4gKyAqIFNlbmRzIHBsYXRmb3JtIGRhdGEgdG8gYSBTUERNIHNlcnZlciBvbiBz
b2NrZXQsIHJldHVybnMgdHJ1ZSBvbg0KPiA+IHN1Y2Nlc3MuDQo+ID4gKyAqIFRoZSByZXNwb25z
ZSBmcm9tIHRoZSBzZXJ2ZXIgbXVzdCB0aGVuIGJlIGZldGNoZWQgYnkgdXNpbmcNCj4gPiArICog
c3BkbV9zb2NrZXRfcmVjZWl2ZSgpLg0KPiA+ICsgKi8NCj4gPiArYm9vbCBzcGRtX3NvY2tldF9z
ZW5kKGNvbnN0IGludCBzb2NrZXQsIHVpbnQzMl90IHNvY2tldF9jbWQsDQo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCB0cmFuc3BvcnRfdHlw
ZSwgdm9pZCAqcmVxLCB1aW50MzJfdA0KPiA+IHJlcV9sZW4pOw0KPiA+ICsNCj4gPiDCoC8qKg0K
PiA+IMKgICogc3BkbV9zb2NrZXRfY2xvc2U6IHNlbmQgYSBzaHV0ZG93biBjb21tYW5kIHRvIHRo
ZSBzZXJ2ZXINCj4gPiDCoCAqIEBzb2NrZXQ6IHNvY2tldCByZXR1cm5lZCBmcm9tIHNwZG1fc29j
a2V0X2Nvbm5lY3QoKQ0KPiA+IEBAIC02MCw2ICs4OSw5IEBAIHVpbnQzMl90IHNwZG1fc29ja2V0
X3JzcChjb25zdCBpbnQgc29ja2V0LA0KPiA+IHVpbnQzMl90IHRyYW5zcG9ydF90eXBlLA0KPiA+
IMKgdm9pZCBzcGRtX3NvY2tldF9jbG9zZShjb25zdCBpbnQgc29ja2V0LCB1aW50MzJfdCB0cmFu
c3BvcnRfdHlwZSk7DQo+ID4gDQo+ID4gwqAjZGVmaW5lIFNQRE1fU09DS0VUX0NPTU1BTkRfTk9S
TUFMwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4MDAwMQ0KPiA+ICsjZGVmaW5lIFNQ
RE1fU09DS0VUX1NUT1JBR0VfQ01EX0lGX1NFTkTCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDAwMDIN
Cj4gPiArI2RlZmluZSBTUERNX1NPQ0tFVF9TVE9SQUdFX0NNRF9JRl9SRUNWwqDCoMKgwqDCoMKg
wqDCoMKgwqAgMHgwMDAzDQo+ID4gKyNkZWZpbmUgU09DS0VUX1NQRE1fU1RPUkFHRV9BQ0tfU1RB
VFVTwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDAwMDQNCj4gPiDCoCNkZWZpbmUgU1BETV9TT0NL
RVRfQ09NTUFORF9PT0JfRU5DQVBfS0VZX1VQREFURcKgIDB4ODAwMQ0KPiA+IMKgI2RlZmluZSBT
UERNX1NPQ0tFVF9DT01NQU5EX0NPTlRJTlVFwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHhG
RkZEDQo+ID4gwqAjZGVmaW5lIFNQRE1fU09DS0VUX0NPTU1BTkRfU0hVVERPV07CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAweEZGRkUNCj4gPiBAQCAtNjgsNyArMTAwLDEwIEBAIHZvaWQgc3Bk
bV9zb2NrZXRfY2xvc2UoY29uc3QgaW50IHNvY2tldCwNCj4gPiB1aW50MzJfdCB0cmFuc3BvcnRf
dHlwZSk7DQo+ID4gDQo+ID4gwqAjZGVmaW5lIFNQRE1fU09DS0VUX1RSQU5TUE9SVF9UWVBFX01D
VFDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDAxDQo+ID4gwqAjZGVmaW5lIFNQRE1fU09DS0VUX1RS
QU5TUE9SVF9UWVBFX1BDSV9ET0XCoMKgwqDCoMKgwqDCoCAweDAyDQo+ID4gKyNkZWZpbmUgU1BE
TV9TT0NLRVRfVFJBTlNQT1JUX1RZUEVfU0NTScKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4MDMNCj4g
PiArI2RlZmluZSBTUERNX1NPQ0tFVF9UUkFOU1BPUlRfVFlQRV9OVk1FwqDCoMKgwqDCoMKgwqDC
oMKgwqAgMHgwNA0KPiANCj4gVGhpcyBzaG91bGQgYmUgaW4gYSBkaWZmZXJlbnQgcGF0Y2gNCj4g
DQo+IEFsaXN0YWlyDQo+IA0KU291bmRzIGdvb2QsIHdpbGwgc2VuZCBhIHNlcGFyYXRlIHBhdGNo
IHdpdGggdGhlIGFzc2VydCBmaXhlZC4NCj4gPiANCj4gPiDCoCNkZWZpbmUgU1BETV9TT0NLRVRf
TUFYX01FU1NBR0VfQlVGRkVSX1NJWkXCoMKgwqDCoMKgwqAgMHgxMjAwDQo+ID4gKyNkZWZpbmUg
U1BETV9TT0NLRVRfTUFYX01TR19TVEFUVVNfTEVOwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDAy
DQo+ID4gDQo+ID4gwqAjZW5kaWYNCj4gPiAtLQ0KPiA+IDIuNDcuMQ0KPiA+IA0KPiA+IA0KPiAN
Cg0K

