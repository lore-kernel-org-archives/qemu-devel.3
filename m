Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E32CCA490
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 02:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIcoC-0000h5-K9; Sun, 18 Oct 2026 22:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xIco8-0000gp-Vq; Sun, 18 Oct 2026 22:09:01 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xIco6-0000AR-I5; Sun, 18 Oct 2026 22:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792375738; x=1823911738;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=3AloBbXo3ySP7rFYXsVaAdDW5HhNLT86EktOOZYMbII=;
 b=g7ZLpuJd7BOmELREjG8ixdwNno6JddlxYrFmigcIy7J0wZykFPB0a5jA
 VxYO9CWnxyvIkPxxjevD4wf2waHDznZX1908heYZlzTn58vgkObxOcL6J
 zGQTnuaT5HxoAh4OOHwchb8urAWr4YBJBvdJqTDNTMlWehOMWxXjhBM3o
 Ywjo6RQagaf/AT5VbR5n+zilRsSRtrJd16MOwOv1md2waVYrrXvpwinQX
 il+orLSXKu94pp0tgHQlv8L8lFE/7tOquIRgELPar1CPwl8RHHQKmJHLw
 Lbmg1ephrAjqP9p70sG8/acwrYANJJemKNSRvBwqd+krjr4/3DnCAqR7b g==;
X-CSE-ConnectionGUID: YoMEX+f1RyKW9sG8gEkA6g==
X-CSE-MsgGUID: cVmrhM9LQZyk0evP1Ru7aQ==
X-IronPort-AV: E=Sophos;i="6.27,166,1786982400"; d="scan'208";a="158303528"
Received: from mail-westcentralusazon11010046.outbound.protection.outlook.com
 (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.46])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 19 Oct 2026 10:08:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qwiBkBW0ytUmPztV6gfCaRaAgHwb1UzHwynAXKdDXOad3MF3ojnRJGC9Tr4H4kmILQAkBnfuwrAzrbigpfboqZTXhlzzTVhtsRwnyDUgYWmKmj/qnLGv6o/zYOjV9UFLxQpXT3Sc5S4q3cG49j7Bob3XpvRXUl84kO2SSD0SecRmjO8zqrlL7QrGcqufglsot+yuU0cDr6MBWl/z7GvWZzLy0q1ysgNkQy9v8SzwX4QP10j65k5St7fYhY7S6gENAqnZrgUOZzjKtf7qQzQM4Jd/Tp/tWjB2T8j7OR8eHSNnsaLomWrxsrL/704hcUQIOl9lAsMtkNixp4cftZU5AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AloBbXo3ySP7rFYXsVaAdDW5HhNLT86EktOOZYMbII=;
 b=x9Es5oyQMh8T5Uu9igebf8jjnF3dTPaPbKE4enIbR9VlOturQ/egnLOFe70Wu0qIjlCaDXl74RZisQtwlmR9lqIG4RQZ4ATn3bGjq3EzuqesMjN41wL6hsYxDpka3Gu3AFx7+hnYWQlrs6r0qxsixRsGEWJz9nrCba31Lo7OndlMHERftJyktqMWn24thMJxBeKtRoXnas13fTGNHeLsl88F/VJjdoopBU4d2V+UGllGi50Aj5dPG6CV3BrXu6me8dF/Gtoz22OEKktaZeufO9Lz+TSTIu4WjRS9AwxJ6ARpJ/OIx0v+tbaUUPotlA2/KczGh1YmmbI+jCAk6bl6Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AloBbXo3ySP7rFYXsVaAdDW5HhNLT86EktOOZYMbII=;
 b=xNbtkTHhBuTjilyR8ObXmHfhEqLWoFdddWu4B/1/vFzwrLscTZZxNOnnmRYk5s7UpImEZqJLrLdVbHkwjKV7PDGXXVlbibqeSIoU5C9JBMfCApWUClqmRskn/SuNPTEzuaGP6uZmrrayNrz727P9C19SQrKVb6ZLH4LC0rXXJig=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by DS2PR04MB993992.namprd04.prod.outlook.com (2603:10b6:8:338::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 02:08:53 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 02:08:53 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "hushunchao@bosc.ac.cn" <hushunchao@bosc.ac.cn>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "wutianze@ict.ac.cn" <wutianze@ict.ac.cn>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2] target/riscv: add hgatp-specific WARL legalization
