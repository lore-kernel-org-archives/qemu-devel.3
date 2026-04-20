Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BF9F36C5C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 16:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wErvU-0004Dp-BB; Mon, 20 Apr 2026 12:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1wErvS-0004D7-Bn
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:56:46 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1wErvQ-0003i8-GC
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:56:46 -0400
Received: from pps.filterd (m0409411.ppops.net [127.0.0.1])
 by m0409411.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 63KGmfnA1602830; Mon, 20 Apr 2026 17:56:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 jan2016.eng; bh=9jpi3IGqW3/0rFYsxcaOQTKLUjWnshLVnlsUiQNaJLI=; b=
 hEvaW0g76b6uJZJZ2tzeQO/tVMRuSsyQskuDBZyIhMHQv/zXN2hNpTZ4eNMrQ8Fh
 uqjZWRzMtz9GnrMuCxtkKYEwqh5kBOVjWy6dO9/LZE4yThyKT8yu9x5yOLNJh6r1
 4Yd25vUQ9VBoc0NWYKLx6giGcFb0HLI3IpKeuKgLl13fu73oDOWuMZvwdyDRmphI
 xK20UerG3QKh3vu7vyPs3jaxrOGcH3gKXzgDE3EvghS24Vk+xr743w5Bm3Hjbb+O
 gJzl3a+Yufbm1leLP0vnBoyx+rI338dq12DNelsmepLEUz9/hXoZHDse9HsHBLVO
 sbl59p2hL81j4IJO4T/KXQ==
Received: from prod-mail-ppoint3
 (a72-247-45-31.deploy.static.akamaitechnologies.com [72.247.45.31] (may be
 forged))
 by m0409411.ppops.net-00190b01. (PPS) with ESMTPS id 4dmk9y84g5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2026 17:56:34 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
 by prod-mail-ppoint3.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id
 63KGfsH0019278; Mon, 20 Apr 2026 12:56:33 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.221])
 by prod-mail-ppoint3.akamai.com (PPS) with ESMTPS id 4dm59ttaux-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2026 12:56:33 -0400 (EDT)
Received: from ustx2ex-dag4mb1.msg.corp.akamai.com (172.27.50.200) by
 ustx2ex-dag5mb4.msg.corp.akamai.com (172.27.50.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 20 Apr 2026 09:56:33 -0700
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-dag4mb1.msg.corp.akamai.com (172.27.50.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 11:56:33 -0500
Received: from DM5PR08CU004.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft
 SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 20 Apr 2026 11:56:32 -0500
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by SJ0PR17MB5605.namprd17.prod.outlook.com (2603:10b6:a03:387::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 16:56:30 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab%3]) with mapi id 15.20.9818.033; Mon, 20 Apr 2026
 16:56:30 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>
CC: "armbru@redhat.com" <armbru@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "farosas@suse.de" <farosas@suse.de>,
 "raphael.s.norwitz@gmail.com" <raphael.s.norwitz@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "berrange@redhat.com"
 <berrange@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH v14 5/8] virtio-net: support local migration of backend
Thread-Topic: [PATCH v14 5/8] virtio-net: support local migration of backend
Thread-Index: AQHc0OGXKIis9WtFOUOtrBENvmvZQLXn6HKA
Date: Mon, 20 Apr 2026 16:56:30 +0000
Message-ID: <AB9D5FA5-8BEE-41CC-8446-C640E5BE5814@akamai.com>
References: <20260420161958.584407-1-vsementsov@yandex-team.ru>
 <20260420161958.584407-6-vsementsov@yandex-team.ru>
