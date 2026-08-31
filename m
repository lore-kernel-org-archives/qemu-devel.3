Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC57C61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 01:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0qbK-000872-AC; Sun, 30 Aug 2026 21:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=696fae14a=Alistair.Francis@wdc.com>)
 id 1x0qbI-00086d-HX; Sun, 30 Aug 2026 21:14:16 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=696fae14a=Alistair.Francis@wdc.com>)
 id 1x0qbG-0007qG-MB; Sun, 30 Aug 2026 21:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788138854; x=1819674854;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=LI+akSOjdiihQpC40NtFxcK6ss1ZtK3v/KPPQb7OFyY=;
 b=VHeeOPPtWvOW8q7yNw0L/q0f52XMpnmIh3yuTUzw1y5m8f5QGh5HqYgf
 i6H9rnOOMRzjDbSDr7IdKPGrmox2i/ShLKZeyRt8QYuMBfh26NieKq0xw
 o/YwW64jgGdT1ai1uCXBkPOYCEx32wmjzi8mpZrc7sIhjA90QzsS4ozYq
 +llcWqFsroNkoDh1BJAZNq/aVF2rGDb7a6nkJ5TQiuBiMrl82EsWjItXU
 NFn5tWVLO2PfXdGfKC5dK9clalyd+Jfxxkbkm6GuRbT5x9z3LIkKEuKzj
 kc7ZjjTiJKDVnOh90ato6JlPVB0+EWyfOcVcvS6F8O8dJc1rR6I0imP+o A==;
