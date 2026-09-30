Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DC4CA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 23:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC47Y-0005Y2-E1; Wed, 30 Sep 2026 19:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=726c96411=Alistair.Francis@wdc.com>)
 id 1xC47X-0005Xq-9v; Wed, 30 Sep 2026 19:53:55 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=726c96411=Alistair.Francis@wdc.com>)
 id 1xC47V-0005hJ-78; Wed, 30 Sep 2026 19:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790812433; x=1822348433;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=QIERR9oomazuq4X7laxAtrfPNnL7T1ofJe5i0coMl1M=;
 b=jW6YNUAjT388ad8/DGUIp8c9mFB9uITpeV2askQhRwysn2/rJXWOQoTW
 1BOok8QFYQPQrTl4GHUjuGPOwCS5lfUF+ObzwLSAulV5CdBdwbjwbesQ5
 Fm4fe0v8gc4oLpYU0IvXT0d2+pfmCjecPWmNQUHQnKDGR3Gj18+3zl7WL
 IQnKSWsyz1C/7JNHSePaD9S6Ef6Uhs6TQDups08/cweqEtplj8L5AHjOr
 f7LYc/BGMooIIpaAA9pvzWsWiuR8HbaJzp5iO9bnYxhNvcvau/o5XR5gT
 L+mgVJ1AOpUhxAciuOJ8oUCnrUCg7YcASAa7KI3SLWTSmpqFk6hUftP34 w==;