In-Reply-To: <20260420161958.584407-6-vsementsov@yandex-team.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.106.26021521
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|SJ0PR17MB5605:EE_
x-ms-office365-filtering-correlation-id: 36edb666-bb24-42fb-c32b-08de9efdc537
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: L3qsezRM0XVpbFjcBXsK8UqQNTuY/z3P+81G6ZBkkzEdolzOXEaH7z8bbLPWP3Xx0sinjZM7q+8BYU/E/yobAtuiKqwHGnc5xZWtr6EEi8Tiu3zYvPFVnM8iG2pXz0EHewH07dO0mCpGg8vpUsXdiakwJeSFGh/RouXNOl/HZ+mmwVZBRfkq6b+EDhB8AjuF7onVcNTXPKsxjz1AqI2O+XnZ4N3vCj3Bx1GZvRafW3lI5Rhfg/jSyWKFgHp0M++TtDN2V9Y11N1oAki5ukW+2S5NhyMLr46Yvbe5FTqdCchITYWFkPzHGwP4xgDG/tObtzL1ql1Hm4X3VLZQglp097gAIOnFKWkALe/jhUMoTbsIPnZDQXRPKMB/us5EPVRMW7rthJ9xOxBUv8YC1OUGek67aEY47D/yf58yLEEgmwpdSDBkyp+a5DqxBChpfs9w94SioPZVzC0RlnYfAUDJ6zIJy4ZkzFKD+We36IunJgVwLuwYc6JxVR8VL3mI1VB8pTteQTlJG3bsQ2iyV+W2tl3uguJaAcIulQM4iAIl263ruxkV74KoAKprJ4yCVn7QD+dmVWQsABcd3eOOhSzoP7jByhb5Gf7J1P9yBOWQBsg7nlABUAwzfX69XT4ADm9W2SVRlulBGt8aLP6iyDawhv8rSoasxyCxdhKgD6HsAAlBtsD/rrO09PjNTD2LmNtapmloI//+ijp60JJj9h2StatVWqjzEogkkJoDrlVG9h77a02EksBovOfaGTfVFp9g4z+gHTd2XNp//r/yF8jUYvxQcJ+26iZ0VLGX02JJEmw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1RHWEppMWxNRVRrU21QM2h4NW5Od3IxZG9BbFNMQWFyOUx0LytNQXBwSG9R?=
 =?utf-8?B?MlNXYkFnQVlmYWlkZTU4Y3VEcXhKZ2ZaaUQwTndLUnFqeUhMQTBPVWFERFUw?=
 =?utf-8?B?S1ZFWit6WmxLdGF5TXp1bXlQZDNQdWR1V1lHUzRvVXp5ejAvTG1KOStaM2Uz?=
 =?utf-8?B?ZDlvNTY4QmUzeVF5STRZVldiem44czFMZm9nUjlZcm9BU0l4eUErWWZIa0Fr?=
 =?utf-8?B?UDVIQjJBLy8vbG5jUlZ1amZkblcwcUhQL29BT2I4NnhyQTl2cXpaSmEzNDVh?=
 =?utf-8?B?TzdYL08wZkc1aEFFckJ2bk4xbWdLNCtwQTBDaXpKTmpYcS93bmdBVCttVW1Z?=
 =?utf-8?B?bE5Kc1liTEtONFZLUlhzcTdQVDZIVDRZcmZhU3RLN09TWTNyMkd1dmxkbjZD?=
 =?utf-8?B?VDNGamtCUlhJOUV0UkJDQkszb3NpSEpWcnJrS1pMRnFUSFZ4VjNnMnVUSSt6?=
 =?utf-8?B?NXk3c0ZTekJHQllZTmpEN1RrZWJoaVFvUFA0NVE0VlNkVjZVMFRsMXlrU2ht?=
 =?utf-8?B?S1NjMUpTa1hzdE45Z1VCaHR6QXVXZU0vMVRSMXNTNDc4bG1tU1N4T1R6cEVN?=
 =?utf-8?B?TStFOHhET0M0OVQwbjZWbDBlNDdFcWZwcVA3TGNFamxMeG15bnRlMDlmVit4?=
 =?utf-8?B?WWFVbXU3blB0V25FLzdqS0d6cTVsU2Q3My9OKzVPemwwaTJSeTd0a0hzYytl?=
 =?utf-8?B?Z1FMY3FGd2U1amJFdXBDRC8rcldWalIyVXFBQWEyYUVCUis0SzBDanVlUmpl?=
 =?utf-8?B?aGJtRTlrQWYwVytCNmJ5eWk4dXAyUVRqSFhUaEhWVjRIUHlnMGVKNFRVK2xr?=
 =?utf-8?B?cWlwa0RkWTRhUUJla2ZpbXdlUEFPbkxTbVFWWmV6VStBaVdaNjNHL0Noay9p?=
 =?utf-8?B?a0kwZzkrRGF3T05Gc09qNXZaVGJDRnlGb1lUNUt6WmYwYURyaFd4QWVpREY2?=
 =?utf-8?B?QnN5M01tTFAzcG9GSkQrZFIyUmtqeEc1TjAxUHhtNkFHbk9ycjZ6T2RKN3ow?=
 =?utf-8?B?MjNmTWRXLys5V3BrTjFzQWplNkMzNnE3UFVvRFNVajJQMzZ3em16Uitxd3Iz?=
 =?utf-8?B?L0VZNFhtK2N6V01iLzA1cjVIMFkyUHM2V1k2d1gxN1ladXZMZEpwdTFpMWo2?=
 =?utf-8?B?cEkvTEZ6aURhRE9DMEJHT3ZTMW4zVUk1YURHUVpHMnAvZ3B2MlVtdk9mNnRJ?=
 =?utf-8?B?eGdRK3ZLcXM1cTVSY1BHbU1DN1phOWo3NEFsdnFaYVIwNGJzZ004bFpoMmc5?=
 =?utf-8?B?OC9tRUlKV1dmSmtpTG5pTHdxSnN2bGI3WUJlUVFzMGs5UWJYdGVrb3RpSVpZ?=
 =?utf-8?B?WjlyYnI3SjR4WWpYMDl3bXhjYUl0WjN3bkFTZzNKcEFhTGdjTkttcHQwc3hp?=
 =?utf-8?B?c2laOGN3ejVwdkVaN1hQUlNydVNYWjY0Y3ByU0hxVGdRcTlCZkpRNkNKaWdZ?=
 =?utf-8?B?ZFhYNXcyS0Z2WkhmSC90eWFDYnlvVytGQXA0R1RCTjNDZjZkQWo1U2lMNEpx?=
 =?utf-8?B?Vmg1V29ueDQxazM1WU5RZ1NQWWZqdWhDV2FuRGlpOHZORUtMUGEwU0V6d0Rp?=
 =?utf-8?B?Q1VxNlQyZGRvMG5KR1ZxRlBmaVFVRzNEYm9YZFh6bUlXNFNjMDlYYUx3MXFL?=
 =?utf-8?B?Mlp0a3ZTc1Q2aWpoalhnYnl6QVJLTVlBZFhINC9LQWZiQWhxR0Z2MVc2Ly8y?=
 =?utf-8?B?dVFsbCtkdm9iSG02WHdiUUNKWXNuODVMc2ZaUlUwZWF5ekg5RkJmaFVlN3dL?=
 =?utf-8?B?Yjh1T3B5TkpPdE1vOU1aYm1mWVYyVHIzbUdZSVZpZU9Ld3VoUk1QbDFQWWJ3?=
 =?utf-8?B?V0x6N2pXVlZHQzhrVlBKR1h1TkhRbUM2TXpndGExdm90d3VvUWFZcndNdTAz?=
 =?utf-8?B?VnpJTWVLTkh1ZTM3TDk4aFY5K3U4TFYzczk5MFhPVHpZOTQza3NKTnkxRlp3?=
 =?utf-8?B?SXhQdzdTRkttaDBpRGMvb1VPblJsQlVjTE9oYUNRTTlIT21qOE1wb2ZVamtl?=
 =?utf-8?B?dVFrWjhQM0hucmdMdjRWdys3eVh3citZd1JiaW1RQmM4VGdyNDJ5bFM1d3dt?=
 =?utf-8?B?ZTFtTUs5VGFCcDRHazR0YjVsMzc3YWFXNzcvOVVVbnpGNFNZSEFxNXFHckMw?=
 =?utf-8?B?dGtxMnVOVlFUNmFhcDNJWmRadlJXNzl6bUg3bTBZam5WTnl5cE9LYTRScHBC?=
 =?utf-8?B?VjJMZmdwMEpWTERjeVlvMjBnM1htUEUyZnZnVHZoUjRBT0RGY1NmUFd5cHU5?=
 =?utf-8?B?RWczUnRvemxYbHBzaXdFSXVHaVV2VGVJeW5JeGdtMFJxU0d1QkdtWTZqbGw4?=
 =?utf-8?B?ZTZuYW1mYW1EdDVuak90OG5VU3ZNWEdJc2xDMlg0VTR2QTh3M0dKSllPYnRu?=
 =?utf-8?Q?z+03jAI8/SePVKwI5xa12eDIgP3db3pJHiB/wvY7u7Df4?=
