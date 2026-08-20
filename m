Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A95C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 01:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwr91-0001dn-Hu; Wed, 19 Aug 2026 21:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwr8p-0001X7-8l; Wed, 19 Aug 2026 21:00:24 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwr8n-00013F-87; Wed, 19 Aug 2026 21:00:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNt6A6AIEjJY/7FldV7XXDplzR2ayECI/S7QMk3VIayYAgxJH08rp0aiYGXHqsBsyctiw+y7dKDJ20j+FBmf3hHYr/wgwON7BFMjwJutOzuwZu/9jDtEySXfmk8rdKmHyZWK7pHEfuLArtQnewe6T5LA2+6pMIFaMbQ4JZEoDQjA338lL5NW0L7zahRVl/JoWR408K1d4tuEqNkFCK2OhSwQIntm0dbQ3xeB/cAAM4VQV2ip/cKYty3ZcXkQMuRWTAMiApObqAmgsp+++WqW3IMSK0iyx+TEqZwgpGv/DmdRHz1k8434B/bfOBoG4eJUhE+0V0MidgFcE92BXieGZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBTCM5kCZ4ZColRRR1kUyx+5tmMursUgKAAyYUTXTLc=;
 b=BEinA9LsqwXw84RAESzCNbtgUQ4nKUOybL7CSV4zXDDHsbOOKunLDVcS5/yF14Sl26f8VylfY+X/VXq/LCSmbDKFslNm6lsNVOHphJRfIyV2BJWEb/Izth8jdyP7ocpVg+oBpy4x/BiIok6TkNzvcn/TDlLVoSHR3I23g3Fu4tsj42FBWfP1FiON5RnibClz2GmfYMdF//Q7LMPOTPQIgsTtkDAGS45sxpkmVzUTliRE/VO86CIhWXZDk+f4CFr86tJqulV8L8oDLnJnrF9e3VC24JIYvSwBF5Vez0gdCMXyguH0bfZL/WkuALlncoi/THeLzhG96171t1JqvqfGCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBTCM5kCZ4ZColRRR1kUyx+5tmMursUgKAAyYUTXTLc=;
 b=isdaatSuMt2uwyzpLrUgsTfzypp/c2PH+Fljy8mLVW3STV14nw6eZUOdvKgWXm/uXqxS8big6U5Pt7M7QuGpC8oNC6WZ+sPdtJs0ymA12qRmm7zlLQ39S8ynHFUmaaY9/BW/Pv4+rsVMSrTKcgDaOPpST1XGxjolnP2FtO9JA450K8lV4aLBP1aW4r2RGz2tWn6IjZV6oNF5VbXdoPTo6S6kbyTSHKmtcABo0omxW1wsLG+knPKq8mjUBbmnqeLlNHkcdL1IsG8If2bKeqwFgcgbv7zkAARF2eGx06rbI80y7duZLkiqaYzLN9mKS8k2xNN2dRJxqH1DHn7zEcFdeA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEZPR06MB6815.apcprd06.prod.outlook.com (2603:1096:101:19d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 01:00:11 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 01:00:11 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 3/5] hw/arm/aspeed_soc: Add the ACRY model to
 AspeedSoCState
Thread-Topic: [PATCH v1 3/5] hw/arm/aspeed_soc: Add the ACRY model to
 AspeedSoCState
Thread-Index: AQHdKuxXB3MNmnWAAEybbVlPXSYo1bal08aAgABUrDA=
Date: Thu, 20 Aug 2026 01:00:11 +0000
Message-ID: <TYZPR06MB498092F8F737DA51A9E28DF6FCA42@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260813062359.425268-1-jamin_lin@aspeedtech.com>
 <20260813062359.425268-4-jamin_lin@aspeedtech.com>
 <932b207f-fdad-41ad-b220-9f50ef0bd712@kaod.org>
