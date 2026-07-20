Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC15CC4452A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 13:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wloE5-0006cI-0b; Mon, 20 Jul 2026 09:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wloE3-0006c8-N2
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 09:40:07 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wloDz-0003i4-SN
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 09:40:07 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KAuwcr201159; Mon, 20 Jul 2026 06:39:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=88rQ8MYEpjracobNb7Fo3oHSnGjRd7ysATCU6GZuy
 tQ=; b=Idq3S6unNBj9yALq4+oRcBtVPwcCBYrocm7++ezXkhIItehM6P1pX7QaD
 M8hs1+XbhnnR2aqHKJzGAd9cTjcykVYlwU4eyMQAxFRmrlJbaWXMo8sq2H07L7KZ
 85cYe1FtpxkLhZbsT4NbrvQfZzY1JviEdIcp1IuizL2oUNS/E17SKdpicgWrGImn
 94TooBDWJkTxaeKLujIsfKzV7kEr0Cf2NysTSzPa+2QW9DYIr1hRWtJt9lRZwbke
 XUmvvjKoBW9wAmDXPF3OiJiMJ5jXBQiZJU+QhVD/J329usXQCN6ZAAHvPXPSNAIL
 lcquf5NHeBlB1yQlEu9FNGGG7fAuw==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022072.outbound.protection.outlook.com [52.101.48.72])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4fg8tbkce8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 06:39:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxOFOvM897tuyf9kPOxa83XtJyn1qV+YT6zKoHw0fOzGtQ8pMqCvnAxz7KylVMJuZN2zeN5l4cHmwW8DL+cNti5m5AWHggbvpz+fJHKoO/IjHS82UFTxAx8xVZ0GQgTKWRUmosRQ8ockKJtuPpRcrKBESz0LsBEWrzag4DyevSYrFxn1MpXokurYvo6mU1qNBuKLpD3KzRZ/rdf0GezUe3DOXHgGxtJZhNh3QPP6Rxo0wmxCUVqwbxuqAATZtTLG8Sk8x8L1MLlsmXzKX0c98MEQzxEhCcXkWgOxpQ1uIZ0yvCPYFtjSTj1Z10BhqoJS8+02xT/rH2aMX+AW9b864A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88rQ8MYEpjracobNb7Fo3oHSnGjRd7ysATCU6GZuytQ=;
 b=Nsjd4KjcIRalqmMlW1a0BmtkaiV8GiSoS4m9qAoB2A7n7L0GHB1vRayQCKN8XeluoP1daEUCOdELN7RLJRP3ayF9uaQASkuJgWW//FZOh0gzopmFOIQTSQT3Bzk9msWpgA0xyriLDWkkhDbBhP+/zISTJT1XbLL4Ly7kV49Z57OnYa5Gt3yLVmI4UkAEHeFl4112Hv2OGZTPkrvJq8/c5hq4j2P29Hny5hNoVTUIc1ozTkwmh0SvRT1yKEzZJiNmvAYqcp9YkfU3WQsHHx8AvO/5WyiMiQ5lhtj0A5PHBDHhX6KJXYEiVFlUrgQcFD3l7I3LGHTlhX119+r78ndYbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88rQ8MYEpjracobNb7Fo3oHSnGjRd7ysATCU6GZuytQ=;
 b=bcZA1ANnR+Ofz8HMrMYY7cUzX9E6v7Hqd+mJMDWzkqK95QLp2vEWOErl2siNx+IZ2mJGL5FGQdxUs90oL0Xsl7vnmvfvl9Xyvsmv2TmCM3i8c0uX3QhL+F0kEZy1imLq2jtAo2VsJUyhOKtFXZjA4kkKfSeuEaovy6h8TfPsjA+poDQ6RCwzfkxztsoUa9gjh9yE4IOqG/ElODseFoXiOBR5vdEXUaO8cywtkuSQwzT1SE6s9YFZaGTZ+R3g9OrjP0zQ5Q2AMF+2utOqD3Yru15V0IMTdDAiPY9D6FQFOPXx2tTIttvGnVYzz7RCajDGBP8vjUEuq83HAa2Tb7+3mA==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by SA2PR02MB7708.namprd02.prod.outlook.com (2603:10b6:806:145::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Mon, 20 Jul
 2026 13:39:51 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%7]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 13:39:51 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: John Levon <john.levon@nutanix.com>
