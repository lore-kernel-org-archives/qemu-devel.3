Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A439CD5BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 23:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS1eC-0004wr-PI; Tue, 26 May 2026 19:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=599a94ef2=Alistair.Francis@wdc.com>)
 id 1wS1eA-0004vx-Qc; Tue, 26 May 2026 19:57:18 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=599a94ef2=Alistair.Francis@wdc.com>)
 id 1wS1e8-000134-V3; Tue, 26 May 2026 19:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1779839836; x=1811375836;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=7Cv+g4U98P4F77ObknHYyxzRZEcLggfz4RAa2le1g8c=;
 b=pJpGLCnu88XF1NzljhqijDihpIG8rrKuN/su1L4GTIdwj+gDER9A/bis
 sAoiRlOJLRTNgye4VaH9wSpVB2mx5dOQjIp8gZ/n6khx2SgcX8bp1XoVE
 shf60rOl4u0jbl0F49trijeP3/G+m4yN3kNx0ve0vtMlZ1Nzfk6i+B3Q/
 F2OwJZ7WckkTl5lWS7FiLVOS2UDENQwjDWv7g59nmxqhy3faDvhJGet+r
 ooZ8sLVkFxPVhlbUGF8cEEFbCty/7Qxa8lycm0mqOvyWK1C8nBPWH48Uc
 bbbJ+kxCQmYKHDQ0jPRfeJR9z5kyeF2kSzIsoagaysKlz6T/hcP207f4l g==;
X-CSE-ConnectionGUID: uY2VemnzQ5y0U2/5aPzHzw==
X-CSE-MsgGUID: a46XwY5aTCirSfzRhnV86Q==
X-IronPort-AV: E=Sophos;i="6.24,170,1774281600"; d="scan'208";a="148679001"
Received: from mail-westus2azon11010039.outbound.protection.outlook.com (HELO
 CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.39])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 May 2026 07:57:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0lpKMpCq9SQpeK1veip+x/gl3iC3/u40H9z+iY4UMNQGO18kHuzIy1uq+6uMAEiCghhncLNJX8nAmjyevHJpseFG8cTzH7zzBaWjkKV1Jxm4MByrX9xciPkyhmUA14j7ZPDvNngCXBY9PenlX5TDzwNu6zh3eCFybNKQZm45XcdITrKW1W7H4PnxdCALIlkTWQZF+7cplw1ei25Ny3ok9tRBbhIJlpMuGkktALjDvRLt1MaCLx6JHav5eDPofeu3AqEaDmPnlzI6A5P78saHEgM2dLkAGiqSbZnhjpBQ/KIZyXXlJ/gAp6HO70Dd2IqVjMhDe/R9cUmINPl5wgT1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Cv+g4U98P4F77ObknHYyxzRZEcLggfz4RAa2le1g8c=;
 b=esHNvFewfxlSWg8qHKZ+LFppSGlq/7H3O+s5NbHfr4OrKmHfh227JjR7urKhHoJDLkpAr1S/Cv+SFZYe8Oj3W2r/E9XK/PX6gOQ6rzZvTgEWwwm5b2UeW53d6T/NeacDSNksrUu8AtfEA2oBbpYXs4ACJ09kxqOUWD1hcSGbs3BsHKorIR06Eiydu3vahTRxpEV7a5vEvnRJm85LORId6poLd9JUsF0QmB2roxnlaOLeopxrWTFOw4kBkBkSkZ/VFwGk+Xmb0iVUaw43gK7gsrPGVCBJ20+w/6ime46r9of/Ua3kkfBGJqBIC5Vj46dFvK4v5Hjx+t8PoWzLYY3Sew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Cv+g4U98P4F77ObknHYyxzRZEcLggfz4RAa2le1g8c=;
 b=gBX8SB/g4kSl4o9QmxjeofkkGlqsdltWlKXebixlxFxIyZpakbKpRh7QaXZATuJ/c6Vqj0Nukrx40x1iLIkBRrghy92H2nm2EIRwd5jF1MNCstdyLlLalBtk9FHacFbuOFqZrqQlIXSxCTczticCXqSrjibyfEyHDVF0b/kf6+g=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by DM8PR04MB7959.namprd04.prod.outlook.com (2603:10b6:8:d::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.12; Tue, 26 May 2026 23:57:11 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%4]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 23:57:10 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "mjt@tls.msk.ru" <mjt@tls.msk.ru>, "vulab@iscas.ac.cn"
 <vulab@iscas.ac.cn>, "palmer@dabbelt.com" <palmer@dabbelt.com>