Thread-Topic: [PATCH v2] target/riscv: add hgatp-specific WARL legalization
Thread-Index: AQHdTPc7X6lEbkfz1EO+RaWUOqZyGbcEQ6QA
Date: Mon, 19 Oct 2026 02:08:53 +0000
Message-ID: <35fdc7d62d8c0b52a55c9ffec1e763a4f9401df8.camel@wdc.com>
References: <20260925-riscv-hgatp-warl-v2-1-2aa9aa7718cd@bosc.ac.cn>
In-Reply-To: <20260925-riscv-hgatp-warl-v2-1-2aa9aa7718cd@bosc.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|DS2PR04MB993992:EE_
x-ms-office365-filtering-correlation-id: a734afb1-e778-464d-0808-08df2d85ece6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|23010399003|19092799006|38070700021|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 2DJv4MbZxTcHDH+mPT8wRCnwKjU/1JjnUuIJrdsNdqdvoUW2l8J5O3HgrL2IMSpE//UDgIp/krHKBoe0TDJXMVV3aTSZUyChzdY9plwEV7f5ivvwb+kWI7vhX4u+UdthR0Tb0Hk8AhS+MyhjeN4RDcbOsgFJMg9oWAOfbRjVB8AR3FRXsIfTpJV4H2vbd5Xb0yCfnruIeqgsXs1K6sso2+OZ3qvpXsWjk7pTwMPdvEtQpX5WRhvEMvLK43+0vN4ygxkr6rU9Loxq0WBSttjwoB3fwWVmSHN1Zgmc9vqRq83+52EF4fY5x5TL8G+qaRleKrTUBvhxCy+2zUtf6A9eP4fEW8XjfYibM+cQ0fDwOrrmE2tCq1PHqzcGs5eeADrCFoEi9wMCL57JKcqcv5UyNE/rE4XQtNA8toHrG1OMHEydcGuSS6K9txDJdzN9KMMe2uWTI/JIuxMLltJZe4HJG5/9nHe+jH/ebc9oun16enqZSREXNfQbYPiNxa0zsFCZ9lDTIdn54sNUOK/hSsTjwp26xkkk3s0C0HAI+Co6O7xlXg5nPwOplVPZV5c4heallVRIU72mpRj1b1oXrU/FEWQ/RZXD71lT/kc9mCSPdLu7esyOArq2bCBnz3IGNc+8guMpNWMq6JQTAt3N+/XsLlV+Hybdd7Ic8MsZ5ySTbUA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(23010399003)(19092799006)(38070700021)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elZvaHczWXBic3RMZmhGWXpmTlUwRmFNNEpDa2tieGxETzNPd3FqUkszWEV5?=
 =?utf-8?B?bmZOd2QzUW0rdmxzUlkrZytHL1FwNTBWSXllOUhteEoxdk9PdU8yUTdpL3Jq?=
 =?utf-8?B?NjVTSDFMUWNhaFpYZU1XNTV3eUFweVBxZGNTTnVTejBpaldFNm85Z0VNUyts?=
 =?utf-8?B?RGszcGJSY0ptbFdsSHMwTFpZNHVxZWxha1VqeHBHT3FxM0FnYklOYkRQZnlX?=
 =?utf-8?B?a1YxRzlQcjMvS0Y3b3h0R1R6ZnJpdWFMdXNNeitwazFWSHNFT0ovdzZ0UWxB?=
 =?utf-8?B?MGQ4emtLVEpkK2w1MzA2N3pndXg1WFQ3TzBnNTNkWlpRRUFkSzNTWWNMV3A3?=
 =?utf-8?B?MW0wYU0xK2ZIODRsS0hpeEdqR3VTYnhIZ1ZrV0hnZFlVV3cxQ1Izb3VDRllH?=
 =?utf-8?B?QS9qT3UyaERQR0xDUzhFaUE0Ry80VnNSL3Fwb1p3NHhFYzNuZ3J4RFlEdEln?=
 =?utf-8?B?allsSGtCcWsvV0VMZWRZMWU5MkdSbVRTWmpDeFRVZDRzVEs4TXIxdlEzS05W?=
 =?utf-8?B?VEVPczRKUWY0czNEbEJSQnNOV3lEVHN5ODNYOXVWN0lKSlg2OEtoaExxendI?=
 =?utf-8?B?WUdzWFQ4R0dqZmxtMnlmMDU0RW5hTUtvT0RiWEZ3QWNDSXdxMXZCeURMa08v?=
 =?utf-8?B?UXRCUytQY1YrUWdwWC9iV05LR0NDcDVpSXNvdVdhV0lKblpCSWRPOGk0RHBZ?=
 =?utf-8?B?UEljT0p3MmdKenhhQmdhSFg5bnQ1M0Q2TWxNVXpnNERMY3c5TVBXOXhkaXFz?=
 =?utf-8?B?SVJ5Smk4bml6bE4rYmtwb3ZZK3hBb0tuOFdENGN2TFlxYzVvVS9VcTU2ZUdR?=
 =?utf-8?B?RkZuQkxPeFd6N0ZndVB5SjZpZUFGMjVxVHpIanVheUM2WkVjY3FVV01pZXk0?=
 =?utf-8?B?MFlxS3pOazBiZlVRZGFZUmtzTDhreUh1ZmlsUXExdy92eXI1L29SMmhGNWow?=
 =?utf-8?B?ZlkydCtLNlRJQ1pnK0FqWEZVK2o3byt3YkdEdUxpSGNNVU56bkIycVJVaUJL?=
 =?utf-8?B?VFR6eFdETWlNSk1xMXZzd1hUVjYveVVxMUZ2dnJ1WFI0ckVWWW1EZGhYbUFS?=
 =?utf-8?B?OGhwTU5sdDQ1MkprR3hJNS9LOGhneXNPWnZLUHRnWHMyTnB1OXYybHpuWjZm?=
 =?utf-8?B?d20vZ1Y2SWNGMnVJeXUzR0pDWGE3THF1TmNmSUpzdmRYUHc1S1RuYUZjZktG?=
 =?utf-8?B?bFI0VE5nWG0rUi9oNVNPMHhEbXVhNWRkQUMrSW1PelA0b01VYjYxVjEwTVFU?=
 =?utf-8?B?dFQvZ3hhakRITUtTVFdPbHYxcVFoc1JwbVJBTE5DZzVOZVZINURVQ2F3a3Nx?=
 =?utf-8?B?TkhDai8yOHFRQUFRWllzUmZ6Q0IrR1VqdnlieUFoMm1ObEt3Wm91L09weTcz?=
 =?utf-8?B?bnM4ZWIrc0g0V3ZSbDFiSTZJMnlWZk1ycDRtTlpJWFFqSFQrR3V1aGdPYUVa?=
 =?utf-8?B?V0JRU2p5dHloUWdwVTFrektoeU9kdnV3RkY5eGJkRUIyQnpCb0MveUU0VWdy?=
 =?utf-8?B?L1pvQURxYzF4U0xUU25PcjZhelN3ZStPZENiQnl3dDhIRUJ5SFMyUjRZSW9E?=
 =?utf-8?B?Mi9iSE1JdnVnMmxobk1hdVY1WjdqTExxK2FVR2pBM1hGT3grbXlOM2d2OEo4?=
 =?utf-8?B?d3dRTGtndVVPQ1JJMERXbHhUMUZockk1YXp4cEt5MFE2OFVPb2dCOEd3c3B4?=
 =?utf-8?B?Q1lQY0lWZ01rbFo5c1F2YnlMSE9HbytQY3BEbHhpby9TRHNKTENCNS9TMmZL?=
 =?utf-8?B?OENaRWFQT2pUN1RKY2ExSnFxZUtrTDIra1lXQnE1QTJ1VG5lZXNwektTbHFB?=
 =?utf-8?B?WjNjVCtoLy9NK2x3NDJNSk55b1hscHB4TEdub3BEWDdDcW84OVN6MzU0SzJ1?=
 =?utf-8?B?YnpDSUdYYkZPc3hkc0xhakpVRlpLSTAxZzdWT0ZOUWJHQ3dwQzkzRmdxOTUw?=
 =?utf-8?B?MHdlNmMzUHRxRStPdU5MSktiZkFMVUhGa1g2U0lscXpORVdCRVVjSUY1T0dh?=
 =?utf-8?B?ZzVLckp1TzZoZ1RQTFQwaXpWNEorZzJYUllWL3llTVNCUklMN2Fzd1k5cnJU?=
 =?utf-8?B?ZDVNem44R1V0ck5FRi9RWFUvT3NJSlBGWkZaN2ZON2dvT0Z6SFp2NXNIQ0pG?=
 =?utf-8?B?M3hCc1ZpN1JBR2gwZ1RUMmQ4U29QK1M1cjJkOG42Y2lCZ2ZmeDlha3FiQk9Y?=
 =?utf-8?B?VGxWbWhBeHNjNjdoWXBYWEFkQU9UcllJK0owVUJlREN1ZDZENktCN3BoeWlj?=
 =?utf-8?B?MFNONkpyYlJvMHc3ZkNNWno0VnFNRkJjZnl6VjhhU1M0VGQyT1VudGNZUjY1?=
 =?utf-8?B?K3BnV0FaUGEzWnV4VTVzTGZDejRnUXl3S2duWC8yeXJGYlRycVBzQkp3Mndw?=
 =?utf-8?Q?8Yh4Ldp9DkO6tvksfZDaQzI3gtr/SzvUMPpYtrrS5Pu53?=