Subject: RE: [PATCH 1/5] vfio-user: vfio_user_get_region_info: prevent buffer
 overflow
Thread-Topic: [PATCH 1/5] vfio-user: vfio_user_get_region_info: prevent buffer
 overflow
Thread-Index: AQHdGCiUeQzpPGhc9U+w6z3aHy5MpbZ2RbiAgAALYpA=
Date: Mon, 20 Jul 2026 13:39:51 +0000
Message-ID: <IA0PR02MB946282D514DBFA5F99C7C1E58BC32@IA0PR02MB9462.namprd02.prod.outlook.com>
References: <20260720091718.2642-1-thanos.makatos@nutanix.com>
 <20260720091718.2642-2-thanos.makatos@nutanix.com>
 <664901a4-d8ce-4f12-8511-86acd3f53c37@redhat.com>
In-Reply-To: <664901a4-d8ce-4f12-8511-86acd3f53c37@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|SA2PR02MB7708:EE_
x-ms-office365-filtering-correlation-id: 3812afb1-77fe-4fb5-fdb8-08dee6646010
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|4143699003|56012099006|18002099003|22082099003|10067099003|38070700021;
x-microsoft-antispam-message-info: /lKsgphoNV77gFGHpRyZd5huPTrLv8lS3TShh1fhXQ27J7wHLlT6I7RRJxHAYrtscSbBk/1xHJrve00aM4nomevHrt8QMgTXWFJ/1FHQk4dGh9FgyZIQWbXfpjPhSmHYd11WYAy+A1Ol6Nusv49kUqd8HtUYjY9aFI9DkKGhDTTVXtDxEjTyCmXbWc4ICfTRvTVfp/ghPZDG0ppAqxwo+p0bcmij6JB39asqaARQ0TuhJq6zZ1FWXjNot5YrgJGZQL/aMIcPReK2tsW1FCCRAey0/AGfKQ99NfeYSYISCXq7W7lbQT8EV99Fi1CUgKXHBO75aPbL0oznR42YQO5IogOpJI4quJsDTKJyzagkvmrpAM6f8pzvz3cRayKxaBX8oDb+BOW/h+ZxAiN8rAzuxi3tGZi9TAsjEFRTSWqudvVkQViEMzuQiqByvvHm0CCypuaclSxCzFKeGTrqFpDhG7HweFRGu97pY0cE58TsuqKtcBUGYS5xYT9TwH7YW9b72r55xpHE45PiLyfvfEEkefKvAOX9lGVHp8ov4/siR19mqJOYnAZqH81j3nx/7fo80T36DTxzyHfsE6zqeu2vb+kytvyFXk3UUAvGYl/SCh1RBcbO1jXXUr0P2dfj93iVctWwD0DP5AzryaScNPKzv9SdQ/yYHiN6zKunGAKIU02cyPDj/BE+d8k1oyN0Q3P2B7ZKwrEJkAwoy5P6mBONjUgKmwqO9zY/gxw9TeiLkf0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(4143699003)(56012099006)(18002099003)(22082099003)(10067099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnVnTnNHeThFYlltaHFQdUtQTTBJOEU4aGFYbnYrcndzRnkwRFFJL1lVSmp0?=
 =?utf-8?B?eFRVZGY1VkI2enlpdU5Fb0ZZVDVjTm1MTWJKY0JUUFVJTzhJcC80QmRHVkxY?=
 =?utf-8?B?dWU0UUF0bW82K0VUdThESjhFVVhLeTJRYVl4Ri9LbG1mM0lnbzdOUnJ6TlFG?=
 =?utf-8?B?aHRKVXdDUm1nQWd5OUMrc2dvdXRtVzk3ekNFYXJtcEx3MnN2aTBtQlM4WkQr?=
 =?utf-8?B?UWErR3E4SlNSY2NpeFR6cVlhb1U4T0FjRTI2bHpqSUJWTkZmcHZOaThhR01U?=
 =?utf-8?B?OEJid2VGS0dqaFU1Viszbm1ldlRidE04VjJ3WndIaWk2Z1Q2MWZveXduejBp?=
 =?utf-8?B?ZCtTLzJOZ1lQNmp4MXR1eDQ4WlhpSUtvRjdaNW5WSDNrNFZkVnBhSTlseTlH?=
 =?utf-8?B?QU5CWmR1M05NQ0hmVHJpSjFlMExBamNkTUp6RUkza3Q4eTU2emNQZkJFUk9t?=
 =?utf-8?B?eGtiemE3MXo4amJiRlhNNTJuOURZN0d2UFF5RXpCcWZkUFd5K2FkRVZJdDNp?=
 =?utf-8?B?aDRnV1lNa1pUdVNubTRSdEFkZ2wrOHN2eXNBWWY2Mm15N2dGd3lFVEwyeVVD?=
 =?utf-8?B?Si9GK1pScjRkYWdVaVRrbE8vWlg4Q05MaVVSVjE2aXZlMUN5TnpKTDdYM2I3?=
 =?utf-8?B?S1BxV20xK0RhbHZUbjZHbnNhbnN1MWQ0Q3dpZWNHeVZpajZNMVNQY0ZjdDFu?=
 =?utf-8?B?UTZoc2JWdEs0emlIV2xvYlZEREg3K2JrNFo4UzgxcW5ZeDBINnRHMWZiSVJo?=
 =?utf-8?B?Yis3L2JaelBuZFp1MEhFRmdUMy9Td1FLcC9ZSXk4ZHVNMXVmVHJVby9HNEhJ?=
 =?utf-8?B?OTlVTExoVTFMRnRyTnRzWXgyQ0RxUXVvRXNleFhVOWZ1UzFJZ2Q3c0hMZkJj?=
 =?utf-8?B?NUNpQTY4U3Qzb2Zkd1piNDNBQm5iRWQxNkU1eWFsSTdNS0JDWWJJMVNESHZH?=
 =?utf-8?B?cHkzUkUzWmFLV0xkUHlHVjlSWERhcDBTZW53STZMVEovcWx5NGxOVlFqNEtE?=
 =?utf-8?B?dFRuSGZWRHo4a05lekNiRnRTeGVCVTRabGhuM1kvTkdtOGp1Q0NzSUxWbktJ?=
 =?utf-8?B?Mlo4TnVuUGlNZGZFLzlLMGhLa3VxOUFrU2pWZXoyQlFDUmMwZUNLZ2NFRFo1?=
 =?utf-8?B?dVluVFpMbm9vTDhDdzFveTZZZDBYUDhPdi9mdUtWS25ua0lXSE8xVStFNGhm?=
 =?utf-8?B?TEFhOE40TWcrOTBQTWZUU2JNL3VZV1o2MkU0MTdOOTI2UVI3WWNtSDF4RUFW?=
 =?utf-8?B?V0o4NlJvbmxjMW1OTENURTBWQWZWUGcwZE8yRnl2eUM4Tk8yTzhRQUJSR0M4?=
 =?utf-8?B?SjVYd0RaQk1CL3Z0VzZXRDhPYWdyRFp6RDBXeDlBdmpJL0FWaGN5eU9YTjZ4?=
 =?utf-8?B?UmpSbW5iQnNyanRxRFg5dXdXYlFYNUhmY2FFWStncCtyblRkSjhmZVh2WXh3?=
 =?utf-8?B?eFFEdnZpOTBtb0MzRmthWWlxcE5nUEppdFVTREtJUGNNekRyTXF6NkRqN2lt?=
 =?utf-8?B?L0d2eEJNbXJnUGRFbFJMWFBFSktwcU1ZL25JWmJta2F5Unh6MWJjQkE4aEQ2?=
 =?utf-8?B?NzNYcDlqLys1Vk4wcFFzYUxQMlB6ZnhGc29wTEJqZ0pGeEo0T09PM25Fd0tD?=
 =?utf-8?B?YkFOWGdpVFhvOEU0bnhZOWZsa2R6dWlqVDVpL0ErSlAxc0pPMGJJblhEbjZM?=
 =?utf-8?B?cGY0TkFsY3I5ZWtKTG55VFlBU2hNelpzb2FWSk51QjZabEtJWTVFekFmaExS?=
 =?utf-8?B?bWdBVGFibU1sL2NhZ1VPQUcxclRmMzBhb0dvMExobUNmTFpGUEs2L0huS1hW?=
 =?utf-8?B?UVNiemh5MlloMUUwWmtxeDRkSzBVRXV1SzNPaEJGWlFEVStxQXZIb0VSQWpK?=
 =?utf-8?B?YXk2YjJjNmExYXhPV3d0NjEyL1pjNlc3b3ZIMk5YVEc0SWw5QktpdzVReWJU?=
 =?utf-8?B?am9YbFZKc3NHcW9hT3RYcVhqbEI0cis0VFhRR0NoOFVmTVpQYkR0aWNKdlpT?=
 =?utf-8?B?NlkvNWVBa250ZTFpZGowRHNOQlZHT2U0SnJEUWY0cUdoOWNkRm5BTUxkc0Mz?=
 =?utf-8?B?T1hVNGtVaS9XdEpCOVBrRHJhejZ0eXFOa3VUS1d5WmoxTVZWbm5QREMxQmUy?=
 =?utf-8?B?bHJjSmw5QXhreUhrMVcxTTFSU3hXanEzQkpSWVVvT0ZHbTRqL1pUcGs1MGcv?=
 =?utf-8?B?Vk5wNUQzWGlycE4xbnZoS2lpUzJmTlB4K0ZPNWhvK2YrRTlDNFpxUFljREZT?=
 =?utf-8?B?ayszd3dIb0Q2bjFNNTZuNDAwQ0tVVXZObG1sZzZSdEdQZHA2SWkrYkxoWEpL?=
 =?utf-8?B?ZlUwenNnZDFNc1F1MWZRblA5cHhhYytDWEU1bGlOeEo1Z0hIRFpxb3dWRVk5?=
 =?utf-8?Q?VWD1GRidj/IPPEM0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: X0TPx4d239/KqMTDBSh8Z1WVz0XAji+ojY7fuy3tgJp187ow4TT+GUYm0q5zJM26bJlWdoNmxSSmb/DaCJ2IFYD3eOq86lYm+MnnipTee2lfVVbElNSkPOBpHLU6fyfSXV28kvtRXoOew0N8XVRFbbYHadPuZHMcgfsB7qlMQ8HOAR7Vec9RBP7RuI29KTtDTrXNIGN5MkC5S1PVx4EW0zL7C/h9wI4eRiTwSCYlCZOW8NqKHX/hRyp0FMMIzKkhKVH8IYnQy+KrJF3dle4SujWkP7tr8zWnarnyOg01IjXWZvVhz2z4dom/wkPr3a49rE0uKUdsIAD9ec5oKUEjJA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3812afb1-77fe-4fb5-fdb8-08dee6646010
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 13:39:51.5976 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MBBu2pVJ7DmecjLM1+QuMKAD0N9XSV6itV/lJZCjUsK+MvvcsR5BzSUSi+Hr66chbecQ3NrQenHbZtvgQHsqAZ0QmAlawoqEcsK1X/K4mg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7708
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE1MSBTYWx0ZWRfX/uuM8C2/B6Uw
 WxfPQPN3bOprQ4ezeDb7kJ7BNSpa73c8i//dJrOjfUbYQAC3FbgcyWnviB0TjYQV8EhJAhWm9Xb
 xWz6lK1EoAX6d6VniOUkyzxRER2BJ3SWfo3rzH0C0B1hf894gx3gh6NCHmMF5Wc9gnr6MgRqCsW
 RKm6OtUJHpOrmYKV7MgH8VgvqSPbkiyZs+mWyoRH6QTRF5F2KRaLt0CmpeQMS6gQbvaGIc5IED+
 jex2P/MKqZ3nJ302+nAvH7Cb7mHKoFRejlmRqRErdROCqBvTzhDauzNermez6xCMwpLWvkgjTjR
 TiqIxei1CvxoR9bNJqqpvfZ+4eXB9jfli0neN+2NapukQC4tvqkQmxluxSsfmQXo298QEm3roUB
 rXnOZf/8CD1hWQOm3iVjdhrtmCmc1FgR94zpv8rEJ6ert8scsjr/rL/AHAWFiyMj8T0+2LfwzHm
 dc4oXgtCelwAxj3WmUg==
X-Proofpoint-ORIG-GUID: uW3UFDYU846AD4MEXChFFiMa70thePLN
X-Proofpoint-GUID: uW3UFDYU846AD4MEXChFFiMa70thePLN
X-Authority-Analysis: v=2.4 cv=ZJ3nX37b c=1 sm=1 tr=0 ts=6a5e252f cx=c_pps
 a=hro4gVXncoUBxB/Amc69HA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22 a=RpNjiQI2AAAA:8
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=69wJf7TsAAAA:8 a=T--ZwRJRNw57Rg2RrLoA:9
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE1MSBTYWx0ZWRfX8Ueu2H9jKM1y
 xORzX45HJmTiTnaW3qjBqJ+VLr9vICNB+BHajPPdDahU3oyDhCUyWS2zAcgNTP6RC+fvbVyc8lv
 4uerOm8AAFahz2oY5eIPr9RD80CChxk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDIwIEp1bHkgMjAyNiAxMjoyOQ0KPiBUbzogVGhhbm9z
IE1ha2F0b3MgPHRoYW5vcy5tYWthdG9zQG51dGFuaXguY29tPjsgcWVtdS0NCj4gZGV2ZWxAbm9u
Z251Lm9yZw0KPiBDYzogSm9obiBMZXZvbiA8am9obi5sZXZvbkBudXRhbml4LmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCAxLzVdIHZmaW8tdXNlcjogdmZpb191c2VyX2dldF9yZWdpb25faW5m
bzogcHJldmVudCBidWZmZXINCj4gb3ZlcmZsb3cNCj4gDQo+ICEtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfA0KPiAgIENB
VVRJT046IEV4dGVybmFsIEVtYWlsDQo+IA0KPiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSENCj4gDQo+IE9uIDcvMjAv
MjYgMTE6MTcsIFRoYW5vcyBNYWthdG9zIHdyb3RlOg0KPiA+IElmIHRoZSB2ZmlvLXVzZXIgcmVz
cG9uZHMgd2l0aCBhIHZhbHVlIGxhcmdlIGVub3VnaCBzdWNoIHRoYXQgYWRkaW5nDQo+ID4gdGhl
IGhlYWRlciBzaXplIHRvIGl0IG92ZXJmbG93cywgYSBzbWFsbGVyIGJ1ZmZlciB3b3VsZCBiZQ0K
PiA+IGluYWR2ZXJ0ZW50bHkgYWxsb2NhdGVkLCBsZWFkaW5nIHRvIGJ1ZmZlciBvdmVyZmxvdy4N
Cj4gDQo+IA0KPiBtaXNzaW5nIFNpZ25lZC1vZmYtYnk6DQoNCkFjay4NCg0KPiANCj4gQ291bGQg
eW91IHBsZWFzZSBhZGQgYSByZWZlcmVuY2UgdG8gdGhlICdjdWxwcml0JyBjb21taXQgYW5kDQo+
IA0KPiAgICBSZXNvbHZlczogaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3Vy
bD91PWh0dHBzLQ0KPiAzQV9fZ2l0bGFiLmNvbV9xZW11LTJEcHJvamVjdF9xZW11Xy0yRF93b3Jr
LQ0KPiA1Rml0ZW1zX3h5eiZkPUR3SUNhUSZjPXM4ODNHcFVDT0NoS09IaW9jWXRHY2cmcj1YVHBZ
c2g1UHMyekp2dHcNCj4gNm9ndHRpNDZhdGs3MzZTSTR2Z3NKaVVLSXlERSZtPW1qZzVnMnFyZGFf
SE5tS0J2YzdsTnNMeFpUajY3MzhCbQ0KPiBhbnFCTS0NCj4gRnRSemNyaGVYSmFua3g3U2ZUY0Vl
OEVqNCZzPTlxVDk2SU9zNVpNRUFfM05DTWNRaDg0dG81R2lHUldjckJYDQo+IF95dkNjeWxrJmU9
DQoNCkFjay4NCg0KPiANCj4gDQo+ID4gLS0tDQo+ID4gICBody92ZmlvLXVzZXIvZGV2aWNlLmMg
fCAxMCArKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8tdXNlci9kZXZpY2UuYyBiL2h3L3ZmaW8tdXNl
ci9kZXZpY2UuYw0KPiA+IGluZGV4IGI4ZDJiN2MxYTguLjE5YTQyYzJhMjUgMTAwNjQ0DQo+ID4g
LS0tIGEvaHcvdmZpby11c2VyL2RldmljZS5jDQo+ID4gKysrIGIvaHcvdmZpby11c2VyL2Rldmlj
ZS5jDQo+ID4gQEAgLTEyOCw2ICsxMjgsMTYgQEAgc3RhdGljIGludA0KPiB2ZmlvX3VzZXJfZ2V0
X3JlZ2lvbl9pbmZvKFZGSU9Vc2VyUHJveHkgKnByb3h5LA0KPiA+ICAgICAgICAgICBlcnJvcl9w
cmludGYoInZmaW9fdXNlcl9nZXRfcmVnaW9uX2luZm8gYXJnc3ogdG9vIHNtYWxsXG4iKTsNCj4g
PiAgICAgICAgICAgcmV0dXJuIC1FMkJJRzsNCj4gPiAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAg
LyoNCj4gPiArICAgICAqIEVuc3VyZSB0aGF0IHNpemUgZG9lc24ndCBvdmVyZmxvdywgb3RoZXJ3
aXNlIHdlJ2xsIGFsbG9jYXRlIGEgbXVjaA0KPiA+ICsgICAgICogc21hbGxlciBidWZmZXIgdGhh
biB3ZSBuZWVkLg0KPiA+ICsgICAgICovDQo+ID4gKyAgICBpZiAoX19idWlsdGluX2FkZF9vdmVy
ZmxvdyhpbmZvLT5hcmdzeiwgc2l6ZW9mKFZGSU9Vc2VySGRyKSwgJnNpemUpKSB7DQo+ID4gKyAg
ICAgICAgZXJyb3JfcHJpbnRmKCJ2ZmlvX3VzZXJfZ2V0X3JlZ2lvbl9pbmZvIGFyZ3N6IHRvbyBs
YXJnZVxuIik7DQo+ID4gKyAgICAgICAgcmV0dXJuIC1FMkJJRzsNCj4gPiArICAgIH0NCj4gPiAr
DQo+ID4gICAgICAgaWYgKGZkcyAhPSBOVUxMICYmIGZkcy0+c2VuZF9mZHMgIT0gMCkgew0KPiA+
ICAgICAgICAgICBlcnJvcl9wcmludGYoInZmaW9fdXNlcl9nZXRfcmVnaW9uX2luZm8gY2FuJ3Qg
c2VuZCBGRHNcbiIpOw0KPiA+ICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gQSBiaXQgYmVs
b3csIHdlIGhhdmUgOg0KPiANCj4gICAgICBzaXplID0gaW5mby0+YXJnc3ogKyBzaXplb2YoVkZJ
T1VzZXJIZHIpOw0KPiAgICAgIG1zZ3AgPSBnX21hbGxvYzAoc2l6ZSk7DQo+IA0KPiB3aGljaCBi
ZWNvbWVzIHJlZHVuZGFudCBub3cuDQoNClJpZ2h0Lg0KDQo+IA0KPiANCj4gV2hhdCB2ZmlvX3Vz
ZXJfZGV2aWNlX2lvX2RldmljZV9mZWF0dXJlKCkgOg0KPiANCj4gICAgICBpbnQgc2l6ZSA9IHNp
emVvZihWRklPVXNlckhkcikgKyBmZWF0dXJlLT5hcmdzejsNCj4gICAgICBWRklPVXNlclByb3h5
ICpwcm94eSA9IHZiYXNlZGV2LT5wcm94eTsNCj4gICAgICBFcnJvciAqbG9jYWxfZXJyID0gTlVM
TDsNCj4gDQo+ICAgICAgbXNncCA9IGdfbWFsbG9jMChzaXplKTsNCj4gDQo+IGl0IHNlZW1zIHRv
IGJlIGEgcHJvYmxlbSBhbHNvLCBpc24ndCBpdCA/DQoNCkluIHRoZW9yeSB5ZXMsIHRob3VnaCBm
ZWF0dXJlLT5hcmdzeiBjb21lcyBmcm9tIHdpdGhpbiBRRU1VLCBpdCdzIG5vdCBleHRlcm5hbGx5
IHByb3ZpZGVkIHNvIGluIHByYWN0aXNlIGl0J3Mgc2FmZS4gSSdsbCBmaXggaXQgdGhlIHNhbWUg
d2F5IHRob3VnaCAoaW4gYSBmb2xsb3cgdXAgY29tbWl0KSBhcyBpdCdzIGdvb2QgaGFyZGVuaW5n
Lg0KDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLi8NCj4gDQo+IA0KDQo=

