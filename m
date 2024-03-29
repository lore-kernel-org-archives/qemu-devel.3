Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98300CD1284
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 01:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq1RM-000622-EJ; Thu, 28 Mar 2024 21:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1rq1RJ-00061c-4t; Thu, 28 Mar 2024 21:53:53 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com ([68.232.159.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1rq1RG-0004aZ-AN; Thu, 28 Mar 2024 21:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1711677231; x=1743213231;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=BbDaNGuQUp6UY2grl6xRcBG5nMkEo8yeWRwE1jZHumw=;
 b=tvYbgjmkkdjogf+yRKDzfxwTJW+Gjkmxpx9JYfueu/SN5cBbwvqWrDNL
 qa5HmG7gIf2bzyOLvY6IoifiI3BZPhXGyh04SrNbrSgRusR3HMwuiP277
 TgZtFQ/rrKO4FT6u7FdlMNqG8+WSVSCZ+7Mt8NOvdJg15SabuyhK96rLG
 PVHzeRgA8SEkxRAvgW7MloKnZtSo5RAGOov0e72hY+WNcq4NBGlSxE4u0
 viq5/e3JDY1ONOxkSlTv+dJUZKTOOKdJLNuvL/i5M3UfyiiMCFAzhF+lx
 G0EUie78HAfDsLDa96f17KI/fEw6IyiOWHuYTVUC5olgqwwH8TSkoUjF4 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="115393995"
X-IronPort-AV: E=Sophos;i="6.07,162,1708354800"; d="scan'208";a="115393995"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2024 10:53:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPptJzyLkVEeVOuQnjK6FRBBOTRtnRfZ9FnQszCBIKmxw5w35mw7wtdpUla4daDN5C6Ch8J+9dCGV9RyxyyO7a3yuglnADbuTvwwInOV1FQsxrtjyFAQz40h3P+Upfak2jhfJ8V7YdbIzYg/sjJRup8+tg0bv15Lz/NI59ZcbRF6/ZhGN8hGmbBxI1f67HzClN/gydatYPE8C4+DFrKVy69KF9m1UqjUgIkDBoGyNIK/T0KUT7NHL2sX99qNz4BwfQtpeexh6y/CTakVqZm37b/YcaJf9qFlQ8lk8Qs6jeaALpgUYfrq65HI8mBwem3GrCtZCdwkuQMIvfaKBhLseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbDaNGuQUp6UY2grl6xRcBG5nMkEo8yeWRwE1jZHumw=;
 b=fsv173mrIyuewoOgIhMhpfy/2KU/SlANVOFdhVAGlx4N3zm85SraA6ffTKtmlOjlK+RvJoRR/v5bSn51iwHikTmSyRr9c9HW9YdcEkY5GiVaXX6FRCxYR/rCc8/cTb87ZE6fe327upkxbri9WH0PV3zdCwC29N8QQ/yENG5Z1KzVaj2RUJCU2Wk+7+x5o1YbBlmnN/47yuibkHRAjtXdj1z2OOUDph0bF0ef2yaFm4oPokmW/RXnsX7xaPzEj7hNOndvW0udjYuzZwHSbyeU9o4IeSebfwDFStbsFoeLbTAXmtz88lTtMbWpfOi/r24B+tZLcNwiNKb7nGmUxbhj6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 (2603:1096:404:8059::10) by OSZPR01MB8562.jpnprd01.prod.outlook.com
 (2603:1096:604:18b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Fri, 29 Mar
 2024 01:53:33 +0000
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::e69:40a6:944b:f974]) by TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::e69:40a6:944b:f974%5]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 01:53:33 +0000
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
CC: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Yuval Shaia
 <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Prasanna Kumar
 Kalever <prasanna.kalever@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Prasanna Kumar Kalever
 <prasanna4324@gmail.com>, "integration@gluster.org"
 <integration@gluster.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>, Hanna Reitz
 <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Eric Blake <eblake@redhat.com>, Song Gao
 <gaosong@loongson.cn>, =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?=
 <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Wainer dos Santos
 Moschetta <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Yu Zhang <yu.zhang@ionos.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Thread-Topic: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Thread-Index: AQHagRBhZe2HiRGZ1kqMYe8iGl3wH7FNM10AgAAMBgCAALZIAA==