CC: "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v1] target/riscv: Add mseccfg to VMStateDescription
Thread-Topic: [PATCH v1] target/riscv: Add mseccfg to VMStateDescription
Thread-Index: AQHc4UR/iJcOx3F+3UeVSJs2SLCoXrYf/28AgAEUwYA=
Date: Tue, 26 May 2026 23:57:10 +0000
Message-ID: <6e42ecc1026a057e07e73386463bd57e1467a46f.camel@wdc.com>
References: <20260511124828.3210477-1-vulab@iscas.ac.cn>
 <bcc0aaa1-8d1c-4f52-a681-85bc903c8d66@tls.msk.ru>
In-Reply-To: <bcc0aaa1-8d1c-4f52-a681-85bc903c8d66@tls.msk.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.1 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|DM8PR04MB7959:EE_
x-ms-office365-filtering-correlation-id: 14ad7106-a852-4d2a-e7a6-08debb828069
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|10070799003|376014|7416014|38070700021|11063799006|4143699003|3023799007|18002099003|22082099003|6133799003|56012099006;
x-microsoft-antispam-message-info: MVRKxTiHVp0vq1kz78t0JMo+3ESmmRBa5DxB2siradYNlb6MsWPjhdNpsrBs8fXCuIt3iCzqCROk415HVm1ERc5nqe5AhAX8jP1y2HmaC637zCl2xuO6CjT8/3tJvRT6MuXgB0xjAwc94KBaJHZemYZPOg5zXoTkix+9H60ItikiQ0FUGCONlGRAayBVlYmhZsWM7KbN3DqHONA++K6ROlEWc2BaKn8cFtVwRFEYuxXKBVoS1E/slPP+/ccAIQT4F7bEef/xF8R+UWHEjqRvW4ZkKMZWk4LWV/q0GCVX5PxQ55aORTD7FNSNXlj8zHs2WwfDuKOcnc6SNXLI9Tzao/V3RRdtB7PeUYxVBGmyNIEBuLzp2L1Hpkk5BjGJP16UWZXkepWsg5bKG5d/ZQEanKljYVRXX1SdqCRQTbUDbDNUsEwXSSraxBGsGxSLANKD1depntKgr451O4dlitlJ8ZsZeRPI4DyKEr8quFXfpGSUIJEU+Ilr2qeimmD+kSrPsFcYS07O/jcOPj43gGEJqycGMSX0LFr2p7GTO7LmFlRA52i3S2sLCd36KAd9rG4+nLP/hgJxqat3/75znbdLTuf4OXc6iGNVfMYC9wz0BCqlStxBckPotGVEi9F0bbfFPikL7Gpu2h1a9HAA8JAS9MRhc9/T/aBd/rjjYLRbB3UyXIrZCpRmASsPatxBupI/JfongL8J+8BYjmZRITqFhOOWrTxWB5p1BdKwjPbROM5FUZqbxQkrQhtDSmQCkZHK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(10070799003)(376014)(7416014)(38070700021)(11063799006)(4143699003)(3023799007)(18002099003)(22082099003)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aG1yQXEyVDFlb3JKUnpFcEN3b2J3ZXpNL1pJWm56TWFWRE9UemZMUXVaUVc3?=
 =?utf-8?B?UFJZQ1JrVUZzQzBQL3JiOTJlRnFrS2RuYlExM1NCZjBjUmV4MFRYbDlmRWlQ?=
 =?utf-8?B?VUVtS0t2bllLVktDU01hZWVFNzY0S0FVcmxoaU54YmF2MnlaV1F2VXlUMVB6?=
 =?utf-8?B?Z281TklyK3Q3ZGFnV1RWYU1oWHZYaVRlRE1sNUdGVzhCejBqSm1td1FOSUxH?=
 =?utf-8?B?QjR6OXh6N1RONFc3VFVoT3dBd09vNnNtUFg0bGdsWTlEbHBEelh2T0diMzVi?=
 =?utf-8?B?UzVEOWR1d0ZkaDl0c1J3djU3ZXFlZWp2RnlseDBOK2JTb3lxZHM0VHFLODJl?=
 =?utf-8?B?L0w5TWJtcGFyVktkZExkUFJBN2JvOXQvbmN4MGF0OUtIcUgxYzNoMmdpWWw3?=
 =?utf-8?B?MkFRLzlKNHE0NzIxejJVeU1YSlJrbzZNZCsrT0xjaks2ZnZTVFJKakt2ZlIw?=
 =?utf-8?B?dDhhVWQ2M29DMG9OcWFtQlhtbmZESXpOS3F2YjFJK1dZRXR2NVgyQUhWUUNu?=
 =?utf-8?B?MG5wMHpzSzlZMlFTZnNLaURuQjREL1NRSlgwaWtlNGFvTVk4eThTc1RTTjRo?=
 =?utf-8?B?MTA1L1BHcG95S1oyV2VESTlpb2xZS1VHRDgvUkU0Z2VYNkx4WE81Tyt5bnJK?=
 =?utf-8?B?VVVBY3Vqb1M2eUVkOVBXZGE5QXBQOG8rdHZwY1diWFBVYTV1Z1VodHEreC9t?=
 =?utf-8?B?aTBIeWxZMUdGZWRkK2syb0tEdjdZL0h0RE4wRnkzMUQ0Z1IySXl0YUxVZTR6?=
 =?utf-8?B?aFhodjk5TkYvK042RDJSc2Nobi9lTEpGVDdWSkV2QWlRdCt1MGI3RE1iWVFQ?=
 =?utf-8?B?QmhFR3JuYk9pL1EvQWJJZU5FNXhNWVdibm5xdjgxWFpwcmFaZk85enpFL3kr?=
 =?utf-8?B?SFgydkg4Zys3MlpOMjdsUEF6U3dNa1cvWWRHVEFranpQeVFyVmkvSS9oSk9M?=
 =?utf-8?B?MTExRk1xM3RHUjZGVm1pRldld0NVWkNYcTZnWGliejdtYWhBQkJ1VHR6T0NG?=
 =?utf-8?B?VUxId1BhRlY5YTBpaURaSk5WN0dIRW1wYlpiQTlySCtiLzJiczhSWXJ2dGVN?=
 =?utf-8?B?Wk1WQXkyTFFGNEZuaEk3U1BQZVJWNHdEekZ1MzVFcHl2dGcrcWJWcTJCWW5s?=
 =?utf-8?B?Z21IRXFydVlnS0gremJNQStkRkJXUXFWU0RuRzVZZkFVVytQVzdpbFV0T1lq?=
 =?utf-8?B?TnFSVThQVjVpVUU5RVAyUTF2SHNySFZDR3ZYeEZLcVpoeTJrM0pFV2o3M25Y?=
 =?utf-8?B?U2c3emNDZm9QMXZwMDI3Tmo5eXZPOGY4YmVIZEh2d3EwNnZ2dUZTcmRzVFFp?=
 =?utf-8?B?U3F1MzNVK1FoNkovbHVyVzJLWVJ4YlBBaC9NS2JReHU3OW1ITmxuQjV5dncr?=
 =?utf-8?B?eUpvQW1YRGxvK0Z2U0VvWFduTWlmZFBXTzNZR0dpcS92T3dZOCt1Uk9uQ0t6?=
 =?utf-8?B?YkVlc2owYVZKVmFtUjJNcnluNndNTHplOHVhK2xoem9WVG50RlFvR2JKa2Mr?=
 =?utf-8?B?UGp1K3pnM250K3pHbE1teFZ2NFRwejJ0RTlJQ3BsL0swSDg0WW1vK2JtZkY3?=
 =?utf-8?B?YVdhTDdITitucExjWitsSFNlRERjblN6WkZXWnVuVnBST1JHVk9qekdrZnRT?=
 =?utf-8?B?MEE1S2NweHhrbUtOWWxzVEovN1VIYlZjRVFzcXN1RUtkb00rZWxpblNUaWlM?=
 =?utf-8?B?NzNKWlk4L1NYblFsa1VFakI0ckFZRDBQMHl2bElJRDdwUmdsYWd4Sm5aVUtr?=
 =?utf-8?B?UEUxTHZSeDM3cW40RHRQN1cyV0pIUTNNRVJCRzFUUDBObW9LSnBqWjV6eFZv?=
 =?utf-8?B?QVlUYnE4S3pnbkg2YkVKN3VvSjlod0J4UXlTcVh1Zi9iRWpEeGE1UXY4TjFJ?=
 =?utf-8?B?eVE4cHdoRXZrRkE5NC9VZ1YxbGtFTU1oLzBBSG5ieXorUkptTmkyV1JVT2da?=
 =?utf-8?B?bnVCT2I0VDVibUVDZlBlMCtFenNGR3RVcktGR0x3NFFWQXVOclRMY2RQUGha?=
 =?utf-8?B?T2dVY2dvTVErNk9RNm1jeEcwcC9ZNGx4c1VXOWQ0SHpsbDJqUkk3dVNOeTV5?=
 =?utf-8?B?cDVGYUtHT1JoK0ZBVWErQmZRdVdteVZQVXBlOUlUZlUzUTNpT1Y5aXNUc05u?=
 =?utf-8?B?TkNOQlc0YlZPbVRhbnpwZ0JRK1NmMVcrUjRFdmc1ZnVucEEzVFVvYklyUkxv?=
 =?utf-8?B?dERrUlRNbVZPS1RoK2d5ZUM2dFJubGNsa0FaNUJMSFFQWmdSNW5HS2NCSUlr?=
 =?utf-8?B?N1hBbDJtVnlhaVdKRmU2VXlKcUlOT3dVbnRiZ2w5elIvQmdhTGxlMjlUM1lt?=
 =?utf-8?B?YUFoNm5ndko5eG12dlNVRE9vTFhSYTdUNFRZdGVrSzRNZld4azhtWVpPTjFv?=
 =?utf-8?Q?t7s0fnB0jDXKsvNMRVgTFtr/XJyslfzcbwRQYDpVR86/z?=
