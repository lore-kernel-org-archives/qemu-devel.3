Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9B2C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 04:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1zVj-0006qJ-2V; Thu, 03 Sep 2026 00:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1zVg-0006pn-TS; Thu, 03 Sep 2026 00:57:13 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1zVe-0000Gs-Qf; Thu, 03 Sep 2026 00:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788411430; x=1819947430;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=/4klosFitOUrrdNdhUVUabcmqcecm051LM/iQA2a0H4=;
 b=ZzOIE4GrAZQmV7fbT1UaBxNc2+xoScXFKbHYDmoMxX219VXyB/oZDVrZ
 JY3HuUJ1nZM9ARcSc7z0ufMGC8AulN523uExWRPgRSZdCEYzBeR8PCsjk
 PqHD0dBAg3hlb52Byzp1+3sOO6Xky8+3GZ5KcxvgppX3cnw+Pm5fIPudV
 BcUlp3jDdAMLtoQpXrsWxcrV/dR1bKVxulG8orpE3KIsfRSM4juCS03xs
 LjuxJ7e84QUGZnkcBiwBnGhxhjur5eVD/w6wiOKr2SQiFao7M6erCnMUp
 wvcaSTh3oYZ9ouy8IKVsFqAOeI1fhH8eMJH6NdflS1IPrTHMhYxr4DRI4 w==;