In-Reply-To: <932b207f-fdad-41ad-b220-9f50ef0bd712@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEZPR06MB6815:EE_
x-ms-office365-filtering-correlation-id: 6b04f5d6-e59d-4208-4e40-08defe566316
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|7416014|366016|18002099003|22082099003|56012099006|38070700021|4143699003|10067099003|921020;
x-microsoft-antispam-message-info: kW2dkfYcNs7Mh5glsGmu//J3Ao7fYUIA7MZeTeiOsOddjrVY+hgrmckI9Fh/fRgoZmsTmbLP596v5NEnLX0gHvR4U4991I/bKEAd+k3lB2bPplMr5Ro7Gr2XqFW7xLHIeW2v5WslHK6h72rC4PYuUDdKzWJ5HoMQsPw8gOMM9F1M6/bkbfQts5Sxx2TqjJG/XrpNH2228Cb2zmo46luIOiWlMYZg/qio4LKbVCHsYmz6ybtxbjvIDEsFOvnczfR0v+Ywi7g+m4ESNliciChRuxbzmuMXAlpANu0plSCyUU9fhKKyemzTb8s6SpQRVer83d60vgWSJbmxH/ASOTJkITjKX4NgCb8JfEL2sR9nraH8o70nKCIZZsmmvIpfXVaR1BI0PagPIsAtLB/VE5JU+8Srt0ItYyjQoGs3rrvoPsjZc04FUJHc775DnLyoZLYQIFN/FktOsm4IpYB1Izyv9UHeuyS/yjQj2JiUiNeBR4sqG/pRhjXiHaPCtSHuohil2rrhHnoS3cdbCPRWJAnmu6MeJXxAX5sXxg9kCIaNj0KmSn57syC3NPwfeq9pk6Dx3ybflNA0az4FIwOLC/ssOKuGBwBV2P4TY0CaDAXskn2LGYiwQ121AR7w1vuCpTChIvYLUKoW48wUPdUHstRsnWaQaWqjS5Tpf7VcwcBru0+khy5+KuCOmipIleEpo+rvhqTClXSBC0Owm/xmpTe7i6cd0RyGVx2qFV5Fp8NlB7tERyZ81K+Y9XAvlfgCo8zp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(18002099003)(22082099003)(56012099006)(38070700021)(4143699003)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjUwYnFkUkJEdVJLa2k4My9jTXlET1I2MXVoNVJGc2xPYjVhcFFhTzB6cGc0?=
 =?utf-8?B?V2NUS2VIT2tMTHpZM2JjdE00MWNXdXVPUGpUZy9DbTViK2RtYmt3MXFGMTFI?=
 =?utf-8?B?NnBNQnNCMXhvakFEU0pDK1Jld0EwM0p3cHBwNktBbDhBcm15TEswekM0aFAr?=
 =?utf-8?B?UEEvcFFWY3hLTi9uUVRwRjl1V2VuT3Z3bFNURVRGR1Rtd0dtY1ZGUEVZVkF1?=
 =?utf-8?B?ZmtnNE1zdmZmMlJycTNML09zUmFXb1JidUZIdGdFVFFiemgwZzVaMHU1aStI?=
 =?utf-8?B?emtSeGlHbzlpOURhb3MzeGpQYldweEFldzNGSTEweW1VbWNDbStkK3BzUWM3?=
 =?utf-8?B?UmQyYm8rZm9ucFR3d25kalp0N3djMlN5ekVIbnRlUjVBazNOUHRkTGJGdFVw?=
 =?utf-8?B?Lys0cDNaZEhDb3AyWEgxUUxaTGxLQTQ0M2V1TnJ2V1pPK2pnRUhWVWUvaWVq?=
 =?utf-8?B?NWRqRzFuMnZBUmEzUDlrNE9FQVVJcjVTQTMyV2F2eEpNbWNhS0xhOW81TlFk?=
 =?utf-8?B?R2dOajFObDAwUUs4c21vSTRPSnJRYmdCZmNEQ2krRjA0aXBBOGgyV2VucHRl?=
 =?utf-8?B?QUI2OHlzT29NOHVBZWVRZmxTTTNxNEJ1SjJpSmkxaDhHZDJUWXI1eGpWYTZK?=
 =?utf-8?B?V21QbUNHY29DSzJEUHluUHRtTUZZckExcnhjSDhwL3VmSDJ1Z0VYZDQxRlBm?=
 =?utf-8?B?NmIrdjR4YStxYjBwZy9MbUdLbkJqWjR6cWluVXNUTzc2NTBKeGxQM2RrRUh3?=
 =?utf-8?B?b0tucnRxaS9aeGFXZTRRL1FnNXB3VHVkSXJubkl2Zm9VVzd3MkhaWG9weXhF?=
 =?utf-8?B?UTJPdjZrUnFCOVYrUjZiVVJEU3AwZk85Z1lDcWxseGsxSkRMUTh4NFI5K2E5?=
 =?utf-8?B?SktvZS9aRWJXY0VzakZreXBWNE5lVUhkNEhHRCtvQy9iUkdla0RtV28wZHRr?=
 =?utf-8?B?YVB6MHNqRDEwS3pZQ1FsOExxcnJDa3NFRXpUQjFjTlZYWitIc1JqdDBZT0JX?=
 =?utf-8?B?bkQ2RFl4MHdBa3RXaFdzZnFDOXI2MkJXSUFKWVFVdjg4ME1MK2NpT0EwT2FF?=
 =?utf-8?B?ZUUwYXBWdlpmUEVQZDBKRkt4SU1pekZnTnovSXhNcXFsTzFZWktVSk9ZdllR?=
 =?utf-8?B?a2VyclgyeDlTNDVkWDEyZGVTNWxuaERyMmdHbmcvTzNQWGQ0VVErWTVUSVp3?=
 =?utf-8?B?RHlGaUZjVUdVc0xjbFUvY1o4Qjd5Z1lZRUlKMTZ5a3VvWTZTSC90TWhJbmpy?=
 =?utf-8?B?a3Y2RWFsK1ZLK2pTdktDdUNBU2xkUlpQS1dJYlc0bFltSHNpYzBzMGQyWXFY?=
 =?utf-8?B?OXE1UVlwRXd0Zkk3L0YwWnE4MDNBbksrTlRxRkNKa282MFVkeGExYmpLOWhK?=
 =?utf-8?B?dDJJUVRtVVh2aHJoeWxFTzErL0ozc2xpejZlZ2p4VitXOWRMLzh6d05TNU03?=
 =?utf-8?B?bG9hZWExY1N3WUE3Rm5qeWtabm0xM1F1QkxTUllqUGdaUmNkekh3WGpGdktz?=
 =?utf-8?B?Mi9OVVpVZHM2UE9JeWtjaVIxMTlkQ0tGYVVkUGVJeC8yeDN0c0h4YjVYcS9r?=
 =?utf-8?B?b0lLa2FiRnRFTDhKTDljZHF3a1pqZGR2L1Z2MDNsa0hKZlQrQXQreFJackZN?=
 =?utf-8?B?SDl0Mkt6NFcvU256WXJMcEdESmhUSDBFb1UrZ1BrSkJYeEhteWdORUZxbTk4?=
 =?utf-8?B?cEZNZTduUGk5cnVqY0RXT2xoaWhUVkJ5SXB6N2lnSVFhL1h6a2Y5MzZnL1Jt?=
 =?utf-8?B?TUljSGVldTkwcmNkT3hHT1NDNzlkTWtVU3RVNXg2S2ZlV01oUmFiQ0tRODg0?=
 =?utf-8?B?TnV0TTQrWUd4WWNrbWszMnFUV0lQQ0F5S0ZjZGJNN1l2UVNwbmZBeHpvWjB0?=
 =?utf-8?B?UDlhZVdnWGwwaVBQbXFhZVJiKytiRVp5VWJML0tGeUtwNGQ2VGhwS3ZoQ204?=
 =?utf-8?B?SHB6RGQxZXZZRmVtc2JhZXpEZ2JjdTBuVi9vWUlKTENFMjEybUxVa29EVDIv?=
 =?utf-8?B?NjB6VWJBWTlYeEVVdWVmdWlGcDNUbkQ3TXNtU0ZZWElscHhEeDNhSDE4cnZn?=
 =?utf-8?B?eTZSSloxeHJLZ3NVMTVTdGxWOFpIZUZlNC8xcU9IVy9SMnpVUkNqNWRQUkE5?=
 =?utf-8?B?a3lQWnBMdmNnM3BRSng0MFl1S1V2R0NLemdZc3lzZE9yWXdVQWV3VXRpQ0hr?=
 =?utf-8?B?MGVDSVNPbjl2a0tlYXc3NWVHMlpDVDhqMUFLMUZ1NXpVMHJ1eFdEeU5BSXpH?=
 =?utf-8?B?QWROcXc1YjRueTVKWmY1dldONlp3VmFrNGZjblFsazlzUkh0Z2FzcHp1Ulkx?=
 =?utf-8?B?aTBxVDcvSW84RE9wM3JmM1cvWC8vV3V4L3crWS84S2RRU1dtZzNKQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QIsyTB1xuIju4DhpQvFB3BAozZmfNnHUZ/567tFYsFaFgRBDjhwKnYuzwfaQat58niTiSuS7bCRtJRpbneK2wgkOv0Te3gqDki9tm4g+y5BExDFRLeDb96Fl0FdtPQXfwI32MJ5QdIi1WoGiGsFHpJ6KLxCzwsJiPBPOEGUVjv6pr7/oZ3u3FMDzrF/ooe6fUpMwoDU4SgseIfcO3ddaofVjeNBo3oAL1/h9RYvNbueROEZkLnv5fRG8pMrVqR3QnLe10E3TCgU3l/W3o+sT72d2nZzlre26u6RGiMsfc/CUcc7kgVInBo4tOzI99w+ROAzRRWLSC2nJI+gFmJ561A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b04f5d6-e59d-4208-4e40-08defe566316
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 01:00:11.6120 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HAHJdaWHSiF82393vos0AcuYlIVHms7u84C3KHL2lQNK7eSEEdrqaFcEZQAHOCnl6y4El8bvPWw4KLII+UDU9EHPRSVV5wW26xTlLKZwFFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6815
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMy81XSBody9hcm0vYXNwZWVk
X3NvYzogQWRkIHRoZSBBQ1JZIG1vZGVsIHRvDQo+IEFzcGVlZFNvQ1N0YXRlDQo+IA0KPiBPbiA4
LzEzLzI2IDA4OjI0LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gSW50cm9kdWNlIHRoZSBBU1BFRURf
REVWX0FDUlkgZW51bSBzbG90IGFuZCBhZGQgdGhlIEFDUlkgbW9kZWwgc3RhdGUNCj4gPiB0byBB
c3BlZWRTb0NTdGF0ZS4NCj4gDQo+IEkgdGhpbmsgdGhpcyBjYW4gYmUgbWVyZ2VkIGluIHRoZSBm
b2xsb3dpbmcgcGF0Y2guDQoNClRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24gYW5kIHJldmlldy4N
CldpbGwgZG8uDQoNCj4gDQo+IFRoYW5rcw0KPiANCj4gQy4NCj4gDQo+IA0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0t
DQo+ID4gICBpbmNsdWRlL2h3L2FybS9hc3BlZWRfc29jLmggfCAzICsrKw0KPiA+ICAgMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
aHcvYXJtL2FzcGVlZF9zb2MuaCBiL2luY2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2MuaA0KPiA+IGlu
ZGV4IGNkNjhjN2YxY2EuLjJlNzk4N2Y5ZGMgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9ody9h
cm0vYXNwZWVkX3NvYy5oDQo+ID4gKysrIGIvaW5jbHVkZS9ody9hcm0vYXNwZWVkX3NvYy5oDQo+
ID4gQEAgLTI1LDYgKzI1LDcgQEANCj4gPiAgICNpbmNsdWRlICJody9pMmMvYXNwZWVkX2kyYy5o
Ig0KPiA+ICAgI2luY2x1ZGUgImh3L2kzYy9hc3BlZWRfaTNjLmgiDQo+ID4gICAjaW5jbHVkZSAi
aHcvc3NpL2FzcGVlZF9zbWMuaCINCj4gPiArI2luY2x1ZGUgImh3L21pc2MvYXNwZWVkX2Fjcnku
aCINCj4gPiAgICNpbmNsdWRlICJody9taXNjL2FzcGVlZF9oYWNlLmgiDQo+ID4gICAjaW5jbHVk
ZSAiaHcvbWlzYy9hc3BlZWRfc2JjLmgiDQo+ID4gICAjaW5jbHVkZSAiaHcvbWlzYy9hc3BlZWRf
c2xpLmgiDQo+ID4gQEAgLTgxLDYgKzgyLDcgQEAgc3RydWN0IEFzcGVlZFNvQ1N0YXRlIHsNCj4g
PiAgICAgICBBc3BlZWRTQ1VTdGF0ZSBzY3U7DQo+ID4gICAgICAgQXNwZWVkU0NVU3RhdGUgc2N1
aW87DQo+ID4gICAgICAgQXNwZWVkSEFDRVN0YXRlIGhhY2U7DQo+ID4gKyAgICBBc3BlZWRBQ1JZ
U3RhdGUgYWNyeTsNCj4gPiAgICAgICBBc3BlZWRYRE1BU3RhdGUgeGRtYTsNCj4gPiAgICAgICBB
c3BlZWRBRENTdGF0ZSBhZGM7DQo+ID4gICAgICAgQXNwZWVkU01DU3RhdGUgZm1jOw0KPiA+IEBA
IC0yNzAsNiArMjcyLDcgQEAgZW51bSB7DQo+ID4gICAgICAgQVNQRUVEX0RFVl9FTU1DLA0KPiA+
ICAgICAgIEFTUEVFRF9ERVZfS0NTLA0KPiA+ICAgICAgIEFTUEVFRF9ERVZfSEFDRSwNCj4gPiAr
ICAgIEFTUEVFRF9ERVZfQUNSWSwNCj4gPiAgICAgICBBU1BFRURfREVWX0RQTUNVLA0KPiA+ICAg
ICAgIEFTUEVFRF9ERVZfRFAsDQo+ID4gICAgICAgQVNQRUVEX0RFVl9JM0MsDQoNCg==

