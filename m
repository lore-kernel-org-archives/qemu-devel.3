Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E64FD9E25
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 23:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvl7O-000692-20; Thu, 26 Feb 2026 18:50:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=510b84ec3=Alistair.Francis@wdc.com>)
 id 1vvl7K-00067x-BT; Thu, 26 Feb 2026 18:50:03 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=510b84ec3=Alistair.Francis@wdc.com>)
 id 1vvl7G-0001ZR-Tl; Thu, 26 Feb 2026 18:50:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1772149797; x=1803685797;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=CQ0ik58tqU9fmHfdjLLOTXcVtcGoZt9f9XNOirxKDNg=;
 b=mIKBiuxZRtTtCFqdRkIjVxceFFrAUusyJvop6BqHDmNCeHvmhaQ6rPd1
 Dyek7pJmnSiActMLbInbJ9z2Ezwsn4cxfbgLxhWCXUXGvLZf1hVZONw+E
 pMsmuc0F4WbXtYmoG2Wgz55PlPH4Zj2x4O08hUqegfD6fdRkAFFiUFt30
 vcuT3hb7Gp+3QLqnDIbBGqk9bHarzRT55A9GvWwCj96L6eqzQoVs0DBpk
 7DjR3E1MOh3GnYQOotRWJ0zLAIC+HtvSBXvBT/Q6hBWYMLxEs3ktE7kgK
 hfjH4OHy479T1BZc6rWOP9j8lGBtlAE6747temO9Wuw4F0MP3K/1A6V9M A==;
X-CSE-ConnectionGUID: GllF3kSgRp20v0/Hyu6wMQ==
X-CSE-MsgGUID: ZVn95RbFQh6RvpZ0+EKnjg==
X-IronPort-AV: E=Sophos;i="6.21,313,1763395200"; d="scan'208";a="142103890"
Received: from mail-eastus2azon11010048.outbound.protection.outlook.com (HELO
 BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.48])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Feb 2026 07:49:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T95Qy3LKzeL2vwT3ja7gfiwqFGuvXHwBRTnOgCPeMwe1bC5nJmPqdMmt+FdG0l1uvh0/7byGvYgZe95HLZGrIjnXQ+0ABWEQhh1RAbCzBNKrDPDWv1STu7HgxjnwBh6POcp4azWJcpypnrCV1JR+HVEVWzIHwVKT+zbLRqvMdpFOGQyYlTpuRqVBz2G4hZn5rK0f6lQBFmPYsmNX61zhWTmdpp9yk6uE7mmTA4VM8UM4DE+UTDy/mHleISle/sjwEmHjFiLllnJYCo69L0kEZPa38kF6QFVrOD3FJiiD0xtHa0rbPaP5suDCsbb9/AOME4HusV//6BnjhN5mYvGZ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQ0ik58tqU9fmHfdjLLOTXcVtcGoZt9f9XNOirxKDNg=;
 b=Hwc6vpywtsI+ZW7bQx4FYDRsD7EvVD7BWqOfI1mBnAlTwR7tSBcQm7v13RpVx71kqLHUvC9nJ3LuOqTPKQSVLYKmA0vBK44uLFGDNkPxjKTofbmeV1NbLaAi9Of8CJ5BKsNNTiNKW0CPNWOfjWFeMUdBELT17j6oBDlZy31Rs7VcvVmNgFDRkF+L/Jn8pBitBhoYO+sPMeVVzmCFylIgk91iqDzf4JiR45661uIpSyM0irVrIOPiCISYnW3KvJ2wK39fJJr5qeA8Z6ZM29dxfcQ0L5d8FrdlXeuzngiB+JpSvmLrYGS0paKplu2iSOTPSdpydyo0nz5SlDJRNuMODQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQ0ik58tqU9fmHfdjLLOTXcVtcGoZt9f9XNOirxKDNg=;
 b=Q0g+f3fHSj5d/2cPNUi48kQH/Yix1FqO7oUVhr/eSb/AGrzX3XdkMN0vdWfDeCWHtKm/XEdFni+gHFyrwBc6/TuI4ksVtfJ50qRrmAvP0BbF63FIlZeap+nElh5b/F8sY5lLqd9EJ/8Hh7umA2SPDdgfCcbvSeBeMfNy+tVCAWE=
