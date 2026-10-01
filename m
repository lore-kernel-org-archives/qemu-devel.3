Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A66CA5FCC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 05:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC97y-0006Ud-ED; Thu, 01 Oct 2026 01:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xC97o-0006TG-IR; Thu, 01 Oct 2026 01:14:33 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xC97m-0000s5-KP; Thu, 01 Oct 2026 01:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790831670; x=1822367670;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=E0AHV5HchqGsdfQ1mHSkf03vX45uugOu/Csv3XAAuXo=;
 b=NNLTEOqhsYPpCmAnVXEr20DPQi5CfL9MPF9EcA/TSEaYWiIJwOT/Q0Xh
 RGbEK3Au74DDXhTDLuu8M5+xTCB3U9CjwJxh2KexmN+tBxVibglVu9nQS
 01RhtF+KvXlRwbSl/yaHrO2Rzt+9cykKUOmyU/ZbD93/MCIymFYENk5r4
 RrHeVveu6AUNJ0wNC0rr/aHJzRPGwwRZjh1DZuR5l9NEOwJIeE38xcsyw
 Ypw1ctJ18b/er5BMKKYE8oDKFqPeawowgX3jFD+UJP2gGRuED6ImP0dpb
 GF4jl6YP0I45AA6Ps5uJjuXroGQ5g//RY72jeB9c1Zxd9V2cvrYj2/f9F g==;
X-CSE-ConnectionGUID: YhFr0xebRRKOaIEMpyF+eQ==
X-CSE-MsgGUID: 5fXr1i0QRIuu2/Sl/berwQ==
X-IronPort-AV: E=Sophos;i="6.27,134,1786982400"; d="scan'208";a="155408327"
Received: from mail-centralusazon11011061.outbound.protection.outlook.com
 (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.61])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 01 Oct 2026 13:14:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zn8f4H7CT7fNIe3TY/orHnTTKVb5vdE7jj2o2F2o18+f/OkmaqbrvaSMVWbjynYF67+gwWpxw752xDIJIbMlKgkmvoaKJjzbqD3mMgJQhlKRvk4p2STr7ZPolbdWckyojJKliGgEu/4oN3yIW/wYuCnnncPbSK8YcY1/Rs3DVGcUSxrGFkTixwQxCYQsSanH7+I3Cwar60Hpz8VNzzG1mXZxuMMcPSBT16qKXvmSsq57lLTzOtBhk/PmSGBpJ0+lTawS1faz78Wt57VzEOVeJqi/SrnLvJZPNaxknpibkY/GCs873Qep4Tuycw/7UIBbP0bJW2R9kL1GEVgovIH5Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0AHV5HchqGsdfQ1mHSkf03vX45uugOu/Csv3XAAuXo=;
 b=QZXMC0Nmq0O3A3OOUkeLY1E06a+EDFzu0h3Ow7P3SGeElNJCXGJM+HhXPS7id8qRKrm74hWg543YMTtc/79cE9U5PPpstqX7HrCzayU9ffcUQBXwLHlC2HX7OS7ZxD1KmRwgAQYwT8ZjnbjYoilSj5hn+HT9rd0lNZZiPBr4IU3t5mv2F7w2SqO23KZiUaV6OtnYy4FgVeBUrNXOmU1yeVVIqtOMjwggzrYJIcF/me8OyLyFWeLMSaQAx3+BRJachRj6QJDgyz9V+2TVuMbxX0Quj2t9bElde1pmpan7YtQJGVJLqkPfHTNH2WuPDpK2jVCDdDPjubanthh5hRMjMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0AHV5HchqGsdfQ1mHSkf03vX45uugOu/Csv3XAAuXo=;
 b=xA2KadiKzko26h6Y7Pbx4+HUWG5XieVJPT1JvOyxkmobGjf9BQNSihAPFhI8ZpOOKPlhYSK1JWdOUTe+oaDly0r95Dg+PQqe8fomaxS3cGzfLaQWUenX/qefcadpTaaCG333Nc/DBkHLqUNG3xn8giCbag4KR/ENpIPvduksJn4=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by DM6PR04MB7114.namprd04.prod.outlook.com (2603:10b6:5:243::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Thu, 1 Oct
 2026 05:14:14 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 05:14:13 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "tgamblin@baylibre.com" <tgamblin@baylibre.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2 2/2] target/riscv: add helper_tlb_flush_page(), use for
 sfence.vma with vaddr operand
