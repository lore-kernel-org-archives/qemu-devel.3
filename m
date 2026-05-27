Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B88CD5BD2
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 00:37:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS2HC-0004ee-Ip; Tue, 26 May 2026 20:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6009f06ea=Alistair.Francis@wdc.com>)
 id 1wS2HB-0004e9-2b; Tue, 26 May 2026 20:37:37 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6009f06ea=Alistair.Francis@wdc.com>)
 id 1wS2H8-000139-8Y; Tue, 26 May 2026 20:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1779842253; x=1811378253;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=tO44x/kRTMfR7sm+zZXk5MOLbOMlQfQuYLqO3Eu7aL8=;
 b=ibCa2aHbJIexakHD8XkVN9wsx66eMc0wko7Tt8zZACb2kPlKE4Tx5mf8
 4W5Z6oltf6oFtcwqzc1guK6BbCTtWGesyAWK189VZIHnRP28CtIM2IYzV
 /AIs6khr4+/oImlXBivbd+SzjnAGdLzmUoFPEu4PBBVoJzWxmo/f97dIh
 oHHrkxqvB8RWjnU4i4KHl04bUXfBtyMSaozv+z7tE5xzj7RMdRAMQ88JB
 jg4aBLO38uT3lqtsxBIus+dZUEZjrs/ZQOg7sEsvsBxh272STPLUU+90z
 d98Y8AZiLLsUl92s6pIU6p4lWgAGZgA/Qmg7leIhOYtXvWh5pqEHPg3NU w==;
