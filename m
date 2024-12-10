Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F4EE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 21:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL893-0001j0-2b; Tue, 10 Dec 2024 16:51:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Zhigang.Luo@amd.com>)
 id 1tL891-0001iZ-EA
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 16:51:51 -0500
Received: from mail-dm3nam02on20611.outbound.protection.outlook.com
 ([2a01:111:f403:2405::611]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Zhigang.Luo@amd.com>)
 id 1tL88z-0000UK-19
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 16:51:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERCfcODFjYn5PolNNKcJhhYU67xA2W0vD9jrtTTyM+wQVDHFVKysyVcDe46hRU+GknM1kRObRFbtwv4hZ/+z0RH1Votl579POf/XSha4lZCYUQLDHd5if7XhiVo717oGKGltv3LI/twV1htj9DowsxosvB/FHxgNEIJ7tY9a3/pc9rtovy6xPKf4PJtEHX51TVR7lVPAUhYC6vK7RpyXGvxjRMKrcM9OMpU4jvwlsyLJq9ijgBOOyDd98HlqWoqvkurNDEsP6cR6N4MyBQXkjHQbm5C3VpxD043penGTvL44sRQ5sOlAGPhEtcoRMaCoGOj9pS0eMo271W0gMROV2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jncwsuToI2vrrmTMPQFbPNAx7Cqu2UnLI+XKmj3sVqE=;
 b=nqhPOoUODPDLruMDpb9qIXQeEA3FXwRSys/NzDN7PiN6VU4q7E3+m53SCDRaL+DZl1efjWKGQsVhO3tXqj19vtV/lCqNz62ivRQkAoLbhErPEjVZvYeO7WQLfmifOf6VctMQHf8hjvX/m00Ugnz2FaO8+iL2q4FT5C0BRA7Wqfdtwyy14sPdFVXMB93c6LjzllmlDj5jHR/EG0Q6+abBSpGdJN89rXVCL7BHjC6zvSzSM0qf9Fhc0NQWEdyJJGq4f7O8dwmzdCoNJ/8/9UdC4FHeAXNUt9JUyveAAk9KLhaCwZiwc/D7S1Bzmn1PQ39lMmxxw0htsvvsacjnALM02A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jncwsuToI2vrrmTMPQFbPNAx7Cqu2UnLI+XKmj3sVqE=;
 b=v2MAJx5Ta6DgiYLm8BDgTq96t1dxEI2E0N0urlQL66oV4f7yg8kJZwOGkxGIEWUjfXUAg+dE8k7gGvHXOChA4I6Js0//sTqRrAPXbpkTQA3fre0xZbcSnmoTZXHyUxabRKbYTTQw8veR5Kk6iP8bbw1ewPF//bMh88Z0O66dEUM=
Received: from BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 21:51:41 +0000
Received: from BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::bb8a:785:463:43ec]) by BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::bb8a:785:463:43ec%5]) with mapi id 15.20.8251.008; Tue, 10 Dec 2024
 21:51:40 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: David Hildenbrand <david@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "kraxel@redhat.com" <kraxel@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>
Subject: RE: [PATCH] hostmem-file: add the 'hmem' option
Thread-Topic: [PATCH] hostmem-file: add the 'hmem' option
Thread-Index: AQHbRm+T08edT93tD0m94+3Dx5+wM7LZAIAAgAB6QhCABPYygIABblGQgAAOkYCAABsxEA==
Date: Tue, 10 Dec 2024 21:51:40 +0000
Message-ID: <BL1PR12MB5317EAF52CFCABB96E05D538F13D2@BL1PR12MB5317.namprd12.prod.outlook.com>
References: <20241204171114.20033-1-Zhigang.Luo@amd.com>
 <5d4019cd-a3fb-4bed-8bab-e0388ccffee7@redhat.com>
 <BL1PR12MB531759C282DC7A424CBC56E8F1312@BL1PR12MB5317.namprd12.prod.outlook.com>
 <ab889035-afa2-4a32-8a13-b8bd21b69fc7@redhat.com>
 <BL1PR12MB5317B47F9AF0068760239C8BF13D2@BL1PR12MB5317.namprd12.prod.outlook.com>
 <cbe5a04e-caac-4ddc-a7a4-6c6bf5b0fac8@redhat.com>
