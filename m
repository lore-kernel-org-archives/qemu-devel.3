Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF295C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78rJ-00054k-Th; Wed, 15 May 2024 03:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qe-0004cu-Vd
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:50 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qd-0000oJ-5U
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1715757287; x=1747293287;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=zFEzYvx6Y53xIqVlSMToVmTVIq0lJKNumg4SqsbmCWs=;
 b=nsmz2LubUF3M2wJonFSdMxiakDWuQ+HxBc+wGaAUe5uLt7E8eoeX1ZoB
 av5nhiyvDKdP1YLLIy9U2hWjBvWwgIsKiq8iRGep+whNeAjTdojPW1EcN
 dfZcPIFq4kty1mqWJhLCdAZ4WDHlphMl7/26jY0ucKDcIc3O5uWwqOFh+
 OuxuzdNQ6T33INtrZaBf51l3rwI0yhOXaXjfgxy6lpguI1Gm2jlMY7oAm
 t9IlaV8PQEXbev5fJm55r7YeUU2xffmHEj7v+x6snARj1WIV8+n770d6Y
 gosX0ys7wYQdTE85B41Cq1dsA47tCBFdCt8rVnHE2Ng5UGDr3dfzM3hHm Q==;
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; d="scan'208";a="12581808"
X-MGA-submission: =?us-ascii?q?MDHdlLOcPjNYStfw5dq3bQW8wErerSl/H95ns2?=
 =?us-ascii?q?fp11/im2f1xDTEZCOvusYKtDqJ9n3NBQtBZTiADBPl5emQ8t0kggncy7?=
 =?us-ascii?q?CfNwHoUCVlyXNWWmZA7uRHjTdtYKrKRN0nEjhqlKR7kZYGRJ/2TWQokE?=
 =?us-ascii?q?P7F40u1G2rkzKagIm5amTGGQ=3D=3D?=
Received: from mail-vi1eur04lp2050.outbound.protection.outlook.com (HELO
 outbound.mail.protection.outlook.com) ([104.47.14.50])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 09:14:21 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkT7AaZejPRBKpe8PONBpkxX3ogCGCnHO9m7MdV3BLzbWz8EeOQlvjPZvp5RTlA9QlqQqLhQm5zGVMPA3PL/V+If8lTk3SREV6Fo6lWbOjJyTf/9/EkC6DeFlw5WN4hBWZ844Mc8v6h+9fUX9+6ZtMv5VppHKtx8U8q4KVMsIPBtlh+mLkXMAtFjj6W1HPnHldr+09s39tGL5zzqyg/o0QvgpmrCyiaQweFpEhEaNhKzT6cxQHCqHZ/DAORSq6auFdGQYzk3nuu7/d1n05eNhdqFI++EU5FWPY/Jf+Sb7Y7HnvsWXb6StScEY3Qt2PvMF/+y4nLWZUPduYr9JNThrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFEzYvx6Y53xIqVlSMToVmTVIq0lJKNumg4SqsbmCWs=;
 b=fOAcDXx/YipoIveJFtaUsiLG/QQvDsYdfzDtV4d5HqpFSeEZt/BMC+HRbV7ppVKaB8lNp5nity8EQT1Q4TbM2k9vhfZmPeysJznaot7r77sM0RI4Y9y8I1ntTaYpOU8DyjSgPmACT05uQCTjEQMHtYCoberd100zYRHq+6HwESd6wP4//vOTgPWEfkP7gniuvK5Fp/RC02pdT5x9cYu5l5Hv6p++9WScC+OLj25WfOTvhET4Ew7Tlmbu6Ymrq6+yhAeEWOJ9gLgj2ycbt4HmELUYCC4R3ZrqhydOGCKsUGxyD/hbgDB/tTxPShnSE/c/W6g58QI+onX83HxW30lIJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6718.eurprd07.prod.outlook.com (2603:10a6:800:18f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 07:14:19 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7544.056; Wed, 15 May 2024
 07:14:19 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v2 20/25] intel_iommu: fill the PASID field when
 creating an instance of IOMMUTLBEntry
