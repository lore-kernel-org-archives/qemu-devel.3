Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB03F43688
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDfuC-0001bo-RU; Fri, 17 Apr 2026 05:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDfuB-0001bS-FM; Fri, 17 Apr 2026 05:54:31 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDfu9-0001IL-LD; Fri, 17 Apr 2026 05:54:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ittj8XPngAIqcKn0EH+XXWZhxUzAvmk1vLtVSD/LSSbHn3cSteq6RSC2rIHO2Q43+gHtNORsaW8Wp8GN+Wkr4jzLxy+i3yS0OBLYjiWFpVp09G/pa9KubSmkvkJ2XuqfnD7kimQzROjYYgp6d3E0Y0hZcO4t1un1BXfqOghXc57dBaako6wUkEYSQF6L1AWrz9qRftBVXbTEsBe33KJwmckPJQGyZFKRFwVr819H/b1Kz4nFH/iSHsDk0MuhQH57ujFUFldJATk3ZRP+bXE1e391wWpmQokCVPYf2k1QcAPUCZvNsWcS3dVV2d7dX/qCWAdgDdP3pjr+46KnG32hhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d45+ip3TENAZ4Ly1+p0dqk4sbcpDL6IPd2FqncQWiM0=;
 b=itZLfv7+wUzi3mGeymYSmhlkVdedt3gDspQW/BxRnbMFtrJc0Zfprcmu8vPPQL30taQ7RrcHSYPLF6sbT3hyR6RWHzai5O+g7Coq7XVQ4ha1xrivYx1uOsc7OY4fQ1DmsXLA+qJp33pe/CMZCQa2gsZqSHiKGzMi/Qa+vVwl3HheNY2msB2eIB6wW/vCCqsDeo6ugpJ36iImcZknwKQ79wuyIaoVXVnvJ1qWUtDHTboAXUchm4oql+4xsvILo0CepDfRx8J1K/nnWfWGEEb6sMyfMfA854cLCLUEuCPAoCqVRkV+IGTFTc3l6yYcZy2CDeIM/ZjK5RPkFlfrcU5Y4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d45+ip3TENAZ4Ly1+p0dqk4sbcpDL6IPd2FqncQWiM0=;
 b=VhJBbbkd7iGSHylzWcU8+92tsjoOFzAG7z8qXo+BZSPnFLwo0Y0eN3ehESdmZDivzxDly16ylDteS3szx0sTtxBOrtO9MPTnKcx3lC4EX/HzU/Y8meDBezgp5PYUwmuSNmkXMYR/Z7sPTaw65Av9nVBn5tT4JmH4MVtFDy8S5WdbOOkOuOEzniYJ6US0V/u4ePDnbXVlPqfUHm0kuUvqy1f7tlWLsbMDYLCBk4QiUTWVExsRbFlDj9Dv7kJEt0ojWQvL+sdmI/mJ2QmrH8HXQr7AnYXbWjbIFxN/NsHQ6smX/xXwvd21F9igl4TKzHqvUIbvLHFS1zLtjf2iZyIW3A==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by GVXPR09MB6976.eurprd09.prod.outlook.com (2603:10a6:150:1bc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Fri, 17 Apr
 2026 09:54:16 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 09:54:15 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: Alistair Francis <alistair23@gmail.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com"
 <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "thuth@redhat.com"
 <thuth@redhat.com>, Chao Liu <chao.liu.zevorn@gmail.com>
Subject: Re: [PATCH v6 2/7] target/riscv: Add big-endian CPU property
Thread-Topic: [PATCH v6 2/7] target/riscv: Add big-endian CPU property
Thread-Index: AQHcxdz7upla7z38V0m76mmMu7gfv7XTpuqAgAJ4ToCAABGbAIAAA2kAgAzgMoA=
Date: Fri, 17 Apr 2026 09:54:15 +0000
Message-ID: <ed6e6e5c-3cb9-4cf1-a773-e3cbe77a4552@htecgroup.com>
References: <20260406154935.144674-1-djordje.todorovic@htecgroup.com>
 <20260406154935.144674-3-djordje.todorovic@htecgroup.com>
 <884193da-0078-44f0-804d-e5ccaf5f3398@linaro.org>
 <CAKmqyKPZRQ6djtJU2w5y=5i6Bt3Nkr7yOe+K0vnj-m_XKvG=Kg@mail.gmail.com>
 <55bf85d3-3b62-4dab-9b21-ec1ca193dd15@linaro.org>
 <CAKmqyKN=pn997tWzN+-7rFT5ksN6hq7ae3nLW2yDczcCqCWhnw@mail.gmail.com>
In-Reply-To: <CAKmqyKN=pn997tWzN+-7rFT5ksN6hq7ae3nLW2yDczcCqCWhnw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA2PR09MB7634:EE_|GVXPR09MB6976:EE_
x-ms-office365-filtering-correlation-id: ba2e05de-609b-43cf-b45f-08de9c674935
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: DbU3jCUzVY5ZhjH1Cx2Iq+GUvgRBgPmJb7iwQf8vguHZBToTAV1VcZ2J0cfX/APjXUqVYOfu+bpmX7a/9oPPqfWFLBr8mfGZENuwkICRGS2Ay12liJ/sD8ISb7oBFsHu6QdLdR2Lqu2CgG0RNc39FIbP1YgjSoYVZkduD/y8SV8ECzYH3rLndWYlTSZBPHRJ1IEMlzMabQDMxV4svsWxXB4msLhsshH6UIRn/fpfP4L6MQFh8x1BOvCQIwZWrdLiIxVvBsHfKGpwTX0Ojx5R0nnJgnWY35EDp9uQMds742+RBGYNPKBosdSW43qtSzPek4wALECEdTAz8JXRX7b7YUsQdah3mqOTayPIpCzYGc43zHkYuN+tjpM4yZGX6qlFc2/DVoPTr9dHJn9r15zPtEl7vOr72xNndgeanWysiUGqV8rFNKPvIL5d9Tx4cUA+strHgqwny+RIz9ExybvgWubboghUG+qRR6J31KzkYXQLHLKd7wVgmJQEUphwTZC5f06oSC/eQgOLadgGPA4V3ZwqBmzgjbSfOEsvBCRPsgFyVq6+AjdI5ZTp9idfCi91EPqvrP5UFgvCxK94cXehFvl65RKVnfF260Y5lVKRQffV5hNHqcqWF2jd+kCMnocB45cHeKPtAzrHtFEweIUVjJLqcLmfIC1/ikvM+6eDwIDxyjLm5SGS8QGcFJWCZiwbjGIacxvNXvmIzGpQLqONHw9LcphqGz9+6iE6pIrGJa4rimfjOPwaGGrPQnBCHantcjWekUCzpx7m5p8uDbWCPcZbVyNVrVL+sf+r9QoqeZ8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGpkOE04ZVNvWDcyNVJZa2JUaDd1cWZRWHZVVHVJNitBTkNDOG5Cak9PY2NJ?=
 =?utf-8?B?eWZsN0NSMFFPdmRKVGJFZXorYVpFZEtIcGk3dmk0YkpRZlJEUDFEaGRBSGE1?=
 =?utf-8?B?OTdyMWpFTDJ4ek1OSkNhcXE3aFpnVWEwOTZMQmVzTGp0UlBXQlF1YVBsa2RU?=
 =?utf-8?B?aG9veFdhMUhBS0E3aFVQSlhNWTNvQzBML2VkRjFuM2tIbE9iTDQzSTU2VVI1?=
 =?utf-8?B?SE9HNEYxM01lYXloS0g4STNwc3dabnBhTlN5Mkd6UVNYeGlKTDNnT2UrWTJl?=
 =?utf-8?B?SGduRkFlV0xnalZWSVlnek95U1lXVlFYVVNVWkJwS1V6amZubjZmOHA0dGFs?=
 =?utf-8?B?ZjJWU2pjNFVvRi9iZGVOejlGa3djbDZDNVkvczN1SkV4VWlEVUEzejQrMC9P?=
 =?utf-8?B?US93RDFDRWpEeVd2bmJjNFArd0FHRE5MU08rNUVrNWVvT2JTTGQwSUtnYXA3?=
 =?utf-8?B?YUhHdEdIUVR3Q0lhT2VnODBtSzBRcVA0a2hVZWVwakkzL1NoMDBhaW1pVlpx?=
 =?utf-8?B?MWwzQ1BvekkrcE1YcnRuZzZpYm8wM09TazRNU1BwRDZUMm1JeEg3UTBybEs0?=
 =?utf-8?B?VVJoNXNNVXJ6NDgrdmhYcFU5czIrYnlxQlRreE9PazdQSTEwTEZUaDBtb1lv?=
 =?utf-8?B?a0orWVNOQ2s0SEI1NzhKSWR3b0NZYXdLcStYZDFvMUdnK29wekptaDVXZEZi?=
 =?utf-8?B?eWZ6clZkTXNxcjVkQnI0cTViVC8vUUtOSENZbGp2RjVOaXV4VTd5cW1lNUtn?=
 =?utf-8?B?MGZLenovemZDRmdJN3NndmlPaDJTYlpicFd2U1NCOUdVYVU5N0pUaXNzaVc4?=
 =?utf-8?B?Zi9RcHpKbmQwS1puVjlUSUl1NkxOcm5CTjhaV3I2eWVsb1hQbDNrMHFVR3pF?=
 =?utf-8?B?eExYemNRWVRTbXZQa1NCcnlSUUl6T2lBMWpKaEtPT3crNzBSYmdVd29aeWdh?=
 =?utf-8?B?T21veVhhQjZpVTczYk5SVmNhUVNZeldBL2c0MXlhZER2Yy94VkNMRWpUa1Bz?=
 =?utf-8?B?VVk0citIZnJFVHMrUzkraTVJamUwN0U1bXJuajhyVVltbnFDWmR3N1ptR2pM?=
 =?utf-8?B?RGZiZlZ2SGtvUitLNzY0RlNyU2h6bEc3WmpjeXZ1YzNOQm5qTUF0Y2ZiUDg0?=
 =?utf-8?B?SkU4dStLajNoeGxjMmZ5c0RmdzZIb09ZL2FvOGd5S1FwQUVUbEtuNy9YNWNk?=
 =?utf-8?B?SDZtcVp3RU53dGJwNVlVRDAwemRRaTNkWEdPOStkRWJhb0ZYN25qVTFWT1pm?=
 =?utf-8?B?SzVYOXBlbzVCa25wVk9mcCtaU0JUbk52MkNrU3NUQlJhckNVWGxzWkJRUlhP?=
 =?utf-8?B?YWtyN3dpRi9pc2NsQTJmUEtkT0JLVEQ2cDZjZFBLL1BRWkxFZXBydDBFdU1J?=
 =?utf-8?B?T3BNV1FXek5PQ0dmRHVGUytJY1huL3FRMXVkUm45YnRiNGYwdmFSWWJTUU9R?=
 =?utf-8?B?ekNjTFAzaVMzYjg0ZVpFdE83WlJzRFYvS2ZjeVIvMkdLM3FuT2dQd0NFQnJB?=
 =?utf-8?B?ZEFhdXZ5OG4yUHBITGo4TTRwOVRPa01odVRaT2tmNXFKaUtXcTE0SEw3VWVu?=
 =?utf-8?B?WGpEa3lMckdwU0lBWTRpbTVTdnNqOXRwVEFaalE0dzVKZEU3SENZN05ZNXdr?=
 =?utf-8?B?Y0dhVjk5VEFmS0UvVERKbERvblI1MW5UTkxBMVptZThkdzRTRTN5WDBVQjJM?=
 =?utf-8?B?YXl6WjRnWmVyay93MzI0NE1TcithYTgrcTRPU20yZjduS0QxM2pnTldOaGdF?=
 =?utf-8?B?WmN0VlYvQXFpdVJkZUpaUExHM1FuTU5uRFk3aVJJL2M2R3NzSHN3SWpSU1M4?=
 =?utf-8?B?b013QVlGV2xQVnBSaGRjOHBRZjlwQnVjaWcxMjlCVTduaTFiNFVsUFFlU1Bv?=
 =?utf-8?B?MjhOVWNiQ0xGaEEwWC80bE4xWmlLaEozdlY4ckltTy9HRVkySzZ3UU5xRkJ2?=
 =?utf-8?B?SHJGbTRxZ3VyeDl6eUFRR3pyb1Z1WGx6WmdhY0tteDFVOXdMOXNhcW0rc0V0?=
 =?utf-8?B?R1Q3L29XbTFYcm01RVRzQWVEWFhCTm95UUN4Wi9VT3pBejB1WWlTcStUSUFy?=
 =?utf-8?B?dU9adWRzbkF5STEweGRaR0dQc3ZoZzRyMkxNSnk1Mzl0N09qUEdmYWRtTUF5?=
 =?utf-8?B?U1c1UU5YMGVVWTFoTm5uUVFEMTNxdmI5WnFUdldwMlJZemdzdTZxZ1N6VnFx?=
 =?utf-8?B?NVNGWk9xckdqNFhEQktnSGVuV1lrdWpLZVBSaHZtVThoYnp2NWdZdHQweC9V?=
 =?utf-8?B?YW5PVUg2ZEVLY3lCVE85NXR6S05IQy9pczhLZWlTdmhYelpzNG1zWWtXRFl0?=
 =?utf-8?B?WFNXNjQxV1hNWlVxV3ZjeDY0SEhQaWRJZEJoN1ZzQWNMRUZTbkc4N1lUSzRR?=
 =?utf-8?Q?KQDxJSWW5V4pqpmgX6Oac26fMBvNaqvL+5RBz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6A90B1ADB924640991F8685960E72E9@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2e05de-609b-43cf-b45f-08de9c674935
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 09:54:15.6676 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SyowLEktw12C3In38z661eoBEwxK3Ho74dpmEhaXuYWp11lywJD9VTHlMgxZ8fosO2GQqR/lsYFVdP4iYQ5s6B3fRmTSJfO8o7WX1w8fFsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR09MB6976
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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

DQpPbiA0LzkvMjYgMDc6MTYsIEFsaXN0YWlyIEZyYW5jaXMgd3JvdGU6DQo+IENBVVRJT046IFRo
aXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9yZ2FuaXphdGlvbi4gRG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUg
dGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPiBPbiBUaHUs
IEFwciA5LCAyMDI2IGF0IDM6MDTigK9QTSBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1k
QGxpbmFyby5vcmc+IHdyb3RlOg0KPj4gT24gOS80LzI2IDA2OjAwLCBBbGlzdGFpciBGcmFuY2lz
IHdyb3RlOg0KPj4+IE9uIFdlZCwgQXByIDgsIDIwMjYgYXQgMTI6MTfigK9BTSBQaGlsaXBwZSBN
YXRoaWV1LURhdWTDqQ0KPj4+IDxwaGlsbWRAbGluYXJvLm9yZz4gd3JvdGU6DQo+Pj4+IE9uIDYv
NC8yNiAxNzo0OSwgRGpvcmRqZSBUb2Rvcm92aWMgd3JvdGU6DQo+Pj4+PiBBZGQgYSAiYmlnLWVu
ZGlhbiIgYm9vbGVhbiBwcm9wZXJ0eSB0byB0aGUgUklTQy1WIENQVSBjb25maWd1cmF0aW9uLA0K
Pj4+Pj4gZGVmYXVsdGluZyB0byBmYWxzZSAobGl0dGxlLWVuZGlhbikuIFRoaXMgcHJvcGVydHkg
YWxsb3dzIG1hY2hpbmUNCj4+Pj4+IG1vZGVscyB0byBjb25maWd1cmUgaW5kaXZpZHVhbCBIQVJU
cyBmb3IgYmlnLWVuZGlhbiBkYXRhIG9wZXJhdGlvbi4NCj4+Pj4+DQo+Pj4+PiBUaGUgUklTQy1W
IElTQSBzdXBwb3J0cyBiaWctZW5kaWFuIGRhdGEgYWNjZXNzZXMgdmlhIHRoZSBtc3RhdHVzDQo+
Pj4+PiBTQkUvTUJFL1VCRSBiaXRzLCB3aGlsZSBpbnN0cnVjdGlvbnMgcmVtYWluIGFsd2F5cyBs
aXR0bGUtZW5kaWFuLg0KPj4+Pj4gVGhpcyBwcm9wZXJ0eSBwcm92aWRlcyB0aGUgY29uZmlndXJh
dGlvbiBpbnRlcmZhY2U7IHN1YnNlcXVlbnQNCj4+Pj4+IHBhdGNoZXMgd2lsbCBjb25uZWN0IGl0
IHRvIHRoZSBDUFUgc3RhdGUgYW5kIHRyYW5zbGF0aW9uIGxvZ2ljLg0KPj4+Pj4NCj4+Pj4+IFNp
Z25lZC1vZmYtYnk6IERqb3JkamUgVG9kb3JvdmljIDxkam9yZGplLnRvZG9yb3ZpY0BodGVjZ3Jv
dXAuY29tPg0KPj4+Pj4gUmV2aWV3ZWQtYnk6IENoYW8gTGl1IDxjaGFvLmxpdS56ZXZvcm5AZ21h
aWwuY29tPg0KPj4+Pj4gLS0tDQo+Pj4+PiAgICAgdGFyZ2V0L3Jpc2N2L2NwdS5jICAgICAgICAg
ICAgICAgIHwgMSArDQo+Pj4+PiAgICAgdGFyZ2V0L3Jpc2N2L2NwdV9jZmdfZmllbGRzLmguaW5j
IHwgMSArDQo+Pj4+PiAgICAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4+Pj4N
Cj4+Pj4+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvY3B1X2NmZ19maWVsZHMuaC5pbmMgYi90
YXJnZXQvcmlzY3YvY3B1X2NmZ19maWVsZHMuaC5pbmMNCj4+Pj4+IGluZGV4IDcwZWM2NTBhYmYu
LjUxNDM2ZGFhYmYgMTAwNjQ0DQo+Pj4+PiAtLS0gYS90YXJnZXQvcmlzY3YvY3B1X2NmZ19maWVs
ZHMuaC5pbmMNCj4+Pj4+ICsrKyBiL3RhcmdldC9yaXNjdi9jcHVfY2ZnX2ZpZWxkcy5oLmluYw0K
Pj4+Pj4gQEAgLTE1NCw2ICsxNTQsNyBAQCBCT09MX0ZJRUxEKGV4dF94bWlwc2Nib3ApDQo+Pj4+
PiAgICAgQk9PTF9GSUVMRChleHRfeG1pcHNjbW92KQ0KPj4+Pj4gICAgIEJPT0xfRklFTEQoZXh0
X3htaXBzbHNwKQ0KPj4+Pj4NCj4+Pj4+ICtCT09MX0ZJRUxEKGJpZ19lbmRpYW4pDQo+Pj4+IFNp
bmNlIGl0IGlzIHJ1bnRpbWUgaXQgZG9lc24ndCBiZWxvbmcgdG8gUklTQ1ZDUFVDb25maWcuDQo+
Pj4gSSB0aGluayB0aGUgaWRlYSBpcyB0aGF0IGEgdXNlciBjYW4gc2V0IHRoZSBgYmlnLWVuZGlh
bmAgcHJvcGVydHkNCj4+PiAoZnJvbSB0aGUgY29tbWFuZCBsaW5lIG9yIG1hY2hpbmUpIGFuZCB0
aGVuIE1CRSwgU0JFIGFuZCBVQkUgYXJlDQo+Pj4gYWx3YXlzIDEgYW5kIGJpZyBlbmRpYW4gaXMg
YWx3YXlzIGVuYWJsZWQuIEJhc2ljYWxseSB0byBtb2RlbA0KPj4+IGJpZy1lbmRpYW4gb25seSBo
YXJkd2FyZQ0KPj4+DQo+Pj4gU28gaW4gdGhhdCBjb250ZXh0IGl0IGlzbid0IHJ1bnRpbWUsIGJ1
dCBpdCdzIG5vdCBjbGVhciBmcm9tIHRoZQ0KPj4+IGNvbW1pdCBkZXNjcmlwdGlvbi4gQWxzbyBp
ZiB3ZSBhcmUgYWRkaW5nIGEgcHJvcGVydHkgdGhlIHByb3BlcnR5DQo+Pj4gc2hvdWxkIGJlIGV4
cG9zZWQgbGFzdCwgYXMgaW4gb25jZSBhbGwgb2YgdGhlIGZ1bmN0aW9uYWxpdHkgaXMNCj4+PiBz
dXBwb3J0ZWQuIFRoYXQgd2F5IHdlIGRvbid0IGhhdmUgYSBwcm9wZXJ0eSB0aGF0IGRvZXNuJ3Qg
ZG8gYW55dGhpbmcuDQo+Pj4gV2Ugd291bGQgYWxzbyBuZWVkIGRvY3VtZW50YXRpb24gYWRkZWQu
DQo+PiBSZWFkaW5nICIzLjEuNi4zIE1lbW9yeSBQcml2aWxlZ2UgaW4gbXN0YXR1cyBSZWdpc3Rl
ciIgaXQgaXMgbm90DQo+PiBjbGVhciB0byBtZSB3aGV0aGVyIE1CRSBhbmQgU0JFIGFyZSBoYXJk
LXdpcmVkLCBJJ2QgaGF2ZSBleHBlY3RlZA0KPiBUaGV5IGRvbid0IGhhdmUgdG8gYmUgaGFyZC13
aXJlZC4gVGhlcmUgaXMgYSBub3RlIGluIHNlY3Rpb24gMy4xLjYuNSB0aGF0IHNheXM6DQo+DQo+
ICIiIg0KPiBBbiBpbXBsZW1lbnRhdGlvbiBzdXBwb3J0cyBvbmx5IGxpdHRsZS1lbmRpYW4gbWVt
b3J5IGFjY2Vzc2VzIGlmDQo+IGZpZWxkcyBNQkUsIFNCRSwgYW5kIFVCRQ0KPiBhcmUgYWxsIHJl
YWQtb25seSAwLiBBbiBpbXBsZW1lbnRhdGlvbiBzdXBwb3J0cyBvbmx5IGJpZy1lbmRpYW4gbWVt
b3J5DQo+IGFjY2Vzc2VzIChhc2lkZSBmcm9tDQo+IGluc3RydWN0aW9uIGZldGNoZXMpIGlmIE1C
RSBpcyByZWFkLW9ubHkgMSBhbmQgU0JFIGFuZCBVQkUgYXJlIGVhY2gNCj4gcmVhZC1vbmx5IDEg
d2hlbiBTLW1vZGUNCj4gYW5kIFUtbW9kZSBhcmUgc3VwcG9ydGVkLg0KPiAiIiINCj4NCj4+IGEg
SEFSVCB0byBiZSBhYmxlIHRvIHJlc2V0IGl0c2VsZiBpbiBhIGRpZmZlcmVudCBlbmRpYW5uZXNz
LCBhbmQNCj4+IGluIHRoYXQgY2FzZSB0aGUgY3VycmVudCByaXNjdl9jcHVfcmVzZXRfaG9sZCgp
IHdvdWxkIG92ZXJ3cml0ZSB0aGF0Lg0KPiBJIHN1c3BlY3QgYSBsb3Qgb2YgYmlnLWVuZGlhbiBo
YXJ0cyBhcmUganVzdCBhbHdheXMgYmlnLWVuZGlhbi4NCj4gU3dhcHBpbmcgYXQgcnVudGltZSBz
ZWVtcyB0cmlja3ksIGFsdGhvdWdoIHNvbWV0aGluZyB3ZSBjYW4gc3VwcG9ydC4NCj4NCj4gVGhp
cyBzaG91bGQgYWxsIGJlIG1hZGUgY2xlYXIgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIGFuZCBzb21l
IGRvY3VtZW50YXRpb24NCj4NCj4gQWxpc3RhaXINCg0KVGhhbmtzIFBoaWxpcHBlLCBBbGlzdGFp
ci4NCg0KVG8gY2xhcmlmeTogYmlnX2VuZGlhbiBpcyBub3QgYSBydW50aW1lIGZsYWcg4oCUIGl0
IG1vZGVscyBiaWctZW5kaWFuLW9ubHkNCmhhcmR3YXJlIGFzIGRlc2NyaWJlZCBpbiB0aGUgcHJp
dmlsZWdlZCBzcGVjIHNlY3Rpb24gMy4xLjYuNSwgd2hlcmUgDQpNQkUvU0JFL1VCRQ0KYXJlIGhh
cmR3aXJlZCB0byAxLiBJdCBiZWxvbmdzIGluIFJJU0NWQ1BVQ29uZmlnIGJlY2F1c2UgaXQncyBh
IHN0YXRpYywNCnBlci1DUFUgaGFyZHdhcmUgcHJvcGVydHkgKHNhbWUgY2F0ZWdvcnkgYXMgbW11
IG9yIHBtcCksIG5vdCBzb21ldGhpbmcNCnRoZSBndWVzdCB0b2dnbGVzIGF0IHJ1bnRpbWUuDQoN
ClRoZSBNQkUvU0JFL1VCRSBiaXRzIGFyZSBhbHJlYWR5IGVmZmVjdGl2ZWx5IGhhcmR3aXJlZCBp
biB0aGUgZXhpc3RpbmcNCmNvZGViYXNlOiBub25lIG9mIHRoZSB3cml0ZV9tc3RhdHVzL3dyaXRl
X21zdGF0dXNoL3dyaXRlX3NzdGF0dXMgQ1NSIHBhdGhzDQppbmNsdWRlIHRoZW0gaW4gdGhlaXIg
d3JpdGFibGUgbWFzaywgc28gd2hhdGV2ZXIgdmFsdWUgaXMgc2V0IGF0IHJlc2V0DQpwZXJzaXN0
cyBmb3IgdGhlIGxpZmV0aW1lIG9mIHRoZSBDUFUuDQoNCkFkZHJlc3NlZCBpbiB2NzoNCiDCoCAt
IE1lcmdlZCB0aGlzIHBhdGNoIHdpdGggcGF0Y2ggMyAocmVzZXQpIHNvIHRoZSBwcm9wZXJ0eSBp
cyBpbnRyb2R1Y2VkDQogwqAgdG9nZXRoZXIgd2l0aCBpdHMgZWZmZWN0Lg0KIMKgIC0gU3dpdGNo
ZWQgZnJvbSB8PSB0byBzZXRfZmllbGQoKSBzbyB0aGUgcmVzZXQgdmFsdWUgaXMgd3JpdHRlbg0K
IMKgIGRldGVybWluaXN0aWNhbGx5IG9uIGJvdGggY29sZCBhbmQgd2FybSByZXNldCwgbm90IGp1
c3QgImNsYW1wZWQiIGluDQogwqAgb25lIGRpcmVjdGlvbi4NCiDCoCAtIFVwZGF0ZWQgdGhlIGNv
bW1pdCBtZXNzYWdlIHRvIGV4cGxhaW4gdGhlIGhhcmR3aXJlZCBzZW1hbnRpY3MgYW5kDQogwqAg
cmVmZXJlbmNlIHNlY3Rpb24gMy4xLjYuNS4NCiDCoCAtIEFkZGVkIGRvY3VtZW50YXRpb24gdG8g
ZG9jcy9zeXN0ZW0vdGFyZ2V0LXJpc2N2LnJzdC4NCg0KQmVzdCwNCkRqb3JkamUNCg==

