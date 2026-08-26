Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3785C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 06:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz6lJ-0001si-88; Wed, 26 Aug 2026 02:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6911f864d=Alistair.Francis@wdc.com>)
 id 1wz6lH-0001sR-VL; Wed, 26 Aug 2026 02:05:24 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6911f864d=Alistair.Francis@wdc.com>)
 id 1wz6lF-0007DU-NI; Wed, 26 Aug 2026 02:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1787724325; x=1819260325;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=hqvo70sqCQuNimSK+EG13IGy9eaxuxfxA+JUNuAzVpU=;
 b=GPxOo855OqqBKemDv+6bvamydChraGac0XdY3qBwMjtvcAFhyDdGlJ00
 X5SGjvBorw6x82wqUCgMZPBA5BnxIdRnEaFCNysBIGrY5Il/7taKlZAhk
 +xUQX8mdkSXIv4hMV7ajNQox+Krb3cIDuNz8kIkFwVFkxVZAK2KqRjSa2
 BRb3Q3WXg/S2w33cvL1fE8JjTtURkRnY9gQ416tvb7HZc8L33/YCViS6s
 Puu339I+oJqvAwTpSSoOLuPNoGxmfzmgmGWbHk3i4e2qkwyu3c8C6Yghi
 93FRecv1WRpkhnyFVSwvcxZ/DeukWmTe4t3f+Yd5VPVkGv99NwCH9nKSy w==;
X-CSE-ConnectionGUID: HYl32vCpQie0bUUANot9Fg==
X-CSE-MsgGUID: Lx+4tv3CSr6go7G7Zl1lzA==
X-IronPort-AV: E=Sophos;i="6.25,244,1779120000"; d="scan'208";a="154288024"
Received: from mail-westus2azon11012040.outbound.protection.outlook.com (HELO
 MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.40])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 26 Aug 2026 14:05:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdCqGyxa90F7boDoEJo3LJKopcVOckRiq1L6ScRQJJA3z9UBVttbDVoEm/v+KfF57D/aQA4bn9DuozstD63JhRljSvrtcB9GmsUIlb/Q1PaiMY/IXqtgvjIl45JopWjxnu/zVxLILjdQuH9DjwsHz7+GNsWA7oc7BlKeGQzwMyFMpJH6s0ihmRGlQThTS6T1E6CvqUM8FXbETQTZYP8Itt78lJIrjSclf8u0IZZfE9nl8iqrBsm6FMsj/0yrJOwVYW4Cp7CfRjiT9bJMQ0Y8UN8A8my3UQLDGcX4BeH92akgvN/xdBDt67L48pWUaO/Cam1IJ91+UGnhRR8XIlFrnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqvo70sqCQuNimSK+EG13IGy9eaxuxfxA+JUNuAzVpU=;
 b=aR3pHqQbzG/+GAFnWu07T9fTlT+ZUaczzNzbhHlo7rrTDF/j95Kj5vnhmODvZVESasWgNLscQXg3ETa/WnmCZs7nhnw53Hfr/Xj2/t+z9bMFNLabGbi4yHl3TpmNcXKdt3GBJh0bmRP7/HzP5D64s4NiinEKbFBG4lhplRWRSorgHEjASnAAIrkb1lw1D6NrsY5/jazVuWRxZnIvDcYqxsbm5h7DSyGKTc4K1c12UdzTChhCzRwFXhpqAHMKjWpaQj/b7XhnD2lcPGsIRiRauZpFRpQCZjW2dBsV8o9iSo/6dFNtVZ2tKoTPCasWzMiWIH6dAJ5XJrzG21oxDdNjtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqvo70sqCQuNimSK+EG13IGy9eaxuxfxA+JUNuAzVpU=;
 b=nDYS6DW2BaovkpiAqGPI/ztpoCeYwDf7pyClHeNaiZQZHrEAfbSHRQUzXiqkLinOhnECneAhUz8LvRdCMk+Ul60p1anFR6MJQp4YR8tvGOx/Lvd0aVRpxg5/ULo2D3+51Eqj9tGJje1wZitcDPtYRPbcuYqzaWoZmddl6OX7QGw=
