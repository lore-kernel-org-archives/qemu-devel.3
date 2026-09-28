Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF790C9832F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 03:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB1wL-00008t-6x; Sun, 27 Sep 2026 23:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=724888370=Alistair.Francis@wdc.com>)
 id 1xB1wI-000087-Lt; Sun, 27 Sep 2026 23:22:02 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=724888370=Alistair.Francis@wdc.com>)
 id 1xB1wG-0004aA-NJ; Sun, 27 Sep 2026 23:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790565725; x=1822101725;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=pLQG8KFQBKbMweHx/6tB28lwF0SSchTqmU/0ROlEYZ8=;
 b=J9RUmlAG217jkPN/QLKt7PMJCJfn55gARi5JNwHtiYI9TniWTaRzMT/f
 eQ22ytpVUP4CupIt+4+pS+dAVVgIp78K/C5SIjQP9tchPaH+AAQJg1ETI
 cQ+EotkWVqb+tm7k1CTR4duuMEXzZEXXfsh3Tbt4R3ITsG3v6ygxNanSb
 uyFm9/JEqO5S9USqwIkiHP8tVAWSvk15dhZWwBYYim3cHPJi31mTLY9RM
 1MUmneXKTSUWeVJwKJEvzREdbfxXb/CNHqoyTuSM7bl1JuHKFiXVgepc5
 d6iGNmfPdYdJQhwCkytH0DqoQuZiHi7Tf8b3MoP0Uu+lJ9Jm/d7YZAOPP Q==;
X-CSE-ConnectionGUID: RPFx5hb4QVa7bKaCEW4o5A==
X-CSE-MsgGUID: APbuJuWmTUu4sfh7JClz2A==
X-IronPort-AV: E=Sophos;i="6.27,127,1786982400"; d="scan'208";a="155112904"
Received: from mail-southcentralusazon11011011.outbound.protection.outlook.com
 (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.11])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 28 Sep 2026 11:22:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0tEHOMZkNKBVheRlClypUP/zCbFWunTCdvuTG3CqD9IwNPjvSYcBsDXFylDbEkvk85BsMa70R6/Cv+7IrXTTeioxijjtq8x0P/xm1pMunVFrVZ/ifqblf80Wmh/TPY6OUIY95kK2tJph10z+2KeEF3DIVN7gF7O25YFKgwLvMC+usuA7VmYiKZzHYnTzY6oyBEEF2oHcYAKCHoPTtCEt2qATgmzKZ/RYTPk8n2Dhp+XOdB7n+xjepQXVd39K2b6potMjxvaizZCLDnP6G1T6AomJouJ19TTL4pGWwcOJQ6Xo8atDpfKOumv/RCDpVCi32uqERttR0PWRrVJ0ZSpgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLQG8KFQBKbMweHx/6tB28lwF0SSchTqmU/0ROlEYZ8=;
 b=B6qQsXxRXy8FXRccmkptPXa41kk8L62MBPjonLh0e7j0WF8dqh7iYSbqhTuyLi+YtKLuCB/KwIcJVlUNB/ZLTWZadaowuqcBAdukqvcqz6OK4NfhLkz5HTRIwnY0C2YoHVx4TtrQBUN4R+qXPyzoorpQ/6ShnaQCZmalTqP2/GFmwBuBE3cybGfQ1o+ZgN7PsQztgpBYiFVc8F1SvG3bzIlwpk9MFgzCBI+Q2NX3frrFiTaVRhrlerwck9PeFF/H0i7aenfSfkIAHX4Zj2iJC9SOe8qfM6YFy21zVQatq9gbLA7I3qeYpCRglJarDLW95c0QDpbMabQQS8kswMmU7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLQG8KFQBKbMweHx/6tB28lwF0SSchTqmU/0ROlEYZ8=;
 b=tJrWreZChICiV/0I3ZuJZzX26KnhaFAlGR0079O34e7th6Kyx5nKvUMHEF3cSEVI+gMRkoBtShIuPd9J9TQrMXWhm8BbyC22CkVfReQVAmR6n+Br9EQEzV4Ndp9veCVKtr7yyyGoBnExGXkNrzNNTO66C0NPrSiUlGo7qKRx4oM=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by LV8PR04MB9729.namprd04.prod.outlook.com (2603:10b6:408:295::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 03:21:55 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 03:21:54 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v9 7/7] tests/tcg/riscv64: add sdext "not on Debug mode"
 sigill tests
