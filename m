Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5E1CD37B5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 09:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMN91-0002eU-81; Mon, 11 May 2026 05:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wMN81-00023d-NS; Mon, 11 May 2026 05:40:46 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wMN7z-0001RA-MO; Mon, 11 May 2026 05:40:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWP3Y0xGTSCxH6V3VNbficMeofBSfwBVOv01fuLoCfOPjx846csxkbEg+FO7CpvNOAzRFBza9CcudG55m9/X2vmqg4Iujwc2hEY/LC3pJJELCy7uLl90MHe9gKevxhu2hpG9UGTPNvLBu4wB0lhxiGZDJkvhi32uWHJ8ApoF6tTPmaFR8dnulveJ0phEQkMIwWlViT4SGRR34t6AMi8BGwCMR/3fMxZ2s9ibvQAQz1M1i7X0pJDK2rioLgX4QfDmy4R9Mu0dmAGjL5xbuvFZpRq6bkCR/YmvntOQ59Gr/kTPQJNCDUfLwKA5uW3neK09RH64VDVLv5h4VOhhfJQPYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBjW1oJhftg8bgEbtsan9gmAdg3hteb6BLqkqe4Tq94=;
 b=IN6FFEbRFum5G6oz52/r0nw0gT9eMgnKlVjvv94ALfIR0GfxH2glryQ1vCbe2HKi1Ww1GbhmpOtGvdgKiG/+jI8wE+X6bXfOPQGRJP1zd4Fp/ntUEb/d71TPrCQ5RFyhQgpS3yfIOd5xn9vBicOGA4fr1x2CrtYbZMaIAsAORbhvkobzyQfUcxxojxh29j4L7TeUfjGA2rpQQ18tqAITjYIDjJAsqcasJbFYO9KxJI+eEp2UJFt/R6YRkgOXerpsph+YFGZGpPwy23tnuNQdjIDjqflPT/7tUu3JeZXMS5P5vJofA6EP6TDQ6PpofIV/q4SkAl0KTOWQtA2PDM+WFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBjW1oJhftg8bgEbtsan9gmAdg3hteb6BLqkqe4Tq94=;
 b=IjEoFhChBea0m0YWN5MHG1KvZi0glRnQOOVC30hQPLICQ+P7gJLTnOBEpg08a/ZlNpEgoUO4n4Bh7Co65+fvtLOUskhCV2RjdxmXl3UC2bZgglGA9O3h7g0Yug+fVYMrjw/6gcCslN3cCV4I8lgL4WTHBNEq7UV9N6t3qEKbnGUk+kPBn0oU1gb4JuaergnbLGKHyPDFhcgLolG9ngbSWlwr5LFZIEJ3TxxWFtEawAujQJShSu3WIJZiytgblqb1WNYkQQQT2DmU2l26UVQwVEO2OukFein5DhRhhBVj/fGs9M2x/21+i18vDBS76uuuYsZEVwd58VkRiOlXblA8aQ==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by DB5PR09MB8695.eurprd09.prod.outlook.com (2603:10a6:10:64a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Mon, 11 May
 2026 08:38:31 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 08:38:30 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v9 5/7] target/riscv: Fix page table walk endianness for
 big-endian harts
Thread-Topic: [PATCH v9 5/7] target/riscv: Fix page table walk endianness for
 big-endian harts
