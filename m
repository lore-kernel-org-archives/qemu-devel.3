Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E58C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78rQ-0005Ej-0Q; Wed, 15 May 2024 03:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qr-0004hG-CA
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:15:03 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qp-0000oJ-FE
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1715757299; x=1747293299;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=VWlIX1VzRzwG75UfxtkfPvYMR3owUrVk6gP7Psf/+C4=;
 b=QvFqXNffn9MC57EjWtuTJNnAE1F+EormEdzrgAhDZCGEGEnMBaypiJMP
 vjNufX4YvDknC7FOOu7rWDWR8MjWnmlzFhoQu9/wG5GjZ4130WgxUc+fR
 opntE2o0m3hGpqsjLXpF5I3cXV9UZSlvvPMH6tJxMf+p3lNcKc8YjN129
 49WrhNleNPA7IhPjSij3qnIcA0KFj4eMxyiRQU/QfWLLotFei2uKTGX72
 qEn4uCYEnYmXkD1mfbyw0TCJ9HZGAsY936Kku0fGbc+c3bIPfvNux+lbV
 0mOieYYHNdx3ovsaHfZHwdhKFADTQq7ceeylWXTaO/F1yfNf4b+T1YVgr A==;
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; d="scan'208";a="12581812"
X-MGA-submission: =?us-ascii?q?MDEr9loOd5xbA7r3vDslgYzEW29fy2YztUKYO7?=
 =?us-ascii?q?6rIm20WIjSlnYgkx88kP/IBIcOk7Z9yVY3J6/AD9bp2tTr7dnmNV9BvL?=
 =?us-ascii?q?5YzzJkyv8YXVVAaIrnV6hjcmmLjqNNGLfoZ4NpcRSWOVuZd7rdHwcWH8?=
 =?us-ascii?q?3v46P0ubH5H/OOSxUa4k+cFw=3D=3D?=
Received: from mail-vi1eur04lp2050.outbound.protection.outlook.com (HELO
 EUR04-VI1-obe.outbound.protection.outlook.com) ([104.47.14.50])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 09:14:22 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5yYMpnam6XsIRMgQHout6eU2+T0/NHQONU5X4oJmbVzXXZwMxRFVruX8x8dRCiMK9RAdXMcZXW3eB2cxoaDTaVbnghZYNaTpvqeP9idRZnpwSCvWiay+1GTcOS1JXLrkeEl84gDxtUfPaKI9p1kJ1O3UBYiZK6lNT9i4yYui+xOzpV9Z79ocfZnXV/nmhJxrQw5ZliBRXTAO6/qad1aa477VlidZNG5OweMl/1KMDvaDwUeTchGX4SQL0mbkGLXo1KlNEmK2MwTxvi2GGA9yAheNrePm/PAxheCbmhPw/E2JJmoonjva84OpPalqvheAzR6EGDwPdbwptxLyt9odw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWlIX1VzRzwG75UfxtkfPvYMR3owUrVk6gP7Psf/+C4=;
 b=iwvtcDy6D7/jkzmJDJsfJJhgsqdhWV9UrKRw1cS1OdD5T7lc352XPDd0QXFdOCMx1EdjIXGAfAK7kzFdQwNjwdE174ywh56nzB8MRf3VNNjVqvu8YhtVFfP5nkuOFa0DbCpvDmBkRjHvPwGAxk9nwqKX8Sx8/qlEt0jnhgDo3NUaccaWX1lE2Umubp79q6wUL1zI0/f25tlMdOET2mu61pZpopLcV/TlF9rBU2AiCHYeN8PUB94jx5vkvhPvfkj4OiZcqq0VKEKoH2mJONkFQzb0P1BMoQRxuv7PnR/YMxr3wQqnEpzYDxmZ7eFkGnYIkCKuetlfyfLzpTo/BDKUXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6718.eurprd07.prod.outlook.com (2603:10a6:800:18f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 07:14:21 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7544.056; Wed, 15 May 2024
 07:14:21 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v2 23/25] pci: add a pci-level API for ATS