x-ms-exchange-antispam-messagedata-1: 4rNOayFZ29FEZg==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DN6Y3BOTykr07M2vqqRxNoiNb6sPNzoq06RZR+yz0DgQk94LWIhddF2XmwfYtW/7Ia6skhbWY+u80kqvXoY2kRfRsQauXwZ+bNl8xRplPIxFHGFV3qtdHmu35/pxDFq/PXY9yYvBbOlO8pRtg5CCZRmskDtDdP3dLO9DTUybmuJQ4maV91YgxlGWjhSTJb9UMPrkYXl8hjXXt+DJto4ftg0ANyher/ffGtEqWVm5FzYwpLi5o/0FNHFrbUoX5P9uCZsysaB4IRm4N+kdzsU5V9pcrtCF48lGFk3cVBs4UwUBoultmWQmj3xadQlPpn7stWD6OBIASxzmDbDYwwHgTQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILYNKgO+SYW5bdojjC0zJFrv0BLfFSGRuutDFqcVFF0=;
 b=dKGckYQZ8vAOJZJsX4BjMBsN13Ncmp25xpglscKEOJV1Y27b6hxekuNhtYXHXwwNyGHFlbRUym2Y+KqEzicqLrm9YptieulOi9XtkapKfvAxMS84IaWRb+9VrdBnWse4JJwqyXPDZUZxPVjOKKMixV/vXP9UKVHBk5o84QIb2kxyhpmf8ZTkWpxhPlbiSPB2ntFVgCJZPR5V57AO4yTvvLE76oq0bVCleiAHMCY2/EDUJgmlVcPzQ50UVs3Hj1TNAVY2IeSZyCOhkYtZCuHfp1MeM57rSr0JgJeqSh1EVICp3rqn6DLKSyOtESU8fnVHQssXwtjNog8Z8kO6/GStIA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: AnhjIJrC4dV9rsAbtNyCidxmI2MhwlylKa0uOk+CBJeDceJ9dk1DD7kunozr+2pzbmJuMZE0lShiFAnWfd29SsNauHe6xQ4Xj91JH5qDuV5q8LxdPSEHHlXjkb0ZHBfe5GayAArTJGmoBV1oAsmbVEzpaUtcelLDSUReHnSW1pvsNjAVA/RLIhXjsnIk2CuLE+w5VTJfxd35Y6MHZxNedqYbhxKN+DDg8uyenv0Dc45IDf8r4ZTT2+UDEm2em/AFmi/9WUCa5HcrFv1TYCn+XPg/Wflu9zzfs6YuGauiG/0gWtLIANXN6540t7MKHjS3BQVKU9LyZUu9lBISQZzlRA==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 36edb666-bb24-42fb-c32b-08de9efdc537