Thread-Topic: [PATCH v2 2/2] target/riscv: add helper_tlb_flush_page(), use
 for sfence.vma with vaddr operand
Thread-Index: AQHdPJ0/NTWw/O/ViUWHJDX1b0jXTrboTiqA
Date: Thu, 1 Oct 2026 05:14:13 +0000
Message-ID: <322f18f233ae985970ba75eede7d3623110b13f3.camel@wdc.com>
References: <20260904-riscv_tlb_page_flush-v2-0-defec3f29312@baylibre.com>
 <20260904-riscv_tlb_page_flush-v2-2-defec3f29312@baylibre.com>
In-Reply-To: <20260904-riscv_tlb_page_flush-v2-2-defec3f29312@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|DM6PR04MB7114:EE_
x-ms-office365-filtering-correlation-id: 456f117f-a39f-4e58-b426-08df1f7ad593
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|366016|23010399003|376014|19092799006|1800799024|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: J+qUcwVD8tcMA9y5b8GsRXM/c+FB8/LVuzhD0yhTwBOFS57JobeImKDf29mfhFGq+UjM3JvZISBSOE7VglJcN81I35WQ7S2qzcdCi0S2urEOfesjJijjJsME8LsL5Ng7br7rLgAk8LW+Y80gx9zfKXFQq9zFI2hk7Yc3QF8BQ73lyGP9VbbblsJfgZXXth8t2TQnqvBtT98lhvy8xIs5QCfgYUVKb30LZgZQVuFAIyNqY0gNIFHVcZ/Os2BbS0We3Qxj2+k0rUSufxS/S/3spJgozGunQDBVn7CvQT2nRrBAwBr2rt+bBeeh9q1ZFdxwIlRJJrwF98SdBi/sYct+wM5PVqCUXWbms9TW2hCjQYYcQBPqbUnb2V5Yjqibyte8tnb8MyY2hJIG/cQVlva8S9ljDt25lYdjIio9oqOwWz1/nNvjEsDE0MITudw8zQCNAslb2QMd0VSd68F8Ep8EPc3VISclo6lGH7wVLEy9u8n1CRiKiHMB0R/Gsjg91f8915j5KbJfE/tXZvJdG/UJw86+LpoMZq1DDSJ3vKQa3VQV+awThQ/sF929oH6QlYStfzqB5hhw13xF0Y1iQR4qwH64K5y9izC23fnX+upHtGrQKs2Og27h3ajFDynSsjSjgTcGdY/jpSVdwejjAyJgjThogi/dmr0B/r40kEI2crIeHWMTXc+vt6TiDVZVf4KK9mriZzts6A4KKFqBfJ6K+4eUeuYhRLxKRQ2nmVdkyBI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(23010399003)(376014)(19092799006)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEdIR2VHYWVOMzhjNWt4OEF0ZGhHanZ5VWR0NmovSmc2cDI5Z2ZsZXJTdGti?=
 =?utf-8?B?aU9obCt3dXBtSTNCalZ1RWNpb2hyM3oveW55SFAvR0pMWE8wVVgzVjF5eGo4?=
 =?utf-8?B?WkZUNUVVT0pQcSs0SjZicExDcXZKZ3l5VnVhNWIxZStlY3pVQlNJVnJlMDdZ?=
 =?utf-8?B?WDBWV0NSQzA5VHpwWmlPZnVXeXhicWNhbkR1TDB0RU51TTIrT2Q4MWFLM3NF?=
 =?utf-8?B?dlZMZm9DTkFlSmZXTTFXVnI4VzEyWUpFcDcwZUN2RjAwcjV2aUJTcHFMajRj?=
 =?utf-8?B?Q2pRTjZGdjN3RkFwYkkxejV0OW80NW4rUUV2N21XVVVMQnk4ZWtGKzkybG4r?=
 =?utf-8?B?SGhYdHQzT1N3K2cyMzdjSk5MWkpKbmU0YlNKSXZwTzNIZzNRVzRLN3RSTmJt?=
 =?utf-8?B?OUQ0T0k1MmNPOVo3VGc0c0o2M0x1dUE5QzRuWjEzbzhEVjYrRi92ZVpaL3ZI?=
 =?utf-8?B?ZGFjMS9kY09ZYXNDenBSTHlxb1grczJwb0hPdFdicVhGcHhhVHdpTkxYUGI4?=
 =?utf-8?B?UVNLa05xSDRtRGdyRE9YTStQTStlVmpPU1M4emx0R1ZDVzFkdnVVWVU4amtX?=
 =?utf-8?B?TTVKTGQ3Sk9yWGNiRjkwNlNTK1BHODNiYksrTHR4ZmlRdHFPM3dRWm8yM1No?=
 =?utf-8?B?cEpSN1FvVWU5VnJSRHdjbktET3U2RHJac3NhRGJEZy9JNnVreDlXVGtya2hR?=
 =?utf-8?B?NDVPb2t1SnlQc1dKOEJ4YWl3TGlwTmVlanNjSHNRYkVKcHRIT3BZcThuZUVn?=
 =?utf-8?B?eC9BTlhOc2w1MVVGclhWOWZ5ekllbkRGTlR2RlNTN0MwMVlmZDY5czhqNWhy?=
 =?utf-8?B?WGRmVlBRbHczSFBtQzhYWGRUaEpmNnhvanFiV2tVdVlQMDVqU09GTHlCRXpK?=
 =?utf-8?B?a2U1UWg4UzZzVzRLeDBYV3M2eXlWb28xaXhBNVdjZ1owQ1B4TUhZVElSU3A3?=
 =?utf-8?B?bDZHVU8xQ0NGYWgwUXV5VzE0SHVZeEpKak1NSzZyTHFaYnJPL2ZzR1NLd2tQ?=
 =?utf-8?B?SkgyVllvRk55bGpPNlh0ZGJXNEdxaFNYeEhOalhNczMyT2ZPWTd2QXRqWFdl?=
 =?utf-8?B?R2VFbU1JMHFoMmFpSXgyUHRxSk1ITkpXNGFoNy95QVV3VEVSZHJHOGhGV1Jm?=
 =?utf-8?B?alE1U1VDSjZWUWVHRlZqSUdYL2dJZ1FsaEJFMkRoUTdzTEdla3BjcjhFTUFD?=
 =?utf-8?B?RHh4bTZRTU1BclZmV1VZaDVHTHc0YjJqLzFEYktrQXh5by9xRnJVUkhkSnNW?=
 =?utf-8?B?SEhjKzg2WmFtMERUbW00MlFNdlRRT054Z29ZMWZnNXVWNlBLaTRYSEV3aVJa?=
 =?utf-8?B?N3RjMVMreE91NEJuUFFXZWZCeVJVVUVuOFRpSU9xV0haU0htZ2tHQVVTR3RK?=
 =?utf-8?B?eGpRS1BvYXNGamNqQUliZytlK2kzRlBDbW1oRVhXYkV5eko0SGpwa0xTZVNO?=
 =?utf-8?B?cHpjL3ZnVjhGVC9mdkJ6TC8wZzYxM3hYcUgrOXQzdm5yYVErdUJWM3BvN0pR?=
 =?utf-8?B?Y3JWVFVsR2pGYndydVJLVDFXYVVSWUFtOXUxL205dHRDZjlwaGp1bHVIMGx3?=
 =?utf-8?B?V2M3Vkh1djVPYkJHNSs2alFISE5MUWgyQ21TYVcyUlZNN0VHSzh5dXA5ZVVP?=
 =?utf-8?B?SjRzZGhwRVJoTHNaK1lSN2ZVOFc2enNWNVlKaWswZm1Tdkc4dFJuK2NmbDZm?=
 =?utf-8?B?MCtVSlV6eWQ2dlJTeStwUTIyR3ROdVo3cmJ5bmVQbktWcTJTOEdlcnFyajlD?=
 =?utf-8?B?VWYvKzNsRUU5L1BmN1RmWU9FY0NhWDlNTzZwSm94ZGZnQjZmY3grYlRPYTQ1?=
 =?utf-8?B?NFNSMkdDOUVaS3ozSmRzSW9rS1Y2ZHVlSzRDeVhHN1psWUJZUzhSOCtwem5s?=
 =?utf-8?B?U3ppVXpuaHRGejIwL1pJcklFaTBPNFhRVmN3TlhYdyszamtaM3pRZnFtalNk?=
 =?utf-8?B?UWloQXl4YmFwemJ1N1UvMG1QSGt3NVgwNFVPOWFQWVhpOTlac1dyUU8zNnQr?=
 =?utf-8?B?bFlBQzlBbXJWdzZVM2diZ1h3SVppRzBuMTVIcnJNSnRaeWpoTk0xc0RMWmxH?=
 =?utf-8?B?SHN5NkZnRlNiOEsrY1IzRG1BY1R5VitHZG93R25tamxSTE9UYkJSdVZ6a2Iv?=
 =?utf-8?B?UGpBRFJqbHdOdFlQZWhZYXZJbW5ON1hZSitpSnRqaGpjdFpGOU51cDl1VG5G?=
 =?utf-8?B?NzROVkxmbGZuMlpBbDgzeEgyWFZDckxuaFgvdkllbFFnZzliYW5raTFqemdj?=
 =?utf-8?B?TnROSkI2Nmcwak5rd0cxODI5S0RER0F5ZGowTDUzdE11akxFdlN5ajdBbDEv?=
 =?utf-8?B?YjhDZzIyN0kyRE56b3ZtMVc5Y0ZxUWRnbFNKbXp4WW5XYktUTi9TakM5b2lj?=
 =?utf-8?Q?VTIOp6Xek0HLGmMk7JsT7qhJCdiHmaQibvMw/B6O/Qe1t?=
