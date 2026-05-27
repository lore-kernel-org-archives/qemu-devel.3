Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EFBCD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 00:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS2Ml-0006n0-Q2; Tue, 26 May 2026 20:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6009f06ea=Alistair.Francis@wdc.com>)
 id 1wS2Md-0006mg-Sn; Tue, 26 May 2026 20:43:17 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6009f06ea=Alistair.Francis@wdc.com>)
 id 1wS2Ma-0004jb-Fx; Tue, 26 May 2026 20:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1779842592; x=1811378592;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=YH/jxGdOWjw5vskpY6tiVAJntp/kC5cCin4Jf00MCl4=;
 b=owDfRJgVk4ScGocgKW+YwwM6A/FQxE8iMLAlFYQ4BY9dGNp09RI53b+n
 ELjT67yyhbtSlLal4fd4J66wR/c9m0kBZ5NJP9ghY+ZUubvJ14DwOwqav
 NSfe1u+7oo/puQScOCwSPc4VEvusWymMnirn0U0YX9xI844kMgDMZI/fB
 SQ2ZJ7peYKAgdBFva1FpxVrwHGfj2tMTIO0oL8mMfJ6ZDwzBMqqv/wD+2
 QQyDsGlJvmlihIHO1rhbFkR/7J0bm8t7u8sjkuplGHGojGY/RmXP/7yvz
 0Y/+BDYkj6Iz6Jn3YJ2IqbbXGFvHco++rYdHy+V5xBNOqFZJAnE7HAblA w==;