x-ms-exchange-crosstenant-originalarrivaltime: 20 Apr 2026 16:56:30.5712 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 8LqQ4sgXM1cHyxcfrC4mgpFDimHTu9FfF7eyXYS+DYA4W+gn5Wr0OrgmIkqfJpf11aaqpj3yr+2/7ZVQhYUouQ==
x-ms-exchange-transport-crosstenantheadersstamped: SJ0PR17MB5605
Content-Type: text/plain; charset="utf-8"
Content-ID: <01817667E693774F8DC6496DE13B3999@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=575 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604070000 definitions=main-2604200161
X-Proofpoint-GUID: C3zC9GoSIZgYWoMuqDp47GG6YF4jn2J7
X-Authority-Analysis: v=2.4 cv=L6otheT8 c=1 sm=1 tr=0 ts=69e65ac2 cx=c_pps
 a=x6EWYSa6xQJ7sIVSrxzgOQ==:117 a=x6EWYSa6xQJ7sIVSrxzgOQ==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=XKgOefoLEnF0tNwW78TB:22 a=6R7veym_AAAA:8 a=lqhwKlS1FD9NeV_RJd4A:9
 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE2MyBTYWx0ZWRfX5AL6iW9N4s7M
 JQ27bCb+VhQXX1oX3HFTBNH2Ljq7fb8yp73QdJSqnNaotoaTVGe7e/8yphgdDChY2/Pa6CgbPr0
 YOhqiO84uaIy9EkTOs+XQibaIiKJwL1wXzUR71Xgv5uRkkJfSjlGD10nHH5wl8sVjnPODd2toRZ
 wNlSfKoY/CVQd6shLpTxrb1A7yR158KK8d4KozECRFKyhrS/ehMKWz/MyATNn4cVw+3aDCG7q1R
 m+MFYkB+gxfJUko/U+PboDCtPIVsDhQhxIBo59YBFVkKGGJk74UN+/1bvTS3wULg6VcXo9LRa5g
 AQJB6KXuwR7CdLwy8FWjThFmd0XHlBFIpN4kgut4tIOpuMfPaEJGsLLUtxKip8FevUn8DnDmgSC
 sDnbLFRaTCg5gRBYw+ownxUi4wIRxYOuNSP+EEn7OokN9fzilPX7YVhZTXopIZdrLXZGwYsMdiD
 laQUMYA0O2yEFA6zHPw==
