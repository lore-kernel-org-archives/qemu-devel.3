Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3923C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 05:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwvGl-00085q-LL; Thu, 20 Aug 2026 01:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=685c7dad1=Alistair.Francis@wdc.com>)
 id 1wwvGb-00084z-O1; Thu, 20 Aug 2026 01:24:41 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=685c7dad1=Alistair.Francis@wdc.com>)
 id 1wwvGX-0008U7-O4; Thu, 20 Aug 2026 01:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1787203477; x=1818739477;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=JkyMptMXWBPtf0ahH0y0xA2Z+D47Ikst/5an0sRqA7M=;
 b=qvfmG+cL081POFgleFePHjHou2911TnthfaUXt2xNyP2ZuXg4ZKQ07v5
 1axWfzqAo/3dp2NKisR0zX/pSAwPlyI4SMGzdJHiz1ds+Ql5j1pPIILHr
 M2us+V132I/RkqidoSxWFbA6va/hqm1PoCiRg3uqvRhiUGFNy4DXVltK8
 WNEfqIji5OMv9JZxtcugn1QGG4WBT+J93hsjwfqFXw3sP/u937KA2xo2M
 V6uysPg9zV/vbjW2xRSNla7kgAHaGQrM/M7vD9+Z9g6sZhUhbO84SMsAu
 JGGH1pfWm7Kqm526B8j27NGHGO/bZo1u166HXvPqSAsvi3LfqmGo8ZY7B A==;
X-CSE-ConnectionGUID: 5917rL2GQba6GOTKH6fNLg==
X-CSE-MsgGUID: 0SqPeUSpSTGaaDBR1bjxBA==
X-IronPort-AV: E=Sophos;i="6.25,232,1779120000"; d="scan'208";a="153666141"
Received: from mail-eastusazon11011026.outbound.protection.outlook.com (HELO
 BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.26])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 20 Aug 2026 13:24:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gk1tm/WuDs6o6+K3h5aU89TVdPVeEXH89QQ5nJphNRDsTsez1WZt14qcgaV3bSZGnJaIHNaUldZiaLdaaomNqvfL11YyDeWxr8ftg9InLkAMeOEU72MjEa6tUKTulNsuXumIbZLO/nZKU+cCWWDBd9ZPPdKMje3MI0W5b3z6OmWomAPl4rJSghsq/tBGLpNJLR0Wl+DK9H1iBImEjNEpVy5o+PyE+vcF2NIgI7HYx78jI3aEeaA8RCOTOcnqbsYk5VY01G5hbxfsAf7N9Aodz0Uguz7WG8dS+oFk2xz6AO3Dc+0QwgkNd2CVfoLa1vgidOCn8EfOKXLcg1W8t51VnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkyMptMXWBPtf0ahH0y0xA2Z+D47Ikst/5an0sRqA7M=;
 b=Dw/XcbhqCd54E3tl83VZxWvIvi9duvVPRCKv+3XzdgiFhtxXsvDThz6EPWJ2DHBbH/SuflprLtGQicZZK5tlwQaMZx37Xsw6/+4gXpJmfuIMaLSUzNuQbSA5Wlg25MewE836Ocx5EPf0zcrVRHV7l2NzYHCAbOxjvydNWBxfW1mw9Ll3ngWW+O8lQXI3QxdbIVDUU9bg5Rv/ldXQ+FH3MXCDd/I9DusryH/rwUtvWtwr1b5G8p1fGlM3j3GoDi77aMo1FB5dd5BMQtM4MqR038mh9ms46/uUiFCrCVq+B4HAh2I5iO8WR36fbJiKDQYV/3nuNBghFQnJdOvx9AFoNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkyMptMXWBPtf0ahH0y0xA2Z+D47Ikst/5an0sRqA7M=;
 b=da+DEPpWDdfHdEeh5903WKd/EbHU++er+vk5OJGqk7QV4fnZQS/tbJrCiwmJnBDOJVGB906R1qpAZPI2BDlvf2o8AlDYfW7W7JamWeXfDgJ+v1MSaaC3cqMMfL6XbDBz6qd8mH1TupdabZDGFjx7ALKW42vQ6/6VcqSleFdLmTs=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by DS2PR04MB994170.namprd04.prod.outlook.com (2603:10b6:8:4ac::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Thu, 20 Aug
 2026 05:24:33 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 05:24:33 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "christianslima@proton.me" <christianslima@proton.me>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] target/riscv/tcg: sret in virtual user mode raises
 virtual instruction exception