Received: from SA1PR04MB9849.namprd04.prod.outlook.com (2603:10b6:806:4a3::15)
 by CH2PR04MB6997.namprd04.prod.outlook.com (2603:10b6:610:9d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 23:49:52 +0000
Received: from SA1PR04MB9849.namprd04.prod.outlook.com
 ([fe80::705f:2ac8:b2ff:f845]) by SA1PR04MB9849.namprd04.prod.outlook.com
 ([fe80::705f:2ac8:b2ff:f845%7]) with mapi id 15.20.9654.007; Thu, 26 Feb 2026
 23:49:52 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "lex.bailey@lowrisc.org" <lex.bailey@lowrisc.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "amitkh@google.com" <amitkh@google.com>, "qemu-maintainers@lowrisc.org"
 <qemu-maintainers@lowrisc.org>, "philmd@linaro.org" <philmd@linaro.org>,
 "alistair@alistair23.me" <alistair@alistair23.me>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "dave@treblig.org"
 <dave@treblig.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>
Subject: Re: [PATCH qemu 01/11] [ot] target/riscv: rename ibex hart as
 lowrisc-ibex
Thread-Topic: [PATCH qemu 01/11] [ot] target/riscv: rename ibex hart as
 lowrisc-ibex
Thread-Index: AQHconoV90+eD4uu4UyXuwzEwRB1H7WVsD2A
Date: Thu, 26 Feb 2026 23:49:52 +0000
Message-ID: <612091045f67dc0b4b8b1743842e28dbf7019b61.camel@wdc.com>
References: <177159976712.8279.7732381632410882915-1@git.sr.ht>
In-Reply-To: <177159976712.8279.7732381632410882915-1@git.sr.ht>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.58.3 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR04MB9849:EE_|CH2PR04MB6997:EE_
x-ms-office365-filtering-correlation-id: 6bd9b988-fdaf-494c-e7a2-08de7591bc91
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|7416014|10070799003|376014|366016|38070700021;
x-microsoft-antispam-message-info: TS5iQGRxNUewQX7J16/YHkwZokBjCWz8W5M48gg7nlLt6UXKiE3zECVpwvrwJMpJCKkq35oy0ypMQyWGZBFcrml5ugFIuuOEGsV9bXkOI0UvhkO+0Dh5w9Pn2R5Wey/4QGCBSpPCD7DHKF4BIcAdjYIfJbW3+1U6gsEufOxe8uhihGj2mOTAiCuGX/cDlJNYBc6woSUIhROLPRbR3Q1ZwgcD17RVgr/wHiRfiVG2YfK2Chj9Z+erarx/ebQuX+WcfcdE7wD4a+r71RnGDtMq0xjQ/gOndEoDeQ9pde5/VgE8gfFBIsPrCMx8ELKlpEdA+6g4/+ZPnP3YggeWJCl2RyShd0WXuZxcl0BxSU1aYTJ+NWz3r+DZx1Ex3HGUpXF4ASpUZuQI206J+61G9ixnCfKwkQRev1XYuaK6m4k0Z+si5uZNsM+Jrz1466nvRJKKbRg1VCfwn6nXNCQsrTu3nQXRY1NwH6XdGO0/HYUhB3+BUxsoeKNgcsmS3PjMDZSBBTlsP7x6O3hXitMYv3PRj2Op0ZBXHFQfj29NiE+gnuw1Qt0rVdjwel3qxOll/AADPz0weqHqXcAM0URbBIp6zP79I/wm9jdIkEyvQmwctlGXYtH8fJ5awq7MhUlSNeuK85cL9w189ZCBBOygEPmXQL1JB84uLf2zrOIJr6t3A2q4HvBq0fUeu/qykgIAZQ4urV9TiQldKdGLi3RvlF8FSxDOab6PfkZxGv0fM8vzopDmIiV8+hJ1Fd0EVHtyTKoT8JfRJkip1ADVCejR1nGTTM6hCHsfa8cb+GygDTq+dWM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR04MB9849.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(7416014)(10070799003)(376014)(366016)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVpDcnJyZmk2RkhLcFhjeXhxYzlDeFI3N1Z3anVSZ2RaTnU1S1hUMm05WkNn?=
 =?utf-8?B?dGN2TENlbytQSFFWbkF2bnc4NExlL09WQTBrVTZDWmMyQ1REV0N1YkJmQkI0?=
 =?utf-8?B?UWpqS1I0RVpGT05UMkZNa0JFWDhPYzVPaC9JcjhuM252S2tQVHk4bFdPZEZq?=
 =?utf-8?B?d0U5MytnYjlpN2dITkVmdzNPWlMwRWNnVlp0cGdYeE14R2tvUi9Xb0VYcGhj?=
 =?utf-8?B?aFRJLzJ4UEZ2ZEZGaHV2NS9EeDA4LzNPYlFqZnVtS1h3UHhuZG1SRjhnTlg4?=
 =?utf-8?B?ajBXUTFMQm5NTExCRXM4bkUrV0xjNlpIVjJvMC9vUTR6c0tScDRnTUxQOFov?=
 =?utf-8?B?NGdJZWM2ZFpVTVhDQlQvZG5STnV5SVFkTEZGdGdxb1FUWFhlMFVhUGMzYUNr?=
 =?utf-8?B?MzBiVjdMZGZLU2Z1WnJmVThEaGNxUWdxTXJ1Nm9ySVJILzVHT3JPRWFjQW5i?=
 =?utf-8?B?bDR0Ynd1NTJRZE5zM2l5dmNhYmIvOElsdHp6Y3gvVmJtOU9KekNPQ3NtTmdR?=
 =?utf-8?B?RWVSRE4rWmc2R3kzZmNRQjhuQkVrRmdYREVlRkg4NUxzREtscitIUVZqc2pE?=
 =?utf-8?B?TWlORkN4ZXM0NnZhcU4rZWM0d1BIL3oyWlJTZmY0QUFLczlEbTVWTWdiaUx1?=
 =?utf-8?B?UnJUSmF2YlJVUXBUVEwwWVhPTElMaSs2SDhVZ2paSFIvZk5KNm5hanFJT3Q0?=
 =?utf-8?B?eGJ0WDBiVXZLbmV3dUZJdDExTjVTVjJnWk9RU0w2eTRSSHFvTjFmM0lXTkla?=
 =?utf-8?B?WDF0MTV5Z0lzUlBmWjhXNjI3cThWUXNoWSszb1M2UEtBMDBwUjdvTlBsenhX?=
 =?utf-8?B?a3RNNlFCZ3JCL2xzQnJwS1pYR0NpWVdhbFdHQjR5dnloS1E5MjRkT28vc0ov?=
 =?utf-8?B?U0w0Sm1pYlJSU3pSeHY4UCtXcUs5K0ZVVUhXUW56RjZIeTVKK1NpTWhnTlpm?=
 =?utf-8?B?akdjVkdXSDFOQVVLZXVnS3laTGkxbHhjRzBMc29vUE1NbjlWalA3QXV5VjIw?=
 =?utf-8?B?MkJlczMyMU5Xd3crTDNaZ0UzaHhCWnlQRWNNdnRoeDR6RVlvZ2hEazkvZnpW?=
 =?utf-8?B?aXc1QXFvdTg1a3F5Q1JpbExlb2Z0S2JueUZ3eUM4emJGZE0xZ3hMTVRsOVlz?=
 =?utf-8?B?UGRGRitXYWhQdDZBQ2hndnV4Smlrem5tbXhtTzdXK2NwUlduNCtGZExXRGVh?=
 =?utf-8?B?SkVYa2MxNmRzN1BXYndUTXRkQVFocGtTQm9mQTlkU1pMaEVqUGtqRlVHYm1V?=
 =?utf-8?B?UXNPUFFXOGtaZjJYbU5QdTBkSFArV0x0TTNMT1BFUUdKYzg1ZFVJMjdFKzBZ?=
 =?utf-8?B?TjhrUklFTkdjZlNERGFxWEVPZ1ZjN2ptM3IzODB5cjZGSzQ2SVhWWWNZWWxW?=
 =?utf-8?B?WEpTU05lbXFvaEJZVEJGeXQrUzduVE9nL1E1ODg4T0RkTE9iVlA0dkM1U1Iz?=
 =?utf-8?B?OSt2cWhsOUlDd1lMWHFVK3FaVDNFL0hCSGJEZUZrVmRlWlg5Vjd2RWF0dzcw?=
 =?utf-8?B?UFVsNUI5bFZIVHRjSlRzeXpwb1dlVTBBRHl0N0tyRnEra0NsaUJEanpJVGhD?=
 =?utf-8?B?TWh6L1dyY000b1o0MWY4dWNHVkU5VWRCd2pOVHRFTkpqd1BPa3FzUllkZ2pZ?=
 =?utf-8?B?S2xwNm5GMWd4QUpyUC8zVW4vTWVRTVRvMVR6MDZwWWRXU3liRGRxUUxsNTFt?=
 =?utf-8?B?akJQWDdOclFqWVE5blVRQ0d4VFdzaXI5TG5HbWVsZi9YU0t1SjEvYWVoK3Nr?=
 =?utf-8?B?bmtUTmRsN2Y5NXZvYTVMTTVmRVYyNXdlaktCaTd0dVhEUXlhUkFUMVQzSVpU?=
 =?utf-8?B?d2kxT2dzQWIzTDEvMVFCd29xMmg3MDFtbHZnbk5pSkZoNXFBNnhBRTR5Rk9E?=
 =?utf-8?B?UEl5djBHOVNWN2xrUmN2SENRV01jSmtISHk3OEV3S0F5bHlGYVgxWS9ZSXBR?=
 =?utf-8?B?NUpVRnlGRjI3RTJ0eHdtbFVUd1pISUR3MlVrTCtsVG9rdlpJcytoQUEyR25m?=
 =?utf-8?B?aVRKWVp4eEEwMXVVOWhzM0tLeTM2eW9EU2MyMzVYelhWMlE5cXRkdlBYcjh0?=
 =?utf-8?B?L0ltajIwejNGVWFxdHhWM3Nqem5SZ202QklmSGp3V2NXSmxqY0RNNGxMUXJ4?=
 =?utf-8?B?NzNDVlhGN2JxMUhiTzNBSlg5Z3RwQmI3QkZaTkZWVkxuTjFPV2Izd2dDS01B?=
 =?utf-8?B?a1htNFhPUlQwMGIxSzMrY3ZYcThvaUNFUEdLQmN6MkdkM09jcVUyRUh3ZFBK?=
 =?utf-8?B?ejIxQVVBQ1l5cDY1bUtacnByOHQvMlFHL0tGck9vOExmMFluNVpvS2g4Wjh5?=
 =?utf-8?B?bHdLS1Y5RXNhWHBudytiNVI0S1Z0KzcycWRsMW9DQ3RwSW8vTlJodjJEOWhn?=
 =?utf-8?Q?a3XDq3gqqRIMJvpRhT//X5XA83vVwuWUDmPotIwSLF/v6?=
x-ms-exchange-antispam-messagedata-1: 1Pj/cqlGzAm3zS4NA1ysasF30agJke/gdic=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B66F7F855F4A040969DFB9E9852781B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: epa1UHAAR60e+eAdMbEgVy8CwLOdjsKg2MmUAQlO95DWNmSLmTVT5bQ2l8wnyWCojgaiZ6CjtHQ1cu3kljRplm3EZynUgWGyHQROzXsdg5BxZ+kjm7jBS5EPT1ZbVGIAhS8Mgc1BcD5cJYTH6qI84MNy4qG0eG0pT+ahpVX7GLuj6aDJsDmaYBdennriSsx8hHSWXM3DVIqxas1jYPt4ypfyq0g5OU+FnSaf42SnkCq8WyXW9fnRbROaGDS48zb01zzWhDHer3j5rYCtVSsGUI/bkLd4aXW35qjk/He6pNZd90jVYYUWVR2wixCsA9ZxDYTNXKLVf/uTaXU11wQJKC8vMq+H9gPVih12+fKJvAi7txo7Wm2WBPjqlIR2Rcx0BA/fbt+yuZLDQ9kUdpo1UL+mJdzXMSu4C35OsajzfZxyuzaxectLPNZx4ScAFKCfqFaJrgJqOnEr9SU5ICEV2GVSOWAV7Qe3jZ3FupM1U4Y27OvgXJUQ7tNdDH+wwSnRtdpv3Bwh6bpfdvjyiEDE4DIXmlpd+nv6ptSJE4v/yjpoybYBdmKKgMDP51c8CNTToVI33CnfAlhKkDz0V1vWnLZHzL1So0Qng3U44HZmDGmO+lAahe9Hf4wkBzq6k6zy
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB9849.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd9b988-fdaf-494c-e7a2-08de7591bc91
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 23:49:52.7321 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vQquL3MvQ0SGLpC/caCwoKCwNg+HYlTKRq5OJR6WstEylc1brNvI/U0NxzrF8GvubA57RSFLNGh22wIOkAe27vFa7du7/AozUPoRsrTnmDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6997
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=510b84ec3=Alistair.Francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668, SPF_HELO_PASS=-0.001,
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

T24gVGh1LCAyMDIzLTA0LTI3IGF0IDE5OjM5ICswMjAwLCB+bGV4YmFpbGV5bG93cmlzYyB3cm90
ZToNCj4gRnJvbTogRW1tYW51ZWwgQmxvdCA8ZWJsb3RAcml2b3NpbmMuY29tPg0KPiANCj4gRm9s
bG93IHZlbmRvci1kZXZpY2Ugc3ludGF4IHVzZWQgd2l0aCBvdGhlciBSSVNDViBjb3Jlcw0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogRW1tYW51ZWwgQmxvdCA8ZWJsb3RAcml2b3NpbmMuY29tPg0KDQpN
aXNzaW5nIFNvQg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoGh3L3Jpc2N2L29wZW50aXRhbi5j
wqDCoCB8IDIgKy0NCj4gwqB0YXJnZXQvcmlzY3YvY3B1LXFvbS5oIHwgMiArLQ0KPiDCoHRhcmdl
dC9yaXNjdi9jcHUuY8KgwqDCoMKgIHwgMiArLQ0KPiDCoDMgZmlsZXMgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L3Jpc2N2L29w
ZW50aXRhbi5jIGIvaHcvcmlzY3Yvb3BlbnRpdGFuLmMNCj4gaW5kZXggMzA5MTI1ZTg1NC4uMTlj
YjM1YjM1MSAxMDA2NDQNCj4gLS0tIGEvaHcvcmlzY3Yvb3BlbnRpdGFuLmMNCj4gKysrIGIvaHcv
cmlzY3Yvb3BlbnRpdGFuLmMNCj4gQEAgLTExOSw3ICsxMTksNyBAQCBzdGF0aWMgdm9pZA0KPiBv
cGVudGl0YW5fbWFjaGluZV9jbGFzc19pbml0KE9iamVjdENsYXNzICpvYywgY29uc3Qgdm9pZCAq
ZGF0YSkNCj4gwqDCoMKgwqAgbWMtPmRlc2MgPSAiUklTQy1WIEJvYXJkIGNvbXBhdGlibGUgd2l0
aCBPcGVuVGl0YW4iOw0KPiDCoMKgwqDCoCBtYy0+aW5pdCA9IG9wZW50aXRhbl9tYWNoaW5lX2lu
aXQ7DQo+IMKgwqDCoMKgIG1jLT5tYXhfY3B1cyA9IDE7DQo+IC3CoMKgwqAgbWMtPmRlZmF1bHRf
Y3B1X3R5cGUgPSBUWVBFX1JJU0NWX0NQVV9JQkVYOw0KPiArwqDCoMKgIG1jLT5kZWZhdWx0X2Nw
dV90eXBlID0gVFlQRV9SSVNDVl9DUFVfTE9XUklTQ19JQkVYOw0KPiDCoMKgwqDCoCBtYy0+ZGVm
YXVsdF9yYW1faWQgPSAicmlzY3YubG93cmlzYy5pYmV4LnJhbSI7DQo+IMKgwqDCoMKgIG1jLT5k
ZWZhdWx0X3JhbV9zaXplID0gaWJleF9tZW1tYXBbSUJFWF9ERVZfUkFNXS5zaXplOw0KPiDCoH0N
Cj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9jcHUtcW9tLmggYi90YXJnZXQvcmlzY3YvY3B1
LXFvbS5oDQo+IGluZGV4IDMwZGNkY2ZhYWUuLjNhNjM5NGZkMTEgMTAwNjQ0DQo+IC0tLSBhL3Rh
cmdldC9yaXNjdi9jcHUtcW9tLmgNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2NwdS1xb20uaA0KPiBA
QCAtNDIsNyArNDIsNyBAQA0KPiDCoCNkZWZpbmUgVFlQRV9SSVNDVl9DUFVfUlZBMjJTNjTCoMKg
wqDCoMKgwqDCoMKgDQo+IFJJU0NWX0NQVV9UWVBFX05BTUUoInJ2YTIyczY0IikNCj4gwqAjZGVm
aW5lIFRZUEVfUklTQ1ZfQ1BVX1JWQTIzVTY0wqDCoMKgwqDCoMKgwqDCoA0KPiBSSVNDVl9DUFVf
VFlQRV9OQU1FKCJydmEyM3U2NCIpDQo+IMKgI2RlZmluZSBUWVBFX1JJU0NWX0NQVV9SVkEyM1M2
NMKgwqDCoMKgwqDCoMKgwqANCj4gUklTQ1ZfQ1BVX1RZUEVfTkFNRSgicnZhMjNzNjQiKQ0KPiAt
I2RlZmluZSBUWVBFX1JJU0NWX0NQVV9JQkVYwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgDQo+IFJJ
U0NWX0NQVV9UWVBFX05BTUUoImxvd3Jpc2MtaWJleCIpDQo+ICsjZGVmaW5lIFRZUEVfUklTQ1Zf
Q1BVX0xPV1JJU0NfSUJFWMKgwqDCoMKgDQo+IFJJU0NWX0NQVV9UWVBFX05BTUUoImxvd3Jpc2Mt
aWJleCIpDQo+IMKgI2RlZmluZSBUWVBFX1JJU0NWX0NQVV9TSEFLVElfQ8KgwqDCoMKgwqDCoMKg
wqAgUklTQ1ZfQ1BVX1RZUEVfTkFNRSgic2hha3RpLQ0KPiBjIikNCj4gwqAjZGVmaW5lIFRZUEVf
UklTQ1ZfQ1BVX1NJRklWRV9FwqDCoMKgwqDCoMKgwqDCoCBSSVNDVl9DUFVfVFlQRV9OQU1FKCJz
aWZpdmUtDQo+IGUiKQ0KPiDCoCNkZWZpbmUgVFlQRV9SSVNDVl9DUFVfU0lGSVZFX0UzMcKgwqDC
oMKgwqDCoCBSSVNDVl9DUFVfVFlQRV9OQU1FKCJzaWZpdmUtDQo+IGUzMSIpDQo+IGRpZmYgLS1n
aXQgYS90YXJnZXQvcmlzY3YvY3B1LmMgYi90YXJnZXQvcmlzY3YvY3B1LmMNCj4gaW5kZXggZTU2
NDcwYTM3NC4uMjRhNGMyZmQzZiAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L2NwdS5jDQo+
ICsrKyBiL3RhcmdldC9yaXNjdi9jcHUuYw0KPiBAQCAtMzA0Myw3ICszMDQzLDcgQEAgc3RhdGlj
IGNvbnN0IFR5cGVJbmZvIHJpc2N2X2NwdV90eXBlX2luZm9zW10gPQ0KPiB7DQo+IMKgwqDCoMKg
wqDCoMKgwqAgLm1pc2FfbXhsX21heCA9IE1YTF9SVjMyLA0KPiDCoMKgwqDCoCApLA0KPiDCoA0K
PiAtwqDCoMKgIERFRklORV9SSVNDVl9DUFUoVFlQRV9SSVNDVl9DUFVfSUJFWCwgVFlQRV9SSVND
Vl9WRU5ET1JfQ1BVLA0KPiArwqDCoMKgIERFRklORV9SSVNDVl9DUFUoVFlQRV9SSVNDVl9DUFVf
TE9XUklTQ19JQkVYLA0KPiBUWVBFX1JJU0NWX1ZFTkRPUl9DUFUsDQo+IMKgwqDCoMKgwqDCoMKg
wqAgLm1pc2FfbXhsX21heCA9IE1YTF9SVjMyLA0KPiDCoMKgwqDCoMKgwqDCoMKgIC5taXNhX2V4
dCA9IFJWSSB8IFJWTSB8IFJWQyB8IFJWVSwNCj4gwqDCoMKgwqDCoMKgwqDCoCAucHJpdl9zcGVj
ID0gUFJJVl9WRVJTSU9OXzFfMTJfMCwNCg==

