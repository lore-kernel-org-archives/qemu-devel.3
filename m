Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C0ECCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 02:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHXGL-00037x-6h; Thu, 15 Oct 2026 22:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=742cbab99=Alistair.Francis@wdc.com>)
 id 1xHXGI-00037C-Df; Thu, 15 Oct 2026 22:01:34 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=742cbab99=Alistair.Francis@wdc.com>)
 id 1xHXGG-0001VH-MT; Thu, 15 Oct 2026 22:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792116092; x=1823652092;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=60ed0jDvPmxtVOr8LTLTay16uphxpjZgUcBE/MKccNs=;
 b=hBvmk/xG/nyKkg/7V8ZkFtNTIpxMSWcveTIRK9Y/nmxVdhqBtOWl4NRU
 JIcvc6tfN/HYVNkGd9wqc/3eblzDPox5iIVyp0D+pTWELdKpECAq19hgq
 6nr11i0OEbga4wCZXuOfYKrL4bX9hJHz2txiapji+Z3em3wC3G3fTd4JT
 SExBRkY2W1kD6FqwkePOcrWu5YzG+xMXYFGn+lhfDvjoN4jG6+7UiU4/8
 TvQgNBet1kCT/zuyJAoRyWJZWgf3Fo1G3oUQasNiv0UVoTsj7z6yyRs6g
 BU76jkKKq3Sb73CaVg4pinHuL+JS/h4oOeyH8i579ZACt1ijbB2OQrWE1 A==;
