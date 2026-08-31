Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5B6C61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 01:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0qVN-0006Ks-Lv; Sun, 30 Aug 2026 21:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=696fae14a=Alistair.Francis@wdc.com>)
 id 1x0qVM-0006KO-AF; Sun, 30 Aug 2026 21:08:08 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=696fae14a=Alistair.Francis@wdc.com>)
 id 1x0qVK-0007Fh-Ie; Sun, 30 Aug 2026 21:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788138487; x=1819674487;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=0TloUcCVjRB2Y5CRZ/ZyiNkiFIHkocBE/mpWV/biJfM=;
 b=Day5pc83tUmHR6cMzFjuKyedsrYMXR//z1FctouMSbad21rxoEpBm3xh
 mHybuwxuLRe7+z4jU7HmAsgxiJ9nQtxkJzdDX+XZvzhEcoolX+CCfn/Uv
 Q9jmbX5AjzLoCwsrsVxg6Y82Xwkyip48iIa1WwcIik1MyX4RHTrndap9g
 g30+nn3dHtDDYg23nisUagTh/XHA7xdFKeQNS32HhruBv4uxcaTju74ch
 B2QVtagrbtZRfla/nN7iSllsMMkSbisw+4Uw8r8gMUC1aEqRsdEwUWTy4
 IXciuwQh0EpoCTLZq0639wxFQMDJobHK0wIlzi1ARJ8WAWlCPvMe18Dpv A==;