x-ms-exchange-antispam-messagedata-1: 7qdjduqiBSHNz/7DzJ57oh6ThtggBpBikkY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <611D99C357CDAD488F44D471C670E14D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: T2Gm8+29oorxfSZ3g1StF602d4sTF7qV2YZZXW0Zo9GBVAcln4qhBeHE+q2rnslLW+sjY/fRRJdxu2nvoCbaJhIB4wfZ+igBvdVVo4nqzYA51x2+Q/2P7hmmGyJn8SQJogv2Zb4YvvkTvvoHlJtDrXy201Kirx3FQC2aV27XaH0GK+nvRg+gN12R+qE6FQP8xb7o07zbrm65ykD1R3qGvXLwzQ+CvmO0zQFOKXdC8yhPsiCRhwtxlL2Rm6AGIwszXgUtEcUBqz6EqglIeWWf8a/925hGXTJvRcqbzKYqpkSognvGX+r2/AIXqND2dmJ+HDfYO7uyCuNycld3kOSOOA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: la0y669m5K4wIq1MgdeWqCIovsjcuJXu+e9B67MUBs3fAWjl76Z4Pql04ZUw+YPDp05a/fHBj25VIRucn0hM3NMfNSwgFnsOOiuO+toiP2qZackldCyiCnqhjlyFbP0OBF/qsa6kw47cCqSvBN8bqbFboCqY8f5MUjHMOI7KeY91wjb7AalXmp75a1spn4afceIYHU/ktkkID7KR2fh3WPAGiPcFELsDFO+28g8DzxYjfDkstBJDiVTlQYp4+a+2eIg1BX7468zAbgpAjthajiHljsizAYxchFD7UWtG66voXj7qdXWxSE9LZ7WevMNm6MX+B+ggmE2u2mPSu5gtpvE/oVLd69RCjX0JVdmOzgpCfTwC/jDs8vH/JFcCjdbF3XzFh9fLuJuaIAv2lOTpktg4XXNMBq1UjRgn+R00eKDm/5BoPAsNAQe0XDW3Rv/w6NinHggAY/aNnsfaggQSTQybn6OlmdShIJgE+mquUyPuB6EP/ZRqIb9GaTVEEJw4FwxgfV4hz/i66+unPk5uGD5itIZV1dn+sFa2bmPxy146XapehHetIgHugMiQpVKYAWEmH+mX/rFl3DNiiGvhJnYQS/FO/yee9KoQhf4rT5oalnQB1T2RndR3rq7GbxJB
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a734afb1-e778-464d-0808-08df2d85ece6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 02:08:53.7690 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yd/m0mjxwrj901jmB5c7Gd1XuEqR5vt/4Uecn9Lq3wZNytdkZ100Sj2A+D3gAYShy5whJqDwnA7DXxBGpIFB3xyoHP6n+X3XC4ptJY4JNJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR04MB993992
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=7454c2a62=Alistair.Francis@wdc.com;
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

