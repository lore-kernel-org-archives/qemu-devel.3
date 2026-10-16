Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A083CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHX4M-00007h-4B; Thu, 15 Oct 2026 21:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=742cbab99=Alistair.Francis@wdc.com>)
 id 1xHX4K-00007D-Gb; Thu, 15 Oct 2026 21:49:12 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=742cbab99=Alistair.Francis@wdc.com>)
 id 1xHX4G-0000IL-TJ; Thu, 15 Oct 2026 21:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792115348; x=1823651348;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ODWf7r659YRD9IjfAPGyBS6uPztcW8GG1OLOA1TltKM=;
 b=OOqRqoXc8xsYq6Exp+ycj6hPVj9jHD0yFVIBbpB7ZH+8u7JDpEosqn5v
 jcsV/U8vWXWIEPwDKwp0NCrdKhT60Wd5gsGcBDX2788yMGQHPxARcg1zv
 /zEmbtfWAE9UCRrPZRryIsAj8UbEfrFpsFVliU9ELVyfO9qEQy1Rst1/q
 39wWeB5Nx46ClgiZZfbSwmPFdccRXqS6FFz1SxRwV0mhqyj2zZvOYdikG
 o/O8xnVtt72PxsGJeeFOA1c9Boq+PB4oXV56aJgZ2+WqjyRhV/ZU5DCy7
 wHgkYKoZ9gJHYu1R6A84TXuj+ezAM0lK8kETCY3rGL8Llnlpp0xp7dPXZ g==;
