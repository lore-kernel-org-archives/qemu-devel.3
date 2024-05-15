Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1AAC25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 04:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s75uU-0000an-FZ; Wed, 15 May 2024 00:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1s75uB-0000Y1-3U; Wed, 15 May 2024 00:06:15 -0400
Received: from mail-psaapc01on20709.outbound.protection.outlook.com
 ([2a01:111:f400:feae::709]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1s75u7-0003gp-9Y; Wed, 15 May 2024 00:06:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWVLVxQ/RL2+7/SsqN4DmHiUAH8arIgEHKEHwxhir/kZ0NA9i0SLOHqj7IynodlOcJLQ04gqd1E6g5NPuWDIyx6lj++RLwtD6GMLO/N6HqhI1oRaD23xrBPaI2xl6QU2h1tN2hTvOuI8BBvIQMv1+sdLkqDCbceUYlDqz0sv728Z2aR5pejDsjbJRhfu+eNprEhdkfL/5AXe/FodIVfUvgZ1LY4PUUBhh1PWb2fxyXa+F5jxmK6BOLi3mN1rCZtCMVNqU8BBxN+9T0Ltc6sxuKrUWc3kmg0Nwm03gQ1EnzPiSUxRkIBNJkhga+5e7o9UuHqCHRJ+HNqf+fhpW1NAhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Onr4ljj0z+cIziognlzuTONlXcdMpi0F2I5nuW03q4=;
 b=WrIfFOhppwznDALrv1S3cbl5lHU/13puFyQEbJhrgISfx8BrOeBw5ziR7R/uruy8NkX9kA6pe3vu5i1wVB8myFv8cx9aoV1EV1INBea5LEgGRETAsIDW0mGoPnOIDrslGQ+3wqECN3rhse9t1OsYt23Gg3XybilK0u9KFsheRbMN2VN6sRf/NFI4he7bXPW0ihYt+2GnE/19iL6RDd+LCSNn6QgNax1LonZ3ufcCVLt2TdTvFZ6aUYYgmh9eSWF8V9vyO72U2DaJsRsk6/dt81mtgaTChyU+jeRxRndo/n9GHAfj4CMCYNImFmL1cbchVl6F4UwbbYIRUzUbPjVtsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Onr4ljj0z+cIziognlzuTONlXcdMpi0F2I5nuW03q4=;
 b=izNkBMPU4nyy07dp+ha7f2WAOxcY0oMkoDG+UaQ860IR+k89Eg5YH05J29jSyAUpGOrwTxVlwl+P7/OdbQMoepE1OsmWar5Ombrjrc+UwmGvN1sH8QalTv0Rzos1Wwt3IoU0h6VMYkzCgM/XDOTGkCHTquWtNYzlXBqeEvXAlu56/6nVt53n0VdTrvvzPF4JKV2t6sxQdsqlouQvbYEfF39dC1qHhvwNBZaMwTb3MeLfIgsne8lpR/GOP2CEec5ORx4jsVupwkrr2Bi9sI1Suo2gi8te7zgf/FKDWCZEY8f49K75oZBXIozn6YGyuvXT9QHwwk/Ox8elyKJ7kmGpGQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SI2PR06MB5410.apcprd06.prod.outlook.com (2603:1096:4:1ed::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Wed, 15 May 2024 04:05:57 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 04:05:56 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 Cleber Rosa <crosa@redhat.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v3 07/16] aspeed/smc: fix dma moving incorrect data length
 issue
Thread-Topic: [PATCH v3 07/16] aspeed/smc: fix dma moving incorrect data
 length issue
Thread-Index: AQHaj98nZO6QOpl6ikiVeDaw5PJCfbFvnuKAgBDflQCAAA0ZkIAFIw0AgBIdzHA=
Date: Wed, 15 May 2024 04:05:56 +0000
Message-ID: <SI2PR06MB5041697205A43EAAA21AD68FFCEC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240416091904.935283-1-jamin_lin@aspeedtech.com>
 <20240416091904.935283-8-jamin_lin@aspeedtech.com>
 <90a930b9-ec7f-47fc-bfc9-f4ac0958ef83@kaod.org>
 <cd94d997-8989-4518-ac9f-ab6a544ba77e@kaod.org>
 <SI2PR06MB504122AE11599095D521AA4AFC1A2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <39abc9f5-7f5f-4361-954c-489842c0bfd0@kaod.org>
In-Reply-To: <39abc9f5-7f5f-4361-954c-489842c0bfd0@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SI2PR06MB5410:EE_
x-ms-office365-filtering-correlation-id: 881abb3f-d765-45e8-a442-08dc74945271
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|7416005|1800799015|376005|921011|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?ZkMzZEpiNUs0c0d1K29xYkFGbExFZFZPbFcvK2IzdWdIRnRKNjVaZVJ4Zm5P?=
 =?utf-8?B?NDBHSUw0anAvSVdRMDd5MlBoL2pQenVMaHArb09ZdngvNCtCaG5vRmdEQUE0?=
 =?utf-8?B?L013bndySy9jQVk2NC9LS2xtMmpvNG9rOWJtVFJETWFDWDdBTmFnNjY2NGVw?=
 =?utf-8?B?ajBHcEdkV3hpTCtGODdLdXNpYlVyY2d2ZGRXVXp0Q2xmMEpZSTgzU1N2cWpt?=
 =?utf-8?B?Z1NoYVRpYkhNYU9idFNNeDRDRFNZbzlTUmUyelNNV2x1Q2xwUlpZQWJ0ZGVR?=
 =?utf-8?B?U0I4VlY4T1Qra3pnTzNXZ3l2cTkydnJTMzRvL1V3akxHVncza2pETXltQThI?=
 =?utf-8?B?NkUveEVIdk5PY0tXTm9PZHc5c0FMN1hRRUxWVmdkT1lXOCtyZWRsSHc4Yloy?=
 =?utf-8?B?WEk1RmJQSk5oNDhOZTZHd3ZvZ2tycGhUTlVUcFpEUFgwL1hpUmNPUXVHN2tm?=
 =?utf-8?B?RjZwRVlGbk5xb1dWU3hTMXh4UU91OTRZSmxFaWhBOGdBdTN6ZDVMaW5WTWtZ?=
 =?utf-8?B?S3NNdmZGci9pY3VBYmxaYVN5OGVRdVhjeWkvNWRUcmwyOWZiZDk1UGF3NDdi?=
 =?utf-8?B?bnROY2V1WndWa2RsYWsxYStuWXhiNkVFdXBNMDZ3a2FNNTMra1JVMmVRSk5p?=
 =?utf-8?B?dkRmODJUeHR4U2lITXJXZ2lqUkFKdWtOdWhxNUFRWkxoOWtrL01GSWlQb2pW?=
 =?utf-8?B?aVNFR01sSEFtSk5Fazh2UlhCdkpYaWJpSW5QbzVKWXhISy9leW5vYkRlQUY1?=
 =?utf-8?B?aTFNZXVlVktXYmF6cGtaa0tjdnFsRmFTWWIzNFBHeU1rSEZYZmJLU0hWTm9l?=
 =?utf-8?B?WGJFaGdtWVN2RjRMeE1rVndlajJVa3B6VVdnbkJFb2x5ZkhodUJSaWloK3hY?=
 =?utf-8?B?dk0zcVl6MGsyL0s2UUMvYlhoSVFwZXJtMHcrYjlGQ09wekQvWUhuT0VKb09V?=
 =?utf-8?B?bFpXb0FoR3d4cy9aWXZLZlJUYVUrRHA1UGtzQkkvdG8zQm5CU1Q3NzBoMUd2?=
 =?utf-8?B?WjUrL29TNjRjN1Y0aWRnRDRXUjd3MHZhM1lmSGQrQmZ6SnUya09uVE1Ndkdi?=
 =?utf-8?B?YzA5Mkdqdnl6NThVdXV0V01SeDB2aWlkNENvZFdRdkxGRks2NlcxZlgyQjlF?=
 =?utf-8?B?ZFZ3eHlwMUFpcUlzNGZBMHNSVDFCNlJ0Q3ltUTJVTXZWMk9Gc3ZYelBsaEpP?=
 =?utf-8?B?TWI5VERUa3dSQm9VY2M4blJ1NjlaUTBsOGk1RE9RNmpRcXVrOEVUTFI5ak8y?=
 =?utf-8?B?N3NSOXRlTWNIeDV6T1JmWTFXUGc4bHBnUDlXSkRkREY1Tk9ZcG5ZaXBkNkRh?=
 =?utf-8?B?Z28xdDYrcEg1WXBBR3NPNUVTcTlJMnliVU9PRDdydFlodTk3STVjaUJHWGNy?=
 =?utf-8?B?VHlyVWZOeEs0RnpmdXB1K2ZqWk9vNFNsd2toUDRMYyswZ1hLdXRjeFZxWThZ?=
 =?utf-8?B?UjJoSENhamgwNlFSVUh0anFqa2c3dkxIMDdFemRqNXFXQ1k3WG8ra3dlaERU?=
 =?utf-8?B?U1pJaHdWcEdKL1VHWkljNFQzM0FwV0ZQK25WcmkzM293OW81bjUvb0tWclNI?=
 =?utf-8?B?VlMvRkdJTEx1V2hBeFc0NDRtUWlxWHdYc2lLK3JRd0dNeHI5SlYyYTFDT3Zs?=
 =?utf-8?B?b3NpVEFmZVJqdGRNS0cxUDRQVDhOSnI4ckI0MVdVY213c1VEdy8venF3VlYw?=
 =?utf-8?B?ajZEVzB6amErS0t5TUx6ZWVpcWVLMkkyNWM4a1dqWGplYW1uSGR2K3pyMXhr?=
 =?utf-8?Q?W97Vt0gq8nEfdboxBg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230031)(366007)(7416005)(1800799015)(376005)(921011)(38070700009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlZIK0JZb3pkVnpaRWNza3hocFlUNS9HaEFLbGxtd0NmZ1NkYlkrWFpmbWZN?=
 =?utf-8?B?b1pZYy8vb2V4K09QUDZIVFV4R0pneVU5QW55dHNUcjd5M1NVUTlpWFc3c1p2?=
 =?utf-8?B?ZUJjckZFZUlzRmMyRURBanpVajdRSzFCQ3NsZlo3TlhyWklCR0VYekdvYnc5?=
 =?utf-8?B?aHM5Y2JpK0VNcjgxL0VWc3VzZjFyOTBRNmdRSFN2RVVhT1pCUG84VzFYZkRa?=
 =?utf-8?B?aER4RDN1SDNvL1JmNmJIMlRUR1J6RzZSeUp4aGpRVmYvUWphUnhKaEhpT1Mv?=
 =?utf-8?B?UCtZZ2szc2xXRm9MbFZ0Umx3citWVWJsTk1JZEV2UUMvazd2UGJET0F6eTJ5?=
 =?utf-8?B?QVVqTmVSMHdvTUdrTTMwYk1aMDh0U1lxdCtqalJZZlpJUG1ERUlsQk5hSlRi?=
 =?utf-8?B?MU5xOFA5YS8vQXpONnl6N3dBenNjLzFIdFlpdEtqMEF2dmNlNXBjcHY2bXRD?=
 =?utf-8?B?ck0rcy9vWlZTZGJuRnl6T3V1SzYrWDNQVkw1TWNTQXllS3BjTmJKOE5abDJU?=
 =?utf-8?B?dTM1MXhmcVpMVFRlYTZuYTBBZHRHV21EN1Nnc1ZSZzdRTTBoQjZUaGlQUmxV?=
 =?utf-8?B?bCs0d0Z6Z0pZYmoydC9VUGljMGFvMDlsR0VWTmRvWjFjTTMreURZYjdBQVFv?=
 =?utf-8?B?STJZR29xM2d2UUZ3NGJ6c1gvcmNIeDF5QlFSUkwraTVGREE3Z1hEZ2FveDJx?=
 =?utf-8?B?aFNNNW1KbVhwajlBa21lK1VkQ25FWmFKUVdEeXJ6SUl6a21zMUFtSW9ZVzZu?=
 =?utf-8?B?U2FoWnQzMlppZXRKaDV2cDZhNXFZOWo4YzgxbG5sNjh0b3BkWUdBb2JzOG1j?=
 =?utf-8?B?UTBUWGUyQnpqWnNyTU5sakNyeTlBMHQ2ekxwWmFKUHlFZzliT3luWjdxY0NE?=
 =?utf-8?B?UHliRmVsKzBPNFowaXYyTTY5SlZrVzQ1VFRCVjUwa2dGZHBqOUo1eUMwL1dy?=
 =?utf-8?B?cXVENjN5aUdleEZFaGxwUEVlRXgwQTRBQUF4MWJ6SHZiQnA0R2VVaFdhTDRh?=
 =?utf-8?B?NlRSZVo3SWk0dDYvWTl3NVJ6TURNVmN4S0FveGdiZkV6VGJKaTRINTJkRlNL?=
 =?utf-8?B?MGJtK2k0SEhLWFR6WU5oOUVxbEZuYklsQy94ZHVKSGY5dUhTTEJWRDh1Q0c0?=
 =?utf-8?B?cGtncG1PaXRKQmppaVM5dU5Qd2FrLzNIU3g0QVkrVXphZWI0ZXNlSlRwbTJx?=
 =?utf-8?B?Uzl0ZFJGcEpiVUF4Wm0vV2h4TWY2M3BBK05pRHU5YytSeG5MZmwxbG5WZzVx?=
 =?utf-8?B?Q3BROXVsdEVCYzdQZzdWSlFCc01CTXVpSk1uS1R3NEFpMEJxTHYwMXpKUkVD?=
 =?utf-8?B?bGYzUzhzbSs4VUQ4MXRhR1U3aiszNUdVdndHN1BYeXB1NUJMSlZzd3ZqQ3VY?=
 =?utf-8?B?VWJPYWlDS1BkL21BYlc2VVhIRFhSWSswNS9laWNNU2dlR2Zpa05GeTlycks1?=
 =?utf-8?B?c1p2T2ljbVhrb2gvZDJrMGRneUZybXhVWkhPZjFiZjNPbWMyNm4vb2ZpZ29q?=
 =?utf-8?B?Nk5xckhSczYxcUJxTWE0UjduRFZMMGthSzZxRmpWZHRyTmZPQUx4MkR5TEtJ?=
 =?utf-8?B?K0lPMVpvOCt2d2pMQ3ZIdDRKSHZpaVlSZDVPUHBWMm16YzNSOWczYlNEV01C?=
 =?utf-8?B?N0NrbVh0SE83ZlVyYzVUS0hPSjUxS0NUN1lhaThDd3VxTkxzbTFPYXEvTC9V?=
 =?utf-8?B?cllSTjZ0ZkVFNCtXN0FIc29sYzFTdlI0aFk1MmxLZkpPZU9HT2RGSmNjN25C?=
 =?utf-8?B?TXMySzM4SE9tYVdaaVpqcmJyT2tISHUyeWpvWEJ0ZnlNZXp2d0hVQmcxZ3V4?=
 =?utf-8?B?V3BNdGlNZmxGdFRZUmZFYTJ3RGtuUVVwSVRuMU1WOHZlSm1FVWFxajRueGw2?=
 =?utf-8?B?ZG0wc09lS2xFUHN3S0xieUVoQzE4NFFaMG1RTGxLWVE1YXBXUTBqalBqZW1M?=
 =?utf-8?B?VWhRMXFDdmZ0Rk1vNWVxMWRHbE9ZNCtmZGhBNmk3TTlvanRHNlFVSXVYcGoz?=
 =?utf-8?B?TVNldkkvZFdRYVFCcjh6Yk8wWFZNYzQyN2kvUXJtbThKekxOZ3MrdndzNHZT?=
 =?utf-8?B?Ris0bmxVN3ZjcjQzN05tN1dOZVhhMnZTRWJJenhPSHg5eFJPZ0NmKy8zRS9z?=
 =?utf-8?Q?7l1sGTJqHzZS8xcRZ5QairQRx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 881abb3f-d765-45e8-a442-08dc74945271
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 04:05:56.6336 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SytFdlCc8H731KDJVntLw1bWYKH/eY5E0NUJ2TYLRwweqcPwOtwYGNkhEhMOWssWwAc8iuXMRVakSjBosrEkkHlRcrmJ/HLZ+6h4mbfDvvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5410
Received-SPF: pass client-ip=2a01:111:f400:feae::709;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
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

SGkgQ2VkcmljLA0KDQpTb3JyeSByZXBseSB5b3UgbGF0ZS4NCj4gT24gNC8zMC8yNCAxMDo1MSwg
SmFtaW4gTGluIHdyb3RlOg0KPiA+IEhpIENlZHJpYywNCj4gPj4gT24gNC8xOS8yNCAxNTo0MSwg
Q8OpZHJpYyBMZSBHb2F0ZXIgd3JvdGU6DQo+ID4+PiBPbiA0LzE2LzI0IDExOjE4LCBKYW1pbiBM
aW4gd3JvdGU6DQo+ID4+Pj4gRE1BIGxlbmd0aCBpcyBmcm9tIDEgYnl0ZSB0byAzMk1CIGZvciBB
U1QyNjAwIGFuZCBBU1QxMHgwIGFuZCBETUENCj4gPj4+PiBsZW5ndGggaXMgZnJvbSA0IGJ5dGVz
IHRvIDMyTUIgZm9yIEFTVDI1MDAuDQo+ID4+Pj4NCj4gPj4+PiBJbiBvdGhlciB3b3JkcywgaWYg
IlJfRE1BX0xFTiIgaXMgMCwgaXQgc2hvdWxkIG1vdmUgYXQgbGVhc3QgMSBieXRlDQo+ID4+Pj4g
ZGF0YSBmb3IgQVNUMjYwMCBhbmQgQVNUMTB4MCBhbmQgNCBieXRlcyBkYXRhIGZvciBBU1QyNTAw
Lg0KPiA+Pj4+PiBUbyBzdXBwb3J0IGFsbCBBU1BFRUQgU09DcywgYWRkcyBkbWFfc3RhcnRfbGVu
Z3RoIHBhcmFtZXRlciB0bw0KPiA+Pj4+PiBzdG9yZQ0KPiA+Pj4+IHRoZSBzdGFydCBsZW5ndGgs
IGFkZCBoZWxwZXIgcm91dGluZXMgZnVuY3Rpb24gdG8gY29tcHV0ZSB0aGUgZG1hDQo+ID4+Pj4g
bGVuZ3RoIGFuZCB1cGRhdGUgRE1BX0xFTkdUSCBtYXNrIHRvICIxRkZGRkZGIiB0byBmaXggZG1h
IG1vdmluZw0KPiA+Pj4+IGluY29ycmVjdCBkYXRhIGxlbmd0aCBpc3N1ZS4NCj4gPj4+DQo+ID4+
PiBPSy4gVGhlcmUgYXJlIHR3byBwcm9ibGVtcyB0byBhZGRyZXNzLCB0aGUgInplcm8iIGxlbmd0
aCB0cmFuc2Zlcg0KPiA+Pj4gYW5kIHRoZSBETUEgbGVuZ3RoIHVuaXQsIHdoaWNoIGlzIG1pc3Np
bmcgdG9kYXkuIE5ld2VyIFNvQyB1c2UgYSAxDQo+ID4+PiBiaXQgLyBieXRlIGFuZCBvbGRlciBv
bmVzLCBBU1QyNDAwIGFuZCBBU1QyNTAwLCB1c2UgMSBiaXQgLyA0IGJ5dGVzLg0KPiA+Pj4NCj4g
Pj4+IFdlIGNhbiBpbnRyb2R1Y2UgYSBBc3BlZWRTTUNDbGFzczo6ZG1hX2xlbl91bml0IGFuZCBy
ZXdvcmsgdGhlIGxvb3ANCj4gdG8gOg0KPiA+Pj4NCj4gPj4+ICAgwqDCoMKgIGRvIHsNCj4gPj4+
DQo+ID4+PiAgIMKgwqDCoMKgwqAgLi4uLg0KPiA+Pj4NCj4gPj4+ICAgwqDCoMKgwqDCoMKgIGlm
IChzLT5yZWdzW1JfRE1BX0xFTl0pIHsNCj4gPj4+ICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
LT5yZWdzW1JfRE1BX0xFTl0gLT0gNCAvIGFzYy0+ZG1hX2xlbl91bml0Ow0KPiA+Pj4gICDCoMKg
wqDCoMKgwqDCoCB9DQo+ID4+PiAgIMKgwqDCoCB9IHdoaWxlIChzLT5yZWdzW1JfRE1BX0xFTl0p
Ow0KPiA+Pj4NCj4gPj4+IEl0IHNob3VsZCBmaXggdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24u
DQo+ID4+DQo+ID4+DQo+ID4+IEkgY2hlY2tlZCB3aGF0IEZXIGlzIGRvaW5nIG9uIGEgUUVNVSBh
c3QyNTAwLWV2YiBtYWNoaW5lIDoNCj4gPj4NCj4gPj4gICAgICAgVS1Cb290IDIwMTkuMDQtdjAw
LjA0LjEyIChTZXAgMjkgMjAyMiAtIDEwOjQwOjM3ICswMDAwKQ0KPiA+PiAgICAgICAuLi4NCj4g
Pj4NCj4gPj4gICAgICAgICAgTG9hZGluZyBLZXJuZWwgSW1hZ2UgLi4uIGFzcGVlZF9zbWNfd3Jp
dGUgQDB4ODggc2l6ZSA0Og0KPiA+PiAweDgwMDAxMDAwDQo+ID4+ICAgICAgIGFzcGVlZF9zbWNf
d3JpdGUgQDB4ODQgc2l6ZSA0OiAweDIwMTAwMTMwDQo+ID4+ICAgICAgIGFzcGVlZF9zbWNfd3Jp
dGUgQDB4OGMgc2l6ZSA0OiAweDNjNjc3MA0KPiA+PiAgICAgICBhc3BlZWRfc21jX3dyaXRlIEAw
eDgwIHNpemUgNDogMHgxDQo+ID4+ICAgICAgIGFzcGVlZF9zbWNfZG1hX3J3IHJlYWQgZmxhc2g6
QDB4MDAxMDAxMzAgZHJhbTpAMHgxMDAwDQo+ID4+IHNpemU6MHgwMDNjNjc3NA0KPiA+PiAgICAg
ICBhc3BlZWRfc21jX3JlYWQgQDB4OCBzaXplIDQ6IDB4ODAwDQo+ID4+ICAgICAgIGFzcGVlZF9z
bWNfd3JpdGUgQDB4ODAgc2l6ZSA0OiAweDANCj4gPj4gICAgICAgT0sNCj4gPj4gICAgICAgICAg
TG9hZGluZyBSYW1kaXNrIHRvIDhmZWYyMDAwLCBlbmQgOGZmZmY2MDQgLi4uDQo+ID4+IGFzcGVl
ZF9zbWNfd3JpdGUNCj4gPj4gQDB4ODggc2l6ZSA0OiAweDhmZWYyMDAwDQo+ID4+ICAgICAgIGFz
cGVlZF9zbWNfd3JpdGUgQDB4ODQgc2l6ZSA0OiAweDIwNGNkZGUwDQo+ID4+ICAgICAgIGFzcGVl
ZF9zbWNfd3JpdGUgQDB4OGMgc2l6ZSA0OiAweDEwZDYwNA0KPiA+PiAgICAgICBhc3BlZWRfc21j
X3dyaXRlIEAweDgwIHNpemUgNDogMHgxDQo+ID4+ICAgICAgIGFzcGVlZF9zbWNfZG1hX3J3IHJl
YWQgZmxhc2g6QDB4MDA0Y2RkZTAgZHJhbTpAMHhmZWYyMDAwDQo+ID4+IHNpemU6MHgwMDEwZDYw
OA0KPiA+PiAgICAgICBhc3BlZWRfc21jX3JlYWQgQDB4OCBzaXplIDQ6IDB4ODAwDQo+ID4+ICAg
ICAgIGFzcGVlZF9zbWNfd3JpdGUgQDB4ODAgc2l6ZSA0OiAweDANCj4gPj4gICAgICAgT0sNCj4g
Pj4gICAgICAgICAgTG9hZGluZyBEZXZpY2UgVHJlZSB0byA4ZmVlNzAwMCwgZW5kIDhmZWYxMzVl
IC4uLg0KPiA+PiBhc3BlZWRfc21jX3dyaXRlDQo+ID4+IEAweDg4IHNpemUgNDogMHg4ZmVlNzAw
MA0KPiA+PiAgICAgICBhc3BlZWRfc21jX3dyaXRlIEAweDg0IHNpemUgNDogMHgyMDRjNjliNA0K
PiA+PiAgICAgICBhc3BlZWRfc21jX3dyaXRlIEAweDhjIHNpemUgNDogMHg3MzYwDQo+ID4+ICAg
ICAgIGFzcGVlZF9zbWNfd3JpdGUgQDB4ODAgc2l6ZSA0OiAweDENCj4gPj4gICAgICAgYXNwZWVk
X3NtY19kbWFfcncgcmVhZCBmbGFzaDpAMHgwMDRjNjliNCBkcmFtOkAweGZlZTcwMDANCj4gPj4g
c2l6ZToweDAwMDA3MzY0DQo+ID4+ICAgICAgIGFzcGVlZF9zbWNfcmVhZCBAMHg4IHNpemUgNDog
MHg4MDANCj4gPj4gICAgICAgYXNwZWVkX3NtY193cml0ZSBAMHg4MCBzaXplIDQ6IDB4MA0KPiA+
PiAgICAgICBPSw0KPiA+Pg0KPiA+PiAgICAgICBTdGFydGluZyBrZXJuZWwgLi4uDQo+ID4+DQo+
ID4+IEl0IHNlZW1zIHRoYXQgdGhlIFJfRE1BX0xFTiByZWdpc3RlciBpcyBzZXQgYnkgRlcgd2l0
aG91dCB0YWtpbmcgaW50bw0KPiA+PiBhY2NvdW50IHRoZSBsZW5ndGggdW5pdCAoIGJpdCAvIDQg
Ynl0ZXMpLiBXb3VsZCB5b3Uga25vdyB3aHkgPw0KPiA+Pg0KQWZ0ZXIgSSBkaXNjdXNzZWQgd2l0
aCBkZXNpZ25lcnMsIG15IGV4cGxhbmF0aW9uIGFzIGJlbG93Lg0KQVNUMjUwMCBkYXRhc2hlZXQg
ZGVzY3JpcHRpb246DQpGTUM4QzogRE1BIExlbmd0aCBSZWdpc3Rlcg0KMzE6MjUgICAgICBSZXNl
cnZlZCgwKQ0KMjQ6MiAgUlcgIERNQV9MRU5HVEgNCiAgICAgICAgICBGcm9tIDRieXRlcyB0byAz
Mk1CDQogICAgICAgICAgMDogNGJ5dGVzDQogICAgICAgICAgMHg3RkZGRkY6IDMyTUINCjE6MCAg
ICAgICBSZXNlcnZlZA0KDQpJZiB1c2VycyBzZXQgdGhpcyByZWdpc3RlciAwLCBTUEkgRE1BIGNv
bnRyb2xsZXIgd291bGQgbW92ZSA0IGJ5dGVzIGRhdGEuDQpJZiB1c2VycyBzZXQgdGhpcyByZWdp
c3RlciBiaXRzWzI0OjJdIDB4N0ZGRkZGLCBTUEkgRE1DIGNvbnRyb2xsZXIgd291bGQgbW92ZSAz
Mk1CIGRhdGEgYmVjYXVzZSB0aGlzIHJlZ2lzdGVyIGluY2x1ZGVzIHJlc2VydmVkIGJpdHMgWzE6
MF0uDQpFeDogYml0cyAyNDoyIC0tPiAweDdmZmZmZg0KICAgYml0cyAxOjAgLS0+IDAgUmVzZXJ2
ZWQgIA0KYml0c1syNDowXSBpcyAoMHgxRkZGRkZDICsgc3RhcnQgbGVuZ3RoIDQpIC0tPiAyMDAw
MDAwIC0tPiAzMk1CICANCiAgICAgICAgICAgMTExIDExMTEgMTExMSAxMTExIDExMTEgMTExMSAg
MDANCkxFTkdUSFsyNDoyXSA3ICAgRiAgICBGICAgRiAgIEYgICAgRiAgICBSZXNlcnZlZCBbMTow
XQ0KDQpUaGF0IHdhcyB3aHkgQVNUMjUwMCBETUEgbGVuZ3RoIHNob3VsZCA0IGJ5dGVzIGFsaWdu
bWVudCBhbmQgeW91IGRvIG5vdCBzZWUgaGFuZGxpbmcgbGVuZ3RoIHVuaXRzIGJlY2F1c2UgaXQg
aW5jbHVkZXMgcmVzZXJ2ZWQgYml0cyAxIGFuZCAwLg0KSWYgdXNlciB3YW50IHRvIG1vdmUgMyBi
eXRlcyBkYXRhLCBvdXIgZmlybXdhcmUgc2V0IHRoaXMgcmVnaXN0ZXIgNCBlbnN1cmUgaXQgNGJ5
dGVzIGFsaWdubWVudCBhbmQgdGhlIHZhbHVlIG9mIHJlZ2lzdGVyIGFzIGZvbGxvd2luZw0KYml0
c1syOjBdID0gImIxMDAiIEZpbmFsbHksIFNQSSBETUEgY29udHJvbGxlciBtb3ZlIDggYnl0ZXMg
ZGF0YSg0Ynl0ZXMgaW5wdXQgY291bnQgKyBzdGFydCBsZW5ndGggNGJ5dGVzKSANCg0KQW5kIHRo
YXQgd2FzIHdoeSBpdCBzZXQgRE1BX0xFTkdUSCAweDAxRkZGRkZDDQpodHRwczovL2dpdGh1Yi5j
b20vcWVtdS9xZW11L2Jsb2IvbWFzdGVyL2h3L3NzaS9hc3BlZWRfc21jLmMjTDE4Nw0KI2RlZmlu
ZSBETUFfTEVOR1RIKHZhbCkgICAgICAgICAoKHZhbCkgJiAweDAxRkZGRkZDKQ0KDQpJIHdhbnQg
dG8gY2hhbmdlIGl0IHRvIDB4MDFGRkZGRkYgdG8gc3VwcG9ydCBhbGwgQVNQRUVEIFNPQ3MgYmVj
YXVzZSBBU1QyNjAwLCBBU1QyNzAwIGFuZCBBU1QxMDMwIHVzZSB0aGlzIHJlZ2lzdGVyIGJpdCAw
IGFuZCAxIHdob3NlIHVuaXQgaXMgMWJ5dGUgcmF0aGVyIHRoYW4gNCBieXRlcy4NCg0KPiA+IGh0
dHBzOi8vZ2l0aHViLmNvbS9Bc3BlZWRUZWNoLUJNQy91LWJvb3QvYmxvYi9hc3BlZWQtbWFzdGVy
LXYyMDE5LjA0L2wNCj4gPiBpYi9zdHJpbmcuYyNMNTU5IFRoaXMgbGluZSBtYWtlIHVzZXIgaW5w
dXQgZGF0YSBsZW5ndGggNCBieXRlcw0KPiA+IGFsaWdubWVudC4NCj4gPg0KPiBodHRwczovL2dp
dGh1Yi5jb20vQXNwZWVkVGVjaC1CTUMvdS1ib290L2Jsb2IvYXNwZWVkLW1hc3Rlci12MjAxOS4w
NC9hDQo+ID4gcmNoL2FybS9tYWNoLWFzcGVlZC9hc3QyNTAwL3V0aWxzLlMjTDM1DQo+IA0KPiB5
ZXMuIEkgZG9uJ3Qgc2VlIGFueSAxYml0IC8gNGJ5dGVzIGNvbnZlcnNpb24gd2hlbiBzZXR0aW5n
IHRoZSBETUFfTEVODQo+IHJlZ2lzdGVyLiBBbSBJIG1pc3Rha2luZyA/IFRoYXQncyBub3Qgd2hh
dCB0aGUgc3BlY3Mgc2F5cy4NCj4gDQo+ID4gVGhpcyBsaW5lIHNldCB0aGUgdmFsdWUgb2YgY291
bnQgcGFyYW1ldGVyIHRvIEFTVF9GTUNfRE5BX0xFTkdUSC4NCj4gPiBBU1RfRk1DX0RNQV9MRU5H
VEggaXMgNCBieXRlcyBhbGlnbm1lbnQgdmFsdWUuDQo+ID4gRXhhbXBsZTogaW5wdXQgNA0KPiA+
ICgoNCszKS80KSAqIDQgLS0+ICg3LzQpICo0IC0tLT4gNA0KPiA+IElmIEFTVF9GTUNfRE1BX0xF
TkdUSCBpcyAwLCBpdCBtZWFucyBpdCBzaG91bGQgbW92ZSA0IGJ5dGVzIGRhdGEgYW5kDQo+IEFT
VF9GTUNfRE1BX0xFTkdUSCBkbyBub3QgbmVlZCB0byBiZSBkaXZpZGVkIGJ5IDQuDQo+IA0KPiBv
ay4gRm9yIHRoYXQsIEkgdGhpbmsgeW91IGNvdWxkIHJlcGxhY2UgYXNwZWVkX3NtY19kbWFfbGVu
KCkgd2l0aA0KPiANCj4gICAgIHJldHVybiBRRU1VX0FMSUdOX1VQKHMtPnJlZ3NbUl9ETUFfTEVO
XSArIGFzYy0+ZG1hX3N0YXJ0X2xlbmd0aCwNCj4gNCk7DQo+IA0KVGhhbmtzIGZvciB5b3VyIHN1
Z2dlc3Rpb24gYW5kIHdpbGwgZml4IGl0Lg0KDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KPiAN
Cj4gDQo+ID4NCj4gPj4gSWYgSSBjaGFuZ2UgdGhlIG1vZGVsIHRvIG1hdGNoIDEgYml0IC8gNCBi
eXRlcyB1bml0IG9mIHRoZSBSX0RNQV9MRU4NCj4gcmVnaXN0ZXIuDQo+ID4+IExpbnV4IGZhaWxz
IHRvIGJvb3QuIEkgZGlkbid0IGRpZyBmdXJ0aGVyIGFuZCB0aGlzIGlzIHNvbWV0aGluZyB3ZQ0K
PiA+PiBuZWVkIHRvIHVuZGVyc3RhbmQgYmVmb3JlIGNvbW1pdHRpbmcuDQo+ID4+DQo+ID4+PiBJ
IGRvbid0IHRoaW5rIHRoaXMgaXMgbmVjZXNzYXJ5IHRvIGFkZCBhIEZpeGVzIHRhZyBiZWNhdXNl
IHRoZQ0KPiA+Pj4gcHJvYmxlbSBoYXMgYmVlbiB0aGVyZSBmb3IgYWdlcyBhbmQgbm8gb25lIHJl
cG9ydGVkIGl0LiBQcm9iYWJseQ0KPiA+Pj4gYmVjYXVzZSB0aGUgb25seSBwbGFjZSBETUEgdHJh
bnNmZXJzIGFyZSB1c2VkIGlzIGluIFUtQm9vdCBhbmQNCj4gPj4+IHRyYW5zZmVycyBoYXZlIGEg
bm9uLXplcm8gbGVuZ3RoLg0KPiA+Pj4NCj4gPj4+PiBDdXJyZW50bHksIG9ubHkgc3VwcG9ydHMg
ZG1hIGxlbmd0aCA0IGJ5dGVzIGFsaWduZWQuDQo+ID4+DQo+ID4+IElzIHRoaXMgNCBieXRlcyBh
bGlnbm1lbnQgbmV3IGZvciB0aGUgQVNUMjcwMCBvciBpcyB0aGlzIHNvbWV0aGluZw0KPiA+PiB5
b3UgYWRkZWQgYmVjYXVzZSB0aGUgbWFzayBvZiBETUFfTEVOR1RIIGlzIG5vdyByZWxheGVkIHRv
IG1hdGNoIGFsbA0KPiBhZGRyZXNzZXMgPw0KPiA+Pg0KPiA+PiAjZGVmaW5lIERNQV9MRU5HVEgo
dmFsKSAgICAgICAgICgodmFsKSAmIDB4MDFGRkZGRkYpDQo+ID4gQVNUMjcwMCwgQVNUMjYwMCBh
bmQgQVNUMTAzMCBpcyBmcm9tIDEgYnl0ZSB0byAxRkZGRkZGLCBzbyBJIGNoYW5nZSB0aGlzDQo+
IE1pY3JvIHRvIGZpeCBkYXRhIGxvc3QuDQo+ID4NCj4gaHR0cHM6Ly9naXRodWIuY29tL0FzcGVl
ZFRlY2gtQk1DL3UtYm9vdC9ibG9iL2FzcGVlZC1tYXN0ZXItdjIwMjMuMTAvYQ0KPiA+IHJjaC9h
cm0vbWFjaC1hc3BlZWQvYXN0MjcwMC9zcGkuYyNMMTg2DQo+ID4gUGxlYXNlIHNlZSB0aGlzIGxp
bmUsIGl0IGRlY3JlYXNlIGRtYV9sZW4gMSBieXRlIGZpcnN0IHRoZW4sIHNldCB0byBETUFfTEVO
DQo+IHJlZ2lzdGVyIGJlY2F1c2UgRE1BX0xFTiBpcyAwIHdoaWNoIG1lYW5zIHNob3VsZCBtb3Zl
IDEgYnl0ZSBkYXRhIGlmIERNQQ0KPiBlbmFibGVzIGZvciBBU1QyNjAwLCBBU1QxMDMwIGFuZCBB
U1QyNzAwLg0KPiA+Pg0KPiA+PiBUaGFua3MsDQo+ID4+DQo+ID4+IEMuDQo+ID4NCj4gPiBPbmx5
IEFTVDI1MDAgbmVlZCA0IGJ5dGVzIGFsaWdubWVudCBmb3IgRE1BIExlbmd0aC4gSG93ZXZlciwg
YWNjb3JkaW5nDQo+ID4gdG8gdGhlIGRlc2lnbiBvZiBzYXBwZWRfc21jX2RtYV9ydyBmdW5jdGlv
biwgaXQgdXRpbGl6ZXMNCj4gPiBhZGRyZXNzX3NwYWNlX3N0bF9sZSBBUEkgYW5kIGl0IG9ubHkg
d29ya3MgZGF0YSA0IGJ5dGVzIGFsaWdubWVudC4NCj4gPiBodHRwczovL2dpdGh1Yi5jb20vcWVt
dS9xZW11L2Jsb2IvbWFzdGVyL2h3L3NzaS9hc3BlZWRfc21jLmMjTDg4OQ0KPiA+IEZvciBleGFt
cGxlLA0KPiA+IElmIHVzZXJzIHdhbnQgdG8gbW92ZSAweDEwMSBkYXRhX2xlbmd0aCwgYWZ0ZXIg
MHgxMDAgZGF0YSBoYXMgYmVlbiBtb3ZlZA0KPiBhbmQgcmVtYWlucyAxIGJ5dGUgZGF0YSBuZWVk
IHRvIGJlIG1vdmVkLg0KPiA+IFBsZWFzZSBzZWUgdGhpcyBsaW5lIHByb2dyYW0sDQo+ID4gaHR0
cHM6Ly9naXRodWIuY29tL3FlbXUvcWVtdS9ibG9iL21hc3Rlci9ody9zc2kvYXNwZWVkX3NtYy5j
I0w5NDANCj4gPiBgYGANCj4gPiBzLT5yZWdzW1JfRE1BX0xFTl0gLT0gNDsNCj4gPiBgYGANCj4g
PiBUaGUgdmFsdWUgb2Ygcy0+cmVnc1tSX0RNQV9MRU5dIGJlY29tZXMgMHhmZmZmZmZmZlhYIGJl
Y2F1c2UgaXQgaXMNCj4gPiB1aW50MzJfdCBkYXRhIHR5cGUgYW5kIHRoaXMgd2hpbGUgbG9vcCBy
dW4gaW4gdGhlIHVuZXhwZWN0ZWQgYmVoYXZpb3IsDQo+ID4gaHR0cHM6Ly9naXRodWIuY29tL3Fl
bXUvcWVtdS9ibG9iL21hc3Rlci9ody9zc2kvYXNwZWVkX3NtYy5jI0w4NjQNCj4gPiBUaGF0IHdh
cywgd2h5IEkgc2V0IDRieXRlcyBhbGlnbm1lbnQgZm9yIGFsbCBtb2RlbHMuDQo+ID4NCj4gPg0K
DQo=

