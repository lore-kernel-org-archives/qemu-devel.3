Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA227CD5BD2
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 00:40:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS2JX-0005Bj-Qv; Tue, 26 May 2026 20:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6009f06ea=Alistair.Francis@wdc.com>)
 id 1wS2JT-0005BX-06; Tue, 26 May 2026 20:39:59 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6009f06ea=Alistair.Francis@wdc.com>)
 id 1wS2JP-00036x-NL; Tue, 26 May 2026 20:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1779842395; x=1811378395;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Y4fGQwccZdM4ka4Y/sExIb5AK0JbqQrM2IwZexwzKJY=;
 b=AELbzR8OkkNWtjyhHJPMuAisykM0QlMq5Pgnl5FnnWDudYeAwkMClzvr
 nJJcCR/NevRjrPLRC7pFZgr8OuMhqoT8JLRGlMmTF8FQ+d6cqUFpGd7FG
 gTUpP08f6bDR+upqUSxk2GY7kwUY/Saq5ViMjkUnoA+iU6umYgvmrGvJA
 XVf+avzS1eM1XY5UadGas6nLMLCaN2RbDOh+qfQYpBVyx002UEvXJnRBO
 WoAwHTDwG4dbA9pKxJV8BYBtKNA4q3o9gxPX1CU2hsLbEYmuP/aqErdpB
 t8jogQDJbUPMCI0fv5wgbx5+/qjgqQ4F8fUOX381O4oNz9SjfP6nZbfOc Q==;