X-CSE-ConnectionGUID: t7LOQdn6SwGcLzqQ1cQkmg==
X-CSE-MsgGUID: hOkZBuCGTXyV/xAaOKylNQ==
X-IronPort-AV: E=Sophos;i="6.27,160,1786982400"; d="scan'208";a="156617591"
Received: from mail-westus2azon11012027.outbound.protection.outlook.com (HELO
 MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.27])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 16 Oct 2026 09:48:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w33+W03+GfoBGNRjSIP3uBUHig87HypR8L1PPhYL+FCN+VpIOh9amGzyIfzR3LtH5Ega3ukW+MDwx3RV5gkrKJkQrwR6KdSpxNvb+7QSS3LgSyWK+wy7xX2bOoHvpaf//7L0iT2GA7c5h8FGeglOTlHv6d8XQtbaYyHbgqG1EM5eJzzl5hdCA5wPGxiGAFkAgiiU2hHCg0LqLXUzJvN2OnMyqeGx4eL/uX5kUM30GQtHHLeihfcgTotTd4LcZpbB1r22tUg9jWGw5JBqhOr0c9VY18KM0AT+MWtvR0ZL/KKB40zuqUToEXIOLJyPGCo8wc3SOAcAtw6gMw9BFyrtlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODWf7r659YRD9IjfAPGyBS6uPztcW8GG1OLOA1TltKM=;
 b=xBe93Q3hkq0zfzZYG9lZe7pgqmW0mJrVSDj0YL34JKtPreP97FK6pLqow59TXBKNJNkptk/L79PU3LqM8/Lw/Lu0uuGsfH8zh9mwanXv2k9LF+HU5rh5XsF9FKhcZTpZX1L/jHdFHjfj6nGC3pUVQTSIkTDHz2Ol0oy7R4Cb4X2rYAQVuTH9ejXSQ2tZiiQhzBi1Aqwch9yq+9OiolVGzIFGkSIgGwwHEMNFLt7PD6pzN31c/umXDL8baYhxLqeOpg3/XI1/ZhzhV/FgvGYDGUOdEOqVryAJDkEQTTSg2jN3HZaG6g3mTGiDTwWWKvvTaAVn19FWRskyCoHt2HeXLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODWf7r659YRD9IjfAPGyBS6uPztcW8GG1OLOA1TltKM=;
 b=KgTkeQs3rgxs7jD85GXyDDAbh7AjI4a+rpst6/EFw4fGRlJedNw/wrPg4ZyGOiMHabZ5PzAWnYpxW5wlS5y9jjgFOL2lj7v0MJ6WSeWWOZxuHelQiWL4aAPLDPi6yu+r3SDmvVx7B68zwkE7EArc9rPHwsOfRffrmSBdtbL5Ikc=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by SA1PR04MB8888.namprd04.prod.outlook.com (2603:10b6:806:38e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 01:48:55 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 01:48:55 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "fritchleybohrer@gmail.com" <fritchleybohrer@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv: mask vsepc according to IALIGN
Thread-Topic: [PATCH] target/riscv: mask vsepc according to IALIGN
Thread-Index: AQHdRLzvxArAwy+0MUugXvhulFCkG7b/l4YA
Date: Fri, 16 Oct 2026 01:48:55 +0000
Message-ID: <63d2a968c602df5cf9b2898d84ab52831d4a0b31.camel@wdc.com>
References: <20260915024945.32329-1-fritchleybohrer@gmail.com>
In-Reply-To: <20260915024945.32329-1-fritchleybohrer@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|SA1PR04MB8888:EE_
x-ms-office365-filtering-correlation-id: 2946aa4a-d209-49ff-bad5-08df2b27a341
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|23010399003|19092799006|38070700021|56012099006|261009223027099003|11063799006|10067099003|22082099003|18002099003|260925022911599003|260925021911599003|260925021311599003;
x-microsoft-antispam-message-info: ILj7oMUli8A8ESp7oJui/oyW60MX+hPESuEBZ2lwvg1/Y18u4x4lFOEODF6znb0ohB1ljJLjTk5OjqNXRAjv5GnPsDQQhZw36l0KctQThSHyWQ4sp46ELKCQEEDGeH0eRGWlbbf3ndraA89+GpsdUochs5w0BQ6jIaPm8pWP3fPYxZqZBrBa8GwAO/scn9ecJdV8+ppX6JyjjQ/N1R9hf/m656oOnYFz4I7EBlJDiNKj9JxKNPg6s95XPLTb0BQ4owrxr/AAKJs/RY/uED3pUGOmcKTqIeD3vM5GEJ+SjB78XApOTC/xhceDpg0Y/bbcJzzhhMZgADC17hdT0kUjmyenDdfnL6iV3QPoWAzxK9on4LrBYca3lCWcYaNPHz6UYnRsdtioqTEgtofL1CLRrHj5vJPbZoSqPvg6QUyqQEomdG8AFQCNbq74NJM+t7GB/y0vaeyBvvzqtGY44plDUIrgjJsMPYiY05MAFn1c2utaizBrSh/GgjFHeAbK+lEv/V03Uoz2rpRGMlcxpOagmxKduwp9nPEmOOsS4YKDVkfb93P4hHGUSBVX4MHkJ1pg6mT5+bqWNQ0+rby6sbMq3lkrUMypW3tK2quCAKOBPXZJE2aVZgddzKK6UmFxOBSyaf9hqFIm+dqp4VVHEMxHXqV+ETZBxajUyY/73aus7wDzbYyLA7+Bn5idWYd+rrkCfmmMJ8viXkvKz/NEYUq9m+3mm/ht70hGxpCKkjos4aY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(23010399003)(19092799006)(38070700021)(56012099006)(261009223027099003)(11063799006)(10067099003)(22082099003)(18002099003)(260925022911599003)(260925021911599003)(260925021311599003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFM1Ny8rNWN2eXd1MGpySmp5NkJZQWdtK0JRcVpuYms3WVZhbVRucytvcnZl?=
 =?utf-8?B?UU9NcjdoVHlkMy9TOVcxUzZhTUloYmNITFcrREh3cmxtYm1OZnNVMktvN01t?=
 =?utf-8?B?eW1SOXdWVm94UGxVSnpZaVdrcWlJSmxicCtwa1lXM0ptdFJqY0x6QWRtWGJN?=
 =?utf-8?B?K1c0ZnpMcDJ2aGQ1Y2hGRmx0dWFaWXFGRVN6Y2tTRjMyVE82aUZxaUU4Z0N2?=
 =?utf-8?B?U2hxaEt5VytqdEtJaXVUb2dLeUZHbHFSVjFZNUlPOVRxOTJRNWZ0VlFhU3Nu?=
 =?utf-8?B?b25MUjBYS2Y2aDBnTU9ScmNnRFFLOFpzTk5reE1MclkvV2NhN0RuYUdkQkgw?=
 =?utf-8?B?Z3djUXhqR1NGTXYwaVhhcXphRVNtZlVQUXpjZmhmaXdINHFXVXRHRHN1Uk92?=
 =?utf-8?B?ZG1MdVR6VFV6eG42cHVna0s4a2RSdU5CS2F5d3I2Vit6MlZTcUh6M1FXd1pa?=
 =?utf-8?B?QUZGSEF5UW9FaXRxTHpLWk94YktLS2tXVmlPeElxSzBxWmZNZlQ2ZWN6MjFE?=
 =?utf-8?B?d0Q0OEdGRkdvS25aVmpTdER0Y2c4U3paa1F2Q3RxaEF2R0ZNNHA4UVNqbHVu?=
 =?utf-8?B?VHk3Y0RRV21NRDRXMkRmK0pNcVFuUytNYy84WWlJODlaaUlDU3lHRHhWSkds?=
 =?utf-8?B?MGpNcFBjaDdVU2NsQW5jc0pwU25SN1Q3T3AvRnRKWGJab0tkYjhXMzM3a0RD?=
 =?utf-8?B?d01nNDVIZ3doanBuaGh2YTNVa3kxaXhZdEJiM0dhZU15UWd6Z3JBVy9wNFpN?=
 =?utf-8?B?dzR6VVVXMVZiNjNUamZKZzZranViTU9LaG9vZXNNNzc0U1d2QklLd29jTGIy?=
 =?utf-8?B?TTZuZjJVcG9CRWY5dStZN1N2Y1Roc29PUTRXUTBVcnJQem9GclcyUVRDOVNu?=
 =?utf-8?B?S0xkTGdwR25Oenp4OXpldEdENTFWZ3NaZlBlSURoVWd1ZXkvemlCWWtVajBG?=
 =?utf-8?B?Yi9zMHVuR3NJSHRoejJKUXNJMlFVSHpQQWdwV1J1czk1cjJ2eWFqVjdDcWJC?=
 =?utf-8?B?KzBuWlhSSXZXSGp4amZHd1VXTGlZQVR6RGx2akNkRWQ3eW5IeVJXRFpVR2FV?=
 =?utf-8?B?VmVWdjFBVkxaZHlubUhVZFVPL2RQOE5pNjcrSGtYUW4wSkVpTXBTZTJodkxE?=
 =?utf-8?B?YnlKL3lqcmMxeWlNOStGcUtOY2ZMT25KOXpvWmlGTTF4L2hIcFpKNmR3YXlQ?=
 =?utf-8?B?aTBQaTJLdFVCZHg1NzRteXYrb3p0eFNLb2ZPZ3g1NEYzZ3ExaHVzdmxGY0hs?=
 =?utf-8?B?azNZRDBqVnpGYjhBMHBjc3QrYkhtNmd0Rkl1RWt1REpWMVNkWk9CQmxiWUFV?=
 =?utf-8?B?ZHhBcmRVSE1VM0dSenhROG8zdEw2bWNXY0tna0dWZ1A4VUdzRFAvdVAyb0xR?=
 =?utf-8?B?NEphQXc4MWxnWnNkdVRCblhGckFzaDhTaWRxNlBXYjQwNU5VVTRLdjFXYU8y?=
 =?utf-8?B?QnhwbjBRWENKUTN4aXRjRmNmKy9qdEM0QnNxTFhTeXE3ZlRhRW5SREdJeWRS?=
 =?utf-8?B?b1p6eDRpZ3BxdnRpa3oxWW94TTBrcnJuQnFNUWhWQ3lhNG05czBqY2txQm9W?=
 =?utf-8?B?a0pheE9mRGJwcHJmOHVBY3N1U2lSOHN6RFJrVElobElTd21NcmJZQTlQQjhw?=
 =?utf-8?B?MStIRnVPME51UXFrazdUVDZ0OUxkTEFFd2ZUbE5tU2VPSFJqRGlMdUFER29R?=
 =?utf-8?B?RDd2ODcvdTIwL0lGZk1NYU5PbjVRTGdhTHQxbkYrVkYzaFZvdnNHeVFwRXUv?=
 =?utf-8?B?MWtCWStMLy9udDJhYkx5MFNpQzZHSFdRQStLRy95bEhFeS94TTRBaDNWY0hC?=
 =?utf-8?B?cWQ0VDZobUxLQUpXUmU4TVhkdFhjSWo0SE90QXVJck1LbzZNcnFiemdaSi9p?=
 =?utf-8?B?VDBVdkZDNjVXeHFzU1ZxMnJ6aUhjditQdEgycmsxNndZSUFXM0IzU2IwR0Yw?=
 =?utf-8?B?U0VUV3BSMllFUkIwd24zU3NRZ2M4ZTJndVVjVlR6aFJCYXg2clRRbjUzb0hn?=
 =?utf-8?B?eFVzdGgvK3daZURtTUc2NGpXalJ3MUpvUkkrNmRVRnlTZmxSNW9EQUh2ZGo5?=
 =?utf-8?B?RWYxVUJXNHBYRCtjQXBZZTVJRml6ekpwazRVTjB2ZHJ1ZjN0WE1GcVVuYjRV?=
 =?utf-8?B?cDh1S2RzVk9PSTN1Yks0bXZnNDY3TEtUS3hhL0hBVStFbURhdjNzMjZJYnJp?=
 =?utf-8?B?ZWs1bnJMWis0blB0VGtaZkJRVmVyc3RrckxEb3NwdTRNYVg1NjRGRTZIWGlv?=
 =?utf-8?B?RDc1RC8vbURqekFXbFY1TGVJYmpqZXNNbm5lbVVTZXI5SE1LZ0ZodUFRaURo?=
 =?utf-8?B?c0Z6dk1FVXNmaERuMkUxb1gvcWVrL1NYeFdXakoyU05EQWNtSC9DUU1vR0Z3?=
 =?utf-8?Q?GGZbMSV2rWsuG8eq87crSuBX9V1luSUpZNkZwyQyyg51h?=
x-ms-exchange-antispam-messagedata-1: 3M8zvOCbaXiVmcS86p1or1UnuMwDgeX6cpQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <932A64414D773841AABB87EFB3051B18@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bfPJnC49NskR/cHY3BvTPxjSkG5ZqeWi+wrNBrYieoZc/3UnhjfOd/s1+87mKnDPqqRmsYFQHWasfuYLc82LFgP29dL0uTdLvTDmNX4dymt+dP7YcMu9NSxWc8e+Euj9lcLfU7FYlMRIo+xXNJfKVmoRctS+jc4eljtwCCbMTnZhqGqthR98H9Ys9QKiFfNKtH+kxO2uGUCyTPl3fnjtT3RyzRMNPX0EbLy4C3g97mSKumiz9kKM6l4iVKbyDku3oSwg9RIUt921T/w2Tv7iBs+WR2ZbP5EYdgc73RrIgaU3G1r5XWgxn686i0pDFKzC3oYLFkWXLNcKHqIWTKKgcA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mlDu5/IOLWsc/67fuMFfNguF5WhY8LDMaAmy65QC9vuJb/3pjVF4XIuO0vmO4rfDj/1XyWX52PpcQb4d8DWKL6FBg64t+DkXTrZltb6vX63JYAyeeKJb+6Gx1UBdSBbLdnWzaGI85hgVb6y9Ki7WswhZOK1w6CtHSRtMxDtLrBIzMYqYwqfgJpmPc0lW+RT2MlX7bqcyR/pbxRcdnZWc0ZdTswQiEHRf0uJAWXxu9e3iKhqs/5ZLUnIwyMugDBPlIx3AVcrEGpXEtExAA4U27IWbu/gpyM9Rv4dwbvP1ZjFAVtFMpd7Qvib3uaSK57zP5bPeiFrsxM3OF+iF4EMRg1e01+d8wobGf4HVTken6cFqRGB/zHfM9H6RZV/GLhx4n+Z5m05RXim6fhHWETwyJqEqursaGND/qbHtVbzQdGo4VL3IWQAUhRhddjnD3hpoyUjApo9Ze0kvYNFM8vTgGjzbuNmxS7eqCYEI7dGOuoufsm7aTYfeRFU9pngCZpi0WUBSJ3vEUbmgc+zqNlry4EtnPY45+f3blFQV9GSCLA9vM3gReWGXJ9SE8DmobE6PgPZRwkDpZwXfNVR7ufN4Yv0YNtmIJ8O1VufkIrSDx6gAEV39eQk9yI7ga/gD3rgI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2946aa4a-d209-49ff-bad5-08df2b27a341
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 01:48:55.2065 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 238BiWT1pMpFGnxc0eIFZJ2M9pmHE0DdfVdO51aCJ4Mkyqw3NMX69ocXVy36yKMtn2NJxphm/n8z+MMlzipOZeKrBc2sv4OhVY/2NeRFImQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8888
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

T24gVHVlLCAyMDI2LTA5LTE1IGF0IDEwOjQ5ICswODAwLCBaZXBoeXIgTGkgd3JvdGU6DQo+IHZz
ZXBjIGlzIHRoZSBWUy1tb2RlIGNvdW50ZXJwYXJ0IG9mIHNlcGMgYW5kIGlzIGEgV0FSTCByZWdp
c3RlciwgYnV0DQo+IHVubGlrZSBtZXBjIGFuZCBzZXBjIGl0cyBhY2Nlc3NvcnMgZG8gbm90IG1h
c2sgdGhlIGxvdyBhZGRyZXNzIGJpdHMNCj4gYWNjb3JkaW5nIHRvIElBTElHTi7CoCBBcyBhIHJl
c3VsdCwgdmFsdWVzIHdpdGggaW52YWxpZCBsb3cgYml0cyBjYW4NCj4gYmUNCj4gb2JzZXJ2ZWQg
dGhyb3VnaCB2c2VwYy4NCj4gDQo+IEFwcGx5IGdldF94ZXBjX21hc2soKSB0byBib3RoIHZzZXBj
IHJlYWRzIGFuZCB3cml0ZXMsIG1hdGNoaW5nIHRoZQ0KPiBleGlzdGluZyBtZXBjL3NlcGMgaGFu
ZGxpbmcuDQo+IA0KPiBBZGQgYSBUQ0cgcmVncmVzc2lvbiB0ZXN0IGNvdmVyaW5nIGJvdGggSUFM
SUdOPTE2IGFuZCBJQUxJR049MzIuDQo+IA0KPiBGaXhlczogODc0N2M5ZWViMmFhICgidGFyZ2V0
L3Jpc2N2OiBBZGQgSHlwZXJ2aXNvciB2aXJ0dWFsIENTUnMNCj4gYWNjZXNzZXMiKQ0KPiBSZXNv
bHZlczogaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0vd29ya19pdGVtcy80
NDIwDQo+IFNpZ25lZC1vZmYtYnk6IFplcGh5ciBMaSA8ZnJpdGNobGV5Ym9ocmVyQGdtYWlsLmNv
bT4NCg0KVGhhbmtzIQ0KDQpBcHBsaWVkIHRvIHJpc2N2LXRvLWFwcGx5Lm5leHQNCg0KQWxpc3Rh
aXINCg0KPiAtLS0NCj4gwqB0YXJnZXQvcmlzY3YvdGNnL2Nzci5jwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgIDQgKy0NCj4gwqB0ZXN0cy90Y2cvcmlzY3Y2NC9zeXN0ZW0vbWVz
b24uYnVpbGTCoMKgIHwgMTEgKysrKysrDQo+IMKgdGVzdHMvdGNnL3Jpc2N2NjQvdGVzdC12c2Vw
Yy1tYXNraW5nLlMgfCA1NA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiDCoDMgZmls
ZXMgY2hhbmdlZCwgNjcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gwqBjcmVhdGUg
bW9kZSAxMDA2NDQgdGVzdHMvdGNnL3Jpc2N2NjQvdGVzdC12c2VwYy1tYXNraW5nLlMNCj4gDQo+
IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvdGNnL2Nzci5jIGIvdGFyZ2V0L3Jpc2N2L3RjZy9j
c3IuYw0KPiBpbmRleCBiZDRiNmRjMTE0Li4yNzRjNWNmYmY0IDEwMDY0NA0KPiAtLS0gYS90YXJn
ZXQvcmlzY3YvdGNnL2Nzci5jDQo+ICsrKyBiL3RhcmdldC9yaXNjdi90Y2cvY3NyLmMNCj4gQEAg
LTUyOTksMTQgKzUyOTksMTQgQEAgc3RhdGljIFJJU0NWRXhjZXB0aW9uDQo+IHdyaXRlX3Zzc2Ny
YXRjaChDUFVSSVNDVlN0YXRlICplbnYsIGludCBjc3JubywNCj4gwqBzdGF0aWMgUklTQ1ZFeGNl
cHRpb24gcmVhZF92c2VwYyhDUFVSSVNDVlN0YXRlICplbnYsIGludCBjc3JubywNCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHRhcmdldF91bG9uZyAqdmFsKQ0KPiDCoHsNCj4gLcKgwqDCoCAqdmFsID0gZW52LT52c2Vw
YzsNCj4gK8KgwqDCoCAqdmFsID0gZW52LT52c2VwYyAmIGdldF94ZXBjX21hc2soZW52KTsNCj4g
wqDCoMKgwqAgcmV0dXJuIFJJU0NWX0VYQ1BfTk9ORTsNCj4gwqB9DQo+IMKgDQo+IMKgc3RhdGlj
IFJJU0NWRXhjZXB0aW9uIHdyaXRlX3ZzZXBjKENQVVJJU0NWU3RhdGUgKmVudiwgaW50IGNzcm5v
LA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB0YXJnZXRfdWxvbmcgdmFsLCB1aW50cHRyX3QgcmEpDQo+IMKgew0K
PiAtwqDCoMKgIGVudi0+dnNlcGMgPSB2YWw7DQo+ICvCoMKgwqAgZW52LT52c2VwYyA9IHZhbCAm
IGdldF94ZXBjX21hc2soZW52KTsNCj4gwqDCoMKgwqAgcmV0dXJuIFJJU0NWX0VYQ1BfTk9ORTsN
Cj4gwqB9DQo+IMKgDQo+IGRpZmYgLS1naXQgYS90ZXN0cy90Y2cvcmlzY3Y2NC9zeXN0ZW0vbWVz
b24uYnVpbGQNCj4gYi90ZXN0cy90Y2cvcmlzY3Y2NC9zeXN0ZW0vbWVzb24uYnVpbGQNCj4gaW5k
ZXggODYwNGMyYTQ1YS4uNWQ2MzNhMjY2YSAxMDA2NDQNCj4gLS0tIGEvdGVzdHMvdGNnL3Jpc2N2
NjQvc3lzdGVtL21lc29uLmJ1aWxkDQo+ICsrKyBiL3Rlc3RzL3RjZy9yaXNjdjY0L3N5c3RlbS9t
ZXNvbi5idWlsZA0KPiBAQCAtMjQsNiArMjQsMTcgQEAgdGVzdHMgKz0gew0KPiDCoMKgICd0ZXN0
LWNyYzMyLlMnOiBzZXR1cCArIHsncWVtdV9hcmdzJzogWyctY3B1JywgJ3J2NjQseGxyYnI9dHJ1
ZScsDQo+IHFlbXVfYXJnc119LA0KPiDCoMKgICd0ZXN0LW1pbnN0cmV0LWVjYWxsLlMnOiBzZXR1
cCArIHsncWVtdV9hcmdzJzogWyctaWNvdW50JywNCj4gJ3NoaWZ0PTEnLCBxZW11X2FyZ3NdfSwN
Cj4gwqDCoCAndGVzdC1taXNhLXcuUyc6IHNldHVwICsgeydxZW11X2FyZ3MnOiBbJy1jcHUnLCAn
cnY2NCx4LW1pc2EtDQo+IHc9dHJ1ZSxjPXRydWUsdj10cnVlJywgcWVtdV9hcmdzXX0sDQo+ICvC
oCAndGVzdC12c2VwYy1tYXNraW5nLlMnOiBzZXR1cCArIHsNCj4gK8KgwqDCoCAndGVzdF9uYW1l
JzogJ3Rlc3QtdnNlcGMtbWFza2luZy1jJywNCj4gK8KgwqDCoCAncWVtdV9hcmdzJzogWyctY3B1
JywgJ3J2NjQsaD10cnVlLGM9dHJ1ZScsIHFlbXVfYXJnc10sDQo+ICvCoCB9LA0KPiArfQ0KPiAr
DQo+ICt0ZXN0cyArPSB7DQo+ICvCoCAndGVzdC12c2VwYy1tYXNraW5nLlMnOiB7DQo+ICvCoMKg
wqAgJ3Rlc3RfbmFtZSc6ICd0ZXN0LXZzZXBjLW1hc2tpbmctbm8tYycsDQo+ICvCoMKgwqAgJ3Fl
bXVfYXJncyc6IFsnLWNwdScsICdydjY0LGg9dHJ1ZSxjPWZhbHNlLHpjYT1mYWxzZScsDQo+IHFl
bXVfYXJnc10sDQo+ICvCoCB9LA0KPiDCoH0NCj4gwqANCj4gwqB0ZXN0cyArPSB7DQo+IGRpZmYg
LS1naXQgYS90ZXN0cy90Y2cvcmlzY3Y2NC90ZXN0LXZzZXBjLW1hc2tpbmcuUw0KPiBiL3Rlc3Rz
L3RjZy9yaXNjdjY0L3Rlc3QtdnNlcGMtbWFza2luZy5TDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQo+IGluZGV4IDAwMDAwMDAwMDAuLmU1NDYwZjhhZWUNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysg
Yi90ZXN0cy90Y2cvcmlzY3Y2NC90ZXN0LXZzZXBjLW1hc2tpbmcuUw0KPiBAQCAtMCwwICsxLDU0
IEBADQo+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlciAqLw0K
PiArDQo+ICsjZGVmaW5lIE1JU0FfQ8KgwqDCoMKgwqDCoMKgwqDCoCAoMSA8PCAyKQ0KPiArDQo+
ICsJLm9wdGlvbglub3J2Yw0KPiArCS50ZXh0DQo+ICsJLmdsb2JhbAlfc3RhcnQNCj4gK19zdGFy
dDoNCj4gKwljc3JyCXMwLCBtaXNhDQo+ICsJYW5kaQlzMCwgczAsIE1JU0FfQw0KPiArDQo+ICsJ
bGxhCXMxLCB0ZXN0X2FkZHINCj4gKwlvcmkJdDAsIHMxLCAzDQo+ICsJY3Nydwl2c2VwYywgdDAN
Cj4gKwljc3JyCXQxLCB2c2VwYw0KPiArDQo+ICsJYmVxeglzMCwgaWFsaWduMzINCj4gKwlhZGRp
CXQyLCBzMSwgMgkvKiBJQUxJR049MTY6IGJpdCAwIHJlYWRzIGFzIHplcm8uDQo+ICovDQo+ICsJ
agljaGVjaw0KPiArDQo+ICtpYWxpZ24zMjoNCj4gKwkvKiBJQUxJR049MzI6IGJpdHMgWzE6MF0g
cmVhZCBhcyB6ZXJvLiAqLw0KPiArCW12CXQyLCBzMQ0KPiArDQo+ICtjaGVjazoNCj4gKwlsaQlh
MCwgMg0KPiArCWJuZQl0MSwgdDIsIF9leGl0DQo+ICsNCj4gKwlsaQlhMCwgMA0KPiArCWoJX2V4
aXQNCj4gKw0KPiArCS5iYWxpZ24JNA0KPiArdGVzdF9hZGRyOg0KPiArCW5vcA0KPiArDQo+ICsv
KiBFeGl0IGNvZGUgaW4gYTAuICovDQo+ICtfZXhpdDoNCj4gKwlsbGEJYTEsIHNlbWlhcmdzDQo+
ICsJbGkJdDAsIDB4MjAwMjYJLyogQURQX1N0b3BwZWRfQXBwbGljYXRpb25FeGl0ICovDQo+ICsJ
c2QJdDAsIDAoYTEpDQo+ICsJc2QJYTAsIDgoYTEpDQo+ICsJbGkJYTAsIDB4MjAJLyogVEFSR0VU
X1NZU19FWElUX0VYVEVOREVEICovDQo+ICsNCj4gKwkvKiBTZW1paG9zdGluZyBjYWxsIHNlcXVl
bmNlLiAqLw0KPiArCS5iYWxpZ24JMTYNCj4gKwlzbGxpCXplcm8sIHplcm8sIDB4MWYNCj4gKwll
YnJlYWsNCj4gKwlzcmFpCXplcm8sIHplcm8sIDB4Nw0KPiArCWoJLg0KPiArDQo+ICsJLmRhdGEN
Cj4gKwkuYmFsaWduCTE2DQo+ICtzZW1pYXJnczoNCj4gKwkuc3BhY2UJMTYNCg==