Thread-Topic: [PATCH ats_vtd v2 23/25] pci: add a pci-level API for ATS
Thread-Index: AQHappeC13mp6/hTPU+N/vB4OMaWEQ==
Date: Wed, 15 May 2024 07:14:21 +0000
Message-ID: <20240515071057.33990-24-clement.mathieu--drif@eviden.com>
References: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6718:EE_
x-ms-office365-filtering-correlation-id: c6890e1a-d55a-4bbf-d78c-08dc74aea499
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?d0xmcVlGcGdESEtPNGg5amVCNVFscHUzV0NWd2wvQ05zZUxUQ2RRcm1YL2Rk?=
 =?utf-8?B?MUV1OHlmSDk1MzZDNVk1ajdMY2xIRGtFTjBrMVVJN1Z0S3FONGQzRVhzWHlK?=
 =?utf-8?B?MWV2OEliL3BPYjR5eGlObnJaZ2VXRUY4ZlpWQzVGVWo3bTBkTm90RU9JZmlq?=
 =?utf-8?B?bW1hVmo4S0wvOVZxYS9PZ01rbW45SGdEYmZ4ZTI3VjVwMkpybGRTTDRXcHlj?=
 =?utf-8?B?d2MxTTY2OXlnUzNGbTB5ZE5DV3Z6SHVCUkNKZFZGZW8rQWJXRExjOWJlTWpy?=
 =?utf-8?B?UWI2WWVxKytvMEZmSHZCbEFVVWtmVjRldFhjTi9qczhadDRXQkd1K1ltYkRO?=
 =?utf-8?B?Q0Jqa0x5MHRuMW9xa1oyMUNpNk5Obkd6aUpTWUF4SDhQMmdQTmVNSm9tYnd2?=
 =?utf-8?B?clJYbms3anFCSkFic1laY0o1dU4yMVAzSExVVVFUbU9mdTVrKzA4Z1BGSVNz?=
 =?utf-8?B?alhVZGlqYS96S21MeG5STCtycjcvVWlLWmhybFlLRVNxTEIzb3A3M1cxRHZL?=
 =?utf-8?B?bi96V0dKV05HQTRybGQ5NWNVSlh1dmJsZExpQ1NKdDNMYzFCNW51bDRpWVJQ?=
 =?utf-8?B?d0pzdDZWWVBYc2laL1hiSzlmWnhZcEhzRnBuVCtqNnN0cWc3NUQyVXJpaVpn?=
 =?utf-8?B?Q2traHIzakdBRDBueDRrQU5lYXN0by9oUEZRSnMvUzVOWGZTSUIwcmdEb3NY?=
 =?utf-8?B?ZUlUeldtSzJteWMxbW40N1JqN3MzRWV2VDlDOGxVeVROVC9ubVdZUVZRTHNC?=
 =?utf-8?B?QldPY1VzQ09Ra0l4VmZCNkk0SGh0RWpHYk1Zcklrb3FQZlk3ZnA2UXNhTWVo?=
 =?utf-8?B?YkZKUERMY0hsUlpvWERmbGtsNWROMjZ0MmNCY3AvNXJKVUNqd09vamhQNGtr?=
 =?utf-8?B?bWwySTVORUVNY0Y4RjFNSVRUMzlkdExYbmZTcUJyQnlLb0FTdTFZOHgwV0Y5?=
 =?utf-8?B?ajNaQjlsNlZzbXF1N2xUbEJqZStjaUd0WEJ5OXJrS3IzRlBCZ01vNzdmUnNk?=
 =?utf-8?B?a0J4VUh1akQwYm1LcXE3aGpYdElLd0ZuY2IwbEZhK1FEb0lCdjVoZnBGN2dh?=
 =?utf-8?B?WGU3Tzg1aU55WTJJdDZid2hmOU5NRVlFN1NEVnludm04bE1wNjhvOXh6dGM5?=
 =?utf-8?B?bXJqUU5qNjZlSklnUm5pM1B4UEV0UG5wcno3di9vU3RsQ3k1MlpUUmVCMitH?=
 =?utf-8?B?b3VZenM0Wk12cTB4RkRxN2xHOVNFblI4WWU1U1JXbTd3TWNEWCtVZmtMai84?=
 =?utf-8?B?c1NvUm8rU2taYUZ4NGxVUmE4cGtMNHZkaU9PeksvZklqSUNVcGl2aUtKVnV0?=
 =?utf-8?B?TFlKcHluNEd3eTljK2FaRW90eGtqYlFjbHlpNzZtUk84Y0c4T3lEVnpod0VG?=
 =?utf-8?B?SGs3dFBrZUhRZWxpVW5zWlU1ZXJiMXhRQjFlNWdhR05VSll4K3hGNEc0OElG?=
 =?utf-8?B?L3RQYmZEdjNoOTRvSVRCZmdvWW5aL1hYeEQ2WFhLWjQvRmpJUkhOU1ZtSXFt?=
 =?utf-8?B?WkYxcWsrWkorWTIyK21VREdzVlVMRS9lWTJjV0UxZDNKaVBhUWg4aEFla2Q1?=
 =?utf-8?B?K2ZPWEF5bGdHYXZiNW9BUFF5ek16YlNvbkFTY1JKTnRoY3QzdjlpakxXdGt3?=
 =?utf-8?B?SU16T3FPd1hnV01lMDVKalhVNCtEc1NvUllkekxBWHhobWR5VFRPMU9wMkdI?=
 =?utf-8?B?c2ZrZms2Z2kvNUpab2hlT29oYzUzUEU2YUFBVmV3cFA0SzdIelVnR05lYjNo?=
 =?utf-8?B?K3RTcDFRaHZzWWpxc0xESmJwNVJEdHM1UUM3RHB1dlJSN3VlVm9wMnhWb3Zy?=
 =?utf-8?B?eWRrZFlQRFpzcW40Q3crZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWxxVHY1RWp6UEhRditab0R5aW80R21Fc0E3eGV6WkJremxqZ2E2ZUFtK2hn?=
 =?utf-8?B?dlg3Q21nZFEwTEFqUHJiSERBMWp6OFprTkpPOXF0bnE5UDBKcnF0S2RwL3My?=
 =?utf-8?B?UHp1NmFFOFBWU282SHM3WjM0RWNFNGFXV2Y2UEJDM3k1c0hlclViZGg1RkVB?=
 =?utf-8?B?V3RyOW9wQzlhaXhBNFU5dXZUNFY4bFlnUHB5enFlUnBDTTB5ZTJvVnZTb2J2?=
 =?utf-8?B?eFQzd2pES2JVTUFVeGNFeGZldURySzgxUkV1eWY0ejBDTS9vRncveEV4UlRH?=
 =?utf-8?B?WG52YnhjNDVKTy8rb0ViVGJDOFhmOHBtOTI3bGo5RXltRXlnRm52YkpRdGhx?=
 =?utf-8?B?UVk0cmlta3krZ0duSFN5ZGRHeFZHdkc0OGtReURkQlZ6VVdxSjlPM3RmQWlx?=
 =?utf-8?B?S1JqOWFURVcySzJxMDdHRHhLN25QV2d1SWVVQmNwdlU1N1RaUUo0YzIwZmZ0?=
 =?utf-8?B?amZTNHpZc2gwL2ovUmFBNTFjUVRZNGxJRnN1eGRScG9OZFlQckVXbzlwRkxR?=
 =?utf-8?B?NUkvd212TklST1JnVS9tOFNHVms1dmw5U1F6R3FLalUxU2pSZ3JxMzZJN0E4?=
 =?utf-8?B?aEFMbC93ZGJZL0o1UEMyeWhUOGx2UVc4RlBNbXpUQTVCNTlRRHZuM1IrTmF0?=
 =?utf-8?B?V0F3TXNydC9LZStya0dsZS9QTTZHN1FkTndxa3NhTGdzVVh5azN0NDluMXoz?=
 =?utf-8?B?WmRZb3hLd0k2akVuS0ZXU0xEMU9xUkJZQnV0aDhORFUxVnhUMmdRY1Z4VUtm?=
 =?utf-8?B?cWZvbVhEbC95ZUsrUFYwSXRnY2dpTGtwSEYrZ1VEb0tDN3dydllTb2t0VVZZ?=
 =?utf-8?B?bDlORkMwNUJTUitYbktxYkFEZDU3MjRnSXlQenV5YnVBWGdvVkVVOXFnWWZG?=
 =?utf-8?B?UTdUWWNxU2FWMGtQMVByT01YR1NZUmM2TnVHT3VxandOOFlrNGx6YnRkWFZ6?=
 =?utf-8?B?aG10cENBVzVBU3hrd2tIMDRwSVU4ckI1cWZhYjIxWkNtZjF6SjNnSWVlSTZp?=
 =?utf-8?B?aWlDZnZhc1NkOW1IeHhCRExYODRLOXBvcDZaMlFYcCsweGJ6dnZrQStDSHVB?=
 =?utf-8?B?MmZWWFVvTEEwVmpKWWZYZGZkMm1sc0tjVktUKzhPZ2xFbVpVT2NqbjlTamVT?=
 =?utf-8?B?K1l1c0U5c0NuTWhNR1V0OTVoRzhnOHJyYmFwVnEzNDlORzVkNkVLSnM2S3pp?=
 =?utf-8?B?dnJhRGk4OE9lbDk5TVN1UUpVdS9zaHJtQmwzNUdmdFAzUGFLRTJkNWNjMGUv?=
 =?utf-8?B?bDcwT3ppNHpXTE4reWZSYUFKanZEV3hTQ0xzV0FwTTFiOENSN3dHTjNldGVD?=
 =?utf-8?B?UTBRMFJxcHdCTC9ROXNqaGZMaTRTRVJCcnczRnVSaVlkbFNqeEVnNWNwU2J2?=
 =?utf-8?B?N0o2UXdTYVc0V0huYVlFS2prT09oNzQxSXV6T2I5TkFBTUFlVTljYStoNlgr?=
 =?utf-8?B?WHZ4QWdLQ0szZFRDNGIvazFrelhjbk5DcWo1MWtyTi82UzhjQWl0S1k4ODJl?=
 =?utf-8?B?Z1Ywdm9yOUJOVUx6Ymp5SzkxQjBUU1FmV2hPcEtvZG1meU50ZTI4cDZObGw1?=
 =?utf-8?B?NEY1eSswbjdwNTFoNHc2NmJ6UWFXMG1pWkk0elNnbng4Wnd2UjE1TVBxU1FU?=
 =?utf-8?B?MWhNL21hZ1FrYUlQOFRkUXMzZW5iSDVWQjVIZSt5M3VxY1Q5RHk5MTVoMzBE?=
 =?utf-8?B?OGJhNkdSKzdOOE9XSWNjZktJWkxJS01nK1B4Tmd5bXBtNENqOTE5a2RyOUZi?=
 =?utf-8?B?Q3VSWWlSVW04OXNaSWFhQmNjWVpVdVlzSzJZVjRWamxteksvYWtZZ3hxNGRP?=
 =?utf-8?B?V2ozeXpiTkgzTHdCUGd4cVorMWtUSEk0QnNma25jNXV1L3A2RU1wbHJVSnI1?=
 =?utf-8?B?VVhvZGF1RmFOVTE0R1FGNzRTL2xoSFc1elkwZXkvajhaNmtDZHhRTitsdDVY?=
 =?utf-8?B?YUJ2Y2FRV0FLNkxFamtwenFsa0UyUVU5THhmaWNTQVl6TkM1eG1EelFvTXdt?=
 =?utf-8?B?UlIvZnBIZjNONkNQblpxQ3FZOWQwVHNzcTZjYzdBbHliN3ZGbTF0UE5wSnlE?=
 =?utf-8?B?Q1JZUGE2Rkx1VjNuV2F4cEhrSlQxN1laYzhwbnlNUENsRytLMis2YXZnNkNy?=
 =?utf-8?B?OHhoN0JTYUlFSzFhWGhQRmtFbGg5SW1vdWUxdFNyajdUMUJST3hqRkExYzJj?=
 =?utf-8?Q?iVHhHbBcVek2RjHf6qhFL/U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E32D1496CCC9D428814EC5D434F237F@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6890e1a-d55a-4bbf-d78c-08dc74aea499
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:14:21.4259 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jxVsZMgVswgkwJQU6fu2CPS18AYsplnPnOBGHbC9UIvTmSA0QLw+WNmh0FbPEU5IYBhB9KCs6/5vRiEz46Rqr/b4sQMYOqtAy2vHJgrT2/41wK3W5is3VBh4M2GtwdkH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6718
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
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