X-CSE-ConnectionGUID: UdKoHBi2QlWOUGtyiZlPfQ==
X-CSE-MsgGUID: 6a3fCwY5TtemoW1lj+u5Ug==
X-IronPort-AV: E=Sophos;i="6.24,170,1774281600"; d="scan'208";a="148681799"
Received: from mail-centralusazon11011070.outbound.protection.outlook.com
 (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.70])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 May 2026 08:43:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPCo+31bkjle6hrZBIr8CXl0A8ziO03CQ8km2/r5FTGdLYWOpuCjo7zWbQVWx3o68eNQJVVqQIUGm2fR2rUIiFX1LXuiGgG8qcy4BvPbx091T4KhXmHUiPyUdBoCHcgaoZow58CA7sZI0wDOuboBLeWC6rdDppfTDboMteIDsRozrqyFnLzTdTKdtxlxDyEw7grzMXLSyIFh+loSrEGs86GFdFlT4qZX8xbSWsifbf7Lo1BDEfmtAZy63U2hilDWIIw/uOtmTDiXSrXRQ5WEvTs5AytarI0kp/XNhBFR7OBfIoNYg+TZdJSznA4+Wtjod5I5otnJp+rdwkqWD/cLww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YH/jxGdOWjw5vskpY6tiVAJntp/kC5cCin4Jf00MCl4=;
 b=ghWi3unCUc/xX99DNNfshqDcZfsuFY35lPIKj6VIBhek4qg1gyTYOIqAZMvhfABjquWxT/+75+JiVr0gadekwG/PLGHB3a0ZmihWO/AS+aQ3hkJZb1yW+Hvq/sRYueAZluoZqIlBzbznhkNaWPeTjXzBAiDIt+pMXNWKeQffgkxJIepa0Er5hK31c3BwGhBT7hYDsmcSmmelWdY1s41rKWN5l+64kE8guzHuzpPb3yNcXRHq/cykVgUEwhup0xD2ej5L0WGQDuXlZLvTWmJI4k7ppBNomlrV4EJJn75Ku53PgBiZRkVco80+M5M3819Hc5siNwwz6QzZLGaNaKH7gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YH/jxGdOWjw5vskpY6tiVAJntp/kC5cCin4Jf00MCl4=;
 b=umMSX+oj2eo7peT2bwXRp+Fg7RNO0ssPXrHHVdVZ5hDWNxR3vkyWMVeuq+Ss5gcGUfQ299lQUGdwN7YUuCc0LdSIG/lcYb0Zsgrah0kpMjhkjkalMZaiR+OHiIKEsXU+cbk3Co9273zOLZomYteOGt7m/DmxAVX8PatFqOyxugI=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by IA3PR04MB9088.namprd04.prod.outlook.com (2603:10b6:208:525::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 00:43:08 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 00:43:08 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv/cpu_helper.c: fault with reserved PTE.PBMT
 val
Thread-Topic: [PATCH] target/riscv/cpu_helper.c: fault with reserved PTE.PBMT
 val
Thread-Index: AQHc6SLStPtYEzHEwk2PCRKqM+Us2bYhEUuA
Date: Wed, 27 May 2026 00:43:08 +0000
Message-ID: <3843f1a4a9d3b6540f7611aa01bb0dda6e343813.camel@wdc.com>
References: <20260521130727.2311629-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260521130727.2311629-1-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.1 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|IA3PR04MB9088:EE_
x-ms-office365-filtering-correlation-id: ed6966a3-9a2c-4ff6-03e9-08debb88ec1a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|10070799003|22082099003|18002099003|56012099006|38070700021|11063799006;
x-microsoft-antispam-message-info: jh5omLdd23jY4JZTLpNTV3PcbHBpyXk89P7y2fZpyROn9JzxCXnUyDfnAe+ZcEdo4X7URHZtjEqBwynY5oT7VGbN7DVJpZONl+d9l68lgSBSGoe8GJGx7LdV/JL5Ykjnwt4+tihR9MzcFb9wfEMjuYBRO1T1CKLp5oMgfyHpoO3RNS9qay4JuK1LjNk5OAzLMevSnUPX6ionfpRWbazcSoihq8ELMOE+YenV4rbbsvEEjuZm3CYdwQmPUyYhGOkUb9H4HHi+HYZLp4VUFI+PVf6cIzTUOLQvo0yDjS4loB2No4ucAvl0KI9oet882vFGmyupfnjLx4inYzvNrGR+VARKE6AZqiEk4YrTwwK7ax2wKmTu1O8mymLrAaVUE7FXQhh5cOXdY3fAskv5klJAYvaYAG5qT7+xF0kkRjuahRuVb5JkdQY40yZxEHPF9lg6mHdCbr13AQvbNvlcCwILi3B8E6h+6bt5f6US6HYWcK+fQ3tORl/NC6p3IgWg9zkG39vbyT/yITkbA+6W4MItvJ4toJYWLjYZcyF4FlDV8whVMpaEMGDHwHHRYhpIzk2YeehzVsH0Tvrt52UHWcArQAun2Ic43B537keEWil+SrScxKV/cbIBUhBSUjMCg7MLaf6cSfTHVxNZQ6EiSD5r6PNvJx9SEYZOhp9va8tNVOVqTUwPKhBI8oHbTd+4BRRbtjOPIfIv7Xij3THHy1p/ImKSkBW4FWxBvBw1X0xGKW6KkOvkp7mrTq2+B8rxBG9Y
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(10070799003)(22082099003)(18002099003)(56012099006)(38070700021)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3F6L2Rjdm1rVThPYjlLY1cyNGtHMG56VDVmVHU2SzBLd1RKT05RQmlham9Q?=
 =?utf-8?B?ZnlIbGdKMHk1aG9VOVBIaU5lNjVGOXhsVGdUVFAzNys0QjRlWXIzWG1LQzFY?=
 =?utf-8?B?QlYzMUFEZTZHejcvRkVrUjc4dmp6ZVdCVi9zUlJ3RWVmbVpLcDhHbC9Vdi9H?=
 =?utf-8?B?cGV2aTArSUlrM3RCdXUrb1F0dkU0SThEOUIzZWhxM0FyaExWRVN5VHFYeXE2?=
 =?utf-8?B?eHNCSmhnNDNvQWhKczB2U1I4R29XL3Qvd0J1U3JjczRPdk9IVXdCR1UyRDhY?=
 =?utf-8?B?R1BRTkZxaUJpTUdkRzBhZEdvbVhpZ0dPZUNZTUU5aDRuSFJkcXR6VnY1bmtM?=
 =?utf-8?B?UjYzcDlxY291eklYb2M2d3RwSTRlZjJrLzhuUDhaTUY5eUJ6dzVwa25vMy9V?=
 =?utf-8?B?SFF3d3k3dDJ5MTc2UnJxb2RRanJuaUdIWU01ZlhRZEJENk9sNDVWYXpTZURX?=
 =?utf-8?B?MXRxVXJXeitkaEF6aFdXZXlQZzBvYmcvSDV5NGpZeWFhMTZEQVBuRkQ5WEpx?=
 =?utf-8?B?bk1ySUxBMzE4OVlPU0xxRkVDSThYZWJtd0Y3RkREOEs3eFc5ejhZY3RzVWVj?=
 =?utf-8?B?MUNPM1NqRlNaWG95QWpJVnkyV2RMTzlWWWNvc1ArTWtxVTViK1NvSVdsRGhD?=
 =?utf-8?B?RDNXS3VGMGlmbVhtcGgwYjZOWVhSSmpDUnBLNTBacm1oYy92a2lTWCt5dE84?=
 =?utf-8?B?NXQ2ZmQ3R01wRkd1emdINXhUL3VVRGNhQnQ4OVVPeDNrS0wxUlVQMVduYm15?=
 =?utf-8?B?RVh1MVBJVmJmejFiRjNiOU9JQ3diZmtsSit3aC9LYmczWFhINlZuL2xyMWt1?=
 =?utf-8?B?TEhKWi9FRThRNS9QL2FHOXp0MURibHFLeFN3OFh0bEd2WG9KWEZ6SHpPeVpS?=
 =?utf-8?B?cDhoVnJUblM5eG1janRUSUNpTHlwOHUwZ3BCcS9XeDMvRE9hbkppcUNsRlFv?=
 =?utf-8?B?S0grVmZDL1U5bTgzNThMUlYxV2M3MW5kOStpclhObER0eUY2Z0NFZk82eXlH?=
 =?utf-8?B?cDJCcjJpcDRoMHV1Mk5pVGR1UVdmeVZwTi9LNFJYSlFzcC9QLzc0YUYwVHBF?=
 =?utf-8?B?OFdWMmtSOWhJV2I3ZWFlR3pLaTd4RzVxdk9xdmZHTHAxUWgvcGJOTDhReG5v?=
 =?utf-8?B?V3RxZVB5aGI4S0NZRkk3alViRVdFMEZEN1hJTzVwbjIrdTJJa1FkZHpwYmQ3?=
 =?utf-8?B?SDdhMmZnQkhORXo3ZEEyTFUzRDNhMXJ0ZkNxWm9vNDBUaWQrUlBIRG8raEov?=
 =?utf-8?B?SFlsMXlwNkZLM1VFb1VISEpJUEVQZnk3Vlo4ZE5ndU1naEQ5L0xNVE9ncFFh?=
 =?utf-8?B?anFWUVhrSDlROE04SzlhSk1COEtOaGZOU1lwbVhscUFtMzdDSkRzeXl1ZjN1?=
 =?utf-8?B?L1pkSkRoT1lVK25vZ2t5UUJNeThyVk8xQVFiblAydXdJbG9UNnJaNFlOeGtj?=
 =?utf-8?B?bW1zSkRaU2t5M3hqWGc0MDV0MmJNTnIzbzlmTk9sNkRXWmdtU3BDYWpsWTdt?=
 =?utf-8?B?WlFjMDE2cnNsWStUVGNENlFzQWZDbjdxRnJjZE1XOHBvUUo4c2FRUWphTWVt?=
 =?utf-8?B?TkZ1d09NbHlmNzN2azVxeWl3M29wOEZQUk53b0tQdURuNFhkR3VoODRKeTRD?=
 =?utf-8?B?TlhORS9HZjZ4enZrNE1SQTVmWXY4dVhWM1E0RUFraTZhMGZyTjg1NGppQ243?=
 =?utf-8?B?dE5ETTFtM1huUkhLenFCcy9aQU9NaVVydXF6ZWhEUkVFbFhjNm1ncjlzSStY?=
 =?utf-8?B?Slk3dmR2VmV0UHJPdkZnYWFySndQUlYwYkVnUFpnQ1owa3NDaEQ1UjhRSE9m?=
 =?utf-8?B?WWVvb3ZyM0E5OU9ZL1FvZnI3ZEdhT3V1SzVVTUtheGcvZnUwK2ZxdWY1c0Nj?=
 =?utf-8?B?Smxsb2hDZGNlalp1QytoY3JWVlRPU0dCNHNPSVlUTldISTRnU1dBazJ3eG1q?=
 =?utf-8?B?ZDBvK09JQjhBNW4vckdFQ3hDYWc0ZFB5aThMOWQxeHFlYUpHbVRYcCtHT1lC?=
 =?utf-8?B?WkdFWGZ1Sjh0UGpuVGd1TVRMRFQ1OC9yajRyME13RXBibVMyRGV3UlhwVXd4?=
 =?utf-8?B?d25xR3p6aFQ3ZFF0NnprWHR3TmdjSEY1WlVDUkNoYUdmVEtPN0V2YXBEMG9h?=
 =?utf-8?B?MDFVT0RWNXpZZGVlRFZjMWUrSzdIV0lXcEJpWnRaMStzY3ZVeEk5Q1VGT3Bm?=
 =?utf-8?B?OEtmb1cxNjd0RVVHNTFnZEZXUjF0b1RiYmRQRkNlZFJTK3Z6d1k1alVza2lD?=
 =?utf-8?B?RmFtWjhLbW5KZUU2WENEUTYxK3VKYVgybW8rS1BvYlY3VGJqd0Z6ejd5bDBp?=
 =?utf-8?B?aGpEVGdLRFo3TjJIeFlYZmV6azM2ZmR1WDlvMmRGNXcyQ0l3cUY3SHY5akMy?=
 =?utf-8?Q?AXNatciz7Boz9vrpVbbTfVPdPmWuueEZdtMYxgMsiEuGw?=
x-ms-exchange-antispam-messagedata-1: 3Ry0hzRaXktklClY/enbhkFTsarBnWeQ58g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DF353EA84B0C94E8A411A45C24B88CB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OKhf7r/mYoTqN2/I9gQno69NDDcSWRC7lIfV/Ij+F3XeYNOJI6OmZnK8M24usvyiBKEzgxzZavTPfRVUObpOijxjtyw3fawDnhQCvdqLpoFqd51QtyBG1zEcY2nsoGiPaRexXHhgA1qRsetcNnDfP75gfB3wgwAjryZvZBFpuDaLSD/zJSbe+8uwWuusWoiLp1gGm//y/SK/06kwjiG0iEVOUZt0AI2DLu6VwzTnPV0eaKqdNm9itRgtzg1ld2Oo7DBpJTBV6w8uVvFS03z6p3q5bmt1n3XN3VhpaZ1EEnOu7cxPl9X3ccxYHyq8ggwgzio5zXGEcjbMVbdMxagA7w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ClFtjDrWL0u0zn0/G2u9eLrMrnn2piGL2k+UfxqQ4mwiptkel86fBHs5GA/fO2aPVkkftmj4L8N3FmWqKifWuAkcD4GAU+O5AZgCgth3KyTXEQXH7v9qkCrHHYxJDhJwc90cFoPitzAHLqGVh7CqPuQYdeagGsyTBY+/DVZlbGImQ4WZdCU/Lpv06tJnHFal9JusiGR3gGKlV4deYdyKwhNqykc1rVyiiRu/6bBukPtCl10G5fwsOKLUQiZThdIAOsprJxbzgj6jTZd/T0EJvDW9teklMCIjo0YNmyLsc1x19z0XY3NIANZHOxdFkbQVacBJ6/IujYKLksADKZct6TbKCx1sejU3JPsZoke+8Lb/5DdJ5MU56QfSG+feKptxWiHj3tfgUkKqoQiRZhWIXWbLyyGRIrX3qmIl85fJjUeRcUJeN8noA48L89SntHzdUNDn+3H8Slm9RPLcjbc6ky2MgmxuPkBydZH/Pjnw02IYAQP93PdciQ2v7XY/Z6NY9eN8fN6aH3y7bcHlYMys/uGenPUBTRaDSpwNeA0N/2wK6G97T59AyWGwImEbXr+8gKUxt7K5nsCt8YLHc0OwbCGNdwhRv/d8l6PfHXxvrksNYxc4zoLLdJ6kYuPo7hzR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6966a3-9a2c-4ff6-03e9-08debb88ec1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 00:43:08.3795 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FlSbWt6TbWC+RpkZABsEOPxZ7Uf2Y9bGernUxKgboRu9YifC0k1RMwDgDghS6oBKAkA92qc6T1TrsxjZHeSdXeSxDpFRHRpwWD7BE8YgyKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9088
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=6009f06ea=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
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

T24gVGh1LCAyMDI2LTA1LTIxIGF0IDEwOjA3IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToKPiBXZSBuZWVkIHRvIGZhdWx0IGR1cmluZyBhbnkgYWNjZXNzIGRvbmUgd2hpbGUg
UFRFIGJpdHMgNjItNjEgYXJlIGJvdGgKPiBzZXQsIGFjY29yZGluZyB0byB0aGUgUklTQy1WIHBy
aXYgc3BlYy4KPiAKPiBSZXNvbHZlczogaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9x
ZW11Ly0vd29ya19pdGVtcy8zNDk0Cj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIEhlbnJpcXVlIEJh
cmJvemEKPiA8ZGFuaWVsLmJhcmJvemFAb3NzLnF1YWxjb21tLmNvbT4KClJldmlld2VkLWJ5OiBB
bGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+CgpBbGlzdGFpcgoKPiAt
LS0KPiDCoHRhcmdldC9yaXNjdi9jcHVfaGVscGVyLmMgfCAzNiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysKPiDCoDEgZmlsZSBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspCj4g
Cj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9jcHVfaGVscGVyLmMgYi90YXJnZXQvcmlzY3Yv
Y3B1X2hlbHBlci5jCj4gaW5kZXggMTczMDVlMWJiNy4uYmM2MzcxM2RkZiAxMDA2NDQKPiAtLS0g
YS90YXJnZXQvcmlzY3YvY3B1X2hlbHBlci5jCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2NwdV9oZWxw
ZXIuYwo+IEBAIC0xNDQ2LDYgKzE0NDYsMjUgQEAgc3RhdGljIGludCBnZXRfcGh5c2ljYWxfYWRk
cmVzcyhDUFVSSVNDVlN0YXRlCj4gKmVudiwgaHdhZGRyICpwaHlzaWNhbCwKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gVFJBTlNMQVRFX0ZBSUw7Cj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIH0KPiDCoAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIHByaXYgc3BlYywgIlN2cGJtdCIgY2hhcHRlcjoKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogIkZvciBub24tbGVhZiBQVEVzLCBiaXRzIDYyLTYx
IGFyZSByZXNlcnZlZCBmb3IKPiBmdXR1cmUKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICog
c3RhbmRhcmQgdXNlLsKgIFVudGlsIHRoZWlyIHVzZSBpcyBkZWZpbmVkIGJ5IGEKPiBzdGFuZGFy
ZAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBleHRlbnNpb24sIHRoZXkgbXVzdCBiZSBj
bGVhcmVkIGJ5IHNvZnR3YXJlIGZvcgo+IGZvcndhcmQKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICogY29tcGF0aWJpbGl0eSwgb3IgZWxzZSBhIHBhZ2UtZmF1bHQgZXhjZXB0aW9uIGlzCj4g
cmFpc2VkLiIKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICoKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICogRm9yIGxlYWYgUFRFcyB0aGUgc2FtZSBiaXRzIGFyZSBhbHNvIHJlc2VydmVk
IGJ1dCBpbgo+IHRoYXQKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogY2FzZSB0aGUgcGFn
ZS1mYXVsdCBpcyBtYW5kYXRvcnkuwqAgTWFrZSBib3RoIGNhc2VzCj4gY29uc2lzdGVudAo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBieSBhbHNvIHBhZ2UgZmF1bHRpbmcgaGVyZS4KPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYg
KChwdGUgJiBQVEVfUEJNVCkgPT0gUFRFX1BCTVQpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9SLCAiJXM6IFBCTVQgYml0cyA2
MiBhbmQKPiA2MSBhcmUgIgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICJyZXNlcnZlZCBidXQgYXJlIHNldCBpbiBQVEU6ICIKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiYWRkcjogMHglIiBIV0FERFJfUFJJ
eCAiIHB0ZTogMHgiCj4gVEFSR0VUX0ZNVF9seCAiXG4iLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fZnVuY19fLCBwdGVfYWRkciwgcHRlKTsKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBUUkFOU0xBVEVfRkFJTDsKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gKwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
ZiAoIXJpc2N2X2NwdV9jZmcoZW52KS0+ZXh0X3N2bmFwb3QgJiYgKHB0ZSAmIFBURV9OKSkgewo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIFJlc2VydmVkIHdpdGhvdXQgU3Zu
YXBvdCBleHRlbnNpb24gKi8KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBxZW11
X2xvZ19tYXNrKExPR19HVUVTVF9FUlJPUiwgIiVzOiBOIGJpdCBzZXQgaW4KPiBQVEUsICIKPiBA
QCAtMTQ5OCw2ICsxNTE3LDIzIEBAIHN0YXRpYyBpbnQgZ2V0X3BoeXNpY2FsX2FkZHJlc3MoQ1BV
UklTQ1ZTdGF0ZQo+ICplbnYsIGh3YWRkciAqcGh5c2ljYWwsCj4gwqDCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gVFJBTlNMQVRFX0ZBSUw7Cj4gwqDCoMKgwqAgfQo+IMKgCj4gK8KgwqDCoCAvKgo+ICvC
oMKgwqDCoCAqIHByaXYgc3BlYywgIlN2cGJtdCIgY2hhcHRlcjoKPiArwqDCoMKgwqAgKiAiRm9y
IGxlYWYgUFRFcywgc2V0dGluZyBiaXRzIDYyLTYxIHRvIHRoZSB2YWx1ZSAzIGlzIHJlc2VydmVk
Cj4gK8KgwqDCoMKgICogZm9yIGZ1dHVyZSBzdGFuZGFyZCB1c2UuIFVudGlsIHRoaXMgdmFsdWUg
aXMgZGVmaW5lZCBieSBhCj4gK8KgwqDCoMKgICogc3RhbmRhcmQgZXh0ZW5zaW9uLCB1c2luZyB0
aGlzIHJlc2VydmVkIHZhbHVlIGluIGEgbGVhZiBQVEUKPiArwqDCoMKgwqAgKiByYWlzZXMgYSBw
YWdlLWZhdWx0IGV4Y2VwdGlvbi4gIgo+ICvCoMKgwqDCoCAqCj4gK8KgwqDCoMKgICogUmFpc2Ug
YSBmYXVsdCBpZiA2Mi02MSAoaS5lLiBQVEVfUEJNVCkgYXJlIHNldC4KPiArwqDCoMKgwqAgKi8K
PiArwqDCoMKgIGlmICgocHRlICYgUFRFX1BCTVQpID09IFBURV9QQk1UKSB7Cj4gK8KgwqDCoMKg
wqDCoMKgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9SLCAiJXM6IFBCTVQgYml0cyA2MiBh
bmQgNjEgYXJlCj4gIgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgInJlc2VydmVkIGJ1dCBhcmUgc2V0IGluIGxlYWYgUFRFOiAiCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiYWRkcjogMHglIiBIV0FERFJfUFJJeCAiIHB0
ZTogMHgiCj4gVEFSR0VUX0ZNVF9seCAiXG4iLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgX19mdW5jX18sIHB0ZV9hZGRyLCBwdGUpOwo+ICvCoMKgwqDCoMKg
wqDCoCByZXR1cm4gVFJBTlNMQVRFX0ZBSUw7Cj4gK8KgwqDCoCB9Cj4gKwo+IMKgwqDCoMKgIHRh
cmdldF91bG9uZyByd3ggPSBwdGUgJiAoUFRFX1IgfCBQVEVfVyB8IFBURV9YKTsKPiDCoMKgwqDC
oCAvKiBDaGVjayBmb3IgcmVzZXJ2ZWQgY29tYmluYXRpb25zIG9mIFJXWCBmbGFncy4gKi8KPiDC
oMKgwqDCoCBzd2l0Y2ggKHJ3eCkgewo=