Thread-Topic: [PATCH] target/riscv/tcg: sret in virtual user mode raises
 virtual instruction exception
Thread-Index: AQHdJuSqWo6nw7MDSE2HQK1NBB/yY7amepIA
Date: Thu, 20 Aug 2026 05:24:33 +0000
Message-ID: <40b583df87a1eb29791511bbc21c5afc04204189.camel@wdc.com>
References: <20260808031849.59726-1-christianslima@proton.me>
In-Reply-To: <20260808031849.59726-1-christianslima@proton.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|DS2PR04MB994170:EE_
x-ms-office365-filtering-correlation-id: 8e38cb0a-0030-45ec-fed6-08defe7b51a5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|19092799006|366016|376014|10070799003|10067099003|56012099006|3023799007|6133799003|18002099003|22082099003|11063799006|38070700021;
x-microsoft-antispam-message-info: sQWEeXwYKmFj7A8KCW0IOIkAOTJcnsdcwkI1BWsQpzyI/reh+/hpvRrBeStDRMfEDW/DSFa24O5CBw4tGSBK3jXz+eyKK6aEqy3U4wAD5VagCo87qLCOvTSF55W1vANuF0Zf4dVDRtQSGlZVgI99vFDQMxdiwaITc3DEghj2cKAeAIRPcy1aC6CLHDF1vknnyLbU4wFoyDYW7OhbsAWfhx+y1eFuzDU639ihjvy21ro7sA6VG7fIqdR0Ex+My/O3zpLZXXwq+87UyXrrapPZ2Q2zdM3zSdHzNuWt50UeBW+dxryP1awEvwEqlI6h+IMLMWFG99Dij67jmhgQT+210Z0Wma6/a0Sa7OrG2HCh0x48uzHvyPDiI270zQX416I2WwaVYgUbQOJYfALyA/o4DI0C0neygHekWGUHQWW7yFpQpwy4Pmk6irxNsa1Ujma2D0+H7xsBIQAyC7a+ZuP76g5r6NgueEWfT0d8Ow492mdNK8fHlyt1nWbQ1klmCyBBXoPxr1Y79s4uHYFZPB5f2BMZJVkVM0Ylv0SKGLcxMlWHBsn/mBpofdSD9HGCzcPLg+Z97zGLbG75LQjECZsTmSnKiry2Diw5sBkeT6lEm9av89wUN23B8m2JudQHIjbFmNT0R/5ti9LGE0hp+rpZ4gC8pRqsYdfOI1NQCDtZoBQEAGJMEe59wik7Z3w7Yqkor1nSwKgGiSMcnanaM+A4z89oO4Hi1pMxsM5d0aB5Nfw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(19092799006)(366016)(376014)(10070799003)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFNHVU9aakR1eW52cWdoajh4NW1FeXJtQkhuOUIzZzl4dGptWkdDN0ppMzkv?=
 =?utf-8?B?QVQyN1FxSXIzN1lUY2dBdzMrM2lGeGdEN1ZrUjh5WE1JYlVVa2JvUFlDRHdv?=
 =?utf-8?B?bEVhMnhIZUhVeDJ5OXAvQm41aktDcUhlRVdHT2JlNFV6aDUyRFBVY3N6QkMv?=
 =?utf-8?B?Zy9pRDlodWYyMFJub3JqSER5T3RTaW96N1AxOXI1UGpBUmpNRXBleGhHNFRy?=
 =?utf-8?B?dG1ybjRreWtNamU5eGFONkMvbWx2dFJpM0JHcE85ZVZYQVZhekhTOXZ0dGxB?=
 =?utf-8?B?TVF4TEU3MzlhK0U3VUdEWlQ3aGxBWDBibERlR2JiLytmbFYrc3hOdm9pbVdM?=
 =?utf-8?B?aXFFS0ZDRlNrQUxQTlcvc2ZzbSs1K2NMQkc1S2laWjlINXBjZ2NjakU4bXJI?=
 =?utf-8?B?VURZSkIwTERDKzl5VnZ6b1Fta0NvZXhTWVh4bEFTcjk2NUw4YjJvRmlicDZs?=
 =?utf-8?B?UlI2RmVjbnhkRzZHVHZ5R0FSeUlJdCs1eFg5SWRwODlZbkNyRkhhUFNlaUtL?=
 =?utf-8?B?SW9oajhsaElwMDJxSEpDTnVPdG9nM1BudE83VFEvTTVUQ21mZHFoY0cxdVVu?=
 =?utf-8?B?UTRINzV1VjhqdUNLSGFZekFJbitnMVE5eGJyTkRnelpiSitYMmFhQ1hwemxl?=
 =?utf-8?B?VFI3bXdYNGpMYkJtREttUDZNTThCUHBEL29kYjRQOFRyeDhzRnpjTmtBZDNK?=
 =?utf-8?B?WXR4cTJsK3h5UmR2bFNVek5OSWRlYk5KUDNWbmRaU0c3aDVvVGRCWTJIWE8y?=
 =?utf-8?B?Q3ZFbGRnblk4T09hMmV4ZnBDSG9sQmxaTGpOVDNSM1hlbGcyN0d5eTNwd2xm?=
 =?utf-8?B?OWYzQzUyYlRUV1plOTJ4ekNTck95clV6OTE1WlhnVFUxYjlGMzQwNjEwbHdq?=
 =?utf-8?B?aHZCYUpGbkttNkkrd0JGeFZ1TkE0OUVXQTNvdzNPQ1ZQeE12SGhSVVllbzhD?=
 =?utf-8?B?dFVwNEtmT0w1a0RIcS81S2J2cmh4U2N3OGVoVDBtcDhyekRxdktBV2IwM1ZO?=
 =?utf-8?B?QUticlFyZkdpQWhTdy8zdTVkWS9jWmgrMXIycjdXYlBINXg2ZDR6K0ViWHU3?=
 =?utf-8?B?UDNySXhqZU4yTit3YlhXOUtzKzRNRGQ2UHgvWWpIWVRJV1JWcmc4ZFhzVzN4?=
 =?utf-8?B?cFJpT0wwck9qQjJpOSt3WHcrU0VCcThtOGJxaTBvNWMvc2ZyVkwyMkFLcVlM?=
 =?utf-8?B?ckcyMjR1UG1wOHAyTDI2RmVQdkY1cXczNXFtVkdCRHFHL2V0K3JmUmlrR1lx?=
 =?utf-8?B?VGJwOHRsdzN1MWZ1eTNvL09NdmRNcFJxeDZnZHRyblBLak5VWklsNnpCSXZG?=
 =?utf-8?B?Z2xNeFJtYWgvRUxqMEh4VEpheUdkMVk0anZSTzdoMTU2M1Z3VDZta0RWNGVx?=
 =?utf-8?B?eGpuU09MQ1haV0svS3dpbWFOb1RXL0ZGWUpWUVFQNGZZdFlOMnRpczArbDFk?=
 =?utf-8?B?S2xQS0hNUklqOFFYd09zbHV0cE8vVnM5S1RUK2psaHkvNzdLS2toRThjbXNB?=
 =?utf-8?B?Q3RsanpGbmN0SS9MVUJBZE9Wa1IyQ3QrZm5aRjBVU0JPM21IbkVTWmJFSSs0?=
 =?utf-8?B?UFZWSS82SitjTkRRSWxDZzB0cTR3bW5tRmsxSUJCMWdublhhVS92WnRLTUQz?=
 =?utf-8?B?VG1BNlp3RWlhcWIyS3UySEJzdjNtWjlVbzlwdWxMd0pMVkYwNWpYSk5uTSsr?=
 =?utf-8?B?b3hRSG9KdzNvSXhYRGdIOWVIVXBFMEFVb2JXOGlRcURHYzQwc0YrelU5azdE?=
 =?utf-8?B?WEVlTG0yQmV2UEJUTXJHWDI2T0pLOVFISUhXdmhjUFU1WStxb2hvSnZHTjZD?=
 =?utf-8?B?ZmgzWWtrUmozZUJqWmV3aUJ1WjNlWG1DcmZOclFoVFJvZkNlc0h5WjBsVkhG?=
 =?utf-8?B?ZXlpbU9peDd2NWYxZkwxRHp2THJxQUppUWNWcUk4TlRqZUE4UW5Gb1BLbHlt?=
 =?utf-8?B?emxsS1JxYWs2eStJQ1p0V09HVzhqN1RmQ2dJTDkzc2dIbDJ1Mk1aMm5uZzYv?=
 =?utf-8?B?T0tMcEswZTRwaktVSmVPWEwzWCsyRVF4RUpHZ3FkMGV6YnBZYTVQeFlQYU40?=
 =?utf-8?B?THAzMU52K1BiZDRrUzBmZVprMmJJRDRNZ3NpY1FqRFlyNEhRNEF6TWNjQkIz?=
 =?utf-8?B?Vk05WlorSnVjUGV1ejdFd1hOVUJVSGI1Qmx4YlRNK1N3Mk5HOW1sY04vTjZW?=
 =?utf-8?B?MjAzT1VXVTYzakUyOUV6YzRPVjE2NHRrNERISTB4TjBLeVVhQm5mZGJxd2hZ?=
 =?utf-8?B?NkZydXIvTXh1ZDU3RGJRdk95QUpKQjkzNlNYVUYxdG9MbmJuT3M2VkZWdjJ5?=
 =?utf-8?B?NmhNc0FVazh0QTVJVWg5RVBjVEZ0TDZXLzZvUTBtQzVkNW00Q3FMdG1lT1No?=
 =?utf-8?Q?oOLLvOEQp9cvQOyjagbAAClbMevOdLKxEoM9HmW9sboC9?=