Received: from CH5PR04MB9550.namprd04.prod.outlook.com (2603:10b6:610:20e::17)
 by CH2PR04MB6490.namprd04.prod.outlook.com (2603:10b6:610:69::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 06:05:15 +0000
Received: from CH5PR04MB9550.namprd04.prod.outlook.com
 ([fe80::2dd5:1dc8:e3e7:5d31]) by CH5PR04MB9550.namprd04.prod.outlook.com
 ([fe80::2dd5:1dc8:e3e7:5d31%4]) with mapi id 15.21.0360.005; Wed, 26 Aug 2026
 06:05:15 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "frederic.petrot@univ-grenoble-alpes.fr"
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: Re: [PATCH v3 0/1] target/riscv: correct cbo and lq disassembly
Thread-Topic: [PATCH v3 0/1] target/riscv: correct cbo and lq disassembly
Thread-Index: AQHdNHnU+OudLdqfx0CPbmeMpeG0KLav2MQA
Date: Wed, 26 Aug 2026 06:05:15 +0000
Message-ID: <f30f8dbd7da63cb1035de4232858809020d72af8.camel@wdc.com>
References: <20260825100922.387919-1-frederic.petrot@univ-grenoble-alpes.fr>
In-Reply-To: <20260825100922.387919-1-frederic.petrot@univ-grenoble-alpes.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH5PR04MB9550:EE_|CH2PR04MB6490:EE_
x-ms-office365-filtering-correlation-id: 92665e8c-8b4a-4411-01b0-08df0337ff8b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|23010399003|376014|366016|19092799006|22082099003|18002099003|11063799006|3023799007|38070700021|56012099006|10067099003;
x-microsoft-antispam-message-info: bI7KuOsdGHfpa5skZB7+Ny5HcK6spyby27R8aFTWpkGkDWQDmYm6JyDoJY+7pwoAJFwRpQmlw9rkfQyq9Zr1pjI6T9rqouKZQEDcddZFWjiob84mt3N4C4kj4MovjQdMdPlW85DVD1BZPt8/pXzWCEdjMwOh8k2DxKG2RVNLMXg6TQwUcNC9EzwNYyX+x3vwZ4NOH2tGIDw/P3JohJEakkwSdcizxcGjMikZ/jTTTfuh3C5CWo0b3dBrayaLfN7sVygY6AH834DJSgMBD0YbjBPCdEz/WaobvP3PKMyWT22vYEC/JIEkZqdJ/dT9ui6bOGylYNHd+Bsq+TskWxBhRO2E6FXResVvzyLTPAebzavgXmhKERakfcZeSJBcVGeF3CcAOyn3HgE7O136Md/kyTB22M7/Fnz9nMF6VqFggXXDRHgFXnLftl5AO/FzOqfSBrrZIavxX/UHa3wX6mRnRgeFbS0gaNTDZxsosNIUU283Nd4srH5aa6tzn5LcN/eZyIY1QyyLjiyeykXLgwZtMcrU4idVTAtU6YfqtF3QUfvBrzXpBJ+MqZz1BE2TQSZZZTpqEvIOiv8Y93DRrKaW8+afsVPDpN9dcBh+5TLa4YNOjQdtInBmMG0OdS7ZpaTQ8BjTcFz1/pP41k0bhwnpkq4rWGYWHSOQlJXAB1lK+SUcLjpc2FCB/GeCQaNoByqOHgzsqjqt08MjrUtCLMwWSwhDa8CFPKb00s+R3a5GWI4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH5PR04MB9550.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(23010399003)(376014)(366016)(19092799006)(22082099003)(18002099003)(11063799006)(3023799007)(38070700021)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEJHV3cxbUtOekpZaVFxenZFdTcwNXdIdFdmWTd4N3pzdVowWi9KZjBvcWVR?=
 =?utf-8?B?MmFKZE9RZUkyMkUxUTVuT3JxSnhDZGxIcDBOSkJ0SWdoOVFjS0ZpUDNybTFE?=
 =?utf-8?B?SUx0bk54TUJUWGFITDJUKzJnRVlPY25nYytTUlV3bVY1anZBUmFZVU9xSktj?=
 =?utf-8?B?WFBINTF4Ni9BNWFSQUhtMlpyTzc2czZ4Y2NjbXNqMXpIL0RFTFVOLzZkZzV5?=
 =?utf-8?B?b0NNNjNWS3c3L2tFWFM1SFZVakluNmZhRWJ4WWEvWDk4RUtJUHN6ckVsOW5t?=
 =?utf-8?B?YVdlZ3d4T0ZnRm5hRW5VSmtDYUQyVCtmRmhBRzNBQkZqdERTMFZrM1ZvWDI3?=
 =?utf-8?B?S2ZTQUwyNU93Q0c5b05HQlo3Qkt3RG51OGIxcU1pVkwwN1Yvb2hjWW5jejhH?=
 =?utf-8?B?WWg2QkxMR3BiV3pOdENOT1lwclEweDFzeDBiT3NkT3ZCZU9JTXU4WG9DMlY2?=
 =?utf-8?B?dWl4Yi85SCtPOTlsWjhCaDd4dnZPQ1hCbGxZaW1BaEgrS0dhMHZvV0lJT09N?=
 =?utf-8?B?WDBWZldEVGZhK3dKVzVackdaT2swY3RtU3NHL2lINkhNRlpjREhvTTJySVlx?=
 =?utf-8?B?YzBIQWNDU1Vkajhscm9jelY2U0xaOStVbFhBZ3FQVHlUdEl2d1BxRUduRk1V?=
 =?utf-8?B?bEZ5TkNxOWJZdzE3eHQrOUpwZ2xjeDUyTXNDbkQ4ZU54L3ZjNldVOTE2K3BH?=
 =?utf-8?B?M3NibFU5K1JRMWtDR09VdkFrZHlkWHpMd2I3OUZDcDFTeEk1eS9VdlF4UmNo?=
 =?utf-8?B?cmRZNGhtVU9Zc2tNMDAxZXQ1Z0JrUnBEdG1mUTZUNDI3VnRPaUYrU2JOdnYx?=
 =?utf-8?B?cW5SZVM0bHZ1KzBub1pqMDViS3RjYitVOVB6THpueXgvNXd0MlVnT29oS1hz?=
 =?utf-8?B?ZldnQU85c1F2UXBDZytoUTV5cDkxVVlubllOVm1zRVl3MC9xZk9DbVpZb1B3?=
 =?utf-8?B?d3RwYnlmaGNOSkFRcnpHeWlpcW1JNFhKZzdFWVVvcWFsVU9lNFVET0I5OXJj?=
 =?utf-8?B?anNQUFJaVUZ2Qy9KL1Z4VnVONDM4dWtRWGd3U0U4U1VvdUkxMzRvMElZVVFQ?=
 =?utf-8?B?U2FoOE5mZjVncG5Ld2VVRGJZQmY0Y3NHVkdFQkpwdGZsTmhRQjRjcmxPL2Js?=
 =?utf-8?B?Y2tPWDVEaHFNdy9KNXRBNzF0MllLekxNMjFJTi9OcnFsLzZRbEZaaGNDcDU5?=
 =?utf-8?B?MXhIV0pTTnJJaW5FaDVWSkxGK1U4MkFwb2VJbGlwaTZ4STNUa1BJTWE1QXNE?=
 =?utf-8?B?SEluZk5CNnBkQUVFak13VUw1dzBjWEIrL3NyLzhLeG1qeXJVWlpxTm01OStz?=
 =?utf-8?B?eHM2RHhzdU95b1JhSDM3Rk1ZbFJ4SkYyd2dURnY0a253bWZzVkc2NzZWc2FM?=
 =?utf-8?B?cmpHK09mSWNIZ0psNmtVVTVhdlJ3eWNJSFlKWmJPUmZ3VzhVcnFMMEhjb1I5?=
 =?utf-8?B?QVI2NVE2V3BVQzNsR1hWUkdLSVRsQkVJOU5yaUtYQ245WE9GNzJ1UjhSZHlU?=
 =?utf-8?B?V0krZnFodzFKRERtc3BveFJnNm1oRldEaGpPMHRSWEVtdzVhTlhmckNDb2M1?=
 =?utf-8?B?dWhKMElHZ3hKeVd1Nldua2hmVzJnRXRLOUs5QTBNYnBCcmdnYzE3SHFFTVhl?=
 =?utf-8?B?dm9pOHdqTzB5UHlnTzFsKytxaFVGV0RWcUI0WHRLcEh6c1pyaFhQd01ZbW8w?=
 =?utf-8?B?Z1JhVlh1NkN6M3psRENYSlBYVlkwZzluOU5oSk5zL3F0WGhlTFNiSmE2NUVq?=
 =?utf-8?B?VUNlcGN2d3ovZWJCa2JEdzRvTGt0M1hvdTNSVFB5VjlpdWVHR0JDQTlWeFpk?=
 =?utf-8?B?dFpQK0dIL0lkQnhIQ0RVem5WS1d2WG00Y1B5OTZwK0FtVGVuZVhKb0pkRGRQ?=
 =?utf-8?B?NkNOdXNYalRub2I3WnVtM3BySEREUDdDc2I5by9UNW54N3B0enpBaDRzend5?=
 =?utf-8?B?K0d2bmh2Nk5ZcXpSM2xnYWhrRmt3ckMyQWdoNVZCRVRya0NFNTFVaytTTndT?=
 =?utf-8?B?ZXdJOTM5UnBjNVkra3pDK0dVdkV3Mit5QW9wZ052enhaNEJxZXd2d2NjcDFX?=
 =?utf-8?B?TWxkYXVNU1VCWndKR092QkRJZ1ZBNHpXVm9sSng0VnE5emtMVnFSaUhldE9K?=
 =?utf-8?B?QStYWTFDY3ZvdFhYWWNTa0s0RWkwTGlKVjdzV2NJeWMzN2RCMnZpb3U3SDM2?=
 =?utf-8?B?OG9DaVQwcWhFUEQ0NVd4NnZLVHBvWDJhSzhYVU1FTGljZmxha0cyL0JBdW0z?=
 =?utf-8?B?MWtrMFd5OGdmKzM2TlY4cnhqSTlaOWpJVnZmMExIazFGb043ampjUmJoSW1X?=
 =?utf-8?B?WVZ0UWNyN0w1MmpteUYyd2RHdUhta1VETFZtTGRuWkJEaG56SlVDZWxvZ0R6?=
 =?utf-8?Q?bM4pUIKv5EBwbAiwtqLU3QxsjzoWcNqhAM3H9aK7QvNGQ?=
x-ms-exchange-antispam-messagedata-1: OL+x995rmExAr2gOnhJdFYmcp6t+HXwO78o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F45423C7F8F654DA03BE94F7AA3D909@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YBrdYWL9sEv6BIygzn2EeuDOZ6YInerWw+b3npu+HPCbM7LhqPaqC4bs8XQbP+0bj0X/E5urJTMBSpAZgX7J6KaYvHJc5kaGHARjq3CEmtC84mIkvrSQ9yjaS2nzy7eKe1C02UblrlUxE8t5or2I2PfGNBp5uBe0oGXHr0z+9UZPjGZYSo2dux+rqtG80DDnn0Yu1z1+D82xf5L+jV1WKsasZKHZNdrfJ6/xxu9bPk34JgcYrh2hu/pVPOd4DYEZZ4wQG+7lUXpqAHB/hpzVBF95zqUeLqEadZDzI5X+GtOXnX7L/sgYII2KZ+GIJuyakZHxPwtdQJdMsIWJ2HrBNw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: P0+MLDB5a7llMDAuBnp8xzq3dULeVHORzLeiKTkhJxFtckwvCs/BG4FGeCwK03/b608r/Gj5gif591Nk4znMiR2wnql7lHNBXNd9/PWIdXan32XGyJRL88zFYEKcoBz5Fn5wpToIAJtppseQE2hQzvY4fHkqYhnUcq2Wezy+SAQ55WZSeqsdbKs/ozjqqf6lp5/4dqZuF7Ic92D7SK1mPpjrBMGpNvy3tQmoMteB1K4ODo4E4NDB4RRemoVBNZJBzuEcIBUSxtbGxsSr6uKVtG+xsZmcXFmHGR2hVjOLt9ennPGskh8NRTijrN5UjAKgkFNAQwpBIiVIUfrOT91USZId0eQPSNeDHyEhqB0amSxnyNsPguMt3OBN0yMFDt19rbJ++qgvSb95ymTV7WQIIrhb+y9/8Tz0pu0mI15PgoxXJNxztml4p9LWIojfpftk3SrIalQ1DwRSCr/b79JNWkYvYM/4VBEsF6VYDNEkWYVOCefT3yPxY4aTDymu6Bba/dq74sKAZ0iOswyiovZznjyIuR5W9fp0gg7+0ApKEvB7fvtxf9SHInxr9epKXw+BuOYfYqiwI1qXogRxCfhnUR2b/ruWlA0QlBNjp36h5X+tcDPOeTYKnfMaF6e8bxA7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH5PR04MB9550.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92665e8c-8b4a-4411-01b0-08df0337ff8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 06:05:15.4746 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X400n4Wj2VcEMcOYeTKB9H3XpvFjOoBWnz+OOv7zjWtsSR+7khnQKidMm6kidyFzdBelfEYGjm/k5HwUUohb9VIHwHcB2ZzbQ8zzhf5S1nY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6490
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=6911f864d=Alistair.Francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

T24gVHVlLCAyMDI2LTA4LTI1IGF0IDEyOjA5ICswMjAwLA0KZnJlZGVyaWMucGV0cm90QHVuaXYt
Z3Jlbm9ibGUtYWxwZXMuZnIgd3JvdGU6DQo+IEZyb206IEZyw6lkw6lyaWMgUMOpdHJvdCA8ZnJl
ZGVyaWMucGV0cm90QHVuaXYtZ3Jlbm9ibGUtYWxwZXMuZnI+DQo+IA0KPiBUaGUgQ0JPIGluc3Ry
dWN0aW9ucyB3ZXJlLCBBRkFJVSwgZGlzYXNzZW1ibGVkIGVycm9uZW91c2x5Lg0KPiBJbiBhZGRp
dGlvbiwgbHEgKGxvYWQtcXVhZCwgYSBSVjEyOCBpbnN0cnVjdGlvbikgc2hhcmVzIHRoZSBzYW1l
DQo+IG9wY29kZSBzcGFjZSBhcyB0aGUgQ0JPcywgd2hpY2ggYWxzbyBsZWQgdG8gaW5jb3JyZWN0
IGRhc20gZm9yIHRoYXQNCj4gaW5zdHJ1Y3Rpb24gKHVuZGVyc3RhbmRhYmxlIHNpbmNlIFJWMTI4
IGlzIGFuIGV4cGVyaW1lbnRhbCBmZWF0dXJlKS4NCj4gVG8gYXZvaWQgb3ZlcmxhcHMsIHdlIG5v
dyByZXF1aXJlIHRoYXQgbHEgaXMgZGVjb2RlZCBvbmx5IGlmDQo+IHJkIGlzIG5vdCAwLCBhcyBD
Qk8gcmVxdWlyZXMgdGhlIGZpZWxkIGNvcnJlc3BvbmRpbmcgdG8gcmQgdG8gYmUNCj4gemVybywN
Cj4gYm90aCBpbiBkYXNtIGFuZCBkZWNvZGV0cmVlLg0KPiANCj4gQ2hhbmdlcyBpbiB2MzoNCj4g
LSByZWJhc2Ugb24gbWFzdGVyDQo+IC0gc3F1YXNoIHRoZSAzIG9yaWdpbmFsIHBhdGNoZXMsIGF0
IHRoZXkgZGlkIG5vdCBtYWtlIHNlbnNlDQo+IMKgIGFueW1vcmUgYWZ0ZXIgcmViYXNpbmcNCj4g
DQo+IEZyw6lkw6lyaWMgUMOpdHJvdCAoMSk6DQo+IMKgIGRpc2FzL3Jpc2N2LmM6IENvcnJlY3Qg
ZGFzbSBmb3IgY2JvIGFuZCBscQ0KDQpUaGFua3MhDQoNCkFwcGxpZWQgdG8gcmlzY3YtdG8tYXBw
bHkubmV4dA0KDQpBbGlzdGFpcg0KDQo+IA0KPiDCoGRpc2FzL3Jpc2N2LmMgfCAxOCArKysrKysr
KysrLS0tLS0tLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgOCBkZWxl
dGlvbnMoLSkNCg==