X-CSE-ConnectionGUID: 7qCowofIR/CeBwA0H7vC0A==
X-CSE-MsgGUID: 6mLNxSLYRMyP/KqwGoShFg==
X-IronPort-AV: E=Sophos;i="6.27,160,1786982400"; d="scan'208";a="156618451"
Received: from mail-eastus2azon11010005.outbound.protection.outlook.com (HELO
 BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.5])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 16 Oct 2026 10:01:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYuvbcOIFTZAW4puvSwdSXrXp8TnKYvwX3mQqjY+BjCMOvFb8BezruU8i2G4YjJpqOJ40qUsGnGiyfdT3y/HEmcqXnGwcAOTL7P1tMRdPAYVF6pu16dJl85+xq2+N+Owj7+Le9zTD6qXkXfr6FAorw2ZJ/B3X5hfnJm8gyILXdJdx1Y1Vf9XukXFhtJzeVAcxgR1dDGECmaEoTJPKtUGJhVuDOaKH1VVPL2uJJ9giRu+b9XoaujkUQDXuvm/tCs9ZBBDCcIDvzqh06yK6SNViqBawtw1buB0q4+MwhqJubypoAYBKPw3GmQLWW8my2Cf9Opcqwhf7O193w5QX0Y1QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60ed0jDvPmxtVOr8LTLTay16uphxpjZgUcBE/MKccNs=;
 b=B6JWuW7IjfcLkoW6hN2OBHIaFo49OMOsf0XwGLLNFcJXjvlrxBxLMGqymyDiCQhbLIYDQCwDoIXLvipmcjSWT9avYIprKv1lDhpc3RP7dBNT7QPk5VmEHvytOoTRs2mDDlhtIc5x6jp/UwHuK9MVLHEdkyDElaC5JbVUHNGr6KBIJNcoHZDvrhmWa0GgEP4a66EJkiJ/UhVtbbDMIrmIQrOK2IOc0+xwIxHCUXxmE288agQyxCmYaGhYwBo3jzhy3RrA0YYHlKTPB5L3eCWBeDJzEScE85QFlWoUDxZpay02NPB+KmXCmCIIUhKOJISL3sPjV9ygtBAki2gnn2O81g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60ed0jDvPmxtVOr8LTLTay16uphxpjZgUcBE/MKccNs=;
 b=rYweI7u5vIZHW8uYiYS3tiZkCIypfiDkFC/uoh8RmkmH8/DzRpFMn9Omu1pcRkA8/JaNguP5qEdAtuBMEF4DYB5AIH6iZLojAA3Dp1+bhgyQHkBzEjYo44QKy5eyNVc3QXp6TgYk94lYfwHKZ8AeS1DPCXQlMQb01FGEb4roTFI=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by SA1PR04MB8886.namprd04.prod.outlook.com (2603:10b6:806:386::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 02:01:16 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 02:01:16 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "dingtaodtdt@gmail.com" <dingtaodtdt@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "dingtao0430@163.com" <dingtao0430@163.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "lvivier@redhat.com" <lvivier@redhat.com>
Subject: Re: [PATCH v2 4/5] qtest: fix k230_decomp_gzip test integer handling
 issues
Thread-Topic: [PATCH v2 4/5] qtest: fix k230_decomp_gzip test integer handling
 issues
Thread-Index: AQHdUnbFXcPepDdL8EiBmC4rm2wWebb/f4WA
Date: Fri, 16 Oct 2026 02:01:16 +0000
Message-ID: <ec5af366d89b953d35dc4139552a37276dd750e1.camel@wdc.com>
References: <20261002140245.30214-1-dingtao0430@163.com>
 <20261002140245.30214-5-dingtao0430@163.com>
In-Reply-To: <20261002140245.30214-5-dingtao0430@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|SA1PR04MB8886:EE_
x-ms-office365-filtering-correlation-id: 39a54e87-dfa1-4a7e-786d-08df2b295d12
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|19092799006|23010399003|22082099003|261009223027099003|38070700021|56012099006|11063799006|4143699003|10067099003|18002099003;
x-microsoft-antispam-message-info: 5gaPnX7JEBlW7BtHht28mwP23NIy3KyoiFX4AG28NqEpb4ShQK+fMaUwZnwT54bAklUzYHCGLBHmU/iXLb7WP3d9DZL0cvFJAk2IGbATqZad6+6yPQYhCGIOCCJNarbN2NtlVWVCIDodVuEU4lfCXJvqS/Yyft/pKWmB59OkYyyWdEc+lLjuYneJtdOCCDib/SRGhiNqzTqgpyMHOwjLWzjSvHD3O748v7QFHloaPQcl5WzpUE/avpOnqCOeAQFg4QE1w5Zwaxcm+8D5P8mH7xj5YV/YSPZpWU3aEpupK/iAPVpmhIgrtynRWSOQVOvcKzypOqEbjKTz+VBfeO9hAFbYJMfMr4XI7e6Ver+dvysMRKQEyZgifWGNWAxg1vk32ZxrU3bICIWr/bB2a1Tu6thBuZ4bHwNpZf8I2//QWHen0391tzW9XbyQJPLX4JITVuMUqbXpJlN1n2XL9hBEMrO3inHjOBj+De4nnKy9ZOE0iIk3ByYoSn5asRHaz/auuT+saZMpnXQIGTZXNuqT1tvbv9MIu2sFbZUU+Ntppv5rUAi+CnKP6+vlx0mc2IfY1zw2X2kFNfFhS2stZEgTUz4ZQOhxY6NC7q1LPJnbD8yUJBZhRPaSPc68LfAiBdOGvHG5tkNO1L5INJ+LtAGopWBeM1ub2RrDgvWS5CLlJkW1Wd5zrJQhngsLFIoLCHEY0ZT7SfL3YwcGuIrXudfRNzK1WeC7aic4q+2y8qO/TOU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(19092799006)(23010399003)(22082099003)(261009223027099003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGtsWEN6ZzNtK3k4RXlxLytxRVM4N2JOZURjcEpCUjlBSjRKYjRVbU1XN2d0?=
 =?utf-8?B?TUpHVTYzVHk1N2U1YUp6RVJxYk5xcDBMb1A3R2pmTlZ3ZmFxMFF3aU9aOFIy?=
 =?utf-8?B?TndEMXBsUXhBaGpJaFo4N0pIWVZoc1R6UFVZbTlFYStWbG9VN2dRQzd3a21l?=
 =?utf-8?B?RUh2NHFBOGdwdXJTcHp0Zno3WWpwRjVPbyt4NnkwSzY5ZEFQc0NaYXhIeWh5?=
 =?utf-8?B?UHB2ZUVoOW9CeWNBUkhwd09NRERyYUt4SS84ZytISi9TS00yRVFuNHNqTktX?=
 =?utf-8?B?Sk5JN1cxK1VTdFpKT09CVWF4ZXFCMUI5VmFEWFQrWTZtdTF4aCt6SkdKTnB4?=
 =?utf-8?B?YjF0UklJVDRoNTdlNGJNSnBSNHlDblA4OGxoRlVNbXprT3d3cGtYSUZXYWxU?=
 =?utf-8?B?NGExdG5WeCs5Qko1ZE1JU05sMXlaL09OeTBwYm9zZzBUbnRUa09PbkIyS2JG?=
 =?utf-8?B?VG80VGU5MHhDTDRnRW5KaUZwMHlTbnVyUjBVM0dLS0s0QTdHck1KMVpIQUp2?=
 =?utf-8?B?bndiTnUvdlo4VWNnNHVqMytka3Zrc25wQlNHNXo0SHdRbzdycDNlRGJVRUZC?=
 =?utf-8?B?aGhSS1ROKzdXUGdEcEF1SURUZm5VZjAyTUtiYStoUFh5Rk5DQ2l0SjA5RmlN?=
 =?utf-8?B?akNleHRYMW9CMlg0QldRY0hKM0pxWEs2OFowQmV3bml2ZEFlSHJkNTJ2RWEr?=
 =?utf-8?B?ckg0OXkrWWR4VDZmL3VHZWNqUkRzYUxLZHRSUnVOYVFhdzBWekx2Q3QzYWdG?=
 =?utf-8?B?a2VETy9heEVjb2k0MldFN1J4ZmRxV1QvRHBISk04RVZMQVI0UG5qUjYwckhk?=
 =?utf-8?B?OHJDSlFIMGVqNXRUMnBOQkt2SkgvaXl5UjZ4M3NqelBNdHp2SC9qZ0ErV2tY?=
 =?utf-8?B?clJrS1pBam1oYWlHMWVTWUhKTmhsbFBSY3lIRTJkOUloWUR3NnkrQnpzMmF6?=
 =?utf-8?B?SnFlWjVaeUd5YWwzditlVHd3V3ZmSXk2Q1V1ejQvQloxTWtzRGZQMGpmOEJJ?=
 =?utf-8?B?bXlJUmh3Z3lVbjZGTnFWZ1dVbEJhWVpvNW9vOFVteWZVVy9rbWtUUmF2WFZs?=
 =?utf-8?B?dWVEVVkvTlBPRm5xYzUxUkJBWmFjSTJvZVZqQlZVT0ZROUoyNHFud1NqRUIz?=
 =?utf-8?B?ZWJlSk94eVpkYXk1RU5LaS9JbHlVMmtMKzczSFREZkFVSEcvMHREb1JCSkk4?=
 =?utf-8?B?UFgxb3VOUUVZUDRISUJVTnphcExCV05PdHo0R1dpWlk2OW5NalE3SlZaRHNC?=
 =?utf-8?B?ZjJRVEhsbi91dTl6NllSRC9BT2NVenQ5azVGWjQzSVMrMGJvVWcxK0JGaC9Q?=
 =?utf-8?B?TFBzN1VlSjU2ZTJFRXdTTjNuNU9qeE5sTEg0WWxRVmlTUjlhaG45S0ZFT3Jp?=
 =?utf-8?B?VGIraUNuZTNOcFRjdE1JUlM4eEs5WjRvcGNhVXdFQXRyUXNLTTBNZ1JlRkY2?=
 =?utf-8?B?UmZ3d3Q3RTdCNmpXc2t4czZ0aG8yZ1JDQTdpZS96T05ab0lEMDV0QlF0ZmJ2?=
 =?utf-8?B?RjVxcE9ad2VtZUI4TXJWWW5Rdm9GUE9JR205TUJCK2w0bGV5RDJUWWJETVNR?=
 =?utf-8?B?VmFhRU9IeUhodUliZUVxc01tUlBVT3JmL2xNZVVxSHczaXY2T1NtYlJ4NUlr?=
 =?utf-8?B?bW55aklMOW02RjA5ZFRiRCtZaWs5MHE4QTZuNHUvZ1hJNFBSTzdXWUh2NnZW?=
 =?utf-8?B?WUFqMEc0NENEWUxyYVUrRmhSbDloOWxsbmhiTW8zZmFXYVRLMEhXRXhJSytC?=
 =?utf-8?B?NjV2VHVTaTMwYUNnK3ppT3RaNFp2RE1zcWRhS24rU3FZUTFsUklRRURJQlZt?=
 =?utf-8?B?WjdPMEtxTzg4Q05EZjFLVkJzNHlBd2I5cUVTaTJnbWl0V1hodG1NaGh2Zi9B?=
 =?utf-8?B?Uk5GY1dxM0YzL1AyaVZ3N0hTOHJhN3l4SUhxS1JacTJESENGbjZRSmxzVlBh?=
 =?utf-8?B?L0E5cTlLZW12bEV3a3RKWmNPNWo5d0ZVNzhJRGcxOFAvMmJKK3NNSG9oclRZ?=
 =?utf-8?B?RFVYTFNyTjJKdjBrdFZpTTM4R0R4OGU4aUE1WnNpclRtSk91MDNPa3NpdjBa?=
 =?utf-8?B?QlJxMDJOemxCRTdld0VEWWwrcG9Cb1Vvczd6Nlg5NzY2QnJBaTFCY2wwelk0?=
 =?utf-8?B?dENSbDFJSjd0VE5udEdSeitrNU9GdFZpM2ZqTlpFTDFoNGdseUVNSUNoZExr?=
 =?utf-8?B?MlZXdUdHcjZRbGRYQVM2c3BUQVo1djBCZys5NzE3aFVYLzR3QW1ESWd1SlF5?=
 =?utf-8?B?WXB1UjRxMDNoTjZJRXpQcGZkN3FCNlovakg3T1Faa2w0TUZWZnhRbVVxaHhx?=
 =?utf-8?B?cHp5eVVjelJ3N3l4OTV0NmIvbzluZitSck83UUJNVkR2LzBxRjBqM2ZyVGRE?=
 =?utf-8?Q?+LINCiZa/HZ9VKSb6aZCYqpzBsD3yFeLvpwynAsV9oT7H?=
x-ms-exchange-antispam-messagedata-1: udrVjkEJU5W6fZ7nNUmaGHBOZ9XbYje6fyc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF1194249ABADE4E91439316F5E3030D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: s1GUt0xRza45xokCXrgQZgFutVJ3lGKmw9CR+7R+Ewd+hJwOhfSeMyVuZUAdMprUML9We8NmgDsoo4utfuODnOhI+6n7+KKRSRggdyF1YAUa8g6RurFOHXxWsoBM9TqoStTkPiSSTHu69COsBLCdi/G2HP8BtZAiDXgJG1hy4eQdGrwlDVB9asHuhsaF7afX8YHOAmZ/3jQMO1YeO3pOH6K0mQVt7s9JlTc2YlFIZ+rLoIeiz7HrsWf+1xI1qachR93HEhr+Ox/RbqX8acqUOZoQ3uTSDw3jTtIY8bSbgf8kKMZ8xJZFEKyAMHjHirMxEOrlqYn9P/rw028FqZbDAg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VTpEuae5InAoW6FdpDek5LHdN1YlUxiqse+AfFjTnj/bT1HmvpgpzipJ6NEm6Z86GEyUfkggr/z9hr+e5HZtlzUeUcfufBA/qkqHPFcMjUSjhJv4L2F/L9Vadnjc5KwuD7jGt0CNAXVjSBLP6Uz5L9AHkTJmfL2L+44p2Abl+SX2QgFGp9KPkW9/URqDgDy7KfwzMqbp9yxfk2iBtjqT6ZV4PATOITk9Fr10o4gzuDPY+6jggfCIsPDTGMZ/whQBy09uIEeuDgvUed+CUw+RQx4Hv2tV/hjMQUD5nC7TvdLx1LZrCTYlRZ5MopxJCFZUeYIdLOassxAfzSJ6G1QeK/zsCReWzj3eePIEanfbt8dlajhcrAQwLT1cwQKHLoTEpUBTAQ3n0x8TK9ML6f+PJfvBrK7jwJu/mzSr/eQ14UGoFhPdaNuKWLQy0Evm0Y/s9OkMmNryXRlOttH1Gg0O79YlftYYnzEY/PAXP8aTO98SJO9iSL76lwOAHss7FpC//T/Pi9bDwZa0WN0hAcUjVFUuwvO8unytcUNcuOlBGULugkCFOe5I4SR2nMtpdy60Mh2hfSgABgT02kN2/0cq0H3jzmeOwXCKP3BYbKHioHA9ONGgCqI6tnZyeBZcCVlH
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a54e87-dfa1-4a7e-786d-08df2b295d12
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 02:01:16.4656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xdQ3WQCr2i0B631P0GvQ4cRmw3HGsjZBkfmlvGiXrcgaGcJDq3wBQkJAovz2dBmhfGszZMJx3qxgRUNcGzl88FmRygTkuz7zmGkHco9yiBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8886
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=742cbab99=Alistair.Francis@wdc.com;
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

T24gRnJpLCAyMDI2LTEwLTAyIGF0IDIyOjAyICswODAwLCBUYW8gRGluZyB3cm90ZToNCj4gQ2Fz
dCBzbG90IHRvIGh3YWRkciBiZWZvcmUgbXVsdGlwbGljYXRpb24gdG8gcHJldmVudCAzMi1iaXQg
b3ZlcmZsb3cNCj4gd2hlbiANCj4gY2FsY3VsYXRpbmcgdGhlIFNSQU0gaW5wdXQgYWRkcmVzcy4g
DQo+IA0KPiBSZXNvbHZlczogQ292ZXJpdHkgQ0lEIDE2ODU1MTYNCj4gDQo+IFJlcG9ydGVkLWJ5
OiBBbGlzdGFpciBGcmFuY2lzIDxBbGlzdGFpci5GcmFuY2lzQHdkYy5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IFRhbyBEaW5nIDxkaW5ndGFvMDQzMEAxNjMuY29tPg0KDQpSZXZpZXdlZC1ieTogQWxp
c3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+
IC0tLQ0KPiDCoHRlc3RzL3F0ZXN0L2syMzAtZGVjb21wLWd6aXAtdGVzdC5jIHwgMiArLQ0KPiDC
oDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL3Rlc3RzL3F0ZXN0L2syMzAtZGVjb21wLWd6aXAtdGVzdC5jIGIvdGVzdHMvcXRl
c3QvazIzMC0NCj4gZGVjb21wLWd6aXAtdGVzdC5jDQo+IGluZGV4IGU4MDExM2ZkMjguLjI0OWM4
YWU4MmMgMTAwNjQ0DQo+IC0tLSBhL3Rlc3RzL3F0ZXN0L2syMzAtZGVjb21wLWd6aXAtdGVzdC5j
DQo+ICsrKyBiL3Rlc3RzL3F0ZXN0L2syMzAtZGVjb21wLWd6aXAtdGVzdC5jDQo+IEBAIC00Niw3
ICs0Niw3IEBAIHN0YXRpYyBpbmxpbmUgaHdhZGRyIGsyMzBfc3JhbV9hZGRyKGh3YWRkciBvZmYp
DQo+IMKgc3RhdGljIGlubGluZSBod2FkZHIgazIzMF9zcmFtX2lucHV0X2FkZHIodW5zaWduZWQg
aW50IHNsb3QpDQo+IMKgew0KPiDCoMKgwqDCoCByZXR1cm4gazIzMF9zcmFtX2FkZHIoSzIzMF9E
RUNPTVBfR1pJUF9TUkFNX0lOX0JBU0UgKw0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2xvdCAqIEsyMzBfREVDT01QX0daSVBfQkxPQ0tfU0la
RSk7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAoaHdhZGRyKSBzbG90ICoNCj4gSzIzMF9ERUNPTVBfR1pJUF9CTE9DS19TSVpFKTsNCj4gwqB9
DQo+IMKgDQo+IMKgLyoNCg==

