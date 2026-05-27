Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6DACD5BD2
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 01:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS2ez-0001z7-SF; Tue, 26 May 2026 21:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6009f06ea=Alistair.Francis@wdc.com>)
 id 1wS2ey-0001yu-QV; Tue, 26 May 2026 21:02:12 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6009f06ea=Alistair.Francis@wdc.com>)
 id 1wS2ew-00076x-CV; Tue, 26 May 2026 21:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1779843731; x=1811379731;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=+SgVTIp8Xu+WL2OXDDbtXqjiwYcCGI0pAPV0nHBqyl4=;
 b=TbPxGEjDlDC0uemKH5eyZEw/rG1m1BJ5EC9qhBhly/l+i+KMCKIKULrZ
 pe6WkfV7Z1AtM30aYY5JR48FP0glRNgKvp/U0JsWBEKcJnxRvgZ4q8vsw
 G62Z32NPnKOnyevRrabRijDZbF72Armb3VprCPb0csDh8E4glryigmSYa
 2Fm722jqhw6SewZnk9V/5UCDJDssa7zvhK65raheUVfTnTh9R/64xNjdf
 Huj+taeNTa3pCEwEXaKuIxMYrEIO1htAnaUhX/j0D9Vn2CFlmSROFjSZP
 eFG9pO0qEdrctNiJyTEE65KFcwKZ8s41BML3dQNhypxm5WB7WAnWeh//2 w==;