Thread-Topic: [PATCH ats_vtd v2 20/25] intel_iommu: fill the PASID field when
 creating an instance of IOMMUTLBEntry
Thread-Index: AQHappeALIV+LSCFtU2DUckW7CrvTw==
Date: Wed, 15 May 2024 07:14:18 +0000
Message-ID: <20240515071057.33990-21-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: ede01cb5-30cf-4c7c-1a44-08dc74aea331
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?WEJhNkpWejAvVDVldXIrTytuM3VvY2tCOHdxUlFzelpPK1BnZnpPdE1uSUhz?=
 =?utf-8?B?V2k5OXJLYjAxbGQySTFFcUs0TmxCR1pVcGNORjV1N0c0K2d6VForV2RwQVR1?=
 =?utf-8?B?Y3hLSEhJUnhmTGVZS3Jxc1pCSEh4NVpkVERJazAwc215WWVCVENJR2tqR3d4?=
 =?utf-8?B?aTNzYXZTM3huQnZLdHovS2tSWXVOZmoyczdJaWRGY2pWVWF1ZFE2dFRsbldk?=
 =?utf-8?B?MVhxT2pSOVNDZzVLTFRSUE5MUjVWUzhyMVBSampNeGxhUnVyV0JoNjIya2FM?=
 =?utf-8?B?WE5HRFo1N0VWd0RPazBlMmpsYzMwOUNkSWo5SDlacGZnS0FlQ1grUE1zYUY2?=
 =?utf-8?B?U3BGdVBmVGszMHhTQkJOYmQ4a1RHUkNjQkdpeUw5c2tWWjl5aXhud2RWVENW?=
 =?utf-8?B?MktHYXZ3NEJwLzNqZm5GUnRSYW9lckFkVlU0YW9teHhyU2crVnp6Tlo1TVkr?=
 =?utf-8?B?UTF0RS9Fa1ZNUnh4MTN6U1AvUkd2Z1JWMEx4NVp0NHBtSmdTK3JDUDBUQ2pN?=
 =?utf-8?B?UWxya3ZQVWNnTHl4WUVvY0FlRVFSdGhMb0thTTdtazVld2Zib0Y4TzdYaDc4?=
 =?utf-8?B?Qk1kWGtNQklTYjhYRURYWFd6dmhER1U2N0cwT1B6ZmozTTVTWG1kTUxuLzNP?=
 =?utf-8?B?UHY2RDlQZ2lhTHRmUGJpQTk4dFVEbkRVNU5laVBtNDBWdzZoZEg1REwxYUlh?=
 =?utf-8?B?NFA5WkJ3azkzaXZPcFJGMEZlMFduczBXQUFYNktkVTY0N3B6OUZXdmI5dncx?=
 =?utf-8?B?dXRqOWhrQW5OV3Y5MTBSdkg2U3BsR1hKZGw1Mm1JemVXdHptRUJFUWVHOWh0?=
 =?utf-8?B?OXV1ajVaRTcwMHRvVk14L3U3KzhETERUZkprSWtlQjVpN2pSZ0tSQTVUcXZ4?=
 =?utf-8?B?bXRQSCthSmV4UnAxZ2E0Si82QmFyRit5S3hyNTMzMXF2SnVZb0xqNjFKQjZj?=
 =?utf-8?B?VmNrWUZ1cTdiTEc2c2dFZ001eE5UQkJSRDlERXptWHdnL0hsRVRVTHhjbVAw?=
 =?utf-8?B?OXMrSElkSVBVd1g2a2loUklSdXI2bXplKzNJVk9IL3p1SFFjY0RIbU9rU2Nr?=
 =?utf-8?B?Rkc1OTJaTXVjL2M5b2pCUGlET2xPVVFJWmdGS3VGRDEwdW9RZUFSeEJkV2Z2?=
 =?utf-8?B?T1F6QTV3ZWo1ZmZYUjdVazZYR3JTYVMzRGpNVzRsK0x1ZW12bE5OVUdVdzBU?=
 =?utf-8?B?akpTNkFDYnBVZ0N0VHViMGNaKzY1cWZkdTRoYUhLcTFtVS84dUVjRmMwZE9j?=
 =?utf-8?B?S0lsVEF2U1hxRXhFZmVtanQ5eEhLQUJWMWJiNU1ldTlLbTdwaENKd09uQWtq?=
 =?utf-8?B?MmhjU2IzUTdiNERyc1I1RGhvZHdyTy8yZDlsQkp3MGFHajBvR3BxNVZucFZJ?=
 =?utf-8?B?cWp4UmM2WmxMVWVWNEcrOUJJeXRYaURrd2U2VUQxYVYvUXhsbGZubkRGOXJY?=
 =?utf-8?B?SU51NVF0ZGVqRjdYRTZ6RjRaNkZkMlJMeldYaUo5cWk2czd1ZzFuK2hJQ2NH?=
 =?utf-8?B?TWdleTRUZnZ5QWQ0M2NNaTg3S2N1SnoveVJRMVN4Tk1ZTXQ0MW53TjVsNWRj?=
 =?utf-8?B?UVdNTW8ySldaWlNESTM5dVpDQXMyQ2gzbXg5dlVLeFVJdzIxU1lMamhFTmw0?=
 =?utf-8?B?Rk9TKzNsbXJPQm9PMmFKbWNkYUV6RUtnNHI1aUZGaUVaUThQdUNneWtTZ0xH?=
 =?utf-8?B?eWNRTk1UTThMTnU1MHNVUmhJZmtOMnpDSXhTQnVTNlA3UllPMzJYSUc5dmpL?=
 =?utf-8?B?Ni9OQVV6Z0tNVHhpc1Y5NHJLY2ZiUjdHS0YvNStlTzBSaFNZb1dDWnF5ZEp6?=
 =?utf-8?B?ait6VzV5L0ZENVhPNlcxZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDZNUlUvR2pNRmVYL0J4VCswZmdiWTFZMTFnbXUyTUl6TDNxYjI4VHladnVt?=
 =?utf-8?B?OWR3ajUramEvN2R1OEUrM0pKS0xneGFURndGYW03Q2d0eGZVd3pRSkRNcEJ5?=
 =?utf-8?B?NU9hazBLL2VKaUtjRTllYXBnT054U0NwNjNZdnA5MS9tNHlxSHpNaWwvS2dh?=
 =?utf-8?B?RmhBWloyTUNkRFM4TmR2dC9HbWovU3N2SERIZ2VsbE9SNkhudHYvMFJjcVJW?=
 =?utf-8?B?Ui9kZkdUTHcyY2UzSjhueUlpSmxLOGh6eHg5VFZmR0tCZnNVMXo0UGUrSE9s?=
 =?utf-8?B?WDBobWk2MkpUK1M1T0RzY0NTTWROMnZyRzhJT0hHdDBIdWliaDFtbGkwcVZD?=
 =?utf-8?B?ZUYxNVNpRUYzM1A0K3Q5Ulh1eUhwOUtpVTR4UGhsTVBjKzl5dFIzWHEwUE90?=
 =?utf-8?B?aXVxSVNJUUZURGdodSthd0lhQ0dsRGFuNUpDN3Fpd1FpQ2hYbloyV2ZmTWE2?=
 =?utf-8?B?UTZPWG5pcDBvU2pVbUpRc3l6YWVxUy9ZMFIzUUtlMmRVUzZiRDlwZE5WZGhC?=
 =?utf-8?B?L1Q2eVAwM3ZKeE9nbmc4RlNUM3JheHJCNjlpamxhUjUwbFQ5S2NXZitrMkF1?=
 =?utf-8?B?dnh6MjZHNlFRK1g1NGgzNENiMEhJUStzOVZVdjNoT0RkcSt0alNBNkE2eTY0?=
 =?utf-8?B?ZEx6THFmUjlab2h0QXJXQ1p5QXRjaUZDbXRCOEJ2SzEvWVhXd044dWFqb2dG?=
 =?utf-8?B?T0VmT3c4bkRVNmZxUDhLb3FVWEZyeFFKb3ZKRU5OYUNkTU9UN200TytUWVF3?=
 =?utf-8?B?TmFHTkdmWkFCc3cvM3haclRhb0xpTFg5aVp2RTBBSnZVZ3lrM2N3V3U5K3Va?=
 =?utf-8?B?Z2JUY3lNWTNJNU1Va3JNRTJ0bzJwT1dhZllvNlA3Y3IvSXUwNG1JeXpaSmVl?=
 =?utf-8?B?SHJMVnA3M1p0aWhIaTBFUVl3cXRIS0U4aTcxZGFyZWs5Y2xQVkhBUXFjWThj?=
 =?utf-8?B?MWZXeDlTNGZKT3FtblR2cmphS081UVBMbWJ4cEVGYzRXQ1VPWU9IRWZBbG9m?=
 =?utf-8?B?VkNSYWR3V2l1V1JXdzFiOGJETUJVNHhlWUlUZG82QmZOOU5LOUs2UGhIRjNC?=
 =?utf-8?B?amNkMFNUR2lwMUNLM2t2YnRoY3QrYkF2V3JFaEFaanZrYjloQ2JQcm5zYmZH?=
 =?utf-8?B?eVQrQU96M2RXN2ZqbHQ4WUt6Y3pVd3RWaXBoaTZuUHhOSHpkaEJ4bzhSWVRT?=
 =?utf-8?B?RUs2NkxrWFMvMHlwQnNzU3FZTkxObXNLSmQxRU9yci9oSE1DTU9FdjhydzQ2?=
 =?utf-8?B?WlY4QlFvQm5kd0x3Si85MDNyYU43NlZJSHU2TkpsSXZOdzMvM2Y2eCtjd0hm?=
 =?utf-8?B?MUg4RGt5NDhRWVpvem5nN2JsMWhhTzd2aFFZL0xSWmg5SUVGQXFKZlV0bmx0?=
 =?utf-8?B?K096Vnp5ajlrNXVlWFBVbkhiZmxzWTRETzM2WEEwdGhVMW8zVXdyOTJ1TmNW?=
 =?utf-8?B?VzF2OURKQlJ3QUNub0ZTWXBtQ1FEOEVtR3ViSlZjY1o4YnF3NUUvZmpSd1Ja?=
 =?utf-8?B?UURXZ1dtQmZjOXNnU1FqbFgyV1cvbnlhOFc0MHlCRDZKU3FzK1QyU1VoN0FR?=
 =?utf-8?B?VHN1VGQ4anRyY2JCc0ZFV0c3NFdhY2l2ZkNuNURJZjJmWTREYnRCME1PS25v?=
 =?utf-8?B?ZllPL2VCenZNaVhKaXQ5dG1pR3U5eHpmamtOamF5cE56dVRISk5pMlNNWUc4?=
 =?utf-8?B?UUxneG9HWnVLNXBnbjlHZXQ4aStwZVJhYXN6N1JkNTB5aEl1ckpyZGQrYnRP?=
 =?utf-8?B?NVMvcUxxaURnL2k3N0FFNDBub1NVdmt1c2hncEs3ZjRNbzFVZ01jUnErd0hO?=
 =?utf-8?B?ZUw3WUZTT1NSTHBrTjRXUUNvZkE1M21JWEZaY1Z3cklOOTZ0Qy9FSnFwT3Jq?=
 =?utf-8?B?Z3ViU1kvZE9MeWxFWnlRbWc3aVFhaWlobWlzcTFKSWxOV3BKY0NQUWFCNlBp?=
 =?utf-8?B?ZzRsZlZCOEg5cnN2djRqalNwZldtV3VqUXJqeUlkcVZ6RzdWMG0vU0tGUEF3?=
 =?utf-8?B?NldxS0ZRR2x4RmY4OUxESi9HTFZDamMzU2Y0VU5YWmF1Q1pjL2FaMTYvdzZs?=
 =?utf-8?B?dGJIVGljRkMwV243c3RHZmdGSHFtTzBIbm5VR2RvZjhQb3k5R1VZandlOEhi?=
 =?utf-8?B?UGRiT3Q2U0d1ZUVJWU8zdDd5RDRHM3pvLzdKVEZZcTdiTUQxYXkyRG1sZ25u?=
 =?utf-8?Q?x5CBbADSWIPyU5X+6/ztqO4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77E151F780656B47BFE3F939CC4B0C75@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ede01cb5-30cf-4c7c-1a44-08dc74aea331
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:14:18.8655 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iR6tlSIHjQafkpTYDlMxF8cPUuHIo0VOYarTqfPZ3EpVolQTUxnfv0b71A+aF31bPsqq5++0r95xHmUfLhdG1AjNUB2Bk3wogvhSPNF4LTvka68DwoJLMZhwy//9YwK/
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