X-CSE-ConnectionGUID: w8+oI0SXTzO/SXEzFq9+wg==
X-CSE-MsgGUID: tiBV82wURiqKBJrD4BCCDg==
X-IronPort-AV: E=Sophos;i="6.25,252,1779120000"; d="scan'208";a="154585880"
Received: from mail-centralusazon11010052.outbound.protection.outlook.com
 (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.52])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 31 Aug 2026 09:08:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0/upvK9E37LghsypbkbUm6kxnDMlRfjiIU+UUZFu8e2Kh4AOfoeWK2Ire9cT+cVpPAnhbJqYNmtSHK6zUCnf5+ZE/UtoDu9lWF0Ceo1ohGbMho6vvfPXo70s8s9b+jaMr01hcbCaGePuUW78M6Uxfz07qFSg2luJy5lpJ3CqqX1SppjcpkJGBVtWgSM7wRfonclAIeqkAzY2ADUMmS8zU2FEJIy3Dx8ot24vke4GXbZ0z55g/8gNrBkYgDFLKDcGcBrPEvYGhVWzcf9+DTbSKuCZ422SL8lnJBx3leTgAngwl8XEfZTj6OEsp7cLwuCFRURD6lmQNeZJamwrfEHkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TloUcCVjRB2Y5CRZ/ZyiNkiFIHkocBE/mpWV/biJfM=;
 b=K7Adyj32q6Aou0on5riJ2tLcO42vN6qvGFO5QD4PnQjioEyicVFP1zIB2hfL4m8LroyZ8WYwCAj9tgs7naB8ymNls3Hrv3Zhg8cMoV0HblAy5qkk+f59aY5pMf9kPWPQLOpHAVj1wyAH96wcq1mqcm1JrAb/9WNrc27OcHfkQciENsy9I425iThFR6/ULJyvyNYy7iO1IWRmriSgfNJQt3HqXOK7avqWsn9MgL/POJvY8tEFv6Zl1Bn7DBY3FAXZuydyaGITF5bfQUqeOwp3Jh5XdCKQr6MBU2Oki7QLtm9JEvewH/0AxYsDZP91+PG9MEXqZ5AaI7uXkBf044le7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TloUcCVjRB2Y5CRZ/ZyiNkiFIHkocBE/mpWV/biJfM=;
 b=QGzVfKr6HgrLW+BlszxxWPlYFm629JF3agNBVSQCNMrC3SpFpqMr9CDdiLAAo7VEYl16mgGZk4obKU6I6G1YTdsnE08B9pFr48g4tFSaDSI35Pt4HPBnRXf5PqbPXcTxpdApPNm8GOFv0jm1YNfGNJS0xCH6hdN2C2ZsJqQ4Ru8=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by LV2PR04MB993975.namprd04.prod.outlook.com (2603:10b6:408:36c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 01:07:58 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 01:07:57 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "joel@jms.id.au"
 <joel@jms.id.au>
CC: "npiggin@gmail.com" <npiggin@gmail.com>, "mpe@kernel.org"
 <mpe@kernel.org>, "portias@oss.tenstorrent.com"
 <portias@oss.tenstorrent.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "asrinivasan@oss.tenstorrent.com" <asrinivasan@oss.tenstorrent.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>
Subject: Re: [PATCH 01/12] tests/tcg/riscv64: Include stdint.h in semicall.h
Thread-Topic: [PATCH 01/12] tests/tcg/riscv64: Include stdint.h in semicall.h
Thread-Index: AQHdNeJfeBiDsF47A0uV1wQumGaYKba3XoyA
Date: Mon, 31 Aug 2026 01:07:57 +0000
Message-ID: <6239b890e8dea1a7c4571935ef1d472dfbe2ea85.camel@wdc.com>
References: <20260827050953.67184-1-joel@jms.id.au>
 <20260827050953.67184-2-joel@jms.id.au>
In-Reply-To: <20260827050953.67184-2-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|LV2PR04MB993975:EE_
x-ms-office365-filtering-correlation-id: 5873c0c7-cc34-421b-08ba-08df06fc4b8e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|23010399003|10070799003|376014|7416014|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: FYYB31hJP1NFMHRxWLr7jRv98/tq6v46UPp8lZkj0dXeQ0alMMr03XODL5DUyTixLzlRe4YufxPkZkqLInTn7Xg13p+DyJ9mDcTnB7Nk/R21hpbA8HxFosJvAQ1XVJm4IaTa/PNdtBQqB0Cbj9AUTRMq4MIpPkPRe+PYHWZ7OXsR8AL/DiCNmM3zcVgo3e5QX/tV4wMsP5ESQQdqbo39qYPXGAdbI1rAagSZ1GiMc0rg/xfeCO0iFSef8fjRnZ3e8EMaTocb+gBVIFF+jhEeH6WGNxCfve9TAIQqlZ8nYizVOmiPICBc+AlWO7yRUk2FkV9LGhNxlnvSUSWojGe1TaT3IGcDK8cEtA1lM4Oj5dk2bT1jglM+YReWL398S73njc4m8J+kJIe+csLE+AtRgBEEcu2JXQ+w4hyOUUP6CKaw3XNV8t/0/h7atz6r7S3eTd5BBm5f2225+AgO1hyegU08umaGMG92ZOt6079saVhEzjVYIeY0QQA/nLisYSMjLV6pJ549Q8hyvd7S4XDmF54qt6IyrjPL9nVklyg1J/OeSb8LGrSHfN/7RF4jZaZvEApDovrSHp4KvhBhl6QQXUdiWB1URu84bxfPxfKCqafnNTiyf6CsGfHBaaITjVYM2ReROK9HqTxSv2OPGSYr/wFtBnFs6LwpoXsj2LU3oFJ/KrZf3EWoKDSf+Meb9XiOivystValgMnlDK4oPi9t2HyNpdtPAET+bKMT1553TBQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(10070799003)(376014)(7416014)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmxEaE5tcGxOaUdTVlF0Zm14eGZRbm1ZOHY3M1dCamthMEphQSs3TWJUNkJS?=
 =?utf-8?B?Y1czbDZJNUNPRzJyVmhaZXdjYnhDUEVpdXV0MVJ5b3YrYkV2dDdZcTljVU9D?=
 =?utf-8?B?cVpCcExnYWpDdDlaYUhaTW1oWTBJQlIzcXBMbWI4eDlWYTdnQXliMElSL2dZ?=
 =?utf-8?B?ZXB0Q2lWdFcrU1dkNE9mRGlwdm42TnJFbURheXFIUE1SMWdlODF2MGE0MnNR?=
 =?utf-8?B?ZE8zb0V0cVpEbk5HaVE4N2Y4eHQxa293UVVWRUtkL0Y3a0phMEVwMDlGOTJ4?=
 =?utf-8?B?WkFWdDV1WTRjZithV3h2cVhsYUVkWm5CTExrZks1d2FNSWVtVnpXdm85eWZN?=
 =?utf-8?B?OWdXTzhYdkdadXFDbFBQbWp6Q0NqQkNXY3lGaW5LWjZHSjBlQnBtTys5ZXJh?=
 =?utf-8?B?bU5OdlY2ajNZaEFISklrbXFaV2tDNkg2UC9SZzF0SDRHQ0M1dWlRUnZRRThv?=
 =?utf-8?B?WjVjTzdRZEJWREZlWGFNM3kzTXJrSTZtaWRydS9wMTcvNnZZTTNpY01udTZm?=
 =?utf-8?B?TXgwY3dDS281VDFsbnVjano3Zjdicy81NUdQTnFYVFhhVmJ6b2xqREFBVkFo?=
 =?utf-8?B?YUdFdlZaVXpWbmU2bEJNemo4MUJhNm1mMHZtTmJia0wvTTdJNVU4bmFHS0Rh?=
 =?utf-8?B?N1kzdGFscW5ZWDZ0d2xVNkprNlBBM2xUcE00MHgxelBhbXpCUzd5d2FPWEpD?=
 =?utf-8?B?MUlwSU41dDN5Uk5VUzR6Qk9DVmxUZUxZYzlXWlBGVDVtcGRhOUlFSCtjdjlr?=
 =?utf-8?B?cnpiL0JVREhPYUx0R2h6eFFzR29zSGQwWGJ3U1ZPSmQ0RG1qRkpEMjVoSmE1?=
 =?utf-8?B?aFZPeUpGUm9OYjFqTVR1dHZVaVJ4Z2c1dEdhRStJTEdTV05DdFB1dHhEN0RP?=
 =?utf-8?B?bWh3ZTlaaVl2K2Q4MGkzTi93Sm92Q3RaZjV0YTRwd0haSjF3SjU3R1dadVFh?=
 =?utf-8?B?MmM3bEJnSWp6ZVpWbXNudTFUSTk3TjM2Uyt6ZUNhWDBWdW5VQlZEMmYxNFJl?=
 =?utf-8?B?bVB1YlllSlpZRFZlVzdNbDVFZVhEbityL1JDWmdOeUszNEowWVJNMFhtZVk5?=
 =?utf-8?B?dklUZGl2V2ZqMmhOZ0QxR2FRbEhTbDgvblpvcHVHTjFWUFJJZENMOFc3U1Vl?=
 =?utf-8?B?T0dMQWloNDlJN1ZyRWxMWnRvT2MyMDU4N3YzalpWQldpZDUzQVd4Mnl0eGV0?=
 =?utf-8?B?RDFXZ1ZBUUxzN253ZjE1Ri9xVXA3VGtzTmNGZFRxa0ZNUDRtMHA2akFZOUdy?=
 =?utf-8?B?N1NtTTdyZFdoRkwzZDBlS2krKy9rdjlkOURxWlFTL0JrMFp4cmM0SzZuN1ll?=
 =?utf-8?B?RU96eHVoRlhCbGZldmRuNXRUd1VaU0JLM1RFL1JzRXVMZSs4dFNIQXRYdWVp?=
 =?utf-8?B?RjRlYUN0Q3hUaWVyTTBsTTN6NFV2M0FmaEIyb0NPRFAzUHJiNVRPYjh5VHhE?=
 =?utf-8?B?MWlVREVPTEN1N055U2VPOVVBZis2UEkwMFVBMElFcWtYVVkzMnRCVDAxaFhG?=
 =?utf-8?B?TVJIcmFmWkhkTmUvWXhyYmh4RFVlN1lKUlRNTmdoalFVOVBaNEFIdU1NbHh3?=
 =?utf-8?B?dTA0dUpNU3p2Vm9rT1oxNkVxbDhHSU9za1VUQmhaNFdJKzBJeVdwN2plVGh2?=
 =?utf-8?B?MUc4UWwzWHNQekUwYmptR0JzM1RzejlKVHBBVEpFODU0TTNyK29acnUvYkJO?=
 =?utf-8?B?R2VvQmpOVlFLWGdoUU9XRVBuQ2ErMCtPbUlOYk1xbDlaaFRteDdpMVJXZWhs?=
 =?utf-8?B?Z3ZMU1B2UkFCeFVBUGJJRWtIMXNSMlZiYlFpdkNVMlJ2Z2xCT2w3Qi9rc2Nr?=
 =?utf-8?B?b0pmZkpjeXoxTVBJcVNWak40N3UxYWNYSENDUDRFaHVyVWtjRHZpd21EVStC?=
 =?utf-8?B?V1kvRWpMK2RSQ1lIdnQ0YTBaZ1paclBVQWFLeGRmTmh0YVhRd0RHclV2bWUv?=
 =?utf-8?B?amFDT3ZKanNlR29ZZXJ5ejdOVDNzS0VjbEtiRmZBUms3bXYzcjJkT1BWUG5x?=
 =?utf-8?B?WW5ZK3AwcWd5eVJsbnRqL0RYMTBFbnQvUlhaVkkzM0piR2dDRi9GQy9nTTg4?=
 =?utf-8?B?N3NENm42d0xFWGUxRXlPamZyNEFyR2xHQTk0RHpUblNKT2dGaTVySVhUcm9a?=
 =?utf-8?B?Wm1taGxibFowbE1CN1ZpWmpFQkt5ZEdiRFZEb0tjSlJkL1JQVUFiTDF1Zmda?=
 =?utf-8?B?NUcxdzJrdDUveTBjZzg3VVZmNnJ6THh4TEhscllpQ3NZUkNIZTNFREhpem1K?=
 =?utf-8?B?a2hoZG1XUzBueFpQSmZqdTEzT3Q2NVc2T1VrSGcxN2lUM0xSUDcya3RFL01i?=
 =?utf-8?B?MHg4MThJQVBid2dCdkNOUGh3WGtOd1d2aWJRckhWMGRJcUNaMXJyMzVNbWVC?=
 =?utf-8?Q?T8tyL0J3SqGkz9xqquHwmxVRXRiqIqLTpxJa1TjVF5j1H?=
x-ms-exchange-antispam-messagedata-1: l6QyOSoDu3+IuH9NqIqDf9OsKNt+RjmPt58=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6469D43C90289746BADE2E3F5AED9AEC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HKy5g5FQtFI/3sG2yDm+ikqJ7RR6+rgTi56pG6CEdyrBUYYG5uLd9sL1xELZ6clUA2cxymMUcylxzHE8cQFj1UeY/tDanBK++FlblEqHicZl3B/7S+4kpiodc00cjCXwTsOPztZFy29mkTjJpIq2iTuQMoOAwKWep70e8nlu+4HilL4XTqhSCg1JmeZIl6DtQ8Xo2HbsOHfc1sEd0yemXDfpvGWkxjzwiIN+11us55AFg6nfr4Wl5Z8QjGtvoW2xWx70fKAoEFmdv3FLPKP7QagcnXhub8VQCox0FGMRKX+3PCpd0OcMGIgCchVRljD6pRYPyzk/zxV5Htyk/QRLBQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sPWK83dwltEUF2JmG9koW1tIw7UU7Dsd9XaQRKIlbyRsxMdJPoxuDtDMlYJrpMbyLwsse24xtve92OPkJnQto5OePRJcg0/XmkyEYriI3JK86odGcXrjJvFrxSupqbQorNR7/fAlF64AZyCtDMNah3q3c5Ax1lEWE+spdj/hhNu/Hl8Nj/bgKPx3HIEzWDIijV1W+sniiXbdcuDjSpmUkZLi4kKP2EkHfRcoHEfJ8HOkfYVW4Tw+Wg/fgkUxMHn5SJd1UDX3dKrgfOa6jDZqABAtTlo39WTR8JEtoffnqH3s9Fl2jv7Ng97sZupC236puMeTUriC+8V/SBsBnl/iHv1vVH8Lho4CeVBHgraJwhicxRuTw5rOLFZQzP9dl7v/q4gbuXZaJe1moLBzzqYNWlKuy3nH9fYPu8a6+nJhAb33Y9YFCr0BalD3Yqx+qbeqI3lWFZ5FExfkqb8BIhd9Qa9yIzG69qTz/bYQgKoJ2Y2ujz3E9m5Cw1nHEDAkqN0VyOdHU7KJiDJ4F6YPs9oJGjTc+0JSi2pf+muqB5XaT2Eq1i9L4xHFytA0GQNF4Decuq78N2hO0qvk90H9ZQ9syuoUZLgDKZX06PQKDwzmyA7GfqpEZxL74NBQ/2XAPGJV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5873c0c7-cc34-421b-08ba-08df06fc4b8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 01:07:57.8652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vu06GPNV7+tsy21pz/sZ74Tqv9O9lA+5Va4GaJTGWDNoZt6l5xg+v6CxRuwaZMXOFgkiS4pYAhbRrrEy4K9Cc7jhJakElq0hwmHLJKNuS+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR04MB993975
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=696fae14a=Alistair.Francis@wdc.com;
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

T24gVGh1LCAyMDI2LTA4LTI3IGF0IDE0OjM5ICswOTMwLCBKb2VsIFN0YW5sZXkgd3JvdGU6DQo+
IHNlbWljYWxsLmggdXNlcyB1aW50cHRyX3QuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKb2VsIFN0
YW5sZXkgPGpvZWxAam1zLmlkLmF1Pg0KDQpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8
YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoHRlc3Rz
L3RjZy9yaXNjdjY0L3NlbWljYWxsLmggfCAxICsNCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0cy90Y2cvcmlzY3Y2NC9zZW1pY2FsbC5o
DQo+IGIvdGVzdHMvdGNnL3Jpc2N2NjQvc2VtaWNhbGwuaA0KPiBpbmRleCAxMWQwNjUwY2IwNmMu
LjJmZGQzMjJhZjkxZiAxMDA2NDQNCj4gLS0tIGEvdGVzdHMvdGNnL3Jpc2N2NjQvc2VtaWNhbGwu
aA0KPiArKysgYi90ZXN0cy90Y2cvcmlzY3Y2NC9zZW1pY2FsbC5oDQo+IEBAIC02LDYgKzYsNyBA
QA0KPiDCoCAqDQo+IMKgICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0
ZXINCj4gwqAgKi8NCj4gKyNpbmNsdWRlIDxzdGRpbnQuaD4NCj4gwqANCj4gwqB1aW50cHRyX3Qg
X19zZW1pX2NhbGwodWludHB0cl90IHR5cGUsIHVpbnRwdHJfdCBhcmcwKQ0KPiDCoHsNCg==

