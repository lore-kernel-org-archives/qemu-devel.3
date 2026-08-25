Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B06FC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 04:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyiT7-00017V-GN; Tue, 25 Aug 2026 00:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=690dc056c=Alistair.Francis@wdc.com>)
 id 1wyiT6-00016s-4E; Tue, 25 Aug 2026 00:09:00 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=690dc056c=Alistair.Francis@wdc.com>)
 id 1wyiSB-0008JC-9H; Tue, 25 Aug 2026 00:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1787630883; x=1819166883;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ZV5qzu93ozi0FE6/HFLx5KRlhMKl1tp6d3ylaVbrfro=;
 b=bKdt2oyfUXuBXjQz6mOCEle34tnLrdBBVEnkkMgdo83kZbxPFyktbVcp
 nXwkWVKo5tz6SHzNiJQZOyrlsqiXDZJdmix4w2iJKHiSNrk42dZQM3oTE
 6JiphxxgJK5176DAR4ulP2rHm7EwdX2ZABw6k+D1VXS/nzPu//6nedUa5
 DxTerG+P+uhPcdNbsFUfoxICn/fK7af+xyW7XWBuQfGhOstT1Bd45WIdF
 xHaYBqQL5n7pLvkvd4MdCcfblTsDY/xzRf0Py2MKhTWt8G6GwXsfW4Nv1
 FnZ1DjVXUKyUF8bv1r2NK2upfmtKowqsV8UVvIgnMxYLp5UkomelP1kAN w==;