Thread-Index: AQHc4SGK0JUQ/DW2t0itnij4kostKg==
Date: Mon, 11 May 2026 08:38:29 +0000
Message-ID: <20260511083819.206216-6-djordje.todorovic@htecgroup.com>
References: <20260511083819.206216-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260511083819.206216-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA2PR09MB7634:EE_|DB5PR09MB8695:EE_
x-ms-office365-filtering-correlation-id: 0f0e71a8-0d88-4262-adc0-08deaf38ae39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|3023799003|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: YMn+Eewy2ZAQDcG2MHDZZCx+C6sdXbjSty4DAEKZ3OOU60ivo7zebMZw8dhFVpTdd5WkoJmh9mOP+VbPA7mxfCzvcf8SrhGjEXRb99TeQEl8P1Hi7vx1vZg2Hl+lXkgMDapYEKewhoBNk6V715L9r8K+YkWURjtru6aIY0wOHUBErsNEC/thNgpWqJPLrm3rM4DVv1d2HLpqJ/kpZZVHSqxlTLovm2oVpY7Ts6ZKcOJoIBQwCv1tXaae/ebcYw8bpMK0Q8n7JgsAYoc1LM2jVekAsKh1WfQ+4MQ0d1n7PJ8d8qu60GvQajjqIjX4DIR34Up2giUxr/F49fXmtmaSZo8i/Me+Q0cAkoaN0aGmHuYoMiuZRvRTsZBIyp2kUEFEkurvvXb371oZI4fcKG6fwZYkytmZX9hZo3WW5mheuPAYfPfEDb4OH6+s4p1/5/ioTYErLZSlIeTnRkpAxxD20H5oJF+6D24AO9VTCO2lKnRMOhnKtBuOPCJtdm1vkt1gR2fLBY9besk+UP9ls62kTs5oUmZSDRs1/4E48vvozM8HqKLygxaJRyQw9ICYkrPp1S3yn4zAnTHp44FNMG2dWEv+FopcMXBiuQjcmNCYgbfahMCgzaiCsYw3OlQezD0lm7WUCserBlAwXx2rM5BLZaILzQ8TV0rRL0PIBOYbl7C0C4HifnTl0zAeL8lRKqv83DWvGpo5fiUjnsNaPN6PzlptA1sKbIXD0ZK6sShSRpNibGC8lvDxUG84+dkbTYRG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(3023799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDNOd0pERGxjM2hWeXhkZ01iRDlTZ3NyY2tNTWc1Wm9pNExMVTFPdGpoYVJG?=
 =?utf-8?B?KytudytGZ0hoVWpFbFAxRTNaeVQzUFNwdkF1MjEvMTNMYWs2TjUrblIrVHc2?=
 =?utf-8?B?Rmg0azlOY1lMQkttQTVVS2x4R1c2T1JOUnNqWER0VmlwaVRlREdZekRQdVVV?=
 =?utf-8?B?NDZqM1ZKSE5FQ2d4aFB5aE5qbUhVQzRIaWkvSG1aS3EzUndPUnNKb2RLbVBn?=
 =?utf-8?B?ck5jc0tLTXdIVlZxSkhUUkIxbHlFMDB6dlBSemN3VGZyMjdpK3dsSkNReDlx?=
 =?utf-8?B?NlpUZ3hmOUdWYnFCZG1vZTdOb3RuUW4zWHB1RWE1L0hVY1lCcks1bGIyVk9a?=
 =?utf-8?B?WklYRlE2d3RwZXRPd2lJOUY5UHRtN1NTaGY4cXM5K2tia2dJZ0Y4ZUNSMXdZ?=
 =?utf-8?B?VWtXc01IZEE5Sk1KbHJ2NkEzVXNZRVB0L1M3MDRPTWZkQUR6RDYrWXVrcElm?=
 =?utf-8?B?VWloMy80cjFGZjhuRVZUamdjMENtQmxTeUJNSWNoN1c0d1lNSnZEc0wxaWdM?=
 =?utf-8?B?YWk3TXVPUWRzV05JeTNIM1pnQ2pBWDhRajF3dk9pZDBCSzR4T2prSksvM0ZO?=
 =?utf-8?B?aERRdzNzbHBmakZZZ3JpQVdWSHE4OGJWU3NZUUh0L2F1L0tFcXVCRTcrKzAz?=
 =?utf-8?B?dlZPWklBaWVyR3AxSTB5eHA4SDlDOHRFNjlTNldEbHBZZFRxbUlBdUErTnFl?=
 =?utf-8?B?NE5nbkdLMzdCeVFVU3NlcURaaXpuaGtrNnRmeStoa3JiS25LZno5TjJVYkJq?=
 =?utf-8?B?RUtzZkJXUC84d09Gd01mL3hmNWhJMzNLQ3dtZ2VkaWRsNDQzQ2VhMWYxRjkw?=
 =?utf-8?B?ZnlsNmV1amFjU2o1R3hXTlBlWFpvSlBQR1Z6T1N5OFZKUXRBOE13bS9hY3Y3?=
 =?utf-8?B?bUxOd2Y2R0pCNzBFZ3QwbTR1UnhyN2ZiM3NpWFE2QWh0aS9rQUlmNCs1S2g0?=
 =?utf-8?B?TUlCUlJ6bThXMlNNS1RNSXdMUWc3bk9mK0JIZldqcWxpTkxnQXcyR3RDN2VN?=
 =?utf-8?B?ZHpXOXpqZmdTZThFd21ZV0ZPU04xenIzenE0QkpEelF4ZCthMmtsVWp4VDBa?=
 =?utf-8?B?Q1ZPL1RmTzRhbDhJSXNoQ0JPc01jcmozd2xrT2NQejlqalFVbVlWaEVmQlVr?=
 =?utf-8?B?cmRZWGZCelhLOXhBOHRQcDl6RWxOczJsNDRXUU94NHhGdmpjWXNXN2wrRGdD?=
 =?utf-8?B?N2ZWalQrRHo5L2NIK3ZHRWlvM2NndmIvd0EvQkJCRU90YmNCaVF3ejFGVHdJ?=
 =?utf-8?B?QlVFcXdqS3BwcnRCVXB4TUJudU9RN1NvdEtkQUZKOTFqMWZLRjdTVThnVlBD?=
 =?utf-8?B?SXJ6TXIzMGxHZXpPamhKaDhvM0JmY1VCUThqZUlZbEFGeG5BYTFQVW1Zc250?=
 =?utf-8?B?QUNzR3VqRzhRTVZwSStvRjU3MUxBNnpOcGZVYzQxLzdoWnJOQjhwbVlwSG0z?=
 =?utf-8?B?SEdDYisram96L1JpYktpMk5EVE1EVU81ZmlaR0E2c2N2MXlpMjJrTHlibSti?=
 =?utf-8?B?emY2Mm9DcnE0bThzNGNkVUNxV3B0cnUvdGFra1Jyby9CdHZuMVY5cDZTTTUx?=
 =?utf-8?B?cFIrUnQ0VWdkSjFweFlITGNBQXQ5WThjT2tCaVZrSEFoclpBL2M0SzBob3k4?=
 =?utf-8?B?SjU3TW9yYmVxTklVN3NSQVhPUHVrS1dFZUFCOVRhVjZXT2JsN0RaMWpZWVdy?=
 =?utf-8?B?eGRPNGlKeHUyK2hpN3Z2c0d2YytBVStrblJOWHoyL1pnZzE5V09wL3kwejMy?=
 =?utf-8?B?Qkx4YlJEeElnb0NtN3pPQlRLMndjSFp4WStKOEhuVkFyQzJmbGhuOTZKYkRv?=
 =?utf-8?B?dkRLOWx0VUh2L1FoUGEwWDhjVkpBNTYxODE3bVI5YnNPRUxkcVl5blFjVHdG?=
 =?utf-8?B?MXhmbGZUNHRWbEM5cWhoSHVHTG16Zmtmem03czJiZ1ZzWVNkazl6dXcyV2hv?=
 =?utf-8?B?YmhwNExVR2xBYzZmUERsSUFRaUptYWZIUEsyUnpEditsMGdzVksza1lCdGg2?=
 =?utf-8?B?clF5QmlRcUlLdVNMZXllYWZrOTZPUXBLVDc5dnphTlNLa2FTOTdRNXlnbVNY?=
 =?utf-8?B?dGVDSXJDNWZxNnRDNWdXcy9Zdm1hR1NMbEdvSVBVb1VoZXF4aC9jell3YnN2?=
 =?utf-8?B?YkpoQWZROVEyNCtsUUF2QWZGdTNyNGhYajRSNXVraTZkVElYUTNhQ0o4RHE4?=
 =?utf-8?B?UDBSeW9DQy9paXlLK2hLeiswZ0NKdHdhK2srYkJBK2plVWs0QklVTXVLZ3pv?=
 =?utf-8?B?R2wrbkpTS3FiM1BiQWg2dVl6WlBSb240M21OVlZsRlJjUlVmZHdMWkJTMHRV?=
 =?utf-8?B?eU1qVjZJZmRnZ0RMQXp1RjdtRXBCTlFzemVoNHAweGF4T3hqNEdhVXoreGVw?=
 =?utf-8?Q?tfuUehhJ+uBJHPPMNORBVZzE3hKQmOvarBkbL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <931636DC2DDB29449A217E5CA134F7BA@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0e71a8-0d88-4262-adc0-08deaf38ae39
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 08:38:29.0479 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UoZ+TFW0x/25n0La3JnGOX+s5sCG9Bixw7/lUE/BrWV8OmAvmqS1hRoMax1Rnt9l39LMws4R3rGGnUBA7dlTPgiPAyTxgi2/wRzaddiTAFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR09MB8695
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

VGhlIHBhZ2UgdGFibGUgd2Fsa2VyIHJlYWRzIFBURXMgdXNpbmcgYWRkcmVzc19zcGFjZV9sZGwv
bGRxIHdoaWNoIHVzZQ0KY29tcGlsZS10aW1lIG5hdGl2ZSBlbmRpYW5uZXNzIChhbHdheXMgTEUg
Zm9yIFJJU0MtVikuIEhvd2V2ZXIsIHdoZW4gYQ0KYmlnLWVuZGlhbiBrZXJuZWwgd3JpdGVzIFBU
RXMgdmlhIG5vcm1hbCBzdG9yZSBpbnN0cnVjdGlvbnMsIHRoZXkgYXJlDQpzdG9yZWQgaW4gYmln
LWVuZGlhbiBieXRlIG9yZGVyLiBUaGUgd2Fsa2VyIHRoZW4gbWlzaW50ZXJwcmV0cyB0aGUgUFRF
DQp2YWx1ZXMsIGNhdXNpbmcgcGFnZSBmYXVsdHMgYW5kIGEgaGFuZyB3aGVuIHRoZSBrZXJuZWwg
ZW5hYmxlcyB0aGUgTU1VLg0KDQpUaGUgUklTQy1WIHByaXZpbGVnZWQgc3BlY2lmaWNhdGlvbiBz
dGF0ZXMgdGhhdCBpbXBsaWNpdCBkYXRhIG1lbW9yeQ0KYWNjZXNzZXMgdG8gc3VwZXJ2aXNvci1s
ZXZlbCBtZW1vcnkgbWFuYWdlbWVudCBkYXRhIHN0cnVjdHVyZXMgZm9sbG93DQp0aGUgaGFydCdz
IGVuZGlhbm5lc3Mgc2V0dGluZyAoTVNUQVRVUyBTQkUvTUJFIGJpdHMpLg0KDQpGaXggYm90aCBQ
VEUgcmVhZHMgYW5kIGF0b21pYyBBL0QgYml0IHVwZGF0ZXMgdG8gdXNlIHRoZSBleHBsaWNpdCBf
bGUNCm9yIF9iZSBtZW1vcnkgYWNjZXNzIHZhcmlhbnRzIGJhc2VkIG9uIHRoZSBoYXJ0J3MgcnVu
dGltZSBlbmRpYW5uZXNzLg0KDQpTaWduZWQtb2ZmLWJ5OiBEam9yZGplIFRvZG9yb3ZpYyA8ZGpv
cmRqZS50b2Rvcm92aWNAaHRlY2dyb3VwLmNvbT4NClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRo
aWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQotLS0NCiB0YXJnZXQvcmlzY3YvY3B1X2hl
bHBlci5jIHwgMjggKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAyMiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L3Jpc2N2L2NwdV9oZWxwZXIuYyBiL3RhcmdldC9yaXNjdi9jcHVfaGVscGVyLmMNCmluZGV4IDM5
YzM0ODZhZTAuLjQ4NTliOGRkNWMgMTAwNjQ0DQotLS0gYS90YXJnZXQvcmlzY3YvY3B1X2hlbHBl
ci5jDQorKysgYi90YXJnZXQvcmlzY3YvY3B1X2hlbHBlci5jDQpAQCAtMTQxOCw5ICsxNDE4LDEz
IEBAIHN0YXRpYyBpbnQgZ2V0X3BoeXNpY2FsX2FkZHJlc3MoQ1BVUklTQ1ZTdGF0ZSAqZW52LCBo
d2FkZHIgKnBoeXNpY2FsLA0KICAgICAgICAgfQ0KIA0KICAgICAgICAgaWYgKHJpc2N2X2NwdV9t
eGwoZW52KSA9PSBNWExfUlYzMikgew0KLSAgICAgICAgICAgIHB0ZSA9IGFkZHJlc3Nfc3BhY2Vf
bGRsX2xlKGNzLT5hcywgcHRlX2FkZHIsIGF0dHJzLCAmcmVzKTsNCisgICAgICAgICAgICBwdGUg
PSByaXNjdl9jcHVfZGF0YV9pc19iaWdfZW5kaWFuKGVudikNCisgICAgICAgICAgICAgICAgPyBh
ZGRyZXNzX3NwYWNlX2xkbF9iZShjcy0+YXMsIHB0ZV9hZGRyLCBhdHRycywgJnJlcykNCisgICAg
ICAgICAgICAgICAgOiBhZGRyZXNzX3NwYWNlX2xkbF9sZShjcy0+YXMsIHB0ZV9hZGRyLCBhdHRy
cywgJnJlcyk7DQogICAgICAgICB9IGVsc2Ugew0KLSAgICAgICAgICAgIHB0ZSA9IGFkZHJlc3Nf
c3BhY2VfbGRxX2xlKGNzLT5hcywgcHRlX2FkZHIsIGF0dHJzLCAmcmVzKTsNCisgICAgICAgICAg
ICBwdGUgPSByaXNjdl9jcHVfZGF0YV9pc19iaWdfZW5kaWFuKGVudikNCisgICAgICAgICAgICAg
ICAgPyBhZGRyZXNzX3NwYWNlX2xkcV9iZShjcy0+YXMsIHB0ZV9hZGRyLCBhdHRycywgJnJlcykN
CisgICAgICAgICAgICAgICAgOiBhZGRyZXNzX3NwYWNlX2xkcV9sZShjcy0+YXMsIHB0ZV9hZGRy
LCBhdHRycywgJnJlcyk7DQogICAgICAgICB9DQogDQogICAgICAgICBpZiAocmVzICE9IE1FTVRY
X09LKSB7DQpAQCAtMTYxOSwxMiArMTYyMywyNCBAQCBzdGF0aWMgaW50IGdldF9waHlzaWNhbF9h
ZGRyZXNzKENQVVJJU0NWU3RhdGUgKmVudiwgaHdhZGRyICpwaHlzaWNhbCwNCiAgICAgICAgIGlm
IChtZW1vcnlfcmVnaW9uX2lzX3JhbShtcikpIHsNCiAgICAgICAgICAgICB0YXJnZXRfdWxvbmcg
KnB0ZV9wYSA9IHFlbXVfbWFwX3JhbV9wdHIobXItPnJhbV9ibG9jaywgYWRkcjEpOw0KICAgICAg
ICAgICAgIHRhcmdldF91bG9uZyBvbGRfcHRlOw0KKyAgICAgICAgICAgIGJvb2wgYmUgPSByaXNj
dl9jcHVfZGF0YV9pc19iaWdfZW5kaWFuKGVudik7DQogICAgICAgICAgICAgaWYgKHJpc2N2X2Nw
dV9zeGwoZW52KSA9PSBNWExfUlYzMikgew0KLSAgICAgICAgICAgICAgICBvbGRfcHRlID0gcWF0
b21pY19jbXB4Y2hnKCh1aW50MzJfdCAqKXB0ZV9wYSwgY3B1X3RvX2xlMzIocHRlKSwgY3B1X3Rv
X2xlMzIodXBkYXRlZF9wdGUpKTsNCi0gICAgICAgICAgICAgICAgb2xkX3B0ZSA9IGxlMzJfdG9f
Y3B1KG9sZF9wdGUpOw0KKyAgICAgICAgICAgICAgICB1aW50MzJfdCBjbXAgPSBiZSA/IGNwdV90
b19iZTMyKHB0ZSkNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOiBjcHVfdG9f
bGUzMihwdGUpOw0KKyAgICAgICAgICAgICAgICB1aW50MzJfdCB2YWwgPSBiZSA/IGNwdV90b19i
ZTMyKHVwZGF0ZWRfcHRlKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA6IGNw
dV90b19sZTMyKHVwZGF0ZWRfcHRlKTsNCisgICAgICAgICAgICAgICAgb2xkX3B0ZSA9IHFhdG9t
aWNfY21weGNoZygodWludDMyX3QgKilwdGVfcGEsDQorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgY21wLCB2YWwpOw0KKyAgICAgICAgICAgICAgICBvbGRfcHRlID0g
YmUgPyBiZTMyX3RvX2NwdShvbGRfcHRlKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
OiBsZTMyX3RvX2NwdShvbGRfcHRlKTsNCiAgICAgICAgICAgICB9IGVsc2Ugew0KLSAgICAgICAg
ICAgICAgICBvbGRfcHRlID0gcWF0b21pY19jbXB4Y2hnKHB0ZV9wYSwgY3B1X3RvX2xlNjQocHRl
KSwgY3B1X3RvX2xlNjQodXBkYXRlZF9wdGUpKTsNCi0gICAgICAgICAgICAgICAgb2xkX3B0ZSA9
IGxlNjRfdG9fY3B1KG9sZF9wdGUpOw0KKyAgICAgICAgICAgICAgICB0YXJnZXRfdWxvbmcgY21w
ID0gYmUgPyBjcHVfdG9fYmU2NChwdGUpDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICA6IGNwdV90b19sZTY0KHB0ZSk7DQorICAgICAgICAgICAgICAgIHRhcmdldF91bG9u
ZyB2YWwgPSBiZSA/IGNwdV90b19iZTY0KHVwZGF0ZWRfcHRlKQ0KKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgOiBjcHVfdG9fbGU2NCh1cGRhdGVkX3B0ZSk7DQorICAgICAg
ICAgICAgICAgIG9sZF9wdGUgPSBxYXRvbWljX2NtcHhjaGcocHRlX3BhLCBjbXAsIHZhbCk7DQor
ICAgICAgICAgICAgICAgIG9sZF9wdGUgPSBiZSA/IGJlNjRfdG9fY3B1KG9sZF9wdGUpDQorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICA6IGxlNjRfdG9fY3B1KG9sZF9wdGUpOw0KICAgICAg
ICAgICAgIH0NCiAgICAgICAgICAgICBpZiAob2xkX3B0ZSAhPSBwdGUpIHsNCiAgICAgICAgICAg
ICAgICAgZ290byByZXN0YXJ0Ow0KLS0gDQoyLjM0LjENCg==