x-ms-exchange-antispam-messagedata-1: AtZd3XJWJdOv8mBeeOyHB2e8gT4OsvEw62g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DB986AD0012EA4B821BD8562249BB7E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kcSmWex58HEhoMX4FLr1GIQkIKbQzmO8r2vPS37TEoSaNaZ7Lqr+GBgWrsmsZXg+ICOqbQFb0elv5FFeqeePS3MttVyXh073NLiqIhLSrTGxG8Of7N1Dk6miclEIqW1XSe8+lh4v0dNeQzoPqw6R2CgY7H0zF/FEIVmRqbWOyQSXBhVhshyqqAZW9fiPDMu1cpLA2BjjBJlCOsCwIQB7xmkqqbtngWXr8ZUgci1IKw5mwZt68vODl278SpGLesqPH6oU217YpYLtas9W4JpPuMnH4dXNRqDK7hEbtwIPKo+96TSkn4NYhS7JRHnFtWQfJVu9Kz5x2AvWR6oAsStEnw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /JWEy7yGyj4pbhpEZGx6/tRG+gRlLyhRk3aesPIxG1BM94RMMGYX7tHofLskUvidQyNdl5eeO/7NCqsSpl6zD50WoiDq25Cv2wF9GCB/U1WVBlleoMyZLTGpTNhXSKLxbipogYD3KtVB4vJo/R+XT0EgBvAMUJ4RiXptomt1Sn78q2o52njleVgxMGhiLX0HbZ8fxpulc2kBk3AqUp/iLifCSmN14ZM2vsSa4rYOY0u1G3owQg9hGGHHylnqYUkvByf7zDN5a+Rusy4WJ96j+Hnucx7hVrXFCWVdYEibMgBqygviMxG4GMCR6n0hwczCePkNjGY/KAVhhXUPg8OBy7eyWk+xpK3kQNwh24F05y9uVdO8NpP9Klvb0wkgblyBi+dhJc0MpKxGZP5FBFJGv/EGSZmP5Ac/cY6iIzDnjZ3ONswaFM5IQeCwpbWJ40w6SLl4qC3qe/p00VPhZlij8zIniJfQ4uaQInQEfw9V5QnCILp2p7rQ+jVt6IukcDKVZGr6OKbYsZ0TUynjBcEFQy81Bh83BOT9dygBKdE2T1u1w7owdqqwwqsqdI7V/Xuoz0xHJ+xnk4CDNRL0B6+AlCu0cbnqQcbF20Kd/R0KICvE3TBVVsy7UwketTMzAtJG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456f117f-a39f-4e58-b426-08df1f7ad593
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 05:14:13.9326 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EsGextW2NUdtTqYcNCfT00fa3nJqiZnVwfDfmzTUXSv0eWlr/JdhwrFgLslj/7FNroE3Q9Wls2GE1A2yBDx0cnS5fqR+FB1kWOpsJSA0ld8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7114
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=727d860e1=Alistair.Francis@wdc.com;
 helo=esa6.hgst.iphmx.com
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