U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11LmMgfCA3ICsrKysrKysN
CiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9ody9pMzg2
L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCmluZGV4IDUzZjE3ZDY2YzAu
LmM0ZWJkNDU2OWUgMTAwNjQ0DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCisrKyBiL2h3
L2kzODYvaW50ZWxfaW9tbXUuYw0KQEAgLTIyOTksNiArMjI5OSw3IEBAIG91dDoNCiAgICAgZW50
cnktPnRyYW5zbGF0ZWRfYWRkciA9IHZ0ZF9nZXRfc2xwdGVfYWRkcihwdGUsIHMtPmF3X2JpdHMp
ICYgcGFnZV9tYXNrOw0KICAgICBlbnRyeS0+YWRkcl9tYXNrID0gfnBhZ2VfbWFzazsNCiAgICAg
ZW50cnktPnBlcm0gPSBhY2Nlc3NfZmxhZ3M7DQorICAgIGVudHJ5LT5wYXNpZCA9IHBhc2lkOw0K
ICAgICByZXR1cm4gdHJ1ZTsNCiANCiBlcnJvcjoNCkBAIC0yMzA3LDYgKzIzMDgsNyBAQCBlcnJv
cjoNCiAgICAgZW50cnktPnRyYW5zbGF0ZWRfYWRkciA9IDA7DQogICAgIGVudHJ5LT5hZGRyX21h
c2sgPSAwOw0KICAgICBlbnRyeS0+cGVybSA9IElPTU1VX05PTkU7DQorICAgIGVudHJ5LT5wYXNp
ZCA9IFBDSV9OT19QQVNJRDsNCiAgICAgcmV0dXJuIGZhbHNlOw0KIH0NCiANCkBAIC0zNDk3LDYg
KzM0OTksNyBAQCBzdGF0aWMgdm9pZCB2dGRfcGlvdGxiX3Bhc2lkX2ludmFsaWRhdGVfbm90aWZ5
KEludGVsSU9NTVVTdGF0ZSAqcywNCiAgICAgICAgICAgICAgICAgZXZlbnQuZW50cnkudGFyZ2V0
X2FzID0gJmFkZHJlc3Nfc3BhY2VfbWVtb3J5Ow0KICAgICAgICAgICAgICAgICBldmVudC5lbnRy
eS5pb3ZhID0gbm90aWZpZXItPnN0YXJ0Ow0KICAgICAgICAgICAgICAgICBldmVudC5lbnRyeS5w
ZXJtID0gSU9NTVVfTk9ORTsNCisgICAgICAgICAgICAgICAgZXZlbnQuZW50cnkucGFzaWQgPSBw
YXNpZDsNCiAgICAgICAgICAgICAgICAgZXZlbnQuZW50cnkuYWRkcl9tYXNrID0gbm90aWZpZXIt
PmVuZCAtIG5vdGlmaWVyLT5zdGFydDsNCiAgICAgICAgICAgICAgICAgZXZlbnQuZW50cnkudHJh
bnNsYXRlZF9hZGRyID0gMDsNCiANCkBAIC0zNjc4LDYgKzM2ODEsNyBAQCBzdGF0aWMgdm9pZCB2
dGRfcGlvdGxiX3BhZ2VfaW52YWxpZGF0ZShJbnRlbElPTU1VU3RhdGUgKnMsIHVpbnQxNl90IGRv
bWFpbl9pZCwNCiAgICAgICAgICAgICBldmVudC5lbnRyeS50YXJnZXRfYXMgPSAmYWRkcmVzc19z
cGFjZV9tZW1vcnk7DQogICAgICAgICAgICAgZXZlbnQuZW50cnkuaW92YSA9IGFkZHI7DQogICAg
ICAgICAgICAgZXZlbnQuZW50cnkucGVybSA9IElPTU1VX05PTkU7DQorICAgICAgICAgICAgZXZl
bnQuZW50cnkucGFzaWQgPSBwYXNpZDsNCiAgICAgICAgICAgICBldmVudC5lbnRyeS5hZGRyX21h
c2sgPSBzaXplIC0gMTsNCiAgICAgICAgICAgICBldmVudC5lbnRyeS50cmFuc2xhdGVkX2FkZHIg
PSAwOw0KIA0KQEAgLTQzMzUsNiArNDMzOSw3IEBAIHN0YXRpYyB2b2lkIGRvX2ludmFsaWRhdGVf
ZGV2aWNlX3RsYihWVERBZGRyZXNzU3BhY2UgKnZ0ZF9kZXZfYXMsDQogICAgIGV2ZW50LmVudHJ5
LmlvdmEgPSBhZGRyOw0KICAgICBldmVudC5lbnRyeS5wZXJtID0gSU9NTVVfTk9ORTsNCiAgICAg
ZXZlbnQuZW50cnkudHJhbnNsYXRlZF9hZGRyID0gMDsNCisgICAgZXZlbnQuZW50cnkucGFzaWQg
PSB2dGRfZGV2X2FzLT5wYXNpZDsNCiAgICAgbWVtb3J5X3JlZ2lvbl9ub3RpZnlfaW9tbXUoJnZ0
ZF9kZXZfYXMtPmlvbW11LCAwLCBldmVudCk7DQogfQ0KIA0KQEAgLTQ5MTEsNiArNDkxNiw3IEBA
IHN0YXRpYyBJT01NVVRMQkVudHJ5IHZ0ZF9pb21tdV90cmFuc2xhdGUoSU9NTVVNZW1vcnlSZWdp
b24gKmlvbW11LCBod2FkZHIgYWRkciwNCiAgICAgSU9NTVVUTEJFbnRyeSBpb3RsYiA9IHsNCiAg
ICAgICAgIC8qIFdlJ2xsIGZpbGwgaW4gdGhlIHJlc3QgbGF0ZXIuICovDQogICAgICAgICAudGFy
Z2V0X2FzID0gJmFkZHJlc3Nfc3BhY2VfbWVtb3J5LA0KKyAgICAgICAgLnBhc2lkID0gdnRkX2Fz
LT5wYXNpZCwNCiAgICAgfTsNCiAgICAgYm9vbCBzdWNjZXNzOw0KIA0KQEAgLTQ5MjMsNiArNDky
OSw3IEBAIHN0YXRpYyBJT01NVVRMQkVudHJ5IHZ0ZF9pb21tdV90cmFuc2xhdGUoSU9NTVVNZW1v
cnlSZWdpb24gKmlvbW11LCBod2FkZHIgYWRkciwNCiAgICAgICAgIGlvdGxiLnRyYW5zbGF0ZWRf
YWRkciA9IGFkZHIgJiBWVERfUEFHRV9NQVNLXzRLOw0KICAgICAgICAgaW90bGIuYWRkcl9tYXNr
ID0gflZURF9QQUdFX01BU0tfNEs7DQogICAgICAgICBpb3RsYi5wZXJtID0gSU9NTVVfUlc7DQor
ICAgICAgICBpb3RsYi5wYXNpZCA9IFBDSV9OT19QQVNJRDsNCiAgICAgICAgIHN1Y2Nlc3MgPSB0
cnVlOw0KICAgICB9DQogDQotLSANCjIuNDQuMA0K