X-CSE-ConnectionGUID: Y86cbWGfT6yAYmB3rMHEUQ==
X-CSE-MsgGUID: D2L8p2AjRmu81ZRPJyK5Wg==
X-IronPort-AV: E=Sophos;i="6.25,242,1779120000"; d="scan'208";a="154202670"
Received: from mail-westus3azon11011052.outbound.protection.outlook.com (HELO
 PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.52])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 25 Aug 2026 12:07:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRSVdGQOxghqMMSfvl8Kc7N+Ut0gTHsTWJoahVPZKZS7faMcVNfItl2tIpqAHaU6ZztiQkleZDC/9LgH/Lzy4nq8+8dhfeqk/vU6DvxUWI96iDaRXNMOxETVYUlE5/YAvAi+dksPashUMS6LKaCHpU+9Uag9p47XZPQ6EKpS6/KTYLFpaPpzZgt64YpREAgAB+jZv+6W3PowXqT44EYuTWoPfGnwB1RVQN1TlLzrrno8rM4MDTAKLJjaoNC60zE2JHQunBVKKE7N2zy/c4r2xC0UajlHtqJyRf35toEHUr7eOb70nC+5yTpAgiTuV6A4wsjD/nanTsCx7XZcmou4ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZV5qzu93ozi0FE6/HFLx5KRlhMKl1tp6d3ylaVbrfro=;
 b=WL6YbkgWhGVQOgPCJeim5CPpvPGwy21Ro+wcB9l6NcdJvMpB+fjwmVWyiDGK9n5R5gqf4UPHzvg4k5ELmZKWtnzmXLNRS8tOE588qKpGnBw//JYkcXdypjEpBnRt2KSElhNhcTwKTrArOos7iEYbe0s/427NlV4VkV4z4UlgNreqrisQEd1jbTfBhKA5+MC7Vgeg4nxSR+rDZckxqAyKxUEHF39l6JKzaxeZKm9qnNyqo0OJVbjRjz3KlkHRnTZjD3lENva5ZNLWTwt8Fop6QAULXxSP/WIhzXD9BfRumWuqRK3dWo5TgAz71z6FOPr/mr6g8+CeyZKe30iP0qt0nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZV5qzu93ozi0FE6/HFLx5KRlhMKl1tp6d3ylaVbrfro=;
 b=N2Y71CJwBhxLDx0gx5WdEqdoFGiTCxqYQcQmvl6eqUwI9eORdjBPrg12w2VELYttTJjW98mQ60eudeUaZ4+3fgZbz2hhyA2g0PztmsCgTu6XwcWAExLmq0ySj3Vrco4ePk6jWsW0nGUWmKPmkzTqA86iDHwI6K/FJYDBLgowhU8=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by LV0PR04MB9859.namprd04.prod.outlook.com (2603:10b6:408:32a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 04:07:57 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 04:07:57 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "joel@jms.id.au" <joel@jms.id.au>, "philmd@linaro.org" <philmd@linaro.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "npiggin@gmail.com"
 <npiggin@gmail.com>, "mpe@kernel.org" <mpe@kernel.org>,
 "portias@oss.tenstorrent.com" <portias@oss.tenstorrent.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "asrinivasan@oss.tenstorrent.com"
 <asrinivasan@oss.tenstorrent.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "nieklinnenbank@gmail.com" <nieklinnenbank@gmail.com>
Subject: Re: [PATCH 3/4] tests/functional: Avoid unnecessary removal of
 scratch files
Thread-Topic: [PATCH 3/4] tests/functional: Avoid unnecessary removal of
 scratch files
Thread-Index: AQHdM41xHTEyNXrXEkyLOAHI8MfenbauJ4IA
Date: Tue, 25 Aug 2026 04:07:57 +0000
Message-ID: <d47e80b4bea7ee693428b4107568e1bbbd17b447.camel@wdc.com>
References: <20260824055642.41098-1-joel@jms.id.au>
 <20260824055642.41098-4-joel@jms.id.au>
In-Reply-To: <20260824055642.41098-4-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|LV0PR04MB9859:EE_
x-ms-office365-filtering-correlation-id: d598eb37-24ba-43f1-d897-08df025e71f2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|10070799003|7416014|23010399003|4143699003|22082099003|18002099003|11063799006|56012099006|38070700021|10067099003;
x-microsoft-antispam-message-info: bsGk3X0XL22ADtViF3cDXTj+2DLEswhOXZMbSkLhKjuQ+H91c9EwXPmiQfIKGGQVvtDcE2pwH2c9Ogjk+TelyFqe8QYrwH/VCUF6RrAwl0OWFZ3A3rbJNrvMyD+xRIEjbWXJmJc3C8AY99Dk2a1AUnf197qZLQnS06Y4SscfPzDHNo7nvBM7tdvJ67JOUQznfYAtR/YPlBctEt5fPnmiZ5z1zNXBC5LWXY71P5uemJJTt9nPrvuLfXYpi/zZelgJvq10gejTn1TMk7s3pd5y9KK2NXigfllvGaBYh+qJno+Hk3oknrXaYghUw2ECD9xoCE0D/iOBVbeC738JeySbSghIVRnn1iUmRAVwjXVpkVwJEYlkVqZ2P6tbj7NOZur865LCtpZSCwMF73/PSdSOBQHA2hgbiPhJ/KHnC88NdHDS3A73KHAQiyt3t9ITQkGAcZCQJmPgLOl22tQNofvfU/CiyTWi5KDT8tKsLgBFgFxW6UttAgyS5U8wK0eIh+34kK9Lz+LYDbhKyX8jZ9moG1zn1oiDiINUXkWlltgY+D/xhUDSsgMqrrorFtDF/klhX+7PXCuG6GgMPOyZAwEGe22ovgwzP+8jCTxVsPGQYqkFNRB/LefSE4Whoq+aZRYvfMsGmkobR8IjGaQnBMusnklJk1wAZwJU6jzKu1bnqdF+7kVUbLAFCs7I+++21OXuko5HfIakw+B9MZyWWfqvKA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(10070799003)(7416014)(23010399003)(4143699003)(22082099003)(18002099003)(11063799006)(56012099006)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1RoRmIxZGNVZWwwTS85ZXlIbnBiVTZGSGMrbFRMdWxDUWwxU29iaGJXNU9E?=
 =?utf-8?B?U3pGNEphaktOdWNUaS9TdnAzaHVyRGNUcUQvbHA0em5IL0R5MzdrSE5zQ3Zq?=
 =?utf-8?B?eVpCM2RRZTBPaVBXeHd5ZzdkK3VrQzNmSFZ4a2VEdVB4RmRIZ09mcnZLUWtq?=
 =?utf-8?B?Wkt2TlRadERxVnB5dEplSFgrUWw4ZUVHT3BKRE83c2NpeTZpSXEzTTZkWFIr?=
 =?utf-8?B?ejIvdmltWTlFUENVODdNR1FkYjlSQjI3R284ektXRGlsSW5COWhqSzFpS0s4?=
 =?utf-8?B?WVhreHNYSmtCeWRzRjVQV1NSNTdiSVRXTDgrQkZiV3pFUEFhVDl1WEg3K3pZ?=
 =?utf-8?B?Mzdad3ZVV25FVDhYR2M5S01lMVpwSUlYODQwby80cXcweXRwbDBhR0VCN2Qy?=
 =?utf-8?B?aXcvRyt4TmlXT2R0am5PZEI5dU5oT2twR0p3eG9rSFVhOEIwRXN6SExaK1Vk?=
 =?utf-8?B?dklEWjdSSElYTE1XZWtRYytFSVNIZTVyZ2ZPbCtFNWo0ZkJSNmNuTlJReFZ3?=
 =?utf-8?B?bkdUMEtTNWV2UlppY01mSVhWTlIvQWpWVlZ5cHFhdFNUVURxa2xYbjZ3L0xK?=
 =?utf-8?B?OWZWK2pvTDRJRmI3UktGUEJ2VllGRXhsVmc1ZFZmUk13QkYzaVAra2ZON3dh?=
 =?utf-8?B?NHdyRWJ4cDJucm9LMmRRQnVBTktJY1J0dUR5QjliTEFDS1VhcXdldDJDZ0cw?=
 =?utf-8?B?OGE2eHFLbUt0OEd3YTZ1SXI3ZjdTc3RqRjV5SXhsbDV4SmxmQ29jRHVXVlBV?=
 =?utf-8?B?cTlXOW81SFAyS0tSSU1STFRSM2p6K3JhRmpTNnNNcXVUNXJITUZUWjFFWHBK?=
 =?utf-8?B?VmF2VjB0VXpnTVFyU1liVHBtVDJHMWo1UVVQdUxsYnA2Q2l1RU5mMll1MXl2?=
 =?utf-8?B?Q2xEemQ4SG1rZjNtVEExTU8rQWNNQmZ4dHNURzFYMHpoTGxvTnIzMnF1OVJK?=
 =?utf-8?B?M2tHaUhBeGtNZEVFTlB5TVdyeGVtTDNLaGc1c0x3RWhLZTlObEdscGJWTGpE?=
 =?utf-8?B?R0tSaS8zVndITzFDR2tLM1RQS3JrYzZwSW51OFFlUG9GUGtFTTQ4cm1LbEE5?=
 =?utf-8?B?TjBGZGF4UEZ3YU03Mnd4Um8zTXUrZ2pMNnBFOWVjajh1c0lyTzRWUktrUVhZ?=
 =?utf-8?B?eHJ4TjJ4dzdJdU1CZGFsOTlXcFVBMXBPR3k1TjNGYlJlcFp0SkpvWXZHVVFj?=
 =?utf-8?B?bUpuS1liUCtYZ0hIQnNsNVFDUE56SkQ3RnlIamxWNndLc2s1QWRpUyt4ZU5l?=
 =?utf-8?B?YzNkREoxNTR4aWtoN1I5NlRZNjdUOEk5MnZsN2VDT0JiS0FxclN3VzVTSElw?=
 =?utf-8?B?ZGlnN3FRbCtNcTVjWHFOSG0rL0FQT0hwU3VLYTRDRkpNZTdrMU50aDhYMW9K?=
 =?utf-8?B?T1B6T0RqWFBmdkdZNWNQSCtueUxkSzRSZTFmT2ZTdiszZlFyczQ0dnd4Z1Yr?=
 =?utf-8?B?bUw2YzZydnFhSXQxMk10MkRDdnVnL0FHdDJYNlVKT3ZQOXVEMWVVRm5PM0FS?=
 =?utf-8?B?SkpHaXNXTXhIdVdjUDJuTVZTbmIwRGxoMjlmL2RPMG1KWkNuOGFJdnkvSTZo?=
 =?utf-8?B?bE9mSUxEMzdOY0k3OE1DN21ZUFcvQkZNdUcwYUgzMVNxMnE0ZWV0T0t5UmNJ?=
 =?utf-8?B?L3RESVpTdUYvcitIWGh3cnJybmhCZWx5S2tMVUhpN2xVNGgvL1o1ZW5iaDZK?=
 =?utf-8?B?cGJZTVlod3B6SWxWMTEzelowMmR2MTRkbkJnNGNkazRrd2E4ZmE1TGxKWlJl?=
 =?utf-8?B?Nzd3UHk1UVdDRXo2ZGRianFCMUFZanJuSTRaTGdqQVlqUGhJTXVOZ0ExUTQy?=
 =?utf-8?B?aU5YS0hncXRGbTE1TGJzazU5K3J3WjBrYStkMm10Y3NvTVczcUt6S0FBVzVS?=
 =?utf-8?B?UVF0OFRDMm1OaEV3RTZrMTkwOWdXanlQWnBRdE5GNlczSmhYYlB1MWVKS282?=
 =?utf-8?B?RkZDR0QwVHRyVy80NU11SzdvemdEY3Nvdk1jRG0rNEIrLy92NjVTQUh2Tzl4?=
 =?utf-8?B?eXArRnFBYm15OGN0MjlsMVFQb2F6ZkZRelNOL2M1Mnc2QU4rWnp5ZjhhZUp0?=
 =?utf-8?B?RzUyMVFPcStQa0Foa3U3eGMzWXEvMHhZMTA0QzNTNDdEcnZoVFZwTE5HZExi?=
 =?utf-8?B?aXdXNHYrNmd1TlJ1UytOb0lQQkMzMFV5ampXdnBYK1pxOG1SVXFhUjQyVU5z?=
 =?utf-8?B?Uk81M1ZUOUtPUXM3UjRidHRlQS82TzhJVUZmSHdvT1QwVlBQS0ZjWHh6aks0?=
 =?utf-8?B?UW5FVStFcWtaekNrWUxMVTdma1hnVEJ0Tis0ZWhEc2NaZ1lXcjN5eG5pVDhn?=
 =?utf-8?B?RFhUL1grOEtqT2txK1Q3T29tbDAwU0VCRDFhWFRiNHIyWEhGNlJXQkRQODZo?=
 =?utf-8?Q?CtXVfXwvtiwB6svi/lfD58ycnu4QicRcGUj3ewYipAaMy?=
x-ms-exchange-antispam-messagedata-1: adNbWRXw5udiXA6l5DnAIiZz31fyrzJJWhk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD2BD39D1E3D9A45A0F72818D6C4584D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XpKnUN7qRx86tYsGqVAHpEpfv8K6MJu1JD2ZLtqljKJ37hYIbMALPEX2T6t1YIkZ2zLkZwHKQpHhRg5FgGhomEj2G3x4ZY5J1QBoqisXeGHsRbL6j6wl48Ck6YP5dVBdhYxGLP3ym4y7sdCXlEDhpyMORScgViO4CeGPT6i1K/fv92K8lc5skNAIljvodr63U2hzUV2VmYFfc6Yk8wT1eU2sUQ+6HRo/ZxvLxo+yw0zDPqG31+BxDa23r1pPdPoFb3V48SFBpphHJ9pBz3jBLGYQYufxsU14Y4UPdFi9HPM3lCMoASsPemM6WGmY6l878lkkK/5GxtjtZwYCAYM1Og==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Tve81vVebv3rWCNMJlRxiteVr6/6TVPHABTQnRnN0fOybUgx2S8AJpOJNV+n7K5Amx6vBqM3/cDPh8FpEd0DZAKfk7chkr7jw8JlcxM9nIH5zGvE9adfFKlib9h2H9b78wyYjmg6YLcwZz4QAeONAM1G1InS7tgceSzQUH2icwESlswoZCCRaOQvEm5/nE7YsHijfQJGvdjFMu7F1UkWN57VQBx0P+gW/99Ylrwu9U+8SPv9XCib6HkouLa/bj1pz8yUlQISAQhaqureqnH2OpsGaWGjaV/LQ5TJBibMCRXLIdSUhdOcd5lzboxrGdzOu6mc+FVxltlPjcsZIOtRj90cu8CBV0p1pea2c7lNDmoPQgXzDYwWUKdIs4zqf7LPkvQg+DrlJ5BLxN+bm8PKPNRvKT+QjWYpcH49O4aOvfJytFFGVZmG2iV+SaCA6/tCnfk682lf9sBCK68PjfzZF7qIOHO/TDk9LJKf2PWaBtUc73O+y1QN6yMhrBZeA2VORJNCByncGc2m/9GoN0KwjK57JJKLfWgeYCl7r2XyC9lmBz8F6ktmRcaFwuqqT8rENaTsJMXxnuiwBAf1q74eZAAEnkDdazlmhect80+wikLyYwrVms970jdQ1cjobXmY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d598eb37-24ba-43f1-d897-08df025e71f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 04:07:57.1170 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /hhQbx1EQc7o9PC9Vj6KMYeUeXFFn+hHROQykSqK+oFIlrv/4HXhqgODKhXzKawFfv35o7WyveGZDbeHKhChf2Ocb6lHYk9K/1sOy+7R1NE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR04MB9859
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=690dc056c=Alistair.Francis@wdc.com;
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

T24gTW9uLCAyMDI2LTA4LTI0IGF0IDE1OjI2ICswOTMwLCBKb2VsIFN0YW5sZXkgd3JvdGU6Cj4g
RmlsZXMgd3JpdHRlbiBieSB1bmNvbXByZXNzKCkgYW5kIGFyY2hpdmVfZXh0cmFjdCgpIGFyZSBw
bGFjZWQgaW4gYQo+IHRlbXBvcmFyeSBkaXJlY3RvcnkgdGhhdCBpcyBjbGVhbmVkIHVwIHdoZW4g
dGhlIHRlc3QgZXhpdHMsIG1ha2luZwo+IG9zLnJlbW92ZSgpIHJlZHVuZGFudC4gRHJvcCBpdCBh
bmQgdGhlIHVudXNlZCBvcyBpbXBvcnQuCj4gCj4gU3VnZ2VzdGVkLWJ5OiBQaGlsaXBwZSBNYXRo
aWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+Cj4gU2lnbmVkLW9mZi1ieTogSm9lbCBTdGFu
bGV5IDxqb2VsQGptcy5pZC5hdT4KClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlz
dGFpci5mcmFuY2lzQHdkYy5jb20+CgpBbGlzdGFpcgoKPiAtLS0KPiDCoHRlc3RzL2Z1bmN0aW9u
YWwvYXJtL3Rlc3RfYnBpbTJ1LnB5wqDCoMKgwqDCoMKgIHwgMTEgLS0tLS0tLS0tLS0KPiDCoHRl
c3RzL2Z1bmN0aW9uYWwvYXJtL3Rlc3Rfb3JhbmdlcGkucHnCoMKgwqDCoCB8wqAgOSAtLS0tLS0t
LS0KPiDCoHRlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC90ZXN0X3NpZml2ZV91LnB5IHzCoCA0IC0t
LS0KPiDCoDMgZmlsZXMgY2hhbmdlZCwgMjQgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBh
L3Rlc3RzL2Z1bmN0aW9uYWwvYXJtL3Rlc3RfYnBpbTJ1LnB5Cj4gYi90ZXN0cy9mdW5jdGlvbmFs
L2FybS90ZXN0X2JwaW0ydS5weQo+IGluZGV4IDhiZWQ2NGI3MDJmZS4uOTE5MmEyZmJlYzQ1IDEw
MDc1NQo+IC0tLSBhL3Rlc3RzL2Z1bmN0aW9uYWwvYXJtL3Rlc3RfYnBpbTJ1LnB5Cj4gKysrIGIv
dGVzdHMvZnVuY3Rpb25hbC9hcm0vdGVzdF9icGltMnUucHkKPiBAQCAtNSw4ICs1LDYgQEAKPiDC
oCMKPiDCoCMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKPiDCoAo+
IC1pbXBvcnQgb3MKPiAtCj4gwqBmcm9tIHFlbXVfdGVzdCBpbXBvcnQgTGludXhLZXJuZWxUZXN0
LAo+IGV4ZWNfY29tbWFuZF9hbmRfd2FpdF9mb3JfcGF0dGVybgo+IMKgZnJvbSBxZW11X3Rlc3Qg
aW1wb3J0IEFzc2V0LAo+IGludGVycnVwdF9pbnRlcmFjdGl2ZV9jb25zb2xlX3VudGlsX3BhdHRl
cm4KPiDCoGZyb20gcWVtdV90ZXN0IGltcG9ydCBza2lwQmlnRGF0YVRlc3QKPiBAQCAtNTQsOCAr
NTIsNiBAQCBkZWYgdGVzdF9hcm1fYnBpbTJ1KHNlbGYpOgo+IMKgwqDCoMKgwqDCoMKgwqAgc2Vs
Zi52bS5sYXVuY2goKQo+IMKgwqDCoMKgwqDCoMKgwqAgY29uc29sZV9wYXR0ZXJuID0gJ0tlcm5l
bCBjb21tYW5kIGxpbmU6ICVzJyAlCj4ga2VybmVsX2NvbW1hbmRfbGluZQo+IMKgwqDCoMKgwqDC
oMKgwqAgc2VsZi53YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4oY29uc29sZV9wYXR0ZXJuKQo+IC3C
oMKgwqDCoMKgwqDCoCBvcy5yZW1vdmUoa2VybmVsX3BhdGgpCj4gLcKgwqDCoMKgwqDCoMKgIG9z
LnJlbW92ZShkdGJfcGF0aCkKPiDCoAo+IMKgwqDCoMKgIGRlZiB0ZXN0X2FybV9icGltMnVfaW5p
dHJkKHNlbGYpOgo+IMKgwqDCoMKgwqDCoMKgwqAgc2VsZi5zZXRfbWFjaGluZSgnYnBpbTJ1JykK
PiBAQCAtODYsOSArODIsNiBAQCBkZWYgdGVzdF9hcm1fYnBpbTJ1X2luaXRyZChzZWxmKToKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJ3JlYm9vdDogUmVzdGFydGlu
Zwo+IHN5c3RlbScpCj4gwqDCoMKgwqDCoMKgwqDCoCAjIFdhaXQgZm9yIFZNIHRvIHNodXQgZG93
biBncmFjZWZ1bGx5Cj4gwqDCoMKgwqDCoMKgwqDCoCBzZWxmLnZtLndhaXQoKQo+IC3CoMKgwqDC
oMKgwqDCoCBvcy5yZW1vdmUoa2VybmVsX3BhdGgpCj4gLcKgwqDCoMKgwqDCoMKgIG9zLnJlbW92
ZShkdGJfcGF0aCkKPiAtwqDCoMKgwqDCoMKgwqAgb3MucmVtb3ZlKGluaXRyZF9wYXRoKQo+IMKg
Cj4gwqDCoMKgwqAgZGVmIHRlc3RfYXJtX2JwaW0ydV9nbWFjKHNlbGYpOgo+IMKgwqDCoMKgwqDC
oMKgwqAgc2VsZi5zZXRfbWFjaGluZSgnYnBpbTJ1JykKPiBAQCAtMTMzLDkgKzEyNiw2IEBAIGRl
ZiB0ZXN0X2FybV9icGltMnVfZ21hYyhzZWxmKToKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgJ3JlYm9vdDogUmVzdGFydGluZwo+IHN5c3RlbScpCj4gwqDCoMKgwqDC
oMKgwqDCoCAjIFdhaXQgZm9yIFZNIHRvIHNodXQgZG93biBncmFjZWZ1bGx5Cj4gwqDCoMKgwqDC
oMKgwqDCoCBzZWxmLnZtLndhaXQoKQo+IC3CoMKgwqDCoMKgwqDCoCBvcy5yZW1vdmUoa2VybmVs
X3BhdGgpCj4gLcKgwqDCoMKgwqDCoMKgIG9zLnJlbW92ZShkdGJfcGF0aCkKPiAtwqDCoMKgwqDC
oMKgwqAgb3MucmVtb3ZlKHJvb3Rmc19wYXRoKQo+IMKgCj4gwqDCoMKgwqAgQHNraXBCaWdEYXRh
VGVzdCgpCj4gwqDCoMKgwqAgZGVmIHRlc3RfYXJtX2JwaW0ydV9vcGVud3J0XzIyXzAzXzMoc2Vs
Zik6Cj4gQEAgLTE3NCw3ICsxNjQsNiBAQCBkZWYgdGVzdF9hcm1fYnBpbTJ1X29wZW53cnRfMjJf
MDNfMyhzZWxmKToKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJ0Fs
bHdpbm5lciBzdW44aQo+IEZhbWlseScpCj4gwqDCoMKgwqDCoMKgwqDCoCBleGVjX2NvbW1hbmRf
YW5kX3dhaXRfZm9yX3BhdHRlcm4oc2VsZiwgJ2NhdCAvcHJvYy9pb21lbScsCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gJ3N5c3RlbS1jb250cm9sQDFjMDAwMDAn
KQo+IC3CoMKgwqDCoMKgwqDCoCBvcy5yZW1vdmUoaW1hZ2VfcGF0aCkKPiDCoAo+IMKgaWYgX19u
YW1lX18gPT0gJ19fbWFpbl9fJzoKPiDCoMKgwqDCoCBMaW51eEtlcm5lbFRlc3QubWFpbigpCj4g
ZGlmZiAtLWdpdCBhL3Rlc3RzL2Z1bmN0aW9uYWwvYXJtL3Rlc3Rfb3JhbmdlcGkucHkKPiBiL3Rl
c3RzL2Z1bmN0aW9uYWwvYXJtL3Rlc3Rfb3JhbmdlcGkucHkKPiBpbmRleCBmOWJmYThjNzhkOTku
LjA5NzgwMjM2NTUzZiAxMDA3NTUKPiAtLS0gYS90ZXN0cy9mdW5jdGlvbmFsL2FybS90ZXN0X29y
YW5nZXBpLnB5Cj4gKysrIGIvdGVzdHMvZnVuY3Rpb25hbC9hcm0vdGVzdF9vcmFuZ2VwaS5weQo+
IEBAIC01LDcgKzUsNiBAQAo+IMKgIwo+IMKgIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMC1vci1sYXRlcgo+IMKgCj4gLWltcG9ydCBvcwo+IMKgaW1wb3J0IHNodXRpbAo+IMKgCj4g
wqBmcm9tIHFlbXVfdGVzdCBpbXBvcnQgTGludXhLZXJuZWxUZXN0LAo+IGV4ZWNfY29tbWFuZF9h
bmRfd2FpdF9mb3JfcGF0dGVybgo+IEBAIC02NSw4ICs2NCw2IEBAIGRlZiB0ZXN0X2FybV9vcmFu
Z2VwaShzZWxmKToKPiDCoMKgwqDCoMKgwqDCoMKgIHNlbGYudm0ubGF1bmNoKCkKPiDCoMKgwqDC
oMKgwqDCoMKgIGNvbnNvbGVfcGF0dGVybiA9ICdLZXJuZWwgY29tbWFuZCBsaW5lOiAlcycgJQo+
IGtlcm5lbF9jb21tYW5kX2xpbmUKPiDCoMKgwqDCoMKgwqDCoMKgIHNlbGYud2FpdF9mb3JfY29u
c29sZV9wYXR0ZXJuKGNvbnNvbGVfcGF0dGVybikKPiAtwqDCoMKgwqDCoMKgwqAgb3MucmVtb3Zl
KGtlcm5lbF9wYXRoKQo+IC3CoMKgwqDCoMKgwqDCoCBvcy5yZW1vdmUoZHRiX3BhdGgpCj4gwqAK
PiDCoMKgwqDCoCBkZWYgdGVzdF9hcm1fb3JhbmdlcGlfaW5pdHJkKHNlbGYpOgo+IMKgwqDCoMKg
wqDCoMKgwqAgc2VsZi5zZXRfbWFjaGluZSgnb3JhbmdlcGktcGMnKQo+IEBAIC05Nyw5ICs5NCw2
IEBAIGRlZiB0ZXN0X2FybV9vcmFuZ2VwaV9pbml0cmQoc2VsZik6Cj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICdyZWJvb3Q6IFJlc3RhcnRpbmcKPiBzeXN0ZW0nKQo+
IMKgwqDCoMKgwqDCoMKgwqAgIyBXYWl0IGZvciBWTSB0byBzaHV0IGRvd24gZ3JhY2VmdWxseQo+
IMKgwqDCoMKgwqDCoMKgwqAgc2VsZi52bS53YWl0KCkKPiAtwqDCoMKgwqDCoMKgwqAgb3MucmVt
b3ZlKGtlcm5lbF9wYXRoKQo+IC3CoMKgwqDCoMKgwqDCoCBvcy5yZW1vdmUoZHRiX3BhdGgpCj4g
LcKgwqDCoMKgwqDCoMKgIG9zLnJlbW92ZShpbml0cmRfcGF0aCkKPiDCoAo+IMKgwqDCoMKgIGRl
ZiB0ZXN0X2FybV9vcmFuZ2VwaV9zZChzZWxmKToKPiDCoMKgwqDCoMKgwqDCoMKgIHNlbGYuc2V0
X21hY2hpbmUoJ29yYW5nZXBpLXBjJykKPiBAQCAtMTQwLDkgKzEzNCw2IEBAIGRlZiB0ZXN0X2Fy
bV9vcmFuZ2VwaV9zZChzZWxmKToKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgJ3JlYm9vdDogUmVzdGFydGluZwo+IHN5c3RlbScpCj4gwqDCoMKgwqDCoMKgwqDCoCAj
IFdhaXQgZm9yIFZNIHRvIHNodXQgZG93biBncmFjZWZ1bGx5Cj4gwqDCoMKgwqDCoMKgwqDCoCBz
ZWxmLnZtLndhaXQoKQo+IC3CoMKgwqDCoMKgwqDCoCBvcy5yZW1vdmUoa2VybmVsX3BhdGgpCj4g
LcKgwqDCoMKgwqDCoMKgIG9zLnJlbW92ZShkdGJfcGF0aCkKPiAtwqDCoMKgwqDCoMKgwqAgb3Mu
cmVtb3ZlKHJvb3Rmc19wYXRoKQo+IMKgCj4gwqDCoMKgwqAgQHNraXBCaWdEYXRhVGVzdCgpCj4g
wqDCoMKgwqAgZGVmIHRlc3RfYXJtX29yYW5nZXBpX2FybWJpYW4oc2VsZik6Cj4gZGlmZiAtLWdp
dCBhL3Rlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC90ZXN0X3NpZml2ZV91LnB5Cj4gYi90ZXN0cy9m
dW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF9zaWZpdmVfdS5weQo+IGluZGV4IDU0YTBmOWM2NDg0NS4u
NmJmNWJlMTVmOTNhIDEwMDc1NQo+IC0tLSBhL3Rlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC90ZXN0
X3NpZml2ZV91LnB5Cj4gKysrIGIvdGVzdHMvZnVuY3Rpb25hbC9yaXNjdjY0L3Rlc3Rfc2lmaXZl
X3UucHkKPiBAQCAtMTAsOCArMTAsNiBAQAo+IMKgIwo+IMKgIyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMC1vci1sYXRlcgo+IMKgCj4gLWltcG9ydCBvcwo+IC0KPiDCoGZyb20gcWVt
dV90ZXN0IGltcG9ydCBBc3NldCwgTGludXhLZXJuZWxUZXN0Cj4gwqAKPiDCoAo+IEBAIC00OSw4
ICs0Nyw2IEBAIGRlZiBkb190ZXN0X3Jpc2N2NjRfc2lmaXZlX3VfbW1jX3NwaShzZWxmLAo+IGNv
bm5lY3RfY2FyZCk6Cj4gwqDCoMKgwqDCoMKgwqDCoCBzZWxmLnZtLmxhdW5jaCgpCj4gwqDCoMKg
wqDCoMKgwqDCoCBzZWxmLndhaXRfZm9yX2NvbnNvbGVfcGF0dGVybihwYXR0ZXJuKQo+IMKgCj4g
LcKgwqDCoMKgwqDCoMKgIG9zLnJlbW92ZShyb290ZnNfcGF0aCkKPiAtCj4gwqDCoMKgwqAgZGVm
IHRlc3RfcmlzY3Y2NF9zaWZpdmVfdV9ub21tY19zcGkoc2VsZik6Cj4gwqDCoMKgwqDCoMKgwqDC
oCBzZWxmLmRvX3Rlc3RfcmlzY3Y2NF9zaWZpdmVfdV9tbWNfc3BpKEZhbHNlKQo+IMKgCg==