Thread-Topic: [PATCH v9 7/7] tests/tcg/riscv64: add sdext "not on Debug mode"
 sigill tests
Thread-Index: AQHdQGpgPZbcWM32gUSJbDkc+qcWCrbjcC+A
Date: Mon, 28 Sep 2026 03:21:54 +0000
Message-ID: <d8626847c00d936e127beab5de00c8566d91aebd.camel@wdc.com>
References: <20260909144841.1766921-1-daniel.barboza@oss.qualcomm.com>
 <20260909144841.1766921-8-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260909144841.1766921-8-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|LV8PR04MB9729:EE_
x-ms-office365-filtering-correlation-id: 19d7827b-d475-43e8-8c18-08df1d0fa516
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10070799003|19092799006|38070700021|4143699003|10067099003|260925021311599003|260925021911599003|260925022911599003|56012099006|11063799006|22082099003|18002099003|18092099006|10086099003;
x-microsoft-antispam-message-info: xq9tko0DXkJNc/1iTUXMlEhHlDCjoF3Yq7wTIxBTmrXTRf3Dsfy4p/tMKNif8x77+9PBGO5H+ShygXrMjlD0dbDdNBHdjyrpowNXBlEmOZUVr8ZQ/IlmoI1ZykjRc2n90Io12Jox76QOY+gB2ssVVVEBWzos7/KeALXqRlt5UDde+XbmD7vkwOaeLdygX6f/EnAYkO0jLfTnxz0wn6oFZYzm3kspUR4Cn7Zh36YXFC+ke0cG6yfi6Q5OJLCstSEAINk6iz8+JxQNvoKX4zjrxDCBfJmQ50n4osKbuk0kpGi69RaAWMrjwYDbWroemRGd7zQ+zzA1D+C+kZFiLOGNvtojxN1v7ksIvT1vhmzAR2t6nv6W4d483QlsKBsYXv82XECeh1PSeflaesT+byPeoiWGNimDHLQP4MRiB9cZKmhdLNHw1GXU5MIw/BeVSaNrTlL/8PQMSK8kSsYGNSsbyiywdcYpItP7UfRR1OCvlu/7lq9P1Dj9liWY0urOWKRpAh35B8q3e9AMBoZUXfcp0/nElqZtdmVYDz23te6XMIdmIqvN/Dyuxlq1cawnFtlwI28LH6g424V8fdRbvyj4nxUjc+9vP9PCQdEXX9BpROyQIpBOHhgEUJdHiFbBTgYSttkUrMoc92mBPE9af71nIYzfSLvWI0wrpUopZZxwDT9jBMPypl+IWOqUy07sIKFLJxFLL6LyH7kW7oeogBf5tn+cV0agEPYojSF+Ifd2kmw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10070799003)(19092799006)(38070700021)(4143699003)(10067099003)(260925021311599003)(260925021911599003)(260925022911599003)(56012099006)(11063799006)(22082099003)(18002099003)(18092099006)(10086099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDd3Ymh6TTBNWklxSm10MFlCaTU1QW9ZTXJObDBpekVNVGE1MXh0R2RhWm5w?=
 =?utf-8?B?SEczZi9VaTV1Q01TTTFaaXk5ckZGL1pndjJvSkEwekgvbHkrUVFhVGNDRXRK?=
 =?utf-8?B?NlA2bXlTcmpkdkxBWGRkcTdJdldmUmoxQU52Q1NoSU56ZkF5ZHBxVUsrWFFE?=
 =?utf-8?B?QUJiTmdoVy9aeHZ2NHRyZGlta3d2N2NOa0dORDZhTXZYTElqbFlCbk4yUWZr?=
 =?utf-8?B?bmhRVVlCdmRaUFJ6bDdqMkJRSDJyajludVRRWEl6NDV4Qm5PK2pkY0kwSGtV?=
 =?utf-8?B?K05VQ1RvWU5FUVkwV2dJVE81Q2dQVU1GMUdZaFlzY0p2Qy9lNFRkYVJ0SnBP?=
 =?utf-8?B?UGgxRlloa0pOdGZyQU5xRkMwejZKT2kyeGxjSnVjVW1FOTdIMjNGNHEvMDYv?=
 =?utf-8?B?VkVmYUF6ZU5uYTIybGFSOUZDenBlUW9GcFdtdlcrZ3RhaTJzT2lFcVZFV1pl?=
 =?utf-8?B?QzcxUFRrcklTWUp6TnBZSS9xWDVhME1VZ2FDbUQwRWJiN1dBTWhUUFRVbldG?=
 =?utf-8?B?bTlrbEtoYkp6ZkJhNnZlTEM2Q1Nlc2Q3NjNMODh1aHZRTXZKUm9UNitWcUV4?=
 =?utf-8?B?WVA2b2FiY0JKQVZTZnI0RnhRQ1A0UUw2NkhpajlQQ1c3dDVRZktCdXlnL2dQ?=
 =?utf-8?B?TzVWc3A0dUtqZVE4S05KM29idFN5YmdSbzJOYXNxU2N6SE5pZGRtQitCQ2g2?=
 =?utf-8?B?ZzY5Z1JkMDdiR0RGQWpQeHpialFPdlhNendJQzk3Y3NnZ1lidnRaRzdvSVlw?=
 =?utf-8?B?citxd01tWFJmaTVtaFRPNGVwMXh2eVkzRVJUaHFuZTl0MVg5K0dEMWs5dEdY?=
 =?utf-8?B?UE95MTR6MmZpN3hnaEFaZTZwc2lxWkZvOGRDMVVZOU9vZEhNMVQ0dCtVVDEr?=
 =?utf-8?B?K1V3U2JFVTM0a3BVdXJ6YlBDOXhIcDRtU2lMNHRiQmI2UjZFdHRrTDQvaDB5?=
 =?utf-8?B?Z0VIOWVSS296WVlwSHh0eUkvY0dDbjFuNDJWaWtnSCtCbGpmZzEwSW51RmJQ?=
 =?utf-8?B?aDR5UEtva05qZ3lpTFFkaG0xM3NsU205L3hYUnJ2L05KT3UyVms4cWR4ZWs0?=
 =?utf-8?B?c08xRTRyRGpiZElYRWNYT0c4SHl4RDlhUHQvVXpvbEdUb3dEelQ5c21tblpt?=
 =?utf-8?B?MXJSdTl3c1hqS0diWnhHenF2WDJFUjc0MHY5amVSMjRybGtmZWNRN0NVVkxH?=
 =?utf-8?B?d1JwUFdEQzlpbnNiNTRYaFRUajMxQjFxUDZzY2gzaEhZNG9WOW51cE1WRGZp?=
 =?utf-8?B?bFh3YTIzbkhmZkJCMFlSNXlWWXk4czc2VXIwUHM2NE90Rm9nOUx4Q0paU3dw?=
 =?utf-8?B?WFpsQk93eXNhK0pUb0lFbmVTWWc2RzI1dC9IRzFNMnFGY1lsZ0Jrc1hxQ0R0?=
 =?utf-8?B?djZJbDBKRmZlOGc3bEh6aDh5TFh5RGdSTUVta3B3RDFxZVFtdGUrQzdFcXp3?=
 =?utf-8?B?V2VsbHJZRXZLVENmL1Yra0FrNTdaRE9LbjhCb3RPRzhPV3ozN3NpZ2NlaTJV?=
 =?utf-8?B?MXBNU2tNREgydmFMTytJbEtyb1U2dXhweElQaHdwWWNHS1ZNWDBtYXNaazl2?=
 =?utf-8?B?elRxeXlQYndBQ0E1ZWRKTmtJT3FQQXdONHdtUGtOZy9Dc2lFdUdxVStOQWFD?=
 =?utf-8?B?MlVCL3Z1Qjcya015RENvek9aRms2MUN2QjhTSFFqckVNcGg1L2ZFTEFQTHpX?=
 =?utf-8?B?b3lsczJ2Z0FsT3NSTkNnNWFFbnFxd3k2K2VISUZ4VFpBaExCVTgzMUNXSGdv?=
 =?utf-8?B?S0tGYW5jc1Y0Ri9OSmFjZXo1MkhtN2pMQ2pWNzB5NUhEakpQWTZFWVJ3SFJV?=
 =?utf-8?B?ZE10ckJneW1Bam9ycEhpbGwzOE90czRsbjV6bnFpbWxaeW5YUGJSd3VaUWIw?=
 =?utf-8?B?NmFWNUJmenhIK3JRVUV4TFR2eEpWcDdXeUQ5d2FlVElpY1VXdllLNUdWVVli?=
 =?utf-8?B?akhnd3IzcUhhU3ozT2ZIWTNJZ0t5dEhHRS82VUM3MXMybHhjeDhRakV1cjBs?=
 =?utf-8?B?aURQQjkyU1ozL3ZkZkJQOUhvdlpjOXArMzRCd25UOTJ3T2NiQS9Ud1lPTmtY?=
 =?utf-8?B?TGthUEZ6a1FrQmRQNk5vbTdUZTdIYTJnWXJQcVFKODBpNW44Y25WTStncFVw?=
 =?utf-8?B?SnpNSU5kQVlxbUxYNytHSjc4blk1dEpSWFI4TkR6NlRpYk44SC9FUlFEZUht?=
 =?utf-8?B?d05oUzVzUEN5Sk9XcHY1MzFQNEUvbE1nbW12WlczVnhMYW90bkd2djJXNVVT?=
 =?utf-8?B?amdwa2JWU2hXVTMveDlKN2xraExSekVQVmZGZll4NUhpbjdOVWpDU1JPMFQ1?=
 =?utf-8?B?UXZ2Y2VCM21wYVZha2lvRlZvbTV3cFFLZGZGR2ZQVC9uVWc4TklmV2xCMnk2?=
 =?utf-8?Q?WBL8XuZz4Lv4XR2S1UpaaTJEIoXzZU27vCBnv572KtRMj?=
x-ms-exchange-antispam-messagedata-1: cGucmYgoIIHyiIGzdtsRmLg5EUX0PLRzPd8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F3EF45E0EE27044B5A39F77432FF97E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JRyQCIwIgJy8KssAJ5kCr+L+lpCjfQUX6rirX7Twii2V/kO5lGV/P9zQWeCWpglbK1O/Mz3Ve7Hy+kFzgO1IYD1PkFZ+hgicdTTo2xHMYFxgfoFiWzH7y9gz9EpL94qgKIdGtsdebmUjnwQVYbPMs1zSCrA2wWoBAuVQQ3hp7TwPI8Fqcnnbo2R1xY6aRYSl57DC5Yd1MrsaoBVet1gHCS7PXGm+QWRqc7jra3SkHDHeUIdhSbp9cbJt26DsttustFE77ZF6M2bGmfuYPwhlwr8dMffCxVQudAEIgQGA/Ib2pwxWiR0DFFMduiKDB4wkQ/WaY7SZHwlSv/je+xx/kQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MMd3qE0Mk8w/Z8Mj+cC5RxyFqrxysm7DYeRgF9DyvjIs4rbuzA7Mj2DDUDc0oIyCHPZWpwLHnvSkgsMzFRMIjwbx5V44bUd1p4A7r/O1ERvalazDVBPSj6lnI9Jgrr1cgADKEqYVS+nTHffE4FC0irz0bjO62PCSe+6FaaPnzM5Pg4YzURiy0mGyxLnlNXr3S9ZmpEKqkA9qgQBaukbIPSnz5uYyXNolVRFriXKye2X+YIJOKSnKG19hcduHX5VnUkIgMtM80LlmoJejMQOEM3NxjYToXvdIjzKxWy2Li8L9Rl23szjZdaJzEwGFdeAvOgQCNaFazZ+l3t1nmJryU/Q0MBCPmtR4pSJol9QF3j9hSid4i6JhmkfLSbuJDp2xVecPLAcltXdzC+EpqPprmGX9ZeuM9gasMBqlfJFHzCZzQLDtigl8YIQ27xe2i/PFJA9a7Tbf4J/NRzjlOuxVZWfSXTPD1IFLS6zgAySzq8PMXiOHd+i7BlA/IfbIa3KQbgqzFIOko5Gc9y0FlGpFDlsz6FRh6fd6vomcaRWM0L8gORnYwIslymJlnSXfM5ERI4wWjveZRU1RjxaI+3jeF8A/kLWFQ6qzj4xhbLMy5g7yL1n40fdIkt6D65b2YgNQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d7827b-d475-43e8-8c18-08df1d0fa516
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 03:21:54.0263 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dU4MA28dcWfjpAKuV7s6BAa8olJ/puLJzA9uNptHBNo85vjFR4l2uHXqtmc6FM0MfOdd9qwlphx9ensqUlVfVnaCQKJWXA99+Gcmi71eA8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR04MB9729
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=724888370=Alistair.Francis@wdc.com;
 helo=esa6.hgst.iphmx.com
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

T24gV2VkLCAyMDI2LTA5LTA5IGF0IDExOjQ4IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gQWRkaW5nIHByb3BlciBUQ0cgYXV0b21hdGVkIHRlc3RzIHRvIHNkZXh0IENT
UnMgcmVxdWlyZXMgZW5hYmxpbmcNCj4gZ2Ric3R1YiBzdXBwb3J0IGZvciByaXNjdjY0LCB3aGlj
aCB3ZSBkb24ndCBoYXZlLCBzaW5jZSB0aGUgbmF0dXJlIG9mDQo+IHRoZSBDU1JzIGFkZGVkIGlz
IHRoYXQgdGhleSBydW4gaW4gYSBoaWdoZXIgcHJpdmlsZWdlIHRoYW4gTSBtb2RlLg0KPiANCj4g
RENTUiBoYXMgYml0cyB0byBhbGxvdyBmb3IgY29udGV4dCBzd2l0Y2hpbmcgZnJvbSBvdGhlciBt
b2RlcyB0bw0KPiBEZWJ1Zw0KPiBtb2RlLCBidXQgdGhvc2UgYml0cyBtdXN0IGJlIHNldCB2aWEg
YW4gZXh0ZXJuYWwgZW50aXR5IChlLmcuIGdkYikNCj4gYmVmb3JlaGFuZC4NCj4gDQo+IFdoYXQg
d2UgY2FuIGRvIGZvciBub3cgaXMgYSAibmVnYXRpdmUiIFRDRyB0ZXN0IHRvIGVuc3VyZSB0aGF0
IHdlJ2xsDQo+IHRocm93IGlsbGVnYWwgaW5zbiB0cmFwcyB3aGVuIHRyeWluZyB0byB3cml0ZSBz
ZGV4dCBDU1JzIGluIG1hY2hpbmUNCj4gbW9kZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhbmll
bCBIZW5yaXF1ZSBCYXJib3phDQo+IDxkYW5pZWwuYmFyYm96YUBvc3MucXVhbGNvbW0uY29tPg0K
DQpBY2tlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0K
DQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoHRlc3RzL3RjZy9yaXNjdjY0L3N5c3RlbS9tZXNvbi5i
dWlsZMKgIHzCoCA4ICsrKw0KPiDCoHRlc3RzL3RjZy9yaXNjdjY0L3Rlc3Qtc2RleHQtc2lnaWxs
LlMgfCA4Mw0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gwqAyIGZpbGVzIGNoYW5n
ZWQsIDkxIGluc2VydGlvbnMoKykNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvdGNnL3Jp
c2N2NjQvdGVzdC1zZGV4dC1zaWdpbGwuUw0KPiANCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9y
aXNjdjY0L3N5c3RlbS9tZXNvbi5idWlsZA0KPiBiL3Rlc3RzL3RjZy9yaXNjdjY0L3N5c3RlbS9t
ZXNvbi5idWlsZA0KPiBpbmRleCA4NjA0YzJhNDVhLi42YTgzNjk5NGU2IDEwMDY0NA0KPiAtLS0g
YS90ZXN0cy90Y2cvcmlzY3Y2NC9zeXN0ZW0vbWVzb24uYnVpbGQNCj4gKysrIGIvdGVzdHMvdGNn
L3Jpc2N2NjQvc3lzdGVtL21lc29uLmJ1aWxkDQo+IEBAIC02MSw2ICs2MSwxNCBAQCB0ZXN0cyAr
PSB7DQo+IMKgwqAgfQ0KPiDCoH0NCj4gwqANCj4gK3Rlc3RzICs9IHsNCj4gK8KgICd0ZXN0LXNk
ZXh0LXNpZ2lsbC5TJzogew0KPiArwqDCoMKgICdleGVfbmFtZSc6ICd0ZXN0LXNkZXh0LXNpZ2ls
bCcsDQo+ICvCoMKgwqAgJ2NmbGFncyc6IGNmbGFncyArIFsnLW1hcmNoPXJ2NjRnY3YnXSwNCj4g
K8KgwqDCoCAncWVtdV9hcmdzJzogWyctY3B1JywgJ3J2NjQsc2R0cmlnPXRydWUsc2RleHQ9dHJ1
ZScsIHFlbXVfYXJnc10sDQo+ICvCoCB9DQo+ICt9DQo+ICsNCj4gwqBpZiAncWVtdS1zeXN0ZW0t
cmlzY3Y2NCcgaW4gZW11bGF0b3JzDQo+IMKgwqAgdGNnX3Rlc3RzICs9IHsNCj4gwqDCoMKgwqAg
J3Jpc2N2NjQtc29mdG1tdSc6IHsNCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9yaXNjdjY0L3Rl
c3Qtc2RleHQtc2lnaWxsLlMNCj4gYi90ZXN0cy90Y2cvcmlzY3Y2NC90ZXN0LXNkZXh0LXNpZ2ls
bC5TDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAuLjgwYTZjMDY0
NjUNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi90ZXN0cy90Y2cvcmlzY3Y2NC90ZXN0LXNkZXh0
LXNpZ2lsbC5TDQo+IEBAIC0wLDAgKzEsODMgQEANCj4gKy8qDQo+ICsgKiBSSVNDLVYgc2RleHQg
ZXh0ZW5zaW9uICJTSUdJTEwiIHRlc3Q6IGNoZWNrIGlmIHNkZXh0IENTUnMNCj4gKyAqIGFuZCAn
ZHJldCcgd2lsbCB0aHJvdyBTSUdJTExzIG91dHNpZGUgb2YgRGVidWcgTW9kZS4NCj4gKyAqDQo+
ICsgKiBDb3B5cmlnaHQgKGMpIFF1YWxjb21tIFRlY2hub2xvZ2llcywgSW5jLiBhbmQvb3IgaXRz
DQo+IHN1YnNpZGlhcmllcy4NCj4gKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
LW9yLWxhdGVyDQo+ICsgKi8NCj4gKw0KPiArLmVxdSBDU1JfRENTUizCoMKgwqDCoMKgIDB4N2Iw
DQo+ICsuZXF1IENTUl9EUEMswqDCoMKgwqDCoMKgIDB4N2IxDQo+ICsuZXF1IENTUl9EU0NSQVRD
SDAsIDB4N2IyDQo+ICsNCj4gKwkub3B0aW9uIG5vcnZjDQo+ICsJLnRleHQNCj4gKw0KPiArCS5n
bG9iYWwgX3N0YXJ0DQo+ICsNCj4gK19zdGFydDoNCj4gKwlsYSB0MCwgdHJhcF9oYW5kbGVyDQo+
ICsJY3NydyBtdHZlYywgdDANCj4gKw0KPiArCWRyZXQNCj4gKwlqIF9mYWlsDQo+ICsNCj4gKwls
aSB0MCwgMQ0KPiArCWNzcncgQ1NSX0RQQywgdDANCj4gKwlqIF9mYWlsDQo+ICsNCj4gKwlsaSB0
MCwgMQ0KPiArCWNzcncgQ1NSX0RTQ1JBVENIMCwgdDANCj4gKwlqIF9mYWlsDQo+ICsNCj4gKwls
aSB0MCwgMQ0KPiArCWNzcncgQ1NSX0RDU1IsIHQwDQo+ICsJaiBfZmFpbA0KPiArDQo+ICsJbGkg
YTAsIDANCj4gKwlqIF9leGl0DQo+ICsNCj4gK19mYWlsOg0KPiArCWxpIGEwLCAxDQo+ICsNCj4g
Ky8qIEV4aXQgdGhyb3VnaCB0aGUgc2VtaWhvc3RpbmcgU1lTX0VYSVRfRVhURU5ERUQgY2FsbCB3
aXRoIGEwIGFzDQo+IHRoZSBjb2RlLiAqLw0KPiArX2V4aXQ6DQo+ICsJbGEJYTEsIHNlbWlhcmdz
DQo+ICsJbGkJdDAsIDB4MjAwMjYJLyogQURQX1N0b3BwZWRfQXBwbGljYXRpb25FeGl0ICovDQo+
ICsJc2QJdDAsIDAoYTEpDQo+ICsJc2QJYTAsIDgoYTEpDQo+ICsJbGkJYTAsIDB4MjAJLyogVEFS
R0VUX1NZU19FWElUX0VYVEVOREVEICovDQo+ICsJLmJhbGlnbgkxNg0KPiArCXNsbGkJemVybywg
emVybywgMHgxZg0KPiArCWVicmVhaw0KPiArCXNyYWkJemVybywgemVybywgMHg3DQo+ICsJagku
DQo+ICsNCj4gKw0KPiArCS5iYWxpZ24JNA0KPiArdHJhcF9oYW5kbGVyOg0KPiArCWNzcnIJdDQs
IG1jYXVzZQ0KPiArCWxhCXQ1LCB0cmFwX21jYXVzZQ0KPiArCXNkCXQ0LCAwKHQ1KQ0KPiArCWNz
cnIJdDQsIG10dmFsDQo+ICsJbGEJdDUsIHRyYXBfbXR2YWwNCj4gKwlzZAl0NCwgMCh0NSkNCj4g
Kwljc3JyCXQ0LCBtZXBjDQo+ICsNCj4gKwkvKg0KPiArCSAqIFNraXAgMiBpbnNucyAoOCBpbmNy
ZW1lbnQgaW4gbWVwYykgdG8gc2tpcCBib3RoIHRoZQ0KPiArCSAqIGluc24gdGhhdCBjYXVzZWQg
dGhlIHRyYXAgYW5kIHRoZSAiasKgIF9mYWlsIiBpbnNuDQo+ICsJICogdGhhdCBmb2xsb3dzIGl0
Lg0KPiArCSAqLw0KPiArCWFkZGkJdDQsIHQ0LCA4DQo+ICsJY3NydwltZXBjLCB0NA0KPiArCW1y
ZXQNCj4gKw0KPiArCS5kYXRhDQo+ICsJLmJhbGlnbgk4DQo+ICtzZW1pYXJnczoNCj4gKwkuc3Bh
Y2UJMTYNCj4gK3RyYXBfbWNhdXNlOg0KPiArCS5zcGFjZQk4DQo+ICt0cmFwX210dmFsOg0KPiAr
CS5zcGFjZQk4DQo=