T24gRnJpLCAyMDI2LTA5LTI1IGF0IDIyOjA3ICswODAwLCBTaHVuY2hhbyBIdSB3cm90ZToNCj4g
QWNjb3JkaW5nIHRvIHRoZSBIeXBlcnZpc29yIEV4dGVuc2lvbiBpbiBSSVNDLVYgc3BlYzoNCj4g
LSBWTUlETUFYIGlzIDcgYml0cyBmb3IgUlYzMiBhbmQgMTQgYml0cyBmb3IgUlY2NA0KPiAtIHRo
ZSBmaWVsZHMgb2YgaGdhdHAgYXJlIFdBUkwgaW4gdGhlIG5vcm1hbCB3YXkNCj4gLSB0aGUgbG93
ZXN0IHR3byBiaXRzIG9mIHRoZSBwaHlzaWNhbCBwYWdlIG51bWJlcg0KPiDCoCAoUFBOKSBpbiBo
Z2F0cCBhbHdheXMgcmVhZCBhcyB6ZXJvcw0KPiANCj4gVGhlc2UgYmVoYXZpb3JzIGRpZmZlciBm
cm9tIHRob3NlIG9mIHRoZSBzYXRwIENTUiwNCj4gc28gaGdhdHAgY2Fubm90IHJldXNlIGxlZ2Fs
aXplX3hhdHAoKS4gQWRkIGEgZGVkaWNhdGVkDQo+IGxlZ2FsaXplX2hnYXRwKCkgaGVscGVyIHRv
IGltcGxlbWVudCB0aGUgaGdhdHAtc3BlY2lmaWMNCj4gV0FSTCBzZW1hbnRpY3MuDQo+IA0KPiBD
by1hdXRob3JlZC1ieTogVGlhbnplIFd1IDx3dXRpYW56ZUBpY3QuYWMuY24+DQo+IFNpZ25lZC1v
ZmYtYnk6IFRpYW56ZSBXdSA8d3V0aWFuemVAaWN0LmFjLmNuPg0KPiBTaWduZWQtb2ZmLWJ5OiBT
aHVuY2hhbyBIdSA8aHVzaHVuY2hhb0Bib3NjLmFjLmNuPg0KDQpSZXZpZXdlZC1ieTogQWxpc3Rh
aXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0t
LQ0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIFJld29yZCB0aGUgY29tbWVudCB0byBjbGFyaWZ5IHRo
YXQgcmV0YWluaW5nIHRoZSBwcmV2aW91cyBNT0RFIGlzDQo+IMKgIFFFTVUncyBXQVJMIGxlZ2Fs
aXphdGlvbiBjaG9pY2UsIG5vdCBhIHJlcXVpcmVtZW50IG9mIHRoZSBzcGVjLg0KPiAtIExpbmsg
dG8gdjE6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjA5MjAtcmlz
Y3YtaGdhdHAtd2FybC12MS0xLTJlNTJmNzhjODAyN0Bib3NjLmFjLmNuDQo+IA0KPiBUbzogcWVt
dS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBQYWxtZXIgRGFiYmVsdCA8cGFsbWVyQGRhYmJlbHQu
Y29tPg0KPiBDYzogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0K
PiBDYzogV2Vpd2VpIExpIDxsaXdlaTE1MThAZ21haWwuY29tPg0KPiBDYzogRGFuaWVsIEhlbnJp
cXVlIEJhcmJvemEgPGRhbmllbC5iYXJib3phQG9zcy5xdWFsY29tbS5jb20+DQo+IENjOiBMaXUg
Wmhpd2VpIDx6aGl3ZWlfbGl1QGxpbnV4LmFsaWJhYmEuY29tPg0KPiBDYzogQ2hhbyBMaXUgPGNo
YW8ubGl1QHByb2Nlc3NtaXNzaW9uLmNvbT4NCj4gQ2M6IHFlbXUtcmlzY3ZAbm9uZ251Lm9yZw0K
PiAtLS0NCj4gwqB0YXJnZXQvcmlzY3YvY3B1X2JpdHMuaCB8wqAgOCArKysrKysrKw0KPiDCoHRh
cmdldC9yaXNjdi90Y2cvY3NyLmPCoCB8IDQ2DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0NCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDUyIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L2NwdV9i
aXRzLmggYi90YXJnZXQvcmlzY3YvY3B1X2JpdHMuaA0KPiBpbmRleCBjMDEwNTBjZTJiLi5jNGE5
MTQ0MTFiIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3YvY3B1X2JpdHMuaA0KPiArKysgYi90
YXJnZXQvcmlzY3YvY3B1X2JpdHMuaA0KPiBAQCAtNzExLDYgKzcxMSwxNCBAQCB0eXBlZGVmIGVu
dW0gew0KPiDCoCNkZWZpbmUgU0FUUDY0X0FTSUTCoMKgwqDCoMKgwqDCoMKgIDB4MEZGRkYwMDAw
MDAwMDAwMFVMTA0KPiDCoCNkZWZpbmUgU0FUUDY0X1BQTsKgwqDCoMKgwqDCoMKgwqDCoCAweDAw
MDAwRkZGRkZGRkZGRkZVTEwNCj4gwqANCj4gKy8qIGhnYXRwIENTUiBmaWVsZCBtYXNrcyAqLw0K
PiArI2RlZmluZSBIR0FUUDMyX01PREXCoMKgwqDCoMKgwqDCoCBTQVRQMzJfTU9ERQ0KPiArI2Rl
ZmluZSBIR0FUUDMyX1ZNSUTCoMKgwqDCoMKgwqDCoCAweDFGQzAwMDAwDQo+ICsjZGVmaW5lIEhH
QVRQMzJfUFBOwqDCoMKgwqDCoMKgwqDCoCBTQVRQMzJfUFBODQo+ICsjZGVmaW5lIEhHQVRQNjRf
TU9ERcKgwqDCoMKgwqDCoMKgIFNBVFA2NF9NT0RFDQo+ICsjZGVmaW5lIEhHQVRQNjRfVk1JRMKg
wqDCoMKgwqDCoMKgIDB4MDNGRkYwMDAwMDAwMDAwMFVMTA0KPiArI2RlZmluZSBIR0FUUDY0X1BQ
TsKgwqDCoMKgwqDCoMKgwqAgU0FUUDY0X1BQTg0KPiArDQo+IMKgLyogUk5NSSBtbnN0YXR1cyBD
U1IgbWFzayAqLw0KPiDCoCNkZWZpbmUgTU5TVEFUVVNfTk1JRcKgwqDCoMKgwqDCoCAweDAwMDAw
MDA4DQo+IMKgI2RlZmluZSBNTlNUQVRVU19NTlBWwqDCoMKgwqDCoMKgIDB4MDAwMDAwODANCj4g
ZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi90Y2cvY3NyLmMgYi90YXJnZXQvcmlzY3YvdGNnL2Nz
ci5jDQo+IGluZGV4IDA2MWJjOWRiNzcuLmZjN2JkNjEwNzMgMTAwNjQ0DQo+IC0tLSBhL3Rhcmdl
dC9yaXNjdi90Y2cvY3NyLmMNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuYw0KPiBAQCAt
NTA1MCwxNyArNTA1MCw1OSBAQCBzdGF0aWMgUklTQ1ZFeGNlcHRpb24NCj4gcmVhZF9oZ2VpcChD
UFVSSVNDVlN0YXRlICplbnYsIGludCBjc3JubywNCj4gwqDCoMKgwqAgcmV0dXJuIFJJU0NWX0VY
Q1BfTk9ORTsNCj4gwqB9DQo+IMKgDQo+ICtzdGF0aWMgdGFyZ2V0X3Vsb25nIGhnYXRwX21hc2so
Q1BVUklTQ1ZTdGF0ZSAqZW52KQ0KPiArew0KPiArwqDCoMKgIHRhcmdldF91bG9uZyBtYXNrOw0K
PiArDQo+ICvCoMKgwqAgaWYgKHJpc2N2X2NwdV9teGwoZW52KSA9PSBNWExfUlYzMikgew0KPiAr
wqDCoMKgwqDCoMKgwqAgbWFzayA9IEhHQVRQMzJfTU9ERSB8IEhHQVRQMzJfVk1JRCB8IEhHQVRQ
MzJfUFBOOw0KPiArwqDCoMKgIH0gZWxzZSB7DQo+ICvCoMKgwqDCoMKgwqDCoCBtYXNrID0gSEdB
VFA2NF9NT0RFIHwgSEdBVFA2NF9WTUlEIHwgSEdBVFA2NF9QUE47DQo+ICvCoMKgwqAgfQ0KPiAr
DQo+ICvCoMKgwqAgLyogRy1zdGFnZSB4NCByb290IHBhZ2UgdGFibGVzIGFyZSBhbHdheXMgMTYg
S2lCIGFsaWduZWQuICovDQo+ICvCoMKgwqAgcmV0dXJuIG1hc2sgJiB+KHRhcmdldF91bG9uZykz
Ow0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdGFyZ2V0X3Vsb25nIGxlZ2FsaXplX2hnYXRwKENQVVJJ
U0NWU3RhdGUgKmVudiwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRhcmdldF91bG9uZyBvbGRfaGdhdHAsDQo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB0YXJnZXRfdWxvbmcgdmFsKQ0KPiArew0KPiArwqDCoMKgIHRhcmdldF91
bG9uZyBtb2RlX21hc2sgPSByaXNjdl9jcHVfbXhsKGVudikgPT0gTVhMX1JWMzIgPw0KPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSEdB
VFAzMl9NT0RFIDogSEdBVFA2NF9NT0RFOw0KPiArwqDCoMKgIHRhcmdldF91bG9uZyBoZ2F0cCA9
IHZhbCAmIGhnYXRwX21hc2soZW52KTsNCj4gK8KgwqDCoCB0YXJnZXRfdWxvbmcgbW9kZSA9IGdl
dF9maWVsZChoZ2F0cCwgbW9kZV9tYXNrKTsNCj4gKw0KPiArwqDCoMKgIC8qDQo+ICvCoMKgwqDC
oCAqIGhnYXRwLk1PREUgaXMgYSBXQVJMIGZpZWxkLCBzbyBhbiB1bnN1cHBvcnRlZCB2YWx1ZSBt
dXN0IGJlDQo+ICvCoMKgwqDCoCAqIGxlZ2FsaXplZCByYXRoZXIgdGhhbiBjYXVzaW5nIHRoZSBl
bnRpcmUgd3JpdGUgdG8gYmUgaWdub3JlZC4NCj4gK8KgwqDCoMKgICogVGhlIHNwZWNpZmljYXRp
b24gZG9lcyBub3QgcmVxdWlyZSBhIHBhcnRpY3VsYXIgbGVnYWwgdmFsdWUsDQo+ICvCoMKgwqDC
oCAqIFFFTVUgaGVyZSBjaG9vc2VzIHRvIGtlZXAgdGhlIHByZXZpb3VzIG1vZGUgd2hpbGUgYWNj
ZXB0aW5nDQo+ICvCoMKgwqDCoCAqIHdyaXRlcyB0byB0aGUgcmVtYWluaW5nIFdBUkwgZmllbGRz
Lg0KPiArwqDCoMKgwqAgKi8NCj4gK8KgwqDCoCBpZiAoIXZhbGlkYXRlX3ZtKGVudiwgbW9kZSkp
IHsNCj4gK8KgwqDCoMKgwqDCoMKgIGhnYXRwID0gc2V0X2ZpZWxkKGhnYXRwLCBtb2RlX21hc2ss
DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBn
ZXRfZmllbGQob2xkX2hnYXRwLCBtb2RlX21hc2spKTsNCj4gK8KgwqDCoCB9DQo+ICsNCj4gK8Kg
wqDCoCBpZiAoaGdhdHAgIT0gb2xkX2hnYXRwKSB7DQo+ICvCoMKgwqDCoMKgwqDCoCB0bGJfZmx1
c2goZW52X2NwdShlbnYpKTsNCj4gK8KgwqDCoCB9DQo+ICsNCj4gK8KgwqDCoCByZXR1cm4gaGdh
dHA7DQo+ICt9DQo+ICsNCj4gwqBzdGF0aWMgUklTQ1ZFeGNlcHRpb24gcmVhZF9oZ2F0cChDUFVS
SVNDVlN0YXRlICplbnYsIGludCBjc3JubywNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRhcmdldF91bG9uZyAqdmFs
KQ0KPiDCoHsNCj4gLcKgwqDCoCAqdmFsID0gZW52LT5oZ2F0cDsNCj4gK8KgwqDCoCAqdmFsID0g
ZW52LT5oZ2F0cCAmIGhnYXRwX21hc2soZW52KTsNCj4gwqDCoMKgwqAgcmV0dXJuIFJJU0NWX0VY
Q1BfTk9ORTsNCj4gwqB9DQo+IMKgDQo+IMKgc3RhdGljIFJJU0NWRXhjZXB0aW9uIHdyaXRlX2hn
YXRwKENQVVJJU0NWU3RhdGUgKmVudiwgaW50IGNzcm5vLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0YXJnZXRf
dWxvbmcgdmFsLCB1aW50cHRyX3QgcmEpDQo+IMKgew0KPiAtwqDCoMKgIGVudi0+aGdhdHAgPSBs
ZWdhbGl6ZV94YXRwKGVudiwgZW52LT5oZ2F0cCwgdmFsKTsNCj4gK8KgwqDCoCBlbnYtPmhnYXRw
ID0gbGVnYWxpemVfaGdhdHAoZW52LCBlbnYtPmhnYXRwLCB2YWwpOw0KPiDCoMKgwqDCoCByZXR1
cm4gUklTQ1ZfRVhDUF9OT05FOw0KPiDCoH0NCj4gwqANCj4gDQo+IC0tLQ0KPiBiYXNlLWNvbW1p
dDogYzFjMThkMWU2NDBiNjQyOTI4NTljZTlmMzBmM2MzNDRlZGZiMDI5NA0KPiBjaGFuZ2UtaWQ6
IDIwMjYwOTIwLXJpc2N2LWhnYXRwLXdhcmwtMWU0OGZkMzIxMTg4DQo+IA0KPiBCZXN0IHJlZ2Fy
ZHMsDQo+IC0twqAgDQo+IFNodW5jaGFvIEh1IDxodXNodW5jaGFvQGJvc2MuYWMuY24+DQo+IA0K