x-ms-exchange-antispam-messagedata-1: We8RkzxDi3YdV4qkKviQpH/mMRdmrRHZFMc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE3107FB6D2C8A4F97F80ED5B1C1F91E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gSFPU2vuUW7YVtwhAeoA0uLWp9xLXfTAtzU3QsJfXmPf6Gyx0NNuO+THk63pOKQYOGN9KCPeDP22kAy/ttBL764+9kcotvQf4s8H5na9an9qTQH3UXyZkmMJcgGX2Kkyuh31uO19boea8JRZKDc9JlHkJG7GatGjD+HTM65v+u6UOZG8FJ5RNZCRDf1/SQjYxyX33zfR142/i3jC/qKnk3Rbdk1gxTPCP2JZRDC57FgItFMLhgVUYOXM5HYf7Krc3QQ3DyQpFgiz5Mv04N4XF48hFdSyJAaXz7yIpO8xrngI1VDcx1tLN8pIck3lly55TkEkJByHEOngyLgOS/UWeQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZrO++f8nB7eRZiJXYVOkfh+KdpjJF+zuS17Cz2W2rwbwkp2Y7hkvrgzA8P7Oe2OCCPi/PMxxADgs8sYxtJMibfeZRAGw0tbbR3Wo7v1uBePLREyXMS4UE6V+LIIBEdIyNNJdgtw3pzR+pTMVYup4UstQxdhyX6zwb7SWmPCzXtl9DF8+FI3U/yIzkqXf1yV6S56Jh7fLnzBuvxRwmsRwNwUXC/uXiDnUrEBxXgoj3JlmgZfd3N6yQWzaddinyqxoXb0mUzru0MUoyRqA0oglmlhRkd4heHlyjHGy0NoA88lEvQlYPgHtn3D+r2m8Oj/l9W9i19kiNGV/rZrvp4WWHMj0Sox9WKJWU8DZDWRlhr/kPF4IGVuDVzflUj/4EdPoR7oQJLtLDMPjE2XNuuzuPN0pc3bODkMsNHEYqLZW5lxFGbXBWZnqWNR5i2BfqEyj7oNbRYZCD9kRk8GaZi8to5+pAsZu7PDUjbpwdrlv9ytLKdqI22zygD0nrMWaI2iKgdrCA3GK4n3najB6rtAZoMud1iurp2B8G5iRyyimVvNE4z5xoj5SvCR9i+r+HP5hJAEIcDJIP8cf8TrTCBckvuYUYcqrk1DHudevvXT+eOewAdaA/XwYszsJVheIi53M
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e38cb0a-0030-45ec-fed6-08defe7b51a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 05:24:33.6916 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aNU+ROxapT5c7k3leA0QqhiPlvFc+2qCmGRV4lHi6pDiHaBQfjw9DS/zFosV9U504iifxMdFGqNANH5zxdlkTUUY3sJprW7jigqz97/sSJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR04MB994170
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=685c7dad1=Alistair.Francis@wdc.com;
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