X-CSE-ConnectionGUID: jFc2T7qiQeatIkQda73F0w==
X-CSE-MsgGUID: woSoCXC/QGG8boVCstQ9UQ==
X-IronPort-AV: E=Sophos;i="6.24,170,1774281600"; d="scan'208";a="147845190"
Received: from mail-eastus2azon11011054.outbound.protection.outlook.com (HELO
 BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.54])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 May 2026 09:02:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCAWUYRyBHkDO48ttuv2QN2rBFO+pfXhan1OFNcDudHjwAEBxXuFNL6TxWTAft6U4nMfb2umUPue+PN54yXL0oGV6LCfTD4+SvCxekg7TTP4i97AsvvUtpY8Ain2PBKqpAuZZZ1O1b94PV4zA3vr46fBuv6p6g5E665hhkBsOeXuIntqLmSxms9+m4tB28G4bZsHxtKgj2eww0fLvJK9lH4Y+Tk3/Nrq4/4PWCLHC3QEx9K7xVpF+wq4PbVc3lqGMwbiy+aLuFtV3Z812F4EMmNsrv018FiLYciKKRRDzKrHWA3Bwe5+phXc/nTTId2irXalVY/6EDOqSZoJLcPhlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SgVTIp8Xu+WL2OXDDbtXqjiwYcCGI0pAPV0nHBqyl4=;
 b=B31w6jks9sDJXdABJnOlkZ+2OhzPoNYL82NGTfC3UM7PgVM7yxQvCQoGpJwycAkOSsc+5zFH1s46dnUejbpEysoS1wS+IXrpmtpQh9idL/+s4jRm9w+wGF6gSD5rXE2Mhp0GmMZYiW4/oO8q/l+v8jeVNSCrhiipowjPG2n6cnSf+IWATBqCswLjuanxwxa9ZaOjMgslqYwpgJsOLTvVtOdCx7kPCKOFcxuf5h7+PLk0yX+hF70i35EfUQFR8zRxBMok+Z8xmotIx3lKsdlZQLeWPk/jpniSxrvd/tElzWqm1x3GU5b4kyeQXhehumpqI5cXnps4sccT8Tb1TC212A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SgVTIp8Xu+WL2OXDDbtXqjiwYcCGI0pAPV0nHBqyl4=;
 b=z4Vl3EmVWrixLaayArYQLT8gfh6sJjPlBGRPc7WrLXQpy5rKSfXmsudjeZPD7wJ5YRTCYyuD6pEBzGDjfz8DJqR5gHdWfJDFcRIUMqROvn+qQsw8bNEyYc0wfD6jjSQB7WeRYEqzvAS85L8mM0oSflh+UZ8jrDzGr6U5TuUAjAs=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by BN0PR04MB8173.namprd04.prod.outlook.com (2603:10b6:408:15c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 01:02:05 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 01:02:05 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "stephensportia@gmail.com" <stephensportia@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "portias@oss.tenstorrent.com"
 <portias@oss.tenstorrent.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>
Subject: Re: [PATCH] target/riscv: Add support for a custom CPU arch state
Thread-Topic: [PATCH] target/riscv: Add support for a custom CPU arch state
Thread-Index: AQHc7Pjt66Zi120dZUWVzIeW4MLkp7YhDusA
Date: Wed, 27 May 2026 01:02:05 +0000
Message-ID: <404368207f5bfd0d65b38bbc905242677f0128fa.camel@wdc.com>
References: <20260526101732.54144-1-stephensportia@gmail.com>
In-Reply-To: <20260526101732.54144-1-stephensportia@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.1 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|BN0PR04MB8173:EE_
x-ms-office365-filtering-correlation-id: 07a15b4c-2445-42d0-2008-08debb8b91a5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|10070799003|366016|22082099003|18002099003|38070700021|6133799003|56012099006|11063799006;
x-microsoft-antispam-message-info: pY3hqz6QvL2DSunqWzZkcA/687M81EOp+SHqs+IwNJWyh0ZanceTfcySyQvmFch62PpSUFfoqdKrXzX9/GTDfxNkMgXScHBY96+tGpnt05Z/fuckLEYFvNqZpmZMWLucax4BJiQT2rObw3HKLq96i8MJaLUyKPibXe1rab5lUE7ZpHIzEyovQJ6+mWltE/g8IRhdSJid16SEYYmnOyfX1kf3dzWIdm6lvffcz+1BaE4kJoxnmlhL5t1h/5YeOCcPC1XpQcj3T9SYT7cS6cWPPw8KSp4tUWqYT2GzaSTkH294MLbCArp9RjutJTApnrVQn2V+dSZHgGPbz8kp8Iea3uoDPoh9w6wx4IbjUX78bgN8EIDoCsTvRYZeAyIX4ID0fjUKKzxtHoztYwvH0D5/8eGyYYJ1Vt6hwapNFHd0lMcZYX0f7dgsfwknl6CaHu+CpAiZeyfvJg5Im7mBNLJassp2B2IlYuRYc0XLtJM0Xa+XegC7k/l7dp7gwDaLecO2BTyRuOKYYOB/5SBK8vKRsxzdqFD8y8Tz4aQS8MFGd30g0Xxjvbb4k1IXlxP+USFhu3HDcLrGfAqeFDDnylpAmEwvzW61vkdVcayGwdVaLuHFwU2Q582BoHUdn2jlgbb9kupt1uOpPiAL/bIf91SgGl8Do4SIlSZbBJvnCU6IosUxIgciAIf7/GoMt9eYq8+jegcgxhCFiW4zNX58iYKKMkaOeMoEn0VDx3zaG8AABKzJJMwymnAvMTFCSuV5piMn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(10070799003)(366016)(22082099003)(18002099003)(38070700021)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEFCWStzR2IvYmlkZFYxdnRKQ1pjR2d3TUxoemVPbTd4YXpTaHNGSlRmaG1z?=
 =?utf-8?B?aVRSU2JBelM5bnkzT2h3RjFlbUFDYjNPZUFoTHdjYmptVWJYb0JRSE5EUGRm?=
 =?utf-8?B?S2lJTFg5RHhHa1NSNlR5NWtNWDBwM3VrbFBIMHNwLzJRdFRpYTZtSDAvcEpp?=
 =?utf-8?B?KzBFRjdyN05VOVpqc0VJLy9GdUNIZ0Y5bCttZFFVODd2eE03RlFwdlJhUG9Z?=
 =?utf-8?B?VjhySWlldjVwVFR5Z2FUR0VaZGg2elh1bnZyZUNaRklXVEhITnUrdXBQaG1l?=
 =?utf-8?B?V040RDl3cm9xSTV4c2RxTjRCYUJnWmZRbGRmNlZoM0IxaEw1eGU1QWFxRUZ1?=
 =?utf-8?B?cjJmRnZsSFpNOWdMS2lHNExPdnhKVjJOaEZrdEZ5aFhYSDNrTTVsZ2tBeGhT?=
 =?utf-8?B?bDF6QzZwKzhMYWJBV2dhRndSTGxPYlJxQXlrTEVtQ29WVW5PMm1KclNHb25o?=
 =?utf-8?B?blp2OS9BanRYblhLS2JVTlYyU3NEQndIdm9vc09aMjk1UENRVUx5YzZuODBy?=
 =?utf-8?B?aGNnR0drMm90bnJJeHVxcDU2U2orN3NhRGZHSko5RmExTm4zZzlLaFh0Uzh3?=
 =?utf-8?B?RzZlMFI0eTduU3RCUlluMC90dk9tOGM5VU9XZ3hVSmw1RzltLzBHNUVHVmtx?=
 =?utf-8?B?SkdGTjdybzJBemNyeGdOMC9SWHdHeXNsVG9YSUl0eUxKNFNoWjVwNnNKb3dY?=
 =?utf-8?B?aHoyTEUxa1d3WkNVMmdjcXRuV0g1V3Z6RFBUUjZOall3RGgvUVNCWU1YVUwr?=
 =?utf-8?B?dWlHRHBqaloxQlBzQWpoSExSNFluY2x3MGxHSlZvOFo1RlBzTUtmNGdteWhq?=
 =?utf-8?B?VFc3M29iN1FPdlEzSnVUVVRIMGZhVTJ5S09PMU0rVzEvMEVoc1MzQVJTMm1s?=
 =?utf-8?B?bzZCNU04V21FVlVjZkY3QnVFZTJjK0FhQWV4bGZvSVpWeC9VV2NzKzVlcGNs?=
 =?utf-8?B?Zy85VUJLQk5hSXZjYWtCMzhwVWI0aWlORG5CRERNMmdCWms3Ty9zbVovK25L?=
 =?utf-8?B?UjArNGFSQ2lpVlkrMEx5Nktzb3JacGtTQllMYlhJajIxcXB6TmlHLy9ydzdz?=
 =?utf-8?B?MW9pcDdVV3VlWE5CUEVwQTQ2UGtBRzJ0UnAyb1E0UTB2d1NKZzB3R2VmeGc3?=
 =?utf-8?B?VFZTYkZONW51ZStWYlJTaE5ic3JHRlg3WEREbnJTTVlRQ1FQcEZZZGxiRWlL?=
 =?utf-8?B?UHkzZ0Nid2ZmOWM5c3ZUVEUwMGFETjBraVEyaVlINWRHangrU1NidXM4dU5B?=
 =?utf-8?B?dWFOemNzcS9YVW1WSng5SzZSM2lyZGxSakQxMGF4Vkl2eEJXVXpSRnQwMlFy?=
 =?utf-8?B?NFBzbVByYW5Cd0kwb1cwbUZEeXhWZVBlOW4xdk05SytGb1dyamcraTNaSDdk?=
 =?utf-8?B?MXdGOU9qZ2Q3K1F3MHdhTjRHVW5DbHcwNUNETm1WT28yUXZ2eFh4K2lwVTgw?=
 =?utf-8?B?dTlOOEh3SzhQdEFKU0dYVEpycGdXeEh0bUN6RUp2NkMvUmdFakd2S3VpcURl?=
 =?utf-8?B?UE41eUloV25BL2tzWk9obUl3aWUwM2QwVlJlM2J4Mk4vQW12SEtSaWtScTBG?=
 =?utf-8?B?aWNBY3VlZUJMRWltTENNc1ZrSllJMWxvQ2luM2cxZ3IydjByMS9SV2R4UWp4?=
 =?utf-8?B?WVI1VjloZXFTRjFDS2ZQRXZ5azc3RHZHUElxN1NTWEY2QlVZTnM2NEl4QmdX?=
 =?utf-8?B?ZXMzbFRMYzArZnhJWVVpUTEzYXkyZ094M3ovUkxOK1UzNGNUa3lHaTJtbHhM?=
 =?utf-8?B?K05NWWpmNWlicmlNUjFUQnBuSkdpdnNZYVQxWlRSbnFmM3FyaU1Oa0tpL29H?=
 =?utf-8?B?T1RWZzZLY2piVFl0RE5iaUV0S1lvSXZSUzFvMndURG43bEZFRWc1cjJkUHFU?=
 =?utf-8?B?c3JIbnU3UVhsOTJQSGgvV1Z2VUdRT1pYQXd1ZzZtSGVUUG1zaGZCNkVobmRT?=
 =?utf-8?B?OGZPR2pKdGNhbnJ0UlNQT21VaSt6dWFlNGh1MkplaDYrbzNIbmxTNmI2VzQv?=
 =?utf-8?B?NmxWcWJpMm1tRFBQN1E1dldNR0MvVVpmN3RUaWV4citvSFhqMjhXbGRZUFQv?=
 =?utf-8?B?S0tmTSt0OUg5VzZSbDlEMWpmSTFQY2pGWUtRbVUwYUpENDVQbFlmakR4UDcz?=
 =?utf-8?B?ZUhXQXMwMHV0RmJDS1lRWU1jMTZrWGgrRXk2aHJpRFBKK0FLSWx1Z1RPVlRs?=
 =?utf-8?B?TzlXOUdiKzJoNUpGNDY1TExIZmtkSENyUFpxY0s0b09RRlRLaWRjZ0tRdmdC?=
 =?utf-8?B?aWVjaHN5RDdyMWc0K3BBUE1DSlBpVUdYRmRaLzh5TFp2THdWamM2QklRMzYz?=
 =?utf-8?B?Uzc5eGN2WVNwNmdCMXg3V1FuT2pScGtxckUzaSszckoyYkdTRHl1UGJNaUpm?=
 =?utf-8?Q?bPJEMFUjQaXTq1BmyEWibU3vfJBgXdwtXZOc3VSST0Gqt?=
x-ms-exchange-antispam-messagedata-1: hR1InEbpPK/Hcn09ABCZB+Wfih5O+pl59eU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FA7E37A94DF8249A7D2489464015673@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: N7cIPrqpUAZvKhM36feJqFzcHzMBHRMvp52fKKwvTmpfItL+V0MIfmY/OQrFON+JNCxF5w9joBBUm2JKtojodWRbPp/Xr3NxSA3CG5AziMGkDeTnMB/hc4V6L7xDtGdKaUzvn1tB3wnVx14BuAnLjQutjs7SHcZFaxnSnoQriRi7o4Z4HXosBdE8mnRm56q+7NG+1kXP5Z6IniJYonyvuzuxYgR8j07Z2VZTriPG/UdXFtADc8IrUe988jQrlMGqsETYoRZifd989LWroRmTP5ejheFwGih/Yd/qSqSPqBylr7/5qYUu4v10P5J4aMuteNoou6+bvFUskIGFQQyIfg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fLlWGRIT1eOL7jnkagy9vxMPhpquMvXo476ai9hZKdKAPeTshaeOea4w5vpFTLUyVFslbA+jpmKbLThG8w3MtZkRzvOB9pBWb8IxQBedaXvwxr58dN9rC0DQsOTh55kty8JAP0ZD3FsgdBmn73agCx7qPkBS+k+vAfKfOKxFodokClL8Hq4awzzZZ21vgbnYxs3BU1bxHwn9fcoTplPOLYg3BMp1HZ6/8g7md/ESzJkR8Pi98vxj0QtXHPTm5yhTtrJ3yR7fpe+Q08ivBodWLIR6l9GtqwDI3cSh0uIpmZnrrnajjnO8lKa+kdS0lLvB60KmL0Ig1rUQbWGBC++aXKoP6gs9GhowQnHj0CwflpVuWBkxmS7TuDD0Z6r5JlkCz/Tt0f9cf2duM3m62pyBgARqe0Z8DYUZVKDbzdqCAAx5SiGDVnphT87cbmbZAdub26tPBbBcxaQ5oy12xQKyNYJH2R9orQ6LY2LGcNzAIE6IiXBkL2u35y8b8J2GPNhCbTUyQcEADaPGRlhBl7taDvbU27X2oY8M9Mie/QJceP3umNsJElt0eWFSlfeGGAZ/MDpyBOhXaFpU/Wl9qNXgWlJt35TFOh5Sp4mwZy6PdwBJtPtDGgWtMP/eKsd2axS6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a15b4c-2445-42d0-2008-08debb8b91a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 01:02:05.1448 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pZonrKKyU75zQ7eIkM+JTyNJ9fenloUEsAq46ZS4LDcquw/Kupb4DgSlrQaGlh6D8C/IFZcY67RV0l1EregweVSO4QoDPOFLVwNM3/TQUOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8173
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=6009f06ea=Alistair.Francis@wdc.com;
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

T24gVHVlLCAyMDI2LTA1LTI2IGF0IDIwOjE3ICsxMDAwLCBzdGVwaGVuc3BvcnRpYUBnbWFpbC5j
b20gd3JvdGU6DQo+IEZyb206IFBvcnRpYSBTdGVwaGVucyA8cG9ydGlhc0Bvc3MudGVuc3RvcnJl
bnQuY29tPg0KPiANCj4gQ1BVIGN1c3RvbSBDU1IgaW1wbGVtZW50YXRpb25zIG1heSByZXF1aXJl
IGN1c3RvbSBzdGF0ZSBpbmZvcm1hdGlvbi4NCj4gVGhpcyBhZGRzIHN1cHBvcnQgZm9yIGEgdm9p
ZCBzdHJ1Y3QgdG8gYmUgYWRkZWQgdG8gQ1BVQXJjaFN0YXRlIHRvDQo+IHRyYWNrDQo+IHRoaXMg
c3RhdGUgaW5mb3JtYXRpb24uDQoNCk5ld2xpbmUgaGVyZSBwbGVhc2UNCg0KPiBTaWduZWQtb2Zm
LWJ5OiBQb3J0aWEgU3RlcGhlbnMgPHBvcnRpYXNAb3NzLnRlbnN0b3JyZW50LmNvbT4NCj4gLS0t
DQo+IMKgdGFyZ2V0L3Jpc2N2L2NwdS5jIHwgMTggKysrKysrKysrKysrKysrKysrDQo+IMKgdGFy
Z2V0L3Jpc2N2L2NwdS5oIHzCoCA4ICsrKysrKysrDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAyNiBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L2NwdS5jIGIvdGFy
Z2V0L3Jpc2N2L2NwdS5jDQo+IGluZGV4IDg2MjgzNGI0ODAuLjJlM2FjZWU3NmYgMTAwNjQ0DQo+
IC0tLSBhL3RhcmdldC9yaXNjdi9jcHUuYw0KPiArKysgYi90YXJnZXQvcmlzY3YvY3B1LmMNCj4g
QEAgLTgxOSw2ICs4MTksMTAgQEAgc3RhdGljIHZvaWQgcmlzY3ZfY3B1X3Jlc2V0X2hvbGQoT2Jq
ZWN0ICpvYmosDQo+IFJlc2V0VHlwZSB0eXBlKQ0KPiDCoMKgwqDCoCBpZiAoa3ZtX2VuYWJsZWQo
KSkgew0KPiDCoMKgwqDCoMKgwqDCoMKgIGt2bV9yaXNjdl9yZXNldF92Y3B1KGNwdSk7DQo+IMKg
wqDCoMKgIH0NCj4gKw0KPiArwqDCoMKgIGlmIChlbnYtPmN1c3RvbV9hcmNoX3N0YXRlX3Jlc2V0
KSB7DQo+ICvCoMKgwqDCoMKgwqDCoCBlbnYtPmN1c3RvbV9hcmNoX3N0YXRlX3Jlc2V0KGVudik7
DQo+ICvCoMKgwqAgfQ0KPiDCoCNlbmRpZg0KPiDCoH0NCj4gwqANCj4gQEAgLTExNjcsNiArMTE3
MSwxMiBAQCBzdGF0aWMgdm9pZCByaXNjdl9jcHVfaW5pdChPYmplY3QgKm9iaikNCj4gwqDCoMKg
wqAgaWYgKG1jYy0+ZGVmLT5jdXN0b21fY3Nycykgew0KPiDCoMKgwqDCoMKgwqDCoMKgIHJpc2N2
X3JlZ2lzdGVyX2N1c3RvbV9jc3JzKGNwdSwgbWNjLT5kZWYtPmN1c3RvbV9jc3JzKTsNCj4gwqDC
oMKgwqAgfQ0KPiArwqDCoMKgIGlmIChtY2MtPmRlZi0+Y3VzdG9tX2FyY2hfc3RhdGVfaW5pdCkg
ew0KPiArwqDCoMKgwqDCoMKgwqAgbWNjLT5kZWYtPmN1c3RvbV9hcmNoX3N0YXRlX2luaXQoJmNw
dS0+ZW52KTsNCj4gK8KgwqDCoCB9DQo+ICvCoMKgwqAgaWYgKG1jYy0+ZGVmLT5jdXN0b21fYXJj
aF9zdGF0ZV9yZXNldCkgew0KPiArwqDCoMKgwqDCoMKgwqAgY3B1LT5lbnYuY3VzdG9tX2FyY2hf
c3RhdGVfcmVzZXQgPSBtY2MtPmRlZi0NCj4gPmN1c3RvbV9hcmNoX3N0YXRlX3Jlc2V0Ow0KPiAr
wqDCoMKgIH0NCj4gwqAjZW5kaWYNCj4gwqANCj4gwqDCoMKgwqAgYWNjZWxfY3B1X2luc3RhbmNl
X2luaXQoQ1BVKG9iaikpOw0KPiBAQCAtMjcwNiw2ICsyNzE2LDE0IEBAIHN0YXRpYyB2b2lkDQo+
IHJpc2N2X2NwdV9jbGFzc19iYXNlX2luaXQoT2JqZWN0Q2xhc3MgKmMsIGNvbnN0IHZvaWQgKmRh
dGEpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhc3NlcnQoIW1jYy0+ZGVmLT5jdXN0b21f
Y3Nycyk7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtY2MtPmRlZi0+Y3VzdG9tX2NzcnMg
PSBkZWYtPmN1c3RvbV9jc3JzOw0KPiDCoMKgwqDCoMKgwqDCoMKgIH0NCj4gK8KgwqDCoMKgwqDC
oMKgIGlmIChkZWYtPmN1c3RvbV9hcmNoX3N0YXRlX2luaXQpIHsNCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgYXNzZXJ0KCFtY2MtPmRlZi0+Y3VzdG9tX2FyY2hfc3RhdGVfaW5pdCk7DQo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1jYy0+ZGVmLT5jdXN0b21fYXJjaF9zdGF0ZV9pbml0ID0g
ZGVmLQ0KPiA+Y3VzdG9tX2FyY2hfc3RhdGVfaW5pdDsNCj4gK8KgwqDCoMKgwqDCoMKgIH0NCj4g
K8KgwqDCoMKgwqDCoMKgIGlmIChkZWYtPmN1c3RvbV9hcmNoX3N0YXRlX3Jlc2V0KSB7DQo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFzc2VydCghbWNjLT5kZWYtPmN1c3RvbV9hcmNoX3N0YXRl
X3Jlc2V0KTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWNjLT5kZWYtPmN1c3RvbV9hcmNo
X3N0YXRlX3Jlc2V0ID0gZGVmLQ0KPiA+Y3VzdG9tX2FyY2hfc3RhdGVfcmVzZXQ7DQo+ICvCoMKg
wqDCoMKgwqDCoCB9DQo+IMKgwqDCoMKgIH0NCj4gwqANCj4gwqDCoMKgwqAgaWYgKCFvYmplY3Rf
Y2xhc3NfaXNfYWJzdHJhY3QoYykpIHsNCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9jcHUu
aCBiL3RhcmdldC9yaXNjdi9jcHUuaA0KPiBpbmRleCA3ZDc5YzdhNWE3Li43N2I1MTNjMjlhIDEw
MDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3YvY3B1LmgNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2Nw
dS5oDQo+IEBAIC0yMTMsNiArMjEzLDkgQEAgdHlwZWRlZiBzdHJ1Y3QgUE1VRml4ZWRDdHJTdGF0
ZSB7DQo+IMKgwqDCoMKgwqDCoMKgwqAgdWludDY0X3QgY291bnRlcl92aXJ0X3ByZXZbMl07DQo+
IMKgfSBQTVVGaXhlZEN0clN0YXRlOw0KPiDCoA0KPiArdHlwZWRlZiB2b2lkICgqcmlzY3ZfY3Ny
X2N1c3RvbV9pbml0X2ZuKShDUFVSSVNDVlN0YXRlICplbnYpOw0KPiArdHlwZWRlZiB2b2lkICgq
cmlzY3ZfY3NyX2N1c3RvbV9yZXNldF9mbikoQ1BVUklTQ1ZTdGF0ZSAqZW52KTsNCj4gKw0KPiDC
oHN0cnVjdCBDUFVBcmNoU3RhdGUgew0KPiDCoMKgwqDCoCB0YXJnZXRfdWxvbmcgZ3ByWzMyXTsN
Cj4gwqDCoMKgwqAgdGFyZ2V0X3Vsb25nIGdwcmhbMzJdOyAvKiA2NCB0b3AgYml0cyBvZiB0aGUg
MTI4LWJpdCByZWdpc3RlcnMNCj4gKi8NCj4gQEAgLTUwOSw2ICs1MTIsOSBAQCBzdHJ1Y3QgQ1BV
QXJjaFN0YXRlIHsNCj4gwqDCoMKgwqAgdWludDY0X3Qgcm5taXA7DQo+IMKgwqDCoMKgIHVpbnQ2
NF90IHJubWlfaXJxdmVjOw0KPiDCoMKgwqDCoCB1aW50NjRfdCBybm1pX2V4Y3B2ZWM7DQo+ICsN
Cj4gK8KgwqDCoCBjb25zdCB2b2lkICpjdXN0b21fYXJjaF9zdGF0ZTsNCj4gK8KgwqDCoCByaXNj
dl9jc3JfY3VzdG9tX2luaXRfZm4gY3VzdG9tX2FyY2hfc3RhdGVfcmVzZXQ7DQoNCldoeSBhcmUg
dGhlcmUgdHdvIGN1c3RvbV9hcmNoX3N0YXRlX3Jlc2V0IGZ1bmN0aW9ucz8gT25lIGZvciBpbml0
ICh0aGlzDQpvbmUpIGFuZCBvbmUgZm9yIHJlc2V0ICh0aGUgb25lIGluIFJJU0NWQ1BVRGVmKT8N
Cg0KV2h5IGRvIHdlIG5lZWQgYSByZXNldCBmdW5jdGlvbiBoZXJlPw0KDQpDYW4geW91IGFkZCBj
b21tZW50cyBkZXNjcmliaW5nIHdoYXQgdGhlc2Ugc2hvdWxkIGJlIHVzZWQgZm9yPw0KDQpBbGlz
dGFpcg0KDQo+IMKgfTsNCj4gwqANCj4gwqAvKg0KPiBAQCAtNTYxLDYgKzU2Nyw4IEBAIHR5cGVk
ZWYgc3RydWN0IFJJU0NWQ1BVRGVmIHsNCj4gwqDCoMKgwqAgUklTQ1ZDUFVDb25maWcgY2ZnOw0K
PiDCoMKgwqDCoCBib29sIGJhcmU7DQo+IMKgwqDCoMKgIGNvbnN0IFJJU0NWQ1NSICpjdXN0b21f
Y3NyczsNCj4gK8KgwqDCoCByaXNjdl9jc3JfY3VzdG9tX2luaXRfZm4gY3VzdG9tX2FyY2hfc3Rh
dGVfaW5pdDsNCj4gK8KgwqDCoCByaXNjdl9jc3JfY3VzdG9tX3Jlc2V0X2ZuIGN1c3RvbV9hcmNo
X3N0YXRlX3Jlc2V0Ow0KPiDCoH0gUklTQ1ZDUFVEZWY7DQo+IMKgDQo+IMKgLyoqDQo=

