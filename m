Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44FACA5FD9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 23:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCQHw-0003j1-Ms; Thu, 01 Oct 2026 19:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xCQHu-0003do-7N; Thu, 01 Oct 2026 19:34:06 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xCQHs-0002Di-DB; Thu, 01 Oct 2026 19:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790897644; x=1822433644;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=s3haYIbYknhEju93ZwmE6gPwGEvafbq21gvGNDFJj0Q=;
 b=Mv+7el1cjxLRNfi+Mx7mfece82yoJg+MBOR5bsH9e3APGNvPnnHIOHjw
 yBluSwt5nIVKT8PYF4rMxB/Tl4jqWCkgofU9m042qYlGTUt4MeqGZBroW
 S4kBcU8tD+M3Xu79Ygo5QcuxXcoG3cffAfbOzQDK3pcMfieHHtKUhcpFv
 oEKUhT580PGuV3bHQWq8Hj9J5jVz6//2g0JDK5L4YlxC71nB8MJ44f0oO
 V/f8mOAOxcLhwMRa/nJ4X6rQF9rXS6bVHlOiqLKlvCjniuzI025+6YMRB
 39IOyIZZXCYIIiK6N+t/ZMOh+KZoHJwDwMLUbegjKeLQcBLwYMARLk9x+ Q==;
