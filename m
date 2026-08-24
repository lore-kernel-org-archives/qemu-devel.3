Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32063C5DF9B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyUlq-0001At-BN; Mon, 24 Aug 2026 09:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neal.frager@amd.com>)
 id 1wyUlb-0001AA-NV
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:31:11 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neal.frager@amd.com>)
 id 1wyUlZ-0005GH-6I
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:31:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGsKRcKZR9hZ+5cgAwV+O1bw5ieNAcHZjCEoBqvSZn3mhHlEFhhYCZ930Xxlu6uQVpfmMEV08Z+tsJ8d9WAVhGJlkWlNo6mtX7H+bcJ81+ax9JIj413nNNfrJE+DuZuk+rg1IaIRdKtgQZJvhBOhx+AXvk5sirj9UIxM8N5/IHFCQ2ubcTnrs66pBMAa7AcVkn84jS9+yn2Wjz55BODqSkp466CoRqIFiQWPn6scJXXSdsR8bgbfMu42eIXxuo0tIwaDzvIZug5Cg5Jw6Kf+eRvQn71VjavJ+S6LPoSKGnRU6qRYOyhv0VmXIUeFMK2Pygjha0AqFuDaLo9trMe/sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quEor2gylcZ4dQoDnP21GY4cNRxz+KjlMVJQt7mHae8=;
 b=P3kpeDz5F8UTo5qYHyjGbPGZz5Q5xmnlOp7LKPAx42ocNsoGzXFSalCBeY5Gp8CBtPucpnWT2vQBOG6eBG0dG4CMimNGMusa9vqT02GQxe3x7+ENedkRdF7mkgwUiUlQl/6eX2Tx1ZhkIuKsh5C12fM9WUzUcRDYO36n01b5OAOgct+o7IQx776bwCsxaRS904jw/8MyK+m8oUuivU16khgwajpjCIBFBmo+jLVKvIMLxsJj9NFasFf+T++KAhtqh3OaRYmCLF7J7VsnQJen5L07ntsqamPktTPRW5xP2lGZGdgn6WD1vp/SpCTvznLebJM3ECVFOwCAqEeSbDcQLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quEor2gylcZ4dQoDnP21GY4cNRxz+KjlMVJQt7mHae8=;
 b=tlyPryuIbkDym5xiLCVq1OEI0Zdza6yGQmQ9mXtcaOjXGNsYI3lVQJbwd7v2yxEE+Z17ehSkRpN/sGN2ogQw+6dO3xFrED6sEG06pyFBTi9zf4sismIJ/aC+c58KL18X7+V1UZhBn0hhHBBNWaUJEiNYasdE7l3zCcDefOkJP+Y=