RGV2aWNlcyBpbXBsZW1lbnRpbmcgQVRTIGNhbiBzZW5kIHRyYW5zbGF0aW9uIHJlcXVlc3RzIHVz
aW5nDQpwY2lfYXRzX3JlcXVlc3RfdHJhbnNsYXRpb25fcGFzaWQuDQoNClRoZSBpbnZhbGlkYXRp
b24gZXZlbnRzIGFyZSBzZW50IGJhY2sgdG8gdGhlIGRldmljZSB1c2luZyB0aGUgaW9tbXUNCm5v
dGlmaWVyIG1hbmFnZWQgd2l0aCBwY2lfcmVnaXN0ZXJfaW9tbXVfdGxiX2V2ZW50X25vdGlmaWVy
IGFuZA0KcGNpX3VucmVnaXN0ZXJfaW9tbXVfdGxiX2V2ZW50X25vdGlmaWVyDQoNClNpZ25lZC1v
ZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlk
ZW4uY29tPg0KLS0tDQogaHcvcGNpL3BjaS5jICAgICAgICAgfCA0NCArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQogaW5jbHVkZS9ody9wY2kvcGNpLmggfCA1MiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwg
OTYgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvcGNpL3BjaS5jIGIvaHcvcGNpL3Bj
aS5jDQppbmRleCBmOTBlYjA0ZmRhLi4yMGI4Mzg2NTdlIDEwMDY0NA0KLS0tIGEvaHcvcGNpL3Bj
aS5jDQorKysgYi9ody9wY2kvcGNpLmMNCkBAIC0yODMxLDYgKzI4MzEsNTAgQEAgdm9pZCBwY2lf
ZGV2aWNlX3Vuc2V0X2lvbW11X2RldmljZShQQ0lEZXZpY2UgKmRldikNCiAgICAgfQ0KIH0NCiAN
Citzc2l6ZV90IHBjaV9hdHNfcmVxdWVzdF90cmFuc2xhdGlvbl9wYXNpZChQQ0lEZXZpY2UgKmRl
diwgdWludDMyX3QgcGFzaWQsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgYm9vbCBwcml2X3JlcSwgYm9vbCBleGVjX3JlcSwgaHdhZGRyIGFkZHIsDQorICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZV90IGxlbmd0aCwgYm9vbCBu
b193cml0ZSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT01N
VVRMQkVudHJ5ICpyZXN1bHQsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc2l6ZV90IHJlc3VsdF9sZW5ndGgsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdWludDMyX3QgKmVycl9jb3VudCkNCit7DQorICAgIGFzc2VydChyZXN1
bHRfbGVuZ3RoKTsNCisgICAgSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11X21yID0gcGNpX2Rldmlj
ZV9pb21tdV9tZW1vcnlfcmVnaW9uX3Bhc2lkKGRldiwNCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwYXNpZCk7
DQorICAgIGlmICghaW9tbXVfbXIgfHwgIXBjaWVfYXRzX2VuYWJsZWQoZGV2KSkgew0KKyAgICAg
ICAgcmV0dXJuIC1FUEVSTTsNCisgICAgfQ0KKyAgICByZXR1cm4gbWVtb3J5X3JlZ2lvbl9pb21t
dV9hdHNfcmVxdWVzdF90cmFuc2xhdGlvbihpb21tdV9tciwgcHJpdl9yZXEsDQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGV4ZWNfcmVxLCBh
ZGRyLCBsZW5ndGgsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIG5vX3dyaXRlLCByZXN1bHQsDQorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlc3VsdF9sZW5ndGgsDQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVycl9jb3VudCk7
DQorfQ0KKw0KK2ludCBwY2lfcmVnaXN0ZXJfaW9tbXVfdGxiX2V2ZW50X25vdGlmaWVyKFBDSURl
dmljZSAqZGV2LCB1aW50MzJfdCBwYXNpZCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBJT01NVU5vdGlmaWVyICpuKQ0KK3sNCisgICAgSU9NTVVNZW1vcnlSZWdp
b24gKmlvbW11X21yID0gcGNpX2RldmljZV9pb21tdV9tZW1vcnlfcmVnaW9uX3Bhc2lkKGRldiwN
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBwYXNpZCk7DQorICAgIGlmICghaW9tbXVfbXIpIHsNCisgICAgICAg
IHJldHVybiAtRVBFUk07DQorICAgIH0NCisgICAgcmV0dXJuIG1lbW9yeV9yZWdpb25fcmVnaXN0
ZXJfaW9tbXVfbm90aWZpZXIoTUVNT1JZX1JFR0lPTihpb21tdV9tciksIG4sDQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZlcnJvcl9mYXRhbCk7DQor
fQ0KKw0KK2ludCBwY2lfdW5yZWdpc3Rlcl9pb21tdV90bGJfZXZlbnRfbm90aWZpZXIoUENJRGV2
aWNlICpkZXYsIHVpbnQzMl90IHBhc2lkLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIElPTU1VTm90aWZpZXIgKm4pDQorew0KKyAgICBJT01NVU1lbW9yeVJl
Z2lvbiAqaW9tbXVfbXIgPSBwY2lfZGV2aWNlX2lvbW11X21lbW9yeV9yZWdpb25fcGFzaWQoZGV2
LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHBhc2lkKTsNCisgICAgaWYgKCFpb21tdV9tcikgew0KKyAgICAg
ICAgcmV0dXJuIC1FUEVSTTsNCisgICAgfQ0KKyAgICBtZW1vcnlfcmVnaW9uX3VucmVnaXN0ZXJf
aW9tbXVfbm90aWZpZXIoTUVNT1JZX1JFR0lPTihpb21tdV9tciksIG4pOw0KKyAgICByZXR1cm4g
MDsNCit9DQorDQogdm9pZCBwY2lfc2V0dXBfaW9tbXUoUENJQnVzICpidXMsIGNvbnN0IFBDSUlP
TU1VT3BzICpvcHMsIHZvaWQgKm9wYXF1ZSkNCiB7DQogICAgIC8qDQpkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9ody9wY2kvcGNpLmggYi9pbmNsdWRlL2h3L3BjaS9wY2kuaA0KaW5kZXggMTU4N2MxOGNk
OS4uZGMyNDdkMjRiZCAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvaHcvcGNpL3BjaS5oDQorKysgYi9p
bmNsdWRlL2h3L3BjaS9wY2kuaA0KQEAgLTQ3MSw2ICs0NzEsNTggQEAgdm9pZCBwY2lfZGV2aWNl
X3Vuc2V0X2lvbW11X2RldmljZShQQ0lEZXZpY2UgKmRldik7DQogYm9vbCBwY2lfaW9tbXVfaW5p
dF9pb3RsYl9ub3RpZmllcihQQ0lEZXZpY2UgKmRldiwgdWludDMyX3QgcGFzaWQsDQogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVU5vdGlmaWVyICpuLCBJT01NVU5vdGlm
eSBmbik7DQogDQorLyoqDQorICogcGNpX2F0c19yZXF1ZXN0X3RyYW5zbGF0aW9uX3Bhc2lkOiBw
ZXJmb3JtIGFuIEFUUyByZXF1ZXN0DQorICoNCisgKiBSZXR1cm4gdGhlIG51bWJlciBvZiB0cmFu
c2xhdGlvbnMgc3RvcmVkIGluIEByZXN1bHQgaW4gY2FzZSBvZiBzdWNjZXNzLA0KKyAqIGEgbmVn
YXRpdmUgZXJyb3IgY29kZSBvdGhlcndpc2UuDQorICogLUVOT01FTSBpcyByZXR1cm5lZCB3aGVu
IHRoZSByZXN1bHQgYnVmZmVyIGlzIG5vdCBsYXJnZSBlbm91Z2ggdG8gc3RvcmUNCisgKiBhbGwg
dGhlIHRyYW5zbGF0aW9ucw0KKyAqDQorICogQGRldjogdGhlIEFUUy1jYXBhYmxlIFBDSSBkZXZp
Y2UNCisgKiBAcGFzaWQ6IHRoZSBwYXNpZCBvZiB0aGUgYWRkcmVzcyBzcGFjZSBpbiB3aGljaCB0
aGUgdHJhbnNsYXRpb24gd2lsbCBiZSBtYWRlDQorICogQHByaXZfcmVxOiBwcml2aWxlZ2VkIG1v
ZGUgYml0IChQQVNJRCBUTFApDQorICogQGV4ZWNfcmVxOiBleGVjdXRlIHJlcXVlc3QgYml0IChQ
QVNJRCBUTFApDQorICogQGFkZHI6IHN0YXJ0IGFkZHJlc3Mgb2YgdGhlIG1lbW9yeSByYW5nZSB0
byBiZSB0cmFuc2xhdGVkDQorICogQGxlbmd0aDogbGVuZ3RoIG9mIHRoZSBtZW1vcnkgcmFuZ2Ug
aW4gYnl0ZXMNCisgKiBAbm9fd3JpdGU6IHJlcXVlc3QgYSByZWFkLW9ubHkgYWNjZXNzIHRyYW5z
bGF0aW9uIChpZiBzdXBwb3J0ZWQgYnkgdGhlIElPTU1VKQ0KKyAqIEByZXN1bHQ6IGJ1ZmZlciBp
biB3aGljaCB0aGUgVExCIGVudHJpZXMgd2lsbCBiZSBzdG9yZWQNCisgKiBAcmVzdWx0X2xlbmd0
aDogcmVzdWx0IGJ1ZmZlciBsZW5ndGgNCisgKiBAZXJyX2NvdW50OiBudW1iZXIgb2YgdW50cmFu
c2xhdGVkIHN1YnJlZ2lvbnMNCisgKi8NCitzc2l6ZV90IHBjaV9hdHNfcmVxdWVzdF90cmFuc2xh
dGlvbl9wYXNpZChQQ0lEZXZpY2UgKmRldiwgdWludDMyX3QgcGFzaWQsDQorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBwcml2X3JlcSwgYm9vbCBleGVjX3Jl
cSwgaHdhZGRyIGFkZHIsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc2l6ZV90IGxlbmd0aCwgYm9vbCBub193cml0ZSwNCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBJT01NVVRMQkVudHJ5ICpyZXN1bHQsDQorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZV90IHJlc3VsdF9sZW5ndGgsDQorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgKmVycl9jb3Vu
dCk7DQorDQorLyoqDQorICogcGNpX3JlZ2lzdGVyX2lvbW11X3RsYl9ldmVudF9ub3RpZmllcjog
cmVnaXN0ZXIgYSBub3RpZmllciBmb3IgY2hhbmdlcyB0bw0KKyAqIElPTU1VIHRyYW5zbGF0aW9u
IGVudHJpZXMgaW4gYSBzcGVjaWZpYyBhZGRyZXNzIHNwYWNlLg0KKyAqDQorICogUmV0dXJucyAw
IG9uIHN1Y2Nlc3MsIG9yIGEgbmVnYXRpdmUgZXJybm8gb3RoZXJ3aXNlLg0KKyAqDQorICogQGRl
djogdGhlIGRldmljZSB0aGF0IHdhbnRzIHRvIGdldCBub3RpZmllZA0KKyAqIEBwYXNpZDogdGhl
IHBhc2lkIG9mIHRoZSBhZGRyZXNzIHNwYWNlIHRvIHRyYWNrDQorICogQG46IHRoZSBub3RpZmll
ciB0byByZWdpc3Rlcg0KKyAqLw0KK2ludCBwY2lfcmVnaXN0ZXJfaW9tbXVfdGxiX2V2ZW50X25v
dGlmaWVyKFBDSURldmljZSAqZGV2LCB1aW50MzJfdCBwYXNpZCwNCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVU5vdGlmaWVyICpuKTsNCisNCisvKioNCisg
KiBwY2lfdW5yZWdpc3Rlcl9pb21tdV90bGJfZXZlbnRfbm90aWZpZXI6IHVucmVnaXN0ZXIgYSBu
b3RpZmllciB0aGF0IGhhcyBiZWVuDQorICogcmVnaXN0ZXJkIHdpdGggcGNpX3JlZ2lzdGVyX2lv
bW11X3RsYl9ldmVudF9ub3RpZmllcg0KKyAqDQorICogUmV0dXJucyAwIG9uIHN1Y2Nlc3MsIG9y
IGEgbmVnYXRpdmUgZXJybm8gb3RoZXJ3aXNlLg0KKyAqDQorICogQGRldjogdGhlIGRldmljZSB0
aGF0IHdhbnRzIHRvIHVuc3Vic2NyaWJlDQorICogQHBhc2lkOiB0aGUgcGFzaWQgb2YgdGhlIGFk
ZHJlc3Mgc3BhY2UgdG8gYmUgdW50cmFja2VkDQorICogQG46IHRoZSBub3RpZmllciB0byB1bnJl
Z2lzdGVyDQorICovDQoraW50IHBjaV91bnJlZ2lzdGVyX2lvbW11X3RsYl9ldmVudF9ub3RpZmll
cihQQ0lEZXZpY2UgKmRldiwgdWludDMyX3QgcGFzaWQsDQorICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBJT01NVU5vdGlmaWVyICpuKTsNCisNCiAvKioNCiAgKiBw
Y2lfc2V0dXBfaW9tbXU6IEluaXRpYWxpemUgc3BlY2lmaWMgSU9NTVUgaGFuZGxlcnMgZm9yIGEg
UENJQnVzDQogICoNCi0tIA0KMi40NC4wDQo=