X-CSE-ConnectionGUID: Ts7giAaqSaecHQohAleBQQ==
X-CSE-MsgGUID: tDuSF03ERwaPi/CCxB3j+w==
X-IronPort-AV: E=Sophos;i="6.27,135,1786982400"; d="scan'208";a="152858932"
Received: from mail-eastus2azon11011054.outbound.protection.outlook.com (HELO
 BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.54])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 02 Oct 2026 07:34:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vz4Pg2sw8Pbh+Jp9RT+yB0efYErPOi0KVPrknM2hmz6dcoqK/YlcY+GP+U+wQMlQf/yUYUXx+ZI2lba4IO0YZ+AVj0JY1TM1zCSUSb4+rEOYC+w8/pDRIllxufrNPIHiSSDdZCLXBMXUIPadJFk7zUd+yN9g0DqNY0LiajJO8PpQdU6xL136yBulF5rXprkEJeSyDq+Qmk/GRJ5jh3ZcmLAYGY3rQaSm5OLJDoC8mmt9UAENeqbP1wjJWJ00fZsaMJmFtVnc5wjh5ltdzFqDMb/RiMovgE5O/fZU/8MWzuvKe49p9EsQ5B8vEJja9p+tBJ7KvuV6/YIJ03Z/6sEaSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3haYIbYknhEju93ZwmE6gPwGEvafbq21gvGNDFJj0Q=;
 b=oKDygKvammaov5nXP7C00PAi9t69fjD6H48zCT+BIbUnSq2zxGZBRk+lXlT62nUDwggJmg+wkX1cNtriKs1wlDJJPeEll6s8QiSmLgWBCAAo5qtzbUo6pkVkGjMn8oO2XBUzebT7miCdpQz+dBP9twyKDhqs+pBaONjotNc9DdxFN6vrMdYBNlllFKMKj7dJ7Ih5DoVhPAOYKCefoAivBAKUsuXnTilDsh/XIM6ySnbHS5iNxxuYPouhXS3qUWpnXbmWa7mbIHl761IHu0lV+/iz010CYoTFdASUlSwdodMQXRTdwB+mEsKpU7iS5DFfztLHblQrf4g3ME8XUaG+UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3haYIbYknhEju93ZwmE6gPwGEvafbq21gvGNDFJj0Q=;
 b=xo9ewBUFnA661C/Nd1NctOOa0q9skpFkMNYL1zgtcjXdBehdqrC6cL04KZp/pFYpdbavIxt+wrL82e9gFsQ8BUC/4T52os2AAW2Y4a85nWoKyieuBTULwO511QhbRbrnrwBXA5rytuAatx58BfupfCm+WWtLjlGUDDCL0Bf4FXo=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by DM6PR04MB6300.namprd04.prod.outlook.com (2603:10b6:5:1e3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 23:33:58 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 23:33:57 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "dingtaodtdt@gmail.com" <dingtaodtdt@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "dingtao0430@163.com" <dingtao0430@163.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "lvivier@redhat.com" <lvivier@redhat.com>
Subject: Re: [PATCH 3/3] hw/dma: fix k230_gsdma integer handling issues
Thread-Topic: [PATCH 3/3] hw/dma: fix k230_gsdma integer handling issues
Thread-Index: AQHdUUvVbvG4TzU9tU2ZUZ9HOX0f2bbpWA8A
Date: Thu, 1 Oct 2026 23:33:57 +0000
Message-ID: <0e009c8e861279afcb9344eff6a8b083089ff074.camel@wdc.com>
References: <20261001022223.8633-1-dingtao0430@163.com>
 <20261001022223.8633-4-dingtao0430@163.com>
In-Reply-To: <20261001022223.8633-4-dingtao0430@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|DM6PR04MB6300:EE_
x-ms-office365-filtering-correlation-id: bdd92219-a4de-42c5-5bc1-08df201476cc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|19092799006|23010399003|38070700021|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: 2GruPjiFsizuViKbG1Fb9UdNmZicOwP5xn5QW+rovrVVVscSRwXt5xLaC/cZz9NQw/4D7ncR2lhpPg6z40O8c80krffq8Bfh6rtpv/mhRobMaYJKmYB/pBQl1NYe2wOGrj5WzJ93Adc2/Xr3CEPSKKmf/m/gBEbcuheZoR6iPW9XzQToU0CzUiVqqNwhZvRIdxrA5dSutXUcV0l0Imo7/5Sd2cVPSZqDcXlHOQbuCf2SZvCp1yt2RE9KpOzNJpiQy49WwVz6HylZGN4j0jvS6XnnuNdjZESMKEB78ViCwsDBwQaC/w8IH5zmUWVh/jW127hyFzDy4qHpWlQKe3RWPVBYW4OtSWdj4TRkKxLGEnb3Ery3HaomGX0M975VHwHoTSKSn06hXayGChr2UDYKAIQk66e0NB+yX7Jna/tPY8X2yTqZwvt2t17JaNh2Ph9tesfrAEPTMkfv6K/5vkteA16CucaaO2O2Zj66LziAP8ESjOlAslzCK54Xr1VVvl7KhYVdV/PfMfVb7XjefrAT1EyJ0zRvFkfilUNTpMzWHqz/0c/93HpoWXvPsEVHuUCzqx6JQ52tro/ggU+AQU/ib0l90LA3QMwij/yukQqUvq8GtXWzNBe2umXbdI8u1N9ICuj4Tk3ApHi+Df7LMtonTfcLQ6kn5ekwvnj1N6L+BTcQp6/v5JYkJmpvtbUCIwgEMuImZfBUsMPOrHJJDZvtjfW1VE3OSWM+ZINBkwLUnTU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(19092799006)(23010399003)(38070700021)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWxRRHExSm9TajNXdGtaWnhxai9zamVISU5NbWl2QXRPN1ZCWTEyczNRS2tJ?=
 =?utf-8?B?N0ZwQ2dEMU5EVlpKWGNLNzRKZjZEdXhRZ3ZVVGtYZFFmaHlGdFlSMXRuY0Nl?=
 =?utf-8?B?OC9QbEh5MXhrNW4yTDJXNS9aY2FJMUdybWxPaFFFSFdScWRzK1FnQW5ZV0l4?=
 =?utf-8?B?QUc2U280eUlUNDBuZ21iL3NVTHBXVDFzclovdTE5MHgwbmhrS2I0K1NOWTAw?=
 =?utf-8?B?c3hRbTRRQ3pOTGQ2Rk1IaTRPbFNGbklCSnpXb1lWWHErQVRwaDFXTlpOMXo0?=
 =?utf-8?B?T1IwM0FwTnFETEduSE9JUVE4RDB0RjVoOHpMbXRaLzYrZkxvTGtJbmZPVDZR?=
 =?utf-8?B?UUdCMnh1QnpTWDFvTzZqYkdUMXp5QXNiVG5jWDJrYXZPZVYwL0NoMEIrNzVC?=
 =?utf-8?B?YWx0S2cxamJXbzJwM1hrQWNuSFY2SGlpSnJuL1V5ZVEvaVZiNGdvMkNGRmIr?=
 =?utf-8?B?dzlyQnI5ODB3YlZONWNnODh2SGdxb1NBQ1JUb3QzU3ppT1hzeStYMGQzMFRR?=
 =?utf-8?B?UXJ2SFRtSE5xdmxRdmN0bGtkbE1taEF5UXpTSHpYRmVyeVpZcTVRVmxjYnpK?=
 =?utf-8?B?QVVXR0xjVUk3cWd2UDI4RUJ5TWU3WEdFNUhmR2Y3N0Q3MnFhVjd5V2lCTk5S?=
 =?utf-8?B?aHFjTm5QYTVvQzJXUlduZTRqblZRaTJTczMzSjBHV2JyOEVUV2VWUG50Q1Jz?=
 =?utf-8?B?UEFyZWVkUUd5N0tlVVpMZndCYlNXbUR1K2NTM1pHdVduTVdEa1U4WGZMdEVr?=
 =?utf-8?B?Mll5M3Yrb1lsVTJ0L3NIbHQwV2ZLOWQvTHBDaTBXYm4wdmZIdHJ4Rkl3ME9n?=
 =?utf-8?B?Tm15TXMxY1JBa2g1OHBzM1NQV3QwY0xjQXF1dCtWaU1UMWZibnZ5RDJzL0dQ?=
 =?utf-8?B?OVEyUVluMzVLeDllVm9RYUIzNGs0b2xZck5pNzU0b0RQbWg4SWpoejgrYmpw?=
 =?utf-8?B?M1FEVVJYKzJ3M1d6QkdEZ1R0bnlIakRSUXcxV0lZUFhjVno1YU5zdy9JdGJN?=
 =?utf-8?B?Q3IzaFZjbjA3T0hIczI4MTZmckhYMDVsaVpOeC9JUlBHNEZob0FSWGJwUURE?=
 =?utf-8?B?ZzIrUTFOVXNGVzRUdmkyMVlSdmxEZlpUQTB6OWc2V2s3Z2FMdzlycm1KclE5?=
 =?utf-8?B?VElUT2xlamRHTGMvS3ZyaW8zNzVRTTVTanAvT2l5SFB2b1NBUnI2WHYvb0t2?=
 =?utf-8?B?UUVjeU4yVkFLYThzcnNWUGNBZThqT3h2Qi83UXBWWkVDMmUveXNweE80QTh5?=
 =?utf-8?B?ZFY1V1krTnhZNVNBNk0zUUJRdFJ5QUgvRlJMdklreVhHcFkwOG44Q3YrS2x6?=
 =?utf-8?B?aFFNMW1aSWpnVUdQNVRJa1pUVW9WeThBSWpCQ0xJZzQxVWVPbGt6MHdVbERu?=
 =?utf-8?B?MjZrYzd5bkhrRTczblRybUlUdTVzWjVrcm94OVJhOXQ2UmErblpXREhJUVdH?=
 =?utf-8?B?N3hWS2R0cGZtQUpjenF6VGo5M1loQkZzVjgzdzZITUVvWWU5MWFCYmExQ0NR?=
 =?utf-8?B?NUlYVUx4enhXYjAzQk9WaDRIdFFYZi9Hd1pMVStTdWZhdVFVOFJ0eGFaSFVN?=
 =?utf-8?B?TEN6b3RSOU9xNlJGM1FpVXBhTzdCcElVZ0pOM3cydTAyM21YL1NTVXFNekVG?=
 =?utf-8?B?dlFYVXcwVGtXbmtodkFUNVRyZzRpRWx2R3dBS0FrWWR6eDlwS0ViUFdod1ZJ?=
 =?utf-8?B?R2N6eHRzcUI3dGZTUURZYmFjb3FKeEowb1ZQSzFVT0pxWW9ndGpVYXB3Unlp?=
 =?utf-8?B?TWlCbTlPNmlxb1p1TndpVmVBcXhZbVRmSDFxaUtnRC90Vlg1bmQzNkFJbmJH?=
 =?utf-8?B?cXB3amRKcjJtWFBGN28vWXpEZ3hMakV0czJvMHFDUTljMDFKeU8zRHFrOE9u?=
 =?utf-8?B?VThuZzRTS2d6NDRPNFJVaWYxK3FHM1NjcGl1TkZhbFdPdGFCTE8xR3FDOE1C?=
 =?utf-8?B?Y0x2eUpQMjltanRUdmNTeUxrZFgyZWErS1dCY05EbkJTT0VLVFZScnZodVpH?=
 =?utf-8?B?dldSZC9UYU5XcVRhSjIya3JIR0JHSHZGQTVwY3NXcVN6VEhzVlhJejRzV2p5?=
 =?utf-8?B?WUgzdWhmaVRrSXNVL0FKSmg1UmdIemdXYnhUUExuZWR3OWRwVlA2VmxZa0hV?=
 =?utf-8?B?b09rNFR0Z1pBc3p1Rk90dmFmRGY0OHVoV3VoWWYxN0ZPUnI0YTVMSjMzRzJY?=
 =?utf-8?B?TG9MZjgzdlpBN3k1TTdIOWVtQ1RSWnlXU2tOdStNZHZrU2Z1QVZralVOck5T?=
 =?utf-8?B?V2ZTbzIxUTMxQ20zVkh5TlUyWjMxNDZSa0pXMmI1cEZmNzJjWjhDYnZvam83?=
 =?utf-8?B?Vkt0NTUvczlJcU0yUlJtUiszSnViZHdrOWY5QzNFZHI0R0ptVGZsVW15VEdE?=
 =?utf-8?Q?MnY4OXgW/oc61yF56UsgHcJDxIWKxNHuBh8D3vuoSIPlM?=
x-ms-exchange-antispam-messagedata-1: l+ndd5SWGeJ0AtDke7rnBh1iZwL9UpwlC4w=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF6DA0B47083584D876FF1B0EA2D49D7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: yejd8oM6WPQFO6QbRLgTKHoj2yQGaTU1PG8yFL+UHvXL3Vm+5yNTbjeSy9q5UKqutYn+WIITEdTDsnN56FpP4R73p6GrU7M+7ZYOup22kX1j2rHja/l/31o6Q39ADHGU6ITfkJwXc/ZpBvkcwT5GkHV2mMKngCPfaWW/qV8Zv38NTbLAQd8vOhc27e/eeAbLiwHQgvuaRvtDtLVJqANzEG14Owix6jSBtYqehuqr5YEd20trITJfSlK5ZapizlpGKeoKY1MkCBGxlfcWnwCj9+CpLpk6R6Wc5EPVedYdY2o3rZyYMvVYrw/cjMQVRffdFGQreuFeG9i6jvC6vA2JYg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KRRK2IUOanGaCX+j8a/gjSqT9Ocxh75BVgIwESFkfFI2ZmYmwXo3ZXxrtKSn/sciXVWfk1DV+qLk/qN/L6RY8qOQDX+K5GqsgqU8V0yDPxOO0r998YlXxZIxF6eTeeKOimymh9CpZycQRdmIbf7E310gtvloYv4ASWW/dqSWe8yl+MQfZMeiMH8/4s8y3iUa1alzjItrN8wbpg18s8M3EfCBtmEamrTsSFIyvzH5pGsHPMpoLvgYcW/lrcfrKrOD3H8VXGOAJrt3LfY/jvlH33x0HBiUOALZjc8YYt5WSSBH1oCcGszkz/+pZnzpOdDyjIMobt1pg7qYDnPruDLdH62ttMBNV4CaR1DV4Or/Bl8NzEBocz6xgJHclUFskvJbA/TpYoBUrHiw5sZTZ+dLtWKHbrdAp5u4zY3rbQly7Vb23WI279ejOjDIvMf1XjX7uxgK6KaK1hx73ECF6XM/e5k38jdXZs8OLQwyPw6Ea0OwmoX0aisMwU0HgkW06McuAO7bEfLSFc7DFDRFtRvODLv4CblgwmajaUuAj6w5BxgkqrkMq1nMEzgMXJXtBQceY2c/viWONYF5U1Nu2cy+wtM9TJk6j90KTi0Efcv1kn3N5hAgGY8Q+fhvI3aKn15n
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd92219-a4de-42c5-5bc1-08df201476cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 23:33:57.3302 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZTFTrExQWBXgV7YYmxJoe12ADQp8Uz53WuGsqB5j70ipbRIZbCrpis2EhjNo4k5T1oHV4F+ukU0EFFdodxxRZ6R1kagtZNDtFl0omIhWwAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6300
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=727d860e1=Alistair.Francis@wdc.com;
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

T24gVGh1LCAyMDI2LTEwLTAxIGF0IDEwOjIyICswODAwLCBUYW8gRGluZyB3cm90ZToNCj4gVmFs
aWRhdGUgdGhlIGFkZHJlc3MgYmVmb3JlIHN1YnRyYWN0aW5nIHRoZSBjaGFubmVsIGJhc2UgYW5k
IHVzZQ0KPiBod2FkZHIgDQo+IGZvciBjaGFubmVsIGNhbGN1bGF0aW9ucyB0byBwcmV2ZW50IHVu
c2lnbmVkIHVuZGVyZmxvdyBhbmQNCj4gdHJ1bmNhdGlvbi4NCg0KVGhhbmtzIGZvciBzZW5kaW5n
IGZpeGVzLiBZb3UgYXJlIG1pc3NpbmcgYSBjb3ZlciBsZXR0ZXIgZm9yIGEgbXVsdGktDQpwYXRj
aCBzZXJpZXMNCg0KPiANCj4gUmVzb2x2ZXM6IENvdmVyaXR5IENJRCAxNjg1NTE2DQoNClNob3Vs
ZCBiZSAxNjg1NTE0DQoNCj4gDQo+IFJlcG9ydGVkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxBbGlz
dGFpci5GcmFuY2lzQHdkYy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFRhbyBEaW5nIDxkaW5ndGFv
MDQzMEAxNjMuY29tPg0KPiAtLS0NCj4gwqBody9kbWEvazIzMF9nc2RtYS5jIHwgNiArKysrKy0N
Cj4gwqAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvaHcvZG1hL2syMzBfZ3NkbWEuYyBiL2h3L2RtYS9rMjMwX2dzZG1hLmMN
Cj4gaW5kZXggNzYzNWNkMTllOC4uZTlhNzg3N2U1NCAxMDA2NDQNCj4gLS0tIGEvaHcvZG1hL2sy
MzBfZ3NkbWEuYw0KPiArKysgYi9ody9kbWEvazIzMF9nc2RtYS5jDQo+IEBAIC0zMDAsNyArMzAw
LDcgQEAgc3RhdGljIGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlvbg0KPiB2bXN0YXRlX2syMzBfZ3Nk
bWEgPSB7DQo+IMKgc3RhdGljIHVpbnQ2NF90IGsyMzBfZ3NkbWFfcmVhZCh2b2lkICpvcGFxdWUs
IGh3YWRkciBhZGRyLCB1bnNpZ25lZA0KPiBpbnQgc2l6ZSkNCj4gwqB7DQo+IMKgwqDCoMKgIEsy
MzBHU0RNQVN0YXRlICpzID0gSzIzMF9HU0RNQShvcGFxdWUpOw0KPiAtwqDCoMKgIHVuc2lnbmVk
IGludCBjaDsNCj4gK8KgwqDCoCBod2FkZHIgY2g7DQo+IMKgwqDCoMKgIGh3YWRkciBjaF9vZmY7
DQo+IMKgwqDCoMKgIHVpbnQ2NF90IHJldCA9IDA7DQo+IMKgDQo+IEBAIC0zMjksNiArMzI5LDkg
QEAgc3RhdGljIHVpbnQ2NF90IGsyMzBfZ3NkbWFfcmVhZCh2b2lkICpvcGFxdWUsDQo+IGh3YWRk
ciBhZGRyLCB1bnNpZ25lZCBpbnQgc2l6ZSkNCj4gwqDCoMKgwqDCoMKgwqDCoCBicmVhazsNCj4g
wqDCoMKgwqAgfQ0KPiDCoA0KPiArwqDCoMKgIGlmIChhZGRyIDwgSzIzMF9HU0RNQV9DSF9CQVNF
KSB7DQo+ICvCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsNCj4gK8KgwqDCoCB9DQoNCldoeSBhZGQg
dGhlIGNvbXBsZXhpdHkgb2YgYSBnb3RvPyBZb3UgYWxyZWFkeSBoYXZlIGEgYGFkZHIgPA0KSzIz
MF9HU0RNQV9DSF9CQVNFYCBjaGVjayAod2hpY2ggd2lsbCBuZXZlciB0cmlnZ2VyIGFmdGVyIHRo
aXMgY2hhbmdlKQ0Kd2hlcmUgeW91IGxvZyBhbiBlcnJvciwganVzdCByZXR1cm4gdGhlcmUuDQoN
Cj4gwqDCoMKgwqAgY2ggPSAoYWRkciAtIEsyMzBfR1NETUFfQ0hfQkFTRSkgLyBLMjMwX0dTRE1B
X0NIX1NUUklERTsNCj4gwqDCoMKgwqAgY2hfb2ZmID0gKGFkZHIgLSBLMjMwX0dTRE1BX0NIX0JB
U0UpICUgSzIzMF9HU0RNQV9DSF9TVFJJREU7DQo+IMKgwqDCoMKgIGlmIChjaCA8IEsyMzBfR1NE
TUFfTlVNX1NETUFfQ0hBTk5FTFMpIHsNCj4gQEAgLTM1NSw2ICszNTgsNyBAQCBzdGF0aWMgdWlu
dDY0X3QgazIzMF9nc2RtYV9yZWFkKHZvaWQgKm9wYXF1ZSwNCj4gaHdhZGRyIGFkZHIsIHVuc2ln
bmVkIGludCBzaXplKQ0KPiDCoMKgwqDCoMKgwqDCoMKgIH0NCj4gwqDCoMKgwqAgfQ0KPiDCoA0K
PiArb3V0Og0KPiDCoMKgwqDCoCB0cmFjZV9rMjMwX2dzZG1hX3JlYWQoYWRkciwgc2l6ZSwgcmV0
KTsNCg0KV2h5IGRvIHlvdSB3YW50IHRvIGxvZyBhIGZhaWxlZCByZWFkIGFzIHN1Y2Nlc3NmdWw/
DQoNCkFsaXN0YWlyDQoNCj4gwqDCoMKgwqAgcmV0dXJuIHJldDsNCj4gwqB9DQo=