X-CSE-ConnectionGUID: eH9KuA8MT8mj0d5OanZZRA==
X-CSE-MsgGUID: 0noh7dZhQ+6eqYhwkR65wQ==
X-IronPort-AV: E=Sophos;i="6.24,170,1774281600"; d="scan'208";a="148681632"
Received: from mail-eastus2azon11010031.outbound.protection.outlook.com (HELO
 BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.31])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 May 2026 08:39:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chwk++6MwX/zMUHkOK23Bo8a8SwJ+6SAn7O1rkdQXK4MsMlU/E3jF3DTqrATmSnIx+Ko8LKOyLvHVDB2Cj/RALw8FCi+At17U1NYINPD0GfyDa23IC0/yDLpNCk378e9l2JeItOGHXFia6fDOJVUSidLzwZJzbDhmhHOUV/+Q5wi8pXcO9sH3Cu3y29ArUrLYobWHUS+Tnlf272kBwIORvJyUp6eFehwYuPMFywKAcWInZYZ5PY2tSuqzMf8cfZ0Dr6MsAjVtWgsRvC+i0qk7+DEmqTcYTrIoXWbO8a61jjjE+lu4yeWXyn0wIS7dMcF2NXK6Uele8OBn7bsemLeig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4fGQwccZdM4ka4Y/sExIb5AK0JbqQrM2IwZexwzKJY=;
 b=j3oDAGlp5W7ZHTA7yIj74T7tbBi4UHbfxBgD8aCMC41f7Op3ewnGTieeGaHZLo5fciL5MIMJgfpxgz/nnn8D3I4XWqHM/nyPPJGjxlcWSPyMGYUr6aZWp5rSErEw5w5cqDi0X/sFZHwtrQIkFS2kU6vVmceuHsf6mXbZFfdgk23CuvyFuBO3ysEPwLoS/uH/m2LJ0RCmEopwNj04FUSriUpNqzENC+5v0h0ovW0Ehzb1QxzWsiRB5nExQ5BLat6A99eXOB9znRgRnWKOnvrvAb/v3ArERVetGapy85PmCdx7OsEtZaUvMH25wEeOOTdCkzHMq8JGH82iQ9V4lylLfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4fGQwccZdM4ka4Y/sExIb5AK0JbqQrM2IwZexwzKJY=;
 b=yuH8c9mqVxvTkZspXnQgt5qRL7rbuThGUykcFaXysaPZYsSJAOgCw/rvIj2ARL7/EdBeO6R9fSictKJynNoX841Z6/Zios4G8kPK3qIPeU2Tqt/Jbfo0SMm74xvfGBhjtdwU7bxjVR+X6X0yx+43Pxdop629cosj4am0AT7RZAo=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by IA3PR04MB9088.namprd04.prod.outlook.com (2603:10b6:208:525::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 00:39:50 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 00:39:50 +0000
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
Thread-Index: AQHc6KI6Uj/o7S7uaEe/E8JpueSeE7YhEWGA
Date: Wed, 27 May 2026 00:39:50 +0000
Message-ID: <05727483a9dd6955ebaf4bb1e057e29f3964f5f9.camel@wdc.com>
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
x-ms-office365-filtering-correlation-id: 53a1e3b0-3a6d-4d11-d445-08debb887605
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|10070799003|22082099003|18002099003|56012099006|38070700021|6133799003|11063799006;
x-microsoft-antispam-message-info: Sq9lfI472+ErmRWc/V1XQoe/aK3qm5WNfeL3SXAr2t/ejtHRx9AHkHVGbvhTYByZB0OWCTyL69btnamwEvvZYAq6KsfJcc1+jmwypRcGFguzuFPGEKteBvSJ2jVieeIPHgcdcbCmGK5BZYTW2a0Uij0IeBHc14ElgnvfS1rWOQKn1luIE/vhKwHhx14npA5Wbs3ZYPlV0stu8ptGw4XQEGRqoQKC6aFARbbOi8C+D1mMtTrabGo2qeLMBbYcQ+8tfTet1vbwNqEAswN15eeVqv5lo2fPD0kgL4y+GvSmNf2exzKp1E/y+Fv3zr81+ciUARzob+nOLdF83YUUVpaTe8Txp+Kjk26c/Pwu/uieCmCi7FzDNvZE/YQJD4TE8Tr7TWFKWq1cpeAXLKUp6VqypHePcmLB3geNuSg6jw4HSbcyWocabIIbIVi0QcKp3tCpyU1OHdJVgTgAlLVNyrebdoinznwLkKNXZtxgxoHLvV1SocReNos03l0/nHiPMNrF6qtZw6IOLO1kW1EvmUS4VlhL35X6AXrUFl3truwCCymcjOgZXIv3qefRWrf1bKWkVE4C50Lp0UwYyoMVANJzZwn/2kxGudXQHGq7FkZAjfe65E9rOMYYIRclcnY45uMa12t8GKdEzjpuL2nd0gsmU2xFdKXpsaoBYFeYGnXH42R18eHhN+DuxRaOl9Tr9r00a+aSvgV/uJLA/4RrHnw9ueriPAzK+ZQs1AvMEKWcWESgABlEvZ7X51iN5yzlaAa3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(10070799003)(22082099003)(18002099003)(56012099006)(38070700021)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RG1jWFNLMWZCMFJMVTNBUkdzQng0eW9NRFo1VUVvQ0xVZlRIQ0s3TzBTS0Uy?=
 =?utf-8?B?ZFFzcW9yZ3lOVEtzSmFRd2dHUWVOcnBvbklua1NZT2h0QlVZM1RMWGhWQ1Bz?=
 =?utf-8?B?a1ZHZWtWcEdVK3RJb215VHBWNWpxc2l2NldyaXBjTVlrUXgwcmJnNWNRVWNI?=
 =?utf-8?B?elZNak1CakdlYk1UWmFDU2l5N1pMWU5zUkdyUVdKdEVGdVJZc2Nwb3NUbzlt?=
 =?utf-8?B?bmdIRVNYMm1qUHF5T0FQb1g0WkZGWHJjazUwbEJGeDJuUi9WT1VSeFc0VVJI?=
 =?utf-8?B?RnJhWGVzWm85MEExRFhrL3N4cmt6Z3RmU3IxYURYVi9rWE5Vb0FNUHJSQUdM?=
 =?utf-8?B?d3hiM1ZSMGhvM1Y4Tm4xQnR1VitCZFVCcTgrTzF5eCt5VGZjaGVkbFFONkVD?=
 =?utf-8?B?Mk1yMnRnNEwyMnBjMW1yM2cvS3BVcXRmbm5BK2FoaFVLcnRQWlluTlRPdDdH?=
 =?utf-8?B?b1lKTDdJbThCYVFicUJ1T1FZSnU2WEE3TlR6ZkxSQnY0S290WjBTVjBGbW52?=
 =?utf-8?B?a1dsSmlqNzNyTGdndklRZUxYcmpNQ0pCdDJSbzdlOTVERDl1dTRsQkJhZnNk?=
 =?utf-8?B?b3NqMUxyWTd5Q2prK3NoekVWaW9BeTQ1VUxIUEVacGp2K21sdGIwR3NWN2VJ?=
 =?utf-8?B?TnB5T0pRREU2eXFvQ1ZuZ0tMVXJlbXRZaGtYUTdmZU5zcGVwMEhlTDV4WU9m?=
 =?utf-8?B?clErTHNMakNzSHVTZkc2dEZFTW1pRE1iSDh0TGgrQTRocTduSzlWangwdFk1?=
 =?utf-8?B?dDF1K0VmVjJ2T3Z4Z05SVURyWDA1OXBwWFgySWlnbGd3UGVCd01hbnJlYUVh?=
 =?utf-8?B?Y1NPVDFzejVBcDQrSkNlYXovVE5vVHVXTTQ0UjlLTHJCS0Q4YzdnUWRFOEk3?=
 =?utf-8?B?ejhpU2NVM2NXZlNUZWFmTE5CZkRMSVByUEozU25wS1BEZFFIV2Y3cytLTzFu?=
 =?utf-8?B?bkJFNVBQTTBVSHhaVVU2R3B1ajVrTERMa2QvUEpNVzZwakZXNzdiMTVxaVRo?=
 =?utf-8?B?OXNsdHJuVThoWlBVWFp5OHlscE45U3RJcFF3eU9EWFpWTlVmZnkwb0NKSTBL?=
 =?utf-8?B?Y3A0NVhDNDVuTXpFbWJQb3RaS0tqMmJoYXdsVUlZbHhNcktrZWMrMTYxQldy?=
 =?utf-8?B?Y0JqRHZZbk5yMjBFS3lUUmpkK00rM1YxZEpmWWkxU1dZdkpyQWdEUzRYOENY?=
 =?utf-8?B?VzJJcFY0K1NyaU54dHp0T3pRUGZxa0ZqNElRMnZVSWI0czIyQmNJQWN2ODg0?=
 =?utf-8?B?ZlRjbzVNVWlPNTNEcDdSOFkwd2ZYR1pvdGtIY00xYmRJbE9HNVp6Ui9vVWs0?=
 =?utf-8?B?VHlNR2xHd01OZ0FYUEtYL1VtOWpZWWlLbWZXa1BUU3BwRm05d3NkZGlzdXJP?=
 =?utf-8?B?clNZeGd3bUhPclVvTk9ZZmhRaWp6cUx1aGZwOUJwSzl2bjdLelZUTDFCMjc2?=
 =?utf-8?B?ZXBKdkpDaVJWUDdDMk5UQXZYb1lzNmNqbWlpYXBPWVFTdjZmSkRZakFMSWZB?=
 =?utf-8?B?U3hwcGpGSldzQTVHcW81QnZ4bXZFQ1pRTTR0RDhaT0VsdCtqRmk0NC9YbTB4?=
 =?utf-8?B?NHozMmN4V2FTd1FHVkhPdkZlK1Q3dGp1NmYxMmI2MHJ2N2R0YmJxbUFodlNU?=
 =?utf-8?B?SjI5c0QydVNqb3ZFNWJ6YlVUVE43NzNKaWV6VkRXamoxa0tzY0FzR2lucjNM?=
 =?utf-8?B?STg3Z1Z5dXBIaTV0SFp6bU9IR0ZzWVlUaVZsSGZ1RFFBOS9IM1JMelhnWW4z?=
 =?utf-8?B?cGNxb1dnYmFGQzdqZXFpUis2a0hYSURKNXFMelFxSjVUdGc4Tm5WUjNQeEpy?=
 =?utf-8?B?dTFTUlB4Y2xPN3JFL1hXeU8yclNmRklWbTBhb2FSVzdzWFhpUXJoUFREZTVx?=
 =?utf-8?B?UGNlTGt0aVV0Z3g0RmNtYWt1R0pRd3lHTWEwRmVNNXIzU0dZenhPcVhJNUIw?=
 =?utf-8?B?ZkFzTVNjSWNkTHNndCtYTG9HR2NudWJFeE4reE90b0NNUTd2bHh6NElMK2dl?=
 =?utf-8?B?VlJ0Ym9zcERQYmFCLzBCZ3VGYi9NZkNUenZGL0NVNG9qYmtLNTZHMzVSdnVM?=
 =?utf-8?B?SXRFV0x6dU1FOXM1ZlpPbCszRzdnTlBjQmRHZTRHd3V4dStSL2RrZkZyY0Fz?=
 =?utf-8?B?V0g5OWwxMHNwYVIrRC9lQnFVM2VZS0tBRWR4djV5WUhxTy9NZE05MTk2MkFE?=
 =?utf-8?B?TGZiY0JDQ2s2MUlISnRRaUFtSzhqYjUyYzdZdHBORUNydHZ0bEg5SEJGOWRK?=
 =?utf-8?B?bWRoV0NmeXBITVdWSEkveWUrRTBlcWoxVDM1SHlUWG9WWDBSVDIyajBDMWd3?=
 =?utf-8?B?U0toY21ubXVIVS9jZFlidnRUZkFacUtQM2w3OW9FQnEzelk1NGdvdHBGN1lt?=
 =?utf-8?Q?imgzE335pUMcRB3JA9aRd4WyEMF0RWV+Q9QweikTfolYH?=
x-ms-exchange-antispam-messagedata-1: CpwF/SM+TV0KB9qt/Vc/jI09U+5clperAQM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4131188B442A9D46B1135F0F7CD3CDBF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GFLuiVnhppmqOz2AUJmXZjg90Wqf+DPC1cP4CdCWKu5CKXWguVCgH1VLehHUbIp4fvJ4pnrJCUpvGLM0A4vJVB5bgA7HC1pEmQ9rDnitRxAX3IMf5OyPA4abg7pl+3Kbks+DE9JHl9KQDeIJNapN6d7AN8rm2nC6pKzyx/VGAP8D75WIexQlJuMCkr62pNQKwgA+6g198fVkJ3TJxfs9Ws7sE/IFox8XiH2iKVbm//BPZ1e8Na/uW1ECTdKkFyw0XaWBWRu+esX3ny4nPtCl7shPsgyLgbEigRu6f5sTL64CNJEadIQIs33iyMZc76qSBTgcyV1KkkMcMsQwqmMy+A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /l3YtGcr9aXrTRm/07+hqhJzImJSgGd/nMorGzGc81X3FaJ9meUmatFuPQcYHell+WrChq77mldfPqFRBVbo+PLlCNbhHvzpYQ0YK1powkZlM935GQQ3ZILbzbq12NKwe9+p9a8kV//WPhi07YBQdGSxWP4tszv3UzziXwlYFEc9W2j7wphUXRnT1FjLIryr8p5oXeiaIjcVsorNhcz2yqXqgxuvzfgZWiKJ6roVNb8IOff/oDUNDq1JYpVO0ogmPI2hZ5hjCMLgjIPgAVX2zxdTyloicxmEuPtmnQoUKbgLEYAZVHwwZoYAJ4MLgcYAzsa80BQ7snrz2A30j7aojOKzlpdI9bKw9pYwjEdJbnjsRdExffhrHOHo+XuKhauwvO5ix1TlF7zCeKM2XLQWOVhgmUpmjsK9HUcuA7FeHQWz/dqSjdVEXNrHLMj9sPHNjXOoERX+Az0p6sxrS9QS6kicgIqpCC12jMTiyD90j9W4TM2pFa0DZZA4ARpnIp4bg7GEO+5YftUrNiiVEk6YfsgMtPs1hDTcUmbZ0X2FN7+l5OJO4RB9YqJl6x9c2r5NfRd3aZmphqSDTGcXnWSQpRE36J2Zken1d3qIRd3oj7uKWPsHw9o3L2GtaDFSZ+iA
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a1e3b0-3a6d-4d11-d445-08debb887605
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 00:39:50.2797 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O3AnXlFCFE1C4pMqnpiwnodZFx5/BTrNrM7BXnmw1RAnmXoV8apGEi9NZ2Rmocx1IKIiw8V//177zwW3Z4lLw4XFWsbNNld61Nb+dzrUcBc=
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
QmFyYm96YQ0KPiA8ZGFuaWVsLmJhcmJvemFAb3NzLnF1YWxjb21tLmNvbT4NCg0KVGhhbmtzIQ0K
DQpBcHBsaWVkIHRvIHJpc2N2LXRvLWFwcGx5Lm5leHQNCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4g
wqB0YXJnZXQvcmlzY3YvaW5zbl90cmFucy90cmFuc19ydnppY2JvLmMuaW5jIHwgOCArKysrKysr
Kw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQg
YS90YXJnZXQvcmlzY3YvaW5zbl90cmFucy90cmFuc19ydnppY2JvLmMuaW5jDQo+IGIvdGFyZ2V0
L3Jpc2N2L2luc25fdHJhbnMvdHJhbnNfcnZ6aWNiby5jLmluYw0KPiBpbmRleCAxNTcxMWMzMTQw
Li4wOTZmN2RkZTI3IDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3YvaW5zbl90cmFucy90cmFu
c19ydnppY2JvLmMuaW5jDQo+ICsrKyBiL3RhcmdldC9yaXNjdi9pbnNuX3RyYW5zL3RyYW5zX3J2
emljYm8uYy5pbmMNCj4gQEAgLTMzLDYgKzMzLDggQEAgc3RhdGljIGJvb2wgdHJhbnNfY2JvX2Ns
ZWFuKERpc2FzQ29udGV4dCAqY3R4LA0KPiBhcmdfY2JvX2NsZWFuICphKQ0KPiDCoMKgwqDCoCBS
RVFVSVJFX1pJQ0JPTShjdHgpOw0KPiDCoMKgwqDCoCBUQ0d2IHNyYyA9IGdldF9hZGRyZXNzKGN0
eCwgYS0+cnMxLCAwKTsNCj4gwqANCj4gK8KgwqDCoCAvKiBUaGUgaGVscGVyIG1heSByYWlzZSBJ
TExFR0FMX0lOU04gLS0gcmVjb3JkIGJpbnYgZm9yIHVud2luZC4NCj4gKi8NCj4gK8KgwqDCoCBk
ZWNvZGVfc2F2ZV9vcGMoY3R4LCAwKTsNCj4gwqDCoMKgwqAgZ2VuX2hlbHBlcl9jYm9fY2xlYW5f
Zmx1c2godGNnX2Vudiwgc3JjKTsNCj4gwqDCoMKgwqAgcmV0dXJuIHRydWU7DQo+IMKgfQ0KPiBA
QCAtNDIsNiArNDQsOCBAQCBzdGF0aWMgYm9vbCB0cmFuc19jYm9fZmx1c2goRGlzYXNDb250ZXh0
ICpjdHgsDQo+IGFyZ19jYm9fZmx1c2ggKmEpDQo+IMKgwqDCoMKgIFJFUVVJUkVfWklDQk9NKGN0
eCk7DQo+IMKgwqDCoMKgIFRDR3Ygc3JjID0gZ2V0X2FkZHJlc3MoY3R4LCBhLT5yczEsIDApOw0K
PiDCoA0KPiArwqDCoMKgIC8qIFRoZSBoZWxwZXIgbWF5IHJhaXNlIElMTEVHQUxfSU5TTiAtLSBy
ZWNvcmQgYmludiBmb3IgdW53aW5kLg0KPiAqLw0KPiArwqDCoMKgIGRlY29kZV9zYXZlX29wYyhj
dHgsIDApOw0KPiDCoMKgwqDCoCBnZW5faGVscGVyX2Nib19jbGVhbl9mbHVzaCh0Y2dfZW52LCBz
cmMpOw0KPiDCoMKgwqDCoCByZXR1cm4gdHJ1ZTsNCj4gwqB9DQo+IEBAIC01MSw2ICs1NSw4IEBA
IHN0YXRpYyBib29sIHRyYW5zX2Nib19pbnZhbChEaXNhc0NvbnRleHQgKmN0eCwNCj4gYXJnX2Ni
b19pbnZhbCAqYSkNCj4gwqDCoMKgwqAgUkVRVUlSRV9aSUNCT00oY3R4KTsNCj4gwqDCoMKgwqAg
VENHdiBzcmMgPSBnZXRfYWRkcmVzcyhjdHgsIGEtPnJzMSwgMCk7DQo+IMKgDQo+ICvCoMKgwqAg
LyogVGhlIGhlbHBlciBtYXkgcmFpc2UgSUxMRUdBTF9JTlNOIC0tIHJlY29yZCBiaW52IGZvciB1
bndpbmQuDQo+ICovDQo+ICvCoMKgwqAgZGVjb2RlX3NhdmVfb3BjKGN0eCwgMCk7DQo+IMKgwqDC
oMKgIGdlbl9oZWxwZXJfY2JvX2ludmFsKHRjZ19lbnYsIHNyYyk7DQo+IMKgwqDCoMKgIHJldHVy
biB0cnVlOw0KPiDCoH0NCj4gQEAgLTYwLDYgKzY2LDggQEAgc3RhdGljIGJvb2wgdHJhbnNfY2Jv
X3plcm8oRGlzYXNDb250ZXh0ICpjdHgsDQo+IGFyZ19jYm9femVybyAqYSkNCj4gwqDCoMKgwqAg
UkVRVUlSRV9aSUNCT1ooY3R4KTsNCj4gwqDCoMKgwqAgVENHdiBzcmMgPSBnZXRfYWRkcmVzcyhj
dHgsIGEtPnJzMSwgMCk7DQo+IMKgDQo+ICvCoMKgwqAgLyogVGhlIGhlbHBlciBtYXkgcmFpc2Ug
SUxMRUdBTF9JTlNOIC0tIHJlY29yZCBiaW52IGZvciB1bndpbmQuDQo+ICovDQo+ICvCoMKgwqAg
ZGVjb2RlX3NhdmVfb3BjKGN0eCwgMCk7DQo+IMKgwqDCoMKgIGdlbl9oZWxwZXJfY2JvX3plcm8o
dGNnX2Vudiwgc3JjKTsNCj4gwqDCoMKgwqAgcmV0dXJuIHRydWU7DQo+IMKgfQ0K