In-Reply-To: <cbe5a04e-caac-4ddc-a7a4-6c6bf5b0fac8@redhat.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=0c7e73bb-8f92-4a03-9ae8-9355b5100a7b;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-10T21:32:01Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5317:EE_|DM4PR12MB8451:EE_
x-ms-office365-filtering-correlation-id: a428734c-4130-4432-b0ad-08dd1964d462
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bmxQQndyeVh5bkFKZDJGTmZXWUdPVzU5dmhjcnNiUFZjRmpYTXVVVVNHQzgx?=
 =?utf-8?B?dzdLTmgwMUFuRlRXZHlHVmdzR1RsSkZUNEhXaGIwZEM3dHdnTGhmcTRzZm90?=
 =?utf-8?B?dXY1dHpjM3FUYXVmRFJvSVRIYmlseUJHK3B0aXVBMDhwUS9TMmJXYTJUSU1R?=
 =?utf-8?B?ZEllaDU2L3JvMFlsV21ZOWl1VDhCUjBmdWp4ZGx0WUtoVzVRVklFaHNLZ2sz?=
 =?utf-8?B?eTFmSTc0d2FBTktxakova0tEdWNLb29YQmh0L05vR3hoa1dpdnJzZVZwbzVT?=
 =?utf-8?B?TlhEVmZGdFl1Sk1WMnpzaWFaTGUvdEZhRkE5TUZvOG1uVVpETFMrTDZ3VVh2?=
 =?utf-8?B?akFXZVBMT3owc2JCZzdGbVVPYkNVWjBGaG5DdGNJdjhCd3ZDSnBTN3BjeHg0?=
 =?utf-8?B?UmhWbGNtSk9tTnkvSjJaZmd3NVVEQ3VxcU5vck01cGVUM08zdys2NHFQdkJ3?=
 =?utf-8?B?TVJvRVJWbWNWcllxK3lSTnBBOUFUemtCblR1YlpjeDhUeG5zNDZkdCt2MGZ4?=
 =?utf-8?B?aFRTTEV6L1JnSHRVeGc1Q2swRytTTEo4YXRIUnRQRTg3ZmxkanJuUzRFVWo4?=
 =?utf-8?B?U0l6dFMzRGJJQldxZmMwckxiVXhEWmdqeG94cURuemsyRENmU1k4RS96OXZs?=
 =?utf-8?B?OGJ3SkFKNlhGUWNTaGplN2tjQXhQcXJaQ0E1M1hvREVOSGt1TzR2RHhjQUp1?=
 =?utf-8?B?b1AwUXJTTU4rWHdTdVBRMUJXd3FrVWp6V3N4SW41UHFWWlo0Zms5MThQcGhD?=
 =?utf-8?B?T2duNjc5QThJOHo2R2VDcE9WNGhXQ3FmaFovd1FNS2crQjhIVDNrZzRMNzl3?=
 =?utf-8?B?NzBpcWtyMmdzVnhVT3gvY2llMmVrN001T0JNdHRFN0NYUVpVMXdndUp5ZmZh?=
 =?utf-8?B?em90WUJPaXRnaGtPa0l6bXJzcXRJWTNUMTVUcGEyZ1RrQkcycVVOdlk0N0Rh?=
 =?utf-8?B?ZkkyaXRNTjVhTElkWThlK29iYi9pWUwwV2RzM2R4Tm5sdkNzNGtVTnpVUUdD?=
 =?utf-8?B?ZXlkdnhNTG8yVzMxUmJ5ZkttZ09wdUNGbHZPeDF5Mms1d1p6REc2WXZZYkc0?=
 =?utf-8?B?VUF5UXBrWmY5NjBINTlTVWRTamxudGtLTWxpS01raWFqNHNRbnYwTWc3WGdh?=
 =?utf-8?B?cXpYMzJYbkFIUlJUMWNBWTVPL2ZvWHF5eGpOU290cGdxRWxXMURZYUowRk9x?=
 =?utf-8?B?aEhhYkMycjZxN0FwSjRUWHFPL28rVGRHV295eG5UandQalpvU09VRTg5Z0dC?=
 =?utf-8?B?MnhUU0ZOWGdWM1g3TFd0UmlkVUROTnpHMWp4QUptbm15U09VMDJMOVFCKzY2?=
 =?utf-8?B?M2lrSkJUSEpBckI1UGd0cW1KcDdQM1FJdGp2Z2w4R0xZbStoZGlvQ0FlZE95?=
 =?utf-8?B?bXloenZqdjlLcHdaVjNGQmw2RTlRVFFnQ0VFNW1CN2pSQkRiZEdNeHRldVcw?=
 =?utf-8?B?M0tYd09OUFR2djVOSkY3Q2NYbllxS2JieU1UM3BSeWF3ZWErMnNuOW1SNnpV?=
 =?utf-8?B?SVUxM3EyRDQyTzlEZ0duaElDYTlGdWxUc3dTdG9IMUhXMHRYeThvOSthOUJ3?=
 =?utf-8?B?ZVA3V0hrRDhJN3lrRTFtalVxZ0VXRTJadjVWZmk5eEc5V0ZIbmpOSU1vc0hv?=
 =?utf-8?B?Yi9OLzU1bEdCaW9US0JrZWtxQ1REa0FjTDhkVHJNdWo2WjY0bzBCOXdaYW9q?=
 =?utf-8?B?aDRHN0hvSFV1bEtnSVl3azJ2Vk9XMEZvOVJYTkhZdTJqaVlYUnU5MkljbzEx?=
 =?utf-8?B?a3ZldmVjR0xTVGZsa1BNbWVHWjB4YjZNSUVBTXhvTm9HbXB5VFE2SFZNemls?=
 =?utf-8?B?Sjh6Rnl3M0hGOXJPaDFVRnlFZkdDY0ptOWN2QWdVNU1JMmpOYU5ma2V2eDYy?=
 =?utf-8?B?NzFmNlJCakcrSFQ5MnN5VTNNaXg3b3BpaUlzTHkwTGsxMnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5317.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFVIMmFGaUNDWEpyc2tCbGpwTlNWQmFrZU1xc3V5MWZvSGdWaXV2NDFCZ01Y?=
 =?utf-8?B?UVRqVjdTTlVFSnZpMHdNQ1l0aEI1dVhWcFdTUWJUTXZ1VmxnWlJsK1RjSUpT?=
 =?utf-8?B?OHA3NitCTitMNEllTHB3dUpzdHpmakNGQlhMbkp5YXJ0ZjdMbEUycjVVNDdm?=
 =?utf-8?B?cWNIWkhhL2pablh5RWVmTDg1WCsrbFhkTXFUUkdtYVRkOVBhQnpiaDNnS0ht?=
 =?utf-8?B?TStLQU5qZitKWXh1c3E4d1Qwck9MWjc4d0Z4THpWcmdIMitEc21vcGlBOGpx?=
 =?utf-8?B?U3FiNW81YWQ0djlTTUJ1aFdoUDlESzJmR0RNWEVlZHhhOVBVbjVsamVNTWV6?=
 =?utf-8?B?ZVVleWNacTJvN043R243clo2cjgvekNKNDBmQm8wUlI2ZU5seTZHM0F3clhx?=
 =?utf-8?B?aDcyZHlPOUI5VG5ZVExKemc1L21zcFAyMEdDRjRaNmgzTksxVGV6R3JNRG44?=
 =?utf-8?B?Yzk0VWltb3BoREFmUjd2cUhmeEFrdWVhQk5lT1FPZXBiaVF0ZlRLQVRza3FF?=
 =?utf-8?B?VW5jTmtLTWJFdEhtVDB1UFRMUDZyZXYyNCtMeHV3cFVDeXU1WmJSb1ptcEJD?=
 =?utf-8?B?cHU5RXFudndEUzFDdzdkMVZwUTNQcUxJdnllN0ZWQVl3L1k1VmV5YlkvUVpE?=
 =?utf-8?B?U1RKVHMvdG1UL2czMlVpeEtpd3lJZ0lJeVJLZ2grYkMxV0QwM3k1bmh0MVUy?=
 =?utf-8?B?aldXSjYwNzFxUnRFL1RjWUwwVnFibER2YjJiUGx0eTJFbmZDY2o5bWlyWHoy?=
 =?utf-8?B?d2hlQVpWdm1vdjloY3Eyand1N1Z3eWRBRHpBK3ZlOFNxNndpQkxucHpBUStS?=
 =?utf-8?B?ZW1oS1JUcCthS20xeEhVUGpUSEw3czVYZEhwUW9JTy9tNmRBdHNKUmVXVUVC?=
 =?utf-8?B?eTE3RVJ1eElvTEdXL2oxYXhaVDZRR0lxemxlSnQ2dzZhRUtST1B5UHFRRkVK?=
 =?utf-8?B?d0pTTTlDRHFmdmtYVTUwQTNncEU3WGJJUkhPcmZnaVd1S1dyK1Q2RDV5VEg4?=
 =?utf-8?B?OXlPNG4zVjU4LzlzVVJVZ21SZjB2NlJGcjZBODVBS2JETWcxeUtiUUI2d05q?=
 =?utf-8?B?UUxkT3VTRnhjTFlUeHozRkp1VGlBMEZuOGZpWTRadVJJK2ZUYnlkbjVCclJt?=
 =?utf-8?B?Zk1tZTNBaFFJdzVIMHdoUXZ1bWluKzRHeXFhUEpFRlZ6elJxWkFzcjc2UDBW?=
 =?utf-8?B?TnpOV0VxQ3QzNmIwL2lkeUl5SXlnd2lOK3ZLNjNlTDFvRC9MZHVGZy9RQUxx?=
 =?utf-8?B?aDhnRXFlREkzTFgvKzM5RzBldXg3S3VNWlRHcWJtVjBuNFdwNGZXek83RXhF?=
 =?utf-8?B?U095RWdhK2hReitwRTFkdHhTcHAxRTA1clpHQWlLV3FQa0l1VWFPSGdhMEVm?=
 =?utf-8?B?N2VuQ2JZMVJ1ejlTRXFNMG4zR3F2eWNyMXR3TFM2ejBFbllQSzhJOFZZRHF0?=
 =?utf-8?B?aXhUTktKUlBQL3QxUTdRUFpHTzQyLzVldzBxN05BZUtMVk1UZTF2QXV3Qkhm?=
 =?utf-8?B?UUNmcXF1cVBhd1BNRmZiaDJsdk53bEE1cVdvQTlVOVhTWkJGc1ovTHJkQjcz?=
 =?utf-8?B?SHRNQWtTMXNIZFFXRzdqQkRBUW8xeVFyVU9jRlRvTVpsbDUwT1ZQS1pjQkNM?=
 =?utf-8?B?SDRNendlWFYweXJkNm4vc0RpN0lRZXA3TXhpYjJpZUp0Y1o2eHdxNEJBSzQ5?=
 =?utf-8?B?Wm1TUzBERVUvYzBpbjdPT1duZUJwZm1lS3M5QWVsL0VsNEo0MW4zbWZLWEd3?=
 =?utf-8?B?R3pDLzY1Z3h1azV5ODFSZkY3TGRTODlUSEVwL0F5UlUxVGEzWGhKL1dWMTZr?=
 =?utf-8?B?R0tIdUlyN0NUYkxmMXNtc0Vub0FpS0tBUGJvTURKemI1OWcyeXBIdVlUaUxz?=
 =?utf-8?B?d2E2ZW1QYlpDNmdqQmJORGMya0Q0SVNVYTZBQjhYYndOLzVkSUNpSS9rYnpu?=
 =?utf-8?B?MUpPM09iOEZzKzQxRXpTY2JqWTZVOWs0OGlUb1dFUXlZcFJBeVU2U1BKcENt?=
 =?utf-8?B?K1JjVmxERFpmYStNaEpEZkxqZnpEbzA5VzJFcWhMb0czVGZXYjA2ek10OHdV?=
 =?utf-8?B?Mm5aYURqWjlhRHRKejJSNFN1aktPZlZXdDU2L3FHbEkya1EreThuTXZIVEZD?=
 =?utf-8?Q?soGc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a428734c-4130-4432-b0ad-08dd1964d462
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 21:51:40.6874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ESh5zOYI6B93ReeegtwsUEmCA1p3LIoWTPSvcrJxlLFliMgROrg7ZwDrk6goGE4d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451
Received-SPF: permerror client-ip=2a01:111:f403:2405::611;
 envelope-from=Zhigang.Luo@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBIaWxkZW5icmFu
ZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gU2VudDogVHVlc2RheSwgRGVjZW1iZXIgMTAsIDIwMjQg
Mjo1NSBQTQ0KPiBUbzogTHVvLCBaaGlnYW5nIDxaaGlnYW5nLkx1b0BhbWQuY29tPjsgcWVtdS1k
ZXZlbEBub25nbnUub3JnDQo+IENjOiBrcmF4ZWxAcmVkaGF0LmNvbTsgSWdvciBNYW1tZWRvdiA8
aW1hbW1lZG9AcmVkaGF0LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gaG9zdG1lbS1maWxl
OiBhZGQgdGhlICdobWVtJyBvcHRpb24NCj4NCj4gT24gMTAuMTIuMjQgMjA6MzIsIEx1bywgWmhp
Z2FuZyB3cm90ZToNCj4gPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIEludGVybmFsIERp
c3RyaWJ1dGlvbiBPbmx5XQ0KPiA+DQo+ID4gSGkgRGF2aWQsDQo+ID4NCj4NCj4gSGksDQo+DQo+
ID4+Pg0KPiA+Pj4gVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KPiA+Pj4gTGV0IG1lIGdpdmUg
eW91IHNvbWUgYmFja2dyb3VuZCBmb3IgdGhpcyBwYXRjaC4NCj4gPj4+IEkgYW0gY3VycmVudGx5
IGVuZ2FnZWQgaW4gYSBwcm9qZWN0IHRoYXQgcmVxdWlyZXMgdG8gcGFzcyB0aGUNCj4gPj4+IEVG
SV9NRU1PUllfU1ANCj4gPj4gKFNwZWNpYWwgUHVycG9zZSBNZW1vcnkpIHR5cGUgbWVtb3J5IGZy
b20gaG9zdCB0byBhIHZpcnR1YWwgbWFjaGluZQ0KPiA+PiB3aXRoaW4gUUVNVS4gVGhpcyBtZW1v
cnkgbmVlZHMgdG8gYmUgRUZJX01FTU9SWV9TUCB0eXBlIGluIHRoZQ0KPiA+PiB2aXJ0dWFsIG1h
Y2hpbmUgYXMgd2VsbC4NCj4gPj4+IFRoaXMgcGFydGljdWxhciBtZW1vcnkgdHlwZSBpcyBlc3Nl
bnRpYWwgZm9yIHRoZSBmdW5jdGlvbmFsaXR5IG9mIG15IHByb2plY3QuDQo+ID4+DQo+ID4+IFdo
aWNoIGV4YWN0IGd1ZXN0IG1lbW9yeSB3aWxsIGJlIGJhY2tlZCBieSB0aGlzIG1lbW9yeT8gQWxs
IGd1ZXN0LW1lbW9yeT8NCj4gPiBbTHVvLCBaaGlnYW5nXSBub3QgYWxsIGd1ZXN0LW1lbW9yeS4g
T25seSB0aGUgbWVtb3J5IHJlc2VydmVkIGZvciBzcGVjaWZpYw0KPiBkZXZpY2UuDQo+DQo+IENh
biB5b3Ugc2hvdyBtZSBhbiBleGFtcGxlIFFFTVUgY21kbGluZSwgYW5kIGhvdyB5b3Ugd291bGQg
cGFzcyB0aGF0DQo+IGhvc3RtZW0tZmlsZSBvYmplY3QgdG8gdGhlIGRldmljZT8NCj4NCltMdW8s
IFpoaWdhbmddIHRoZSBmb2xsb3dpbmcgaXMgYW4gZXhhbXBsZS4gbTEgaXMgdGhlIHJlc2VydmVk
IG1lbW9yeSBmb3IgcGNpIGRldmljZSAiMDAwMDowMzowMC4wIi4gYm90aCB0aGUgbWVtb3J5IGFu
ZCBwY2kgZGV2aWNlIGFyZSBzZXQgdG8gc2FtZSBudW1hIG5vZGUuDQoNCi1vYmplY3QgbWVtb3J5
LWJhY2tlbmQtcmFtLHNpemU9OEcsaWQ9bTAgXA0KLW9iamVjdCBtZW1vcnktYmFja2VuZC1maWxl
LHNpemU9MTZHLGlkPW0xLG1lbS1wYXRoPS9kZXYvZGF4MC4wLHByZWFsbG9jPW9uLGFsaWduPTFH
LGhtZW09b24gXA0KLW51bWEgbm9kZSxub2RlaWQ9MCxtZW1kZXY9bTAgLW51bWEgbm9kZSxub2Rl
aWQ9MSxtZW1kZXY9bTEgXA0KLWRldmljZSBweGItcGNpZSxpZD1wY2llLjEsbnVtYV9ub2RlPTEs
YnVzX25yPTIsYnVzPXBjaWUuMCBcDQotZGV2aWNlIGlvaDM0MjAsaWQ9cGNpZV9wb3J0MSxidXM9
cGNpZS4xLGNoYXNzaXM9MSBcDQotZGV2aWNlIHZmaW8tcGNpLGhvc3Q9MDAwMDowMzowMC4wLGlk
PWhvc3RkZXYwLGJ1cz1wY2llX3BvcnQxDQoNCj4gPg0KPiA+Pg0KPiA+PiBBbmQsIHdoYXQgaXMg
dGhlIGd1ZXN0IE9TIGdvaW5nIHRvIGRvIHdpdGggdGhpcyBtZW1vcnk/DQo+ID4gW0x1bywgWmhp
Z2FuZ10gdGhlIGRldmljZSBkcml2ZXIgaW4gZ3Vlc3Qgd2lsbCB1c2UgdGhpcyByZXNlcnZlZCBt
ZW1vcnkuDQo+DQo+IE9rYXksIHNvIGp1c3QgbGlrZSBDWEwgbWVtb3J5Lg0KPg0KPiA+DQo+ID4+
DQo+ID4+IFVzdWFsbHksIHRoaXMgU1AgbWVtb3J5IChkYXgsIGN4bCwgLi4uKSBpcyBub3QgdXNl
ZCBhcyBib290IG1lbW9yeS4NCj4gPj4gTGlrZSBvbiBhIGJhcmUgbWV0YWwgc3lzdGVtLCBvbmUg
d291bGQgZXhwZWN0IHRoYXQgb25seSBDWEwgbWVtb3J5DQo+ID4+IHdpbGwgYmUgbWFya2VkIGFz
IHNwZWNpYWwgYW5kIHB1dCBhc2lkZSB0byB0aGUgY3hsIGRyaXZlciwgc3VjaCB0aGF0DQo+ID4+
IHRoZSBPUyBjYW4gYm9vdCBvbiBvcmRpbmFyeSBESU1Ncywgc3VjaCB0aGF0IGN4bCBjYW4gb25s
aW5lIGl0IGV0Yy4NCj4gPj4NCj4gPj4gU28gbWF5YmUgeW91IHdvdWxkIHdhbnQgdG8gZXhwb3Nl
IHRoaXMgbWVtb3J5IHVzaW5nIENYTC1tZW0gZGV2aWNlIHRvDQo+ID4+IHRoZSBWTT8gT3IgYSBE
SU1NPw0KPiA+Pg0KPiA+PiBJIGFzc3VtZSB0aGUgYWx0ZXJuYXRpdmUgaXMgdG8gdGVsbCB0aGUg
Vk0gb24gdGhlIExpbnV4IGtlcm5lbA0KPiA+PiBjbWRsaW5lIHRvIHNldCBFRklfTUVNT1JZX1NQ
IG9uIHRoaXMgbWVtb3J5LiBJIHJlY2FsbCB0aGF0IHRoZXJlIGlzIGEgd2F5IHRvDQo+IGFjaGll
dmUgdGhhdC4NCj4gPj4NCj4gPiBbTHVvLCBaaGlnYW5nXSBJIGtub3cgdGhpcyBvcHRpb24uIGJ1
dCBpdCByZXF1aXJlcyB0aGUgZW5kIHVzZXIgdG8ga25vdyB3aGVyZSBpcyB0aGUNCj4gbWVtb3J5
IGxvY2F0aW9uIGluIGd1ZXN0IHNpZGUoc3RhcnQgYWRkcmVzcywgc2l6ZSkuDQo+DQo+IFJpZ2h0
Lg0KPg0KPiA+DQo+ID4NCj4gPj4+IEluIExpbnV4LCB0aGUgU1BNIG1lbW9yeSB3aWxsIGJlIGNs
YWltZWQgYnkgaG1lbS1kYXggZHJpdmVyIGJ5DQo+ID4+PiBkZWZhdWx0LiBXaXRoDQo+ID4+IHRo
aXMgcGF0Y2ggSSBjYW4gdXNlIHRoZSBmb2xsb3dpbmcgY29uZmlnIHRvIHBhc3MgdGhlIFNQTSBt
ZW1vcnkgdG8gZ3Vlc3QgVk0uDQo+ID4+PiAtb2JqZWN0DQo+ID4+PiBtZW1vcnktYmFja2VuZC1m
aWxlLHNpemU9MzBHLGlkPW0xLG1lbS1wYXRoPS9kZXYvZGF4MC4wLHByZWFsbG9jPW9uLA0KPiA+
Pj4gYWwNCj4gPj4+IGlnbj0xRyxobWVtPW9uDQo+ID4+Pg0KPiA+Pj4gSSB3YXMgdGhpbmtpbmcg
dG8gY2hhbmdlIHRoZSBvcHRpb24gbmFtZSBmcm9tICJobWVtIiB0byAic3BtIiB0bw0KPiA+Pj4g
YXZvaWQNCj4gPj4gY29uZnVzaW9uLg0KPiA+Pg0KPiA+PiBMaWtlbHkgaXQgc2hvdWxkIGJlIHNw
ZWNpZmllZCBlbHNld2hlcmUsIHRoYXQgeW91IHdhbnQgc3BlY2lmaWMgZ3Vlc3QNCj4gPj4gUkFN
IHJhbmdlcyB0byBiZSBFRklfTUVNT1JZX1NQLiBGb3IgYSBESU1NLCBpdCBjb3VsZCBiZSBhIHBy
b3BlcnR5LA0KPiA+PiBzaW1pbGFybHkgbWF5YmUgZm9yIENYTC0gbWVtIGRldmljZXMgKG5vIGV4
cGVydCBvbiB0aGF0KS4NCj4gPj4NCj4gPj4gRm9yIGJvb3QgbWVtb3J5IC8gbWFjaGluZSBtZW1v
cnkgaXQgY291bGQgYmUgYSBtYWNoaW5lIHByb3BlcnR5LiBCdXQNCj4gPj4gSSdsbCBmaXJzdCBo
YXZlIHRvIGxlYXJuIHdoaWNoIHJhbmdlcyB5b3UgYWN0dWFsbHkgd2FudCB0byBleHBvc2UNCj4g
Pj4gdGhhdCB3YXksIGFuZCB3aGF0IHRoZSBWTSB3aWxsIGRvIHdpdGggdGhhdCBpbmZvcm1hdGlv
bi4NCj4gPiBbTHVvLCBaaGlnYW5nXSB3ZSB3YW50IHRvIGV4cG9zZSB0aGUgU1BNIG1lbW9yeSBy
ZXNlcnZlZCBmb3Igc3BlY2lmaWMgZGV2aWNlLg0KPiBBbmQgd2Ugd2lsbCBwYXNzIHRoZSBTUE0g
bWVtb3J5IGFuZCB0aGUgZGV2aWNlIHRvIGd1ZXN0LiBUaGVuIHRoZSBkZXZpY2UgZHJpdmVyDQo+
IGNhbiB1c2UgdGhlIFNQTSBtZW1vcnkgaW4gZ3Vlc3Qgc2lkZS4NCj4NCj4gVGhlbiB0aGUgZGV2
aWNlIGRyaXZlciBzaG91bGQgbGlrZWx5IGhhdmUgYSB3YXkgdG8gY29uZmlndXJlIHRoYXQsIG5v
dCB0aGUgbWVtb3J5DQo+IGJhY2tlbmQuDQo+DQo+IEFmdGVyIGFsbCwgdGhlIGRldmljZSBkcml2
ZXIgd2lsbCBtYXAgaXQgc29tZWhvdyBpbnRvIGd1ZXN0IHBoeXNpY2FsIGFkZHJlc3Mgc3BhY2UN
Cj4gKGhvdz8pLg0KPg0KW0x1bywgWmhpZ2FuZ10gZnJvbSBndWVzdCB2aWV3LCBpdCdzIHN0aWxs
IHN5c3RlbSBtZW1vcnksIGJ1dCBtYXJrZWQgYXMgU1BNLiBTbywgcWVtdSB3aWxsIG1hcCB0aGUg
bWVtb3J5IHRvIGd1ZXN0IHBoeXNpY2FsIGFkZHJlc3Mgc3BhY2UuDQpUaGUgZGV2aWNlIGRyaXZl
ciBqdXN0IGNsYWltcyB0byB1c2UgdGhlIFNQTSBtZW1vcnkgaW4gZ3Vlc3Qgc2lkZS4NCg0KPiA+
DQo+ID4+DQo+ID4+Pg0KPiA+Pj4gRG8geW91IGhhdmUgYW55IHN1Z2dlc3Rpb25zIHRvIGFjaGll
dmUgdGhpcyBtb3JlIHJlYXNvbmFibGU/DQo+ID4+DQo+ID4+IFRoZSBwcm9ibGVtIHdpdGggcWVt
dV9yYW1fZm9yZWFjaF9ibG9jaygpIGlzIHRoYXQgeW91IHdvdWxkIGluZGljYXRlDQo+ID4+IGFs
c28gRElNTXMsIHZpcnRpby1tZW0sIC4uLiBhbmQgZXZlbiBSQU1CbG9ja3MgdGhhdCBhcmUgbm90
IGV2ZW4gdXNlZA0KPiA+PiBmb3IgYmFja2luZyBhbnl0aGluZyB0byB0aGUgVk0gYXMgRUZJX01F
TU9SWV9TUCwgd2hpY2ggaXMgd3JvbmcuDQo+ID4gW0x1bywgWmhpZ2FuZ10gcWVtdV9yYW1fZm9y
ZWFjaF9ibG9jaygpIHdpbGwgbGlzdCBhbGwgbWVtb3J5IGJsb2NrLCBidXQgaW4NCj4gcGNfdXBk
YXRlX2htZW1fbWVtb3J5KCksIG9ubHkgdGhlIG1lbW9yeSBibG9jayB3aXRoICJobWVtIiBmbGFn
IHdpbGwgYmUNCj4gdXBkYXRlZCB0byBTUE0gbWVtb3J5Lg0KPg0KPiBZZXMsIGJ1dCBpbWFnaW5l
IGEgdXNlciBwYXNzaW5nIHN1Y2ggYSBtZW1vcnkgYmFja2VuZCB0byBhIERJTU0vdmlydGlvLW1l
bS9ib290DQo+IG1lbW9yeSBldGMuIEl0IHdpbGwgaGF2ZSB2ZXJ5IHVuZGVzaXJlZCBzaWRlIGVm
ZmVjdHMuDQo+DQpbTHVvLCBaaGlnYW5nXSB0aGUgdXNlciBzaG91bGQga25vdyB3aGF0IGhlL3No
ZSBpcyBkb2luZyB3aGVuIGhlL3NoZSBzZXQgdGhlIGZsYWcgZm9yIHRoZSBtZW1vcnkgcmVnaW9u
Lg0KDQoNCj4gLS0NCj4gQ2hlZXJzLA0KPg0KPiBEYXZpZCAvIGRoaWxkZW5iDQoNCg==