X-CSE-ConnectionGUID: anHYkmRqTq6hgu9R2D9DSw==
X-CSE-MsgGUID: CkCA0a2gRdSLPEIDThgsQQ==
X-IronPort-AV: E=Sophos;i="6.25,258,1779120000"; d="scan'208";a="155766966"
Received: from mail-westus2azon11012010.outbound.protection.outlook.com (HELO
 MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.10])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 03 Sep 2026 12:57:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJTZ/MpbetqoF5PX/LGchZJ1LZ8TVQ9HTeWPRwbRQKlohm4b8Kbv6KrYwn5J7cSm21yI9XWI+AaGr/KhyqiAcWRLihpZm6ja7sAXmEU9NEVvF5HkfsgyE5jg0/2Dt8CRU+9pjj3QZUvnIff/OetxJAfK6Ju3zyXfzIIN0Gaftxzo9hgNZaNMWQ5sctlPmKbNDX2qr4tCtdjzq+Px0tsI28bqjohIkuaEvOJ1rB1wry4s4QOvC0WNqng3LFAOG71JjcTSmLpNmizszV1hejF5eZy6QPrJ/3STjOYtbO+bI6Y94AOlOQGdwR6vFCNes1HZJsWQoogcBHrQiZZMC4Wnzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4klosFitOUrrdNdhUVUabcmqcecm051LM/iQA2a0H4=;
 b=CT4fR22+oxgn3qBCy7Hs3hwyXhDwgNadpYa1j/WTUMUOvrFOZyG5em/6cK5vlSbXc9lsZXidmvP1o0afbNgrliyJ1iFTzNB9/JcX2mEz9C+qt8ikdzMtjDX5mGI8+LZ90RVn5vRcbO1eWDFmxWCCF2r5coOijdz+RW8X9cklpbGim2huT8ftRFMCzgLVqodfaCm5sZPaeCcHvTd1ZxTbEF9INm5JjteLJBv8o8NpRhHVjmNifpyRwc6OpgfnAS1nHyVWpEowo92bbizZnyx+UnL5DdGmhMYn8FIXgHtuZHveFZpUs0q+D1/RQh9mN/Qq7oZ1jiLJoBjkiUF0xJH6Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4klosFitOUrrdNdhUVUabcmqcecm051LM/iQA2a0H4=;
 b=A6F4D3lNK3wan/mjQeBCCYv4RzSpgmdJdd57X3rb5B6P+apZf/B04LRQNsqz8fIZFRnXd7bui25R3wZoJzCZ7hJprSf1dCaNP7zqRGcgEZp0g1LXqrSbvFmxh+qIVRn2uC67Tq0B1wVShUjPlq8z2Nl3uSB6sMxvfZJ7lVwFC4c=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by PH8PR04MB8660.namprd04.prod.outlook.com (2603:10b6:510:23b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 04:57:04 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 04:57:04 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "314abh@gmail.com" <314abh@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv: prevent abrupt abortion on unassigned value
 write to tdata
Thread-Topic: [PATCH] target/riscv: prevent abrupt abortion on unassigned
 value write to tdata
Thread-Index: AQHdH64Z9nhdGcBW9ki+Gqkpk8rXe7a8gfWA
Date: Thu, 3 Sep 2026 04:57:04 +0000
Message-ID: <4524952f518c069cf27ee374ac42af8529936e76.camel@wdc.com>
References: <20260729230028.1797355-1-314abh@gmail.com>
In-Reply-To: <20260729230028.1797355-1-314abh@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|PH8PR04MB8660:EE_
x-ms-office365-filtering-correlation-id: 570cbbd2-0adc-4c15-8f8b-08df0977cc29
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|19092799006|23010399003|376014|6133799003|18002099003|10086099003|18092099006|22082099003|56012099006|38070700021|10067099003|11063799006;
x-microsoft-antispam-message-info: K1+4rox4pGHlv6hCQxfjUyYbaFTtFa7GjPaJi+7j7ZPY5C5rzfQvNKqZ2SYFjTBkfrpqinQVTajNDIIieM4qlei7V8usd959tnCOSG32JV7anb7rBSwWs70HBtvYUTs4pljYl5dbTBs7/DHRkteAQDKUrchCe473beXd+QixiyFoMxOTqq8LMwffyDV8/3ZDQvC2cmvWVFPWprHo6Xwjirj90Yq+WlNHW4GZShc2YsshhEkS1l27u6+03VQajcKKVZ4XcJoyT/9USi6UL3ajBPTJqKY66itnNxki8K1undM6+iT6QItwUdU3+xWhzcni0ymrRyRBcMpazBIwoQJvk0rdi/wWYZ5wsAbqUdBBsq3a/adgCtkNvhFuethgYGf68RKIb2StmOvA2JOdJq/P2udv+s9LVcLWsrAX/d7FiaFJAd+L1YC1ABWKHVFHH+AphAZBVQAHCASsOsQVPxp/PVGZ382y9qOPIF21jfb/QjevZHiw7GEYyXjBPqtS/PtD4xWh4CwfKpr8mSNrKvINMsmcyx6c3TCZEr7NFn0tsRhcIj6xBVcRsu/np+xfgl9Wudz3wg6jJ5J4HUYr6PkrNA1pFG+JkTCairEhkXuweZIKquabn/S77nE0RN6XGptFvMFKUi0+k5dlBvGtxqfavEnvQ4AwCKKRLxITPj5OQYzsrmvZzbd4x1+GVgIpVYR/U1v75/A4jkbZFr2NIEvuzSL01c0RcwY+1xXGaIOYfjE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(19092799006)(23010399003)(376014)(6133799003)(18002099003)(10086099003)(18092099006)(22082099003)(56012099006)(38070700021)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFVrMW1CSlZ4NEZiQVhnd0U5YXZTWWtUdVhHcWVHRC9VVHhwM1d2b2FkVE5L?=
 =?utf-8?B?d3BLSWd2VVBaOFZlY1lsbXhoYm1lTmJQcnZ1MjBXUHE5Y0h0T2RkbkFkWEFq?=
 =?utf-8?B?RmwydkF3YUZ0bXhGU2hoVlV6ODJMU1VodVk3VlJDTk5RTkNLR3NOS3Z0a1R1?=
 =?utf-8?B?MzNzWTl3Z21Da2ZQYWRZblljTDFjMzNFMTZMbDQxNjR0a0pLTU9hQXBvSU1X?=
 =?utf-8?B?Sk40NXpsdFdFa3FUeG9qTWh0UUNHWVQ0clIvcUZYU0kzSWJrNEJ2MXFwVGxI?=
 =?utf-8?B?UitVUFVoT2gyWjMybERiaXRoS3J5cFQrTW9EM3B2NnRBWGNNMDRPK01obWNI?=
 =?utf-8?B?djBjT0RabmdWWG5ZMkMrenpqS0I2aGF3REppZ1c5b0NTNWZOZ0MrQW5QU2k3?=
 =?utf-8?B?VVd0QVJ4T2M2MHB2VWxmY0grU3N3aW10cGMzWmtrRmpwNEVLWDErZ2RYQmNN?=
 =?utf-8?B?c3Q0OGpFM2JIbnByOGF2UmNpalBEZGJMcWRjWkxadmhMY3FEMEg4Tno0cDMw?=
 =?utf-8?B?NHdVWTdkRmY2a3ViL0RocjJubS9tOHNjYW8ydWgxbGtZZlgreXlYQ2FIR2Q3?=
 =?utf-8?B?Qnd4RzdaNzFadENlMWhRMkZuWHNBakUrMnVTSG9uaTJLR1daZ3B3TkE0T01q?=
 =?utf-8?B?ZjRnMGVNRVZEM3BicjgrR00wb1hTcDhHY1JrVjEwRERvN2ExbUlTUzJ1cXN6?=
 =?utf-8?B?SDg1VHExd0l4ZHZKZ21wZzUyQnBjUzNHT3hHR3RBMGE2Wk9IYXdhbUpzemND?=
 =?utf-8?B?MEc1Q0JNZU5zWGlYSXRmRlJXNGRIZEZySDM0aW0waDVhNEFFRlZXQ2NMdU1n?=
 =?utf-8?B?TkZFcHhLMmpEZlNmSUwrbnFDRnI0YTAwbDFubGQ5cml5L1VPT2FzT0FMamlR?=
 =?utf-8?B?VGJBRDJQZ2VMc3V0NVE0bWQvUjdka2dUUlRuWXFxTW5HdUVDZDFRbGlMMFh0?=
 =?utf-8?B?aE5mRnU1QWhYN2pKS2NvYUFUQzZEeE96cUpmSDExMm5naTFwcUYrbUp4RXZU?=
 =?utf-8?B?T3d2ZkhpTGhDU25IWmVzR05lWUJIYVZHbHVTSDRvRVkvS3JyZ21sa045bVpv?=
 =?utf-8?B?ckdwRlo5bFh5andCa2ZkajBjWHBJd3pqamJmenpvWGs1SkVZN2NDZWo5Wk9h?=
 =?utf-8?B?NXk5bXlYeUUyMEtvT3JNd1ExbC9xTGFseFQrSy9xZ1VTa2hiUzZ2TEdVbGFV?=
 =?utf-8?B?U1B0SzAyZExsZ1owdkhVSmlSekttQ20xV1JLSUkrSFg4eGNRSnR0Q0d5ajVs?=
 =?utf-8?B?OStFUkpwNGNMc1ppNCtWYmpMUnR1ZU5Lc2Zaa0pVNlQyb0NwZjF4dkFWWjFR?=
 =?utf-8?B?VjJENGZ4Y2pNWWZsOVJKbkEycVc3OEx4ckhZZ0ZyYVZ4RmV3NTFxLy9FVGtw?=
 =?utf-8?B?UCtBZ3VZSndHWUU1SnpiWWJhQm5hMzJ5MmNleFNvdFV4WXJJRWFsNGJaTG4z?=
 =?utf-8?B?SDRad3FQRkttTXd3M1B3bFA0VTdTWDdlRVFJaTMyZ3FCcnBONUJjTzIyM2RV?=
 =?utf-8?B?bVovUGlMMGE0UjJqelpSUVZkVDFrclVEWXBZNjYxbEV5bUxRZ3FBY1ZUTjR5?=
 =?utf-8?B?Nk1LZ0dpMnBRRERPSURVQktUTjF5c3JIMFFSa0kxV3RFaVV3MU1tWG1TUlI3?=
 =?utf-8?B?MDBFZW5lOEh6a0hXd2JEZWpEMElteFlYNEZYazhEcHAya1QzUFhtZWp6WnNM?=
 =?utf-8?B?UTNCcmVVVURtbGJ0VGRUU29CQ0tXYVFWQ1lwTFdIclhEQ295aVdDSmxITkFz?=
 =?utf-8?B?cTcxOFlSOUZJc3o3NXpwU0lQTWdDbkJSOFlFdFpjT29qbFh2TUJBbUxNUzNR?=
 =?utf-8?B?Uk9Ycmp0Y0tzWDlUdS94VGhidzc1VStHVXpHaUJMeC9rZGFWMlBHSksvYXMv?=
 =?utf-8?B?REpmT2sxMW0wYmw0MkRCQitPSnZXZXU0eksyMWtDTEd2a0ZiOStaekJicjZo?=
 =?utf-8?B?RTFHamJFUUxzc0ZPM3YrenFzc1FVUXQ5QUdET29zaE5zUWZQckZFOVhvRDdx?=
 =?utf-8?B?TzJ5OGpLbWU4NEpzcDA1K0d1aDZDRDJQc3pVTkR3dFM4L2R0Mk1PclNIMW1Z?=
 =?utf-8?B?MmhQUTBGeFRGTzliTHc5NHIzR3orUXdRQ05uS1BSZXFrbjNDd3doZ1VycEMx?=
 =?utf-8?B?QnBWSWR5OHhiMlpQK0kvWXFWSWpmRG9rcGFZdWl2a0RQaEtXaFhLSEFSTmJy?=
 =?utf-8?B?UWpwVS81Qm9lb2JXSXFFWFdOT25WaXNRbGFTSXhTMkFVcW83Y2RoZEFiVGQ2?=
 =?utf-8?B?U0djbXY0Y0xzNEU3ejh1NG8zQ3htSmdOYU1jTTdzdEFiYk9LcVRYcnVlbWlI?=
 =?utf-8?B?cDgyKzhIQ29zV0NpS1VoU1JadkVlNGJlZXE3NHQzSGJCRE9KVU9pY3greEtS?=
 =?utf-8?Q?2wo5mYtchpIIjh2/CKITL4ou3TweFKA3hcsM1gsQKw9E1?=
x-ms-exchange-antispam-messagedata-1: Vv/RCBgI+DjmpZkOn2HzI0maVOx32uSwnX0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <177079F67996EE48BC0CD9602EBB6991@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Dwq7nBL2DLPvEbySp+8rTuTnKz6uM4x273F0zi07UUZTk+Bp9vTsBgN3MpoARP2PbsNgBSSkBft3H4ZnTjDczrNXpdmm9xxlBP8i69ju/cNs0gXnyoxkD/zXoYf8Or1mOgbYENQYkK5Khyf0QGDSDvolBVGxXdLrJexPBGS3Y7MqPlImYnysdXPlrvH5S3//xq46St//38gN708CC21awiETxFxHWUII9VL24d8++MkaFfINiLHIEfptL3WR3KbuGAvycNv26f/U39kxhQGQ9oN7Z6iNvnLWLYZfTfA/YSWcfP9K4dJV+c0Lh7zeZ8aER7Z+DsS3uaxzUGy1F8XNvA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0jFcc7ZLLDksPbkHTsLh4/Ryc4Kyv10QE8UnI5EJ+aAjmG+PmZKUY0Cmb5TcWxXLStz4EctntOn8DPXP0TFK3PvF8z2TAPUSAm8ZlxfIWsdryYIVpb3VvFqf+GkVgQ+YrEcQ+gbjEcehSZTVfX4SKNQkN85C1X7ozXdWf457tgtE+WdB+NnyGXvYnMWqnRcJK8gNPWE2VeKvr+ljSbpC2Nq9Eiw0Y2HfDA81EuR6281gJ/gx5p5pOKXKOL+yeAJPr8DTTFxetDgT6ygSGgU4yFqWqBJzFKaLniZC60eIs9vQO5qmyymoagGO4Dt7JfKFlB+7nE3LBQtwCvROXdoqxPpwdHfaciuoUui0FU9WLVWO9ctInu6cIPk1glLHLK7mNdTcHTxT/qY2JBi3PZnz7wSQZRvTPrO6fv/eFPLc6v+ebBxIweFYHdxf7Z6+JnnigRMsH316cMC0h9P25c901nqzatU/ZL5IZBlqH6YHKaDJfSATiyDfRtNy/lj8cm8UbH8ONVSyHtyRzHEsjbXccfNd3dQdILgeVZZJIbh4vF5ZY8dB1B4Qurbu+YuUgf/gPCTcwgwandIOI+p9zgEDWcDhbA0bplWbktIKwzN2anB8FGIkXvdrM812QGq11jwc
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570cbbd2-0adc-4c15-8f8b-08df0977cc29
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 04:57:04.0839 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EyQFohLoX48+fmPLM+EZdsZmyvnZzcTPJbqpIenRVvMJR/5Vvujtvcrr8T51cq7hMdszT72xFqN8ZCSHvs0sM5XeaGB35TCPa5FMoS059iQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB8660
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=6997dc6e7=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

T24gVGh1LCAyMDI2LTA3LTMwIGF0IDA0OjMwICswNTMwLCBBYmhpZ3lhbiBLdW1hciB3cm90ZToN
Cj4gdGRhdGFfY3NyX3dyaXRlIGlzIGFwcHJvYWNoYWJsZSBieSBndWVzdCBwcm9ncmFtcy4gSW4g
Y2FzZSBvZg0KPiB1bmFzc2lnbmVkDQo+IHZhbHVlcyB3cml0dGVuIHRvIGEgdGRhdGEgQ1NSIGlu
IGRlYnVnIG1vZGUsIHRoZSBzd2l0Y2gtY2FzZSBmYWxscw0KPiB0aHJvdWdoIHN0cmFpZ2h0IHRv
IGRlZmF1bHQgY2F1c2luZyBhbiBpbW1lZGlhdGUgYWJvcnQuIFRoZSByaXNjLXYNCj4gc3BlYw0K
PiBzYXlzOg0KPiANCj4gwqDCoMKgIEFsbCB0ZGF0YSByZWdpc3RlcnMgZm9sbG93IHdyaXRlLWFu
eS1yZWFkLWxlZ2FsIHNlbWFudGljcy4gSWYgYQ0KPiBkZWJ1Z2dlcg0KPiDCoMKgwqAgd3JpdGVz
IGFuIHVuc3VwcG9ydGVkIGNvbmZpZ3VyYXRpb24sIHRoZSByZWdpc3RlciB3aWxsIHJlYWQgYmFj
aw0KPiBhIHZhbHVlDQo+IMKgwqDCoCB0aGF0IGlzIHN1cHBvcnRlZCAod2hpY2ggbWF5IHNpbXBs
eSBiZSBhIGRpc2FibGVkIHRyaWdnZXIpLiBUaGlzDQo+IG1lYW5zDQo+IMKgwqDCoCB0aGF0IGEg
ZGVidWdnZXIgbXVzdCBhbHdheXMgcmVhZCBiYWNrIHZhbHVlcyBpdCB3cml0ZXMgdG8gdGRhdGEN
Cj4gwqDCoMKgIHJlZ2lzdGVycywgdW5sZXNzIGl0IGFscmVhZHkga25vd3Mgd2hhdCBpcyBzdXBw
b3J0ZWQuDQo+IA0KPiBUaGlzIGZpeCBjb3JyZWN0bHkgZW5zdXJlcyB0aGF0IHRoZSBXQVJMIGJl
aGF2aW91ciBvZiB0ZGF0YSBDU1JzLg0KPiANCj4gRml4ZXM6IGE0MmJkMDAxICgidGFyZ2V0L3Jp
c2N2OiBkZWJ1ZzogRGV0ZXJtaW5lIHRoZSB0cmlnZ2VyIHR5cGUNCj4gZnJvbQ0KPiB0ZGF0YTEu
dHlwZSIpDQo+IFNpZ25lZC1vZmYtYnk6IEFiaGlneWFuIEt1bWFyIDwzMTRhYmhAZ21haWwuY29t
Pg0KDQpUaGFua3MhDQoNCkFwcGxpZWQgdG8gcmlzY3YtdG8tYXBwbHkubmV4dA0KDQpBbGlzdGFp
cg0KDQo+IC0tLQ0KPiDCoHRhcmdldC9yaXNjdi90Y2cvZGVidWcuYyB8IDMgKystDQo+IMKgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL3RhcmdldC9yaXNjdi90Y2cvZGVidWcuYyBiL3RhcmdldC9yaXNjdi90Y2cvZGVidWcu
Yw0KPiBpbmRleCAzYzBmZTcwMTAuLmFlNDkzMjM1ZCAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L3Jp
c2N2L3RjZy9kZWJ1Zy5jDQo+ICsrKyBiL3RhcmdldC9yaXNjdi90Y2cvZGVidWcuYw0KPiBAQCAt
OTEzLDcgKzkxMyw4IEBAIHZvaWQgdGRhdGFfY3NyX3dyaXRlKENQVVJJU0NWU3RhdGUgKmVudiwg
aW50DQo+IHRkYXRhX2luZGV4LCB0YXJnZXRfdWxvbmcgdmFsKQ0KPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0cmlnZ2VyX3R5cGUpOw0KPiDCoMKgwqDCoMKg
wqDCoMKgIGJyZWFrOw0KPiDCoMKgwqDCoCBkZWZhdWx0Og0KPiAtwqDCoMKgwqDCoMKgwqAgZ19h
c3NlcnRfbm90X3JlYWNoZWQoKTsNCj4gK8KgwqDCoMKgwqDCoMKgIHFlbXVfbG9nX21hc2soTE9H
X0dVRVNUX0VSUk9SLCAidHJpZ2dlciB0eXBlOiAlZCBpcw0KPiB1bmFzc2lnbmVkXG4iLA0KPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRyaWdnZXJfdHlwZSk7DQo+IMKgwqDCoMKg
IH0NCj4gwqB9DQo+IMKgDQo=