x-ms-exchange-antispam-messagedata-1: zmr6CIbZpk3QoVrdpyOpuI0g7oAsNinn+rA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9A27CB3108AE048A71A16A55A1522B2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: b4hBuxtFYzXipbDVQ1StVqBsVmw+bQSlaRgYjmn29UL6L3zEnNEDIbKFXN1VhfncqFrfuiNqnS2h8Bj94W7pCbLzlyN+T2Q1Jic/wY5v2+bSUbrzFHcr8H0t+71IsO+M+fWy6wDYidB+90UfMHOLU/FxTA9c+Gu/b9tIHDjwS26FdUN96zPF9qHTFoX0S6wcK1tou0M8juY1zAHO18H+qgLb5GODr4M+ucz6UxYwnSd4WQE7c09EZI3zHL1OUnxGljoNksO+4VjwPYXPhmaNue5U+HDxn0w20/rcrVSEHclZr/6dlTy9ya1Gpq3rZUl6HPhFbk8W+QKqE4ek2Nc5yg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kwr2gQulr796N6QHR/+dSy8fjdkFkjwvm6ePfWBAeZLn9Cp0XiE4WZvcPCyszyAjRdBnzYa2DlAS2gT4c1AZBEzFqePPZFcSJ+NWnNfTET+AUaBsVSbHQvAwD0/agcXzU4Xslte8TVCCRUxHd0K+9SsaOfrraY5t5g1quD6xIcH2S7BbHbcOkCnvhELsS9NHQgcOOmPJBABZ3lYoGdcs8prSzqg77sVR83ChSB04PqCnsDuKt8T3yS6sNWbn1ZwPEjI/uIYojfOjYj4B41y5T8XM61sm6YVRJh8D5Fyf3qdRFlnga642MAYXOdRCk10sLnRICDYrWlmvvpwiBRA9XApRiLQYFdVEfSVcOd5H6VUGTa56pzLnw+/T7l5By/eHnJi+GQftOiAD27Wsdv2vpBJbfDnYMs/VjSZW41xZXERcMp7fQRc+RR2cRKTeS00kXpW2OB0eQcdzst1jVVKw57fyV4Ku3XtA75W/VYKNspi7ikgtlup3Ifn4tQiv1v8J0nu80sOoV/Eour9/CmwXOaBPBlI+9l2wGkI8Df42S4r9Yz8Rdj6Im1mu5ElDvtpPzKSGjeEtOr//2GEdK3sSGKUI0HaUsSU/l5EGaY6GtsIdaiiNUfxBmAFcnaCSfR3G
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ad7106-a852-4d2a-e7a6-08debb828069
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 23:57:10.7641 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kyE6qDD5Cx0Nx+y+zMyHKNHR8umfI/InxVVtP00j3b6PlJr+wCcDo4I/woqJel2yrTObHfrpwYK+TSxBv5wTZlXHCiaWEBWYSptQOVNuHVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7959
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=599a94ef2=Alistair.Francis@wdc.com;
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