X-Proofpoint-ORIG-GUID: C3zC9GoSIZgYWoMuqDp47GG6YF4jn2J7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1011 malwarescore=0
 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604170000 definitions=main-2604200163
Received-SPF: softfail client-ip=67.231.157.127;
 envelope-from=bchaney@akamai.com; helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=ham autolearn_force=no
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

DQoNCu+7v09uIDQvMjAvMjYsIDEyOjIwIFBNLCAiVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tp
eSIgPHZzZW1lbnRzb3ZAeWFuZGV4LXRlYW0ucnUgPG1haWx0bzp2c2VtZW50c292QHlhbmRleC10
ZWFtLnJ1Pj4gd3JvdGU6DQoNCj4gZGlmZiAtLWdpdCBhL2h3L2NvcmUvbWFjaGluZS5jIGIvaHcv
Y29yZS9tYWNoaW5lLmMNCj4gaW5kZXggYTE0YWQwNWI5YTYuLjhiMmU2NjY4NTRiIDEwMDY0NA0K
PiAtLS0gYS9ody9jb3JlL21hY2hpbmUuYw0KPiArKysgYi9ody9jb3JlL21hY2hpbmUuYw0KPiBA
QCAtNDAsNiArNDAsNyBAQA0KDQoNCj4gR2xvYmFsUHJvcGVydHkgaHdfY29tcGF0XzEwXzJbXSA9
IHsNCj4geyAic2NzaS1ibG9jayIsICJtaWdyYXRlLXByIiwgIm9mZiIgfSwNCj4gKyB7IFRZUEVf
VklSVElPX05FVCwgImxvY2FsLW1pZ3JhdGlvbiIsICJmYWxzZSIgfSwNCj4gfTsNCj4gY29uc3Qg
c2l6ZV90IGh3X2NvbXBhdF8xMF8yX2xlbiA9IEdfTl9FTEVNRU5UUyhod19jb21wYXRfMTBfMik7
DQoNClRoaXMgaHVuayBkb2Vzbid0IGFwcGx5IG9uIHRoZSBjdXJyZW50IG1hc3RlciBicmFuY2gu
DQoNClRoYW5rcywNCiAgICAgICAgQmVuDQoNCg==