X-CSE-ConnectionGUID: EoFF0RaSSxS0aA96kAFcnw==
X-CSE-MsgGUID: shPISOpTQDyIqyVkmjt6XQ==
X-IronPort-AV: E=Sophos;i="6.27,133,1786982400"; d="scan'208";a="152761632"
Received: from mail-southcentralusazon11013070.outbound.protection.outlook.com
 (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.70])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 01 Oct 2026 07:53:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iklZKflzUI0ITplQPQDGJo2cWEA40cHWjARxLtsq4/jJqq710OuCTya/lH7MoQOEoHJz9jR2xqGAoy0d1x2VSM/hQl7oPpVm3Qtl4go5Mqm+kjM2K0ZHor3prQHUBDJAWnOGK7PlDjgHAE6WiJTWq2Gia/XqqB1jNEqpRmkitmnjRBXiGG5LjWx+setVqOzboFhU2tT05hYrieIB/9elWlzgq+4EKHbo7mZs0CDzR+iIDuhwwBpfi/HeHxmcm2rk6clgMv7v6SR406V+1njDLhvZQSvlEH9BI7c8/kCreK3H5HNJSTdoeLwiKs0u3JAQq7F4BlKUi5Ifm1keeeGS2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIERR9oomazuq4X7laxAtrfPNnL7T1ofJe5i0coMl1M=;
 b=r4H5fIrOo5bVTK49BN7UwSanPpsgJvJOC3CN4rS5D6ZaA0I5Rb8k/U2H9qPST29hoBIab4h/59HdX5buZHvW2FX8+2FP+tMLxEbeLXSK5mqAYsNaxdxo8tM2BA/GFzi/p2i/TGSGY80yNc+UAOB+7QNSNo3mo/zBPgtPXHFbFEjpHBhkB3uZlBmGDRSt21nZp4un9ak/RyytPwh0DPddIeZz+sHM/OmtESF3vf2pgxOeGnVSEYVDptDwjoIEDKEbtsMYwL6vpt4i9nW7vtN5CD/3WRpzM7duvuvvSXNtOhyJMWSslRGac5N1tdODdZN/ZwLVh+ChbfsnRrn3a7Lm/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIERR9oomazuq4X7laxAtrfPNnL7T1ofJe5i0coMl1M=;
 b=U4kZj8pZyPIfk+NDEjTLJIQawsmf5A84r2IOTXQbitLEy7agtva8fPaK3DMSVju8+mc7u2c7TzfwnXi2NXSUWh4ntO8IUpeGUdO+3LTD4PqEHprptwelU2h7+jpg6xiSXlcdORgNNg1mYtq3RlbnXMN239IRi6BmgV2Y7Gd8t90=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by BL0PR04MB6564.namprd04.prod.outlook.com (2603:10b6:208:17d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 23:53:48 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.026; Wed, 30 Sep 2026
 23:53:48 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "visitorckw@gmail.com" <visitorckw@gmail.com>,
 "farosas@suse.de" <farosas@suse.de>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>
CC: "wxchen0913@gmail.com" <wxchen0913@gmail.com>, "marscheng@google.com"
 <marscheng@google.com>, "portias@oss.tenstorrent.com"
 <portias@oss.tenstorrent.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "jserv@ccns.ncku.edu.tw" <jserv@ccns.ncku.edu.tw>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "eleanor15x@gmail.com" <eleanor15x@gmail.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "chao.liu.zevorn@gmail.com"
 <chao.liu.zevorn@gmail.com>
Subject: Re: [PATCH v5 1/7] hw/char: Add dw8250 UART
Thread-Topic: [PATCH v5 1/7] hw/char: Add dw8250 UART
Thread-Index: AQHdTry3TXyPMyytakmJkY+03mxakrbnHT6AgACzJoA=
Date: Wed, 30 Sep 2026 23:53:48 +0000
Message-ID: <d7205153acfde8d660faaadcc0c6a40d20d51f61.camel@wdc.com>
References: <20260927201326.650943-1-visitorckw@gmail.com>
 <20260927201326.650943-2-visitorckw@gmail.com>
 <7da68b92-e599-4afc-8b4b-03e44d7e1930@oss.qualcomm.com>
In-Reply-To: <7da68b92-e599-4afc-8b4b-03e44d7e1930@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|BL0PR04MB6564:EE_
x-ms-office365-filtering-correlation-id: fd8d8e45-8361-4b23-1aba-08df1f4e1247
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|7416014|366016|19092799006|23010399003|1800799024|22082099003|18002099003|38070700021|4143699003|3023799007|10067099003|260925022911599003|260925021911599003|260925021311599003|56012099006|11063799006;
x-microsoft-antispam-message-info: jcOrkvzq6jYtdhHiwORr5MDuZT7ed42YH6b68W6SUsxO1gdEiK74dYQHnSACFTd7ujVfa3R/xz3LkHJNlNGayLNxc4wEjnZEU0QG7fkZg2jQrNoy/u2Ut2QxbfQFooo1sKOm3262aR9PfLT95+q2cBvVCbEiSw1bdKsOZvjC2iNqtUDrj4pYG18hT3f17ARPlUIMgis3uiY2BLYGl2COmIeM8v2ZHD8sTkm7KD/Q933iuBL8QQjN5H25hb4g359Ed2aYH+ZJZ0uKDDvL3xaZpBTzkzAzPferSkn7lE6epWu29ILw9bmBE0aiMmGNopxV89PiEsyp0Jb2dKaKbifnh5xEmmmL5N9soWInnr2YMsJH5O3PJ5Zo8yVVwIq+ioZakBeGS+cdJMGSIL14LkagEiyppkxh+TkdjkkehRps3L1UvWeSoiZY6QaMtGgMy3MYBX6RZfIkCJmH0BGXYwsCREWTH+e9tVgpJwOl/yDlOkL00l7roJ4dcZfr67XV7IpqGJnsGQCq/jlnve/M/jj+ag2vsWwS7WOEkoF8Rz91ZgOr82RT1cj4UYliqEfLylRi9rR5KoB/0+LjLZJwrozQRztYcNE0abxOzTTUwjLdEmw2UlxRSOYGPKXXMPeTpVSVdvuMlrOfFkCE3mutn8oBjduSgT3lWyz8HSCmLjRGtP0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(7416014)(366016)(19092799006)(23010399003)(1800799024)(22082099003)(18002099003)(38070700021)(4143699003)(3023799007)(10067099003)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wm5aRVZPODNhN2svVHpMaVp6QUVQVVNpdUhybGNKb3EvR0NuOWdzOWhia291?=
 =?utf-8?B?ZGc3K0UvSzhJYlI3N1VoUFh6R3NWQUpGUWJJcTVwZnN4azdCTTNyUmVMTHBQ?=
 =?utf-8?B?OEoxVXNGUTlZUXE5ajVONFEyeElhamNlcXpzempkT2l1c3lwQ2ZtSmE5T0o4?=
 =?utf-8?B?MVJkTG5QQWI5cGgxZEJ5dVJ3czd2NlZmWWhKMU9sYXFaWmlWS3E4TkhsQVFk?=
 =?utf-8?B?WXRHNEpMZWJsbDNwOE50Z29pbG9iaHdwNVU1bmxtUm5pQ09rdUZLV0E1d0VV?=
 =?utf-8?B?UTFTTFU2N1NucDdmZkN2OFp3M1RJRGNsaXpNRmkwd3BCUlRjRE9sN2JVU3dn?=
 =?utf-8?B?cnZmZUVMWnlvQSs1TTlyYnM2SWpHeFJmWjhZMytKcDBCNVVHQ0wvUUs3aFRa?=
 =?utf-8?B?dW5NcHlFU2ZCOGw4OXVFRVZqK29nYTdqSVNkRGlXR2FlUDEzMjhtQitlenYz?=
 =?utf-8?B?SmNScHJ0UG1FV0xycllBQVVlaElWdDNuUW1PWkxKaWdCU0xZVFE0ZHhiaTRq?=
 =?utf-8?B?QWM2MXNJK0hlSUdjRGRSaW5tdUViVjZaSm5xUE1wT0pFQnNheURaZDNkam1n?=
 =?utf-8?B?Qis1MjdxenJBcHdLbjdiZWVVN29xTkJTbWFGd3RaTkcrRnhFRTIwazJGdm50?=
 =?utf-8?B?ZUx0WlVtRHlQdks3RFNjS3pKZTJLQm52VjcrUmZKS3VPbitlRHcwKzZJTUxV?=
 =?utf-8?B?SHJHTjREQkxDY3JFU0NGS04rK2RpVVpzei9BWWNQMjdMWjNtR2l0VENWNElp?=
 =?utf-8?B?TTlqV0NKOHp1aFlTVTY0Z3h5WS9MQ3FwaVFUSDMzTG1zYXJJVTdHbDM3aDNj?=
 =?utf-8?B?b1JBMHJNenlSUVFEQVBzTkRoMVk5ajNQVUNlaUpBYkR1QThVY1NWRlhzVjZi?=
 =?utf-8?B?ZCtWY042eHBsN042c2s4R3JaR1JCMjBLbXlzL3JsZzBVaHEvZTBoVzBuQjZO?=
 =?utf-8?B?elNRdCttc1JvbHJ3RExXTlE0NXNvVG13SjYzOXRRVWtoN2twOU1MV1BDdFlI?=
 =?utf-8?B?c3Q4VHYvaSswZHl2MlBRTlAvS1N2UDcyUTk4d0pMNUZaQ21SaDBzSTNDMnV1?=
 =?utf-8?B?ZXZETndEZmd3UktpZXFkMzZCQ3I4NWpuTW1aOUtWRDJBbHJuN2wrQ1ZKUWhn?=
 =?utf-8?B?SW92OUcrOVFwRUVuaWZ1TVpoZ1dTUjBMMUFlUklkS1BYQituMXVtb3B0Y3Er?=
 =?utf-8?B?Vk9acUZzZmFrcHh0NEZ6R2tpYlJnQWJYMHI5M3hXcXJYYTNvbmVpcDJUY2Rt?=
 =?utf-8?B?TVhLdEZ1SmFxOUJHQlAxWURHS1VvL2pOR3p0YXNuMjV5N3lXcFNqSUNHTzBM?=
 =?utf-8?B?cUYvVzJlak9GZHUxNWpGZ2pwOHJXd1Jxbmh6SGhlQk5JbC9oQ05KSEFPR2U5?=
 =?utf-8?B?b3drREhPSDEwb2ZwR0RQWUJ0V04zMTVwYTVhR2huQUJOeDhHZWloYTM4QzN6?=
 =?utf-8?B?TVhxcmpTaUJ5N3c0RUhyc0RpWUVQKzc0UFh1WjQ4ZHFWMFB0RXBSeEQ0OTA2?=
 =?utf-8?B?V3N5elZjY3NGa3B5L2pxMk5EQ05oZE05bVJyMWthdmJWOHdtTFNEa1pvYVBR?=
 =?utf-8?B?NmhzREFkNzEyeURWNjNtU1poblJCZC9aOUQ5WGFNVUF3NzNscUdsb2dxV01o?=
 =?utf-8?B?QWJvTHJzUFVxVERGdklnbVhnVFBqZkFJdVZ3UllSVHVwRnkzOUVzYTRiQ25G?=
 =?utf-8?B?alFvYytsVTAxaXVYbFhyai9Ic2lhSDI5SSt3QjRKRUlQRzB4Z0NCSitoR1Zn?=
 =?utf-8?B?cEE0emRGdWpiVStVQ3JMcWVIK3Y0Ti81dWV1cVZkTWxHaGxSNVlIV2p0cW9h?=
 =?utf-8?B?K2RGZ2pBcG1HcFkrdjJQRW5CeCthSEw5ekJ1OURqZm01MFNOdEZLN0NWd09Q?=
 =?utf-8?B?S204YmE4cFk1OUV5MStVNFdhbWRUaHFCRFI3bEl3dmNvY3ZvSWpjaU4zT3ZO?=
 =?utf-8?B?SmFoaG41Mm5oMFFBYVYxQmJiQ2hzS3RUOHBDS3B2M2ZnMlYvR1cyS21tUVpM?=
 =?utf-8?B?djM0MDlQbjlnU0JyeWJwbjFCLytOVUtia1BTL1NjTGl1aHlrTjk3V3VhY3V0?=
 =?utf-8?B?UlRGeUpwcVhBTU5wSFJaSFErYWt3Tklxdm5lUUlNMWNucjZyVk1PMTZnN3lh?=
 =?utf-8?B?R2dWVEkrYXcwd1prcVczMlQ1ekRRNHc0SHNoNEJMMEVMZDZCcHBvdDQ1enVQ?=
 =?utf-8?B?SURZbEhXYTVKNmpzTC90YUJtbFRORnJiUE1IZmN6QVNROGdHZXpDVVBsUEk2?=
 =?utf-8?B?SytVZlFHT3VZSjExRXN0bG5qbDZCOUtTdXJva2YwSmFyd0RETzkrdlZEVlIr?=
 =?utf-8?B?MlNLZlB2TzZvdGppZktXZWFYOEkxU0JGWC9vVG9sY3VRUmZ1RnY0Vm83Z2Nm?=
 =?utf-8?Q?9bqxM62h5chF5xz5kS8krgqyikwT/I6wHJeVEqiFXbvG/?=
x-ms-exchange-antispam-messagedata-1: nFeu8vfD7u5frOesuaA1K4V3aqNK/tLoW7M=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8082B9AC615EB4985CDC8D7F06B3396@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IjL1jhFqDXN73/Hxu/XytSAv5UTQ5nkyGyAMo9BbzQuL3VzAcP+MkhbuLnnwt9DPrP0olC5I1WSwFXIkDPo6I4gmi46QV3GgLzxMM+QN/X1BeUsnUbOzwIGZ8VK/+l5R4/5ZokI8//kxmejcxdD0AO0NBuPGDKWatHieeBmXKLWMZM+ffX3KnxwoWZEAejID60YiyibTH/8cqf+L8z/tMPiHNBYu5xl3yH0DQmt4se6vlkCU0SG5xwyXTiEBNJvYhV1CbKHqieuCa5FKd7kA30SXoceaPFKhjsl+zWEtCokQXbLRyofZPou68I50/tpcy6w4DWbTOEdM556PdFYoLQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8tpn2IThEhiZfKlb3PnfxiJBkNFmKW6ECd7gqP7J4preMYMYl3c5L2NFQunkNAaV3Unw7CricSJuSd8naUIJS09kosgzyyqQK6uaebgvDED0NN6Hh0AmToJaKQ5UXLEU/EM/5YDMOjFysLsNjGJQ1x5tA1bxv/Af+IpPzcoCiNUcr1vXm2/AlBGTX4YJAQrhs/vf6pJTMdOk45tPAIwrXNSguCZdJ6PcNmDIEje/gyBITxLnwGNtzXuFvMcZFb3Xl/9TFxIlaIYfWXX+sfh3jFKUem804UQCBhXTqhbf/Z3R2OMgKKNn+rYEVjlYH20sASTQrt2NgWKg8ig6R88PPCGC21jehuu4/EFM+1i3fx3WXvWTJfDfuSgoxKnNjTBbIDHcFpoaMNFIRDQJFWIHVaJp2NGej/eVsvRjT/l1UeRXKvlR7scYor41V/xY7JMZCqCsQKXPlvYEgvidvfRSOo5wDjM+QHju6EaUae3TFQ7L0r2rlQtOVSWX7VOu+cT2E3PFCl88ynhAH5NIGnZS31CIfsk5TCyz/1is6dAJDVsgeSkRR9GvMNI0HDRG15PRuhDiRvS4q/Cchq3K7X6bU7PVy21N+biG8C5IiKlfZRTI9YwJhFJ3yAsXf/U7cxfm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8d8e45-8361-4b23-1aba-08df1f4e1247
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 23:53:48.4102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gHxyV+sz0jxfrZOfMXn2ca+oAdRnttvhf0eCDU1lJGjZrqM1sF0j8+W7aHiPqv8QQmQ5r3ugUbhbSnyA3pLxB5YwXq5rvBwf/UhXwAQK+Xw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6564
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=726c96411=Alistair.Francis@wdc.com;
 helo=esa4.hgst.iphmx.com
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

T24gV2VkLCAyMDI2LTA5LTMwIGF0IDEwOjEyIC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gSGVsbG8sDQo+IA0KPiANCj4gU2VlbXMgbGlrZSB3ZSBoYXZlIGEgbWVtIGxl
YWsgZG93biB0aGVyZToNCj4gDQo+IE9uIDkvMjcvMjAyNiA1OjEzIFBNLCBLdWFuLVdlaSBDaGl1
IHdyb3RlOg0KPiA+IEFkZCB0aGUgZHc4MjUwIHVhcnQgc3VwcG9ydC4gVGhpcyBoYXJkd2FyZSBp
cyBhIHdpZGVseSB1c2VkIDE2NTUwQQ0KPiA+IGRlcml2YXRpdmUgdGhhdCBpbmNsdWRlcyBhZGRp
dGlvbmFsIHJlZ2lzdGVycy4NCj4gPiANCj4gPiBXaXRob3V0IHRoaXMgc3BlY2lmaWMgZGV2aWNl
IHN1cHBvcnQsIHRoZSBMaW51eCA4MjUwX2R3IGRyaXZlcg0KPiA+IGZhaWxzIHRvDQo+ID4gcHJv
YmUgdGhlIGV4dGVuZGVkIHJlZ2lzdGVycyAoVUNWLCBDUFIsIGV0Yy4pLCB3aGljaCBhcmUgZXNz
ZW50aWFsDQo+ID4gZm9yDQo+ID4gY29ycmVjdCBmZWF0dXJlIGRldGVjdGlvbi4NCj4gPiANCj4g
PiBTaWduZWQtb2ZmLWJ5OiBLdWFuLVdlaSBDaGl1IDx2aXNpdG9yY2t3QGdtYWlsLmNvbT4NCj4g
PiBSZXZpZXdlZC1ieTogQ2hhbyBMaXUgPGNoYW8ubGl1Lnpldm9ybkBnbWFpbC5jb20+DQo+ID4g
UmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4N
Cj4gPiAtLS0NCj4gPiDCoCBNQUlOVEFJTkVSU8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oMKgIDYgKysNCj4gPiDCoCBody9jaGFyL0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAg
NCArKw0KPiA+IMKgIGh3L2NoYXIvZHc4MjUwLmPCoMKgwqDCoMKgwqDCoMKgIHwgMTMxDQo+ID4g
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gwqAgaHcvY2hhci9t
ZXNvbi5idWlsZMKgwqDCoMKgwqAgfMKgwqAgMSArDQo+ID4gwqAgaW5jbHVkZS9ody9jaGFyL2R3
ODI1MC5oIHzCoCAyNyArKysrKysrKw0KPiA+IMKgIDUgZmlsZXMgY2hhbmdlZCwgMTY5IGluc2Vy
dGlvbnMoKykNCj4gPiDCoCBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvY2hhci9kdzgyNTAuYw0KPiA+
IMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L2NoYXIvZHc4MjUwLmgNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KPiA+IGluZGV4IDZiZTlj
NTcyNWIuLmQ0ZTljZjYxZWEgMTAwNjQ0DQo+ID4gLS0tIGEvTUFJTlRBSU5FUlMNCj4gPiArKysg
Yi9NQUlOVEFJTkVSUw0KPiA+IEBAIC0yODQ4LDYgKzI4NDgsMTIgQEAgUzogTWFpbnRhaW5lZA0K
PiA+IMKgIEY6IGh3L2kyYy9kZXNpZ253YXJlX2kyYy5jDQo+ID4gwqAgRjogaW5jbHVkZS9ody9p
MmMvZGVzaWdud2FyZV9pMmMuaA0KPiA+IMKgIA0KPiA+ICtEZXNpZ25XYXJlIDgyNTAgVUFSVA0K
PiA+ICtNOiBLdWFuLVdlaSBDaGl1IDx2aXNpdG9yY2t3QGdtYWlsLmNvbT4NCj4gPiArUzogTWFp
bnRhaW5lZA0KPiA+ICtGOiBody9jaGFyL2R3ODI1MC5jDQo+ID4gK0Y6IGluY2x1ZGUvaHcvY2hh
ci9kdzgyNTAuaA0KPiA+ICsNCj4gPiDCoCBHZW5lcmljIExvYWRlcg0KPiA+IMKgIE06IEFsaXN0
YWlyIEZyYW5jaXMgPGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+DQo+ID4gwqAgUzogTWFpbnRhaW5l
ZA0KPiA+IGRpZmYgLS1naXQgYS9ody9jaGFyL0tjb25maWcgYi9ody9jaGFyL0tjb25maWcNCj4g
PiBpbmRleCAwMjBjMGE4NGJiLi40MThkOTliNzU3IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2NoYXIv
S2NvbmZpZw0KPiA+ICsrKyBiL2h3L2NoYXIvS2NvbmZpZw0KPiA+IEBAIC05NSwzICs5NSw3IEBA
IGNvbmZpZyBJUF9PQ1RBTF8yMzINCj4gPiDCoMKgwqDCoMKgIGJvb2wNCj4gPiDCoMKgwqDCoMKg
IGRlZmF1bHQgeQ0KPiA+IMKgwqDCoMKgwqAgZGVwZW5kcyBvbiBJUEFDSw0KPiA+ICsNCj4gPiAr
Y29uZmlnIERXODI1MA0KPiA+ICvCoMKgwqAgYm9vbA0KPiA+ICvCoMKgwqAgc2VsZWN0IFNFUklB
TA0KPiA+IGRpZmYgLS1naXQgYS9ody9jaGFyL2R3ODI1MC5jIGIvaHcvY2hhci9kdzgyNTAuYw0K
PiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMC4uY2NmMDVkZDlh
ZA0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9ody9jaGFyL2R3ODI1MC5jDQo+ID4gQEAg
LTAsMCArMSwxMzEgQEANCj4gPiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAt
b3ItbGF0ZXIgKi8NCj4gPiArLyoNCj4gPiArICogU3lub3BzeXMgRGVzaWduV2FyZSBBUEIgVUFS
VCAoRFcgODI1MCkNCj4gPiArICoNCj4gPiArICogQ29weXJpZ2h0IChjKSAyMDI2IEt1YW4tV2Vp
IENoaXUgPHZpc2l0b3Jja3dAZ21haWwuY29tPg0KPiA+ICsgKi8NCj4gPiArDQo+ID4gKyNpbmNs
dWRlICJxZW11L29zZGVwLmgiDQo+ID4gKyNpbmNsdWRlICJxZW11L2xvZy5oIg0KPiA+ICsjaW5j
bHVkZSAicWFwaS9lcnJvci5oIg0KPiA+ICsjaW5jbHVkZSAiaHcvY2hhci9kdzgyNTAuaCINCj4g
PiArI2luY2x1ZGUgImh3L2NvcmUvcWRldi1wcm9wZXJ0aWVzLmgiDQo+ID4gKyNpbmNsdWRlICJo
dy9jb3JlL3FkZXYtcHJvcGVydGllcy1zeXN0ZW0uaCINCj4gPiArDQo+ID4gKyNkZWZpbmUgRFdf
VUFSVF9SRUdJT05fU0laRSAweDEwMA0KPiA+ICsNCj4gPiArI2RlZmluZSBEV19VQVJUX1JFX0VO
ICgweEI0ID4+IDIpIC8qIFJlY2VpdmVyIE91dHB1dCBFbmFibGUNCj4gPiBSZWdpc3RlciAqLw0K
PiA+ICsjZGVmaW5lIERXX1VBUlRfRExGwqDCoCAoMHhDMCA+PiAyKSAvKiBEaXZpc29yIExhdGNo
IEZyYWN0aW9uDQo+ID4gUmVnaXN0ZXIgKi8NCj4gPiArI2RlZmluZSBEV19VQVJUX0NQUsKgwqAg
KDB4RjQgPj4gMikgLyogQ29tcG9uZW50IFBhcmFtZXRlciBSZWdpc3Rlcg0KPiA+ICovDQo+ID4g
KyNkZWZpbmUgRFdfVUFSVF9VQ1bCoMKgICgweEY4ID4+IDIpIC8qIFVBUlQgQ29tcG9uZW50IFZl
cnNpb24gKi8NCj4gPiArI2RlZmluZSBEV19VQVJUX0NUUsKgwqAgKDB4RkMgPj4gMikgLyogQ29t
cG9uZW50IFR5cGUgUmVnaXN0ZXIgKi8NCj4gPiArDQo+ID4gKyNkZWZpbmUgRFdfVUFSVF9VQ1Zf
VkFMVUUgMHgzMzMyMzMyQSAvKiAiMzIzKiIgLT4gdjMuMjNhICovDQo+ID4gKyNkZWZpbmUgRFdf
VUFSVF9DVFJfVkFMVUUgMHg0NDU3MDExMCAvKiAiRFciICovDQo+ID4gKw0KPiA+ICtzdGF0aWMg
dWludDY0X3QgZHc4MjUwX2V4dF9yZWFkKHZvaWQgKm9wYXF1ZSwgaHdhZGRyIGFkZHIsDQo+ID4g
dW5zaWduZWQgaW50IHNpemUpDQo+ID4gK3sNCj4gPiArwqDCoMKgIERXODI1MFN0YXRlICpzID0g
b3BhcXVlOw0KPiA+ICsNCj4gPiArwqDCoMKgIHN3aXRjaCAoYWRkciA+PiBzLT5yZWdzaGlmdCkg
ew0KPiA+ICvCoMKgwqAgY2FzZSBEV19VQVJUX1VDVjoNCj4gPiArwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIERXX1VBUlRfVUNWX1ZBTFVFOw0KPiA+ICvCoMKgwqAgY2FzZSBEV19VQVJUX0NQUjoNCj4g
PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDB4MDAwMDAwMDA7IC8qIE5vIGFkdmFuY2VkIGZlYXR1
cmVzIChETUEsIGV4dHJhDQo+ID4gRklGT3MpICovDQo+ID4gK8KgwqDCoCBjYXNlIERXX1VBUlRf
Q1RSOg0KPiA+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gRFdfVUFSVF9DVFJfVkFMVUU7DQo+ID4g
Kw0KPiA+ICvCoMKgwqAgY2FzZSBEV19VQVJUX1JFX0VOOg0KPiA+ICvCoMKgwqAgY2FzZSBEV19V
QVJUX0RMRjoNCj4gPiArwqDCoMKgwqDCoMKgwqAgLyoNCj4gPiArwqDCoMKgwqDCoMKgwqDCoCAq
IFJldHVybiAwIHRvIGluZGljYXRlIHRoZXNlIG9wdGlvbmFsIGZlYXR1cmVzDQo+ID4gK8KgwqDC
oMKgwqDCoMKgwqAgKiAoUlM0ODUgYW5kIEZyYWN0aW9uYWwgRGl2aXNvcikgYXJlIG5vdCBpbXBs
ZW1lbnRlZC4NCj4gPiArwqDCoMKgwqDCoMKgwqDCoCAqLw0KPiA+ICvCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gMHgwMDAwMDAwMDsNCj4gPiArDQo+ID4gK8KgwqDCoCBkZWZhdWx0Og0KPiA+ICvCoMKg
wqDCoMKgwqDCoCByZXR1cm4gMDsNCj4gPiArwqDCoMKgIH0NCj4gPiArfQ0KPiA+ICsNCj4gPiAr
c3RhdGljIHZvaWQgZHc4MjUwX2V4dF93cml0ZSh2b2lkICpvcGFxdWUsIGh3YWRkciBhZGRyLCB1
aW50NjRfdA0KPiA+IHZhbCwgdW5zaWduZWQgaW50IHNpemUpDQo+ID4gK3sNCj4gPiArwqDCoMKg
IHFlbXVfbG9nX21hc2soTE9HX1VOSU1QLCAiJXM6IFVuaW1wbGVtZW50ZWQgd3JpdGUgdG8gYWRk
cmVzcw0KPiA+IDB4JSIgSFdBRERSX1BSSXggIlxuIiwNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBfX2Z1bmNfXywgYWRkcik7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0
YXRpYyBjb25zdCBNZW1vcnlSZWdpb25PcHMgZHc4MjUwX2V4dF9vcHMgPSB7DQo+ID4gK8KgwqDC
oCAucmVhZCA9IGR3ODI1MF9leHRfcmVhZCwNCj4gPiArwqDCoMKgIC53cml0ZSA9IGR3ODI1MF9l
eHRfd3JpdGUsDQo+ID4gK8KgwqDCoCAuZW5kaWFubmVzcyA9IERFVklDRV9MSVRUTEVfRU5ESUFO
LA0KPiA+ICvCoMKgwqAgLmltcGwgPSB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgIC5taW5fYWNjZXNz
X3NpemUgPSA0LA0KPiA+ICvCoMKgwqDCoMKgwqDCoCAubWF4X2FjY2Vzc19zaXplID0gNCwNCj4g
PiArwqDCoMKgIH0sDQo+ID4gK8KgwqDCoCAudmFsaWQgPSB7DQo+ID4gK8KgwqDCoMKgwqDCoMKg
IC5taW5fYWNjZXNzX3NpemUgPSAxLA0KPiA+ICvCoMKgwqDCoMKgwqDCoCAubWF4X2FjY2Vzc19z
aXplID0gNCwNCj4gPiArwqDCoMKgIH0sDQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9p
ZCBkdzgyNTBfaW5zdGFuY2VfaW5pdChPYmplY3QgKm9iaikNCj4gPiArew0KPiA+ICvCoMKgwqAg
RFc4MjUwU3RhdGUgKnMgPSBEVzgyNTAob2JqKTsNCj4gPiArDQo+ID4gK8KgwqDCoCBzLT5zZXJp
YWxfbW0gPSBxZGV2X25ldygic2VyaWFsLW1tIik7DQo+ID4gK8KgwqDCoCBvYmplY3RfcHJvcGVy
dHlfYWRkX2NoaWxkKG9iaiwgInNlcmlhbC1tbSIsIE9CSkVDVChzLQ0KPiA+ID5zZXJpYWxfbW0p
KTsNCj4gDQo+IF4gaGVyZS4gcy0+c2VyaWFsX21tIGlzIGJlaW5nIGFsbG9jIGluIHFkZXZfbmV3
KCkgYW5kIHRoZW4gZHVyaW5nDQo+IG9iamVjdF9wcm9wZXJ0eV9hZGRfY2hpbGQoKS4NCj4gDQo+
IFRoaXMgaXMgYmVpbmcgZml4ZWQgYnkgUG9ydGlhIGluIGFub3RoZXIgcGF0Y2g6DQo+IA0KPiBb
UEFUQ0ggMS81XSBody9jaGFyL2R3ODI1MDogRml4IGxlYWsgd2hlbiBjcmVhdGluZyBjaGlsZCBk
ZXZpY2UNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MDkyOTAzMTY0
NC4xMDE2MzU0LTItcG9ydGlhc0Bvc3MudGVuc3RvcnJlbnQuY29tLw0KPiANCj4gDQo+IEdpdmVu
IHRoYXQgdGhpcyBpc24ndCBtZXJnZWQgeWV0IEkgc3VnZ2VzdCBmaXhpbmcgdGhlIGxlYWsgaW4g
dGhpcw0KPiBwYXRjaCBpbnN0ZWFkLg0KDQpJJ3ZlIHB1bGxlZCBpbiBQb3J0aWEncyBwYXRjaCBh
bmQgc3F1YXNoZWQgaXQuIEl0J3MgYSBwcmV0dHkgc2ltcGxlIGZpeA0KYW5kIGFzIGl0J3MgYWxy
ZWFkeSBpbiBteSB0cmVlIGl0J3MgYW4gZWFzeSBmaXgNCg0KQWxpc3RhaXINCg==