X-CSE-ConnectionGUID: mBD5NHSBT5aSZEwLOZpXeg==
X-CSE-MsgGUID: e7k7pbaWRAilKGzbPON4GQ==
X-IronPort-AV: E=Sophos;i="6.25,252,1779120000"; d="scan'208";a="155504321"
Received: from mail-westcentralusazon11013022.outbound.protection.outlook.com
 (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.22])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 31 Aug 2026 09:14:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJTdcxIBu2GuJvR3O7GYcf1tGLKJToky77Za6SJRvZ+7qEPK1IHmZlqUyOzB8fGbWoCk5Yn+4BRvvQtT6EFgofnJ9fD8sPYPzpeLfCoYqgwbGR0r18a+RaJXnefM+RqE8AqK10bLWQgTWo4SegTcVHf+xuMAyYn9AHmXplogKWRwKssbdCQ/QDejr+mIZsGajtGe1/7rYroA1YgEydP5XXRE1cfdK2y7Ynd+OWlOJLdrToVjbbnUb5lPJwDIqK6UZCtadAfclgd/yG7Fx+nsA0GqBOcuajRl1kfsotiMZlYNK/KJQ52s9nLq73LLbVjUwpGI33ug73RfTnWe4hET2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LI+akSOjdiihQpC40NtFxcK6ss1ZtK3v/KPPQb7OFyY=;
 b=XpLu7XD/0RO33GxI9YSnn/cI+YazUnSbwut4+PwkneMl22B0RLQ4uiht1s23Pm6BL1wf14L2fXcATP8mOy3wy7xUdO+YSEac33S8QoqkpQkoJNKSN/weEKYTuiNpIoie5UYzHwHlHvpfkjk33/fzlhU3Eblb3IY9rXDWvJKShMyQW8mf/Y0xj1V81XMFQ5vWI9tjW6410iDsHJkGdevagLSymiDGqK4j7cOPUupJgmDRzp8Q9grwI28Dgr8kMIlpVQjiKWyvCKbbVYToO4GIsPx92ZDd+OVU39TMd8fHtECx6oDYRvO3/prBKB14d9gHYT8Oom0/z42eiKAjjn4P0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LI+akSOjdiihQpC40NtFxcK6ss1ZtK3v/KPPQb7OFyY=;
 b=gZco0WVN/CeEshkCw5gWKq4pCfw2K1K8Uqb++UR2DOJaD5VO90e8hKkLrmLf/8a28tN1LxDfHwDiitgy8o0m5ZjPFSclZ823XIxL8eR+ED4GckoVm8xMmHVzXx2rf1dQ8yVzuSpjywGfoORw+fpVK0UMdUfzagY6rNFapvagDrI=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by LV2PR04MB993975.namprd04.prod.outlook.com (2603:10b6:408:36c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 01:14:09 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 01:14:08 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "joel@jms.id.au"
 <joel@jms.id.au>
CC: "npiggin@gmail.com" <npiggin@gmail.com>, "mpe@kernel.org"
 <mpe@kernel.org>, "portias@oss.tenstorrent.com"
 <portias@oss.tenstorrent.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "asrinivasan@oss.tenstorrent.com" <asrinivasan@oss.tenstorrent.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>
Subject: Re: [PATCH 04/12] tests/tcg/riscv64: Update semihosting linker script
Thread-Topic: [PATCH 04/12] tests/tcg/riscv64: Update semihosting linker script
Thread-Index: AQHdNeJqumW5Fvey50ePpd3F0HNc4ba3YEEA
Date: Mon, 31 Aug 2026 01:14:08 +0000
Message-ID: <21db8838b7fcfd4c40fe06efa7b15f700cc0d254.camel@wdc.com>
References: <20260827050953.67184-1-joel@jms.id.au>
 <20260827050953.67184-5-joel@jms.id.au>
In-Reply-To: <20260827050953.67184-5-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|LV2PR04MB993975:EE_
x-ms-office365-filtering-correlation-id: 7de35b8b-b8c9-4b19-021a-08df06fd28a6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|23010399003|10070799003|376014|7416014|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: zGrDKJOGUoF9OoheRzOgEmvi7O2iBPygLNFsQevA2RxaVVJPTpGAyONO2iKarVzvJqIhvGs4G2NHKTJQY6/Tr9satmsJwHELNUYagKUaUNwYkECAMBkOuAa74mCNKKl++MPk5hXvzeKUbPB6IwZ1zPu1IDi1swgbjRLQdq6Gzw4au9sgcID8UJzWcW5bJRtwGXQ+bgDqDOnVJ6f3pW9K1g8PD/GxL8sCaSZbdk1ZHqT91WPqyAsX8eixLVtJnsZ4Dw5Q9e3ejp3p5NHFbvUokh5KGYoz939QooQQlLyJU2lQ/uEYpuOg4is3TnN2vM7dEFwsFibHzSyCKYvBLISGibU6IjWmsJDSttxvPXiLZimBCegQrE34tW4nKODzY1cjdtb30Gy+jgkPzasGhCcaBx8W1z+kQBg7UzmN8/MFOVFAPDhvq/RYN6Yv+mDlaZinL+bQ4BU2fLwCInRLwEVpa6bL1YT5I3VAD4GJmSsUxwS07FQrbDfnyWMv5WuolebV4+qWQuWz+uHyZ3YBFi93UfHMpBFaryv6Jb1sHwHy4292GXNEYDP8IWgevj0+Tc2CvS4KnFqSCvYbr+ij1THEshrYEaS+Q1+c+sQp1uIRJ2YpOY/1QIKv4TNfys0SR+pzJIGqwC8w0yvslaSWKH6aO1Z+voTy/M/FgYylyyz4hL5oHskYXFjOXRs+qD99z/DQ5+p0n4vJTuFF/OuC8hyMeUsIRSsfPs0lv8j+GRxTjC0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(10070799003)(376014)(7416014)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZG5DeGlkdXN5dy96bmFGSUZuL21qUzZXL3ZZSGVEbW9KTTBVYlBUSmkwOEZC?=
 =?utf-8?B?VGhDZEwwWnZnOFlQYVdNem5GQ3Y0MEJuL0NNaGFDS0tPUTRIRTJ6Vml5NmZt?=
 =?utf-8?B?WUpIeXdYZHNLeXFrd2hhbktudHVhMldFY1kxT1pLVGNRUTNuZlpkNnR2UUcx?=
 =?utf-8?B?T1I1M0NLb0d6YWlOcXVUYmordTBXWE9PUlordmVoVTY1M0FTYzVOZlVTZ2NY?=
 =?utf-8?B?TXVDSE1WcXNuSXJhYk1oYTFmdk5taHE2UlR2ci9hN094YmJPSllrRU52R0ln?=
 =?utf-8?B?THVmWkdsVVA1U0wzejUyS1ZJeUgxaHZmVmNJdVU5V2NnKysxeW9aSHhDNFRJ?=
 =?utf-8?B?M1ptdm5lTCs4cVZTNllzV1hkQ3ZiZzJlQ3FJUG90OUtXOWFCbVZVV3c5SUd3?=
 =?utf-8?B?MnNGY2doditrVnFzSGNDbldVdWVYTndSazlVV3pxUjE3VUhPeGlLQ3kwZjMw?=
 =?utf-8?B?OUJ5L2s5dTV0ZElsUWwzZ29uQkV2SFUrejlTdjd1d2w2SS9lYk95RnZBUnNu?=
 =?utf-8?B?T1JGRjB3L1NTdVBvZ3BWbzh5QmpWcnE3Qk1HbXUzOUlxcDRma2tIT0d3Mktx?=
 =?utf-8?B?cWM3U00wZ2luYy9rUUw3L053dWhFa05SSFA2N0EramlFV1VJemMzY3NQR3hD?=
 =?utf-8?B?eGtyZ1hOc0lBcDM4dTkwWTNlaUwvNU9yWnVZcGtVd2NTVzlqcTFyZzVaSm1w?=
 =?utf-8?B?S3QxNi8vcE5JM3BqY01Sb2dvM0tjd1ViRjR0QlJnYnVvS1ZoMHRCMFlrZ202?=
 =?utf-8?B?dVVjU2RVQVVlcFBQYm8rblRkK3JuMHJoWHZVYUV3NUE0bXV6QlNPc0Vud2pm?=
 =?utf-8?B?RlpXc2hTS2FpT0JTRWEwaU9DUlNyb3dGdmlnNEdEd3Btd3Jqc3BjclhZNlZF?=
 =?utf-8?B?MnpTVVArcytsTTdLNXZuaFJtVVRWL2lrMFhTaXhDS3M4OXlYbzFUNVRKRnlv?=
 =?utf-8?B?S3NHZVdEcWZhSnpHZm9acUdFc2xiSGdnZWVTRmVZRGQrWmszSndTR2ozM0pV?=
 =?utf-8?B?RUtaT3czZGdBRVJTSHVLNkZib3JnN0Zicnowa3dXSWZkMVZnMTBEd3lzMWZF?=
 =?utf-8?B?bm1mT2gzay80a2tuRDJKWVB4VG0zWFRlY0ZIUXNGd1BQOVQ2YVBPNEZCbWl2?=
 =?utf-8?B?eDgxb3g4QUx4Zzh3RDhtdnRHc29yTEZ6OGpncnMzL2JrU0hkK0wwRVRDZDBm?=
 =?utf-8?B?K2dUWFdXV3pKdWY0VFJqbHBEd2xkY2laNjFNVXhQTnpWV3hVR3cvcnEzbEV4?=
 =?utf-8?B?L21FdUhEaXE1U2M1ZGdXWFRIK0s2V0N6ZzZBOGd1YVgzaWxmbXJmOU9wWjRh?=
 =?utf-8?B?OXhNWDZUTDdaenNGbVduOUk3T2dkSVpjZG1menpLUDF3UE12ejZIVG0wMjJO?=
 =?utf-8?B?ellXaWNuWjFzQnpsVlYzbXpsQW9XSHY5emRrZ1hVazgyU3VnSDBLNS9nbExz?=
 =?utf-8?B?Zy9hd2hSSnpyQmNHMU0rbWtxRlVkcnZRQzJCRURSRlVydHJyR2lvOXY0SHVG?=
 =?utf-8?B?Vm92a2kvTmxVYTJBVjlhWkljSWhMeDBLMHVtV2hRT245eHFCNHo4dHVKQ2RJ?=
 =?utf-8?B?bGRaNHhFYUdvM2ZidG5mMS9uSDh2MHJPK2RWWE5GajhnTnJPWmVZK1FjMGtR?=
 =?utf-8?B?U25aSWJteEE4Y1hlWWFhLyswZjlqK3ZXMk5rTkhQTnFNQ3Njb0FGSUNkMVVB?=
 =?utf-8?B?dkxmME9xdGNMWTN3eENkc0ZKMWlHUG5za1lSOFNXT0l0NEJINHJiUjVxWVJy?=
 =?utf-8?B?NHRiNVR1dnFkeVZ4S0hFY1dtQ3l1T0Z5azVENzJLQmo4anpXNnlhZ0NNN0Nh?=
 =?utf-8?B?RGNkR3FETjNCbGk5NTAxOXNiUlNRc2oreWt3SXF5eW5MQ1c0QklvMjVMWEV0?=
 =?utf-8?B?Nnp0UEVtdjlZSUhuVy9obGN6UkxGaHZ0SFRYOGRPZFJNZG14bTM5cHBlVXAx?=
 =?utf-8?B?cXovNWF2Uk9iS0dxYWpObmdpRUJhZFAyS1d2bGw5Um5NL3QrWG4xYXJDaEFy?=
 =?utf-8?B?ZngvR2NkR3d0a3ZYcnF4SE5aSkx4ZTFHcWw1bmxRSjhQVHlzODVkQ0JtQUlt?=
 =?utf-8?B?elB3cElObFZHR2xXdVdqb1REVWRVNWhCS2MwbjBxZHlDcmJyeXFkcmw3RUFr?=
 =?utf-8?B?N0tnR1RCamx5dzhuell6QWsxWVkzT3QzZWhURUZMeEt5WVVaOTFhR2ZYNG1O?=
 =?utf-8?B?TlRzaXUvcERUa21jYm1VZHZBbUo3d0ZWRWFQQjZhajQxYkhlVm16ZkRsMXpk?=
 =?utf-8?B?NnJkZkNtQVJ2dlFBckEyZzNKcHdkclBjS1ZzM01BdDB4SVdPQmtsY1p4Y3RE?=
 =?utf-8?B?bmkyQkNUckVzdDhUSFlFMG03Q0lzc1FiS1l5SnRFQmNWSmFDTmo1dW5TUWgy?=
 =?utf-8?Q?cz1RVkyqgJn4m5TBUDYJu1ZUUxoPUUPRE4ErX1eF7XqPk?=
x-ms-exchange-antispam-messagedata-1: G3m0DEiqubzjRe/1KIJGx6ds+QaeR8fwNEU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C22BB9FA3E9214183890D843C2C48A8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZNWtSPJONYlMQdDdBvjxiP87jrNOddi6kxU0kZjMtBMCymVfcfQtKxHhwKmbydH0q9gqQLwaeG1zTmr7KSqqq5DlWIoFmiFgs1wggEZEfE0D3xIiYag1uRwYaGUw8hP8stgIx4C1WB0Zd6Vh4UgdIhtP5bksY9oatob439pmFh+Y8qaVqUJGDSFh52lIDzw7ay/uozSiHAoh7AEd8ydoC/qUHPA9JplH6DuTw/KjXtAAXtFeyIUek4hvKecdseZRkyk5r2CYEfWKoWBscP/DDKpwrzNB62PWXnw5ffcoNtIWXOOkt+YeXwqSPDuMguZ43VmvuIFdI6bZkfgKDu6Neg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TUmIrdkM96mpGeZUftC9SXgHaaX/rJUctiEPL7vvvLgHx+qLzTQe5IXZRBAJqWs7OcgceqP+Mt5SwG0Ln1bsO3F4B4p4H2TseyH1L0uvsL9NS9AyltS37hARlW67u6WtU6JwbK69NFyYWu9axxEOIdeQqLf9dw1W+CsbQEYqRlCcGu4EIo1/kEf+xkmyiROeEviuCRKNy85XAH44h/BH5oOUZ7fZBmQXcMBW0uX40oWjk7lTId2300lC878+9tfd5xvkHQsMwT5+R0MMkjQP92uZlKHUFO2TR8rBlcyoxg6vh+o1Sy2IEf8BDh0ImVxO/boMVxx7sTGdDiCYRE1Jp8ILl+1FEVuoJuMh0jkdm+ArmXuc6VhcjBVUxpcRVQcewARi0iYkHIi/Co+Z6XHUhIQKY1eCOocmQQur2kLFbkTBobMYdKbuGuVlgHS/7HoDtwoV+oWflgVrUmH3YsDuwTStSN//kGN7YeQMm8UsNjtOacINDlLMIYvK5OII+IzSVC98ejG3PNMuh7KHfhoNfg5os8hBLHfx2di2cAWmYVy6mVQlXJvvmollIRXQrMGZ4TIbKs0tylPQcrC9nQYtt1CgrLusJl2CuVoG940oiYPYcH5NdJ/Gh5mli0e9qaK7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de35b8b-b8c9-4b19-021a-08df06fd28a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 01:14:08.7991 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zQq90kJOZroMsd2+l6h/SAxyJaLa5NyFvDYn2uhCLlaf54BdHXgmPWTYfeEw9teNynfk5dd+xgK3rbeZLgg2ZGBEknDR54GuiIh1rYKLHY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR04MB993975
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=696fae14a=Alistair.Francis@wdc.com;
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

T24gVGh1LCAyMDI2LTA4LTI3IGF0IDE0OjM5ICswOTMwLCBKb2VsIFN0YW5sZXkgd3JvdGU6DQo+
IEtlZXAgdGhlIHRlc3RzIGF0IHRoZSBzdGFydCBvZiBSQU0gYnV0IGJvdW5kIHRoZW0gd2l0aCBh
IE1FTU9SWQ0KPiByZWdpb24sDQo+IGFuZCB1c2UgdGhpcyB0byBkZWZpbmUgX19zdGFja190b3As
IHdoaWNoIHRoZSBtdWx0aWFyY2ggc3lzdGVtIHRlc3QNCj4gYm9vdA0KPiBjb2RlIHdpbGwgdXNl
Lg0KPiANCj4gQWRkIG1vcmUgc2VjdGlvbnMgZ2VuZXJhdGVkIGJ5IHRoZSB0ZXN0IGJpbmFyaWVz
IHNvIHRoZXkgYXJlIHBsYWNlZA0KPiBleHBsaWNpdGx5Lg0KPiANCj4gU3BsaXQgdGV4dCBhbmQg
ZGF0YSBpbnRvIHNlcGFyYXRlIHJ4L3J3IHJlZ2lvbnMsIGluc3RlYWQgb2Ygb25lIHJ3eA0KPiBy
ZWdpb24gdG8gYXZvaWQgYmludXRpbHMgd2FybmluZ3MuDQo+IA0KPiBBIC1rZXJuZWwgYm9vdCBq
dW1wcyB0byB0aGUgbG93ZXN0IGxvYWRlZCBhZGRyZXNzIHJhdGhlciB0aGFuIHRoZSBFTEYNCj4g
ZW50cnkgcG9pbnQsIHNvIF9zdGFydCBtdXN0IGJlIGZpcnN0IGluIC50ZXh0LiBVc2UgYSAudGV4
dC5fc3RhcnQNCj4gaW5wdXQNCj4gc2VjdGlvbiB0byBtYWtlIHRoYXQgZXhwbGljaXQuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1Pg0KDQpSZXZpZXdl
ZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlz
dGFpcg0KDQo+IC0tLQ0KPiDCoHRlc3RzL3RjZy9yaXNjdjY0L3NlbWlob3N0LmxkIHwgNDcgKysr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+IC0tDQo+IMKgMSBmaWxlIGNoYW5nZWQs
IDM2IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rl
c3RzL3RjZy9yaXNjdjY0L3NlbWlob3N0LmxkDQo+IGIvdGVzdHMvdGNnL3Jpc2N2NjQvc2VtaWhv
c3QubGQNCj4gaW5kZXggYTU5Y2M1NmIyODlhLi5lZmYzNzAxZTRhMTkgMTAwNjQ0DQo+IC0tLSBh
L3Rlc3RzL3RjZy9yaXNjdjY0L3NlbWlob3N0LmxkDQo+ICsrKyBiL3Rlc3RzL3RjZy9yaXNjdjY0
L3NlbWlob3N0LmxkDQo+IEBAIC0xLDIxICsxLDQ2IEBADQo+ICsvKg0KPiArICogTGlua2VyIHNj
cmlwdCBmb3IgdGhlIFJJU0MtViBzeXN0ZW0gdGVzdHMNCj4gKyAqIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyDQo+ICsgKi8NCj4gKw0KPiDCoEVOVFJZKF9zdGFydCkN
Cj4gwqANCj4gK01FTU9SWQ0KPiArew0KPiArwqDCoMKgIC8qDQo+ICvCoMKgwqDCoCAqIFZpcnQg
bWFjaGluZSwgUkFNIHN0YXJ0cyBhdCAyR0INCj4gK8KgwqDCoMKgICoNCj4gK8KgwqDCoMKgICog
U2VwYXJhdGUgc2VjdGlvbnMgZm9yIGV4ZWN1dGFibGUgYW5kIHdyaXRhYmxlIGRhdGEgdG8gYXZv
aWQNCj4gbGlua2VyDQo+ICvCoMKgwqDCoCAqIHdhcm5pbmdzLg0KPiArwqDCoMKgwqAgKi8NCj4g
K8KgwqDCoCBUWFQgKHJ4KSA6IE9SSUdJTiA9IDB4ODAwMDAwMDAsIExFTkdUSCA9IDJNDQo+ICvC
oMKgwqAgREFUIChydykgOiBPUklHSU4gPSAweDgwMDAwMDAwICsgMk0sIExFTkdUSCA9IDJNDQo+
ICt9DQo+ICsNCj4gwqBTRUNUSU9OUw0KPiDCoHsNCj4gLcKgwqDCoCAvKiB2aXJ0IG1hY2hpbmUs
IFJBTSBzdGFydHMgYXQgMmdiICovDQo+IC3CoMKgwqAgLiA9IDB4ODAwMDAwMDA7DQo+IMKgwqDC
oMKgIC50ZXh0IDogew0KPiArwqDCoMKgwqDCoMKgwqAgKigudGV4dC5fc3RhcnQpDQo+IMKgwqDC
oMKgwqDCoMKgwqAgKigudGV4dCkNCj4gLcKgwqDCoCB9DQo+ICvCoMKgwqAgfSA+IFRYVA0KPiAr
DQo+IMKgwqDCoMKgIC5yb2RhdGEgOiB7DQo+IC3CoMKgwqDCoMKgwqDCoCAqKC5yb2RhdGEpDQo+
IC3CoMKgwqAgfQ0KPiAtwqDCoMKgIC8qIGFsaWduIHIvdyBzZWN0aW9uIHRvIG5leHQgMm1iICov
DQo+IC3CoMKgwqAgLiA9IEFMSUdOKDEgPDwgMjEpOw0KPiArwqDCoMKgwqDCoMKgwqAgKigucm9k
YXRhIC5yb2RhdGEuKikNCj4gK8KgwqDCoMKgwqDCoMKgICooLmVoX2ZyYW1lKQ0KPiArwqDCoMKg
IH0gPiBUWFQNCj4gKw0KPiArwqDCoMKgIC5nb3QgOiB7DQo+ICvCoMKgwqDCoMKgwqDCoCAqKC5n
b3QgLmdvdC5wbHQpDQo+ICvCoMKgwqAgfSA+IERBVA0KPiArDQo+IMKgwqDCoMKgIC5kYXRhIDog
ew0KPiAtwqDCoMKgwqDCoMKgwqAgKiguZGF0YSkNCj4gLcKgwqDCoCB9DQo+ICvCoMKgwqDCoMKg
wqDCoCAqKC5kYXRhIC5kYXRhLiogLnNkYXRhIC5zZGF0YS4qKQ0KPiArwqDCoMKgIH0gPiBEQVQN
Cj4gKw0KPiDCoMKgwqDCoCAuYnNzIDogew0KPiAtwqDCoMKgwqDCoMKgwqAgKiguYnNzKQ0KPiAt
wqDCoMKgIH0NCj4gK8KgwqDCoMKgwqDCoMKgICooLmJzcyAuYnNzLiogLnNic3MgLnNic3MuKikN
Cj4gK8KgwqDCoCB9ID4gREFUDQo+ICsNCj4gK8KgwqDCoCAvKiBTdGFjayBncm93cyBkb3duIGZy
b20gdGhlIGVuZCBvZiB0aGUgZGF0YSByZWdpb24gKi8NCj4gK8KgwqDCoCBfX3N0YWNrX3RvcCA9
IE9SSUdJTihEQVQpICsgTEVOR1RIKERBVCk7DQo+IMKgfQ0K