Received: from BL1PR12MB5032.namprd12.prod.outlook.com (2603:10b6:208:30a::12)
 by DSVPR12MB999310.namprd12.prod.outlook.com (2603:10b6:8:41e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 13:31:02 +0000
Received: from BL1PR12MB5032.namprd12.prod.outlook.com
 ([fe80::3c13:eeb6:d9ef:c95d]) by BL1PR12MB5032.namprd12.prod.outlook.com
 ([fe80::3c13:eeb6:d9ef:c95d%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 13:31:01 +0000
From: "Frager, Neal" <neal.frager@amd.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "sstabellini@kernel.org"
 <sstabellini@kernel.org>, "anthony@xenproject.org" <anthony@xenproject.org>,
 "edgar.iglesias@gmail.com" <edgar.iglesias@gmail.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "Stabellini, Stefano" <stefano.stabellini@amd.com>, "Saleab, Micheal"
 <Micheal.Saleab@amd.com>, "john.ernberg@actia.se" <john.ernberg@actia.se>,
 "matthew.l.weber3@boeing.com" <matthew.l.weber3@boeing.com>,
 "vincent.stehle@arm.com" <vincent.stehle@arm.com>
Subject: RE: [PATCH v1 1/1] include/hw/xen/xen_native.h: downgrade
 include-order assertion to warning
Thread-Topic: [PATCH v1 1/1] include/hw/xen/xen_native.h: downgrade
 include-order assertion to warning
Thread-Index: AQHdJJsckvnz/cO5N0ySs3v4A11/7LatQ5eAgAAFmcCAAAXOAIAAAMSQ
Date: Mon, 24 Aug 2026 13:31:01 +0000
Message-ID: <BL1PR12MB50322B1D97569B5CADEC8E55F0A02@BL1PR12MB5032.namprd12.prod.outlook.com>
References: <20260805052723.2823538-1-neal.frager@amd.com>
 <2383a98d-d88d-415d-9de1-aa68a5d215fe@amd.com>
 <BL1PR12MB5032F21E0E2A6F17398B6D76F0A02@BL1PR12MB5032.namprd12.prod.outlook.com>
 <CAFEAcA8sWn1vjm+OFYzwA-jko2vYkFcWPwT6g9=0AeO+JQo-JQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8sWn1vjm+OFYzwA-jko2vYkFcWPwT6g9=0AeO+JQo-JQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-24T13:28:44.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5032:EE_|DSVPR12MB999310:EE_
x-ms-office365-filtering-correlation-id: 27de5415-703e-4129-ff6b-08df01e3f0cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|38070700021|6133799003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: ftlHy0XSeh/p9lOxehx2+HpXxAvXChDoQNps/6Wz7BHXgPW0WAoTnlH+vzGEzR77XgQ2bbxZGdxK4NSMZ5gxVaq2zOCFajQbtuYXJZ5NTBelRrl/Kp7tfNZm1g76ATw5Ar5BS7xxAdTsBhfkFAVDafUNzYPtRbmZu79b2u659RdZFNYhCTBBKO35Bvq0EVeu01xJ8puVAYy/NQaon0+GBgC5PfOOP6okKpC4uSblkCkrZJcO1ChdmgbTlbTRSVr2lFcJvc1sbGEl4rE8qCnfJkiCkCDATHfSQUub4JeU+y+XLmlpU92vtJhXVVWWwXEK2pBuzCirC/8ChwNi2yXXEw+9wMG+IMKPKlm70OwV4Kx/2nODbf6fN8Jsja7t97ZOEJG4Gyz2HVundOuYQyEi9J/VafaSLMzg2gEl4IfBpMtNZYLtkMRJgtGjBL9RsQH2Vpv1gkGNtTokoPAd7FHhGQEiyBgk34MqvGCwFW5mHUpCCIpHWU6UaJiuTCEIJNo6JMRuJy6uIfCrOGCvgDcuW68L1txga0R379qtiM9Oo4k6tRwYapq7gf//Tg3r6jtoiMTYfnHV0DbWX8IIw/7Q6SOJe0U3m6cDq6x/MBWRX8YTPROVIawKKPjWc39AScEKa0CZseG3+5hruVsBuvKDzYT7r63XSNibiMsNDmsFSoRkHQKLhtHnvnsJcLpucWVzxkhKDAk6xQiOe+XPVmjGSaNVQJTtsOZLmcePFpHKbws=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzQrYVp3cTlMRTQ2Nk50TzkrSFdSK3RrbzNPK2s2S3VWTjc1aWNzNWZJOVpK?=
 =?utf-8?B?cFFOLzdIUWg1TkRmeVlMeVpYUlV2SUV6MXlUeldyc2hLYm1obi9XM0lqcWNt?=
 =?utf-8?B?aHVtaGhFOEVsTEtMekdVS0lUaG9hYnUxajNEL09BVVJrL1QzVmxWNHRUS1hT?=
 =?utf-8?B?bnExbFU3MENqSHhhclA5em1EMDFQalJOWjc3aU1pZW9iUm9sQ2g3elRUbG9h?=
 =?utf-8?B?VHQ0akp3cm5vTGM5bWtMa0QvemZSVVEzY3hPVlJLMnNzNlVoSFVWY3dXbDNa?=
 =?utf-8?B?ZG5DZVZWd2pTaHlHVk9xUmxjSU1RSUFsOFhGTWdBS2F2b0h2a2dRWkhnWU1W?=
 =?utf-8?B?K0tBdHJYT09QWVBPV0lldUZPdThtYXFKYzZvQ3MzcUJOMlV2ZDlwL3FoZGhz?=
 =?utf-8?B?ZVlObG11d3ZuQlg0clFFWlZGb2JaQ3pSSDZ5aFpsRzl6aFo4KzhqU2FlcFJ5?=
 =?utf-8?B?cFQ1ZjJHbktrZEl6WE5nbzYwN3pZSWZFRHJTYlJkMEZYMjYxNVNlWFVWRDl4?=
 =?utf-8?B?ZVNwN3h0YlpqNndlbUZ2R3hFMlhTbi9rRUtXcXlwUmU2UXVRbmFOYSthK2kv?=
 =?utf-8?B?RTRZRlhWMVNiTDg4U2Q0YWZJVmVwQytLZFdlclFwU285U1FUQXVLRlhZeHhq?=
 =?utf-8?B?MUgrOUM3a2drcGMxYzRuYkhCRGs5VWtYVGtaSEdGK1FnRVhmQUdzMUhhQVFn?=
 =?utf-8?B?ci9DRHlHb21ibFhNNWYwUzlGYi9va2lXOWN1TnJLU0o0em1YOG1qbWNVVm50?=
 =?utf-8?B?WTdRNzVlVFROU1h4d2xJMCtVUUdoRjRETTNyWUlOZUpKd3pqMjJpYWNsMTJi?=
 =?utf-8?B?SkRpYkxOTFUyWGRZc3lUcTg5SEc4andWTHphb0kvTkw5RTM2RGtKL3RhdlBY?=
 =?utf-8?B?NlE0ZHpWR2k5OG04V1hRTnl5T2FBZStmNjNFRGg1S0F6b1pSWHFOMTRWVXg4?=
 =?utf-8?B?a1ZqdjFIQjByanJuMXprc2pFeFlCOWhjQmZaWGFYdGlsaWJ4M2Q1WGlZS25D?=
 =?utf-8?B?RFcyc3BtaVhaaXp2Q2FzdEx5ckowbk5ncWJFYjl0SVBybzBlK1ZmL1BxWSsx?=
 =?utf-8?B?Q1VKVFVXanlXQXREWGIxZXJaK0tvam01UkhUeWIxcHlpbkhiS3p3eFZ2bktC?=
 =?utf-8?B?QnhndVJSbFZCZ1pneW1nNFU3b0ZKQnFiRzIxQ1MycWVXblFmZXdUQ1BqRFo4?=
 =?utf-8?B?MHFYS01aLzV1RGlpQmdxT2tGYnpiZ1RTcVV5VEt1M3lYakQ5VmQxRGtJbzhJ?=
 =?utf-8?B?bVdUdGk5eUo0QVBZUjNnTUxabkNmcTE4U04xVGhzck9wckZjR09DVlhMdFBq?=
 =?utf-8?B?dEFiRFFyanQ1TG1DTnVPVE91ajVXK1R2S0U5dG1nb0UzZG1GTTlocjdBajYw?=
 =?utf-8?B?WW5LRXZYeHFJWTlBdVVPQTFhNG9uVTRZbzZJYllBT0ZTaVIrM3V3V1JsYXhx?=
 =?utf-8?B?c0p4dkpIb0x6aE80ZGhHM0dvVUhOR252Y2lqRXZvMkhVbG41Rm9tek5CYjha?=
 =?utf-8?B?RExWS1F6RDhMS2NjbS9zYXJkb3dtU3hpTWxJZ3ZudGM5MHJuZHdmUGlXTlQz?=
 =?utf-8?B?ZFczbjU0ZGhhWWJxUG15dTIwYzZncjhaL3lkNmo0T0xzTTl5U1ltZ3J0UVBO?=
 =?utf-8?B?Qmh3TnhjM1IxYnd3ZmNEOVBuRVVMTXA4cWpiSm9qZi9QSUdQZDZQbk1wM1Vt?=
 =?utf-8?B?MnJjdWZ1eXpuZTVvL3UzazNKL00wL0Z6emRZTk00OTkyTFFZRFlZVmRqNFhj?=
 =?utf-8?B?K3lzSEUwZDZ4cFFDdUMxQldFSnpyRlRDY0IrUFd3MCtqdjFXWUFSN00rb0xC?=
 =?utf-8?B?RHlmVUhDbGhhaUdNV0RVZXYyNU0rdmVwOWFPU3NhR3V3MmM5L0RvNUE3OGpX?=
 =?utf-8?B?MDNKMHpLQmlkZUJSbzZ4Q1VTWXFIaVp0V3lqUkZpUkN5Rmk3dzV5Sk8ydU1h?=
 =?utf-8?B?UDk4Q1FldWI2blhQK2o0Smd1NGllbDNuNmV5Z0dQbXRmWlJHemczckdCcTY2?=
 =?utf-8?B?aXFqMGduV1RwZlJZaXFjalptYVpwNU5HZFowenBIL3RNUGM3MnNhRzFpUkhu?=
 =?utf-8?B?MUZzdm5qM1QremZJM2hncy90ZDFlNEJreTBlcXNram5XOHhlb05UeDFNSDY2?=
 =?utf-8?B?eHhQMklDdFlpOGlmcTZxV0F2aGtyMGt0LzJuUVY3R0xhMHR2cDdpUjFXN05Y?=
 =?utf-8?B?OGFtdVRDV3dkbmFoem5GSGl5c0VsM08rTktSajlDMWVUZlg5cDVKalAxdERm?=
 =?utf-8?B?Qy9CcHJJdWg2dXlmRGNpeTUyMnRmeHdvY0dOMVo1c0VRWFliOXc0L1ZWQk1n?=
 =?utf-8?Q?e7jMPaW5us8DGAUq9r?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5032.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27de5415-703e-4129-ff6b-08df01e3f0cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 13:31:01.8847 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e6oHlze76a1qQvRn8vjgKaPUShJQVAarM/qQgeVey3AVG/2gk7YA8Rlcvl6uWzwF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999310
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=neal.frager@amd.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

QU1EIEdlbmVyYWwNCg0KSGkgUGV0ZXIsDQoNCj4NCj4gSGkgU3Rld2FydCwNCj4NCj4gPiBUaGUg
LUkkKFhFTl9ST09UKS90b29scy9pbmNsdWRlIGFkZGVkIHRvIFFFTVUncyBleHRyYS1jZmxhZ3Mg
Y2F1c2VzDQo+ID4gX19YRU5fSU5URVJGQUNFX1ZFUlNJT05fXyB0byBiZSBkZWZpbmVkIGJlZm9y
ZSB4ZW5fbmF0aXZlLmggaXMgaW5jbHVkZWQsDQo+ID4gdHJpZ2dlcmluZyBhbiBpbmNsdWRlLW9y
ZGVyIGFzc2VydGlvbi4gRG93bmdyYWRlIHRvIGEgd2FybmluZyBzaW5jZSB0aGUNCj4gPiB2ZXJz
aW9uIGlzIGNvbnNpc3RlbnQgaW4gY3Jvc3MtY29tcGlsZS4NCj4gPiBSZWY6IGh0dHBzOi8vZ2l0
aHViLmNvbS9xZW11L3FlbXUvY29tbWl0L2UyYWJmZTVlYzYNCg0KPiA+IFRoaXMgaXMgYSBidWls
ZHJvb3QgaXNzdWUsIHNvIEkgZG9uJ3QgYmVsaWV2ZSBpdCdzIG5lY2Vzc2FyeSB0byBmaXggZnJv
bSB0aGUNCj4gPiBxZW11IHNpZGUuDQo+DQo+IEkgYW0gbm90IHN1cmUgSSBmdWxseSBhZ3JlZSBo
ZXJlLiBXaGlsZSB0aGlzIGlzIGEgYnVpbGRyb290IGlkZW50aWZpZWQgaXNzdWUsDQo+IHRoZXJl
IGNvdWxkIGJlIG90aGVyIHVzZSBjYXNlcyBmb3IgX19YRU5fSU5URVJGQUNFX1ZFUlNJT05fXyB0
byBiZSBkZWZpbmVkDQo+IGJlZm9yZSB4ZW5fbmF0aXZlLmggaXMgaW5jbHVkZWQuDQoNCj4gQnV0
IHdoYXQsIHRob3VnaD8NCg0KPiBBbmQgd2hhdCB3ZSBoYXZlIGZvdW5kIGlzIHRoYXQgaWYNCj4g
X19YRU5fSU5URVJGQUNFX1ZFUlNJT05fXyB0byBiZSBkZWZpbmVkIGJlZm9yZSB4ZW5fbmF0aXZl
LmggaXMgaW5jbHVkZWQsIGl0DQo+IGlzIG5vdCBhIGhhcmQgZXJyb3IuICBGb3IgYnVpbGRyb290
LCB0aGUgcWVtdSB3b3JrcyBqdXN0IGZpbmUgaW4gc3BpdGUgb2YNCj4gdGhpcy4NCg0KDQo+IEkg
dGhpbmsgdGhhdCBqdXN0IG1lYW5zIHlvdSBnb3QgbHVja3kuIEVpdGhlciB0aGVyZSBpcyBhIGhh
cmQgcmVxdWlyZW1lbnQNCj4gZm9yIG9uZSBoZWFkZXIgdG8gYmUgaW5jbHVkZWQgYmVmb3JlIHRo
ZSBvdGhlciAoaW4gd2hpY2ggY2FzZSBpdCBtdXN0DQo+IGJlIGEgI2Vycm9yLCBhbmQgd2hhdGV2
ZXIgaXMgY2F1c2luZyB0aGUgbWlzLW9yZGVyaW5nIHRvIGhhcHBlbiBtdXN0IGJlDQo+IGZpeGVk
KSwgb3IgaXQncyBmaW5lIGZvciB0aGUgb3JkZXJpbmcgdG8gYmUgZWl0aGVyIHdheSAoaW4gd2hp
Y2ggY2FzZSBpdA0KPiBkb2Vzbid0IGV2ZW4gbmVlZCB0byBiZSBhICN3YXJuaW5nKS4NCg0KRnJv
bSBteSB2aWV3LCB0aGUgb3JkZXIgdGhlIGhlYWRlciBmaWxlcyBhcmUgaW5jbHVkZWQgZG9lcyBu
b3QgbWF0dGVyLCBhbmQNCnRoaXMgc2hvdWxkIG5vdCBiZSBhbiBlcnJvci4gIEkgYWdyZWUgd2l0
aCByZW1vdmluZyB0aGUgd2FybmluZyBhcyB3ZWxsLCBpZg0KdGhhdCBpcyB3aGF0IHdlIGFsbCBh
Z3JlZSBvbiBpbiB0aGUgZW5kLg0KDQpCZXN0IHJlZ2FyZHMsDQpOZWFsIEZyYWdlcg0KQU1EDQo=