T24gVHVlLCAyMDI2LTA1LTI2IGF0IDEwOjI2ICswMzAwLCBNaWNoYWVsIFRva2FyZXYgd3JvdGU6
DQo+IE9uIDExLjA1LjIwMjYgMTU6NDgsIFppc2h1biBZaSB3cm90ZToNCj4gPiBDdXJyZW50bHks
IHRoZSBNYWNoaW5lIFNlY3VyaXR5IENvbmZpZ3VyYXRpb24gUmVnaXN0ZXIgKG1zZWNjZmcpDQo+
ID4gd2FzDQo+ID4gbWlzc2luZyBmcm9tIHRoZSBsaXZlIG1pZ3JhdGlvbiBzdGF0ZS4gVGhpcyBv
bWlzc2lvbiBjYXVzZXMgdGhlDQo+ID4gcmVnaXN0ZXINCj4gPiB0byBiZSByZXNldCB0byB6ZXJv
IG9uIHRoZSBkZXN0aW5hdGlvbiBob3N0IGFmdGVyIG1pZ3JhdGlvbi4NCj4gPiANCj4gPiBGaXhl
ZCBieSBhZGRpbmcgdm1zdGF0ZV9tc2VjY2ZnIHN1YnNlY3Rpb24NCj4gPiANCj4gPiBUaGlzIHZ1
bG5lcmFiaWxpdHkgd2FzIGRpc2NvdmVyZWQgYW5kIHJlcG9ydGVkIGJ5IFNwZWNIdW50ZXIsIGFu
DQo+ID4gQUktZHJpdmVuIGFyY2hpdGVjdHVyZSBzcGVjaWZpY2F0aW9uIGFuYWx5c2lzIHRvb2wu
DQo+ID4gDQo+ID4gTGluazoNCj4gPiBodHRwczovL2dpdGh1Yi5jb20veWl6aXNodW4vcnYtaXNh
LXNlYy9ibG9iL2EyMmU0NDU5Y2QwMjZhZTk3MDc5MWRmYmQ5Y2ZlNWQxMTBmYmQ0NmIvb3V0cHV0
L3Jpc2N2LWlzYS1tYW51YWwvcHItMTg3OS9xZW11LnR4dCNMMTIxDQo+ID4gU2lnbmVkLW9mZi1i
eTogWmlzaHVuIFlpIDx2dWxhYkBpc2Nhcy5hYy5jbj4NCj4gDQo+IFRoaXMgY2hhbmdlIGhhcyBi
ZWVuIG5vbWluYXRlZCBmb3IgaW5jbHVzaW9uIGludG8gcHJldmlvdXMgc3RhYmxlDQo+IHJlbGVh
c2VzIGJ5IEFsaXN0YXIuwqAgSG93ZXZlciBJJ3ZlIGEgY29uY2VybiBoZXJlOiBjYW4gd2UgYWRk
IG5ldw0KPiBmaWVsZHMgdG8gb2xkZXIgbWFjaGluZSBkZXNjcmlwdGlvbnMgdGhpcyB3YXksIGFu
ZCBzdGF5IG1pZ3JhdGFibGU/DQoNCkkgd2FzIHVuZGVyIHRoZSBpbXByZXNzaW9uIHRoYXQgd2Ug
Y291bGQsIGJ1dCBhcyBJIHdyaXRlIHRoaXMgSSBzdGFydA0KdG8gdGhpbmsgdGhhdCBubyB3ZSBj
YW4ndC4NCg0KV2UgZG9uJ3QgaGF2ZSB0byBiYWNrcG9ydCB0aGlzIHRoZW4NCg0KPiANCj4gSSB1
bmRlcnN0YW5kIHJpc2N2IG1hY2hpbmUgaXMgbm90IHZlcnNpb25lZC7CoCBIb3cgZG9lcyBtaWdy
YXRpb24gd29yaw0KPiBpbiB0aGUgZmlyc3QgcGxhY2U/DQoNCkFzIGluIHRoZSB2aXJ0IG1hY2hp
bmUgaXNuJ3QgdmVyc2lvbmVkPyBvciBgdm1zdGF0ZV9yaXNjdl9jcHVgIGlzbid0DQp2ZXJzaW9u
ZWQ/DQoNCkFsaXN0YWlyDQoNCj4gDQo+IFRoYW5rcywNCj4gDQo+IC9tanQNCj4gDQo+IA0K