Date: Fri, 29 Mar 2024 01:53:33 +0000
Message-ID: <7a510fbe-1c27-4f67-93b8-0d9cf01c1c74@fujitsu.com>
References: <20240328130255.52257-1-philmd@linaro.org>
 <20240328130255.52257-3-philmd@linaro.org> <87frwatp7n.fsf@suse.de>
 <ZgWGMmUTq0jqSUvr@x1n>
In-Reply-To: <ZgWGMmUTq0jqSUvr@x1n>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB5818:EE_|OSZPR01MB8562:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /yzrKaY9Cf5IgUQ4NcBSE0daxLlBpEgqXaznJev9i4LPK/oFW+pyHJ4uvVSd3YThBe1Tieb/jB2U0ycN/QC04QQ46eoEpCUVdn21MEXusPW6WBlLAshk6kPmGCkk5aCDDsCdXgNQVChOpZ/rUgqnYvkor39WVvpq02oIC7B9gDnTegQTZV90sfMbbGg0v7d1EW89RWhNo1fUS2W3Dz4IxHQqv5zLBssLAIo/LhY/SPWAKgwKv3mXhUxmfnFkOCbBtgG2F35PWmWm6eITt3bLfi2YM3whSvmJaieFU2ywBcS/anDVozpkjosfBQHa4ASoRcZJFTKDwoUWQzBYRH4Io29ibCSOYtrZf+TRnjBudqvAZollVVbUlrHBjYAuIjDzU2W1NP/rhJPlnjNrAiJne3F6Za54BTGvYiGybY3v2P6sRV3Sw99RID9FHe9bVEUO9FKKlMfrpo0FNZRblU8acg7vcbSxDHZ63IWo7mQ8itW1jdhCbya/CDjzXdLBlM0LG4uQcFgdshnhh5R78xjc3fGfE6PErcJigk0KKk8Cuzqoe3/U5F1r5dLZgurgrAAwGI2sgdnv9FCyoNS3RBVzTmf1t6LFl8pSyaU9pmzMFbzA/TKKHa/l1QN5B7bjZihmIQE6hyCYofUW5sgyo2Fnvle0wG9aeDC/HmFte7C32YI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYAPR01MB5818.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(1800799015)(366007)(1580799018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkVmZjdrOUdKeGZDYm5iMzZNbUM4Q0VaUzZ6TWp5YjY0dzFCQUZsTnEzd0dX?=
 =?utf-8?B?Yjhxa0I5ZlFzMkhVTEMzNklaTXpJN2FuSlVlSS9YdHZqMjFlU3hJSEJEbG5q?=
 =?utf-8?B?U3kxcWNnUkwwQWNEOGlRZzVqZnJ1bTVGNjhjd3dkSHhDQTRuc0ZvQ2E4UEI3?=
 =?utf-8?B?TGR6b0tZT3dGVWhEczRRMHpUZ0NXOWMxWlVxM0J2SUU3TWtheWpCMVZYVDMr?=
 =?utf-8?B?ZDNDQmhUYWRiYnRBd1FXenZlZG5ENVE1QkJKdU03dzUySzZiVlVRMmtNWHl2?=
 =?utf-8?B?UENZM0tsMm4vOTVHVW4ybFBZY0xwcUN6MnFZQlhwUXM4NWxxamNjVkwrdi81?=
 =?utf-8?B?bFFZRlhMVjE0V1N6WDQrb0JaVGJmdndacFBYL0Z0SFRVU0crRit6TGlGdGdr?=
 =?utf-8?B?M2F1S1F6dzA1NHJrdGhyd0FOSWJIY2F4clJGRmxDbmJsUW4wblE0QWNzeVlH?=
 =?utf-8?B?bUFzTWYvNWdxTW5jUGhGV3kzbU4rZUxMVEdQQWRBcjB1RFRpU0ZaSnRjTzlI?=
 =?utf-8?B?UUpFUG1wOUhUQk1DVzQ4Nmh0YTVQckorWmxodGZ1S1p1TmJUTzZrR3p3SlRH?=
 =?utf-8?B?dXBJY1RMalpFc0VWTlBOZHZmUmh1SDJtbjhxNmJsN1g5L293MTF5R2pxU0o2?=
 =?utf-8?B?ZmpkMFVGU2hLVUE1Q2dZakRRY0RoSzlzcmtjL3JJclp6dnhlQWlSZUh3TERD?=
 =?utf-8?B?NVBTZlJ4L24xZ0RpYmFFTHhHOHk3WTFFdW9ybDljQVQ2d2FwWjZqZjFOZXlp?=
 =?utf-8?B?cWp4eGJTRnlGV0RIL3lENVRwand0VElESjRpR0kxM3Z2M1RaT2k3dVNzc0wz?=
 =?utf-8?B?UStGNGt6a3lnSFpXY1ZSajJObENwYkRyVUJJU1dGZ2l6My9nQ2NYbXYvNkQy?=
 =?utf-8?B?djZEYkhZZ0k2TmVlKzJSZmczL2wwYUlacHRuNGFrWmdmVzFxMmg4YjBvVXdq?=
 =?utf-8?B?b1VEcEJMc0o4eERqK2lZdm9hTWJOb1MrNXBwVHBYMldocWdNUkxMTXNzUEVt?=
 =?utf-8?B?akdnc08yZE1TRnZiNVdWOW85WXJwcHFuR1NpdkFXOVlwYWdvcVhNTlRETjdz?=
 =?utf-8?B?UGdiWFVJeWc2VklRQW91S2tUY09GWE9vaW81NWlocGJ1V3hvNVV1KzlyWEdM?=
 =?utf-8?B?UHJlQTNwYmdnd3p4SDF5aFFYYTVZVGNISHI1Q2VibDh3RXhMNStLZ2w5bVp2?=
 =?utf-8?B?R2JKVjNHTmFWWlY5S0c5UzJaWFNRZEp4OXhRcjg0STAvUEVkWXF4TVlydUhU?=
 =?utf-8?B?KzI4WjB0RG5QWk5oOWJOMTJ6aGtRTjJkSWZrS1JuSVlTbTJCRy9oMXo1YjZw?=
 =?utf-8?B?VnVvaWJRSHhndnFUWUZRSUdhV3FWdEttYjlZRjM1TmNFbUNqTXY4TzBnR2J2?=
 =?utf-8?B?RHAvVnBkMmZBQVpOR1RQUEVVWVMvNjFhTWdHM0pXWDNhRUhnVDNSZTZKWTNj?=
 =?utf-8?B?TzY3UVJNVUhEYkRCS3hPalByVXhVdzVTQ05XS2tYS3dzVHpCY29PQ1E2VllV?=
 =?utf-8?B?YXBVUFlOMEdwZEwyUzNXMHFhNkwyK0FBNlQ3OHN3bmJZdWt2aUNjTzZyTU5V?=
 =?utf-8?B?QnlOZFlqYlE4YmhGVWN2a0FqNEFoZG1ZQ1N3bXk4blZSWCtwWXF3Ly9qTVgz?=
 =?utf-8?B?R296cE9FcGF3NXI1MlpwQjVDSGFTMndqZWFxU1BNS3VyNll1S3ZmekdyVmp5?=
 =?utf-8?B?QytCcUxpdys5RTlWeDYvbmg3TnlsWlBiUVRLa2xMbmV0M1ZnREFWYVhqWW5k?=
 =?utf-8?B?RlFMUXdLendNcVRaRW1PdG1DNHJpdDhMS0FqdFdsYkVubXl4ZzFaR2lUWTdK?=
 =?utf-8?B?cWxyTWErT1M4Y1dta2NObzdRRlIzZHJnM3pZUkF3N2dxUDRLUWIwK1pYUVR6?=
 =?utf-8?B?ZTRVbTlJc00yYzBIMzZ2S0xDSi9ka2ttczBMaXNSTUYvck10cGFiVjFReVE5?=
 =?utf-8?B?aHhrb0oyOU5OS01Lam5Da0R3aE5zVHhERzJjRnl1K3VZZS90R1hVT0lJSStl?=
 =?utf-8?B?K0kvN1RXd3dSVVhBeitzYmVFUXdSeEVpUlhCVkNEWFZ4MUxSeUVEc0tTdjE3?=
 =?utf-8?B?N1A1T0xXdWhNbmRvdmpNVVBMYXM1YldCZ1NGTUlmRHpieVR0SkRyUTNpZE10?=
 =?utf-8?B?L3JZUS9NenZrQUdJcUl3UWJTTXNvL09LV093YkNvelNUdFJlb09qOCtHcmE1?=
 =?utf-8?B?MUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1BEAF77A6446143A5F61F0AF7660DA8@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fEzOESnZyQbblm/lcJ5sFem02rcmU8eNQfSI4VS5LYKV5dwrVdzV3xZ+Nan+Pwa04cPE5v99MOyQCKZWSNWpxq3h+gj4k/lwC4p43vVQFITaqHN32b1qSuqcOL6Bog0NrJwRQHueVVH2I2o3AVm1AGO459XRE483E3vhcc6JSP1W8IWTCS7bKZ2adBHDGEkzee43NYkD6SARgr4pmgIW3Q0QSA0YLm1cOlYIpqYh3CyIcoCaa7pYpsQgQbjgm2bd4SJHZ9vceppsK/CXkvcJ6Sv4BtvdXAWdT6SuYo6kgTjdW2u3SYOx2QyDUcB4VSX890eRi7K8ODD4cUV8PJ4JXPUqigC4kIEedzleAD7HsMNiMEXbMDM3XPj8P/10IhEiASnGnIPcZsd48abDeDzzNmV9aDzJw5KOctN1GYEl4mqsAXudArf0gZPiT/egXW8TI+lm2ePxK/fOtKBwRaqUek4QzMLU6R7z3hGC9yM/Dk0v/cAyY0RB+v/fEqipVOB+rcQKCVE4swQR/Mg0FfBdBWNw/aZjMiRNCEPbFZE1p4XsOQnAlLebSe+eoOGblkAbtz3nHIRzzQvVLO10hp0CGoerkvAkwA3g3BVkQwB2tQsIqYNP/4Z9/4FKasFiAkG1
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB5818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c367fba-66d2-4695-c137-08dc4f930a9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 01:53:33.6573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BmmGWhLxsycmTk9VJIORjv+8XUHCP8ClkQ2lO7mhBpa5JcV12LtbSi/giQ2E8ry3n5tIR2EhwPL5/yT5wC5H4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8562
Received-SPF: pass client-ip=68.232.159.83; envelope-from=lizhijian@fujitsu.com;
 helo=esa6.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
From:  "Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCk9uIDI4LzAzLzIwMjQgMjM6MDEsIFBldGVyIFh1IHdyb3RlOg0KPiBPbiBUaHUsIE1hciAy
OCwgMjAyNCBhdCAxMToxODowNEFNIC0wMzAwLCBGYWJpYW5vIFJvc2FzIHdyb3RlOg0KPj4gUGhp
bGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPiB3cml0ZXM6DQo+Pg0KPj4+
IFRoZSB3aG9sZSBSRE1BIHN1YnN5c3RlbSB3YXMgZGVwcmVjYXRlZCBpbiBjb21taXQgZTlhNTQy
NjVmNQ0KPj4+ICgiaHcvcmRtYTogRGVwcmVjYXRlIHRoZSBwdnJkbWEgZGV2aWNlIGFuZCB0aGUg
cmRtYSBzdWJzeXN0ZW0iKQ0KPj4+IHJlbGVhc2VkIGluIHY4LjIuDQo+Pj4NCj4+PiBSZW1vdmU6
DQo+Pj4gICAtIFJETUEgaGFuZGxpbmcgZnJvbSBtaWdyYXRpb24NCj4+PiAgIC0gZGVwZW5kZW5j
aWVzIG9uIGxpYmlidW1hZCwgbGliaWJ2ZXJicyBhbmQgbGlicmRtYWNtDQo+Pj4NCj4+PiBLZWVw
IHRoZSBSQU1fU0FWRV9GTEFHX0hPT0sgZGVmaW5pdGlvbiBzaW5jZSBpdCBtaWdodCBhcHBlYXJz
DQo+Pj4gaW4gb2xkIG1pZ3JhdGlvbiBzdHJlYW1zLg0KPj4+DQo+Pj4gQ2M6IFBldGVyIFh1IDxw
ZXRlcnhAcmVkaGF0LmNvbT4NCj4+PiBDYzogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3Uu
Y29tPg0KPj4+IEFja2VkLWJ5OiBGYWJpYW5vIFJvc2FzIDxmYXJvc2FzQHN1c2UuZGU+DQo+Pj4g
U2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3Jn
Pg0KPj4NCj4+IEp1c3QgdG8gYmUgY2xlYXIsIGJlY2F1c2UgcGVvcGxlIHJhaXNlZCB0aGUgcG9p
bnQgaW4gdGhlIGxhc3QgdmVyc2lvbiwNCj4+IHRoZSBmaXJzdCBsaW5rIGluIHRoZSBkZXByZWNh
dGlvbiBjb21taXQgbGlua3MgdG8gYSB0aHJlYWQgY29tcHJpc2luZw0KPj4gZW50aXJlbHkgb2Yg
cmRtYSBtaWdyYXRpb24gcGF0Y2hlcy4gSSBkb24ndCBzZWUgYW55IGFtYmlndWl0eSBvbiB3aGV0
aGVyDQo+PiB0aGUgZGVwcmVjYXRpb24gd2FzIGludGVuZGVkIHRvIGluY2x1ZGUgbWlncmF0aW9u
LiBUaGVyZSdzIGV2ZW4gYW4gYWNrDQo+PiBmcm9tIEp1YW4uDQo+IA0KPiBZZXMgSSByZW1lbWJl
ciB0aGF0J3MgdGhlIHBsYW4uDQo+IA0KPj4NCj4+IFNvIG9uIHRoZSBiYXNpcyBvZiBub3QgcmV2
ZXJ0aW5nIHRoZSBwcmV2aW91cyBtYWludGFpbmVyJ3MgZGVjaXNpb24sIG15DQo+PiBBY2sgc3Rh
bmRzIGhlcmUuDQo+Pg0KPj4gV2UgYWxzbyBoYWQgcHJldHR5IG9idmlvdXMgYnVncyAoWzFdLCBb
Ml0pIGluIHRoZSBwYXN0IHRoYXQgd291bGQgaGF2ZQ0KPj4gYmVlbiBjYXVnaHQgaWYgd2UgaGFk
IGFueSBraW5kIG9mIHRlc3RpbmcgZm9yIHRoZSBmZWF0dXJlLCBzbyBJIGNhbid0DQo+PiBldmVu
IHNheSB0aGlzIHRoaW5nIHdvcmtzIGN1cnJlbnRseS4NCj4+DQo+PiBAUGV0ZXIgWHUsIEBMaSBa
aGlqaWFuLCB3aGF0IGFyZSB5b3VyIHRob3VnaHRzIG9uIHRoaXM/DQo+IA0KPiBHZW5lcmFsbHkg
SSBkZWZpbml0ZWx5IGFncmVlIHdpdGggc3VjaCBhIHJlbW92YWwgc29vbmVyIG9yIGxhdGVyLCBh
cyB0aGF0J3MNCj4gaG93IGRlcHJlY2F0aW9uIHdvcmtzLCBhbmQgZXZlbiBhZnRlciBKdWFuJ3Mg
bGVmdCBJJ20gbm90IGF3YXJlIG9mIGFueQ0KPiBvdGhlciBuZXcgUkRNQSB1c2Vycy4gIFBlcnNv
bmFsbHksIEknZCBzbGlnaHRseSBwcmVmZXIgcG9zdHBvbmluZyBpdCBvbmUNCj4gbW9yZSByZWxl
YXNlIHdoaWNoIG1pZ2h0IGhlbHAgYSBiaXQgb2Ygb3VyIGRvd25zdHJlYW0gbWFpbnRlbmFuY2Us
IGhvd2V2ZXINCj4gSSBhc3N1bWUgdGhhdCdzIG5vdCBhIGJsb2NrZXIgZWl0aGVyLCBhcyBJIHRo
aW5rIHdlIGNhbiBhbHNvIG1hbmFnZSBpdC4NCj4gDQo+IElNSE8gaXQncyBtb3JlIGltcG9ydGFu
dCB0byBrbm93IHdoZXRoZXIgdGhlcmUgYXJlIHN0aWxsIHVzZXJzIGFuZCB3aGV0aGVyDQo+IHRo
ZXkgd291bGQgc3RpbGwgbGlrZSB0byBzZWUgaXQgYXJvdW5kLiBUaGF0J3MgYWxzbyBvbmUgdGhp
bmcgSSBub3RpY2UgdGhhdA0KPiBlOWE1NDI2NWY1MzNmIGRpZG4ndCB5ZXQgZ2V0IGFja3MgZnJv
bSBSRE1BIHVzZXJzIHRoYXQgd2UgYXJlIGF3YXJlLCBldmVuDQo+IGlmIHRoZXkncmUgcmFyZS4g
QWNjb3JkaW5nIHRvIFsyXSBpdCBjb3VsZCBiZSB0aGF0IHN1Y2ggdXNlciBtYXkgb25seSByZWx5
DQo+IG9uIHRoZSByZWxlYXNlIHZlcnNpb25zIG9mIFFFTVUgd2hlbiBpdCBicm9rZSB0aGluZ3Mu
DQo+IA0KPiBTbyBJJ20gY29weWluZyBZdSB0b28gKHdoaWxlIFpoaWppYW4gaXMgYWxyZWFkeSBp
biB0aGUgbG9vcCksIGp1c3QgaW4gY2FzZQ0KPiBzb21lb25lIHdvdWxkIGxpa2UgdG8gc3RhbmQg
dXAgYW5kIHNwZWFrLg0KDQoNCkkgYWRtaXQgUkRNQSBtaWdyYXRpb24gd2FzIGxhY2sgb2YgdGVz
dGluZyh1bml0L0NJIHRlc3QpLCB3aGljaCBsZWQgdG8gdGhlIGEgZmV3DQpvYnZpb3VzIGJ1Z3Mg
YmVpbmcgbm90aWNlZCB0b28gbGF0ZS4NCkhvd2V2ZXIgSSB3YXMgYSBiaXQgc3VycHJpc2VkIHdo
ZW4gSSBzYXcgdGhlIHJlbW92YWwgb2YgdGhlIFJETUEgbWlncmF0aW9uLiBJIHdhc24ndA0KYXdh
cmUgdGhhdCB0aGlzIGZlYXR1cmUgaGFzIG5vdCBiZWVuIG1hcmtlZCBhcyBkZXByZWNhdGVkKGF0
IGxlYXN0IHRoZXJlIGlzIG5vDQpwcm9tcHQgdG8gZW5kLXVzZXIpLg0KDQoNCj4gSU1ITyBpdCdz
IG1vcmUgaW1wb3J0YW50IHRvIGtub3cgd2hldGhlciB0aGVyZSBhcmUgc3RpbGwgdXNlcnMgYW5k
IHdoZXRoZXINCj4gdGhleSB3b3VsZCBzdGlsbCBsaWtlIHRvIHNlZSBpdCBhcm91bmQuDQoNCkFn
cmVlLg0KSSBkaWRuJ3QgaW1tZWRpYXRlbHkgZXhwcmVzcyBteSBvcGluaW9uIGluIFYxIGJlY2F1
c2UgSSdtIGFsc28gY29uc3VsdGluZyBvdXINCmN1c3RvbWVycyBmb3IgdGhpcyBmZWF0dXJlIGlu
IHRoZSBmdXR1cmUuDQoNClBlcnNvbmFsbHksIEkgYWdyZWUgd2l0aCBQZXJ0ZXIncyBpZGVhIHRo
YXQgIkknZCBzbGlnaHRseSBwcmVmZXIgcG9zdHBvbmluZyBpdCBvbmUNCm1vcmUgcmVsZWFzZSB3
aGljaCBtaWdodCBoZWxwIGEgYml0IG9mIG91ciBkb3duc3RyZWFtIG1haW50ZW5hbmNlIg0KDQpU
aGFua3MNClpoaWppYW4NCg0KPiANCj4gVGhhbmtzLA0KPiANCj4+DQo+PiAxLSBodHRwczovL2xv
cmUua2VybmVsLm9yZy9yLzIwMjMwOTIwMDkwNDEyLjcyNjcyNS0xLWxpemhpamlhbkBmdWppdHN1
LmNvbQ0KPj4gMi0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci9DQUhFY1Z5N0hYU3duNE93X0tv
ZytRK1RONmZfa01laUNIZXZ6MXFHTS1mYnhCUHAxaFFAbWFpbC5nbWFpbC5jb20NCj4+DQo+IA==

