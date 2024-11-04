Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACC3D1BDD3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t812y-000723-9H; Mon, 04 Nov 2024 12:39:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1t812s-0006xt-BO; Mon, 04 Nov 2024 12:39:18 -0500
Received: from mail-mw2nam12on2062d.outbound.protection.outlook.com
 ([2a01:111:f403:200a::62d]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1t812p-0001WI-Ms; Mon, 04 Nov 2024 12:39:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhqMyDg4q5R92V5qmdHtDNzkhYX9qtXgIJ16bnVBgVcIWknzUDsMx4Ba9ThMMXsHOsfjrPs8D+ZQ8EejGwSZP3JGWeg/QcW+swq3FnkmSa+E2VhAZcTVcEbyXK6ocPwWIRDyaoPlx0ToyBHemaWT6ZoyW//sqApFE2sLa+pKbivhu7paTnlc71Jr0u1MPntHxaQ4TfJTxWRWXZvH10yU9/K6/Kwxx9A1CxMPiafSJnt7GyxOk4ZViNrcRU6nCWdubsXdXKc1A3hKjViQWJF1lyVloXdLOjkgy6aPLQA7gFrZ90YnKYz2P6BXUuOBAtOinPu31RqKtAkRKJ6HO21qHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbyofWxhCBJlETPPL2ByeP/+ryxwdOrfjlItNRF0ukQ=;
 b=ZNChusKbtbENcZRmwM0SSUbpietNZwpRjKdheBVkSaWjzpc6oMiqhagGIrjPRWF20eVccam/VXPz2wHfpJ7rkrZhid4N0B56qmeVRNJMQlAaMflA2L4dfna1GDxW7NgQ3SBlLTiQi1/KRgeyzzQYdfx4DnpHdpyRIRc5USos5yBTryFwK8dXHb8PUq4qQ29WCQPq2Tsddh7nAxt+avmSBmD+873xNaV6CXgv7KVvx+8iMGTqvXOPlsNwTBMBUsauhyIieV3Zsa7dw/shy0KqTpPKo6HioA3qS8E6AV2nFLvM4egROAOoFmBDukHq/h/O/WOMwWWfR6Ox+eZlVs/3yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbyofWxhCBJlETPPL2ByeP/+ryxwdOrfjlItNRF0ukQ=;
 b=ESGAIKVBW1WtbXxrfzjQKcx+w/nlRhf4rJ9bDasxNi/AJEGYwqByZJzJ5oGP3tSshiPvzGEbq+ASSvY9YgL5j9nPysmWeXCKufqSX0FCy0V85EHXhnQCFN/DAtxWNYikgqPzd7fgRceLBI4lPAxNW0r+CFciMEhW+YA+Itcf0ds=
Received: from DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) by
 DS7PR12MB6144.namprd12.prod.outlook.com (2603:10b6:8:98::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.30; Mon, 4 Nov 2024 17:39:06 +0000
Received: from DS7PR12MB5741.namprd12.prod.outlook.com
 ([fe80::4a06:1053:ead5:ef39]) by DS7PR12MB5741.namprd12.prod.outlook.com
 ([fe80::4a06:1053:ead5:ef39%7]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 17:39:05 +0000
From: "Boddu, Sai Pavan" <sai.pavan.boddu@amd.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "Simek, 
 Michal" <michal.simek@amd.com>, Alistair Francis <alistair23@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, Bin Meng
 <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, Daniel Henrique
 Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>
Subject: RE: [PATCH v2] hw/riscv: Add Microblaze V 32bit virt board
Thread-Topic: [PATCH v2] hw/riscv: Add Microblaze V 32bit virt board
Thread-Index: AQHbIGXDNaihtEdEIUuajgv+UhTD87KerV2AgAAyA4CAAXRDAIAATZcAgAB52ACABmTDEA==
Date: Mon, 4 Nov 2024 17:39:05 +0000
Message-ID: <DS7PR12MB57414558FB13B67741091313B6512@DS7PR12MB5741.namprd12.prod.outlook.com>
References: <20241017072507.4033413-1-sai.pavan.boddu@amd.com>
 <CAKmqyKNfoakaJ66PCN49x5+=gVkAnQVV1UWTdPe7ARr3RA8ouA@mail.gmail.com>
 <7dbcb2de-89f9-445b-a096-2a3d03a2dfe7@amd.com>
 <34d6acf1-2106-481e-a016-375e697f31cf@linaro.org>
 <47b60bf0-e43e-43a6-b9d7-0d072cd8d4ad@amd.com>
 <8caf45e4-0be8-46aa-923b-402c80f74060@linaro.org>
In-Reply-To: <8caf45e4-0be8-46aa-923b-402c80f74060@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5741:EE_|DS7PR12MB6144:EE_
x-ms-office365-filtering-correlation-id: 5ae86b22-d869-4445-a3fe-08dcfcf79488
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZW5FVXR6MGZYV0tvNlBlWmltQ2RXenlNZWFhWXZuTmd6RVdjMUZLV0NLY3N1?=
 =?utf-8?B?S1VVOEdJZXpaL1NXYU9wTWJ5VWJuWXY0T0hzV2pBWUhjbzRCSWNucCthQ0FS?=
 =?utf-8?B?aHJmNEtkMEtTenV2d0NpZ0NjbHJTaDIyWGxDWEMzMkUxMHQ5LysveVhJWWdV?=
 =?utf-8?B?bWVxRkpQbUxhYjhScW5NMW1MNmRvSzF4UmtwZVlWaU1Ob1FEa09wVlZkSGx0?=
 =?utf-8?B?eDZEMU5OdXFrVU1NdUFxSHBPVFl4TVg2Vzl3TGU0aDI4L0xwZzBRNXNDY0lY?=
 =?utf-8?B?ZWQrSTlYWDdxMVlodEEyclN3WS9PVUdLUTcvN0tZS3Z6S1FxVUhCOVBrMjFj?=
 =?utf-8?B?blc3RzNaNEZaN2ZvMXQwd056OWI2a2dRWk5rcWxhdGJBSHRHemxEdEJ1WkVP?=
 =?utf-8?B?UDlNb0FVOUdwVzVPelpMaVBvUlRBQnNlK3B0NXFYdThnUGQ1VmVzZFlxYWxV?=
 =?utf-8?B?ZHVFT1N4TndCYmNNM2hqRjhEQUZkMGtjbWk5ZENEWEI1ZGkwL2lJVGdYQVpY?=
 =?utf-8?B?S2tzc2JBdWZSVi9PMjVHMUEvTEpSaFlLTE51TjRZaFkycVM3d3M5TWIrdWdR?=
 =?utf-8?B?Nll1R016WGx3cy9aS2ZHdFdpZ1RLd1Z3NHdXNDduOTlvMm1Tek5MbnV3VlF4?=
 =?utf-8?B?K3ZxMmV3ZjdpMXRiRVBVcFFsSm5tZEIybk1oMzRsTnRDeXFKNXNYRG5yOEhn?=
 =?utf-8?B?empnMjNqZkxWbTR0M1FQeXdzUWhQYkVaZ2p5TUp4eHdzUWVuSDdmUk9EZy90?=
 =?utf-8?B?Rldtd2FuVlBUZjVZTXVyZlVEWFlJRUVwRFdtSzRVZlI4ZnVvK3V0enN1Y2c5?=
 =?utf-8?B?TlJPT3QvYnJPcWt6aUp1aVJwK1JtNzhTSHFqb1ZiSHl5R3RQTnpjRXZ4aHlw?=
 =?utf-8?B?TXNDSHIrUUxSczE0QWhHWmJ4cnVWL2dNQldKdlY5UnNoSzB0ZGtzRnhISUh4?=
 =?utf-8?B?OTJhSmZlYjNCcjUzMytvdlcvbkpmdjdkNlhGbGxuTmQwOFpWaUhhZVZmdDhT?=
 =?utf-8?B?UThaVW5PMjQ2WTNNVDEwVlp6R3ArZ241T1dxZG5iOVBpQ3ZEVDFhMmI0NXoz?=
 =?utf-8?B?WkhYUm5EbHJhQjJmYmI2dDBxekVUbnhObGJrc0tuV3UvZGRHb2l5cVlXMndK?=
 =?utf-8?B?STBEMDgvTlFNaWt4OC9kcUJ0R3pCcGxkVG95SDhnbWFIbHl1b0ZwNkxVMG9N?=
 =?utf-8?B?TnFta21MOEdOZzdWMXRnY2pGaTlIS2dNcndNSE8xTmNTZHZGQzVNNHc5OUtB?=
 =?utf-8?B?a1JtWjdGSzVEdjJEYnBLMmxsUEhndlptTU1sSERFaHo5dHd3UUNxQW5acS9s?=
 =?utf-8?B?MzRnNVJHVnBaRDBnUFArVlVKUldpUnlpVjgwYStPblZVU0srZFQxanBmclB4?=
 =?utf-8?B?WDJIdGlJelAzdEtHZzVUSzFSdnIzQzdORXpXOHhNZThxNDhEUEhtbjF1N045?=
 =?utf-8?B?UXc1WGg0Y1R2dDVUaUhSM1p4VWE2TmhZRjF2WXEwWkxXbE5EdWhXTW5GTzVp?=
 =?utf-8?B?WUJmUFVBVHJCQnl0WEZHL2owQThYYmhGWStaMWRObHRjT0tNQ3lIZGxDTmx5?=
 =?utf-8?B?WGpxQ3NPWlA4UWNCS0ozeGRGTjVTQWxtNVlNT0k4cnNZRjBCbldRZnZZRGRl?=
 =?utf-8?B?QWVRYm90bU4xbW04cklQMTZ0UkQ1V2xvY0JKa05CK0VnUndOSDVyMWxUZWtR?=
 =?utf-8?B?N2hId2hINzRDT3Zwb2U4WHhrRzFsR0U4dXpzck96V3h0ZTVpZy9Ec1VHemh1?=
 =?utf-8?B?aXkyWEthTjgxV3BVdXlDT2JNWWtXaHJSaE5rYXkzWi94VFZuL1NoZkxoaGlP?=
 =?utf-8?B?ZTlrU1EyMklDK1JoNEU4V2cwWmFXNnI5QUoyOUhMVTAxZHBWOVZYNTM4VVBT?=
 =?utf-8?Q?afBKVnAOkESVs?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5741.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2lkZjU4c2Jhd0wrU0NlOGQxclM1R3oxaXVjMlNUYXpLVys1Sy9sYUZVYWpJ?=
 =?utf-8?B?UWxFWFpmSGlObXlMbUpHRnJuMmJjZlFqRkhwN2JJOFhoRjBsZi9Uc0kyN3By?=
 =?utf-8?B?VUYvQWZTeEpEZ2VFaDgvSmpjTklZNDd2NlhnTzYwVXUzaDFUaldiYXl0eUM4?=
 =?utf-8?B?TmxBd2lVZ1pGL0pwSDdTcVJJSUxwNTIyZTdHK2lPdlZaYm9jczloMjFOa0lx?=
 =?utf-8?B?c0laUGhrcnk0bmJIUDVXczJ6cFZBYVJvSEUzQmJjVjdpWmhpRE5aNlBKbWk3?=
 =?utf-8?B?aTBZbDBBdTdCRmNqNGF2bUVNVkZXNStYRlk4OVE4NVRuL0lXWHJMbnA5V1My?=
 =?utf-8?B?RWM2RkROK01WT3dQQ3lPTzRESVRuNk9rUStwUVN6WGFnVjRtUVBkQnBGZmxX?=
 =?utf-8?B?T2VNTkRaZEUzd3hqb1Q0VmdYdmtaWFFzY2RVSWs1RytqTjFKaWxuUzRMSWN6?=
 =?utf-8?B?NlhOVndBZEIwR09Mc28xVzNJb244eVNGMGVYSjBHU0FuaGtlOFk1bDVQdjZr?=
 =?utf-8?B?a3Rxdnl4U0svMU82Z3hJUzdLbndSL0RQVFlHMW9OSzdrVzJ1NzJjMnllUEhs?=
 =?utf-8?B?b2xrUDAvUnM1QVluTDB1ZWdtUUxlYm53ZHo0YWxQU0FGbVVHUW9jRFl1NlV2?=
 =?utf-8?B?L0pOTjZZRm1TNHI5Z1FUelY4cFRZeUJqZ2wwVU5FTS9VTVNlZk94cDJON29Z?=
 =?utf-8?B?RzRuQm80K1NLb1BSTkN3MzlhbVQ1SzZOcDRwU0h6Zkdyano4dHQ1SkRYemxF?=
 =?utf-8?B?dHkzSzlMZVc2RnR2YzgvelpxMTkxWkdrR25YOEpJbEFhVW81aUdpVStZZVMz?=
 =?utf-8?B?Mkw1ajFGRWFEbzNUcTFyeWZteGNYeHpFOER4OHZvK2c4TEI0ZWlkRnZBcmh2?=
 =?utf-8?B?NXBHaGNOTTdFZncrd1VtRWpZaGN5SnNtTnhNQml1ZWV3TmJkUkp2dTBwc0dC?=
 =?utf-8?B?Wmx5dWlCV2hMc0t6QldNa2RZNWVhWHRtS0duR0RoTTFjZlB1VnNSTWZ1SzVp?=
 =?utf-8?B?TTdubVlVT3lHdUFScklZODBYTjh2UHhYQlM5WU8rREVhTUt5NllPZjZ2bUNq?=
 =?utf-8?B?Q3ZMRTFmRjR0UHZyaGVCTS9KSGNCM0tkT1BiNDM3NkgrQWZHZzNieVhWb2RX?=
 =?utf-8?B?aFRaQVJPU050NDJLQ2ttajRqTno3QlV0aDFGaE9JdUxtcDVoN2h0MUpoelQz?=
 =?utf-8?B?bzdYRGI4Ui81TkFtSHE1dFFJUlplTXJQdjd1VjdqRXY5czNBQzRGM2VlaFNX?=
 =?utf-8?B?OGV5WmZXakxibVM2ZmE3aGpVNWRSakpUbG1FOFJId0d0MTRON0dqUzBjSUkr?=
 =?utf-8?B?bCtJWjVJQS9wVzVSQzRjNCsrK1ZiVTBTZXJ5R3dFVkdobmhSV2MyNlV2bHQ4?=
 =?utf-8?B?ZlRiek1aUXMzT05weWdVemRYUGl3ZzVUSldCYmZHVUhIWXgrSEo3eDJ1Njlo?=
 =?utf-8?B?OVgvcXdJcE5sNktuMHFqOHcxN1RwYUwxMlpzMWU4dFIrVGlUYWpZbmszOTBp?=
 =?utf-8?B?RWo2eGVpakczNVZMSStiMk9vdzVKQ0UrY2xyc3RkWUlDZ283b0tRVXBvdmVY?=
 =?utf-8?B?bFREakZxaDNTeE9LVWg1QTdxSGU4UGx4ZzZqdnZUNjhSM0pIWXBjRnhLWjlO?=
 =?utf-8?B?VlUyM0FJNW92bWdLU04weWhJNXlGNkxhbXc5cFpyMDZQM1hYWUlPWXI1VzFa?=
 =?utf-8?B?b0dxSWpJQVRWTE9kWURNVjBNVFlKenR5bDRaUm9FVkYycUh2RndEWmVzdHBy?=
 =?utf-8?B?MG1LSmI2RG1PRjFrWjhSTE15cWxDYTF0Y0JOZnVVL2lIWllHL2xnRGgwV2Vw?=
 =?utf-8?B?VVh2emZJVktJY1pTZkhsV1ljK3dYVGlGRGFOSGZPMWp3NDViWHd4NjIwRVc0?=
 =?utf-8?B?Z21jNnRSZllhYU02Uit1TjNpTG5NbXl3SzFlZFN5NXR3K0Y3VVErbXFMZVht?=
 =?utf-8?B?a0hwVy84OTBURGhDS3o1b2lnNDVQU2VKZlpXRE9UTHZEK0RrRllnWURMYXA1?=
 =?utf-8?B?WFRvMGQwWVI2QUpyUWNWNVZHUnpSbFZKYXFTWVQyTjZOSUVKcitsOU1HZU5U?=
 =?utf-8?B?WG5aRWhuSGlCRFdjUVF4TGlZaUFoaHM0dmpOSmFpNFBOZHZOeXJoeW5pK1Fs?=
 =?utf-8?Q?VMDU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5741.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae86b22-d869-4445-a3fe-08dcfcf79488
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 17:39:05.8465 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 42f1W923KfxB5ptoT9CYJpgBgcDkUgqsA+N8J0x9FnUvKwFLPDdNdkKyvltOBUKs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6144
Received-SPF: permerror client-ip=2a01:111:f403:200a::62d;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

VGhhbmtzIFBoaWwsIEkgd2lsbCBzZW5kIGEgdjMgZm9yIGZvbGxvdy11cC4NCg0KUmVnYXJkcywN
ClNhaSBQYXZhbg0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBQaGlsaXBw
ZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+U2VudDogVGh1cnNkYXksIE9j
dG9iZXIgMzEsIDIwMjQgOTozMCBQTQ0KPlRvOiBTaW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtA
YW1kLmNvbT47IEFsaXN0YWlyIEZyYW5jaXMNCj48YWxpc3RhaXIyM0BnbWFpbC5jb20+OyBCb2Rk
dSwgU2FpIFBhdmFuIDxzYWkucGF2YW4uYm9kZHVAYW1kLmNvbT4NCj5DYzogcWVtdS1kZXZlbEBu
b25nbnUub3JnOyBxZW11LXJpc2N2QG5vbmdudS5vcmc7IFBhb2xvIEJvbnppbmkNCj48cGJvbnpp
bmlAcmVkaGF0LmNvbT47IFBhbG1lciBEYWJiZWx0IDxwYWxtZXJAZGFiYmVsdC5jb20+OyBBbGlz
dGFpciBGcmFuY2lzDQo+PGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT47IEJpbiBNZW5nIDxibWVu
Zy5jbkBnbWFpbC5jb20+OyBXZWl3ZWkgTGkNCj48bGl3ZWkxNTE4QGdtYWlsLmNvbT47IERhbmll
bCBIZW5yaXF1ZSBCYXJib3phIDxkYmFyYm96YUB2ZW50YW5hbWljcm8uY29tPjsNCj5MaXUgWmhp
d2VpIDx6aGl3ZWlfbGl1QGxpbnV4LmFsaWJhYmEuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0gg
djJdIGh3L3Jpc2N2OiBBZGQgTWljcm9ibGF6ZSBWIDMyYml0IHZpcnQgYm9hcmQNCj4NCj5PbiAz
MS8xMC8yNCAwNTo0MywgTWljaGFsIFNpbWVrIHdyb3RlOg0KPj4gSGksDQo+Pg0KPj4gT24gMTAv
MzEvMjQgMDU6MDYsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPj4+IEhpIE1pY2hh
bCwNCj4+Pg0KPj4+IE9uIDMwLzEwLzI0IDAyOjUzLCBNaWNoYWwgU2ltZWsgd3JvdGU6DQo+Pj4+
IEhpIEFsaXN0YWlyLA0KPj4+Pg0KPj4+PiBPbiAxMC8zMC8yNCAwMzo1NCwgQWxpc3RhaXIgRnJh
bmNpcyB3cm90ZToNCj4+Pj4+IE9uIFRodSwgT2N0IDE3LCAyMDI0IGF0IDU6MjbigK9QTSBTYWkg
UGF2YW4gQm9kZHUNCj4+Pj4+IDxzYWkucGF2YW4uYm9kZHVAYW1kLmNvbT4gd3JvdGU6DQo+Pj4+
DQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2h3L3Jpc2N2L21pY3JvYmxhemUtdi12aXJ0LmMNCj4+Pj4+
PiBiL2h3L3Jpc2N2L21pY3JvYmxhemUtdi12aXJ0LmMgbmV3IGZpbGUgbW9kZSAxMDA2NDQgaW5k
ZXgNCj4+Pj4+PiAwMDAwMDAwMDAwMC4uNjYwM2U2ZDZiMDYNCj4+Pj4+PiAtLS0gL2Rldi9udWxs
DQo+Pj4+Pj4gKysrIGIvaHcvcmlzY3YvbWljcm9ibGF6ZS12LXZpcnQuYw0KPj4+Pj4+IEBAIC0w
LDAgKzEsMTgxIEBADQo+Pj4+Pj4gKy8qDQo+Pj4+Pj4gKyAqIFFFTVUgbW9kZWwgb2YgTWljcm9i
bGF6ZSBWICgzMmJpdCB2ZXJzaW9uKQ0KPj4+DQo+Pj4gSXMgdGhlcmUgYSA2NC1iaXQgbW9kZWwg
cGxhbm5lZD8NCj4+DQo+PiBUaGlzIGd1aWRlIGlzIHRhbGtpbmcgYWJvdXQgNjRiaXQgdG9vDQo+
PiBodHRwczovL2RvY3MuYW1kLmNvbS9yL2VuLVVTL3VnMTYyOS1taWNyb2JsYXplLXYtdXNlci1n
dWlkZQ0KPg0KPlNhbWUgYm9hcmQsIGRpZmZlcmVudCBjb3JlIChzeW50aGVzaXplZCB3aXRoIENf
REFUQV9TSVpFID0gNjQpLg0KPg0KPj4gSXQgbWVhbnMgYW5zd2VyIGlzIHllcy4gQW5kIHByZXR0
eSBtdWNoIHRoaXMgZ2VuZXJpYyBtb2RlbCB3aXRoIHRoZQ0KPj4gc2FtZSBsYXlvdXQgc2hvdWxk
IGJlIHBvc3NpYmxlIHRvIHVzZSB3aXRoIGdlbmVyaWMgNjRiaXQgdmVyc2lvbiB0b28uDQo+Pg0K
Pj4gSSBleHBlY3QgdGhhdCBtZWFucyB0aGF0IGRlZmF1bHRfY3B1X3R5cGUgc2hvdWxkIGJlIFRZ
UEVfUklTQ1ZfQ1BVX0JBU0UuDQo+PiBhbmQgS2NvbmZpZyBzaG91bGQgYmUgZXh0ZW5kZWQNCj4+
ICvCoMKgwqAgZGVwZW5kcyBvbiBSSVNDVjMyIHx8IFJJU0NWNjQNCj4+DQo+PiBBbHNvIHNvbWUg
c21hbGwgdXBkYXRlcyBpbiBkb2N1bWVudGF0aW9uIHRvIGNvdmVyIGl0Lg0KPj4NCj4+IElzIHRo
ZXJlIHNvbWV0aGluZyBlbHNlIHdoYXQgc2hvdWxkIGJlIHVwZGF0ZWQ/DQo+DQo+Tm8gaXNzdWUs
IEkgd2FzIGp1c3QgY2hlY2tpbmcuDQo+DQo+UmVnYXJkcywNCj4NCj5QaGlsLg0K