T24gU2F0LCAyMDI2LTA4LTA4IGF0IDAzOjE4ICswMDAwLCBDaHJpc3RpYW4gUy4gTGltYSB3cm90
ZToNCj4gQ3VycmVudGx5LCB3aGVuIGEgYHNyZXRgIGlzIGV4ZWN1dGVkIGluIHZpcnR1YWwgdXNl
ciBtb2RlLCBxZW11DQo+IHJhaXNlIGFuIGBpbGxlZ2FsIGluc3RydWN0aW9uIGV4Y2VwdGlvbmAs
IGJ1dCBpbiB0aGlzIGNhc2UgdGhlDQo+IGNvcnJlY3QNCj4gYmVoYXZpb3IgaXMgdG8gcmFpc2Ug
YSBgdmlydHVhbCBpbnN0cnVjdGlvbiBleGNlcHRpb25gIGFuZCB0aGUgY29kZQ0KPiBhbHJlYWR5
IGNvbnRhaW5zIGEgY2hlY2sgdG8gaXQsIGJ1dCBpdCdzIG5vdCBlbm91Z2ggdG8gY2F0Y2guIFRo
aXMNCj4gcGF0Y2ggaXMgdXNlZnVsIHRvIGltcHJvdmUgdGhlIGNvcnJlY3RuZXNzIG9mIHRoZSB2
aXJ0dWFsaXphdGlvbiBvZg0KPiB0aGUgcmlzYyB2IGFyY2hpdGVjdHVyZS4NCj4gDQo+IFJlc29s
dmVzOiBodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS93b3JrX2l0ZW1zLzM2
MjINCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBTLiBMaW1hIDxjaHJpc3RpYW5zbGlt
YUBwcm90b24ubWU+DQoNClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5m
cmFuY2lzQHdkYy5jb20+DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IMKgdGFyZ2V0L3Jpc2N2L3Rj
Zy9vcF9oZWxwZXIuYyB8IDggKysrKy0tLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi90
Y2cvb3BfaGVscGVyLmMNCj4gYi90YXJnZXQvcmlzY3YvdGNnL29wX2hlbHBlci5jDQo+IGluZGV4
IGJhM2M3ZGEzNzUuLjQyOWE2MTg2YTcgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9yaXNjdi90Y2cv
b3BfaGVscGVyLmMNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L3RjZy9vcF9oZWxwZXIuYw0KPiBAQCAt
MjkzLDYgKzI5MywxMCBAQCB0YXJnZXRfdWxvbmcgaGVscGVyX3NyZXQoQ1BVUklTQ1ZTdGF0ZSAq
ZW52KQ0KPiDCoMKgwqDCoCBjb25zdCBwcml2aWxlZ2VfbW9kZV90IHNyY19wcml2ID0gZW52LT5w
cml2Ow0KPiDCoMKgwqDCoCBjb25zdCBib29sIHNyY192aXJ0ID0gZW52LT52aXJ0X2VuYWJsZWQ7
DQo+IMKgDQo+ICvCoMKgwqAgaWYgKChlbnYtPnZpcnRfZW5hYmxlZCAmJiBlbnYtPnByaXYgPCBQ
UlZfUykgfHwgKGVudi0NCj4gPnZpcnRfZW5hYmxlZCAmJiBnZXRfZmllbGQoZW52LT5oc3RhdHVz
LCBIU1RBVFVTX1ZUU1IpKSkgew0KPiArwqDCoMKgwqDCoMKgwqAgcmlzY3ZfcmFpc2VfZXhjZXB0
aW9uKGVudiwNCj4gUklTQ1ZfRVhDUF9WSVJUX0lOU1RSVUNUSU9OX0ZBVUxULCBHRVRQQygpKTsN
Cj4gK8KgwqDCoCB9DQo+ICsNCj4gwqDCoMKgwqAgaWYgKCEoZW52LT5wcml2ID49IFBSVl9TKSkg
ew0KPiDCoMKgwqDCoMKgwqDCoMKgIHJpc2N2X3JhaXNlX2V4Y2VwdGlvbihlbnYsIFJJU0NWX0VY
Q1BfSUxMRUdBTF9JTlNULA0KPiBHRVRQQygpKTsNCj4gwqDCoMKgwqAgfQ0KPiBAQCAtMzA4LDEw
ICszMTIsNiBAQCB0YXJnZXRfdWxvbmcgaGVscGVyX3NyZXQoQ1BVUklTQ1ZTdGF0ZSAqZW52KQ0K
PiDCoMKgwqDCoMKgwqDCoMKgIHJpc2N2X3JhaXNlX2V4Y2VwdGlvbihlbnYsIFJJU0NWX0VYQ1Bf
SUxMRUdBTF9JTlNULA0KPiBHRVRQQygpKTsNCj4gwqDCoMKgwqAgfQ0KPiDCoA0KPiAtwqDCoMKg
IGlmIChlbnYtPnZpcnRfZW5hYmxlZCAmJiBnZXRfZmllbGQoZW52LT5oc3RhdHVzLCBIU1RBVFVT
X1ZUU1IpKQ0KPiB7DQo+IC3CoMKgwqDCoMKgwqDCoCByaXNjdl9yYWlzZV9leGNlcHRpb24oZW52
LA0KPiBSSVNDVl9FWENQX1ZJUlRfSU5TVFJVQ1RJT05fRkFVTFQsIEdFVFBDKCkpOw0KPiAtwqDC
oMKgIH0NCj4gLQ0KPiDCoMKgwqDCoCBtc3RhdHVzID0gZW52LT5tc3RhdHVzOw0KPiDCoMKgwqDC
oCBwcmV2X3ByaXYgPSBnZXRfZmllbGQobXN0YXR1cywgTVNUQVRVU19TUFApOw0KPiDCoMKgwqDC
oCBtc3RhdHVzID0gc2V0X2ZpZWxkKG1zdGF0dXMsIE1TVEFUVVNfU0lFLA0K

