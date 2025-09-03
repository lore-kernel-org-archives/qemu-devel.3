Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D08CA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 08:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utj1K-0007AU-Le; Wed, 03 Sep 2025 04:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1utj1H-0007A2-Nt; Wed, 03 Sep 2025 04:39:07 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1utj1F-0007OW-IG; Wed, 03 Sep 2025 04:39:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnO45Tt1IIINdXRax2UBG2a/C5V9VGNjoiWfh36IlCmO80dwTFYEnqLurqrgm3iPX2ybXXj+Naxrr6hYcvjVe2jvlVpJ4tgpUofeOIipfHeGbHwfKxg21l4FJtDaKEaFTnybVBDm+uNXeRQ25hzaD+e2RuND0xy7H2uUdgoxyFje0nkXEyGscQqkFnQFixSi2h19HN5tta8aiQXJ0VOFkEVAB9SyrS/K4sUYRNIT/a6ywCSYguxwIMXAmd8l/16g6QVNk59TPJ5CGvjzxR+UBegk1eVWbgkEuRvnmwDiYc+N1tldvjGS/83dBMcKvEyaTpcDVJhn10gbUY2JGxyb8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKSiG9b+n14yEXt0Hx5Li+39lSNt6JHLMV3iWgvFLnA=;
 b=EW4U4Rjm1dD9VHJdp01pKKZFQ3tTO4thNyRFwnILj8Tg9b8p1ZrH0HrdbwvZjpGWQSzQQYpoqei5nkToDonEx31x2+I3RH06fx61pfGrHWb9ATCRgf6rJXFieO1I8erV28g63Glh926myuLf0H83o549oYkMIdE50sLhvvbSSGpbKRx+guNtO4oE7FCq+PTVuNDx/LrCP7GTSYh9rK5KZO+XwxxY0w6F+BEnjyQzpOfBjuZujGxjD5OK+KacbjDNk2I93LHEZ5VqlRv6gSYxmeEnnw1hkkpyNKYLupUKOXU682B12SmLDnQJc/nfS8cMVXYcHQ+uf13M7c+n0JCGJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKSiG9b+n14yEXt0Hx5Li+39lSNt6JHLMV3iWgvFLnA=;
 b=r7y51t5iMwQJDnFHb4/UZE1Fq16tWJ6NFjoWCu9Q6GuuJBSz3+03SL2Ffee/gCgQQq44aHvy/Ws2MQyjEFa5/3GjQ4Aun6mrask6XU/42k89uPUGzBJvf4sMyhHgkCabg17Qn6mfPAqcaRc6JJBI3e/7W5CWE6Ryzy7p8v6r9xs26gqX2GJkciBryg8/FeWG1yD6pvcmPdHsMXQILDP+6Y8MvEcnEdxf8rC8UCQMCEPGFQspKpgKt7uCnzgaFgmtz3QAVzyBjEie09hE8sjcHJE72VRfNCaGZwRA3z4ogZUatRFs5JHfmfD0DE56KfFJdSz7KiQ/87Y6CS1m+QRNjA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PA2PR09MB7346.eurprd09.prod.outlook.com (2603:10a6:102:40c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Wed, 3 Sep
 2025 08:38:59 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9052.019; Wed, 3 Sep 2025
 08:38:59 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com"
 <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>
Subject: Re: [PATCH v7 04/14] target/riscv: Add MIPS P8700 CSRs
Thread-Topic: [PATCH v7 04/14] target/riscv: Add MIPS P8700 CSRs
Thread-Index: AQHcGys8Klg4nakYSUWO+0bMvmC/nLR+I6CAgAMCa4A=
Date: Wed, 3 Sep 2025 08:38:59 +0000
Message-ID: <5aaa4f39-4524-4247-af7c-e31bc99e77ed@htecgroup.com>
References: <20250901102850.1172983-1-djordje.todorovic@htecgroup.com>
 <20250901102850.1172983-5-djordje.todorovic@htecgroup.com>
 <aLV4XVR6baQpZRD_@redhat.com>
In-Reply-To: <aLV4XVR6baQpZRD_@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PA2PR09MB7346:EE_
x-ms-office365-filtering-correlation-id: adcc9e35-f91e-458a-817d-08ddeac5540e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?WVp0dUJNMGxTZ01mUk5LOG5RUVM1R0lnRVBMeWR4NjZoTFVmVEs1RC9PK3Ru?=
 =?utf-8?B?TW5GaWNYRE5vVDd6KzgrcGpUS0lIbThra2E2eG5IVWJOcGd2L1pCTjF3SG1T?=
 =?utf-8?B?eks4UnUyaGJncklhMEZ1cVMwQ1k4TVVSemFJcUFTSmZkSmJ5d0pqRGwrU3NI?=
 =?utf-8?B?b3dUNmhIUzRlMDlHaVNVVnp1cVc4T1ltYWFPVlhuRVFDaVNMQmVkVGd3M3R0?=
 =?utf-8?B?WnRnb3dYbTI0YXM4dzNBZTR3ODdBanlTM3VCK3JtY0tYbjZUMFY2RHJiTmJL?=
 =?utf-8?B?SzlQM1RPK2NrR3NnSzRhN1d2b3dpNFJWcFh3a2NOQVU2Qm1rNVJPeUNpV2l2?=
 =?utf-8?B?clhsSElIZmRXUzhiRTIybEJvZ2dxVzNPQVNKSk85WkFlaHdLZ3owUXJCMDBV?=
 =?utf-8?B?VXZXUnNlNURFeXgwKzBtd0p2ZUxhY2QxZXM5LzU0UzZDOUF3N080dGRoRHNy?=
 =?utf-8?B?UjNSWTF3dGNrb1U2Qy9IUEo4eXgrZ1VydnNtTkRUblFjODB5NXMrRUU0T3lv?=
 =?utf-8?B?czBMamVVejlCRGdiSTFLSXRlNjJ0RnJ1WUF6ejEyT3VadURZRUZCS2g4eXBM?=
 =?utf-8?B?T09hVlpnZm5rbk10RDIxMGJaUHpQSCtUb0VWZUoxMGpLMlFORytkTTcwTFJv?=
 =?utf-8?B?MzRaT2xxWmlWMkVBcGV0TnJJeTN3TTFZMmJ4dG9NY0VmcW02TktYUllMMkdj?=
 =?utf-8?B?bStwMlcxa2JNSjhleGVoMmdUaWpKVVV3Q1Bpd05KR05sSTNPdzF3U1A0NWxK?=
 =?utf-8?B?QlRjMG4vZnBpQWNyZU9IMktKRGI2cWVFbU1kd1pXRzNwclBLd2RzVjVSNzA1?=
 =?utf-8?B?ZENScmhHRkVQSTkzdUJjS3V4eWEwV21aYWVaR1V6VDVSbXRkQVNiYWE0SmVU?=
 =?utf-8?B?dzhIald5SlFqTG1neXdXeG03K0lEb3B0VndJb1J1eUR0OFdFVTAvOGFDbit6?=
 =?utf-8?B?K3JTV2pRdlF5MVkyc0NCSSsrTlYyb0oxOFBVZW5nc1VUQVg5VTdzSFRPVU9j?=
 =?utf-8?B?Mi9wckRSd3p3ZzBVU3NBL3pZSjFoSzkrMzFIZ1l5dDE3S2lDRmgzdVBLam42?=
 =?utf-8?B?TmVWc2xnSmdSOGt1d25MZnVFTytuQldZRkczUUQwc3ZvTjZJWlJJUDFBTHow?=
 =?utf-8?B?VHlGdG9BY3NySjlyWnBZNXpZWVhydktXYTBBd3pjQUYvaUxIWm1RK3pydmZl?=
 =?utf-8?B?RHk2TXFSZGJ6d0RSUCtvNy9LdllxdFp1ZGQvV1NiQW9ubE8zcytWd1hZYkdZ?=
 =?utf-8?B?MXdpV01sVFlLdVhyMWVidEZ1MG0wUVJEWGthVnpNaStKc1pWblB4Si9sNkdu?=
 =?utf-8?B?SytwUVp0S3dIVExCT3l6N3Vza0VCUGdwSEZQOHYzS2t6bnZObUxEWGIxSWFF?=
 =?utf-8?B?YS81cko0L01YNUIrRXIxeHNJUSs3a1NCR21jTy9pd0g2SzljUzc4Mkt1NU8y?=
 =?utf-8?B?b2ZMSXUvUFpZODFnS2dKQUlOTkFhUnJLZmRHamFsQ043QzNCcEdTTitLSmhC?=
 =?utf-8?B?NkVpUWI1QkJKTkRIOVJyOTlibWVrVS85a0ZqSGd2Uit2enBCZW56K01QZ3dW?=
 =?utf-8?B?MWZkd0I2b3c5ZVRUT3B1YzFzQTYya1h3OVJOTC9XV2ZEZzMvaXdqNTQrSUJh?=
 =?utf-8?B?aW8zQXpMN201dTNSSzBOUzdreUgxODM5TXVFWFFxZm91c05BL294Z1Q0N3h2?=
 =?utf-8?B?K2tKZU9GanFEdmpOakdkT1lJcmNyQXhTYU81NXE3ZlFvYTdUZUY2bUY0eWND?=
 =?utf-8?B?akJCVnpvZEpneWEyRDJRWTFWajdxSTVLRmlrM3hGTnR4Zkp4QmErL2ZNazBD?=
 =?utf-8?B?SkJrZlhQUWluYmpiK29ONVVBZWRodnBOaHIrTWIweGxzdnExWTRqclFveE1G?=
 =?utf-8?B?SXg4Q1N4ODFvWGtJUHJicThwNzRhbUc4MUhkaDBVc0llaXJYeWZSRmxwbkR0?=
 =?utf-8?Q?tcInYQ/zDNE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWhqQ1BONGJVSnJwWUlBY29Ob05pSGlqRHdpemFJSzZxaVo2YThMSFBoYUFz?=
 =?utf-8?B?NVJGQWJaeHhiYXhhQUtzUmJMa0tPNHo2V1F6UjA2cDgycUhQR2NVVmxSVitT?=
 =?utf-8?B?MzVJRnU4ZnpGS0RzZno5OEIwTDVnOUNLKzYxTHk1RjFoVVVmcHFTY2NHTFcy?=
 =?utf-8?B?VFoxdmtpdWd4UUxRclBYK3VFa2FvTGRRWU45d0MzNGw0WXpGU2haRG9sVXZq?=
 =?utf-8?B?VEROLzY4NmpOQVhUckV6THVVYVNiV1JEODFCZUg1UUR2Q012NDBQZGcxQXhH?=
 =?utf-8?B?T1M0K1pnOHZ2Z0dVZnF0UnpWQXFoUElOSFpLZXFGbXlhM2JsSDRIUGRTcFJZ?=
 =?utf-8?B?aUdGTzRLWXlpOXdURVdWbUFleVd0ZWtFbkIxaXVMS2NOWGp2NzNPRFIzNE81?=
 =?utf-8?B?WWRmQ29vRWFmYk52WkJ3ZGNlRnUvMDd5dVFQdktEa2NIM0dnSS9WRGZDRzFB?=
 =?utf-8?B?eTkyL3VaRlhCb3A0ZjNDNHZFVUdtVEtIZFhoWk14c0pYZXFpM21XalRXRDBN?=
 =?utf-8?B?RkVuMDYyVnhXRVppMWppVWpQQWxnQXFQUGNpbXdCM0hlM3NjUzVlSzRsRmIv?=
 =?utf-8?B?eVcxSmxzRXU3RzJqRmVNa2taRDRETXRNVCt4blMxdGFEai91VWR2YkdLZEJD?=
 =?utf-8?B?Y21ZbDBKcDM2S0hvUEJjUnFoZkZFSnMwbnFhQTlSMzk5L05hb29kZ2tmam5s?=
 =?utf-8?B?RVA0cWdkN2VSamlxUkg4RHlucjlyZ1RSaHpzeU5vU3lPUTVKUG5xbGgxVUN2?=
 =?utf-8?B?eXZPTXQ0QTZKcG1BNFBrL044aG1CM2hRelU3Rks5QUtVSGxvejBIRnZrRE9r?=
 =?utf-8?B?RWhHMk1QMkRoVDVnKzNTMGw3MkdTRGVXMm5LWXRCQzBXNE9LemVQcnZlV1cv?=
 =?utf-8?B?VWtxWjBwSDdLSXpYOXlGQVdrZmdHQTVEOUZCUVkwUTRTSHh3OGIwaHBrVjhU?=
 =?utf-8?B?SHBiSjN2eDJpVE5RanFENXhHbUI1ZnQ3SnFyTE9rZVRwL3d3Mlp3d0RiYkFG?=
 =?utf-8?B?RTRxNVFMSFhYM3BOSTJtTnJyQm9tcXcrUHZmd3JiWVVIL1JQZlRZeHNJL2xR?=
 =?utf-8?B?YjkwbzFjN2E1WUpyaW5SYkxzOGlLOTRHci8rK2Y3bVZhd0RqT0k3ZUo1M2Ry?=
 =?utf-8?B?b085UjVraFgxRVphajZUNVA5SzV4bWoySEFRZTMrL2V2Rm80Nk96czF2UzNC?=
 =?utf-8?B?Ryt1M0g5OVdMTXhzN1crTm1HQlNyTFFrSlhWVlBsd3g2WVR0M1ZVdXRzbzFY?=
 =?utf-8?B?SE80YWFMb1NVUkw1c25aUXlZZ0FLZHgwcUd2Y0IyckNwNkxQQzFIWk9FZDY5?=
 =?utf-8?B?L1EyN2s4Wm5BL25wbTNXTnp0aEh0RGRUb1lkbUp3SURCc01FaUJ5WEJpWDZV?=
 =?utf-8?B?aUN3Z1dINnNhRGFLanRtVVNZWmFESkgyY2FlanNEM1Z4K212aXVsMDlxUFcr?=
 =?utf-8?B?eUhLL0tNZkNPTlhCZUdnVHUwUE1aSWJ4dzhJL1pBc0hHNjlpZHI5bFFDNFBq?=
 =?utf-8?B?M3NuWVJtUG5lbFl6OW5JdkVaczhkTWttQUw5RzFLRkVCQkRiYXZHdk5KNmJQ?=
 =?utf-8?B?YktTQ1ZuK285YUFUcXNjdFZITTFBVVZBd0V5UVB4VTlnUmRNS0kwUGY3MkRW?=
 =?utf-8?B?bnVxR2dhdXltanZDTWNlcHpMSGE5cklVSjZpeEZMWThVY3hDT0loUDZ0Nk1P?=
 =?utf-8?B?eFV5aWQ0TmRhMStzQm5RK3NOYmZ2OVhYV1BYWlpCMzhjSzFyN2xXZXlYRDBX?=
 =?utf-8?B?b2wvb0pzdHpnWURYcGFNVXkyYmtCRXRITnVMdndUMzNTUFk0Ull3bFhYemFZ?=
 =?utf-8?B?cG5lQXNpR0dTeEhQY2t6ODZiNjJGMTUremVjMmRPZzBacGxndGZOK3pXL0lp?=
 =?utf-8?B?RFUvNDI1ZVBXQkg3a3JzSmkvRFNyaWg5dW9jNU5EeG1nUVZEWk9GRFFMRllp?=
 =?utf-8?B?emVWcUJNNHVXSmhFS3NSZ2FvUWRMT1lyMWpCUzlNOXpSWFJyeUxYVDRZMjBs?=
 =?utf-8?B?cjRyT0lwYmNEUmptUzlkcE1aeGdSWUNLL1JWeTJVK0NrN1A5MGN1Rk5jZHQ4?=
 =?utf-8?B?UUtsUGxHei84dFF5RDYwT05jRUIrK1ppMmNHSTRPU280YThubVF0eE9pKzJj?=
 =?utf-8?B?L0k3MFIrOWcrUlBCY1ZnZzR4WHRrRkZMNUJkVnFpUnk1bGtMRjFTbUdqT1hF?=
 =?utf-8?Q?Ss+Btl9NZf87uwYJoH4PQTI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18BE5D6BD64A844DA80D2C9F6CE1CEE6@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adcc9e35-f91e-458a-817d-08ddeac5540e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 08:38:59.5570 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KKHbIXuLKrZiK3R750NL0vY/NDNtF+i5b3TTsZnTNtWouSClA87/9qLFKX/VhevMIyJx8bvT2j6y7oty3nGHKqp7XhV5bgNSqAngtpiddi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR09MB7346
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

SGkgRGFuaWVsLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVudHMhDQoNCk9uIDEuIDkuIDI1
LiAxMjo0MSwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3cm90ZToNCj4gW1lvdSBkb24ndCBvZnRlbiBn
ZXQgZW1haWwgZnJvbSBiZXJyYW5nZUByZWRoYXQuY29tLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBv
cnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0N
Cj4NCj4gQ0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUg
b3JnYW5pemF0aW9uLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxl
c3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUu
DQo+DQo+DQo+IE9uIE1vbiwgU2VwIDAxLCAyMDI1IGF0IDEwOjI5OjAyQU0gKzAwMDAsIERqb3Jk
amUgVG9kb3JvdmljIHdyb3RlOg0KPj4gRGVmaW5lIE1JUFMgQ1NScyB1c2VkIGZvciBQODcwMCBD
UFUuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hhby15aW5nIEZ1IDxjZnVAbWlwcy5jb20+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBEam9yZGplIFRvZG9yb3ZpYyA8ZGpvcmRqZS50b2Rvcm92aWNAaHRl
Y2dyb3VwLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBEYW5pZWwgSGVucmlxdWUgQmFyYm96YSA8ZGJh
cmJvemFAdmVudGFuYW1pY3JvLmNvbT4NCj4+IC0tLQ0KPj4gICB0YXJnZXQvcmlzY3YvY3B1LmMg
ICAgICAgfCAgIDMgKw0KPj4gICB0YXJnZXQvcmlzY3YvY3B1LmggICAgICAgfCAgIDMgKw0KPj4g
ICB0YXJnZXQvcmlzY3YvbWVzb24uYnVpbGQgfCAgIDEgKw0KPj4gICB0YXJnZXQvcmlzY3YvbWlw
c19jc3IuYyAgfCAyMjggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
PiAgIDQgZmlsZXMgY2hhbmdlZCwgMjM1IGluc2VydGlvbnMoKykNCj4+ICAgY3JlYXRlIG1vZGUg
MTAwNjQ0IHRhcmdldC9yaXNjdi9taXBzX2Nzci5jDQo+PiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jp
c2N2L21pcHNfY3NyLmMgYi90YXJnZXQvcmlzY3YvbWlwc19jc3IuYw0KPj4gbmV3IGZpbGUgbW9k
ZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAuLjJmYzEwYjg2MTgNCj4+IC0tLSAvZGV2L251
bGwNCj4+ICsrKyBiL3RhcmdldC9yaXNjdi9taXBzX2Nzci5jDQo+PiBAQCAtMCwwICsxLDIyOCBA
QA0KPj4gKy8qDQo+PiArICogTUlQUy1zcGVjaWZpYyBDU1JzLg0KPj4gKyAqDQo+PiArICogQ29w
eXJpZ2h0IChjKSAyMDI1IE1JUFMNCj4+ICsgKg0KPj4gKyAqIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBMR1BMLTIuMS1vci1sYXRlcg0KPiBXaGF0IGlzIHRoZSByZWFzb24gZm9yIHRoaXMgY2hv
aWNlID8NCj4NCj4gTmV3IGZpbGVzIGFyZSBleHBlY3RlZCB0byBiZSBHUEwtMi4wLW9yLWxhdGVy
LCB3aXRoIGFueSBkaXZlcmdlbmNlDQo+IGZyb20gdGhpcyBleHBsYWluZWQgaW4gdGhlIGNvbW1p
dCBtZXNzYWdlLg0KPg0KTm8gcmVhc29uLCBJIHdpbGwgY2hhbmdlIGl0IGluIHY4Lg0KDQo+PiAr
ICoNCj4+ICsgKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3Ry
aWJ1dGUgaXQgYW5kL29yIG1vZGlmeSBpdA0KPj4gKyAqIHVuZGVyIHRoZSB0ZXJtcyBhbmQgY29u
ZGl0aW9ucyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UsDQo+PiArICogdmVyc2lv
biAyIG9yIGxhdGVyLCBhcyBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlv
bi4NCj4+ICsgKg0KPj4gKyAqIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9w
ZSBpdCB3aWxsIGJlIHVzZWZ1bCwgYnV0IFdJVEhPVVQNCj4+ICsgKiBBTlkgV0FSUkFOVFk7IHdp
dGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZiBNRVJDSEFOVEFCSUxJVFkgb3INCj4+
ICsgKiBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUgR05VIEdlbmVy
YWwgUHVibGljIExpY2Vuc2UgZm9yDQo+PiArICogbW9yZSBkZXRhaWxzLg0KPj4gKyAqDQo+PiAr
ICogWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVi
bGljIExpY2Vuc2UgYWxvbmcgd2l0aA0KPj4gKyAqIHRoaXMgcHJvZ3JhbS4gIElmIG5vdCwgc2Vl
IDxodHRwOi8vd3d3LmdudS5vcmcvbGljZW5zZXMvPi4NCj4gVGhpcyBzaG91bGQgbm90IGJlIHBy
ZXNlbnQgb24gbmV3bHkgYXV0aG9yZWQgZmlsZXMgLSBvbmx5IHByZS1leGlzdGluZw0KPiBjb2Rl
IHdoaWNoIHByZWRhdGVkIG91ciB1c2Ugb2YgU1BEWCB0YWdzLCBiZWNhdXNlIGl0IGNyZWF0ZXMg
dGhlIHBvc3NpYmxlDQo+IHByb2JsZW0gb2YgaW5jb25zaXN0ZW50IGxpY2Vuc2UgZGV0YWlscyAt
IHdoaWNoIGlzIHdoYXQgeW91IGhhdmUgaGVyZS4NCj4NCj4gVGhpcyBpcyBzYXlpbmcgR1BMLTIu
MC1vci1sYXRlciwgd2hpbGUgdGhlIFNEUFggdGFnIHNheXMgTEdQTC0yLjEtb3ItbGF0ZXINCj4N
Cj4gVGhlc2UgcG9pbnRzIGFwcGx5IHRvIG11bHRpcGxlIHBhdGNoZXMgaW4gdGhpcyBzZXJpZXMu
DQo+DQo+IFBsZWFzZSBtYWtlIHN1cmUgdG8gcnVuICdjaGVja3BhdGNoLnBsJyBvbiBwYXRjaGVz
IGJlZm9yZSBzdWJtaXNzaW9ucywNCj4gYXMgaXQgd291bGQgaGF2ZSByZXBvcnRlZCB0aGVzZSBw
cm9ibGVtcy4NCg0KV2VsbCwgSSBkaWQgaXQsIGJ1dCBpdCByZXBvcnRlZCB0aGF0IGFzIHdhcm5p
bmcsIHNvIEkgYXNzdW1lZCBpdCBpcyBva2F5IHRvDQoNCnByb2NlZWQgdGhhdCB3YXkuIFdpbGwg
Zml4IGl0Lg0KDQoNCkJlc3QsDQoNCkRqb3JkamUNCg0KDQo+IFdpdGggcmVnYXJkcywNCj4gRGFu
aWVsDQo+IC0tDQo+IHw6IGh0dHBzOi8vYmVycmFuZ2UuY29tICAgICAgLW8tICAgIGh0dHBzOi8v
d3d3LmZsaWNrci5jb20vcGhvdG9zL2RiZXJyYW5nZSA6fA0KPiB8OiBodHRwczovL2xpYnZpcnQu
b3JnICAgICAgICAgLW8tICAgICAgICAgICAgaHR0cHM6Ly9mc3RvcDEzOC5iZXJyYW5nZS5jb20g
OnwNCj4gfDogaHR0cHM6Ly9lbnRhbmdsZS1waG90by5vcmcgICAgLW8tICAgIGh0dHBzOi8vd3d3
Lmluc3RhZ3JhbS5jb20vZGJlcnJhbmdlIDp8DQo+