X-CSE-ConnectionGUID: BVvM31yxRAWHj14WfY+mMQ==
X-CSE-MsgGUID: 2bjwO5WlSf+t6BiBTCMw8w==
X-IronPort-AV: E=Sophos;i="6.24,170,1774281600"; d="scan'208";a="147470973"
Received: from mail-westus2azon11010061.outbound.protection.outlook.com (HELO
 CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.61])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 May 2026 08:37:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7N8EEblQjIiYJbaB/FhCwz4ewk5X5zhIzTjBu0YUrhl/jpQphonECq+TDg6r2J7FWSoZQacbJTQh8ny605FJaPh76wsNRhciJ61HH/NAyF+5ROHIakN4OfBD3kWmMv7Nu8Au8uYuN7rCdS9x422IZ8JCodTE/852pBhbTIeglbvjVafstN6DiWWZSb161h2wGoMdbH4OELe3JGTUd7PFgU+gA41iNx22FDuurw6zLhw/Ul5obqnObY6Pj3mIEthzl15fFTf1agd/NxStJuIwcErMaeIuuD0Wt/YYCN9Pk1Ua4glC6vKm4n6tIHVJEveLq1og4wHaoRLpQ9RqHxfPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tO44x/kRTMfR7sm+zZXk5MOLbOMlQfQuYLqO3Eu7aL8=;
 b=y7JEW5eLxuXURMoDrFvQMPcz0rzOsYLYWkJdJGKJz1AsWT1SkAHjp5yQxAegO5dlF7rm5838o42gQV0AsLuXLorhgV28lDqA3heIXAY7KZVw9nFsqB6z1K4KzwPLH7YtfGp7bXmSPLcvQFjK3z6P2bGAAl8AhZDkx5s0VaA6//qRJi+XUKCh6Z+HWQj1H/NOJPk+eZM5nqfxKCjAMy6c6Ft/vQcWZo2Rmk6obb+ybcTY/QWqypZWft/2sOKEJxPRi218Fk8EGq/cut7m7/ouuKYFslKsZuyOpCmU8WoZdAX1ERektgmZilNceS9nl45hunfMD70yFo+XGSlLG7/x0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tO44x/kRTMfR7sm+zZXk5MOLbOMlQfQuYLqO3Eu7aL8=;
 b=K4oAtAEv+HX8sqL+/UHXeN9kwewUQ4vY3DAeKMy9bmgldDLCKlTVZHWQ9WKLLXWHaJCogSdWG7UVWTjWGyUc9VFb14Sy/DOPrI4H+OtjZ2Lv4qE5tW198by1ue2Tx7m118EjLxIiZD0dmCpS7zEQmVpJbtAwMKGstu8UHREN3x8=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by IA3PR04MB9088.namprd04.prod.outlook.com (2603:10b6:208:525::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 00:37:25 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 00:37:25 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv/insn_trans/trans_rvzicbo.c.inc: save opcode
 before helpers
Thread-Topic: [PATCH] target/riscv/insn_trans/trans_rvzicbo.c.inc: save opcode
 before helpers
Thread-Index: AQHc6KI6Uj/o7S7uaEe/E8JpueSeE7YhELQA
Date: Wed, 27 May 2026 00:37:25 +0000
Message-ID: <b40651d7a54f854a4fa649864789450183fc04a4.camel@wdc.com>
References: <20260520214704.1943652-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260520214704.1943652-1-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.1 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|IA3PR04MB9088:EE_
x-ms-office365-filtering-correlation-id: 555b4cd8-54c2-4377-e918-08debb881fc3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|10070799003|376014|366016|1800799024|6133799003|38070700021|11063799006|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: jhIKWvTJHYGKz7Tm78o/+7QMtor7911Xn65S3rBq7GaBA2WJqUPNnsUsu3JjkIx7hKa99EZZz77XVsfSJesDlBF9U3ghgLNlwCcJXcPbPxpzumZLxS+OZwWUqCYnkkEPt9NcJrrbpajBCOQZlq16Db8cvUeH5q+gZFnzZGjLFsmLolyDyGwec6tGF3I8BT1f6TTV94+383MX5w8O4hxHduJCsLEFirhUXQqEUas6vqGJTjMUNwSEok6ej9GM3Geqhq1G7PhXsSvlBKqnpIJR7+ylUPYkMrXlTXRIH/a8fgjJK1N4IGljOGVnPeI3eTokEOb56McD8n3Gyg2xbQpuBJTV0T681XZQnnuRQuzm8C9LyAXRBH1+Zt6VgPGxNzKj/gY1tlJWRwc55UZW9JGlZS3bMAI1EB/++rmIkHPzVSdlqks+bhsi2Zba8qj0qHKuzsATxyuDrT1OA+zp5eQG0KB9YuuNXsDOClxwvGZ4LYxPIy9qrBjuendvgKAqouRhy6GisLQzxy/lY4i0LmYGWwcVT1M3KxkLWcn/ocULgTANhWtcmJq3N9+Rhfo3MfgPin1U7zuX8ySMfP2Nvdxec0ATt2hbBWRdnVPNMSAz/rlg7idVf4kyTZLyZgMFdsEJVc0AG2AAPJQ6t7OvHAkfn3Ke9IwjG8vW7E1eVnDJ30HpDHOSd9pPQBM85xWlelE+PejQus84em7RMT2fA/c2A4UDEP56HcUNGGD6FPO4OV0oLKi05xEwmmy7AtSdY2XS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(10070799003)(376014)(366016)(1800799024)(6133799003)(38070700021)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWFjUGlTT1Q1RTIvQkREMStOOU12MjZtNWo5cURjMkplYVpIZWNLOXpUMGhO?=
 =?utf-8?B?NFM4bGlxd0xnNHdIeWdIMWRMdWVGakpQcS9YWW1mTjVYRW1Ib1NUMFYreXN5?=
 =?utf-8?B?VnZxUmZnVmlVRU9UUEh2TFBvOXpyOU5HZXFuTnR0d3NVcVc5MHZnVk12OUZP?=
 =?utf-8?B?eS9SOFhEMWVWaVAwaWtlQnAxWWhSQlVONmJQZUxJU2hWSWc2NGhrdE56K2Zz?=
 =?utf-8?B?bnlBejRYc0NtN1J4cVgwT1RsV0k5MTVJcnpPNkVlaUR5cEJYR3ZVVUk4VURs?=
 =?utf-8?B?WWphUm41MGE4ZDFSOGNGODgwZ0UrN2NzSnBrdXBtanFRUnROdnJJZEowS3hh?=
 =?utf-8?B?WG5kcW9qS0d5b1hPNHFobkRVd1dVbGRQQm1YWERwRmlXOUdRVkU0LzhtbCtX?=
 =?utf-8?B?UWc3NmN5bFV2R2YrQVVlUVo3N1NIbHlSckpHcGE2V0ZPN3V4VnRNamY2eTdC?=
 =?utf-8?B?UHlkMWU4K1lVeHN2TmtML2FqMmhJVTJnamxXbkY2OHRKR2g2NTRuUksvVEJV?=
 =?utf-8?B?RHlhS0ZSZ0ordUJvUnA3Q0NleExYT3dUVkFYNFJJdklWbzV4U25wa2F3VlEz?=
 =?utf-8?B?S3cxM0FJUXg0QjJQRnc1ZG9Oc1MyNDNoU0lsbEQvTkdQbzBQVnVzVlJpOVRP?=
 =?utf-8?B?bTlkUEk4TTZ4YVlaOTBucFdtQ0pCcmE5UkR4bmZ4bkxVZUNRcTQyUHZudjk5?=
 =?utf-8?B?cGhPMVB4VWpuNVBuZ21paVpMY3VnWHl0WWs5Z0UrSGZaMktlcHhSR2lCYk9I?=
 =?utf-8?B?eGVESWxoNDFrczNXOHA0MmpJQ0REV3RMeGoxaG1hdDlaaE9qTCtQOTdySHhv?=
 =?utf-8?B?bXZwYXQrb1BZNXJqTnFjTnczSmFXWGlDUG40KzAzME42bTFqQ2dQR0p4K2tS?=
 =?utf-8?B?UUhDaFBwZENNU3Z5YlF2TjJHZm1ac015VGIvZk84SWltL0U2VVlmWEp4L2lm?=
 =?utf-8?B?MndGM0pnb0JNNVRNVkxkQnBHSnJHMHNmR3NScis2dTNvSHNQU2UyT2d6M3Bo?=
 =?utf-8?B?TkZiTUw2UFpDd2xNeVAxK2NYRFFsWHl3TGhkUTVGS0lUZDNCV1NnNWhxZU1l?=
 =?utf-8?B?UFlhdkRKelNIdUdpdzJEQjRTSUZnWlJuWlZrQ2poYU9XRTI4YlBHUDlOS1Nh?=
 =?utf-8?B?aHdZaWVuRTVGRWY1ekNndkNNTWx6cUNhUzQ2elBDeE1uOTZROFF6Q0I2WGxY?=
 =?utf-8?B?UlhOSE5wQnArR1QxNEFtdFBTYWhQWDhJVmtmdHV2bGludkVMTzVtQkptbU5s?=
 =?utf-8?B?ZmxuY01Rby9BV1BTZEF1WWZTa2lMcGlFWmxPUTBUTHRrQ2VQaWtSWUcyOWM0?=
 =?utf-8?B?aUtHUlhJNlRkQmtTZE5LakhjQnZKdVEvT0FvVnhGSWo3TndpK2xkQmlrV2Vs?=
 =?utf-8?B?MlpLNFFWSkhjejQzTFVPWHVmS25ER1JYMWl2REF2MFQrRW9PN2ZLeENZb292?=
 =?utf-8?B?ajhiZlN3LzJmZEdqcXNYTW1teWZjeFN6bGxVb2htMWFFd3hESTlDQjRaRFNr?=
 =?utf-8?B?aGhON0lSNDZFSlVZRHV3UzVaREdnNlIwVzVSRXZHVm5Dd0o4cDc2bG1FU3pS?=
 =?utf-8?B?VWVMN1JXWUVFOUI5MU0xSHNJQWkrZlBhSWJvbURyd0treCtWT0V2S2NpaEZp?=
 =?utf-8?B?TFpGd2kyaGM3djQ5N3RuTEMrZGliekp2TEFZQWtXd2dkZUp4VndDRWpQQ1p3?=
 =?utf-8?B?OGZDUnBBaHRnd21BaUhFMHFSbXlGQ3Bwbi9hTXhLTFFEZEF4bmkyWnVBeUZz?=
 =?utf-8?B?MzkrY3pSM2c4NXh2Yi9ITUtEekhvMEh3b1VGTzluc29pbWsrQlUwbkE0WDQ2?=
 =?utf-8?B?UTcweVBiTllBT1llOVJ1RktHalNjSStFN0h6czE3V014R0VFVC9Za2VaVVRT?=
 =?utf-8?B?T1E2d1ZxbVFhOTdjSFBmWHpOUnhrOEFtN01qdkV6bVk0NDBiNjJzK0xRVzM0?=
 =?utf-8?B?TklVdTVPeUQvMGg3VFRieHVNRzhjVjFBRUYrNXJGcUY5dzlrMmNURy95a0JG?=
 =?utf-8?B?UjFyQWkyK2YySFZCTGFGOEJ1aHB3T1cxTHpLelVFTXF1SWVZbElQdGhmaUxa?=
 =?utf-8?B?MTVKVENnWXdXMEg5MVhUeG8yeTRZTFZwdWEzZ1lTNzkwSmJkdGFKUjlsVGg2?=
 =?utf-8?B?cHNkR29IZHkyVFRmYkxMNTRNUUxQNWJxVjIrV3NqZkszdmJvaWdvL2g2VldB?=
 =?utf-8?B?OWsxN0E2eUZDeGQ0dk9IWXZPdHNDWWZ5dU9TN09TczFwQ0w4dkF1M0tacDJa?=
 =?utf-8?B?a2JVdE4zRU83MFBKeHU4MHNqR1crc0Q1MzM3UjY1bnYvbEc3VjZ3Zi9hdmtD?=
 =?utf-8?B?SCtaMVNsY2VuWm4zN2thMFRlMHJyMEpnK2FJUWsycU5oemtJeWFCelJ1QWRz?=
 =?utf-8?Q?Kf83D8M9VliZMOpH5Tz7/Qq36UDq8wQLMYITQp9qZjXDl?=
x-ms-exchange-antispam-messagedata-1: +J4wUaTp3tRucbsC8/VQOaHBb+cFIr38zFs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33C7B377402CE148BF9E7CD70DD81715@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BP83dMtb7ntf5ei7a0VkEr3aRSVHgacvj9Uy/pj5mvDPlvWlAiMcb2XJI+Fg9twkxWjtv7aLLySau4lWNxwoRwHx3brPTUlY1SY4yxvU/qK5GCcMC5KoXJGtDTIfDxr1PD6wxdUx/NAdeetufGAJoY1TVy8WEQEgtHVim7beVY1MRLkx4ldEpv5JkB4w8FcRfk8AccRKaE1oighQUbsTGazWRpHVmqhsNjdA/b3YrG+cle6FnxASpQfO/7nEaFYzxaqf4xeHh3QvLcQrbT4aMV8iqek42g6cUeNBCCsWAlQyeKyJBS0mWQlEe8xeX9Qt0fhNwdzMCWMy1OXVYd+ORA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SkePdHT2lVNgIAItxiz9L6193ZverupEYaatNJKF31OKmyDNXJYW1Y39tQFcQTowf4C3bXWUYWn2kjVXlADR6WnvtB6cN93DZK5rePZLC5ZGN4MlAgnmc795m4ha4Kc4uBVorjrb7LNJtc6wPG8iqo/yIUN8dKmzcfrglcbW+88a1LF9SeV2yX6XXlEe1GyCw3u24qaE8wJw7HdEpmglXlbaG1+H4w6ebolRowPliGWkuNXGFFQ1R/uMtVfkJsgL2PzRO6kK1XK2cytIE/JYVc5ywbP1KFB+/jRWlKqmV6+Wi1nqiCvA6lxwAvi1zuyW+gQI1yG3WPG01+f+QrRGXzkG9guYm4AhqLa9QCzDEaPbf+2a/KevHRkj9GjE14+pVQMZujJH+9f5sC5JEIc/e1mu0s6Vvrht6jTFLByLmG10zOL546BNYMOxl+Ipv2kjsvkiCN1XT7oAqQ6+/1vkFp7XQfxuAKPvg2uN6CCH/LA9naP+bISy0b/QFsKlw7zsub0Vw+6ltc0mtWpSLvSOCct9cII72BZbVwfKz1EOmuAygItkKip/J+68drfyKA2uhf3HG7+5pIgvKeAL9oqPaFXiZtoxacma2yyxM5EiabUe5nRMQQZq7D9zEwPzRXHh
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 555b4cd8-54c2-4377-e918-08debb881fc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 00:37:25.5706 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6B0+H2wxbwB59U3IlQxgPc/q9MBUzi6tKAtdZrHajXNUn0+5AQhIratbn5jbj5U5AjTgzNaNSR1sZsLny86IVDJH46FVp1YEsxL2CRp4H9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9088
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=6009f06ea=Alistair.Francis@wdc.com;
 helo=esa1.hgst.iphmx.com
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

T24gV2VkLCAyMDI2LTA1LTIwIGF0IDE4OjQ3IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gQWxsIGhlbHBlcnMgZnJvbSB0aGlzIGZpbGUgY2FuIHRyaWdnZXIgSUxMRUdB
TF9JTlNOIGV4Y2VwdGlvbnMgdmlhDQo+IGNoZWNrX3ppY2JvX2VudmNmZygpIGRpcmVjdGx5LCBi
eXBhc3NpbmcgdGhlIHVzdWFsIGV4Y2VwdGlvbiBjb2RlDQo+IGZyb20NCj4gdHJhbnNsYXRlLmMu
wqDCoCBJZiB3ZSBkb24ndCBzYXZlIHRoZSBvcGNvZGUgYmVmb3JlIGVhY2ggaGVscGVyLA0KPiBy
aXNjdl9yYWlzZV9leGNlcHRpb24oKSBpcyB0cmlnZ2VyZWQgYW5kIGVudi0+YmlucyB3b24ndCBi
ZSB1bndpbmQNCj4gZHVyaW5nDQo+IGNwdV9sb29wX2V4aXRfcmVzdG9yZSgpIChjb2RlIHBhdGgg
Y3B1X3Jlc3RvcmVfc3RhdGUgLT4NCj4gY3B1X3Jlc3RvcmVfc3RhdGVfZnJvbV90YigpIC0+IHJl
c3RvcmVfc3RhdGVfdG9fb3BjKCkpLg0KPiANCj4gQW5kIGZpbmFsbHksIGluIHJpc2N2X2NwdV9k
b19pbnRlcnJ1cHQoKSwgd2Ugd2lsbCBzZXQgKG0pdHZhbCA9IDANCj4gd2hlbiB3ZSBjYW4sDQo+
IGluc3RlYWQsIHNldCBpdCB0byB0aGUgY2JvIG9wY29kZSB0aGF0IGdlbmVyYXRlZCB0aGUgZXhj
ZXB0aW9uLg0KPiANCj4gUmVzb2x2ZXM6IGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11LXByb2plY3Qv
cWVtdS8tL3dvcmtfaXRlbXMvMzM4MA0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgSGVucmlxdWUg
QmFyYm96YQ0KPiA8ZGFuaWVsLmJhcmJvemFAb3NzLnF1YWxjb21tLmNvbT4NCg0KUmV2aWV3ZWQt
Ynk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCg0KQWxpc3Rh
aXINCg0KPiAtLS0NCj4gwqB0YXJnZXQvcmlzY3YvaW5zbl90cmFucy90cmFuc19ydnppY2JvLmMu
aW5jIHwgOCArKysrKysrKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4g
DQo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvaW5zbl90cmFucy90cmFuc19ydnppY2JvLmMu
aW5jDQo+IGIvdGFyZ2V0L3Jpc2N2L2luc25fdHJhbnMvdHJhbnNfcnZ6aWNiby5jLmluYw0KPiBp
bmRleCAxNTcxMWMzMTQwLi4wOTZmN2RkZTI3IDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3Yv
aW5zbl90cmFucy90cmFuc19ydnppY2JvLmMuaW5jDQo+ICsrKyBiL3RhcmdldC9yaXNjdi9pbnNu
X3RyYW5zL3RyYW5zX3J2emljYm8uYy5pbmMNCj4gQEAgLTMzLDYgKzMzLDggQEAgc3RhdGljIGJv
b2wgdHJhbnNfY2JvX2NsZWFuKERpc2FzQ29udGV4dCAqY3R4LA0KPiBhcmdfY2JvX2NsZWFuICph
KQ0KPiDCoMKgwqDCoCBSRVFVSVJFX1pJQ0JPTShjdHgpOw0KPiDCoMKgwqDCoCBUQ0d2IHNyYyA9
IGdldF9hZGRyZXNzKGN0eCwgYS0+cnMxLCAwKTsNCj4gwqANCj4gK8KgwqDCoCAvKiBUaGUgaGVs
cGVyIG1heSByYWlzZSBJTExFR0FMX0lOU04gLS0gcmVjb3JkIGJpbnYgZm9yIHVud2luZC4NCj4g
Ki8NCj4gK8KgwqDCoCBkZWNvZGVfc2F2ZV9vcGMoY3R4LCAwKTsNCj4gwqDCoMKgwqAgZ2VuX2hl
bHBlcl9jYm9fY2xlYW5fZmx1c2godGNnX2Vudiwgc3JjKTsNCj4gwqDCoMKgwqAgcmV0dXJuIHRy
dWU7DQo+IMKgfQ0KPiBAQCAtNDIsNiArNDQsOCBAQCBzdGF0aWMgYm9vbCB0cmFuc19jYm9fZmx1
c2goRGlzYXNDb250ZXh0ICpjdHgsDQo+IGFyZ19jYm9fZmx1c2ggKmEpDQo+IMKgwqDCoMKgIFJF
UVVJUkVfWklDQk9NKGN0eCk7DQo+IMKgwqDCoMKgIFRDR3Ygc3JjID0gZ2V0X2FkZHJlc3MoY3R4
LCBhLT5yczEsIDApOw0KPiDCoA0KPiArwqDCoMKgIC8qIFRoZSBoZWxwZXIgbWF5IHJhaXNlIElM
TEVHQUxfSU5TTiAtLSByZWNvcmQgYmludiBmb3IgdW53aW5kLg0KPiAqLw0KPiArwqDCoMKgIGRl
Y29kZV9zYXZlX29wYyhjdHgsIDApOw0KPiDCoMKgwqDCoCBnZW5faGVscGVyX2Nib19jbGVhbl9m
bHVzaCh0Y2dfZW52LCBzcmMpOw0KPiDCoMKgwqDCoCByZXR1cm4gdHJ1ZTsNCj4gwqB9DQo+IEBA
IC01MSw2ICs1NSw4IEBAIHN0YXRpYyBib29sIHRyYW5zX2Nib19pbnZhbChEaXNhc0NvbnRleHQg
KmN0eCwNCj4gYXJnX2Nib19pbnZhbCAqYSkNCj4gwqDCoMKgwqAgUkVRVUlSRV9aSUNCT00oY3R4
KTsNCj4gwqDCoMKgwqAgVENHdiBzcmMgPSBnZXRfYWRkcmVzcyhjdHgsIGEtPnJzMSwgMCk7DQo+
IMKgDQo+ICvCoMKgwqAgLyogVGhlIGhlbHBlciBtYXkgcmFpc2UgSUxMRUdBTF9JTlNOIC0tIHJl
Y29yZCBiaW52IGZvciB1bndpbmQuDQo+ICovDQo+ICvCoMKgwqAgZGVjb2RlX3NhdmVfb3BjKGN0
eCwgMCk7DQo+IMKgwqDCoMKgIGdlbl9oZWxwZXJfY2JvX2ludmFsKHRjZ19lbnYsIHNyYyk7DQo+
IMKgwqDCoMKgIHJldHVybiB0cnVlOw0KPiDCoH0NCj4gQEAgLTYwLDYgKzY2LDggQEAgc3RhdGlj
IGJvb2wgdHJhbnNfY2JvX3plcm8oRGlzYXNDb250ZXh0ICpjdHgsDQo+IGFyZ19jYm9femVybyAq
YSkNCj4gwqDCoMKgwqAgUkVRVUlSRV9aSUNCT1ooY3R4KTsNCj4gwqDCoMKgwqAgVENHdiBzcmMg
PSBnZXRfYWRkcmVzcyhjdHgsIGEtPnJzMSwgMCk7DQo+IMKgDQo+ICvCoMKgwqAgLyogVGhlIGhl
bHBlciBtYXkgcmFpc2UgSUxMRUdBTF9JTlNOIC0tIHJlY29yZCBiaW52IGZvciB1bndpbmQuDQo+
ICovDQo+ICvCoMKgwqAgZGVjb2RlX3NhdmVfb3BjKGN0eCwgMCk7DQo+IMKgwqDCoMKgIGdlbl9o
ZWxwZXJfY2JvX3plcm8odGNnX2Vudiwgc3JjKTsNCj4gwqDCoMKgwqAgcmV0dXJuIHRydWU7DQo+
IMKgfQ0K