T24gRnJpLCAyMDI2LTA5LTA0IGF0IDE0OjQzIC0wNDAwLCBUcmV2b3IgR2FtYmxpbiB3cm90ZToN
Cj4gc2ZlbmNlLnZtYSB1bmNvbmRpdGlvbmFsbHkgY2FsbGVkIGhlbHBlcl90bGJfZmx1c2goKSwg
cmVnYXJkbGVzcyBvZg0KPiB0aGUNCj4gcnMxICh2YWRkcikgYW5kIHJzMiAoYXNpZCkgb3BlcmFu
ZHMsIGZvcmNpbmcgYSBwYWdlLXRhYmxlIHdhbGsgb24gdGhlDQo+IG5leHQgYWNjZXNzLiBDcmVh
dGUgYSBwYWdlLWxldmVsIGNvdW50ZXJwYXJ0IHRvIGhlbHBlcl90bGJfZmx1c2goKQ0KPiBjYWxs
ZWQgaGVscGVyX3RsYl9mbHVzaF9wYWdlKCksIGFuZCB1c2UgaXQgd2hlbmV2ZXIgcnMxICE9IDAs
IGZhbGxpbmcNCj4gYmFjayB0byB0aGUgZXhpc3RpbmcgZnVsbCBmbHVzaCBmb3IgcnMxID09IDAu
IFRoaXMgbWFrZXMgUklTQy1WDQo+IGJlaGF2aW91ciBtb3JlIHNpbWlsYXIgdG8gQVJNJ3MgZXF1
aXZhbGVudCAodGxiaV9hYTY0X3ZhZTFfd3JpdGUpLA0KPiB3aGljaA0KPiBhbHJlYWR5IGRvZXMg
dGxiX2ZsdXNoX3BhZ2VfYnlfbW11aWR4KCkgaW5zdGVhZCBvZiBhIGZ1bGwgZmx1c2guDQo+IA0K
PiBQYXNzIGdldF9hZGRyZXNzKGN0eCwgYS0+cnMxLCAwKSB0byBnZW5faGVscGVyX3RsYl9mbHVz
aF9wYWdlKCkNCj4gcmF0aGVyDQo+IHRoYW4gZ2V0X2dwcigpLCBzbyB0aGF0IHRoZSBhZGRyZXNz
IGJlaW5nIHBhc3NlZCBtYXRjaGVzIHRoZSBjdXJyZW50DQo+IGFkZHJfeGwgd2lkdGggcmVnYXJk
bGVzcyBvZiAnLWNwdScgaW5wdXQuIE90aGVyd2lzZSwgdGhlIHJhdyByZWdpc3Rlcg0KPiB2YWx1
ZSBjYW4gY2FycnkgZ2FyYmFnZSBhYm92ZSB0aGF0IHdpZHRoIGFuZCBuZXZlciBtYXRjaCB0aGUg
YWRkcmVzcw0KPiB0aGUNCj4gVExCIGVudHJ5IHdhcyBhY3R1YWxseSBmaWxsZWQgdW5kZXIsIHNv
IHRoZSBmbHVzaCBzaWxlbnRseSBtaXNzZXMgYW5kDQo+IGENCj4gc3RhbGUgbWFwcGluZyBzdXJ2
aXZlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRyZXZvciBHYW1ibGluIDx0Z2FtYmxpbkBiYXls
aWJyZS5jb20+DQoNClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFu
Y2lzQHdkYy5jb20+DQoNCkNhbiB5b3UgZml4dXAgc2ludmFsLnZtYSBhbmQgaGludmFsLiogYXMg
d2VsbCBwbGVhc2U/DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IMKgdGFyZ2V0L3Jpc2N2L2hlbHBl
ci5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8IDEgKw0KPiDCoHRhcmdldC9yaXNjdi90Y2cvaW5zbl90cmFucy90cmFuc19wcml2aWxl
Z2VkLmMuaW5jIHwgNiArKysrKy0NCj4gwqB0YXJnZXQvcmlzY3YvdGNnL29wX2hlbHBlci5jwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA2ICsrKysrKw0KPiDC
oDMgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9oZWxwZXIuaCBiL3RhcmdldC9yaXNjdi9oZWxwZXIu
aA0KPiBpbmRleCA0ZmMyZDNhMTU1Li42NTJmODVhNWM3IDEwMDY0NA0KPiAtLS0gYS90YXJnZXQv
cmlzY3YvaGVscGVyLmgNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2hlbHBlci5oDQo+IEBAIC0xMzcs
NiArMTM3LDcgQEAgREVGX0hFTFBFUl8xKGN0cl9jbGVhciwgdm9pZCwgZW52KQ0KPiDCoERFRl9I
RUxQRVJfMSh3ZmksIHZvaWQsIGVudikNCj4gwqBERUZfSEVMUEVSXzEod3JzX250bywgdm9pZCwg
ZW52KQ0KPiDCoERFRl9IRUxQRVJfMSh0bGJfZmx1c2gsIHZvaWQsIGVudikNCj4gK0RFRl9IRUxQ
RVJfMih0bGJfZmx1c2hfcGFnZSwgdm9pZCwgZW52LCB0bCkNCj4gwqBERUZfSEVMUEVSXzEodGxi
X2ZsdXNoX2FsbCwgdm9pZCwgZW52KQ0KPiDCoERFRl9IRUxQRVJfNChjdHJfYWRkX2VudHJ5LCB2
b2lkLCBlbnYsIHRsLCB0bCwgdGwpDQo+IMKgLyogTmF0aXZlIERlYnVnICovDQo+IGRpZmYgLS1n
aXQgYS90YXJnZXQvcmlzY3YvdGNnL2luc25fdHJhbnMvdHJhbnNfcHJpdmlsZWdlZC5jLmluYw0K
PiBiL3RhcmdldC9yaXNjdi90Y2cvaW5zbl90cmFucy90cmFuc19wcml2aWxlZ2VkLmMuaW5jDQo+
IGluZGV4IGE4ZWFjY2VmNjcuLjg2NTVmYTMzMmUgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9yaXNj
di90Y2cvaW5zbl90cmFucy90cmFuc19wcml2aWxlZ2VkLmMuaW5jDQo+ICsrKyBiL3RhcmdldC9y
aXNjdi90Y2cvaW5zbl90cmFucy90cmFuc19wcml2aWxlZ2VkLmMuaW5jDQo+IEBAIC0xNTUsNyAr
MTU1LDExIEBAIHN0YXRpYyBib29sIHRyYW5zX3NmZW5jZV92bWEoRGlzYXNDb250ZXh0ICpjdHgs
DQo+IGFyZ19zZmVuY2Vfdm1hICphKQ0KPiDCoHsNCj4gwqAjaWZuZGVmIENPTkZJR19VU0VSX09O
TFkNCj4gwqDCoMKgwqAgZGVjb2RlX3NhdmVfb3BjKGN0eCwgMCk7DQo+IC3CoMKgwqAgZ2VuX2hl
bHBlcl90bGJfZmx1c2godGNnX2Vudik7DQo+ICvCoMKgwqAgaWYgKGEtPnJzMSA9PSAwKSB7DQo+
ICvCoMKgwqDCoMKgwqDCoCBnZW5faGVscGVyX3RsYl9mbHVzaCh0Y2dfZW52KTsNCj4gK8KgwqDC
oCB9IGVsc2Ugew0KPiArwqDCoMKgwqDCoMKgwqAgZ2VuX2hlbHBlcl90bGJfZmx1c2hfcGFnZSh0
Y2dfZW52LCBnZXRfYWRkcmVzcyhjdHgsIGEtPnJzMSwNCj4gMCkpOw0KPiArwqDCoMKgIH0NCj4g
wqDCoMKgwqAgcmV0dXJuIHRydWU7DQo+IMKgI2VuZGlmDQo+IMKgwqDCoMKgIHJldHVybiBmYWxz
ZTsNCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi90Y2cvb3BfaGVscGVyLmMNCj4gYi90YXJn
ZXQvcmlzY3YvdGNnL29wX2hlbHBlci5jDQo+IGluZGV4IDdmNjNmM2FkYTUuLjE3OGI0ZDI3MWIg
MTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9yaXNjdi90Y2cvb3BfaGVscGVyLmMNCj4gKysrIGIvdGFy
Z2V0L3Jpc2N2L3RjZy9vcF9oZWxwZXIuYw0KPiBAQCAtNjA3LDYgKzYwNywxMiBAQCB2b2lkIGhl
bHBlcl90bGJfZmx1c2goQ1BVUklTQ1ZTdGF0ZSAqZW52KQ0KPiDCoMKgwqDCoCB0bGJfZmx1c2go
Y3MpOw0KPiDCoH0NCj4gwqANCj4gK3ZvaWQgaGVscGVyX3RsYl9mbHVzaF9wYWdlKENQVVJJU0NW
U3RhdGUgKmVudiwgdGFyZ2V0X3Vsb25nIGFkZHIpDQo+ICt7DQo+ICvCoMKgwqAgY2hlY2tfc2Zl
bmNlX3ZtYShlbnYsIEdFVFBDKCkpOw0KPiArwqDCoMKgIHRsYl9mbHVzaF9wYWdlKGVudl9jcHUo
ZW52KSwgYWRkcik7DQo+ICt9DQo+ICsNCj4gwqB2b2lkIGhlbHBlcl90bGJfZmx1c2hfYWxsKENQ
VVJJU0NWU3RhdGUgKmVudikNCj4gwqB7DQo+IMKgwqDCoMKgIENQVVN0YXRlICpjcyA9IGVudl9j
cHUoZW52KTsNCg==

